library iEEE;
use ieee.std_logic_1164.all;


entity Convert is 
    port ( chaves : in std_logic_vector(3 downto 0);
    leds : out std_logic_vector (0 to 6)
    );
end entity;

architecture hardware of Convert is
begin 
    process (chaves)
    begin
        if(chaves = "0000") then leds <= "0000001";
        elsif (chaves = "0001") then leds <= "1001111";
        elsif (chaves = "0010") then leds <= "0010010";
        elsif (chaves = "0011") then leds <= "0000110";
        elsif (chaves = "0100") then leds <= "1001100";
        elsif (chaves = "0101") then leds <= "0100100";
        elsif (chaves = "0110") then leds <= "0100000";
        elsif (chaves = "0111") then leds <= "0001111";
        elsif (chaves = "1000") then leds <= "0000000";
        elsif (chaves = "1001") then leds <= "0000100";
        else leds <= "1111111";
        end if;
    end process;
end hardware; 
