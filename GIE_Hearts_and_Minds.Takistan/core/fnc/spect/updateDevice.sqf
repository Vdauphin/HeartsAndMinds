
/* ----------------------------------------------------------------------------
Function: btc_spect_fnc_updateDevice

Description:
    Refresh spectrum device depend on UAV and EMP distance and angle.

Parameters:
    _player - Player. [Object]
    _weapon - Weapon use by player. [Object]

Returns:

Examples:
    (begin example)
        [player, currentWeapon player] call btc_spect_fnc_updateDevice;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_player", objNull, [objNull]],
    ["_weapon", "", [""]]
];

if (btc_spect_updateOn > -1) exitWith {};

private _accessorie = (_player weaponAccessories _weapon) select 0;

if !(_accessorie isKindOf ["muzzle_antenna_base_01_F", configFile >> "CfgWeapons"]) exitWith {};

private _freq = [[385, 505], [77, 90]] select (_accessorie isEqualTo "muzzle_antenna_01_f");
_freq params ["_fMin", "_fMax"];

private _EM = [
    ["#EM_FMin", _fMin],
    ["#EM_FMax", _fMax],
    ["#EM_SMin", 0],
    ["#EM_SMax", 100],
    ["#EM_Values", []],
    ["#EM_Transmit", false],
    ["#EM_Progress", 0]
];

if (
    _fMin > missionNamespace getVariable ["#EM_SelMin", 0] ||
    _fMax < missionNamespace getVariable ["#EM_SelMin", 0]
) then {
    _EM append [
        ["#EM_SelMin", _fMin],
        ["#EM_SelMax", (_fMax - _fMin) / 16 + _fMin]
    ];
};
{missionNamespace setVariable _x} forEach _EM;

btc_spect_updateOn = [{
    params ["_arguments", "_idPFH"];
    _arguments params [
        ["_accessorie", "", [""]],
        ["_player", player, [objNull]]
    ];

    if (((_player weaponAccessories currentWeapon _player) select 0) isNotEqualTo _accessorie) exitWith {
        [] call btc_spect_fnc_disableDevice;
        [_player, currentWeapon _player] call btc_spect_fnc_updateDevice;
    };

    private _signalFrequencies = [_player, allUnitsUAV] call btc_spect_fnc_frequencies;
    _signalFrequencies append ([_player, btc_spect_emp select {damage _x < 1}, [78, 89]] call btc_spect_fnc_frequencies);
    missionNamespace setVariable ["#EM_Values", _signalFrequencies];
}, 1, [_accessorie]] call CBA_fnc_addPerFrameHandler;
