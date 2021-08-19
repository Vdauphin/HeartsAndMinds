

requestResupplyCrateRefill = {
	params ["_crate", "_refiller"];
	private _cannotResupplyStr = "You cannot refill this crate";
	// Ensure check

	private _crateSquadOwner = _crate getVariable "resupplySquadOwner";

	private _crateSquadFlag = _crate getVariable "resupplySquadFlag";

	if (isNil { _crateSquadOwner }) exitWith {
		_cannotResupplyStr remoteExec ["hint", owner _refiller];
	};

	private  _playerSquadName = _refiller getVariable "resupplySquadGroupName";


	if (isNil { _playerSquadName }) exitWith {
		_cannotResupplyStr remoteExec ["hint", owner _refiller];
	};

	private _playerSquadFlag = _refiller getVariable "resupplySquadGroupFlag";

	if (isNil { _playerSquadFlag }) exitWith {
		_cannotResupplyStr remoteExec ["hint", owner _refiller];
	};

	private _squadDefinition = ResupplyCrateAllocations get _playerSquadFlag; 

	if (isNil { _squadDefinition }) exitWith {
		_cannotResupplyStr remoteExec ["hint", owner _refiller];
	};

	private _globalResupplier = _squadDefinition getOrDefault ["Resupplier", false];


	if(_crateSquadOwner == _playerSquadName || _globalResupplier) then {

		// Check for specials

		private _crateName = _crate getVariable "resupplyCrateName";
		private _crateInfo = ResupplyCrates get _crateName;



		private _isSpecialCrate = (_crateInfo getOrDefault ["SpecialtyCost", 0]) > 0;

		if(_isSpecialCrate) then {

			private _specialtyCost = _crateInfo get "SpecialtyCost";

			private _currentAllocations = missionNamespace getVariable _crateSquadOwner;

			private _currentSpecialtyResources = _currentAllocations get "SpecialtyResources";
			if((_currentSpecialtyResources - _specialtyCost) < 0) exitWith {
				format ["Not enough specialty resources to refill this crate"] remoteExec ["hint", owner _requester];
			};

			[_crate] call fillResupplyCrate;

			private _missionTime = CBA_missionTime;

			_currentAllocations set ["SpecialtyResources", _currentSpecialtyResources - _specialtyCost];
			_currentAllocations set ["ResetTime", _missionTime + ResupplyDefaultSpecialtyCooldown];

			missionNamespace setVariable [_crateSquadOwner, _currentAllocations, true];

			private _maxSpecialtyResources = ResupplyCrateAllocations get _crateSquadFlag getOrDefault ["SpecialtyAllocations", 0];

			[loopAndAddSpecialtyResources, [_crateSquadOwner, _maxSpecialtyResources], ResupplyDefaultSpecialtyCooldown] call CBA_fnc_waitAndExecute;

			format ["%1 Refilled", _crateName] remoteExec ["hint", owner _refiller];
			
		} else {
			[_crate] call fillResupplyCrate;
			format ["%1 Refilled", _crateName] remoteExec ["hint", owner _refiller];
		}
	};


};