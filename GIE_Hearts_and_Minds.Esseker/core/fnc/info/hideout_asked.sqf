
/* ----------------------------------------------------------------------------
Function: btc_info_fnc_hideout_asked

Description:
    Send real or false information about a hideout around.

Parameters:
    _name - Name of the player. [String]
    _is_real - If the information is true or not. [Boolean]
    _text - Not used. [String]

Returns:

Examples:
    (begin example)
        _result = [] call btc_info_fnc_hideout_asked;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_name", "Vdauphin", [""]],
    ["_is_real", true, [true]],
    ["_text", "", [""]]
];

if (_is_real) then {
    private _index = btc_hideouts findIf {
        _x inArea [getPosWorld player, 3000, 3000, 0, false]
    };

    if (_index > -1) then {
        private _hideout = btc_hideouts select _index;
        private _dist = (player distance _hideout) + (random 500) - (random 500);
        private _dir = player getDir _hideout;
        private _card = [_dir] call btc_fnc_get_cardinal;
        _text = format [localize "STR_BTC_HAM_CON_INFO_ASKHIDEOUT_TRUE", _card, round _dist];
    } else {
        _text = localize "STR_BTC_HAM_CON_INFO_ASKHIDEOUT_FALSE";
    };
} else {
    if ((random 1) > 0.5) then {
        private _dir = selectRandom ["N", "E", "W", "S", "NW", "NE", "SE", "SW"];
        private _dist = 300 + (random 2000);
        _text = format [localize "STR_BTC_HAM_CON_INFO_ASKHIDEOUT_TRUE", _dir, round _dist];
    } else {
        _text = localize "STR_BTC_HAM_CON_INFO_ASKHIDEOUT_FALSE";
    };
};

if (btc_debug) then {_text = _text + " - " + str _is_real};

[_name, _text] call btc_fnc_showSubtitle;
player createDiaryRecord ["btc_diarylog", [str(mapGridPosition player) + " - " + _name, _text]];
