library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity divisor_clock is
port ( clk50MHz : in std_logic;
       reset : in std_logic;
       clk1Hz : out std_logic
     );
end divisor_clock;

architecture Behavioral of divisor_clock is

--signal count : integer := 0;
signal b : std_logic := '0';
begin

 -- clk generation. For 50MHz clock this process generates 1Hz clock.
process(clk50MHz, b)
	variable cnt : integer range 0 to 2**26-1;
	begin
		if(rising_edge(clk50MHz)) then
		   if(reset = '1') then
			   cnt := 0;
			else
			   cnt := cnt + 1;
         end if;
			if(cnt = 24999999) then
				b <= not b;
				cnt := 0;
			end if;
		end if;
		clk1Hz <= b;
	end process;
end;
