
private ["_array_of_string","_section","_key"];

_array_of_string = (_this select 0) call btc_fnc_db_array_to_string;
_section = _this select 1;
_key = _this select 2;

{
	["write", [_section, format ["%1_%2",_key,_forEachIndex], _x]] call OO_fnc_inidbi;
} forEach _array_of_string;
count _array_of_string