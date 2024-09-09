# Verifica se a biblioteca 'work' já existe e a deleta se necessário
if {[file isdirectory work]} { 
    vdel -all -lib work 
}

# Cria uma nova biblioteca 'work'
vlib work
vmap work work

# Compila os arquivos VHDL para a biblioteca 'work'
vcom -work work DiviserCounter.vhd
vcom -work work tb_DiviserCounter.vhd

# Realiza a simulação do testbench 'tb_DiviserCounter' com a opção de otimização e precisão de tempo em nanosegundos
vsim -voptargs=+acc=lprn -t ns work.tb_DiviserCounter

# Suprime os avisos padrão durante a simulação
set StdArithNoWarnings 1
set StdVitalGlitchNoWarnings 1

# Executa o script para configurar as ondas
do wave.do 

# Roda a simulação por 10000 microsegundos
run 10000 us
