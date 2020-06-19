
/* ----------------------------------------------------------------------------
Function: btc_fnc_db_save

Description:
    Save the current game into profileNamespace.

Parameters:
    _name - Name of the game saved. [String]

Returns:

Examples:
    (begin example)
        [] spawn btc_fnc_db_save;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_name", worldName, [""]]
];

if (btc_debug) then {
    ["...1", __FILE__, [btc_debug, false, true]] call btc_fnc_debug_message;
};

[8] remoteExecCall ["btc_fnc_show_hint", 0];

btc_db_is_saving = true;

{
    if (!isNull _x) then {
        private _s = [_forEachIndex] spawn btc_fnc_city_de_activate;
        waitUntil {scriptDone _s};
    };
} forEach btc_city_all;

if (btc_debug) then {
    ["...2", __FILE__, [btc_debug, false, true]] call btc_fnc_debug_message;
};

[false] call btc_fnc_db_delete;

//Version
profileNamespace setVariable [format ["btc_hm_%1_version", _name], btc_version select 1];

//World Date
profileNamespace setVariable [format ["btc_hm_%1_date", _name], date];

//City status
private _cities_status = [];
{
    private _city_status = [];
    _city_status pushBack (_x getVariable "id");

    _city_status pushBack (_x getVariable "initialized");

    _city_status pushBack (_x getVariable "spawn_more");
    _city_status pushBack (_x getVariable "occupied");

    _city_status pushBack (_x getVariable "data_units");

    _city_status pushBack (_x getVariable ["has_ho", false]);
    _city_status pushBack (_x getVariable ["ho_units_spawned", false]);
    _city_status pushBack (_x getVariable ["ieds", []]);
    _city_status pushBack (_x getVariable ["has_suicider", false]);

    _cities_status pushBack _city_status;
    if (btc_debug_log) then {
        [format ["ID %1 - IsOccupied %2", _x getVariable "id", _x getVariable "occupied"], __FILE__, [false]] call btc_fnc_debug_message;
    };
} forEach (btc_city_all select {!(isNull _x)});
profileNamespace setVariable [format ["btc_hm_%1_cities", _name], _cities_status];

//HIDEOUT
private _array_ho = [];
{
    private _data = [];
    (getPos _x) params ["_xx", "_yy"];
    _data pushBack [_xx, _yy, 0];
    _data pushBack (_x getVariable ["id", 0]);
    _data pushBack (_x getVariable ["rinf_time", 0]);
    _data pushBack (_x getVariable ["cap_time", 0]);
    _data pushBack ((_x getVariable ["assigned_to", objNull]) getVariable "id");

    private _ho_markers = [];
    {
        private _marker = [];
        _marker pushBack (getMarkerPos _x);
        _marker pushBack (markerText _x);
        _ho_markers pushBack _marker;
    } forEach (_x getVariable ["markers", []]);
    _data pushBack _ho_markers;
    if (btc_debug_log) then {
        [format ["HO %1 DATA %2", _x, _data], __FILE__, [false]] call btc_fnc_debug_message;
    };
    _array_ho pushBack _data;
} forEach btc_hideouts;
profileNamespace setVariable [format ["btc_hm_%1_ho", _name], _array_ho];

profileNamespace setVariable [format ["btc_hm_%1_ho_sel", _name], btc_hq getVariable ["id", 0]];

//CACHE
private _array_cache = [];
_array_cache pushBack (getPosATL btc_cache_obj);
_array_cache pushBack btc_cache_n;
_array_cache pushBack btc_cache_info;
private _cache_markers = [];
{
    private _data = [];
    _data pushBack (getMarkerPos _x);
    _data pushBack (markerText _x);
    _cache_markers pushBack _data;
} forEach btc_cache_markers;
_array_cache pushBack _cache_markers;
_array_cache pushBack [btc_cache_pictures select 0, btc_cache_pictures select 1, []];
profileNamespace setVariable [format ["btc_hm_%1_cache", _name], +_array_cache];

//REPUTATION
profileNamespace setVariable [format ["btc_hm_%1_rep", _name], btc_global_reputation];

//FOBS
private _fobs = [];
{
    if !(isNull ((btc_fobs select 2) select _forEachIndex)) then {
        private _pos = getMarkerPos [_x, true];
        private _direction = getDir ((btc_fobs select 1) select _forEachIndex);
        _fobs pushBack [markerText _x, _pos, _direction];
    };
} forEach (btc_fobs select 0);
profileNamespace setVariable [format ["btc_hm_%1_fobs", _name], _fobs];

//Vehicles status
private _array_veh = [];
{
    private _data = [];
    _data pushBack (typeOf _x);
    _data pushBack (getPosASL _x);
    _data pushBack (getDir _x);
    _data pushBack (fuel _x);
    _data pushBack (getAllHitPointsDamage _x);
    private _cargo = [];
    {
        _cargo pushBack (if (_x isEqualType "") then {
            [_x, "", [[], [], []]]
        } else {
            [typeOf _x, _x getVariable ["ace_rearm_magazineClass", ""], [getWeaponCargo _x, getMagazineCargo _x, getItemCargo _x], _x in btc_chem_contaminated]
        });
    } forEach (_x getVariable ["ace_cargo_loaded", []]);
    _data pushBack _cargo;
    private _cont = [getWeaponCargo _x, getMagazineCargo _x, getItemCargo _x];
    _data pushBack _cont;
    _data append ([_x] call btc_fnc_getVehProperties);
    _array_veh pushBack _data;
    if (btc_debug_log) then {
        [format ["VEH %1 DATA %2", _x, _data], __FILE__, [false]] call btc_fnc_debug_message;
    };
} forEach (btc_vehicles - [objNull]);
profileNamespace setVariable [format ["btc_hm_%1_vehs", _name], _array_veh];

//Objects status
private _array_obj = [];
{
    private _data = [_x] call btc_fnc_db_saveObjectStatus;
    if !(_data isEqualTo []) then {
        _array_obj pushBack _data;
    };
} forEach (btc_log_obj_created select {
    !(isObjectHidden _x) &&
    (objectParent _x) isEqualTo objNull
});
profileNamespace setVariable [format ["btc_hm_%1_objs", _name], _array_obj];

//Player Markers
private _player_markers = allMapMarkers select {(_x select [0, 15]) isEqualTo "_USER_DEFINED #"};
private _markers_properties = _player_markers apply {
    [markerText _x, markerPos _x, markerColor _x, markerType _x, markerSize _x, markerAlpha _x, markerBrush _x, markerDir _x, markerShape _x]
};
profileNamespace setVariable [format ["btc_hm_%1_markers", _name], _markers_properties];

//End
profileNamespace setVariable [format ["btc_hm_%1_db", _name], true];
saveProfileNamespace;
if (btc_debug) then {
    ["...3", __FILE__, [btc_debug, false, true]] call btc_fnc_debug_message;
};
[9] remoteExecCall ["btc_fnc_show_hint", 0];

btc_db_is_saving = false;
