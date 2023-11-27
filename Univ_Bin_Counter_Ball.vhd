LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
--------------------------------

ENTITY Univ_Bin_Counter_Ball IS 
  GENERIC ( N : INTEGER := 22);
  
  PORT    ( clk      : IN  STD_LOGIC;
            rst      : IN  STD_LOGIC;
				ena      : IN  STD_LOGIC;
				syn_clr  : IN  STD_LOGIC;
				load     : IN  STD_LOGIC;
				up       : IN  STD_LOGIC;
				d        : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0);
				max_tick : OUT STD_LOGIC;
				min_tick : OUT STD_LOGIC;
				counter  : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END ENTITY;
---------------------------------

ARCHITECTURE rtl OF Univ_Bin_Counter_Ball IS 

  CONSTANT MaxCount : UNSIGNED(N-1 DOWNTO 0) := "1011111010111100001000";--"110000110101000";--(500uS)14bts--"11000011010100"(250uS);--"10111110101111000010000000"(1S);
  CONSTANT ZEROS    : UNSIGNED(N-1 DOWNTO 0) := (OTHERS => '0');
  
  SIGNAL count_s    : UNSIGNED(N-1 DOWNTO 0);
  SIGNAL count_next : UNSIGNED(N-1 DOWNTO 0);
  
  BEGIN 
    --NEXT STATE LOGIC--
    count_next <= (OTHERS => '0') WHEN syn_clr = '1'            ELSE 
                  UNSIGNED(d)    WHEN load = '1'               ELSE 
					    count_s + 1    WHEN (ena = '1' AND up = '1') ELSE	 
                   count_s - 1    WHEN (ena = '1' AND up = '0') ELSE 
						 count_s;

    PROCESS(clk,rst)
	   VARIABLE temp : UNSIGNED (N-1 DOWNTO 0);
		
		BEGIN 
		  IF(rst = '1')THEN
		    temp := (OTHERS => '0');
		  ELSIF(rising_edge(clk))THEN
		    IF(ena = '1')THEN 
			   temp := count_next;
		    END IF;
		  END IF;
		counter <= STD_LOGIC_VECTOR(temp);
		count_s <= temp;
    END PROCESS;
  
  ---- OUTPUT LOGIC ----
  max_tick <= '1' WHEN count_s = MaxCount ELSE '0';
  min_tick <= '1' WHEN count_s = ZEROS    ELSE '0';
END ARCHITECTURE; 