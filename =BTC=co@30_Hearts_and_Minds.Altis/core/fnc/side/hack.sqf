//https://forums.bistudio.com/forums/topic/186316-how-to-open-the-land_dataterminal_01_f-data-terminal-nexus-update/
//http://killzonekid.com/arma-scripting-tutorials-uav-r2t-and-pip/
//http://killzonekid.com/arma-scripting-tutorials-scripted-charges/

private _useful = btc_city_all select {(_x getVariable ["occupied",false] && {_x getVariable ["type",""] != "NameLocal"} && {_x getVariable ["type",""] != "Hill"} && (_x getVariable ["type",""] != "NameMarine"))};

if (_useful isEqualTo []) exitWith {[] spawn btc_fnc_side_create;};

private _city = selectRandom _useful;

private _pos = [getPos _city, 100] call btc_fnc_randomize_pos;
private _house = selectRandom ([_pos,100] call btc_fnc_getHouses);
if (isNil "_house") exitWith {[] spawn btc_fnc_side_create;};
_pos = selectRandom (_house buildingPos -1);

btc_side_aborted = false;
btc_side_done = false;
btc_side_failed = false;
btc_side_assigned = true;publicVariable "btc_side_assigned";

[16,_pos,_city getVariable "name"] call btc_fnc_task_create;

btc_side_jip_data = [16,_pos,_city getVariable "name"];

_city setVariable ["spawn_more",true];

private _marker = createmarker [format ["sm_2_%1",_pos],_pos];
_marker setmarkertype "hd_flag";
_marker setmarkertext (localize "STR_BTC_HAM_SIDE_HACK_MRK"); //Terminal
_marker setMarkerSize [0.6, 0.6];

//// Create terminal \\\\
private _terminal = createVehicle ["Land_DataTerminal_01_F", _pos, [], 0, "CAN_COLLIDE"];
{btc_side_done = false} remoteExec ["call", 0];
_pos = [[_pos, 100] call btc_fnc_randomize_pos, 50, 500, 30, 0, 60 * (pi / 180), 0] call BIS_fnc_findSafePos;
private _launchsite = createVehicle ["Land_PenBlack_F", _pos, [], 0, "FLY"];

//// Add interaction on Terminal \\\\
[[_terminal],{
	private _action = ["Open",(localize "STR_BTC_HAM_SIDE_HACK_ACEACTION"),"\A3\ui_f\data\igui\cfg\simpleTasks\types\intel_ca.paa",{ //Start Hacking
		[_this select 0,3] call BIS_fnc_dataTerminalAnimate;
		{btc_side_done = true} remoteExec ["call", 0];
	},{!btc_side_done}] call ace_interact_menu_fnc_createAction;
	[_this select 0, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
}] remoteExec ["call", -2];

waitUntil {sleep 5; (btc_side_aborted || btc_side_failed || btc_side_done)};
if (btc_side_aborted || btc_side_failed) exitWith {
	16 remoteExec ["btc_fnc_task_fail", 0];
	[[_marker], [_terminal], [], []] call btc_fnc_delete;
	btc_side_assigned = false;publicVariable "btc_side_assigned";
};

private _groups = [];
private _closest = [_city,btc_city_all select {!(_x getVariable ["active",false])},false] call btc_fnc_find_closecity;
for "_i" from 1 to (2 + round random 1) do {
	_groups pushBack ([_closest, getpos _terminal,1,selectRandom btc_type_motorized] call btc_fnc_mil_send);
};
_groups apply {_x setBehaviour "CARELESS"};

[_terminal, _launchsite modelToWorld [0,100,10]] remoteExec ["btc_fnc_log_place_create_camera", -2];

{player commandChat (localize "STR_BTC_HAM_SIDE_HACK_STARTCHAT")} remoteExec ["call", -2]; //Defend the terminal until the missile is hacked!

waitUntil {sleep 5; (btc_side_aborted || btc_side_failed || ({_x isEqualTo grpNull} count _groups > 0) || !(_city getVariable ["active", false]))};
if (btc_side_aborted || btc_side_failed) exitWith {
	16 remoteExec ["btc_fnc_task_fail", 0];
	[[_marker], [_terminal], [], []] call btc_fnc_delete;
	btc_side_assigned = false;publicVariable "btc_side_assigned";
};


//// Launch the hacked missile \\\\
private _altitude = 20;
while {_altitude < 500} do {
	_altitude = _altitude + 3;
	(createVehicle ["DemoCharge_Remote_Ammo_Scripted", [_pos select 0, _pos select 1, _altitude], [], 0, "CAN_COLLIDE"]) setDamage 1;
	sleep 0.1;
};
private _rocket = createVehicle ["ace_rearm_Missile_AGM_02_F", [_pos select 0, _pos select 1, _altitude], [], 0, "CAN_COLLIDE"];
private _fx = createVehicle ["test_EmptyObjectForSmoke", [_pos select 0, _pos select 1, _altitude], [], 0, "CAN_COLLIDE"];
_fx attachTo [_rocket,[0,0,0]];

{btc_side_done = false} remoteExec ["call", 0];
btc_side_assigned = false;publicVariable "btc_side_assigned";
[[_marker], [_rocket, _terminal], [_fx], []] call btc_fnc_delete;
if (btc_side_aborted || btc_side_failed || !(_city getVariable ["active", false])) exitWith {
	16 remoteExec ["btc_fnc_task_fail", 0];
};

80 call btc_fnc_rep_change;

16 remoteExec ["btc_fnc_task_set_done", 0];
