
/* ----------------------------------------------------------------------------
Function: btc_db_fnc_setTurretMagazines

Description:
    Set turret magazines.

Parameters:
    _vehicle - Vehicle to add magazines. [Object]
    _turretMagazines - Turret magazines. [Array]

Returns:

Examples:
    (begin example)
        [magazinesAllTurrets cursorObject] call btc_db_fnc_setTurretMagazines;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_vehicle", objNull, [objNull]],
    ["_turretMagazines", [], [[]]]
];

if (_turretMagazines isEqualTo []) exitWith {};

{
    _x params ["_magazineClass", "_turretPath"];
    _vehicle removeMagazineTurret [_magazineClass, _turretPath];
    false
} forEach (magazinesAllTurrets _vehicle);
{
    _x params ["_magazineClass", "_turretPath", "_ammoCount"];
    _vehicle addMagazineTurret [_magazineClass, _turretPath, _ammoCount];
} forEach _turretMagazines;
