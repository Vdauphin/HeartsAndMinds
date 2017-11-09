/////////////////////SERVER\\\\\\\\\\\\\\\\\\\\\
if (isServer) then {
	//CACHE
	btc_fnc_cache_find_pos = compile preprocessFileLineNumbers "core\fnc\cache\find_pos.sqf";
	btc_fnc_cache_hd_cache = compile preprocessFileLineNumbers "core\fnc\cache\hd_cache.sqf";
	btc_fnc_cache_spawn = compile preprocessFileLineNumbers "core\fnc\cache\spawn.sqf";
	btc_fnc_cache_create = compile preprocessFileLineNumbers "core\fnc\cache\create.sqf";

	//COMMON
	btc_fnc_check_los = compile preprocessFileLineNumbers "core\fnc\common\check_los.sqf";
	btc_fnc_clean_up = compile preprocessFileLineNumbers "core\fnc\common\clean_up.sqf";
	btc_fnc_create_composition = compile preprocessFileLineNumbers "core\fnc\common\create_composition.sqf";
	btc_fnc_create_attachto = compile preprocessFileLineNumbers "core\fnc\common\create_attachto.sqf";
	btc_fnc_getHouses = compile preprocessFileLineNumbers "core\fnc\common\getHouses.sqf";
	btc_fnc_house_addWP = compile preprocessFileLineNumbers "core\fnc\common\house_addWP.sqf";
	btc_fnc_house_addWP_loop = compile preprocessFileLineNumbers "core\fnc\common\house_addWP_loop.sqf";
	btc_fnc_randomize_pos = compile preprocessFileLineNumbers "core\fnc\common\randomize_pos.sqf";
	btc_fnc_set_owner = compile preprocessFileLineNumbers "core\fnc\common\set_owner.sqf";
	btc_fnc_task_patrol = compile preprocessFileLineNumbers "core\fnc\common\task_patrol.sqf";
	btc_fnc_set_damage = compile preprocessFileLineNumbers "core\fnc\common\set_damage.sqf";
	btc_fnc_road_direction = compile preprocessFileLineNumbers "core\fnc\common\road_direction.sqf";
	btc_fnc_findsafepos = compile preprocessFileLineNumbers "core\fnc\common\findsafepos.sqf";
	btc_fnc_deleteTestObj = compile preprocessFileLineNumbers "core\fnc\common\deleteTestObj.sqf";
	btc_fnc_get_owners = compile preprocessFileLineNumbers "core\fnc\common\get_owners.sqf";
	btc_fnc_set_groupowner = compile preprocessFileLineNumbers "core\fnc\common\set_groupowner.sqf";
	btc_fnc_find_closecity = compile preprocessFileLineNumbers "core\fnc\common\find_closecity.sqf";
	btc_fnc_deletegroup = compile preprocessFileLineNumbers "core\fnc\common\deletegroup.sqf";
	btc_fnc_delete = compile preprocessFileLineNumbers "core\fnc\common\delete.sqf";

	//CITY
	btc_fnc_city_activate = compile preprocessFileLineNumbers "core\fnc\city\activate.sqf";
	btc_fnc_city_create = compile preprocessFileLineNumbers "core\fnc\city\create.sqf";
	btc_fnc_city_de_activate = compile preprocessFileLineNumbers "core\fnc\city\de_activate.sqf";
	btc_fnc_city_set_clear = compile preprocessFileLineNumbers "core\fnc\city\set_clear.sqf";
	btc_fnc_city_trigger_player_side = compile preprocessFileLineNumbers "core\fnc\city\trigger_player_side.sqf";

	//CIV
	btc_fnc_civ_add_weapons = compile preprocessFileLineNumbers "core\fnc\civ\add_weapons.sqf";
	btc_fnc_civ_add_grenade = compile preprocessFileLineNumbers "core\fnc\civ\add_grenade.sqf";
	btc_fnc_civ_addWP = compile preprocessFileLineNumbers "core\fnc\civ\addWP.sqf";
	btc_fnc_civ_create = compile preprocessFileLineNumbers "core\fnc\civ\create.sqf";
	btc_fnc_civ_get_weapons = compile preprocessFileLineNumbers "core\fnc\civ\get_weapons.sqf";
	btc_fnc_civ_get_grenade = compile preprocessFileLineNumbers "core\fnc\civ\get_grenade.sqf";
	btc_fnc_civ_populate = compile preprocessFileLineNumbers "core\fnc\civ\populate.sqf";
	btc_fnc_civ_traffic_add_WP = compile preprocessFileLineNumbers "core\fnc\civ\traffic_add_WP.sqf";
	btc_fnc_civ_traffic_create = compile preprocessFileLineNumbers "core\fnc\civ\traffic_create.sqf";
	btc_fnc_civ_traffic_eh = compile preprocessFileLineNumbers "core\fnc\civ\traffic_eh.sqf";
	btc_fnc_civ_traffic_eh_remove = compile preprocessFileLineNumbers "core\fnc\civ\traffic_eh_remove.sqf";
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

	//EH
	//btc_fnc_eh_helo_respawn = compile preprocessFileLineNumbers "core\fnc\eh\helo_respawn.sqf";
	btc_fnc_eh_veh_add_respawn = compile preprocessFileLineNumbers "core\fnc\eh\veh_add_respawn.sqf";
	btc_fnc_eh_veh_killed = compile preprocessFileLineNumbers "core\fnc\eh\veh_killed.sqf";
	btc_fnc_eh_veh_respawn = compile preprocessFileLineNumbers "core\fnc\eh\veh_respawn.sqf";
	btc_fnc_eh_explosives_defuse = compile preprocessFileLineNumbers "core\fnc\eh\explosives_defuse.sqf";
	btc_fnc_eh_handledisconnect = compile preprocessFileLineNumbers "core\fnc\eh\handledisconnect.sqf";
	btc_fnc_eh_buildingchanged = compile preprocessFileLineNumbers "core\fnc\eh\buildingchanged.sqf";

	//IED
	btc_fnc_ied_boom = compile preprocessFileLineNumbers "core\fnc\ied\boom.sqf";
	btc_fnc_ied_check = compile preprocessFileLineNumbers "core\fnc\ied\check.sqf";
	btc_fnc_ied_create = compile preprocessFileLineNumbers "core\fnc\ied\create.sqf";
	btc_fnc_ied_fired_near = compile preprocessFileLineNumbers "core\fnc\ied\fired_near.sqf";
	btc_fnc_ied_init_area = compile preprocessFileLineNumbers "core\fnc\ied\init_area.sqf";
	btc_fnc_ied_suicider_active = compile preprocessFileLineNumbers "core\fnc\ied\suicider_active.sqf";
	btc_fnc_ied_suicider_create = compile preprocessFileLineNumbers "core\fnc\ied\suicider_create.sqf";
	btc_fnc_ied_allahu_akbar = compile preprocessFileLineNumbers "core\fnc\ied\allahu_akbar.sqf";

	//INFO
	btc_fnc_info_cache = compile preprocessFileLineNumbers "core\fnc\info\cache.sqf";
	btc_fnc_info_give_intel = compile preprocessFileLineNumbers "core\fnc\info\give_intel.sqf";
	btc_fnc_info_has_intel = compile preprocessFileLineNumbers "core\fnc\info\has_intel.sqf";
	btc_fnc_info_hideout = compile preprocessFileLineNumbers "core\fnc\info\hideout.sqf";

	//FOB
	btc_fnc_fob_create_s = compile preprocessFileLineNumbers "core\fnc\fob\create_s.sqf";
	btc_fnc_fob_dismantle_s = compile preprocessFileLineNumbers "core\fnc\fob\dismantle_s.sqf";

	//MIL
	btc_fnc_mil_addWP = compile preprocessFileLineNumbers "core\fnc\mil\addWP.sqf";
	btc_fnc_mil_check_cap = compile preprocessFileLineNumbers "core\fnc\mil\check_cap.sqf";
	btc_fnc_mil_create_group = compile preprocessFileLineNumbers "core\fnc\mil\create_group.sqf";
	btc_fnc_mil_hd_hideout = compile preprocessFileLineNumbers "core\fnc\mil\hd_hideout.sqf";
	//btc_fnc_mil_eh_killed = compile preprocessFileLineNumbers "core\fnc\mil\eh_killed.sqf";
	btc_fnc_mil_create_hideout = compile preprocessFileLineNumbers "core\fnc\mil\create_hideout.sqf";
	btc_fnc_mil_create_hideout_composition = compile preprocessFileLineNumbers "core\fnc\mil\create_hideout_composition.sqf";
	btc_fnc_mil_create_static = compile preprocessFileLineNumbers "core\fnc\mil\create_static.sqf";
	btc_fnc_mil_patrol_create = compile preprocessFileLineNumbers "core\fnc\mil\patrol_create.sqf";
	btc_fnc_mil_patrol_addWP = compile preprocessFileLineNumbers "core\fnc\mil\patrol_addWP.sqf";
	btc_fnc_mil_send = compile preprocessFileLineNumbers "core\fnc\mil\send.sqf";
	btc_fnc_mil_set_skill = compile preprocessFileLineNumbers "core\fnc\mil\set_skill.sqf";
	btc_fnc_mil_unit_create = compile preprocessFileLineNumbers "core\fnc\mil\unit_create.sqf";
	btc_fnc_mil_patrol_eh = compile preprocessFileLineNumbers "core\fnc\mil\patrol_eh.sqf";
	btc_fnc_mil_patrol_eh_remove = compile preprocessFileLineNumbers "core\fnc\mil\patrol_eh_remove.sqf";
	btc_fnc_mil_CuratorMilPlaced_s = compile preprocessFileLineNumbers "core\fnc\mil\CuratorMilPlaced_s.sqf";
	btc_fnc_mil_getStructures = compile preprocessFileLineNumbers "core\fnc\mil\getStructures.sqf";

	//REP
	btc_fnc_rep_add_eh = compile preprocessFileLineNumbers "core\fnc\rep\add_eh.sqf";
	btc_fnc_rep_call_militia = compile preprocessFileLineNumbers "core\fnc\rep\call_militia.sqf";
	btc_fnc_rep_change = compile preprocessFileLineNumbers "core\fnc\rep\change.sqf";
	btc_fnc_rep_eh_effects = compile preprocessFileLineNumbers "core\fnc\rep\eh_effects.sqf";
	btc_fnc_rep_hd = compile preprocessFileLineNumbers "core\fnc\rep\hd.sqf";
	btc_fnc_rep_hh = compile preprocessFileLineNumbers "core\fnc\rep\hh.sqf";
	btc_fnc_rep_killed = compile preprocessFileLineNumbers "core\fnc\rep\killed.sqf";
	btc_fnc_rep_firednear = compile preprocessFileLineNumbers "core\fnc\rep\firednear.sqf";
	btc_fnc_rep_remove_eh = compile preprocessFileLineNumbers "core\fnc\rep\remove_eh.sqf";

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

	//LOG
	btc_fnc_log_CuratorObjectPlaced_s = compile preprocessFileLineNumbers "core\fnc\log\CuratorObjectPlaced_s.sqf";
	btc_fnc_log_createVehicle = compile preprocessFileLineNumbers "core\fnc\log\createVehicle.sqf";
	btc_fnc_log_getRearmMagazines = compile preprocessFileLineNumbers "core\fnc\log\getRearmMagazines.sqf";

	//DEAF
	btc_fnc_deaf_earringing = compile preprocessFileLineNumbers "core\fnc\deaf\earringing.sqf";
};

/////////////////////SERVER AND HEADLESS\\\\\\\\\\\\\\\\\\\\\
if (isServer OR (!isDedicated && !hasInterface)) then {
	//MIL
	btc_fnc_mil_unit_killed = compile preprocessFileLineNumbers "core\fnc\mil\unit_killed.sqf";
	btc_fnc_mil_add_eh = compile preprocessFileLineNumbers "core\fnc\mil\add_eh.sqf";
};

/////////////////////CLIENT AND SERVER\\\\\\\\\\\\\\\\\\\\\

//COMMON
//btc_fnc_veh_track_marker = compile preprocessFileLineNumbers "core\fnc\common\veh_track_marker.sqf";
btc_fnc_find_veh_with_turret = compile preprocessFileLineNumbers "core\fnc\common\find_veh_with_turret.sqf";
btc_fnc_get_class = compile preprocessFileLineNumbers "core\fnc\common\get_class.sqf";

//DB
btc_fnc_db_add_veh = compile preprocessFileLineNumbers "core\fnc\db\add_veh.sqf";

//CIV
btc_fnc_civ_class = compile preprocessFileLineNumbers "core\fnc\civ\class.sqf";

//EH
btc_fnc_eh_unit_init = compile preprocessFileLineNumbers "core\fnc\eh\unit_init.sqf";


//INT
btc_fnc_int_change_var = compile preprocessFileLineNumbers "core\fnc\int\change_var.sqf";
btc_fnc_int_orders_give = compile preprocessFileLineNumbers "core\fnc\int\orders_give.sqf";
btc_fnc_int_orders_behaviour = compile preprocessFileLineNumbers "core\fnc\int\orders_behaviour.sqf";
btc_fnc_int_ans_var = compile preprocessFileLineNumbers "core\fnc\int\ans_var.sqf";
btc_fnc_int_ask_var = compile preprocessFileLineNumbers "core\fnc\int\ask_var.sqf";

//LOG
btc_fnc_log_can_tow = compile preprocessFileLineNumbers "core\fnc\log\can_tow.sqf";
btc_fnc_log_check_cargo = compile preprocessFileLineNumbers "core\fnc\log\check_cargo.sqf";
btc_fnc_log_check_cc = compile preprocessFileLineNumbers "core\fnc\log\check_cc.sqf";
btc_fnc_log_create = compile preprocessFileLineNumbers "core\fnc\log\create.sqf";
btc_fnc_log_create_apply = compile preprocessFileLineNumbers "core\fnc\log\create_apply.sqf";
btc_fnc_log_create_load = compile preprocessFileLineNumbers "core\fnc\log\create_load.sqf";
btc_fnc_log_create_change_target = compile preprocessFileLineNumbers "core\fnc\log\create_change_target.sqf";
btc_fnc_log_create_s = compile preprocessFileLineNumbers "core\fnc\log\create_s.sqf";
btc_fnc_log_hook = compile preprocessFileLineNumbers "core\fnc\log\hook.sqf";
btc_fnc_log_lift_check = compile preprocessFileLineNumbers "core\fnc\log\lift_check.sqf";
btc_fnc_log_lift_deploy_ropes = compile preprocessFileLineNumbers "core\fnc\log\lift_deploy_ropes.sqf";
btc_fnc_log_lift_destroy_ropes = compile preprocessFileLineNumbers "core\fnc\log\lift_destroy_ropes.sqf";
btc_fnc_log_lift_hook = compile preprocessFileLineNumbers "core\fnc\log\lift_hook.sqf";
btc_fnc_log_lift_hook_fake = compile preprocessFileLineNumbers "core\fnc\log\lift_hook_fake.sqf";
btc_fnc_log_lift_hud = compile preprocessFileLineNumbers "core\fnc\log\lift_hud.sqf";
btc_fnc_log_lift_hud_loop = compile preprocessFileLineNumbers "core\fnc\log\lift_hud_loop.sqf";
btc_fnc_log_get_cc = compile preprocessFileLineNumbers "core\fnc\log\get_cc.sqf";
btc_fnc_log_get_rc = compile preprocessFileLineNumbers "core\fnc\log\get_rc.sqf";
btc_fnc_log_load = compile preprocessFileLineNumbers "core\fnc\log\load.sqf";
btc_fnc_log_obj_fall = compile preprocessFileLineNumbers "core\fnc\log\obj_fall.sqf";
btc_fnc_log_paradrop = compile preprocessFileLineNumbers "core\fnc\log\paradrop.sqf";
btc_fnc_log_place = compile preprocessFileLineNumbers "core\fnc\log\place.sqf";
btc_fnc_log_place_create_camera = compile preprocessFileLineNumbers "core\fnc\log\place_create_camera.sqf";
btc_fnc_log_place_destroy_camera = compile preprocessFileLineNumbers "core\fnc\log\place_destroy_camera.sqf";
btc_fnc_log_place_key_down = compile preprocessFileLineNumbers "core\fnc\log\place_key_down.sqf";
btc_fnc_log_repair_wreck = compile preprocessFileLineNumbers "core\fnc\log\repair_wreck.sqf";
btc_fnc_log_select = compile preprocessFileLineNumbers "core\fnc\log\select.sqf";
btc_fnc_log_server_load = compile preprocessFileLineNumbers "core\fnc\log\server_load.sqf";
btc_fnc_log_server_repair_wreck = compile preprocessFileLineNumbers "core\fnc\log\server_repair_wreck.sqf";
btc_fnc_log_server_unload = compile preprocessFileLineNumbers "core\fnc\log\server_unload.sqf";
btc_fnc_log_set_mass = compile preprocessFileLineNumbers "core\fnc\log\set_mass.sqf";
btc_fnc_log_tow = compile preprocessFileLineNumbers "core\fnc\log\tow.sqf";
btc_fnc_log_unhook = compile preprocessFileLineNumbers "core\fnc\log\unhook.sqf";
btc_fnc_log_unload = compile preprocessFileLineNumbers "core\fnc\log\unload.sqf";
btc_fnc_log_getconfigmagazines = compile preprocessFileLineNumbers "core\fnc\log\getconfigmagazines.sqf";
btc_fnc_log_copy = compile preprocessFileLineNumbers "core\fnc\log\copy.sqf";
btc_fnc_log_paste = compile preprocessFileLineNumbers "core\fnc\log\paste.sqf";

//MIL
btc_fnc_mil_class = compile preprocessFileLineNumbers "core\fnc\mil\class.sqf";

//TASK
btc_fnc_task_create = compile preprocessFileLineNumbers "core\fnc\task\create.sqf";
btc_fnc_task_fail = compile preprocessFileLineNumbers "core\fnc\task\fail.sqf";
btc_fnc_task_set_done = compile preprocessFileLineNumbers "core\fnc\task\set_done.sqf";

//SIDE
btc_fnc_side_abort = compile preprocessFileLineNumbers "core\fnc\side\abort.sqf";

/////////////////////CLIENT\\\\\\\\\\\\\\\\\\\\\
if (!isDedicated) then {
	//DB
	btc_fnc_db_request_save = compile preprocessFileLineNumbers "core\fnc\db\request_save.sqf";
	btc_fnc_db_request_delete = compile preprocessFileLineNumbers "core\fnc\db\request_delete.sqf";

	//COMMON
	btc_fnc_end_mission = compile preprocessFileLineNumbers "core\fnc\common\end_mission.sqf";
	btc_fnc_get_cardinal = compile preprocessFileLineNumbers "core\fnc\common\get_cardinal.sqf";
	btc_fnc_is_engineer = compile preprocessFileLineNumbers "core\fnc\common\is_engineer.sqf";
	btc_fnc_marker_debug = compile preprocessFileLineNumbers "core\fnc\common\marker_debug.sqf";
	btc_fnc_systemchat_debug = compile preprocessFileLineNumbers "core\fnc\common\systemchat_debug.sqf";
	btc_fnc_show_hint = compile preprocessFileLineNumbers "core\fnc\common\show_hint.sqf";
	btc_fnc_intro = compile preprocessFileLineNumbers "core\fnc\common\intro.sqf";

	//CIV
	btc_fnc_civ_add_leaflets = compile preprocessFileLineNumbers "core\fnc\civ\add_leaflets.sqf";

	//IED
	btc_fnc_ied_effects = compile preprocessFile "core\fnc\ied\ied_effects.sqf";
	btc_fnc_ied_effect_smoke = compile preprocessFile "core\fnc\ied\effect_smoke.sqf";
	btc_fnc_ied_effect_color_smoke = compile preprocessFile "core\fnc\ied\effect_color_smoke.sqf";
	btc_fnc_ied_effect_rocks = compile preprocessFile "core\fnc\ied\effect_rocks.sqf";
	btc_fnc_ied_effect_blurEffect = compile preprocessFile "core\fnc\ied\effect_blurEffect.sqf";
	btc_fnc_ied_effect_shock_wave = compile preprocessFile "core\fnc\ied\effect_shock_wave.sqf";

	//EH
	btc_fnc_eh_player_respawn = compile preprocessFileLineNumbers "core\fnc\eh\player_respawn.sqf";
	btc_fnc_eh_CuratorObjectPlaced = compile preprocessFileLineNumbers "core\fnc\eh\CuratorObjectPlaced.sqf";
	btc_fnc_eh_treatment = compile preprocessFileLineNumbers "core\fnc\eh\treatment.sqf";
	btc_fnc_eh_leaflets = compile preprocessFileLineNumbers "core\fnc\eh\leaflets.sqf";

	//FOB
	btc_fnc_fob_create = compile preprocessFileLineNumbers "core\fnc\fob\create.sqf";
	btc_fnc_fob_lb_change = compile preprocessFileLineNumbers "core\fnc\fob\lb_change.sqf";
	btc_fnc_fob_redeploy = compile preprocessFileLineNumbers "core\fnc\fob\redeploy.sqf";
	btc_fnc_fob_dismantle = compile preprocessFileLineNumbers "core\fnc\fob\dismantle.sqf";

	//INT
	btc_fnc_int_add_actions = compile preprocessFileLineNumbers "core\fnc\int\add_actions.sqf";
	btc_fnc_int_action_result = compile preprocessFileLineNumbers "core\fnc\int\action_result.sqf";
	btc_fnc_int_orders = compile preprocessFileLineNumbers "core\fnc\int\orders.sqf";
	btc_fnc_int_shortcuts = compile preprocessFileLineNumbers "core\fnc\int\shortcuts.sqf";

	//INFO
	btc_fnc_info_ask = compile preprocessFileLineNumbers "core\fnc\info\ask.sqf";
	btc_fnc_info_hideout_asked = compile preprocessFileLineNumbers "core\fnc\info\hideout_asked.sqf";
	btc_fnc_info_search_for_intel = compile preprocessFileLineNumbers "core\fnc\info\search_for_intel.sqf";
	btc_fnc_info_troops = compile preprocessFileLineNumbers "core\fnc\info\troops.sqf";
	btc_fnc_info_ask_reputation = compile preprocessFileLineNumbers "core\fnc\info\ask_reputation.sqf";

	//LOG
	btc_fnc_log_garage = compile preprocessFileLineNumbers "core\fnc\log\garage.sqf";
	btc_fnc_log_hitch_points = compile preprocessFileLineNumbers "core\fnc\log\hitch_points.sqf";
	btc_fnc_log_get_corner_points = compile preprocessFileLineNumbers "core\fnc\log\get_corner_points.sqf";

	//TASK
	btc_fnc_task_create = compile preprocessFileLineNumbers "core\fnc\task\create.sqf";
	btc_fnc_task_fail = compile preprocessFileLineNumbers "core\fnc\task\fail.sqf";
	btc_fnc_task_set_done = compile preprocessFileLineNumbers "core\fnc\task\set_done.sqf";

	//SIDE
	btc_fnc_side_request = compile preprocessFileLineNumbers "core\fnc\side\request.sqf";
};
