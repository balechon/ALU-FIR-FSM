----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.11.2019 18:07:36
-- Design Name: 
-- Module Name: top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE, ESPEVLSI;
use IEEE.STD_LOGIC_1164.ALL;

USE IEEE.std_logic_arith.ALL;
use IEEE.std_logic_unsigned.ALL;
use work.alu_pck.all;
use work.hex2disp_pck.all;
use work.FSM_pckg.all;
use work.mode_selector_pck.all;
use work.Clock_Generator_pckg.all;
use work.fir2_pck.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is

 	        
    Port ( 
           --variables top alu
           a_t : in std_logic_vector (3 downto 0);
           b_t : in std_logic_vector (3 downto 0);
           op_t : in std_logic_vector (1 downto 0);
           disp_t : out std_logic_vector (6 downto 0);
           
           --variables top FSM
           rst_t : in STD_LOGIC;
           clk_puls_t : in STD_LOGIC;
         
           -- variables top FIR
         	          
           --Variables top mode selector
           sel_t : in std_logic_vector (1 downto 0);
           resp_sel_t : out STD_LOGIC_VECTOR (7 downto 0);
           an_t : out std_logic_vector (3 downto 0);
          
           --variables del clock 1MHz
           clk_t : in STD_LOGIC
           
        );    
end top;

architecture Behavioral of top is
    signal aux : std_logic_vector (7 downto 0);
    signal auxclk : std_logic;
    signal aux_a: std_logic_vector(3 downto 0);
    signal aux_as: signed(3 downto 0);
    signal aux_bs: signed(3 downto 0);
    signal aux_rst: std_logic;
    signal salida_fsm : std_logic_vector (3 downto 0);
    signal alu2_mode_selector : std_logic_vector (3 downto 0);
    signal fsm2_mode_selector : std_logic_vector (3 downto 0);
    signal fir2_mode_selector : signed (7 downto 0);
    
begin
    aux_a<=a_t;
    aux_as <= signed(a_t);-- fir para conectar el a
    aux_bs <= signed(b_t);-- entrada B para el fir 
    aux_rst<=rst_t;
    resp_sel_t<=aux;
    
    uo: alu port map (a=> aux_a,
                      b=>b_t, 
                      op=>op_t, 
                      resp=>alu2_mode_selector);         
                      
    u1: FSM port map (x1 => aux_a(0), 
                      x2 => aux_a(1), 
                      rst=>aux_rst,
                      clk_pul=>clk_puls_t, 
                      sel_clk=>aux_a(2), 
                      clk_1Hz=>auxclk,
                      salida_fsm => fsm2_mode_selector);
                      
    u2: Clock_Generator port map(clk=>clk_t,  
                                 clk_salida=>auxclk);
                                 
    u3: mode_selector port map (alu=>alu2_mode_selector, 
                                fsm=>fsm2_mode_selector,
                                fir=>fir2_mode_selector,
                                sel=>sel_t,
                                resp_sel=>aux,
                                an =>an_t);
                                
    u4: fir2 port map ( clk=> auxclk,
                        rst=> aux_rst,
                        x=> aux_as,
                        y=> fir2_mode_selector);                            
     
    u5: hex2disp port map (data =>aux(3 downto 0), 
                           disp=>disp_t
                           );
                            
end Behavioral;
