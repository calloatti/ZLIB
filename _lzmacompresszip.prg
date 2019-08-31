*!* _lzmacompresszip

#define LZMA_PROPS_SIZE	5

#define SZ_OK 0
 
#define SZ_ERROR_DATA 1
#define SZ_ERROR_MEM 2
#define SZ_ERROR_CRC 3
#define SZ_ERROR_UNSUPPORTED 4
#define SZ_ERROR_PARAM 5
#define SZ_ERROR_INPUT_EOF 6
#define SZ_ERROR_OUTPUT_EOF 7
#define SZ_ERROR_READ 8
#define SZ_ERROR_WRITE 9
#define SZ_ERROR_PROGRESS 10
#define SZ_ERROR_FAIL 11
#define SZ_ERROR_THREAD 12

#define SZ_ERROR_ARCHIVE 16
#define SZ_ERROR_NO_ARCHIVE 17

lparameters psrc

Local dest, destlen, dictsize, fb, ilevel, lc, lp, numthreads, outprops, outpropssize, pb, result
Local srclen

m.srclen = len(m.psrc)

m.destlen = int(m.srclen + m.srclen/40) + 4096

m.dest = replicate(0h00, m.destlen)

m.outprops = replicate(0h00, LZMA_PROPS_SIZE)

m.outpropssize = LZMA_PROPS_SIZE

m.ilevel	 = -1
m.dictsize	 = 0
m.lc		 = -1
m.lp		 = -1
m.pb		 = -1
m.fb		 = -1
m.numthreads = -1

m.result = _lzmaapicompress(@m.dest, @m.destlen, m.psrc, m.srclen, @m.outprops, @m.outpropssize, m.ilevel, m.dictsize, m.lc, m.lp, m.pb, m.fb, m.numthreads)

if m.result # SZ_OK

	error '_ZAPILZMACOMPRESS'

endif

*!*	[LZMA properties header for file 1]

*!*	LZMA Version Information 2 bytes
*!*	LZMA Properties Size 2 bytes
*!*	LZMA Properties Data variable, defined by "LZMA Properties Size"

*!*	[LZMA compressed data for file 1]

return 0h1300 + 0h0500 + m.outprops + left(m.dest, m.destlen) 