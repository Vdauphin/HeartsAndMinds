
/* ----------------------------------------------------------------------------
Function: btc_fnc_cache_create

Description:
    Create a cache at btc_cache_pos position.

Parameters:
    _cache_pos - Position of the cache. [Array]
    _p_chem - Create a chemical cache. [Boolean]
    _probilityNotChemical - Probability to not create a chemical cache. [Number]

Returns:

Examples:
    (begin example)
        [] spawn {
            for [{_i=1},{_i<=360},{_i=_i+10}] do {
                [player getpos [10, _i], true, 0.7] call btc_fnc_cache_create;
            };
        };
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_cache_pos", btc_cache_pos, [[]]],
    ["_p_chem", btc_p_chem, [true]],
    ["_probilityNotChemical", 0.7, [0]]
];

private _isChem = false;
if (_p_chem) then {
    _isChem = random 1 > _probilityNotChemical;
};
private _cacheType = selectRandom (btc_cache_type select 0);
btc_cache_obj = _cacheType createVehicle _cache_pos;
btc_cache_obj setPosATL _cache_pos;
btc_cache_obj setDir (random 360);

clearWeaponCargoGlobal btc_cache_obj;
clearItemCargoGlobal btc_cache_obj;
clearMagazineCargoGlobal btc_cache_obj;
clearBackpackCargoGlobal btc_cache_obj;

[btc_cache_obj, "HandleDamage", btc_fnc_cache_hd] remoteExecCall ["CBA_fnc_addBISEventHandler", 0, true];

if (_isChem) then {
    btc_chem_contaminated pushBack btc_cache_obj;
    publicVariable "btc_chem_contaminated";
    private _holder = createSimpleObject [selectRandom (btc_cache_type select 1), _cache_pos];
    [btc_cache_obj, _holder, "TOP", -0.47] call btc_fnc_cache_create_attachto;
} else {
    private _pos_type_array = ["TOP", "FRONT", "CORNER_L", "CORNER_R"];

    for "_i" from 1 to (1 + round random 3) do {
        private _holder = createVehicle ["groundWeaponHolder", _cache_pos, [], 0, "can_collide"];
        _holder addWeaponCargoGlobal [selectRandom btc_cache_weapons_type, 1];
        _holder setVariable ["no_cache", true];

        private _pos_type = selectRandom _pos_type_array;
        _pos_type_array = _pos_type_array - [_pos_type];
        [btc_cache_obj, _holder, _pos_type] call btc_fnc_cache_create_attachto;
    };
};

if (btc_debug_log) then {
    [format ["ID %1 POS %2", btc_cache_n, _cache_pos], __FILE__, [false]] call btc_fnc_debug_message;
};

if (btc_debug) then {
    [format ["in %1", _cache_pos], __FILE__, [btc_debug, false]] call btc_fnc_debug_message;
    //Marker
    private _marker = createMarker [format ["%1", _cache_pos], _cache_pos];
    _marker setMarkerType "mil_unknown";
    _marker setMarkerText format ["Cache %1", btc_cache_n];
    _marker setMarkerSize [0.8, 0.8];
};
