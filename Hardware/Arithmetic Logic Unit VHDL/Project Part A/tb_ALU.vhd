-- Testbench for the ALU
--addition, subtraction, xor, nand
library IEEE;
use IEEE.std_logic_1164.all;

entity tb_ALU is
-- empty
end tb_ALU;

architecture tb of tb_ALU is

--component declaration
component ALUcomp is
port(
	abus: in std_logic_vector(15 downto 0);
    bbus: in std_logic_vector(15 downto 0);
    aluctrl: in std_logic_vector(1 downto 0);
    aluout: out std_logic_vector(16 downto 0)
    zero: out std_logic);
end component;

--input signals
signal abus: std_logic_vector(15 downto 0) := (others => '0');
signal bbus: std_logic_vector(15 downto 0) := (others => '0');
signal aluctrl: std_logic_vector(1 downto 0) := (others => '0');

--output signal
signal aluout: std_logic_vector(16 downto 0) := (others => '0');
signal zero: std_logic := '0';

begin
--	design under test initialisation
	dut_instance: ALU port map(
    abus => abus,
    bbus => bbus,
    aluctrl => aluctrl,
    aluout => aluout
    zero => zero);
-- stimulus process
    stim_proc: process
    begin

-- first test case
    abus <= "0101010101010101";
    bbus <= "1111111111111111";
    aluctrl <= "00";
    for i in 0 to 3 loop		-- going through all control inputs
    wait for 50ns;
    aluctrl = aluctrl + "1";
    end loop;
    wait for 50ns

--second test case
    abus <= "0000000000000000";
    bbus <= "0000000000000000";
    aluctrl <= "00";
    for i in 0 to 3 loop		-- going through all control inputs
    wait for 50ns;
    aluctrl = aluctrl + "1";
    end loop;
    wait for 50ns

--third test case
    abus <= "1010101010101010";
    bbus <= "0000000000000000";
    aluctrl <= "00";
    for i in 0 to 3 loop		-- going through all control inputs
    wait for 50ns;
    aluctrl = aluctrl + "1";
    end loop;
    wait for 50ns

    wait;
    end process;
end tb;
