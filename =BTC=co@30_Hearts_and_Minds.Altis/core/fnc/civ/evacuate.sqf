
/* ----------------------------------------------------------------------------
Function: btc_civ_fnc_evacuate

Description:
    Evacuate civlians around a position in an area of 200 to a safe position.

Parameters:
    _position - Position to search for cilivians in a area of 200. [Array]
    _position_evac - Safe position where civilians will move to. [Array]

Returns:
    _civilians - Civlians found. [Array]
Examples:
    (begin example)
        _civilians = [getPos player] call btc_civ_fnc_evacuate;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_position", [], [[]]],
    ["_position_evac", [], [[]]]
];

private _civilians = (units civilian) inAreaArray [_position, 200, 200];

if (_position_evac isEqualTo []) then {
    private _safe = (nearestTerrainObjects [_position, ["CHURCH", "CHAPEL"], 400]);
    if (_safe isEqualTo []) then {
        _position_evac = [_position, 0, 500, 30, 0, 60 * (pi / 180), 0] call BIS_fnc_findSafePos;
        _position_evac set [2, 0];
    } else {
        private _safe_building = _safe select 0;
        if ((_safe_building buildingPos -1) isEqualTo []) then {
            _position_evac = _safe_building getPos [((boundingBox _safe_building) select 1 select 0) + 10, getDir _safe_building];
        } else {
            _position_evac = getPos _safe_building;
        };
    };
};

{
    [group _x, _position_evac, 20] call btc_civ_fnc_addWP;
} forEach _civilians;

_civilians
