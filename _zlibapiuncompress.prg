*!* _zlibapiuncompress

*!*	Decompresses the source buffer into the destination buffer.  sourceLen is
*!*	the byte length of the source buffer.  Upon entry, destLen is the total size
*!*	of the destination buffer, which must be large enough to hold the entire
*!*	uncompressed data.  (The size of the uncompressed data must have been saved
*!*	previously by the compressor and transmitted to the decompressor by some
*!*	mechanism outside the scope of this compression library.) Upon exit, destLen
*!*	is the actual size of the uncompressed buffer.

*!*	uncompress returns Z_OK if success, Z_MEM_ERROR if there was not
*!*	enough memory, Z_BUF_ERROR if there was not enough room in the output
*!*	buffer, or Z_DATA_ERROR if the input data was corrupted or incomplete.  In
*!*	the case where there is not enough room, uncompress() will fill the output
*!*	buffer with the uncompressed data up to that point.

lparameters dest, destlen, source, sourcelen

declare integer uncompress in zlib1.dll as _zlibapiuncompress ;
	string  @dest, ;
	integer @destlen, ;
	string  source, ;
	integer sourcelen

return _zlibapiuncompress(@m.dest, @m.destlen, m.source, m.sourcelen)