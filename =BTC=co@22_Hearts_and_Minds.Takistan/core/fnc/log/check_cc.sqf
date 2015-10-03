_veh  = _this select 0;
_cargo = _this select 1;
_tot_rc   = 0;
{_tot_rc = _tot_rc + ([_x] call btc_fnc_log_get_rc);} foreach _cargo;
_tot_rc