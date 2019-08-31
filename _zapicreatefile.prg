*!* _zapicreatefile

lparameters lpFileName, dwDesiredAccess, dwShareMode, lpSecurityAttributes, dwCreationDisposition, dwFlagsAndAttributes, hTemplateFile

declare integer CreateFile in win32api as _zapicreatefile ;
	string  lpFileName, ;
	integer dwDesiredAccess, ;
	integer dwShareMode, ;
	integer lpSecurityAttributes, ;
	integer dwCreationDisposition, ;
	integer dwFlagsAndAttributes, ;
	integer hTemplateFile

return _zapicreatefile(m.lpFileName, m.dwDesiredAccess, m.dwShareMode, m.lpSecurityAttributes, m.dwCreationDisposition, m.dwFlagsAndAttributes, m.hTemplateFile)