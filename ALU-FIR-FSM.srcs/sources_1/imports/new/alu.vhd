----------------------------------------------------------------------------------
-- Engineer: Bryan Lechon
-- 
-- Create Date: 22.11.2019 18:00:56
-- Module Name: alu - Behavioral
-- Project Name: 

-- Revision:
-- Revision 0.01 - File Created

----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
--USE IEEE.std_logic_arith.ALL;
--use IEEE.std_logic_unsigned.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

package alu_pck is
    component alu
     Port ( 
           a : in std_logic_vector (3 downto 0);
           b : in std_logic_vector (3 downto 0);
           op : in std_logic_vector (1 downto 0);
           resp : out std_logic_vector (3 downto 0)
           );
    end component;

end alu_pck;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
--USE IEEE.std_logic_arith.ALL;
use IEEE.std_logic_unsigned.ALL;

entity alu is

    Port ( 
           a : in std_logic_vector (3 downto 0);
           b : in std_logic_vector (3 downto 0);
           op : in std_logic_vector (1 downto 0);
           resp : out std_logic_vector (3 downto 0)
           );
end alu;

architecture Behavioral of alu is
signal mul: integer range 0 to 15;
begin

   mul<=to_integer(unsigned(b))*to_integer(unsigned(a));
   
    resp <= a + b when op = "00" else
            a - b when op = "01" else
           std_logic_vector(to_unsigned(mul,4)) when op = "10" else
        --    a and b when op = "10" else
            a(0) & a(3 downto 1) when op ="11" else
           "0000";

end Behavioral;
