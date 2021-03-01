
/* ----------------------------------------------------------------------------
Function: btc_fnc_city_init

Description:
    Create cities all over the map and store those properties.

Parameters:
    _is_free_probability - Probability for a city to have military. [Number]

Returns:

Examples:
    (begin example)
        [] call btc_fnc_city_init;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_is_free_probability", btc_p_is_free_prob, [0]]
];

private _locations = configfile >> "cfgworlds" >> worldname >> "names";

private _cities = ["NameVillage", "NameCity", "NameCityCapital", "NameLocal", "Hill", "Airport", "StrongpointArea", "BorderCrossing", "VegetationFir"];
if (btc_p_sea) then {_cities pushBack "NameMarine";};

btc_city_all = [];

for "_id" from 0 to (count _locations - 1) do {
    private _current = _locations select _id;

    private _type = getText (_current >> "type");

    if (_type in _cities) then {
        private _position = getArray (_current >> "position");
        if (surfaceIsWater _position) then {
            if !(_type isEqualTo "NameMarine") then {
                private _church = nearestTerrainObjects [_position, ["CHURCH"], 470];
                if (_church isEqualTo []) then {
                    private _area = 50;
                    for "_i" from 0 to 3 do {
                        private _new_position = [_position, 0, _area, 0.5, 0, -1, 0] call BIS_fnc_findSafePos;
                        if (count _new_position isEqualTo 2) exitWith {
                            _position = _new_position;
                        };
                        _area = _area * 2;
                    };
                } else {
                    _position = getPos (_church select 0);
                };
            };
        };
        private _name = getText(_current >> "name");
        private _radius = getNumber(_current >> "RadiusA") + getNumber(_current >> "RadiusB");
        _radius = (_radius max 160) min 800;

        if (btc_city_blacklist find _name >= 0) exitWith {};

        /*
        //if you want a safe area
        if ((getMarkerPos "YOUR_MARKER_AREA") inArea [_position, 500, 500, 0, false]) exitWith {};
        */

        [_position, _type, _name, _radius, random 1 > _is_free_probability, _id] call btc_fnc_city_create;
    };
};

if !(isNil "btc_custom_loc") then {
    {_x call btc_fnc_city_create;} forEach btc_custom_loc;
};

btc_city_all = btc_city_all apply {if (isNil "_x") then {objNull} else {_x}};
