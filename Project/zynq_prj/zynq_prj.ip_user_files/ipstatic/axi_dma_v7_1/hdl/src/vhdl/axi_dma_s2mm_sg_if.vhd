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
-- Filename:          axi_dma_s2mm_sg_if.vhd
-- Description: This entity is the S2MM Scatter Gather Interface for Descriptor
--              Fetches and Updates.
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

library lib_cdc_v1_0_2;
library lib_srl_fifo_v1_0_2;
use lib_srl_fifo_v1_0_2.srl_fifo_f;

-------------------------------------------------------------------------------
entity  axi_dma_s2mm_sg_if is
    generic (
        C_PRMRY_IS_ACLK_ASYNC        : integer range 0 to 1          := 0       ;
            -- Primary MM2S/S2MM sync/async mode
            -- 0 = synchronous mode     - all clocks are synchronous
            -- 1 = asynchronous mode    - Any one of the 4 clock inputs is not
            --                            synchronous to the other
        -----------------------------------------------------------------------
        -- Scatter Gather Parameters
        -----------------------------------------------------------------------
        C_SG_INCLUDE_STSCNTRL_STRM      : integer range 0 to 1          := 1    ;
            -- Include or Exclude AXI Status and AXI Control Streams
            -- 0 = Exclude Status and Control Streams
            -- 1 = Include Status and Control Streams

        C_SG_INCLUDE_DESC_QUEUE         : integer range 0 to 1          := 0    ;
            -- Include or Exclude Scatter Gather Descriptor Queuing
            -- 0 = Exclude SG Descriptor Queuing
            -- 1 = Include SG Descriptor Queuing

        C_SG_USE_STSAPP_LENGTH      : integer range 0 to 1          := 1;
            -- Enable or Disable use of Status Stream Rx Length.  Only valid
            -- if C_SG_INCLUDE_STSCNTRL_STRM = 1
            -- 0 = Don't use Rx Length
            -- 1 = Use Rx Length

        C_SG_LENGTH_WIDTH               : integer range 8 to 23         := 14   ;
            -- Descriptor Buffer Length, Transferred Bytes, and Status Stream
            -- Rx Length Width.  Indicates the least significant valid bits of
            -- descriptor buffer length, transferred bytes, or Rx Length value
            -- in the status word coincident with tlast.

        C_M_AXIS_SG_TDATA_WIDTH          : integer range 32 to 32        := 32  ;
            -- AXI Master Stream in for descriptor fetch

        C_S_AXIS_UPDPTR_TDATA_WIDTH : integer range 32 to 32            := 32   ;
            -- 32 Update Status Bits

        C_S_AXIS_UPDSTS_TDATA_WIDTH : integer range 33 to 33            := 33   ;
            -- 1 IOC bit + 32 Update Status Bits

        C_M_AXI_SG_ADDR_WIDTH           : integer range 32 to 64        := 32   ;
            -- Master AXI Memory Map Data Width for Scatter Gather R/W Port

        C_M_AXI_S2MM_ADDR_WIDTH         : integer range 32 to 64        := 32   ;
            -- Master AXI Memory Map Address Width for S2MM Write Port

        C_S_AXIS_S2MM_STS_TDATA_WIDTH   : integer range 32 to 32        := 32   ;
            -- Slave AXI Status Stream Data Width
        C_NUM_S2MM_CHANNELS             : integer range 1 to 16         := 1 ;

        C_ENABLE_MULTI_CHANNEL                 : integer range 0 to 1          := 0;

        C_MICRO_DMA                     : integer range 0 to 1          := 0;

        C_FAMILY                        : string                        := "virtex5"
            -- Target FPGA Device Family
    );
    port (

        m_axi_sg_aclk               : in  std_logic                         ;                     --
        m_axi_sg_aresetn            : in  std_logic                         ;                     --

        s2mm_desc_info_in              : in std_logic_vector (13 downto 0)     ;
                                                                                                  --
        -- SG S2MM Descriptor Fetch AXI Stream In                                                 --
        m_axis_s2mm_ftch_tdata      : in  std_logic_vector                                        --
                                        (C_M_AXIS_SG_TDATA_WIDTH-1 downto 0);                     --
        m_axis_s2mm_ftch_tvalid     : in  std_logic                         ;                     --
        m_axis_s2mm_ftch_tready     : out std_logic                         ;                     --
        m_axis_s2mm_ftch_tlast      : in  std_logic                         ;                     --

        m_axis_s2mm_ftch_tdata_new      : in  std_logic_vector                                        --
                                        (96+31*0+(0+2)*(C_M_AXI_SG_ADDR_WIDTH-32) downto 0);                     --
        m_axis_s2mm_ftch_tdata_mcdma_new      : in  std_logic_vector                                        --
                                        (63 downto 0);                     --
        m_axis_s2mm_ftch_tdata_mcdma_nxt      : in  std_logic_vector                                        --
                                        (C_M_AXI_SG_ADDR_WIDTH-1 downto 0);                     --
        m_axis_s2mm_ftch_tvalid_new     : in  std_logic                         ;                     --
        m_axis_ftch2_desc_available  : in std_logic;
                                                                                                  --
                                                                                                  --
        -- SG S2MM Descriptor Update AXI Stream Out                                               --
        s_axis_s2mm_updtptr_tdata   : out std_logic_vector                                        --
                                     (C_M_AXI_SG_ADDR_WIDTH-1 downto 0) ;                   --
        s_axis_s2mm_updtptr_tvalid  : out std_logic                         ;                     --
        s_axis_s2mm_updtptr_tready  : in  std_logic                         ;                     --
        s_axis_s2mm_updtptr_tlast   : out std_logic                         ;                     --
                                                                                                  --
        s_axis_s2mm_updtsts_tdata   : out std_logic_vector                                        --
                                     (C_S_AXIS_UPDSTS_TDATA_WIDTH-1 downto 0)  ;                  --
        s_axis_s2mm_updtsts_tvalid  : out std_logic                         ;                     --
        s_axis_s2mm_updtsts_tready  : in  std_logic                         ;                     --
        s_axis_s2mm_updtsts_tlast   : out std_logic                         ;                     --
                                                                                                  --
        -- S2MM Descriptor Fetch Request (from s2mm_sm)                                           --
        desc_available              : out std_logic                         ;                     --
        desc_fetch_req              : in  std_logic                         ;                     --
        updt_pending                : out std_logic                         ;
        desc_fetch_done             : out std_logic                         ;                     --
                                                                                                  --
        -- S2MM Descriptor Update Request (from s2mm_sm)                                          --
        desc_update_done            : out std_logic                         ;                     --
        s2mm_sts_received_clr       : out std_logic                         ;                     --
        s2mm_sts_received           : in  std_logic                         ;                     --
                                                                                                  --
        -- Scatter Gather Update Status                                                           --
        s2mm_done                   : in  std_logic                         ;                     --
        s2mm_interr                 : in  std_logic                         ;                     --
        s2mm_slverr                 : in  std_logic                         ;                     --
        s2mm_decerr                 : in  std_logic                         ;                     --
        s2mm_tag                    : in  std_logic_vector(3 downto 0)      ;                     --
        s2mm_brcvd                  : in  std_logic_vector                                        --
                                        (C_SG_LENGTH_WIDTH-1 downto 0)      ;                     --
        s2mm_eof_set                : in  std_logic                         ;                     --
        s2mm_packet_eof             : in  std_logic                         ;                     --
        s2mm_halt                   : in  std_logic                         ;                     --
                                                                                                  --
        -- S2MM Status Stream Interface                                                           --
        stsstrm_fifo_rden           : out std_logic                         ;                     --
        stsstrm_fifo_empty          : in  std_logic                         ;                     --
        stsstrm_fifo_dout           : in  std_logic_vector                                        --
                                        (C_S_AXIS_S2MM_STS_TDATA_WIDTH downto 0);                 --
                                                                                                  --
        -- DataMover Command                                                                      --
        s2mm_cmnd_wr                : in  std_logic                         ;                     --
        s2mm_cmnd_data              : in  std_logic_vector                                        --
                                        (((1+C_ENABLE_MULTI_CHANNEL)*C_M_AXI_S2MM_ADDR_WIDTH+CMD_BASE_WIDTH)-1 downto 0);    --
                                                                                                  --
        -- S2MM Descriptor Field Output                                                           --
        s2mm_new_curdesc            : out std_logic_vector                                        --
                                        (C_M_AXI_SG_ADDR_WIDTH-1 downto 0)  ;                     --
        s2mm_new_curdesc_wren       : out std_logic                         ;                     --
                                                                                                  --
        s2mm_desc_info          : out std_logic_vector                                        --
                                        (31 downto 0);                     --
        s2mm_desc_baddress          : out std_logic_vector                                        --
                                        (C_M_AXI_S2MM_ADDR_WIDTH-1 downto 0);                     --
        s2mm_desc_blength           : out std_logic_vector                                        --
                                        (BUFFER_LENGTH_WIDTH-1 downto 0)  ;                       --
        s2mm_desc_blength_v           : out std_logic_vector                                        --
                                        (BUFFER_LENGTH_WIDTH-1 downto 0)  ;                       --
        s2mm_desc_blength_s           : out std_logic_vector                                        --
                                        (BUFFER_LENGTH_WIDTH-1 downto 0)  ;                       --
        s2mm_desc_cmplt             : out std_logic                         ;                     --
        s2mm_eof_micro              : out std_logic ;
        s2mm_sof_micro              : out std_logic ;
        s2mm_desc_app0              : out std_logic_vector                                        --
                                        (C_M_AXIS_SG_TDATA_WIDTH-1 downto 0)  ;                   --
        s2mm_desc_app1              : out std_logic_vector                                        --
                                        (C_M_AXIS_SG_TDATA_WIDTH-1 downto 0)  ;                   --
        s2mm_desc_app2              : out std_logic_vector                                        --
                                        (C_M_AXIS_SG_TDATA_WIDTH-1 downto 0)  ;                   --
        s2mm_desc_app3              : out std_logic_vector                                        --
                                        (C_M_AXIS_SG_TDATA_WIDTH-1 downto 0)  ;                   --
        s2mm_desc_app4              : out std_logic_vector                                        --
                                        (C_M_AXIS_SG_TDATA_WIDTH-1 downto 0)                      --
    );

end axi_dma_s2mm_sg_if;

-------------------------------------------------------------------------------
-- Architecture
-------------------------------------------------------------------------------
architecture implementation of axi_dma_s2mm_sg_if is
  attribute DowngradeIPIdentifiedWarnings: string;
  attribute DowngradeIPIdentifiedWarnings of implementation : architecture is "yes";

  ATTRIBUTE async_reg                      : STRING;

-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------

-- No Functions Declared

-------------------------------------------------------------------------------
-- Constants Declarations
-------------------------------------------------------------------------------
-- Status reserved bits
constant RESERVED_STS           : std_logic_vector(2 downto 0)
                                    := (others => '0');
-- Zero value constant
constant ZERO_VALUE             : std_logic_vector(31 downto 0)
                                    := (others => '0');
-- Zero length constant
constant ZERO_LENGTH            : std_logic_vector(C_SG_LENGTH_WIDTH-1 downto 0)
                                    := (others => '0');

-------------------------------------------------------------------------------
-- Signal / Type Declarations
-------------------------------------------------------------------------------
signal ftch_shftenbl            : std_logic := '0';

-- fetch descriptor holding registers
signal desc_reg12               : std_logic_vector(C_M_AXIS_SG_TDATA_WIDTH - 1 downto 0) := (others => '0');
signal desc_reg11               : std_logic_vector(C_M_AXIS_SG_TDATA_WIDTH - 1 downto 0) := (others => '0');
signal desc_reg10               : std_logic_vector(C_M_AXIS_SG_TDATA_WIDTH - 1 downto 0) := (others => '0');
signal desc_reg9                : std_logic_vector(C_M_AXIS_SG_TDATA_WIDTH - 1 downto 0) := (others => '0');
signal desc_reg8                : std_logic_vector(C_M_AXIS_SG_TDATA_WIDTH - 1 downto 0) := (others => '0');
signal desc_reg7                : std_logic_vector(C_M_AXIS_SG_TDATA_WIDTH - 1 downto 0) := (others => '0');
signal desc_reg6                : std_logic_vector(C_M_AXIS_SG_TDATA_WIDTH - 1 downto 0) := (others => '0');
signal desc_reg5                : std_logic_vector(C_M_AXIS_SG_TDATA_WIDTH - 1 downto 0) := (others => '0');
signal desc_reg4                : std_logic_vector(C_M_AXIS_SG_TDATA_WIDTH - 1 downto 0) := (others => '0');
signal desc_reg3                : std_logic_vector(C_M_AXIS_SG_TDATA_WIDTH - 1 downto 0) := (others => '0');
signal desc_reg2                : std_logic_vector(C_M_AXIS_SG_TDATA_WIDTH - 1 downto 0) := (others => '0');
signal desc_reg1                : std_logic_vector(C_M_AXIS_SG_TDATA_WIDTH - 1 downto 0) := (others => '0');
signal desc_reg0                : std_logic_vector(C_M_AXIS_SG_TDATA_WIDTH - 1 downto 0) := (others => '0');

signal s2mm_desc_curdesc_lsb    : std_logic_vector(C_M_AXIS_SG_TDATA_WIDTH - 1 downto 0) := (others => '0');
signal s2mm_desc_curdesc_lsb_nxt    : std_logic_vector(C_M_AXIS_SG_TDATA_WIDTH - 1 downto 0) := (others => '0');
signal s2mm_desc_curdesc_msb    : std_logic_vector(C_M_AXIS_SG_TDATA_WIDTH - 1 downto 0) := (others => '0');
signal s2mm_desc_curdesc_msb_nxt    : std_logic_vector(C_M_AXIS_SG_TDATA_WIDTH - 1 downto 0) := (others => '0');
signal s2mm_desc_baddr_lsb      : std_logic_vector(C_M_AXIS_SG_TDATA_WIDTH - 1 downto 0) := (others => '0');
signal s2mm_desc_baddr_msb      : std_logic_vector(C_M_AXIS_SG_TDATA_WIDTH - 1 downto 0) := (others => '0');
signal s2mm_pending_update      : std_logic := '0';
signal s2mm_new_curdesc_wren_i  : std_logic := '0';
signal s2mm_ioc                 : std_logic := '0';
signal s2mm_pending_pntr_updt   : std_logic := '0';

-- Descriptor Update Signals
signal s2mm_complete            : std_logic := '0';
signal s2mm_xferd_bytes         : std_logic_vector(BUFFER_LENGTH_WIDTH-1 downto 0)      := (others => '0');
signal s2mm_desc_blength_i      : std_logic_vector(BUFFER_LENGTH_WIDTH - 1 downto 0)    := (others => '0');
signal s2mm_desc_blength_v_i      : std_logic_vector(BUFFER_LENGTH_WIDTH - 1 downto 0)    := (others => '0');
signal s2mm_desc_blength_s_i      : std_logic_vector(BUFFER_LENGTH_WIDTH - 1 downto 0)    := (others => '0');

-- Signals for pointer support
-- Make 1 bit wider to allow tagging of LAST for use in generating tlast
signal updt_desc_reg0           : std_logic_vector(C_M_AXI_SG_ADDR_WIDTH-1 downto 0)     := (others => '0');
signal updt_desc_reg1           : std_logic_vector(C_S_AXIS_UPDPTR_TDATA_WIDTH downto 0)     := (others => '0');

signal updt_shftenbl            : std_logic := '0';

signal updtptr_tvalid           : std_logic := '0';
signal updtptr_tlast            : std_logic := '0';
signal updtptr_tdata            : std_logic_vector(C_M_AXI_SG_ADDR_WIDTH-1 downto 0) := (others => '0');

-- Signals for Status Stream Support
signal updt_desc_sts            : std_logic_vector(C_S_AXIS_UPDSTS_TDATA_WIDTH downto 0)     := (others => '0');
signal updt_desc_reg3           : std_logic_vector(C_S_AXIS_UPDSTS_TDATA_WIDTH downto 0)     := (others => '0');
signal updt_zero_reg3           : std_logic_vector(C_S_AXIS_UPDSTS_TDATA_WIDTH downto 0)     := (others => '0');
signal updt_zero_reg4           : std_logic_vector(C_S_AXIS_UPDSTS_TDATA_WIDTH downto 0)     := (others => '0');
signal updt_zero_reg5           : std_logic_vector(C_S_AXIS_UPDSTS_TDATA_WIDTH downto 0)     := (others => '0');
signal updt_zero_reg6           : std_logic_vector(C_S_AXIS_UPDSTS_TDATA_WIDTH downto 0)     := (others => '0');
signal updt_zero_reg7           : std_logic_vector(C_S_AXIS_UPDSTS_TDATA_WIDTH downto 0)     := (others => '0');

signal writing_app_fields       : std_logic := '0';
signal stsstrm_fifo_rden_i      : std_logic := '0';

signal sts_shftenbl             : std_logic := '0';

signal sts_received             : std_logic := '0';
signal sts_received_d1          : std_logic := '0';
signal sts_received_re          : std_logic := '0';

-- Queued Update signals
signal updt_data_clr            : std_logic := '0';
signal updt_sts_clr             : std_logic := '0';
signal updt_data                : std_logic := '0';
signal updt_sts                 : std_logic := '0';

signal ioc_tag                  : std_logic := '0';
signal s2mm_sof_set             : std_logic := '0';
signal s2mm_in_progress         : std_logic := '0';
signal eof_received             : std_logic := '0';
signal sof_received             : std_logic := '0';

signal updtsts_tvalid           : std_logic := '0';
signal updtsts_tlast            : std_logic := '0';
signal updtsts_tdata            : std_logic_vector(C_S_AXIS_UPDSTS_TDATA_WIDTH-1 downto 0) := (others => '0');

signal s2mm_halt_d1_cdc_tig             : std_logic := '0';
signal s2mm_halt_cdc_d2             : std_logic := '0';
signal s2mm_halt_d2             : std_logic := '0';
  --ATTRIBUTE async_reg OF s2mm_halt_d1_cdc_tig  : SIGNAL IS "true";
  --ATTRIBUTE async_reg OF s2mm_halt_cdc_d2  : SIGNAL IS "true";

signal desc_fetch_done_i        : std_logic;

-------------------------------------------------------------------------------
-- Begin architecture logic
-------------------------------------------------------------------------------
begin


-- Drive buffer length out
s2mm_desc_blength <= s2mm_desc_blength_i;
s2mm_desc_blength_v <= s2mm_desc_blength_v_i;
s2mm_desc_blength_s <= s2mm_desc_blength_s_i;

updt_pending <= s2mm_pending_update;
-- Drive ready if descriptor fetch request is being made
m_axis_s2mm_ftch_tready     <= desc_fetch_req                   -- Request descriptor fetch
                                and not s2mm_pending_update;    -- No pending pointer updates


                            
desc_fetch_done <= desc_fetch_done_i;

-- Shift in data from SG engine if tvalid and fetch request
ftch_shftenbl           <= m_axis_s2mm_ftch_tvalid_new
                            and desc_fetch_req
                            and not s2mm_pending_update;

-- Passed curdes write out to register module
s2mm_new_curdesc_wren   <= s2mm_new_curdesc_wren_i;

-- tvalid asserted means descriptor availble
desc_available          <= m_axis_ftch2_desc_available; --m_axis_s2mm_ftch_tvalid_new;


--***************************************************************************--
--** Register DataMover Halt to secondary if needed
--***************************************************************************--
GEN_FOR_ASYNC : if C_PRMRY_IS_ACLK_ASYNC = 1 generate
begin
    -- Double register to secondary clock domain.  This is sufficient
    -- because halt will remain asserted until halt_cmplt detected in
    -- reset module in secondary clock domain.
REG_TO_SECONDARY : entity  lib_cdc_v1_0_2.cdc_sync
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
        prmry_in                   => s2mm_halt,
        prmry_vect_in              => (others => '0'),

        scndry_aclk                => m_axi_sg_aclk,
        scndry_resetn              => '0',
        scndry_out                 => s2mm_halt_cdc_d2,
        scndry_vect_out            => open
    );

--    REG_TO_SECONDARY : process(m_axi_sg_aclk)
--        begin
--            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
--            --    if(m_axi_sg_aresetn = '0')then
--            --        s2mm_halt_d1_cdc_tig <= '0';
--            --        s2mm_halt_d2 <= '0';
--            --    else
--                    s2mm_halt_d1_cdc_tig <= s2mm_halt;
--                    s2mm_halt_cdc_d2 <= s2mm_halt_d1_cdc_tig;
--          --      end if;
--            end if;
--        end process REG_TO_SECONDARY;

                    s2mm_halt_d2 <= s2mm_halt_cdc_d2;

end generate GEN_FOR_ASYNC;

GEN_FOR_SYNC : if C_PRMRY_IS_ACLK_ASYNC = 0 generate
begin
    -- No clock crossing required therefore simple pass through
    s2mm_halt_d2 <= s2mm_halt;

end generate GEN_FOR_SYNC;


--***************************************************************************--
--**                        Descriptor Fetch Logic                         **--
--***************************************************************************--


    s2mm_desc_curdesc_lsb   <= desc_reg0;
--s2mm_desc_curdesc_lsb_nxt   <= desc_reg2;
--s2mm_desc_curdesc_msb_nxt   <= desc_reg3;
    s2mm_desc_baddr_lsb     <= desc_reg4;




    GEN_NO_MCDMA : if C_ENABLE_MULTI_CHANNEL = 0 generate


            desc_fetch_done_i         <= m_axis_s2mm_ftch_tvalid_new; 
                            desc_reg0     <= m_axis_s2mm_ftch_tdata_new (96 downto 65); 
                            desc_reg4     <= m_axis_s2mm_ftch_tdata_new (31 downto 0);
                            desc_reg8     <= m_axis_s2mm_ftch_tdata_new (63 downto 32);
                            desc_reg9( DESC_STS_CMPLTD_BIT)     <= m_axis_s2mm_ftch_tdata_new (64);
                            desc_reg9(30 downto 0)     <= (others => '0');




       s2mm_desc_curdesc_lsb_nxt   <= desc_reg0;
    --   s2mm_desc_curdesc_msb_nxt   <= (others => '0'); --desc_reg1;
       s2mm_desc_info     <= (others => '0'); 
       -- desc 4 and desc 5 are reserved and thus don't care
       s2mm_sof_micro <= desc_reg8 (DESC_SOF_BIT);
       s2mm_eof_micro <= desc_reg8 (DESC_EOF_BIT);
       s2mm_desc_blength_i     <= desc_reg8(DESC_BLENGTH_MSB_BIT downto DESC_BLENGTH_LSB_BIT);
       s2mm_desc_blength_v_i     <= (others => '0'); 
       s2mm_desc_blength_s_i     <= (others => '0') ;


ADDR_64BIT : if C_M_AXI_SG_ADDR_WIDTH > 32 generate
begin

    s2mm_desc_baddr_msb   <= m_axis_s2mm_ftch_tdata_new (128 downto 97);
    s2mm_desc_curdesc_msb     <= m_axis_s2mm_ftch_tdata_new (160 downto 129);

end generate ADDR_64BIT;

ADDR_32BIT : if C_M_AXI_SG_ADDR_WIDTH = 32 generate
begin

    s2mm_desc_curdesc_msb   <= (others => '0');
    s2mm_desc_baddr_msb     <= (others => '0');

end generate ADDR_32BIT;



ADDR_64BIT_DMA : if C_M_AXI_SG_ADDR_WIDTH > 32 generate
begin

       s2mm_desc_curdesc_lsb_nxt   <= desc_reg0;
    s2mm_desc_curdesc_msb_nxt   <= m_axis_s2mm_ftch_tdata_new (160 downto 129);

end generate ADDR_64BIT_DMA;

ADDR_32BIT_DMA : if C_M_AXI_SG_ADDR_WIDTH = 32 generate
begin

       s2mm_desc_curdesc_lsb_nxt   <= desc_reg0;
       s2mm_desc_curdesc_msb_nxt   <= (others => '0');

end generate ADDR_32BIT_DMA;

    end generate GEN_NO_MCDMA;

    GEN_MCDMA : if C_ENABLE_MULTI_CHANNEL = 1 generate


                            desc_fetch_done_i         <= m_axis_s2mm_ftch_tvalid_new; --ftch_shftenbl;

                            desc_reg0     <= m_axis_s2mm_ftch_tdata_new (96 downto 65); --127 downto 96);
                            desc_reg4     <= m_axis_s2mm_ftch_tdata_new (31 downto 0);
                            desc_reg8     <= m_axis_s2mm_ftch_tdata_new (63 downto 32);
                            desc_reg9(DESC_STS_CMPLTD_BIT)     <= m_axis_s2mm_ftch_tdata_new (64); --95 downto 64);
                            desc_reg9(30 downto 0)     <= (others => '0');


                            desc_reg2     <= m_axis_s2mm_ftch_tdata_mcdma_nxt (31 downto 0);
                            desc_reg6     <= m_axis_s2mm_ftch_tdata_mcdma_new (31 downto 0);
                            desc_reg7     <= m_axis_s2mm_ftch_tdata_mcdma_new (63 downto 32);


       s2mm_desc_info     <= desc_reg6 (31 downto 24) & desc_reg9 (23 downto 0);
-- desc 4 and desc 5 are reserved and thus don't care
       s2mm_desc_blength_i     <= "0000000" & desc_reg8(15 downto 0);
       s2mm_desc_blength_v_i     <= "0000000000" & desc_reg7(31 downto 19); 
       s2mm_desc_blength_s_i     <= "0000000" & desc_reg7(15 downto 0);


ADDR_64BIT_1 : if C_M_AXI_SG_ADDR_WIDTH > 32 generate
begin

    s2mm_desc_curdesc_msb   <= m_axis_s2mm_ftch_tdata_new (128 downto 97);
    s2mm_desc_baddr_msb     <= m_axis_s2mm_ftch_tdata_new (160 downto 129);

end generate ADDR_64BIT_1;

ADDR_32BIT_1 : if C_M_AXI_SG_ADDR_WIDTH = 32 generate
begin

    s2mm_desc_curdesc_msb   <= (others => '0');
    s2mm_desc_baddr_msb     <= (others => '0');

end generate ADDR_32BIT_1;


ADDR_64BIT_MCDMA : if C_M_AXI_SG_ADDR_WIDTH > 32 generate
begin

       s2mm_desc_curdesc_lsb_nxt   <= desc_reg2;
       s2mm_desc_curdesc_msb_nxt   <= m_axis_s2mm_ftch_tdata_mcdma_nxt (63 downto 32);

end generate ADDR_64BIT_MCDMA;

ADDR_32BIT_MCDMA : if C_M_AXI_SG_ADDR_WIDTH = 32 generate
begin

       s2mm_desc_curdesc_lsb_nxt   <= desc_reg2;
       s2mm_desc_curdesc_msb_nxt   <= (others => '0');

end generate ADDR_32BIT_MCDMA;


    end generate GEN_MCDMA;

s2mm_desc_cmplt         <= desc_reg9(DESC_STS_CMPLTD_BIT);
s2mm_desc_app0          <= (others => '0');
s2mm_desc_app1          <= (others => '0');
s2mm_desc_app2          <= (others => '0');
s2mm_desc_app3          <= (others => '0');
s2mm_desc_app4          <= (others => '0');

-------------------------------------------------------------------------------
-- BUFFER ADDRESS
-------------------------------------------------------------------------------
-- If 64 bit addressing then concatinate msb to lsb
GEN_NEW_64BIT_BUFADDR : if C_M_AXI_S2MM_ADDR_WIDTH = 64 generate
    s2mm_desc_baddress <= s2mm_desc_baddr_msb & s2mm_desc_baddr_lsb;
--    s2mm_desc_baddr_msb     <= m_axis_s2mm_ftch_tdata_new (128 downto 97);
end generate GEN_NEW_64BIT_BUFADDR;

-- If 32 bit addressing then simply pass lsb out
GEN_NEW_32BIT_BUFADDR : if C_M_AXI_S2MM_ADDR_WIDTH = 32 generate
    s2mm_desc_baddress <= s2mm_desc_baddr_lsb;
end generate GEN_NEW_32BIT_BUFADDR;

-------------------------------------------------------------------------------
-- NEW CURRENT DESCRIPTOR
-------------------------------------------------------------------------------
-- If 64 bit addressing then concatinate msb to lsb
GEN_NEW_64BIT_CURDESC : if C_M_AXI_SG_ADDR_WIDTH = 64 generate
    s2mm_new_curdesc <= s2mm_desc_curdesc_msb_nxt & s2mm_desc_curdesc_lsb_nxt;
end generate GEN_NEW_64BIT_CURDESC;

-- If 32 bit addressing then simply pass lsb out
GEN_NEW_32BIT_CURDESC : if C_M_AXI_SG_ADDR_WIDTH = 32 generate
    s2mm_new_curdesc <= s2mm_desc_curdesc_lsb_nxt;
end generate GEN_NEW_32BIT_CURDESC;

                s2mm_new_curdesc_wren_i <= desc_fetch_done_i; --ftch_shftenbl;

--***************************************************************************--
--**                       Descriptor Update Logic                         **--
--***************************************************************************--
-- SOF Flagging logic for when descriptor queues are enabled in SG Engine
GEN_SOF_QUEUE_MODE : if C_SG_INCLUDE_DESC_QUEUE = 1 generate

-- SOF Queued one count value
constant ONE_COUNT          : std_logic_vector(2 downto 0) := "001";

signal incr_sof_count       : std_logic := '0';
signal decr_sof_count       : std_logic := '0';
signal sof_count            : std_logic_vector(2 downto 0) := (others => '0');
signal sof_received_set     : std_logic := '0';
signal sof_received_clr     : std_logic := '0';
signal cmd_wr_mask          : std_logic := '0';

begin

    -- Keep track of number of commands queued up in data mover to
    -- allow proper setting of SOF's and EOF's when associated
    -- descriptor is updated.
    REG_SOF_COUNT : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    sof_count <= (others => '0');
                elsif(incr_sof_count = '1')then
                    sof_count <= std_logic_vector(unsigned(sof_count(2 downto 0)) + 1);
                elsif(decr_sof_count = '1')then
                    sof_count <= std_logic_vector(unsigned(sof_count(2 downto 0)) - 1);
                end if;
            end if;
        end process REG_SOF_COUNT;

    -- Increment count on each command write that does NOT occur
    -- coincident with a status received
    incr_sof_count  <= s2mm_cmnd_wr and not sts_received_re;

    -- Decrement count on each status received that does NOT
    -- occur coincident with a command write
    decr_sof_count  <= sts_received_re and not s2mm_cmnd_wr;


    -- Drive sof and eof setting to interrupt module for delay interrupt
    --s2mm_packet_sof  <= s2mm_sof_set;
    REG_SOF_STATUS : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    sof_received <= '0';
                elsif(sof_received_set = '1')then
                    sof_received <= '1';
                elsif(sof_received_clr = '1')then
                    sof_received <= '0';
                end if;
            end if;
        end process REG_SOF_STATUS;

    -- SOF Received
    -- Case 1 (i.e. already running): EOF received therefore next has to be SOF
    -- Case 2 (i.e. initial command): No commands in queue (count=0) therefore this must be an SOF command
    sof_received_set <= '1' when (sts_received_re = '1'                 -- Status back from Datamover
                              and eof_received = '1')                   -- End of packet received
                                                                        -- OR...
                              or (s2mm_cmnd_wr = '1'                    -- Command written to datamover
                              and cmd_wr_mask = '0'                     -- Not inner-packet command
                              and sof_count = ZERO_VALUE(2 downto 0))   -- No Queued SOF cmnds
                   else '0';

    -- Done with SOF's
    -- Status received and EOF received flag not set
    -- Or status received and EOF received flag set and last SOF
    sof_received_clr <= '1' when (sts_received_re = '1' and eof_received = '0')
                              or (sts_received_re = '1' and eof_received = '1' and sof_count = ONE_COUNT)
                   else '0';

    -- Mask command writes if inner-packet command written.  An inner packet
    -- command is one where status if received and eof_received is not asserted.
    -- This mask is only used for when a cmd_wr occurs and sof_count is zero, meaning
    -- no commands happen to be queued in datamover.
    WR_MASK : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    cmd_wr_mask <= '0';
                -- received data mover status, mask if EOF not set
                -- clear mask if EOF set.
                elsif(sts_received_re = '1')then
                    cmd_wr_mask <= not eof_received;
                end if;
            end if;
        end process WR_MASK;

end generate GEN_SOF_QUEUE_MODE;

-- SOF Flagging logic for when descriptor queues are disabled in SG Engine
GEN_SOF_NO_QUEUE_MODE : if C_SG_INCLUDE_DESC_QUEUE = 0 generate
begin
    -----------------------------------------------------------------------
    -- Assert window around receive packet in order to properly set
    -- SOF and EOF bits in descriptor
    --
    -- SOF for S2MM determined by new command write to datamover, i.e.
    -- command write receive packet not already in progress.
    -----------------------------------------------------------------------
    RX_IN_PROG_PROCESS : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0' or s2mm_packet_eof = '1')then
                    s2mm_in_progress <= '0';
                    s2mm_sof_set     <= '0';
                elsif(s2mm_in_progress = '0' and s2mm_cmnd_wr = '1')then
                    s2mm_in_progress <= '1';
                    s2mm_sof_set     <= '1';
                else
                    s2mm_in_progress <= s2mm_in_progress;
                    s2mm_sof_set     <= '0';
                end if;
            end if;
        end process RX_IN_PROG_PROCESS;

    -- Drive sof and eof setting to interrupt module for delay interrupt
    --s2mm_packet_sof  <= s2mm_sof_set;
    REG_SOF_STATUS : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0' or sts_received_re = '1')then
                    sof_received <= '0';
                elsif(s2mm_sof_set = '1')then
                    sof_received <= '1';
                end if;
            end if;
        end process REG_SOF_STATUS;


end generate GEN_SOF_NO_QUEUE_MODE;

-- IOC and EOF bits in desc update both set via packet eof flag from
-- command/status interface.
eof_received <= s2mm_packet_eof;
s2mm_ioc     <= s2mm_packet_eof;


--***************************************************************************--
--**            Descriptor Update Logic                                    **--
--***************************************************************************--


--*****************************************************************************
--** Pointer Update Logic
--*****************************************************************************

    -----------------------------------------------------------------------
    -- Capture LSB cur descriptor on write for use on descriptor update.
    -- This will be the address the descriptor is updated to
    -----------------------------------------------------------------------
    UPDT_DESC_WRD0: process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    updt_desc_reg0 (31 downto 0) <= (others => '0');
                elsif(s2mm_new_curdesc_wren_i = '1')then

                    updt_desc_reg0 (31 downto 0) <= s2mm_desc_curdesc_lsb;


                end if;
            end if;
        end process UPDT_DESC_WRD0;

    ---------------------------------------------------------------------------
    -- Capture MSB cur descriptor on write for use on descriptor update.
    -- This will be the address the descriptor is updated to
    ---------------------------------------------------------------------------
PTR_64BIT_CURDESC : if C_M_AXI_SG_ADDR_WIDTH = 64 generate
begin
    UPDT_DESC_WRD1: process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    updt_desc_reg0 (C_M_AXI_SG_ADDR_WIDTH-1 downto 32) <= (others => '0');
                elsif(s2mm_new_curdesc_wren_i = '1')then
                    updt_desc_reg0 (C_M_AXI_SG_ADDR_WIDTH-1 downto 32) <= s2mm_desc_curdesc_msb;

                end if;
            end if;
        end process UPDT_DESC_WRD1;
end generate PTR_64BIT_CURDESC;

    -- Shift in pointer to SG engine if tvalid, tready, and not on last word
    updt_shftenbl <=  updt_data and updtptr_tvalid and s_axis_s2mm_updtptr_tready;

    -- Update data done when updating data and tlast received and target
    -- (i.e. SG Engine) is ready
    updt_data_clr <= '1' when updtptr_tvalid = '1'
                          and updtptr_tlast = '1'
                          and s_axis_s2mm_updtptr_tready = '1'
                else '0';

    ---------------------------------------------------------------------------
    -- When desc data ready for update set and hold flag until
    -- data can be updated to queue.  Note it may
    -- be held off due to update of status
    ---------------------------------------------------------------------------
    UPDT_DATA_PROCESS : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0' or updt_data_clr = '1')then
                    updt_data   <= '0';
                -- clear flag when data update complete
        --        elsif(updt_data_clr = '1')then
        --            updt_data <= '0';
        --        -- set flag when desc fetched as indicated
        --        -- by curdesc wren
                elsif(s2mm_new_curdesc_wren_i = '1')then
                    updt_data <= '1';
                end if;
            end if;
        end process UPDT_DATA_PROCESS;

    updtptr_tvalid  <= updt_data;
    updtptr_tlast   <= DESC_LAST; --updt_desc_reg0(C_S_AXIS_UPDPTR_TDATA_WIDTH);
    updtptr_tdata   <= updt_desc_reg0;



    -- Pass out to sg engine
    s_axis_s2mm_updtptr_tdata    <= updtptr_tdata;
    s_axis_s2mm_updtptr_tlast    <= updtptr_tlast and updtptr_tvalid;
    s_axis_s2mm_updtptr_tvalid   <= updtptr_tvalid;


--*****************************************************************************
--** Status Update Logic - DESCRIPTOR QUEUES INCLUDED                        **
--*****************************************************************************
GEN_DESC_UPDT_QUEUE : if C_SG_INCLUDE_DESC_QUEUE = 1 generate
signal xb_fifo_reset    : std_logic := '0';
signal xb_fifo_full     : std_logic := '0';
begin
    s2mm_complete       <= '1';     -- Fixed at '1'

    -----------------------------------------------------------------------
    -- Need to flag a pending point update to prevent subsequent fetch of
    -- descriptor from stepping on the stored pointer, and buffer length
    -----------------------------------------------------------------------
    REG_PENDING_UPDT : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0' or updt_data_clr = '1')then
                    s2mm_pending_pntr_updt <= '0';
                elsif(s2mm_new_curdesc_wren_i = '1')then
                    s2mm_pending_pntr_updt <= '1';
                end if;
            end if;
        end process REG_PENDING_UPDT;

    -- Pending update on pointer not updated yet or xfer'ed bytes fifo full
    s2mm_pending_update <= s2mm_pending_pntr_updt or xb_fifo_full;

    -- Clear status received flag in cmdsts_if to
    -- allow more status to be received from datamover
    s2mm_sts_received_clr <= updt_sts_clr;

    -- Generate a rising edge off status received in order to
    -- flag status update
    REG_STATUS : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    sts_received_d1 <= '0';
                else
                    sts_received_d1 <= s2mm_sts_received;
                end if;
            end if;
        end process REG_STATUS;

    -- CR 566306 Status invalid during halt
    --  sts_received_re <= s2mm_sts_received and not sts_received_d1;
    sts_received_re <= s2mm_sts_received and not sts_received_d1 and not s2mm_halt_d2;

    ---------------------------------------------------------------------------
    -- When status received set and hold flag until
    -- status can be updated to queue.  Note it may
    -- be held off due to update of data
    ---------------------------------------------------------------------------
    UPDT_STS_PROCESS : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0' or updt_sts_clr = '1')then
                    updt_sts                <= '0';
                -- clear flag when status update done or
                -- datamover halted
      --          elsif(updt_sts_clr = '1')then
      --              updt_sts                <= '0';
                -- set flag when status received
                elsif(sts_received_re = '1')then
                    updt_sts                <= '1';
                end if;
            end if;
        end process UPDT_STS_PROCESS;


    updt_sts_clr <= '1' when updt_sts = '1'
                         and updtsts_tvalid = '1'
                         and updtsts_tlast = '1'
                         and s_axis_s2mm_updtsts_tready = '1'
               else '0';


    -- for queue case used to keep track of number of datamover queued cmnds
    UPDT_DONE_PROCESS : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    desc_update_done <= '0';
                else
                    desc_update_done <= updt_sts_clr;
                end if;
            end if;
       end process UPDT_DONE_PROCESS;

    --***********************************************************************--
    --**       Descriptor Update Logic - DESCRIPTOR QUEUES - NO STS APP    **--
    --***********************************************************************--

    ---------------------------------------------------------------------------
    -- Generate Descriptor Update Signaling for NO Status App Stream
    ---------------------------------------------------------------------------
    GEN_DESC_UPDT_NO_STSAPP : if C_SG_INCLUDE_STSCNTRL_STRM = 0 generate
    begin

        stsstrm_fifo_rden   <= '0'; -- Not used in the NO sts stream configuration
        xb_fifo_full        <= '0'; -- Not used for indeterminate BTT mode


        -- Transferred byte length from status is equal to bytes transferred field
        -- in descriptor status
        GEN_EQ_23BIT_BYTE_XFERED : if C_SG_LENGTH_WIDTH = 23 generate
        begin

            s2mm_xferd_bytes <= s2mm_brcvd;

        end generate GEN_EQ_23BIT_BYTE_XFERED;

        -- Transferred byte length from status is less than bytes transferred field
        -- in descriptor status therefore need to pad value.
        GEN_LESSTHN_23BIT_BYTE_XFERED : if C_SG_LENGTH_WIDTH < 23 generate
        constant PAD_VALUE : std_logic_vector(22 - C_SG_LENGTH_WIDTH downto 0)
                                := (others => '0');
        begin
            s2mm_xferd_bytes <= PAD_VALUE & s2mm_brcvd;

        end generate GEN_LESSTHN_23BIT_BYTE_XFERED;


        -----------------------------------------------------------------------
        -- Catpure Status.  Status is built from status word from DataMover
        -- and from transferred bytes value.
        -----------------------------------------------------------------------
        UPDT_DESC_STATUS : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0')then
                        updt_desc_sts  <= (others => '0');

                    elsif(sts_received_re = '1')then
                        updt_desc_sts  <= DESC_LAST
                                         & s2mm_ioc
                                         & s2mm_complete
                                         & s2mm_decerr
                                         & s2mm_slverr
                                         & s2mm_interr
                                         & sof_received -- If asserted also set SOF
                                         & eof_received -- If asserted also set EOF
                                         & RESERVED_STS
                                         & s2mm_xferd_bytes;
                    end if;
                end if;
            end process UPDT_DESC_STATUS;

        -- Drive TVALID
        updtsts_tvalid <= updt_sts;
        -- Drive TLast
        updtsts_tlast  <= updt_desc_sts(C_S_AXIS_UPDSTS_TDATA_WIDTH);
        -- Drive TData
   GEN_DESC_UPDT_MCDMA : if C_ENABLE_MULTI_CHANNEL = 1 generate 
        updtsts_tdata  <= updt_desc_sts(C_S_AXIS_UPDSTS_TDATA_WIDTH-1 downto 20) & 
                          s2mm_desc_info_in (13 downto 10) & "000" & 
                          s2mm_desc_info_in (9 downto 5) & "000" & 
                          s2mm_desc_info_in (4 downto 0);
   end generate GEN_DESC_UPDT_MCDMA;


   GEN_DESC_UPDT_DMA : if C_ENABLE_MULTI_CHANNEL = 0 generate 
        updtsts_tdata  <= updt_desc_sts(C_S_AXIS_UPDSTS_TDATA_WIDTH-1 downto 0);
   end generate GEN_DESC_UPDT_DMA;

    end generate GEN_DESC_UPDT_NO_STSAPP;


    --***********************************************************************--
    --**       Descriptor Update Logic - DESCRIPTOR QUEUES - STS APP       **--
    --***********************************************************************--
    ---------------------------------------------------------------------------
    -- Generate Descriptor Update Signaling for Status App Stream
    ---------------------------------------------------------------------------
    GEN_DESC_UPDT_STSAPP : if C_SG_INCLUDE_STSCNTRL_STRM = 1 generate
    begin


        -- Get rx length is identical to command written, therefor store
        -- the BTT value from the command written to be used as the xferd bytes.
        GEN_USING_STSAPP_LENGTH : if C_SG_USE_STSAPP_LENGTH = 1 generate
        begin
            -----------------------------------------------------------------------
            -- On S2MM transferred bytes equals buffer length.  Capture length
            -- on curdesc write.
            -----------------------------------------------------------------------
            XFERRED_BYTE_FIFO : entity lib_srl_fifo_v1_0_2.srl_fifo_f
              generic map(
                C_DWIDTH        => BUFFER_LENGTH_WIDTH                              ,
                C_DEPTH         => 16                                               ,
                C_FAMILY        => C_FAMILY
                )
              port map(
                Clk             => m_axi_sg_aclk                                  ,
                Reset           => xb_fifo_reset                                    ,
                FIFO_Write      => s2mm_cmnd_wr                                     ,
                Data_In         => s2mm_cmnd_data(BUFFER_LENGTH_WIDTH-1 downto 0)   ,
                FIFO_Read       => sts_received_re                                  ,
                Data_Out        => s2mm_xferd_bytes                                 ,
                FIFO_Empty      => open                                             ,
                FIFO_Full       => xb_fifo_full                                     ,
                Addr            => open
                );

            xb_fifo_reset      <= not m_axi_sg_aresetn;

        end generate GEN_USING_STSAPP_LENGTH;

        -- Not using status app length field therefore primary S2MM DataMover is
        -- configured as a store and forward channel (i.e. indeterminate BTT mode)
        -- Receive length will be reported in datamover status.
        GEN_NOT_USING_STSAPP_LENGTH : if C_SG_USE_STSAPP_LENGTH = 0 generate
        begin
            xb_fifo_full        <= '0';         -- Not used in Indeterminate BTT mode

            -- Transferred byte length from status is equal to bytes transferred field
            -- in descriptor status
            GEN_EQ_23BIT_BYTE_XFERED : if C_SG_LENGTH_WIDTH = 23 generate
            begin

                s2mm_xferd_bytes <= s2mm_brcvd;

            end generate GEN_EQ_23BIT_BYTE_XFERED;

            -- Transferred byte length from status is less than bytes transferred field
            -- in descriptor status therefore need to pad value.
            GEN_LESSTHN_23BIT_BYTE_XFERED : if C_SG_LENGTH_WIDTH < 23 generate
            constant PAD_VALUE : std_logic_vector(22 - C_SG_LENGTH_WIDTH downto 0)
                                    := (others => '0');
            begin
                s2mm_xferd_bytes <= PAD_VALUE & s2mm_brcvd;

            end generate GEN_LESSTHN_23BIT_BYTE_XFERED;

        end generate GEN_NOT_USING_STSAPP_LENGTH;

        -----------------------------------------------------------------------
        -- For EOF Descriptor then need to update APP fields from Status
        -- Stream FIFO
        -----------------------------------------------------------------------
        WRITE_APP_PROCESS : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0' )then

                        writing_app_fields <= '0';
                    -- If writing app fields and reach LAST then stop writing
                    -- app fields
                    elsif(writing_app_fields = '1'                              -- Writing app fields
                    and stsstrm_fifo_dout (C_S_AXIS_S2MM_STS_TDATA_WIDTH) = '1'  -- Last app word (tlast=1)
                    and stsstrm_fifo_rden_i = '1')then                          -- Fifo read
                        writing_app_fields <= '0';

                    -- ON EOF Descriptor, then need to write application fields on desc
                    -- update
                    elsif(s2mm_packet_eof = '1'
                    and s2mm_xferd_bytes /= ZERO_LENGTH) then

                        writing_app_fields <= '1';
                    end if;
                end if;
            end process WRITE_APP_PROCESS;


        -- Shift in apps to SG engine if tvalid, tready, and not on last word
        sts_shftenbl  <=  updt_sts and updtsts_tvalid and s_axis_s2mm_updtsts_tready;

        -----------------------------------------------------------------------
        -- Catpure Status.  Status is built from status word from DataMover
        -- and from transferred bytes value.
        -----------------------------------------------------------------------
        UPDT_DESC_STATUS : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0')then
                        updt_desc_sts  <= (others => '0');
                    elsif(sts_received_re = '1')then
                        updt_desc_sts  <= DESC_NOT_LAST
                                         & s2mm_ioc
                                         & s2mm_complete
                                         & s2mm_decerr
                                         & s2mm_slverr
                                         & s2mm_interr
                                         & sof_received -- If asserted also set SOF
                                         & eof_received -- If asserted also set EOF
                                         & RESERVED_STS
                                         & s2mm_xferd_bytes;

                    elsif(sts_shftenbl='1')then
                        updt_desc_sts <= updt_desc_reg3;

                    end if;
                end if;
            end process UPDT_DESC_STATUS;


        -----------------------------------------------------------------------
        -- If EOF Descriptor (writing_app_fields=1) then pass data from
        -- status stream FIFO into descriptor update shift registers
        -- Else pass zeros
        -----------------------------------------------------------------------
        UPDT_REG3_MUX : process(writing_app_fields,
                                stsstrm_fifo_dout,
                                updt_zero_reg3,
                                sts_shftenbl)
                begin
                    if(writing_app_fields = '1')then
                        updt_desc_reg3      <= stsstrm_fifo_dout(C_S_AXIS_S2MM_STS_TDATA_WIDTH)              -- Update LAST setting
                                             & '0'
                                             & stsstrm_fifo_dout(C_S_AXIS_S2MM_STS_TDATA_WIDTH-1 downto 0);  -- Update Word
                        stsstrm_fifo_rden_i <= sts_shftenbl;
                    else
                        updt_desc_reg3      <= updt_zero_reg3;
                        stsstrm_fifo_rden_i <= '0';
                    end if;
                end process UPDT_REG3_MUX;

        stsstrm_fifo_rden <= stsstrm_fifo_rden_i;

        -----------------------------------------------------------------------
        -- APP 0 Register (Set to Zero for Non-EOF Descriptor)
        -----------------------------------------------------------------------
        UPDT_ZERO_WRD3  : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0' or sts_received_re = '1')then
                        updt_zero_reg3  <= DESC_NOT_LAST                -- Not last word of stream
                                         & '0'                          -- Don't set IOC
                                         & ZERO_VALUE;                  -- Remainder is zero

                    -- Shift data out on shift enable
                    elsif(sts_shftenbl = '1')then
                        updt_zero_reg3  <= updt_zero_reg4;
                    end if;
                end if;
            end process UPDT_ZERO_WRD3;

        -----------------------------------------------------------------------
        -- APP 1 Register (Set to Zero for Non-EOF Descriptor)
        -----------------------------------------------------------------------
        UPDT_ZERO_WRD4  : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0' or sts_received_re = '1')then
                        updt_zero_reg4  <= DESC_NOT_LAST                -- Not last word of stream
                                         & '0'                          -- Don't set IOC
                                         & ZERO_VALUE;                  -- Remainder is zero
                    -- Shift data out on shift enable
                    elsif(sts_shftenbl = '1')then
                        updt_zero_reg4  <= updt_zero_reg5;
                    end if;
                end if;
            end process UPDT_ZERO_WRD4;

        -----------------------------------------------------------------------
        -- APP 2 Register (Set to Zero for Non-EOF Descriptor)
        -----------------------------------------------------------------------
        UPDT_ZERO_WRD5  : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0' or sts_received_re = '1')then
                        updt_zero_reg5  <= DESC_NOT_LAST                -- Not last word of stream
                                         & '0'                          -- Don't set IOC
                                         & ZERO_VALUE;                  -- Remainder is zero

                    -- Shift data out on shift enable
                    elsif(sts_shftenbl = '1')then
                        updt_zero_reg5  <= updt_zero_reg6;
                    end if;
                end if;
            end process UPDT_ZERO_WRD5;

        -----------------------------------------------------------------------
        -- APP 3 and APP 4 Register (Set to Zero for Non-EOF Descriptor)
        -----------------------------------------------------------------------
        UPDT_ZERO_WRD6  : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0' or sts_received_re = '1')then
                        updt_zero_reg6  <= DESC_NOT_LAST                -- Not last word of stream
                                         & '0'                          -- Don't set IOC
                                         & ZERO_VALUE;                  -- Remainder is zero

                    -- Shift data out on shift enable
                    elsif(sts_shftenbl = '1')then
                        updt_zero_reg6  <= DESC_LAST                    -- Last word of stream
                                         & s2mm_ioc
                                         & ZERO_VALUE;                  -- Remainder is zero
                    end if;
                end if;
            end process UPDT_ZERO_WRD6;

        -----------------------------------------------------------------------
        -- Drive TVALID
        -- If writing app then base on stsstrm fifo empty flag
        -- If writing datamover status then base simply assert on updt_sts
        -----------------------------------------------------------------------
        TVALID_MUX : process(writing_app_fields,updt_sts,stsstrm_fifo_empty)
            begin

                if(updt_sts = '1' and writing_app_fields = '1')then
                    updtsts_tvalid <= not stsstrm_fifo_empty;
                else
                    updtsts_tvalid <= updt_sts;
                end if;

            end process TVALID_MUX;

        -- Drive TLAST
        updtsts_tlast  <= updt_desc_sts(C_S_AXIS_UPDSTS_TDATA_WIDTH);
        -- Drive TDATA
        updtsts_tdata  <= updt_desc_sts(C_S_AXIS_UPDSTS_TDATA_WIDTH-1 downto 0);

    end generate GEN_DESC_UPDT_STSAPP;

    -- Pass out to sg engine
    s_axis_s2mm_updtsts_tdata   <= updtsts_tdata;
    s_axis_s2mm_updtsts_tvalid  <= updtsts_tvalid;
    s_axis_s2mm_updtsts_tlast   <= updtsts_tlast and updtsts_tvalid;


end generate GEN_DESC_UPDT_QUEUE;




--***************************************************************************--
--** Status Update Logic - NO DESCRIPTOR QUEUES                            **--
--***************************************************************************--
GEN_DESC_UPDT_NO_QUEUE : if C_SG_INCLUDE_DESC_QUEUE = 0 generate
begin

    s2mm_sts_received_clr   <= '1'; -- Not needed for the No Queue configuration
    s2mm_complete           <= '1'; -- Fixed at '1' for the No Queue configuration
    s2mm_pending_update     <= '0'; -- Not needed for the No Queue configuration

    -- Status received based on a DONE or an ERROR from DataMover
    sts_received <= s2mm_done or s2mm_interr or s2mm_decerr or s2mm_slverr;

    -- Generate a rising edge off done for use in triggering an
    -- update to the SG engine
    REG_STATUS : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    sts_received_d1 <= '0';
                else
                    sts_received_d1 <= sts_received;
                end if;
            end if;
        end process REG_STATUS;

    -- CR 566306 Status invalid during halt
    --  sts_received_re <= sts_received and not sts_received_d1;
    sts_received_re <= sts_received and not sts_received_d1 and not s2mm_halt_d2;


    ---------------------------------------------------------------------------
    -- When status received set and hold flag until
    -- status can be updated to queue.  Note it may
    -- be held off due to update of data
    ---------------------------------------------------------------------------
    UPDT_STS_PROCESS : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    updt_sts                <= '0';
                -- clear flag when status update done
                elsif(updt_sts_clr = '1')then
                    updt_sts                <= '0';
                -- set flag when status received
                elsif(sts_received_re = '1')then
                    updt_sts                <= '1';
                end if;
            end if;
        end process UPDT_STS_PROCESS;


    -- Clear status update on acceptance of tlast by sg engine
    updt_sts_clr <= '1' when updt_sts = '1'
                         and updtsts_tvalid = '1'
                         and updtsts_tlast = '1'
                         and s_axis_s2mm_updtsts_tready = '1'
               else '0';


    -- for queue case used to keep track of number of datamover queued cmnds
    UPDT_DONE_PROCESS : process(m_axi_sg_aclk)
        begin
            if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                if(m_axi_sg_aresetn = '0')then
                    desc_update_done <= '0';
                else
                    desc_update_done <= updt_sts_clr;
                end if;

            end if;
       end process UPDT_DONE_PROCESS;


    --***********************************************************************--
    --**  Descriptor Update Logic - NO DESCRIPTOR QUEUES - NO STS APP      **--
    --***********************************************************************--
    ---------------------------------------------------------------------------
    -- Generate Descriptor Update Signaling for NO Status App Stream
    ---------------------------------------------------------------------------
    GEN_DESC_UPDT_NO_STSAPP : if C_SG_INCLUDE_STSCNTRL_STRM = 0 generate
    begin

        stsstrm_fifo_rden <= '0';   -- Not used in the NO sts stream configuration

      GEN_NO_MICRO_DMA : if C_MICRO_DMA = 0 generate
        begin

        -- Transferred byte length from status is equal to bytes transferred field
        -- in descriptor status
        GEN_EQ_23BIT_BYTE_XFERED : if C_SG_LENGTH_WIDTH = 23 generate
        begin

            s2mm_xferd_bytes <= s2mm_brcvd;

        end generate GEN_EQ_23BIT_BYTE_XFERED;

        -- Transferred byte length from status is less than bytes transferred field
        -- in descriptor status therefore need to pad value.
        GEN_LESSTHN_23BIT_BYTE_XFERED : if C_SG_LENGTH_WIDTH < 23 generate
        constant PAD_VALUE : std_logic_vector(22 - C_SG_LENGTH_WIDTH downto 0)
                                := (others => '0');
        begin
            s2mm_xferd_bytes <= PAD_VALUE & s2mm_brcvd;

        end generate GEN_LESSTHN_23BIT_BYTE_XFERED;

       end generate GEN_NO_MICRO_DMA;

       GEN_MICRO_DMA : if C_MICRO_DMA = 1 generate
         begin
            s2mm_xferd_bytes <= (others => '0');
       end generate GEN_MICRO_DMA;
        -----------------------------------------------------------------------
        -- Catpure Status.  Status is built from status word from DataMover
        -- and from transferred bytes value.
        -----------------------------------------------------------------------
        UPDT_DESC_WRD2 : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0')then
                        updt_desc_sts  <= (others => '0');
                    -- Register Status on status received rising edge
                    elsif(sts_received_re = '1')then
                        updt_desc_sts  <= DESC_LAST
                                         & s2mm_ioc
                                         & s2mm_complete
                                         & s2mm_decerr
                                         & s2mm_slverr
                                         & s2mm_interr
                                         & sof_received -- If asserted also set SOF
                                         & eof_received -- If asserted also set EOF
                                         & RESERVED_STS
                                         & s2mm_xferd_bytes;

                    end if;
                end if;
            end process UPDT_DESC_WRD2;

  GEN_DESC_UPDT_MCDMA_NOQUEUE : if C_ENABLE_MULTI_CHANNEL = 1 generate
        updtsts_tdata  <= updt_desc_sts(C_S_AXIS_UPDSTS_TDATA_WIDTH-1 downto 20) & 
                          s2mm_desc_info_in (13 downto 10) & "000" & 
                          s2mm_desc_info_in (9 downto 5) & "000" & 
                          s2mm_desc_info_in (4 downto 0);
   end generate GEN_DESC_UPDT_MCDMA_NOQUEUE;


   GEN_DESC_UPDT_DMA_NOQUEUE : if C_ENABLE_MULTI_CHANNEL = 0 generate
        updtsts_tdata  <= updt_desc_sts(C_S_AXIS_UPDSTS_TDATA_WIDTH-1 downto 0);
   end generate GEN_DESC_UPDT_DMA_NOQUEUE; 
        -- Drive TVALID
        updtsts_tvalid <= updt_sts;
        -- Drive TLAST
        updtsts_tlast  <= updt_desc_sts(C_S_AXIS_UPDSTS_TDATA_WIDTH);
        -- Drive TData
  --      updtsts_tdata  <= updt_desc_sts(C_S_AXIS_UPDSTS_TDATA_WIDTH - 1 downto 0);


    end generate GEN_DESC_UPDT_NO_STSAPP;



    --***********************************************************************--
    --**    Descriptor Update Logic - NO DESCRIPTOR QUEUES - STS APP       **--
    --***********************************************************************--
    ---------------------------------------------------------------------------
    -- Generate Descriptor Update Signaling for NO Status App Stream
    ---------------------------------------------------------------------------
    GEN_DESC_UPDT_STSAPP : if C_SG_INCLUDE_STSCNTRL_STRM = 1 generate
    begin

        -- Rx length is identical to command written, therefore store
        -- the BTT value from the command written to be used as the xferd bytes.
        GEN_USING_STSAPP_LENGTH : if C_SG_USE_STSAPP_LENGTH = 1 generate
        begin
            -----------------------------------------------------------------------
            -- On S2MM transferred bytes equals buffer length.  Capture length
            -- on curdesc write.
            -----------------------------------------------------------------------
            REG_XFERRED_BYTES : process(m_axi_sg_aclk)
                begin
                    if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                        if(m_axi_sg_aresetn = '0')then
                            s2mm_xferd_bytes <= (others => '0');
                        elsif(s2mm_cmnd_wr = '1')then
                            s2mm_xferd_bytes <= s2mm_cmnd_data(BUFFER_LENGTH_WIDTH-1 downto 0);
                        end if;
                    end if;
                end process REG_XFERRED_BYTES;
        end generate GEN_USING_STSAPP_LENGTH;

        -- Configured as a store and forward channel (i.e. indeterminate BTT mode)
        -- Receive length will be reported in datamover status.
        GEN_NOT_USING_STSAPP_LENGTH : if C_SG_USE_STSAPP_LENGTH = 0 generate
        begin

            -- Transferred byte length from status is equal to bytes transferred field
            -- in descriptor status
            GEN_EQ_23BIT_BYTE_XFERED : if C_SG_LENGTH_WIDTH = 23 generate
            begin

                s2mm_xferd_bytes <= s2mm_brcvd;

            end generate GEN_EQ_23BIT_BYTE_XFERED;

            -- Transferred byte length from status is less than bytes transferred field
            -- in descriptor status therefore need to pad value.
            GEN_LESSTHN_23BIT_BYTE_XFERED : if C_SG_LENGTH_WIDTH < 23 generate
            constant PAD_VALUE : std_logic_vector(22 - C_SG_LENGTH_WIDTH downto 0)
                                    := (others => '0');
            begin
                s2mm_xferd_bytes <= PAD_VALUE & s2mm_brcvd;

            end generate GEN_LESSTHN_23BIT_BYTE_XFERED;


        end generate GEN_NOT_USING_STSAPP_LENGTH;

        -----------------------------------------------------------------------
        -- For EOF Descriptor then need to update APP fields from Status
        -- Stream FIFO
        -----------------------------------------------------------------------
        WRITE_APP_PROCESS : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0')then

                        writing_app_fields <= '0';

                    -- If writing app fields and reach LAST then stop writing
                    -- app fields
                    elsif(writing_app_fields = '1'                              -- Writing app fields
                    and stsstrm_fifo_dout(C_S_AXIS_S2MM_STS_TDATA_WIDTH) = '1'  -- Last app word (tlast=1)
                    and stsstrm_fifo_rden_i = '1')then                          -- Fifo read
                        writing_app_fields <= '0';

                    -- ON EOF Descriptor, then need to write application fields on desc
                    -- update
                    elsif(eof_received = '1'
                    and s2mm_xferd_bytes /= ZERO_LENGTH) then
                        writing_app_fields <= '1';
                    end if;
                end if;
            end process WRITE_APP_PROCESS;

        -- Shift in apps to SG engine if tvalid, tready, and not on last word
        sts_shftenbl  <=  updt_sts and updtsts_tvalid and s_axis_s2mm_updtsts_tready;

        -----------------------------------------------------------------------
        -- Catpure Status.  Status is built from status word from DataMover
        -- and from transferred bytes value.
        -----------------------------------------------------------------------
        UPDT_DESC_WRD2 : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0')then
                        updt_desc_sts  <= (others => '0');
                    -- Status from Prmry Datamover received
                    elsif(sts_received_re = '1')then
                        updt_desc_sts  <= DESC_NOT_LAST
                                         & s2mm_ioc
                                         & s2mm_complete
                                         & s2mm_decerr
                                         & s2mm_slverr
                                         & s2mm_interr
                                         & sof_received -- If asserted also set SOF
                                         & eof_received -- If asserted also set EOF
                                         & RESERVED_STS
                                         & s2mm_xferd_bytes;
                    -- Shift on descriptor update
                    elsif(sts_shftenbl = '1')then
                        updt_desc_sts <= updt_desc_reg3;

                    end if;
                end if;
            end process UPDT_DESC_WRD2;

        -----------------------------------------------------------------------
        -- If EOF Descriptor (writing_app_fields=1) then pass data from
        -- status stream FIFO into descriptor update shift registers
        -- Else pass zeros
        -----------------------------------------------------------------------
        UPDT_REG3_MUX : process(writing_app_fields,
                                stsstrm_fifo_dout,
                                updt_zero_reg3,
                                sts_shftenbl)
                begin
                    if(writing_app_fields = '1')then
                        updt_desc_reg3      <= stsstrm_fifo_dout(C_S_AXIS_S2MM_STS_TDATA_WIDTH)              -- Update LAST setting
                                             & '0'
                                             & stsstrm_fifo_dout(C_S_AXIS_S2MM_STS_TDATA_WIDTH-1 downto 0);  -- Update Word
                        stsstrm_fifo_rden_i <= sts_shftenbl;
                    else
                        updt_desc_reg3      <= updt_zero_reg3;
                        stsstrm_fifo_rden_i <= '0';
                    end if;
                end process UPDT_REG3_MUX;

        stsstrm_fifo_rden <= stsstrm_fifo_rden_i;

        -----------------------------------------------------------------------
        -- APP 0 Register (Set to Zero for Non-EOF Descriptor)
        -----------------------------------------------------------------------
        UPDT_ZERO_WRD3  : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0' or sts_received_re = '1')then
                        updt_zero_reg3  <= (others => '0');
                    -- Shift data out on shift enable
                    elsif(sts_shftenbl = '1')then
                        updt_zero_reg3  <= updt_zero_reg4;
                    end if;
                end if;
            end process UPDT_ZERO_WRD3;

        -----------------------------------------------------------------------
        -- APP 1 Register (Set to Zero for Non-EOF Descriptor)
        -----------------------------------------------------------------------
        UPDT_ZERO_WRD4  : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0' or sts_received_re = '1')then
                        updt_zero_reg4  <= (others => '0');
                    -- Shift data out on shift enable
                    elsif(sts_shftenbl = '1')then
                        updt_zero_reg4  <= updt_zero_reg5;
                    end if;
                end if;
            end process UPDT_ZERO_WRD4;

        -----------------------------------------------------------------------
        -- APP 2 Register (Set to Zero for Non-EOF Descriptor)
        -----------------------------------------------------------------------
        UPDT_ZERO_WRD5  : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0' or sts_received_re = '1')then
                        updt_zero_reg5  <= (others => '0');
                    -- Shift data out on shift enable
                    elsif(sts_shftenbl = '1')then
                        updt_zero_reg5  <= updt_zero_reg6;
                    end if;
                end if;
            end process UPDT_ZERO_WRD5;

        -----------------------------------------------------------------------
        -- APP 3 Register (Set to Zero for Non-EOF Descriptor)
        -----------------------------------------------------------------------
        UPDT_ZERO_WRD6  : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0' or sts_received_re = '1')then
                        updt_zero_reg6  <= (others => '0');
                    -- Shift data out on shift enable
                    elsif(sts_shftenbl = '1')then
                        updt_zero_reg6  <= updt_zero_reg7;
                    end if;
                end if;
            end process UPDT_ZERO_WRD6;

        -----------------------------------------------------------------------
        -- APP 4 Register (Set to Zero for Non-EOF Descriptor)
        -----------------------------------------------------------------------
        UPDT_ZERO_WRD7  : process(m_axi_sg_aclk)
            begin
                if(m_axi_sg_aclk'EVENT and m_axi_sg_aclk = '1')then
                    if(m_axi_sg_aresetn = '0')then
                        updt_zero_reg7  <= (others => '0');
                    elsif(sts_received_re = '1')then
                        updt_zero_reg7 <=  DESC_LAST
                                         & '0'
                                         & ZERO_VALUE;
                    end if;
                end if;
            end process UPDT_ZERO_WRD7;

        -----------------------------------------------------------------------
        -- Drive TVALID
        -- If writing app then base on stsstrm fifo empty flag
        -- If writing datamover status then base simply assert on updt_sts
        -----------------------------------------------------------------------
        TVALID_MUX : process(writing_app_fields,updt_sts,stsstrm_fifo_empty)
            begin

                if(updt_sts = '1' and writing_app_fields = '1')then
                    updtsts_tvalid <= not stsstrm_fifo_empty;
                else
                    updtsts_tvalid <= updt_sts;
                end if;

            end process TVALID_MUX;


        -- Drive TDATA
        updtsts_tdata <= updt_desc_sts(C_S_AXIS_UPDSTS_TDATA_WIDTH-1 downto 0);

        -- DRIVE TLAST
        updtsts_tlast <= updt_desc_sts(C_S_AXIS_UPDSTS_TDATA_WIDTH);



    end generate GEN_DESC_UPDT_STSAPP;


    -- Pass out to sg engine
    s_axis_s2mm_updtsts_tdata   <= updtsts_tdata;
    s_axis_s2mm_updtsts_tvalid  <= updtsts_tvalid;
    s_axis_s2mm_updtsts_tlast   <= updtsts_tlast and updtsts_tvalid;



end generate GEN_DESC_UPDT_NO_QUEUE;




end implementation;
