/* ----------------------------------------------------------------------------
Function: getConfigInfo

Description:

Contains functions for getting relevant items from the config file, based on a list of units within the given factions.

Parameters:
0: Gear type - what kind of gear to search for <STRING>
1: Factions - a list of factions to find the gear for <ARRAY>

Returns: An array of items / weapons / identities belonging to the given factions.

Examples:

["units",[(faction _groupLead)]] call INCON_ucr_fnc_getConfigInfo;
["headgear",["OPF_F"]] call INCON_ucr_fnc_getConfigInfo;

Author: Spyderblack723, modified by Incontinentia
---------------------------------------------------------------------------- */

private ["_units","_cfgVehicles","_result","_unit","_linkedItems","_pack","_uniform","_headgearList"];

params ["_gearType","_factions"];

_result = [];
_units = [];
_cfgVehicles = configFile >> "CfgVehicles";

if (isNil "INC_cfgManEntries") then {

    private _cfgMen = [];

    for "_i" from 0 to (count _cfgVehicles - 1) do {
        _entry = _cfgVehicles select _i;

        if (isclass _entry) then {
            if (
                (getNumber(_entry >> "scope") >= 2) &&
                {configname _entry isKindOf "Man"}
            ) then {
                _cfgMen pushback _entry;
            };
        };
    };

    missionNamespace setVariable ["INC_cfgManEntries", _cfgMen, true];
};

{
    if (
        (getText(_x >> "faction") in _factions)
    ) then {
        _units pushback _x;
    };
} forEach INC_cfgManEntries;

switch (_gearType) do {

    case "backpacks": {
        {
            _pack =  getText (_x >> "backpack");;
            _result pushbackunique _pack;
        } forEach _units;
    };

    case "headgear": {
        {
            _unit = _x;
            _linkedItems = getArray (_unit >> "linkedItems");

            {
                _item = _x;
                _configPath = configFile >> "CfgWeapons" >> _item;
                    if (isClass _configPath) then {
                        _itemInfo = getNumber (_configPath >> "ItemInfo" >> "Type");

                        switch (str _itemInfo) do {
                            case "605": {
                                _result pushbackunique _item;
                            };
                        };
                    };
            } forEach _linkedItems;
        } forEach _units;
    };

    case "possibleHeadgear": {
        {
            _unit = _x;
            _headgearList = (getArray (_unit >> "headgearList")) select {typeName _x == "STRING"};

            {
                _item = _x;
                _configPath = configFile >> "CfgWeapons" >> _item;
                    if (isClass _configPath) then {
                        _itemInfo = getNumber (_configPath >> "ItemInfo" >> "Type");

                        switch (str _itemInfo) do {
                            case "605": {
                                _result pushbackunique _item;
                            };
                        };
                    };
            } forEach _headgearList;
        } forEach _units;
    };

    case "vests": {
        {
            _unit = _x;
            _linkedItems = getArray (_unit >> "linkedItems");
            {
                _item = _x;
                _configPath = configFile >> "CfgWeapons" >> _item;
                    if (isClass _configPath) then {
                        _itemInfo = getNumber (_configPath >> "ItemInfo" >> "Type");

                        switch (str _itemInfo) do {
                            case "701": {
                                _result pushbackunique _item;
                            };
                        };
                    };
            } forEach _linkedItems;
        } forEach _units;
    };

    case "uniforms": {
        {
            _uniform = getText (_x >> "uniformClass");
            _result pushbackunique _uniform;
        } forEach _units;
    };

    case "units": {
        {
            _unit = configName _x;
            if ((_unit isKindOf "Man") && {(((str _x) find "Pilot") == -1)} && {(((str _x) find "pilot") == -1)}) then {
                _result pushbackunique _unit
            };
        } forEach _units;
    };

    case "weapons": {
        {
            _unit = _x;
            _weaponArray = getArray (_unit >> "weapons");
            {
                _item = _x;
                _configPath = configFile >> "CfgWeapons" >> _item;
                    if (isClass _configPath) then {
                        _result pushBackUnique ([_item] call BIS_fnc_baseWeapon);
                    };
            } forEach _weaponArray;
        } forEach _units;
    };

    case "possibleIdentities": {
      _result = [];
      {
          _unit = _x;
          _IDarray = getArray (_unit >> "identityTypes");
          {
					  _result pushbackunique _x;
          } forEach _IDarray;
      } forEach _units;
    };
};

_result
