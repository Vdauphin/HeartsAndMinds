private _onTeamJoin = {
	params ["_target", "_player", "_params"];

	private _teamColor = _params select 0;

	player assignTeam _teamColor;

	["CBA_teamColorChanged", [player, _teamColor]] call CBA_fnc_globalEvent;

};

private _canJoinTeam = {
	params ["_target", "_player", "_params"];

	true
};

private _modifyJoinAction = {
	params ["_target", "_player", "_params", "_actionData"];


	private _teamColor = _params select 0;

	private _color = switch (toUpper _teamColor) do {
		case "RED": {missionNamespace getVariable ["ace_nametags_nametagColorRed", [221, 0, 0]]};
		case "GREEN": {missionNamespace getVariable ["ace_nametags_nametagColorGreen", [0, 221, 0]]};
		case "BLUE": {missionNamespace getVariable ["ace_nametags_nametagColorBlue", [0, 0, 221]]};
		case "YELLOW": {missionNamespace getVariable ["ace_nametags_nametagColorYellow", [221, 221, 0]]};
		default {missionNamespace getVariable ["ace_nametags_nametagColorMain", [255, 255, 255]]};
	};

	_actionData set [2, ["\z\ace\addons\interaction\UI\team\team_white_ca.paa", _color call BIS_fnc_colorRGBtoHTML]];
};





_joinRed = ["KARMA_JOIN_RED", "Join Red", "\z\ace\addons\interaction\UI\team\team_white_ca.paa", _onTeamJoin,  _canJoinTeam, {}, ["RED"], {[0, 0, 0]}, 2, [false, false, false, false, false], _modifyJoinAction] call ace_interact_menu_fnc_createAction;
_joinGreen = ["KARMA_JOIN_GREEN", "Join Green", "\z\ace\addons\interaction\UI\team\team_white_ca.paa", _onTeamJoin,  _canJoinTeam, {}, ["GREEN"], {[0, 0, 0]}, 2, [false, false, false, false, false], _modifyJoinAction] call ace_interact_menu_fnc_createAction;
_joinYellow = ["KARMA_JOIN_YELLOW", "Join Yellow", "\z\ace\addons\interaction\UI\team\team_white_ca.paa", _onTeamJoin,  _canJoinTeam, {}, ["YELLOW"], {[0, 0, 0]}, 2, [false, false, false, false, false], _modifyJoinAction] call ace_interact_menu_fnc_createAction;
_joinBlue = ["KARMA_JOIN_BLUE", "Join Blue", "\z\ace\addons\interaction\UI\team\team_white_ca.paa", _onTeamJoin,  _canJoinTeam, {}, ["BLUE"], {[0, 0, 0]}, 2, [false, false, false, false, false], _modifyJoinAction] call ace_interact_menu_fnc_createAction;
_joinMain = ["KARMA_JOIN_MAIN", "Join White", "\z\ace\addons\interaction\UI\team\team_white_ca.paa", _onTeamJoin,  _canJoinTeam, {}, ["MAIN"], {[0, 0, 0]}, 2, [false, false, false, false, false], _modifyJoinAction] call ace_interact_menu_fnc_createAction;

_teamManagementRoot = ["KARMA_TEAM_MANAGEMENT_ROOT", "Fireteams", "\z\ace\addons\interaction\UI\team\team_management_ca.paa", {}, { true }] call ace_interact_menu_fnc_createAction;
["CAManBase", 1, ["ACE_SelfActions"], _teamManagementRoot, true] call ace_interact_menu_fnc_addActionToClass;



["CAManBase", 1, ["ACE_SelfActions", "KARMA_TEAM_MANAGEMENT_ROOT"], _joinRed, true] call ace_interact_menu_fnc_addActionToClass;
["CAManBase", 1, ["ACE_SelfActions", "KARMA_TEAM_MANAGEMENT_ROOT"], _joinGreen, true] call ace_interact_menu_fnc_addActionToClass;
["CAManBase", 1, ["ACE_SelfActions", "KARMA_TEAM_MANAGEMENT_ROOT"], _joinYellow, true] call ace_interact_menu_fnc_addActionToClass;
["CAManBase", 1, ["ACE_SelfActions", "KARMA_TEAM_MANAGEMENT_ROOT"], _joinBlue, true] call ace_interact_menu_fnc_addActionToClass;
["CAManBase", 1, ["ACE_SelfActions", "KARMA_TEAM_MANAGEMENT_ROOT"], _joinMain, true] call ace_interact_menu_fnc_addActionToClass; 