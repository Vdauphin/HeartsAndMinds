_obj  = _this select 0;
_type = typeOf _obj;
_cc   = 0;
_cond = false;
for "_i" from 0 to (count btc_log_def_cc - 1) do 
{
	if (typeName (btc_log_def_cc select _i) == "STRING" && !_cond) then
	{
		if (!_cond && _type == (btc_log_def_cc select _i)) then {_cc = (btc_log_def_cc select (_i + 1));_cond = true;};
	};
};
if (!_cond) then 
{
	for "_i" from 0 to (count btc_log_main_cc - 1) do 
	{
		if (typeName (btc_log_main_cc select _i) == "STRING") then
		{
			if (!_cond && _type isKindOf (btc_log_main_cc select _i)) then {_cc = (btc_log_main_cc select (_i + 1));_cond = true;};
		};
	};
};
_cc