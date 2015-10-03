/*_text = "Rifle: ";
_br = "<br />";

_w = primaryWeapon player;
if (_w == "") then {_text = _text + "None";} else {_text = _text + (getText (configFile >> "cfgWeapons" >> _w >> "displayName"));};
_text = _text + _br;
_w_items = primaryWeaponItems player;
_i = 0;
if ({_x != ""} count _w_items > 0) then
{
	_text = _text + "Accessories: ";
	{
		if (_x != "") then {if (_i > 0) then {_text = _text + ", ";};_text = _text + (getText (configFile >> "cfgWeapons" >> _x >> "displayName"));_i = _i + 1;};
	} foreach _w_items;
} else {_text = _text + "Accessories: None";};
_text = _text + _br + _br + "Launcher: ";
_s = secondaryWeapon player;
if (_s == "") then {_text = _text + "None";} else {_text = _text + (getText (configFile >> "cfgWeapons" >> _s >> "displayName"));};
_text = _text + _br;
_s_items = secondaryWeaponItems player;
_i = 0;
if ({_x != ""} count _s_items > 0) then
{
	_text = _text + "Accessories: ";
	{
		if (_x != "") then {if (_i > 0) then {_text = _text + ", ";};_text = _text + (getText (configFile >> "cfgWeapons" >> _x >> "displayName"));_i = _i + 1;};
	} foreach _s_items;
} else {_text = _text + "Accessories: None";};
_text = _text + _br + _br + "Hand gun: ";
_h = handGunWeapon player;
if (_h == "") then {_text = _text + "None";} else {_text = _text + (getText (configFile >> "cfgWeapons" >> _h >> "displayName"));};
_text = _text + _br;
_h_items = secondaryWeaponItems player;
_i = 0;
if ({_x != ""} count _h_items > 0) then
{
	_text = _text + "Accessories: ";
	{
		if (_x != "") then {if (_i > 0) then {_text = _text + ", ";};_text = _text + (getText (configFile >> "cfgWeapons" >> _x >> "displayName"));_i = _i + 1;};
	} foreach _h_items;
} else {_text = _text + "Accessories: None";};
_text = _text + _br + _br + "Ammo and items:";
*/
_ui = uiNamespace getVariable "btc_gear_dlg";
_text = "";
_w = primaryWeapon player;
if (_w == "") then {_text = "None";} else {_text = getText (configFile >> "cfgWeapons" >> _w >> "displayName");};
(_ui displayCtrl 3910) ctrlSettext _text;

_w_items = primaryWeaponItems player;
_i = 0;
{
	if (_x != "") then {(_ui displayCtrl (3930 + _i)) ctrlSettext (getText (configFile >> "cfgWeapons" >> _x >> "picture"))} else {(_ui displayCtrl (3930 + _i)) ctrlSettext ""};
	_i = _i + 1;
} foreach _w_items;

_text = "";
_s = secondaryWeapon player;
if (_s == "") then {_text = "None";} else {_text = getText (configFile >> "cfgWeapons" >> _s >> "displayName");};
(_ui displayCtrl 3911) ctrlSettext _text;

_w_items = secondaryWeaponItems player;
_i = 0;
{
	if (_x != "") then {(_ui displayCtrl (3940 + _i)) ctrlSettext (getText (configFile >> "cfgWeapons" >> _x >> "picture"))} else {(_ui displayCtrl (3940 + _i)) ctrlSettext ""};
	_i = _i + 1;
} foreach _w_items;

_text = "";
_h = handGunWeapon player;
if (_h == "") then {_text = "None";} else {_text = getText (configFile >> "cfgWeapons" >> _h >> "displayName");};
(_ui displayCtrl 3912) ctrlSettext _text;

_w_items = handGunItems player;
_i = 0;
{
	if (_x != "") then {(_ui displayCtrl (3950 + _i)) ctrlSettext (getText (configFile >> "cfgWeapons" >> _x >> "picture"))} else {(_ui displayCtrl (3950 + _i)) ctrlSettext ""};
	_i = _i + 1;
} foreach _w_items;

_mags = magazines player;
_items = (items player) + (assignedItems player);

_idc = 3921;
lbClear _idc;

if (count _mags > 0) then
{
	while {count _mags > 0} do
	{
		_i = _mags select 0;
		_n = {_i == _x} count _mags;
		_displayName = format ["[%2] %1",(getText (configFile >> "cfgMagazines" >> _i >> "displayName")),_n];
		_picture = getText (configFile >> "cfgMagazines" >> _i >> "picture");
		_index = lbAdd [ _idc, _displayName ];
		lbSetData [ _idc, _index, _i ];
		lbSetTooltip [ _idc, _index, _displayName ];	
		lbSetPicture [ _idc, _index, _picture ];
		_mags = _mags - [_i];
	};
};
if (count _items > 0) then
{
	while {count _items > 0} do
	{
		_i = _items select 0;
		_n = {_i == _x} count _items;
		_displayName = format ["[%2] %1",(getText (configFile >> "cfgWeapons" >> _i >> "displayName")),_n];
		_picture = getText (configFile >> "cfgWeapons" >> _i >> "picture");
		_index = lbAdd [ _idc, _displayName ];
		lbSetData [ _idc, _index, _i ];
		lbSetTooltip [ _idc, _index, _displayName ];	
		lbSetPicture [ _idc, _index, _picture ];
		_items = _items - [_i];
	};
};

lbSort [((uiNamespace getVariable "btc_gear_dlg") displayCtrl _idc), "ASC"];


true 