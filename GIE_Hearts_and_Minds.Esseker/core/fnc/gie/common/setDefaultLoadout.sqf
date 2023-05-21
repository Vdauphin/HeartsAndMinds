/* ----------------------------------------------------------------------------
Function: gie_loadout_fnc_setDefaultLoadout

Description:
    Set default loadout to player

Parameters:
	_player - Player to add default loadout. [Object]

Returns:

Examples:
    (begin example)
        [player] call gie_loadout_fnc_setDefaultLoadout;
    (end)

Author:
    Gavin "Morbakos" Sertix

---------------------------------------------------------------------------- */

params [
    ["_player", objNull, [objNull]]
];

_player setUnitLoadout [[],[],[],["amf_uniform_03_CE_2",[]],[],[],"AMF_BERET_INFANTERIE","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]];