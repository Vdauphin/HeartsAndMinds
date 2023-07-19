
/* ----------------------------------------------------------------------------
Function: btc_db_fnc_delete

Description:
    Delete database.

Parameters:
    _showHint - Show the hint telling the database has been deleted. [Boolean]
    _name - Name of the current database. [String]

Returns:

Examples:
    (begin example)
        [] call btc_db_fnc_delete;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_showHint", true, [true]],
    ["_name", worldName, [""]]
];

profileNamespace setVariable [format ["btc_hm_%1_version", _name], nil];
profileNamespace setVariable [format ["btc_hm_%1_date", _name], nil];
profileNamespace setVariable [format ["btc_hm_%1_cities", _name], nil];
profileNamespace setVariable [format ["btc_hm_%1_ho", _name], nil];
profileNamespace setVariable [format ["btc_hm_%1_ho_sel", _name], nil];
profileNamespace setVariable [format ["btc_hm_%1_cache", _name], nil];
profileNamespace setVariable [format ["btc_hm_%1_rep", _name], nil];
profileNamespace setVariable [format ["btc_hm_%1_fobs", _name], nil];
profileNamespace setVariable [format ["btc_hm_%1_vehs", _name], nil];
profileNamespace setVariable [format ["btc_hm_%1_objs", _name], nil];
profileNamespace setVariable [format ["btc_hm_%1_tags", _name], nil];
profileNamespace setVariable [format ["btc_hm_%1_respawnTickets", _name], nil];
profileNamespace setVariable [format ["btc_hm_%1_deadBodyPlayers", _name], nil];
profileNamespace setVariable [format ["btc_hm_%1_slotsSerialized", _name], nil];
profileNamespace setVariable [format ["btc_hm_%1_markers", _name], nil];
profileNamespace setVariable [format ["btc_hm_%1_db", _name], nil];

saveProfileNamespace;

if (_showHint) then {
    [10] remoteExecCall ["btc_fnc_show_hint", 0];
};
