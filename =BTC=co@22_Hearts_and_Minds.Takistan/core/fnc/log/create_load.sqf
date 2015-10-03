lbClear 71;
_main_class = btc_construction_array select 0;
_sub_class  = btc_construction_array select 1;
for "_i" from 0 to ((count _main_class) - 1) do
{
	_lb = lbAdd [71,(_main_class select _i)];if (_i == 0) then {lbSetCurSel [71,_lb];};
};
_category = _sub_class select 0;
lbClear 72;
for "_i" from 0 to ((count _category) - 1) do
{
	private ["_class","_display"];
	_class = (_category select _i);
	_display = getText (configFile >> "cfgVehicles" >> _class >> "displayName");
	//_lb = lbAdd [72,_display];
	//lbSetData [72, _i, _class];
	_index = lbAdd [72,_display];
	lbSetData [72, _index, _class];
	if (_i == 0) then {lbSetCurSel [72,_index];};
};	
true