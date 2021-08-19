resupplyLog = {
	diag_log format ["[Resupply] %1", _this];
};
[] call compileFinal preprocessFileLineNumbers "scripts\crate-resupply\config.sqf";
[] call compileFinal preprocessFileLineNumbers "scripts\crate-resupply\functions\index.sqf";

if (isServer) then {
	[] call compileFinal preprocessFileLineNumbers "scripts\crate-resupply\server\addCrateDeleteHandlers.sqf";
	[] call compileFinal preprocessFileLineNumbers "scripts\crate-resupply\server\requestResupplyFlags.sqf";
	[] call compileFinal preprocessFileLineNumbers "scripts\crate-resupply\server\requestResupplyCrate.sqf";
	[] call compileFinal preprocessFileLineNumbers "scripts\crate-resupply\server\requestResupplyCrateRefill.sqf";
	[] call compileFinal preprocessFileLineNumbers "scripts\crate-resupply\server\requestResupplyCrateReturn.sqf";
	[] call compileFinal preprocessFileLineNumbers "scripts\crate-resupply\server\requestResupplyCrateEmpty.sqf";
	[] call compileFinal preprocessFileLineNumbers "scripts\crate-resupply\server\requestResupplyCrateRecall.sqf";
	[] call compileFinal preprocessFileLineNumbers "scripts\crate-resupply\server\loopAndAddSpecialtyResources.sqf";
};

if (!isServer || (isServer && !isDedicated)) then {
	[] call compileFinal preprocessFileLineNumbers "scripts\crate-resupply\client\addResupplyActions.sqf";
};

[] call compileFinal preprocessFileLineNumbers "scripts\crate-resupply\shared\onSupplyCrateSpawned.sqf";


// Server handles deletion and broadcasting
if(isServer) then {
	
	{
		private _ammoCrateClass = _x;

		[_ammoCrateClass, "init", {
			private _ammoContainer = _this select 0;
			
			_ammoContainer addEventHandler ["HandleDamage", { false }];
		}];
	} forEach ResupplyCrateSourceClasses;

	
};

if( (isServer && !isDedicated) || !isServer ) then {
	// Clients instead, will add ACE actions on init to ammo container sources
	{
		private _ammoCrateClass = _x;


		format ["Class Init %1", _ammoCrateClass] call resupplyLog;

		_conditionToShowRoot = {

			private _currentCompatibleCrates = player getVariable ["resupplyCompatibleCrates", []];

			private _shouldShow = count _currentCompatibleCrates > 0;


			_shouldShow;
		};

		// Render category roots
		_renderChildren = {
			params ["_target", "_player", "_params"];

			
			private _currentSquadName = player getVariable "resupplySquadGroupName";
			private _currentSquadFlag = player getVariable "resupplySquadGroupFlag";
			private _currentCompatibleCrates = player getVariable ["resupplyCompatibleCrates" ,[]];



			if ( isNil { _currentSquadName } ) exitWith {
				[]
			};

			if ( isNil { _currentSquadFlag } ) exitWith {
				[]
			};

			private _currentAllocations = missionNamespace getVariable _currentSquadName;
			private _currentCrates = _currentAllocations get "Crates";
			private _maxCrates = ResupplyCrateAllocations get _currentSquadFlag getOrDefault ["CrateAllocations", 0];
			private _actions = [];


			_modifyRecallDisplayName = {
				params ["_target", "_player", "_params", "_actionData"];
				private  _playerSquadName = player getVariable "resupplySquadGroupName";


				if (isNil { _playerSquadName }) exitWith {
					false
				};
				_actionData set [1, format["Recall ALL Resupply Crates for %1", _playerSquadName]];
				

				private _currentAllocations = missionNamespace getVariable _playerSquadName;

				private _canReset = _currentAllocations get "CanReset";

				if (!_canReset) then {

					private _currentMissionTime = CBA_missionTime;
					private _resetTime = _currentAllocations get "RecallResetTime";

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

					_actionData set [1, format ["Recall available in %1:%2", _strMin, _strSec]];
				};

				_actionData;
			};

			_canDisplayRecall = {
				private _currentCompatibleCrates = player getVariable ["resupplyCompatibleCrates", []];

				private _shouldShow = count _currentCompatibleCrates > 0;

				if(!_shouldShow) exitWith {
					false
				};

				private _playerSquadName = player getVariable "resupplySquadGroupName";

				if (isNil { _playerSquadName }) exitWith {
					false
				};
				
				private _currentAllocations = missionNamespace getVariable _playerSquadName;

				private _currentCrates = _currentAllocations get "Crates";

				_currentCrates > 0
			};

			_onRecall = {

				params ["_target", "_player", "_params"];

				private  _playerSquadName = player getVariable "resupplySquadGroupName";


				if (isNil { _playerSquadName }) exitWith {
					false
				};
				
				

				private _currentAllocations = missionNamespace getVariable _playerSquadName;

				private _canReset = _currentAllocations get "CanReset";

				if(!_canReset) exitWith {
					false
				};

				[_target, player] remoteExec ["requestResupplyCrateRecall", 2];
			};


			_recallAction = ["KARMA_RESUPPLY_RECALL", "Recall ALL Crates", "", _onRecall,  _canDisplayRecall, {}, [], {[0, 0, 0]}, 2, [false, false, false, false, false], _modifyRecallDisplayName] call ace_interact_menu_fnc_createAction;

			_actions pushBack [_recallAction, [], _target];
			// Do not show any subcategories when they don't haev enough allocation. All they will see is Resupply Crates (1/1) or etc..
			if (_maxCrates == 0 || _currentCrates >= _maxCrates) exitWith {
				_actions
			};

			
			{
				private _category = _x;

				private _crateNames = _y;
				private _categoryActions = [];
				private _actionName = format ["KARMA_RESUPPLY_SUBROOT_%1", _x];
				private _displayName = format ["%1", _category];

				private _displayCategoryRootCondition = {
					params ["_target", "_player", "_params"];
					private _category = _params select 0;
					private _crateNames = _params select 1;
					private _currentSquadFlag = player getVariable "resupplySquadGroupFlag";

					private _isSpecial = SpecialCategories getOrDefault [_category, false];

					private _shouldShow = true;
					// If this is special, then should display the root only when the squad they belong to can even get special stuff ever.
					// Checks the MAX they can have, not the current.
					if(_isSpecial) then {
						private _maxSpecialtyResources = ResupplyCrateAllocations get _currentSquadFlag getOrDefault ["SpecialtyAllocations", 0];
						_shouldShow = _maxSpecialtyResources > 0;
					};

					_shouldShow;
				};
				private _modifyCategoryRootDisplayName = {
					params ["_target", "_player", "_params", "_actionData"];


					private _category = _params select 0;
					private _crateNames = _params select 1;
					_actionData set [1, format ["%1", _category]];


					private _isSpecial = SpecialCategories getOrDefault [_category, false];

					if (_isSpecial) then {
						private _currentSquadFlag = player getVariable "resupplySquadGroupFlag";
						private _maxSpecialtyResources = ResupplyCrateAllocations get _currentSquadFlag getOrDefault ["SpecialtyAllocations", 0];

						if (_maxSpecialtyResources > 0) then {
							
							private _currentSquadName = player getVariable "resupplySquadGroupName";

							private _currentAllocations = missionNamespace getVariable _currentSquadName;

							private _currentSpecialtyResource = _currentAllocations get "SpecialtyResources";

							if( !isNil { _currentSpecialtyResource }) then {

								if( _currentSpecialtyResource <= 0) then {
									// Get the mission time that is meant to have the reset

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

											_actionData set [1, format ["%1 available in %2:%3", _category, _strMin, _strSec]];
										};
									};
								};
							};
						
						};
					};

					_actionData;
				};
				private _renderCategoryChildren = {
					params ["_target", "_player", "_params"];


					
					private _category = _params select 0;
					private _crateNames = _params select 1;

					private _currentSquadName = player getVariable ["resupplySquadGroupName", ""];
					private _currentSquadFlag = player getVariable ["resupplySquadGroupFlag", ""];
					private _currentAllocations = missionNamespace getVariable _currentSquadName;


					private _squadMaxAllocations = ResupplyCrateAllocations get _currentSquadFlag getOrDefault ["CrateAllocations", 0];

					if( _squadMaxAllocations == 0 || (_currentAllocations get "Crates") >= _squadMaxAllocations) exitWith {
						[]
					};

					private _isSpecial = SpecialCategories getOrDefault [_category, false];


					private _shouldExit = false;

					if (_isSpecial) then {
						// Get our current player squad's allocation.
						// Don't display children crates when they can't pull.
						private _currentSpecialtyResource = _currentAllocations getOrDefault ["SpecialtyResources", 0];


						if(_currentSpecialtyResource <= 0) exitWith {
							_shouldExit = true;
						};
					};

					if(_shouldExit) exitWith {
						[]
					};

					private _actions = [];

					{
						_crateName = _x;

						private _onActionExec = {
							params ["_target", "_player", "_params"];

							_crateName = _params select 0;
							[player, _crateName] remoteExec ["requestResupplyCrate", 2];
							true
						};



						_grabCrate = [_crateName, format ["Grab %1", _crateName], "", _onActionExec, { true }, nil, [_crateName]] call ace_interact_menu_fnc_createAction;

						_actions pushBack [_grabCrate, [], _target];
					} forEach _crateNames;


					// Children actions add to the category that is the action to pull a crate.
					_actions
					
				};	

				_categoryRoot = [_actionName, _displayName, "", { true }, { true }, _renderCategoryChildren, [_category, _crateNames], {[0, 0, 0]}, 2, [false, false, false, false, false], _modifyCategoryRootDisplayName] call ace_interact_menu_fnc_createAction;

				_actions pushBack [_categoryRoot, [], _target];
				
			} forEach _currentCompatibleCrates;
			_actions
		};


		_modifyRootDisplayName = {
			params ["_target", "_player", "_params", "_actionData"];

			private _currentSquadName = player getVariable "resupplySquadGroupName";
			private _currentSquadFlag = player getVariable "resupplySquadGroupFlag";
			private _currentAllocations = missionNamespace getVariable _currentSquadName;
			private _currentCrates = _currentAllocations get "Crates";
			private _maxCrates = ResupplyCrateAllocations get _currentSquadFlag getOrDefault ["CrateAllocations", 0];

			private _displayName = format ["Resupply Crates (%1/%2)", _currentCrates, _maxCrates];

			_actionData set [1, _displayName];
		};
		
		
		
		
		_actionId = ["KARMA_RESUPPLY_ROOT", "Resupply Crates", "\z\ace\addons\rearm\ui\icon_rearm_interact.paa", { true }, _conditionToShowRoot, _renderChildren, [], {[0, 0, 0]}, 5, [false, false, false, false, false], _modifyRootDisplayName] call ace_interact_menu_fnc_createAction;

		[_ammoCrateClass, 0, [], _actionId, false] call ace_interact_menu_fnc_addActionToClass;


	} forEach resupplyCrateSourceClasses; 


	private _resupplyCrateClassNames = keys ResupplyModelsUsed;


	private _resupplyCrates = nearestObjects[[worldSize / 2, worldSize / 2, 0], _resupplyCrateClassNames, worldSize, true];

	{
		_crate = _x;

		private _squadOwner = _crate getVariable "resupplySquadOwner";

		if ( isNil { _squadOwner } ) then {
			continue;
		};

		[_crate] call addResupplyActions;

		
	} forEach _resupplyCrates;
};