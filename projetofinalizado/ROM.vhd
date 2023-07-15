LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ROM IS
    PORT (
        produto_escolhido : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        preco_produto : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        produto_existente : OUT STD_LOGIC
    );
END ENTITY ROM;

ARCHITECTURE rtl OF ROM IS

BEGIN
    proc_rom : PROCESS (produto_escolhido)
    BEGIN
        CASE produto_escolhido IS
            WHEN "0000" =>
                preco_produto <= "0001";
                produto_existente <= '1';
            WHEN "0001" =>
                preco_produto <= "0010";
                produto_existente <= '1';
            WHEN "0010" =>
                preco_produto <= "0101";
                produto_existente <= '1';
            WHEN "0011" =>
                preco_produto <= "1010";
                produto_existente <= '1';
            WHEN "0100" =>
                preco_produto <= "1111";
                produto_existente <= '1';
            WHEN OTHERS =>
                preco_produto <= "0000";
                produto_existente <= '0';
        END CASE;
    END PROCESS proc_rom;
END ARCHITECTURE rtl;