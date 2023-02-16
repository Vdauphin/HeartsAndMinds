diag_log "[CVO] [ARSENAL] - GreenMod Detected";

_greenMag_Basic_items = [
	
	"greenmag_item_speedloader",

	"greenmag_ammo_545x39_basic_30Rnd",
	"greenmag_ammo_545x39_basic_60Rnd",

   	"greenmag_ammo_762x39_basic_30Rnd",
	"greenmag_ammo_762x39_basic_60Rnd",

   	"greenmag_ammo_765x17_basic_30Rnd",
	"greenmag_ammo_765x17_basic_60Rnd",

   	"greenmag_ammo_9x19_basic_30Rnd",
	"greenmag_ammo_9x19_basic_60Rnd",
	"CVO_greenmag_ammo_9x39_basic_60Rnd"
];

_greenMag_A_MG = [
   	"greenmag_beltlinked_762x54_basic_50",
	"greenmag_beltlinked_762x54_basic_100",
	"greenmag_beltlinked_762x54_basic_150",
	"greenmag_beltlinked_762x54_basic_200",

	"greenmag_ammo_762x54_basic_30Rnd",
	"greenmag_ammo_762x54_basic_60Rnd"
];

_greenMag_A_Marskman = [
	"greenmag_ammo_762x54_basic_30Rnd",
	"greenmag_ammo_762x54_basic_60Rnd"
];

CVO_A_Basic 		append _greenMag_Basic_items;
CVO_A_MG		 	append _greenMag_A_MG;
CVO_A_Marksman 		append _greenMag_A_Marskman;

[compileScript ["cvo\arsenal\cvo_arsenal_Tab_greenMag.sqf"]] call CBA_fnc_directCall;
