LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY insercao_moeda IS
    PORT (
        entrada_pino4 : IN STD_LOGIC;
        entrada_pino5 : IN STD_LOGIC;
        entrada_pino6 : IN STD_LOGIC;
        entrada_pino7 : IN STD_LOGIC;
        clkMoeda : IN STD_LOGIC;
        somaMoedas : INOUT unsigned(7 DOWNTO 0)
    );
END ENTITY insercao_moeda;

ARCHITECTURE comportamental OF insercao_moeda IS
    SIGNAL moedas : unsigned(7 DOWNTO 0) := (OTHERS => '0');
BEGIN
    PROCESS (entrada_pino4, entrada_pino5, entrada_pino6, entrada_pino7)
    BEGIN
        IF rising_edge(clkMoeda) THEN
            IF (entrada_pino4 = '1') THEN
                moedas <= moedas + 1;
            END IF;
        END IF;
        IF rising_edge(clkMoeda) THEN
            IF (entrada_pino5 = '1') THEN
                moedas <= moedas + 2;
            END IF;
        END IF;
        IF rising_edge(clkMoeda) THEN
            IF (entrada_pino6 = '1') THEN
                moedas <= moedas + 5;
            END IF;
        END IF;
        IF rising_edge(clkMoeda) THEN
            IF (entrada_pino7 = '1') THEN
                moedas <= moedas + 10;
            END IF;
        END IF;
        -- Atribuição correta do valor de moedas a somaMoedas
        somaMoedas <= moedas;
    END PROCESS;
END ARCHITECTURE comportamental;