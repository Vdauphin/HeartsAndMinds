if (isDedicated) exitWith {};

switch _this do
{
	case 0 : {
		private "_task";
		_task = player getVariable "task_0";
		_task setTaskState "SUCCEEDED";
		["TaskSucceeded",["Misison accomplished!","Oplitas has been finally defeated!    Misison accomplished!"]] call bis_fnc_showNotification;

		_task = player getVariable "task_2";
		_task setTaskState "SUCCEEDED";
	};
	case 1 : {
		private "_task";
		_task = player getVariable "task_1";
		_task setTaskState "SUCCEEDED";
		["TaskSucceeded",["Misison accomplished!","All the hideouts have been destroyed!"]] call bis_fnc_showNotification;

		sleep 1;

		_task = player createSimpleTask ["Size the last enemies positions"];
		_task setSimpleTaskDescription ["Size the last positions held by the enemies","Size the last enemies positions","Size the last enemies positions"];
		player setCurrentTask _task;
		player setVariable ["task_2",_task];
		["TaskAssigned",["New task assigned!","Size the last positions held by the enemies"]] call bis_fnc_showNotification;
	};
	case 3 : {
		private "_task";
		_task = player getVariable "task_3";
		_task setTaskState "SUCCEEDED";
		["TaskSucceeded",["Side mission Accomplished!","Supplies have been delivered"]] call bis_fnc_showNotification;
		player setVariable ["task_3",nil];
	};
	case 4 : {
		private "_task";
		_task = player getVariable "task_4";
		_task setTaskState "SUCCEEDED";
		["TaskSucceeded",["Side mission Accomplished!","The minefield has been cleared"]] call bis_fnc_showNotification;
		player setVariable ["task_4",nil];
	};
	case 5 : {
		private "_task";
		_task = player getVariable "task_5";
		_task setTaskState "SUCCEEDED";
		["TaskSucceeded",["Side mission Accomplished!","The vehicle has been repaired"]] call bis_fnc_showNotification;
		player setVariable ["task_5",nil];
	};
	case 6 : {
		private "_task";
		_task = player getVariable "task_6";
		_task setTaskState "SUCCEEDED";
		["TaskSucceeded",["Side mission Accomplished!","The city has been cleared!"]] call bis_fnc_showNotification;
		player setVariable ["task_6",nil];
	};
	case 7 : {
		private "_task";
		_task = player getVariable "task_7";
		_task setTaskState "SUCCEEDED";
		["TaskSucceeded",["Side mission Accomplished!","The tower has been destroyed!"]] call bis_fnc_showNotification;
		player setVariable ["task_7",nil];
	};
	case 8 : {
		private "_task";
		_task = player getVariable "task_8";
		_task setTaskState "SUCCEEDED";
		["TaskSucceeded",["Side mission Accomplished!","The civilian has been stabilized!"]] call bis_fnc_showNotification;
		player setVariable ["task_8",nil];
	};
	case 9 : {
		private "_task";
		_task = player getVariable "task_9";
		_task setTaskState "SUCCEEDED";
		["TaskSucceeded",["Side mission Accomplished!","Checkpoints have been destroyed!"]] call bis_fnc_showNotification;
		player setVariable ["task_9",nil];
	};
};