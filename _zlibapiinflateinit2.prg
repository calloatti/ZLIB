*!* _zlibapiinflateinit2

lparameters strm, windowsbits, zlibversion, stream_size

declare integer inflateInit2_ in zlib1.dll as _zlibapiinflateinit2 ;
	integer strm, ;
	integer windowsbits, ;
	string  zlibversion, ;
	integer stream_size

return _zlibapiinflateinit2(m.strm, m.windowsbits, m.zlibversion, m.stream_size)