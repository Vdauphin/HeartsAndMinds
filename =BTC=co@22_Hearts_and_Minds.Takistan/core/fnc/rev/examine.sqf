
btc_rev_examined = btc_int_target;
_isMedic = player call btc_fnc_rev_is_medic;

if (!alive player || {isNull btc_rev_examined} || {!Alive btc_rev_examined}) exitWith {};

closeDialog 0;

sleep 0.01;

player setVariable ["btc_int_busy",true];
_delay = btc_rev_examination_time;if (btc_rev_examined == player) then {_delay = btc_rev_examination_time / 3};
_anim  = "AinvPknlMstpSlayWrflDnon_medic";//AinvPknlMstpSnonWnonDnon_medic

if (_isMedic) then {_delay = (_delay / 3 * 2);};

_isProne = (stance player == "PRONE");
_inVeh = (vehicle player != player);

_last_ex = btc_rev_examined getVariable ["btc_rev_time_examination", - 300];
_actual_time = time;
if ((_actual_time - _last_ex) > 300) then
{
	if (_isProne || _inVeh) then {_delay = _delay + 5;} else {player playMove _anim;};
	
	[_delay,format ["Examining %1 . . .", name btc_rev_examined],btc_rev_examined] call btc_fnc_int_action_result;

	waitUntil {!(isNil "btc_int_action_result")};
	
	if (!btc_int_action_result && {!_isProne && !_inVeh} && {animationState player == _anim}) then {player switchmove "";player playActionNow "PlayerCrouch";};
	
	if (btc_int_action_result) then
	{
		if (btc_rev_examined == player) then 
		{
			player setVariable ["btc_rev_time_examination", time];
			btc_int_target = player;
			btc_int_target spawn btc_fnc_rev_examine_result;
			1 spawn btc_fnc_int_open_dlg;
		}
		else 
		{
			[[player],"btc_fnc_rev_ask_var",btc_rev_examined,false] spawn BIS_fnc_MP;
		};
	} else {player setVariable ["btc_int_busy",false];};
} else {if (btc_rev_examined == player) then {player setVariable ["btc_rev_time_examination", time];btc_int_target = player;btc_int_target spawn btc_fnc_rev_examine_result;1 spawn btc_fnc_int_open_dlg;} else {btc_int_action_result = true;[[player],"btc_fnc_rev_ask_var",btc_rev_examined,false] spawn BIS_fnc_MP;};};
player setVariable ["btc_int_busy",false];