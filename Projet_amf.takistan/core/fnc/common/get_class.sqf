
/* ----------------------------------------------------------------------------
Function: btc_fnc_get_class

Description:
    Get enemy or civilian factions.

Parameters:
    _get_civ_faction - Search for factions of civilian or enemies. [String]

Returns:
    _array_of_factions - Array with authos names, text entry for mission parameters, corresponding number for each faction, faction name array. [Array]

Examples:
    (begin example)
        copyToClipboard str (["CIV"] call btc_fnc_get_class);
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_get_civ_faction", "EN", [""]]
];

private _faction_list = if (_get_civ_faction isEqualTo "CIV") then {[3]} else {[0, 1, 2]};

//Get all vehicles/Units
private _cfgVehicles = configFile >> "CfgVehicles";
private _allvehicles = ("(configName _x) isKindOf 'AllVehicles'" configClasses (_cfgVehicles)) apply {configName _x};
_allvehicles = _allvehicles select {getNumber (_cfgVehicles >> _x >> "scope") isEqualTo 2};
private _cfgFactionClasses = configFile >> "CfgFactionClasses";
private _allfaction = [];
private _allside = [];
private _allauthor = [];
private _alldlc = [];

// Get factions and store it if new faction are found
{
    // Get faction of the vehicle and store it if is a new faction
    private _index = _allfaction pushBackUnique toUpper getText(_cfgVehicles >> _x >> "faction");

    //If new get the side and author name and dlc name
    if (_index > -1) then {
        _allside pushBack getNumber(_cfgVehicles >> _x >> "side");
        _allauthor pushBack getText(_cfgVehicles >> _x >> "author");
        private _dlc = getText(_cfgVehicles >> _x >> "dlc");
        if (_dlc isEqualTo "") then {
            if ((_allauthor select _index) isEqualTo "Bohemia Interactive") then {
                //If is BI check if it is really BI, some mod don't change the author
                private _mod_folder = getText(_cfgFactionClasses >> _allfaction select _index >> "icon") select [if ((getText(_cfgFactionClasses >> _allfaction select _index >> "icon") select [0, 1]) isEqualTo "\") then {1} else {0}];
                private _mod = _mod_folder select [0, _mod_folder find "\"];
                if !(_mod isEqualTo "a3") then {
                    _dlc = (_allfaction select _index) select [0, (_allfaction select _index) find "_"];
                };
            } else {
                _dlc = (_allfaction select _index) select [0, (_allfaction select _index) find "_"];
            };
        };
        _alldlc pushBack _dlc;
    };
} forEach _allvehicles;

//Create an array of all information get
private _all = [];
{
    _all pushBack [_alldlc select _foreachindex, _x, _allside select _foreachindex, _allauthor select _foreachindex];
} forEach _allfaction;

//Select faction depending on side CIV or Enemy
_all = _all select {(_x select 2) in _faction_list && (getNumber(_cfgFactionClasses >> _x select 0 >> "side") in [0, 1, 2, 3])};
_all sort true;

//Return the text which be use in param.hpp
private _texts = _all apply {format ["%3 %4: %1 (Side: %2)", getText(_cfgFactionClasses >> _x select 1 >> "displayName"), [East, West, Independent, Civilian] select (_x select 2), _x select 0, _x select 3]};

_allauthor = _all apply {_x select 0};
private _values = [];
for "_i" from 0 to (count _all) - 1 do {
    _values pushBack _i;
};
_texts = _values apply {format ["%1 -%2", _x, _texts select _x]};

[_allauthor arrayIntersect _allauthor, _texts, _all apply {_x select 1}, _values]
