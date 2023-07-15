LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY conversor IS
    PORT (
        binary : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        hex : OUT STD_LOGIC_VECTOR(0 TO 6)
    );
END ENTITY conversor;

ARCHITECTURE Behavioral OF conversor IS
BEGIN
    converte : PROCESS (binary)
    BEGIN
        CASE binary IS
            WHEN "0000" => hex <= "0000001";
            WHEN "0001" => hex <= "1001111";
            WHEN "0010" => hex <= "0010010";
            WHEN "0011" => hex <= "0000110";
            WHEN "0100" => hex <= "1001100";
            WHEN "0101" => hex <= "0100100";
            WHEN "0110" => hex <= "0100000";
            WHEN "0111" => hex <= "0001111";
            WHEN "1000" => hex <= "0000000";
            WHEN "1001" => hex <= "0001100";
            WHEN "1010" => hex <= "0001000";
            WHEN "1011" => hex <= "1100000";
            WHEN "1100" => hex <= "0110001";
            WHEN "1101" => hex <= "1000010";
            WHEN "1110" => hex <= "0010000";
            WHEN "1111" => hex <= "0111000";
            WHEN OTHERS => hex <= "1111111"; -- Valor inválido
        END CASE;
    END PROCESS converte;
END ARCHITECTURE Behavioral;