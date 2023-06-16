# Universidade Federal de Minas Gerais
# Laboratório de Sistemas Digitais
# Autor: Prof. Ricardo de Oliveira Duarte - DELT/EE/UFMG
# Compilation and Simulation with vlib, vcm and vsim Shell Script File - versão 1.0
# Referência: https://docs.fileformat.com/programming/sh/
# Objetivos:
# (1) Analisar arquivos .vhd usando vlib e vcom (Intel-Altera-QuartusII)
# (2) Simular arquivos .vhd usando vsim (Intel-Altera-ModelSim)
# (3) Gerar arquivos com os resultados da simulação demandados pelo tb_funcao.vhd
# Pré-requisitos:
# (1) QuartusII e ModelSim instalados
# (2) Variável de ambiente Path editada e ativada, com os caminhos dos executáveis QuartusII e ModelSim
# Para executar esse script:
# (1) Vá para a pasta do seu computador onde se encontra os seus arquivos fonte a serem compilados e simulados.
# (2) Da janela Terminal (do MS-Windows ou do Visual Studion Code) digite no diretório onde se encontra o arquivo com extensão .bat o comando ".\shell_script_vcom_vsim.sh"
vlib work
vcom -explicit  -93 "funcao.vhd"
vcom -explicit  -93 "tb_funcao.vhd"
vsim -t 1ns -lib work tb_funcao -do "add wave -radix unsigned sim:/tb_funcao/*" -do "view wave" -do "view structure" -do "view signals" -do "run 60ns" -do "wave zoom full"