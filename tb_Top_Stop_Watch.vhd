library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_top_Stop_Watch is
end tb_top_Stop_Watch;

architecture behavior of tb_top_Stop_Watch is
    -- Component declaration for the Unit Under Test (UUT)
    component top_Stop_Watch
        Port (
            clk_in       : in  STD_LOGIC;
            rst_in       : in  STD_LOGIC;
            hour_count   : out STD_LOGIC_VECTOR(7 downto 0);
            minute_count : out STD_LOGIC_VECTOR(7 downto 0);
            segund_count : out STD_LOGIC_VECTOR(7 downto 0);
            hundredth_count : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    -- Signals for connecting to the UUT
    signal clk_in       : STD_LOGIC := '0';
    signal rst_in       : STD_LOGIC := '0';
    signal hour_count   : STD_LOGIC_VECTOR(7 downto 0);
    signal minute_count : STD_LOGIC_VECTOR(7 downto 0);
    signal segund_count : STD_LOGIC_VECTOR(7 downto 0);
    signal hundredth_count : STD_LOGIC_VECTOR(7 downto 0);

    -- Clock period definition
    constant clk_period : time := 10 ns;  -- 100 MHz clock

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: top_Stop_Watch
        Port map (
            clk_in       => clk_in,
            rst_in       => rst_in,
            hour_count   => hour_count,
            minute_count => minute_count,
            segund_count => segund_count,
            hundredth_count => hundredth_count
        );

    -- Clock generation process
    clk_process : process
    begin
        while true loop
            clk_in <= '0';
            wait for clk_period / 2;
            clk_in <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Initialize inputs
        rst_in <= '1';
        wait for 20 ns;
        rst_in <= '0';
        wait for 20 ns;

        -- Apply test vectors
        -- Test: Start counting
        -- To be modified based on specific test scenarios and expected results
        -- Example: Assert that after a certain amount of time, the count values change

        -- Wait some time to observe the counter behavior
        wait for 1 ms;

        -- Apply a reset again to see if it works correctly
        rst_in <= '1';
        wait for 20 ns;
        rst_in <= '0';
        wait for 1 ms;

        -- End of simulation
        wait;
    end process;

end behavior;
