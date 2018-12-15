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

library lib_pkg_v1_0_2;
use lib_pkg_v1_0_2.lib_pkg.all;

-------------------------------------------------------------------------------
entity  axi_sg_ftch_q_mngr is
    generic (
        C_M_AXI_SG_ADDR_WIDTH       : integer range 32 to 64    := 32;
            -- Master AXI Memory Map Address Width

        C_M_AXIS_SG_TDATA_WIDTH     : integer range 32 to 32    := 32;
            -- Master AXI Stream Data width

        C_AXIS_IS_ASYNC             : integer range 0 to 1      := 0;
            -- Channel 1 is async to sg_aclk
            -- 0 = Synchronous to SG ACLK
            -- 1 = Asynchronous to SG ACLK

        C_ASYNC             : integer range 0 to 1      := 0;
            -- Channel 1 is async to sg_aclk
            -- 0 = Synchronous to SG ACLK
            -- 1 = Asynchronous to SG ACLK

        C_SG_FTCH_DESC2QUEUE        : integer range 0 to 8         := 0;
            -- Number of descriptors to fetch and queue for each channel.
            -- A value of zero excludes the fetch queues.
        C_ENABLE_MULTI_CHANNEL      : integer range 0 to 1          := 0;

        C_SG_CH1_WORDS_TO_FETCH         : integer range 4 to 16     := 8;
            -- Number of words to fetch for channel 1

        C_SG_CH2_WORDS_TO_FETCH         : integer range 4 to 16     := 8;
            -- Number of words to fetch for channel 1

        C_SG_CH1_ENBL_STALE_ERROR   : integer range 0 to 1          := 1;
            -- Enable or disable stale descriptor check
            -- 0 = Disable stale descriptor error check
            -- 1 = Enable stale descriptor error check

        C_SG_CH2_ENBL_STALE_ERROR   : integer range 0 to 1          := 1;
            -- Enable or disable stale descriptor check
            -- 0 = Disable stale descriptor error check
            -- 1 = Enable stale descriptor error check

        C_INCLUDE_CH1               : integer range 0 to 1          := 1;
            -- Include or Exclude channel 1 scatter gather engine
            -- 0 = Exclude Channel 1 SG Engine
            -- 1 = Include Channel 1 SG Engine


        C_INCLUDE_CH2               : integer range 0 to 1          := 1;
            -- Include or Exclude channel 2 scatter gather engine
            -- 0 = Exclude Channel 2 SG Engine
            -- 1 = Include Channel 2 SG Engine
        C_ENABLE_CDMA               : integer range 0 to 1          := 0;

        C_ACTUAL_ADDR               : integer range 32 to 64        := 32;

        C_FAMILY                    : string            := "virtex7"
            -- Device family used for proper BRAM selection
    );
    port (
        -----------------------------------------------------------------------
        -- AXI Scatter Gather Interface
        -----------------------------------------------------------------------
        m_axi_sg_aclk               : in  std_logic                         ;                   --
        m_axi_mm2s_aclk               : in  std_logic                         ;                   --
        m_axi_sg_aresetn            : in  std_logic                         ;                   --
        p_reset_n                   : in  std_logic                         ;

        ch2_sg_idle                 : in std_logic                          ;
                                                                                                --
        -- Channel 1 Control                                                                    --
        ch1_desc_flush              : in  std_logic                         ;                   --
        ch1_cyclic                  : in  std_logic                         ;                   --
        ch1_cntrl_strm_stop         : in  std_logic                         ;
        ch1_ftch_active             : in  std_logic                         ;                   --
        ch1_nxtdesc_wren            : out std_logic                         ;                   --
        ch1_ftch_queue_empty        : out std_logic                         ;                   --
        ch1_ftch_queue_full         : out std_logic                         ;                   --
        ch1_ftch_pause              : out std_logic                         ;                   --
                                                                                                --
        -- Channel 2 Control                                                                    --
        ch2_desc_flush              : in  std_logic                         ;                   --
        ch2_cyclic                  : in  std_logic                         ;                   --
        ch2_ftch_active             : in  std_logic                         ;                   --
        ch2_nxtdesc_wren            : out std_logic                         ;                   --
        ch2_ftch_queue_empty        : out std_logic                         ;                   --
        ch2_ftch_queue_full         : out std_logic                         ;                   --
        ch2_ftch_pause              : out std_logic                         ;                   --
        nxtdesc                     : out std_logic_vector                                      --
                                        (C_M_AXI_SG_ADDR_WIDTH-1 downto 0)  ;                   --
        -- DataMover Command                                                                    --
        ftch_cmnd_wr                : in  std_logic                         ;                   --
        ftch_cmnd_data              : in  std_logic_vector                                      --
                                        ((C_M_AXI_SG_ADDR_WIDTH+CMD_BASE_WIDTH)-1 downto 0);    --
        ftch_stale_desc             : out std_logic                         ;                   --
                                                                                                --
        -- MM2S Stream In from DataMover                                                        --
        m_axis_mm2s_tdata           : in  std_logic_vector                                      --
                                        (C_M_AXIS_SG_TDATA_WIDTH-1 downto 0) ;                  --
        m_axis_mm2s_tkeep           : in  std_logic_vector                                      --
                                        ((C_M_AXIS_SG_TDATA_WIDTH/8)-1 downto 0);               --
        m_axis_mm2s_tlast           : in  std_logic                         ;                   --
        m_axis_mm2s_tvalid          : in  std_logic                         ;                   --
        m_axis_mm2s_tready          : out std_logic                         ;                   --
                                                                                                --
                                                                                                --
        -- Channel 1 AXI Fetch Stream Out                                                       --
        m_axis_ch1_ftch_aclk        : in  std_logic                         ;
        m_axis_ch1_ftch_tdata       : out std_logic_vector                                      --
                                        (C_M_AXIS_SG_TDATA_WIDTH-1 downto 0);                   --
        m_axis_ch1_ftch_tvalid      : out std_logic                         ;                   --
        m_axis_ch1_ftch_tready      : in  std_logic                         ;                   --
        m_axis_ch1_ftch_tlast       : out std_logic                         ;                   --

        m_axis_ch1_ftch_tdata_new       : out std_logic_vector                                      --
                                        (96+31*C_ENABLE_CDMA+(2+C_ENABLE_CDMA)*(C_M_AXI_SG_ADDR_WIDTH-32) downto 0);                   --
        m_axis_ch1_ftch_tdata_mcdma_new       : out std_logic_vector                                      --
                                        (63 downto 0);                   --
        m_axis_ch1_ftch_tvalid_new      : out std_logic                         ;                   --
        m_axis_ftch1_desc_available            : out std_logic                     ;

                                                                                                --
        m_axis_ch2_ftch_tdata_new       : out std_logic_vector                                      --
                                        (96+31*C_ENABLE_CDMA+(2+C_ENABLE_CDMA)*(C_M_AXI_SG_ADDR_WIDTH-32) downto 0);                   --
        m_axis_ch2_ftch_tdata_mcdma_new       : out std_logic_vector                                      --
                                        (63 downto 0);                   --
        m_axis_ch2_ftch_tdata_mcdma_nxt       : out std_logic_vector                                      --
                                        (C_M_AXI_SG_ADDR_WIDTH-1 downto 0);                   --
        m_axis_ch2_ftch_tvalid_new      : out std_logic                         ;                   --
        m_axis_ftch2_desc_available            : out std_logic                     ;

                                                                                                --
        -- Channel 2 AXI Fetch Stream Out                                                       --
        m_axis_ch2_ftch_aclk        : in  std_logic                         ;                   --
        m_axis_ch2_ftch_tdata       : out std_logic_vector                                      --
                                        (C_M_AXIS_SG_TDATA_WIDTH-1 downto 0) ;                  --
        m_axis_ch2_ftch_tvalid      : out std_logic                         ;                   --
        m_axis_ch2_ftch_tready      : in  std_logic                         ;                   --
        m_axis_ch2_ftch_tlast       : out std_logic                         ;                    --

        m_axis_mm2s_cntrl_tdata     : out std_logic_vector                                 --
                                        (31 downto 0);      --
        m_axis_mm2s_cntrl_tkeep     : out std_logic_vector                                 --
                                        (3 downto 0);  --
        m_axis_mm2s_cntrl_tvalid    : out std_logic                         ;              --
        m_axis_mm2s_cntrl_tready    : in  std_logic                         := '0';              --
        m_axis_mm2s_cntrl_tlast     : out std_logic                                       --


    );

end axi_sg_ftch_q_mngr;

-------------------------------------------------------------------------------
-- Architecture
-------------------------------------------------------------------------------
architecture implementation of axi_sg_ftch_q_mngr is
  attribute DowngradeIPIdentifiedWarnings: string;
  attribute DowngradeIPIdentifiedWarnings of implementation : architecture is "yes";



-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------

-- No Functions Declared

-------------------------------------------------------------------------------
-- Constants Declarations
-------------------------------------------------------------------------------

-- Determine the maximum word count for use in setting the word counter width
-- Set bit width on max num words to fetch

constant FETCH_COUNT            : integer := max2(C_SG_CH1_WORDS_TO_FETCH
                                                 ,C_SG_CH2_WORDS_TO_FETCH);
-- LOG2 to get width of counter
constant WORDS2FETCH_BITWIDTH   : integer := clog2(FETCH_COUNT);
-- Zero value for counter
constant WORD_ZERO              : std_logic_vector(WORDS2FETCH_BITWIDTH-1 downto 0)
                                    := (others => '0');
-- One value for counter
constant WORD_ONE               : std_logic_vector(WORDS2FETCH_BITWIDTH-1 downto 0)
                                    := std_logic_vector(to_unsigned(1,WORDS2FETCH_BITWIDTH));
-- Seven value for counter
constant WORD_SEVEN             : std_logic_vector(WORDS2FETCH_BITWIDTH-1 downto 0)
                                    := std_logic_vector(to_unsigned(7,WORDS2FETCH_BITWIDTH));

constant USE_LOGIC_FIFOS        : integer   := 0; -- Use Logic FIFOs
constant USE_BRAM_FIFOS         : integer   := 1; -- Use BRAM FIFOs


-------------------------------------------------------------------------------
-- Signal / Type Declarations
-------------------------------------------------------------------------------
signal m_axis_mm2s_tready_i     : std_logic := '0';
signal ch1_ftch_tready          : std_logic := '0';
signal ch2_ftch_tready          : std_logic := '0';

-- Misc Signals
signal writing_curdesc          : std_logic := '0';
signal fetch_word_count         : std_logic_vector
                                    (WORDS2FETCH_BITWIDTH-1 downto 0) := (others => '0');
signal msb_curdesc              : std_logic_vector(31 downto 0) := (others => '0');

signal lsbnxtdesc_tready        : std_logic := '0';
signal msbnxtdesc_tready        : std_logic := '0';
signal nxtdesc_tready           : std_logic := '0';

signal ch1_writing_curdesc      : std_logic := '0';
signal ch2_writing_curdesc      : std_logic := '0';
signal m_axis_ch2_ftch_tvalid_1 : std_logic := '0';

-- KAPIL
signal ch_desc_flush : std_logic := '0';
signal m_axis_ch_ftch_tready : std_logic := '0';
signal ch_ftch_queue_empty : std_logic := '0';
signal ch_ftch_queue_full : std_logic := '0';
signal ch_ftch_pause : std_logic := '0';
signal ch_writing_curdesc : std_logic := '0';
signal ch_ftch_tready : std_logic := '0';
signal m_axis_ch_ftch_tdata : std_logic_vector (C_M_AXIS_SG_TDATA_WIDTH-1 downto 0) := (others => '0');
signal m_axis_ch_ftch_tvalid : std_logic := '0';
signal m_axis_ch_ftch_tlast : std_logic := '0';


signal data_concat : std_logic_vector (95 downto 0) := (others => '0');
signal data_concat_64 : std_logic_vector (31 downto 0) := (others => '0');
signal data_concat_64_cdma : std_logic_vector (31 downto 0) := (others => '0');
signal data_concat_mcdma : std_logic_vector (63 downto 0) := (others => '0');
signal next_bd : std_logic_vector (31 downto 0) := (others => '0');
signal data_concat_valid, tvalid_new :  std_logic;
signal data_concat_tlast, tlast_new :  std_logic;
signal counter : std_logic_vector (C_SG_CH1_WORDS_TO_FETCH-1 downto 0);                      
 
signal sof_ftch_desc : std_logic;   

signal nxtdesc_int                     : std_logic_vector                                      --
                                        (C_M_AXI_SG_ADDR_WIDTH-1 downto 0)  ;                   --

signal cyclic_enable    : std_logic := '0';
  
-------------------------------------------------------------------------------
-- Begin architecture logic
-------------------------------------------------------------------------------
begin

    cyclic_enable <= ch1_cyclic when ch1_ftch_active = '1' else
                     ch2_cyclic; 

    nxtdesc <= nxtdesc_int;

TLAST_GEN : if (C_SG_CH1_WORDS_TO_FETCH = 13) generate

-- TLAST is generated when 8th beat is received

          tlast_new <= counter (7) and m_axis_mm2s_tvalid;
          tvalid_new <= counter (7) and m_axis_mm2s_tvalid;

    SOF_CHECK : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0' or (m_axis_mm2s_tvalid = '1' and m_axis_mm2s_tlast = '1'))then
                    sof_ftch_desc <= '0';
                elsif(counter (6) = '1'
                and m_axis_mm2s_tready_i = '1' and m_axis_mm2s_tvalid = '1'
                and m_axis_mm2s_tdata(27) = '1' )then
                    sof_ftch_desc <= '1';
                end if;
            end if;
        end process SOF_CHECK;

end generate TLAST_GEN;

NOTLAST_GEN : if (C_SG_CH1_WORDS_TO_FETCH /= 13) generate

                    sof_ftch_desc <= '0';

CDMA : if C_ENABLE_CDMA = 1 generate

-- For CDMA TLAST is generated when 7th beat is received
-- because last one is not needed

          tlast_new <= counter (6) and m_axis_mm2s_tvalid;
          tvalid_new <=counter (6) and m_axis_mm2s_tvalid;

end generate CDMA;

NOCDMA : if C_ENABLE_CDMA = 0 generate
-- For DMA tlast is generated with 8th beat

          tlast_new <=  counter (7) and m_axis_mm2s_tvalid;
          tvalid_new <= counter (7) and m_axis_mm2s_tvalid;



end generate NOCDMA;

end generate NOTLAST_GEN;

-- Following shift register keeps track of number of data beats
-- of BD that is being read

    DATA_BEAT_REG : process (m_axi_sg_aclk)
       begin
         if (m_axi_sg_aclk'event and m_axi_sg_aclk = '1') then
            if (m_axi_sg_aresetn          = '0' or (m_axis_mm2s_tlast = '1' and m_axis_mm2s_tvalid = '1')) then
              counter (0) <= '1';
              counter (C_SG_CH1_WORDS_TO_FETCH-1 downto 1) <= (others => '0');
              
            Elsif (m_axis_mm2s_tvalid = '1') then
              counter (C_SG_CH1_WORDS_TO_FETCH-1 downto 1) <= counter (C_SG_CH1_WORDS_TO_FETCH-2 downto 0);
              counter (0) <= '0';
            end if; 
         end if;       
       end process DATA_BEAT_REG; 

-- Registering the Buffer address from BD, 3rd beat
-- Common for DMA, CDMA

    DATA_REG1 : process (m_axi_sg_aclk)
       begin
         if (m_axi_sg_aclk'event and m_axi_sg_aclk = '1') then
            if (m_axi_sg_aresetn          = '0') then
              data_concat (31 downto 0) <= (others => '0');
              
            Elsif (counter (2) = '1') then
              data_concat (31 downto 0) <= m_axis_mm2s_tdata;
            end if; 
         end if;       
       end process DATA_REG1; 

ADDR_64BIT : if C_ACTUAL_ADDR = 64 generate
begin

    DATA_REG1_64 : process (m_axi_sg_aclk)
       begin
         if (m_axi_sg_aclk'event and m_axi_sg_aclk = '1') then
            if (m_axi_sg_aresetn          = '0') then
              data_concat_64 (31 downto 0) <= (others => '0');
              
            Elsif (counter (3) = '1') then
              data_concat_64 (31 downto 0) <= m_axis_mm2s_tdata;
            end if; 
         end if;       
       end process DATA_REG1_64; 
end generate ADDR_64BIT;


ADDR_64BIT2 : if C_ACTUAL_ADDR > 32 and C_ACTUAL_ADDR < 64 generate
begin

    DATA_REG1_64 : process (m_axi_sg_aclk)
       begin
         if (m_axi_sg_aclk'event and m_axi_sg_aclk = '1') then
            if (m_axi_sg_aresetn          = '0') then
              data_concat_64 (C_ACTUAL_ADDR-32-1 downto 0) <= (others => '0');
              
            Elsif (counter (3) = '1') then
              data_concat_64 (C_ACTUAL_ADDR-32-1 downto 0) <= m_axis_mm2s_tdata (C_ACTUAL_ADDR-32-1 downto 0);
            end if; 
         end if;       
       end process DATA_REG1_64;

 data_concat_64 (31 downto C_ACTUAL_ADDR-32) <= (others => '0');

 
end generate ADDR_64BIT2;


DMA_REG2 : if C_ENABLE_CDMA = 0 generate
begin

-- For DMA, the 7th beat has the control information

    DATA_REG2 : process (m_axi_sg_aclk)
       begin
         if (m_axi_sg_aclk'event and m_axi_sg_aclk = '1') then
            if (m_axi_sg_aresetn          = '0') then
              data_concat (63 downto 32) <= (others => '0');
              
            Elsif (counter (6) = '1') then
              data_concat (63 downto 32) <= m_axis_mm2s_tdata;
            end if; 
         end if;       
       end process DATA_REG2; 

end generate DMA_REG2;

CDMA_REG2 : if C_ENABLE_CDMA = 1 generate
begin

-- For CDMA, the 5th beat has the DA information

    DATA_REG2 : process (m_axi_sg_aclk)
       begin
         if (m_axi_sg_aclk'event and m_axi_sg_aclk = '1') then
            if (m_axi_sg_aresetn          = '0') then
              data_concat (63 downto 32) <= (others => '0');
              
            Elsif (counter (4) = '1') then
              data_concat (63 downto 32) <= m_axis_mm2s_tdata;
            end if; 
         end if;       
       end process DATA_REG2; 

CDMA_ADDR_64BIT : if C_ACTUAL_ADDR = 64 generate
begin

    DATA_REG2_64 : process (m_axi_sg_aclk)
       begin
         if (m_axi_sg_aclk'event and m_axi_sg_aclk = '1') then
            if (m_axi_sg_aresetn          = '0') then
              data_concat_64_cdma (31 downto 0) <= (others => '0');
              
            Elsif (counter (5) = '1') then
              data_concat_64_cdma (31 downto 0) <= m_axis_mm2s_tdata;
            end if; 
         end if;       
       end process DATA_REG2_64; 


end generate CDMA_ADDR_64BIT;


CDMA_ADDR_64BIT2 : if C_ACTUAL_ADDR > 32 and C_ACTUAL_ADDR < 64 generate
begin

    DATA_REG2_64 : process (m_axi_sg_aclk)
       begin
         if (m_axi_sg_aclk'event and m_axi_sg_aclk = '1') then
            if (m_axi_sg_aresetn          = '0') then
              data_concat_64_cdma (C_ACTUAL_ADDR-32-1 downto 0) <= (others => '0');
              
            Elsif (counter (5) = '1') then
              data_concat_64_cdma (C_ACTUAL_ADDR-32-1 downto 0) <= m_axis_mm2s_tdata (C_ACTUAL_ADDR-32-1 downto 0);
            end if; 
         end if;       
       end process DATA_REG2_64; 

 data_concat_64_cdma (31 downto C_ACTUAL_ADDR-32) <= (others => '0');

end generate CDMA_ADDR_64BIT2;

end generate CDMA_REG2;

NOFLOP_FOR_QUEUE : if C_SG_CH1_WORDS_TO_FETCH = 8 generate
begin

-- Last beat is directly concatenated and passed to FIFO
-- Masking the CMPLT bit with cyclic_enable
              data_concat (95 downto 64) <= (m_axis_mm2s_tdata(31) and (not cyclic_enable)) & m_axis_mm2s_tdata (30 downto 0);
              data_concat_valid <= tvalid_new;
              data_concat_tlast <= tlast_new;

end generate NOFLOP_FOR_QUEUE;


-- In absence of queuing option the last beat needs to be floped

FLOP_FOR_NOQUEUE : if C_SG_CH1_WORDS_TO_FETCH = 13 generate
begin

NO_FETCH_Q : if C_SG_FTCH_DESC2QUEUE = 0 generate 
    DATA_REG3 : process (m_axi_sg_aclk)
       begin
         if (m_axi_sg_aclk'event and m_axi_sg_aclk = '1') then
            if (m_axi_sg_aresetn          = '0') then
              data_concat (95 downto 64) <= (others => '0');
            Elsif (counter (7) = '1') then
              data_concat (95 downto 64) <= (m_axis_mm2s_tdata(31) and (not cyclic_enable)) & m_axis_mm2s_tdata (30 downto 0);
            end if; 
         end if;       
       end process DATA_REG3; 
end generate NO_FETCH_Q;

FETCH_Q : if C_SG_FTCH_DESC2QUEUE /= 0 generate 
    DATA_REG3 : process (m_axi_sg_aclk)
       begin
         if (m_axi_sg_aclk'event and m_axi_sg_aclk = '1') then
            if (m_axi_sg_aresetn          = '0') then
              data_concat (95) <= '0';
            Elsif (counter (7) = '1') then
              data_concat (95) <= m_axis_mm2s_tdata (31) and (not cyclic_enable);
            end if; 
         end if;       
       end process DATA_REG3; 

              data_concat (94 downto 64) <= (others => '0');
end generate FETCH_Q;

    DATA_CNTRL : process (m_axi_sg_aclk)
       begin
         if (m_axi_sg_aclk'event and m_axi_sg_aclk = '1') then
            if (m_axi_sg_aresetn          = '0') then
              data_concat_valid <= '0';
              data_concat_tlast <= '0'; 
            Else
              data_concat_valid <= tvalid_new; 
              data_concat_tlast <= tlast_new; 
            end if; 
         end if;       
       end process DATA_CNTRL; 

end generate FLOP_FOR_NOQUEUE;

-- Since the McDMA BD has two more fields to be captured
-- following procedures are needed
NOMCDMA_FTECH : if C_ENABLE_MULTI_CHANNEL = 0 generate
begin
data_concat_mcdma <= (others => '0');
end generate NOMCDMA_FTECH;


MCDMA_BD_FETCH : if C_ENABLE_MULTI_CHANNEL = 1 generate 
begin



    DATA_MCDMA_REG1 : process (m_axi_sg_aclk)
       begin
         if (m_axi_sg_aclk'event and m_axi_sg_aclk = '1') then
            if (m_axi_sg_aresetn          = '0') then
              data_concat_mcdma (31 downto 0) <= (others => '0');
            Elsif (counter (4) = '1') then
              data_concat_mcdma (31 downto 0) <= m_axis_mm2s_tdata;
            end if; 
         end if;       
       end process DATA_MCDMA_REG1; 


    DATA_MCDMA_REG2 : process (m_axi_sg_aclk)
       begin
         if (m_axi_sg_aclk'event and m_axi_sg_aclk = '1') then
            if (m_axi_sg_aresetn          = '0') then
              data_concat_mcdma (63 downto 32) <= (others => '0');
            Elsif (counter (5) = '1') then
              data_concat_mcdma (63 downto 32) <= m_axis_mm2s_tdata;
            end if; 
         end if;       
       end process DATA_MCDMA_REG2; 


end generate MCDMA_BD_FETCH;

---------------------------------------------------------------------------
-- For 32-bit SG addresses then drive zero on msb
---------------------------------------------------------------------------
GEN_CURDESC_32 : if C_M_AXI_SG_ADDR_WIDTH = 32 generate
begin
    msb_curdesc <= (others => '0');
end generate  GEN_CURDESC_32;

---------------------------------------------------------------------------
-- For 64-bit SG addresses then capture upper order adder to msb
---------------------------------------------------------------------------
GEN_CURDESC_64 : if C_M_AXI_SG_ADDR_WIDTH = 64 generate
begin
    CAPTURE_CURADDR : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    msb_curdesc <= (others => '0');
                elsif(ftch_cmnd_wr = '1')then
                    msb_curdesc <= ftch_cmnd_data(DATAMOVER_CMD_ADDRMSB_BOFST
                                                    + C_M_AXI_SG_ADDR_WIDTH
                                                    downto DATAMOVER_CMD_ADDRMSB_BOFST
                                                    + DATAMOVER_CMD_ADDRLSB_BIT + 1);
                end if;
            end if;
        end process CAPTURE_CURADDR;
end generate  GEN_CURDESC_64;


---------------------------------------------------------------------------
-- Write lower order Next Descriptor Pointer out to pntr_mngr
---------------------------------------------------------------------------
REG_LSB_NXTPNTR : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0' )then
                nxtdesc_int(31 downto 0)    <= (others => '0');

            -- On valid and word count at 0 and channel active capture LSB next pointer
            elsif(m_axis_mm2s_tvalid = '1' and counter (0) = '1')then
                nxtdesc_int(31 downto 6)    <= m_axis_mm2s_tdata (31 downto 6);
                -- BD addresses are always 16 word 32-bit aligned
                nxtdesc_int(5 downto 0)     <= (others => '0');

            end if;
        end if;
    end process REG_LSB_NXTPNTR;

lsbnxtdesc_tready <= '1' when m_axis_mm2s_tvalid = '1'
                          and counter (0) = '1' --etch_word_count = WORD_ZERO
                    else '0';

---------------------------------------------------------------------------
-- 64 Bit Scatter Gather addresses enabled
---------------------------------------------------------------------------
GEN_UPPER_MSB_NXTDESC : if C_ACTUAL_ADDR = 64 generate
begin
    ---------------------------------------------------------------------------
    -- Write upper order Next Descriptor Pointer out to pntr_mngr
    ---------------------------------------------------------------------------
    REG_MSB_NXTPNTR : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0' )then
                    nxtdesc_int(63 downto 32)   <= (others => '0');
                    ch1_nxtdesc_wren            <= '0';
                    ch2_nxtdesc_wren            <= '0';
                -- Capture upper pointer, drive ready to progress DataMover
                -- and also write nxtdesc out
                elsif(m_axis_mm2s_tvalid = '1' and counter (1) = '1') then -- etch_word_count = WORD_ONE)then
                    nxtdesc_int(63 downto 32)   <= m_axis_mm2s_tdata;
                    ch1_nxtdesc_wren            <= ch1_ftch_active;
                    ch2_nxtdesc_wren            <= ch2_ftch_active;
                -- Assert tready/wren for only 1 clock
                else
                    ch1_nxtdesc_wren            <= '0';
                    ch2_nxtdesc_wren            <= '0';
                end if;
            end if;
        end process REG_MSB_NXTPNTR;

    msbnxtdesc_tready <= '1' when m_axis_mm2s_tvalid = '1'
                              and counter (1) = '1' --fetch_word_count = WORD_ONE
                        else '0';


end generate GEN_UPPER_MSB_NXTDESC;


GEN_UPPER_MSB_NXTDESC2 : if C_ACTUAL_ADDR > 32 and C_ACTUAL_ADDR < 64 generate
begin
    ---------------------------------------------------------------------------
    -- Write upper order Next Descriptor Pointer out to pntr_mngr
    ---------------------------------------------------------------------------
    REG_MSB_NXTPNTR : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0' )then
                    nxtdesc_int(C_ACTUAL_ADDR-1 downto 32)   <= (others => '0');
                    ch1_nxtdesc_wren            <= '0';
                    ch2_nxtdesc_wren            <= '0';
                -- Capture upper pointer, drive ready to progress DataMover
                -- and also write nxtdesc out
                elsif(m_axis_mm2s_tvalid = '1' and counter (1) = '1') then -- etch_word_count = WORD_ONE)then
                    nxtdesc_int(C_ACTUAL_ADDR-1 downto 32)   <= m_axis_mm2s_tdata (C_ACTUAL_ADDR-32-1 downto 0);
                    ch1_nxtdesc_wren            <= ch1_ftch_active;
                    ch2_nxtdesc_wren            <= ch2_ftch_active;
                -- Assert tready/wren for only 1 clock
                else
                    ch1_nxtdesc_wren            <= '0';
                    ch2_nxtdesc_wren            <= '0';
                end if;
            end if;
        end process REG_MSB_NXTPNTR;

   nxtdesc_int (63 downto C_ACTUAL_ADDR) <= (others => '0');

    msbnxtdesc_tready <= '1' when m_axis_mm2s_tvalid = '1'
                              and counter (1) = '1' --fetch_word_count = WORD_ONE
                        else '0';


end generate GEN_UPPER_MSB_NXTDESC2;


---------------------------------------------------------------------------
-- 32 Bit Scatter Gather addresses enabled
---------------------------------------------------------------------------
GEN_NO_UPR_MSB_NXTDESC : if C_M_AXI_SG_ADDR_WIDTH = 32 generate
begin

    -----------------------------------------------------------------------
    -- No upper order therefore dump fetched word and write pntr lower next
    -- pointer to pntr mngr
    -----------------------------------------------------------------------
    REG_MSB_NXTPNTR : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0' )then
                    ch1_nxtdesc_wren            <= '0';
                    ch2_nxtdesc_wren            <= '0';
                -- Throw away second word but drive ready to progress DataMover
                -- and also write nxtdesc out
                elsif(m_axis_mm2s_tvalid = '1' and counter (1) = '1') then --fetch_word_count = WORD_ONE)then
                    ch1_nxtdesc_wren            <= ch1_ftch_active;
                    ch2_nxtdesc_wren            <= ch2_ftch_active;
                -- Assert for only 1 clock
                else
                    ch1_nxtdesc_wren            <= '0';
                    ch2_nxtdesc_wren            <= '0';
                end if;
            end if;
        end process REG_MSB_NXTPNTR;

    msbnxtdesc_tready <= '1' when m_axis_mm2s_tvalid = '1'
                              and counter (1) = '1' --fetch_word_count = WORD_ONE
                    else '0';


end generate GEN_NO_UPR_MSB_NXTDESC;

-- Drive ready to DataMover for ether lsb or msb capture
nxtdesc_tready  <= msbnxtdesc_tready or lsbnxtdesc_tready;

-- Generate logic for checking stale descriptor
GEN_STALE_DESC_CHECK : if C_SG_CH1_ENBL_STALE_ERROR = 1 or C_SG_CH2_ENBL_STALE_ERROR = 1 generate
begin

    ---------------------------------------------------------------------------
    -- Examine Completed BIT to determine if stale descriptor fetched
    ---------------------------------------------------------------------------
    CMPLTD_CHECK : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0' )then
                    ftch_stale_desc <= '0';
                -- On valid and word count at 0 and channel active capture LSB next pointer
                elsif(m_axis_mm2s_tvalid = '1' and counter (7) = '1'   --fetch_word_count = WORD_SEVEN
                and m_axis_mm2s_tready_i = '1'
                and m_axis_mm2s_tdata(DESC_STS_CMPLTD_BIT) = '1' )then
                    ftch_stale_desc <= '1' and (not cyclic_enable);
                else
                    ftch_stale_desc <= '0';
                end if;
            end if;
        end process CMPLTD_CHECK;

end generate GEN_STALE_DESC_CHECK;

-- No needed logic for checking stale descriptor
GEN_NO_STALE_CHECK : if C_SG_CH1_ENBL_STALE_ERROR = 0 and C_SG_CH2_ENBL_STALE_ERROR = 0 generate
begin
    ftch_stale_desc <= '0';
end generate GEN_NO_STALE_CHECK;

    ---------------------------------------------------------------------------
    -- SG Queueing therefore pass stream signals to
    -- FIFO
    ---------------------------------------------------------------------------
    GEN_QUEUE : if C_SG_FTCH_DESC2QUEUE /= 0 generate
    begin
        -- Instantiate the queue version
        FTCH_QUEUE_I : entity  axi_sg_v4_1_2.axi_sg_ftch_queue
            generic map(
                C_M_AXI_SG_ADDR_WIDTH       => C_M_AXI_SG_ADDR_WIDTH        ,
                C_M_AXIS_SG_TDATA_WIDTH     => C_M_AXIS_SG_TDATA_WIDTH      ,
                C_SG_FTCH_DESC2QUEUE        => C_SG_FTCH_DESC2QUEUE         ,
                C_SG_WORDS_TO_FETCH         => C_SG_CH1_WORDS_TO_FETCH      ,
                C_AXIS_IS_ASYNC             => C_AXIS_IS_ASYNC              ,
                C_ASYNC             => C_ASYNC              ,
                C_FAMILY                    => C_FAMILY                     , 
                C_SG2_WORDS_TO_FETCH        => C_SG_CH2_WORDS_TO_FETCH      ,
                C_INCLUDE_MM2S              => C_INCLUDE_CH1,
                C_INCLUDE_S2MM              => C_INCLUDE_CH2,
                C_ENABLE_CDMA               => C_ENABLE_CDMA,
                C_ENABLE_MULTI_CHANNEL      => C_ENABLE_MULTI_CHANNEL       
            )
            port map(
                -----------------------------------------------------------------------
                -- AXI Scatter Gather Interface
                -----------------------------------------------------------------------
                m_axi_sg_aclk               => m_axi_sg_aclk                ,
                m_axi_primary_aclk          => m_axi_mm2s_aclk ,
                m_axi_sg_aresetn            => m_axi_sg_aresetn             ,
                p_reset_n                   => p_reset_n                    , 
                ch2_sg_idle                 => '0'                          ,

                -- Channel Control
                desc1_flush                  => ch1_desc_flush               ,
                desc2_flush                  => ch2_desc_flush               ,
                ch1_cntrl_strm_stop          => ch1_cntrl_strm_stop          ,
                ftch1_active                 => ch1_ftch_active              ,
                ftch2_active                 => ch2_ftch_active              ,
                ftch1_queue_empty            => ch1_ftch_queue_empty         ,
                ftch2_queue_empty            => ch2_ftch_queue_empty         ,
                ftch1_queue_full             => ch1_ftch_queue_full          ,
                ftch2_queue_full             => ch2_ftch_queue_full          ,
                ftch1_pause                  => ch1_ftch_pause               ,
                ftch2_pause                  => ch2_ftch_pause               ,

                writing_nxtdesc_in          => nxtdesc_tready               ,
                writing1_curdesc_out         => ch1_writing_curdesc          ,
                writing2_curdesc_out         => ch2_writing_curdesc          ,

                -- DataMover Command
                ftch_cmnd_wr                => ftch_cmnd_wr                 ,
                ftch_cmnd_data              => ftch_cmnd_data               ,

                -- MM2S Stream In from DataMover
                m_axis_mm2s_tdata           => m_axis_mm2s_tdata            ,
                m_axis_mm2s_tlast           => m_axis_mm2s_tlast            ,
                m_axis_mm2s_tvalid          => m_axis_mm2s_tvalid           ,
                sof_ftch_desc               => sof_ftch_desc                ,
                next_bd                     => nxtdesc_int                     ,
                data_concat_64              => data_concat_64,
                data_concat_64_cdma         => data_concat_64_cdma,
                data_concat                 => data_concat,
                data_concat_mcdma           => data_concat_mcdma,
                data_concat_valid           => data_concat_valid,
                data_concat_tlast           => data_concat_tlast,

                m_axis1_mm2s_tready         => ch1_ftch_tready              ,
                m_axis2_mm2s_tready         => ch2_ftch_tready              ,

                -- Channel 1 AXI Fetch Stream Out
                m_axis_ftch_aclk            => m_axi_sg_aclk, --m_axis_ch_ftch_aclk         ,
                m_axis_ftch1_tdata           => m_axis_ch1_ftch_tdata        ,
                m_axis_ftch1_tvalid          => m_axis_ch1_ftch_tvalid       ,
                m_axis_ftch1_tready          => m_axis_ch1_ftch_tready       ,
                m_axis_ftch1_tlast           => m_axis_ch1_ftch_tlast        ,

                m_axis_ftch1_tdata_new           => m_axis_ch1_ftch_tdata_new        ,
                m_axis_ftch1_tdata_mcdma_new           => m_axis_ch1_ftch_tdata_mcdma_new        ,
                m_axis_ftch1_tvalid_new          => m_axis_ch1_ftch_tvalid_new       ,
                m_axis_ftch1_desc_available  => m_axis_ftch1_desc_available ,

                m_axis_ftch2_tdata_new           => m_axis_ch2_ftch_tdata_new        ,
                m_axis_ftch2_tdata_mcdma_new           => m_axis_ch2_ftch_tdata_mcdma_new        ,
                m_axis_ftch2_tvalid_new          => m_axis_ch2_ftch_tvalid_new       ,
                m_axis_ftch2_desc_available  => m_axis_ftch2_desc_available ,

                m_axis_ftch2_tdata           => m_axis_ch2_ftch_tdata        ,
                m_axis_ftch2_tvalid          => m_axis_ch2_ftch_tvalid       ,
                m_axis_ftch2_tready          => m_axis_ch2_ftch_tready       ,
                m_axis_ftch2_tlast           => m_axis_ch2_ftch_tlast        ,
                  
                m_axis_mm2s_cntrl_tdata  => m_axis_mm2s_cntrl_tdata  ,
                m_axis_mm2s_cntrl_tkeep  => m_axis_mm2s_cntrl_tkeep  ,
                m_axis_mm2s_cntrl_tvalid => m_axis_mm2s_cntrl_tvalid ,
                m_axis_mm2s_cntrl_tready => m_axis_mm2s_cntrl_tready ,
                m_axis_mm2s_cntrl_tlast  => m_axis_mm2s_cntrl_tlast  

            );


    m_axis_ch2_ftch_tdata_mcdma_nxt <= (others => '0');

    end generate GEN_QUEUE;

    -- No SG Queueing therefore pass stream signals straight
    -- out channel port

    -- No SG Queueing therefore pass stream signals straight
    -- out channel port
    GEN_NO_QUEUE : if C_SG_FTCH_DESC2QUEUE = 0 generate
    begin
        -- Instantiate the No queue version
        NO_FTCH_QUEUE_I : entity  axi_sg_v4_1_2.axi_sg_ftch_noqueue
            generic map (
                C_M_AXI_SG_ADDR_WIDTH       => C_M_AXI_SG_ADDR_WIDTH,
                C_M_AXIS_SG_TDATA_WIDTH     => C_M_AXIS_SG_TDATA_WIDTH,
                C_ENABLE_MULTI_CHANNEL      => C_ENABLE_MULTI_CHANNEL,
                C_AXIS_IS_ASYNC             => C_AXIS_IS_ASYNC              ,
                C_ASYNC             => C_ASYNC              ,
                C_FAMILY                    => C_FAMILY                     ,
                C_SG_WORDS_TO_FETCH         => C_SG_CH1_WORDS_TO_FETCH      ,
                C_ENABLE_CDMA               => C_ENABLE_CDMA,
                C_ENABLE_CH1                => C_INCLUDE_CH1
            )
            port map(
                -----------------------------------------------------------------------
                -- AXI Scatter Gather Interface
                -----------------------------------------------------------------------
                m_axi_sg_aclk               => m_axi_sg_aclk                ,
                m_axi_primary_aclk          => m_axi_mm2s_aclk ,
                m_axi_sg_aresetn            => m_axi_sg_aresetn             ,
                p_reset_n                   => p_reset_n                    ,

                -- Channel Control
                desc_flush                  => ch1_desc_flush               ,
                ch1_cntrl_strm_stop         => ch1_cntrl_strm_stop          ,
                ftch_active                 => ch1_ftch_active              ,
                ftch_queue_empty            => ch1_ftch_queue_empty         ,
                ftch_queue_full             => ch1_ftch_queue_full          ,

                desc2_flush                  => ch2_desc_flush               ,
                ftch2_active                 => ch2_ftch_active              ,
                ftch2_queue_empty            => ch2_ftch_queue_empty         ,
                ftch2_queue_full             => ch2_ftch_queue_full          ,

                writing_nxtdesc_in          => nxtdesc_tready               ,
                writing_curdesc_out         => ch1_writing_curdesc          ,
                writing2_curdesc_out         => ch2_writing_curdesc          ,

                -- DataMover Command
                ftch_cmnd_wr                => ftch_cmnd_wr                 ,
                ftch_cmnd_data              => ftch_cmnd_data               ,

                -- MM2S Stream In from DataMover
                m_axis_mm2s_tdata           => m_axis_mm2s_tdata            ,
                m_axis_mm2s_tlast           => m_axis_mm2s_tlast            ,
                m_axis_mm2s_tvalid          => m_axis_mm2s_tvalid           ,
                m_axis_mm2s_tready          => ch1_ftch_tready              ,
                m_axis2_mm2s_tready         => ch2_ftch_tready              ,

                sof_ftch_desc               => sof_ftch_desc                ,

                next_bd                     => nxtdesc_int                     ,
                data_concat_64              => data_concat_64,
                data_concat                 => data_concat,
                data_concat_mcdma           => data_concat_mcdma,
                data_concat_valid           => data_concat_valid,
                data_concat_tlast           => data_concat_tlast,

                -- Channel 1 AXI Fetch Stream Out
                m_axis_ftch_tdata           => m_axis_ch1_ftch_tdata        ,
                m_axis_ftch_tvalid          => m_axis_ch1_ftch_tvalid       ,
                m_axis_ftch_tready          => m_axis_ch1_ftch_tready       ,
                m_axis_ftch_tlast           => m_axis_ch1_ftch_tlast        ,

                m_axis_ftch_tdata_new           => m_axis_ch1_ftch_tdata_new        ,
                m_axis_ftch_tdata_mcdma_new           => m_axis_ch1_ftch_tdata_mcdma_new        ,
                m_axis_ftch_tvalid_new          => m_axis_ch1_ftch_tvalid_new       ,
                m_axis_ftch_desc_available  => m_axis_ftch1_desc_available ,

                m_axis2_ftch_tdata_new           => m_axis_ch2_ftch_tdata_new        ,
                m_axis2_ftch_tdata_mcdma_new           => m_axis_ch2_ftch_tdata_mcdma_new        ,
                m_axis2_ftch_tdata_mcdma_nxt           => m_axis_ch2_ftch_tdata_mcdma_nxt        ,
                m_axis2_ftch_tvalid_new          => m_axis_ch2_ftch_tvalid_new       ,
                m_axis2_ftch_desc_available  => m_axis_ftch2_desc_available ,

                m_axis2_ftch_tdata           => m_axis_ch2_ftch_tdata        ,
                m_axis2_ftch_tvalid          => m_axis_ch2_ftch_tvalid       ,
                m_axis2_ftch_tready          => m_axis_ch2_ftch_tready       ,
                m_axis2_ftch_tlast           => m_axis_ch2_ftch_tlast        ,

                m_axis_mm2s_cntrl_tdata  => m_axis_mm2s_cntrl_tdata  ,
                m_axis_mm2s_cntrl_tkeep  => m_axis_mm2s_cntrl_tkeep  ,
                m_axis_mm2s_cntrl_tvalid => m_axis_mm2s_cntrl_tvalid ,
                m_axis_mm2s_cntrl_tready => m_axis_mm2s_cntrl_tready ,
                m_axis_mm2s_cntrl_tlast  => m_axis_mm2s_cntrl_tlast
            );

        ch1_ftch_pause          <= '0';
        ch2_ftch_pause          <= '0';

    end generate GEN_NO_QUEUE;



-------------------------------------------------------------------------------
-- DataMover TREADY MUX
-------------------------------------------------------------------------------
writing_curdesc <= ch1_writing_curdesc or ch2_writing_curdesc or ftch_cmnd_wr;


TREADY_MUX : process(writing_curdesc,
                     fetch_word_count,
                     nxtdesc_tready,

                     -- channel 1 signals
                     ch1_ftch_active,
                     ch1_desc_flush,
                     ch1_ftch_tready,

                     -- channel 2 signals
                     ch2_ftch_active,
                     ch2_desc_flush,
                     counter(0),
                     counter(1),
                     ch2_ftch_tready)
    begin
        -- If commmanded to flush descriptor then assert ready
        -- to datamover until active de-asserts.  this allows
        -- any commanded fetches to complete.
        if( (ch1_desc_flush = '1' and ch1_ftch_active = '1')
          or(ch2_desc_flush = '1' and ch2_ftch_active = '1'))then
            m_axis_mm2s_tready_i <= '1';

        -- NOT ready if cmnd being written because
        -- curdesc gets written to queue
        elsif(writing_curdesc = '1')then
            m_axis_mm2s_tready_i <= '0';

        -- First two words drive ready from internal logic
        elsif(counter(0) = '1' or counter(1)='1')then
            m_axis_mm2s_tready_i <= nxtdesc_tready;

        -- Remainder stream words drive ready from channel input
        else
            m_axis_mm2s_tready_i <= (ch1_ftch_active and ch1_ftch_tready)
                                 or (ch2_ftch_active and ch2_ftch_tready);
        end if;
    end process TREADY_MUX;

m_axis_mm2s_tready    <= m_axis_mm2s_tready_i;





end implementation;
