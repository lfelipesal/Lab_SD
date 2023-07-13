LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY fsm IS
  PORT (
    --entradas
    clock : IN STD_LOGIC;
    reset : IN STD_LOGIC;
    enter : IN STD_LOGIC;
    ficha : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    produto : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    tempo_expirado : IN STD_LOGIC;

    --saidas
    valor_valido : IN STD_LOGIC;
    ficha_acumulada : IN STD_LOGIC;
    troco_calculado : IN STD_LOGIC;
    display_troco : OUT STD_LOGIC_VECTOR(0 TO 6);
    display_codigo_produto : OUT STD_LOGIC_VECTOR(0 TO 6);
    display_valor_produto : OUT STD_LOGIC_VECTOR(0 TO 6);
    display_valor_acumulado : OUT STD_LOGIC_VECTOR(0 TO 6);
    led_end : OUT STD_LOGIC;
    led_insert : OUT STD_LOGIC;
  );
END ENTITY fsm;

ARCHITECTURE rtl OF fsm IS

  TYPE state_type IS (inicial, produto_escolhido, valida_produto, produto_valido, recebe_ficha, valida_ficha, acumula_ficha, calcula_troco, espera_timer);

  SIGNAL current_state, next_state : state_type;

  SIGNAL next_state_logic : STD_LOGIC;

  SIGNAL ficha_valida_reg : STD_LOGIC;

  SIGNAL ficha_acumulada_reg : STD_LOGIC;

  SIGNAL calcula_troco_reg : STD_LOGIC;

BEGIN
  PROCESS (clk, reset)
  BEGIN
    IF (RESET = '1') THEN
      current_state <= INITIAL;
    ELSIF rising_edge(clk) THEN
      current_state <= next_state;
    END IF;
  END PROCESS;
END ARCHITECTURE rtl;