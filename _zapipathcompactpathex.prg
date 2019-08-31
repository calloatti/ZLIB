*!* _zapipathcompactpathex

lparameters pszOut, pszSrc, cchMax, dwFlags

declare integer PathCompactPathEx in SHLWAPI.dll as _zapipathcompactpathex ;
	string  @pszOut, ;
	string  pszSrc, ;
	integer cchMax, ;
	integer dwFlags

return _zapipathcompactpathex(@m.pszOut, m.pszSrc, m.cchMax, m.dwFlags)