
/* ----------------------------------------------------------------------------
Function: btc_info_fnc_has_intel

Description:
    Check if the body or object have intel.

Parameters:
    _body - Body or object to check. [Object]
    _asker - Player asking for intel. [Object]

Returns:

Examples:
    (begin example)
        [cursorObject, player] remoteExecCall ["btc_info_fnc_has_intel", 2];
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_body", objNull, [objNull]],
    ["_asker", objNull, [objNull]]
];

if (btc_debug_log) then {
    [format ["%1", _body getVariable "intel"], __FILE__, [false]] call btc_debug_fnc_message;
};

if (
    _body isKindOf "Items_base_F" || (
    _body getVariable ["intel", false] &&
    !(_body getVariable ["btc_already_interrogated", false]))
) then {
    _body setVariable ["intel", false];
    if (_body isKindOf "Items_base_F") then {
        _body call CBA_fnc_deleteEntity;
    };
    if (isServer) then    {
        [_asker] call btc_info_fnc_give_intel;
    } else {
        [_asker] remoteExecCall ["btc_info_fnc_give_intel", 2];
    };
} else {
    [3] remoteExecCall ["btc_fnc_show_hint", _asker];
};
