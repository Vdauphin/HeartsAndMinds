
private _unit = _this select 0;

_unit addMagazines [selectRandom btc_g_civs, 1];

_unit addEventHandler ["Fired", {
	if ((_this select 1) isEqualTo "Throw") then {
		(_this select 0) removeEventHandler ["Fired", _thisEventHandler];
		[_this select 0] joinSilent createGroup [civilian, true];
		[{
			(_this select 0) call btc_fnc_rep_add_eh;
			[group (_this select 0)] call btc_fnc_civ_addWP;
		}, [_this select 0], 20] call CBA_fnc_waitAndExecute;
	};
}];