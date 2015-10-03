/*
	16 Q
	44 Z
	30 A
	32 D
	45 X
	46 C
*/
	
private ["_key","_shift","_ctrl","_alt"];
	
_key   = _this select 1;
_shift = _this select 2;
_ctrl  = _this select 3;
_alt   = _this select 4;
	
_turbo = if (_shift) then {1} else {0};

switch (true) do {	
	case (_key == 16) : {if (btc_log_placing_h > btc_log_placing_max_h) exitWith {true};btc_log_placing_h = btc_log_placing_h + 0.1 + (_turbo/2);btc_log_placing_obj attachTo [player,[0,btc_log_placing_d,btc_log_placing_h]];true};
	case (_key == 44) : {if (btc_log_placing_h < - 2) exitWith {true};btc_log_placing_h = btc_log_placing_h - 0.1 - (_turbo/2);btc_log_placing_obj attachTo [player,[0,btc_log_placing_d,btc_log_placing_h]];true};
	case (_key == 45) : {btc_log_placing_dir = btc_log_placing_dir + 0.5 + _turbo;btc_log_placing_obj setDir btc_log_placing_dir;true};
	case (_key == 46) : {btc_log_placing_dir = btc_log_placing_dir - 0.5 - _turbo;btc_log_placing_obj setDir btc_log_placing_dir;true};
	default {false};
};