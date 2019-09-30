--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:28:45 09/30/2019
-- Design Name:   
-- Module Name:   E:/Display/testdisplay.vhd
-- Project Name:  Display
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: command_display
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
USE ieee.std_logic_arith.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY testdisplay IS
END testdisplay;
 
ARCHITECTURE behavior OF testdisplay IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT command_display
    PORT(
         DI : IN  std_logic_vector(3 downto 0);
         Segments : OUT  std_logic_vector(6 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal DI : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal Segments : std_logic_vector(6 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: command_display PORT MAP (
          DI => DI,
          Segments => Segments
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;
			for i in 0 to 15 loop
				DI <= CONV_STD_LOGIC_VECTOR(i, 4);
				wait for 100 ns;
			end loop;
		wait;
   end process;

END;
