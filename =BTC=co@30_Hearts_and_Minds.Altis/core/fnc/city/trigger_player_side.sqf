
private ["_trigger","_radius_x","_radius_y","_city","_position","_has_en","_name","_type","_id"];

_position	= _this select 0;
_radius_x	= _this select 1;
_radius_y	= _this select 2;
_city		= _this select 3;
_has_en		= _this select 4;
_name		= _this select 5;
_type		= _this select 6;
_id			= _this select 7;

_trigger = createTrigger["EmptyDetector",_position];
_trigger setTriggerArea[(_radius_x+_radius_y) + btc_city_radius,(_radius_x+_radius_y) + btc_city_radius,0,false];
_trigger setTriggerActivation[str(btc_player_side),"PRESENT",true];
_trigger setTriggerStatements [btc_p_trigger, format ["[%1] spawn btc_fnc_city_activate",_id], format ["[%1] spawn btc_fnc_city_de_activate",_id]];
_city setVariable ["trigger_player_side",_trigger];

if (btc_debug) then	{//_debug
	private ["_marker","_marke"];
	_marker = createmarker [format ["loc_%1",_id],_position];
	_marker setMarkerShape "ELLIPSE";
	_marker setMarkerBrush "SolidBorder";
	_marker setMarkerSize [(_radius_x+_radius_y) + btc_city_radius, (_radius_x+_radius_y) + btc_city_radius];
	_marker setMarkerAlpha 0.3;
	//_marker setmarkertype "mil_dot";
	if (_has_en) then {_marker setmarkercolor "colorRed";} else {_marker setmarkercolor "colorGreen";};
	//_marker setmarkeralpha 0.5;
	_marke = createmarker [format ["locn_%1",_id],_position];
	_marke setmarkertype "mil_dot";
	_marke setmarkertext format ["loc_%3 %1 %2 - [%4] - [%5] ",_name,_type,_id,_has_en, _city getVariable ["hasbeach", "empty"] ];
};