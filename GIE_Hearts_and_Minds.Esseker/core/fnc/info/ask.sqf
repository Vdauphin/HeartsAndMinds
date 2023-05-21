
/* ----------------------------------------------------------------------------
Function: btc_info_fnc_ask

Description:
    Ask information to an IA.

Parameters:
    _man - Man giving information. [Object]
    _isInterrogate - Is interrogated. [Boolean]

Returns:

Examples:
    (begin example)
        [cursorObject] call btc_info_fnc_ask;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_man", objNull, [objNull]],
    ["_isInterrogate", false, [false]]
];

if !(player getVariable ["interpreter", false]) exitWith {
    [name _man, localize "STR_BTC_HAM_CON_INFO_ASKREP_NOINTER"] call btc_fnc_showSubtitle;
};

if !(_man call ace_medical_status_fnc_isInStableCondition) exitWith {
    private _complain = selectRandom [
        localize "STR_BTC_HAM_CON_INFO_ASK_WOUNDED1",
        localize "STR_BTC_HAM_CON_INFO_ASK_WOUNDED2",
        localize "STR_BTC_HAM_CON_INFO_ASK_WOUNDED3",
        localize "STR_BTC_HAM_CON_INFO_ASK_WOUNDED4"
    ];
    [name _man, _complain] call btc_fnc_showSubtitle;
};

if (
    _man getVariable ["btc_already_asked", false] ||
    _man getVariable ["btc_already_interrogated", false]
) exitWith {
    [name _man, localize "STR_BTC_HAM_CON_INFO_ASK_ALLREADYANS"] call btc_fnc_showSubtitle;
};

if ((round random 3) >= 2 || !_isInterrogate) then {
    _man setVariable ["btc_already_asked", true, true];
    if (_isInterrogate) then {_man setVariable ["btc_already_interrogated", true, true];};
};

//NO < btc_rep_level_low . FAKE < btc_rep_level_normal + 100 . REAL > btc_rep_level_normal + 100

btc_int_ask_data = nil;
["btc_global_reputation"] remoteExecCall ["btc_int_fnc_ask_var", 2];

waitUntil {!(isNil "btc_int_ask_data")};

private _rep = btc_int_ask_data;

private _chance = (random 300) + (random _rep) + _rep/2;
private _info_type = "";
switch !(_isInterrogate) do {
    case (_chance < btc_rep_level_low) : {_info_type = "NO";};
    case (_chance >= btc_rep_level_low && _chance < btc_rep_level_normal + 100) : {_info_type = "FAKE";};
    case (_chance >= btc_rep_level_normal + 100) : {_info_type = "REAL";};
};
if (_isInterrogate) then {_info_type = "REAL";};
if (_info_type isEqualTo "NO") exitWith {
    [name _man, localize "STR_BTC_HAM_CON_INFO_ASK_NOINFO"] call btc_fnc_showSubtitle;
};

private _final_phase = (count btc_hideouts) isEqualTo 0;
private _info = selectRandomWeighted [
    "TROOPS", 0.4,
    ["HIDEOUT", "TROOPS"] select _final_phase, 0.4,
    "CACHE", 0.2
];

_info_type = _info_type isEqualTo "REAL";
switch (_info) do {
    case "TROOPS" : {
        [_man, _info_type] call btc_info_fnc_troops;
    };
    case "HIDEOUT" : {
        [name _man, _info_type] call btc_info_fnc_hideout_asked;
    };
    case "CACHE" : {
        [name _man, localize "STR_BTC_HAM_CON_INFO_ASK_CACHEMAP"] call btc_fnc_showSubtitle;
        sleep 2;
        [_info_type] remoteExecCall ["btc_info_fnc_cache", 2];
    };
};
