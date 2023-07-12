library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity registrador_3 is
    port (
        load: in std_logic;
        reset: in std_logic;
        clock: in std_logic;
        entrada: in unsigned(2 downto 0);
        saida: out unsigned(2 downto 0)
    );
end entity registrador_3;

architecture rtl of registrador_3 is
    
begin
    
    
process (clock, reset)
begin
	-- Reset whenever the reset signal goes low, regardless of the clock
	if (reset = '0') then
		saida <= "000";
	-- If not resetting, update the register output on the clock's rising edge
	elsif (rising_edge(clock)) then
		saida <= entrada;
	end if;
end process;

    
end architecture rtl;