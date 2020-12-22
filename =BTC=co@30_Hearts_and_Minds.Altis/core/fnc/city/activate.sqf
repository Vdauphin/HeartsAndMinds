
/* ----------------------------------------------------------------------------
Function: btc_fnc_city_activate

Description:
    Activate the city with the current id passed. This generate IED, random group, populate city with civilian and suicider. It also spawn military patrol and civilian.

Parameters:
    _id - Number of the city will be activated. [Number]
    _p_mil_group_ratio - Enemy density. [Number]
    _p_civ_group_ratio - Civilian density. [Number]
    _p_civ_max_veh - Maximum number of civilian patrol. [Number]
    _p_patrol_max - Maximum number of enemy patrol. [Number]
    _wp_ratios - Ratio of spawned group in and out houses. [Array]

Returns:

Examples:
    (begin example)
        _result = [] call btc_fnc_city_activate;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_id", 0, [0]],
    ["_p_mil_group_ratio", btc_p_mil_group_ratio, [0]],
    ["_p_civ_group_ratio", btc_p_civ_group_ratio, [0]],
    ["_p_civ_max_veh", btc_p_civ_max_veh, [0]],
    ["_p_patrol_max", btc_p_patrol_max, [0]],
    ["_wp_ratios", btc_p_mil_wp_ratios, [[]]]
];
_wp_ratios params ["_wp_house", "_wp_sentry"];

if (btc_debug) then {
    ("Activate " + str _id) call CBA_fnc_notify;
};

private _city = btc_city_all select _id;

if (_city getVariable "activating") exitWith {};

_city setVariable ["activating", true];

private _is_init = _city getVariable ["initialized", false];
private _data_units = _city getVariable ["data_units", []];
private _type = _city getVariable ["type", ""];
private _radius_x = _city getVariable ["RadiusX", 0];
private _radius_y = _city getVariable ["RadiusY", 0];
private _has_en = _city getVariable ["occupied", false];
private _has_ho = _city getVariable ["has_ho", false];
private _ieds = _city getVariable ["ieds", []];
private _radius = (_radius_x + _radius_y)/2;

if (!_is_init) then {
    private _ratio = (switch _type do {
        case "Hill" : {random 1};
        case "NameLocal" : {random 2.5};
        case "NameVillage" : {random 3.5};
        case "NameCity" : {random 5};
        case "NameCityCapital" : {random 6};
        case "Airport" : {0};
        case "NameMarine" : {0};
    });

    private _ratio_ied = _ratio;
    if (_has_en) then {
        _ratio_ied = _ratio_ied * 1.5;
    } else {
        _ratio_ied = _ratio_ied * 0.75;
    };
    if (_has_ho) then {
        _ratio_ied = _ratio_ied * 2;
    };

    if (btc_debug_log) then {
        [format ["_ratio_ied %1 - p %2", _ratio_ied, _ratio_ied * btc_p_ied], __FILE__, [false]] call btc_fnc_debug_message;
    };

    _ratio_ied = _ratio_ied * btc_p_ied;
    if (_ratio_ied > 0) then {[_city, _radius, (_ratio_ied / 2) + (random _ratio_ied)] call btc_fnc_ied_init_area};

    _ieds = _city getVariable ["ieds", []];
    _city setVariable ["initialized", true];
};

_city setVariable ["active", true];

if !(_ieds isEqualTo []) then {
    private _ieds_data = _ieds apply {_x call btc_fnc_ied_create};
    [_city, _ieds_data] call btc_fnc_ied_check;
};

if !(_data_units isEqualTo []) then {
    {
        (_x call btc_fnc_data_spawn_group) params ["_leader", "_type"];
        if (_type in [5, 7]) then {
            [_leader, "killed", "btc_fnc_ied_suiciderKilled", [_id]] call btc_fnc_eh_persistOnLocalityChange;
        };
    } forEach _data_units;
} else {
    // Maximum number of enemy group
    private _max_number_group = (switch _type do {
        case "Hill" : {1};
        case "NameLocal" : {4};
        case "NameVillage" : {7};
        case "NameCity" : {10};
        case "NameCityCapital" : {15};
        case "Airport" : {15};
        case "NameMarine" : {3};
        default {0};
    });

    if (_has_en) then {
        for "_i" from 1 to (round (_p_mil_group_ratio * (1 + random _max_number_group))) do {
            [_city, _radius, 1 + round random [0, 1, 2] , random 1] call btc_fnc_mil_create_group;
        };
        for "_i" from 1 to (round random 2) do {
            private _pos = [getPos _city, (_radius_x + _radius_y)/4] call btc_fnc_randomize_pos;
            private _road = _pos nearRoads 80;
            _road = _road select {isOnRoad _x};
            if !(_road isEqualTo []) then {
                private _road = selectRandom _road;
                _pos = getPos _road;
                private _statics = btc_type_gl + btc_type_mg;

                private _direction = [_road] call btc_fnc_road_direction;

                _pos params ["_x", "_y", "_z"];
                private _posStatic = [_x -2.39185*cos(-_direction) - 2.33984*sin(-_direction), _y  + 2.33984 *cos(-_direction) -2.39185*sin(-_direction), _z];
                private _static = [_posStatic, _statics, _direction + 180] call btc_fnc_mil_create_static;
                _static setPos _posStatic;
            };
        };
        private _closest = [_city, btc_city_all select {!(_x getVariable ["active", false])}, false] call btc_fnc_find_closecity;
        for "_i" from 1 to (1 + round random 2) do {
        [{_this call btc_fnc_mil_send}, [_closest, getPos _city, 1, selectRandom btc_type_motorized_armed], 2] call CBA_fnc_waitAndExecute;
        };
    };
    
    
    //Spawn civilians
    if (_type != "Hill") then {
        private _max_number_group = (switch _type do {
            case "NameLocal" : {3};
            case "NameVillage" : {6};
            case "NameCity" : {10};
            case "NameCityCapital" : {19};
            case "Airport" : {6};
            default {2};
        });
        [_city, _radius/3, round (_p_civ_group_ratio * random _max_number_group)] call btc_fnc_civ_populate;
    };
};

if (_has_en) then {
    private _trigger = createTrigger ["EmptyDetector", getPos _city];
    _trigger setTriggerArea [_radius_x + _radius_y, _radius_x + _radius_y, 0, false];
    _trigger setTriggerActivation [str btc_enemy_side, "NOT PRESENT", false];
    _trigger setTriggerStatements ["this", format ["[%1] call btc_fnc_city_set_clear", _id], ""];
    _city setVariable ["trigger", _trigger];
};

if (_city getVariable ["spawn_more", false]) then {
    _city setVariable ["spawn_more", false];
    for "_i" from 1 to (round (_p_mil_group_ratio * (2 + random 3))) do {
        [_city, _radius, 4 + round random 3, random 1] call btc_fnc_mil_create_group;
    };
    if (btc_p_veh_armed_spawn_more) then {
        private _closest = [_city, btc_city_all select {!(_x getVariable ["active", false])}, false] call btc_fnc_find_closecity;
        for "_i" from 1 to (1 + round random 2) do {
            [{_this call btc_fnc_mil_send}, [_closest, getPos _city, 1, selectRandom btc_type_motorized_armed], _i * 2] call CBA_fnc_waitAndExecute;
        };
    };
};

if !(btc_cache_pos isEqualTo []) then {
    if (_city inArea [btc_cache_pos, _radius_x + _radius_y, _radius_x + _radius_y, 0, false]) then {
        if (count (btc_cache_pos nearEntities ["Man", 30]) > 3) exitWith {};
        [btc_cache_pos, 8, 3, _wp_house] call btc_fnc_mil_create_group;
        [btc_cache_pos, 60, 4, _wp_sentry] call btc_fnc_mil_create_group;
        if (btc_p_veh_armed_spawn_more) then {
            private _closest = [_city, btc_city_all select {!(_x getVariable ["active", false])}, false] call btc_fnc_find_closecity;
            for "_i" from 1 to (1 + round random 3) do {
                [{_this call btc_fnc_mil_send}, [_closest, getPos _city, 1, selectRandom btc_type_motorized_armed], _i * 2] call CBA_fnc_waitAndExecute;
            };
        };
    };
};

if (_has_ho && {!(_city getVariable ["ho_units_spawned", false])}) then {
    _city setVariable ["ho_units_spawned", true];
    private _pos = _city getVariable ["ho_pos", getPos _city];
    [_pos, 20, 10 + round (_p_mil_group_ratio * random 6), 1.1] call btc_fnc_mil_create_group;
    [_pos, 120, 1 + round random 2, _wp_sentry] call btc_fnc_mil_create_group;
    [_pos, 120, 1 + round random 2, _wp_sentry] call btc_fnc_mil_create_group;
    private _random = random 1;
    switch (true) do {
        case (_random <= 0.3) : {};
        case (_random > 0.3 && _random <= 0.75) : {
            private _statics = btc_type_gl + btc_type_mg;
            [[(_pos select 0) + 7, (_pos select 1) + 7, 0], _statics, 45] call btc_fnc_mil_create_static;
        };
        case (_random > 0.75) : {
            private _statics = btc_type_gl + btc_type_mg;
            [[(_pos select 0) + 7, (_pos select 1) + 7, 0], _statics, 45] call btc_fnc_mil_create_static;
            [[(_pos select 0) - 7, (_pos select 1) - 7, 0], _statics, 225] call btc_fnc_mil_create_static;
        };
    };
    if (btc_p_veh_armed_ho) then {
        _closest = [_city, btc_city_all select {!(_x getVariable ["active", false])}, false] call btc_fnc_find_closecity;
        for "_i" from 1 to (2 + round random 3) do {
            [{_this call btc_fnc_mil_send}, [_closest, _pos, 1, selectRandom btc_type_motorized_armed], _i * 2] call CBA_fnc_waitAndExecute;
        };
    };
};

//Suicider
if !(_city getVariable ["has_suicider", false]) then {
    if ((time - btc_ied_suic_spawned) > btc_ied_suic_time && {random 1000 > btc_global_reputation}) then {
        btc_ied_suic_spawned = time;
        _city setVariable ["has_suicider", true];
        private _suicider = if (selectRandom [false, false, btc_p_ied_drone]) then {
            [_city, _radius] call btc_fnc_ied_drone_create;
        } else {
            [_city, _radius] call btc_fnc_ied_suicider_create;
        };
        [_suicider, "killed", "btc_fnc_ied_suiciderKilled", [_id]] call btc_fnc_eh_persistOnLocalityChange;
    };
};

_city setVariable ["activating", false];

//Patrol
btc_patrol_active = btc_patrol_active - [grpNull];
private _number_patrol_active = count btc_patrol_active;
if (_number_patrol_active < _p_patrol_max) then {
    private _n = 0;
    private _r = 0;
    if (_has_en) then {_n = round (random 3 + (3/2));} else {_n = round random 2;};
    private _av = _p_patrol_max - _number_patrol_active;
    private _d = _n - _av;
    _r = if (_d > 0) then {_n - _d;} else {_n;};
    for "_i" from 1 to _r do {
        [1 + round random 1, _city, _radius_x + _radius_y + btc_patrol_area] spawn btc_fnc_mil_create_patrol;
    };

    if (btc_debug_log) then {
        [format ["(patrol) _n = %1 _av %2 _d %3 _r %4", _n, _av, _d, _r], __FILE__, [false]] call btc_fnc_debug_message;
    };
};
//Traffic
btc_civ_veh_active = btc_civ_veh_active - [grpNull];
private _number_civ_veh_active = count btc_civ_veh_active;
if (_number_civ_veh_active < _p_civ_max_veh) then {
    private _n = 0;
    private _r = 0;
    _n = round (random 3 + (3/2));
    private _av = _p_civ_max_veh - _number_civ_veh_active;
    private _d = _n - _av;
    _r = if (_d > 0) then {_n - _d;} else {_n;};
    for "_i" from 1 to _r do {
        [_city, _radius_x+_radius_y + btc_patrol_area] call btc_fnc_civ_create_patrol;
    };

    if (btc_debug_log) then {
        [format ["(traffic) _n = %1 _av %2 _d %3 _r %4", _n, _av, _d, _r], __FILE__, [false]] call btc_fnc_debug_message;
    };
};
