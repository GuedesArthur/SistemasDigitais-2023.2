-- Trabalho Final - Sistemas Digitais 2023.2 - A2 Noturno
-- Universidade Federal do ABC
-- divider_vhd_tst.vhd
--
-- Arthur N. Guedes - 11085314

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                


ENTITY divider_vhd_tst
IS
END divider_vhd_tst;


ARCHITECTURE divider_arch OF divider_vhd_tst
IS                                             
    SIGNAL a:       INTEGER RANGE 0 TO 15;
    SIGNAL b:       INTEGER RANGE 0 TO 15;
    SIGNAL rm:      INTEGER RANGE 0 TO 15;
    SIGNAL err:     STD_LOGIC;
    SIGNAL y:       STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL hex0:    STD_LOGIC_VECTOR (6 DOWNTO 0);
    SIGNAL hex1:    STD_LOGIC_VECTOR (6 DOWNTO 0);

    BEGIN uut:
    ENTITY work.divider(rtl)
    PORT MAP
    (
        a    => a,
        b    => b,
        err  => err,
        rm   => rm,
        y    => y,
        hex0 => hex0,
        hex1 => hex1
    );

    init : PROCESS                                   
    BEGIN                                  
	    a <= 11; b <=  3; -- Teste 1
	    WAIT FOR 200 ns;  ---- Resultado esperado: y = 3 | rm = 2 | err = 0

	    a <= 15; b <=  2; -- Teste 2
	    WAIT FOR 200 ns;  ---- Resultado esperado: y = 7 | rm = 1 | err = 0

	    a <= 13; b <=  5; -- Teste 3
	    WAIT FOR 200 ns;  --   Resultado esperado: y = 2 | rm = 3 | err = 0

        a <= 10; b <=  0; -- Teste 4 (Divisão por zero)
        WAIT FOR 200 ns;  --   Resultado esperado: y = 0 | rm = 0 | err = 1

        a <=  2; b <=  2; -- Teste 5 (Dividendo e divisor iguais)
	    WAIT FOR 200 ns;  ---- Resultado esperado: y = 1 | rm = 0 | err = 0

        a <= 15; b <=  1; -- Teste 6 (Divisão por um):
        WAIT FOR 200 ns;  ---- Resultado esperado: y = 15 | rm = 0 | err = 0

        a <=  0; b <=  0; -- Teste 7 (Divisão zero por zero):
        WAIT FOR 200 ns;  ---- Resultado esperado: y = 0 | rm = 0 | err = 1

        a <=  2; b <= 10; -- Teste 8 (Divisão maior que dividendo)
        WAIT FOR 200 ns;  ---- Resultado esperado: y = 0 | rm = 10 | err = 0
        WAIT;                                                     
    END PROCESS init;                                          
                                        
END divider_arch;
