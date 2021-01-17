LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use std.textio.all; 
ENTITY TB2 IS
END TB2;
 
ARCHITECTURE behavior OF TB2 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    
	 COMPONENT Compressor
    PORT(
			CLK : in std_logic;
         Data : IN  string(1 to 64);
         Compressed : INOUT  string(1 to 192)
        );
    END COMPONENT;
    
	 COMPONENT FileWriter
    PORT(
			WriteData: in String (1 to 192)
		  );
    END COMPONENT;
	 
	     COMPONENT FileReader
    PORT(
         ReadData : OUT  String(1 to 64)
        );
    END COMPONENT;
	 -------------------------------------------------------------------------
	 
	signal writeData : String(1 to 192):= "                                                                                                                                                                                                ";
   
	signal ReadData :  String(1 to 64):= "                                                                ";
	
   --Inputs
   signal Data : string(1 to 64) :=     "                                                                ";

	--BiDirs
   signal Compressed : string(1 to 192) := "                                                                                                                                                                                                ";
	
	signal clk : std_logic := '1';
	
	constant clk_period : time := 2000 ns;
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut1: Compressor PORT MAP (
			 clk => clk,
          Data => Data,
          Compressed => Compressed
        );
		  
	 uut2: FileReader PORT MAP (
          ReadData => ReadData
        );	  
		  
	uut3: FileWriter PORT MAP (
			 WriteData => WriteData
        );
   
	clk_proc: process
	begin
		clk <= '1';
		wait for clk_period/2;
		clk <= '0';
		wait for clk_period/2;
   end process;
   stim_proc: process
	
   begin		
		wait for 300 ns;
		Data <= ReadData;  --&"                                                                ";
		wait for 200000 ns;
		WriteData <= Compressed;
		wait;
   end process;

END;
