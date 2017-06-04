*!* _zlibcompressgzip

#Include _zlib1.h

#Define HEAP_ZERO_MEMORY	8

Lparameters pstring

Local avail_in, avail_out, memlevel, next_in, next_out, nlevel, nmethod, outstring, result
Local stream_size, strm, windowsbits, zlibversion

m.stream_size = 56

m.strm = _apiHeapAlloc(_apigetprocessheap(), HEAP_ZERO_MEMORY, m.stream_size)

*!*	00 next_in
*!*	04 avail_in
*!*	08 total_in
*!*	12 next_out
*!*	16 avail_out
*!*	20 total_out
*!*	24 msg
*!*	28 state
*!*	32 zalloc
*!*	36 zfree
*!*	40 opaque
*!*	44 data_type
*!*	48 adler
*!*	52 reserved

m.avail_in = Len(m.pstring)	&& number of bytes available at next_in

m.next_in = _apiHeapAlloc(_apigetprocessheap(), HEAP_ZERO_MEMORY, m.avail_in)	&& next input byte

Sys(2600, m.next_in, m.avail_in, m.pstring) && copy pstring to m.next_in

Sys(2600, m.strm, 4, BinToC(m.next_in, '4rs'))		&& next_in
Sys(2600, m.strm + 4, 4, BinToC(m.avail_in, '4rs'))		&& avail_in

m.avail_out = _zlibapideflatebound(m.strm, m.avail_in)

m.next_out = _apiHeapAlloc(_apigetprocessheap(), HEAP_ZERO_MEMORY, m.avail_out)

Sys(2600, m.strm + 12, 4, BinToC(m.next_out, '4rs'))		&& next_out
Sys(2600, m.strm + 16, 4, BinToC(m.avail_out, '4rs'))		&& avail_out

m.nlevel = Z_DEFAULT_COMPRESSION

m.nmethod = Z_DEFLATED

*!* Add 16 to windowBits to write a simple gzip header and trailer around the
*!* compressed data instead of a zlib wrapper

m.windowsbits = MAX_WBITS + 16

m.memlevel = MAX_MEM_LEVEL

m.strategy = Z_DEFAULT_STRATEGY

m.zlibversion = _zlibapizlibversion()

m.result = _zlibapideflateinit2(m.strm, m.nlevel, m.nmethod, m.windowsbits, m.memlevel, strategy, m.zlibversion, m.stream_size)

If m.result # Z_OK Then

	Error '_zlibapideflateinit2:' + Transform(m.result)

Endif

m.result = _zlibapideflate(m.strm, Z_FINISH)

If m.result # Z_STREAM_END Then

	Error '_zlibapdeflate:' + Transform(m.result)

Endif

m.result = _zlibapideflateend(m.strm)

If m.result # Z_OK Then

	Error '_zlibapideflateend:' + Transform(m.result)

Endif

m.total_out = CTOBIN(SYS(2600, m.strm + 20, 4), '4rs')

m.outstring = Sys(2600, m.next_out, m.total_out)

_apiHeapFree(_apigetprocessheap(), 0, m.strm)

_apiHeapFree(_apigetprocessheap(), 0, m.next_out)

_apiHeapFree(_apigetprocessheap(), 0, m.next_in)

Return m.outstring