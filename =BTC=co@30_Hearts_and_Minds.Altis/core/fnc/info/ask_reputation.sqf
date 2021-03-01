
/* ----------------------------------------------------------------------------
Function: btc_fnc_info_ask_reputation

Description:
    Fill me when you edit me !

Parameters:
    _man - [Object]

Returns:

Examples:
    (begin example)
        _result = [] call btc_fnc_info_ask_reputation;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_man", objNull, [objNull]]
];

if !(player getVariable ["interpreter", false]) exitWith {
    [name _man, localize "STR_BTC_HAM_CON_INFO_ASKREP_NOINTER"] call btc_fnc_showSubtitle;
};

btc_int_ask_data = nil;
["btc_global_reputation"] remoteExecCall ["btc_fnc_int_ask_var", 2];

waitUntil {!(isNil "btc_int_ask_data")};

private _rep = btc_int_ask_data;

private _ho_left = "";
if ((round random 1) isEqualTo 1) then {
    _ho_left = format [localize "STR_BTC_HAM_CON_INFO_ASKREP_HIDEOUTS", count btc_hideouts];
};

private _info_type = switch (true) do {
    case (_rep < 200): {localize "STR_BTC_HAM_CON_INFO_ASKREP_VLOW"};
    case (_rep >= 200 && _rep < 500): {localize "STR_BTC_HAM_CON_INFO_ASKREP_LOW"};
    case (_rep >= 500 && _rep < 750): {toLower localize "str_terrain_12_5"};
    case (_rep >= 750): {localize "str_terrain_6_25"};
};

private _text = selectRandom [
    localize "STR_BTC_HAM_CON_INFO_ASKREP_ASK1",
    localize "STR_BTC_HAM_CON_INFO_ASKREP_ASK2",
    localize "STR_BTC_HAM_CON_INFO_ASKREP_ASK3"
];

[name _man, format ["%1 %2. %3", _text, _info_type, _ho_left]] call btc_fnc_showSubtitle;
