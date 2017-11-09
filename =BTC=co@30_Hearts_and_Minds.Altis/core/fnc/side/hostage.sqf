
private ["_useful","_city","_pos","_captive","_group_civ","_group","_house","_houses","_marker","_wp","_unit","_buildingPos","_pos_number","_mine"];

//// Choose an occupied City \\\\
_useful = btc_city_all select {(_x getVariable ["occupied",false] && {_x getVariable ["type",""] != "NameLocal"} && {_x getVariable ["type",""] != "Hill"} && (_x getVariable ["type",""] != "NameMarine"))};

if (_useful isEqualTo []) exitWith {[] spawn btc_fnc_side_create;};

_city = selectRandom _useful;

//// Randomise position \\\\
_houses = [getPos _city,100] call btc_fnc_getHouses;
if (_houses isEqualTo []) exitWith {[] spawn btc_fnc_side_create;};
_houses = _houses apply { [count (_x buildingPos -1), _x] };
_houses sort false;
if (count _houses > 3) then {_house = (selectRandom _houses select [0,3]) select 1;} else {_house = _houses select 0 select 1;};
_buildingPos = _house buildingPos -1;
_pos_number = count _buildingPos - 1;
_pos = _buildingPos select (_pos_number - round random 1);

//// Data side mission
btc_side_aborted = false;
btc_side_done = false;
btc_side_failed = false;
btc_side_assigned = true;publicVariable "btc_side_assigned";

[15,_pos,_city getVariable "name"] call btc_fnc_task_create;

btc_side_jip_data = [15,getPos _city,_city getVariable "name"];

//// Marker
_marker = createmarker [format ["sm_2_%1",getPos _house],getPos _house];
_marker setmarkertype "hd_flag";
_marker setmarkertext (localize "STR_BTC_HAM_SIDE_HOSTAGE_MRK"); //Hostage
_marker setMarkerSize [0.6, 0.6];

_city setVariable ["spawn_more",true];

//// Hostage
_group_civ = createGroup civilian;
_group_civ setVariable ["no_cache",true];
(selectRandom btc_civ_type_units) createUnit [_pos, _group_civ, "_captive = this;"];
waitUntil {local _captive};
[_captive,true] call ACE_captives_fnc_setHandcuffed;
_captive setPosATL _pos;
_captive call btc_fnc_civ_unit_create;

_group = [];
{
	private ["_grp"];
	_grp = createGroup btc_enemy_side;
	_unit = _grp createUnit [selectRandom btc_type_units, _x, [], 0, "NONE"];
	[_unit] joinSilent _grp;
	_unit setPosATL _x;
	_group pushBack _grp;
	_grp setVariable ["no_cache",true];
	_unit call btc_fnc_mil_unit_create;
} forEach (_buildingPos - [_pos]);

_trigger = createTrigger["EmptyDetector",_pos];
_trigger setVariable ["group", _group];
_trigger setTriggerArea[20,20,0,false];
_trigger setTriggerActivation[str(btc_player_side),"PRESENT",true];
_trigger setTriggerStatements["this", "private _group = thisTrigger getVariable 'group'; {_x setCombatMode 'RED';} foreach _group;", "private _group = thisTrigger getVariable 'group'; {_x setCombatMode 'WHITE';} foreach _group;"];

if (random 1 > 0.5) then {
	sleep 5;
	_mine = createMine [selectRandom btc_type_mines, getposATL _captive, [], 0];
} else {
	_mine = objNull;
};

waitUntil {sleep 5; (btc_side_aborted || btc_side_failed || !(_captive getVariable ["ace_captives_isHandcuffed", false]) || !Alive _captive)};

if (!(_captive getVariable ["ace_captives_isHandcuffed", false])) then {
	_mine setDamage 1;
	sleep 1;
};

_group_civ setVariable ["no_cache",false];
{_x setVariable ["no_cache",false];} foreach _group;
btc_side_assigned = false;publicVariable "btc_side_assigned";

if (btc_side_aborted || btc_side_failed || !(Alive _captive)) exitWith {
	15 remoteExec ["btc_fnc_task_fail", 0];
	[[_marker], [_trigger,_mine], [], _group + [_group_civ]] call btc_fnc_delete;
};

40 call btc_fnc_rep_change;

[[_marker], [], [], []] call btc_fnc_delete;
15 remoteExec ["btc_fnc_task_set_done", 0];
