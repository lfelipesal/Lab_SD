LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY VendingMachine IS
  PORT (
    clk : IN STD_LOGIC;
    reset : IN STD_LOGIC;
    enter : IN STD_LOGIC;
    coin_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    product_selected : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    display_change : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
    display_product_code : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
    display_product_value : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
    display_accumulated_value : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
    led_end : OUT STD_LOGIC;
    led_insert : OUT STD_LOGIC
  );
END ENTITY VendingMachine;

ARCHITECTURE fsm OF VendingMachine IS
  TYPE state_type IS (INITIAL, PRODUCT_CHOSEN, VALIDATE_PRODUCT, PRODUCT_VALID, RECEIVE_COIN,
    VALIDATE_COIN, ACCUMULATE_COIN, CALCULATE_CHANGE, WAIT_TIMER);
  SIGNAL current_state, next_state : state_type;
  SIGNAL next_state_logic : STD_LOGIC;

  SIGNAL product_reg : STD_LOGIC_VECTOR(2 DOWNTO 0);
  SIGNAL coin_reg : STD_LOGIC_VECTOR(3 DOWNTO 0);
  SIGNAL change_reg : STD_LOGIC_VECTOR(3 DOWNTO 0);
  SIGNAL product_value_reg : STD_LOGIC_VECTOR(3 DOWNTO 0);
  SIGNAL coin_accumulator_reg : STD_LOGIC_VECTOR(3 DOWNTO 0);
  SIGNAL display_change_reg : STD_LOGIC_VECTOR(6 DOWNTO 0);
  SIGNAL display_product_value_reg : STD_LOGIC_VECTOR(6 DOWNTO 0);
  SIGNAL display_accumulated_value_reg : STD_LOGIC_VECTOR(6 DOWNTO 0);
  SIGNAL product_code_reg : STD_LOGIC_VECTOR(3 DOWNTO 0);
  SIGNAL led_end_reg : STD_LOGIC;
  SIGNAL led_insert_reg : STD_LOGIC;

BEGIN
  PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      current_state <= INITIAL;
    ELSIF rising_edge(clk) THEN
      current_state <= next_state;
    END IF;
  END PROCESS;

  PROCESS (current_state, coin_in, product_selected, enter)
  BEGIN
    next_state_logic <= '0';
    display_change <= display_change_reg;
    display_product_code <= product_code_reg & '0' & '0';
    display_product_value <= display_product_value_reg;
    display_accumulated_value <= display_accumulated_value_reg;
    led_end <= led_end_reg;
    led_insert <= led_insert_reg;

    CASE current_state IS
      WHEN INITIAL =>
        IF enter = '1' THEN
          next_state <= PRODUCT_CHOSEN;
          next_state_logic <= '1';
        ELSE
          next_state <= INITIAL;
        END IF;

      WHEN PRODUCT_CHOSEN =>
        next_state <= VALIDATE_PRODUCT;
        next_state_logic <= '1';

      WHEN VALIDATE_PRODUCT =>
        IF product_selected = "11" THEN
          next_state <= PRODUCT_VALID;
          next_state_logic <= '1';
          product_code_reg <= product_selected;
          led_insert_reg <= '1';
        ELSE
          next_state <= RECEIVE_COIN;
          next_state_logic <= '1';
          product_code_reg <= (OTHERS => '0');
          led_insert_reg <= '0';
        END IF;

      WHEN PRODUCT_VALID =>
        next_state <= RECEIVE_COIN;
        next_state_logic <= '1';

      WHEN RECEIVE_COIN =>
        IF coin_in = "0001" OR coin_in = "0010" OR coin_in = "0011" OR
          coin_in = "0101" OR coin_in = "1010" THEN
          next_state <= VALIDATE_COIN;
          next_state_logic <= '1';
        ELSE
          next_state <= RECEIVE_COIN;
        END IF;

      WHEN VALIDATE_COIN =>
        coin_reg <= coin_in;
        next_state <= ACCUMULATE_COIN;
        next_state_logic <= '1';

      WHEN ACCUMULATE_COIN =>
        coin_accumulator_reg <= coin_reg;
        next_state <= CALCULATE_CHANGE;
        next_state_logic <= '1';

      WHEN CALCULATE_CHANGE =>
        change_reg <= coin_accumulator_reg - product_value_reg;
        display_change_reg <= change_reg;
        next_state <= WAIT_TIMER;
        next_state_logic <= '1';

      WHEN WAIT_TIMER =>
        IF enter = '1' THEN
          next_state <= INITIAL;
          next_state_logic <= '1';
          coin_accumulator_reg <= (OTHERS => '0');
          led_end_reg <= '1';
        ELSIF change_reg = (OTHERS => '0') THEN
          next_state <= WAIT_TIMER;
        ELSE
          next_state <= INITIAL;
          next_state_logic <= '1';
          led_end_reg <= '0';
        END IF;

      WHEN OTHERS =>
        next_state <= INITIAL;
    END CASE;
  END PROCESS;

  product_reg <= product_selected;
  product_value_reg <= product_reg;
  display_product_value_reg <= product_value_reg;
  display_accumulated_value_reg <= coin_accumulator_reg;

  next_state <= next_state_logic & '0' & '0';

END ARCHITECTURE fsm;