LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY fsm IS
  PORT (
    --entradas
    clock : IN STD_LOGIC;--
    reset : IN STD_LOGIC;--
    enter : IN STD_LOGIC;--
    --verificar se necessariamente o produto e a ficha não precisam estar aqui e já podem ir direto pro datapath;
    --ld_ficha e ld_prod vêm do demux e não precisam sair da fsm;
    ficha_valida : IN STD_LOGIC;--
    produto_valido : IN STD_LOGIC;--
    compra_valida : IN STD_LOGIC;--
    Cinco_time : IN STD_LOGIC;
    --saidas
    controle : OUT STD_LOGIC;--
    reset_out : OUT STD_LOGIC;
    ld_val_prod : OUT STD_LOGIC;--
    ld_display_prod : OUT STD_LOGIC;--
    ld_display_val : OUT STD_LOGIC;--
    ld_display_val_ac : OUT STD_LOGIC;--
    ld_troco : OUT STD_LOGIC;--
    ld_display_troco : OUT STD_LOGIC;--
    ld_acumulador : OUT STD_LOGIC;--
    ld_timer : OUT STD_LOGIC;--
    led_end : OUT STD_LOGIC;--
    led_insert : OUT STD_LOGIC;--

  );
END ENTITY fsm;

ARCHITECTURE rtl OF fsm IS

  TYPE state_type IS (inicial, produto_escolhido, valida_produto, produto_valido_st, recebe_ficha, valida_ficha, acumula_ficha, calcula_troco, espera_timer);

  SIGNAL current_state, next_state : state_type;

BEGIN
  PROCESS (clk, reset)
  BEGIN
    IF (reset = '1') THEN
      current_state <= inicial;
    ELSIF rising_edge(clk) THEN
      current_state <= next_state;
    END IF;
  END PROCESS;

  PROCESS (current_state, clock, reset, enter, ficha_valida, produto_valido, compra_valida, Cinco_time)
  BEGIN
    reset_out <= '0';
    controle <= '1';
    ld_timer <= '0';
    led_end <= '0';
    ld_val_prod <= '0';
    ld_display_prod <= '0';
    ld_display_val <= '0';
    ld_display_val_ac <= '0';
    ld_troco <= '0';
    ld_display_troco <= '0';
    ld_acumulador <= '0';
    ld_timer <= '0';
    led_end <= '0';
    led_insert <= '0';
    CASE current_state IS
      WHEN inicial =>
        IF (enter = '0') THEN
          reset_out <= '1';
          next_state <= inicial;
        ELSIF (enter = '1') THEN
          next_state <= produto_escolhido;
        END IF;
      WHEN produto_escolhido =>
        next_state <= valida_produto;
      WHEN valida_produto =>
        IF (produto_valido = '1') THEN
          next_state <= produto_valido_st;
        ELSE
          next_state <= inicial;
        END IF;

      WHEN produto_valido_st =>
        ld_val_prod <= '1';
        ld_display_prod <= '1';
        ld_display_val <= '1';
        led_insert <= '1';
        led_insert <= '1';
        next_state <= recebe_ficha;
      WHEN recebe_ficha =>
        controle <= '0';
        led_insert <= '1';
        ld_display_val <= '1';
        IF (enter = '0') THEN
          next_state <= recebe_ficha;
        ELSE
          next_state <= valida_ficha;
        END IF;
        --demux serve como load do reg_ficha e do reg_prod, então está um pouco diferente;
      WHEN valida_ficha =>
        controle <= '0';
        IF (ficha_valida = '1') THEN
          next_state <= acumula_ficha;
        ELSE
          next_state <= recebe_ficha;
        END IF;
      WHEN acumula_ficha =>
        controle <= '0';
        ld_acumulador <= '1';
        IF (compra_valida = '1') THEN
          next_state <= calcula_troco;
        ELSE
          next_state <= recebe_ficha;
        END IF;
      WHEN calcula_troco =>
        ld_troco <= '1';
        ld_display_troco <= '1';
        --verificar se o ld_timer e o led_end podem estar aqui ou precisam ir no espera_timer;
        ld_timer <= '1';
        led_end <= '1';
        next_state <= espera_timer;
      WHEN espera_timer =>
        led_end <= '1';
        IF (Cinco_time = '1') THEN
          next_state <= inicial;
        ELSE
          next_state <= espera_timer;
        END IF;
        --quando for o mesmo estado, eu preciso retornar ao mesmo estado no if, ou não é necessário?
    END CASE;
  END PROCESS;
END ARCHITECTURE rtl;