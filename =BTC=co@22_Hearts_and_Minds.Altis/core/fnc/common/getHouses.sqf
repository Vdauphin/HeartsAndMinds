_pos       = _this select 0;
_radius    = _this select 1;
_buildings = nearestObjects [_pos, ["Building"], _radius];
_useful    = [];
{ 
	if (format["%1", _x buildingPos 2] != "[0,0,0]" && {damage _x == 0} && {isNil {_x getVariable "btc_house_taken"}}) then
	{ 
		_useful set [count _useful, _x]; 
	}; 
} forEach _buildings; 
_useful	