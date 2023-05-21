
/* ----------------------------------------------------------------------------
Function: btc_civ_fnc_leaflets

Description:
    Evacuate civilian when player drop leaflets.

Parameters:
    _uav - UAV use by player. [Object]
    _weapon - Type of weapon use by player inside UAV. [String]

Returns:

Examples:
    (begin example)
        _result = [player, "Bomb_Leaflets"] call btc_civ_fnc_leaflets;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_uav", objNull, [objNull]],
    ["_weapon", "", [""]]
];

if (btc_debug) then {
    [format ["%1 fired with %2", typeOf _uav, _weapon], __FILE__, [btc_debug, false]] call btc_debug_fnc_message;
};

if (_weapon isEqualTo "Bomb_Leaflets") then {
    [getPos _uav] remoteExecCall ["btc_civ_fnc_evacuate", 2];
};
