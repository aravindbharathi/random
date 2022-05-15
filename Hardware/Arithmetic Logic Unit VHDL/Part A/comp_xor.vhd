library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity comp_xor is
	port 
		( 
		X, Y : in STD_LOGIC_VECTOR(15 downto 0);
		O : out STD_LOGIC_VECTOR(15 downto 0)
		);
end comp_xor;

architecture dataflow of comp_xor is

begin

	O <= X xor Y;

end dataflow;