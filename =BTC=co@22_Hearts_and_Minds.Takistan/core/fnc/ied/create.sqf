_pos = _this select 0;
_type = _this select 1;
_dir = _this select 2;
_active = _this select 3;

if (btc_debug_log) then {diag_log format ["CREATE IED %1",_this];};
_ied = _type createVehicle _pos;

_ied addEventHandler ["HandleDamage",{0}];

_ied spawn btc_fnc_ied_fired_near;

_ied setDir (random 360);

_ied setVariable ["active",_active];

_ied