library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use ieee.std_logic_textio.all;
use std.textio.all;
use ieee.numeric_std.all;

entity tb_funcao is
end tb_funcao;

architecture tb of tb_funcao is
component funcao is
port (
	x	:	in	std_logic_vector(3 downto 0);
	f	:	out	std_logic_vector(7 downto 0)
	);
end component;

signal xin				:	std_logic_vector(3 downto 0);
signal fout				: 	std_logic_vector(7 downto 0);

signal flag_read_data  	: std_logic:='0';
signal flag_write      	: std_logic:='0';   
   
file   arquivo_entrada 	: text open read_mode  is "data_in.txt";
file   arquivo_saida1  	: text open write_mode is "saida1.txt";
file   arquivo_saida2  	: text open write_mode is "saida2.txt";

constant OFFSET     		: time := 10 ns;
constant OFFSET_WRITE   : time := 12 ns;
constant MEIO_OFFSET    : time := 5 ns;

type vetor_int is array (integer range <>) of integer;
signal vetor			: vetor_int (0 to 8) := (88, 10, 108, 100, 88, 72, 52, 28, 0);
constant aux_string1	: string := "discordancia";
constant aux_string2	: string := "concordancia";

begin
instancia	: funcao port map (x=>xin, f=>fout);

-- processo para ler os dados do arquivo data_in.txt
	read_inputs_from_file:
	process
	variable linha 		: line;
	variable entrada 		: integer;
	begin
	   wait for OFFSET;
		while not endfile(arquivo_entrada) loop
		      if flag_read_data = '1' then
					readline(arquivo_entrada,linha);
					read(linha,entrada);
					xin <= std_logic_vector(to_unsigned(entrada,4));
			  end if;
			  wait for (MEIO_OFFSET);
		end loop;
		wait;
	end process read_inputs_from_file;
	
-- processo para gerar os estimulos da entrada xin 
	processo_entrada:
	process
	begin
		wait for OFFSET;
		flag_read_data <= '1';		
		for i in 0 to 8 loop
		    wait for MEIO_OFFSET;
		end loop;
        flag_read_data <= '0';
		wait;
	end process;

-- processo para gerar os sinais simulados para escrita no arquivo_saida1   
	escreve_outputs1:
	process
	begin
		wait for OFFSET_WRITE;
		flag_write <= '1';
		for i in 0 to 8 loop
			wait for MEIO_OFFSET;
		end loop;
		flag_write <= '0';			
		wait;
	end process escreve_outputs1;   

-- processo para testar os sinais simulados e gerar as saidas do arquivo_saida2   
	escreve_outputs2:
	process
	variable aux 		: std_logic_vector (7 downto 0);
	variable aux_int	: integer;
	variable linha2  		: line;
	begin
		wait for OFFSET_WRITE;
		flag_write <= '1';
		for i in 0 to 8 loop
			wait for MEIO_OFFSET;
			aux := fout;
			aux_int := to_integer(unsigned(aux));
			if(vetor(i)/=aux_int) then
				assert false report aux_string1 severity note;
				write(linha2,aux_string1);
				writeline(arquivo_saida2,linha2);
			else
				assert false report aux_string2 severity note;
				write(linha2,aux_string2);
				writeline(arquivo_saida2,linha2);
			end if;
		end loop;
		flag_write <= '0';
		wait;
	end process escreve_outputs2;   
   
-- processo para escrever os dados de saida no arquivo .txt   
	write_outputs_to_files:
	process
	variable linha1  		: line;
	variable saida_aux 	: std_logic_vector (7 downto 0);
	begin
		wait for OFFSET_WRITE;
		while true loop
			if (flag_write ='1')then
				saida_aux := fout;
				write(linha1,to_integer(unsigned(saida_aux)));
--				write(linha2,aux_string2);
				writeline(arquivo_saida1,linha1);
			end if;
			wait for MEIO_OFFSET;
		end loop;
	end process write_outputs_to_files;
end tb;
