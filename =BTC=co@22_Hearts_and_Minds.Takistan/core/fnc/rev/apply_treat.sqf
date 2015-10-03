
_unit = _this select 0;
_treat = _this select 1;


switch (_treat) do
{
	case 1 : 
	{
		private ["_bleed","_pain","_new_pain","_dam","_new_dam"];
		_bleed = _unit getVariable ["btc_rev_bleed",0];
		_bleed = _bleed - 0.2;
		if (_bleed < 0) then {_bleed = 0;};
		_unit setVariable ["btc_rev_bleed",_bleed];
		_pain = _unit getvariable ["btc_rev_pain",0];
		_new_pain = _pain - 0.1;if (_new_pain < 0) then {_new_pain = 0;};
		_unit setVariable ["btc_rev_pain",_new_pain];
		
		_new_dam = 0.1;
		_dam = _unit getVariable ["btc_rev_head",0];
		if (_dam > 0) then {_unit setVariable ["btc_rev_head",(_dam - _new_dam)];};
		if (_unit getVariable ["btc_rev_head",0] < 0) then {_unit setVariable ["btc_rev_head",0];};
		_dam = _unit getVariable ["btc_rev_body",0];
		if (_dam > 0) then {_unit setVariable ["btc_rev_body",(_dam - _new_dam)];};
		if (_unit getVariable ["btc_rev_body",0] < 0) then {_unit setVariable ["btc_rev_body",0];};
		_dam = _unit getVariable ["btc_rev_hands",0];
		if (_dam > 0) then {_unit setVariable ["btc_rev_hands",(_dam - _new_dam)];};
		if (_unit getVariable ["btc_rev_hands",0] < 0) then {_unit setVariable ["btc_rev_hands",0];};
		_dam = _unit getVariable ["btc_rev_legs",0];
		if (_dam > 0) then {_unit setVariable ["btc_rev_legs",(_dam - _new_dam)];};
		if (_unit getVariable ["btc_rev_legs",0] < 0) then {_unit setVariable ["btc_rev_legs",0];};
	};
	case 2 : 
	{
		private ["_bleed","_pain","_new_pain"];
		_bleed = _unit getVariable ["btc_rev_bleed",0];
		_bleed = _bleed - 0.5;
		if (_bleed < 0) then {_bleed = 0;};
		_unit setVariable ["btc_rev_bleed",_bleed];
		_pain = _unit getvariable ["btc_rev_pain",0];
		_new_pain = _pain - 0.1;if (_new_pain < 0) then {_new_pain = 0;};
		_unit setVariable ["btc_rev_pain",_new_pain];

		_new_dam = 0.2;
		_dam = _unit getVariable ["btc_rev_head",0];
		if (_dam > 0) then {_unit setVariable ["btc_rev_head",(_dam - _new_dam)];};
		if (_unit getVariable ["btc_rev_head",0] < 0) then {_unit setVariable ["btc_rev_head",0];};
		_dam = _unit getVariable ["btc_rev_body",0];
		if (_dam > 0) then {_unit setVariable ["btc_rev_body",(_dam - _new_dam)];};
		if (_unit getVariable ["btc_rev_body",0] < 0) then {_unit setVariable ["btc_rev_body",0];};
		_dam = _unit getVariable ["btc_rev_hands",0];
		if (_dam > 0) then {_unit setVariable ["btc_rev_hands",(_dam - _new_dam)];};
		if (_unit getVariable ["btc_rev_hands",0] < 0) then {_unit setVariable ["btc_rev_hands",0];};
		_dam = _unit getVariable ["btc_rev_legs",0];
		if (_dam > 0) then {_unit setVariable ["btc_rev_legs",(_dam - _new_dam)];};
		if (_unit getVariable ["btc_rev_legs",0] < 0) then {_unit setVariable ["btc_rev_legs",0];};
	};
	case 3 :
	{
		private ["_mor"];
		_mor = _unit getvariable ["btc_rev_mor",0];
		_unit setvariable ["btc_rev_mor",(_mor + 1)];
		_pain = _unit getvariable ["btc_rev_pain",0];
		_new_pain = _pain - 0.2;if (_new_pain < 0) then {_new_pain = 0;};
		_unit setVariable ["btc_rev_pain",_new_pain];
		//_spawn = _unit spawn {private ["_id"];_id = _this getVariable ["btc_rev_id",0];sleep btc_rev_mor_duration;if (_this getVariable ["btc_rev_id",0] == _id) then {private ["_mor"];_mor = _unit getvariable ["btc_rev_mor",0];if (_mor - 1 < 0) then {_mor = 1;};_unit setvariable ["btc_rev_mor",(_mor - 1)];};};
	};
	case 4 :
	{
		_unit setVariable ["btc_rev_isUnc",false];
	};
	case 5 :
	{
		private ["_bloss"];
		_bloss = _unit getVariable ["btc_rev_bloss",0];
		_bloss = _bloss - 0.5;
		if (_bloss < 0) then {_bloss = 0;};
		_unit setVariable ["btc_rev_bloss",_bloss];
	};
};
