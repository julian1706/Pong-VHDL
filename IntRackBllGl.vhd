LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
--------------------------------

ENTITY IntRackBllGl IS
  PORT(PlayerN : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
       NorRslt : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		 AndRslt : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END ENTITY;
--------------------------------

ARCHITECTURE GateLevel OF IntRackBllGl IS 
  
  SIGNAL BallVect_s   : STD_LOGIC_VECTOR(7 DOWNTO 0) := PlayerN(15 DOWNTO 8); 
  SIGNAL RackVect_s   : STD_LOGIC_VECTOR(7 DOWNTO 0) := PlayerN(7 DOWNTO 0);
  SIGNAL NorRsltVect_s : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL AndRsltVect_s : STD_LOGIC_VECTOR(7 DOWNTO 0);
  

  BEGIN
    
	 NorRsltVect_s(0) <=(RackVect_s(0) NOR BallVect_s(0));
	 NorRsltVect_s(1) <=(RackVect_s(1) NOR BallVect_s(1));
	 NorRsltVect_s(2) <=(RackVect_s(2) NOR BallVect_s(2));
	 NorRsltVect_s(3) <=(RackVect_s(3) NOR BallVect_s(3));
	 NorRsltVect_s(4) <=(RackVect_s(4) NOR BallVect_s(4));
	 NorRsltVect_s(5) <=(RackVect_s(5) NOR BallVect_s(5));
	 NorRsltVect_s(6) <=(RackVect_s(6) NOR BallVect_s(6));
	 NorRsltVect_s(7) <=(RackVect_s(7) NOR BallVect_s(7));

	 AndRsltVect_s(0) <=(RackVect_s(0) AND BallVect_s(0));
	 AndRsltVect_s(1) <=(RackVect_s(1) AND BallVect_s(1));
	 AndRsltVect_s(2) <=(RackVect_s(2) AND BallVect_s(2));
	 AndRsltVect_s(3) <=(RackVect_s(3) AND BallVect_s(3));
	 AndRsltVect_s(4) <=(RackVect_s(4) AND BallVect_s(4));
	 AndRsltVect_s(5) <=(RackVect_s(5) AND BallVect_s(5));
	 AndRsltVect_s(6) <=(RackVect_s(6) AND BallVect_s(6));
	 AndRsltVect_s(7) <=(RackVect_s(7) AND BallVect_s(7));
    	 
	NorRslt <= NorRsltVect_s;
	AndRslt <= AndRsltVect_s;
	
	
	
END ARCHITECTURE;
  