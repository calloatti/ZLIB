*!* _apiPathMatchSpecEx

*!*	pszFile [in]

*!*	A pointer to a null-terminated string of maximum length MAX_PATH that contains 
*!*	the path from which the file name to be matched is taken.

*!*	pszSpec [in]

*!*	A pointer to a null-terminated string of maximum length MAX_PATH that contains 
*!*	the file name pattern for which to search. This can be the exact name, or it can 
*!*	contain wildcard characters. If exactly one pattern is specified, set the PMSF_NORMAL 
*!*	flag in dwFlags. If more than one pattern is specified, separate them with semicolons 
*!*	and set the PMSF_MULTIPLE flag.

*!*	dwFlags [in]

*!*	Modifies the search condition. The following are valid flags.

*!*	PMSF_NORMAL (0x00000000)
*!*	The pszSpec parameter points to a single file name pattern to be matched.

*!*	PMSF_MULTIPLE (0x00000001)
*!*	The pszSpec parameter points to a semicolon-delimited list of file name patterns to be matched.

*!*	PMSF_DONT_STRIP_SPACES (0x00010000)
*!*	If PMSF_NORMAL is used, ignore leading spaces in the string pointed to by pszSpec. 
*!*	If PMSF_MULTIPLE is used, ignore leading spaces in each file type contained in the 
*!*	string pointed to by pszSpec. This flag can be combined with PMSF_NORMAL and PMSF_MULTIPLE.

*!*	Return value

*!*	Type: HRESULT
*!*	Returns one of the following values.

*!*	S_OK
*!*	A file name pattern specified in pszSpec matched the file name found in the string pointed to by pszFile.

*!*	S_FALSE
*!*	No file name pattern specified in pszSpec matched the file name found in the string pointed to by pszFile.

*!* YES, RETURNS 0 FOR A MATCH AND 1 FOR NO MATCH

#Define PMSF_NORMAL				0x00000000
#Define PMSF_MULTIPLE			0x00000001
#Define PMSF_DONT_STRIP_SPACES	0x00010000
#Define S_OK					0
#Define S_FALSE					1

Lparameters pszFile, pszSpec, dwFlags

Declare Integer PathMatchSpecEx In SHLWAPI.Dll As _apiPathMatchSpecEx ;
	String  pszFile, ;
	String  pszSpec, ;
	Integer dwFlags

Return _apiPathMatchSpecEx(m.pszFile, m.pszSpec, m.dwFlags)