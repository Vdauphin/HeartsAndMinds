
/* ----------------------------------------------------------------------------
Function: btc_debug_fnc_fps

Description:
    Fill me when you edit me !

Parameters:
    _args - [Array]
    _id - [Number]

Returns:

Examples:
    (begin example)
        _result = [] call btc_debug_fnc_fps;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_args", [], [[]]],
    ["_id", 0, [0]]
];
_args params ["_display", "_maxFps", "_maxWidth", "_width", "_barArray", "_GRPframes", "_TXTfps"];

if (isNull _display || !btc_debug_graph) exitWith {
    [_id] call CBA_fnc_removePerFrameHandler;
    _display closeDisplay 1;
};

[11, objNull, "btc_debug_frames"] remoteExecCall ["btc_int_fnc_ask_var", 2];
private _frames = btc_debug_frames;
_TXTfps ctrlSetText format ["SERVER FPS: %1", _frames];

private _newBar = _display ctrlCreate ["RscVProgress", -1, _GRPframes];
private _arraysize = count _barArray -1;
{
    _x ctrlSetPosition [_maxWidth - ((_arraysize - _forEachIndex + 2) * _width), 0];
    _x ctrlCommit 0;
} forEach _barArray;
_barArray pushBack _newBar;
_newBar ctrlSetPosition [
    _maxWidth-_width,
    0,
    _width,
    0.252 * safezoneH
];

private _firstCtrl = _barArray select 0;
_newBar ctrlCommit 0;
_newBar progressSetPosition (_frames/_maxFps);
if ((ctrlPosition _firstCtrl) select 0 < 0) then {
    ctrlDelete _firstCtrl;
    _barArray deleteAt 0;
};
