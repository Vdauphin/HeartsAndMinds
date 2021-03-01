
/* ----------------------------------------------------------------------------
Function: btc_fnc_city_trigger_player_side

Description:
    Create a trigger to detect player presence around a position.

Parameters:
    _position - Position where the trigger is created. [Array]
    _radius - Radius of the location. [Number]
    _city - City object where the trigger will be stored. [Object]
    _has_en - City is occupied. [Boolean]
    _name - Name of the city. [String]
    _type - Type of the city. [String]
    _id - ID of the city. [Number]

Returns:

Examples:
    (begin example)
        [_position, _radius, _city, _has_en, _name, _type, _id] call btc_fnc_city_trigger_player_side;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_position", [0, 0, 0], [[]]],
    ["_radius", 0, [0]],
    ["_city", objNull, [objNull]],
    ["_has_en", false, [false]],
    ["_name", "", [""]],
    ["_type", "", [""]],
    ["_id", 0, [0]]
];

private _trigger = createTrigger ["EmptyDetector", _position];
_trigger setTriggerArea [_radius + btc_city_radius, _radius + btc_city_radius, 0, false];
_trigger setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_trigger setTriggerStatements [btc_p_trigger, format ["[%1] call btc_fnc_city_activate", _id], format ["[%1] call btc_fnc_city_de_activate", _id]];
_city setVariable ["trigger_player_side", _trigger];

if (btc_debug) then {
    private _marker = createMarker [format ["loc_%1", _id], _position];
    _marker setMarkerShape "ELLIPSE";
    _marker setMarkerBrush "SolidBorder";
    _marker setMarkerSize [_radius + btc_city_radius, _radius + btc_city_radius];
    _marker setMarkerAlpha 0.3;
    if (_has_en) then {
        _marker setMarkerColor "colorRed";
    } else {
        _marker setMarkerColor "colorGreen";
    };
    _city setVariable ["marker", _marker];

    private _marke = createMarker [format ["locn_%1", _id], _position];
    _marke setMarkerType "mil_dot";
    _marke setMarkerText format ["loc_%3 %1 %2 - [%4] - [%5]", _name, _type, _id, _has_en, _city getVariable ["hasbeach", "empty"]];
};
