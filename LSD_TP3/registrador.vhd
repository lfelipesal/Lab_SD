LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY registrador IS
    GENERIC (
        LARGURA_DADOS : NATURAL := 8
    );
    PORT (
        moeda : IN unsigned(LARGURA_DADOS - 1 DOWNTO 0);
        precoProduto : IN unsigned(LARGURA_DADOS - 1 DOWNTO 0);
        clock : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        soma : OUT unsigned(LARGURA_DADOS - 1 DOWNTO 0);
        preco : OUT unsigned(LARGURA_DADOS - 1 DOWNTO 0)
    );
END ENTITY registrador;

ARCHITECTURE behavioral OF registrador IS
    SIGNAL soma_reg : unsigned(LARGURA_DADOS - 1 DOWNTO 0);
    SIGNAL preco_reg : unsigned(LARGURA_DADOS - 1 DOWNTO 0);
BEGIN
    PROCESS (clock, reset)
    BEGIN
        IF reset = '1' THEN
            soma_reg <= (OTHERS => '0');
            preco_reg <= (OTHERS => '0');
        ELSIF rising_edge(clock) THEN
            soma_reg <= soma_reg + moeda;
            preco_reg <= precoProduto;
        END IF;
    END PROCESS;
    soma <= soma_reg;
    preco <= preco_reg;
END ARCHITECTURE behavioral;