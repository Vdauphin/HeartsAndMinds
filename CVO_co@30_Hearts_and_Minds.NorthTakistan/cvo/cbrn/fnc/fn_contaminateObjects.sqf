/*
	Author: Skippie [CVO]

	Description: Contaminates the given objects and their ACE cargo.

	Syntax:
		[object1, object2, ...] call cvo_cbrn_fnc_contaminateObjects;

		Parameters:
			object: OBJECT

		Example 1:
			[cursorObject] call cvo_cbrn_fnc_contaminateObjects;

		Example 2:
			[player_1, player_2] call cvo_cbrn_fnc_contaminateObjects;
*/

if ((count _this) < 1) throw "Error: invalid argument (null)";

if (cvo_debug) then {
	systemChat format ["cvo_cbrn_fnc_contaminateObjects: received objects %1", str _this];
};

{
	if ((btc_chem_contaminated pushBackUnique _x) > -1) then {
		{
			if (_x isEqualType objNull) then {
				[_x] call cvo_cbrn_fnc_contaminateObject;
			};
		} forEach (_x getVariable ["ace_cargo_loaded", []]) + (crew _x);
	};
} forEach _this;

if (cvo_debug) then {
	systemChat format ["cvo_cbrn_fnc_contaminateObjects: resulting contaminated %1", str btc_chem_contaminated];
};

publicVariable "btc_chem_contaminated";
