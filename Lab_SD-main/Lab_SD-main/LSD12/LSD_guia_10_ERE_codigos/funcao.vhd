-- vsg_off
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- f(x)=r*x*not(x), sendo r=2 (x representado com 4 bits)

entity funcao is
port (
	x	:	in	std_logic_vector(3 downto 0);
	f	:	out	std_logic_vector(7 downto 0)
	);
end funcao;

architecture beh of funcao is
begin
	f <= std_logic_vector(shift_left((unsigned(x) * unsigned(not(x))),1));
end beh;
