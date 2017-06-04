Lparameters gzfile, nlevel, strategy

Declare Long gzsetparams In zlib1.Dll As _zlibgzsetparams   ;
	Integer gzfile, ;
	Integer nlevel, ;
	Integer strategy

Return _zlibgzsetparams(m.gzfile, m.nlevel, m.strategy)
