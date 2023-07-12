library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity valida_ficha is
    port (
        reg_ficha: in std_logic_vector(3 downto 0);
        ficha_valida : out std_logic
    );
end entity valida_ficha;

architecture rtl of valida_ficha is
    
begin
    proc_valida: process(reg_ficha)
    begin
    case reg_ficha is
        when "0001" =>
        ficha_valida <= '1';
        when "0010" =>
        ficha_valida <= '1';
        when "0101" =>
        ficha_valida <= '1';
        when "1010" =>
        ficha_valida <= '1';
        when others =>
        ficha_valida <= '0';
    end case;
    end process;
    
end architecture rtl;