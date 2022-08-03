/* ----------------------------------------------------------------------------
Function: cooldown

Description: Runs checks to see if enemies have witnessed a suspicious act or behaviour and waits until the side who witnessed the suspicious act no longer know about him. Then sets captive back to true as long as the unit isn't doing anything suspicious again or is compromised. Also includes a chance of making the unit compromised if the regular enemy side knows about him.

Parameters:
0: Unit <OBJECT>

Returns: Nil

Examples:

[_unit] call INCON_ucr_fnc_cooldown;

Author: Incontinentia
---------------------------------------------------------------------------- */

params ["_unit"];

if ((_unit getVariable ["INC_cooldown",false]) || {!local _unit}) exitWith {};

_unit setVariable ["INC_cooldown", true];

_unit setVariable ["INC_hasBeenPID",false];

[_unit,_debug] spawn {

	params ["_unit",["_debug",false]];

	private ["_asymKnowsAboutUnit","_regKnowsAboutUnit","_regAlerted","_asymAlerted"];

	//Holding variable while unit is armed / trespassing but remember if unit has been seen acting suspiciously
	waitUntil {

		if ([_unit, INC_regEnySide,2] call INCON_ucr_fnc_groupsWithPID || {[_unit, INC_asymEnySide,2] call INCON_ucr_fnc_groupsWithPID}) then {_unit setVariable ["INC_hasBeenPID",true]} else {_unit setVariable ["INC_hasBeenPID",false]};
		sleep 1;
		!(_unit getVariable ["INC_suspicious",false])
	};

	//Stop the script running while the unit is compromised
	waitUntil {
		sleep 1;

		if ([_unit, INC_regEnySide,2] call INCON_ucr_fnc_groupsWithPID || {[_unit, INC_asymEnySide,2] call INCON_ucr_fnc_groupsWithPID}) then {_unit setVariable ["INC_hasBeenPID",true]} else {_unit setVariable ["INC_hasBeenPID",false]};
		sleep 1;

		!((_unit getVariable ["INC_isCompromised",false]) || {(_unit getVariable ["INC_suspiciousValue",1]) >= 2});
	};

	//If the unit hasn't been seen while suspicious, exit
	if !(_unit getVariable ["INC_hasBeenPID",false]) exitWith {

		if !((_unit getVariable ["INC_isCompromised",false]) || {(_unit getVariable ["INC_suspiciousValue",1]) >= 2}) then {

			[[_unit],"captiveCheck"] call INCON_ucr_fnc_ucrMain; //Checks whether the unit is the undercover side, if not, switches sides
			[_unit, true] remoteExec ["setCaptive", _unit];
		};

		_unit setVariable ["INC_cooldown", false, true];
	};

	//Checks if INC_regEnySide has seen him recently and sets variables accordingly
	_regKnowsAboutUnit = [_unit, INC_regEnySide,50] call INCON_ucr_fnc_isKnownExact;

	//Checks if INC_asymEnySide has seen him recently
	_asymKnowsAboutUnit = [_unit, INC_asymEnySide,50] call INCON_ucr_fnc_isKnownExact;

	if ((isPlayer _unit) && (_debug)) then {hint "Cooldown active."};

	//SetsCaptive back to true if nobody has seen him, unless he is already compromised
	if !((_asymKnowsAboutUnit) || {_regKnowsAboutUnit}) exitWith {

		if !((_unit getVariable ["INC_isCompromised",false]) || {(_unit getVariable ["INC_suspiciousValue",1]) >= 2}) then {

			[[_unit],"captiveCheck"] call INCON_ucr_fnc_ucrMain; //Checks whether the unit is the undercover side, if not, switches sides
			[_unit, true] remoteExec ["setCaptive", _unit];
		};

		if (_debug && (isPlayer _unit)) then {hint "Cooldown complete."};

		_unit setVariable ["INC_cooldown", false, true];
	};

	//If both INC_regEnySide and INC_asymEnySide know about the unit, wait until neither does.
	if ((_asymKnowsAboutUnit) && {_regKnowsAboutUnit}) exitWith {

		waitUntil {
			sleep 2;
			(!(_unit getVariable ["INC_anyKnowsSO",false]) && {!((_unit getVariable ["INC_suspiciousValue",1]) >= 2)} && {!(_unit getVariable ["INC_isCompromised",false])})
		};

		if !(_unit getVariable ["INC_isCompromised",false]) then {

			[[_unit],"captiveCheck"] call INCON_ucr_fnc_ucrMain; //Checks whether the unit is the undercover side, if not, switches sides
			[_unit, true] remoteExec ["setCaptive", _unit];
		};

		_unit setVariable ["INC_cooldown", false, true];

	};

	//If only INC_asymEnySide knows about the unit, wait until they no longer do.
	if (_asymKnowsAboutUnit) then {

		waitUntil {
			sleep 2;
			(!(_unit getVariable ["INC_asymKnowsSO",false]) && {!((_unit getVariable ["INC_suspiciousValue",1]) >= 2)} && {!(_unit getVariable ["INC_isCompromised",false])})
		};

	//Otherwise, only INC_regEnySide knows about the unit so wait until they no longer do.
	} else {

		waitUntil {
			sleep 2;
			(!(_unit getVariable ["INC_regKnowsSO",false]) && {!((_unit getVariable ["INC_suspiciousValue",1]) >= 2)} && {!(_unit getVariable ["INC_isCompromised",false])})
		};

		//Percentage chance that unit will become compromised anyway
		if ((45 > (random 100)) && {((INC_regEnySide knowsAbout _unit) > 3)}) then {

			[_unit] call INCON_ucr_fnc_compromised;
		};
	};

	//Then set captive back to true as long as the compromised loop isn't running
	if !(_unit getVariable ["INC_isCompromised",false]) then {

		[[_unit],"captiveCheck"] call INCON_ucr_fnc_ucrMain; //Checks whether the unit is the undercover side, if not, switches sides
		[_unit, true] remoteExec ["setCaptive", _unit];
	};

	if (_debug && (isPlayer _unit)) then {hint "Cooldown complete."};

	//Allow the loop to be run again on the unit
	_unit setVariable ["INC_cooldown", false, true];
};
