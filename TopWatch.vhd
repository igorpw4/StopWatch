library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_Stop_Watch is
    Port (
        clk_in       : in  STD_LOGIC;
        rst_in       : in  STD_LOGIC;
        start_btn    : in  STD_LOGIC;
        stop_btn     : in  STD_LOGIC;
        split_btn    : in  STD_LOGIC;
        hour_count   : out STD_LOGIC_VECTOR(7 downto 0);
        minute_count : out STD_LOGIC_VECTOR(7 downto 0);
        second_count : out STD_LOGIC_VECTOR(7 downto 0);
        hundredth_count : out STD_LOGIC_VECTOR(7 downto 0)
    );
end top_Stop_Watch;

architecture Behavioral of top_Stop_Watch is

    -- Sinais internos
    signal reset_out, start_out, stop_out, split_out : STD_LOGIC;
    signal pulse_in : STD_LOGIC;

    -- Instâncias dos componentes
    component StateMachine
        Port (
            clk       : in  STD_LOGIC;
            reset     : in  STD_LOGIC;
            start_btn : in  STD_LOGIC;
            stop_btn  : in  STD_LOGIC;
            split_btn : in  STD_LOGIC;
            reset_out : out STD_LOGIC;
            start_out : out STD_LOGIC;
            stop_out  : out STD_LOGIC;
            split_out : out STD_LOGIC
        );
    end component;

    component CentisecondCounter
        Port (
            clk       : in  STD_LOGIC;
            reset     : in  STD_LOGIC;
            pulse_out : out STD_LOGIC
        );
    end component;

    component DiviserCounter
        Port (
            clk             : in  STD_LOGIC;
            reset           : in  STD_LOGIC;
            pulse_in        : in  STD_LOGIC;
            start           : in  STD_LOGIC;
            stopp           : in  STD_LOGIC;
            return_count    : in  STD_LOGIC;
            hour_count      : out STD_LOGIC_VECTOR(7 downto 0);
            minute_count    : out STD_LOGIC_VECTOR(7 downto 0);
            second_count    : out STD_LOGIC_VECTOR(7 downto 0);
            hundredth_count : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

begin

    -- Instância do StateMachine
    state_machine_inst : StateMachine
        Port map (
            clk       => clk_in,
            reset     => rst_in,
            start_btn => start_btn,
            stop_btn  => stop_btn,
            split_btn => split_btn,
            reset_out => reset_out,
            start_out => start_out,
            stop_out  => stop_out,
            split_out => split_out
        );

    -- Instância do CentisecondCounter
    centisecond_counter_inst : CentisecondCounter
        Port map (
            clk       => clk_in,
            reset     => rst_in,
            pulse_out => pulse_in
        );

    -- Instância do DiviserCounter
    diviser_counter_inst : DiviserCounter
        Port map (
            clk             => clk_in,
            reset           => reset_out,
            pulse_in        => pulse_in,
            start           => start_out,
            stopp            => stop_out,
            return_count    => split_out,
            hour_count      => hour_count,
            minute_count    => minute_count,
            second_count    => second_count,
            hundredth_count => hundredth_count
        );

end Behavioral;
