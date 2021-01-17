library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use std.textio.all;
use ieee.numeric_std.all;
--use ieee.std_logic_textio.all;

entity FileReader is
    Port (  ReadData : out  String (1 to 64));
end FileReader;

architecture Behavioral of FileReader is

begin

	p_read : process
		
		file File_toRead                : TEXT open read_mode is "INUN.txt";
		variable row                    : LINE;
		variable Char            : Character;
		variable output: String (1 to 64);
		variable idx: integer:=1;	
		
		begin
		wait for 100 ns;
			while not endfile(File_toread) loop
				readline(File_toread,row);
				for k in row'range loop
--				for i in 1 to 64 loop
					read(row,output(idx));
					idx := idx+1;
				end loop;
			end loop;
			ReadData <= output;
			report "Data to Read: " & output;
			file_close( File_toRead);
			
			wait;
	end process p_read;

end Behavioral;

