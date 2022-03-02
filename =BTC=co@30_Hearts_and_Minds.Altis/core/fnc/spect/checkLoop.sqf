
/* ----------------------------------------------------------------------------
Function: btc_spect_fnc_checkLoop

Description:
    Loop over EMP and create electronic failure to vehicles.

Parameters:

Returns:

Examples:
    (begin example)
        [] call btc_spect_fnc_checkLoop;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

if !(btc_p_spect) exitWith {};

[{
    params ["_args", "_id"];
    _args params ["_emp", "_range"];

    if (_emp isEqualTo []) exitWith {};

    private _vehiclesOn = vehicles select {isEngineOn _x && {_x isKindOf "allVehicles"}};
    private _vehiclesAround = [];
    {
        _vehiclesAround append (_vehiclesOn inAreaArray [getPosWorld _x, _range, _range]);
    } forEach _emp;

    [_vehiclesAround] call btc_spect_fnc_electronicFailure;
}, 10, [btc_spect_emp, btc_spect_range / 2]] call CBA_fnc_addPerFrameHandler;
