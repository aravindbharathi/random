library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity comp_add is
	port
		(
		X, Y: in STD_LOGIC_VECTOR(16 downto 1);
		O: out STD_LOGIC_VECTOR(15 downto 0);
		Carryout: out STD_LOGIC
		);
end comp_add;

architecture dataflow of comp_add is

component GPGG	-- Group Generate (AND-OR gate) and Group Propagate (AND gate) BLACK
	port
		(
		Gk, Pk, Gj, Pj: in STD_LOGIC;		-- Gk = G_{i:k}, Gj = G_{k-1:j}
		Gij, Pij: out STD_LOGIC				-- Gij = G_{i:j}
		); 
end component;
-- Gij = Gk + Pk.Gj
-- Pij = Pk.Pj

component GG	-- Group Generate GRAY
	port
		(
		Gk, Pk, Gj: in STD_LOGIC;			-- Gk = G_{i:k}, Gj = G_{k-1:j}
		Gij: out STD_LOGIC					-- Gij = G_{i:j}
		);
end component;
-- Gij = Gk + Pk.Gj

signal G,P: STD_LOGIC_VECTOR(16 downto 1);
signal G0, P0: STD_LOGIC;

signal Glevel1, Plevel1: STD_LOGIC_VECTOR(15 downto 0);
signal Glevel2, Plevel2: STD_LOGIC_VECTOR(15 downto 0);
signal Glevel3, Plevel3: STD_LOGIC_VECTOR(15 downto 0);
signal Glevel4: STD_LOGIC_VECTOR(15 downto 8);

begin

	G <= X and Y;
	P <= X xor Y;
	
	G0 <= '0';
	P0 <= '0';

	-- Level 1
	KS_11: GG port map (G(1),P(1),G0,Glevel1(1));
	
	KS_12: GPGG port map (G(2),P(2),G(1),P(1),Glevel1(2),Plevel1(2));
	KS_13: GPGG port map (G(3),P(3),G(2),P(2),Glevel1(3),Plevel1(3));
	KS_14: GPGG port map (G(4),P(4),G(3),P(3),Glevel1(4),Plevel1(4));
	KS_15: GPGG port map (G(5),P(5),G(4),P(4),Glevel1(5),Plevel1(5));
	KS_16: GPGG port map (G(6),P(6),G(5),P(5),Glevel1(6),Plevel1(6));
	KS_17: GPGG port map (G(7),P(7),G(6),P(6),Glevel1(7),Plevel1(7));
	KS_18: GPGG port map (G(8),P(8),G(7),P(7),Glevel1(8),Plevel1(8));
	KS_19: GPGG port map (G(9),P(9),G(8),P(8),Glevel1(9),Plevel1(9));
	KS_110: GPGG port map (G(10),P(10),G(9),P(9),Glevel1(10),Plevel1(10));
	KS_111: GPGG port map (G(11),P(11),G(10),P(10),Glevel1(11),Plevel1(11));
	KS_112: GPGG port map (G(12),P(12),G(11),P(11),Glevel1(12),Plevel1(12));
	KS_113: GPGG port map (G(13),P(13),G(12),P(12),Glevel1(13),Plevel1(13));
	KS_114: GPGG port map (G(14),P(14),G(13),P(13),Glevel1(14),Plevel1(14));
	KS_115: GPGG port map (G(15),P(15),G(14),P(14),Glevel1(15),Plevel1(15));
	
	-- Level 2
	KS_22: GG port map (Glevel1(2),Plevel1(2),G0,Glevel2(2));
	KS_23: GG port map (Glevel1(3),Plevel1(3),Glevel1(1),Glevel2(3));
	
	KS_24: GPGG port map (Glevel1(4),Plevel1(4),Glevel1(2),Plevel1(2),Glevel2(4),Plevel2(4));
	KS_25: GPGG port map (Glevel1(5),Plevel1(5),Glevel1(3),Plevel1(3),Glevel2(5),Plevel2(5));
	KS_26: GPGG port map (Glevel1(6),Plevel1(6),Glevel1(4),Plevel1(4),Glevel2(6),Plevel2(6));
	KS_27: GPGG port map (Glevel1(7),Plevel1(7),Glevel1(5),Plevel1(5),Glevel2(7),Plevel2(7));
	KS_28: GPGG port map (Glevel1(8),Plevel1(8),Glevel1(6),Plevel1(6),Glevel2(8),Plevel2(8));
	KS_29: GPGG port map (Glevel1(9),Plevel1(9),Glevel1(7),Plevel1(7),Glevel2(9),Plevel2(9));
	KS_210: GPGG port map (Glevel1(10),Plevel1(10),Glevel1(8),Plevel1(8),Glevel2(10),Plevel2(10));
	KS_211: GPGG port map (Glevel1(11),Plevel1(11),Glevel1(9),Plevel1(9),Glevel2(11),Plevel2(11));
	KS_212: GPGG port map (Glevel1(12),Plevel1(12),Glevel1(10),Plevel1(10),Glevel2(12),Plevel2(12));
	KS_213: GPGG port map (Glevel1(13),Plevel1(13),Glevel1(11),Plevel1(11),Glevel2(13),Plevel2(13));
	KS_214: GPGG port map (Glevel1(14),Plevel1(14),Glevel1(12),Plevel1(12),Glevel2(14),Plevel2(14));
	KS_215: GPGG port map (Glevel1(15),Plevel1(15),Glevel1(13),Plevel1(13),Glevel2(15),Plevel2(15));
	
	-- Level 3
	KS_34: GG port map (Glevel2(4),Plevel2(4),G0,Glevel3(4));
	KS_35: GG port map (Glevel2(5),Plevel2(5),Glevel1(1),Glevel3(5));
	KS_36: GG port map (Glevel2(6),Plevel2(6),Glevel2(2),Glevel3(6));
	KS_37: GG port map (Glevel2(7),Plevel2(7),Glevel2(3),Glevel3(7));
	
	KS_38: GPGG port map (Glevel2(8),Plevel2(8),Glevel2(4),Plevel2(4),Glevel3(8),Plevel3(8));
	KS_39: GPGG port map (Glevel2(9),Plevel2(9),Glevel2(5),Plevel2(5),Glevel3(9),Plevel3(9));
	KS_310: GPGG port map (Glevel2(10),Plevel2(10),Glevel2(6),Plevel2(6),Glevel3(10),Plevel3(10));
	KS_311: GPGG port map (Glevel2(11),Plevel2(11),Glevel2(7),Plevel2(7),Glevel3(11),Plevel3(11));
	KS_312: GPGG port map (Glevel2(12),Plevel2(12),Glevel2(8),Plevel2(8),Glevel3(12),Plevel3(12));
	KS_313: GPGG port map (Glevel2(13),Plevel2(13),Glevel2(9),Plevel2(9),Glevel3(13),Plevel3(13));
	KS_314: GPGG port map (Glevel2(14),Plevel2(14),Glevel2(10),Plevel2(10),Glevel3(14),Plevel3(14));
	KS_315: GPGG port map (Glevel2(15),Plevel2(15),Glevel2(11),Plevel2(11),Glevel3(15),Plevel3(15));
	
	-- Level 4
	KS_48: GG port map (Glevel3(8),Plevel3(8),G0,Glevel4(8));
	KS_49: GG port map (Glevel3(9),Plevel3(9),Glevel1(1),Glevel4(9));
	KS_410: GG port map (Glevel3(10),Plevel3(10),Glevel2(2),Glevel4(10));
	KS_411: GG port map (Glevel3(11),Plevel3(11),Glevel2(3),Glevel4(11));
	KS_412: GG port map (Glevel3(12),Plevel3(12),Glevel3(4),Glevel4(12));
	KS_413: GG port map (Glevel3(13),Plevel3(13),Glevel3(5),Glevel4(13));
	KS_414: GG port map (Glevel3(14),Plevel3(14),Glevel3(6),Glevel4(14));
	KS_415: GG port map (Glevel3(15),Plevel3(15),Glevel3(7),Glevel4(15));
	
	-- Other Outputs
	O(0) <= P(1) xor G0;
	O(1) <= P(2) xor Glevel1(1);
	
	O(2) <= P(3) xor Glevel2(2);
	O(3) <= P(4) xor Glevel2(3);
	
	O(4) <= P(5) xor Glevel3(4);
	O(5) <= P(6) xor Glevel3(5);
	O(6) <= P(7) xor Glevel3(6);
	O(7) <= P(8) xor Glevel3(7);
	
	O(8) <= P(9) xor Glevel4(8);
	O(9) <= P(10) xor Glevel4(9);
	O(10) <= P(11) xor Glevel4(10);
	O(11) <= P(12) xor Glevel4(11);
	O(12) <= P(13) xor Glevel4(12);
	O(13) <= P(14) xor Glevel4(13);
	O(14) <= P(15) xor Glevel4(14);
	O(15) <= P(16) xor Glevel4(15);
	
	Carryout <= G(16) or (P(16) and Glevel4(15));
	
end dataflow;