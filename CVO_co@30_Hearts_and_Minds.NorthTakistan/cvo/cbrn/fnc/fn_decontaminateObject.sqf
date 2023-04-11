/*
	Author: Skippie [CVO]

	Description: Internal function used to decontaminate object and cargo.

	cvo_cbrn_fnc_decontaminateObject
*/

params ["_obj", objNull, [objNull]];

["btc_chem_decontaminated", [_obj], _obj] call CBA_fnc_targetEvent;
btc_chem_contaminated deleteAt (btc_chem_contaminated find _obj);

{
	if (_x isEqualType objNull) then {
		[_x] call cvo_cbrn_fnc_decontaminateObject;
	};
} forEach (_obj getVariable ["ace_cargo_loaded", []]);
