
/* ----------------------------------------------------------------------------
Function: btc_db_fnc_loadCargo

Description:
    Load ACE cargo and inventory of a vehicle/container.

Parameters:
    _obj - Vehicle or container. [Object]
    _cargo - Object to load in ACE cargo. [Array]
    _inventory - Weapon and item to load in inventory. [Array]

Returns:

Examples:
    (begin example)
        _result = [] call btc_db_fnc_loadCargo;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

[{
    params ["_obj", "_cargo", "_inventory"];

    //handle cargo
    {
        _x params ["_type", "", "_inventory",
            ["_isContaminated", false, [false]],
            ["_dogtagDataTaken", [], [[]]],
            ["_turretMagazines", [], [[]]],
            ["_customName", "", [""]],
            ["_properties", [], [[]]]
        ];

        private _l = createVehicle [_type, getPosATL _obj, [], 0, "CAN_COLLIDE"];
        [_l] call btc_log_fnc_init;
        private _isloaded = [_l, _obj, false] call ace_cargo_fnc_loadItem;
        if (btc_debug_log) then {
            [format ["Object loaded: %1 in veh/container %2 IsLoaded: %3", _l, _obj, _isloaded], __FILE__, [false]] call btc_debug_fnc_message;
        };

        [_l, _inventory] call btc_log_fnc_inventorySet;

        if (_isContaminated) then {
            btc_chem_contaminated pushBack _l;
            publicVariable "btc_chem_contaminated";
        };

        [_l, _dogtagDataTaken] call btc_body_fnc_dogtagSet;

        if (_turretMagazines isNotEqualTo []) then {
            [_l, _turretMagazines] call btc_db_fnc_setTurretMagazines;
        };

        if (_customName isNotEqualTo "") then {
            _l setVariable ["ace_cargo_customName", _customName, true];
        };

        if (unitIsUAV _l) then {
            createVehicleCrew _l;
        };

        if (_properties isNotEqualTo []) then {
            ([_l] + _properties) call btc_veh_fnc_propertiesSet;
        };
    } forEach _cargo;

    //set inventory content for weapons, magazines and items
    [_obj, _inventory] call btc_log_fnc_inventorySet;
}, _this] call CBA_fnc_execNextFrame;
