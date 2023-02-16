
/* ----------------------------------------------------------------------------
Function: btc_debug_fnc_message

Description:
    Fill me when you edit me !

Parameters:
    _message - [String]
    _folder - [String]
    _type - [Array]

Returns:

Examples:
    (begin example)
        _result = [] call btc_debug_fnc_message;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_message", "BTC Message debug", [""]],
    ["_folder", __FILE__, [""]],
    ["_type", [], [[]]]
];

private _startPosition = _folder find "fnc";
if (_startPosition isEqualTo -1) then {
    _startPosition = (_folder find worldName) + count worldName;
};

[_message, _folder select [_startPosition, (_folder find ".sqf") - _startPosition], _type] call CBA_fnc_debug;
