----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:07:35 06/18/2017 
-- Design Name: 
-- Module Name:    test - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test is
    Port ( CP : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           START : in  STD_LOGIC;
           DX : in  STD_LOGIC_VECTOR (3 downto 0);
           DY : in  STD_LOGIC_VECTOR (3 downto 0);
           P : out  STD_LOGIC_VECTOR (7 downto 0));
end test;

architecture Behavioral of test is
signal V0: STD_LOGIC;
signal V1: STD_LOGIC;
signal V2: STD_LOGIC;
signal INI: STD_LOGIC;
signal ADD: STD_LOGIC;
signal SHIFT: STD_LOGIC;
signal ASSIGN1: STD_LOGIC;
type state is (T0,T1,T2,T3,T4);
signal current_state,next_state: state;
signal A:STD_LOGIC_VECTOR (7 downto 0):=(others => '0');
signal M:STD_LOGIC_VECTOR (7 downto 0):=(others => '0');
signal Q:STD_LOGIC_VECTOR (3 downto 0):=(others => '0');
signal Z:STD_LOGIC_VECTOR (7 downto 0):=(others => '0');

begin
V0 <= START;

control_seq:process(CP,RESET)
	begin
		if RESET='1' then current_state<=T0;
		elsif rising_edge(CP) then 
			current_state<=next_state;
		end if;
	end process control_seq;

control_com:process(current_state,V0,V1,V2)
begin
	INI<='0';
	ADD<='0';
	SHIFT<='0';
	ASSIGN1<='0';
	case current_state is
	when T0 => if V0='1' then next_state <= T1;
					else next_state <= T0;
					end if;
		  INI<='1';
	when T1 => if (V1='1') then next_state<=T4;end if;
				  if (V1='0') AND (V2='1') then next_state <= T2; end if;
				  if (V1='0') AND (V2='0') then next_state <= T3; end if;
	when T2 => next_state<=T3;
			ADD <= '1';
	when T3 => next_state <= T1;
			SHIFT <= '1';
	when T4 => next_state <= T0;
			ASSIGN1<='1';
	end case;
end process control_com;

dataprocess:process(CP,INI,ADD,SHIFT,ASSIGN1)
begin
	if rising_edge(CP) then
		if INI = '1' then
			M <= "0000"&DX;
			Q <= DY;
			A <= (others =>'0');
		end if;
		if ADD = '1' then
			A <= A+M;
		end if;
		if SHIFT = '1' then
			Q(3 downto 0) <= '0'&Q(3 downto 1);
			M(7 downto 0) <= M(6 downto 0)&'0';
		end if;
		if ASSIGN1 = '1' then 
			Z <= A;
		end if;
	end if;
end process dataprocess;

V1 <= '1' when Q ="0000" else '0';
V2 <= Q(0);
P<=Z;
	
end Behavioral;