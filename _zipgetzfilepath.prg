* ! * _zipgetzfilepath

* ! * REMOVES THE BASE PATH FROM A PATH

lparameters psfilepath, pbasepath

return ltrim(strextract(m.psfilepath, m.pbasepath, '', 1, 1), 1, '\')