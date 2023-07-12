library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity subtrator is
    port (
        -- valor1: in unsigned(3 downto 0);
        -- valor2: in unsigned(3 downto 0);
        -- resultado: out unsigned(3 downto 0)
        valor1: in std_logic_vector(3 downto 0);
        valor2: in std_logic_vector(3 downto 0);
        resultado: out std_logic_vector(3 downto 0)
    );
end entity subtrator;

architecture rtl of subtrator is
    --signal result : integer range 0 to 99 :=0;
begin
    --result <= to_integer(unsigned(valor1)) - to_integer(unsigned(valor2));
    resultado <= std_logic_vector(unsigned(valor1) - unsigned(valor1)); --duvida!!!!
    -- resultado <= valor1 + valor2;
    
end architecture rtl;