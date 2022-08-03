/* ----------------------------------------------------------------------------
Name: postInitXEH

Description: Executes all CBA post-init extended eventhandler scripts on units of the given class. Must be defined in description.ext. 

Parameters:
0: Unit <OBJECT>

Returns: Nil

Examples:

class Extended_InitPost_EventHandlers {
     class CAManBase {
		init = "_this call (compile preprocessFileLineNumbers 'postInitXEH.sqf')";
	};
};

Author: Incontinentia
---------------------------------------------------------------------------- */




params [["_unit",objNull]];


//Exit if the code is already running on the unit or the unit has "noChanges" variable
if (_unit getVariable ["initLoopRunning",false]) exitWith {};
if (_unit getVariable ["noChanges",false]) exitWith {};

_unit setVariable ["initLoopRunning", true, true];

//Recruitment script
#include "INC_undercover\Scripts\unitInitsUndercover.sqf"
