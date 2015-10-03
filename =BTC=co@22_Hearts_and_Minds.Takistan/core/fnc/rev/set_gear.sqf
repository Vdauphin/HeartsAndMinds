_unit = _this select 0;
_gear = _this select 1;
_weapons_array = _gear select 0;
_gear_array    = _gear select 1;

removeAllweapons player;
removeAllAssignedItems player;
removeuniform player;
removevest player;
removeheadgear player;
removegoggles player;
removeBackPack player;
	
if ((_gear_array select 0) != "") then {player addUniform (_gear_array select 0);};
if ((_gear_array select 1) != "") then {player addVest (_gear_array select 1);};
if ((_gear_array select 2) != "") then {player addheadGear (_gear_array select 2);};
if ((_gear_array select 3) != "") then {player addBackpack (_gear_array select 3);};

{player addMagazine _x;} foreach (_weapons_array select 4);
{player addMagazine _x;} foreach (_weapons_array select 5);
{player addMagazine _x;} foreach (_weapons_array select 6);
{player addWeapon _x} foreach (_weapons_array select 0);
if (count (_weapons_array select 1) > 0) then {{if (_x != "") then {player addPrimaryWeaponItem _x;};} foreach (_weapons_array select 1);};
if (count (_weapons_array select 2) > 0) then {{if (_x != "") then {player addSecondaryWeaponItem _x;};} foreach (_weapons_array select 2);};
if (count (_weapons_array select 3) > 0) then {{if (_x != "") then {player addHandgunItem _x;};} foreach (_weapons_array select 3);};
	
if (count (_gear_array select 4) > 0) then {{if (_x != "" && _x != "Binocular" && _x != "Rangefinder" && _x != "Laserdesignator") then {player addItem _x;player assignItem _x;} else {player addWeapon _x;};} foreach (_gear_array select 4);};  

if ((count ((_gear_array select 5) select 0)) > 0) then
{
	for "_i" from 0 to (count ((_gear_array select 5) select 0) - 1) do
	{
		(uniformContainer player) addMagazineCargo [(((_gear_array select 5) select 0) select _i),(((_gear_array select 5) select 1) select _i)];
	};
};
if ((count ((_gear_array select 6) select 0)) > 0) then
{
	for "_i" from 0 to (count ((_gear_array select 6) select 0) - 1) do
	{
		(uniformContainer player) addItemCargo [(((_gear_array select 6) select 0) select _i),(((_gear_array select 6) select 1) select _i)];
	};
};
if ((count (_gear_array select 7)) > 0) then
{
	for "_i" from 0 to (count ((_gear_array select 7) select 0) - 1) do
	{
		(vestContainer player) addMagazineCargo [(((_gear_array select 7) select 0) select _i),(((_gear_array select 7) select 1) select _i)];
	};
};
if ((count ((_gear_array select 8) select 0)) > 0) then
{
	for "_i" from 0 to (count ((_gear_array select 8) select 0) - 1) do
	{
		(vestContainer player) addItemCargo [(((_gear_array select 8) select 0) select _i),(((_gear_array select 8) select 1) select _i)];
	};
};
if ((count (_gear_array select 9)) > 0) then
{
	for "_i" from 0 to (count ((_gear_array select 9) select 0) - 1) do
	{
		(backpackContainer player) addMagazineCargo [(((_gear_array select 9) select 0) select _i),(((_gear_array select 9) select 1) select _i)];
	};
};
if ((count ((_gear_array select 10) select 0)) > 0) then
{
	for "_i" from 0 to (count ((_gear_array select 10) select 0) - 1) do
	{
		(backpackContainer player) addItemCargo [(((_gear_array select 10) select 0) select _i),(((_gear_array select 10) select 1) select _i)];
	};
};		