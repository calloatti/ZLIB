Lparameters gzfile, cbuf, nlen

Declare Long gzread In zlib1.Dll As _zlibapigzread ;
	Integer gzfile, ;
	String  @cbuf, ;
	Integer nlen

Return _zlibapigzread(m.gzfile, @m.cbuf, m.nlen)
