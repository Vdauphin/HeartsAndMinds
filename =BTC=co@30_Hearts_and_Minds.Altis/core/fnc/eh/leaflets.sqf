
params ["_uav","_weapon"];

if (btc_debug) then {
	systemChat format ["UAV: %1 fired with %2", typeOf _uav, _weapon];
};

if (_weapon isEqualTo "Bomb_Leaflets") then {
	[getPos _uav] remoteExec ["btc_fnc_civ_evacuate", 2];
};