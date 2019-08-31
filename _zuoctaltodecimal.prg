*!* _zuoctaltodecimal

Lparameters poctal

Local base, result

m.result = 0

m.base = 1

Do While m.poctal > 0

	m.result = m.result + (m.poctal % 10) * m.base

	m.base = m.base * 8

	m.poctal = Int(m.poctal / 10)

Enddo

Return m.result 