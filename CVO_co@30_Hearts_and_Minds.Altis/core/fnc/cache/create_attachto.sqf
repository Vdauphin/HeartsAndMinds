
/* ----------------------------------------------------------------------------
Function: btc_cache_fnc_create_attachto

Description:
    Attach holder to an object at the desired position.

Parameters:
    _object - Object where holders are attached. [Object]
    _holder - Object attached to _object [Object]
    _pos_type - Position ("TOP", "FRONT", "CORNER_L", "CORNER_R") where holder will be attached to object. [String]
    _offSet - Add verticale offset. [Number]

Returns:

Examples:
    (begin example)
        [btc_cache_obj, "groundWeaponHolder" createVehicle btc_cache_obj, "TOP"] call btc_cache_fnc_create_attachto;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_object", objNull, [objNull]],
    ["_holder", objNull, [objNull]],
    ["_pos_type", "", [""]],
    ["_offSet", 0, [0]]
];

private _bbr = (boundingBoxReal _object) params ["_p1", "_p2"];
private _height_box = abs ((_p2 select 2) - (_p1 select 2));
private _maxWidth_box = abs ((_p2 select 0) - (_p1 select 0));
private _corner_box = abs ((_p2 select 2) - (_p1 select 2)); 

private _bbr = (boundingBoxReal _object) params ["_p1", "_p2"];
private _height_weapon = abs ((_p2 select 2) - (_p1 select 2));

private _y = 0;
private _p = 0;
private _r = 0;

switch (_pos_type) do {
    case "FRONT": {
        _holder attachTo [_object, [- _maxWidth_box/6, 0, _height_weapon/2 - 0.15]];
        _y = 90;
        _p = -10;
        _r = 90;
    };
    case "CORNER_L": {
        _holder attachTo [_object, [- _maxWidth_box/6.5, _corner_box/2, _height_weapon/2 - 0.15]];
        _y = -70;
        _p = 10;
        _r = 90;
    };
    case "CORNER_R": {
        _holder attachTo [_object, [- _maxWidth_box/6.5, -_corner_box/2, _height_weapon/2 - 0.15]];
        _y = -110;
        _p = 10;
        _r = 90;
    };
    default { // TOP
        _holder attachTo [_object, [0, 0, _height_box/2 + 0.02 + _offSet]];
        _y = random 180;
        _p = 90;
        _r = 0;
    };
};

_holder setVectorDirAndUp [[ sin _y * cos _p, cos _y * cos _p, sin _p], [[ sin _r, -sin _p, cos _r * cos _p], -_y] call BIS_fnc_rotateVector2D];
