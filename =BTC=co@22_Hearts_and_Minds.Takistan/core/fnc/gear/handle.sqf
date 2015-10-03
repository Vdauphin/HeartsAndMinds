_type = _this select 0;

_ui = uiNamespace getVariable "btc_gear_dlg";

switch _type do
{
	case 0 :
	{
		if (lbData [372, lbCurSel 372] == "") exitWith {};
		
		_cargo = lbText [371, lbCurSel 371];
		
		if (_cargo == "Uniforms" || _cargo == "Vests" || _cargo == "Backpacks" || _cargo == "HeadGear" || _cargo == "Goggles") exitWith
		{
			switch (lbText [371, lbCurSel 371]) do
			{
				case "Uniforms" : 
				{
					_m = getMagazineCargo uniformContainer player;
					_it = getItemCargo uniformContainer player;
					player addUniform (lbData [372, lbCurSel 372]);
					for "_i" from 0 to (count (_m select 0) - 1) do {(uniformContainer player) addMagazineCargo [((_m select 0) select _i),((_m select 1) select _i)];};
					for "_i" from 0 to (count (_it select 0) - 1) do {(uniformContainer player) addItemCargo [((_it select 0) select _i),((_it select 1) select _i)];};
					(_ui displayCtrl 374) ctrlSettext (getText (configFile >> "cfgWeapons" >> (lbData [372, lbCurSel 372]) >> "picture"));
				};
				case "Vests" : 
				{
					_m = getMagazineCargo vestContainer player;
					_it = getItemCargo vestContainer player;					
					player addVest (lbData [372, lbCurSel 372]);
					for "_i" from 0 to (count (_m select 0) - 1) do {(vestContainer player) addMagazineCargo [((_m select 0) select _i),((_m select 1) select _i)];};
					for "_i" from 0 to (count (_it select 0) - 1) do {(vestContainer player) addItemCargo [((_it select 0) select _i),((_it select 1) select _i)];};
					(_ui displayCtrl 375) ctrlSettext (getText (configFile >> "cfgWeapons" >> (lbData [372, lbCurSel 372]) >> "picture"));
				};
				case "Backpacks" : 
				{
					_m = getMagazineCargo backpackContainer player;
					_it = getItemCargo backpackContainer player;					
					player addBackpack (lbData [372, lbCurSel 372]);
					for "_i" from 0 to (count (_m select 0) - 1) do {(backpackContainer player) addMagazineCargo [((_m select 0) select _i),((_m select 1) select _i)];};
					for "_i" from 0 to (count (_it select 0) - 1) do {(backpackContainer player) addItemCargo [((_it select 0) select _i),((_it select 1) select _i)];};
					(_ui displayCtrl 376) ctrlSettext (getText (configFile >> "cfgVehicles" >> (lbData [372, lbCurSel 372]) >> "picture"));
				};
				case "HeadGear" :
				{
					player addHeadGear (lbData [372, lbCurSel 372]);
					(_ui displayCtrl 377) ctrlSettext (getText (configFile >> "cfgWeapons" >> (lbData [372, lbCurSel 372]) >> "picture"));
				};
				case "Goggles" :
				{
					player addGoggles (lbData [372, lbCurSel 372]);
					(_ui displayCtrl 378) ctrlSettext (getText (configFile >> "cfgGlasses" >> (lbData [372, lbCurSel 372]) >> "picture"));
				};
			};
		};
		
		if (_cargo == "Weapons") exitWith
		{
			player addWeapon (lbData [372, lbCurSel 372]);
		};
		
		//Add
		_cond = true;
		switch btc_gear_container_selected do
		{
			case 0 : {if (uniform player == "") then {_cond = false;};};
			case 1 : {if (vest player == "") then {_cond = false;};};
			case 2 : {if (backpack player == "") then {_cond = false;};};
		};
		if !(_cond) exitWith {};
		_obj_type = lbData [372, lbCurSel 372];
		switch btc_gear_container_selected do
		{
			case 0 : {if !(player canAddItemToUniform _obj_type) then {_cond = false;};};
			case 1 : {if !(player canAddItemToVest _obj_type) then {_cond = false;};};
			case 2 : {if !(player canAddItemToBackpack _obj_type) then {_cond = false;};};
		};
		if !(_cond) exitWith {hint "There is no enough space!"};
		switch btc_gear_container_selected do
		{
			case 0 : {player addItemToUniform _obj_type;[0,0] call btc_fnc_gear_change_container;};
			case 1 : {player addItemToVest _obj_type;[0,1] call btc_fnc_gear_change_container;};
			case 2 : {player addItemToBackpack _obj_type;[0,2] call btc_fnc_gear_change_container;};
		};
		//if ({_obj_type == _x} count assignedItems player == 0) then {player assignItem _obj_type};
	};
	case 1 :
	{
		//Remove
		if (lbData [373, lbCurSel 373] == "") exitWith {};
		
		switch btc_gear_container_selected do
		{
			case 0 : {player removeItemFromUniform (lbData [373, lbCurSel 373]);[0,0] call btc_fnc_gear_change_container;};
			case 1 : {player removeItemFromVest (lbData [373, lbCurSel 373]);[0,1] call btc_fnc_gear_change_container;};
			case 2 : {player removeItemFromBackpack (lbData [373, lbCurSel 373]);[0,2] call btc_fnc_gear_change_container;};
		};		
	};
	case 2 : {player removeWeapon (primaryWeapon player)};
	case 3 : {player removeWeapon (secondaryWeapon player)};
	case 4 : {player removeWeapon (handGunWeapon player)};
};

call btc_fnc_gear_get_text;