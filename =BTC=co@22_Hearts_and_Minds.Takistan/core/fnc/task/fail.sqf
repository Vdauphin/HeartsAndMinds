if (isDedicated) exitWith {};

switch _this do
{
	case 3 : 
	{
		private "_task";
		_task = player getVariable "task_3";		
		_task setTaskState "FAILED";
		["TaskFailed",["Side mission failed!","Supplies have not been delivered"]] call bis_fnc_showNotification;
		player setVariable ["task_3",nil];
	};
	case 4 : 
	{
		private "_task";
		_task = player getVariable "task_4";		
		_task setTaskState "FAILED";
		["TaskFailed",["Side mission failed!","The minefield has not been cleared"]] call bis_fnc_showNotification;
		player setVariable ["task_4",nil];
	};
	case 5 : 
	{
		private "_task";
		_task = player getVariable "task_5";		
		_task setTaskState "FAILED";
		["TaskFailed",["Side mission failed!","The vehicle has not been repaired"]] call bis_fnc_showNotification;
		player setVariable ["task_5",nil];
	};
	case 6 : 
	{
		private "_task";
		_task = player getVariable "task_6";		
		_task setTaskState "FAILED";
		["TaskFailed",["Side mission failed!","The city has not been conquered"]] call bis_fnc_showNotification;
		player setVariable ["task_6",nil];
	};
};