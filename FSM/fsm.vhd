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
    valor_valido : IN STD_LOGIC;
    ficha_acumulada : IN STD_LOGIC;
    troco_calculado : IN STD_LOGIC;

    --saidas
    -- display_troco : OUT STD_LOGIC_VECTOR(0 TO 6);
    -- display_codigo_produto : OUT STD_LOGIC_VECTOR(0 TO 6);
    -- display_valor_produto : OUT STD_LOGIC_VECTOR(0 TO 6);
    -- display_valor_acumulado : OUT STD_LOGIC_VECTOR(0 TO 6);
    led_end : OUT STD_LOGIC;
    led_insert : OUT STD_LOGIC;
  );
END ENTITY fsm;

ARCHITECTURE rtl OF fsm IS
  COMPONENT data IS PORT (
    --confirmar se todo signal precisa ser associado, a um entrada no componente fsm
    --confirmar
    ctrl : IN STD_LOGIC;
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

    -- display_prod : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
    -- display_val : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
    -- display_val_ac : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
    -- display_troco : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)

    );
  END COMPONENT;

  TYPE state_type IS (inicial, produto_escolhido, valida_produto, produto_valido, recebe_ficha, valida_ficha, acumula_ficha, calcula_troco, espera_timer);

  SIGNAL current_state, next_state : state_type;

  SIGNAL clk_signal : STD_LOGIC;
  SIGNAL reset_signal : STD_LOGIC;

  SIGNAL ld_val_prod : STD_LOGIC;
  SIGNAL ld_troco : STD_LOGIC;
  SIGNAL ld_display_prod : STD_LOGIC;
  SIGNAL ld_display_val : STD_LOGIC;
  SIGNAL ld_display_val_ac : STD_LOGIC;
  SIGNAL ld_display_troco : STD_LOGIC;
  SIGNAL ld_acumulador : STD_LOGIC;
  SIGNAL ld_timer : STD_LOGIC;
  SIGNAL ficha_valida : STD_LOGIC;
  SIGNAL produto_valido : STD_LOGIC;
  SIGNAL compra_valida : STD_LOGIC;
  SIGNAL Cinco_time : STD_LOGIC;
  SIGNAL demux_signal : STD_LOGIC;
  SIGNAL reg_prod : STD_LOGIC_VECTOR(3 DOWNTO 0);
  SIGNAL reg_ficha : STD_LOGIC_VECTOR(3 DOWNTO 0);
  SIGNAL reg_valor_prod : STD_LOGIC_VECTOR(3 DOWNTO 0);
  SIGNAL reg_acu : STD_LOGIC_VECTOR(3 DOWNTO 0);
  SIGNAL reg_troco : STD_LOGIC_VECTOR(3 DOWNTO 0);

  SIGNAL display_prod : STD_LOGIC_VECTOR(6 DOWNTO 0);
  SIGNAL display_val : STD_LOGIC_VECTOR(6 DOWNTO 0);
  SIGNAL display_val_ac : STD_LOGIC_VECTOR(6 DOWNTO 0);
  SIGNAL display_troco : STD_LOGIC_VECTOR(6 DOWNTO 0);
BEGIN
  my_data : data
  PORT MAP(
    ctrl => demux_signal;
    produto => reg_prod;
    ficha => reg_ficha;
    enter => enter;

    clock => clock;
    reset => reset_signal;

    ld_val_prod => ld_val_prod;
    ld_troco => ld_troco;
    ld_display_prod => ld_display_prod;
    ld_display_val => ld_display_val;
    ld_display_val_ac => ld_display_val_ac;
    ld_display_troco => ld_display_troco;
    ld_acumulador => ld_acumulador;
    ld_timer => ld_timer;

    ficha_valida => ficha_valida;
    produto_valido => produto_valido;
    compra_valida => compra_valida;

    Cinco_time => Cinco_time;

    display_prod => display_prod;
    display_val => display_val;
    display_val_ac => display_val_ac;
    display_troco => display_troco;
  )

  PROCESS (clk, reset)
  BEGIN
    IF (RESET = '1') THEN
      current_state <= INITIAL;
    ELSIF rising_edge(clk) THEN
      current_state <= next_state;
    END IF;
  END PROCESS;

  PROCESS (current_state, clock, reset, enter, ficha, produto, tempo_expirado)
  BEGIN
    CASE current_state IS
        --verificar se o current_state precisa ser trocado para next_state
      WHEN inicial =>
        ld_timer <= "0";
        led_end <= "0";
        IF (enter = "0") THEN
          reset_signal <= "1";
        ELSIF (enter = "1") THEN
          reset_signal <= "0";
          current_state <= produto_escolhido;
        END IF;
        -- ctrl <= "0";
        -- produto <= "000";
        -- ficha <= "0000";
        -- enter <= "0";
        -- clock <= "0";
        -- ld_val_prod <= "0";
        -- ld_troco <= "0";
        -- ld_display_prod <= "0";
        -- ld_display_val <= "0";
        -- ld_display_val_ac <= "0";
        -- ld_display_troco <= "0";
        -- ld_acumulador <= "0";
        -- ld_timer <= "0";
        -- ficha_valida <= "0";
        -- produto_valido <= "0";
        -- compra_valida <= "0";
        -- Cinco_time <= "0";
      WHEN produto_escolhido =>
        demux_signal <= '1';
        reg_prod <= produto;
        current_state <= valida_produto;

      WHEN valida_produto =>
        IF (produto_valido = "1") THEN
          current_state <= produto_valido;
        ELSE
          current_state <= inicial;
        END IF;

      WHEN produto_valido =>
        ld_display_prod <= "1";
        current_state <= recebe_ficha;

      WHEN recebe_ficha =>
        IF (enter = "0") THEN
          demux_signal <= "0";
          reg_ficha <= ficha;
          ld_display_val <= "1";
          led_insert <= "1";
        ELSE
          current_state <= valida_ficha;
        END IF;
      WHEN valida_ficha =>
        IF (ficha_valida = "1") THEN
          current_state <= acumula_ficha;
        ELSE
          current_state <= recebe_ficha;
        END IF;
      WHEN acumula_ficha =>
        ld_acumulador <= "1";
        IF (compra_valida = "1") THEN
          current_state <= calcula_troco;
        ELSE
          current_state <= recebe_ficha;
        END IF;
      WHEN calcula_troco =>
        ld_troco <= "1";
        ld_display_troco <= "1";
        led_insert <= "0";
        --verificar se o ld_timer e o led_end podem estar aqui ou precisam ir no espera_timer;
        ld_timer <= "1";
        led_end <= "1";
        current_state <= espera_timer;
      WHEN espera_timer =>
        IF (Cinco_time = "1") THEN
          current_state <= inicial;
        ELSE
          current_state <= espera_timer;
        END IF;
        --quando for o mesmo estado, eu preciso retornar ao mesmo estado no if, ou não é necessário?
    END CASE;
  END PROCESS;
END ARCHITECTURE rtl;