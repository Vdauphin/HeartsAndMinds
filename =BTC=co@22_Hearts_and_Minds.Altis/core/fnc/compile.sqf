/////////////////////SERVER\\\\\\\\\\\\\\\\\\\\\
if (isServer) then {
	//CACHE
	btc_fnc_cache_find_pos = compile preprocessFile "core\fnc\cache\find_pos.sqf";
	btc_fnc_cache_hd_cache = compile preprocessFile "core\fnc\cache\hd_cache.sqf";
	btc_fnc_cache_spawn = compile preprocessFile "core\fnc\cache\spawn.sqf";

	//COMMON
	btc_fnc_check_los = compile preprocessFile "core\fnc\common\check_los.sqf";
	btc_fnc_clean_up = compile preprocessFile "core\fnc\common\clean_up.sqf";
	btc_fnc_create_composition = compile preprocessFile "core\fnc\common\create_composition.sqf";
	btc_fnc_getHouses = compile preprocessFile "core\fnc\common\getHouses.sqf";
	btc_fnc_house_addWP = compile preprocessFile "core\fnc\common\house_addWP.sqf";
	btc_fnc_randomize_pos = compile preprocessFile "core\fnc\common\randomize_pos.sqf";
	btc_fnc_set_owner = compile preprocessFile "core\fnc\common\set_owner.sqf";
	btc_fnc_task_patrol = compile preprocessFile "core\fnc\common\task_patrol.sqf";
	btc_fnc_set_damage = compile preprocessFile "core\fnc\common\set_damage.sqf";
	btc_fnc_road_direction = compile preprocessFile "core\fnc\common\road_direction.sqf";

	//CITY
	btc_fnc_city_activate = compile preprocessFile "core\fnc\city\activate.sqf";
	btc_fnc_city_create = compile preprocessFile "core\fnc\city\create.sqf";
	btc_fnc_city_de_activate = compile preprocessFile "core\fnc\city\de_activate.sqf";
	btc_fnc_city_set_clear = compile preprocessFile "core\fnc\city\set_clear.sqf";

	//CIV
	btc_fnc_civ_add_weapons = compile preprocessFile "core\fnc\civ\add_weapons.sqf";
	btc_fnc_civ_addWP = compile preprocessFile "core\fnc\civ\addWP.sqf";
	btc_fnc_civ_create = compile preprocessFile "core\fnc\civ\create.sqf";
	btc_fnc_civ_get_weapons = compile preprocessFile "core\fnc\civ\get_weapons.sqf";
	btc_fnc_civ_populate = compile preprocessFile "core\fnc\civ\populate.sqf";
	btc_fnc_civ_traffic_add_WP = compile preprocessFile "core\fnc\civ\traffic_add_WP.sqf";
	btc_fnc_civ_traffic_create = compile preprocessFile "core\fnc\civ\traffic_create.sqf";
	btc_fnc_civ_traffic_eh = compile preprocessFile "core\fnc\civ\traffic_eh.sqf";
	btc_fnc_civ_traffic_eh_remove = compile preprocessFile "core\fnc\civ\traffic_eh_remove.sqf";
	btc_fnc_civ_unit_create = compile preprocessFile "core\fnc\civ\unit_create.sqf";

	//DATA
	btc_fnc_data_add_group = compile preprocessFile "core\fnc\data\add_group.sqf";
	btc_fnc_data_get_group = compile preprocessFile "core\fnc\data\get_group.sqf";
	btc_fnc_data_spawn_group = compile preprocessFile "core\fnc\data\spawn_group.sqf";

	//DB
	if (isClass(configFile >> "cfgPatches" >> "inidbi2")) then {OO_fnc_inidbi = ["new", format ["btc_hm_%1",worldName]] call OO_INIDBI};
	btc_fnc_db_save = compile preprocessFile "core\fnc\db\save.sqf";
	btc_fnc_db_delete = compile preprocessFile "core\fnc\db\delete.sqf";
	btc_fnc_db_save_array = compile preprocessFile "core\fnc\db\save_array.sqf";
	btc_fnc_db_array_to_string = compile preprocessFile "core\fnc\db\array_to_string.sqf";
	btc_fnc_db_string_to_array = compile preprocessFile "core\fnc\db\string_to_array.sqf";

	//EH
	//btc_fnc_eh_helo_respawn = compile preprocessFile "core\fnc\eh\helo_respawn.sqf";
	btc_fnc_eh_veh_add_respawn = compile preprocessFile "core\fnc\eh\veh_add_respawn.sqf";
	btc_fnc_eh_veh_killed = compile preprocessFile "core\fnc\eh\veh_killed.sqf";
	btc_fnc_eh_veh_respawn = compile preprocessFile "core\fnc\eh\veh_respawn.sqf";

	//IED
	btc_fnc_ied_boom = compile preprocessFile "core\fnc\ied\boom.sqf";
	btc_fnc_ied_check = compile preprocessFile "core\fnc\ied\check.sqf";
	btc_fnc_ied_create = compile preprocessFile "core\fnc\ied\create.sqf";
	btc_fnc_ied_fired_near = compile preprocessFile "core\fnc\ied\fired_near.sqf";
	btc_fnc_ied_init_area = compile preprocessFile "core\fnc\ied\init_area.sqf";
	btc_fnc_ied_suicider_active = compile preprocessFile "core\fnc\ied\suicider_active.sqf";
	btc_fnc_ied_suicider_create = compile preprocessFile "core\fnc\ied\suicider_create.sqf";
	btc_fnc_ied_allahu_akbar = compile preprocessFile "core\fnc\ied\allahu_akbar.sqf";

	//INFO
	btc_fnc_info_cache = compile preprocessFile "core\fnc\info\cache.sqf";
	btc_fnc_info_give_intel = compile preprocessFile "core\fnc\info\give_intel.sqf";
	btc_fnc_info_has_intel = compile preprocessFile "core\fnc\info\has_intel.sqf";
	btc_fnc_info_hideout = compile preprocessFile "core\fnc\info\hideout.sqf";

	//FOB
	btc_fnc_fob_create_s = compile preprocessFile "core\fnc\fob\create_s.sqf";

	//MIL
	btc_fnc_mil_addWP = compile preprocessFile "core\fnc\mil\addWP.sqf";
	btc_fnc_mil_check_cap = compile preprocessFile "core\fnc\mil\check_cap.sqf";
	btc_fnc_mil_create_group = compile preprocessFile "core\fnc\mil\create_group.sqf";
	btc_fnc_mil_hd_hideout = compile preprocessFile "core\fnc\mil\hd_hideout.sqf";
	//btc_fnc_mil_eh_killed = compile preprocessFile "core\fnc\mil\eh_killed.sqf";
	btc_fnc_mil_create_hideout = compile preprocessFile "core\fnc\mil\create_hideout.sqf";
	btc_fnc_mil_create_static = compile preprocessFile "core\fnc\mil\create_static.sqf";
	btc_fnc_mil_patrol_create = compile preprocessFile "core\fnc\mil\patrol_create.sqf";
	btc_fnc_mil_patrol_addWP = compile preprocessFile "core\fnc\mil\patrol_addWP.sqf";
	btc_fnc_mil_send = compile preprocessFile "core\fnc\mil\send.sqf";
	btc_fnc_mil_set_skill = compile preprocessFile "core\fnc\mil\set_skill.sqf";
	btc_fnc_mil_unit_create = compile preprocessFile "core\fnc\mil\unit_create.sqf";
	btc_fnc_mil_unit_killed = compile preprocessFile "core\fnc\mil\unit_killed.sqf";

	//REP
	btc_fnc_rep_add_eh = compile preprocessFile "core\fnc\rep\add_eh.sqf";
	btc_fnc_rep_call_militia = compile preprocessFile "core\fnc\rep\call_militia.sqf";
	btc_fnc_rep_change = compile preprocessFile "core\fnc\rep\change.sqf";
	btc_fnc_rep_eh_effects = compile preprocessFile "core\fnc\rep\eh_effects.sqf";
	btc_fnc_rep_hd = compile preprocessFile "core\fnc\rep\hd.sqf";
	btc_fnc_rep_hh = compile preprocessFile "core\fnc\rep\hh.sqf";
	btc_fnc_rep_killed = compile preprocessFile "core\fnc\rep\killed.sqf";
	btc_fnc_rep_remove_eh = compile preprocessFile "core\fnc\rep\remove_eh.sqf";

	//SIDE
	btc_fnc_side_create = compile preprocessFileLineNumbers "core\fnc\side\create.sqf";
	btc_fnc_side_get_city = compile preprocessFileLineNumbers "core\fnc\side\get_city.sqf";
	btc_fnc_side_mines = compile preprocessFileLineNumbers "core\fnc\side\mines.sqf";
	btc_fnc_side_supply = compile preprocessFileLineNumbers "core\fnc\side\supply.sqf";
	btc_fnc_side_vehicle = compile preprocessFileLineNumbers "core\fnc\side\vehicle.sqf";
	btc_fnc_side_civtreatment = compile preprocessFileLineNumbers "core\fnc\side\civtreatment.sqf";
	btc_fnc_side_tower = compile preprocessFileLineNumbers "core\fnc\side\tower.sqf";
	btc_fnc_side_checkpoint = compile preprocessFileLineNumbers "core\fnc\side\checkpoint.sqf";
};
/////////////////////CLIENT AND SERVER\\\\\\\\\\\\\\\\\\\\\

//COMMON
//btc_fnc_veh_track_marker = compile preprocessFile "core\fnc\common\veh_track_marker.sqf";

//DB
btc_fnc_db_add_veh = compile preprocessFile "core\fnc\db\add_veh.sqf";

//EH
btc_fnc_eh_unit_init = compile preprocessFile "core\fnc\eh\unit_init.sqf";
btc_fnc_eh_CuratorObjectPlaced = compile preprocessFile "core\fnc\eh\CuratorObjectPlaced.sqf";

//INT
btc_fnc_int_change_var = compile preprocessFile "core\fnc\int\change_var.sqf";
btc_fnc_int_orders_give = compile preprocessFile "core\fnc\int\orders_give.sqf";
btc_fnc_int_orders_behaviour = compile preprocessFile "core\fnc\int\orders_behaviour.sqf";
btc_fnc_int_ans_var = compile preprocessFile "core\fnc\int\ans_var.sqf";
btc_fnc_int_ask_var = compile preprocessFile "core\fnc\int\ask_var.sqf";

//LOG
btc_fnc_log_can_tow = compile preprocessFile "core\fnc\log\can_tow.sqf";
btc_fnc_log_check_cargo = compile preprocessFile "core\fnc\log\check_cargo.sqf";
btc_fnc_log_check_cc = compile preprocessFile "core\fnc\log\check_cc.sqf";
btc_fnc_log_create = compile preprocessFile "core\fnc\log\create.sqf";
btc_fnc_log_create_apply = compile preprocessFile "core\fnc\log\create_apply.sqf";
btc_fnc_log_create_load = compile preprocessFile "core\fnc\log\create_load.sqf";
btc_fnc_log_create_change_target = compile preprocessFile "core\fnc\log\create_change_target.sqf";
btc_fnc_log_create_s = compile preprocessFile "core\fnc\log\create_s.sqf";
btc_fnc_log_hook = compile preprocessFile "core\fnc\log\hook.sqf";
btc_fnc_log_lift_check = compile preprocessFile "core\fnc\log\lift_check.sqf";
btc_fnc_log_lift_deploy_ropes = compile preprocessFile "core\fnc\log\lift_deploy_ropes.sqf";
btc_fnc_log_lift_destroy_ropes = compile preprocessFile "core\fnc\log\lift_destroy_ropes.sqf";
btc_fnc_log_lift_hook = compile preprocessFile "core\fnc\log\lift_hook.sqf";
btc_fnc_log_lift_hook_fake = compile preprocessFile "core\fnc\log\lift_hook_fake.sqf";
btc_fnc_log_lift_hud = compile preprocessFile "core\fnc\log\lift_hud.sqf";
btc_fnc_log_lift_unhook = compile preprocessFile "core\fnc\log\lift_hook.sqf";
btc_fnc_log_get_cc = compile preprocessFile "core\fnc\log\get_cc.sqf";
btc_fnc_log_get_rc = compile preprocessFile "core\fnc\log\get_rc.sqf";
btc_fnc_log_load = compile preprocessFile "core\fnc\log\load.sqf";
btc_fnc_log_obj_fall = compile preprocessFile "core\fnc\log\obj_fall.sqf";
btc_fnc_log_paradrop = compile preprocessFile "core\fnc\log\paradrop.sqf";
btc_fnc_log_place = compile preprocessFile "core\fnc\log\place.sqf";
btc_fnc_log_place_create_camera = compile preprocessFile "core\fnc\log\place_create_camera.sqf";
btc_fnc_log_place_destroy_camera = compile preprocessFile "core\fnc\log\place_destroy_camera.sqf";
btc_fnc_log_place_key_down = compile preprocessFile "core\fnc\log\place_key_down.sqf";
btc_fnc_log_repair_wreck = compile preprocessFile "core\fnc\log\repair_wreck.sqf";
btc_fnc_log_select = compile preprocessFile "core\fnc\log\select.sqf";
btc_fnc_log_server_load = compile preprocessFile "core\fnc\log\server_load.sqf";
btc_fnc_log_server_repair_wreck = compile preprocessFile "core\fnc\log\server_repair_wreck.sqf";
btc_fnc_log_server_unload = compile preprocessFile "core\fnc\log\server_unload.sqf";
btc_fnc_log_set_mass = compile preprocessFile "core\fnc\log\set_mass.sqf";
btc_fnc_log_tow = compile preprocessFile "core\fnc\log\tow.sqf";
btc_fnc_log_unhook = compile preprocessFile "core\fnc\log\unhook.sqf";
btc_fnc_log_unload = compile preprocessFile "core\fnc\log\unload.sqf";

//SIDE
btc_fnc_side_abort = compile preprocessFileLineNumbers "core\fnc\side\abort.sqf";

/////////////////////CLIENT\\\\\\\\\\\\\\\\\\\\\
if (!isDedicated) then {
	//DB
	btc_fnc_db_request_save = compile preprocessFile "core\fnc\db\request_save.sqf";
	btc_fnc_db_request_delete = compile preprocessFile "core\fnc\db\request_delete.sqf";

	//COMMON
	btc_fnc_end_mission = compile preprocessFile "core\fnc\common\end_mission.sqf";
	btc_fnc_get_cardinal = compile preprocessFile "core\fnc\common\get_cardinal.sqf";
	btc_fnc_is_engineer = compile preprocessFile "core\fnc\common\is_engineer.sqf";
	btc_fnc_marker_debug = compile preprocessFile "core\fnc\common\marker_debug.sqf";
	btc_fnc_show_hint = compile preprocessFile "core\fnc\common\show_hint.sqf";

	//EH
	btc_fnc_eh_player_respawn = compile preprocessFile "core\fnc\eh\player_respawn.sqf";

	//FOB
	btc_fnc_fob_create = compile preprocessFile "core\fnc\fob\create.sqf";
	btc_fnc_fob_lb_change = compile preprocessFile "core\fnc\fob\lb_change.sqf";
	btc_fnc_fob_redeploy = compile preprocessFile "core\fnc\fob\redeploy.sqf";

	//IED
	btc_fnc_ied_check_for = compile preprocessFile "core\fnc\ied\check_for.sqf";
	btc_fnc_ied_disarm = compile preprocessFile "core\fnc\ied\disarm.sqf";

	//INT
	btc_fnc_int_add_actions = compile preprocessFile "core\fnc\int\add_actions.sqf";
	btc_fnc_int_action_result = compile preprocessFile "core\fnc\int\action_result.sqf";
	btc_fnc_int_orders = compile preprocessFile "core\fnc\int\orders.sqf";

	//INFO
	btc_fnc_info_ask = compile preprocessFile "core\fnc\info\ask.sqf";
	btc_fnc_info_hideout_asked = compile preprocessFile "core\fnc\info\hideout_asked.sqf";
	btc_fnc_info_search_for_intel = compile preprocessFile "core\fnc\info\search_for_intel.sqf";
	btc_fnc_info_troops = compile preprocessFile "core\fnc\info\troops.sqf";
	btc_fnc_info_ask_reputation = compile preprocessFile "core\fnc\info\ask_reputation.sqf";

	//TASK
	btc_fnc_task_create = compile preprocessFileLineNumbers "core\fnc\task\create.sqf";
	btc_fnc_task_fail = compile preprocessFileLineNumbers "core\fnc\task\fail.sqf";
	btc_fnc_task_set_done = compile preprocessFileLineNumbers "core\fnc\task\set_done.sqf";

	//SIDE
	btc_fnc_side_request = compile preprocessFileLineNumbers "core\fnc\side\request.sqf";
};