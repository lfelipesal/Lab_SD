library ieee;
use ieee.std_logic_1164.all;

entity tb_semaforo is
end entity tb_semaforo;

architecture tb_arch of tb_semaforo is
  -- Signals
  signal clock       : std_logic := '0';
  signal reset       : std_logic := '0';
  signal led_g       : std_logic;
  signal led_y       : std_logic;
  signal led_r       : std_logic;
  signal seg_out     : std_logic_vector(6 downto 0);
  
  -- Constants
  constant CLK_PERIOD : time := 10 ns;
  
  
  begin

  -- Instantiate the DUT
  uut: entity work.semaforo_fsm
    port map (
      clock     => clock,
      reset     => reset,
      led_g     => led_g,
      led_y     => led_y,
      led_r     => led_r,
      seg_out   => seg_out
    );

  -- Clock process
  clock_process: process
  begin
    while now < 500 ns loop
      clock <= '0';
      wait for CLK_PERIOD / 2;
      clock <= '1';
      wait for CLK_PERIOD / 2;
    end loop;
    wait;
  end process clock_process;
  
  -- Stimulus process
  stimulus_process: process
  begin
    -- Reset
    reset <= '1';
    wait for 20 ns;
    reset <= '0';
    wait for 10 ns;
    
    -- Hold state s_vermelho for a while
    wait for 100 ns;
    
    -- Test s_verde state
    assert led_g = '1' and led_y = '0' and led_r = '0' and seg_out = "1001111"
      report "Error in s_verde state" severity error;
    wait for 100 ns;
    
    -- Test s_amarelo state
    assert led_g = '0' and led_y = '1' and led_r = '0' and seg_out = "0000011"
      report "Error in s_amarelo state" severity error;
    wait for 40 ns;
    
    -- Test s_vermelho state
    assert led_g = '0' and led_y = '0' and led_r = '1' and seg_out = "0111111"
      report "Error in s_vermelho state" severity error;
    wait for 70 ns;
    
    -- Test s_verde state again
    assert led_g = '1' and led_y = '0' and led_r = '0' and seg_out = "1001111"
      report "Error in s_verde state" severity error;
    wait for 90 ns;
    
    -- Finish simulation
    wait;
  end process stimulus_process;

end architecture tb_arch;