*!* _zushortenpath

lparameters pszSrc, cchMax

local dwFlags, pszOut, result

m.pszOut = replicate(0h00, m.cchMax + 1)

m.dwFlags = 0

m.result = _zapipathcompactpathex(@m.pszOut, m.pszSrc, m.cchMax + 1, m.dwFlags)

m.pszOut = padr(rtrim(m.pszOut, 1, 0h00), m.cchMax)

return m.pszOut