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
-- Filename:          axi_sg_ftch_noqueue.vhd
-- Description: This entity is the no queue version
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
entity  axi_sg_ftch_noqueue is
    generic (
        C_M_AXI_SG_ADDR_WIDTH       : integer range 32 to 64        := 32;
            -- Master AXI Memory Map Address Width

        C_M_AXIS_SG_TDATA_WIDTH     : integer range 32 to 32        := 32;
            -- Master AXI Stream Data Width

        C_ENABLE_MULTI_CHANNEL      : integer range 0 to 1          := 0;

        C_AXIS_IS_ASYNC             : integer range 0 to 1      := 0;
        C_ASYNC             : integer range 0 to 1      := 0;

        C_SG_WORDS_TO_FETCH : integer range 8 to 13                 := 8;

        C_ENABLE_CDMA  : integer range 0 to 1                       := 0;

        C_ENABLE_CH1        : integer range 0 to 1                  := 0;

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
                                                                                                --
        -- Channel Control                                                                    --
        desc_flush                  : in  std_logic                         ;                   --
        ch1_cntrl_strm_stop         : in  std_logic                         ;
        ftch_active                 : in  std_logic                         ;                   --
        ftch_queue_empty            : out std_logic                         ;                   --
        ftch_queue_full             : out std_logic                         ;                   --

        sof_ftch_desc               : in  std_logic                         ;

        desc2_flush                  : in  std_logic                         ;                   --
        ftch2_active                 : in  std_logic                         ;                   --
        ftch2_queue_empty            : out std_logic                         ;                   --
        ftch2_queue_full             : out std_logic                         ;                   --
                                                                                                --
        writing_nxtdesc_in          : in  std_logic                         ;                   --
        writing_curdesc_out         : out std_logic                         ;                   --
        writing2_curdesc_out         : out std_logic                         ;                   --

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
        m_axis_mm2s_tready          : out std_logic                         ;                   --
        m_axis2_mm2s_tready          : out std_logic                         ;                   --

        data_concat           : in  std_logic_vector                                      --
                                        (95 downto 0) ;                  --
        data_concat_64           : in  std_logic_vector                                      --
                                        (31 downto 0) ;                  --
        data_concat_mcdma           : in  std_logic_vector                                      --
                                        (63 downto 0) ;                  --
        next_bd                     : in std_logic_vector (C_M_AXI_SG_ADDR_WIDTH-1 downto 0);
        data_concat_tlast           : in  std_logic                         ;                   --
        data_concat_valid          : in  std_logic                         ;                   --
                                                                                                --
        -- Channel 1 AXI Fetch Stream Out                                                       --
        m_axis_ftch_tdata           : out std_logic_vector                                      --
                                            (C_M_AXIS_SG_TDATA_WIDTH-1 downto 0) ;              --
        m_axis_ftch_tvalid          : out std_logic                         ;                   --
        m_axis_ftch_tready          : in  std_logic                         ;                   --
        m_axis_ftch_tlast           : out std_logic                         ;                    --

        m_axis_ftch_tdata_new           : out std_logic_vector                                      --
                                        (96+31*C_ENABLE_CDMA+(2+C_ENABLE_CDMA)*(C_M_AXI_SG_ADDR_WIDTH-32) downto 0);                   --
        m_axis_ftch_tdata_mcdma_new           : out std_logic_vector                                      --
                                        (63 downto 0);                   --
        m_axis_ftch_tvalid_new          : out std_logic                         ;                   --
        m_axis_ftch_desc_available            : out std_logic                     ;

        m_axis2_ftch_tdata           : out std_logic_vector                                      --
                                            (C_M_AXIS_SG_TDATA_WIDTH-1 downto 0) ;              --
        m_axis2_ftch_tvalid          : out std_logic                         ;                   --
        m_axis2_ftch_tready          : in  std_logic                         ;                   --
        m_axis2_ftch_tlast           : out std_logic                         ;                    --
        m_axis2_ftch_tdata_new           : out std_logic_vector                                      --
                                        (96+31*C_ENABLE_CDMA+(2+C_ENABLE_CDMA)*(C_M_AXI_SG_ADDR_WIDTH-32) downto 0);                   --
        m_axis2_ftch_tdata_mcdma_new           : out std_logic_vector                                      --
                                        (63 downto 0);                   --
        m_axis2_ftch_tdata_mcdma_nxt           : out std_logic_vector                                      --
                                        (C_M_AXI_SG_ADDR_WIDTH-1 downto 0);                   --
        m_axis2_ftch_tvalid_new          : out std_logic                         ;                   --
        m_axis2_ftch_desc_available            : out std_logic                   ;

        m_axis_mm2s_cntrl_tdata     : out std_logic_vector                                 --
                                        (31 downto 0);      --
        m_axis_mm2s_cntrl_tkeep     : out std_logic_vector                                 --
                                        (3 downto 0);  --
        m_axis_mm2s_cntrl_tvalid    : out std_logic                         ;              --
        m_axis_mm2s_cntrl_tready    : in  std_logic                         := '0';              --
        m_axis_mm2s_cntrl_tlast     : out std_logic                                       --
  


    );

end axi_sg_ftch_noqueue;

-------------------------------------------------------------------------------
-- Architecture
-------------------------------------------------------------------------------
architecture implementation of axi_sg_ftch_noqueue is
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
-- Channel 1 internal signals
signal curdesc_tdata            : std_logic_vector
                                    (C_M_AXIS_SG_TDATA_WIDTH-1 downto 0) := (others => '0');
signal curdesc_tvalid           : std_logic := '0';
signal ftch_tvalid              : std_logic := '0';
signal ftch_tdata               : std_logic_vector
                                    (C_M_AXIS_SG_TDATA_WIDTH-1 downto 0) := (others => '0');
signal ftch_tlast               : std_logic := '0';
signal ftch_tready              : std_logic := '0';

-- Misc Signals
signal writing_curdesc          : std_logic := '0';
signal writing_nxtdesc          : std_logic := '0';
signal msb_curdesc              : std_logic_vector(31 downto 0) := (others => '0');
signal ftch_tdata_new_64        : std_logic_vector (C_M_AXI_SG_ADDR_WIDTH-1 downto 0);

signal writing_lsb              : std_logic := '0';
signal writing_msb              : std_logic := '0';

signal ftch_active_int : std_logic := '0';

signal ftch_tvalid_mult              : std_logic := '0';
signal ftch_tdata_mult               : std_logic_vector
                                    (C_M_AXIS_SG_TDATA_WIDTH-1 downto 0) := (others => '0');
signal ftch_tlast_mult               : std_logic := '0';

signal counter : std_logic_vector (3 downto 0) := (others => '0');
signal wr_cntl : std_logic := '0';

signal ftch_tdata_new : std_logic_vector (96+31*C_ENABLE_CDMA downto 0);

signal queue_wren, queue_rden : std_logic := '0';
signal queue_din : std_logic_vector (32 downto 0);
signal queue_dout : std_logic_vector (32 downto 0);
signal queue_empty, queue_full : std_logic := '0';

signal sof_ftch_desc_del, sof_ftch_desc_pulse : std_logic := '0';
signal sof_ftch_desc_del1 : std_logic := '0';
signal queue_sinit : std_logic := '0';
signal data_concat_mcdma_nxt : std_logic_vector (C_M_AXI_SG_ADDR_WIDTH-1 downto 0) := (others => '0');
signal current_bd : std_logic_vector (C_M_AXI_SG_ADDR_WIDTH-1 downto 0) := (others => '0');

-------------------------------------------------------------------------------
-- Begin architecture logic
-------------------------------------------------------------------------------
begin

queue_sinit <= not m_axi_sg_aresetn;

ftch_active_int <= ftch_active or ftch2_active;



ftch_tdata_new (64 downto 0) <= data_concat (95) & data_concat (63 downto 0);-- when (ftch_active = '1') else (others =>'0');
ftch_tdata_new (96 downto 65) <= current_bd (31 downto 0);


ADDR641 : if C_M_AXI_SG_ADDR_WIDTH > 32 generate
begin

ftch_tdata_new_64 <= data_concat_64 & current_bd (C_M_AXI_SG_ADDR_WIDTH-1 downto 32);

end generate ADDR641;


---------------------------------------------------------------------------
-- Write current descriptor to FIFO or out channel port
---------------------------------------------------------------------------

NXT_BD_MCDMA : if C_ENABLE_MULTI_CHANNEL = 1 generate
begin

NEXT_BD_S2MM : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0' )then
              data_concat_mcdma_nxt       <= (others => '0');
            elsif (ftch2_active = '1') then
              data_concat_mcdma_nxt <= next_bd; 
            end if;
        end if;
end process NEXT_BD_S2MM;

end generate NXT_BD_MCDMA;

WRITE_CURDESC_PROCESS : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0' )then
              current_bd       <= (others => '0');
--
--            -- Write LSB Address on command write
            elsif(ftch_cmnd_wr = '1' and ftch_active_int = '1')then

               current_bd       <= ftch_cmnd_data((C_M_AXI_SG_ADDR_WIDTH-32)+DATAMOVER_CMD_ADDRMSB_BOFST
                                                        + DATAMOVER_CMD_ADDRLSB_BIT
                                                        downto DATAMOVER_CMD_ADDRLSB_BIT);
            end if;
        end if;
    end process WRITE_CURDESC_PROCESS;

GEN_MULT_CHANNEL : if C_ENABLE_MULTI_CHANNEL = 1 generate
begin
            ftch_tvalid_mult  <= m_axis_mm2s_tvalid;
            ftch_tdata_mult   <= m_axis_mm2s_tdata;
            ftch_tlast_mult   <= m_axis_mm2s_tlast;
            wr_cntl <= m_axis_mm2s_tvalid;


        m_axis_mm2s_cntrl_tdata  <= (others => '0');
        m_axis_mm2s_cntrl_tkeep  <= "0000";
        m_axis_mm2s_cntrl_tvalid <= '0';
        m_axis_mm2s_cntrl_tlast  <= '0';

end generate GEN_MULT_CHANNEL;

GEN_NOMULT_CHANNEL : if C_ENABLE_MULTI_CHANNEL = 0 generate
begin
            ftch_tvalid_mult  <= '0'; --m_axis_mm2s_tvalid;
            ftch_tdata_mult   <= (others => '0'); --m_axis_mm2s_tdata;
            ftch_tlast_mult   <= '0'; --m_axis_mm2s_tlast;


CONTROL_STREAM : if C_SG_WORDS_TO_FETCH = 13 and C_ENABLE_CH1 = 1  generate
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
            if(m_axi_sg_aresetn = '0' or m_axis_mm2s_tlast = '1')then
                sof_ftch_desc_del1 <= '0';
            elsif (m_axis_mm2s_tvalid = '1') then
                sof_ftch_desc_del1 <= sof_ftch_desc;
            end if;
        end if;
   end process SOF_DEL1_PROCESS;

sof_ftch_desc_pulse <= sof_ftch_desc and (not sof_ftch_desc_del1);


queue_wren  <= not queue_full
               and sof_ftch_desc
               and m_axis_mm2s_tvalid
               and ftch_active;

queue_rden  <= not queue_empty
               and m_axis_mm2s_cntrl_tready;

queue_din(C_M_AXIS_SG_TDATA_WIDTH)               <= m_axis_mm2s_tlast;
queue_din(C_M_AXIS_SG_TDATA_WIDTH-1 downto 0)    <= x"A0000000" when (sof_ftch_desc_pulse = '1') else m_axis_mm2s_tdata;




        I_MM2S_CNTRL_STREAM : entity axi_sg_v4_1_2.axi_sg_cntrl_strm
            generic map(
                C_PRMRY_IS_ACLK_ASYNC           => C_ASYNC           ,
                C_PRMY_CMDFIFO_DEPTH            => 16, --FETCH_QUEUE_DEPTH             ,
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


NO_CONTROL_STREAM : if C_SG_WORDS_TO_FETCH /= 13 or C_ENABLE_CH1 = 0 generate
begin

        m_axis_mm2s_cntrl_tdata  <= (others => '0');
        m_axis_mm2s_cntrl_tkeep  <= "0000";
        m_axis_mm2s_cntrl_tvalid <= '0';
        m_axis_mm2s_cntrl_tlast  <= '0';

end generate NO_CONTROL_STREAM;


end generate GEN_NOMULT_CHANNEL;



---------------------------------------------------------------------------
-- Map internal stream to external
---------------------------------------------------------------------------

ftch_tready             <= (m_axis_ftch_tready and ftch_active) or
                            (m_axis2_ftch_tready and ftch2_active);


ADDR64 : if C_M_AXI_SG_ADDR_WIDTH > 32 generate
begin
m_axis_ftch_tdata_new     <= ftch_tdata_new_64 & ftch_tdata_new;    

end generate ADDR64;


ADDR32 : if C_M_AXI_SG_ADDR_WIDTH = 32 generate
begin
m_axis_ftch_tdata_new     <= ftch_tdata_new;    

end generate ADDR32;

m_axis_ftch_tdata_mcdma_new     <= data_concat_mcdma;    
m_axis_ftch_tvalid_new    <= data_concat_valid and ftch_active; 
m_axis_ftch_desc_available <= data_concat_tlast and ftch_active; 



REG_FOR_STS_CNTRL : if C_SG_WORDS_TO_FETCH = 13 generate
begin

LATCH_PROCESS : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0')then
                m_axis2_ftch_tvalid_new    <= '0';
                m_axis2_ftch_desc_available <= '0';
            else
                m_axis2_ftch_tvalid_new    <= data_concat_valid and ftch2_active;
                m_axis2_ftch_desc_available <= data_concat_valid and ftch2_active;
            end if;
        end if;
   end process LATCH_PROCESS;

LATCH2_PROCESS : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
            if(m_axi_sg_aresetn = '0')then
                m_axis2_ftch_tdata_new    <= (others => '0');
            elsif (data_concat_valid = '1' and ftch2_active = '1') then
                m_axis2_ftch_tdata_new     <= ftch_tdata_new;
            end if;
        end if;
   end process LATCH2_PROCESS;

end generate REG_FOR_STS_CNTRL;

NO_REG_FOR_STS_CNTRL : if C_SG_WORDS_TO_FETCH /= 13 generate
begin

ADDR64 : if C_M_AXI_SG_ADDR_WIDTH > 32 generate
begin
m_axis2_ftch_tdata_new     <= ftch_tdata_new_64 & ftch_tdata_new;    

end generate ADDR64;


ADDR32 : if C_M_AXI_SG_ADDR_WIDTH = 32 generate
begin
m_axis2_ftch_tdata_new     <= ftch_tdata_new;    

end generate ADDR32;
                m_axis2_ftch_tvalid_new    <= data_concat_valid and ftch2_active;
                m_axis2_ftch_desc_available <= data_concat_valid and ftch2_active;

                m_axis2_ftch_tdata_mcdma_new     <= data_concat_mcdma;
                m_axis2_ftch_tdata_mcdma_nxt     <= data_concat_mcdma_nxt;

end generate NO_REG_FOR_STS_CNTRL;




m_axis_mm2s_tready      <= ftch_tready;
m_axis2_mm2s_tready      <= ftch_tready;

---------------------------------------------------------------------------
-- generate psuedo empty flag for Idle generation
---------------------------------------------------------------------------
Q_EMPTY_PROCESS : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk='1')then
            if(m_axi_sg_aresetn = '0' or desc_flush = '1')then
                ftch_queue_empty <= '1';

            -- Else on valid and ready modify empty flag
            elsif(ftch_tvalid = '1' and m_axis_ftch_tready = '1' and ftch_active = '1')then
                -- On last mark as empty
                if(ftch_tlast = '1' )then
                    ftch_queue_empty <= '1';
                -- Otherwise mark as not empty
                else
                    ftch_queue_empty <= '0';
                end if;
            end if;
        end if;
    end process Q_EMPTY_PROCESS;


Q2_EMPTY_PROCESS : process(m_axi_sg_aclk)
    begin
        if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk='1')then
            if(m_axi_sg_aresetn = '0' or desc2_flush = '1')then
                ftch2_queue_empty <= '1';

            -- Else on valid and ready modify empty flag
            elsif(ftch_tvalid = '1' and m_axis2_ftch_tready = '1' and ftch2_active = '1')then
                -- On last mark as empty
                if(ftch_tlast = '1' )then
                    ftch2_queue_empty <= '1';
                -- Otherwise mark as not empty
                else
                    ftch2_queue_empty <= '0';
                end if;
            end if;
        end if;
    end process Q2_EMPTY_PROCESS;

-- do not need to indicate full to axi_sg_ftch_sm.  Only
-- needed for queue case to allow other channel to be serviced
-- if it had queue room
ftch_queue_full <= '0';
ftch2_queue_full <= '0';

-- If writing curdesc out then flag for proper mux selection
writing_curdesc     <= curdesc_tvalid;
-- Map intnal signal to port
writing_curdesc_out <= writing_curdesc and ftch_active;
writing2_curdesc_out <= writing_curdesc and ftch2_active;
-- Map port to internal signal
writing_nxtdesc     <= writing_nxtdesc_in;


end implementation;
