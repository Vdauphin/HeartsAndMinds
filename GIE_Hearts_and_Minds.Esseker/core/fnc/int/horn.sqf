
/* ----------------------------------------------------------------------------
Function: btc_int_fnc_horn

Description:
    Execute STOP order if player use horn.

Parameters:

Returns:

Examples:
    (begin example)
        [] call btc_int_fnc_horn;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

private _veh = vehicle player;
if (
    _veh isEqualTo player || 
    {visibleMap} ||
    {time < btc_int_hornDelay + 1}
) exitWith {};

params ["_displayOrControl", "_button"];
if (_button isNotEqualTo 0) exitWith {};

private _weapon = (weaponState [_veh, _veh unitTurret player]) select 0;
if !(_weapon isKindOf ["CarHorn", configFile >> "CfgWeapons"]) exitWith {};

[
    1,
    objNull,
    btc_int_hornRadius,
    _veh
] call btc_int_fnc_orders;

btc_int_hornDelay = time;
