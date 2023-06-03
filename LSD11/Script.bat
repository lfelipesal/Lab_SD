cd C:\Users\luiz_\OneDrive\Área de Trabalho\LabSD\LSD11\
ghdl -a Circuito_Convert.vhd
ghdl -a tb_Circuito_Convert.vhd
ghdl -e tb_Circuito_Convert
ghdl -r tb_Circuito_Convert --vcd=tb_Circuito_Convert.vcd
gtkwave -f tb_Circuito_Convert.vcd  --script=gtkwave_print.tcl
:Done