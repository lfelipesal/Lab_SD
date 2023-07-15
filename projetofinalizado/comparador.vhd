LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY comparador_4 IS
    PORT (
        valor1 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        valor2 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        lt : OUT STD_LOGIC;
        gt : OUT STD_LOGIC;
        eq : OUT STD_LOGIC
    );
END ENTITY comparador_4;

ARCHITECTURE rtl OF comparador_4 IS
BEGIN
    compara : PROCESS (valor1, valor2)
    BEGIN
        IF (valor1 > valor2) THEN
            lt <= '0';
            gt <= '1';
            eq <= '0';
        ELSIF (valor1 < valor2) THEN
            lt <= '1';
            gt <= '0';
            eq <= '0';
        ELSE
            lt <= '0';
            gt <= '0';
            eq <= '1';
        END IF;

    END PROCESS compara;

END ARCHITECTURE rtl;