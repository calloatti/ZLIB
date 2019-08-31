lparameters gzfile, cbuf, nlen

declare long gzread in zlib1.dll as _zlibapigzread ;
	integer gzfile, ;
	string  @cbuf, ;
	integer nlen

return _zlibapigzread(m.gzfile, @m.cbuf, m.nlen)