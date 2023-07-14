LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY valida_ficha IS
    PORT (
        reg_ficha : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        ficha_valida : OUT STD_LOGIC
    );
END ENTITY valida_ficha;

ARCHITECTURE rtl OF valida_ficha IS

BEGIN
    proc_valida : PROCESS (reg_ficha)
    BEGIN
        CASE reg_ficha IS
            WHEN "0001" =>
                ficha_valida <= '1';
            WHEN "0010" =>
                ficha_valida <= '1';
            WHEN "0101" =>
                ficha_valida <= '1';
            WHEN "1010" =>
                ficha_valida <= '1';
            WHEN OTHERS =>
                ficha_valida <= '0';
        END CASE;
    END PROCESS;

END ARCHITECTURE rtl;