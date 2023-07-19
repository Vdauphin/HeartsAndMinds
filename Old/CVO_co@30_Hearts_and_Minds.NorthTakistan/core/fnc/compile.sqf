/////////////////////SERVER\\\\\\\\\\\\\\\\\\\\\
if (isServer) then {
    //BODY
    btc_body_fnc_bagRecover_s = compileScript ["core\fnc\body\bagRecover_s.sqf"];
    btc_body_fnc_createMarker = compileScript ["core\fnc\body\createMarker.sqf"];
    btc_body_fnc_dogtagGet = compileScript ["core\fnc\body\dogtagGet.sqf"];
    btc_body_fnc_dogtagSet = compileScript ["core\fnc\body\dogtagSet.sqf"];
    btc_body_fnc_setBodyBag = compileScript ["core\fnc\body\setBodyBag.sqf"];
    btc_body_fnc_create = compileScript ["core\fnc\body\create.sqf"];
    btc_body_fnc_get = compileScript ["core\fnc\body\get.sqf"];

    //CACHE
    btc_cache_fnc_find_pos = compileScript ["core\fnc\cache\find_pos.sqf"];
    btc_cache_fnc_create = compileScript ["core\fnc\cache\create.sqf"];
    btc_cache_fnc_create_attachto = compileScript ["core\fnc\cache\create_attachto.sqf"];
    btc_cache_fnc_init = compileScript ["core\fnc\cache\init.sqf"];

    //COMMON
    btc_fnc_check_los = compileScript ["core\fnc\common\check_los.sqf"];
    btc_fnc_create_composition = compileScript ["core\fnc\common\create_composition.sqf"];
    btc_fnc_house_addWP = compileScript ["core\fnc\common\house_addWP.sqf"];
    btc_fnc_set_damage = compileScript ["core\fnc\common\set_damage.sqf"];
    btc_fnc_road_direction = compileScript ["core\fnc\common\road_direction.sqf"];
    btc_fnc_findsafepos = compileScript ["core\fnc\common\findsafepos.sqf"];
    btc_fnc_find_closecity = compileScript ["core\fnc\common\find_closecity.sqf"];
    btc_fnc_delete = compileScript ["core\fnc\common\delete.sqf"];
    btc_fnc_deleteEntities = compileScript ["core\fnc\common\deleteEntities.sqf"];
    btc_fnc_final_phase = compileScript ["core\fnc\common\final_phase.sqf"];
    btc_fnc_findPosOutsideRock = compileScript ["core\fnc\common\findposoutsiderock.sqf"];
    btc_fnc_typeOf = compileScript ["core\fnc\common\typeOf.sqf"];
    btc_fnc_roof = compileScript ["core\fnc\common\roof.sqf"];
    btc_fnc_moveOut = compileScript ["core\fnc\common\moveOut.sqf"];
    btc_fnc_changeWeather = compileScript ["core\fnc\common\changeWeather.sqf"];

    //CHEM
    btc_chem_fnc_checkLoop = compileScript ["core\fnc\chem\checkLoop.sqf"];
    btc_chem_fnc_propagate = compileScript ["core\fnc\chem\propagate.sqf"];
    btc_chem_fnc_handleShower = compileScript ["core\fnc\chem\handleShower.sqf"];

    //SPECT
    btc_spect_fnc_checkLoop = compileScript ["core\fnc\spect\checkLoop.sqf"];
    btc_spect_fnc_electronicFailure = compileScript ["core\fnc\spect\electronicFailure.sqf"];

    //CITY
    btc_city_fnc_activate = compileScript ["core\fnc\city\activate.sqf"];
    btc_city_fnc_create = compileScript ["core\fnc\city\create.sqf"];
    btc_city_fnc_de_activate = compileScript ["core\fnc\city\de_activate.sqf"];
    btc_city_fnc_setClear = compileScript ["core\fnc\city\setClear.sqf"];
    btc_city_fnc_setPlayerTrigger = compileScript ["core\fnc\city\setPlayerTrigger.sqf"];
    btc_city_fnc_cleanUp = compileScript ["core\fnc\city\cleanUp.sqf"];
    btc_city_fnc_trigger_free_condition = compileScript ["core\fnc\city\trigger_free_condition.sqf"];
    btc_city_fnc_getHouses = compileScript ["core\fnc\city\getHouses.sqf"];
    btc_city_fnc_send = compileScript ["core\fnc\city\send.sqf"];

    //CIV
    btc_civ_fnc_add_grenade = compileScript ["core\fnc\civ\add_grenade.sqf"];
    btc_civ_fnc_get_weapons = compileScript ["core\fnc\civ\get_weapons.sqf"];
    btc_civ_fnc_get_grenade = compileScript ["core\fnc\civ\get_grenade.sqf"];
    btc_civ_fnc_populate = compileScript ["core\fnc\civ\populate.sqf"];
    btc_civ_fnc_create_patrol = compileScript ["core\fnc\civ\create_patrol.sqf"];
    btc_civ_fnc_evacuate = compileScript ["core\fnc\civ\evacuate.sqf"];
    btc_civ_fnc_createFlower = compileScript ["core\fnc\civ\createFlower.sqf"];

    //DATA
    btc_data_fnc_add_group = compileScript ["core\fnc\data\add_group.sqf"];
    btc_data_fnc_get_group = compileScript ["core\fnc\data\get_group.sqf"];
    btc_data_fnc_spawn_group = compileScript ["core\fnc\data\spawn_group.sqf"];

    //DB
    btc_db_fnc_save = compileScript ["core\fnc\db\save.sqf"];
    btc_db_fnc_delete = compileScript ["core\fnc\db\delete.sqf"];
    btc_db_fnc_loadObjectStatus = compileScript ["core\fnc\db\loadObjectStatus.sqf"];
    btc_db_fnc_saveObjectStatus = compileScript ["core\fnc\db\saveObjectStatus.sqf"];
    btc_db_fnc_loadCargo = compileScript ["core\fnc\db\loadcargo.sqf"];
    btc_db_fnc_autoRestart = compileScript ["core\fnc\db\autoRestart.sqf"];
    btc_db_fnc_setTurretMagazines = compileScript ["core\fnc\db\setTurretMagazines.sqf"];
    btc_db_fnc_autoRestartLoop = compileScript ["core\fnc\db\autoRestartLoop.sqf"];

    //DELAY
    btc_delay_fnc_createUnit = compileScript ["core\fnc\delay\createUnit.sqf"];
    btc_delay_fnc_createVehicle = compileScript ["core\fnc\delay\createVehicle.sqf"];
    btc_delay_fnc_createAgent = compileScript ["core\fnc\delay\createAgent.sqf"];
    btc_delay_fnc_exec = compileScript ["core\fnc\delay\exec.sqf"];
    btc_delay_fnc_waitAndExecute = compileScript ["core\fnc\delay\waitAndExecute.sqf"];

    //DOOR
    btc_door_fnc_lock = compileScript ["core\fnc\door\lock.sqf"];
    btc_door_fnc_get = compileScript ["core\fnc\door\get.sqf"];

    //EH
    btc_eh_fnc_server = compileScript ["core\fnc\eh\server.sqf"];
    btc_eh_fnc_playerConnected = compileScript ["core\fnc\eh\playerConnected.sqf"];

    //IED
    btc_ied_fnc_boom = compileScript ["core\fnc\ied\boom.sqf"];
    btc_ied_fnc_check = compileScript ["core\fnc\ied\check.sqf"];
    btc_ied_fnc_checkLoop = compileScript ["core\fnc\ied\checkLoop.sqf"];
    btc_ied_fnc_create = compileScript ["core\fnc\ied\create.sqf"];
    btc_ied_fnc_fired_near = compileScript ["core\fnc\ied\fired_near.sqf"];
    btc_ied_fnc_initArea = compileScript ["core\fnc\ied\initArea.sqf"];
    btc_ied_fnc_suicider_active = compileScript ["core\fnc\ied\suicider_active.sqf"];
    btc_ied_fnc_suicider_activeLoop = compileScript ["core\fnc\ied\suicider_activeLoop.sqf"];
    btc_ied_fnc_suicider_create = compileScript ["core\fnc\ied\suicider_create.sqf"];
    btc_ied_fnc_suiciderLoop = compileScript ["core\fnc\ied\suiciderLoop.sqf"];
    btc_ied_fnc_allahu_akbar = compileScript ["core\fnc\ied\allahu_akbar.sqf"];
    btc_ied_fnc_drone_active = compileScript ["core\fnc\ied\drone_active.sqf"];
    btc_ied_fnc_drone_create = compileScript ["core\fnc\ied\drone_create.sqf"];
    btc_ied_fnc_droneLoop = compileScript ["core\fnc\ied\droneLoop.sqf"];
    btc_ied_fnc_drone_fire = compileScript ["core\fnc\ied\drone_fire.sqf"];
    btc_ied_fnc_randomRoadPos = compileScript ["core\fnc\ied\randomRoadPos.sqf"];

    //INFO
    btc_info_fnc_cache = compileScript ["core\fnc\info\cache.sqf"];
    btc_info_fnc_give_intel = compileScript ["core\fnc\info\give_intel.sqf"];
    btc_info_fnc_has_intel = compileScript ["core\fnc\info\has_intel.sqf"];
    btc_info_fnc_hideout = compileScript ["core\fnc\info\hideout.sqf"];
    btc_info_fnc_cacheMarker = compileScript ["core\fnc\info\cacheMarker.sqf"];
    btc_info_fnc_path = compileScript ["core\fnc\info\path.sqf"];
    btc_info_fnc_createIntels = compileScript ["core\fnc\info\createIntels.sqf"];

    //FOB
    btc_fob_fnc_create_s = compileScript ["core\fnc\fob\create_s.sqf"];
    btc_fob_fnc_dismantle_s = compileScript ["core\fnc\fob\dismantle_s.sqf"];
    btc_fob_fnc_killed = compileScript ["core\fnc\fob\killed.sqf"];
    btc_fob_fnc_rallypointTimer = compileScript ["core\fnc\fob\rallypointTimer.sqf"];

    //MIL
    btc_mil_fnc_addWP = compileScript ["core\fnc\mil\addWP.sqf"];
    btc_mil_fnc_check_cap = compileScript ["core\fnc\mil\check_cap.sqf"];
    btc_mil_fnc_create_group = compileScript ["core\fnc\mil\create_group.sqf"];
    btc_mil_fnc_create_static = compileScript ["core\fnc\mil\create_static.sqf"];
    btc_mil_fnc_create_patrol = compileScript ["core\fnc\mil\create_patrol.sqf"];
    btc_mil_fnc_send = compileScript ["core\fnc\mil\send.sqf"];
    btc_mil_fnc_set_skill = compileScript ["core\fnc\mil\set_skill.sqf"];
    btc_mil_fnc_getStructures = compileScript ["core\fnc\mil\getStructures.sqf"];
    btc_mil_fnc_getBuilding = compileScript ["core\fnc\mil\getBuilding.sqf"];
    btc_mil_fnc_createVehicle = compileScript ["core\fnc\mil\createVehicle.sqf"];
    btc_mil_fnc_createUnits = compileScript ["core\fnc\mil\createUnits.sqf"];
    btc_mil_fnc_unit_killed = compileScript ["core\fnc\mil\unit_killed.sqf"];
    btc_mil_fnc_create_staticOnRoof = compileScript ["core\fnc\mil\create_staticOnRoof.sqf"];

    //HIDEOUT
    btc_hideout_fnc_hd = compileScript ["core\fnc\hideout\hd.sqf"];
    btc_hideout_fnc_create = compileScript ["core\fnc\hideout\create.sqf"];
    btc_hideout_fnc_create_composition = compileScript ["core\fnc\hideout\create_composition.sqf"];

    //PATROL
    btc_patrol_fnc_playersInAreaCityGroup = compileScript ["core\fnc\patrol\playersInAreaCityGroup.sqf"];
    btc_patrol_fnc_usefulCity = compileScript ["core\fnc\patrol\usefulCity.sqf"];
    btc_patrol_fnc_WPCheck = compileScript ["core\fnc\patrol\WPCheck.sqf"];
    btc_patrol_fnc_init = compileScript ["core\fnc\patrol\init.sqf"];
    btc_patrol_fnc_addWP = compileScript ["core\fnc\patrol\addWP.sqf"];
    btc_patrol_fnc_eh = compileScript ["core\fnc\patrol\eh.sqf"];
    btc_patrol_fnc_addEH = compileScript ["core\fnc\patrol\addEH.sqf"];

    //SLOT
    btc_slot_fnc_serializeState = compileScript ["core\fnc\slot\serializeState.sqf"];
    btc_slot_fnc_deserializeState_s = compileScript ["core\fnc\slot\deserializeState_s.sqf"];
    btc_slot_fnc_createKey = compileScript ["core\fnc\slot\createKey.sqf"];

    //REP
    btc_rep_fnc_call_militia = compileScript ["core\fnc\rep\call_militia.sqf"];
    btc_rep_fnc_change = compileScript ["core\fnc\rep\change.sqf"];
    btc_rep_fnc_eh_effects = compileScript ["core\fnc\rep\eh_effects.sqf"];
    btc_rep_fnc_hh = compileScript ["core\fnc\rep\hh.sqf"];
    btc_rep_fnc_buildingchanged = compileScript ["core\fnc\rep\buildingchanged.sqf"];
    btc_rep_fnc_explosives_defuse = compileScript ["core\fnc\rep\explosives_defuse.sqf"];
    btc_rep_fnc_notify = compileScript ["core\fnc\rep\notify.sqf"];
    btc_rep_fnc_killed = compileScript ["core\fnc\rep\killed.sqf"];
    btc_rep_fnc_wheelChange = compileScript ["core\fnc\rep\wheelChange.sqf"];

    //RESPAWN
    btc_respawn_fnc_addTicket = compileScript ["core\fnc\respawn\addTicket.sqf"];
    btc_respawn_fnc_playerConnected = compileScript ["core\fnc\respawn\playerConnected.sqf"];
    btc_respawn_fnc_player = compileScript ["core\fnc\respawn\player.sqf"];

    //SIDE
    btc_side_fnc_create = compileScript ["core\fnc\side\create.sqf"];
    btc_side_fnc_get_city = compileScript ["core\fnc\side\get_city.sqf"];
    btc_side_fnc_mines = compileScript ["core\fnc\side\mines.sqf"];
    btc_side_fnc_supply = compileScript ["core\fnc\side\supply.sqf"];
    btc_side_fnc_vehicle = compileScript ["core\fnc\side\vehicle.sqf"];
    btc_side_fnc_civtreatment = compileScript ["core\fnc\side\civtreatment.sqf"];
    btc_side_fnc_tower = compileScript ["core\fnc\side\tower.sqf"];
    btc_side_fnc_checkpoint = compileScript ["core\fnc\side\checkpoint.sqf"];
    btc_side_fnc_civtreatment_boat = compileScript ["core\fnc\side\civtreatment_boat.sqf"];
    btc_side_fnc_underwater_generator= compileScript ["core\fnc\side\underwater_generator.sqf"];
    btc_side_fnc_convoy = compileScript ["core\fnc\side\convoy.sqf"];
    btc_side_fnc_rescue = compileScript ["core\fnc\side\rescue.sqf"];
    btc_side_fnc_capture_officer = compileScript ["core\fnc\side\capture_officer.sqf"];
    btc_side_fnc_hostage = compileScript ["core\fnc\side\hostage.sqf"];
    btc_side_fnc_hack = compileScript ["core\fnc\side\hack.sqf"];
    btc_side_fnc_kill = compileScript ["core\fnc\side\kill.sqf"];
    btc_side_fnc_chemicalLeak = compileScript ["core\fnc\side\chemicalLeak.sqf"];
    btc_side_fnc_EMP = compileScript ["core\fnc\side\EMP.sqf"];
    btc_side_fnc_removeRubbish = compileScript ["core\fnc\side\removeRubbish.sqf"];
    btc_side_fnc_pandemic = compileScript ["core\fnc\side\pandemic.sqf"];

    //TAG
    btc_tag_fnc_initArea = compileScript ["core\fnc\tag\initArea.sqf"];
    btc_tag_fnc_eh = compileScript ["core\fnc\tag\eh.sqf"];
    btc_tag_fnc_create = compileScript ["core\fnc\tag\create.sqf"];

    //LOG
    btc_log_fnc_createVehicle = compileScript ["core\fnc\log\createVehicle.sqf"];
    btc_log_fnc_init = compileScript ["core\fnc\log\init.sqf"];
    btc_log_fnc_server_delete = compileScript ["core\fnc\log\server_delete.sqf"];
    btc_log_fnc_create_s = compileScript ["core\fnc\log\create_s.sqf"];
    btc_log_fnc_server_repair_wreck = compileScript ["core\fnc\log\server_repair_wreck.sqf"];

    //DEAF
    btc_deaf_fnc_earringing = compileScript ["core\fnc\deaf\earringing.sqf"];

    //TASK
    btc_task_fnc_create = compileScript ["core\fnc\task\create.sqf"];
    btc_task_fnc_setState = compileScript ["core\fnc\task\setState.sqf"];

    //TOW
    btc_tow_fnc_ropeBreak = compileScript ["core\fnc\tow\ropeBreak.sqf"];
    btc_tow_fnc_ViV = compileScript ["core\fnc\tow\ViV.sqf"];

    //VEH
    btc_veh_fnc_addRespawn = compileScript ["core\fnc\veh\addRespawn.sqf"];
    btc_veh_fnc_killed = compileScript ["core\fnc\veh\killed.sqf"];
    btc_veh_fnc_respawn = compileScript ["core\fnc\veh\respawn.sqf"];
    btc_veh_fnc_propertiesGet = compileScript ["core\fnc\veh\propertiesGet.sqf"];
    btc_veh_fnc_propertiesSet = compileScript ["core\fnc\veh\propertiesSet.sqf"];
    btc_veh_fnc_add = compileScript ["core\fnc\veh\add.sqf"];
    btc_veh_fnc_inventoryRestore = compileScript ["core\fnc\veh\inventoryRestore.sqf"];
};

/////////////////////CLIENT AND SERVER\\\\\\\\\\\\\\\\\\\\\

//CACHE
btc_cache_fnc_hd = compileScript ["core\fnc\cache\hd.sqf"];

//COMMON
btc_fnc_get_class = compileScript ["core\fnc\common\get_class.sqf"];
btc_fnc_randomize_pos = compileScript ["core\fnc\common\randomize_pos.sqf"];
btc_fnc_getHouses = compileScript ["core\fnc\common\getHouses.sqf"];
btc_fnc_house_addWP_loop = compileScript ["core\fnc\common\house_addWP_loop.sqf"];

//CHEM
btc_chem_fnc_damage = compileScript ["core\fnc\chem\damage.sqf"];
btc_chem_fnc_deconShowerAnimLarge = {(_this select 0) setVariable ["BIN_Shower_Stop",false]; _this call BIN_fnc_deconShowerAnimLarge;};
btc_chem_fnc_damageLoop = compileScript ["core\fnc\chem\damageLoop.sqf"];

//DOOR
btc_door_fnc_broke = compileScript ["core\fnc\door\broke.sqf"];

//DEBUG
btc_debug_fnc_message = compileScript ["core\fnc\debug\message.sqf"];

//EH
btc_eh_fnc_trackItem = compileScript ["core\fnc\eh\trackItem.sqf"];

//FLAG
btc_flag_fnc_int = compileScript ["core\fnc\flag\int.sqf"];

//CIV
btc_civ_fnc_class = compileScript ["core\fnc\civ\class.sqf"];
btc_civ_fnc_addWP = compileScript ["core\fnc\civ\addWP.sqf"];
btc_civ_fnc_add_weapons = compileScript ["core\fnc\civ\add_weapons.sqf"];

//IED
btc_ied_fnc_belt = compileScript ["core\fnc\ied\belt.sqf"];

//INT
btc_int_fnc_orders_give = compileScript ["core\fnc\int\orders_give.sqf"];
btc_int_fnc_orders_behaviour = compileScript ["core\fnc\int\orders_behaviour.sqf"];
btc_int_fnc_ask_var = compileScript ["core\fnc\int\ask_var.sqf"];

//LOG
btc_log_fnc_place_destroy_camera = compileScript ["core\fnc\log\place_destroy_camera.sqf"];
btc_log_fnc_inventoryGet = compileScript ["core\fnc\log\inventoryGet.sqf"];
btc_log_fnc_inventorySet = compileScript ["core\fnc\log\inventorySet.sqf"];

//MIL
btc_mil_fnc_class = compileScript ["core\fnc\mil\class.sqf"];
btc_mil_fnc_ammoUsage = compileScript ["core\fnc\mil\ammoUsage.sqf"];

//PATROL
btc_patrol_fnc_disabled = compileScript ["core\fnc\patrol\disabled.sqf"];

//REP
btc_rep_fnc_hd = compileScript ["core\fnc\rep\hd.sqf"];
btc_rep_fnc_suppressed = compileScript ["core\fnc\rep\suppressed.sqf"];
btc_rep_fnc_foodRemoved = compileScript ["core\fnc\rep\foodRemoved.sqf"];

//ARSENAL
btc_arsenal_fnc_ammoUsage = compileScript ["core\fnc\arsenal\ammoUsage.sqf"];

//TOW
btc_tow_fnc_int = compileScript ["core\fnc\tow\int.sqf"];

//VEH
btc_veh_fnc_init = compileScript ["core\fnc\veh\init.sqf"];

/////////////////////CLIENT\\\\\\\\\\\\\\\\\\\\\
if (!isDedicated) then {
    //BODY
    btc_body_fnc_bagRecover = compileScript ["core\fnc\body\bagRecover.sqf"];

    //COMMON
    btc_fnc_end_mission = compileScript ["core\fnc\common\end_mission.sqf"];
    btc_fnc_get_cardinal = compileScript ["core\fnc\common\get_cardinal.sqf"];
    btc_fnc_show_hint = compileScript ["core\fnc\common\show_hint.sqf"];
    btc_fnc_set_markerTextLocal = compileScript ["core\fnc\common\set_markerTextLocal.sqf"];
    btc_fnc_showSubtitle = compileScript ["core\fnc\common\showSubtitle.sqf"];
    btc_fnc_get_composition = compileScript ["core\fnc\common\get_composition.sqf"];
    btc_fnc_checkArea = compileScript ["core\fnc\common\checkArea.sqf"];
    btc_fnc_typeOfPreview = compileScript ["core\fnc\common\typeOfPreview.sqf"];

    //CHEM
    btc_chem_fnc_biopsy = compileScript ["core\fnc\chem\biopsy.sqf"];
    btc_chem_fnc_ehDetector = compileScript ["core\fnc\chem\ehDetector.sqf"];
    btc_chem_fnc_updateDetector = compileScript ["core\fnc\chem\updateDetector.sqf"];

    //DEBUG
    btc_debug_fnc_marker = compileScript ["core\fnc\debug\marker.sqf"];
    btc_debug_fnc_units = compileScript ["core\fnc\debug\units.sqf"];
    btc_debug_fnc_fps = compileScript ["core\fnc\debug\fps.sqf"];
    btc_debug_fnc_graph = compileScript ["core\fnc\debug\graph.sqf"];

    //CIV
    btc_civ_fnc_add_leaflets = compileScript ["core\fnc\civ\add_leaflets.sqf"];
    btc_civ_fnc_leaflets = compileScript ["core\fnc\civ\leaflets.sqf"];

    //DOOR
    btc_door_fnc_break = compileScript ["core\fnc\door\break.sqf"];

    //IED
    btc_ied_fnc_effects = compileScript ["core\fnc\ied\effects.sqf"];
    btc_ied_fnc_effect_smoke = compileScript ["core\fnc\ied\effect_smoke.sqf"];
    btc_ied_fnc_effect_color_smoke = compileScript ["core\fnc\ied\effect_color_smoke.sqf"];
    btc_ied_fnc_effect_rocks = compileScript ["core\fnc\ied\effect_rocks.sqf"];
    btc_ied_fnc_effect_blurEffect = compileScript ["core\fnc\ied\effect_blurEffect.sqf"];
    btc_ied_fnc_effect_shock_wave = compileScript ["core\fnc\ied\effect_shock_wave.sqf"];
    btc_ied_fnc_deleteLoop = compileScript ["core\fnc\ied\deleteLoop.sqf"];

    //EH
    btc_eh_fnc_CuratorObjectPlaced = compileScript ["core\fnc\eh\CuratorObjectPlaced.sqf"];
    btc_eh_fnc_player = compileScript ["core\fnc\eh\player.sqf"];

    //FLAG
    btc_flag_fnc_deploy = compileScript ["core\fnc\flag\deploy.sqf"];

    //FOB
    btc_fob_fnc_create = compileScript ["core\fnc\fob\create.sqf"];
    btc_fob_fnc_rallypointAssemble = compileScript ["core\fnc\fob\rallypointAssemble.sqf"];
    btc_fob_fnc_redeploy = compileScript ["core\fnc\fob\redeploy.sqf"];
    btc_fob_fnc_redeployCheck = compileScript ["core\fnc\fob\redeployCheck.sqf"];

    //INT
    btc_int_fnc_add_actions = compileScript ["core\fnc\int\add_actions.sqf"];
    btc_int_fnc_orders = compileScript ["core\fnc\int\orders.sqf"];
    btc_int_fnc_shortcuts = compileScript ["core\fnc\int\shortcuts.sqf"];
    btc_int_fnc_terminal = compileScript ["core\fnc\int\terminal.sqf"];
    btc_int_fnc_foodGive = compileScript ["core\fnc\int\foodGive.sqf"];
    btc_int_fnc_ordersLoop = compileScript ["core\fnc\int\ordersLoop.sqf"];
    btc_int_fnc_checkSirenBeacons = compileScript ["core\fnc\int\checkSirenBeacons.sqf"];
    btc_int_fnc_horn = compileScript ["core\fnc\int\horn.sqf"];

    //INFO
    btc_info_fnc_ask = compileScript ["core\fnc\info\ask.sqf"];
    btc_info_fnc_hideout_asked = compileScript ["core\fnc\info\hideout_asked.sqf"];
    btc_info_fnc_search_for_intel = compileScript ["core\fnc\info\search_for_intel.sqf"];
    btc_info_fnc_troops = compileScript ["core\fnc\info\troops.sqf"];
    btc_info_fnc_ask_reputation = compileScript ["core\fnc\info\ask_reputation.sqf"];
    btc_info_fnc_cachePicture = compileScript ["core\fnc\info\cachePicture.sqf"];

    //LIFT
    btc_lift_fnc_check = compileScript ["core\fnc\lift\check.sqf"];
    btc_lift_fnc_deployRopes = compileScript ["core\fnc\lift\deployRopes.sqf"];
    btc_lift_fnc_destroyRopes = compileScript ["core\fnc\lift\destroyRopes.sqf"];
    btc_lift_fnc_hook = compileScript ["core\fnc\lift\hook.sqf"];
    btc_lift_fnc_hookFake = compileScript ["core\fnc\lift\hookFake.sqf"];
    btc_lift_fnc_hud = compileScript ["core\fnc\lift\hud.sqf"];
    btc_lift_fnc_hudLoop = compileScript ["core\fnc\lift\hudLoop.sqf"];
    btc_lift_fnc_shortcuts = compileScript ["core\fnc\lift\shortcuts.sqf"];

    //LOG
    btc_log_fnc_get_corner_points = compileScript ["core\fnc\log\get_corner_points.sqf"];
    btc_log_fnc_delete = compileScript ["core\fnc\log\delete.sqf"];
    btc_log_fnc_create = compileScript ["core\fnc\log\create.sqf"];
    btc_log_fnc_create_apply = compileScript ["core\fnc\log\create_apply.sqf"];
    btc_log_fnc_create_load = compileScript ["core\fnc\log\create_load.sqf"];
    btc_log_fnc_create_change_target = compileScript ["core\fnc\log\create_change_target.sqf"];
    btc_log_fnc_place_create_camera = compileScript ["core\fnc\log\place_create_camera.sqf"];
    btc_log_fnc_place = compileScript ["core\fnc\log\place.sqf"];
    btc_log_fnc_place_key_down = compileScript ["core\fnc\log\place_key_down.sqf"];
    btc_log_fnc_repair_wreck = compileScript ["core\fnc\log\repair_wreck.sqf"];
    btc_log_fnc_copy = compileScript ["core\fnc\log\copy.sqf"];
    btc_log_fnc_paste = compileScript ["core\fnc\log\paste.sqf"];
    btc_log_fnc_refuelSource = compileScript ["core\fnc\log\refuelSource.sqf"];
    btc_log_fnc_rearmSource = compileScript ["core\fnc\log\rearmSource.sqf"];
    btc_log_fnc_inventoryCopy = compileScript ["core\fnc\log\inventoryCopy.sqf"];
    btc_log_fnc_inventoryPaste = compileScript ["core\fnc\log\inventoryPaste.sqf"];
    btc_log_fnc_inventoryRestore = compileScript ["core\fnc\log\inventoryRestore.sqf"];

    //REP
    btc_rep_fnc_treatment = compileScript ["core\fnc\rep\treatment.sqf"];

    //RESPAWN
    btc_respawn_fnc_screen = compileScript ["core\fnc\respawn\screen.sqf"];
    btc_respawn_fnc_force = compileScript ["core\fnc\respawn\force.sqf"];
    btc_respawn_fnc_intro = compileScript ["core\fnc\respawn\intro.sqf"];

    //SPECT
    btc_spect_fnc_updateDevice = compileScript ["core\fnc\spect\updateDevice.sqf"];
    btc_spect_fnc_frequencies = compileScript ["core\fnc\spect\frequencies.sqf"];
    btc_spect_fnc_disableDevice = compileScript ["core\fnc\spect\disableDevice.sqf"];

    //ARSENAL
    btc_arsenal_fnc_data = compileScript ["core\fnc\arsenal\data.sqf"];
    btc_arsenal_fnc_garage = compileScript ["core\fnc\arsenal\garage.sqf"];
    btc_arsenal_fnc_loadout = compileScript ["core\fnc\arsenal\loadout.sqf"];
    btc_arsenal_fnc_trait = compileScript ["core\fnc\arsenal\trait.sqf"];
    btc_arsenal_fnc_ammoUsage = compileScript ["core\fnc\arsenal\ammoUsage.sqf"];
    btc_arsenal_fnc_weaponsFilter = compileScript ["core\fnc\arsenal\weaponsfilter.sqf"];

    //TASK
    btc_task_fnc_setDescription = compileScript ["core\fnc\task\setDescription.sqf"];
    btc_task_fnc_abort = compileScript ["core\fnc\task\abort.sqf"];

    //TOW
    btc_tow_fnc_ropeCreate = compileScript ["core\fnc\tow\ropeCreate.sqf"];
    btc_tow_fnc_hitch_points = compileScript ["core\fnc\tow\hitch_points.sqf"];
    btc_tow_fnc_unhook = compileScript ["core\fnc\tow\unhook.sqf"];
    btc_tow_fnc_check = compileScript ["core\fnc\tow\check.sqf"];

    //SLOT
    btc_slot_fnc_deserializeState = compileScript ["core\fnc\slot\deserializeState.sqf"];
};

/////////////////////HEADLESS\\\\\\\\\\\\\\\\\\\\\
if (!hasInterface && !isDedicated) then {
    btc_eh_fnc_headless = compileScript ["core\fnc\eh\headless.sqf"];
};
