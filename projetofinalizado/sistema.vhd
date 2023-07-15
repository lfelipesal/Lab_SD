LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY sistema IS
  PORT (
    --entradas
    clock : IN STD_LOGIC;--
    reset : IN STD_LOGIC;--
    enter : IN STD_LOGIC;--

    produto : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    ficha : IN STD_LOGIC_VECTOR(3 DOWNTO 0);--

    display_prod : OUT STD_LOGIC_VECTOR(0 TO 6);
    display_troco : OUT STD_LOGIC_VECTOR(0 TO 6);
    display_val : OUT STD_LOGIC_VECTOR(0 TO 6);
    display_val_ac : OUT STD_LOGIC_VECTOR(0 TO 6);

    led_end : OUT STD_LOGIC;--
    led_insert : OUT STD_LOGIC--
  );
END ENTITY sistema;

ARCHITECTURE arch_sistema OF sistema IS

  COMPONENT fsm 
    PORT (
      clock : IN STD_LOGIC;--
      reset : IN STD_LOGIC;--
      enter : IN STD_LOGIC;--
      ficha_valida : IN STD_LOGIC;--
      produto_valido : IN STD_LOGIC;--
      compra_valida : IN STD_LOGIC;--
      Cinco_time : IN STD_LOGIC;
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
      led_insert : OUT STD_LOGIC--
    );
  END COMPONENT;

  COMPONENT data 
    PORT (
      ctrl : IN STD_LOGIC;
      produto : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      ficha : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      enter : IN STD_LOGIC;

      clock : IN STD_LOGIC;
      reset : IN STD_LOGIC;

      ld_val_prod : IN STD_LOGIC;
      ld_troco : IN STD_LOGIC;
      ld_display_prod : IN STD_LOGIC;
      ld_display_val : IN STD_LOGIC;
      ld_display_val_ac : IN STD_LOGIC;
      ld_display_troco : IN STD_LOGIC;
      ld_acumulador : IN STD_LOGIC;
      ld_timer : IN STD_LOGIC;

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

  COMPONENT DivisorClock 
    PORT (
      CLOCK_50MHz : IN STD_LOGIC;
      reset : IN STD_LOGIC;
      CLOCK_1Hz : OUT STD_LOGIC
    );
  END COMPONENT;

  SIGNAL controle_signal : STD_LOGIC;
  SIGNAL reset_out_signal : STD_LOGIC;
  SIGNAL ld_val_prod_signal : STD_LOGIC;
  SIGNAL ld_display_prod_signal : STD_LOGIC;
  SIGNAL ld_display_val_signal : STD_LOGIC;
  SIGNAL ld_display_val_ac_signal : STD_LOGIC;
  SIGNAL ld_troco_signal : STD_LOGIC;
  SIGNAL ld_display_troco_signal : STD_LOGIC;
  SIGNAL ld_acumulador_signal : STD_LOGIC;
  SIGNAL ld_timer_signal : STD_LOGIC;
  SIGNAL ficha_valida_signal : STD_LOGIC;
  SIGNAL produto_valido_signal : STD_LOGIC;
  SIGNAL compra_valida_signal : STD_LOGIC;
  SIGNAL Cinco_time_signal : STD_LOGIC;
  SIGNAL CLOCK_1Hz_signal : STD_LOGIC;

BEGIN

  my_clock : DivisorClock
  PORT MAP(
    CLOCK_50MHz => clock,
    reset => reset,
    CLOCK_1Hz => CLOCK_1Hz_signal
  );

  my_fsm : fsm
  PORT MAP(
    clock => CLOCK_1Hz_signal,
    reset => reset,
    enter => enter,
    ficha_valida => ficha_valida_signal,
    produto_valido => produto_valido_signal,
    compra_valida => compra_valida_signal,
    Cinco_time => Cinco_time_signal,
    controle => controle_signal,
    reset_out => reset_out_signal,
    ld_val_prod => ld_val_prod_signal,
    ld_display_prod => ld_display_prod_signal,
    ld_display_val => ld_display_val_signal,
    ld_display_val_ac => ld_display_val_ac_signal,
    ld_troco => ld_troco_signal,
    ld_display_troco => ld_display_troco_signal,
    ld_acumulador => ld_acumulador_signal,
    ld_timer => ld_timer_signal,
    led_end => led_end,
    led_insert => led_insert
  );

  my_data : data
  PORT MAP(
    ctrl => controle_signal,
    produto => produto,
    ficha => ficha,
    enter => enter,
    clock => CLOCK_1Hz_signal,
    reset => reset_out_signal,
    ld_val_prod => ld_val_prod_signal,
    ld_troco => ld_troco_signal,
    ld_display_prod => ld_display_prod_signal,
    ld_display_val => ld_display_val_signal,
    ld_display_val_ac => ld_display_val_ac_signal,
    ld_display_troco => ld_display_troco_signal,
    ld_acumulador => ld_acumulador_signal,
    ld_timer => ld_timer_signal,
    ficha_valida => ficha_valida_signal,
    produto_valido => produto_valido_signal,
    compra_valida => compra_valida_signal,
    Cinco_time => Cinco_time_signal,
    display_prod => display_prod,
    display_val => display_val,
    display_val_ac => display_val_ac,
    display_troco => display_troco
  );

END ARCHITECTURE arch_sistema;