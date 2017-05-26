
private ["_tower","_towed","_array","_can_tow","_pos_towed","_pos_tower"];

// _tower ----rope--- (hook)_towed
_tower = _this select 0;
_towed = _this select 1;//btc_log_vehicle_selected

_array = [_tower] call btc_fnc_log_get_nottowable;

if !({_towed isKindOf _x} count _array == 0) exitWith {false};

_can_tow = false;


_pos_towed = [];
_pos_tower = [];

_pos_towed = _towed modeltoworld [0,5,0];
_pos_tower = _tower modeltoworld [0,-6,0];

if (_pos_tower distance _pos_towed < 10) then {_can_tow = true;};

_can_tow
