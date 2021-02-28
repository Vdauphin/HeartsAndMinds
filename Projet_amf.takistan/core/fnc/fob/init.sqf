
/* ----------------------------------------------------------------------------
Function: btc_fnc_fob_init

Description:
    Store FOB data in btc_fobs global variable.

Parameters:
    _structure - Structure/rallypoint of the FOB. [Object]
    _flag - Flag of the FOB. [Object]
    _marker - Marker. [String]
    _fobs - GLobal variable. [Array]

Returns:

Examples:
    (begin example)
        [cursorObject] call btc_fnc_fob_init;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_structure", objNull, [objNull]],
    ["_flag", objNull, [objNull]],
    ["_marker", "", [""]],
    ["_fobs", btc_fobs, [[]]]
];

if (
    if (_marker isEqualTo "") then {
        _marker = "respawn_" + str btc_player_side + str _structure;
        _structure setVariable ["btc_fob_rallypointPos", position _structure, true];
        if (_marker in (_fobs select 0)) then {
            true
        } else {
            _structure setVariable ["btc_tickets", btc_fob_rallypointTicket, true];
            false
        }
    } else {
        false
    }
) exitWith {};

(_fobs select 0) pushBack _marker;
(_fobs select 1) pushBack _structure;
(_fobs select 2) pushBack _flag;
