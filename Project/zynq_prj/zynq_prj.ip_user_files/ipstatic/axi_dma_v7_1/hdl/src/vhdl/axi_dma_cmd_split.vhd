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
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;


library unisim;
use unisim.vcomponents.all;

library lib_cdc_v1_0_2;

library axi_dma_v7_1_8;
use axi_dma_v7_1_8.axi_dma_pkg.all;


 
entity axi_dma_cmd_split is
     generic (
             C_ADDR_WIDTH  : integer range 32 to 64    := 32;
             C_DM_STATUS_WIDTH               : integer range 8 to 32         := 8;
             C_INCLUDE_S2MM : integer range 0 to 1     := 0 
             );
     port (
           clock : in std_logic;
           sgresetn : in std_logic;
           clock_sec : in std_logic;
           aresetn : in std_logic;

   -- command coming from _MNGR 
           s_axis_cmd_tvalid : in std_logic;
           s_axis_cmd_tready : out std_logic;
           s_axis_cmd_tdata  : in std_logic_vector ((C_ADDR_WIDTH-32+2*32+CMD_BASE_WIDTH+46)-1 downto 0);

   -- split command to DM
           s_axis_cmd_tvalid_s : out std_logic;
           s_axis_cmd_tready_s : in std_logic;
           s_axis_cmd_tdata_s  : out std_logic_vector ((C_ADDR_WIDTH+CMD_BASE_WIDTH+8)-1 downto 0);
   -- Tvalid from Datamover
           tvalid_from_datamover    : in std_logic;
           status_in                : in std_logic_vector (C_DM_STATUS_WIDTH-1 downto 0);
           tvalid_unsplit           : out std_logic;
           status_out               : out std_logic_vector (C_DM_STATUS_WIDTH-1 downto 0);

   -- Tlast of stream data from Datamover
           tlast_stream_data        : in std_logic;
           tready_stream_data        : in std_logic;
           tlast_unsplit            : out std_logic;  
           tlast_unsplit_user       : out std_logic  

          );
end entity axi_dma_cmd_split;

architecture implementation of axi_dma_cmd_split is
  attribute DowngradeIPIdentifiedWarnings: string;
  attribute DowngradeIPIdentifiedWarnings of implementation : architecture is "yes";


type SPLIT_MM2S_STATE_TYPE      is (
                                IDLE,
                                SEND,
                                SPLIT
                                );

signal mm2s_cs                  : SPLIT_MM2S_STATE_TYPE;
signal mm2s_ns                  : SPLIT_MM2S_STATE_TYPE;

signal mm2s_cmd    : std_logic_vector (C_ADDR_WIDTH-32+2*32+CMD_BASE_WIDTH+46-1 downto 0);
signal command_ns    : std_logic_vector (C_ADDR_WIDTH-32+2*32+CMD_BASE_WIDTH-1 downto 0);
signal command    : std_logic_vector (C_ADDR_WIDTH-32+2*32+CMD_BASE_WIDTH-1 downto 0);

signal cache_info  : std_logic_vector (31 downto 0);
signal vsize_data  : std_logic_vector (22 downto 0);
signal vsize_data_int  : std_logic_vector (22 downto 0);
signal vsize       : std_logic_vector (22 downto 0);
signal counter     : std_logic_vector (22 downto 0);
signal counter_tlast     : std_logic_vector (22 downto 0);
signal split_cmd   : std_logic_vector (31+(C_ADDR_WIDTH-32) downto 0);
signal stride_data : std_logic_vector (22 downto 0);
signal vsize_over   : std_logic;

signal cmd_proc_cdc_from    : std_logic;
signal cmd_proc_cdc_to    : std_logic;
signal cmd_proc_cdc    : std_logic;
signal cmd_proc_ns    : std_logic;
  ATTRIBUTE async_reg                      : STRING;
--  ATTRIBUTE async_reg OF cmd_proc_cdc_to  : SIGNAL IS "true";
--  ATTRIBUTE async_reg OF cmd_proc_cdc  : SIGNAL IS "true";


signal cmd_out    : std_logic;
signal cmd_out_ns    : std_logic;

signal split_out    : std_logic;
signal split_out_ns    : std_logic;

signal command_valid : std_logic;
signal command_valid_ns : std_logic;
signal command_ready : std_logic;
signal reset_lock : std_logic;
signal reset_lock_tlast : std_logic;


signal tvalid_unsplit_int : std_logic;
signal tlast_stream_data_int : std_logic;

signal ready_for_next_cmd : std_logic;
signal ready_for_next_cmd_tlast : std_logic;
signal ready_for_next_cmd_tlast_cdc_from : std_logic;
signal ready_for_next_cmd_tlast_cdc_to : std_logic;
signal ready_for_next_cmd_tlast_cdc : std_logic;

--  ATTRIBUTE async_reg OF ready_for_next_cmd_tlast_cdc_to  : SIGNAL IS "true";
--  ATTRIBUTE async_reg OF ready_for_next_cmd_tlast_cdc  : SIGNAL IS "true";

signal tmp1, tmp2, tmp3, tmp4 : std_logic;
signal tlast_int : std_logic;

signal eof_bit : std_logic;
signal eof_bit_cdc_from : std_logic;
signal eof_bit_cdc_to : std_logic;
signal eof_bit_cdc : std_logic;
signal eof_set : std_logic;
signal over_ns, over : std_logic;

signal cmd_in : std_logic;

signal status_out_int : std_logic_vector (C_DM_STATUS_WIDTH-1 downto 0);

begin

s_axis_cmd_tvalid_s <= command_valid;
command_ready <= s_axis_cmd_tready_s;
s_axis_cmd_tdata_s <= command (103+(C_ADDR_WIDTH-32) downto 96+(C_ADDR_WIDTH-32)) & command (71+(C_ADDR_WIDTH-32) downto 0);


REGISTER_STATE_MM2S : process(clock)
    begin
        if(clock'EVENT and clock = '1')then
            if(sgresetn = '0')then
                mm2s_cs     <= IDLE;
                cmd_proc_cdc_from <= '0';
                cmd_out <= '0';
                command <= (others => '0');
                command_valid <= '0';
                split_out <= '0';
                over <= '0';
            else
                mm2s_cs     <= mm2s_ns;
                cmd_proc_cdc_from <= cmd_proc_ns;
                cmd_out <= cmd_out_ns;
                command <= command_ns;
                command_valid <= command_valid_ns;
                split_out <= split_out_ns;
                over <= over_ns;
            end if;
        end if;
    end process REGISTER_STATE_MM2S;


-- grab the MM2S command coming from MM2S_mngr
REGISTER_MM2S_CMD : process(clock)
    begin
        if(clock'EVENT and clock = '1')then
            if(sgresetn = '0')then
                mm2s_cmd <= (others => '0');
                s_axis_cmd_tready <= '0';
                cache_info <= (others => '0');
                vsize_data <= (others => '0');
                vsize_data_int <= (others => '0');
                stride_data <= (others => '0');
                eof_bit_cdc_from <= '0';
                cmd_in <= '0';
            elsif (s_axis_cmd_tvalid = '1' and ready_for_next_cmd = '1' and cmd_proc_cdc_from = '0' and ready_for_next_cmd_tlast_cdc = '1') then  -- when there is no processing being done, means it is ready to accept
                mm2s_cmd     <= s_axis_cmd_tdata;
                s_axis_cmd_tready <= '1';
                cache_info <= s_axis_cmd_tdata (149+(C_ADDR_WIDTH-32) downto 118+(C_ADDR_WIDTH-32));
                vsize_data <= s_axis_cmd_tdata (117+(C_ADDR_WIDTH-32) downto 95+(C_ADDR_WIDTH-32));
                vsize_data_int <= s_axis_cmd_tdata (117+(C_ADDR_WIDTH-32) downto 95+(C_ADDR_WIDTH-32)) - '1';
                stride_data <= s_axis_cmd_tdata (94+(C_ADDR_WIDTH-32) downto 72+(C_ADDR_WIDTH-32));
                eof_bit_cdc_from <= s_axis_cmd_tdata (30);
                cmd_in <= '1';
            else
                mm2s_cmd     <= mm2s_cmd; --split_cmd;
                vsize_data   <= vsize_data;
                vsize_data_int   <= vsize_data_int;
                stride_data   <= stride_data;
                cache_info <= cache_info;
                s_axis_cmd_tready <= '0';
                eof_bit_cdc_from <= eof_bit_cdc_from;
                cmd_in <= '0';
            end if;
        end if;
    end process REGISTER_MM2S_CMD;


REGISTER_DECR_VSIZE : process(clock)
    begin
        if(clock'EVENT and clock = '1')then
            if(sgresetn = '0')then
                vsize <= "00000000000000000000000";
            elsif (command_valid = '1' and command_ready = '1' and (vsize < vsize_data_int)) then  -- sending a cmd out to DM
                vsize <= vsize + '1';
            elsif (cmd_proc_cdc_from = '0') then  -- idle or when all cmd are sent to DM
                vsize <= "00000000000000000000000";
            else 
                vsize <= vsize;    
            end if;
        end if;
    end process REGISTER_DECR_VSIZE;

    vsize_over <= '1' when (vsize = vsize_data_int) else '0';
  --  eof_set <= eof_bit when (vsize = vsize_data_int) else '0';


 REGISTER_SPLIT : process(clock)
     begin
         if(clock'EVENT and clock = '1')then
             if(sgresetn = '0')then
                 split_cmd <= (others => '0');
             elsif (s_axis_cmd_tvalid = '1' and cmd_proc_cdc_from = '0' and ready_for_next_cmd = '1' and ready_for_next_cmd_tlast_cdc = '1') then
                 split_cmd <= s_axis_cmd_tdata (63+(C_ADDR_WIDTH-32) downto 32);          -- capture the ba when a new cmd arrives
             elsif (split_out = '1') then  -- add stride to previous ba
                 split_cmd <= split_cmd + stride_data;
             else 
                 split_cmd <= split_cmd;
             end if;

         end if;
     end process REGISTER_SPLIT;



MM2S_MACHINE : process(mm2s_cs,
                       s_axis_cmd_tvalid,
                       cmd_proc_cdc_from, 
                       vsize_over, command_ready,
                       cache_info, mm2s_cmd,
                       split_cmd, eof_set,
                       cmd_in, command
                       )
    begin
         over_ns <= '0'; 
                       cmd_proc_ns <= '0';      -- ready to receive new command 
                       split_out_ns <= '0';
                       command_valid_ns <= '0';
         mm2s_ns <= mm2s_cs;
         command_ns <= command;  
        -- Default signal assignment
        case mm2s_cs is

            -------------------------------------------------------------------
            when IDLE => 
                       command_ns <=  cache_info & mm2s_cmd (72+(C_ADDR_WIDTH-32) downto 65+(C_ADDR_WIDTH-32)) & split_cmd & mm2s_cmd (31) & eof_set & mm2s_cmd (29 downto 0); -- buf length remains the same
                  --     command_ns <=  cache_info & mm2s_cmd (72 downto 65) & split_cmd & mm2s_cmd (31 downto 0); -- buf length remains the same
                   if (cmd_in = '1' and cmd_proc_cdc_from = '0') then
                       cmd_proc_ns <= '1';      -- new command has come in and i need to start processing
                       mm2s_ns <= SEND;
                       over_ns <= '0'; 
                       split_out_ns <= '1'; 
                       command_valid_ns <= '1';
                   else 
                       mm2s_ns <= IDLE; 
                       over_ns <= '0'; 
                       cmd_proc_ns <= '0';      -- ready to receive new command 
                       split_out_ns <= '0'; 
                       command_valid_ns <= '0';
                   end if;

            -------------------------------------------------------------------
            when SEND =>
                       cmd_out_ns <= '1';
                       command_ns <=  command;

                       if (vsize_over = '1' and command_ready = '1') then
                         mm2s_ns <= IDLE; 
                         cmd_proc_ns <= '1';
                         command_valid_ns <= '0';
                         split_out_ns <= '0'; 
                         over_ns <= '1'; 
                       elsif  (command_ready = '0') then --(command_valid = '1' and command_ready = '0') then
                         mm2s_ns <= SEND;
                         command_valid_ns <= '1';
                         cmd_proc_ns <= '1'; 
                         split_out_ns <= '0'; 
                         over_ns <= '0';
                       else 
                         mm2s_ns <= SPLIT;
                         command_valid_ns <= '0';
                         cmd_proc_ns <= '1';
                         over_ns <= '0'; 
                         split_out_ns <= '0'; 
                       end if;
                  
            -------------------------------------------------------------------
            when SPLIT =>
                         cmd_proc_ns <= '1';
                         mm2s_ns <= SEND; 
                         command_ns <=  cache_info & mm2s_cmd (72+(C_ADDR_WIDTH-32) downto 65+(C_ADDR_WIDTH-32)) & split_cmd & mm2s_cmd (31) & eof_set & mm2s_cmd (29 downto 0); -- buf length remains the same
        --                 command_ns <=  cache_info & mm2s_cmd (72 downto 65) & split_cmd & mm2s_cmd (31 downto 0); -- buf length remains the same
                         cmd_out_ns <= '0';
                         split_out_ns <= '1'; 
                         command_valid_ns <= '1';

            -------------------------------------------------------------------
          -- coverage off
            when others =>
                mm2s_ns <= IDLE;
          -- coverage on

        end case;
    end process MM2S_MACHINE;


SWALLOW_TVALID : process(clock)
    begin
        if(clock'EVENT and clock = '1')then
            if(sgresetn = '0')then
                counter <= (others => '0');
           --     tvalid_unsplit_int <= '0';
                reset_lock <= '1';
                ready_for_next_cmd <= '0';
            elsif (vsize_data_int = "00000000000000000000000") then
           --     tvalid_unsplit_int <= '0';
                ready_for_next_cmd <= '1';
                reset_lock <= '0';
            elsif ((tvalid_from_datamover = '1') and (counter < vsize_data_int)) then
                counter <= counter + '1';
           --     tvalid_unsplit_int <= '0';
                ready_for_next_cmd <= '0';
                reset_lock <= '0';
            elsif ((counter = vsize_data_int) and (reset_lock = '0') and (tvalid_from_datamover = '1')) then
                counter <= (others => '0');
          --      tvalid_unsplit_int <= '1';
                ready_for_next_cmd <= '1';
            else
                counter <= counter;
           --     tvalid_unsplit_int <= '0';
                if (cmd_proc_cdc_from = '1') then
                   ready_for_next_cmd <= '0';
                else
                   ready_for_next_cmd <= ready_for_next_cmd;
                end if;
            end if;
        end if;
    end process SWALLOW_TVALID;

                tvalid_unsplit_int <= tvalid_from_datamover when (counter = vsize_data_int) else '0'; --tvalid_unsplit_int;

SWALLOW_TDATA : process(clock)
    begin
        if(clock'EVENT and clock = '1')then
            if (sgresetn = '0' or cmd_in = '1') then
               tvalid_unsplit <= '0';
               status_out_int <= (others => '0');
            else
               tvalid_unsplit <= tvalid_unsplit_int;
               if (tvalid_from_datamover = '1') then 
                  status_out_int (C_DM_STATUS_WIDTH-2 downto 0) <= status_in (C_DM_STATUS_WIDTH-2 downto 0) or status_out_int (C_DM_STATUS_WIDTH-2 downto 0); 
               else
                  status_out_int <= status_out_int;
               end if;

               if (tvalid_unsplit_int = '1') then
                  status_out_int (C_DM_STATUS_WIDTH-1) <= status_in (C_DM_STATUS_WIDTH-1);
               end if;
            end if;
        end if;
    end process SWALLOW_TDATA;


        status_out <= status_out_int;

SWALLOW_TLAST_GEN : if C_INCLUDE_S2MM = 0 generate
begin


    eof_set <= '1'; --eof_bit when (vsize = vsize_data_int) else '0';

CDC_CMD_PROC1 : entity  lib_cdc_v1_0_2.cdc_sync
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
        prmry_in                   => cmd_proc_cdc_from,
        prmry_vect_in              => (others => '0'),

        scndry_aclk                => clock_sec,
        scndry_resetn              => '0',
        scndry_out                 => cmd_proc_cdc,
        scndry_vect_out            => open
    );

CDC_CMD_PROC2 : entity  lib_cdc_v1_0_2.cdc_sync
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
        prmry_in                   => eof_bit_cdc_from,
        prmry_vect_in              => (others => '0'),

        scndry_aclk                => clock_sec,
        scndry_resetn              => '0',
        scndry_out                 => eof_bit_cdc,
        scndry_vect_out            => open
    );


CDC_CMD_PROC : process (clock_sec)
   begin
        if (clock_sec'EVENT and clock_sec = '1') then
           if (aresetn = '0') then
--              cmd_proc_cdc_to <= '0';
--              cmd_proc_cdc <= '0';
--              eof_bit_cdc_to <= '0';
--              eof_bit_cdc <= '0';
              ready_for_next_cmd_tlast_cdc_from <= '0';
           else
--              cmd_proc_cdc_to <= cmd_proc_cdc_from;
--              cmd_proc_cdc <= cmd_proc_cdc_to;
--              eof_bit_cdc_to <= eof_bit_cdc_from;
--              eof_bit_cdc <= eof_bit_cdc_to;
              ready_for_next_cmd_tlast_cdc_from <= ready_for_next_cmd_tlast;
           end if;
        end if;
end process CDC_CMD_PROC;

CDC_CMDTLAST_PROC : entity  lib_cdc_v1_0_2.cdc_sync
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
        prmry_in                   => ready_for_next_cmd_tlast_cdc_from,
        prmry_vect_in              => (others => '0'),

        scndry_aclk                => clock,
        scndry_resetn              => '0',
        scndry_out                 => ready_for_next_cmd_tlast_cdc,
        scndry_vect_out            => open
    );

--CDC_CMDTLAST_PROC : process (clock)
--   begin
--        if (clock'EVENT and clock = '1') then
--           if (sgresetn = '0') then
--              ready_for_next_cmd_tlast_cdc_to <= '0';
--              ready_for_next_cmd_tlast_cdc <= '0';
--           else
--              ready_for_next_cmd_tlast_cdc_to <= ready_for_next_cmd_tlast_cdc_from;
--              ready_for_next_cmd_tlast_cdc <= ready_for_next_cmd_tlast_cdc_to;
--           end if;
--         end if;  
--end process CDC_CMDTLAST_PROC;

SWALLOW_TLAST : process(clock_sec)
    begin
        if(clock_sec'EVENT and clock_sec = '1')then
            if(aresetn = '0')then
                counter_tlast <= (others => '0');
                tlast_stream_data_int <= '0';
                reset_lock_tlast <= '1';
                ready_for_next_cmd_tlast <= '1';
            elsif ((tlast_stream_data = '1' and tready_stream_data = '1') and vsize_data_int = "00000000000000000000000") then
                tlast_stream_data_int <= '0';
                ready_for_next_cmd_tlast <= '1';
                reset_lock_tlast <= '0';
            elsif ((tlast_stream_data = '1' and tready_stream_data = '1') and (counter_tlast < vsize_data_int)) then
                counter_tlast <= counter_tlast + '1';
                tlast_stream_data_int <= '0';
                ready_for_next_cmd_tlast <= '0';
                reset_lock_tlast <= '0';
            elsif ((counter_tlast = vsize_data_int) and (reset_lock_tlast = '0') and (tlast_stream_data = '1' and tready_stream_data = '1')) then
                counter_tlast <= (others => '0');
                tlast_stream_data_int <= '1';
                ready_for_next_cmd_tlast <= '1';
            else
                counter_tlast <= counter_tlast;
                tlast_stream_data_int <= '0';
                if (cmd_proc_cdc = '1') then
                   ready_for_next_cmd_tlast <= '0';
                else
                   ready_for_next_cmd_tlast <= ready_for_next_cmd_tlast;
                end if;
            end if;
        end if;
    end process SWALLOW_TLAST;
                
          tlast_unsplit <= tlast_stream_data when (counter_tlast = vsize_data_int and eof_bit_cdc = '1') else '0';
          tlast_unsplit_user <= tlast_stream_data when (counter_tlast = vsize_data_int) else '0';
       --   tlast_unsplit <= tlast_stream_data; -- when (counter_tlast = vsize_data_int) else '0';


end generate SWALLOW_TLAST_GEN;

SWALLOW_TLAST_GEN_S2MM : if C_INCLUDE_S2MM = 1 generate
begin

    eof_set <= eof_bit_cdc_from;
ready_for_next_cmd_tlast_cdc <= '1';

end generate SWALLOW_TLAST_GEN_S2MM;


end implementation;
