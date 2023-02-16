// Define PLayers additional loadout

private _individualKit = [];


if (player getVariable ["Officer",false]) then {
	_individualKit append CVO_A_Officer;
	_individualKit append CVO_A_TeamLeader;
	_individualKit append CVO_A_RTO;};


if (player getVariable ["GL",false]) then {
	_individualKit append CVO_A_GL;};


if (player getVariable ["Interpreter",false]) then {
	_individualKit append CVO_A_Interpreter;
	_individualKit append CVO_A_Officer;};


if (player getVariable ["TeamLeader",false]) then {
	_individualKit append CVO_A_GL;
	_individualKit append CVO_A_TeamLeader;};


if (player getVariable ["Medic",false]) then {
	_individualKit append CVO_A_Medic;};


if (player getVariable ["MG",false]) then {
	_individualKit append CVO_A_MG;};


if (player getVariable ["AT",false]) then {
	_individualKit append CVO_A_AT;};


if (player getVariable ["AA",false]) then {
	_individualKit append CVO_A_AA;};


if (player getVariable ["Marksman",false]) then {
	_individualKit append CVO_A_Marksman;};


if (player getVariable ["Rifleman",false]) then {
	_individualKit append CVO_A_Rifleman;};


if (player getVariable ["EW",false]) then {
	_individualKit append CVO_A_EW;
	_individualKit append CVO_A_RTO;};


if (player getVariable ["CBRN",false]) then {
	_individualKit append CVO_A_CBRN;};


if (player getVariable ["Engineer",false]) then {
	_individualKit append CVO_A_Engineer;};


{[_x, _individualKit, false] call ace_arsenal_fnc_addVirtualItems;} forEach CVO_arsenal_boxes;