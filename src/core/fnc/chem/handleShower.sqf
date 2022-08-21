
/* ----------------------------------------------------------------------------
Function: btc_chem_fnc_handleShower

Description:
    Loop over shower and activate or desactivate them if objects are around.

Parameters:
    _minDistance - Minimal distance of shower triggered. [Number]

Returns:

Examples:
    (begin example)
        [] call btc_chem_fnc_handleShower;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

if !(btc_p_chem) exitWith {};

params [
    ["_minDistance", 5, [2]]
];

[{
    params ["_args", "_id"];
    _args params ["_shower", "_minDistance"];

    if (_shower isEqualTo []) exitWith {};

    _needActivate = _shower select {
        _x animationSourcePhase "valve_source" isEqualTo 0 &&
        {(nearestObjects [_x, ["Car_F", "Man", "Strategic", "Constructions_base_F", "Cargo_base_F"], _minDistance]) isNotEqualTo []}
    };

    _needDesactivate = _shower select {
        _x animationSourcePhase "valve_source" > 0 &&
        {(nearestObjects [_x, ["Car_F", "Man", "Strategic", "Constructions_base_F", "Cargo_base_F"], _minDistance]) isEqualTo []}
    };

    {
        if (_x isKindOf "DeconShower_01_F") then {
            [_x, 1.5, 9] remoteExec ["BIN_fnc_deconShowerAnim", 0, _x];
        } else {
            [_x, 5.4, 4, 2, true] remoteExec ["btc_chem_fnc_deconShowerAnimLarge", 0, _x];
        };
    } forEach _needActivate;
    {
        remoteExecCall ["", _x];
        [_x] remoteExecCall ["BIN_fnc_deconShowerAnimStop", 0];
    } forEach _needDesactivate;
}, 2, [btc_chem_decontaminate, _minDistance]] call CBA_fnc_addPerFrameHandler;
