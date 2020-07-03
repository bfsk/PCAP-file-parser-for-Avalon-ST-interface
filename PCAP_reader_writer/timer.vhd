library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity timer is
  
  port (
    clk : in  std_logic;--! system clock
    reset : in std_logic;
    u_sec : out std_logic_vector (31 downto 0);
    second : out std_logic_vector (31 downto 0)	 
);
end timer;

architecture arch of timer is
  signal a                : integer := 0;
  signal s_micro_counter  : integer := 0;
  signal s_sec_counter    : integer := 0;
  signal s_usec           : integer := 0;
  signal s_sec            : integer := 0;

begin
  u_sec  <= std_logic_vector(to_unsigned(s_usec,32));
  second <= std_logic_vector(to_unsigned(s_sec,32));
process(clk)
  begin
    if (rising_edge(clk)) then
      if (reset = '1') then
        a                   <= 0;
        s_micro_counter     <= 0;
        s_sec_counter       <= 0; 
        s_usec              <= 0;
        s_sec               <= 0;
      else
        if(a < 3) then
          s_micro_counter <= s_micro_counter + 1;
        else 
          a <=0;
        end if;
        if(s_micro_counter = 155) then 
          s_micro_counter <= 0;
          a <= a + 1;
          if(s_usec < 1000000) then 
            s_usec <= s_usec + 1;
          else
            s_usec <= 0;
          end if;
        end if;
        s_sec_counter <= s_sec_counter + 1;
        if(s_sec_counter = 156249999) then
            s_sec <= s_sec + 1;
            s_sec_counter <= 0;
        end if;
      end if;
    end if;
 end process;
end arch;