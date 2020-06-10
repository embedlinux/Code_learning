-- ************************************************************************
-- *  NOVAS SOFTWARE CONFIDENTIAL PROPRIETARY NOTE                        *
-- *                                                                      *
-- *  This software contains information confidential and proprietary     *
-- *  to Novas Software Inc. It shall not be reproduced in whole          *
-- *  or in part or transferred to other documents, or disclosed          *
-- *  to third parties, or used for any purpose other than that           *
-- *  for which it was obtained, without the prior written consent        *
-- *  of Novas Software Inc.                                              *
-- *  (c) 1996, 1997 Novas Software Inc.                                  *
-- *  All rights reserved                                                 *
-- *                                                                      *
-- ************************************************************************

--   Debussy tutorial case: A simplified microprogramming-based CPU
--   file name: ALUB.v
--   description: this part performs the arithmetic and login funtion
--                on the operands of internal data bus(IDB)
--                IR: instruction register (from CCU)
--                IDB: internal data bus (from PCU)
--                PC: program counter (from PCU)
--                C: timing control (from CCU,12-bits)
--                clock: system clock
--                reset: system reset
--                S1: program counter control (to PCU)
--                ALU: ALU output data (to PCU)
--                IXR: index register (to PCU)
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

package vec_pkg is
 
    type std_vec_type is record
        one_bit   : std_logic;
        two_bit   : std_logic_vector(1 downto 0);
	three_bit : std_logic_vector(2 downto 0);
        four_bit  : std_logic_vector(3 downto 0);
        five_bit  : std_logic_vector(4 downto 0);
        six_bit   : std_logic_vector(5 downto 0);
        seven_bit : std_logic_vector(6 downto 0);
        eight_bit : std_logic_vector(7 downto 0);
        nine_bit  : std_logic_vector(8 downto 0);
        ten_bit   : std_logic_vector(9 downto 0);
    end record;
 
end;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use work.vec_pkg.all;

entity PCU is
  port (
    mux_sel : in std_logic_vector(2 downto 0);
    C6 : in std_logic;
    C5 : in std_logic;
    C1 : in std_logic;
    ALU : in std_logic_vector(7 downto 0);
    S1 : in std_logic;
    IXR : in std_logic_vector(7 downto 0);
    reset : in std_logic;
    data : inout std_logic_vector(7 downto 0);
    PC : out std_logic_vector(7 downto 0);
    IDB : out std_logic_vector(7 downto 0);
    TDB : out std_logic_vector(7 downto 0);
    error_in : in std_logic
  );
end PCU;

architecture PCU of PCU is
signal pcu_din  : std_vec_type;
signal pcu_dout : std_vec_type;
signal n_q0     : std_logic_vector(7 downto 0);
signal n_q2     : std_logic_vector(7 downto 0);
signal n_clk1   : std_logic;
signal TDB0     : std_logic_vector(7 downto 0);
signal clk_en1  : std_logic;
-- signal dout0    : std_logic;
signal n_PC0    : std_logic_vector(7 downto 0);
signal i_dff_creg_l, i_dff_nreg_l : std_logic_vector(7 downto 0);
signal i_dff0_creg_l, i_dff0_nreg_l : std_logic_vector(7 downto 0);
signal i_dff1_creg_l, i_dff1_nreg_l : std_logic_vector(7 downto 0);


begin
  PC <= n_PC0;
 IDB <= pcu_dout.eight_bit;
 TDB <= pcu_din.eight_bit;
 clk_en1 <='1';


--Tri-state buffer
 process (C1)
 begin
        if (C1 = '1' or C1 = 'H') then
                data <= (others => 'Z');
        else
                data <= n_q0;
        end if;
 end process;


 process (n_q0, n_PC0, n_q2, ALU, IXR, mux_sel)
 begin
        case mux_sel is
        when "000"|"00L"|"0L0"|"0LL"|"L00"|"L0L"|"LL0"|"LLL" => pcu_dout.eight_bit <= n_q0;
        when "001"|"00H"|"0L1"|"0LH"|"L01"|"L0H"|"LL1"|"LLH" => pcu_dout.eight_bit <= n_PC0;
        when "010"|"01L"|"0H0"|"0HL"|"L10"|"L1L"|"LH0"|"LHL" => pcu_dout.eight_bit <= n_q2;
        when "011"|"01H"|"0H1"|"0HH"|"L11"|"L1H"|"LH1"|"LHH" => pcu_dout.eight_bit <= ALU;
        when "100"|"10L"|"1L0"|"1LL"|"H00"|"H0L"|"HL0"|"HLL" => pcu_dout.eight_bit <= IXR;
        when "101"|"10H"|"1L1"|"1LH"|"H01"|"H0H"|"HL1"|"HLH" => pcu_dout.eight_bit <= "00000000";
        when "110"|"11L"|"1H0"|"1HL"|"H10"|"H1L"|"HH0"|"HHL" => pcu_dout.eight_bit <= "00000000";
        when "111"|"11H"|"1H1"|"1HH"|"H11"|"H1H"|"HH1"|"HHH" => pcu_dout.eight_bit <= "00000000";
        when others => pcu_dout.eight_bit <= (others => 'X');
        end case;
 end process;

 process (pcu_dout.eight_bit, pcu_din.eight_bit, C1)
 begin
        case C1 is
        when '0'|'L' => TDB0 <= pcu_dout.eight_bit after 1 ns;
        when '1'|'H' => TDB0 <= pcu_din.eight_bit after 1 ns;
        when others => TDB0 <= (others => 'X') after 1 ns;
        end case;
 end process;


 process (C5, reset)
 begin
 if (reset ='0') then
        n_q0 <= "00000000";
 elsif (falling_edge(C5)) then
        n_q0 <= TDB0;
 end if;
 end process;

 process (S1, reset)
 begin
 if (reset ='0') then
        n_PC0 <= "00000000";
 elsif (falling_edge(S1)) then
        n_PC0 <= ALU;
 end if;
 end process;

 process (n_clk1, reset)
 begin
 if (reset ='0') then
        n_q2 <= "00000000";
 elsif (rising_edge(n_clk1)) then
        n_q2 <= ALU;
 end if;
 end process;

 n_clk1 <= not(C6);

 pcu_dout.one_bit <= error_in and clk_en1;
 process (C1, pcu_dout.one_bit, data)
 begin
        if (pcu_dout.one_bit = '1' or pcu_dout.one_bit = 'H') then
                pcu_din.eight_bit <= "00000000";
        elsif (pcu_dout.one_bit = '0' or pcu_dout.one_bit = 'L') then
                if (C1 = '1' or C1 = 'H') then
                        pcu_din.eight_bit <= data;
                end if;
        else
                pcu_din.eight_bit <= (others => 'X');
        end if;
 end process;
end PCU;
