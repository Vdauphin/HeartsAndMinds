_cond = false;
if (getNumber (configFile >> "CfgVehicles" >> typeOf _this >> "engineer") == 1 || _this getVariable ["btc_isEngineer",false]) then {_cond = true;};
_cond