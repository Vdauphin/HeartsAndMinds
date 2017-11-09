if (isDedicated) exitWith {};

private ["_type"];

_type  = _this select 0;

switch (_type) do {
	case 0 : {
		hint (localize "STR_BTC_HAM_O_COMMON_SHOWHINTS_0"); //Cache destroyed!
	};
	case 1 : {
		hint (localize "STR_BTC_HAM_O_COMMON_SHOWHINTS_1"); //Intel about an ammo cache found! Map updated
	};
	case 2 : {
		hint format [(localize "STR_BTC_HAM_O_COMMON_SHOWHINTS_2"),(_this select 1)]; //Hideout destroyed! %1 remaining
	};
	case 3 : {
		hint (localize "STR_BTC_HAM_O_COMMON_SHOWHINTS_3"); //This body does not have any intel
	};
	case 4 : {
		hint (localize "STR_BTC_HAM_O_COMMON_SHOWHINTS_4"); //Found intels about an ammo cache and an hideout! Map updated
	};
	case 5 : {
		hint (localize "STR_BTC_HAM_O_COMMON_SHOWHINTS_5"); //Intel about an hideout found! Map updated
	};
	case 6 : {
		hint (localize "STR_BTC_HAM_O_COMMON_SHOWHINTS_6"); //In the last hideout we found important intel about all the cities occupied by the Oplitas! Size the last positions held by the enemies and defeat them once and for all
	};
	case 7 : {
		hint ((_this select 1) + (localize "STR_BTC_HAM_O_COMMON_SHOWHINTS_7")); // has been deployed!
	};
	case 8 : {
		hint (localize "STR_BTC_HAM_O_COMMON_SHOWHINTS_8"); //Saving in progress...Please wait
	};
	case 9 : {
		hint (localize "STR_BTC_HAM_O_COMMON_SHOWHINTS_9"); //Game has been saved!
	};
	case 10 : {
		hint (localize "STR_BTC_HAM_O_COMMON_SHOWHINTS_10"); //Database deleted!
	};
	case 11 : {
		hint (localize "STR_BTC_HAM_O_COMMON_SHOWHINTS_11"); //One checkpoint destroyed!
	};
};
