library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.riscv_types.all;

library std;
use std.textio.all;

entity cpu_tb is
end cpu_tb;

architecture Behavioral of cpu_tb is

  -- Clock
  signal clk : std_logic;

  -- Inputs
  signal reset : std_logic := '0';

  -- Outputs
  -- Clock period definitions
  constant clk_period : time := 10 ns;

  -- peripherie
  signal s_switch  : std_logic_vector(15 downto 0) := (others => '0');
  signal s_button  : std_logic_vector(4 downto 0)  := (others => '0');
  signal s_led     : std_logic_vector(15 downto 0) := (others => '0');
  signal s_segment : std_logic_vector(31 downto 0) := (others => '0');
  signal s_rgb     : std_logic_vector(7 downto 0)  := (others => '0');

begin

  -- Instantiate the Unit Under Test (UUT)
  uut : entity work.cpu(implementation)
    port map (clk   => clk,
              reset => reset,

              switch  => s_switch,
              button  => s_button,
              led     => s_led,
              segment => s_segment,
              rgb     => s_rgb
              );

  -- Clock process definitions
  clk_process : process
  begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
  end process;

  -- Process stim_proc  stimulate uut
  stim_proc : process                   -- runs only, when  changed
    variable lineBuffer : line;
  begin
    write(lineBuffer, string'("Start the simulator"));
    writeline(output, lineBuffer);

    wait for 470 ns;

    write(lineBuffer, string'("RESET: Values should be set to zero"));
    writeline(output, lineBuffer);

    reset <= '1';
    wait for 10 ns;
    reset <= '0';

    wait;
  end process;
end architecture;
