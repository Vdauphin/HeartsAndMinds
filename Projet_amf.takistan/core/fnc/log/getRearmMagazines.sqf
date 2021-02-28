
/* ----------------------------------------------------------------------------
Function: btc_fnc_log_getRearmMagazines

Description:
    Fill me when you edit me !

Parameters:
    _rearming_vehicles - [Array]

Returns:

Examples:
    (begin example)
        _result = [] call btc_fnc_log_getRearmMagazines;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_rearming_vehicles", [], [[]]]
];

private _typeof_rearming_vehicles = ([_rearming_vehicles] call btc_fnc_find_veh_with_turret) select 0;
private _rearming_magazines = [];
{
    private _vehicle_type = _x;
    private _vehicle = (_rearming_vehicles select {typeOf _x isEqualTo _vehicle_type}) select 0;
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

    ([[typeOf _vehicle]] call btc_fnc_find_veh_with_turret) params ["", "_magazines"];
    _magazineInfo append _magazines;

    _rearming_magazines pushBack (_magazineInfo arrayIntersect _magazineInfo);
} forEach _typeof_rearming_vehicles;

[_typeof_rearming_vehicles, _rearming_magazines]
