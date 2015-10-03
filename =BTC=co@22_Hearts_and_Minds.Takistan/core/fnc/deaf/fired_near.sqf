_hearer   = _this select 0;
_shooter  = _this select 1;
_distance = _this select 2;
_weapon   = _this select 3;

_max_distance = 5;

if (_weapon == "Throw") exitWith {};

if (player != _hearer || {_distance > _max_distance}) exitWith {};
if (player getVariable ["btc_hasEarplugs",false]) exitWith {};

_magazine = (getArray(configFile >> "CfgWeapons" >> _weapon >> "magazines")) select 0;_magazine = (getArray(configFile >> "CfgWeapons" >> _weapon >> "magazines")) select 0;

_ammo = getText(configFile >> "CfgMagazines" >> _magazine >> "ammo");
_caliber = getNumber(configFile >> "CfgAmmo" >> _ammo >> "caliber");
_audible_fire = getNumber(configFile >> "CfgAmmo" >> _ammo >> "audibleFire");
_initSpeed = getNumber(configFile >> "CfgMagazines" >> _magazine >> "initSpeed");

if (_audible_fire < 6) exitWith {};
if (_initSpeed < 500 && {_audible_fire < 10}) exitWith {};

if (_distance < 1) then {_distance = 1;};

_deafness = (_audible_fire/btc_deaf_ratio) * (0.8/_distance);

if (_audible_fire >= 10) then {_deafness = _deafness + (_audible_fire / 4)};

if (_caliber < 1.6) then {_deafness = _deafness / 5};

player setVariable ["btc_deafness",(player getVariable "btc_deafness") + _deafness];

if (!(player getVariable ["btc_isDeaf",false]) && {_audible_fire >= 10}) then
{
	playSound "combat_deafness";
};

