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
-- Filename:          axi_dma_s2mm_mngr.vhd
-- Description: This entity is the top level entity for the AXI DMA S2MM
--              manager.
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
entity  axi_dma_s2mm_mngr is
    generic(

        C_PRMRY_IS_ACLK_ASYNC           : integer range 0 to 1         := 0;
            -- Primary MM2S/S2MM sync/async mode
            -- 0 = synchronous mode     - all clocks are synchronous
            -- 1 = asynchronous mode    - Primary data path channels (MM2S and S2MM)
            --                            run asynchronous to AXI Lite, DMA Control,
            --                            and SG.

        C_PRMY_CMDFIFO_DEPTH            : integer range 1 to 16         := 1;
            -- Depth of DataMover command FIFO

        C_DM_STATUS_WIDTH               : integer range 8 to 32         := 8;
            -- Width of DataMover status word
            -- 8  for Determinate BTT Mode
            -- 32 for Indterminate BTT Mode

        -----------------------------------------------------------------------
        -- Scatter Gather Parameters
        -----------------------------------------------------------------------
        C_INCLUDE_SG                : integer range 0 to 1          := 1;
            -- Include or Exclude the Scatter Gather Engine
            -- 0 = Exclude SG Engine - Enables Simple DMA Mode
            -- 1 = Include SG Engine - Enables Scatter Gather Mode

        C_SG_INCLUDE_STSCNTRL_STRM      : integer range 0 to 1      := 1;
            -- Include or Exclude AXI Status and AXI Control Streams
            -- 0 = Exclude Status and Control Streams
            -- 1 = Include Status and Control Streams

        C_SG_INCLUDE_DESC_QUEUE     : integer range 0 to 1          := 0;
            -- Include or Exclude Scatter Gather Descriptor Queuing
            -- 0 = Exclude SG Descriptor Queuing
            -- 1 = Include SG Descriptor Queuing

        C_SG_USE_STSAPP_LENGTH      : integer range 0 to 1          := 1;
            -- Enable or Disable use of Status Stream Rx Length.  Only valid
            -- if C_SG_INCLUDE_STSCNTRL_STRM = 1
            -- 0 = Don't use Rx Length
            -- 1 = Use Rx Length

        C_SG_LENGTH_WIDTH               : integer range 8 to 23     := 14;
            -- Descriptor Buffer Length, Transferred Bytes, and Status Stream
            -- Rx Length Width.  Indicates the least significant valid bits of
            -- descriptor buffer length, transferred bytes, or Rx Length value
            -- in the status word coincident with tlast.


        C_M_AXI_SG_ADDR_WIDTH           : integer range 32 to 64    := 32;
            -- Master AXI Memory Map Address Width for Scatter Gather R/W Port

        C_M_AXIS_SG_TDATA_WIDTH          : integer range 32 to 32    := 32;
            -- AXI Master Stream in for descriptor fetch

        C_S_AXIS_UPDPTR_TDATA_WIDTH : integer range 32 to 32        := 32;
            -- 32 Update Status Bits

        C_S_AXIS_UPDSTS_TDATA_WIDTH : integer range 33 to 33        := 33;
            -- 1 IOC bit + 32 Update Status Bits

        C_S_AXIS_S2MM_STS_TDATA_WIDTH : integer range 32 to 32    := 32;
            -- Slave AXI Status Stream Data Width

        -----------------------------------------------------------------------
        -- Stream to Memory Map (S2MM) Parameters
        -----------------------------------------------------------------------
        C_INCLUDE_S2MM                  : integer range 0 to 1      := 1;
            -- Include or exclude S2MM primary data path
            -- 0 = Exclude S2MM primary data path
            -- 1 = Include S2MM primary data path

        C_M_AXI_S2MM_ADDR_WIDTH         : integer range 32 to 64    := 32;
            -- Master AXI Memory Map Address Width for S2MM Write Port

        C_NUM_S2MM_CHANNELS             : integer range 1 to 16     := 1;

        C_ENABLE_MULTI_CHANNEL                 : integer range 0 to 1    := 0;     
        C_MICRO_DMA                     : integer range 0 to 1 := 0;
 
        C_FAMILY                        : string            := "virtex5"
            -- Target FPGA Device Family
    );
    port (

        -- Secondary Clock and Reset
        m_axi_sg_aclk               : in  std_logic                         ;                      --
        m_axi_sg_aresetn            : in  std_logic                         ;                      --
                                                                                                   --
        -- Primary Clock and Reset                                                                 --
        axi_prmry_aclk              : in  std_logic                         ;                      --
        p_reset_n                   : in  std_logic                         ;                      --
                                                                                                   --
        soft_reset                  : in  std_logic                         ;                      --
        -- MM2S Control and Status                                                                 --
        s2mm_run_stop               : in  std_logic                         ;                      --
        s2mm_keyhole                : in  std_logic                         ;
        s2mm_halted                 : in  std_logic                         ;                      --
        s2mm_ftch_idle              : in  std_logic                         ;                      --
        s2mm_updt_idle              : in  std_logic                         ;                      --
        s2mm_tailpntr_enble         : in  std_logic                         ;                      --
        s2mm_ftch_err_early         : in  std_logic                         ;                      --
        s2mm_ftch_stale_desc        : in  std_logic                         ;                      --
        s2mm_halt                   : in  std_logic                         ;                      --
        s2mm_halt_cmplt             : in  std_logic                         ;                      --
        s2mm_packet_eof_out         : out std_logic                         ;
        s2mm_halted_clr             : out std_logic                         ;                      --
        s2mm_halted_set             : out std_logic                         ;                      --
        s2mm_idle_set               : out std_logic                         ;                      --
        s2mm_idle_clr               : out std_logic                         ;                      --
        s2mm_new_curdesc            : out std_logic_vector                                         --
                                        (C_M_AXI_SG_ADDR_WIDTH-1 downto 0)  ;                      --
        s2mm_new_curdesc_wren       : out std_logic                         ;                      --
        s2mm_stop                   : out std_logic                         ;                      --
        s2mm_desc_flush             : out std_logic                         ;                      --
        s2mm_all_idle               : out std_logic                         ;                      --
        s2mm_error                  : out std_logic                         ;                      --
        mm2s_error                  : in  std_logic                         ;                      --
        s2mm_desc_info_in              : in  std_logic_vector (13 downto 0)    ;

        -- Simple DMA Mode Signals
        s2mm_da                     : in  std_logic_vector                                         --
                                        (C_M_AXI_S2MM_ADDR_WIDTH-1 downto 0);                      --
        s2mm_length                 : in  std_logic_vector                                         --
                                        (C_SG_LENGTH_WIDTH-1 downto 0)      ;                      --
        s2mm_length_wren            : in  std_logic                         ;                      --
        s2mm_smple_done             : out std_logic                         ;                      --
        s2mm_interr_set             : out std_logic                         ;                      --
        s2mm_slverr_set             : out std_logic                         ;                      --
        s2mm_decerr_set             : out std_logic                         ;                      --
        s2mm_bytes_rcvd             : out std_logic_vector                                         --
                                        (C_SG_LENGTH_WIDTH-1 downto 0)      ;                      --
        s2mm_bytes_rcvd_wren        : out std_logic                         ;                      --
                                                                                                   --
        -- SG S2MM Descriptor Fetch AXI Stream In                                                  --
        m_axis_s2mm_ftch_tdata      : in  std_logic_vector                                         --
                                        (C_M_AXIS_SG_TDATA_WIDTH-1 downto 0);                      --
        m_axis_s2mm_ftch_tvalid     : in  std_logic                         ;                      --
        m_axis_s2mm_ftch_tready     : out std_logic                         ;                      --
        m_axis_s2mm_ftch_tlast      : in  std_logic                         ;                      --

        m_axis_s2mm_ftch_tdata_new      : in  std_logic_vector                                         --
                                        (96+31*0+(0+2)*(C_M_AXI_SG_ADDR_WIDTH-32) downto 0);                      --
        m_axis_s2mm_ftch_tdata_mcdma_new      : in  std_logic_vector                                         --
                                        (63 downto 0);                      --
        m_axis_s2mm_ftch_tdata_mcdma_nxt      : in  std_logic_vector                                         --
                                        (C_M_AXI_SG_ADDR_WIDTH-1 downto 0);                      --
        m_axis_s2mm_ftch_tvalid_new     : in  std_logic                         ;                      --
        m_axis_ftch2_desc_available     : in std_logic;
                                                                                                   --
                                                                                                   --
        -- SG S2MM Descriptor Update AXI Stream Out                                                --
        s_axis_s2mm_updtptr_tdata   : out std_logic_vector                                         --
                                        (C_M_AXI_SG_ADDR_WIDTH-1 downto 0) ;                 --
        s_axis_s2mm_updtptr_tvalid  : out std_logic                         ;                      --
        s_axis_s2mm_updtptr_tready  : in  std_logic                         ;                      --
        s_axis_s2mm_updtptr_tlast   : out std_logic                         ;                      --
                                                                                                   --
        s_axis_s2mm_updtsts_tdata   : out std_logic_vector                                         --
                                        (C_S_AXIS_UPDSTS_TDATA_WIDTH-1 downto 0) ;                 --
        s_axis_s2mm_updtsts_tvalid  : out std_logic                         ;                      --
        s_axis_s2mm_updtsts_tready  : in  std_logic                         ;                      --
        s_axis_s2mm_updtsts_tlast   : out std_logic                         ;                      --
                                                                                                   --
        -- User Command Interface Ports (AXI Stream)                                               --
        s_axis_s2mm_cmd_tvalid      : out std_logic                         ;                      --
        s_axis_s2mm_cmd_tready      : in  std_logic                         ;                      --
        s_axis_s2mm_cmd_tdata       : out std_logic_vector                                         --
                                        ((C_M_AXI_S2MM_ADDR_WIDTH-32+2*32+CMD_BASE_WIDTH+46)-1 downto 0);     --
                                                                                                   --
        -- User Status Interface Ports (AXI Stream)                                                --
        m_axis_s2mm_sts_tvalid      : in  std_logic                         ;                      --
        m_axis_s2mm_sts_tready      : out std_logic                         ;                      --
        m_axis_s2mm_sts_tdata       : in  std_logic_vector                                         --
                                        (C_DM_STATUS_WIDTH - 1 downto 0)    ;                      --
        m_axis_s2mm_sts_tkeep       : in  std_logic_vector((C_DM_STATUS_WIDTH/8-1) downto 0);      --
        s2mm_err                    : in  std_logic                         ;                      --
        updt_error                  : in  std_logic                         ;                      --
        ftch_error                  : in  std_logic                         ;                      --
                                                                                                   --
        -- Stream to Memory Map Status Stream Interface                                            --
        s_axis_s2mm_sts_tdata       : in  std_logic_vector                                         --
                                        (C_S_AXIS_S2MM_STS_TDATA_WIDTH-1 downto 0);                --
        s_axis_s2mm_sts_tkeep       : in  std_logic_vector                                         --
                                        ((C_S_AXIS_S2MM_STS_TDATA_WIDTH/8)-1 downto 0);            --
        s_axis_s2mm_sts_tvalid      : in  std_logic                         ;                      --
        s_axis_s2mm_sts_tready      : out std_logic                         ;                      --
        s_axis_s2mm_sts_tlast       : in  std_logic                                                --
    );

end axi_dma_s2mm_mngr;

-------------------------------------------------------------------------------
-- Architecture
-------------------------------------------------------------------------------
architecture implementation of axi_dma_s2mm_mngr is
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
-- Primary DataMover Command signals
signal s2mm_cmnd_wr                 : std_logic := '0';
signal s2mm_cmnd_data               : std_logic_vector
                                        ((C_M_AXI_S2MM_ADDR_WIDTH-32+2*32+CMD_BASE_WIDTH+46)-1 downto 0) := (others => '0');
signal s2mm_cmnd_pending            : std_logic := '0';
-- Primary DataMover Status signals
signal s2mm_done                    : std_logic := '0';
signal s2mm_stop_i                  : std_logic := '0';
signal s2mm_interr                  : std_logic := '0';
signal s2mm_slverr                  : std_logic := '0';
signal s2mm_decerr                  : std_logic := '0';
signal s2mm_tag                     : std_logic_vector(3 downto 0) := (others => '0');
signal s2mm_brcvd                   : std_logic_vector(C_SG_LENGTH_WIDTH-1 downto 0) := (others => '0');
signal dma_s2mm_error               : std_logic := '0';
signal soft_reset_d1                : std_logic := '0';
signal soft_reset_d2                : std_logic := '0';
signal soft_reset_re                : std_logic := '0';
signal s2mm_error_i                 : std_logic := '0';
signal sts_strm_stop                : std_logic := '0';
signal s2mm_halted_set_i            : std_logic := '0';

signal s2mm_sts_received_clr        : std_logic := '0';
signal s2mm_sts_received            : std_logic := '0';

signal s2mm_cmnd_idle               : std_logic := '0';
signal s2mm_sts_idle                : std_logic := '0';
signal s2mm_eof_set                 : std_logic := '0';
signal s2mm_packet_eof              : std_logic := '0';

-- Scatter Gather Interface signals
signal desc_fetch_req               : std_logic := '0';
signal desc_fetch_done              : std_logic := '0';
signal desc_update_req              : std_logic := '0';
signal desc_update_done             : std_logic := '0';
signal desc_available               : std_logic := '0';

signal s2mm_desc_baddress           : std_logic_vector(C_M_AXI_S2MM_ADDR_WIDTH-1 downto 0)  := (others => '0');
signal s2mm_desc_info           : std_logic_vector(31 downto 0)  := (others => '0');
signal s2mm_desc_blength            : std_logic_vector(BUFFER_LENGTH_WIDTH-1 downto 0)    := (others => '0');
signal s2mm_desc_blength_v            : std_logic_vector(BUFFER_LENGTH_WIDTH-1 downto 0)    := (others => '0');
signal s2mm_desc_blength_s            : std_logic_vector(BUFFER_LENGTH_WIDTH-1 downto 0)    := (others => '0');
signal s2mm_desc_cmplt              : std_logic := '0';
signal s2mm_desc_app0               : std_logic_vector(C_M_AXIS_SG_TDATA_WIDTH-1 downto 0)    := (others => '0');
signal s2mm_desc_app1               : std_logic_vector(C_M_AXIS_SG_TDATA_WIDTH-1 downto 0)    := (others => '0');
signal s2mm_desc_app2               : std_logic_vector(C_M_AXIS_SG_TDATA_WIDTH-1 downto 0)    := (others => '0');
signal s2mm_desc_app3               : std_logic_vector(C_M_AXIS_SG_TDATA_WIDTH-1 downto 0)    := (others => '0');
signal s2mm_desc_app4               : std_logic_vector(C_M_AXIS_SG_TDATA_WIDTH-1 downto 0)    := (others => '0');


-- S2MM Status Stream Signals
signal s2mm_rxlength_valid          : std_logic := '0';
signal s2mm_rxlength_clr            : std_logic := '0';
signal s2mm_rxlength                : std_logic_vector(C_SG_LENGTH_WIDTH - 1 downto 0) := (others => '0');
signal stsstrm_fifo_rden            : std_logic := '0';
signal stsstrm_fifo_empty           : std_logic := '0';
signal stsstrm_fifo_dout            : std_logic_vector(C_S_AXIS_S2MM_STS_TDATA_WIDTH downto 0) := (others => '0');
signal s2mm_desc_flush_i            : std_logic := '0';

signal updt_pending                 : std_logic := '0';
signal s2mm_cmnd_wr_1               : std_logic := '0';
signal s2mm_eof_micro, s2mm_sof_micro : std_logic := '0';
-------------------------------------------------------------------------------
-- Begin architecture logic
-------------------------------------------------------------------------------
begin

-------------------------------------------------------------------------------
-- Include S2MM (Received) Channel
-------------------------------------------------------------------------------
GEN_S2MM_DMA_CONTROL : if C_INCLUDE_S2MM = 1 generate
begin

    -- pass out to register module
    s2mm_halted_set <= s2mm_halted_set_i;

    -------------------------------------------------------------------------------
    -- Graceful shut down logic
    -------------------------------------------------------------------------------

    -- Error from DataMover (DMAIntErr, DMADecErr, or DMASlvErr) or SG Update error
    -- or SG Fetch error, or Stale Descriptor Error
    s2mm_error_i    <= dma_s2mm_error                -- Primary data mover reports error
                        or updt_error                -- SG Update engine reports error
                        or ftch_error                -- SG Fetch engine reports error
                        or s2mm_ftch_err_early       -- SG Fetch engine reports early error on S2MM
                        or s2mm_ftch_stale_desc;     -- SG Fetch stale descriptor error

    -- pass out to shut down mm2s
    s2mm_error <= s2mm_error_i;

    -- Clear run/stop and stop state machines due to errors or soft reset
    -- Error based on datamover error report or sg update error or sg fetch error
    -- SG update error and fetch error included because need to shut down, no way
    -- to update descriptors on sg update error and on fetch error descriptor
    -- data is corrupt therefor do not want to issue the xfer command to primary datamover

--CR#566306 status for both mm2s and s2mm datamover are masked during shutdown therefore
-- need to stop all processes regardless of the source of the error.
--    s2mm_stop_i    <= s2mm_error                -- Error
--                   or soft_reset;               -- Soft Reset issued
    s2mm_stop_i    <= s2mm_error_i              -- Error on s2mm
                   or mm2s_error                -- Error on mm2s
                   or soft_reset;               -- Soft Reset issued


    -- Register signals out
    REG_OUT : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    s2mm_stop           <= '0';
                    s2mm_desc_flush_i   <= '0';
                else
                    s2mm_stop           <= s2mm_stop_i;
                    -- Flush any fetch descriptors if error or if run stop cleared
                    s2mm_desc_flush_i   <= s2mm_stop_i or not s2mm_run_stop;
                end if;
            end if;
        end process REG_OUT;


    -- Generate DMA Controller For Scatter Gather Mode
    GEN_SCATTER_GATHER_MODE : if C_INCLUDE_SG = 1 generate
    begin
        -- Not used in Scatter Gather mode
        s2mm_smple_done <= '0';
        s2mm_interr_set <= '0';
        s2mm_slverr_set <= '0';
        s2mm_decerr_set <= '0';
        s2mm_bytes_rcvd             <= (others => '0');
        s2mm_bytes_rcvd_wren        <= '0';

        -- Flush descriptors
        s2mm_desc_flush <= s2mm_desc_flush_i;

OLD_CMD_WR : if (C_SG_USE_STSAPP_LENGTH = 1 and C_SG_INCLUDE_STSCNTRL_STRM = 1 and C_ENABLE_MULTI_CHANNEL = 0) generate
begin
     s2mm_cmnd_wr <=  s2mm_cmnd_wr_1;
end generate OLD_CMD_WR;

NEW_CMD_WR : if (C_SG_USE_STSAPP_LENGTH = 0 or C_SG_INCLUDE_STSCNTRL_STRM = 0 or C_ENABLE_MULTI_CHANNEL = 1) generate
begin
     s2mm_cmnd_wr <=  m_axis_s2mm_ftch_tvalid_new;
end generate NEW_CMD_WR;

        ---------------------------------------------------------------------------
        -- S2MM Primary DMA Controller State Machine
        ---------------------------------------------------------------------------
        I_S2MM_SM : entity  axi_dma_v7_1_8.axi_dma_s2mm_sm
            generic map(
                C_M_AXI_S2MM_ADDR_WIDTH     => C_M_AXI_S2MM_ADDR_WIDTH          ,
                C_SG_LENGTH_WIDTH           => C_SG_LENGTH_WIDTH                ,
                C_SG_INCLUDE_DESC_QUEUE     => C_SG_INCLUDE_DESC_QUEUE          ,
                C_SG_INCLUDE_STSCNTRL_STRM  => C_SG_INCLUDE_STSCNTRL_STRM       ,
                C_SG_USE_STSAPP_LENGTH      => C_SG_USE_STSAPP_LENGTH           ,
                C_ENABLE_MULTI_CHANNEL      => C_ENABLE_MULTI_CHANNEL                  ,
                C_MICRO_DMA                 => C_MICRO_DMA                      ,
                C_PRMY_CMDFIFO_DEPTH        => C_PRMY_CMDFIFO_DEPTH
            )
            port map(
                m_axi_sg_aclk               => m_axi_sg_aclk                    ,
                m_axi_sg_aresetn            => m_axi_sg_aresetn                 ,

                s2mm_stop                   => s2mm_stop_i                      ,

                -- Channel 1 Control and Status
                s2mm_run_stop               => s2mm_run_stop                    ,
                s2mm_keyhole                => s2mm_keyhole                     ,
                s2mm_ftch_idle              => s2mm_ftch_idle                   ,
                s2mm_desc_flush             => s2mm_desc_flush_i                ,
                s2mm_cmnd_idle              => s2mm_cmnd_idle                   ,
                s2mm_sts_idle               => s2mm_sts_idle                    ,
                s2mm_eof_set                => s2mm_eof_set                     ,
                s2mm_eof_micro              => s2mm_eof_micro,
                s2mm_sof_micro              => s2mm_sof_micro,

                -- S2MM Status Stream RX Length
                s2mm_rxlength_valid         => s2mm_rxlength_valid              ,
                s2mm_rxlength_clr           => s2mm_rxlength_clr                ,
                s2mm_rxlength               => s2mm_rxlength                    ,

                -- S2MM Descriptor Fetch Request (from s2mm_sm)
                desc_fetch_req              => desc_fetch_req                   ,
                desc_fetch_done             => desc_fetch_done                  ,
                desc_update_done            => desc_update_done                 ,
                updt_pending                => updt_pending                     ,
                desc_available              => desc_available                   ,

                -- DataMover Command
                s2mm_cmnd_wr                => s2mm_cmnd_wr_1                     ,
                s2mm_cmnd_data              => s2mm_cmnd_data                   ,
                s2mm_cmnd_pending           => s2mm_cmnd_pending                ,

                -- Descriptor Fields
                s2mm_desc_baddress          => s2mm_desc_baddress               ,
                s2mm_desc_info          => s2mm_desc_info               ,
                s2mm_desc_blength           => s2mm_desc_blength,
                s2mm_desc_blength_v           => s2mm_desc_blength_v,
                s2mm_desc_blength_s           => s2mm_desc_blength_s
            );

        ---------------------------------------------------------------------------
        -- S2MM Scatter Gather State Machine
        ---------------------------------------------------------------------------
        I_S2MM_SG_IF : entity  axi_dma_v7_1_8.axi_dma_s2mm_sg_if
            generic map(

                -------------------------------------------------------------------
                -- Scatter Gather Parameters
                -------------------------------------------------------------------
                C_PRMRY_IS_ACLK_ASYNC       => C_PRMRY_IS_ACLK_ASYNC            ,
                C_SG_INCLUDE_STSCNTRL_STRM  => C_SG_INCLUDE_STSCNTRL_STRM       ,
                C_SG_INCLUDE_DESC_QUEUE     => C_SG_INCLUDE_DESC_QUEUE          ,
                C_SG_USE_STSAPP_LENGTH      => C_SG_USE_STSAPP_LENGTH           ,
                C_SG_LENGTH_WIDTH           => C_SG_LENGTH_WIDTH                ,
                C_M_AXIS_SG_TDATA_WIDTH     => C_M_AXIS_SG_TDATA_WIDTH          ,
                C_S_AXIS_UPDPTR_TDATA_WIDTH => C_S_AXIS_UPDPTR_TDATA_WIDTH      ,
                C_S_AXIS_UPDSTS_TDATA_WIDTH => C_S_AXIS_UPDSTS_TDATA_WIDTH      ,
                C_M_AXI_SG_ADDR_WIDTH       => C_M_AXI_SG_ADDR_WIDTH            ,
                C_M_AXI_S2MM_ADDR_WIDTH     => C_M_AXI_S2MM_ADDR_WIDTH          ,
                C_S_AXIS_S2MM_STS_TDATA_WIDTH=> C_S_AXIS_S2MM_STS_TDATA_WIDTH   ,
                C_NUM_S2MM_CHANNELS         => C_NUM_S2MM_CHANNELS              ,
                C_ENABLE_MULTI_CHANNEL             => C_ENABLE_MULTI_CHANNEL    ,
                C_MICRO_DMA                 => C_MICRO_DMA                      ,
                C_FAMILY                    => C_FAMILY
            )
            port map(

                m_axi_sg_aclk               => m_axi_sg_aclk                    ,
                m_axi_sg_aresetn            => m_axi_sg_aresetn                 ,
                s2mm_desc_info_in              => s2mm_desc_info_in                   ,

                -- SG S2MM Descriptor Fetch AXI Stream In
                m_axis_s2mm_ftch_tdata      => m_axis_s2mm_ftch_tdata           ,
                m_axis_s2mm_ftch_tvalid     => m_axis_s2mm_ftch_tvalid          ,
                m_axis_s2mm_ftch_tready     => m_axis_s2mm_ftch_tready          ,
                m_axis_s2mm_ftch_tlast      => m_axis_s2mm_ftch_tlast           ,

                m_axis_s2mm_ftch_tdata_new      => m_axis_s2mm_ftch_tdata_new           ,
                m_axis_s2mm_ftch_tdata_mcdma_new      => m_axis_s2mm_ftch_tdata_mcdma_new           ,
                m_axis_s2mm_ftch_tdata_mcdma_nxt      => m_axis_s2mm_ftch_tdata_mcdma_nxt           ,
                m_axis_s2mm_ftch_tvalid_new     => m_axis_s2mm_ftch_tvalid_new          ,
                m_axis_ftch2_desc_available     => m_axis_ftch2_desc_available ,

                -- SG S2MM Descriptor Update AXI Stream Out
                s_axis_s2mm_updtptr_tdata   => s_axis_s2mm_updtptr_tdata        ,
                s_axis_s2mm_updtptr_tvalid  => s_axis_s2mm_updtptr_tvalid       ,
                s_axis_s2mm_updtptr_tready  => s_axis_s2mm_updtptr_tready       ,
                s_axis_s2mm_updtptr_tlast   => s_axis_s2mm_updtptr_tlast        ,

                s_axis_s2mm_updtsts_tdata   => s_axis_s2mm_updtsts_tdata        ,
                s_axis_s2mm_updtsts_tvalid  => s_axis_s2mm_updtsts_tvalid       ,
                s_axis_s2mm_updtsts_tready  => s_axis_s2mm_updtsts_tready       ,
                s_axis_s2mm_updtsts_tlast   => s_axis_s2mm_updtsts_tlast        ,

                -- S2MM Descriptor Fetch Request (from s2mm_sm)
                desc_available              => desc_available                   ,
                desc_fetch_req              => desc_fetch_req                   ,
                desc_fetch_done             => desc_fetch_done                  ,
                updt_pending                => updt_pending                     ,

                -- S2MM Status Stream Interface
                stsstrm_fifo_rden           => stsstrm_fifo_rden                ,
                stsstrm_fifo_empty          => stsstrm_fifo_empty               ,
                stsstrm_fifo_dout           => stsstrm_fifo_dout                ,

                -- Update command write interface from s2mm sm
                s2mm_cmnd_wr                => s2mm_cmnd_wr                     ,
                s2mm_cmnd_data              => s2mm_cmnd_data (
                                                 ((1+C_ENABLE_MULTI_CHANNEL)*
                                                   C_M_AXI_S2MM_ADDR_WIDTH+
                                                   CMD_BASE_WIDTH)-1 downto 0)  ,


                -- S2MM Descriptor Update Request (from s2mm_sm)
                desc_update_done            => desc_update_done                 ,

                s2mm_sts_received_clr       => s2mm_sts_received_clr            ,
                s2mm_sts_received           => s2mm_sts_received                ,
                s2mm_desc_cmplt             => s2mm_desc_cmplt                  ,
                s2mm_done                   => s2mm_done                        ,
                s2mm_interr                 => s2mm_interr                      ,
                s2mm_slverr                 => s2mm_slverr                      ,
                s2mm_decerr                 => s2mm_decerr                      ,
                s2mm_tag                    => s2mm_tag                         ,
                s2mm_brcvd                  => s2mm_brcvd                       ,
                s2mm_eof_set                => s2mm_eof_set                     ,
                s2mm_packet_eof             => s2mm_packet_eof                  ,
                s2mm_halt                   => s2mm_halt                        ,
                s2mm_eof_micro              => s2mm_eof_micro,
                s2mm_sof_micro              => s2mm_sof_micro,

                -- S2MM Descriptor Field Output
                s2mm_new_curdesc            => s2mm_new_curdesc                 ,
                s2mm_new_curdesc_wren       => s2mm_new_curdesc_wren            ,
                s2mm_desc_baddress          => s2mm_desc_baddress               ,
                s2mm_desc_blength           => s2mm_desc_blength                ,
                s2mm_desc_blength_v           => s2mm_desc_blength_v                ,
                s2mm_desc_blength_s           => s2mm_desc_blength_s                ,
                s2mm_desc_info              => s2mm_desc_info                   ,
                s2mm_desc_app0              => s2mm_desc_app0                   ,
                s2mm_desc_app1              => s2mm_desc_app1                   ,
                s2mm_desc_app2              => s2mm_desc_app2                   ,
                s2mm_desc_app3              => s2mm_desc_app3                   ,
                s2mm_desc_app4              => s2mm_desc_app4
            );
    end generate GEN_SCATTER_GATHER_MODE;

      s2mm_packet_eof_out <= s2mm_packet_eof;

    -- Generate DMA Controller for Simple DMA Mode
    GEN_SIMPLE_DMA_MODE : if C_INCLUDE_SG = 0 generate
    begin


        -- Scatter Gather signals not used in Simple DMA Mode
        s2mm_desc_flush <= '0';
        m_axis_s2mm_ftch_tready     <= '0';
        s_axis_s2mm_updtptr_tdata   <= (others => '0');
        s_axis_s2mm_updtptr_tvalid  <= '0';
        s_axis_s2mm_updtptr_tlast   <= '0';
        s_axis_s2mm_updtsts_tdata   <= (others => '0');
        s_axis_s2mm_updtsts_tvalid  <= '0';
        s_axis_s2mm_updtsts_tlast   <= '0';
        desc_fetch_req              <= '0';
        desc_available              <= '0';
        desc_fetch_done             <= '0';
        desc_update_done            <= '0';
        s2mm_rxlength_clr           <= '0';
        stsstrm_fifo_rden           <= '0';
        s2mm_new_curdesc            <= (others => '0');
        s2mm_new_curdesc_wren       <= '0';
        s2mm_desc_baddress          <= (others => '0');
        s2mm_desc_info          <= (others => '0');
        s2mm_desc_blength           <= (others => '0');
        s2mm_desc_blength_v           <= (others => '0');
        s2mm_desc_blength_s           <= (others => '0');
        s2mm_desc_cmplt             <= '0';
        s2mm_desc_app0              <= (others => '0');
        s2mm_desc_app1              <= (others => '0');
        s2mm_desc_app2              <= (others => '0');
        s2mm_desc_app3              <= (others => '0');
        s2mm_desc_app4              <= (others => '0');

        -- Simple DMA State Machine
        I_S2MM_SMPL_SM : entity axi_dma_v7_1_8.axi_dma_smple_sm
            generic map(
                C_M_AXI_ADDR_WIDTH          => C_M_AXI_S2MM_ADDR_WIDTH  ,
                C_MICRO_DMA                 => C_MICRO_DMA ,
                C_SG_LENGTH_WIDTH           => C_SG_LENGTH_WIDTH
            )
            port map(
                m_axi_sg_aclk               => m_axi_sg_aclk            ,
                m_axi_sg_aresetn            => m_axi_sg_aresetn         ,

                -- Channel 1 Control and Status
                run_stop                    => s2mm_run_stop            ,
                keyhole                     => s2mm_keyhole              ,
                stop                        => s2mm_stop_i              ,
                cmnd_idle                   => s2mm_cmnd_idle           ,
                sts_idle                    => s2mm_sts_idle            ,

                -- DataMover Status
                sts_received                => s2mm_sts_received        ,
                sts_received_clr            => s2mm_sts_received_clr    ,

                -- DataMover Command
                cmnd_wr                     => s2mm_cmnd_wr             ,
                cmnd_data                   => s2mm_cmnd_data           ,
                cmnd_pending                => s2mm_cmnd_pending        ,

                -- Trasnfer Qualifiers
                xfer_length_wren            => s2mm_length_wren         ,
                xfer_address                => s2mm_da                  ,
                xfer_length                 => s2mm_length
            );

        -- Pass Done/Error Status out to DMASR
        s2mm_interr_set                 <= s2mm_interr;
        s2mm_slverr_set                 <= s2mm_slverr;
        s2mm_decerr_set                 <= s2mm_decerr;
        s2mm_bytes_rcvd                 <= s2mm_brcvd;
        s2mm_bytes_rcvd_wren            <= s2mm_done;

        -- S2MM Simple DMA Transfer Done - used to assert IOC bit in DMASR.
                         -- Receive clear when not shutting down
        s2mm_smple_done    <= s2mm_sts_received_clr when s2mm_stop_i = '0'
                         -- Else halt set prior to halted being set
                         else s2mm_halted_set_i when s2mm_halted = '0'
                         else '0';

    end generate GEN_SIMPLE_DMA_MODE;

    -------------------------------------------------------------------------------
    -- S2MM DataMover Command / Status Interface
    -------------------------------------------------------------------------------
    I_S2MM_CMDSTS : entity  axi_dma_v7_1_8.axi_dma_s2mm_cmdsts_if
        generic map(
            C_M_AXI_S2MM_ADDR_WIDTH     => C_M_AXI_S2MM_ADDR_WIDTH          ,
            C_DM_STATUS_WIDTH           => C_DM_STATUS_WIDTH                ,
            C_SG_INCLUDE_STSCNTRL_STRM  => C_SG_INCLUDE_STSCNTRL_STRM       ,
            C_SG_USE_STSAPP_LENGTH      => C_SG_USE_STSAPP_LENGTH           ,
            C_SG_LENGTH_WIDTH           => C_SG_LENGTH_WIDTH                ,
            C_INCLUDE_SG                => C_INCLUDE_SG                     ,
            C_ENABLE_MULTI_CHANNEL             => C_ENABLE_MULTI_CHANNEL   ,
                C_MICRO_DMA                 => C_MICRO_DMA                      ,
            C_ENABLE_QUEUE                  => C_SG_INCLUDE_DESC_QUEUE 
        )
        port map(
            m_axi_sg_aclk               => m_axi_sg_aclk                    ,
            m_axi_sg_aresetn            => m_axi_sg_aresetn                 ,

            -- Update command write interface from s2mm sm
            s2mm_cmnd_wr                => s2mm_cmnd_wr                     ,
            s2mm_cmnd_data              => s2mm_cmnd_data                   ,
            s2mm_cmnd_pending           => s2mm_cmnd_pending                ,
            s2mm_packet_eof             => s2mm_packet_eof                  , -- EOF Detected
            s2mm_sts_received_clr       => s2mm_sts_received_clr            ,
            s2mm_sts_received           => s2mm_sts_received                ,
            s2mm_tailpntr_enble         => s2mm_tailpntr_enble              ,
            s2mm_desc_cmplt             => s2mm_desc_cmplt                  ,

            -- User Command Interface Ports (AXI Stream)
            s_axis_s2mm_cmd_tvalid      => s_axis_s2mm_cmd_tvalid           ,
            s_axis_s2mm_cmd_tready      => s_axis_s2mm_cmd_tready           ,
            s_axis_s2mm_cmd_tdata       => s_axis_s2mm_cmd_tdata            ,

            -- User Status Interface Ports (AXI Stream)
            m_axis_s2mm_sts_tvalid      => m_axis_s2mm_sts_tvalid           ,
            m_axis_s2mm_sts_tready      => m_axis_s2mm_sts_tready           ,
            m_axis_s2mm_sts_tdata       => m_axis_s2mm_sts_tdata            ,
            m_axis_s2mm_sts_tkeep       => m_axis_s2mm_sts_tkeep            ,

            -- S2MM Primary DataMover Status
            s2mm_brcvd                  => s2mm_brcvd                       ,
            s2mm_err                    => s2mm_err                         ,
            s2mm_done                   => s2mm_done                        ,
            s2mm_error                  => dma_s2mm_error                   ,
            s2mm_interr                 => s2mm_interr                      ,
            s2mm_slverr                 => s2mm_slverr                      ,
            s2mm_decerr                 => s2mm_decerr                      ,
            s2mm_tag                    => s2mm_tag
        );


    ---------------------------------------------------------------------------
    -- Halt / Idle Status Manager
    ---------------------------------------------------------------------------
    I_S2MM_STS_MNGR : entity  axi_dma_v7_1_8.axi_dma_s2mm_sts_mngr
        generic map(
            C_PRMRY_IS_ACLK_ASYNC       => C_PRMRY_IS_ACLK_ASYNC
        )
        port map(
            m_axi_sg_aclk               => m_axi_sg_aclk                    ,
            m_axi_sg_aresetn            => m_axi_sg_aresetn                 ,

            -- dma control and sg engine status signals
            s2mm_run_stop               => s2mm_run_stop                    ,
            s2mm_ftch_idle              => s2mm_ftch_idle                   ,
            s2mm_updt_idle              => s2mm_updt_idle                   ,
            s2mm_cmnd_idle              => s2mm_cmnd_idle                   ,
            s2mm_sts_idle               => s2mm_sts_idle                    ,

            -- stop and halt control/status
            s2mm_stop                   => s2mm_stop_i                      ,
            s2mm_halt_cmplt             => s2mm_halt_cmplt                  ,

            -- system state and control
            s2mm_all_idle               => s2mm_all_idle                    ,
            s2mm_halted_clr             => s2mm_halted_clr                  ,
            s2mm_halted_set             => s2mm_halted_set_i                ,
            s2mm_idle_set               => s2mm_idle_set                    ,
            s2mm_idle_clr               => s2mm_idle_clr
        );


    -- S2MM Status Stream Included
    GEN_STS_STREAM : if C_SG_INCLUDE_STSCNTRL_STRM = 1 and C_INCLUDE_SG = 1 generate
    begin
        -- Register soft reset to create rising edge pulse to use for shut down.
        -- soft_reset from DMACR does not clear until after all reset processes
        -- are done.  This causes stop to assert too long causing issue with
        -- status stream skid buffer.
        REG_SFT_RST : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0')then
                        soft_reset_d1   <= '0';
                        soft_reset_d2   <= '0';
                    else
                        soft_reset_d1   <= soft_reset;
                        soft_reset_d2   <= soft_reset_d1;
                    end if;
                end if;
            end process REG_SFT_RST;

        -- Rising edge soft reset pulse
        soft_reset_re <= soft_reset_d1 and not soft_reset_d2;

        -- Status Stream module stop requires rising edge of soft reset to
        -- shut down due to DMACR.SoftReset does not deassert on internal hard reset
        -- It clears after therefore do not want to issue another stop to sts strm
        -- skid buffer.
        sts_strm_stop <= s2mm_error_i               -- Error
                      or soft_reset_re;             -- Soft Reset issued

        I_S2MM_STS_STREAM : entity axi_dma_v7_1_8.axi_dma_s2mm_sts_strm
            generic map(

                C_PRMRY_IS_ACLK_ASYNC       => C_PRMRY_IS_ACLK_ASYNC            ,
                C_S_AXIS_S2MM_STS_TDATA_WIDTH=> C_S_AXIS_S2MM_STS_TDATA_WIDTH   ,
                C_SG_USE_STSAPP_LENGTH      => C_SG_USE_STSAPP_LENGTH           ,
                C_SG_LENGTH_WIDTH           => C_SG_LENGTH_WIDTH                ,
                C_FAMILY                    => C_FAMILY
            )
            port map(

                m_axi_sg_aclk               => m_axi_sg_aclk                    ,
                m_axi_sg_aresetn            => m_axi_sg_aresetn                 ,

                axi_prmry_aclk              => axi_prmry_aclk                   ,
                p_reset_n                   => p_reset_n                        ,

                s2mm_stop                   => sts_strm_stop                    ,

                s2mm_rxlength_valid         => s2mm_rxlength_valid              ,
                s2mm_rxlength_clr           => s2mm_rxlength_clr                ,
                s2mm_rxlength               => s2mm_rxlength                    ,
                stsstrm_fifo_rden           => stsstrm_fifo_rden                ,
                stsstrm_fifo_empty          => stsstrm_fifo_empty               ,
                stsstrm_fifo_dout           => stsstrm_fifo_dout                ,

                -- Stream to Memory Map Status Stream Interface                 ,
                s_axis_s2mm_sts_tdata       => s_axis_s2mm_sts_tdata            ,
                s_axis_s2mm_sts_tkeep       => s_axis_s2mm_sts_tkeep            ,
                s_axis_s2mm_sts_tvalid      => s_axis_s2mm_sts_tvalid           ,
                s_axis_s2mm_sts_tready      => s_axis_s2mm_sts_tready           ,
                s_axis_s2mm_sts_tlast       => s_axis_s2mm_sts_tlast
            );
    end generate GEN_STS_STREAM;

    -- S2MM Status Stream Not Included
    GEN_NO_STS_STREAM : if C_SG_INCLUDE_STSCNTRL_STRM = 0 or C_INCLUDE_SG = 0 generate
    begin
        s2mm_rxlength_valid     <= '0';
        s2mm_rxlength           <= (others => '0');
        stsstrm_fifo_empty      <= '1';
        stsstrm_fifo_dout       <= (others => '0');
        s_axis_s2mm_sts_tready  <= '0';
    end generate GEN_NO_STS_STREAM;


end generate GEN_S2MM_DMA_CONTROL;



-------------------------------------------------------------------------------
-- Do Not Include S2MM Channel
-------------------------------------------------------------------------------
GEN_NO_S2MM_DMA_CONTROL : if C_INCLUDE_S2MM = 0 generate
begin
        m_axis_s2mm_ftch_tready     <= '0';
        s_axis_s2mm_updtptr_tdata   <= (others =>'0');
        s_axis_s2mm_updtptr_tvalid  <= '0';
        s_axis_s2mm_updtptr_tlast   <= '0';
        s_axis_s2mm_updtsts_tdata   <= (others =>'0');
        s_axis_s2mm_updtsts_tvalid  <= '0';
        s_axis_s2mm_updtsts_tlast   <= '0';
        s2mm_new_curdesc            <= (others =>'0');
        s2mm_new_curdesc_wren       <= '0';
        s_axis_s2mm_cmd_tvalid      <= '0';
        s_axis_s2mm_cmd_tdata       <= (others =>'0');
        m_axis_s2mm_sts_tready      <= '0';
        s2mm_halted_clr             <= '0';
        s2mm_halted_set             <= '0';
        s2mm_idle_set               <= '0';
        s2mm_idle_clr               <= '0';
        s_axis_s2mm_sts_tready      <= '0';
        s2mm_stop                   <= '0';
        s2mm_desc_flush             <= '0';
        s2mm_all_idle               <= '1';
        s2mm_error                  <= '0'; -- CR#570587
        s2mm_packet_eof_out         <= '0';
        s2mm_smple_done             <= '0';
        s2mm_interr_set             <= '0';
        s2mm_slverr_set             <= '0';
        s2mm_decerr_set             <= '0';
        s2mm_bytes_rcvd             <= (others => '0');
        s2mm_bytes_rcvd_wren        <= '0';

        

end generate GEN_NO_S2MM_DMA_CONTROL;

end implementation;
