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
-- Filename:          axi_dma_s2mm_sm.vhd
-- Description: This entity contains the S2MM DMA Controller State Machine
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
entity  axi_dma_s2mm_sm is
    generic (
        C_M_AXI_S2MM_ADDR_WIDTH     : integer range 32 to 64    := 32;
            -- Master AXI Memory Map Address Width for S2MM Write Port

        C_SG_INCLUDE_STSCNTRL_STRM  : integer range 0 to 1      := 1;
            -- Include or Exclude AXI Status and AXI Control Streams
            -- 0 = Exclude Status and Control Streams
            -- 1 = Include Status and Control Streams

        C_SG_USE_STSAPP_LENGTH      : integer range 0 to 1      := 1;
            -- Enable or Disable use of Status Stream Rx Length.  Only valid
            -- if C_SG_INCLUDE_STSCNTRL_STRM = 1
            -- 0 = Don't use Rx Length
            -- 1 = Use Rx Length

        C_SG_LENGTH_WIDTH           : integer range 8 to 23     := 14;
            -- Width of Buffer Length, Transferred Bytes, and BTT fields

        C_SG_INCLUDE_DESC_QUEUE     : integer range 0 to 1      := 0;
            -- Include or Exclude Scatter Gather Descriptor Queuing
            -- 0 = Exclude SG Descriptor Queuing
            -- 1 = Include SG Descriptor Queuing
        C_ENABLE_MULTI_CHANNEL             : integer range 0 to 1 := 0;

        C_MICRO_DMA      : integer range 0 to 1 := 0;

        C_PRMY_CMDFIFO_DEPTH        : integer range 1 to 16     := 1
            -- Depth of DataMover command FIFO
    );
    port (
        m_axi_sg_aclk               : in  std_logic                         ;                   --
        m_axi_sg_aresetn            : in  std_logic                         ;                   --
                                                                                                --
        s2mm_stop                   : in  std_logic                         ;                   --
                                                                                                --
        -- S2MM Control and Status                                                              --
        s2mm_run_stop               : in  std_logic                         ;                   --
        s2mm_keyhole                : in  std_logic                         ;                   --
        s2mm_ftch_idle              : in  std_logic                         ;                   --
        s2mm_desc_flush             : in  std_logic                         ;                   --
        s2mm_cmnd_idle              : out std_logic                         ;                   --
        s2mm_sts_idle               : out std_logic                         ;                   --
        s2mm_eof_set                : out std_logic                         ;                   --
        s2mm_eof_micro              : in std_logic                         ;                   --
        s2mm_sof_micro              : in std_logic                         ;                   --
                                                                                                --
        -- S2MM Descriptor Fetch Request                                                        --
        desc_fetch_req              : out std_logic                         ;                   --
        desc_fetch_done             : in  std_logic                         ;                   --
        desc_update_done            : in  std_logic                         ;                   --
        updt_pending                : in  std_logic                         ;
        desc_available              : in  std_logic                         ;                   --
                                                                                                --
        -- S2MM Status Stream RX Length                                                         --
        s2mm_rxlength_valid         : in  std_logic                         ;                   --
        s2mm_rxlength_clr           : out std_logic                         ;                   --
        s2mm_rxlength               : in  std_logic_vector                                      --
                                        (C_SG_LENGTH_WIDTH - 1 downto 0)    ;                   --
                                                                                                --
        -- DataMover Command                                                                    --
        s2mm_cmnd_wr                : out std_logic                         ;                   --
        s2mm_cmnd_data              : out std_logic_vector                                      --
                                        ((C_M_AXI_S2MM_ADDR_WIDTH-32+2*32+CMD_BASE_WIDTH+46)-1 downto 0);  --
        s2mm_cmnd_pending           : in  std_logic                         ;                   --
                                                                                                --
        -- Descriptor Fields                                                                    --
        s2mm_desc_info          : in  std_logic_vector                                      --
                                        (31 downto 0);                   --
        s2mm_desc_baddress          : in  std_logic_vector                                      --
                                        (C_M_AXI_S2MM_ADDR_WIDTH-1 downto 0);                   --
        s2mm_desc_blength           : in  std_logic_vector                                      --
                                        (BUFFER_LENGTH_WIDTH-1 downto 0);                        --
        s2mm_desc_blength_v           : in  std_logic_vector                                      --
                                        (BUFFER_LENGTH_WIDTH-1 downto 0);                        --
        s2mm_desc_blength_s           : in  std_logic_vector                                      --
                                        (BUFFER_LENGTH_WIDTH-1 downto 0)                        --

    );

end axi_dma_s2mm_sm;

-------------------------------------------------------------------------------
-- Architecture
-------------------------------------------------------------------------------
architecture implementation of axi_dma_s2mm_sm is
  attribute DowngradeIPIdentifiedWarnings: string;
  attribute DowngradeIPIdentifiedWarnings of implementation : architecture is "yes";


-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------

-- No Functions Declared

-------------------------------------------------------------------------------
-- Constants Declarations
-------------------------------------------------------------------------------
-- DataMover Commmand TAG
constant S2MM_CMD_TAG       : std_logic_vector(2 downto 0)  := (others => '0');
-- DataMover Command Destination Stream Offset
constant S2MM_CMD_DSA       : std_logic_vector(5 downto 0)  := (others => '0');
-- DataMover Cmnd Reserved Bits
constant S2MM_CMD_RSVD      : std_logic_vector(
                                DATAMOVER_CMD_RSVMSB_BOFST + C_M_AXI_S2MM_ADDR_WIDTH downto
                                DATAMOVER_CMD_RSVLSB_BOFST + C_M_AXI_S2MM_ADDR_WIDTH)
                                := (others => '0');
-- Queued commands counter width
constant COUNTER_WIDTH      : integer := clog2(C_PRMY_CMDFIFO_DEPTH+1);

-- Queued commands zero count
constant ZERO_COUNT         : std_logic_vector(COUNTER_WIDTH - 1 downto 0)
                                := (others => '0');
-- Zero buffer length error - compare value
constant ZERO_LENGTH        : std_logic_vector(C_SG_LENGTH_WIDTH-1 downto 0)
                                := (others => '0');
constant ZERO_BUFFER        : std_logic_vector(BUFFER_LENGTH_WIDTH-1 downto 0)
                                := (others => '0');
-------------------------------------------------------------------------------
-- Signal / Type Declarations
-------------------------------------------------------------------------------
-- State Machine Signals
signal desc_fetch_req_cmb       : std_logic := '0';
signal write_cmnd_cmb           : std_logic := '0';
signal s2mm_rxlength_clr_cmb    : std_logic := '0';

signal rxlength                 : std_logic_vector(C_SG_LENGTH_WIDTH-1 downto 0) := (others => '0');
signal s2mm_rxlength_set        : std_logic := '0';
signal blength_grtr_rxlength    : std_logic := '0';
signal rxlength_fetched         : std_logic := '0';

signal cmnds_queued             : std_logic_vector(COUNTER_WIDTH - 1 downto 0) := (others => '0');
signal cmnds_queued_shift             : std_logic_vector(C_PRMY_CMDFIFO_DEPTH - 1 downto 0) := (others => '0');
signal count_incr               : std_logic := '0';
signal count_decr               : std_logic := '0';

signal desc_fetch_done_d1       : std_logic := '0';
signal zero_length_error        : std_logic := '0';
signal s2mm_eof_set_i           : std_logic := '0';

signal queue_more               : std_logic := '0';

signal burst_type               : std_logic;
signal eof_micro                : std_logic;

-------------------------------------------------------------------------------
-- Begin architecture logic
-------------------------------------------------------------------------------
begin

EN_MICRO_DMA : if C_MICRO_DMA = 1 generate
begin
 eof_micro <= s2mm_eof_micro;
end generate EN_MICRO_DMA;


NO_MICRO_DMA : if C_MICRO_DMA = 0 generate
begin
 eof_micro <= '0';
end generate NO_MICRO_DMA;

s2mm_eof_set <= s2mm_eof_set_i;

burst_type <= '1' and (not s2mm_keyhole);
-- A 0 s2mm_keyhole means incremental burst
-- a 1 s2mm_keyhole means fixed burst

-------------------------------------------------------------------------------
-- Not using rx length from status stream - (indeterminate length mode)
-------------------------------------------------------------------------------
GEN_SM_FOR_NO_LENGTH : if (C_SG_USE_STSAPP_LENGTH = 0 or C_SG_INCLUDE_STSCNTRL_STRM = 0 or C_ENABLE_MULTI_CHANNEL = 1) generate
type SG_S2MM_STATE_TYPE      is (
                                IDLE,
                                FETCH_DESCRIPTOR,
                           --     EXECUTE_XFER,
                                WAIT_STATUS
                                );

signal s2mm_cs                  : SG_S2MM_STATE_TYPE;
signal s2mm_ns                  : SG_S2MM_STATE_TYPE;


begin
    -- For no status stream or not using length in status app field then eof set is
    -- generated from datamover status (see axi_dma_s2mm_cmdsts_if.vhd)
    s2mm_eof_set_i        <= '0';

    -------------------------------------------------------------------------------
    -- S2MM Transfer State Machine
    -------------------------------------------------------------------------------
    S2MM_MACHINE : process(s2mm_cs,
                           s2mm_run_stop,
                           desc_available,
                           desc_fetch_done,
                           desc_update_done,
                           s2mm_cmnd_pending,
                           s2mm_stop,
                           s2mm_desc_flush,
                           updt_pending 
                        --   queue_more
                           )
        begin

            -- Default signal assignment
            desc_fetch_req_cmb      <= '0';
            write_cmnd_cmb          <= '0';
            s2mm_cmnd_idle          <= '0';
            s2mm_ns                 <= s2mm_cs;

            case s2mm_cs is

                -------------------------------------------------------------------
                when IDLE =>
                    -- fetch descriptor if desc available, not stopped and running
    --                if (updt_pending = '1') then
    --                      s2mm_ns <= WAIT_STATUS;
                    if(s2mm_run_stop = '1' and desc_available = '1'
                --    and s2mm_stop = '0' and queue_more = '1' and updt_pending = '0')then
                    and s2mm_stop = '0' and updt_pending = '0')then
                       if (C_SG_INCLUDE_DESC_QUEUE = 1) then
                          s2mm_ns <= FETCH_DESCRIPTOR;
                          desc_fetch_req_cmb  <= '1';
                       else
                          s2mm_ns <= WAIT_STATUS;
                          write_cmnd_cmb  <= '1';
                       end if;
                    else
                        s2mm_cmnd_idle <= '1';
                        s2mm_ns         <= IDLE;
                    end if;

                -------------------------------------------------------------------
                when FETCH_DESCRIPTOR =>
                    -- exit if error or descriptor flushed
                    if(s2mm_desc_flush = '1' or s2mm_stop = '1')then
                        s2mm_ns         <= IDLE;
                    -- wait until fetch complete then execute
               --     elsif(desc_fetch_done = '1')then
               --         desc_fetch_req_cmb  <= '0';
               --         s2mm_ns             <= EXECUTE_XFER;
                    elsif (s2mm_cmnd_pending = '0')then
                        desc_fetch_req_cmb  <= '0';
                        if (updt_pending = '0') then
                            if(C_SG_INCLUDE_DESC_QUEUE = 1)then
                              s2mm_ns         <= IDLE;
                              write_cmnd_cmb  <= '1';
                            else
--              coverage off
                               s2mm_ns         <= WAIT_STATUS;
--              coverage on
                            end if;
                        end if; 
                    else
                          s2mm_ns <= FETCH_DESCRIPTOR;
                    end if;

                -------------------------------------------------------------------
--                when EXECUTE_XFER =>
--                    -- if error exit
--                    if(s2mm_stop = '1')then
--                        s2mm_ns         <= IDLE;
--                    -- Write another command if there is not one already pending
--                    elsif(s2mm_cmnd_pending = '0')then
--                        if (updt_pending = '0') then
--                          write_cmnd_cmb  <= '1';
--                        end if;
--                        if(C_SG_INCLUDE_DESC_QUEUE = 1)then
--                            s2mm_ns         <= IDLE;
--                        else
--                            s2mm_ns         <= WAIT_STATUS;
--                        end if;
--                    else
--                        s2mm_ns <= EXECUTE_XFER;
--                    end if;

                -------------------------------------------------------------------
                when WAIT_STATUS =>
                    -- for no Q wait until desc updated
                    if(desc_update_done = '1' or s2mm_stop = '1')then
                        s2mm_ns <= IDLE;
                    else
                        s2mm_ns <= WAIT_STATUS;
                    end if;

                -------------------------------------------------------------------
--              coverage off
                when others =>
                    s2mm_ns <= IDLE;
--              coverage on

            end case;
        end process S2MM_MACHINE;

    -------------------------------------------------------------------------------
    -- Register State Machine Statues
    -------------------------------------------------------------------------------
    REGISTER_STATE : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    s2mm_cs     <= IDLE;
                else
                    s2mm_cs     <= s2mm_ns;
                end if;
            end if;
        end process REGISTER_STATE;

    -------------------------------------------------------------------------------
    -- Register State Machine Signalse
    -------------------------------------------------------------------------------
--    SM_SIG_REGISTER : process(m_axi_sg_aclk)
--        begin
--            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
--                if(m_axi_sg_aresetn = '0')then
--                    desc_fetch_req      <= '0'      ;
--                else
--                    if (C_SG_INCLUDE_DESC_QUEUE = 0) then
--                       desc_fetch_req      <= '1';
--                    else
--                       desc_fetch_req      <= desc_fetch_req_cmb   ;
--                    end if;
--                end if;
--            end if;
--        end process SM_SIG_REGISTER;
           desc_fetch_req <= '1' when (C_SG_INCLUDE_DESC_QUEUE = 0) else 
                             desc_fetch_req_cmb ;

    -------------------------------------------------------------------------------
    -- Build DataMover command
    -------------------------------------------------------------------------------
    -- If Bytes To Transfer (BTT) width less than 23, need to add pad
    GEN_CMD_BTT_LESS_23 : if C_SG_LENGTH_WIDTH < 23 generate
    constant PAD_VALUE : std_logic_vector(22 - C_SG_LENGTH_WIDTH downto 0)
                            := (others => '0');
    begin
        -- When command by sm, drive command to s2mm_cmdsts_if
        GEN_DATAMOVER_CMND : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0')then
                        s2mm_cmnd_wr    <= '0';
               --         s2mm_cmnd_data  <= (others => '0');

                    -- Fetch SM issued a command write
                    elsif(write_cmnd_cmb = '1')then
                        s2mm_cmnd_wr    <= '1';
               --         s2mm_cmnd_data  <=  s2mm_desc_info
               --                             & s2mm_desc_blength_v
               --                             & s2mm_desc_blength_s
               --                             & S2MM_CMD_RSVD
               --                             & "0000"  -- Cat IOC to CMD TAG
               --                             & s2mm_desc_baddress
               --                             & '1'           -- Always reset DRE
               --                             & '0'           -- For Indeterminate BTT mode do not set EOF
               --                             & S2MM_CMD_DSA
               --                             & burst_type  -- Key Hole '1'           -- s2mm_desc_type -- IR# 545697
               --                             & PAD_VALUE
               --                             & s2mm_desc_blength(C_SG_LENGTH_WIDTH-1 downto 0);
                    else
                        s2mm_cmnd_wr    <= '0';

                    end if;
                end if;
            end process GEN_DATAMOVER_CMND;

                        s2mm_cmnd_data  <=  s2mm_desc_info
                                            & s2mm_desc_blength_v
                                            & s2mm_desc_blength_s
                                            & S2MM_CMD_RSVD
                                            & "00" & eof_micro & eof_micro --00"  -- Cat IOC to CMD TAG
                                            & s2mm_desc_baddress
                                            & '1'           -- Always reset DRE
                                            & eof_micro --'0'           -- For Indeterminate BTT mode do not set EOF
                                            & S2MM_CMD_DSA
                                            & burst_type  -- Key Hole '1'           -- s2mm_desc_type -- IR# 545697
                                            & PAD_VALUE
                                            & s2mm_desc_blength(C_SG_LENGTH_WIDTH-1 downto 0);

    end generate GEN_CMD_BTT_LESS_23;

    -- If Bytes To Transfer (BTT) width equal 23, no required pad
    GEN_CMD_BTT_EQL_23 : if C_SG_LENGTH_WIDTH = 23 generate
    begin
        -- When command by sm, drive command to s2mm_cmdsts_if
        GEN_DATAMOVER_CMND : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0')then
                        s2mm_cmnd_wr    <= '0';
               --         s2mm_cmnd_data  <= (others => '0');

                    -- Fetch SM issued a command write
                    elsif(write_cmnd_cmb = '1')then
                        s2mm_cmnd_wr    <= '1';
               --         s2mm_cmnd_data  <=  s2mm_desc_info 
               --                             & s2mm_desc_blength_v
               --                             & s2mm_desc_blength_s 
               --                             & S2MM_CMD_RSVD
               --                             & "0000"  -- Cat IOC to CMD TAG
               --                             & s2mm_desc_baddress
               --                             & '1'           -- Always reset DRE
               --                             & '0'           -- For indeterminate BTT mode do not set EOF
               --                             & S2MM_CMD_DSA
               --                             & burst_type -- Key Hole '1'           -- s2mm_desc_type -- IR# 545697
               --                             & s2mm_desc_blength;

                    else
                        s2mm_cmnd_wr    <= '0';

                    end if;
                end if;
            end process GEN_DATAMOVER_CMND;

                        s2mm_cmnd_data  <=  s2mm_desc_info 
                                            & s2mm_desc_blength_v
                                            & s2mm_desc_blength_s 
                                            & S2MM_CMD_RSVD
                                            & "00" & eof_micro & eof_micro -- "0000"  -- Cat IOC to CMD TAG
                                            & s2mm_desc_baddress
                                            & '1'           -- Always reset DRE
                                            & eof_micro           -- For indeterminate BTT mode do not set EOF
                                            & S2MM_CMD_DSA
                                            & burst_type -- Key Hole '1'           -- s2mm_desc_type -- IR# 545697
                                            & s2mm_desc_blength;

    end generate GEN_CMD_BTT_EQL_23;



    -- Drive unused output to zero
    s2mm_rxlength_clr   <= '0';

end generate GEN_SM_FOR_NO_LENGTH;



-------------------------------------------------------------------------------
-- Generate state machine and support logic for Using RX Length from Status
-- Stream
-------------------------------------------------------------------------------
-- this would not hold good for MCDMA
GEN_SM_FOR_LENGTH : if (C_SG_USE_STSAPP_LENGTH = 1 and C_SG_INCLUDE_STSCNTRL_STRM = 1 and C_ENABLE_MULTI_CHANNEL = 0) generate
type SG_S2MM_STATE_TYPE      is (
                                IDLE,
                                FETCH_DESCRIPTOR,
                                GET_RXLENGTH,
                                CMPR_LENGTH,
                                EXECUTE_XFER,
                                WAIT_STATUS
                                );

signal s2mm_cs                  : SG_S2MM_STATE_TYPE;
signal s2mm_ns                  : SG_S2MM_STATE_TYPE;

begin

    -------------------------------------------------------------------------------
    -- S2MM Transfer State Machine
    -------------------------------------------------------------------------------
    S2MM_MACHINE : process(s2mm_cs,
                           s2mm_run_stop,
                           desc_available,
                           desc_update_done,
                       --    desc_fetch_done,
                           updt_pending,
                           s2mm_rxlength_valid,
                           rxlength_fetched,
                           s2mm_cmnd_pending,
                           zero_length_error,
                           s2mm_stop,
                           s2mm_desc_flush
                        --   queue_more
                           )
        begin

            -- Default signal assignment
            desc_fetch_req_cmb      <= '0';
            s2mm_rxlength_clr_cmb   <= '0';
            write_cmnd_cmb          <= '0';
            s2mm_cmnd_idle          <= '0';
            s2mm_rxlength_set       <= '0';
            --rxlength_fetched_clr    <= '0';
            s2mm_ns                 <= s2mm_cs;

            case s2mm_cs is

                -------------------------------------------------------------------
                when IDLE =>
                    if(s2mm_run_stop = '1' and desc_available = '1'
                 --   and s2mm_stop = '0' and queue_more = '1' and updt_pending = '0')then
                    and s2mm_stop = '0' and updt_pending = '0')then
                      if (C_SG_INCLUDE_DESC_QUEUE = 0) then
                        if(rxlength_fetched = '0')then
                            s2mm_ns             <= GET_RXLENGTH;
                        else
                            s2mm_ns             <= CMPR_LENGTH;
                        end if;
                      else  
                        s2mm_ns <= FETCH_DESCRIPTOR;
                        desc_fetch_req_cmb  <= '1';
                      end if;
                    else
                        s2mm_cmnd_idle <= '1';
                        s2mm_ns <= IDLE; --FETCH_DESCRIPTOR;
                    end if;

                -------------------------------------------------------------------
                when FETCH_DESCRIPTOR =>
                        desc_fetch_req_cmb  <= '0';
                    -- exit if error or descriptor flushed
                    if(s2mm_desc_flush = '1')then
                        s2mm_ns         <= IDLE;
                    -- Descriptor fetch complete
                    else --if(desc_fetch_done = '1')then
                   --     desc_fetch_req_cmb  <= '0';
                        if(rxlength_fetched = '0')then
                            s2mm_ns             <= GET_RXLENGTH;
                        else
                            s2mm_ns             <= CMPR_LENGTH;
                        end if;

                  --  else
                    --    desc_fetch_req_cmb  <= '1';
                    end if;

                -------------------------------------------------------------------
                WHEN GET_RXLENGTH =>
                    if(s2mm_stop = '1')then
                        s2mm_ns         <= IDLE;
                    -- Buffer length zero, do not compare lengths, execute
                    -- command to force datamover to issue interror
                    elsif(zero_length_error = '1')then
                        s2mm_ns                 <= EXECUTE_XFER;
                    elsif(s2mm_rxlength_valid = '1')then
                        s2mm_rxlength_set       <= '1';
                        s2mm_rxlength_clr_cmb   <= '1';
                        s2mm_ns                 <= CMPR_LENGTH;
                    else
                        s2mm_ns <= GET_RXLENGTH;
                    end if;

                -------------------------------------------------------------------
                WHEN CMPR_LENGTH    =>
                        s2mm_ns                 <= EXECUTE_XFER;

                -------------------------------------------------------------------
                when EXECUTE_XFER =>
                    if(s2mm_stop = '1')then
                        s2mm_ns         <= IDLE;
                    -- write new command if one is not already pending
                    elsif(s2mm_cmnd_pending = '0')then
                        write_cmnd_cmb  <= '1';

                        -- If descriptor queuing enabled then
                        -- do NOT need to wait for status
                        if(C_SG_INCLUDE_DESC_QUEUE = 1)then
                            s2mm_ns         <= IDLE;

                        -- No queuing therefore must wait for
                        -- status before issuing next command
                        else
                            s2mm_ns         <= WAIT_STATUS;
                        end if;
                    else
                            s2mm_ns         <= EXECUTE_XFER;
                    end if;
                -------------------------------------------------------------------
--              coverage off
                when WAIT_STATUS =>
                    if(desc_update_done = '1' or s2mm_stop = '1')then
                        s2mm_ns <= IDLE;
                    else
                        s2mm_ns <= WAIT_STATUS;
                    end if;
--              coverage on

                -------------------------------------------------------------------
--              coverage off
                when others =>
                    s2mm_ns <= IDLE;
--              coverage on

            end case;
        end process S2MM_MACHINE;

    -------------------------------------------------------------------------------
    -- Register state machine states
    -------------------------------------------------------------------------------
    REGISTER_STATE : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    s2mm_cs     <= IDLE;
                else
                    s2mm_cs     <= s2mm_ns;
                end if;
            end if;
        end process REGISTER_STATE;

    -------------------------------------------------------------------------------
    -- Register state machine signals
    -------------------------------------------------------------------------------
    SM_SIG_REGISTER : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    desc_fetch_req      <= '0'      ;
                    s2mm_rxlength_clr   <= '0'      ;
                else
                    if (C_SG_INCLUDE_DESC_QUEUE = 0) then
                       desc_fetch_req      <= '1';
                    else
                       desc_fetch_req      <= desc_fetch_req_cmb   ;
                    end if;
                    s2mm_rxlength_clr   <= s2mm_rxlength_clr_cmb;
                end if;
            end if;
        end process SM_SIG_REGISTER;


    -------------------------------------------------------------------------------
    -- Check for a ZERO value in descriptor buffer length.  If there is
    -- then flag an error and skip waiting for valid rxlength.  cmnd will
    -- get written to datamover with BTT=0 and datamover will flag dmaint error
    -- which will be logged in desc, reset required to clear error
    -------------------------------------------------------------------------------
    REG_ALIGN_DONE : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    desc_fetch_done_d1 <= '0';
                else
                    desc_fetch_done_d1 <= desc_fetch_done;
                end if;
            end if;
        end process REG_ALIGN_DONE;



    -------------------------------------------------------------------------------
    -- Zero length error detection - for determinate mode, detect early to prevent
    -- rxlength calcuation from first taking place.  This will force a 0 BTT
    -- command to be issued to the datamover causing an internal error.
    -------------------------------------------------------------------------------
    REG_ZERO_LNGTH_ERR : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    zero_length_error <= '0';
                elsif(desc_fetch_done_d1 = '1'
                and s2mm_desc_blength(C_SG_LENGTH_WIDTH-1 downto 0) = ZERO_LENGTH)then
                    zero_length_error <= '1';
                end if;
            end if;
        end process REG_ZERO_LNGTH_ERR;


    -------------------------------------------------------------------------------
    -- Capture/Hold receive length from status stream.  Also decrement length
    -- based on if received length is greater than descriptor buffer size. (i.e. is
    -- the case where multiple descriptors/buffers are used to describe one packet)
    -------------------------------------------------------------------------------
    REG_RXLENGTH : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    rxlength            <= (others => '0');
                -- If command register rxlength from status stream fifo
                elsif(s2mm_rxlength_set = '1')then
                    rxlength            <= s2mm_rxlength;

                -- On command write if current desc buffer size not greater
                -- than current rxlength then decrement rxlength in preperations
                -- for subsequent commands
                elsif(write_cmnd_cmb = '1' and blength_grtr_rxlength = '0')then

                    rxlength <= std_logic_vector(unsigned(rxlength(C_SG_LENGTH_WIDTH-1 downto 0))
                                               - unsigned(s2mm_desc_blength(C_SG_LENGTH_WIDTH-1 downto 0)));

                end if;
            end if;
        end process REG_RXLENGTH;

    -------------------------------------------------------------------------------
    -- Calculate if Descriptor Buffer Length is 'Greater Than' or 'Equal To'
    -- Received Length value
    -------------------------------------------------------------------------------
    REG_BLENGTH_GRTR_RXLNGTH : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    blength_grtr_rxlength <= '0';
                elsif(s2mm_desc_blength(C_SG_LENGTH_WIDTH-1 downto 0) >= rxlength)then
                    blength_grtr_rxlength <= '1';
                else
                    blength_grtr_rxlength <= '0';
                end if;
            end if;
        end process REG_BLENGTH_GRTR_RXLNGTH;

    -------------------------------------------------------------------------------
    -- On command assert rxlength fetched flag indicating length grabbed from
    -- status stream fifo
    -------------------------------------------------------------------------------
    RXLENGTH_FTCHED_PROCESS : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0' or s2mm_eof_set_i = '1')then
                    rxlength_fetched    <= '0';
                elsif(s2mm_rxlength_set = '1')then
                    rxlength_fetched    <= '1';
                end if;
             end if;
         end process RXLENGTH_FTCHED_PROCESS;

    -------------------------------------------------------------------------------
    -- Build DataMover command
    -------------------------------------------------------------------------------
    -- If Bytes To Transfer (BTT) width less than 23, need to add pad
    GEN_CMD_BTT_LESS_23 : if C_SG_LENGTH_WIDTH < 23 generate
    constant PAD_VALUE : std_logic_vector(22 - C_SG_LENGTH_WIDTH downto 0)
                            := (others => '0');
    begin
        -- When command by sm, drive command to s2mm_cmdsts_if
        GEN_DATAMOVER_CMND : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0')then
                        s2mm_cmnd_wr    <= '0';
                        s2mm_cmnd_data  <= (others => '0');
                        s2mm_eof_set_i  <= '0';

                    -- Current Desc Buffer will NOT hold entire rxlength of data therefore
                    -- set EOF = based on Desc.EOF and pass buffer length for BTT
                    elsif(write_cmnd_cmb = '1' and blength_grtr_rxlength = '0')then
                        s2mm_cmnd_wr    <= '1';
                        s2mm_cmnd_data  <=  s2mm_desc_info
                                            & ZERO_BUFFER
                                            & ZERO_BUFFER
                                            & S2MM_CMD_RSVD
                                            -- Command Tag
                                            & '0'
                                            & '0'
                                            & '0'  -- Cat. EOF=0 to CMD Tag
                                            & '0'  -- Cat. IOC to CMD TAG
                                            -- Command
                                            & s2mm_desc_baddress
                                            & '1'           -- Always reset DRE
                                            & '0'           -- Not End of Frame
                                            & S2MM_CMD_DSA
                                            & burst_type -- Key Hole '1'           -- s2mm_desc_type -- IR# 545697
                                            & PAD_VALUE
                                            & s2mm_desc_blength(C_SG_LENGTH_WIDTH-1 downto 0);
                        s2mm_eof_set_i  <= '0';


                    -- Current Desc Buffer will hold entire rxlength of data therefore
                    -- set EOF = 1 and pass rxlength for BTT
                    --
                    -- Note: change to mode where EOF generates IOC interrupt as
                    -- opposed to a IOC bit in the descriptor negated need for an
                    -- EOF and IOC tag.  Given time, these two bits could be combined
                    -- into 1.  Associated logic in SG engine would also need to be
                    -- modified as well as in s2mm_sg_if.
                    elsif(write_cmnd_cmb = '1' and blength_grtr_rxlength = '1')then
                        s2mm_cmnd_wr    <= '1';
                        s2mm_cmnd_data  <=  s2mm_desc_info
                                            & ZERO_BUFFER
                                            & ZERO_BUFFER
                                            & S2MM_CMD_RSVD
                                            -- Command Tag
                                            & '0'
                                            & '0'
                                            & '1'  -- Cat. EOF=1 to CMD Tag
                                            & '1'  -- Cat. IOC to CMD TAG
                                            -- Command
                                            & s2mm_desc_baddress
                                            & '1'           -- Always reset DRE
                                            & '1'           -- Set EOF=1
                                            & S2MM_CMD_DSA
                                            & burst_type -- Key Hole '1'           -- s2mm_desc_type -- IR# 545697
                                            & PAD_VALUE
                                            & rxlength;
                        s2mm_eof_set_i    <= '1';

                    else
                 --       s2mm_cmnd_data  <= (others => '0');
                        s2mm_cmnd_wr    <= '0';
                        s2mm_eof_set_i  <= '0';

                    end if;
                end if;
            end process GEN_DATAMOVER_CMND;

    end generate GEN_CMD_BTT_LESS_23;

    -- If Bytes To Transfer (BTT) width equal 23, no required pad
    GEN_CMD_BTT_EQL_23 : if C_SG_LENGTH_WIDTH = 23 generate
    begin
        -- When command by sm, drive command to s2mm_cmdsts_if
        GEN_DATAMOVER_CMND : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0')then
                        s2mm_cmnd_wr    <= '0';
                        s2mm_cmnd_data  <= (others => '0');
                        s2mm_eof_set_i    <= '0';
                    -- Current Desc Buffer will NOT hold entire rxlength of data therefore
                    -- set EOF = based on Desc.EOF and pass buffer length for BTT
                    elsif(write_cmnd_cmb = '1' and blength_grtr_rxlength = '0')then
                        s2mm_cmnd_wr    <= '1';
                        s2mm_cmnd_data  <=  s2mm_desc_info
                                            & ZERO_BUFFER
                                            & ZERO_BUFFER
                                            & S2MM_CMD_RSVD
                                            --& S2MM_CMD_TAG & s2mm_desc_ioc  -- Cat IOC to CMD TAG
                                            -- Command Tag
                                            & '0'
                                            & '0'
                                            & '0'  -- Cat. EOF='0' to CMD Tag
                                            & '0'  -- Cat. IOC='0' to CMD TAG
                                            -- Command
                                            & s2mm_desc_baddress
                                            & '1'           -- Always reset DRE
                                            & '0'           -- Not End of Frame
                                            & S2MM_CMD_DSA
                                            & burst_type    -- Key Hole '1' -- s2mm_desc_type -- IR# 545697
                                            & s2mm_desc_blength;

                        s2mm_eof_set_i    <= '0';

                    -- Current Desc Buffer will hold entire rxlength of data therefore
                    -- set EOF = 1 and pass rxlength for BTT
                    --
                    -- Note: change to mode where EOF generates IOC interrupt as
                    -- opposed to a IOC bit in the descriptor negated need for an
                    -- EOF and IOC tag.  Given time, these two bits could be combined
                    -- into 1.  Associated logic in SG engine would also need to be
                    -- modified as well as in s2mm_sg_if.
                    elsif(write_cmnd_cmb = '1' and blength_grtr_rxlength = '1')then
                        s2mm_cmnd_wr    <= '1';
                        s2mm_cmnd_data  <=  s2mm_desc_info
                                            & ZERO_BUFFER
                                            & ZERO_BUFFER
                                            & S2MM_CMD_RSVD
                                            --& S2MM_CMD_TAG & s2mm_desc_ioc  -- Cat IOC to CMD TAG
                                            -- Command Tag
                                            & '0'
                                            & '0'
                                            & '1'  -- Cat. EOF='1' to CMD Tag
                                            & '1'  -- Cat. IOC='1' to CMD TAG
                                            -- Command
                                            & s2mm_desc_baddress
                                            & '1'           -- Always reset DRE
                                            & '1'           -- End of Frame
                                            & S2MM_CMD_DSA
                                            & burst_type    -- Key Hole '1' -- s2mm_desc_type -- IR# 545697
                                            & rxlength;
                        s2mm_eof_set_i    <= '1';
                    else
                  --      s2mm_cmnd_data  <= (others => '0');
                        s2mm_cmnd_wr    <= '0';
                        s2mm_eof_set_i    <= '0';

                    end if;
                end if;
            end process GEN_DATAMOVER_CMND;

    end generate GEN_CMD_BTT_EQL_23;

end generate GEN_SM_FOR_LENGTH;


-------------------------------------------------------------------------------
-- Counter for keepting track of pending commands/status in primary datamover
-- Use this to determine if primary datamover for s2mm is Idle.
-------------------------------------------------------------------------------
-- Increment queue count for each command written if not occuring at
-- same time a status from DM being updated to SG engine
count_incr  <= '1' when write_cmnd_cmb = '1' and desc_update_done = '0'
          else '0';

-- Decrement queue count for each status update to SG engine if not occuring
-- at same time as command being written to DM
count_decr  <= '1' when write_cmnd_cmb = '0' and desc_update_done = '1'
          else '0';

-- keep track of number queue commands
--CMD2STS_COUNTER : process(m_axi_sg_aclk)
--    begin
--        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
--            if(m_axi_sg_aresetn = '0' or s2mm_stop = '1')then
--                cmnds_queued <= (others => '0');
--            elsif(count_incr = '1')then
--                cmnds_queued <= std_logic_vector(unsigned(cmnds_queued(COUNTER_WIDTH - 1 downto 0)) + 1);
--            elsif(count_decr = '1')then
--                cmnds_queued <= std_logic_vector(unsigned(cmnds_queued(COUNTER_WIDTH - 1 downto 0)) - 1);
--            end if;
--        end if;
--    end process CMD2STS_COUNTER;

QUEUE_COUNT : if C_SG_INCLUDE_DESC_QUEUE = 1 generate
begin

CMD2STS_COUNTER1 : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0' or s2mm_stop = '1')then
                cmnds_queued_shift <= (others => '0');
            elsif(count_incr = '1')then
                cmnds_queued_shift <= cmnds_queued_shift (2 downto 0) & '1';
            elsif(count_decr = '1')then
                cmnds_queued_shift <= '0' & cmnds_queued_shift (3 downto 1);
            end if;
        end if;
    end process CMD2STS_COUNTER1;

end generate QUEUE_COUNT;


NOQUEUE_COUNT : if C_SG_INCLUDE_DESC_QUEUE = 0 generate
begin

CMD2STS_COUNTER1 : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0' or s2mm_stop = '1')then
                cmnds_queued_shift (0) <= '0';
            elsif(count_incr = '1')then
                cmnds_queued_shift (0) <= '1';
            elsif(count_decr = '1')then
                cmnds_queued_shift (0) <= '0';
            end if;
        end if;
    end process CMD2STS_COUNTER1;

end generate NOQUEUE_COUNT;

-- indicate idle when no more queued commands
--s2mm_sts_idle <= '1' when  cmnds_queued_shift = "0000"
--            else '0';

s2mm_sts_idle <= not cmnds_queued_shift(0);

-------------------------------------------------------------------------------
-- Queue only the amount of commands that can be queued on descriptor update
-- else lock up can occur. Note datamover command fifo depth is set to number
-- of descriptors to queue.
-------------------------------------------------------------------------------
--QUEUE_MORE_PROCESS : process(m_axi_sg_aclk)
--    begin
--        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
--            if(m_axi_sg_aresetn = '0')then
--                queue_more <= '0';
--            elsif(cmnds_queued < std_logic_vector(to_unsigned(C_PRMY_CMDFIFO_DEPTH,COUNTER_WIDTH)))then
--                queue_more <= '1';
--            else
--                queue_more <= '0';
--            end if;
--        end if;
--    end process QUEUE_MORE_PROCESS;

QUEUE_MORE_PROCESS : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0')then
                queue_more <= '0';
 --           elsif(cmnds_queued < std_logic_vector(to_unsigned(C_PRMY_CMDFIFO_DEPTH,COUNTER_WIDTH)))then
 --               queue_more <= '1';
            else
                queue_more <= not (cmnds_queued_shift (C_PRMY_CMDFIFO_DEPTH-1)); --'0';
            end if;
        end if;
    end process QUEUE_MORE_PROCESS;


end implementation;
