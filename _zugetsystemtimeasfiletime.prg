*!* _zugetsystemtimeasfiletime

local filetime, systemtime

m.systemtime = 0h00000000000000000000000000000000

_zapigetsystemtime(@m.systemtime)

m.filetime = 0h00000000000000000000000000000000

_zapisystemtimetofiletime(m.systemtime, @m.filetime)

return m.filetime