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
-- Filename:    axi_dma_mm2s_sts_mngr.vhd
-- Description: This entity mangages 'halt' and 'idle' status for the MM2S
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
entity  axi_dma_mm2s_sts_mngr is
    generic (
        C_PRMRY_IS_ACLK_ASYNC        : integer range 0 to 1          := 0
            -- Primary MM2S/S2MM sync/async mode
            -- 0 = synchronous mode     - all clocks are synchronous
            -- 1 = asynchronous mode    - Any one of the 4 clock inputs is not
            --                            synchronous to the other
    );
    port (
        -- system signals
        m_axi_sg_aclk               : in  std_logic                         ;           --
        m_axi_sg_aresetn            : in  std_logic                         ;           --
                                                                                        --
        -- dma control and sg engine status signals                                     --
        mm2s_run_stop               : in  std_logic                         ;           --
                                                                                        --
        mm2s_ftch_idle              : in  std_logic                         ;           --
        mm2s_updt_idle              : in  std_logic                         ;           --
        mm2s_cmnd_idle              : in  std_logic                         ;           --
        mm2s_sts_idle               : in  std_logic                         ;           --
                                                                                        --
        -- stop and halt control/status                                                 --
        mm2s_stop                   : in  std_logic                         ;           --
        mm2s_halt_cmplt             : in  std_logic                         ;           --
                                                                                        --
        -- system state and control                                                     --
        mm2s_all_idle               : out std_logic                         ;           --
        mm2s_halted_clr             : out std_logic                         ;           --
        mm2s_halted_set             : out std_logic                         ;           --
        mm2s_idle_set               : out std_logic                         ;           --
        mm2s_idle_clr               : out std_logic                                     --

    );

end axi_dma_mm2s_sts_mngr;

-------------------------------------------------------------------------------
-- Architecture
-------------------------------------------------------------------------------
architecture implementation of axi_dma_mm2s_sts_mngr is
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
signal mm2s_datamover_idle  : std_logic := '0';

signal mm2s_halt_cmpt_d1_cdc_tig    : std_logic := '0';
signal mm2s_halt_cmpt_cdc_d2    : std_logic := '0';
  --ATTRIBUTE async_reg OF mm2s_halt_cmpt_d1_cdc_tig  : SIGNAL IS "true";
  --ATTRIBUTE async_reg OF mm2s_halt_cmpt_cdc_d2  : SIGNAL IS "true";

signal mm2s_halt_cmpt_d2    : std_logic := '0';

-------------------------------------------------------------------------------
-- Begin architecture logic
-------------------------------------------------------------------------------
begin

-- Everything is idle when everything is idle
all_is_idle <=  mm2s_ftch_idle
            and mm2s_updt_idle
            and mm2s_cmnd_idle
            and mm2s_sts_idle;

-- Pass out for soft reset use
mm2s_all_idle <= all_is_idle;



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
AWVLD_CDC_TO : entity  lib_cdc_v1_0_2.cdc_sync
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
        prmry_in                   => mm2s_halt_cmplt,
        prmry_vect_in              => (others => '0'),

        scndry_aclk                => m_axi_sg_aclk,
        scndry_resetn              => '0',
        scndry_out                 => mm2s_halt_cmpt_cdc_d2,
        scndry_vect_out            => open
    );


--    REG_TO_SECONDARY : process(m_axi_sg_aclk)
--        begin
--            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
--            --    if(m_axi_sg_aresetn = '0')then
--            --        mm2s_halt_cmpt_d1_cdc_tig <= '0';
--            --        mm2s_halt_cmpt_d2 <= '0';
--            --    else
--                    mm2s_halt_cmpt_d1_cdc_tig <= mm2s_halt_cmplt;
--                    mm2s_halt_cmpt_cdc_d2 <= mm2s_halt_cmpt_d1_cdc_tig;
--            --    end if;
--            end if;
--        end process REG_TO_SECONDARY;

                    mm2s_halt_cmpt_d2 <= mm2s_halt_cmpt_cdc_d2;

end generate GEN_FOR_ASYNC;

GEN_FOR_SYNC : if C_PRMRY_IS_ACLK_ASYNC = 0 generate
begin
    -- No clock crossing required therefore simple pass through
    mm2s_halt_cmpt_d2 <= mm2s_halt_cmplt;

end generate GEN_FOR_SYNC;




mm2s_datamover_idle  <= '1' when (mm2s_stop = '1' and mm2s_halt_cmpt_d2 = '1')
                              or (mm2s_stop = '0')
                   else '0';

-------------------------------------------------------------------------------
-- Set halt bit if run/stop cleared and all processes are idle
-------------------------------------------------------------------------------
HALT_PROCESS : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0')then
                mm2s_halted_set <= '0';

            -- DMACR.Run/Stop is cleared, all processes are idle, datamover halt cmplted
            elsif(mm2s_run_stop = '0' and all_is_idle = '1' and mm2s_datamover_idle = '1')then
                mm2s_halted_set <= '1';
            else
                mm2s_halted_set <= '0';
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
                mm2s_halted_clr <= '0';
            elsif(mm2s_run_stop = '1')then
                mm2s_halted_clr <= '1';
            else
                mm2s_halted_clr <= '0';
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
mm2s_idle_set <= all_is_idle_re and mm2s_run_stop;
mm2s_idle_clr <= all_is_idle_fe;


end implementation;
