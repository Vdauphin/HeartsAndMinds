/*
	Author: Mr. Zorn

	Description:
		Defines or Updates the local CVO_A_FULL Array to be used in the CVO Arsenal.

	Parameter(s):

	Returns:
		<Array> List of classnames of additional gear to be used in ACE Arsenal

	Examples:
		<example>
		[] call cvo_A_fnc_update;
*/
if (!hasInterface) exitWith {};

private _finalKit = [];
_finalKit append CVO_A_BASE;

// ############ Detect ROLE KIT ############

private _roles = player getVariable ["CVO_A_Roles", []];

// Detectes ACE MEDIC and ACE Engineer
if (0 < player getVariable ["ace_medical_medicClass", 0]) 	then {_roles pushBackUnique "Medic"};
if (0 < player getVariable ["ACE_IsEngineer",0]) 			then {_roles pushBackUnique "Engineer"};


{// Retrieves Info from HASHMAP
	private _array = CVO_A_HASH_RoleKit getOrDefault [_x,false];

diag_log format ["_array: %1", _array];


	if (!(_array isEqualTo false)) then {
		// _array = [  "KEY/ROLENAME",	[  ["ARRAY OF CLASSNAMES"],{"Optional CODEBLOCK"}  ]  ]
		
		diag_log format ["Role: %1 detected", _x];

		diag_log format ["Kit Added: %1", _array select 0];
		_finalKit append (_array select 0);

		private _code = call (_array select 1);
		diag_log format ["Code Return: %1",_code];
		_finalKit append _code;

	}; 
} forEach _roles;

// ############ Detect PLAYER KIT ############
private _uid = getPlayerUID player;
_array = CVO_A_HASH_PlayerKit getOrDefault [_uid,false];
diag_log format ["_PKarray: %1", _array];

if (!(_array isEqualTo false)) then {

	private _code = [] call (_array select 2);

	_finalkit append (_array select 1);
	_finalKit append _code;

	diag_log format ["PlayerKit Detected for %1 - Array: %2 - Code: %3",_array select 0, _array select 1, _code];
}; 

// Removes Duplicates
_finalkit = _finalkit arrayIntersect _finalkit;

// Return
_finalkit