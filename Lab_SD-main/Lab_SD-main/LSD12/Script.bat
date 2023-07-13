cd C:\Users\luiz_\OneDrive\Área de Trabalho\LabSD\LSD11\
ghdl -a divisor_clock.vhd
ghdl -a semaforo.vhd
ghdl -a tb_semaforo.vhd
ghdl -e tb_semaforo
ghdl -r tb_semaforo --vcd=tb_semaforo.vcd
gtkwave -f tb_semaforo.vcd  --script=gtkwave_print.tcl
:Done