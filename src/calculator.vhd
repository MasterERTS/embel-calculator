----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:13:59 09/30/2019 
-- Design Name: 
-- Module Name:    command_display - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity command_display is
    Port ( CLK : in STD_LOGIC ;
			  BP0 : in STD_LOGIC ;
			  BP1 : in STD_LOGIC ;
			  SW0 : in STD_LOGIC ;
			  SW1 : in STD_LOGIC ;
			  Digit : out  STD_LOGIC_VECTOR (3 downto 0);
           Segments : out  STD_LOGIC_VECTOR (6 downto 0));
end command_display;

architecture Behavioral of command_display is

signal Disp : std_logic_vector(1 DOWNTO 0);
signal DI : std_logic_vector(3 DOWNTO 0);
signal divFreq : std_logic_vector(6 downto 0);
-- signal divFreq2 : std_logic_vector(2 downto 0);
signal x : std_logic_vector(3 downto 0);
signal y : std_logic_vector(3 downto 0);
signal z1 : std_logic_vector(3 downto 0);
signal z10 : std_logic_vector(3 downto 0);
signal result : std_logic_vector(6 downto 0);

begin

process(CLK) 

begin
 
	if (rising_edge(CLK)) then
		if (divFreq = 99) then
			Disp <= Disp + 1;
			divFreq <= "0000000";
		else
			divFreq <= divFreq + 1;
		end if;
   end if;

end process;

process (Disp)

variable K : integer range 0 to 10;

begin

	-- Increment left digit every time we push BP0
	if (falling_edge(BP0)) then
		x <= x+1;
		if ( x = "1001" ) then
			x <= "0000";			
		end if;
	end if;
	
	-- Increment right digit every time we push BP1
	if (falling_edge(BP1)) then
		y <= y + 1;
		if ( y = "1001" ) then
			y <= "0000";
		end if;
	end if;
	
	-- Calculator
	if (SW0 = '0' and SW1 = '0') then
		-- ADDITION
		result <= ("000" & x) + ("000" & y);
		
	elsif (SW0 = '1' and SW1 = '0') then
    	-- SUBSTRACTION
		if (x >= y) then
			z1 <= x - y;
			z10 <= "1111";
		else
			z1 <= y - x;
			z10 <= "1101";
		end if;
	
	elsif (SW1 = '1') then
		-- MULTIPLICATION
		result <= x * y;
		
	else 
		-- ELSE ( shouldn't happen ) put everything to zero
		z1 <= "0000";
		z10 <= "0000";
	end if;
	
	-- Only differentiate units and tens when we're not in SUBSTRACTION case 
	if ((SW1 = '1') or (SW0 = '0' and SW1 = '0')) then
		-- Increment from 1 to 9 ( 81 is the max value and it's inferior to 90)
		for K in 1 to 9 loop
			if ( 10*K = result ) then
				-- If multiple of 10 then units is 0 and tens is K
				z1 <= "0000";
				z10 <= conv_std_logic_vector(K, 4);
				exit;
			elsif ( 10*K > result ) then
				-- As soon as 10*K passes by the result, then we can compute the value
				z1 <= result - 10*(K-1);
				z10 <= conv_std_logic_vector(K-1, 4);
				exit;
			end if;
		end loop;
	end if;
	
		
	-- Display
	case Disp is
		when "00" => DI <= z1;
		when "01" => DI <= z10;
		when "10" => DI <= y;
		when "11" => DI <= x;
		when others => DI <= "1111";
	end case;
	
	-- Choose which segment is modified with the Disp number
	case Disp is
		when "00" => Digit <= "1110";
		when "01" => Digit <= "1101";
		when "10" => Digit <= "1011";
		when "11" => Digit <= "0111";
		when others => Digit <= "0000";
	end case;
	
end process;

process(DI)
begin
	-- Choose segment with the wanted digit
	case DI is
		when "0000" => Segments <= "0000001";
		when "0001" => Segments <= "1001111";
		when "0010" => Segments <= "0010010";
		when "0011" => Segments <= "0000110";
		when "0100" => Segments <= "1001100";
		when "0101" => Segments <= "0100100";
		when "0110" => Segments <= "0100000";
		when "0111" => Segments <= "0001111";
		when "1000" => Segments <= "0000000";
		when "1001" => Segments <= "0000100";
		when "1101" => Segments <= "1111110";
		when others => Segments <= "1111111";
	end case;
end process;

end Behavioral;