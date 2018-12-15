-------------------------------------------------------------------------------
-- axi_dma_lite_if
-------------------------------------------------------------------------------
--
-- *************************************************************************
--
-- (c) Copyright 2010, 2011 Xilinx, Inc. All rights reserved.
--
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
--
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
--
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
--
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
--
-- *************************************************************************
--
-------------------------------------------------------------------------------
-- Filename:          axi_dma_lite_if.vhd
-- Description: This entity is AXI Lite Interface Module for the AXI DMA
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
library lib_cdc_v1_0_2;
use lib_pkg_v1_0_2.lib_pkg.clog2;

-------------------------------------------------------------------------------
entity  axi_dma_lite_if is
    generic(
        C_NUM_CE                    : integer                := 8           ;
        C_AXI_LITE_IS_ASYNC         : integer range 0 to 1   := 0           ;
        C_S_AXI_LITE_ADDR_WIDTH     : integer range 2 to 32 := 32          ;
        C_S_AXI_LITE_DATA_WIDTH     : integer range 32 to 32 := 32
    );
    port (
        -- Async clock input
        ip2axi_aclk                 : in  std_logic                         ;          --
        ip2axi_aresetn              : in  std_logic                         ;          --

        -----------------------------------------------------------------------
        -- AXI Lite Control Interface
        -----------------------------------------------------------------------
        s_axi_lite_aclk             : in  std_logic                         ;          --
        s_axi_lite_aresetn          : in  std_logic                         ;          --
                                                                                       --
        -- AXI Lite Write Address Channel                                              --
        s_axi_lite_awvalid          : in  std_logic                         ;          --
        s_axi_lite_awready          : out std_logic                         ;          --
        s_axi_lite_awaddr           : in  std_logic_vector                             --
                                        (C_S_AXI_LITE_ADDR_WIDTH-1 downto 0);          --
                                                                                       --
        -- AXI Lite Write Data Channel                                                 --
        s_axi_lite_wvalid           : in  std_logic                         ;          --
        s_axi_lite_wready           : out std_logic                         ;          --
        s_axi_lite_wdata            : in  std_logic_vector                             --
                                        (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);          --
                                                                                       --
        -- AXI Lite Write Response Channel                                             --
        s_axi_lite_bresp            : out std_logic_vector(1 downto 0)      ;          --
        s_axi_lite_bvalid           : out std_logic                         ;          --
        s_axi_lite_bready           : in  std_logic                         ;          --
                                                                                       --
        -- AXI Lite Read Address Channel                                               --
        s_axi_lite_arvalid          : in  std_logic                         ;          --
        s_axi_lite_arready          : out std_logic                         ;          --
        s_axi_lite_araddr           : in  std_logic_vector                             --
                                        (C_S_AXI_LITE_ADDR_WIDTH-1 downto 0);          --
        s_axi_lite_rvalid           : out std_logic                         ;          --
        s_axi_lite_rready           : in  std_logic                         ;          --
        s_axi_lite_rdata            : out std_logic_vector                             --
                                        (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);          --
        s_axi_lite_rresp            : out std_logic_vector(1 downto 0)      ;          --
                                                                                       --
        -- User IP Interface                                                           --
        axi2ip_wrce                 : out std_logic_vector                             --
                                        (C_NUM_CE-1 downto 0)               ;          --
        axi2ip_wrdata               : out std_logic_vector                             --
                                        (C_S_AXI_LITE_DATA_WIDTH-1 downto 0);          --
                                                                                       --
        axi2ip_rdce                 : out std_logic_vector                             --
                                        (C_NUM_CE-1 downto 0)               ;          --

        axi2ip_rdaddr               : out std_logic_vector                             --
                                        (C_S_AXI_LITE_ADDR_WIDTH-1 downto 0);          --
        ip2axi_rddata               : in std_logic_vector                              --
                                        (C_S_AXI_LITE_DATA_WIDTH-1 downto 0)           --
    );
end axi_dma_lite_if;


-------------------------------------------------------------------------------
-- Architecture
-------------------------------------------------------------------------------
architecture implementation of axi_dma_lite_if is
  attribute DowngradeIPIdentifiedWarnings: string;
  attribute DowngradeIPIdentifiedWarnings of implementation : architecture is "yes";


-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------

-- No Functions Declared

-------------------------------------------------------------------------------
-- Constants Declarations
-------------------------------------------------------------------------------
-- Register I/F Address offset
constant ADDR_OFFSET    : integer := clog2(C_S_AXI_LITE_DATA_WIDTH/8);
-- Register I/F CE number
constant CE_ADDR_SIZE   : integer := clog2(C_NUM_CE);

-------------------------------------------------------------------------------
-- Signal / Type Declarations
-------------------------------------------------------------------------------
-- AXI Lite slave interface signals
signal awvalid              : std_logic := '0';
signal awaddr               : std_logic_vector
                                (C_S_AXI_LITE_ADDR_WIDTH-1 downto 0) := (others => '0');
signal wvalid               : std_logic := '0';
signal wdata                : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');


signal arvalid              : std_logic := '0';
signal araddr               : std_logic_vector
                                (C_S_AXI_LITE_ADDR_WIDTH-1 downto 0) := (others => '0');
signal awvalid_d1           : std_logic := '0';
signal awvalid_re           : std_logic := '0';
signal awready_i            : std_logic := '0';
signal wvalid_d1            : std_logic := '0';
signal wvalid_re            : std_logic := '0';
signal wready_i             : std_logic := '0';
signal bvalid_i             : std_logic := '0';

signal wr_addr_cap          : std_logic := '0';
signal wr_data_cap          : std_logic := '0';

-- AXI to IP interface signals
signal axi2ip_wraddr_i      : std_logic_vector
                                (C_S_AXI_LITE_ADDR_WIDTH-1 downto 0) := (others => '0');
signal axi2ip_wrdata_i      : std_logic_vector
                                (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal axi2ip_wren          : std_logic := '0';
signal wrce                 : std_logic_vector(C_NUM_CE-1 downto 0);

signal rdce                 : std_logic_vector(C_NUM_CE-1 downto 0) := (others => '0');
signal arvalid_d1           : std_logic := '0';
signal arvalid_re           : std_logic := '0';
signal arvalid_re_d1        : std_logic := '0';
signal arvalid_i            : std_logic := '0';
signal arready_i            : std_logic := '0';
signal rvalid               : std_logic := '0';
signal axi2ip_rdaddr_i      : std_logic_vector
                                (C_S_AXI_LITE_ADDR_WIDTH-1 downto 0) := (others => '0');

signal s_axi_lite_rvalid_i  : std_logic := '0';
signal read_in_progress     : std_logic := '0'; -- CR607165
signal rst_rvalid_re        : std_logic := '0'; -- CR576999
signal rst_wvalid_re        : std_logic := '0'; -- CR576999
signal rdy : std_logic := '0';
signal rdy1 : std_logic := '0';
signal wr_in_progress : std_logic := '0';

-------------------------------------------------------------------------------
-- Begin architecture logic
-------------------------------------------------------------------------------
begin

--*****************************************************************************
--** AXI LITE READ
--*****************************************************************************

s_axi_lite_wready   <= wready_i;
s_axi_lite_awready  <= awready_i;
s_axi_lite_arready  <= arready_i;

s_axi_lite_bvalid   <= bvalid_i;

-------------------------------------------------------------------------------
-- Register AXI Inputs
-------------------------------------------------------------------------------
REG_INPUTS : process(s_axi_lite_aclk)
    begin
        if(s_axi_lite_aclk'EVENT and s_axi_lite_aclk = '1')then
            if(s_axi_lite_aresetn = '0')then
                awvalid <=  '0'                 ;
                awaddr  <=  (others => '0')     ;
                wvalid  <=  '0'                 ;
                wdata   <=  (others => '0')     ;
                arvalid <=  '0'                 ;
                araddr  <=  (others => '0')     ;
            else
                awvalid <= s_axi_lite_awvalid   ;
                awaddr  <= s_axi_lite_awaddr    ;
                wvalid  <= s_axi_lite_wvalid    ;
                wdata   <= s_axi_lite_wdata     ;
                arvalid <= s_axi_lite_arvalid   ;
                araddr  <= s_axi_lite_araddr    ;
            end if;
        end if;
    end process REG_INPUTS;



-- s_axi_lite_aclk is synchronous to ip clock
GEN_SYNC_WRITE : if C_AXI_LITE_IS_ASYNC = 0 generate
begin


-------------------------------------------------------------------------------
-- Assert Write Adddress Ready Handshake
-- Capture rising edge of valid and register out as ready.  This creates
-- a 3 clock cycle address phase but also registers all inputs and outputs.
-- Note : Single clock cycle address phase can be accomplished using
-- combinatorial logic.
-------------------------------------------------------------------------------
REG_AWVALID : process(s_axi_lite_aclk)
    begin
        if(s_axi_lite_aclk'EVENT and s_axi_lite_aclk = '1')then
            if(s_axi_lite_aresetn = '0' or rst_wvalid_re = '1')then
                awvalid_d1  <= '0';
--                awvalid_re  <= '0';                             -- CR605883
            else
                awvalid_d1  <= awvalid;
--                awvalid_re  <= awvalid and not awvalid_d1;      -- CR605883
            end if;
        end if;
    end process REG_AWVALID;

                awvalid_re  <= awvalid and not awvalid_d1 and (not (wr_in_progress));      -- CR605883
-------------------------------------------------------------------------------
-- Capture assertion of awvalid to indicate that we have captured
-- a valid address
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Assert Write Data Ready Handshake
-- Capture rising edge of valid and register out as ready.  This creates
-- a 3 clock cycle address phase but also registers all inputs and outputs.
-- Note : Single clock cycle address phase can be accomplished using
-- combinatorial logic.
-------------------------------------------------------------------------------
REG_WVALID : process(s_axi_lite_aclk)
    begin
        if(s_axi_lite_aclk'EVENT and s_axi_lite_aclk = '1')then
            if(s_axi_lite_aresetn = '0' or rst_wvalid_re = '1')then
                wvalid_d1   <= '0';
--                wvalid_re   <= '0';
            else
                wvalid_d1   <= wvalid;
--                wvalid_re   <= wvalid and not wvalid_d1; -- CR605883
            end if;
        end if;
    end process REG_WVALID;

                wvalid_re   <= wvalid and not wvalid_d1; -- CR605883


WRITE_IN_PROGRESS : process(s_axi_lite_aclk)
    begin
        if(s_axi_lite_aclk'EVENT and s_axi_lite_aclk = '1')then
            if(s_axi_lite_aresetn = '0' or rst_wvalid_re = '1')then
                wr_in_progress <= '0';
            elsif(awvalid_re = '1')then
                wr_in_progress <= '1';
            end if;
        end if;
    end process WRITE_IN_PROGRESS;


-- CR605883 (CDC) provide pure register output to synchronizers
--wvalid_re  <= wvalid and not wvalid_d1 and not rst_wvalid_re;

                

-------------------------------------------------------------------------------
-- Capture assertion of wvalid to indicate that we have captured
-- valid data
-------------------------------------------------------------------------------


WRDATA_CAP_FLAG : process(s_axi_lite_aclk)
    begin
        if(s_axi_lite_aclk'EVENT and s_axi_lite_aclk = '1')then
            if(s_axi_lite_aresetn = '0' or rdy = '1')then
                wr_data_cap <= '0';
            elsif(wvalid_re = '1')then
                wr_data_cap <= '1';
            end if;
        end if;
    end process WRDATA_CAP_FLAG;

REG_WREADY : process(s_axi_lite_aclk)
    begin
        if(s_axi_lite_aclk'EVENT and s_axi_lite_aclk = '1')then
            if(s_axi_lite_aresetn = '0' or rdy = '1') then
                rdy <= '0';
            elsif (wr_data_cap = '1' and wr_addr_cap = '1') then
                rdy <= '1';
            end if;
                wready_i <= rdy;
                awready_i <= rdy;
                rdy1 <= rdy; 
        end if;
    end process REG_WREADY;


WRADDR_CAP_FLAG : process(s_axi_lite_aclk)
    begin
        if(s_axi_lite_aclk'EVENT and s_axi_lite_aclk = '1')then
            if(s_axi_lite_aresetn = '0' or rdy = '1')then
                wr_addr_cap <= '0';
            elsif(awvalid_re = '1')then
                wr_addr_cap <= '1';
            end if;
        end if;
    end process WRADDR_CAP_FLAG;
    -------------------------------------------------------------------------------
    -- Capture Write Address
    -------------------------------------------------------------------------------
    REG_WRITE_ADDRESS : process(s_axi_lite_aclk)
        begin
            if(s_axi_lite_aclk'EVENT and s_axi_lite_aclk = '1')then
                if(s_axi_lite_aresetn = '0')then
                 --   axi2ip_wraddr_i   <= (others => '0');

                -- Register address on valid
                elsif(awvalid_re = '1')then
                 --   axi2ip_wraddr_i   <= awaddr;

                end if;
            end if;
        end process REG_WRITE_ADDRESS;

    -------------------------------------------------------------------------------
    -- Capture Write Data
    -------------------------------------------------------------------------------
    REG_WRITE_DATA : process(s_axi_lite_aclk)
        begin
            if(s_axi_lite_aclk'EVENT and s_axi_lite_aclk = '1')then
                if(s_axi_lite_aresetn = '0')then
                    axi2ip_wrdata_i     <= (others => '0');

                -- Register address and assert ready
                elsif(wvalid_re = '1')then
                    axi2ip_wrdata_i     <= wdata;

                end if;
            end if;
        end process REG_WRITE_DATA;

    -------------------------------------------------------------------------------
    -- Must have both a valid address and valid data before updating
    -- a register.  Note in AXI write address can come before or
    -- after AXI write data.
--    axi2ip_wren <= '1' when wr_data_cap = '1' and wr_addr_cap = '1'
--                else '0';
      axi2ip_wren <= rdy; -- or rdy1;
    -------------------------------------------------------------------------------
    -- Decode and assert proper chip enable per captured axi lite write address
    -------------------------------------------------------------------------------
    WRCE_GEN: for j in 0 to C_NUM_CE - 1 generate

    constant BAR    : std_logic_vector(CE_ADDR_SIZE-1 downto 0) :=
                    std_logic_vector(to_unsigned(j,CE_ADDR_SIZE));
    begin

        wrce(j) <= axi2ip_wren when s_axi_lite_awaddr
                                    ((CE_ADDR_SIZE + ADDR_OFFSET) - 1
                                                        downto ADDR_OFFSET)

                                    = BAR(CE_ADDR_SIZE-1 downto 0)
              else '0';

    end generate WRCE_GEN;

    -------------------------------------------------------------------------------
    -- register write ce's and data out to axi dma register module
    -------------------------------------------------------------------------------
    REG_WR_OUT : process(s_axi_lite_aclk)
        begin
        if(s_axi_lite_aclk'EVENT and s_axi_lite_aclk = '1')then
            if(s_axi_lite_aresetn = '0')then
                axi2ip_wrce     <= (others => '0');
        --        axi2ip_wrdata   <= (others => '0');
            else
                axi2ip_wrce     <= wrce;
        --        axi2ip_wrdata   <= axi2ip_wrdata_i;
            end if;
        end if;
    end process REG_WR_OUT;
  
             axi2ip_wrdata <= s_axi_lite_wdata; 

    -------------------------------------------------------------------------------
    -- Write Response
    -------------------------------------------------------------------------------
    s_axi_lite_bresp    <= OKAY_RESP;

    WRESP_PROCESS : process(s_axi_lite_aclk)
        begin
            if(s_axi_lite_aclk'EVENT and s_axi_lite_aclk = '1')then
                if(s_axi_lite_aresetn = '0')then
                    bvalid_i        <= '0';
                    rst_wvalid_re   <= '0';     -- CR576999
                -- If response issued and target indicates ready then
                -- clear response
                elsif(bvalid_i = '1' and s_axi_lite_bready = '1')then
                    bvalid_i        <= '0';
                    rst_wvalid_re   <= '0';     -- CR576999
                -- Issue a resonse on write
                elsif(rdy1 = '1')then
                    bvalid_i        <= '1';
                    rst_wvalid_re   <= '1';     -- CR576999
                end if;
            end if;
        end process WRESP_PROCESS;


end generate GEN_SYNC_WRITE;


-- s_axi_lite_aclk is asynchronous to ip clock
GEN_ASYNC_WRITE : if C_AXI_LITE_IS_ASYNC = 1 generate
-- Data support

 -----------------------------------------------------------------------------
  -- ATTRIBUTE Declarations
  -----------------------------------------------------------------------------
  -- Prevent x-propagation on clock-domain crossing register
  ATTRIBUTE async_reg                      : STRING;
 Attribute KEEP : string; -- declaration
 Attribute EQUIVALENT_REGISTER_REMOVAL : string; -- declaration


signal ip_wvalid_d1_cdc_to     : std_logic := '0';
signal ip_wvalid_d2     : std_logic := '0';
signal ip_wvalid_re     : std_logic := '0';
signal wr_wvalid_re_cdc_from     : std_logic := '0';
signal wr_data_cdc_from          : std_logic_vector                                              -- CR605883
                            (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');    -- CR605883
signal wdata_d1_cdc_to         : std_logic_vector
                            (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal wdata_d2         : std_logic_vector
                            (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');

signal axi2ip_wrdata_cdc_tig         : std_logic_vector
                            (C_S_AXI_LITE_DATA_WIDTH-1 downto 0) := (others => '0');
signal ip_data_cap      : std_logic := '0';

-- Address support
signal ip_awvalid_d1_cdc_to    : std_logic := '0';
signal ip_awvalid_d2    : std_logic := '0';
signal ip_awvalid_re    : std_logic := '0';
signal wr_awvalid_re_cdc_from    : std_logic := '0';
signal wr_addr_cdc_from          : std_logic_vector                                              -- CR605883
                            (C_S_AXI_LITE_ADDR_WIDTH-1 downto 0) := (others => '0');    -- CR605883
signal awaddr_d1_cdc_tig        : std_logic_vector
                            (C_S_AXI_LITE_ADDR_WIDTH-1 downto 0) := (others => '0');
signal awaddr_d2        : std_logic_vector
                            (C_S_AXI_LITE_ADDR_WIDTH-1 downto 0) := (others => '0');
signal ip_addr_cap      : std_logic := '0';

-- Bvalid support
signal lite_data_cap_d1 : std_logic := '0';
signal lite_data_cap_d2 : std_logic := '0';
signal lite_addr_cap_d1 : std_logic := '0';
signal lite_addr_cap_d2 : std_logic := '0';
signal lite_axi2ip_wren : std_logic := '0';

signal awvalid_cdc_from : std_logic := '0';
signal awvalid_cdc_to : std_logic := '0';
signal awvalid_to : std_logic := '0';
signal awvalid_to2 : std_logic := '0';
  --ATTRIBUTE async_reg OF awvalid_cdc_to  : SIGNAL IS "true";
  --ATTRIBUTE async_reg OF awvalid_to  : SIGNAL IS "true";


signal wvalid_cdc_from : std_logic := '0';
signal wvalid_cdc_to : std_logic := '0';
signal wvalid_to : std_logic := '0';
signal wvalid_to2 : std_logic := '0';
  --ATTRIBUTE async_reg OF wvalid_cdc_to  : SIGNAL IS "true";
  --ATTRIBUTE async_reg OF wvalid_to  : SIGNAL IS "true";

signal rdy_cdc_to : std_logic := '0';
signal rdy_cdc_from : std_logic := '0';
signal rdy_to : std_logic := '0';
signal rdy_to2 : std_logic := '0';
signal rdy_to2_cdc_from : std_logic := '0';
signal rdy_out : std_logic := '0';
  --ATTRIBUTE async_reg OF rdy_cdc_to  : SIGNAL IS "true";
  --ATTRIBUTE async_reg OF rdy_to  : SIGNAL IS "true";

  Attribute KEEP of rdy_to2_cdc_from       : signal is "TRUE";
  Attribute EQUIVALENT_REGISTER_REMOVAL of rdy_to2_cdc_from : signal is "no";

signal rdy_back_cdc_to : std_logic := '0';
signal rdy_back_to : std_logic :='0';
  --ATTRIBUTE async_reg OF rdy_back_cdc_to  : SIGNAL IS "true";
  --ATTRIBUTE async_reg OF rdy_back_to  : SIGNAL IS "true";

signal rdy_back : std_logic := '0';

signal rdy_shut : std_logic := '0';

begin

REG_AWVALID : process(s_axi_lite_aclk)
    begin
        if(s_axi_lite_aclk'EVENT and s_axi_lite_aclk = '1')then
            if(s_axi_lite_aresetn = '0' or rst_wvalid_re = '1')then
                awvalid_d1  <= '0';
            else
                awvalid_d1  <= awvalid;
            end if;
        end if;
    end process REG_AWVALID;

                awvalid_re  <= awvalid and not awvalid_d1 and (not (wr_in_progress));      -- CR605883
-------------------------------------------------------------------------------
-- Capture assertion of awvalid to indicate that we have captured
-- a valid address
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Assert Write Data Ready Handshake
-- Capture rising edge of valid and register out as ready.  This creates
-- a 3 clock cycle address phase but also registers all inputs and outputs.
-- Note : Single clock cycle address phase can be accomplished using
-- combinatorial logic.
-------------------------------------------------------------------------------
REG_WVALID : process(s_axi_lite_aclk)
    begin
        if(s_axi_lite_aclk'EVENT and s_axi_lite_aclk = '1')then
            if(s_axi_lite_aresetn = '0' or rst_wvalid_re = '1')then
                wvalid_d1   <= '0';
            else
                wvalid_d1   <= wvalid;
            end if;
        end if;
    end process REG_WVALID;

                wvalid_re   <= wvalid and not wvalid_d1; -- CR605883

    --*************************************************************************
    --** Write Address Support
    --*************************************************************************

    AWVLD_CDC_FROM : process(s_axi_lite_aclk)
        begin
            if(s_axi_lite_aclk'EVENT and s_axi_lite_aclk = '1')then
                if(s_axi_lite_aresetn = '0' or rst_wvalid_re = '1')then
                    awvalid_cdc_from <= '0';
                elsif(awvalid_re = '1')then
                    awvalid_cdc_from <= '1';
                end if;
            end if;
        end process AWVLD_CDC_FROM;

AWVLD_CDC_TO : entity  lib_cdc_v1_0_2.cdc_sync
    generic map (
        C_CDC_TYPE                 => 1,
        C_RESET_STATE              => 0,
        C_SINGLE_BIT               => 1,
        C_VECTOR_WIDTH             => 32,
        C_MTBF_STAGES              => MTBF_STAGES
    )
    port map (
        prmry_aclk                 => s_axi_lite_aclk,
        prmry_resetn               => '0', 
        prmry_in                   => awvalid_cdc_from, 
        prmry_vect_in              => (others => '0'),
                                    
        scndry_aclk                => ip2axi_aclk, 
        scndry_resetn              => '0',
        scndry_out                 => awvalid_to,
        scndry_vect_out            => open
    );


--    AWVLD_CDC_TO : process(ip2axi_aclk)
--        begin
--            if(ip2axi_aclk'EVENT and ip2axi_aclk = '1')then
--                    awvalid_cdc_to <= awvalid_cdc_from;
--                    awvalid_to <= awvalid_cdc_to;
--            end if;
--        end process AWVLD_CDC_TO;

    AWVLD_CDC_TO2 : process(ip2axi_aclk)
        begin
            if(ip2axi_aclk'EVENT and ip2axi_aclk = '1')then
                if(ip2axi_aresetn = '0')then
                    awvalid_to2 <= '0';
                else
                    awvalid_to2 <= awvalid_to;
                end if;
            end if;
        end process AWVLD_CDC_TO2;


               ip_awvalid_re <= awvalid_to and (not awvalid_to2);


    WVLD_CDC_FROM : process(s_axi_lite_aclk)
        begin
            if(s_axi_lite_aclk'EVENT and s_axi_lite_aclk = '1')then
                if(s_axi_lite_aresetn = '0' or rst_wvalid_re = '1')then
                    wvalid_cdc_from <= '0';
                elsif(wvalid_re = '1')then
                    wvalid_cdc_from <= '1';
                end if;
            end if;
        end process WVLD_CDC_FROM;


WVLD_CDC_TO : entity  lib_cdc_v1_0_2.cdc_sync
    generic map (
        C_CDC_TYPE                 => 1,
        C_RESET_STATE              => 0,
        C_SINGLE_BIT               => 1,
        C_VECTOR_WIDTH             => 32,
        C_MTBF_STAGES              => MTBF_STAGES
    )
    port map (
        prmry_aclk                 => s_axi_lite_aclk,
        prmry_resetn               => '0', 
        prmry_in                   => wvalid_cdc_from, 
        prmry_vect_in              => (others => '0'),
                                    
        scndry_aclk                => ip2axi_aclk, 
        scndry_resetn              => '0',
        scndry_out                 => wvalid_to,
        scndry_vect_out            => open
    );

--    WVLD_CDC_TO : process(ip2axi_aclk)
--        begin
--            if(ip2axi_aclk'EVENT and ip2axi_aclk = '1')then
--                    wvalid_cdc_to <= wvalid_cdc_from;
--                    wvalid_to <= wvalid_cdc_to;
--            end if;
--        end process WVLD_CDC_TO;


    WVLD_CDC_TO2 : process(ip2axi_aclk)
        begin
            if(ip2axi_aclk'EVENT and ip2axi_aclk = '1')then
                if(ip2axi_aresetn = '0')then
                    wvalid_to2 <= '0';
                else
                    wvalid_to2 <= wvalid_to;
                end if;
            end if;
        end process WVLD_CDC_TO2;

               ip_wvalid_re <= wvalid_to and (not wvalid_to2);


REG_WADDR_TO_IPCLK : entity  lib_cdc_v1_0_2.cdc_sync
    generic map (
        C_CDC_TYPE                 => 1,
        C_RESET_STATE              => 0,
        C_SINGLE_BIT               => 0,
        C_VECTOR_WIDTH             => C_S_AXI_LITE_ADDR_WIDTH,
        C_MTBF_STAGES              => 1
    )
    port map (
        prmry_aclk                 => s_axi_lite_aclk,
        prmry_resetn               => '0', 
        prmry_in                   => '0', 
        prmry_vect_in              => s_axi_lite_awaddr,
                                    
        scndry_aclk                => ip2axi_aclk, 
        scndry_resetn              => '0',
        scndry_out                 => open, 
        scndry_vect_out            => awaddr_d1_cdc_tig
    );


REG_WADDR_TO_IPCLK1 : entity  lib_cdc_v1_0_2.cdc_sync
    generic map (
        C_CDC_TYPE                 => 1,
        C_RESET_STATE              => 0,
        C_SINGLE_BIT               => 0,
        C_VECTOR_WIDTH             => C_S_AXI_LITE_DATA_WIDTH,
        C_MTBF_STAGES              => 1
    )
    port map (
        prmry_aclk                 => s_axi_lite_aclk,
        prmry_resetn               => '0', 
        prmry_in                   => '0', 
        prmry_vect_in              => s_axi_lite_wdata,
                                    
        scndry_aclk                => ip2axi_aclk, 
        scndry_resetn              => '0',
        scndry_out                 => open, 
        scndry_vect_out            => axi2ip_wrdata_cdc_tig
    );

    -- Double register address in
--    REG_WADDR_TO_IPCLK : process(ip2axi_aclk)
--        begin
--            if(ip2axi_aclk'EVENT and ip2axi_aclk = '1')then
--                if(ip2axi_aresetn = '0')then
--                    awaddr_d1_cdc_tig           <= (others => '0');
--                --    axi2ip_wraddr_i     <= (others => '0');
--                    axi2ip_wrdata_cdc_tig <= (others => '0');
--                else
--                    awaddr_d1_cdc_tig           <= s_axi_lite_awaddr;
--                    axi2ip_wrdata_cdc_tig       <= s_axi_lite_wdata;
--                --    axi2ip_wraddr_i     <= awaddr_d1_cdc_tig;           -- CR605883
--                end if;
--            end if;
--        end process REG_WADDR_TO_IPCLK;

    -- Flag that address has been captured
    REG_IP_ADDR_CAP : process(ip2axi_aclk)
        begin
            if(ip2axi_aclk'EVENT and ip2axi_aclk = '1')then
                if(ip2axi_aresetn = '0' or rdy_shut = '1')then
                    ip_addr_cap <= '0';
                elsif(ip_awvalid_re = '1')then
                    ip_addr_cap <= '1';
                end if;
            end if;
        end process REG_IP_ADDR_CAP;


    REG_WREADY : process(ip2axi_aclk)
    begin
        if(ip2axi_aclk'EVENT and ip2axi_aclk = '1')then
            if(ip2axi_aresetn = '0' or rdy_shut = '1') then -- or rdy = '1') then
                rdy <= '0';
            elsif (ip_data_cap = '1' and ip_addr_cap = '1') then
                rdy <= '1';
            end if;
        end if;
    end process REG_WREADY;

REG3_WREADY : entity  lib_cdc_v1_0_2.cdc_sync
    generic map (
        C_CDC_TYPE                 => 1,
        C_RESET_STATE              => 0,
        C_SINGLE_BIT               => 1,
        C_VECTOR_WIDTH             => 32,
        C_MTBF_STAGES              => MTBF_STAGES
    )
    port map (
        prmry_aclk                 => s_axi_lite_aclk,
        prmry_resetn               => '0', 
        prmry_in                   => rdy_to2_cdc_from, 
        prmry_vect_in              => (others => '0'),
                                    
        scndry_aclk                => ip2axi_aclk, 
        scndry_resetn              => '0',
        scndry_out                 => rdy_back_to,
        scndry_vect_out            => open
    );

--    REG3_WREADY : process(ip2axi_aclk)
--    begin
--        if(ip2axi_aclk'EVENT and ip2axi_aclk = '1')then
--                rdy_back_cdc_to <= rdy_to2_cdc_from;
--                rdy_back_to <= rdy_back_cdc_to;
--        end if;
--    end process REG3_WREADY;


    REG3_WREADY2 : process(ip2axi_aclk)
    begin
        if(ip2axi_aclk'EVENT and ip2axi_aclk = '1')then
            if(ip2axi_aresetn = '0') then
                rdy_back <= '0';
            else
                rdy_back <= rdy_back_to;
            end if;
        end if;
    end process REG3_WREADY2;

    rdy_shut <= rdy_back_to and (not rdy_back);


    REG1_WREADY : process(ip2axi_aclk)
    begin
        if(ip2axi_aclk'EVENT and ip2axi_aclk = '1')then
            if(ip2axi_aresetn = '0' or rdy_shut = '1') then
                rdy_cdc_from <= '0';
            elsif (rdy = '1') then
                rdy_cdc_from <= '1';
            end if;
        end if;
    end process REG1_WREADY;


REG2_WREADY : entity  lib_cdc_v1_0_2.cdc_sync
    generic map (
        C_CDC_TYPE                 => 1,
        C_RESET_STATE              => 0,
        C_SINGLE_BIT               => 1,
        C_VECTOR_WIDTH             => 32,
        C_MTBF_STAGES              => MTBF_STAGES
    )
    port map (
        prmry_aclk                 => ip2axi_aclk,
        prmry_resetn               => '0', 
        prmry_in                   => rdy_cdc_from, 
        prmry_vect_in              => (others => '0'),
                                    
        scndry_aclk                => s_axi_lite_aclk, 
        scndry_resetn              => '0',
        scndry_out                 => rdy_to,
        scndry_vect_out            => open
    );


--    REG2_WREADY : process(s_axi_lite_aclk)
--    begin
--        if(s_axi_lite_aclk'EVENT and s_axi_lite_aclk = '1')then
--                rdy_cdc_to <= rdy_cdc_from;
--                rdy_to <= rdy_cdc_to;
--        end if;
--    end process REG2_WREADY;

    REG2_WREADY2 : process(s_axi_lite_aclk)
    begin
        if(s_axi_lite_aclk'EVENT and s_axi_lite_aclk = '1')then
            if(s_axi_lite_aresetn = '0') then
                rdy_to2 <= '0';
                rdy_to2_cdc_from <= '0';
            else
                rdy_to2 <= rdy_to;
                rdy_to2_cdc_from <= rdy_to;
            end if;
        end if;
    end process REG2_WREADY2;


   rdy_out <= not (rdy_to) and rdy_to2;

                wready_i <= rdy_out;
                awready_i <= rdy_out;


    --*************************************************************************
    --** Write Data Support
    --*************************************************************************

    -------------------------------------------------------------------------------
    -- Capture write data
    -------------------------------------------------------------------------------
--    WRDATA_S_H : process(s_axi_lite_aclk)
--        begin
--            if(s_axi_lite_aclk'EVENT and s_axi_lite_aclk = '1')then
--                if(s_axi_lite_aresetn = '0')then
--                    wr_data_cdc_from <= (others => '0');
--                elsif(wvalid_re = '1')then
--                    wr_data_cdc_from <= wdata;
--                end if;
--            end if;
--        end process WRDATA_S_H;


    -- Flag that data has been captured
    REG_IP_DATA_CAP : process(ip2axi_aclk)
        begin
            if(ip2axi_aclk'EVENT and ip2axi_aclk = '1')then
                if(ip2axi_aresetn = '0' or rdy_shut = '1')then
                    ip_data_cap <= '0';
                elsif(ip_wvalid_re = '1')then
                    ip_data_cap <= '1';
                end if;
            end if;
        end process REG_IP_DATA_CAP;

    -- Must have both a valid address and valid data before updating
    -- a register.  Note in AXI write address can come before or
    -- after AXI write data.

      axi2ip_wren <= rdy;
--    axi2ip_wren <= '1' when ip_data_cap = '1' and ip_addr_cap = '1'
--                else '0';

    -------------------------------------------------------------------------------
    -- Decode and assert proper chip enable per captured axi lite write address
    -------------------------------------------------------------------------------
    WRCE_GEN: for j in 0 to C_NUM_CE - 1 generate

    constant BAR    : std_logic_vector(CE_ADDR_SIZE-1 downto 0) :=
                    std_logic_vector(to_unsigned(j,CE_ADDR_SIZE));
    begin

        wrce(j) <= axi2ip_wren when awaddr_d1_cdc_tig
                                    ((CE_ADDR_SIZE + ADDR_OFFSET) - 1
                                                        downto ADDR_OFFSET)

                                    = BAR(CE_ADDR_SIZE-1 downto 0)
              else '0';

    end generate WRCE_GEN;

    -------------------------------------------------------------------------------
    -- register write ce's and data out to axi dma register module
    -------------------------------------------------------------------------------
    REG_WR_OUT : process(ip2axi_aclk)
        begin
        if(ip2axi_aclk'EVENT and ip2axi_aclk = '1')then
            if(ip2axi_aresetn = '0')then
                axi2ip_wrce     <= (others => '0');
            else
                axi2ip_wrce     <= wrce;
            end if;
        end if;
    end process REG_WR_OUT;

     axi2ip_wrdata  <=  axi2ip_wrdata_cdc_tig; --s_axi_lite_wdata;

    --*************************************************************************
    --** Write Response Support
    --*************************************************************************

    -- Minimum of 2 IP clocks for addr and data capture, therefore delaying
    -- Lite clock addr and data capture by 2 Lite clocks will guarenttee bvalid
    -- responce occurs after write data acutally written.
--    REG_ALIGN_CAP : process(s_axi_lite_aclk)
--        begin
--            if(s_axi_lite_aclk'EVENT and s_axi_lite_aclk = '1')then
--                if(s_axi_lite_aresetn = '0')then
--                    lite_data_cap_d1 <= '0';
--                    lite_data_cap_d2 <= '0';

--                    lite_addr_cap_d1 <= '0';
--                    lite_addr_cap_d2 <= '0';
--                else
--                    lite_data_cap_d1 <= rdy; --wr_data_cap;
--                    lite_data_cap_d2 <= lite_data_cap_d1;

--                    lite_addr_cap_d1 <= rdy; --wr_addr_cap;
--                    lite_addr_cap_d2 <= lite_addr_cap_d1;
--                end if;
--            end if;
--        end process REG_ALIGN_CAP;

    -- Pseudo write enable used simply to assert bvalid
  --  lite_axi2ip_wren <= rdy; --'1' when wr_data_cap = '1' and wr_addr_cap = '1'
              --  else '0';

    WRESP_PROCESS : process(s_axi_lite_aclk)
        begin
            if(s_axi_lite_aclk'EVENT and s_axi_lite_aclk = '1')then
                if(s_axi_lite_aresetn = '0')then
                    bvalid_i        <= '0';
                    rst_wvalid_re   <= '0';     -- CR576999
                -- If response issued and target indicates ready then
                -- clear response
                elsif(bvalid_i = '1' and s_axi_lite_bready = '1')then
                    bvalid_i        <= '0';
                    rst_wvalid_re   <= '0';     -- CR576999
                -- Issue a resonse on write
                elsif(rdy_out = '1')then
            --    elsif(lite_axi2ip_wren = '1')then
                    bvalid_i        <= '1';
                    rst_wvalid_re   <= '1';     -- CR576999
                end if;
            end if;
        end process WRESP_PROCESS;

    s_axi_lite_bresp    <= OKAY_RESP;


end generate GEN_ASYNC_WRITE;





--*****************************************************************************
--** AXI LITE READ
--*****************************************************************************

-------------------------------------------------------------------------------
-- Assert Read Adddress Ready Handshake
-- Capture rising edge of valid and register out as ready.  This creates
-- a 3 clock cycle address phase but also registers all inputs and outputs.
-- Note : Single clock cycle address phase can be accomplished using
-- combinatorial logic.
-------------------------------------------------------------------------------
REG_ARVALID : process(s_axi_lite_aclk)
    begin
        if(s_axi_lite_aclk'EVENT and s_axi_lite_aclk = '1')then
            if(s_axi_lite_aresetn = '0' or rst_rvalid_re = '1')then
                arvalid_d1 <= '0';
            else
                arvalid_d1 <= arvalid;
            end if;
        end if;
    end process REG_ARVALID;

arvalid_re  <= arvalid and not arvalid_d1
                and not rst_rvalid_re and not read_in_progress; -- CR607165

-- register for proper alignment
REG_ARREADY : process(s_axi_lite_aclk)
    begin
        if(s_axi_lite_aclk'EVENT and s_axi_lite_aclk = '1')then
            if(s_axi_lite_aresetn = '0')then
                arready_i <= '0';
            else
                arready_i <= arvalid_re;
            end if;
        end if;
    end process REG_ARREADY;

-- Always respond 'okay' axi lite read
s_axi_lite_rresp    <= OKAY_RESP;
s_axi_lite_rvalid   <= s_axi_lite_rvalid_i;


-- s_axi_lite_aclk is synchronous to ip clock
GEN_SYNC_READ : if C_AXI_LITE_IS_ASYNC = 0 generate
begin

    read_in_progress <= '0'; --Not used for sync mode (CR607165)

    -------------------------------------------------------------------------------
    -- Capture Read Address
    -------------------------------------------------------------------------------
    REG_READ_ADDRESS : process(s_axi_lite_aclk)
        begin
            if(s_axi_lite_aclk'EVENT and s_axi_lite_aclk = '1')then
                if(s_axi_lite_aresetn = '0')then
                    axi2ip_rdaddr_i   <= (others => '0');

                -- Register address on valid
                elsif(arvalid_re = '1')then
                    axi2ip_rdaddr_i   <= araddr;

                end if;
            end if;
        end process REG_READ_ADDRESS;



    -------------------------------------------------------------------------------
    -- Generate RdCE based on address match to address bar
    -------------------------------------------------------------------------------
    RDCE_GEN: for j in 0 to C_NUM_CE - 1 generate

    constant BAR    : std_logic_vector(CE_ADDR_SIZE-1 downto 0) :=
                    std_logic_vector(to_unsigned(j,CE_ADDR_SIZE));
    begin

      rdce(j) <= arvalid_re_d1
        when axi2ip_rdaddr_i((CE_ADDR_SIZE + ADDR_OFFSET) - 1
                              downto ADDR_OFFSET)
             = BAR(CE_ADDR_SIZE-1 downto 0)
        else '0';

    end generate RDCE_GEN;

    -------------------------------------------------------------------------------
    -- Register out to IP
    -------------------------------------------------------------------------------
    REG_RDCNTRL_OUT : process(s_axi_lite_aclk)
        begin
            if(s_axi_lite_aclk'EVENT and s_axi_lite_aclk = '1')then
                if(s_axi_lite_aresetn = '0')then
                    --axi2ip_rdce     <= (others => '0');
                    axi2ip_rdaddr   <= (others => '0');
                else
                    --axi2ip_rdce     <= rdce;
                    axi2ip_rdaddr   <= axi2ip_rdaddr_i;
                end if;
            end if;
        end process REG_RDCNTRL_OUT;


    -- Sample and hold rdce value until rvalid assertion
    REG_RDCE_OUT : process(s_axi_lite_aclk)
        begin
            if(s_axi_lite_aclk'EVENT and s_axi_lite_aclk = '1')then
                if(s_axi_lite_aresetn = '0' or rst_rvalid_re = '1')then
                    axi2ip_rdce     <= (others => '0');
                elsif(arvalid_re_d1 = '1')then
                    axi2ip_rdce     <= rdce;
                end if;
            end if;
        end process REG_RDCE_OUT;

    -- Register for proper alignment
    REG_RVALID : process(s_axi_lite_aclk)
        begin
            if(s_axi_lite_aclk'EVENT and s_axi_lite_aclk = '1')then
                if(s_axi_lite_aresetn = '0')then
                    arvalid_re_d1   <= '0';
                    rvalid          <= '0';
                else
                    arvalid_re_d1   <= arvalid_re;
                    rvalid          <= arvalid_re_d1;
                end if;
            end if;
        end process REG_RVALID;

    -------------------------------------------------------------------------------
    -- Drive read data and read data valid out on capture of valid address.
    -------------------------------------------------------------------------------
    REG_RD_OUT : process(s_axi_lite_aclk)
        begin
            if(s_axi_lite_aclk'EVENT and s_axi_lite_aclk = '1')then
                if(s_axi_lite_aresetn = '0')then
                    s_axi_lite_rdata    <= (others => '0');
                    s_axi_lite_rvalid_i <= '0';
                    rst_rvalid_re       <= '0';                 -- CR576999

                -- If rvalid driving out to target and target indicates ready
                -- then de-assert rvalid. (structure guarentees min 1 clock of rvalid)
                elsif(s_axi_lite_rvalid_i = '1' and s_axi_lite_rready = '1')then
                    s_axi_lite_rdata    <= (others => '0');
                    s_axi_lite_rvalid_i <= '0';
                    rst_rvalid_re       <= '0';                 -- CR576999

                -- If read cycle then assert rvalid and rdata out to target
                elsif(rvalid = '1')then
                    s_axi_lite_rdata    <= ip2axi_rddata;
                    s_axi_lite_rvalid_i <= '1';
                    rst_rvalid_re       <= '1';                 -- CR576999

                end if;
            end if;
        end process REG_RD_OUT;


end generate GEN_SYNC_READ;



-- s_axi_lite_aclk is asynchronous to ip clock
GEN_ASYNC_READ : if C_AXI_LITE_IS_ASYNC = 1 generate

  ATTRIBUTE async_reg                      : STRING;

signal ip_arvalid_d1_cdc_tig        : std_logic := '0';
signal ip_arvalid_d2        : std_logic := '0';
signal ip_arvalid_d3        : std_logic := '0';
signal ip_arvalid_re        : std_logic := '0';

signal araddr_d1_cdc_tig            : std_logic_vector(C_S_AXI_LITE_ADDR_WIDTH-1 downto 0) :=(others => '0');
signal araddr_d2            : std_logic_vector(C_S_AXI_LITE_ADDR_WIDTH-1 downto 0) :=(others => '0');
signal araddr_d3            : std_logic_vector(C_S_AXI_LITE_ADDR_WIDTH-1 downto 0) :=(others => '0');

signal lite_rdata_cdc_from           : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) :=(others => '0');
signal lite_rdata_d1_cdc_to        : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) :=(others => '0');
signal lite_rdata_d2        : std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0) :=(others => '0');

  --ATTRIBUTE async_reg OF ip_arvalid_d1_cdc_tig  : SIGNAL IS "true";
  --ATTRIBUTE async_reg OF ip_arvalid_d2  : SIGNAL IS "true";

  --ATTRIBUTE async_reg OF araddr_d1_cdc_tig  : SIGNAL IS "true";
  --ATTRIBUTE async_reg OF araddr_d2  : SIGNAL IS "true";

  --ATTRIBUTE async_reg OF lite_rdata_d1_cdc_to : SIGNAL IS "true";
  --ATTRIBUTE async_reg OF lite_rdata_d2  : SIGNAL IS "true";

signal p_pulse_s_h          : std_logic := '0';
signal p_pulse_s_h_clr      : std_logic := '0';
signal s_pulse_d1           : std_logic := '0';
signal s_pulse_d2           : std_logic := '0';
signal s_pulse_d3           : std_logic := '0';
signal s_pulse_re           : std_logic := '0';

signal p_pulse_re_d1        : std_logic := '0';
signal p_pulse_re_d2        : std_logic := '0';
signal p_pulse_re_d3        : std_logic := '0';

signal arready_d1           : std_logic := '0'; -- CR605883
signal arready_d2           : std_logic := '0'; -- CR605883
signal arready_d3           : std_logic := '0'; -- CR605883
signal arready_d4           : std_logic := '0'; -- CR605883
signal arready_d5           : std_logic := '0'; -- CR605883
signal arready_d6           : std_logic := '0'; -- CR605883
signal arready_d7           : std_logic := '0'; -- CR605883
signal arready_d8           : std_logic := '0'; -- CR605883
signal arready_d9           : std_logic := '0'; -- CR605883
signal arready_d10           : std_logic := '0'; -- CR605883
signal arready_d11           : std_logic := '0'; -- CR605883
signal arready_d12           : std_logic := '0'; -- CR605883

begin

    -- CR607165
    -- Flag to prevent overlapping reads
    RD_PROGRESS : process(s_axi_lite_aclk)
        begin
            if(s_axi_lite_aclk'EVENT and s_axi_lite_aclk = '1')then
                if(s_axi_lite_aresetn = '0' or rst_rvalid_re = '1')then
                    read_in_progress <= '0';

                elsif(arvalid_re = '1')then
                    read_in_progress <= '1';
                end if;
            end if;
        end process RD_PROGRESS;


    -- Double register address in
REG_RADDR_TO_IPCLK : entity  lib_cdc_v1_0_2.cdc_sync
    generic map (
        C_CDC_TYPE                 => 1,
        C_RESET_STATE              => 0,
        C_SINGLE_BIT               => 0,
        C_VECTOR_WIDTH             => C_S_AXI_LITE_ADDR_WIDTH,
        C_MTBF_STAGES              => MTBF_STAGES
    )
    port map (
        prmry_aclk                 => s_axi_lite_aclk,
        prmry_resetn               => '0',
        prmry_in                   => '0',
        prmry_vect_in              => s_axi_lite_araddr,
        
        scndry_aclk                => ip2axi_aclk,
        scndry_resetn              => '0',
        scndry_out                 => open,
        scndry_vect_out            => araddr_d3
    );


--    REG_RADDR_TO_IPCLK : process(ip2axi_aclk)
--        begin
--            if(ip2axi_aclk'EVENT and ip2axi_aclk = '1')then
--                if(ip2axi_aresetn = '0')then
--                    araddr_d1_cdc_tig           <= (others => '0');
--                    araddr_d2           <= (others => '0');
--                    araddr_d3           <= (others => '0');
--                else
--                    araddr_d1_cdc_tig   <= s_axi_lite_araddr;
--                    araddr_d2           <= araddr_d1_cdc_tig;
--                    araddr_d3           <= araddr_d2;
--                end if;
--            end if;
--        end process REG_RADDR_TO_IPCLK;

    -- Latch and hold read address
    REG_ARADDR_PROCESS : process(ip2axi_aclk)
        begin
            if(ip2axi_aclk'EVENT and ip2axi_aclk = '1')then
                if(ip2axi_aresetn = '0')then
                    axi2ip_rdaddr_i <= (others => '0');
                elsif(ip_arvalid_re = '1')then
                    axi2ip_rdaddr_i <= araddr_d3;
                end if;
            end if;
        end process REG_ARADDR_PROCESS;

    axi2ip_rdaddr   <= axi2ip_rdaddr_i;

    -- Register awready into IP clock domain.  awready
    -- is a 1 axi_lite clock delay of the rising edge of
    -- arvalid.  This provides a signal that asserts when
    -- araddr is known to be stable.

REG_ARVALID_TO_IPCLK : entity  lib_cdc_v1_0_2.cdc_sync
    generic map (
        C_CDC_TYPE                 => 1,
        C_RESET_STATE              => 0,
        C_SINGLE_BIT               => 1,
        C_VECTOR_WIDTH             => C_S_AXI_LITE_ADDR_WIDTH,
        C_MTBF_STAGES              => MTBF_STAGES
    )
    port map (
        prmry_aclk                 => s_axi_lite_aclk,
        prmry_resetn               => '0',
        prmry_in                   => arready_i,
        prmry_vect_in              => (others => '0'),

        scndry_aclk                => ip2axi_aclk,
        scndry_resetn              => '0',
        scndry_out                 => ip_arvalid_d2,
        scndry_vect_out            => open
    );



    REG_ARVALID_TO_IPCLK1 : process(ip2axi_aclk)
        begin
            if(ip2axi_aclk'EVENT and ip2axi_aclk = '1')then
                if(ip2axi_aresetn = '0')then
--                    ip_arvalid_d1_cdc_tig <= '0';
--                    ip_arvalid_d2 <= '0';
                    ip_arvalid_d3 <= '0';
                else
--                    ip_arvalid_d1_cdc_tig <= arready_i;
--                    ip_arvalid_d2 <= ip_arvalid_d1_cdc_tig;
                    ip_arvalid_d3 <= ip_arvalid_d2;
                end if;
            end if;
        end process REG_ARVALID_TO_IPCLK1;

    ip_arvalid_re <= ip_arvalid_d2 and not ip_arvalid_d3;

    -------------------------------------------------------------------------------
    -- Generate Read CE's
    -------------------------------------------------------------------------------
    RDCE_GEN: for j in 0 to C_NUM_CE - 1 generate

    constant BAR    : std_logic_vector(CE_ADDR_SIZE-1 downto 0) :=
                    std_logic_vector(to_unsigned(j,CE_ADDR_SIZE));
    begin

      rdce(j) <= ip_arvalid_re
        when araddr_d3((CE_ADDR_SIZE + ADDR_OFFSET) - 1
                              downto ADDR_OFFSET)
             = BAR(CE_ADDR_SIZE-1 downto 0)
        else '0';

    end generate RDCE_GEN;

    -------------------------------------------------------------------------------
    -- Register RDCE and RD Data out to IP
    -------------------------------------------------------------------------------
    REG_RDCNTRL_OUT : process(ip2axi_aclk)
        begin
            if(ip2axi_aclk'EVENT and ip2axi_aclk = '1')then
                if(ip2axi_aresetn = '0')then
                    axi2ip_rdce     <= (others => '0');
                elsif(ip_arvalid_re = '1')then
                    axi2ip_rdce     <= rdce;
                else
                    axi2ip_rdce     <= (others => '0');
                end if;
            end if;
        end process REG_RDCNTRL_OUT;

    -- Generate sample and hold pulse to capture read data from IP
    REG_RVALID : process(ip2axi_aclk)
        begin
            if(ip2axi_aclk'EVENT and ip2axi_aclk = '1')then
                if(ip2axi_aresetn = '0')then
                    rvalid          <= '0';
                else
                    rvalid          <= ip_arvalid_re;
                end if;
            end if;
        end process REG_RVALID;

    -------------------------------------------------------------------------------
    -- Sample and hold read data from IP
    -------------------------------------------------------------------------------
    S_H_READ_DATA : process(ip2axi_aclk)
        begin
            if(ip2axi_aclk'EVENT and ip2axi_aclk = '1')then
                if(ip2axi_aresetn = '0')then
                    lite_rdata_cdc_from    <= (others => '0');

                -- If read cycle then assert rvalid and rdata out to target
                elsif(rvalid = '1')then
                    lite_rdata_cdc_from    <= ip2axi_rddata;

                end if;
            end if;
        end process S_H_READ_DATA;

    -- Cross read data to axi_lite clock domain
REG_DATA2LITE_CLOCK : entity  lib_cdc_v1_0_2.cdc_sync
    generic map (
        C_CDC_TYPE                 => 1,
        C_RESET_STATE              => 0,
        C_SINGLE_BIT               => 0,
        C_VECTOR_WIDTH             => 32,
        C_MTBF_STAGES              => MTBF_STAGES
    )
    port map (
        prmry_aclk                 => ip2axi_aclk,
        prmry_resetn               => '0',
        prmry_in                   => '0', --lite_rdata_cdc_from,
        prmry_vect_in              => lite_rdata_cdc_from,

        scndry_aclk                => s_axi_lite_aclk,
        scndry_resetn              => '0',
        scndry_out                 => open, --lite_rdata_d2,
        scndry_vect_out            => lite_rdata_d2
    );

--    REG_DATA2LITE_CLOCK : process(s_axi_lite_aclk)
--        begin
--            if(s_axi_lite_aclk'EVENT and s_axi_lite_aclk = '1')then
--                if(s_axi_lite_aresetn = '0')then
--                    lite_rdata_d1_cdc_to   <= (others => '0');
--                    lite_rdata_d2   <= (others => '0');
--                else
--                    lite_rdata_d1_cdc_to   <= lite_rdata_cdc_from;
--                    lite_rdata_d2   <= lite_rdata_d1_cdc_to;
--                end if;
--            end if;
--        end process REG_DATA2LITE_CLOCK;



    -- CR605883 (CDC) modified to remove
    -- Because axi_lite_aclk must be less than or equal to ip2axi_aclk
    -- then read data will appear a maximum 6 clocks from assertion
    -- of arready.
    REG_ALIGN_RDATA_LATCH : process(s_axi_lite_aclk)
        begin
            if(s_axi_lite_aclk'EVENT and s_axi_lite_aclk = '1')then
                if(s_axi_lite_aresetn = '0')then
                    arready_d1 <= '0';
                    arready_d2 <= '0';
                    arready_d3 <= '0';
                    arready_d4 <= '0';
                    arready_d5 <= '0';
                    arready_d6 <= '0';
                    arready_d7 <= '0';
                    arready_d8 <= '0';
                    arready_d9 <= '0';
                    arready_d10 <= '0';
                    arready_d11 <= '0';
                    arready_d12 <= '0';
                else
                    arready_d1 <= arready_i;
                    arready_d2 <= arready_d1;
                    arready_d3 <= arready_d2;
                    arready_d4 <= arready_d3;
                    arready_d5 <= arready_d4;
                    arready_d6 <= arready_d5;
                    arready_d7 <= arready_d6;
                    arready_d8 <= arready_d7;
                    arready_d9 <= arready_d8;
                    arready_d10 <= arready_d9;
                    arready_d11 <= arready_d10;
                    arready_d12 <= arready_d11;
                end if;
            end if;
        end process REG_ALIGN_RDATA_LATCH;

    -------------------------------------------------------------------------------
    -- Drive read data and read data valid out on capture of valid address.
    -------------------------------------------------------------------------------
    REG_RD_OUT : process(s_axi_lite_aclk)
        begin
            if(s_axi_lite_aclk'EVENT and s_axi_lite_aclk = '1')then
                if(s_axi_lite_aresetn = '0')then
                    s_axi_lite_rdata    <= (others => '0');
                    s_axi_lite_rvalid_i <= '0';
                    rst_rvalid_re       <= '0';                 -- CR576999

                -- If rvalid driving out to target and target indicates ready
                -- then de-assert rvalid. (structure guarentees min 1 clock of rvalid)
                elsif(s_axi_lite_rvalid_i = '1' and s_axi_lite_rready = '1')then
                    s_axi_lite_rdata    <= (others => '0');
                    s_axi_lite_rvalid_i <= '0';
                    rst_rvalid_re       <= '0';                 -- CR576999

                -- If read cycle then assert rvalid and rdata out to target
                -- CR605883
                --elsif(s_pulse_re = '1')then
                elsif(arready_d12 = '1')then
                    s_axi_lite_rdata    <= lite_rdata_d2;
                    s_axi_lite_rvalid_i <= '1';
                    rst_rvalid_re       <= '1';                 -- CR576999

                end if;
            end if;
        end process REG_RD_OUT;


end generate GEN_ASYNC_READ;

end implementation;



