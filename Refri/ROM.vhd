library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ROM is
    port (
        produto_escolhido: in std_logic_vector(3 downto 0);
        preco_produto: out std_logic_vector(3 downto 0);
        produto_existente: out std_logic
    );
end entity ROM;

architecture rtl of ROM is
    
begin
   proc_rom: process(produto_escolhido)
   begin
        case produto_escolhido is
            when "0000" =>
            preco_produto <= "0001";
            produto_existente <= '1';
            when "0001" =>
            preco_produto <= "0010";
            produto_existente <= '1';
            when "0010" =>
            preco_produto <= "0101";
            produto_existente <= '1';
            when "0011" =>
            preco_produto <= "1010";
            produto_existente <= '1';
            when "0100" =>
            preco_produto <= "1111";
            produto_existente <= '1';
            when others =>
            preco_produto <= "0000";
            produto_existente <= '0';
        end case;
    end process proc_rom;
    
    
end architecture rtl;