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
-- Filename:          axi_sg_updt_noqueue.vhd
-- Description: This entity provides the descriptor update for the No Queue mode
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
entity  axi_sg_updt_noqueue is
    generic (
        C_M_AXI_SG_ADDR_WIDTH       : integer range 32 to 64        := 32;
            -- Master AXI Memory Map Address Width for Scatter Gather R/W Port

        C_M_AXIS_UPDT_DATA_WIDTH    : integer range 32 to 32        := 32;
            -- Master AXI Memory Map Data Width for Scatter Gather R/W Port

        C_S_AXIS_UPDPTR_TDATA_WIDTH : integer range 32 to 32         := 32;
            -- 32 Update Status Bits

        C_S_AXIS_UPDSTS_TDATA_WIDTH : integer range 33 to 33         := 33
            -- 1 IOC bit + 32 Update Status Bits
    );
    port (
        -----------------------------------------------------------------------
        -- AXI Scatter Gather Interface
        -----------------------------------------------------------------------
        m_axi_sg_aclk           : in  std_logic                         ;               --
        m_axi_sg_aresetn        : in  std_logic                         ;               --
                                                                                        --
        -- Channel 1 Control                                                            --
        updt_curdesc_wren       : out std_logic                         ;               --
        updt_curdesc            : out std_logic_vector                                  --
                                    (C_M_AXI_SG_ADDR_WIDTH-1 downto 0)  ;               --
        updt_active             : in  std_logic                         ;               --
        updt_queue_empty        : out std_logic                         ;               --
        updt_ioc                : out std_logic                         ;               --
        updt_ioc_irq_set        : in  std_logic                         ;               --
                                                                                        --
        dma_interr              : out std_logic                         ;               --
        dma_slverr              : out std_logic                         ;               --
        dma_decerr              : out std_logic                         ;               --
        dma_interr_set          : in  std_logic                         ;               --
        dma_slverr_set          : in  std_logic                         ;               --
        dma_decerr_set          : in  std_logic                         ;               --


        updt2_active             : in  std_logic                         ;               --
        updt2_queue_empty        : out std_logic                         ;               --
        updt2_ioc                : out std_logic                         ;               --
        updt2_ioc_irq_set        : in  std_logic                         ;               --
                                                                                        --
        dma2_interr              : out std_logic                         ;               --
        dma2_slverr              : out std_logic                         ;               --
        dma2_decerr              : out std_logic                         ;               --
        dma2_interr_set          : in  std_logic                         ;               --
        dma2_slverr_set          : in  std_logic                         ;               --
        dma2_decerr_set          : in  std_logic                         ;               --
                                                                                        --
        --*********************************--                                           --
        --** Channel Update Interface In **--                                           --
        --*********************************--                                           --
        -- Update Pointer Stream                                                        --
        s_axis_updtptr_tdata    : in  std_logic_vector                                  --
                                    (C_M_AXI_SG_ADDR_WIDTH-1 downto 0) ;          --
        s_axis_updtptr_tvalid   : in  std_logic                         ;               --
        s_axis_updtptr_tready   : out std_logic                         ;               --
        s_axis_updtptr_tlast    : in  std_logic                         ;               --
                                                                                        --
        -- Update Status Stream                                                         --
        s_axis_updtsts_tdata    : in  std_logic_vector                                  --
                                     (C_S_AXIS_UPDSTS_TDATA_WIDTH-1 downto 0);          --
        s_axis_updtsts_tvalid   : in  std_logic                         ;               --
        s_axis_updtsts_tready   : out std_logic                         ;               --
        s_axis_updtsts_tlast    : in  std_logic                         ;               --

        -- Update Pointer Stream                                                        --
        s_axis2_updtptr_tdata    : in  std_logic_vector                                  --
                                    (C_M_AXI_SG_ADDR_WIDTH-1 downto 0) ;          --
        s_axis2_updtptr_tvalid   : in  std_logic                         ;               --
        s_axis2_updtptr_tready   : out std_logic                         ;               --
        s_axis2_updtptr_tlast    : in  std_logic                         ;               --
                                                                                        --
        -- Update Status Stream                                                         --
        s_axis2_updtsts_tdata    : in  std_logic_vector                                  --
                                     (C_S_AXIS_UPDSTS_TDATA_WIDTH-1 downto 0);          --
        s_axis2_updtsts_tvalid   : in  std_logic                         ;               --
        s_axis2_updtsts_tready   : out std_logic                         ;               --
        s_axis2_updtsts_tlast    : in  std_logic                         ;               --
                                                                                        --
        --*********************************--                                           --
        --** Channel Update Interface Out**--                                           --
        --*********************************--                                           --
        -- S2MM Stream Out To DataMover                                                 --
        m_axis_updt_tdata       : out std_logic_vector                                  --
                                    (C_M_AXIS_UPDT_DATA_WIDTH-1 downto 0);              --
        m_axis_updt_tlast       : out std_logic                         ;               --
        m_axis_updt_tvalid      : out std_logic                         ;               --
        m_axis_updt_tready      : in  std_logic                                         --


    );

end axi_sg_updt_noqueue;

-------------------------------------------------------------------------------
-- Architecture
-------------------------------------------------------------------------------
architecture implementation of axi_sg_updt_noqueue is
  attribute DowngradeIPIdentifiedWarnings: string;
  attribute DowngradeIPIdentifiedWarnings of implementation : architecture is "yes";


-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------

-- No Functions Declared

-------------------------------------------------------------------------------
-- Constants Declarations
-------------------------------------------------------------------------------

-- No Contstants Declared

-------------------------------------------------------------------------------
-- Signal / Type Declarations
-------------------------------------------------------------------------------
-- Channel signals
signal writing_curdesc      : std_logic := '0';


signal write_curdesc_lsb    : std_logic := '0';
signal write_curdesc_msb    : std_logic := '0';
signal updt_active_d1       : std_logic := '0';
signal updt_active_re       : std_logic := '0';


type PNTR_STATE_TYPE      is (IDLE,
                              READ_CURDESC_LSB,
                              READ_CURDESC_MSB,
                              WRITE_STATUS
                              );

signal pntr_cs              : PNTR_STATE_TYPE;
signal pntr_ns              : PNTR_STATE_TYPE;

signal writing_status       : std_logic := '0';
signal curdesc_tready       : std_logic := '0';
signal writing_status_d1    : std_logic := '0';
signal writing_status_re    : std_logic := '0';
signal writing_status_re_ch1    : std_logic := '0';
signal writing_status_re_ch2    : std_logic := '0';

signal updt_active_int      : std_logic := '0';
signal s_axis_updtptr_tvalid_int : std_logic := '0';
signal s_axis_updtsts_tvalid_int : std_logic := '0';
signal s_axis_updtsts_tlast_int : std_logic := '0';

signal s_axis_updtptr_tdata_int : std_logic_vector (C_M_AXI_SG_ADDR_WIDTH-1 downto 0) := (others => '0'); 

signal s_axis_qual : std_logic := '0';
signal s_axis2_qual : std_logic := '0';

signal m_axis_updt_tdata_mm2s       : std_logic_vector  (31 downto 0);                                 --
signal m_axis_updt_tlast_mm2s       : std_logic                         ;               --
signal m_axis_updt_tvalid_mm2s      : std_logic   ;

signal m_axis_updt_tdata_s2mm       : std_logic_vector  (31 downto 0);                                 --
signal m_axis_updt_tlast_s2mm       : std_logic                         ;               --
signal m_axis_updt_tvalid_s2mm      : std_logic   ;

-------------------------------------------------------------------------------
-- Begin architecture logic
-------------------------------------------------------------------------------
begin

    m_axis_updt_tdata <= m_axis_updt_tdata_mm2s when updt_active = '1' else
                         m_axis_updt_tdata_s2mm;

    m_axis_updt_tvalid <= m_axis_updt_tvalid_mm2s when updt_active = '1' else
                         m_axis_updt_tvalid_s2mm;

    m_axis_updt_tlast <= m_axis_updt_tlast_mm2s when updt_active = '1' else
                         m_axis_updt_tlast_s2mm;

    updt_active_int <= updt_active or updt2_active;

    s_axis_updtptr_tvalid_int <= s_axis_updtptr_tvalid or s_axis2_updtptr_tvalid;
    s_axis_updtsts_tvalid_int <= s_axis_updtsts_tvalid or s_axis2_updtsts_tvalid;
    s_axis_updtsts_tlast_int <= s_axis_updtsts_tlast or s_axis2_updtsts_tlast;

    s_axis_qual <= s_axis_updtsts_tvalid and s_axis_updtsts_tlast and updt_active;
    s_axis2_qual <= s_axis2_updtsts_tvalid and s_axis2_updtsts_tlast and updt2_active;
    -- Asset active strobe on rising edge of update active
    -- asertion.  This kicks off the update process for
    -- the channel
    REG_ACTIVE : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    updt_active_d1 <= '0';
                else
                    updt_active_d1 <= updt_active or updt2_active;
                end if;
            end if;
        end process REG_ACTIVE;

    updt_active_re  <= (updt_active or updt2_active) and not updt_active_d1;


    -- Current Descriptor Pointer Fetch.  This state machine controls
    -- reading out the current pointer from the Queue or channel port
    -- and writing it to the update manager for use in command
    -- generation to the DataMover for Descriptor update.
    CURDESC_PNTR_STATE : process(pntr_cs,
                                 updt_active_int,
                                 s_axis_updtptr_tvalid_int,
                                 updt_active, updt2_active,
                                 s_axis_qual, s_axis2_qual,
                                 s_axis_updtptr_tvalid,
                                 s_axis2_updtptr_tvalid,
                                 s_axis_updtsts_tvalid_int,
                                 m_axis_updt_tready)
        begin

            write_curdesc_lsb   <= '0';
            write_curdesc_msb   <= '0';
            writing_status      <= '0';
            writing_curdesc     <= '0';
            curdesc_tready      <= '0';
            pntr_ns             <= pntr_cs;

            case pntr_cs is

                when IDLE =>
                    if((s_axis_updtptr_tvalid = '1' and updt_active = '1') or 
                       (s_axis2_updtptr_tvalid = '1' and updt2_active = '1')) then
                        writing_curdesc <= '1';
                        pntr_ns <= READ_CURDESC_LSB;
                    else
                        pntr_ns <= IDLE;
                    end if;

                ---------------------------------------------------------------
                -- Get lower current descriptor
                when READ_CURDESC_LSB =>
                    curdesc_tready  <= '1';
                    writing_curdesc <= '1';
                    -- on tvalid from Queue or channel port then register
                    -- lsb curdesc and setup to register msb curdesc

                    if(s_axis_updtptr_tvalid_int = '1' and updt_active_int = '1')then
                        write_curdesc_lsb   <= '1';
--                        pntr_ns             <= READ_CURDESC_MSB;
                        pntr_ns             <= WRITE_STATUS;
                    else
                    -- coverage off  
                        pntr_ns <= READ_CURDESC_LSB;
                    -- coverage on
                    end if;

                    -- coverage off  
                ---------------------------------------------------------------
                -- Get upper current descriptor
                when READ_CURDESC_MSB =>
                    curdesc_tready  <= '1';
                    writing_curdesc <= '1';
                    -- On tvalid from Queue or channel port then register
                    -- msb.  This will also write curdesc out to update
                    -- manager.
                    if(s_axis_updtptr_tvalid_int = '1')then
                        write_curdesc_msb   <= '1';
                        pntr_ns             <= WRITE_STATUS;
                    else
                        pntr_ns             <= READ_CURDESC_MSB;
                    end if;
                    -- coverage on

                ---------------------------------------------------------------
                -- Hold in this state until remainder of descriptor is
                -- written out.
                when WRITE_STATUS =>
                    writing_status <= '1'; --s_axis_updtsts_tvalid_int;
                    if((s_axis_qual = '1' and m_axis_updt_tready = '1') or
                      (s_axis2_qual = '1' and m_axis_updt_tready = '1')) then
                        pntr_ns        <= IDLE;
                    else
                        pntr_ns         <= WRITE_STATUS;
                    end if;

                    -- coverage off  
                when others =>
                    pntr_ns             <= IDLE;
                    -- coverage on  

            end case;
        end process CURDESC_PNTR_STATE;

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

    -- Status stream signals
    m_axis_updt_tdata_mm2s              <= s_axis_updtsts_tdata(C_S_AXIS_UPDSTS_TDATA_WIDTH-2 downto 0);
    m_axis_updt_tvalid_mm2s             <= s_axis_updtsts_tvalid and writing_status;
    m_axis_updt_tlast_mm2s              <= s_axis_updtsts_tlast and writing_status;

    s_axis_updtsts_tready   <= m_axis_updt_tready and writing_status and updt_active;

    -- Pointer stream signals
    s_axis_updtptr_tready   <= curdesc_tready and updt_active;

    -- Indicate need for channel service for update state machine
    updt_queue_empty    <= not (s_axis_updtsts_tvalid); -- and writing_status);


    m_axis_updt_tdata_s2mm              <= s_axis2_updtsts_tdata(C_S_AXIS_UPDSTS_TDATA_WIDTH-2 downto 0);
    m_axis_updt_tvalid_s2mm             <= s_axis2_updtsts_tvalid and writing_status;
    m_axis_updt_tlast_s2mm              <= s_axis2_updtsts_tlast and writing_status;

    s_axis2_updtsts_tready   <= m_axis_updt_tready and writing_status and updt2_active;

    -- Pointer stream signals
    s_axis2_updtptr_tready   <= curdesc_tready and updt2_active;

    -- Indicate need for channel service for update state machine
    updt2_queue_empty    <= not (s_axis2_updtsts_tvalid); -- and writing_status);




--*********************************************************************
--** POINTER CAPTURE LOGIC
--*********************************************************************
      
      s_axis_updtptr_tdata_int <= s_axis_updtptr_tdata when (updt_active = '1') else
                                  s_axis2_updtptr_tdata;
   
    ---------------------------------------------------------------------------
    -- Write lower order Next Descriptor Pointer out to pntr_mngr
    ---------------------------------------------------------------------------
    REG_LSB_CURPNTR : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0' )then
                    updt_curdesc(31 downto 0)    <= (others => '0');

                -- Capture lower pointer from FIFO or channel port
                elsif(write_curdesc_lsb = '1')then
                    updt_curdesc(31 downto 0)    <= s_axis_updtptr_tdata_int(31 downto 0);

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
                        updt_curdesc(63 downto 32)   <= (others => '0');
                        updt_curdesc_wren            <= '0';
                    -- Capture upper pointer from FIFO or channel port
                    -- and also write curdesc out
                    elsif(write_curdesc_lsb = '1')then
                        updt_curdesc(63 downto 32)   <= s_axis_updtptr_tdata_int(C_M_AXI_SG_ADDR_WIDTH-1 downto 32);
                        updt_curdesc_wren            <= '1';
                    -- Assert tready/wren for only 1 clock
                    else
                        updt_curdesc_wren            <= '0';
                    end if;
                end if;
            end process REG_MSB_CURPNTR;

    end generate GEN_UPPER_MSB_CURDESC;

    ---------------------------------------------------------------------------
    -- 32 Bit Scatter Gather addresses enabled
    ---------------------------------------------------------------------------
    GEN_NO_UPR_MSB_CURDESC : if C_M_AXI_SG_ADDR_WIDTH = 32 generate
    begin

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
                    elsif(write_curdesc_lsb = '1')then
                 --   elsif(write_curdesc_msb = '1')then
                        updt_curdesc_wren            <= '1';
                    -- Assert for only 1 clock
                    else
                        updt_curdesc_wren            <= '0';
                    end if;
                end if;
            end process REG_MSB_CURPNTR;

    end generate GEN_NO_UPR_MSB_CURDESC;




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

    ---------------------------------------------------------------------------
    -- Caputure IOC begin set
    ---------------------------------------------------------------------------
    REG_IOC_PROCESS : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0' or updt_ioc_irq_set = '1')then
                    updt_ioc <= '0';
                elsif(writing_status_re_ch1 = '1')then
                    updt_ioc <= s_axis_updtsts_tdata(DESC_IOC_TAG_BIT);
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
                    dma_interr <=  s_axis_updtsts_tdata(DESC_STS_INTERR_BIT);
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
                    dma_slverr <=  s_axis_updtsts_tdata(DESC_STS_SLVERR_BIT);
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
                    dma_decerr <=  s_axis_updtsts_tdata(DESC_STS_DECERR_BIT);
                end if;
            end if;
        end process CAPTURE_DMADEC_ERROR;


    ---------------------------------------------------------------------------
    -- Caputure IOC begin set
    ---------------------------------------------------------------------------
    REG2_IOC_PROCESS : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0' or updt2_ioc_irq_set = '1')then
                    updt2_ioc <= '0';
                elsif(writing_status_re_ch2 = '1')then
                    updt2_ioc <= s_axis2_updtsts_tdata(DESC_IOC_TAG_BIT);
                end if;
            end if;
        end process REG2_IOC_PROCESS;

    -----------------------------------------------------------------------
    -- Capture DMA Internal Errors
    -----------------------------------------------------------------------
    CAPTURE2_DMAINT_ERROR: process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0' or dma2_interr_set = '1')then
                    dma2_interr  <= '0';
                elsif(writing_status_re_ch2 = '1')then
                    dma2_interr <=  s_axis2_updtsts_tdata(DESC_STS_INTERR_BIT);
                end if;
            end if;
        end process CAPTURE2_DMAINT_ERROR;

    -----------------------------------------------------------------------
    -- Capture DMA Slave Errors
    -----------------------------------------------------------------------
    CAPTURE2_DMASLV_ERROR: process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0' or dma2_slverr_set = '1')then
                    dma2_slverr  <= '0';
                elsif(writing_status_re_ch2 = '1')then
                    dma2_slverr <=  s_axis2_updtsts_tdata(DESC_STS_SLVERR_BIT);
                end if;
            end if;
        end process CAPTURE2_DMASLV_ERROR;

    -----------------------------------------------------------------------
    -- Capture DMA Decode Errors
    -----------------------------------------------------------------------
    CAPTURE2_DMADEC_ERROR: process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0' or dma2_decerr_set = '1')then
                    dma2_decerr  <= '0';
                elsif(writing_status_re_ch2 = '1')then
                    dma2_decerr <=  s_axis2_updtsts_tdata(DESC_STS_DECERR_BIT);
                end if;
            end if;
        end process CAPTURE2_DMADEC_ERROR;


end implementation;
