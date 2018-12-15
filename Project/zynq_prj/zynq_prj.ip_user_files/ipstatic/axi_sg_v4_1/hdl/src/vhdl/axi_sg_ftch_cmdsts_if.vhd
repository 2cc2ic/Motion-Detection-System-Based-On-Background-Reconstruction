-- *************************************************************************
--
--  (c) Copyright 2010-2011 Xilinx, Inc. All rights reserved.
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
--
-- *************************************************************************
--
-------------------------------------------------------------------------------
-- Filename:    axi_sg_ftch_cmdsts_if.vhd
-- Description: This entity is the descriptor fetch command and status inteface
--              for the Scatter Gather Engine AXI DataMover.
--
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;

library unisim;
use unisim.vcomponents.all;

library axi_sg_v4_1_2;
use axi_sg_v4_1_2.axi_sg_pkg.all;

-------------------------------------------------------------------------------
entity  axi_sg_ftch_cmdsts_if is
    generic (
        C_M_AXI_SG_ADDR_WIDTH       : integer range 32 to 64        := 32
            -- Master AXI Memory Map Address Width for Scatter Gather R/W Port

    );
    port (
        -----------------------------------------------------------------------
        -- AXI Scatter Gather Interface
        -----------------------------------------------------------------------
        m_axi_sg_aclk               : in  std_logic                         ;                   --
        m_axi_sg_aresetn            : in  std_logic                         ;                   --
                                                                                                --
        -- Fetch command write interface from fetch sm                                          --
        ftch_cmnd_wr                : in  std_logic                         ;                   --
        ftch_cmnd_data              : in  std_logic_vector                                      --
                                        ((C_M_AXI_SG_ADDR_WIDTH+CMD_BASE_WIDTH)-1 downto 0);    --
                                                                                                --
        -- User Command Interface Ports (AXI Stream)                                            --
        s_axis_ftch_cmd_tvalid      : out std_logic                         ;                   --
        s_axis_ftch_cmd_tready      : in  std_logic                         ;                   --
        s_axis_ftch_cmd_tdata       : out std_logic_vector                                      --
                                        ((C_M_AXI_SG_ADDR_WIDTH+CMD_BASE_WIDTH)-1 downto 0);    --
                                                                                                --
        -- Read response for detecting slverr, decerr early                                     --
        m_axi_sg_rresp              : in  std_logic_vector(1 downto 0)      ;                   --
        m_axi_sg_rvalid             : in  std_logic                         ;                   --
                                                                                                --
        -- User Status Interface Ports (AXI Stream)                                             --
        m_axis_ftch_sts_tvalid      : in  std_logic                         ;                   --
        m_axis_ftch_sts_tready      : out std_logic                         ;                   --
        m_axis_ftch_sts_tdata       : in  std_logic_vector(7 downto 0)      ;                   --
        m_axis_ftch_sts_tkeep       : in  std_logic_vector(0 downto 0)      ;                   --
                                                                                                --
        -- Scatter Gather Fetch Status                                                          --
        mm2s_err                    : in  std_logic                         ;                   --
        ftch_done                   : out std_logic                         ;                   --
        ftch_error                  : out std_logic                         ;                   --
        ftch_interr                 : out std_logic                         ;                   --
        ftch_slverr                 : out std_logic                         ;                   --
        ftch_decerr                 : out std_logic                         ;                   --
        ftch_error_early            : out std_logic                                             --

    );

end axi_sg_ftch_cmdsts_if;

-------------------------------------------------------------------------------
-- Architecture
-------------------------------------------------------------------------------
architecture implementation of axi_sg_ftch_cmdsts_if is
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
signal ftch_slverr_i    : std_logic := '0';
signal ftch_decerr_i    : std_logic := '0';
signal ftch_interr_i    : std_logic := '0';
signal mm2s_error       : std_logic := '0';

signal sg_rresp         : std_logic_vector(1 downto 0) := (others => '0');
signal sg_rvalid        : std_logic := '0';

-------------------------------------------------------------------------------
-- Begin architecture logic
-------------------------------------------------------------------------------
begin

ftch_slverr <= ftch_slverr_i;
ftch_decerr <= ftch_decerr_i;
ftch_interr <= ftch_interr_i;

-------------------------------------------------------------------------------
-- DataMover Command Interface
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- When command by fetch sm, drive descriptor fetch command to data mover.
-- Hold until data mover indicates ready.
-------------------------------------------------------------------------------
GEN_DATAMOVER_CMND : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0')then
                s_axis_ftch_cmd_tvalid  <= '0';
             --   s_axis_ftch_cmd_tdata   <= (others => '0');

            elsif(ftch_cmnd_wr = '1')then
                s_axis_ftch_cmd_tvalid  <= '1';
             --   s_axis_ftch_cmd_tdata   <= ftch_cmnd_data;

            elsif(s_axis_ftch_cmd_tready = '1')then
                s_axis_ftch_cmd_tvalid  <= '0';
             --   s_axis_ftch_cmd_tdata   <= (others => '0');

            end if;
        end if;
    end process GEN_DATAMOVER_CMND;

                s_axis_ftch_cmd_tdata   <= ftch_cmnd_data;

-------------------------------------------------------------------------------
-- DataMover Status Interface
-------------------------------------------------------------------------------
-- Drive ready low during reset to indicate not ready
REG_STS_READY : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0')then
                m_axis_ftch_sts_tready <= '0';
            else
                m_axis_ftch_sts_tready <= '1';
            end if;
        end if;
    end process REG_STS_READY;

-------------------------------------------------------------------------------
-- Log status bits out of data mover.
-------------------------------------------------------------------------------
DATAMOVER_STS : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0')then
                ftch_done      <= '0';
                ftch_slverr_i  <= '0';
                ftch_decerr_i  <= '0';
                ftch_interr_i  <= '0';
            -- Status valid, therefore capture status
            elsif(m_axis_ftch_sts_tvalid = '1')then
                ftch_done      <= m_axis_ftch_sts_tdata(DATAMOVER_STS_CMDDONE_BIT);
                ftch_slverr_i  <= m_axis_ftch_sts_tdata(DATAMOVER_STS_SLVERR_BIT);
                ftch_decerr_i  <= m_axis_ftch_sts_tdata(DATAMOVER_STS_DECERR_BIT);
                ftch_interr_i  <= m_axis_ftch_sts_tdata(DATAMOVER_STS_INTERR_BIT);
            -- Only assert when valid
            else
                ftch_done      <= '0';
                ftch_slverr_i  <= '0';
                ftch_decerr_i  <= '0';
                ftch_interr_i  <= '0';
            end if;
        end if;
    end process DATAMOVER_STS;


-------------------------------------------------------------------------------
-- Early SlvErr and DecErr detections
-- Early detection primarily required for non-queue mode because fetched desc
-- is immediatle fed to DMA controller.  Status from SG Datamover arrives
-- too late to stop the insuing transfer on fetch error
-------------------------------------------------------------------------------
REG_MM_RD_SIGNALS : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0')then
                sg_rresp  <= (others => '0');
                sg_rvalid <= '0';
            else
                sg_rresp  <= m_axi_sg_rresp;
                sg_rvalid <= m_axi_sg_rvalid;
            end if;
        end if;
    end process REG_MM_RD_SIGNALS;


REG_ERLY_FTCH_ERROR : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0')then
                ftch_error_early     <= '0';
            elsif(sg_rvalid = '1' and (sg_rresp = SLVERR_RESP
                                    or sg_rresp = DECERR_RESP))then
                ftch_error_early     <= '1';
            end if;
        end if;
    end process REG_ERLY_FTCH_ERROR;


-------------------------------------------------------------------------------
-- Register global error from data mover.
-------------------------------------------------------------------------------
mm2s_error <= ftch_slverr_i or ftch_decerr_i or ftch_interr_i;

-- Log errors into a global error output
FETCH_ERROR_PROCESS : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0')then
                ftch_error <= '0';
            elsif(mm2s_error = '1')then
                ftch_error <= '1';
            end if;
        end if;
    end process FETCH_ERROR_PROCESS;

end implementation;
