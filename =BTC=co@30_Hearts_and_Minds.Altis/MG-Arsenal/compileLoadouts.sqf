params ["_unitTrait"];
private ["_availableItems", "_availableBackpacks", "_availableWeapons", "_availableMagazines", "_arsenalUniforms", "_arsenalItems", "_arsenalBackpacks", "_arsenalWeapons"];

Call Compile Format ["_arsenalUniforms = arsenal_%1_Uniforms", _unitTrait];
Call Compile Format ["_arsenalItems = arsenal_%1_Items", _unitTrait];
Call Compile Format ["_arsenalBackpacks = arsenal_%1_Backpacks", _unitTrait];
Call Compile Format ["_arsenalWeapons = arsenal_%1_Weapons", _unitTrait];

_availableItems = [(getItemCargo _arsenalUniforms select 0) + (getItemCargo _arsenalItems select 0)] select 0;
_availableBackpacks = [getBackpackCargo _arsenalBackpacks select 0] select 0;
_availableWeapons = [getWeaponCargo _arsenalWeapons select 0] select 0;
_availableMagazines = [];
{       // Get weapon bullets
        _currentWeaponMagazine = getArray(configFile >> "CfgWeapons" >> _x >> "magazines");
        {
                _availableMagazines pushBackUnique _x;
        } forEach _currentWeaponMagazine;
} forEach _availableWeapons;
{       // Don't forget the explosives
        _availableMagazines pushBackUnique _x;
} forEach ((getMagazineCargo _arsenalWeapons) select 0);

_return = [_availableItems, _availableBackpacks, _availableWeapons, _availableMagazines];
_return
