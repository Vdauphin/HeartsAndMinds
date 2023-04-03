
/* ----------------------------------------------------------------------------
Function: btc_fnc_road_direction

Description:
    Found road direction.

Parameters:
    _road - Road to find the direction. [Object]

Returns:
	_direction - Direction of the road. [Number]

Examples:
    (begin example)
        _direction = [(nearRoads player) select 0] call btc_fnc_road_direction;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_road", objNull, [objNull]]
];

private _info = getRoadInfo _road;
(_info select 6) getDir (_info select 7)
