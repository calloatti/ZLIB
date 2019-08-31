*!* _lzmaapiuncompress

lparameters dest, destlen, src, srclen, props, propssize

declare integer LzmaUncompress@24 in LZMA.dll as _lzmaapiuncompress ;
	string  @dest, ;
	integer @destLen, ;
	string  src, ;
	integer @srclen, ;
	string  props, ;
	integer propssize
	
	
return _lzmaapiuncompress(@dest, @destlen, src, @srclen, props, propssize)