
/* ----------------------------------------------------------------------------
Function: btc_int_fnc_foodGive

Description:
    Give food to a unit.

Parameters:
    _player - Player. [Object]
    _target - Target. [Object]

Returns:

Examples:
    (begin example)
        [player, cursorObject] call btc_int_fnc_foodGive;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_player", player, [objNull]],
    ["_target", objNull, [objNull]]
];

private _hadFood = "ACE_Banana" in items _target;
if (
    [player, "ACE_Banana"] call CBA_fnc_removeItem &&
    {[_target, "ACE_Banana", true] call CBA_fnc_addItem}
) then {
    [_player, "PutDown"] call ace_common_fnc_doGesture;

    private _isInterpreter = player getVariable ["interpreter", false];
    if (_hadFood) then {
        [name _target, localize (["STR_BTC_HAM_CON_INFO_ASKREP_NOINTER", "STR_BTC_HAM_CON_INT_ALRGIVEFOOD"] select _isInterpreter)] call btc_fnc_showSubtitle;
    } else {
        [name _target, localize (["STR_BTC_HAM_CON_INFO_ASKREP_NOINTER", "str_a3_rscdisplaywelcome_kart_pard_footer2"] select _isInterpreter)] call btc_fnc_showSubtitle;
        [btc_rep_bonus_foodGive, _player] remoteExecCall ["btc_rep_fnc_change", 2];
    };
};
