/* ----------------------------------------------------------------------------
Function: addEH

Description: Adds killed eventhandlers to enemies which can compromise undercover units nearby or cause chaos.

Parameters:

0: Unit <OBJECT>
1: Allow brbaric behavior <BOOL> (default: false)
2: Undercover unit side <SIDE> (default: west)

Returns: Nil

Examples:

[_unit,false,east] call INCON_ucr_fnc_addEH;

Author:

Incontinentia
---------------------------------------------------------------------------- */

params [["_unit",objNull],["_barbaric",false],["_undercoverUnitSide",west]];

if ((_unit getVariable ["INC_undercoverSide",sideEmpty]) isEqualTo _undercoverUnitSide) exitWith {};

_unit setVariable ["INC_unitSide",(side _unit)];

//Non-barbaric response to getting killed
if !(_barbaric) then {

	_unit addEventHandler["Killed", {

		params["_unit","_killer"];

		[_unit,_killer] spawn {

			params["_unit","_killer"];

			if (_killer getVariable ["isSneaky",true]) then {

				[_killer, 1000] remoteExec ["addRating", _killer];
			};

			private _side = (_unit getVariable ["INC_unitSide",west]);

			if (30 > (random 100)) then {

				//Find out if there are any known undercover units nearby

				private _nearbyUndercoverUnits = ((_unit nearEntities ["Man", 700]) select {

					if (_x getVariable ["isSneaky",false]) then {

						if ((_side knowsAbout _x) > 3.8) then {

							true;

						}
					}
				});

				//If there are known undercover units nearby, they might become compromised
				if !(_nearbyUndercoverUnits isEqualTo []) then {

					_suspect = selectRandom _nearbyUndercoverUnits;

					[_suspect] remoteExecCall ["INCON_ucr_fnc_compromised",_suspect];

					[_suspect, 2000] remoteExec ["addRating", _suspect];
				};
			};
		};
	}];
};


//Barbaric response to getting killed
if (_barbaric) then {

	_unit addEventHandler["Killed", {

		params["_unit","_killer"];

		[_unit,_killer] spawn {

			params["_unit","_killer"];

			if (_killer getVariable ["isSneaky",true]) then {

				[_killer, 1000] remoteExec ["addRating", _killer];

			};

			private _side = (_unit getVariable ["INC_unitSide",west]);

			if (30 > (random 100)) then {

				//Find out if there are any known undercover units nearby

				private _nearbyUndercoverUnits = ((_unit nearEntities ["Man", 700]) select {

					if (_x getVariable ["isSneaky",false] && {(_side knowsAbout _x) > 3.7}) then {

							true;

					}
				});


				if !(_nearbyUndercoverUnits isEqualTo []) exitWith {

					_suspect = selectRandom _nearbyUndercoverUnits;

					//makes enemies consider undercover units as a threat if they start to die and know about the underCoverUnit
					[_suspect] remoteExecCall ["INCON_ucr_fnc_compromised",_suspect];

				};

				//If there is no known suspect and the killer was an undercover unit, then there's a 10% chance they will lash out against civilians
				if ((33 > (random 100)) && {_killer getVariable ["isUndercover",false]}) then {

					//makes this side consider civilians a threat if they start to die and know about the underCoverUnit, also make civilians hostile to this side
					[[80,20], "INC_undercover\Scripts\civChaosHandler.sqf"] remoteExec ["execVM",2];

					if (isClass(configFile >> "CfgPatches" >> "ALiVE_main")) then {

						private _sideText = [[_side] call ALIVE_fnc_sideObjectToNumber] call ALIVE_fnc_sideNumberToText;

						[ALIVE_civilianHostility, _sideText,-100] call ALIVE_fnc_hashSet;
					};
				};
			};
		};
	}];
};
