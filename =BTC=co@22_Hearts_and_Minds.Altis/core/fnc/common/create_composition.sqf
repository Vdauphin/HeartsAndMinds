_pos = _this select 0;
//// Direction parameter is align with compass \\\\
_setdir = -(_this select 1);
_array = _this select 2;
_pos_x = _pos select 0;
_pos_y = _pos select 1;
_pos_z = 0;if (count _pos > 2) then {_pos_z = _pos select 2;};
{
	_type = _x select 0;
	//// Determine direction function of setdir \\\\
	_dir  = ((_x select 1) - _setdir);
	_rel_pos = _x select 2;
	_rel_x   = _rel_pos select 0;
	_rel_y   = _rel_pos select 1;
	_rel_z   = _rel_pos select 2;
	//// Determine position function of setdir \\\\
	_pos_obj = [(_pos_x + _rel_x*cos(_setdir) - _rel_y*sin(_setdir)),(_pos_y +  _rel_y*cos(_setdir) + _rel_x*sin(_setdir)),(_pos_z + _rel_z)];
	_obj = createVehicle [_type, _pos_obj, [], 0, "NONE"];
	_obj setDir _dir;
	_obj setPos _pos_obj;
} foreach _array;