library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity semaforo_fsm is
  port (
    clock     : in  std_logic;                -- Clock de entrada
    reset     : in  std_logic;                -- Sinal de reset síncrono
    led_g     : out std_logic;                -- LED verde
    led_y     : out std_logic;                -- LED amarelo
    led_r     : out std_logic;                -- LED vermelho
    seg_out   : out std_logic_vector(0 to 6)  -- Saída para o display de 7 segmentos
  );
end entity semaforo_fsm;

architecture behavioral of semaforo_fsm is
  type state_type is (s_verde, s_amarelo, s_vermelho);
  signal current_state : state_type := s_vermelho;
  signal counter : integer range 0 to 255 := 0;
  signal seg_out_internal : std_logic_vector(0 to 6) := "0000000";
  
  signal clock_div : std_logic;
  signal reset_div : std_logic;

begin

    divisor_clock_inst : entity work.divisor_clock
        port map(clk50MHz => clock, reset => reset_div, clk1Hz => clock_div);
    
  process(clock)
  begin
    if rising_edge(clock) then
      if reset_div = '1' then
        current_state <= s_vermelho;
        counter <= 0;
      else
        case current_state is
          when s_verde =>
            if counter >= 8 then
              current_state <= s_amarelo;
              counter <= 0;
            else
              counter <= counter + 1;
            end if;
          when s_amarelo =>
            if counter >= 3 then
              current_state <= s_vermelho;
              counter <= 0;
            else
              counter <= counter + 1;
            end if;
          when s_vermelho =>
            if counter >= 6 then
              current_state <= s_verde;
              counter <= 0;
            else
              counter <= counter + 1;
            end if;
        end case;
      end if;
    end if;
  end process;

  -- Lógica de controle dos LEDs com contagem regressiva
  process(current_state, counter)
  begin
    case current_state is
      when s_verde =>
        led_g <= '1';
        led_y <= '0';
        led_r <= '0';
        case counter is
          when 0 =>
            seg_out_internal <= "0001100"; -- 9
          when 1 =>
            seg_out_internal <= "0000000"; -- 8
          when 2 =>
            seg_out_internal <= "0001111"; -- 7
          when 3 =>
            seg_out_internal <= "0100000"; -- 6
          when 4 =>
            seg_out_internal <= "0100100"; -- 5
          when 5 =>
            seg_out_internal <= "1001100"; -- 4
          when 6 =>
            seg_out_internal <= "0000110"; -- 3
          when 7 =>
            seg_out_internal <= "0010010"; -- 2
          when 8 =>
            seg_out_internal <= "1001111"; -- 1
          when 9 =>
            seg_out_internal <= "0000001"; -- 0
          when others =>
            seg_out_internal <= "0001001"; -- Error
        end case;
      when s_amarelo =>
        led_g <= '0';
        led_y <= '1';
        led_r <= '0';
        case counter is
          when 0 =>
            seg_out_internal <= "1001100"; -- 4
          when 1 =>
            seg_out_internal <= "0000110"; -- 3
          when 2 =>
            seg_out_internal <= "0010010"; -- 2
          when 3 =>
            seg_out_internal <= "1001111"; -- 1
          when 4 =>
            seg_out_internal <= "0000001"; -- 0
          when others =>
            seg_out_internal <= "0001001"; -- Error
        end case;
      when s_vermelho =>
        led_g <= '0';
        led_y <= '0';
        led_r <= '1';
        case counter is
          when 0 =>
            seg_out_internal <= "0001111"; -- 7
          when 1 =>
            seg_out_internal <= "0100000"; -- 6
          when 2 =>
            seg_out_internal <= "0100100"; -- 5
          when 3 =>
            seg_out_internal <= "1001100"; -- 4
          when 4 =>
            seg_out_internal <= "0000110"; -- 3
          when 5 =>
            seg_out_internal <= "0010010"; -- 2
          when 6 =>
            seg_out_internal <= "1001111"; -- 1
          when 7 =>
            seg_out_internal <= "0000001"; -- 0
when others =>
            seg_out_internal <= "0001001"; -- Error
        end case;
    end case;
  end process;

  seg_out <= seg_out_internal;
 end architecture behavioral;