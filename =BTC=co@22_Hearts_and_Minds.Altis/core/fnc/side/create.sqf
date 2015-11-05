
if (btc_side_assigned) exitWith {};

if (count btc_side_list_use == 0) then {btc_side_list_use = + btc_side_list;};

_side = btc_side_list_use select (floor random count btc_side_list_use);

btc_side_list_use = btc_side_list_use - [_side];

btc_side_aborted = false;
btc_side_done = false;
btc_side_failed = false;

switch (_side) do {
	case 0 : {[] spawn btc_fnc_side_supply;};
	case 1 : {[] spawn btc_fnc_side_mines;};
	case 2 : {[] spawn btc_fnc_side_vehicle;};
	case 3 : {[] spawn btc_fnc_side_get_city;};
	case 4 : {[] spawn btc_fnc_side_tower;};
	case 5 : {[] spawn btc_fnc_side_civtreatment;};
	case 6 : {[] spawn btc_fnc_side_checkpoint;};
};