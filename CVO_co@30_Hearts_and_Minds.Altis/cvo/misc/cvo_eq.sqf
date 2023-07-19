/*
[
	[427.109,9267.15],
	 1000,
	 0.3,
	 3,
	 ["UK3CB_TKC_C_WORKER", "UK3CB_TKC_C_SPOT",	"UK3CB_TKC_C_PILOT", "UK3CB_TKC_C_DOC", "UK3CB_TKC_C_CIV"]
] spawn cvo_misc_fnc_eq;
*/

if (!isServer) exitWith {};
if (!canSuspend) exitWith {_this spawn cvo_ss_fnc_sandstorm};
	
	
params [
	["_centerPos", [0,0,0], [objNull, []], [2,3]],
	["_radius", 1000, [0]],
	["_selectionChance", 0.5, [0]],
	["_numOfCiv", 1, [1,[]], [2]],
	["_civClasses", ["C_man_1"], []]
];

private _nearBuildingsSelection = [];
private _civQty = 0;

{
	if (random 1 > _selectionChance) then {_nearBuildingsSelection pushBack _x};
} forEach (_centerPos nearObjects ["House", _radius]);

diag_log "####### CVO Earthquake Building Array #######";
diag_log "_nearBuildingsSelection";
diag_log _nearBuildingsSelection;

[3] remoteExec ["BIS_fnc_earthquake"];
{
	sleep random 3;

	// destroy buildling

	_x call BIS_fnc_createRuin;
	[_x, true] remoteExecCall ["hideObject", -2];

	//  spawn Civilian
	diag_log "_civQTY_1";
	diag_log _civQTY;

	if (_numOfCiv isEqualType []) then {

		_civQty =  (round random _numOfCiv#1) min _numOfCiv#0;

	diag_log "_civQTY_2";
	diag_log _civQTY;



	} else { 
		_civQty = _numOfCiv;
		diag_log "_civQTY_3";
		diag_log _civQTY;
	};



	if (_civQty isEqualTo  0) then {continue};

	for "_i" from 1 to _civQty do {

		// Random CIV CLASS
		private "_selectedCivClass";
		if (_civClasses isEqualType []) then {
			_selectedCivClass = selectRandom _civClasses;
		} else {
			_selectedCivClass = _civClasses;
		};

		// Create Group + CIV
		_grp = createGroup [civilian, true];
		_civOBJ = _grp createUnit [_selectedCivClass, _x, [], (1.5 * sizeOf typeOf _x), "NONE"];


		// Define Default behaviour: Walk away far

		_wpTGT = _civOBJ getPos [2000, round random 360];
		while {surfaceIsWater _wpTGT} do {
			_wpTGT = _civOBJ getPos [2000, round random 360];
		};

		_wp = _grp addWaypoint [_wpTGT, 250];
		_wp setWaypointStatements ["true", "{deleteVehicle _x} forEach thisList;"];



		// Define Civ Damage State
		switch (floor random 5) do
			{
				case 1: {
					// Walking Wounded
					_civOBJ setDamage 0.6;
					_civOBJ setUnitPos selectRandom ["UP", "MIDDLE"];

				};
				case 2: {
					// UNCON
					for "_i" from 0 to (5 + round random 10) do {
						[	_civOBJ,
							random 1, 
							selectRandom ["Head", "Body", "LeftArm", "RightArm", "LeftLeg", "RightLeg"], 
							selectRandom ["vehiclecrash", "collision", "falling", "punch", "unkown"]
						] call ace_medical_fnc_addDamageToUnit;
					};
					[_civOBJ,true] call ace_medical_fnc_setUnconscious; 
				};
				case 3: {
					// DEAD
					_objPos = getPos _civOBJ;
					_objPos set [2, (random 5)];
					_civOBJ setPos _objPos;
					_civOBJ setDamage 1;
				};
			};
	}; 





	
} forEach _nearBuildingsSelection;
