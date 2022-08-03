/* ----------------------------------------------------------------------------
Name: initUCR

Description: Initiates undercover mode on the given unit and (if the unit is a player) on all group members of the unit.

Parameters:
0: Unit <OBJECT>

Returns: Nil

Examples:

[player] execVM "INC_undercover\Scripts\initUCR.sqf";

Author: Incontinentia
---------------------------------------------------------------------------- */

private ["_trespassMarkers","_civilianVests","_civilianUniforms","_civilianBackpacks","_civFactions","_civPackArray","_incogVests","_incogUniforms","_incogFactions"];

params [["_unit",objNull]];

waitUntil {!(isNull player)};

#include "..\UCR_setup.sqf"

//Can only be run once per unit.
if ((_unit getVariable ["INC_undercoverHandlerRunning",false]) || {(!local _unit)}) exitWith {};

_unit setVariable ["INC_undercoverHandlerRunning", true];
_unit setVariable ["INC_isCompromised", false];
_unit setVariable ["INC_suspicious", false];
_unit setVariable ["INC_cooldown", false];
_unit setVariable ["INC_shotAt",false];
_unit setVariable ["INC_firedRecent",false];
_unit setVariable ["INC_highSecAlert",false];
_unit setVariable ["INC_trespassAlert",false];
_unit setVariable ["INC_seenByList",[]];

if ((isPlayer _unit) && {time < 60}) then {{_x setVariable ["INC_notDismissable",true]} forEach (units group _unit)};

_unit setVariable ["isUndercover", true, true]; //Allow scripts to pick up sneaky units alongside undercover civilians (who do not have the isSneaky variable)

sleep 1;

if (!isPlayer _unit) then {_unit setCombatMode "GREEN"};

if ((_debug) && {isPlayer _unit}) then {hint "Undercover initialising..."};

if (isNil "INC_asymEnySide") then {
	[player] call INCON_ucr_fnc_initUcrVars;
};

waitUntil {
	sleep 1;
	(missionNamespace getVariable ["INC_ucrInitComplete",false])
};

if (_racism) then {
	private ["_unitIDs","_looksLikeArray"];
	_unitIDs = ([[_unit],"getUnitIDs","full"] call INCON_ucr_fnc_ucrMain);
	_looksLikeArray = ([[_unitIDs,INC_civIdentities,INC_incogIdentities],"IDcheck"] call INCON_ucr_fnc_ucrMain);
	_looksLikeArray params ["_looksLikeCiv","_looksLikeIncog"];
	_unit setVariable ["INC_looksLikeCiv",_looksLikeCiv];
	_unit setVariable ["INC_looksLikeIncog",_looksLikeIncog];

	if ((_debug) && {isPlayer _unit}) then {
		diag_log format ["Player identities: %1", _unitIDs ];
		diag_log format ["Lookalike array: %1", _looksLikeArray];
	};
} else {
	_unit setVariable ["INC_looksLikeCiv",true];
	_unit setVariable ["INC_looksLikeIncog",true];
};

if ((_debug) && {isPlayer _unit}) then {
	diag_log format ["INC_ucr racism checks active: %1",_racism];
	diag_log format ["Incon undercover variable INC_looksLikeCiv: %1", (_unit getVariable "INC_looksLikeCiv") ];
	diag_log format ["Incon undercover variable INC_looksLikeIncog: %1", (_unit getVariable "INC_looksLikeIncog") ];
};

sleep 0.5;

[[_unit],"captiveCheck"] call INCON_ucr_fnc_ucrMain; //Checks whether the unit is the undercover side, if not, switches sides
[_unit, true] remoteExec ["setCaptive", _unit]; //Makes enemies not hostile to the unit

if (isPlayer _unit) then {

	//Add respawn eventhandler so all scripts work properly on respawn
	_unit addMPEventHandler ["MPRespawn",{
		_this spawn {
	        params ["_unit"];
			_unit setVariable ["INC_undercoverHandlerRunning", false];
			_unit setVariable ["INC_isCompromised", false];
			_unit setVariable ["INC_suspicious", false];
			_unit setVariable ["INC_cooldown", false];
			_unit setVariable ["INC_shotAt",false];
			_unit setVariable ["INC_firedRecent",false];
			_unit setVariable ["INC_highSecAlert",false];
			_unit setVariable ["INC_trespassAlert",false];
			_unit setVariable ["INC_seenByList",[]];
			sleep 1;
			[[_unit], "INC_undercover\Scripts\initUCR.sqf"] remoteExec ["execVM",_unit];
		};
	}];

	sleep 0.5;

	//Debug hints
	if (_debug) then {
		[player] spawn {
			params ["_unit"];
			sleep 5;

			waitUntil {
				sleep 1;
				_unit globalChat (format ["%1 cvr intact: %2, comp ft/vh: %3 / %4",_unit,(captive _unit),(_unit getVariable ["INC_isCompromised",false]),((vehicle _unit) getVariable ["INC_naughtyVehicle",false])]);
				_unit globalChat (format ["%1 prox/tresp: %2",_unit,((_unit getVariable ["INC_proxAlert",false]) || {(_unit getVariable ["INC_trespassAlert",false])})]);
				_unit globalChat (format ["%1 suspicious level: %2",_unit,(_unit getVariable ["INC_suspiciousValue",1])]);
				_unit globalChat (format ["%1 weirdo check on: %2, level %3",_unit,(captive _unit),(round (_unit getVariable ["INC_disguiseValue",1]))]);
				_unit globalChat (format ["%1 dist multi on: %2, value i%3 / f%4",_unit,(captive _unit),(round (_unit getVariable ["INC_radiusMulti",1])),(round (_unit getVariable ["INC_disguiseRad",1]))]);
				_unit globalChat (format ["Enemy know about %1: t%2 / r%3 / a%4",_unit,(_unit getVariable ["INC_AnyKnowsSO",false]),([_unit,INC_regEnySide,true] call INCON_ucr_fnc_isKnownToSide),([_unit,INC_asymEnySide,true] call INCON_ucr_fnc_isKnownToSide)]);
				!(_unit getVariable ["isUndercover",false])
			};

			_unit globalChat (format ["%1 undercover status: %2",_unit,(_unit getVariable ["isUndercover",false])]);
		};
	};

	sleep 0.5;

	//Run a low-impact version of the undercover script on AI subordinates (no proximity check)
	[_unit] spawn {
		params ["_unit"];
		{
			sleep 0.2;
			[_x] execVM "INC_undercover\Scripts\initUCR.sqf";
			sleep 0.2;
			_x setVariable ["noChanges",true,true];
			_x setVariable ["isUndercover", true];
			sleep 0.2;
			[[_x,_unit],"addConcealActions"] call INCON_ucr_fnc_ucrMain;
		} forEach ((units _unit) select {
			!(_x getVariable ["isUndercover",false]) &&
			{!isPlayer _x}
		});
	};
};

sleep 1;

if ((_debug) && {isPlayer _unit}) then {hint "Undercover init complete."};

//Get the undercover loops running on the unit
[_unit] call INCON_ucr_fnc_UCRhandler;

sleep 1;

//Main loop
waitUntil {

	//Pause while the unit is compromised
	waitUntil {
		sleep 1;
		!(_unit getVariable ["INC_isCompromised",false]);
	};

	//wait until the unit is acting all suspicious
	waitUntil {
		sleep 1;
		(((_unit getVariable ["INC_suspiciousValue",1]) >= 2) || {!captive _unit});
	};

	//Once the player is doing suspicious stuff, make them vulnerable to being compromised
	_unit setVariable ["INC_suspicious", true]; //Hold the cooldown script until the unit is no longer doing suspicious things
	[[_unit],"captiveCheck"] call INCON_ucr_fnc_ucrMain; //Checks whether the unit is the undercover side, if not, switches sides
	[_unit, false] remoteExec ["setCaptive", _unit]; //Makes enemies hostile to the unit

	[_unit] call INCON_ucr_fnc_cooldown; //Gets the cooldown script going

	//While he's acting suspiciously
	while {
		sleep 0.7;
		(((_unit getVariable ["INC_suspiciousValue",1]) >= 2) && {!(_unit getVariable ["INC_isCompromised",false])}) //While not compromised and either armed or trespassing
	} do {
		if (
			((_unit getVariable ["INC_suspiciousValue",1]) >= 3) &&
			{(_unit getVariable ["INC_AnyKnowsSO",false])}
		) then {

			//Once people know exactly where he is, and that he is doing loads of suspicious stuff, make him compromised
			if (([_unit, INC_regEnySide,2] call INCON_ucr_fnc_isKnownExact) || {([_unit, INC_asymEnySide,2] call INCON_ucr_fnc_isKnownExact)}) exitWith {

				[_unit] call INCON_ucr_fnc_compromised;
			};
		};
	};

	//Then stop the holding variable and allow cooldown to commence
	_unit setVariable ["INC_suspicious", false];

	sleep 2;

	//Wait until cooldown loop has finished
	waitUntil {
		sleep 2;
		!(_unit getVariable ["INC_cooldown",false]);
	};

	(!(_unit getVariable ["isUndercover",false]) || {!(alive _unit)} || {!local _unit})

};

_unit setVariable ["INC_undercoverHandlerRunning", false];
