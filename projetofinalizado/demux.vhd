library ieee;
use ieee.std_logic_1164.all;

entity Demux is
    port (
        enter  : in  std_logic;
        ctrl   : in  std_logic;
        ficha  : out std_logic;
        produto: out std_logic
    );
end entity Demux;

architecture Behavioral of Demux is
begin
    process (enter, ctrl)
    begin
        if ctrl = '0' then
            ficha <= enter;
            produto <= '0';
        else
            ficha <= '0';
            produto <= enter;
        end if;
    end process;
end architecture Behavioral;
