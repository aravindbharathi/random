library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity comp_nand is
	port 
		( 
		X, Y : in STD_LOGIC_VECTOR(15 downto 0);
		O : out STD_LOGIC_VECTOR(15 downto 0)
		);
end comp_nand;

architecture dataflow of comp_nand is

begin

	O <= X nand Y;

end dataflow;