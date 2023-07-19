// This init needs to be executed via initPlayerLocal.sqf

cvo_FTVic_fnc_drawMarker 			= compileScript ["cvo\FTVic\cvo_FTVic_fnc_drawMarker.sqf", 			false, ""];
cvo_FTVic_fnc_checkDistanceArray 	= compileScript ["cvo\FTVic\cvo_FTVic_fnc_checkDistanceArray.sqf", 	false, ""];
cvo_FTVic_fnc_teleport				= compileScript ["cvo\FTVic\cvo_FTVic_fnc_teleport.sqf", 			false, ""];
cvo_FTVic_fnc_selectLocation		= compileScript ["cvo\FTVic\cvo_FTVic_fnc_selectLocation.sqf", 		false, ""];

cvo_FTVic_radius = 300;

if (isServer) then {publicVariable "btc_fobs";};

//  [(btc_fobs#1 + [btc_gear_object]), 100] call cvo_FTVic_fnc_drawMarker;
// returns array of markers

_condition = { 
	(currentPilot vehicle player == player) 
	&& {round (speed vehicle player) <= 3} 
	&& { [ vehicle player, cvo_FTVic_radius, ([] + [btc_gear_object] + btc_fobs#1) ] call cvo_FTVic_fnc_checkDistanceArray; }
};

_statement = {
    [vehicle player] call cvo_FTVic_fnc_selectLocation;
};

_action = ["FTVic","Deploy with Vehicle","\A3\ui_f\data\igui\cfg\simpleTasks\types\takeoff_ca.paa",_statement,_condition] call ace_interact_menu_fnc_createAction;

[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;
