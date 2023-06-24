LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY divisor_de_clock IS
    PORT (
        clk50MHz : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        clk1Hz : OUT STD_LOGIC
    );
END ENTITY divisor_de_clock;

ARCHITECTURE comportamental OF divisor_de_clock IS
    SIGNAL contador : INTEGER := 0;
    SIGNAL clk1Hz_temp : STD_LOGIC := '0';
BEGIN
    processo_geracao_clk : PROCESS (clk50MHz, reset)
    BEGIN
        IF reset = '1' THEN
            contador <= 0;
            clk1Hz_temp <= '0';
        ELSIF rising_edge(clk50MHz) THEN
            contador <= contador + 1;
            IF contador = 24999999 THEN
                clk1Hz_temp <= NOT clk1Hz_temp;
                contador <= 0;
            END IF;
        END IF;
    END PROCESS processo_geracao_clk;

    clk1Hz <= clk1Hz_temp;
END ARCHITECTURE comportamental;