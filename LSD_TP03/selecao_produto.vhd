library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity selecao_produto is
port (
pino1: in std_logic;
pino2: in std_logic;
pino3: in std_logic;
clkProduto: in std_logic;
preco_produto: out unsigned(7 downto 0)
);
end entity selecao_produto;

architecture rtl of selecao_produto is
begin
process (pino1, pino2, pino3)
begin
    if rising_edge(clkProduto) then
        if (pino1 = '0' and pino2 = '0' and pino3 = '0') then
            preco_produto <= to_unsigned(1, 8);  -- Produto 1
        elsif (pino1 = '0' and pino2 = '0' and pino3 = '1') then
            preco_produto <= to_unsigned(2, 8);  -- Produto 2
        elsif (pino1 = '0' and pino2 = '1' and pino3 = '0') then
            preco_produto <= to_unsigned(3, 8);  -- Produto 3
        elsif (pino1 = '0' and pino2 = '1' and pino3 = '1') then
            preco_produto <= to_unsigned(5, 8);  -- Produto 4
        elsif (pino1 = '1' and pino2 = '0' and pino3 = '0') then
            preco_produto <= to_unsigned(10, 8);  -- Produto 5
        elsif (pino1 = '1' and pino2 = '0' and pino3 = '1') then
            preco_produto <= to_unsigned(15, 8);  -- Produto 6
        else
        preco_produto <= (others => '0');
        end if;
    end if;
end process;
end architecture rtl;