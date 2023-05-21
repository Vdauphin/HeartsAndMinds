
/* ----------------------------------------------------------------------------
Function: btc_rep_fnc_call_militia

Description:
    Call militia to a position.

Parameters:
    _pos - Position to calling for militia. [Array]

Returns:

Examples:
    (begin example)
        [getPos player] call btc_rep_fnc_call_militia;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_pos", [0, 0, 0], [[]]]
];

btc_rep_militia_called = time;

private _players = if (isMultiplayer) then {playableUnits} else {switchableunits};

//is there an hideout close by?
private _start_pos = objNull;
private _hideouts = btc_hideouts inAreaArray [_pos, 2000, 2000];
if (_hideouts isNotEqualTo []) then {
    _hideouts = _hideouts select {_players inAreaArray [getPosWorld _x, 500, 500] isEqualTo []};
    if (_hideouts isNotEqualTo []) then {_start_pos = selectRandom _hideouts};
};

if (btc_debug_log) then {
    [format ["_start_pos : %1 (HIDEOUTS)", _start_pos], __FILE__, [false]] call btc_debug_fnc_message;
};

if (_start_pos isEqualTo objNull) then {
    _start_pos = [_pos, values btc_city_all select {
        !(_x getVariable ["active", false]) &&
        _x getVariable ["type", ""] != "NameMarine"
    }, false] call btc_fnc_find_closecity;
};

private _ratio = if (_pos distance _start_pos > 1000) then {0.2} else {0.6};

if (btc_debug_log) then {
    [format ["POS : %1 STARTPOS : %2 - RATIO = %3", _pos, _start_pos, _ratio], __FILE__, [false]] call btc_debug_fnc_message;
};

if ((random 1) > _ratio) then { //MOT
    [_start_pos, _pos, 1] call btc_mil_fnc_send;

    if (btc_debug_log) then {
        [format ["MOT %1 POS %2", _group, _pos], __FILE__, [false]] call btc_debug_fnc_message;
    };
} else { //INF
    [_start_pos, _pos, 0, "", "WEDGE"] call btc_mil_fnc_send;

    if (btc_debug_log) then {
        [format ["INF %1", _group], __FILE__, [false]] call btc_debug_fnc_message;
    };
};
