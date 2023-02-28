-- io_ram
-- 2023-02-28
-- Author: Yannick Reiß
-- E-Mail: yannick.reiss@protonmail.ch
-- Copyright: 
-- Content: Entity io_ram - input and output into ram
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.riscv_types.all;

entity io_ram is

    generic (initMem : ram_t := (others => (others => '0')));

    port (clk : in std_logic;

          addr_a      : in  std_logic_vector(ram_addr_size - 3 downto 0);
          data_read_a : out std_logic_vector(wordWidth - 1 downto 0);

          write_b      : in  one_bit;
          addr_b       : in  std_logic_vector(ram_addr_size - 3 downto 0);
          data_read_b  : out std_logic_vector(wordWidth - 1 downto 0);
          data_write_b : in  std_logic_vector(wordWidth - 1 downto 0);

          -- peripheral input
          switch : in std_logic_vector(15 downto 0);
          button : in std_logic_vector(4 downto 0);

          -- graphic outputs
          led     : out std_logic_vector(15 downto 0);
          segment : out std_logic_vector(31 downto 0);
          rgb     : out std_logic_vector(7 downto 0)
          );

end io_ram;

--
architecture behavioral of io_ram is

    signal store : ram_t := initMem;

begin

    process(clk)
    begin
        if rising_edge(clk) then

            -- One synchron write port
            if write_b = "1" then
                store(to_integer(unsigned(addr_b(9 downto 2)))) <= data_write_b;
            end if;

        end if;
    end process;

    -- Two synchron read ports 
    data_read_a <= store(to_integer(unsigned(addr_a(9 downto 2))));
    data_read_b <= store(to_integer(unsigned(addr_b(9 downto 2))));

    store(128) <= switch(15 downto 0) & button(4 downto 0) & "00000000000";  -- TODO: Check constraints

    led     <= store(0)(31 downto 16);
    segment <= store(1);
    RGB     <= store(2)(31 downto 24);

end behavioral;


