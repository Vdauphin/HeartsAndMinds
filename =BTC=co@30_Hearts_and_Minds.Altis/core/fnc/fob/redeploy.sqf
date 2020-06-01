
/* ----------------------------------------------------------------------------
Function: btc_fnc_fob_redeploy

Description:
    Show user interface of the map with FOB position.

Parameters:

Returns:

Examples:
    (begin example)
        [] spawn btc_fnc_fob_redeploy;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

btc_int_ask_data = nil;
["btc_fobs"] remoteExecCall ["btc_fnc_int_ask_var", 2];

waitUntil {!(isNil "btc_int_ask_data")};

private _fobs_marker = [];
private _fobs_markerText = [];
private _fobs_structure = [];
private _fobs_texts = [];
{
    private _structure = (btc_int_ask_data select 1) select _forEachIndex;
    if ((_x in allMapMarkers) || !(isNull _structure) && (_structure inArea [_structure getVariable ["btc_fob_rallypointPos", [0, 0]], 1, 1, 0, false])) then {
        _fobs_marker pushBack _x;
        _fobs_markerText pushBack (if (_x in allMapMarkers) then {
            markerText _x;
        } else {
            getText (configfile >> "CfgVehicles" >> typeOf _structure >> "displayName")
        });
        _fobs_structure pushBack _structure;

        private _fobs_ticket = _structure getVariable ["btc_tickets", -1];
        _fobs_texts pushBack (if (_fobs_ticket isEqualTo -1) then {
            format [localize "STR_BTC_HAM_O_FOB_REDEPLOY_H_MOVING", markerText _x]
        } else {
            format [localize "STR_BTC_HAM_O_FOB_REDEPLOY_H_MOVING" + "<br/>%2: " + localize "str_a3_rscdisplaycampaignlobby_respawn_tooltip", markerText _x, _fobs_ticket]
        });
    };
} forEach (btc_int_ask_data select 0);

if (_fobs_marker isEqualTo []) exitWith {
    (localize "STR_BTC_HAM_O_FOB_REDEPLOY_H_NOFOB") call CBA_fnc_notify;
};

private _respawn_positions = _fobs_structure apply {
    private _positions = _x buildingPos -1;
    if (_positions isEqualTo []) then {
        private _pos = _x getPos [1.5, getDir _x];
        _pos set [
            2,
            ([getPosATL _x, getPosASL _x] select (surfaceIsWater _pos)) select 2
        ];
        _pos
    } else {
        private _availablePos = _positions select {_x select 2 < 1};
        if (_availablePos isEqualTo []) then {
            selectRandom _positions
        } else {
            selectRandom _availablePos
        };
    };
};

private _EHid = ["btc_respawn", {
    _this params ["_pos", "_structure"];

    if (surfaceIsWater _pos) then {
        player setPosASL _pos;
    } else {
        player setPosATL _pos;
    };

    private _ticket = _structure getVariable ["btc_tickets", -1];
    if !(_ticket isEqualTo -1) then {
        _ticket = _ticket - 1;
        if (_ticket <= 0) then {
            [_structure, objNull, objNull, true, true] remoteExecCall ["btc_fnc_fob_killed", 2];
        } else {
            _structure setVariable ["btc_tickets", _ticket, true];
        };
    };
}] call CBA_fnc_addEventHandler;

private _missionsData = [];
{
    _missionsData pushBack [
        position _x,
        {["btc_respawn", _this select 9] call CBA_fnc_localEvent;},
        _fobs_markerText select _forEachIndex,
        _fobs_texts select _forEachIndex,
        "",
        getText (configfile >> "CfgVehicles" >> typeOf _x >> "editorPreview"),
        1,
        [_respawn_positions select _forEachIndex, _x]
    ]
} forEach _fobs_structure;

disableserialization;
(date call BIS_fnc_sunriseSunsetTime) params ["_sunrise", "_sunset"];

private _parentDisplay = [] call bis_fnc_displayMission;
private _mapCenter = getMarkerPos btc_respawn_marker;
private _ORBAT  = [];
private _markers = [];
private _images = [];
private _overcast = overcast;
private _isNight = !((_sunrise < dayTime) && (_sunset > dayTime));
private _scale = 1;
private _simul = true;

{
    _x setMarkerAlphaLocal 0;
} forEach _fobs_marker;

private _display = [
    _parentDisplay,
    _mapCenter,
    _missionsData,
    _ORBAT,
    _markers,
    _images,
    _overcast,
    _isNight,
    _scale,
    _simul,
    localize "$STR_BTC_HAM_O_FOB_REDEPLOY_LABEL",
    true
] call btc_fnc_strategicMapOpen;

_display displayaddeventhandler [
    "unload",
    format [
        "
            {
                _x setMarkerAlphaLocal 1;
            } forEach %1;
            ['btc_respawn', %2] call CBA_fnc_removeEventHandler;
        ",
        _fobs_marker,
        _EHid
    ]
];
