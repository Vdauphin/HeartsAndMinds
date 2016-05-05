
private ["_array_to_save","_section","_key","_number_of_array","_step","_temp_save","_size_temp_array"];

_array_to_save = _this select 0;
_section = _this select 1;
_key = _this select 2;

_step = count _array_to_save;
_number_of_array = 0;

while {!(_array_to_save isEqualTo [])} do	{
	if (_step isEqualTo 0) exitWith {
		hint "Error Array too big";
		_nb_cities_array ="Error Array too big";
	};

	_temp_save = +_array_to_save;
	_temp_save resize _step;
	_size_temp_array = count (str(_temp_save));
	switch (_size_temp_array < 8100) do	{
		case true:
		{
			["write", [_section, format ["%1_%2",_key,_number_of_array], _temp_save]] call OO_fnc_inidbi;
			_array_to_save deleteRange [0,_step];
			if (count _array_to_save < _step) then {_step = count _array_to_save};
			_number_of_array = _number_of_array + 1;
		};
		default
		{
			player sideChat str(_size_temp_array/8100);
			player sideChat str(_step);
			_step = floor(_step/ (_size_temp_array/8100));
			player sideChat str(_step);
		};
	};
};
_number_of_array