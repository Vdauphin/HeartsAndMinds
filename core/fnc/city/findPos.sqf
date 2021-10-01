
/* ----------------------------------------------------------------------------
Function: btc_fnc_city_findPos

Description:
    Find a random and safe position in a city (not inside rock).

Parameters:
    _city - City object or position search for a random and safe position. [Object, Array]
    _area - Size of the area to search. [Number]
    _p_sea - Allow position in water. [Boolean]

Returns:
    _rpos - [Array]
    _pos_iswater - [Boolean]

Examples:
    (begin example)
        _results = [[0, 0, 0], 100, true] call btc_fnc_city_findPos;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_city", objNull, [objNull, []]],
    ["_area", 300, [0]],
    ["_p_sea", btc_p_sea, [true]]
];

if (_city isEqualType objNull) then {
    _city = position _city;
};

private _rpos = [_city, _area, _p_sea] call btc_fnc_randomize_pos;

private _pos_iswater = surfaceIsWater _rpos;
if !(_pos_iswater) then {
    private _newpos = _rpos findEmptyPosition [0, 40, "B_soldier_AR_F"];
    if !(_newpos isEqualTo []) then {
        _rpos = _newpos;
    };
    _rpos = [_rpos] call btc_fnc_findPosOutsideRock;
};

[_rpos, _pos_iswater]
