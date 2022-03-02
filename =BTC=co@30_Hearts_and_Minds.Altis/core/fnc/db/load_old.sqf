
/* ----------------------------------------------------------------------------
Function: btc_db_fnc_load_old

Description:
    Load older database version thanks to profileNamespace getVariable [format ["btc_hm_%1_version", worldName], 1.13].

Parameters:
    _name - Name of the world currently played. [String]

Returns:

Examples:
    (begin example)
        [] call compileScript ["core\fnc\db\load_old.sqf"];
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_name", worldName, [""]]
];

setDate +(profileNamespace getVariable [format ["btc_hm_%1_date", _name], date]);

//CITIES
private _cities_status = +(profileNamespace getVariable [format ["btc_hm_%1_cities", _name], []]);

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
    };
    if (btc_debug_log) then {
        [format ["ID: %1 - IsOccupied %2", _id, _occupied], __FILE__, [false]] call btc_debug_fnc_message;
        [format ["data_city: %1", _x], __FILE__, [false]] call btc_debug_fnc_message;
    };
} forEach _cities_status;

//HIDEOUT
private _array_ho = +(profileNamespace getVariable [format ["btc_hm_%1_ho", _name], []]);

{
    _x call btc_hideout_fnc_create;
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
private _array_cache = +(profileNamespace getVariable [format ["btc_hm_%1_cache", _name], []]);
_array_cache params ["_cache_pos", "_cache_n", "_cache_info", "_cache_markers", "_cache_pictures",
    ["_isChem", false, [true]],
    ["_cache_unitsSpawned", false, [true]]
];

btc_cache_pos = _cache_pos;
btc_cache_n = _cache_n;
btc_cache_info = _cache_info;

[_cache_pos, btc_p_chem, [1, 0] select _isChem] call btc_cache_fnc_create;
btc_cache_obj setVariable ["btc_cache_unitsSpawned", _cache_unitsSpawned];

btc_cache_markers = [];
{
    _x params ["_pos", "_marker_name"];

    [_pos, 0, _marker_name] call btc_info_fnc_cacheMarker;
} forEach _cache_markers;

btc_cache_pictures = _cache_pictures;
{
    (btc_cache_pictures select 2) pushBack ([
        _x,
        btc_cache_n,
        btc_cache_pictures select 1 select _forEachindex
    ] remoteExecCall ["btc_info_fnc_cachePicture", [0, -2] select isDedicated, true]);
} forEach (btc_cache_pictures select 0);

//FOB
private _fobs = +(profileNamespace getVariable [format ["btc_hm_%1_fobs", _name], []]);

{
    _x params ["_fob_name", "_pos", ["_direction", 0, [0]]];

    [_pos, _direction, _fob_name] call btc_fob_fnc_create_s;
} forEach _fobs;

//REP
btc_global_reputation = profileNamespace getVariable [format ["btc_hm_%1_rep", _name], 0];

//Objects
{deleteVehicle _x} forEach (getMissionLayerEntities "btc_vehicles" select 0);
if !(isNil "btc_vehicles") then {
    {deleteVehicle _x} forEach btc_vehicles;
    btc_vehicles = [];
};

btc_load_fnc_migrateOldToNew_inventory = {
    params [
        ["_weap_obj", [[],[]], [[]]],
        ["_mags_obj", [], [[]]],
        ["_items_obj", [], [[]]],
        ["_backpack_obj", [], [[]]]
    ];

    private _weaponsItemsCargo = [];
    {
        for "_i" from 1 to (_weap_obj select 1 select _forEachindex) do {
            _weaponsItemsCargo pushBack [_x,"","","",[],[],""];
        };
    } forEach (_weap_obj select 0);

    private _itemCargo = [];
    {
        for "_i" from 1 to (_items_obj select 1 select _forEachindex) do {
            _itemCargo pushBack _x;
        };
    } forEach (_items_obj select 0);

    private _everyContainer = [];
    {
        for "_i" from 1 to (_backpack_obj select 1 select _forEachindex) do {
            _everyContainer pushBack [_x,[[[],[]],[],[],[]]];
        };
    } forEach (_backpack_obj select 0);

    [
        _mags_obj,
        _weaponsItemsCargo,
        _itemCargo,
        _everyContainer
    ]
};

private _objs = +(profileNamespace getVariable [format ["btc_hm_%1_objs", _name], []]);
[{ // Can't use ace_cargo for objects created during first frame.
    {
        [_x] call {
            params [
                ["_object_data", [], [[]]]
            ];
            _object_data params [
                "_type",
                "_posWorld",
                "_dir",
                "_magClass",
                "_cargo",
                "_inventory",
                "_vectorPos",
                ["_isContaminated", false, [false]]
            ];

            private _obj =  _type createVehicle _posWorld;

            _obj setDir _dir;
            _obj setPosWorld _posWorld;
            _obj setVectorDirAndUp _vectorPos;

            if (_isContaminated) then {
                if ((btc_chem_contaminated pushBackUnique _obj) > -1) then {
                    publicVariable "btc_chem_contaminated";
                };
            };
            if (_magClass isNotEqualTo "") then {_obj setVariable ["ace_rearm_magazineClass", _magClass, true]};
            if (unitIsUAV _obj) then {
                createVehicleCrew _obj;
            };

            [_obj] call btc_log_fnc_init;
            {
                _x set [2, (_x select 2) call btc_load_fnc_migrateOldToNew_inventory];
            } forEach _cargo;
            [_obj, _cargo, _inventory call btc_load_fnc_migrateOldToNew_inventory] call btc_db_fnc_loadCargo;
        };
    } forEach _this;
}, _objs] call CBA_fnc_execNextFrame;

//VEHICLES
private _vehs = +(profileNamespace getVariable [format ["btc_hm_%1_vehs", _name], []]);
[{ // Can't be executed just after because we can't delete and spawn vehicle during the same frame.
    private _loadVehicle = {
        params [
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
            ["_vectorPos", [], [[]]],
            ["_ViV", [], [[]]]
        ];

        if (btc_debug_log) then {
            [format ["_veh = %1", _x], __FILE__, [false]] call btc_debug_fnc_message;
        };

        private _veh = [_veh_type, _veh_pos, _veh_dir, _customization, _isMedicalVehicle, _isRepairVehicle, _fuelSource, _pylons, _isContaminated, _supplyVehicle, _EDENinventory call btc_load_fnc_migrateOldToNew_inventory, _veh_AllHitPointsDamage] call btc_log_fnc_createVehicle;
        _veh setVectorDirAndUp _vectorPos;
        _veh setFuel _veh_fuel;

        {
            _x set [2, (_x select 2) call btc_load_fnc_migrateOldToNew_inventory];
        } forEach _veh_cargo;
        [_veh, _veh_cargo, _veh_cont call btc_load_fnc_migrateOldToNew_inventory] call btc_db_fnc_loadCargo;

        if !(alive _veh) then {
            [_veh, objNull, objNull, nil, false] call btc_veh_fnc_killed;
        };
        if !(_ViV isEqualTo []) then {
            {
                private _vehToLoad = _x call _loadVehicle;
                if !([_vehToLoad, _veh] call btc_tow_fnc_ViV) then {
                    _vehToLoad setVehiclePosition [_veh, [], 100, "NONE"];
                    private _marker = _vehToLoad getVariable ["marker", ""];
                    if !(_marker isEqualTo "") then {
                        _marker setMarkerPos _vehToLoad;
                    };
                };
            } forEach _ViV;
        };

        _veh
    };
    {
        _x call _loadVehicle;
    } forEach _this;
}, _vehs] call CBA_fnc_execNextFrame;

//Player Tags
private _tags_properties = +(profileNamespace getVariable [format ["btc_hm_%1_tags", _name], []]);
private _id = ["ace_tagCreated", {
    params ["_tag", "_texture", "_object"];
    btc_tags_player pushBack [_tag, _texture, _object];
}] call CBA_fnc_addEventHandler;
{
    _x params ["_tagPosASL", "_vectorDirAndUp", "_texture", "_typeObject", "_tagModel"];
    private _object = objNull;
    if (_typeObject isNotEqualTo "") then {
        _object = nearestObject [ASLToATL _tagPosASL, _typeObject];
    };
    [_tagPosASL, _vectorDirAndUp, _texture, _object, objNull, "",_tagModel] call ace_tagging_fnc_createTag;
} forEach _tags_properties;
["ace_tagCreated", _id] call CBA_fnc_removeEventHandler;

//Player Markers
private _markers_properties = +(profileNamespace getVariable [format ["btc_hm_%1_markers", _name], []]);
{
    _x params ["_markerText", "_markerPos", "_markerColor", "_markerType", "_markerSize", "_markerAlpha", "_markerBrush", "_markerDir", "_markerShape",
        ["_markerPolyline", [], [[]]],
        ["_markerChannel", 0, [0]]
    ];

    private _marker = createMarker [format ["_USER_DEFINED #0/%1/%2", _forEachindex, _markerChannel], _markerPos, _markerChannel];
    _marker setMarkerText _markerText;
    _marker setMarkerColor _markerColor;
    _marker setMarkerType _markerType;
    _marker setMarkerSize _markerSize;
    _marker setMarkerAlpha _markerAlpha;
    _marker setMarkerBrush _markerBrush;
    _marker setMarkerDir _markerDir;
    _marker setMarkerShape _markerShape;
    if !(_markerPolyline isEqualTo []) then {
        _marker setMarkerPolyline _markerPolyline;
    };
} forEach _markers_properties;
