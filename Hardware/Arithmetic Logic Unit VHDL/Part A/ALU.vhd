library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;

entity ALU is
	port
		(
		A, B: in STD_LOGIC_VECTOR(15 downto 0);
		S1, S0: in STD_LOGIC;
		----
		Z:	out STD_LOGIC;
		C:	out STD_LOGIC;
		R: inout STD_LOGIC_VECTOR(15 downto 0)
		);
end entity;

architecture Structural of ALU is

component comp_xor is
	port
		(
		X, Y: in STD_LOGIC_VECTOR(15 downto 0);
		O: out STD_LOGIC_VECTOR(15 downto 0)
		);
end component;

component comp_nand is 
	port
		(
		X, Y: in STD_LOGIC_VECTOR(15 downto 0);
		O: out STD_LOGIC_VECTOR(15 downto 0)
		);
end component;

component comp_add is
	port
		(
		X, Y: in STD_LOGIC_VECTOR(15 downto 0);
		O: out STD_LOGIC_VECTOR(15 downto 0);
		Carryout: out STD_LOGIC
		);
end component;

component comp_sub is
	port
		(
		X, Y: in STD_LOGIC_VECTOR(15 downto 0);
		O: out STD_LOGIC_VECTOR(15 downto 0);
		Carryout: out STD_LOGIC
		);
end component;

component mux is
	port
		(
		X1, X2, X3, X4 : in STD_LOGIC_VECTOR(15 downto 0);
		Sel1, Sel0: in STD_LOGIC;
		Y: out STD_LOGIC_VECTOR(15 downto 0)
		);
end component;

component mux2 is
	port
		(
		X1, X2, X3, X4 : in STD_LOGIC;
		Sel1, Sel0: in STD_LOGIC;
		Y: out STD_LOGIC
		);
end component;

component comp_zero is
	port
		(
		X: in STD_LOGIC_VECTOR(15 downto 0);
		Y: out STD_LOGIC
		);
end component;

----

signal sigAdd: STD_LOGIC_VECTOR(16 downto 0);

signal sigSub: STD_LOGIC_VECTOR(16 downto 0);

signal sigN: STD_LOGIC_VECTOR(15 downto 0);

signal sigX: STD_LOGIC_VECTOR(15 downto 0);

begin

	-- Addition 
	Addstep: comp_add port map (A, B, sigAdd(15 downto 0), sigAdd(16));
	
	----
	-- Subtraction
	Substep: comp_add port map (A, B, sigSub(15 downto 0), sigSub(16));
		
	----
	-- NAND Operation
	Nstep: comp_nand port map (A, B, sigN);
			
	----
	-- XOR Operation
	Xstep: comp_xor port map (A, B, sigX);
			
	----
	-- MUX Selection
	Mstep: mux port map(sigAdd(15 downto 0), sigSub(15 downto 0), sigN, sigX, S1, S0, R);
	M2step: mux2 port map(sigAdd(16), sigSub(16), '0', '0', S1, S0, C);
	
	----
	-- Zero Bit Evaluation
	Zstep: comp_zero port map(R, Z);
	
end Structural;