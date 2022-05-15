library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity comp_zero is
	port 
		( 
		X: in STD_LOGIC_VECTOR(15 downto 0);
		Y: inout STD_LOGIC
		);
end comp_zero;

architecture dataflow of comp_zero is

begin

process (X,Y)
	begin

	if (X = x"0") then
		Y <= '1';
	else
		Y <= '0';
	end if;

end process;
	
end dataflow;