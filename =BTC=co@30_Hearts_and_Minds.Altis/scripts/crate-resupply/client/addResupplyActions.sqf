addResupplyActions = {
	params ["_supplyCrate"];


	
	_conditionToShowRoot = {
		true
	};
	_insertChildren = {
		params ["_target", "_player", "_params"];

		private _containerNear = (count (nearestObjects [player, ResupplyCrateSourceClasses, 10])) > 0;

		if(!_containerNear) exitWith {
			[];
		};
		
		private _crateSquadOwner = _target getVariable "resupplySquadOwner";

		

		if (isNil { _crateSquadOwner }) exitWith {
			[];
		};

		

		private  _playerSquadName = player getVariable "resupplySquadGroupName";


		if (isNil { _playerSquadName }) exitWith {
			[];
		};

		private _playerSquadFlag = player getVariable "resupplySquadGroupFlag";

		if (isNil { _playerSquadFlag }) exitWith {
			[];
		};

		private _squadDefinition = ResupplyCrateAllocations get _playerSquadFlag; 

		if (isNil { _squadDefinition }) exitWith {
			[];
		};

		private _globalResupplier = _squadDefinition getOrDefault ["Resupplier", false];

		if (!_globalResupplier && _playerSquadName != _crateSquadOwner) exitWith {
			[];
		};
		
		private _crateType = _target getVariable "resupplyCrateName";

		if (isNil { _crateType }) exitWith {
			[];
		};

		private _actions = [];

		_canReturn = {
			params ["_target", "_player", "_params"];

			private _crateSquadOwner = _target getVariable "resupplySquadOwner";

			if (isNil { _crateSquadOwner }) exitWith {
				false;
			};

			private _playerSquadName = player getVariable "resupplySquadGroupName";


			if (isNil { _playerSquadName }) exitWith {
				false;
			};
			
			private _allowed = _playerSquadName == _crateSquadOwner;
			_allowed;
		};



		_onReturn = {
			params ["_target", "_player", "_params"];
			
			[_target, player] remoteExec ["requestResupplyCrateReturn", 2];
		};

		_returnAction = ["KARMA_RESUPPLY_CRATE_RETURN", format ["Return %1", _crateType], "", _onReturn, _canReturn] call ace_interact_menu_fnc_createAction;


		_modifyRefillDisplayName = {
			params ["_target", "_player", "_params", "_actionData"];
			private _crateSquadOwner = _target getVariable "resupplySquadOwner";

			if (isNil { _crateSquadOwner }) exitWith {
				false;
			};

			private _crateSquadFlag = _target getVariable "resupplySquadFlag";

			if (isNil { _crateSquadFlag }) exitWith {
				false;
			};

			private  _playerSquadName = player getVariable "resupplySquadGroupName";


			if (isNil { _playerSquadName }) exitWith {
				false;
			};

			private _playerSquadFlag = player getVariable "resupplySquadGroupFlag";

			if (isNil { _playerSquadFlag }) exitWith {
				false;
			};

			private _squadDefinition = ResupplyCrateAllocations get _playerSquadFlag; 

			if (isNil { _squadDefinition }) exitWith {
				false;
			};

			private _crateName = _target getVariable "resupplyCrateName";
			_actionData set [1, format ["Refill %1", _crateName]];
			private _crateInfo = ResupplyCrates get _crateName;


			private _allowed = true;
			

			private _globalResupplier = _squadDefinition getOrDefault ["Resupplier", false];

			if(_globalResupplier || _playerSquadName == _crateSquadOwner) then {
				
				if ( !(isNil { _crateInfo })) then {
					private _isSpecialCrate = (_crateInfo getOrDefault ["SpecialtyCost", 0]) > 0;

					private _currentAllocations = missionNamespace getVariable _crateSquadOwner;

					if(_isSpecialCrate == true && _currentAllocations getOrDefault ["SpecialtyResources", 0] <= 0) then {
						private _currentMissionTime = CBA_missionTime;

						private _resetTime = _currentAllocations get "ResetTime";
						if ( !(isNil { _resetTime }) ) then {
							if (_resetTime > 0) then {
								private _diffTime = _resetTime - _currentMissionTime;

								private _minutes = floor (_diffTime / 60);

								private _strMin = str _minutes;

								if (count _strMin == 1) then {
									_strMin = "0" + _strMin;
								};

								private _remainingSeconds = floor (_diffTime - _minutes * 60);

								private _strSec = str _remainingSeconds;

								if (count _strSec == 1) then {
									_strSec = "0" + _strSec;
								};

								_actionData set [1, format ["Refill available in %1:%2", _strMin, _strSec]];
							};
						};
					};
					
				};
			};

			_actionData;
		};

		_onRefill = {
			params ["_target", "_player", "_params"];

			private _crateSquadOwner = _target getVariable "resupplySquadOwner";

			if (isNil { _crateSquadOwner }) exitWith {
				false;
			};

			private  _playerSquadName = player getVariable "resupplySquadGroupName";


			if (isNil { _playerSquadName }) exitWith {
				false;
			};

			private _playerSquadFlag = player getVariable "resupplySquadGroupFlag";

			if (isNil { _playerSquadFlag }) exitWith {
				false;
			};

			private _squadDefinition = ResupplyCrateAllocations get _playerSquadFlag; 

			if (isNil { _squadDefinition }) exitWith {
				false;
			};

			private _crateInfo = ResupplyCrates get (_target getVariable "resupplyCrateName");


			private _allowed = true;
			if ( !(isNil { _crateInfo })) then {
				private _isSpecialCrate = (_crateInfo getOrDefault ["SpecialtyCost", 0]) > 0;

				private _currentAllocations = missionNamespace getVariable _crateSquadOwner;

				if(_isSpecialCrate == true && _currentAllocations getOrDefault ["SpecialtyResources", 0] <= 0) exitWith {
					_allowed = false;
					false
				};
			};

			if(!_allowed) exitWith {
				false;
			};

			private _globalResupplier = _squadDefinition getOrDefault ["Resupplier", false];

			if(_globalResupplier || _playerSquadName == _crateSquadOwner) then {
				[_target, player] remoteExec ["requestResupplyCrateRefill", 2];
			};

		};
		_refillAction = ["KARMA_RESUPPLY_CRATE_REFILL", format ["Refill %1", _crateType], "z\ace\addons\rearm\ui\icon_rearm_interact.paa", _onRefill, { true }, {}, [], {[0, 0, 0]}, 2, [false, false, false, false, false], _modifyRefillDisplayName] call ace_interact_menu_fnc_createAction;
		


		
		_onEmpty = {
			params ["_target", "_player", "_params"];

			[_target, player] remoteExec ["requestResupplyCrateEmpty", 2];
		};
		// Being able to empty is the same perms as being able to return it.
		_emptyAction = ["KARMA_RESUPPLY_CRATE_EMPTY", format ["Empty %1", _crateType], "", _onEmpty, _canReturn];

		_actions pushBack [_emptyAction, [], _target];
		_actions pushBack [_returnAction, [], _target];
		_actions pushBack [_refillAction, [], _target];

		_actions;

	};

	private _crateName = _supplyCrate getVariable "resupplyCrateName";
	private _crateSquadOwner = _supplyCrate getVariable "resupplySquadOwner";
	_menuRoot = ["KARMA_RESUPPLY_CRATE_ROOT", format ["%1 (%2)", _cratename, _crateSquadOwner], "z\ace\addons\rearm\ui\icon_rearm_interact.paa", { true }, _conditionToShowRoot, _insertChildren] call ace_interact_menu_fnc_createAction;
	[_supplyCrate, 0, ["ACE_MainActions"], _menuRoot] call ace_interact_menu_fnc_addActionToObject;
};