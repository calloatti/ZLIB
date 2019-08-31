*!* _zlibzipreadlfh

*!* pbytes: the local file header + compressed data

lparameters pbytes

local olfh as 'empty'
local npos

m.olfh = createobject('empty')

addproperty(m.olfh, 'zzsignature', '')
addproperty(m.olfh, 'zzversiontoextract', 0)
addproperty(m.olfh, 'zzbitflags', 0)
addproperty(m.olfh, 'zzmethod', 0)
addproperty(m.olfh, 'zzfiletime', '')
addproperty(m.olfh, 'zzfiledate', '')
addproperty(m.olfh, 'zzcrc32', 0)
addproperty(m.olfh, 'zzcompressedsize', 0)
addproperty(m.olfh, 'zzuncompressedsize', 0)
addproperty(m.olfh, 'zzfilenamelen', 0)
addproperty(m.olfh, 'zzextrafieldlen', 0)
addproperty(m.olfh, 'zzfilename', '')
addproperty(m.olfh, 'zzextrafield', '')
addproperty(m.olfh, 'zzoffset', 0)

*!*	local file header signature     4 bytes 00  (0x04034b50)
*!*	version needed to extract       2 bytes 04 
*!*	general purpose bit flag        2 bytes 06
*!*	compression method              2 bytes 08
*!*	last mod file time              2 bytes 10
*!*	last mod file date              2 bytes 12
*!*	crc-32                          4 bytes 14
*!*	compressed size                 4 bytes 18
*!*	uncompressed size               4 bytes 22
*!*	file name length                2 bytes 26
*!*	extra field length              2 bytes 28
*!*	file name (variable size)               30
*!*	extra field (variable size)

m.npos = 1

m.olfh.zzsignature		  = 0h + substr(m.pbytes, m.npos + 0, 4)
m.olfh.zzversiontoextract = _zuctobin(substr(m.pbytes, m.npos + 4, 2))
m.olfh.zzbitflags		  = _zuctobin(substr(m.pbytes, m.npos + 6, 2))
m.olfh.zzmethod			  = _zuctobin(substr(m.pbytes, m.npos + 8, 2))
m.olfh.zzfiletime		  = 0h + substr(m.pbytes, m.npos + 10, 2)
m.olfh.zzfiledate		  = 0h + substr(m.pbytes, m.npos + 12, 2)
m.olfh.zzcrc32			  = _zuctobin(substr(m.pbytes, m.npos + 14, 4))
m.olfh.zzcompressedsize	  = _zuctobin(substr(m.pbytes, m.npos + 18, 4))
m.olfh.zzuncompressedsize = _zuctobin(substr(m.pbytes, m.npos + 22, 4))
m.olfh.zzfilenamelen	  = _zuctobin(substr(m.pbytes, m.npos + 26, 2))
m.olfh.zzextrafieldlen	  = _zuctobin(substr(m.pbytes, m.npos + 28, 2))
m.olfh.zzfilename		  = substr(m.pbytes, m.npos + 30, m.olfh.zzfilenamelen)
m.olfh.zzextrafield		  = 0h + substr(m.pbytes, m.npos + 30 + m.olfh.zzfilenamelen, m.olfh.zzextrafieldlen)
m.olfh.zzoffset			  = 30 + m.olfh.zzfilenamelen + m.olfh.zzextrafieldlen


*!* IF Bittest(m.olfh.zzbitflags, 3) = .t.

*!* zzcrc32, zzcompressedsize and zzuncompressedsize will be 0

*!* use data from cdr

*!* Data descriptor

*!* This descriptor MUST exist if bit 3 of the general
*!* purpose bit flag is set (see below).  It is byte aligned
*!* and immediately follows the last byte of compressed data.

*!*	crc-32                          4 bytes
*!*	compressed size                 4 bytes
*!*	uncompressed size               4 bytes

return m.olfh