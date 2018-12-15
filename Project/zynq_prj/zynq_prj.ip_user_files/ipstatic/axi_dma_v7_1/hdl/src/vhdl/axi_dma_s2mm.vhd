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
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;

library unisim;
use unisim.vcomponents.all;

library axi_dma_v7_1_8;
use axi_dma_v7_1_8.axi_dma_pkg.all;
library lib_fifo_v1_0_4;
use lib_fifo_v1_0_4.async_fifo_fg;

entity axi_dma_s2mm is
     generic (
             C_FAMILY : string := "virtex7"
             );
     port (
           clk_in      : in std_logic;
           sg_clk      : in std_logic;
           resetn      : in std_logic;
           reset_sg     : in std_logic;
           s2mm_tvalid : in std_logic;
           s2mm_tlast  : in std_logic;
           s2mm_tdest  : in std_logic_vector (4 downto 0);
           s2mm_tuser  : in std_logic_vector (3 downto 0);
           s2mm_tid  : in std_logic_vector (4 downto 0);
           s2mm_tready : in std_logic;
           desc_available : in std_logic;
       --    s2mm_eof       : in std_logic;
           s2mm_eof_det       : in std_logic_vector (1 downto 0);
           ch2_update_active : in std_logic;

           tdest_out       : out std_logic_vector (6 downto 0);  -- to select desc
           same_tdest      : out std_logic;  -- to select desc
-- to DM
           s2mm_desc_info  : out std_logic_vector (13 downto 0);
--           updt_cmpt       : out std_logic;
           s2mm_tvalid_out : out std_logic;
           s2mm_tlast_out  : out std_logic;
           s2mm_tready_out : out std_logic;
           s2mm_tdest_out  : out std_logic_vector (4 downto 0)
          );
end entity axi_dma_s2mm;

architecture implementation of axi_dma_s2mm is
  attribute DowngradeIPIdentifiedWarnings: string;
  attribute DowngradeIPIdentifiedWarnings of implementation : architecture is "yes";


signal first_data : std_logic;
signal first_stream : std_logic;
signal first_stream_del : std_logic;

signal last_received : std_logic;
signal first_received : std_logic;
signal first_received1 : std_logic;
signal open_window : std_logic;

signal tdest_out_int : std_logic_vector (6 downto 0);
signal fifo_wr : std_logic;

signal last_update_over_int : std_logic;
signal last_update_over_int1 : std_logic;
signal last_update_over : std_logic;

signal ch_updt_over_int : std_logic;

signal ch_updt_over_int_cdc_from : std_logic;
signal ch_updt_over_int_cdc_to : std_logic;
signal ch_updt_over_int_cdc_to1 : std_logic;
signal ch_updt_over_int_cdc_to2 : std_logic;
  -- Prevent x-propagation on clock-domain crossing register
  ATTRIBUTE async_reg                      : STRING;
  --ATTRIBUTE async_reg OF ch_updt_over_int_cdc_to  : SIGNAL IS "true";
  --ATTRIBUTE async_reg OF ch_updt_over_int_cdc_to1  : SIGNAL IS "true";


signal fifo_rd : std_logic;
signal first_read : std_logic;
signal first_rd_en : std_logic;
signal fifo_rd_int : std_logic;
signal first_read_int : std_logic;

signal fifo_empty : std_logic;
signal fifo_full : std_logic;
signal s2mm_desc_info_int : std_logic_vector (13 downto 0);

signal updt_cmpt : std_logic;
signal tdest_capture : std_logic_vector (4 downto 0);
signal noread : std_logic;

signal same_tdest_b2b : std_logic;
signal fifo_reset : std_logic;

begin


     process (sg_clk)
       begin
            if (sg_clk'event and sg_clk = '1') then
              if (reset_sg = '0') then
                ch_updt_over_int_cdc_from <= '0';
              else --if (sg_clk'event and sg_clk = '1') then
                ch_updt_over_int_cdc_from <= ch2_update_active;
              end if;
            end if;
     end process;

     process (clk_in)
       begin
            if (clk_in'event and clk_in = '1') then
              if (resetn = '0') then
               ch_updt_over_int_cdc_to <= '0';
               ch_updt_over_int_cdc_to1 <= '0';
               ch_updt_over_int_cdc_to2 <= '0';
              else --if (clk_in'event and clk_in = '1') then
               ch_updt_over_int_cdc_to <= ch_updt_over_int_cdc_from;
               ch_updt_over_int_cdc_to1 <= ch_updt_over_int_cdc_to;
               ch_updt_over_int_cdc_to2 <= ch_updt_over_int_cdc_to1;
              end if;
            end if;
     end process;

         updt_cmpt <= (not ch_updt_over_int_cdc_to1) and ch_updt_over_int_cdc_to2;

  --   process (sg_clk)
  --     begin
  --          if (resetn = '0') then
  --             ch_updt_over_int <= '0';
  --          elsif (sg_clk'event and sg_clk = '1') then
  --             ch_updt_over_int <= ch2_update_active;
  --          end if;
  --   end process;
  
     --    updt_cmpt <= (not ch2_update_active) and ch_updt_over_int;

     process (sg_clk)
       begin
          if (sg_clk'event and sg_clk = '1') then
            if (reset_sg = '0') then
               last_update_over_int <= '0';
               last_update_over_int1 <= '0';
                   noread <= '0'; 
         --   else --if (sg_clk'event and sg_clk = '1') then
                   last_update_over_int1 <= last_update_over_int; 
             elsif (s2mm_eof_det(1) = '1' and noread = '0') then
                   last_update_over_int <= '1';
                   noread <= '1'; 
             elsif (s2mm_eof_det(0) = '1') then
                   noread <= '0';
                   last_update_over_int <= '0'; 
             elsif (fifo_empty = '0') then -- (updt_cmpt = '1') then
                   last_update_over_int <= '0'; 
             else
                   last_update_over_int <= last_update_over_int; 
             end if; 
            end if;
      --    end if;
     end process;
 
        last_update_over <= (not last_update_over_int) and last_update_over_int1;

     process (sg_clk)
       begin
          if (sg_clk'event and sg_clk = '1') then
            if (reset_sg = '0') then
               fifo_rd_int <= '0';
               first_read <= '0';
       --     else --if (sg_clk'event and sg_clk = '1') then
            elsif (last_update_over_int = '1' and fifo_rd_int = '0') then
                   fifo_rd_int <= '1';
            else
                   fifo_rd_int <= '0';
            end if;
          end if; 
     end process;

     process (sg_clk)
       begin
          if (sg_clk'event and sg_clk = '1') then
            if (reset_sg = '0') then
               first_read_int <= '0';
            else --if (sg_clk'event and sg_clk = '1') then
                   first_read_int <= first_read;
            end if;
          end if;
     end process;

         first_rd_en <= first_read and (not first_read_int);
         fifo_rd <= last_update_over_int; --(fifo_rd_int or first_rd_en);


--     process (clk_in)
--       begin
--            if (resetn = '0') then
--                first_data <= '0';
--                first_stream_del <= '0';
--           elsif (clk_in'event and clk_in = '1') then
--               if (s2mm_tvalid = '1' and first_data = '0' and s2mm_tready = '1') then   -- no tlast
--                  first_data <= '1';         -- just after the system comes out of reset
--               end if;
--               first_stream_del <= first_stream;
--           end if;
--    end process;

            first_stream <= (s2mm_tvalid and (not first_data));  -- pulse when first stream comes after reset

     process (clk_in)
       begin
          if (clk_in'event and clk_in = '1') then
            if (resetn = '0') then
                first_received1 <= '0';
                first_stream_del <= '0';
            else --if (clk_in'event and clk_in = '1') then
                first_received1 <= first_received; --'0';
                first_stream_del <= first_stream;
            end if;
          end if;
     end process;

     process (clk_in)
       begin
          if (clk_in'event and clk_in = '1') then
            if (resetn = '0') then
                last_received <= '0';
                first_received <= '0';
                tdest_capture <= (others => '0'); 
                first_data <= '0';
        --    else --if (clk_in'event and clk_in = '1') then
            elsif (s2mm_tvalid = '1' and first_data = '0' and s2mm_tready = '1') then   -- first stream afetr reset
                   s2mm_desc_info_int <= s2mm_tuser & s2mm_tid & s2mm_tdest;
                   tdest_capture <= s2mm_tdest;  -- latching tdest on first beat
                   first_data <= '1';         -- just after the system comes out of reset
            elsif (s2mm_tlast = '1' and s2mm_tvalid = '1' and s2mm_tready = '1') then  -- catch for last beat 
                   last_received <= '1';         
                   first_received <= '0';
                   s2mm_desc_info_int <= s2mm_desc_info_int;
            elsif (last_received = '1' and s2mm_tvalid = '1' and s2mm_tready = '1') then -- catch for following first beat
                   last_received <= '0';
                   first_received <= '1';
                   tdest_capture <= s2mm_tdest;  -- latching tdest on first beat
                   s2mm_desc_info_int <= s2mm_tuser & s2mm_tid & s2mm_tdest;
            else
                   s2mm_desc_info_int <= s2mm_desc_info_int;
                   last_received <= last_received;
                   if (updt_cmpt = '1') then
                      first_received <= '0';
                   else
                      first_received <= first_received;  -- hold the first received until update comes for previous tlast
                   end if; 
            end if;
          end if;
     end process;

           fifo_wr <= first_stream_del or (first_received and not (first_received1)); -- writing the tdest,tuser,tid into FIFO





     process (clk_in)
       begin
          if (clk_in'event and clk_in = '1') then
            if (resetn = '0') then
                   tdest_out_int <= "0100000";
                   same_tdest_b2b <= '0';
        --    else --if (clk_in'event and clk_in = '1') then
            elsif (first_received = '1' or first_stream = '1') then
                   if (first_stream = '1') then    -- when first stream is received, capture the tdest
                      tdest_out_int (6) <= not tdest_out_int (6);  -- signifies a new stream has come
                      tdest_out_int (5 downto 0) <=  '0' & s2mm_tdest;
                      same_tdest_b2b <= '0';
                 --  elsif (updt_cmpt = '1' or (first_received = '1' and first_received1 = '0')) then    -- when subsequent streams are received, pass the latched value of tdest
                 --  elsif (first_received = '1' and first_received1 = '0') then    -- when subsequent streams are received, pass the latched value of tdest
                 -- Following change made to allow b2b same channel pkt
                   elsif ((first_received = '1' and first_received1 = '0') and (tdest_out_int (4 downto 0) /= tdest_capture)) then    -- when subsequent streams are received, pass the latched value of tdest
                      tdest_out_int (6) <= not tdest_out_int (6);
                      tdest_out_int (5 downto 0) <=  '0' & tdest_capture; --s2mm_tdest;
                   elsif (first_received = '1' and first_received1 = '0') then
                      same_tdest_b2b <= not (same_tdest_b2b);
                   end if;
             else
                   tdest_out_int <= tdest_out_int;
             end if;
          end if;
     end process;

           tdest_out <= tdest_out_int;
           same_tdest <= same_tdest_b2b;

     process (clk_in)
       begin
          if (clk_in'event and clk_in = '1') then
            if (resetn = '0') then
                open_window <= '0';
          --  else --if (clk_in'event and clk_in = '1') then
            elsif (desc_available = '1') then
                   open_window <= '1';
            elsif (s2mm_tlast = '1') then
                   open_window <= '0';
            else
                   open_window <= open_window;
            end if;
          end if;
     end process;


     process (clk_in)
       begin
          if (clk_in'event and clk_in = '1') then
            if (resetn = '0') then
                s2mm_tvalid_out <= '0';
                s2mm_tready_out <= '0';
                s2mm_tlast_out  <= '0';
                s2mm_tdest_out      <= "00000";
          --  else --if (clk_in'event and clk_in = '1') then
            elsif (open_window = '1') then
                s2mm_tvalid_out <= s2mm_tvalid;
                s2mm_tready_out <= s2mm_tready;
                s2mm_tlast_out  <= s2mm_tlast;
                s2mm_tdest_out  <= s2mm_tdest;
            else
                s2mm_tready_out <= '0';
                s2mm_tvalid_out <= '0';
                s2mm_tlast_out  <= '0';
                s2mm_tdest_out      <= "00000";
            end if;
          end if;
     end process;

    fifo_reset <= not (resetn);

--    s2mm_desc_info_int <= s2mm_tuser & s2mm_tid & s2mm_tdest;
    -- Following FIFO is used to store the Tuser, Tid and xCache info
    I_ASYNC_FIFOGEN_FIFO : entity lib_fifo_v1_0_4.async_fifo_fg
       generic map (
--          C_ALLOW_2N_DEPTH      =>  1,
          C_ALLOW_2N_DEPTH      =>  0,
          C_FAMILY              =>  C_FAMILY,
          C_DATA_WIDTH          =>  14,
          C_ENABLE_RLOCS        =>  0,
          C_FIFO_DEPTH          =>  31,
          C_HAS_ALMOST_EMPTY    =>  1,
          C_HAS_ALMOST_FULL     =>  1,
          C_HAS_RD_ACK          =>  1,
          C_HAS_RD_COUNT        =>  1,
          C_HAS_RD_ERR          =>  0,
          C_HAS_WR_ACK          =>  0,
          C_HAS_WR_COUNT        =>  1,
          C_HAS_WR_ERR          =>  0,
          C_RD_ACK_LOW          =>  0,
          C_RD_COUNT_WIDTH      =>  5,
          C_RD_ERR_LOW          =>  0,
          C_USE_BLOCKMEM        =>  0,
          C_WR_ACK_LOW          =>  0,
          C_WR_COUNT_WIDTH      =>  5,
          C_WR_ERR_LOW          =>  0,
          C_SYNCHRONIZER_STAGE  =>  C_FIFO_MTBF
    --      C_USE_EMBEDDED_REG    =>  1, -- 0 ;
    --      C_PRELOAD_REGS        =>  0, -- 0 ;
    --      C_PRELOAD_LATENCY     =>  1  -- 1 ;
         )
      port Map (
         Din                 =>  s2mm_desc_info_int,
         Wr_en               =>  fifo_wr,
         Wr_clk              =>  clk_in,
         Rd_en               =>  fifo_rd,
         Rd_clk              =>  sg_clk,
         Ainit               =>  fifo_reset,
         Dout                =>  s2mm_desc_info,
         Full                =>  fifo_Full,
         Empty               =>  fifo_empty,
         Almost_full         =>  open,
         Almost_empty        =>  open,
         Wr_count            =>  open,
         Rd_count            =>  open,
         Rd_ack              =>  open,
         Rd_err              =>  open,              -- Not used by axi_dma
         Wr_ack              =>  open,              -- Not used by axi_dma
         Wr_err              =>  open               -- Not used by axi_dma
        );



end implementation;
