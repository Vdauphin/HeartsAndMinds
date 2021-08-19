setResupplyFlags = {
	params ["_player", "_debug"];

	private _isDebugOn = !isNil { _debug };

	private _currentRoleDescription = roleDescription _player;

	private _resupplyLastDescription = _player getVariable ["resupplyLastDescription", ""];

	

	format ["SetResupplyFlags(%1): %2)", _player, _currentRoleDescription] call resupplyLog;
	

	private _currentRoles = [];
	private _currentSquadFlag = nil;
	private _currentSquad = nil;
	{
		private _index = _currentRoleDescription find _y;

		if(_index != -1) then {

			if (_isDebugOn) then {
				format ["Role %1 exists", _x] call resupplyLog;
			};
			_currentRoles pushBack _x;
		};
	} forEach ResupplyRoleDescriptionsToRoleFlags;

	{
		private _flagInfo = _x;
		private _squadNames = _flagInfo get "SquadNames";
		private _match = false;

		{
			private _index = _currentRoleDescription find _x;

			if(_index != -1) exitWith {
				if (_isDebugOn) then {
					format ["Squad matched to %1", _x] call resupplyLog;
				};
				_match = true;
				_currentSquad = _x;
			}
		} forEach _squadNames;

		if(_match) exitWith {
			if (_isDebugOn) then {
				format ["Squad flag set to %1", _flagInfo get "FlagName"] call resupplyLog;
			};
			_currentSquadFlag = _flagInfo get "FlagName";
		};

	} forEach ResupplyRoleDescriptionToSquadFlags;

	if (isNil { _currentSquadFlag }) exitWith {
		format ["Could not detect valid Squad Flag for %1, RD: %2", _player, _currentRoleDescription] call resupplyLog;
	};
	if (isNil { _currentSquad }) exitWith {
		format ["Could not detect valid Squad for %1, RD: %2", _player, _currentRoleDescription] call resupplyLog;
	};
	format ["Set %1 Squad Roles: %2, Squad Flag: %3, Squad Name: %4", _player, _currentRoles, _currentSquadFlag, _currentSquad] call resupplyLog;

	_player setVariable ["resupplySquadRoleFlags", _currentRoles, true];
	_player setVariable ["resupplySquadGroupFlag", _currentSquadFlag, true];
	// NOTE: Just cache the name to enable O(1) lookups
	_player setVariable ["resupplySquadGroupName", _currentSquad, true];

	private _newCompatibleCrates = [_player] call getCompatibleCratesForPlayer;

	if (_isDebugOn) then {
		format ["New Compatible Crates %1", _newCompatibleCrates] call resupplyLog;
	};

	

	_player setVariable ["resupplyCompatibleCrates", _newCompatibleCrates, true];

	_player setVariable ["resupplyLastDescription", _currentRoleDescription];
};