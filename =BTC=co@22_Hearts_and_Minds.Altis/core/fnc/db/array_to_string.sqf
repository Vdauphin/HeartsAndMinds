#define SIZESTRING 8098
private ["_array_of_string","_range","_size_array","_string_of_array"];

_string_of_array = str(_this);
_size_array = count _string_of_array;

_Doublequotation_pos = _string_of_array find '"';
while {!(_Doublequotation_pos isEqualTo -1)} do	{
	_string_of_array = (_string_of_array select [0, _Doublequotation_pos]) + "'" + (_string_of_array select [_Doublequotation_pos + 1, _size_array]);
	_Doublequotation_pos = _string_of_array find '"';
};

_range = floor(_size_array/SIZESTRING);
_array_of_string = [];

for "_i" from 0 to (_range - 1) do	{
	_array_of_string pushBack (_string_of_array select [_i * SIZESTRING, SIZESTRING]);
};
_array_of_string pushBack (_string_of_array select [_range * SIZESTRING, _size_array]);
player sideChat "array to string";
player sideChat str(count _array_of_string);
player sideChat str(count ((_array_of_string) select 0));
_array_of_string
