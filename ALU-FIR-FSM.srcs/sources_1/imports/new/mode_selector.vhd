----------------------------------------------------------------------------------
-- Engineer: 
-- 
-- Create Date: 22.11.2019 18:00:56
-- Module Name: hex2disp - Behavioral
-- Project Name: 

-- Revision:
-- Revision 0.01 - File Created

----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;
USE ieee.std_logic_arith.all;
package mode_selector_pck is
   component mode_selector
    port( sel : in std_logic_vector (1 downto 0);
           resp_sel : out std_logic_vector (7 downto 0);
           alu : in std_logic_vector (3 downto 0);
           fsm : in STD_LOGIC_VECTOR (3 downto 0);
           fir : in signed (7 downto 0);
           an: out std_logic_vector(3 downto 0)
          );
    end component;
end mode_selector_pck;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;
USE ieee.std_logic_arith.all;
entity mode_selector is
    Port ( 
           sel : in std_logic_vector (1 downto 0);
           resp_sel : out std_logic_vector (7 downto 0); -- para display
           alu : in std_logic_vector (3 downto 0);
           fsm : in STD_LOGIC_VECTOR (3 downto 0);
           fir : in signed (7 downto 0);
           an: out std_logic_vector(3 downto 0)
           );
end mode_selector;

architecture Behavioral of mode_selector is
        
begin
       
resp_sel <= 
            "0000" &alu when sel="00" else
            "0000" & fsm  when sel="01" else
            std_logic_vector(fir) when sel= "10" else
            "11110000" when sel="11" else
            "11111111";
         
an  <=      "1110" when sel="00" else
            "1111"  when sel="01" else
            "1111" when sel= "10" else
            "1111" when sel="11" else
            "1111";
end Behavioral;
