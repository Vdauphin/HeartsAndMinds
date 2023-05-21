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

_player setUnitLoadout [[],[],[],["U_B_BDU_2acr",[["ACE_splint",1],["ACE_epinephrine",1],["ACE_morphine",2],["ACE_packingBandage",4],["ACE_elasticBandage",4],["ACE_EarPlugs",1],["ACE_tourniquet",2],["ACE_Flashlight_MX991",1],["ACE_MapTools",1],["ACE_CableTie",1],["ACE_Chemlight_IR",2,1],["ACE_Chemlight_HiRed",2,1],["ACE_Chemlight_HiGreen",2,1]]],[],[],"cap_patrel_dcu","G_Shades_tactical",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]];