
/* ----------------------------------------------------------------------------
Function: btc_fob_fnc_rallypointAssemble

Description:
    Handle assembling and disassembling of BI rallypoint.

Parameters:
    _nameEH - Name of the event. [String]
    _args - Arguments passed by the event. [Array]

Returns:

Examples:
    (begin example)
        ["WeaponAssembled", [player, cursorObject]] call btc_fob_fnc_rallypointAssemble;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_nameEH", "", [""]],
    ["_args", [], [[]]]
];

switch (_nameEH) do {
    case "WeaponAssembled": {
        _args params [
            ["_player", objNull, [objNull]],
            ["_rallyPoint", objNull, [objNull]]
        ];

        if !(_rallyPoint isKindOf "Camping_base_F") exitWith {_this};
        _rallyPoint remoteExecCall ["btc_fob_fnc_rallypointTimer", 2];
        [
            [format [localize "STR_BTC_HAM_O_FOB_SELFDESTRUCTION", btc_p_rallypointTimer]],
            ["<img size='1' image='\A3\ui_f\data\igui\cfg\simpleTasks\types\wait_ca.paa' align='center'/>"]
        ] call CBA_fnc_notify;
    };
    case "WeaponDisassembled": {
        _args params [
            ["_player", objNull, [objNull]],
            ["_bag", objNull, [objNull]]
        ];

        if !("_Respawn_" in typeOf _bag) exitWith {_this};

        private _markers = ([btc_player_side, false] call BIS_fnc_getRespawnMarkers) - [btc_respawn_marker];
        _markers = _markers apply {[_player distance markerPos _x, _x]};
        _markers sort true;
        deleteMarker (_markers select 0 select 1);
    };
    default {
    };
};
