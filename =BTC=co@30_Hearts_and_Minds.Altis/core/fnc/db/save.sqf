
/* ----------------------------------------------------------------------------
Function: btc_db_fnc_save

Description:
    Save the current game into missionProfileNamespace.

Parameters:

Returns:

Examples:
    (begin example)
        [] call btc_db_fnc_save;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

if (btc_debug) then {
    ["...1", __FILE__, [btc_debug, false, true]] call btc_debug_fnc_message;
};

[8] remoteExecCall ["btc_fnc_show_hint", 0];

[false] call btc_db_fnc_delete;

//Version
missionProfileNamespace setVariable ["btc_hm_version", btc_version select 1];

//World Date
missionProfileNamespace setVariable ["btc_hm_date", date];

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
missionProfileNamespace setVariable ["btc_hm_cities", +_cities_status];

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
missionProfileNamespace setVariable ["btc_hm_ho", +_array_ho];

missionProfileNamespace setVariable ["btc_hm_ho_sel", btc_hq getVariable ["id", 0]];

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
missionProfileNamespace setVariable ["btc_hm_cache", +_array_cache];

//REPUTATION
missionProfileNamespace setVariable ["btc_hm_rep", btc_global_reputation];

//FOBS
private _fobs = [];
{
    if !(isNull ((btc_fobs select 2) select _forEachIndex)) then {
        private _pos = getMarkerPos [_x, true];
        private _direction = getDir ((btc_fobs select 1) select _forEachIndex);
        _fobs pushBack [markerText _x, _pos, _direction];
    };
} forEach (btc_fobs select 0);
missionProfileNamespace setVariable ["btc_hm_fobs", +_fobs];

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
        ((_array_veh select _index) select 17) pushBack _data;
    };

    if (btc_debug_log) then {
        [format ["VEH %1 DATA %2", _x, _data], __FILE__, [false]] call btc_debug_fnc_message;
    };
} forEach (_vehiclesNotInCargo + _vehiclesInCargo);
missionProfileNamespace setVariable ["btc_hm_vehs", +_array_veh];

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
missionProfileNamespace setVariable ["btc_hm_objs", +_array_obj];

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
missionProfileNamespace setVariable ["btc_hm_tags", +_tags_properties];

//Player respawn tickets
if (btc_p_respawn_ticketsAtStart >= 0) then {
    missionProfileNamespace setVariable ["btc_hm_respawnTickets", +btc_respawn_tickets];

    private _deadBodyPlayers = [btc_body_deadPlayers] call btc_body_fnc_get;
    missionProfileNamespace setVariable ["btc_hm_deadBodyPlayers", +_deadBodyPlayers];
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
missionProfileNamespace setVariable ["btc_hm_slotsSerialized", +_slots_serialized];

//Player Markers
private _player_markers = allMapMarkers select {"_USER_DEFINED" in _x};
private _markers_properties = _player_markers apply {
    [markerText _x, markerPos _x, markerColor _x, markerType _x, markerSize _x, markerAlpha _x, markerBrush _x, markerDir _x, markerShape _x, markerPolyline _x, markerChannel _x]
};
missionProfileNamespace setVariable ["btc_hm_markers", +_markers_properties];

//Explosives
private _explosives = [];
{
    _x params ["_explosive", "_dir", "_pitch"];
    if (isNull _explosive) then {continue};
    _explosives pushBack [
        typeOf _explosive,
        _dir,
        _pitch,
        getPosATL _explosive,
        _explosive getVariable ["btc_side", sideEmpty]
    ]
} forEach btc_explosives;
{
    _explosives pushBack [
        typeOf _x,
        getDir _x,
        0,
        getPosATL _x,
        _x getVariable ["btc_side", side group ((getShotParents _x) select 0)]
    ]
} forEach (allMines select {_x isKindOf "APERSMineDispenser_Mine_Ammo"});
missionProfileNamespace setVariable ["btc_hm_explosives", +_explosives];

//End
missionProfileNamespace setVariable ["btc_hm_db", true];
saveMissionProfileNamespace;
if (btc_debug) then {
    ["...3", __FILE__, [btc_debug, false, true]] call btc_debug_fnc_message;
};
[9] remoteExecCall ["btc_fnc_show_hint", 0];
