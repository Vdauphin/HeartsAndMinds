
/* ----------------------------------------------------------------------------
Function: btc_fnc_db_load_old

Description:
    Load older database version thanks to profileNamespace getVariable [format ["btc_hm_%1_version", worldName], 1.13].

Parameters:
    _name - Name of the world currently played. [String]

Returns:

Examples:
    (begin example)
        [] call compile preprocessFileLineNumbers "core\fnc\db\load_old.sqf";
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_name", worldName, [""]]
];

setDate (profileNamespace getVariable [format ["btc_hm_%1_date", _name], date]);

//CITIES
private _cities_status = profileNamespace getVariable [format ["btc_hm_%1_cities", _name], []];

{
    _x params ["_id", "_initialized", "_spawn_more", "_occupied", "_data_units", "_has_ho", "_ho_units_spawned", "_ieds", "_has_suicider",
        ["_data_animals", [], [[]]],
        ["_data_tags", [], [[]]]
    ];

    private _city = btc_city_all select _id;

    _city setVariable ["initialized", _initialized];
    _city setVariable ["spawn_more", _spawn_more];
    _city setVariable ["occupied", _occupied];
    _city setVariable ["data_units", _data_units];
    _city setVariable ["has_ho", _has_ho];
    _city setVariable ["ho_units_spawned", _ho_units_spawned];
    _city setVariable ["ieds", _ieds];
    _city setVariable ["has_suicider", _has_suicider];
    _city setVariable ["data_animals", _data_animals];
    _city setVariable ["data_tags", _data_tags];

    if (btc_debug) then {
        private _marker = _city getVariable ["marker", ""];
        if (_city getVariable ["occupied", false]) then {
            _marker setMarkerColor "colorRed";
        } else {
            _marker setMarkerColor "colorGreen";
        };
        _marker setMarkerText format ["loc_%3 %1 %2 - [%4]", _city getVariable "name", _city getVariable "type", _id, _occupied];
    };
    if (btc_debug_log) then {
        [format ["ID: %1 - IsOccupied %2", _id, _occupied], __FILE__, [false]] call btc_fnc_debug_message;
        [format ["data_city: %1", _x], __FILE__, [false]] call btc_fnc_debug_message;
    };
} forEach _cities_status;

//HIDEOUT
private _array_ho = profileNamespace getVariable [format ["btc_hm_%1_ho", _name], []];

{
    _x call btc_fnc_mil_create_hideout;
} forEach _array_ho;

private _ho = profileNamespace getVariable [format ["btc_hm_%1_ho_sel", _name], 0];
private _select_ho = (btc_hideouts apply {_x getVariable "id"}) find _ho;
if (_select_ho isEqualTo - 1) then {
    btc_hq = objNull;
} else {
    btc_hq = btc_hideouts select _select_ho;
};

if (btc_hideouts isEqualTo []) then {[] spawn btc_fnc_final_phase;};

//CACHE
private _array_cache = profileNamespace getVariable [format ["btc_hm_%1_cache", _name], []];

btc_cache_pos = _array_cache select 0;
btc_cache_n = _array_cache select 1;
btc_cache_info = _array_cache select 2;

[] call btc_fnc_cache_create;

btc_cache_markers = [];
{
    _x params ["_pos", "_marker_name"];

    [_pos, 0, _marker_name] call btc_fnc_info_cacheMarker;
} forEach (_array_cache select 3);

btc_cache_pictures = +(_array_cache select 4);
{
    (btc_cache_pictures select 2) pushBack ([
        _x,
        btc_cache_n,
        btc_cache_pictures select 1 select _forEachindex
    ] remoteExecCall ["btc_fnc_info_cachePicture", [0, -2] select isDedicated, true]);
} forEach (btc_cache_pictures select 0);

//FOB
private _fobs = profileNamespace getVariable [format ["btc_hm_%1_fobs", _name], []];

{
    _x params ["_fob_name", "_pos", ["_direction", 0, [0]]];

    [_pos, _direction, _fob_name] call btc_fnc_fob_create_s;
} forEach _fobs;

//REP
btc_global_reputation = profileNamespace getVariable [format ["btc_hm_%1_rep", _name], 0];

//VEHICLES
{deleteVehicle _x} forEach btc_vehicles;
btc_vehicles = [];

private _vehs = profileNamespace getVariable [format ["btc_hm_%1_vehs", _name], []];
[{ // Can't be executed just after because we can't delete and spawn vehicle during the same frame.
    {
        _x params [
            "_veh_type",
            "_veh_pos",
            "_veh_dir",
            "_veh_fuel",
            "_veh_AllHitPointsDamage",
            "_veh_cargo",
            "_veh_cont",
            "_customization",
            ["_isMedicalVehicle", false, [false]],
            ["_isRepairVehicle", false, [false]],
            ["_fuelSource", [], [[]]],
            ["_pylons", [], [[]]],
            ["_isContaminated", false, [false]],
            ["_supplyVehicle", [], [[]]],
            ["_EDENinventory", [], [[]]],
            ["_vectorPos", [], [[]]]
        ];

        if (btc_debug_log) then {
            [format ["_veh = %1", _x], __FILE__, [false]] call btc_fnc_debug_message;
        };

        private _veh = [_veh_type, _veh_pos, _veh_dir, _customization, _isMedicalVehicle, _isRepairVehicle, _fuelSource, _pylons, _isContaminated, _supplyVehicle, _EDENinventory, _veh_AllHitPointsDamage] call btc_fnc_log_createVehicle;
        if ((getPos _veh) select 2 < 0) then {_veh setVectorUp surfaceNormal position _veh;};
        _veh setFuel _veh_fuel;

        [_veh, _veh_cargo, _veh_cont] call btc_fnc_db_loadCargo;

        if !(alive _veh) then {
            [_veh, objNull, objNull, false] call btc_fnc_veh_killed;
        };
    } forEach _this;
}, _vehs, 0.5] call CBA_fnc_waitAndExecute;

//Objects
private _objs = profileNamespace getVariable [format ["btc_hm_%1_objs", _name], []];
{
    [_x] call btc_fnc_db_loadObjectStatus;
} forEach _objs;

//Player Tags
private _tags_properties = profileNamespace getVariable [format ["btc_hm_%1_tags", _name], []];
private _id = ["ace_tagCreated", {
    params ["_tag", "_texture", "_object"];
    btc_tags_player pushBack [_tag, _texture, _object];
}] call CBA_fnc_addEventHandler;
{
    _x params ["_tagPosASL", "_vectorDirAndUp", "_texture", "_typeObject", "_tagModel"];
    private _object = objNull;
    if !(_typeObject isEqualTo "") then {
        _object = nearestObject [ASLToATL _tagPosASL, _typeObject];
    };
    [_tagPosASL, _vectorDirAndUp, _texture, _object, objNull, "",_tagModel] call ace_tagging_fnc_createTag;
} forEach _tags_properties;
["ace_tagCreated", _id] call CBA_fnc_removeEventHandler;

//Player Markers
private _markers_properties = profileNamespace getVariable [format ["btc_hm_%1_markers", _name], []];
{
    _x params ["_markerText", "_markerPos", "_markerColor", "_markerType", "_markerSize", "_markerAlpha", "_markerBrush", "_markerDir", "_markerShape"];

    private _marker = createMarker [format ["_USER_DEFINED #0/%1/0", _forEachindex], _markerPos];
    _marker setMarkerText _markerText;
    _marker setMarkerColor _markerColor;
    _marker setMarkerType _markerType;
    _marker setMarkerSize _markerSize;
    _marker setMarkerAlpha _markerAlpha;
    _marker setMarkerBrush _markerBrush;
    _marker setMarkerDir _markerDir;
    _marker setMarkerShape _markerShape;
} forEach _markers_properties;
