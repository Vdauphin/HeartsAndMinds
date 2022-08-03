/* ----------------------------------------------------------------------------
Function: armedLoop

Description:

Performs checks on undercover units which are then saved into the variables -
* INC_goneIncog (if the unit has gone incognito or not)
* INC_canConcealWeapon (whether the unit can conceal his weapon in a uniform or backpack)
* INC_canGoLoud (whether the unit has a concealed weapon in his back back and can get it out)
* INC_firedRecent (whether the unit has recently fired)
* INC_suspiciousValue (number of suspicious things the unit is doing)
* INC_weirdoLevel (how strange the unit is acting for a given context)
* INC_radiusMulti (how much attention the unit is drawing for a given context)
Automatically includes all variables from UCR_setup.sqf so most parameters are not needed.

Parameters:
0: Unit <OBJECT>

Parameters taken from UCR_setup.sqf:
2: Are HMDs allowed <BOOL>
3: Are civilians allowed to drive offroad <BOOL>
4: Regular forces defaul detection radius in meters - units will be seen as weird if they get within this distance of a regular enemy unit <NUMBER>
5: Asym forces defaul detection radius in meters - units will be seen as weird if they get within this distance of an asymetric enemy unit <NUMBER>
6: Include racial profile checks which determine whether the unit looks like the side he is impersonating <BOOL>
7: Racial profile factor when disguised as a civilian - 1 = normal, 2 = double etc., increases the effect of racial profiling <NUMBER>
8: Racial profile factor when disguised as an enemy - 1 = normal, 2 = double etc., increases the effect of racial profiling <NUMBER>

Returns: nil

Examples:

[_unit] call INCON_ucr_fnc_armedLoop;

Author: Incontinentia
---------------------------------------------------------------------------- */


params ["_unit"];

#include "..\UCR_setup.sqf"

if (!local _unit) exitWith {};


//Armed / Incognito Stuff
//=======================================================================//
[_unit,_highSecInstantHostile,_highSecItemCheck,_highSecItemCheckScalar,_hsItChkOutside,_hsMustBeUnarmed,_globalSuspicionModifier,_HMDallowed,_noOffRoad,_regDetectRadius,_asymDetectRadius,_racism,_racProfFacCiv,_racProfFacEny] spawn {

	params ["_unit","_highSecInstantHostile","_highSecItemCheck","_highSecItemCheckScalar","_hsItChkOutside","_hsMustBeUnarmed","_globalSuspicionModifier","_HMDallowed","_noOffRoad","_regDetectRadius","_asymDetectRadius","_racism","_racProfFacCiv","_racProfFacEny"];

	private _responseTime = 0.15;

	if !(isPlayer _unit) then {_responseTime = (_responseTime * 2)}; //Repsonsiveness of script reduced for performance on AI

	sleep _responseTime;

	//Main loop
	waitUntil {

		//Handles incognito status and checks on leaving vehicle
		if ((uniform _unit in INC_incogUniforms) && {!(_unit getVariable ["INC_goneIncog",false])}) then {

			_unit setVariable ["INC_goneIncog",true];
		} else {

			if ((_unit getVariable ["INC_goneIncog",false]) && {!(uniform _unit in INC_incogUniforms)}) then {

				if !(_unit getVariable ["INC_isCompromised",false]) then {

					//If either side has seen the unit, make him compromised
					if (([_unit,INC_regEnySide,10] call INCON_ucr_fnc_isKnownExact) || {[_unit,INC_asymEnySide,10] call INCON_ucr_fnc_isKnownExact}) then {

						[_unit] call INCON_ucr_fnc_compromised;
					};
				};
			};
		};

		//While on foot
		waitUntil {

			if !(isNull objectParent _unit) exitWith {true};

			private ["_suspiciousValue","_weirdoLevel","_spotDistance","_incog"];

			_suspiciousValue = 1;
			_weirdoLevel = 1;
			_spotDistance = 1;
			_unit setVariable ["INC_canConcealWeapon",([[_unit],"ableToConceal"] call INCON_ucr_fnc_gearHandler)];
			_unit setVariable ["INC_canGoLoud",([[_unit],"ableToGoLoud"] call INCON_ucr_fnc_gearHandler)];

			sleep _responseTime;

			if (!isPlayer _unit) then {

				_unit setVariable ["INC_canSwitch",[[_unit,false],"switchUniforms"] call INCON_ucr_fnc_gearHandler];

				sleep _responseTime;

				_unit setVariable ["INC_canSwawp",[[_unit,false],"swapGear"] call INCON_ucr_fnc_gearHandler];
			};

			//Incognito check
			_incog = [[_unit],"checkIncogFoot"] call INCON_ucr_fnc_ucrMain;

			sleep _responseTime;

			switch (_incog) do {

				case true: {

					if (uniform _unit isEqualTo (_unit getVariable ["INC_activeCompUniform","NONEXISTANT"])) then {

						_suspiciousValue = _suspiciousValue + 2;
					};

					//High security area check
					switch (_unit getVariable ["INC_highSecAlert",false]) do {

						case true: {

							switch (uniform _unit in INC_highSecUniforms) do {
								case true: {

									if (_highSecItemCheck) then {
										private _suspiciousItems = ([headgear _unit, goggles _unit, ([currentWeapon _unit] call BIS_fnc_baseWeapon), hmd _unit, vest _unit, backpack _unit] select {!(_x in INC_highSecItems)});

										switch (_hsMustBeUnarmed) do {
											case true: {

												//Check if unit is armed
												if !(((currentWeapon _unit == "") || {currentWeapon _unit == "Throw"} || {currentWeapon _unit == binocular _unit}) && {primaryweapon _unit == ""} && {secondaryWeapon _unit == ""}) then {

													_suspiciousValue = _suspiciousValue + 1;
												};

												_weirdoLevel = _weirdoLevel + ((count _suspiciousItems) * _highSecItemCheckScalar);
												_spotDistance = _spotDistance + ((count _suspiciousItems)/(2 / _highSecItemCheckScalar));
											};

											case false: {

												_weirdoLevel = _weirdoLevel + ((count _suspiciousItems) * _highSecItemCheckScalar);
												_spotDistance = _spotDistance + ((count _suspiciousItems)/(2 / _highSecItemCheckScalar));
											};
										};
									};
								};

								case false: {

									switch (_highSecInstantHostile) do {
										case true: {

											_suspiciousValue = _suspiciousValue + 2;
										};

										case false: {

											_weirdoLevel = _weirdoLevel + 11;
											_spotDistance = _spotDistance + 5;
										};
									};
								};
							};
						};

						case false: {

							if (_hsItChkOutside && {_highSecItemCheck} && {uniform _unit in INC_highSecUniforms}) then {

								private _suspiciousItems = ([headgear _unit, goggles _unit, ([currentWeapon _unit] call BIS_fnc_baseWeapon), hmd _unit, vest _unit, backpack _unit] select {!(_x in INC_highSecItems)});

								switch (_hsMustBeUnarmed) do {
									case true: {

										//Check if unit is armed
										if !(((currentWeapon _unit == "") || {currentWeapon _unit == "Throw"} || {currentWeapon _unit == binocular _unit}) && {primaryweapon _unit == ""} && {secondaryWeapon _unit == ""}) then {

											_suspiciousValue = _suspiciousValue + 1;
										};

										_weirdoLevel = _weirdoLevel + ((count _suspiciousItems) * _highSecItemCheckScalar);
										_spotDistance = _spotDistance + ((count _suspiciousItems)/(2 / _highSecItemCheckScalar));
									};

									case false: {

										_weirdoLevel = _weirdoLevel + ((count _suspiciousItems) * _highSecItemCheckScalar);
										_spotDistance = _spotDistance + ((count _suspiciousItems)/(2 / _highSecItemCheckScalar));
									};
								};
							};
						};
					};

					//Only run on captive or gear checking units for performance
					if (captive _unit || {_unit getVariable ["INC_checkingDiguise",false]}) then {

						if !(backpack _unit in INC_incogBackpacks) then {
							_weirdoLevel = _weirdoLevel + 1;
							_spotDistance = _spotDistance + 1;
						};

						if !(vest _unit in INC_incogVests) then {
							_weirdoLevel = _weirdoLevel + 3;
							_spotDistance = _spotDistance + 1;
						};

						sleep _responseTime;

						if !(headgear _unit in INC_incogHeadgear) then {
							_weirdoLevel = _weirdoLevel + 0.5;

							if (((headgear _unit) find "elmet") >= 0) then {
								_weirdoLevel = _weirdoLevel + 2;
								_spotDistance = _spotDistance + 0.3;
							};
						};

						sleep _responseTime;

						if !(([currentWeapon _unit] call BIS_fnc_baseWeapon) in INC_incogWpns) then {
							_weirdoLevel = _weirdoLevel + 1.5;
							_spotDistance = _spotDistance + 0.5;
						};

						if (uniform _unit in (_unit getVariable ["INC_compromisedUniforms",[]])) then {
							_weirdoLevel = _weirdoLevel + 3;
						};

						private ["_start","_end","_obj"];

						_start = eyePos _unit;
						_end = (_start vectorAdd (_unit weaponDirection currentWeapon _unit vectorMultiply 80));
						_obj = (lineIntersectsSurfaces [_start, _end, _unit]) select 0 select 2;

						if ((!isNil "_obj") && {_obj isKindOf "Man" && {side _obj in [INC_regEnySide,INC_asymEnySide]}}) then {
							_weirdoLevel = _weirdoLevel + 10;
							_spotDistance = _spotDistance + 4;
						};

						sleep _responseTime;

						if !(_unit getVariable ["INC_shotNear",false]) then {

							if ((currentWeapon _unit == primaryWeapon _unit) && {!(weaponLowered _unit)}) then {
								_weirdoLevel = _weirdoLevel + 1;
								_spotDistance = _spotDistance + 0.5;
							};

					        switch (stance _unit == "STAND") do {

								case true: {

									if (speed _unit > 8) then {
										_weirdoLevel = _weirdoLevel + 0.3;
										_spotDistance = _spotDistance + 1.5;

										if (speed _unit > 17) then {
											_weirdoLevel = _weirdoLevel + 1;
											_spotDistance = _spotDistance + 3;
										};
									};
								};

								case false: {
									_weirdoLevel = _weirdoLevel + 2;
									_spotDistance = _spotDistance + 2;

							        if (speed _unit > 2) then {
										_weirdoLevel = _weirdoLevel + 1;
										_spotDistance = _spotDistance + 2;

								        if (speed _unit > 5) then {
											_weirdoLevel = _weirdoLevel + 1;
											_spotDistance = _spotDistance + 1;
										};
									};
								};
							};
						};

						sleep _responseTime;

						//Racial profiling checks
						if (!(_unit getVariable ["INC_faceFits",true]) && {_racism}) then {

							if (headgear _unit == "") then {
								_weirdoLevel = _weirdoLevel + (2 * _racProfFacEny);
								_spotDistance = _spotDistance + (2 * _racProfFacEny);
							};

							if (goggles _unit == ""  && {((headgear _unit) find "alaclava") == -1} && {((headgear _unit) find "hemag") == -1}) then {

								_weirdoLevel = _weirdoLevel + (4 * _racProfFacEny);
								_spotDistance = _spotDistance + (2 * _racProfFacEny);

							} else {

								if ((((goggles _unit) find "andanna") >= 0) || {((goggles _unit) find "carf") >= 0}) then {
									_weirdoLevel = _weirdoLevel + (2 * _racProfFacEny);
									_spotDistance = _spotDistance + (0.5 * _racProfFacEny);

								} else {

									//If the unit isn't wearing a bandana but is wearing something else, and is not wearing a balaclava...
									if ((((goggles _unit) find "alaclava") == -1) && {((headgear _unit) find "alaclava") == -1} && {((headgear _unit) find "hemag") == -1}) then {

										_weirdoLevel = _weirdoLevel + (3 * _racProfFacEny);
										_spotDistance = _spotDistance + (1.5 * _racProfFacEny);
									} else {

										//If the unit is wearing a balaclava
										if (!(headgear _unit in INC_incogHeadgear) || {!(goggles _unit in INC_incogHeadgear)}) then {
											_weirdoLevel = _weirdoLevel + 1.5;
										};
									};
								};
							};
						};
					};
				};

				case false: {

					//Check if unit is wearing anything suspicious
					if (!(uniform _unit in INC_civilianUniforms) || {!(vest _unit in INC_civilianVests)}) then {

						_suspiciousValue = _suspiciousValue + 1;
					};

					if (uniform _unit isEqualTo (_unit getVariable ["INC_activeCompUniform","NONEXISTANT"])) then {

						_suspiciousValue = _suspiciousValue + 1;
					};

					sleep _responseTime;

					//Check if unit is armed
					if !(((currentWeapon _unit == "") || {currentWeapon _unit == "Throw"} || {currentWeapon _unit == binocular _unit}) && {primaryweapon _unit == ""} && {secondaryWeapon _unit == ""}) then {

						_suspiciousValue = _suspiciousValue + 1;
					};

					//Trespass check
					if (_unit getVariable ["INC_trespassAlert",false]) then {

						_suspiciousValue = _suspiciousValue + 1;
					};

					sleep _responseTime;

					//Oddball check (only done if the unit is captive or checking disguise)
					if (((captive _unit) && {_suspiciousValue == 1}) || {_unit getVariable ["INC_checkingDiguise",false]}) then {

						//Check if unit is wearing anything suspicious
						if ((((headgear _unit) find "elmet") >= 0) || {(((goggles _unit) find "alaclava") >= 0) || {((headgear _unit) find "alaclava") >= 0}} || {((headgear _unit) find "hemag") >= 0}) then {

							_weirdoLevel = _weirdoLevel + 5;
							_spotDistance = _spotDistance + 2;
						};

						{
							if (side _x == INC_regEnySide) exitWith {
								_weirdoLevel = _weirdoLevel + ((_regDetectRadius - (_x distance _unit)) / 2);
								true
							};
							if (side _x == INC_asymEnySide) exitWith {
								_weirdoLevel = _weirdoLevel + ((_asymDetectRadius - (_x distance _unit)) / 2);
								true
							};
						} forEach (_unit nearEntities ((_regDetectRadius + _asymDetectRadius)/2));

						sleep _responseTime;

						if !(headgear _unit in INC_civilianHeadgear) then {
							_weirdoLevel = _weirdoLevel + 1;
							_spotDistance = _spotDistance + 0.5;
						};

						if ((hmd _unit != "") && !(_HMDallowed)) then {
							_weirdoLevel = _weirdoLevel + 3;
							_spotDistance = _spotDistance + 1;
						};

						sleep _responseTime;

						if !(backpack _unit in INC_civilianBackpacks) then {
							_weirdoLevel = _weirdoLevel + 1;
							_spotDistance = _spotDistance + 0.5;
						};

						if ((binocular _unit == currentWeapon _unit) && {binocular _unit != ""}) then {
							_weirdoLevel = _weirdoLevel + 5;
							_spotDistance = _spotDistance + 3;
						};

						if (_unit getVariable ["INC_firedRecent",false]) then {
							_weirdoLevel = _weirdoLevel + 2;
						};

						if (uniform _unit in (_unit getVariable ["INC_compromisedUniforms",[]])) then {
							_weirdoLevel = _weirdoLevel + 3;
						};

						sleep _responseTime;

						if !(_unit getVariable ["INC_shotNear",false]) then {

							switch (stance _unit == "STAND") do {

								case true: {
									if (speed _unit > 8) then {
										_weirdoLevel = _weirdoLevel + 0.3;
										_spotDistance = _spotDistance + 1.5;

										if (speed _unit > 17) then {
											_weirdoLevel = _weirdoLevel + 1;
											_spotDistance = _spotDistance + 3;
										};
									};
								};

								case false: {
									_weirdoLevel = _weirdoLevel + 4;
									_spotDistance = _spotDistance + 3;

							        if (speed _unit > 2) then {
										_weirdoLevel = _weirdoLevel + 1;
										_spotDistance = _spotDistance + 1.5;

								        if (speed _unit > 5) then {
											_weirdoLevel = _weirdoLevel + 1;
											_spotDistance = _spotDistance + 1.5;
										};
									};
								};
							};
						};

						sleep _responseTime;

						//Racial profiling checks
						if (!(_unit getVariable ["INC_faceFits",true]) && {_racism}) then {

							if (headgear _unit == "") then {
								_weirdoLevel = _weirdoLevel + (1 * _racProfFacCiv);
								_spotDistance = _spotDistance + (2 * _racProfFacCiv);
							};

							if (goggles _unit == "") then {

								_weirdoLevel = _weirdoLevel + (3 * _racProfFacCiv);
								_spotDistance = _spotDistance + (1.5 * _racProfFacCiv);

							} else {

								if ((((goggles _unit) find "andanna") >= 0) || {((goggles _unit) find "carf") >= 0}) then {
									_weirdoLevel = _weirdoLevel + (2 * _racProfFacCiv);
									_spotDistance = _spotDistance + (1 * _racProfFacCiv);

								} else {
									_weirdoLevel = _weirdoLevel + (2 * _racProfFacCiv);
									_spotDistance = _spotDistance + (1 * _racProfFacCiv);
								};
							};
						};
					};
				};
			};

			sleep _responseTime;

			if (_unit getVariable ["INC_justFired",false]) then {
				_suspiciousValue = _suspiciousValue + 2;

				if !(_unit getVariable ["INC_firedRecent",false]) then {

					_unit setVariable ["INC_firedRecent",true];

					[_unit] spawn {
						params ["_unit"];
						sleep (60 + (random 300));
						_unit setVariable ["INC_firedRecent",false];
					};
				};
			};

			//Proximity alert scenario
			if ((_unit getVariable ["INC_proxAlert",false]) && {!(_unit getVariable ["INC_isCompromised",false])}) then {

				private ["_nearMines","_suspiciousEnemies"];

				sleep _responseTime;

				_nearMines = {_x isKindOf "timeBombCore"} count (nearestObjects [_unit,[],3]);
				_weirdoLevel = _weirdoLevel + (_nearMines * 25);
				_spotDistance = _spotDistance + (_nearMines * 3);

				_suspiciousEnemies = ((_unit nearEntities [["Man","LandVehicle"],(_regDetectRadius * (_unit getVariable ["INC_disguiseRad",1]))]) select {
					((side _x == INC_regEnySide) || {side _x == INC_asymEnySide}) &&
					{((_x getHideFrom _unit) distanceSqr _unit < 15)} &&
					{((missionNamespace getVariable ["INC_envJumpygMulti",1]) * ((_unit getVariable ["INC_disguiseValue",1]) * 3)) > (random 100)}
				});

				if (count _suspiciousEnemies != 0) then {
					{if !(_x getVariable ["INC_isSuspicious",false]) then {[_unit,_x] call INCON_ucr_fnc_suspiciousEny}} forEach _suspiciousEnemies;
				};
			};

			sleep _responseTime;

			_unit setVariable ["INC_suspiciousValue", _suspiciousValue];
			_unit setVariable ["INC_weirdoLevel",(_weirdoLevel * _globalSuspicionModifier)];
			_unit setVariable ["INC_radiusMulti",_spotDistance];
			_unit setVariable ["INC_checkingDiguise",false];

			(!(isNull objectParent _unit) || {!alive _unit})
		};


		sleep _responseTime;


		//While in a vehicle
		waitUntil {

			if (isNull objectParent _unit) exitWith {true};

			private ["_suspiciousValue","_weirdoLevel","_spotDistance","_vehDescription","_vehFullOpen","_vehicle","_vehFullOpen","_vehFullClosed"];

			_vehicle = vehicle _unit;

			if ((_vehicle getVariable ["INC_vehDescription","UNASSIGNED"]) == "UNASSIGNED") then {

			    _vehDescription = format ["%1%2%3",(getText (configfile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName")),(typeOf _vehicle),(getText (configfile >> "CfgVehicles" >> (typeOf _vehicle) >> "editorSubcategory"))];

			    _vehicle setVariable ["INC_vehDescription",_vehDescription];
			};

			_vehDescription = _vehicle getVariable ["INC_vehDescription","UNASSIGNED"];

			_vehFullOpen =  ((getText (configfile >> "CfgVehicles" >> (typeOf _vehicle) >> "attenuationEffectType")) == "OpenCarAttenuation");

			_vehFullClosed = ((getText (configfile >> "CfgVehicles" >> (typeOf _vehicle) >> "attenuationEffectType")) == "TankAttenuation");

			_suspiciousValue = 1;
			_weirdoLevel = 1;
			_spotDistance = 1;
			_unit setVariable ["INC_canConcealWeapon",([[_unit],"ableToConceal"] call INCON_ucr_fnc_gearHandler)];
			_unit setVariable ["INC_canGoLoud",([[_unit],"ableToGoLoud"] call INCON_ucr_fnc_gearHandler)];

			sleep _responseTime;

			//Incognito check
			_incog = [[_unit],"checkIncogVeh"] call INCON_ucr_fnc_ucrMain;

			sleep _responseTime;

			switch (_incog) do {

				case true: {

					//Suspicious vehicle check
					if (_vehicle getVariable ["INC_naughtyVehicle",false]) then {

						_suspiciousValue = _suspiciousValue + 1;
					};

					sleep _responseTime;

					//Oddball check
					if (captive _unit || {!isNull objectParent _unit && {!(_unit getVariable ["INC_isCompromised",false])}}) then {

						if (driver _vehicle == _unit) then {

							_weirdoLevel = _weirdoLevel + (((speed _unit) + 1)/ 50);
							_spotDistance = _spotDistance + (((speed _unit) + 1)/ 10);

							//Headlights check for moving vehicle at night
							if (
								!(missionNamespace getVariable ["INC_isDaytime",true]) &&
								{!isLightOn _vehicle} &&
								{speed _unit > 5} &&
								{_vehicle isKindOf "LandVehicle"}
							) then {
								_weirdoLevel = _weirdoLevel + 4;
								_spotDistance = _spotDistance + 3;
							};
						};

						sleep _responseTime;

						//Incognito uniform check for non-tank, non-covered vehicles
						if ((((_vehDescription find "overed") == -1) || {_unit == driver _vehicle} || {count assignedVehicleRole _unit == 2}) && {(!_vehFullClosed) || {isTurnedOut _unit}}) then {
						    if (
						        (

						            ((_vehDescription find "ffroad") >= 1) ||
						            {(_vehDescription find "pen") >= 1} ||
						            {(_vehDescription find "ransport") >= 1} ||
						            {_vehFullOpen} ||
						            {isTurnedOut _unit}
						        ) && {
						            ((_vehDescription find "overed") == -1) &&
						            {!_vehFullClosed} &&
						            {
						                (count assignedVehicleRole _unit == 2) ||
						                {_vehFullOpen}
						            }
						        }
						    ) then {
								_racProfFacEny = _racProfFacEny * 1;
						        if !(uniform _unit in INC_incogUniforms) then {
						            _weirdoLevel = _weirdoLevel + 15;
						            _spotDistance = _spotDistance + 8;
						        };

								if !(vest _unit in INC_incogVests) then {
									_weirdoLevel = _weirdoLevel + 4;
									_spotDistance = _spotDistance + 2;
								};

								if !(headgear _unit in INC_incogHeadgear) then {
									_weirdoLevel = _weirdoLevel + 2;

									if (((headgear _unit) find "elmet") >= 0) then {
										_weirdoLevel = _weirdoLevel + 1;
										_spotDistance = _spotDistance + 0.5;
									};
								};
						    } else {

								_racProfFacEny = _racProfFacEny * 0.5;
						        if (!(uniform _unit in INC_incogUniforms) && {(_vehDescription find "MRAP") == -1 || {driver _vehicle == _unit}}) then {
						            _weirdoLevel = _weirdoLevel + 12;
						            _spotDistance = _spotDistance + 1;

									if !(vest _unit in INC_incogVests) then {
										_weirdoLevel = _weirdoLevel + 3;
										_spotDistance = _spotDistance + 1;
									};
						        };
						    };

							sleep _responseTime;

							//Racial profiling checks
							if (!(_unit getVariable ["INC_faceFits",true]) && {_racism} && {!(_vehicle isKindOf "Tank")}) then {

								if (headgear _unit == "") then {
									_weirdoLevel = _weirdoLevel + (1.5 * _racProfFacEny);
									_spotDistance = _spotDistance + (0.5 * _racProfFacEny);
								};

								if (goggles _unit == ""  && {((headgear _unit) find "alaclava") == -1} && {((headgear _unit) find "hemag") == -1}) then {

									_weirdoLevel = _weirdoLevel + (2.5 * _racProfFacEny);
									_spotDistance = _spotDistance + (1 * _racProfFacEny);

								} else {

									if ((((goggles _unit) find "andanna") >= 0) || {((goggles _unit) find "carf") >= 0}) then {
										_weirdoLevel = _weirdoLevel + (0.5 * _racProfFacEny);
										_spotDistance = _spotDistance + (0.5 * _racProfFacEny);

									} else {

										if ((((goggles _unit) find "alaclava") >= 0) || {((headgear _unit) find "alaclava") >= 0}  || {((headgear _unit) find "hemag") >= 0}) then {

											if (!(headgear _unit in INC_incogHeadgear) || {!(goggles _unit in INC_incogHeadgear)}) then {
												_weirdoLevel = _weirdoLevel + (0.5 * _racProfFacEny);
											};

										} else {

											if (!(headgear _unit in INC_incogHeadgear) || {!(goggles _unit in INC_incogHeadgear)}) then {
												_weirdoLevel = _weirdoLevel + (1 * _racProfFacEny);
											};
											_weirdoLevel = _weirdoLevel + (0.5 * _racProfFacEny);
										};
									};
								};
							};
						};

						sleep _responseTime;

						//Offroad check
						if ((_noOffRoad) && {speed _unit > 5} && {(_vehicle isKindOf "Land")} && {((count (_unit nearRoads 30)) == 0)}) then {

							_weirdoLevel = _weirdoLevel + 3;
							_spotDistance = _spotDistance + 2;
						};

						//Trespass check
						if (_unit getVariable ["INC_trespassAlert",false]) then {

							_weirdoLevel = _weirdoLevel + 2;
							_spotDistance = _spotDistance + 2;
						};

						//High security area check
						if (_unit getVariable ["INC_highSecAlert",false]) then {

							switch ((typeOf vehicle _unit) in INC_incogHighSecVeh) do {

								case true: {
									if (!(uniform _unit in INC_highSecUniforms) && {!_vehFullClosed}) then {

										_weirdoLevel = _weirdoLevel * 2;

										if (_vehFullOpen) then {

											_weirdoLevel = _weirdoLevel * 2;
										};
									};
								};

								case false: {

										switch (_highSecInstantHostile) do {
										case true: {

											_suspiciousValue = _suspiciousValue + 2;
										};

										case false: {

											_weirdoLevel = _weirdoLevel + 11;
											_spotDistance = _spotDistance + 5;
										};
									};
								};
							};
						};
					};
				};

				case false: {

					//Suspicious vehicle check
					if (!((typeof _vehicle) in INC_civilianVehicleArray) || {(_vehicle getVariable ["INC_naughtyVehicle",false])}) then {

						_suspiciousValue = _suspiciousValue + 1;
					};

					//Trespass check
					if (_unit getVariable ["INC_trespassAlert",false]) then {

						_suspiciousValue = _suspiciousValue + 1;
					};

					if (driver _vehicle == _unit) then {

						//Headlights check for moving land vehicle at night
						if (
							!(missionNamespace getVariable ["INC_isDaytime",true]) &&
							{!isLightOn _vehicle} &&
							{_vehicle isKindOf "LandVehicle"} &&
							{speed _unit > 5}
						) then {
							_suspiciousValue = _suspiciousValue + 1;
						};

						sleep _responseTime;

						//Offroad check
						if ((_noOffRoad && {speed _unit > 1}) && {(_vehicle isKindOf "Land")} && {((count (_unit nearRoads 30)) == 0)}) then {

							_suspiciousValue = _suspiciousValue + 1;
						};
					};

					sleep _responseTime;

					//Oddball check --- add in speed
					if (captive _unit || {!isNull objectParent _unit && {!(_unit getVariable ["INC_isCompromised",false])}}) then {

						if (driver _vehicle == _unit) then {

							if ((!_noOffRoad && {speed _unit > 5}) && {_vehicle isKindOf "Land" && {(count (_unit nearRoads 30)) == 0}}) then {

								_weirdoLevel = _weirdoLevel + 4;
								_spotDistance = _spotDistance + 4;
							};

							_weirdoLevel = _weirdoLevel + (((speed _unit) + 1)/ 40);
							_spotDistance = _spotDistance + (((speed _unit) + 1)/ 8);
						};

						sleep _responseTime;

						if ((((_vehDescription find "overed") == -1) || {_unit == driver _vehicle} || {count assignedVehicleRole _unit == 2}) && {(!_vehFullClosed) || {isTurnedOut _unit}}) then {
						    if (
						        (

						            ((_vehDescription find "ffroad") >= 1) ||
						            {(_vehDescription find "pen") >= 1} ||
						            {(_vehDescription find "ransport") >= 1} ||
						            {_vehFullOpen} ||
						            {isTurnedOut _unit}
						        ) && {
						            ((_vehDescription find "overed") == -1) &&
						            {!_vehFullClosed} &&
						            {
						                (count assignedVehicleRole _unit == 2) ||
						                {_vehFullOpen}
						            }
						        }
						    ) then {

						        if !(((uniform _unit in INC_civilianUniforms) || {(uniform _unit in INC_incogUniforms)})) then {
						            _weirdoLevel = _weirdoLevel + 15;
						            _spotDistance = _spotDistance + 8;
						        };

						        if (!(((currentWeapon _unit == "") || {currentWeapon _unit == "Throw"} || {currentWeapon _unit == binocular _unit}) && {primaryweapon _unit == ""} && {secondaryWeapon _unit == ""}) && {count assignedVehicleRole _unit == 2 && {!_vehFullClosed} && {(_vehDescription find "MRAP") == -1}}) then {

						            if !(weaponLowered _unit) then {
										_weirdoLevel = _weirdoLevel + 12;
						                _spotDistance = _spotDistance + 7;

						            } else {
										_weirdoLevel = _weirdoLevel + 3;
						            };
						        };
						    } else {
						        if !(((uniform _unit in INC_civilianUniforms) || {(uniform _unit in INC_incogUniforms)})) then {
						            _weirdoLevel = _weirdoLevel + 6;
						            _spotDistance = _spotDistance + 1;
						        };

						        if (!(((currentWeapon _unit == "") || {currentWeapon _unit == "Throw"} || {currentWeapon _unit == binocular _unit}) && {primaryweapon _unit == ""} && {secondaryWeapon _unit == ""}) && {count assignedVehicleRole _unit == 2 && {!_vehFullClosed} && {(_vehDescription find "MRAP") == -1}}) then {

						            if !(weaponLowered _unit) then {
						                _weirdoLevel = _weirdoLevel + 12;
						                _spotDistance = _spotDistance + 2;
						            } else {
						                _weirdoLevel = _weirdoLevel + 8;
						            };
						        };
						    };

							sleep _responseTime;

							//Racial profiling checks
							if (!(_unit getVariable ["INC_faceFits",true]) && {_racism}) then {

								switch (true) do {

									case (headgear _unit == ""): {
										_weirdoLevel = _weirdoLevel + (0.5 * _racProfFacCiv);
									};

									case (goggles _unit == ""): {

										_weirdoLevel = _weirdoLevel + (2 * _racProfFacCiv);
										_spotDistance = _spotDistance + (1 * _racProfFacCiv);
									};

									case !((((goggles _unit) find "andanna") >= 0) || {((goggles _unit) find "carf") >= 0}): {

										_weirdoLevel = _weirdoLevel + (1 * _racProfFacCiv);
										_spotDistance = _spotDistance + (1 * _racProfFacCiv);
									};

									_weirdoLevel = _weirdoLevel + (1 * _racProfFacCiv);
								};
							};
						};

						sleep _responseTime;

				    	if !(vest _unit in INC_civilianVests) then {
							_weirdoLevel = _weirdoLevel + 3;
							_spotDistance = _spotDistance + 1;
						};

						if ((hmd _unit != "") && {!(_HMDallowed)}) then {
							_weirdoLevel = _weirdoLevel + 2;
						};

						if (uniform _unit isEqualTo (_unit getVariable ["INC_activeCompUniform","NONEXISTANT"])) then {
							_weirdoLevel = _weirdoLevel + 3;
						};
					};
				};
			};

			sleep _responseTime;

			if (_unit getVariable ["INC_justFired",false]) then {
				_suspiciousValue = _suspiciousValue + 2;

				if !(_unit getVariable ["INC_firedRecent",false]) then {
					_unit setVariable ["INC_firedRecent",true];

					[_unit] spawn {
						params ["_unit"];
						sleep (60 + (random 300));
						_unit setVariable ["INC_firedRecent",false];
					};
				};
			};

			//Proximity alert scenario
			if (_unit getVariable ["INC_proxAlert",false]) then {

				private ["_suspiciousEnemies"];

				sleep _responseTime;

				_suspiciousEnemies = ((_vehicle nearEntities [["Man","LandVehicle"],(_regDetectRadius * (_unit getVariable ["INC_disguiseRad",1]))]) select {
					((side _x == INC_regEnySide) || {side _x == INC_asymEnySide}) &&
					{((_x getHideFrom _vehicle) distanceSqr _unit < 10)} &&
					{((missionNamespace getVariable ["INC_envJumpygMulti",1]) * ((_unit getVariable ["INC_disguiseValue",1]) * 3)) > (random 100)}
				});

				if (count _suspiciousEnemies != 0) then {
					{
						if !(_x getVariable ["INC_isSuspicious",false]) then {
							[_unit,_x] call INCON_ucr_fnc_suspiciousEny;
						};
						if ((_unit getVariable ["INC_disguiseValue",1]) > (7 + (random 45))) then {
							[_x,[_unit,3]] remoteExec ["reveal",_x];
						};
					} forEach _suspiciousEnemies;
				};
			};

			sleep _responseTime;

			_unit setVariable ["INC_suspiciousValue", _suspiciousValue];
			_unit setVariable ["INC_weirdoLevel",(_weirdoLevel * _globalSuspicionModifier)];
			_unit setVariable ["INC_radiusMulti",_spotDistance];
			_unit setVariable ["INC_checkingDiguise",false];

			((isNull objectParent _unit) || {!alive _unit})
		};

		(!(_unit getVariable ["isUndercover",false]) || {!(alive _unit)} || {!local _unit})
	};

	_unit setVariable ["INC_undercoverLoopsActive", false]; // Stops the script running twice on the same unit
};
