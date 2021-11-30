
/* ----------------------------------------------------------------------------
Function: btc_door_fnc_break

Description:
    Break locked door action.

Parameters:

Returns:

Examples:
    (begin example)
        [] call btc_door_fnc_break;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

([2] call ace_interaction_fnc_getDoor) params ["_house", "_door"];
if (_door isEqualTo "") exitWith {
    (localize "STR_BTC_HAM_O_DOOR_NO") call CBA_fnc_notify;
};

[localize "STR_BTC_HAM_O_DOOR_BREAKING", btc_door_breaking_time, {
    [player, objNull, ["isnotinside"]] call ace_common_fnc_canInteractWith
}, {
    params ["_args"];
    _args call btc_door_fnc_broke;
}, {}, [_house, _door]] call CBA_fnc_progressBar;
