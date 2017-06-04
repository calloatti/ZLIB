*!* _zlibapicompress2

*!* Compresses the source buffer into the destination buffer.  The level
*!*	parameter has the same meaning as in deflateInit.  sourceLen is the byte
*!*	length of the source buffer.  Upon entry, destLen is the total size of the
*!*	destination buffer, which must be at least the value returned by
*!*	compressBound(sourceLen).  Upon exit, destLen is the actual size of the
*!*	compressed buffer.

*!* The compression level must be Z_DEFAULT_COMPRESSION, or between 0 and 9:
*!*	1 gives best speed, 9 gives best compression, 0 gives no compression at all
*!*	(the input data is simply copied a block at a time).  Z_DEFAULT_COMPRESSION
*!*	requests a default compromise between speed and compression (currently
*!*	equivalent to level 6)

*!*	compress2 returns Z_OK if success, Z_MEM_ERROR if there was not enough
*!*	memory, Z_BUF_ERROR if there was not enough room in the output buffer,
*!*	Z_STREAM_ERROR if the level parameter is invalid.

Lparameters Dest, destlen, Source, sourcelen, nlevel

*#beautify keyword_nochange

Declare Integer compress2 In ZLIB1.Dll As _zlibapicompress2 ;
	String  @Dest, ;
	Integer @destlen, ;
	String  Source, ;
	Integer sourcelen, ;
	Integer nlevel

*#beautify

Return _zlibapicompress2(@m.dest, @m.destlen, m.source, m.sourcelen, m.nlevel)
