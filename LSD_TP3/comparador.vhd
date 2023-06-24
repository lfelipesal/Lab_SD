library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity comparador_moedas is
generic (
NUM_MOEDAS : integer := 8
);
port (
somaMoedas : in unsigned(NUM_MOEDAS-1 downto 0);
precoProduto : in unsigned(NUM_MOEDAS-1 downto 0);
liberarProduto : out std_logic
);
end entity comparador_moedas;

architecture comportamental of comparador_moedas is
begin
process (somaMoedas, precoProduto)
begin
if unsigned(somaMoedas) >= unsigned(precoProduto) then
liberarProduto <= '1';
else
liberarProduto <= '0';
end if;
end process;
end architecture comportamental;