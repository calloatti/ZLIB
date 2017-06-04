*!* _zlibcompress

#Include _zlib1.h

Lparameters csource

Local cdest, ndestlen, nresult, nsourcelen

m.nsourcelen = Len(m.csource)

If m.nsourcelen = 0 Then

	m.cdest = ''

Else

	m.ndestlen = _zlibapicompressbound(m.nsourcelen)

	m.cdest = Space(m.ndestlen)

	m.nresult = _zlibapicompress(@m.cdest, @m.ndestlen, m.csource, m.nsourcelen)

	Do While m.nresult = Z_BUF_ERROR
	
		m.ndestlen = m.ndestlen * 2

		m.cdest = Space(m.ndestlen)

		m.nresult = _zlibapicompress(@m.cdest, @m.ndestlen, m.csource, m.nsourcelen)

	Enddo

	If m.nresult # Z_OK Then

		Error '_zlibapicompress: ' + Transform(m.nresult)

	Endif

	m.cdest = Left(m.cdest, m.ndestlen)

Endif

Return m.cdest