lparameters zfile, zmode

declare long gzopen in zlib1.dll as _zlibapigzopen  ;
	string  zfile, ;
	string  zmode

return _zlibapigzopen(m.zfile, m.zmode)