library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity GG is
	port 
		( 
		Gk, Pk, Gj: in STD_LOGIC;			-- Gk = G_{i:k}, Gj = G_{k-1:j}
		Gij: out STD_LOGIC					-- Gij = G_{i:j}
		);
end GG;

architecture dataflow of GG is

begin

	Gij <= Gk or (Pk and Gj);

end dataflow;