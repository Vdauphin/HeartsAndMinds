
/* ----------------------------------------------------------------------------
Function: btc_ied_fnc_create

Description:
    Create wreck and add an IED when it is not a fake. True IED is added to the btc_ied_list to check if player is around.

Parameters:
    _pos - Position of wreck. [Array]
    _type - Shape name of the wreck. [String]
    _dir - Direction of the wreck. [Number]
    _active - Does the wreck has an IED around it. [Boolean]
    _ied_list - Globale variable which store current active IED and delete them when there are removed. [Array]

Returns:
    _wreck - Simple object of the wreck. [Object]
    _type - Shape name of the wreck. [String]
    _ied - The IED object created. If fake, objNull is returned. [Object]

Examples:
    (begin example)
        [_wreck, _type, _ied] = [[0,0,0], "a3\armor_f_beta\apc_tracked_01\apc_tracked_01_rcws_f.p3d", 90, true] call btc_ied_fnc_create;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_pos", [0, 0, 0], [[]]],
    ["_type", "", [""]],
    ["_dir", 0, [0]],
    ["_active", false, [false]],
    ["_ied_list", btc_ied_list, [[]]]
];

if (btc_debug_log) then {
    [format ["%1", _this], __FILE__, [false]] call btc_debug_fnc_message;
};

private _wreck = createSimpleObject [_type, _pos];
_wreck setPosATL [_pos select 0, _pos select 1, 0];
_wreck setDir _dir;
_wreck setVectorUp surfaceNormal _pos;

if !(_active) exitWith {[_wreck, _type, objNull]};

private _ied = createMine [selectRandom btc_type_ieds_ace, [_pos select 0, _pos select 1, btc_ied_offset], [], 2];
_ied setVectorUp surfaceNormal _pos;

_pos params ["_xx", "_yy", "_zz"];
_ied_list pushBack [_ied, _wreck, [_xx, _yy, _zz + 0.5]];

[_wreck, _type, _ied]
