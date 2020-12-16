----------------------------------------------------------------------------------
-- Engineer: Brayan Lechon
-- 
-- Create Date: 22.11.2019 18:00:56
-- Module Name: FSM - Behavioral
-- Project Name: ALU-FIR-FSM 

-- Revision:
-- Revision 0.01 - File Created

----------------------------------------------------------------------------------

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



package FSM_pckg is
    component FSM
    Port ( x1 : in std_logic;
           x2 : in STD_LOGIC;
           rst : in STD_LOGIC;
           sel_clk : in STD_LOGIC;
           clk_pul : in STD_LOGIC;
           clk_1Hz : in STD_LOGIC;

           salida_fsm : out std_logic_vector (3 downto 0)
           );
    end component;
end FSM_pckg;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FSM is
    Port ( x1 : in STD_LOGIC;
           x2 : in STD_LOGIC;
           rst : in STD_LOGIC;
           sel_clk : in STD_LOGIC;
           clk_pul : in STD_LOGIC;
           clk_1Hz : in STD_LOGIC;
          
           salida_fsm : out std_logic_vector (3 downto 0)
           );
end FSM;

architecture Behavioral of FSM is

Type estados is (a,b,c);
signal ps,ns:estados;
signal clk:STD_LOGIC;

begin
    clk <= clk_pul when (sel_clk ='1') else
            clk_1Hz;
   
    process(clk,rst)
    begin
        if(rst='1')then
            ps <= a;
        elsif(clk'event AND clk='1')then 
            ps <= ns;
        end if;    
    end process;
    
    process (x1,x2,ps)
    begin
        case ps is
            WHEN a =>
               
                if (x1 = '1') then
                
                    ns <= c;
                 salida_fsm <= "001" & '1';
                else
                   
                    ns <= b; 
                    salida_fsm <= "001" & '1';
                end if;
            WHEN b =>
               
                if (x1 = '1') then
                 
                    ns <= b;
                    salida_fsm <= "010" & '0';
                else
                
                    ns <= c; 
                    salida_fsm <= "010" & '0';
                end if;
                
            WHEN c =>
               
                if (x2 = '1') then
               
                    ns <= c;
                    salida_fsm <= "100" & '1';
                else
                  
                    ns <= a; 
                    salida_fsm <= "100" & '0';
                end if;        
           when others =>
            salida_fsm <= "0000";
        end case;
    end process;
    
end Behavioral;

