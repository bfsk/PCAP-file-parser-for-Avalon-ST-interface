library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;

LIBRARY std;
USE std.textio.all;

--! write data to PCAP File from the hardware - !ONLY! Simulation !!!
entity pcap_writer is
  port (
    clk                         : in  std_logic; --! system clock
    reset                       : in std_logic;
    avalon_st_rx_ready          : out  std_logic;
    avalon_st_rx_valid          : in std_logic;
    avalon_st_rx_startofpacket  : in std_logic;    
    avalon_st_rx_endofpacket    : in std_logic;
    avalon_st_rx_data           : in std_logic_vector(63 downto 0);
    avalon_st_rx_empty          : in std_logic_vector(2 downto 0);
    avalon_st_rx_error          : in std_logic
    );
end pcap_writer;

--! architecture of the pcap_writer

architecture arch of pcap_writer is

  constant  PCAP_FILE_NAME  : STRING  := "recorded_traffic.pcap";
  -- Global Header Signals
  --
  signal s_magic_number   : std_logic_vector(31 downto 0) := x"d4c3b2a1";-- x"a1b2c3d4"; --magic number
  signal s_version_major  : std_logic_vector(15 downto 0) := x"0002";--major version number
  signal s_version_minor  : std_logic_vector(15 downto 0) := x"0004";--minor version number
  signal s_thiszone       : std_logic_vector(31 downto 0) := x"00000000"; --GMT to local correction
  signal s_sigfigs        : std_logic_vector(31 downto 0) := x"00000000"; --accuracy of timestamps
  signal s_snaplen        : std_logic_vector(31 downto 0) := x"0000ffff"; --max length of captured packets, in octets
  signal s_network        : std_logic_vector(31 downto 0) := x"00000001"; --data link type

  --
  -- Packet Header Signals
  --
  signal s_ts_sec         : std_logic_vector(31 downto 0);    --timestamp seconds
  signal s_ts_usec        : std_logic_vector(31 downto 0);    --timestamp microseconds
  signal s_len            : std_logic_vector(31 downto 0);    --number of received octets of packet
  --
  -- all read signals converted to big endian if necessary
  --
  signal sd_version_major     :  std_logic_vector(15 downto 0);
  signal sd_version_minor     :  std_logic_vector(15 downto 0);
  signal sd_thiszone          :  std_logic_vector(31 downto 0);
  signal sd_sigfigs           :  std_logic_vector(31 downto 0);
  signal sd_snaplen           :  std_logic_vector(31 downto 0);
  signal sd_network           :  std_logic_vector(31 downto 0);
  signal sd_ts_sec            : std_logic_vector(31 downto 0);
  signal sd_ts_usec           : std_logic_vector(31 downto 0);
  signal sd_len               : std_logic_vector(31 downto 0);

  
  --
  -- variables
  --
  signal s_usec            : std_logic_vector(31 downto 0);
  signal s_sec             : std_logic_vector(31 downto 0);

  signal rx_ready         : std_logic :='0';
  signal byte_counter     : integer := 0;
  signal little_endian    : std_logic;
  signal data             : std_logic_vector(63 downto 0);
  signal empty            : std_logic_vector(2 downto 0);

  type states is (st_initialize_file, st_start, st_receive_packet, st_write_to_file);
  signal current_state : states;

  type ram_type is array (0 to 1500) of std_logic_vector(7 downto 0); 
  signal RAM : ram_type;


  COMPONENT timer is
    port (
      clk : in  std_logic;--! system clock
      reset : in std_logic;
      u_sec : out std_logic_vector (31 downto 0);
      second : out std_logic_vector (31 downto 0)
  );
  end COMPONENT;

begin
  tim:	timer port map(clk, reset, s_usec, s_sec);

  little_endian <= '1' when s_magic_number = x"d4c3b2a1" else '0';
  avalon_st_rx_ready <= rx_ready;
  s_ts_sec  <= s_sec;
  s_ts_usec <= s_usec;
  s_len     <= std_logic_vector(to_unsigned(byte_counter, 32));

  -- convert read values to BigEndian if required
  sd_version_major      <= s_version_major(7 downto 0) & s_version_major(15 downto 8) when little_endian='1' else s_version_major;
  sd_version_minor      <= s_version_minor(7 downto 0) & s_version_minor(15 downto 8) when little_endian='1' else s_version_minor;
  sd_thiszone           <= s_thiszone(7 downto 0) & s_thiszone(15 downto 8) & s_thiszone(23 downto 16) & s_thiszone(31 downto 24) when little_endian='1' else s_thiszone;
  sd_sigfigs            <= s_sigfigs(7 downto 0) & s_sigfigs(15 downto 8) & s_sigfigs(23 downto 16) & s_sigfigs(23 downto 16) when little_endian='1' else s_sigfigs;
  sd_snaplen            <= s_snaplen(7 downto 0) & s_snaplen(15 downto 8) & s_snaplen(23 downto 16) & s_snaplen(31 downto 24) when little_endian='1' else s_snaplen;
  sd_network            <= s_network(7 downto 0) & s_network(15 downto 8) & s_network(23 downto 16) & s_network(31 downto 24) when little_endian='1' else s_network;
  sd_ts_sec             <= s_ts_sec(7 downto 0) & s_ts_sec(15 downto 8) & s_ts_sec(23 downto 16) & s_ts_sec(31 downto 24) when little_endian='1' else s_ts_sec;
  sd_ts_usec            <= s_ts_usec(7 downto 0) & s_ts_usec(15 downto 8) & s_ts_usec(23 downto 16) & s_ts_usec(31 downto 24) when little_endian='1' else s_ts_usec;
  sd_len                <= s_len(7 downto 0) & s_len(15 downto 8) & s_len(23 downto 16) & s_len(31 downto 24) when little_endian='1' else s_len;
 

  --! FSM to write data
  process(clk)
    type t_char_file is FILE of character;
    FILE PCAP: t_char_file OPEN write_mode IS PCAP_FILE_NAME;
  begin
    empty <= avalon_st_rx_empty;
    data  <= avalon_st_rx_data;
    if (rising_edge(clk)) then
      if (reset = '1') then
        rx_ready        <= '0';
        byte_counter    <=  0;
      else
        case current_state is
          when st_initialize_file =>
            for i in 3 downto 0 loop --write magic number
              write(PCAP, character'val(to_integer(unsigned(s_magic_number((i*8) + 7 downto i*8)))));
            end loop;
            for i in 1 downto 0 loop --write major version number
              write(PCAP, character'val(to_integer(unsigned(sd_version_major((i*8) + 7 downto i*8)))));
            end loop;
            for i in 1 downto 0 loop --write minor version number
              write(PCAP, character'val(to_integer(unsigned(sd_version_minor((i*8) + 7 downto i*8)))));
            end loop;
            for i in 3 downto 0 loop --write timezone
              write(PCAP, character'val(to_integer(unsigned(sd_thiszone((i*8) + 7 downto i*8)))));
            end loop;
            for i in 3 downto 0 loop --write sigfigs
              write(PCAP, character'val(to_integer(unsigned(sd_sigfigs((i*8) + 7 downto i*8)))));
            end loop;
            for i in 3 downto 0 loop --write snaplen
              write(PCAP, character'val(to_integer(unsigned(sd_snaplen((i*8) + 7 downto i*8)))));
            end loop;
            for i in 3 downto 0 loop --write network
              write(PCAP, character'val(to_integer(unsigned(sd_network((i*8) + 7 downto i*8)))));
            end loop;
            current_state <= st_start;
            rx_ready <= '1';
          when st_start =>
            rx_ready <= '1';
            if(avalon_st_rx_startofpacket = '1') then
              current_state <= st_receive_packet;	
              for i in 0 to 7 - conv_integer(empty) loop 
                RAM(byte_counter + i) <= data( (7-i)*8+ 7 downto (7-i)*8); 
              end loop;
              byte_counter <= byte_counter + 8 - conv_integer(empty); 
            end if;

          when st_receive_packet =>
            if(avalon_st_rx_valid = '1') then
              for i in 0 to 7 - conv_integer(empty) loop 
                RAM(byte_counter + i) <= data( (7-i)*8+ 7 downto (7-i)*8); 
              end loop;
              byte_counter <= byte_counter + 8 - conv_integer(empty); 
            end if;
            if(avalon_st_rx_endofpacket = '1') then
              rx_ready <= '0'; 
              current_state <= st_write_to_file;
            end if;
          when st_write_to_file =>
            --write packet header
            for i in 3 downto 0  loop --write sec time
              write(PCAP, character'val(to_integer(unsigned(sd_ts_sec((i*8) + 7 downto i*8)))));
            end loop;
            for i in 3 downto 0  loop --write microsec time
              write(PCAP, character'val(to_integer(unsigned(sd_ts_usec((i*8) + 7 downto i*8)))));
            end loop;
            for i in 3 downto 0  loop --write saved length
              write(PCAP, character'val(to_integer(unsigned(sd_len((i*8) + 7 downto i*8)))));
            end loop;
            for i in 3 downto 0  loop --write original length
              write(PCAP, character'val(to_integer(unsigned(sd_len((i*8) + 7 downto i*8)))));
            end loop;
            
            for i in 0 to byte_counter - 1 loop --write packet data
              write(PCAP, character'val(to_integer(unsigned(RAM(i)))));
            end loop;
            current_state <= st_start;
            byte_counter <= 0; 
        end case;
      end if;
    end if;
  end process;


end arch;


