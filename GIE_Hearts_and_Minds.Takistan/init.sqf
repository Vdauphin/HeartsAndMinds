
[compileScript ["core\init.sqf"]] call CBA_fnc_directCall;

if (isDedicated) then {
	diag_log format ["Starting mission %1", briefingName];
};