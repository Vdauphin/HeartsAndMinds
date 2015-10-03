_examined = _this select 0;
_data = _this select 1;

//_data = [_target,_isUnc,_isBusy,_isDragging,_bleed,_bloss,_pain,_mor];

_examined setVariable ["btc_rev_time_examination", time];
/*
_examined setVariable ["BTC_w_isUnc",(_data select 1)];
_examined setVariable ["BTC_w_busy",(_data select 2)];
_examined setVariable ["BTC_w_isDragging",(_data select 3)];
_examined setVariable ["BTC_w_bleed",(_data select 4)];
_examined setVariable ["BTC_w_bloss",(_data select 5)];
_examined setVariable ["BTC_w_pain",(_data select 6)];
_examined setVariable ["BTC_w_mor",(_data select 7)];*/

_examined setVariable ["btc_int_busy",(_data select 1)];
_examined setVariable ["btc_rev_isDragging",(_data select 2)];
_examined setVariable ["btc_rev_bleed",(_data select 3)];
_examined setVariable ["btc_rev_bloss",(_data select 4)];
_examined setVariable ["btc_rev_pain",(_data select 5)];
_examined setVariable ["btc_rev_mor",(_data select 6)];

_examined spawn
{
	waitUntil {!(isNil "btc_int_action_result")};

	if (!btc_int_action_result) exitWith {player setVariable ["btc_int_busy", false];};

	hintSilent "";

	btc_int_target = _this;
	btc_int_target spawn btc_fnc_rev_examine_result;
	1 spawn btc_fnc_int_open_dlg;
};