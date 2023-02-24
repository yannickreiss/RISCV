-- tb_branch.vhd
-- Created on: Fr 24. Feb 15:44:16 CET 2023
-- Author(s): Yannick Reiß
-- Content:  Entity tb_branchanch
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

library work;
use work.riscv_types.all;

library std;
use std.textio.all;

-- Entity branch_tb: testbench for branch
entity branch_tb is
end branch_tb;

architecture arch of branch_tb is
  -- clk
  signal clk          : std_logic;
  constant clk_period : time := 10 ns;

  -- inputs
  signal op_code : uOP;
  signal reg1    : word;
  signal reg2    : word;

  -- outputs
  signal jmp_enable : one_bit;

  begin
    uut : entity work.Branch(arch)
      port map (
        op_code    => op_code,
        reg1       => reg1,
        reg2       => reg2,
        jmp_enable => jmp_enable
        );

    -- clk-prog
    clk_process : process               -- runs only, if changed
    begin
      clk <= '0';
      wait for clk_period/2;
      clk <= '1';
      wait for clk_period/2;
    end process;

    -- Process stim_proc  stimulate uut
    stim_proc : process                 -- runs only, if changed
      variable lineBuffer : line;
    begin
      write(lineBuffer, string'("Start the simulator"));
      writeline(output, lineBuffer);

      wait for 5 ns;

      -- describe case
      -- load opcode
      -- load reg1
      -- load reg2
      -- compare jmp_enable
      -- wait for 10ns

      -- BEQ true
      op_code <= uBEQ;
      reg1    <= std_logic_vector(to_unsigned(36, wordWidth));
      reg2    <= std_logic_vector(to_unsigned(36, wordWidth));
      wait for 5 ns;
      if (unsigned(jmp_enable) = 1) then
        write(lineBuffer, string'("Result BEQ True: +"));
        writeline(output, lineBuffer);
      else
        write(lineBuffer, string'("Result BEQ True: -"));
        writeline(output, lineBuffer);
      end if;
      wait for 10 ns;

      -- BEQ false
      op_code <= uBEQ;
      reg1    <= std_logic_vector(to_unsigned(53, wordWidth));
      reg2    <= std_logic_vector(to_unsigned(36, wordWidth));
    
      wait for 5 ns;
      if (unsigned(jmp_enable) = 0) then
        write(lineBuffer, string'("Result BEQ Fals: +"));
        writeline(output, lineBuffer);
      else
        write(lineBuffer, string'("Result BEQ Fals: -"));
        writeline(output, lineBuffer);
      end if;
      wait for 10 ns;

      -- BNE true
      op_code <= uBNE;
      reg1    <= std_logic_vector(to_unsigned(22, wordWidth));
      reg2    <= std_logic_vector(to_unsigned(36, wordWidth));
      wait for 5 ns;
      if (unsigned(jmp_enable) = 1) then
        write(lineBuffer, string'("Result BNE True: +"));
        writeline(output, lineBuffer);
      else
        write(lineBuffer, string'("Result BNE True: -"));
        writeline(output, lineBuffer);
      end if;
      wait for 10 ns;

      -- BNE false
      op_code <= uBNE;
      reg1    <= std_logic_vector(to_unsigned(53, wordWidth));
      reg2    <= std_logic_vector(to_unsigned(53, wordWidth));
      wait for 5 ns;
      if (unsigned(jmp_enable) = 0) then
        write(lineBuffer, string'("Result BNE Fals: +"));
        writeline(output, lineBuffer);
      else
        write(lineBuffer, string'("Result BNE Fals: -"));
        writeline(output, lineBuffer);
      end if;
      wait for 10 ns;

      -- BLT true
      op_code <= uBLT;
      reg1    <= std_logic_vector(to_unsigned(11, wordWidth));
      reg2    <= std_logic_vector(to_unsigned(36, wordWidth));
      wait for 5 ns;
      if (unsigned(jmp_enable) = 1) then
        write(lineBuffer, string'("Result BLT True: +"));
        writeline(output, lineBuffer);
      else
        write(lineBuffer, string'("Result BLT True: -"));
        writeline(output, lineBuffer);
      end if;
      wait for 10 ns;

      -- BLT false
      op_code <= uBLT;
      reg1    <= std_logic_vector(to_unsigned(53, wordWidth));
      reg2    <= std_logic_vector(to_unsigned(36, wordWidth));
      wait for 5 ns;
      if (unsigned(jmp_enable) = 0) then
        write(lineBuffer, string'("Result BLT Fals: +"));
        writeline(output, lineBuffer);
      else
        write(lineBuffer, string'("Result BLT Fals: -"));
        writeline(output, lineBuffer);
      end if;
      wait for 10 ns;

      -- BGE true
      op_code <= uBGE;
      reg1    <= std_logic_vector(to_unsigned(46, wordWidth));
      reg2    <= std_logic_vector(to_unsigned(36, wordWidth));
      wait for 5 ns;
      if (unsigned(jmp_enable) = 1) then
        write(lineBuffer, string'("Result BGE True: +"));
        writeline(output, lineBuffer);
      else
        write(lineBuffer, string'("Result BGE True: -"));
        writeline(output, lineBuffer);
      end if;
      wait for 10 ns;

      -- BGE false
      op_code <= uBGE;
      reg1    <= std_logic_vector(to_unsigned(23, wordWidth));
      reg2    <= std_logic_vector(to_unsigned(36, wordWidth));
      wait for 5 ns;
      if (unsigned(jmp_enable) = 0) then
        write(lineBuffer, string'("Result BGE Fals: +"));
        writeline(output, lineBuffer);
      else
        write(lineBuffer, string'("Result BGE Fals: -"));
        writeline(output, lineBuffer);
      end if;
      wait for 10 ns;

      -- BLTU true
      op_code <= uBLTU;
      reg1    <= std_logic_vector(to_unsigned(22, wordWidth));
      reg2    <= std_logic_vector(to_unsigned(36, wordWidth));
      wait for 5 ns;
      if (unsigned(jmp_enable) = 1) then
        write(lineBuffer, string'("Result BLTU True: +"));
        writeline(output, lineBuffer);
      else
        write(lineBuffer, string'("Result BLTU True: -"));
        writeline(output, lineBuffer);
      end if;
      wait for 10 ns;

      -- BLTU false
      op_code <= uBLTU;
      reg1    <= std_logic_vector(to_unsigned(53, wordWidth));
      reg2    <= std_logic_vector(to_unsigned(36, wordWidth));
      wait for 5 ns;
      if (unsigned(jmp_enable) = 0) then
        write(lineBuffer, string'("Result BLTU Fals: +"));
        writeline(output, lineBuffer);
      else
        write(lineBuffer, string'("Result BLTU Fals: -"));
        writeline(output, lineBuffer);
      end if;
      wait for 10 ns;

      -- BGEU true
      op_code <= uBGEU;
      reg1    <= std_logic_vector(to_unsigned(55, wordWidth));
      reg2    <= std_logic_vector(to_unsigned(36, wordWidth));
      wait for 5 ns;
      if (unsigned(jmp_enable) = 1) then
        write(lineBuffer, string'("Result BGEU True: +"));
        writeline(output, lineBuffer);
      else
        write(lineBuffer, string'("Result BGEU True: -"));
        writeline(output, lineBuffer);
      end if;
      wait for 10 ns;

      -- BGEU false
      op_code <= uBGEU;
      reg1    <= std_logic_vector(to_unsigned(36, wordWidth));
      reg2    <= std_logic_vector(to_unsigned(38, wordWidth));
      wait for 5 ns;
      if (unsigned(jmp_enable) = 0) then
        write(lineBuffer, string'("Result BLT Fals: +"));
        writeline(output, lineBuffer);
      else
        write(lineBuffer, string'("Result BLT Fals: -"));
        writeline(output, lineBuffer);
      end if;
      wait for 10 ns;

      wait;
    end process;
  end arch;
