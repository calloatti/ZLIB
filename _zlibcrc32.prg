*!* _zlibcrc32

lparameters pbytes

local crc32

m.crc32 = _zlibapicrc32(0, m.pbytes, len(m.pbytes))

if m.crc32 < 0 then

	m.crc32 = m.crc32 + 2^32

endif

return m.crc32