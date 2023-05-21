
/* ----------------------------------------------------------------------------
Function: btc_log_fnc_place_create_camera

Description:
    Fill me when you edit me !

Parameters:
    _terminal - [Object]
    _campos - [Array]

Returns:

Examples:
    (begin example)
        _result = [] call btc_log_fnc_place_create_camera;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_terminal", objNull, [objNull]],
    ["_campos", [0, 0, 0], [[]]]
];

_terminal setObjectTexture [0, "#(argb,512,512,1)r2t(uavrtt,1)"];

/* create camera and stream to render surface */
private _cam = "camera" camCreate _campos;
_cam cameraEffect ["Internal", "Back", "uavrtt"];

private _y = -180;
private _p = 50;
private _r = 0;
_cam setVectorDirAndUp [
    [ sin _y * cos _p, cos _y * cos _p, sin _p],
    [[ sin _r,-sin _p, cos _r * cos _p], -_y] call BIS_fnc_rotateVector2D
];

btc_log_place_camera = _cam;
btc_log_place_camera_created = true;
