LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY DivisorClock IS
	PORT (
		CLOCK_50MHz : IN STD_LOGIC;
		reset : IN STD_LOGIC;
		CLOCK_1Hz : OUT STD_LOGIC
	);

END ENTITY;

ARCHITECTURE rtl OF DivisorClock IS

BEGIN

	PROCESS (CLOCK_50MHz, reset)
		VARIABLE cnt : INTEGER RANGE 0 TO 25000000;
		VARIABLE clk : STD_LOGIC := '0';
	BEGIN
		IF (reset = '1') THEN
			cnt := 0;
		ELSIF (rising_edge(CLOCK_50MHz)) THEN
			IF (cnt = 25000000) THEN
				clk := NOT clk;
				cnt := 0;
			ELSE
				cnt := cnt + 1;
			END IF;
		END IF;
		CLOCK_1Hz <= clk;
	END PROCESS;

END rtl;