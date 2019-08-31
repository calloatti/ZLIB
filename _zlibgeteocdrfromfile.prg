*!* _zlibgeteocdrfromfile

#define LOCAL_FILE_HEADER_SIGNATURE   0h504b0304
#define CENTRAL_FILE_HEADER_SIGNATURE 0h504b0102
#define DIGITAL_SIGNATURE             0h504b0505
#define ZIP64_EOCD_SIGNATURE          0h504b0606
#define ZIP64_EOCD_LOCATOR_SIGNATURE  0h504b0607
#define EOCD_SIGNATURE                0h504b0506
#define DATA_DESCRIPTOR_SIGNATURE     0h504b0708

lparameters pfile

*!* End of central directory record

*!*	end of central dir signature                                                   4 bytes  (0x06054b50)
*!*	number of this disk                                                            2 bytes
*!*	number of the disk with the start of the central directory                     2 bytes
*!*	total number of entries in the central directory on this disk                  2 bytes
*!*	total number of entries in the central directory                               2 bytes
*!*	size of the central directory                                                  4 bytes
*!*	offset of start of central directory with respect to the starting disk number  4 bytes
*!*	.ZIP file comment length                                                       2 bytes
*!*	.ZIP file comment                                                              (variable size)

local oecdr as 'empty'
local bytes, hfile, npos

m.oecdr = createobject('empty')

addproperty(m.oecdr, 'zzsignature', '')
addproperty(m.oecdr, 'zzfound', 0)
addproperty(m.oecdr, 'zzdisknumber', 0)
addproperty(m.oecdr, 'zzdisknumbercd', 0)
addproperty(m.oecdr, 'zzcountdisk', 0)
addproperty(m.oecdr, 'zzcount', 0)
addproperty(m.oecdr, 'zzsize', 0)
addproperty(m.oecdr, 'zzoffset', 0)
addproperty(m.oecdr, 'zzcommentlen', 0)
addproperty(m.oecdr, 'zzcomment', '')
addproperty(m.oecdr, 'zzbytes', 0h)

m.hfile = fopen(m.pfile, 0)

if m.hfile > 0

	fseek(m.hfile, -8192, 2)

	m.bytes = fread(m.hfile, 8192)

	fclose(m.hfile)

	m.npos = rat(EOCD_SIGNATURE, m.bytes, 1)

	if m.npos > 0 then

		m.oecdr.zzsignature	   = 0h + substr(m.bytes, m.npos, 4)
		m.oecdr.zzfound		   = 1
		m.oecdr.zzdisknumber   = _zuctobin(substr(m.bytes, m.npos + 4, 2))
		m.oecdr.zzdisknumbercd = _zuctobin(substr(m.bytes, m.npos + 6, 2))
		m.oecdr.zzcountdisk	   = _zuctobin(substr(m.bytes, m.npos + 8, 2))
		m.oecdr.zzcount		   = _zuctobin(substr(m.bytes, m.npos + 10, 2))
		m.oecdr.zzsize		   = _zuctobin(substr(m.bytes, m.npos + 12, 4))
		m.oecdr.zzoffset	   = _zuctobin(substr(m.bytes, m.npos + 16, 4))
		m.oecdr.zzcommentlen   = _zuctobin(substr(m.bytes, m.npos + 20, 2))

		if m.oecdr.zzcommentlen > 0

			m.oecdr.zzcomment = substr(m.bytes, m.npos + 22, m.oecdr.zzcommentlen)

		endif

		m.oecdr.zzbytes = 0h + substr(m.bytes, m.npos, 22 + m.oecdr.zzcommentlen)

	endif

endif

return m.oecdr