
/* ----------------------------------------------------------------------------
Function: btc_civ_fnc_populate

Description:
    Populate a city in an area with a defined number of civilians.

Parameters:
    _houses - Houses to populate around a city. [Number]
    _n - Number of civilians to generate. [Number]
    _city - City where the civilian is created. [Object]

Returns:

Examples:
    (begin example)
        [_city, 200, 3] call btc_civ_fnc_populate;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_houses", [], [[]]],
    ["_n", 0, [0]],
    ["_city", objNull, [objNull]]
];

if (_houses isEqualTo []) exitWith {};

for "_i" from 1 to _n do {
    if (_houses isEqualTo []) exitWith {};

    private _pos = (_houses deleteAt 0) buildingPos 0;

    private _group = createGroup civilian;
    _group setVariable ["btc_city", _city];
    _group setVariable ["btc_data_inhouse", [_pos]];
    [[_group, _pos], btc_civ_fnc_addWP] call btc_delay_fnc_exec;
    [_group, selectRandom btc_civ_type_units, _pos] call btc_delay_fnc_createUnit;
};
