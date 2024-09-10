library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_top_Stop_Watch is
-- Testbench não precisa de portas
end tb_top_Stop_Watch;

architecture Behavioral of tb_top_Stop_Watch is

    -- Sinais locais para o DUT (Design Under Test)
    signal clk_in       : STD_LOGIC := '0';
    signal rst_in       : STD_LOGIC := '0';
    signal start_btn    : STD_LOGIC := '0';
    signal stop_btn     : STD_LOGIC := '0';
    signal split_btn    : STD_LOGIC := '0';
    signal hour_count   : STD_LOGIC_VECTOR(7 downto 0);
    signal minute_count : STD_LOGIC_VECTOR(7 downto 0);
    signal second_count : STD_LOGIC_VECTOR(7 downto 0);
    signal hundredth_count : STD_LOGIC_VECTOR(7 downto 0);

    -- Período do clock
    constant clk_period : time := 10 ns;

    -- Instância da unidade a ser testada (DUT)
    component top_Stop_Watch
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
    end component;

begin

    -- Instância do DUT
    uut: top_Stop_Watch
        Port map (
            clk_in       => clk_in,
            rst_in       => rst_in,
            start_btn    => start_btn,
            stop_btn     => stop_btn,
            split_btn    => split_btn,
            hour_count   => hour_count,
            minute_count => minute_count,
            second_count => second_count,
            hundredth_count => hundredth_count
        );

    -- Geração do clock
    clk_process : process
    begin
        clk_in <= '0';
        wait for clk_period / 2;
        clk_in <= '1';
        wait for clk_period / 2;
    end process clk_process;

    -- Processo de simulação
    stim_proc: process
    begin
        -- Reset inicial
        rst_in <= '1';
        wait for 50 ns;
        rst_in <= '0';

        -- Simula pressionar o botão de iniciar (start_btn)
        start_btn <= '1';
        wait for 100 ns;
        start_btn <= '0';

        -- Aguarda 1 segundo (100 * 10 ms = 1 segundo simulado)
        wait for 1 ms;

        -- Simula pressionar o botão de parar (stop_btn)
        stop_btn <= '1';
        wait for 100 ns;
        stop_btn <= '0';

        -- Aguarda um momento e reseta novamente
        wait for 500 ns;
        rst_in <= '1';
        wait for 50 ns;
        rst_in <= '0';

        -- Testa o botão de dividir (split_btn)
        start_btn <= '1';
        wait for 100 ns;
        start_btn <= '0';
        
        wait for 500 ns;
        split_btn <= '1';
        wait for 100 ns;
        split_btn <= '0';

        -- Aguarda o final da simulação
        wait for 2 ms;

        -- Finaliza a simulação
        wait;
    end process;

end Behavioral;
