private ["_receiver", "_delay"];
_receiver = _this select 0;
_treat = _this select 1;

_isMedic = player call btc_fnc_rev_is_medic;

if (!alive player) exitWith {};
if (!_isMedic && {((_treat == 2 && btc_rev_lbndg_only_medic) || (_treat == 3 && btc_rev_mor_only_medic) || (_treat == 4 && btc_rev_epi_only_medic) || (_treat == 5 && btc_rev_blood_only_medic))}) exitWith {hint "You're not a medic"};

closeDialog 0;

sleep 0.01;

/*
1 - bndg
2 - lbndg
3 - mor
4 - epi
5 - blood
*/

player setVariable ["btc_int_busy",true];
_delay = 6.5;
_anim  = "AinvPknlMstpSlayWrflDnon_medic";//AinvPknlMstpSnonWnonDnon_medic
_item  = "";
/*
switch (_treat) do
{
	case 1   : {_delay = 6.5;_item  = "BTC_w_bandage";};
	case 2   : {_delay = 7.5;_item  = "BTC_w_largeBandage";};
	case 3   : {_delay = 5;_item  = "BTC_w_mor";};
	case 4   : {_delay = 5;_item  = "BTC_w_epi";};//AinvPknlMstpSnonWnonDnon_medicUp0
	case 5   : {_delay = 15;_item  = "BTC_w_bloodbag";};
};*/

//if !(btc_wounds_mod) then {_item  = "";};

_isProne = (stance player == "PRONE");
_inVeh = (vehicle player != player);

if (_isProne || _inVeh) then {_delay = _delay + 5;} else {player playMove _anim;};

_target_action = _receiver;

if (_inVeh) then {_target_action = objNull};

[_delay,format ["Treating %1 . . .", name _receiver],_receiver] call btc_fnc_int_action_result;

//if (!_isProne) then {_anim spawn {while { isNil "btc_rev_action_result" } do {sleep 0.1;if (animationState player != _this) then {player playMoveNow _this;};};};};

waitUntil {!(isNil "btc_int_action_result")};

if (btc_int_action_result) then
{
	if (_item != "") then {player removeItem _item;};
	if (local _receiver) then {[_receiver,_treat] spawn btc_fnc_rev_apply_treat;} else {[[_receiver,_treat],"btc_fnc_rev_apply_treat",_receiver,false] spawn BIS_fnc_MP;};
	hint "Treatment applied";
} else {hint "Treatment could not be applied";};

if ((!_isProne && !_inVeh) || (animationState player == _anim)) then {player switchmove "";player playActionNow "PlayerCrouch";};

player setVariable ["btc_int_busy", false];