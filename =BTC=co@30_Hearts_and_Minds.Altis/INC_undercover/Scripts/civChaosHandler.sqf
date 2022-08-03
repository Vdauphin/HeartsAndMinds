/* ----------------------------------------------------------------------------
Name: civChaosHandler

Description: Runs a scenario where civilians join the undercover unit's side and some take up arms. Needs to be run locally to the units who are rebelling. 

Parameters:
0: Target chance - how likely civilians are to be targeted in percent <NUMBER>
1: Percentage change of rebellion  - how likely civilians are to respond with force <NUMBER>
2: Percentage of civilians that are targeted <NUMBER>
3: Percentage of civilians that may rebel <NUMBER>
4: Length of delay after targetting for rebellion to happen in seconds <NUMBER>

Returns: Nil

Examples:
[80,20], "INC_undercover\Scripts\civChaosHandler.sqf"] remoteExec ["execVM",2];

Author: Incontinentia
---------------------------------------------------------------------------- */

params [["_targetChance",100],["_rebelChance",40],["_percentageTarget",40],["_percentageRebel",50],["_timeToRebel",(random 600)]];

if (missionNamespace getVariable ["civiliansTargeted",false]) exitWith {};

[_targetChance,_rebelChance,_percentageTarget,_percentageRebel,_timeToRebel] spawn {

	params [["_targetChance",100],["_rebelChance",40],["_percentageTarget",40],["_percentageRebel",30],["_timeToRebel",(random 600)]];

	_cooldownTimer = (30 + (random 300));
	sleep _cooldownTimer;

	if (_targetChance > (random 100)) then {

		missionNameSpace setVariable ["civiliansTargeted", true, true];
		//Enemies target civs
		{
			if !(_x getVariable ["isUndercover", false]) then {
				if (_percentageTarget > (random 100)) then {
					private _prevGroup = group _x;

					[_x] joinSilent grpNull;
					[_x] joinSilent (group INC_rebelCommander);

					if ((count units _prevGroup) == 0) then {
						deleteGroup _prevGroup; // clean up empty groups
					};
				};
			};
		} foreach (allunits select {(side _x) == CIVILIAN});
	};

	sleep _timeToRebel;


	//Armed civs will rebel
	if (_rebelChance > (random 100)) then {
		{
			if (
				(_percentageRebel > (random 100)) &&
				{!(_x getVariable ["isUndercover", false])} &&
				{!((count weapons _x) == 0)}
			) then {
				private _prevGroup = group _x;

				[_x] joinSilent grpNull;
				[_x] joinSilent (group INC_rebelCommander);

				deleteGroup _prevGroup;

				private _wpn = selectRandom (weapons _x);
				_x removeWeapon _wpn;
				private _mag = selectRandom ([_wpn,"getCompatMags"] call INCON_ucr_fnc_gearHandler);
				_x addMagazine _mag;
				_x addWeapon _wpn;

				_x setUnitAbility (0.7 + (random 0.25));
			};
		} foreach (allunits select {(side _x) == CIVILIAN});
	};

	sleep _cooldownTimer;

	missionNamespace setVariable ["civiliansTargeted", false, true];
};
