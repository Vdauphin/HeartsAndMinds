/* ----------------------------------------------------------------------------
Function: suspiciosEny

Description: Handles suspicious behavior for enemies when alerted to strange behaviour by undercover units.

Parameters:
0: The unit who is acting strangely <OBJECT>
1: The suspicious enemy <OBJECT>

Returns: Nil

Examples:

[_unit,_suspiciousEnemy] call INCON_ucr_fnc_suspiciousEny;

Author: Incontinentia
---------------------------------------------------------------------------- */

_this spawn {

	params ["_unit","_suspiciousEnemy"];

	if (_suspiciousEnemy getVariable ["INC_isSuspicious",false]) exitWith {true};

	_suspiciousEnemy setVariable ["INC_isSuspicious",true];

	[_suspiciousEnemy,_unit] remoteExec ["doWatch",2];

	while {sleep 0.5; ((alive _unit && {alive _suspiciousEnemy}) && {captive _unit && {_suspiciousEnemy getVariable ["INC_isSuspicious",false]}} && {((_unit getHideFrom (vehicle _unit)) distanceSqr _unit < 25)})} do {

		if ((_unit getVariable ["INC_disguiseValue",1]) > (13 + random 15)) exitWith {
			[_unit] call INCON_ucr_fnc_compromised;
		};

		_reactionTime = ((_unit distance _suspiciousEnemy) - (_unit getVariable ["INC_disguiseValue",1]));

		if (_reactionTime <= 5) then {_reactionTime = 5};

		sleep (random _reactionTime);


		//Quick spot
		if ((_unit getVariable ["INC_disguiseValue",1]) > (7 + (random 15))) exitWith {

			if (45 > (random 100)) then {
				private ["_comment"];
				if ((_suspiciousEnemy distance _unit)< 40) then {
					_comment = selectRandom ["Get him!","It's one of them!","Oh shit!","Take this guy down!","Kill him!","Shoot!","Take him out!"];
					[[_suspiciousEnemy, _comment] remoteExec ["globalChat",_unit]];
				};
			};

			if ((side _suspiciousEnemy == INC_regEnySide && {80 > random 100}) || {50 > random 100}) then {
				[(group _suspiciousEnemy),"WHITE"] remoteExec ["setCombatMode",_suspiciousEnemy];
				{[ _x,"WHITE"] remoteExec ["setCombatMode",_suspiciousEnemy];} forEach (units _suspiciousEnemy);

				sleep 0.5;

				[_unit,_suspiciousEnemy] spawn {
					params ["_unit","_suspiciousEnemy"];

					_reactionTime = ((_unit distance _suspiciousEnemy) - (_unit getVariable ["INC_disguiseValue",1]));

					if (_reactionTime <= 5) then {_reactionTime = 5};

					sleep (random _reactionTime);

					[(group _suspiciousEnemy),"RED"] remoteExec ["setCombatMode",_suspiciousEnemy];
					{[ _x,"RED"] remoteExec ["setCombatMode",_suspiciousEnemy];} forEach (units _suspiciousEnemy);
				};
			};

			sleep 2;

			[_unit] call INCON_ucr_fnc_compromised;
			sleep (random 3);
			{
				[_x] call INCON_ucr_fnc_compromised;
				sleep (random 3);
			} forEach ((units _unit) select {
				(_x getVariable ["INC_anyKnowsSO",false]) &&
				{(_x distance _unit) < (3 * (_unit getVariable ["INC_disguiseValue",1]))} &&
				{((10 * (_x getVariable ["INC_disguiseValue",1])) > (random 100))}
			});
			true
		};

		if (45 > (random 100)) then {
			private ["_comment"];

			if ((_suspiciousEnemy distance _unit)< 40) then {
				switch (_unit getVariable ["INC_goneIncog",false]) do {
					case true: {
						_comment = selectRandom ["You look odd.","There's something strange about you.","Hey, who are you?","Who the fuck are you?","I don't recognise you.","I don't like the look of you.","You look strange.","What are you doing?","I'd like to know which unit you're from.","Who are you with?","You're not supposed to be here.","You're not with us are you?"];
					};
					case false: {
						_comment = selectRandom ["I recognise you from somewhere.","You hiding something?","Stop right there, let me get a good look at you.","Stop. Don't move.","Stay right there.","You better stop fucking about."];
					};
				};
				[[_suspiciousEnemy, _comment] remoteExec ["globalChat",_unit]];
			};
		};

		[_suspiciousEnemy,_unit] remoteExec ["doWatch",2];


		waitUntil {

			_suspiciousEnemy setSpeedMode "LIMITED";

			if (_unit distance _suspiciousEnemy > (15 + (random 85))) then {

				_pos = _suspiciousEnemy getHideFrom _unit;

				[_suspiciousEnemy,([_pos,10] call CBA_fnc_Randpos)] remoteExec ["doMove",2];
			};

			_reactionTime = ((_unit distance _suspiciousEnemy) - (_unit getVariable ["INC_disguiseValue",1]));

			if (_reactionTime <= 5) then {_reactionTime = 5};

			sleep (_reactionTime * (random 3));

			if !((alive _unit && {alive _suspiciousEnemy}) && {captive _unit && {_suspiciousEnemy getVariable ["INC_isSuspicious",false]}} && {((_unit getHideFrom (vehicle _unit)) distanceSqr _unit < 25)}) exitWith {true};

			sleep 0.5;

			if (((_unit getVariable ["INC_disguiseValue",1]) + ((speed _unit / 3))) > (random [3,10,30])) exitWith {


				if ((_suspiciousEnemy distance _unit)< 40) then {

					_comment = selectRandom ["Get him!","It's one of them!","Oh shit!","Surrender now!","I'll kill you!","You better surrender!","Take him down!"];
					[[_suspiciousEnemy, _comment] remoteExec ["globalChat",_unit]];
				};

				if ((side _suspiciousEnemy == INC_regEnySide && {80 > random 100}) || {50 > random 100}) then {
					[(group _suspiciousEnemy),"WHITE"] remoteExec ["setCombatMode",_suspiciousEnemy];
					{[ _x,"WHITE"] remoteExec ["setCombatMode",_suspiciousEnemy];} forEach (units _suspiciousEnemy);

					sleep 0.5;

					[_unit,_suspiciousEnemy] spawn {
						params ["_unit","_suspiciousEnemy"];

						_reactionTime = ((_unit distance _suspiciousEnemy) - (_unit getVariable ["INC_disguiseValue",1]));

						if (_reactionTime <= 5) then {_reactionTime = 5};

						sleep (_reactionTime * (random 3));

						[(group _suspiciousEnemy),"RED"] remoteExec ["setCombatMode",_suspiciousEnemy];
						{[ _x,"RED"] remoteExec ["setCombatMode",_suspiciousEnemy];} forEach (units _suspiciousEnemy);
					};
				};

				[_unit] call INCON_ucr_fnc_compromised;

				sleep (random 3);
				{
					[_x] call INCON_ucr_fnc_compromised;
					sleep (random 3);
				} forEach ((units _unit) select {
					(_x getVariable ["INC_anyKnowsSO",false]) &&
					{(_x distance _unit) < (3 * (_unit getVariable ["INC_disguiseValue",1]))} &&
					{((10 * (_x getVariable ["INC_disguiseValue",1])) > (random 100))}
				});
				true
			};


			((_unit getVariable ["INC_disguiseValue",1]) < (random [0,1.5,4]))
		};

		_suspiciousEnemy setVariable ["INC_isSuspicious",false];

		[_suspiciousEnemy,objNull] remoteExec ["doWatch",2];

		_suspiciousEnemy setSpeedMode "NORMAL";
	};

	_suspiciousEnemy setVariable ["INC_isSuspicious",false];

	[_suspiciousEnemy,objNull] remoteExec ["doWatch",2];

	_suspiciousEnemy setSpeedMode "NORMAL";
};
