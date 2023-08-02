-- Trabalho Final - Sistemas Digitais 2023.2 - A2 Noturno
-- Universidade Federal do ABC
-- divider.vhd
--
-- Arthur N. Guedes - 11085314

LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY divider
IS
    GENERIC
    (
        nBits: INTEGER := 4 -- Número de bits da resposta
    );
    PORT 
    (
        a:    IN INTEGER RANGE 0 TO 15;           -- Dividendo da operação (0-15)
        b:    IN INTEGER RANGE 0 TO 15;           -- Divisor da operação (0-15)
        y:    OUT STD_LOGIC_VECTOR (3 DOWNTO 0);  -- Quociente (4 bits)
        rm:   OUT INTEGER RANGE 0 TO 15;          -- Resto  (0-15)
        err:  OUT STD_LOGIC;                      -- Flag de erro de divisão por zero ('0' ou '1')
        hex0: OUT STD_LOGIC_VECTOR (6 DOWNTO 0);  -- Quociente (Display 7 segmentos)
        hex1: OUT STD_LOGIC_VECTOR (6 DOWNTO 0)   -- Resto (Display 7 segmentos)
    );
END divider;


ARCHITECTURE rtl OF divider 
IS
    BEGIN PROCESS (a, b)

        VARIABLE quot:   STD_LOGIC_VECTOR (3 DOWNTO 0);
        VARIABLE rmVar:  INTEGER RANGE 0 TO 15;
        VARIABLE errVar: STD_LOGIC;

        BEGIN

        rmVar := a;

        IF (b=0)            -- Se b(divisor) é 0, ERRO
        THEN errVar := '1';
        ELSE errVar := '0';
        END IF;

        FOR i IN (nBits - 1) DOWNTO 0 -- Para cada bit de um vetor de 4 bits (3 a 0)
        LOOP
            IF(rmVar >= b * 2**i) -- Divisão binária
            THEN
                quot(i) := '1';
                rmVar := rmVar - b * 2**i;
            ELSE
                quot(i) := '0';
            END IF;
        END LOOP;

        err <= errVar;

        IF (errVar = '1')
        THEN       -- Se houver erro de divisão por zero, exibe caracteres de erro (-) em ambos Displays
            y  <= "0000";
            rm <= 0;
            hex0(6 DOWNTO 0) <= "0111111";
            hex1(6 DOWNTO 0) <= "0111111";
        ELSE        
            y  <= quot;
            rm <= rmVar;

            CASE quot -- Exibe algarismo hexadecimal no primeiro Display 7 segmentos (Quociente)
            IS
                WHEN "0000" => hex0(6 DOWNTO 0) <= "1000000";
                WHEN "0001" => hex0(6 DOWNTO 0) <= "1111001";
                WHEN "0010" => hex0(6 DOWNTO 0) <= "0100100";
                WHEN "0011" => hex0(6 DOWNTO 0) <= "0110000";
                WHEN "0100" => hex0(6 DOWNTO 0) <= "0011001";
                WHEN "0101" => hex0(6 DOWNTO 0) <= "0010010";
                WHEN "0110" => hex0(6 DOWNTO 0) <= "0000010";
                WHEN "0111" => hex0(6 DOWNTO 0) <= "1111000";
                WHEN "1000" => hex0(6 DOWNTO 0) <= "0000000";
                WHEN "1001" => hex0(6 DOWNTO 0) <= "0010000";
                WHEN "1010" => hex0(6 DOWNTO 0) <= "0001000";
                WHEN "1011" => hex0(6 DOWNTO 0) <= "0000011";
                WHEN "1100" => hex0(6 DOWNTO 0) <= "1000110";
                WHEN "1101" => hex0(6 DOWNTO 0) <= "0100001";
                WHEN "1110" => hex0(6 DOWNTO 0) <= "0000110";
                WHEN "1111" => hex0(6 DOWNTO 0) <= "0001110";
                WHEN OTHERS => hex0(6 DOWNTO 0) <= "0000000";
            END CASE;
        
            CASE rmVar -- Exibe algarismo hexadecimal no segundo Display 7 segmentos (resto)
            IS
                WHEN  0 => hex1(6 DOWNTO 0) <= "1000000";
                WHEN  1 => hex1(6 DOWNTO 0) <= "1111001";
                WHEN  2 => hex1(6 DOWNTO 0) <= "0100100";
                WHEN  3 => hex1(6 DOWNTO 0) <= "0110000";
                WHEN  4 => hex1(6 DOWNTO 0) <= "0011001";
                WHEN  5 => hex1(6 DOWNTO 0) <= "0010010";
                WHEN  6 => hex1(6 DOWNTO 0) <= "0000010";
                WHEN  7 => hex1(6 DOWNTO 0) <= "1111000";
                WHEN  8 => hex1(6 DOWNTO 0) <= "0000000";
                WHEN  9 => hex1(6 DOWNTO 0) <= "0010000";
                WHEN 10 => hex1(6 DOWNTO 0) <= "0001000";
                WHEN 11 => hex1(6 DOWNTO 0) <= "0000011";
                WHEN 12 => hex1(6 DOWNTO 0) <= "1000110";
                WHEN 13 => hex1(6 DOWNTO 0) <= "0100001";
                WHEN 14 => hex1(6 DOWNTO 0) <= "0000110";
                WHEN 15 => hex1(6 DOWNTO 0) <= "0001110";
                WHEN OTHERS => hex1(6 DOWNTO 0) <= "0000000";
            END CASE;
        END IF;
    END PROCESS;
END rtl;
