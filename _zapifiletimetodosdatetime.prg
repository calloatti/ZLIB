*!* _zapifiletimetodosdatetime

lparameters lpFileTime, lpFatDate, lpFatTime

declare integer FileTimeToDosDateTime in WIN32.API as _zapifiletimetodosdatetime;
	string lpFileTime, ;
	short @lpFatDate, ;
	short @lpFatTime

return _zapifiletimetodosdatetime(m.lpFileTime, @m.lpFatDate, @m.lpFatTime)