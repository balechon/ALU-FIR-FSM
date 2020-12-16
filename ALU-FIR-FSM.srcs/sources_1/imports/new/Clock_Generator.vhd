----------------------------------------------------------------------------------
-- Engineer: Brayan Lechon
-- 
-- Create Date: 22.11.2019 18:00:56
-- Module Name: Clock_Generator - Behavioral
-- Project Name: ALU-FIR-FSM 

-- Revision:
-- Revision 0.01 - File Created

----------------------------------------------------------------------------------
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;




package Clock_Generator_pckg is
    component Clock_Generator
    Port ( clk : in STD_LOGIC;
           clk_salida : out STD_LOGIC);
    end component;
end Clock_Generator_pckg;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Clock_Generator is
    Port ( clk : in STD_LOGIC;
           clk_salida : out STD_LOGIC);
end Clock_Generator;

architecture Behavioral of Clock_Generator is

signal cont: UNSIGNED(0 to 26);
begin
    process(clk)
    begin
        if(clk'event and clk='1') then
            cont <= cont+1;
        end if;
    end process;
    clk_salida <= cont(0);


end Behavioral;
