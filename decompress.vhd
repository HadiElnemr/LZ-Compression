library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;
USE STD.TEXTIO.ALL;


entity Decompress is
	port( CLK : in std_logic;
			Compressed : in string(1 to 192);
			Decompressed : out string(1 to 64)
		);
end Decompress;


architecture Behavioral of Decompress is
 ----------------------------------------------------------------------
  function string_to_int(x_str : string; radix : positive range 2 to 36 := 10) return integer is
    constant STR_LEN          : integer := x_str'length;
    
    variable chr_val          : integer;
    variable ret_int          : integer := 0;
    variable do_mult          : boolean := true;
    variable power            : integer := 0;
  begin
    
    for i in STR_LEN downto 1 loop
      case x_str(i) is
        when '0'       =>   chr_val := 0;
        when '1'       =>   chr_val := 1;
        when '2'       =>   chr_val := 2;
        when '3'       =>	   chr_val := 3;
        when '4'       =>   chr_val := 4;
        when '5'       =>   chr_val := 5;
        when '6'       =>   chr_val := 6;
        when '7'       =>   chr_val := 7;
        when '8'       =>   chr_val := 8;
        when '9'       =>   chr_val := 9;
        when 'A' | 'a' =>   chr_val := 10;
        when 'B' | 'b' =>   chr_val := 11;
        when 'C' | 'c' =>   chr_val := 12;
        when 'D' | 'd' =>   chr_val := 13;
        when 'E' | 'e' =>   chr_val := 14;
        when 'F' | 'f' =>   chr_val := 15;
        when 'G' | 'g' =>   chr_val := 16;
        when 'H' | 'h' =>   chr_val := 17;
        when 'I' | 'i' =>   chr_val := 18;
        when 'J' | 'j' =>   chr_val := 19;
        when 'K' | 'k' =>   chr_val := 20;
        when 'L' | 'l' =>   chr_val := 21;
        when 'M' | 'm' =>   chr_val := 22;
        when 'N' | 'n' =>   chr_val := 23;
        when 'O' | 'o' =>   chr_val := 24;
        when 'P' | 'p' =>   chr_val := 25;
        when 'Q' | 'q' =>   chr_val := 26;
        when 'R' | 'r' =>   chr_val := 27;
        when 'S' | 's' =>   chr_val := 28;
        when 'T' | 't' =>   chr_val := 29;
        when 'U' | 'u' =>   chr_val := 30;
        when 'V' | 'v' =>   chr_val := 31;
        when 'W' | 'w' =>   chr_val := 32;
        when 'X' | 'x' =>   chr_val := 33;
        when 'Y' | 'y' =>   chr_val := 34;
        when 'Z' | 'z' =>   chr_val := 35;                           
        when '-' =>   
          if i /= 1 then
            report "Minus sign must be at the front of the string" severity failure;
          else
            ret_int           := 0 - ret_int;
            chr_val           := 0;
            do_mult           := false;    --Minus sign - do not do any number manipulation
          end if;
                     
        when others => report "Illegal character for conversion for string to integer" severity failure;
      end case;
      
      if chr_val >= radix then report "Illagel character at this radix" severity failure; end if;
        
      if do_mult then
        ret_int               := ret_int + (chr_val * (radix**power));
      end if;
        
      power                   := power + 1;
          
    end loop;
    
    return ret_int;
    
  end function;
begin
Decompress: process(CLK)
	type StringArray is array(0 to 63) of string(1 to 3);
	type DictionaryStringArray is array(0 to 63) of string(1 to 11);
	variable	Dictionary : DictionaryStringArray := ("***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********", "***********" ); --6 chars (bytes)
	variable dIdx: integer := 0;
	variable outIdx: integer := 0;
	variable refIdx : Integer := 0;
--	variable final : string(1 to 64) := "                                                                ";
	variable final : string(1 to 64) := "****************************************************************";
--	variable shortfinal : string(1 to 64) := "                                                                ";
	variable strt : integer range 0 to 200 := 1;
	variable refcom : Integer := 0;
--	variable temp : string (1 to 2):= "  ";
	
	begin
	if(now > 300 ns and clk'event and clk='1') then
--		while strt<127 loop
		if strt<191 then
			if compressed(strt + 1) = ' ' then
				strt := strt + 1;
			else
				if Compressed(strt) = ' ' then
					
					if	Compressed(strt + 1) = '#' then
						Dictionary(dIdx) := "**********" & Compressed(strt + 2);
						final := final( 2 to 64) & Compressed(strt + 2);
					else
						refcom := string_to_int("" & Compressed(strt + 1));
						
						Dictionary(dIdx) :=  Dictionary(refcom)(2 to 11) & Compressed(strt + 2);
						for n in Dictionary(dIdx)'range loop
							if ( Dictionary(dIdx)(n) /= '*') then
									final := final( 2 to 64) & Dictionary(dIdx)(n);
							end if;
						end loop;
					end if;  				
				else
					refcom := string_to_int("" & Compressed(strt) & Compressed(strt + 1));
					Dictionary(dIdx) :=  Dictionary(refcom)(2 to 11) & Compressed(strt + 2);
					for n in Dictionary(dIdx)'range loop
						if ( Dictionary(dIdx)(n) /= '*') then
							final := final( 2 to 64) & Dictionary(dIdx)(n);
						end if;
					end loop; 
				end if;
				strt := strt+3;
				didx := 	dIdx+1;
				
				
--			end loop;
			end if; -- of space character	
			end if; -- of loop
			Decompressed <= final;

		
	end if;	
end process;
end Behavioral;


-- al4ea55alfal2345srf53rtaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa$
-- [ #d #f #g #s 0g 0s #y #3 #6 #8 #5 72 #7 8t128 74 # 16 17 18 19 20 21 22]
