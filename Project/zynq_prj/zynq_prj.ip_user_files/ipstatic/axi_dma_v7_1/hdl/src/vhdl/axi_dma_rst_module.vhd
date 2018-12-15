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
-- Filename:          axi_dma_rst_module.vhd
-- Description: This entity is the top level reset module entity for the
--              AXI VDMA core.
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

library lib_cdc_v1_0_2;


-------------------------------------------------------------------------------
entity  axi_dma_rst_module is
    generic(
        C_INCLUDE_MM2S                  : integer range 0 to 1      := 1;
            -- Include or exclude MM2S primary data path
            -- 0 = Exclude MM2S primary data path
            -- 1 = Include MM2S primary data path
        C_INCLUDE_S2MM                  : integer range 0 to 1      := 1;
            -- Include or exclude S2MM primary data path
            -- 0 = Exclude S2MM primary data path
            -- 1 = Include S2MM primary data path

        C_INCLUDE_SG                : integer range 0 to 1          := 1;
            -- Include or Exclude the Scatter Gather Engine
            -- 0 = Exclude SG Engine - Enables Simple DMA Mode
            -- 1 = Include SG Engine - Enables Scatter Gather Mode

        C_SG_INCLUDE_STSCNTRL_STRM  : integer range 0 to 1          := 1;
            -- Include or Exclude AXI Status and AXI Control Streams
            -- 0 = Exclude Status and Control Streams
            -- 1 = Include Status and Control Streams

        C_PRMRY_IS_ACLK_ASYNC       : integer range 0 to 1          := 0;
            -- Primary MM2S/S2MM sync/async mode
            -- 0 = synchronous mode     - all clocks are synchronous
            -- 1 = asynchronous mode    - Primary data path channels (MM2S and S2MM)
            --                            run asynchronous to AXI Lite, DMA Control,
            --                            and SG.

        C_M_AXI_MM2S_ACLK_FREQ_HZ        : integer := 100000000;
            -- Primary clock frequency in hertz

        C_M_AXI_S2MM_ACLK_FREQ_HZ        : integer := 100000000;
            -- Primary clock frequency in hertz

        C_M_AXI_SG_ACLK_FREQ_HZ          : integer := 100000000
            -- Scatter Gather clock frequency in hertz




    );
    port (
        -----------------------------------------------------------------------
        -- Clock Sources
        -----------------------------------------------------------------------
        s_axi_lite_aclk             : in  std_logic                         ;
        m_axi_sg_aclk               : in  std_logic                         ;           --
        m_axi_mm2s_aclk             : in  std_logic                         ;           --
        m_axi_s2mm_aclk             : in  std_logic                         ;           --
                                                                                        --
        -----------------------------------------------------------------------         --
        -- Hard Reset                                                                   --
        -----------------------------------------------------------------------         --
        axi_resetn                  : in  std_logic                         ;           --

        -----------------------------------------------------------------------         --
        -- Soft Reset                                                                   --
        -----------------------------------------------------------------------         --
        soft_reset                  : in  std_logic                         ;           --
        soft_reset_clr              : out std_logic := '0'                  ;           --
                                                                                        --
        -----------------------------------------------------------------------         --
        -- MM2S Soft Reset Support                                                      --
        -----------------------------------------------------------------------         --
        mm2s_all_idle               : in  std_logic                         ;           --
        mm2s_stop                   : in  std_logic                         ;           --
        mm2s_halt                   : out std_logic := '0'                  ;           --
        mm2s_halt_cmplt             : in  std_logic                         ;           --
                                                                                        --
        -----------------------------------------------------------------------         --
        -- S2MM Soft Reset Support                                                      --
        -----------------------------------------------------------------------         --
        s2mm_all_idle               : in  std_logic                         ;           --
        s2mm_stop                   : in  std_logic                         ;           --
        s2mm_halt                   : out std_logic := '0'                  ;           --
        s2mm_halt_cmplt             : in  std_logic                         ;           --
                                                                                        --
        -----------------------------------------------------------------------         --
        -- MM2S Distributed Reset Out                                                   --
        -----------------------------------------------------------------------         --
        -- AXI DataMover Primary Reset (Raw)                                            --
        dm_mm2s_prmry_resetn        : out std_logic := '1'                  ;           --
        -- AXI DataMover Secondary Reset (Raw)                                          --
        dm_mm2s_scndry_resetn       : out std_logic := '1'                  ;
        -- AXI Stream Primary Reset Outputs                                             --
        mm2s_prmry_reset_out_n      : out std_logic := '1'                  ;           --
        -- AXI Stream Control Reset Outputs                                             --
        mm2s_cntrl_reset_out_n      : out std_logic := '1'                  ;           --
        -- AXI Secondary reset
        mm2s_scndry_resetn          : out std_logic := '1'                  ;           --
        -- AXI Upsizer and Line Buffer                                                  --
        mm2s_prmry_resetn           : out std_logic := '1'                  ;           --
                                                                                        --
                                                                                        --
        -----------------------------------------------------------------------         --
        -- S2MM Distributed Reset Out                                                   --
        -----------------------------------------------------------------------         --
        -- AXI DataMover Primary Reset (Raw)                                            --
        dm_s2mm_prmry_resetn        : out std_logic := '1'                  ;           --
        -- AXI DataMover Secondary Reset (Raw)                                          --
        dm_s2mm_scndry_resetn       : out std_logic := '1'                  ;
        -- AXI Stream Primary Reset Outputs                                             --
        s2mm_prmry_reset_out_n      : out std_logic := '1'                  ;           --
        -- AXI Stream Control Reset Outputs                                             --
        s2mm_sts_reset_out_n        : out std_logic := '1'                  ;           --
        -- AXI Secondary reset
        s2mm_scndry_resetn          : out std_logic := '1'                  ;           --
        -- AXI Upsizer and Line Buffer                                                  --
        s2mm_prmry_resetn           : out std_logic := '1'                  ;           --

        -----------------------------------------------------------------------         --
        -- Scatter Gather Distributed Reset Out
        -----------------------------------------------------------------------         --
        -- AXI Scatter Gather Reset Out
        m_axi_sg_aresetn            : out std_logic := '1'                  ;           --
        -- AXI Scatter Gather Datamover Reset Out
        dm_m_axi_sg_aresetn         : out std_logic := '1'                  ;           --


        -----------------------------------------------------------------------         --
        -- Hard Reset Out                                                               --
        -----------------------------------------------------------------------         --
        m_axi_sg_hrdresetn          : out std_logic := '1'                  ;           --
        s_axi_lite_resetn           : out std_logic := '1'                              --
    );


Attribute KEEP : string; -- declaration
Attribute EQUIVALENT_REGISTER_REMOVAL : string; -- declaration

Attribute KEEP of s_axi_lite_resetn                                 : signal is "TRUE";
Attribute KEEP of m_axi_sg_hrdresetn                                : signal is "TRUE";

Attribute EQUIVALENT_REGISTER_REMOVAL of s_axi_lite_resetn          : signal is "no";
Attribute EQUIVALENT_REGISTER_REMOVAL of m_axi_sg_hrdresetn         : signal is "no";

end axi_dma_rst_module;

-------------------------------------------------------------------------------
-- Architecture
-------------------------------------------------------------------------------
architecture implementation of axi_dma_rst_module is
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
  ATTRIBUTE async_reg                      : STRING;


signal hrd_resetn_i_cdc_tig                     : std_logic := '1';
signal hrd_resetn_i_d1_cdc_tig                  : std_logic := '1';
  --ATTRIBUTE async_reg OF hrd_resetn_i_cdc_tig  : SIGNAL IS "true";
  --ATTRIBUTE async_reg OF hrd_resetn_i_d1_cdc_tig : SIGNAL IS "true";

-- Soft reset support
signal mm2s_soft_reset_clr              : std_logic := '0';
signal s2mm_soft_reset_clr              : std_logic := '0';
signal soft_reset_clr_i                 : std_logic := '0';
signal mm2s_soft_reset_done             : std_logic := '0';
signal s2mm_soft_reset_done             : std_logic := '0';

signal mm2s_scndry_resetn_i             : std_logic := '0';
signal s2mm_scndry_resetn_i             : std_logic := '0';

signal dm_mm2s_scndry_resetn_i          : std_logic := '0';
signal dm_s2mm_scndry_resetn_i          : std_logic := '0';

signal sg_hard_reset                    : std_logic := '0';

-------------------------------------------------------------------------------
-- Begin architecture logic
-------------------------------------------------------------------------------
begin
-- Register hard reset in

REG_HRD_RST : entity  lib_cdc_v1_0_2.cdc_sync
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
        prmry_in                   => axi_resetn,
        prmry_vect_in              => (others => '0'),

        scndry_aclk                => m_axi_sg_aclk,
        scndry_resetn              => '0',
        scndry_out                 => sg_hard_reset, 
        scndry_vect_out            => open
    );

m_axi_sg_hrdresetn <= sg_hard_reset;

--REG_HRD_RST : process(m_axi_sg_aclk)
--    begin
--        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
--            hrd_resetn_i_cdc_tig        <= axi_resetn;
--            m_axi_sg_hrdresetn  <= hrd_resetn_i_cdc_tig;
--        end if;
--    end process REG_HRD_RST;

-- Regsiter hard reset out for axi lite interface

REG_HRD_RST_OUT : entity  lib_cdc_v1_0_2.cdc_sync
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
        prmry_in                   => axi_resetn,
        prmry_vect_in              => (others => '0'),

        scndry_aclk                => s_axi_lite_aclk,
        scndry_resetn              => '0',
        scndry_out                 => s_axi_lite_resetn,
        scndry_vect_out            => open
    );


--REG_HRD_RST_OUT : process(s_axi_lite_aclk)
--    begin
--        if(s_axi_lite_aclk'EVENT and s_axi_lite_aclk = '1')then
--            hrd_resetn_i_d1_cdc_tig     <= hrd_resetn_i_cdc_tig;
--            s_axi_lite_resetn   <= hrd_resetn_i_d1_cdc_tig;
--        end if;
--    end process REG_HRD_RST_OUT;

dm_mm2s_scndry_resetn <= dm_mm2s_scndry_resetn_i;
dm_s2mm_scndry_resetn <= dm_s2mm_scndry_resetn_i;


-- mm2s channel included therefore map secondary resets to
-- from mm2s reset module to scatter gather interface (default)
MAP_SG_FOR_BOTH : if C_INCLUDE_MM2S = 1  and C_INCLUDE_S2MM = 1 generate
begin

    -- both must be low before sg reset is asserted.
    m_axi_sg_aresetn       <= mm2s_scndry_resetn_i or s2mm_scndry_resetn_i;
    dm_m_axi_sg_aresetn    <= dm_mm2s_scndry_resetn_i or dm_s2mm_scndry_resetn_i;

end generate MAP_SG_FOR_BOTH;

-- Only s2mm channel included therefore map secondary resets to
-- from s2mm reset module to scatter gather interface
MAP_SG_FOR_S2MM : if C_INCLUDE_MM2S = 0 and C_INCLUDE_S2MM = 1 generate
begin

    m_axi_sg_aresetn       <= s2mm_scndry_resetn_i;
    dm_m_axi_sg_aresetn    <= dm_s2mm_scndry_resetn_i;

end generate MAP_SG_FOR_S2MM;

-- Only mm2s channel included therefore map secondary resets to
-- from mm2s reset module to scatter gather interface
MAP_SG_FOR_MM2S : if C_INCLUDE_MM2S = 1 and C_INCLUDE_S2MM = 0 generate
begin

    m_axi_sg_aresetn       <= mm2s_scndry_resetn_i;
    dm_m_axi_sg_aresetn    <= dm_mm2s_scndry_resetn_i;

end generate MAP_SG_FOR_MM2S;

-- Invalid configuration for axi dma - simply here for completeness
MAP_NO_SG : if C_INCLUDE_MM2S = 0 and C_INCLUDE_S2MM = 0 generate
begin

    m_axi_sg_aresetn       <= '1';
    dm_m_axi_sg_aresetn    <= '1';

end generate MAP_NO_SG;


s2mm_scndry_resetn <= s2mm_scndry_resetn_i;
mm2s_scndry_resetn <= mm2s_scndry_resetn_i;



-- Generate MM2S reset signals
GEN_RESET_FOR_MM2S : if C_INCLUDE_MM2S = 1 generate
begin
    RESET_I : entity  axi_dma_v7_1_8.axi_dma_reset
        generic map(
            C_PRMRY_IS_ACLK_ASYNC       => C_PRMRY_IS_ACLK_ASYNC        ,
            C_AXI_PRMRY_ACLK_FREQ_HZ    => C_M_AXI_MM2S_ACLK_FREQ_HZ    ,
            C_AXI_SCNDRY_ACLK_FREQ_HZ   => C_M_AXI_SG_ACLK_FREQ_HZ      ,
            C_SG_INCLUDE_STSCNTRL_STRM  => C_SG_INCLUDE_STSCNTRL_STRM   ,
            C_INCLUDE_SG                => C_INCLUDE_SG
        )
        port map(
            -- Clock Sources
            m_axi_sg_aclk               => m_axi_sg_aclk                ,
            axi_prmry_aclk              => m_axi_mm2s_aclk              ,

            -- Hard Reset
            axi_resetn                  => sg_hard_reset                 ,

            -- Soft Reset
            soft_reset                  => soft_reset                   ,
            soft_reset_clr              => mm2s_soft_reset_clr          ,
            soft_reset_done             => soft_reset_clr_i             ,

            all_idle                    => mm2s_all_idle                ,
            stop                        => mm2s_stop                    ,
            halt                        => mm2s_halt                    ,
            halt_cmplt                  => mm2s_halt_cmplt              ,


            -- Secondary Reset
            scndry_resetn               => mm2s_scndry_resetn_i         ,
            -- AXI Upsizer and Line Buffer
            prmry_resetn                => mm2s_prmry_resetn            ,
            -- AXI DataMover Primary Reset (Raw)
            dm_prmry_resetn             => dm_mm2s_prmry_resetn         ,
            -- AXI DataMover Secondary Reset (Raw)
            dm_scndry_resetn            => dm_mm2s_scndry_resetn_i      ,
            -- AXI Stream Primary Reset Outputs
            prmry_reset_out_n           => mm2s_prmry_reset_out_n       ,
            -- AXI Stream Alternate Reset Outputs
            altrnt_reset_out_n          => mm2s_cntrl_reset_out_n
        );


    -- Sample an hold mm2s soft reset done to use in
    -- combined reset done to DMACR
    MM2S_SOFT_RST_DONE : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(sg_hard_reset = '0' or soft_reset_clr_i = '1')then
                    mm2s_soft_reset_done <= '0';
                elsif(mm2s_soft_reset_clr = '1')then
                    mm2s_soft_reset_done <= '1';
                end if;
            end if;
        end process MM2S_SOFT_RST_DONE;

end generate GEN_RESET_FOR_MM2S;


-- No MM2S therefore tie off mm2s reset signals
GEN_NO_RESET_FOR_MM2S : if C_INCLUDE_MM2S = 0 generate
begin
    mm2s_prmry_reset_out_n  <= '1';
    mm2s_cntrl_reset_out_n  <= '1';
    dm_mm2s_scndry_resetn_i <= '1';
    dm_mm2s_prmry_resetn    <= '1';
    mm2s_prmry_resetn       <= '1';
    mm2s_scndry_resetn_i    <= '1';
    mm2s_halt               <= '0';
    mm2s_soft_reset_clr     <= '0';
    mm2s_soft_reset_done    <= '1';

end generate GEN_NO_RESET_FOR_MM2S;


-- Generate S2MM reset signals
GEN_RESET_FOR_S2MM : if C_INCLUDE_S2MM = 1 generate
begin
    RESET_I : entity  axi_dma_v7_1_8.axi_dma_reset
        generic map(
            C_PRMRY_IS_ACLK_ASYNC       => C_PRMRY_IS_ACLK_ASYNC        ,
            C_AXI_PRMRY_ACLK_FREQ_HZ    => C_M_AXI_S2MM_ACLK_FREQ_HZ    ,
            C_AXI_SCNDRY_ACLK_FREQ_HZ   => C_M_AXI_SG_ACLK_FREQ_HZ      ,
            C_SG_INCLUDE_STSCNTRL_STRM  => C_SG_INCLUDE_STSCNTRL_STRM   ,
            C_INCLUDE_SG                => C_INCLUDE_SG
        )
        port map(
            -- Clock Sources
            m_axi_sg_aclk               => m_axi_sg_aclk                ,
            axi_prmry_aclk              => m_axi_s2mm_aclk              ,

            -- Hard Reset
            axi_resetn                  => sg_hard_reset                 ,

            -- Soft Reset
            soft_reset                  => soft_reset                   ,
            soft_reset_clr              => s2mm_soft_reset_clr          ,
            soft_reset_done             => soft_reset_clr_i             ,

            all_idle                    => s2mm_all_idle                ,
            stop                        => s2mm_stop                    ,
            halt                        => s2mm_halt                    ,
            halt_cmplt                  => s2mm_halt_cmplt              ,


            -- Secondary Reset
            scndry_resetn               => s2mm_scndry_resetn_i         ,
            -- AXI Upsizer and Line Buffer
            prmry_resetn                => s2mm_prmry_resetn            ,
            -- AXI DataMover Primary Reset (Raw)
            dm_prmry_resetn             => dm_s2mm_prmry_resetn         ,
            -- AXI DataMover Secondary Reset (Raw)
            dm_scndry_resetn            => dm_s2mm_scndry_resetn_i      ,
            -- AXI Stream Primary Reset Outputs
            prmry_reset_out_n           => s2mm_prmry_reset_out_n       ,
            -- AXI Stream Alternate Reset Outputs
            altrnt_reset_out_n          => s2mm_sts_reset_out_n
        );

    -- Sample an hold s2mm soft reset done to use in
    -- combined reset done to DMACR
    S2MM_SOFT_RST_DONE : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(sg_hard_reset = '0' or soft_reset_clr_i = '1')then
                    s2mm_soft_reset_done <= '0';
                elsif(s2mm_soft_reset_clr = '1')then
                    s2mm_soft_reset_done <= '1';
                end if;
            end if;
        end process S2MM_SOFT_RST_DONE;

end generate GEN_RESET_FOR_S2MM;

-- No SsMM therefore tie off mm2s reset signals
GEN_NO_RESET_FOR_S2MM : if C_INCLUDE_S2MM = 0 generate
begin
    s2mm_prmry_reset_out_n  <= '1';
    dm_s2mm_scndry_resetn_i <= '1';
    dm_s2mm_prmry_resetn    <= '1';
    s2mm_prmry_resetn       <= '1';
    s2mm_scndry_resetn_i    <= '1';
    s2mm_halt               <= '0';
    s2mm_soft_reset_clr     <= '0';
    s2mm_soft_reset_done    <= '1';

end generate GEN_NO_RESET_FOR_S2MM;




-- When both mm2s and s2mm are done then drive soft reset clear and
-- also clear s_h registers above
soft_reset_clr_i    <= s2mm_soft_reset_done and mm2s_soft_reset_done;

soft_reset_clr      <= soft_reset_clr_i;


end implementation;

