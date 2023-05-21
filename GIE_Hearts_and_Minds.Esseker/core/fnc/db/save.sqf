
/* ----------------------------------------------------------------------------
Function: btc_db_fnc_save

Description:
    Save the current game into profileNamespace.

Parameters:
    _name - Name of the game saved. [String]

Returns:

Examples:
    (begin example)
        [] call btc_db_fnc_save;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_name", worldName, [""]]
];

if (btc_debug) then {
    ["...1", __FILE__, [btc_debug, false, true]] call btc_debug_fnc_message;
};

[8] remoteExecCall ["btc_fnc_show_hint", 0];

[false] call btc_db_fnc_delete;

//Version
profileNamespace setVariable [format ["btc_hm_%1_version", _name], btc_version select 1];

//World Date
profileNamespace setVariable [format ["btc_hm_%1_date", _name], date];

//City status
private _cities_status = [];
{
    private _city_status = [];
    _city_status pushBack _x;

    _city_status pushBack (_y getVariable "initialized");

    _city_status pushBack (_y getVariable "spawn_more");
    _city_status pushBack (_y getVariable "occupied");

    _city_status pushBack (_y getVariable "data_units");

    _city_status pushBack (_y getVariable ["has_ho", false]);
    _city_status pushBack (_y getVariable ["ho_units_spawned", false]);
    _city_status pushBack (_y getVariable ["ieds", []]);
    _city_status pushBack (_y getVariable ["has_suicider", false]);
    _city_status pushBack (_y getVariable ["data_animals", []]);
    _city_status pushBack (_y getVariable ["data_tags", []]);
    _city_status pushBack (_y getVariable ["btc_rep_civKilled", []]);

    _cities_status pushBack _city_status;
    if (btc_debug_log) then {
        [format ["ID %1 - IsOccupied %2", _y getVariable "id", _y getVariable "occupied"], __FILE__, [false]] call btc_debug_fnc_message;
    };
} forEach btc_city_all;
profileNamespace setVariable [format ["btc_hm_%1_cities", _name], +_cities_status];

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
        [format ["HO %1 DATA %2", _x, _data], __FILE__, [false]] call btc_debug_fnc_message;
    };
    _array_ho pushBack _data;
} forEach btc_hideouts;
profileNamespace setVariable [format ["btc_hm_%1_ho", _name], +_array_ho];

profileNamespace setVariable [format ["btc_hm_%1_ho_sel", _name], btc_hq getVariable ["id", 0]];

if (btc_debug) then {
    ["...2", __FILE__, [btc_debug, false, true]] call btc_debug_fnc_message;
};

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
_array_cache pushBack (btc_cache_obj in btc_chem_contaminated);
_array_cache pushBack (btc_cache_obj getVariable ["btc_cache_unitsSpawned", false]);
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
profileNamespace setVariable [format ["btc_hm_%1_fobs", _name], +_fobs];

//Vehicles status
private _array_veh = [];
private _vehicles = btc_vehicles - [objNull];
private _vehiclesNotInCargo = _vehicles select {
    isNull isVehicleCargo _x &&
    {isNull isVehicleCargo attachedTo _x}
};
private _vehiclesInCargo = _vehicles - _vehiclesNotInCargo;
{
    (_x call btc_db_fnc_saveObjectStatus) params [
        "_type", "_pos", "_dir", "", "_cargo",
        "_inventory", "_vectorPos", "_isContaminated", "",
        ["_flagTexture", "", [""]],
        ["_turretMagazines", [], [[]]],
        ["_notuse", "", [""]],
        ["_tagTexture", "", [""]],
        ["_properties", [], [[]]]
    ];

    private _data = [];
    _data pushBack _type;
    _data pushBack _pos;
    _data pushBack _dir;
    _data pushBack (fuel _x);
    _data pushBack (getAllHitPointsDamage _x);
    _data pushBack _cargo;
    _data pushBack _inventory;
    _data append ([_x] call btc_veh_fnc_propertiesGet);
    _data pushBack (_x getVariable ["btc_EDENinventory", []]);
    _data pushBack _vectorPos;
    _data pushBack []; // ViV
    _data pushBack _flagTexture;
    _data pushBack _turretMagazines;
    _data pushBack _tagTexture;
    _data pushBack _properties;

    private _fakeViV = isVehicleCargo attachedTo _x;
    if (
        isNull _fakeViV &&
        {isNull isVehicleCargo _x}
    ) then {
         _array_veh pushBack _data;
    } else {
        private _vehicleCargo = if (isNull _fakeViV) then {
            isVehicleCargo _x
        } else {
            _fakeViV
        };
        private _index = _vehiclesNotInCargo find _vehicleCargo;
        ((_array_veh select _index) select 16) pushBack _data;
    };

    if (btc_debug_log) then {
        [format ["VEH %1 DATA %2", _x, _data], __FILE__, [false]] call btc_debug_fnc_message;
    };
} forEach (_vehiclesNotInCargo + _vehiclesInCargo);
profileNamespace setVariable [format ["btc_hm_%1_vehs", _name], +_array_veh];

//Objects status
private _array_obj = [];
{
    if !(!alive _x || isNull _x) then {
        private _data = [_x] call btc_db_fnc_saveObjectStatus;
        _array_obj pushBack _data;
    };
} forEach (btc_log_obj_created select {
    !(isObjectHidden _x) &&
    isNull objectParent _x &&
    isNull isVehicleCargo _x
});
profileNamespace setVariable [format ["btc_hm_%1_objs", _name], +_array_obj];

//Player Tags
private _tags = btc_tags_player select {alive (_x select 0)};
private _tags_properties = _tags apply {
    private _tag = _x select 0;
    [
        getPosASL _tag,
        [vectorDir _tag, vectorUp _tag],
        _x select 1,
        typeOf (_x select 2),
        typeOf _tag
    ]
};
profileNamespace setVariable [format ["btc_hm_%1_tags", _name], +_tags_properties];

//Player respawn tickets
if (btc_p_respawn_ticketsAtStart >= 0) then {
    profileNamespace setVariable [format ["btc_hm_%1_respawnTickets", _name], +btc_respawn_tickets];

    private _deadBodyPlayers = [btc_body_deadPlayers] call btc_body_fnc_get;
    profileNamespace setVariable [format ["btc_hm_%1_deadBodyPlayers", _name], +_deadBodyPlayers];
};

//Player slots
{
    if (alive _x) then {
        _x call btc_slot_fnc_serializeState;
    };
} forEach (allPlayers - entities "HeadlessClient_F");
private _slots_serialized = +btc_slots_serialized;
{
    if (btc_debug_log) then {
        [format ["btc_slots_serialized %1 %2", _x, _y], __FILE__, [false]] call btc_debug_fnc_message;
    };
    if (_y isEqualTo []) then {continue};
    private _vehicle = _y select 6;
    if !(isNull _vehicle) then {
        _y set [0, getPosASL _vehicle];
    };
    _y set [6, typeOf _vehicle];
} forEach _slots_serialized;
profileNamespace setVariable [format ["btc_hm_%1_slotsSerialized", _name], +_slots_serialized];

//Player Markers
private _player_markers = allMapMarkers select {"_USER_DEFINED" in _x};
private _markers_properties = _player_markers apply {
    [markerText _x, markerPos _x, markerColor _x, markerType _x, markerSize _x, markerAlpha _x, markerBrush _x, markerDir _x, markerShape _x, markerPolyline _x, markerChannel _x]
};
profileNamespace setVariable [format ["btc_hm_%1_markers", _name], +_markers_properties];

//End
profileNamespace setVariable [format ["btc_hm_%1_db", _name], true];
saveProfileNamespace;
if (btc_debug) then {
    ["...3", __FILE__, [btc_debug, false, true]] call btc_debug_fnc_message;
};
[9] remoteExecCall ["btc_fnc_show_hint", 0];
