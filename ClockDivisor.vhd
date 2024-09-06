library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CentisecondCounter is
    Port ( clk       : in  STD_LOGIC;
           reset     : in  STD_LOGIC;
           pulse_out : out STD_LOGIC);
end CentisecondCounter;

architecture Behavioral of CentisecondCounter is
    signal counter : INTEGER := 0;
begin

    process(clk, reset)
    begin
        if reset = '1' then
            counter <= 0;
            pulse_out <= '0';
        elsif rising_edge(clk) then
            if counter = 1000000 - 1 then
                counter <= 0;
                pulse_out <= '1';
            else
                counter <= counter + 1;
                pulse_out <= '0';
            end if;
        end if;
    end process;

end Behavioral;
 