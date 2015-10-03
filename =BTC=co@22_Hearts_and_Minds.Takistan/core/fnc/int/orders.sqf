/*
		{(_ui displayCtrl _x) ctrlShow false;} foreach [9995,9996];
		(_ui displayCtrl 9991) ctrlSetText "Stop";
		(_ui displayCtrl 9991) buttonSetAction "[1] spawn btc_fnc_int_orders";
		(_ui displayCtrl 9992) ctrlSetText "Get down";
		(_ui displayCtrl 9992) buttonSetAction "[2] spawn btc_fnc_int_orders";
		(_ui displayCtrl 9994) ctrlSetText "Go away";
		(_ui displayCtrl 9994) buttonSetAction "[3] spawn btc_fnc_int_orders";
		(_ui displayCtrl 9993) ctrlSetText "Hands up";
		(_ui displayCtrl 9993) buttonSetAction "[4] spawn btc_fnc_int_orders";
*/
//closeDialog 0;

private ["_order","_unit","_gesture","_pos"];

_order = _this select 0;
_unit = objNull;
if (count _this > 1) then {_unit = _this select 1;};

_gesture = switch (_order) do {case 1 : {"gestureFreeze"};case 2 : {"gestureCover"};case 3 : {"gestureGo"};};

player playActionNow _gesture;

_pos = getpos player;

if (count (_pos nearEntities ["Civilian_F", btc_int_radius_orders]) == 0) exitWith {true};

if (isNull _unit) then {[[_pos,_order],"btc_fnc_int_orders_give",false] spawn BIS_fnc_MP;} else {[[_pos,_order,_unit],"btc_fnc_int_orders_give",_unit] spawn BIS_fnc_MP;};