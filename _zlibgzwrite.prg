Lparameters gzfile, cbuf, nlen

Declare Long gzwrite In zlib1.Dll As _zlibgzwrite   ;
	Integer gzfile, ;
	String  cbuf, ;
	Integer nlen

Return _zlibgzwrite(m.gzfile, m.cbuf, m.nlen)
