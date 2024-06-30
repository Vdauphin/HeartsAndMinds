
/* ----------------------------------------------------------------------------
Function: btc_fob_fnc_addInteraction

Description:
    Add respawn ACE interaction to vehicle or FOB.

Parameters:
    _veh - Vehicle to add in wreck system. [Object, String]
    _isFull - Full respawn menu. [Bool]
    _timeout - Enable timeout for interaction. [Bool]
    _typeNum - Type of action, 0 for actions, 1 for self-actions [Number]
    _parentPath - Parent path of the new action. [Array]

Returns:

Examples:
    (begin example)
        [cursorObject] call btc_fob_fnc_addInteraction;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_veh", objNull, [objNull, ""]],
    ["_isFull", true, [true]],
    ["_timeout", false, [false]],
    ["_typeNum", 0, [0]],
    ["_parentPath", ["ACE_MainActions"], [[]]]
];

private _actions = [];
private _condition = {
    !btc_log_placing &&
    !(player getVariable ["ace_dragging_isCarrying", false]) &&
    alive _target
};
if (_timeout) then {
    _condition = {
        !btc_log_placing &&
        !(player getVariable ["ace_dragging_isCarrying", false]) &&
        alive _target &&
        CBA_missionTime < btc_fob_timeout
    };
};

if (_isFull) then {
    _actions pushBack ["redeploy", localize "STR_BTC_HAM_ACTION_BIRESPAWN", "\A3\ui_f\data\igui\cfg\simpleTasks\types\run_ca.paa", {
        if ([] call btc_fob_fnc_redeployCheck) then {
            [] call btc_respawn_fnc_force;
        };
    }, _condition];
};
_actions pushBack ["base", localize "STR_BTC_HAM_ACTION_REDEPLOYBASE", getText (configfile >> "CfgMarkers" >> getMarkerType "btc_base" >> "icon"), {
    if ([] call btc_fob_fnc_redeployCheck) then {
        [_player, btc_respawn_marker, false] call BIS_fnc_moveToRespawnPosition
    };
}, _condition, btc_fob_fnc_redeploy, "Base"];

if (_isFull) then {
    _actions pushBack ["rallypoints", localize "STR_BTC_HAM_ACTION_REDEPLOYRALLY", 
        "\A3\ui_f\data\igui\cfg\simpleTasks\types\wait_ca.paa", {}, 
        _condition,
        btc_fob_fnc_redeploy, ""
    ];
    _actions pushBack ["FOB", localize "STR_BTC_HAM_ACTION_REDEPLOYFOB",
        "\A3\Ui_f\data\Map\Markers\NATO\b_hq.paa", {},
        _condition
    ];
};

{
    private _action = _x call ace_interact_menu_fnc_createAction;
    if (_veh isEqualType "") then {
        [_veh, _typeNum, _parentPath, _action] call ace_interact_menu_fnc_addActionToClass;
    } else {
        [_veh, _typeNum, _parentPath, _action] call ace_interact_menu_fnc_addActionToObject;
    };
} forEach _actions;

if (_isFull) then {
    {
        _x params ["_cardinal", "_degrees"];

        _action = ["FOB" + _cardinal, localize _cardinal,
            "\A3\ui_f\data\igui\cfg\simpleTasks\types\map_ca.paa", {},
            {alive _target}, btc_fob_fnc_redeploy, _degrees
        ] call ace_interact_menu_fnc_createAction;
        if (_veh isEqualType "") then {
            [_veh, _typeNum, _parentPath + ["FOB"], _action] call ace_interact_menu_fnc_addActionToClass;
        } else {
            [_veh, _typeNum, _parentPath + ["FOB"], _action] call ace_interact_menu_fnc_addActionToObject;
        };
    } forEach [
        ["str_q_north_east", [0, 90]], ["str_q_south_east", [90, 180]],
        ["str_q_south_west", [180, 270]], ["str_q_north_west", [270, 360]]
    ];
};
