# Suprime os erros e mensagens
onerror {resume}
quietly WaveActivateNextPane {} 0

# Adiciona sinais do testbench
add wave -noupdate /tb_DiviserCounter/clk
add wave -noupdate /tb_DiviserCounter/reset
add wave -noupdate /tb_DiviserCounter/start
add wave -noupdate /tb_DiviserCounter/stopp
add wave -noupdate /tb_DiviserCounter/return_count

# Adiciona sinais do módulo DiviserCounter
add wave -noupdate -radix decimal /tb_DiviserCounter/uut/hundredth_count
add wave -noupdate -radix decimal /tb_DiviserCounter/uut/segund_count
add wave -noupdate -radix decimal /tb_DiviserCounter/uut/minute_count
add wave -noupdate -radix decimal /tb_DiviserCounter/uut/hour_count

# Configurações adicionais de exibição
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {100000 us}
