*!* _lzmaapicompress

lparameters dest, destlen, src, srclen, outprops, outpropssize, ilevel, dictsize, lc, lp, pb, fb, numthreads

declare integer LzmaCompress@52 in LZMA.dll as _lzmaapicompress;
	string  @dest, ;
	integer @destlen, ;
	string  src, ;
	integer srclen, ;
	string  @outprops, ;
	integer @outpropssize, ;
	integer ilevel, ;
	integer dictsize, ;
	integer lc, ;
	integer lp, ;
	integer pb, ;
	integer fb, ;
	integer numthreads

return _lzmaapicompress(@m.dest, @m.destlen, m.src, m.srclen, @m.outprops, @m.outpropssize, m.ilevel, m.dictsize, m.lc, m.lp, m.pb, m.fb, m.numthreads)


