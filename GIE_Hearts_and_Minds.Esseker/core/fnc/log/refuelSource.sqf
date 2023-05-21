
/* ----------------------------------------------------------------------------
Function: btc_log_fnc_refuelSource

Description:
    Refuel a fuel source.

Parameters:
    _object - Fuel truck. [Object]

Returns:

Examples:
    (begin example)
        [] call btc_log_fnc_refuelSource;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_object", objNull, [objNull]]
];

private _array = (nearestObjects [_object, ["LandVehicle", "Air", "Ship", "Thing"], 10]) select {!(
    _x isKindOf "ACE_friesBase" OR
    _x isKindOf "ace_fastroping_helper"
)};

private _failNotify = [
    [localize "STR_ACE_Refuel_Failed"],
    ["<img size='1' image='\A3\ui_f\data\igui\cfg\simpleTasks\types\refuel_ca.paa' align='center'/>"]
];
if (_array isEqualTo []) exitWith {_failNotify call CBA_fnc_notify;};

private _fuelSource = _array select 0;
private _default_fuelCargo = _fuelSource getVariable ["btc_EDEN_defaultFuelCargo", _fuelSource call ace_refuel_fnc_getFuel];

if (_default_fuelCargo <= 0) exitWith {_failNotify call CBA_fnc_notify;};

[_fuelSource, _default_fuelCargo] call ace_refuel_fnc_setFuel;
(localize "STR_ACE_Refuel_Hint_Completed") call CBA_fnc_notify;
