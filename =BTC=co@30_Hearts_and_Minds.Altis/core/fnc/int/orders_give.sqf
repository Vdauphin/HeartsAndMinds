
params ["_units", "_dir", "_order", ["_wp_pos", []]];

_units = _units select {(isNil {group _x getVariable "suicider"}) && ((side _x) == civilian)};

{
	private _wp_pos_i = if ((_order isEqualTo 3) && (_wp_pos isEqualTo [])) then {
		(getpos _x) getPos [200 * sqrt random 1 , _dir - 0.5*40 + random 40]
	} else {
		_wp_pos
	};
	[_x, _order, _wp_pos_i] spawn btc_fnc_int_orders_behaviour;
} foreach _units;

true