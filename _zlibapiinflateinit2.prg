*!* _zlibapiinflateinit2

Lparameters strm, windowsbits, zlibversion, stream_size

Declare Integer inflateInit2_ In ZLIB1.Dll As _zlibapiinflateinit2 ;
	Integer strm, ;
	Integer windowsbits, ;
	String  zlibversion, ;
	Integer stream_size

Return _zlibapiinflateinit2(m.strm, m.windowsbits, m.zlibversion, m.stream_size)