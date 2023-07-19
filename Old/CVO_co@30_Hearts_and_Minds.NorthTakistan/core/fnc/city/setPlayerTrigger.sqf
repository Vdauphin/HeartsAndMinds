
/* ----------------------------------------------------------------------------
Function: btc_city_fnc_setPlayerTrigger

Description:
    Set trigger properties to detect player presence.

Parameters:
    _trigger - City. [Object]
    _cachingRadius - Radius of the location. [Number]

Returns:

Examples:
    (begin example)
        [_trigger, _cachingRadius] call btc_city_fnc_setPlayerTrigger;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_trigger", objNull, [objNull]],
    ["_cachingRadius", 0, [0]]
];

_trigger setTriggerArea [_cachingRadius + btc_city_radiusOffset, _cachingRadius + btc_city_radiusOffset, 0, false, 800];
_trigger setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_trigger setTriggerStatements [btc_p_trigger, "thisTrigger call btc_city_fnc_activate", "thisTrigger call btc_city_fnc_de_activate"];

if (btc_debug) then {
    private _id = _trigger getVariable "id";
    private _has_en = _trigger getVariable "occupied";
    private _name = _trigger getVariable "name";
    private _type = _trigger getVariable "type";

    private _marker = createMarker [format ["loc_%1", _id], _trigger];
    _marker setMarkerShape "ELLIPSE";
    _marker setMarkerBrush "SolidBorder";
    _marker setMarkerSize [_cachingRadius + btc_city_radiusOffset, _cachingRadius + btc_city_radiusOffset];
    _marker setMarkerAlpha 0.3;
    _marker setMarkerColor (["colorGreen", "colorRed"] select _has_en);
    _trigger setVariable ["marker", _marker];

    private _marke = createMarker [format ["locn_%1", _id], _trigger];
    _marke setMarkerType "Contact_dot1";
    private _spaces = "";
    for "_i" from 0 to count _name -1 do {
        _spaces = _spaces + " ";
    };
    _marke setMarkerText format [_spaces + "%1 ID %2 - %3", _type, _id, _trigger getVariable ["hasbeach", "empty"]];
};
