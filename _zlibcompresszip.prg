*!* _zlibcompresszip

#Include _zlib1.h

#define HEAP_ZERO_MEMORY	8

lparameters pstring

local avail_in, avail_out, heap, memlevel, next_in, next_out, nlevel, nmethod, outstring, result
local strategy, stream_size, strm, total_out, windowsbits, zlibversion

if empty(m.pstring) then

	return ''

endif

m.heap = _zapigetprocessheap()

m.stream_size = 56

m.strm = _zapiheapalloc(m.heap, HEAP_ZERO_MEMORY, m.stream_size)

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

m.avail_in = len(m.pstring)	&& number of bytes available at next_in

m.next_in = _zapiheapalloc(m.heap, HEAP_ZERO_MEMORY, m.avail_in)	&& next input byte

sys(2600, m.next_in, m.avail_in, m.pstring) && copy pstring to m.next_in

sys(2600, m.strm, 4, bintoc(m.next_in, '4rs'))		&& next_in
sys(2600, m.strm + 4, 4, bintoc(m.avail_in, '4rs'))		&& avail_in

m.avail_out = _zlibapideflatebound(m.strm, m.avail_in) + 128		&& add 128 bytes just in case, for short strings

m.next_out = _zapiheapalloc(m.heap, HEAP_ZERO_MEMORY, m.avail_out)

sys(2600, m.strm + 12, 4, bintoc(m.next_out, '4rs'))		&& next_out
sys(2600, m.strm + 16, 4, bintoc(m.avail_out, '4rs'))		&& avail_out

m.nlevel = Z_DEFAULT_COMPRESSION

m.nmethod = Z_DEFLATED

*!* Add 16 to windowBits to write a simple gzip header and trailer around the
*!* compressed data instead of a zlib wrapper

m.windowsbits = MAX_WBITS * (-1)

m.memlevel = MAX_MEM_LEVEL

m.strategy = Z_DEFAULT_STRATEGY

m.zlibversion = _zlibapizlibversion()

m.result = _zlibapideflateinit2(m.strm, m.nlevel, m.nmethod, m.windowsbits, m.memlevel, m.strategy, m.zlibversion, m.stream_size)

if m.result # Z_OK then

	error '_zlibapideflateinit2:' + transform(m.result)

endif

m.result = _zlibapideflate(m.strm, Z_FINISH)

if m.result # Z_STREAM_END then

	error '_zlibapdeflate:' + transform(m.result)

endif

m.result = _zlibapideflateend(m.strm)

if m.result # Z_OK then

	error '_zlibapideflateend:' + transform(m.result)

endif

m.total_out = ctobin(sys(2600, m.strm + 20, 4), '4rs')

m.outstring = sys(2600, m.next_out, m.total_out)

_zapiheapfree(m.heap, 0, m.strm)

_zapiheapfree(m.heap, 0, m.next_out)

_zapiheapfree(m.heap, 0, m.next_in)

return m.outstring