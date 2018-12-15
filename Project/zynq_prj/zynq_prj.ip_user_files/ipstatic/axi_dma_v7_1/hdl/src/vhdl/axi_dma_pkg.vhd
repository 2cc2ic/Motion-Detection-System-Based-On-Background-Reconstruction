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
-- Filename:          axi_dma_pkg.vhd
-- Description: This package contains various constants and functions for
--              AXI DMA operations.
--
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library lib_pkg_v1_0_2;
use lib_pkg_v1_0_2.lib_pkg.clog2;

package axi_dma_pkg is

-------------------------------------------------------------------------------
-- Function declarations
-------------------------------------------------------------------------------
-- Find minimum required btt width
function required_btt_width (dwidth     : integer;
                            burst_size  : integer;
                            btt_width   : integer)
            return  integer;

-- Return correct hertz paramter value
function hertz_prmtr_select(included        : integer;
                            lite_frequency  : integer;
                            sg_frequency    : integer)
    return integer;

-- Return SnF enable or disable
function enable_snf (sf_enabled         : integer;
                     axi_data_width     : integer;
                     axis_tdata_width   : integer)
    return integer;

-------------------------------------------------------------------------------
-- Constant Declarations
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- AXI Responce Values
-------------------------------------------------------------------------------
constant OKAY_RESP                  : std_logic_vector(1 downto 0)  := "00";
constant EXOKAY_RESP                : std_logic_vector(1 downto 0)  := "01";
constant SLVERR_RESP                : std_logic_vector(1 downto 0)  := "10";
constant DECERR_RESP                : std_logic_vector(1 downto 0)  := "11";

constant MTBF_STAGES                : integer := 4;
constant C_FIFO_MTBF                : integer := 4;
-------------------------------------------------------------------------------
-- Misc Constants
-------------------------------------------------------------------------------
--constant NUM_REG_TOTAL              : integer := 18;
--constant NUM_REG_TOTAL              : integer := 23;
constant NUM_REG_TOTAL              : integer := 143; -- To accomodate S2MM registers
--constant NUM_REG_PER_CHANNEL        : integer := 6;
constant NUM_REG_PER_CHANNEL        : integer := 12;
constant NUM_REG_PER_S2MM        : integer := 120;
--constant REG_MSB_ADDR_BIT           : integer := clog2(NUM_REG_TOTAL)-1;
constant CMD_BASE_WIDTH             : integer := 40;
constant BUFFER_LENGTH_WIDTH        : integer := 23;

-- Constants Used in Desc Updates
constant DESC_STS_TYPE              : std_logic := '1';
constant DESC_DATA_TYPE             : std_logic := '0';
constant DESC_LAST                  : std_logic := '1';
constant DESC_NOT_LAST              : std_logic := '0';

-- Interrupt Coalescing
constant ZERO_THRESHOLD             : std_logic_vector(7 downto 0) := (others => '0');
constant ONE_THRESHOLD              : std_logic_vector(7 downto 0) := "00000001";
constant ZERO_DELAY                 : std_logic_vector(7 downto 0) := (others => '0');

-------------------------------------------------------------------------------
-- AXI Lite AXI DMA Register Offsets
-------------------------------------------------------------------------------
constant MM2S_DMACR_INDEX           : integer := 0;
constant MM2S_DMASR_INDEX           : integer := 1;
constant MM2S_CURDESC_LSB_INDEX     : integer := 2;
constant MM2S_CURDESC_MSB_INDEX     : integer := 3;
constant MM2S_TAILDESC_LSB_INDEX    : integer := 4;
constant MM2S_TAILDESC_MSB_INDEX    : integer := 5;
constant MM2S_SA_INDEX              : integer := 6;
constant MM2S_SA2_INDEX          : integer := 7;
constant RESERVED_20_INDEX          : integer := 8;
constant RESERVED_24_INDEX          : integer := 9;
constant MM2S_LENGTH_INDEX          : integer := 10;
constant RESERVED_2C_INDEX          : integer := 11;
constant S2MM_DMACR_INDEX           : integer := 12;
constant S2MM_DMASR_INDEX           : integer := 13;
constant S2MM_CURDESC_LSB_INDEX     : integer := 14;
constant S2MM_CURDESC_MSB_INDEX     : integer := 15;
constant S2MM_TAILDESC_LSB_INDEX    : integer := 16;
constant S2MM_TAILDESC_MSB_INDEX    : integer := 17;
constant S2MM_DA_INDEX              : integer := 18;
constant S2MM_DA2_INDEX          : integer := 19;
constant RESERVED_50_INDEX          : integer := 20;
constant RESERVED_54_INDEX          : integer := 21;
--constant S2MM_LENGTH_INDEX          : integer := 22;
constant S2MM_LENGTH_INDEX          : integer := 142; 


constant MM2S_DMACR_OFFSET          : std_logic_vector(9 downto 0) := "0000000000";    -- 0x00
constant MM2S_DMASR_OFFSET          : std_logic_vector(9 downto 0) := "0000000100";    -- 0x04
constant MM2S_CURDESC_LSB_OFFSET    : std_logic_vector(9 downto 0) := "0000001000";    -- 0x08
constant MM2S_CURDESC_MSB_OFFSET    : std_logic_vector(9 downto 0) := "0000001100";    -- 0x0C
constant MM2S_TAILDESC_LSB_OFFSET   : std_logic_vector(9 downto 0) := "0000010000";    -- 0x10
constant MM2S_TAILDESC_MSB_OFFSET   : std_logic_vector(9 downto 0) := "0000010100";    -- 0x14
constant MM2S_SA_OFFSET             : std_logic_vector(9 downto 0) := "0000011000";    -- 0x18
constant MM2S_SA2_OFFSET            : std_logic_vector(9 downto 0) := "0000011100";    -- 0x1C
constant RESERVED_20_OFFSET         : std_logic_vector(9 downto 0) := "0000100000";    -- 0x20
constant RESERVED_24_OFFSET         : std_logic_vector(9 downto 0) := "0000100100";    -- 0x24
constant MM2S_LENGTH_OFFSET         : std_logic_vector(9 downto 0) := "0000101000";    -- 0x28
-- Following was reserved, now is used for SG xCache and xUser
constant SGCTL_OFFSET               : std_logic_vector(9 downto 0) := "0000101100";    -- 0x2C

constant S2MM_DMACR_OFFSET          : std_logic_vector(9 downto 0) := "0000110000";    -- 0x30
constant S2MM_DMASR_OFFSET          : std_logic_vector(9 downto 0) := "0000110100";    -- 0x34
constant S2MM_CURDESC_LSB_OFFSET    : std_logic_vector(9 downto 0) := "0000111000";    -- 0x38
constant S2MM_CURDESC_MSB_OFFSET    : std_logic_vector(9 downto 0) := "0000111100";    -- 0x3C
constant S2MM_TAILDESC_LSB_OFFSET   : std_logic_vector(9 downto 0) := "0001000000";    -- 0x40
constant S2MM_TAILDESC_MSB_OFFSET   : std_logic_vector(9 downto 0) := "0001000100";    -- 0x44
constant S2MM_DA_OFFSET             : std_logic_vector(9 downto 0) := "0001001000";    -- 0x48 --CR603034
constant S2MM_DA2_OFFSET            : std_logic_vector(9 downto 0) := "0001001100";    -- 0x4C
constant RESERVED_50_OFFSET         : std_logic_vector(9 downto 0) := "0001010000";    -- 0x50
constant RESERVED_54_OFFSET         : std_logic_vector(9 downto 0) := "0001010100";    -- 0x54
constant S2MM_LENGTH_OFFSET         : std_logic_vector(9 downto 0) := "0001011000";    -- 0x58

-- New registers for S2MM channels
constant S2MM_CURDESC1_LSB_OFFSET    : std_logic_vector(9 downto 0) := "0001110000";    -- 0x70
constant S2MM_CURDESC1_MSB_OFFSET    : std_logic_vector(9 downto 0) := "0001110100";    -- 0x74
constant S2MM_TAILDESC1_LSB_OFFSET   : std_logic_vector(9 downto 0) := "0001111000";    -- 0x78
constant S2MM_TAILDESC1_MSB_OFFSET   : std_logic_vector(9 downto 0) := "0001111100";    -- 0x7C

constant S2MM_CURDESC2_LSB_OFFSET    : std_logic_vector(9 downto 0) := "0010010000";    -- 0x90
constant S2MM_CURDESC2_MSB_OFFSET    : std_logic_vector(9 downto 0) := "0010010100";    -- 0x94
constant S2MM_TAILDESC2_LSB_OFFSET   : std_logic_vector(9 downto 0) := "0010011000";    -- 0x98
constant S2MM_TAILDESC2_MSB_OFFSET   : std_logic_vector(9 downto 0) := "0010011100";    -- 0x9C

constant S2MM_CURDESC3_LSB_OFFSET    : std_logic_vector(9 downto 0) := "0010110000";    -- 0xB0
constant S2MM_CURDESC3_MSB_OFFSET    : std_logic_vector(9 downto 0) := "0010110100";    -- 0xB4
constant S2MM_TAILDESC3_LSB_OFFSET   : std_logic_vector(9 downto 0) := "0010111000";    -- 0xB8
constant S2MM_TAILDESC3_MSB_OFFSET   : std_logic_vector(9 downto 0) := "0010111100";    -- 0xBC

constant S2MM_CURDESC4_LSB_OFFSET    : std_logic_vector(9 downto 0) := "0011010000";    -- 0xD0
constant S2MM_CURDESC4_MSB_OFFSET    : std_logic_vector(9 downto 0) := "0011010100";    -- 0xD4
constant S2MM_TAILDESC4_LSB_OFFSET   : std_logic_vector(9 downto 0) := "0011011000";    -- 0xD8
constant S2MM_TAILDESC4_MSB_OFFSET   : std_logic_vector(9 downto 0) := "0011011100";    -- 0xDC

constant S2MM_CURDESC5_LSB_OFFSET    : std_logic_vector(9 downto 0) := "0011110000";    -- 0xF0
constant S2MM_CURDESC5_MSB_OFFSET    : std_logic_vector(9 downto 0) := "0011110100";    -- 0xF4
constant S2MM_TAILDESC5_LSB_OFFSET   : std_logic_vector(9 downto 0) := "0011111000";    -- 0xF8
constant S2MM_TAILDESC5_MSB_OFFSET   : std_logic_vector(9 downto 0) := "0011111100";    -- 0xFC

constant S2MM_CURDESC6_LSB_OFFSET    : std_logic_vector(9 downto 0) := "0100010000";    -- 0x110
constant S2MM_CURDESC6_MSB_OFFSET    : std_logic_vector(9 downto 0) := "0100010100";    -- 0x114
constant S2MM_TAILDESC6_LSB_OFFSET   : std_logic_vector(9 downto 0) := "0100011000";    -- 0x118
constant S2MM_TAILDESC6_MSB_OFFSET   : std_logic_vector(9 downto 0) := "0100011100";    -- 0x11C

constant S2MM_CURDESC7_LSB_OFFSET    : std_logic_vector(9 downto 0) := "0100110000";    -- 0x130
constant S2MM_CURDESC7_MSB_OFFSET    : std_logic_vector(9 downto 0) := "0100110100";    -- 0x134
constant S2MM_TAILDESC7_LSB_OFFSET   : std_logic_vector(9 downto 0) := "0100111000";    -- 0x138
constant S2MM_TAILDESC7_MSB_OFFSET   : std_logic_vector(9 downto 0) := "0100111100";    -- 0x13C

constant S2MM_CURDESC8_LSB_OFFSET    : std_logic_vector(9 downto 0) := "0101010000";    -- 0x150
constant S2MM_CURDESC8_MSB_OFFSET    : std_logic_vector(9 downto 0) := "0101010100";    -- 0x154
constant S2MM_TAILDESC8_LSB_OFFSET   : std_logic_vector(9 downto 0) := "0101011000";    -- 0x158
constant S2MM_TAILDESC8_MSB_OFFSET   : std_logic_vector(9 downto 0) := "0101011100";    -- 0x15C

constant S2MM_CURDESC9_LSB_OFFSET    : std_logic_vector(9 downto 0) := "0101110000";    -- 0x170
constant S2MM_CURDESC9_MSB_OFFSET    : std_logic_vector(9 downto 0) := "0101110100";    -- 0x174
constant S2MM_TAILDESC9_LSB_OFFSET   : std_logic_vector(9 downto 0) := "0101111000";    -- 0x178
constant S2MM_TAILDESC9_MSB_OFFSET   : std_logic_vector(9 downto 0) := "0101111100";    -- 0x17C

constant S2MM_CURDESC10_LSB_OFFSET    : std_logic_vector(9 downto 0) := "0110010000";    -- 0x190
constant S2MM_CURDESC10_MSB_OFFSET    : std_logic_vector(9 downto 0) := "0110010100";    -- 0x194
constant S2MM_TAILDESC10_LSB_OFFSET   : std_logic_vector(9 downto 0) := "0110011000";    -- 0x198
constant S2MM_TAILDESC10_MSB_OFFSET   : std_logic_vector(9 downto 0) := "0110011100";    -- 0x19C

constant S2MM_CURDESC11_LSB_OFFSET    : std_logic_vector(9 downto 0) := "0110110000";    -- 0x1B0
constant S2MM_CURDESC11_MSB_OFFSET    : std_logic_vector(9 downto 0) := "0110110100";    -- 0x1B4
constant S2MM_TAILDESC11_LSB_OFFSET   : std_logic_vector(9 downto 0) := "0110111000";    -- 0x1B8
constant S2MM_TAILDESC11_MSB_OFFSET   : std_logic_vector(9 downto 0) := "0110111100";    -- 0x1BC

constant S2MM_CURDESC12_LSB_OFFSET    : std_logic_vector(9 downto 0) := "0111010000";    -- 0x1D0
constant S2MM_CURDESC12_MSB_OFFSET    : std_logic_vector(9 downto 0) := "0111010100";    -- 0x1D4
constant S2MM_TAILDESC12_LSB_OFFSET   : std_logic_vector(9 downto 0) := "0111011000";    -- 0x1D8
constant S2MM_TAILDESC12_MSB_OFFSET   : std_logic_vector(9 downto 0) := "0111011100";    -- 0x1DC

constant S2MM_CURDESC13_LSB_OFFSET    : std_logic_vector(9 downto 0) := "0111110000";    -- 0x1F0
constant S2MM_CURDESC13_MSB_OFFSET    : std_logic_vector(9 downto 0) := "0111110100";    -- 0x1F4
constant S2MM_TAILDESC13_LSB_OFFSET   : std_logic_vector(9 downto 0) := "0111111000";    -- 0x1F8
constant S2MM_TAILDESC13_MSB_OFFSET   : std_logic_vector(9 downto 0) := "0111111100";    -- 0x1FC

constant S2MM_CURDESC14_LSB_OFFSET    : std_logic_vector(9 downto 0) := "1000010000";    -- 0x210
constant S2MM_CURDESC14_MSB_OFFSET    : std_logic_vector(9 downto 0) := "1000010100";    -- 0x214
constant S2MM_TAILDESC14_LSB_OFFSET   : std_logic_vector(9 downto 0) := "1000011000";    -- 0x218
constant S2MM_TAILDESC14_MSB_OFFSET   : std_logic_vector(9 downto 0) := "1000011100";    -- 0x21C

constant S2MM_CURDESC15_LSB_OFFSET    : std_logic_vector(9 downto 0) := "1000110000";    -- 0x230
constant S2MM_CURDESC15_MSB_OFFSET    : std_logic_vector(9 downto 0) := "1000110100";    -- 0x234
constant S2MM_TAILDESC15_LSB_OFFSET   : std_logic_vector(9 downto 0) := "1000111000";    -- 0x238
constant S2MM_TAILDESC15_MSB_OFFSET   : std_logic_vector(9 downto 0) := "1000111100";    -- 0x23C




-------------------------------------------------------------------------------
-- Register Bit Constants
-------------------------------------------------------------------------------
-- DMACR
constant DMACR_RS_BIT               : integer := 0;
constant DMACR_TAILPEN_BIT          : integer := 1;
constant DMACR_RESET_BIT            : integer := 2;
constant DMACR_KH_BIT        : integer := 3;
constant CYCLIC_BIT        : integer := 4;
--constant DMACR_RESERVED3_BIT        : integer := 3;
--constant DMACR_RESERVED4_BIT        : integer := 4;
constant DMACR_RESERVED5_BIT        : integer := 5;
constant DMACR_RESERVED6_BIT        : integer := 6;
constant DMACR_RESERVED7_BIT        : integer := 7;
constant DMACR_RESERVED8_BIT        : integer := 8;
constant DMACR_RESERVED9_BIT        : integer := 9;
constant DMACR_RESERVED10_BIT       : integer := 10;
constant DMACR_RESERVED11_BIT       : integer := 11;
constant DMACR_IOC_IRQEN_BIT        : integer := 12;
constant DMACR_DLY_IRQEN_BIT        : integer := 13;
constant DMACR_ERR_IRQEN_BIT        : integer := 14;
constant DMACR_RESERVED15_BIT       : integer := 15;
constant DMACR_IRQTHRESH_LSB_BIT    : integer := 16;
constant DMACR_IRQTHRESH_MSB_BIT    : integer := 23;
constant DMACR_IRQDELAY_LSB_BIT     : integer := 24;
constant DMACR_IRQDELAY_MSB_BIT     : integer := 31;

-- DMASR
constant DMASR_HALTED_BIT           : integer := 0;
constant DMASR_IDLE_BIT             : integer := 1;
constant DMASR_CMPLT_BIT            : integer := 2;
constant DMASR_ERROR_BIT            : integer := 3;
constant DMASR_DMAINTERR_BIT        : integer := 4;
constant DMASR_DMASLVERR_BIT        : integer := 5;
constant DMASR_DMADECERR_BIT        : integer := 6;
constant DMASR_RESERVED7_BIT        : integer := 7;
constant DMASR_SGINTERR_BIT         : integer := 8;
constant DMASR_SGSLVERR_BIT         : integer := 9;
constant DMASR_SGDECERR_BIT         : integer := 10;
constant DMASR_RESERVED11_BIT       : integer := 11;
constant DMASR_IOCIRQ_BIT           : integer := 12;
constant DMASR_DLYIRQ_BIT           : integer := 13;
constant DMASR_ERRIRQ_BIT           : integer := 14;
constant DMASR_RESERVED15_BIT       : integer := 15;
constant DMASR_IRQTHRESH_LSB_BIT    : integer := 16;
constant DMASR_IRQTHRESH_MSB_BIT    : integer := 23;
constant DMASR_IRQDELAY_LSB_BIT     : integer := 24;
constant DMASR_IRQDELAY_MSB_BIT     : integer := 31;

-- CURDESC
constant CURDESC_LOWER_MSB_BIT      : integer := 31;
constant CURDESC_LOWER_LSB_BIT      : integer := 6;
constant CURDESC_RESERVED_BIT5      : integer := 5;
constant CURDESC_RESERVED_BIT4      : integer := 4;
constant CURDESC_RESERVED_BIT3      : integer := 3;
constant CURDESC_RESERVED_BIT2      : integer := 2;
constant CURDESC_RESERVED_BIT1      : integer := 1;
constant CURDESC_RESERVED_BIT0      : integer := 0;

-- TAILDESC
constant TAILDESC_LOWER_MSB_BIT     : integer := 31;
constant TAILDESC_LOWER_LSB_BIT     : integer := 6;
constant TAILDESC_RESERVED_BIT5     : integer := 5;
constant TAILDESC_RESERVED_BIT4     : integer := 4;
constant TAILDESC_RESERVED_BIT3     : integer := 3;
constant TAILDESC_RESERVED_BIT2     : integer := 2;
constant TAILDESC_RESERVED_BIT1     : integer := 1;
constant TAILDESC_RESERVED_BIT0     : integer := 0;

-- DataMover Command / Status Constants
constant DATAMOVER_CMDDONE_BIT      : integer := 7;
constant DATAMOVER_SLVERR_BIT       : integer := 6;
constant DATAMOVER_DECERR_BIT       : integer := 5;
constant DATAMOVER_INTERR_BIT       : integer := 4;
constant DATAMOVER_TAGMSB_BIT       : integer := 3;
constant DATAMOVER_TAGLSB_BIT       : integer := 0;

-- Descriptor Control Bits
constant DESC_BLENGTH_LSB_BIT       : integer := 0;
constant DESC_BLENGTH_MSB_BIT       : integer := 22;
constant DESC_RSVD23_BIT            : integer := 23;
constant DESC_RSVD24_BIT            : integer := 24;
constant DESC_RSVD25_BIT            : integer := 25;
constant DESC_EOF_BIT               : integer := 26;
constant DESC_SOF_BIT               : integer := 27;
constant DESC_RSVD28_BIT            : integer := 28;
constant DESC_RSVD29_BIT            : integer := 29;
constant DESC_RSVD30_BIT            : integer := 30;
constant DESC_IOC_BIT               : integer := 31;

-- Descriptor Status Bits
constant DESC_STS_CMPLTD_BIT        : integer := 31;
constant DESC_STS_DECERR_BIT        : integer := 30;
constant DESC_STS_SLVERR_BIT        : integer := 29;
constant DESC_STS_INTERR_BIT        : integer := 28;
constant DESC_STS_RXSOF_BIT         : integer := 27;
constant DESC_STS_RXEOF_BIT         : integer := 26;
constant DESC_STS_RSVD25_BIT        : integer := 25;
constant DESC_STS_RSVD24_BIT        : integer := 24;
constant DESC_STS_RSVD23_BIT        : integer := 23;
constant DESC_STS_XFRDBYTS_MSB_BIT  : integer := 22;
constant DESC_STS_XFRDBYTS_LSB_BIT  : integer := 0;


-- DataMover Command / Status Constants
constant DATAMOVER_STS_CMDDONE_BIT  : integer := 7;
constant DATAMOVER_STS_SLVERR_BIT   : integer := 6;
constant DATAMOVER_STS_DECERR_BIT   : integer := 5;
constant DATAMOVER_STS_INTERR_BIT   : integer := 4;
constant DATAMOVER_STS_TAGMSB_BIT   : integer := 3;
constant DATAMOVER_STS_TAGLSB_BIT   : integer := 0;

constant DATAMOVER_STS_TAGEOF_BIT   : integer := 1;
constant DATAMOVER_STS_TLAST_BIT    : integer := 31;

constant DATAMOVER_CMD_BTTLSB_BIT   : integer := 0;
constant DATAMOVER_CMD_BTTMSB_BIT   : integer := 22;
constant DATAMOVER_CMD_TYPE_BIT     : integer := 23;
constant DATAMOVER_CMD_DSALSB_BIT   : integer := 24;
constant DATAMOVER_CMD_DSAMSB_BIT   : integer := 29;
constant DATAMOVER_CMD_EOF_BIT      : integer := 30;
constant DATAMOVER_CMD_DRR_BIT      : integer := 31;
constant DATAMOVER_CMD_ADDRLSB_BIT  : integer := 32;

-- Note: Bit offset require adding ADDR WIDTH to get to actual bit index
constant DATAMOVER_CMD_ADDRMSB_BOFST: integer := 31;
constant DATAMOVER_CMD_TAGLSB_BOFST : integer := 32;
constant DATAMOVER_CMD_TAGMSB_BOFST : integer := 35;
constant DATAMOVER_CMD_RSVLSB_BOFST : integer := 36;
constant DATAMOVER_CMD_RSVMSB_BOFST : integer := 39;


end axi_dma_pkg;

-------------------------------------------------------------------------------
-- PACKAGE BODY
-------------------------------------------------------------------------------
package body axi_dma_pkg is



-------------------------------------------------------------------------------
-- Function to determine minimum bits required for BTT_SIZE field
-------------------------------------------------------------------------------
function required_btt_width ( dwidth    : integer;
                              burst_size: integer;
                              btt_width : integer)
    return integer  is
variable min_width : integer;

begin
    min_width := clog2((dwidth/8)*burst_size)+1;
    if(min_width > btt_width)then
        return min_width;
    else
        return btt_width;
    end if;
end function required_btt_width;

-------------------------------------------------------------------------------
-- function to return Frequency Hertz parameter based on inclusion of sg engine
-------------------------------------------------------------------------------
function hertz_prmtr_select(included        : integer;
                            lite_frequency  : integer;
                            sg_frequency    : integer)
    return integer is
    begin
        -- 1 = Scatter Gather Included
        -- 0 = Scatter Gather Excluded
        if(included = 1)then
            return sg_frequency;
        else
            return lite_frequency;
        end if;
    end;


-------------------------------------------------------------------------------
-- function to enable store and forward based on data width mismatch
-- or directly enabled
-------------------------------------------------------------------------------
function enable_snf (sf_enabled         : integer;
                     axi_data_width     : integer;
                     axis_tdata_width   : integer)
    return integer is
    begin
        -- If store and forward enable or data widths do not
        -- match then return 1 to enable snf
        if( (sf_enabled = 1) or (axi_data_width /= axis_tdata_width))then
            return 1;
        else
-- coverage off
            return 0;
-- coverage on
        end if;
    end;

end package body axi_dma_pkg;
