*!* _zlibzipreadeocdr

*!* PARAMETERS

*!* pbytes: string that contains the [end of central directory record]

*!* Usually read x bytes from the end of zip file (maybe 2kb)

*!* The exact size is unknown since the last entry in a EOCDR is the file
*!* comment, that can technically be as as large as 65535 bytes

*!* If the EOCDR signature cannot be found in pbytes, the object returned
*!* will have the property zzfound set to 0, in that case a larger string
*!* from the end of the file should be passed.

*!* Reads [end of central directory record]

*!* The parameter passed to this function is a string that represents the contents
*!* of a zip file, or the partial contents of a zip file.
*!* Since the [end of central directory record] is located at the end of the file,
*!* the partial content should be from the end of the file and large enough to contain
*!* the 'end of central dir signature' bytes.
*!* The zip file comment is the last member of [end of central directory record] 
*!* and since it has an unknown length, a size large enough to contain the whole 
*!* [end of central directory record] should be used. Maybe 2-4KB bytes to be safe.

*!* The purpose of this function is to help download a specific file from a zip file located
*!* on a web server that supports ranges.

*!*	Overall .ZIP file format:

*!* [local file header 1]
*!* [encryption header 1]
*!* [file data 1]
*!* [data descriptor 1]
*!* . 
*!* .
*!* .
*!* [local file header n]
*!* [encryption header n]
*!* [file data n]
*!* [data descriptor n]
*!* [archive decryption header] 
*!* [archive extra data record] 
*!* [central directory header 1]
*!* .
*!* .
*!* .
*!* [central directory header n]
*!* [zip64 end of central directory record]
*!* [zip64 end of central directory locator] 
*!* [end of central directory record]

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

lparameters pbytes

local oecdr as 'empty'
local npos

m.oecdr = createobject('empty')

addproperty(m.oecdr, 'zzfound', 0)
addproperty(m.oecdr, 'zzdisknumber', 0)
addproperty(m.oecdr, 'zzdisknumbercd', 0)
addproperty(m.oecdr, 'zzcountdisk', 0)
addproperty(m.oecdr, 'zzcount', 0)
addproperty(m.oecdr, 'zzsize', 0)
addproperty(m.oecdr, 'zzoffset', 0)
addproperty(m.oecdr, 'zzcommentlen', 0)
addproperty(m.oecdr, 'zzcomment', '')

if vartype(m.pbytes) $ 'CQ'

	m.npos = rat(0h504b0506, m.pbytes, 1)

	if m.npos > 0 then

		m.oecdr.zzfound = 1

		m.oecdr.zzdisknumber   = _zuctobin(substr(m.pbytes, m.npos + 4, 2))
		m.oecdr.zzdisknumbercd = _zuctobin(substr(m.pbytes, m.npos + 6, 2))
		m.oecdr.zzcountdisk	   = _zuctobin(substr(m.pbytes, m.npos + 8, 2))
		m.oecdr.zzcount		   = _zuctobin(substr(m.pbytes, m.npos + 10, 2))
		m.oecdr.zzsize		   = _zuctobin(substr(m.pbytes, m.npos + 12, 4))
		m.oecdr.zzoffset	   = _zuctobin(substr(m.pbytes, m.npos + 16, 4))
		m.oecdr.zzcommentlen   = _zuctobin(substr(m.pbytes, m.npos + 20, 2))

		if m.oecdr.zzcommentlen > 0
			m.oecdr.zzcomment	   = substr(m.pbytes, m.npos + 22, m.oecdr.zzcommentlen)
		endif

	endif

endif

return m.oecdr