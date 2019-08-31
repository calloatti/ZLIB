*!* _zapisystemtimetofiletime

Lparameters lpSystemTime, lpFileTime

Declare Integer SystemTimeToFileTime In WIN32API As _zapisystemtimetofiletime;
  String lpSystemTime, ;
  String @lpFileTime

Return _zapisystemtimetofiletime(m.lpSystemTime, @m.lpFileTime)