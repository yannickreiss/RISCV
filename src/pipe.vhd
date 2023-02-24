-- pipe
-- 2023-02-14
-- Author: Yannick Reiß
-- E-Mail: yannick.reiss@protonmail.ch
-- Copyright: WTFPL
-- Content: Entity pipe - Pipeline prototype
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.riscv_types.all;

entity pipe is
    port (
        clk        : in std_logic;
        empty_pipe : in std_logic;

        pipe_empty : out std_logic;
        write_back : out std_logic;

     -- TODO: Add registers to load in each step
        );
end pipe;

architecture arch of pipe is

    signal semaphore : std_logic_vector(2 downto 0) := "000";
begin

    pcraise : process(clk)
    begin
        if rising_edge(clk) then

            -- fill and empty pipe
            if unsigned(semaphore) < 5 and empty_pipe = '0' then
                semaphore <= std_logic_vector(unsigned(semaphore) + 1);
            else
                if empty_pipe = '1' and unsigned(semaphore) > 0 then
                    semaphore <= std_logic_vector(unsigned(semaphore) - 1);
                end if;
            end if;

            -- signal that pipe is empty
            if semaphore = "000" then
                pipe_empty <= '0';
            else
                pipe_empty <= '1';
            end if;
        end if;
    end process;  -- pcraise  

    writeback : process(clk)
    begin
        if rising_edge(clk) then
            if semaphore = "100" then
                write_back <= '1';
            else
                write_back <= '0';
            end if;


        end if;
    end process;  -- writeback  
end architecture;  -- arch
