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
-- Filename:          axi_dma_mm2s_cntrl_strm.vhd
-- Description: This entity is MM2S control stream logic
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
use lib_pkg_v1_0_2.lib_pkg.max2;

library lib_fifo_v1_0_4;

-------------------------------------------------------------------------------
entity  axi_dma_mm2s_cntrl_strm is
    generic(
        C_PRMRY_IS_ACLK_ASYNC           : integer range 0 to 1      := 0;
            -- Primary MM2S/S2MM sync/async mode
            -- 0 = synchronous mode     - all clocks are synchronous
            -- 1 = asynchronous mode    - Primary data path channels (MM2S and S2MM)
            --                            run asynchronous to AXI Lite, DMA Control,
            --                            and SG.

        C_PRMY_CMDFIFO_DEPTH        : integer range 1 to 16         := 1;
            -- Depth of DataMover command FIFO

        C_M_AXIS_MM2S_CNTRL_TDATA_WIDTH : integer range 32 to 32    := 32;
            -- Master AXI Control Stream Data Width

        C_FAMILY                        : string                    := "virtex7"
            -- Target FPGA Device Family
    );
    port (
        -- Secondary clock / reset
        m_axi_sg_aclk               : in  std_logic                         ;           --
        m_axi_sg_aresetn            : in  std_logic                         ;           --
                                                                                        --
        -- Primary clock / reset                                                        --
        axi_prmry_aclk              : in  std_logic                         ;           --
        p_reset_n                   : in  std_logic                         ;           --
                                                                                        --
        -- MM2S Error                                                                   --
        mm2s_stop                   : in  std_logic                         ;           --
                                                                                        --
        -- Control Stream FIFO write signals (from axi_dma_mm2s_sg_if)                  --
        cntrlstrm_fifo_wren         : in  std_logic                         ;           --
        cntrlstrm_fifo_din          : in  std_logic_vector                              --
                                        (C_M_AXIS_MM2S_CNTRL_TDATA_WIDTH downto 0);     --
        cntrlstrm_fifo_full         : out std_logic                         ;           --
                                                                                        --
                                                                                        --
        -- Memory Map to Stream Control Stream Interface                                --
        m_axis_mm2s_cntrl_tdata     : out std_logic_vector                              --
                                        (C_M_AXIS_MM2S_CNTRL_TDATA_WIDTH-1 downto 0);   --
        m_axis_mm2s_cntrl_tkeep     : out std_logic_vector                              --
                                        ((C_M_AXIS_MM2S_CNTRL_TDATA_WIDTH/8)-1 downto 0);--
        m_axis_mm2s_cntrl_tvalid    : out std_logic                         ;           --
        m_axis_mm2s_cntrl_tready    : in  std_logic                         ;           --
        m_axis_mm2s_cntrl_tlast     : out std_logic                                     --



    );
end axi_dma_mm2s_cntrl_strm;

-------------------------------------------------------------------------------
-- Architecture
-------------------------------------------------------------------------------
architecture implementation of axi_dma_mm2s_cntrl_strm is
  attribute DowngradeIPIdentifiedWarnings: string;
  attribute DowngradeIPIdentifiedWarnings of implementation : architecture is "yes";


-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------

-- No Functions Declared

-------------------------------------------------------------------------------
-- Constants Declarations
-------------------------------------------------------------------------------

-- Number of words deep fifo needs to be
-- Only 5 app fields, but set to 8 so depth is a power of 2
constant CNTRL_FIFO_DEPTH       : integer := max2(16,8 * C_PRMY_CMDFIFO_DEPTH);


-- Width of fifo rd and wr counts - only used for proper fifo operation
constant CNTRL_FIFO_CNT_WIDTH   : integer   := clog2(CNTRL_FIFO_DEPTH+1);

constant USE_LOGIC_FIFOS        : integer   := 0; -- Use Logic FIFOs
constant USE_BRAM_FIFOS         : integer   := 1; -- Use BRAM FIFOs

-------------------------------------------------------------------------------
-- Signal / Type Declarations
-------------------------------------------------------------------------------
-- FIFO signals
signal cntrl_fifo_rden  : std_logic := '0';
signal cntrl_fifo_empty : std_logic := '0';
signal cntrl_fifo_dout  : std_logic_vector
                            (C_M_AXIS_MM2S_CNTRL_TDATA_WIDTH downto 0) := (others => '0');
signal cntrl_fifo_dvalid: std_logic := '0';

signal cntrl_tdata      : std_logic_vector
                            (C_M_AXIS_MM2S_CNTRL_TDATA_WIDTH-1 downto 0) := (others => '0');
signal cntrl_tkeep      : std_logic_vector
                            ((C_M_AXIS_MM2S_CNTRL_TDATA_WIDTH/8)-1 downto 0) := (others => '0');
signal cntrl_tvalid     : std_logic := '0';
signal cntrl_tready     : std_logic := '0';
signal cntrl_tlast      : std_logic := '0';
signal sinit            : std_logic := '0';

signal m_valid          : std_logic := '0';
signal m_ready          : std_logic := '0';
signal m_data           : std_logic_vector(C_M_AXIS_MM2S_CNTRL_TDATA_WIDTH-1 downto 0) := (others => '0');
signal m_strb           : std_logic_vector((C_M_AXIS_MM2S_CNTRL_TDATA_WIDTH/8)-1 downto 0) := (others => '0');
signal m_last           : std_logic := '0';

signal skid_rst         : std_logic := '0';
-------------------------------------------------------------------------------
-- Begin architecture logic
-------------------------------------------------------------------------------
begin
-- All bytes always valid
cntrl_tkeep <= (others => '1');


-- Primary Clock is synchronous to Secondary Clock therfore
-- instantiate a sync fifo.
GEN_SYNC_FIFO : if C_PRMRY_IS_ACLK_ASYNC = 0 generate
signal mm2s_stop_d1     : std_logic := '0';
signal mm2s_stop_re     : std_logic := '0';
signal xfer_in_progress : std_logic := '0';
begin
    -- reset on hard reset or mm2s stop
    sinit   <= not m_axi_sg_aresetn or mm2s_stop;

    -- Generate Synchronous FIFO
    I_CNTRL_FIFO : entity lib_fifo_v1_0_4.sync_fifo_fg
    generic map (
        C_FAMILY                =>  C_FAMILY                ,
        C_MEMORY_TYPE           =>  USE_LOGIC_FIFOS,
        C_WRITE_DATA_WIDTH      =>  C_M_AXIS_MM2S_CNTRL_TDATA_WIDTH + 1,
        C_WRITE_DEPTH           =>  CNTRL_FIFO_DEPTH       ,
        C_READ_DATA_WIDTH       =>  C_M_AXIS_MM2S_CNTRL_TDATA_WIDTH + 1,
        C_READ_DEPTH            =>  CNTRL_FIFO_DEPTH       ,
        C_PORTS_DIFFER          =>  0,
        C_HAS_DCOUNT            =>  1, --req for proper fifo operation
        C_DCOUNT_WIDTH          =>  CNTRL_FIFO_CNT_WIDTH,
        C_HAS_ALMOST_FULL       =>  0,
        C_HAS_RD_ACK            =>  0,
        C_HAS_RD_ERR            =>  0,
        C_HAS_WR_ACK            =>  0,
        C_HAS_WR_ERR            =>  0,
        C_RD_ACK_LOW            =>  0,
        C_RD_ERR_LOW            =>  0,
        C_WR_ACK_LOW            =>  0,
        C_WR_ERR_LOW            =>  0,
        C_PRELOAD_REGS          =>  1,-- 1 = first word fall through
        C_PRELOAD_LATENCY       =>  0 -- 0 = first word fall through
 --       C_USE_EMBEDDED_REG      =>  1 -- 0 ;
    )
    port map (

        Clk             =>  m_axi_sg_aclk       ,
        Sinit           =>  sinit               ,
        Din             =>  cntrlstrm_fifo_din  ,
        Wr_en           =>  cntrlstrm_fifo_wren ,
        Rd_en           =>  cntrl_fifo_rden     ,
        Dout            =>  cntrl_fifo_dout     ,
        Full            =>  cntrlstrm_fifo_full ,
        Empty           =>  cntrl_fifo_empty    ,
        Almost_full     =>  open                ,
        Data_count      =>  open                ,
        Rd_ack          =>  open                ,
        Rd_err          =>  open                ,
        Wr_ack          =>  open                ,
        Wr_err          =>  open

    );

    -----------------------------------------------------------------------
    -- Control Stream OUT Side
    -----------------------------------------------------------------------
    -- Read if fifo is not empty and target is ready
    cntrl_fifo_rden  <= not cntrl_fifo_empty
                        and cntrl_tready;

    -- Drive valid if fifo is not empty or in the middle
    -- of transfer and stop issued.
    cntrl_tvalid  <= not cntrl_fifo_empty
                    or (xfer_in_progress and mm2s_stop_re);

    -- Pass data out to control channel with MSB driving tlast
    cntrl_tlast   <= (cntrl_tvalid and cntrl_fifo_dout(C_M_AXIS_MM2S_CNTRL_TDATA_WIDTH))
                    or (xfer_in_progress and mm2s_stop_re);

    cntrl_tdata   <= cntrl_fifo_dout(C_M_AXIS_MM2S_CNTRL_TDATA_WIDTH-1 downto 0);

    -- Register stop to create re pulse for cleaning shutting down
    -- stream out during soft reset.
    REG_STOP : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    mm2s_stop_d1    <= '0';
                else
                    mm2s_stop_d1    <= mm2s_stop;
                end if;
            end if;
        end process REG_STOP;

    mm2s_stop_re <= mm2s_stop and not mm2s_stop_d1;

    -------------------------------------------------------------
    -- Flag transfer in progress. If xfer in progress then
    -- a fake tlast and tvalid need to be asserted during soft
    -- reset else no need of tlast.
    -------------------------------------------------------------
    TRANSFER_IN_PROGRESS : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(cntrl_tlast = '1' and cntrl_tvalid = '1' and cntrl_tready = '1')then
                    xfer_in_progress <= '0';
                elsif(xfer_in_progress = '0' and cntrl_tvalid = '1')then
                    xfer_in_progress <= '1';
                end if;
            end if;
        end process TRANSFER_IN_PROGRESS;

    skid_rst   <= not m_axi_sg_aresetn;

    ---------------------------------------------------------------------------
    -- Buffer AXI Signals
    ---------------------------------------------------------------------------
    CNTRL_SKID_BUF_I : entity axi_dma_v7_1_8.axi_dma_skid_buf
        generic map(
            C_WDATA_WIDTH           => C_M_AXIS_MM2S_CNTRL_TDATA_WIDTH
        )
        port map(
            -- System Ports
            ACLK            => m_axi_sg_aclk                          ,
            ARST            => skid_rst                                 ,

            skid_stop       => mm2s_stop_re                             ,

            -- Slave Side (Stream Data Input)
            S_VALID         => cntrl_tvalid                             ,
            S_READY         => cntrl_tready                             ,
            S_Data          => cntrl_tdata                              ,
            S_STRB          => cntrl_tkeep                              ,
            S_Last          => cntrl_tlast                              ,

            -- Master Side (Stream Data Output
            M_VALID         => m_axis_mm2s_cntrl_tvalid                 ,
            M_READY         => m_axis_mm2s_cntrl_tready                 ,
            M_Data          => m_axis_mm2s_cntrl_tdata                  ,
            M_STRB          => m_axis_mm2s_cntrl_tkeep                  ,
            M_Last          => m_axis_mm2s_cntrl_tlast
        );


end generate GEN_SYNC_FIFO;

-- Primary Clock is asynchronous to Secondary Clock therfore
-- instantiate an async fifo.
GEN_ASYNC_FIFO : if C_PRMRY_IS_ACLK_ASYNC = 1 generate
signal mm2s_stop_reg        : std_logic := '0'; -- CR605883
signal p_mm2s_stop_d1       : std_logic := '0';
signal p_mm2s_stop_d2       : std_logic := '0';
signal p_mm2s_stop_d3       : std_logic := '0';
signal p_mm2s_stop_re       : std_logic := '0';
signal xfer_in_progress     : std_logic := '0';
begin

    -- reset on hard reset, soft reset, or mm2s error
    sinit   <= not p_reset_n or p_mm2s_stop_d2;

    -- Generate Asynchronous FIFO
    I_CNTRL_STRM_FIFO : entity axi_dma_v7_1_8.axi_dma_afifo_autord
      generic map(
         C_DWIDTH        => C_M_AXIS_MM2S_CNTRL_TDATA_WIDTH + 1  ,
-- Temp work around for issue in async fifo model
--         C_DEPTH         => CNTRL_FIFO_DEPTH                    ,
--         C_CNT_WIDTH     => CNTRL_FIFO_CNT_WIDTH                ,
         C_DEPTH         => 31                                  ,
         C_CNT_WIDTH     => 5                                   ,
         C_USE_BLKMEM    => USE_LOGIC_FIFOS                     ,
         C_FAMILY        => C_FAMILY
        )
      port map(
        -- Inputs
         AFIFO_Ainit                => sinit                    ,
         AFIFO_Wr_clk               => m_axi_sg_aclk            ,
         AFIFO_Wr_en                => cntrlstrm_fifo_wren      ,
         AFIFO_Din                  => cntrlstrm_fifo_din       ,
         AFIFO_Rd_clk               => axi_prmry_aclk           ,
         AFIFO_Rd_en                => cntrl_fifo_rden          ,
         AFIFO_Clr_Rd_Data_Valid    => '0'                      ,

        -- Outputs
         AFIFO_DValid               => cntrl_fifo_dvalid        ,
         AFIFO_Dout                 => cntrl_fifo_dout          ,
         AFIFO_Full                 => cntrlstrm_fifo_full      ,
         AFIFO_Empty                => cntrl_fifo_empty         ,
         AFIFO_Almost_full          => open                     ,
         AFIFO_Almost_empty         => open                     ,
         AFIFO_Wr_count             => open                     ,
         AFIFO_Rd_count             => open                     ,
         AFIFO_Corr_Rd_count        => open                     ,
         AFIFO_Corr_Rd_count_minus1 => open                     ,
         AFIFO_Rd_ack               => open
        );


    -----------------------------------------------------------------------
    -- Control Stream OUT Side
    -----------------------------------------------------------------------
    -- Read if fifo is not empty and target is ready
    cntrl_fifo_rden <= not cntrl_fifo_empty        -- fifo has data
                       and cntrl_tready;           -- target ready


    -- Drive valid if fifo is not empty or in the middle
    -- of transfer and stop issued.
    cntrl_tvalid  <= cntrl_fifo_dvalid
                    or (xfer_in_progress and p_mm2s_stop_re);

    -- Pass data out to control channel with MSB driving tlast
    cntrl_tlast   <= cntrl_tvalid and cntrl_fifo_dout(C_M_AXIS_MM2S_CNTRL_TDATA_WIDTH);

    cntrl_tdata   <= cntrl_fifo_dout(C_M_AXIS_MM2S_CNTRL_TDATA_WIDTH-1 downto 0);

    -- CR605883
    -- Register stop to provide pure FF output for synchronizer
    REG_STOP : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    mm2s_stop_reg <= '0';
                else
                    mm2s_stop_reg <= mm2s_stop;
                end if;
            end if;
        end process REG_STOP;


    -- Double/triple register mm2s error into primary clock domain
    -- Triple register to give two versions with min double reg for use
    -- in rising edge detection.
    REG_ERR2PRMRY : process(axi_prmry_aclk)
        begin
            if(axi_prmry_aclk'EVENT and axi_prmry_aclk = '1')then
                if(p_reset_n = '0')then
                    p_mm2s_stop_d1 <= '0';
                    p_mm2s_stop_d2 <= '0';
                    p_mm2s_stop_d3 <= '0';
                else
                    --p_mm2s_stop_d1 <= mm2s_stop;
                    p_mm2s_stop_d1 <= mm2s_stop_reg;
                    p_mm2s_stop_d2 <= p_mm2s_stop_d1;
                    p_mm2s_stop_d3 <= p_mm2s_stop_d2;
                end if;
            end if;
        end process REG_ERR2PRMRY;

    -- Rising edge pulse for use in shutting down stream output
    p_mm2s_stop_re <= p_mm2s_stop_d2 and not p_mm2s_stop_d3;

    -------------------------------------------------------------
    -- Flag transfer in progress. If xfer in progress then
    -- a fake tlast needs to be asserted during soft reset.
    -- else no need of tlast.
    -------------------------------------------------------------
    TRANSFER_IN_PROGRESS : process(axi_prmry_aclk)
        begin
            if(axi_prmry_aclk'EVENT and axi_prmry_aclk = '1')then
                if(cntrl_tlast = '1' and cntrl_tvalid = '1' and cntrl_tready = '1')then
                    xfer_in_progress <= '0';
                elsif(xfer_in_progress = '0' and cntrl_tvalid = '1')then
                    xfer_in_progress <= '1';
                end if;
            end if;
        end process TRANSFER_IN_PROGRESS;


    skid_rst   <= not p_reset_n;

    ---------------------------------------------------------------------------
    -- Buffer AXI Signals
    ---------------------------------------------------------------------------
    CNTRL_SKID_BUF_I : entity axi_dma_v7_1_8.axi_dma_skid_buf
        generic map(
            C_WDATA_WIDTH           => C_M_AXIS_MM2S_CNTRL_TDATA_WIDTH
        )
        port map(
            -- System Ports
            ACLK            => axi_prmry_aclk                           ,
            ARST            => skid_rst                                 ,

            skid_stop       => p_mm2s_stop_re                           ,

            -- Slave Side (Stream Data Input)
            S_VALID         => cntrl_tvalid                             ,
            S_READY         => cntrl_tready                             ,
            S_Data          => cntrl_tdata                              ,
            S_STRB          => cntrl_tkeep                              ,
            S_Last          => cntrl_tlast                              ,

            -- Master Side (Stream Data Output
            M_VALID         => m_axis_mm2s_cntrl_tvalid                 ,
            M_READY         => m_axis_mm2s_cntrl_tready                 ,
            M_Data          => m_axis_mm2s_cntrl_tdata                  ,
            M_STRB          => m_axis_mm2s_cntrl_tkeep                  ,
            M_Last          => m_axis_mm2s_cntrl_tlast
        );


end generate GEN_ASYNC_FIFO;


end implementation;
