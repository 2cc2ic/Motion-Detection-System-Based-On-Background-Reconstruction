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
-- Filename:          axi_dma_mm2s_mngr.vhd
-- Description: This entity is the top level entity for the AXI DMA MM2S
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
entity  axi_dma_mm2s_mngr is
    generic(

        C_PRMRY_IS_ACLK_ASYNC       : integer range 0 to 1         := 0;
            -- Primary MM2S/S2MM sync/async mode
            -- 0 = synchronous mode     - all clocks are synchronous
            -- 1 = asynchronous mode    - Primary data path channels (MM2S and S2MM)
            --                            run asynchronous to AXI Lite, DMA Control,
            --                            and SG.

        C_PRMY_CMDFIFO_DEPTH        : integer range 1 to 16         := 1;
            -- Depth of DataMover command FIFO

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

        C_SG_LENGTH_WIDTH               : integer range 8 to 23     := 14;
            -- Descriptor Buffer Length, Transferred Bytes, and Status Stream
            -- Rx Length Width.  Indicates the least significant valid bits of
            -- descriptor buffer length, transferred bytes, or Rx Length value
            -- in the status word coincident with tlast.

        C_M_AXI_SG_ADDR_WIDTH           : integer range 32 to 64    := 32;
            -- Master AXI Memory Map Address Width for Scatter Gather R/W Port

        C_M_AXIS_SG_TDATA_WIDTH         : integer range 32 to 32    := 32;
            -- AXI Master Stream in for descriptor fetch

        C_S_AXIS_UPDPTR_TDATA_WIDTH : integer range 32 to 32     := 32;
            -- 32 Update Status Bits

        C_S_AXIS_UPDSTS_TDATA_WIDTH : integer range 33 to 33     := 33;
            -- 1 IOC bit + 32 Update Status Bits

        C_M_AXIS_MM2S_CNTRL_TDATA_WIDTH : integer range 32 to 32    := 32;
            -- Master AXI Control Stream Data Width

        -----------------------------------------------------------------------
        -- Memory Map to Stream (MM2S) Parameters
        -----------------------------------------------------------------------
        C_INCLUDE_MM2S                  : integer range 0 to 1      := 1;
            -- Include or exclude MM2S primary data path
            -- 0 = Exclude MM2S primary data path
            -- 1 = Include MM2S primary data path

        C_M_AXI_MM2S_ADDR_WIDTH         : integer range 32 to 64    := 32;
            -- Master AXI Memory Map Address Width for MM2S Read Port
 
        C_ENABLE_MULTI_CHANNEL                 : integer range 0 to 1 := 0;
        C_MICRO_DMA                            : integer range 0 to 1 := 0;

        C_FAMILY                        : string            := "virtex7"
            -- Target FPGA Device Family
    );
    port (

        -- Secondary Clock and Reset
        m_axi_sg_aclk               : in  std_logic                         ;                 --
        m_axi_sg_aresetn            : in  std_logic                         ;                 --
                                                                                              --
        -- Primary Clock and Reset                                                            --
        axi_prmry_aclk              : in  std_logic                         ;                 --
        p_reset_n                   : in  std_logic                         ;                 --
                                                                                              --
        soft_reset                  : in  std_logic                         ;                 --
                                                                                              --
        -- MM2S Control and Status                                                            --
        mm2s_run_stop               : in  std_logic                         ;                 --
        mm2s_keyhole                : in  std_logic                         ;
        mm2s_halted                 : in  std_logic                         ;                 --
        mm2s_ftch_idle              : in  std_logic                         ;                 --
        mm2s_updt_idle              : in  std_logic                         ;                 --
        mm2s_ftch_err_early         : in  std_logic                         ;                 --
        mm2s_ftch_stale_desc        : in  std_logic                         ;                 --
        mm2s_tailpntr_enble         : in  std_logic                         ;                 --
        mm2s_halt                   : in  std_logic                         ;                 --
        mm2s_halt_cmplt             : in  std_logic                         ;                 --
        mm2s_halted_clr             : out std_logic                         ;                 --
        mm2s_halted_set             : out std_logic                         ;                 --
        mm2s_idle_set               : out std_logic                         ;                 --
        mm2s_idle_clr               : out std_logic                         ;                 --
        mm2s_new_curdesc            : out std_logic_vector                                    --
                                            (C_M_AXI_SG_ADDR_WIDTH-1 downto 0);               --
        mm2s_new_curdesc_wren       : out std_logic                         ;                 --
        mm2s_stop                   : out std_logic                         ;                 --
        mm2s_desc_flush             : out std_logic                         ;                 --
        cntrl_strm_stop             : out std_logic                         ;
        mm2s_all_idle               : out std_logic                         ;                 --
                                                                                              --
        mm2s_error                  : out std_logic                         ;                 --
        s2mm_error                  : in  std_logic                         ;                 --

        -- Simple DMA Mode Signals
        mm2s_sa                     : in  std_logic_vector                                    --
                                        (C_M_AXI_MM2S_ADDR_WIDTH-1 downto 0);                 --
        mm2s_length_wren            : in  std_logic                         ;                 --
        mm2s_length                 : in  std_logic_vector                                    --
                                        (C_SG_LENGTH_WIDTH-1 downto 0)      ;                 --
        mm2s_smple_done             : out std_logic                         ;                 --
        mm2s_interr_set             : out std_logic                         ;                 --
        mm2s_slverr_set             : out std_logic                         ;                 --
        mm2s_decerr_set             : out std_logic                         ;                 --
        
        m_axis_mm2s_aclk            : in std_logic;
        mm2s_strm_tlast             : in std_logic;
        mm2s_strm_tready            : in std_logic;
        mm2s_axis_info              : out std_logic_vector
                                        (13 downto 0);
                                                                                              --
        -- SG MM2S Descriptor Fetch AXI Stream In                                             --
        m_axis_mm2s_ftch_tdata      : in  std_logic_vector                                    --
                                        (C_M_AXIS_SG_TDATA_WIDTH-1 downto 0);                 --
        m_axis_mm2s_ftch_tvalid     : in  std_logic                         ;                 --
        m_axis_mm2s_ftch_tready     : out std_logic                         ;                 --
        m_axis_mm2s_ftch_tlast      : in  std_logic                         ;                 --

        m_axis_mm2s_ftch_tdata_new      : in  std_logic_vector                                    --
                                        (96+31*0+(0+2)*(C_M_AXI_SG_ADDR_WIDTH-32) downto 0);                 --
        m_axis_mm2s_ftch_tdata_mcdma_new      : in  std_logic_vector                                    --
                                        (63 downto 0);                 --
        m_axis_mm2s_ftch_tvalid_new     : in  std_logic                         ;                 --
        m_axis_ftch1_desc_available  : in std_logic;
                                                                                              --
        -- SG MM2S Descriptor Update AXI Stream Out                                           --
        s_axis_mm2s_updtptr_tdata   : out std_logic_vector                                    --
                                     (C_M_AXI_SG_ADDR_WIDTH-1 downto 0);                --
        s_axis_mm2s_updtptr_tvalid  : out std_logic                         ;                 --
        s_axis_mm2s_updtptr_tready  : in  std_logic                         ;                 --
        s_axis_mm2s_updtptr_tlast   : out std_logic                         ;                 --
                                                                                              --
        s_axis_mm2s_updtsts_tdata   : out std_logic_vector                                    --
                                     (C_S_AXIS_UPDSTS_TDATA_WIDTH-1 downto 0);                --
        s_axis_mm2s_updtsts_tvalid  : out std_logic                         ;                 --
        s_axis_mm2s_updtsts_tready  : in  std_logic                         ;                 --
        s_axis_mm2s_updtsts_tlast   : out std_logic                         ;                 --
                                                                                              --
        -- User Command Interface Ports (AXI Stream)                                          --
        s_axis_mm2s_cmd_tvalid      : out std_logic                         ;                 --
        s_axis_mm2s_cmd_tready      : in  std_logic                         ;                 --
        s_axis_mm2s_cmd_tdata       : out std_logic_vector                                    --
                                        ((C_M_AXI_MM2S_ADDR_WIDTH-32+2*32+CMD_BASE_WIDTH+46)-1 downto 0);--
                                                                                              --
        -- User Status Interface Ports (AXI Stream)                                           --
        m_axis_mm2s_sts_tvalid      : in  std_logic                         ;                 --
        m_axis_mm2s_sts_tready      : out std_logic                         ;                 --
        m_axis_mm2s_sts_tdata       : in  std_logic_vector(7 downto 0)      ;                 --
        m_axis_mm2s_sts_tkeep       : in  std_logic_vector(0 downto 0)      ;                 --
        mm2s_err                    : in  std_logic                         ;                 --
                                                                                              --
        ftch_error                  : in  std_logic                         ;                 --
        updt_error                  : in  std_logic                         ;                 --
                                                                                              --
        -- Memory Map to Stream Control Stream Interface                                      --
        m_axis_mm2s_cntrl_tdata     : out std_logic_vector                                    --
                                        (C_M_AXIS_MM2S_CNTRL_TDATA_WIDTH-1 downto 0);         --
        m_axis_mm2s_cntrl_tkeep     : out std_logic_vector                                    --
                                        ((C_M_AXIS_MM2S_CNTRL_TDATA_WIDTH/8)-1 downto 0);     --
        m_axis_mm2s_cntrl_tvalid    : out std_logic                         ;                 --
        m_axis_mm2s_cntrl_tready    : in  std_logic                         ;                 --
        m_axis_mm2s_cntrl_tlast     : out std_logic                                           --

    );

end axi_dma_mm2s_mngr;

-------------------------------------------------------------------------------
-- Architecture
-------------------------------------------------------------------------------
architecture implementation of axi_dma_mm2s_mngr is
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
signal mm2s_cmnd_wr                 : std_logic := '0';
signal mm2s_cmnd_data               : std_logic_vector
                                        ((C_M_AXI_MM2S_ADDR_WIDTH-32+2*32+CMD_BASE_WIDTH+46)-1 downto 0) := (others => '0');
signal mm2s_cmnd_pending            : std_logic := '0';
-- Primary DataMover Status signals
signal mm2s_done                    : std_logic := '0';
signal mm2s_stop_i                  : std_logic := '0';
signal mm2s_interr                  : std_logic := '0';
signal mm2s_slverr                  : std_logic := '0';
signal mm2s_decerr                  : std_logic := '0';
signal mm2s_tag                     : std_logic_vector(3 downto 0) := (others => '0');
signal dma_mm2s_error               : std_logic := '0';
signal soft_reset_d1                : std_logic := '0';
signal soft_reset_d2                : std_logic := '0';
signal soft_reset_re                : std_logic := '0';
signal mm2s_error_i                 : std_logic := '0';
--signal cntrl_strm_stop              : std_logic := '0';
signal mm2s_halted_set_i            : std_logic := '0';

signal mm2s_sts_received_clr        : std_logic := '0';
signal mm2s_sts_received            : std_logic := '0';

signal mm2s_cmnd_idle               : std_logic := '0';
signal mm2s_sts_idle                : std_logic := '0';

-- Scatter Gather Interface signals
signal desc_fetch_req               : std_logic := '0';
signal desc_fetch_done              : std_logic := '0';
signal desc_fetch_done_del              : std_logic := '0';
signal desc_update_req              : std_logic := '0';
signal desc_update_done             : std_logic := '0';
signal desc_available               : std_logic := '0';
signal packet_in_progress           : std_logic := '0';

signal mm2s_desc_baddress           : std_logic_vector(C_M_AXI_MM2S_ADDR_WIDTH-1 downto 0)  := (others => '0');
signal mm2s_desc_blength            : std_logic_vector(BUFFER_LENGTH_WIDTH-1 downto 0)    := (others => '0');
signal mm2s_desc_blength_v            : std_logic_vector(BUFFER_LENGTH_WIDTH-1 downto 0)    := (others => '0');
signal mm2s_desc_blength_s            : std_logic_vector(BUFFER_LENGTH_WIDTH-1 downto 0)    := (others => '0');
signal mm2s_desc_eof                : std_logic := '0';
signal mm2s_desc_sof                : std_logic := '0';
signal mm2s_desc_cmplt              : std_logic := '0';
signal mm2s_desc_info               : std_logic_vector(C_M_AXIS_SG_TDATA_WIDTH-1 downto 0)    := (others => '0');
signal mm2s_desc_app0               : std_logic_vector(C_M_AXIS_SG_TDATA_WIDTH-1 downto 0)    := (others => '0');
signal mm2s_desc_app1               : std_logic_vector(C_M_AXIS_SG_TDATA_WIDTH-1 downto 0)    := (others => '0');
signal mm2s_desc_app2               : std_logic_vector(C_M_AXIS_SG_TDATA_WIDTH-1 downto 0)    := (others => '0');
signal mm2s_desc_app3               : std_logic_vector(C_M_AXIS_SG_TDATA_WIDTH-1 downto 0)    := (others => '0');
signal mm2s_desc_app4               : std_logic_vector(C_M_AXIS_SG_TDATA_WIDTH-1 downto 0)    := (others => '0');
signal mm2s_desc_info_int               : std_logic_vector(13 downto 0)    := (others => '0');
signal mm2s_strm_tlast_int          : std_logic;
signal rd_en_hold, rd_en_hold_int   : std_logic;

-- Control Stream Fifo write signals
signal cntrlstrm_fifo_wren          : std_logic := '0';
signal cntrlstrm_fifo_full          : std_logic := '0';
signal cntrlstrm_fifo_din           : std_logic_vector(C_M_AXIS_MM2S_CNTRL_TDATA_WIDTH downto 0) := (others => '0');

signal info_fifo_full               : std_logic;
signal info_fifo_empty              : std_logic;

signal updt_pending                 : std_logic := '0';
signal mm2s_cmnd_wr_1               : std_logic := '0'; 
signal fifo_rst : std_logic;


signal fifo_empty : std_logic;
signal fifo_empty_first  : std_logic;
signal fifo_empty_first1  : std_logic;
signal first_read_pulse : std_logic;
signal fifo_read : std_logic;

-------------------------------------------------------------------------------
-- Begin architecture logic
-------------------------------------------------------------------------------
begin


-------------------------------------------------------------------------------
-- Include MM2S State Machine and support logic
-------------------------------------------------------------------------------
GEN_MM2S_DMA_CONTROL : if C_INCLUDE_MM2S = 1 generate
begin

    -- Pass out to register module
    mm2s_halted_set <= mm2s_halted_set_i;


    -------------------------------------------------------------------------------
    -- Graceful shut down logic
    -------------------------------------------------------------------------------
    -- Error from DataMover (DMAIntErr, DMADecErr, or DMASlvErr) or SG Update error
    -- or SG Fetch error, or Stale Descriptor Error
    mm2s_error_i <= dma_mm2s_error              -- Primary data mover reports error
                    or updt_error               -- SG Update engine reports error
                    or ftch_error               -- SG Fetch engine reports error
                    or mm2s_ftch_err_early      -- SG Fetch engine reports early error on mm2s
                    or mm2s_ftch_stale_desc;    -- SG Fetch stale descriptor error

    -- pass out to shut down s2mm
    mm2s_error <= mm2s_error_i;

    -- Clear run/stop and stop state machines due to errors or soft reset
    -- Error based on datamover error report or sg update error or sg fetch error
    -- SG update error and fetch error included because need to shut down, no way
    -- to update descriptors on sg update error and on fetch error descriptor
    -- data is corrupt therefor do not want to issue the xfer command to primary datamover
--CR#566306 status for both mm2s and s2mm datamover are masked during shutdown therefore
-- need to stop all processes regardless of the source of the error.
--    mm2s_stop_i    <= mm2s_error                -- Error
--                   or soft_reset;               -- Soft Reset issued
    mm2s_stop_i    <= mm2s_error_i              -- Error on MM2S
                   or s2mm_error                -- Error on S2MM
                   or soft_reset;               -- Soft Reset issued

    -- Reg stop out
    REG_STOP_OUT : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    mm2s_stop <= '0';
                else
                    mm2s_stop      <= mm2s_stop_i;
                end if;
            end if;
        end process REG_STOP_OUT;

    -- Generate DMA Controller For Scatter Gather Mode
    GEN_SCATTER_GATHER_MODE : if C_INCLUDE_SG = 1 generate
    begin
        -- Not Used in SG Mode (Errors are imbedded in updated descriptor and
        -- generate error after descriptor update is complete)
        mm2s_interr_set  <=  '0';
        mm2s_slverr_set  <=  '0';
        mm2s_decerr_set  <=  '0';
        mm2s_smple_done  <=  '0';

mm2s_cmnd_wr_1 <= m_axis_mm2s_ftch_tvalid_new;

        ---------------------------------------------------------------------------
        -- MM2S Primary DMA Controller State Machine
        ---------------------------------------------------------------------------
        I_MM2S_SM : entity  axi_dma_v7_1_8.axi_dma_mm2s_sm
            generic map(
                C_M_AXI_MM2S_ADDR_WIDTH     => C_M_AXI_MM2S_ADDR_WIDTH          ,
                C_SG_LENGTH_WIDTH           => C_SG_LENGTH_WIDTH                ,
                C_SG_INCLUDE_DESC_QUEUE     => C_SG_INCLUDE_DESC_QUEUE          ,
                C_PRMY_CMDFIFO_DEPTH        => C_PRMY_CMDFIFO_DEPTH             ,
                C_ENABLE_MULTI_CHANNEL             => C_ENABLE_MULTI_CHANNEL
            )
            port map(
                m_axi_sg_aclk               => m_axi_sg_aclk                    ,
                m_axi_sg_aresetn            => m_axi_sg_aresetn                 ,

                -- Channel 1 Control and Status
                mm2s_run_stop               => mm2s_run_stop                    ,
                mm2s_keyhole                => mm2s_keyhole                     ,
                mm2s_ftch_idle              => mm2s_ftch_idle                   ,
                mm2s_cmnd_idle              => mm2s_cmnd_idle                   ,
                mm2s_sts_idle               => mm2s_sts_idle                    ,
                mm2s_stop                   => mm2s_stop_i                      ,
                mm2s_desc_flush             => mm2s_desc_flush                  ,

                -- MM2S Descriptor Fetch Request (from mm2s_sm)
                desc_available              => desc_available                   ,
                desc_fetch_req              => desc_fetch_req                   ,
                desc_fetch_done             => desc_fetch_done                  ,
                desc_update_done            => desc_update_done                 ,
                updt_pending                => updt_pending                     ,
                packet_in_progress          => packet_in_progress               ,

                -- DataMover Command
                mm2s_cmnd_wr                => open, --mm2s_cmnd_wr_1                     ,
                mm2s_cmnd_data              => mm2s_cmnd_data                   ,
                mm2s_cmnd_pending           => mm2s_cmnd_pending                ,

                -- Descriptor Fields
                mm2s_cache_info             => mm2s_desc_info                   ,
                mm2s_desc_baddress          => mm2s_desc_baddress               ,
                mm2s_desc_blength           => mm2s_desc_blength                ,
                mm2s_desc_blength_v           => mm2s_desc_blength_v                ,
                mm2s_desc_blength_s           => mm2s_desc_blength_s                ,
                mm2s_desc_eof               => mm2s_desc_eof                    ,
                mm2s_desc_sof               => mm2s_desc_sof
            );

        ---------------------------------------------------------------------------
        -- MM2S Scatter Gather State Machine
        ---------------------------------------------------------------------------
        I_MM2S_SG_IF : entity  axi_dma_v7_1_8.axi_dma_mm2s_sg_if
            generic map(

                -------------------------------------------------------------------
                -- Scatter Gather Parameters
                -------------------------------------------------------------------
                C_PRMRY_IS_ACLK_ASYNC       => C_PRMRY_IS_ACLK_ASYNC            ,
                C_SG_INCLUDE_DESC_QUEUE         => C_SG_INCLUDE_DESC_QUEUE      ,
                C_SG_INCLUDE_STSCNTRL_STRM      => C_SG_INCLUDE_STSCNTRL_STRM   ,
                C_M_AXIS_SG_TDATA_WIDTH         => C_M_AXIS_SG_TDATA_WIDTH      ,
                C_S_AXIS_UPDPTR_TDATA_WIDTH     => C_S_AXIS_UPDPTR_TDATA_WIDTH  ,
                C_S_AXIS_UPDSTS_TDATA_WIDTH     => C_S_AXIS_UPDSTS_TDATA_WIDTH  ,
                C_M_AXI_SG_ADDR_WIDTH           => C_M_AXI_SG_ADDR_WIDTH        ,
                C_M_AXI_MM2S_ADDR_WIDTH         => C_M_AXI_MM2S_ADDR_WIDTH      ,
                C_M_AXIS_MM2S_CNTRL_TDATA_WIDTH => C_M_AXIS_MM2S_CNTRL_TDATA_WIDTH,
                C_ENABLE_MULTI_CHANNEL                 => C_ENABLE_MULTI_CHANNEL              , 
                C_MICRO_DMA                 => C_MICRO_DMA,
                C_FAMILY                        => C_FAMILY
            )
            port map(

                m_axi_sg_aclk                   => m_axi_sg_aclk                ,
                m_axi_sg_aresetn                => m_axi_sg_aresetn             ,

                -- SG MM2S Descriptor Fetch AXI Stream In
                m_axis_mm2s_ftch_tdata          => m_axis_mm2s_ftch_tdata       ,
                m_axis_mm2s_ftch_tvalid         => m_axis_mm2s_ftch_tvalid      ,
                m_axis_mm2s_ftch_tready         => m_axis_mm2s_ftch_tready      ,
                m_axis_mm2s_ftch_tlast          => m_axis_mm2s_ftch_tlast       ,

                m_axis_mm2s_ftch_tdata_new          => m_axis_mm2s_ftch_tdata_new       ,
                m_axis_mm2s_ftch_tdata_mcdma_new          => m_axis_mm2s_ftch_tdata_mcdma_new       ,
                m_axis_mm2s_ftch_tvalid_new         => m_axis_mm2s_ftch_tvalid_new      ,
                m_axis_ftch1_desc_available         => m_axis_ftch1_desc_available      ,

                -- SG MM2S Descriptor Update AXI Stream Out
                s_axis_mm2s_updtptr_tdata       => s_axis_mm2s_updtptr_tdata    ,
                s_axis_mm2s_updtptr_tvalid      => s_axis_mm2s_updtptr_tvalid   ,
                s_axis_mm2s_updtptr_tready      => s_axis_mm2s_updtptr_tready   ,
                s_axis_mm2s_updtptr_tlast       => s_axis_mm2s_updtptr_tlast    ,

                s_axis_mm2s_updtsts_tdata       => s_axis_mm2s_updtsts_tdata    ,
                s_axis_mm2s_updtsts_tvalid      => s_axis_mm2s_updtsts_tvalid   ,
                s_axis_mm2s_updtsts_tready      => s_axis_mm2s_updtsts_tready   ,
                s_axis_mm2s_updtsts_tlast       => s_axis_mm2s_updtsts_tlast    ,


                -- MM2S Descriptor Fetch Request (from mm2s_sm)
                desc_available                  => desc_available               ,
                desc_fetch_req                  => desc_fetch_req               ,
                desc_fetch_done                 => desc_fetch_done              ,
                updt_pending                    => updt_pending                 ,
                packet_in_progress              => packet_in_progress           ,

                -- MM2S Descriptor Update Request
                desc_update_done                => desc_update_done             ,

                mm2s_ftch_stale_desc            => mm2s_ftch_stale_desc         ,
                mm2s_sts_received_clr           => mm2s_sts_received_clr        ,
                mm2s_sts_received               => mm2s_sts_received            ,
                mm2s_desc_cmplt                 => mm2s_desc_cmplt              ,
                mm2s_done                       => mm2s_done                    ,
                mm2s_interr                     => mm2s_interr                  ,
                mm2s_slverr                     => mm2s_slverr                  ,
                mm2s_decerr                     => mm2s_decerr                  ,
                mm2s_tag                        => mm2s_tag                     ,
                mm2s_halt                       => mm2s_halt                    , -- CR566306

                -- Control Stream Output
                cntrlstrm_fifo_wren             => cntrlstrm_fifo_wren          ,
                cntrlstrm_fifo_full             => cntrlstrm_fifo_full          ,
                cntrlstrm_fifo_din              => cntrlstrm_fifo_din           ,

                -- MM2S Descriptor Field Output
                mm2s_new_curdesc                => mm2s_new_curdesc             ,
                mm2s_new_curdesc_wren           => mm2s_new_curdesc_wren        ,
                mm2s_desc_baddress              => mm2s_desc_baddress           ,
                mm2s_desc_blength               => mm2s_desc_blength            ,
                mm2s_desc_blength_v               => mm2s_desc_blength_v            ,
                mm2s_desc_blength_s               => mm2s_desc_blength_s            ,
                mm2s_desc_info                  => mm2s_desc_info               ,
                mm2s_desc_eof                   => mm2s_desc_eof                ,
                mm2s_desc_sof                   => mm2s_desc_sof                ,
                mm2s_desc_app0                  => mm2s_desc_app0               ,
                mm2s_desc_app1                  => mm2s_desc_app1               ,
                mm2s_desc_app2                  => mm2s_desc_app2               ,
                mm2s_desc_app3                  => mm2s_desc_app3               ,
                mm2s_desc_app4                  => mm2s_desc_app4
            );

        cntrlstrm_fifo_full         <= '0';

    end generate GEN_SCATTER_GATHER_MODE;


    -- Generate DMA Controller for Simple DMA Mode
    GEN_SIMPLE_DMA_MODE : if C_INCLUDE_SG = 0 generate
    begin

        -- Scatter Gather signals not used in Simple DMA Mode
        m_axis_mm2s_ftch_tready     <= '0';
        s_axis_mm2s_updtptr_tdata   <= (others => '0');
        s_axis_mm2s_updtptr_tvalid  <= '0';
        s_axis_mm2s_updtptr_tlast   <= '0';
        s_axis_mm2s_updtsts_tdata   <= (others => '0');
        s_axis_mm2s_updtsts_tvalid  <= '0';
        s_axis_mm2s_updtsts_tlast   <= '0';
        desc_available              <= '0';
        desc_fetch_done             <= '0';
        packet_in_progress          <= '0';
        desc_update_done            <= '0';
        cntrlstrm_fifo_wren         <= '0';
        cntrlstrm_fifo_din          <= (others => '0');
        mm2s_new_curdesc            <= (others => '0');
        mm2s_new_curdesc_wren       <= '0';
        mm2s_desc_baddress          <= (others => '0');
        mm2s_desc_blength           <= (others => '0');
        mm2s_desc_blength_v           <= (others => '0');
        mm2s_desc_blength_s           <= (others => '0');
        mm2s_desc_eof               <= '0';
        mm2s_desc_sof               <= '0';
        mm2s_desc_cmplt             <= '0';
        mm2s_desc_app0              <= (others => '0');
        mm2s_desc_app1              <= (others => '0');
        mm2s_desc_app2              <= (others => '0');
        mm2s_desc_app3              <= (others => '0');
        mm2s_desc_app4              <= (others => '0');
        desc_fetch_req              <= '0';

        -- Simple DMA State Machine
        I_MM2S_SMPL_SM : entity axi_dma_v7_1_8.axi_dma_smple_sm
            generic map(
                C_M_AXI_ADDR_WIDTH          => C_M_AXI_MM2S_ADDR_WIDTH  ,
                C_SG_LENGTH_WIDTH           => C_SG_LENGTH_WIDTH,
                C_MICRO_DMA                 => C_MICRO_DMA
            )
            port map(
                m_axi_sg_aclk               => m_axi_sg_aclk            ,
                m_axi_sg_aresetn            => m_axi_sg_aresetn         ,

                -- Channel 1 Control and Status
                run_stop                    => mm2s_run_stop            ,
                keyhole                     => mm2s_keyhole             ,
                stop                        => mm2s_stop_i              ,
                cmnd_idle                   => mm2s_cmnd_idle           ,
                sts_idle                    => mm2s_sts_idle            ,

                -- DataMover Status
                sts_received                => mm2s_sts_received        ,
                sts_received_clr            => mm2s_sts_received_clr    ,

                -- DataMover Command
                cmnd_wr                     => mm2s_cmnd_wr_1             ,
                cmnd_data                   => mm2s_cmnd_data           ,
                cmnd_pending                => mm2s_cmnd_pending        ,

                -- Trasnfer Qualifiers
                xfer_length_wren            => mm2s_length_wren         ,
                xfer_address                => mm2s_sa                  ,
                xfer_length                 => mm2s_length
            );


        -- Pass Done/Error Status out to DMASR
        mm2s_interr_set                 <= mm2s_interr;
        mm2s_slverr_set                 <= mm2s_slverr;
        mm2s_decerr_set                 <= mm2s_decerr;

        -- S2MM Simple DMA Transfer Done - used to assert IOC bit in DMASR.
                                      -- Receive clear when not shutting down
        mm2s_smple_done                 <= mm2s_sts_received_clr when mm2s_stop_i = '0'
                                      -- Else halt set prior to halted being set
                                      else mm2s_halted_set_i when mm2s_halted = '0'
                                      else '0';



    end generate GEN_SIMPLE_DMA_MODE;

    -------------------------------------------------------------------------------
    -- MM2S Primary DataMover command status interface
    -------------------------------------------------------------------------------
    I_MM2S_CMDSTS : entity  axi_dma_v7_1_8.axi_dma_mm2s_cmdsts_if
        generic map(
            C_M_AXI_MM2S_ADDR_WIDTH         => C_M_AXI_MM2S_ADDR_WIDTH,
            C_ENABLE_MULTI_CHANNEL                 => C_ENABLE_MULTI_CHANNEL,
            C_ENABLE_QUEUE                  => C_SG_INCLUDE_DESC_QUEUE 
        )
        port map(
            m_axi_sg_aclk                   => m_axi_sg_aclk                ,
            m_axi_sg_aresetn                => m_axi_sg_aresetn             ,

            -- Fetch command write interface from mm2s sm
            mm2s_cmnd_wr                    => mm2s_cmnd_wr_1                 ,
            mm2s_cmnd_data                  => mm2s_cmnd_data               ,
            mm2s_cmnd_pending               => mm2s_cmnd_pending            ,

            mm2s_sts_received_clr           => mm2s_sts_received_clr        ,
            mm2s_sts_received               => mm2s_sts_received            ,
            mm2s_tailpntr_enble             => mm2s_tailpntr_enble          ,
            mm2s_desc_cmplt                 => mm2s_desc_cmplt              ,

            -- User Command Interface Ports (AXI Stream)
            s_axis_mm2s_cmd_tvalid          => s_axis_mm2s_cmd_tvalid       ,
            s_axis_mm2s_cmd_tready          => s_axis_mm2s_cmd_tready       ,
            s_axis_mm2s_cmd_tdata           => s_axis_mm2s_cmd_tdata        ,

            -- User Status Interface Ports (AXI Stream)
            m_axis_mm2s_sts_tvalid          => m_axis_mm2s_sts_tvalid       ,
            m_axis_mm2s_sts_tready          => m_axis_mm2s_sts_tready       ,
            m_axis_mm2s_sts_tdata           => m_axis_mm2s_sts_tdata        ,
            m_axis_mm2s_sts_tkeep           => m_axis_mm2s_sts_tkeep        ,

            -- MM2S Primary DataMover Status
            mm2s_err                        => mm2s_err                     ,
            mm2s_done                       => mm2s_done                    ,
            mm2s_error                      => dma_mm2s_error               ,
            mm2s_interr                     => mm2s_interr                  ,
            mm2s_slverr                     => mm2s_slverr                  ,
            mm2s_decerr                     => mm2s_decerr                  ,
            mm2s_tag                        => mm2s_tag
        );

    ---------------------------------------------------------------------------
    -- Halt / Idle Status Manager
    ---------------------------------------------------------------------------
    I_MM2S_STS_MNGR : entity  axi_dma_v7_1_8.axi_dma_mm2s_sts_mngr
        generic map(
            C_PRMRY_IS_ACLK_ASYNC       => C_PRMRY_IS_ACLK_ASYNC
        )
        port map(
            m_axi_sg_aclk               => m_axi_sg_aclk                    ,
            m_axi_sg_aresetn            => m_axi_sg_aresetn                 ,

            -- dma control and sg engine status signals
            mm2s_run_stop               => mm2s_run_stop                    ,
            mm2s_ftch_idle              => mm2s_ftch_idle                   ,
            mm2s_updt_idle              => mm2s_updt_idle                   ,
            mm2s_cmnd_idle              => mm2s_cmnd_idle                   ,
            mm2s_sts_idle               => mm2s_sts_idle                    ,

            -- stop and halt control/status
            mm2s_stop                   => mm2s_stop_i                      ,
            mm2s_halt_cmplt             => mm2s_halt_cmplt                  ,

            -- system state and control
            mm2s_all_idle               => mm2s_all_idle                    ,
            mm2s_halted_clr             => mm2s_halted_clr                  ,
            mm2s_halted_set             => mm2s_halted_set_i                ,
            mm2s_idle_set               => mm2s_idle_set                    ,
            mm2s_idle_clr               => mm2s_idle_clr
        );


    -- MM2S Control Stream Included
    GEN_CNTRL_STREAM : if C_SG_INCLUDE_STSCNTRL_STRM = 1 and C_INCLUDE_SG = 1 generate
    begin

        -- Register soft reset to create rising edge pulse to use for shut down.
        -- soft_reset from DMACR does not clear until after all reset processes
        -- are done.  This causes stop to assert too long causing issue with
        -- status stream skid buffer.
        REG_SFT_RST : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0')then
                        soft_reset_d1 <= '0';
                        soft_reset_d2 <= '0';
                    else
                        soft_reset_d1 <= soft_reset;
                        soft_reset_d2 <= soft_reset_d1;
                    end if;
                end if;
            end process REG_SFT_RST;

        -- Rising edge soft reset pulse
        soft_reset_re <= soft_reset_d1 and not soft_reset_d2;

        -- Control Stream module stop requires rising edge of soft reset to
        -- shut down due to DMACR.SoftReset does not deassert on internal hard reset
        -- It clears after therefore do not want to issue another stop to cntrl strm
        -- skid buffer.
        cntrl_strm_stop <= mm2s_error_i             -- Error
                        or soft_reset_re;           -- Soft Reset issued

        -- Control stream interface
--        I_MM2S_CNTRL_STREAM : entity axi_dma_v7_1_8.axi_dma_mm2s_cntrl_strm
--            generic map(
--                C_PRMRY_IS_ACLK_ASYNC           => C_PRMRY_IS_ACLK_ASYNC            ,
--                C_PRMY_CMDFIFO_DEPTH            => C_PRMY_CMDFIFO_DEPTH             ,
--                C_M_AXIS_MM2S_CNTRL_TDATA_WIDTH => C_M_AXIS_MM2S_CNTRL_TDATA_WIDTH  ,
--                C_FAMILY                        => C_FAMILY
--            )
--            port map(
--                -- Secondary clock / reset
--                m_axi_sg_aclk               => m_axi_sg_aclk                ,
--                m_axi_sg_aresetn            => m_axi_sg_aresetn             ,
--
--                -- Primary clock / reset
--                axi_prmry_aclk              => axi_prmry_aclk               ,
--                p_reset_n                   => p_reset_n                    ,
--
--                -- MM2S Error
--                mm2s_stop                   => cntrl_strm_stop              ,
--
--                -- Control Stream input
----                cntrlstrm_fifo_wren         => cntrlstrm_fifo_wren          ,
--                cntrlstrm_fifo_full         => cntrlstrm_fifo_full          ,
--                cntrlstrm_fifo_din          => cntrlstrm_fifo_din           ,
--
--                -- Memory Map to Stream Control Stream Interface
--                m_axis_mm2s_cntrl_tdata     => m_axis_mm2s_cntrl_tdata      ,
--                m_axis_mm2s_cntrl_tkeep     => m_axis_mm2s_cntrl_tkeep      ,
--                m_axis_mm2s_cntrl_tvalid    => m_axis_mm2s_cntrl_tvalid     ,
--                m_axis_mm2s_cntrl_tready    => m_axis_mm2s_cntrl_tready     ,
--                m_axis_mm2s_cntrl_tlast     => m_axis_mm2s_cntrl_tlast
--
--            );
    end generate GEN_CNTRL_STREAM;


    -- MM2S Control Stream Excluded
    GEN_NO_CNTRL_STREAM : if C_SG_INCLUDE_STSCNTRL_STRM = 0 or C_INCLUDE_SG = 0 generate
    begin
        soft_reset_d1               <= '0';
        soft_reset_d2               <= '0';
        soft_reset_re               <= '0';
        cntrl_strm_stop             <= '0';

    end generate GEN_NO_CNTRL_STREAM;

        m_axis_mm2s_cntrl_tdata     <= (others => '0');
        m_axis_mm2s_cntrl_tkeep     <= (others => '0');
        m_axis_mm2s_cntrl_tvalid    <= '0';
        m_axis_mm2s_cntrl_tlast     <= '0';

end generate GEN_MM2S_DMA_CONTROL;


-------------------------------------------------------------------------------
-- Exclude MM2S State Machine and support logic
-------------------------------------------------------------------------------
GEN_NO_MM2S_DMA_CONTROL : if C_INCLUDE_MM2S = 0 generate
begin
        m_axis_mm2s_ftch_tready     <= '0';
        s_axis_mm2s_updtptr_tdata   <= (others =>'0');
        s_axis_mm2s_updtptr_tvalid  <= '0';
        s_axis_mm2s_updtptr_tlast   <= '0';
        s_axis_mm2s_updtsts_tdata   <= (others =>'0');
        s_axis_mm2s_updtsts_tvalid  <= '0';
        s_axis_mm2s_updtsts_tlast   <= '0';
        mm2s_new_curdesc            <= (others =>'0');
        mm2s_new_curdesc_wren       <= '0';
        s_axis_mm2s_cmd_tvalid      <= '0';
        s_axis_mm2s_cmd_tdata       <= (others =>'0');
        m_axis_mm2s_sts_tready      <= '0';
        mm2s_halted_clr             <= '0';
        mm2s_halted_set             <= '0';
        mm2s_idle_set               <= '0';
        mm2s_idle_clr               <= '0';
        m_axis_mm2s_cntrl_tdata     <= (others => '0');
        m_axis_mm2s_cntrl_tkeep     <= (others => '0');
        m_axis_mm2s_cntrl_tvalid    <= '0';
        m_axis_mm2s_cntrl_tlast     <= '0';
        mm2s_stop                   <= '0';
        mm2s_desc_flush             <= '0';
        mm2s_all_idle               <= '1';
        mm2s_error                  <= '0'; -- CR#570587
        mm2s_interr_set             <= '0';
        mm2s_slverr_set             <= '0';
        mm2s_decerr_set             <= '0';
        mm2s_smple_done             <= '0';
        cntrl_strm_stop             <= '0';

end generate GEN_NO_MM2S_DMA_CONTROL;

TDEST_FIFO : if (C_ENABLE_MULTI_CHANNEL = 1) generate

    process (m_axi_sg_aclk)
    begin
         if (m_axi_sg_aclk'event and m_axi_sg_aclk = '1') then
           if (m_axi_sg_aresetn = '0') then
                 desc_fetch_done_del <= '0';
           else --if (m_axi_sg_aclk'event and m_axi_sg_aclk = '1') then
                 desc_fetch_done_del <= desc_fetch_done;
           end if;
         end if;
    end process; 


    process (m_axis_mm2s_aclk)
    begin
         if (m_axis_mm2s_aclk'event and m_axis_mm2s_aclk = '1') then
           if (m_axi_sg_aresetn = '0') then
                 fifo_empty <= '0';
           else 
                 fifo_empty <= info_fifo_empty;
           end if;
         end if;
    end process; 
    process (m_axis_mm2s_aclk)
    begin
         if (m_axis_mm2s_aclk'event and m_axis_mm2s_aclk = '1') then
           if (m_axi_sg_aresetn = '0') then
                 fifo_empty_first <= '0';
                 fifo_empty_first1 <= '0';
           else
                if (fifo_empty_first = '0' and (info_fifo_empty = '0' and fifo_empty = '1')) then
                 fifo_empty_first <= '1';
                end if;
                 fifo_empty_first1 <= fifo_empty_first;
           end if;
         end if;
    end process; 
              
    first_read_pulse <= fifo_empty_first and (not fifo_empty_first1);

    fifo_read <= first_read_pulse or rd_en_hold; 

    mm2s_desc_info_int <= mm2s_desc_info (19 downto 16) & mm2s_desc_info (12 downto 8) & mm2s_desc_info (4 downto 0);

--    mm2s_strm_tlast_int <= mm2s_strm_tlast and (not info_fifo_empty); 
--    process (m_axis_mm2s_aclk)
--    begin
--       if (m_axis_mm2s_aclk'event and m_axis_mm2s_aclk = '1') then
--         if (p_reset_n = '0') then
--             rd_en_hold <= '0';
--             rd_en_hold_int <= '0';
--         else
--            if (rd_en_hold = '1') then
--              rd_en_hold <= '0';
--            elsif (info_fifo_empty = '0' and mm2s_strm_tlast = '1' and mm2s_strm_tready = '1') then
--              rd_en_hold <= '1';
--              rd_en_hold_int <= '0';
--            else
--              rd_en_hold <= rd_en_hold; 
--              rd_en_hold_int <= rd_en_hold_int;
--            end if;        
--         end if;
--       end if;
--    end process; 


    process (m_axis_mm2s_aclk)
    begin
       if (m_axis_mm2s_aclk'event and m_axis_mm2s_aclk = '1') then
         if (p_reset_n = '0') then
             rd_en_hold <= '0';
             rd_en_hold_int <= '0';
         else
            if (info_fifo_empty = '1' and mm2s_strm_tlast = '1' and mm2s_strm_tready = '1') then
              rd_en_hold <= '1';
              rd_en_hold_int <= '0';
            elsif (info_fifo_empty = '0') then
              rd_en_hold <= mm2s_strm_tlast and mm2s_strm_tready; 
              rd_en_hold_int <= rd_en_hold;
            else
              rd_en_hold <= rd_en_hold; 
              rd_en_hold_int <= rd_en_hold_int;
            end if;        
         end if;
       end if;
    end process; 

    fifo_rst <= not (m_axi_sg_aresetn);

    -- Following FIFO is used to store the Tuser, Tid and xCache info
    I_INFO_FIFO : entity axi_dma_v7_1_8.axi_dma_afifo_autord
      generic map(
         C_DWIDTH        => 14,
         C_DEPTH         => 31                                  ,
         C_CNT_WIDTH     => 5                                   ,
         C_USE_BLKMEM    => 0, 
         C_USE_AUTORD    => 1,
         C_PRMRY_IS_ACLK_ASYNC       => C_PRMRY_IS_ACLK_ASYNC            ,
         C_FAMILY        => C_FAMILY
        )
      port map(
        -- Inputs
         AFIFO_Ainit                => fifo_rst         ,
         AFIFO_Wr_clk               => m_axi_sg_aclk            ,
         AFIFO_Wr_en                => desc_fetch_done_del      ,
         AFIFO_Din                  => mm2s_desc_info_int       ,
         AFIFO_Rd_clk               => m_axis_mm2s_aclk           ,
         AFIFO_Rd_en                => rd_en_hold_int, --fifo_read, --mm2s_strm_tlast_int          ,
         AFIFO_Clr_Rd_Data_Valid    => '0'                      ,

        -- Outputs
         AFIFO_DValid               => open        ,
         AFIFO_Dout                 => mm2s_axis_info          ,
         AFIFO_Full                 => info_fifo_full      ,
         AFIFO_Empty                => info_fifo_empty     ,
         AFIFO_Almost_full          => open                     ,
         AFIFO_Almost_empty         => open                     ,
         AFIFO_Wr_count             => open                     ,
         AFIFO_Rd_count             => open                     ,
         AFIFO_Corr_Rd_count        => open                     ,
         AFIFO_Corr_Rd_count_minus1 => open                     ,
         AFIFO_Rd_ack               => open
        );

end generate TDEST_FIFO;


NO_TDEST_FIFO : if (C_ENABLE_MULTI_CHANNEL = 0) generate
    mm2s_axis_info <= (others => '0');

end generate NO_TDEST_FIFO;

end implementation;
