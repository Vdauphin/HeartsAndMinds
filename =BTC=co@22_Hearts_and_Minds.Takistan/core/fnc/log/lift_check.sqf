
if (!(vehicle player isKindOf "Helicopter") || !isNull ((vehicle player) getVariable ["cargo",objNull])) exitWith {false};
_array = [vehicle player] call btc_fnc_log_get_liftable;
if (count _array == 0) exitWith {false};
_chopper  = vehicle player;
_can_lift = false;
_cargo_array = nearestObjects [_chopper, _array, 30];
_cargo = objNull;
if (count _cargo_array > 0) then {if (driver (_cargo_array select 0) == player) then {_cargo_array set [0,0];_cargo_array = _cargo_array - [0];};};
if (count _cargo_array > 0) then {_cargo = _cargo_array select 0;_can_lift = true;} else {_can_lift = false;};

if !(_can_lift) exitWith {false};

if (({_cargo isKindOf _x} count _array) > 0 && speed _cargo < 5) then {_can_lift = true;} else {_can_lift = false;};

if !(_can_lift) exitWith {false};

_cargo_pos = getPosATL _cargo;
_rel_pos   = _chopper worldToModel _cargo_pos;
_cargo_x   = _rel_pos select 0;
_cargo_y   = _rel_pos select 1;
_cargo_z   = _rel_pos select 2;//hintSilent format ["%1 - %2 - %3",_cargo_x,_cargo_y,_cargo_z];

if (((abs _cargo_z) < btc_lift_max_h) && ((abs _cargo_z) > btc_lift_min_h) && ((abs _cargo_x) < btc_lift_radius) && ((abs _cargo_y) < btc_lift_radius)) then
	{_can_lift = true;} else {_can_lift = false;};
	//hintSilent format ["%1 - %2", _cargo,_cargo_array];
_can_lift 