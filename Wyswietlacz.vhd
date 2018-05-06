
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity lcd is
    Port (	Clk : in  STD_LOGIC;
			--reset : in std_logic;
			BT : in std_logic_vector(3 downto 0);
			SW : in std_logic_vector(7 downto 0);
			AN : out  STD_LOGIC_vector(3 downto 0);
			SEG : out  STD_LOGIC_vector(6 downto 0);
			dp : out std_logic);
end lcd;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dzielnik is
    Port ( --Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           LD7 : out  STD_LOGIC);
end dzielnik;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity display is
Port (     	Clk : in  STD_LOGIC;
				digit_i : in  STD_LOGIC_vector(31 downto 0);
				AN : out  STD_LOGIC_vector(3 downto 0);
				SEG : out  STD_LOGIC_vector(6 downto 0);
				dp : out std_logic);
end display;

architecture wyswietl of display is
begin
	pokaz: process(Clk) is
		variable counter: integer range 0 to 3 := 0;
		begin
			if rising_edge(Clk)	then
				if(counter = 0) then
					SEG <= digit_i(6 downto 0);
					AN <= "1110";
					dp <= digit_i(7);
				elsif(counter = 1) then
					SEG <= digit_i(14 downto 8);
					AN <= "1110";
					dp <= digit_i(15);
				elsif(counter = 2) then
					SEG <= digit_i(22 downto 16);
					AN <= "1110";
					dp <= digit_i(23);
				elsif(counter = 3) then
					SEG <= digit_i(30 downto 24);
					AN <= "1110";
					dp <= digit_i(31);
				end if;
				counter := counter + 1;
				if (counter = 4) then 
				counter := 0;
				end if;
			end if;
		end process;
end wyswietl;

architecture var of dzielnik is
constant N : integer := 50000; 
begin

	dzielimy: process(Clk) is
		variable counter : integer range 0 to N := 0;
		variable state : std_logic := '0';
		begin
--		if (Reset = '1') then
--			state := '0';
--			counter := 0;
		if rising_edge(Clk) then

			if (counter = N/2) then
				state := '1';
			elsif(counter = N) then
				state := '0';
				counter := 0;
			end if;
			counter := counter + 1;
		end if;
			LD7 <= state;
	end process;
end var;

architecture Behavioral of lcd is

component dzielnik is
    Port ( --Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           LD7 : out  STD_LOGIC);
end component dzielnik;

component display is
Port (     	Clk : in  STD_LOGIC;
				digit_i : in  STD_LOGIC_vector(31 downto 0);
				AN : out  STD_LOGIC_vector(3 downto 0);
				SEG : out  STD_LOGIC_vector(6 downto 0);
				dp : out std_logic);
end component display;

signal Clock: std_logic;
signal digit_i: std_logic_vector(31 downto 0);

begin
	g1: dzielnik port map (Clk, Clock);
	
	p0:process (Clock)
		variable state0, state1, state2, state3 : std_logic_vector (6 downto 0) := "1111111"; 
	begin
--		if (reset = '1') then
--			state0 := "1111111";
--			state1 := "1111111";
--			state2 := "1111111";
--			state3 := "1111111";
		if rising_edge(Clock) then
			if(BT(0) = '1') then
				case std_logic_vector'(SW(3),SW(2),SW(1),SW(0)) is
					when "0000" =>
						state0 := (6=>'1', others=>'0');
					when "0001" =>
						state0 := (1=>'0', 2=>'0', others=>'1');
					when "0010" =>
						state0 := (2=>'1', 5=>'1', others=>'0');
					when "0011" =>
						state0 := (4=>'1', 5=>'1', others=>'0');
					when "0100" =>
						state0 := (0=>'1', 3=>'1', 4=>'1', others=>'0');
					when "0101" =>
						state0 := (1=>'1', 4=>'1', others=>'0');
					when "0110" =>
						state0 := (1=>'1', others=>'0');
					when "0111" =>
						state0 := (0=>'0', 1=>'0', 2=>'0', others=>'1');
					when "1000" =>
						state0 := (others=>'0');
					when "1001" =>
						state0 := (3=>'1', 4=>'1', others=>'0');
					when "1010" =>
						state0 := (3=>'1', others=>'0');
					when "1011" =>
						state0 := (0=>'1', 1=>'1', others=>'0');
					when "1100" =>
						state0 := (1=>'1', 2=>'1', 6=>'1', others=>'0');
					when "1101" =>
						state0 := (0=>'1', 5=>'1', others=>'0');
					when "1110" =>
						state0 := (1=>'1', 2=>'1', others=>'0');
					when "1111" =>
						state0 := (1=>'1', 2=>'1', 3=>'1', others=>'0');
					when others => null;
					end case;
			elsif(BT(1) = '1') then 
				case std_logic_vector'(SW(3),SW(2),SW(1),SW(0)) is
					when "0000" =>
						state1 := (6=>'1', others=>'0');
					when "0001" =>
						state1 := (1=>'0', 2=>'0', others=>'1');
					when "0010" =>
						state1 := (2=>'1', 5=>'1', others=>'0');
					when "0011" =>
						state1 := (4=>'1', 5=>'1', others=>'0');
					when "0100" =>
						state1 := (0=>'1', 3=>'1', 4=>'1', others=>'0');
					when "0101" =>
						state1 := (1=>'1', 4=>'1', others=>'0');
					when "0110" =>
						state1 := (1=>'1', others=>'0');
					when "0111" =>
						state1 := (0=>'0', 1=>'0', 2=>'0', others=>'1');
					when "1000" =>
						state1 := (others=>'0');
					when "1001" =>
						state1 := (3=>'1', 4=>'1', others=>'0');
					when "1010" =>
						state1 := (3=>'1', others=>'0');
					when "1011" =>
						state1 := (0=>'1', 1=>'1', others=>'0');
					when "1100" =>
						state1 := (1=>'1', 2=>'1', 6=>'1', others=>'0');
					when "1101" =>
						state1 := (0=>'1', 5=>'1', others=>'0');
					when "1110" =>
						state1 := (1=>'1', 2=>'1', others=>'0');
					when "1111" =>
						state1 := (1=>'1', 2=>'1', 3=>'1', others=>'0');
					when others => null;
					end case;
			elsif(BT(2) = '1') then
				case std_logic_vector'(SW(3),SW(2),SW(1),SW(0)) is
					when "0000" =>
						state2 := (6=>'1', others=>'0');
					when "0001" =>
						state2 := (1=>'0', 2=>'0', others=>'1');
					when "0010" =>
						state2 := (2=>'1', 5=>'1', others=>'0');
					when "0011" =>
						state2 := (4=>'1', 5=>'1', others=>'0');
					when "0100" =>
						state2 := (0=>'1', 3=>'1', 4=>'1', others=>'0');
					when "0101" =>
						state2 := (1=>'1', 4=>'1', others=>'0');
					when "0110" =>
						state2 := (1=>'1', others=>'0');
					when "0111" =>
						state2 := (0=>'0', 1=>'0', 2=>'0', others=>'1');
					when "1000" =>
						state2 := (others=>'0');
					when "1001" =>
						state2 := (3=>'1', 4=>'1', others=>'0');
					when "1010" =>
						state2 := (3=>'1', others=>'0');
					when "1011" =>
						state2 := (0=>'1', 1=>'1', others=>'0');
					when "1100" =>
						state2 := (1=>'1', 2=>'1', 6=>'1', others=>'0');
					when "1101" =>
						state2 := (0=>'1', 5=>'1', others=>'0');
					when "1110" =>
						state2 := (1=>'1', 2=>'1', others=>'0');
					when "1111" =>
						state2 := (1=>'1', 2=>'1', 3=>'1', others=>'0');
					when others => null;
					end case;
			elsif(BT(3) = '1') then
				case std_logic_vector'(SW(3),SW(2),SW(1),SW(0)) is
					when "0000" =>
						state3 := (6=>'1', others=>'0');
					when "0001" =>
						state3 := (1=>'0', 2=>'0', others=>'1');
					when "0010" =>
						state3 := (2=>'1', 5=>'1', others=>'0');
					when "0011" =>
						state3 := (4=>'1', 5=>'1', others=>'0');
					when "0100" =>
						state3 := (0=>'1', 3=>'1', 4=>'1', others=>'0');
					when "0101" =>
						state3 := (1=>'1', 4=>'1', others=>'0');
					when "0110" =>
						state3 := (1=>'1', others=>'0');
					when "0111" =>
						state3 := (0=>'0', 1=>'0', 2=>'0', others=>'1');
					when "1000" =>
						state3 := (others=>'0');
					when "1001" =>
						state3 := (3=>'1', 4=>'1', others=>'0');
					when "1010" =>
						state3 := (3=>'1', others=>'0');
					when "1011" =>
						state3 := (0=>'1', 1=>'1', others=>'0');
					when "1100" =>
						state3 := (1=>'1', 2=>'1', 6=>'1', others=>'0');
					when "1101" =>
						state3 := (0=>'1', 5=>'1', others=>'0');
					when "1110" =>
						state3 := (1=>'1', 2=>'1', others=>'0');
					when "1111" =>
						state3 := (1=>'1', 2=>'1', 3=>'1', others=>'0');
					when others => null;
				end case;
				
			end if;
			digit_i <= std_logic_vector'(SW(7), state3, SW(6), state2, SW(5), state1, SW(4), state0);
	end if;
	end process;
			
	g2: display port map (Clock, digit_i, AN, SEG, dp);
	
end Behavioral;
