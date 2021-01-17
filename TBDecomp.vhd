LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use std.textio.all; 
ENTITY TBDecomp IS
END TBDecomp;
 
ARCHITECTURE behavior OF TBDecomp IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    
	 COMPONENT Decompress
    PORT(
			Clk : in std_logic;
         Compressed : IN  string(1 to 192);
         Decompressed : out  string(1 to 64)
        );
    END COMPONENT;
    
	 COMPONENT FileWriterD
    PORT(
			WriteData: in String (1 to 192)
		  );
    END COMPONENT;
	 
	     COMPONENT FileReaderD
    PORT(
         ReadData : OUT  String(1 to 192)
        );
    END COMPONENT;
	 -------------------------------------------------------------------------
	 
	signal writeData : String(1 to 192):= "                                                                                                                                                                                                ";
   
	signal ReadData :  String(1 to 192):= "                                                                                                                                                                                                ";
	
   --Inputs
   signal Decompressed : string(1 to 64) :=     "                                                                ";

	--BiDirs
   signal Compressed : string(1 to 192) := "                                                                                                                                                                                                ";
	
	signal clk : std_logic := '1';
	
	constant clk_period : time := 2000 ns;
	
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut1: DeCompress PORT MAP (
          clk => clk,
			 Compressed => Compressed,
          deCompressed => deCompressed
        );
		  
	 uut2: FileReaderD PORT MAP (
          ReadData => ReadData
        );	  
		  
	uut3: FileWriterD PORT MAP (
			 WriteData => WriteData
        );
   
	clk_process: process
	begin
		wait for clk_period/2;
		clk<= '0';
		wait for clk_period/2;
		clk<= '1';
	end process;
	
   stim_proc: process
	
   begin		
		wait for 200 ns;
		Compressed <= ReadData;  --&"                                                                ";
		wait for 2000000 ns;
		report Decompressed;
		WriteData <= Decompressed & "                                                                                                                                ";
		wait;
   end process;

END;
