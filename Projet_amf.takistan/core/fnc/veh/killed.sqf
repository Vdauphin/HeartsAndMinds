
/* ----------------------------------------------------------------------------
Function: btc_fnc_veh_killed

Description:
    Create marker wreck and change reputation on vehicle destruction.

Parameters:
    _vehicle - Vehicle object. [Object]
    _killer - Killer. [Object]
    _instigator - Person who pulled the trigger. [Object]
    _allowRepChange - Allow reputation change. [Boolean]

Returns:

Examples:
    (begin example)
        [btc_veh_12] call btc_fnc_veh_killed;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_vehicle", objNull, [objNull]],
    ["_killer", objNull, [objNull]],
    ["_instigator", objNull, [objNull]],
    ["_allowRepChange", true, [false]]
];

private _marker = createMarker [format ["m_%1", _vehicle], getPos _vehicle];
_marker setMarkerType "mil_box";
_marker setMarkerColor "ColorRed";
[_marker, "STR_BTC_HAM_O_EH_VEHKILLED_MRK", getText (configFile >> "cfgVehicles" >> typeOf _vehicle >> "displayName")] remoteExecCall ["btc_fnc_set_markerTextLocal", [0, -2] select isDedicated, _marker]; // %1 wreck

_vehicle setVariable ["marker", _marker];
if (_allowRepChange) then {
    if (isServer) then {
        [btc_rep_malus_veh_killed, _killer] call btc_fnc_rep_change;
    } else {
        [btc_rep_malus_veh_killed, _killer] remoteExecCall ["btc_fnc_rep_change", 2];
    };
};
