
/* ----------------------------------------------------------------------------
Function: btc_side_fnc_hostage

Description:
    Fill me when you edit me !

Parameters:
    _taskID - Unique task ID. [String]

Returns:

Examples:
    (begin example)
        [false, "btc_side_fnc_hostage"] spawn btc_side_fnc_create;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_taskID", "btc_side", [""]]
];

//// Choose an occupied City \\\\
private _useful = values btc_city_all select {
    _x getVariable ["occupied", false] &&
    !((_x getVariable ["type", ""]) in ["NameLocal", "Hill", "NameMarine", "StrongpointArea"])
};

if (_useful isEqualTo []) exitWith {[] spawn btc_side_fnc_create;};

private _city = selectRandom _useful;

//// Randomise position \\\\
private _houses = ([getPos _city, 100] call btc_fnc_getHouses) select 0;
_houses = _houses select {count (_x buildingPos -1) > 1}; // Building with low enterable positions are not interesting
if (_houses isEqualTo []) exitWith {[] spawn btc_side_fnc_create;};
_houses = _houses apply {[count (_x buildingPos -1), _x]};
_houses sort false;
private _house = objNull;
if (count _houses > 3) then {
    _house = (selectRandom _houses select [0,3]) select 1;
} else {
    _house = _houses select 0 select 1;
};
private _buildingPos = _house buildingPos -1;
_buildingPos = _buildingPos select [0, count _buildingPos min 20];
private _pos_number = count _buildingPos - 1;
private _pos = _buildingPos select (_pos_number - ((round random 1) min _pos_number));

_city setVariable ["spawn_more", true];

//// Hostage
private _group_civ = createGroup civilian;
_group_civ setVariable ["no_cache", true];
private _civType = selectRandom btc_civ_type_units;
private _captive = _group_civ createUnit [_civType, _pos, [], 0, "CAN_COLLIDE"];
waitUntil {local _captive};
[_captive, true] call ACE_captives_fnc_setHandcuffed;

//// Data side mission
[_taskID, 15, _captive, [_city getVariable "name", _civType]] call btc_task_fnc_create;

private _group = [];
{
    private _grp = createGroup btc_enemy_side;
    private _unit = _grp createUnit [selectRandom btc_type_units, _x, [], 0, "CAN_COLLIDE"];
    [_unit] joinSilent _grp;
    _group pushBack _grp;
    _grp setVariable ["no_cache", true];
    _grp setVariable ["btc_city", _city];
} forEach (_buildingPos - [_pos]);

_trigger = createTrigger ["EmptyDetector", _pos, false];
_trigger setVariable ["group", _group];
_trigger setTriggerArea [20, 20, 0, false];
_trigger setTriggerActivation [str btc_player_side, "PRESENT", true];
_trigger setTriggerStatements ["this", "private _group = thisTrigger getVariable 'group'; {_x setCombatMode 'RED';} forEach _group;", "private _group = thisTrigger getVariable 'group'; {_x setCombatMode 'WHITE';} forEach _group;"];

private _mine = objNull;
if (random 1 > 0.5) then {
    sleep 5;
    _mine = createMine [selectRandom btc_type_mines, getPosATL _captive, [], 0];
};

waitUntil {sleep 5; 
    _taskID call BIS_fnc_taskCompleted ||
    !(_captive getVariable ["ace_captives_isHandcuffed", false]) ||
    !alive _captive
};

if (!(_captive getVariable ["ace_captives_isHandcuffed", false])) then {
    _mine setDamage 1;
    sleep 1;
};

_group_civ setVariable ["no_cache", false];
{
    _x setVariable ["no_cache", false];
} forEach _group;

if (_taskID call BIS_fnc_taskState isEqualTo "CANCELED") exitWith {
    [[], _group + [_group_civ, _trigger, _mine]] call btc_fnc_delete;
};
if !(alive _captive) exitWith {
    [_taskID, "FAILED"] call BIS_fnc_taskSetState;
    [[], _group + [_group_civ, _trigger, _mine]] call btc_fnc_delete;
};

40 call btc_rep_fnc_change;

[_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;
