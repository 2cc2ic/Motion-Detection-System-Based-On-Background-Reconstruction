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
-- Filename:          axi_sg.vhd
-- Description: This entity is the top level entity for the AXI Scatter Gather
--              Engine.
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

library axi_sg_v4_1_2;
use axi_sg_v4_1_2.axi_sg_pkg.all;


library lib_pkg_v1_0_2;
use lib_pkg_v1_0_2.lib_pkg.max2;

-------------------------------------------------------------------------------
entity  axi_sg is
    generic (
        C_M_AXI_SG_ADDR_WIDTH       : integer range 32 to 64    := 32;
            -- Master AXI Memory Map Address Width for Scatter Gather R/W Port

        C_M_AXI_SG_DATA_WIDTH       : integer range 32 to 32    := 32;
            -- Master AXI Memory Map Data Width for Scatter Gather R/W Port

        C_M_AXIS_SG_TDATA_WIDTH  : integer range 32 to 32        := 32;
            -- AXI Master Stream out for descriptor fetch

        C_S_AXIS_UPDPTR_TDATA_WIDTH : integer range 32 to 32     := 32;
            -- 32 Update Status Bits

        C_S_AXIS_UPDSTS_TDATA_WIDTH : integer range 33 to 33     := 33;
            -- 1 IOC bit + 32 Update Status Bits

        C_SG_FTCH_DESC2QUEUE     : integer range 0 to 8         := 0;
            -- Number of descriptors to fetch and queue for each channel.
            -- A value of zero excludes the fetch queues.

        C_SG_UPDT_DESC2QUEUE     : integer range 0 to 8         := 0;
            -- Number of descriptors to fetch and queue for each channel.
            -- A value of zero excludes the fetch queues.

        C_SG_CH1_WORDS_TO_FETCH   : integer range 4 to 16       := 8;
            -- Number of words to fetch

        C_SG_CH1_WORDS_TO_UPDATE   : integer range 1 to 16      := 8;
            -- Number of words to update

        C_SG_CH1_FIRST_UPDATE_WORD : integer range 0 to 15      := 0;
            -- Starting update word offset

        C_SG_CH1_ENBL_STALE_ERROR   : integer range 0 to 1      := 1;
            -- Enable or disable stale descriptor check
            -- 0 = Disable stale descriptor error check
            -- 1 = Enable stale descriptor error check

        C_SG_CH2_WORDS_TO_FETCH    : integer range 4 to 16      := 8;
            -- Number of words to fetch

        C_SG_CH2_WORDS_TO_UPDATE   : integer range 1 to 16      := 8;
            -- Number of words to update

        C_SG_CH2_FIRST_UPDATE_WORD : integer range 0 to 15      := 0;
            -- Starting update word offset

        C_SG_CH2_ENBL_STALE_ERROR   : integer range 0 to 1      := 1;
            -- Enable or disable stale descriptor check
            -- 0 = Disable stale descriptor error check
            -- 1 = Enable stale descriptor error check

        C_INCLUDE_CH1               : integer range 0 to 1      := 1;
            -- Include or Exclude channel 1 scatter gather engine
            -- 0 = Exclude Channel 1 SG Engine
            -- 1 = Include Channel 1 SG Engine

        C_INCLUDE_CH2               : integer range 0 to 1      := 1;
            -- Include or Exclude channel 2 scatter gather engine
            -- 0 = Exclude Channel 2 SG Engine
            -- 1 = Include Channel 2 SG Engine

        C_AXIS_IS_ASYNC             : integer range 0 to 1      := 0;
            -- Channel 1 is async to sg_aclk
            -- 0 = Synchronous to SG ACLK
            -- 1 = Asynchronous to SG ACLK

        C_ASYNC             : integer range 0 to 1      := 0;
            -- Channel 1 is async to sg_aclk
            -- 0 = Synchronous to SG ACLK
            -- 1 = Asynchronous to SG ACLK

        C_INCLUDE_DESC_UPDATE       : integer range 0 to 1      := 1;
            -- Include or Exclude Scatter Gather Descriptor Update
            -- 0 = Exclude Descriptor Update
            -- 1 = Include Descriptor Update

        C_INCLUDE_INTRPT            : integer range 0 to 1      := 1;
            -- Include/Exclude interrupt logic coalescing
            -- 0 = Exclude Delay timer
            -- 1 = Include Delay timer

        C_INCLUDE_DLYTMR            : integer range 0 to 1      := 1;
            -- Include/Exclude interrupt delay timer
            -- 0 = Exclude Delay timer
            -- 1 = Include Delay timer

        C_DLYTMR_RESOLUTION         : integer range 1 to 100000 := 125;
            -- Interrupt Delay Timer resolution in usec

        C_ENABLE_MULTI_CHANNEL             : integer range 0 to 1   := 0;
        C_ENABLE_CDMA                      : integer range 0 to 1   := 0;
        C_ENABLE_EXTRA_FIELD         : integer range 0 to 1 := 0;
        C_NUM_S2MM_CHANNELS         : integer range 1 to 16 := 1;
        C_NUM_MM2S_CHANNELS         : integer range 1 to 16 := 1;
        C_ACTUAL_ADDR               : integer range 32 to 64 := 32;

        C_FAMILY                    : string                    := "virtex7"
            -- Device family used for proper BRAM selection
    );
    port (
        -----------------------------------------------------------------------
        -- AXI Scatter Gather Interface
        -----------------------------------------------------------------------
        m_axi_sg_aclk               : in  std_logic                         ;               --
        m_axi_mm2s_aclk             : in  std_logic                         ;               --
        m_axi_sg_aresetn            : in  std_logic                         ;               --
        p_reset_n                   : in  std_logic                         ;
                                                                                            --
        dm_resetn                   : in  std_logic                         ;               --
        sg_ctl                      : in  std_logic_vector (7 downto 0)     ;
                                                                                            --
        -- Scatter Gather Write Address Channel                                             --
        m_axi_sg_awaddr             : out std_logic_vector                                  --
                                        (C_M_AXI_SG_ADDR_WIDTH-1 downto 0)  ;               --
        m_axi_sg_awlen              : out std_logic_vector(7 downto 0)      ;               --
        m_axi_sg_awsize             : out std_logic_vector(2 downto 0)      ;               --
        m_axi_sg_awburst            : out std_logic_vector(1 downto 0)      ;               --
        m_axi_sg_awprot             : out std_logic_vector(2 downto 0)      ;               --
        m_axi_sg_awcache            : out std_logic_vector(3 downto 0)      ;               --
        m_axi_sg_awuser             : out std_logic_vector(3 downto 0)      ;               --
        m_axi_sg_awvalid            : out std_logic                         ;               --
        m_axi_sg_awready            : in  std_logic                         ;               --
                                                                                            --
        -- Scatter Gather Write Data Channel                                                --
        m_axi_sg_wdata              : out std_logic_vector                                  --
                                        (C_M_AXI_SG_DATA_WIDTH-1 downto 0)  ;               --
        m_axi_sg_wstrb              : out std_logic_vector                                  --
                                        ((C_M_AXI_SG_DATA_WIDTH/8)-1 downto 0);             --
        m_axi_sg_wlast              : out std_logic                         ;               --
        m_axi_sg_wvalid             : out std_logic                         ;               --
        m_axi_sg_wready             : in  std_logic                         ;               --
                                                                                            --
        -- Scatter Gather Write Response Channel                                            --
        m_axi_sg_bresp              : in  std_logic_vector(1 downto 0)      ;               --
        m_axi_sg_bvalid             : in  std_logic                         ;               --
        m_axi_sg_bready             : out std_logic                         ;               --
                                                                                            --
        -- Scatter Gather Read Address Channel                                              --
        m_axi_sg_araddr             : out std_logic_vector                                  --
                                        (C_M_AXI_SG_ADDR_WIDTH-1 downto 0)  ;               --
        m_axi_sg_arlen              : out std_logic_vector(7 downto 0)      ;               --
        m_axi_sg_arsize             : out std_logic_vector(2 downto 0)      ;               --
        m_axi_sg_arburst            : out std_logic_vector(1 downto 0)      ;               --
        m_axi_sg_arcache            : out std_logic_vector(3 downto 0)      ;               --
        m_axi_sg_aruser             : out std_logic_vector(3 downto 0)      ;               --
        m_axi_sg_arprot             : out std_logic_vector(2 downto 0)      ;               --
        m_axi_sg_arvalid            : out std_logic                         ;               --
        m_axi_sg_arready            : in  std_logic                         ;               --
                                                                                            --
        -- Memory Map to Stream Scatter Gather Read Data Channel                            --
        m_axi_sg_rdata              : in  std_logic_vector                                  --
                                        (C_M_AXI_SG_DATA_WIDTH-1 downto 0)  ;               --
        m_axi_sg_rresp              : in  std_logic_vector(1 downto 0)      ;               --
        m_axi_sg_rlast              : in  std_logic                         ;               --
        m_axi_sg_rvalid             : in  std_logic                         ;               --
        m_axi_sg_rready             : out std_logic                         ;               --
                                                                                            --
        -- Channel 1 Control and Status                                                     --
        ch1_run_stop                : in  std_logic                         ;               --
        ch1_cyclic                  : in  std_logic                         ;               --
        ch1_desc_flush              : in  std_logic                         ;               --
        ch1_cntrl_strm_stop         : in  std_logic                         ;
        ch1_tailpntr_enabled        : in  std_logic                         ;               --
        ch1_taildesc_wren           : in  std_logic                         ;               --
        ch1_taildesc                : in  std_logic_vector                                  --
                                        (C_M_AXI_SG_ADDR_WIDTH-1 downto 0)  ;               --
        ch1_curdesc                 : in  std_logic_vector                                  --
                                        (C_M_AXI_SG_ADDR_WIDTH-1 downto 0)  ;               --
        ch1_ftch_idle               : out std_logic                         ;               --
        ch1_ftch_interr_set         : out std_logic                         ;               --
        ch1_ftch_slverr_set         : out std_logic                         ;               --
        ch1_ftch_decerr_set         : out std_logic                         ;               --
        ch1_ftch_err_early          : out std_logic                         ;               --
        ch1_ftch_stale_desc         : out std_logic                         ;               --
        ch1_updt_idle               : out std_logic                         ;               --
        ch1_updt_ioc_irq_set        : out std_logic                         ;               --
        ch1_updt_interr_set         : out std_logic                         ;               --
        ch1_updt_slverr_set         : out std_logic                         ;               --
        ch1_updt_decerr_set         : out std_logic                         ;               --
        ch1_dma_interr_set          : out std_logic                         ;               --
        ch1_dma_slverr_set          : out std_logic                         ;               --
        ch1_dma_decerr_set          : out std_logic                         ;               --
                                                                                            --
                                                                                            --
        -- Channel 1 Interrupt Coalescing Signals                                           --
        ch1_irqthresh_rstdsbl       : in  std_logic                         ;-- CR572013    --
        ch1_dlyirq_dsble            : in  std_logic                         ;               --
        ch1_irqdelay_wren           : in  std_logic                         ;               --
        ch1_irqdelay                : in  std_logic_vector(7 downto 0)      ;               --
        ch1_irqthresh_wren          : in  std_logic                         ;               --
        ch1_irqthresh               : in  std_logic_vector(7 downto 0)      ;               --
        ch1_packet_sof              : in  std_logic                         ;               --
        ch1_packet_eof              : in  std_logic                         ;               --
        ch1_ioc_irq_set             : out std_logic                         ;               --
        ch1_dly_irq_set             : out std_logic                         ;               --
        ch1_irqdelay_status         : out std_logic_vector(7 downto 0)      ;               --
        ch1_irqthresh_status        : out std_logic_vector(7 downto 0)      ;               --
                                                                                            --
        -- Channel 1 AXI Fetch Stream Out                                                   --
        m_axis_ch1_ftch_aclk        : in  std_logic                         ;               --
        m_axis_ch1_ftch_tdata       : out std_logic_vector                                  --
                                        (C_M_AXIS_SG_TDATA_WIDTH-1 downto 0);               --
        m_axis_ch1_ftch_tvalid      : out std_logic                         ;               --
        m_axis_ch1_ftch_tready      : in  std_logic                         ;               --
        m_axis_ch1_ftch_tlast       : out std_logic                         ;               --


        m_axis_ch1_ftch_tdata_new       : out std_logic_vector                                  --
                                        (96+31*C_ENABLE_CDMA+(2+C_ENABLE_CDMA)*(C_M_AXI_SG_ADDR_WIDTH-32) downto 0);               --
        m_axis_ch1_ftch_tdata_mcdma_new       : out std_logic_vector                                  --
                                        (63 downto 0);               --
        m_axis_ch1_ftch_tvalid_new      : out std_logic                         ;               --
        m_axis_ftch1_desc_available  : out std_logic;

                                                                                            --
                                                                                            --
        -- Channel 1 AXI Update Stream In                                                   --
        s_axis_ch1_updt_aclk        : in  std_logic                         ;               --
        s_axis_ch1_updtptr_tdata    : in  std_logic_vector                                  --
                                        (C_M_AXI_SG_ADDR_WIDTH-1 downto 0);           --
        s_axis_ch1_updtptr_tvalid   : in  std_logic                         ;               --
        s_axis_ch1_updtptr_tready   : out std_logic                         ;               --
        s_axis_ch1_updtptr_tlast    : in  std_logic                         ;               --
                                                                                            --
        s_axis_ch1_updtsts_tdata    : in  std_logic_vector                                  --
                                        (C_S_AXIS_UPDSTS_TDATA_WIDTH-1 downto 0);           --
        s_axis_ch1_updtsts_tvalid   : in  std_logic                         ;               --
        s_axis_ch1_updtsts_tready   : out std_logic                         ;               --
        s_axis_ch1_updtsts_tlast    : in  std_logic                         ;               --
                                                                                            --
        -- Channel 2 Control and Status                                                     --
        ch2_run_stop                : in  std_logic                         ;               --
        ch2_cyclic                  : in  std_logic                         ;               --
        ch2_desc_flush              : in  std_logic                         ;               --
        ch2_tailpntr_enabled        : in  std_logic                         ;               --
        ch2_taildesc_wren           : in  std_logic                         ;               --
        ch2_taildesc                : in  std_logic_vector                                  --
                                        (C_M_AXI_SG_ADDR_WIDTH-1 downto 0)  ;               --
        ch2_curdesc                 : in  std_logic_vector                                  --
                                        (C_M_AXI_SG_ADDR_WIDTH-1 downto 0)  ;               --
        ch2_ftch_idle               : out std_logic                         ;               --
        ch2_ftch_interr_set         : out std_logic                         ;               --
        ch2_ftch_slverr_set         : out std_logic                         ;               --
        ch2_ftch_decerr_set         : out std_logic                         ;               --
        ch2_ftch_err_early          : out std_logic                         ;               --
        ch2_ftch_stale_desc         : out std_logic                         ;               --
        ch2_updt_idle               : out std_logic                         ;               --
        ch2_updt_ioc_irq_set        : out std_logic                         ;               --
        ch2_updt_interr_set         : out std_logic                         ;               --
        ch2_updt_slverr_set         : out std_logic                         ;               --
        ch2_updt_decerr_set         : out std_logic                         ;               --
        ch2_dma_interr_set          : out std_logic                         ;               --
        ch2_dma_slverr_set          : out std_logic                         ;               --
        ch2_dma_decerr_set          : out std_logic                         ;               --
                                                                                            --
        -- Channel 2 Interrupt Coalescing Signals                                           --
        ch2_irqthresh_rstdsbl       : in  std_logic                         ;-- CR572013    --
        ch2_dlyirq_dsble            : in  std_logic                         ;               --
        ch2_irqdelay_wren           : in  std_logic                         ;               --
        ch2_irqdelay                : in  std_logic_vector(7 downto 0)      ;               --
        ch2_irqthresh_wren          : in  std_logic                         ;               --
        ch2_irqthresh               : in  std_logic_vector(7 downto 0)      ;               --
        ch2_packet_sof              : in  std_logic                         ;               --
        ch2_packet_eof              : in  std_logic                         ;               --
        ch2_ioc_irq_set             : out std_logic                         ;               --
        ch2_dly_irq_set             : out std_logic                         ;               --
        ch2_irqdelay_status         : out std_logic_vector(7 downto 0)      ;               --
        ch2_irqthresh_status        : out std_logic_vector(7 downto 0)      ;               --
        ch2_update_active           : out std_logic                         ;
                                                                                            --
        -- Channel 2 AXI Fetch Stream Out                                                   --
        m_axis_ch2_ftch_aclk        : in  std_logic                         ;               --
        m_axis_ch2_ftch_tdata       : out std_logic_vector                                  --
                                        (C_M_AXIS_SG_TDATA_WIDTH-1 downto 0);               --
        m_axis_ch2_ftch_tvalid      : out std_logic                         ;               --
        m_axis_ch2_ftch_tready      : in  std_logic                         ;               --
        m_axis_ch2_ftch_tlast       : out std_logic                         ;               --
                                                                                            --
        m_axis_ch2_ftch_tdata_new       : out std_logic_vector                                  --
                                        (96+31*C_ENABLE_CDMA+(2+C_ENABLE_CDMA)*(C_M_AXI_SG_ADDR_WIDTH-32) downto 0);               --
        m_axis_ch2_ftch_tdata_mcdma_new       : out std_logic_vector                                  --
                                        (63 downto 0);               --
        m_axis_ch2_ftch_tdata_mcdma_nxt       : out std_logic_vector                                  --
                                        (C_M_AXI_SG_ADDR_WIDTH-1 downto 0);               --
        m_axis_ch2_ftch_tvalid_new      : out std_logic                         ;               --
        m_axis_ftch2_desc_available  : out std_logic;
        -- Channel 2 AXI Update Stream In                                                   --
        s_axis_ch2_updt_aclk        : in  std_logic                         ;               --
        s_axis_ch2_updtptr_tdata    : in  std_logic_vector                                  --
                                        (C_M_AXI_SG_ADDR_WIDTH-1 downto 0);           --
        s_axis_ch2_updtptr_tvalid   : in  std_logic                         ;               --
        s_axis_ch2_updtptr_tready   : out std_logic                         ;               --
        s_axis_ch2_updtptr_tlast    : in  std_logic                         ;               --
                                                                                            --
                                                                                            --
        s_axis_ch2_updtsts_tdata    : in  std_logic_vector                                  --
                                        (C_S_AXIS_UPDSTS_TDATA_WIDTH-1 downto 0);           --
        s_axis_ch2_updtsts_tvalid   : in  std_logic                         ;               --
        s_axis_ch2_updtsts_tready   : out std_logic                         ;               --
        s_axis_ch2_updtsts_tlast    : in  std_logic                         ;               --
                                                                                            --
                                                                                            --
        -- Error addresses                                                                  --
        ftch_error                  : out std_logic                         ;               --
        ftch_error_addr             : out std_logic_vector                                  --
                                        (C_M_AXI_SG_ADDR_WIDTH-1 downto 0)  ;               --
        updt_error                  : out std_logic                         ;               --
        updt_error_addr             : out std_logic_vector                                  --
                                        (C_M_AXI_SG_ADDR_WIDTH-1 downto 0)  ;                --

        m_axis_mm2s_cntrl_tdata     : out std_logic_vector                                 --
                                        (31 downto 0);      --
        m_axis_mm2s_cntrl_tkeep     : out std_logic_vector                                 --
                                        (3 downto 0);  --
        m_axis_mm2s_cntrl_tvalid    : out std_logic                         ;              --
        m_axis_mm2s_cntrl_tready    : in  std_logic                         := '0';              --
        m_axis_mm2s_cntrl_tlast     : out std_logic                         ;
        bd_eq                       : out std_logic 
    );

end axi_sg;

-------------------------------------------------------------------------------
-- Architecture
-------------------------------------------------------------------------------
architecture implementation of axi_sg is
  attribute DowngradeIPIdentifiedWarnings: string;
  attribute DowngradeIPIdentifiedWarnings of implementation : architecture is "yes";


-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------

-- No Functions Declared

-------------------------------------------------------------------------------
-- Constants Declarations
-------------------------------------------------------------------------------
constant AXI_LITE_MODE      : integer := 2;         -- DataMover Lite Mode
constant EXCLUDE            : integer := 0;         -- Define Exclude as 0
constant NEVER_HALT         : std_logic := '0';     -- Never halt sg datamover

-- Always include descriptor fetch (use lite datamover)
constant INCLUDE_DESC_FETCH     : integer := AXI_LITE_MODE;
-- Selectable include descriptor update (use lite datamover)
constant INCLUDE_DESC_UPDATE    : integer := AXI_LITE_MODE * C_INCLUDE_DESC_UPDATE;

-- Always allow address requests
constant ALWAYS_ALLOW       : std_logic := '1';


-- If async mode and number of descriptors to fetch is zero then set number
-- of descriptors to fetch as 1.
constant SG_FTCH_DESC2QUEUE : integer := max2(C_SG_FTCH_DESC2QUEUE,C_AXIS_IS_ASYNC);
constant SG_UPDT_DESC2QUEUE : integer := max2(C_SG_UPDT_DESC2QUEUE,C_AXIS_IS_ASYNC);



-------------------------------------------------------------------------------
-- Signal / Type Declarations
-------------------------------------------------------------------------------
-- DataMover MM2S Fetch Command Stream Signals
signal s_axis_ftch_cmd_tvalid   : std_logic := '0';
signal s_axis_ftch_cmd_tready   : std_logic := '0';
signal s_axis_ftch_cmd_tdata    : std_logic_vector
                                    (((1+C_ENABLE_MULTI_CHANNEL)*C_M_AXI_SG_ADDR_WIDTH+CMD_BASE_WIDTH)-1 downto 0) := (others => '0');
-- DataMover MM2S Fetch Status Stream Signals
signal m_axis_ftch_sts_tvalid   : std_logic := '0';
signal m_axis_ftch_sts_tready   : std_logic := '0';
signal m_axis_ftch_sts_tdata    : std_logic_vector(7 downto 0) := (others => '0');
signal m_axis_ftch_sts_tkeep    : std_logic_vector(0 downto 0) := (others => '0');
signal mm2s_err                 : std_logic := '0';

-- DataMover MM2S Fetch Stream Signals

signal m_axis_mm2s_tdata        : std_logic_vector
                                    (C_M_AXIS_SG_TDATA_WIDTH-1 downto 0)     := (others => '0');
signal m_axis_mm2s_tkeep        : std_logic_vector
                                    ((C_M_AXIS_SG_TDATA_WIDTH/8)-1 downto 0) := (others => '0');
signal m_axis_mm2s_tlast        : std_logic := '0';
signal m_axis_mm2s_tvalid       : std_logic := '0';
signal m_axis_mm2s_tready       : std_logic := '0';

-- DataMover S2MM Update Command Stream Signals
signal s_axis_updt_cmd_tvalid   : std_logic := '0';
signal s_axis_updt_cmd_tready   : std_logic := '0';
signal s_axis_updt_cmd_tdata    : std_logic_vector
                                    (((1+C_ENABLE_MULTI_CHANNEL)*C_M_AXI_SG_ADDR_WIDTH+CMD_BASE_WIDTH)-1 downto 0) := (others => '0');
-- DataMover S2MM Update Status Stream Signals
signal m_axis_updt_sts_tvalid   : std_logic := '0';
signal m_axis_updt_sts_tready   : std_logic := '0';
signal m_axis_updt_sts_tdata    : std_logic_vector(7 downto 0) := (others => '0');
signal m_axis_updt_sts_tkeep    : std_logic_vector(0 downto 0) := (others => '0');
signal s2mm_err                 : std_logic := '0';

-- DataMover S2MM Update Stream Signals
signal s_axis_s2mm_tdata        : std_logic_vector
                                    (C_M_AXI_SG_DATA_WIDTH-1 downto 0)     := (others => '0');
signal s_axis_s2mm_tkeep        : std_logic_vector
                                    ((C_M_AXI_SG_DATA_WIDTH/8)-1 downto 0) := (others => '1');
signal s_axis_s2mm_tlast        : std_logic := '0';
signal s_axis_s2mm_tvalid       : std_logic := '0';
signal s_axis_s2mm_tready       : std_logic := '0';

-- Channel 1 internals
signal ch1_ftch_active          : std_logic := '0';
signal ch1_ftch_queue_empty     : std_logic := '0';
signal ch1_ftch_queue_full      : std_logic := '0';
signal ch1_nxtdesc_wren         : std_logic := '0';
signal ch1_updt_active          : std_logic := '0';
signal ch1_updt_queue_empty     : std_logic := '0';
signal ch1_updt_curdesc_wren    : std_logic := '0';
signal ch1_updt_curdesc         : std_logic_vector
                                    (C_M_AXI_SG_ADDR_WIDTH-1 downto 0)  := (others => '0');
signal ch1_updt_ioc             : std_logic := '0';
signal ch1_updt_ioc_irq_set_i   : std_logic := '0';
signal ch1_dma_interr           : std_logic := '0';
signal ch1_dma_slverr           : std_logic := '0';
signal ch1_dma_decerr           : std_logic := '0';
signal ch1_dma_interr_set_i     : std_logic := '0';
signal ch1_dma_slverr_set_i     : std_logic := '0';
signal ch1_dma_decerr_set_i     : std_logic := '0';
signal ch1_updt_done            : std_logic := '0';
signal ch1_ftch_pause           : std_logic := '0';


-- Channel 2 internals
signal ch2_ftch_active          : std_logic := '0';
signal ch2_ftch_queue_empty     : std_logic := '0';
signal ch2_ftch_queue_full      : std_logic := '0';
signal ch2_nxtdesc_wren         : std_logic := '0';
signal ch2_updt_active          : std_logic := '0';
signal ch2_updt_queue_empty     : std_logic := '0';
signal ch2_updt_curdesc_wren    : std_logic := '0';
signal ch2_updt_curdesc         : std_logic_vector
                                    (C_M_AXI_SG_ADDR_WIDTH-1 downto 0) := (others => '0');
signal ch2_updt_ioc             : std_logic := '0';
signal ch2_updt_ioc_irq_set_i   : std_logic := '0';
signal ch2_dma_interr           : std_logic := '0';
signal ch2_dma_slverr           : std_logic := '0';
signal ch2_dma_decerr           : std_logic := '0';
signal ch2_dma_interr_set_i     : std_logic := '0';
signal ch2_dma_slverr_set_i     : std_logic := '0';
signal ch2_dma_decerr_set_i     : std_logic := '0';
signal ch2_updt_done            : std_logic := '0';
signal ch2_ftch_pause           : std_logic := '0';

signal nxtdesc                  : std_logic_vector
                                    (C_M_AXI_SG_ADDR_WIDTH-1 downto 0)     := (others => '0');

signal ftch_cmnd_wr             : std_logic := '0';
signal ftch_cmnd_data           : std_logic_vector
                                    ((C_M_AXI_SG_ADDR_WIDTH+CMD_BASE_WIDTH)-1 downto 0) := (others => '0');
signal ftch_stale_desc          : std_logic := '0';
signal ftch_error_i             : std_logic := '0';
signal updt_error_i             : std_logic := '0';

signal ch1_irqthresh_decr       : std_logic := '0'; --CR567661
signal ch2_irqthresh_decr       : std_logic := '0'; --CR567661

signal m_axi_sg_awaddr_int      : std_logic_vector                                  --
                                        (C_M_AXI_SG_ADDR_WIDTH-1 downto 0)  ;               --
signal m_axi_sg_awlen_int       : std_logic_vector(7 downto 0)      ;               --
signal m_axi_sg_awsize_int      : std_logic_vector(2 downto 0)      ;               --
signal m_axi_sg_awburst_int     : std_logic_vector(1 downto 0)      ;               --
signal m_axi_sg_awprot_int      : std_logic_vector(2 downto 0)      ;               --
signal m_axi_sg_awcache_int     : std_logic_vector(3 downto 0)      ;               --
signal m_axi_sg_awuser_int      : std_logic_vector(3 downto 0)      ;               --
signal m_axi_sg_awvalid_int     : std_logic                         ;               --
signal m_axi_sg_awready_int     : std_logic                         ;               --
                                                                                            --
        -- Scatter Gather Write Data Channel                                                --
signal m_axi_sg_wdata_int       : std_logic_vector                                  --
                                        (C_M_AXI_SG_DATA_WIDTH-1 downto 0)  ;               --
signal m_axi_sg_wstrb_int       : std_logic_vector                                  --
                                        ((C_M_AXI_SG_DATA_WIDTH/8)-1 downto 0);             --
signal m_axi_sg_wlast_int       : std_logic                         ;               --
signal m_axi_sg_wvalid_int      : std_logic                         ;               --
signal m_axi_sg_wready_int      : std_logic                         ;               --

signal m_axi_sg_bresp_int       : std_logic_vector (1 downto 0);
signal m_axi_sg_bvalid_int      : std_logic;
signal m_axi_sg_bready_int      : std_logic;
signal m_axi_sg_bvalid_int_del  : std_logic;
signal ch2_eof_detected         : std_logic;
signal s_axis_ch2_updtsts_tready_i : std_logic;
signal ch2_sg_idle, tail_updt_latch : std_logic;
signal tail_updt : std_logic;
signal ch2_taildesc_wren_int : std_logic; 
signal ch2_sg_idle_int : std_logic;
signal ftch_error_addr_1 : std_logic_vector                                  --
                                        (C_M_AXI_SG_ADDR_WIDTH-1 downto 0)  ;         
signal updt_error_addr_1 : std_logic_vector                                  --
                                        (C_M_AXI_SG_ADDR_WIDTH-1 downto 0)  ;         
signal ch1_ftch_interr_set_i : std_logic := '0';
signal ch1_ftch_slverr_set_i : std_logic := '0';
signal ch1_ftch_decerr_set_i : std_logic := '0';

signal ch2_ftch_interr_set_i : std_logic := '0';
signal ch2_ftch_slverr_set_i : std_logic := '0';
signal ch2_ftch_decerr_set_i : std_logic := '0';

signal ch1_updt_interr_set_i : std_logic := '0';
signal ch1_updt_slverr_set_i : std_logic := '0';
signal ch1_updt_decerr_set_i : std_logic := '0';
signal ch2_updt_interr_set_i : std_logic := '0';
signal ch2_updt_slverr_set_i : std_logic := '0';
signal ch2_updt_decerr_set_i : std_logic := '0';



signal ftch_error_capture : std_logic := '0';
signal updt_error_capture : std_logic := '0';

-------------------------------------------------------------------------------
-- Begin architecture logic
-------------------------------------------------------------------------------
begin
updt_error <= updt_error_i;
ftch_error <= ftch_error_i;

ftch_error_capture <= ch1_ftch_interr_set_i or
                      ch1_ftch_slverr_set_i or
                      ch1_ftch_decerr_set_i or 
                      ch2_ftch_interr_set_i or
                      ch2_ftch_slverr_set_i or
                      ch2_ftch_decerr_set_i;

ch1_ftch_interr_set <= ch1_ftch_interr_set_i;
ch1_ftch_slverr_set <= ch1_ftch_slverr_set_i;
ch1_ftch_decerr_set <= ch1_ftch_decerr_set_i;
ch2_ftch_interr_set <= ch2_ftch_interr_set_i;
ch2_ftch_slverr_set <= ch2_ftch_slverr_set_i;
ch2_ftch_decerr_set <= ch2_ftch_decerr_set_i;

updt_error_capture <= ch1_updt_interr_set_i or
                      ch1_updt_slverr_set_i or
                      ch1_updt_decerr_set_i or
                      ch2_updt_interr_set_i or
                      ch2_updt_slverr_set_i or
                      ch2_updt_decerr_set_i or
                      ch2_dma_interr_set_i or
                      ch2_dma_slverr_set_i or
                      ch2_dma_decerr_set_i or
                      ch1_dma_interr_set_i or
                      ch1_dma_slverr_set_i or
                      ch1_dma_decerr_set_i;

ch1_updt_interr_set <=  ch1_updt_interr_set_i;
ch1_updt_slverr_set <=  ch1_updt_slverr_set_i;
ch1_updt_decerr_set <=  ch1_updt_decerr_set_i;
ch2_updt_interr_set <=  ch2_updt_interr_set_i;
ch2_updt_slverr_set <=  ch2_updt_slverr_set_i;
ch2_updt_decerr_set <=  ch2_updt_decerr_set_i;



process (m_axi_sg_aclk)
begin
     if (m_axi_sg_aclk'event and m_axi_sg_aclk = '1') then
        if (m_axi_sg_aresetn = '0') then
           ftch_error_addr (31 downto 6) <= (others => '0');
        elsif (ftch_error_capture = '1') then -- or updt_error_i = '1') then
           ftch_error_addr (31 downto 6)<= ftch_error_addr_1(31 downto 6);
        elsif (updt_error_capture = '1') then
           ftch_error_addr (31 downto 6)<= updt_error_addr_1(31 downto 6);
        end if;
     end if;
end process; 

ADDR_64 : if (C_M_AXI_SG_ADDR_WIDTH > 32) generate
begin

process (m_axi_sg_aclk)
begin
     if (m_axi_sg_aclk'event and m_axi_sg_aclk = '1') then
        if (m_axi_sg_aresetn = '0') then
           ftch_error_addr (63 downto 32) <= (others => '0');
        elsif (ftch_error_capture = '1') then -- or updt_error_i = '1') then
           ftch_error_addr (63 downto 32)<= ftch_error_addr_1(63 downto 32);
        elsif (updt_error_capture = '1') then
           ftch_error_addr (63 downto 32)<= updt_error_addr_1(63 downto 32);
        end if;
     end if;
end process; 

end generate ADDR_64;

 updt_error_addr <= (others => '0');
 ftch_error_addr (5 downto 0) <= (others => '0');

-- Always valid therefore fix to '1'
s_axis_s2mm_tkeep       <= (others => '1');

-- Drive interrupt on complete set out
--ch1_updt_ioc_irq_set    <= ch1_updt_ioc_irq_set_i;  -- CR567661
--ch2_updt_ioc_irq_set    <= ch2_updt_ioc_irq_set_i;  -- CR567661

ch1_dma_interr_set      <= ch1_dma_interr_set_i;
ch1_dma_slverr_set      <= ch1_dma_slverr_set_i;
ch1_dma_decerr_set      <= ch1_dma_decerr_set_i;

ch2_dma_interr_set      <= ch2_dma_interr_set_i;
ch2_dma_slverr_set      <= ch2_dma_slverr_set_i;
ch2_dma_decerr_set      <= ch2_dma_decerr_set_i;

s_axis_ch2_updtsts_tready <= s_axis_ch2_updtsts_tready_i;

EOF_DET : if (C_ENABLE_MULTI_CHANNEL = 1) generate
     ch2_eof_detected        <= s_axis_ch2_updtsts_tdata (26) 
                                and s_axis_ch2_updtsts_tready_i 
                                and s_axis_ch2_updtsts_tvalid 
                                and s_axis_ch2_updtsts_tlast;
  --   ch2_eof_detected        <= '0';

     ch2_sg_idle_int <= ch2_sg_idle;  
  --   ch2_sg_idle_int <= '0'; --ch2_sg_idle;  


    TAILUPDT_LATCH : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0' or tail_updt = '1' ) then  -- nned to have some reset condition here
                    tail_updt <= '0';
                elsif(ch2_sg_idle = '1' and tail_updt_latch = '1' and tail_updt = '0')then
                    tail_updt <= '1';
                end if;
            end if;
        end process TAILUPDT_LATCH;

ch2_taildesc_wren_int <= ch2_taildesc_wren or tail_updt;
--ch2_taildesc_wren_int <= ch2_taildesc_wren;

end generate EOF_DET; 


NOEOF_DET : if (C_ENABLE_MULTI_CHANNEL = 0) generate
                    tail_updt <= '0';
     ch2_eof_detected        <= '0';
     ch2_taildesc_wren_int <= ch2_taildesc_wren;
     ch2_sg_idle_int <= '0'; --ch2_sg_idle;  
end generate NOEOF_DET; 

-------------------------------------------------------------------------------
-- Scatter Gather Fetch Manager
-------------------------------------------------------------------------------
I_SG_FETCH_MNGR : entity  axi_sg_v4_1_2.axi_sg_ftch_mngr
    generic map(
        C_M_AXI_SG_ADDR_WIDTH       => C_M_AXI_SG_ADDR_WIDTH                ,
        C_ENABLE_MULTI_CHANNEL             => C_ENABLE_MULTI_CHANNEL                      ,
        C_INCLUDE_CH1               => C_INCLUDE_CH1                        ,
        C_INCLUDE_CH2               => C_INCLUDE_CH2                        ,
        C_SG_CH1_WORDS_TO_FETCH     => C_SG_CH1_WORDS_TO_FETCH              ,
        C_SG_CH2_WORDS_TO_FETCH     => C_SG_CH2_WORDS_TO_FETCH              ,
        C_SG_CH1_ENBL_STALE_ERROR   => C_SG_CH1_ENBL_STALE_ERROR            ,
        C_SG_CH2_ENBL_STALE_ERROR   => C_SG_CH2_ENBL_STALE_ERROR            ,
        C_SG_FTCH_DESC2QUEUE        => SG_FTCH_DESC2QUEUE
    )
    port map(
        -----------------------------------------------------------------------
        -- AXI Scatter Gather Interface
        -----------------------------------------------------------------------
        m_axi_sg_aclk               => m_axi_sg_aclk                        ,
        m_axi_sg_aresetn            => m_axi_sg_aresetn                     ,

        -- Channel 1 Control and Status
        ch1_run_stop                => ch1_run_stop                         ,
        ch1_desc_flush              => ch1_desc_flush                       ,
        ch1_updt_done               => ch1_updt_done                        ,
        ch1_ftch_idle               => ch1_ftch_idle                        ,
        ch1_ftch_active             => ch1_ftch_active                      ,
        ch1_ftch_interr_set         => ch1_ftch_interr_set_i                  ,
        ch1_ftch_slverr_set         => ch1_ftch_slverr_set_i                  ,
        ch1_ftch_decerr_set         => ch1_ftch_decerr_set_i                  ,
        ch1_ftch_err_early          => ch1_ftch_err_early                   ,
        ch1_ftch_stale_desc         => ch1_ftch_stale_desc                  ,
        ch1_tailpntr_enabled        => ch1_tailpntr_enabled                 ,
        ch1_taildesc_wren           => ch1_taildesc_wren                    ,
        ch1_taildesc                => ch1_taildesc                         ,
        ch1_nxtdesc_wren            => ch1_nxtdesc_wren                     ,
        ch1_curdesc                 => ch1_curdesc                          ,
        ch1_ftch_queue_empty        => ch1_ftch_queue_empty                 ,
        ch1_ftch_queue_full         => ch1_ftch_queue_full                  ,
        ch1_ftch_pause              => ch1_ftch_pause                       ,

        -- Channel 2 Control and Status
        ch2_run_stop                => ch2_run_stop                         ,
        ch2_desc_flush              => ch2_desc_flush                       ,
        ch2_updt_done               => ch2_updt_done                        ,
        ch2_ftch_idle               => ch2_ftch_idle                        ,
        ch2_ftch_active             => ch2_ftch_active                      ,
        ch2_ftch_interr_set         => ch2_ftch_interr_set_i                  ,
        ch2_ftch_slverr_set         => ch2_ftch_slverr_set_i                  ,
        ch2_ftch_decerr_set         => ch2_ftch_decerr_set_i                  ,
        ch2_ftch_err_early          => ch2_ftch_err_early                   ,
        ch2_ftch_stale_desc         => ch2_ftch_stale_desc                  ,
        ch2_tailpntr_enabled        => ch2_tailpntr_enabled                 ,
        ch2_taildesc_wren           => ch2_taildesc_wren_int                    ,
        ch2_taildesc                => ch2_taildesc                         ,
        ch2_nxtdesc_wren            => ch2_nxtdesc_wren                     ,
        ch2_curdesc                 => ch2_curdesc                          ,
        ch2_ftch_queue_empty        => ch2_ftch_queue_empty                 ,
        ch2_ftch_queue_full         => ch2_ftch_queue_full                  ,
        ch2_ftch_pause              => ch2_ftch_pause                       ,
        ch2_eof_detected            => ch2_eof_detected                     , 
        tail_updt                   => tail_updt                            ,
        tail_updt_latch             => tail_updt_latch                      ,
        ch2_sg_idle                 => ch2_sg_idle                          ,   

        nxtdesc                     => nxtdesc                              ,

        -- Read response for detecting slverr, decerr early
        m_axi_sg_rresp              => m_axi_sg_rresp                       ,
        m_axi_sg_rvalid             => m_axi_sg_rvalid                      ,

        -- User Command Interface Ports (AXI Stream)
        s_axis_ftch_cmd_tvalid      => s_axis_ftch_cmd_tvalid               ,
        s_axis_ftch_cmd_tready      => s_axis_ftch_cmd_tready               ,
        s_axis_ftch_cmd_tdata       => s_axis_ftch_cmd_tdata ((C_M_AXI_SG_ADDR_WIDTH+CMD_BASE_WIDTH)-1 downto 0)                ,

        -- User Status Interface Ports (AXI Stream)
        m_axis_ftch_sts_tvalid      => m_axis_ftch_sts_tvalid               ,
        m_axis_ftch_sts_tready      => m_axis_ftch_sts_tready               ,
        m_axis_ftch_sts_tdata       => m_axis_ftch_sts_tdata                ,
        m_axis_ftch_sts_tkeep       => m_axis_ftch_sts_tkeep                ,
        mm2s_err                    => mm2s_err                             ,

        -- DataMover Command
        ftch_cmnd_wr                => ftch_cmnd_wr                         ,
        ftch_cmnd_data              => ftch_cmnd_data                       ,
        ftch_stale_desc             => ftch_stale_desc                      ,
        updt_error                  => updt_error_i                         ,
        ftch_error                  => ftch_error_i                         ,
        ftch_error_addr             => ftch_error_addr_1                    ,
        bd_eq                       => bd_eq
    );

-------------------------------------------------------------------------------
-- Scatter Gather Fetch Queue
-------------------------------------------------------------------------------
I_SG_FETCH_QUEUE : entity  axi_sg_v4_1_2.axi_sg_ftch_q_mngr
    generic map(
        C_M_AXI_SG_ADDR_WIDTH       => C_M_AXI_SG_ADDR_WIDTH                ,
        C_M_AXIS_SG_TDATA_WIDTH     => C_M_AXIS_SG_TDATA_WIDTH              ,
        C_SG_FTCH_DESC2QUEUE        => SG_FTCH_DESC2QUEUE                   ,
        C_SG_CH1_WORDS_TO_FETCH     => C_SG_CH1_WORDS_TO_FETCH              ,
        C_SG_CH2_WORDS_TO_FETCH     => C_SG_CH2_WORDS_TO_FETCH              ,
        C_SG_CH1_ENBL_STALE_ERROR   => C_SG_CH1_ENBL_STALE_ERROR            ,
        C_SG_CH2_ENBL_STALE_ERROR   => C_SG_CH2_ENBL_STALE_ERROR            ,
        C_ENABLE_MULTI_CHANNEL      => C_ENABLE_MULTI_CHANNEL               ,
        C_INCLUDE_CH1               => C_INCLUDE_CH1                        ,
        C_INCLUDE_CH2               => C_INCLUDE_CH2                        ,
        C_AXIS_IS_ASYNC             => C_AXIS_IS_ASYNC                      ,
        C_ASYNC                     => C_ASYNC                      ,
        C_ENABLE_CDMA               => C_ENABLE_CDMA,
        C_ACTUAL_ADDR               => C_ACTUAL_ADDR,
        C_FAMILY                    => C_FAMILY
    )
    port map(
        -----------------------------------------------------------------------
        -- AXI Scatter Gather Interface
        -----------------------------------------------------------------------
        m_axi_sg_aclk               => m_axi_sg_aclk                        ,
        m_axi_mm2s_aclk             => m_axi_mm2s_aclk                      ,
        m_axi_sg_aresetn            => m_axi_sg_aresetn                     ,
        p_reset_n                   => p_reset_n                            ,

        ch2_sg_idle                 => ch2_sg_idle_int                      , 

        -- Channel 1 Control
        ch1_desc_flush              => ch1_desc_flush                       ,
        ch1_cyclic                  => ch1_cyclic                       ,
        ch1_cntrl_strm_stop         => ch1_cntrl_strm_stop                  ,
        ch1_ftch_active             => ch1_ftch_active                      ,
        ch1_nxtdesc_wren            => ch1_nxtdesc_wren                     ,
        ch1_ftch_queue_empty        => ch1_ftch_queue_empty                 ,
        ch1_ftch_queue_full         => ch1_ftch_queue_full                  ,
        ch1_ftch_pause              => ch1_ftch_pause                       ,

        -- Channel 2 Control
        ch2_ftch_active             => ch2_ftch_active                      ,
        ch2_cyclic                  => ch2_cyclic                       ,
        ch2_desc_flush              => ch2_desc_flush                       ,
        ch2_nxtdesc_wren            => ch2_nxtdesc_wren                     ,
        ch2_ftch_queue_empty        => ch2_ftch_queue_empty                 ,
        ch2_ftch_queue_full         => ch2_ftch_queue_full                  ,
        ch2_ftch_pause              => ch2_ftch_pause                       ,

        nxtdesc                     => nxtdesc                              ,

        -- DataMover Command
        ftch_cmnd_wr                => ftch_cmnd_wr                         ,
        ftch_cmnd_data              => ftch_cmnd_data                       ,
        ftch_stale_desc             => ftch_stale_desc                      ,

        -- MM2S Stream In from DataMover
        m_axis_mm2s_tdata           => m_axis_mm2s_tdata                    ,
        m_axis_mm2s_tkeep           => m_axis_mm2s_tkeep                    ,
        m_axis_mm2s_tlast           => m_axis_mm2s_tlast                    ,
        m_axis_mm2s_tvalid          => m_axis_mm2s_tvalid                   ,
        m_axis_mm2s_tready          => m_axis_mm2s_tready                   ,


        -- Channel 1 AXI Fetch Stream Out
        m_axis_ch1_ftch_aclk        => m_axis_ch1_ftch_aclk                 ,
        m_axis_ch1_ftch_tdata       => m_axis_ch1_ftch_tdata                ,
        m_axis_ch1_ftch_tvalid      => m_axis_ch1_ftch_tvalid               ,
        m_axis_ch1_ftch_tready      => m_axis_ch1_ftch_tready               ,
        m_axis_ch1_ftch_tlast       => m_axis_ch1_ftch_tlast                ,

        m_axis_ch1_ftch_tdata_new       => m_axis_ch1_ftch_tdata_new                ,
        m_axis_ch1_ftch_tdata_mcdma_new       => m_axis_ch1_ftch_tdata_mcdma_new                ,
        m_axis_ch1_ftch_tvalid_new      => m_axis_ch1_ftch_tvalid_new               ,
m_axis_ftch1_desc_available => m_axis_ftch1_desc_available,

        m_axis_ch2_ftch_tdata_new       => m_axis_ch2_ftch_tdata_new                ,
        m_axis_ch2_ftch_tdata_mcdma_new       => m_axis_ch2_ftch_tdata_mcdma_new                ,
        m_axis_ch2_ftch_tdata_mcdma_nxt       => m_axis_ch2_ftch_tdata_mcdma_nxt                ,
        m_axis_ch2_ftch_tvalid_new      => m_axis_ch2_ftch_tvalid_new               ,
m_axis_ftch2_desc_available => m_axis_ftch2_desc_available,

        -- Channel 2 AXI Fetch Stream Out
        m_axis_ch2_ftch_aclk        => m_axis_ch2_ftch_aclk                 ,
        m_axis_ch2_ftch_tdata       => m_axis_ch2_ftch_tdata                ,
        m_axis_ch2_ftch_tvalid      => m_axis_ch2_ftch_tvalid               ,
        m_axis_ch2_ftch_tready      => m_axis_ch2_ftch_tready               ,
        m_axis_ch2_ftch_tlast       => m_axis_ch2_ftch_tlast                ,
                
        m_axis_mm2s_cntrl_tdata  => m_axis_mm2s_cntrl_tdata  ,
        m_axis_mm2s_cntrl_tkeep  => m_axis_mm2s_cntrl_tkeep  ,
        m_axis_mm2s_cntrl_tvalid => m_axis_mm2s_cntrl_tvalid ,
        m_axis_mm2s_cntrl_tready => m_axis_mm2s_cntrl_tready ,
        m_axis_mm2s_cntrl_tlast  => m_axis_mm2s_cntrl_tlast

    );

-- Include Scatter Gather Descriptor Update logic
GEN_DESC_UPDATE : if C_INCLUDE_DESC_UPDATE = 1 generate
begin

    -- CR567661
    -- Route update version of IOC set to threshold
    -- counter decrement control
    ch1_irqthresh_decr      <= ch1_updt_ioc_irq_set_i;
    ch2_irqthresh_decr      <= ch2_updt_ioc_irq_set_i;

    -- Drive interrupt on complete set out
    ch1_updt_ioc_irq_set    <= ch1_updt_ioc_irq_set_i;
    ch2_updt_ioc_irq_set    <= ch2_updt_ioc_irq_set_i;

    -------------------------------------------------------------------------------
    -- Scatter Gather Update Manager
    -------------------------------------------------------------------------------
    I_SG_UPDATE_MNGR : entity  axi_sg_v4_1_2.axi_sg_updt_mngr
        generic map(
            C_M_AXI_SG_ADDR_WIDTH       => C_M_AXI_SG_ADDR_WIDTH                ,
            C_INCLUDE_CH1               => C_INCLUDE_CH1                        ,
            C_INCLUDE_CH2               => C_INCLUDE_CH2                        ,
            C_SG_CH1_WORDS_TO_UPDATE    => C_SG_CH1_WORDS_TO_UPDATE             ,
            C_SG_CH1_FIRST_UPDATE_WORD  => C_SG_CH1_FIRST_UPDATE_WORD           ,
            C_SG_CH2_WORDS_TO_UPDATE    => C_SG_CH2_WORDS_TO_UPDATE             ,
            C_SG_CH2_FIRST_UPDATE_WORD  => C_SG_CH2_FIRST_UPDATE_WORD
        )
        port map(
            m_axi_sg_aclk               => m_axi_sg_aclk                        ,
            m_axi_sg_aresetn            => m_axi_sg_aresetn                     ,

            -- Channel 1 Control and Status
            ch1_updt_idle               => ch1_updt_idle                        ,
            ch1_updt_active             => ch1_updt_active                      ,
            ch1_updt_ioc                => ch1_updt_ioc                         ,
            ch1_updt_ioc_irq_set        => ch1_updt_ioc_irq_set_i               ,

            -- Update Descriptor Status
            ch1_dma_interr              => ch1_dma_interr                       ,
            ch1_dma_slverr              => ch1_dma_slverr                       ,
            ch1_dma_decerr              => ch1_dma_decerr                       ,
            ch1_dma_interr_set          => ch1_dma_interr_set_i                 ,
            ch1_dma_slverr_set          => ch1_dma_slverr_set_i                 ,
            ch1_dma_decerr_set          => ch1_dma_decerr_set_i                 ,
            ch1_updt_interr_set         => ch1_updt_interr_set_i                  ,
            ch1_updt_slverr_set         => ch1_updt_slverr_set_i                  ,
            ch1_updt_decerr_set         => ch1_updt_decerr_set_i                  ,
            ch1_updt_queue_empty        => ch1_updt_queue_empty                 ,
            ch1_updt_curdesc_wren       => ch1_updt_curdesc_wren                ,
            ch1_updt_curdesc            => ch1_updt_curdesc                     ,
            ch1_updt_done               => ch1_updt_done                        ,

            -- Channel 2 Control and Status
            ch2_dma_interr              => ch2_dma_interr                       ,
            ch2_dma_slverr              => ch2_dma_slverr                       ,
            ch2_dma_decerr              => ch2_dma_decerr                       ,
            ch2_updt_idle               => ch2_updt_idle                        ,
            ch2_updt_active             => ch2_updt_active                      ,
            ch2_updt_ioc                => ch2_updt_ioc                         ,
            ch2_updt_ioc_irq_set        => ch2_updt_ioc_irq_set_i               ,
            ch2_dma_interr_set          => ch2_dma_interr_set_i                 ,
            ch2_dma_slverr_set          => ch2_dma_slverr_set_i                 ,
            ch2_dma_decerr_set          => ch2_dma_decerr_set_i                 ,
            ch2_updt_interr_set         => ch2_updt_interr_set_i                  ,
            ch2_updt_slverr_set         => ch2_updt_slverr_set_i                  ,
            ch2_updt_decerr_set         => ch2_updt_decerr_set_i                  ,
            ch2_updt_queue_empty        => ch2_updt_queue_empty                 ,
        --    ch2_updt_curdesc_wren       => ch2_updt_curdesc_wren                ,
        --    ch2_updt_curdesc            => ch2_updt_curdesc                     ,
            ch2_updt_done               => ch2_updt_done                        ,

            -- User Command Interface Ports (AXI Stream)
            s_axis_updt_cmd_tvalid      => s_axis_updt_cmd_tvalid               ,
            s_axis_updt_cmd_tready      => s_axis_updt_cmd_tready               ,
            s_axis_updt_cmd_tdata       => s_axis_updt_cmd_tdata ((C_M_AXI_SG_ADDR_WIDTH+CMD_BASE_WIDTH)-1 downto 0)                ,

            -- User Status Interface Ports (AXI Stream)
            m_axis_updt_sts_tvalid      => m_axis_updt_sts_tvalid               ,
            m_axis_updt_sts_tready      => m_axis_updt_sts_tready               ,
            m_axis_updt_sts_tdata       => m_axis_updt_sts_tdata                ,
            m_axis_updt_sts_tkeep       => m_axis_updt_sts_tkeep                ,
            s2mm_err                    => s2mm_err                             ,
            ftch_error                  => ftch_error_i                         ,
            updt_error                  => updt_error_i                         ,
            updt_error_addr             => updt_error_addr_1
        );

    -------------------------------------------------------------------------------
    -- Scatter Gather Update Queue
    -------------------------------------------------------------------------------
    I_SG_UPDATE_QUEUE : entity  axi_sg_v4_1_2.axi_sg_updt_q_mngr
        generic map(
            C_M_AXI_SG_ADDR_WIDTH       => C_M_AXI_SG_ADDR_WIDTH                ,
            C_M_AXI_SG_DATA_WIDTH       => C_M_AXI_SG_DATA_WIDTH                ,
            C_S_AXIS_UPDPTR_TDATA_WIDTH => C_S_AXIS_UPDPTR_TDATA_WIDTH          ,
            C_S_AXIS_UPDSTS_TDATA_WIDTH => C_S_AXIS_UPDSTS_TDATA_WIDTH          ,
            C_SG_UPDT_DESC2QUEUE        => SG_UPDT_DESC2QUEUE                   ,
            C_SG_CH1_WORDS_TO_UPDATE    => C_SG_CH1_WORDS_TO_UPDATE             ,
            C_SG_CH2_WORDS_TO_UPDATE    => C_SG_CH2_WORDS_TO_UPDATE             ,
            C_INCLUDE_CH1               => C_INCLUDE_CH1                        ,
            C_INCLUDE_CH2               => C_INCLUDE_CH2                        ,
            C_AXIS_IS_ASYNC             => C_AXIS_IS_ASYNC                      ,
            C_FAMILY                    => C_FAMILY
        )
        port map(
            -----------------------------------------------------------------------
            -- AXI Scatter Gather Interface
            -----------------------------------------------------------------------
            m_axi_sg_aclk               => m_axi_sg_aclk                        ,
            m_axi_sg_aresetn            => m_axi_sg_aresetn                     ,

            -- Channel 1 Control
            ch1_updt_curdesc_wren       => ch1_updt_curdesc_wren                ,
            ch1_updt_curdesc            => ch1_updt_curdesc                     ,
            ch1_updt_active             => ch1_updt_active                      ,
            ch1_updt_queue_empty        => ch1_updt_queue_empty                 ,
            ch1_updt_ioc                => ch1_updt_ioc                         ,
            ch1_updt_ioc_irq_set        => ch1_updt_ioc_irq_set_i               ,

            -- Channel 1 Update Descriptor Status
            ch1_dma_interr              => ch1_dma_interr                       ,
            ch1_dma_slverr              => ch1_dma_slverr                       ,
            ch1_dma_decerr              => ch1_dma_decerr                       ,
            ch1_dma_interr_set          => ch1_dma_interr_set_i                 ,
            ch1_dma_slverr_set          => ch1_dma_slverr_set_i                 ,
            ch1_dma_decerr_set          => ch1_dma_decerr_set_i                 ,

            -- Channel 2 Control
            ch2_updt_active             => ch2_updt_active                      ,
         --   ch2_updt_curdesc_wren       => ch2_updt_curdesc_wren                ,
         --   ch2_updt_curdesc            => ch2_updt_curdesc                     ,
            ch2_updt_queue_empty        => ch2_updt_queue_empty                 ,
            ch2_updt_ioc                => ch2_updt_ioc                         ,
            ch2_updt_ioc_irq_set        => ch2_updt_ioc_irq_set_i               ,

            -- Channel 2 Update Descriptor Status
            ch2_dma_interr              => ch2_dma_interr                       ,
            ch2_dma_slverr              => ch2_dma_slverr                       ,
            ch2_dma_decerr              => ch2_dma_decerr                       ,
            ch2_dma_interr_set          => ch2_dma_interr_set_i                 ,
            ch2_dma_slverr_set          => ch2_dma_slverr_set_i                 ,
            ch2_dma_decerr_set          => ch2_dma_decerr_set_i                 ,

            -- S2MM Stream Out To DataMover
            s_axis_s2mm_tdata           => s_axis_s2mm_tdata                    ,
            s_axis_s2mm_tlast           => s_axis_s2mm_tlast                    ,
            s_axis_s2mm_tvalid          => s_axis_s2mm_tvalid                   ,
            s_axis_s2mm_tready          => s_axis_s2mm_tready                   ,

            -- Channel 1 AXI Update Stream In
            s_axis_ch1_updt_aclk        => s_axis_ch1_updt_aclk                 ,
            s_axis_ch1_updtptr_tdata    => s_axis_ch1_updtptr_tdata             ,
            s_axis_ch1_updtptr_tvalid   => s_axis_ch1_updtptr_tvalid            ,
            s_axis_ch1_updtptr_tready   => s_axis_ch1_updtptr_tready            ,
            s_axis_ch1_updtptr_tlast    => s_axis_ch1_updtptr_tlast             ,

            s_axis_ch1_updtsts_tdata    => s_axis_ch1_updtsts_tdata             ,
            s_axis_ch1_updtsts_tvalid   => s_axis_ch1_updtsts_tvalid            ,
            s_axis_ch1_updtsts_tready   => s_axis_ch1_updtsts_tready            ,
            s_axis_ch1_updtsts_tlast    => s_axis_ch1_updtsts_tlast             ,

            -- Channel 2 AXI Update Stream In
            s_axis_ch2_updt_aclk        => s_axis_ch2_updt_aclk                 ,
            s_axis_ch2_updtptr_tdata    => s_axis_ch2_updtptr_tdata             ,
            s_axis_ch2_updtptr_tvalid   => s_axis_ch2_updtptr_tvalid            ,
            s_axis_ch2_updtptr_tready   => s_axis_ch2_updtptr_tready            ,
            s_axis_ch2_updtptr_tlast    => s_axis_ch2_updtptr_tlast             ,

            s_axis_ch2_updtsts_tdata    => s_axis_ch2_updtsts_tdata             ,
            s_axis_ch2_updtsts_tvalid   => s_axis_ch2_updtsts_tvalid            ,
            s_axis_ch2_updtsts_tready   => s_axis_ch2_updtsts_tready_i            ,
            s_axis_ch2_updtsts_tlast    => s_axis_ch2_updtsts_tlast
        );

end generate GEN_DESC_UPDATE;

-- Exclude Scatter Gather Descriptor Update logic
GEN_NO_DESC_UPDATE : if C_INCLUDE_DESC_UPDATE = 0 generate
begin

        ch1_updt_idle               <= '1';
        ch1_updt_active             <= '0';
--        ch1_updt_ioc_irq_set        <= '0';--CR#569609
        ch1_updt_interr_set         <= '0';
        ch1_updt_slverr_set         <= '0';
        ch1_updt_decerr_set         <= '0';
        ch1_dma_interr_set_i        <= '0';
        ch1_dma_slverr_set_i        <= '0';
        ch1_dma_decerr_set_i        <= '0';
        ch1_updt_done               <= '1'; -- Always done
        ch2_updt_idle               <= '1';
        ch2_updt_active             <= '0';
--        ch2_updt_ioc_irq_set        <= '0'; --CR#569609
        ch2_updt_interr_set         <= '0';
        ch2_updt_slverr_set         <= '0';
        ch2_updt_decerr_set         <= '0';
        ch2_dma_interr_set_i        <= '0';
        ch2_dma_slverr_set_i        <= '0';
        ch2_dma_decerr_set_i        <= '0';
        ch2_updt_done               <= '1'; -- Always done
        s_axis_updt_cmd_tvalid      <= '0';
        s_axis_updt_cmd_tdata       <= (others => '0');
        m_axis_updt_sts_tready      <= '0';
        updt_error_i                <= '0';
        updt_error_addr             <= (others => '0');
        ch1_updt_curdesc_wren       <= '0';
        ch1_updt_curdesc            <= (others => '0');
        ch1_updt_queue_empty        <= '0';
        ch1_updt_ioc                <= '0';
        ch1_dma_interr              <= '0';
        ch1_dma_slverr              <= '0';
        ch1_dma_decerr              <= '0';
        ch2_updt_curdesc_wren       <= '0';
        ch2_updt_curdesc            <= (others => '0');
        ch2_updt_queue_empty        <= '0';
        ch2_updt_ioc                <= '0';
        ch2_dma_interr              <= '0';
        ch2_dma_slverr              <= '0';
        ch2_dma_decerr              <= '0';
        s_axis_s2mm_tdata           <= (others => '0');
        s_axis_s2mm_tlast           <= '0';
        s_axis_s2mm_tvalid          <= '0';
        s_axis_ch1_updtptr_tready   <= '0';
        s_axis_ch2_updtptr_tready   <= '0';
        s_axis_ch1_updtsts_tready   <= '0';
        s_axis_ch2_updtsts_tready   <= '0';

        -- CR567661
        -- Route packet eof to threshold counter decrement control
        ch1_irqthresh_decr      <= ch1_packet_eof;
        ch2_irqthresh_decr      <= ch2_packet_eof;

        -- Drive interrupt on complete set out
        ch1_updt_ioc_irq_set    <= ch1_packet_eof;
        ch2_updt_ioc_irq_set    <= ch2_packet_eof;


end generate GEN_NO_DESC_UPDATE;

-------------------------------------------------------------------------------
-- Scatter Gather Interrupt Coalescing
-------------------------------------------------------------------------------
GEN_INTERRUPT_LOGIC : if C_INCLUDE_INTRPT = 1 generate
begin
    I_AXI_SG_INTRPT : entity  axi_sg_v4_1_2.axi_sg_intrpt
        generic map(

            C_INCLUDE_CH1              => C_INCLUDE_CH1                     ,
            C_INCLUDE_CH2              => C_INCLUDE_CH2                     ,
            C_INCLUDE_DLYTMR           => C_INCLUDE_DLYTMR                  ,
            C_DLYTMR_RESOLUTION        => C_DLYTMR_RESOLUTION
        )
        port map(

            -- Secondary Clock and Reset
            m_axi_sg_aclk               => m_axi_sg_aclk                    ,
            m_axi_sg_aresetn            => m_axi_sg_aresetn                 ,

            ch1_irqthresh_decr          => ch1_irqthresh_decr               , -- CR567661
            ch1_irqthresh_rstdsbl       => ch1_irqthresh_rstdsbl            , -- CR572013
            ch1_dlyirq_dsble            => ch1_dlyirq_dsble                 ,
            ch1_irqdelay_wren           => ch1_irqdelay_wren                ,
            ch1_irqdelay                => ch1_irqdelay                     ,
            ch1_irqthresh_wren          => ch1_irqthresh_wren               ,
            ch1_irqthresh               => ch1_irqthresh                    ,
            ch1_packet_sof              => ch1_packet_sof                   ,
            ch1_packet_eof              => ch1_packet_eof                   ,
            ch1_ioc_irq_set             => ch1_ioc_irq_set                  ,
            ch1_dly_irq_set             => ch1_dly_irq_set                  ,
            ch1_irqdelay_status         => ch1_irqdelay_status              ,
            ch1_irqthresh_status        => ch1_irqthresh_status             ,

            ch2_irqthresh_decr          => ch2_irqthresh_decr               , -- CR567661
            ch2_irqthresh_rstdsbl       => ch2_irqthresh_rstdsbl            , -- CR572013
            ch2_dlyirq_dsble            => ch2_dlyirq_dsble                 ,
            ch2_irqdelay_wren           => ch2_irqdelay_wren                ,
            ch2_irqdelay                => ch2_irqdelay                     ,
            ch2_irqthresh_wren          => ch2_irqthresh_wren               ,
            ch2_irqthresh               => ch2_irqthresh                    ,
            ch2_packet_sof              => ch2_packet_sof                   ,
            ch2_packet_eof              => ch2_packet_eof                   ,
            ch2_ioc_irq_set             => ch2_ioc_irq_set                  ,
            ch2_dly_irq_set             => ch2_dly_irq_set                  ,
            ch2_irqdelay_status         => ch2_irqdelay_status              ,
            ch2_irqthresh_status        => ch2_irqthresh_status
        );
end generate GEN_INTERRUPT_LOGIC;

GEN_NO_INTRPT_LOGIC : if C_INCLUDE_INTRPT = 0 generate
begin
    ch1_ioc_irq_set         <= '0';
    ch1_dly_irq_set         <= '0';
    ch1_irqdelay_status     <= (others => '0');
    ch1_irqthresh_status    <= (others => '0');

    ch2_ioc_irq_set         <= '0';
    ch2_dly_irq_set         <= '0';
    ch2_irqdelay_status     <= (others => '0');
    ch2_irqthresh_status    <= (others => '0');
end generate GEN_NO_INTRPT_LOGIC;

-------------------------------------------------------------------------------
-- Scatter Gather DataMover Lite
-------------------------------------------------------------------------------
I_SG_AXI_DATAMOVER : entity axi_sg_v4_1_2.axi_sg_datamover
    generic map(
        C_INCLUDE_MM2S              => 2, --INCLUDE_DESC_FETCH,          -- Lite
        C_M_AXI_MM2S_ADDR_WIDTH     => C_M_AXI_SG_ADDR_WIDTH,       -- 32 or 64
        C_M_AXI_MM2S_DATA_WIDTH     => C_M_AXI_SG_DATA_WIDTH,       -- Fixed at 32
        C_M_AXIS_MM2S_TDATA_WIDTH   => C_M_AXI_SG_DATA_WIDTH,       -- Fixed at 32
        C_INCLUDE_MM2S_STSFIFO      => 0,                           -- Exclude
        C_MM2S_STSCMD_FIFO_DEPTH    => 1,                           -- Set to Min
        C_MM2S_STSCMD_IS_ASYNC      => 0,                           -- Synchronous
        C_INCLUDE_MM2S_DRE          => 0,                           -- No DRE
        C_MM2S_BURST_SIZE           => 16,                          -- Set to Min
        C_MM2S_ADDR_PIPE_DEPTH      => 1,                           -- Only 1 outstanding request
        C_MM2S_INCLUDE_SF           => 0,                           -- Exclude Store-and-Forward
    
        C_ENABLE_MULTI_CHANNEL             => C_ENABLE_MULTI_CHANNEL,                           --  
        C_ENABLE_EXTRA_FIELD        => C_ENABLE_EXTRA_FIELD,

        C_INCLUDE_S2MM              => 2, --INCLUDE_DESC_UPDATE,         -- Lite
        C_M_AXI_S2MM_ADDR_WIDTH     => C_M_AXI_SG_ADDR_WIDTH,       -- 32 or 64
        C_M_AXI_S2MM_DATA_WIDTH     => C_M_AXI_SG_DATA_WIDTH,       -- Fixed at 32
        C_S_AXIS_S2MM_TDATA_WIDTH   => C_M_AXI_SG_DATA_WIDTH,       -- Fixed at 32
        C_INCLUDE_S2MM_STSFIFO      => 0,                           -- Exclude
        C_S2MM_STSCMD_FIFO_DEPTH    => 1,                           -- Set to Min
        C_S2MM_STSCMD_IS_ASYNC      => 0,                           -- Synchronous
        C_INCLUDE_S2MM_DRE          => 0,                           -- No DRE
        C_S2MM_BURST_SIZE           => 16,                          -- Set to Min;
        C_S2MM_ADDR_PIPE_DEPTH      => 1,                           -- Only 1 outstanding request
        C_S2MM_INCLUDE_SF           => 0,                           -- Exclude Store-and-Forward
        C_FAMILY                    => C_FAMILY
    )
    port map(
        -- MM2S Primary Clock / Reset input
        m_axi_mm2s_aclk             => m_axi_sg_aclk                        ,
        m_axi_mm2s_aresetn          => dm_resetn                            ,
        mm2s_halt                   => NEVER_HALT                           ,
        mm2s_halt_cmplt             => open                                 ,
        mm2s_err                    => mm2s_err                             ,
        mm2s_allow_addr_req         => ALWAYS_ALLOW                         ,
        mm2s_addr_req_posted        => open                                 ,
        mm2s_rd_xfer_cmplt          => open                                 ,

        sg_ctl                      => sg_ctl                               ,

        -- Memory Map to Stream Command FIFO and Status FIFO I/O --------------
        m_axis_mm2s_cmdsts_aclk     => m_axi_sg_aclk                        ,
        m_axis_mm2s_cmdsts_aresetn  => dm_resetn                            ,

        -- User Command Interface Ports (AXI Stream)
        s_axis_mm2s_cmd_tvalid      => s_axis_ftch_cmd_tvalid               ,
        s_axis_mm2s_cmd_tready      => s_axis_ftch_cmd_tready               ,
        s_axis_mm2s_cmd_tdata       => s_axis_ftch_cmd_tdata                ,

        -- User Status Interface Ports (AXI Stream)
        m_axis_mm2s_sts_tvalid      => m_axis_ftch_sts_tvalid               ,
        m_axis_mm2s_sts_tready      => m_axis_ftch_sts_tready               ,
        m_axis_mm2s_sts_tdata       => m_axis_ftch_sts_tdata                ,
        m_axis_mm2s_sts_tkeep       => m_axis_ftch_sts_tkeep                ,


        -- MM2S AXI Address Channel I/O  --------------------------------------
        m_axi_mm2s_arid             => open                                 ,
        m_axi_mm2s_araddr           => m_axi_sg_araddr                      ,
        m_axi_mm2s_arlen            => m_axi_sg_arlen                       ,
        m_axi_mm2s_arsize           => m_axi_sg_arsize                      ,
        m_axi_mm2s_arburst          => m_axi_sg_arburst                     ,
        m_axi_mm2s_arprot           => m_axi_sg_arprot                      ,
        m_axi_mm2s_arcache          => m_axi_sg_arcache                     ,
        m_axi_mm2s_aruser           => m_axi_sg_aruser                     ,
        m_axi_mm2s_arvalid          => m_axi_sg_arvalid                     ,
        m_axi_mm2s_arready          => m_axi_sg_arready                     ,

        -- MM2S AXI MMap Read Data Channel I/O  -------------------------------
        m_axi_mm2s_rdata            => m_axi_sg_rdata                       ,
        m_axi_mm2s_rresp            => m_axi_sg_rresp                       ,
        m_axi_mm2s_rlast            => m_axi_sg_rlast                       ,
        m_axi_mm2s_rvalid           => m_axi_sg_rvalid                      ,
        m_axi_mm2s_rready           => m_axi_sg_rready                      ,

        -- MM2S AXI Master Stream Channel I/O  --------------------------------
        m_axis_mm2s_tdata           => m_axis_mm2s_tdata                    ,
        m_axis_mm2s_tkeep           => m_axis_mm2s_tkeep                    ,
        m_axis_mm2s_tlast           => m_axis_mm2s_tlast                    ,
        m_axis_mm2s_tvalid          => m_axis_mm2s_tvalid                   ,
        m_axis_mm2s_tready          => m_axis_mm2s_tready                   ,


        -- Testing Support I/O
        mm2s_dbg_sel                => (others => '0')                      ,
        mm2s_dbg_data               => open                                 ,

        -- S2MM Primary Clock/Reset input
        m_axi_s2mm_aclk             => m_axi_sg_aclk                        ,
        m_axi_s2mm_aresetn          => dm_resetn                            ,
        s2mm_halt                   => NEVER_HALT                           ,
        s2mm_halt_cmplt             => open                                 ,
        s2mm_err                    => s2mm_err                             ,
        s2mm_allow_addr_req         => ALWAYS_ALLOW                         ,
        s2mm_addr_req_posted        => open                                 ,
        s2mm_wr_xfer_cmplt          => open                                 ,
        s2mm_ld_nxt_len             => open                                 ,
        s2mm_wr_len                 => open                                 ,

        -- Stream to Memory Map Command FIFO and Status FIFO I/O --------------
        m_axis_s2mm_cmdsts_awclk    => m_axi_sg_aclk                        ,
        m_axis_s2mm_cmdsts_aresetn  => dm_resetn                            ,

        -- User Command Interface Ports (AXI Stream)
        s_axis_s2mm_cmd_tvalid      => s_axis_updt_cmd_tvalid               ,
        s_axis_s2mm_cmd_tready      => s_axis_updt_cmd_tready               ,
        s_axis_s2mm_cmd_tdata       => s_axis_updt_cmd_tdata                ,

        -- User Status Interface Ports (AXI Stream)
        m_axis_s2mm_sts_tvalid      => m_axis_updt_sts_tvalid               ,
        m_axis_s2mm_sts_tready      => m_axis_updt_sts_tready               ,
        m_axis_s2mm_sts_tdata       => m_axis_updt_sts_tdata                ,
        m_axis_s2mm_sts_tkeep       => m_axis_updt_sts_tkeep                ,

        -- S2MM AXI Address Channel I/O  --------------------------------------
        m_axi_s2mm_awid             => open                                 ,
        m_axi_s2mm_awaddr           => m_axi_sg_awaddr_int                      ,
        m_axi_s2mm_awlen            => m_axi_sg_awlen_int                      ,
        m_axi_s2mm_awsize           => m_axi_sg_awsize_int                      ,
        m_axi_s2mm_awburst          => m_axi_sg_awburst_int                     ,
        m_axi_s2mm_awprot           => m_axi_sg_awprot_int                     ,
        m_axi_s2mm_awcache          => m_axi_sg_awcache_int                     ,
        m_axi_s2mm_awuser           => m_axi_sg_awuser_int                       ,
        m_axi_s2mm_awvalid          => m_axi_sg_awvalid_int                    ,
        m_axi_s2mm_awready          => m_axi_sg_awready_int                     ,

        -- S2MM AXI MMap Write Data Channel I/O  ------------------------------
        m_axi_s2mm_wdata            => m_axi_sg_wdata                       ,
        m_axi_s2mm_wstrb            => m_axi_sg_wstrb                       ,
        m_axi_s2mm_wlast            => m_axi_sg_wlast                       ,
        m_axi_s2mm_wvalid           => m_axi_sg_wvalid_int                      ,
        m_axi_s2mm_wready           => m_axi_sg_wready_int                      ,

        -- S2MM AXI MMap Write response Channel I/O  --------------------------
        m_axi_s2mm_bresp            => m_axi_sg_bresp_int                       ,
        m_axi_s2mm_bvalid           => m_axi_sg_bvalid_int                      ,
        m_axi_s2mm_bready           => m_axi_sg_bready_int                      ,

        -- S2MM AXI Slave Stream Channel I/O  ---------------------------------
        s_axis_s2mm_tdata           => s_axis_s2mm_tdata                    ,
        s_axis_s2mm_tkeep           => s_axis_s2mm_tkeep                    ,
        s_axis_s2mm_tlast           => s_axis_s2mm_tlast                    ,
        s_axis_s2mm_tvalid          => s_axis_s2mm_tvalid                   ,
        s_axis_s2mm_tready          => s_axis_s2mm_tready                   ,

        -- Testing Support I/O
        s2mm_dbg_sel                  => (others => '0')                    ,
        s2mm_dbg_data                 => open
    );

--ENABLE_MM2S_STATUS: if (C_NUM_MM2S_CHANNELS = 1) generate 
-- begin
 m_axi_sg_awaddr <= m_axi_sg_awaddr_int ;
 m_axi_sg_awlen <= m_axi_sg_awlen_int  ;
 m_axi_sg_awsize <= m_axi_sg_awsize_int ;
 m_axi_sg_awburst <= m_axi_sg_awburst_int;
 m_axi_sg_awprot <= m_axi_sg_awprot_int ;
 m_axi_sg_awcache <= m_axi_sg_awcache_int;
 m_axi_sg_awuser <= m_axi_sg_awuser_int ;
 m_axi_sg_awvalid <= m_axi_sg_awvalid_int;
 m_axi_sg_awready_int <= m_axi_sg_awready;

 m_axi_sg_wvalid <= m_axi_sg_wvalid_int;
 m_axi_sg_wready_int <= m_axi_sg_wready;

 m_axi_sg_bresp_int <= m_axi_sg_bresp;
 m_axi_sg_bvalid_int <= m_axi_sg_bvalid;
 m_axi_sg_bready <= m_axi_sg_bready_int; 

-- end generate ENABLE_MM2S_STATUS;


--DISABLE_MM2S_STATUS: if (C_NUM_MM2S_CHANNELS > 1) generate 
--
-- m_axi_sg_awaddr <= (others => '0') when ch1_updt_active = '1' else m_axi_sg_awaddr_int;
-- m_axi_sg_awlen <=  (others => '0') when ch1_updt_active = '1' else m_axi_sg_awlen_int;
-- m_axi_sg_awsize <=  (others => '0') when ch1_updt_active = '1' else m_axi_sg_awsize_int;
-- m_axi_sg_awburst <= (others => '0') when ch1_updt_active = '1' else m_axi_sg_awburst_int;
-- m_axi_sg_awprot <=  (others => '0') when ch1_updt_active = '1' else m_axi_sg_awprot_int;
-- m_axi_sg_awcache <= (others => '0') when ch1_updt_active = '1' else m_axi_sg_awcache_int;
-- m_axi_sg_awuser <=  (others => '0') when ch1_updt_active = '1' else m_axi_sg_awuser_int;
-- m_axi_sg_awvalid <= '0' when ch1_updt_active = '1' else m_axi_sg_awvalid_int;
-- m_axi_sg_awready_int <=  m_axi_sg_awvalid_int when ch1_updt_active = '1' else m_axi_sg_awready; -- to make sure that AXI logic is fine.
--
-- m_axi_sg_wvalid <= '0' when ch1_updt_active = '1' else m_axi_sg_wvalid_int;
-- m_axi_sg_wready_int <= m_axi_sg_wvalid_int when ch1_updt_active = '1' else m_axi_sg_wready; -- to make sure that AXI logic is fine
--
-- m_axi_sg_bresp_int <= m_axi_sg_bresp;
-- m_axi_sg_bvalid_int <= m_axi_sg_bvalid_int_del when ch1_updt_active = '1' else m_axi_sg_bvalid;
-- m_axi_sg_bready <= m_axi_sg_bready_int;
--
 ch2_update_active <= ch2_updt_active;
-- 
---- A dummy response is needed to keep things running on DMA side
-- PROC_DUMMY_RESP : process (m_axi_sg_aclk)
--    begin
--        if (dm_resetn = '0') then
--            m_axi_sg_bvalid_int_del <= '0';
--        elsif (m_axi_sg_aclk'event and m_axi_sg_aclk = '1') then
--            m_axi_sg_bvalid_int_del <= m_axi_sg_wvalid_int;
--        end if;
--    end process PROC_DUMMY_RESP;
--
-- end generate DISABLE_MM2S_STATUS;


end implementation;
