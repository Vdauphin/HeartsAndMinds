_cond = false;
if (getNumber (configFile >> "CfgVehicles" >> typeOf _this >> "attendant") == 1 || _this getVariable ["btc_rev_isMedic",false]) then {_cond = true;};
_cond