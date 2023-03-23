
// Define Individual Equipment Packages people can aquire.

// Default PersonalKit Package should have:
// 1. Name as String
// 2. Cost
//

CVO_PK_PKM = [

];




// 

CVO_PK_DB = createHashMap;

//							Key: PlayerUserIDs 	Value: [[array of kits or individual classnames]]
// Username:
// User Steam ID:
// Array of Kits or Classnames. 

CVO_PK_DB set [	"01234",	[	], "username"];






// End of the script.
publicVariable CVO_PK_DB;


/*
Example on how to Extract said Array

CVO_PK_DB_Array = [
	[CVO_PK_xyz, _uidArray,[""]]
];

*/


private _UID = getPlayerUID player; //string
{	_x params ["_kitName", "_uidArray", "_customItems"];
	if (_UID in _uidArray) 		then { _roleKit append _kitName;			};
	if (0 < count _customItems) then { _roleKit append _customItems;		};
} forEach CVO_PK_Array;