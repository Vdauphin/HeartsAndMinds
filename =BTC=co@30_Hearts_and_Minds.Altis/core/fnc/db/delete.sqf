
/* ----------------------------------------------------------------------------
Function: btc_db_fnc_delete

Description:
    Delete database.

Parameters:
    _showHint - Show the hint telling the database has been deleted. [Boolean]

Returns:

Examples:
    (begin example)
        [] call btc_db_fnc_delete;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_showHint", true, [true]]
];

missionProfileNamespace setVariable ["btc_hm_version", nil];
missionProfileNamespace setVariable ["btc_hm_date", nil];
missionProfileNamespace setVariable ["btc_hm_cities", nil];
missionProfileNamespace setVariable ["btc_hm_ho", nil];
missionProfileNamespace setVariable ["btc_hm_ho_sel", nil];
missionProfileNamespace setVariable ["btc_hm_cache", nil];
missionProfileNamespace setVariable ["btc_hm_rep", nil];
missionProfileNamespace setVariable ["btc_hm_fobs", nil];
missionProfileNamespace setVariable ["btc_hm_vehs", nil];
missionProfileNamespace setVariable ["btc_hm_objs", nil];
missionProfileNamespace setVariable ["btc_hm_tags", nil];
missionProfileNamespace setVariable ["btc_hm_respawnTickets", nil];
missionProfileNamespace setVariable ["btc_hm_deadBodyPlayers", nil];
missionProfileNamespace setVariable ["btc_hm_slotsSerialized", nil];
missionProfileNamespace setVariable ["btc_hm_markers", nil];
missionProfileNamespace setVariable ["btc_hm_db", nil];

saveMissionProfileNamespace;

if (_showHint) then {
    [10] remoteExecCall ["btc_fnc_show_hint", 0];
};
