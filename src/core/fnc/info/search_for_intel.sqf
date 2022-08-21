
/* ----------------------------------------------------------------------------
Function: btc_info_fnc_search_for_intel

Description:
    Search a body for intel.

Parameters:
    _target - Body to search. [Object]

Returns:

Examples:
    (begin example)
        _result = [] call btc_info_fnc_search_for_intel;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_target", objNull, [objNull]]
];

private _radius = 7;
if (_target isKindOf "Man") then {_radius = 4;};
if (_target isKindOf "Helicopter") then {_radius = 20;};

private _onFinish = {
    params ["_args"];
    _args params ["_target", "_player"];

    [_target, _player] remoteExecCall ["btc_info_fnc_has_intel", 2];
};
private _condition = {
    params ["_args"];
    _args params ["_target", "_player", "_radius"];

    (_target distance _player < _radius) && {[_player, objNull, ["isnotinside"]] call ace_common_fnc_canInteractWith}
};

[localize "STR_BTC_HAM_CON_INFO_SEARCH_BAR", btc_int_search_intel_time, _condition, _onFinish, {}, [_target, player, _radius]] call CBA_fnc_progressBar;
