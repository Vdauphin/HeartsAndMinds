
/* ----------------------------------------------------------------------------
Function: btc_body_fnc_dogtagSet

Description:
    Set ACE dogtag data.

Parameters:
    _deadBody - Dead body or body bag. [Object]
    _dogtagDataTaken - Dogtag data and if it has been taken. [Array]

Returns:

Examples:
    (begin example)
        [cursorObject] call btc_body_fnc_dogtagSet;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_deadBody", objNull, [objNull]],
    ["_dogtagDataTaken", [], [[]]]
];
_dogtagDataTaken params [
    ["_dogtagData", [], [[]]],
    ["_dogtagTaken", false, [false]],
    ["_UID", "", [""]]
];

if (_dogtagData isNotEqualTo []) then {
    _deadBody setVariable ["ace_dogtags_dogtagData", _dogtagData, true];
    if (_dogtagTaken) then {
        _deadBody setVariable ["ace_dogtags_dogtagTaken", _deadBody, true];
    };
    _deadBody setVariable ["btc_UID", _UID];
};
