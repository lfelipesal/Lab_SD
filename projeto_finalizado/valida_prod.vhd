LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY valida_prod IS
    PORT (
        reg_prod : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        produto_valido : OUT STD_LOGIC

    );
END ENTITY valida_prod;

ARCHITECTURE rtl OF valida_prod IS

BEGIN

    proc_valida : PROCESS (reg_prod)
    BEGIN
        CASE reg_prod IS
            WHEN "0000" =>
                produto_valido <= '1';
            WHEN "0001" =>
                produto_valido <= '1';
            WHEN "0010" =>
                produto_valido <= '1';
            WHEN "0011" =>
                produto_valido <= '1';
            WHEN "0100" =>
                produto_valido <= '1';
            WHEN OTHERS =>
                produto_valido <= '0';
        END CASE;
    END PROCESS;

END ARCHITECTURE rtl;