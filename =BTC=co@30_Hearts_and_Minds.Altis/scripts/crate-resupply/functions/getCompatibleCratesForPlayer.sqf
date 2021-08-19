getCompatibleCratesForPlayer = {

	params ["_player", "_debug"];

	private _isDebugOn = !isNil { _debug };

	private _squadFlag = _player getVariable "resupplySquadGroupFlag";
	private _squadName = _player getVariable "resupplySquadGroupName";
	private _squadRoles = _player getVariable ["resupplySquadRoleFlags", []];

	format ["getCompatibleCratesForPlayer(%1): [%2, %3, %4]", _player, _squadFlag, _squadName, _squadRoles] call resupplyLog;


	if( isNil { _squadFlag }) exitWith {
		createHashMap;
	};

	if( isNil { _squadName }) exitWith {
		createHashMap;
	};

	private _squadAllocationDef = ResupplyCrateAllocations get _squadFlag;

	if (isNil { _squadAllocationDef } ) exitWith {
		createHashMap;
	};

	private _whitelistedFlags = _squadAllocationDef getOrDefault ["WhitelistedFlags", []];

	if( isNil { _whitelistedFlags } ) exitWith {
		createHashMap;
	};

	private _allowed = count _whitelistedFlags == 0;
	if ( count _whitelistedFlags > 0 ) then {
		{
			_allowed = _x in _whitelistedFlags;

			if(_allowed) exitWith {
				_allowed = true;
			};
		} forEach _squadRoles;
	};

	if(!_allowed) exitWith {
		createHashMap;
	};

	private _compatibleCrates = createHashMap;
	{
		_crateName = _x;
		_crateInfo = _y;

		_squadLocks = _crateInfo get "SquadLocks";
		_whitelist = _crateInfo get "WhitelistedRoles";
		_blacklist = _crateInfo get "BlacklistedRoles";

		_category = _crateInfo getOrDefault ["Category", "Basic"];

		if(_isDebugOn) then {
			format ["Crate %1:", _crateName] call resupplyLog;
			format ["    Whitelisted Roles: %1", _whitelist] call resupplyLog;
			format ["    Blacklisted Roles: %1", _blacklist] call resupplyLog;
			format ["    Squad Locks: %1", _squadLocks] call resupplyLog;
		};
		private _allowed = false;
		if(count _squadLocks > 0) then {
			 _allowed = _squadFlag in _squadLocks;
		};
		if(!_allowed && count _squadLocks > 0) then {
			continue;
		};
		_allowed = false;

		if(count _whitelist > 0) then {
			
			{
				private _role = _x;
				private _inWhitelist = _role in _whitelist;

				if(_inWhitelist) exitWith {
					if(_isDebugOn) then {
						format ["%1 is in whitelist", _role] call resupplyLog;
					};
					_allowed = true;
				};
			} forEach _squadRoles;
			
		};

		if(!_allowed && count _whitelist > 0) then {
			continue;
		};
		_allowed = true;

		private _amountBlacklisted = 0;
		if(count _blacklist > 0) then {
			{
				private _role = _x;
				private _inBlacklist = _role in _blacklist;

				if(_inBlacklist) then {
					if(_isDebugOn) then {
						format ["%1 is in blacklist", _role] call resupplyLog;
					};
					_amountBlacklisted = _amountBlacklisted + 1;
				};
				
			} forEach _squadRoles;

			
		};
		
		_allowed = _amountBlacklisted < count _squadRoles;
		
		if(!_allowed) then {
			continue;
		};

		

		private _currentValue = _compatibleCrates getOrDefault [_category, []];

		_currentValue pushBack _crateName;

		_compatibleCrates set [_category, _currentValue];
	} forEach ResupplyCrates;

	_compatibleCrates
};