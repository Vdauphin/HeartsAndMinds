
/* ----------------------------------------------------------------------------
Function: btc_door_fnc_lock

Description:
    Lock door in a city.

Parameters:
    _city - City. [Array]
    _rep - Reputation level. [Number]

Returns:

Examples:
    (begin example)
        [player] call btc_door_fnc_lock;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_city", objNull, [objNull]],
    ["_rep", btc_global_reputation, [0]]
];

private _houses = +(_city getVariable ["btc_city_housesEntrerable", []]);
private _ratio = switch (true) do {
    case (_rep < btc_rep_level_low): {1};
    case (_rep >= btc_rep_level_low && _rep < btc_rep_level_normal): {1/2};
    case (_rep >= btc_rep_level_normal && _rep < btc_rep_level_high): {1/3};
    case (_rep >= btc_rep_level_high): {0};
};
private _n = (count _houses) * _ratio;
private _i = 1;

while {
    _i <= _n &&
    {_houses isNotEqualTo []}
} do {
    private _house = _houses deleteAt 0;
    private _numberOfDoors = getNumber (configOf _house >> "numberOfDoors");

    if (_numberOfDoors isNotEqualTo 0) then {
        if (isNil {_house getVariable "bis_disabled_Door_1"}) then {
            for "_door" from 1 to _numberOfDoors do {
                _house setVariable [format ["bis_disabled_Door_%1", _door], 1, true];
            };
        };
        _i = _i + 1;
    };
};

{
    if (_x getVariable ["bis_disabled_Door_1", 0] isEqualTo 1) then {
        for "_door" from 1 to getNumber (configOf _x >> "numberOfDoors") do {
            _x setVariable [format ["bis_disabled_Door_%1", _door], nil, true];
        };
    };
} forEach _houses;
