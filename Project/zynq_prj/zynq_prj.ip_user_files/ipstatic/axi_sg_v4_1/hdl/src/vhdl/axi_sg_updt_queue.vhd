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
-- Filename:          axi_sg_updt_queue.vhd
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

library lib_srl_fifo_v1_0_2;
use lib_srl_fifo_v1_0_2.srl_fifo_f;

library lib_pkg_v1_0_2;
use lib_pkg_v1_0_2.lib_pkg.all;

-------------------------------------------------------------------------------
entity  axi_sg_updt_queue is
    generic (
        C_M_AXI_SG_ADDR_WIDTH       : integer range 32 to 64        := 32;
            -- Master AXI Memory Map Address Width for Scatter Gather R/W Port

        C_M_AXIS_UPDT_DATA_WIDTH    : integer range 32 to 32        := 32;
            -- Master AXI Memory Map Data Width for Scatter Gather R/W Port

        C_S_AXIS_UPDPTR_TDATA_WIDTH  : integer range 32 to 32        := 32;
            -- 32 Update Status Bits

        C_S_AXIS_UPDSTS_TDATA_WIDTH  : integer range 33 to 33        := 33;
            -- 1 IOC bit + 32 Update Status Bits

        C_SG_UPDT_DESC2QUEUE        : integer range 0 to 8          := 0;
            -- Number of descriptors to fetch and queue for each channel.
            -- A value of zero excludes the fetch queues.

        C_SG_WORDS_TO_UPDATE        : integer range 1 to 16         := 8;
            -- Number of words to update
        C_SG2_WORDS_TO_UPDATE        : integer range 1 to 16         := 8;
            -- Number of words to update

        C_AXIS_IS_ASYNC             : integer range 0 to 1          := 0;
            -- Channel 1 is async to sg_aclk
            -- 0 = Synchronous to SG ACLK
            -- 1 = Asynchronous to SG ACLK
        C_INCLUDE_MM2S              : integer range 0 to 1          := 0;

        C_INCLUDE_S2MM              : integer range 0 to 1          := 0;

        C_FAMILY                    : string            := "virtex7"
            -- Device family used for proper BRAM selection
    );
    port (
        -----------------------------------------------------------------------
        -- AXI Scatter Gather Interface
        -----------------------------------------------------------------------
        m_axi_sg_aclk               : in  std_logic                         ;              --
        m_axi_sg_aresetn            : in  std_logic                         ;              --
        s_axis_updt_aclk            : in  std_logic                         ;              --
                                                                                           --
        --********************************--                                               --
        --** Control and Status         **--                                               --
        --********************************--                                               --
        updt_curdesc_wren           : out std_logic                         ;              --
        updt_curdesc                : out std_logic_vector                                 --
                                        (C_M_AXI_SG_ADDR_WIDTH-1 downto 0)  ;              --
        updt_active                 : in  std_logic                         ;              --
        updt_queue_empty            : out std_logic                         ;              --
        updt_ioc                    : out std_logic                         ;              --
        updt_ioc_irq_set            : in  std_logic                         ;              --
                                                                                           --
        dma_interr                  : out std_logic                         ;              --
        dma_slverr                  : out std_logic                         ;              --
        dma_decerr                  : out std_logic                         ;              --
        dma_interr_set              : in  std_logic                         ;              --
        dma_slverr_set              : in  std_logic                         ;              --
        dma_decerr_set              : in  std_logic                         ;              --

        updt2_active                 : in  std_logic                         ;              --
        updt2_queue_empty            : out std_logic                         ;              --
        updt2_ioc                    : out std_logic                         ;              --
        updt2_ioc_irq_set            : in  std_logic                         ;              --
                                                                                           --
        dma2_interr                  : out std_logic                         ;              --
        dma2_slverr                  : out std_logic                         ;              --
        dma2_decerr                  : out std_logic                         ;              --
        dma2_interr_set              : in  std_logic                         ;              --
        dma2_slverr_set              : in  std_logic                         ;              --
        dma2_decerr_set              : in  std_logic                         ;              --
                                                                                           --
        --********************************--                                               --
        --** Update Interfaces In       **--                                               --
        --********************************--                                               --
        -- Update Pointer Stream                                                           --
        s_axis_updtptr_tdata        : in  std_logic_vector                                 --
                                        (C_M_AXI_SG_ADDR_WIDTH-1 downto 0);          --
        s_axis_updtptr_tvalid       : in  std_logic                         ;              --
        s_axis_updtptr_tready       : out std_logic                         ;              --
        s_axis_updtptr_tlast        : in  std_logic                         ;              --
                                                                                           --
        -- Update Status Stream                                                            --
        s_axis_updtsts_tdata        : in  std_logic_vector                                 --
                                        (C_S_AXIS_UPDSTS_TDATA_WIDTH-1 downto 0);           --
        s_axis_updtsts_tvalid       : in  std_logic                         ;              --
        s_axis_updtsts_tready       : out std_logic                         ;              --
        s_axis_updtsts_tlast        : in  std_logic                         ;              --

        s_axis2_updtptr_tdata        : in  std_logic_vector                                 --
                                        (C_M_AXI_SG_ADDR_WIDTH-1 downto 0);          --
        s_axis2_updtptr_tvalid       : in  std_logic                         ;              --
        s_axis2_updtptr_tready       : out std_logic                         ;              --
        s_axis2_updtptr_tlast        : in  std_logic                         ;              --
                                                                                           --
        -- Update Status Stream                                                            --
        s_axis2_updtsts_tdata        : in  std_logic_vector                                 --
                                        (C_S_AXIS_UPDSTS_TDATA_WIDTH-1 downto 0);           --
        s_axis2_updtsts_tvalid       : in  std_logic                         ;              --
        s_axis2_updtsts_tready       : out std_logic                         ;              --
        s_axis2_updtsts_tlast        : in  std_logic                         ;              --
                                                                                           --
        --********************************--                                               --
        --** Update Interfaces Out      **--                                               --
        --********************************--                                               --
        -- S2MM Stream Out To DataMover                                                    --
        m_axis_updt_tdata           : out std_logic_vector                                 --
                                        (C_M_AXIS_UPDT_DATA_WIDTH-1 downto 0);             --
        m_axis_updt_tlast           : out std_logic                         ;              --
        m_axis_updt_tvalid          : out std_logic                         ;              --
        m_axis_updt_tready          : in  std_logic                                       --


    );

end axi_sg_updt_queue;

-------------------------------------------------------------------------------
-- Architecture
-------------------------------------------------------------------------------
architecture implementation of axi_sg_updt_queue is
  attribute DowngradeIPIdentifiedWarnings: string;
  attribute DowngradeIPIdentifiedWarnings of implementation : architecture is "yes";



-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------

-- No Functions Declared

-------------------------------------------------------------------------------
-- Constants Declarations
-------------------------------------------------------------------------------
constant USE_LOGIC_FIFOS            : integer   := 0; -- Use Logic FIFOs
constant USE_BRAM_FIFOS             : integer   := 1; -- Use BRAM FIFOs

-- Number of words deep fifo needs to be. Depth required to store 2 word
-- porters for each descriptor is C_SG_UPDT_DESC2QUEUE x 2
--constant UPDATE_QUEUE_DEPTH         : integer := max2(16,C_SG_UPDT_DESC2QUEUE * 2);
constant UPDATE_QUEUE_DEPTH         : integer := max2(16,pad_power2(C_SG_UPDT_DESC2QUEUE * 2));



-- Width of fifo rd and wr counts - only used for proper fifo operation
constant UPDATE_QUEUE_CNT_WIDTH     : integer   := clog2(UPDATE_QUEUE_DEPTH+1);

-- Select between BRAM or LOGIC memory type
constant UPD_Q_MEMORY_TYPE          : integer := bo2int(UPDATE_QUEUE_DEPTH > 16);

-- Number of words deep fifo needs to be. Depth required to store all update
-- words is C_SG_UPDT_DESC2QUEUE x C_SG_WORDS_TO_UPDATE
constant UPDATE_STS_QUEUE_DEPTH     : integer := max2(16,pad_power2(C_SG_UPDT_DESC2QUEUE
                                                    * C_SG_WORDS_TO_UPDATE));

constant UPDATE_STS2_QUEUE_DEPTH     : integer := max2(16,pad_power2(C_SG_UPDT_DESC2QUEUE
                                                    * C_SG2_WORDS_TO_UPDATE));
-- Select between BRAM or LOGIC memory type
constant STS_Q_MEMORY_TYPE          : integer := bo2int(UPDATE_STS_QUEUE_DEPTH > 16);

-- Select between BRAM or LOGIC memory type
constant STS2_Q_MEMORY_TYPE          : integer := bo2int(UPDATE_STS2_QUEUE_DEPTH > 16);

-- Width of fifo rd and wr counts - only used for proper fifo operation
constant UPDATE_STS_QUEUE_CNT_WIDTH : integer := clog2(C_SG_UPDT_DESC2QUEUE+1);

-------------------------------------------------------------------------------
-- Signal / Type Declarations
-------------------------------------------------------------------------------
-- Channel signals
signal write_curdesc_lsb    : std_logic := '0';
signal write_curdesc_lsb_sm    : std_logic := '0';
signal write_curdesc_msb    : std_logic := '0';
signal write_curdesc_lsb1    : std_logic := '0';
signal write_curdesc_msb1    : std_logic := '0';
signal rden_del : std_logic := '0';
signal updt_active_d1       : std_logic := '0';
signal updt_active_d2       : std_logic := '0';
signal updt_active_re1       : std_logic := '0';
signal updt_active_re2       : std_logic := '0';
signal updt_active_re       : std_logic := '0';


type PNTR_STATE_TYPE      is (IDLE,
                              READ_CURDESC_LSB,
                              READ_CURDESC_MSB,
                              WRITE_STATUS
                              );

signal pntr_cs              : PNTR_STATE_TYPE;
signal pntr_ns              : PNTR_STATE_TYPE;

-- State Machine Signal
signal writing_status       : std_logic := '0';
signal dataq_rden           : std_logic := '0';
signal stsq_rden            : std_logic := '0';

-- Pointer Queue FIFO Signals
signal ptr_queue_rden       : std_logic := '0';
signal ptr_queue_wren       : std_logic := '0';
signal ptr_queue_empty      : std_logic := '0';
signal ptr_queue_full       : std_logic := '0';
signal ptr_queue_din        : std_logic_vector
                                (C_M_AXI_SG_ADDR_WIDTH-1 downto 0) := (others => '0');
signal ptr_queue_dout       : std_logic_vector
                                (C_M_AXI_SG_ADDR_WIDTH-1 downto 0) := (others => '0');
signal ptr_queue_dout_int       : std_logic_vector
                                (C_M_AXI_SG_ADDR_WIDTH-1 downto 0) := (others => '0');

-- Status Queue FIFO Signals
signal sts_queue_wren       : std_logic := '0';
signal sts_queue_rden       : std_logic := '0';
signal sts_queue_din        : std_logic_vector
                                (C_S_AXIS_UPDSTS_TDATA_WIDTH downto 0) := (others => '0');
signal sts_queue_dout       : std_logic_vector
                                (C_S_AXIS_UPDSTS_TDATA_WIDTH downto 0) := (others => '0');
signal sts_queue_dout_int       : std_logic_vector (3 downto 0) := (others => '0');
signal sts_queue_full       : std_logic := '0';
signal sts_queue_empty      : std_logic := '0';


signal ptr2_queue_rden       : std_logic := '0';
signal ptr2_queue_wren       : std_logic := '0';
signal ptr2_queue_empty      : std_logic := '0';
signal ptr2_queue_full       : std_logic := '0';
signal ptr2_queue_din        : std_logic_vector
                                (C_M_AXI_SG_ADDR_WIDTH-1 downto 0) := (others => '0');
signal ptr2_queue_dout       : std_logic_vector
                                (C_M_AXI_SG_ADDR_WIDTH-1 downto 0) := (others => '0');

-- Status Queue FIFO Signals
signal sts2_queue_wren       : std_logic := '0';
signal sts2_queue_rden       : std_logic := '0';
signal sts2_queue_din        : std_logic_vector
                                (C_S_AXIS_UPDSTS_TDATA_WIDTH downto 0) := (others => '0');
signal sts2_queue_dout       : std_logic_vector
                                (C_S_AXIS_UPDSTS_TDATA_WIDTH downto 0) := (others => '0');
signal sts2_queue_full       : std_logic := '0';
signal sts2_queue_empty      : std_logic := '0';
signal sts2_queue_empty_del      : std_logic := '0';
signal sts2_dout_valid       : std_logic := '0';
signal sts_dout_valid       : std_logic := '0';
signal sts2_dout_valid_del       : std_logic := '0';
signal valid_new       : std_logic := '0';
signal valid_latch       : std_logic := '0';
signal valid1_new       : std_logic := '0';
signal valid1_latch       : std_logic := '0';
signal empty_low       : std_logic := '0';

-- Misc Support Signals
signal writing_status_d1    : std_logic := '0';
signal writing_status_re    : std_logic := '0';
signal writing_status_re_ch1    : std_logic := '0';
signal writing_status_re_ch2    : std_logic := '0';
signal sinit                : std_logic := '0';
signal updt_tvalid          : std_logic := '0';
signal updt_tlast           : std_logic := '0';
signal updt2_tvalid          : std_logic := '0';
signal updt2_tlast           : std_logic := '0';

signal status_d1, status_d2 : std_logic := '0';
signal updt_tvalid_int : std_logic := '0';
signal updt_tlast_int : std_logic := '0';

signal ptr_queue_empty_int : std_logic := '0';
signal updt_active_int : std_logic := '0';

signal follower_reg_mm2s : std_logic_vector (33 downto 0) := (others => '0');
signal follower_full_mm2s :std_logic := '0';
signal follower_empty_mm2s : std_logic := '0'; 
signal follower_reg_s2mm : std_logic_vector (33 downto 0) := (others => '0');
signal follower_full_s2mm :std_logic := '0';
signal follower_empty_s2mm : std_logic := '0'; 

signal follower_reg, m_axis_updt_tdata_tmp : std_logic_vector (33 downto 0);
signal follower_full :std_logic := '0';
signal follower_empty : std_logic := '0'; 
signal sts_rden : std_logic := '0';
signal sts2_rden : std_logic := '0';
signal follower_tlast : std_logic := '0';
signal follower_reg_image : std_logic := '0';
signal m_axis_updt_tready_mm2s, m_axis_updt_tready_s2mm : std_logic := '0';
-------------------------------------------------------------------------------
-- Begin architecture logic
-------------------------------------------------------------------------------
begin


    m_axis_updt_tdata  <= follower_reg_mm2s (C_S_AXIS_UPDSTS_TDATA_WIDTH-2 downto 0) when updt_active = '1'
                          else follower_reg_s2mm (C_S_AXIS_UPDSTS_TDATA_WIDTH-2 downto 0) ;


    m_axis_updt_tvalid <= updt_tvalid when updt_active = '1'
                          else updt2_tvalid;

    m_axis_updt_tlast  <= updt_tlast when updt_active = '1'
                          else updt2_tlast;
    m_axis_updt_tready_mm2s <= m_axis_updt_tready when updt_active = '1' else '0';
    m_axis_updt_tready_s2mm <= m_axis_updt_tready when updt2_active = '1' else '0';


    -- Asset active strobe on rising edge of update active
    -- asertion.  This kicks off the update process for
    -- channel 1




    updt_active_re  <=  updt_active_re1 or updt_active_re2;

    -- Current Descriptor Pointer Fetch.  This state machine controls
    -- reading out the current pointer from the Queue or channel port
    -- and writing it to the update manager for use in command
    -- generation to the DataMover for Descriptor update.
    CURDESC_PNTR_STATE : process(pntr_cs,
                                 updt_active_re,
                                 ptr_queue_empty_int,
                                 m_axis_updt_tready,
                                 updt_tvalid_int,
                                 updt_tlast_int)
        begin

            write_curdesc_lsb_sm   <= '0';
            write_curdesc_msb   <= '0';
            writing_status      <= '0';
            dataq_rden          <= '0';
            stsq_rden           <= '0';
            pntr_ns             <= pntr_cs;

            case pntr_cs is

                when IDLE =>
                    if(updt_active_re = '1')then
                        pntr_ns <= READ_CURDESC_LSB;
                    else
                        pntr_ns <= IDLE;
                    end if;

                ---------------------------------------------------------------
                -- Get lower current descriptor pointer
                -- Reads one word from data queue fifo
                ---------------------------------------------------------------
                when READ_CURDESC_LSB =>
                    -- on tvalid from Queue or channel port then register
                    -- lsb curdesc and setup to register msb curdesc
                    if(ptr_queue_empty_int = '0')then
                        write_curdesc_lsb_sm   <= '1';
                        dataq_rden          <= '1';
                     --   pntr_ns             <= READ_CURDESC_MSB;
                        pntr_ns             <= WRITE_STATUS; --READ_CURDESC_MSB;
                    else
                    -- coverage off  
                        pntr_ns <= READ_CURDESC_LSB;
                    -- coverage on  
                    end if;

                ---------------------------------------------------------------
                -- Get upper current descriptor
                -- Reads one word from data queue fifo
                ---------------------------------------------------------------
--                when READ_CURDESC_MSB =>
                    -- On tvalid from Queue or channel port then register
                    -- msb.  This will also write curdesc out to update
                    -- manager.
--                    if(ptr_queue_empty_int = '0')then
--                        dataq_rden      <= '1';
--                        write_curdesc_msb   <= '1';
--                        pntr_ns         <= WRITE_STATUS;
--                    else
--                    -- coverage off  
--                        pntr_ns         <= READ_CURDESC_MSB;
--                    -- coverage on  
--                    end if;

                ---------------------------------------------------------------
                -- Hold in this state until remainder of descriptor is
                -- written out.
                when WRITE_STATUS =>
                    -- De-MUX appropriage tvalid/tlast signals
                    writing_status <= '1';

                    -- Enable reading of Status Queue if datamover can
                    -- accept data
                    stsq_rden      <= m_axis_updt_tready;

                    -- Hold in the status state until tlast is pulled
                    -- from status fifo
                    if(updt_tvalid_int = '1' and m_axis_updt_tready = '1'
                    and updt_tlast_int = '1')then
--                    if(follower_full = '1' and m_axis_updt_tready = '1'
--                    and follower_tlast = '1')then
                        pntr_ns     <= IDLE;
                    else
                        pntr_ns     <= WRITE_STATUS;
                    end if;

                    -- coverage off  
                when others =>
                    pntr_ns             <= IDLE;
                    -- coverage on  

            end case;
        end process CURDESC_PNTR_STATE;

updt_tvalid_int <= updt_tvalid or updt2_tvalid;
updt_tlast_int <= updt_tlast or updt2_tlast;

ptr_queue_empty_int <= ptr_queue_empty when updt_active = '1' else
                       ptr2_queue_empty when updt2_active = '1' else
                       '1';

    ---------------------------------------------------------------------------
    -- Register for CURDESC Pointer state machine
    ---------------------------------------------------------------------------
    REG_PNTR_STATES : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    pntr_cs <= IDLE;
                else
                    pntr_cs <= pntr_ns;
                end if;
            end if;
        end process REG_PNTR_STATES;

GEN_Q_FOR_SYNC : if C_AXIS_IS_ASYNC = 0 generate
begin

MM2S_CHANNEL : if C_INCLUDE_MM2S = 1 generate

    updt_tvalid <= follower_full_mm2s and updt_active;
       
    updt_tlast  <=  follower_reg_mm2s(C_S_AXIS_UPDSTS_TDATA_WIDTH) and updt_active;

    sts_rden <= follower_empty_mm2s and (not sts_queue_empty); -- and updt_active;

    VALID_REG_MM2S_ACTIVE : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0' or (m_axis_updt_tready_mm2s = '1' and follower_full_mm2s = '1'))then
                   --    follower_reg_mm2s <= (others => '0');
                       follower_full_mm2s <= '0';
                       follower_empty_mm2s <= '1'; 
                else
                    if (sts_rden = '1') then
                   --    follower_reg_mm2s <= sts_queue_dout; 
                       follower_full_mm2s <= '1';
                       follower_empty_mm2s <= '0'; 
                    end if;
                end if;
            end if;
        end process VALID_REG_MM2S_ACTIVE;


    VALID_REG_MM2S_ACTIVE1 : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                       follower_reg_mm2s <= (others => '0');
                else
                   if (sts_rden = '1') then
                       follower_reg_mm2s <= sts_queue_dout; 
                   end if;
                end if;
            end if;
        end process VALID_REG_MM2S_ACTIVE1;

    REG_ACTIVE : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0' )then
                    updt_active_d1 <= '0';
                else
                    updt_active_d1 <= updt_active;
                end if;
            end if;
        end process REG_ACTIVE;

    updt_active_re1  <= updt_active and not updt_active_d1;

--       I_UPDT_DATA_FIFO : entity lib_srl_fifo_v1_0_2.srl_fifo_f
--       generic map (
--         C_DWIDTH            =>  32   ,
--         C_DEPTH             =>  8    ,
--         C_FAMILY            =>  C_FAMILY
--         )
--       port map (
--         Clk           =>  m_axi_sg_aclk  ,
--         Reset         =>  sinit          ,
--         FIFO_Write    =>  ptr_queue_wren  ,
--         Data_In       =>  ptr_queue_din ,
--         FIFO_Read     =>  ptr_queue_rden ,
--         Data_Out      =>  ptr_queue_dout ,
--         FIFO_Empty    =>  ptr_queue_empty ,
--         FIFO_Full     =>  ptr_queue_full,
--         Addr          =>  open
--         );

process (m_axi_sg_aclk)
begin
       if (m_axi_sg_aclk'event and m_axi_sg_aclk = '1') then
           if (sinit = '1') then
              ptr_queue_dout <= (others => '0');
           elsif (ptr_queue_wren = '1') then
              ptr_queue_dout <= ptr_queue_din;
           end if;
       end if;
end process;

process (m_axi_sg_aclk)
begin
       if (m_axi_sg_aclk'event and m_axi_sg_aclk = '1') then
           if (sinit = '1' or ptr_queue_rden = '1') then
              ptr_queue_empty <= '1';
              ptr_queue_full <= '0';
           elsif (ptr_queue_wren = '1') then
              ptr_queue_empty <= '0';
              ptr_queue_full <= '1';
           end if;
       end if;
end process;


    -- Channel Pointer Queue (Generate Synchronous FIFO)

--       I_UPDT_STS_FIFO : entity lib_srl_fifo_v1_0_2.srl_fifo_f
--       generic map (
--         C_DWIDTH            =>  34   ,
--         C_DEPTH             =>  4    ,
--         C_FAMILY            =>  C_FAMILY
--         )
--       port map (
--         Clk           =>  m_axi_sg_aclk       ,
--         Reset         =>  sinit               ,
--         FIFO_Write    =>  sts_queue_wren       ,
--         Data_In       =>  sts_queue_din      ,
--         FIFO_Read     =>  sts_rden, --sts_queue_rden      ,
--         Data_Out      =>  sts_queue_dout      ,
--         FIFO_Empty    =>  sts_queue_empty      ,
--         FIFO_Full     =>  sts_queue_full     ,
--         Addr          =>  open
--         );

process (m_axi_sg_aclk)
begin
       if (m_axi_sg_aclk'event and m_axi_sg_aclk = '1') then
           if (sinit = '1') then
              sts_queue_dout <= (others => '0');
           elsif (sts_queue_wren = '1') then
              sts_queue_dout <= sts_queue_din;
           end if;
       end if;
end process;

process (m_axi_sg_aclk)
begin
       if (m_axi_sg_aclk'event and m_axi_sg_aclk = '1') then
           if (sinit = '1' or sts_rden = '1') then
              sts_queue_empty <= '1';
              sts_queue_full <= '0';
           elsif (sts_queue_wren = '1') then
              sts_queue_empty <= '0';
              sts_queue_full <= '1';
           end if;
       end if;
end process;



    -- Channel Status Queue (Generate Synchronous FIFO)

 
    --*****************************************
    --** Channel Data Port Side of Queues
    --*****************************************

    -- Pointer Queue Update -  Descriptor Pointer (32bits)
    -- i.e. 2 current descriptor pointers and any app fields
    ptr_queue_din(C_M_AXI_SG_ADDR_WIDTH-1 downto 0)   <= s_axis_updtptr_tdata(        -- DESC DATA
                                                                C_M_AXI_SG_ADDR_WIDTH-1
                                                                downto 0);

    -- Data Queue Write Enable - based on tvalid and queue not full
    ptr_queue_wren    <=  s_axis_updtptr_tvalid    -- TValid
                          and not ptr_queue_full;      -- Data Queue NOT Full


    -- Drive channel port with ready if room in data queue
    s_axis_updtptr_tready <= not ptr_queue_full;


    --*****************************************
    --** Channel Status Port Side of Queues
    --*****************************************

    -- Status Queue Update - TLAST(1bit) & Includes IOC(1bit) & Descriptor Status(32bits)
    -- Note: Type field is stripped off
    sts_queue_din(C_S_AXIS_UPDSTS_TDATA_WIDTH)              <= s_axis_updtsts_tlast;        -- Store with tlast
    sts_queue_din(C_S_AXIS_UPDSTS_TDATA_WIDTH-1 downto 0)   <= s_axis_updtsts_tdata(        -- IOC & DESC STS
                                                                C_S_AXIS_UPDSTS_TDATA_WIDTH-1
                                                                downto 0);

    -- Status Queue Write Enable - based on tvalid and queue not full
    sts_queue_wren  <= s_axis_updtsts_tvalid
                          and not sts_queue_full;

    -- Drive channel port with ready if room in status queue
    s_axis_updtsts_tready <= not sts_queue_full;


    --*************************************
    --** SG Engine Side of Queues
    --*************************************
    -- Indicate NOT empty if both status queue and data queue are not empty
 --   updt_queue_empty    <= ptr_queue_empty
 --                           or (sts_queue_empty and follower_empty and updt_active);
    updt_queue_empty    <= ptr_queue_empty
                            or follower_empty_mm2s; -- and updt_active);


    -- Data queue read enable
    ptr_queue_rden <= '1' when dataq_rden = '1'             -- Cur desc read enable
                               and ptr_queue_empty = '0'        -- Data Queue NOT empty
                               and updt_active = '1'
                 else '0';

    -- Status queue read enable
    sts_queue_rden <= '1' when stsq_rden = '1'          -- Writing desc status
                               and sts_queue_empty = '0'    -- Status fifo NOT empty
                               and updt_active = '1'
                     else '0';



    -----------------------------------------------------------------------
    -- TVALID - status queue not empty and writing status
    -----------------------------------------------------------------------

    -----------------------------------------------------------------------
    -- TLAST - status queue not empty, writing status, and last asserted
    -----------------------------------------------------------------------
    -- Drive last as long as tvalid is asserted and last from fifo
    -- is asserted


end generate MM2S_CHANNEL;

NO_MM2S_CHANNEL : if C_INCLUDE_MM2S = 0 generate
begin

      updt_active_re1 <= '0';
      updt_queue_empty <= '0';
      s_axis_updtptr_tready <= '0';
      s_axis_updtsts_tready <= '0';
      sts_queue_dout <= (others => '0'); 
      sts_queue_full <= '0';
      sts_queue_empty <= '0';  
      ptr_queue_dout <= (others => '0');
      ptr_queue_empty <= '0';
      ptr_queue_full <= '0';


end generate NO_MM2S_CHANNEL;

S2MM_CHANNEL : if C_INCLUDE_S2MM = 1 generate
begin

    updt2_tvalid <= follower_full_s2mm and updt2_active;
       
    updt2_tlast  <=  follower_reg_s2mm(C_S_AXIS_UPDSTS_TDATA_WIDTH) and updt2_active;


    sts2_rden <= follower_empty_s2mm and (not sts2_queue_empty); -- and updt2_active;


    VALID_REG_S2MM_ACTIVE : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0' or (m_axis_updt_tready_s2mm = '1' and follower_full_s2mm = '1'))then
                 --      follower_reg_s2mm <= (others => '0');
                       follower_full_s2mm <= '0';
                       follower_empty_s2mm <= '1'; 
                else
                    if (sts2_rden = '1') then
                 --      follower_reg_s2mm <= sts2_queue_dout; 
                       follower_full_s2mm <= '1';
                       follower_empty_s2mm <= '0'; 
                    end if;
                end if;
            end if;
        end process VALID_REG_S2MM_ACTIVE;

    VALID_REG_S2MM_ACTIVE1 : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                       follower_reg_s2mm <= (others => '0');
                else
                   if (sts2_rden = '1') then
                       follower_reg_s2mm <= sts2_queue_dout; 
                   end if;
                end if;
            end if;
        end process VALID_REG_S2MM_ACTIVE1;

    REG2_ACTIVE : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0' )then
                    updt_active_d2 <= '0';
                else
                    updt_active_d2 <= updt2_active;
                end if;
            end if;
        end process REG2_ACTIVE;

    updt_active_re2  <= updt2_active and not updt_active_d2;

--       I_UPDT2_DATA_FIFO : entity lib_srl_fifo_v1_0_2.srl_fifo_f
--       generic map (
--         C_DWIDTH            =>  32   ,
--         C_DEPTH             =>  8    ,
--         C_FAMILY            =>  C_FAMILY
--         )
--       port map (
--         Clk           =>  m_axi_sg_aclk  ,
--         Reset         =>  sinit          ,
--         FIFO_Write    =>  ptr2_queue_wren  ,
--         Data_In       =>  ptr2_queue_din ,
--         FIFO_Read     =>  ptr2_queue_rden ,
--         Data_Out      =>  ptr2_queue_dout ,
--         FIFO_Empty    =>  ptr2_queue_empty ,
--         FIFO_Full     =>  ptr2_queue_full,
--         Addr          =>  open
--         );


process (m_axi_sg_aclk)
begin
       if (m_axi_sg_aclk'event and m_axi_sg_aclk = '1') then
           if (sinit = '1') then
              ptr2_queue_dout <= (others => '0');
           elsif (ptr2_queue_wren = '1') then
              ptr2_queue_dout <= ptr2_queue_din;
           end if;
       end if;
end process;

process (m_axi_sg_aclk)
begin
       if (m_axi_sg_aclk'event and m_axi_sg_aclk = '1') then
           if (sinit = '1' or ptr2_queue_rden = '1') then
              ptr2_queue_empty <= '1';
              ptr2_queue_full <= '0';
           elsif (ptr2_queue_wren = '1') then
              ptr2_queue_empty <= '0';
              ptr2_queue_full <= '1';
           end if;
       end if;
end process;


APP_UPDATE: if C_SG2_WORDS_TO_UPDATE /= 1 generate
begin

       I_UPDT2_STS_FIFO : entity lib_srl_fifo_v1_0_2.srl_fifo_f
       generic map (
         C_DWIDTH            =>  34   ,
         C_DEPTH             =>  12   ,
         C_FAMILY            =>  C_FAMILY
         )
       port map (
         Clk           =>  m_axi_sg_aclk       ,
         Reset         =>  sinit               ,
         FIFO_Write    =>  sts2_queue_wren       ,
         Data_In       =>  sts2_queue_din      ,
         FIFO_Read     =>  sts2_rden,
         Data_Out      =>  sts2_queue_dout      ,
         FIFO_Empty    =>  sts2_queue_empty      ,
         FIFO_Full     =>  sts2_queue_full     ,
         Addr          =>  open
         );

end generate APP_UPDATE;

NO_APP_UPDATE: if C_SG2_WORDS_TO_UPDATE = 1 generate
begin

process (m_axi_sg_aclk)
begin
       if (m_axi_sg_aclk'event and m_axi_sg_aclk = '1') then
           if (sinit = '1') then
              sts2_queue_dout <= (others => '0');
           elsif (sts2_queue_wren = '1') then
              sts2_queue_dout <= sts2_queue_din;
           end if;
       end if;
end process;

process (m_axi_sg_aclk)
begin
       if (m_axi_sg_aclk'event and m_axi_sg_aclk = '1') then
           if (sinit = '1' or sts2_rden = '1') then
              sts2_queue_empty <= '1';
              sts2_queue_full <= '0';
           elsif (sts2_queue_wren = '1') then
              sts2_queue_empty <= '0';
              sts2_queue_full <= '1';
           end if;
       end if;
end process;

end generate NO_APP_UPDATE;

    -- Pointer Queue Update -  Descriptor Pointer (32bits)
    -- i.e. 2 current descriptor pointers and any app fields
    ptr2_queue_din(C_M_AXI_SG_ADDR_WIDTH-1 downto 0)   <= s_axis2_updtptr_tdata(        -- DESC DATA
                                                                C_M_AXI_SG_ADDR_WIDTH-1
                                                                downto 0);

    -- Data Queue Write Enable - based on tvalid and queue not full
    ptr2_queue_wren    <=  s_axis2_updtptr_tvalid    -- TValid
                          and not ptr2_queue_full;      -- Data Queue NOT Full


    -- Drive channel port with ready if room in data queue
    s_axis2_updtptr_tready <= not ptr2_queue_full;


    --*****************************************
    --** Channel Status Port Side of Queues
    --*****************************************

    -- Status Queue Update - TLAST(1bit) & Includes IOC(1bit) & Descriptor Status(32bits)
    -- Note: Type field is stripped off
    sts2_queue_din(C_S_AXIS_UPDSTS_TDATA_WIDTH)              <= s_axis2_updtsts_tlast;        -- Store with tlast
    sts2_queue_din(C_S_AXIS_UPDSTS_TDATA_WIDTH-1 downto 0)   <= s_axis2_updtsts_tdata(        -- IOC & DESC STS
                                                                C_S_AXIS_UPDSTS_TDATA_WIDTH-1
                                                                downto 0);

    -- Status Queue Write Enable - based on tvalid and queue not full
    sts2_queue_wren  <= s_axis2_updtsts_tvalid
                          and not sts2_queue_full;

    -- Drive channel port with ready if room in status queue
    s_axis2_updtsts_tready <= not sts2_queue_full;


    --*************************************
    --** SG Engine Side of Queues
    --*************************************
    -- Indicate NOT empty if both status queue and data queue are not empty
    updt2_queue_empty    <= ptr2_queue_empty
                            or follower_empty_s2mm; --or (sts2_queue_empty and follower_empty and updt2_active);


    -- Data queue read enable
    ptr2_queue_rden <= '1' when dataq_rden = '1'             -- Cur desc read enable
                               and ptr2_queue_empty = '0'        -- Data Queue NOT empty
                               and updt2_active = '1'
                 else '0';

    -- Status queue read enable
    sts2_queue_rden <= '1' when stsq_rden = '1'          -- Writing desc status
                               and sts2_queue_empty = '0'    -- Status fifo NOT empty
                               and updt2_active = '1'
                     else '0';




end generate S2MM_CHANNEL;


NO_S2MM_CHANNEL : if C_INCLUDE_S2MM = 0 generate
begin

      updt_active_re2 <= '0';
      updt2_queue_empty <= '0';
      s_axis2_updtptr_tready <= '0';
      s_axis2_updtsts_tready <= '0';
      sts2_queue_dout <= (others => '0'); 
      sts2_queue_full <= '0';
      sts2_queue_empty <= '0';  
      ptr2_queue_dout <= (others => '0');
      ptr2_queue_empty <= '0';
      ptr2_queue_full <= '0';


end generate NO_S2MM_CHANNEL;

end generate GEN_Q_FOR_SYNC;



    -- FIFO Reset is active high
    sinit   <= not m_axi_sg_aresetn;


--    LSB_PROC : process(m_axi_sg_aclk)
--        begin
--            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
--                if(m_axi_sg_aresetn = '0' )then
--                    write_curdesc_lsb <= '0'; 

--                -- Capture lower pointer from FIFO or channel port
--                else -- if(write_curdesc_lsb = '1' and updt_active_int = '1')then
                    write_curdesc_lsb <= write_curdesc_lsb_sm;
--                end if;
--            end if;
--        end process LSB_PROC;





--*********************************************************************
--** POINTER CAPTURE LOGIC
--*********************************************************************

    ptr_queue_dout_int <= ptr2_queue_dout when (updt2_active = '1') else
                          ptr_queue_dout;

    ---------------------------------------------------------------------------
    -- Write lower order Next Descriptor Pointer out to pntr_mngr
    ---------------------------------------------------------------------------

    updt_active_int <= updt_active or updt2_active;

    REG_LSB_CURPNTR : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0' )then
                    updt_curdesc(31 downto 0)    <= (others => '0');

                -- Capture lower pointer from FIFO or channel port
                elsif(write_curdesc_lsb = '1' and updt_active_int = '1')then
                    updt_curdesc(31 downto 0)    <= ptr_queue_dout_int(C_S_AXIS_UPDPTR_TDATA_WIDTH-1 downto 0);

                end if;
            end if;
        end process REG_LSB_CURPNTR;
    

    ---------------------------------------------------------------------------
    -- 64 Bit Scatter Gather addresses enabled
    ---------------------------------------------------------------------------
    GEN_UPPER_MSB_CURDESC : if C_M_AXI_SG_ADDR_WIDTH > 32 generate
    begin
        ---------------------------------------------------------------------------
        -- Write upper order Next Descriptor Pointer out to pntr_mngr
        ---------------------------------------------------------------------------
        REG_MSB_CURPNTR : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0' )then
                        updt_curdesc(C_M_AXI_SG_ADDR_WIDTH-1 downto 32)   <= (others => '0');
                  --      updt_curdesc_wren            <= '0';
                    -- Capture upper pointer from FIFO or channel port
                    -- and also write curdesc out
                    elsif(write_curdesc_lsb = '1' and updt_active_int = '1')then
                        updt_curdesc(C_M_AXI_SG_ADDR_WIDTH-1 downto 32)   <= ptr_queue_dout_int(C_M_AXI_SG_ADDR_WIDTH-1 downto 32);
                  --      updt_curdesc_wren            <= '1';
                    -- Assert tready/wren for only 1 clock
                    else
                  --      updt_curdesc_wren            <= '0';
                    end if;
                end if;
            end process REG_MSB_CURPNTR;



    end generate GEN_UPPER_MSB_CURDESC;

    ---------------------------------------------------------------------------
    -- 32 Bit Scatter Gather addresses enabled
    ---------------------------------------------------------------------------

        -----------------------------------------------------------------------
        -- No upper order therefore dump fetched word and write pntr lower next
        -- pointer to pntr mngr
        -----------------------------------------------------------------------
        REG_MSB_CURPNTR : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0' )then
                        updt_curdesc_wren            <= '0';
                    -- Throw away second word, only write curdesc out with msb
                    -- set to zero
                    elsif(write_curdesc_lsb = '1' and updt_active_int = '1')then
                    --elsif(write_curdesc_msb = '1' and updt_active_int = '1')then
                        updt_curdesc_wren            <= '1';
                    -- Assert for only 1 clock
                    else
                        updt_curdesc_wren            <= '0';
                    end if;
                end if;
            end process REG_MSB_CURPNTR;





--*********************************************************************
--** ERROR CAPTURE LOGIC
--*********************************************************************

    -----------------------------------------------------------------------
    -- Generate rising edge pulse on writing status signal.  This will
    -- assert at the beginning of the status write.  Coupled with status
    -- fifo set to first word fall through status will be on dout
    -- regardless of target ready.
    -----------------------------------------------------------------------
    REG_WRITE_STATUS : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    writing_status_d1 <= '0';
                else
                    writing_status_d1 <= writing_status;
                end if;
            end if;
        end process REG_WRITE_STATUS;



    writing_status_re <= writing_status and not writing_status_d1;
    writing_status_re_ch1 <= writing_status_re and updt_active;
    writing_status_re_ch2 <= writing_status_re and updt2_active;

    -----------------------------------------------------------------------
    -- Caputure IOC begin set
    -----------------------------------------------------------------------
    REG_IOC_PROCESS : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0' or updt_ioc_irq_set = '1')then
                    updt_ioc <= '0';
                elsif(writing_status_re_ch1 = '1')then
                  --  updt_ioc <= sts_queue_dout(DESC_IOC_TAG_BIT) and updt_active;
                    updt_ioc <= follower_reg_mm2s(DESC_IOC_TAG_BIT);
                end if;
            end if;
        end process REG_IOC_PROCESS;

    -----------------------------------------------------------------------
    -- Capture DMA Internal Errors
    -----------------------------------------------------------------------
    CAPTURE_DMAINT_ERROR: process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0' or dma_interr_set = '1')then
                    dma_interr  <= '0';
                elsif(writing_status_re_ch1 = '1')then
                    --dma_interr <=  sts_queue_dout(DESC_STS_INTERR_BIT) and updt_active;
                    dma_interr <=  follower_reg_mm2s(DESC_STS_INTERR_BIT);
                end if;
            end if;
        end process CAPTURE_DMAINT_ERROR;

    -----------------------------------------------------------------------
    -- Capture DMA Slave Errors
    -----------------------------------------------------------------------
    CAPTURE_DMASLV_ERROR: process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0' or dma_slverr_set = '1')then
                    dma_slverr  <= '0';
                elsif(writing_status_re_ch1 = '1')then
                   -- dma_slverr <=  sts_queue_dout(DESC_STS_SLVERR_BIT) and updt_active;
                    dma_slverr <=  follower_reg_mm2s(DESC_STS_SLVERR_BIT);
                end if;
            end if;
        end process CAPTURE_DMASLV_ERROR;

    -----------------------------------------------------------------------
    -- Capture DMA Decode Errors
    -----------------------------------------------------------------------
    CAPTURE_DMADEC_ERROR: process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0' or dma_decerr_set = '1')then
                    dma_decerr  <= '0';
                elsif(writing_status_re_ch1 = '1')then
                  --  dma_decerr <=  sts_queue_dout(DESC_STS_DECERR_BIT) and updt_active;
                    dma_decerr <=  follower_reg_mm2s(DESC_STS_DECERR_BIT);
                end if;
            end if;
        end process CAPTURE_DMADEC_ERROR;



    -----------------------------------------------------------------------
    -- Caputure IOC begin set
    -----------------------------------------------------------------------
    REG_IOC2_PROCESS : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0' or updt2_ioc_irq_set = '1')then
                    updt2_ioc <= '0';
                elsif(writing_status_re_ch2 = '1')then
                   -- updt2_ioc <= sts2_queue_dout(DESC_IOC_TAG_BIT) and updt2_active;
                    updt2_ioc <= follower_reg_s2mm(DESC_IOC_TAG_BIT);
                end if;
            end if;
        end process REG_IOC2_PROCESS;

    -----------------------------------------------------------------------
    -- Capture DMA Internal Errors
    -----------------------------------------------------------------------
    CAPTURE_DMAINT2_ERROR: process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0' or dma2_interr_set = '1')then
                    dma2_interr  <= '0';
                elsif(writing_status_re_ch2 = '1')then
                  --  dma2_interr <=  sts2_queue_dout(DESC_STS_INTERR_BIT) and updt2_active;
                    dma2_interr <=  follower_reg_s2mm (DESC_STS_INTERR_BIT);
                end if;
            end if;
        end process CAPTURE_DMAINT2_ERROR;

    -----------------------------------------------------------------------
    -- Capture DMA Slave Errors
    -----------------------------------------------------------------------
    CAPTURE_DMASLV2_ERROR: process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0' or dma2_slverr_set = '1')then
                    dma2_slverr  <= '0';
                elsif(writing_status_re_ch2 = '1')then
                  --  dma2_slverr <=  sts2_queue_dout(DESC_STS_SLVERR_BIT) and updt2_active;
                    dma2_slverr <=  follower_reg_s2mm(DESC_STS_SLVERR_BIT);
                end if;
            end if;
        end process CAPTURE_DMASLV2_ERROR;

    -----------------------------------------------------------------------
    -- Capture DMA Decode Errors
    -----------------------------------------------------------------------
    CAPTURE_DMADEC2_ERROR: process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0' or dma2_decerr_set = '1')then
                    dma2_decerr  <= '0';
                elsif(writing_status_re_ch2 = '1')then
                  --  dma2_decerr <=  sts2_queue_dout(DESC_STS_DECERR_BIT) and updt2_active;
                    dma2_decerr <=  follower_reg_s2mm(DESC_STS_DECERR_BIT);
                end if;
            end if;
        end process CAPTURE_DMADEC2_ERROR;


end implementation;
