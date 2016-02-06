
private ["_string_of_array"];

_string_of_array = "";
{
	_string_of_array = _string_of_array + _x;
} forEach _this;

call compile _string_of_array