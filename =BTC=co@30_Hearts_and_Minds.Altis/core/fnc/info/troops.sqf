
/* ----------------------------------------------------------------------------
Function: btc_info_fnc_troops

Description:
    Show troops information.

Parameters:
    _name - IA giving the information. [Object]
    _is_real - Is a real information. [Boolean]
    _text - Text to show. [String]

Returns:

Examples:
    (begin example)
        [] call btc_info_fnc_troops;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_man", objNull, [objNull]],
    ["_is_real", true, [true]],
    ["_text", "", [""]]
];

if (_is_real) then {
    private _array = player nearEntities [btc_type_units, 2500];
    _array = _array - [_man];
    if (_array isEqualTo []) then {
        _text = localize "STR_BTC_HAM_CON_INFO_TROOPS_FALSE";
    } else {
        _array = _array apply {[player distance _x, _x]};
        private _nearestEnemy = _array select 0 select 1;
        private _dist = player distance ([_nearestEnemy, 100] call CBA_fnc_randPos);
        private _dir = player getDir _nearestEnemy;
        private _card = [_dir] call btc_fnc_get_cardinal;
        _text = format [localize "STR_BTC_HAM_CON_INFO_TROOPS_TRUE", _card, round _dist];
    };
} else {
    if ((random 1) > 0.5) then {
        private _array = ["N", "E", "W", "S", "NW", "NE", "SE", "SW"];
        private _dir = selectRandom _array;
        private _dist = 500 + (random 1000);
        _text = format [localize "STR_BTC_HAM_CON_INFO_TROOPS_TRUE", _dir, round _dist];
    } else {
        _text = localize "STR_BTC_HAM_CON_INFO_TROOPS_FALSE";
    };
};

if (btc_debug) then {_text = _text + " - " + str _is_real};

[name _man, _text] call btc_fnc_showSubtitle;
player createDiaryRecord ["btc_diarylog", [str(mapGridPosition player) + " - " + name _man, _text]];
