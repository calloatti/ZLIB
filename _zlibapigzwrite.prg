*!* _zlibapigzwrite

lparameters gzfile, cbuf, nlen

declare long gzwrite in zlib1.dll as _zlibapigzwrite   ;
	integer gzfile, ;
	string  cbuf, ;
	integer nlen

return _zlibapigzwrite(m.gzfile, m.cbuf, m.nlen)