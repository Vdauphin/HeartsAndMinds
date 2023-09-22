/* WIP
 * Author: Zorn
 * spawn an AmmoCrate and fills it with a custom Array.
 *
 * Arguments:
 * 0: Target supplySpawner, where the ace action should be added <OBJECT> or <CLASS as STRING>
 * 1: Name of the supplyCrateAction <string>
 * 2: Nested Array of content EXCEPT BACKPACKS [["class0", amount], ["classN",#]] <Nested Array>
 * 3: Class of Crate to be used <OBJECT> <Optional - Default: "LandWoodenBox_F">
 * 4: Nested Array of Content BACKPACKS Only [[class0, #], [classN,#]] <Nested Array > <optional - Default: []>
 * 5: Spawn Location - ideally a invisible helipad or Tarp_01_Large_Black_F <Object> <optional - default: objNull>
 * 
 * Return Value:
 * None
 *
 * Examples:
 
[
	btc_create_object, 
	"Monkey Care Package",
	[
		["Ace_banana", 100],
		["ace_maptools",100]
	]
] call cvo_logistics_fnc_addCustomSupplyBoxAceActionToObject;

[
	"ACM_APD_Unimog", 
	"CBRN Package", 
	[
		["U_C_CBRN_Suit_01_Blue_F",6],
		["G_RegulatorMask_F",6]
	],
	"LandWoodenBox_F",
	objNull,
	[
		["B_SCBA_01_F",6]
	]
] call cvo_logistics_fnc_addCustomSupplyBoxAceActionToObject;



 *
 * Public: maybe idfk
 *
 *
*/

params [
	["_spawner", objNull],
	["_name", "defaultName", ["String"]],
	["_array",[]],
	["_BoxType","Land_WoodenBox_F", ["String"]],
	["_backpacks", []],
	["_spawnloc", objNull]
];


// ### Creates an Array to store all already existing "Menu Nodes" when the Array doesnt exist yet.
if (isNil "CVO_CSC_array") then {
	CVO_CSC_array = [];
	diag_log ("[CVO] [LOGISTICS] (CSC) created CVO_CSC_Array.");
};

// ### Creates CSC Menu Node if the _spawner does not carries a CSC Menu Node yet.
if (!(_spawner in CVO_CSC_array)) then {
	private _root = [
		"cvo_csc_root",													// Action Name
		"Take Custom Supply Crates",									// Name for the ACE Interaction Menu
		"\A3\ui_f\data\igui\cfg\simpleTasks\types\box_ca.paa",																// Custom Icon 
		{},																// Statement
		{true}															// Condition
	] call ace_interact_menu_fnc_createAction;

	if (typeName _spawner isEqualTo "OBJECT") then {
		_test = [
			_spawner,										// Object the action should be assigned to
			0,												// Type of action, 0 for action, 1 for self-actionIDs
			["ACE_MainActions"],							// Parent path of the new action <Array>
			_root
		] call ace_interact_menu_fnc_addActionToObject;

	} else {

		_test = [
			_spawner,										// Class(string) the action should be assigned to
			0,												// Type of action, 0 for action, 1 for self-actionIDs
			["ACE_MainActions"],							// Parent path of the new action <Array>
			_root
		] call ace_interact_menu_fnc_addActionToClass;		
	};

	CVO_CSC_array pushBack _spawner;
};


// ### Uses the BTC_create_object_point in case of Hearts an Minds
if (_spawner isEqualTo btc_create_object) then {_spawnloc = btc_create_object_point;} else {_spawnloc = "REL"};			// untested


// ### Adapts Names for the Ace action
private _actionname = ("CVO_spawnbox_" + str _name);
private _actionstring = (           "" + str _name);


// ## Creating the ACTION itself. should be universal for OBJ and Class
private _action = [
	_actionname,													// Action Name
	_actionstring,													// Name for the ACE Interaction Menu
	"\A3\ui_f\data\igui\cfg\simpleTasks\types\box_ca.paa",																// Custom Icon 
	{_this call cvo_CSC_fnc_spawnCSC_old},							// Statement
	{true},															// Condition
	{},
	[_BoxType, _spawnloc, _name, _array, _backpacks]
] call ace_interact_menu_fnc_createAction;


// ## ATTACHING THE ACTION to class OR OBJECT

if (typeName _spawner isEqualTo "OBJECT") then {

	// TO OBJECT
	[
		_spawner,										// Class the action should be assigned to
		0,												// Type of action, 0 for action, 1 for self-actionIDs
		["ACE_MainActions","cvo_csc_root"],							// Parent path of the new action <Array>
		_action
	] call ace_interact_menu_fnc_addActionToObject;		// Alternative: ace_interact_menu_fnc_addActionToClass

} else {
 		
	// TO CLASS
	[
		_spawner,										// Class the action should be assigned to
		0,												// Type of action, 0 for action, 1 for self-actionIDs
		["ACE_MainActions","cvo_csc_root"],				// Parent path of the new action <Array>
		_action
	] call ace_interact_menu_fnc_addActionToClass;		

};
diag_log format ["[CVO] [LOGISTICS] (CSC) - Successful => Carrier: %1 - CSC: %2", _spawner, _name];