*!* _zlibapicompressbound

*!* compressBound() returns an upper bound on the compressed size after   
*!*	compress() or compress2() on sourceLen bytes.  It would be used before a   
*!*	compress() or compress2() call to allocate the destination buffer.

Lparameters sourcelen

Declare Integer compressBound In ZLIB1.Dll As _zlibapicompressbound ;
	Integer sourcelen

Return _zlibapicompressbound(m.sourcelen)
