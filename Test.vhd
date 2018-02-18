--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:08:19 06/19/2017
-- Design Name:   
-- Module Name:   D:/shudianzuoye4/bcy/test_tb.vhd
-- Project Name:  bcy
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: test
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_tb IS
END test_tb;
 
ARCHITECTURE behavior OF test_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT test
    PORT(
         CP : IN  std_logic;
         RESET : IN  std_logic;
         START : IN  std_logic;
         DX : IN  std_logic_vector(3 downto 0);
         DY : IN  std_logic_vector(3 downto 0);
         P : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CP : std_logic := '0';
   signal RESET : std_logic := '0';
   signal START : std_logic := '0';
   signal DX : std_logic_vector(3 downto 0) := (others => '0');
   signal DY : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal P : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace CP below with 
   -- appropriate port name 
 
   constant CP_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: test PORT MAP (
          CP => CP,
          RESET => RESET,
          START => START,
          DX => DX,
          DY => DY,
          P => P
        );

   -- Clock process definitions
   CP_process :process
   begin
		CP <= '0';
		wait for 1 ns;
		CP <= '1';
		wait for 1 ns;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      RESET <= '1';
      wait for 2 ns;
		RESET <= '0';
		DX <= "1101";
		DY <= "1010";
		START <= '1';
		wait for 2 ns;
		START <= '0';
		wait for 100 ns;
		DX <= "0101";
		DY <= "1010";
		START <= '1';
		wait for 2 ns;
		START <= '0';
		wait;
   end process;

END;