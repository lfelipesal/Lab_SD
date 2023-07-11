LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY distribuidor IS
    PORT (
        estado : IN STD_LOGIC;
        sinalDistribuidor : OUT STD_LOGIC
    );
END ENTITY distribuidor;

ARCHITECTURE comportamental OF distribuidor IS
BEGIN
    PROCESS (estado)
    BEGIN
        IF estado = '1' THEN
            sinalDistribuidor <= '1';
        ELSE
            sinalDistribuidor <= '0';
        END IF;
    END PROCESS;
END ARCHITECTURE comportamental;