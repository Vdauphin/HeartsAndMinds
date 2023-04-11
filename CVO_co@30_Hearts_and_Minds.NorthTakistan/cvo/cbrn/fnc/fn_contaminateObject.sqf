/*
	Author: Skippie [CVO]

	Description: Internal function used to contaminate object and cargo.

	cvo_cbrn_fnc_contaminateObject
*/

params ["_obj", objNull, [objNull]];

if ((btc_chem_contaminated pushBackUnique _obj) > -1) then {
	{
		if (_x isEqualType objNull) then {
			[_x] call cvo_cbrn_fnc_contaminateObject;
		};
	} forEach (_obj getVariable ["ace_cargo_loaded", []]);
};
