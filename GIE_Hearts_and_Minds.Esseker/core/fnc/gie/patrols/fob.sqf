/* ----------------------------------------------------------------------------
Function: gie_patrol_fnc_fob

Description:
    Create a group to protect FOB

Parameters:
    _fob - Fob to protect [Object]

Returns:

Examples:
    (begin example)
        [btc_fobs select 0] call gie_patrol_fnc_fob;
    (end)

Author:
    Gavin "Morbakos" Sertix

---------------------------------------------------------------------------- */

params [["_fob", objNull, [objNull]]];

if (isNull _fob) exitWith {};

[{
	params ["_fob"];

	private _pos = [_fob, 5, 15] call BIS_fnc_findSafePos;

	private _group = [
		_pos,
		btc_player_side,
		configfile >> "CfgGroups" >> "West" >> "R3F_MIS_BLUFOR_Group" >> "R3F_BLUFOR_Infanterie" >> "R3F_MIS_INF_BLUFOR"
	] call BIS_fnc_spawnGroup;
	_group deleteGroupWhenEmpty true;

	[_group, getPos _fob, 100, 1, 0.5, 0.3] call CBA_fnc_taskDefend;
	[format ["Patrol created at %1", getPos leader _group], __FILE__, [false, true]] call btc_debug_fnc_message;
}, [_fob], 10] call CBA_fnc_waitAndExecute;