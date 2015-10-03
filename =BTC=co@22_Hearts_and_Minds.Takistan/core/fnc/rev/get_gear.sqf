_unit = _this select 0;
_weapons_array = [weapons player,primaryWeaponItems player,secondaryWeaponItems player,handgunItems player,primaryWeaponMagazine player,secondaryWeaponMagazine player,handgunMagazine player];
_gear_array = 
[
	uniform _unit,
	vest _unit,
	headGear _unit,
	backpack _unit,
	assignedItems _unit,
	getMagazineCargo uniformContainer _unit,
	getItemCargo uniformContainer _unit,
	getMagazineCargo vestContainer _unit,
	getItemCargo vestContainer _unit,
	getMagazineCargo backpackContainer _unit,
	getItemCargo backpackContainer _unit
];
_gear =
[
	_weapons_array,
	_gear_array
];
_gear