*!* _zlibuncompress

#Include _zlib1.h

Lparameters csource, ndestlen

Local cdest, ndestlen, nresult, nsourcelen

m.nsourcelen = Len(m.csource)

If m.nsourcelen = 0 Then

	m.cdest = ''

Else

	If Vartype(m.ndestlen) # 'N' Then

		m.ndestlen = m.nsourcelen * 2

	Endif

	m.cdest = Space(m.ndestlen)

	m.nresult = _zlibapiuncompress(@m.cdest, @m.ndestlen, m.csource, m.nsourcelen)

	Do While m.nresult = Z_BUF_ERROR

		m.ndestlen = m.ndestlen * 2

		m.cdest = Space(m.ndestlen)

		m.nresult = _zlibapiuncompress(@m.cdest, @m.ndestlen, m.csource, m.nsourcelen)

	Enddo

	If m.nresult # Z_OK Then

		Error '_zlibapiuncompress: ' + Transform(m.nresult)

	Endif

	m.cdest = Left(m.cdest, m.ndestlen)

Endif

Return m.cdest