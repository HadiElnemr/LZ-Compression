library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

entity Compressor is
    Port ( 	Clk: in std_logic;
				Data : in string (1 to 64); 
				Compressed : inout  string(1 to 192) );
end Compressor;

architecture Behavioral of Compressor is
	
	
begin
	compress: process(clk)
	type StringArray is array(0 to 63) of string(1 to 3);
	type DictionaryStringArray is array(0 to 63) of string(1 to 11);
--	variable	Dictionary : DictionaryStringArray := ("           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " , "           " ); --6 chars (bytes)
	variable	Dictionary : DictionaryStringArray := ("***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********" ); --6 chars (bytes)
	variable	str : String(1 to 11) := "           ";
	variable dIdx: integer := 0;
	variable outIdx: integer := 0;
	variable refIdx : Integer := 0;
	variable ts : string(1 to 3) := "   ";
	variable i : Integer:= 1;
	variable outString : StringArray := ("   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ");
	variable final : string(1 to 192) := "************************************************************************************************************************************************************************************************";
	variable j : integer := 0;
	begin    
--	wait for 400 ns;
		if( clk'event and clk = '1') then
		if i < 65 then
--				str := "           ";
				str := "***********";
				refIdx := -1;
				j:=0;
				while j < 64 loop 
					if (i >= 65) then
						exit;
					end if;
					
					if (Dictionary(j) = str(2 to 11) & Data(i)) then
						str := str(2 to 11) & Data(i);
						refIdx := j;
--						j := -1;
						i := i + 1;
					end if;
					j:=j+1;
				end loop;
				if( i <65) then
					if refIdx = -1   then
						outString(outIdx) := " #" & Data(i) ;
						Dictionary(dIdx) := "**********" & Data(i);
					else
						if(refIdx > 9) then
							outString(outIdx) := integer'image(refIdx) & Data(i) ;
						else
							outString(outIdx) := " " & integer'image(refIdx) & Data(i) ;
						end if;
						Dictionary(dIdx) := Dictionary(refIdx)(2 to 11) & Data(i);
					end if;
	--				ts := integer'image(refIdx);
					dIdx := dIdx + 1;
					outIdx := outIdx + 1;	
					i := i+1;
				end if;
			end if;
--			if str /= "           " then
--				outString(outIdx) := Integer'image(refIdx) & " ";
--			end if;
			final := "                                                                                                                                                                                                ";
			for i in outString'range loop
				if outString(i) = "   " then
					exit;
				end if;	
				final := (final(4 to 192) & outString(i));
			end loop;
			end if;
			Compressed <= final;
			report final;
	end process;
end Behavioral;

