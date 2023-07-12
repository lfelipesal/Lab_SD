library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity contador is
    port (
        clock: in std_logic;
        reset: in std_logic;
        gt_or_eq: out std_logic
    );
end entity contador;

architecture rtl of contador is
begin
    contagem: process (clock)
    variable conta: integer range 0 to 10;
    begin
        if reset = '1' then
            conta := 0;
        elsif rising_edge(clock) then
            conta := conta + 1;
            if conta >= 5 then
                gt_or_eq <= '1';
                conta := 0;
            end if;
        end if;

    end process;
    
end architecture rtl;