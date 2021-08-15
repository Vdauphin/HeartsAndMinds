
/* ----------------------------------------------------------------------------
Function: btc_debug_fnc_graph

Description:
    https://forums.bohemia.net/forums/topic/204157-display-graph-in-dialog/

Parameters:
    _display - [Display]

Returns:

Examples:
    (begin example)
        _result = [] call btc_debug_fnc_graph;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

disableSerialization;

params [
    ["_display", displayNull, [displayNull]]
];

private _GRPframes = _display displayCtrl 9901;
private _TXTfps = _display displayCtrl 1000;
private _TXTunits = _display displayCtrl 1002;
private _barArray = [];
private _maxFps = 60;
private _maxWidth = ctrlPosition _GRPframes select 2;
private _width = _maxWidth/300;

[btc_debug_fnc_fps, [0.5, 0.1] select (isServer), [_display, _maxFps, _maxWidth, _width, _barArray, _GRPframes, _TXTfps]] call CBA_fnc_addPerFrameHandler;

[btc_debug_fnc_units, 1, [_display, _TXTunits]] call CBA_fnc_addPerFrameHandler;
