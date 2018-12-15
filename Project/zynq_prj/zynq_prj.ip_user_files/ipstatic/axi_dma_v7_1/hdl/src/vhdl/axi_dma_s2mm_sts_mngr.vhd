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
-- Filename:    axi_dma_s2mm_sts_mngr.vhd
-- Description: This entity mangages 'halt' and 'idle' status for the S2MM
--              channel
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
entity  axi_dma_s2mm_sts_mngr is
    generic (
        C_PRMRY_IS_ACLK_ASYNC        : integer range 0 to 1          := 0
            -- Primary MM2S/S2MM sync/async mode
            -- 0 = synchronous mode     - all clocks are synchronous
            -- 1 = asynchronous mode    - Any one of the 4 clock inputs is not
            --                            synchronous to the other
    );
    port (
        -----------------------------------------------------------------------
        -- AXI Scatter Gather Interface
        -----------------------------------------------------------------------
        m_axi_sg_aclk               : in  std_logic                         ;          --
        m_axi_sg_aresetn            : in  std_logic                         ;          --
                                                                                       --
        -- system state                                                                --
        s2mm_run_stop               : in  std_logic                         ;          --
        s2mm_ftch_idle              : in  std_logic                         ;          --
        s2mm_updt_idle              : in  std_logic                         ;          --
        s2mm_cmnd_idle              : in  std_logic                         ;          --
        s2mm_sts_idle               : in  std_logic                         ;          --
                                                                                       --
        -- stop and halt control/status                                                --
        s2mm_stop                   : in  std_logic                         ;          --
        s2mm_halt_cmplt             : in  std_logic                         ;          --
                                                                                       --
        -- system control                                                              --
        s2mm_all_idle               : out std_logic                         ;          --
        s2mm_halted_clr             : out std_logic                         ;          --
        s2mm_halted_set             : out std_logic                         ;          --
        s2mm_idle_set               : out std_logic                         ;          --
        s2mm_idle_clr               : out std_logic                                    --

    );

end axi_dma_s2mm_sts_mngr;

-------------------------------------------------------------------------------
-- Architecture
-------------------------------------------------------------------------------
architecture implementation of axi_dma_s2mm_sts_mngr is
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

signal all_is_idle          : std_logic := '0';
signal all_is_idle_d1       : std_logic := '0';
signal all_is_idle_re       : std_logic := '0';
signal all_is_idle_fe       : std_logic := '0';
signal s2mm_datamover_idle  : std_logic := '0';

signal s2mm_halt_cmpt_d1_cdc_tig    : std_logic := '0';
signal s2mm_halt_cmpt_cdc_d2    : std_logic := '0';
signal s2mm_halt_cmpt_d2    : std_logic := '0';
  --ATTRIBUTE async_reg OF s2mm_halt_cmpt_d1_cdc_tig  : SIGNAL IS "true";
  --ATTRIBUTE async_reg OF s2mm_halt_cmpt_cdc_d2  : SIGNAL IS "true";

-------------------------------------------------------------------------------
-- Begin architecture logic
-------------------------------------------------------------------------------
begin
-- all is idle when all is idle
all_is_idle <=  s2mm_ftch_idle
            and s2mm_updt_idle
            and s2mm_cmnd_idle
            and s2mm_sts_idle;


s2mm_all_idle   <= all_is_idle;

-------------------------------------------------------------------------------
-- For data mover halting look at halt complete to determine when halt
-- is done and datamover has completly halted.  If datamover not being
-- halted then can ignore flag thus simply flag as idle.
-------------------------------------------------------------------------------
GEN_FOR_ASYNC : if C_PRMRY_IS_ACLK_ASYNC = 1 generate
begin
    -- Double register to secondary clock domain.  This is sufficient
    -- because halt_cmplt will remain asserted until detected in
    -- reset module in secondary clock domain.
REG_TO_SECONDARY : entity  lib_cdc_v1_0_2.cdc_sync
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
        prmry_in                   => s2mm_halt_cmplt,
        prmry_vect_in              => (others => '0'),

        scndry_aclk                => m_axi_sg_aclk,
        scndry_resetn              => '0',
        scndry_out                 => s2mm_halt_cmpt_cdc_d2,
        scndry_vect_out            => open
    );

--    REG_TO_SECONDARY : process(m_axi_sg_aclk)
--        begin
--            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
----                if(m_axi_sg_aresetn = '0')then
----                    s2mm_halt_cmpt_d1_cdc_tig <= '0';
----                    s2mm_halt_cmpt_d2 <= '0';
----                else
--                    s2mm_halt_cmpt_d1_cdc_tig <= s2mm_halt_cmplt;
--                    s2mm_halt_cmpt_cdc_d2 <= s2mm_halt_cmpt_d1_cdc_tig;
----                end if;
--            end if;
--        end process REG_TO_SECONDARY;

                    s2mm_halt_cmpt_d2 <= s2mm_halt_cmpt_cdc_d2;

end generate GEN_FOR_ASYNC;

GEN_FOR_SYNC : if C_PRMRY_IS_ACLK_ASYNC = 0 generate
begin
    -- No clock crossing required therefore simple pass through
    s2mm_halt_cmpt_d2 <= s2mm_halt_cmplt;

end generate GEN_FOR_SYNC;

s2mm_datamover_idle  <= '1' when (s2mm_stop = '1' and s2mm_halt_cmpt_d2 = '1')
                              or (s2mm_stop = '0')
                   else '0';

-------------------------------------------------------------------------------
-- Set halt bit if run/stop cleared and all processes are idle
-------------------------------------------------------------------------------
HALT_PROCESS : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0')then
                s2mm_halted_set <= '0';
            elsif(s2mm_run_stop = '0' and all_is_idle = '1' and s2mm_datamover_idle = '1')then
                s2mm_halted_set <= '1';
            else
                s2mm_halted_set <=  '0';
            end if;
        end if;
    end process HALT_PROCESS;

-------------------------------------------------------------------------------
-- Clear halt bit if run/stop is set and SG engine begins to fetch descriptors
-------------------------------------------------------------------------------
NOT_HALTED_PROCESS : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0')then
                s2mm_halted_clr <= '0';
            elsif(s2mm_run_stop = '1')then
                s2mm_halted_clr <= '1';
            else
                s2mm_halted_clr <= '0';
            end if;
        end if;
    end process NOT_HALTED_PROCESS;

-------------------------------------------------------------------------------
-- Register ALL is Idle to create rising and falling edges on idle flag
-------------------------------------------------------------------------------
IDLE_REG_PROCESS : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0')then
                all_is_idle_d1 <= '0';
            else
                all_is_idle_d1 <= all_is_idle;
            end if;
        end if;
    end process IDLE_REG_PROCESS;

all_is_idle_re  <= all_is_idle and not all_is_idle_d1;
all_is_idle_fe  <= not all_is_idle and all_is_idle_d1;

-- Set or Clear IDLE bit in DMASR
s2mm_idle_set <= all_is_idle_re and s2mm_run_stop;
s2mm_idle_clr <= all_is_idle_fe;


end implementation;
