
/* ----------------------------------------------------------------------------
Function: btc_int_fnc_ask_var

Description:
    Fill me when you edit me !

Parameters:
    _id - [Object]
    _target - [String]
    _varName - []

Returns:

Examples:
    (begin example)
        _result = [] call btc_int_fnc_ask_var;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_id", 0, [0, ""]],
    ["_target", objNull, [objNull]],
    ["_varName", "btc_int_ask_data", [""]]
];

private _data = switch (_id) do {
    case 9 : {[_target] call btc_db_fnc_saveObjectStatus;};
    case 10 : {
        private _units = allUnits select {alive _x};
        _units append entities [["Car", "Tank", "Ship", "Air"], []];
        _units apply {[_x, owner _x]};
    };
    case 11 : {floor diag_fps;};
    default {missionNamespace getVariable [_id, []];};
};

missionNamespace setVariable [_varName, _data, remoteExecutedOwner];
