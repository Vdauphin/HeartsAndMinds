

requestResupplyCrateRecall = {
	params ["_crate", "_recaller"];

	private _cannotRecallStr = "You cannot recall";

	private  _playerSquadName = _recaller getVariable "resupplySquadGroupName";


	if (isNil { _playerSquadName }) exitWith {
		_cannotRecallStr remoteExec ["hint", owner _recaller];
	};



	_currentAllocations = missionNamespace getVariable _playerSquadName;

	private _currentCrates = _currentAllocations get "Crates";

	if(_currentCrates <= 0) exitWith {
		_cannotRecallStr remoteExec ["hint", owner _recaller];
	};

	private _isAbleToRecall = _currentAllocations get "CanReset";

	if(!_isAbleToRecall) exitWith {
		_cannotRecallStr remoteExec ["hint", owner _recaller];
	};

	_currentCrateObjects = _currentAllocations get "CrateObjects";

	{
		deleteVehicle _x;
	} forEach _currentCrateObjects;

	_currentAllocations set ["Crates", 0];
	_currentAllocations set ["CrateObjects", []];
	_currentAllocations set ["CanReset", false];
	_currentAllocations set ["RecallResetTime", CBA_missionTime + ResupplyDefaultRecallCooldown];

	[{
		params ["_squadName"];
		_currentAllocations = missionNamespace getVariable _squadName;

		_currentAllocations set ["CanReset", true];

		missionNamespace setVariable [_squadName, _currentAllocations, true];
	}, [_playerSquadName], ResupplyDefaultRecallCooldown] call CBA_fnc_waitAndExecute;

	missionNamespace setVariable [_playerSquadName, _currentAllocations, true];

	"Crates Recalled" remoteExec ["hint", owner _recaller];
	
};