
_idc = 778;

_fob = lbText [_idc, lbCurSel _idc];

if (_fob == "Base") then {_fob = "respawn_west";};

mapAnimAdd [0.5, 0.2, (getMarkerPos _fob)]; mapAnimCommit;