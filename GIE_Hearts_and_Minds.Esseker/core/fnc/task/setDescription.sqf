
/* ----------------------------------------------------------------------------
Function: btc_task_fnc_setDescription

Description:
    Set description to created task accordingly to player language.

Parameters:
    _task_ids - ID of the task. [String]
    _side - Side of the player. [Side]
    _description - Number of the corresponding description. [Number]
    _destination - Destination of the task. [Object or Array]
    _priority - Task priority. [Number]
    _showNotification - Show notification. [Boolean]
    _location - Custom information to fill the task description. [String or Array]

Returns:

Examples:
    (begin example)
        ["btc_1", btc_player_side, -1] remoteExecCall ["btc_task_fnc_setDescription", [0, -2] select isDedicated, true];
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_task_ids", [], ["", []]],
    ["_side", west, [west]],
    ["_description", 0, [0]],
    ["_destination", [], [objNull, []]],
    ["_priority", 2, [0]],
    ["_showNotification", true, [true]],
    ["_location", "", ["", []]]
];

private _type = "";
switch (_description) do {
    case -1 : {
        _description = [
            localize "STR_BTC_HAM_MISSION_OBJ_DESC",
            localize "STR_BTC_HAM_MISSION_OBJ_TITLE",
            localize "STR_BTC_HAM_MISSION_OBJ_TITLE"
        ];
        _type = "documents";
    };
    case 0 : {
        _description = [
            localize "STR_BTC_HAM_MISSION_DEFEAT_DESC",
            localize "STR_BTC_HAM_MISSION_DEFEAT_TITLE",
            localize "STR_BTC_HAM_MISSION_DEFEAT_TITLE"
        ];
        _type = "kill";
    };
    case 1 : {
        _description = [
            localize "STR_BTC_HAM_MISSION_DESTROY_DESC",
            localize "STR_BTC_HAM_MISSION_DESTROY_TITLE",
            localize "STR_BTC_HAM_MISSION_DESTROY_TITLE"
        ];
        _type = "destroy";
    };
    case 2 : {
        _description = [
            localize "STR_BTC_HAM_O_COMMON_SHOWHINTS_6",
            localize "STR_BTC_HAM_MISSION_SEIZE_TITLE",
            localize "STR_BTC_HAM_MISSION_SEIZE_TITLE"
        ];
        _type = "map";
    };
    case 3 : {
        _description = [
            format [localize "STR_BTC_HAM_SIDE_SUPPLIES_DESC", _location],
            format [localize "STR_BTC_HAM_SIDE_SUPPLIES_TITLE", _location],
            format [localize "STR_BTC_HAM_SIDE_SUPPLIES_TITLE", _location]
        ];
        _type = "container";
    };
    case 4 : {
        _description = [
            format [localize "STR_BTC_HAM_SIDE_MINES_DESC", _location],
            format [localize "STR_BTC_HAM_SIDE_MINES_TITLE", _location],
            format [localize "STR_BTC_HAM_SIDE_MINES_TITLE", _location]
        ];
        _type = "mine";
    };
    case 5 : {
        _location params ["_loc", "_vehicleType"];
        _description = [
            (format [localize "STR_BTC_HAM_SIDE_VEHICLE_DESC", _loc]) + ([_vehicleType] call btc_fnc_typeOfPreview),
            format [localize "STR_BTC_HAM_SIDE_VEHICLE_TITLE", _loc],
            format [localize "STR_BTC_HAM_SIDE_VEHICLE_TITLE", _loc]
        ];
        _type = "repair";
    };
    case 6 : {
        _description = [
            format [localize "STR_BTC_HAM_SIDE_CONQUER_DESC", _location],
            format [localize "STR_BTC_HAM_SIDE_CONQUER_TITLE", _location],
            format [localize "STR_BTC_HAM_SIDE_CONQUER_TITLE", _location]
        ];
        _type = "attack";
    };
    case 7 : {
        _location params ["_loc", "_towerType"];
        _description = [
            (format [localize "STR_BTC_HAM_SIDE_TOWER_DESC", _loc]) + ([_towerType] call btc_fnc_typeOfPreview),
            format [localize "STR_BTC_HAM_SIDE_TOWER_TITLE", _loc],
            format [localize "STR_BTC_HAM_SIDE_TOWER_TITLE", _loc]
        ];
        _type = "destroy";
    };
    case 8 : {
        _location params ["_loc", "_unitType"];
        _description = [
            (format [localize "STR_BTC_HAM_SIDE_CIVTREAT_DESC", _loc]) + ([_unitType] call btc_fnc_typeOfPreview),
            format [localize "STR_BTC_HAM_SIDE_CIVTREAT_TITLE", _loc],
            format [localize "STR_BTC_HAM_SIDE_CIVTREAT_TITLE", _loc]
        ];
        _type = "heal";
    };
    case 9 : {
        _description = [
            format [localize "STR_BTC_HAM_SIDE_CHECKPOINT_DESC", _location],
            format [localize "STR_BTC_HAM_SIDE_CHECKPOINT_TITLE", _location],
            format [localize "STR_BTC_HAM_SIDE_CHECKPOINT_TITLE", _location]
        ];
        _type = "destroy";
    };
    case 10 : {
        _location params ["_loc", "_vehicleType"];
        _description = [
            (format [localize "STR_BTC_HAM_SIDE_CIVTREATBOAT_DESC", _loc]) + ([_vehicleType] call btc_fnc_typeOfPreview),
            format [localize "STR_BTC_HAM_SIDE_CIVTREATBOAT_TITLE", _loc],
            format [localize "STR_BTC_HAM_SIDE_CIVTREATBOAT_TITLE", _loc]
        ];
        _type = "heal";
    };
    case 11 : {
        _location params ["_loc", "_vehicleType"];
        _description = [
            (format [localize "STR_BTC_HAM_SIDE_UNDERWATER_DESC", _loc]) + ([_vehicleType] call btc_fnc_typeOfPreview),
            format [localize "STR_BTC_HAM_SIDE_UNDERWATER_TITLE", _loc],
            format [localize "STR_BTC_HAM_SIDE_UNDERWATER_TITLE", _loc]
        ];
        _type = "destroy";
    };
    case 12 : {
        _description = [
            format [localize "STR_BTC_HAM_SIDE_CONVOY_DESC", _location],
            format [localize "STR_BTC_HAM_SIDE_CONVOY_TITLE", _location],
            format [localize "STR_BTC_HAM_SIDE_CONVOY_TITLE", _location]
        ];
        _type = "car";
    };
    case 13 : {
        _description = [
            format [localize "STR_BTC_HAM_SIDE_RESC_DESC", _location],
            format [localize "STR_BTC_HAM_SIDE_RESC_TITLE", _location],
            format [localize "STR_BTC_HAM_SIDE_RESC_TITLE", _location]
        ];
        _type = "heli";
    };
    case 14 : {
        _description = [
            format [localize "STR_BTC_HAM_SIDE_CAPOFF_DESC", _location],
            format [localize "STR_BTC_HAM_SIDE_CAPOFF_TITLE", _location],
            format [localize "STR_BTC_HAM_SIDE_CAPOFF_TITLE", _location]
        ];
        _type = "run";
    };
    case 15 : {
        _location params ["_loc", "_hostageType"];
        _description = [
            (format [localize "STR_BTC_HAM_SIDE_HOSTAGE_DESC", _loc]) + ([_hostageType] call btc_fnc_typeOfPreview),
            format [localize "STR_BTC_HAM_SIDE_HOSTAGE_TITLE", _loc],
            format [localize "STR_BTC_HAM_SIDE_HOSTAGE_TITLE", _loc]
        ];
        _type = "handcuff";
    };
    case 16 : {
        _description = [
            format [localize "STR_BTC_HAM_SIDE_HACK_DESC", _location],
            format [localize "STR_BTC_HAM_SIDE_HACK_TITLE", _location],
            format [localize "STR_BTC_HAM_SIDE_HACK_TITLE", _location]
        ];
        _type = "defend";
    };
    case 17 : {
        _description = [
            localize "STR_BTC_HAM_SIDE_HACK_OPEN_DESC" + ([_location] call btc_fnc_typeOfPreview),
            localize "STR_BTC_HAM_SIDE_HACK_OPEN_TITLE",
            localize "STR_BTC_HAM_SIDE_HACK_OPEN_TITLE"
        ];
        _type = "interact";
    };
    case 18 : {
        _description = [
            localize "STR_BTC_HAM_SIDE_SUPPLIES_MOVE_DESC" + ([_location] call btc_fnc_typeOfPreview),
            localize "STR_BTC_HAM_SIDE_SUPPLIES_MOVE_TITLE",
            localize "STR_BTC_HAM_SIDE_SUPPLIES_MOVE_TITLE"
        ];
        _type = "move";
    };
    case 19 : {
        _description = [
            localize "STR_BTC_HAM_SIDE_SUPPLIES_UNLOAD_DESC" + ([_location] call btc_fnc_typeOfPreview),
            localize "STR_BTC_HAM_SIDE_SUPPLIES_UNLOAD_TITLE",
            localize "STR_BTC_HAM_SIDE_SUPPLIES_UNLOAD_TITLE"
        ];
        _type = "box";
    };
    case 20 : {
        _description = [
            localize "STR_BTC_HAM_SIDE_RESC_FIND_DESC" + ([_location] call btc_fnc_typeOfPreview),
            localize "STR_BTC_HAM_SIDE_RESC_FIND_TITLE",
            localize "STR_BTC_HAM_SIDE_RESC_FIND_TITLE"
        ];
        _type = "scout";
    };
    case 21 : {
        _description = [
            localize "STR_BTC_HAM_SIDE_RESC_BACK_DESC" + ([_location] call btc_fnc_typeOfPreview),
            localize "STR_BTC_HAM_SIDE_RESC_BACK_TITLE",
            localize "STR_BTC_HAM_SIDE_RESC_BACK_TITLE"
        ];
        _type = "move";
    };
    case 22 : {
        _description = [
            localize "STR_BTC_HAM_SIDE_HACK_STARTHACK" + ([_location] call btc_fnc_typeOfPreview),
            localize "STR_BTC_HAM_SIDE_HACK_DEFEND_TITLE",
            localize "STR_BTC_HAM_SIDE_HACK_DEFEND_TITLE"
        ];
        _type = "defend";
    };
    case 23 : {
        _description = [
            localize "STR_BTC_HAM_SIDE_CHECKPOINT_DESTROY_DESC" + ([_location] call btc_fnc_typeOfPreview),
            localize "STR_BTC_HAM_SIDE_CHECKPOINT_DESTROY_TITLE",
            localize "STR_BTC_HAM_SIDE_CHECKPOINT_DESTROY_TITLE"
        ];
        _type = "destroy";
    };
    case 24 : {
        _description = [
            localize "STR_BTC_HAM_SIDE_CAPOFF_SURRENDER_DESC" + ([_location] call btc_fnc_typeOfPreview),
            localize "STR_BTC_HAM_SIDE_CAPOFF_SURRENDER_TITLE",
            localize "STR_BTC_HAM_SIDE_CAPOFF_SURRENDER_TITLE"
        ];
        _type = "surrender";
    };
    case 25 : {
        _location params ["_officerName", "_loc"];
        _description = [
            format [localize "STR_BTC_HAM_SIDE_KILL_DESC", _officerName, _loc],
            format [localize "STR_BTC_HAM_SIDE_KILL_TITLE", _officerName],
            format [localize "STR_BTC_HAM_SIDE_KILL_TITLE", _officerName]
        ];
        _type = "kill";
    };
    case 26 : {
        _location params ["_officerName", "_loc", "_officerType"];
        _description = [
            format [localize "STR_BTC_HAM_SIDE_KILL_IN_DESC", _officerName, _loc] + ([_officerType] call btc_fnc_typeOfPreview),
            format [localize "STR_BTC_HAM_SIDE_KILL_IN_TITLE", _officerName],
            format [localize "STR_BTC_HAM_SIDE_KILL_IN_TITLE", _officerName]
        ];
        _type = "kill";
    };
    case 27 : {
        _description = [
            format [localize "STR_BTC_HAM_SIDE_KILL_DOGTAG_DESC", _location] + format ["<br/><img image='%1' width='355' height='300'/>", "\z\ace\addons\dogtags\data\dogtagSingle.paa"],
            localize "STR_BTC_HAM_SIDE_KILL_DOGTAG_TITLE",
            localize "STR_BTC_HAM_SIDE_KILL_DOGTAG_TITLE"
        ];
        _type = "dogtags";
    };
    case 28 : {
        _location params ["_officerName", "_base"];
        _description = [
            format [localize "STR_BTC_HAM_SIDE_KILL_BRING_DESC", _officerName] + ([_base] call btc_fnc_typeOfPreview),
            localize "STR_BTC_HAM_SIDE_KILL_BRING_TITLE",
            localize "STR_BTC_HAM_SIDE_KILL_BRING_TITLE"
        ];
        _type = "move";
    };
    case 29 : {
        _description = [
            localize "STR_BTC_HAM_SIDE_CAPOFF_HANDCUFF_DESC",
            localize "STR_BTC_HAM_SIDE_CAPOFF_HANDCUFF_TITLE",
            localize "STR_BTC_HAM_SIDE_CAPOFF_HANDCUFF_TITLE"
        ];
        _type = "handcuff";
    };
    case 30 : {
        _description = [
            format [localize "STR_BTC_HAM_SIDE_CHEM_DESC", _location] + (["B_W_Soldier_CBRN_F"] call btc_fnc_typeOfPreview),
            format [localize "STR_BTC_HAM_SIDE_CHEM_TITLE", _location],
            format [localize "STR_BTC_HAM_SIDE_CHEM_TITLE", _location]
        ];
        _type = "danger";
    };
    case 31 : {
        _description = [
            (localize "STR_BTC_HAM_SIDE_CHEM_BRING_DESC") + ([_location] call btc_fnc_typeOfPreview),
            localize "STR_BTC_HAM_SIDE_CHEM_BRING_TITLE",
            localize "STR_BTC_HAM_SIDE_CHEM_BRING_TITLE"
        ];
        _type = "container";
    };
    case 32 : {
        _description = [
            (localize "STR_BTC_HAM_SIDE_CHEM_LOCATE_DESC") + ([_location] call btc_fnc_typeOfPreview),
            localize "STR_BTC_HAM_SIDE_CHEM_LOCATE_TITLE",
            localize "STR_BTC_HAM_SIDE_CHEM_LOCATE_TITLE"
        ];
        _type = "search";
    };
    case 33 : {
        _description = [
            (localize "STR_BTC_HAM_SIDE_CHEM_MOVE_DESC") + ([_location] call btc_fnc_typeOfPreview),
            localize "STR_BTC_HAM_SIDE_CHEM_MOVE_TITLE",
            localize "STR_BTC_HAM_SIDE_CHEM_MOVE_TITLE"
        ];
        _type = "move";
    };
    case 34 : {
        _location params ["_pilotName", "_typeOf_pilot"];
        _description = [
            format [localize "STR_BTC_HAM_SIDE_RESC_BODYBAG_DESC", _pilotName] + ([_typeOf_pilot] call btc_fnc_typeOfPreview),
            localize "STR_BTC_HAM_SIDE_RESC_BODYBAG_TITLE",
            localize "STR_BTC_HAM_SIDE_RESC_BODYBAG_TITLE"
        ];
        _type = "interact";
    };
    case 35 : {
        _location params ["_pilotName", "_base"];
        _description = [
            format [localize "STR_BTC_HAM_SIDE_RESC_BRING_DESC", _pilotName] + ([_base] call btc_fnc_typeOfPreview),
            localize "STR_BTC_HAM_SIDE_RESC_BRING_TITLE",
            localize "STR_BTC_HAM_SIDE_RESC_BRING_TITLE"
        ];
        _type = "move";
    };
    case 36 : {
        _description = [
            format [localize "STR_BTC_HAM_SIDE_EMP_DESC", _location, "<br/><img image='\a3\Data_F_Enoch\Images\SpectrumDevice_ca.paa'  width='355' height='200'/>"],
            format [localize "STR_BTC_HAM_SIDE_EMP_TITLE", _location],
            format [localize "STR_BTC_HAM_SIDE_EMP_TITLE", _location]
        ];
        _type = "antenna";
    };
    case 37 : {
        _description = [
            (localize "STR_BTC_HAM_SIDE_EMP_DESTROY_DESC") + ([_location] call btc_fnc_typeOfPreview),
            localize "STR_BTC_HAM_SIDE_EMP_DESTROY_TITLE",
            localize "STR_BTC_HAM_SIDE_EMP_DESTROY_TITLE"
        ];
        _type = "search";
    };
    case 38 : {
        _description = [
            format [localize "STR_BTC_HAM_SIDE_RUBBISH_DESC", _location] + (["B_APC_Tracked_01_CRV_F"] call btc_fnc_typeOfPreview),
            format [localize "STR_BTC_HAM_SIDE_RUBBISH_TITLE", _location],
            format [localize "STR_BTC_HAM_SIDE_RUBBISH_TITLE", _location]
        ];
        _type = "use";
    };
    case 39 : {
        _description = [
            (localize "STR_BTC_HAM_SIDE_RUBBISH_SPOT_DESC") + ([_location] call btc_fnc_typeOfPreview),
            localize "STR_BTC_HAM_SIDE_RUBBISH_SPOT_TITLE",
            localize "STR_BTC_HAM_SIDE_RUBBISH_SPOT_TITLE"
        ];
        _type = "move";
    };
    case 40 : {
        _description = [
            format [localize "STR_BTC_HAM_SIDE_PANDEMIC_DESC", _location] + (["DeconShower_01_F"] call btc_fnc_typeOfPreview),
            format [localize "STR_BTC_HAM_SIDE_PANDEMIC_TITLE", _location],
            format [localize "STR_BTC_HAM_SIDE_PANDEMIC_TITLE", _location]
        ];
        _type = "danger";
    };
    case 41 : {
        _description = [
            (localize "STR_BTC_HAM_SIDE_PANDEMIC_DECON_DESC") + ([_location] call btc_fnc_typeOfPreview),
            localize "STR_BTC_HAM_SIDE_PANDEMIC_DECON_TITLE",
            localize "STR_BTC_HAM_SIDE_PANDEMIC_DECON_TITLE"
        ];
        _type = "search";
    };
};

[
    _task_ids, _side, _description, _destination,
    _task_id call BIS_fnc_taskState,
    _priority, false, false, _type
] call BIS_fnc_setTask;

if !(_showNotification) exitWith {};

private _task_id = if (_task_ids isEqualType []) then {
    _task_ids select 0
} else {
    _task_ids
};
[
    {!isNull player && {scriptDone btc_intro_done}},
    {
        params ["_task_id"];

        if !(_task_id call BIS_fnc_taskCompleted) then {
            _task_id call BIS_fnc_taskHint;
        };
    },
    _task_id
] call CBA_fnc_waitUntilAndExecute;
