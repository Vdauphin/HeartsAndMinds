/*
	Author: Skippie [CVO]

	Description: Decontaminates the given objects and their ACE cargo.

	Syntax:
		[object1, object2, ...] call cvo_cbrn_fnc_decontaminateObject;

		Parameters:
			object: OBJECT

		Example 1:
			[cursorObject] call cvo_cbrn_fnc_decontaminateObject;

		Example 2:
			[player_1, player_2] call cvo_cbrn_fnc_decontaminateObject;
*/

if ((count _this) == 1) throw "Error: invalid argument (null)";


private _cvo_cbrn_fnc_decontaminateObjectRecursive = {
	params ["_objRecursive", objNull, [objNull]];

	private _objCargoRecursive = (_objRecursive getVariable ["ace_cargo_loaded", []]) + crew _objRecursive;


	["btc_chem_decontaminated", [_objRecursive], _objRecursive] call CBA_fnc_targetEvent;
	btc_chem_contaminated deleteAt (btc_chem_contaminated find _objRecursive);

	{
		[_x] call _cvo_cbrn_fnc_decontaminateObjectRecursive;
	} forEach _objCargoRecursive;
};


{
	private _objCargo = (_x getVariable ["ace_cargo_loaded", []]) + crew _x;


	["btc_chem_decontaminated", [_x], _x] call CBA_fnc_targetEvent;
	btc_chem_contaminated deleteAt (btc_chem_contaminated find _x);

	{
		[_x] call _cvo_cbrn_fnc_decontaminateObjectRecursive;
	} forEach _objCargo;
} forEach _this;

publicVariable "btc_chem_contaminated";
