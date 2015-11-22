
private ["_city","_area","_pos","_rpos","_unit_type","_group"];

_city = _this select 0;
_area = _this select 1;

_pos = [];

switch (typeName _city) do
{
	case "ARRAY" :{_pos = _city;};
	case "STRING":{_pos = getMarkerPos _city;};
	case "OBJECT":{_pos = position _city;};
};

_rpos = [_pos, _area] call btc_fnc_randomize_pos;

_unit_type = btc_civ_type_units select (floor random count btc_civ_type_units);

_group = createGroup civilian;
_group createUnit [_unit_type, _rpos, [], 0, "NONE"];
(leader _group) setpos _rpos;

_group spawn btc_fnc_civ_addWP;

_group setSpeedMode "LIMITED";

{_x call btc_fnc_civ_unit_create} foreach units _group;

if (BTC_debug_log) then {
	diag_log format ["BTC_fnc_civ_create: _this = %1 ; POS %2 UNITS N %3",_this,_pos,count units _group];
};

_group