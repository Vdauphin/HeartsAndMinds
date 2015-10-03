disableSerialization;
_ui = uiNamespace getVariable "btc_gear_dlg";
_click = _this select 0;
_type = _this select 1;
switch _type do
{
	case 0 : 
	{
		if (_click == 1) then
		{
			removeUniform player;
			(_ui displayCtrl 374) ctrlSettext "\A3\ui_f\data\gui\rsc\rscdisplaygear\ui_gear_uniform_gs.paa";
			if (btc_gear_container_selected == 0) then
			{
				lbClear 373;
				(_ui displayCtrl 380) progressSetPosition 0;
			};
			call btc_fnc_gear_get_text;
		}
		else
		{
			_load = loadUniform player;
			_items = uniformItems player;
			(_ui displayCtrl 380) progressSetPosition _load;
			[373,_items] call btc_fnc_gear_lb_fill;
			btc_gear_container_selected = 0;		
		};
	};
	case 1 : 
	{
		if (_click == 1) then
		{
			removeVest player;
			(_ui displayCtrl 375) ctrlSettext "\A3\ui_f\data\gui\rsc\rscdisplaygear\ui_gear_vest_gs.paa";
			if (btc_gear_container_selected == 1) then
			{
				lbClear 373;
				(_ui displayCtrl 380) progressSetPosition 0;
			};
			call btc_fnc_gear_get_text;
		}
		else
		{		
			_load = loadVest player;
			_items = vestItems player;
			(_ui displayCtrl 380) progressSetPosition _load;
			[373,_items] call btc_fnc_gear_lb_fill;
			btc_gear_container_selected = 1;
		};
	};
	case 2 : 
	{
		if (_click == 1) then
		{
			removeBackPack player;
			(_ui displayCtrl 376) ctrlSettext "\A3\ui_f\data\gui\rsc\rscdisplaygear\ui_gear_backpack_gs.paa";
			if (btc_gear_container_selected == 2) then
			{
				lbClear 373;
				(_ui displayCtrl 380) progressSetPosition 0;
			};
			call btc_fnc_gear_get_text;
		}
		else
		{		
			_load = loadBackPack player;
			_items = backPackItems player;
			(_ui displayCtrl 380) progressSetPosition _load;
			[373,_items] call btc_fnc_gear_lb_fill;
			btc_gear_container_selected = 2;
		};
	};
};