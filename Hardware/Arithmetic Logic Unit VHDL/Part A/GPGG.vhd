library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity GPGG is
	port 
		( 
		Gk, Pk, Gj, Pj: in STD_LOGIC;		-- Gk = G_{i:k}, Gj = G_{k-1:j}
		Gij, Pij: out STD_LOGIC				-- Gij = G_{i:j}
		);
end GPGG;

architecture dataflow of GPGG is

begin

	Gij <= Gk or (Pk and Gj);
	Pij <= Pk and Pj;

end dataflow;