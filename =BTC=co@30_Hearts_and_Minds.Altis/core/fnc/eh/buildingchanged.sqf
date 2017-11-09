params ["_from", "_to", "_isRuin"];
private _classname = toUpper typeOf _from;
private _malus = [btc_rep_malus_building_damaged, btc_rep_malus_building_destroyed] select _isRuin;
private _skipCategories = false;

// Accept only static, terrain buildings, discard any dynamically created ones but keep already damaged buildings.
if ((getObjectType _from != 1) && !(_from in btc_buildings_changed)) exitWith {};

btc_buildings_changed pushBack _to;

{
	if (_classname find (toUpper (_x select 0)) != -1) exitWith {
		_malus = _malus * (_x select 1);
		_skipCategories = true;
	};
} forEach btc_buildings_multipliers;

if (!_skipCategories) then {
	{
		if (_classname find (toUpper (_x select 0)) != -1) then {
			_malus = _malus * (_x select 1);
		};
	} forEach btc_buildings_categories_multipliers;
};

if (btc_debug) then {
	systemChat format [ "BuildingChanged: %1 to %2. Malus: %3",
	typeOf _from, typeOf _to, _malus ];
};

_malus call btc_fnc_rep_change;