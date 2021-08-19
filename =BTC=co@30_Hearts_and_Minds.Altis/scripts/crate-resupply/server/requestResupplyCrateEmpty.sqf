

requestResupplyCrateEmpty = {
	params ["_crate", "_requester"];

	private _cannotEmptyStr = "You cannot empty this crate";

	private _crateName = _crate getVariable "resupplyCrateName";

	private _crateSquadOwner = _crate getVariable "resupplySquadOwner";

	if (isNil { _crateSquadOwner }) exitWith {
		_cannotEmptyStr remoteExec ["hint", owner _requester];
	};

	private  _playerSquadName = _requester getVariable "resupplySquadGroupName";


	if (isNil { _playerSquadName }) exitWith {
		_cannotEmptyStr remoteExec ["hint", owner _requester];
	};


	if(_crateSquadOwner == _playerSquadName) then {

		clearItemCargoGlobal _crate;
		clearMagazineCargoGlobal _crate;
		clearWeaponCargoGlobal _crate;
		clearBackpackCargoGlobal _crate;	

		format ["%1 Emptied", _crateName] remoteExec ["hint", owner _requester];
	} else {
		_cannotEmptyStr remoteExec ["hint", owner _requester];
	};
};