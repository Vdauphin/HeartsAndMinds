
/* ----------------------------------------------------------------------------
Function: btc_city_fnc_trigger_player_side

Description:
    Create a trigger to detect player presence around a position.

Parameters:
    _city - Position where the trigger is created. [Object]
    _cachingRadius - Radius of the location. [Number]
    _city - City object where the trigger will be stored. [Object]
    _has_en - City is occupied. [Boolean]
    _name - Name of the city. [String]
    _type - Type of the city. [String]
    _id - ID of the city. [Number]

Returns:

Examples:
    (begin example)
        [_city, _cachingRadius, _city, _has_en, _name, _type, _id] call btc_city_fnc_trigger_player_side;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_city", objNull, [objNull]],
    ["_cachingRadius", 0, [0]],
    ["_city", objNull, [objNull]],
    ["_has_en", false, [false]],
    ["_name", "", [""]],
    ["_type", "", [""]],
    ["_id", 0, [0]]
];

private _trigger = createTrigger ["EmptyDetector", _city, false];
_trigger setTriggerArea [_cachingRadius + btc_city_radiusOffset, _cachingRadius + btc_city_radiusOffset, 0, false, 800];
_trigger setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_trigger setTriggerStatements [btc_p_trigger, format ["[%1] call btc_city_fnc_activate", _id], format ["[%1] call btc_city_fnc_de_activate", _id]];
_city setVariable ["trigger_player_side", _trigger];

if (btc_debug) then {
    private _marker = createMarker [format ["loc_%1", _id], _city];
    _marker setMarkerShape "ELLIPSE";
    _marker setMarkerBrush "SolidBorder";
    _marker setMarkerSize [_cachingRadius + btc_city_radiusOffset, _cachingRadius + btc_city_radiusOffset];
    _marker setMarkerAlpha 0.3;
    if (_has_en) then {
        _marker setMarkerColor "colorRed";
    } else {
        _marker setMarkerColor "colorGreen";
    };
    _city setVariable ["marker", _marker];

    private _marke = createMarker [format ["locn_%1", _id], _city];
    _marke setMarkerType "Contact_dot1";
    private _spaces = "";
    for "_i" from 0 to count _name -1 do {
        _spaces = _spaces + " ";
    };
    _marke setMarkerText format [_spaces + "%1 ID %2 - %3", _type, _id, _city getVariable ["hasbeach", "empty"]];
};
