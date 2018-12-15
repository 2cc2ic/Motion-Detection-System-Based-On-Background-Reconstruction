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
-- Filename:    axi_dma_s2mm_cmdsts_if.vhd
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
entity  axi_dma_s2mm_cmdsts_if is
    generic (
        C_M_AXI_S2MM_ADDR_WIDTH       : integer range 32 to 64          := 32;
            -- Master AXI Memory Map Address Width for S2MM Write Port

        C_DM_STATUS_WIDTH               : integer range 8 to 32         := 8;
            -- Width of DataMover status word
            -- 8  for Determinate BTT Mode
            -- 32 for Indterminate BTT Mode

        C_INCLUDE_SG                : integer range 0 to 1          := 1;
            -- Include or Exclude the Scatter Gather Engine
            -- 0 = Exclude SG Engine - Enables Simple DMA Mode
            -- 1 = Include SG Engine - Enables Scatter Gather Mode

        C_SG_INCLUDE_STSCNTRL_STRM      : integer range 0 to 1          := 1;
            -- Include or Exclude AXI Status and AXI Control Streams
            -- 0 = Exclude Status and Control Streams
            -- 1 = Include Status and Control Streams

        C_SG_USE_STSAPP_LENGTH      : integer range 0 to 1              := 1;
            -- Enable or Disable use of Status Stream Rx Length.  Only valid
            -- if C_SG_INCLUDE_STSCNTRL_STRM = 1
            -- 0 = Don't use Rx Length
            -- 1 = Use Rx Length

        C_SG_LENGTH_WIDTH           : integer range 8 to 23             := 14;
            -- Descriptor Buffer Length, Transferred Bytes, and Status Stream
            -- Rx Length Width.  Indicates the least significant valid bits of
            -- descriptor buffer length, transferred bytes, or Rx Length value
            -- in the status word coincident with tlast.

        C_ENABLE_MULTI_CHANNEL             : integer range 0 to 1              := 0;
        C_MICRO_DMA                        : integer range 0 to 1              := 0;
        C_ENABLE_QUEUE                     : integer range 0 to 1              := 1
    );
    port (
        -----------------------------------------------------------------------
        -- AXI Scatter Gather Interface
        -----------------------------------------------------------------------
        m_axi_sg_aclk               : in  std_logic                         ;                    --
        m_axi_sg_aresetn            : in  std_logic                         ;                    --
                                                                                                 --
        -- Command write interface from mm2s sm                                                  --
        s2mm_cmnd_wr                : in  std_logic                         ;                    --
        s2mm_cmnd_data              : in  std_logic_vector                                       --
                                        ((C_M_AXI_S2MM_ADDR_WIDTH-32+2*32+CMD_BASE_WIDTH+46)-1 downto 0);   --
        s2mm_cmnd_pending           : out std_logic                         ;                    --
                                                                                                 --
        s2mm_packet_eof             : out std_logic                         ;                    --
                                                                                                 --
        s2mm_sts_received_clr       : in  std_logic                         ;                    --
        s2mm_sts_received           : out std_logic                         ;                    --
        s2mm_tailpntr_enble         : in  std_logic                         ;                    --
        s2mm_desc_cmplt             : in  std_logic                         ;                    --
                                                                                                 --
        -- User Command Interface Ports (AXI Stream)                                             --
        s_axis_s2mm_cmd_tvalid      : out std_logic                         ;                    --
        s_axis_s2mm_cmd_tready      : in  std_logic                         ;                    --
        s_axis_s2mm_cmd_tdata       : out std_logic_vector                                       --
                                        ((C_M_AXI_S2MM_ADDR_WIDTH-32+2*32+CMD_BASE_WIDTH+46)-1 downto 0);   --
                                                                                                 --
        -- User Status Interface Ports (AXI Stream)                                              --
        m_axis_s2mm_sts_tvalid      : in  std_logic                         ;                    --
        m_axis_s2mm_sts_tready      : out std_logic                         ;                    --
        m_axis_s2mm_sts_tdata       : in  std_logic_vector                                       --
                                        (C_DM_STATUS_WIDTH - 1 downto 0)    ;                    --
        m_axis_s2mm_sts_tkeep       : in  std_logic_vector((C_DM_STATUS_WIDTH/8)-1 downto 0);    --
                                                                                                 --
        -- Scatter Gather Fetch Status                                                           --
        s2mm_err                    : in  std_logic                         ;                    --
        s2mm_brcvd                  : out std_logic_vector                                       --
                                        (C_SG_LENGTH_WIDTH-1 downto 0)      ;                    --
        s2mm_done                   : out std_logic                         ;                    --
        s2mm_error                  : out std_logic                         ;                    --
        s2mm_interr                 : out std_logic                         ;                    --
        s2mm_slverr                 : out std_logic                         ;                    --
        s2mm_decerr                 : out std_logic                         ;                    --
        s2mm_tag                    : out std_logic_vector(3 downto 0)                           --
    );

end axi_dma_s2mm_cmdsts_if;

-------------------------------------------------------------------------------
-- Architecture
-------------------------------------------------------------------------------
architecture implementation of axi_dma_s2mm_cmdsts_if is
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
signal sts_tready           : std_logic := '0';
signal sts_received_i       : std_logic := '0';
signal stale_desc           : std_logic := '0';
signal log_status           : std_logic := '0';

signal s2mm_slverr_i        : std_logic := '0';
signal s2mm_decerr_i        : std_logic := '0';
signal s2mm_interr_i        : std_logic := '0';
signal s2mm_error_or        : std_logic := '0';

signal s2mm_packet_eof_i    : std_logic := '0';
signal smpl_dma_overflow    : std_logic := '0';

-------------------------------------------------------------------------------
-- Begin architecture logic
-------------------------------------------------------------------------------
begin
s2mm_slverr     <= s2mm_slverr_i;
s2mm_decerr     <= s2mm_decerr_i;
s2mm_interr     <= s2mm_interr_i or smpl_dma_overflow;


s2mm_packet_eof <= s2mm_packet_eof_i;

-- Stale descriptor if complete bit already set and in tail pointer mode.
stale_desc <= '1' when s2mm_desc_cmplt = '1' and s2mm_tailpntr_enble = '1'
         else '0';

-------------------------------------------------------------------------------
-- DataMover Command Interface
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- When command by fetch sm, drive descriptor fetch command to data mover.
-- Hold until data mover indicates ready.
-------------------------------------------------------------------------------
GEN_HOLD_NO_DATA : if C_ENABLE_QUEUE = 1 generate
begin
GEN_DATAMOVER_CMND : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0')then
                s_axis_s2mm_cmd_tvalid  <= '0';
        --        s_axis_s2mm_cmd_tdata   <= (others => '0');
                s2mm_cmnd_pending       <= '0';
            -- new command and descriptor not flagged as stale
            elsif(s2mm_cmnd_wr = '1' and stale_desc = '0')then
                s_axis_s2mm_cmd_tvalid  <= '1';
        --        s_axis_s2mm_cmd_tdata   <= s2mm_cmnd_data;
                s2mm_cmnd_pending       <= '1';
            -- clear flag on datamover acceptance of command
            elsif(s_axis_s2mm_cmd_tready = '1')then
                s_axis_s2mm_cmd_tvalid  <= '0';
        --        s_axis_s2mm_cmd_tdata   <= (others => '0');
                s2mm_cmnd_pending       <= '0';
            end if;
        end if;
    end process GEN_DATAMOVER_CMND;

                s_axis_s2mm_cmd_tdata   <= s2mm_cmnd_data;

end generate GEN_HOLD_NO_DATA;


GEN_HOLD_DATA : if C_ENABLE_QUEUE = 0 generate
begin
GEN_DATAMOVER_CMND : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0')then
                s_axis_s2mm_cmd_tvalid  <= '0';
                s_axis_s2mm_cmd_tdata   <= (others => '0');
                s2mm_cmnd_pending       <= '0';
            -- new command and descriptor not flagged as stale
            elsif(s2mm_cmnd_wr = '1' and stale_desc = '0')then
                s_axis_s2mm_cmd_tvalid  <= '1';
                s_axis_s2mm_cmd_tdata   <= s2mm_cmnd_data;
                s2mm_cmnd_pending       <= '1';
            -- clear flag on datamover acceptance of command
            elsif(s_axis_s2mm_cmd_tready = '1')then
                s_axis_s2mm_cmd_tvalid  <= '0';
                s_axis_s2mm_cmd_tdata   <= (others => '0');
                s2mm_cmnd_pending       <= '0';
            end if;
        end if;
    end process GEN_DATAMOVER_CMND;


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
            elsif(sts_tready = '1' and m_axis_s2mm_sts_tvalid = '1')then
                sts_tready <= '0';
            elsif(sts_received_i = '0') then
                sts_tready <= '1';
            end if;
        end if;
    end process REG_STS_READY;

-- Pass to DataMover
m_axis_s2mm_sts_tready <= sts_tready;

log_status <= '1' when m_axis_s2mm_sts_tvalid = '1' and sts_received_i = '0'
         else '0';


-- Status stream is included, and using the rxlength from the status stream and in Scatter Gather Mode
DETERMINATE_BTT_MODE : if (C_SG_INCLUDE_STSCNTRL_STRM = 1 and C_SG_USE_STSAPP_LENGTH = 1
                       and C_INCLUDE_SG = 1) or (C_MICRO_DMA = 1) generate
begin
    -- Bytes received not available in determinate byte mode
    s2mm_brcvd          <= (others => '0');
    -- Simple DMA overflow not used in Scatter Gather Mode
    smpl_dma_overflow   <= '0';

    -------------------------------------------------------------------------------
    -- Log status bits out of data mover.
    -------------------------------------------------------------------------------
    DATAMOVER_STS : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    s2mm_done       <= '0';
                    s2mm_slverr_i   <= '0';
                    s2mm_decerr_i   <= '0';
                    s2mm_interr_i   <= '0';
                    s2mm_tag        <= (others => '0');
                -- Status valid, therefore capture status
                elsif(m_axis_s2mm_sts_tvalid = '1' and sts_received_i = '0')then
                    s2mm_done       <= m_axis_s2mm_sts_tdata(DATAMOVER_STS_CMDDONE_BIT);
                    s2mm_slverr_i   <= m_axis_s2mm_sts_tdata(DATAMOVER_STS_SLVERR_BIT);
                    s2mm_decerr_i   <= m_axis_s2mm_sts_tdata(DATAMOVER_STS_DECERR_BIT);
                    s2mm_interr_i   <= m_axis_s2mm_sts_tdata(DATAMOVER_STS_INTERR_BIT);
                    s2mm_tag        <= m_axis_s2mm_sts_tdata(DATAMOVER_STS_TAGMSB_BIT downto DATAMOVER_STS_TAGLSB_BIT);
                -- Only assert when valid
                else
                    s2mm_done      <= '0';
                    s2mm_slverr_i  <= '0';
                    s2mm_decerr_i  <= '0';
                    s2mm_interr_i  <= '0';
                    s2mm_tag       <= (others => '0');
                end if;
            end if;
        end process DATAMOVER_STS;

    -- End Of Frame (EOF = 1) detected on status received. Used
    -- for interrupt delay timer
    REG_RX_EOF : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    s2mm_packet_eof_i <= '0';
                elsif(log_status = '1')then
                    s2mm_packet_eof_i <=  m_axis_s2mm_sts_tdata(DATAMOVER_STS_TAGEOF_BIT)
                                       or m_axis_s2mm_sts_tdata(DATAMOVER_STS_INTERR_BIT);
                else
                    s2mm_packet_eof_i <= '0';
                end if;
            end if;
        end process REG_RX_EOF;


end generate DETERMINATE_BTT_MODE;

-- No Status Stream or not using rxlength from status stream or in Simple DMA Mode
INDETERMINATE_BTT_MODE : if (C_SG_INCLUDE_STSCNTRL_STRM = 0 or C_SG_USE_STSAPP_LENGTH = 0
                         or C_INCLUDE_SG = 0) and (C_MICRO_DMA = 0) generate

-- Bytes received MSB index bit
constant BRCVD_MSB_BIT : integer := (C_DM_STATUS_WIDTH - 2) - (BUFFER_LENGTH_WIDTH - C_SG_LENGTH_WIDTH);
-- Bytes received LSB index bit
constant BRCVD_LSB_BIT : integer := (C_DM_STATUS_WIDTH - 2) - (BUFFER_LENGTH_WIDTH - 1);

begin

    -------------------------------------------------------------------------------
    -- Log status bits out of data mover.
    -------------------------------------------------------------------------------
    DATAMOVER_STS : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    s2mm_brcvd      <= (others => '0');
                    s2mm_done       <= '0';
                    s2mm_slverr_i   <= '0';
                    s2mm_decerr_i   <= '0';
                    s2mm_interr_i   <= '0';
                    s2mm_tag        <= (others => '0');
                -- Status valid, therefore capture status
                elsif(m_axis_s2mm_sts_tvalid = '1' and sts_received_i = '0')then
                    s2mm_brcvd      <= m_axis_s2mm_sts_tdata(BRCVD_MSB_BIT downto BRCVD_LSB_BIT);
                    s2mm_done       <= m_axis_s2mm_sts_tdata(DATAMOVER_STS_CMDDONE_BIT);
                    s2mm_slverr_i   <= m_axis_s2mm_sts_tdata(DATAMOVER_STS_SLVERR_BIT);
                    s2mm_decerr_i   <= m_axis_s2mm_sts_tdata(DATAMOVER_STS_DECERR_BIT);
                    s2mm_interr_i   <= m_axis_s2mm_sts_tdata(DATAMOVER_STS_INTERR_BIT);
                    s2mm_tag        <= m_axis_s2mm_sts_tdata(DATAMOVER_STS_TAGMSB_BIT downto DATAMOVER_STS_TAGLSB_BIT);
                -- Only assert when valid
                else
                    s2mm_brcvd     <= (others => '0');
                    s2mm_done      <= '0';
                    s2mm_slverr_i  <= '0';
                    s2mm_decerr_i  <= '0';
                    s2mm_interr_i  <= '0';
                    s2mm_tag       <= (others => '0');
                end if;
            end if;
        end process DATAMOVER_STS;

    -- End Of Frame (EOF = 1) detected on statis received. Used
    -- for interrupt delay timer
    REG_RX_EOF : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    s2mm_packet_eof_i <= '0';
                elsif(log_status = '1')then
                    s2mm_packet_eof_i <=  m_axis_s2mm_sts_tdata(DATAMOVER_STS_TLAST_BIT)
                                       or m_axis_s2mm_sts_tdata(DATAMOVER_STS_INTERR_BIT);
                else
                    s2mm_packet_eof_i <= '0';
                end if;
            end if;
        end process REG_RX_EOF;

    -- If in Simple DMA mode then generate overflow flag
    GEN_OVERFLOW_SMPL_DMA : if C_INCLUDE_SG = 0 generate
        REG_OVERFLOW : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0')then
                        smpl_dma_overflow <= '0';
                    -- If status received and TLAST bit is NOT set then packet is bigger than
                    -- BTT value commanded which is an invalid command
                    elsif(log_status = '1' and m_axis_s2mm_sts_tdata(DATAMOVER_STS_TLAST_BIT) = '0')then
                        smpl_dma_overflow <= '1';
                    end if;
                end if;
            end process REG_OVERFLOW;
    end generate GEN_OVERFLOW_SMPL_DMA;

    -- If in Scatter Gather Mode then do NOT generate simple dma mode overflow flag
    GEN_NO_OVERFLOW_SMPL_DMA : if C_INCLUDE_SG = 1 generate
    begin
        smpl_dma_overflow <= '0';
    end generate GEN_NO_OVERFLOW_SMPL_DMA;

end generate INDETERMINATE_BTT_MODE;





-- Flag when status is received.  Used to hold status until sg if
-- can use status.  This only has meaning when SG Engine Queues are turned
-- on
STS_RCVD_FLAG : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0' or s2mm_sts_received_clr = '1')then
                sts_received_i  <= '0';
            -- Status valid, therefore capture status
            elsif(m_axis_s2mm_sts_tvalid = '1' and sts_received_i = '0')then
                sts_received_i  <= '1';
            end if;
        end if;
    end process STS_RCVD_FLAG;

s2mm_sts_received    <= sts_received_i;

-------------------------------------------------------------------------------
-- Register global error from data mover.
-------------------------------------------------------------------------------
s2mm_error_or <= s2mm_slverr_i or s2mm_decerr_i or s2mm_interr_i or smpl_dma_overflow;

-- Log errors into a global error output
S2MM_ERROR_PROCESS : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0')then
                s2mm_error <= '0';
            -- If Datamover issues error on the transfer or if a stale descriptor is
            -- detected when in tailpointer mode then issue an error
            elsif((s2mm_error_or = '1')
               or (stale_desc = '1' and s2mm_cmnd_wr='1'))then
                s2mm_error <= '1';
            end if;
        end if;
    end process S2MM_ERROR_PROCESS;



end implementation;
