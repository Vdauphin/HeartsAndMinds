
/* ----------------------------------------------------------------------------
Function: btc_fnc_mil_addWP

Description:
    Add waypoint to allready created units.

Parameters:
    _group - Group of enemies. [Group]
    _city - City to patrol around. [Object]
    _area - Area to patrol around. [Number]
    _wp - Type of wp: in house, patrol or sentry. [Number]
    _wp_ratios - Ratios between each type of waypoints. [Array]

Returns:

Examples:
    (begin example)
        [group cursorObject, btc_city_all select 0, 200] call btc_fnc_mil_addWP;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_group", grpNull, [grpNull]],
    ["_city", objNull, [objNull]],
    ["_area", 0, [0]],
    ["_wp", 0, [0]],
    ["_wp_ratios", btc_p_mil_wp_ratios, [[]]]
];
_wp_ratios params ["_wp_house_probability", "_wp_sentry_probability"];

private _pos = position _city;
private _rpos = [_pos, _area] call btc_fnc_randomize_pos;

switch (true) do {
    case (_wp <= _wp_house_probability) : {
        private _houses = [_city, _area] call btc_fnc_getHouses;
        if !(_houses isEqualTo []) then {
            private _house = selectRandom _houses;
            [_group, _house] spawn btc_fnc_house_addWP;
            _group setVariable ["btc_inHouse", typeOf _house];
        } else {
            [_group, _rpos, _area, 2 + floor (random 4), "MOVE", "SAFE", "RED", ["LIMITED", "NORMAL"] select ((vehicle leader _group) isKindOf "Air"), "STAG COLUMN", "", [5, 10, 20]] call CBA_fnc_taskPatrol;
        };
    };
    case (_wp > _wp_house_probability && _wp <= _wp_sentry_probability) : {
        [_group, _rpos, _area, 2 + floor (random 4), "MOVE", "AWARE", "RED", ["LIMITED", "NORMAL"] select ((vehicle leader _group) isKindOf "Air"), "STAG COLUMN", "", [5, 10, 20]] call CBA_fnc_taskPatrol;
    };
    case (_wp > _wp_sentry_probability) : {
        [_group, _rpos, -1, "SENTRY", "AWARE", "RED", "UNCHANGED", "WEDGE", "(group this) spawn btc_fnc_data_add_group;", [18000, 36000, 54000]] call CBA_fnc_addWaypoint;
    };
};

true
