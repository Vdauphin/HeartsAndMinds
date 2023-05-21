
/* ----------------------------------------------------------------------------
Function: gie_db_fnc_exportDatabase_s

Description:
    Export database to logs and to requester

Parameters:
    None

Returns:

Examples:
    (begin example)
        [] call gie_db_fnc_exportDatabase_s;
    (end)

Author:
    Gavin "Morbakos" Sertix

---------------------------------------------------------------------------- */

params [
	["_varName", "gie_database_export_datas", [""]],
    ["_name", worldName, [""]]
];

private _hashMap = createHashMap;

{
    _x params ["_name", "_val"];
	_hashMap set [_name, _val],
    [format ["%1: %2", _name, _val], __FILE__, [false, true]] call btc_debug_fnc_message;
} forEach [
    [format ["btc_hm_%1_date", _name], +(profileNamespace getVariable [format ["btc_hm_%1_date", _name], date])],
    [format ["btc_hm_%1_cities", _name], +(profileNamespace getVariable [format ["btc_hm_%1_cities", _name], []])],
    [format ["btc_hm_%1_ho", _name], +(profileNamespace getVariable [format ["btc_hm_%1_ho", _name], []])],
    [format ["btc_hm_%1_ho_sel", _name], profileNamespace getVariable [format ["btc_hm_%1_ho_sel", _name], 0]],
    [format ["btc_hm_%1_cache", _name], +(profileNamespace getVariable [format ["btc_hm_%1_cache", _name], []])],
    [format ["btc_hm_%1_fobs", _name], +(profileNamespace getVariable [format ["btc_hm_%1_fobs", _name], []])],
    [format ["btc_hm_%1_rep", _name], profileNamespace getVariable [format ["btc_hm_%1_rep", _name], 0]],
    [format ["btc_hm_%1_objs", _name], +(profileNamespace getVariable [format ["btc_hm_%1_objs", _name], []])],
    [format ["btc_hm_%1_vehs", _name], +(profileNamespace getVariable [format ["btc_hm_%1_vehs", _name], []])],
    [format ["btc_hm_%1_tags", _name], +(profileNamespace getVariable [format ["btc_hm_%1_tags", _name], []])],
    [format ["btc_hm_%1_respawnTickets", _name], +(profileNamespace getVariable [format ["btc_hm_%1_respawnTickets", _name], btc_respawn_tickets])],
    [format ["btc_hm_%1_deadBodyPlayers", _name], +(profileNamespace getVariable [format ["btc_hm_%1_deadBodyPlayers", _name], []])],
    [format ["btc_hm_%1_slotsSerialized", _name], +(profileNamespace getVariable [format ["btc_hm_%1_slotsSerialized", _name], createHashMap])],
    [format ["btc_hm_%1_markers", _name], +(profileNamespace getVariable [format ["btc_hm_%1_markers", _name], []])]
];

missionNamespace setVariable [_varName, [_hashMap] call CBA_fnc_encodeJSON, remoteExecutedOwner];
