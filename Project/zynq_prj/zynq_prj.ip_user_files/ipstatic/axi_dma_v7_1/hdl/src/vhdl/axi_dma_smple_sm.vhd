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
-- Filename:          axi_dma_smple_sm.vhd
-- Description: This entity contains the DMA Controller State Machine for
--              Simple DMA mode.
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

library lib_pkg_v1_0_2;
use lib_pkg_v1_0_2.lib_pkg.clog2;


-------------------------------------------------------------------------------
entity  axi_dma_smple_sm is
    generic (
        C_M_AXI_ADDR_WIDTH          : integer range 32 to 64    := 32;
            -- Master AXI Memory Map Address Width for MM2S Read Port

        C_SG_LENGTH_WIDTH           : integer range 8 to 23     := 14;
            -- Width of Buffer Length, Transferred Bytes, and BTT fields

        C_MICRO_DMA                 : integer range 0 to 1      := 0
    );
    port (
        m_axi_sg_aclk               : in  std_logic                         ;                      --
        m_axi_sg_aresetn            : in  std_logic                         ;                      --
                                                                                                   --
        -- Channel 1 Control and Status                                                            --
        run_stop                    : in  std_logic                         ;                      --
        keyhole                     : in  std_logic                         ;
        stop                        : in  std_logic                         ;                      --
        cmnd_idle                   : out std_logic                         ;                      --
        sts_idle                    : out std_logic                         ;                      --
                                                                                                   --
        -- DataMover Status                                                                        --
        sts_received                : in  std_logic                         ;                      --
        sts_received_clr            : out std_logic                         ;                      --
                                                                                                   --
        -- DataMover Command                                                                       --
        cmnd_wr                     : out std_logic                         ;                      --
        cmnd_data                   : out std_logic_vector                                         --
                                           ((C_M_AXI_ADDR_WIDTH-32+2*32+CMD_BASE_WIDTH+46)-1 downto 0);       --
        cmnd_pending                : in std_logic                          ;                      --
                                                                                                   --
        -- Trasnfer Qualifiers                                                                     --
        xfer_length_wren            : in  std_logic                         ;                      --
        xfer_address                : in  std_logic_vector                                         --
                                        (C_M_AXI_ADDR_WIDTH-1 downto 0)     ;                      --
        xfer_length                 : in  std_logic_vector                                         --
                                        (C_SG_LENGTH_WIDTH - 1 downto 0)                           --
    );

end axi_dma_smple_sm;

-------------------------------------------------------------------------------
-- Architecture
-------------------------------------------------------------------------------
architecture implementation of axi_dma_smple_sm is
  attribute DowngradeIPIdentifiedWarnings: string;
  attribute DowngradeIPIdentifiedWarnings of implementation : architecture is "yes";


-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------

-- No Functions Declared

-------------------------------------------------------------------------------
-- Constants Declarations
-------------------------------------------------------------------------------
-- DataMover Command Destination Stream Offset
constant CMD_DSA            : std_logic_vector(5 downto 0)  := (others => '0');
-- DataMover Cmnd Reserved Bits
constant CMD_RSVD           : std_logic_vector(
                                DATAMOVER_CMD_RSVMSB_BOFST + C_M_AXI_ADDR_WIDTH downto
                                DATAMOVER_CMD_RSVLSB_BOFST + C_M_AXI_ADDR_WIDTH)
                                := (others => '0');


-------------------------------------------------------------------------------
-- Signal / Type Declarations
-------------------------------------------------------------------------------
type SMPL_STATE_TYPE        is (
                                IDLE,
                                EXECUTE_XFER,
                                WAIT_STATUS
                                );

signal smpl_cs                  : SMPL_STATE_TYPE;
signal smpl_ns                  : SMPL_STATE_TYPE;



-- State Machine Signals
signal write_cmnd_cmb           : std_logic := '0';
signal cmnd_wr_i                : std_logic := '0';
signal sts_received_clr_cmb     : std_logic := '0';

signal cmnds_queued             : std_logic := '0';
signal cmd_dumb                 : std_logic_vector (31 downto 0) := (others => '0');
signal zeros                    : std_logic_vector (45 downto 0) := (others => '0');

signal burst_type               : std_logic;
-------------------------------------------------------------------------------
-- Begin architecture logic
-------------------------------------------------------------------------------
begin
-- Pass command write control out
cmnd_wr    <= cmnd_wr_i;

burst_type <= '1' and (not keyhole);
-- 0 means fixed burst
-- 1 means increment burst

-------------------------------------------------------------------------------
-- MM2S Transfer State Machine
-------------------------------------------------------------------------------
MM2S_MACHINE : process(smpl_cs,
                       run_stop,
                       xfer_length_wren,
                       sts_received,
                       cmnd_pending,
                       cmnds_queued,
                       stop
                       )
    begin

        -- Default signal assignment
        write_cmnd_cmb          <= '0';
        sts_received_clr_cmb    <= '0';
        cmnd_idle               <= '0';
        smpl_ns                 <= smpl_cs;

        case smpl_cs is

            -------------------------------------------------------------------
            when IDLE =>
                -- Running, no errors, and new length written,then execute
                -- transfer
                if( run_stop = '1' and xfer_length_wren = '1' and stop = '0'
                and cmnds_queued = '0') then
                    smpl_ns <= EXECUTE_XFER;
                else
                    cmnd_idle <= '1';
                end if;


            -------------------------------------------------------------------
            when EXECUTE_XFER =>
                -- error detected
                if(stop = '1')then
                    smpl_ns     <= IDLE;
                -- Write another command if there is not one already pending
                elsif(cmnd_pending = '0')then
                    write_cmnd_cmb  <= '1';
                    smpl_ns         <= WAIT_STATUS;
                else
                    smpl_ns         <= EXECUTE_XFER;
                end if;

            -------------------------------------------------------------------
            when WAIT_STATUS =>
                -- wait until desc update complete or error occurs
                if(sts_received = '1' or stop = '1')then
                    sts_received_clr_cmb <= '1';
                    smpl_ns              <= IDLE;
                else
                    smpl_ns <= WAIT_STATUS;
                end if;

            -------------------------------------------------------------------
--          coverage off
            when others =>
                smpl_ns <= IDLE;
--          coverage on

        end case;
    end process MM2S_MACHINE;

-------------------------------------------------------------------------------
-- register state machine states
-------------------------------------------------------------------------------
REGISTER_STATE : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0')then
                smpl_cs     <= IDLE;
            else
                smpl_cs     <= smpl_ns;
            end if;
        end if;
    end process REGISTER_STATE;

-- Register state machine signals
REGISTER_STATE_SIGS : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn ='0')then
                sts_received_clr    <= '0';
            else
                sts_received_clr    <= sts_received_clr_cmb;
            end if;
        end if;
    end process REGISTER_STATE_SIGS;

-------------------------------------------------------------------------------
-- Build DataMover command
-------------------------------------------------------------------------------
-- If Bytes To Transfer (BTT) width less than 23, need to add pad
GEN_CMD_BTT_LESS_23 : if C_SG_LENGTH_WIDTH < 23 generate
constant PAD_VALUE : std_logic_vector(22 - C_SG_LENGTH_WIDTH downto 0)
                        := (others => '0');
begin
    -- When command by sm, drive command to mm2s_cmdsts_if
    GEN_DATAMOVER_CMND : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    cmnd_wr_i       <= '0';
                    cmnd_data       <= (others => '0');

                -- SM issued a command write
                elsif(write_cmnd_cmb = '1')then
                    cmnd_wr_i       <= '1';
                    cmnd_data       <=  zeros
                                        & cmd_dumb 
                                        & CMD_RSVD
                                        -- Command Tag
                                        & '0'               -- Tag Not Used in Simple Mode
                                        & '0'               -- Tag Not Used in Simple Mode
                                        & '0'               -- Tag Not Used in Simple Mode
                                        & '0'               -- Tag Not Used in Simple Mode
                                        -- Command
                                        & xfer_address      -- Command Address
                                        & '1'               -- Command SOF
                                        & '1'               -- Command EOF
                                        & CMD_DSA           -- Stream Offset
                                        & burst_type  -- Key Hole Operation'1'               -- Not Used
                                        & PAD_VALUE
                                        & xfer_length;

                else
                    cmnd_wr_i       <= '0';

                end if;
            end if;
        end process GEN_DATAMOVER_CMND;

end generate GEN_CMD_BTT_LESS_23;

-- If Bytes To Transfer (BTT) width equal 23, no required pad
GEN_CMD_BTT_EQL_23 : if C_SG_LENGTH_WIDTH = 23 generate
begin
    -- When command by sm, drive command to mm2s_cmdsts_if
    GEN_DATAMOVER_CMND : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    cmnd_wr_i       <= '0';
                    cmnd_data       <= (others => '0');

                -- SM issued a command write
                elsif(write_cmnd_cmb = '1')then
                    cmnd_wr_i       <= '1';
                    cmnd_data       <=  zeros 
                                        & cmd_dumb
                                        & CMD_RSVD
                                        -- Command Tag
                                        & '0'                   -- Tag Not Used in Simple Mode
                                        & '0'                   -- Tag Not Used in Simple Mode
                                        & '0'                   -- Tag Not Used in Simple Mode
                                        & '0'                   -- Tag Not Used in Simple Mode
                                        -- Command
                                        & xfer_address          -- Command Address
                                        & '1'                   -- Command SOF
                                        & '1'                   -- Command EOF
                                        & CMD_DSA               -- Stream Offset
                                        & burst_type  -- key Hole Operation '1'                   -- Not Used
                                        & xfer_length;

                else
                    cmnd_wr_i       <= '0';

                end if;
            end if;
        end process GEN_DATAMOVER_CMND;

end generate GEN_CMD_BTT_EQL_23;


-------------------------------------------------------------------------------
-- Flag indicating command being processed by Datamover
-------------------------------------------------------------------------------

-- count number of queued commands to keep track of what datamover is still
-- working on
CMD2STS_COUNTER : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0' or stop = '1')then
                cmnds_queued <= '0';
            elsif(cmnd_wr_i = '1')then
                cmnds_queued <= '1';
            elsif(sts_received = '1')then
                cmnds_queued <= '0';
            end if;
        end if;
    end process CMD2STS_COUNTER;

-- Indicate status is idle when no cmnd/sts queued
sts_idle <= '1' when  cmnds_queued = '0'
       else '0';

end implementation;
