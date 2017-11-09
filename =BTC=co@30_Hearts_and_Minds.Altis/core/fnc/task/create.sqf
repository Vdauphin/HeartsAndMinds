
if (!isServer) exitWith {["task" + ([_this select 0] call BIS_fnc_taskState) + "Icon",[[[_this select 0] call BIS_fnc_taskType] call bis_fnc_taskTypeIcon, ([_this select 0] call BIS_fnc_taskDescription) select 1 select 0]] call bis_fnc_showNotification;};

private ["_location","_destination","_description","_type"];

if ((typeName (_this select 0)) isEqualTo "STRING") exitWith {};

if (count _this > 1) then {
	_destination = _this select 1;
	_location = _this select 2;
} else {
	_destination = objNull;
	_location = "";
};

switch (_this select 0) do {
	case 0 : {
		_description = [(localize "STR_BTC_HAM_MISSION_DEFEAT_DESC"),(localize "STR_BTC_HAM_MISSION_DEFEAT_TITLE"),(localize "STR_BTC_HAM_MISSION_DEFEAT_TITLE")]; //"Defeat the Oplitas once and for all","Defeat the Oplitas","Defeat the Oplitas"
		_type = "kill";
	};
	case 1 : {
		_description = [(localize "STR_BTC_HAM_MISSION_DESTORY_DESC"),(localize "STR_BTC_HAM_MISSION_DESTORY_TITLE"),(localize "STR_BTC_HAM_MISSION_DESTORY_TITLE")]; //"Destroy all the hideouts of the Oplitas","Destroy all the hideouts","Destroy all the hideouts"
		_type = "destroy";
	};
	case 2 : {
		_description = [(localize "STR_BTC_HAM_MISSION_SEIZE_DESC"),(localize "STR_BTC_HAM_MISSION_SEIZE_TITLE"),(localize "STR_BTC_HAM_MISSION_SEIZE_MRK")]; //"Seize the last positions held by Oplitas fighters","Seize the last Oplitas positions","Seize the last Oplitas fighters positions"
		_type = "move";
	};
	case 3 : {
		_description = [format [(localize "STR_BTC_HAM_SIDE_SUPPLIES_DESC"),_location],(format [(localize "STR_BTC_HAM_SIDE_SUPPLIES_TITLE"),_location]),(format [(localize "STR_BTC_HAM_SIDE_SUPPLIES_TITLE"),_location])]; //The citizens of %1 are on the brink starving to death, bring them some supplies present at the logisitic point!",_location],("Supply " + _location),("Supply " + _location)
		_type = "move";
	};
	case 4 : {
		_description = [format [(localize "STR_BTC_HAM_SIDE_MINES_DESC"),_location],(format [(localize "STR_BTC_HAM_SIDE_MINES_TITLE"),_location]),(format [(localize "STR_BTC_HAM_SIDE_MINES_TITLE"),_location])]; //There is a minefield near %1, clear it!",_location],("Minefield near " + _location),("Minefield near " + _location)
		_type = "search";
	};
	case 5 : {
		_description = [format [(localize "STR_BTC_HAM_SIDE_VEHICLE_DESC"),_location],(format [(localize "STR_BTC_HAM_SIDE_VEHICLE_TITLE"),_location]),(format [(localize "STR_BTC_HAM_SIDE_VEHICLE_TITLE"),_location])]; //"A vehicle damaged by an IED needs assistance near %1! Repair it!",_location],("Vehicle needs assistance near " + _location),("Vehicle needs assistance near " + _location)
		_type = "repair";
	};
	case 6 : {
		_description = [format [(localize "STR_BTC_HAM_SIDE_CONQUER_DESC"),_location],(format [(localize "STR_BTC_HAM_SIDE_CONQUER_TITLE"),_location]),(format [(localize "STR_BTC_HAM_SIDE_CONQUER_TITLE"),_location])]; //"%1 has been conquered by the Oplitas! Local population is being terrorized, they are asking for help!",_location],("Free " + _location),("Free " + _location)
		_type = "attack";
	};
	case 7 : {
		_description = [format [(localize "STR_BTC_HAM_SIDE_TOWER_DESC"),_location],(format [(localize "STR_BTC_HAM_SIDE_TOWER_TITLE"),_location]),(format [(localize "STR_BTC_HAM_SIDE_TOWER_TITLE"),_location])]; //"A Oplitas communications tower has been located in %1. Local population is asking for your help to destroy it! (Use one M183 explosive satchel)",_location],("Destroy tower in " + _location),("Destroy tower in " + _location)
		_type = "destroy";
	};
	case 8 : {
		_description = [format [(localize "STR_BTC_HAM_SIDE_CIVTREAT_DESC"),_location],(format [(localize "STR_BTC_HAM_SIDE_CIVTREAT_TITLE"),_location]),(format [(localize "STR_BTC_HAM_SIDE_CIVTREAT_TITLE"),_location])]; //format ["A civilian is calling for a medic in %1, treat and wait for patient stabilization ",_location],("Medical emergency call in " + _location),("Medical emergency call in " + _location)
		_type = "heal";
	};
	case 9 : {
		_description = [format [(localize "STR_BTC_HAM_SIDE_CHECKPOINT_DESC"),_location],(format [(localize "STR_BTC_HAM_SIDE_CHECKPOINT_TITLE"),_location]),(format [(localize "STR_BTC_HAM_SIDE_CHECKPOINT_TITLE"),_location])]; //"Checkpoints have been located in %1. Local population is asking for your help to destroy ammo box in all checkpoints!",_location],("Destroy checkpoints in " + _location),("Destroy checkpoints in " + _location)
		_type = "destroy";
	};
	case 10 : {
		_description = [format [(localize "STR_BTC_HAM_SIDE_CIVTREATBOAT_DESC"),_location],(format [(localize "STR_BTC_HAM_SIDE_CIVTREATBOAT_TITLE"),_location]),(format [(localize "STR_BTC_HAM_SIDE_CIVTREATBOAT_TITLE"),_location])]; //"A civilian is calling for a medic in %1, treat and wait for patient stabilization ",_location],("Medical emergency call in " + _location),("Medical emergency call in " + _location)
		_type = "heal";
	};
	case 11 : {
		_description = [format [(localize "STR_BTC_HAM_SIDE_UNDERWATER_DESC"),_location],(format [(localize "STR_BTC_HAM_SIDE_UNDERWATER_TITLE"),_location]),(format [(localize "STR_BTC_HAM_SIDE_UNDERWATER_TITLE"),_location])]; //"Underwater generator has been located in %1. Local population is asking for your help to destroy it!",_location],("Destroy underwater generator in " + _location),("Destroy underwater generator in " + _location)
		_type = "destroy";
	};
	case 12 : {
		_description = [format [(localize "STR_BTC_HAM_SIDE_CONVOY_DESC"),_location],(format [(localize "STR_BTC_HAM_SIDE_CONVOY_TITLE"),_location]),(format [(localize "STR_BTC_HAM_SIDE_CONVOY_TITLE"),_location])]; //"An armed Oplitas convoy is going to attack %1. Local population is asking for your help to destroy it before it gets there!",_location],("Destroy Oplitas convoy attacking " + _location),("Destroy Oplitas convoy attacking " + _location)
		_type = "attack";
	};
	case 13 : {
		_description = [format [(localize "STR_BTC_HAM_SIDE_RESC_DESC"),_location],(format [(localize "STR_BTC_HAM_SIDE_RESC_TITLE"),_location]),(format [(localize "STR_BTC_HAM_SIDE_RESC_TITLE"),_location])]; //"MAYDAY-MAYDAY, a pilot crashed his helicopter near %1. Command is asking for your help to rescue and bring him back to base!",_location],("Rescue downed pilot near " + _location),("Rescue downed pilot near " + _location)
		_type = "navigate";
	};
	case 14 : {
		_description = [format [(localize "STR_BTC_HAM_SIDE_CAPOFF_DESC"),_location],((localize "STR_BTC_HAM_SIDE_CAPOFF_TITLE")),((localize "STR_BTC_HAM_SIDE_CAPOFF_TITLE"))]; //"Capture an officer travelling in a concealed convoy, then bring him at base for interrogation. He is his responsible for terrorizing local population!",_location],("Capture commander in concealed convoy"),("Capture commander in concealed convoy")
		_type = "run";
	};
	case 15 :	{
		_description = [format [(localize "STR_BTC_HAM_SIDE_HOSTAGE_DESC"),_location],(format [(localize "STR_BTC_HAM_SIDE_HOSTAGE_TITLE"),_location]),(format [(localize "STR_BTC_HAM_SIDE_HOSTAGE_TITLE"),_location])]; //"Liberate a civilian hostage in %1. Local population is asking for your help!",_location],("Liberate hostage near " + _location),("Liberate hostage near " + _location)
		_type = "exit";
	};
	case 16 : {
		_description = [format [(localize "STR_BTC_HAM_SIDE_HACK_DESC"),_location],(format [(localize "STR_BTC_HAM_SIDE_HACK_TITLE"),_location]),(format [(localize "STR_BTC_HAM_SIDE_HACK_TITLE"),_location])]; //"Hack a prototype missile with a terminal available in %1. Defend your position until the process is done!",_location],("Hack missile near " + _location),("Hack missile near " + _location)
		_type = "intel";
	};
};

[btc_player_side,[str(_this select 0)],_description,_destination,true,2,true,_type,true] call BIS_fnc_taskCreate;
