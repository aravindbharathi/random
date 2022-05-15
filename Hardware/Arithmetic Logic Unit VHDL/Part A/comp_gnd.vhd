library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity comp_gnd is
	port 
		( 
		X: inout STD_LOGIC
		);
end comp_gnd;

architecture dataflow of comp_gnd is

begin

	X <= '0';

end dataflow;