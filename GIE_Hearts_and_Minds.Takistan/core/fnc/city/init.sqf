
/* ----------------------------------------------------------------------------
Function: btc_city_fnc_init

Description:
    Create cities all over the map and store those properties.

Parameters:
    _density_of_occupiedCity - Density of occupied city. [Number]

Returns:

Examples:
    (begin example)
        [] call btc_city_fnc_init;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_density_of_occupiedCity", btc_p_density_of_occupiedCity, [0]]
];

private _locations = configfile >> "cfgworlds" >> worldname >> "names";

private _citiesType = ["NameVillage", "NameCity", "NameCityCapital", "NameLocal", "Hill", "Airport", "StrongpointArea", "BorderCrossing", "VegetationFir"];
if (btc_p_sea) then {_citiesType pushBack "NameMarine";};

btc_city_all = createHashMap;
for "_id" from 0 to (count _locations - 1) do {
    private _current = _locations select _id;

    private _type = getText (_current >> "type");

    if (_type in _citiesType) then {
        private _position = getArray (_current >> "position");
        if (
            surfaceIsWater _position &&
            {_type isNotEqualTo "NameMarine"} &&
            {getTerrainHeightASL _position < - 1}
        ) then {
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
        private _name = getText(_current >> "name");
        private _cachingRadius = getNumber(_current >> "RadiusA") + getNumber(_current >> "RadiusB");
        _cachingRadius = (_cachingRadius max 160) min 800;

        if (btc_city_blacklist find _name >= 0) exitWith {};

        /*
        //if you want a safe area
        if ((getMarkerPos "YOUR_MARKER_AREA") inArea [_position, 500, 500, 0, false]) exitWith {};
        */

        [_position, _type, _name, _cachingRadius, false, _id] call btc_city_fnc_create;
    };
};

private _cities = values btc_city_all;
[_cities, true] call CBA_fnc_shuffle;
private _numberOfCity = round ((count _cities) * _density_of_occupiedCity);
{
    _x setVariable ["occupied", true];
    if (btc_debug) then {
        (format ["loc_%1", _x getVariable "id"]) setMarkerColor "colorRed";
    };
} forEach (_cities select [0, _numberOfCity]);

if !(isNil "btc_custom_loc") then {
    {_x call btc_city_fnc_create;} forEach btc_custom_loc;
};
