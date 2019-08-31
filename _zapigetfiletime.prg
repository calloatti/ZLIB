*!* _zapigetfiletime.prg

lparameters hFile, lpCreationTime, lpLastAccessTime, lpLastWriteTime

declare integer GetFileTime in win32api as _zapigetfiletime ;
	integer hFile, ;
	string  @lpCreationTime, ;
	string  @lpLastAccessTime, ;
	string  @lpLastWriteTime

return _zapigetfiletime(m.hFile, @m.lpCreationTime, @m.lpLastAccessTime, @m.lpLastWriteTime)