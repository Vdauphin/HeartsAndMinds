
/* ----------------------------------------------------------------------------
Function: btc_fnc_findposoutsiderock

Description:
    Found position outside rock.

Parameters:
    _rpos - Position to check. [Array]

Returns:
    _rpos - New position outside rock.

Examples:
    (begin example)
        _rpos = [getPos player] call btc_fnc_findposoutsiderock;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_rpos", [0, 0, 0], [[]]]
];
_rpos params ["_x", "_y"];

private _objects = lineIntersectsObjs [[_x, _y, (getTerrainHeightASL _rpos) + 1], [_x, _y, (getTerrainHeightASL _rpos) + 100], objNull, objNull, false, 16];

if (_objects isEqualTo []) exitWith {_rpos};

private _object = _objects select 0;
if (_object in nearestTerrainObjects [_object, ["HIDE", "ROCK", "ROCKS"], 1]) then {
    private _roads = _rpos nearRoads 100;
    if (_roads isEqualTo []) then {
        _rpos = [_rpos, 5, 50, 10, false] call btc_fnc_findsafepos;
    } else {
        _rpos = getPos (_roads select 0);
    };
};

if (btc_debug_log) then {
    _objects = lineIntersectsObjs [[_x, _y, (getTerrainHeightASL _rpos) + 1], [_x, _y, (getTerrainHeightASL _rpos) + 100], objNull, objNull, false, 16];
    if (_objects isNotEqualTo []) then {
        _object = _objects select 0;
        if (_object in nearestTerrainObjects [_object, ["HIDE", "ROCK", "ROCKS"], 1]) then {
            [format ["POS %1 Still inside rock", _rpos], __FILE__, [false]] call btc_debug_fnc_message;
            if (btc_debug) then {
                ["Still inside rock", __FILE__, [btc_debug, false]] call btc_debug_fnc_message;
                private _marker = createMarker [format ["btc_inrock_%1", _rpos], _rpos];
                _marker setMarkerType "mil_unknown";
                _marker setMarkerText "In rock";
                _marker setMarkerSize [0.5, 0.5];
            };
        };
    };
};

_rpos
