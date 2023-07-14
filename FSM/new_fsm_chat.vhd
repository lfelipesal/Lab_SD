LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY fsm IS
  PORT (
    clock : IN STD_LOGIC;
    reset : IN STD_LOGIC;
    enter : IN STD_LOGIC;
    ficha : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    produto : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    tempo_expirado : IN STD_LOGIC;
    valor_valido : IN STD_LOGIC;
    ficha_acumulada : IN STD_LOGIC;
    troco_calculado : IN STD_LOGIC;

    display_troco : OUT STD_LOGIC_VECTOR(0 TO 6);
    display_codigo_produto : OUT STD_LOGIC_VECTOR(0 TO 6);
    display_valor_produto : OUT STD_LOGIC_VECTOR(0 TO 6);
    display_valor_acumulado : OUT STD_LOGIC_VECTOR(0 TO 6);
    led_end : OUT STD_LOGIC;
    led_insert : OUT STD_LOGIC
  );
END ENTITY fsm;

ARCHITECTURE rtl OF fsm IS
  COMPONENT data IS
    PORT (
      ctrl : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      produto : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      ficha : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      enter : IN STD_LOGIC;
      clock : IN STD_LOGIC;
      reset : IN STD_LOGIC;
      ld_val_prod : OUT STD_LOGIC;
      ld_troco : OUT STD_LOGIC;
      ld_display_prod : OUT STD_LOGIC;
      ld_display_val : OUT STD_LOGIC;
      ld_display_val_ac : OUT STD_LOGIC;
      ld_display_troco : OUT STD_LOGIC;
      ld_acumulador : OUT STD_LOGIC;
      ld_timer : OUT STD_LOGIC;
      ficha_valida : OUT STD_LOGIC;
      produto_valido : OUT STD_LOGIC;
      compra_valida : OUT STD_LOGIC;
      Cinco_time : OUT STD_LOGIC;
      display_prod : OUT STD_LOGIC_VECTOR(0 TO 6);
      display_val : OUT STD_LOGIC_VECTOR(0 TO 6);
      display_val_ac : OUT STD_LOGIC_VECTOR(0 TO 6);
      display_troco : OUT STD_LOGIC_VECTOR(0 TO 6)
    );
  END COMPONENT;

  TYPE state_type IS (inicial, produto_escolhido, valida_produto, produto_valido, recebe_ficha, valida_ficha, acumula_ficha, calcula_troco, espera_timer);

  SIGNAL current_state, next_state : state_type;

  SIGNAL clk_signal, reset_signal : STD_LOGIC;
  SIGNAL ld_val_prod, ld_troco, ld_display_prod, ld_display_val, ld_display_val_ac, ld_display_troco : STD_LOGIC;
  SIGNAL ld_acumulador, ld_timer, ficha_valida, produto_valido, compra_valida, Cinco_time : STD_LOGIC;
  SIGNAL display_prod, display_val, display_val_ac, display_troco : STD_LOGIC_VECTOR(0 TO 6);

BEGIN
  my_data : data
  PORT MAP(
    ctrl => STD_LOGIC_VECTOR(to_unsigned(to_integer(unsigned(current_state)), 3)), -- Converter o estado atual para std_logic_vector
    produto => produto,
    ficha => ficha,
    enter => enter,
    clock => clock,
    reset => reset,
    ld_val_prod => ld_val_prod,
    ld_troco => ld_troco,
    ld_display_prod => ld_display_prod,
    ld_display_val => ld_display_val,
    ld_display_val_ac => ld_display_val_ac,
    ld_display_troco => ld_display_troco,
    ld_acumulador => ld_acumulador,
    ld_timer => ld_timer,
    ficha_valida => ficha_valida,
    produto_valido => produto_valido,
    compra_valida => compra_valida,
    Cinco_time => Cinco_time,
    display_prod => display_prod,
    display_val => display_val,
    display_val_ac => display_val_ac,
    display_troco => display_troco
  );

  PROCESS (clock, reset)
  BEGIN
    IF reset = '1' THEN
      clk_signal <= '0';
      reset_signal <= '0';
      current_state <= inicial;
    ELSIF rising_edge(clock) THEN
      clk_signal <= clock;
      reset_signal <= reset;
      current_state <= next_state;
    END IF;
  END PROCESS;

  PROCESS (current_state, clk_signal, reset_signal, enter, ficha, produto, tempo_expirado, valor_valido, ficha_acumulada, troco_calculado)
  BEGIN
    CASE current_state IS
      WHEN inicial =>
        display_troco <= (OTHERS => '0');
        display_codigo_produto <= (OTHERS => '0');
        display_valor_produto <= (OTHERS => '0');
        display_valor_acumulado <= (OTHERS => '0');
        led_end <= '0';
        led_insert <= '0';
        IF enter = '1' THEN
          next_state <= produto_escolhido;
        ELSE
          next_state <= inicial;
        END IF;

      WHEN produto_escolhido =>
        ld_display_prod <= '1';
        next_state <= valida_produto;

      WHEN valida_produto =>
        IF produto_valido = '1' THEN
          next_state <= produto_valido;
        ELSE
          next_state <= recebe_ficha;
        END IF;

      WHEN produto_valido =>
        display_codigo_produto <= produto;
        display_valor_produto <= display_val;
        ld_display_val_ac <= '1';
        next_state <= recebe_ficha;

      WHEN recebe_ficha =>
        IF enter = '0' THEN
          next_state <= valida_ficha;
        ELSE
          next_state <= recebe_ficha;
        END IF;

      WHEN valida_ficha =>
        IF ficha_valida = '1' THEN
          next_state <= acumula_ficha;
        ELSE
          next_state <= recebe_ficha;
        END IF;

      WHEN acumula_ficha =>
        IF compra_valida = '1' THEN
          next_state <= calcula_troco;
        ELSE
          next_state <= recebe_ficha;
        END IF;

      WHEN calcula_troco =>
        ld_display_troco <= '1';
        led_insert <= '0';
        ld_timer <= '1';
        led_end <= '1';
        next_state <= espera_timer;

      WHEN espera_timer =>
        IF tempo_expirado = '1' OR (troco_calculado = '1' AND valor_valido = '1') THEN
          next_state <= inicial;
        ELSE
          next_state <= espera_timer;
        END IF;

      WHEN OTHERS =>
        next_state <= inicial;
    END CASE;
  END PROCESS;

  display_troco <= display_troco;
  display_codigo_produto <= display_codigo_produto;
  display_valor_produto <= display_valor_produto;
  display_valor_acumulado <= display_valor_ac;

END ARCHITECTURE rtl;