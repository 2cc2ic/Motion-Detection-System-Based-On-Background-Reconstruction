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
-- Filename:        axi_dma_register.vhd
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
entity  axi_dma_register is
    generic(
        C_NUM_REGISTERS             : integer                   := 11       ;
        C_INCLUDE_SG                : integer                   := 1        ;
        C_SG_LENGTH_WIDTH           : integer range 8 to 23     := 14       ;
        C_S_AXI_LITE_DATA_WIDTH     : integer range 32 to 32    := 32       ;
        C_M_AXI_SG_ADDR_WIDTH       : integer range 32 to 64    := 32       ;
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
        buffer_address              : out std_logic_vector                             --
                                           (C_M_AXI_SG_ADDR_WIDTH-1 downto 0);       --
        buffer_length               : out std_logic_vector                             --
                                           (C_SG_LENGTH_WIDTH-1 downto 0)   ;          --
        buffer_length_wren          : out std_logic                         ;          --
        bytes_received              : in  std_logic_vector                             --
                                           (C_SG_LENGTH_WIDTH-1 downto 0)   ;          --
        bytes_received_wren         : in  std_logic                                    --
    );                                                                                 --
end axi_dma_register;

-------------------------------------------------------------------------------
-- Architecture
-------------------------------------------------------------------------------
architecture implementation of axi_dma_register is
  attribute DowngradeIPIdentifiedWarnings: string;
  attribute DowngradeIPIdentifiedWarnings of implementation : architecture is "yes";


-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------

-- No Functions Declared

-------------------------------------------------------------------------------
-- Constants Declarations
-------------------------------------------------------------------------------
constant DMACR_INDEX            : integer := 0;                     -- DMACR Register index
constant DMASR_INDEX            : integer := 1;                     -- DMASR Register index
constant CURDESC_LSB_INDEX      : integer := 2;                     -- CURDESC LSB Reg index
constant CURDESC_MSB_INDEX      : integer := 3;                     -- CURDESC MSB Reg index
constant TAILDESC_LSB_INDEX     : integer := 4;                     -- TAILDESC LSB Reg index
constant TAILDESC_MSB_INDEX     : integer := 5;                     -- TAILDESC MSB Reg index
-- CR603034 moved s2mm back to offset 6
--constant SA_ADDRESS_INDEX       : integer := 6;                     -- Buffer Address Reg (SA)
--constant DA_ADDRESS_INDEX       : integer := 8;                     -- Buffer Address Reg (DA)
--
--
--constant BUFF_ADDRESS_INDEX     : integer := address_index_select   -- Buffer Address Reg (SA or DA)
--                                                    (C_CHANNEL_IS_S2MM, -- Channel Type 1=rx 0=tx
--                                                     SA_ADDRESS_INDEX,  -- Source Address Index
--                                                     DA_ADDRESS_INDEX); -- Destination Address Index
constant BUFF_ADDRESS_INDEX     : integer := 6;
constant BUFF_ADDRESS_MSB_INDEX     : integer := 7;
constant BUFF_LENGTH_INDEX      : integer := 10;                    -- Buffer Length Reg
constant SGCTL_INDEX      : integer := 11;                    -- Buffer Length Reg

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
signal buffer_address_i_64     : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal buffer_length_i      : std_logic_vector
                                (C_SG_LENGTH_WIDTH-1 downto 0)       := (others => '0');




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

-- interrupt coalescing support signals
signal different_delay      : std_logic := '0';
signal different_thresh     : std_logic := '0';
signal threshold_is_zero    : std_logic := '0';
-- soft reset support signals
signal soft_reset_i         : std_logic := '0';
signal run_stop_clr         : std_logic := '0';
signal sg_cache_info        : std_logic_vector (7 downto 0);
signal diff_thresh_xor      : std_logic_vector (7 downto 0);

signal sig_cur_updated : std_logic;
signal tmp11 : std_logic;

signal tailpntr_updated_d1 : std_logic;
signal tailpntr_updated_d2 : std_logic;

-------------------------------------------------------------------------------
-- Begin architecture logic
-------------------------------------------------------------------------------
begin

dmacr                   <= dmacr_i          ;
dmasr                   <= dmasr_i          ;
curdesc_lsb             <= curdesc_lsb_i (31 downto 6) & "000000"   ;
curdesc_msb             <= curdesc_msb_i    ;
taildesc_lsb            <= taildesc_lsb_i (31 downto 6) & "000000"   ;
taildesc_msb            <= taildesc_msb_i   ;

BUFF_ADDR_EQL64 : if C_M_AXI_SG_ADDR_WIDTH > 32 generate
begin

buffer_address          <= buffer_address_i_64 & buffer_address_i ;

end generate BUFF_ADDR_EQL64;


BUFF_ADDR_EQL32 : if C_M_AXI_SG_ADDR_WIDTH = 32 generate
begin

buffer_address          <= buffer_address_i ;

end generate BUFF_ADDR_EQL32;


buffer_length           <= buffer_length_i  ;

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

--diff_thresh_xor <= dmacr_i(DMACR_IRQTHRESH_MSB_BIT downto DMACR_IRQTHRESH_LSB_BIT) xor 
--                   axi2ip_wrdata(DMACR_IRQTHRESH_MSB_BIT downto DMACR_IRQTHRESH_LSB_BIT);

--different_thresh <= '0' when diff_thresh_xor = "00000000" 
--                    else '1';
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
-- DMACR - Remainder of DMA Control Register, Bit 3 for Key hole operation
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
                    if(sg_ftch_error = '1' or sg_updt_error = '1')then
                        curdesc_lsb_i       <= ftch_error_addr(C_S_AXI_LITE_DATA_WIDTH-1 downto 6);
                        error_pointer_set   <= '1';
                    -- Scatter Gather Update Error
            --        elsif(sg_updt_error = '1')then
            --            curdesc_lsb_i       <= updt_error_addr(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
             --           error_pointer_set   <= '1';

                    -- Commanded to update descriptor value - used for indicating
                    -- current descriptor begin processed by dma controller
                    elsif(update_curdesc = '1' and dmacr_i(DMACR_RS_BIT)  = '1')then
                        curdesc_lsb_i       <= new_curdesc(C_S_AXI_LITE_DATA_WIDTH-1 downto 6);
                        error_pointer_set   <= '0';

                    -- CPU update of current descriptor pointer.  CPU
                    -- only allowed to update when engine is halted.
                    elsif(axi2ip_wrce(CURDESC_LSB_INDEX) = '1' and dmasr_i(DMASR_HALTED_BIT) = '1')then
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
                        if(sg_ftch_error = '1'  or sg_updt_error = '1')then
                            curdesc_msb_i   <= ftch_error_addr(C_M_AXI_SG_ADDR_WIDTH - 1 downto C_S_AXI_LITE_DATA_WIDTH);

                        -- Scatter Gather Update Error
              --          elsif(sg_updt_error = '1')then
              --              curdesc_msb_i   <= updt_error_addr((C_M_AXI_SG_ADDR_WIDTH
              --                                  - C_S_AXI_LITE_DATA_WIDTH)-1
              --                                  downto 0);

                        -- Commanded to update descriptor value - used for indicating
                        -- current descriptor begin processed by dma controller
                        elsif(update_curdesc = '1' and dmacr_i(DMACR_RS_BIT)  = '1')then
                            curdesc_msb_i <= new_curdesc (C_M_AXI_SG_ADDR_WIDTH-1 downto C_S_AXI_LITE_DATA_WIDTH);

                        -- CPU update of current descriptor pointer.  CPU
                        -- only allowed to update when engine is halted.
                        elsif(axi2ip_wrce(CURDESC_MSB_INDEX) = '1' and dmasr_i(DMASR_HALTED_BIT) = '1')then
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

        end generate GEN_SG_ADDR_EQL64;

    -- Scatter Gather Interface configured for 32-Bit SG Addresses
    GEN_SG_ADDR_EQL32 : if C_M_AXI_SG_ADDR_WIDTH = 32 generate
    begin
        curdesc_msb_i  <= (others => '0');
        taildesc_msb_i <= (others => '0');
    end generate GEN_SG_ADDR_EQL32;


    -- Scatter Gather Interface configured for 32-Bit SG Addresses
    GEN_TAILUPDATE_EQL32 : if C_M_AXI_SG_ADDR_WIDTH = 32 generate
    begin
        TAILPNTR_UPDT_PROCESS : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0' or dmacr_i(DMACR_RS_BIT)='0')then
                        tailpntr_updated_d1    <= '0';
                    elsif(axi2ip_wrce(TAILDESC_LSB_INDEX) = '1')then
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
        TAILPNTR_UPDT_PROCESS : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0' or dmacr_i(DMACR_RS_BIT)='0')then
                        tailpntr_updated_d1    <= '0';
                    elsif(axi2ip_wrce(TAILDESC_MSB_INDEX) = '1')then
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

    GEN_BUFF_ADDR_EQL64 : if C_M_AXI_SG_ADDR_WIDTH > 32 generate
    begin
    BUFFER_ADDR_REGISTER1 : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    buffer_address_i_64  <= (others => '0');
                elsif(axi2ip_wrce(BUFF_ADDRESS_MSB_INDEX) = '1')then
                    buffer_address_i_64  <= axi2ip_wrdata;
                end if;
            end if;
        end process BUFFER_ADDR_REGISTER1;


    end generate GEN_BUFF_ADDR_EQL64;

    -- Buffer Length register.  Used for number of bytes to transfer if MM2S
    -- and used for size of receive buffer is S2MM
    BUFFER_LNGTH_REGISTER : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    buffer_length_i  <= (others => '0');

                -- Update with actual bytes received (Only for S2MM channel)
       --         elsif(bytes_received_wren = '1')then
       --             buffer_length_i <= bytes_received;

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
