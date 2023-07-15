LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY somador IS
    PORT (
        -- valor1: in unsigned(3 downto 0);
        -- valor2: in unsigned(3 downto 0);
        -- resultado: out unsigned(3 downto 0)
        valor1 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        valor2 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        resultado : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END ENTITY somador;

ARCHITECTURE rtl OF somador IS
    --signal result : integer range 0 to 99 :=0;
BEGIN
    --result <= to_integer(unsigned(valor1)) + to_integer(unsigned(valor2));
    resultado <= STD_LOGIC_VECTOR(unsigned(valor1) + unsigned(valor2)); --duvida!!!!
    -- resultado <= valor1 + valor2;

END ARCHITECTURE rtl;