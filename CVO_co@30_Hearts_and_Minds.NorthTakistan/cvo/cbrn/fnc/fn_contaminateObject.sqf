/*
	Author: Skippie [CVO]

	Description: Contaminates the given objects and their ACE cargo.

	Syntax:
		[object1, object2, ...] call cvo_cbrn_fnc_contaminateObject;

		Parameters:
			object: OBJECT

		Example 1:
			[cursorObject] call cvo_cbrn_fnc_contaminateObject;

		Example 2:
			[player_1, player_2] call cvo_cbrn_fnc_contaminateObject;
*/
if ((count _this) == 1) throw "Error: invalid argument (null)";


private _cvo_cbrn_fnc_contaminateObjectRecursive = {
	params ["_obj", objNull, [objNull]];

	if ((btc_chem_contaminated pushBackUnique _obj) > -1) then {
		private _objCargo = (_obj getVariable ["ace_cargo_loaded", []]) + (crew _obj);

		{
			[_x] call _cvo_cbrn_fnc_contaminateObjectRecursive;
		} forEach _objCargo;
	};
};


{
	if ((btc_chem_contaminated pushBackUnique _x) > -1) then {
		private _objCargo = (_x getVariable ["ace_cargo_loaded", []]) + (crew _x);
		
		{
			[_x] call _cvo_cbrn_fnc_contaminateObjectRecursive;
		} forEach _objCargo;

	};
} forEach _this;

publicVariable "btc_chem_contaminated";
