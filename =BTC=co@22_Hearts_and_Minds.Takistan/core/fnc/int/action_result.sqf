
btc_int_action_result = nil;
_this spawn {
	_time = _this select 0;
	_title = _this select 1;
	_target = _this select 2;
	_pos = getPosATL _target;
	_radius = 3;
	if (_target isKindOf "Man") then {_radius = 1;};
	if (_target isKindOf "Helicopter") then {_radius = 10;};
	if (count _this > 3) then {_radius = _this select 3;};
	disableSerialization;
	createDialog "btc_dlg_progressBar";
	_ctrlProgressBar = uiNamespace getVariable "btc_dlg_ctrlProgressBar";
	_ctrlProgressBarTitle = uiNamespace getVariable "btc_dlg_title";
	_ctrlProgressBar ctrlSetPosition [
		safezoneX + 0.1 * safezoneW,
		safezoneY + 0.1 * safezoneH,
		0.8 * safezoneW,
		0.01 * safezoneH
	];
	_ctrlProgressBar ctrlCommit (_time / accTime);
	_ctrlProgressBarTitle ctrlSetText _title;


	_time = time + _time;
	waitUntil {
		!dialog || {!alive player} || {player getVariable ["ACE_isUnconscious",false]} || {time > _time} || {_target distance _pos > _radius}
	};

	closeDialog 0;

	if (time > _time) then {btc_int_action_result = true} else {btc_int_action_result = false};
};