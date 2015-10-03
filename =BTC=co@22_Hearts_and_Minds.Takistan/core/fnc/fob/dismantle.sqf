	_cond = false;
	_array = nearestObjects [position player, BTC_fob_materials, 10];
	if (count _array > 0) then {_cond = true;};
	if (!_cond) exitWith {hint "Can't find the material required!";};
	_cond = false;
	_obj = _array select 0;
	if (_obj distance getMarkerpos "respawn_west" > 500) then {_cond = true;};//500
	if (!_cond) exitWith {hint "Too close to the main base!";};
	_pos = getPos _obj;
	deleteVehicle _obj;
	hint "Get back! Mounting FOB";
	_struc = createVehicle [BTC_fob_sign, [_pos select 0,_pos select 1,-10], [], 0, "NONE"];//"Land_Cargo_HQ_V1_F" // "Land_Cargo_House_V1_F"
	_flag  = createVehicle ["FlagPole_F", _pos, [], 0, "NONE"];
	_flag setFlagTexture "=BTC=_flagpole.paa";
	_h = - 10;
	while {_h < 0} do
	{
		_h = _h + 0.1;
		_struc setpos [_pos select 0,_pos select 1,_h];
		sleep 0.1;
	};
	{_x setpos _pos} foreach [_flag,_struc];
	_flag setVariable ["BTC_mobile_west",format ["FOB_%1",BTC_fob_id],true];
	BTC_fob_placed = BTC_fob_placed + [_flag];publicVariable "BTC_fob_placed";//Till nearestObjects will work again
	BTC_vehs_mobile_west_str = BTC_vehs_mobile_west_str + [format ["FOB_%1",BTC_fob_id]];
	BTC_fob_id = BTC_fob_id + 1;publicVariable "BTC_fob_id";publicVariable "BTC_vehs_mobile_west_str";
	_flag setvariable ["BTC_cannot_lift",1,true];
	_flag setVariable ["BTC_cannot_drag",1,true];
	_flag setVariable ["BTC_cannot_load",1,true];
	_flag setVariable ["BTC_cannot_place",1,true];
	_marker = createmarkerLocal [(_flag getVariable "BTC_mobile_west"), getPos _flag];
	(_flag getVariable "BTC_mobile_west") setMarkerSizeLocal [0.5,0.5];
	(_flag getVariable "BTC_mobile_west") setMarkerTypeLocal "hd_flag";
	(_flag getVariable "BTC_mobile_west") setMarkerTextLocal (_flag getVariable "BTC_mobile_west");
	(_flag getVariable "BTC_mobile_west") setMarkerColorLocal "ColorBlue";
	(_flag getVariable "BTC_mobile_west") setMarkerShapelocal "ICON";	
	BTC_m_PVEH = [1,_flag];publicVariable "BTC_m_PVEH";
	_flag addAction [("<t color=""#12F905"">") + ("Dismantle FOB") + "</t>","=BTC=_revive\=BTC=_addAction.sqf",[[_flag],BTC_dismantle_fob], 8, true, true, "", "true"];
	hint "FOB assembled!";