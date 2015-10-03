_w = _this select 0;
_i = _this select 1;

_ui = uiNamespace getVariable "btc_gear_dlg";

switch _w do
{
	case 0 : 
	{
		_items = primaryWeaponItems player;
		_item = _items select _i;
		if (_item != "") then {player removePrimaryWeaponItem _item;(_ui displayCtrl (3930 + _i)) ctrlSettext "";};
	};
	case 1 : 
	{
		_items = secondaryWeaponItems player;
		_item = _items select _i;
		if (_item != "") then {/*player removeSecondaryWeaponItem _item;(_ui displayCtrl (3940 + _i)) ctrlSettext "";*/};
	};
	case 2 : 
	{
		_items = handgunItems player;
		_item = _items select _i;
		if (_item != "") then {player removeHandgunItem _item;(_ui displayCtrl (3950 + _i)) ctrlSettext "";};
	};
};