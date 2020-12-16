----------------------------------------------------------------------------------
-- Engineer: 
-- 
-- Create Date: 22.11.2019 18:00:56
-- Module Name: hex2disp - Behavioral
-- Project Name: ALU-FIR-FSM 

-- Revision:
-- Revision 0.01 - File Created

----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.ALL;


package hex2disp_pck is 
    component hex2disp 
    Port ( 
           data : in std_logic_vector (3 downto 0);
           disp : out std_logic_vector (6 downto 0)
           );
    end component;
end hex2disp_pck;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.ALL;
entity hex2disp is
    Port ( 
           data : in std_logic_vector (3 downto 0);
           disp : out std_logic_vector (6 downto 0)
          
           );
           
end hex2disp;

architecture Behavioral of hex2disp is

begin
    with data select
  disp<= "1111001" when "0001",   --1
         "0100100" when "0010",   --2
         "0110000" when "0011",   --3
         "0011001" when "0100",   --4
         "0010010" when "0101",   --5
         "0000010" when "0110",   --6
         "1111000" when "0111",   --7
         "0000000" when "1000",   --8
         "0010000" when "1001",   --9
         "0001000" when "1010",   --A
         "0000011" when "1011",   --b
         "1000110" when "1100",   --C
         "0100001" when "1101",   --d
         "0000110" when "1110",   --E
         "0001110" when "1111",   --F
         "1000000" when others;   --0
end Behavioral;