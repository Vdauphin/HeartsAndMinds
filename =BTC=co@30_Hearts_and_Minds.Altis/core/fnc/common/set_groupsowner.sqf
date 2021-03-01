
/* ----------------------------------------------------------------------------
Function: btc_fnc_set_groupsOwner

Description:
    Transfert groups to a headless client.

Parameters:
    _groups - Array of groups to transfert. [Array]

Returns:
	Returns array of true if locality was changed. [Array]

Examples:
    (begin example)
        [btc_patrol_active + btc_civ_veh_active] call btc_fnc_set_groupsOwner;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

if !(btc_p_auto_headless) exitWith {};
private _HCs = entities "HeadlessClient_F";
if (_HCs isEqualTo []) exitWith {[]};

params [
    ["_groups", btc_patrol_active + btc_civ_veh_active, [[]]]
];

private _HC = owner (_HCs select 0);
_groups apply {
    _x setGroupOwner _HC;
};
