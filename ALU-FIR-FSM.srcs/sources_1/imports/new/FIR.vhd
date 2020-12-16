-- Engineer: 
-- 
-- Create Date: 22.11.2019 18:00:56
-- Module Name: FIR - Behavioral
-- Project Name: ALU-FIR-FSM 

-- Revision:
-- Revision 0.01 - File Created

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

package fir2_pck is
    component fir2
    GENERIC(
            n: INTEGER := 4; 
	        m: INTEGER := 4
	        );
  	PORT ( 
  	    x: IN SIGNED (m-1 DOWNTO 0);
		clk, rst: IN STD_LOGIC;
		y: OUT SIGNED(2*m-1 DOWNTO 0)
		);
    end component;
    
    
end fir2_pck;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY fir2 IS
	GENERIC(n: INTEGER := 4; 
	        m: INTEGER := 4);
  	PORT ( x: IN SIGNED (m-1 DOWNTO 0);
		clk, rst: IN STD_LOGIC;
		y: OUT SIGNED(2*m-1 DOWNTO 0));
END fir2;

ARCHITECTURE Behavioral of fir2 IS
	-- declaracion de tipos
TYPE registros IS ARRAY (N-2 DOWNTO 0) OF SIGNED(M-1 DOWNTO 0);
TYPE coeficientes IS ARRAY (N-1 DOWNTO 0) OF SIGNED(M-1 DOWNTO 0);
-- declaracion de registros y coeficientes
SIGNAL REG: registros;
CONSTANT COEF: coeficientes := ("0001","0010","0011","0100");

begin
    PROCESS (clk,rst)
        VARIABLE ACC,PROD:
            SIGNED(2*M-1 DOWNTO 0) := (OTHERS=>'0');
        VARIABLE SIGN: STD_LOGIC;
    BEGIN
    -- RESET DEL SISTEMA
    IF(rst='1')THEN
        FOR I IN N-2 DOWNTO 0 LOOP
            FOR J IN M-1 DOWNTO 0 LOOP
                reg(I)(J) <='0';
            END LOOP;
       END LOOP;
    -- REGISTER INFERENCE + MAC
    ELSIF (clk'EVENT AND clk='1') THEN
        ACC:=COEF(0)*x;
        FOR I IN 1 TO N-1 LOOP
            SIGN:= ACC(2*M-1);
            PROD:=COEF(I)*REG(N-1-I);
            ACC:=ACC+PROD;
    -- CHEQUEO DE OVERFLOW 
        IF (SIGN=PROD(PROD'LEFT)) AND (ACC(ACC'LEFT) /= SIGN) THEN
            ACC:=(ACC'LEFT => SIGN, OTHERS => NOT SIGN);
        END IF;
    END LOOP;
    REG <= x & REG(N-2 DOWNTO 1);
    END IF;
    y <= ACC;
    END PROCESS;
END Behavioral;