library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use STD.TEXTIO.all;
entity FileWriterD is
	port(
			WriteData: in String(1 to 192)
	);
end FileWriterD;

architecture Behavioral of FileWriterD is
	
begin
	
	 process

    file F: TEXT open WRITE_MODE is "OUTD.txt";
    variable L: LINE;
    variable temp: String (1 to 192):= "                                                                                                                                                                                                ";
	 
  begin
	wait for 20000000 ns;
	temp:= WriteData;
	for i in temp'range loop
		if(temp(1) = '*') then
			temp := temp(2 to 192) & " ";
		end if;
	end loop;
	for i in temp'range loop
		 WRITE (L, temp(i), Left);
	end loop;

	report("Data Written : " & temp);
	
	WRITELINE (F, L);
	file_close(F);
	wait;
	end process;

end Behavioral;

