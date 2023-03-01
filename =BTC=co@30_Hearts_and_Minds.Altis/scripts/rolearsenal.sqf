roleArsenal = {
	params ["_box", "_player"];


	Private _UnitRole = roleDescription _player;

	//Clear the inventory
	clearMagazineCargoGlobal _box;
	clearItemCargoGlobal _box;
	clearBackpackCargoGlobal _box;
	clearWeaponCargoGlobal _box;

	_Role = [];

	// Command
	if (_UnitRole == "Company Commander @ CROSSROADS") then
	{_Role = "CO"};

    // GROUND
		//SL
			if ((_UnitRole == "Alpha Squad Leader@Alpha (Infantry)")
			or (_UnitRole == "Bravo Squad Leader@Bravo (Infantry)")
			or (_UnitRole == "Charlie Squad Leader@Charlie (Infantry)")) then
			{_Role = "SL"};
		//MEDIC
			if ((_UnitRole == "Alpha Medic")
			or (_UnitRole == "Bravo Medic")
			or (_UnitRole == "Charlie Medic")) then
			{_Role = "MEDIC"};
		//FTL
			if ((_UnitRole == "Alpha FTL")
			or (_UnitRole == "Bravo FTL")
			or (_UnitRole == "Charlie FTL")) then
			{_Role = "FTL"};
		//AUTORIFLEMAN
			if ((_UnitRole == "Alpha AutoRifleman")
			or (_UnitRole == "Bravo AutoRifleman")
			or (_UnitRole == "Charlie AutoRifleman")) then
			{_Role = "AUTORIFLEMAN"};
		//AT
			if ((_UnitRole == "Alpha AT")
			or (_UnitRole == "Bravo AT")
			or (_UnitRole == "Charlie AT")) then
			{_Role = "AT"};
    //GRENADIER
			if ((_UnitRole == "Alpha Grenadier")
			or (_UnitRole == "Bravo Grenadier")
			or (_UnitRole == "Charlie Grenadier")) then
			{_Role = "GRENADIER"};
    //RIFLEMAN
			if ((_UnitRole == "Alpha Rifleman")
			or (_UnitRole == "Bravo Rifleman")
			or (_UnitRole == "Charlie Rifleman")) then
			{_Role = "RIFLEMAN"};

  //Armor
    if ((_UnitRole == "Warpig Commander@Armor 1")
	or (_UnitRole == "Warpig Commander@Armor 2")
    or (_UnitRole == "Warpig Driver")
    or (_UnitRole == "Warpig Gunner")) then
    {_Role = "WARPIG"};  
  //O.G.R.E
    if ((_UnitRole == "O.G.R.E Commander@O.G.R.E (Logistics)")
    or (_UnitRole == "O.G.R.E Engineer")) then
    {_Role = "OGRE"};
  //STALKER
    if ((_UnitRole == "STALKER 1 Pilot@Joint Air Command 1")
    or (_UnitRole == "STALKER 1 Crew")
    or (_UnitRole == "STALKER 2 Pilot@Joint Air Command 2")
    or (_UnitRole == "STALKER 2 Crew")) then
    {_Role = "STALKER"};

	//Empty array of gear to add to the arsenal per player.
	Private _GearToAdd = [];

	//Define the gear for each Role
	Private _DefaultGear = [
//PRIMARY
"rhs_weap_m4","rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red", "ACE_30Rnd_556x45_Stanag_M995_AP_mag","rhsusf_acc_eotech_552","rhsusf_acc_compm4","rhsusf_acc_acog_rmr","rhsusf_acc_su230","rhsusf_acc_su230_mrds","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15_bk","rhsusf_acc_anpeq15a","ace_acc_pointer_green","acc_pointer_ir","rhsusf_acc_wmx_bk","rhsusf_acc_nt4_black","rhsusf_acc_rotex5_grey","rhsusf_acc_sf3p556","rhsusf_acc_sfmb556","ace_muzzle_mzls_l","rhsusf_acc_grip2","rhsusf_acc_grip1","rhsusf_acc_harris_bipod","rhsusf_acc_kac_grip","rhsusf_acc_rvg_blk","rhsusf_acc_tacsac_blk","rhsusf_acc_tdstubby_blk","rhsusf_acc_grip3",
"rhs_weap_m4_carryhandle","rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red", "ACE_30Rnd_556x45_Stanag_M995_AP_mag","rhsusf_acc_eotech_552","rhsusf_acc_compm4","rhsusf_acc_acog_rmr","rhsusf_acc_su230","rhsusf_acc_su230_mrds","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15_bk","rhsusf_acc_anpeq15a","ace_acc_pointer_green","acc_pointer_ir","rhsusf_acc_wmx_bk","rhsusf_acc_nt4_black","rhsusf_acc_rotex5_grey","rhsusf_acc_sf3p556","rhsusf_acc_sfmb556","ace_muzzle_mzls_l","rhsusf_acc_grip2","rhsusf_acc_grip1","rhsusf_acc_harris_bipod","rhsusf_acc_kac_grip","rhsusf_acc_rvg_blk","rhsusf_acc_tacsac_blk","rhsusf_acc_tdstubby_blk","rhsusf_acc_grip3",
"rhs_weap_m4_carryhandle_mstock","rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red", "ACE_30Rnd_556x45_Stanag_M995_AP_mag","rhsusf_acc_eotech_552","rhsusf_acc_compm4","rhsusf_acc_acog_rmr","rhsusf_acc_su230","rhsusf_acc_su230_mrds","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15_bk","rhsusf_acc_anpeq15a","ace_acc_pointer_green","acc_pointer_ir","rhsusf_acc_wmx_bk","rhsusf_acc_nt4_black","rhsusf_acc_rotex5_grey","rhsusf_acc_sf3p556","rhsusf_acc_sfmb556","ace_muzzle_mzls_l","rhsusf_acc_grip2","rhsusf_acc_grip1","rhsusf_acc_harris_bipod","rhsusf_acc_kac_grip","rhsusf_acc_rvg_blk","rhsusf_acc_tacsac_blk","rhsusf_acc_tdstubby_blk","rhsusf_acc_grip3",
"rhs_weap_m4_mstock","rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red", "ACE_30Rnd_556x45_Stanag_M995_AP_mag","rhsusf_acc_eotech_552","rhsusf_acc_compm4","rhsusf_acc_acog_rmr","rhsusf_acc_su230","rhsusf_acc_su230_mrds","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15_bk","rhsusf_acc_anpeq15a","ace_acc_pointer_green","acc_pointer_ir","rhsusf_acc_wmx_bk","rhsusf_acc_nt4_black","rhsusf_acc_rotex5_grey","rhsusf_acc_sf3p556","rhsusf_acc_sfmb556","ace_muzzle_mzls_l","rhsusf_acc_grip2","rhsusf_acc_grip1","rhsusf_acc_harris_bipod","rhsusf_acc_kac_grip","rhsusf_acc_rvg_blk","rhsusf_acc_tacsac_blk","rhsusf_acc_tdstubby_blk","rhsusf_acc_grip3",
"rhs_weap_m4a1_carryhandle","rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red", "ACE_30Rnd_556x45_Stanag_M995_AP_mag","rhsusf_acc_eotech_552","rhsusf_acc_compm4","rhsusf_acc_acog_rmr","rhsusf_acc_su230","rhsusf_acc_su230_mrds","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15_bk","rhsusf_acc_anpeq15a","ace_acc_pointer_green","acc_pointer_ir","rhsusf_acc_wmx_bk","rhsusf_acc_nt4_black","rhsusf_acc_rotex5_grey","rhsusf_acc_sf3p556","rhsusf_acc_sfmb556","ace_muzzle_mzls_l","rhsusf_acc_grip2","rhsusf_acc_grip1","rhsusf_acc_harris_bipod","rhsusf_acc_kac_grip","rhsusf_acc_rvg_blk","rhsusf_acc_tacsac_blk","rhsusf_acc_tdstubby_blk","rhsusf_acc_grip3",
"rhs_weap_m4a1_carryhandle_mstock","rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red", "ACE_30Rnd_556x45_Stanag_M995_AP_mag","rhsusf_acc_eotech_552","rhsusf_acc_compm4","rhsusf_acc_acog_rmr","rhsusf_acc_su230","rhsusf_acc_su230_mrds","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15_bk","rhsusf_acc_anpeq15a","ace_acc_pointer_green","acc_pointer_ir","rhsusf_acc_wmx_bk","rhsusf_acc_nt4_black","rhsusf_acc_rotex5_grey","rhsusf_acc_sf3p556","rhsusf_acc_sfmb556","ace_muzzle_mzls_l","rhsusf_acc_grip2","rhsusf_acc_grip1","rhsusf_acc_harris_bipod","rhsusf_acc_kac_grip","rhsusf_acc_rvg_blk","rhsusf_acc_tacsac_blk","rhsusf_acc_tdstubby_blk","rhsusf_acc_grip3",
"rhs_weap_m4a1_blockII","rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red", "ACE_30Rnd_556x45_Stanag_M995_AP_mag","rhsusf_acc_eotech_552","rhsusf_acc_compm4","rhsusf_acc_acog_rmr","rhsusf_acc_su230","rhsusf_acc_su230_mrds","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15_bk","rhsusf_acc_anpeq15a","ace_acc_pointer_green","acc_pointer_ir","rhsusf_acc_wmx_bk","rhsusf_acc_nt4_black","rhsusf_acc_rotex5_grey","rhsusf_acc_sf3p556","rhsusf_acc_sfmb556","ace_muzzle_mzls_l","rhsusf_acc_grip2","rhsusf_acc_grip1","rhsusf_acc_harris_bipod","rhsusf_acc_kac_grip","rhsusf_acc_rvg_blk","rhsusf_acc_tacsac_blk","rhsusf_acc_tdstubby_blk","rhsusf_acc_grip3",
"rhs_weap_m4a1_blockII_bk","rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red", "ACE_30Rnd_556x45_Stanag_M995_AP_mag","rhsusf_acc_eotech_552","rhsusf_acc_compm4","rhsusf_acc_acog_rmr","rhsusf_acc_su230","rhsusf_acc_su230_mrds","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15_bk","rhsusf_acc_anpeq15a","ace_acc_pointer_green","acc_pointer_ir","rhsusf_acc_wmx_bk","rhsusf_acc_nt4_black","rhsusf_acc_rotex5_grey","rhsusf_acc_sf3p556","rhsusf_acc_sfmb556","ace_muzzle_mzls_l","rhsusf_acc_grip2","rhsusf_acc_grip1","rhsusf_acc_harris_bipod","rhsusf_acc_kac_grip","rhsusf_acc_rvg_blk","rhsusf_acc_tacsac_blk","rhsusf_acc_tdstubby_blk","rhsusf_acc_grip3",
"rhs_weap_m4a1_blockII_KAC_bk","rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red", "ACE_30Rnd_556x45_Stanag_M995_AP_mag","rhsusf_acc_eotech_552","rhsusf_acc_compm4","rhsusf_acc_acog_rmr","rhsusf_acc_su230","rhsusf_acc_su230_mrds","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15_bk","rhsusf_acc_anpeq15a","ace_acc_pointer_green","acc_pointer_ir","rhsusf_acc_wmx_bk","rhsusf_acc_nt4_black","rhsusf_acc_rotex5_grey","rhsusf_acc_sf3p556","rhsusf_acc_sfmb556","ace_muzzle_mzls_l","rhsusf_acc_grip2","rhsusf_acc_grip1","rhsusf_acc_harris_bipod","rhsusf_acc_kac_grip","rhsusf_acc_rvg_blk","rhsusf_acc_tacsac_blk","rhsusf_acc_tdstubby_blk","rhsusf_acc_grip3",
"rhs_weap_m4a1_blockII_KAC","rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red", "ACE_30Rnd_556x45_Stanag_M995_AP_mag","rhsusf_acc_eotech_552","rhsusf_acc_compm4","rhsusf_acc_acog_rmr","rhsusf_acc_su230","rhsusf_acc_su230_mrds","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15_bk","rhsusf_acc_anpeq15a","ace_acc_pointer_green","acc_pointer_ir","rhsusf_acc_wmx_bk","rhsusf_acc_nt4_black","rhsusf_acc_rotex5_grey","rhsusf_acc_sf3p556","rhsusf_acc_sfmb556","ace_muzzle_mzls_l","rhsusf_acc_grip2","rhsusf_acc_grip1","rhsusf_acc_harris_bipod","rhsusf_acc_kac_grip","rhsusf_acc_rvg_blk","rhsusf_acc_tacsac_blk","rhsusf_acc_tdstubby_blk","rhsusf_acc_grip3",
"rhs_weap_m4a1","rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red", "ACE_30Rnd_556x45_Stanag_M995_AP_mag","rhsusf_acc_eotech_552","rhsusf_acc_compm4","rhsusf_acc_acog_rmr","rhsusf_acc_su230","rhsusf_acc_su230_mrds","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15_bk","rhsusf_acc_anpeq15a","ace_acc_pointer_green","acc_pointer_ir","rhsusf_acc_wmx_bk","rhsusf_acc_nt4_black","rhsusf_acc_rotex5_grey","rhsusf_acc_sf3p556","rhsusf_acc_sfmb556","ace_muzzle_mzls_l","rhsusf_acc_grip2","rhsusf_acc_grip1","rhsusf_acc_harris_bipod","rhsusf_acc_kac_grip","rhsusf_acc_rvg_blk","rhsusf_acc_tacsac_blk","rhsusf_acc_tdstubby_blk","rhsusf_acc_grip3",
"rhs_weap_m4a1_mstock","rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red", "ACE_30Rnd_556x45_Stanag_M995_AP_mag","rhsusf_acc_eotech_552","rhsusf_acc_compm4","rhsusf_acc_acog_rmr","rhsusf_acc_su230","rhsusf_acc_su230_mrds","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15_bk","rhsusf_acc_anpeq15a","ace_acc_pointer_green","acc_pointer_ir","rhsusf_acc_wmx_bk","rhsusf_acc_nt4_black","rhsusf_acc_rotex5_grey","rhsusf_acc_sf3p556","rhsusf_acc_sfmb556","ace_muzzle_mzls_l","rhsusf_acc_grip2","rhsusf_acc_grip1","rhsusf_acc_harris_bipod","rhsusf_acc_kac_grip","rhsusf_acc_rvg_blk","rhsusf_acc_tacsac_blk","rhsusf_acc_tdstubby_blk","rhsusf_acc_grip3",
"rhs_weap_mk18","rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red", "ACE_30Rnd_556x45_Stanag_M995_AP_mag","rhsusf_acc_eotech_552","rhsusf_acc_compm4","rhsusf_acc_acog_rmr","rhsusf_acc_su230","rhsusf_acc_su230_mrds","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15_bk","rhsusf_acc_anpeq15a","ace_acc_pointer_green","acc_pointer_ir","rhsusf_acc_wmx_bk","rhsusf_acc_nt4_black","rhsusf_acc_rotex5_grey","rhsusf_acc_sf3p556","rhsusf_acc_sfmb556","ace_muzzle_mzls_l","rhsusf_acc_grip2","rhsusf_acc_grip1","rhsusf_acc_harris_bipod","rhsusf_acc_kac_grip","rhsusf_acc_rvg_blk","rhsusf_acc_tacsac_blk","rhsusf_acc_tdstubby_blk","rhsusf_acc_grip3",
"rhs_weap_mk18_bk","rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red", "ACE_30Rnd_556x45_Stanag_M995_AP_mag","rhsusf_acc_eotech_552","rhsusf_acc_compm4","rhsusf_acc_acog_rmr","rhsusf_acc_su230","rhsusf_acc_su230_mrds","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15_bk","rhsusf_acc_anpeq15a","ace_acc_pointer_green","acc_pointer_ir","rhsusf_acc_wmx_bk","rhsusf_acc_nt4_black","rhsusf_acc_rotex5_grey","rhsusf_acc_sf3p556","rhsusf_acc_sfmb556","ace_muzzle_mzls_l","rhsusf_acc_grip2","rhsusf_acc_grip1","rhsusf_acc_harris_bipod","rhsusf_acc_kac_grip","rhsusf_acc_rvg_blk","rhsusf_acc_tacsac_blk","rhsusf_acc_tdstubby_blk","rhsusf_acc_grip3",
"rhs_weap_mk18_KAC_bk","rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red", "ACE_30Rnd_556x45_Stanag_M995_AP_mag","rhsusf_acc_eotech_552","rhsusf_acc_compm4","rhsusf_acc_acog_rmr","rhsusf_acc_su230","rhsusf_acc_su230_mrds","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15_bk","rhsusf_acc_anpeq15a","ace_acc_pointer_green","acc_pointer_ir","rhsusf_acc_wmx_bk","rhsusf_acc_nt4_black","rhsusf_acc_rotex5_grey","rhsusf_acc_sf3p556","rhsusf_acc_sfmb556","ace_muzzle_mzls_l","rhsusf_acc_grip2","rhsusf_acc_grip1","rhsusf_acc_harris_bipod","rhsusf_acc_kac_grip","rhsusf_acc_rvg_blk","rhsusf_acc_tacsac_blk","rhsusf_acc_tdstubby_blk","rhsusf_acc_grip3",
"rhs_weap_mk18_KAC","rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red", "ACE_30Rnd_556x45_Stanag_M995_AP_mag","rhsusf_acc_eotech_552","rhsusf_acc_compm4","rhsusf_acc_acog_rmr","rhsusf_acc_su230","rhsusf_acc_su230_mrds","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15_bk","rhsusf_acc_anpeq15a","ace_acc_pointer_green","acc_pointer_ir","rhsusf_acc_wmx_bk","rhsusf_acc_nt4_black","rhsusf_acc_rotex5_grey","rhsusf_acc_sf3p556","rhsusf_acc_sfmb556","ace_muzzle_mzls_l","rhsusf_acc_grip2","rhsusf_acc_grip1","rhsusf_acc_harris_bipod","rhsusf_acc_kac_grip","rhsusf_acc_rvg_blk","rhsusf_acc_tacsac_blk","rhsusf_acc_tdstubby_blk","rhsusf_acc_grip3",
"rhs_weap_m16a4","rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red", "ACE_30Rnd_556x45_Stanag_M995_AP_mag","rhsusf_acc_eotech_552","rhsusf_acc_compm4","rhsusf_acc_acog_rmr","rhsusf_acc_su230","rhsusf_acc_su230_mrds","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15_bk","rhsusf_acc_anpeq15a","ace_acc_pointer_green","acc_pointer_ir","rhsusf_acc_wmx_bk","rhsusf_acc_nt4_black","rhsusf_acc_rotex5_grey","rhsusf_acc_sf3p556","rhsusf_acc_sfmb556","ace_muzzle_mzls_l","rhsusf_acc_grip2","rhsusf_acc_grip1","rhsusf_acc_harris_bipod","rhsusf_acc_kac_grip","rhsusf_acc_rvg_blk","rhsusf_acc_tacsac_blk","rhsusf_acc_tdstubby_blk","rhsusf_acc_grip3",
"rhs_weap_m16a4_carryhandle","rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red", "ACE_30Rnd_556x45_Stanag_M995_AP_mag","rhsusf_acc_eotech_552","rhsusf_acc_compm4","rhsusf_acc_acog_rmr","rhsusf_acc_su230","rhsusf_acc_su230_mrds","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15_bk","rhsusf_acc_anpeq15a","ace_acc_pointer_green","acc_pointer_ir","rhsusf_acc_wmx_bk","rhsusf_acc_nt4_black","rhsusf_acc_rotex5_grey","rhsusf_acc_sf3p556","rhsusf_acc_sfmb556","ace_muzzle_mzls_l","rhsusf_acc_grip2","rhsusf_acc_grip1","rhsusf_acc_harris_bipod","rhsusf_acc_kac_grip","rhsusf_acc_rvg_blk","rhsusf_acc_tacsac_blk","rhsusf_acc_tdstubby_blk","rhsusf_acc_grip3",
"rhs_weap_m16a4_imod","rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red", "ACE_30Rnd_556x45_Stanag_M995_AP_mag","rhsusf_acc_eotech_552","rhsusf_acc_compm4","rhsusf_acc_acog_rmr","rhsusf_acc_su230","rhsusf_acc_su230_mrds","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15_bk","rhsusf_acc_anpeq15a","ace_acc_pointer_green","acc_pointer_ir","rhsusf_acc_wmx_bk","rhsusf_acc_nt4_black","rhsusf_acc_rotex5_grey","rhsusf_acc_sf3p556","rhsusf_acc_sfmb556","ace_muzzle_mzls_l","rhsusf_acc_grip2","rhsusf_acc_grip1","rhsusf_acc_harris_bipod","rhsusf_acc_kac_grip","rhsusf_acc_rvg_blk","rhsusf_acc_tacsac_blk","rhsusf_acc_tdstubby_blk","rhsusf_acc_grip3",
"rhs_weap_m27iar","rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red", "ACE_30Rnd_556x45_Stanag_M995_AP_mag","rhsusf_acc_eotech_552","rhsusf_acc_compm4","rhsusf_acc_acog_rmr","rhsusf_acc_su230","rhsusf_acc_su230_mrds","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15_bk","rhsusf_acc_anpeq15a","ace_acc_pointer_green","acc_pointer_ir","rhsusf_acc_wmx_bk","rhsusf_acc_nt4_black","rhsusf_acc_rotex5_grey","rhsusf_acc_sf3p556","rhsusf_acc_sfmb556","ace_muzzle_mzls_l","rhsusf_acc_grip2","rhsusf_acc_grip1","rhsusf_acc_harris_bipod","rhsusf_acc_kac_grip","rhsusf_acc_rvg_blk","rhsusf_acc_tacsac_blk","rhsusf_acc_tdstubby_blk","rhsusf_acc_grip3",
"arifle_SDAR_F", "20Rnd_556x45_UW_mag",
//SECONDARY
"hgun_ACPC2_F","9Rnd_45ACP_Mag","acc_flashlight_pistol", "rhsusf_acc_omega9k", "muzzle_snds_acp" , "ace_muzzle_mzls_smg_01" ,
"rhsus_weap_glock17g4","rhsusf_mag_17Rnd_9x19_FMJ","acc_flashlight_pistol", "rhsusf_acc_omega9k",
"rhsusf_weap_m1911a1","rhsusf_mag_7x45acp_MHP",
"hgun_Pistol_heavy_01_F","11Rnd_45ACP_Mag","optic_mrd", "acc_flashlight_pistol", "muzzle_snds_acp",
"rhsusf_weap_m9","rhsusf_mag_15Rnd_9x19_FMJ",
"hgun_esd_01_F","acc_esd_01_flashlight", "muzzle_antenna_02_f","muzzle_antenna_03_f","muzzle_antenna_01_f",
"ACE_VMH3",
"ACE_VMM3",
//LAUNCHER
//HELM
"rhsusf_mich_helmet_marpatwd",
"rhsusf_mich_helmet_marpatwd_alt",
"rhsusf_mich_helmet_marpatwd_alt_headset",
"rhsusf_mich_helmet_marpatwd_headset",
"rhsusf_mich_helmet_marpatwd_norotos",
"rhsusf_mich_helmet_marpatwd_norotos_arc",
"rhsusf_mich_helmet_marpatwd_norotos_arc_headset",
"rhsusf_mich_helmet_marpatwd_norotos_headset",
//"rhsusf_patrolcap_ocp",
//"rhsusf_patrolcap_ucp",
"rhs_8point_marpatd",
"rhs_8point_marpatwd",
"H_Booniehat_khk_hs",
"H_Booniehat_khk",
//"H_Booniehat_mcamo",
"H_Booniehat_oli",
"H_Booniehat_tan",
//"H_Booniehat_dgtl",
"rhsusf_lwh_helmet_marpatwd",
"rhsusf_lwh_helmet_marpatwd_blk_ess",
"rhsusf_lwh_helmet_marpatwd_headset_blk2",
"rhsusf_lwh_helmet_marpatwd_headset_blk",
"rhsusf_lwh_helmet_marpatwd_headset",
"rhsusf_lwh_helmet_marpatwd_ess",
//UNIFORM
"U_B_Wetsuit",
//"rhs_uniform_g3_aor2",
//"rhs_uniform_g3_blk",
"rhs_uniform_g3_m81",
//"rhs_uniform_g3_mc",
"rhs_uniform_g3_rgr",
//"rhs_uniform_g3_tan",
"rhs_uniform_FROG01_wd",
//VEST
"rhsusf_plateframe_grenadier",
"rhsusf_plateframe_light",
"rhsusf_plateframe_rifleman",
"rhsusf_spc",
"rhsusf_spc_iar",
"rhsusf_spc_light",
"rhsusf_spc_patchless",
"rhsusf_spc_patchless_radio",
"rhsusf_spc_rifleman",
"V_RebreatherB",
//BACKPACK
"B_Carryall_oli",
//"B_Carryall_mcamo",
"B_Carryall_khk",
"B_Carryall_cbr",
"B_Carryall_eaf_F",
"rhssaf_kitbag_smb",
//"rhssaf_kitbag_md2camo",
"B_Kitbag_cbr",
"B_Kitbag_rgr",
"rhsusf_falconii_coy",
//"rhsusf_falconii_mc",
"rhsusf_falconii",
"B_AssaultPack_rgr",
//"B_AssaultPack_mcamo",
"B_AssaultPack_khk",
//"B_AssaultPack_mcamo",
"B_AssaultPack_wdl_F",
"B_AssaultPack_cbr",
"rhs_d6_Parachute_backpack",
"B_Parachute",
//M40GasMask
"M40_Gas_mask_nbc_hood_v1_s",
"M40_Gas_mask_nbc_hood_v4_s",
"M40_Gas_mask_nbc_hood_v7_s",
"M40_Gas_mask_nbc_f1_d",
"M40_Gas_mask_nbc_f2_d",
"M40_Gas_mask_nbc_f4_d",
"M40_Gas_mask_nbc_c1_d",
"M40_Gas_mask_nbc_c2_d",
"M40_Gas_mask_nbc_c4_d",
//FACEWARE
"rhs_googles_black",
"rhs_googles_clear",
"rhs_googles_orange",
"rhs_googles_yellow",
"G_Bandanna_beast",
"G_Bandanna_aviator",
"G_Bandanna_blk",
"G_Bandanna_khk",
"G_Bandanna_oli",
"G_Bandanna_tan",
"rhsusf_shemagh_grn",
"rhsusf_shemagh2_grn",
"rhsusf_shemagh_od",
"rhsusf_shemagh2_od",
"rhsusf_shemagh_tan",
"rhsusf_shemagh2_tan",
"rhsusf_shemagh_white",
"rhsusf_shemagh_gogg_grn",
"rhsusf_shemagh2_gogg_grn",
"rhsusf_shemagh_gogg_od",
"rhsusf_shemagh2_gogg_od",
"rhsusf_shemagh_gogg_tan",
"rhsusf_shemagh2_gogg_tan",
"rhsusf_shemagh_gogg_white",
"rhsusf_shemagh2_gogg_white",
"rhsusf_oakley_goggles_blk",
"rhsusf_oakley_goggles_clr",
"rhsusf_oakley_goggles_ylw",
"G_B_Diving",
"G_Aviator",
//NVG
"rhs_1PN138",
"rhsusf_ANPVS_14",
"rhsusf_ANPVS_15",
"ACE_NVG_Wide_Green",
"ACE_NVG_Wide",
"ACE_NVG_Wide_Black",
//BINOCULARS
"Binocular",
"Camera_lxWS",
"rhsusf_bino_lerca_1200_black",
"rhsusf_bino_lerca_1200_tan",
"rhsusf_bino_m24",
"rhsusf_bino_m24_ARD",
"ACE_VectorDay",
"ACE_Vector",
//RADIO
"TFAR_anprc152",
//GRENADE
"ACE_M14",
"rhs_mag_an_m14_th3",
"B_IR_Grenade",
"rhs_mag_an_m8hc",
"SmokeShellBlue",
"SmokeShellGreen",
"SmokeShellOrange",
"SmokeShellPurple",
"SmokeShellRed",
"SmokeShellYellow",
"ACE_HandFlare_White",
"ACE_HandFlare_Yellow",
"ACE_HandFlare_Red",
"ACE_HandFlare_Green",
"rhs_mag_m67",
"Chemlight_blue",
"Chemlight_green",
"ACE_Chemlight_HiBlue",
"ACE_Chemlight_HiGreen",
"ACE_Chemlight_HiRed",
"ACE_Chemlight_HiWhite",
"ACE_Chemlight_HiYellow",
"ACE_Chemlight_IR",
"ACE_Chemlight_Orange",
"Chemlight_red",
"ACE_Chemlight_UltraHiOrange",
"ACE_Chemlight_White",
"Chemlight_yellow",
//EXPLOSIVES
"rhsusf_m112_mag",
"rhsusf_m112x4_mag",
//MEDICAL
"kat_Painkiller",
"ACE_adenosine",
"ACE_fieldDressing",
"ACE_elasticBandage",
"ACE_packingBandage",
"ACE_quikclot",
"ACE_bodyBag",
"ACE_epinephrine",
"ACE_morphine",
"ACE_tourniquet",
"ACE_splint",
//MISC ITEMS
"ACE_CableTie",
"ACE_EarPlugs",
"MineDetector",
"ACE_RangeTable_82mm",
"ACE_artilleryTable",
"ACE_Banana",
"ACE_Canteen",
"ACE_Chemlight_Shield",
"ACE_DAGR",
"ACE_EarPlugs",
"ACE_EntrenchingTool",
"ACE_Flashlight_MX991",
"ACE_Humanitarian_Ration",
"ACE_IR_Strobe_Item",
"ACE_M26_Clacker",
"ACE_Clacker",
"ACE_Flashlight_XL50",
"ACE_MapTools",
"ACE_microDAGR",
"ACE_RangeCard",
"ACE_rope27",
"ACE_rope36",
"ACE_Sandbag_empty",
"ACE_SpareBarrel_Item",
"ACE_SpottingScope",
"ACE_SpraypaintRed",
"ACE_WaterBottle",
"ACE_wirecutter",
"ItemcTabHCam",
"tfw_rf3080Item",
//TERMINAL
"ItemGPS",
"Laserbatteries",
"ItemAndroid",
"ItemMicroDAGR",
"ChemicalDetector_01_watch_F",
"ItemWatch",
"ACE_Altimeter",
"ItemcTab"
	];

	Private _CO = [
//PRIMARY
//SECONDARY
"rhs_weap_M320","rhs_mag_M433_HEDP","rhs_mag_M441_HE","ACE_40mm_Flare_white","rhs_mag_m714_White","rhs_mag_m715_Green","rhs_mag_m716_yellow","ACE_HuntIR_M203",
//LAUNCHER
//HELM
"rhsusf_bowman_cap",
"H_Cap_headphones",
"H_Cap_blk",
"H_Cap_grn_BI",
"H_Cap_blu",
"H_Cap_blk_CMMG",
"H_Cap_grn",
"H_Cap_blk_ION",
"H_Cap_oli",
"H_Cap_oli_hs",
"H_Cap_police",
"H_Cap_press",
"H_Cap_tan",
"H_Cap_khaki_specops_UK",
"H_Cap_usblack",
"H_Cap_tan_specops_US",
//UNIFORM
//VEST
"rhsusf_plateframe_marksman",
"rhsusf_plateframe_teamleader",
"rhsusf_spc_marksman",
"rhsusf_spc_squadleader",
"rhsusf_spc_teamleader",
"V_Rangemaster_belt",
"V_LegStrapBag_olive_F",
"V_LegStrapBag_coyote_F",
"V_LegStrapBag_black_F",
//BACKPACK
//"tfw_ilbe_blade_mc",
//"tfw_ilbe_blade_ocp",
"tfw_ilbe_blade_wd2",
//"tfw_ilbe_DD_alpine",
//"tfw_ilbe_DD_arid",
//"tfw_ilbe_DD_black",
"tfw_ilbe_DD_coy",
"tfw_ilbe_DD_gr",
//"tfw_ilbe_DD_d",
"tfw_ilbe_DD_wd",
//"tfw_ilbe_DD_mct",
//"tfw_ilbe_DD_mc",
//"tfw_ilbe_DD_ocp",
"tfw_ilbe_DD_wd2",
//"tfw_ilbe_whip_alpine",
//"tfw_ilbe_whip_arid",
//"tfw_ilbe_whip_black",
"tfw_ilbe_whip_coy",
"tfw_ilbe_whip_gr",
//"tfw_ilbe_whip_d",
"tfw_ilbe_whip_wd",
//"tfw_ilbe_whip_mct",
//"tfw_ilbe_whip_mc",
//"tfw_ilbe_whip_ocp",
"tfw_ilbe_whip_wd2",
"B_Respawn_TentDome_F",
"B_shield_backpack_lxWS",
"B_UAV_01_backpack_F",
"B_G_UAV_02_IED_backpack_lxWS",
"B_UGV_02_Science_backpack_F",
"B_UAV_06_backpack_F",
"B_UGV_02_Demining_backpack_F",
//FACEWARE
//NVG
//BINOCULARS
"Laserdesignator",
"ACE_MX2A",
//RADIO
//GRENADE
//EXPLOSIVES
//MEDICAL
//MISC ITEMS
"ACE_ATragMX",
"ACE_HuntIR_monitor",
"ACE_Kestrel4500",
"ACE_Tripod",
"ACE_UAVBattery",
//TERMINAL
"itc_land_tablet_rover",
"ITC_ROVER_SIR",
"ACE_Fortify",
"B_UavTerminal"
  ];

	Private _SL = [
//PRIMARY
//SECONDARY
"rhs_weap_M320","rhs_mag_M433_HEDP","rhs_mag_M441_HE","ACE_40mm_Flare_white","rhs_mag_m714_White","rhs_mag_m715_Green","rhs_mag_m716_yellow","ACE_HuntIR_M203",
//LAUNCHER
"tf47_at4_heat",
"tf47_at4_HEDP",
"tf47_at4_HP",
"rhs_weap_M136",
"rhs_weap_M136_hedp",
"rhs_weap_M136_hp",
//HELM
//UNIFORM
//VEST
"rhsusf_plateframe_marksman",
"rhsusf_plateframe_teamleader",
"rhsusf_spc_marksman",
"rhsusf_spc_squadleader",
"rhsusf_spc_teamleader",
//BACKPACK
//"tfw_ilbe_blade_mc",
//"tfw_ilbe_blade_ocp",
"tfw_ilbe_blade_wd2",
//"tfw_ilbe_DD_alpine",
//"tfw_ilbe_DD_arid",
//"tfw_ilbe_DD_black",
"tfw_ilbe_DD_coy",
"tfw_ilbe_DD_gr",
//"tfw_ilbe_DD_d",
"tfw_ilbe_DD_wd",
//"tfw_ilbe_DD_mct",
//"tfw_ilbe_DD_mc",
//"tfw_ilbe_DD_ocp",
//"tfw_ilbe_DD_wd2",
//"tfw_ilbe_whip_alpine",
//"tfw_ilbe_whip_arid",
//"tfw_ilbe_whip_black",
"tfw_ilbe_whip_coy",
"tfw_ilbe_whip_gr",
//"tfw_ilbe_whip_d",
"tfw_ilbe_whip_wd",
//"tfw_ilbe_whip_mct",
//"tfw_ilbe_whip_mc",
//"tfw_ilbe_whip_ocp",
"tfw_ilbe_whip_wd2",
"B_Respawn_TentDome_F",
"B_shield_backpack_lxWS",
"B_UAV_01_backpack_F",
"B_G_UAV_02_IED_backpack_lxWS",
"B_UGV_02_Science_backpack_F",
"B_UAV_06_backpack_F",
"B_UGV_02_Demining_backpack_F",
//FACEWARE
//FACEWARE
//NVG
//BINOCULARS
"Laserdesignator",
"Laserdesignator_03",
"ACE_MX2A",
//RADIO
//GRENADE
//EXPLOSIVES
//MEDICAL
//MISC ITEMS
"ACE_ATragMX",
"ACE_HuntIR_monitor",
"ACE_Kestrel4500",
"ACE_Tripod",
"ACE_UAVBattery",
//TERMINAL
"itc_land_tablet_rover",
"ITC_ROVER_SIR",
"B_UavTerminal"
	];

	Private _MEDIC = [
//PRIMARY
"rhs_weap_M590_8RD","rhsusf_8Rnd_00Buck","rhsusf_8Rnd_Slug",
"rhs_weap_M590_5RD","rhsusf_8Rnd_00Buck","rhsusf_8Rnd_Slug",
//SECONDARY
//LAUNCHER
//HELM
//UNIFORM
//VEST
"rhsusf_plateframe_medic",
"rhsusf_spc_corpsman",
//BACKPACK
//FACEWARE
//NVG
//BINOCULARS
//RADIO
//GRENADE
//EXPLOSIVES
//MEDICAL
"kat_IV_16",
"ACE_adenosine",
"kat_AED",
"kat_X_AED",
"ACE_bloodIV",
"ACE_bloodIV_250",
"ACE_bloodIV_500",
"kat_plate",
"kat_clamp",
"kat_vacuum",
"ACE_epinephrine",
"kat_etomidate",
"kat_IO_FAST",
"kat_flumazenil",
"kat_lidocaine",
"kat_lorazepam",
"ACE_morphine",
"kat_naloxone",
"kat_nitroglycerin",
"kat_norepinephrine",
"ACE_personalAidKit",
"kat_phenylephrine",
"kat_phenylephrine_inject",
"ACE_plasmaIV",
"ACE_plasmaIV_250",
"ACE_plasmaIV_500",
"kat_retractor",
"ACE_salineIV",
"ACE_salineIV_250",
"ACE_salineIV_500",
"kat_scalpel",
"ACE_splint",
"ACE_surgicalKit",
"kat_TXA",
"kat_Carbonate"
//MISC ITEMS
//TERMINAL
	];

	Private _FTL = [
//PRIMARY
//SECONDARY
"rhs_weap_M320","rhs_mag_M433_HEDP","rhs_mag_M441_HE","ACE_40mm_Flare_white","rhs_mag_m714_White","rhs_mag_m715_Green","rhs_mag_m716_yellow","ACE_HuntIR_M203",
//LAUNCHER
"tf47_at4_heat",
"tf47_at4_HEDP",
"tf47_at4_HP",
"rhs_weap_M136",
"rhs_weap_M136_hedp",
"rhs_weap_M136_hp",
//HELM
//UNIFORM
//VEST
"rhsusf_plateframe_marksman",
"rhsusf_plateframe_teamleader",
"rhsusf_spc_marksman",
"rhsusf_spc_squadleader",
"rhsusf_spc_teamleader",
//BACKPACK
//"tfw_ilbe_blade_mc",
//"tfw_ilbe_blade_ocp",
"tfw_ilbe_blade_wd2",
//"tfw_ilbe_DD_alpine",
//"tfw_ilbe_DD_arid",
//"tfw_ilbe_DD_black",
"tfw_ilbe_DD_coy",
"tfw_ilbe_DD_gr",
//"tfw_ilbe_DD_d",
"tfw_ilbe_DD_wd",
//"tfw_ilbe_DD_mct",
//"tfw_ilbe_DD_mc",
//"tfw_ilbe_DD_ocp",
"tfw_ilbe_DD_wd2",
//"tfw_ilbe_whip_alpine",
//"tfw_ilbe_whip_arid",
//"tfw_ilbe_whip_black",
"tfw_ilbe_whip_coy",
"tfw_ilbe_whip_gr",
//"tfw_ilbe_whip_d",
"tfw_ilbe_whip_wd",
//"tfw_ilbe_whip_mct",
//"tfw_ilbe_whip_mc",
//"tfw_ilbe_whip_ocp",
"tfw_ilbe_whip_wd2",
//FACEWARE
//NVG
//BINOCULARS
"Laserdesignator",
"Laserdesignator_03",
"ACE_MX2A",
//RADIO
//GRENADE
//EXPLOSIVES
//MEDICAL
//MISC ITEMS
"ACE_ATragMX",
"ACE_HuntIR_monitor",
"ACE_Kestrel4500",
"ACE_Tripod",
"ACE_UAVBattery",
//TERMINAL
"itc_land_tablet_rover",
"ITC_ROVER_SIR",
"B_UavTerminal"
	];

	Private _AUTORIFLEMAN = [
//PRIMARY
"rhs_weap_m240B","rhsusf_100Rnd_762x51_m61_ap","rhsusf_100Rnd_762x51_m62_tracer","rhsusf_100Rnd_762x51_m80a1epr","rhsusf_50Rnd_762x51_m61_ap","rhsusf_50Rnd_762x51_m62_tracer","rhsusf_50Rnd_762x51_m80a1epr","150Rnd_762x51_Box_Tracer","rhsusf_acc_su230a","rhsusf_acc_su230a_mrds","rhsusf_acc_acog_mdo","rhsusf_acc_acog_rmr","rhsusf_acc_elcan_ard","rhsusf_acc_anpeq15side_bk","rhsusf_acc_ardec_m240",
"rhs_weap_m240G","rhsusf_100Rnd_762x51_m61_ap","rhsusf_100Rnd_762x51_m62_tracer","rhsusf_100Rnd_762x51_m80a1epr","rhsusf_50Rnd_762x51_m61_ap","rhsusf_50Rnd_762x51_m62_tracer","rhsusf_50Rnd_762x51_m80a1epr","150Rnd_762x51_Box_Tracer","rhsusf_acc_su230a","rhsusf_acc_su230a_mrds","rhsusf_acc_acog_mdo","rhsusf_acc_acog_rmr","rhsusf_acc_elcan_ard","rhsusf_acc_ardec_m240",
"rhs_weap_m249_pip_L","rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red", "ACE_30Rnd_556x45_Stanag_M995_AP_mag","rhsusf_100Rnd_556x45_M855_soft_pouch","rhsusf_100Rnd_556x45_M855_mixed_soft_pouch","rhsusf_100Rnd_556x45_soft_pouch","rhsusf_100Rnd_556x45_mixed_soft_pouch","rhsusf_100Rnd_556x45_M995_soft_pouch","rhsusf_200Rnd_556x45_box","rhsusf_200rnd_556x45_mixed_box","rhsusf_200Rnd_556x45_soft_pouch","rhsusf_200Rnd_556x45_mixed_soft_pouch","rhsusf_acc_su230","rhsusf_acc_su230_mrds","rhsusf_acc_acog_rmr","rhsusf_acc_elcan_ard","rhsusf_acc_sf3p556","rhsusf_acc_sfmb556","rhsusf_acc_rotex5_grey","rhsusf_acc_nt4_black","rhsusf_acc_anpeq15side_bk","rhsusf_acc_kac_grip_saw_bipod","rhsusf_acc_grip1","rhsusf_acc_grip4_bipod","rhsusf_acc_saw_lw_bipod","rhsusf_acc_kac_grip",
"rhs_weap_m249_pip_S","rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red", "ACE_30Rnd_556x45_Stanag_M995_AP_mag","rhsusf_100Rnd_556x45_M855_soft_pouch","rhsusf_100Rnd_556x45_M855_mixed_soft_pouch","rhsusf_100Rnd_556x45_soft_pouch","rhsusf_100Rnd_556x45_mixed_soft_pouch","rhsusf_100Rnd_556x45_M995_soft_pouch","rhsusf_200Rnd_556x45_box","rhsusf_200rnd_556x45_mixed_box","rhsusf_200Rnd_556x45_soft_pouch","rhsusf_200Rnd_556x45_mixed_soft_pouch","rhsusf_acc_su230","rhsusf_acc_su230_mrds","rhsusf_acc_acog_rmr","rhsusf_acc_elcan_ard","rhsusf_acc_sf3p556","rhsusf_acc_sfmb556","rhsusf_acc_rotex5_grey","rhsusf_acc_nt4_black","rhsusf_acc_anpeq15side_bk","rhsusf_acc_kac_grip_saw_bipod","rhsusf_acc_grip1","rhsusf_acc_grip4_bipod","rhsusf_acc_saw_lw_bipod","rhsusf_acc_kac_grip",
//SECONDARY
//LAUNCHER
//HELM
//UNIFORM
//VEST
"rhsusf_plateframe_machinegunner",
"rhsusf_spc_mg",
//BACKPACK
//FACEWARE
//NVG
//BINOCULARS
//RADIO
//GRENADE
//EXPLOSIVES
//MEDICAL
//MISC ITEMS
"optic_nvs"
//TERMINAL
	];

	Private _AT = [
//PRIMARY
//SECONDARY
//LAUNCHER
"tf47_at4_heat",
"tf47_at4_HEDP",
"rhs_weap_fim92","rhs_fim92_mag",
"tf47_at4_HP",
"tf47_m3maaws","tf47_m3maaws_HE","tf47_m3maaws_SMOKE","tf47_m3maaws_HEDP","tf47_m3maaws_ILLUM","tf47_m3maaws_HEAT","tf47_optic_m3maaws",
"tf47_smaw_green","tf47_smaw_HEDP","tf47_smaw_HEAA","tf47_smaw_NE","tf47_optic_smaw",
"tf47_smaw","tf47_smaw_HEDP","tf47_smaw_HEAA","tf47_smaw_NE","tf47_optic_smaw",
"rhs_weap_M136",
"rhs_weap_M136_hedp",
"rhs_weap_M136_hp",
//HELM
//UNIFORM
//VEST
//BACKPACK
//FACEWARE
//NVG
//BINOCULARS
//RADIO
//GRENADE
//EXPLOSIVES
//MEDICAL
//MISC ITEMS
"tf47_smaw_SR"
//TERMINAL
	];

  Private _GRENADIER = [
//PRIMARY
"rhs_weap_m4_carryhandle_m203","rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red", "ACE_30Rnd_556x45_Stanag_M995_AP_mag","rhs_mag_M433_HEDP","rhs_mag_M441_HE","ACE_40mm_Flare_white","rhs_mag_m714_White","rhs_mag_m715_Green","rhs_mag_m716_yellow","ACE_HuntIR_M203","rhsusf_acc_eotech_552","rhsusf_acc_compm4","rhsusf_acc_acog_rmr","rhsusf_acc_su230","rhsusf_acc_su230_mrds","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15a","rhsusf_acc_wmx_bk","rhsusf_acc_grip_m203_blk",
"rhs_weap_m4_carryhandle_m203S","rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red", "ACE_30Rnd_556x45_Stanag_M995_AP_mag","rhs_mag_M433_HEDP","rhs_mag_M441_HE","ACE_40mm_Flare_white","rhs_mag_m714_White","rhs_mag_m715_Green","rhs_mag_m716_yellow","ACE_HuntIR_M203","rhsusf_acc_eotech_552","rhsusf_acc_compm4","rhsusf_acc_acog_rmr","rhsusf_acc_su230","rhsusf_acc_su230_mrds","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15a","rhsusf_acc_wmx_bk","rhsusf_acc_grip_m203_blk",
"rhs_weap_m4_m203","rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red", "ACE_30Rnd_556x45_Stanag_M995_AP_mag","rhs_mag_M433_HEDP","rhs_mag_M441_HE","ACE_40mm_Flare_white","rhs_mag_m714_White","rhs_mag_m715_Green","rhs_mag_m716_yellow","ACE_HuntIR_M203","rhsusf_acc_eotech_552","rhsusf_acc_compm4","rhsusf_acc_acog_rmr","rhsusf_acc_su230","rhsusf_acc_su230_mrds","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15a","rhsusf_acc_wmx_bk","rhsusf_acc_grip_m203_blk",
"rhs_weap_m4_m203S","rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red", "ACE_30Rnd_556x45_Stanag_M995_AP_mag","rhs_mag_M433_HEDP","rhs_mag_M441_HE","ACE_40mm_Flare_white","rhs_mag_m714_White","rhs_mag_m715_Green","rhs_mag_m716_yellow","ACE_HuntIR_M203","rhsusf_acc_eotech_552","rhsusf_acc_compm4","rhsusf_acc_acog_rmr","rhsusf_acc_su230","rhsusf_acc_su230_mrds","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15a","rhsusf_acc_wmx_bk","rhsusf_acc_grip_m203_blk",
"rhs_weap_m4_m320","rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red", "ACE_30Rnd_556x45_Stanag_M995_AP_mag","rhs_mag_M433_HEDP","rhs_mag_M441_HE","ACE_40mm_Flare_white","rhs_mag_m714_White","rhs_mag_m715_Green","rhs_mag_m716_yellow","ACE_HuntIR_M203","rhsusf_acc_eotech_552","rhsusf_acc_compm4","rhsusf_acc_acog_rmr","rhsusf_acc_su230","rhsusf_acc_su230_mrds","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15_bk","rhsusf_acc_anpeq15a","ace_acc_pointer_green","acc_pointer_ir","rhsusf_acc_wmx_bk","rhsusf_acc_nt4_black","rhsusf_acc_rotex5_grey","rhsusf_acc_sf3p556","rhsusf_acc_sfmb556","ace_muzzle_mzls_l","rhsusf_acc_grip2","rhsusf_acc_grip1","rhsusf_acc_harris_bipod","rhsusf_acc_kac_grip","rhsusf_acc_rvg_blk","rhsusf_acc_tacsac_blk","rhsusf_acc_tdstubby_blk","rhsusf_acc_grip3",
"rhs_weap_m4a1_carryhandle_m203","rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red", "ACE_30Rnd_556x45_Stanag_M995_AP_mag","rhs_mag_M433_HEDP","rhs_mag_M441_HE","ACE_40mm_Flare_white","rhs_mag_m714_White","rhs_mag_m715_Green","rhs_mag_m716_yellow","ACE_HuntIR_M203","rhsusf_acc_eotech_552","rhsusf_acc_compm4","rhsusf_acc_acog_rmr","rhsusf_acc_su230","rhsusf_acc_su230_mrds","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15a","rhsusf_acc_wmx_bk","rhsusf_acc_grip_m203_blk",
"rhs_weap_m4a1_carryhandle_m203S","rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red", "ACE_30Rnd_556x45_Stanag_M995_AP_mag","rhs_mag_M433_HEDP","rhs_mag_M441_HE","ACE_40mm_Flare_white","rhs_mag_m714_White","rhs_mag_m715_Green","rhs_mag_m716_yellow","ACE_HuntIR_M203","rhsusf_acc_eotech_552","rhsusf_acc_compm4","rhsusf_acc_acog_rmr","rhsusf_acc_su230","rhsusf_acc_su230_mrds","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15a","rhsusf_acc_wmx_bk","rhsusf_acc_grip_m203_blk",
"rhs_weap_m4a1_blockII_M203_bk","rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red", "ACE_30Rnd_556x45_Stanag_M995_AP_mag","rhs_mag_M433_HEDP","rhs_mag_M441_HE","ACE_40mm_Flare_white","rhs_mag_m714_White","rhs_mag_m715_Green","rhs_mag_m716_yellow","ACE_HuntIR_M203","rhsusf_acc_eotech_552","rhsusf_acc_compm4","rhsusf_acc_acog_rmr","rhsusf_acc_su230","rhsusf_acc_su230_mrds","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15a","rhsusf_acc_wmx_bk","rhsusf_acc_grip_m203_blk",
"rhs_weap_m4a1_blockII_M203","rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red", "ACE_30Rnd_556x45_Stanag_M995_AP_mag","rhs_mag_M433_HEDP","rhs_mag_M441_HE","ACE_40mm_Flare_white","rhs_mag_m714_White","rhs_mag_m715_Green","rhs_mag_m716_yellow","ACE_HuntIR_M203","rhsusf_acc_eotech_552","rhsusf_acc_compm4","rhsusf_acc_acog_rmr","rhsusf_acc_su230","rhsusf_acc_su230_mrds","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15a","rhsusf_acc_wmx_bk","rhsusf_acc_grip_m203_blk",
"rhs_weap_m4a1_m203","rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red", "ACE_30Rnd_556x45_Stanag_M995_AP_mag","rhs_mag_M433_HEDP","rhs_mag_M441_HE","ACE_40mm_Flare_white","rhs_mag_m714_White","rhs_mag_m715_Green","rhs_mag_m716_yellow","ACE_HuntIR_M203","rhsusf_acc_eotech_552","rhsusf_acc_compm4","rhsusf_acc_acog_rmr","rhsusf_acc_su230","rhsusf_acc_su230_mrds","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15a","rhsusf_acc_wmx_bk","rhsusf_acc_grip_m203_blk",
"rhs_weap_m4a1_m203s","rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red", "ACE_30Rnd_556x45_Stanag_M995_AP_mag","rhs_mag_M433_HEDP","rhs_mag_M441_HE","ACE_40mm_Flare_white","rhs_mag_m714_White","rhs_mag_m715_Green","rhs_mag_m716_yellow","ACE_HuntIR_M203","rhsusf_acc_eotech_552","rhsusf_acc_compm4","rhsusf_acc_acog_rmr","rhsusf_acc_su230","rhsusf_acc_su230_mrds","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15a","rhsusf_acc_wmx_bk","rhsusf_acc_grip_m203_blk",
"rhs_weap_m4a1_m320","rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red", "ACE_30Rnd_556x45_Stanag_M995_AP_mag","rhs_mag_M433_HEDP","rhs_mag_M441_HE","ACE_40mm_Flare_white","rhs_mag_m714_White","rhs_mag_m715_Green","rhs_mag_m716_yellow","ACE_HuntIR_M203","rhsusf_acc_eotech_552","rhsusf_acc_compm4","rhsusf_acc_acog_rmr","rhsusf_acc_su230","rhsusf_acc_su230_mrds","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15_bk","rhsusf_acc_anpeq15a","ace_acc_pointer_green","acc_pointer_ir","rhsusf_acc_wmx_bk","rhsusf_acc_nt4_black","rhsusf_acc_rotex5_grey","rhsusf_acc_sf3p556","rhsusf_acc_sfmb556","ace_muzzle_mzls_l","rhsusf_acc_grip2","rhsusf_acc_grip1","rhsusf_acc_harris_bipod","rhsusf_acc_kac_grip","rhsusf_acc_rvg_blk","rhsusf_acc_tacsac_blk","rhsusf_acc_tdstubby_blk","rhsusf_acc_grip3",
"rhs_weap_mk18_m320","rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red", "ACE_30Rnd_556x45_Stanag_M995_AP_mag","rhs_mag_M433_HEDP","rhs_mag_M441_HE","ACE_40mm_Flare_white","rhs_mag_m714_White","rhs_mag_m715_Green","rhs_mag_m716_yellow","ACE_HuntIR_M203","rhsusf_acc_eotech_552","rhsusf_acc_compm4","rhsusf_acc_acog_rmr","rhsusf_acc_su230","rhsusf_acc_su230_mrds","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15_bk","rhsusf_acc_anpeq15a","ace_acc_pointer_green","acc_pointer_ir","rhsusf_acc_wmx_bk","rhsusf_acc_nt4_black","rhsusf_acc_rotex5_grey","rhsusf_acc_sf3p556","rhsusf_acc_sfmb556","ace_muzzle_mzls_l","rhsusf_acc_grip2","rhsusf_acc_grip1","rhsusf_acc_harris_bipod","rhsusf_acc_kac_grip","rhsusf_acc_rvg_blk","rhsusf_acc_tacsac_blk","rhsusf_acc_tdstubby_blk","rhsusf_acc_grip3",
"rhs_weap_m16a4_carryhandle_M203","rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red", "ACE_30Rnd_556x45_Stanag_M995_AP_mag","rhs_mag_M433_HEDP","rhs_mag_M441_HE","ACE_40mm_Flare_white","rhs_mag_m714_White","rhs_mag_m715_Green","rhs_mag_m716_yellow","ACE_HuntIR_M203","rhsusf_acc_eotech_552","rhsusf_acc_compm4","rhsusf_acc_acog_rmr","rhsusf_acc_su230","rhsusf_acc_su230_mrds","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15a","rhsusf_acc_wmx_bk","rhsusf_acc_grip_m203_blk",
"rhs_weap_m16a4_imod_M203","rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red", "ACE_30Rnd_556x45_Stanag_M995_AP_mag","rhs_mag_M433_HEDP","rhs_mag_M441_HE","ACE_40mm_Flare_white","rhs_mag_m714_White","rhs_mag_m715_Green","rhs_mag_m716_yellow","ACE_HuntIR_M203","rhsusf_acc_eotech_552","rhsusf_acc_compm4","rhsusf_acc_acog_rmr","rhsusf_acc_su230","rhsusf_acc_su230_mrds","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15a","rhsusf_acc_wmx_bk","rhsusf_acc_grip_m203_blk"
//SECONDARY
//LAUNCHER
//HELM
//UNIFORM
//VEST
//BACKPACK
//FACEWARE
//NVG
//BINOCULARS
//RADIO
//GRENADE
//EXPLOSIVES
//MEDICAL
//MISC ITEMS
//TERMINAL
  ];

	Private _RIFLEMAN = [
//PRIMARY
//SECONDARY
//LAUNCHER
"tf47_at4_heat",
"tf47_at4_HEDP",
"tf47_at4_HP",
"rhs_weap_M136",
"rhs_weap_M136_hedp",
"rhs_weap_M136_hp",
//HELM
//UNIFORM
//VEST
"rhsusf_plateframe_sapi"
//BACKPACK
//FACEWARE
//NVG
//BINOCULARS
//RADIO
//GRENADE
//EXPLOSIVES
//MEDICAL
//MISC ITEMS
//TERMINAL
	];

  Private _WARPIG = [
//PRIMARY
"rhs_weap_M590_8RD","rhsusf_8Rnd_00Buck","rhsusf_8Rnd_Slug",
"rhs_weap_M590_5RD","rhsusf_8Rnd_00Buck","rhsusf_8Rnd_Slug",
//SECONDARY
//LAUNCHER
//HELM
"rhsusf_cvc_green_helmet",
"rhsusf_cvc_green_alt_helmet",
"rhsusf_cvc_green_ess",
"rhsusf_cvc_helmet",
"rhsusf_cvc_alt_helmet",
"rhsusf_cvc_ess",
//UNIFORM
"U_lxWS_SFIA_Tanker_O",
//VEST
"rhsusf_plateframe_sapi",
"rhsusf_spc_crewman",
//BACKPACK
//"tfw_ilbe_blade_mc",
//"tfw_ilbe_blade_ocp",
"tfw_ilbe_blade_wd2",
//"tfw_ilbe_DD_alpine",
//"tfw_ilbe_DD_arid",
//"tfw_ilbe_DD_black",
"tfw_ilbe_DD_coy",
"tfw_ilbe_DD_gr",
//"tfw_ilbe_DD_d",
"tfw_ilbe_DD_wd",
//"tfw_ilbe_DD_mct",
//"tfw_ilbe_DD_mc",
//"tfw_ilbe_DD_ocp",
"tfw_ilbe_DD_wd2",
//"tfw_ilbe_whip_alpine",
//"tfw_ilbe_whip_arid",
//"tfw_ilbe_whip_black",
"tfw_ilbe_whip_coy",
"tfw_ilbe_whip_gr",
//"tfw_ilbe_whip_d",
"tfw_ilbe_whip_wd",
//"tfw_ilbe_whip_mct",
//"tfw_ilbe_whip_mc",
//"tfw_ilbe_whip_ocp",
"tfw_ilbe_whip_wd2",
//FACEWARE
//NVG
//BINOCULARS
"Laserdesignator",
"Laserdesignator_03",
"ACE_MX2A",
//RADIO
//GRENADE
//EXPLOSIVES
"ACE_FlareTripMine_Mag",
"SLAMDirectionalMine_Wire_Mag",
"ATMine_Range_Mag",
"ToolKit",
"ACE_ATragMX",
"ACE_HuntIR_monitor",
"ACE_Kestrel4500",
"ACE_Tripod",
"ACE_UAVBattery",
"ACE_DefusalKit"
//MEDICAL
//MISC ITEMS
//TERMINAL
  ];

Private _OGRE = [
//PRIMARY
"rhs_weap_M590_8RD","rhsusf_8Rnd_00Buck","rhsusf_8Rnd_Slug",
"rhs_weap_M590_5RD","rhsusf_8Rnd_00Buck","rhsusf_8Rnd_Slug",
//SECONDARY
//LAUNCHER
"tf47_at4_heat",
"tf47_at4_HEDP",
"tf47_at4_HP",
"rhs_weap_M136",
"rhs_weap_M136_hedp",
"rhs_weap_M136_hp",
//HELM
"rhsusf_cvc_green_helmet",
"rhsusf_cvc_green_alt_helmet",
"rhsusf_cvc_green_ess",
"rhsusf_cvc_helmet",
"rhsusf_cvc_alt_helmet",
"rhsusf_cvc_ess",
//UNIFORM
"U_lxWS_SFIA_Tanker_O",
//VEST
"rhsusf_plateframe_sapi",
"rhsusf_spc_crewman",
//BACKPACK
//"tfw_ilbe_blade_mc",
//"tfw_ilbe_blade_ocp",
"tfw_ilbe_blade_wd2",
//"tfw_ilbe_DD_alpine",
//"tfw_ilbe_DD_arid",
//"tfw_ilbe_DD_black",
"tfw_ilbe_DD_coy",
"tfw_ilbe_DD_gr",
//"tfw_ilbe_DD_d",
"tfw_ilbe_DD_wd",
//"tfw_ilbe_DD_mct",
//"tfw_ilbe_DD_mc",
//"tfw_ilbe_DD_ocp",
"tfw_ilbe_DD_wd2",
//"tfw_ilbe_whip_alpine",
//"tfw_ilbe_whip_arid",
//"tfw_ilbe_whip_black",
"tfw_ilbe_whip_coy",
"tfw_ilbe_whip_gr",
//"tfw_ilbe_whip_d",
"tfw_ilbe_whip_wd",
//"tfw_ilbe_whip_mct",
//"tfw_ilbe_whip_mc",
//"tfw_ilbe_whip_ocp",
"tfw_ilbe_whip_wd2",
"B_Respawn_TentDome_F",
"B_shield_backpack_lxWS",
"B_UAV_01_backpack_F",
"B_G_UAV_02_IED_backpack_lxWS",
"B_UGV_02_Science_backpack_F",
"B_UAV_06_backpack_F",
"B_UGV_02_Demining_backpack_F",
//FACEWARE
//NVG
//BINOCULARS
"Laserdesignator",
"Laserdesignator_03",
"ACE_MX2A",
//RADIO
//GRENADE
//EXPLOSIVES
"ACE_FlareTripMine_Mag",
"SLAMDirectionalMine_Wire_Mag",
"ATMine_Range_Mag",
//MEDICAL
//MISC ITEMS
"ToolKit",
"ACE_ATragMX",
"ACE_HuntIR_monitor",
"ACE_Kestrel4500",
"ACE_Tripod",
"ACE_UAVBattery",
"ACE_DefusalKit",
//TERMINAL
"itc_land_tablet_rover",
"ITC_ROVER_SIR",
"B_UavTerminal"
	];

	Private _STALKER = [
//PRIMARY
"SMG_05_F", "30Rnd_9x21_Mag_SMG_02", "optic_aco_smg", "muzzle_snds_l",
//SECONDARY
//LAUNCHER
//HELM
"rhsusf_hgu56p_mask_mo",
"rhsusf_hgu56p_mask_skull",
"rhsusf_hgu56p_visor",
"rhsusf_hgu56p_visor_mask",
"rhsusf_hgu56p_visor_mask_mo",
"rhsusf_hgu56p_visor_mask_skull",
"rhsusf_hgu56p_pink",
"rhsusf_hgu56p_mask_pink",
"rhsusf_hgu56p_visor_pink",
"rhsusf_hgu56p_visor_mask_pink",
"rhsusf_hgu56p_saf",
"rhsusf_hgu56p_mask_saf",
"rhsusf_hgu56p_visor_saf",
"rhsusf_hgu56p_visor_mask_saf",
"rhsusf_hgu56p_mask_smiley",
"rhsusf_hgu56p_visor_mask_smiley",
"rhsusf_hgu56p_tan",
"rhsusf_hgu56p_mask_tan",
"rhsusf_hgu56p_visor_tan",
"rhsusf_hgu56p_visor_mask_tan",
"rhsusf_hgu56p_usa",
"rhsusf_hgu56p_visor_usa",
"rhsusf_hgu56p_white",
"rhsusf_hgu56p_visor_white",
"rhsusf_ihadss",
//UNIFORM
"U_B_HeliPilotCoveralls",
"rhssaf_uniform_heli_pilot",
"U_lxWS_SFIA_pilot_O",
"U_B_PilotCoveralls",
//VEST
"V_Rangemaster_belt",
"V_LegStrapBag_olive_F",
"V_LegStrapBag_coyote_F",
"V_LegStrapBag_black_F",
//BACKPACK
//"tfw_ilbe_blade_mc",
//"tfw_ilbe_blade_ocp",
"tfw_ilbe_blade_wd2",
//"tfw_ilbe_DD_alpine",
//"tfw_ilbe_DD_arid",
//"tfw_ilbe_DD_black",
"tfw_ilbe_DD_coy",
"tfw_ilbe_DD_gr",
//"tfw_ilbe_DD_d",
"tfw_ilbe_DD_wd",
//"tfw_ilbe_DD_mct",
//"tfw_ilbe_DD_mc",
//"tfw_ilbe_DD_ocp",
"tfw_ilbe_DD_wd2",
//"tfw_ilbe_whip_alpine",
//"tfw_ilbe_whip_arid",
//"tfw_ilbe_whip_black",
"tfw_ilbe_whip_coy",
"tfw_ilbe_whip_gr",
//"tfw_ilbe_whip_d",
"tfw_ilbe_whip_wd",
//"tfw_ilbe_whip_mct",
//"tfw_ilbe_whip_mc",
//"tfw_ilbe_whip_ocp",
"tfw_ilbe_whip_wd2",
//FACEWARE
//NVG
//BINOCULARS
"Laserdesignator",
"Laserdesignator_03",
"ACE_MX2A",
//RADIO
//GRENADE
//EXPLOSIVES
//MEDICAL
//MISC ITEMS
"ToolKit",
//TERMINAL
"itc_land_tablet_rover",
"ITC_ROVER_SIR",
"B_UavTerminal"
	];

	switch (_Role) do {
	  case "CO": {
	    _GearToAdd = _DefaultGear + _CO;
	  };
	  case "SL": {
	    _GearToAdd = _DefaultGear + _SL;
	  };
	  case "MEDIC": {
	    _GearToAdd = _DefaultGear + _MEDIC;
	  };
	  case "FTL": {
	    _GearToAdd = _DefaultGear + _FTL;
	  };
	  case "AUTORIFLEMAN": {
	    _GearToAdd = _DefaultGear + _AUTORIFLEMAN;
	  };
	  case "AT": {
	    _GearToAdd = _DefaultGear + _AT;
    };
	  case "GRENADIER": {
	    _GearToAdd = _DefaultGear + _GRENADIER;
    };
	  case "RIFLEMAN": {
	    _GearToAdd = _DefaultGear + _RIFLEMAN;
    };
    case "WARPIG": {
	    _GearToAdd = _DefaultGear + _WARPIG;
	  };
		case "OGRE": {
	    _GearToAdd = _DefaultGear + _OGRE;
	  };
	  case "STALKER": {
	    _GearToAdd = _DefaultGear + _STALKER;
	  };
	  default {
	    _GearToAdd = _DefaultGear + ["ACE_Banana"];
	  };
	};

	[_box, false] call ace_arsenal_fnc_removeBox;
	[_box, _GearToAdd, false] call ace_arsenal_fnc_initBox;
}