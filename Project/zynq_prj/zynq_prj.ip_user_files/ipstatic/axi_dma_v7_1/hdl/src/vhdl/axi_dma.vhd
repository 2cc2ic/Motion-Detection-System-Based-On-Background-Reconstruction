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
-- Filename:          axi_dma.vhd
-- Description: This entity is the top level entity for the AXI DMA core.
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

library axi_sg_v4_1_2;
use axi_sg_v4_1_2.all;

library axi_datamover_v5_1_9;
use axi_datamover_v5_1_9.all;

library lib_pkg_v1_0_2;
use lib_pkg_v1_0_2.lib_pkg.max2;


-------------------------------------------------------------------------------
entity  axi_dma is
    generic(
        C_S_AXI_LITE_ADDR_WIDTH          : integer range 2 to 32    := 10;
            -- Address width of the AXI Lite Interface

        C_S_AXI_LITE_DATA_WIDTH          : integer range 32 to 32    := 32;
            -- Data width of the AXI Lite Interface

        C_DLYTMR_RESOLUTION         : integer range 1 to 100000      := 125;
            -- Interrupt Delay Timer resolution in usec

        C_PRMRY_IS_ACLK_ASYNC        : integer range 0 to 1          := 0;
            -- Primary MM2S/S2MM sync/async mode
            -- 0 = synchronous mode     - all clocks are synchronous
            -- 1 = asynchronous mode    - Any one of the 4 clock inputs is not
            --                            synchronous to the other
        -----------------------------------------------------------------------
        -- Scatter Gather Parameters
        -----------------------------------------------------------------------
        C_INCLUDE_SG                : integer range 0 to 1          := 1;
            -- Include or Exclude the Scatter Gather Engine
            -- 0 = Exclude SG Engine - Enables Simple DMA Mode
            -- 1 = Include SG Engine - Enables Scatter Gather Mode

  --      C_SG_INCLUDE_DESC_QUEUE     : integer range 0 to 1          := 0;
            -- Include or Exclude Scatter Gather Descriptor Queuing
            -- 0 = Exclude SG Descriptor Queuing
            -- 1 = Include SG Descriptor Queuing

        C_SG_INCLUDE_STSCNTRL_STRM  : integer range 0 to 1          := 1;
            -- Include or Exclude AXI Status and AXI Control Streams
            -- 0 = Exclude Status and Control Streams
            -- 1 = Include Status and Control Streams

        C_SG_USE_STSAPP_LENGTH      : integer range 0 to 1          := 1;
            -- Enable or Disable use of Status Stream Rx Length.  Only valid
            -- if C_SG_INCLUDE_STSCNTRL_STRM = 1
            -- 0 = Don't use Rx Length
            -- 1 = Use Rx Length

        C_SG_LENGTH_WIDTH           : integer range 8 to 23         := 14;
            -- Descriptor Buffer Length, Transferred Bytes, and Status Stream
            -- Rx Length Width.  Indicates the least significant valid bits of
            -- descriptor buffer length, transferred bytes, or Rx Length value
            -- in the status word coincident with tlast.

        C_M_AXI_SG_ADDR_WIDTH       : integer range 32 to 64        := 32;
            -- Master AXI Memory Map Address Width for Scatter Gather R/W Port

        C_M_AXI_SG_DATA_WIDTH       : integer range 32 to 32        := 32;
            -- Master AXI Memory Map Data Width for Scatter Gather R/W Port

        C_M_AXIS_MM2S_CNTRL_TDATA_WIDTH : integer range 32 to 32    := 32;
            -- Master AXI Control Stream Data Width

        C_S_AXIS_S2MM_STS_TDATA_WIDTH   : integer range 32 to 32    := 32;
            -- Slave AXI Status Stream Data Width

        -----------------------------------------------------------------------
        -- Memory Map to Stream (MM2S) Parameters
        -----------------------------------------------------------------------
        C_INCLUDE_MM2S                  : integer range 0 to 1      := 1;
            -- Include or exclude MM2S primary data path
            -- 0 = Exclude MM2S primary data path
            -- 1 = Include MM2S primary data path

        C_INCLUDE_MM2S_SF               : integer range 0 to 1      := 1;
          -- This parameter specifies the inclusion/omission of the
          -- MM2S (Read) Store and Forward function
          -- 0 = Omit MM2S Store and Forward
          -- 1 = Include MM2S Store and Forward

        C_INCLUDE_MM2S_DRE              : integer range 0 to 1      := 0;
            -- Include or exclude MM2S data realignment engine (DRE)
            -- 0 = Exclude MM2S DRE
            -- 1 = Include MM2S DRE

        C_MM2S_BURST_SIZE               : integer range 2 to 256   := 16;
            -- Maximum burst size per burst request on MM2S Read Port


        C_M_AXI_MM2S_ADDR_WIDTH         : integer range 32 to 64    := 32;
            -- Master AXI Memory Map Address Width for MM2S Read Port

        C_M_AXI_MM2S_DATA_WIDTH         : integer range 32 to 1024  := 32;
            -- Master AXI Memory Map Data Width for MM2S Read Port

        C_M_AXIS_MM2S_TDATA_WIDTH       : integer range 8 to 1024    := 32;
            -- Master AXI Stream Data Width for MM2S Channel

        -----------------------------------------------------------------------
        -- Stream to Memory Map (S2MM) Parameters
        -----------------------------------------------------------------------
        C_INCLUDE_S2MM                  : integer range 0 to 1      := 1;
            -- Include or exclude S2MM primary data path
            -- 0 = Exclude S2MM primary data path
            -- 1 = Include S2MM primary data path

        C_INCLUDE_S2MM_SF               : integer range 0 to 1      := 1;
          -- This parameter specifies the inclusion/omission of the
          -- S2MM (Write) Store and Forward function
          -- 0 = Omit S2MM Store and Forward
          -- 1 = Include S2MM Store and Forward


        C_INCLUDE_S2MM_DRE              : integer range 0 to 1      := 0;
            -- Include or exclude S2MM data realignment engine (DRE)
            -- 0 = Exclude S2MM DRE
            -- 1 = Include S2MM DRE

        C_S2MM_BURST_SIZE               : integer range 2 to 256   := 16;
            -- Maximum burst size per burst request on S2MM Write Port

        C_M_AXI_S2MM_ADDR_WIDTH         : integer range 32 to 64    := 32;
            -- Master AXI Memory Map Address Width for S2MM Write Port

        C_M_AXI_S2MM_DATA_WIDTH         : integer range 32 to 1024  := 32;
            -- Master AXI Memory Map Data Width for MM2SS2MMWrite Port

        C_S_AXIS_S2MM_TDATA_WIDTH       : integer range 8 to 1024    := 32;
            -- Slave AXI Stream Data Width for S2MM Channel
        C_ENABLE_MULTI_CHANNEL                 : integer range 0 to 1 := 0;
            -- Enable CACHE support, primarily for MCDMA
        C_NUM_S2MM_CHANNELS             : integer range 1 to 16 := 1;
            -- Number of S2MM channels, primarily for MCDMA
        C_NUM_MM2S_CHANNELS             : integer range 1 to 16 := 1;
            -- Number of MM2S channels, primarily for MCDMA

        C_FAMILY                        : string            := "virtex7";
        C_MICRO_DMA                     : integer range 0 to 1 := 0;
            -- Target FPGA Device Family
        C_INSTANCE                      : string   := "axi_dma"
    );
    port (
        s_axi_lite_aclk             : in  std_logic   := '0'                      ;              --
        m_axi_sg_aclk               : in  std_logic   := '0'                      ;              --
        m_axi_mm2s_aclk             : in  std_logic   := '0'                      ;              --
        m_axi_s2mm_aclk             : in  std_logic   := '0'                      ;              --
    -----------------------------------------------------------------------
    -- Primary Clock CDMA
    -----------------------------------------------------------------------
        axi_resetn                  : in  std_logic   := '0'                      ;              --
                                                                                           --
        -----------------------------------------------------------------------            --
        -- AXI Lite Control Interface                                                      --
        -----------------------------------------------------------------------            --
        -- AXI Lite Write Address Channel                                                  --
        s_axi_lite_awvalid          : in  std_logic   := '0'                      ;              --
        s_axi_lite_awready          : out std_logic                         ;              --
    --    s_axi_lite_awaddr           : in  std_logic_vector                                 --
    --                                    (C_S_AXI_LITE_ADDR_WIDTH-1 downto 0) := (others => '0');              --
        s_axi_lite_awaddr           : in  std_logic_vector                                 --
                                        (9 downto 0) := (others => '0');              --
                                                                                           --
        -- AXI Lite Write Data Channel                                                     --
        s_axi_lite_wvalid           : in  std_logic     := '0'                    ;              --
        s_axi_lite_wready           : out std_logic                         ;              --
        s_axi_lite_wdata            : in  std_logic_vector                                 --
                                        (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');              --
                                                                                           --
        -- AXI Lite Write Response Channel                                                 --
        s_axi_lite_bresp            : out std_logic_vector(1 downto 0)      ;              --
        s_axi_lite_bvalid           : out std_logic                         ;              --
        s_axi_lite_bready           : in  std_logic     := '0'                    ;              --
                                                                                           --
        -- AXI Lite Read Address Channel                                                   --
        s_axi_lite_arvalid          : in  std_logic     := '0'                    ;              --
        s_axi_lite_arready          : out std_logic                         ;              --
     --   s_axi_lite_araddr           : in  std_logic_vector                                 --
     --                                   (C_S_AXI_LITE_ADDR_WIDTH-1 downto 0) := (others => '0');              --
        s_axi_lite_araddr           : in  std_logic_vector                                 --
                                        (9 downto 0) := (others => '0');              --
        s_axi_lite_rvalid           : out std_logic                         ;              --
        s_axi_lite_rready           : in  std_logic     := '0'                    ;              --
        s_axi_lite_rdata            : out std_logic_vector                                 --
                                        (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);              --
        s_axi_lite_rresp            : out std_logic_vector(1 downto 0)      ;              --
                                                                                           --
        -----------------------------------------------------------------------            --
        -- AXI Scatter Gather Interface                                                    --
        -----------------------------------------------------------------------            --
        -- Scatter Gather Write Address Channel                                            --
        m_axi_sg_awaddr             : out std_logic_vector                                 --
                                        (C_M_AXI_SG_ADDR_WIDTH-1 downto 0)  ;              --
        m_axi_sg_awlen              : out std_logic_vector(7 downto 0)      ;              --
        m_axi_sg_awsize             : out std_logic_vector(2 downto 0)      ;              --
        m_axi_sg_awburst            : out std_logic_vector(1 downto 0)      ;              --
        m_axi_sg_awprot             : out std_logic_vector(2 downto 0)      ;              --
        m_axi_sg_awcache            : out std_logic_vector(3 downto 0)      ;              --
        m_axi_sg_awuser             : out std_logic_vector(3 downto 0)      ;              --
        m_axi_sg_awvalid            : out std_logic                         ;              --
        m_axi_sg_awready            : in  std_logic      := '0'                   ;              --
                                                                                           --
        -- Scatter Gather Write Data Channel                                               --
        m_axi_sg_wdata              : out std_logic_vector                                 --
                                        (C_M_AXI_SG_DATA_WIDTH-1 downto 0)  ;              --
        m_axi_sg_wstrb              : out std_logic_vector                                 --
                                        ((C_M_AXI_SG_DATA_WIDTH/8)-1 downto 0);            --
        m_axi_sg_wlast              : out std_logic                         ;              --
        m_axi_sg_wvalid             : out std_logic                         ;              --
        m_axi_sg_wready             : in  std_logic      := '0'                   ;              --
                                                                                           --
        -- Scatter Gather Write Response Channel                                           --
        m_axi_sg_bresp              : in  std_logic_vector(1 downto 0)  := "00"    ;              --
        m_axi_sg_bvalid             : in  std_logic       := '0'                  ;              --
        m_axi_sg_bready             : out std_logic                         ;              --
                                                                                           --
        -- Scatter Gather Read Address Channel                                             --
        m_axi_sg_araddr             : out std_logic_vector                                 --
                                        (C_M_AXI_SG_ADDR_WIDTH-1 downto 0)  ;              --
        m_axi_sg_arlen              : out std_logic_vector(7 downto 0)      ;              --
        m_axi_sg_arsize             : out std_logic_vector(2 downto 0)      ;              --
        m_axi_sg_arburst            : out std_logic_vector(1 downto 0)      ;              --
        m_axi_sg_arprot             : out std_logic_vector(2 downto 0)      ;              --
        m_axi_sg_arcache            : out std_logic_vector(3 downto 0)      ;              --
        m_axi_sg_aruser             : out std_logic_vector(3 downto 0)      ;              --
        m_axi_sg_arvalid            : out std_logic                         ;              --
        m_axi_sg_arready            : in  std_logic       := '0'                  ;              --
                                                                                           --
        -- Memory Map to Stream Scatter Gather Read Data Channel                           --
        m_axi_sg_rdata              : in  std_logic_vector                                 --
                                        (C_M_AXI_SG_DATA_WIDTH-1 downto 0)  := (others => '0');              --
        m_axi_sg_rresp              : in  std_logic_vector(1 downto 0)      := "00";              --
        m_axi_sg_rlast              : in  std_logic                         := '0';              --
        m_axi_sg_rvalid             : in  std_logic                         := '0';              --
        m_axi_sg_rready             : out std_logic                         ;              --
                                                                                           --
                                                                                           --
        -----------------------------------------------------------------------            --
        -- AXI MM2S Channel                                                                --
        -----------------------------------------------------------------------            --
        -- Memory Map To Stream Read Address Channel                                       --
        m_axi_mm2s_araddr           : out std_logic_vector                                 --
                                        (C_M_AXI_MM2S_ADDR_WIDTH-1 downto 0);              --
        m_axi_mm2s_arlen            : out std_logic_vector(7 downto 0)      ;              --
        m_axi_mm2s_arsize           : out std_logic_vector(2 downto 0)      ;              --
        m_axi_mm2s_arburst          : out std_logic_vector(1 downto 0)      ;              --
        m_axi_mm2s_arprot           : out std_logic_vector(2 downto 0)      ;              --
        m_axi_mm2s_arcache          : out std_logic_vector(3 downto 0)      ;              --
        m_axi_mm2s_aruser           : out std_logic_vector(3 downto 0)      ;              --
        m_axi_mm2s_arvalid          : out std_logic                         ;              --
        m_axi_mm2s_arready          : in  std_logic                         := '0';              --
                                                                                           --
        -- Memory Map  to Stream Read Data Channel                                         --
        m_axi_mm2s_rdata            : in  std_logic_vector                                 --
                                        (C_M_AXI_MM2S_DATA_WIDTH-1 downto 0) := (others => '0');              --
        m_axi_mm2s_rresp            : in  std_logic_vector(1 downto 0)      := "00";              --
        m_axi_mm2s_rlast            : in  std_logic                         := '0';              --
        m_axi_mm2s_rvalid           : in  std_logic                         := '0';              --
        m_axi_mm2s_rready           : out std_logic                         ;              --
                                                                                           --
        -- Memory Map to Stream Stream Interface                                           --
        mm2s_prmry_reset_out_n      : out std_logic                         ;              -- CR573702
        m_axis_mm2s_tdata           : out std_logic_vector                                 --
                                        (C_M_AXIS_MM2S_TDATA_WIDTH-1 downto 0);            --
        m_axis_mm2s_tkeep           : out std_logic_vector                                 --
                                        ((C_M_AXIS_MM2S_TDATA_WIDTH/8)-1 downto 0);        --
        m_axis_mm2s_tvalid          : out std_logic                         ;              --
        m_axis_mm2s_tready          : in  std_logic                         := '0';              --
        m_axis_mm2s_tlast           : out std_logic                         ;              --
        m_axis_mm2s_tuser           : out std_logic_vector (3 downto 0)     ;              --
        m_axis_mm2s_tid             : out std_logic_vector (4 downto 0)     ;              --
        m_axis_mm2s_tdest           : out std_logic_vector (4 downto 0)     ;              --
                                                                                           --
        -- Memory Map to Stream Control Stream Interface                                   --
        mm2s_cntrl_reset_out_n      : out std_logic                         ;              -- CR573702
        m_axis_mm2s_cntrl_tdata     : out std_logic_vector                                 --
                                        (C_M_AXIS_MM2S_CNTRL_TDATA_WIDTH-1 downto 0);      --
        m_axis_mm2s_cntrl_tkeep     : out std_logic_vector                                 --
                                        ((C_M_AXIS_MM2S_CNTRL_TDATA_WIDTH/8)-1 downto 0);  --
        m_axis_mm2s_cntrl_tvalid    : out std_logic                         ;              --
        m_axis_mm2s_cntrl_tready    : in  std_logic                         := '0';              --
        m_axis_mm2s_cntrl_tlast     : out std_logic                         ;              --
                                                                                           --
                                                                                           --
        -----------------------------------------------------------------------            --
        -- AXI S2MM Channel                                                                --
        -----------------------------------------------------------------------            --
        -- Stream to Memory Map Write Address Channel                                      --
        m_axi_s2mm_awaddr           : out std_logic_vector                                 --
                                        (C_M_AXI_S2MM_ADDR_WIDTH-1 downto 0);              --
        m_axi_s2mm_awlen            : out std_logic_vector(7 downto 0)      ;              --
        m_axi_s2mm_awsize           : out std_logic_vector(2 downto 0)      ;              --
        m_axi_s2mm_awburst          : out std_logic_vector(1 downto 0)      ;              --
        m_axi_s2mm_awprot           : out std_logic_vector(2 downto 0)      ;              --
        m_axi_s2mm_awcache          : out std_logic_vector(3 downto 0)      ;              --
        m_axi_s2mm_awuser           : out std_logic_vector(3 downto 0)      ;              --
        m_axi_s2mm_awvalid          : out std_logic                         ;              --
        m_axi_s2mm_awready          : in  std_logic                         := '0';              --
                                                                                           --
        -- Stream to Memory Map Write Data Channel                                         --
        m_axi_s2mm_wdata            : out std_logic_vector                                 --
                                        (C_M_AXI_S2MM_DATA_WIDTH-1 downto 0);              --
        m_axi_s2mm_wstrb            : out std_logic_vector                                 --
                                        ((C_M_AXI_S2MM_DATA_WIDTH/8)-1 downto 0);          --
        m_axi_s2mm_wlast            : out std_logic                         ;              --
        m_axi_s2mm_wvalid           : out std_logic                         ;              --
        m_axi_s2mm_wready           : in  std_logic                         := '0';              --
                                                                                           --
        -- Stream to Memory Map Write Response Channel                                     --
        m_axi_s2mm_bresp            : in  std_logic_vector(1 downto 0)      := "00";              --
        m_axi_s2mm_bvalid           : in  std_logic                         := '0';              --
        m_axi_s2mm_bready           : out std_logic                         ;              --
                                                                                           --
        -- Stream to Memory Map Steam Interface                                            --
        s2mm_prmry_reset_out_n      : out std_logic                         ;              -- CR573702
        s_axis_s2mm_tdata           : in  std_logic_vector                                 --
                                        (C_S_AXIS_S2MM_TDATA_WIDTH-1 downto 0) := (others => '0');            --
        s_axis_s2mm_tkeep           : in  std_logic_vector                                 --
                                        ((C_S_AXIS_S2MM_TDATA_WIDTH/8)-1 downto 0) := (others => '1');        --
        s_axis_s2mm_tvalid          : in  std_logic                         := '0';              --
        s_axis_s2mm_tready          : out std_logic                         ;              --
        s_axis_s2mm_tlast           : in  std_logic                         := '0';              --
        s_axis_s2mm_tuser           : in std_logic_vector (3 downto 0) := "0000"     ;              --
        s_axis_s2mm_tid             : in std_logic_vector (4 downto 0) := "00000"    ;              --
        s_axis_s2mm_tdest           : in std_logic_vector (4 downto 0) := "00000"    ;               --
                                                                                           --
        -- Stream to Memory Map Status Steam Interface                                     --
        s2mm_sts_reset_out_n        : out std_logic                         ;              -- CR573702
        s_axis_s2mm_sts_tdata       : in  std_logic_vector                                 --
                                        (C_S_AXIS_S2MM_STS_TDATA_WIDTH-1 downto 0) := (others => '0');        --
        s_axis_s2mm_sts_tkeep       : in  std_logic_vector                                 --
                                        ((C_S_AXIS_S2MM_STS_TDATA_WIDTH/8)-1 downto 0) := (others => '1');    --
        s_axis_s2mm_sts_tvalid      : in  std_logic                         := '0';              --
        s_axis_s2mm_sts_tready      : out std_logic                         ;              --
        s_axis_s2mm_sts_tlast       : in  std_logic                         := '0';              --



                                                                                           --
        -- MM2S and S2MM Channel Interrupts                                                --
        mm2s_introut                : out std_logic                         ;              --
        s2mm_introut                : out std_logic                         ;              --
        axi_dma_tstvec              : out std_logic_vector(31 downto 0)                    --
    -----------------------------------------------------------------------
    -- Test Support for Xilinx internal use
    -----------------------------------------------------------------------
    );

end axi_dma;

-------------------------------------------------------------------------------
-- Architecture
-------------------------------------------------------------------------------
architecture implementation of axi_dma is
  attribute DowngradeIPIdentifiedWarnings: string;
  attribute DowngradeIPIdentifiedWarnings of implementation : architecture is "yes";


-- The FREQ are needed only for ASYNC mode, for SYNC mode these are irrelevant
-- For Async, mm2s or s2mm >= sg >= lite

constant   C_S_AXI_LITE_ACLK_FREQ_HZ        : integer                  := 100000000;
            -- AXI Lite clock frequency in hertz
constant   C_M_AXI_MM2S_ACLK_FREQ_HZ        : integer                  := 100000000;
            -- AXI MM2S clock frequency in hertz
constant   C_M_AXI_S2MM_ACLK_FREQ_HZ        : integer                  := 100000000;
            -- AXI S2MM clock frequency in hertz
constant   C_M_AXI_SG_ACLK_FREQ_HZ          : integer                  := 100000000;
            -- Scatter Gather clock frequency in hertz

-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------
-- Functions

  -------------------------------------------------------------------
  -- Function
  --
  -- Function Name: funct_get_max
  --
  -- Function Description:
  --   Returns the greater of two integers.
  --
  -------------------------------------------------------------------
  function funct_get_string (value_in_1 : integer)
                          return string is

    Variable max_value : string (1 to 5) := "00000";

  begin

    If (value_in_1 = 1) Then
-- coverage off
      max_value := "11100";
-- coverage on

    else

      max_value := "11111";

    End if;

    Return (max_value);

  end function funct_get_string;


  function width_calc (value_in : integer)
                     return integer is
  variable addr_value : integer := 32;

  begin
      if (value_in > 32) then
          addr_value := 64;
      else
          addr_value := 32;
      end if;

      return(addr_value);

end function width_calc;

--  -------------------------------------------------------------------
--
--
--
--  -------------------------------------------------------------------
--  -- Function
--  --
--  -- Function Name: funct_rnd2pwr_of_2
--  --
--  -- Function Description:
--  --  Rounds the input value up to the nearest power of 2 between
--  --  128 and 8192.
--  --
--  -------------------------------------------------------------------
--  function funct_rnd2pwr_of_2 (input_value : integer) return integer is
--
--    Variable temp_pwr2 : Integer := 128;
--
--  begin
--
--    if (input_value <= 128) then
--
--       temp_pwr2 := 128;
--
--    elsif (input_value <= 256) then
--
--       temp_pwr2 := 256;
--
--    elsif (input_value <= 512) then
--
--       temp_pwr2 := 512;
--
--    elsif (input_value <= 1024) then
--
--       temp_pwr2 := 1024;
--
--    elsif (input_value <= 2048) then
--
--       temp_pwr2 := 2048;
--
--    elsif (input_value <= 4096) then
--
--       temp_pwr2 := 4096;
--
--    else
--
--       temp_pwr2 := 8192;
--
--    end if;
--
--
--    Return (temp_pwr2);
--
--  end function funct_rnd2pwr_of_2;
--  -------------------------------------------------------------------
--
--
--
--
--

-------------------------------------------------------------------------------
-- Constants Declarations
-------------------------------------------------------------------------------

 Constant SOFT_RST_TIME_CLKS : integer := 8;
   -- Specifies the time of the soft reset assertion in
   -- m_axi_aclk clock periods.
 constant skid_enable : string := (funct_get_string(0));

 -- Calculates the minimum needed depth of the CDMA Store and Forward FIFO
-- Constant PIPEDEPTH_BURST_LEN_PROD : integer :=
--          (funct_get_max(4, 4)+2)
--           * C_M_AXI_MAX_BURST_LEN;
--
-- -- Assigns the depth of the CDMA Store and Forward FIFO to the nearest
-- -- power of 2
-- Constant SF_FIFO_DEPTH       : integer range 128 to 8192 :=
--                                funct_rnd2pwr_of_2(PIPEDEPTH_BURST_LEN_PROD);



-- No Functions Declared

-------------------------------------------------------------------------------
-- Constants Declarations
-------------------------------------------------------------------------------
-- Scatter Gather Engine Configuration
-- Number of Fetch Descriptors to Queue
constant ADDR_WIDTH : integer := width_calc (C_M_AXI_SG_ADDR_WIDTH);

constant MCDMA                      : integer := (1 - C_ENABLE_MULTI_CHANNEL);
constant DESC_QUEUE                 : integer := (1*MCDMA);
constant STSCNTRL_ENABLE            : integer := (C_SG_INCLUDE_STSCNTRL_STRM*MCDMA);
constant APPLENGTH_ENABLE           : integer := (C_SG_USE_STSAPP_LENGTH*MCDMA);
constant C_SG_LENGTH_WIDTH_INT      : integer := (C_SG_LENGTH_WIDTH*MCDMA + 23*C_ENABLE_MULTI_CHANNEL);
-- Comment the foll 2 line to disable queuing for McDMA and uncomment the 3rd and 4th lines
--constant SG_FTCH_DESC2QUEUE         : integer := ((DESC_QUEUE * 4)*MCDMA + (2*C_ENABLE_MULTI_CHANNEL)) * C_SG_INCLUDE_DESC_QUEUE;
-- Number of Update Descriptors to Queue
--constant SG_UPDT_DESC2QUEUE         : integer := ((DESC_QUEUE * 4)*MCDMA + (2*C_ENABLE_MULTI_CHANNEL)) * C_SG_INCLUDE_DESC_QUEUE;

constant SG_FTCH_DESC2QUEUE         : integer := ((DESC_QUEUE * 4)*MCDMA + (2*C_ENABLE_MULTI_CHANNEL)) * DESC_QUEUE;
-- Number of Update Descriptors to Queue
constant SG_UPDT_DESC2QUEUE         : integer := ((DESC_QUEUE * 4)*MCDMA + (2*C_ENABLE_MULTI_CHANNEL)) * DESC_QUEUE;


-- Number of fetch words per descriptor for channel 1 (MM2S)
constant SG_CH1_WORDS_TO_FETCH      : integer := 8 + (5 * STSCNTRL_ENABLE);
-- Number of fetch words per descriptor for channel 2 (S2MM)
constant SG_CH2_WORDS_TO_FETCH      : integer := 8;  -- Only need to fetch 1st 8wrds for s2mm
-- Number of update words per descriptor for channel 1 (MM2S)
constant SG_CH1_WORDS_TO_UPDATE     : integer := 1;  -- Only status needs update for mm2s
-- Number of update words per descriptor for channel 2 (S2MM)
constant SG_CH2_WORDS_TO_UPDATE     : integer := 1 + (5 * STSCNTRL_ENABLE);
-- First word offset (referenced to descriptor beginning) to update for channel 1 (MM2S)
constant SG_CH1_FIRST_UPDATE_WORD   : integer := 7;  -- status word in descriptor
-- First word offset (referenced to descriptor beginning) to update for channel 2 (MM2S)
constant SG_CH2_FIRST_UPDATE_WORD   : integer := 7;  -- status word in descriptor
-- Enable stale descriptor check for channel 1
constant SG_CH1_ENBL_STALE_ERROR    : integer := 1;
-- Enable stale descriptor check for channel 2
constant SG_CH2_ENBL_STALE_ERROR    : integer := 1;
-- Width of descriptor fetch bus
constant M_AXIS_SG_TDATA_WIDTH      : integer := 32;
-- Width of descriptor update pointer bus
constant S_AXIS_UPDPTR_TDATA_WIDTH  : integer := 32;
-- Width of descriptor update status bus
constant S_AXIS_UPDSTS_TDATA_WIDTH  : integer := 33; -- IOC (1 bit) & DescStatus (32 bits)
-- Include SG Descriptor Updates
constant INCLUDE_DESC_UPDATE        : integer := 1;
-- Include SG Interrupt Logic
constant INCLUDE_INTRPT             : integer := 1;
-- Include SG Delay Interrupt
constant INCLUDE_DLYTMR             : integer := 1;


-- Primary DataMover Configuration
-- DataMover Command / Status FIFO Depth
-- Note :Set maximum to the number of update descriptors to queue, to prevent lock up do to
-- update data fifo full before
--constant DM_CMDSTS_FIFO_DEPTH       : integer := 1*C_ENABLE_MULTI_CHANNEL + (max2(1,SG_UPDT_DESC2QUEUE))*MCDMA;
constant DM_CMDSTS_FIFO_DEPTH       : integer := max2(1,SG_UPDT_DESC2QUEUE);
constant DM_CMDSTS_FIFO_DEPTH_1       : integer := ((1-C_PRMRY_IS_ACLK_ASYNC)+C_PRMRY_IS_ACLK_ASYNC*DM_CMDSTS_FIFO_DEPTH);
-- DataMover Include Status FIFO
constant DM_INCLUDE_STS_FIFO        : integer := 1;

-- Enable indeterminate BTT on datamover when stscntrl stream not included or
-- when use status app rx length is not enable or when in Simple DMA mode.
constant DM_SUPPORT_INDET_BTT       : integer := 1 - (STSCNTRL_ENABLE
                                                        * APPLENGTH_ENABLE
                                                        * C_INCLUDE_SG) - C_MICRO_DMA;
-- Indterminate BTT Mode additional status vector width
constant INDETBTT_ADDED_STS_WIDTH   : integer := 24;
-- Base status vector width
constant BASE_STATUS_WIDTH          : integer := 8;
-- DataMover status width - is based on mode of operation
constant DM_STATUS_WIDTH            : integer := BASE_STATUS_WIDTH
                                               + (DM_SUPPORT_INDET_BTT * INDETBTT_ADDED_STS_WIDTH);
-- DataMover outstanding address request fifo depth
constant DM_ADDR_PIPE_DEPTH         : integer := 4;

-- AXI DataMover Full mode value
constant AXI_FULL_MODE              : integer := 1;
-- AXI DataMover mode for MM2S Channel (0 if channel not included)
constant MM2S_AXI_FULL_MODE         : integer := (C_INCLUDE_MM2S) * AXI_FULL_MODE + C_MICRO_DMA*C_INCLUDE_MM2S;
-- AXI DataMover mode for S2MM Channel (0 if channel not included)
constant S2MM_AXI_FULL_MODE         : integer := (C_INCLUDE_S2MM) * AXI_FULL_MODE + C_MICRO_DMA*C_INCLUDE_S2MM;



-- Minimum value required for length width based on burst size and stream dwidth
-- If user sets c_sg_length_width too small based on setting of burst size and
-- dwidth then this will reset the width to a larger mimimum requirement.
constant DM_BTT_LENGTH_WIDTH : integer := max2((required_btt_width(C_M_AXIS_MM2S_TDATA_WIDTH,
                                                            C_MM2S_BURST_SIZE,
                                                            C_SG_LENGTH_WIDTH_INT)*C_INCLUDE_MM2S),
                                         (required_btt_width(C_S_AXIS_S2MM_TDATA_WIDTH,
                                                            C_S2MM_BURST_SIZE,
                                                            C_SG_LENGTH_WIDTH_INT)*C_INCLUDE_S2MM));


-- Enable store and forward on datamover if data widths are mismatched (allows upsizers
-- to be instantiated) or when enabled by user.
constant DM_MM2S_INCLUDE_SF             : integer := enable_snf(C_INCLUDE_MM2S_SF,
                                                                C_M_AXI_MM2S_DATA_WIDTH,
                                                                C_M_AXIS_MM2S_TDATA_WIDTH);

-- Enable store and forward on datamover if data widths are mismatched (allows upsizers
-- to be instantiated) or when enabled by user.
constant DM_S2MM_INCLUDE_SF             : integer := enable_snf(C_INCLUDE_S2MM_SF,
                                                                C_M_AXI_S2MM_DATA_WIDTH,
                                                                C_S_AXIS_S2MM_TDATA_WIDTH);





-- Always allow datamover address requests
constant ALWAYS_ALLOW       : std_logic := '1';


-- Return correct freq_hz parameter depending on if sg engine is included
constant M_AXI_SG_ACLK_FREQ_HZ  :integer := hertz_prmtr_select(C_INCLUDE_SG,
                                                               C_S_AXI_LITE_ACLK_FREQ_HZ,
                                                               C_M_AXI_SG_ACLK_FREQ_HZ);

-- Scatter / Gather is always configure for synchronous operation for AXI DMA
constant SG_IS_SYNCHRONOUS     : integer := 0;

constant CMD_WIDTH : integer := ((8*C_ENABLE_MULTI_CHANNEL)+ ADDR_WIDTH+ CMD_BASE_WIDTH) ;

-------------------------------------------------------------------------------
-- Signal / Type Declarations
-------------------------------------------------------------------------------
signal axi_lite_aclk            : std_logic := '1';
signal axi_sg_aclk              : std_logic := '1';

signal m_axi_sg_aresetn         : std_logic := '1';     -- SG Reset on sg aclk domain (Soft/Hard)
signal dm_m_axi_sg_aresetn      : std_logic := '1';     -- SG Reset on sg aclk domain (Soft/Hard) (Raw)
signal m_axi_mm2s_aresetn       : std_logic := '1';     -- MM2S Channel Reset on s2mm aclk domain (Soft/Hard)(Raw)
signal m_axi_s2mm_aresetn       : std_logic := '1';     -- S2MM Channel Reset on s2mm aclk domain (Soft/Hard)(Raw)
signal mm2s_scndry_resetn       : std_logic := '1';     -- MM2S Channel Reset on sg aclk domain (Soft/Hard)
signal s2mm_scndry_resetn       : std_logic := '1';     -- S2MM Channel Reset on sg aclk domain (Soft/Hard)
signal mm2s_prmry_resetn        : std_logic := '1';     -- MM2S Channel Reset on s2mm aclk domain (Soft/Hard)
signal s2mm_prmry_resetn        : std_logic := '1';     -- S2MM Channel Reset on s2mm aclk domain (Soft/Hard)
signal axi_lite_reset_n         : std_logic := '1';     -- AXI Lite Interface Reset (Hard Only)
signal m_axi_sg_hrdresetn       : std_logic := '1';     -- AXI Lite Interface Reset on SG clock domain (Hard Only)
signal dm_mm2s_scndry_resetn    : std_logic := '1';     -- MM2S Channel Reset on sg domain (Soft/Hard)(Raw)
signal dm_s2mm_scndry_resetn    : std_logic := '1';     -- S2MM Channel Reset on sg domain (Soft/Hard)(Raw)


-- Register Module Signals
signal mm2s_halted_clr          : std_logic := '0';
signal mm2s_halted_set          : std_logic := '0';
signal mm2s_idle_set            : std_logic := '0';
signal mm2s_idle_clr            : std_logic := '0';
signal mm2s_dma_interr_set      : std_logic := '0';
signal mm2s_dma_slverr_set      : std_logic := '0';
signal mm2s_dma_decerr_set      : std_logic := '0';
signal mm2s_ioc_irq_set         : std_logic := '0';
signal mm2s_dly_irq_set         : std_logic := '0';
signal mm2s_irqdelay_status     : std_logic_vector(7 downto 0) := (others => '0');
signal mm2s_irqthresh_status    : std_logic_vector(7 downto 0) := (others => '0');
signal mm2s_new_curdesc_wren    : std_logic := '0';
signal mm2s_new_curdesc         : std_logic_vector(ADDR_WIDTH-1 downto 0) := (others => '0');
signal mm2s_tailpntr_updated    : std_logic := '0';
signal mm2s_dmacr               : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0)  := (others => '0');
signal mm2s_dmasr               : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0)  := (others => '0');
signal mm2s_curdesc             : std_logic_vector(ADDR_WIDTH-1 downto 0)    := (others => '0');
signal mm2s_taildesc            : std_logic_vector(ADDR_WIDTH-1 downto 0)    := (others => '0');
signal mm2s_sa                  : std_logic_vector(ADDR_WIDTH-1 downto 0)    := (others => '0'); --(C_M_AXI_MM2S_ADDR_WIDTH-1 downto 0)  := (others => '0');
signal mm2s_length              : std_logic_vector(C_SG_LENGTH_WIDTH_INT-1 downto 0)        := (others => '0');
signal mm2s_length_wren         : std_logic := '0';
signal mm2s_smpl_interr_set     : std_logic := '0';
signal mm2s_smpl_slverr_set     : std_logic := '0';
signal mm2s_smpl_decerr_set     : std_logic := '0';
signal mm2s_smpl_done           : std_logic := '0';
signal mm2s_packet_sof          : std_logic := '0';
signal mm2s_packet_eof          : std_logic := '0';
signal mm2s_all_idle            : std_logic := '0';
signal mm2s_error               : std_logic := '0';
signal mm2s_dlyirq_dsble        : std_logic := '0'; -- CR605888


signal s2mm_halted_clr          : std_logic := '0';
signal s2mm_halted_set          : std_logic := '0';
signal s2mm_idle_set            : std_logic := '0';
signal s2mm_idle_clr            : std_logic := '0';
signal s2mm_dma_interr_set      : std_logic := '0';
signal s2mm_dma_slverr_set      : std_logic := '0';
signal s2mm_dma_decerr_set      : std_logic := '0';
signal s2mm_ioc_irq_set         : std_logic := '0';
signal s2mm_dly_irq_set         : std_logic := '0';
signal s2mm_irqdelay_status     : std_logic_vector(7 downto 0) := (others => '0');
signal s2mm_irqthresh_status    : std_logic_vector(7 downto 0) := (others => '0');
signal s2mm_new_curdesc_wren    : std_logic := '0';
signal s2mm_new_curdesc         : std_logic_vector(ADDR_WIDTH-1 downto 0) := (others => '0');
signal s2mm_tailpntr_updated    : std_logic := '0';
signal s2mm_dmacr               : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0)    := (others => '0');
signal s2mm_dmasr               : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0)    := (others => '0');
signal s2mm_curdesc             : std_logic_vector(ADDR_WIDTH-1 downto 0) := (others => '0');
signal s2mm_taildesc            : std_logic_vector(ADDR_WIDTH-1 downto 0) := (others => '0');
signal s2mm_da                  : std_logic_vector(ADDR_WIDTH-1 downto 0)    := (others => '0'); --(C_M_AXI_S2MM_ADDR_WIDTH-1 downto 0)  := (others => '0');
signal s2mm_length              : std_logic_vector(C_SG_LENGTH_WIDTH_INT-1 downto 0)        := (others => '0');
signal s2mm_length_wren         : std_logic := '0';
signal s2mm_bytes_rcvd          : std_logic_vector(C_SG_LENGTH_WIDTH_INT-1 downto 0) := (others => '0');
signal s2mm_bytes_rcvd_wren     : std_logic := '0';
signal s2mm_smpl_interr_set     : std_logic := '0';
signal s2mm_smpl_slverr_set     : std_logic := '0';
signal s2mm_smpl_decerr_set     : std_logic := '0';
signal s2mm_smpl_done           : std_logic := '0';
signal s2mm_packet_sof          : std_logic := '0';
signal s2mm_packet_eof          : std_logic := '0';
signal s2mm_all_idle            : std_logic := '0';
signal s2mm_error               : std_logic := '0';
signal s2mm_dlyirq_dsble        : std_logic := '0'; -- CR605888

signal mm2s_stop                : std_logic := '0';
signal s2mm_stop                : std_logic := '0';
signal ftch_error               : std_logic := '0';
signal ftch_error_addr          : std_logic_vector(ADDR_WIDTH-1 downto 0) := (others => '0');
signal updt_error               : std_logic := '0';
signal updt_error_addr          : std_logic_vector(ADDR_WIDTH-1 downto 0) := (others => '0');

--*********************************
-- MM2S Signals
--*********************************
-- MM2S DMA Controller Signals
signal mm2s_desc_flush          : std_logic := '0';
signal mm2s_ftch_idle           : std_logic := '0';
signal mm2s_updt_idle           : std_logic := '0';
signal mm2s_updt_ioc_irq_set    : std_logic := '0';
signal mm2s_irqthresh_wren      : std_logic := '0';
signal mm2s_irqdelay_wren       : std_logic := '0';
signal mm2s_irqthresh_rstdsbl   : std_logic := '0'; -- CR572013

-- SG MM2S Descriptor Fetch AXI Stream IN
signal m_axis_mm2s_ftch_tdata_new   : std_logic_vector(96+31*0+(0+2)*(ADDR_WIDTH-32) downto 0) := (others => '0');
signal m_axis_mm2s_ftch_tdata_mcdma_new   : std_logic_vector(63 downto 0) := (others => '0');
signal m_axis_mm2s_ftch_tvalid_new  : std_logic := '0';
signal m_axis_mm2s_ftch_tdata   : std_logic_vector(M_AXIS_SG_TDATA_WIDTH-1 downto 0) := (others => '0');
signal m_axis_mm2s_ftch_tvalid  : std_logic := '0';
signal m_axis_mm2s_ftch_tready  : std_logic := '0';
signal m_axis_mm2s_ftch_tlast   : std_logic := '0';

-- SG MM2S Descriptor Update AXI Stream Out
signal s_axis_mm2s_updtptr_tdata   : std_logic_vector(ADDR_WIDTH-1 downto 0) := (others => '0');
signal s_axis_mm2s_updtptr_tvalid  : std_logic := '0';
signal s_axis_mm2s_updtptr_tready  : std_logic := '0';
signal s_axis_mm2s_updtptr_tlast   : std_logic := '0';

signal s_axis_mm2s_updtsts_tdata   : std_logic_vector(S_AXIS_UPDSTS_TDATA_WIDTH-1 downto 0) := (others => '0');
signal s_axis_mm2s_updtsts_tvalid  : std_logic := '0';
signal s_axis_mm2s_updtsts_tready  : std_logic := '0';
signal s_axis_mm2s_updtsts_tlast   : std_logic := '0';

-- DataMover MM2S Command Stream Signals
signal s_axis_mm2s_cmd_tvalid_split   : std_logic := '0';
signal s_axis_mm2s_cmd_tready_split   : std_logic := '0';
signal s_axis_mm2s_cmd_tdata_split    : std_logic_vector
                                    ((ADDR_WIDTH-32+2*32+CMD_BASE_WIDTH+46)-1 downto 0) := (others => '0');
signal s_axis_s2mm_cmd_tvalid_split   : std_logic := '0';
signal s_axis_s2mm_cmd_tready_split   : std_logic := '0';
signal s_axis_s2mm_cmd_tdata_split    : std_logic_vector
                                    ((ADDR_WIDTH-32+2*32+CMD_BASE_WIDTH+46)-1 downto 0) := (others => '0');
signal s_axis_mm2s_cmd_tvalid   : std_logic := '0';
signal s_axis_mm2s_cmd_tready   : std_logic := '0';
signal s_axis_mm2s_cmd_tdata    : std_logic_vector
              ((ADDR_WIDTH+CMD_BASE_WIDTH+(8*C_ENABLE_MULTI_CHANNEL))-1 downto 0) := (others => '0');
-- DataMover MM2S Status Stream Signals
signal m_axis_mm2s_sts_tvalid   : std_logic := '0';
signal m_axis_mm2s_sts_tvalid_int   : std_logic := '0';
signal m_axis_mm2s_sts_tready   : std_logic := '0';
signal m_axis_mm2s_sts_tdata    : std_logic_vector(7 downto 0) := (others => '0');
signal m_axis_mm2s_sts_tdata_int    : std_logic_vector(7 downto 0) := (others => '0');
signal m_axis_mm2s_sts_tkeep    : std_logic_vector(0 downto 0) := (others => '0');
signal mm2s_err                 : std_logic := '0';
signal mm2s_halt                : std_logic := '0';
signal mm2s_halt_cmplt          : std_logic := '0';

-- S2MM DMA Controller Signals
signal s2mm_desc_flush          : std_logic := '0';
signal s2mm_ftch_idle           : std_logic := '0';
signal s2mm_updt_idle           : std_logic := '0';
signal s2mm_updt_ioc_irq_set    : std_logic := '0';
signal s2mm_irqthresh_wren      : std_logic := '0';
signal s2mm_irqdelay_wren       : std_logic := '0';
signal s2mm_irqthresh_rstdsbl   : std_logic := '0'; -- CR572013

-- SG S2MM Descriptor Fetch AXI Stream IN
signal m_axis_s2mm_ftch_tdata_new   : std_logic_vector(96+31*0+(0+2)*(ADDR_WIDTH-32) downto 0) := (others => '0');
signal m_axis_s2mm_ftch_tdata_mcdma_new   : std_logic_vector(63 downto 0) := (others => '0');
signal m_axis_s2mm_ftch_tdata_mcdma_nxt   : std_logic_vector(ADDR_WIDTH-1 downto 0) := (others => '0');
signal m_axis_s2mm_ftch_tvalid_new  : std_logic := '0';
signal m_axis_ftch2_desc_available, m_axis_ftch1_desc_available : std_logic;
signal m_axis_s2mm_ftch_tdata   : std_logic_vector(M_AXIS_SG_TDATA_WIDTH-1 downto 0) := (others => '0');
signal m_axis_s2mm_ftch_tvalid  : std_logic := '0';
signal m_axis_s2mm_ftch_tready  : std_logic := '0';
signal m_axis_s2mm_ftch_tlast   : std_logic := '0';
signal mm2s_axis_info           : std_logic_vector(13 downto 0) := (others => '0');

-- SG S2MM Descriptor Update AXI Stream Out
signal s_axis_s2mm_updtptr_tdata   : std_logic_vector(ADDR_WIDTH-1 downto 0) := (others => '0');
signal s_axis_s2mm_updtptr_tvalid  : std_logic := '0';
signal s_axis_s2mm_updtptr_tready  : std_logic := '0';
signal s_axis_s2mm_updtptr_tlast   : std_logic := '0';

signal s_axis_s2mm_updtsts_tdata   : std_logic_vector(S_AXIS_UPDSTS_TDATA_WIDTH-1 downto 0) := (others => '0');
signal s_axis_s2mm_updtsts_tvalid  : std_logic := '0';
signal s_axis_s2mm_updtsts_tready  : std_logic := '0';
signal s_axis_s2mm_updtsts_tlast   : std_logic := '0';

-- DataMover S2MM Command Stream Signals
signal s_axis_s2mm_cmd_tvalid   : std_logic := '0';
signal s_axis_s2mm_cmd_tready   : std_logic := '0';
signal s_axis_s2mm_cmd_tdata    : std_logic_vector
           ((ADDR_WIDTH+CMD_BASE_WIDTH+(8*C_ENABLE_MULTI_CHANNEL))-1 downto 0) := (others => '0');
-- DataMover S2MM Status Stream Signals
signal m_axis_s2mm_sts_tvalid   : std_logic := '0';
signal m_axis_s2mm_sts_tvalid_int   : std_logic := '0';
signal m_axis_s2mm_sts_tready   : std_logic := '0';
signal m_axis_s2mm_sts_tdata    : std_logic_vector(DM_STATUS_WIDTH - 1 downto 0) := (others => '0');
signal m_axis_s2mm_sts_tdata_int    : std_logic_vector(DM_STATUS_WIDTH - 1 downto 0) := (others => '0');
signal m_axis_s2mm_sts_tkeep    : std_logic_vector((DM_STATUS_WIDTH/8)-1 downto 0) := (others => '0');
signal s2mm_err                 : std_logic := '0';
signal s2mm_halt                : std_logic := '0';
signal s2mm_halt_cmplt          : std_logic := '0';

-- Error Status Control
signal mm2s_ftch_interr_set     : std_logic := '0';
signal mm2s_ftch_slverr_set     : std_logic := '0';
signal mm2s_ftch_decerr_set     : std_logic := '0';
signal mm2s_updt_interr_set     : std_logic := '0';
signal mm2s_updt_slverr_set     : std_logic := '0';
signal mm2s_updt_decerr_set     : std_logic := '0';
signal mm2s_ftch_err_early      : std_logic := '0';
signal mm2s_ftch_stale_desc     : std_logic := '0';
signal s2mm_updt_interr_set     : std_logic := '0';
signal s2mm_updt_slverr_set     : std_logic := '0';
signal s2mm_updt_decerr_set     : std_logic := '0';
signal s2mm_ftch_interr_set     : std_logic := '0';
signal s2mm_ftch_slverr_set     : std_logic := '0';
signal s2mm_ftch_decerr_set     : std_logic := '0';
signal s2mm_ftch_err_early      : std_logic := '0';
signal s2mm_ftch_stale_desc     : std_logic := '0';

signal soft_reset_clr           : std_logic := '0';
signal soft_reset               : std_logic := '0';

signal s_axis_s2mm_tready_i     : std_logic := '0';
signal s_axis_s2mm_tready_int     : std_logic := '0';
signal m_axis_mm2s_tlast_i      : std_logic := '0';
signal m_axis_mm2s_tlast_i_user      : std_logic := '0';
signal m_axis_mm2s_tvalid_i     : std_logic := '0';
signal sg_ctl                   : std_logic_vector (7 downto 0);

signal s_axis_s2mm_tvalid_int   : std_logic;
signal s_axis_s2mm_tlast_int   : std_logic;

signal tdest_out_int           : std_logic_vector (6 downto 0);
signal same_tdest              : std_logic;

signal s2mm_eof_s2mm           : std_logic;
signal ch2_update_active       : std_logic; 

signal s2mm_desc_info_in          : std_logic_vector (13 downto 0);

signal m_axis_mm2s_tlast_i_mcdma : std_logic;

signal s2mm_run_stop_del : std_logic;
signal s2mm_desc_flush_del : std_logic;

signal s2mm_tvalid_latch : std_logic;
signal s2mm_tvalid_latch_del : std_logic;

signal clock_splt : std_logic;
signal clock_splt_s2mm : std_logic;
signal updt_cmpt : std_logic;

signal cmpt_updt : std_logic_vector (1 downto 0);

signal reset1, reset2 : std_logic;

signal mm2s_cntrl_strm_stop : std_logic;

signal bd_eq : std_logic;

signal m_axi_sg_awaddr_internal : std_logic_vector (ADDR_WIDTH-1 downto 0)  ;
signal m_axi_sg_araddr_internal : std_logic_vector (ADDR_WIDTH-1 downto 0)  ;
signal m_axi_mm2s_araddr_internal : std_logic_vector (ADDR_WIDTH-1 downto 0)  ;
signal m_axi_s2mm_awaddr_internal : std_logic_vector (ADDR_WIDTH-1 downto 0)  ;



-------------------------------------------------------------------------------
-- Begin architecture logic
-------------------------------------------------------------------------------
begin

m_axi_mm2s_araddr <= m_axi_mm2s_araddr_internal (C_M_AXI_SG_ADDR_WIDTH-1 downto 0); 
m_axi_s2mm_awaddr <= m_axi_s2mm_awaddr_internal (C_M_AXI_SG_ADDR_WIDTH-1 downto 0); 

-- AXI DMA Test Vector (For Xilinx Internal Use Only)
axi_dma_tstvec(31 downto 6) <= (others => '0');
axi_dma_tstvec(5) <= s2mm_updt_ioc_irq_set;
axi_dma_tstvec(4) <= mm2s_updt_ioc_irq_set;
axi_dma_tstvec(3) <= s2mm_packet_eof;
axi_dma_tstvec(2) <= s2mm_packet_sof;
axi_dma_tstvec(1) <= mm2s_packet_eof;
axi_dma_tstvec(0) <= mm2s_packet_sof;

-- Primary MM2S Stream outputs (used internally to gen eof and sof for
-- interrupt coalescing
m_axis_mm2s_tlast  <= m_axis_mm2s_tlast_i;
m_axis_mm2s_tvalid <= m_axis_mm2s_tvalid_i;
-- Primary S2MM Stream output (used internally to gen eof and sof for
-- interrupt coalescing
s_axis_s2mm_tready <=     s_axis_s2mm_tready_i;


GEN_INCLUDE_SG : if C_INCLUDE_SG = 1 generate
    axi_lite_aclk <= s_axi_lite_aclk;
    axi_sg_aclk   <= m_axi_sg_aclk;
end generate GEN_INCLUDE_SG;

GEN_EXCLUDE_SG : if C_INCLUDE_SG = 0 generate
    axi_lite_aclk <= s_axi_lite_aclk;
    axi_sg_aclk   <= s_axi_lite_aclk;
end generate GEN_EXCLUDE_SG;


-------------------------------------------------------------------------------
-- AXI DMA Reset Module
-------------------------------------------------------------------------------
I_RST_MODULE : entity  axi_dma_v7_1_8.axi_dma_rst_module
    generic map(
        C_INCLUDE_MM2S              => C_INCLUDE_MM2S                       ,
        C_INCLUDE_S2MM              => C_INCLUDE_S2MM                       ,
        C_PRMRY_IS_ACLK_ASYNC       => C_PRMRY_IS_ACLK_ASYNC                ,
        C_M_AXI_MM2S_ACLK_FREQ_HZ   => C_M_AXI_MM2S_ACLK_FREQ_HZ            ,
        C_M_AXI_S2MM_ACLK_FREQ_HZ   => C_M_AXI_S2MM_ACLK_FREQ_HZ            ,
        C_M_AXI_SG_ACLK_FREQ_HZ     => M_AXI_SG_ACLK_FREQ_HZ                ,
        C_SG_INCLUDE_STSCNTRL_STRM  => STSCNTRL_ENABLE           ,
        C_INCLUDE_SG                => C_INCLUDE_SG
    )
    port map(
        -- Clock Sources
        s_axi_lite_aclk             => axi_lite_aclk                        ,
        m_axi_sg_aclk               => axi_sg_aclk                          ,
        m_axi_mm2s_aclk             => m_axi_mm2s_aclk                      ,
        m_axi_s2mm_aclk             => m_axi_s2mm_aclk                      ,

        -----------------------------------------------------------------------
        -- Hard Reset
        -----------------------------------------------------------------------
        axi_resetn                  => axi_resetn                           ,

        -----------------------------------------------------------------------
        -- Soft Reset
        -----------------------------------------------------------------------
        soft_reset                  => soft_reset                           ,
        soft_reset_clr              => soft_reset_clr                       ,

        mm2s_stop                   => mm2s_stop                            ,
        mm2s_all_idle               => mm2s_all_idle                        ,
        mm2s_halt                   => mm2s_halt                            ,
        mm2s_halt_cmplt             => mm2s_halt_cmplt                      ,

        s2mm_stop                   => s2mm_stop                            ,
        s2mm_all_idle               => s2mm_all_idle                        ,
        s2mm_halt                   => s2mm_halt                            ,
        s2mm_halt_cmplt             => s2mm_halt_cmplt                      ,

        -----------------------------------------------------------------------
        -- MM2S Distributed Reset Out (m_axi_mm2s_aclk)
        -----------------------------------------------------------------------
        dm_mm2s_prmry_resetn        => m_axi_mm2s_aresetn                   ,   -- AXI DataMover Primary Reset (Raw)
        dm_mm2s_scndry_resetn       => dm_mm2s_scndry_resetn                ,   -- AXI DataMover Secondary Reset (Raw)
        mm2s_prmry_reset_out_n      => mm2s_prmry_reset_out_n               ,   -- AXI Stream Primary Reset Outputs
        mm2s_cntrl_reset_out_n      => mm2s_cntrl_reset_out_n               ,   -- AXI Stream Control Reset Outputs
        mm2s_scndry_resetn          => mm2s_scndry_resetn                   ,   -- AXI Secondary Reset
        mm2s_prmry_resetn           => mm2s_prmry_resetn                    ,   -- AXI Primary Reset

        -----------------------------------------------------------------------
        -- S2MM Distributed Reset Out (m_axi_s2mm_aclk)
        -----------------------------------------------------------------------
        dm_s2mm_prmry_resetn        => m_axi_s2mm_aresetn                   ,   -- AXI DataMover Primary Reset (Raw)
        dm_s2mm_scndry_resetn       => dm_s2mm_scndry_resetn                ,   -- AXI DataMover Secondary Reset (Raw)
        s2mm_prmry_reset_out_n      => s2mm_prmry_reset_out_n               ,   -- AXI Stream Primary Reset Outputs
        s2mm_sts_reset_out_n        => s2mm_sts_reset_out_n                 ,   -- AXI Stream Control Reset Outputs
        s2mm_scndry_resetn          => s2mm_scndry_resetn                   ,   -- AXI Secondary Reset
        s2mm_prmry_resetn           => s2mm_prmry_resetn                    ,   -- AXI Primary Reset


        -----------------------------------------------------------------------
        -- Scatter Gather Distributed Reset Out (m_axi_sg_aclk)
        -----------------------------------------------------------------------
        m_axi_sg_aresetn            => m_axi_sg_aresetn                     ,   -- AXI Scatter Gather Reset Out
        dm_m_axi_sg_aresetn         => dm_m_axi_sg_aresetn                  ,   -- AXI Scatter Gather Datamover Reset Out

        -----------------------------------------------------------------------
        -- Hard Reset Out (s_axi_lite_aclk)
        -----------------------------------------------------------------------
        m_axi_sg_hrdresetn          => m_axi_sg_hrdresetn                   ,   -- AXI Lite Ingerface (sg aclk) (Hard Only)
        s_axi_lite_resetn           => axi_lite_reset_n                         -- AXI Lite Interface reset (Hard Only)
    );

-------------------------------------------------------------------------------
-- AXI DMA Register Module
-------------------------------------------------------------------------------
I_AXI_DMA_REG_MODULE : entity axi_dma_v7_1_8.axi_dma_reg_module
    generic map(
        C_INCLUDE_MM2S              => C_INCLUDE_MM2S                       ,
        C_INCLUDE_S2MM              => C_INCLUDE_S2MM                       ,
        C_INCLUDE_SG                => C_INCLUDE_SG                         ,
        C_SG_LENGTH_WIDTH           => C_SG_LENGTH_WIDTH_INT                ,
        C_AXI_LITE_IS_ASYNC         => C_PRMRY_IS_ACLK_ASYNC                ,
        C_S_AXI_LITE_ADDR_WIDTH     => C_S_AXI_LITE_ADDR_WIDTH              ,
        C_S_AXI_LITE_DATA_WIDTH     => C_S_AXI_LITE_DATA_WIDTH              ,
        C_M_AXI_SG_ADDR_WIDTH       => ADDR_WIDTH                ,
        C_M_AXI_MM2S_ADDR_WIDTH     => ADDR_WIDTH              ,
        C_NUM_S2MM_CHANNELS         => C_NUM_S2MM_CHANNELS                  ,
        C_M_AXI_S2MM_ADDR_WIDTH     => ADDR_WIDTH              ,
        C_MICRO_DMA                 => C_MICRO_DMA                          ,
        C_ENABLE_MULTI_CHANNEL      => C_ENABLE_MULTI_CHANNEL
    )
    port map(
        -----------------------------------------------------------------------
        -- AXI Lite Control Interface
        -----------------------------------------------------------------------
        s_axi_lite_aclk             => axi_lite_aclk                        ,
        axi_lite_reset_n            => axi_lite_reset_n                     ,

        m_axi_sg_aclk               => axi_sg_aclk                          ,
        m_axi_sg_aresetn            => m_axi_sg_aresetn                     ,
        m_axi_sg_hrdresetn          => m_axi_sg_hrdresetn                   ,

        -- AXI Lite Write Address Channel
        s_axi_lite_awvalid          => s_axi_lite_awvalid                   ,
        s_axi_lite_awready          => s_axi_lite_awready                   ,
        s_axi_lite_awaddr           => s_axi_lite_awaddr                    ,

        -- AXI Lite Write Data Channel
        s_axi_lite_wvalid           => s_axi_lite_wvalid                    ,
        s_axi_lite_wready           => s_axi_lite_wready                    ,
        s_axi_lite_wdata            => s_axi_lite_wdata                     ,

        -- AXI Lite Write Response Channel
        s_axi_lite_bresp            => s_axi_lite_bresp                     ,
        s_axi_lite_bvalid           => s_axi_lite_bvalid                    ,
        s_axi_lite_bready           => s_axi_lite_bready                    ,

        -- AXI Lite Read Address Channel
        s_axi_lite_arvalid          => s_axi_lite_arvalid                   ,
        s_axi_lite_arready          => s_axi_lite_arready                   ,
        s_axi_lite_araddr           => s_axi_lite_araddr                    ,
        s_axi_lite_rvalid           => s_axi_lite_rvalid                    ,
        s_axi_lite_rready           => s_axi_lite_rready                    ,
        s_axi_lite_rdata            => s_axi_lite_rdata                     ,
        s_axi_lite_rresp            => s_axi_lite_rresp                     ,

        -- MM2S DMASR Status
        mm2s_stop                   => mm2s_stop                            ,
        mm2s_halted_clr             => mm2s_halted_clr                      ,
        mm2s_halted_set             => mm2s_halted_set                      ,
        mm2s_idle_set               => mm2s_idle_set                        ,
        mm2s_idle_clr               => mm2s_idle_clr                        ,
        mm2s_dma_interr_set         => mm2s_dma_interr_set                  ,
        mm2s_dma_slverr_set         => mm2s_dma_slverr_set                  ,
        mm2s_dma_decerr_set         => mm2s_dma_decerr_set                  ,
        mm2s_ioc_irq_set            => mm2s_ioc_irq_set                     ,
        mm2s_dly_irq_set            => mm2s_dly_irq_set                     ,
        mm2s_irqthresh_wren         => mm2s_irqthresh_wren                  ,
        mm2s_irqdelay_wren          => mm2s_irqdelay_wren                   ,
        mm2s_irqthresh_rstdsbl      => mm2s_irqthresh_rstdsbl               , -- CR572013
        mm2s_irqdelay_status        => mm2s_irqdelay_status                 ,
        mm2s_irqthresh_status       => mm2s_irqthresh_status                ,
        mm2s_dlyirq_dsble           => mm2s_dlyirq_dsble                    , -- CR605888
        mm2s_ftch_interr_set        => mm2s_ftch_interr_set                 ,
        mm2s_ftch_slverr_set        => mm2s_ftch_slverr_set                 ,
        mm2s_ftch_decerr_set        => mm2s_ftch_decerr_set                 ,
        mm2s_updt_interr_set        => mm2s_updt_interr_set                 ,
        mm2s_updt_slverr_set        => mm2s_updt_slverr_set                 ,
        mm2s_updt_decerr_set        => mm2s_updt_decerr_set                 ,

        -- MM2S CURDESC Update
        mm2s_new_curdesc_wren       => mm2s_new_curdesc_wren                ,
        mm2s_new_curdesc            => mm2s_new_curdesc                     ,

        -- MM2S TAILDESC Update
        mm2s_tailpntr_updated       => mm2s_tailpntr_updated                ,

        -- MM2S Registers
        mm2s_dmacr                  => mm2s_dmacr                           ,
        mm2s_dmasr                  => mm2s_dmasr                           ,
        mm2s_curdesc                => mm2s_curdesc                         ,
        mm2s_taildesc               => mm2s_taildesc                        ,
        mm2s_sa                     => mm2s_sa                              ,
        mm2s_length                 => mm2s_length                          ,
        mm2s_length_wren            => mm2s_length_wren                     ,

        s2mm_sof                    => s2mm_packet_sof                      ,
        s2mm_eof                    => s2mm_packet_eof                      , 

        -- S2MM DMASR Status
        s2mm_stop                   => s2mm_stop                            ,
        s2mm_halted_clr             => s2mm_halted_clr                      ,
        s2mm_halted_set             => s2mm_halted_set                      ,
        s2mm_idle_set               => s2mm_idle_set                        ,
        s2mm_idle_clr               => s2mm_idle_clr                        ,
        s2mm_dma_interr_set         => s2mm_dma_interr_set                  ,
        s2mm_dma_slverr_set         => s2mm_dma_slverr_set                  ,
        s2mm_dma_decerr_set         => s2mm_dma_decerr_set                  ,
        s2mm_ioc_irq_set            => s2mm_ioc_irq_set                     ,
        s2mm_dly_irq_set            => s2mm_dly_irq_set                     ,
        s2mm_irqthresh_wren         => s2mm_irqthresh_wren                  ,
        s2mm_irqdelay_wren          => s2mm_irqdelay_wren                   ,
        s2mm_irqthresh_rstdsbl      => s2mm_irqthresh_rstdsbl               , -- CR572013
        s2mm_irqdelay_status        => s2mm_irqdelay_status                 ,
        s2mm_irqthresh_status       => s2mm_irqthresh_status                ,
        s2mm_dlyirq_dsble           => s2mm_dlyirq_dsble                    , -- CR605888
        s2mm_ftch_interr_set        => s2mm_ftch_interr_set                 ,
        s2mm_ftch_slverr_set        => s2mm_ftch_slverr_set                 ,
        s2mm_ftch_decerr_set        => s2mm_ftch_decerr_set                 ,
        s2mm_updt_interr_set        => s2mm_updt_interr_set                 ,
        s2mm_updt_slverr_set        => s2mm_updt_slverr_set                 ,
        s2mm_updt_decerr_set        => s2mm_updt_decerr_set                 ,

        -- MM2S CURDESC Update
        s2mm_new_curdesc_wren       => s2mm_new_curdesc_wren                ,
        s2mm_new_curdesc            => s2mm_new_curdesc                     ,
        s2mm_tvalid                 => s_axis_s2mm_tvalid                   ,
        s2mm_tvalid_latch           => s2mm_tvalid_latch                    , 
        s2mm_tvalid_latch_del           => s2mm_tvalid_latch_del                    , 

        -- MM2S TAILDESC Update
        s2mm_tailpntr_updated       => s2mm_tailpntr_updated                ,

        -- S2MM Registers
        s2mm_dmacr                  => s2mm_dmacr                           ,
        s2mm_dmasr                  => s2mm_dmasr                           ,
        s2mm_curdesc                => s2mm_curdesc                         ,
        s2mm_taildesc               => s2mm_taildesc                        ,
        s2mm_da                     => s2mm_da                              ,
        s2mm_length                 => s2mm_length                          ,
        s2mm_length_wren            => s2mm_length_wren                     ,
        s2mm_bytes_rcvd             => s2mm_bytes_rcvd                      ,
        s2mm_bytes_rcvd_wren        => s2mm_bytes_rcvd_wren                 ,
    
        tdest_in                    => tdest_out_int, --s_axis_s2mm_tdest                    ,
        same_tdest_in               => same_tdest,
        sg_ctl                      => sg_ctl                               ,


        -- Soft reset and clear
        soft_reset                  => soft_reset                           ,
        soft_reset_clr              => soft_reset_clr                       ,

        -- Fetch/Update error addresses
        ftch_error_addr             => ftch_error_addr                      ,
        updt_error_addr             => updt_error_addr                      ,

        -- DMA Interrupt Outputs
        mm2s_introut                => mm2s_introut                         ,
        s2mm_introut                => s2mm_introut ,
        bd_eq                       => bd_eq
    );

-------------------------------------------------------------------------------
-- Scatter Gather Mode (C_INCLUDE_SG = 1)
-------------------------------------------------------------------------------
GEN_SG_ENGINE : if C_INCLUDE_SG = 1 generate
begin
--    reset1 <= dm_m_axi_sg_aresetn and s2mm_tvalid_latch;
--    reset2 <= m_axi_sg_aresetn and s2mm_tvalid_latch;
    s2mm_run_stop_del <= s2mm_tvalid_latch_del and s2mm_dmacr(DMACR_RS_BIT);
--    s2mm_run_stop_del <= (not (updt_cmpt)) and s2mm_dmacr(DMACR_RS_BIT);
    s2mm_desc_flush_del <= s2mm_desc_flush or  (not s2mm_tvalid_latch);

    -- Scatter Gather Engine
    I_SG_ENGINE : entity  axi_sg_v4_1_2.axi_sg
        generic map(
            C_M_AXI_SG_ADDR_WIDTH       => ADDR_WIDTH            ,
            C_M_AXI_SG_DATA_WIDTH       => C_M_AXI_SG_DATA_WIDTH            ,
            C_M_AXIS_SG_TDATA_WIDTH     => M_AXIS_SG_TDATA_WIDTH            ,
            C_S_AXIS_UPDPTR_TDATA_WIDTH => S_AXIS_UPDPTR_TDATA_WIDTH        ,
            C_S_AXIS_UPDSTS_TDATA_WIDTH => S_AXIS_UPDSTS_TDATA_WIDTH        ,
            C_SG_FTCH_DESC2QUEUE        => SG_FTCH_DESC2QUEUE               ,
            C_SG_UPDT_DESC2QUEUE        => SG_UPDT_DESC2QUEUE               ,
            C_SG_CH1_WORDS_TO_FETCH     => SG_CH1_WORDS_TO_FETCH            ,
            C_SG_CH1_WORDS_TO_UPDATE    => SG_CH1_WORDS_TO_UPDATE           ,
            C_SG_CH1_FIRST_UPDATE_WORD  => SG_CH1_FIRST_UPDATE_WORD         ,
            C_SG_CH1_ENBL_STALE_ERROR   => SG_CH1_ENBL_STALE_ERROR          ,
            C_SG_CH2_WORDS_TO_FETCH     => SG_CH2_WORDS_TO_FETCH            ,
            C_SG_CH2_WORDS_TO_UPDATE    => SG_CH2_WORDS_TO_UPDATE           ,
            C_SG_CH2_FIRST_UPDATE_WORD  => SG_CH2_FIRST_UPDATE_WORD         ,
            C_SG_CH2_ENBL_STALE_ERROR   => SG_CH2_ENBL_STALE_ERROR          ,
            C_AXIS_IS_ASYNC             => SG_IS_SYNCHRONOUS                ,
            C_ASYNC                     => C_PRMRY_IS_ACLK_ASYNC                ,
            C_INCLUDE_CH1               => C_INCLUDE_MM2S                   ,
            C_INCLUDE_CH2               => C_INCLUDE_S2MM                   ,
            C_INCLUDE_DESC_UPDATE       => INCLUDE_DESC_UPDATE              ,
            C_INCLUDE_INTRPT            => INCLUDE_INTRPT                   ,
            C_INCLUDE_DLYTMR            => INCLUDE_DLYTMR                   ,
            C_DLYTMR_RESOLUTION         => C_DLYTMR_RESOLUTION              ,
            C_ENABLE_MULTI_CHANNEL             => C_ENABLE_MULTI_CHANNEL                  ,
            C_ENABLE_EXTRA_FIELD        => STSCNTRL_ENABLE ,
            C_NUM_S2MM_CHANNELS         => C_NUM_S2MM_CHANNELS              ,
            C_NUM_MM2S_CHANNELS         => C_NUM_MM2S_CHANNELS              ,
            C_ACTUAL_ADDR               => C_M_AXI_SG_ADDR_WIDTH            ,            
            C_FAMILY                    => C_FAMILY
        )
        port map(
            -----------------------------------------------------------------------
            -- AXI Scatter Gather Interface
            -----------------------------------------------------------------------
            m_axi_sg_aclk               => axi_sg_aclk                      ,
            m_axi_mm2s_aclk             => m_axi_mm2s_aclk                  ,
            m_axi_sg_aresetn            => m_axi_sg_aresetn                 ,
            dm_resetn                   => dm_m_axi_sg_aresetn              ,
            p_reset_n                   => mm2s_prmry_resetn                    ,

            -- Scatter Gather Write Address Channel
            m_axi_sg_awaddr             => m_axi_sg_awaddr_internal                  ,
            m_axi_sg_awlen              => m_axi_sg_awlen                   ,
            m_axi_sg_awsize             => m_axi_sg_awsize                  ,
            m_axi_sg_awburst            => m_axi_sg_awburst                 ,
            m_axi_sg_awprot             => m_axi_sg_awprot                  ,
            m_axi_sg_awcache            => m_axi_sg_awcache                 ,
            m_axi_sg_awuser             => m_axi_sg_awuser                  ,
            m_axi_sg_awvalid            => m_axi_sg_awvalid                 ,
            m_axi_sg_awready            => m_axi_sg_awready                 ,

            -- Scatter Gather Write Data Channel
            m_axi_sg_wdata              => m_axi_sg_wdata                   ,
            m_axi_sg_wstrb              => m_axi_sg_wstrb                   ,
            m_axi_sg_wlast              => m_axi_sg_wlast                   ,
            m_axi_sg_wvalid             => m_axi_sg_wvalid                  ,
            m_axi_sg_wready             => m_axi_sg_wready                  ,

            -- Scatter Gather Write Response Channel
            m_axi_sg_bresp              => m_axi_sg_bresp                   ,
            m_axi_sg_bvalid             => m_axi_sg_bvalid                  ,
            m_axi_sg_bready             => m_axi_sg_bready                  ,

            -- Scatter Gather Read Address Channel
            m_axi_sg_araddr             => m_axi_sg_araddr_internal                  ,
            m_axi_sg_arlen              => m_axi_sg_arlen                   ,
            m_axi_sg_arsize             => m_axi_sg_arsize                  ,
            m_axi_sg_arburst            => m_axi_sg_arburst                 ,
            m_axi_sg_arprot             => m_axi_sg_arprot                  ,
            m_axi_sg_arcache            => m_axi_sg_arcache                 ,
            m_axi_sg_aruser             => m_axi_sg_aruser                  ,
            m_axi_sg_arvalid            => m_axi_sg_arvalid                 ,
            m_axi_sg_arready            => m_axi_sg_arready                 ,

            -- Memory Map to Stream Scatter Gather Read Data Channel
            m_axi_sg_rdata              => m_axi_sg_rdata                   ,
            m_axi_sg_rresp              => m_axi_sg_rresp                   ,
            m_axi_sg_rlast              => m_axi_sg_rlast                   ,
            m_axi_sg_rvalid             => m_axi_sg_rvalid                  ,
            m_axi_sg_rready             => m_axi_sg_rready                  ,
    
            sg_ctl                      => sg_ctl                           ,
            -- Channel 1 Control and Status
            ch1_run_stop                => mm2s_dmacr(DMACR_RS_BIT)         ,
            ch1_cyclic                  => mm2s_dmacr(CYCLIC_BIT)           ,
            ch1_desc_flush              => mm2s_desc_flush                  ,
            ch1_cntrl_strm_stop         => mm2s_cntrl_strm_stop             ,
            ch1_ftch_idle               => mm2s_ftch_idle                   ,
            ch1_ftch_interr_set         => mm2s_ftch_interr_set             ,
            ch1_ftch_slverr_set         => mm2s_ftch_slverr_set             ,
            ch1_ftch_decerr_set         => mm2s_ftch_decerr_set             ,
            ch1_ftch_err_early          => mm2s_ftch_err_early              ,
            ch1_ftch_stale_desc         => mm2s_ftch_stale_desc             ,
            ch1_updt_idle               => mm2s_updt_idle                   ,
            ch1_updt_ioc_irq_set        => mm2s_updt_ioc_irq_set            ,
            ch1_updt_interr_set         => mm2s_updt_interr_set             ,
            ch1_updt_slverr_set         => mm2s_updt_slverr_set             ,
            ch1_updt_decerr_set         => mm2s_updt_decerr_set             ,
            ch1_dma_interr_set          => mm2s_dma_interr_set              ,
            ch1_dma_slverr_set          => mm2s_dma_slverr_set              ,
            ch1_dma_decerr_set          => mm2s_dma_decerr_set              ,
            ch1_tailpntr_enabled        => mm2s_dmacr(DMACR_TAILPEN_BIT)    ,
            ch1_taildesc_wren           => mm2s_tailpntr_updated            ,
            ch1_taildesc                => mm2s_taildesc                    ,
            ch1_curdesc                 => mm2s_curdesc                     ,

            -- Channel 1 Interrupt Coalescing Signals
            --ch1_dlyirq_dsble            => mm2s_dmasr(DMASR_DLYIRQ_BIT)   , -- CR605888
            ch1_dlyirq_dsble            => mm2s_dlyirq_dsble                , -- CR605888
            ch1_irqthresh_rstdsbl       => mm2s_irqthresh_rstdsbl           , -- CR572013
            ch1_irqdelay_wren           => mm2s_irqdelay_wren               ,
            ch1_irqdelay                => mm2s_dmacr(DMACR_IRQDELAY_MSB_BIT
                                               downto DMACR_IRQDELAY_LSB_BIT),
            ch1_irqthresh_wren          => mm2s_irqthresh_wren              ,
            ch1_irqthresh               => mm2s_dmacr(DMACR_IRQTHRESH_MSB_BIT
                                               downto DMACR_IRQTHRESH_LSB_BIT),
            ch1_packet_sof              => mm2s_packet_sof                  ,
            ch1_packet_eof              => mm2s_packet_eof                  ,
            ch1_ioc_irq_set             => mm2s_ioc_irq_set                 ,
            ch1_dly_irq_set             => mm2s_dly_irq_set                 ,
            ch1_irqdelay_status         => mm2s_irqdelay_status             ,
            ch1_irqthresh_status        => mm2s_irqthresh_status            ,

            -- Channel 1 AXI Fetch Stream Out
            m_axis_ch1_ftch_aclk        => axi_sg_aclk                      ,
            m_axis_ch1_ftch_tdata       => m_axis_mm2s_ftch_tdata           ,
            m_axis_ch1_ftch_tvalid      => m_axis_mm2s_ftch_tvalid          ,
            m_axis_ch1_ftch_tready      => m_axis_mm2s_ftch_tready          ,
            m_axis_ch1_ftch_tlast       => m_axis_mm2s_ftch_tlast           ,

            m_axis_ch1_ftch_tdata_new       => m_axis_mm2s_ftch_tdata_new           ,
            m_axis_ch1_ftch_tdata_mcdma_new       => m_axis_mm2s_ftch_tdata_mcdma_new           ,
            m_axis_ch1_ftch_tvalid_new      => m_axis_mm2s_ftch_tvalid_new          ,
            m_axis_ftch1_desc_available  => m_axis_ftch1_desc_available,


            -- Channel 1 AXI Update Stream In
            s_axis_ch1_updt_aclk        => axi_sg_aclk                      ,
            s_axis_ch1_updtptr_tdata    => s_axis_mm2s_updtptr_tdata        ,
            s_axis_ch1_updtptr_tvalid   => s_axis_mm2s_updtptr_tvalid       ,
            s_axis_ch1_updtptr_tready   => s_axis_mm2s_updtptr_tready       ,
            s_axis_ch1_updtptr_tlast    => s_axis_mm2s_updtptr_tlast        ,

            s_axis_ch1_updtsts_tdata    => s_axis_mm2s_updtsts_tdata        ,
            s_axis_ch1_updtsts_tvalid   => s_axis_mm2s_updtsts_tvalid       ,
            s_axis_ch1_updtsts_tready   => s_axis_mm2s_updtsts_tready       ,
            s_axis_ch1_updtsts_tlast    => s_axis_mm2s_updtsts_tlast        ,

            -- Channel 2 Control and Status
            ch2_run_stop                => s2mm_run_stop_del                , --s2mm_dmacr(DMACR_RS_BIT)         ,
            ch2_cyclic                  => s2mm_dmacr(CYCLIC_BIT)           ,
            ch2_desc_flush              => s2mm_desc_flush_del, --s2mm_desc_flush                  ,
            ch2_ftch_idle               => s2mm_ftch_idle                   ,
            ch2_ftch_interr_set         => s2mm_ftch_interr_set             ,
            ch2_ftch_slverr_set         => s2mm_ftch_slverr_set             ,
            ch2_ftch_decerr_set         => s2mm_ftch_decerr_set             ,
            ch2_ftch_err_early          => s2mm_ftch_err_early              ,
            ch2_ftch_stale_desc         => s2mm_ftch_stale_desc             ,
            ch2_updt_idle               => s2mm_updt_idle                   ,
            ch2_updt_ioc_irq_set        => s2mm_updt_ioc_irq_set            , -- For TestVector
            ch2_updt_interr_set         => s2mm_updt_interr_set             ,
            ch2_updt_slverr_set         => s2mm_updt_slverr_set             ,
            ch2_updt_decerr_set         => s2mm_updt_decerr_set             ,
            ch2_dma_interr_set          => s2mm_dma_interr_set              ,
            ch2_dma_slverr_set          => s2mm_dma_slverr_set              ,
            ch2_dma_decerr_set          => s2mm_dma_decerr_set              ,
            ch2_tailpntr_enabled        => s2mm_dmacr(DMACR_TAILPEN_BIT)    ,
            ch2_taildesc_wren           => s2mm_tailpntr_updated            ,
            ch2_taildesc                => s2mm_taildesc                    ,
            ch2_curdesc                 => s2mm_curdesc                     ,

            -- Channel 2 Interrupt Coalescing Signals
            --ch2_dlyirq_dsble            => s2mm_dmasr(DMASR_DLYIRQ_BIT)   , -- CR605888
            ch2_dlyirq_dsble            => s2mm_dlyirq_dsble                , -- CR605888
            ch2_irqthresh_rstdsbl       => s2mm_irqthresh_rstdsbl           , -- CR572013
            ch2_irqdelay_wren           => s2mm_irqdelay_wren               ,
            ch2_irqdelay                => s2mm_dmacr(DMACR_IRQDELAY_MSB_BIT
                                               downto DMACR_IRQDELAY_LSB_BIT),
            ch2_irqthresh_wren          => s2mm_irqthresh_wren              ,
            ch2_irqthresh               => s2mm_dmacr(DMACR_IRQTHRESH_MSB_BIT
                                               downto DMACR_IRQTHRESH_LSB_BIT),
            ch2_packet_sof              => s2mm_packet_sof                  ,
            ch2_packet_eof              => s2mm_packet_eof                  ,
            ch2_ioc_irq_set             => s2mm_ioc_irq_set                 ,
            ch2_dly_irq_set             => s2mm_dly_irq_set                 ,
            ch2_irqdelay_status         => s2mm_irqdelay_status             ,
            ch2_irqthresh_status        => s2mm_irqthresh_status            ,
            ch2_update_active           => ch2_update_active                ,

            -- Channel 2 AXI Fetch Stream Out
            m_axis_ch2_ftch_aclk        => axi_sg_aclk                      ,
            m_axis_ch2_ftch_tdata       => m_axis_s2mm_ftch_tdata           ,
            m_axis_ch2_ftch_tvalid      => m_axis_s2mm_ftch_tvalid          ,
            m_axis_ch2_ftch_tready      => m_axis_s2mm_ftch_tready          ,
            m_axis_ch2_ftch_tlast       => m_axis_s2mm_ftch_tlast           ,

            m_axis_ch2_ftch_tdata_new       => m_axis_s2mm_ftch_tdata_new           ,
            m_axis_ch2_ftch_tdata_mcdma_new       => m_axis_s2mm_ftch_tdata_mcdma_new           ,
            m_axis_ch2_ftch_tdata_mcdma_nxt       => m_axis_s2mm_ftch_tdata_mcdma_nxt           ,
            m_axis_ch2_ftch_tvalid_new      => m_axis_s2mm_ftch_tvalid_new          ,
            m_axis_ftch2_desc_available  => m_axis_ftch2_desc_available,

            -- Channel 2 AXI Update Stream In
            s_axis_ch2_updt_aclk        => axi_sg_aclk                      ,
            s_axis_ch2_updtptr_tdata    => s_axis_s2mm_updtptr_tdata        ,
            s_axis_ch2_updtptr_tvalid   => s_axis_s2mm_updtptr_tvalid       ,
            s_axis_ch2_updtptr_tready   => s_axis_s2mm_updtptr_tready       ,
            s_axis_ch2_updtptr_tlast    => s_axis_s2mm_updtptr_tlast        ,

            s_axis_ch2_updtsts_tdata    => s_axis_s2mm_updtsts_tdata        ,
            s_axis_ch2_updtsts_tvalid   => s_axis_s2mm_updtsts_tvalid       ,
            s_axis_ch2_updtsts_tready   => s_axis_s2mm_updtsts_tready       ,
            s_axis_ch2_updtsts_tlast    => s_axis_s2mm_updtsts_tlast        ,


            -- Error addresses        
            ftch_error                  => ftch_error                       ,
            ftch_error_addr             => ftch_error_addr                  ,
            updt_error                  => updt_error                       ,
            updt_error_addr             => updt_error_addr                  ,

        m_axis_mm2s_cntrl_tdata  => m_axis_mm2s_cntrl_tdata  ,
        m_axis_mm2s_cntrl_tkeep  => m_axis_mm2s_cntrl_tkeep  ,
        m_axis_mm2s_cntrl_tvalid => m_axis_mm2s_cntrl_tvalid ,
        m_axis_mm2s_cntrl_tready => m_axis_mm2s_cntrl_tready ,
        m_axis_mm2s_cntrl_tlast  => m_axis_mm2s_cntrl_tlast ,
            bd_eq                => bd_eq

        );

m_axi_sg_awaddr <= m_axi_sg_awaddr_internal (C_M_AXI_SG_ADDR_WIDTH-1 downto 0);
m_axi_sg_araddr <= m_axi_sg_araddr_internal (C_M_AXI_SG_ADDR_WIDTH-1 downto 0);

end generate GEN_SG_ENGINE;

-------------------------------------------------------------------------------
-- Exclude Scatter Gather Engine (Simple DMA Mode Enabled)
-------------------------------------------------------------------------------
GEN_NO_SG_ENGINE : if C_INCLUDE_SG = 0 generate
begin
    -- Scatter Gather AXI Master Interface Tie-Off
    m_axi_sg_awaddr             <= (others => '0');
    m_axi_sg_awlen              <= (others => '0');
    m_axi_sg_awsize             <= (others => '0');
    m_axi_sg_awburst            <= (others => '0');
    m_axi_sg_awprot             <= (others => '0');
    m_axi_sg_awcache            <= (others => '0');
    m_axi_sg_awvalid            <= '0';
    m_axi_sg_wdata              <= (others => '0');
    m_axi_sg_wstrb              <= (others => '0');
    m_axi_sg_wlast              <= '0';
    m_axi_sg_wvalid             <= '0';
    m_axi_sg_bready             <= '0';
    m_axi_sg_araddr             <= (others => '0');
    m_axi_sg_arlen              <= (others => '0');
    m_axi_sg_arsize             <= (others => '0');
    m_axi_sg_arburst            <= (others => '0');
    m_axi_sg_arcache            <= (others => '0');
    m_axi_sg_arprot             <= (others => '0');
    m_axi_sg_arvalid            <= '0';
    m_axi_sg_rready             <= '0';
    m_axis_mm2s_cntrl_tdata     <= (others => '0');
        m_axis_mm2s_cntrl_tkeep     <= (others => '0');
        m_axis_mm2s_cntrl_tvalid    <= '0';
        m_axis_mm2s_cntrl_tlast     <= '0';
  

    -- MM2S Signal Remapping/Tie Off for Simple DMA Mode
    m_axis_mm2s_ftch_tdata      <= (others => '0');
    m_axis_mm2s_ftch_tvalid     <= '0';
    m_axis_mm2s_ftch_tlast      <= '0';
    s_axis_mm2s_updtptr_tready  <= '0';
    s_axis_mm2s_updtsts_tready  <= '0';
    mm2s_ftch_idle              <= '1';
    mm2s_updt_idle              <= '1';
    mm2s_ftch_interr_set        <= '0';
    mm2s_ftch_slverr_set        <= '0';
    mm2s_ftch_decerr_set        <= '0';
    mm2s_ftch_err_early         <= '0';
    mm2s_ftch_stale_desc        <= '0';
    mm2s_updt_interr_set        <= '0';
    mm2s_updt_slverr_set        <= '0';
    mm2s_updt_decerr_set        <= '0';
    mm2s_updt_ioc_irq_set       <= mm2s_smpl_done;       -- For TestVector
    mm2s_dma_interr_set         <= mm2s_smpl_interr_set; -- To DMASR
    mm2s_dma_slverr_set         <= mm2s_smpl_slverr_set; -- To DMASR
    mm2s_dma_decerr_set         <= mm2s_smpl_decerr_set; -- To DMASR


    -- S2MM Signal Remapping/Tie Off for Simple DMA Mode
    m_axis_s2mm_ftch_tdata      <= (others => '0');
    m_axis_s2mm_ftch_tvalid     <= '0';
    m_axis_s2mm_ftch_tlast      <= '0';
    s_axis_s2mm_updtptr_tready  <= '0';
    s_axis_s2mm_updtsts_tready  <= '0';
    s2mm_ftch_idle              <= '1';
    s2mm_updt_idle              <= '1';
    s2mm_ftch_interr_set        <= '0';
    s2mm_ftch_slverr_set        <= '0';
    s2mm_ftch_decerr_set        <= '0';
    s2mm_ftch_err_early         <= '0';
    s2mm_ftch_stale_desc        <= '0';
    s2mm_updt_interr_set        <= '0';
    s2mm_updt_slverr_set        <= '0';
    s2mm_updt_decerr_set        <= '0';
    s2mm_updt_ioc_irq_set       <= s2mm_smpl_done;       -- For TestVector
    s2mm_dma_interr_set         <= s2mm_smpl_interr_set; -- To DMASR
    s2mm_dma_slverr_set         <= s2mm_smpl_slverr_set; -- To DMASR
    s2mm_dma_decerr_set         <= s2mm_smpl_decerr_set; -- To DMASR

    ftch_error                  <= '0';
    ftch_error_addr             <= (others => '0');
    updt_error                  <= '0';
    updt_error_addr             <= (others=> '0');

-- CR595462 - Removed interrupt coalescing logic for Simple DMA mode and replaced
-- with interrupt complete.
    mm2s_ioc_irq_set            <= mm2s_smpl_done;
    mm2s_dly_irq_set            <= '0';
    mm2s_irqdelay_status        <= (others => '0');
    mm2s_irqthresh_status       <= (others => '0');

    s2mm_ioc_irq_set            <= s2mm_smpl_done;
    s2mm_dly_irq_set            <= '0';
    s2mm_irqdelay_status        <= (others => '0');
    s2mm_irqthresh_status       <= (others => '0');

end generate GEN_NO_SG_ENGINE;

INCLUDE_MM2S_SOF_EOF_GENERATOR : if C_INCLUDE_MM2S = 1 generate
begin

-------------------------------------------------------------------------------
-- MM2S DMA Controller
-------------------------------------------------------------------------------
I_MM2S_DMA_MNGR : entity  axi_dma_v7_1_8.axi_dma_mm2s_mngr
    generic map(

        C_PRMRY_IS_ACLK_ASYNC       => C_PRMRY_IS_ACLK_ASYNC                ,
        C_PRMY_CMDFIFO_DEPTH        => DM_CMDSTS_FIFO_DEPTH                 ,
        C_INCLUDE_SG                => C_INCLUDE_SG                         ,
        C_SG_INCLUDE_STSCNTRL_STRM  => STSCNTRL_ENABLE           ,
        C_SG_INCLUDE_DESC_QUEUE     => DESC_QUEUE              ,
        C_SG_LENGTH_WIDTH           => C_SG_LENGTH_WIDTH_INT                    ,
        C_M_AXI_SG_ADDR_WIDTH       => ADDR_WIDTH                ,
        C_M_AXIS_SG_TDATA_WIDTH     => M_AXIS_SG_TDATA_WIDTH                ,
        C_S_AXIS_UPDPTR_TDATA_WIDTH => S_AXIS_UPDPTR_TDATA_WIDTH            ,
        C_S_AXIS_UPDSTS_TDATA_WIDTH => S_AXIS_UPDSTS_TDATA_WIDTH            ,
        C_M_AXIS_MM2S_CNTRL_TDATA_WIDTH => C_M_AXIS_MM2S_CNTRL_TDATA_WIDTH  ,
        C_INCLUDE_MM2S              => C_INCLUDE_MM2S                       ,
        C_M_AXI_MM2S_ADDR_WIDTH     => ADDR_WIDTH, --C_M_AXI_MM2S_ADDR_WIDTH              ,
        C_ENABLE_MULTI_CHANNEL             => C_ENABLE_MULTI_CHANNEL        , 
        C_MICRO_DMA                 => C_MICRO_DMA                          ,
        C_FAMILY                    => C_FAMILY
    )
    port map(

        -- Secondary Clock and Reset
        m_axi_sg_aclk               => axi_sg_aclk                          ,
        m_axi_sg_aresetn            => mm2s_scndry_resetn                   ,

        -- Primary Clock and Reset
        axi_prmry_aclk              => m_axi_mm2s_aclk                      ,
        p_reset_n                   => mm2s_prmry_resetn                    ,

        soft_reset                  => soft_reset                           ,

        -- MM2S Control and Status
        mm2s_run_stop               => mm2s_dmacr(DMACR_RS_BIT)             ,
        mm2s_keyhole                => mm2s_dmacr(DMACR_KH_BIT)             ,
        mm2s_halted                 => mm2s_dmasr(DMASR_HALTED_BIT)         ,
        mm2s_ftch_idle              => mm2s_ftch_idle                       ,
        mm2s_updt_idle              => mm2s_updt_idle                       ,
        mm2s_halt                   => mm2s_halt                            ,
        mm2s_halt_cmplt             => mm2s_halt_cmplt                      ,
        mm2s_halted_clr             => mm2s_halted_clr                      ,
        mm2s_halted_set             => mm2s_halted_set                      ,
        mm2s_idle_set               => mm2s_idle_set                        ,
        mm2s_idle_clr               => mm2s_idle_clr                        ,
        mm2s_stop                   => mm2s_stop                            ,
        mm2s_ftch_err_early         => mm2s_ftch_err_early                  ,
        mm2s_ftch_stale_desc        => mm2s_ftch_stale_desc                 ,
        mm2s_desc_flush             => mm2s_desc_flush                      ,
        cntrl_strm_stop             => mm2s_cntrl_strm_stop                 ,  
        mm2s_tailpntr_enble         => mm2s_dmacr(DMACR_TAILPEN_BIT)        ,
        mm2s_all_idle               => mm2s_all_idle                        ,
        mm2s_error                  => mm2s_error                           ,
        s2mm_error                  => s2mm_error                           ,

        -- Simple DMA Mode Signals
        mm2s_sa                     => mm2s_sa                              ,
        mm2s_length                 => mm2s_length                          ,
        mm2s_length_wren            => mm2s_length_wren                     ,
        mm2s_smple_done             => mm2s_smpl_done                       ,
        mm2s_interr_set             => mm2s_smpl_interr_set                 ,
        mm2s_slverr_set             => mm2s_smpl_slverr_set                 ,
        mm2s_decerr_set             => mm2s_smpl_decerr_set                 ,

        m_axis_mm2s_aclk            => m_axi_mm2s_aclk,
        mm2s_strm_tlast             => m_axis_mm2s_tlast_i_user,
        mm2s_strm_tready            => m_axis_mm2s_tready,
        mm2s_axis_info              => mm2s_axis_info,

        -- SG MM2S Descriptor Fetch AXI Stream In
        m_axis_mm2s_ftch_tdata      => m_axis_mm2s_ftch_tdata               ,
        m_axis_mm2s_ftch_tvalid     => m_axis_mm2s_ftch_tvalid              ,
        m_axis_mm2s_ftch_tready     => m_axis_mm2s_ftch_tready              ,
        m_axis_mm2s_ftch_tlast      => m_axis_mm2s_ftch_tlast               ,

        m_axis_mm2s_ftch_tdata_new      => m_axis_mm2s_ftch_tdata_new               ,
        m_axis_mm2s_ftch_tdata_mcdma_new      => m_axis_mm2s_ftch_tdata_mcdma_new               ,
        m_axis_mm2s_ftch_tvalid_new     => m_axis_mm2s_ftch_tvalid_new              ,
            m_axis_ftch1_desc_available  => m_axis_ftch1_desc_available,

        -- SG MM2S Descriptor Update AXI Stream Out
        s_axis_mm2s_updtptr_tdata   => s_axis_mm2s_updtptr_tdata            ,
        s_axis_mm2s_updtptr_tvalid  => s_axis_mm2s_updtptr_tvalid           ,
        s_axis_mm2s_updtptr_tready  => s_axis_mm2s_updtptr_tready           ,
        s_axis_mm2s_updtptr_tlast   => s_axis_mm2s_updtptr_tlast            ,

        s_axis_mm2s_updtsts_tdata   => s_axis_mm2s_updtsts_tdata            ,
        s_axis_mm2s_updtsts_tvalid  => s_axis_mm2s_updtsts_tvalid           ,
        s_axis_mm2s_updtsts_tready  => s_axis_mm2s_updtsts_tready           ,
        s_axis_mm2s_updtsts_tlast   => s_axis_mm2s_updtsts_tlast            ,


        -- Currently Being Processed Descriptor
        mm2s_new_curdesc            => mm2s_new_curdesc                     ,
        mm2s_new_curdesc_wren       => mm2s_new_curdesc_wren                ,

        -- User Command Interface Ports (AXI Stream)
        s_axis_mm2s_cmd_tvalid      => s_axis_mm2s_cmd_tvalid_split               ,
        s_axis_mm2s_cmd_tready      => s_axis_mm2s_cmd_tready_split               ,
        s_axis_mm2s_cmd_tdata       => s_axis_mm2s_cmd_tdata_split                ,

        -- User Status Interface Ports (AXI Stream)
        m_axis_mm2s_sts_tvalid      => m_axis_mm2s_sts_tvalid               ,
        m_axis_mm2s_sts_tready      => m_axis_mm2s_sts_tready               ,
        m_axis_mm2s_sts_tdata       => m_axis_mm2s_sts_tdata                ,
        m_axis_mm2s_sts_tkeep       => m_axis_mm2s_sts_tkeep                ,
        mm2s_err                    => mm2s_err                             ,
        updt_error                  => updt_error                           ,
        ftch_error                  => ftch_error                           ,

        -- Memory Map to Stream Control Stream Interface
        m_axis_mm2s_cntrl_tdata     => open, --m_axis_mm2s_cntrl_tdata              ,
        m_axis_mm2s_cntrl_tkeep     => open, --m_axis_mm2s_cntrl_tkeep              ,
        m_axis_mm2s_cntrl_tvalid    => open, --m_axis_mm2s_cntrl_tvalid             ,
        m_axis_mm2s_cntrl_tready    => '0', --m_axis_mm2s_cntrl_tready             ,
        m_axis_mm2s_cntrl_tlast     => open --m_axis_mm2s_cntrl_tlast
    );

        m_axis_mm2s_tuser  <=  mm2s_axis_info (13 downto 10);
        m_axis_mm2s_tid    <=  mm2s_axis_info (9 downto 5);              --
        m_axis_mm2s_tdest  <=  mm2s_axis_info (4 downto 0)     ;              --

-- If MM2S channel included then include sof/eof generator
    -------------------------------------------------------------------------------
    -- MM2S SOF / EOF generation for interrupt coalescing
    -------------------------------------------------------------------------------
    I_MM2S_SOFEOF_GEN : entity  axi_dma_v7_1_8.axi_dma_sofeof_gen
        generic map(
            C_PRMRY_IS_ACLK_ASYNC       => C_PRMRY_IS_ACLK_ASYNC
        )
        port map(
            axi_prmry_aclk              => m_axi_mm2s_aclk                  ,
            p_reset_n                   => mm2s_prmry_resetn                ,

            m_axi_sg_aclk               => axi_sg_aclk                      ,
            m_axi_sg_aresetn            => mm2s_scndry_resetn               ,

            axis_tready                 => m_axis_mm2s_tready               ,
            axis_tvalid                 => m_axis_mm2s_tvalid_i             ,
            axis_tlast                  => m_axis_mm2s_tlast_i              ,

            packet_sof                  => mm2s_packet_sof                  ,
            packet_eof                  => mm2s_packet_eof
        );
end generate INCLUDE_MM2S_SOF_EOF_GENERATOR;

-- If MM2S channel not included then exclude sof/eof generator
EXCLUDE_MM2S_SOF_EOF_GENERATOR : if C_INCLUDE_MM2S = 0 generate
begin
    mm2s_packet_sof <= '0';
    mm2s_packet_eof <= '0';
end generate EXCLUDE_MM2S_SOF_EOF_GENERATOR;


INCLUDE_S2MM_SOF_EOF_GENERATOR : if C_INCLUDE_S2MM = 1 generate
begin

-------------------------------------------------------------------------------
-- S2MM DMA Controller
-------------------------------------------------------------------------------
I_S2MM_DMA_MNGR : entity  axi_dma_v7_1_8.axi_dma_s2mm_mngr
    generic map(

        C_PRMRY_IS_ACLK_ASYNC       => C_PRMRY_IS_ACLK_ASYNC                ,
        C_PRMY_CMDFIFO_DEPTH        => DM_CMDSTS_FIFO_DEPTH                 ,
        C_DM_STATUS_WIDTH           => DM_STATUS_WIDTH                      ,
        C_INCLUDE_SG                => C_INCLUDE_SG                         ,
        C_SG_INCLUDE_STSCNTRL_STRM  => STSCNTRL_ENABLE           ,
        C_SG_INCLUDE_DESC_QUEUE     => DESC_QUEUE              ,
        C_SG_USE_STSAPP_LENGTH      => APPLENGTH_ENABLE               ,
        C_SG_LENGTH_WIDTH           => C_SG_LENGTH_WIDTH_INT                    ,
        C_M_AXI_SG_ADDR_WIDTH       => ADDR_WIDTH                ,
        C_M_AXIS_SG_TDATA_WIDTH     => M_AXIS_SG_TDATA_WIDTH                ,
        C_S_AXIS_UPDPTR_TDATA_WIDTH => S_AXIS_UPDPTR_TDATA_WIDTH            ,
        C_S_AXIS_UPDSTS_TDATA_WIDTH => S_AXIS_UPDSTS_TDATA_WIDTH            ,
        C_S_AXIS_S2MM_STS_TDATA_WIDTH => C_S_AXIS_S2MM_STS_TDATA_WIDTH      ,
        C_INCLUDE_S2MM              => C_INCLUDE_S2MM                       ,
        C_M_AXI_S2MM_ADDR_WIDTH     => ADDR_WIDTH              ,
        C_NUM_S2MM_CHANNELS         => C_NUM_S2MM_CHANNELS                  ,
        C_ENABLE_MULTI_CHANNEL      => C_ENABLE_MULTI_CHANNEL               , 
        C_MICRO_DMA                 => C_MICRO_DMA                          ,
        C_FAMILY                    => C_FAMILY
    )
    port map(

        -- Secondary Clock and Reset
        m_axi_sg_aclk               => axi_sg_aclk                          ,
        m_axi_sg_aresetn            => s2mm_scndry_resetn                   ,

        -- Primary Clock and Reset
        axi_prmry_aclk              => m_axi_s2mm_aclk                      ,
        p_reset_n                   => s2mm_prmry_resetn                    ,

        soft_reset                  => soft_reset                           ,

        -- S2MM Control and Status
        s2mm_run_stop               => s2mm_dmacr(DMACR_RS_BIT)             ,
        s2mm_keyhole                => s2mm_dmacr(DMACR_KH_BIT)             ,
        s2mm_halted                 => s2mm_dmasr(DMASR_HALTED_BIT)         ,
        s2mm_packet_eof_out         => s2mm_eof_s2mm                        ,
        s2mm_ftch_idle              => s2mm_ftch_idle                       ,
        s2mm_updt_idle              => s2mm_updt_idle                       ,
        s2mm_halted_clr             => s2mm_halted_clr                      ,
        s2mm_halted_set             => s2mm_halted_set                      ,
        s2mm_idle_set               => s2mm_idle_set                        ,
        s2mm_idle_clr               => s2mm_idle_clr                        ,
        s2mm_stop                   => s2mm_stop                            ,
        s2mm_ftch_err_early         => s2mm_ftch_err_early                  ,
        s2mm_ftch_stale_desc        => s2mm_ftch_stale_desc                 ,
        s2mm_desc_flush             => s2mm_desc_flush                      ,
        s2mm_tailpntr_enble         => s2mm_dmacr(DMACR_TAILPEN_BIT)        ,
        s2mm_all_idle               => s2mm_all_idle                        ,
        s2mm_halt                   => s2mm_halt                            ,
        s2mm_halt_cmplt             => s2mm_halt_cmplt                      ,
        s2mm_error                  => s2mm_error                           ,
        mm2s_error                  => mm2s_error                           ,

        s2mm_desc_info_in              => s2mm_desc_info_in                       ,

        -- Simple DMA Mode Signals
        s2mm_da                     => s2mm_da                              ,
        s2mm_length                 => s2mm_length                          ,
        s2mm_length_wren            => s2mm_length_wren                     ,
        s2mm_smple_done             => s2mm_smpl_done                       ,
        s2mm_interr_set             => s2mm_smpl_interr_set                 ,
        s2mm_slverr_set             => s2mm_smpl_slverr_set                 ,
        s2mm_decerr_set             => s2mm_smpl_decerr_set                 ,
        s2mm_bytes_rcvd             => s2mm_bytes_rcvd                      ,
        s2mm_bytes_rcvd_wren        => s2mm_bytes_rcvd_wren                 ,

        -- SG S2MM Descriptor Fetch AXI Stream In
        m_axis_s2mm_ftch_tdata      => m_axis_s2mm_ftch_tdata               ,
        m_axis_s2mm_ftch_tvalid     => m_axis_s2mm_ftch_tvalid              ,
        m_axis_s2mm_ftch_tready     => m_axis_s2mm_ftch_tready              ,
        m_axis_s2mm_ftch_tlast      => m_axis_s2mm_ftch_tlast               ,

        m_axis_s2mm_ftch_tdata_new      => m_axis_s2mm_ftch_tdata_new               ,
        m_axis_s2mm_ftch_tdata_mcdma_new      => m_axis_s2mm_ftch_tdata_mcdma_new               ,
        m_axis_s2mm_ftch_tdata_mcdma_nxt      => m_axis_s2mm_ftch_tdata_mcdma_nxt               ,
        m_axis_s2mm_ftch_tvalid_new     => m_axis_s2mm_ftch_tvalid_new              ,
            m_axis_ftch2_desc_available  => m_axis_ftch2_desc_available,

        -- SG S2MM Descriptor Update AXI Stream Out
        s_axis_s2mm_updtptr_tdata   => s_axis_s2mm_updtptr_tdata            ,
        s_axis_s2mm_updtptr_tvalid  => s_axis_s2mm_updtptr_tvalid           ,
        s_axis_s2mm_updtptr_tready  => s_axis_s2mm_updtptr_tready           ,
        s_axis_s2mm_updtptr_tlast   => s_axis_s2mm_updtptr_tlast            ,

        s_axis_s2mm_updtsts_tdata   => s_axis_s2mm_updtsts_tdata            ,
        s_axis_s2mm_updtsts_tvalid  => s_axis_s2mm_updtsts_tvalid           ,
        s_axis_s2mm_updtsts_tready  => s_axis_s2mm_updtsts_tready           ,
        s_axis_s2mm_updtsts_tlast   => s_axis_s2mm_updtsts_tlast            ,

        -- Currently Being Processed Descriptor
        s2mm_new_curdesc            => s2mm_new_curdesc                     ,
        s2mm_new_curdesc_wren       => s2mm_new_curdesc_wren                ,

        -- User Command Interface Ports (AXI Stream)
     --   s_axis_s2mm_cmd_tvalid      => s_axis_s2mm_cmd_tvalid_split               ,
     --   s_axis_s2mm_cmd_tready      => s_axis_s2mm_cmd_tready_split               ,
     --   s_axis_s2mm_cmd_tdata       => s_axis_s2mm_cmd_tdata_split                ,

        s_axis_s2mm_cmd_tvalid      => s_axis_s2mm_cmd_tvalid_split               ,
        s_axis_s2mm_cmd_tready      => s_axis_s2mm_cmd_tready_split               ,
        s_axis_s2mm_cmd_tdata       => s_axis_s2mm_cmd_tdata_split               ,
        -- User Status Interface Ports (AXI Stream)
        m_axis_s2mm_sts_tvalid      => m_axis_s2mm_sts_tvalid               ,
        m_axis_s2mm_sts_tready      => m_axis_s2mm_sts_tready               ,
        m_axis_s2mm_sts_tdata       => m_axis_s2mm_sts_tdata                ,
        m_axis_s2mm_sts_tkeep       => m_axis_s2mm_sts_tkeep                ,
        s2mm_err                    => s2mm_err                             ,
        updt_error                  => updt_error                           ,
        ftch_error                  => ftch_error                           ,

        -- Stream to Memory Map Status Stream Interface
        s_axis_s2mm_sts_tdata       => s_axis_s2mm_sts_tdata                ,
        s_axis_s2mm_sts_tkeep       => s_axis_s2mm_sts_tkeep                ,
        s_axis_s2mm_sts_tvalid      => s_axis_s2mm_sts_tvalid               ,
        s_axis_s2mm_sts_tready      => s_axis_s2mm_sts_tready               ,
        s_axis_s2mm_sts_tlast       => s_axis_s2mm_sts_tlast
    );


-- If S2MM channel included then include sof/eof generator
    -------------------------------------------------------------------------------
    -- S2MM SOF / EOF generation for interrupt coalescing
    -------------------------------------------------------------------------------
    I_S2MM_SOFEOF_GEN : entity  axi_dma_v7_1_8.axi_dma_sofeof_gen
        generic map(
            C_PRMRY_IS_ACLK_ASYNC       => C_PRMRY_IS_ACLK_ASYNC
        )
        port map(
            axi_prmry_aclk              => m_axi_s2mm_aclk                  ,
            p_reset_n                   => s2mm_prmry_resetn                ,

            m_axi_sg_aclk               => axi_sg_aclk                      ,
            m_axi_sg_aresetn            => s2mm_scndry_resetn               ,

            axis_tready                 => s_axis_s2mm_tready_i             ,
            axis_tvalid                 => s_axis_s2mm_tvalid               ,
            axis_tlast                  => s_axis_s2mm_tlast                ,

            packet_sof                  => s2mm_packet_sof                  ,
            packet_eof                  => s2mm_packet_eof
        );
end generate INCLUDE_S2MM_SOF_EOF_GENERATOR;

-- If S2MM channel not included then exclude sof/eof generator
EXCLUDE_S2MM_SOF_EOF_GENERATOR : if C_INCLUDE_S2MM = 0 generate
begin
    s2mm_packet_sof <= '0';
    s2mm_packet_eof <= '0';
end generate EXCLUDE_S2MM_SOF_EOF_GENERATOR;


INCLUDE_S2MM_GATE : if (C_ENABLE_MULTI_CHANNEL = 1 and C_INCLUDE_S2MM = 1) generate
begin
  
   cmpt_updt <= m_axis_s2mm_sts_tvalid & s2mm_eof_s2mm;

   I_S2MM_GATE_GEN : entity  axi_dma_v7_1_8.axi_dma_s2mm
       generic map (
           C_FAMILY => C_FAMILY
       ) 
       port map (
           clk_in     => m_axi_s2mm_aclk, 
           sg_clk     => axi_sg_aclk,
           resetn      => s2mm_prmry_resetn,
           reset_sg    => m_axi_sg_aresetn,
           s2mm_tvalid => s_axis_s2mm_tvalid,
           s2mm_tready => s_axis_s2mm_tready_i,
           s2mm_tlast => s_axis_s2mm_tlast,
           s2mm_tdest => s_axis_s2mm_tdest,
           s2mm_tuser => s_axis_s2mm_tuser,
           s2mm_tid => s_axis_s2mm_tid,
           desc_available => s_axis_s2mm_cmd_tvalid_split,
--           s2mm_eof       => s2mm_eof_s2mm,  
           s2mm_eof_det       => cmpt_updt, --m_axis_s2mm_sts_tvalid, --s2mm_eof_s2mm,  
           ch2_update_active => ch2_update_active,

           tdest_out      => tdest_out_int,
           same_tdest     => same_tdest,
-- to DM
        --   updt_cmpt      => updt_cmpt,
           s2mm_desc_info => s2mm_desc_info_in,
           s2mm_tvalid_out => open, --s_axis_s2mm_tvalid_int,
           s2mm_tready_out => open, --s_axis_s2mm_tready_i,
           s2mm_tlast_out => open, --s_axis_s2mm_tlast_int,
           s2mm_tdest_out => open
          );

end generate INCLUDE_S2MM_GATE;

INCLUDE_S2MM_NOGATE : if (C_ENABLE_MULTI_CHANNEL = 0 and C_INCLUDE_S2MM = 1) generate
begin
           updt_cmpt <= '0';
           tdest_out_int <= (others => '0');
           same_tdest <= '0';
           s_axis_s2mm_tvalid_int <= s_axis_s2mm_tvalid; 
           s_axis_s2mm_tlast_int <= s_axis_s2mm_tlast;

end generate INCLUDE_S2MM_NOGATE;


MM2S_SPLIT : if (C_ENABLE_MULTI_CHANNEL = 1 and C_INCLUDE_MM2S = 1) generate
begin


CLOCKS : if (C_PRMRY_IS_ACLK_ASYNC = 1) generate
begin
      clock_splt <= axi_sg_aclk;

end generate CLOCKS;


CLOCKS_SYNC : if (C_PRMRY_IS_ACLK_ASYNC = 0) generate
begin
      clock_splt <= m_axi_mm2s_aclk;

end generate CLOCKS_SYNC;

I_COMMAND_MM2S_SPLITTER : entity axi_dma_v7_1_8.axi_dma_cmd_split

 
     generic map (
               C_ADDR_WIDTH     => ADDR_WIDTH,
               C_INCLUDE_S2MM   => 0,
               C_DM_STATUS_WIDTH  => 8
             )
     port map (
           clock => clock_splt, --axi_sg_aclk,
           sgresetn  => m_axi_sg_aresetn,
           clock_sec => m_axi_mm2s_aclk, --axi_sg_aclk, 
           aresetn  => m_axi_mm2s_aresetn,

   -- MM2S command coming from MM2S_MNGR
           s_axis_cmd_tvalid => s_axis_mm2s_cmd_tvalid_split,
           s_axis_cmd_tready => s_axis_mm2s_cmd_tready_split, 
           s_axis_cmd_tdata  => s_axis_mm2s_cmd_tdata_split,

   -- MM2S split command to DM
           s_axis_cmd_tvalid_s => s_axis_mm2s_cmd_tvalid,
           s_axis_cmd_tready_s => s_axis_mm2s_cmd_tready,
           s_axis_cmd_tdata_s  => s_axis_mm2s_cmd_tdata,

           tvalid_from_datamover    => m_axis_mm2s_sts_tvalid_int, 
           status_in                => m_axis_mm2s_sts_tdata_int,
           tvalid_unsplit           => m_axis_mm2s_sts_tvalid,
           status_out               => m_axis_mm2s_sts_tdata,

           tlast_stream_data    => m_axis_mm2s_tlast_i_mcdma,
           tready_stream_data   => m_axis_mm2s_tready,
           tlast_unsplit        => m_axis_mm2s_tlast_i,
           tlast_unsplit_user   => m_axis_mm2s_tlast_i_user
          );
end generate MM2S_SPLIT;


MM2S_SPLIT_NOMCDMA : if (C_ENABLE_MULTI_CHANNEL = 0 and C_INCLUDE_MM2S = 1) generate
begin

      s_axis_mm2s_cmd_tvalid <= s_axis_mm2s_cmd_tvalid_split;
      s_axis_mm2s_cmd_tready_split <= s_axis_mm2s_cmd_tready;
      s_axis_mm2s_cmd_tdata <= s_axis_mm2s_cmd_tdata_split ((ADDR_WIDTH+CMD_BASE_WIDTH)-1 downto 0);

      m_axis_mm2s_sts_tvalid <= m_axis_mm2s_sts_tvalid_int;
      m_axis_mm2s_sts_tdata <= m_axis_mm2s_sts_tdata_int;
      m_axis_mm2s_tlast_i <= m_axis_mm2s_tlast_i_mcdma;

      m_axis_mm2s_tlast_i_user <= '0';

end generate MM2S_SPLIT_NOMCDMA;


S2MM_SPLIT : if (C_ENABLE_MULTI_CHANNEL = 1 and C_INCLUDE_S2MM = 1) generate
begin

CLOCKS_S2MM : if (C_PRMRY_IS_ACLK_ASYNC = 1) generate
begin
      clock_splt_s2mm <= axi_sg_aclk;

end generate CLOCKS_S2MM;


CLOCKS_SYNC_S2MM : if (C_PRMRY_IS_ACLK_ASYNC = 0) generate
begin
      clock_splt_s2mm <= m_axi_s2mm_aclk;

end generate CLOCKS_SYNC_S2MM;


I_COMMAND_S2MM_SPLITTER : entity axi_dma_v7_1_8.axi_dma_cmd_split 
     generic map (
               C_ADDR_WIDTH     => ADDR_WIDTH,
               C_INCLUDE_S2MM   => C_INCLUDE_S2MM,
               C_DM_STATUS_WIDTH  => DM_STATUS_WIDTH 
             )
     port map (
           clock => clock_splt_s2mm,
           sgresetn  => m_axi_sg_aresetn,
           clock_sec => m_axi_s2mm_aclk, --axi_sg_aclk, --m_axi_s2mm_aclk, 
           aresetn  => m_axi_s2mm_aresetn,

   -- S2MM command coming from S2MM_MNGR
           s_axis_cmd_tvalid => s_axis_s2mm_cmd_tvalid_split,
           s_axis_cmd_tready => s_axis_s2mm_cmd_tready_split, 
           s_axis_cmd_tdata  => s_axis_s2mm_cmd_tdata_split,

   -- S2MM split command to DM
           s_axis_cmd_tvalid_s => s_axis_s2mm_cmd_tvalid,
           s_axis_cmd_tready_s => s_axis_s2mm_cmd_tready,
           s_axis_cmd_tdata_s  => s_axis_s2mm_cmd_tdata,

           tvalid_from_datamover    => m_axis_s2mm_sts_tvalid_int, 
           status_in                => m_axis_s2mm_sts_tdata_int, 
           tvalid_unsplit           => m_axis_s2mm_sts_tvalid,
           status_out               => m_axis_s2mm_sts_tdata, 

           tlast_stream_data    => '0', 
           tready_stream_data    => '0', 
           tlast_unsplit           => open,
           tlast_unsplit_user           => open
          );

end generate S2MM_SPLIT;

S2MM_SPLIT_NOMCDMA : if (C_ENABLE_MULTI_CHANNEL = 0 and C_INCLUDE_S2MM = 1) generate
begin

      s_axis_s2mm_cmd_tvalid <= s_axis_s2mm_cmd_tvalid_split;
      s_axis_s2mm_cmd_tready_split <= s_axis_s2mm_cmd_tready;
      s_axis_s2mm_cmd_tdata <= s_axis_s2mm_cmd_tdata_split ((ADDR_WIDTH+CMD_BASE_WIDTH)-1 downto 0);

      m_axis_s2mm_sts_tvalid <= m_axis_s2mm_sts_tvalid_int;   
      m_axis_s2mm_sts_tdata <= m_axis_s2mm_sts_tdata_int;   

end generate S2MM_SPLIT_NOMCDMA;




-------------------------------------------------------------------------------
-- Primary MM2S and S2MM DataMover
-------------------------------------------------------------------------------
I_PRMRY_DATAMOVER : entity axi_datamover_v5_1_9.axi_datamover
    generic map(
        C_INCLUDE_MM2S              => MM2S_AXI_FULL_MODE,
        C_M_AXI_MM2S_ADDR_WIDTH     => ADDR_WIDTH,
        C_M_AXI_MM2S_DATA_WIDTH     => C_M_AXI_MM2S_DATA_WIDTH,
        C_M_AXIS_MM2S_TDATA_WIDTH   => C_M_AXIS_MM2S_TDATA_WIDTH,
        C_INCLUDE_MM2S_STSFIFO      => DM_INCLUDE_STS_FIFO,
        C_MM2S_STSCMD_FIFO_DEPTH    => DM_CMDSTS_FIFO_DEPTH_1,
        C_MM2S_STSCMD_IS_ASYNC      => C_PRMRY_IS_ACLK_ASYNC,
        C_INCLUDE_MM2S_DRE          => C_INCLUDE_MM2S_DRE,
        C_MM2S_BURST_SIZE           => C_MM2S_BURST_SIZE,
        C_MM2S_BTT_USED             => DM_BTT_LENGTH_WIDTH,
        C_MM2S_ADDR_PIPE_DEPTH      => DM_ADDR_PIPE_DEPTH,
        C_MM2S_INCLUDE_SF           => DM_MM2S_INCLUDE_SF,

        C_ENABLE_CACHE_USER         => C_ENABLE_MULTI_CHANNEL,
        C_ENABLE_SKID_BUF           => skid_enable, --"11111",
        C_MICRO_DMA                 => C_MICRO_DMA,
        C_CMD_WIDTH                 => CMD_WIDTH,

        C_INCLUDE_S2MM              => S2MM_AXI_FULL_MODE,
        C_M_AXI_S2MM_ADDR_WIDTH     => ADDR_WIDTH,
        C_M_AXI_S2MM_DATA_WIDTH     => C_M_AXI_S2MM_DATA_WIDTH,
        C_S_AXIS_S2MM_TDATA_WIDTH   => C_S_AXIS_S2MM_TDATA_WIDTH,
        C_INCLUDE_S2MM_STSFIFO      => DM_INCLUDE_STS_FIFO,
        C_S2MM_STSCMD_FIFO_DEPTH    => DM_CMDSTS_FIFO_DEPTH_1,
        C_S2MM_STSCMD_IS_ASYNC      => C_PRMRY_IS_ACLK_ASYNC,
        C_INCLUDE_S2MM_DRE          => C_INCLUDE_S2MM_DRE,
        C_S2MM_BURST_SIZE           => C_S2MM_BURST_SIZE,
        C_S2MM_BTT_USED             => DM_BTT_LENGTH_WIDTH,
        C_S2MM_SUPPORT_INDET_BTT    => DM_SUPPORT_INDET_BTT,
        C_S2MM_ADDR_PIPE_DEPTH      => DM_ADDR_PIPE_DEPTH,
        C_S2MM_INCLUDE_SF           => DM_S2MM_INCLUDE_SF,
        C_FAMILY                    => C_FAMILY
    )
    port map(
        -- MM2S Primary Clock / Reset input
        m_axi_mm2s_aclk             => m_axi_mm2s_aclk                      ,
        m_axi_mm2s_aresetn          => m_axi_mm2s_aresetn                   ,
    
        mm2s_halt                   => mm2s_halt                            ,
        mm2s_halt_cmplt             => mm2s_halt_cmplt                      ,
        mm2s_err                    => mm2s_err                             ,
        mm2s_allow_addr_req         => ALWAYS_ALLOW                         ,
        mm2s_addr_req_posted        => open                                 ,
        mm2s_rd_xfer_cmplt          => open                                 ,
   
        -- Memory Map to Stream Command FIFO and Status FIFO I/O --------------
        m_axis_mm2s_cmdsts_aclk     => axi_sg_aclk                          ,
        m_axis_mm2s_cmdsts_aresetn  => dm_mm2s_scndry_resetn                ,

        -- User Command Interface Ports (AXI Stream)
        s_axis_mm2s_cmd_tvalid      => s_axis_mm2s_cmd_tvalid               ,
        s_axis_mm2s_cmd_tready      => s_axis_mm2s_cmd_tready               ,
        s_axis_mm2s_cmd_tdata       => s_axis_mm2s_cmd_tdata 
                                        (((8*C_ENABLE_MULTI_CHANNEL)+
                                           ADDR_WIDTH+
                                           CMD_BASE_WIDTH)-1 downto 0)         ,

        -- User Status Interface Ports (AXI Stream)
        m_axis_mm2s_sts_tvalid      => m_axis_mm2s_sts_tvalid_int               ,
        m_axis_mm2s_sts_tready      => m_axis_mm2s_sts_tready               ,
        m_axis_mm2s_sts_tdata       => m_axis_mm2s_sts_tdata_int                ,
        m_axis_mm2s_sts_tkeep       => m_axis_mm2s_sts_tkeep                ,
        m_axis_mm2s_sts_tlast       => open                                 ,

        -- MM2S AXI Address Channel I/O  --------------------------------------
        m_axi_mm2s_arid             => open                                 ,
        m_axi_mm2s_araddr           => m_axi_mm2s_araddr_internal                    ,
        m_axi_mm2s_arlen            => m_axi_mm2s_arlen                     ,
        m_axi_mm2s_arsize           => m_axi_mm2s_arsize                    ,
        m_axi_mm2s_arburst          => m_axi_mm2s_arburst                   ,
        m_axi_mm2s_arprot           => m_axi_mm2s_arprot                    ,
        m_axi_mm2s_arcache          => m_axi_mm2s_arcache                   ,
        m_axi_mm2s_aruser           => m_axi_mm2s_aruser                   ,
        m_axi_mm2s_arvalid          => m_axi_mm2s_arvalid                   ,
        m_axi_mm2s_arready          => m_axi_mm2s_arready                   ,

        -- MM2S AXI MMap Read Data Channel I/O  -------------------------------
        m_axi_mm2s_rdata            => m_axi_mm2s_rdata                     ,
        m_axi_mm2s_rresp            => m_axi_mm2s_rresp                     ,
        m_axi_mm2s_rlast            => m_axi_mm2s_rlast                     ,
        m_axi_mm2s_rvalid           => m_axi_mm2s_rvalid                    ,
        m_axi_mm2s_rready           => m_axi_mm2s_rready                    ,

        -- MM2S AXI Master Stream Channel I/O  --------------------------------
        m_axis_mm2s_tdata           => m_axis_mm2s_tdata                    ,
        m_axis_mm2s_tkeep           => m_axis_mm2s_tkeep                    ,
        m_axis_mm2s_tlast           => m_axis_mm2s_tlast_i_mcdma                  ,
        m_axis_mm2s_tvalid          => m_axis_mm2s_tvalid_i                 ,
        m_axis_mm2s_tready          => m_axis_mm2s_tready                   ,

        -- Testing Support I/O
        mm2s_dbg_sel                => (others => '0')                      ,
        mm2s_dbg_data               => open                                 ,

        -- S2MM Primary Clock/Reset input
        m_axi_s2mm_aclk             => m_axi_s2mm_aclk                      ,
        m_axi_s2mm_aresetn          => m_axi_s2mm_aresetn                   ,
        s2mm_halt                   => s2mm_halt                            ,
        s2mm_halt_cmplt             => s2mm_halt_cmplt                      ,
        s2mm_err                    => s2mm_err                             ,
        s2mm_allow_addr_req         => ALWAYS_ALLOW                         ,
        s2mm_addr_req_posted        => open                                 ,
        s2mm_wr_xfer_cmplt          => open                                 ,
        s2mm_ld_nxt_len             => open                                 ,
        s2mm_wr_len                 => open                                 ,

        -- Stream to Memory Map Command FIFO and Status FIFO I/O --------------
        m_axis_s2mm_cmdsts_awclk    => axi_sg_aclk                          ,
        m_axis_s2mm_cmdsts_aresetn  => dm_s2mm_scndry_resetn                ,

        -- User Command Interface Ports (AXI Stream)
        s_axis_s2mm_cmd_tvalid      => s_axis_s2mm_cmd_tvalid               ,
        s_axis_s2mm_cmd_tready      => s_axis_s2mm_cmd_tready               ,
        s_axis_s2mm_cmd_tdata       => s_axis_s2mm_cmd_tdata (
                                         ((8*C_ENABLE_MULTI_CHANNEL)+
                                           ADDR_WIDTH+
                                           CMD_BASE_WIDTH)-1 downto 0)      ,

        -- User Status Interface Ports (AXI Stream)
        m_axis_s2mm_sts_tvalid      => m_axis_s2mm_sts_tvalid_int           ,
        m_axis_s2mm_sts_tready      => m_axis_s2mm_sts_tready               ,
        m_axis_s2mm_sts_tdata       => m_axis_s2mm_sts_tdata_int            ,
        m_axis_s2mm_sts_tkeep       => m_axis_s2mm_sts_tkeep                ,
        m_axis_s2mm_sts_tlast       => open                                 ,

        -- S2MM AXI Address Channel I/O  --------------------------------------
        m_axi_s2mm_awid             => open                                 ,
        m_axi_s2mm_awaddr           => m_axi_s2mm_awaddr_internal                    ,
        m_axi_s2mm_awlen            => m_axi_s2mm_awlen                     ,
        m_axi_s2mm_awsize           => m_axi_s2mm_awsize                    ,
        m_axi_s2mm_awburst          => m_axi_s2mm_awburst                   ,
        m_axi_s2mm_awprot           => m_axi_s2mm_awprot                    ,
        m_axi_s2mm_awcache          => m_axi_s2mm_awcache                   ,
        m_axi_s2mm_awuser           => m_axi_s2mm_awuser                    ,
        m_axi_s2mm_awvalid          => m_axi_s2mm_awvalid                   ,
        m_axi_s2mm_awready          => m_axi_s2mm_awready                   ,

        -- S2MM AXI MMap Write Data Channel I/O  ------------------------------
        m_axi_s2mm_wdata            => m_axi_s2mm_wdata                     ,
        m_axi_s2mm_wstrb            => m_axi_s2mm_wstrb                     ,
        m_axi_s2mm_wlast            => m_axi_s2mm_wlast                     ,
        m_axi_s2mm_wvalid           => m_axi_s2mm_wvalid                    ,
        m_axi_s2mm_wready           => m_axi_s2mm_wready                    ,

        -- S2MM AXI MMap Write response Channel I/O  --------------------------
        m_axi_s2mm_bresp            => m_axi_s2mm_bresp                     ,
        m_axi_s2mm_bvalid           => m_axi_s2mm_bvalid                    ,
        m_axi_s2mm_bready           => m_axi_s2mm_bready                    ,

        -- S2MM AXI Slave Stream Channel I/O  ---------------------------------
        s_axis_s2mm_tdata           => s_axis_s2mm_tdata                    ,
        s_axis_s2mm_tkeep           => s_axis_s2mm_tkeep                    ,
        s_axis_s2mm_tlast           => s_axis_s2mm_tlast                    , 
        s_axis_s2mm_tvalid          => s_axis_s2mm_tvalid                   , 
        s_axis_s2mm_tready          => s_axis_s2mm_tready_i                 ,

        -- Testing Support I/O
        s2mm_dbg_sel                  => (others => '0')                    ,
        s2mm_dbg_data                 => open
    );




end implementation;
