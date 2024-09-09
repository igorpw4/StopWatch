library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity StateMachine is
    Port (  
        clk        : in  STD_LOGIC;
        reset      : in  STD_LOGIC;
        start_btn  : in  STD_LOGIC;
        stop_btn   : in  STD_LOGIC;
        split_btn  : in  STD_LOGIC;
        reset_out  : out STD_LOGIC;
        start_out  : out STD_LOGIC;
        stop_out   : out STD_LOGIC;
        split_out  : out STD_LOGIC
    );
end StateMachine;

architecture Behavioral of StateMachine is

    type state_type is ( START, STOP_S, SPLIT, RESET);
    signal current_state, next_state : state_type;

begin

    process(clk, reset)
    begin
        if reset = '1' then
            current_state <= RESET;  
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;

    process(current_state, start_btn, stop_btn, split_btn)
    begin
        -- Default: zera todas as saídas para evitar "latch"
        reset_out <= '0';
        start_out <= '0';
        stop_out <= '0';
        split_out <= '0';

        case current_state is
            -- Estado RESET
            when RESET =>
                reset_out <= '1'; -- Sinaliza o reset
                if start_btn = '1' then
                    next_state <= START;
                else
                    next_state <= RESET;
                end if;

            -- Estado START (cronômetro rodando)
            when START =>
                start_out <= '1'; -- Sinaliza que o cronômetro está rodando
                if stop_btn = '1' then
                    next_state <= STOP_S;
                elsif split_btn = '1' then
                    next_state <= SPLIT;
                else
                    next_state <= START;
                end if;

            -- Estado STOP (cronômetro parado)
            when STOP_S =>
                stop_out <= '1'; -- Sinaliza que o cronômetro está parado
                if start_btn = '1' then
                    next_state <= START;
                elsif split_btn = '1' then
                    next_state <= SPLIT;
                else
                    next_state <= STOP_S;
                end if;
          
            -- Estado SPLIT (dividindo tempos intermediários)
            when SPLIT =>
                split_out <= '1'; -- Sinaliza que está no estado SPLIT
                if stop_btn = '1' then
                    next_state <= STOP_S;
                else
                    next_state <= START;
                end if;

            -- Estado padrão caso ocorra algo inesperado
            when others =>
                next_state <= RESET;
        end case;
    end process;

end Behavioral;
