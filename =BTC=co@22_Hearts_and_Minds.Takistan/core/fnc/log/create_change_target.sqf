_var = lbText [71,lbCurSel 71];
_main_class = btc_construction_array select 0;
_sub_class  = btc_construction_array select 1;
_id = _main_class find _var;
_category = _sub_class select _id;
lbClear 72;
for "_i" from 0 to ((count _category) - 1) do
{
	private ["_class","_display","_index"];
	_class = (_category select _i);
	_display = getText (configFile >> "cfgVehicles" >> _class >> "displayName");
	//_lb = lbAdd [72,_display];
	_index = lbAdd [72,_display];
	lbSetData [72, _index, _class];
	if (_i == 0) then {lbSetCurSel [72,_index];};
};