
if (_this getvariable ["btc_rev_mor",0] > btc_rev_max_mor) then {_this setvariable ["btc_rev_mor",btc_rev_max_mor];};
_this setVariable ["btc_rev_head",0];
_this setVariable ["btc_rev_body",0];
_this setVariable ["btc_rev_hands",0];
_this setVariable ["btc_rev_legs",0];

if (btc_p_revive == 1) then {player setDamage 1};

_timer = true;
if (btc_p_t_revive == 9999) then {_timer = false;};

if (_this getVariable ["btc_rev_isUnc",false]) exitWith {};

btc_rev_gear = [_this] call btc_fnc_rev_get_gear;

_this setVariable ["tf_globalVolume", 0.4];
_this setVariable ["tf_voiceVolume", 0];
_this setVariable ["tf_unable_to_use_radio", true];

_this setVariable ["btc_rev_isUnc",true,true];
_this setCaptive true;
//_this spawn {waitUntil {animationState player == "AinjPpneMstpSnonWrflDnon"};_this enableSimulation false;};

if (vehicle _this != _this) then {/*_this action ["EJECT",vehicle _this]*/} else
{
	_this switchMove "AinjPpneMstpSnonWrflDnon";
	_this spawn {sleep 7;if (_this getVariable ["btc_rev_isUnc",false]) then {_this switchMove "AinjPpneMstpSnonWrflDnon";};};
};
if (Dialog) then {closeDialog 0;};
disableSerialization;

if (isPlayer _this) then
{
	createDialog "btc_rev_dlg_unconscious";
	//_ui = uiNamespace getVariable "btc_rev_dlg_unconscious";
} 
else
{
	_this disableAI "MOVE";
};
_time = 0;_r_time = 0;
while {(_this getVariable ["btc_rev_isUnc",false]) && {Alive _this}} do
{
	private ["_ui"];
	if (isPlayer _this && {!Dialog}) then {createDialog "btc_rev_dlg_unconscious";};
	if (_this getvariable ["btc_rev_bleed",0] == 0 && {_this getVariable ["btc_rev_bloss",0] < 0.85} && {_this getVariable ["btc_rev_pain",0] < 0.7}) then
	{
		_time = _time + 0.1;
	} else {_time = 0;};
	if (_time > (60 + random 30)) then {_this setVariable ["btc_rev_isUnc",false];};
	if (_timer) then {_r_time = _r_time + 0.1;if (_r_time > btc_p_t_revive) then {player setDamage 1;}};
	sleep 0.1;
};
_this enableSimulation true;
_this enableAI "MOVE";

if (Alive _this) then
{
	closeDialog 0;
	_this switchMove "AinjPpneMstpSnonWnonDnon_rolltofront";
	sleep 2;
	_this playMoveNow "AmovPpneMstpSnonWnonDnon_healed";
	closeDialog 0;
};

_this setCaptive false;

_this setVariable ["btc_rev_isUnc",false,true];
_this setVariable ["btc_int_busy",false];

_this setVariable ["tf_globalVolume", 1];
_this setVariable ["tf_voiceVolume", 1];
_this setVariable ["tf_unable_to_use_radio", false];

if (Dialog) then {closeDialog 0;};