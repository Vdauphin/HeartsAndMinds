
private _faction_list = if ((_this select 0) isEqualTo "CIV") then {[3]} else {[0,1,2]};

//Get all vehicles/Units
private _allvehicles = ("(configName _x) isKindOf 'AllVehicles'" configClasses (configFile >> "CfgVehicles")) apply {configName _x};
private _allfaction = [];
private _allside = [];
private _allauthor = [];
private _alldlc = [];

// Get factions and store it if new faction are found
{
	// Get faction of the vehicle and store it if is a new faction
	private _index = _allfaction pushBackUnique toUpper getText(configfile >> "CfgVehicles" >> _x >> "faction");

	//If new get the side and author name and dlc name
	if (_index > -1) then 	{
		_allside pushBack getNumber(configfile >> "CfgVehicles" >> _x >> "side");
		_allauthor pushBack getText(configfile >> "CfgVehicles" >> _x >> "author");
		private _dlc = getText(configfile >> "CfgVehicles" >> _x >> "dlc");
		if (_dlc isEqualTo "") then {
			if ((_allauthor select _index) isEqualTo "Bohemia Interactive") then {
				//If is BI check if it is really BI, some mod don't change the author
				private _mod_folder = getText(configfile >> "CfgFactionClasses" >> _allfaction select _index >> "icon") select [if ((getText(configfile >> "CfgFactionClasses" >> _allfaction select _index >> "icon") select [0,1]) isEqualTo "\") then {1} else {0}];
				private _mod = _mod_folder select [0, _mod_folder find "\"];
				if !(_mod isEqualTo "a3") then {_dlc = (_allfaction select _index) select [0, (_allfaction select _index) find "_"];};
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
	_all pushBack [ _alldlc select _foreachindex, _x, _allside select _foreachindex, _allauthor select _foreachindex];
} forEach _allfaction;

//Select faction depending on side CIV or Enemy
_all = _all select {(_x select 2) in _faction_list && (getNumber(configfile >> "CfgFactionClasses" >> _x select 0 >> "side") in [0,1,2,3])};
_all sort true;

//Return the text which be use in param.hpp
private _texts = _all apply {Format ["%3 %4: %1 (Side: %2)", getText(configfile >> "CfgFactionClasses" >> _x select 1 >> "displayName"), [East,West,Independent,Civilian] select (_x select 2), _x select 0, _x select 3]};

_allauthor = [];
{_allauthor pushBackUnique _x} forEach (_all apply {_x select 0});
private _values = [];
for "_i" from 0 to (count _all) - 1 do {
	_values pushBack _i;
};
_texts = _values apply {Format ["%1 -%2",_x,_texts select _x]};

[_allauthor,_texts,_all apply {_x select 1},_values]