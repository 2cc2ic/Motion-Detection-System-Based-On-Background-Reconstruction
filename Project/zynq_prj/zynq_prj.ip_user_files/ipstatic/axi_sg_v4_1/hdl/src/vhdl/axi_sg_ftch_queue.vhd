-- *************************************************************************
--
--  (c) Copyright 2010-2011 Xilinx, Inc. All rights reserved.
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
--
-- *************************************************************************
--
-------------------------------------------------------------------------------
-- Filename:          axi_sg_ftch_queue.vhd
-- Description: This entity is the descriptor fetch queue interface
--
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;

library axi_sg_v4_1_2;
use axi_sg_v4_1_2.axi_sg_pkg.all;
--use axi_sg_v4_1_2.axi_sg_afifo_autord.all;

library lib_fifo_v1_0_4;
use lib_fifo_v1_0_4.sync_fifo_fg;
library lib_pkg_v1_0_2;
use lib_pkg_v1_0_2.lib_pkg.all;

-------------------------------------------------------------------------------
entity  axi_sg_ftch_queue is
    generic (
        C_M_AXI_SG_ADDR_WIDTH       : integer range 32 to 64    := 32;
            -- Master AXI Memory Map Address Width

        C_M_AXIS_SG_TDATA_WIDTH     : integer range 32 to 32    := 32;
            -- Master AXI Stream Data width

        C_SG_FTCH_DESC2QUEUE        : integer range 0 to 8      := 0;
            -- Number of descriptors to fetch and queue for each channel.
            -- A value of zero excludes the fetch queues.

        C_SG_WORDS_TO_FETCH         : integer range 4 to 16     := 8;
            -- Number of words to fetch for channel 1
        C_SG2_WORDS_TO_FETCH         : integer range 4 to 16     := 8;
            -- Number of words to fetch for channel 1

        C_ENABLE_MULTI_CHANNEL      : integer range 0 to 1      := 0; 

        C_INCLUDE_MM2S              : integer range 0 to 1      := 0;
        C_INCLUDE_S2MM              : integer range 0 to 1      := 0;
        C_ENABLE_CDMA               : integer range 0 to 1      := 0;

        C_AXIS_IS_ASYNC             : integer range 0 to 1      := 0;
        C_ASYNC             : integer range 0 to 1      := 0;
            -- Channel 1 is async to sg_aclk
            -- 0 = Synchronous to SG ACLK
            -- 1 = Asynchronous to SG ACLK

        C_FAMILY                    : string            := "virtex7"
            -- Device family used for proper BRAM selection
    );
    port (
        -----------------------------------------------------------------------
        -- AXI Scatter Gather Interface
        -----------------------------------------------------------------------
        m_axi_sg_aclk               : in  std_logic                         ;                   --
        m_axi_primary_aclk          : in  std_logic                         ;
        m_axi_sg_aresetn            : in  std_logic                         ;                   --
        p_reset_n                   : in  std_logic                         ;
 
        ch2_sg_idle                 : in std_logic                          ;              

        -- Channel Control                                                                    --
        desc1_flush                  : in  std_logic                         ;                   --
        ch1_cntrl_strm_stop          : in  std_logic                         ;
        desc2_flush                  : in  std_logic                         ;                   --
        ftch1_active                 : in  std_logic                         ;                   --
        ftch2_active                 : in  std_logic                         ;                   --
        ftch1_queue_empty            : out std_logic                         ;                   --
        ftch2_queue_empty            : out std_logic                         ;                   --
        ftch1_queue_full             : out std_logic                         ;                   --
        ftch2_queue_full             : out std_logic                         ;                   --
        ftch1_pause                  : out std_logic                         ;                   --
        ftch2_pause                  : out std_logic                         ;                   --
                                                                                                --
        writing_nxtdesc_in          : in  std_logic                         ;                   --
        writing1_curdesc_out         : out std_logic                         ;                   --
        writing2_curdesc_out         : out std_logic                         ;                   --
                                                                                                --
        -- DataMover Command                                                                    --
        ftch_cmnd_wr                : in  std_logic                         ;                   --
        ftch_cmnd_data              : in  std_logic_vector                                      --
                                        ((C_M_AXI_SG_ADDR_WIDTH+CMD_BASE_WIDTH)-1 downto 0);    --
                                                                                                --
        -- MM2S Stream In from DataMover                                                        --
        m_axis_mm2s_tdata           : in  std_logic_vector                                      --
                                        (C_M_AXIS_SG_TDATA_WIDTH-1 downto 0) ;                  --
        m_axis_mm2s_tlast           : in  std_logic                         ;                   --
        m_axis_mm2s_tvalid          : in  std_logic                         ;                   --
        sof_ftch_desc               : in  std_logic                         ;
        m_axis1_mm2s_tready          : out std_logic                         ;                   --
        m_axis2_mm2s_tready          : out std_logic                         ;                   --
                                                                                                --
        data_concat_64           : in  std_logic_vector                                      --
                                        (31 downto 0) ;                  --
        data_concat_64_cdma           : in  std_logic_vector                                      --
                                        (31 downto 0) ;                  --
        data_concat           : in  std_logic_vector                                      --
                                        (95 downto 0) ;                  --
        data_concat_mcdma           : in  std_logic_vector                                      --
                                        (63 downto 0) ;                  --
        data_concat_tlast           : in  std_logic                         ;                   --
        next_bd                     : in std_logic_vector (C_M_AXI_SG_ADDR_WIDTH-1 downto 0);
        data_concat_valid          : in  std_logic                         ;                   --
                                                                                                --
        -- Channel 1 AXI Fetch Stream Out                                                       --
        m_axis_ftch_aclk            : in  std_logic                         ;                   --
        m_axis_ftch1_tdata           : out std_logic_vector                                      --
                                        (C_M_AXIS_SG_TDATA_WIDTH-1 downto 0);                   --
        m_axis_ftch1_tvalid          : out std_logic                         ;                   --
        m_axis_ftch1_tready          : in  std_logic                         ;                   --
        m_axis_ftch1_tlast           : out std_logic                         ;                    --

        m_axis_ftch1_tdata_new           : out std_logic_vector                                      --
                                        (96+31*C_ENABLE_CDMA+(2+C_ENABLE_CDMA)*(C_M_AXI_SG_ADDR_WIDTH-32) downto 0);                   --
        m_axis_ftch1_tdata_mcdma_new           : out std_logic_vector                                      --
                                        (63 downto 0);                   --
        m_axis_ftch1_tvalid_new          : out std_logic                         ;                   --
        m_axis_ftch1_desc_available            : out std_logic                     ;

        m_axis_ftch2_tdata           : out std_logic_vector                                      --
                                        (C_M_AXIS_SG_TDATA_WIDTH-1 downto 0);                   --
        m_axis_ftch2_tvalid          : out std_logic                         ;                   --

        m_axis_ftch2_tdata_new           : out std_logic_vector                                      --
                                        (96+31*C_ENABLE_CDMA+(2+C_ENABLE_CDMA)*(C_M_AXI_SG_ADDR_WIDTH-32) downto 0);                   --
        m_axis_ftch2_tdata_mcdma_new           : out std_logic_vector                                      --
                                        (63 downto 0);                   --
        m_axis_ftch2_tvalid_new          : out std_logic                         ;                   --
        m_axis_ftch2_desc_available            : out std_logic                     ;
        m_axis_ftch2_tready          : in  std_logic                         ;                   --
        m_axis_ftch2_tlast           : out std_logic                         ;                    --

        m_axis_mm2s_cntrl_tdata     : out std_logic_vector                                 --
                                        (31 downto 0);      --
        m_axis_mm2s_cntrl_tkeep     : out std_logic_vector                                 --
                                        (3 downto 0);  --
        m_axis_mm2s_cntrl_tvalid    : out std_logic                         ;              --
        m_axis_mm2s_cntrl_tready    : in  std_logic                         := '0';              --
        m_axis_mm2s_cntrl_tlast     : out std_logic                                       --

    );

end axi_sg_ftch_queue;

-------------------------------------------------------------------------------
-- Architecture
-------------------------------------------------------------------------------
architecture implementation of axi_sg_ftch_queue is
  attribute DowngradeIPIdentifiedWarnings: string;
  attribute DowngradeIPIdentifiedWarnings of implementation : architecture is "yes";



-- Number of words deep fifo needs to be
-- 6 is subtracted as BD address are always 16 word aligned

constant FIFO_WIDTH : integer := (128*C_ENABLE_CDMA + 97*(1-C_ENABLE_CDMA) -6);
constant C_SG_WORDS_TO_FETCH1 : integer := C_SG_WORDS_TO_FETCH + 2*C_ENABLE_MULTI_CHANNEL;
--constant    FETCH_QUEUE_DEPTH       : integer := max2(16,pad_power2(C_SG_FTCH_DESC2QUEUE
--                                                                  * C_SG_WORDS_TO_FETCH1));
constant    FETCH_QUEUE_DEPTH       : integer := 16;

-- Select between BRAM or Logic Memory Type
constant    MEMORY_TYPE : integer := bo2int(C_SG_FTCH_DESC2QUEUE
                                    * C_SG_WORDS_TO_FETCH1 > 16);

constant    FETCH_QUEUE_CNT_WIDTH   : integer   := clog2(FETCH_QUEUE_DEPTH+1);

constant DCNT_LO_INDEX              : integer :=  max2(1,clog2(C_SG_WORDS_TO_FETCH1)) - 1;

constant DCNT_HI_INDEX              : integer :=  FETCH_QUEUE_CNT_WIDTH-1;                          --  CR616461


constant C_SG2_WORDS_TO_FETCH1 : integer := C_SG2_WORDS_TO_FETCH;

constant    FETCH2_QUEUE_DEPTH       : integer := max2(16,pad_power2(C_SG_FTCH_DESC2QUEUE
                                                                  * C_SG2_WORDS_TO_FETCH1));
-- Select between BRAM or Logic Memory Type
constant    MEMORY2_TYPE : integer := bo2int(C_SG_FTCH_DESC2QUEUE
                                    * C_SG2_WORDS_TO_FETCH1 > 16);
constant    FETCH2_QUEUE_CNT_WIDTH   : integer   := clog2(FETCH2_QUEUE_DEPTH+1);
constant DCNT2_LO_INDEX              : integer :=  max2(1,clog2(C_SG2_WORDS_TO_FETCH1)) - 1;
constant DCNT2_HI_INDEX              : integer :=  FETCH2_QUEUE_CNT_WIDTH-1;                          --  CR616461


-- Width of fifo rd and wr counts - only used for proper fifo operation


constant DESC2QUEUE_VECT_WIDTH      : integer := 4;
--constant SG_FTCH_DESC2QUEUE_VECT    : std_logic_vector(DESC2QUEUE_VECT_WIDTH-1 downto 0)
--                                        := std_logic_vector(to_unsigned(C_SG_FTCH_DESC2QUEUE,DESC2QUEUE_VECT_WIDTH)); --  CR616461
constant SG_FTCH_DESC2QUEUE_VECT    : std_logic_vector(DESC2QUEUE_VECT_WIDTH-1 downto 0)
                                        := std_logic_vector(to_unsigned(C_SG_FTCH_DESC2QUEUE,DESC2QUEUE_VECT_WIDTH));   --  CR616461

--constant DCNT_HI_INDEX              : integer :=  (DCNT_LO_INDEX + DESC2QUEUE_VECT_WIDTH) - 1;    --  CR616461


constant ZERO_COUNT                 : std_logic_vector(FETCH_QUEUE_CNT_WIDTH-1 downto 0) := (others => '0');
constant ZERO_COUNT1                 : std_logic_vector(FETCH2_QUEUE_CNT_WIDTH-1 downto 0) := (others => '0');

-------------------------------------------------------------------------------
-- Signal / Type Declarations
-------------------------------------------------------------------------------
-- Internal signals
signal curdesc_tdata            : std_logic_vector
                                    (C_M_AXIS_SG_TDATA_WIDTH-1 downto 0) := (others => '0');
signal curdesc_tvalid           : std_logic := '0';
signal ftch_tvalid              : std_logic := '0';
signal ftch_tvalid_new         : std_logic := '0';
signal ftch_tdata               : std_logic_vector
                                    (31 downto 0) := (others => '0');
signal ftch_tdata_new, reg1, reg2               : std_logic_vector
                                    (FIFO_WIDTH-1 downto 0) := (others => '0');

signal ftch_tdata_new_64, reg1_64, reg2_64 : std_logic_vector ((1+C_ENABLE_CDMA)*(C_M_AXI_SG_ADDR_WIDTH-32) -1 downto 0) := (others => '0');
signal ftch_tdata_new_bd, reg2_bd_64, reg1_bd_64 : std_logic_vector (31 downto 0) := (others => '0');

signal ftch_tlast               : std_logic := '0';
signal ftch_tlast_new               : std_logic := '0';
signal ftch_tready              : std_logic := '0';
signal ftch_tready_ch1              : std_logic := '0';
signal ftch_tready_ch2              : std_logic := '0';

-- Misc Signals
signal writing_curdesc          : std_logic := '0';
signal writing_nxtdesc          : std_logic := '0';

signal msb_curdesc              : std_logic_vector(31 downto 0) := (others => '0');
signal writing_lsb              : std_logic := '0';
signal writing_msb              : std_logic := '0';

-- FIFO signals
signal queue_rden2               : std_logic := '0';
signal queue_rden2_new               : std_logic := '0';
signal queue_wren2               : std_logic := '0';
signal queue_wren2_new               : std_logic := '0';
signal queue_empty2              : std_logic := '0';
signal queue_empty2_new              : std_logic := '0';
signal queue_rden               : std_logic := '0';
signal queue_rden_new               : std_logic := '0';
signal queue_wren               : std_logic := '0';
signal queue_wren_new               : std_logic := '0';
signal queue_empty              : std_logic := '0';
signal queue_empty_new              : std_logic := '0';
signal queue_dout_valid              : std_logic := '0';
signal queue_dout2_valid              : std_logic := '0';
signal queue_full_new               : std_logic := '0';
signal queue_full2_new               : std_logic := '0';
signal queue_full, queue_full2               : std_logic := '0';
signal queue_din_new                : std_logic_vector
                                    (127 downto 0) := (others => '0');
signal queue_dout_new_64            : std_logic_vector ((1+C_ENABLE_CDMA)*(C_M_AXI_SG_ADDR_WIDTH-32) -1 downto 0) := (others => '0');
signal queue_dout_new_bd            : std_logic_vector (31 downto 0) := (others => '0');
signal queue_dout_new               : std_logic_vector
                                    (96+31*C_ENABLE_CDMA-6 downto 0) := (others => '0');
signal queue_dout_mcdma_new               : std_logic_vector
                                    (63 downto 0) := (others => '0');
signal queue_dout2_new_64            : std_logic_vector ((1+C_ENABLE_CDMA)*(C_M_AXI_SG_ADDR_WIDTH-32) -1 downto 0) := (others => '0');
signal queue_dout2_new_bd            : std_logic_vector (31 downto 0) := (others => '0');
signal queue_dout2_new               : std_logic_vector
                                    (96+31*C_ENABLE_CDMA-6 downto 0) := (others => '0');
signal queue_dout2_mcdma_new               : std_logic_vector
                                    (63 downto 0) := (others => '0');
signal queue_din                : std_logic_vector
                                    (C_M_AXIS_SG_TDATA_WIDTH downto 0) := (others => '0');
signal queue_dout               : std_logic_vector
                                    (C_M_AXIS_SG_TDATA_WIDTH downto 0) := (others => '0');
signal queue_dout2               : std_logic_vector
                                    (C_M_AXIS_SG_TDATA_WIDTH downto 0) := (others => '0');
signal queue_sinit              : std_logic := '0';
signal queue_sinit2              : std_logic := '0';
signal queue_dcount_new        : std_logic_vector(FETCH_QUEUE_CNT_WIDTH-1 downto 0) := (others => '0');
signal queue_dcount2_new       : std_logic_vector(FETCH_QUEUE_CNT_WIDTH-1 downto 0) := (others => '0');
signal ftch_no_room             : std_logic;

signal ftch_active : std_logic := '0';

signal ftch_tvalid_mult              : std_logic := '0';
signal ftch_tdata_mult               : std_logic_vector
                                    (C_M_AXIS_SG_TDATA_WIDTH-1 downto 0) := (others => '0');
signal ftch_tlast_mult               : std_logic := '0';

signal counter : std_logic_vector (3 downto 0) := (others => '0');
signal wr_cntl : std_logic := '0';

signal sof_ftch_desc_del : std_logic;
signal sof_ftch_desc_del1 : std_logic;
signal sof_ftch_desc_pulse : std_logic;
signal current_bd : std_logic_vector (C_M_AXI_SG_ADDR_WIDTH-1 downto 0) := (others => '0');

signal xfer_in_progress : std_logic := '0';

-------------------------------------------------------------------------------
-- Begin architecture logic
-------------------------------------------------------------------------------
begin


SOF_DEL_PROCESS : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0')then
                sof_ftch_desc_del <= '0';
            else
                sof_ftch_desc_del <= sof_ftch_desc;
            end if;
        end if;
   end process SOF_DEL_PROCESS;

SOF_DEL1_PROCESS : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0' or (m_axis_mm2s_tlast = '1' and m_axis_mm2s_tvalid = '1'))then
                sof_ftch_desc_del1 <= '0';
            elsif (m_axis_mm2s_tvalid = '1') then
                sof_ftch_desc_del1 <= sof_ftch_desc;
            end if;
        end if;
   end process SOF_DEL1_PROCESS;

sof_ftch_desc_pulse <= sof_ftch_desc and (not sof_ftch_desc_del1);

ftch_active <= ftch1_active or ftch2_active;
---------------------------------------------------------------------------
-- Write current descriptor to FIFO or out channel port
---------------------------------------------------------------------------

CURRENT_BD_64 : if C_M_AXI_SG_ADDR_WIDTH > 32 generate
begin

CMDDATA_PROCESS : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0')then
                  current_bd <= (others => '0');
            elsif (ftch2_active = '1' and C_ENABLE_MULTI_CHANNEL = 1) then 
                  current_bd <= next_bd;
            elsif (ftch_cmnd_wr = '1' and ftch_active = '1') then
                current_bd       <= ftch_cmnd_data(32+DATAMOVER_CMD_ADDRMSB_BOFST
                                                        + DATAMOVER_CMD_ADDRLSB_BIT
                                                        downto DATAMOVER_CMD_ADDRLSB_BIT);
            end if;
        end if;
   end process CMDDATA_PROCESS;
end generate CURRENT_BD_64;


CURRENT_BD_32 : if C_M_AXI_SG_ADDR_WIDTH = 32 generate
begin

CMDDATA_PROCESS : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0')then
                  current_bd <= (others => '0');
            elsif (ftch2_active = '1' and C_ENABLE_MULTI_CHANNEL = 1) then 
                  current_bd <= next_bd;
            elsif (ftch_cmnd_wr = '1' and ftch_active = '1') then
                current_bd       <= ftch_cmnd_data(DATAMOVER_CMD_ADDRMSB_BOFST
                                                        + DATAMOVER_CMD_ADDRLSB_BIT
                                                        downto DATAMOVER_CMD_ADDRLSB_BIT);
            end if;
        end if;
   end process CMDDATA_PROCESS;
end generate CURRENT_BD_32;



GEN_MULT_CHANNEL : if C_ENABLE_MULTI_CHANNEL = 1 generate
begin
            ftch_tvalid_mult  <= m_axis_mm2s_tvalid;
            ftch_tdata_mult   <= m_axis_mm2s_tdata;
            ftch_tlast_mult   <= m_axis_mm2s_tlast;
            wr_cntl <= m_axis_mm2s_tvalid;

end generate GEN_MULT_CHANNEL;


GEN_NOMULT_CHANNEL : if C_ENABLE_MULTI_CHANNEL = 0 generate
begin
            ftch_tvalid_mult  <= '0'; --m_axis_mm2s_tvalid;
            ftch_tdata_mult   <= (others => '0'); --m_axis_mm2s_tdata;
            ftch_tlast_mult   <= '0'; --m_axis_mm2s_tlast;
            m_axis_ftch1_tdata_mcdma_new <= (others => '0');
            m_axis_ftch2_tdata_mcdma_new <= (others => '0');

COUNTER_PROCESS : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0' or m_axis_mm2s_tlast = '1')then
                counter <= (others => '0');
            elsif (m_axis_mm2s_tvalid = '1') then
                counter <= std_logic_vector(unsigned(counter) + 1);
            end if;
        end if;
   end process COUNTER_PROCESS;


end generate GEN_NOMULT_CHANNEL;

---------------------------------------------------------------------------
-- TVALID MUX
-- MUX tvalid out channel port
---------------------------------------------------------------------------
CDMA_FIELDS : if C_ENABLE_CDMA = 1 generate
begin

CDMA_FIELDS_64 : if C_M_AXI_SG_ADDR_WIDTH > 32 generate
begin

ftch_tdata_new_64 (63 downto 0) <= data_concat_64_cdma & data_concat_64;
ftch_tdata_new_bd (31 downto 0) <= current_bd (C_M_AXI_SG_ADDR_WIDTH-1 downto 32);

end generate CDMA_FIELDS_64;

ftch_tdata_new (95 downto 0) <= data_concat;
-- BD is always 16 word aligned
ftch_tdata_new (121 downto 96) <= current_bd (31 downto 6);

end generate CDMA_FIELDS;

DMA_FIELDS : if C_ENABLE_CDMA = 0 generate
begin

DMA_FIELDS_64 : if C_M_AXI_SG_ADDR_WIDTH > 32 generate
begin

ftch_tdata_new_64 (31 downto 0) <= data_concat_64;
ftch_tdata_new_bd (31 downto 0) <= current_bd (C_M_AXI_SG_ADDR_WIDTH-1 downto 32);

end generate DMA_FIELDS_64;

ftch_tdata_new (64 downto 0) <= data_concat (95) & data_concat (63 downto 0);-- when (ftch_active = '1') else (others =>'0');
-- BD is always 16 word aligned
ftch_tdata_new (90 downto 65) <= current_bd (31 downto 6);

end generate DMA_FIELDS;


ftch_tvalid_new  <= data_concat_valid and ftch_active;
ftch_tlast_new  <= data_concat_tlast and ftch_active;


GEN_MM2S : if C_INCLUDE_MM2S = 1 generate
begin

process (m_axi_sg_aclk)
begin
    if (m_axi_sg_aclk'event and m_axi_sg_aclk = '1') then
        if (queue_sinit = '1' or queue_rden_new = '1') then
           queue_empty_new <= '1';
           queue_full_new <= '0';
        elsif (queue_wren_new = '1') then
           queue_empty_new <= '0';
           queue_full_new <= '1';
        end if;
    end if;
end process;

process (m_axi_sg_aclk)
begin
    if (m_axi_sg_aclk'event and m_axi_sg_aclk = '1') then
        if (queue_sinit = '1') then
           reg1 <= (others => '0');
           reg1_64 <= (others => '0');
           reg1_bd_64 <= (others => '0');
        elsif (queue_wren_new = '1') then
           reg1 <= ftch_tdata_new;
           reg1_64 <= ftch_tdata_new_64;
           reg1_bd_64 <= ftch_tdata_new_bd;
        end if;
    end if;
end process;


process (m_axi_sg_aclk)
begin
    if (m_axi_sg_aclk'event and m_axi_sg_aclk = '1') then
        if (queue_sinit = '1') then
           queue_dout_new <= (others => '0');
           queue_dout_new_64 <= (others => '0');
           queue_dout_new_bd <= (others => '0');
        elsif (queue_rden_new = '1') then
           queue_dout_new <= reg1;
           queue_dout_new_64 <= reg1_64;
           queue_dout_new_bd <= reg1_bd_64;
        end if;
    end if;
end process;


process (m_axi_sg_aclk)
begin
    if (m_axi_sg_aclk'event and m_axi_sg_aclk = '1') then
        if (queue_sinit = '1' or queue_dout_valid = '1') then
           queue_dout_valid <= '0';
        elsif (queue_rden_new = '1') then
           queue_dout_valid <= '1';
        end if;
    end if;
end process;


MCDMA_MM2S : if C_ENABLE_MULTI_CHANNEL = 1 generate
begin

    -- Generate Synchronous FIFO
    I_CH1_FTCH_MCDMA_FIFO_NEW : entity lib_fifo_v1_0_4.sync_fifo_fg
    generic map (
        C_FAMILY                =>  C_FAMILY                ,
        C_MEMORY_TYPE           =>  0, --MEMORY_TYPE             ,
        C_WRITE_DATA_WIDTH      =>  64,
        C_WRITE_DEPTH           =>  FETCH_QUEUE_DEPTH       ,
        C_READ_DATA_WIDTH       =>  64,
        C_READ_DEPTH            =>  FETCH_QUEUE_DEPTH       ,
        C_PORTS_DIFFER          =>  0,
        C_HAS_DCOUNT            =>  0,
        C_DCOUNT_WIDTH          =>  FETCH_QUEUE_CNT_WIDTH,
        C_HAS_ALMOST_FULL       =>  0,
        C_HAS_RD_ACK            =>  0,
        C_HAS_RD_ERR            =>  0,
        C_HAS_WR_ACK            =>  0,
        C_HAS_WR_ERR            =>  0,
        C_RD_ACK_LOW            =>  0,
        C_RD_ERR_LOW            =>  0,
        C_WR_ACK_LOW            =>  0,
        C_WR_ERR_LOW            =>  0,
        C_PRELOAD_REGS          =>  0,-- 1 = first word fall through
        C_PRELOAD_LATENCY       =>  1 -- 0 = first word fall through

    )
    port map (

        Clk             =>  m_axi_sg_aclk       ,
        Sinit           =>  queue_sinit         ,
        Din             =>  data_concat_mcdma, --ftch_tdata_new, --queue_din           ,
        Wr_en           =>  queue_wren_new          ,
        Rd_en           =>  queue_rden_new          ,
        Dout            =>  queue_dout_mcdma_new          ,
        Full            =>  open, --queue_full_new          ,
        Empty           =>  open, --queue_empty_new         ,
        Almost_full     =>  open                ,
        Data_count      =>  open, --queue_dcount_new    ,
        Rd_ack          =>  open, --queue_dout_valid, --open                ,
        Rd_err          =>  open                ,
        Wr_ack          =>  open                ,
        Wr_err          =>  open

    );

m_axis_ftch1_tdata_mcdma_new <= queue_dout_mcdma_new;

end generate MCDMA_MM2S;



CONTROL_STREAM : if C_SG_WORDS_TO_FETCH = 13 generate
begin


        I_MM2S_CNTRL_STREAM : entity axi_sg_v4_1_2.axi_sg_cntrl_strm
            generic map(
                C_PRMRY_IS_ACLK_ASYNC           => C_ASYNC           ,
                C_PRMY_CMDFIFO_DEPTH            => FETCH_QUEUE_DEPTH             ,
                C_M_AXIS_MM2S_CNTRL_TDATA_WIDTH => C_M_AXIS_SG_TDATA_WIDTH  ,
                C_FAMILY                        => C_FAMILY
            )
            port map(
                -- Secondary clock / reset
                m_axi_sg_aclk               => m_axi_sg_aclk                ,
                m_axi_sg_aresetn            => m_axi_sg_aresetn             ,

                -- Primary clock / reset
                axi_prmry_aclk              => m_axi_primary_aclk           ,
                p_reset_n                   => p_reset_n                    ,

                -- MM2S Error
                mm2s_stop                   => ch1_cntrl_strm_stop              ,

                -- Control Stream input
                cntrlstrm_fifo_wren         => queue_wren          ,
                cntrlstrm_fifo_full         => queue_full          ,
                cntrlstrm_fifo_din          => queue_din           ,

                -- Memory Map to Stream Control Stream Interface
                m_axis_mm2s_cntrl_tdata     => m_axis_mm2s_cntrl_tdata      ,
                m_axis_mm2s_cntrl_tkeep     => m_axis_mm2s_cntrl_tkeep      ,
                m_axis_mm2s_cntrl_tvalid    => m_axis_mm2s_cntrl_tvalid     ,
                m_axis_mm2s_cntrl_tready    => m_axis_mm2s_cntrl_tready     ,
                m_axis_mm2s_cntrl_tlast     => m_axis_mm2s_cntrl_tlast

            );


end generate CONTROL_STREAM;


end generate GEN_MM2S;

GEN_S2MM : if C_INCLUDE_S2MM = 1 generate
begin

process (m_axi_sg_aclk)
begin
    if (m_axi_sg_aclk'event and m_axi_sg_aclk = '1') then
        if (queue_sinit2 = '1' or queue_rden2_new = '1') then
           queue_empty2_new <= '1';
           queue_full2_new <= '0';
        elsif (queue_wren2_new = '1') then
           queue_empty2_new <= '0';
           queue_full2_new <= '1';
        end if;
    end if;
end process;

process (m_axi_sg_aclk)
begin
    if (m_axi_sg_aclk'event and m_axi_sg_aclk = '1') then
        if (queue_sinit2 = '1') then
           reg2 <= (others => '0');
           reg2_64 <= (others => '0');
           reg2_bd_64 <= (others => '0');
        elsif (queue_wren2_new = '1') then
           reg2 <= ftch_tdata_new;
           reg2_64 <= ftch_tdata_new_64;
           reg2_bd_64 <= ftch_tdata_new_bd;
        end if;
    end if;
end process;


process (m_axi_sg_aclk)
begin
    if (m_axi_sg_aclk'event and m_axi_sg_aclk = '1') then
        if (queue_sinit2 = '1') then
           queue_dout2_new <= (others => '0');
           queue_dout2_new_64 <= (others => '0');
           queue_dout2_new_bd <= (others => '0');
        elsif (queue_rden2_new = '1') then
           queue_dout2_new <= reg2;
           queue_dout2_new_64 <= reg2_64;
           queue_dout2_new_bd <= reg2_bd_64;
        end if;
    end if;
end process;


process (m_axi_sg_aclk)
begin
    if (m_axi_sg_aclk'event and m_axi_sg_aclk = '1') then
        if (queue_sinit2 = '1' or queue_dout2_valid = '1') then
           queue_dout2_valid <= '0';
        elsif (queue_rden2_new = '1') then
           queue_dout2_valid <= '1';
        end if;
    end if;
end process;



MCDMA_S2MM : if C_ENABLE_MULTI_CHANNEL = 1 generate
begin

    -- Generate Synchronous FIFO
    I_CH2_FTCH_MCDMA_FIFO_NEW : entity lib_fifo_v1_0_4.sync_fifo_fg
    generic map (
        C_FAMILY                =>  C_FAMILY                ,
        C_MEMORY_TYPE           =>  0, --MEMORY_TYPE             ,
        C_WRITE_DATA_WIDTH      =>  64,
        C_WRITE_DEPTH           =>  FETCH_QUEUE_DEPTH       ,
        C_READ_DATA_WIDTH       =>  64,
        C_READ_DEPTH            =>  FETCH_QUEUE_DEPTH       ,
        C_PORTS_DIFFER          =>  0,
        C_HAS_DCOUNT            =>  0,
        C_DCOUNT_WIDTH          =>  FETCH_QUEUE_CNT_WIDTH,
        C_HAS_ALMOST_FULL       =>  0,
        C_HAS_RD_ACK            =>  0,
        C_HAS_RD_ERR            =>  0,
        C_HAS_WR_ACK            =>  0,
        C_HAS_WR_ERR            =>  0,
        C_RD_ACK_LOW            =>  0,
        C_RD_ERR_LOW            =>  0,
        C_WR_ACK_LOW            =>  0,
        C_WR_ERR_LOW            =>  0,
        C_PRELOAD_REGS          =>  0,-- 1 = first word fall through
        C_PRELOAD_LATENCY       =>  1 -- 0 = first word fall through

    )
    port map (

        Clk             =>  m_axi_sg_aclk       ,
        Sinit           =>  queue_sinit2         ,
        Din             =>  data_concat_mcdma, --ftch_tdata_new, --queue_din           ,
        Wr_en           =>  queue_wren2_new          ,
        Rd_en           =>  queue_rden2_new          ,
        Dout            =>  queue_dout2_new          ,
        Full            =>  open, --queue_full2_new          ,
        Empty           =>  open, --queue_empty2_new         ,
        Almost_full     =>  open                ,
        Data_count      =>  queue_dcount2_new        ,
        Rd_ack          =>  open, --queue_dout2_valid                ,
        Rd_err          =>  open                ,
        Wr_ack          =>  open                ,
        Wr_err          =>  open

    );

m_axis_ftch2_tdata_mcdma_new <= queue_dcount2_new;

end generate MCDMA_S2MM;

end generate GEN_S2MM;


-----------------------------------------------------------------------
-- Internal Side
-----------------------------------------------------------------------

-- Drive tready with fifo not full
ftch_tready <= ftch_tready_ch1 or ftch_tready_ch2;
              

-- Following is the APP data that goes into APP FIFO
queue_din(C_M_AXIS_SG_TDATA_WIDTH)               <= m_axis_mm2s_tlast;
queue_din(C_M_AXIS_SG_TDATA_WIDTH-1 downto 0)    <= x"A0000000" when (sof_ftch_desc_pulse = '1') else m_axis_mm2s_tdata;

GEN_CH1_CTRL : if C_INCLUDE_MM2S =1 generate
begin

--queue_full_new <= '1' when (queue_dcount_new = "00100") else '0';

queue_sinit <= desc1_flush or not m_axi_sg_aresetn;

ftch_tready_ch1 <= (not queue_full and ftch1_active); 
m_axis1_mm2s_tready <= ftch_tready_ch1;

-- Wr_en to APP FIFO. Data is written only when BD with SOF is fetched.

queue_wren  <= not queue_full
               and sof_ftch_desc
               and m_axis_mm2s_tvalid
               and ftch1_active;

-- Wr_en of BD FIFO
queue_wren_new  <= not queue_full_new
                   and ftch_tvalid_new
                   and ftch1_active;


ftch1_queue_empty <= queue_empty_new;

ftch1_queue_full     <= queue_full_new;

ftch1_pause <= queue_full_new;

-- RD_en of APP FIFO based on empty and tready

-- RD_EN of BD FIFO based on empty and tready
queue_rden_new  <= not queue_empty_new
               and m_axis_ftch1_tready;

-- drive valid if fifo is not empty

m_axis_ftch1_tvalid  <= '0';
m_axis_ftch1_tvalid_new  <= queue_dout_valid; --not queue_empty_new and (not ch2_sg_idle);

-- below signal triggers the fetch of BD in MM2S Mngr
m_axis_ftch1_desc_available <= not queue_empty_new and (not ch2_sg_idle);

-- Pass data out to port channel with MSB driving tlast
m_axis_ftch1_tlast   <= '0'; 
m_axis_ftch1_tdata   <= (others => '0'); 


FTCH_FIELDS_64 : if C_M_AXI_SG_ADDR_WIDTH > 32 generate
begin

m_axis_ftch1_tdata_new   <= queue_dout_new_bd & queue_dout_new_64 & queue_dout_new (FIFO_WIDTH-1 downto FIFO_WIDTH-26) & "000000" & queue_dout_new (FIFO_WIDTH-27 downto 0);

end generate FTCH_FIELDS_64;

FTCH_FIELDS_32 : if C_M_AXI_SG_ADDR_WIDTH = 32 generate
begin

m_axis_ftch1_tdata_new   <= queue_dout_new (FIFO_WIDTH-1 downto FIFO_WIDTH-26) & "000000" & queue_dout_new (FIFO_WIDTH-27 downto 0);

end generate FTCH_FIELDS_32;

writing1_curdesc_out <= writing_curdesc and ftch1_active;


NOCONTROL_STREAM_ASST : if C_SG_WORDS_TO_FETCH = 8 generate
begin

        m_axis_mm2s_cntrl_tdata  <= (others => '0');
        m_axis_mm2s_cntrl_tkeep  <= (others => '0');
        m_axis_mm2s_cntrl_tvalid <= '0';
        m_axis_mm2s_cntrl_tlast  <= '0';

end generate NOCONTROL_STREAM_ASST;

end generate GEN_CH1_CTRL;


GEN_NO_CH1_CTRL : if C_INCLUDE_MM2S =0 generate
begin

        m_axis_mm2s_cntrl_tdata  <= (others => '0');
        m_axis_mm2s_cntrl_tkeep  <= "0000";   
        m_axis_mm2s_cntrl_tvalid <= '0';   
        m_axis_mm2s_cntrl_tlast  <= '0';   

ftch_tready_ch1 <= '0';
m_axis1_mm2s_tready <= '0';

-- Write to fifo if it is not full and data is valid
queue_wren  <= '0';

ftch1_queue_empty <= '0';
ftch1_queue_full     <= '0';
ftch1_pause <= '0';
queue_rden  <= '0';

-- drive valid if fifo is not empty
m_axis_ftch1_tvalid  <= '0';

-- Pass data out to port channel with MSB driving tlast
m_axis_ftch1_tlast   <= '0';
m_axis_ftch1_tdata   <= (others => '0');
writing1_curdesc_out <= '0';
m_axis_ftch1_tdata_new   <= (others => '0');
m_axis_ftch1_tvalid_new  <= '0';
m_axis_ftch1_desc_available <= '0';

end generate GEN_NO_CH1_CTRL;



GEN_CH2_CTRL : if C_INCLUDE_S2MM =1 generate
begin
queue_sinit2 <= desc2_flush or not m_axi_sg_aresetn;

ftch_tready_ch2 <= (not queue_full2_new and ftch2_active); 
m_axis2_mm2s_tready <= ftch_tready_ch2;


queue_wren2  <= '0';

-- Wr_en for S2MM BD FIFO
queue_wren2_new  <= not queue_full2_new
                    and ftch_tvalid_new
                    and ftch2_active;

--queue_full2_new <= '1' when (queue_dcount2_new = "00100") else '0';

-- Pass fifo status back to fetch sm for channel IDLE determination

ftch2_queue_empty <= queue_empty2_new;

ftch2_queue_full     <= queue_full2_new;


ftch2_pause <= queue_full2_new;

queue_rden2  <= '0';

-- Rd_en for S2MM BD FIFO
queue_rden2_new  <= not queue_empty2_new
                    and m_axis_ftch2_tready;

m_axis_ftch2_tvalid  <= '0';
m_axis_ftch2_tvalid_new  <= queue_dout2_valid; -- not queue_empty2_new and (not ch2_sg_idle);
m_axis_ftch2_desc_available <= not queue_empty2_new and (not ch2_sg_idle);

-- Pass data out to port channel with MSB driving tlast
m_axis_ftch2_tlast   <= '0';
m_axis_ftch2_tdata   <= (others => '0');

FTCH_FIELDS_64_2 : if C_M_AXI_SG_ADDR_WIDTH > 32 generate

m_axis_ftch2_tdata_new   <= queue_dout2_new_bd & queue_dout2_new_64 & queue_dout2_new (FIFO_WIDTH-1 downto FIFO_WIDTH-26) & "000000" & queue_dout2_new (FIFO_WIDTH-27 downto 0);

end generate FTCH_FIELDS_64_2;


FTCH_FIELDS_32_2 : if C_M_AXI_SG_ADDR_WIDTH = 32 generate

m_axis_ftch2_tdata_new   <= queue_dout2_new (FIFO_WIDTH-1 downto FIFO_WIDTH-26) & "000000" & queue_dout2_new (FIFO_WIDTH-27 downto 0);

end generate FTCH_FIELDS_32_2;

writing2_curdesc_out <= writing_curdesc and ftch2_active;

end generate GEN_CH2_CTRL;

GEN_NO_CH2_CTRL : if C_INCLUDE_S2MM =0 generate
begin

ftch_tready_ch2 <= '0';
m_axis2_mm2s_tready <= '0';
queue_wren2  <= '0';

-- Pass fifo status back to fetch sm for channel IDLE determination
--ftch_queue_empty    <= queue_empty; CR 621600

ftch2_queue_empty <= '0';
ftch2_queue_full  <= '0';
ftch2_pause <= '0';
queue_rden2 <= '0';

m_axis_ftch2_tvalid  <= '0';

-- Pass data out to port channel with MSB driving tlast
m_axis_ftch2_tlast   <= '0';
m_axis_ftch2_tdata   <= (others => '0');
m_axis_ftch2_tdata_new   <= (others => '0');
m_axis_ftch2_tvalid_new  <= '0';
writing2_curdesc_out <= '0';
m_axis_ftch2_desc_available <= '0';

end generate GEN_NO_CH2_CTRL;


-- If writing curdesc out then flag for proper mux selection
writing_curdesc     <= curdesc_tvalid;
-- Map intnal signal to port
-- Map port to internal signal
writing_nxtdesc     <= writing_nxtdesc_in;


end implementation;
