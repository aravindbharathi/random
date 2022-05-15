library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;

entity ALU is
	port
		(
		A15, A14, A13, A12:	in STD_LOGIC;
		A11, A10, A9, A8:		in STD_LOGIC;
		A7, A6, A5, A4:		in STD_LOGIC;
		A3, A2, A1, A0:		in STD_LOGIC;
		
		B15, B14, B13, B12:	in STD_LOGIC;
		B11, B10, B9, B8:		in STD_LOGIC;
		B7, B6, B5, B4:		in STD_LOGIC;
		B3, B2, B1, B0:		in STD_LOGIC;
		
		A, B: in STD_LOGIC_VECTOR(15 downto 0);
		
		S1, S0:					in STD_LOGIC;
		----
		Z:							out STD_LOGIC;
		
		C:							out STD_LOGIC;
		
		R15, R14, R13, R12:	out STD_LOGIC;
		R11, R10, R9, R8:		out STD_LOGIC;
		R7, R6, R5, R4:		out STD_LOGIC;
		R3, R2, R1, R0:		out STD_LOGIC;
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
		X, Y: out STD_LOGIC_VECTOR(15 downto 0);
		O: out STD_LOGIC_VECTOR(15 downto 0)
		);
end component;

component comp_add is
	port
		(
		X, Y: out STD_LOGIC_VECTOR(15 downto 0);
		O: out STD_LOGIC_VECTOR(15 downto 0);
		Carryout: out STD_LOGIC
		);
end component;

component comp_sub is
	port
		(
		X, Y: out STD_LOGIC_VECTOR(15 downto 0);
		O: out STD_LOGIC_VECTOR(15 downto 0);
		Carryout: out STD_LOGIC
		);
end component;

component mux is
	port
		(
		X1, X2, X3, X4 : in STD_LOGIC_VECTOR(15 downto 0);
		S1, S0: in STD_LOGIC;
		Y: out STD_LOGIC_VECTOR(15 downto 0)
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
	Addstep: comp_add port map (A, B, sigAdd, C);
	
	----
	-- Subtraction
	Substep: comp_add port map (A, B, sigSub, C);
		
	----
	-- NAND Operation
	Nstep: comp_nand port map (A, B, sigN);
			
	----
	-- XOR Operation
	Xstep: comp_xor port map (A, B, sigX);
			
	----
	-- MUX
	Mstep: mux port map(sigAdd(15 downto 0), sigSub(15 downto 0), sigN, sigX, S1, S0, R);
	M2step: mux2 port map(sigAdd(16), sigSub(16), 0, 0, S1, S0, C);
	
	----
	-- Zero Bit
	Zstep: comp_zero port map(R, Z);
	
end Structural;