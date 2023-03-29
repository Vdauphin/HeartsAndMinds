
/* ----------------------------------------------------------------------------
Function: btc_delay_fnc_createUnit

Description:
    Create unit when all previous units have been created. btc_delay_time define the time (in second) when the unit will be created.

Parameters:
    _group - Group to add unit. [Group]
    _unit_type - Type of units to create. [Array]
    _pos - Position of creation. [Array]
    _special - Unit placement special. [String]
    _vehicle - Vehicle where unit can be load in. [Object]

Returns:

Examples:
    (begin example)
        [createGroup (side player), typeOf player, getPosATL player] call btc_delay_fnc_createUnit;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

btc_delay_time = btc_delay_time + btc_delay_unit;

[{
    btc_delay_time = btc_delay_time - btc_delay_unit;

    params [
        ["_group", grpNull, [grpNull]],
        ["_unit_type", "", [""]],
        ["_pos", [0, 0, 0], [[], createHashMap]],
        ["_special", "CARGO", [""]],
        ["_vehicle", objNull, [objNull]]
    ];

    if !(_pos isEqualType []) then {
        _pos = _pos get "_pos";
    };
    private _unit = _group createUnit [_unit_type, _pos, [], 0, _special];
    [_unit] joinSilent _group;

    if (!isNull _vehicle) then {
        _unit moveInAny _vehicle;
    };
}, _this, btc_delay_time - 0.01] call CBA_fnc_waitAndExecute;
