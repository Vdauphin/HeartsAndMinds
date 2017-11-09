if (isNil {player getVariable "interpreter"}) exitWith {hint (localize "STR_BTC_HAM_CON_INFO_ASKREP_NOINTER");}; //I can't understand what is saying

private ["_man","_rep","_chance","_info","_info_type","_random","_text","_ho_left"];

_man = _this select 0;

btc_int_ask_data = nil;

[2,nil,player] remoteExec ["btc_fnc_int_ask_var", 2];

waitUntil {!(isNil "btc_int_ask_data")};

_rep = btc_int_ask_data;

if ((round random 1) isEqualTo 1) then {
	btc_int_ask_data = nil;
	[8,nil,player] remoteExec ["btc_fnc_int_ask_var", 2];

	waitUntil {!(isNil "btc_int_ask_data")};

	_ho_left = format [(localize "STR_BTC_HAM_CON_INFO_ASKREP_HIDEOUTS"), btc_int_ask_data]; //I heard about %1 hideouts left.
} else {
	_ho_left = "";
};

switch (true) do {
	case (_rep < 200) : {_info_type = (localize "STR_BTC_HAM_CON_INFO_ASKREP_VLOW");}; //very low
	case (_rep >= 200 && _rep < 500) : {_info_type = (localize "STR_BTC_HAM_CON_INFO_ASKREP_LOW");}; //low
	case (_rep >= 500 && _rep < 750) : {_info_type = (localize "STR_BTC_HAM_CON_INFO_ASKREP_NORMAL");}; //normal
	case (_rep >= 750) : {_info_type = (localize "STR_BTC_HAM_CON_INFO_ASKREP_HIGH");}; //high
};

_chance = (random 100);
switch (true) do {
	case (_chance < 30) : {_text = (localize "STR_BTC_HAM_CON_INFO_ASKREP_ASK1");}; //Sir, your reputation is
	case (_chance >= 30 && _chance < 60) : {_text = (localize "STR_BTC_HAM_CON_INFO_ASKREP_ASK2");}; //Hello ! Your reputation is
	case (_chance >= 60) : {_text = format [(localize "STR_BTC_HAM_CON_INFO_ASKREP_ASK3"), name _man];}; //I am %1 and I think your reputation is
};

hint format ["%1 %2. %3", _text, _info_type, _ho_left];
