
/* ----------------------------------------------------------------------------
Function: btc_door_fnc_get

Description:
    Get door in front of an object.

Parameters:
    _distance - Distance to check intersect. [Number]
    _object - From which ojects. [Object]
    _offset - Off set for explosive. [Number]

Returns:

Examples:
    (begin example)
        [2] call btc_door_fnc_get;
    (end)

Author:
    commy2

---------------------------------------------------------------------------- */

params [
    "_distance",
    ["_object", cameraOn, [objNull]],
    ["_offset", 0, [0]]
];

private _position0 = _object modelToWorld [0, 0, _offset];
private _position1 = _object modelToWorld [0, _distance, _offset];

private _intersections = lineIntersectsSurfaces [AGLToASL _position0, AGLToASL _position1, _object, objNull, true, 1, "GEOM"];

if (_intersections isEqualTo []) exitWith {[objNull, ""]};

private _house = _intersections select 0 select 2;

// shithouse is bugged
if (typeOf _house == "") exitWith {[objNull, ""]};

_intersections = [_house, "GEOM"] intersect [_position0, _position1];

private _door = toLower (_intersections select 0 select 0);

if (isNil "_door") exitWith {[_house, ""]};

//Check if door is glass because then we need to find the proper location of the door so we can use it
if ((_door find "glass") != -1) then {
    _door = [_distance, _house, _door] call ace_interaction_fnc_getGlassDoor;
};

if (isNil "_door") exitWith {[_house, ""]};

[_house, _door]