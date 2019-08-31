lparameters gzfile

declare long gzclose in zlib1.dll as _zlibapigzclose   ;
	integer gzfile

return _zlibapigzclose(m.gzfile)