/* ----------------------------------------------------------------------------
Function: UCRHandler

Description: Sets various loops and eventhandlers that are required for undercover detection.

Parameters:
0: The undercover unit <OBJECT>

Returns: Nil

Examples:
[_unit] call INCON_ucr_fnc_UCRhandler;

Author: Incontinentia
---------------------------------------------------------------------------- */

params [["_unit",objNull]];

#include "..\UCR_setup.sqf"

if ((_unit getVariable ["INC_undercoverLoopsActive",false]) || {(!local _unit)}) exitWith {};

_unit setVariable ["INC_undercoverLoopsActive", true]; // Stops the script running twice on the same unit

_unit setVariable ["INC_proxAlert",false]; //Proximity
_unit setVariable ["INC_trespassAlert",false]; //Trespassing
_unit setVariable ["INC_suspiciousValue", 1]; //How suspicious is the unit
_unit setVariable ["INC_weirdoLevel",1]; //How weird is the unit acting
_unit setVariable ["INC_weaponStore",[["",[""]],["",[""]]]];

if (isPlayer _unit) then {
	[[_unit,_unit,false],"addConcealActions"] call INCON_ucr_fnc_ucrMain;
};


//Proximity / Trespass Stuff - sets variables to be picked up by armed/suspicious loop
//=======================================================================//
[_unit,_fullAIfunctionality,_regDetectRadius,_asymDetectRadius] spawn {
	params [["_unit",player],"_fullAIfunctionality",["_regDetectRadius",15],["_asymDetectRadius",25],["_radius3",60],["_radius4",200]];

	private ["_nearReg","_nearAsym","_nearHVT","_nearSuperHVT","_nearMines"];

	waitUntil {

		//Make AI stop targetting people when incognito
		if !(isPlayer _unit) then {
			if ((combatMode _unit) in ["BLUE", "GREEN", "WHITE"]) then {
				switch ((behaviour _unit == "SAFE") || {(behaviour _unit == "AWARE")}) do {
					case true: {
						switch (captive _unit) do {
							case true: {
								_unit disableAI "AUTOTARGET";
							};

							case false: {
								_unit enableAI "AUTOTARGET";
							};
						};
					};
					case false: {
						_unit enableAI "AUTOTARGET";
					};
				};
			} else {
				_unit enableAI "AUTOTARGET";
			};
		};

		sleep 0.1;

		//Proximity check (doesn't run if the unit isn't trying to be sneaky)
		if (((isPlayer _unit) || {_fullAIfunctionality}) && {captive _unit || {!isNull objectParent _unit && {!(_unit getVariable ["INC_isCompromised",false])}}}) then {

			private ["_disguiseValue","_disguiseRadius","_veh"];

			_disguiseValue = ((_unit getVariable ["INC_compromisedValue",1]) * (_unit getVariable ["INC_weirdoLevel",1]));

			_disguiseRadius = ((_unit getVariable ["INC_compromisedValue",1]) * (_unit getVariable ["INC_radiusMulti",1]) * (missionNamespace getVariable ["INC_envDisgMulti",1]));

			sleep 0.2;

			_unit setVariable ["INC_disguiseValue",_disguiseValue];

			_unit setVariable ["INC_disguiseRad",_disguiseRadius];

			_veh = (vehicle _unit);

			switch (_unit getVariable ["INC_goneIncog",false]) do {

				case true: {

					if (_disguiseValue >= 2) then {

						_nearReg = count (
							(_unit nearEntities ((_regDetectRadius * _disguiseRadius) * 0.7)) select {
								(side _x == INC_regEnySide) &&
								{((_x getHideFrom _veh) distanceSqr _veh < 10)} &&
								{(_x knowsAbout _veh) > 2} &&
								{
									_disguiseValue > (5 + (random 10)) ||
									{(_disguiseValue * (1 + ((_regDetectRadius * _disguiseRadius) / (_x distance _unit)))) > (random 100)}
								}
							}
						);

						sleep 0.3;

						_nearAsym = count (
							(_unit nearEntities ((_asymDetectRadius * _disguiseRadius) * 1.5)) select {
								(side _x == INC_asymEnySide) &&
								{((_x getHideFrom _veh) distanceSqr _veh < 10)} &&
								{(_x knowsAbout _veh) > 3} &&
								{
									_disguiseValue > (5 + (random 10)) ||
									{(_disguiseValue * (1 + ((_asymDetectRadius * _disguiseRadius) / (_x distance _unit)))) > (random 100)}
								}
							}
						);
					} else {
						_nearReg = 0;
						_nearAsym = 0;
					};
				};

				case false: {

					if (_disguiseValue >= 2) then {

						_nearReg = count (
							(_unit nearEntities (_regDetectRadius * _disguiseRadius)) select {
								(side _x == INC_regEnySide) &&
								{(_x knowsAbout _veh) > 3}
							}
						);

						sleep 0.3;

						_nearAsym = count (
							(_unit nearEntities (_asymDetectRadius * _disguiseRadius)) select {
								(side _x == INC_asymEnySide) &&
								{(_x knowsAbout _veh) > 2}
							}
						);
					} else {
						_nearReg = 0;
						_nearAsym = 0;
					};
				};
			};

			sleep 0.3;

			_nearMines = {_x isKindOf "timeBombCore"} count (nearestObjects [_unit,[],4]);

			sleep 0.3;

			if ((_nearAsym + _nearReg + _nearMines) != 0) then {
				_unit setVariable ["INC_proxAlert",true];
			} else {
				_unit setVariable ["INC_proxAlert",false];
			};
		};

        sleep 0.2;

		//Trespassing check
		if !(_unit getVariable ["INC_trespassAlert",true]) then {
	        {
	            if (_unit inArea _x) exitWith {

	                private _activeMarker = _x;

	                _unit setVariable ["INC_trespassAlert",true];

					[_unit,_activeMarker] spawn {
						params ["_unit","_activeMarker"];

						waitUntil {

							sleep 1;

							!(_unit inArea _activeMarker);
						};
						_unit setVariable ["INC_trespassAlert",false];

					};
				};

	            false
	        } count INC_trespassMarkers;
		};

		sleep 0.1;

		//High security check
		if ((missionNamespace getVariable ["INC_highSecCheckActive",false]) && {_unit getVariable ["INC_goneIncog",false]} && {_unit getVariable ["INC_trespassAlert",false]}) then {

			if !(_unit getVariable ["INC_highSecAlert",true]) then {
		        {
		            if (_unit inArea _x) exitWith {

		                private _activeMarker = _x;

		                _unit setVariable ["INC_highSecAlert",true];

						[_unit,_activeMarker] spawn {
							params ["_unit","_activeMarker"];

							waitUntil {

								sleep 1;

								!(_unit inArea _activeMarker);
							};
							_unit setVariable ["INC_highSecAlert",false];

						};
					};

		            false
		        } count INC_highSecMarkers;
			};
		};

		sleep 0.2;

		(!(_unit getVariable ["isUndercover",false]) || {!(alive _unit)} || {!local _unit})
	};
};

[_unit] call INCON_ucr_fnc_armedLoop;

//Detection Stuff
//=======================================================================//
[_unit] spawn {

	params ["_unit"];

	waitUntil {

		sleep 2;

		private _alertedRegKnows = ([_unit, INC_regEnySide] call INCON_ucr_fnc_isKnownToSide);

		private _alertedAsymKnows = ([_unit, INC_asymEnySide] call INCON_ucr_fnc_isKnownToSide);

		private _anyAlerted = false;

		if (_alertedRegKnows || {_alertedAsymKnows}) then {_anyAlerted = true};

		//Publicise variables on undercover unit for undercover handler, killed handler & cooldown.
		_unit setVariable ["INC_regKnowsSO", _alertedRegKnows, true];
		_unit setVariable ["INC_asymKnowsSO", _alertedAsymKnows, true];
		_unit setVariable ["INC_anyKnowsSO", _anyAlerted, true];

		sleep 0.2;

		if !(_unit getVariable ["INC_isCompromised",false]) then {

			private _compValue = _unit getVariable ["INC_compromisedValue",1];

			if (_compValue > 1) then {

				private _coolOffIncriment = random 0.002;

				if !(_anyAlerted) then {_coolOffIncriment = _coolOffIncriment * 5};

				_unit setVariable ["INC_compromisedValue",(_compValue - _coolOffIncriment),true];
			};

			sleep 0.2;

			if (_compValue > 2) then {

				_compDistMulti = ((getPosWorld _unit) distance (_unit getVariable ["INC_lastSeenLoc",(getPosWorld _unit)])) / 40000;

				if (_compDistMulti == 0) then {_compDistMulti = 0.002};

				if !(_anyAlerted) then {_compDistMulti = (_compDistMulti * (10 * _compValue))};

				_unit setVariable ["INC_compromisedValue",(_compValue - _compDistMulti),true];
			};

			sleep 0.2;

			if (_compValue < 1) then {
				_unit setVariable ["INC_compromisedValue",1,true];
			};
		};

		(!(_unit getVariable ["isUndercover",false]) || !(alive _unit))
	};
};

//Fired EventHandler
_unit addEventHandler["FiredMan", {
	params["_unit"];

	//If he's already compromised, do nothing
	if !(_unit getVariable ["INC_isCompromised",false]) then {

		//Smell of cordite on clothes...
		if !(_unit getVariable ["INC_justFired",false]) then {

			_unit setVariable ["INC_justFired",true];

			[_unit] spawn {
				params ["_unit"];
				sleep (15 + (random 5));
				_unit setVariable ["INC_justFired",false];
			};
		};

		//If anybody is aware of the unit and the unit isn't incognito, then compromise him
		if (_unit getVariable ["INC_anyKnowsSO",false]) then {

			//Once people know where he is, who he is, and that he has fired a weapon, make him compromised
			if (([_unit, INC_regEnySide,40] call INCON_ucr_fnc_isKnownExact) || {([_unit, INC_asymEnySide,40] call INCON_ucr_fnc_isKnownExact)}) exitWith {

				[_unit] call INCON_ucr_fnc_compromised;
			};
		};
	};
}];

//Vehicle compromised
_unit addEventHandler["GetInMan", {
	params["_unit","_position","_vehicle","_turret"];

	if (_vehicle getVariable ["INC_naughtyVehicle",false]) then {

		if (([_unit, INC_regEnySide,10] call INCON_ucr_fnc_isKnownExact) || {([_unit, INC_asymEnySide,10] call INCON_ucr_fnc_isKnownExact)}) exitWith {

			[_unit,true] call INCON_ucr_fnc_compromised;
		};
	};

	if !(_vehicle getVariable ["INC_naughtyVehicle",false]) then {

		if ((([_unit, INC_regEnySide,30] call INCON_ucr_fnc_isKnownExact) || {([_unit, INC_asymEnySide,30] call INCON_ucr_fnc_isKnownExact)}) && {(_unit getVariable ["INC_isCompromised",false])}) exitWith {

			[_unit] call INCON_ucr_fnc_compromised;
		};
	};
}];

_unit addEventHandler["GetOutMan", {
	params["_unit","_position","_vehicle","_turret"];

	if (_vehicle getVariable ["INC_naughtyVehicle",false]) then {

		if (([_unit, INC_regEnySide,10] call INCON_ucr_fnc_isKnownExact) || {([_unit, INC_asymEnySide,10] call INCON_ucr_fnc_isKnownExact)}) exitWith {

			[_unit,true] call INCON_ucr_fnc_compromised;
		};
	};
}];

//Shot at nearby EventHandler
if ((isPlayer _unit) || {_fullAIfunctionality}) then {
	_unit addEventHandler["FiredNear", {
		params["_unit"];

		if (_unit == (_this select 7)) exitWith {};

		//If he's doing crazy shit, do nothing
		if (captive _unit) then {

			//If unit hasn't been fired near before
			if !(_unit getVariable ["INC_shotNear",false]) then {

				_unit setVariable ["INC_shotNear",true];

				[_unit] spawn {
					params ["_unit"];
					_cooldownTimer = (60 + (random 120));

					waitUntil {
						sleep 3;
						_cooldownTimer = (_cooldownTimer - 3);
						(!(_unit getVariable ["INC_AnyKnowsSO",false]) || {_cooldownTimer <= 0})
					};
					_unit setVariable ["INC_shotNear",false];
				};
			};
		};
	}];
};

//Environmental loop (runs once per mission)
if ((isPlayer _unit) && {!(missionNamespace getVariable ["INC_envLoopActive",false])}) then {
	[_unit] spawn {
		params ["_unit"];
		private ["_daylightMulti","_jumpinessMulti"];

		missionNamespace setVariable ["INC_envLoopActive",true,true];

		waitUntil {

			if ((daytime > INC_firstLight) && {daytime < INC_lastLight}) then {
				_daylightMulti = 1;
				_jumpinessMulti = 1;
				missionNamespace setVariable ["INC_isDaytime",true,true];
			} else {
				_daylightMulti = (0.5 + (((moonIntensity - (overcast))/4)));
				_jumpinessMulti = 2;
				missionNamespace setVariable ["INC_isDaytime",false,true];
			};

			if (((_daylightMulti - (fog/4) - (rain/5))) < 0.2) then {
				missionNamespace setVariable ["INC_envDisgMulti",0.2];
			} else {
				missionNamespace setVariable ["INC_envDisgMulti",(_daylightMulti - (fog/4) - (rain/5))];
			};

			missionNamespace setVariable ["INC_envJumpygMulti",_jumpinessMulti];

			sleep 15;

			(!local _unit)
		};
		missionNamespace setVariable ["INC_envLoopActive",false,true];
	};
};
