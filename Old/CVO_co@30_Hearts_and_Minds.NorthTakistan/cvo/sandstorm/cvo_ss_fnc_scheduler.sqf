/*
The goal of this file is to have an automated system that controls and triggers sandstorms in a controlled, semi-random, but still rare manner.

[60] spawn cvo_ss_fnc_sandstorm; // params: <Duration in Minutes>
*/


/*
TRIGGER: 
Reroll the probability for the current RL Time Cycle.

	There are 4 Brackets the initial RNG can fall into.
	0.0 to 0.5 	- 0 - 	No Sandstorm
	0.5 to 0.75	- 1 -  	single "short" storm. 			storm time in minutes: min 15  max 30.
	0.75 to 0.9 - 2 - 	several "short" storms.			up to 3x 
	0.9 to 1.0 	- 3 -  single extensive Storm.			minimum 45 - 90 minutes
*/

if (!isServer) exitWith {};
if (!canSuspend) exitWith {_this spawn cvo_ss_fnc_scheduler};


waitUntil {sleep 30; true}; 
// waitUntil {sleep 5; true}; 	// DEBUG

diag_log ("[CVO] [SS] (Scheduler) - ### Start ###");

// ###########################
// DEFINITION

private _cycleMin = 180; // cycle in minutes. in very extreme cases, a storm can last for about 0.75 times of said duration.


// ###########################
// Roll dice to define Regime.

private _dice = round random 100;
cvo_ss_regime = 0;
if (_dice > 50) then {
	cvo_ss_regime = 1;
	if (_dice > 75) then {
		cvo_ss_regime = 2;
		if (_dice > 90) then {
			cvo_ss_regime = 3;
		};
	};
};
diag_log format ["[CVO] [SS] (Scheduler) - CycleTime: %1 min. - Dice: %2 - Regime: %3", _cycleMin, _dice, cvo_ss_regime];

// ###########################
// Execute the Regime.

// ### Regime 1 - Single Short

if (cvo_ss_regime isEqualTo 1) then {

	_durationMin = 15 + round (random 15);
	_delayMin = floor (_cycleMin - _durationMin) * (round (random 100)) / 100 ;
	diag_log format ["[CVO] [SS] (Scheduler) - Regime 1 - Delay: %1 - Duration: %2", _delayMin, _durationMin];
	waitUntil {sleep (_delayMin * 60); true};
	[_durationMin] spawn cvo_ss_fnc_sandstorm;
};

// ### Regime 2 - 1~3x Short

if (cvo_ss_regime isEqualTo 2) then { 
	_frq = ceil random 3;
	_durationMin = 15 + round (random 15);
	_delayMin = floor ((_cycleMin - (_frq * _durationMin)) * (round (random 100)) / 100 / _frq);
	
	for "_i" from 1 to _frq do {
		diag_log format ["[CVO] [SS] (Scheduler) - Regime 2 - Frq: %3 - DelayMin: %1 - DurationMin: %2 - _iteration: %4", _delayMin, _durationMin, _frq,_i];
		waitUntil {sleep (_delayMin * 60); true};
		[_durationMin] spawn cvo_ss_fnc_sandstorm;
	};
};


// ### Regime 3 - 1x Long

if (cvo_ss_regime isEqualTo 3) then {

	_durationMin = 45 + round (random 45);
	_delayMin = floor (_cycleMin - _durationMin) * (round (random 100)) / 100 ;
	diag_log format ["[CVO] [SS] (Scheduler) - Regime 3 - Delay: %1 - Duration: %2", _delayMin, _durationMin];
	waitUntil {sleep (_delayMin * 60); true};
	[_durationMin] spawn cvo_ss_fnc_sandstorm;
};


// ###########################
// Wait until Change of dayCycle

waitUntil { sleep (_cycleMin * 60); true};
// waitUntil { sleep 5; true}; // DEBUG

diag_log ("[CVO] [SS] (Scheduler) - ### End ###");
cvo_ss_regime = nil;
[] spawn cvo_ss_fnc_scheduler;