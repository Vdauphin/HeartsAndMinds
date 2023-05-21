
/* ----------------------------------------------------------------------------
Function: btc_fnc_final_phase

Description:
    Start the final mission process by waiting until all cities are free, then trigger the mission end.

Parameters:

Returns:

Examples:
    (begin example)
        [] call btc_fnc_final_phase;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

["btc_dty", "SUCCEEDED"] call BIS_fnc_taskSetState;
[["btc_sze", "btc_m"], 2] call btc_task_fnc_create;

btc_final_phase = true;

btc_city_remaining = [];
{
    if (_y getVariable ["type", ""] != "NameMarine") then {
        if (_y getVariable ["marker", ""] != "") then {
            deleteMarker (_y getVariable ["marker", ""]);
        };
        private _cachingRadius = _y getVariable ["cachingRadius", 500];

        private _marker = createMarker [format ["city_%1", position _y], position _y];
        _marker setMarkerShape "ELLIPSE";
        _marker setMarkerBrush "SolidBorder";
        _marker setMarkerSize [_cachingRadius, _cachingRadius];
        _marker setMarkerAlpha 0.3;
        if (_y getVariable ["occupied", false]) then {
            _marker setMarkerColor "colorRed";
            btc_city_remaining pushBack _y;
        } else {
            _marker setMarkerColor "colorGreen";
            _marker setMarkerAlpha 0;
        };
        _y setVariable ["marker", _marker];
    };
} forEach btc_city_all;

waitUntil {sleep 15; (btc_city_remaining isEqualTo [])};

["btc_m", "SUCCEEDED"] call btc_task_fnc_setState;

//END
[] remoteExec ["btc_fnc_end_mission", 0, true];
