--  (c) Copyright 2012 Xilinx, Inc. All rights reserved.
--
--  This file contains confidential and proprietary information
--  of Xilinx, Inc. and is protected under U.S. and
--  international copyright and other intellectual property
--  laws.
--
--  DISCLAIMER
--  This disclaimer is not a license and does not grant any
--  rights to the materials distributed herewith. Except as
--  otherwise provided in a valid license issued to you by
--  Xilinx, and to the maximum extent permitted by applicable
--  law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
--  WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
--  AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
--  BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
--  INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
--  (2) Xilinx shall not be liable (whether in contract or tort,
--  including negligence, or under any other theory of
--  liability) for any loss or damage of any kind or nature
--  related to, arising under or in connection with these
--  materials, including for any direct, or any indirect,
--  special, incidental, or consequential loss or damage
--  (including loss of data, profits, goodwill, or any type of
--  loss or damage suffered as a result of any action brought
--  by a third party) even if such damage or loss was
--  reasonably foreseeable or Xilinx had been advised of the
--  possibility of the same.
--
--  CRITICAL APPLICATIONS
--  Xilinx products are not designed or intended to be fail-
--  safe, or for use in any application requiring fail-safe
--  performance, such as life-support or safety devices or
--  systems, Class III medical devices, nuclear facilities,
--  applications related to the deployment of airbags, or any
--  other applications that could lead to death, personal
--  injury, or severe property or environmental damage
--  (individually and collectively, "Critical
--  Applications"). Customer assumes the sole risk and
--  liability of any use of Xilinx products in Critical
--  Applications, subject only to applicable laws and
--  regulations governing limitations on product liability.
--
--  THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
--  PART OF THIS FILE AT ALL TIMES. 
------------------------------------------------------------
-------------------------------------------------------------------------------
-- Filename:    axi_dma_mm2s_cmdsts_if.vhd
-- Description: This entity is the descriptor fetch command and status inteface
--              for the Scatter Gather Engine AXI DataMover.
--
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;

library unisim;
use unisim.vcomponents.all;

library axi_dma_v7_1_8;
use axi_dma_v7_1_8.axi_dma_pkg.all;

-------------------------------------------------------------------------------
entity  axi_dma_mm2s_cmdsts_if is
    generic (
        C_M_AXI_MM2S_ADDR_WIDTH       : integer range 32 to 64        := 32;
        C_ENABLE_QUEUE                : integer range 0 to 1          := 1;
        C_ENABLE_MULTI_CHANNEL               : integer range 0 to 1          := 0
            -- Master AXI Memory Map Address Width for Scatter Gather R/W Port

    );
    port (
        -----------------------------------------------------------------------
        -- AXI Scatter Gather Interface
        -----------------------------------------------------------------------
        m_axi_sg_aclk               : in  std_logic                         ;                   --
        m_axi_sg_aresetn            : in  std_logic                         ;                   --
                                                                                                --
        -- Command write interface from mm2s sm                                                 --
        mm2s_cmnd_wr                : in  std_logic                         ;                   --
        mm2s_cmnd_data              : in  std_logic_vector                                      --
                                        ((C_M_AXI_MM2S_ADDR_WIDTH-32+2*32+CMD_BASE_WIDTH+46)-1 downto 0);  --
        mm2s_cmnd_pending           : out std_logic                         ;                   --
        mm2s_sts_received_clr       : in  std_logic                         ;                   --
        mm2s_sts_received           : out std_logic                         ;                   --
        mm2s_tailpntr_enble         : in  std_logic                         ;                   --
        mm2s_desc_cmplt             : in  std_logic                         ;                   --
                                                                                                --
        -- User Command Interface Ports (AXI Stream)                                            --
        s_axis_mm2s_cmd_tvalid      : out std_logic                         ;                   --
        s_axis_mm2s_cmd_tready      : in  std_logic                         ;                   --
        s_axis_mm2s_cmd_tdata       : out std_logic_vector                                      --
                                        ((C_M_AXI_MM2S_ADDR_WIDTH-32+2*32+CMD_BASE_WIDTH+46)-1 downto 0);  --
                                                                                                --
        -- User Status Interface Ports (AXI Stream)                                             --
        m_axis_mm2s_sts_tvalid      : in  std_logic                         ;                   --
        m_axis_mm2s_sts_tready      : out std_logic                         ;                   --
        m_axis_mm2s_sts_tdata       : in  std_logic_vector(7 downto 0)      ;                   --
        m_axis_mm2s_sts_tkeep       : in  std_logic_vector(0 downto 0)      ;                   --
                                                                                                --
        -- Scatter Gather Fetch Status                                                          --
        mm2s_err                    : in  std_logic                         ;                   --
        mm2s_done                   : out std_logic                         ;                   --
        mm2s_error                  : out std_logic                         ;                   --
        mm2s_interr                 : out std_logic                         ;                   --
        mm2s_slverr                 : out std_logic                         ;                   --
        mm2s_decerr                 : out std_logic                         ;                   --
        mm2s_tag                    : out std_logic_vector(3 downto 0)                          --

    );

end axi_dma_mm2s_cmdsts_if;

-------------------------------------------------------------------------------
-- Architecture
-------------------------------------------------------------------------------
architecture implementation of axi_dma_mm2s_cmdsts_if is
  attribute DowngradeIPIdentifiedWarnings: string;
  attribute DowngradeIPIdentifiedWarnings of implementation : architecture is "yes";


-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------

-- No Functions Declared

-------------------------------------------------------------------------------
-- Constants Declarations
-------------------------------------------------------------------------------

-- No Constants Declared

-------------------------------------------------------------------------------
-- Signal / Type Declarations
-------------------------------------------------------------------------------
signal sts_tready       : std_logic := '0';
signal sts_received_i   : std_logic := '0';
signal stale_desc       : std_logic := '0';
signal log_status       : std_logic := '0';

signal mm2s_slverr_i    : std_logic := '0';
signal mm2s_decerr_i    : std_logic := '0';
signal mm2s_interr_i    : std_logic := '0';
signal mm2s_error_or    : std_logic := '0';

-------------------------------------------------------------------------------
-- Begin architecture logic
-------------------------------------------------------------------------------
begin

mm2s_slverr <= mm2s_slverr_i;
mm2s_decerr <= mm2s_decerr_i;
mm2s_interr <= mm2s_interr_i;

-- Stale descriptor if complete bit already set and in tail pointer mode.
stale_desc <= '1' when mm2s_desc_cmplt = '1' and mm2s_tailpntr_enble = '1'
         else '0';


-------------------------------------------------------------------------------
-- DataMover Command Interface
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- When command by fetch sm, drive descriptor fetch command to data mover.
-- Hold until data mover indicates ready.
-------------------------------------------------------------------------------
GEN_NO_HOLD_DATA : if C_ENABLE_QUEUE = 1 generate
begin
GEN_DATAMOVER_CMND : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0')then
                s_axis_mm2s_cmd_tvalid  <= '0';
          --      s_axis_mm2s_cmd_tdata   <= (others => '0');
                mm2s_cmnd_pending       <= '0';
            -- New command write and not flagged as stale descriptor
            elsif(mm2s_cmnd_wr = '1' and stale_desc = '0')then
                s_axis_mm2s_cmd_tvalid  <= '1';
          --      s_axis_mm2s_cmd_tdata   <= mm2s_cmnd_data;
                mm2s_cmnd_pending       <= '1';
            -- Clear flags when command excepted by datamover
            elsif(s_axis_mm2s_cmd_tready = '1')then
                s_axis_mm2s_cmd_tvalid  <= '0';
          --      s_axis_mm2s_cmd_tdata   <= (others => '0');
                mm2s_cmnd_pending       <= '0';

            end if;
        end if;
    end process GEN_DATAMOVER_CMND;

                s_axis_mm2s_cmd_tdata   <= mm2s_cmnd_data;

end generate GEN_NO_HOLD_DATA;

GEN_HOLD_DATA : if C_ENABLE_QUEUE = 0 generate
begin

GEN_DATAMOVER_CMND : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0')then
                s_axis_mm2s_cmd_tvalid  <= '0';
                s_axis_mm2s_cmd_tdata   <= (others => '0');
                mm2s_cmnd_pending       <= '0';
            -- New command write and not flagged as stale descriptor
            elsif(mm2s_cmnd_wr = '1' and stale_desc = '0')then
                s_axis_mm2s_cmd_tvalid  <= '1';
                s_axis_mm2s_cmd_tdata   <= mm2s_cmnd_data;
                mm2s_cmnd_pending       <= '1';
            -- Clear flags when command excepted by datamover
            elsif(s_axis_mm2s_cmd_tready = '1')then
                s_axis_mm2s_cmd_tvalid  <= '0';
                s_axis_mm2s_cmd_tdata   <= (others => '0');
                mm2s_cmnd_pending       <= '0';

            end if;
        end if;
    end process GEN_DATAMOVER_CMND;
             --   s_axis_mm2s_cmd_tdata   <= mm2s_cmnd_data;
end generate GEN_HOLD_DATA;
-------------------------------------------------------------------------------
-- DataMover Status Interface
-------------------------------------------------------------------------------
-- Drive ready low during reset to indicate not ready
REG_STS_READY : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0')then
                sts_tready <= '0';

            -- De-assert tready on acceptance of status to prevent
            -- over writing current status
            elsif(sts_tready = '1' and m_axis_mm2s_sts_tvalid = '1')then
                sts_tready <= '0';

            -- If not status received assert ready to datamover
            elsif(sts_received_i = '0') then
                sts_tready <= '1';
            end if;
        end if;
    end process REG_STS_READY;

-- Pass to DataMover
m_axis_mm2s_sts_tready <= sts_tready;

-------------------------------------------------------------------------------
-- Log status bits out of data mover.
-------------------------------------------------------------------------------
log_status <= '1' when m_axis_mm2s_sts_tvalid = '1' and sts_received_i = '0'
         else '0';

DATAMOVER_STS : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0')then
                mm2s_done       <= '0';
                mm2s_slverr_i   <= '0';
                mm2s_decerr_i   <= '0';
                mm2s_interr_i   <= '0';
                mm2s_tag        <= (others => '0');
            -- Status valid, therefore capture status
            elsif(log_status = '1')then
                mm2s_done       <= m_axis_mm2s_sts_tdata(DATAMOVER_STS_CMDDONE_BIT);
                mm2s_slverr_i   <= m_axis_mm2s_sts_tdata(DATAMOVER_STS_SLVERR_BIT);
                mm2s_decerr_i   <= m_axis_mm2s_sts_tdata(DATAMOVER_STS_DECERR_BIT);
                mm2s_interr_i   <= m_axis_mm2s_sts_tdata(DATAMOVER_STS_INTERR_BIT);
                mm2s_tag        <= m_axis_mm2s_sts_tdata(DATAMOVER_STS_TAGMSB_BIT downto DATAMOVER_STS_TAGLSB_BIT);
            -- Only assert when valid
            else
                mm2s_done       <= '0';
                mm2s_slverr_i   <= '0';
                mm2s_decerr_i   <= '0';
                mm2s_interr_i   <= '0';
                mm2s_tag        <= (others => '0');
            end if;
        end if;
    end process DATAMOVER_STS;

-- Flag when status is received.  Used to hold status until sg if
-- can use status.  This only has meaning when SG Engine Queues are turned
-- on
STS_RCVD_FLAG : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            -- Clear flag on reset or sg_if status clear
            if(m_axi_sg_aresetn = '0' or mm2s_sts_received_clr = '1')then
                sts_received_i  <= '0';
            -- Status valid, therefore capture status
            elsif(m_axis_mm2s_sts_tvalid = '1' and sts_received_i = '0')then
                sts_received_i  <= '1';
            end if;
        end if;
    end process STS_RCVD_FLAG;

mm2s_sts_received    <= sts_received_i;


-------------------------------------------------------------------------------
-- Register global error from data mover.
-------------------------------------------------------------------------------
mm2s_error_or <= mm2s_slverr_i or mm2s_decerr_i or mm2s_interr_i;

-- Log errors into a global error output
MM2S_ERROR_PROCESS : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0')then
                mm2s_error <= '0';
            -- If Datamover issues error on the transfer or if a stale descriptor is
            -- detected when in tailpointer mode then issue an error
            elsif((mm2s_error_or = '1')
               or (stale_desc = '1' and mm2s_cmnd_wr='1'))then
                mm2s_error <= '1';
            end if;
        end if;
    end process MM2S_ERROR_PROCESS;



end implementation;
