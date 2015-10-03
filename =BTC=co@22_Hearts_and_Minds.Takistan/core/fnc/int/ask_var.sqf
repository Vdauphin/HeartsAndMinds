//[0,_ied,player]

private ["_id","_target","_asker","_data"];

_id = _this select 0;
_target = _this select 1;
_asker  = _this select 2;

_data = [];

switch (_id) do {
	case 0 : {_data = _target getVariable ["active",true];};
	case 1 : {
		private "_hd";
		_hd = objNull;
		{if (_x distance _asker < 3000) then {_hd = _x;};} foreach btc_hideouts;
		_data = _hd;
	};
	case 2 : {_data = btc_global_reputation;};
	case 3 : {_data = _target getVariable ["cargo",[]];};
	case 4 : {_data = _target getVariable ["tow",objNull];};
	case 5 : {_data = btc_side_jip_data;};
	case 6 : {_data = btc_fobs;};
};


[[_data],"btc_fnc_int_ans_var",_asker,false] spawn BIS_fnc_MP;