/*
 * Author: Tuupertunut
 * Returns information about every magazine that can be rearmed in the vehicle.
 */

params ["_vehicle"];

private _magazineInfo = [];

// 1.70 pylons
private _pylonConfigs = configProperties [configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "Components" >> "TransportPylonsComponent" >> "Pylons", "isClass _x"];
{

	// Strangely, a 1-based index.
	private _pylonIndex = _forEachIndex + 1;

	// Retrieving pylon magazine by index. If the pylon is empty, it is marked with "".
	private _pylonMagazine = (getPylonMagazines _vehicle) select (_pylonIndex - 1);

	// Only care about pylons that have a magazine.
	if (!(_pylonMagazine isEqualTo "")) then {
		_magazineInfo pushBack _pylonMagazine;
	};
} forEach _pylonConfigs;

private _turrets = [_vehicle] call ace_rearm_fnc_getAllRearmTurrets;
{
	_magazineInfo append ([_vehicle, _x] call ace_rearm_fnc_getTurretConfigMagazines);
} forEach _turrets;

// _magazines without duplicates
_magazineInfo arrayIntersect _magazineInfo