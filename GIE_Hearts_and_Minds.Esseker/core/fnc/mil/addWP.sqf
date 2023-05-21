
/* ----------------------------------------------------------------------------
Function: btc_mil_fnc_addWP

Description:
    Add waypoint to already created units.

Parameters:
    _group - Group of enemies. [Group]
    _city - City to patrol around. [Object]
    _area - Area to patrol around. [Number]
    _wp - Type of wp: in "HOUSE", "PATROL" or "SENTRY". [String]

Returns:

Examples:
    (begin example)
        [group cursorObject, btc_city_all get 0, 200] call btc_mil_fnc_addWP;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_group", grpNull, [grpNull]],
    ["_city", objNull, [objNull]],
    ["_area", 0, [0]],
    ["_wp", "PATROL", [""]]
];

private _pos = position _city;
private _rpos = [_pos, _area] call btc_fnc_randomize_pos;

switch (_wp) do {
    case ("HOUSE") : {
        private _houses = ([_city, _area] call btc_fnc_getHouses) select 0;
        if (_houses isNotEqualTo []) then {
            private _house = selectRandom _houses;
            [_group, _house] call btc_fnc_house_addWP;
            _group setVariable ["btc_inHouse", typeOf _house];
        } else {
            [
                _group, _rpos,
                _area, 2 + floor (random 4), "MOVE", "SAFE", "RED",
                ["LIMITED", "NORMAL"] select ((vehicle leader _group) isKindOf "Air"),
                "STAG COLUMN", "", [5, 10, 20]
            ] remoteExecCall ["CBA_fnc_taskPatrol", groupOwner _group];
        };
    };
    case ("PATROL") : {
        [
            _group, _rpos,
            _area, 2 + floor (random 4), "MOVE", "AWARE", "RED",
            ["LIMITED", "NORMAL"] select ((vehicle leader _group) isKindOf "Air"),
            "STAG COLUMN", "", [5, 10, 20]
        ] remoteExecCall ["CBA_fnc_taskPatrol", groupOwner _group];
    };
    case ("SENTRY") : {
        [_group] call CBA_fnc_clearWaypoints;
        [_group, _rpos, -1, "SENTRY", "AWARE", "RED", "UNCHANGED", "WEDGE", "(group this) call btc_data_fnc_add_group;", [18000, 36000, 54000]] call CBA_fnc_addWaypoint;
    };
};

true
