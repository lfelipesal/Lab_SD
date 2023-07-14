LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY contador IS
    PORT (
        clock : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        gt_or_eq : OUT STD_LOGIC
    );
END ENTITY contador;

ARCHITECTURE rtl OF contador IS
BEGIN
    contagem : PROCESS (clock)
        VARIABLE conta : INTEGER RANGE 0 TO 10;
    BEGIN
        IF reset = '1' THEN
            conta := 0;
        ELSIF rising_edge(clock) THEN
            conta := conta + 1;
            IF conta >= 5 THEN
                gt_or_eq <= '1';
                conta := 0;
            END IF;
        END IF;

    END PROCESS;

END ARCHITECTURE rtl;