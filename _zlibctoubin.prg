*!* _zlibctoubin

*!* Converts a binary character representation to an unsigned numeric value

Lparameters pbytes

Local res

m.res = CToBin(m.pbytes, Transform(Len(m.pbytes)) + 'rs')

If m.res < 0 Then

	m.res =  m.res + 2^(Len(m.pbytes) * 8)

	m.res = Int(m.res)

Endif

Return m.res
