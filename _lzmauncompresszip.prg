*!* _lzmauncompresszip

#define SZ_OK 0

lparameters psrc, pdestlen

m.dest		= replicate(0h00, m.pdestlen)
m.destlen	= m.pdestlen
m.src		= substr(m.psrc, 10)
m.srclen	= len(m.src )
m.props		= substr(m.psrc, 5, 5)
m.propssize	= 5

m.result = _lzmaapiuncompress(@m.dest, @m.destlen, m.src, @m.srclen, m.props, m.propssize)

if m.result # SZ_OK

	error '_LZMAAPIUNCOMPRESS'

endif

return left(m.dest, m.destlen)