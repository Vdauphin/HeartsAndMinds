
/* ----------------------------------------------------------------------------
Function: btc_fnc_eh_handledisconnect

Description:
    Delete headless.

Parameters:
    _headless - Headless object. [Object]

Returns:

Examples:
    (begin example)
        [headless] call btc_fnc_eh_handledisconnect;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_headless", objNull, [objNull]]
];

if (_headless in (entities "HeadlessClient_F")) then {
    //Remove HC player when disconnect
    deleteVehicle _headless;
};
