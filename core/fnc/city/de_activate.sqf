
/* ----------------------------------------------------------------------------
Function: btc_fnc_city_de_activate

Description:
    Desactivate the city with the corresponding ID by storing all groups present inside and clean up dead bodies.

Parameters:
    _id - ID of the city to desactivate. [Number]

Returns:

Examples:
    (begin example)
        _result = [] call btc_fnc_city_de_activate;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_id", 0, [0]]
];

private _city = btc_city_all select _id;

if !(_city getVariable ["active", false]) exitWith {};

[{
    params ["_city"];

    !(_city getVariable ["activating", false])
}, {
    params ["_city", "_id"];

    if !(_city getVariable ["active", false]) exitWith {};

    if (btc_debug) then {
        [str _id, __FILE__, [btc_debug, btc_debug_log, true]] call btc_fnc_debug_message;
    };

    //Save all and delete
    private _radius = _city getVariable ["radius", 0];
    private _has_en = _city getVariable ["occupied", false];

    if (_has_en) then {
        private _trigger = _city getVariable ["trigger", objNull];
        deleteVehicle _trigger;
        _city setVariable ["trigger", objNull];
    };

    private _pos_city = getPosWorld _city;
    private _data_units = [];
    private _has_suicider = false;
    {
        if (
            (leader _x) inArea [_pos_city, _radius, _radius, 0, false] &&
            {side _x != btc_player_side} &&
            {!(_x getVariable ["no_cache", false])} &&
            {_x getVariable ["btc_city", _city] in [_city, objNull]}
        ) then {
            private _data_group = _x call btc_fnc_data_get_group;
            _data_units pushBack _data_group;

            if ((_data_group select 0) in [5, 7]) then {_has_suicider = true;};
        };
    } forEach allGroups;

    private _data_animals = [];
    {
        private _agent = agent _x;
        if (
            _agent inArea [_pos_city, _radius, _radius, 0, false] &&
            {alive _agent} &&
            {!(_x getVariable ["no_cache", false])} &&
            {_x getVariable ["btc_city", _city] in [_city, objNull]}
        ) then {
            _data_animals pushBack [
                typeOf _agent,
                getPosATL _agent
            ];
            _agent call CBA_fnc_deleteEntity;
        };
    } forEach agents;

    private _data_tags = [];
    {
        if (_x getVariable ["btc_city", _city] isEqualTo _city) then {
            private _pos = getPos _x;
            _pos set [2, 0];
            _data_tags pushBack [
                _pos,
                [vectorDir _x, vectorUp _x],
                _x getVariable "btc_texture",
                typeOf _x
            ];
            _x call CBA_fnc_deleteEntity;
        };
    } forEach (btc_tags_server inAreaArray [_pos_city, _radius, _radius]);
    btc_tags_server = btc_tags_server - [objNull];

    if (btc_debug_log) then {
        [format ["data units = %1", _data_units], __FILE__, [false]] call btc_fnc_debug_message;
        [format ["data animals = %1", _data_animals], __FILE__, [false]] call btc_fnc_debug_message;
        [format ["data tags = %1", _data_tags], __FILE__, [false]] call btc_fnc_debug_message;
    };

    _city setVariable ["has_suicider", _has_suicider];
    _city setVariable ["data_units", _data_units];
    _city setVariable ["data_animals", _data_animals];
    _city setVariable ["data_tags", _data_tags];
    _city setVariable ["active", false];

    if (!btc_hideout_cap_checking) then {
        [] call btc_fnc_mil_check_cap;
    };

    [] call btc_fnc_city_cleanUp;

}, [_city, _id]] call CBA_fnc_waitUntilAndExecute;
