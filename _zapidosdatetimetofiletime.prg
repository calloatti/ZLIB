*!* _zapidosdatetimetofiletime

lparameters wFatDate, wFatTime, lpFileTime

declare integer DosDateTimeToFileTime in WIN32API as _zapidosdatetimetofiletime;
	short wFatDate, ;
	short wFatTime, ;
	string @lpFileTime

return _zapidosdatetimetofiletime(m.wFatDate, m.wFatTime, @m.lpFileTime)