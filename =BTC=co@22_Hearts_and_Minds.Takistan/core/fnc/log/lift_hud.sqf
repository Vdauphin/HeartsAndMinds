disableSerialization;
939996 cutRsc ["btc_log_hud","PLAIN"];
_ui        = uiNamespace getVariable "btc_log_hud";
_radar     = _ui displayCtrl 1001;
_obj_img   = _ui displayCtrl 1002;
_obj_pic   = _ui displayCtrl 1003;
_arrow     = _ui displayCtrl 1004;
_obj_name  = _ui displayCtrl 1005;
_array_hud = [_radar,_obj_img,_obj_pic,_arrow,_obj_name];
{_x ctrlShow true;} foreach _array_hud;_obj_img ctrlShow false;
_can_lift = false;

_arrow_up   = "core\img\rsc\lift\arrow_up_ca.paa";
_arrow_down = "core\img\rsc\lift\arrow_down_ca.paa";
_complete   = "core\img\rsc\lift\objective_complete_ca.paa";
_incomplete = "core\img\rsc\lift\objective_incomplete_ca.paa";

while {(Alive player && vehicle player != player) && btc_log_hud} do {
	private ["_cargo"];
	_array = [vehicle player] call btc_fnc_log_get_liftable;
	_cargo_array = nearestObjects [vehicle player, _array, 30];
	if (count _array == 0) then {_cargo_array = [];};
	if (count _cargo_array > 0 && driver (_cargo_array select 0) == player) then {_cargo_array set [0,0];_cargo_array = _cargo_array - [0];};
	if (count _cargo_array > 0) then {_cargo = _cargo_array select 0;} else {_cargo = objNull;};
	if (({_cargo isKindOf _x} count _array) > 0) then {_can_lift = true;} else {_can_lift = false;};
	if (!isNull _cargo) then {
		_cargo_pos = getPosATL _cargo;
		_rel_pos   = (vehicle player) worldToModel _cargo_pos;
		_cargo_x   = _rel_pos select 0;
		_cargo_y   = _rel_pos select 1;
		_cargo_z   = _rel_pos select 2;
		_obj_img ctrlShow true;
		_hud_x   = _cargo_x / 100;
		_hud_y   = 0;
		switch (true) do {
			case (_cargo_y < 0): {_hud_y = (abs _cargo_y) / 100};
			case (_cargo_y > 0): {_hud_y = (0 - _cargo_y) / 100};
		};
		_hud_x_1 = (btc_lift_HUD_x + _hud_x) * safezoneW + safezoneX;;
		_hud_y_1 = (btc_lift_HUD_y + _hud_y) * safezoneH + safezoneY;
		_obj_img ctrlsetposition [_hud_x_1, _hud_y_1];
		_obj_img ctrlCommit 0;
		_pic_cargo = "";
		if (_cargo isKindOf "LandVehicle") then {_pic_cargo = getText (configFile >> "cfgVehicles" >> typeof _cargo >> "picture");} else {_pic_cargo = "";};
		_name_cargo = getText (configFile >> "cfgVehicles" >> typeof _cargo >> "displayName");
		_obj_pic ctrlSetText _pic_cargo;
		if (btc_lifted) then {_obj_name ctrlSetText (format ["[%1 m] ",(round((getpos _cargo select 2) * 10))/10] + _name_cargo);} else {_obj_name ctrlSetText _name_cargo;};
		if ((abs _cargo_z) > btc_lift_max_h) then {_arrow ctrlSetText _arrow_down;};
		if ((abs _cargo_z) < btc_lift_min_h) then {_arrow ctrlSetText _arrow_up;};
		if ((abs _cargo_z) > btc_lift_min_h && (abs _cargo_z) < btc_lift_max_h) then {_arrow ctrlSetText _complete;};
		if !(_can_lift) then {_arrow ctrlSetText _incomplete;};
	} else {_obj_img ctrlShow false;_obj_pic ctrlSetText "";_obj_name ctrlSetText "";_arrow ctrlSetText "";};
	sleep 0.1;
};

939996 cutRsc ["Default","PLAIN"];