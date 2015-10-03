_key   = _this select 1;
_shift = _this select 2;
_ctrl = _this select 3;

//if (_key in (actionKeys "moveUp") && {player getVariable ["btc_rev_isDragging",false]}) then {player setVariable ["btc_rev_isDragging",false];};

if (dialog || player getVariable ["btc_rev_isUnc",false] || player getVariable ["btc_int_busy",false]) exitWith {};// 
btc_int_target = objNull;

switch (true) do
{
	case (_key in (actionKeys "User1")) : 
	{
		btc_int_target = player;0 spawn btc_fnc_int_open_dlg;
	};
	case (_key in (actionKeys "User2") && {!(player getVariable ["btc_int_busy",false])} && {vehicle player == player}) : 
	{
		switch (true) do
		{
			case (isPlayer cursorTarget && {cursorTarget distance player < 3} && {!(player getVariable ["btc_rev_isDragging",false]) && !(player getVariable ["btc_rev_isCarrying",false])}) : {btc_int_target = cursorTarget;2 spawn btc_fnc_int_open_dlg;};
			case (side cursorTarget == civilian && {cursorTarget isKindOf "Civilian_F"} && {cursorTarget distance player < 3}) : {btc_int_target = cursorTarget;4 spawn btc_fnc_int_open_dlg;};
			case ({cursorTarget isKindOf _x} count btc_type_ieds > 0 && {cursorTarget distance player < 3}) : {btc_int_target = cursorTarget;5 spawn btc_fnc_int_open_dlg;};
			case (!Alive cursorTarget && {{cursorTarget isKindOf _x} count btc_type_units > 0}) : {btc_int_target = cursorTarget;6 spawn btc_fnc_int_open_dlg;};
			case (cursorTarget == btc_create_object && {cursorTarget distance player < 5}) : {9 spawn btc_fnc_int_open_dlg;};
			case (cursorTarget == btc_gear_object && {cursorTarget distance player < 10}) : {10 spawn btc_fnc_int_open_dlg;};
			case (Alive cursorTarget && {cursorTarget distance player < 5} && {{cursorTarget isKindOf _x} count btc_log_def_loadable > 0} && {typeOf cursorTarget != "Land_CargoBox_V1_F"}) : {btc_int_target = cursorTarget;8 spawn btc_fnc_int_open_dlg;};
			case (cursorTarget distance player < 8 && {{cursorTarget isKindOf _x} count ["LandVehicle","Air"] > 0}) : {btc_int_target = cursorTarget;7 spawn btc_fnc_int_open_dlg;};
			case ((typeOf cursorTarget) == btc_fob_flag && {cursorTarget distance player < 5}) : {11 spawn btc_fnc_int_open_dlg;};
		};
	};
	case (_shift && {vehicle player == player} && {_key in [2,3,4]}) : {_key spawn btc_fnc_int_select_weapon};
};