:: Universidade Federal de Minas Gerais
:: Laboratório de Sistemas Digitais
:: Autor: Prof. Ricardo de Oliveira Duarte - DELT/EE/UFMG
:: Compilation and Simulation with GHDL Batch File - versão 1.0
:: Referência: https://www.windowscentral.com/how-create-and-run-batch-file-windows-10
:: Objetivos:
:: (1) Analisar arquivos .vhd usando GHDL
:: (2) Simular arquivos .vhd usando GHDL
:: (3) Gerar arquivos com os resultados da simulação demandados pelo tb_funcao.vhd
:: Pré-requisitos:
:: (1) GHDL e GTKWAVE instalados
:: (2) Variável de ambiente Path editada e ativada, com os caminhos dos executáveis GHDL e GTKWAVE
:: Para executar esse script:
:: (1) Da janela Terminal (do MS-Windows ou do Visual Studion Code) digite no diretório onde se encontra o arquivo com extensão .bat o comando ".\batch_file_ghdl.bat"
::
:: Modifique a linha abaixo para o caminho do seu computador onde se encontra os seus arquivos fonte a serem compilados e simulados.
cd C:\Users\UFMG\Documents\UFMG\LSD\ERE\LSD10\LSD_guia_10_ERE_codigos
ghdl -a funcao.vhd
ghdl -a tb_funcao.vhd
ghdl -e tb_funcao
ghdl -r tb_funcao
:Done
