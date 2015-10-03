/*

*/

closeDialog 0;
disableSerialization;
_dlg = createDialog "btc_dlg_interaction";
_ui = uiNamespace getVariable "btc_dlg_interaction";
waitUntil {Dialog};

switch (_this) do {
/*	case 0 : {
		{(_ui displayCtrl _x) ctrlShow false;} foreach [9993,9994,9995,9996];
		(_ui displayCtrl 9991) ctrlSetText "Treatment";
		(_ui displayCtrl 9991) buttonSetAction "1 spawn btc_fnc_int_open_dlg;";
		if (vehicle player != player) then
		{
			if !(player in (assignedCargo vehicle player)) then {(_ui displayCtrl 9991) ctrlEnable false;};
		};
		
		if (player getVariable ["btc_hasEarplugs",false]) then {(_ui displayCtrl 9992) ctrlSetText "Remove earplugs";} else {(_ui displayCtrl 9992) ctrlSetText "Use earplugs";};
		(_ui displayCtrl 9992) buttonSetAction "[] spawn btc_fnc_deaf_earplugs";
		
		if (vehicle player == player) then
		{
			(_ui displayCtrl 9993) ctrlShow true;
			(_ui displayCtrl 9993) ctrlSetText "Orders";
			(_ui displayCtrl 9993) buttonSetAction "3 spawn btc_fnc_int_open_dlg;";
			
			if (player getVariable ["btc_int_busy",false]) then {(_ui displayCtrl 9991) ctrlEnable false;(_ui displayCtrl 9992) ctrlEnable false;(_ui displayCtrl 9993) ctrlEnable false;};
			if (player getVariable ["btc_rev_isDragging",false] || player getVariable ["btc_rev_isCarrying",false]) then 
			{
				(_ui displayCtrl 9994) ctrlShow true;
				(_ui displayCtrl 9994) ctrlSetText "Release";
				(_ui displayCtrl 9994) buttonSetAction "closeDialog 0;player setVariable ['btc_rev_isDragging',false];player setVariable ['btc_rev_isCarrying',false];";			
				//LOAD
				if (((count (nearestObjects [player, ["Air","LandVehicle"], 5])) > 0) && {(((nearestObjects [player, ["Air","LandVehicle"], 5]) select 0) emptyPositions "cargo" > 0)}) then
				{
					(_ui displayCtrl 9995) ctrlShow true;
					(_ui displayCtrl 9995) ctrlSetText "Load wounded";
					(_ui displayCtrl 9995) buttonSetAction "(player getVariable ['btc_rev_attached',objNull]) spawn btc_fnc_rev_load";
				};
			};
		} 
		else //IN VEH
		{
			(_ui displayCtrl 9993) ctrlShow true;
			(_ui displayCtrl 9993) ctrlSetText "Check Cargo";
			(_ui displayCtrl 9993) buttonSetAction "(vehicle player) spawn btc_fnc_log_check_cargo";
			
			if (vehicle player isKindOf "Helicopter" && {driver vehicle player == player}) then 
			{
				if (btc_ropes_deployed) then 
				{
					(_ui displayCtrl 9994) ctrlShow true;
					(_ui displayCtrl 9994) ctrlSetText "Cut ropes";
					(_ui displayCtrl 9994) buttonSetAction "[] spawn btc_fnc_log_lift_destroy_ropes";				
				}
				else 
				{
					(_ui displayCtrl 9994) ctrlShow true;
					(_ui displayCtrl 9994) ctrlSetText "Deploy ropes";
					(_ui displayCtrl 9994) buttonSetAction "[] spawn btc_fnc_log_lift_deploy_ropes";
					if (getpos (vehicle player) select 2 < 5) then {(_ui displayCtrl 9994) ctrlEnable false;};
				};
			};
		};
		if !(isNil {player getVariable "side_mission"}) then
		{
			(_ui displayCtrl 9996) ctrlShow true;
			if (btc_side_assigned) then 
			{
				(_ui displayCtrl 9996) ctrlSetText "Abort side mission";
				(_ui displayCtrl 9996) buttonSetAction "[] spawn btc_fnc_side_abort";				
			} 
			else
			{
				(_ui displayCtrl 9996) ctrlSetText "Request side mission";
				(_ui displayCtrl 9996) buttonSetAction "[] spawn btc_fnc_side_request";		
			};
		};
	};
	case 1 : {
		//TREATMENT
		//btc_int_target spawn btc_rev_fn_examine_result;
		(_ui displayCtrl 9991) ctrlSetText "Examine";
		(_ui displayCtrl 9991) buttonSetAction "[] spawn btc_fnc_rev_examine;";
		/*if (btc_wounds_mod) then
		{
			_n_items = {_x == "BTC_w_bandage"} count items player;
			(_ui displayCtrl 9992) ctrlSetText format ["Bandage",_n_items];
			(_ui displayCtrl 9992) buttonSetAction "[btc_int_target,1] spawn btc_fnc_rev_treat";
			if (_n_items == 0) then {(_ui displayCtrl 9992) ctrlEnable false;};
			
			_n_items = {_x == "BTC_w_largeBandage"} count items player;
			(_ui displayCtrl 9993) ctrlSetText format ["Large Bandage",_n_items];
			(_ui displayCtrl 9993) buttonSetAction "[btc_int_target,2] spawn btc_fnc_rev_treat";
			if (_n_items == 0 || (!(player call btc_fnc_rev_is_medic) && {btc_rev_lbndg_only_medic})) then {(_ui displayCtrl 9993) ctrlEnable false;};
			
			_n_items = {_x == "BTC_w_mor"} count items player;
			(_ui displayCtrl 9994) ctrlSetText format ["Morphine",_n_items];
			(_ui displayCtrl 9994) buttonSetAction "[btc_int_target,3] spawn btc_fnc_rev_treat";
			if (_n_items == 0 || (!(player call btc_fnc_rev_is_medic) && {btc_rev_mor_only_medic})) then {(_ui displayCtrl 9994) ctrlEnable false;};
			
			_n_items = {_x == "BTC_w_epi"} count items player;
			(_ui displayCtrl 9995) ctrlSetText format ["Epinephrine",_n_items];
			(_ui displayCtrl 9995) buttonSetAction "[btc_int_target,4] spawn btc_fnc_rev_treat";
			if (_n_items == 0 || (!(player call btc_fnc_rev_is_medic) && {btc_rev_epi_only_medic})) then {(_ui displayCtrl 9995) ctrlEnable false;};
			
			_n_items = {_x == "BTC_w_bloodbag"} count items player;
			(_ui displayCtrl 9996) ctrlSetText format ["Blood Bag",_n_items];
			(_ui displayCtrl 9996) buttonSetAction "[btc_int_target,5] spawn btc_fnc_rev_treat";
			if (_n_items == 0 || (!(player call btc_fnc_rev_is_medic) && {btc_rev_blood_only_medic})) then {(_ui displayCtrl 9996) ctrlEnable false;};		
		}
		else
		{
			(_ui displayCtrl 9992) ctrlSetText "Bandage";
			(_ui displayCtrl 9992) buttonSetAction "[btc_int_target,1] spawn btc_fnc_rev_treat";
			
			(_ui displayCtrl 9993) ctrlSetText "Large Bandage";
			(_ui displayCtrl 9993) buttonSetAction "[btc_int_target,2] spawn btc_fnc_rev_treat";
			if ((!(player call btc_fnc_rev_is_medic) && {btc_rev_lbndg_only_medic}) || (btc_rev_medikit_required && {{_x == "Medikit"} count items player == 0})) then {(_ui displayCtrl 9993) ctrlEnable false;};
			
			(_ui displayCtrl 9994) ctrlSetText "Morphine";
			(_ui displayCtrl 9994) buttonSetAction "[btc_int_target,3] spawn btc_fnc_rev_treat";
			if ((!(player call btc_fnc_rev_is_medic) && {btc_rev_mor_only_medic}) || (btc_rev_medikit_required && {{_x == "Medikit"} count items player == 0})) then {(_ui displayCtrl 9994) ctrlEnable false;};
			
			(_ui displayCtrl 9995) ctrlSetText "Epinephrine";
			(_ui displayCtrl 9995) buttonSetAction "[btc_int_target,4] spawn btc_fnc_rev_treat";
			if ((!(player call btc_fnc_rev_is_medic) && {btc_rev_epi_only_medic}) || (btc_rev_medikit_required && {{_x == "Medikit"} count items player == 0})) then {(_ui displayCtrl 9995) ctrlEnable false;};
			
			(_ui displayCtrl 9996) ctrlSetText "Blood Bag";
			(_ui displayCtrl 9996) buttonSetAction "[btc_int_target,5] spawn btc_fnc_rev_treat";
			if ((!(player call btc_fnc_rev_is_medic) && {btc_rev_blood_only_medic}) || (btc_rev_medikit_required && {{_x == "Medikit"} count items player == 0})) then {(_ui displayCtrl 9996) ctrlEnable false;};
		//};
	};*/
	case 2 : {
		//Players
		{(_ui displayCtrl _x) ctrlShow false;} foreach [9995,9996];
		(_ui displayCtrl 9991) ctrlSetText "Treatment";
		(_ui displayCtrl 9991) buttonSetAction "1 spawn btc_fnc_int_open_dlg;";
		(_ui displayCtrl 9992) ctrlSetText "Drag";
		(_ui displayCtrl 9992) buttonSetAction "btc_int_target spawn btc_fnc_rev_drag";
		(_ui displayCtrl 9993) ctrlSetText "Carry";
		(_ui displayCtrl 9993) buttonSetAction "btc_int_target spawn btc_fnc_rev_carry";
		(_ui displayCtrl 9994) ctrlSetText "Load in";
		(_ui displayCtrl 9994) buttonSetAction "btc_int_target spawn btc_fnc_rev_load";
		if !(btc_int_target getVariable ["btc_rev_isUnc",false]) then {(_ui displayCtrl 9992) ctrlEnable false;(_ui displayCtrl 9993) ctrlEnable false;(_ui displayCtrl 9994) ctrlEnable false;} else
		{
			if (((count (nearestObjects [player, ["Air","LandVehicle"], 5])) > 0) && {(((nearestObjects [player, ["Air","LandVehicle"], 5]) select 0) emptyPositions "cargo" > 0)}) then {(_ui displayCtrl 9994) ctrlSetText format ["Load in %1",getText (configFile >> "cfgVehicles" >> typeof ((nearestObjects [player, ["Air","LandVehicle"], 5]) select 0) >> "displayName")];} else {(_ui displayCtrl 9994) ctrlEnable false;};
		};
	};
	case 3 :
	{
		//Orders
		{(_ui displayCtrl _x) ctrlShow false;} foreach [9994,9995,9996];
		(_ui displayCtrl 9991) ctrlSetText "Stop";
		(_ui displayCtrl 9991) buttonSetAction "[1] spawn btc_fnc_int_orders";
		(_ui displayCtrl 9992) ctrlSetText "Get down";
		(_ui displayCtrl 9992) buttonSetAction "[2] spawn btc_fnc_int_orders";
		(_ui displayCtrl 9993) ctrlSetText "Go away";
		(_ui displayCtrl 9993) buttonSetAction "[3] spawn btc_fnc_int_orders";
		/*(_ui displayCtrl 9993) ctrlSetText "Hands up";
		(_ui displayCtrl 9993) buttonSetAction "[4] spawn btc_fnc_int_orders";*/

	};
	case 4 :
	{
		{(_ui displayCtrl _x) ctrlShow false;} foreach [9995,9996];
		(_ui displayCtrl 9991) ctrlSetText "Ask info";
		(_ui displayCtrl 9991) buttonSetAction "[] spawn btc_fnc_info_ask;closeDialog 0;";	
		(_ui displayCtrl 9992) ctrlSetText "Stop";
		(_ui displayCtrl 9992) buttonSetAction "[1,btc_int_target] spawn btc_fnc_int_orders";
		(_ui displayCtrl 9993) ctrlSetText "Get down";
		(_ui displayCtrl 9993) buttonSetAction "[2,btc_int_target] spawn btc_fnc_int_orders";
		(_ui displayCtrl 9994) ctrlSetText "Go away";
		(_ui displayCtrl 9994) buttonSetAction "[3,btc_int_target] spawn btc_fnc_int_orders";
		if (!Alive btc_int_target) then {{(_ui displayCtrl _x) ctrlEnable false;} foreach [9991,9992,9993,9994]};
	};
	case 5 :
	{
		{(_ui displayCtrl _x) ctrlShow false;} foreach [9993,9994,9995,9996];
		(_ui displayCtrl 9991) ctrlSetText "Check for IED";
		(_ui displayCtrl 9991) buttonSetAction "btc_int_target spawn btc_fnc_ied_check_for;closeDialog 0;";	
		(_ui displayCtrl 9992) ctrlSetText "Disarm IED";
		(_ui displayCtrl 9992) buttonSetAction "btc_int_target spawn btc_fnc_ied_disarm;closeDialog 0;";
		if (!(btc_int_target getVariable ["active",false]) || {_x == "ToolKit"} count items player == 0) then {(_ui displayCtrl 9992) ctrlEnable false;};
	};
	case 6 :
	{
		{(_ui displayCtrl _x) ctrlShow false;} foreach [9992,9993,9994,9995,9996];
		(_ui displayCtrl 9991) ctrlSetText "Search for intel";
		(_ui displayCtrl 9991) buttonSetAction "btc_int_target spawn btc_fnc_info_search_for_intel;closeDialog 0;";	
	};
	case 7 :
	{
		{(_ui displayCtrl _x) ctrlShow false;} foreach [9991,9992,9993,9994,9995,9996];
		if (Alive btc_int_target) then
		{
			//UNLOAD
			(_ui displayCtrl 9991) ctrlShow true;
			(_ui displayCtrl 9991) ctrlSetText "Unload wounded";
			(_ui displayCtrl 9991) buttonSetAction "btc_int_target spawn btc_fnc_rev_unload";
			if (({_x getVariable ["btc_rev_isUnc",false]} count (crew btc_int_target)) == 0) then {(_ui displayCtrl 9991) ctrlEnable false;};

			(_ui displayCtrl 9992) ctrlShow true;
			(_ui displayCtrl 9992) ctrlSetText "Check Cargo";
			(_ui displayCtrl 9992) buttonSetAction "btc_int_target spawn btc_fnc_log_check_cargo";
			if (!isNull btc_log_object_selected) then 
			{
				(_ui displayCtrl 9993) ctrlShow true;
				(_ui displayCtrl 9993) ctrlSetText format ["Load %1 in %2",getText (configFile >> "cfgVehicles" >> typeof btc_log_object_selected >> "displayName"),getText (configFile >> "cfgVehicles" >> typeof btc_int_target >> "displayName")];
				(_ui displayCtrl 9993) buttonSetAction "[] spawn btc_fnc_log_load";
				if (btc_log_object_selected distance btc_int_target > btc_log_max_distance_load) then {(_ui displayCtrl 9993) ctrlEnable false;};
			};
		};
		btc_int_ask_data = nil;
		[[4,btc_int_target,player],"btc_fnc_int_ask_var",false] spawn BIS_fnc_MP;

		waitUntil {!(isNil "btc_int_ask_data")};
		
		if (!isNull btc_int_ask_data) then
		{
			(_ui displayCtrl 9994) ctrlShow true;
			(_ui displayCtrl 9994) ctrlSetText "Unhook";
			(_ui displayCtrl 9994) buttonSetAction "btc_int_target spawn btc_fnc_log_unhook";
		}
		else
		{
			if (btc_int_target isKindOf "LandVehicle") then
			{
				(_ui displayCtrl 9994) ctrlShow true;
				(_ui displayCtrl 9994) ctrlSetText "Hook";
				(_ui displayCtrl 9994) buttonSetAction "btc_int_target spawn btc_fnc_log_hook";
				if (!isNull btc_log_vehicle_selected && {btc_log_vehicle_selected != btc_int_target}) then
				{
					(_ui displayCtrl 9995) ctrlShow true;
					(_ui displayCtrl 9995) ctrlSetText "Tow";
					(_ui displayCtrl 9995) buttonSetAction "btc_int_target spawn btc_fnc_log_tow";
					if !([btc_int_target,btc_log_vehicle_selected] call btc_fnc_log_can_tow) then {(_ui displayCtrl 9995) ctrlEnable false;};
				};
			};
		};
	};
	case 8 :
	{
		{(_ui displayCtrl _x) ctrlShow false;} foreach [9993,9994,9995,9996];
		(_ui displayCtrl 9991) ctrlSetText "Load in";
		(_ui displayCtrl 9991) buttonSetAction "[] spawn btc_fnc_log_select";
		
		(_ui displayCtrl 9992) ctrlSetText "Drag";
		(_ui displayCtrl 9992) buttonSetAction "btc_int_target spawn btc_fnc_log_drag";
		if ({btc_int_target isKindOf _x} count btc_log_def_draggable == 0) then {(_ui displayCtrl 9992) ctrlEnable false;};
		
		//PLACE
		(_ui displayCtrl 9993) ctrlShow true;
		(_ui displayCtrl 9993) ctrlSetText "Place";
		(_ui displayCtrl 9993) buttonSetAction "btc_int_target spawn btc_fnc_log_place";
		if ({btc_int_target isKindOf _x} count btc_log_def_placeable == 0) then {(_ui displayCtrl 9993) ctrlEnable false;};
		if (btc_int_target isKindOf "Land_Cargo20_blue_F") then
		{
			(_ui displayCtrl 9994) ctrlShow true;
			(_ui displayCtrl 9994) ctrlSetText "Mount FOB";
			(_ui displayCtrl 9994) buttonSetAction "btc_int_target spawn btc_fnc_fob_create";
		};
	};
	case 9 :
	{
		{(_ui displayCtrl _x) ctrlShow false;} foreach [9993,9994,9995,9996];
		(_ui displayCtrl 9991) ctrlSetText "Require object";
		(_ui displayCtrl 9991) buttonSetAction "[btc_create_object_point] spawn btc_fnc_log_create";
		
		(_ui displayCtrl 9992) ctrlSetText "Repair wreck";
		(_ui displayCtrl 9992) buttonSetAction "closeDialog 0;[btc_create_object_point] spawn btc_fnc_log_repair_wreck";
	};
	case 10 :
	{
		{(_ui displayCtrl _x) ctrlShow false;} foreach [9992,9993,9994,9995,9996];
		(_ui displayCtrl 9991) ctrlSetText "Gear";
		(_ui displayCtrl 9991) buttonSetAction "[] spawn btc_fnc_gear_open_dlg";
	};
	case 11 :
	{
		{(_ui displayCtrl _x) ctrlShow false;} foreach [9992,9993,9994,9995,9996];
		(_ui displayCtrl 9991) ctrlSetText "Re-deploy";
		(_ui displayCtrl 9991) buttonSetAction "[] spawn btc_fnc_fob_redeploy";
		//if (!btc_p_redeploy_base && {btc_int_target distance (getMarkerPos "btc_base") > 200}) then {(_ui displayCtrl 9991) ctrlEnable false;};
	};
};
waitUntil {!Dialog};//player setVariable ["btc_int_busy",false];