
/* ----------------------------------------------------------------------------
Function: btc_hideout_fnc_create_composition

Description:
    Create a random hideout composition.

Parameters:
    _pos - Position. [Array]

Returns:
    _result - The flag. [Object]

Examples:
    (begin example)
        _result = [getPos (allPlayers#0)] call btc_hideout_fnc_create_composition;
    (end)

Author:
    Giallustio & Proxno

---------------------------------------------------------------------------- */

params [
    ["_pos", [0, 0, 0], [[]]]
];

private _type_bigbox = selectRandom ["Land_vn_pavn_weapons_stack1", "Land_vn_pavn_weapons_stack2", "Land_vn_pavn_weapons_stack3"];
private _power = [];

private _composition_hideout = [
    ["vn_flag_vc_dmg",0,[0,0,0]],
    ["vn_campfire_burning_f",270,[-0.5,0.5,0]],
    ["Land_vn_stand_meat_ep1",230,[-0.5,0.5,0]],
    ["Land_vn_c_prop_pot_fire_01",90,[-1,0.5,0]],
    ["Land_vn_o_shelter_06",90,[-4,-0.5,0]],
    ["Land_vn_o_shelter_06",130,[-3,3,0]],
    ["Land_vn_o_shelter_06",0,[0.5,4,0]],
    ["Land_vn_bedrag_01",0,[-4,-0.5,0]],
    ["Land_vn_bedrag_01",45,[-3,3,0]],
    ["Land_vn_bedrag_01",270,[0.5,4,0]],
    ["Land_vn_o_wallfoliage_01",180,[-5.5,0.5,0]],
    ["Land_vn_o_wallfoliage_01",220,[-4,4,0]],
    ["Land_vn_o_wallfoliage_01",275,[-0.5,5.5,0]],
    ["Land_vn_o_wallfoliage_01",90,[1,-7.5,0]],
    ["Land_vn_o_tower_02",315,[-4.5,-5.5,0]],
    ["Land_vn_o_shelter_02",90,[4,-1,0]],
    ["Land_vn_o_prop_cong_cage_01",90,[4,-1,0]],
    ["Land_vn_o_shelter_01",0,[1,-5.5,0]],
    ["vn_o_ammobox_wpn_08",0,[2,-5.5,0]],
    ["Land_vn_pavn_weapons_stack1",225,[0.5,-5.5,0]],
    ["vn_o_ammobox_full_09",0,[1.5,-6.5,0]],
    ["vn_o_ammobox_full_09",0,[2,-6.5,0]],
    ["vn_o_ammobox_full_09",0,[2.5,-6.5,0]],
    ["vn_o_snipertree_02",275,[6,4,0]],
    ["ModuleHideTerrainObjects_F",145,[0.5,-1,0]]
];

private _composition_hideout pushBack [selectRandom (btc_type_camonet - ["Land_vn_camonet_nato","Land_vn_camonetb_nato"]),0,[-0.84668,-2.16113,0]];

private _composition = [_pos, random 360, _composition_hideout] call btc_fnc_create_composition;

_composition select ((_composition apply {typeOf _x}) find _type_bigbox);
