--library declaration 
library IEEE; 
use IEEE.std_logic_1164.all;

--entity 
entity semaforo_clock is port (
    clock_c     : in  std_logic;                -- Clock de entrada
    reset_c    : in  std_logic;                -- Sinal de reset síncrono
    led_g_c     : out std_logic;                -- LED verde
    led_y_c     : out std_logic;                -- LED amarelo
    led_r_c     : out std_logic;                -- LED vermelho
    seg_out_c   : out std_logic_vector(0 to 6)  -- Saída para o display de 7 segmentos
  );
end semaforo_clock;



--architecture 
architecture arch of semaforo_clock is  
component semaforo_fsm
port (
    clock     : in  std_logic;                -- Clock de entrada
    reset     : in  std_logic;                -- Sinal de reset síncrono
    led_g     : out std_logic;                -- LED verde
    led_y     : out std_logic;                -- LED amarelo
    led_r     : out std_logic;                -- LED vermelho
    seg_out   : out std_logic_vector(0 to 6)  -- Saída para o display de 7 segmentos
  );
end component; 
component divisor_clock
port ( clk50MHz : in std_logic;
       reset : in std_logic;
       clk1Hz : out std_logic
     );
end component;
signal div : std_logic;
begin 
t1: divisor_clock port map (clk50MHz => clock_c, reset => reset_c, clk1Hz => div);
ti: semaforo_fsm port map( clock => div, reset => reset_c, led_g => led_g_c, led_y => led_y_c, led_r => led_r_c , seg_out => seg_out_c);

end arch;
