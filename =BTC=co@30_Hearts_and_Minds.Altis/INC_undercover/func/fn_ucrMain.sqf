/* ----------------------------------------------------------------------------
Function: ucrMain

Description: Contains functions required for Incon Undercover.

Parameters:
0: Input <ANY>
1: Operation <STRING>

Returns: Depends on operation.

Examples:
[[_unit,false],"SwitchUniformAction"] call INCON_ucr_fnc_ucrMain;

Author: Incontinentia
---------------------------------------------------------------------------- */

params [["_input",objNull],["_operation","addConcealedRifle"]];

private ["_return"];

_return = false;

#include "..\UCR_setup.sqf"

switch (_operation) do {

	case "captiveCheck": {

		_input params ["_unit",["_switchSides",true]];

		private ["_captiveStatus","_sideSwitchNeeded"];

		_captiveStatus = captive _unit;
		_unit setCaptive false;
		_sideSwitchNeeded = !((side _unit) == _undercoverUnitSide);
		_unit setCaptive _captiveStatus;

		if (_switchSides && _sideSwitchNeeded) then {
			private ["_newGroup","_oldGroup"];
			_newGroup = createGroup [_undercoverUnitSide,true];
			_oldGroup = (group _unit);
			(units group _unit) joinSilent _newGroup;
			deleteGroup _oldGroup;
		};

		if (_debug && _sideSwitchNeeded) then {
			hint "Captive check failed. Unit side is incorrect.";
		};

		_return = _sideSwitchNeeded;
	};

	case "spawnRebelCommander": {

		private ["_commander","_rebelGroup"];

		//private _rebelCommander = format ["INC_rebelCommander"];

		if (missionNamespace getVariable ["INC_rebelCommanderSpawned",false]) exitWith {};

		private _rebelGroup = [[(random 40),(random 40),10], _undercoverUnitSide, 1] call BIS_fnc_spawnGroup;
		_commander = leader _rebelGroup;
		_commander setRank "COLONEL";
		_commander disableAI "ALL";
		_commander enableAI "TARGET";
		_commander enableAI "FSM";
		_commander allowDamage false;
		_commander enableSimulation false;
		_commander hideObjectGlobal true;
		_commander hideObject true;
		_commander setUnitAbility 1;

		missionNamespace setVariable ["INC_rebelCommanderSpawned",true,true];

		missionNamespace setVariable ["INC_rebelCommander",_commander,true];

		_return = _commander;

	};

	case "runAway": {

		_input params ["_unit"];

		_unit doMove [
			(getPosASL _unit select 0) + (5 + (random 3) - (random 16)),
			(getPosASL _unit select 1) + (5 + (random 3)),
			getPosASL _unit select 2
		];
		_return = true;
	};

	case "addConcealActions": {

		_input params ["_unit","_groupLead",["_dismiss",true]];

		_unit addEventHandler ["InventoryClosed", {
			params ["_unit"];
			[[_unit,true,6],"CheckDisguiseAction"] call INCON_ucr_fnc_ucrMain;
		}];

		switch (!isPlayer _unit || {!(isClass(configFile >> "CfgPatches" >> "ace_interact_menu"))}) do {

			case true: {

				[_unit, [

					"<t color='#334FFF'>Conceal weapons</t>", {

						params ["_unit"];

						[_unit] spawn {
							params ["_unit"];

							_wpnArray = ([primaryWeapon _unit, handgunWeapon _unit]) select {
								(_x != "") &&
								{(_unit canAddItemToUniform _x) || {_unit canAddItemToBackpack _x}}
							};

							for "_i" from 1 to (count _wpnArray) do {
								[[_unit],"concealWeapon"] call INCON_ucr_fnc_gearHandler;
								sleep 4;
							};

							sleep 2;

							if !((currentWeapon _unit == "") || {currentWeapon _unit == "Throw"} || {currentWeapon _unit == binocular _unit}) then {
								switch (isPlayer _unit) do {
									case true: {
										hint "Some weapons have been concealed";
									};
									case false: {
										_unit groupChat "Couldn't fit them all in.";
									};
								};
							};
						};

					},[],6,false,true,"","(_this == _target) && {_this getVariable ['INC_canConcealWeapon',false]}"

				]] remoteExec ["addAction", _groupLead];

				[_unit, [

					"<t color='#FF33BB'>Get concealed weapons out</t>", {

						params ["_unit"];

						_unit setVariable ["INC_canGoLoud",false];

						[_unit] spawn {

							params ["_unit"];

							_wpnArray = ((weapons _unit) select {
								((_x isKindOf ['Rifle', configFile >> 'CfgWeapons']) || {_x isKindOf ['Pistol', configFile >> 'CfgWeapons']})
							});

							for "_i" from 1 to (count _wpnArray) do {
								if (_i >= 3) exitWith {true};
								[[_unit],"unConcealWeapon"] call INCON_ucr_fnc_gearHandler;
								sleep 4;
							};

							if (isPlayer _unit) exitWith {};

							switch (currentWeapon _unit == primaryWeapon _unit) do {
								case true: {
									_unit groupChat "Got my rifle out.";
								};
								case false: {
									_unit groupChat "Got my pistol out.";
								};
							};
						};

					},[],6,false,true,"","(_this == _target) && {_this getVariable ['INC_canGoLoud',false]}"

				]] remoteExec ["addAction", _groupLead];
			};

			case false: {

				if !(_unit getVariable ["INC_addedAceActions",false]) then {

					_unit setVariable ["INC_addedAceActions",true];

					INC_concealWeaponsACE = ['Conceal Weapons','Conceal Weapons','',{

					    [player] spawn {
					        params ['_unit'];

							_unit setVariable ["INC_canGoLoud",false];

					        _wpnArray = ([primaryWeapon _unit, handgunWeapon _unit]) select {
					            (_x != '') &&
					            {(_unit canAddItemToUniform _x) || {_unit canAddItemToBackpack _x}}
					        };

					        for '_i' from 1 to (count _wpnArray) do {
					            [[_unit],"concealWeapon"] call INCON_ucr_fnc_gearHandler;
					            sleep 4;
					        };

					        sleep 2;

					        if !((currentWeapon _unit == '') || {currentWeapon _unit == 'Throw'} || {currentWeapon _unit == binocular _unit}) then {
					            switch (isPlayer _unit) do {
					                case true: {
					                    hint 'Some weapons have been concealed';
					                };
					                case false: {
					                    _unit groupChat 'Could not fit them all in.';
					                };
					            };
					        };
					    };

					},{player getVariable ['INC_canConcealWeapon',false]}] call ace_interact_menu_fnc_createAction;
					[player, 1, ["ACE_SelfActions"], INC_concealWeaponsACE] call ace_interact_menu_fnc_addActionToObject;


					INC_unConcealWeaponsACE = ['Get Weapons Out','Get Concealed Weapons Out','',{

					    [player] spawn {
					        params ["_unit"];

					        _wpnArray = ((weapons _unit) select {
					            ((_x isKindOf ['Rifle', configFile >> 'CfgWeapons']) || {_x isKindOf ['Pistol', configFile >> 'CfgWeapons']})
					        });

					        for "_i" from 1 to (count _wpnArray) do {
					            if (_i >= 3) exitWith {true};
					            [[_unit],"unConcealWeapon"] call INCON_ucr_fnc_gearHandler;
					            sleep 4;
					        };
					    };

					},{player getVariable ['INC_canGoLoud',false]}] call ace_interact_menu_fnc_createAction;
					[player, 1, ["ACE_SelfActions"], INC_unConcealWeaponsACE] call ace_interact_menu_fnc_addActionToObject;
				};
			};
		};

		if (!isPlayer _unit) then {
			[[_unit,false],"SwitchUniformAction"] call INCON_ucr_fnc_ucrMain;
			[[_unit,false,8],"SwapGearAction"] call INCON_ucr_fnc_ucrMain;

		} else {

			_unit addEventHandler ["InventoryClosed", {
				params ["_unit"];
				if ([[_unit,false],"switchUniforms"] call INCON_ucr_fnc_gearHandler) then {
					[[_unit,true,4],"SwitchUniformAction"] call INCON_ucr_fnc_ucrMain;
				};
			}];

			_unit addEventHandler ["InventoryClosed", {
				params ["_unit"];
				if ([[_unit,false],"swapGear"] call INCON_ucr_fnc_gearHandler) then {
					[[_unit,true,4],"SwapGearAction"] call INCON_ucr_fnc_ucrMain;
				};
			}];

			[_unit, [

				"<t color='#F70707'>GROUP GO LOUD</t>", {
					params ["_unit"];

					{
						if (!isPlayer _x) then {

							_x enableAI "AUTOTARGET";
							_x setCombatMode "YELLOW";
							_x setBehaviour "COMBAT";
							_x setUnitPos "AUTO";

							_x suppressFor 10;

							[_x] spawn {
								params ["_unit"];

								_wpnArray = ((weapons _unit) select {
									(_x isKindOf ['Rifle', configFile >> 'CfgWeapons']) ||
									{_x isKindOf ['Pistol', configFile >> 'CfgWeapons']}
								});

								for "_i" from 1 to (count _wpnArray) do {
									[[_unit],"unConcealWeapon"] call INCON_ucr_fnc_gearHandler;
									sleep 3;
								};

								sleep 2;

								_x suppressFor 10;
							};
						};
					} forEach (units _unit);

				},[],4,false,true,"","(_this == _target) &&  {(count units _this > 1)}"

			]] remoteExec ["addAction", _groupLead];
		};

		if ((_dismiss || {!(_unit getVariable ["INC_notDismissable",false])}) && {_unit != leader _unit} && {!isPlayer _unit}) then {

			[_unit, [
				"<t color='#9933FF'>Dismiss</t>", {

					private _unit = _this select 0;
					private _civComment = selectRandom ["I'll just hang around here then I suppose.","My back is killing me anyway.","It's been a pleasure.","I'm just not cut out for this.","I'll continue our good work.","See you later.","I don't need you to have a good time.","I'm my own woman.","What time is it? I need to get high.","I've got some paperwork to do anyway.","Well thank God for that."];
					[[_unit, _civComment] remoteExec ["globalChat",0]];

					[_unit] join grpNull;
					_unit remoteExec ["removeAllActions",0];
					_unit setVariable ["isUndercover", false, true];

					_wp1 = (group _unit) addWaypoint [(getPosWorld _unit), 3];
					(group _unit) setBehaviour "SAFE";
					_wp1 setWaypointType "DISMISS";

				},[],5.8,false,true,"","((_this == _target) && {!isPlayer _this})"
			]] remoteExec ["addAction", _groupLead];
		} else {
			_unit setVariable ["INC_notDismissable",true];
		};

		_return = true;
	};

	case "profileGroup": {

		if (!(isClass(configFile >> "CfgPatches" >> "ALiVE_main")) || {!isServer}) exitWith {_return = grpNull};

		_input params ["_groupLead"];

		private ["_originalGroup","_newGroup","_nonPlayableArray","_playableArray"];

		_originalGroup = group _groupLead;

		_newGroup = createGroup _undercoverUnitSide;

		_nonPlayableArray = [];

		_playableArray = [];

		{
			if ((_x != leader group _x) && {!(_x in playableUnits)} && {!(_x getVariable ["INC_notDismissable",false])} && {count _nonPlayableArray <= 4}) then {
				_nonPlayableArray pushback _x;
				_x setCaptive false;
			};
		} forEach units _originalGroup;

		_return = [_newGroup,_playableArray,_nonPlayableArray];

		_nonPlayableArray join _newGroup;

		[_newGroup] spawn {

			params ["_newGroup"];

			{
				if (vehicle _x != _x) then {
					doGetOut _x;
				};
			} forEach (units _newGroup);

			sleep 10;

			{_x setCaptive false} forEach (units _newGroup);

			[false,[_newGroup],[]] call ALiVE_fnc_CreateProfilesFromUnitsRuntime;
		};
	};

	case "SwitchUniformAction": {

		_input params ["_unit",["_temporary",true],["_duration",12]];

		if (_unit getVariable ["INC_switchUniformActionActive",false]) exitWith {_return = false};

		_unit setVariable ["INC_switchUniformActionActive",true];

		INC_switchUniformAction = _unit addAction [
			"<t color='#33FF42'>Find new disguise nearby</t>", {
				params ["_unit"];

				private ["_success"];

				_success = [[_unit,true,1,true,7],"switchUniforms"] call INCON_ucr_fnc_gearHandler;

				if (_success) then {
					if (!isPlayer _unit) then {
						private _comment = selectRandom ["Found one.","Got something","This'll do","Found some new clothes.","Does my bum look big in this?","Fits nicely.","It's almost as if we're all the same dimensions.","Fits like a glove.","Beautiful.","I look like an idiot."];
						_unit groupChat _comment;
					} else {hint "Uniform changed."};
				} else {
					if (!isPlayer _unit) then {
						private _comment = selectRandom ["Which one?","I'm not sure where you want me to look.","Can you point it out a bit better?"];
						_unit groupChat _comment;
					} else {hint "No safe uniforms found nearby."};
				};

			},[],5.5,false,true,"","((_this == _target) && (isPlayer _this || {_this getVariable ['INC_canSwitch',false]}))"
		];

		if (_temporary) then {

			[_unit,_duration] spawn {

				params ["_unit",["_timer",12]];

				waitUntil {
					sleep 3;
					_timer = _timer - 3;

					(!([[_unit,false],"switchUniforms"] call INCON_ucr_fnc_gearHandler) || {_timer <= 0})
				};

				_unit removeAction INC_switchUniformAction;

				_unit setVariable ["INC_switchUniformActionActive",false];
			};
		};

		_return = true;
	};

	case "SwapGearAction": {

		_input params ["_unit",["_temporary",true],["_duration",12]];

		if (_unit getVariable ["INC_swapActionActive",false]) exitWith {_return = false};

		_unit setVariable ["INC_swapActionActive",true];

		INC_stealGear = _unit addAction [
			"<t color='#33FF42'>Swap Gear</t>", {
				params ["_unit"];

				private ["_success"];

				_success = [[_unit,true,7],"swapGear"] call INCON_ucr_fnc_gearHandler;

				if (_success) then {
					if (!isPlayer _unit) then {
						private _comment = selectRandom ["Found one.","Got something","This'll do","Does my bum look big in this?","Fits nicely.","It's almost as if we're all the same dimensions.","Fits like a glove.","Beautiful.","I look like an idiot."];
						_unit groupChat _comment;
					} else {hint "Uniform changed."};
				} else {
					if (!isPlayer _unit) then {
						private _comment = selectRandom ["I'm not sure where you want me to look.","Can you point it out a bit better?"];
						_unit groupChat _comment;
					} else {hint "No safe uniforms found nearby."};
				};

			},[],5.5,false,true,"","((_this == _target) && (isPlayer _this || {_this getVariable ['INC_canSwawp',false]}))"
		];

		if (_temporary) then {

			[_unit,_duration] spawn {

				params ["_unit",["_timer",12]];

				waitUntil {
					sleep 3;
					_timer = _timer - 3;

					(!([[_unit,false],"swapGear"] call INCON_ucr_fnc_gearHandler) || {_timer <= 0})
				};

				_unit removeAction INC_stealGear;

				_unit setVariable ["INC_swapActionActive",false];
			};
		};

		_return = true;
	};

	case "CheckDisguiseAction": {

		_input params ["_unit",["_temporary",true],["_duration",12]];

		if (_unit getVariable ["INC_checkDisguiseAction",false]) exitWith {_return = false};

		_unit setVariable ["INC_checkDisguiseAction",true];

		//Can't do it in vehicles as it would mess everything up (can improve this later on)
		INC_checkDisguise = _unit addAction [
			"<t color='#47AF24'>Check Disguise</t>", {
				params ["_unit"];

				[[_unit],"checkDisguise"] call INCON_ucr_fnc_gearHandler;

			},[],5.5,false,true,"","((_this == _target) && (isNull objectParent _this))"
		];

		if (_temporary) then {

			[_unit,_duration] spawn {

				params ["_unit","_timer"];

				sleep _timer;

				_unit removeAction INC_checkDisguise;

				_unit setVariable ["INC_checkDisguiseAction",false];
			};
		};

		_return = true;
	};

	case "getUnitIDs": {
		_input params ["_unit",["_checkType","face"]];
		private ["_cfgFaces"];

		switch (_checkType) do {

			case "face": {

				_cfgFaces = configFile >> "cfgFaces";

				for "_i" from 0 to (count _cfgFaces - 1) do {
				    _entry = _cfgFaces select _i;

				    if (isclass (_entry >> face _unit)) exitWith {
				        _return = (getArray (_entry >> (face _unit) >> "identityTypes"));
								true
				    };
				};
			};

			case "class": {
				_return = getArray (configFile >> "CfgVehicles" >> (typeOf _unit) >> "identityTypes");
			};

			case "full": {
				_return = ([[_unit],"getUnitIDs","class"] call INCON_ucr_fnc_ucrMain) + ([[_unit],"getUnitIDs","face"] call INCON_ucr_fnc_ucrMain);
			};
		};
	};

	case "factionIDcheck": {

		_input params ["_unit",["_factions",["OPF_F"]],["_checkType","full"],["_simpleCheck",true]];

		private ["_factionIDs","_unitIDs","_overlappingIDs"];

		_overlappingIDs = [];

		_factionIDs = (["possibleIdentities",_factions] call INCON_ucr_fnc_getConfigInfo);

		_unitIDs = [[_unit],"getUnitIDs",_checkType] call INCON_ucr_fnc_ucrMain;

		switch (_simpleCheck) do {
			case true: {
				{if (_x in _factionIDs) exitWith {_return = true}} forEach _unitIDs;
			};
			case false: {
				{if (_x in _factionIDs) then {_overlappingIDs pushbackunique _x}} forEach _unitIDs;
				_return = _overlappingIDs;
			};
		};
	};

	case "IDcheck": {

		_input params ["_unitIDs","_faction1IDs","_faction2IDs"];

		private ["_factionIDs","_unitIDs","_overlappingIDs","_looksLikeCiv","_looksLikeIncog"];

		_looksLike1 = false;
		_looksLike2 = false;

		{if (_x in _faction1IDs) exitWith {_looksLike1 = true}} forEach _unitIDs;
		{if (_x in _faction2IDs) exitWith {_looksLike2 = true}} forEach _unitIDs;

		_return = [_looksLike1,_looksLike2];
	};

	case "getFacVehs": {
		_input params [["_factions",["OPF_F"]]];

		private ["_cfgVehicles"];

		_return = [];

		_cfgVehicles = configFile >> "CfgVehicles";

		for "_i" from 0 to (count _cfgVehicles - 1) do {
			_entry = _cfgVehicles select _i;

			if (isclass _entry) then {
				if (
						(getText(_entry >> "faction") in _factions) &&
						{getNumber(_entry >> "scope") >= 2} &&
					{
						(configname _entry isKindOf "Air") ||
						{configname _entry isKindOf "Boat"} ||
						{configname _entry isKindOf "LandVehicle"}
					}
				) then {
					_return pushback (configName _entry);
				};
			};
		};
	};

	case "getFacUnits": {
		_input params ["_factions"];

		private ["_cfgVehicles"];

		_return = [];
		_cfgVehicles = configFile >> "CfgVehicles";

		for "_i" from 0 to (count _cfgVehicles - 1) do {
			_entry = _cfgVehicles select _i;

			if (isclass _entry) then {
				if (
					(getText(_entry >> "faction") in _factions) &&
					{getNumber(_entry >> "scope") >= 2} &&
					{configname _entry isKindOf "Man"}
				) then {
					_return pushback (configName _entry);
				};
			};
		};
	};

	case "checkIncogFoot": {

		_input params ["_unit"];

		if (uniform _unit in INC_incogUniforms) then {

			_return = true;

			if !(_unit getVariable ["INC_goneIncog",false]) then {

				if !(_unit getVariable ["INC_isCompromised",false]) then {

					//If either side has seen the unit, make him compromised
					if (([_unit, INC_regEnySide,10] call INCON_ucr_fnc_isKnownExact) || {[_unit, INC_asymEnySide,10] call INCON_ucr_fnc_isKnownExact}) then {

						[_unit] call INCON_ucr_fnc_compromised;
					};
				};

				_unit setVariable ["INC_goneIncog",true];
				_unit setVariable ["INC_faceFits",  (_unit getVariable ["INC_looksLikeIncog",true])];
			};
		} else {

			_unit setVariable ["INC_goneIncog",false];
			_unit setVariable ["INC_faceFits", (_unit getVariable ["INC_looksLikeCiv",true])];
		};
	};

	case "checkIncogVeh": {

		_input params ["_unit"];

		if (((typeOf vehicle _unit) in INC_incogVehArray) && {!((vehicle _unit) getVariable ["INC_naughtyVehicle",false])}) then {

			_return = true;

			if !(_unit getVariable ["INC_goneIncog",false]) then {

				if !(_unit getVariable ["INC_isCompromised",false]) then {

					//If either side has seen the unit, make him compromised
					if (([_unit, INC_regEnySide,10] call INCON_ucr_fnc_isKnownExact) || {[_unit, INC_asymEnySide,10] call INCON_ucr_fnc_isKnownExact}) then {
						[_unit] call INCON_ucr_fnc_compromised;
					};
				};

				_unit setVariable ["INC_goneIncog",true];
				_unit setVariable ["INC_faceFits",  (_unit getVariable ["INC_looksLikeIncog",true])];
			};
		} else {
			_unit setVariable ["INC_goneIncog",false];
			_unit setVariable ["INC_faceFits", (_unit getVariable ["INC_looksLikeCiv",true])];
		};
	};
};

_return
