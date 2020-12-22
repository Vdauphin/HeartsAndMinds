
/* ----------------------------------------------------------------------------
Function: btc_fnc_mil_createVehicle

Description:
    Create a vehicle with desired crews.

Parameters:
    _group - Group to store crews. [Group]
    _pos - Position of creation. [Array]
    _veh_type - Vehicle type. [String]
    _dir - Direction of spawn. [Number]
    _type_units - Array of available unit type for cargo. [Array]
    _type_divers - Units used for submarine. [Array]
    _type_crewmen - Array of available crews type. [Array]

Returns:
    _veh - Vehicle created. [Object]

Examples:
    (begin example)
        _veh = [createGroup [btc_enemy_side, true], getPosATL player] call btc_fnc_mil_createVehicle;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_group", grpNull, [grpNull]],
    ["_pos", [0, 0, 0], [[]]],
    ["_veh_type", selectRandom btc_type_motorized, [""]],
    ["_dir", 0, [0]],
    ["_type_units", btc_type_units, [[]]],
    ["_type_divers", btc_type_divers, [[]]],
    ["_type_crewmen", btc_type_crewmen, [[]]],
    ["_p_chem", btc_p_chem, [false]]
];
if (
    _veh_type in btc_etat_islamic ||
    _veh_type isKindOf "StaticWeapon"
) then {
    _type_units = ["rhs_vdv_aa", "rhs_vdv_at", "rhs_vdv_arifleman", "rhs_vdv_efreitor", "rhs_vdv_machinegunner", "rhs_vdv_grenadier", "rhs_vdv_sergeant", "rhs_vdv_LAT"];
    _type_crewmen = "LOP_ISTS_OPF_Infantry_Rifleman_6";
};

private _needdiver = getText (configFile >> "CfgVehicles" >> _veh_type >> "simulation") isEqualTo "submarinex";
if (_veh_type isKindOf "Van_02_vehicle_base_F") then {
    _veh_type = "I_C_Van_02_transport_F"; // https://feedback.bistudio.com/T129141
};

private _veh = createVehicle [_veh_type, _pos, [], 0, "FLY"];
if !(_veh_type isKindOf "Plane") then {
    _veh setDir _dir;
    _veh setVectorUp surfaceNormal position _veh;
};
if (_p_chem) then {
    _veh addEventHandler ["GetIn", {
        [_this select 0, _this select 2] call btc_fnc_chem_propagate;
        _this
    }];
};

private _units = [_veh, _group, false, "", [_type_crewmen, _type_divers select 0] select _needdiver] call BIS_fnc_spawnCrew;
_group selectLeader (driver _veh);
_units joinSilent _group;

private _cargo = _veh emptyPositions "cargo";
[_group, _pos, _cargo, _needdiver, _type_units, _type_divers] call btc_fnc_mil_createUnits;

_veh
