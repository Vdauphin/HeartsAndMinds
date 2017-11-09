
private ["_name","_is_real","_text"];

_name = _this select 0;
_is_real = _this select 1;

_text = "";

switch _is_real do {
	case _is_real : {
		btc_int_ask_data = nil;
		[1,[],player] remoteExec ["btc_fnc_int_ask_var", 2];

		waitUntil {!(isNil "btc_int_ask_data")};

		if (!isNull btc_int_ask_data) then {
			private ["_hideout","_dist","_dir","_card"];
			_hideout = btc_int_ask_data;
			_dist = (player distance _hideout) + ((random 500) - (random 500));
			_dir = player getDir _hideout;
			_card = [_dir] call btc_fnc_get_cardinal;
			_text = format [(localize "STR_BTC_HAM_CON_INFO_ASKHIDEOUT_TRUE"), _name,_card,round _dist]; //%1: I saw a lot of militia activity towards %2, %3 meter from here. Probably there is an hideout!
		} else {_text = format [(localize "STR_BTC_HAM_CON_INFO_ASKHIDEOUT_FALSE"), _name];}; //%1: There are no hideout around here!
	};
	case (!_is_real) : {
		if ((random 1) > 0.5) then {
			private ["_array","_dist","_dir"];
			_array = ["N","E","W","S","NW","NE","SE","SW"];
			_dir = selectRandom _array;
			_dist = 300 + (random 2000);
			_text = format [(localize "STR_BTC_HAM_CON_INFO_ASKHIDEOUT_TRUE"), _name,_dir,round _dist]; //%1: I saw a lot of militia activity towards %2, %3 meter from here. Probably there is an hideout!
		} else {
			_text = format [(localize "STR_BTC_HAM_CON_INFO_ASKHIDEOUT_FALSE"), _name]; //%1: There are no hideout around here!
		};
	};
};

if (btc_debug) then {_text = _text + " - " + str(_is_real)};

hint _text;
player createDiaryRecord [(localize "STR_BTC_HAM_CON_INFO_ASKHIDEOUT_DIARYLOG"), [str(mapGridPosition player) + " - " + _name, _text]]; //Diary log
