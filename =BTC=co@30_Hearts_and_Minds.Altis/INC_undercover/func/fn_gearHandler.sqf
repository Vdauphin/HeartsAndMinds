/* ----------------------------------------------------------------------------
Function: gearHandler

Description: Executes all gear-related functions for Incon Undercover.

Parameters:
0: Input <ANY>
1: Operation <STRING>

Returns: Depends on context.

Examples:

["hgun_ACPC2_snds_F","getCompatMags"] call INCON_ucr_fnc_gearHandler;
[[Jeff,"srifle_EBR_F"], "getStoredWeaponAmmoArray"] call INCON_ucr_fnc_gearHandler;

Author: Incontinentia
---------------------------------------------------------------------------- */

params [["_input",objNull],["_operation","addConcealedRifle"]];

private ["_return"];

_return = false;

#include "..\UCR_setup.sqf"

switch (_operation) do {

	case "getCompatMags": {

		_input params ["_weapon"];

		private _configEntry = configFile >> "CfgWeapons" >> _weapon;
		private _result = [];
		{
			_result pushBack (
				if (_x == "this") then {
					getArray(_configEntry >> "magazines")
				}
			);
		} forEach getArray(_configEntry >> "muzzles");

		_return = _result select 0;
	};

	case "addBackpack": {

		_input params ["_unit"];

		_unit addBackpack (selectRandom _civPackArray);
		unitBackpack _unit setVariable ["owner",_unit,true];

		[(unitBackpack _unit), {
			_this addEventHandler ["ContainerOpened", {
				_backpack  = _this select 0;
				_civ = _backpack getVariable "owner";
				private _civComment = selectRandom ["Get the fuck out of my backpack","What are you doing?","Leave me alone!","Get out!","What are you playing at?"];
				[[_civ, _civComment] remoteExec ["globalChat",0]];
				[[_civ,"runAway"] remoteExecCall ["INCON_ucr_fnc_ucrMain",_civ]];
				}
			];
		}] remoteExec ["call", 0,true];

		_return = unitBackpack _unit;
	};

	case "addWeapon": {

		_input params ["_unit"];

		private _wpn = selectRandom _civWpnArray;
		private _magsArray = ([_wpn,"getCompatMags"] call INCON_ucr_fnc_gearHandler);

		_return = true;

		if (_unit canAddItemToUniform _wpn) then {
			_unit addItemToUniform _wpn;
			_unit addMagazine (selectRandom _magsArray);
			for "_i" from 1 to (ceil random 5) do {
				_unit addMagazine (selectRandom _magsArray);
			};

		} else {

			if (_unit canAddItemToBackpack _wpn) then {

				_unit addMagazine (selectRandom _magsArray);
				_unit addItemToBackpack _wpn;
				for "_i" from 1 to (ceil random 8) do {
					_unit addMagazine (selectRandom _magsArray);
				};

			} else {

				_return = false;
			};
		};
	};

	case "addItems": {

		_input params ["_unit"];

		for "_i" from 0 to (round (random 3)) do {
			private _itemToAdd = selectRandom _civItemArray;
			_unit addItem _itemToAdd;
		};

		_return = true;
	};

	case "getStoredWeaponItems": {

		_input params ["_unit","_wpn",["_comparison",false]];

		_return = [];

		private ["_activeContainer","_weaponArray"];

		//Determine the weapon location, exit if not found
		_activeContainer = weaponsitemscargo uniformContainer _unit;

		if !((uniformItems _unit) find _wpn >= 0) then {

			if ((vestItems _unit) find _wpn >= 0) exitWith {
				_activeContainer = weaponsitemscargo vestContainer _unit;
			};

			if ((backpackItems _unit) find _wpn >= 0) exitWith {
				_activeContainer = weaponsitemscargo unitBackpack _unit;
			};

			_activeContainer = [];
		};

		if (_activeContainer isEqualTo []) exitWith {};

		_weaponArray = (_activeContainer select {(_x select 0) == _wpn}) select 0;

		if (_comparison) exitWith {
			_return = _weaponArray;
		};

		_return = _weaponArray select {(_x isEqualType "STRING") && {_x != _wpn}};
	};

	case "getStoredWeaponAmmoArray": {

		_input params ["_unit","_wpn"];

		_return = [];

		private ["_activeContainer","_weaponArray"];

		//Determine the weapon location, exit if not found
		_activeContainer = weaponsitemscargo uniformContainer _unit;

		if !((uniformItems _unit) find _wpn >= 0) then {

			if ((vestItems _unit) find _wpn >= 0) exitWith {
				_activeContainer = weaponsitemscargo vestContainer _unit;
			};

			if ((backpackItems _unit) find _wpn >= 0) exitWith {
				_activeContainer = weaponsitemscargo unitBackpack _unit;
			};

			_activeContainer = [];
		};

		if (_activeContainer isEqualTo []) exitWith {};

		_weaponArray = (_activeContainer select {(_x select 0) == _wpn}) select 0;

		_return = _weaponArray select 4;
	};

	case "ableToConceal": {

		_input params ["_unit"];

		private _wpn = currentWeapon _unit;

		if ((_wpn == "") || {_wpn == "Throw"} || {_wpn == binocular _unit}) exitWith {_return = false};

		_return = (
			(
				(isNull objectParent _unit) ||
				{count assignedVehicleRole _unit == 2}
			) && {
				((primaryWeapon _unit != "") && {(_unit canAddItemToUniform (primaryWeapon _unit)) || {_unit canAddItemToBackpack (primaryWeapon _unit)}}) ||
				{(handgunWeapon _unit != "") && {(_unit canAddItemToUniform (handgunWeapon _unit)) || {_unit canAddItemToBackpack (handgunWeapon _unit)}}}
			}
		);
	};

	case "ableToGoLoud": {

		_input params ["_unit"];

		_return = (
			(
				(isNull objectParent _unit) ||
				{count assignedVehicleRole _unit == 2}
			) && {
				(currentWeapon _unit == "") || {currentWeapon _unit == "Throw"} || {currentWeapon _unit == binocular _unit}
			} && {
				(handgunWeapon _unit == "") && {primaryWeapon _unit == ""}
			} && {
				({
					(_x isKindOf ['Pistol', configFile >> 'CfgWeapons']) ||
					{_x isKindOf ['Rifle', configFile >> 'CfgWeapons']}
				} count (weapons _unit) != 0)
			}
		);
	};

	case "concealWeapon": {

		private ["_wpnType","_wpn","_id"];

		_input params ["_unit"];

		_return = true;

		_wpn = currentWeapon _unit;

		if ((primaryWeapon _unit != _wpn) || {handgunWeapon _unit != _wpn}) then {
			_wpn = (([(primaryWeapon _unit),(handgunWeapon _unit)] select {
				(_x != "") &&
				{(_unit canAddItemToUniform _x) || {_unit canAddItemToBackpack _x}}
			}) select 0);
		};

		_id = 999;

		if (isNil "_wpn") exitWith {_return = false};

		if (_wpn isEqualTo primaryWeapon _unit) then {_id = 0};
		if (_wpn isEqualTo handgunWeapon _unit) then {_id = 1};

		if (_id == 999) exitWith {_return = false};

		_wpnType = "primary";

		if (_wpn == handgunWeapon _unit) then {
			_wpnType = "handgun";
		};

		[_unit,_wpn,_id,_wpnType] spawn {
			params ["_unit","_wpn","_id","_wpnType"];
			private ["_mag","_ammoCount","_items","_baseWpn","_itemsToAdd","_id","_weaponStore","_weaponArray","_origItems"];

			switch (_wpnType) do {
				case "primary": {
					_mag = primaryWeaponMagazine _unit select 0;
				};
				case "handgun": {
					_mag = handgunMagazine _unit select 0;
				};
			};

			_ammoCount = _unit ammo _wpn;
			_items = _unit weaponAccessories _wpn;
			_baseWpn = [_wpn] call BIS_fnc_baseWeapon;

			sleep 0.2;

			switch (_unit canAddItemToUniform _wpn) do {
				case true: {
					_unit addMagazine [_mag,_ammoCount];
					_unit removeWeaponGlobal _wpn;
					(uniformContainer _unit) addItemCargoGlobal [_baseWpn, 1];
					{(uniformContainer _unit) addItemCargoGlobal [_x, 1]} forEach _items;
				};
				case false: {
					_unit addMagazine [_mag,_ammoCount];
					_unit removeWeaponGlobal _wpn;
					(backpackContainer _unit) addItemCargoGlobal [_baseWpn, 1];
					{(backpackContainer _unit) addItemCargoGlobal [_x, 1]} forEach _items;
				};
			};

			_comparisonArray = ([[_unit,_baseWpn,true],"getStoredWeaponItems"] call INCON_ucr_fnc_gearHandler);

			_weaponArray = [_baseWpn,_items,_comparisonArray,[_mag,_ammoCount]];
			_weaponStore = _unit getVariable "INC_weaponStore";

			sleep 0.1;

			_weaponStore set [_id,_weaponArray];

			_unit setVariable ["INC_weaponStore",_weaponStore];
			_unit setVariable ["INC_weaponStoreActive",true];

			if ((isClass(configFile >> "CfgPatches" >> "ace_main")) && {primaryWeapon _unit == ""}) then {
				_unit call ace_weaponselect_fnc_putWeaponAway;
			};
		};
	};

	case "unConcealWeapon": {

		private ["_id","_wpn","_mag","_ammoCount","_items","_weaponArray","_weaponStore"];

		_input params ["_unit"];

		_return = true;
		_weapons = [];
		_id = 999;

		if ((primaryWeapon _unit != "") && {secondaryWeapon _unit != ""}) exitWith {_return = false};

		//Prioritising primary weapons, return an array of either primary or handgun weapons
		if (primaryWeapon _unit == "") then {
			{
				if ((_x isKindOf ["Rifle", configFile >> "CfgWeapons"]) && {primaryWeapon _unit == ""}) then {
					_weapons pushBack _x;
					_id = 0;
				};
			} forEach (weapons _unit);
		};

		if (handgunWeapon _unit == "") then {
			if (_weapons isEqualTo []) then {
				{
					if ((_x isKindOf ["Pistol", configFile >> "CfgWeapons"]) && {handgunWeapon _unit == ""}) then {
						_weapons pushBack _x;
						_id = 1;
					};
				} forEach (weapons _unit);
			};
		};

		//If there's no weapons of either type, exit
		if (_id == 999) exitWith {_return = false};

		[_unit,_weapons,_id] spawn {

			params ["_unit","_weapons","_id"];
			private ["_weapons","_itemsToAdd","_wpn","_mag","_ammoCount","_items","_weaponArray","_weaponStore","_unitItems"];

			//Find out if the unit's prioritised weapon of the given id (0 being rifles, 1 being pistols) has been stored before
			_weaponArray = ((_unit getVariable "INC_weaponStore") select _id);

			switch (
				!(_weaponArray isEqualTo []) &&
				{(_weaponArray select 0) in weapons _unit} &&
				{
					(_weaponArray select 2) isEqualTo ([[_unit,(_weaponArray select 0),true],"getStoredWeaponItems"] call INCON_ucr_fnc_gearHandler)
				}
			) do {
				case true: {
					_wpn = _weaponArray select 0;
					_itemsToAdd = _weaponArray select 1;

					_itemsToAdd = _itemsToAdd select {_x in ((uniformItems _unit) + (vestItems _unit) + (backPackItems _unit) + ([[_unit,(_weaponArray select 0)],"getStoredWeaponItems"] call INCON_ucr_fnc_gearHandler))};

					_unit removeItem _wpn;

					_unit addWeapon _wpn;

					sleep 0.1;

					switch (_id) do {
						case 0: {
							{
								_unit removeItem _x;
								_unit addPrimaryWeaponItem _x;
							} forEach _itemsToAdd;
						};

						case 1: {
							{
								_unit removeItem _x;
								_unit addHandgunItem _x
							} forEach _itemsToAdd;
						};
					};
				};

				case false: {
					_wpn = selectRandom _weapons;
					_ammoArray = ([[_unit,_wpn], "getStoredWeaponAmmoArray"] call INCON_ucr_fnc_gearHandler);
					_ammoArray params [["_mag",""],["_ammoCount",0]];
					_itemsToAdd = ([[_unit,_wpn], "getStoredWeaponItems"] call INCON_ucr_fnc_gearHandler);
					_unit removeItem _wpn;

					if !(_mag == "") then {_unit addMagazine _mag};

					_unit addWeapon _wpn;

					if !(_mag == "") then {_unit setAmmo [_wpn,_ammoCount]};

					sleep 0.1;

					switch (_id) do {
						case 0: {
							removeAllPrimaryWeaponItems _unit;
							{_unit addPrimaryWeaponItem _x} forEach _itemsToAdd;
						};

						case 1: {
							removeAllHandgunItems _unit;
							{_unit addHandgunItem _x} forEach _itemsToAdd;
						};
					};
				};
			};
		};
	};

	case "switchUniforms": {

		_input params ["_unit",["_switchUniform",true],["_attempt",1],["_autoReAttempt",true],["_radius",5]];

		private ["_activeContainer","_newUnif","_origUnif","_newUnifItems","_droppedUniform","_containerArray","_isMan"];

		_isMan = false;

		_containerArray = [];

		if (_attempt <= 1) then {_containerArray = (nearestObjects [_unit, ["GroundWeaponHolder"],_radius])};

		if ((count _containerArray == 0) && {_attempt <= 2}) then {_attempt = 2; _containerArray = (_unit nearEntities [["LandVehicle","Ship","Air"],_radius])};

		if ((count _containerArray == 0) && {_attempt <= 3}) then {_attempt = 3; _containerArray =  (nearestObjects [_unit, ["ReammoBox_F"],_radius])};

		if ((count _containerArray == 0) && {_attempt <= 4}) then {
			_attempt = 4;
			_isMan = true;
			_containerArray = (nearestObjects [_unit, ["Man"],_radius]) select {
				(!alive _x)
			};

		};

		if (count _containerArray == 0) exitWith {_return = false};

		_activeContainer = (_containerArray select 0);

		_origUnif = uniform _unit;
		_origUnifItems = uniformItems _unit;

		switch (_isMan) do {
			case true: {

				if (
					(uniform _activeContainer in (INC_civilianUniforms + INC_incogUniforms)) &&
					{(uniform _activeContainer) != _origUnif}
				) then {
					_newUnif = uniform _activeContainer;
				};

			};

			case false: {
				_newUnif = (((everyContainer _activeContainer) select {
				    (
						(
							(((_x select 0) find "U_") >= 0) ||
							{(((_x select 0) find "uniform") >= 0)} ||
							{(((_x select 0) find "Uniform") >= 0)}
						) &&
						{
							!(((_x select 0) find _origUnif) == 0) ||
							{_origUnif == ""}
						} &&
						{(_x select 0) in (INC_civilianUniforms + INC_incogUniforms)}
					)
				}) select 0);
			};
		};

		if (isNil "_newUnif") exitWith {
			_return = false;
			if (_autoReAttempt && {_attempt <= 3}) then {
				_return = [[_unit,_switchUniform,(_attempt + 1)],"switchUniforms"] call INCON_ucr_fnc_gearHandler;
			};
		};

		_return = true;

		if (_switchUniform) then {

			switch (_isMan) do {
				case true: {
					[_activeContainer,_unit] spawn {
						params ["_deadGuy","_opportunist"];
						private ["_gwh","_oldUniform","_deadUniform","_oldItems"];

						[_opportunist,"AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon"] remoteExec ["playMove",0];

						_oldUniform = uniform _opportunist;
						_deadUniform = uniform _deadGuy;
						_oldItems = uniformItems _opportunist;
						_deadGuyItems = uniformItems _deadGuy;

						sleep 0.2;

						_gwh = createVehicle ["GroundWeaponHolder", getPosATL _opportunist, [], 0, "CAN_COLLIDE"];
						_gwh addItemCargoGlobal [_oldUniform, 1];
						{_gwh addItemCargoGlobal [_x, 1];} forEach (_deadGuyItems);

						sleep 2;

						removeUniform _deadGuy;
						_opportunist forceAddUniform _deadUniform;
						{(uniformContainer _opportunist) addItemCargoGlobal [_x, 1];} forEach (_oldItems);
					};
				};

				case false: {
					[_unit,_activeContainer,_origUnifItems,_origUnif,_newUnif] spawn {
						params ["_unit","_activeContainer","_origUnifItems","_origUnif","_newUnif"];

						private ["_newCrateCargo","_oldGwh"];

						_oldGwh = false;

						if (_activeContainer isKindOf "GroundWeaponHolder") then {_oldGwh = true};

						_activeContainer addItemCargoGlobal [(_origUnif), 1];

						[_unit,"AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon"] remoteExec ["playMove",0];

						sleep 1;

						_unit forceAddUniform (_newUnif select 0);

						sleep 0.2;

						{(uniformContainer _unit) addItemCargoGlobal  [_x, 1]} forEach (_origUnifItems);

						sleep 0.1;

						_newCrateCargo = [];

						{
							private ["_weapons"];
							private _wpnItmsCrgo = weaponsItemsCargo (_x select 1);
							{for "_i" from 1 to ((count _x - 1)) do {
								private _item = _x select _i;
								if (_item isEqualType "" && {_item != ""}) then {
									if (_i > 0) then {_newCrateCargo pushBack _item} else {_newCrateCargo pushBack ([_item] call BIS_fnc_baseWeapon)};
								} else {
									if (_i == 4 && {!(_item isEqualTo [])}) then {_newCrateCargo pushBack (_item select 0)};
								};
							}} forEach _wpnItmsCrgo;
							{_newCrateCargo pushBack _x} forEach ((itemCargo (_x select 1)) + (magazineCargo (_x select 1)) + (backPackCargo (_x select 1)));
							{_newCrateCargo pushBack ([_x] call BIS_fnc_baseWeapon)} forEach (weaponCargo (_x select 1));
							true
						} count (everyContainer _activeContainer);

						_wpnItmsCrgo = (weaponsItemsCargo _activeContainer);
						{for "_i" from 0 to ((count _x - 1)) do {
							private _item = _x select _i;
							if (_item isEqualType "" && {_item != ""}) then {
								if (_i > 0) then {_newCrateCargo pushBack _item} else {_newCrateCargo pushBack ([_item] call BIS_fnc_baseWeapon)};
							} else {
								if (_i == 4 && {!(_item isEqualTo [])}) then {_newCrateCargo pushBack (_item select 0)};
							};
						}} forEach _wpnItmsCrgo;
						{_newCrateCargo pushBack _x} forEach ((itemCargo _activeContainer) + (magazineCargo _activeContainer) + (backPackCargo _activeContainer));
						//{_newCrateCargo pushBack ([_x] call BIS_fnc_baseWeapon)} forEach (weaponCargo _activeContainer);

						_newCrateCargo set [(_newCrateCargo find (_newUnif select 0)),-1];
						_newCrateCargo = _newCrateCargo - [-1];

						sleep 0.2;

						switch (_oldGwh) do {
							case true: {
								clearItemCargoGlobal _activeContainer;
								clearWeaponCargoGlobal _activeContainer;
								clearMagazineCargoGlobal _activeContainer;
								clearBackpackCargoGlobal _activeContainer;
								deleteVehicle _activeContainer;
								 _newActiveContainer = createVehicle ["GroundWeaponHolder", getPosATL _unit, [], 0, "CAN_COLLIDE"];
								{_newActiveContainer addItemCargoGlobal [_x, 1]} forEach (_newCrateCargo select {!(_x isKindOf "Bag_Base")});
								{_newActiveContainer addBackpackCargoGlobal [(_x call BIS_fnc_basicBackpack),1]} forEach (_newCrateCargo select {_x isKindOf "Bag_Base"});
							};

							case false: {
								clearItemCargoGlobal _activeContainer;
								clearWeaponCargoGlobal _activeContainer;
								clearMagazineCargoGlobal _activeContainer;
								clearBackpackCargoGlobal _activeContainer;
								{_activeContainer addItemCargoGlobal [_x, 1]} forEach (_newCrateCargo select {!(_x isKindOf "Bag_Base")});
								{_activeContainer addBackpackCargoGlobal [(_x call BIS_fnc_basicBackpack),1]} forEach (_newCrateCargo select {_x isKindOf "Bag_Base"});
							};
						};
					};
				};
			};
		};
	};

	case "swapGear": {
		_input params ["_unit",["_swapGear",true],["_radius",5],["_swapType","LIMITED"]];

		private ["_activeContainer","_newUnif","_origUnif","_newUnifItems","_droppedUniform","_containerArray"];

		_containerArray = [];

		_containerArray = (nearestObjects [_unit, ["Man"],_radius]) select {
			(!alive _x)
		};

		if (count _containerArray == 0) exitWith {_return = false};

		_return = true;

		if (_swapGear) then {

			switch (_swapType) do {
				case "FULL": {

					[(_containerArray select 0),_unit] spawn {
						params ["_deadGuy","_opportunist"];
						private ["_gwh","_oldUniform","_deadUniform","_oldItems"];

						[_opportunist,"AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon"] remoteExec ["playMove",0];

						_deadGear = getUnitLoadout _deadGuy;
						_origGear = getUnitLoadout _opportunist;

						_deadGear params ["_dPrimary","_dSecondary","_dHandgun","_dUniform","_dVest","_dBackpack","_dHelmet","_dBinocular","_dAssItems"];
						_origGear params ["_aPrimary","_aSecondary","_aHandgun","_aUniform","_aVest","_aBackpack","_aHelmet","_aBinocular","_aAssItems"];

						sleep 0.1;

						_deadGear set [0, _aPrimary];

						_deadGear set [1, _aSecondary];

						_deadGear set [2, _aHandgun];

						_origGear set [0, _dPrimary];

						_origGear set [1, _dSecondary];

						_origGear set [2, _dHandgun];

						sleep 1.5;

						{
							removeAllWeapons _x;
							removeAllItems _x;
							removeAllAssignedItems _x;
							removeUniform _x;
							removeVest _x;
							removeBackpack _x;
							removeHeadgear _x;
							removeGoggles _x;
						} forEach [_deadGuy,_opportunist];

						sleep 0.1;

						_opportunist setUnitLoadout [_deadGear, false];
						_deadGuy setUnitLoadout [_origGear,false];

						sleep 1;
					};
				};

				case "LIMITED": {

					[(_containerArray select 0),_unit] spawn {
						params ["_deadGuy","_opportunist"];
						private ["_gwh","_deadGear","_origGear"];

						[_opportunist,"AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon"] remoteExec ["playMove",0];

						_deadGear = getUnitLoadout _deadGuy;
						_origGear = getUnitLoadout _opportunist;

						_deadGear params ["_dPrimary","_dSecondary","_dHandgun","_dUniform","_dVest","_dBackpack","_dHelmet","_dGoggles","_dBinocular","_dAssItems"];

						_origGear params ["_aPrimary","_aSecondary","_aHandgun","_aUniform","_aVest","_aBackpack","_aHelmet","_aGoggles","_aBinocular","_aAssItems"];

						sleep 0.1;

						_deadGear set [0, _aPrimary];

						_deadGear set [1, _aSecondary];

						_deadGear set [2, _aHandgun];

						_deadGear set [7, _aGoggles];

						_deadGear set [8, _aBinocular];

						_deadGear set [9, _aAssItems];

						sleep 0.1;

						_origGear set [0, _dPrimary];

						_origGear set [1, _dSecondary];

						_origGear set [2, _dHandgun];

						_origGear set [7, _dGoggles];

						_origGear set [8, _dBinocular];

						_origGear set [9, _dAssItems];

						sleep 1.5;

						{
							removeAllWeapons _x;
							removeAllItems _x;
							removeAllAssignedItems _x;
							removeUniform _x;
							removeVest _x;
							removeBackpack _x;
							removeHeadgear _x;
							removeGoggles _x;
						} forEach [_deadGuy,_opportunist];

						sleep 0.1;

						_opportunist setUnitLoadout [_deadGear, false];
						_deadGuy setUnitLoadout [_origGear,false];

						sleep 1;
					};
				};
			};
		};
	};

	case "checkDisguise": {
		_input params ["_unit"];

		_unit setVariable ["INC_checkingDiguise",true];

		_return = true;

		[_unit,_easyMode] spawn {
			params ["_unit",["_easyMode",true]];
			private ["_isIncog","_isCiv","_isArmed"];

			waitUntil {
				sleep 1;
				!(_unit getVariable ["INC_checkingDiguise",false])
			};

			//Trespassing, incognito / civ, suspiciousness, weirdness

			if (_easyMode) then {
				if (captive _unit) then {
					hint "Your disguise is intact";
					sleep 2;
				} else {

					if (_unit getVariable ["INC_trespassAlert",false]) then {
						hint "You are trespassing";
						sleep 2;
					};

					if (_unit getVariable ["INC_isCompromised",false]) then {
						hint "You have been compromised";
						sleep 2;
					};

					hint "Your disguise isn't working";
				};
			};

			if ((_unit getVariable ["INC_suspiciousValue",1]) >= 2) then {
				hint "You are acting suspiciously";
				sleep 2;
			} else {

				if (_unit getVariable ["INC_firedRecent",false]) then {
					hint "You smell of cordite";
					sleep 2;
				};

				if ((_unit getVariable ["INC_disguiseValue",1]) < 2) then {
					hint "Your disguise is solid";
					sleep 2;
				} else {
					if ((_unit getVariable ["INC_disguiseValue",1]) < 3) then {
						hint "Your disguise is good";
						sleep 2;
					} else {
						if ((_unit getVariable ["INC_disguiseValue",1]) < 7) then {
							hint "You look a little out of place";
							sleep 2;
						} else {
							if ((_unit getVariable ["INC_disguiseValue",1]) < 13) then {
								hint "You look suspicious";
								sleep 2;
							} else {
								hint "You look extremely suspicious";
							};
						};
					};
				};
			};
		};
	};
};

_return
