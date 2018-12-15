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
-- Filename:          axi_dma_s2mm_sts_strm.vhd.vhd
-- Description: This entity is the AXI Status Stream Interface
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

library lib_srl_fifo_v1_0_2;
library lib_cdc_v1_0_2;
library lib_pkg_v1_0_2;
use lib_pkg_v1_0_2.lib_pkg.all;

-------------------------------------------------------------------------------
entity  axi_dma_s2mm_sts_strm is
    generic (

        C_PRMRY_IS_ACLK_ASYNC           : integer range 0 to 1         := 0;
            -- Primary MM2S/S2MM sync/async mode
            -- 0 = synchronous mode     - all clocks are synchronous
            -- 1 = asynchronous mode    - Primary data path channels (MM2S and S2MM)
            --                            run asynchronous to AXI Lite, DMA Control,
            --                            and SG.

        -----------------------------------------------------------------------
        -- Scatter Gather Parameters
        -----------------------------------------------------------------------
        C_S_AXIS_S2MM_STS_TDATA_WIDTH   : integer range 32 to 32        := 32;
            -- Slave AXI Status Stream Data Width

        C_SG_USE_STSAPP_LENGTH          : integer range 0 to 1          := 1;
            -- Enable or Disable use of Status Stream Rx Length.  Only valid
            -- if C_SG_INCLUDE_STSCNTRL_STRM = 1
            -- 0 = Don't use Rx Length
            -- 1 = Use Rx Length

        C_SG_LENGTH_WIDTH               : integer range 8 to 23         := 14;
            -- Descriptor Buffer Length, Transferred Bytes, and Status Stream
            -- Rx Length Width.  Indicates the least significant valid bits of
            -- descriptor buffer length, transferred bytes, or Rx Length value
            -- in the status word coincident with tlast.

        C_ENABLE_SKID                   : integer range 0 to 1          := 0;

        C_FAMILY                        : string            := "virtex5"
            -- Target FPGA Device Family

    );
    port (

        m_axi_sg_aclk               : in  std_logic                         ;                  --
        m_axi_sg_aresetn            : in  std_logic                         ;                  --
                                                                                               --
        axi_prmry_aclk              : in  std_logic                         ;                  --
        p_reset_n                   : in  std_logic                         ;                  --
                                                                                               --
        s2mm_stop                   : in  std_logic                         ;                  --
                                                                                               --
        s2mm_rxlength_valid         : out std_logic                         ;                  --
        s2mm_rxlength_clr           : in  std_logic                         ;                  --
        s2mm_rxlength               : out std_logic_vector                                     --
                                        (C_SG_LENGTH_WIDTH - 1 downto 0)    ;                  --
                                                                                               --
        stsstrm_fifo_rden           : in  std_logic                         ;                  --
        stsstrm_fifo_empty          : out std_logic                         ;                  --
        stsstrm_fifo_dout           : out std_logic_vector                                     --
                                        (C_S_AXIS_S2MM_STS_TDATA_WIDTH downto 0);              --
                                                                                               --
        -- Stream to Memory Map Status Stream Interface                                        --
        s_axis_s2mm_sts_tdata       : in  std_logic_vector                                     --
                                        (C_S_AXIS_S2MM_STS_TDATA_WIDTH-1 downto 0);            --
        s_axis_s2mm_sts_tkeep       : in  std_logic_vector                                     --
                                        ((C_S_AXIS_S2MM_STS_TDATA_WIDTH/8)-1 downto 0);        --
        s_axis_s2mm_sts_tvalid      : in  std_logic                         ;                  --
        s_axis_s2mm_sts_tready      : out std_logic                         ;                  --
        s_axis_s2mm_sts_tlast       : in  std_logic                                            --
    );

end axi_dma_s2mm_sts_strm;

-------------------------------------------------------------------------------
-- Architecture
-------------------------------------------------------------------------------
architecture implementation of axi_dma_s2mm_sts_strm is
  attribute DowngradeIPIdentifiedWarnings: string;
  attribute DowngradeIPIdentifiedWarnings of implementation : architecture is "yes";


-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------

-- No Functions Declared

-------------------------------------------------------------------------------
-- Constants Declarations
-------------------------------------------------------------------------------
-- Status Stream FIFO Depth
constant STSSTRM_FIFO_DEPTH     : integer := 16;
-- Status Stream FIFO Data Count Width (Unsused)
constant STSSTRM_FIFO_CNT_WIDTH : integer := clog2(STSSTRM_FIFO_DEPTH+1);

constant USE_LOGIC_FIFOS        : integer   := 0; -- Use Logic FIFOs
constant USE_BRAM_FIFOS         : integer   := 1; -- Use BRAM FIFOs

-------------------------------------------------------------------------------
-- Signal / Type Declarations
-------------------------------------------------------------------------------
signal fifo_full        : std_logic := '0';
signal fifo_din         : std_logic_vector(C_S_AXIS_S2MM_STS_TDATA_WIDTH downto 0) := (others => '0');
signal fifo_wren        : std_logic := '0';
signal fifo_sinit       : std_logic := '0';

signal rxlength_cdc_from         : std_logic_vector(C_SG_LENGTH_WIDTH-1 downto 0) := (others => '0');
signal rxlength_valid_cdc_from   : std_logic := '0';

    signal rxlength_valid_trdy : std_logic := '0';
--signal sts_tvalid_re    : std_logic := '0';-- CR565502
--signal sts_tvalid_d1    : std_logic := '0';-- CR565502

signal sts_tvalid       : std_logic := '0';
signal sts_tready       : std_logic := '0';
signal sts_tdata        : std_logic_vector(C_S_AXIS_S2MM_STS_TDATA_WIDTH-1 downto 0) := (others => '0');
signal sts_tkeep        : std_logic_vector((C_S_AXIS_S2MM_STS_TDATA_WIDTH/8)-1 downto 0) := (others => '0');
signal sts_tlast        : std_logic := '0';

signal m_tvalid         : std_logic := '0';
signal m_tready         : std_logic := '0';
signal m_tdata          : std_logic_vector(C_S_AXIS_S2MM_STS_TDATA_WIDTH-1 downto 0) := (others => '0');
signal m_tkeep          : std_logic_vector((C_S_AXIS_S2MM_STS_TDATA_WIDTH/8)-1 downto 0) := (others => '0');
signal m_tlast          : std_logic := '0';



signal tag_stripped     : std_logic := '0';
signal mask_tag_write   : std_logic := '0';
--signal mask_tag_hold    : std_logic := '0';-- CR565502

signal skid_rst         : std_logic := '0';

-------------------------------------------------------------------------------
-- Begin architecture logic
-------------------------------------------------------------------------------
begin


-- Primary Clock is synchronous to Secondary Clock therfore
-- instantiate a sync fifo.
GEN_SYNC_FIFO : if C_PRMRY_IS_ACLK_ASYNC = 0 generate
signal s2mm_stop_d1 : std_logic := '0';
signal s2mm_stop_re : std_logic := '0';
signal sts_rden : std_logic := '0';
signal follower_empty : std_logic := '0';
signal fifo_empty : std_logic := '0';
signal fifo_out : std_logic_vector (C_S_AXIS_S2MM_STS_TDATA_WIDTH downto 0) := (others => '0');

begin
        -- Generate Synchronous FIFO
--    I_STSSTRM_FIFO : entity lib_srl_fifo_v1_0_2.sync_fifo_fg
--        generic map (
--            C_FAMILY                =>  C_FAMILY                ,
--            C_MEMORY_TYPE           =>  USE_LOGIC_FIFOS,
--            C_WRITE_DATA_WIDTH      =>  C_S_AXIS_S2MM_STS_TDATA_WIDTH + 1,
--            C_WRITE_DEPTH           =>  STSSTRM_FIFO_DEPTH       ,
--            C_READ_DATA_WIDTH       =>  C_S_AXIS_S2MM_STS_TDATA_WIDTH + 1,
--            C_READ_DEPTH            =>  STSSTRM_FIFO_DEPTH       ,
--            C_PORTS_DIFFER          =>  0,
--            C_HAS_DCOUNT            =>  1, --req for proper fifo operation
--            C_DCOUNT_WIDTH          =>  STSSTRM_FIFO_CNT_WIDTH,
--            C_HAS_ALMOST_FULL       =>  0,
--            C_HAS_RD_ACK            =>  0,
--            C_HAS_RD_ERR            =>  0,
--            C_HAS_WR_ACK            =>  0,
--            C_HAS_WR_ERR            =>  0,
--            C_RD_ACK_LOW            =>  0,
--            C_RD_ERR_LOW            =>  0,
--            C_WR_ACK_LOW            =>  0,
--            C_WR_ERR_LOW            =>  0,
--            C_PRELOAD_REGS          =>  1,-- 1 = first word fall through
--            C_PRELOAD_LATENCY       =>  0 -- 0 = first word fall through
--  --          C_USE_EMBEDDED_REG      =>  1 -- 0 ;
--        )
--        port map (
--
--            Clk             =>  m_axi_sg_aclk       ,
--            Sinit           =>  fifo_sinit          ,
--            Din             =>  fifo_din            ,
--            Wr_en           =>  fifo_wren           ,
--            Rd_en           =>  stsstrm_fifo_rden   ,
--            Dout            =>  stsstrm_fifo_dout   ,
--            Full            =>  fifo_full           ,
--            Empty           =>  stsstrm_fifo_empty  ,
--            Almost_full     =>  open                ,
--            Data_count      =>  open                ,
--            Rd_ack          =>  open                ,
--            Rd_err          =>  open                ,
--            Wr_ack          =>  open                ,
--            Wr_err          =>  open
--
--        );

       I_UPDT_STS_FIFO : entity lib_srl_fifo_v1_0_2.srl_fifo_f
       generic map (
         C_DWIDTH            =>  C_S_AXIS_S2MM_STS_TDATA_WIDTH + 1,
         C_DEPTH             =>  16    ,
         C_FAMILY            =>  C_FAMILY
         )
       port map (
         Clk           =>  m_axi_sg_aclk       ,
         Reset         =>  fifo_sinit              ,
         FIFO_Write    =>  fifo_wren       ,
         Data_In       =>  fifo_din      ,
         FIFO_Read     =>  sts_rden, --sts_queue_rden      ,
         Data_Out      =>  fifo_out, --sts_queue_dout      ,
         FIFO_Empty    =>  fifo_empty, --sts_queue_empty      ,
         FIFO_Full     =>  fifo_full    ,
         Addr          =>  open
         );

   sts_rden <= (not fifo_empty) and follower_empty;

   stsstrm_fifo_empty <= follower_empty;

process (m_axi_sg_aclk)
begin
      if (m_axi_sg_aclk'event and m_axi_sg_aclk = '1') then
           if (fifo_sinit = '1' or stsstrm_fifo_rden = '1') then
              follower_empty <= '1';     
           elsif (sts_rden = '1') then
              follower_empty <= '0';     
           end if;
      end if;
end process;   


process (m_axi_sg_aclk)
begin
      if (m_axi_sg_aclk'event and m_axi_sg_aclk = '1') then
           if (fifo_sinit = '1') then
              stsstrm_fifo_dout <= (others => '0');     
           elsif (sts_rden = '1') then
              stsstrm_fifo_dout <= fifo_out;     
           end if;
      end if;
end process;   

    fifo_sinit              <= not m_axi_sg_aresetn;
    fifo_din                <= sts_tlast & sts_tdata;
    fifo_wren               <= sts_tvalid and not fifo_full and not rxlength_valid_cdc_from and not mask_tag_write;
    sts_tready              <= not fifo_sinit and not fifo_full and not rxlength_valid_cdc_from;


-- CR565502 - particular throttle condition caused masking of tag write to not occur
-- simplified logic will provide more robust handling of tag write mask
--    -- Create register delay of status tvalid in order to create a
--    -- rising edge pulse.  note xx_re signal will hold at 1 if
--    -- fifo full on rising edge of tvalid.
--    REG_TVALID : process(axi_prmry_aclk)
--        begin
--            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
--                if(m_axi_sg_aresetn = '0')then
--                    sts_tvalid_d1 <= '0';
--                elsif(fifo_full = '0')then
--                    sts_tvalid_d1 <= sts_tvalid;
--                end if;
--            end if;
--        end process REG_TVALID;
--
--    -- rising edge on tvalid used to gate off status tag from being
--    -- writen into fifo.
--    sts_tvalid_re <= sts_tvalid and not sts_tvalid_d1;

    REG_TAG_STRIPPED : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    tag_stripped <= '0';
                -- Reset on write of last word
                elsif(fifo_wren = '1' and sts_tlast = '1')then
                    tag_stripped <= '0';
                -- Set on beginning of new status stream
                elsif(sts_tready = '1' and sts_tvalid = '1')then
                    tag_stripped <= '1';
                end if;
            end if;
        end process REG_TAG_STRIPPED;

-- CR565502 - particular throttle condition caused masking of tag write to not occur
-- simplified logic will provide more robust handling of tag write mask
--    REG_MASK_TAG : process(m_axi_sg_aclk)
--        begin
--            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
--                if(m_axi_sg_aresetn = '0')then
--                    mask_tag_hold <= '0';
--                elsif((sts_tvalid_re = '1' and tag_stripped = '0')
--                   or (fifo_wren = '1' and sts_tlast = '1'))then
--                    mask_tag_hold <= '1';
--                elsif(tag_stripped = '1')then
--                    mask_tag_hold <= '0';
--                end if;
--            end if;
--        end process;
--
--    -- Mask TAG if not already masked and rising edge of tvalid
--    mask_tag_write <= not tag_stripped and (sts_tvalid_re or mask_tag_hold);
    mask_tag_write <= not tag_stripped and sts_tready and sts_tvalid;

    -- Generate logic to capture receive length when Use Receive Length is
    -- enabled
    GEN_STS_APP_LENGTH : if C_SG_USE_STSAPP_LENGTH = 1 generate
    begin
        -- Register receive length on assertion of last and valid
        -- Mark rxlength as valid for higher processes
        REG_RXLENGTH : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0' or s2mm_rxlength_clr = '1')then
                        rxlength_cdc_from       <= (others => '0');
                        rxlength_valid_cdc_from <= '0';
                    elsif(sts_tlast = '1' and sts_tvalid = '1' and sts_tready = '1')then
                        rxlength_cdc_from       <= sts_tdata(C_SG_LENGTH_WIDTH-1 downto 0);
                        rxlength_valid_cdc_from <= '1';
                    end if;
                end if;
            end process REG_RXLENGTH;

        s2mm_rxlength_valid <= rxlength_valid_cdc_from;
        s2mm_rxlength       <= rxlength_cdc_from;

    end generate GEN_STS_APP_LENGTH;

    -- Do NOT generate logic to capture receive length when option disabled
    GEN_NO_STS_APP_LENGTH : if C_SG_USE_STSAPP_LENGTH = 0 generate
    begin
        s2mm_rxlength_valid <= '0';
        s2mm_rxlength       <= (others => '0');
    end generate GEN_NO_STS_APP_LENGTH;

    -- register stop to create re pulse
    REG_STOP : process(axi_prmry_aclk)
        begin
            if(axi_prmry_aclk'EVENT and axi_prmry_aclk = '1')then
                if(p_reset_n = '0')then
                    s2mm_stop_d1 <= '0';
                else
                    s2mm_stop_d1 <= s2mm_stop;
                end if;
            end if;
        end process REG_STOP;

    s2mm_stop_re <= s2mm_stop and not s2mm_stop_d1;

    skid_rst   <= not m_axi_sg_aresetn;

ENABLE_SKID : if C_ENABLE_SKID = 1 generate
begin

    ---------------------------------------------------------------------------
    -- Buffer AXI Signals
    ---------------------------------------------------------------------------
    STS_SKID_BUF_I : entity axi_dma_v7_1_8.axi_dma_skid_buf
        generic map(
            C_WDATA_WIDTH       => C_S_AXIS_S2MM_STS_TDATA_WIDTH
        )
        port map(
            -- System Ports
            ACLK                => m_axi_sg_aclk                            ,
            ARST                => skid_rst                                 ,

            skid_stop           => s2mm_stop_re                             ,

            -- Slave Side (Stream Data Input)
            S_VALID             => s_axis_s2mm_sts_tvalid                   ,
            S_READY             => s_axis_s2mm_sts_tready                   ,
            S_Data              => s_axis_s2mm_sts_tdata                    ,
            S_STRB              => s_axis_s2mm_sts_tkeep                    ,
            S_Last              => s_axis_s2mm_sts_tlast                    ,

            -- Master Side (Stream Data Output
            M_VALID             => sts_tvalid                               ,
            M_READY             => sts_tready                               ,
            M_Data              => sts_tdata                                ,
            M_STRB              => sts_tkeep                                ,
            M_Last              => sts_tlast
        );

end generate ENABLE_SKID;


DISABLE_SKID : if C_ENABLE_SKID = 0 generate
begin

     sts_tvalid <= s_axis_s2mm_sts_tvalid;
     s_axis_s2mm_sts_tready <= sts_tready;
     sts_tdata <= s_axis_s2mm_sts_tdata;
     sts_tkeep <= s_axis_s2mm_sts_tkeep;
     sts_tlast <= s_axis_s2mm_sts_tlast;

end generate DISABLE_SKID;



end generate GEN_SYNC_FIFO;


-- Primary Clock is asynchronous to Secondary Clock therfore
-- instantiate an async fifo.
GEN_ASYNC_FIFO : if C_PRMRY_IS_ACLK_ASYNC = 1 generate
  ATTRIBUTE async_reg                      : STRING;

signal s2mm_stop_reg   : std_logic := '0'; -- CR605883
signal p_s2mm_stop_d1_cdc_tig  : std_logic := '0';
signal p_s2mm_stop_d2  : std_logic := '0';
signal p_s2mm_stop_d3  : std_logic := '0';
signal p_s2mm_stop_re  : std_logic := '0';
  --ATTRIBUTE async_reg OF p_s2mm_stop_d1_cdc_tig  : SIGNAL IS "true";
  --ATTRIBUTE async_reg OF p_s2mm_stop_d2  : SIGNAL IS "true";
begin



    -- Generate Asynchronous FIFO
    I_STSSTRM_FIFO : entity axi_dma_v7_1_8.axi_dma_afifo_autord
      generic map(
         C_DWIDTH        => C_S_AXIS_S2MM_STS_TDATA_WIDTH + 1    ,
--         C_DEPTH         => STSSTRM_FIFO_DEPTH                  ,
--         C_CNT_WIDTH     => STSSTRM_FIFO_CNT_WIDTH              ,
         C_DEPTH         => 15                  ,
         C_CNT_WIDTH     => 4                   ,
         C_USE_BLKMEM    => USE_LOGIC_FIFOS                     ,
         C_FAMILY        => C_FAMILY
        )
      port map(
        -- Inputs
         AFIFO_Ainit                => fifo_sinit               ,
         AFIFO_Wr_clk               => axi_prmry_aclk           ,
         AFIFO_Wr_en                => fifo_wren                ,
         AFIFO_Din                  => fifo_din                 ,
         AFIFO_Rd_clk               => m_axi_sg_aclk            ,
         AFIFO_Rd_en                => stsstrm_fifo_rden        ,
         AFIFO_Clr_Rd_Data_Valid    => '0'                      ,

        -- Outputs
         AFIFO_DValid               => open                     ,
         AFIFO_Dout                 => stsstrm_fifo_dout        ,
         AFIFO_Full                 => fifo_full                ,
         AFIFO_Empty                => stsstrm_fifo_empty       ,
         AFIFO_Almost_full          => open                     ,
         AFIFO_Almost_empty         => open                     ,
         AFIFO_Wr_count             => open                     ,
         AFIFO_Rd_count             => open                     ,
         AFIFO_Corr_Rd_count        => open                     ,
         AFIFO_Corr_Rd_count_minus1 => open                     ,
         AFIFO_Rd_ack               => open
        );

    fifo_sinit              <= not p_reset_n;

    fifo_din                <= sts_tlast & sts_tdata;
    fifo_wren               <= sts_tvalid               -- valid data
                                and not fifo_full       -- fifo has room
                                and not rxlength_valid_trdy --rxlength_valid_cdc_from  -- not holding a valid length
                                and not mask_tag_write; -- not masking off tag word

    sts_tready              <= not fifo_sinit and not fifo_full and not rxlength_valid_trdy; --rxlength_valid_cdc_from;
-- CR565502 - particular throttle condition caused masking of tag write to not occur
-- simplified logic will provide more robust handling of tag write mask
--    -- Create register delay of status tvalid in order to create a
--    -- rising edge pulse.  note xx_re signal will hold at 1 if
--    -- fifo full on rising edge of tvalid.
--    REG_TVALID : process(axi_prmry_aclk)
--        begin
--            if(axi_prmry_aclk'EVENT and axi_prmry_aclk = '1')then
--                if(m_axi_sg_aresetn = '0')then
--                    sts_tvalid_d1 <= '0';
--                elsif(fifo_full = '0')then
--                    sts_tvalid_d1 <= sts_tvalid;
--                end if;
--            end if;
--        end process REG_TVALID;
--    -- rising edge on tvalid used to gate off status tag from being
--    -- writen into fifo.
--    sts_tvalid_re <= sts_tvalid and not sts_tvalid_d1;

    REG_TAG_STRIPPED : process(axi_prmry_aclk)
        begin
            if(axi_prmry_aclk'EVENT and axi_prmry_aclk = '1')then
                if(p_reset_n = '0')then
                    tag_stripped <= '0';
                -- Reset on write of last word
                elsif(fifo_wren = '1' and sts_tlast = '1')then
                    tag_stripped <= '0';
                -- Set on beginning of new status stream
                elsif(sts_tready = '1' and sts_tvalid = '1')then
                    tag_stripped <= '1';
                end if;
            end if;
        end process REG_TAG_STRIPPED;

-- CR565502 - particular throttle condition caused masking of tag write to not occur
-- simplified logic will provide more robust handling of tag write mask
--    REG_MASK_TAG : process(axi_prmry_aclk)
--        begin
--            if(axi_prmry_aclk'EVENT and axi_prmry_aclk = '1')then
--                if(m_axi_sg_aresetn = '0')then
--                    mask_tag_hold <= '0';
--                elsif(tag_stripped = '1')then
--                    mask_tag_hold <= '0';
--
--                elsif(sts_tvalid_re = '1'
--                or (fifo_wren = '1' and sts_tlast = '1'))then
--                    mask_tag_hold <= '1';
--                end if;
--            end if;
--        end process;
--
--    -- Mask TAG if not already masked and rising edge of tvalid
--    mask_tag_write <= not tag_stripped and (sts_tvalid_re or mask_tag_hold);

    mask_tag_write <= not tag_stripped and sts_tready and sts_tvalid;

    -- Generate logic to capture receive length when Use Receive Length is
    -- enabled
    GEN_STS_APP_LENGTH : if C_SG_USE_STSAPP_LENGTH = 1 generate
    signal rxlength_clr_d1_cdc_tig      : std_logic := '0';
    signal rxlength_clr_d2      : std_logic := '0';

    signal rxlength_d1_cdc_to          : std_logic_vector(C_SG_LENGTH_WIDTH-1 downto 0) := (others => '0');
    signal rxlength_d2          : std_logic_vector(C_SG_LENGTH_WIDTH-1 downto 0) := (others => '0');
    signal rxlength_valid_d1_cdc_to    : std_logic := '0';
    signal rxlength_valid_d2_cdc_from    : std_logic := '0';
    signal rxlength_valid_d3    : std_logic := '0';
    signal rxlength_valid_d4    : std_logic := '0';
    signal rxlength_valid_d1_back_cdc_to, rxlength_valid_d2_back : std_logic := '0';
      ATTRIBUTE async_reg                      : STRING;
      --ATTRIBUTE async_reg OF rxlength_d1_cdc_to  : SIGNAL IS "true";
      --ATTRIBUTE async_reg OF rxlength_d2  : SIGNAL IS "true";
      --ATTRIBUTE async_reg OF rxlength_valid_d1_cdc_to  : SIGNAL IS "true";
      --ATTRIBUTE async_reg OF rxlength_valid_d1_back_cdc_to  : SIGNAL IS "true";
      --ATTRIBUTE async_reg OF rxlength_valid_d2_back  : SIGNAL IS "true";
    

    begin
        -- Double register from secondary clock domain to primary
S2P_CLK_CROSS : entity  lib_cdc_v1_0_2.cdc_sync
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
        prmry_in                   => s2mm_rxlength_clr,
        prmry_vect_in              => (others => '0'),

        scndry_aclk                => axi_prmry_aclk,
        scndry_resetn              => '0',
        scndry_out                 => rxlength_clr_d2,
        scndry_vect_out            => open
    );

--        S2P_CLK_CROSS : process(axi_prmry_aclk)
--            begin
--                if(axi_prmry_aclk'EVENT and axi_prmry_aclk = '1')then
--                    if(p_reset_n = '0')then
--                        rxlength_clr_d1_cdc_tig <= '0';
--                        rxlength_clr_d2 <= '0';
--                    else
--                        rxlength_clr_d1_cdc_tig <= s2mm_rxlength_clr;
--                        rxlength_clr_d2 <= rxlength_clr_d1_cdc_tig;
--                    end if;
--                end if;
--            end process S2P_CLK_CROSS;

        -- Register receive length on assertion of last and valid
        -- Mark rxlength as valid for higher processes

        TRDY_RXLENGTH : process(axi_prmry_aclk)
            begin
                if(axi_prmry_aclk'EVENT and axi_prmry_aclk = '1')then
                    if(p_reset_n = '0' or rxlength_clr_d2 = '1')then
                        rxlength_valid_trdy <= '0';
                    elsif(sts_tlast = '1' and sts_tvalid = '1' and sts_tready = '1')then
                        rxlength_valid_trdy <= '1';
                    end if;
                end if;
            end process TRDY_RXLENGTH;


        REG_RXLENGTH : process(axi_prmry_aclk)
            begin
                if(axi_prmry_aclk'EVENT and axi_prmry_aclk = '1')then
                    if(p_reset_n = '0') then -- or rxlength_clr_d2 = '1')then
                        rxlength_cdc_from       <= (others => '0');
                        rxlength_valid_cdc_from <= '0';
                    elsif(sts_tlast = '1' and sts_tvalid = '1' and sts_tready = '1')then
                        rxlength_cdc_from       <= sts_tdata(C_SG_LENGTH_WIDTH-1 downto 0);
                        rxlength_valid_cdc_from <= '1';
                    elsif (rxlength_valid_d2_back = '1') then
                        rxlength_valid_cdc_from <= '0';
                    end if;
                end if;
            end process REG_RXLENGTH;


SYNC_RXLENGTH : entity  lib_cdc_v1_0_2.cdc_sync
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
        prmry_in                   => rxlength_valid_d2_cdc_from,
        prmry_vect_in              => (others => '0'),

        scndry_aclk                => axi_prmry_aclk,
        scndry_resetn              => '0',
        scndry_out                 => rxlength_valid_d2_back,
        scndry_vect_out            => open
    );

--        SYNC_RXLENGTH : process(axi_prmry_aclk)
--            begin
--                if(axi_prmry_aclk'EVENT and axi_prmry_aclk = '1')then
--                    if(p_reset_n = '0') then -- or rxlength_clr_d2 = '1')then
--
--                        rxlength_valid_d1_back_cdc_to   <= '0';
--                        rxlength_valid_d2_back   <= '0';
--                    else 
--                        rxlength_valid_d1_back_cdc_to   <= rxlength_valid_d2_cdc_from;
--                        rxlength_valid_d2_back   <= rxlength_valid_d1_back_cdc_to;
--                    
--                    end if;
--                end if;
--            end process SYNC_RXLENGTH;


        -- Double register from primary clock domain to secondary

P2S_CLK_CROSS : entity  lib_cdc_v1_0_2.cdc_sync
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
        prmry_in                   => rxlength_valid_cdc_from,
        prmry_vect_in              => (others => '0'),

        scndry_aclk                => m_axi_sg_aclk,
        scndry_resetn              => '0',
        scndry_out                 => rxlength_valid_d2_cdc_from,
        scndry_vect_out            => open
    );


P2S_CLK_CROSS2 : entity  lib_cdc_v1_0_2.cdc_sync
    generic map (
        C_CDC_TYPE                 => 1,
        C_RESET_STATE              => 0,
        C_SINGLE_BIT               => 0,
        C_VECTOR_WIDTH             => C_SG_LENGTH_WIDTH,
        C_MTBF_STAGES              => MTBF_STAGES
    )
    port map (
        prmry_aclk                 => '0',
        prmry_resetn               => '0',
        prmry_in                   => '0',
        prmry_vect_in              => rxlength_cdc_from,

        scndry_aclk                => m_axi_sg_aclk,
        scndry_resetn              => '0',
        scndry_out                 => open, 
        scndry_vect_out            => rxlength_d2
    );


        P2S_CLK_CROSS1 : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0') then -- or s2mm_rxlength_clr = '1') then
--                        rxlength_d1_cdc_to         <= (others => '0');
--                        rxlength_d2         <= (others => '0');
--                        rxlength_valid_d1_cdc_to   <= '0';
--                        rxlength_valid_d2_cdc_from   <= '0';
                        rxlength_valid_d3   <= '0';
                    else
--                        rxlength_d1_cdc_to         <= rxlength_cdc_from;
--                        rxlength_d2         <= rxlength_d1_cdc_to;
--                        rxlength_valid_d1_cdc_to   <= rxlength_valid_cdc_from;
--                        rxlength_valid_d2_cdc_from   <= rxlength_valid_d1_cdc_to;
                        rxlength_valid_d3   <= rxlength_valid_d2_cdc_from;
                    end if;
                end if;
            end process P2S_CLK_CROSS1;

           process (m_axi_sg_aclk)
           begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0' or s2mm_rxlength_clr = '1')then
                        rxlength_valid_d4 <= '0';    
                    elsif (rxlength_valid_d3 = '1' and rxlength_valid_d2_cdc_from = '0') then
                        rxlength_valid_d4 <= '1';    
                    end if;
                 end if;
           end process;

        s2mm_rxlength       <= rxlength_d2;
       -- s2mm_rxlength_valid <= rxlength_valid_d2;
        s2mm_rxlength_valid <= rxlength_valid_d4;

    end generate GEN_STS_APP_LENGTH;

    -- Do NOT generate logic to capture receive length when option disabled
    GEN_NO_STS_APP_LENGTH : if C_SG_USE_STSAPP_LENGTH = 0 generate
        s2mm_rxlength_valid <= '0';
        s2mm_rxlength       <= (others => '0');
    end generate GEN_NO_STS_APP_LENGTH;

    -- CR605883
    -- Register stop to provide pure FF output for synchronizer
    REG_STOP : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    s2mm_stop_reg <= '0';
                else
                    s2mm_stop_reg <= s2mm_stop;
                end if;
            end if;
        end process REG_STOP;


    -- double register s2mm error into primary clock domain

REG_ERR2PRMRY : entity  lib_cdc_v1_0_2.cdc_sync
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
        prmry_in                   => s2mm_stop_reg,
        prmry_vect_in              => (others => '0'),

        scndry_aclk                => axi_prmry_aclk,
        scndry_resetn              => '0',
        scndry_out                 => p_s2mm_stop_d2,
        scndry_vect_out            => open
    );


    REG_ERR2PRMRY1 : process(axi_prmry_aclk)
        begin
            if(axi_prmry_aclk'EVENT and axi_prmry_aclk = '1')then
                if(p_reset_n = '0')then
--                    p_s2mm_stop_d1_cdc_tig <= '0';
--                    p_s2mm_stop_d2 <= '0';
                    p_s2mm_stop_d3 <= '0';
                else
                    --p_s2mm_stop_d1_cdc_tig <= s2mm_stop;      -- CR605883
--                    p_s2mm_stop_d1_cdc_tig <= s2mm_stop_reg;
--                    p_s2mm_stop_d2 <= p_s2mm_stop_d1_cdc_tig;
                    p_s2mm_stop_d3 <= p_s2mm_stop_d2;
                end if;
            end if;
        end process REG_ERR2PRMRY1;

    p_s2mm_stop_re <= p_s2mm_stop_d2 and not p_s2mm_stop_d3;

    skid_rst   <= not p_reset_n;

    ---------------------------------------------------------------------------
    -- Buffer AXI Signals
    ---------------------------------------------------------------------------
    STS_SKID_BUF_I : entity axi_dma_v7_1_8.axi_dma_skid_buf
        generic map(
            C_WDATA_WIDTH       => C_S_AXIS_S2MM_STS_TDATA_WIDTH
        )
        port map(
            -- System Ports
            ACLK                => axi_prmry_aclk                           ,
            ARST                => skid_rst                                 ,

            skid_stop           => p_s2mm_stop_re                           ,

            -- Slave Side (Stream Data Input)
            S_VALID             => s_axis_s2mm_sts_tvalid                   ,
            S_READY             => s_axis_s2mm_sts_tready                   ,
            S_Data              => s_axis_s2mm_sts_tdata                    ,
            S_STRB              => s_axis_s2mm_sts_tkeep                    ,
            S_Last              => s_axis_s2mm_sts_tlast                    ,

            -- Master Side (Stream Data Output
            M_VALID             => sts_tvalid                               ,
            M_READY             => sts_tready                               ,
            M_Data              => sts_tdata                                ,
            M_STRB              => sts_tkeep                                ,
            M_Last              => sts_tlast
        );


end generate GEN_ASYNC_FIFO;




end implementation;
