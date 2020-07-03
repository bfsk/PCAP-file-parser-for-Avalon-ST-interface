library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity pcap_reader_writer_test is 
  port (
    clk : in  std_logic;--! system clock
    reset : in std_logic
);
end pcap_reader_writer_test;

architecture arch of pcap_reader_writer_test is
  signal s_avalon_st_ready          : std_logic;
  signal s_avalon_st_valid          : std_logic;
  signal s_avalon_st_startofpacket  : std_logic;    
  signal s_avalon_st_endofpacket    : std_logic;
  signal s_avalon_st_data           : std_logic_vector(63 downto 0);
  signal s_avalon_st_empty        : std_logic_vector(2 downto 0);
  signal s_avalon_st_error          : std_logic;

  component pcap_reader is
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
  end component;
  component pcap_writer is
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
  end component;
begin
veza_a: pcap_reader port map(clk, reset, s_avalon_st_ready, s_avalon_st_valid, s_avalon_st_startofpacket, s_avalon_st_endofpacket, s_avalon_st_data, s_avalon_st_empty, s_avalon_st_error);
veza_b: pcap_writer port map(clk, reset, s_avalon_st_ready, s_avalon_st_valid, s_avalon_st_startofpacket, s_avalon_st_endofpacket, s_avalon_st_data, s_avalon_st_empty, s_avalon_st_error);
end arch;