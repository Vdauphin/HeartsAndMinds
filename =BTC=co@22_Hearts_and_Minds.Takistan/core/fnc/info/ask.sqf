if (isNil {player getVariable "interpreter"}) exitWith {hint "I can't understand what is saying";};

private ["_man","_rep","_chance","_info","_info_type","_random"];

_man = _this select 0;
if (!isNil {_man getVariable "btc_already_asked"}) exitWith {hint format ["%1 I already answered to your question!", name _man];};
_man setVariable ["btc_already_asked",true];


//NO < 200 . FAKE < 600 . REAL > 600

btc_int_ask_data = nil;
[[2,nil,player],"btc_fnc_int_ask_var",false] spawn BIS_fnc_MP;
	
waitUntil {!(isNil "btc_int_ask_data")};

_rep = btc_int_ask_data;

_chance = (random 300) + (random _rep + (_rep/2));
_info = "";_info_type = "";
switch (true) do {
	case (_chance < 200) : {_info_type = "NO";};
	case (_chance >= 200 && _chance < 600) : {_info_type = "FAKE";};
	case (_chance >= 600) : {_info_type = "REAL";};
};

if (_info_type == "NO") exitWith {hint format ["%1: I've no information for you", name _man];};

_random = random 10;
switch (true) do {
	case (_random < 4) : {_info = "TROOPS";};
	case (_random >= 4 && _random < 8) : {_info = "HIDEOUT";};
	case (_random >= 8) : {_info = "CACHE";};
};

switch (_info_type) do {
	case "REAL" : {
		switch (_info) do {
			case "TROOPS" : {
				[(name _man),true] spawn btc_fnc_info_troops;
			};
			case "HIDEOUT" : {
				[(name _man),true] spawn btc_fnc_info_hideout_asked;
			};
			case "CACHE" : {
				hint format ["%1: I'll show you some hint on the map", name _man];
				sleep 2;
				[[true,1],"btc_fnc_info_cache",false] spawn BIS_fnc_MP;	
			};
		};		
	};
	case "FAKE" : {
		switch (_info) do {
			case "TROOPS" : {
				[(name _man),false] spawn btc_fnc_info_troops;
			};
			case "HIDEOUT" : {
				[(name _man),false] spawn btc_fnc_info_hideout_asked;
			};
			case "CACHE" : {
				hint format ["%1: I'll show you some hint on the map", name _man];
				sleep 2;
				[[false,1],"btc_fnc_info_cache",false] spawn BIS_fnc_MP;				
			};
		};	
	};
};