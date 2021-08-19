fillResupplyCrate = {

	params ["_crate"];


	private _crateType = _crate getVariable "resupplyCrateName";

	diag_log format ["Fill Crate Exec [%1, %2]", _crate, _crateType];
	if( !isNil{ _crateType }) then {
		private _crateInfo = ResupplyCrates get _crateType;

		private _itemsMap = _crateInfo get "Items";
		clearItemCargoGlobal _crate;
		clearMagazineCargoGlobal _crate;
		clearWeaponCargoGlobal _crate;
		clearBackpackCargoGlobal _crate;
		{
			_itemClass = _x;
			_itemAmount = _y;
			_crate addItemCargoGlobal [_itemClass, _itemAmount];
		} forEach _itemsMap;
	};
};