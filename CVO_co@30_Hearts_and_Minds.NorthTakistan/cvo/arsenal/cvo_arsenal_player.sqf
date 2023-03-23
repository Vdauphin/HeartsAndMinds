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
	_roleKit append CVO_A_Officer;
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


if (player getVariable ["CBRN",false]) then {
	_roleKit append CVO_A_CBRN;
};


if (0 < player getVariable ["ace_medical_medicClass", 0]) then {
	_roleKit append CVO_A_Medic;
};

if (0 < player getVariable ["ACE_IsEngineer",0]) then {
	_roleKit append CVO_A_Engineer;
};

{[_x, _roleKit, false] call ace_arsenal_fnc_addVirtualItems;} forEach CVO_arsenal_boxes;



////////////////////////// DEFINE PERSONAL KIT
// TBA
// {[_x, _roleKit, false] call ace_arsenal_fnc_addVirtualItems;} forEach CVO_arsenal_boxes;
