Lparameters zfile, zmode

Declare Long gzopen In zlib1.Dll As _zlibapigzopen  ;
	String  zfile, ;
	String  zmode

Return _zlibapigzopen(m.zfile, m.zmode)
