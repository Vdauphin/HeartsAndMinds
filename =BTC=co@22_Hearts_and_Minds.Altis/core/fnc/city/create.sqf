
private ["_position","_type","_name","_radius_x","_radius_y","_has_en","_id","_city"];

_position = _this select 0;
_type = _this select 1;
_name = _this select 2;
_radius_x = _this select 3;
_radius_y = _this select 4;
_has_en = _this select 5;//BOOL
_id = count btc_city_all;

_city = "Land_Ammobox_rounds_F" createVehicle _position;
_city hideObjectGlobal true;
_city allowDamage false;
_city enableSimulation false;
_city setVariable ["activating",false];
_city setVariable ["initialized",false];
_city setVariable ["id",_id];
_city setVariable ["name",_name];
_city setVariable ["RadiusX",_radius_x];
_city setVariable ["RadiusY",_radius_y];
_city setVariable ["active",false];
_city setVariable ["type",_type];
_city setVariable ["spawn_more",false];
_city setVariable ["data_units",[]];
_city setVariable ["occupied",_has_en];

_trigger = createTrigger["EmptyDetector",getPos _city];
_trigger setTriggerArea[(_radius_x+_radius_y) + btc_city_radius,(_radius_x+_radius_y) + btc_city_radius,0,false];
_trigger setTriggerActivation[str(btc_player_side),"PRESENT",true];
_trigger setTriggerStatements ["this && !btc_db_is_saving", format ["[%1] spawn btc_fnc_city_activate",_id], format ["[%1] spawn btc_fnc_city_de_activate",_id]];

if (btc_debug) then	{//_debug
	private ["_marker"];
	_marker = createmarker [format ["loc_%1",_id],_position];
	_marker setMarkerShape "ELLIPSE";
	_marker setMarkerBrush "SolidBorder";
	_marker setMarkerSize [(_radius_x+_radius_y) + btc_city_radius, (_radius_x+_radius_y) + btc_city_radius];
	_marker setMarkerAlpha 0.3;
	if (_has_en) then {_marker setmarkercolor "colorRed";} else {_marker setmarkercolor "colorGreen";};
	_marker = createmarker [format ["locn_%1",_id],_position];
	_marker setmarkertype "mil_dot";
	_marker setmarkertext format ["loc_%3 %1 %2 - [%4]",_name,_type,_id,_has_en];
};

_city 