////////////////////////// CREATE ARSENAL

// Creates the Ace Virtual Arsenal and Adds the Basics Arrays

if (count CVO_arsenal_boxes isEqualTo 0) exitWith {};
{
	[_x, false, false] 			call ace_arsenal_fnc_initBox;				// Initialises ACE Arsenal on boxes
	[_x, CVO_A_Basic, false] 	call ace_arsenal_fnc_addVirtualItems;		// Adds the basic list to the arsenal
} forEach CVO_arsenal_boxes;


////////////////////////// DEFINE ROLE KIT
private _roleKit = [];


if (player getVariable ["Officer",false]) then {
	_roleKit append CVO_A_Officer;
	_roleKit append CVO_A_TeamLeader;
	_roleKit append CVO_A_RTO;
};

if (player getVariable ["GL",false]) then {
	_roleKit append CVO_A_GL;
};

if (player getVariable ["Interpreter",false]) then {
	_roleKit append CVO_A_Interpreter;
};

if (player getVariable ["TeamLeader",false]) then {
	_roleKit append CVO_A_GL;
	_roleKit append CVO_A_TeamLeader;
};

if (player getVariable ["MG",false]) then {
	_roleKit append CVO_A_MG;
};

if (player getVariable ["AT",false]) then {
	_roleKit append CVO_A_AT;
};

if (player getVariable ["AA",false]) then {
	_roleKit append CVO_A_AA;
};

if (player getVariable ["Marksman",false]) then {
	_roleKit append CVO_A_Marksman;
};

if (player getVariable ["Rifleman",false]) then {
	_roleKit append CVO_A_Rifleman;
};

if (player getUnitTrait "UAVHacker") then {
	_roleKit append CVO_A_EW;
	_roleKit append CVO_A_RTO;
};

/*
if (player getVariable ["CBRN",false]) then {
	_roleKit append CVO_A_CBRN;
};
*/

if (0 < player getVariable ["ace_medical_medicClass", 0]) then {
	_roleKit append CVO_A_Medic;
};

if (0 < player getVariable ["ACE_IsEngineer",0]) then {
	_roleKit append CVO_A_Engineer;
	_roleKit append CVO_A_CBRN;
};

{[_x, _roleKit, false] call ace_arsenal_fnc_addVirtualItems;} forEach CVO_arsenal_boxes;



////////////////////////// DEFINE PERSONAL KIT
// TBA

if (getPlayerUID player isEqualTo "_SP_PLAYER_") exitWith {
	systemChat "_SP_PLAYER_ detected"};



private _customKit = []; 

_VDV_Hats = [
	"rhs_beret_vdv1",
	"rhs_beret_vdv2",
	"rhs_beret_vdv3",
	"rhs_beret_vdv_early"
];

private _customKit = []; 

if (getPlayerUID player isEqualTo "76561198147307775") then { // Clone
	_customKit append _VDV_Hats;
};


if (getPlayerUID player isEqualTo "76561197970306509") then { // Zorn
	_customKit append _VDV_Hats;
};

{[_x, _customKit, false] call ace_arsenal_fnc_addVirtualItems;} forEach CVO_arsenal_boxes;
