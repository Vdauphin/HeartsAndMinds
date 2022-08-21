
/* ----------------------------------------------------------------------------
Function: btc_body_fnc_dogtagGet

Description:
    Get ACE dogtag data and player UID.

Parameters:
    _deadBody - Dead body or body bag. [Object]

Returns:

Examples:
    (begin example)
        [cursorObject] call btc_body_fnc_dogtagGet;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_unit", objNull, [objNull]]
];

[
    _unit call ace_dogtags_fnc_getDogtagData,
    !isNull (_unit getVariable ["ace_dogtags_dogtagTaken", objNull]),
    _unit getVariable ["btc_UID", ""]
]
