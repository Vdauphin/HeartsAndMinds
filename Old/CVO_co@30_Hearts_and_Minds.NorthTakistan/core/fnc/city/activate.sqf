
/* ----------------------------------------------------------------------------
Function: btc_city_fnc_activate

Description:
    Activate the city with the current id passed. This generate IED, random group, populate city with civilian and suicider. It also spawn military patrol and civilian.

Parameters:
    _city - City will be activating. [Number]
    _p_mil_group_ratio - Enemy density. [Number]
    _p_mil_static_group_ratio - Enemy static density. [Number]
    _p_civ_group_ratio - Civilian density. [Number]
    _p_animals_group_ratio - Animal density. [Number]
    _p_civ_max_veh - Maximum number of civilian patrol. [Number]
    _p_patrol_max - Maximum number of enemy patrol. [Number]

Returns:

Examples:
    (begin example)
        _result = [] call btc_city_fnc_activate;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_city", objNull, [objNull]],
    ["_p_mil_group_ratio", btc_p_mil_group_ratio, [0]],
    ["_p_mil_static_group_ratio", btc_p_mil_static_group_ratio, [0]],
    ["_p_civ_group_ratio", btc_p_civ_group_ratio, [0]],
    ["_p_animals_group_ratio", btc_p_animals_group_ratio, [0]],
    ["_p_civ_max_veh", btc_p_civ_max_veh, [0]],
    ["_p_patrol_max", btc_p_patrol_max, [0]]
];

if (btc_debug) then {
    _city setVariable ["serverTime", serverTime];
};

_city enableSimulation false;
_city setVariable ["active", true];

private _data_units = _city getVariable ["data_units", []];
private _data_animals = _city getVariable ["data_animals", []];
private _type = _city getVariable ["type", ""];
private _cachingRadius = _city getVariable ["cachingRadius", 100];
private _has_en = _city getVariable ["occupied", false];
private _has_ho = _city getVariable ["has_ho", false];
private _ieds = _city getVariable ["ieds", []];
private _spawningRadius = _cachingRadius/2;

if (!(_city getVariable ["initialized", false])) then {
    private _numberOfIED = (switch _type do {
        case "Hill" : {1};
        case "VegetationFir" : {1};
        case "BorderCrossing" : {2};
        case "NameLocal" : {2.5};
        case "StrongpointArea" : {3};
        case "NameVillage" : {3.5};
        case "NameCity" : {5};
        case "NameCityCapital" : {6};
        case "Airport" : {0};
        case "NameMarine" : {0};
        default {0};
    });

    if (_has_en) then {
        _numberOfIED = _numberOfIED * 1.5;
    } else {
        _numberOfIED = _numberOfIED * 0.75;
    };
    if (_has_ho) then {
        _numberOfIED = _numberOfIED * 2;
    };

    if (btc_debug_log) then {
        [format ["_numberOfIED %1 - p %2", _numberOfIED, _numberOfIED * btc_p_ied], __FILE__, [false]] call btc_debug_fnc_message;
    };

    _numberOfIED = _numberOfIED * btc_p_ied / 2;
    if (_numberOfIED > 0) then {
        [[_city, _spawningRadius, _numberOfIED + (random _numberOfIED)], btc_ied_fnc_initArea] call btc_delay_fnc_exec;
    };

    _city setVariable ["initialized", true];
};
[_city, btc_ied_fnc_check] call btc_delay_fnc_exec;

private _delay = 0;
if (_data_units isNotEqualTo []) then {
    {
        _delay = _delay + ([_x, _city, _spawningRadius] call btc_data_fnc_spawn_group);
    } forEach _data_units;
} else {
    // Maximum number of enemy group
    private _numberOfGroup = (switch _type do {
        case "Hill" : {4};
        case "VegetationFir" : {4};
        case "BorderCrossing" : {7};
        case "NameLocal" : {7};
        case "StrongpointArea" : {8};
        case "NameVillage" : {8};
        case "NameCity" : {16};
        case "NameCityCapital" : {32};
        case "Airport" : {32};
        case "NameMarine" : {4};
        default {0};
    });

    if (_has_en) then {
        private _finalNumberOfGroup = _p_mil_group_ratio * _numberOfGroup;
        private _numberOfHouseGroup = _finalNumberOfGroup * btc_p_mil_wp_houseDensity;
        for "_i" from 1 to round _finalNumberOfGroup do {
            [
                _city,
                [_spawningRadius, _spawningRadius/2] select (_i <= _numberOfHouseGroup),
                2 + round random 2,
                [["PATROL", "SENTRY"] selectRandomWeighted [0.7, 0.3], "HOUSE"] select (_i <= _numberOfHouseGroup)
            ] call btc_mil_fnc_create_group;
        };
    };

    if !(_type in ["Hill", "NameMarine"]) then {
        ([_city, _spawningRadius/2] call btc_city_fnc_getHouses) params ["_housesEntrerable", "_housesNotEntrerable"];

        if (_has_en) then {
            private _numberOfStatic = (switch _type do {
                case "VegetationFir" : {3};
                case "BorderCrossing" : {6};
                case "NameLocal" : {3};
                case "StrongpointArea" : {6};
                case "NameVillage" : {6};
                case "NameCity" : {12};
                case "NameCityCapital" : {15};
                case "Airport" : {6};
                default {0};
            });
            [_housesEntrerable+_housesNotEntrerable, round (_p_mil_static_group_ratio * _numberOfStatic), _city] call btc_mil_fnc_create_staticOnRoof;
        };

        // Spawn civilians
        private _numberOfCivi = (switch _type do {
            case "VegetationFir" : {2};
            case "BorderCrossing" : {0};
            case "NameLocal" : {6};
            case "StrongpointArea" : {0};
            case "NameVillage" : {12};
            case "NameCity" : {20};
            case "NameCityCapital" : {38};
            case "Airport" : {12};
            default {4};
        });
        [+_housesEntrerable, round (_p_civ_group_ratio * _numberOfCivi), _city] call btc_civ_fnc_populate;
    };
};
if (btc_p_animals_group_ratio > 0) then {
    if (_data_animals isNotEqualTo []) then {
        {
            (_x + [nil, _city]) call btc_delay_fnc_createAgent;
        } forEach _data_animals;
    } else {
        // Spawn animals
        private _numberOfAnimalsGroup = (switch _type do {
            case "Hill" : {3};
            case "VegetationFir" : {3};
            case "NameLocal" : {3};
            case "NameVillage" : {2};
            case "NameCity" : {1};
            case "NameCityCapital" : {0};
            case "Airport" : {0};
            case "NameMarine" : {0};
            default {0};
        });
        for "_i" from 1 to _numberOfAnimalsGroup do {
            private _pos = [_city, _spawningRadius/3] call CBA_fnc_randPos;
            for "_i" from 1 to (round random 3) do {
                [selectRandom btc_animals_type, [_pos, 6] call CBA_fnc_randPos, nil, _city] call btc_delay_fnc_createAgent;
            };
        };
    };
};

if (_city getVariable ["spawn_more", false]) then {
    _city setVariable ["spawn_more", false];
    private _finalNumberOfGroup = _p_mil_group_ratio * 5;
    private _numberOfHouseGroup = _finalNumberOfGroup * btc_p_mil_wp_houseDensity;
    for "_i" from 1 to round _finalNumberOfGroup do {
        [
            _city,
            [_spawningRadius, _spawningRadius/2] select (_i <= _numberOfHouseGroup),
            4 + round random 3,
            ["PATROL", "HOUSE"] select (_i <= _numberOfHouseGroup)
        ] call btc_mil_fnc_create_group;
    };
    if (btc_p_veh_armed_spawn_more) then {
        [[_city, _spawningRadius, 1, btc_type_motorized_armed, 1 + round random 2], btc_city_fnc_send] call btc_delay_fnc_exec;
    };
};

if (
    (btc_cache_pos isNotEqualTo []) &&
    {_city inArea [btc_cache_pos, _cachingRadius, _cachingRadius, 0, false]}
) then {  
    if (btc_cache_obj getVariable ["btc_cache_unitsSpawned", false]) then {
        [[btc_cache_pos, 5], {
            if (count (btc_cache_pos nearEntities ["Man", 50]) > 3) exitWith {};
            [btc_cache_pos, 8, 3, "HOUSE"] call btc_mil_fnc_create_group;
            [btc_cache_pos, 50, 4, "SENTRY"] call btc_mil_fnc_create_group;
        }] call btc_delay_fnc_exec;
    } else {
        btc_cache_obj setVariable ["btc_cache_unitsSpawned", true];

        [btc_cache_pos, 8, 3, "HOUSE"] call btc_mil_fnc_create_group;
        [btc_cache_pos, 50, 4, "SENTRY"] call btc_mil_fnc_create_group;
        if (btc_p_veh_armed_spawn_more) then {
            [[_city, _spawningRadius, 1, btc_type_motorized_armed, 1 + round random 3], btc_city_fnc_send] call btc_delay_fnc_exec;
        };
    };
};

if (_has_ho && {!(_city getVariable ["ho_units_spawned", false])}) then {
    _city setVariable ["ho_units_spawned", true];
    [_city, 20, 10 + round (_p_mil_group_ratio * random 6), "SENTRY"] call btc_mil_fnc_create_group;
    [_city, 120, 1 + round random 2, "SENTRY"] call btc_mil_fnc_create_group;
    [_city, 120, 1 + round random 2, "SENTRY"] call btc_mil_fnc_create_group;
    private _random = random 1;
    private _pos = getPos _city;
    switch (true) do {
        case (_random <= 0.3) : {};
        case (_random > 0.3 && _random <= 0.75) : {
            private _statics = btc_type_gl + btc_type_mg;
            [[(_pos select 0) + 7, (_pos select 1) + 7, 0], _statics, 45, [], _city] call btc_mil_fnc_create_static;
        };
        case (_random > 0.75) : {
            private _statics = btc_type_gl + btc_type_mg;
            [[(_pos select 0) + 7, (_pos select 1) + 7, 0], _statics, 45, [], _city] call btc_mil_fnc_create_static;
            [[(_pos select 0) - 7, (_pos select 1) - 7, 0], _statics, 225, [], _city] call btc_mil_fnc_create_static;
        };
    };
    if (btc_p_veh_armed_ho) then {
        [[_city, _spawningRadius, 1, btc_type_motorized_armed, 2 + round random 3], btc_city_fnc_send] call btc_delay_fnc_exec;
    };
};

//Suicider
if !(_city getVariable ["has_suicider", false]) then {
    if ((time - btc_ied_suic_spawned) > btc_ied_suic_time && {random (btc_rep_level_high + 250) > btc_global_reputation}) then {
        btc_ied_suic_spawned = time;
        _city setVariable ["has_suicider", true];
        if (selectRandom [false, false, btc_p_ied_drone]) then {
            [[_city, _spawningRadius, getPosATL _city], btc_ied_fnc_drone_create] call btc_delay_fnc_exec;
        } else {
            [[_city, _spawningRadius], btc_ied_fnc_suicider_create] call btc_delay_fnc_exec;
        };
        _delay = _delay + btc_delay_unit;
    };
};

if (_city getVariable ["data_tags", []] isEqualTo []) then {
    private _tag_number = (switch _type do {
        case "Hill" : {1};
        case "BorderCrossing" : {1};
        case "NameLocal" : {2.5};
        case "StrongpointArea" : {3};
        case "NameVillage" : {3.5};
        case "NameCity" : {5};
        case "NameCityCapital" : {6};
        case "Airport" : {6};
        case "NameMarine" : {0};
        default {0};
    });

    if (_has_en) then {
        _tag_number = _tag_number * 1.5;
    };
    if (_has_ho) then {
        _tag_number = _tag_number * 2;
    };

    if (_tag_number > 0) then {
        [[_city, _spawningRadius, _tag_number / 2 + random _tag_number / 2], btc_tag_fnc_initArea] call btc_delay_fnc_exec;
    };
};
[_city, btc_tag_fnc_create] call btc_delay_fnc_exec;

if (
    !(_type in ["Hill", "NameMarine"]) &&
    _city getVariable ["btc_city_housesEntrerable", []] isEqualTo []
) then {
    [[_city, _spawningRadius/2], btc_city_fnc_getHouses] call btc_delay_fnc_exec;
};

[_city, btc_door_fnc_lock] call btc_delay_fnc_exec;

if (btc_p_info_houseDensity > 0) then {
    [_city, btc_info_fnc_createIntels] call btc_delay_fnc_exec;
};   

private _civKilled = _city getVariable ["btc_rep_civKilled", []];
if (_civKilled isNotEqualTo []) then {
    [[_city, _civKilled], btc_civ_fnc_createFlower] call btc_delay_fnc_exec;
};

[{
    params ["_has_en", "_city", "_cachingRadius"];

    if (_has_en) then {
        private _trigger = createTrigger ["EmptyDetector", _city, false];
        _trigger setTriggerArea [_cachingRadius, _cachingRadius, 0, false];
        _trigger setTriggerActivation [str btc_enemy_side, "PRESENT", false];
        _trigger setTriggerStatements [btc_p_city_free_trigger_condition, "[thisTrigger, thisList] call btc_city_fnc_setClear", ""];
        _trigger setTriggerInterval 2;
        _trigger setVariable ["playerTrigger", _city];
        _city setVariable ["enTrigger", _trigger];
    };

    _city enableSimulation true;
}, [_has_en, _city, _cachingRadius], _delay] call btc_delay_fnc_waitAndExecute;

//Patrol
btc_patrol_active = btc_patrol_active - [grpNull];
private _numberOfPatrol = count btc_patrol_active;
if (_numberOfPatrol < _p_patrol_max) then {
    private _min = [0, 1] select _has_en;
    private _addMilPatrol = (_min + random 1) min (_p_patrol_max - _numberOfPatrol);
    for "_i" from 1 to round _addMilPatrol do {
        private _group = createGroup btc_enemy_side;
        btc_patrol_active pushBack _group;
        _group setVariable ["no_cache", true];
        _group setVariable ["acex_headless_blacklist", true];
        [[_group, 1 + round random 1, _city, _cachingRadius + btc_patrol_area], btc_mil_fnc_create_patrol] call btc_delay_fnc_exec;
    };
};
//Traffic
btc_civ_veh_active = btc_civ_veh_active - [grpNull];
private _numberOfCivVeh = count btc_civ_veh_active;
if (_numberOfCivVeh < _p_civ_max_veh) then {
    private _addCivVeh = (random 2) min (_p_civ_max_veh - _numberOfCivVeh);
    for "_i" from 1 to round _addCivVeh do {
        private _group = createGroup civilian;
        btc_civ_veh_active pushBack _group;
        _group setVariable ["no_cache", true];
        _group setVariable ["acex_headless_blacklist", true];
        [[_group, _city, _cachingRadius + btc_patrol_area], btc_civ_fnc_create_patrol] call btc_delay_fnc_exec;
    };
};

// https://feedback.bistudio.com/T162941
private _HCs = entities "HeadlessClient_F";
if (_HCs isNotEqualTo []) then {
    private _triggerZSize = (triggerArea _city) select 4;
    if (_triggerZSize isNotEqualTo -1) then {
        private _cityPos = getPosASL _city;
        private _HCPos = _cityPos vectorAdd [0, 0, -(_triggerZSize + 50)];
        {
            _x setPosASL _HCPos;
        } forEach _HCs;
    };
};

if (btc_debug || btc_debug_log) then {
    private _id = _city getVariable "id";
    [format ["%1 - %2ms", _id, (serverTime - (_city getVariable ["serverTime", serverTime])) * 1000] , __FILE__, [btc_debug, btc_debug_log, true]] call btc_debug_fnc_message;
};
