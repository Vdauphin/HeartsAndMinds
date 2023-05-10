
/* ----------------------------------------------------------------------------
Function: btc_int_fnc_add_actions

Description:
    Add actions use in game.

Parameters:

Returns:

Examples:
    (begin example)
        _result = [] call btc_int_fnc_add_actions;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */


//Database
private _action = ["Database", localize "STR_BTC_HAM_ACTION_DATA_MAIN", "\A3\ui_f\data\igui\cfg\simpleTasks\letters\D_ca.paa", {}, {(call BIS_fnc_admin) == 2 || !isMultiplayer}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["request_save", localize "str_3den_display3den_menubar_missionsave_text", "\A3\ui_f\data\igui\cfg\simpleTasks\types\download_ca.paa", {[] remoteExecCall ["btc_db_fnc_save", 2]}, {true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "Database"], _action] call ace_interact_menu_fnc_addActionToObject;
_action = ["request_delete", localize "STR_3DEN_Delete", "\A3\ui_f\data\igui\cfg\simpleTasks\types\exit_ca.paa", {[] remoteExecCall ["btc_db_fnc_delete", 2]}, {true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "Database"], _action] call ace_interact_menu_fnc_addActionToObject;

//Intel
_action = ["Search_intel", localize "STR_A3_Showcase_Marksman_BIS_tskIntel_title", "\A3\ui_f\data\igui\cfg\simpleTasks\types\search_ca.paa", {
    [btc_info_fnc_search_for_intel, [_target]] call CBA_fnc_execNextFrame;
}, {!alive _target}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;} forEach (btc_type_units + btc_type_divers);
_action = ["Interrogate_intel", localize "STR_BTC_HAM_ACTION_INTEL_INTERROGATE", "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\instructor_ca.paa", {[_target,true] spawn btc_info_fnc_ask;}, {alive _target && {[_target] call ace_common_fnc_isAwake} && captive _target}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;} forEach (btc_type_units + btc_type_divers);
_action = ["Search_intel", localize "STR_A3_Showcase_Marksman_BIS_tskIntel_title", "\A3\ui_f\data\igui\cfg\simpleTasks\types\search_ca.paa", {
    [btc_info_fnc_search_for_intel, [_target]] call CBA_fnc_execNextFrame;
}, {true}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;} forEach btc_info_intels;

//Log point
{
    _x params ["_object", "_helipad"];

    //Logistic
    _action = ["Logistic", localize "STR_BTC_HAM_ACTION_LOC_MAIN", "\A3\ui_f\data\igui\cfg\simpleTasks\letters\L_ca.paa", {}, {true}] call ace_interact_menu_fnc_createAction;
    [_object, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
    _action = ["Require_object", localize "STR_BTC_HAM_ACTION_LOGPOINT_REQOBJ", "\A3\ui_f\data\igui\cfg\simpleTasks\letters\D_ca.paa", {
        params ["", "", "_params"];
        _params spawn btc_log_fnc_create
    }, {true}, {}, [_helipad], [0, 0, 0.4], 5] call ace_interact_menu_fnc_createAction;
    [_object, 0, ["ACE_MainActions", "Logistic"], _action] call ace_interact_menu_fnc_addActionToObject;
    _action = ["Repair_wreck", localize "STR_BTC_HAM_ACTION_LOGPOINT_REPWRECK", "\A3\ui_f\data\igui\cfg\simpleTasks\types\repair_ca.paa", {
        params ["", "", "_params"];
        _params call btc_log_fnc_repair_wreck
    }, {true}, {}, [_helipad], [0, 0, 0], 5] call ace_interact_menu_fnc_createAction;
    [_object, 0, ["ACE_MainActions", "Logistic"], _action] call ace_interact_menu_fnc_addActionToObject;
    _action = ["Refuel", localize "STR_BTC_HAM_ACTION_LOGPOINT_REFUELSOURCE", "\A3\ui_f\data\igui\cfg\simpleTasks\types\refuel_ca.paa", {
        params ["", "", "_params"];
        _params call btc_log_fnc_refuelSource
    }, {true}, {}, [_helipad], [0, 0, 0], 5] call ace_interact_menu_fnc_createAction;
    [_object, 0, ["ACE_MainActions", "Logistic"], _action] call ace_interact_menu_fnc_addActionToObject;
    _action = ["Rearm", localize "STR_BTC_HAM_ACTION_LOGPOINT_REARMSOURCE", "\A3\ui_f\data\igui\cfg\simpleTasks\types\rearm_ca.paa", {
        params ["", "", "_params"];
        _params call btc_log_fnc_rearmSource
    }, {true}, {}, [_helipad], [0, 0, 0], 5] call ace_interact_menu_fnc_createAction;
    [_object, 0, ["ACE_MainActions", "Logistic"], _action] call ace_interact_menu_fnc_addActionToObject;
    _action = ["Require_veh", localize "STR_BTC_HAM_ACTION_LOGPOINT_REQVEH", "\A3\ui_f\data\map\vehicleicons\iconCar_ca.paa", {
        params ["", "", "_params"];
        _params spawn btc_arsenal_fnc_garage
    }, {(serverCommandAvailable "#logout" || !isMultiplayer) and btc_p_garage}, {}, [_helipad], [0, 0, 0], 5] call ace_interact_menu_fnc_createAction;
    [_object, 0, ["ACE_MainActions", "Logistic"], _action] call ace_interact_menu_fnc_addActionToObject;
    _action = ["Require_delete", localize "STR_3DEN_Delete", "\z\ace\addons\arsenal\data\iconClearContainer.paa", {
        params ["", "", "_params"];
        _params call btc_log_fnc_delete
    }, {true}, {}, [_helipad], [0, 0, 0.4], 5] call ace_interact_menu_fnc_createAction;
    [_object, 0, ["ACE_MainActions", "Logistic"], _action] call ace_interact_menu_fnc_addActionToObject;

    //Tool
    _action = ["Tool", localize "str_3den_display3den_menubar_tools_text", "\A3\ui_f\data\igui\cfg\simpleTasks\letters\T_ca.paa", {}, {true}] call ace_interact_menu_fnc_createAction;
    [_object, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
    _action = ["Copy_container", localize "STR_BTC_HAM_ACTION_COPYPASTE_COPY", "\A3\ui_f\data\igui\cfg\simpleTasks\types\download_ca.paa", {
        params ["", "", "_params"];
        _params call btc_log_fnc_copy
    }, {true}, {}, [_helipad], [0, 0, 0.4], 5] call ace_interact_menu_fnc_createAction;
    [_object, 0, ["ACE_MainActions", "Tool"], _action] call ace_interact_menu_fnc_addActionToObject;
    _action = ["Paste_container", localize "STR_BTC_HAM_ACTION_COPYPASTE_PASTE", "\A3\ui_f\data\igui\cfg\simpleTasks\types\upload_ca.paa", {
        params ["", "", "_params"];
        [btc_copy_container, _params] call btc_log_fnc_paste
    }, {!isNil "btc_copy_container"}, {}, _helipad, [0, 0, 0.4], 5] call ace_interact_menu_fnc_createAction;
    [_object, 0, ["ACE_MainActions", "Tool"], _action] call ace_interact_menu_fnc_addActionToObject;
    _action = ["Copy_inventory", localize "STR_BTC_HAM_ACTION_COPYPASTE_COPYI", "\A3\ui_f\data\igui\cfg\simpleTasks\types\download_ca.paa", {
        params ["", "", "_params"];
        _params call btc_log_fnc_inventoryCopy
    }, {true}, {}, [_helipad], [0, 0, 0.4], 5] call ace_interact_menu_fnc_createAction;
    [_object, 0, ["ACE_MainActions", "Tool"], _action] call ace_interact_menu_fnc_addActionToObject;
    _action = ["Paste_inventory", localize "STR_BTC_HAM_ACTION_COPYPASTE_PASTEI", "\A3\ui_f\data\igui\cfg\simpleTasks\types\upload_ca.paa", {
        params ["", "", "_params"];
        [btc_copy_inventory, _params] call btc_log_fnc_inventoryPaste
    }, {!isNil "btc_copy_inventory"}, {}, _helipad, [0, 0, 0.4], 5] call ace_interact_menu_fnc_createAction;
    [_object, 0, ["ACE_MainActions", "Tool"], _action] call ace_interact_menu_fnc_addActionToObject;
    _action = ["Restore_inventory", localize "STR_BTC_HAM_ACTION_RESTOREI", "\A3\Ui_f\data\GUI\Cfg\KeyframeAnimation\IconCurve_CA.paa", {
        params ["", "", "_params"];
        _params call btc_log_fnc_inventoryRestore
    }, {true}, {}, _helipad, [0, 0, 0.4], 5] call ace_interact_menu_fnc_createAction;
    [_object, 0, ["ACE_MainActions", "Tool"], _action] call ace_interact_menu_fnc_addActionToObject;

    //Bodybag
    if (btc_p_respawn_ticketsAtStart isNotEqualTo -1) then {
        _action = ["Bodybag", localize "STR_BTC_HAM_ACTION_LOGPOINT_BODYBAG", "\A3\Data_F_AoW\Logos\arma3_aow_logo_ca.paa", {
            params ["", "", "_params"];
            _params call btc_body_fnc_bagRecover;
        }, {true}, {}, [_helipad], [0, 0, 0], 5] call ace_interact_menu_fnc_createAction;
        [_object, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
    };
} forEach [[btc_create_object, btc_create_object_point]];

//Place
_action = ["Logistic", localize "STR_BTC_HAM_ACTION_LOC_MAIN", "\A3\ui_f\data\igui\cfg\simpleTasks\letters\L_ca.paa", {}, {true}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;} forEach btc_log_def_loadable;
_action = ["Place", localize "STR_ACE_Dragging_Carry", "\z\ace\addons\dragging\UI\icons\box_carry.paa", {_target call btc_log_fnc_place}, {!btc_log_placing && !(player getVariable ["ace_dragging_isCarrying", false])}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;} forEach btc_log_def_placeable;

//Shower
_action = ["Shower_act", getText(configfile >> "CfgVehicles" >> "DeconShower_01_F" >> "UserActions" >> "Activate" >> "displayName"), "", {player playActionNow 'PutDown'; [_target, 1.5, 9] remoteExec ["BIN_fnc_deconShowerAnim", 0]}, {alive _target AND {_target animationSourcePhase 'valve_source' isEqualTo 0}}] call ace_interact_menu_fnc_createAction;
["DeconShower_01_F", 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;
_action = ["Shower_act", getText(configfile >> "CfgVehicles" >> "DeconShower_02_F" >> "UserActions" >> "Activate" >> "displayName"), "", {player playActionNow 'PutDown'; [_target, 5.4, 4, 2, true] remoteExec ["BIN_fnc_deconShowerAnimLarge", 0]}, {alive _target AND {_target animationSourcePhase 'valve_source' isEqualTo 0}}] call ace_interact_menu_fnc_createAction;
["DeconShower_02_F", 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;
{
    _action = ["Shower_desact", getText(configfile >> "CfgVehicles" >> "DeconShower_01_F" >> "UserActions" >> "Deactivate" >> "displayName"), "", {player playActionNow 'PutDown'; [_target] remoteExecCall ["BIN_fnc_deconShowerAnimStop", 0]}, {alive _target AND {_target animationSourcePhase 'valve_source' > 0}}] call ace_interact_menu_fnc_createAction;
    [_x, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;
} forEach ["DeconShower_01_F", "DeconShower_02_F"];

//FOB
_action = ["Mount_FOB", localize "STR_BTC_HAM_ACTION_FOB_MOUNT", "\A3\Ui_f\data\Map\Markers\NATO\b_hq.paa", {_target spawn btc_fob_fnc_create}, {!btc_log_placing && !(player getVariable ["ace_dragging_isCarrying", false])}] call ace_interact_menu_fnc_createAction;
[btc_fob_mat, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;
_action = ["Dismantle_FOB", localize "STR_BTC_HAM_ACTION_FOB_DISMANTLE", "", {_target remoteExecCall ["btc_fob_fnc_dismantle_s", 2]}, {true}, {}, [], [0, 0, -2], 5] call ace_interact_menu_fnc_createAction;
[btc_fob_flag, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;

//Orders
_action = ["Civil_Orders", localize "STR_BTC_HAM_ACTION_ORDERS_MAIN", "\A3\ui_f\data\igui\cfg\simpleTasks\types\meet_ca.paa", {}, {true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["Civil_Stop", localize "STR_BTC_HAM_ACTION_ORDERS_STOP", "\A3\ui_f\data\igui\cfg\simpleTasks\types\talk3_ca.paa", {[1] call btc_int_fnc_orders;}, {vehicle player isEqualTo player}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "Civil_Orders"], _action] call ace_interact_menu_fnc_addActionToObject;
_action = ["Civil_Get_down", localize "STR_BTC_HAM_ACTION_ORDERS_GETDOWN", "\A3\ui_f\data\igui\cfg\simpleTasks\types\talk2_ca.paa", {[2] call btc_int_fnc_orders;}, {vehicle player isEqualTo player}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "Civil_Orders"], _action] call ace_interact_menu_fnc_addActionToObject;
_action = ["Civil_Go_away", localize "STR_BTC_HAM_ACTION_ORDERS_GOAWAY", "\A3\ui_f\data\igui\cfg\simpleTasks\types\talk1_ca.paa", {[3] call btc_int_fnc_orders;}, {vehicle player isEqualTo player}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "Civil_Orders"], _action] call ace_interact_menu_fnc_addActionToObject;

{ //Actions attachted to AI
    _action = ["Civil_Orders", localize "STR_BTC_HAM_ACTION_ORDERS_MAIN", "\A3\ui_f\data\igui\cfg\simpleTasks\types\meet_ca.paa", {}, {true}] call ace_interact_menu_fnc_createAction;
    [_x, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;
    _action = ["Civil_taxi", localize "STR_BTC_HAM_ACTION_ORDERS_TAXI", "\A3\ui_f\data\igui\cfg\simpleTasks\types\talk4_ca.paa", {[4, _target] call btc_int_fnc_orders;}, {(alive _target) && (vehicle _target) isNotEqualTo _target}] call ace_interact_menu_fnc_createAction;
    [_x, 0, ["ACE_MainActions", "Civil_Orders"], _action] call ace_interact_menu_fnc_addActionToClass;
    _action = ["Civil_Stop", localize "STR_BTC_HAM_ACTION_ORDERS_STOP", "\A3\ui_f\data\igui\cfg\simpleTasks\types\talk3_ca.paa", {[1, _target] call btc_int_fnc_orders;}, {alive _target}] call ace_interact_menu_fnc_createAction;
    [_x, 0, ["ACE_MainActions", "Civil_Orders"], _action] call ace_interact_menu_fnc_addActionToClass;
    _action = ["Civil_Get_down", localize "STR_BTC_HAM_ACTION_ORDERS_GETDOWN", "\A3\ui_f\data\igui\cfg\simpleTasks\types\talk2_ca.paa", {[2, _target] call btc_int_fnc_orders;}, {alive _target}] call ace_interact_menu_fnc_createAction;
    [_x, 0, ["ACE_MainActions", "Civil_Orders"], _action] call ace_interact_menu_fnc_addActionToClass;
    _action = ["Civil_Go_away", localize "STR_BTC_HAM_ACTION_ORDERS_GOAWAY", "\A3\ui_f\data\igui\cfg\simpleTasks\types\talk1_ca.paa", {[3, _target] call btc_int_fnc_orders;}, {alive _target}] call ace_interact_menu_fnc_createAction;
    [_x, 0, ["ACE_MainActions", "Civil_Orders"], _action] call ace_interact_menu_fnc_addActionToClass;
    _action = ["Ask_Info", localize "STR_BTC_HAM_ACTION_ORDERS_ASKINFO", "\A3\ui_f\data\igui\cfg\simpleTasks\types\talk_ca.paa", {[_target,false] spawn btc_info_fnc_ask;}, {alive _target && {[_target] call ace_common_fnc_isAwake} && {side _target isEqualTo civilian}}] call ace_interact_menu_fnc_createAction;
    [_x, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;
    _action = ["Ask_Reputation", localize "STR_BTC_HAM_ACTION_ORDERS_ASKREP", "\A3\ui_f\data\igui\cfg\simpleTasks\types\talk_ca.paa", {[_target] spawn btc_info_fnc_ask_reputation;}, {alive _target && {[_target] call ace_common_fnc_isAwake} && {side _target isEqualTo civilian}}] call ace_interact_menu_fnc_createAction;
    [_x, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;
    _action = ["Give_food", localize "STR_BTC_HAM_ACTION_GIVEFOOD", "\z\ace\addons\common\data\icon_banana_ca.paa", {[player, _target] call btc_int_fnc_foodGive}, {alive _target && {"ACE_Banana" in items player}}] call ace_interact_menu_fnc_createAction;
    [_x, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;

    //remove ace3 "get down" order
    [_x, 0, ["ACE_MainActions", "ACE_GetDown"]] call ace_interact_menu_fnc_removeActionFromClass;
    //remove ace3 "go away" order
    [_x, 0, ["ACE_MainActions", "ACE_SendAway"]] call ace_interact_menu_fnc_removeActionFromClass;
} forEach btc_civ_type_units;

//Side missions
_action = ["side_mission", localize "STR_BTC_HAM_DOC_SIDEMISSION_TITLE", "\A3\ui_f\data\igui\cfg\simpleTasks\types\whiteboard_ca.paa", {}, {player getVariable ["side_mission", false]}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;
_action = ["side_mission_abort", localize "STR_BTC_HAM_ACTION_SIDEMISSION_ABORT", "\A3\ui_f\data\igui\cfg\simpleTasks\types\exit_ca.paa", {[player call BIS_fnc_taskCurrent] call btc_task_fnc_abort}, {player getVariable ["side_mission", false]}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "side_mission"], _action] call ace_interact_menu_fnc_addActionToObject;
_action = ["side_mission_request", localize "STR_BTC_HAM_ACTION_SIDEMISSION_REQ", "\A3\ui_f\data\igui\cfg\simpleTasks\types\default_ca.paa", {[] remoteExec ["btc_side_fnc_create", 2]}, {player getVariable ["side_mission", false]}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "side_mission"], _action] call ace_interact_menu_fnc_addActionToObject;

//Debug
if (btc_debug) then {
    _action = ["Debug_graph", "Disable debug graph", "\a3\Ui_f\data\GUI\Rsc\RscDisplayMissionEditor\iconCamera_ca.paa", {btc_debug_graph = !btc_debug_graph}, {btc_debug_graph}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;
    _action = ["Debug_graph", "Enable debug graph", "\a3\Ui_f\data\GUI\Rsc\RscDisplayMissionEditor\iconCamera_ca.paa", {btc_debug_graph = true; 73001 cutRsc ["TER_fpscounter", "PLAIN"];}, {!btc_debug_graph}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;
};

//Re-deploy
private _actions = [];
_actions pushBack ["redeploy", localize "STR_BTC_HAM_ACTION_BIRESPAWN", "\A3\ui_f\data\igui\cfg\simpleTasks\types\run_ca.paa", {
    if ([] call btc_fob_fnc_redeployCheck) then {
        [] call btc_respawn_fnc_force;
    };
}, {!btc_log_placing && !(player getVariable ["ace_dragging_isCarrying", false])}];
_actions pushBack ["base", localize "STR_BTC_HAM_ACTION_REDEPLOYBASE", getText (configfile >> "CfgMarkers" >> getMarkerType "btc_base" >> "icon"), {
    if ([] call btc_fob_fnc_redeployCheck) then {[_player, btc_respawn_marker, false] call BIS_fnc_moveToRespawnPosition};
}, {!btc_log_placing && !(player getVariable ["ace_dragging_isCarrying", false])}, btc_fob_fnc_redeploy, "Base"];
_actions pushBack ["rallypoints", localize "STR_BTC_HAM_ACTION_REDEPLOYRALLY", "\A3\ui_f\data\igui\cfg\simpleTasks\types\wait_ca.paa", {}, {!btc_log_placing && !(player getVariable ["ace_dragging_isCarrying", false])}, btc_fob_fnc_redeploy, ""];
_actions pushBack ["FOB", localize "STR_BTC_HAM_ACTION_REDEPLOYFOB", "\A3\Ui_f\data\Map\Markers\NATO\b_hq.paa", {}, {!btc_log_placing && !(player getVariable ["ace_dragging_isCarrying", false])}];
{
    private _action = _x call ace_interact_menu_fnc_createAction;
    [btc_gear_object, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
    if (btc_p_respawn_fromFOBToBase) then {
        [btc_fob_flag, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;
    };
} forEach _actions;
{
    _x params ["_cardinal", "_degrees"];

    _action = ["FOB" + _cardinal, localize _cardinal, "\A3\ui_f\data\igui\cfg\simpleTasks\types\map_ca.paa", {}, {true}, btc_fob_fnc_redeploy, _degrees] call ace_interact_menu_fnc_createAction;
    [btc_gear_object, 0, ["ACE_MainActions", "FOB"], _action] call ace_interact_menu_fnc_addActionToObject;
    if (btc_p_respawn_fromFOBToBase) then {
        [btc_fob_flag, 0, ["ACE_MainActions", "FOB"], _action] call ace_interact_menu_fnc_addActionToClass;
    };
} forEach [["str_q_north_east", [0, 90]], ["str_q_south_east", [90, 180]], ["str_q_south_west", [180, 270]], ["str_q_north_west", [270, 360]]];

//Arsenal
//BIS
if (btc_p_arsenal_Type < 3) then {
    btc_gear_object addAction [localize "STR_BTC_HAM_ACTION_ARSENAL_OPEN_BIS", "['Open', [btc_p_arsenal_Restrict isNotEqualTo 1, _this select 0]] call bis_fnc_arsenal;"];
};
//ACE
if (btc_p_arsenal_Type > 0) then {
    [btc_gear_object, btc_p_arsenal_Restrict isNotEqualTo 1, false] call ace_arsenal_fnc_initBox;
    if (btc_p_arsenal_Type in [2, 4]) then {
        btc_gear_object addAction [localize "STR_BTC_HAM_ACTION_ARSENAL_OPEN_ACE", "[btc_gear_object, player] call ace_arsenal_fnc_openBox;"];
    };
};
if (btc_p_arsenal_Restrict isNotEqualTo 0) then {[btc_gear_object, btc_p_arsenal_Type, btc_p_arsenal_Restrict, btc_custom_arsenal] call btc_arsenal_fnc_data;};

//Door
_action = ["door_break", localize "STR_BTC_HAM_ACTION_DOOR_BREAK", "\A3\Ui_f\data\IGUI\Cfg\Actions\open_door_ca.paa", {
    [btc_door_fnc_break] call CBA_fnc_execNextFrame;
}, {"ACE_wirecutter" in items player}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "ACE_Equipment"], _action] call ace_interact_menu_fnc_addActionToObject;

//Flag
if (btc_p_flag > 1) then {
    private _action = ["btc_flag_deployPlayer", localize "STR_BTC_HAM_ACTION_VEHINIT_DEPLOYFLAG", "\A3\ui_f\data\map\markers\handdrawn\flag_CA.paa", {}, {getForcedFlagTexture _target isEqualTo ""}, btc_flag_fnc_deploy] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions", "ACE_Equipment"], _action] call ace_interact_menu_fnc_addActionToObject;
    _action = ["btc_flag_cutPlayer", localize "STR_BTC_HAM_ACTION_VEHINIT_CUTFLAG", "\A3\ui_f\data\map\markers\handdrawn\flag_CA.paa", {
        _target forceFlagTexture "";
    }, {getForcedFlagTexture _target isNotEqualTo ""}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions", "ACE_Equipment"], _action] call ace_interact_menu_fnc_addActionToObject;
};

//Change day time and weather
_action = ["env_menu", localize "str_a3_credits_environment", "", {}, {player getVariable ["side_mission", false] && (btc_p_change_time || btc_p_change_weather)}] call ace_interact_menu_fnc_createAction;
[btc_gear_object, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
_action = ["set_day", localize "STR_BTC_HAM_ACTION_SET_DAY", "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\Watch_ca.paa", {
    private _hour = date call BIS_fnc_sunriseSunsetTime select 0;
    ((_hour + 1 - dayTime + 24) % 24) remoteExecCall ["skipTime", 2];
}, {btc_p_change_time && player getVariable ["side_mission", false]}] call ace_interact_menu_fnc_createAction;
[btc_gear_object, 0, ["ACE_MainActions", "env_menu"], _action] call ace_interact_menu_fnc_addActionToObject;
_action = ["set_night", localize "STR_BTC_HAM_ACTION_SET_NIGHT", "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\Watch_ca.paa", {
    private _hour = date call BIS_fnc_sunriseSunsetTime select 1;
    ((_hour + 1 - dayTime + 24) % 24) remoteExecCall ["skipTime", 2];
}, {btc_p_change_time && player getVariable ["side_mission", false]}] call ace_interact_menu_fnc_createAction;

[btc_gear_object, 0, ["ACE_MainActions", "env_menu"], _action] call ace_interact_menu_fnc_addActionToObject;
_action = ["set_weather", localize "STR_BTC_HAM_ACTION_CHANGE_WEATHER", "a3\3den\data\attributes\slidertimeday\sun_ca.paa", {[] remoteExecCall ["btc_fnc_changeWeather", 2]}, {btc_p_change_weather && player getVariable ["side_mission", false]}] call ace_interact_menu_fnc_createAction;
[btc_gear_object, 0, ["ACE_MainActions","env_menu"], _action] call ace_interact_menu_fnc_addActionToObject;
