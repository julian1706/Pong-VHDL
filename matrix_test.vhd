LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
-------------------------
ENTITY matrix_test IS 
  PORT ( rst     : IN STD_LOGIC;
         clk     : IN STD_LOGIC;
			b_up    : IN STD_LOGIC;
			b_down  : IN STD_LOGIC;
			b_up2   : IN STD_LOGIC;
			b_down2 : IN STD_LOGIC;
					
			c0      : OUT STD_LOGIC;
			c1      : OUT STD_LOGIC;
			c2      : OUT STD_LOGIC;
			c3      : OUT STD_LOGIC;
			c4      : OUT STD_LOGIC;
			c5      : OUT STD_LOGIC;
			c6      : OUT STD_LOGIC;
			c7      : OUT STD_LOGIC;
			c8      : OUT STD_LOGIC;
			c9      : OUT STD_LOGIC;
			c10     : OUT STD_LOGIC;
			c11     : OUT STD_LOGIC;
			c12     : OUT STD_LOGIC;
			c13     : OUT STD_LOGIC;
			c14     : OUT STD_LOGIC;
			c15     : OUT STD_LOGIC;
			
			f0      : OUT STD_LOGIC;
			f1      : OUT STD_LOGIC;
			f2      : OUT STD_LOGIC;
			f3      : OUT STD_LOGIC;
			f4      : OUT STD_LOGIC;
			f5      : OUT STD_LOGIC;
			f6      : OUT STD_LOGIC;
			f7      : OUT STD_LOGIC;
			
			sP10    : OUT STD_LOGIC;
			sP11    : OUT STD_LOGIC;
			sP12    : OUT STD_LOGIC;
			sP13    : OUT STD_LOGIC;
			sP14    : OUT STD_LOGIC;
			sP15    : OUT STD_LOGIC;
			sP16    : OUT STD_LOGIC;
			
			sP20    : OUT STD_LOGIC;
			sP21    : OUT STD_LOGIC;
			sP22    : OUT STD_LOGIC;
			sP23    : OUT STD_LOGIC;
			sP24    : OUT STD_LOGIC;
			sP25    : OUT STD_LOGIC;
			sP26    : OUT STD_LOGIC);
			
			
END ENTITY matrix_test;
------------------------------------------------
ARCHITECTURE fsm OF matrix_test IS 
  TYPE state IS (ena_c0, ena_c1, ena_c2, ena_c3, ena_c4, ena_c5, ena_c6, ena_c7, ena_c8, ena_c9, ena_c10, ena_c11, ena_c12, ena_c13, ena_c14 ,ena_c15);
  
  SIGNAL pr_state, nx_state : state;
  SIGNAL GOLFT            : STD_LOGIC_VECTOR(3 DOWNTO 0);  
  SIGNAL GOLRT            : STD_LOGIC_VECTOR(3 DOWNTO 0);  
  SIGNAL max_tick_s       : STD_LOGIC;
  SIGNAL max_tick_g_s     : STD_LOGIC;
  SIGNAL columns_s        : STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL rows_s           : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL scoreP1_s        : STD_LOGIC_VECTOR(6 DOWNTO 0);
  SIGNAL scoreP2_s        : STD_LOGIC_VECTOR(6 DOWNTO 0);
  SIGNAL binlft_s         : STD_LOGIC_VECTOR(3 DOWNTO 0);
  SIGNAL buffDisplay_s    : STD_LOGIC_VECTOR(127 DOWNTO 0) := (OTHERS => '1');
  SIGNAL NorRslt          : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL AndRslt          : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL NorRslt2         : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL AndRslt2         : STD_LOGIC_VECTOR(7 DOWNTO 0);

 
  
  
  
  
  BEGIN 
  
  MatrixScanSpeed : ENTITY work.Univ_Bin_Counter
                      PORT MAP( clk      => clk,
							           rst      => rst,
										  ena      => '1',
										  syn_clr  => '0',
										  load     => '0',
										  up       => '1',
										  d        =>"0000000000000000",
										  max_tick => max_tick_s);
										  
										  
   BallMovement : ENTITY work.Ball_ctrl_v2
                    PORT MAP( clk          => clk,
					               rst          => rst,
										GOL_LFT      => GOLFT, 
										GOL_RGT      => GOLRT, 
										NorIn        => NorRslt,
										NorIn2       => NorRslt2,
										ballDisplay  => buffDisplay_s(119 DOWNTO 8));
			
   RacketMovement : ENTITY work.Racket_ctrl
                      PORT MAP( clk           => clk,
							           rst           => rst,
									     b_up          => b_up,
										  b_down        => b_down,
										  racketDisplay => buffDisplay_s(7 DOWNTO 0)); 
												
	RacketMovement2 : ENTITY work.Racket_ctrl
                       PORT MAP( clk           => clk,
							            rst           => rst,
										   b_up          => b_up2,
											b_down        => b_down2,
											racketDisplay => buffDisplay_s(127 DOWNTO 120)); 
											
	GameOperation1 : ENTITY work.IntRackBllGl
	                  PORT MAP(PlayerN => buffDisplay_s(127 DOWNTO 112),
                              NorRslt => NorRslt,
		                        AndRslt => AndRslt);
										
	GameOperation2 : ENTITY work.IntRackBllGl
	                  PORT MAP(PlayerN => buffDisplay_s(15 DOWNTO 0),
                              NorRslt => NorRslt2,
		                        AndRslt => AndRslt2);
										
										
										
	ScoreP1 : ENTITY work.bin_to_sseg  
    PORT MAP(bin  => GOLFT,  
             sseg => ScoreP1_s,
				 rst => rst);

ScoreP2 : ENTITY work.bin_to_sseg  
    PORT MAP(bin  => GOLRT,  
             sseg => ScoreP2_s,
				 rst => rst);
	
										  
  c0  <= columns_s(0);
  c1  <= columns_s(1);
  c2  <= columns_s(2);
  c3  <= columns_s(3);
  c4  <= columns_s(4);
  c5  <= columns_s(5);
  c6  <= columns_s(6);
  c7  <= columns_s(7);
  c8  <= columns_s(8);
  c9  <= columns_s(9);
  c10 <= columns_s(10);
  c11 <= columns_s(11);
  c12 <= columns_s(12);
  c13 <= columns_s(13);
  c14 <= columns_s(14);
  c15 <= columns_s(15);
  
  f0 <= rows_s(0);
  f1 <= rows_s(1);
  f2 <= rows_s(2);
  f3 <= rows_s(3);
  f4 <= rows_s(4);
  f5 <= rows_s(5);
  f6 <= rows_s(6);
  f7 <= rows_s(7);
  
  sP10 <= scoreP1_s(0);
  sP11 <= scoreP1_s(1);
  sP12 <= scoreP1_s(2);
  sP13 <= scoreP1_s(3);
  sP14 <= scoreP1_s(4);
  sP15 <= scoreP1_s(5);
  sP16 <= scoreP1_s(6);
  
  sP20 <= scoreP2_s(0);
  sP21 <= scoreP2_s(1);
  sP22 <= scoreP2_s(2);
  sP23 <= scoreP2_s(3);
  sP24 <= scoreP2_s(4);
  sP25 <= scoreP2_s(5);
  sP26 <= scoreP2_s(6);

  
  ----------sequential section: -----------------
	 PROCESS (rst, clk)
	   BEGIN
	     IF (rst = '1')THEN
		    pr_state <= ena_c1;
		  ELSIF (rising_edge(clk))THEN 
		    pr_state <= nx_state;
			END IF;
	  END PROCESS;
	 ----------- combinational section: ------------
	PROCESS (pr_state, max_tick_s, buffDisplay_s)
     BEGIN 
	    CASE pr_state IS 
		 
		   WHEN ena_c0 => 
           columns_s <= "0000000000000001";
			  rows_s <= buffDisplay_s(7 DOWNTO 0);--"11100111"TEST#1;
			  IF(max_tick_s = '1')THEN
			    nx_state <= ena_c1;
			   ELSE 
			     nx_state <= ena_c0;
			  END IF;
				 
		   WHEN ena_c1 => 
           columns_s <= "0000000000000010";
			  rows_s <= buffDisplay_s(15 DOWNTO 8);--"11011011"TEST#1;
			  IF(max_tick_s = '1')THEN
			  nx_state <= ena_c2;
			    ELSE 
				   nx_state <= ena_c1;
				END IF;
			  
		   WHEN ena_c2 => 
           columns_s <= "0000000000000100";
			  rows_s <= buffDisplay_s(23 DOWNTO 16);--"10111101"TEST#1;
			  IF(max_tick_s = '1')THEN
			  nx_state <= ena_c3;
			    ELSE 
				   nx_state <= ena_c2;
				END IF;
					
		   WHEN ena_c3 => 
           columns_s <= "0000000000001000";
			  rows_s <= buffDisplay_s(31 DOWNTO 24);--"01111110"TEST#1;
			  IF(max_tick_s = '1')THEN
			  nx_state <= ena_c4;
			    ELSE 
				   nx_state <= ena_c3;
				END IF;
					
		   WHEN ena_c4 => 
           columns_s <= "0000000000010000";
			  rows_s <= buffDisplay_s(39 DOWNTO 32);--"10111101"TEST#1;
			  IF(max_tick_s = '1')THEN
			  nx_state <= ena_c5;
			    ELSE 
				   nx_state <= ena_c4;
				END IF;
					
		   WHEN ena_c5 => 
           columns_s <= "0000000000100000";
			  rows_s <= buffDisplay_s(47 DOWNTO 40);--"11011011"TEST#1;
			  IF(max_tick_s = '1')THEN
			  nx_state <= ena_c6;
			    ELSE 
				   nx_state <= ena_c5;
				END IF;
			  
		   WHEN ena_c6 => 
           columns_s <= "0000000001000000";
			  rows_s <= buffDisplay_s(55 DOWNTO 48);--"11100111"TEST#1;
			  IF(max_tick_s = '1')THEN
			  nx_state <= ena_c7;
			    ELSE 
				   nx_state <= ena_c6;
				END IF;
			  
		   WHEN ena_c7 => 
           columns_s <= "0000000010000000";
			  rows_s <= buffDisplay_s(63 DOWNTO 56);--"11100111"TEST#1;
			  IF(max_tick_s = '1')THEN
			  nx_state <= ena_c8;
			    ELSE 
				   nx_state <= ena_c7;
				END IF;
			  
			WHEN ena_c8 => 
           columns_s <= "0000000100000000";
			  rows_s <= buffDisplay_s(71 DOWNTO 64);--"11011011"TEST#1;
			  IF(max_tick_s = '1')THEN
			  nx_state <= ena_c9;
			    ELSE 
				   nx_state <= ena_c8;
				END IF;
			  
		   WHEN ena_c9 => 
           columns_s <= "0000001000000000";
			  rows_s <= buffDisplay_s(79 DOWNTO 72);--"10111101"TEST#1;
			  IF(max_tick_s = '1')THEN
			  nx_state <= ena_c10;
			    ELSE 
			      nx_state <= ena_c9;
				END IF;
			  
		   WHEN ena_c10 => 
           columns_s <= "0000010000000000";
			  rows_s <= buffDisplay_s(87 DOWNTO 80);--"01111110"TEST#1;
			  IF(max_tick_s = '1')THEN
			  nx_state <= ena_c11;
			    ELSE 
				   nx_state <= ena_c10;
				END IF;
			  
		   WHEN ena_c11 => 
           columns_s <= "0000100000000000";
			  rows_s <= buffDisplay_s(95 DOWNTO 88);--"10111101"TETS#1;
			  IF(max_tick_s = '1')THEN
			  nx_state <= ena_c12;
			    ELSE 
				  nx_state <= ena_c11;
				 END IF;
				  
		   WHEN ena_c12 => 
           columns_s <= "0001000000000000";
			  rows_s <= buffDisplay_s(103 DOWNTO 96);--"11011011"TEST#1;
			  IF(max_tick_s = '1')THEN
			  nx_state <= ena_c13;
			    ELSE 
				   nx_state <= ena_c12;
				END IF;
					
		   WHEN ena_c13 => 
           columns_s <= "0010000000000000";
			  rows_s <= buffDisplay_s(111 DOWNTO 104);--"11100111"TEST#1;
			  IF(max_tick_s = '1')THEN
			  nx_state <= ena_c14;
			    ELSE 
				   nx_state <= ena_c13;
				END IF;
					
		   WHEN ena_c14 => 
           columns_s <= "0100000000000000";
			  rows_s <= buffDisplay_s(119 DOWNTO 112);--"11100111"TEST#1;
			  IF(max_tick_s = '1')THEN
			  nx_state <= ena_c15;
			    ELSE 
				   nx_state <= ena_c14;
				END IF;
			  
		   WHEN ena_c15 => 
           columns_s <= "1000000000000000";
			  rows_s <= buffDisplay_s(127 DOWNTO 120);--"11011011"TEST#1;
			  IF(max_tick_s = '1')THEN
			  nx_state <= ena_c0;
			    ELSE 
				   nx_state <= ena_c15;
				END IF;
	    END CASE;
	  END PROCESS;
	END ARCHITECTURE fsm;
