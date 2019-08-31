*!* _zlibapigzsetparams 

lparameters gzfile, nlevel, strategy

declare long gzsetparams in zlib1.dll as _zlibapigzsetparams ;
	integer gzfile, ;
	integer nlevel, ;
	integer strategy

return _zlibapigzsetparams(m.gzfile, m.nlevel, m.strategy)