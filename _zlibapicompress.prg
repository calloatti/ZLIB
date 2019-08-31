*!* _zlibapicompress

*!*	Compresses the source buffer into the destination buffer.  
*!*	sourceLen is the byte length of the source buffer.  
*!*	Upon entry, destLen is the total size of the destination buffer, 
*!*	which must be at least the value returned by compressBound(sourceLen).  
*!*	Upon exit, destLen is the actual size of the compressed buffer.

lparameters dest, destlen, source, sourcelen

declare integer compress in zlib1.dll as _zlibapicompress ;
	string  @dest, ;
	integer @destlen, ;
	string  source, ;
	integer sourcelen

return _zlibapicompress(@m.dest, @m.destlen, m.source, m.sourcelen)
