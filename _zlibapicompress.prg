*!* _zlibapicompress

*!*	Compresses the source buffer into the destination buffer.  
*!*	sourceLen is the byte length of the source buffer.  
*!*	Upon entry, destLen is the total size of the destination buffer, 
*!*	which must be at least the value returned by compressBound(sourceLen).  
*!*	Upon exit, destLen is the actual size of the compressed buffer.

LPARAMETERS dest, destlen, source, sourcelen

Declare Integer compress In ZLIB1.Dll As _zlibapicompress ;
	String  @dest, ;
	Integer @destlen, ;
	String  source, ;
	integer sourcelen

Return _zlibapicompress(@m.dest, @m.destlen, m.source, m.sourcelen)
