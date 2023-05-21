
/* ----------------------------------------------------------------------------
Function: btc_log_fnc_get_corner_points

Description:
    Fill me when you edit me !

Parameters:
    _vehicle - [Object]

Returns:

Examples:
    (begin example)
        _result = [cursorObject] call btc_log_fnc_get_corner_points;
    (end)

Author:
    sethduda

---------------------------------------------------------------------------- */

params [
    ["_vehicle", objNull, [objNull]]
];

// Correct width and length factor for air
private _widthFactor = 0.75;
private _lengthFactor = 0.75;
if (_vehicle isKindOf "Air") then {
    _widthFactor = 0.3;
};
if (_vehicle isKindOf "Helicopter") then {
    _widthFactor = 0.2;
    _lengthFactor = 0.45;
};

(getCenterOfMass _vehicle) params ["_centerOfMass_x", "_centerOfMass_y", "_centerOfMass_z"];
(boundingBoxReal _vehicle) params ["_p1", "_p2"];
([0, 1] apply {abs ((_p2 select _x) - (_p1 select _x))}) params ["_maxWidth", "_maxLength"];
(0 boundingBoxReal _vehicle) params ["_p1", "_p2"];

private _widthOffset = ((_maxWidth / 2) - abs _centerOfMass_x) * _widthFactor;
private _lengthOffset = ((_maxLength / 2) - abs _centerOfMass_y) * _lengthFactor;
private _rearCorner = [_centerOfMass_x + _widthOffset, _p1 select 1, _centerOfMass_z];
private _rearCorner2 = [_centerOfMass_x - _widthOffset, _p1 select 1, _centerOfMass_z];
private _frontCorner = [_centerOfMass_x + _widthOffset, _centerOfMass_y + _lengthOffset, _centerOfMass_z];
private _frontCorner2 = [_centerOfMass_x - _widthOffset, _centerOfMass_y + _lengthOffset, _centerOfMass_z];

if (btc_debug) then {
    _vehicle call {
        private ["_obj","_bb","_bbx","_bby","_bbz","_arr","_y","_z"];
        _obj = _this;
        _bb = {
            _bbx = [_this select 0 select 0, _this select 1 select 0];
            _bby = [_this select 0 select 1, _this select 1 select 1];
            _bbz = [_this select 0 select 2, _this select 1 select 2];
            _arr = [];
            0 = {
                _y = _x;
                0 = {
                    _z = _x;
                    0 = {
                        0 = _arr pushBack (_obj modelToWorld [_x,_y,_z]);
                    } count _bbx;
                } count _bbz;
                reverse _bbz;
            } count _bby;
            _arr pushBack (_arr select 0);
            _arr pushBack (_arr select 1);
            _arr
        };
        bbox = 0 boundingBoxReal _obj call _bb;
        bboxr = [_rearCorner, _frontCorner2] call _bb;
        addMissionEventHandler ["Draw3D", {
            for "_i" from 0 to 7 step 2 do {
                drawLine3D [
                    bbox select _i,
                    bbox select (_i + 2),
                    [0,0,1,1]
                ];
                drawLine3D [
                    bboxr select _i,
                    bboxr select (_i + 2),
                    [0,1,0,1]
                ];
                drawLine3D [
                    bbox select (_i + 2),
                    bbox select (_i + 3),
                    [0,0,1,1]
                ];
                drawLine3D [
                    bboxr select (_i + 2),
                    bboxr select (_i + 3),
                    [0,1,0,1]
                ];
                drawLine3D [
                    bbox select (_i + 3),
                    bbox select (_i + 1),
                    [0,0,1,1]
                ];
                drawLine3D [
                    bboxr select (_i + 3),
                    bboxr select (_i + 1),
                    [0,1,0,1]
                ];
            };
        }];
    };
};

[_rearCorner, _rearCorner2, _frontCorner, _frontCorner2];
