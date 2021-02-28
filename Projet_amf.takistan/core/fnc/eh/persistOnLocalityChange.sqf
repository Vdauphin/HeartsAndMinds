
/* ----------------------------------------------------------------------------
Function: btc_fnc_eh_persistOnLocalityChange

Description:
    Some event handler (EH) are trigger where the unit is local. This add EH to headless or client on locality change. When locality change back to server, the EH is removed from client. EH are always keep on server in case client lost connection.

Parameters:
    _object - Object where to add the event handler. [Object]
    _EH_name - Name of the event handler. [String]
    _EH_fnc - Name of the function executed when the EH is triggered. [Array]
    _params - Params to pass to the event. [Array]

Returns:
    _EH_IDs - Local EH ID and ID of the EH. [Array]

Examples:
    (begin example)
        [cursorObject, "Killed", "btc_fnc_mil_unit_killed"] call btc_fnc_eh_persistOnLocalityChange;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_object", objNull, [objNull]],
    ["_EH_name", "", [""]],
    ["_EH_fnc", "", [""]],
    ["_params", [], [[]]]
];

private _EH_IDs = [
    _object addEventHandler [_EH_name,
        if (_params isEqualTo []) then {
            missionNamespace getVariable [_EH_fnc, {}]
        } else {
            format ["%1 call %2", _params, _EH_fnc]
        }
    ]
];

if ((toLower _EH_name) in ["killed", "handledamage", "hit"]) then { // Those EH are only trigger where object is local
    _EH_IDs pushBack (
        [_object, "Local", {
            params ["_entity", "_isLocal"];

            if !(_isLocal) then {
                _thisArgs params [
                    ["_EH_name", "", [""]],
                    ["_EH_fnc", "", [""]],
                    ["_params", [], [[]]]
                ];

                if !(isServer) then { // Keep EH on server in case owner drop connection
                    [_entity, _EH_name, _EH_fnc, false] call btc_fnc_eh_removePersistOnLocalityChange;
                } else {
                    [_entity, _EH_name, _EH_fnc, _params] remoteExecCall ["btc_fnc_eh_persistOnLocalityChange", _entity];
                };
            };
        }, [_EH_name, _EH_fnc, _params]] call CBA_fnc_addBISEventHandler
    );
};

if (btc_debug_log) then {
    [format ["%1: EH = %2, fnc = %3, isRE = %4", _object, _EH_name, _EH_fnc, isRemoteExecuted], __FILE__, [false]] call btc_fnc_debug_message;
};

_object setVariable [
    _EH_fnc + _EH_name,
    _EH_IDs
];

_EH_IDs
