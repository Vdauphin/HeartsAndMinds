if (isDedicated) exitWith {};

switch (_this select 0) do
{
	case 0 : 
	{
		private "_task";
		_task = player createSimpleTask ["Defeat the Oplitas"];
		_task setSimpleTaskDescription ["Destroy all the hideouts of the Oplitas and defeat them once and for all","Defeat the Oplitas","Defeat the Oplitas"];
		player setVariable ["task_0",_task];
		["TaskAssigned",["New task assigned!","Defeat the Oplitas"]] call bis_fnc_showNotification;
	};
	case 1 : 
	{
		private "_task";
		_task = player createSimpleTask ["Destroy all the hideouts"];
		_task setSimpleTaskDescription ["Destroy all the hideouts of the Oplitas and defeat them once and for all","Destroy all the hideouts","Destroy all the hideouts"];
		player setVariable ["task_1",_task];	
		["TaskAssigned",["New task assigned!","Destroy all the hideouts"]] call bis_fnc_showNotification;
	};
	case 3 : 
	{
		private "_task";
		_task = player createSimpleTask [("Supply " + (_this select 2))];
		_task setSimpleTaskDescription [format ["The citizens of %1 are starving to death, bring them some supplies!",(_this select 2)],("Supply " + (_this select 2)),("Supply " + (_this select 2))];
		_task setSimpleTaskDestination (_this select 1);
		player setVariable ["task_3",_task];	
		["TaskAssigned",["New task assigned!",("Supply " + (_this select 2))]] call bis_fnc_showNotification;
	};
	case 4 : 
	{
		private "_task";
		_task = player createSimpleTask [("Minefield near " + (_this select 2))];
		_task setSimpleTaskDescription [format ["There is a minefield near %1, clear it!",(_this select 2)],("Minefield near " + (_this select 2)),("Minefield near " + (_this select 2))];
		_task setSimpleTaskDestination (_this select 1);
		player setVariable ["task_4",_task];	
		["TaskAssigned",["New task assigned!",("Clear the minefield near " + (_this select 2))]] call bis_fnc_showNotification;
	};
	case 5 : 
	{
		private "_task";
		_task = player createSimpleTask [("Vehicle needs assistance near " + (_this select 2))];
		_task setSimpleTaskDescription [format ["A vehicle damaged by an IED needs assistance near %1!",(_this select 2)],("Vehicle needs assistance near " + (_this select 2)),("Vehicle needs assistance near " + (_this select 2))];
		_task setSimpleTaskDestination (_this select 1);
		player setVariable ["task_5",_task];	
		["TaskAssigned",["New task assigned!",("Vehicle needs assistance near " + (_this select 2))]] call bis_fnc_showNotification;
	};
	case 6 : 
	{
		private "_task";
		_task = player createSimpleTask [("Free " + (_this select 2))];
		_task setSimpleTaskDescription [format ["%1 has been conquered by the Oplitas! Local population is terrorised and is asking for your help!",(_this select 2)],("Free " + (_this select 2)),("Free " + (_this select 2))];
		_task setSimpleTaskDestination (_this select 1);
		player setVariable ["task_6",_task];	
		["TaskAssigned",["New task assigned!",("Free " + (_this select 2))]] call bis_fnc_showNotification;
	};
};