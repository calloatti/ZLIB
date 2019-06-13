*!* _zlibcrc32

Lparameters pbytes

Local crc32

m.crc32 = _zlibapicrc32(0, m.pbytes, Len(m.pbytes))

If m.crc32 < 0 Then

	m.crc32 = m.crc32 + 4294967296

Endif

Return m.crc32