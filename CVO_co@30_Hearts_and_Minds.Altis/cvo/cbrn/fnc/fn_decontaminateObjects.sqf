/*
	Author: Skippie [CVO]

	Description: Decontaminates the given objects and their ACE cargo. SHOULD BE EXECUTED ON THE SERVER.

	Syntax:
		[object1, object2, ...] call cvo_cbrn_fnc_decontaminateObjects;

		Parameters:
			object: OBJECT

		Example 1:
			[cursorObject] call cvo_cbrn_fnc_decontaminateObjects;

		Example 2:
			[player_1, player_2] call cvo_cbrn_fnc_decontaminateObjects;
*/

if ((count _this) < 1) throw "Error: invalid argument (null)";

if (cvo_debug) then {
	systemChat format ["cvo_cbrn_fnc_decontaminateObjects: received objects %1", str _this];
};

{
	["btc_chem_decontaminated", [_x], _x] call CBA_fnc_targetEvent;
	btc_chem_contaminated deleteAt (btc_chem_contaminated find _x);

	{
		if (_x isEqualType objNull) then {
			[_x] call cvo_cbrn_fnc_decontaminateObject;
		};
	} forEach (_x getVariable ["ace_cargo_loaded", []]) + (crew _x);
} forEach _this;

if (cvo_debug) then {
	systemChat format ["cvo_cbrn_fnc_decontaminateObjects: resulting contaminated %1", str btc_chem_contaminated];
};
publicVariable "btc_chem_contaminated";
