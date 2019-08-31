*!* _zlibuncompress

#Include _zlib1.h

lparameters csource, ndestlen

local cdest, ndestlen, nresult, nsourcelen

m.nsourcelen = len(m.csource)

if m.nsourcelen = 0 then

	m.cdest = ''

else

	if vartype(m.ndestlen) # 'N' then

		m.ndestlen = m.nsourcelen * 2

	endif

	m.cdest = space(m.ndestlen)

	m.nresult = _zlibapiuncompress(@m.cdest, @m.ndestlen, m.csource, m.nsourcelen)

	do while m.nresult = Z_BUF_ERROR

		m.ndestlen = m.ndestlen * 2

		m.cdest = space(m.ndestlen)

		m.nresult = _zlibapiuncompress(@m.cdest, @m.ndestlen, m.csource, m.nsourcelen)

	enddo

	if m.nresult # Z_OK then

		error '_zlibapiuncompress: ' + transform(m.nresult)

	endif

	m.cdest = left(m.cdest, m.ndestlen)

endif

return m.cdest