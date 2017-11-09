
params ["_player","_uav"];

if !(_uav isKindOf "UAV_06_base_F") exitWith {};

_uav addMagazine "1Rnd_Leaflets_West_F";
if !("Bomb_Leaflets" in (_uav weaponsTurret [-1])) then {
	_uav addWeapon "Bomb_Leaflets";
};
if (needReload _uav == 1) then {reload _uav};

if ((_uav getVariable ["btc_leaflets_eh_added" , -1]) isEqualTo -1) then {
	private _id_f = _uav addEventHandler ["Fired", btc_fnc_eh_leaflets];
	_uav setVariable ["btc_leaflets_eh_added" , _id_f];

	if (btc_debug) then {
		systemChat format ["Add leaflets EventHandler ID: %1", _id_f];
	};
};