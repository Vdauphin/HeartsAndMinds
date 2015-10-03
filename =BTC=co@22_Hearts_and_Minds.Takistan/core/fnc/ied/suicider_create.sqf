_city = _this select 0;
_area = _this select 1;

if (btc_debug_log) then
{
	diag_log format ["btc_fnc_ied_suicider_create:  _name = %1 _area %2",_city getVariable ["name","name"],_area];
};

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

_group setVariable ["suicider",true];

_suicider = leader _group;

//Main check
_suicider spawn
{
	_cond = false;

	while {Alive _this && !isNull _this && !_cond} do
	{
		sleep 5;
		if (count (getpos _this nearEntities ["SoldierWB", 25]) > 0) then {_cond = true;_this spawn btc_fnc_ied_suicider_active};
	};
};