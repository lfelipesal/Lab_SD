LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY registrador_7 IS
    PORT (
        load : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        clock : IN STD_LOGIC;
        entrada : IN std_logic_vector(6 DOWNTO 0);
        saida : OUT std_logic_vector(6 DOWNTO 0)
    );
END ENTITY registrador_7;

ARCHITECTURE rtl OF registrador_7 IS

BEGIN
    PROCESS (clock, reset)
    BEGIN
        -- Reset whenever the reset signal goes low, regardless of the clock
        IF (reset = '0') THEN
            saida <= "0000000";
            -- If not resetting, update the register output on the clock's rising edge
        ELSIF (rising_edge(clock)) THEN
            saida <= entrada;
        END IF;
    END PROCESS;
END ARCHITECTURE rtl;