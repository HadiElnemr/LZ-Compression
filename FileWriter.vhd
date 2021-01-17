library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use STD.TEXTIO.all;
entity FileWriter is
	port(
			WriteData: in String(1 to 192)
	);
end FileWriter;

architecture Behavioral of FileWriter is
	
begin
	
	 process
		
    file F: TEXT open WRITE_MODE is "OUTC.txt";
    variable L: LINE;
	 variable temp: String (1 to 192):= "                                                                                                                                                                                                ";

  begin
	wait for 2000000 ns;
	temp:= WriteData;
	for i in temp'range loop
		if(temp(1) = '*') then
			temp := temp(2 to 192) & " ";
		end if;
	end loop;
	for i in temp'range loop
		 WRITE (L, temp(i), Left);
	end loop;
	
	report("Data to be written : " & WriteData);
	
	WRITELINE (F, L);
	file_close(F);
	wait;
	end process;

end Behavioral;

