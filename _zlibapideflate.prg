*!* _zlibapideflate

lparameters strm, flush

declare integer deflate in zlib1.dll as _zlibapideflate ;
	integer strm, ;
	integer flush

return _zlibapideflate(m.strm, m.flush)