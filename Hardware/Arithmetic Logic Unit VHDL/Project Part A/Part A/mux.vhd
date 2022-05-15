library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mux is
	port 
		( 
		X1, X2, X3, X4 : in STD_LOGIC_VECTOR(15 downto 0);
		Sel1, Sel0: in STD_LOGIC;
		Y: inout STD_LOGIC_VECTOR(15 downto 0)
		);
end mux;

architecture dataflow of mux is

begin

process (X1,X2,X3,X4,Y,Sel1,Sel0)
	begin

	if (Sel1 = '0' and Sel0 = '0') then	
		Y <= X1;
	elsif (Sel1 = '0' and Sel0 = '1') then
		Y <= X2;
	elsif (Sel1 = '1' and Sel0 = '0') then
		Y <= X3;
	else
		Y <= X4;
	end if;

end process;
	
end dataflow;