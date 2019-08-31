*!* _zlibapiinflate

lparameters strm, flush

declare integer inflate in zlib1.dll as _zlibapiinflate ;
	integer strm, ;
	integer flush

return _zlibapiinflate(m.strm, m.flush)