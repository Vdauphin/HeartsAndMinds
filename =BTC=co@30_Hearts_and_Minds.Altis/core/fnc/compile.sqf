/////////////////////SERVER\\\\\\\\\\\\\\\\\\\\\
if (isServer) then {
    //CACHE
    btc_fnc_cache_find_pos = compile preprocessFileLineNumbers "core\fnc\cache\find_pos.sqf";
    btc_fnc_cache_create = compile preprocessFileLineNumbers "core\fnc\cache\create.sqf";
    btc_fnc_cache_create_attachto = compile preprocessFileLineNumbers "core\fnc\cache\create_attachto.sqf";
    btc_fnc_cache_init = compile preprocessFileLineNumbers "core\fnc\cache\init.sqf";

    //COMMON
    btc_fnc_check_los = compile preprocessFileLineNumbers "core\fnc\common\check_los.sqf";
    btc_fnc_create_composition = compile preprocessFileLineNumbers "core\fnc\common\create_composition.sqf";
    btc_fnc_house_addWP = compile preprocessFileLineNumbers "core\fnc\common\house_addWP.sqf";
    btc_fnc_set_damage = compile preprocessFileLineNumbers "core\fnc\common\set_damage.sqf";
    btc_fnc_road_direction = compile preprocessFileLineNumbers "core\fnc\common\road_direction.sqf";
    btc_fnc_findsafepos = compile preprocessFileLineNumbers "core\fnc\common\findsafepos.sqf";
    btc_fnc_find_closecity = compile preprocessFileLineNumbers "core\fnc\common\find_closecity.sqf";
    btc_fnc_delete = compile preprocessFileLineNumbers "core\fnc\common\delete.sqf";
    btc_fnc_deleteEntities = compile preprocessFileLineNumbers "core\fnc\common\deleteEntities.sqf";
    btc_fnc_final_phase = compile preprocessFileLineNumbers "core\fnc\common\final_phase.sqf";
    btc_fnc_findPosOutsideRock = compile preprocessFileLineNumbers "core\fnc\common\findposoutsiderock.sqf";
    btc_fnc_set_groupsOwner = compile preprocessFileLineNumbers "core\fnc\common\set_groupsOwner.sqf";
    btc_fnc_typeOf = compile preprocessFileLineNumbers "core\fnc\common\typeOf.sqf";
    btc_fnc_getVehProperties = compile preprocessFileLineNumbers "core\fnc\common\getVehProperties.sqf";
    btc_fnc_setVehProperties = compile preprocessFileLineNumbers "core\fnc\common\setVehProperties.sqf";

    //CHEM
    btc_fnc_chem_checkLoop = compile preprocessFileLineNumbers "core\fnc\chem\checkLoop.sqf";
    btc_fnc_chem_propagate = compile preprocessFileLineNumbers "core\fnc\chem\propagate.sqf";
    btc_fnc_chem_handleShower = compile preprocessFileLineNumbers "core\fnc\chem\handleShower.sqf";

    //SPECT
    btc_fnc_spect_checkLoop = compile preprocessFileLineNumbers "core\fnc\spect\checkLoop.sqf";
    btc_fnc_spect_electronicFailure = compile preprocessFileLineNumbers "core\fnc\spect\electronicFailure.sqf";

    //CITY
    btc_fnc_city_activate = compile preprocessFileLineNumbers "core\fnc\city\activate.sqf";
    btc_fnc_city_create = compile preprocessFileLineNumbers "core\fnc\city\create.sqf";
    btc_fnc_city_de_activate = compile preprocessFileLineNumbers "core\fnc\city\de_activate.sqf";
    btc_fnc_city_set_clear = compile preprocessFileLineNumbers "core\fnc\city\set_clear.sqf";
    btc_fnc_city_trigger_player_side = compile preprocessFileLineNumbers "core\fnc\city\trigger_player_side.sqf";
    btc_fnc_city_findPos = compile preprocessFileLineNumbers "core\fnc\city\findPos.sqf";
    btc_fnc_city_cleanUp = compile preprocessFileLineNumbers "core\fnc\city\cleanUp.sqf";

    //CIV
    btc_fnc_civ_add_weapons = compile preprocessFileLineNumbers "core\fnc\civ\add_weapons.sqf";
    btc_fnc_civ_add_grenade = compile preprocessFileLineNumbers "core\fnc\civ\add_grenade.sqf";
    btc_fnc_civ_get_weapons = compile preprocessFileLineNumbers "core\fnc\civ\get_weapons.sqf";
    btc_fnc_civ_get_grenade = compile preprocessFileLineNumbers "core\fnc\civ\get_grenade.sqf";
    btc_fnc_civ_populate = compile preprocessFileLineNumbers "core\fnc\civ\populate.sqf";
    btc_fnc_civ_create_patrol = compile preprocessFileLineNumbers "core\fnc\civ\create_patrol.sqf";
    btc_fnc_civ_unit_create = compile preprocessFileLineNumbers "core\fnc\civ\unit_create.sqf";
    btc_fnc_civ_CuratorCivPlaced_s = compile preprocessFileLineNumbers "core\fnc\civ\CuratorCivPlaced_s.sqf";
    btc_fnc_civ_evacuate = compile preprocessFileLineNumbers "core\fnc\civ\evacuate.sqf";

    //DATA
    btc_fnc_data_add_group = compile preprocessFileLineNumbers "core\fnc\data\add_group.sqf";
    btc_fnc_data_get_group = compile preprocessFileLineNumbers "core\fnc\data\get_group.sqf";
    btc_fnc_data_spawn_group = compile preprocessFileLineNumbers "core\fnc\data\spawn_group.sqf";

    //DB
    btc_fnc_db_save = compile preprocessFileLineNumbers "core\fnc\db\save.sqf";
    btc_fnc_db_delete = compile preprocessFileLineNumbers "core\fnc\db\delete.sqf";
    btc_fnc_db_autosave = compile preprocessFileLineNumbers "core\fnc\db\autosave.sqf";
    btc_fnc_db_loadObjectStatus = compile preprocessFileLineNumbers "core\fnc\db\loadObjectStatus.sqf";
    btc_fnc_db_saveObjectStatus = compile preprocessFileLineNumbers "core\fnc\db\saveObjectStatus.sqf";
    btc_fnc_db_loadCargo = compile preprocessFileLineNumbers "core\fnc\db\loadcargo.sqf";

    //EH
    btc_fnc_eh_veh_add_respawn = compile preprocessFileLineNumbers "core\fnc\eh\veh_add_respawn.sqf";
    btc_fnc_eh_veh_killed = compile preprocessFileLineNumbers "core\fnc\eh\veh_killed.sqf";
    btc_fnc_eh_veh_respawn = compile preprocessFileLineNumbers "core\fnc\eh\veh_respawn.sqf";
    btc_fnc_eh_handledisconnect = compile preprocessFileLineNumbers "core\fnc\eh\handledisconnect.sqf";
    btc_fnc_eh_server = compile preprocessFileLineNumbers "core\fnc\eh\server.sqf";

    //IED
    btc_fnc_ied_boom = compile preprocessFileLineNumbers "core\fnc\ied\boom.sqf";
    btc_fnc_ied_check = compile preprocessFileLineNumbers "core\fnc\ied\check.sqf";
    btc_fnc_ied_checkLoop = compile preprocessFileLineNumbers "core\fnc\ied\checkLoop.sqf";
    btc_fnc_ied_create = compile preprocessFileLineNumbers "core\fnc\ied\create.sqf";
    btc_fnc_ied_fired_near = compile preprocessFileLineNumbers "core\fnc\ied\fired_near.sqf";
    btc_fnc_ied_init_area = compile preprocessFileLineNumbers "core\fnc\ied\init_area.sqf";
    btc_fnc_ied_suicider_active = compile preprocessFileLineNumbers "core\fnc\ied\suicider_active.sqf";
    btc_fnc_ied_suicider_activeLoop = compile preprocessFileLineNumbers "core\fnc\ied\suicider_activeLoop.sqf";
    btc_fnc_ied_suicider_create = compile preprocessFileLineNumbers "core\fnc\ied\suicider_create.sqf";
    btc_fnc_ied_suiciderLoop = compile preprocessFileLineNumbers "core\fnc\ied\suiciderLoop.sqf";
    btc_fnc_ied_allahu_akbar = compile preprocessFileLineNumbers "core\fnc\ied\allahu_akbar.sqf";
    btc_fnc_ied_drone_active = compile preprocessFileLineNumbers "core\fnc\ied\drone_active.sqf";
    btc_fnc_ied_drone_create = compile preprocessFileLineNumbers "core\fnc\ied\drone_create.sqf";
    btc_fnc_ied_droneLoop = compile preprocessFileLineNumbers "core\fnc\ied\droneLoop.sqf";
    btc_fnc_ied_drone_fire = compile preprocessFileLineNumbers "core\fnc\ied\drone_fire.sqf";
    btc_fnc_ied_randomRoadPos = compile preprocessFileLineNumbers "core\fnc\ied\randomRoadPos.sqf";

    //INFO
    btc_fnc_info_cache = compile preprocessFileLineNumbers "core\fnc\info\cache.sqf";
    btc_fnc_info_give_intel = compile preprocessFileLineNumbers "core\fnc\info\give_intel.sqf";
    btc_fnc_info_has_intel = compile preprocessFileLineNumbers "core\fnc\info\has_intel.sqf";
    btc_fnc_info_hideout = compile preprocessFileLineNumbers "core\fnc\info\hideout.sqf";
    btc_fnc_info_cacheMarker = compile preprocessFileLineNumbers "core\fnc\info\cacheMarker.sqf";
    btc_fnc_info_path = compile preprocessFileLineNumbers "core\fnc\info\path.sqf";

    //FOB
    btc_fnc_fob_create_s = compile preprocessFileLineNumbers "core\fnc\fob\create_s.sqf";
    btc_fnc_fob_dismantle_s = compile preprocessFileLineNumbers "core\fnc\fob\dismantle_s.sqf";
    btc_fnc_fob_init = compile preprocessFileLineNumbers "core\fnc\fob\init.sqf";
    btc_fnc_fob_killed = compile preprocessFileLineNumbers "core\fnc\fob\killed.sqf";

    //MIL
    btc_fnc_mil_addWP = compile preprocessFileLineNumbers "core\fnc\mil\addWP.sqf";
    btc_fnc_mil_check_cap = compile preprocessFileLineNumbers "core\fnc\mil\check_cap.sqf";
    btc_fnc_mil_create_group = compile preprocessFileLineNumbers "core\fnc\mil\create_group.sqf";
    btc_fnc_mil_hd_hideout = compile preprocessFileLineNumbers "core\fnc\mil\hd_hideout.sqf";
    btc_fnc_mil_create_hideout = compile preprocessFileLineNumbers "core\fnc\mil\create_hideout.sqf";
    btc_fnc_mil_create_hideout_composition = compile preprocessFileLineNumbers "core\fnc\mil\create_hideout_composition.sqf";
    btc_fnc_mil_create_static = compile preprocessFileLineNumbers "core\fnc\mil\create_static.sqf";
    btc_fnc_mil_create_patrol = compile preprocessFileLineNumbers "core\fnc\mil\create_patrol.sqf";
    btc_fnc_mil_send = compile preprocessFileLineNumbers "core\fnc\mil\send.sqf";
    btc_fnc_mil_set_skill = compile preprocessFileLineNumbers "core\fnc\mil\set_skill.sqf";
    btc_fnc_mil_unit_create = compile preprocessFileLineNumbers "core\fnc\mil\unit_create.sqf";
    btc_fnc_mil_CuratorMilPlaced_s = compile preprocessFileLineNumbers "core\fnc\mil\CuratorMilPlaced_s.sqf";
    btc_fnc_mil_getStructures = compile preprocessFileLineNumbers "core\fnc\mil\getStructures.sqf";
    btc_fnc_mil_getBuilding = compile preprocessFileLineNumbers "core\fnc\mil\getBuilding.sqf";
    btc_fnc_mil_add_eh = compile preprocessFileLineNumbers "core\fnc\mil\add_eh.sqf";
    btc_fnc_mil_createVehicle = compile preprocessFileLineNumbers "core\fnc\mil\createVehicle.sqf";
    btc_fnc_mil_createUnits = compile preprocessFileLineNumbers "core\fnc\mil\createUnits.sqf";

    //PATROL
    btc_fnc_patrol_playersInAreaCityGroup = compile preprocessFileLineNumbers "core\fnc\patrol\playersInAreaCityGroup.sqf";
    btc_fnc_patrol_eh_remove = compile preprocessFileLineNumbers "core\fnc\patrol\eh_remove.sqf";
    btc_fnc_patrol_usefulCity = compile preprocessFileLineNumbers "core\fnc\patrol\usefulCity.sqf";
    btc_fnc_patrol_WPCheck = compile preprocessFileLineNumbers "core\fnc\patrol\WPCheck.sqf";
    btc_fnc_patrol_init = compile preprocessFileLineNumbers "core\fnc\patrol\init.sqf";
    btc_fnc_patrol_addWP = compile preprocessFileLineNumbers "core\fnc\patrol\addWP.sqf";

    //REP
    btc_fnc_rep_add_eh = compile preprocessFileLineNumbers "core\fnc\rep\add_eh.sqf";
    btc_fnc_rep_call_militia = compile preprocessFileLineNumbers "core\fnc\rep\call_militia.sqf";
    btc_fnc_rep_change = compile preprocessFileLineNumbers "core\fnc\rep\change.sqf";
    btc_fnc_rep_eh_effects = compile preprocessFileLineNumbers "core\fnc\rep\eh_effects.sqf";
    btc_fnc_rep_hh = compile preprocessFileLineNumbers "core\fnc\rep\hh.sqf";
    btc_fnc_rep_firednear = compile preprocessFileLineNumbers "core\fnc\rep\firednear.sqf";
    btc_fnc_rep_remove_eh = compile preprocessFileLineNumbers "core\fnc\rep\remove_eh.sqf";
    btc_fnc_rep_buildingchanged = compile preprocessFileLineNumbers "core\fnc\rep\buildingchanged.sqf";
    btc_fnc_rep_explosives_defuse = compile preprocessFileLineNumbers "core\fnc\rep\explosives_defuse.sqf";

    //SIDE
    btc_fnc_side_create = compile preprocessFileLineNumbers "core\fnc\side\create.sqf";
    btc_fnc_side_get_city = compile preprocessFileLineNumbers "core\fnc\side\get_city.sqf";
    btc_fnc_side_mines = compile preprocessFileLineNumbers "core\fnc\side\mines.sqf";
    btc_fnc_side_supply = compile preprocessFileLineNumbers "core\fnc\side\supply.sqf";
    btc_fnc_side_vehicle = compile preprocessFileLineNumbers "core\fnc\side\vehicle.sqf";
    btc_fnc_side_civtreatment = compile preprocessFileLineNumbers "core\fnc\side\civtreatment.sqf";
    btc_fnc_side_tower = compile preprocessFileLineNumbers "core\fnc\side\tower.sqf";
    btc_fnc_side_checkpoint = compile preprocessFileLineNumbers "core\fnc\side\checkpoint.sqf";
    btc_fnc_side_civtreatment_boat = compile preprocessFileLineNumbers "core\fnc\side\civtreatment_boat.sqf";
    btc_fnc_side_underwater_generator= compile preprocessFileLineNumbers "core\fnc\side\underwater_generator.sqf";
    btc_fnc_side_convoy = compile preprocessFileLineNumbers "core\fnc\side\convoy.sqf";
    btc_fnc_side_rescue = compile preprocessFileLineNumbers "core\fnc\side\rescue.sqf";
    btc_fnc_side_capture_officer = compile preprocessFileLineNumbers "core\fnc\side\capture_officer.sqf";
    btc_fnc_side_hostage = compile preprocessFileLineNumbers "core\fnc\side\hostage.sqf";
    btc_fnc_side_hack = compile preprocessFileLineNumbers "core\fnc\side\hack.sqf";
    btc_fnc_side_kill = compile preprocessFileLineNumbers "core\fnc\side\kill.sqf";
    btc_fnc_side_chemicalLeak = compile preprocessFileLineNumbers "core\fnc\side\chemicalLeak.sqf";
    btc_fnc_side_EMP = compile preprocessFileLineNumbers "core\fnc\side\EMP.sqf";

    //LOG
    btc_fnc_log_CuratorObjectPlaced_s = compile preprocessFileLineNumbers "core\fnc\log\CuratorObjectPlaced_s.sqf";
    btc_fnc_log_createVehicle = compile preprocessFileLineNumbers "core\fnc\log\createVehicle.sqf";
    btc_fnc_log_getRearmMagazines = compile preprocessFileLineNumbers "core\fnc\log\getRearmMagazines.sqf";
    btc_fnc_log_init = compile preprocessFileLineNumbers "core\fnc\log\init.sqf";
    btc_fnc_log_setCargo = compile preprocessFileLineNumbers "core\fnc\log\setCargo.sqf";
    btc_fnc_log_server_delete = compile preprocessFileLineNumbers "core\fnc\log\server_delete.sqf";
    btc_fnc_log_create_s = compile preprocessFileLineNumbers "core\fnc\log\create_s.sqf";
    btc_fnc_log_get_cc = compile preprocessFileLineNumbers "core\fnc\log\get_cc.sqf";
    btc_fnc_log_get_rc = compile preprocessFileLineNumbers "core\fnc\log\get_rc.sqf";
    btc_fnc_log_server_repair_wreck = compile preprocessFileLineNumbers "core\fnc\log\server_repair_wreck.sqf";

    //DEAF
    btc_fnc_deaf_earringing = compile preprocessFileLineNumbers "core\fnc\deaf\earringing.sqf";

    //TASK
    btc_fnc_task_create = compile preprocessFileLineNumbers "core\fnc\task\create.sqf";
    btc_fnc_task_setState = compile preprocessFileLineNumbers "core\fnc\task\setState.sqf";
};

/////////////////////CLIENT AND SERVER\\\\\\\\\\\\\\\\\\\\\

//CACHE
btc_fnc_cache_hd_cache = compile preprocessFileLineNumbers "core\fnc\cache\hd_cache.sqf";

//COMMON
btc_fnc_find_veh_with_turret = compile preprocessFileLineNumbers "core\fnc\common\find_veh_with_turret.sqf";
btc_fnc_get_class = compile preprocessFileLineNumbers "core\fnc\common\get_class.sqf";
btc_fnc_randomize_pos = compile preprocessFileLineNumbers "core\fnc\common\randomize_pos.sqf";
btc_fnc_getHouses = compile preprocessFileLineNumbers "core\fnc\common\getHouses.sqf";
btc_fnc_house_addWP_loop = compile preprocessFileLineNumbers "core\fnc\common\house_addWP_loop.sqf";

//CHEM
btc_fnc_chem_damage = compile preprocessFileLineNumbers "core\fnc\chem\damage.sqf";
btc_fnc_chem_deconShowerAnimLarge = {(_this select 0) setVariable ["BIN_Shower_Stop",false]; _this call BIN_fnc_deconShowerAnimLarge;};

//DEBUG
btc_fnc_debug_message = compile preprocessFileLineNumbers "core\fnc\debug\message.sqf";

//DB
btc_fnc_db_add_veh = compile preprocessFileLineNumbers "core\fnc\db\add_veh.sqf";
//EH
btc_fnc_eh_persistOnLocalityChange = compile preprocessFileLineNumbers "core\fnc\eh\persistOnLocalityChange.sqf";
btc_fnc_eh_removePersistOnLocalityChange = compile preprocessFileLineNumbers "core\fnc\eh\removePersistOnLocalityChange.sqf";
btc_fnc_eh_trackItem = compile preprocessFileLineNumbers "core\fnc\eh\trackItem.sqf";

//CIV
btc_fnc_civ_class = compile preprocessFileLineNumbers "core\fnc\civ\class.sqf";
btc_fnc_civ_addWP = compile preprocessFileLineNumbers "core\fnc\civ\addWP.sqf";

//IED
btc_fnc_ied_belt = compile preprocessFileLineNumbers "core\fnc\ied\belt.sqf";
btc_fnc_ied_suiciderKilled = compile preprocessFileLineNumbers "core\fnc\ied\suiciderKilled.sqf";

//INT
btc_fnc_int_orders_give = compile preprocessFileLineNumbers "core\fnc\int\orders_give.sqf";
btc_fnc_int_orders_behaviour = compile preprocessFileLineNumbers "core\fnc\int\orders_behaviour.sqf";
btc_fnc_int_ask_var = compile preprocessFileLineNumbers "core\fnc\int\ask_var.sqf";

//LOG
btc_fnc_log_place_destroy_camera = compile preprocessFileLineNumbers "core\fnc\log\place_destroy_camera.sqf";

//MIL
btc_fnc_mil_class = compile preprocessFileLineNumbers "core\fnc\mil\class.sqf";
btc_fnc_mil_ammoUsage = compile preprocessFileLineNumbers "core\fnc\mil\ammoUsage.sqf";
btc_fnc_mil_unit_killed = compile preprocessFileLineNumbers "core\fnc\mil\unit_killed.sqf";

//PATROL
btc_fnc_patrol_eh = compile preprocessFileLineNumbers "core\fnc\patrol\eh.sqf";
btc_fnc_patrol_disabled = compile preprocessFileLineNumbers "core\fnc\patrol\disabled.sqf";

//REP
btc_fnc_rep_hd = compile preprocessFileLineNumbers "core\fnc\rep\hd.sqf";
btc_fnc_rep_killed = compile preprocessFileLineNumbers "core\fnc\rep\killed.sqf";

//TOW
btc_fnc_tow_hook = compile preprocessFileLineNumbers "core\fnc\tow\hook.sqf";
btc_fnc_tow_check = compile preprocessFileLineNumbers "core\fnc\tow\check.sqf";

//ARSENAL
btc_fnc_arsenal_ammoUsage = compile preprocessFileLineNumbers "core\fnc\arsenal\ammoUsage.sqf";

/////////////////////CLIENT\\\\\\\\\\\\\\\\\\\\\
if (!isDedicated) then {
    //COMMON
    btc_fnc_end_mission = compile preprocessFileLineNumbers "core\fnc\common\end_mission.sqf";
    btc_fnc_get_cardinal = compile preprocessFileLineNumbers "core\fnc\common\get_cardinal.sqf";
    btc_fnc_show_hint = compile preprocessFileLineNumbers "core\fnc\common\show_hint.sqf";
    btc_fnc_intro = compile preprocessFileLineNumbers "core\fnc\common\intro.sqf";
    btc_fnc_set_markerTextLocal = compile preprocessFileLineNumbers "core\fnc\common\set_markerTextLocal.sqf";
    btc_fnc_showSubtitle = compile preprocessFileLineNumbers "core\fnc\common\showSubtitle.sqf";
    btc_fnc_strategicMapOpen = compile preprocessFileLineNumbers "core\fnc\common\strategicMapOpen.sqf";
    btc_fnc_get_composition = compile preprocessFileLineNumbers "core\fnc\common\get_composition.sqf";
    btc_fnc_checkArea = compile preprocessFileLineNumbers "core\fnc\common\checkArea.sqf";
    btc_fnc_typeOfPreview = compile preprocessFileLineNumbers "core\fnc\common\typeOfPreview.sqf";

    //CHEM
    btc_fnc_chem_biopsy = compile preprocessFileLineNumbers "core\fnc\chem\biopsy.sqf";
    btc_fnc_chem_damageLoop = compile preprocessFileLineNumbers "core\fnc\chem\damageLoop.sqf";
    btc_fnc_chem_ehDetector = compile preprocessFileLineNumbers "core\fnc\chem\ehDetector.sqf";
    btc_fnc_chem_updateDetector = compile preprocessFileLineNumbers "core\fnc\chem\updateDetector.sqf";

    //DEBUG
    btc_fnc_debug_marker = compile preprocessFileLineNumbers "core\fnc\debug\marker.sqf";
    btc_fnc_debug_units = compile preprocessFileLineNumbers "core\fnc\debug\units.sqf";
    btc_fnc_debug_fps = compile preprocessFileLineNumbers "core\fnc\debug\fps.sqf";
    btc_fnc_debug_graph = compile preprocessFileLineNumbers "core\fnc\debug\graph.sqf";

    //CIV
    btc_fnc_civ_add_leaflets = compile preprocessFileLineNumbers "core\fnc\civ\add_leaflets.sqf";
    btc_fnc_civ_leaflets = compile preprocessFileLineNumbers "core\fnc\civ\leaflets.sqf";

    //IED
    btc_fnc_ied_effects = compile preprocessFileLineNumbers "core\fnc\ied\effects.sqf";
    btc_fnc_ied_effect_smoke = compile preprocessFileLineNumbers "core\fnc\ied\effect_smoke.sqf";
    btc_fnc_ied_effect_color_smoke = compile preprocessFileLineNumbers "core\fnc\ied\effect_color_smoke.sqf";
    btc_fnc_ied_effect_rocks = compile preprocessFileLineNumbers "core\fnc\ied\effect_rocks.sqf";
    btc_fnc_ied_effect_blurEffect = compile preprocessFileLineNumbers "core\fnc\ied\effect_blurEffect.sqf";
    btc_fnc_ied_effect_shock_wave = compile preprocessFileLineNumbers "core\fnc\ied\effect_shock_wave.sqf";

    //EH
    btc_fnc_eh_player_respawn = compile preprocessFileLineNumbers "core\fnc\eh\player_respawn.sqf";
    btc_fnc_eh_CuratorObjectPlaced = compile preprocessFileLineNumbers "core\fnc\eh\CuratorObjectPlaced.sqf";
    btc_fnc_eh_player = compile preprocessFileLineNumbers "core\fnc\eh\player.sqf";

    //FOB
    btc_fnc_fob_create = compile preprocessFileLineNumbers "core\fnc\fob\create.sqf";
    btc_fnc_fob_redeploy = compile preprocessFileLineNumbers "core\fnc\fob\redeploy.sqf";

    //INT
    btc_fnc_int_add_actions = compile preprocessFileLineNumbers "core\fnc\int\add_actions.sqf";
    btc_fnc_int_orders = compile preprocessFileLineNumbers "core\fnc\int\orders.sqf";
    btc_fnc_int_shortcuts = compile preprocessFileLineNumbers "core\fnc\int\shortcuts.sqf";
    btc_fnc_int_terminal = compile preprocessFileLineNumbers "core\fnc\int\terminal.sqf";

    //INFO
    btc_fnc_info_ask = compile preprocessFileLineNumbers "core\fnc\info\ask.sqf";
    btc_fnc_info_hideout_asked = compile preprocessFileLineNumbers "core\fnc\info\hideout_asked.sqf";
    btc_fnc_info_search_for_intel = compile preprocessFileLineNumbers "core\fnc\info\search_for_intel.sqf";
    btc_fnc_info_troops = compile preprocessFileLineNumbers "core\fnc\info\troops.sqf";
    btc_fnc_info_ask_reputation = compile preprocessFileLineNumbers "core\fnc\info\ask_reputation.sqf";
    btc_fnc_info_cachePicture = compile preprocessFileLineNumbers "core\fnc\info\cachePicture.sqf";

    //LIFT
    btc_fnc_lift_check = compile preprocessFileLineNumbers "core\fnc\lift\check.sqf";
    btc_fnc_lift_deployRopes = compile preprocessFileLineNumbers "core\fnc\lift\deployRopes.sqf";
    btc_fnc_lift_destroyRopes = compile preprocessFileLineNumbers "core\fnc\lift\destroyRopes.sqf";
    btc_fnc_lift_hook = compile preprocessFileLineNumbers "core\fnc\lift\hook.sqf";
    btc_fnc_lift_hookFake = compile preprocessFileLineNumbers "core\fnc\lift\hookFake.sqf";
    btc_fnc_lift_hud = compile preprocessFileLineNumbers "core\fnc\lift\hud.sqf";
    btc_fnc_lift_hudLoop = compile preprocessFileLineNumbers "core\fnc\lift\hudLoop.sqf";

    //LOG
    btc_fnc_log_get_corner_points = compile preprocessFileLineNumbers "core\fnc\log\get_corner_points.sqf";
    btc_fnc_log_delete = compile preprocessFileLineNumbers "core\fnc\log\delete.sqf";
    btc_fnc_log_create = compile preprocessFileLineNumbers "core\fnc\log\create.sqf";
    btc_fnc_log_create_apply = compile preprocessFileLineNumbers "core\fnc\log\create_apply.sqf";
    btc_fnc_log_create_load = compile preprocessFileLineNumbers "core\fnc\log\create_load.sqf";
    btc_fnc_log_create_change_target = compile preprocessFileLineNumbers "core\fnc\log\create_change_target.sqf";
    btc_fnc_log_place_create_camera = compile preprocessFileLineNumbers "core\fnc\log\place_create_camera.sqf";
    btc_fnc_log_place = compile preprocessFileLineNumbers "core\fnc\log\place.sqf";
    btc_fnc_log_place_key_down = compile preprocessFileLineNumbers "core\fnc\log\place_key_down.sqf";
    btc_fnc_log_repair_wreck = compile preprocessFileLineNumbers "core\fnc\log\repair_wreck.sqf";
    btc_fnc_log_copy = compile preprocessFileLineNumbers "core\fnc\log\copy.sqf";
    btc_fnc_log_paste = compile preprocessFileLineNumbers "core\fnc\log\paste.sqf";
    btc_fnc_log_refuelSource = compile preprocessFileLineNumbers "core\fnc\log\refuelSource.sqf";

    //REP
    btc_fnc_rep_treatment = compile preprocessFileLineNumbers "core\fnc\rep\treatment.sqf";

    //SPECT
    btc_fnc_spect_updateDevice = compile preprocessFileLineNumbers "core\fnc\spect\updateDevice.sqf";
    btc_fnc_spect_frequencies = compile preprocessFileLineNumbers "core\fnc\spect\frequencies.sqf";
    btc_fnc_spect_disableDevice = compile preprocessFileLineNumbers "core\fnc\spect\disableDevice.sqf";

    //ARSENAL
    btc_fnc_arsenal_data = compile preprocessFileLineNumbers "core\fnc\arsenal\data.sqf";
    btc_fnc_arsenal_garage = compile preprocessFileLineNumbers "core\fnc\arsenal\garage.sqf";
    btc_fnc_arsenal_loadout = compile preprocessFileLineNumbers "core\fnc\arsenal\loadout.sqf";
    btc_fnc_arsenal_trait = compile preprocessFileLineNumbers "core\fnc\arsenal\trait.sqf";
    btc_fnc_arsenal_ammoUsage = compile preprocessFileLineNumbers "core\fnc\arsenal\ammoUsage.sqf";
    btc_fnc_arsenal_weaponsFilter = compile preprocessFileLineNumbers "core\fnc\arsenal\weaponsfilter.sqf";

    //TASK
    btc_fnc_task_setDescription = compile preprocessFileLineNumbers "core\fnc\task\setDescription.sqf";
    btc_fnc_task_abort = compile preprocessFileLineNumbers "core\fnc\task\abort.sqf";

    //TOW
    btc_fnc_tow_ropeCreate = compile preprocessFileLineNumbers "core\fnc\tow\ropeCreate.sqf";
    btc_fnc_tow_hitch_points = compile preprocessFileLineNumbers "core\fnc\tow\hitch_points.sqf";
    btc_fnc_tow_unhook = compile preprocessFileLineNumbers "core\fnc\tow\unhook.sqf";
};
