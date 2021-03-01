
/* ----------------------------------------------------------------------------
Function: btc_fnc_civ_leaflets

Description:
    Evacuate civilian when player drop leaflets.

Parameters:
    _uav - UAV use by player. [Object]
    _weapon - Type of weapon use by player inside UAV. [String]

Returns:

Examples:
    (begin example)
        _result = [player, "Bomb_Leaflets"] call btc_fnc_civ_leaflets;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_uav", objNull, [objNull]],
    ["_weapon", "", [""]]
];

if (btc_debug) then {
    [format ["%1 fired with %2", typeOf _uav, _weapon], __FILE__, [btc_debug, false]] call btc_fnc_debug_message;
};

if (_weapon isEqualTo "Bomb_Leaflets") then {
    [getPos _uav] remoteExecCall ["btc_fnc_civ_evacuate", 2];
};
