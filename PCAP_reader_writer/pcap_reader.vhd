library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


LIBRARY std;
USE std.textio.all;

entity pcap_reader is
  port (
    clk                         : in  std_logic;--! system clock
    reset                       : in std_logic;
    avalon_st_tx_ready          : in  std_logic;
    avalon_st_tx_valid          : out std_logic;
    avalon_st_tx_startofpacket  : out std_logic;    
    avalon_st_tx_endofpacket    : out std_logic;
    avalon_st_tx_data           : out std_logic_vector(63 downto 0);
    avalon_st_tx_s_empty          : out std_logic_vector(2 downto 0);
    avalon_st_tx_error          : out std_logic
    );
end pcap_reader;
--! architecture of the pcap_reader

architecture arch of pcap_reader is
  constant PCAP_FILE_NAME  : STRING  := "traffic_3.pcap";
  type t_char_file is FILE of character;
  FILE PCAP: t_char_file OPEN read_mode IS PCAP_FILE_NAME;

  --
  -- Global Header Signals
  --
  signal s_magic_number   : std_logic_vector(31 downto 0);    --magic number
  signal s_version_major  : std_logic_vector(15 downto 0);    --major version number
  signal s_version_minor  : std_logic_vector(15 downto 0);    --minor version number
  signal s_thiszone       : std_logic_vector(31 downto 0);    --GMT to local correction
  signal s_sigfigs        : std_logic_vector(31 downto 0);    --accuracy of timestamps
  signal s_snaplen        : std_logic_vector(31 downto 0);    --max length of captured packets, in octets
  signal s_network        : std_logic_vector(31 downto 0);    --data link type

  --
  -- Packet Header Signals
  --
  signal s_ts_sec         : std_logic_vector(31 downto 0);    --timestamp seconds
  signal s_ts_usec        : std_logic_vector(31 downto 0);    --timestamp microseconds
  signal s_incl_len       : std_logic_vector(31 downto 0);    --number of octets of packet saved in file
  signal s_orig_len       : std_logic_vector(31 downto 0);    --actual length of packet

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
  signal sd_incl_len          : std_logic_vector(31 downto 0);
  signal sd_orig_len          : std_logic_vector(31 downto 0);
  --
  -- variables
  --
  signal little_endian     : std_logic;
  signal s_start_of_packet : std_logic := '0';
  signal s_end_of_packet   : std_logic := '0';
  signal s_empty           : std_logic_vector(2 downto 0);

  signal s_usec            : std_logic_vector(31 downto 0);
  signal s_sec             : std_logic_vector(31 downto 0);

  signal byte_counter     : integer := 0;
  signal byte_index       : integer := 0;
  signal first_packet     : integer := 1;
  signal sec_offset       : integer := 0; 
  signal usec_offset      : integer := 0;

  signal output_data      : std_logic_vector(63 downto 0):= (others => '0');
  signal first_bytes      : std_logic := '1';
    
  type states is (st_start, st_check_file, st_read_global_header, st_read_packet_header, st_packet_available, st_pause, st_read_packet, st_eof);
  signal current_state : states;


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
	
  --
  -- Output signals
  --

  avalon_st_tx_error          <= '0';
  avalon_st_tx_s_empty        <= s_empty;
  avalon_st_tx_startofpacket  <= s_start_of_packet;
  avalon_st_tx_data           <= output_data;
  avalon_st_tx_endofpacket    <= s_end_of_packet;
  little_endian               <= '1' when s_magic_number = x"d4c3b2a1" else '0';

  -- convert read values to BigEndian if required
  sd_version_major      <= s_version_major(7 downto 0) & s_version_major(15 downto 8) when little_endian='1' else s_version_major;
  sd_version_minor      <= s_version_minor(7 downto 0) & s_version_minor(15 downto 8) when little_endian='1' else s_version_minor;
  sd_thiszone           <= s_thiszone(7 downto 0) & s_thiszone(15 downto 8) & s_thiszone(23 downto 16) & s_thiszone(31 downto 24) when little_endian='1' else s_thiszone;
  sd_sigfigs            <= s_sigfigs(7 downto 0) & s_sigfigs(15 downto 8) & s_sigfigs(23 downto 16) & s_sigfigs(23 downto 16) when little_endian='1' else s_sigfigs;
  sd_snaplen            <= s_snaplen(7 downto 0) & s_snaplen(15 downto 8) & s_snaplen(23 downto 16) & s_snaplen(31 downto 24) when little_endian='1' else s_snaplen;
  sd_network            <= s_network(7 downto 0) & s_network(15 downto 8) & s_network(23 downto 16) & s_network(31 downto 24) when little_endian='1' else s_network;
  sd_ts_sec             <= s_ts_sec(7 downto 0) & s_ts_sec(15 downto 8) & s_ts_sec(23 downto 16) & s_ts_sec(31 downto 24) when little_endian='1' else s_ts_sec;
  sd_ts_usec            <= s_ts_usec(7 downto 0) & s_ts_usec(15 downto 8) & s_ts_usec(23 downto 16) & s_ts_usec(31 downto 24) when little_endian='1' else s_ts_usec;
  sd_incl_len           <= s_incl_len(7 downto 0) & s_incl_len(15 downto 8) & s_incl_len(23 downto 16) & s_incl_len(31 downto 24) when little_endian='1' else s_incl_len;
  sd_orig_len           <= s_orig_len(7 downto 0) & s_orig_len(15 downto 8) & s_orig_len(23 downto 16) & s_orig_len(31 downto 24) when little_endian='1' else s_orig_len;



  --! FSM to read data
  process(clk)

    VARIABLE char_buffer : character;
    VARIABLE eof         : boolean;
  begin
    if (rising_edge(clk)) then
      if (reset = '1') then
        -- treba ovo popravit i pregledat
        s_magic_number      <= (others => '0');
        s_version_major     <= (others => '0');
        s_version_minor     <= (others => '0');
        s_thiszone          <= (others => '0');
        s_sigfigs           <= (others => '0');
        s_snaplen           <= (others => '0');
        s_network           <= (others => '0');
        s_ts_sec            <= (others => '0');
        s_ts_usec           <= (others => '0');
        s_incl_len          <= (others => '0');
        byte_counter        <= 0;
        byte_index          <= 0;
        first_bytes         <= '1';
        output_data         <= (others => '0');
        s_start_of_packet   <= '0';
        s_end_of_packet     <='0';
        first_packet        <= 1;
        current_state <= st_start;
        
      else
        case current_state is
            when st_start =>
                s_end_of_packet <= '0';
                avalon_st_tx_valid <= '0';
                for i in 3 downto 0 loop  --reading magic number (4 bytes)
                    if (not(endfile(PCAP))) then
                        read(PCAP, char_buffer);
                        s_magic_number((i*8)+7 downto i*8 ) <= std_logic_vector(to_unsigned(character'POS(char_buffer), 8));
                    end if;
                end loop;

                if (endfile(PCAP)) then
                    current_state <= st_eof;
                else
                    current_state <= st_check_file;
                end if;

            when st_check_file  =>
                if (s_magic_number = x"d4c3b2a1" or s_magic_number=x"a1b2c3d4") then
                    current_state <= st_read_global_header;
                else
                    report "Selected file is not a PCAP file" severity failure;
                end if;

          when st_read_global_header=>
              
              for i in 1 downto 0 loop  --reading major version (2 bytes)
                  if (not(endfile(PCAP))) then
                      read(PCAP, char_buffer);
                      s_version_major((i*8)+7 downto i*8 ) <= std_logic_vector(to_unsigned(character'POS(char_buffer), 8));
                  end if;
              end loop;

              for i in 1 downto 0 loop  --reading minor version (2 bytes)
                  if (not(endfile(PCAP))) then
                      read(PCAP, char_buffer);
                      s_version_minor((i*8)+7 downto i*8 ) <= std_logic_vector(to_unsigned(character'POS(char_buffer), 8));
                  end if;
              end loop;

              for i in 3 downto 0 loop  --reading time zone (4 bytes)
                  if (not(endfile(PCAP))) then
                      read(PCAP, char_buffer);
                      s_thiszone((i*8)+7 downto i*8 ) <= std_logic_vector(to_unsigned(character'POS(char_buffer), 8));
                  end if;
              end loop;

              for i in 3 downto 0 loop  --reading sigfig (4 bytes)
                  if (not(endfile(PCAP))) then
                      read(PCAP, char_buffer);
                      s_sigfigs((i*8)+7 downto i*8 ) <= std_logic_vector(to_unsigned(character'POS(char_buffer), 8));
                  end if;
              end loop;

              for i in 3 downto 0 loop  --reading snaplen (4 bytes)
                  if (not(endfile(PCAP))) then
                      read(PCAP, char_buffer);
                      s_snaplen((i*8)+7 downto i*8 ) <= std_logic_vector(to_unsigned(character'POS(char_buffer), 8));
                  end if;
              end loop;

              for i in 3 downto 0 loop  --reading network type (4 bytes)
                  if (not(endfile(PCAP))) then
                      read(PCAP, char_buffer);
                      s_network((i*8)+7 downto i*8 ) <= std_logic_vector(to_unsigned(character'POS(char_buffer), 8));
                  end if;
              end loop;

              if (endfile(PCAP)) then
                  current_state <= st_eof;
              else
                  current_state <= st_read_packet_header;
              end if;

          when st_read_packet_header  =>
              first_bytes <= '1';  --signals start of reading new packet
              s_end_of_packet <= '0';
              avalon_st_tx_valid <= '0';
              output_data <= (others => '0');
	          s_empty <= "000";
              for i in 3 downto 0 loop  --reading seconds (4 bytes)
                  if (not(endfile(PCAP))) then
                      read(PCAP, char_buffer);
                      s_ts_sec((i*8)+7 downto i*8 ) <= std_logic_vector(to_unsigned(character'POS(char_buffer), 8));
                  end if;
              end loop;

              for i in 3 downto 0 loop  --reading micro secconds (4 bytes)
                  if (not(endfile(PCAP))) then
                      read(PCAP, char_buffer);
                      s_ts_usec((i*8)+7 downto i*8 ) <= std_logic_vector(to_unsigned(character'POS(char_buffer), 8));
                  end if;
              end loop;

              for i in 3 downto 0 loop  --reading packet length (4 bytes)
                  if (not(endfile(PCAP))) then
                      read(PCAP, char_buffer);
                      s_incl_len((i*8)+7 downto i*8 ) <= std_logic_vector(to_unsigned(character'POS(char_buffer), 8));
                  end if;
              end loop;

              for i in 3 downto 0 loop  --reading 'wire' length of packet (4 bytes)
                  if (not(endfile(PCAP))) then
                      read(PCAP, char_buffer);
                      s_orig_len((i*8)+7 downto i*8 ) <= std_logic_vector(to_unsigned(character'POS(char_buffer), 8));
                  end if;
              end loop;

              if (endfile(PCAP)) then
                  current_state <= st_eof;
              else
                  current_state <= st_packet_available;
              end if;

          when st_packet_available =>
	            if(first_packet = 1) then
                    sec_offset <= to_integer(unsigned(sd_ts_sec));
                    usec_offset <= to_integer(unsigned(sd_ts_usec));
                    first_packet <= 0;
              end if;
              current_state <= st_pause;

          when st_pause =>
            byte_counter <= 0;
            if( s_usec + usec_offset >= sd_ts_usec and s_sec + sec_offset >= sd_ts_sec) then
                current_state <= st_read_packet;	
            end if;	

          when st_read_packet =>
              if(avalon_st_tx_ready = '1') then
                if(first_bytes = '1') then
                    s_start_of_packet <= '1';
                    avalon_st_tx_valid <= '1';
                    first_bytes <= '0';
                else
                    s_start_of_packet <= '0';
                end if;
              
                if(byte_counter <= conv_integer(sd_incl_len) - 8) then
                    --read included data
                    for i in 7 downto 0 loop
                        if (not(endfile(PCAP))) then
                            read(PCAP, char_buffer);
                            output_data((i*8)+7 downto i*8 ) <= std_logic_vector(to_unsigned(character'POS(char_buffer), 8));
                        else
                            current_state <= st_eof;
                        end if;
                    end loop;
                    byte_counter <= byte_counter + 8;      
                elsif (byte_counter <= conv_integer(sd_incl_len))  then         
                    for i in 7 downto 7 - (conv_integer(sd_incl_len) - byte_counter) + 1 loop
                        if (not(endfile(PCAP))) then
                            read(PCAP, char_buffer);
                            output_data((i*8)+7 downto i*8 ) <= std_logic_vector(to_unsigned(character'POS(char_buffer), 8));
                        else
                            current_state <= st_eof; --greska???
                        end if;
                    end loop;
                    for i in 7 - (conv_integer(sd_incl_len) - byte_counter) downto 0 loop
                        output_data((i*8)+7 downto i*8 ) <= "00000000";
                    end loop;
                    if (byte_counter + 8 >= conv_integer(sd_orig_len)) then
                        s_end_of_packet <= '1';
                        s_empty <= std_logic_vector(to_unsigned(8 - (conv_integer(sd_incl_len) - byte_counter) - (conv_integer(sd_orig_len) - conv_integer(sd_incl_len)) , 3));
                        current_state <= st_read_packet_header;
                    else
                        byte_counter <= byte_counter + 8;
                    end if;
                   
                elsif(byte_counter <= conv_integer(sd_orig_len) - 8) then
                    for i in 7 downto 0 loop
                        output_data <= (others => '0');
                    end loop;
                    byte_counter <= byte_counter + 8;
                else
                    for i in 7 downto 0 loop
                        output_data <= (others => '0');
                    end loop;
                    s_end_of_packet <= '1';
                    s_empty <= std_logic_vector(to_unsigned(8- (conv_integer(sd_orig_len) - byte_counter), 3));
                    current_state <= st_read_packet_header;
                end if;
              end if;
          when st_eof =>
              current_state <= st_eof;
      end case;
    end if;
  end if;
end process;
end arch;


