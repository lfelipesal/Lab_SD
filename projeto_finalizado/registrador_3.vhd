LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY registrador_3 IS
    PORT (
        load : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        clock : IN STD_LOGIC;
        entrada : IN unsigned(2 DOWNTO 0);
        saida : OUT unsigned(2 DOWNTO 0)
    );
END ENTITY registrador_3;

ARCHITECTURE rtl OF registrador_3 IS

BEGIN
    PROCESS (clock, reset)
    BEGIN
        -- Reset whenever the reset signal goes low, regardless of the clock
        IF (reset = '0') THEN
            saida <= "000";
            -- If not resetting, update the register output on the clock's rising edge
        ELSIF (rising_edge(clock)) THEN
            saida <= entrada;
        END IF;
    END PROCESS;
END ARCHITECTURE rtl;