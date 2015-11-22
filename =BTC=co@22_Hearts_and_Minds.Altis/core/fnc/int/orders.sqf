
private ["_order","_unit","_gesture","_pos"];

_order = _this select 0;
_unit = objNull;
if (count _this > 1) then {_unit = _this select 1;};

_gesture = switch (_order) do {case 1 : {"gestureFreeze"};case 2 : {"gestureCover"};case 3 : {"gestureGo"};};

player playActionNow _gesture;

_pos = getpos player;

if (count (_pos nearEntities ["Civilian_F", btc_int_radius_orders]) == 0) exitWith {true};

if (isNull _unit) then {[[_pos,_order],"btc_fnc_int_orders_give",false] spawn BIS_fnc_MP;} else {[[_pos,_order,_unit],"btc_fnc_int_orders_give",_unit] spawn BIS_fnc_MP;};