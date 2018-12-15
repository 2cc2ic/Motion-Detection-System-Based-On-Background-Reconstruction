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
-- Filename:          axi_dma_reset.vhd
-- Description: This entity encompasses the reset logic (soft and hard) for
--              distribution to the axi_vdma core.
--
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;

library lib_cdc_v1_0_2;
library axi_dma_v7_1_8;
use axi_dma_v7_1_8.axi_dma_pkg.all;


-------------------------------------------------------------------------------
entity  axi_dma_reset is
    generic(
        C_INCLUDE_SG                : integer range 0 to 1          := 1;
            -- Include or Exclude the Scatter Gather Engine
            -- 0 = Exclude SG Engine - Enables Simple DMA Mode
            -- 1 = Include SG Engine - Enables Scatter Gather Mode

        C_SG_INCLUDE_STSCNTRL_STRM  : integer range 0 to 1          := 1;
            -- Include or Exclude AXI Status and AXI Control Streams
            -- 0 = Exclude Status and Control Streams
            -- 1 = Include Status and Control Streams

        C_PRMRY_IS_ACLK_ASYNC           : integer range 0 to 1 := 0;
            -- Primary MM2S/S2MM sync/async mode
            -- 0 = synchronous mode     - all clocks are synchronous
            -- 1 = asynchronous mode    - Primary data path channels (MM2S and S2MM)
            --                            run asynchronous to AXI Lite, DMA Control,
            --                            and SG.
        C_AXI_PRMRY_ACLK_FREQ_HZ        : integer := 100000000;
            -- Primary clock frequency in hertz

        C_AXI_SCNDRY_ACLK_FREQ_HZ       : integer := 100000000
            -- Secondary clock frequency in hertz
    );
    port (
        -- Clock Sources
        m_axi_sg_aclk               : in  std_logic                         ;              --
        axi_prmry_aclk              : in  std_logic                         ;              --
                                                                                           --
        -- Hard Reset                                                                      --
        axi_resetn                  : in  std_logic                         ;              --
                                                                                           --
        -- Soft Reset                                                                      --
        soft_reset                  : in  std_logic                         ;              --
        soft_reset_clr              : out std_logic  := '0'                 ;              --
        soft_reset_done             : in  std_logic                         ;              --
                                                                                           --
                                                                                           --
        all_idle                    : in  std_logic                         ;              --
        stop                        : in  std_logic                         ;              --
        halt                        : out std_logic := '0'                  ;              --
        halt_cmplt                  : in  std_logic                         ;              --
                                                                                           --
        -- Secondary Reset                                                                 --
        scndry_resetn               : out std_logic := '1'                  ;              --
        -- AXI Upsizer and Line Buffer                                                     --
        prmry_resetn                : out std_logic := '0'                  ;              --
        -- AXI DataMover Primary Reset (Raw)                                               --
        dm_prmry_resetn             : out std_logic := '1'                  ;              --
        -- AXI DataMover Secondary Reset (Raw)                                             --
        dm_scndry_resetn            : out std_logic := '1'                  ;              --
        -- AXI Primary Stream Reset Outputs                                                --
        prmry_reset_out_n           : out std_logic := '1'                  ;              --
        -- AXI Alternat Stream Reset Outputs                                               --
        altrnt_reset_out_n          : out std_logic := '1'                                 --
    );

-- Register duplication attribute assignments to control fanout
-- on handshake output signals

Attribute KEEP : string; -- declaration
Attribute EQUIVALENT_REGISTER_REMOVAL : string; -- declaration

Attribute KEEP of scndry_resetn                            : signal is "TRUE";
Attribute KEEP of prmry_resetn                             : signal is "TRUE";
Attribute KEEP of dm_scndry_resetn                         : signal is "TRUE";
Attribute KEEP of dm_prmry_resetn                          : signal is "TRUE";
Attribute KEEP of prmry_reset_out_n                        : signal is "TRUE";
Attribute KEEP of altrnt_reset_out_n                       : signal is "TRUE";

Attribute EQUIVALENT_REGISTER_REMOVAL of scndry_resetn     : signal is "no";
Attribute EQUIVALENT_REGISTER_REMOVAL of prmry_resetn      : signal is "no";
Attribute EQUIVALENT_REGISTER_REMOVAL of dm_scndry_resetn  : signal is "no";
Attribute EQUIVALENT_REGISTER_REMOVAL of dm_prmry_resetn   : signal is "no";
Attribute EQUIVALENT_REGISTER_REMOVAL of prmry_reset_out_n : signal is "no";
Attribute EQUIVALENT_REGISTER_REMOVAL of altrnt_reset_out_n: signal is "no";

end axi_dma_reset;

-------------------------------------------------------------------------------
-- Architecture
-------------------------------------------------------------------------------
architecture implementation of axi_dma_reset is
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

-- No Constants Declared

-------------------------------------------------------------------------------
-- Signal / Type Declarations
-------------------------------------------------------------------------------
-- Soft Reset Support
signal s_soft_reset_i               : std_logic := '0';
signal s_soft_reset_i_d1            : std_logic := '0';
signal s_soft_reset_i_re            : std_logic := '0';
signal assert_sftrst_d1             : std_logic := '0';
signal min_assert_sftrst            : std_logic := '0';
signal min_assert_sftrst_d1_cdc_tig         : std_logic := '0';
  --ATTRIBUTE async_reg OF min_assert_sftrst_d1_cdc_tig  : SIGNAL IS "true";
  --ATTRIBUTE async_reg OF min_assert_sftrst  : SIGNAL IS "true";

signal p_min_assert_sftrst          : std_logic := '0';
signal sft_rst_dly1                 : std_logic := '0';
signal sft_rst_dly2                 : std_logic := '0';
signal sft_rst_dly3                 : std_logic := '0';
signal sft_rst_dly4                 : std_logic := '0';
signal sft_rst_dly5                 : std_logic := '0';
signal sft_rst_dly6                 : std_logic := '0';
signal sft_rst_dly7                 : std_logic := '0';
signal sft_rst_dly8                 : std_logic := '0';
signal sft_rst_dly9                 : std_logic := '0';
signal sft_rst_dly10                : std_logic := '0';
signal sft_rst_dly11                : std_logic := '0';
signal sft_rst_dly12                : std_logic := '0';
signal sft_rst_dly13                : std_logic := '0';
signal sft_rst_dly14                : std_logic := '0';
signal sft_rst_dly15                : std_logic := '0';
signal sft_rst_dly16                : std_logic := '0';
signal soft_reset_d1                : std_logic := '0';
signal soft_reset_re                : std_logic := '0';

-- Soft Reset to Primary clock domain signals
signal p_soft_reset                 : std_logic := '0';
signal p_soft_reset_d1_cdc_tig              : std_logic := '0';
signal p_soft_reset_d2              : std_logic := '0';

  --ATTRIBUTE async_reg OF p_soft_reset_d1_cdc_tig  : SIGNAL IS "true";
  --ATTRIBUTE async_reg OF p_soft_reset_d2  : SIGNAL IS "true";
signal p_soft_reset_d3              : std_logic := '0';
signal p_soft_reset_re              : std_logic := '0';

-- Qualified soft reset in primary clock domain for
-- generating mimimum reset pulse for soft reset
signal p_soft_reset_i               : std_logic := '0';
signal p_soft_reset_i_d1            : std_logic := '0';
signal p_soft_reset_i_re            : std_logic := '0';


-- Graceful halt control
signal halt_cmplt_d1_cdc_tig                : std_logic := '0';
signal s_halt_cmplt                 : std_logic := '0';

  --ATTRIBUTE async_reg OF halt_cmplt_d1_cdc_tig  : SIGNAL IS "true";
  --ATTRIBUTE async_reg OF s_halt_cmplt  : SIGNAL IS "true";
signal p_halt_d1_cdc_tig                    : std_logic := '0';
signal p_halt                       : std_logic := '0';

  --ATTRIBUTE async_reg OF p_halt_d1_cdc_tig  : SIGNAL IS "true";
  --ATTRIBUTE async_reg OF p_halt  : SIGNAL IS "true";
signal s_halt                       : std_logic := '0';

-- composite reset (hard and soft)
signal resetn_i                     : std_logic := '1';
signal scndry_resetn_i              : std_logic := '1';
signal axi_resetn_d1_cdc_tig                : std_logic := '1';
signal axi_resetn_d2                : std_logic := '1';

  --ATTRIBUTE async_reg OF axi_resetn_d1_cdc_tig  : SIGNAL IS "true";
  --ATTRIBUTE async_reg OF axi_resetn_d2 : SIGNAL IS "true";

signal halt_i                       : std_logic := '0';

signal p_all_idle                   : std_logic := '1';
signal p_all_idle_d1_cdc_tig                : std_logic := '1';

signal halt_cmplt_reg : std_logic;

-------------------------------------------------------------------------------
-- Begin architecture logic
-------------------------------------------------------------------------------
begin

-------------------------------------------------------------------------------
-- Internal Hard Reset
-- Generate reset on hardware reset or soft reset
-------------------------------------------------------------------------------
resetn_i    <= '0' when s_soft_reset_i = '1'
                     or min_assert_sftrst = '1'
                     or axi_resetn = '0'
          else '1';

-------------------------------------------------------------------------------
-- Minimum Reset Logic for Soft Reset
-------------------------------------------------------------------------------
-- Register to generate rising edge on soft reset and falling edge
-- on reset assertion.
REG_SFTRST_FOR_RE : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            s_soft_reset_i_d1 <= s_soft_reset_i;
            assert_sftrst_d1  <= min_assert_sftrst;

            -- Register soft reset from DMACR to create
            -- rising edge pulse
            soft_reset_d1     <= soft_reset;

        end if;
    end process REG_SFTRST_FOR_RE;

-- rising edge pulse on internal soft reset
s_soft_reset_i_re <=  s_soft_reset_i and not s_soft_reset_i_d1;

-- CR605883
-- rising edge pulse on DMACR soft reset
REG_SOFT_RE : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            soft_reset_re   <= soft_reset and not soft_reset_d1;
        end if;
    end process REG_SOFT_RE;

-- falling edge detection on min soft rst to clear soft reset
-- bit in register module
soft_reset_clr <= (not min_assert_sftrst and assert_sftrst_d1)
                    or (not axi_resetn);


-------------------------------------------------------------------------------
-- Generate Reset for synchronous configuration
-------------------------------------------------------------------------------
GNE_SYNC_RESET : if C_PRMRY_IS_ACLK_ASYNC = 0 generate
begin

    -- On start of soft reset shift pulse through to assert
    -- 7 clock later.  Used to set minimum 8clk assertion of
    -- reset.  Shift starts when all is idle and internal reset
    -- is asserted.
    MIN_PULSE_GEN : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(s_soft_reset_i_re = '1')then
                    sft_rst_dly1    <= '1';
                    sft_rst_dly2    <= '0';
                    sft_rst_dly3    <= '0';
                    sft_rst_dly4    <= '0';
                    sft_rst_dly5    <= '0';
                    sft_rst_dly6    <= '0';
                    sft_rst_dly7    <= '0';
                elsif(all_idle = '1')then
                    sft_rst_dly1    <= '0';
                    sft_rst_dly2    <= sft_rst_dly1;
                    sft_rst_dly3    <= sft_rst_dly2;
                    sft_rst_dly4    <= sft_rst_dly3;
                    sft_rst_dly5    <= sft_rst_dly4;
                    sft_rst_dly6    <= sft_rst_dly5;
                    sft_rst_dly7    <= sft_rst_dly6;
                end if;
            end if;
        end process MIN_PULSE_GEN;

    -- Drive minimum reset assertion for 8 clocks.
    MIN_RESET_ASSERTION : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then

                if(s_soft_reset_i_re = '1')then
                    min_assert_sftrst <= '1';
                elsif(sft_rst_dly7 = '1')then
                    min_assert_sftrst <= '0';
                end if;
            end if;
        end process MIN_RESET_ASSERTION;

    -------------------------------------------------------------------------------
    -- Soft Reset Support
    -------------------------------------------------------------------------------
    -- Generate reset on hardware reset or soft reset if system is idle
    -- On soft reset or error
    -- mm2s dma controller will idle immediatly
    -- sg fetch engine will complete current task and idle (desc's will flush)
    -- sg update engine will update all completed descriptors then idle
    REG_SOFT_RESET : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(soft_reset = '1'
                and all_idle = '1' and halt_cmplt = '1')then
                    s_soft_reset_i <= '1';

                elsif(soft_reset_done = '1')then
                    s_soft_reset_i <= '0';

                end if;
            end if;
        end process REG_SOFT_RESET;

    -- Halt datamover on soft_reset or on error.  Halt will stay
    -- asserted until s_soft_reset_i assertion which occurs when
    -- halt is complete or hard reset
    REG_DM_HALT : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(resetn_i = '0')then
                    halt_i <= '0';
                elsif(soft_reset_re = '1' or stop = '1')then
                    halt_i <= '1';
                end if;
            end if;
        end process REG_DM_HALT;

    halt <= halt_i;

    -- AXI Stream reset output
    REG_STRM_RESET_OUT : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                prmry_reset_out_n   <= resetn_i and not s_soft_reset_i;
            end if;
        end process REG_STRM_RESET_OUT;

    -- If in Scatter Gather mode and status control stream included
    GEN_ALT_RESET_OUT : if C_INCLUDE_SG = 1 and C_SG_INCLUDE_STSCNTRL_STRM = 1 generate
    begin
        -- AXI Stream reset output
        REG_ALT_RESET_OUT : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    altrnt_reset_out_n  <= resetn_i and not s_soft_reset_i;
                end if;
            end process REG_ALT_RESET_OUT;
    end generate GEN_ALT_RESET_OUT;

    -- If in Simple mode or status control stream excluded
    GEN_NO_ALT_RESET_OUT : if C_INCLUDE_SG = 0 or C_SG_INCLUDE_STSCNTRL_STRM = 0 generate
    begin
        altrnt_reset_out_n <= '1';
    end generate GEN_NO_ALT_RESET_OUT;

    -- Registered primary and secondary resets out
    REG_RESET_OUT : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                prmry_resetn <= resetn_i;
                scndry_resetn <= resetn_i;
            end if;
        end process REG_RESET_OUT;

    -- AXI DataMover Primary Reset (Raw)
    dm_prmry_resetn  <= resetn_i;

    -- AXI DataMover Secondary Reset (Raw)
    dm_scndry_resetn <= resetn_i;

end generate GNE_SYNC_RESET;


-------------------------------------------------------------------------------
-- Generate Reset for asynchronous configuration
-------------------------------------------------------------------------------
GEN_ASYNC_RESET : if C_PRMRY_IS_ACLK_ASYNC = 1 generate
begin

    -- Primary clock is slower or equal to secondary therefore...
    -- For Halt - can simply pass secondary clock version of soft reset
    -- rising edge into p_halt assertion
    -- For Min Rst Assertion - can simply use secondary logic version of min pulse genator
    GEN_PRMRY_GRTR_EQL_SCNDRY : if C_AXI_PRMRY_ACLK_FREQ_HZ >= C_AXI_SCNDRY_ACLK_FREQ_HZ generate
    begin

        -- CR605883 - Register to provide pure register output for synchronizer
        REG_HALT_CONDITIONS : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    s_halt <= soft_reset_re or stop;
                end if;
            end process REG_HALT_CONDITIONS;

        -- Halt data mover on soft reset assertion, error (i.e. stop=1) or
        -- not running
HALT_PROCESS : entity  lib_cdc_v1_0_2.cdc_sync
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
        prmry_in                   => s_halt,
        prmry_vect_in              => (others => '0'),

        scndry_aclk                => axi_prmry_aclk,
        scndry_resetn              => '0',
        scndry_out                 => p_halt,
        scndry_vect_out            => open
    );



--        HALT_PROCESS : process(axi_prmry_aclk)
--            begin
--                if(axi_prmry_aclk'EVENT and axi_prmry_aclk = '1')then
--                    --p_halt_d1_cdc_tig <= soft_reset_re or stop;       -- CR605883
--                    p_halt_d1_cdc_tig <= s_halt;                        -- CR605883
--                    p_halt    <= p_halt_d1_cdc_tig;
--                end if;
--            end process HALT_PROCESS;

        -- On start of soft reset shift pulse through to assert
        -- 7 clock later.  Used to set minimum 8clk assertion of
        -- reset.  Shift starts when all is idle and internal reset
        -- is asserted.
        -- Adding 5 more flops to make up for 5 stages of Sync flops
        MIN_PULSE_GEN : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(s_soft_reset_i_re = '1')then
                        sft_rst_dly1    <= '1';
                        sft_rst_dly2    <= '0';
                        sft_rst_dly3    <= '0';
                        sft_rst_dly4    <= '0';
                        sft_rst_dly5    <= '0';
                        sft_rst_dly6    <= '0';
                        sft_rst_dly7    <= '0';
                        sft_rst_dly8    <= '0';
                        sft_rst_dly9    <= '0';
                        sft_rst_dly10   <= '0';
                        sft_rst_dly11   <= '0';
                        sft_rst_dly12   <= '0';
                        sft_rst_dly13   <= '0';
                        sft_rst_dly14   <= '0';
                        sft_rst_dly15   <= '0';
                        sft_rst_dly16   <= '0';
                    elsif(all_idle = '1')then
                        sft_rst_dly1    <= '0';
                        sft_rst_dly2    <= sft_rst_dly1;
                        sft_rst_dly3    <= sft_rst_dly2;
                        sft_rst_dly4    <= sft_rst_dly3;
                        sft_rst_dly5    <= sft_rst_dly4;
                        sft_rst_dly6    <= sft_rst_dly5;
                        sft_rst_dly7    <= sft_rst_dly6;
                        sft_rst_dly8    <= sft_rst_dly7;
                        sft_rst_dly9    <= sft_rst_dly8;
                        sft_rst_dly10   <= sft_rst_dly9;
                        sft_rst_dly11   <= sft_rst_dly10;
                        sft_rst_dly12   <= sft_rst_dly11;
                        sft_rst_dly13   <= sft_rst_dly12;
                        sft_rst_dly14   <= sft_rst_dly13;
                        sft_rst_dly15   <= sft_rst_dly14;
                        sft_rst_dly16   <= sft_rst_dly15;
                    end if;
                end if;
            end process MIN_PULSE_GEN;

        -- Drive minimum reset assertion for 8 clocks.
        MIN_RESET_ASSERTION : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then

                    if(s_soft_reset_i_re = '1')then
                        min_assert_sftrst <= '1';
                    elsif(sft_rst_dly16 = '1')then
                        min_assert_sftrst <= '0';
                    end if;
                end if;
            end process MIN_RESET_ASSERTION;

    end generate GEN_PRMRY_GRTR_EQL_SCNDRY;

    -- Primary clock is running slower than secondary therefore need to use a primary clock
    -- based rising edge version of soft_reset for primary halt assertion
    GEN_PRMRY_LESS_SCNDRY :  if C_AXI_PRMRY_ACLK_FREQ_HZ < C_AXI_SCNDRY_ACLK_FREQ_HZ generate
       signal soft_halt_int : std_logic := '0';
    begin

        -- Halt data mover on soft reset assertion, error (i.e. stop=1) or
        -- not running
         soft_halt_int <= p_soft_reset_re or stop;

HALT_PROCESS : entity  lib_cdc_v1_0_2.cdc_sync
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
        prmry_in                   => soft_halt_int,
        prmry_vect_in              => (others => '0'),

        scndry_aclk                => axi_prmry_aclk,
        scndry_resetn              => '0',
        scndry_out                 => p_halt,
        scndry_vect_out            => open
    );

--        HALT_PROCESS : process(axi_prmry_aclk)
--            begin
--                if(axi_prmry_aclk'EVENT and axi_prmry_aclk = '1')then
--                    p_halt_d1_cdc_tig <= p_soft_reset_re or stop;
--                    p_halt    <= p_halt_d1_cdc_tig;
--                end if;
--            end process HALT_PROCESS;


REG_IDLE2PRMRY : entity  lib_cdc_v1_0_2.cdc_sync
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
        prmry_in                   => all_idle,
        prmry_vect_in              => (others => '0'),

        scndry_aclk                => axi_prmry_aclk,
        scndry_resetn              => '0',
        scndry_out                 => p_all_idle,
        scndry_vect_out            => open
    );

--        REG_IDLE2PRMRY : process(axi_prmry_aclk)
--            begin
--                if(axi_prmry_aclk'EVENT and axi_prmry_aclk = '1')then
--                    p_all_idle_d1_cdc_tig   <= all_idle;
--                    p_all_idle      <= p_all_idle_d1_cdc_tig;
--                end if;
--            end process REG_IDLE2PRMRY;


        -- On start of soft reset shift pulse through to assert
        -- 7 clock later.  Used to set minimum 8clk assertion of
        -- reset.  Shift starts when all is idle and internal reset
        -- is asserted.
        MIN_PULSE_GEN : process(axi_prmry_aclk)
            begin
                if(axi_prmry_aclk'EVENT and axi_prmry_aclk = '1')then
                    -- CR574188 - fixes issue with soft reset terminating too early
                    -- for primary slower than secondary clock
                    --if(p_soft_reset_re = '1')then
                    if(p_soft_reset_i_re = '1')then
                        sft_rst_dly1    <= '1';
                        sft_rst_dly2    <= '0';
                        sft_rst_dly3    <= '0';
                        sft_rst_dly4    <= '0';
                        sft_rst_dly5    <= '0';
                        sft_rst_dly6    <= '0';
                        sft_rst_dly7    <= '0';
                        sft_rst_dly8    <= '0';
                        sft_rst_dly9    <= '0';
                        sft_rst_dly10   <= '0';
                        sft_rst_dly11   <= '0';
                        sft_rst_dly12   <= '0';
                        sft_rst_dly13   <= '0';
                        sft_rst_dly14   <= '0';
                        sft_rst_dly15   <= '0';
                        sft_rst_dly16   <= '0';
                    elsif(p_all_idle = '1')then
                        sft_rst_dly1    <= '0';
                        sft_rst_dly2    <= sft_rst_dly1;
                        sft_rst_dly3    <= sft_rst_dly2;
                        sft_rst_dly4    <= sft_rst_dly3;
                        sft_rst_dly5    <= sft_rst_dly4;
                        sft_rst_dly6    <= sft_rst_dly5;
                        sft_rst_dly7    <= sft_rst_dly6;
                        sft_rst_dly8    <= sft_rst_dly7;
                        sft_rst_dly9    <= sft_rst_dly8;
                        sft_rst_dly10   <= sft_rst_dly9;
                        sft_rst_dly11   <= sft_rst_dly10;
                        sft_rst_dly12   <= sft_rst_dly11;
                        sft_rst_dly13   <= sft_rst_dly12;
                        sft_rst_dly14   <= sft_rst_dly13;
                        sft_rst_dly15   <= sft_rst_dly14;
                        sft_rst_dly16   <= sft_rst_dly15;
                    end if;
                end if;
            end process MIN_PULSE_GEN;

        -- Drive minimum reset assertion for 8 primary clocks.
        MIN_RESET_ASSERTION : process(axi_prmry_aclk)
            begin
                if(axi_prmry_aclk'EVENT and axi_prmry_aclk = '1')then

                    -- CR574188 - fixes issue with soft reset terminating too early
                    -- for primary slower than secondary clock
                    --if(p_soft_reset_re = '1')then
                    if(p_soft_reset_i_re = '1')then
                        p_min_assert_sftrst <= '1';
                    elsif(sft_rst_dly16 = '1')then
                        p_min_assert_sftrst <= '0';
                    end if;
                end if;
            end process MIN_RESET_ASSERTION;

        -- register minimum reset pulse back to secondary domain

REG_MINRST2SCNDRY : entity  lib_cdc_v1_0_2.cdc_sync
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
        prmry_in                   => p_min_assert_sftrst,
        prmry_vect_in              => (others => '0'),

        scndry_aclk                => m_axi_sg_aclk,
        scndry_resetn              => '0',
        scndry_out                 => min_assert_sftrst,
        scndry_vect_out            => open
    );

--        REG_MINRST2SCNDRY : process(m_axi_sg_aclk)
--        begin
--            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
--                min_assert_sftrst_d1_cdc_tig <= p_min_assert_sftrst;
--                min_assert_sftrst    <= min_assert_sftrst_d1_cdc_tig;
--            end if;
--        end process REG_MINRST2SCNDRY;

        -- CR574188 - fixes issue with soft reset terminating too early
        -- for primary slower than secondary clock
        -- Generate reset on hardware reset or soft reset if system is idle
        REG_P_SOFT_RESET : process(axi_prmry_aclk)
            begin
                if(axi_prmry_aclk'EVENT and axi_prmry_aclk = '1')then
                    if(p_soft_reset = '1'
                    and p_all_idle = '1'
                    and halt_cmplt = '1')then
                        p_soft_reset_i <= '1';
                    else
                        p_soft_reset_i <= '0';
                    end if;
                end if;
            end process REG_P_SOFT_RESET;

        -- CR574188 - fixes issue with soft reset terminating too early
        -- for primary slower than secondary clock
        -- Register qualified soft reset flag for generating rising edge
        -- pulse for starting minimum reset pulse
        REG_SOFT2PRMRY : process(axi_prmry_aclk)
            begin
                if(axi_prmry_aclk'EVENT and axi_prmry_aclk = '1')then
                    p_soft_reset_i_d1 <=  p_soft_reset_i;
                end if;
            end process REG_SOFT2PRMRY;

        -- CR574188 - fixes issue with soft reset terminating too early
        -- for primary slower than secondary clock
        -- Generate rising edge pulse on qualified soft reset for min pulse
        -- logic.
        p_soft_reset_i_re <= p_soft_reset_i and not p_soft_reset_i_d1;

    end generate GEN_PRMRY_LESS_SCNDRY;

    -- Double register halt complete flag from primary to secondary
    -- clock domain.
    -- Note: halt complete stays asserted until halt clears therefore
    -- only need to double register from fast to slow clock domain.

process(axi_prmry_aclk)
begin
     if(axi_prmry_aclk'EVENT and axi_prmry_aclk = '1')then
         halt_cmplt_reg <=  halt_cmplt;
     end if;
end process;

REG_HALT_CMPLT_IN : entity  lib_cdc_v1_0_2.cdc_sync
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
        prmry_in                   => halt_cmplt_reg,
        prmry_vect_in              => (others => '0'),

        scndry_aclk                => m_axi_sg_aclk,
        scndry_resetn              => '0',
        scndry_out                 => s_halt_cmplt,
        scndry_vect_out            => open
    );

--    REG_HALT_CMPLT_IN : process(m_axi_sg_aclk)
--        begin
--            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
--
--                halt_cmplt_d1_cdc_tig   <= halt_cmplt;
--                s_halt_cmplt    <= halt_cmplt_d1_cdc_tig;
--            end if;
--        end process REG_HALT_CMPLT_IN;

    -------------------------------------------------------------------------------
    -- Soft Reset Support
    -------------------------------------------------------------------------------
    -- Generate reset on hardware reset or soft reset if system is idle
    REG_SOFT_RESET : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(soft_reset = '1'
                and all_idle = '1'
                and s_halt_cmplt = '1')then
                    s_soft_reset_i <= '1';
                elsif(soft_reset_done = '1')then
                    s_soft_reset_i <= '0';
                end if;
            end if;
        end process REG_SOFT_RESET;

    -- Register soft reset flag into primary domain to correcly
    -- halt data mover

REG_SOFT2PRMRY : entity  lib_cdc_v1_0_2.cdc_sync
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
        prmry_in                   => soft_reset,
        prmry_vect_in              => (others => '0'),

        scndry_aclk                => axi_prmry_aclk,
        scndry_resetn              => '0',
        scndry_out                 => p_soft_reset_d2,
        scndry_vect_out            => open
    );


    REG_SOFT2PRMRY1 : process(axi_prmry_aclk)
        begin
            if(axi_prmry_aclk'EVENT and axi_prmry_aclk = '1')then
--                p_soft_reset_d1_cdc_tig <=  soft_reset;
--                p_soft_reset_d2 <=  p_soft_reset_d1_cdc_tig;
                p_soft_reset_d3 <=  p_soft_reset_d2;

            end if;
        end process REG_SOFT2PRMRY1;


    -- Generate rising edge pulse for use with p_halt creation
    p_soft_reset_re <= p_soft_reset_d2 and not p_soft_reset_d3;

    -- used to mask halt reset below
    p_soft_reset    <= p_soft_reset_d2;

    -- Halt datamover on soft_reset or on error.  Halt will stay
    -- asserted until s_soft_reset_i assertion which occurs when
    -- halt is complete or hard reset
    REG_DM_HALT : process(axi_prmry_aclk)
        begin
            if(axi_prmry_aclk'EVENT and axi_prmry_aclk = '1')then
                if(axi_resetn_d2 = '0')then
                    halt_i <= '0';
                elsif(p_halt = '1')then
                    halt_i <= '1';
                end if;
            end if;
        end process REG_DM_HALT;

    halt <= halt_i;

    -- CR605883 (CDC) Create pure register out for synchronizer
    REG_CMB_RESET : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                scndry_resetn_i <= resetn_i;
            end if;
        end process REG_CMB_RESET;

    -- Sync to mm2s primary and register resets out

REG_RESET_OUT : entity  lib_cdc_v1_0_2.cdc_sync
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
        prmry_in                   => scndry_resetn_i,
        prmry_vect_in              => (others => '0'),

        scndry_aclk                => axi_prmry_aclk,
        scndry_resetn              => '0',
        scndry_out                 => axi_resetn_d2,
        scndry_vect_out            => open
    );

--    REG_RESET_OUT : process(axi_prmry_aclk)
--        begin
--            if(axi_prmry_aclk'EVENT and axi_prmry_aclk = '1')then
--                --axi_resetn_d1_cdc_tig  <= resetn_i;   -- CR605883
--                axi_resetn_d1_cdc_tig  <= scndry_resetn_i;
--                axi_resetn_d2  <= axi_resetn_d1_cdc_tig;
--            end if;
--        end process REG_RESET_OUT;

    -- Register resets out to AXI DMA Logic
    REG_SRESET_OUT : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                scndry_resetn <= resetn_i;
            end if;
        end process REG_SRESET_OUT;


    -- AXI Stream reset output
    prmry_reset_out_n   <= axi_resetn_d2;

    -- If in Scatter Gather mode and status control stream included
    GEN_ALT_RESET_OUT : if C_INCLUDE_SG = 1 and C_SG_INCLUDE_STSCNTRL_STRM = 1 generate
    begin
        -- AXI Stream alternate reset output
        altrnt_reset_out_n  <= axi_resetn_d2;
    end generate GEN_ALT_RESET_OUT;

    -- If in Simple Mode or status control stream excluded.
    GEN_NO_ALT_RESET_OUT : if C_INCLUDE_SG = 0 or C_SG_INCLUDE_STSCNTRL_STRM = 0 generate
    begin
        altrnt_reset_out_n  <= '1';
    end generate GEN_NO_ALT_RESET_OUT;

    -- Register primary reset
    prmry_resetn        <= axi_resetn_d2;

    -- AXI DataMover Primary Reset
    dm_prmry_resetn     <= axi_resetn_d2;

    -- AXI DataMover Secondary Reset
    dm_scndry_resetn    <= resetn_i;

end generate GEN_ASYNC_RESET;


end implementation;

