LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY datapath IS
    PORT (
        moeda_1 : IN STD_LOGIC; -- Valor 1 da moeda
        moeda_2 : IN STD_LOGIC; -- Valor 2 da moeda
        moeda_3 : IN STD_LOGIC; -- Valor 5 da moeda
        moeda_4 : IN STD_LOGIC; -- Valor 10 da moeda
        selecao_produto1 : IN STD_LOGIC; -- Seleção do produto
        selecao_produto2 : IN STD_LOGIC; -- Seleção do produto
        selecao_produto3 : IN STD_LOGIC; -- Seleção do produto
        clock01 : IN STD_LOGIC;
        reset01 : IN STD_LOGIC;
        saida_comparador : OUT STD_LOGIC; -- Saída do comparador
        segmento_A : OUT STD_LOGIC;
        segmento_B : OUT STD_LOGIC;
        segmento_C : OUT STD_LOGIC;
        segmento_D : OUT STD_LOGIC;
        segmento_E : OUT STD_LOGIC;
        segmento_F : OUT STD_LOGIC;
        segmento_G : OUT STD_LOGIC;
        DATA_WIDTH : in INTEGER;
        troco : OUT unsigned(7 DOWNTO 0)
    );
END datapath;

ARCHITECTURE bdf_type OF datapath IS
    COMPONENT registrador
        GENERIC (DATA_WIDTH : INTEGER);
        PORT (
            clock : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            coin : IN unsigned(7 DOWNTO 0);
            productPrice : IN unsigned(7 DOWNTO 0);
            price : OUT unsigned(7 DOWNTO 0);
            sum : OUT unsigned(7 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT calcula_troco
        PORT (
            change : OUT unsigned(7 DOWNTO 0);
            coinSum : IN unsigned(7 DOWNTO 0);
            productPrice : IN unsigned(7 DOWNTO 0);
            segmentA : OUT STD_LOGIC;
            segmentB : OUT STD_LOGIC;
            segmentC : OUT STD_LOGIC;
            segmentD : OUT STD_LOGIC;
            segmentE : OUT STD_LOGIC;
            segmentF : OUT STD_LOGIC;
            segmentG : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT insercao_moeda
        PORT (
            pino4 : IN STD_LOGIC;
            pino5 : IN STD_LOGIC;
            pino6 : IN STD_LOGIC;
            pino7 : IN STD_LOGIC;
            coinSum : INOUT unsigned(7 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT selecao_produto
        PORT (
            pino1 : IN STD_LOGIC;
            pino2 : IN STD_LOGIC;
            pino3 : IN STD_LOGIC;
            produto_preco : OUT unsigned(7 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT comparador
        GENERIC (NUM_COINS : INTEGER);
        PORT (
            coinSum : IN unsigned(7 DOWNTO 0);
            productPrice : IN unsigned(7 DOWNTO 0);
            dispense : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL SYNTHESIZED_WIRE_0 : unsigned(7 DOWNTO 0);
    SIGNAL SYNTHESIZED_WIRE_1 : unsigned(7 DOWNTO 0);
    SIGNAL SYNTHESIZED_WIRE_6 : unsigned(7 DOWNTO 0);
    SIGNAL SYNTHESIZED_WIRE_7 : unsigned(7 DOWNTO 0);
BEGIN
    b2v_inst : registrador
    GENERIC MAP(DATA_WIDTH => 8)
    PORT MAP(
        clock => clock01,
        reset => reset01,
        coin => SYNTHESIZED_WIRE_0,
        productPrice => SYNTHESIZED_WIRE_1,
        price => SYNTHESIZED_WIRE_7,
        sum => SYNTHESIZED_WIRE_6);

    b2v_inst2 : calcula_troco
    PORT MAP(
        change => troco,
        coinSum => SYNTHESIZED_WIRE_6,
        productPrice => SYNTHESIZED_WIRE_7,
        segmentA => segmento_A,
        segmentB => segmento_B,
        segmentC => segmento_C,
        segmentD => segmento_D,
        segmentE => segmento_E,
        segmentF => segmento_F,
        segmentG => segmento_G);

    b2v_inst4 : insercao_moeda
    PORT MAP(
        pino4 => moeda_1,
        pino5 => moeda_2,
        pino6 => moeda_3,
        pino7 => moeda_4,
        coinSum => SYNTHESIZED_WIRE_0);

    b2v_inst5 : selecao_produto
    PORT MAP(
        pino1 => selecao_produto1,
        pino2 => selecao_produto2,
        pino3 => selecao_produto3,
        produto_preco => SYNTHESIZED_WIRE_1);

    b2v_inst7 : comparador
    GENERIC MAP(NUM_COINS => 8)
    PORT MAP(
        coinSum => SYNTHESIZED_WIRE_6,
        productPrice => SYNTHESIZED_WIRE_7,
        dispense => saida_comparador);
END bdf_type;