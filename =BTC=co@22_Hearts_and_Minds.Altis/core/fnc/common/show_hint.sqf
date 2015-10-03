if (isDedicated) exitWith {};

_type  = _this select 0;

switch (_type) do {
	case 0 : {
		hint "Cache destroyed!";
	};
	case 1 : {
		hint "Intel about an ammo cache found! Map updated";
	};
	case 2 : {
		hint format ["Hideout destroyed! %1 remaining",(_this select 1)];
	};
	case 3 : {
		hint "This body does not have any intel";
	};
	case 4 : {	
		hint "Found intels about an ammo cache and an hideout! Map updated";
	};
	case 5 : {
		hint "Intel about an hideout found! Map updated";
	};
	case 6 : {
		hint "In the last hideout we found important intel about all the cities occupied by the Oplitas! Size the last positions held by the enemies and defeat them once and for all";
	};
	case 7 : {
		hint ((_this select 1) + " has been deployed!");
	};
	case 8 : {
		hint "Saving in progress...Please wait";
	};
	case 9 : {
		hint "Game has been saved!";
	};
	case 10 : {
		hint "Database deleted!";
	};
};