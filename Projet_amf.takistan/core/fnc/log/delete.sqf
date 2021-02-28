
/* ----------------------------------------------------------------------------
Function: btc_fnc_log_delete

Description:
    Delete object created by logistic point.

Parameters:
    _object - Helipad where the object to delete is. [Object]
    _blackList - Object can't be deleted. [Array]

Returns:

Examples:
    (begin example)
        [btc_create_object_point] call btc_fnc_log_delete;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_object", objNull, [objNull]],
    ["_blackList", [btc_create_object], [[]]]
];

private _array = ((nearestObjects [_object, btc_log_main_rc select {_x isEqualType ""}, 6]) select {!(
    _x isKindOf "ACE_friesBase" OR
    _x isKindOf "ace_fastroping_helper"
)}) - _blackList;

if (_array isEqualTo []) exitWith {
    [
        [localize "STR_BTC_HAM_LOG_DELETE"],
        ["<img size='1' image='\z\ace\addons\arsenal\data\iconClearContainer.paa' align='center'/>"]
    ] call CBA_fnc_notify;
};

[_array select 0] remoteExecCall ["btc_fnc_log_server_delete", [2]];
