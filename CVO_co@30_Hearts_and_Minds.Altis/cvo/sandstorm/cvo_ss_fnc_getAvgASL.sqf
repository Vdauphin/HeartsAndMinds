/*
*	Author: MrZorn
*
*	Description:
*		x 
*
*	Parameter(s):
* 		none
*
*	Returns:
*		<array> <[suggested fogBase, _range from max to min]>
*
*	Examples:
*		   _var = call cvo_env_fnc_al_getAvgASL;
*
*/

private _arr = [];
{_arr pushback (name _x) } forEach allPlayers;

private _allPlayers = call BIS_fnc_listPlayers;
private _allASL = [];

if (count _allPlayers > 3) then {
	// Removes Zeus which is assumed the Officer slot.
	_allPlayers = [_allPlayers, {!(_this getVariable ["side_mission", false])}] call CBA_fnc_select;

	// Removes Pilots of Helicopters 
	_allPlayers = [_allPlayers, {!((vehicle player isKindOf "Helicopter") && {currentPilot vehicle player == player})}] call CBA_fnc_select;
};


{	_allASL pushBack (round (getPosASL _x select 2));	} forEach _allPlayers;


_allASL sort true;

private _min = (_allASL call CBA_fnc_findMin) select 0; 
private _max = (_allASL call CBA_fnc_findMax) select 0;
private _range = _max - _min;



private _result = [];

/* 
 	how to define the returning value? 
		https://cbateam.github.io/CBA_A3/docs/files/arrays/fnc_filter-sqf.html
		https://cbateam.github.io/CBA_A3/docs/files/arrays/fnc_sortNestedArray-sqf.html
		https://community.bistudio.com/wiki/BIS_fnc_consolidateArray
*/ 

private _arr2 = [];

private _bracketSize = 25;

_arr2 = [_allASL, {floor (_x/_bracketSize) }] call CBA_fnc_filter;
_arr2 = _arr2 call BIS_fnc_consolidateArray;
_arr2 = [_arr2, 1, false] call CBA_fnc_sortNestedArray;
_avgASL = ((_arr2 select 0) select 0) * _bracketSize + _bracketSize * 0.5;
_avgASL = [_allASL, _avgASL] call BIS_fnc_nearestNum;
_result = [_avgASL, _range];

diag_log ("[CVO] [ENV] (allPlayersASL) - " + format ["return: %1 - ASLs: %2 - Min: %3 - Max: %4",_result, _allASL, _min, _max]);
_result