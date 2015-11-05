
private ["_unit"];

_unit = _this select 0;

switch true do {
	case (side _unit == btc_enemy_side) : {
		_unit call btc_fnc_mil_unit_create;
		
		_type = typeOf _unit;
		if (isNil "btc_actions_units") then {btc_actions_units = [];};
		if !(_type in btc_actions_units) then {
			btc_actions_units pushBack _type;
			_action = ["Search_intel", "Search for intel", "", {(_this select 0) spawn btc_fnc_info_search_for_intel;}, {!Alive (_this select 0)}] call ace_interact_menu_fnc_createAction;
			[_type, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;
		};
		
	};
	case (side _unit == civilian) : {
		_unit call btc_fnc_civ_unit_create;
	};
};