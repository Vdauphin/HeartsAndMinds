
private ["_order","_unit","_gesture","_pos","_wp","_rep","_ran","_info_type"];

_order = _this select 0;
_unit = objNull;
if (count _this > 1) then {_unit = _this select 1;};

_gesture = switch (_order) do {
	case 1 : {"gestureFreeze"};
	case 2 : {"gestureCover"};
	case 3 : {"gestureGo"};
	case 4 : {"gestureGo"};
};

player playActionNow _gesture;

_pos = getpos player;

if (count (_pos nearEntities [["Car","Civilian_F"], btc_int_radius_orders]) == 0) exitWith {true};

if (isNull _unit) then {
	[[_pos,_order],"btc_fnc_int_orders_give",false] spawn BIS_fnc_MP;
} else {
	if (_order == 4) then {

		btc_int_ask_data = nil;
		[[2,nil,player],"btc_fnc_int_ask_var",false] spawn BIS_fnc_MP;
		waitUntil {!(isNil "btc_int_ask_data")};
		_rep = btc_int_ask_data;

		if (_rep >= 500) then {
			hintSilent "Show me where you want to go with your map.";
			["1", "onMapSingleClick", {
				if (surfaceIsWater _pos) then {
					hintSilent 'Selected area must be on land.';
				} else {
					[[(getpos (_this select 0)),4,_this select 1,_pos],'btc_fnc_int_orders_give',_this select 1] spawn BIS_fnc_MP;
					["1", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
				};
			}, [player, _unit]] call BIS_fnc_addStackedEventHandler;
		} else {
			if (isNil {player getVariable "interpreter"}) exitWith {hint "I can't understand what is saying";};
			_ran = round random 3;
			_info_type = switch (true) do {
				case (_ran == 0) : {"I hate you ! Get out !"};
				case (_ran == 1) : {"Get Out of my car ! You are not welcome."};
				case (_ran == 2) : {"I am not a taxi driver !"};
				case (_ran == 3) : {"No ! I go where I want ! "};
			};
			_text = format ["%1", _info_type];
			hint _text;
		};
	} else {
		[[_pos,_order,_unit],"btc_fnc_int_orders_give",_unit] spawn BIS_fnc_MP;
	};
};