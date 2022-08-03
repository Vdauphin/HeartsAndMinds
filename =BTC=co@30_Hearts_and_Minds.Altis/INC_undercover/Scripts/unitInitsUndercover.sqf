/* ----------------------------------------------------------------------------
Name: initUnitsUndercover

Description: Gets all relevant scripts and eventhandlers running on units spawned at the beginning and during a mission.

Parameters:
0: Unit <OBJECT>

Returns: Nil

Examples:

class Extended_InitPost_EventHandlers {
     class CAManBase {
		init = "_this call (compile preprocessFileLineNumbers 'INC_undercover\scripts\unitInitsUndercover.sqf')";
	};
};

Author: Incontinentia
---------------------------------------------------------------------------- */

params ["_unit"];

#include "..\UCR_setup.sqf"

switch (side _unit) do {
	case INC_regEnySide: {
		[_unit,_regBarbaric,_undercoverUnitSide] call INCON_ucr_fnc_addEH;
	};
	case INC_asymEnySide: {
		[_unit,_asymBarbaric,_undercoverUnitSide] call INCON_ucr_fnc_addEH;
	};
};

if (_civRecruitEnabled) then {
	if (((side _unit) == CIVILIAN) && {!(_unit getVariable ["isUndercover",false])}) then {
		[[_unit,_armedCivPercentage,_civRifleArray,_civPistolArray,_civPackArray],"recruitCiv"] remoteExecCall ["INCON_ucr_fnc_recruitHandler",0,true];
	};
};

_unit addEventHandler["Killed", {

	params["_unit"];

	if (uniform _unit in ((missionNamespace getVariable ["INC_incogUniforms",[]]) + (missionNamespace getVariable ["INC_civilianUniforms",[]]))) then {

		[_unit, [
			"<t color='#FFC300'>Take uniform from dead unit</t>", {

				_this spawn {
					params ["_deadGuy","_opportunist"];
					private ["_gwh","_oldUniform","_deadUniform","_oldItems"];

					[_opportunist,"AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon"] remoteExec ["playMove",0];

					_oldUniform = uniform _opportunist;
					_deadUniform = uniform _deadGuy;
					_oldItems = uniformItems _opportunist;
					_deadGuyItems = uniformItems _deadGuy;

					sleep 0.2;

					_gwh = createVehicle ["GroundWeaponHolder", getPosATL _opportunist, [], 0, "CAN_COLLIDE"];
					_gwh addItemCargoGlobal [_oldUniform, 1];
					{_gwh addItemCargoGlobal [_x, 1];} forEach (_deadGuyItems);

					sleep 1;

					removeUniform _deadGuy;
					_opportunist forceAddUniform _deadUniform;
					{(uniformContainer _opportunist) addItemCargoGlobal [_x, 1];} forEach (_oldItems);
				};

			},[],6,true,true,"","((_this getVariable ['isUndercover',false]) && {uniform _target != ''})",3
		]] remoteExec ["addAction", 0,true];
	};
}];
