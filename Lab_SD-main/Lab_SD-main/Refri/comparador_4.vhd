library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity comparador_4 is
    port (
        valor1: in std_logic_vector(3 downto 0);
        valor2: in std_logic_vector(3 downto 0);
        lt: out std_logic;
        gt: out std_logic;
        eq: out std_logic
    );
end entity comparador_4;

architecture rtl of comparador_4 is
begin
   compara: process(valor1, valor2)
   begin
    if (valor1 > valor2) then
        lt <= '0';
        gt <= '1';
        eq <= '0';
    elsif (valor1 < valor2) then
        lt <= '1';
        gt <= '0';
        eq <= '0';
    else
        lt <= '0';
        gt <= '0';
        eq <= '1';
    end if;
       
   end process compara;
    
end architecture rtl;