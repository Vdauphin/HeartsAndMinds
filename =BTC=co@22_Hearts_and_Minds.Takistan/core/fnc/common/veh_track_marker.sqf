
private ["_is_vehicle","_veh","_resp","_v_type","_v_pos","_v_dir","_type","_color","_sleep","_marker"];

_is_vehicle = true;

_veh = _this select 0;
_resp = _this select 1;

_v_type = typeOf _veh;
_v_pos = getPos _veh;
_v_dir = getDir _veh;

if (_veh isKindOf "Man") then {_is_vehicle = false;};

_type = "mil_triangle";
_color = "ColorGreen";
_sleep = 5;

_marker = createmarker [format ["m_%1",_veh],getPos _veh];
_marker setMarkerType _type;
_marker setMarkerColor _color;
_marker setMarkerDir (getDir _veh);

while {Alive _veh} do {
	sleep _sleep;
	if (speed _veh > 50) then {_sleep = 2;} else {_sleep = 5;};
	_marker setMarkerPos (getPos _veh);
	_marker setMarkerDir (getDir _veh);
};

_marker setMarkerColor "ColorRed";

if (_resp) then {
	sleep (_this select 2);
	deleteMarker _marker;
	if (200 > ((getPos _veh) distance _v_pos)) then {deleteVehicle _veh;};

	_veh = _v_type createVehicle _v_pos;
	_veh setDir _v_dir;
	_veh setPos _v_pos;
	[_veh,true,(_this select 2)] spawn btc_fnc_veh_track_marker;
} else {deleteMarker _marker;};