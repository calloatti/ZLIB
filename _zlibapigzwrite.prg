*!* _zlibapigzwrite

Lparameters gzfile, cbuf, nlen

Declare Long gzwrite In zlib1.Dll As _zlibapigzwrite   ;
	Integer gzfile, ;
	String  cbuf, ;
	Integer nlen

Return _zlibapigzwrite(m.gzfile, m.cbuf, m.nlen)
