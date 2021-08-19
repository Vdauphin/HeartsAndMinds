requestResupplyCrate = {
	params ["_requester", "_crateName"];

	format ["RequestResupplyCrate (%1, %2)", _requester, _crateName];
	private _crateInfo = ResupplyCrates get _crateName;

	private _squadFlag = _requester getVariable "resupplySquadGroupFlag";
	private _squadName = _requester getVariable "resupplySquadGroupName";
	private _squadRoles = _requester getVariable ["resupplySquadRoleFlags", []];
	private _allowedCrates = _requester getVariable ["resupplyCompatibleCrates", []];

	private _allowed = _crateName in (_allowedCrates get (_crateInfo getOrDefault ["Category", "Basic"]));

	if(!_allowed) exitWith {
		format ["Someone tried to request a %1 crate despite not having permissions... Compatibles: %2; Squad Flag %3 Squad Name %4 Roles Assigned %5", _crateName, _allowedCrates, _squadFlag, _squadName, _squadRoles] call resupplyLog;
		format ["You're not allowed to grab %1", _crateName] remoteExec ["hint", owner _requester];
	};

	

	private _specialtyCost = _crateInfo getOrDefault ["SpecialtyCost", 0];

	private _isSpecialCrate = _specialtyCost > 0;

	private _currentAllocations = missionNamespace getVariable _squadName;

	if ( isNil { _currentAllocations } ) exitWith {
		format ["Someone tried to request a %1 crate, allocations are not set up for their squad... Compatibles: %2; Squad Flag %3 Squad Name %4 Roles Assigned %5", _crateName, _allowedCrates, _squadFlag, _squadName, _squadRoles] call resupplyLog;
		format ["You're not allowed to grab %1", _crateName] remoteExec ["hint", owner _requester];
	};
	private _currentSpecialtyResources = _currentAllocations get "SpecialtyResources";
	_allowed = true;
	if(_isSpecialCrate) then {
		if((_currentSpecialtyResources - _specialtyCost) < 0) exitWith {
			_allowed = false;
		};
	};

	if(!_allowed) then {
		format ["Not enough specialty resources to grab this crate"] remoteExec ["hint", owner _requester];
	};

	private _currentCrates = _currentAllocations get "Crates";

	_currentCrates = 0 max _currentCrates;
	private _maxCrates = ResupplyCrateAllocations get _squadFlag get "CrateAllocations";

	if ( _currentCrates >= _maxCrates ) exitWith {
		format ["Max crates for your squad has been reached"] remoteExec ["hint", owner _requester];
	};




	// Can spawn then.

	private _model = _crateInfo getOrDefault ["Model", "Box_NATO_Ammo_F"];

	private _offset = _crateInfo getOrDefault ["Offset", [0, 1, 1]];

	if ( isNil { _offset }) then {
		_offset = [0, 1, 1];
	};

	_crate = createVehicle [_model, position _requester, [], 0, "CAN_COLLIDE"];

	
	[_crate, 300] remoteExec ["setMass", 0];
	_crate addEventHandler ["HandleDamage", { false }];
	_crate setVariable ["resupplyCrateName", _crateName, true];
	_crate setVariable ["resupplySquadOwner", _squadName, true];
	_crate setVariable ["resupplySquadFlag", _squadFlag, true];

	[_crate] call fillResupplyCrate;
	[_crate] call addCrateDeleteHandlers;

	_currentAllocations set ["Crates", _currentCrates + 1];

	_currentCrateObjects = _currentAllocations get "CrateObjects";

	_currentCrateObjects pushBack _crate;

	_currentAllocations set ["CrateObjects", _currentCrateObjects];

	if(_isSpecialCrate) then {
		private _maxSpecialtyResources = ResupplyCrateAllocations get _squadFlag getOrDefault ["SpecialtyAllocations", 0];

		private _missionTime = CBA_missionTime;

		format ["Mission Time is %1, setting Reset to %2", _missionTime, _missionTime + ResupplyDefaultSpecialtyCooldown] call resupplyLog;
		_currentAllocations set ["SpecialtyResources", _currentSpecialtyResources - _specialtyCost];
		_currentAllocations set ["ResetTime", _missionTime + ResupplyDefaultSpecialtyCooldown];

		

		
		[loopAndAddSpecialtyResources, [_squadName, _maxSpecialtyResources], ResupplyDefaultSpecialtyCooldown] call CBA_fnc_waitAndExecute;
		
	};

	missionNamespace setVariable [_squadName, _currentAllocations, true];

	

	[_crate, _requester, _offset] remoteExec ["onSupplyCrateSpawned", 0];

	
	
	

};