
/* ----------------------------------------------------------------------------
Function: btc_spect_fnc_disableDevice

Description:
    Disable spectrum device.

Parameters:

Returns:

Examples:
    (begin example)
        [] call btc_spect_fnc_disableDevice;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

if (btc_spect_updateOn < 0) exitWith {};

[btc_spect_updateOn] call CBA_fnc_removePerFrameHandler;
btc_spect_updateOn = -1;

{missionNamespace setVariable _x} forEach [
    ["#EM_FMin", nil],
    ["#EM_FMax", nil],
    ["#EM_SMin", nil],
    ["#EM_SMax", nil],
    ["#EM_Values", nil],
    ["#EM_Transmit", nil],
    ["#EM_Progress", nil],
    ["#EM_Prev", nil],
    ["#EM_Spectrum", nil]
];
