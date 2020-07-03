-- Copyright (C) 2018  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 18.1.0 Build 625 09/12/2018 SJ Lite Edition"

-- DATE "01/23/2020 09:26:29"

-- 
-- Device: Altera 5CGXFC7C6F23I7 Package FBGA484
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA_LNSIM;
LIBRARY CYCLONEV;
LIBRARY IEEE;
USE ALTERA_LNSIM.ALTERA_LNSIM_COMPONENTS.ALL;
USE CYCLONEV.CYCLONEV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	run_modelsim IS
    PORT (
	FREQUENCY : IN std_logic_vector(22 DOWNTO 0);
	CLK : IN std_logic;
	RST : IN std_logic;
	PHASE : OUT std_logic_vector(22 DOWNTO 0)
	);
END run_modelsim;

-- Design Ports Information
-- FREQUENCY[0]	=>  Location: PIN_AA22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- FREQUENCY[1]	=>  Location: PIN_N6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- FREQUENCY[2]	=>  Location: PIN_P18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- FREQUENCY[3]	=>  Location: PIN_A13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- FREQUENCY[4]	=>  Location: PIN_A8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- FREQUENCY[5]	=>  Location: PIN_U7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- FREQUENCY[6]	=>  Location: PIN_V16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- FREQUENCY[7]	=>  Location: PIN_H13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- FREQUENCY[8]	=>  Location: PIN_L19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- FREQUENCY[9]	=>  Location: PIN_A5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- FREQUENCY[10]	=>  Location: PIN_Y14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- FREQUENCY[11]	=>  Location: PIN_AA9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- FREQUENCY[12]	=>  Location: PIN_E12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- FREQUENCY[13]	=>  Location: PIN_AA12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- FREQUENCY[14]	=>  Location: PIN_A17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- FREQUENCY[15]	=>  Location: PIN_E21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- FREQUENCY[16]	=>  Location: PIN_D12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- FREQUENCY[17]	=>  Location: PIN_G16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- FREQUENCY[18]	=>  Location: PIN_E20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- FREQUENCY[19]	=>  Location: PIN_C11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- FREQUENCY[20]	=>  Location: PIN_H16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- FREQUENCY[21]	=>  Location: PIN_T20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- FREQUENCY[22]	=>  Location: PIN_T18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- CLK	=>  Location: PIN_M16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- RST	=>  Location: PIN_AA18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PHASE[0]	=>  Location: PIN_B11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PHASE[1]	=>  Location: PIN_F22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PHASE[2]	=>  Location: PIN_R15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PHASE[3]	=>  Location: PIN_AB11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PHASE[4]	=>  Location: PIN_R6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PHASE[5]	=>  Location: PIN_C15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PHASE[6]	=>  Location: PIN_D22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PHASE[7]	=>  Location: PIN_T9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PHASE[8]	=>  Location: PIN_Y17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PHASE[9]	=>  Location: PIN_F13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PHASE[10]	=>  Location: PIN_AB22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PHASE[11]	=>  Location: PIN_A10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PHASE[12]	=>  Location: PIN_M22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PHASE[13]	=>  Location: PIN_L18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PHASE[14]	=>  Location: PIN_G8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PHASE[15]	=>  Location: PIN_F19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PHASE[16]	=>  Location: PIN_C18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PHASE[17]	=>  Location: PIN_P8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PHASE[18]	=>  Location: PIN_A9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PHASE[19]	=>  Location: PIN_D9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PHASE[20]	=>  Location: PIN_U8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PHASE[21]	=>  Location: PIN_G6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PHASE[22]	=>  Location: PIN_T12,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF run_modelsim IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_FREQUENCY : std_logic_vector(22 DOWNTO 0);
SIGNAL ww_CLK : std_logic;
SIGNAL ww_RST : std_logic;
SIGNAL ww_PHASE : std_logic_vector(22 DOWNTO 0);
SIGNAL \FREQUENCY[0]~input_o\ : std_logic;
SIGNAL \FREQUENCY[1]~input_o\ : std_logic;
SIGNAL \FREQUENCY[2]~input_o\ : std_logic;
SIGNAL \FREQUENCY[3]~input_o\ : std_logic;
SIGNAL \FREQUENCY[4]~input_o\ : std_logic;
SIGNAL \FREQUENCY[5]~input_o\ : std_logic;
SIGNAL \FREQUENCY[6]~input_o\ : std_logic;
SIGNAL \FREQUENCY[7]~input_o\ : std_logic;
SIGNAL \FREQUENCY[8]~input_o\ : std_logic;
SIGNAL \FREQUENCY[9]~input_o\ : std_logic;
SIGNAL \FREQUENCY[10]~input_o\ : std_logic;
SIGNAL \FREQUENCY[11]~input_o\ : std_logic;
SIGNAL \FREQUENCY[12]~input_o\ : std_logic;
SIGNAL \FREQUENCY[13]~input_o\ : std_logic;
SIGNAL \FREQUENCY[14]~input_o\ : std_logic;
SIGNAL \FREQUENCY[15]~input_o\ : std_logic;
SIGNAL \FREQUENCY[16]~input_o\ : std_logic;
SIGNAL \FREQUENCY[17]~input_o\ : std_logic;
SIGNAL \FREQUENCY[18]~input_o\ : std_logic;
SIGNAL \FREQUENCY[19]~input_o\ : std_logic;
SIGNAL \FREQUENCY[20]~input_o\ : std_logic;
SIGNAL \FREQUENCY[21]~input_o\ : std_logic;
SIGNAL \FREQUENCY[22]~input_o\ : std_logic;
SIGNAL \CLK~input_o\ : std_logic;
SIGNAL \RST~input_o\ : std_logic;
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;

BEGIN

ww_FREQUENCY <= FREQUENCY;
ww_CLK <= CLK;
ww_RST <= RST;
PHASE <= ww_PHASE;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

-- Location: IOOBUF_X50_Y81_N93
\PHASE[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_PHASE(0));

-- Location: IOOBUF_X82_Y81_N93
\PHASE[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_PHASE(1));

-- Location: IOOBUF_X89_Y6_N22
\PHASE[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_PHASE(2));

-- Location: IOOBUF_X38_Y0_N36
\PHASE[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_PHASE(3));

-- Location: IOOBUF_X2_Y0_N59
\PHASE[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_PHASE(4));

-- Location: IOOBUF_X62_Y81_N2
\PHASE[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_PHASE(5));

-- Location: IOOBUF_X80_Y81_N53
\PHASE[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_PHASE(6));

-- Location: IOOBUF_X30_Y0_N19
\PHASE[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_PHASE(7));

-- Location: IOOBUF_X58_Y0_N42
\PHASE[8]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_PHASE(8));

-- Location: IOOBUF_X58_Y81_N59
\PHASE[9]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_PHASE(9));

-- Location: IOOBUF_X64_Y0_N53
\PHASE[10]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_PHASE(10));

-- Location: IOOBUF_X36_Y81_N36
\PHASE[11]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_PHASE(11));

-- Location: IOOBUF_X89_Y36_N39
\PHASE[12]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_PHASE(12));

-- Location: IOOBUF_X89_Y38_N22
\PHASE[13]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_PHASE(13));

-- Location: IOOBUF_X38_Y81_N53
\PHASE[14]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_PHASE(14));

-- Location: IOOBUF_X76_Y81_N2
\PHASE[15]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_PHASE(15));

-- Location: IOOBUF_X78_Y81_N19
\PHASE[16]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_PHASE(16));

-- Location: IOOBUF_X28_Y0_N19
\PHASE[17]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_PHASE(17));

-- Location: IOOBUF_X36_Y81_N53
\PHASE[18]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_PHASE(18));

-- Location: IOOBUF_X28_Y81_N19
\PHASE[19]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_PHASE(19));

-- Location: IOOBUF_X2_Y0_N76
\PHASE[20]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_PHASE(20));

-- Location: IOOBUF_X26_Y81_N42
\PHASE[21]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_PHASE(21));

-- Location: IOOBUF_X52_Y0_N19
\PHASE[22]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_PHASE(22));

-- Location: IOIBUF_X64_Y0_N35
\FREQUENCY[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_FREQUENCY(0),
	o => \FREQUENCY[0]~input_o\);

-- Location: IOIBUF_X4_Y0_N1
\FREQUENCY[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_FREQUENCY(1),
	o => \FREQUENCY[1]~input_o\);

-- Location: IOIBUF_X89_Y9_N55
\FREQUENCY[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_FREQUENCY(2),
	o => \FREQUENCY[2]~input_o\);

-- Location: IOIBUF_X60_Y81_N52
\FREQUENCY[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_FREQUENCY(3),
	o => \FREQUENCY[3]~input_o\);

-- Location: IOIBUF_X30_Y81_N1
\FREQUENCY[4]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_FREQUENCY(4),
	o => \FREQUENCY[4]~input_o\);

-- Location: IOIBUF_X2_Y0_N92
\FREQUENCY[5]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_FREQUENCY(5),
	o => \FREQUENCY[5]~input_o\);

-- Location: IOIBUF_X64_Y0_N18
\FREQUENCY[6]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_FREQUENCY(6),
	o => \FREQUENCY[6]~input_o\);

-- Location: IOIBUF_X56_Y81_N1
\FREQUENCY[7]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_FREQUENCY(7),
	o => \FREQUENCY[7]~input_o\);

-- Location: IOIBUF_X89_Y38_N4
\FREQUENCY[8]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_FREQUENCY(8),
	o => \FREQUENCY[8]~input_o\);

-- Location: IOIBUF_X34_Y81_N75
\FREQUENCY[9]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_FREQUENCY(9),
	o => \FREQUENCY[9]~input_o\);

-- Location: IOIBUF_X54_Y0_N18
\FREQUENCY[10]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_FREQUENCY(10),
	o => \FREQUENCY[10]~input_o\);

-- Location: IOIBUF_X32_Y0_N35
\FREQUENCY[11]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_FREQUENCY(11),
	o => \FREQUENCY[11]~input_o\);

-- Location: IOIBUF_X50_Y81_N58
\FREQUENCY[12]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_FREQUENCY(12),
	o => \FREQUENCY[12]~input_o\);

-- Location: IOIBUF_X40_Y0_N35
\FREQUENCY[13]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_FREQUENCY(13),
	o => \FREQUENCY[13]~input_o\);

-- Location: IOIBUF_X74_Y81_N58
\FREQUENCY[14]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_FREQUENCY(14),
	o => \FREQUENCY[14]~input_o\);

-- Location: IOIBUF_X88_Y81_N36
\FREQUENCY[15]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_FREQUENCY(15),
	o => \FREQUENCY[15]~input_o\);

-- Location: IOIBUF_X50_Y81_N41
\FREQUENCY[16]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_FREQUENCY(16),
	o => \FREQUENCY[16]~input_o\);

-- Location: IOIBUF_X70_Y81_N52
\FREQUENCY[17]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_FREQUENCY(17),
	o => \FREQUENCY[17]~input_o\);

-- Location: IOIBUF_X76_Y81_N35
\FREQUENCY[18]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_FREQUENCY(18),
	o => \FREQUENCY[18]~input_o\);

-- Location: IOIBUF_X50_Y81_N75
\FREQUENCY[19]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_FREQUENCY(19),
	o => \FREQUENCY[19]~input_o\);

-- Location: IOIBUF_X64_Y81_N1
\FREQUENCY[20]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_FREQUENCY(20),
	o => \FREQUENCY[20]~input_o\);

-- Location: IOIBUF_X89_Y4_N95
\FREQUENCY[21]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_FREQUENCY(21),
	o => \FREQUENCY[21]~input_o\);

-- Location: IOIBUF_X89_Y4_N44
\FREQUENCY[22]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_FREQUENCY(22),
	o => \FREQUENCY[22]~input_o\);

-- Location: IOIBUF_X89_Y35_N61
\CLK~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_CLK,
	o => \CLK~input_o\);

-- Location: IOIBUF_X60_Y0_N35
\RST~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_RST,
	o => \RST~input_o\);

-- Location: MLABCELL_X8_Y47_N0
\~QUARTUS_CREATED_GND~I\ : cyclonev_lcell_comb
-- Equation(s):

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
;
END structure;


