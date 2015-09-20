_is_vehicle = true;

_veh = _this select 0;
_resp = _this select 1;
_p_marker = _this select 3;

_v_type = typeOf _veh;
_v_pos = getPos _veh;
_v_dir = getDir _veh;

if (_veh isKindOf "Man") then {_is_vehicle = false;};

_type = "mil_triangle";
if (_p_marker == 0) then {_type = "Empty";};
_color = "ColorGreen";
_sleep = 5;

_marker = createmarker [format ["m_%1",_veh],getPos _veh];
_marker setMarkerType _type;
_marker setMarkerColor _color;
_marker setMarkerDir (getDir _veh);
while {Alive _veh} do
{
	sleep _sleep;
	if (_p_marker == 1) then  
	{
		if (speed _veh > 50) then {_sleep = 2;} else {_sleep = 5;};
		_marker setMarkerPos (getPos _veh);
		_marker setMarkerDir (getDir _veh);
	};
};

_marker setMarkerColor "ColorRed";

[_veh,_marker] spawn {waitUntil {sleep 5; (isNull (_this select 0))};deleteMarker (_this select 1);};

if (_resp) then 
{
	sleep (_this select 2);
	
	deleteVehicle _veh;

	_veh = _v_type createVehicle _v_pos;
	_veh setDir _v_dir;
	_veh setPos _v_pos;
	[_veh,true,(_this select 2),_p_marker] spawn btc_fnc_veh_track_marker;
};


/*
_is_vehicle = true;
if (_this isKindOf "Man") then {_is_vehicle = false;};

_type = "mil_triangle";
_color = "ColorGreen";
_sleep = 5;

_marker = createmarker [format ["m_%1",_this],getPos _this];
_marker setMarkerType _type;
_marker setMarkerColor _color;
_marker setMarkerDir (getDir _this);
while {!isNull _this} do
{
	sleep _sleep;
	if (speed _this > 50) then {_sleep = 2;} else {_sleep = 5;};
	_marker setMarkerPos (getPos _this);
	_marker setMarkerDir (getDir _this);
	if (!Alive _this) then {_marker setMarkerColor "ColorRed";};
};

deleteMarker _marker;
*/
