if (("btc_p_chem" call BIS_fnc_getParamValue) isEqualTo 1) then {

	///////////////////////
	// Chemical Detector //
	///////////////////////

	// IGUI display on
	"btc_chem_detector" cutRsc ["RscWeaponChemicalDetector", "PLAIN", 1, false];



	// ACE Actions
	cvo_cbrn_gvar_detector_mode = cvo_cbrn_set_detector_defaultMode;


	private _action = [
		"CVO_CBRN_Detector_Mode", "Chemical Detector", "\A3\Weapons_F_Enoch\Items\data\ui\gear_ChemicalDetector_01_CA.paa", 
		{}, 
		{"ChemicalDetector_01_watch_F" in (assignedItems player)}] call ace_interact_menu_fnc_createAction;

	[player, 1, ["ACE_SelfActions", "ACE_Equipment"], _action] call ace_interact_menu_fnc_addActionToObject;


	private _action = [
		"CVO_CBRN_Detector_Mode_2", "Enable Speakers", "", 
		{cvo_cbrn_gvar_detector_mode = 2}, 
		{cvo_cbrn_gvar_detector_mode != 2}] call ace_interact_menu_fnc_createAction;

	[player, 1, ["ACE_SelfActions", "ACE_Equipment", "CVO_CBRN_Detector_Mode"], _action] call ace_interact_menu_fnc_addActionToObject;


	_action = [
		"CVO_CBRN_Detector_Mode_1", "Connect Headphones", "", 
		{cvo_cbrn_gvar_detector_mode = 1}, 
		{cvo_cbrn_gvar_detector_mode != 1}] call ace_interact_menu_fnc_createAction;

	[player, 1, ["ACE_SelfActions", "ACE_Equipment", "CVO_CBRN_Detector_Mode"], _action] call ace_interact_menu_fnc_addActionToObject;


	_action = [
		"CVO_CBRN_Detector_Mode_1", "Disable Sound", "", 
		{cvo_cbrn_gvar_detector_mode = 0}, 
		{cvo_cbrn_gvar_detector_mode != 0}] call ace_interact_menu_fnc_createAction;

	[player, 1, ["ACE_SelfActions", "ACE_Equipment", "CVO_CBRN_Detector_Mode"], _action] call ace_interact_menu_fnc_addActionToObject;



	// Event handlers
	addUserActionEventHandler ["Watch", "Activate", {_this call cvo_cbrn_fnc_eventHandler_detector;}];
	addUserActionEventHandler ["WatchToggle", "Activate", {_this call cvo_cbrn_fnc_eventHandler_detector;}];
};
