/* 	Executes a gradual change, with flexible targetValue.

	Arguments:
		0: "_ds_duration" 	<number> <optional: 60> <Duration of transition.>
		1: "_ds_target"	<array, 2 or 3 items> <optional: [0,0,0]> <Target fogParams Array>
		2: "_ds_useAvgASL"	<bool> <optional: false> <decides if Avg. ASL of all players should be added to the _ds_target FogAltitute > 
	Examples:
 		[] spawn cvo_env_fnc_setFogFlexible; -> over the time of 60 secounds, fog will be adjusted to [0,0,0];
 		[120, [0.1, 0.05], true] spawn cvo_env_fnc_setFogFlexible;
*/
params [
	["_ds_duration", 60, [0]],
	["_ds_target", [0,0,0], [[]], [2,3]],
	["_ds_useAvgASL", false, [false]]
];

diag_log ("[CVO] [SandStorm] (flexFog) - " + format ["Start - Duration: %1 - Target: %2 - useAvgASL: %3", _ds_duration, _ds_target, _ds_useAvgASL]);


_ds_stepsTotal = 10;														// total count of "steps"
_ds_cycle = (_ds_duration / _ds_stepsTotal);								// Duration of each "cycle", in which the fog is applied.

_ds_iteration = [];
{_ds_iteration pushback _x } forEach _ds_target;

for "_i" from 1 to _ds_stepsTotal do {
	if (_ds_useAvgASL) then {
		_ds_iteration = [];
		{_ds_iteration pushback _x } forEach _ds_target;
		_ds_fogASL = (call cvo_ss_fnc_getAvgASL)#0;
		_ds_iteration set [2, ( (_ds_target#2) + _ds_fogASL)];
	};
	// diag_log 

	_ds_current = fogParams;
	_ds_arr = [];

	for "_j" from 0 to 2 do {
		_ds_arr pushBack (	(_ds_current # _j ) + (	((_ds_iteration # _j) - (_ds_current # _j)) / _ds_stepsTotal * _i 	)	);
	};


	_ds_cycle setFog _ds_arr;
	diag_log ("[CVO] [SandStorm] (flexFog) - " + format ["%1 / %2 - interTarget: %3", _i, _ds_stepsTotal, _ds_arr]);

	sleep _ds_cycle;
	if (!cvo_ss_running) exitWith {};
};
diag_log ("[CVO] [SandStorm] (flexFog) - done - Target: " + str _ds_iteration);

