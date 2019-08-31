*!* _zlibapideflatebound

*!*	deflateBound() returns an upper bound on the compressed size after
*!*	deflation of sourceLen bytes.  It must be called after deflateInit() or
*!*	deflateInit2(), and after deflateSetHeader(), if used.  This would be used
*!*	to allocate an output buffer for deflation in a single pass, and so would be
*!*	called before deflate().  If that first deflate() call is provided the
*!*	sourceLen input bytes, an output buffer allocated to the size returned by
*!*	deflateBound(), and the flush value Z_FINISH, then deflate() is guaranteed
*!*	to return Z_STREAM_END.  Note that it is possible for the compressed size to
*!*	be larger than the value returned by deflateBound() if flush options other
*!*	than Z_FINISH or Z_NO_FLUSH are used.

lparameters strm, sourcelen

declare integer deflateBound in zlib1.dll as _zlibapideflatebound ;
	integer strm, ;
	integer sourcelen

return _zlibapideflatebound (m.strm, m.sourcelen)
