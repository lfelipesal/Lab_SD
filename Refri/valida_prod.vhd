library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity valida_prod is
    port (
        reg_prod : in std_logic_vector(2 downto 0);
        produto_valido : out std_logic
        
    );
end entity valida_prod;

architecture rtl of valida_prod is
    
begin

    proc_valida: process(reg_prod)
    begin
    case reg_prod is
        when "0000" =>
        produto_valido <= '1';
        when "0001" =>
        produto_valido <= '1';
        when "0010" =>
        produto_valido <= '1';
        when "0011" =>
        produto_valido <= '1';
        when "0100" =>
        produto_valido <= '1';
        when others =>
        produto_valido <= '0';
    end case;
end process;
    
end architecture rtl;