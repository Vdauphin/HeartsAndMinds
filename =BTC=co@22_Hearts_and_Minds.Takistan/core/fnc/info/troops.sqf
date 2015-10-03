
private ["_name","_is_real","_text"];

_name = _this select 0;
_is_real = _this select 1;

_text = "";

switch _is_real do
{
	case _is_real : {
		private ["_array"];
		_array = (position player) nearEntities [btc_type_units, 2500];
		if (count _array > 0) then {
			private ["_man","_dist","_dir","_card"];
			_man = _array select 0;
			_dist = (player distance _man) + ((random 150) - (random 150));
			_dir = [player, _man] call BIS_fnc_dirTo;
			_card = [_dir] call btc_fnc_get_cardinal;
			_text = format ["%1: I saw some militia movement %2, %3 meter from here", _name,_card,round _dist];
		} else {
			_text = format ["%1: I didn't see any militia movement in this area!", _name];
		};
	};
	case (!_is_real) : {
		if ((random 1) > 0.5) then {
			private ["_array","_dist","_dir"];
			_array = ["N","E","W","S","NW","NE","SE","SW"];
			_dir = _array select (floor (random (count _array)));
			_dist = (500 + (random 1000));
			_text = format ["%1: I saw some militia movement %2, %3 meter from here", _name,_dir,round _dist];
		} else {
			_text = format ["%1: I didn't see any militia movement in this area!", _name];
		};
	};
};

if (btc_debug) then {_text = _text + " - " + str(_is_real)};

hint _text;
player createDiaryRecord ["Diary log", [str(mapGridPosition player) + " - " + _name, _text]];