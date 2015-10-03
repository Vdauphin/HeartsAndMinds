_pos = _this select 0;
_random_area = _this select 1;

_return_pos = _pos;

_pos_x = _pos select 0;
_pos_y = _pos select 1;

_pos_x = _pos_x + ((random _random_area) - (random _random_area));
_pos_y = _pos_y + ((random _random_area) - (random _random_area));

_check_pos = [_pos_x, _pos_y, 0];

if (surfaceIsWater _check_pos) then 
{
	_return_pos = [_check_pos, 0, _random_area, 13, 0, 60 * (pi / 180), 0] call BIS_fnc_findSafePos;
} 
else
{
	_return_pos = _check_pos;
};
_return_pos