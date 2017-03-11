
if (btc_side_assigned) exitWith {};

private ["_side","_cycle"];

if (_this isEqualTo []) then {
	_cycle = false;
} else {
	_cycle = _this select 0;
};

if (count btc_side_list_use == 0) then {btc_side_list_use = + btc_side_list;};

_side = selectRandom btc_side_list_use;

btc_side_list_use = btc_side_list_use - [_side];

btc_side_aborted = false;
btc_side_done = false;
btc_side_failed = false;

switch (_side) do {
	case 0 : {[] call btc_fnc_side_supply;};
	case 1 : {[] call btc_fnc_side_mines;};
	case 2 : {[] call btc_fnc_side_vehicle;};
	case 3 : {[] call btc_fnc_side_get_city;};
	case 4 : {[] call btc_fnc_side_tower;};
	case 5 : {[] call btc_fnc_side_civtreatment;};
	case 6 : {[] call btc_fnc_side_checkpoint;};
	case 7 : {[] call btc_fnc_side_civtreatment_boat;};
	case 8 : {[] call btc_fnc_side_underwater_generator;};
	case 9 : {[] call btc_fnc_side_convoy;};
	case 10 : {[] call btc_fnc_side_rescue;};
	case 11 : {[] call btc_fnc_side_capture_officer;};
	case 12 : {[] call btc_fnc_side_hostage;};
};

if (_cycle) then {
	[true] spawn btc_fnc_side_create;
};