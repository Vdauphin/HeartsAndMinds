
private ["_pos","_range","_units"];

_pos = _this select 0;
_range = _this select 1;
_units = [];
if (count _this > 2) then {_units = _this select 2;} else {_units = _pos nearEntities [btc_civ_type_units, _range];};
{
	private ["_array_id","_wp"];
	if (btc_debug_log) then	{diag_log format ["fnc_civ_get_weapons %1 - %2",_x,side _x];};
	if (side _x == btc_enemy_side) exitWith {};

	[_x] spawn btc_fnc_civ_add_weapons;
	
	[_x] joinSilent btc_hq_red;
	[_x] joinSilent GrpNull;
	
	_array_id = _x getVariable "btc_rep_eh_added";
	_x removeEventHandler ["HandleHeal", (_array_id select 0)];
	_x removeEventHandler ["HandleDamage", (_array_id select 1)];
	_x removeEventHandler ["Killed", (_array_id select 2)];

	(group _x) setVariable ["getWeapons",true];
	
	(group _x) setBehaviour "AWARE";
	_wp = (group _x) addWaypoint [getpos _x, 0];
	_wp setWaypointType "GUARD";
	_wp setWaypointCombatMode "RED";
	
} foreach _units;