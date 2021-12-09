use std.textio.all;

entity aoc_03_1 is
end aoc_03_1;

architecture behaviour of aoc_03_1 is
begin
  process
    variable l : line;
  begin
    write (l, String'("Hello world!"));
    writeline (output, l);
    wait;
  end process;
end behaviour;
