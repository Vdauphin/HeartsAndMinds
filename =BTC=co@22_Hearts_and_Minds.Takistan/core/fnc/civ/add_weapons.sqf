
private ["_unit","_hgun","_weapon","_magazine"];

_unit = _this select 0;

_hgun = false;

{if (_unit distance _x < 50 && {[_x,_unit] call btc_fnc_check_los}) then {_hgun = true;};} foreach playableUnits;

//btc_w_civs = ["V_Rangemaster_belt","arifle_Mk20_F","30Rnd_556x45_Stanag","hgun_ACPC2_F","9Rnd_45ACP_Mag"];

_weapon = if (_hgun) then {(btc_w_civs select 3)} else {(btc_w_civs select 1)};
_magazine = if (_hgun) then {(btc_w_civs select 4)} else {(btc_w_civs select 2)};

(uniformContainer _unit) addMagazineCargo [_magazine, 10];
_unit addWeapon _weapon;
_unit selectWeapon _weapon;