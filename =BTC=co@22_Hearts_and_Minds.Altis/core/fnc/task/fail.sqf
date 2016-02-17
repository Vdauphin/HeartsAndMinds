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
	case 7 :
	{
		private "_task";
		_task = player getVariable "task_7";
		_task setTaskState "FAILED";
		["TaskFailed",["Side mission failed!","The tower has not been destroyed"]] call bis_fnc_showNotification;
		player setVariable ["task_7",nil];
	};
	case 8 :
	{
		private "_task";
		_task = player getVariable "task_8";
		_task setTaskState "FAILED";
		["TaskFailed",["Side mission failed!","The patient has not been stabilized"]] call bis_fnc_showNotification;
		player setVariable ["task_8",nil];
	};
	case 9 :
	{
		private "_task";
		_task = player getVariable "task_9";
		_task setTaskState "FAILED";
		["TaskFailed",["Side mission failed!","Checkpoints have not been destroyed"]] call bis_fnc_showNotification;
		player setVariable ["task_9",nil];
	};
	case 10 :
	{
		private "_task";
		_task = player getVariable "task_10";
		_task setTaskState "FAILED";
		["TaskFailed",["Side mission failed!","The patient has not been stabilized"]] call bis_fnc_showNotification;
		player setVariable ["task_10",nil];
	};
	case 11 :
	{
		private "_task";
		_task = player getVariable "task_11";
		_task setTaskState "FAILED";
		["TaskFailed",["Side mission failed!","Underwater generator have not been destroyed"]] call bis_fnc_showNotification;
		player setVariable ["task_11",nil];
	};
};