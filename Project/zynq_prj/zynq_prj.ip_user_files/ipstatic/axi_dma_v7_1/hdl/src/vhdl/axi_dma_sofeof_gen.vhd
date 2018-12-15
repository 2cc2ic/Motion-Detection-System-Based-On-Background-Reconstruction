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
-- Filename:    axi_dma_sofeof_gen.vhd
-- Description: This entity manages
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
entity  axi_dma_sofeof_gen is
    generic (
        C_PRMRY_IS_ACLK_ASYNC           : integer range 0 to 1         := 0
            -- Primary MM2S/S2MM sync/async mode
            -- 0 = synchronous mode     - all clocks are synchronous
            -- 1 = asynchronous mode    - Primary data path channels (MM2S and S2MM)
            --                            run asynchronous to AXI Lite, DMA Control,
            --                            and SG.
    );
    port (
        -----------------------------------------------------------------------
        -- AXI Scatter Gather Interface
        -----------------------------------------------------------------------
        axi_prmry_aclk              : in  std_logic                         ;           --
        p_reset_n                   : in  std_logic                         ;           --
                                                                                        --
        m_axi_sg_aclk               : in  std_logic                         ;           --
        m_axi_sg_aresetn            : in  std_logic                         ;           --
                                                                                        --
        axis_tready                 : in  std_logic                         ;           --
        axis_tvalid                 : in  std_logic                         ;           --
        axis_tlast                  : in  std_logic                         ;           --
                                                                                        --
        packet_sof                  : out std_logic                         ;           --
        packet_eof                  : out std_logic                                     --
                                                                                        --

    );

end axi_dma_sofeof_gen;

-------------------------------------------------------------------------------
-- Architecture
-------------------------------------------------------------------------------
architecture implementation of axi_dma_sofeof_gen is
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
signal p_ready          : std_logic := '0';
signal p_valid          : std_logic := '0';
signal p_valid_d1       : std_logic := '0';
signal p_valid_re       : std_logic := '0';
signal p_last           : std_logic := '0';
signal p_last_d1        : std_logic := '0';
signal p_last_re        : std_logic := '0';


signal s_ready          : std_logic := '0';
signal s_valid          : std_logic := '0';
signal s_valid_d1       : std_logic := '0';
signal s_valid_re       : std_logic := '0';
signal s_last           : std_logic := '0';
signal s_last_d1        : std_logic := '0';
signal s_last_re        : std_logic := '0';



signal s_sof_d1_cdc_tig         : std_logic := '0';
signal s_sof_d2         : std_logic := '0';
  --ATTRIBUTE async_reg OF s_sof_d1_cdc_tig  : SIGNAL IS "true";
  --ATTRIBUTE async_reg OF s_sof_d2  : SIGNAL IS "true";

signal s_sof_d3         : std_logic := '0';
signal s_sof_re         : std_logic := '0';

signal s_sof            : std_logic := '0';
signal p_sof            : std_logic := '0';

signal s_eof_d1_cdc_tig         : std_logic := '0';
signal s_eof_d2         : std_logic := '0';

  --ATTRIBUTE async_reg OF s_eof_d1_cdc_tig  : SIGNAL IS "true";
  --ATTRIBUTE async_reg OF s_eof_d2 : SIGNAL IS "true";
signal s_eof_d3         : std_logic := '0';
signal s_eof_re         : std_logic := '0';

signal p_eof            : std_logic := '0';
signal p_eof_d1_cdc_tig         : std_logic := '0';
signal p_eof_d2         : std_logic := '0';
  --ATTRIBUTE async_reg OF p_eof_d1_cdc_tig  : SIGNAL IS "true";
  --ATTRIBUTE async_reg OF p_eof_d2 : SIGNAL IS "true";

signal p_eof_d3         : std_logic := '0';
signal p_eof_clr        : std_logic := '0';

signal s_sof_generated  : std_logic := '0';
signal sof_generated_fe : std_logic := '0';
signal s_eof_re_latch   : std_logic := '0';

-------------------------------------------------------------------------------
-- Begin architecture logic
-------------------------------------------------------------------------------
begin

-- pass internal version out
packet_sof <= s_sof_re;
packet_eof <= s_eof_re;


-- Generate for when primary clock is asynchronous
GEN_FOR_ASYNC : if C_PRMRY_IS_ACLK_ASYNC = 1 generate
begin

    ---------------------------------------------------------------------------
    -- Generate Packet SOF
    ---------------------------------------------------------------------------

    -- Register stream control in to isolate wrt clock
    -- for timing closure
    REG_STRM_IN : process(axi_prmry_aclk)
        begin
            if(axi_prmry_aclk'EVENT and axi_prmry_aclk = '1')then
                if(p_reset_n = '0')then
                    p_valid <= '0';
                    p_last  <= '0';
                    p_ready <= '0';
                else
                    p_valid <= axis_tvalid;
                    p_last  <= axis_tlast ;
                    p_ready <= axis_tready;
                end if;
            end if;
        end process REG_STRM_IN;


    -- Generate rising edge pulse on valid to use for
    -- smaple and hold register
    REG_FOR_RE : process(axi_prmry_aclk)
        begin
            if(axi_prmry_aclk'EVENT and axi_prmry_aclk = '1')then
                if(p_reset_n = '0')then
                    p_valid_d1  <= '0';
                    p_last_d1   <= '0';
                    p_last_re   <= '0';
                else
                    p_valid_d1  <= p_valid and p_ready;
                    p_last_d1   <= p_last and p_valid and p_ready;

                    -- register to aligne with setting of p_sof
                    p_last_re   <= p_ready and p_valid and p_last and not p_last_d1;
                end if;
            end if;
        end process REG_FOR_RE;

    p_valid_re  <= p_ready and p_valid and not p_valid_d1;


    -- Sample and hold valid re to create sof
    SOF_SMPL_N_HOLD : process(axi_prmry_aclk)
        begin
            if(axi_prmry_aclk'EVENT and axi_prmry_aclk = '1')then
                -- clear at end of packet
                if(p_reset_n = '0' or p_eof_clr = '1')then
                    p_sof <= '0';

                -- assert at beginning of packet hold to allow
                -- clock crossing to slower secondary clk
                elsif(p_valid_re = '1')then
                    p_sof <= '1';

                end if;
            end if;
        end process SOF_SMPL_N_HOLD;

    -- Register p_sof into secondary clock domain to
    -- generate packet_sof and also to clear sample and held p_sof
SOF_REG2SCNDRY : entity  lib_cdc_v1_0_2.cdc_sync
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
        prmry_in                   => p_sof,
        prmry_vect_in              => (others => '0'),

        scndry_aclk                => m_axi_sg_aclk,
        scndry_resetn              => '0',
        scndry_out                 => s_sof_d2,
        scndry_vect_out            => open
    );


    SOF_REG2SCNDRY1 : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
--                    s_sof_d1_cdc_tig <= '0';
--                    s_sof_d2 <= '0';
                    s_sof_d3 <= '0';
                else
--                    s_sof_d1_cdc_tig <= p_sof;
--                    s_sof_d2 <= s_sof_d1_cdc_tig;
                    s_sof_d3 <= s_sof_d2;
                end if;
            end if;
        end process SOF_REG2SCNDRY1;

    s_sof_re <= s_sof_d2 and not s_sof_d3;

    ---------------------------------------------------------------------------
    -- Generate Packet EOF
    ---------------------------------------------------------------------------
    -- Sample and hold valid re to create sof
    EOF_SMPL_N_HOLD : process(axi_prmry_aclk)
        begin
            if(axi_prmry_aclk'EVENT and axi_prmry_aclk = '1')then
                if(p_reset_n = '0' or p_eof_clr = '1')then
                    p_eof <= '0';

                -- if p_last but p_sof not set then it means between pkt
                -- gap was too small to catch new sof.  therefor do not
                -- generate eof
                elsif(p_last_re = '1' and p_sof = '0')then
                    p_eof <= '0';

                elsif(p_last_re = '1')then
                    p_eof <= '1';
                end if;
            end if;
        end process EOF_SMPL_N_HOLD;

    -- Register p_sof into secondary clock domain to
    -- generate packet_sof and also to clear sample and held p_sof
    -- CDC register has to be a pure flop

EOF_REG2SCNDRY : entity  lib_cdc_v1_0_2.cdc_sync
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
        prmry_in                   => p_eof,
        prmry_vect_in              => (others => '0'),

        scndry_aclk                => m_axi_sg_aclk,
        scndry_resetn              => '0',
        scndry_out                 => s_eof_d2,
        scndry_vect_out            => open
    );

    EOF_REG2SCNDRY1 : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
--                    s_eof_d1_cdc_tig <= '0';
--                    s_eof_d2 <= '0';
                    s_eof_d3 <= '0';                      -- CR605883
                else
--                    s_eof_d1_cdc_tig <= p_eof;
--                    s_eof_d2 <= s_eof_d1_cdc_tig;
                    s_eof_d3 <= s_eof_d2;                 -- CR605883
                end if;
            end if;
        end process EOF_REG2SCNDRY1;

                    s_eof_re <= s_eof_d2 and not s_eof_d3;

    EOF_latch : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    s_eof_re_latch <= '0';
                elsif (s_eof_re = '1') then 
                    s_eof_re_latch <= not s_eof_re_latch;
                end if;
            end if;
        end process EOF_latch;


    -- Register s_sof_re back into primary clock domain to use
    -- as clear of p_sof.

EOF_REG2PRMRY : entity  lib_cdc_v1_0_2.cdc_sync
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
        prmry_in                   => s_eof_re_latch,
        prmry_vect_in              => (others => '0'),

        scndry_aclk                => axi_prmry_aclk,
        scndry_resetn              => '0',
        scndry_out                 => p_eof_d2,
        scndry_vect_out            => open
    );


    EOF_REG2PRMRY1 : process(axi_prmry_aclk)
        begin
            if(axi_prmry_aclk'EVENT and axi_prmry_aclk = '1')then
                if(p_reset_n = '0')then
               --     p_eof_d1_cdc_tig <= '0';
               --     p_eof_d2 <= '0';
                    p_eof_d3 <= '0';
                else
                --    p_eof_d1_cdc_tig <= s_eof_re_latch;
                --    p_eof_d2 <= p_eof_d1_cdc_tig;
                    p_eof_d3 <= p_eof_d2;

                end if;
            end if;
        end process EOF_REG2PRMRY1;


--    p_eof_clr <= p_eof_d2 and not p_eof_d3;-- CR565366
    -- drive eof clear for minimum of 2 scndry clocks
    -- to guarentee secondary capture.  this allows
    -- new valid assertions to not be missed in
    -- creating next sof.
    p_eof_clr <= p_eof_d2 xor p_eof_d3;



end generate GEN_FOR_ASYNC;

-- Generate for when primary clock is synchronous
GEN_FOR_SYNC : if C_PRMRY_IS_ACLK_ASYNC = 0 generate
begin

    ---------------------------------------------------------------------------
    -- Generate Packet EOF and SOF
    ---------------------------------------------------------------------------

    -- Register stream control in to isolate wrt clock
    -- for timing closure
    REG_STRM_IN : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    s_valid <= '0';
                    s_last  <= '0';
                    s_ready <= '0';
                else
                    s_valid <= axis_tvalid;
                    s_last  <= axis_tlast ;
                    s_ready <= axis_tready;
                end if;
            end if;
        end process REG_STRM_IN;

    -- Generate rising edge pulse on valid to use for
    -- smaple and hold register
    REG_FOR_RE : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    s_valid_d1  <= '0';
                    s_last_d1   <= '0';
                else
                    s_valid_d1  <= s_valid and s_ready;
                    s_last_d1   <= s_last and s_valid and s_ready;
                end if;
            end if;
        end process REG_FOR_RE;

-- CR565366 investigating delay interurpt issue discovered
-- this coding issue.
--    s_valid_re  <= s_ready and s_valid and not s_last_d1;
    s_valid_re  <= s_ready and s_valid and not s_valid_d1;

    s_last_re   <= s_ready and s_valid and s_last and not s_last_d1;

    -- Sample and hold valid re to create sof
    SOF_SMPL_N_HOLD : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(p_reset_n = '0' or s_eof_re = '1')then
                    s_sof_generated <= '0';
                -- new
                elsif((s_valid_re = '1')
                   or (sof_generated_fe = '1' and s_ready = '1' and s_valid = '1'))then
                    s_sof_generated <= '1';
                end if;
            end if;
        end process SOF_SMPL_N_HOLD;


    -- Register p_sof into secondary clock domain to
    -- generate packet_sof and also to clear sample and held p_sof
    SOF_REG2SCNDRY : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    s_sof_d1_cdc_tig <= '0';
                else
                    s_sof_d1_cdc_tig <= s_sof_generated;
                end if;
            end if;
        end process SOF_REG2SCNDRY;

    -- generate falling edge pulse on end of packet for use if
    -- need to generate an immediate sof.
    sof_generated_fe <= not s_sof_generated and s_sof_d1_cdc_tig;

    -- generate SOF on rising edge of valid if not already in a packet OR...
    s_sof_re <= '1' when (s_valid_re = '1' and s_sof_generated = '0')
                      or (sof_generated_fe = '1'        -- If end of previous packet
                               and s_ready = '1'        -- and ready asserted
                               and s_valid = '1')       -- and valid asserted
           else '0';

    -- generate eof on rising edge of valid last assertion OR...
    s_eof_re <= '1' when (s_last_re = '1')
                      or (sof_generated_fe = '1'        -- If end of previous packet
                               and s_ready = '1'        -- and ready asserted
                               and s_valid = '1'        -- and valid asserted
                               and s_last = '1')        -- and last asserted
           else '0';

end generate GEN_FOR_SYNC;



end implementation;
