
btc_log_object_selected = _this;

hint parseText format ["%1 selected<br/>CR: %2<br/>Interact with a vehicle to load it in!",getText (configFile >> "cfgVehicles" >> typeof btc_log_object_selected >> "displayName"),[btc_log_object_selected] call btc_fnc_log_get_rc];