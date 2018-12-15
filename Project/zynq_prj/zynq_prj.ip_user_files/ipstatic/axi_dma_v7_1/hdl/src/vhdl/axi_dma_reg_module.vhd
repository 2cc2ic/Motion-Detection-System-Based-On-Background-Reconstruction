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
-- Filename:          axi_dma_reg_module.vhd
-- Description: This entity is AXI DMA Register Module Top Level
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

library lib_cdc_v1_0_2;
library axi_dma_v7_1_8;
use axi_dma_v7_1_8.axi_dma_pkg.all;

-------------------------------------------------------------------------------
entity  axi_dma_reg_module is
    generic(
        C_INCLUDE_MM2S              : integer range 0 to 1      := 1        ;
        C_INCLUDE_S2MM              : integer range 0 to 1      := 1        ;
        C_INCLUDE_SG                : integer range 0 to 1      := 1        ;
        C_SG_LENGTH_WIDTH           : integer range 8 to 23     := 14       ;
        C_AXI_LITE_IS_ASYNC         : integer range 0 to 1      := 0        ;
        C_S_AXI_LITE_ADDR_WIDTH     : integer range 2 to 32    := 32       ;
        C_S_AXI_LITE_DATA_WIDTH     : integer range 32 to 32    := 32       ;
        C_M_AXI_SG_ADDR_WIDTH       : integer range 32 to 64    := 32       ;
        C_M_AXI_MM2S_ADDR_WIDTH     : integer range 32 to 64    := 32       ;
        C_M_AXI_S2MM_ADDR_WIDTH     : integer range 32 to 64    := 32       ;
        C_NUM_S2MM_CHANNELS         : integer range 1 to 16     := 1        ;
        C_MICRO_DMA                 : integer range 0 to 1      := 0        ;
        C_ENABLE_MULTI_CHANNEL             : integer range 0 to 1      := 0

    );
    port (
        -----------------------------------------------------------------------
        -- AXI Lite Control Interface
        -----------------------------------------------------------------------
        m_axi_sg_aclk               : in  std_logic                         ;                   --
        m_axi_sg_aresetn            : in  std_logic                         ;                   --
        m_axi_sg_hrdresetn          : in  std_logic                         ;                   --
                                                                                                --
        s_axi_lite_aclk             : in  std_logic                         ;                   --
        axi_lite_reset_n            : in  std_logic                         ;                   --
                                                                                                --
        -- AXI Lite Write Address Channel                                                       --
        s_axi_lite_awvalid          : in  std_logic                         ;                   --
        s_axi_lite_awready          : out std_logic                         ;                   --
        s_axi_lite_awaddr           : in  std_logic_vector                                      --
                                        (C_S_AXI_LITE_ADDR_WIDTH-1 downto 0);                   --
                                                                                                --
        -- AXI Lite Write Data Channel                                                          --
        s_axi_lite_wvalid           : in  std_logic                         ;                   --
        s_axi_lite_wready           : out std_logic                         ;                   --
        s_axi_lite_wdata            : in  std_logic_vector                                      --
                                        (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);                   --
                                                                                                --
        -- AXI Lite Write Response Channel                                                      --
        s_axi_lite_bresp            : out std_logic_vector(1 downto 0)      ;                   --
        s_axi_lite_bvalid           : out std_logic                         ;                   --
        s_axi_lite_bready           : in  std_logic                         ;                   --
                                                                                                --
        -- AXI Lite Read Address Channel                                                        --
        s_axi_lite_arvalid          : in  std_logic                         ;                   --
        s_axi_lite_arready          : out std_logic                         ;                   --
        s_axi_lite_araddr           : in  std_logic_vector                                      --
                                        (C_S_AXI_LITE_ADDR_WIDTH-1 downto 0);                   --
        s_axi_lite_rvalid           : out std_logic                         ;                   --
        s_axi_lite_rready           : in  std_logic                         ;                   --
        s_axi_lite_rdata            : out std_logic_vector                                      --
                                        (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);                   --
        s_axi_lite_rresp            : out std_logic_vector(1 downto 0)      ;                   --
                                                                                                --
                                                                                                --
        -- MM2S Signals                                                                         --
        mm2s_stop                   : in  std_logic                         ;                   --
        mm2s_halted_clr             : in  std_logic                         ;                   --
        mm2s_halted_set             : in  std_logic                         ;                   --
        mm2s_idle_set               : in  std_logic                         ;                   --
        mm2s_idle_clr               : in  std_logic                         ;                   --
        mm2s_dma_interr_set         : in  std_logic                         ;                   --
        mm2s_dma_slverr_set         : in  std_logic                         ;                   --
        mm2s_dma_decerr_set         : in  std_logic                         ;                   --
        mm2s_ioc_irq_set            : in  std_logic                         ;                   --
        mm2s_dly_irq_set            : in  std_logic                         ;                   --
        mm2s_irqdelay_status        : in  std_logic_vector(7 downto 0)      ;                   --
        mm2s_irqthresh_status       : in  std_logic_vector(7 downto 0)      ;                   --
        mm2s_ftch_interr_set        : in  std_logic                         ;                   --
        mm2s_ftch_slverr_set        : in  std_logic                         ;                   --
        mm2s_ftch_decerr_set        : in  std_logic                         ;                   --
        mm2s_updt_interr_set        : in  std_logic                         ;                   --
        mm2s_updt_slverr_set        : in  std_logic                         ;                   --
        mm2s_updt_decerr_set        : in  std_logic                         ;                   --
        mm2s_new_curdesc_wren       : in  std_logic                         ;                   --
        mm2s_new_curdesc            : in  std_logic_vector                                      --
                                        (C_M_AXI_SG_ADDR_WIDTH-1 downto 0)  ;                   --
        mm2s_dlyirq_dsble           : out std_logic                         ; -- CR605888       --
        mm2s_irqthresh_rstdsbl      : out std_logic                         ; -- CR572013       --
        mm2s_irqthresh_wren         : out std_logic                         ;                   --
        mm2s_irqdelay_wren          : out std_logic                         ;                   --
        mm2s_tailpntr_updated       : out std_logic                         ;                   --
        mm2s_dmacr                  : out std_logic_vector                                      --
                                        (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);                   --
        mm2s_dmasr                  : out std_logic_vector                                      --
                                        (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);                   --
        mm2s_curdesc                : out std_logic_vector                                      --
                                        (C_M_AXI_SG_ADDR_WIDTH-1 downto 0)  ;                   --
        mm2s_taildesc               : out std_logic_vector                                      --
                                        (C_M_AXI_SG_ADDR_WIDTH-1 downto 0)  ;                   --
        mm2s_sa                     : out std_logic_vector                                      --
                                        (C_M_AXI_SG_ADDR_WIDTH-1 downto 0);                   --
        mm2s_length                 : out std_logic_vector                                      --
                                        (C_SG_LENGTH_WIDTH-1 downto 0)      ;                   --
        mm2s_length_wren            : out std_logic                         ;                   --
                                                                                                --
        -- S2MM Signals                                                                         --
        tdest_in                    : in std_logic_vector (6 downto 0)      ;
        same_tdest_in               : in std_logic;
        sg_ctl                      : out std_logic_vector (7 downto 0)     ;

        s2mm_sof                    : in  std_logic                         ;
        s2mm_eof                    : in  std_logic                         ;
        s2mm_stop                   : in  std_logic                         ;                   --
        s2mm_halted_clr             : in  std_logic                         ;                   --
        s2mm_halted_set             : in  std_logic                         ;                   --
        s2mm_idle_set               : in  std_logic                         ;                   --
        s2mm_idle_clr               : in  std_logic                         ;                   --
        s2mm_dma_interr_set         : in  std_logic                         ;                   --
        s2mm_dma_slverr_set         : in  std_logic                         ;                   --
        s2mm_dma_decerr_set         : in  std_logic                         ;                   --
        s2mm_ioc_irq_set            : in  std_logic                         ;                   --
        s2mm_dly_irq_set            : in  std_logic                         ;                   --
        s2mm_irqdelay_status        : in  std_logic_vector(7 downto 0)      ;                   --
        s2mm_irqthresh_status       : in  std_logic_vector(7 downto 0)      ;                   --
        s2mm_ftch_interr_set        : in  std_logic                         ;                   --
        s2mm_ftch_slverr_set        : in  std_logic                         ;                   --
        s2mm_ftch_decerr_set        : in  std_logic                         ;                   --
        s2mm_updt_interr_set        : in  std_logic                         ;                   --
        s2mm_updt_slverr_set        : in  std_logic                         ;                   --
        s2mm_updt_decerr_set        : in  std_logic                         ;                   --
        s2mm_new_curdesc_wren       : in  std_logic                         ;                   --
        s2mm_new_curdesc            : in  std_logic_vector                                      --
                                        (C_M_AXI_SG_ADDR_WIDTH-1 downto 0)  ;                   --
        s2mm_tvalid                 : in std_logic;
        s2mm_dlyirq_dsble           : out std_logic                         ; -- CR605888       --
        s2mm_irqthresh_rstdsbl      : out std_logic                         ; -- CR572013       --
        s2mm_irqthresh_wren         : out std_logic                         ;                   --
        s2mm_irqdelay_wren          : out std_logic                         ;                   --
        s2mm_tailpntr_updated       : out std_logic                         ;                   --
        s2mm_tvalid_latch           : out std_logic                         ;
        s2mm_tvalid_latch_del           : out std_logic                         ;
        s2mm_dmacr                  : out std_logic_vector                                      --
                                        (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);                   --
        s2mm_dmasr                  : out std_logic_vector                                      --
                                        (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);                   --
        s2mm_curdesc                : out std_logic_vector                                      --
                                        (C_M_AXI_SG_ADDR_WIDTH-1 downto 0)  ;                   --
        s2mm_taildesc               : out std_logic_vector                                      --
                                        (C_M_AXI_SG_ADDR_WIDTH-1 downto 0)  ;                   --
        s2mm_da                     : out std_logic_vector                                      --
                                        (C_M_AXI_SG_ADDR_WIDTH-1 downto 0);                   --
        s2mm_length                 : out std_logic_vector                                      --
                                        (C_SG_LENGTH_WIDTH-1 downto 0)      ;                   --
        s2mm_length_wren            : out std_logic                         ;                   --
        s2mm_bytes_rcvd             : in  std_logic_vector                                      --
                                        (C_SG_LENGTH_WIDTH-1 downto 0)      ;                   --
        s2mm_bytes_rcvd_wren        : in  std_logic                         ;                   --
                                                                                                --
        soft_reset                  : out std_logic                         ;                   --
        soft_reset_clr              : in  std_logic                         ;                   --
                                                                                                --
        -- Fetch/Update error addresses                                                         --
        ftch_error_addr             : in  std_logic_vector                                      --
                                        (C_M_AXI_SG_ADDR_WIDTH-1 downto 0)  ;                   --
        updt_error_addr             : in  std_logic_vector                                      --
                                        (C_M_AXI_SG_ADDR_WIDTH-1 downto 0)  ;                   --
        mm2s_introut                : out std_logic                         ;                   --
        s2mm_introut                : out std_logic                         ;                    --
        bd_eq                       : in std_logic


    );
end axi_dma_reg_module;

-------------------------------------------------------------------------------
-- Architecture
-------------------------------------------------------------------------------
architecture implementation of axi_dma_reg_module is
  attribute DowngradeIPIdentifiedWarnings: string;
  attribute DowngradeIPIdentifiedWarnings of implementation : architecture is "yes";

  ATTRIBUTE async_reg                      : STRING;


-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------

-- No Functions Declared

-------------------------------------------------------------------------------
-- Constants Declarations
-------------------------------------------------------------------------------
constant LENGTH_PAD_WIDTH   : integer := C_S_AXI_LITE_DATA_WIDTH - C_SG_LENGTH_WIDTH;
constant LENGTH_PAD         : std_logic_vector(LENGTH_PAD_WIDTH-1 downto 0) := (others => '0');

constant ZERO_BYTES         : std_logic_vector(C_SG_LENGTH_WIDTH-1 downto 0) := (others => '0');
constant NUM_REG_PER_S2MM_INT : integer := NUM_REG_PER_CHANNEL + ((NUM_REG_PER_S2MM+1)*C_ENABLE_MULTI_CHANNEL);

-- Specifies to axi_dma_register which block belongs to S2MM channel
-- so simple dma s2mm_da register offset can be correctly assigned
-- CR603034
--constant NOT_S2MM_CHANNEL   : integer := 0;
--constant IS_S2MM_CHANNEL    : integer := 1;

-------------------------------------------------------------------------------
-- Signal / Type Declarations
-------------------------------------------------------------------------------
signal axi2ip_wrce          : std_logic_vector(23+(121*C_ENABLE_MULTI_CHANNEL) - 1 downto 0)      := (others => '0');
signal axi2ip_wrdata        : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal axi2ip_rdce          : std_logic_vector(23+(121*C_ENABLE_MULTI_CHANNEL) - 1 downto 0)      := (others => '0');
signal axi2ip_rdaddr        : std_logic_vector(C_S_AXI_LITE_ADDR_WIDTH-1 downto 0) := (others => '0');
signal ip2axi_rddata        : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');

signal mm2s_dmacr_i         : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal mm2s_dmasr_i         : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal mm2s_curdesc_lsb_i   : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal mm2s_curdesc_msb_i   : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal mm2s_taildesc_lsb_i  : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal mm2s_taildesc_msb_i  : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal mm2s_sa_i            : std_logic_vector(C_M_AXI_SG_ADDR_WIDTH-1 downto 0) := (others => '0');
signal mm2s_length_i        : std_logic_vector(C_SG_LENGTH_WIDTH-1 downto 0) := (others => '0');
signal mm2s_error_in        : std_logic := '0';
signal mm2s_error_out       : std_logic := '0';

signal s2mm_curdesc_int     : std_logic_vector                                      --
                                        (C_M_AXI_SG_ADDR_WIDTH-1 downto 0)  ;                   --
signal s2mm_taildesc_int    : std_logic_vector                                      --
                                        (C_M_AXI_SG_ADDR_WIDTH-1 downto 0)  ;                   --

signal s2mm_curdesc_int2     : std_logic_vector                                      --
                                        (C_M_AXI_SG_ADDR_WIDTH-1 downto 0)  ;                   --
signal s2mm_taildesc_int2    : std_logic_vector                                      --
                                        (C_M_AXI_SG_ADDR_WIDTH-1 downto 0)  ;                   --
signal s2mm_taildesc_int3    : std_logic_vector                                      --
                                        (C_M_AXI_SG_ADDR_WIDTH-1 downto 0)  ;                   --
signal s2mm_dmacr_i         : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_dmasr_i         : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_curdesc_lsb_i   : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_curdesc_msb_i   : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_taildesc_lsb_i  : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_taildesc_msb_i  : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');

signal s2mm_curdesc1_lsb_i   : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_curdesc1_msb_i   : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_taildesc1_lsb_i  : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_taildesc1_msb_i  : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');

signal s2mm_curdesc2_lsb_i   : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_curdesc2_msb_i   : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_taildesc2_lsb_i  : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_taildesc2_msb_i  : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');

signal s2mm_curdesc3_lsb_i   : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_curdesc3_msb_i   : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_taildesc3_lsb_i  : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_taildesc3_msb_i  : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');

signal s2mm_curdesc4_lsb_i   : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_curdesc4_msb_i   : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_taildesc4_lsb_i  : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_taildesc4_msb_i  : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');

signal s2mm_curdesc5_lsb_i   : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_curdesc5_msb_i   : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_taildesc5_lsb_i  : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_taildesc5_msb_i  : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');

signal s2mm_curdesc6_lsb_i   : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_curdesc6_msb_i   : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_taildesc6_lsb_i  : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_taildesc6_msb_i  : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');

signal s2mm_curdesc7_lsb_i   : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_curdesc7_msb_i   : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_taildesc7_lsb_i  : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_taildesc7_msb_i  : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');

signal s2mm_curdesc8_lsb_i   : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_curdesc8_msb_i   : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_taildesc8_lsb_i  : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_taildesc8_msb_i  : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');

signal s2mm_curdesc9_lsb_i   : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_curdesc9_msb_i   : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_taildesc9_lsb_i  : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_taildesc9_msb_i  : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');

signal s2mm_curdesc10_lsb_i   : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_curdesc10_msb_i   : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_taildesc10_lsb_i  : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_taildesc10_msb_i  : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');

signal s2mm_curdesc11_lsb_i   : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_curdesc11_msb_i   : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_taildesc11_lsb_i  : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_taildesc11_msb_i  : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');

signal s2mm_curdesc12_lsb_i   : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_curdesc12_msb_i   : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_taildesc12_lsb_i  : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_taildesc12_msb_i  : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');

signal s2mm_curdesc13_lsb_i   : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_curdesc13_msb_i   : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_taildesc13_lsb_i  : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_taildesc13_msb_i  : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');

signal s2mm_curdesc14_lsb_i   : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_curdesc14_msb_i   : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_taildesc14_lsb_i  : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_taildesc14_msb_i  : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');

signal s2mm_curdesc15_lsb_i   : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_curdesc15_msb_i   : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_taildesc15_lsb_i  : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_taildesc15_msb_i  : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');

signal s2mm_curdesc_lsb_muxed   : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_curdesc_msb_muxed   : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_taildesc_lsb_muxed  : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal s2mm_taildesc_msb_muxed  : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');

signal s2mm_da_i            : std_logic_vector(C_M_AXI_SG_ADDR_WIDTH-1 downto 0) := (others => '0');
signal s2mm_length_i        : std_logic_vector(C_SG_LENGTH_WIDTH-1 downto 0) := (others => '0');
signal s2mm_error_in        : std_logic := '0';
signal s2mm_error_out       : std_logic := '0';

signal read_addr            : std_logic_vector(9 downto 0) := (others => '0');

signal mm2s_introut_i_cdc_from       : std_logic := '0';
signal mm2s_introut_d1_cdc_tig      : std_logic := '0';
signal mm2s_introut_to      : std_logic := '0';
signal s2mm_introut_i_cdc_from       : std_logic := '0';
signal s2mm_introut_d1_cdc_tig      : std_logic := '0';
signal s2mm_introut_to      : std_logic := '0';

signal mm2s_sgctl           : std_logic_vector (7 downto 0);
signal s2mm_sgctl           : std_logic_vector (7 downto 0);

signal or_sgctl            : std_logic_vector (7 downto 0);

signal open_window, wren          : std_logic;
signal s2mm_tailpntr_updated_int  : std_logic;
signal s2mm_tailpntr_updated_int1  : std_logic;
signal s2mm_tailpntr_updated_int2  : std_logic;
signal s2mm_tailpntr_updated_int3  : std_logic;


signal tvalid_int : std_logic;
signal tvalid_int1 : std_logic;
signal tvalid_int2 : std_logic;
signal new_tdest : std_logic;
signal tvalid_latch : std_logic;

signal tdest_changed : std_logic;
signal tdest_fix  : std_logic_vector (4 downto 0);

signal same_tdest_int1 : std_logic;
signal same_tdest_int2 : std_logic;
signal same_tdest_int3 : std_logic;
signal same_tdest_arrived : std_logic;

signal s2mm_msb_sa : std_logic_vector (31 downto 0);
signal mm2s_msb_sa : std_logic_vector (31 downto 0);

  --ATTRIBUTE async_reg OF mm2s_introut_d1_cdc_tig  : SIGNAL IS "true";
  --ATTRIBUTE async_reg OF s2mm_introut_d1_cdc_tig  : SIGNAL IS "true";
  --ATTRIBUTE async_reg OF mm2s_introut_to  : SIGNAL IS "true";
  --ATTRIBUTE async_reg OF s2mm_introut_to  : SIGNAL IS "true";
-------------------------------------------------------------------------------
-- Begin architecture logic
-------------------------------------------------------------------------------
begin

or_sgctl        <= mm2s_sgctl or s2mm_sgctl;
sg_ctl          <= mm2s_sgctl or s2mm_sgctl;
mm2s_dmacr      <= mm2s_dmacr_i;        -- MM2S DMA Control Register
mm2s_dmasr      <= mm2s_dmasr_i;        -- MM2S DMA Status Register
mm2s_sa         <= mm2s_sa_i;           -- MM2S Source Address (Simple Only)
mm2s_length     <= mm2s_length_i;       -- MM2S Length (Simple Only)

s2mm_dmacr      <= s2mm_dmacr_i;        -- S2MM DMA Control Register
s2mm_dmasr      <= s2mm_dmasr_i;        -- S2MM DMA Status Register
s2mm_da         <= s2mm_da_i;           -- S2MM Destination Address (Simple Only)
s2mm_length     <= s2mm_length_i;       -- S2MM Length (Simple Only)

-- Soft reset set in mm2s DMACR or s2MM DMACR
soft_reset      <= mm2s_dmacr_i(DMACR_RESET_BIT)
                or s2mm_dmacr_i(DMACR_RESET_BIT);

-- CR572013 - added to match legacy SDMA operation
mm2s_irqthresh_rstdsbl <= not mm2s_dmacr_i(DMACR_DLY_IRQEN_BIT);
s2mm_irqthresh_rstdsbl <= not s2mm_dmacr_i(DMACR_DLY_IRQEN_BIT);




--GEN_S2MM_TDEST : if (C_NUM_S2MM_CHANNELS > 1) generate
GEN_S2MM_TDEST : if (C_ENABLE_MULTI_CHANNEL = 1 and C_INCLUDE_S2MM = 1) generate
begin
   PROC_WREN : process (m_axi_sg_aclk)
          begin
               if (m_axi_sg_aclk'event and m_axi_sg_aclk = '1') then
                   if (m_axi_sg_aresetn = '0') then
                     s2mm_taildesc_int3 <= (others => '0');  
                     s2mm_tailpntr_updated_int <= '0';
                     s2mm_tailpntr_updated_int2 <= '0';
                     s2mm_tailpntr_updated <= '0';
                   else -- (m_axi_sg_aclk'event and m_axi_sg_aclk = '1') then
                 --    s2mm_tailpntr_updated_int <= new_tdest or same_tdest_arrived;
                 --    s2mm_tailpntr_updated_int2 <= s2mm_tailpntr_updated_int;
                 --    s2mm_tailpntr_updated <= s2mm_tailpntr_updated_int2;
 
                 -- Commenting this code as it is causing SG to start early
                     s2mm_tailpntr_updated_int <= new_tdest or s2mm_tailpntr_updated_int1 or (same_tdest_arrived and (not bd_eq));
                     s2mm_tailpntr_updated_int2 <= s2mm_tailpntr_updated_int;
                     s2mm_tailpntr_updated <= s2mm_tailpntr_updated_int2;
                   end if;
                end if;
          end process PROC_WREN; 

          -- this is always '1' as MCH needs to have all desc reg programmed before hand
 
--s2mm_tailpntr_updated_int3_i <= s2mm_tailpntr_updated_int2_i and (not s2mm_tailpntr_updated_int_i); -- and tvalid_latch; 

           tdest_fix <= "11111";


    new_tdest <= tvalid_int1 xor tvalid_int2;  

   process (m_axi_sg_aclk)
   begin
        if (m_axi_sg_aclk'event and m_axi_sg_aclk = '1') then
           if (m_axi_sg_aresetn = '0') then
              tvalid_int <= '0';
              tvalid_int1 <= '0';
              tvalid_int2 <= '0';
              tvalid_latch <= '0';
           else --if (m_axi_sg_aclk'event and m_axi_sg_aclk = '1') then
              tvalid_int <= tdest_in (6); --s2mm_tvalid;
              tvalid_int1 <= tvalid_int;
              tvalid_int2 <= tvalid_int1;
              s2mm_tvalid_latch_del <= tvalid_latch;
              if (new_tdest = '1') then
                tvalid_latch <= '0';
              else
                tvalid_latch <= '1';
              end if;
           end if;
        end if;
    end process;

-- will trigger tailptrupdtd and it will then get SG out of pause
    same_tdest_arrived <= same_tdest_int2 xor same_tdest_int3;  

   process (m_axi_sg_aclk)
   begin
        if (m_axi_sg_aclk'event and m_axi_sg_aclk = '1') then
           if (m_axi_sg_aresetn = '0') then
             same_tdest_int1 <= '0';
             same_tdest_int2 <= '0';
             same_tdest_int3 <= '0';
           else --if (m_axi_sg_aclk'event and m_axi_sg_aclk = '1') then
             same_tdest_int1 <= same_tdest_in;
             same_tdest_int2 <= same_tdest_int1;
             same_tdest_int3 <= same_tdest_int2;
           end if;
        end if;
    end process;

--   process (m_axi_sg_aclk)
--   begin
--        if (m_axi_sg_aresetn = '0') then
--           tvalid_int <= '0';
--           tvalid_int1 <= '0';
--           tvalid_latch <= '0';
--           tdest_in_int <= (others => '0');
--        elsif (m_axi_sg_aclk'event and m_axi_sg_aclk = '1') then
--           tvalid_int <= s2mm_tvalid;
--           tvalid_int1 <= tvalid_int;
--           tdest_in_int <= tdest_in;
--         --  if (tvalid_int1 = '1' and (tdest_in_int /= tdest_in)) then
--           if (tvalid_int1 = '1' and tdest_in_int = "00000" and (tdest_in_int = tdest_in)) then
--              tvalid_latch <= '1';
--           elsif (tvalid_int1 = '1' and (tdest_in_int /= tdest_in)) then
--              tvalid_latch <= '0';
--           elsif (tvalid_int1 = '1' and (tdest_in_int = tdest_in)) then
--              tvalid_latch <= '1';
--           end if;
--        end if;
--    end process;

   s2mm_tvalid_latch <= tvalid_latch;

   PROC_TDEST_IN : process (m_axi_sg_aclk)
          begin
               if (m_axi_sg_aclk'event and m_axi_sg_aclk = '1') then
                  if (m_axi_sg_aresetn = '0') then
                     s2mm_curdesc_int2 <= (others => '0');
                     s2mm_taildesc_int2 <= (others => '0');  
                  else --if (m_axi_sg_aclk'event and m_axi_sg_aclk = '1') then
                     s2mm_curdesc_int2    <= s2mm_curdesc_int;
                     s2mm_taildesc_int2   <= s2mm_taildesc_int; 
                  end if;
               end if;
          end process PROC_TDEST_IN; 
                     
                 s2mm_curdesc <= s2mm_curdesc_int2;
                 s2mm_taildesc <= s2mm_taildesc_int2;  

end generate GEN_S2MM_TDEST;

GEN_S2MM_NO_TDEST : if (C_ENABLE_MULTI_CHANNEL = 0) generate
--GEN_S2MM_NO_TDEST : if (C_NUM_S2MM_CHANNELS = 1 and C_ENABLE_MULTI_CHANNEL = 0) generate
begin
                   s2mm_tailpntr_updated <= s2mm_tailpntr_updated_int1; 
                   s2mm_curdesc <= s2mm_curdesc_int;
                   s2mm_taildesc <= s2mm_taildesc_int; 

                   s2mm_tvalid_latch <= '1'; 
                   s2mm_tvalid_latch_del <= '1'; 

end generate GEN_S2MM_NO_TDEST;


-- For 32 bit address map only lsb registers out
GEN_DESC_ADDR_EQL32 : if C_M_AXI_SG_ADDR_WIDTH = 32 generate
begin
    mm2s_curdesc    <= mm2s_curdesc_lsb_i;
    mm2s_taildesc   <= mm2s_taildesc_lsb_i;

    s2mm_curdesc_int    <= s2mm_curdesc_lsb_muxed; 
    s2mm_taildesc_int   <= s2mm_taildesc_lsb_muxed;
end generate GEN_DESC_ADDR_EQL32;

-- For 64 bit address map lsb and msb registers out
GEN_DESC_ADDR_EQL64 : if C_M_AXI_SG_ADDR_WIDTH = 64 generate
begin
    mm2s_curdesc    <= mm2s_curdesc_msb_i & mm2s_curdesc_lsb_i;
    mm2s_taildesc   <= mm2s_taildesc_msb_i & mm2s_taildesc_lsb_i;

    s2mm_curdesc_int    <= s2mm_curdesc_msb_muxed & s2mm_curdesc_lsb_muxed;
    s2mm_taildesc_int   <= s2mm_taildesc_msb_muxed & s2mm_taildesc_lsb_muxed;
end generate GEN_DESC_ADDR_EQL64;

-------------------------------------------------------------------------------
-- Generate AXI Lite Inteface
-------------------------------------------------------------------------------
GEN_AXI_LITE_IF : if C_INCLUDE_MM2S = 1 or C_INCLUDE_S2MM = 1 generate
begin
    AXI_LITE_IF_I : entity axi_dma_v7_1_8.axi_dma_lite_if
        generic map(
            C_NUM_CE                    => 23+(121*C_ENABLE_MULTI_CHANNEL)   ,
            C_AXI_LITE_IS_ASYNC         => C_AXI_LITE_IS_ASYNC      ,
            C_S_AXI_LITE_ADDR_WIDTH     => C_S_AXI_LITE_ADDR_WIDTH  ,
            C_S_AXI_LITE_DATA_WIDTH     => C_S_AXI_LITE_DATA_WIDTH
        )
        port map(
            ip2axi_aclk                 => m_axi_sg_aclk            ,
            ip2axi_aresetn              => m_axi_sg_hrdresetn       ,

            s_axi_lite_aclk             => s_axi_lite_aclk          ,
            s_axi_lite_aresetn          => axi_lite_reset_n         ,

            -- AXI Lite Write Address Channel
            s_axi_lite_awvalid          => s_axi_lite_awvalid       ,
            s_axi_lite_awready          => s_axi_lite_awready       ,
            s_axi_lite_awaddr           => s_axi_lite_awaddr        ,

            -- AXI Lite Write Data Channel
            s_axi_lite_wvalid           => s_axi_lite_wvalid        ,
            s_axi_lite_wready           => s_axi_lite_wready        ,
            s_axi_lite_wdata            => s_axi_lite_wdata         ,

            -- AXI Lite Write Response Channel
            s_axi_lite_bresp            => s_axi_lite_bresp         ,
            s_axi_lite_bvalid           => s_axi_lite_bvalid        ,
            s_axi_lite_bready           => s_axi_lite_bready        ,

            -- AXI Lite Read Address Channel
            s_axi_lite_arvalid          => s_axi_lite_arvalid       ,
            s_axi_lite_arready          => s_axi_lite_arready       ,
            s_axi_lite_araddr           => s_axi_lite_araddr        ,
            s_axi_lite_rvalid           => s_axi_lite_rvalid        ,
            s_axi_lite_rready           => s_axi_lite_rready        ,
            s_axi_lite_rdata            => s_axi_lite_rdata         ,
            s_axi_lite_rresp            => s_axi_lite_rresp         ,

            -- User IP Interface
            axi2ip_wrce                 => axi2ip_wrce              ,
            axi2ip_wrdata               => axi2ip_wrdata            ,

            axi2ip_rdce                 => open                     ,
            axi2ip_rdaddr               => axi2ip_rdaddr            ,
            ip2axi_rddata               => ip2axi_rddata

        );
end generate GEN_AXI_LITE_IF;

-------------------------------------------------------------------------------
-- No channels therefore do not generate an AXI Lite interface
-------------------------------------------------------------------------------
GEN_NO_AXI_LITE_IF : if C_INCLUDE_MM2S = 0 and C_INCLUDE_S2MM = 0 generate
begin
    s_axi_lite_awready          <= '0';
    s_axi_lite_wready           <= '0';
    s_axi_lite_bresp            <= (others => '0');
    s_axi_lite_bvalid           <= '0';
    s_axi_lite_arready          <= '0';
    s_axi_lite_rvalid           <= '0';
    s_axi_lite_rdata            <= (others => '0');
    s_axi_lite_rresp            <= (others => '0');

end generate GEN_NO_AXI_LITE_IF;

-------------------------------------------------------------------------------
-- Generate MM2S Registers if included
-------------------------------------------------------------------------------
GEN_MM2S_REGISTERS : if C_INCLUDE_MM2S = 1 generate
begin
    I_MM2S_DMA_REGISTER : entity axi_dma_v7_1_8.axi_dma_register
    generic map (
        C_NUM_REGISTERS             => NUM_REG_PER_CHANNEL      ,
        C_INCLUDE_SG                => C_INCLUDE_SG             ,
        C_SG_LENGTH_WIDTH           => C_SG_LENGTH_WIDTH        ,
        C_S_AXI_LITE_DATA_WIDTH     => C_S_AXI_LITE_DATA_WIDTH  ,
        C_M_AXI_SG_ADDR_WIDTH       => C_M_AXI_SG_ADDR_WIDTH    ,
        C_MICRO_DMA                 => C_MICRO_DMA              ,
        C_ENABLE_MULTI_CHANNEL      => C_ENABLE_MULTI_CHANNEL             
  --      C_NUM_S2MM_CHANNELS         => 1 --C_S2MM_NUM_CHANNELS
        --C_CHANNEL_IS_S2MM           => NOT_S2MM_CHANNEL  CR603034
    )
    port map(
        -- Secondary Clock / Reset
        m_axi_sg_aclk               => m_axi_sg_aclk            ,
        m_axi_sg_aresetn            => m_axi_sg_aresetn         ,

        -- CPU Write Control (via AXI Lite)
        axi2ip_wrdata               => axi2ip_wrdata            ,
        axi2ip_wrce                 => axi2ip_wrce              
                                        (RESERVED_2C_INDEX        
                                        downto MM2S_DMACR_INDEX),
                                         --(MM2S_LENGTH_INDEX

        -- DMASR Register bit control/status
        stop_dma                    => mm2s_stop                ,
        halted_clr                  => mm2s_halted_clr          ,
        halted_set                  => mm2s_halted_set          ,
        idle_set                    => mm2s_idle_set            ,
        idle_clr                    => mm2s_idle_clr            ,
        ioc_irq_set                 => mm2s_ioc_irq_set         ,
        dly_irq_set                 => mm2s_dly_irq_set         ,
        irqdelay_status             => mm2s_irqdelay_status     ,
        irqthresh_status            => mm2s_irqthresh_status    ,

        -- SG Error Control
        ftch_interr_set             => mm2s_ftch_interr_set     ,
        ftch_slverr_set             => mm2s_ftch_slverr_set     ,
        ftch_decerr_set             => mm2s_ftch_decerr_set     ,
        ftch_error_addr             => ftch_error_addr          ,
        updt_interr_set             => mm2s_updt_interr_set     ,
        updt_slverr_set             => mm2s_updt_slverr_set     ,
        updt_decerr_set             => mm2s_updt_decerr_set     ,
        updt_error_addr             => updt_error_addr          ,
        dma_interr_set              => mm2s_dma_interr_set      ,
        dma_slverr_set              => mm2s_dma_slverr_set      ,
        dma_decerr_set              => mm2s_dma_decerr_set      ,
        irqthresh_wren              => mm2s_irqthresh_wren      ,
        irqdelay_wren               => mm2s_irqdelay_wren       ,
        dlyirq_dsble                => mm2s_dlyirq_dsble        , -- CR605888
        error_in                    => s2mm_error_out           ,
        error_out                   => mm2s_error_out           ,
        introut                     => mm2s_introut_i_cdc_from           ,
        soft_reset_in               => s2mm_dmacr_i(DMACR_RESET_BIT),
        soft_reset_clr              => soft_reset_clr           ,


        -- CURDESC Update
        update_curdesc              => mm2s_new_curdesc_wren    ,
        new_curdesc                 => mm2s_new_curdesc         ,

        -- TAILDESC Update
        tailpntr_updated            => mm2s_tailpntr_updated    ,

        -- Channel Registers
        sg_ctl                      => mm2s_sgctl               ,
        dmacr                       => mm2s_dmacr_i             ,
        dmasr                       => mm2s_dmasr_i             ,
        curdesc_lsb                 => mm2s_curdesc_lsb_i       ,
        curdesc_msb                 => mm2s_curdesc_msb_i       ,
        taildesc_lsb                => mm2s_taildesc_lsb_i      ,
        taildesc_msb                => mm2s_taildesc_msb_i      ,

--        curdesc1_lsb                 => open       ,
--        curdesc1_msb                 => open       ,
--        taildesc1_lsb                => open      ,
--        taildesc1_msb                => open      ,

--        curdesc2_lsb                 => open       ,
--        curdesc2_msb                 => open       ,
--        taildesc2_lsb                => open      ,
--        taildesc2_msb                => open      ,
--
--        curdesc3_lsb                 => open       ,
--        curdesc3_msb                 => open       ,
--        taildesc3_lsb                => open      ,
--        taildesc3_msb                => open      ,
--
--        curdesc4_lsb                 => open       ,
--        curdesc4_msb                 => open       ,
--        taildesc4_lsb                => open      ,
--        taildesc4_msb                => open      ,
--
--        curdesc5_lsb                 => open       ,
--        curdesc5_msb                 => open       ,
--        taildesc5_lsb                => open      ,
--        taildesc5_msb                => open      ,
--
--        curdesc6_lsb                 => open       ,
--        curdesc6_msb                 => open       ,
--        taildesc6_lsb                => open      ,
--        taildesc6_msb                => open      ,
--
--        curdesc7_lsb                 => open       ,
--        curdesc7_msb                 => open       ,
--        taildesc7_lsb                => open      ,
--        taildesc7_msb                => open      ,
--
--        curdesc8_lsb                 => open       ,
--        curdesc8_msb                 => open       ,
--        taildesc8_lsb                => open      ,
--        taildesc8_msb                => open      ,
--
--        curdesc9_lsb                 => open       ,
--        curdesc9_msb                 => open       ,
--        taildesc9_lsb                => open      ,
--        taildesc9_msb                => open      ,
--
--        curdesc10_lsb                 => open       ,
--        curdesc10_msb                 => open       ,
--        taildesc10_lsb                => open      ,
--        taildesc10_msb                => open      ,
--
--        curdesc11_lsb                 => open       ,
--        curdesc11_msb                 => open       ,
--        taildesc11_lsb                => open      ,
--        taildesc11_msb                => open      ,
--
--        curdesc12_lsb                 => open       ,
--        curdesc12_msb                 => open       ,
--        taildesc12_lsb                => open      ,
--        taildesc12_msb                => open      ,
--
--        curdesc13_lsb                 => open       ,
--        curdesc13_msb                 => open       ,
--        taildesc13_lsb                => open      ,
--        taildesc13_msb                => open      ,
--
--        curdesc14_lsb                 => open       ,
--        curdesc14_msb                 => open       ,
--        taildesc14_lsb                => open      ,
--        taildesc14_msb                => open      ,
--
--
--        curdesc15_lsb                 => open       ,
--        curdesc15_msb                 => open       ,
--        taildesc15_lsb                => open      ,
--        taildesc15_msb                => open      ,
--     
--        tdest_in                    => "00000" ,

        buffer_address              => mm2s_sa_i                ,
        buffer_length               => mm2s_length_i            ,
        buffer_length_wren          => mm2s_length_wren         ,
        bytes_received              => ZERO_BYTES               ,   -- Not used on transmit
        bytes_received_wren         => '0'                          -- Not used on transmit

    );

    -- If async clocks then cross interrupt out to AXI Lite clock domain
    GEN_INTROUT_ASYNC : if C_AXI_LITE_IS_ASYNC = 1 generate
    begin

PROC_REG_INTR2LITE : entity  lib_cdc_v1_0_2.cdc_sync
    generic map (
        C_CDC_TYPE                 => 1,
        C_RESET_STATE              => 0,
        C_SINGLE_BIT               => 1,
        C_VECTOR_WIDTH             => 32,
        C_MTBF_STAGES              => MTBF_STAGES
    )
    port map (
        prmry_aclk                 => '0',
        prmry_resetn               => '0',
        prmry_in                   => mm2s_introut_i_cdc_from,
        prmry_vect_in              => (others => '0'),

        scndry_aclk                => s_axi_lite_aclk,
        scndry_resetn              => '0',
        scndry_out                 => mm2s_introut_to,
        scndry_vect_out            => open
    );


--        PROC_REG_INTR2LITE : process(s_axi_lite_aclk)
--            begin
--                if(s_axi_lite_aclk'EVENT and s_axi_lite_aclk = '1')then
--                 --   if(axi_lite_reset_n = '0')then
--                 --       mm2s_introut_d1_cdc_tig <= '0';
--                 --       mm2s_introut_to    <= '0';
--                 --   else
--                        mm2s_introut_d1_cdc_tig <= mm2s_introut_i_cdc_from;
--                        mm2s_introut_to    <= mm2s_introut_d1_cdc_tig;
--                 --   end if;
--                end if;
--            end process PROC_REG_INTR2LITE;

             mm2s_introut <= mm2s_introut_to;
 
    end generate GEN_INTROUT_ASYNC;

    -- If sync then simply pass out
    GEN_INTROUT_SYNC : if C_AXI_LITE_IS_ASYNC = 0 generate
    begin
        mm2s_introut    <= mm2s_introut_i_cdc_from;
    end generate GEN_INTROUT_SYNC;

end generate GEN_MM2S_REGISTERS;

-------------------------------------------------------------------------------
-- Tie MM2S Register outputs to zero if excluded
-------------------------------------------------------------------------------
GEN_NO_MM2S_REGISTERS : if C_INCLUDE_MM2S = 0 generate
begin
    mm2s_dmacr_i            <= (others => '0');
    mm2s_dmasr_i            <= (others => '0');
    mm2s_curdesc_lsb_i      <= (others => '0');
    mm2s_curdesc_msb_i      <= (others => '0');
    mm2s_taildesc_lsb_i     <= (others => '0');
    mm2s_taildesc_msb_i     <= (others => '0');
    mm2s_tailpntr_updated   <= '0';
    mm2s_sa_i               <= (others => '0');
    mm2s_length_i           <= (others => '0');
    mm2s_length_wren        <= '0';

    mm2s_irqthresh_wren         <= '0';
    mm2s_irqdelay_wren          <= '0';
    mm2s_tailpntr_updated       <= '0';
    mm2s_introut                <= '0';
    mm2s_sgctl                  <= (others => '0');
    mm2s_dlyirq_dsble       <= '0';
end generate GEN_NO_MM2S_REGISTERS;



-------------------------------------------------------------------------------
-- Generate S2MM Registers if included
-------------------------------------------------------------------------------
GEN_S2MM_REGISTERS : if C_INCLUDE_S2MM = 1 generate
begin
    I_S2MM_DMA_REGISTER : entity axi_dma_v7_1_8.axi_dma_register_s2mm
    generic map (
        C_NUM_REGISTERS             => NUM_REG_PER_S2MM_INT, --NUM_REG_TOTAL, --NUM_REG_PER_CHANNEL      ,
        C_INCLUDE_SG                => C_INCLUDE_SG             ,
        C_SG_LENGTH_WIDTH           => C_SG_LENGTH_WIDTH        ,
        C_S_AXI_LITE_DATA_WIDTH     => C_S_AXI_LITE_DATA_WIDTH  ,
        C_M_AXI_SG_ADDR_WIDTH       => C_M_AXI_SG_ADDR_WIDTH    ,
        C_NUM_S2MM_CHANNELS         => C_NUM_S2MM_CHANNELS      ,
        C_MICRO_DMA                 => C_MICRO_DMA              ,
        C_ENABLE_MULTI_CHANNEL      => C_ENABLE_MULTI_CHANNEL             
        --C_CHANNEL_IS_S2MM           => IS_S2MM_CHANNEL    CR603034
    )
    port map(
        -- Secondary Clock / Reset
        m_axi_sg_aclk               => m_axi_sg_aclk            ,
        m_axi_sg_aresetn            => m_axi_sg_aresetn         ,

        -- CPU Write Control (via AXI Lite)
        axi2ip_wrdata               => axi2ip_wrdata            ,
        axi2ip_wrce                 => axi2ip_wrce              
                                        ((23+(121*C_ENABLE_MULTI_CHANNEL)-1)
                                         downto RESERVED_2C_INDEX) ,  
--                                        downto S2MM_DMACR_INDEX),
--S2MM_LENGTH_INDEX
        -- DMASR Register bit control/status
        stop_dma                    => s2mm_stop                ,
        halted_clr                  => s2mm_halted_clr          ,
        halted_set                  => s2mm_halted_set          ,
        idle_set                    => s2mm_idle_set            ,
        idle_clr                    => s2mm_idle_clr            ,
        ioc_irq_set                 => s2mm_ioc_irq_set         ,
        dly_irq_set                 => s2mm_dly_irq_set         ,
        irqdelay_status             => s2mm_irqdelay_status     ,
        irqthresh_status            => s2mm_irqthresh_status    ,

        -- SG Error Control
        dma_interr_set              => s2mm_dma_interr_set      ,
        dma_slverr_set              => s2mm_dma_slverr_set      ,
        dma_decerr_set              => s2mm_dma_decerr_set      ,
        ftch_interr_set             => s2mm_ftch_interr_set     ,
        ftch_slverr_set             => s2mm_ftch_slverr_set     ,
        ftch_decerr_set             => s2mm_ftch_decerr_set     ,
        ftch_error_addr             => ftch_error_addr          ,
        updt_interr_set             => s2mm_updt_interr_set     ,
        updt_slverr_set             => s2mm_updt_slverr_set     ,
        updt_decerr_set             => s2mm_updt_decerr_set     ,
        updt_error_addr             => updt_error_addr          ,
        irqthresh_wren              => s2mm_irqthresh_wren      ,
        irqdelay_wren               => s2mm_irqdelay_wren       ,
        dlyirq_dsble                => s2mm_dlyirq_dsble        , -- CR605888
        error_in                    => mm2s_error_out           ,
        error_out                   => s2mm_error_out           ,
        introut                     => s2mm_introut_i_cdc_from           ,
        soft_reset_in               => mm2s_dmacr_i(DMACR_RESET_BIT),
        soft_reset_clr              => soft_reset_clr           ,

        -- CURDESC Update
        update_curdesc              => s2mm_new_curdesc_wren    ,
        new_curdesc                 => s2mm_new_curdesc         ,

        -- TAILDESC Update
        tailpntr_updated            => s2mm_tailpntr_updated_int1     ,

        -- Channel Registers
        sg_ctl                      => s2mm_sgctl               ,
        dmacr                       => s2mm_dmacr_i             ,
        dmasr                       => s2mm_dmasr_i             ,
        curdesc_lsb                 => s2mm_curdesc_lsb_i       ,
        curdesc_msb                 => s2mm_curdesc_msb_i       ,
        taildesc_lsb                => s2mm_taildesc_lsb_i      ,
        taildesc_msb                => s2mm_taildesc_msb_i      ,

        curdesc1_lsb                 => s2mm_curdesc1_lsb_i       ,
        curdesc1_msb                 => s2mm_curdesc1_msb_i       ,
        taildesc1_lsb                => s2mm_taildesc1_lsb_i      ,
        taildesc1_msb                => s2mm_taildesc1_msb_i      ,

        curdesc2_lsb                 => s2mm_curdesc2_lsb_i       ,
        curdesc2_msb                 => s2mm_curdesc2_msb_i       ,
        taildesc2_lsb                => s2mm_taildesc2_lsb_i      ,
        taildesc2_msb                => s2mm_taildesc2_msb_i      ,

        curdesc3_lsb                 => s2mm_curdesc3_lsb_i       ,
        curdesc3_msb                 => s2mm_curdesc3_msb_i       ,
        taildesc3_lsb                => s2mm_taildesc3_lsb_i      ,
        taildesc3_msb                => s2mm_taildesc3_msb_i      ,

        curdesc4_lsb                 => s2mm_curdesc4_lsb_i       ,
        curdesc4_msb                 => s2mm_curdesc4_msb_i       ,
        taildesc4_lsb                => s2mm_taildesc4_lsb_i      ,
        taildesc4_msb                => s2mm_taildesc4_msb_i      ,

        curdesc5_lsb                 => s2mm_curdesc5_lsb_i       ,
        curdesc5_msb                 => s2mm_curdesc5_msb_i       ,
        taildesc5_lsb                => s2mm_taildesc5_lsb_i      ,
        taildesc5_msb                => s2mm_taildesc5_msb_i      ,

        curdesc6_lsb                 => s2mm_curdesc6_lsb_i       ,
        curdesc6_msb                 => s2mm_curdesc6_msb_i       ,
        taildesc6_lsb                => s2mm_taildesc6_lsb_i      ,
        taildesc6_msb                => s2mm_taildesc6_msb_i      ,

        curdesc7_lsb                 => s2mm_curdesc7_lsb_i       ,
        curdesc7_msb                 => s2mm_curdesc7_msb_i       ,
        taildesc7_lsb                => s2mm_taildesc7_lsb_i      ,
        taildesc7_msb                => s2mm_taildesc7_msb_i      ,

        curdesc8_lsb                 => s2mm_curdesc8_lsb_i       ,
        curdesc8_msb                 => s2mm_curdesc8_msb_i       ,
        taildesc8_lsb                => s2mm_taildesc8_lsb_i      ,
        taildesc8_msb                => s2mm_taildesc8_msb_i      ,

        curdesc9_lsb                 => s2mm_curdesc9_lsb_i       ,
        curdesc9_msb                 => s2mm_curdesc9_msb_i       ,
        taildesc9_lsb                => s2mm_taildesc9_lsb_i      ,
        taildesc9_msb                => s2mm_taildesc9_msb_i      ,

        curdesc10_lsb                => s2mm_curdesc10_lsb_i       ,
        curdesc10_msb                => s2mm_curdesc10_msb_i       ,
        taildesc10_lsb               => s2mm_taildesc10_lsb_i      ,
        taildesc10_msb               => s2mm_taildesc10_msb_i      ,

        curdesc11_lsb                => s2mm_curdesc11_lsb_i       ,
        curdesc11_msb                => s2mm_curdesc11_msb_i       ,
        taildesc11_lsb               => s2mm_taildesc11_lsb_i      ,
        taildesc11_msb               => s2mm_taildesc11_msb_i      ,

        curdesc12_lsb                => s2mm_curdesc12_lsb_i       ,
        curdesc12_msb                => s2mm_curdesc12_msb_i       ,
        taildesc12_lsb               => s2mm_taildesc12_lsb_i      ,
        taildesc12_msb               => s2mm_taildesc12_msb_i      ,

        curdesc13_lsb                => s2mm_curdesc13_lsb_i       ,
        curdesc13_msb                => s2mm_curdesc13_msb_i       ,
        taildesc13_lsb               => s2mm_taildesc13_lsb_i      ,
        taildesc13_msb               => s2mm_taildesc13_msb_i      ,

        curdesc14_lsb                => s2mm_curdesc14_lsb_i       ,
        curdesc14_msb                => s2mm_curdesc14_msb_i       ,
        taildesc14_lsb               => s2mm_taildesc14_lsb_i      ,
        taildesc14_msb               => s2mm_taildesc14_msb_i      ,

        curdesc15_lsb                => s2mm_curdesc15_lsb_i       ,
        curdesc15_msb                => s2mm_curdesc15_msb_i       ,
        taildesc15_lsb               => s2mm_taildesc15_lsb_i      ,
        taildesc15_msb               => s2mm_taildesc15_msb_i      ,

        tdest_in                    => tdest_in (5 downto 0)                ,

        buffer_address              => s2mm_da_i                ,
        buffer_length               => s2mm_length_i            ,
        buffer_length_wren          => s2mm_length_wren         ,
        bytes_received              => s2mm_bytes_rcvd          ,
        bytes_received_wren         => s2mm_bytes_rcvd_wren
    );

    GEN_DESC_MUX_SINGLE_CH : if C_NUM_S2MM_CHANNELS = 1 generate
    begin
        
                     s2mm_curdesc_lsb_muxed <= s2mm_curdesc_lsb_i;
                     s2mm_curdesc_msb_muxed <= s2mm_curdesc_msb_i;
                     s2mm_taildesc_lsb_muxed <= s2mm_taildesc_lsb_i;
                     s2mm_taildesc_msb_muxed <= s2mm_taildesc_msb_i;  
    end generate GEN_DESC_MUX_SINGLE_CH;
   
    GEN_DESC_MUX : if C_NUM_S2MM_CHANNELS > 1 generate
    begin
        
      PROC_DESC_SEL : process (tdest_in, s2mm_curdesc_lsb_i,s2mm_curdesc_msb_i, s2mm_taildesc_lsb_i, s2mm_taildesc_msb_i,
                               s2mm_curdesc1_lsb_i,s2mm_curdesc1_msb_i, s2mm_taildesc1_lsb_i, s2mm_taildesc1_msb_i,
                               s2mm_curdesc2_lsb_i,s2mm_curdesc2_msb_i, s2mm_taildesc2_lsb_i, s2mm_taildesc2_msb_i,
                               s2mm_curdesc3_lsb_i,s2mm_curdesc3_msb_i, s2mm_taildesc3_lsb_i, s2mm_taildesc3_msb_i,
                               s2mm_curdesc4_lsb_i,s2mm_curdesc4_msb_i, s2mm_taildesc4_lsb_i, s2mm_taildesc4_msb_i,
                               s2mm_curdesc5_lsb_i,s2mm_curdesc5_msb_i, s2mm_taildesc5_lsb_i, s2mm_taildesc5_msb_i,
                               s2mm_curdesc6_lsb_i,s2mm_curdesc6_msb_i, s2mm_taildesc6_lsb_i, s2mm_taildesc6_msb_i,
                               s2mm_curdesc7_lsb_i,s2mm_curdesc7_msb_i, s2mm_taildesc7_lsb_i, s2mm_taildesc7_msb_i,
                               s2mm_curdesc8_lsb_i,s2mm_curdesc8_msb_i, s2mm_taildesc8_lsb_i, s2mm_taildesc8_msb_i,
                               s2mm_curdesc9_lsb_i,s2mm_curdesc9_msb_i, s2mm_taildesc9_lsb_i, s2mm_taildesc9_msb_i,
                               s2mm_curdesc10_lsb_i,s2mm_curdesc10_msb_i, s2mm_taildesc10_lsb_i, s2mm_taildesc10_msb_i,
                               s2mm_curdesc11_lsb_i,s2mm_curdesc11_msb_i, s2mm_taildesc11_lsb_i, s2mm_taildesc11_msb_i,
                               s2mm_curdesc12_lsb_i,s2mm_curdesc12_msb_i, s2mm_taildesc12_lsb_i, s2mm_taildesc12_msb_i,
                               s2mm_curdesc13_lsb_i,s2mm_curdesc13_msb_i, s2mm_taildesc13_lsb_i, s2mm_taildesc13_msb_i,
                               s2mm_curdesc14_lsb_i,s2mm_curdesc14_msb_i, s2mm_taildesc14_lsb_i, s2mm_taildesc14_msb_i,
                               s2mm_curdesc15_lsb_i,s2mm_curdesc15_msb_i, s2mm_taildesc15_lsb_i, s2mm_taildesc15_msb_i
                               )
         begin
              case tdest_in (3 downto 0) is
                 when "0000" =>
                     s2mm_curdesc_lsb_muxed <= s2mm_curdesc_lsb_i;
                     s2mm_curdesc_msb_muxed <= s2mm_curdesc_msb_i;
                     s2mm_taildesc_lsb_muxed <= s2mm_taildesc_lsb_i;
                     s2mm_taildesc_msb_muxed <= s2mm_taildesc_msb_i;  
                 when "0001" =>
                     s2mm_curdesc_lsb_muxed <= s2mm_curdesc1_lsb_i;
                     s2mm_curdesc_msb_muxed <= s2mm_curdesc1_msb_i;
                     s2mm_taildesc_lsb_muxed <= s2mm_taildesc1_lsb_i;
                     s2mm_taildesc_msb_muxed <= s2mm_taildesc1_msb_i;  
                 when "0010" =>
                     s2mm_curdesc_lsb_muxed <= s2mm_curdesc2_lsb_i;
                     s2mm_curdesc_msb_muxed <= s2mm_curdesc2_msb_i;
                     s2mm_taildesc_lsb_muxed <= s2mm_taildesc2_lsb_i;
                     s2mm_taildesc_msb_muxed <= s2mm_taildesc2_msb_i;  
                 when "0011" =>
                     s2mm_curdesc_lsb_muxed <= s2mm_curdesc3_lsb_i;
                     s2mm_curdesc_msb_muxed <= s2mm_curdesc3_msb_i;
                     s2mm_taildesc_lsb_muxed <= s2mm_taildesc3_lsb_i;
                     s2mm_taildesc_msb_muxed <= s2mm_taildesc3_msb_i;  
                 when "0100" =>
                     s2mm_curdesc_lsb_muxed <= s2mm_curdesc4_lsb_i;
                     s2mm_curdesc_msb_muxed <= s2mm_curdesc4_msb_i;
                     s2mm_taildesc_lsb_muxed <= s2mm_taildesc4_lsb_i;
                     s2mm_taildesc_msb_muxed <= s2mm_taildesc4_msb_i;  
                 when "0101" =>
                     s2mm_curdesc_lsb_muxed <= s2mm_curdesc5_lsb_i;
                     s2mm_curdesc_msb_muxed <= s2mm_curdesc5_msb_i;
                     s2mm_taildesc_lsb_muxed <= s2mm_taildesc5_lsb_i;
                     s2mm_taildesc_msb_muxed <= s2mm_taildesc5_msb_i;  
                 when "0110" =>
                     s2mm_curdesc_lsb_muxed <= s2mm_curdesc6_lsb_i;
                     s2mm_curdesc_msb_muxed <= s2mm_curdesc6_msb_i;
                     s2mm_taildesc_lsb_muxed <= s2mm_taildesc6_lsb_i;
                     s2mm_taildesc_msb_muxed <= s2mm_taildesc6_msb_i;  
                 when "0111" =>
                     s2mm_curdesc_lsb_muxed <= s2mm_curdesc7_lsb_i;
                     s2mm_curdesc_msb_muxed <= s2mm_curdesc7_msb_i;
                     s2mm_taildesc_lsb_muxed <= s2mm_taildesc7_lsb_i;
                     s2mm_taildesc_msb_muxed <= s2mm_taildesc7_msb_i;  
                 when "1000" =>
                     s2mm_curdesc_lsb_muxed <= s2mm_curdesc8_lsb_i;
                     s2mm_curdesc_msb_muxed <= s2mm_curdesc8_msb_i;
                     s2mm_taildesc_lsb_muxed <= s2mm_taildesc8_lsb_i;
                     s2mm_taildesc_msb_muxed <= s2mm_taildesc8_msb_i;  
                 when "1001" =>
                     s2mm_curdesc_lsb_muxed <= s2mm_curdesc9_lsb_i;
                     s2mm_curdesc_msb_muxed <= s2mm_curdesc9_msb_i;
                     s2mm_taildesc_lsb_muxed <= s2mm_taildesc9_lsb_i;
                     s2mm_taildesc_msb_muxed <= s2mm_taildesc9_msb_i;  
                 when "1010" =>
                     s2mm_curdesc_lsb_muxed <= s2mm_curdesc10_lsb_i;
                     s2mm_curdesc_msb_muxed <= s2mm_curdesc10_msb_i;
                     s2mm_taildesc_lsb_muxed <= s2mm_taildesc10_lsb_i;
                     s2mm_taildesc_msb_muxed <= s2mm_taildesc10_msb_i;  
                 when "1011" =>
                     s2mm_curdesc_lsb_muxed <= s2mm_curdesc11_lsb_i;
                     s2mm_curdesc_msb_muxed <= s2mm_curdesc11_msb_i;
                     s2mm_taildesc_lsb_muxed <= s2mm_taildesc11_lsb_i;
                     s2mm_taildesc_msb_muxed <= s2mm_taildesc11_msb_i;  
                 when "1100" =>
                     s2mm_curdesc_lsb_muxed <= s2mm_curdesc12_lsb_i;
                     s2mm_curdesc_msb_muxed <= s2mm_curdesc12_msb_i;
                     s2mm_taildesc_lsb_muxed <= s2mm_taildesc12_lsb_i;
                     s2mm_taildesc_msb_muxed <= s2mm_taildesc12_msb_i;  
                 when "1101" =>
                     s2mm_curdesc_lsb_muxed <= s2mm_curdesc13_lsb_i;
                     s2mm_curdesc_msb_muxed <= s2mm_curdesc13_msb_i;
                     s2mm_taildesc_lsb_muxed <= s2mm_taildesc13_lsb_i;
                     s2mm_taildesc_msb_muxed <= s2mm_taildesc13_msb_i;  
                 when "1110" =>
                     s2mm_curdesc_lsb_muxed <= s2mm_curdesc14_lsb_i;
                     s2mm_curdesc_msb_muxed <= s2mm_curdesc14_msb_i;
                     s2mm_taildesc_lsb_muxed <= s2mm_taildesc14_lsb_i;
                     s2mm_taildesc_msb_muxed <= s2mm_taildesc14_msb_i;  
                 when "1111" =>
                     s2mm_curdesc_lsb_muxed <= s2mm_curdesc15_lsb_i;
                     s2mm_curdesc_msb_muxed <= s2mm_curdesc15_msb_i;
                     s2mm_taildesc_lsb_muxed <= s2mm_taildesc15_lsb_i;
                     s2mm_taildesc_msb_muxed <= s2mm_taildesc15_msb_i;  
                 when others =>
                     s2mm_curdesc_lsb_muxed <= (others => '0');
                     s2mm_curdesc_msb_muxed <= (others => '0');
                     s2mm_taildesc_lsb_muxed <= (others => '0');
                     s2mm_taildesc_msb_muxed <= (others => '0');
               end case;
         end process PROC_DESC_SEL;
    end generate GEN_DESC_MUX;

    -- If async clocks then cross interrupt out to AXI Lite clock domain
    GEN_INTROUT_ASYNC : if C_AXI_LITE_IS_ASYNC = 1 generate
    begin
        -- Cross interrupt out to AXI Lite clock domain

PROC_REG_INTR2LITE : entity  lib_cdc_v1_0_2.cdc_sync
    generic map (
        C_CDC_TYPE                 => 1,
        C_RESET_STATE              => 0,
        C_SINGLE_BIT               => 1,
        C_VECTOR_WIDTH             => 32,
        C_MTBF_STAGES              => MTBF_STAGES
    )
    port map (
        prmry_aclk                 => '0',
        prmry_resetn               => '0',
        prmry_in                   => s2mm_introut_i_cdc_from,
        prmry_vect_in              => (others => '0'),

        scndry_aclk                => s_axi_lite_aclk,
        scndry_resetn              => '0',
        scndry_out                 => s2mm_introut_to,
        scndry_vect_out            => open
    );

--        PROC_REG_INTR2LITE : process(s_axi_lite_aclk)
--            begin
--                if(s_axi_lite_aclk'EVENT and s_axi_lite_aclk = '1')then
--                    if(axi_lite_reset_n = '0')then
--                        s2mm_introut_d1_cdc_tig <= '0';
--                        s2mm_introut_to    <= '0';
--                    else
--                        s2mm_introut_d1_cdc_tig <= s2mm_introut_i_cdc_from;
--                        s2mm_introut_to    <= s2mm_introut_d1_cdc_tig;
--                    end if;
--                end if;
--            end process PROC_REG_INTR2LITE;
                   
              s2mm_introut <= s2mm_introut_to;

    end generate GEN_INTROUT_ASYNC;

    -- If sync then simply pass out
    GEN_INTROUT_SYNC : if C_AXI_LITE_IS_ASYNC = 0 generate
    begin
        s2mm_introut    <= s2mm_introut_i_cdc_from;
    end generate GEN_INTROUT_SYNC;




end generate GEN_S2MM_REGISTERS;

-------------------------------------------------------------------------------
-- Tie S2MM Register outputs to zero if excluded
-------------------------------------------------------------------------------
GEN_NO_S2MM_REGISTERS : if C_INCLUDE_S2MM = 0 generate
begin
    s2mm_dmacr_i                <= (others => '0');
    s2mm_dmasr_i                <= (others => '0');
    s2mm_curdesc_lsb_i          <= (others => '0');
    s2mm_curdesc_msb_i          <= (others => '0');
    s2mm_taildesc_lsb_i         <= (others => '0');
    s2mm_taildesc_msb_i         <= (others => '0');
    s2mm_da_i                   <= (others => '0');
    s2mm_length_i               <= (others => '0');
    s2mm_length_wren            <= '0';

    s2mm_tailpntr_updated       <= '0';
    s2mm_introut                <= '0';
    s2mm_irqthresh_wren         <= '0';
    s2mm_irqdelay_wren          <= '0';
    s2mm_tailpntr_updated       <= '0';
    s2mm_dlyirq_dsble           <= '0';
    s2mm_tailpntr_updated_int1  <= '0';
    s2mm_sgctl                  <= (others => '0'); 
end generate GEN_NO_S2MM_REGISTERS;


-------------------------------------------------------------------------------
-- AXI LITE READ MUX
-------------------------------------------------------------------------------
read_addr <= axi2ip_rdaddr(9 downto 0);

-- Generate read mux for Scatter Gather Mode
GEN_READ_MUX_FOR_SG : if C_INCLUDE_SG = 1 generate
begin

    AXI_LITE_READ_MUX : process(read_addr            ,
                                mm2s_dmacr_i         ,
                                mm2s_dmasr_i         ,
                                mm2s_curdesc_lsb_i   ,
                                mm2s_curdesc_msb_i   ,
                                mm2s_taildesc_lsb_i  ,
                                mm2s_taildesc_msb_i  ,
                                s2mm_dmacr_i         ,
                                s2mm_dmasr_i         ,
                                s2mm_curdesc_lsb_i   ,
                                s2mm_curdesc_msb_i   ,
                                s2mm_taildesc_lsb_i  ,
                                s2mm_taildesc_msb_i  ,
                                s2mm_curdesc1_lsb_i   ,
                                s2mm_curdesc1_msb_i   ,
                                s2mm_taildesc1_lsb_i  ,
                                s2mm_taildesc1_msb_i  ,
                                s2mm_curdesc2_lsb_i   ,
                                s2mm_curdesc2_msb_i   ,
                                s2mm_taildesc2_lsb_i  ,
                                s2mm_taildesc2_msb_i  ,
                                s2mm_curdesc3_lsb_i   ,
                                s2mm_curdesc3_msb_i   ,
                                s2mm_taildesc3_lsb_i  ,
                                s2mm_taildesc3_msb_i  ,
                                s2mm_curdesc4_lsb_i   ,
                                s2mm_curdesc4_msb_i   ,
                                s2mm_taildesc4_lsb_i  ,
                                s2mm_taildesc4_msb_i  ,
                                s2mm_curdesc5_lsb_i   ,
                                s2mm_curdesc5_msb_i   ,
                                s2mm_taildesc5_lsb_i  ,
                                s2mm_taildesc5_msb_i  ,
                                s2mm_curdesc6_lsb_i   ,
                                s2mm_curdesc6_msb_i   ,
                                s2mm_taildesc6_lsb_i  ,
                                s2mm_taildesc6_msb_i  ,
                                s2mm_curdesc7_lsb_i   ,
                                s2mm_curdesc7_msb_i   ,
                                s2mm_taildesc7_lsb_i  ,
                                s2mm_taildesc7_msb_i  ,
                                s2mm_curdesc8_lsb_i   ,
                                s2mm_curdesc8_msb_i   ,
                                s2mm_taildesc8_lsb_i  ,
                                s2mm_taildesc8_msb_i  ,
                                s2mm_curdesc9_lsb_i   ,
                                s2mm_curdesc9_msb_i   ,
                                s2mm_taildesc9_lsb_i  ,
                                s2mm_taildesc9_msb_i  ,
                                s2mm_curdesc10_lsb_i   ,
                                s2mm_curdesc10_msb_i   ,
                                s2mm_taildesc10_lsb_i  ,
                                s2mm_taildesc10_msb_i  ,
                                s2mm_curdesc11_lsb_i   ,
                                s2mm_curdesc11_msb_i   ,
                                s2mm_taildesc11_lsb_i  ,
                                s2mm_taildesc11_msb_i  ,
                                s2mm_curdesc12_lsb_i   ,
                                s2mm_curdesc12_msb_i   ,
                                s2mm_taildesc12_lsb_i  ,
                                s2mm_taildesc12_msb_i  ,
                                s2mm_curdesc13_lsb_i   ,
                                s2mm_curdesc13_msb_i   ,
                                s2mm_taildesc13_lsb_i  ,
                                s2mm_taildesc13_msb_i  ,
                                s2mm_curdesc14_lsb_i   ,
                                s2mm_curdesc14_msb_i   ,
                                s2mm_taildesc14_lsb_i  ,
                                s2mm_taildesc14_msb_i  ,
                                s2mm_curdesc15_lsb_i   ,
                                s2mm_curdesc15_msb_i   ,
                                s2mm_taildesc15_lsb_i  ,
                                s2mm_taildesc15_msb_i  ,
                                or_sgctl
                                )
        begin
            case read_addr is
                when MM2S_DMACR_OFFSET        =>
                    ip2axi_rddata <= mm2s_dmacr_i;
                when MM2S_DMASR_OFFSET        =>
                    ip2axi_rddata <= mm2s_dmasr_i;
                when MM2S_CURDESC_LSB_OFFSET  =>
                    ip2axi_rddata <= mm2s_curdesc_lsb_i;
                when MM2S_CURDESC_MSB_OFFSET  =>
                    ip2axi_rddata <= mm2s_curdesc_msb_i;
                when MM2S_TAILDESC_LSB_OFFSET =>
                    ip2axi_rddata <= mm2s_taildesc_lsb_i;
                when MM2S_TAILDESC_MSB_OFFSET =>
                    ip2axi_rddata <= mm2s_taildesc_msb_i;
                when SGCTL_OFFSET =>
                    ip2axi_rddata <= x"00000" & or_sgctl (7 downto 4) & "0000" & or_sgctl (3 downto 0);
                when S2MM_DMACR_OFFSET        =>
                    ip2axi_rddata <= s2mm_dmacr_i;
                when S2MM_DMASR_OFFSET       =>
                    ip2axi_rddata <= s2mm_dmasr_i;
                when S2MM_CURDESC_LSB_OFFSET  =>
                    ip2axi_rddata <= s2mm_curdesc_lsb_i;
                when S2MM_CURDESC_MSB_OFFSET  =>
                    ip2axi_rddata <= s2mm_curdesc_msb_i;
                when S2MM_TAILDESC_LSB_OFFSET =>
                    ip2axi_rddata <= s2mm_taildesc_lsb_i;
                when S2MM_TAILDESC_MSB_OFFSET =>
                    ip2axi_rddata <= s2mm_taildesc_msb_i;
                when S2MM_CURDESC1_LSB_OFFSET  =>
                    ip2axi_rddata <= s2mm_curdesc1_lsb_i;
                when S2MM_CURDESC1_MSB_OFFSET  =>
                    ip2axi_rddata <= s2mm_curdesc1_msb_i;
                when S2MM_TAILDESC1_LSB_OFFSET =>
                    ip2axi_rddata <= s2mm_taildesc1_lsb_i;
                when S2MM_TAILDESC1_MSB_OFFSET =>
                    ip2axi_rddata <= s2mm_taildesc1_msb_i;
                when S2MM_CURDESC2_LSB_OFFSET  =>
                    ip2axi_rddata <= s2mm_curdesc2_lsb_i;
                when S2MM_CURDESC2_MSB_OFFSET  =>
                    ip2axi_rddata <= s2mm_curdesc2_msb_i;
                when S2MM_TAILDESC2_LSB_OFFSET =>
                    ip2axi_rddata <= s2mm_taildesc2_lsb_i;
                when S2MM_TAILDESC2_MSB_OFFSET =>
                    ip2axi_rddata <= s2mm_taildesc2_msb_i;
                when S2MM_CURDESC3_LSB_OFFSET  =>
                    ip2axi_rddata <= s2mm_curdesc3_lsb_i;
                when S2MM_CURDESC3_MSB_OFFSET  =>
                    ip2axi_rddata <= s2mm_curdesc3_msb_i;
                when S2MM_TAILDESC3_LSB_OFFSET =>
                    ip2axi_rddata <= s2mm_taildesc3_lsb_i;
                when S2MM_TAILDESC3_MSB_OFFSET =>
                    ip2axi_rddata <= s2mm_taildesc3_msb_i;
                when S2MM_CURDESC4_LSB_OFFSET  =>
                    ip2axi_rddata <= s2mm_curdesc4_lsb_i;
                when S2MM_CURDESC4_MSB_OFFSET  =>
                    ip2axi_rddata <= s2mm_curdesc4_msb_i;
                when S2MM_TAILDESC4_LSB_OFFSET =>
                    ip2axi_rddata <= s2mm_taildesc4_lsb_i;
                when S2MM_TAILDESC4_MSB_OFFSET =>
                    ip2axi_rddata <= s2mm_taildesc4_msb_i;
                when S2MM_CURDESC5_LSB_OFFSET  =>
                    ip2axi_rddata <= s2mm_curdesc5_lsb_i;
                when S2MM_CURDESC5_MSB_OFFSET  =>
                    ip2axi_rddata <= s2mm_curdesc5_msb_i;
                when S2MM_TAILDESC5_LSB_OFFSET =>
                    ip2axi_rddata <= s2mm_taildesc5_lsb_i;
                when S2MM_TAILDESC5_MSB_OFFSET =>
                    ip2axi_rddata <= s2mm_taildesc5_msb_i;
                when S2MM_CURDESC6_LSB_OFFSET  =>
                    ip2axi_rddata <= s2mm_curdesc6_lsb_i;
                when S2MM_CURDESC6_MSB_OFFSET  =>
                    ip2axi_rddata <= s2mm_curdesc6_msb_i;
                when S2MM_TAILDESC6_LSB_OFFSET =>
                    ip2axi_rddata <= s2mm_taildesc6_lsb_i;
                when S2MM_TAILDESC6_MSB_OFFSET =>
                    ip2axi_rddata <= s2mm_taildesc6_msb_i;
                when S2MM_CURDESC7_LSB_OFFSET  =>
                    ip2axi_rddata <= s2mm_curdesc7_lsb_i;
                when S2MM_CURDESC7_MSB_OFFSET  =>
                    ip2axi_rddata <= s2mm_curdesc7_msb_i;
                when S2MM_TAILDESC7_LSB_OFFSET =>
                    ip2axi_rddata <= s2mm_taildesc7_lsb_i;
                when S2MM_TAILDESC7_MSB_OFFSET =>
                    ip2axi_rddata <= s2mm_taildesc7_msb_i;
                when S2MM_CURDESC8_LSB_OFFSET  =>
                    ip2axi_rddata <= s2mm_curdesc8_lsb_i;
                when S2MM_CURDESC8_MSB_OFFSET  =>
                    ip2axi_rddata <= s2mm_curdesc8_msb_i;
                when S2MM_TAILDESC8_LSB_OFFSET =>
                    ip2axi_rddata <= s2mm_taildesc8_lsb_i;
                when S2MM_TAILDESC8_MSB_OFFSET =>
                    ip2axi_rddata <= s2mm_taildesc8_msb_i;
                when S2MM_CURDESC9_LSB_OFFSET  =>
                    ip2axi_rddata <= s2mm_curdesc9_lsb_i;
                when S2MM_CURDESC9_MSB_OFFSET  =>
                    ip2axi_rddata <= s2mm_curdesc9_msb_i;
                when S2MM_TAILDESC9_LSB_OFFSET =>
                    ip2axi_rddata <= s2mm_taildesc9_lsb_i;
                when S2MM_TAILDESC9_MSB_OFFSET =>
                    ip2axi_rddata <= s2mm_taildesc9_msb_i;
                when S2MM_CURDESC10_LSB_OFFSET  =>
                    ip2axi_rddata <= s2mm_curdesc10_lsb_i;
                when S2MM_CURDESC10_MSB_OFFSET  =>
                    ip2axi_rddata <= s2mm_curdesc10_msb_i;
                when S2MM_TAILDESC10_LSB_OFFSET =>
                    ip2axi_rddata <= s2mm_taildesc10_lsb_i;
                when S2MM_TAILDESC10_MSB_OFFSET =>
                    ip2axi_rddata <= s2mm_taildesc10_msb_i;
                when S2MM_CURDESC11_LSB_OFFSET  =>
                    ip2axi_rddata <= s2mm_curdesc11_lsb_i;
                when S2MM_CURDESC11_MSB_OFFSET  =>
                    ip2axi_rddata <= s2mm_curdesc11_msb_i;
                when S2MM_TAILDESC11_LSB_OFFSET =>
                    ip2axi_rddata <= s2mm_taildesc11_lsb_i;
                when S2MM_TAILDESC11_MSB_OFFSET =>
                    ip2axi_rddata <= s2mm_taildesc11_msb_i;
                when S2MM_CURDESC12_LSB_OFFSET  =>
                    ip2axi_rddata <= s2mm_curdesc12_lsb_i;
                when S2MM_CURDESC12_MSB_OFFSET  =>
                    ip2axi_rddata <= s2mm_curdesc12_msb_i;
                when S2MM_TAILDESC12_LSB_OFFSET =>
                    ip2axi_rddata <= s2mm_taildesc12_lsb_i;
                when S2MM_TAILDESC12_MSB_OFFSET =>
                    ip2axi_rddata <= s2mm_taildesc12_msb_i;
                when S2MM_CURDESC13_LSB_OFFSET  =>
                    ip2axi_rddata <= s2mm_curdesc13_lsb_i;
                when S2MM_CURDESC13_MSB_OFFSET  =>
                    ip2axi_rddata <= s2mm_curdesc13_msb_i;
                when S2MM_TAILDESC13_LSB_OFFSET =>
                    ip2axi_rddata <= s2mm_taildesc13_lsb_i;
                when S2MM_TAILDESC13_MSB_OFFSET =>
                    ip2axi_rddata <= s2mm_taildesc13_msb_i;
                when S2MM_CURDESC14_LSB_OFFSET  =>
                    ip2axi_rddata <= s2mm_curdesc14_lsb_i;
                when S2MM_CURDESC14_MSB_OFFSET  =>
                    ip2axi_rddata <= s2mm_curdesc14_msb_i;
                when S2MM_TAILDESC14_LSB_OFFSET =>
                    ip2axi_rddata <= s2mm_taildesc14_lsb_i;
                when S2MM_TAILDESC14_MSB_OFFSET =>
                    ip2axi_rddata <= s2mm_taildesc14_msb_i;
                when S2MM_CURDESC15_LSB_OFFSET  =>
                    ip2axi_rddata <= s2mm_curdesc15_lsb_i;
                when S2MM_CURDESC15_MSB_OFFSET  =>
                    ip2axi_rddata <= s2mm_curdesc15_msb_i;
                when S2MM_TAILDESC15_LSB_OFFSET =>
                    ip2axi_rddata <= s2mm_taildesc15_lsb_i;
                when S2MM_TAILDESC15_MSB_OFFSET =>
                    ip2axi_rddata <= s2mm_taildesc15_msb_i;

                -- coverage off
                when others =>
                    ip2axi_rddata <= (others => '0');

                -- coverage on
            end case;
        end process AXI_LITE_READ_MUX;
end generate GEN_READ_MUX_FOR_SG;

-- Generate read mux for Simple DMA Mode
GEN_READ_MUX_FOR_SMPL_DMA : if C_INCLUDE_SG = 0 generate
begin

ADDR32_MSB : if C_M_AXI_SG_ADDR_WIDTH = 32 generate
begin
mm2s_msb_sa <= (others => '0');
s2mm_msb_sa <= (others => '0');
end generate ADDR32_MSB;


ADDR64_MSB : if C_M_AXI_SG_ADDR_WIDTH > 32 generate
begin
mm2s_msb_sa <= mm2s_sa_i (63 downto 32);
s2mm_msb_sa <= s2mm_da_i (63 downto 32);
end generate ADDR64_MSB;


    AXI_LITE_READ_MUX : process(read_addr            ,
                                mm2s_dmacr_i         ,
                                mm2s_dmasr_i         ,
                                mm2s_sa_i (31 downto 0)            ,
                                mm2s_length_i        ,
                                s2mm_dmacr_i         ,
                                s2mm_dmasr_i         ,
                                s2mm_da_i (31 downto 0)            ,
                                s2mm_length_i        ,
                                mm2s_msb_sa          ,
                                s2mm_msb_sa
                                )
        begin
            case read_addr is
                when MM2S_DMACR_OFFSET        =>
                    ip2axi_rddata <= mm2s_dmacr_i;
                when MM2S_DMASR_OFFSET        =>
                    ip2axi_rddata <= mm2s_dmasr_i;
                when MM2S_SA_OFFSET  =>
                    ip2axi_rddata <= mm2s_sa_i (31 downto 0);
                when MM2S_SA2_OFFSET  =>
                    ip2axi_rddata <= mm2s_msb_sa; --mm2s_sa_i (63 downto 32);
                when MM2S_LENGTH_OFFSET  =>
                    ip2axi_rddata <= LENGTH_PAD & mm2s_length_i;
                when S2MM_DMACR_OFFSET        =>
                    ip2axi_rddata <= s2mm_dmacr_i;
                when S2MM_DMASR_OFFSET       =>
                    ip2axi_rddata <= s2mm_dmasr_i;
                when S2MM_DA_OFFSET  =>
                    ip2axi_rddata <= s2mm_da_i (31 downto 0);
                when S2MM_DA2_OFFSET  =>
                    ip2axi_rddata <= s2mm_msb_sa; --s2mm_da_i (63 downto 32);
                when S2MM_LENGTH_OFFSET  =>
                    ip2axi_rddata <= LENGTH_PAD & s2mm_length_i;
                when others =>
                    ip2axi_rddata <= (others => '0');
            end case;
        end process AXI_LITE_READ_MUX;
end generate GEN_READ_MUX_FOR_SMPL_DMA;



end implementation;
