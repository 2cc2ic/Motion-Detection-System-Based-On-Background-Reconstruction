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
-- Filename:        axi_dma_register_s2mm.vhd
--
-- Description:     This entity encompasses the channel register set.
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
entity  axi_dma_register_s2mm is
    generic(
        C_NUM_REGISTERS             : integer                   := 11       ;
        C_INCLUDE_SG                : integer                   := 1        ;
        C_SG_LENGTH_WIDTH           : integer range 8 to 23     := 14       ;
        C_S_AXI_LITE_DATA_WIDTH     : integer range 32 to 32    := 32       ;
        C_M_AXI_SG_ADDR_WIDTH       : integer range 32 to 64    := 32       ;
        C_NUM_S2MM_CHANNELS         : integer range 1 to 16     := 1        ;
        C_MICRO_DMA                 : integer range 0 to 1      := 0        ;
        C_ENABLE_MULTI_CHANNEL             : integer range 0 to 1      := 0
        --C_CHANNEL_IS_S2MM           : integer range 0 to 1      := 0 CR603034
    );
    port (
        m_axi_sg_aclk               : in  std_logic                         ;          --
        m_axi_sg_aresetn            : in  std_logic                         ;          --
                                                                                       --
        -- AXI Interface Control                                                       --
        axi2ip_wrce                 : in  std_logic_vector                             --
                                        (C_NUM_REGISTERS-1 downto 0)        ;          --
        axi2ip_wrdata               : in  std_logic_vector                             --
                                        (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);          --
                                                                                       --
        -- DMASR Control                                                               --
        stop_dma                    : in  std_logic                         ;          --
        halted_clr                  : in  std_logic                         ;          --
        halted_set                  : in  std_logic                         ;          --
        idle_set                    : in  std_logic                         ;          --
        idle_clr                    : in  std_logic                         ;          --
        ioc_irq_set                 : in  std_logic                         ;          --
        dly_irq_set                 : in  std_logic                         ;          --
        irqdelay_status             : in  std_logic_vector(7 downto 0)      ;          --
        irqthresh_status            : in  std_logic_vector(7 downto 0)      ;          --
        irqthresh_wren              : out std_logic                         ;          --
        irqdelay_wren               : out std_logic                         ;          --
        dlyirq_dsble                : out std_logic                         ;          -- CR605888
                                                                                       --
        -- Error Control                                                               --
        dma_interr_set              : in  std_logic                         ;          --
        dma_slverr_set              : in  std_logic                         ;          --
        dma_decerr_set              : in  std_logic                         ;          --
        ftch_interr_set             : in  std_logic                         ;          --
        ftch_slverr_set             : in  std_logic                         ;          --
        ftch_decerr_set             : in  std_logic                         ;          --
        ftch_error_addr             : in  std_logic_vector                             --
                                        (C_M_AXI_SG_ADDR_WIDTH-1 downto 0)  ;          --
        updt_interr_set             : in  std_logic                         ;          --
        updt_slverr_set             : in  std_logic                         ;          --
        updt_decerr_set             : in  std_logic                         ;          --
        updt_error_addr             : in  std_logic_vector                             --
                                        (C_M_AXI_SG_ADDR_WIDTH-1 downto 0)  ;          --
        error_in                    : in  std_logic                         ;          --
        error_out                   : out std_logic                         ;          --
        introut                     : out std_logic                         ;          --
        soft_reset_in               : in  std_logic                         ;          --
        soft_reset_clr              : in  std_logic                         ;          --
                                                                                       --
        -- CURDESC Update                                                              --
        update_curdesc              : in  std_logic                         ;          --
        tdest_in                    : in  std_logic_vector (5 downto 0)     ;
        new_curdesc                 : in  std_logic_vector                             --
                                        (C_M_AXI_SG_ADDR_WIDTH-1 downto 0)  ;          --
        -- TAILDESC Update                                                             --
        tailpntr_updated            : out std_logic                         ;          --
                                                                                       --
        -- Channel Register Out                                                        --
        sg_ctl                      : out std_logic_vector (7 downto 0)     ;

        dmacr                       : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        dmasr                       : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        curdesc_lsb                 : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        curdesc_msb                 : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        taildesc_lsb                : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        taildesc_msb                : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --

        curdesc1_lsb                 : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        curdesc1_msb                 : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        taildesc1_lsb                : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        taildesc1_msb                : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --

        curdesc2_lsb                 : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        curdesc2_msb                 : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        taildesc2_lsb                : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        taildesc2_msb                : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --

        curdesc3_lsb                 : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        curdesc3_msb                 : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        taildesc3_lsb                : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        taildesc3_msb                : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --

        curdesc4_lsb                 : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        curdesc4_msb                 : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        taildesc4_lsb                : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        taildesc4_msb                : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --

        curdesc5_lsb                 : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        curdesc5_msb                 : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        taildesc5_lsb                : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        taildesc5_msb                : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --

        curdesc6_lsb                 : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        curdesc6_msb                 : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        taildesc6_lsb                : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        taildesc6_msb                : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --

        curdesc7_lsb                 : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        curdesc7_msb                 : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        taildesc7_lsb                : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        taildesc7_msb                : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --

        curdesc8_lsb                 : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        curdesc8_msb                 : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        taildesc8_lsb                : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        taildesc8_msb                : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --

        curdesc9_lsb                 : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        curdesc9_msb                 : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        taildesc9_lsb                : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        taildesc9_msb                : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --

        curdesc10_lsb                 : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        curdesc10_msb                 : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        taildesc10_lsb                : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        taildesc10_msb                : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --

        curdesc11_lsb                 : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        curdesc11_msb                 : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        taildesc11_lsb                : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        taildesc11_msb                : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --

        curdesc12_lsb                 : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        curdesc12_msb                 : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        taildesc12_lsb                : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        taildesc12_msb                : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --

        curdesc13_lsb                 : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        curdesc13_msb                 : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        taildesc13_lsb                : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        taildesc13_msb                : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --

        curdesc14_lsb                 : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        curdesc14_msb                 : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        taildesc14_lsb                : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        taildesc14_msb                : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --

        curdesc15_lsb                 : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        curdesc15_msb                 : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        taildesc15_lsb                : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --
        taildesc15_msb                : out std_logic_vector                             --
                                           (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);       --

        buffer_address              : out std_logic_vector                             --
                                           (C_M_AXI_SG_ADDR_WIDTH-1 downto 0);       --
        buffer_length               : out std_logic_vector                             --
                                           (C_SG_LENGTH_WIDTH-1 downto 0)   ;          --
        buffer_length_wren          : out std_logic                         ;          --
        bytes_received              : in  std_logic_vector                             --
                                           (C_SG_LENGTH_WIDTH-1 downto 0)   ;          --
        bytes_received_wren         : in  std_logic                                    --
    );                                                                                 --
end axi_dma_register_s2mm;

-------------------------------------------------------------------------------
-- Architecture
-------------------------------------------------------------------------------
architecture implementation of axi_dma_register_s2mm is
  attribute DowngradeIPIdentifiedWarnings: string;
  attribute DowngradeIPIdentifiedWarnings of implementation : architecture is "yes";


-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------

-- No Functions Declared

-------------------------------------------------------------------------------
-- Constants Declarations
-------------------------------------------------------------------------------
constant SGCTL_INDEX            : integer := 0;
constant DMACR_INDEX            : integer := 1;                     -- DMACR Register index
constant DMASR_INDEX            : integer := 2;                     -- DMASR Register index
constant CURDESC_LSB_INDEX      : integer := 3;                     -- CURDESC LSB Reg index
constant CURDESC_MSB_INDEX      : integer := 4;                     -- CURDESC MSB Reg index
constant TAILDESC_LSB_INDEX     : integer := 5;                     -- TAILDESC LSB Reg index
constant TAILDESC_MSB_INDEX     : integer := 6;                     -- TAILDESC MSB Reg index

constant CURDESC1_LSB_INDEX      : integer := 17;                     -- CURDESC LSB Reg index
constant CURDESC1_MSB_INDEX      : integer := 18;                     -- CURDESC MSB Reg index
constant TAILDESC1_LSB_INDEX     : integer := 19;                     -- TAILDESC LSB Reg index
constant TAILDESC1_MSB_INDEX     : integer := 20;                     -- TAILDESC MSB Reg index

constant CURDESC2_LSB_INDEX      : integer := 25;                     -- CURDESC LSB Reg index
constant CURDESC2_MSB_INDEX      : integer := 26;                     -- CURDESC MSB Reg index
constant TAILDESC2_LSB_INDEX     : integer := 27;                     -- TAILDESC LSB Reg index
constant TAILDESC2_MSB_INDEX     : integer := 28;                     -- TAILDESC MSB Reg index

constant CURDESC3_LSB_INDEX      : integer := 33;                     -- CURDESC LSB Reg index
constant CURDESC3_MSB_INDEX      : integer := 34;                     -- CURDESC MSB Reg index
constant TAILDESC3_LSB_INDEX     : integer := 35;                     -- TAILDESC LSB Reg index
constant TAILDESC3_MSB_INDEX     : integer := 36;                     -- TAILDESC MSB Reg index

constant CURDESC4_LSB_INDEX      : integer := 41;                     -- CURDESC LSB Reg index
constant CURDESC4_MSB_INDEX      : integer := 42;                     -- CURDESC MSB Reg index
constant TAILDESC4_LSB_INDEX     : integer := 43;                     -- TAILDESC LSB Reg index
constant TAILDESC4_MSB_INDEX     : integer := 44;                     -- TAILDESC MSB Reg index

constant CURDESC5_LSB_INDEX      : integer := 49;                     -- CURDESC LSB Reg index
constant CURDESC5_MSB_INDEX      : integer := 50;                     -- CURDESC MSB Reg index
constant TAILDESC5_LSB_INDEX     : integer := 51;                     -- TAILDESC LSB Reg index
constant TAILDESC5_MSB_INDEX     : integer := 52;                     -- TAILDESC MSB Reg index

constant CURDESC6_LSB_INDEX      : integer := 57;                     -- CURDESC LSB Reg index
constant CURDESC6_MSB_INDEX      : integer := 58;                     -- CURDESC MSB Reg index
constant TAILDESC6_LSB_INDEX     : integer := 59;                     -- TAILDESC LSB Reg index
constant TAILDESC6_MSB_INDEX     : integer := 60;                     -- TAILDESC MSB Reg index

constant CURDESC7_LSB_INDEX      : integer := 65;                     -- CURDESC LSB Reg index
constant CURDESC7_MSB_INDEX      : integer := 66;                     -- CURDESC MSB Reg index
constant TAILDESC7_LSB_INDEX     : integer := 67;                     -- TAILDESC LSB Reg index
constant TAILDESC7_MSB_INDEX     : integer := 68;                     -- TAILDESC MSB Reg index

constant CURDESC8_LSB_INDEX      : integer := 73;                     -- CURDESC LSB Reg index
constant CURDESC8_MSB_INDEX      : integer := 74;                     -- CURDESC MSB Reg index
constant TAILDESC8_LSB_INDEX     : integer := 75;                     -- TAILDESC LSB Reg index
constant TAILDESC8_MSB_INDEX     : integer := 76;                     -- TAILDESC MSB Reg index

constant CURDESC9_LSB_INDEX      : integer := 81;                     -- CURDESC LSB Reg index
constant CURDESC9_MSB_INDEX      : integer := 82;                     -- CURDESC MSB Reg index
constant TAILDESC9_LSB_INDEX     : integer := 83;                     -- TAILDESC LSB Reg index
constant TAILDESC9_MSB_INDEX     : integer := 84;                     -- TAILDESC MSB Reg index

constant CURDESC10_LSB_INDEX      : integer := 89;                     -- CURDESC LSB Reg index
constant CURDESC10_MSB_INDEX      : integer := 90;                     -- CURDESC MSB Reg index
constant TAILDESC10_LSB_INDEX     : integer := 91;                     -- TAILDESC LSB Reg index
constant TAILDESC10_MSB_INDEX     : integer := 92;                     -- TAILDESC MSB Reg index

constant CURDESC11_LSB_INDEX      : integer := 97;                     -- CURDESC LSB Reg index
constant CURDESC11_MSB_INDEX      : integer := 98;                     -- CURDESC MSB Reg index
constant TAILDESC11_LSB_INDEX     : integer := 99;                     -- TAILDESC LSB Reg index
constant TAILDESC11_MSB_INDEX     : integer := 100;                     -- TAILDESC MSB Reg index

constant CURDESC12_LSB_INDEX      : integer := 105;                     -- CURDESC LSB Reg index
constant CURDESC12_MSB_INDEX      : integer := 106;                     -- CURDESC MSB Reg index
constant TAILDESC12_LSB_INDEX     : integer := 107;                     -- TAILDESC LSB Reg index
constant TAILDESC12_MSB_INDEX     : integer := 108;                     -- TAILDESC MSB Reg index

constant CURDESC13_LSB_INDEX      : integer := 113;                     -- CURDESC LSB Reg index
constant CURDESC13_MSB_INDEX      : integer := 114;                     -- CURDESC MSB Reg index
constant TAILDESC13_LSB_INDEX     : integer := 115;                     -- TAILDESC LSB Reg index
constant TAILDESC13_MSB_INDEX     : integer := 116;                     -- TAILDESC MSB Reg index

constant CURDESC14_LSB_INDEX      : integer := 121;                     -- CURDESC LSB Reg index
constant CURDESC14_MSB_INDEX      : integer := 122;                     -- CURDESC MSB Reg index
constant TAILDESC14_LSB_INDEX     : integer := 123;                     -- TAILDESC LSB Reg index
constant TAILDESC14_MSB_INDEX     : integer := 124;                     -- TAILDESC MSB Reg index

constant CURDESC15_LSB_INDEX      : integer := 129;                     -- CURDESC LSB Reg index
constant CURDESC15_MSB_INDEX      : integer := 130;                     -- CURDESC MSB Reg index
constant TAILDESC15_LSB_INDEX     : integer := 131;                     -- TAILDESC LSB Reg index
constant TAILDESC15_MSB_INDEX     : integer := 132;                     -- TAILDESC MSB Reg index


-- CR603034 moved s2mm back to offset 6
--constant SA_ADDRESS_INDEX       : integer := 6;                     -- Buffer Address Reg (SA)
--constant DA_ADDRESS_INDEX       : integer := 8;                     -- Buffer Address Reg (DA)
--
--
--constant BUFF_ADDRESS_INDEX     : integer := address_index_select   -- Buffer Address Reg (SA or DA)
--                                                    (C_CHANNEL_IS_S2MM, -- Channel Type 1=rx 0=tx
--                                                     SA_ADDRESS_INDEX,  -- Source Address Index
--                                                     DA_ADDRESS_INDEX); -- Destination Address Index
constant BUFF_ADDRESS_INDEX     : integer := 7;
constant BUFF_ADDRESS_MSB_INDEX     : integer := 8;
constant BUFF_LENGTH_INDEX      : integer := 11;                    -- Buffer Length Reg

constant ZERO_VALUE             : std_logic_vector(31 downto 0) := (others => '0');

constant DMA_CONFIG             : std_logic_vector(0 downto 0)
                                    := std_logic_vector(to_unsigned(C_INCLUDE_SG,1));

-------------------------------------------------------------------------------
-- Signal / Type Declarations
-------------------------------------------------------------------------------
signal dmacr_i              : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal dmasr_i              : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal curdesc_lsb_i        : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 6) := (others => '0');
signal curdesc_msb_i        : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal taildesc_lsb_i       : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 6) := (others => '0');
signal taildesc_msb_i       : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal buffer_address_i     : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal buffer_address_64_i     : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal buffer_length_i      : std_logic_vector
                                (C_SG_LENGTH_WIDTH-1 downto 0)       := (others => '0');

signal curdesc1_lsb_i        : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal curdesc1_msb_i        : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal taildesc1_lsb_i       : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal taildesc1_msb_i       : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');

signal curdesc2_lsb_i        : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal curdesc2_msb_i        : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal taildesc2_lsb_i       : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal taildesc2_msb_i       : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');

signal curdesc3_lsb_i        : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal curdesc3_msb_i        : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal taildesc3_lsb_i       : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal taildesc3_msb_i       : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');

signal curdesc4_lsb_i        : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal curdesc4_msb_i        : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal taildesc4_lsb_i       : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal taildesc4_msb_i       : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');

signal curdesc5_lsb_i        : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal curdesc5_msb_i        : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal taildesc5_lsb_i       : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal taildesc5_msb_i       : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal curdesc6_lsb_i        : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal curdesc6_msb_i        : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal taildesc6_lsb_i       : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal taildesc6_msb_i       : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');

signal curdesc7_lsb_i        : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal curdesc7_msb_i        : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal taildesc7_lsb_i       : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal taildesc7_msb_i       : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');

signal curdesc8_lsb_i        : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal curdesc8_msb_i        : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal taildesc8_lsb_i       : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal taildesc8_msb_i       : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');

signal curdesc9_lsb_i        : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal curdesc9_msb_i        : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal taildesc9_lsb_i       : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal taildesc9_msb_i       : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');

signal curdesc10_lsb_i        : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal curdesc10_msb_i        : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal taildesc10_lsb_i       : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal taildesc10_msb_i       : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');

signal curdesc11_lsb_i        : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal curdesc11_msb_i        : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal taildesc11_lsb_i       : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal taildesc11_msb_i       : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');

signal curdesc12_lsb_i        : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal curdesc12_msb_i        : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal taildesc12_lsb_i       : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal taildesc12_msb_i       : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');

signal curdesc13_lsb_i        : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal curdesc13_msb_i        : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal taildesc13_lsb_i       : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal taildesc13_msb_i       : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');

signal curdesc14_lsb_i        : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal curdesc14_msb_i        : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal taildesc14_lsb_i       : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal taildesc14_msb_i       : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');

signal curdesc15_lsb_i        : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal curdesc15_msb_i        : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal taildesc15_lsb_i       : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal taildesc15_msb_i       : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');

signal update_curdesc1       : std_logic := '0';
signal update_curdesc2       : std_logic := '0';
signal update_curdesc3       : std_logic := '0';
signal update_curdesc4       : std_logic := '0';
signal update_curdesc5       : std_logic := '0';
signal update_curdesc6       : std_logic := '0';
signal update_curdesc7       : std_logic := '0';
signal update_curdesc8       : std_logic := '0';
signal update_curdesc9       : std_logic := '0';
signal update_curdesc10       : std_logic := '0';
signal update_curdesc11       : std_logic := '0';
signal update_curdesc12       : std_logic := '0';
signal update_curdesc13       : std_logic := '0';
signal update_curdesc14       : std_logic := '0';
signal update_curdesc15       : std_logic := '0';


signal dest0       : std_logic := '0';
signal dest1       : std_logic := '0';
signal dest2       : std_logic := '0';
signal dest3       : std_logic := '0';
signal dest4       : std_logic := '0';
signal dest5       : std_logic := '0';
signal dest6       : std_logic := '0';
signal dest7       : std_logic := '0';
signal dest8       : std_logic := '0';
signal dest9       : std_logic := '0';
signal dest10       : std_logic := '0';
signal dest11       : std_logic := '0';
signal dest12       : std_logic := '0';
signal dest13       : std_logic := '0';
signal dest14       : std_logic := '0';
signal dest15       : std_logic := '0';

-- DMASR Signals
signal halted               : std_logic := '0';
signal idle                 : std_logic := '0';
signal cmplt                : std_logic := '0';
signal error                : std_logic := '0';
signal dma_interr           : std_logic := '0';
signal dma_slverr           : std_logic := '0';
signal dma_decerr           : std_logic := '0';
signal sg_interr            : std_logic := '0';
signal sg_slverr            : std_logic := '0';
signal sg_decerr            : std_logic := '0';
signal ioc_irq              : std_logic := '0';
signal dly_irq              : std_logic := '0';
signal error_d1             : std_logic := '0';
signal error_re             : std_logic := '0';
signal err_irq              : std_logic := '0';

signal sg_ftch_error        : std_logic := '0';
signal sg_updt_error        : std_logic := '0';
signal error_pointer_set    : std_logic := '0';
signal error_pointer_set1    : std_logic := '0';
signal error_pointer_set2    : std_logic := '0';
signal error_pointer_set3    : std_logic := '0';
signal error_pointer_set4    : std_logic := '0';
signal error_pointer_set5    : std_logic := '0';
signal error_pointer_set6    : std_logic := '0';
signal error_pointer_set7    : std_logic := '0';
signal error_pointer_set8    : std_logic := '0';
signal error_pointer_set9    : std_logic := '0';
signal error_pointer_set10    : std_logic := '0';
signal error_pointer_set11    : std_logic := '0';
signal error_pointer_set12    : std_logic := '0';
signal error_pointer_set13    : std_logic := '0';
signal error_pointer_set14    : std_logic := '0';
signal error_pointer_set15    : std_logic := '0';

-- interrupt coalescing support signals
signal different_delay      : std_logic := '0';
signal different_thresh     : std_logic := '0';
signal threshold_is_zero    : std_logic := '0';
-- soft reset support signals
signal soft_reset_i         : std_logic := '0';
signal run_stop_clr         : std_logic := '0';

signal tail_update_lsb      : std_logic := '0';
signal tail_update_msb      : std_logic := '0';

signal sg_cache_info        : std_logic_vector (7 downto 0);

signal halt_free : std_logic := '0';
signal tmp11 : std_logic := '0';
signal sig_cur_updated : std_logic := '0';

signal tailpntr_updated_d1 : std_logic;
signal tailpntr_updated_d2 : std_logic;

-------------------------------------------------------------------------------
-- Begin architecture logic
-------------------------------------------------------------------------------
begin

GEN_MULTI_CH : if C_ENABLE_MULTI_CHANNEL = 1 generate
begin
   halt_free <= '1';

end generate GEN_MULTI_CH;

GEN_NOMULTI_CH : if C_ENABLE_MULTI_CHANNEL = 0 generate
begin
   halt_free <= dmasr_i(DMASR_HALTED_BIT);

end generate GEN_NOMULTI_CH;

GEN_DESC_UPDATE_FOR_SG : if C_NUM_S2MM_CHANNELS = 1 generate
begin
update_curdesc1  <= '0';
update_curdesc2  <= '0';
update_curdesc3  <= '0';
update_curdesc4  <= '0';
update_curdesc5  <= '0';
update_curdesc6  <= '0';
update_curdesc7  <= '0';
update_curdesc8  <= '0';
update_curdesc9  <= '0';
update_curdesc10 <= '0';
update_curdesc11 <= '0';
update_curdesc12 <= '0';
update_curdesc13 <= '0';
update_curdesc14 <= '0';
update_curdesc15 <= '0';

end generate GEN_DESC_UPDATE_FOR_SG;


dest0  <= '1' when tdest_in (4 downto 0) =  "00000" else '0';
dest1  <= '1' when tdest_in (4 downto 0) =  "00001" else '0';
dest2  <= '1' when tdest_in (4 downto 0) =  "00010" else '0';
dest3  <= '1' when tdest_in (4 downto 0) =  "00011" else '0';
dest4  <= '1' when tdest_in (4 downto 0) =  "00100" else '0';
dest5  <= '1' when tdest_in (4 downto 0) =  "00101" else '0';
dest6  <= '1' when tdest_in (4 downto 0) =  "00110" else '0';
dest7  <= '1' when tdest_in (4 downto 0) =  "00111" else '0';
dest8  <= '1' when tdest_in (4 downto 0) =  "01000" else '0';
dest9  <= '1' when tdest_in (4 downto 0) =  "01001" else '0';
dest10 <= '1' when tdest_in (4 downto 0) =  "01010" else '0';
dest11 <= '1' when tdest_in (4 downto 0) =  "01011" else '0';
dest12 <= '1' when tdest_in (4 downto 0) =  "01100" else '0';
dest13 <= '1' when tdest_in (4 downto 0) =  "01101" else '0';
dest14 <= '1' when tdest_in (4 downto 0) =  "01110" else '0';
dest15 <= '1' when tdest_in (4 downto 0) =  "01111" else '0';


GEN_DESC_UPDATE_FOR_SG_CH : if C_NUM_S2MM_CHANNELS > 1 generate

update_curdesc1  <= update_curdesc when tdest_in (4 downto 0) =  "00001" else '0';
update_curdesc2  <= update_curdesc when tdest_in (4 downto 0) =  "00010" else '0';
update_curdesc3  <= update_curdesc when tdest_in (4 downto 0) =  "00011" else '0';
update_curdesc4  <= update_curdesc when tdest_in (4 downto 0) =  "00100" else '0';
update_curdesc5  <= update_curdesc when tdest_in (4 downto 0) =  "00101" else '0';
update_curdesc6  <= update_curdesc when tdest_in (4 downto 0) =  "00110" else '0';
update_curdesc7  <= update_curdesc when tdest_in (4 downto 0) =  "00111" else '0';
update_curdesc8  <= update_curdesc when tdest_in (4 downto 0) =  "01000" else '0';
update_curdesc9  <= update_curdesc when tdest_in (4 downto 0) =  "01001" else '0';
update_curdesc10 <= update_curdesc when tdest_in (4 downto 0) =  "01010" else '0';
update_curdesc11 <= update_curdesc when tdest_in (4 downto 0) =  "01011" else '0';
update_curdesc12 <= update_curdesc when tdest_in (4 downto 0) =  "01100" else '0';
update_curdesc13 <= update_curdesc when tdest_in (4 downto 0) =  "01101" else '0';
update_curdesc14 <= update_curdesc when tdest_in (4 downto 0) =  "01110" else '0';
update_curdesc15 <= update_curdesc when tdest_in (4 downto 0) =  "01111" else '0';
end generate GEN_DESC_UPDATE_FOR_SG_CH;

    GEN_DA_ADDR_EQL64 : if C_M_AXI_SG_ADDR_WIDTH > 32 generate
    begin

    buffer_address          <= buffer_address_64_i & buffer_address_i ;

    end generate GEN_DA_ADDR_EQL64;

    GEN_DA_ADDR_EQL32 : if C_M_AXI_SG_ADDR_WIDTH = 32 generate
    begin

    buffer_address          <= buffer_address_i ;

    end generate GEN_DA_ADDR_EQL32;


dmacr                   <= dmacr_i          ;
dmasr                   <= dmasr_i          ;
curdesc_lsb             <= curdesc_lsb_i (31 downto 6) & "000000"    ;
curdesc_msb             <= curdesc_msb_i    ;
taildesc_lsb            <= taildesc_lsb_i (31 downto 6) & "000000"   ;
taildesc_msb            <= taildesc_msb_i   ;
buffer_length           <= buffer_length_i  ;

curdesc1_lsb             <= curdesc1_lsb_i    ;
curdesc1_msb             <= curdesc1_msb_i    ;
taildesc1_lsb            <= taildesc1_lsb_i   ;
taildesc1_msb            <= taildesc1_msb_i   ;

curdesc2_lsb             <= curdesc2_lsb_i    ;
curdesc2_msb             <= curdesc2_msb_i    ;
taildesc2_lsb            <= taildesc2_lsb_i   ;
taildesc2_msb            <= taildesc2_msb_i   ;

curdesc3_lsb             <= curdesc3_lsb_i    ;
curdesc3_msb             <= curdesc3_msb_i    ;
taildesc3_lsb            <= taildesc3_lsb_i   ;
taildesc3_msb            <= taildesc3_msb_i   ;

curdesc4_lsb             <= curdesc4_lsb_i    ;
curdesc4_msb             <= curdesc4_msb_i    ;
taildesc4_lsb            <= taildesc4_lsb_i   ;
taildesc4_msb            <= taildesc4_msb_i   ;

curdesc5_lsb             <= curdesc5_lsb_i    ;
curdesc5_msb             <= curdesc5_msb_i    ;
taildesc5_lsb            <= taildesc5_lsb_i   ;
taildesc5_msb            <= taildesc5_msb_i   ;

curdesc6_lsb             <= curdesc6_lsb_i    ;
curdesc6_msb             <= curdesc6_msb_i    ;
taildesc6_lsb            <= taildesc6_lsb_i   ;
taildesc6_msb            <= taildesc6_msb_i   ;

curdesc7_lsb             <= curdesc7_lsb_i    ;
curdesc7_msb             <= curdesc7_msb_i    ;
taildesc7_lsb            <= taildesc7_lsb_i   ;
taildesc7_msb            <= taildesc7_msb_i   ;

curdesc8_lsb             <= curdesc8_lsb_i    ;
curdesc8_msb             <= curdesc8_msb_i    ;
taildesc8_lsb            <= taildesc8_lsb_i   ;
taildesc8_msb            <= taildesc8_msb_i   ;

curdesc9_lsb             <= curdesc9_lsb_i    ;
curdesc9_msb             <= curdesc9_msb_i    ;
taildesc9_lsb            <= taildesc9_lsb_i   ;
taildesc9_msb            <= taildesc9_msb_i   ;

curdesc10_lsb             <= curdesc10_lsb_i    ;
curdesc10_msb             <= curdesc10_msb_i    ;
taildesc10_lsb            <= taildesc10_lsb_i   ;
taildesc10_msb            <= taildesc10_msb_i   ;

curdesc11_lsb             <= curdesc11_lsb_i    ;
curdesc11_msb             <= curdesc11_msb_i    ;
taildesc11_lsb            <= taildesc11_lsb_i   ;
taildesc11_msb            <= taildesc11_msb_i   ;

curdesc12_lsb             <= curdesc12_lsb_i    ;
curdesc12_msb             <= curdesc12_msb_i    ;
taildesc12_lsb            <= taildesc12_lsb_i   ;
taildesc12_msb            <= taildesc12_msb_i   ;


curdesc13_lsb             <= curdesc13_lsb_i    ;
curdesc13_msb             <= curdesc13_msb_i    ;
taildesc13_lsb            <= taildesc13_lsb_i   ;
taildesc13_msb            <= taildesc13_msb_i   ;

curdesc14_lsb             <= curdesc14_lsb_i    ;
curdesc14_msb             <= curdesc14_msb_i    ;
taildesc14_lsb            <= taildesc14_lsb_i   ;
taildesc14_msb            <= taildesc14_msb_i   ;

curdesc15_lsb             <= curdesc15_lsb_i    ;
curdesc15_msb             <= curdesc15_msb_i    ;
taildesc15_lsb            <= taildesc15_lsb_i   ;
taildesc15_msb            <= taildesc15_msb_i   ;

---------------------------------------------------------------------------
-- DMA Control Register
---------------------------------------------------------------------------
-- DMACR - Interrupt Delay Value
-------------------------------------------------------------------------------
DMACR_DELAY : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0')then
                dmacr_i(DMACR_IRQDELAY_MSB_BIT
                 downto DMACR_IRQDELAY_LSB_BIT) <= (others => '0');
            elsif(axi2ip_wrce(DMACR_INDEX) = '1')then
                dmacr_i(DMACR_IRQDELAY_MSB_BIT
                 downto DMACR_IRQDELAY_LSB_BIT) <= axi2ip_wrdata(DMACR_IRQDELAY_MSB_BIT
                                                          downto DMACR_IRQDELAY_LSB_BIT);
            end if;
        end if;
    end process DMACR_DELAY;

-- If written delay is different than previous value then assert write enable
different_delay <= '1' when dmacr_i(DMACR_IRQDELAY_MSB_BIT downto DMACR_IRQDELAY_LSB_BIT)
                   /= axi2ip_wrdata(DMACR_IRQDELAY_MSB_BIT downto DMACR_IRQDELAY_LSB_BIT)
              else '0';

-- delay value different, drive write of delay value to interrupt controller
NEW_DELAY_WRITE : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0')then
                irqdelay_wren <= '0';
            -- If AXI Lite write to DMACR and delay different than current
            -- setting then update delay value
            elsif(axi2ip_wrce(DMACR_INDEX) = '1' and different_delay = '1')then
                irqdelay_wren <= '1';
            else
                irqdelay_wren <= '0';
            end if;
        end if;
    end process NEW_DELAY_WRITE;

-------------------------------------------------------------------------------
-- DMACR - Interrupt Threshold Value
-------------------------------------------------------------------------------
threshold_is_zero <= '1' when axi2ip_wrdata(DMACR_IRQTHRESH_MSB_BIT
                                     downto DMACR_IRQTHRESH_LSB_BIT) = ZERO_THRESHOLD
                else '0';

DMACR_THRESH : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0')then
                dmacr_i(DMACR_IRQTHRESH_MSB_BIT
                        downto DMACR_IRQTHRESH_LSB_BIT) <= ONE_THRESHOLD;
            -- On AXI Lite write
            elsif(axi2ip_wrce(DMACR_INDEX) = '1')then

                -- If value is 0 then set threshold to 1
                if(threshold_is_zero='1')then
                    dmacr_i(DMACR_IRQTHRESH_MSB_BIT
                     downto DMACR_IRQTHRESH_LSB_BIT)    <= ONE_THRESHOLD;

                -- else set threshold to axi lite wrdata value
                else
                    dmacr_i(DMACR_IRQTHRESH_MSB_BIT
                     downto DMACR_IRQTHRESH_LSB_BIT)    <= axi2ip_wrdata(DMACR_IRQTHRESH_MSB_BIT
                                                                  downto DMACR_IRQTHRESH_LSB_BIT);
                end if;
            end if;
        end if;
    end process DMACR_THRESH;

-- If written threshold is different than previous value then assert write enable
different_thresh <= '1' when dmacr_i(DMACR_IRQTHRESH_MSB_BIT downto DMACR_IRQTHRESH_LSB_BIT)
                    /= axi2ip_wrdata(DMACR_IRQTHRESH_MSB_BIT downto DMACR_IRQTHRESH_LSB_BIT)
              else '0';

-- new treshold written therefore drive write of threshold out
NEW_THRESH_WRITE : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0')then
                irqthresh_wren <= '0';
            -- If AXI Lite write to DMACR and threshold different than current
            -- setting then update threshold value
            elsif(axi2ip_wrce(DMACR_INDEX) = '1' and different_thresh = '1')then
                irqthresh_wren <= '1';
            else
                irqthresh_wren <= '0';
            end if;
        end if;
    end process NEW_THRESH_WRITE;

-------------------------------------------------------------------------------
-- DMACR - Remainder of DMA Control Register, Key Hole write bit (3)
-------------------------------------------------------------------------------
DMACR_REGISTER : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0')then
                dmacr_i(DMACR_IRQTHRESH_LSB_BIT-1
                        downto DMACR_RESERVED5_BIT)   <= (others => '0');

            elsif(axi2ip_wrce(DMACR_INDEX) = '1')then
                dmacr_i(DMACR_IRQTHRESH_LSB_BIT-1       -- bit 15
                        downto DMACR_RESERVED5_BIT)   <= ZERO_VALUE(DMACR_RESERVED15_BIT)
                                                        -- bit 14
                                                        & axi2ip_wrdata(DMACR_ERR_IRQEN_BIT)
                                                        -- bit 13
                                                        & axi2ip_wrdata(DMACR_DLY_IRQEN_BIT)
                                                        -- bit 12
                                                        & axi2ip_wrdata(DMACR_IOC_IRQEN_BIT)
                                                        -- bits 11 downto 3
                                                        & ZERO_VALUE(DMACR_RESERVED11_BIT downto DMACR_RESERVED5_BIT);

            end if;
        end if;
    end process DMACR_REGISTER;


DMACR_REGISTER1 : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0' or C_ENABLE_MULTI_CHANNEL = 1)then
                dmacr_i(DMACR_KH_BIT)  <= '0';
                dmacr_i(CYCLIC_BIT)  <= '0';

            elsif(axi2ip_wrce(DMACR_INDEX) = '1')then

                dmacr_i(DMACR_KH_BIT)  <= axi2ip_wrdata(DMACR_KH_BIT);
                dmacr_i(CYCLIC_BIT)  <= axi2ip_wrdata(CYCLIC_BIT);
            end if;
        end if;
    end process DMACR_REGISTER1;

-------------------------------------------------------------------------------
-- DMACR - Reset Bit
-------------------------------------------------------------------------------
DMACR_RESET : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(soft_reset_clr = '1')then
                dmacr_i(DMACR_RESET_BIT)  <= '0';
            -- If soft reset set in other channel then set
            -- reset bit here too
            elsif(soft_reset_in = '1')then
                dmacr_i(DMACR_RESET_BIT)  <= '1';

            -- If DMACR Write then pass axi lite write bus to DMARC reset bit
            elsif(soft_reset_i = '0' and axi2ip_wrce(DMACR_INDEX) = '1')then
                dmacr_i(DMACR_RESET_BIT)  <= axi2ip_wrdata(DMACR_RESET_BIT);

            end if;
        end if;
    end process DMACR_RESET;

soft_reset_i <= dmacr_i(DMACR_RESET_BIT);

-------------------------------------------------------------------------------
-- Tail Pointer Enable fixed at 1 for this release of axi dma
-------------------------------------------------------------------------------
dmacr_i(DMACR_TAILPEN_BIT) <= '1';

-------------------------------------------------------------------------------
-- DMACR - Run/Stop Bit
-------------------------------------------------------------------------------
run_stop_clr <= '1' when error = '1'                -- MM2S DataMover Error
                      or error_in = '1'             -- S2MM Error
                      or stop_dma = '1'             -- Stop due to error
                      or soft_reset_i = '1'         -- MM2S Soft Reset
                      or soft_reset_in  = '1'       -- S2MM Soft Reset
           else '0';


DMACR_RUNSTOP : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0')then
                dmacr_i(DMACR_RS_BIT)  <= '0';
            -- Clear on sg error (i.e. error) or other channel
            -- error (i.e. error_in) or dma error or soft reset
            elsif(run_stop_clr = '1')then
                dmacr_i(DMACR_RS_BIT)  <= '0';
            elsif(axi2ip_wrce(DMACR_INDEX) = '1')then
                dmacr_i(DMACR_RS_BIT)  <= axi2ip_wrdata(DMACR_RS_BIT);
            end if;
        end if;
    end process DMACR_RUNSTOP;

---------------------------------------------------------------------------
-- DMA Status Halted bit (BIT 0) - Set by dma controller indicating DMA
-- channel is halted.
---------------------------------------------------------------------------
DMASR_HALTED : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0' or halted_set = '1')then
                halted <= '1';
            elsif(halted_clr = '1')then
                halted <= '0';
            end if;
        end if;
    end process DMASR_HALTED;

---------------------------------------------------------------------------
-- DMA Status Idle bit (BIT 1) - Set by dma controller indicating DMA
-- channel is IDLE waiting at tail pointer.  Update of Tail Pointer
-- will cause engine to resume.  Note: Halted channels return to a
-- reset condition.
---------------------------------------------------------------------------
DMASR_IDLE : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0'
            or idle_clr = '1'
            or halted_set = '1')then
                idle   <= '0';

            elsif(idle_set = '1')then
                idle   <= '1';
            end if;
        end if;
    end process DMASR_IDLE;

---------------------------------------------------------------------------
-- DMA Status Error bit (BIT 3)
-- Note: any error will cause entire engine to halt
---------------------------------------------------------------------------
error  <= dma_interr
            or dma_slverr
            or dma_decerr
            or sg_interr
            or sg_slverr
            or sg_decerr;

-- Scatter Gather Error
--sg_ftch_error <= ftch_interr_set or ftch_slverr_set or ftch_decerr_set;

-- SG Update Errors or DMA errors assert flag on descriptor update
-- Used to latch current descriptor pointer
--sg_updt_error <= updt_interr_set or updt_slverr_set or updt_decerr_set
--              or dma_interr or dma_slverr or dma_decerr;

-- Map out to halt opposing channel
error_out   <= error;


SG_FTCH_ERROR_PROC : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0')then
                sg_ftch_error <= '0';
                sg_updt_error <= '0';
            else
                sg_ftch_error <= ftch_interr_set or ftch_slverr_set or ftch_decerr_set;
                sg_updt_error <= updt_interr_set or updt_slverr_set or updt_decerr_set
                                 or dma_interr or dma_slverr or dma_decerr;
            end if;
        end if;
    end process SG_FTCH_ERROR_PROC;

---------------------------------------------------------------------------
-- DMA Status DMA Internal Error bit (BIT 4)
---------------------------------------------------------------------------
DMASR_DMAINTERR : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0')then
                dma_interr <= '0';
            elsif(dma_interr_set = '1' )then
                dma_interr <= '1';
            end if;
        end if;
    end process DMASR_DMAINTERR;

---------------------------------------------------------------------------
-- DMA Status DMA Slave Error bit (BIT 5)
---------------------------------------------------------------------------
DMASR_DMASLVERR : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0')then
                dma_slverr <= '0';

            elsif(dma_slverr_set = '1' )then
                dma_slverr <= '1';

            end if;
        end if;
    end process DMASR_DMASLVERR;

---------------------------------------------------------------------------
-- DMA Status DMA Decode Error bit (BIT 6)
---------------------------------------------------------------------------
DMASR_DMADECERR : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0')then
                dma_decerr <= '0';

            elsif(dma_decerr_set = '1' )then
                dma_decerr <= '1';

            end if;
        end if;
    end process DMASR_DMADECERR;

---------------------------------------------------------------------------
-- DMA Status SG Internal Error bit (BIT 8)
-- (SG Mode only - trimmed at build time if simple mode)
---------------------------------------------------------------------------
DMASR_SGINTERR : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0')then
                sg_interr <= '0';

            elsif(ftch_interr_set = '1' or updt_interr_set = '1')then
                sg_interr <= '1';


            end if;
        end if;
    end process DMASR_SGINTERR;

---------------------------------------------------------------------------
-- DMA Status SG Slave Error bit (BIT 9)
-- (SG Mode only - trimmed at build time if simple mode)
---------------------------------------------------------------------------
DMASR_SGSLVERR : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0')then
                sg_slverr <= '0';

            elsif(ftch_slverr_set = '1' or updt_slverr_set = '1')then
                sg_slverr <= '1';

            end if;
        end if;
    end process DMASR_SGSLVERR;

---------------------------------------------------------------------------
-- DMA Status SG Decode Error bit (BIT 10)
-- (SG Mode only - trimmed at build time if simple mode)
---------------------------------------------------------------------------
DMASR_SGDECERR : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0')then
                sg_decerr <= '0';

            elsif(ftch_decerr_set = '1' or updt_decerr_set = '1')then
                sg_decerr <= '1';

            end if;
        end if;
    end process DMASR_SGDECERR;

---------------------------------------------------------------------------
-- DMA Status IOC Interrupt status bit (BIT 11)
---------------------------------------------------------------------------
DMASR_IOCIRQ : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0')then
                ioc_irq <= '0';

            -- CPU Writing a '1' to clear - OR'ed with setting to prevent
            -- missing a 'set' during the write.
            elsif(axi2ip_wrce(DMASR_INDEX) = '1' )then

                ioc_irq <= (ioc_irq and not(axi2ip_wrdata(DMASR_IOCIRQ_BIT)))
                             or ioc_irq_set;

            elsif(ioc_irq_set = '1')then
                ioc_irq <= '1';

            end if;
        end if;
    end process DMASR_IOCIRQ;

---------------------------------------------------------------------------
-- DMA Status Delay Interrupt status bit (BIT 12)
---------------------------------------------------------------------------
DMASR_DLYIRQ : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0')then
                dly_irq <= '0';

            -- CPU Writing a '1' to clear - OR'ed with setting to prevent
            -- missing a 'set' during the write.
            elsif(axi2ip_wrce(DMASR_INDEX) = '1' )then

                dly_irq <= (dly_irq and not(axi2ip_wrdata(DMASR_DLYIRQ_BIT)))
                             or dly_irq_set;

            elsif(dly_irq_set = '1')then
                dly_irq <= '1';

            end if;
        end if;
    end process DMASR_DLYIRQ;

-- CR605888 Disable delay timer if halted or on delay irq set
--dlyirq_dsble    <= dmasr_i(DMASR_HALTED_BIT)              -- CR606348
dlyirq_dsble    <= not dmacr_i(DMACR_RS_BIT)                -- CR606348
                    or dmasr_i(DMASR_DLYIRQ_BIT);



---------------------------------------------------------------------------
-- DMA Status Error Interrupt status bit (BIT 12)
---------------------------------------------------------------------------
-- Delay error setting for generation of error strobe
GEN_ERROR_RE : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0')then
                error_d1 <= '0';
            else
                error_d1 <= error;
            end if;
        end if;
    end process GEN_ERROR_RE;

-- Generate rising edge pulse on error
error_re   <= error and not error_d1;

DMASR_ERRIRQ : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0')then
                err_irq <= '0';

            -- CPU Writing a '1' to clear - OR'ed with setting to prevent
            -- missing a 'set' during the write.
            elsif(axi2ip_wrce(DMASR_INDEX) = '1' )then

                err_irq <= (err_irq and not(axi2ip_wrdata(DMASR_ERRIRQ_BIT)))
                             or error_re;

            elsif(error_re = '1')then
                err_irq <= '1';

            end if;
        end if;
    end process DMASR_ERRIRQ;

---------------------------------------------------------------------------
-- DMA Interrupt OUT
---------------------------------------------------------------------------
REG_INTR : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0' or soft_reset_i = '1')then
                introut <= '0';
            else
                introut <= (dly_irq and dmacr_i(DMACR_DLY_IRQEN_BIT))
                        or (ioc_irq and dmacr_i(DMACR_IOC_IRQEN_BIT))
                        or (err_irq and dmacr_i(DMACR_ERR_IRQEN_BIT));
            end if;
        end if;
    end process;

---------------------------------------------------------------------------
-- DMA Status Register
---------------------------------------------------------------------------
dmasr_i    <=  irqdelay_status         -- Bits 31 downto 24
                    & irqthresh_status -- Bits 23 downto 16
                    & '0'              -- Bit  15
                    & err_irq          -- Bit  14
                    & dly_irq          -- Bit  13
                    & ioc_irq          -- Bit  12
                    & '0'              -- Bit  11
                    & sg_decerr        -- Bit  10
                    & sg_slverr        -- Bit  9
                    & sg_interr        -- Bit  8
                    & '0'              -- Bit  7
                    & dma_decerr       -- Bit  6
                    & dma_slverr       -- Bit  5
                    & dma_interr       -- Bit  4
                    & DMA_CONFIG       -- Bit  3
                    & '0'              -- Bit  2
                    & idle             -- Bit  1
                    & halted;          -- Bit  0





-- Generate current descriptor and tail descriptor register for Scatter Gather Mode
GEN_DESC_REG_FOR_SG : if C_INCLUDE_SG = 1 generate
begin

   GEN_SG_CTL_REG : if C_ENABLE_MULTI_CHANNEL = 1 generate
   begin

   MM2S_SGCTL : process(m_axi_sg_aclk)
      begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0')then
                sg_cache_info <= "00000011"; --(others => '0');

            elsif(axi2ip_wrce(SGCTL_INDEX) = '1' ) then

                sg_cache_info <= axi2ip_wrdata(11 downto 8) & axi2ip_wrdata(3 downto 0);
            else
              sg_cache_info <= sg_cache_info;

            end if;
        end if;
      end process MM2S_SGCTL;

      sg_ctl <= sg_cache_info;

   end generate GEN_SG_CTL_REG;

   GEN_SG_NO_CTL_REG : if C_ENABLE_MULTI_CHANNEL = 0 generate
   begin

                sg_ctl <= "00000011"; --(others => '0');


   end generate GEN_SG_NO_CTL_REG;


    -- Signals not used for Scatter Gather Mode, only simple mode
    buffer_address_i    <= (others => '0');
    buffer_length_i     <= (others => '0');
    buffer_length_wren  <= '0';

    ---------------------------------------------------------------------------
    -- Current Descriptor LSB Register
    ---------------------------------------------------------------------------
    CURDESC_LSB_REGISTER : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    curdesc_lsb_i  <= (others => '0');
                    error_pointer_set   <= '0';

                -- Detected error has NOT register a desc pointer
                elsif(error_pointer_set = '0')then

                    -- Scatter Gather Fetch Error
                    if((sg_ftch_error = '1' or sg_updt_error = '1') and dest0 = '1')then
                        curdesc_lsb_i       <= ftch_error_addr(C_S_AXI_LITE_DATA_WIDTH-1 downto 6);
                        error_pointer_set   <= '1';
                    -- Scatter Gather Update Error
             --       elsif(sg_updt_error = '1' and dest0 = '1')then
             --           curdesc_lsb_i       <= updt_error_addr(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
             --           error_pointer_set   <= '1';

                    -- Commanded to update descriptor value - used for indicating
                    -- current descriptor begin processed by dma controller
                    elsif(update_curdesc = '1' and dmacr_i(DMACR_RS_BIT)  = '1'  and dest0 = '1')then
                        curdesc_lsb_i       <= new_curdesc(C_S_AXI_LITE_DATA_WIDTH-1 downto 6);
                        error_pointer_set   <= '0';

                    -- CPU update of current descriptor pointer.  CPU
                    -- only allowed to update when engine is halted.
                    elsif(axi2ip_wrce(CURDESC_LSB_INDEX) = '1' and halt_free = '1')then
                        curdesc_lsb_i       <= axi2ip_wrdata(CURDESC_LOWER_MSB_BIT
                                                      downto CURDESC_LOWER_LSB_BIT);
--                                              & ZERO_VALUE(CURDESC_RESERVED_BIT5
--                                                      downto CURDESC_RESERVED_BIT0);
                        error_pointer_set   <= '0';

                    end if;
                end if;
            end if;
        end process CURDESC_LSB_REGISTER;


         


    ---------------------------------------------------------------------------
    -- Tail Descriptor LSB Register
    ---------------------------------------------------------------------------
    TAILDESC_LSB_REGISTER : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    taildesc_lsb_i  <= (others => '0');
                elsif(axi2ip_wrce(TAILDESC_LSB_INDEX) = '1')then
                    taildesc_lsb_i  <= axi2ip_wrdata(TAILDESC_LOWER_MSB_BIT
                                              downto TAILDESC_LOWER_LSB_BIT);
--                                       & ZERO_VALUE(TAILDESC_RESERVED_BIT5
--                                              downto TAILDESC_RESERVED_BIT0);

                end if;
            end if;
        end process TAILDESC_LSB_REGISTER;

GEN_DESC1_REG_FOR_SG : if C_NUM_S2MM_CHANNELS > 1 generate


    CURDESC1_LSB_REGISTER : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    curdesc1_lsb_i  <= (others => '0');
                    error_pointer_set1   <= '0';

                -- Detected error has NOT register a desc pointer
                elsif(error_pointer_set1 = '0')then

                    -- Scatter Gather Fetch Error
                    if((sg_ftch_error = '1' or sg_updt_error = '1') and dest1 = '1')then
                        curdesc1_lsb_i       <= ftch_error_addr(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
                        error_pointer_set1   <= '1';
                    -- Scatter Gather Update Error
--                    elsif(sg_updt_error = '1' and dest1 = '1')then
--                        curdesc1_lsb_i       <= updt_error_addr(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
--                        error_pointer_set1   <= '1';

                    -- Commanded to update descriptor value - used for indicating
                    -- current descriptor begin processed by dma controller
                    elsif(update_curdesc1 = '1' and dmacr_i(DMACR_RS_BIT)  = '1'  and dest1 = '1')then
                        curdesc1_lsb_i       <= new_curdesc(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
                        error_pointer_set1   <= '0';

                    -- CPU update of current descriptor pointer.  CPU
                    -- only allowed to update when engine is halted.
                    elsif(axi2ip_wrce(CURDESC1_LSB_INDEX) = '1' and halt_free = '1')then
                        curdesc1_lsb_i       <= axi2ip_wrdata(CURDESC_LOWER_MSB_BIT
                                                      downto CURDESC_LOWER_LSB_BIT)
                                              & ZERO_VALUE(CURDESC_RESERVED_BIT5
                                                      downto CURDESC_RESERVED_BIT0);
                        error_pointer_set1   <= '0';

                    end if;
                end if;
            end if;
        end process CURDESC1_LSB_REGISTER;

    ---------------------------------------------------------------------------
    -- Tail Descriptor LSB Register
    ---------------------------------------------------------------------------
    TAILDESC1_LSB_REGISTER : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    taildesc1_lsb_i  <= (others => '0');
                elsif(axi2ip_wrce(TAILDESC1_LSB_INDEX) = '1')then
                    taildesc1_lsb_i  <= axi2ip_wrdata(TAILDESC_LOWER_MSB_BIT
                                              downto TAILDESC_LOWER_LSB_BIT)
                                       & ZERO_VALUE(TAILDESC_RESERVED_BIT5
                                              downto TAILDESC_RESERVED_BIT0);

                end if;
            end if;
        end process TAILDESC1_LSB_REGISTER;

end generate GEN_DESC1_REG_FOR_SG;


GEN_DESC2_REG_FOR_SG : if C_NUM_S2MM_CHANNELS > 2 generate

    CURDESC2_LSB_REGISTER : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    curdesc2_lsb_i  <= (others => '0');
                    error_pointer_set2   <= '0';

                -- Detected error has NOT register a desc pointer
                elsif(error_pointer_set2 = '0')then

                    -- Scatter Gather Fetch Error
                    if((sg_ftch_error = '1' or sg_updt_error = '1') and dest2 = '1')then
                        curdesc2_lsb_i       <= ftch_error_addr(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
                        error_pointer_set2   <= '1';
                    -- Scatter Gather Update Error
--                    elsif(sg_updt_error = '1' and dest2 = '1')then
--                        curdesc2_lsb_i       <= updt_error_addr(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
--                        error_pointer_set2   <= '1';

                    -- Commanded to update descriptor value - used for indicating
                    -- current descriptor begin processed by dma controller
                    elsif(update_curdesc2 = '1' and dmacr_i(DMACR_RS_BIT)  = '1' and dest2 = '1')then
                        curdesc2_lsb_i       <= new_curdesc(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
                        error_pointer_set2   <= '0';

                    -- CPU update of current descriptor pointer.  CPU
                    -- only allowed to update when engine is halted.
                    elsif(axi2ip_wrce(CURDESC2_LSB_INDEX) = '1' and halt_free = '1')then
                        curdesc2_lsb_i       <= axi2ip_wrdata(CURDESC_LOWER_MSB_BIT
                                                      downto CURDESC_LOWER_LSB_BIT)
                                              & ZERO_VALUE(CURDESC_RESERVED_BIT5
                                                      downto CURDESC_RESERVED_BIT0);
                        error_pointer_set2   <= '0';

                    end if;
                end if;
            end if;
        end process CURDESC2_LSB_REGISTER;

    TAILDESC2_LSB_REGISTER : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    taildesc2_lsb_i  <= (others => '0');
                elsif(axi2ip_wrce(TAILDESC2_LSB_INDEX) = '1')then
                    taildesc2_lsb_i  <= axi2ip_wrdata(TAILDESC_LOWER_MSB_BIT
                                              downto TAILDESC_LOWER_LSB_BIT)
                                       & ZERO_VALUE(TAILDESC_RESERVED_BIT5
                                              downto TAILDESC_RESERVED_BIT0);

                end if;
            end if;
        end process TAILDESC2_LSB_REGISTER;

end generate GEN_DESC2_REG_FOR_SG;

GEN_DESC3_REG_FOR_SG : if C_NUM_S2MM_CHANNELS > 3 generate

    CURDESC3_LSB_REGISTER : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    curdesc3_lsb_i  <= (others => '0');
                    error_pointer_set3   <= '0';

                -- Detected error has NOT register a desc pointer
                elsif(error_pointer_set3 = '0')then

                    -- Scatter Gather Fetch Error
                    if((sg_ftch_error = '1' or sg_updt_error = '1') and dest3 = '1')then
                        curdesc3_lsb_i       <= ftch_error_addr(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
                        error_pointer_set3   <= '1';
                    -- Scatter Gather Update Error
--                    elsif(sg_updt_error = '1' and dest3 = '1')then
 --                       curdesc3_lsb_i       <= updt_error_addr(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
 --                       error_pointer_set3   <= '1';

                    -- Commanded to update descriptor value - used for indicating
                    -- current descriptor begin processed by dma controller
                    elsif(update_curdesc3 = '1' and dmacr_i(DMACR_RS_BIT)  = '1' and dest3 = '1')then
                        curdesc3_lsb_i       <= new_curdesc(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
                        error_pointer_set3   <= '0';

                    -- CPU update of current descriptor pointer.  CPU
                    -- only allowed to update when engine is halted.
                    elsif(axi2ip_wrce(CURDESC3_LSB_INDEX) = '1' and halt_free = '1')then
                        curdesc3_lsb_i       <= axi2ip_wrdata(CURDESC_LOWER_MSB_BIT
                                                      downto CURDESC_LOWER_LSB_BIT)
                                              & ZERO_VALUE(CURDESC_RESERVED_BIT5
                                                      downto CURDESC_RESERVED_BIT0);
                        error_pointer_set3   <= '0';

                    end if;
                end if;
            end if;
        end process CURDESC3_LSB_REGISTER;

    ---------------------------------------------------------------------------
    -- Tail Descriptor LSB Register
    ---------------------------------------------------------------------------
    TAILDESC3_LSB_REGISTER : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    taildesc3_lsb_i  <= (others => '0');
                elsif(axi2ip_wrce(TAILDESC3_LSB_INDEX) = '1')then
                    taildesc3_lsb_i  <= axi2ip_wrdata(TAILDESC_LOWER_MSB_BIT
                                              downto TAILDESC_LOWER_LSB_BIT)
                                       & ZERO_VALUE(TAILDESC_RESERVED_BIT5
                                              downto TAILDESC_RESERVED_BIT0);

                end if;
            end if;
        end process TAILDESC3_LSB_REGISTER;

end generate GEN_DESC3_REG_FOR_SG;

GEN_DESC4_REG_FOR_SG : if C_NUM_S2MM_CHANNELS > 4 generate

    CURDESC4_LSB_REGISTER : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    curdesc4_lsb_i  <= (others => '0');
                    error_pointer_set4   <= '0';

                -- Detected error has NOT register a desc pointer
                elsif(error_pointer_set4 = '0')then

                    -- Scatter Gather Fetch Error
                    if((sg_ftch_error = '1' or sg_updt_error = '1') and dest4 = '1')then
                        curdesc4_lsb_i       <= ftch_error_addr(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
                        error_pointer_set4   <= '1';
                    -- Scatter Gather Update Error
--                    elsif(sg_updt_error = '1' and dest4 = '1')then
--                        curdesc4_lsb_i       <= updt_error_addr(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
--                        error_pointer_set4   <= '1';

                    -- Commanded to update descriptor value - used for indicating
                    -- current descriptor begin processed by dma controller
                    elsif(update_curdesc4 = '1' and dmacr_i(DMACR_RS_BIT)  = '1' and dest4 = '1')then
                        curdesc4_lsb_i       <= new_curdesc(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
                        error_pointer_set4   <= '0';

                    -- CPU update of current descriptor pointer.  CPU
                    -- only allowed to update when engine is halted.
                    elsif(axi2ip_wrce(CURDESC4_LSB_INDEX) = '1' and halt_free = '1')then
                        curdesc4_lsb_i       <= axi2ip_wrdata(CURDESC_LOWER_MSB_BIT
                                                      downto CURDESC_LOWER_LSB_BIT)
                                              & ZERO_VALUE(CURDESC_RESERVED_BIT5
                                                      downto CURDESC_RESERVED_BIT0);
                        error_pointer_set4   <= '0';

                    end if;
                end if;
            end if;
        end process CURDESC4_LSB_REGISTER;

    ---------------------------------------------------------------------------
    -- Tail Descriptor LSB Register
    ---------------------------------------------------------------------------
    TAILDESC4_LSB_REGISTER : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    taildesc4_lsb_i  <= (others => '0');
                elsif(axi2ip_wrce(TAILDESC4_LSB_INDEX) = '1')then
                    taildesc4_lsb_i  <= axi2ip_wrdata(TAILDESC_LOWER_MSB_BIT
                                              downto TAILDESC_LOWER_LSB_BIT)
                                       & ZERO_VALUE(TAILDESC_RESERVED_BIT5
                                              downto TAILDESC_RESERVED_BIT0);

                end if;
            end if;
        end process TAILDESC4_LSB_REGISTER;

end generate GEN_DESC4_REG_FOR_SG;

GEN_DESC5_REG_FOR_SG : if C_NUM_S2MM_CHANNELS > 5 generate


    CURDESC5_LSB_REGISTER : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    curdesc5_lsb_i  <= (others => '0');
                    error_pointer_set5   <= '0';

                -- Detected error has NOT register a desc pointer
                elsif(error_pointer_set5 = '0')then

                    -- Scatter Gather Fetch Error
                    if((sg_ftch_error = '1' or sg_updt_error = '1') and dest5 = '1')then
                        curdesc5_lsb_i       <= ftch_error_addr(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
                        error_pointer_set5   <= '1';
                    -- Scatter Gather Update Error
--                    elsif(sg_updt_error = '1' and dest5 = '1')then
--                        curdesc5_lsb_i       <= updt_error_addr(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
--                        error_pointer_set5   <= '1';

                    -- Commanded to update descriptor value - used for indicating
                    -- current descriptor begin processed by dma controller
                    elsif(update_curdesc5 = '1' and dmacr_i(DMACR_RS_BIT)  = '1' and dest5 = '1')then
                        curdesc5_lsb_i       <= new_curdesc(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
                        error_pointer_set5   <= '0';

                    -- CPU update of current descriptor pointer.  CPU
                    -- only allowed to update when engine is halted.
                    elsif(axi2ip_wrce(CURDESC5_LSB_INDEX) = '1' and halt_free = '1')then
                        curdesc5_lsb_i       <= axi2ip_wrdata(CURDESC_LOWER_MSB_BIT
                                                      downto CURDESC_LOWER_LSB_BIT)
                                              & ZERO_VALUE(CURDESC_RESERVED_BIT5
                                                      downto CURDESC_RESERVED_BIT0);
                        error_pointer_set5   <= '0';

                    end if;
                end if;
            end if;
        end process CURDESC5_LSB_REGISTER;

    ---------------------------------------------------------------------------
    -- Tail Descriptor LSB Register
    ---------------------------------------------------------------------------
    TAILDESC5_LSB_REGISTER : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    taildesc5_lsb_i  <= (others => '0');
                elsif(axi2ip_wrce(TAILDESC5_LSB_INDEX) = '1')then
                    taildesc5_lsb_i  <= axi2ip_wrdata(TAILDESC_LOWER_MSB_BIT
                                              downto TAILDESC_LOWER_LSB_BIT)
                                       & ZERO_VALUE(TAILDESC_RESERVED_BIT5
                                              downto TAILDESC_RESERVED_BIT0);

                end if;
            end if;
        end process TAILDESC5_LSB_REGISTER;

end generate GEN_DESC5_REG_FOR_SG;

GEN_DESC6_REG_FOR_SG : if C_NUM_S2MM_CHANNELS > 6 generate


    CURDESC6_LSB_REGISTER : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    curdesc6_lsb_i  <= (others => '0');
                    error_pointer_set6   <= '0';

                -- Detected error has NOT register a desc pointer
                elsif(error_pointer_set6 = '0')then

                    -- Scatter Gather Fetch Error
                    if((sg_ftch_error = '1' or sg_updt_error = '1') and dest6 = '1')then
                        curdesc6_lsb_i       <= ftch_error_addr(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
                        error_pointer_set6   <= '1';
                    -- Scatter Gather Update Error
--                    elsif(sg_updt_error = '1' and dest6 = '1')then
--                        curdesc6_lsb_i       <= updt_error_addr(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
--                        error_pointer_set6   <= '1';

                    -- Commanded to update descriptor value - used for indicating
                    -- current descriptor begin processed by dma controller
                    elsif(update_curdesc6 = '1' and dmacr_i(DMACR_RS_BIT)  = '1' and dest6 = '1')then
                        curdesc6_lsb_i       <= new_curdesc(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
                        error_pointer_set6   <= '0';

                    -- CPU update of current descriptor pointer.  CPU
                    -- only allowed to update when engine is halted.
                    elsif(axi2ip_wrce(CURDESC6_LSB_INDEX) = '1' and halt_free = '1')then
                        curdesc6_lsb_i       <= axi2ip_wrdata(CURDESC_LOWER_MSB_BIT
                                                      downto CURDESC_LOWER_LSB_BIT)
                                              & ZERO_VALUE(CURDESC_RESERVED_BIT5
                                                      downto CURDESC_RESERVED_BIT0);
                        error_pointer_set6   <= '0';

                    end if;
                end if;
            end if;
        end process CURDESC6_LSB_REGISTER;

    ---------------------------------------------------------------------------
    -- Tail Descriptor LSB Register
    ---------------------------------------------------------------------------
    TAILDESC6_LSB_REGISTER : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    taildesc6_lsb_i  <= (others => '0');
                elsif(axi2ip_wrce(TAILDESC6_LSB_INDEX) = '1')then
                    taildesc6_lsb_i  <= axi2ip_wrdata(TAILDESC_LOWER_MSB_BIT
                                              downto TAILDESC_LOWER_LSB_BIT)
                                       & ZERO_VALUE(TAILDESC_RESERVED_BIT5
                                              downto TAILDESC_RESERVED_BIT0);

                end if;
            end if;
        end process TAILDESC6_LSB_REGISTER;

end generate GEN_DESC6_REG_FOR_SG; 

GEN_DESC7_REG_FOR_SG : if C_NUM_S2MM_CHANNELS > 7 generate

    CURDESC7_LSB_REGISTER : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    curdesc7_lsb_i  <= (others => '0');
                    error_pointer_set7   <= '0';

                -- Detected error has NOT register a desc pointer
                elsif(error_pointer_set7 = '0')then

                    -- Scatter Gather Fetch Error
                    if((sg_ftch_error = '1' or sg_updt_error = '1') and dest7 = '1')then
                        curdesc7_lsb_i       <= ftch_error_addr(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
                        error_pointer_set7   <= '1';
                    -- Scatter Gather Update Error
--                    elsif(sg_updt_error = '1' and dest7 = '1')then
--                        curdesc7_lsb_i       <= updt_error_addr(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
--                        error_pointer_set7   <= '1';

                    -- Commanded to update descriptor value - used for indicating
                    -- current descriptor begin processed by dma controller
                    elsif(update_curdesc7 = '1' and dmacr_i(DMACR_RS_BIT)  = '1' and dest7 = '1')then
                        curdesc7_lsb_i       <= new_curdesc(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
                        error_pointer_set7   <= '0';

                    -- CPU update of current descriptor pointer.  CPU
                    -- only allowed to update when engine is halted.
                    elsif(axi2ip_wrce(CURDESC7_LSB_INDEX) = '1' and halt_free = '1')then
                        curdesc7_lsb_i       <= axi2ip_wrdata(CURDESC_LOWER_MSB_BIT
                                                      downto CURDESC_LOWER_LSB_BIT)
                                              & ZERO_VALUE(CURDESC_RESERVED_BIT5
                                                      downto CURDESC_RESERVED_BIT0);
                        error_pointer_set7   <= '0';

                    end if;
                end if;
            end if;
        end process CURDESC7_LSB_REGISTER;

    ---------------------------------------------------------------------------
    -- Tail Descriptor LSB Register
    ---------------------------------------------------------------------------
    TAILDESC7_LSB_REGISTER : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    taildesc7_lsb_i  <= (others => '0');
                elsif(axi2ip_wrce(TAILDESC7_LSB_INDEX) = '1')then
                    taildesc7_lsb_i  <= axi2ip_wrdata(TAILDESC_LOWER_MSB_BIT
                                              downto TAILDESC_LOWER_LSB_BIT)
                                       & ZERO_VALUE(TAILDESC_RESERVED_BIT5
                                              downto TAILDESC_RESERVED_BIT0);

                end if;
            end if;
        end process TAILDESC7_LSB_REGISTER;

end generate GEN_DESC7_REG_FOR_SG;

GEN_DESC8_REG_FOR_SG : if C_NUM_S2MM_CHANNELS > 8 generate


    CURDESC8_LSB_REGISTER : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    curdesc8_lsb_i  <= (others => '0');
                    error_pointer_set8   <= '0';

                -- Detected error has NOT register a desc pointer
                elsif(error_pointer_set8 = '0')then

                    -- Scatter Gather Fetch Error
                    if((sg_ftch_error = '1' or sg_updt_error = '1') and dest8 = '1')then
                        curdesc8_lsb_i       <= ftch_error_addr(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
                        error_pointer_set8   <= '1';
                    -- Scatter Gather Update Error
--                    elsif(sg_updt_error = '1' and dest8 = '1')then
--                        curdesc8_lsb_i       <= updt_error_addr(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
--                        error_pointer_set8   <= '1';

                    -- Commanded to update descriptor value - used for indicating
                    -- current descriptor begin processed by dma controller
                    elsif(update_curdesc8 = '1' and dmacr_i(DMACR_RS_BIT)  = '1' and dest8 = '1')then
                        curdesc8_lsb_i       <= new_curdesc(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
                        error_pointer_set8   <= '0';

                    -- CPU update of current descriptor pointer.  CPU
                    -- only allowed to update when engine is halted.
                    elsif(axi2ip_wrce(CURDESC8_LSB_INDEX) = '1' and halt_free = '1')then
                        curdesc8_lsb_i       <= axi2ip_wrdata(CURDESC_LOWER_MSB_BIT
                                                      downto CURDESC_LOWER_LSB_BIT)
                                              & ZERO_VALUE(CURDESC_RESERVED_BIT5
                                                      downto CURDESC_RESERVED_BIT0);
                        error_pointer_set8   <= '0';

                    end if;
                end if;
            end if;
        end process CURDESC8_LSB_REGISTER;

    ---------------------------------------------------------------------------
    -- Tail Descriptor LSB Register
    ---------------------------------------------------------------------------
    TAILDESC8_LSB_REGISTER : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    taildesc8_lsb_i  <= (others => '0');
                elsif(axi2ip_wrce(TAILDESC8_LSB_INDEX) = '1')then
                    taildesc8_lsb_i  <= axi2ip_wrdata(TAILDESC_LOWER_MSB_BIT
                                              downto TAILDESC_LOWER_LSB_BIT)
                                       & ZERO_VALUE(TAILDESC_RESERVED_BIT5
                                              downto TAILDESC_RESERVED_BIT0);

                end if;
            end if;
        end process TAILDESC8_LSB_REGISTER;


end generate GEN_DESC8_REG_FOR_SG;

GEN_DESC9_REG_FOR_SG : if C_NUM_S2MM_CHANNELS > 9 generate

    CURDESC9_LSB_REGISTER : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    curdesc9_lsb_i  <= (others => '0');
                    error_pointer_set9   <= '0';

                -- Detected error has NOT register a desc pointer
                elsif(error_pointer_set9 = '0')then

                    -- Scatter Gather Fetch Error
                    if((sg_ftch_error = '1' or sg_updt_error = '1') and dest9 = '1')then
                        curdesc9_lsb_i       <= ftch_error_addr(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
                        error_pointer_set9   <= '1';
                    -- Scatter Gather Update Error
--                    elsif(sg_updt_error = '1' and dest9 = '1')then
--                        curdesc9_lsb_i       <= updt_error_addr(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
--                        error_pointer_set9   <= '1';

                    -- Commanded to update descriptor value - used for indicating
                    -- current descriptor begin processed by dma controller
                    elsif(update_curdesc9 = '1' and dmacr_i(DMACR_RS_BIT)  = '1' and dest9 = '1')then
                        curdesc9_lsb_i       <= new_curdesc(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
                        error_pointer_set9   <= '0';

                    -- CPU update of current descriptor pointer.  CPU
                    -- only allowed to update when engine is halted.
                    elsif(axi2ip_wrce(CURDESC9_LSB_INDEX) = '1' and halt_free = '1')then
                        curdesc9_lsb_i       <= axi2ip_wrdata(CURDESC_LOWER_MSB_BIT
                                                      downto CURDESC_LOWER_LSB_BIT)
                                              & ZERO_VALUE(CURDESC_RESERVED_BIT5
                                                      downto CURDESC_RESERVED_BIT0);
                        error_pointer_set9   <= '0';

                    end if;
                end if;
            end if;
        end process CURDESC9_LSB_REGISTER;

    ---------------------------------------------------------------------------
    -- Tail Descriptor LSB Register
    ---------------------------------------------------------------------------
    TAILDESC9_LSB_REGISTER : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    taildesc9_lsb_i  <= (others => '0');
                elsif(axi2ip_wrce(TAILDESC9_LSB_INDEX) = '1')then
                    taildesc9_lsb_i  <= axi2ip_wrdata(TAILDESC_LOWER_MSB_BIT
                                              downto TAILDESC_LOWER_LSB_BIT)
                                       & ZERO_VALUE(TAILDESC_RESERVED_BIT5
                                              downto TAILDESC_RESERVED_BIT0);

                end if;
            end if;
        end process TAILDESC9_LSB_REGISTER;

end generate GEN_DESC9_REG_FOR_SG;

GEN_DESC10_REG_FOR_SG : if C_NUM_S2MM_CHANNELS > 10 generate


    CURDESC10_LSB_REGISTER : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    curdesc10_lsb_i  <= (others => '0');
                    error_pointer_set10   <= '0';

                -- Detected error has NOT register a desc pointer
                elsif(error_pointer_set10 = '0')then

                    -- Scatter Gather Fetch Error
                    if((sg_ftch_error = '1' or sg_updt_error = '1') and dest10 = '1')then
                        curdesc10_lsb_i       <= ftch_error_addr(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
                        error_pointer_set10   <= '1';
                    -- Scatter Gather Update Error
--                    elsif(sg_updt_error = '1' and dest10 = '1')then
--                        curdesc10_lsb_i       <= updt_error_addr(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
--                        error_pointer_set10   <= '1';

                    -- Commanded to update descriptor value - used for indicating
                    -- current descriptor begin processed by dma controller
                    elsif(update_curdesc10 = '1' and dmacr_i(DMACR_RS_BIT)  = '1' and dest10 = '1')then
                        curdesc10_lsb_i       <= new_curdesc(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
                        error_pointer_set10   <= '0';

                    -- CPU update of current descriptor pointer.  CPU
                    -- only allowed to update when engine is halted.
                    elsif(axi2ip_wrce(CURDESC10_LSB_INDEX) = '1' and halt_free = '1')then
                        curdesc10_lsb_i       <= axi2ip_wrdata(CURDESC_LOWER_MSB_BIT
                                                      downto CURDESC_LOWER_LSB_BIT)
                                              & ZERO_VALUE(CURDESC_RESERVED_BIT5
                                                      downto CURDESC_RESERVED_BIT0);
                        error_pointer_set10   <= '0';

                    end if;
                end if;
            end if;
        end process CURDESC10_LSB_REGISTER;

    ---------------------------------------------------------------------------
    -- Tail Descriptor LSB Register
    ---------------------------------------------------------------------------
    TAILDESC10_LSB_REGISTER : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    taildesc10_lsb_i  <= (others => '0');
                elsif(axi2ip_wrce(TAILDESC10_LSB_INDEX) = '1')then
                    taildesc10_lsb_i  <= axi2ip_wrdata(TAILDESC_LOWER_MSB_BIT
                                              downto TAILDESC_LOWER_LSB_BIT)
                                       & ZERO_VALUE(TAILDESC_RESERVED_BIT5
                                              downto TAILDESC_RESERVED_BIT0);

                end if;
            end if;
        end process TAILDESC10_LSB_REGISTER;

end generate GEN_DESC10_REG_FOR_SG; 

GEN_DESC11_REG_FOR_SG : if C_NUM_S2MM_CHANNELS > 11 generate



    CURDESC11_LSB_REGISTER : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    curdesc11_lsb_i  <= (others => '0');
                    error_pointer_set11   <= '0';

                -- Detected error has NOT register a desc pointer
                elsif(error_pointer_set11 = '0')then

                    -- Scatter Gather Fetch Error
                    if((sg_ftch_error = '1' or sg_updt_error = '1') and dest11 = '1')then
                        curdesc11_lsb_i       <= ftch_error_addr(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
                        error_pointer_set11   <= '1';
                    -- Scatter Gather Update Error
--                    elsif(sg_updt_error = '1' and dest11 = '1')then
--                        curdesc11_lsb_i       <= updt_error_addr(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
--                        error_pointer_set11   <= '1';

                    -- Commanded to update descriptor value - used for indicating
                    -- current descriptor begin processed by dma controller
                    elsif(update_curdesc11 = '1' and dmacr_i(DMACR_RS_BIT)  = '1' and dest11 = '1')then
                        curdesc11_lsb_i       <= new_curdesc(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
                        error_pointer_set11   <= '0';

                    -- CPU update of current descriptor pointer.  CPU
                    -- only allowed to update when engine is halted.
                    elsif(axi2ip_wrce(CURDESC11_LSB_INDEX) = '1' and halt_free = '1')then
                        curdesc11_lsb_i       <= axi2ip_wrdata(CURDESC_LOWER_MSB_BIT
                                                      downto CURDESC_LOWER_LSB_BIT)
                                              & ZERO_VALUE(CURDESC_RESERVED_BIT5
                                                      downto CURDESC_RESERVED_BIT0);
                        error_pointer_set11   <= '0';

                    end if;
                end if;
            end if;
        end process CURDESC11_LSB_REGISTER;

    ---------------------------------------------------------------------------
    -- Tail Descriptor LSB Register
    ---------------------------------------------------------------------------
    TAILDESC11_LSB_REGISTER : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    taildesc11_lsb_i  <= (others => '0');
                elsif(axi2ip_wrce(TAILDESC11_LSB_INDEX) = '1')then
                    taildesc11_lsb_i  <= axi2ip_wrdata(TAILDESC_LOWER_MSB_BIT
                                              downto TAILDESC_LOWER_LSB_BIT)
                                       & ZERO_VALUE(TAILDESC_RESERVED_BIT5
                                              downto TAILDESC_RESERVED_BIT0);

                end if;
            end if;
        end process TAILDESC11_LSB_REGISTER;

end generate GEN_DESC11_REG_FOR_SG; 

GEN_DESC12_REG_FOR_SG : if C_NUM_S2MM_CHANNELS > 12 generate



    CURDESC12_LSB_REGISTER : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    curdesc12_lsb_i  <= (others => '0');
                    error_pointer_set12   <= '0';

                -- Detected error has NOT register a desc pointer
                elsif(error_pointer_set12 = '0')then

                    -- Scatter Gather Fetch Error
                    if((sg_ftch_error = '1' or sg_updt_error = '1') and dest12 = '1')then
                        curdesc12_lsb_i       <= ftch_error_addr(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
                        error_pointer_set12   <= '1';
                    -- Scatter Gather Update Error
--                    elsif(sg_updt_error = '1' and dest12 = '1')then
--                        curdesc12_lsb_i       <= updt_error_addr(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
--                        error_pointer_set12   <= '1';

                    -- Commanded to update descriptor value - used for indicating
                    -- current descriptor begin processed by dma controller
                    elsif(update_curdesc12 = '1' and dmacr_i(DMACR_RS_BIT)  = '1' and dest12 = '1')then
                        curdesc12_lsb_i       <= new_curdesc(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
                        error_pointer_set12   <= '0';

                    -- CPU update of current descriptor pointer.  CPU
                    -- only allowed to update when engine is halted.
                    elsif(axi2ip_wrce(CURDESC12_LSB_INDEX) = '1' and halt_free = '1')then
                        curdesc12_lsb_i       <= axi2ip_wrdata(CURDESC_LOWER_MSB_BIT
                                                      downto CURDESC_LOWER_LSB_BIT)
                                              & ZERO_VALUE(CURDESC_RESERVED_BIT5
                                                      downto CURDESC_RESERVED_BIT0);
                        error_pointer_set12   <= '0';

                    end if;
                end if;
            end if;
        end process CURDESC12_LSB_REGISTER;

    ---------------------------------------------------------------------------
    -- Tail Descriptor LSB Register
    ---------------------------------------------------------------------------
    TAILDESC12_LSB_REGISTER : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    taildesc12_lsb_i  <= (others => '0');
                elsif(axi2ip_wrce(TAILDESC12_LSB_INDEX) = '1')then
                    taildesc12_lsb_i  <= axi2ip_wrdata(TAILDESC_LOWER_MSB_BIT
                                              downto TAILDESC_LOWER_LSB_BIT)
                                       & ZERO_VALUE(TAILDESC_RESERVED_BIT5
                                              downto TAILDESC_RESERVED_BIT0);

                end if;
            end if;
        end process TAILDESC12_LSB_REGISTER;

end generate GEN_DESC12_REG_FOR_SG; 

GEN_DESC13_REG_FOR_SG : if C_NUM_S2MM_CHANNELS > 13 generate



    CURDESC13_LSB_REGISTER : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    curdesc13_lsb_i  <= (others => '0');
                    error_pointer_set13   <= '0';

                -- Detected error has NOT register a desc pointer
                elsif(error_pointer_set13 = '0')then

                    -- Scatter Gather Fetch Error
                    if((sg_ftch_error = '1' or sg_updt_error = '1') and dest13 = '1')then
                        curdesc13_lsb_i       <= ftch_error_addr(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
                        error_pointer_set13   <= '1';
                    -- Scatter Gather Update Error
--                    elsif(sg_updt_error = '1' and dest13 = '1')then
--                        curdesc13_lsb_i       <= updt_error_addr(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
--                        error_pointer_set13   <= '1';

                    -- Commanded to update descriptor value - used for indicating
                    -- current descriptor begin processed by dma controller
                    elsif(update_curdesc13 = '1' and dmacr_i(DMACR_RS_BIT)  = '1' and dest13 = '1')then
                        curdesc13_lsb_i       <= new_curdesc(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
                        error_pointer_set13   <= '0';

                    -- CPU update of current descriptor pointer.  CPU
                    -- only allowed to update when engine is halted.
                    elsif(axi2ip_wrce(CURDESC13_LSB_INDEX) = '1' and halt_free = '1')then
                        curdesc13_lsb_i       <= axi2ip_wrdata(CURDESC_LOWER_MSB_BIT
                                                      downto CURDESC_LOWER_LSB_BIT)
                                              & ZERO_VALUE(CURDESC_RESERVED_BIT5
                                                      downto CURDESC_RESERVED_BIT0);
                        error_pointer_set13   <= '0';

                    end if;
                end if;
            end if;
        end process CURDESC13_LSB_REGISTER;

    ---------------------------------------------------------------------------
    -- Tail Descriptor LSB Register
    ---------------------------------------------------------------------------
    TAILDESC13_LSB_REGISTER : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    taildesc13_lsb_i  <= (others => '0');
                elsif(axi2ip_wrce(TAILDESC13_LSB_INDEX) = '1')then
                    taildesc13_lsb_i  <= axi2ip_wrdata(TAILDESC_LOWER_MSB_BIT
                                              downto TAILDESC_LOWER_LSB_BIT)
                                       & ZERO_VALUE(TAILDESC_RESERVED_BIT5
                                              downto TAILDESC_RESERVED_BIT0);

                end if;
            end if;
        end process TAILDESC13_LSB_REGISTER;

end generate GEN_DESC13_REG_FOR_SG; 

GEN_DESC14_REG_FOR_SG : if C_NUM_S2MM_CHANNELS > 14 generate

    CURDESC14_LSB_REGISTER : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    curdesc14_lsb_i  <= (others => '0');
                    error_pointer_set14   <= '0';

                -- Detected error has NOT register a desc pointer
                elsif(error_pointer_set14 = '0')then

                    -- Scatter Gather Fetch Error
                    if((sg_ftch_error = '1' or sg_updt_error = '1') and dest14 = '1')then
                        curdesc14_lsb_i       <= ftch_error_addr(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
                        error_pointer_set14   <= '1';
                    -- Scatter Gather Update Error
--                    elsif(sg_updt_error = '1' and dest14 = '1')then
--                        curdesc14_lsb_i       <= updt_error_addr(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
--                        error_pointer_set14   <= '1';

                    -- Commanded to update descriptor value - used for indicating
                    -- current descriptor begin processed by dma controller
                    elsif(update_curdesc14 = '1' and dmacr_i(DMACR_RS_BIT)  = '1' and dest14 = '1')then
                        curdesc14_lsb_i       <= new_curdesc(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
                        error_pointer_set14   <= '0';

                    -- CPU update of current descriptor pointer.  CPU
                    -- only allowed to update when engine is halted.
                    elsif(axi2ip_wrce(CURDESC14_LSB_INDEX) = '1' and halt_free = '1')then
                        curdesc14_lsb_i       <= axi2ip_wrdata(CURDESC_LOWER_MSB_BIT
                                                      downto CURDESC_LOWER_LSB_BIT)
                                              & ZERO_VALUE(CURDESC_RESERVED_BIT5
                                                      downto CURDESC_RESERVED_BIT0);
                        error_pointer_set14   <= '0';

                    end if;
                end if;
            end if;
        end process CURDESC14_LSB_REGISTER;

    ---------------------------------------------------------------------------
    -- Tail Descriptor LSB Register
    ---------------------------------------------------------------------------
    TAILDESC14_LSB_REGISTER : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    taildesc14_lsb_i  <= (others => '0');
                elsif(axi2ip_wrce(TAILDESC14_LSB_INDEX) = '1')then
                    taildesc14_lsb_i  <= axi2ip_wrdata(TAILDESC_LOWER_MSB_BIT
                                              downto TAILDESC_LOWER_LSB_BIT)
                                       & ZERO_VALUE(TAILDESC_RESERVED_BIT5
                                              downto TAILDESC_RESERVED_BIT0);

                end if;
            end if;
        end process TAILDESC14_LSB_REGISTER;

end generate GEN_DESC14_REG_FOR_SG;

GEN_DESC15_REG_FOR_SG : if C_NUM_S2MM_CHANNELS > 15 generate


    CURDESC15_LSB_REGISTER : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    curdesc15_lsb_i  <= (others => '0');
                    error_pointer_set15   <= '0';

                -- Detected error has NOT register a desc pointer
                elsif(error_pointer_set15 = '0')then

                    -- Scatter Gather Fetch Error
                    if((sg_ftch_error = '1' or sg_updt_error = '1') and dest15 = '1')then
                        curdesc15_lsb_i       <= ftch_error_addr(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
                        error_pointer_set15   <= '1';
                    -- Scatter Gather Update Error
--                    elsif(sg_updt_error = '1' and dest15 = '1')then
--                        curdesc15_lsb_i       <= updt_error_addr(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
--                        error_pointer_set15   <= '1';

                    -- Commanded to update descriptor value - used for indicating
                    -- current descriptor begin processed by dma controller
                    elsif(update_curdesc15 = '1' and dmacr_i(DMACR_RS_BIT)  = '1' and dest15 = '1')then
                        curdesc15_lsb_i       <= new_curdesc(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
                        error_pointer_set15   <= '0';

                    -- CPU update of current descriptor pointer.  CPU
                    -- only allowed to update when engine is halted.
                    elsif(axi2ip_wrce(CURDESC15_LSB_INDEX) = '1' and halt_free = '1')then
                        curdesc15_lsb_i       <= axi2ip_wrdata(CURDESC_LOWER_MSB_BIT
                                                      downto CURDESC_LOWER_LSB_BIT)
                                              & ZERO_VALUE(CURDESC_RESERVED_BIT5
                                                      downto CURDESC_RESERVED_BIT0);
                        error_pointer_set15   <= '0';

                    end if;
                end if;
            end if;
        end process CURDESC15_LSB_REGISTER;

    ---------------------------------------------------------------------------
    -- Tail Descriptor LSB Register
    ---------------------------------------------------------------------------
    TAILDESC15_LSB_REGISTER : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    taildesc15_lsb_i  <= (others => '0');
                elsif(axi2ip_wrce(TAILDESC15_LSB_INDEX) = '1')then
                    taildesc15_lsb_i  <= axi2ip_wrdata(TAILDESC_LOWER_MSB_BIT
                                              downto TAILDESC_LOWER_LSB_BIT)
                                       & ZERO_VALUE(TAILDESC_RESERVED_BIT5
                                              downto TAILDESC_RESERVED_BIT0);

                end if;
            end if;
        end process TAILDESC15_LSB_REGISTER;

end generate GEN_DESC15_REG_FOR_SG;


    ---------------------------------------------------------------------------
    -- Current Descriptor MSB Register
    ---------------------------------------------------------------------------
    -- Scatter Gather Interface configured for 64-Bit SG Addresses
    GEN_SG_ADDR_EQL64 :if C_M_AXI_SG_ADDR_WIDTH = 64 generate
    begin
        CURDESC_MSB_REGISTER : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0')then
                        curdesc_msb_i  <= (others => '0');

                    elsif(error_pointer_set = '0')then
                        -- Scatter Gather Fetch Error
                        if((sg_ftch_error = '1' or sg_updt_error = '1') and dest0 = '1')then
                            curdesc_msb_i   <= ftch_error_addr(C_M_AXI_SG_ADDR_WIDTH-1 downto C_S_AXI_LITE_DATA_WIDTH);

                        -- Scatter Gather Update Error
                        elsif(sg_updt_error = '1' and dest0 = '1')then
                            curdesc_msb_i   <= updt_error_addr(C_M_AXI_SG_ADDR_WIDTH-1 downto C_S_AXI_LITE_DATA_WIDTH);

                        -- Commanded to update descriptor value - used for indicating
                        -- current descriptor begin processed by dma controller
                        elsif(update_curdesc = '1' and dmacr_i(DMACR_RS_BIT)  = '1' and dest0 = '1')then
                            curdesc_msb_i <= new_curdesc (C_M_AXI_SG_ADDR_WIDTH-1 downto C_S_AXI_LITE_DATA_WIDTH);

                        -- CPU update of current descriptor pointer.  CPU
                        -- only allowed to update when engine is halted.
                        elsif(axi2ip_wrce(CURDESC_MSB_INDEX) = '1' and halt_free = '1')then
                            curdesc_msb_i  <= axi2ip_wrdata;

                        end if;
                    end if;
                end if;
            end process CURDESC_MSB_REGISTER;

        ---------------------------------------------------------------------------
        -- Tail Descriptor MSB Register
        ---------------------------------------------------------------------------
        TAILDESC_MSB_REGISTER : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0')then
                        taildesc_msb_i  <= (others => '0');
                    elsif(axi2ip_wrce(TAILDESC_MSB_INDEX) = '1')then
                        taildesc_msb_i  <= axi2ip_wrdata;
                    end if;
                end if;
            end process TAILDESC_MSB_REGISTER;


GEN_DESC1_MSB_FOR_SG : if C_NUM_S2MM_CHANNELS > 1 generate

        CURDESC1_MSB_REGISTER : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0')then
                        curdesc1_msb_i  <= (others => '0');

                    elsif(error_pointer_set1 = '0')then
                        -- Scatter Gather Fetch Error
                        if((sg_ftch_error = '1' or sg_updt_error = '1') and dest1 = '1')then
                            curdesc1_msb_i   <= ftch_error_addr(C_M_AXI_SG_ADDR_WIDTH-1 downto C_S_AXI_LITE_DATA_WIDTH);

                        -- Scatter Gather Update Error
--                        elsif(sg_updt_error = '1' and dest1 = '1')then
--                            curdesc1_msb_i   <= updt_error_addr((C_M_AXI_SG_ADDR_WIDTH
--                                                - C_S_AXI_LITE_DATA_WIDTH)-1
--                                                downto 0);

                        -- Commanded to update descriptor value - used for indicating
                        -- current descriptor begin processed by dma controller
                        elsif(update_curdesc1 = '1' and dmacr_i(DMACR_RS_BIT)  = '1' and dest1 = '1')then
                            curdesc1_msb_i <= new_curdesc (C_M_AXI_SG_ADDR_WIDTH-1 downto C_S_AXI_LITE_DATA_WIDTH);

                        -- CPU update of current descriptor pointer.  CPU
                        -- only allowed to update when engine is halted.
                        elsif(axi2ip_wrce(CURDESC1_MSB_INDEX) = '1' and halt_free = '1')then
                            curdesc1_msb_i  <= axi2ip_wrdata;

                        end if;
                    end if;
                end if;
            end process CURDESC1_MSB_REGISTER;

        ---------------------------------------------------------------------------
        -- Tail Descriptor MSB Register
        ---------------------------------------------------------------------------
        TAILDESC1_MSB_REGISTER : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0')then
                        taildesc1_msb_i  <= (others => '0');
                    elsif(axi2ip_wrce(TAILDESC1_MSB_INDEX) = '1')then
                        taildesc1_msb_i  <= axi2ip_wrdata;
                    end if;
                end if;
            end process TAILDESC1_MSB_REGISTER;

end generate GEN_DESC1_MSB_FOR_SG;

GEN_DESC2_MSB_FOR_SG : if C_NUM_S2MM_CHANNELS > 2 generate
        
          CURDESC2_MSB_REGISTER : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0')then
                        curdesc2_msb_i  <= (others => '0');

                    elsif(error_pointer_set2 = '0')then
                        -- Scatter Gather Fetch Error
                        if((sg_ftch_error = '1' or sg_updt_error = '1') and dest2 = '1')then
                            curdesc2_msb_i   <= ftch_error_addr(C_M_AXI_SG_ADDR_WIDTH-1 downto C_S_AXI_LITE_DATA_WIDTH);

                        -- Scatter Gather Update Error
--                        elsif(sg_updt_error = '1' and dest2 = '1')then
--                            curdesc2_msb_i   <= updt_error_addr((C_M_AXI_SG_ADDR_WIDTH
--                                                - C_S_AXI_LITE_DATA_WIDTH)-1
--                                                downto 0);

                        -- Commanded to update descriptor value - used for indicating
                        -- current descriptor begin processed by dma controller
                        elsif(update_curdesc2 = '1' and dmacr_i(DMACR_RS_BIT)  = '1' and dest2 = '1')then
                            curdesc2_msb_i <= new_curdesc (C_M_AXI_SG_ADDR_WIDTH-1 downto C_S_AXI_LITE_DATA_WIDTH);

                        -- CPU update of current descriptor pointer.  CPU
                        -- only allowed to update when engine is halted.
                        elsif(axi2ip_wrce(CURDESC2_MSB_INDEX) = '1' and halt_free = '1')then
                            curdesc2_msb_i  <= axi2ip_wrdata;

                        end if;
                    end if;
                end if;
            end process CURDESC2_MSB_REGISTER;

        ---------------------------------------------------------------------------
        -- Tail Descriptor MSB Register
        ---------------------------------------------------------------------------
        TAILDESC2_MSB_REGISTER : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0')then
                        taildesc2_msb_i  <= (others => '0');
                    elsif(axi2ip_wrce(TAILDESC2_MSB_INDEX) = '1')then
                        taildesc2_msb_i  <= axi2ip_wrdata;
                    end if;
                end if;
            end process TAILDESC2_MSB_REGISTER;

end generate GEN_DESC2_MSB_FOR_SG;

GEN_DESC3_MSB_FOR_SG : if C_NUM_S2MM_CHANNELS > 3 generate



        CURDESC3_MSB_REGISTER : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0')then
                        curdesc3_msb_i  <= (others => '0');

                    elsif(error_pointer_set3 = '0')then
                        -- Scatter Gather Fetch Error
                        if((sg_ftch_error = '1' or sg_updt_error = '1') and dest3 = '1')then
                            curdesc3_msb_i   <= ftch_error_addr(C_M_AXI_SG_ADDR_WIDTH-1 downto C_S_AXI_LITE_DATA_WIDTH);

                        -- Scatter Gather Update Error
--                        elsif(sg_updt_error = '1' and dest3 = '1')then
--                            curdesc3_msb_i   <= updt_error_addr((C_M_AXI_SG_ADDR_WIDTH
--                                                - C_S_AXI_LITE_DATA_WIDTH)-1
--                                                downto 0);

                        -- Commanded to update descriptor value - used for indicating
                        -- current descriptor begin processed by dma controller
                        elsif(update_curdesc3 = '1' and dmacr_i(DMACR_RS_BIT)  = '1' and dest3 = '1')then
                            curdesc3_msb_i <= new_curdesc (C_M_AXI_SG_ADDR_WIDTH-1 downto C_S_AXI_LITE_DATA_WIDTH);

                        -- CPU update of current descriptor pointer.  CPU
                        -- only allowed to update when engine is halted.
                        elsif(axi2ip_wrce(CURDESC3_MSB_INDEX) = '1' and halt_free = '1')then
                            curdesc3_msb_i  <= axi2ip_wrdata;

                        end if;
                    end if;
                end if;
            end process CURDESC3_MSB_REGISTER;

        ---------------------------------------------------------------------------
        -- Tail Descriptor MSB Register
        ---------------------------------------------------------------------------
        TAILDESC3_MSB_REGISTER : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0')then
                        taildesc3_msb_i  <= (others => '0');
                    elsif(axi2ip_wrce(TAILDESC3_MSB_INDEX) = '1')then
                        taildesc3_msb_i  <= axi2ip_wrdata;
                    end if;
                end if;
            end process TAILDESC3_MSB_REGISTER;

end generate GEN_DESC3_MSB_FOR_SG;

GEN_DESC4_MSB_FOR_SG : if C_NUM_S2MM_CHANNELS > 4 generate



        CURDESC4_MSB_REGISTER : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0')then
                        curdesc4_msb_i  <= (others => '0');

                    elsif(error_pointer_set4 = '0')then
                        -- Scatter Gather Fetch Error
                        if((sg_ftch_error = '1' or sg_updt_error = '1') and dest4 = '1')then
                            curdesc4_msb_i   <= ftch_error_addr(C_M_AXI_SG_ADDR_WIDTH-1 downto C_S_AXI_LITE_DATA_WIDTH);

                        -- Scatter Gather Update Error
--                        elsif(sg_updt_error = '1' and dest4 = '1')then
--                            curdesc4_msb_i   <= updt_error_addr((C_M_AXI_SG_ADDR_WIDTH
--                                                - C_S_AXI_LITE_DATA_WIDTH)-1
--                                                downto 0);

                        -- Commanded to update descriptor value - used for indicating
                        -- current descriptor begin processed by dma controller
                        elsif(update_curdesc4 = '1' and dmacr_i(DMACR_RS_BIT)  = '1' and dest4 = '1')then
                            curdesc4_msb_i <= new_curdesc (C_M_AXI_SG_ADDR_WIDTH-1 downto C_S_AXI_LITE_DATA_WIDTH);

                        -- CPU update of current descriptor pointer.  CPU
                        -- only allowed to update when engine is halted.
                        elsif(axi2ip_wrce(CURDESC4_MSB_INDEX) = '1' and halt_free = '1')then
                            curdesc4_msb_i  <= axi2ip_wrdata;

                        end if;
                    end if;
                end if;
            end process CURDESC4_MSB_REGISTER;

        ---------------------------------------------------------------------------
        -- Tail Descriptor MSB Register
        ---------------------------------------------------------------------------
        TAILDESC4_MSB_REGISTER : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0')then
                        taildesc4_msb_i  <= (others => '0');
                    elsif(axi2ip_wrce(TAILDESC4_MSB_INDEX) = '1')then
                        taildesc4_msb_i  <= axi2ip_wrdata;
                    end if;
                end if;
            end process TAILDESC4_MSB_REGISTER;
end generate GEN_DESC4_MSB_FOR_SG;

GEN_DESC5_MSB_FOR_SG : if C_NUM_S2MM_CHANNELS > 5 generate


        CURDESC5_MSB_REGISTER : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0')then
                        curdesc5_msb_i  <= (others => '0');

                    elsif(error_pointer_set5 = '0')then
                        -- Scatter Gather Fetch Error
                        if((sg_ftch_error = '1' or sg_updt_error = '1') and dest5 = '1')then
                            curdesc5_msb_i   <= ftch_error_addr(C_M_AXI_SG_ADDR_WIDTH-1 downto C_S_AXI_LITE_DATA_WIDTH);

                        -- Scatter Gather Update Error
--                        elsif(sg_updt_error = '1' and dest5 = '1')then
--                            curdesc5_msb_i   <= updt_error_addr((C_M_AXI_SG_ADDR_WIDTH
--                                                - C_S_AXI_LITE_DATA_WIDTH)-1
--                                                downto 0);

                        -- Commanded to update descriptor value - used for indicating
                        -- current descriptor begin processed by dma controller
                        elsif(update_curdesc5 = '1' and dmacr_i(DMACR_RS_BIT)  = '1' and dest5 = '1')then
                            curdesc5_msb_i <= new_curdesc (C_M_AXI_SG_ADDR_WIDTH-1 downto C_S_AXI_LITE_DATA_WIDTH);

                        -- CPU update of current descriptor pointer.  CPU
                        -- only allowed to update when engine is halted.
                        elsif(axi2ip_wrce(CURDESC5_MSB_INDEX) = '1' and halt_free = '1')then
                            curdesc5_msb_i  <= axi2ip_wrdata;

                        end if;
                    end if;
                end if;
            end process CURDESC5_MSB_REGISTER;

        ---------------------------------------------------------------------------
        -- Tail Descriptor MSB Register
        ---------------------------------------------------------------------------
        TAILDESC5_MSB_REGISTER : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0')then
                        taildesc5_msb_i  <= (others => '0');
                    elsif(axi2ip_wrce(TAILDESC5_MSB_INDEX) = '1')then
                        taildesc5_msb_i  <= axi2ip_wrdata;
                    end if;
                end if;
            end process TAILDESC5_MSB_REGISTER;

end generate GEN_DESC5_MSB_FOR_SG;

GEN_DESC6_MSB_FOR_SG : if C_NUM_S2MM_CHANNELS > 6 generate

        CURDESC6_MSB_REGISTER : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0')then
                        curdesc6_msb_i  <= (others => '0');

                    elsif(error_pointer_set6 = '0')then
                        -- Scatter Gather Fetch Error
                        if((sg_ftch_error = '1' or sg_updt_error = '1') and dest6 = '1')then
                            curdesc6_msb_i   <= ftch_error_addr(C_M_AXI_SG_ADDR_WIDTH-1 downto C_S_AXI_LITE_DATA_WIDTH);

                        -- Scatter Gather Update Error
--                        elsif(sg_updt_error = '1' and dest6 = '1')then
--                            curdesc6_msb_i   <= updt_error_addr((C_M_AXI_SG_ADDR_WIDTH
--                                                - C_S_AXI_LITE_DATA_WIDTH)-1
--                                                downto 0);

                        -- Commanded to update descriptor value - used for indicating
                        -- current descriptor begin processed by dma controller
                        elsif(update_curdesc6 = '1' and dmacr_i(DMACR_RS_BIT)  = '1' and dest6 = '1')then
                            curdesc6_msb_i <= new_curdesc (C_M_AXI_SG_ADDR_WIDTH-1 downto C_S_AXI_LITE_DATA_WIDTH);

                        -- CPU update of current descriptor pointer.  CPU
                        -- only allowed to update when engine is halted.
                        elsif(axi2ip_wrce(CURDESC6_MSB_INDEX) = '1' and halt_free = '1')then
                            curdesc6_msb_i  <= axi2ip_wrdata;

                        end if;
                    end if;
                end if;
            end process CURDESC6_MSB_REGISTER;

        ---------------------------------------------------------------------------
        -- Tail Descriptor MSB Register
        ---------------------------------------------------------------------------
        TAILDESC6_MSB_REGISTER : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0')then
                        taildesc6_msb_i  <= (others => '0');
                    elsif(axi2ip_wrce(TAILDESC6_MSB_INDEX) = '1')then
                        taildesc6_msb_i  <= axi2ip_wrdata;
                    end if;
                end if;
            end process TAILDESC6_MSB_REGISTER;
end generate GEN_DESC6_MSB_FOR_SG;

GEN_DESC7_MSB_FOR_SG : if C_NUM_S2MM_CHANNELS > 7 generate


        CURDESC7_MSB_REGISTER : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0')then
                        curdesc7_msb_i  <= (others => '0');

                    elsif(error_pointer_set7 = '0')then
                        -- Scatter Gather Fetch Error
                        if((sg_ftch_error = '1' or sg_updt_error = '1') and dest7 = '1')then
                            curdesc7_msb_i   <= ftch_error_addr(C_M_AXI_SG_ADDR_WIDTH-1 downto C_S_AXI_LITE_DATA_WIDTH);

                        -- Scatter Gather Update Error
--                        elsif(sg_updt_error = '1' and dest7 = '1')then
--                            curdesc7_msb_i   <= updt_error_addr((C_M_AXI_SG_ADDR_WIDTH
--                                                - C_S_AXI_LITE_DATA_WIDTH)-1
--                                                downto 0);

                        -- Commanded to update descriptor value - used for indicating
                        -- current descriptor begin processed by dma controller
                        elsif(update_curdesc7 = '1' and dmacr_i(DMACR_RS_BIT)  = '1' and dest7 = '1')then
                            curdesc7_msb_i <= new_curdesc (C_M_AXI_SG_ADDR_WIDTH-1 downto C_S_AXI_LITE_DATA_WIDTH);

                        -- CPU update of current descriptor pointer.  CPU
                        -- only allowed to update when engine is halted.
                        elsif(axi2ip_wrce(CURDESC7_MSB_INDEX) = '1' and halt_free = '1')then
                            curdesc7_msb_i  <= axi2ip_wrdata;

                        end if;
                    end if;
                end if;
            end process CURDESC7_MSB_REGISTER;

        ---------------------------------------------------------------------------
        -- Tail Descriptor MSB Register
        ---------------------------------------------------------------------------
        TAILDESC7_MSB_REGISTER : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0')then
                        taildesc7_msb_i  <= (others => '0');
                    elsif(axi2ip_wrce(TAILDESC7_MSB_INDEX) = '1')then
                        taildesc7_msb_i  <= axi2ip_wrdata;
                    end if;
                end if;
            end process TAILDESC7_MSB_REGISTER;

end generate GEN_DESC7_MSB_FOR_SG;

GEN_DESC8_MSB_FOR_SG : if C_NUM_S2MM_CHANNELS > 8 generate

        CURDESC8_MSB_REGISTER : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0')then
                        curdesc8_msb_i  <= (others => '0');

                    elsif(error_pointer_set8 = '0')then
                        -- Scatter Gather Fetch Error
                        if((sg_ftch_error = '1' or sg_updt_error = '1') and dest8 = '1')then
                            curdesc8_msb_i   <= ftch_error_addr(C_M_AXI_SG_ADDR_WIDTH-1 downto C_S_AXI_LITE_DATA_WIDTH);

                        -- Scatter Gather Update Error
--                        elsif(sg_updt_error = '1' and dest8 = '1')then
--                            curdesc8_msb_i   <= updt_error_addr((C_M_AXI_SG_ADDR_WIDTH
--                                                - C_S_AXI_LITE_DATA_WIDTH)-1
--                                                downto 0);

                        -- Commanded to update descriptor value - used for indicating
                        -- current descriptor begin processed by dma controller
                        elsif(update_curdesc8 = '1' and dmacr_i(DMACR_RS_BIT)  = '1' and dest8 = '1')then
                            curdesc8_msb_i <= new_curdesc (C_M_AXI_SG_ADDR_WIDTH-1 downto C_S_AXI_LITE_DATA_WIDTH);

                        -- CPU update of current descriptor pointer.  CPU
                        -- only allowed to update when engine is halted.
                        elsif(axi2ip_wrce(CURDESC8_MSB_INDEX) = '1' and halt_free = '1')then
                            curdesc8_msb_i  <= axi2ip_wrdata;

                        end if;
                    end if;
                end if;
            end process CURDESC8_MSB_REGISTER;

        ---------------------------------------------------------------------------
        -- Tail Descriptor MSB Register
        ---------------------------------------------------------------------------
        TAILDESC8_MSB_REGISTER : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0')then
                        taildesc8_msb_i  <= (others => '0');
                    elsif(axi2ip_wrce(TAILDESC8_MSB_INDEX) = '1')then
                        taildesc8_msb_i  <= axi2ip_wrdata;
                    end if;
                end if;
            end process TAILDESC8_MSB_REGISTER;


end generate  GEN_DESC8_MSB_FOR_SG;

GEN_DESC9_MSB_FOR_SG : if C_NUM_S2MM_CHANNELS > 9 generate

        CURDESC9_MSB_REGISTER : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0')then
                        curdesc9_msb_i  <= (others => '0');

                    elsif(error_pointer_set9 = '0')then
                        -- Scatter Gather Fetch Error
                        if((sg_ftch_error = '1' or sg_updt_error = '1') and dest9 = '1')then
                            curdesc9_msb_i   <= ftch_error_addr(C_M_AXI_SG_ADDR_WIDTH-1 downto C_S_AXI_LITE_DATA_WIDTH);

                        -- Scatter Gather Update Error
--                        elsif(sg_updt_error = '1' and dest9 = '1')then
--                            curdesc9_msb_i   <= updt_error_addr((C_M_AXI_SG_ADDR_WIDTH
--                                                - C_S_AXI_LITE_DATA_WIDTH)-1
--                                                downto 0);

                        -- Commanded to update descriptor value - used for indicating
                        -- current descriptor begin processed by dma controller
                        elsif(update_curdesc9 = '1' and dmacr_i(DMACR_RS_BIT)  = '1' and dest9 = '1')then
                            curdesc9_msb_i <= new_curdesc (C_M_AXI_SG_ADDR_WIDTH-1 downto C_S_AXI_LITE_DATA_WIDTH);

                        -- CPU update of current descriptor pointer.  CPU
                        -- only allowed to update when engine is halted.
                        elsif(axi2ip_wrce(CURDESC9_MSB_INDEX) = '1' and halt_free = '1')then
                            curdesc9_msb_i  <= axi2ip_wrdata;

                        end if;
                    end if;
                end if;
            end process CURDESC9_MSB_REGISTER;

        ---------------------------------------------------------------------------
        -- Tail Descriptor MSB Register
        ---------------------------------------------------------------------------
        TAILDESC9_MSB_REGISTER : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0')then
                        taildesc9_msb_i  <= (others => '0');
                    elsif(axi2ip_wrce(TAILDESC9_MSB_INDEX) = '1')then
                        taildesc9_msb_i  <= axi2ip_wrdata;
                    end if;
                end if;
            end process TAILDESC9_MSB_REGISTER;

end generate GEN_DESC9_MSB_FOR_SG;

GEN_DESC10_MSB_FOR_SG : if C_NUM_S2MM_CHANNELS > 10 generate


        CURDESC10_MSB_REGISTER : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0')then
                        curdesc10_msb_i  <= (others => '0');

                    elsif(error_pointer_set10 = '0')then
                        -- Scatter Gather Fetch Error
                        if((sg_ftch_error = '1' or sg_updt_error = '1') and dest10 = '1')then
                            curdesc10_msb_i   <= ftch_error_addr(C_M_AXI_SG_ADDR_WIDTH-1 downto C_S_AXI_LITE_DATA_WIDTH);

                        -- Scatter Gather Update Error
--                        elsif(sg_updt_error = '1' and dest10 = '1')then
--                            curdesc10_msb_i   <= updt_error_addr((C_M_AXI_SG_ADDR_WIDTH
--                                                - C_S_AXI_LITE_DATA_WIDTH)-1
--                                                downto 0);

                        -- Commanded to update descriptor value - used for indicating
                        -- current descriptor begin processed by dma controller
                        elsif(update_curdesc10 = '1' and dmacr_i(DMACR_RS_BIT)  = '1' and dest10 = '1')then
                            curdesc10_msb_i <= new_curdesc (C_M_AXI_SG_ADDR_WIDTH-1 downto C_S_AXI_LITE_DATA_WIDTH);

                        -- CPU update of current descriptor pointer.  CPU
                        -- only allowed to update when engine is halted.
                        elsif(axi2ip_wrce(CURDESC10_MSB_INDEX) = '1' and halt_free = '1')then
                            curdesc10_msb_i  <= axi2ip_wrdata;

                        end if;
                    end if;
                end if;
            end process CURDESC10_MSB_REGISTER;

        ---------------------------------------------------------------------------
        -- Tail Descriptor MSB Register
        ---------------------------------------------------------------------------
        TAILDESC10_MSB_REGISTER : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0')then
                        taildesc10_msb_i  <= (others => '0');
                    elsif(axi2ip_wrce(TAILDESC10_MSB_INDEX) = '1')then
                        taildesc10_msb_i  <= axi2ip_wrdata;
                    end if;
                end if;
            end process TAILDESC10_MSB_REGISTER;


end generate GEN_DESC10_MSB_FOR_SG;

GEN_DESC11_MSB_FOR_SG : if C_NUM_S2MM_CHANNELS > 11 generate

        CURDESC11_MSB_REGISTER : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0')then
                        curdesc11_msb_i  <= (others => '0');

                    elsif(error_pointer_set11 = '0')then
                        -- Scatter Gather Fetch Error
                        if((sg_ftch_error = '1' or sg_updt_error = '1') and dest11 = '1')then
                            curdesc11_msb_i   <= ftch_error_addr(C_M_AXI_SG_ADDR_WIDTH-1 downto C_S_AXI_LITE_DATA_WIDTH);

                        -- Scatter Gather Update Error
--                        elsif(sg_updt_error = '1' and dest11 = '1')then
--                            curdesc11_msb_i   <= updt_error_addr((C_M_AXI_SG_ADDR_WIDTH
--                                                - C_S_AXI_LITE_DATA_WIDTH)-1
--                                                downto 0);

                        -- Commanded to update descriptor value - used for indicating
                        -- current descriptor begin processed by dma controller
                        elsif(update_curdesc11 = '1' and dmacr_i(DMACR_RS_BIT)  = '1' and dest11 = '1')then
                            curdesc11_msb_i <= new_curdesc (C_M_AXI_SG_ADDR_WIDTH-1 downto C_S_AXI_LITE_DATA_WIDTH);

                        -- CPU update of current descriptor pointer.  CPU
                        -- only allowed to update when engine is halted.
                        elsif(axi2ip_wrce(CURDESC11_MSB_INDEX) = '1' and halt_free = '1')then
                            curdesc11_msb_i  <= axi2ip_wrdata;

                        end if;
                    end if;
                end if;
            end process CURDESC11_MSB_REGISTER;

        ---------------------------------------------------------------------------
        -- Tail Descriptor MSB Register
        ---------------------------------------------------------------------------
        TAILDESC11_MSB_REGISTER : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0')then
                        taildesc11_msb_i  <= (others => '0');
                    elsif(axi2ip_wrce(TAILDESC11_MSB_INDEX) = '1')then
                        taildesc11_msb_i  <= axi2ip_wrdata;
                    end if;
                end if;
            end process TAILDESC11_MSB_REGISTER;

end generate GEN_DESC11_MSB_FOR_SG;

GEN_DESC12_MSB_FOR_SG : if C_NUM_S2MM_CHANNELS > 12 generate


        CURDESC12_MSB_REGISTER : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0')then
                        curdesc12_msb_i  <= (others => '0');

                    elsif(error_pointer_set12 = '0')then
                        -- Scatter Gather Fetch Error
                        if((sg_ftch_error = '1' or sg_updt_error = '1') and dest12 = '1')then
                            curdesc12_msb_i   <= ftch_error_addr(C_M_AXI_SG_ADDR_WIDTH-1 downto C_S_AXI_LITE_DATA_WIDTH);

                        -- Scatter Gather Update Error
--                        elsif(sg_updt_error = '1' and dest12 = '1')then
--                            curdesc12_msb_i   <= updt_error_addr((C_M_AXI_SG_ADDR_WIDTH
--                                                - C_S_AXI_LITE_DATA_WIDTH)-1
--                                                downto 0);

                        -- Commanded to update descriptor value - used for indicating
                        -- current descriptor begin processed by dma controller
                        elsif(update_curdesc12 = '1' and dmacr_i(DMACR_RS_BIT)  = '1' and dest12 = '1')then
                            curdesc12_msb_i <= new_curdesc (C_M_AXI_SG_ADDR_WIDTH-1 downto C_S_AXI_LITE_DATA_WIDTH);

                        -- CPU update of current descriptor pointer.  CPU
                        -- only allowed to update when engine is halted.
                        elsif(axi2ip_wrce(CURDESC12_MSB_INDEX) = '1' and halt_free = '1')then
                            curdesc12_msb_i  <= axi2ip_wrdata;

                        end if;
                    end if;
                end if;
            end process CURDESC12_MSB_REGISTER;

        ---------------------------------------------------------------------------
        -- Tail Descriptor MSB Register
        ---------------------------------------------------------------------------
        TAILDESC12_MSB_REGISTER : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0')then
                        taildesc12_msb_i  <= (others => '0');
                    elsif(axi2ip_wrce(TAILDESC12_MSB_INDEX) = '1')then
                        taildesc12_msb_i  <= axi2ip_wrdata;
                    end if;
                end if;
            end process TAILDESC12_MSB_REGISTER;

end generate GEN_DESC12_MSB_FOR_SG;

GEN_DESC13_MSB_FOR_SG : if C_NUM_S2MM_CHANNELS > 13 generate

        CURDESC13_MSB_REGISTER : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0')then
                        curdesc13_msb_i  <= (others => '0');

                    elsif(error_pointer_set13 = '0')then
                        -- Scatter Gather Fetch Error
                        if((sg_ftch_error = '1' or sg_updt_error = '1') and dest13 = '1')then
                            curdesc13_msb_i   <= ftch_error_addr(C_M_AXI_SG_ADDR_WIDTH-1 downto C_S_AXI_LITE_DATA_WIDTH);

                        -- Scatter Gather Update Error
--                        elsif(sg_updt_error = '1' and dest13 = '1')then
--                            curdesc13_msb_i   <= updt_error_addr((C_M_AXI_SG_ADDR_WIDTH
--                                                - C_S_AXI_LITE_DATA_WIDTH)-1
--                                                downto 0);

                        -- Commanded to update descriptor value - used for indicating
                        -- current descriptor begin processed by dma controller
                        elsif(update_curdesc13 = '1' and dmacr_i(DMACR_RS_BIT)  = '1' and dest13 = '1')then
                            curdesc13_msb_i <= new_curdesc (C_M_AXI_SG_ADDR_WIDTH-1 downto C_S_AXI_LITE_DATA_WIDTH);

                        -- CPU update of current descriptor pointer.  CPU
                        -- only allowed to update when engine is halted.
                        elsif(axi2ip_wrce(CURDESC13_MSB_INDEX) = '1' and halt_free = '1')then
                            curdesc13_msb_i  <= axi2ip_wrdata;

                        end if;
                    end if;
                end if;
            end process CURDESC13_MSB_REGISTER;

        ---------------------------------------------------------------------------
        -- Tail Descriptor MSB Register
        ---------------------------------------------------------------------------
        TAILDESC13_MSB_REGISTER : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0')then
                        taildesc13_msb_i  <= (others => '0');
                    elsif(axi2ip_wrce(TAILDESC13_MSB_INDEX) = '1')then
                        taildesc13_msb_i  <= axi2ip_wrdata;
                    end if;
                end if;
            end process TAILDESC13_MSB_REGISTER;

end generate GEN_DESC13_MSB_FOR_SG;


GEN_DESC14_MSB_FOR_SG : if C_NUM_S2MM_CHANNELS > 14 generate

        CURDESC14_MSB_REGISTER : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0')then
                        curdesc14_msb_i  <= (others => '0');

                    elsif(error_pointer_set14 = '0')then
                        -- Scatter Gather Fetch Error
                        if((sg_ftch_error = '1' or sg_updt_error = '1') and dest14 = '1')then
                            curdesc14_msb_i   <= ftch_error_addr(C_M_AXI_SG_ADDR_WIDTH-1 downto C_S_AXI_LITE_DATA_WIDTH);

                        -- Scatter Gather Update Error
--                        elsif(sg_updt_error = '1' and dest14 = '1')then
--                            curdesc14_msb_i   <= updt_error_addr((C_M_AXI_SG_ADDR_WIDTH
--                                                - C_S_AXI_LITE_DATA_WIDTH)-1
--                                                downto 0);

                        -- Commanded to update descriptor value - used for indicating
                        -- current descriptor begin processed by dma controller
                        elsif(update_curdesc14 = '1' and dmacr_i(DMACR_RS_BIT)  = '1' and dest14 = '1')then
                            curdesc14_msb_i <= new_curdesc (C_M_AXI_SG_ADDR_WIDTH-1 downto C_S_AXI_LITE_DATA_WIDTH);

                        -- CPU update of current descriptor pointer.  CPU
                        -- only allowed to update when engine is halted.
                        elsif(axi2ip_wrce(CURDESC14_MSB_INDEX) = '1' and halt_free = '1')then
                            curdesc14_msb_i  <= axi2ip_wrdata;

                        end if;
                    end if;
                end if;
            end process CURDESC14_MSB_REGISTER;

        ---------------------------------------------------------------------------
        -- Tail Descriptor MSB Register
        ---------------------------------------------------------------------------
        TAILDESC14_MSB_REGISTER : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0')then
                        taildesc14_msb_i  <= (others => '0');
                    elsif(axi2ip_wrce(TAILDESC14_MSB_INDEX) = '1')then
                        taildesc14_msb_i  <= axi2ip_wrdata;
                    end if;
                end if;
            end process TAILDESC14_MSB_REGISTER;

end generate GEN_DESC14_MSB_FOR_SG;


GEN_DESC15_MSB_FOR_SG : if C_NUM_S2MM_CHANNELS > 15 generate

        CURDESC15_MSB_REGISTER : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0')then
                        curdesc15_msb_i  <= (others => '0');

                    elsif(error_pointer_set15 = '0')then
                        -- Scatter Gather Fetch Error
                        if((sg_ftch_error = '1' or sg_updt_error = '1') and dest15 = '1')then
                            curdesc15_msb_i   <= ftch_error_addr(C_M_AXI_SG_ADDR_WIDTH-1 downto C_S_AXI_LITE_DATA_WIDTH);

                        -- Scatter Gather Update Error
--                        elsif(sg_updt_error = '1' and dest15 = '1')then
--                            curdesc15_msb_i   <= updt_error_addr((C_M_AXI_SG_ADDR_WIDTH
--                                                - C_S_AXI_LITE_DATA_WIDTH)-1
--                                                downto 0);

                        -- Commanded to update descriptor value - used for indicating
                        -- current descriptor begin processed by dma controller
                        elsif(update_curdesc15 = '1' and dmacr_i(DMACR_RS_BIT)  = '1' and dest15 = '1')then
                            curdesc15_msb_i <= new_curdesc (C_M_AXI_SG_ADDR_WIDTH-1 downto C_S_AXI_LITE_DATA_WIDTH);

                        -- CPU update of current descriptor pointer.  CPU
                        -- only allowed to update when engine is halted.
                        elsif(axi2ip_wrce(CURDESC15_MSB_INDEX) = '1' and halt_free = '1')then
                            curdesc15_msb_i  <= axi2ip_wrdata;

                        end if;
                    end if;
                end if;
            end process CURDESC15_MSB_REGISTER;

        ---------------------------------------------------------------------------
        -- Tail Descriptor MSB Register
        ---------------------------------------------------------------------------
        TAILDESC15_MSB_REGISTER : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0')then
                        taildesc15_msb_i  <= (others => '0');
                    elsif(axi2ip_wrce(TAILDESC15_MSB_INDEX) = '1')then
                        taildesc15_msb_i  <= axi2ip_wrdata;
                    end if;
                end if;
            end process TAILDESC15_MSB_REGISTER;

end generate GEN_DESC15_MSB_FOR_SG;

        end generate GEN_SG_ADDR_EQL64;

    -- Scatter Gather Interface configured for 32-Bit SG Addresses
    GEN_SG_ADDR_EQL32 : if C_M_AXI_SG_ADDR_WIDTH = 32 generate
    begin
        curdesc_msb_i  <= (others => '0');
        taildesc_msb_i <= (others => '0');
    -- Extending this to the extra registers
        curdesc1_msb_i  <= (others => '0');
        taildesc1_msb_i <= (others => '0');
        curdesc2_msb_i  <= (others => '0');
        taildesc2_msb_i <= (others => '0');
        curdesc3_msb_i  <= (others => '0');
        taildesc3_msb_i <= (others => '0');
        curdesc4_msb_i  <= (others => '0');
        taildesc4_msb_i <= (others => '0');
        curdesc5_msb_i  <= (others => '0');
        taildesc5_msb_i <= (others => '0');
        curdesc6_msb_i  <= (others => '0');
        taildesc6_msb_i <= (others => '0');
        curdesc7_msb_i  <= (others => '0');
        taildesc7_msb_i <= (others => '0');
        curdesc8_msb_i  <= (others => '0');
        taildesc8_msb_i <= (others => '0');
        curdesc9_msb_i  <= (others => '0');
        taildesc9_msb_i <= (others => '0');
        curdesc10_msb_i  <= (others => '0');
        taildesc10_msb_i <= (others => '0');
        curdesc11_msb_i  <= (others => '0');
        taildesc11_msb_i <= (others => '0');
        curdesc12_msb_i  <= (others => '0');
        taildesc12_msb_i <= (others => '0');
        curdesc13_msb_i  <= (others => '0');
        taildesc13_msb_i <= (others => '0');
        curdesc14_msb_i  <= (others => '0');
        taildesc14_msb_i <= (others => '0');
        curdesc15_msb_i  <= (others => '0');
        taildesc15_msb_i <= (others => '0');

    end generate GEN_SG_ADDR_EQL32;


    -- Scatter Gather Interface configured for 32-Bit SG Addresses
    GEN_TAILUPDATE_EQL32 : if C_M_AXI_SG_ADDR_WIDTH = 32 generate
    begin

 -- Added dest so that BD can be dynamically updated

GENERATE_MULTI_CH : if C_ENABLE_MULTI_CHANNEL = 1 generate
        tail_update_lsb <= (axi2ip_wrce(TAILDESC_LSB_INDEX) and dest0) or 
                           (axi2ip_wrce(TAILDESC1_LSB_INDEX) and dest1) or 
                           (axi2ip_wrce(TAILDESC2_LSB_INDEX) and dest2) or 
                           (axi2ip_wrce(TAILDESC3_LSB_INDEX) and dest3) or 
                           (axi2ip_wrce(TAILDESC4_LSB_INDEX) and dest4) or 
                           (axi2ip_wrce(TAILDESC5_LSB_INDEX) and dest5) or 
                           (axi2ip_wrce(TAILDESC6_LSB_INDEX) and dest6) or 
                           (axi2ip_wrce(TAILDESC7_LSB_INDEX) and dest7) or 
                           (axi2ip_wrce(TAILDESC8_LSB_INDEX) and dest8) or 
                           (axi2ip_wrce(TAILDESC9_LSB_INDEX) and dest9) or 
                           (axi2ip_wrce(TAILDESC10_LSB_INDEX) and dest10) or 
                           (axi2ip_wrce(TAILDESC11_LSB_INDEX) and dest11) or 
                           (axi2ip_wrce(TAILDESC12_LSB_INDEX) and dest12) or 
                           (axi2ip_wrce(TAILDESC13_LSB_INDEX) and dest13) or 
                           (axi2ip_wrce(TAILDESC14_LSB_INDEX) and dest14) or 
                           (axi2ip_wrce(TAILDESC15_LSB_INDEX) and dest15); 
end generate GENERATE_MULTI_CH;

GENERATE_NO_MULTI_CH : if C_ENABLE_MULTI_CHANNEL = 0 generate
        tail_update_lsb <= (axi2ip_wrce(TAILDESC_LSB_INDEX) and dest0);

end generate GENERATE_NO_MULTI_CH;
        
        TAILPNTR_UPDT_PROCESS : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0' or dmacr_i(DMACR_RS_BIT)='0')then
                        tailpntr_updated_d1    <= '0';
                    elsif (tail_update_lsb = '1' and tdest_in(5) = '0')then  
                        tailpntr_updated_d1    <= '1';
                    else
                        tailpntr_updated_d1    <= '0';
                    end if;
                end if;
            end process TAILPNTR_UPDT_PROCESS;

        TAILPNTR_UPDT_PROCESS_DEL : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0')then
                        tailpntr_updated_d2    <= '0';
                    else
                        tailpntr_updated_d2    <= tailpntr_updated_d1;
                    end if;
                end if;
            end process TAILPNTR_UPDT_PROCESS_DEL;
   
           tailpntr_updated <= tailpntr_updated_d1 and (not tailpntr_updated_d2);

    end generate GEN_TAILUPDATE_EQL32;

    -- Scatter Gather Interface configured for 64-Bit SG Addresses
    GEN_TAILUPDATE_EQL64 : if C_M_AXI_SG_ADDR_WIDTH = 64 generate
    begin

 -- Added dest so that BD can be dynamically updated
GENERATE_NO_MULTI_CH1 : if C_ENABLE_MULTI_CHANNEL = 1 generate
        tail_update_msb <= (axi2ip_wrce(TAILDESC_MSB_INDEX) and dest0) or 
                           (axi2ip_wrce(TAILDESC1_MSB_INDEX) and dest1) or 
                           (axi2ip_wrce(TAILDESC2_MSB_INDEX) and dest2) or 
                           (axi2ip_wrce(TAILDESC3_MSB_INDEX) and dest3) or 
                           (axi2ip_wrce(TAILDESC4_MSB_INDEX) and dest4) or 
                           (axi2ip_wrce(TAILDESC5_MSB_INDEX) and dest5) or 
                           (axi2ip_wrce(TAILDESC6_MSB_INDEX) and dest6) or 
                           (axi2ip_wrce(TAILDESC7_MSB_INDEX) and dest7) or 
                           (axi2ip_wrce(TAILDESC8_MSB_INDEX) and dest8) or 
                           (axi2ip_wrce(TAILDESC9_MSB_INDEX) and dest9) or 
                           (axi2ip_wrce(TAILDESC10_MSB_INDEX) and dest10) or 
                           (axi2ip_wrce(TAILDESC11_MSB_INDEX) and dest11) or 
                           (axi2ip_wrce(TAILDESC12_MSB_INDEX) and dest12) or 
                           (axi2ip_wrce(TAILDESC13_MSB_INDEX) and dest13) or 
                           (axi2ip_wrce(TAILDESC14_MSB_INDEX) and dest14) or 
                           (axi2ip_wrce(TAILDESC15_MSB_INDEX) and dest15); 
end generate GENERATE_NO_MULTI_CH1;


GENERATE_NO_MULTI_CH2 : if C_ENABLE_MULTI_CHANNEL = 0 generate

        tail_update_msb <= (axi2ip_wrce(TAILDESC_MSB_INDEX) and dest0);

end generate GENERATE_NO_MULTI_CH2;

        TAILPNTR_UPDT_PROCESS : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0' or dmacr_i(DMACR_RS_BIT)='0')then
                        tailpntr_updated_d1    <= '0';
                    elsif (tail_update_msb = '1'  and tdest_in(5) = '0')then
                        tailpntr_updated_d1    <= '1';
                    else
                        tailpntr_updated_d1    <= '0';
                    end if;
                end if;
            end process TAILPNTR_UPDT_PROCESS;


        TAILPNTR_UPDT_PROCESS_DEL : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0')then
                        tailpntr_updated_d2    <= '0';
                    else
                        tailpntr_updated_d2    <= tailpntr_updated_d1;
                    end if;
                end if;
            end process TAILPNTR_UPDT_PROCESS_DEL;
   
           tailpntr_updated <= tailpntr_updated_d1 and (not tailpntr_updated_d2);

    end generate GEN_TAILUPDATE_EQL64;

end generate GEN_DESC_REG_FOR_SG;


-- Generate Buffer Address and Length Register for Simple DMA Mode
GEN_REG_FOR_SMPL : if C_INCLUDE_SG = 0 generate
begin
    -- Signals not used for simple dma mode, only for sg mode
    curdesc_lsb_i       <= (others => '0');
    curdesc_msb_i       <= (others => '0');
    taildesc_lsb_i      <= (others => '0');
    taildesc_msb_i      <= (others => '0');
-- Extending this to new registers
    curdesc1_msb_i  <= (others => '0');
    taildesc1_msb_i <= (others => '0');
    curdesc2_msb_i  <= (others => '0');
    taildesc2_msb_i <= (others => '0');
    curdesc3_msb_i  <= (others => '0');
    taildesc3_msb_i <= (others => '0');
    curdesc4_msb_i  <= (others => '0');
    taildesc4_msb_i <= (others => '0');
    curdesc5_msb_i  <= (others => '0');
    taildesc5_msb_i <= (others => '0');
    curdesc6_msb_i  <= (others => '0');
    taildesc6_msb_i <= (others => '0');
    curdesc7_msb_i  <= (others => '0');
    taildesc7_msb_i <= (others => '0');
    curdesc8_msb_i  <= (others => '0');
    taildesc8_msb_i <= (others => '0');
    curdesc9_msb_i  <= (others => '0');
    taildesc9_msb_i <= (others => '0');
    curdesc10_msb_i  <= (others => '0');
    taildesc10_msb_i <= (others => '0');
    curdesc11_msb_i  <= (others => '0');
    taildesc11_msb_i <= (others => '0');
    curdesc12_msb_i  <= (others => '0');
    taildesc12_msb_i <= (others => '0');
    curdesc13_msb_i  <= (others => '0');
    taildesc13_msb_i <= (others => '0');
    curdesc14_msb_i  <= (others => '0');
    taildesc14_msb_i <= (others => '0');
    curdesc15_msb_i  <= (others => '0');
    taildesc15_msb_i <= (others => '0');

    curdesc1_lsb_i  <= (others => '0');
    taildesc1_lsb_i <= (others => '0');
    curdesc2_lsb_i  <= (others => '0');
    taildesc2_lsb_i <= (others => '0');
    curdesc3_lsb_i  <= (others => '0');
    taildesc3_lsb_i <= (others => '0');
    curdesc4_lsb_i  <= (others => '0');
    taildesc4_lsb_i <= (others => '0');
    curdesc5_lsb_i  <= (others => '0');
    taildesc5_lsb_i <= (others => '0');
    curdesc6_lsb_i  <= (others => '0');
    taildesc6_lsb_i <= (others => '0');
    curdesc7_lsb_i  <= (others => '0');
    taildesc7_lsb_i <= (others => '0');
    curdesc8_lsb_i  <= (others => '0');
    taildesc8_lsb_i <= (others => '0');
    curdesc9_lsb_i  <= (others => '0');
    taildesc9_lsb_i <= (others => '0');
    curdesc10_lsb_i  <= (others => '0');
    taildesc10_lsb_i <= (others => '0');
    curdesc11_lsb_i  <= (others => '0');
    taildesc11_lsb_i <= (others => '0');
    curdesc12_lsb_i  <= (others => '0');
    taildesc12_lsb_i <= (others => '0');
    curdesc13_lsb_i  <= (others => '0');
    taildesc13_lsb_i <= (others => '0');
    curdesc14_lsb_i  <= (others => '0');
    taildesc14_lsb_i <= (others => '0');
    curdesc15_lsb_i  <= (others => '0');
    taildesc15_lsb_i <= (others => '0');

    tailpntr_updated    <= '0';
    error_pointer_set   <= '0';

    -- Buffer Address register.  Used for Source Address (SA) if MM2S
    -- and used for Destination Address (DA) if S2MM
    BUFFER_ADDR_REGISTER : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    buffer_address_i  <= (others => '0');
                elsif(axi2ip_wrce(BUFF_ADDRESS_INDEX) = '1')then
                    buffer_address_i  <= axi2ip_wrdata;
                end if;
            end if;
        end process BUFFER_ADDR_REGISTER;

    GEN_BUF_ADDR_EQL64 : if C_M_AXI_SG_ADDR_WIDTH > 32 generate
    begin

    BUFFER_ADDR_REGISTER1 : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    buffer_address_64_i  <= (others => '0');
                elsif(axi2ip_wrce(BUFF_ADDRESS_MSB_INDEX) = '1')then
                    buffer_address_64_i  <= axi2ip_wrdata;
                end if;
            end if;
        end process BUFFER_ADDR_REGISTER1;

    end generate GEN_BUF_ADDR_EQL64;


    -- Buffer Length register.  Used for number of bytes to transfer if MM2S
    -- and used for size of receive buffer is S2MM
    BUFFER_LNGTH_REGISTER : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    buffer_length_i  <= (others => '0');

                -- Update with actual bytes received (Only for S2MM channel)
                elsif(bytes_received_wren = '1' and C_MICRO_DMA = 0)then
                    buffer_length_i <= bytes_received;

                elsif(axi2ip_wrce(BUFF_LENGTH_INDEX) = '1')then
                    buffer_length_i  <= axi2ip_wrdata(C_SG_LENGTH_WIDTH-1 downto 0);
                end if;
            end if;
        end process BUFFER_LNGTH_REGISTER;

    -- Buffer Length Write Enable control.  Assertion of wren will
    -- begin a transfer if channel is Idle.
    BUFFER_LNGTH_WRITE : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    buffer_length_wren <= '0';
                -- Non-zero length value written
                elsif(axi2ip_wrce(BUFF_LENGTH_INDEX) = '1'
                and axi2ip_wrdata(C_SG_LENGTH_WIDTH-1 downto 0) /= ZERO_VALUE(C_SG_LENGTH_WIDTH-1 downto 0))then
                    buffer_length_wren <= '1';
                else
                    buffer_length_wren <= '0';
                end if;
            end if;
        end process BUFFER_LNGTH_WRITE;

end generate GEN_REG_FOR_SMPL;



end implementation;
