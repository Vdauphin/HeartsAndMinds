_mat = _this select 0;
_name = _this select 1;

_pos = getPos _mat;
deleteVehicle _mat;

_struc = createVehicle [btc_fob_structure, [_pos select 0,_pos select 1,-10], [], 0, "NONE"];
_flag  = createVehicle [btc_fob_flag, _pos, [], 0, "NONE"];

_h = - 10;
while {_h < 0} do {
	_h = _h + 0.1;
	_struc setpos [_pos select 0,_pos select 1,_h];
	sleep 0.1;
};
{_x setpos _pos} foreach [_flag,_struc];

_marker = createmarker [("FOB " + _name), getPos _flag];
("FOB " + _name) setMarkerSize [1,1];
("FOB " + _name) setMarkerType "hd_flag";
("FOB " + _name) setMarkerText (("FOB " + _name));
("FOB " + _name) setMarkerColor "ColorBlue";
("FOB " + _name) setMarkerShape "ICON";	

btc_fobs pushBack (("FOB " + _name));

[[7,("FOB " + _name)],"btc_fnc_show_hint"] spawn BIS_fnc_MP;
/*
//_flag setVariable ["BTC_mobile_west",format ["FOB_%1",BTC_fob_id],true];
	BTC_fob_placed = BTC_fob_placed + [_flag];publicVariable "BTC_fob_placed";//Till nearestObjects will work again
	BTC_vehs_mobile_west_str = BTC_vehs_mobile_west_str + [format ["FOB_%1",BTC_fob_id]];
	BTC_fob_id = BTC_fob_id + 1;publicVariable "BTC_fob_id";publicVariable "BTC_vehs_mobile_west_str";
	_flag setvariable ["BTC_cannot_lift",1,true];
	_flag setVariable ["BTC_cannot_drag",1,true];
	_flag setVariable ["BTC_cannot_load",1,true];
	_flag setVariable ["BTC_cannot_place",1,true];
	_marker = createmarker [(_flag getVariable "BTC_mobile_west"), getPos _flag];
	(_flag getVariable "BTC_mobile_west") setMarkerSize [0.5,0.5];
	(_flag getVariable "BTC_mobile_west") setMarkerType "hd_flag";
	(_flag getVariable "BTC_mobile_west") setMarkerText (_flag getVariable "BTC_mobile_west");
	(_flag getVariable "BTC_mobile_west") setMarkerColor "ColorBlue";
	(_flag getVariable "BTC_mobile_west") setMarkerShape "ICON";	
	BTC_m_PVEH = [1,_flag];publicVariable "BTC_m_PVEH";
	_flag addAction [("<t color=""#12F905"">") + ("Dismantle FOB") + "</t>","=BTC=_revive\=BTC=_addAction.sqf",[[_flag],BTC_dismantle_fob], 8, true, true, "", "true"];
	hint "FOB assembled!";
	
	#define east_pack "Land_Pod_Heli_Transport_04_box_F"
#define west_pack "B_Slingload_01_Cargo_F" */