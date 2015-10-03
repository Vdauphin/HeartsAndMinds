_idc = _this select 0;
_items = _this select 1;

hint str(_this);

lbClear _idc;
{
	private ["_type","_index","_displayName","_picture"];
	_type = "cfgMagazines";
	if (isClass (configFile >> "cfgWeapons" >> _x)) then {_type = "cfgWeapons"};
	if (isClass (configFile >> "CfgGlasses" >> _x)) then {_type = "CfgGlasses"};
	_displayName = getText (configFile >> _type >> _x >> "displayName");
	_picture = getText (configFile >> _type >> _x >> "picture");
	_index = lbAdd [ _idc, _displayName ];
	lbSetData [ _idc, _index, _x ];
	lbSetTooltip [ _idc, _index, _displayName ];	
	lbSetPicture [ _idc, _index, _picture ];	
} foreach _items;	