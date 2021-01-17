library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use std.textio.all;
use ieee.numeric_std.all;
--use ieee.std_logic_textio.all;

entity FileReaderD is
    Port (  ReadData : out  String (1 to 192));
end FileReaderD;

architecture Behavioral of FileReaderD is

begin

	p_read : process
		
		file File_toRead                : TEXT open read_mode is "OUTC.txt";
		variable row                    : LINE;
		variable Char            : Character;
		variable output: String (1 to 192):= "                                                                                                                                                                                                ";
		variable idx: integer:=1;	
		
		begin
			wait for 100 ns;
			while not endfile(File_toread) loop
				
				readline(File_toread,row);
				for k in row'range loop
					if(idx > 192)then 
						exit;
					end if;	
					read(row,output(idx));
					idx := idx+1;
				end loop;
			end loop;
			ReadData <= output;
			report "Reader output" & output;
			file_close(File_toRead);
			
			wait;
	end process p_read;

end Behavioral;

