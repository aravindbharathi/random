library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- 16-bit ALU 
entity ALU is
 port (
   ABUS: in std_logic_vector(15 downto 0); -- ABUS data input of the 16-bit ALU
   BBUS: in std_logic_vector(15 downto 0); -- BBUS data input of the 16-bit ALU
   ALUctrl: in std_logic_vector(3 downto 0); -- ALUctrl control input of the 16-bit ALU 
   ALUOUT: out std_logic_vector(15 downto 0)  -- 16-bit data output of the 16-bit ALU 
   );
end ALU;

architecture Behavioral of ALU is

signal BBUS_not: std_logic_vector(16-1 downto 0);
signal tmp_out1: std_logic_vector(16-1 downto 0);
signal tmp_out2: std_logic_vector(16-1 downto 0);
signal tmp: std_logic_vector(16-1 downto 0);
begin
BBUS_not <= not BBUS;  
-- Other instructions of the 16-bit ALU in VHDL 
process(ALUctrl,ABUS,BBUS,tmp_out1,tmp)
begin 
case(ALUctrl) is 
 when "0010" =>  ALUOUT <= ABUS nand BBUS; -- AND
 when "0011" =>  ALUOUT <= ABUS xor BBUS; -- OR
 when others => ALUOUT <= tmp_out1; 
 end case;
end process;

end Behavioral;