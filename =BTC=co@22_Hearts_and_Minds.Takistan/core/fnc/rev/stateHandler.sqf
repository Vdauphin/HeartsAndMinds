
private ["_fatigue","_get_fatigue","_new_fatigue","_bloss","_is_bleed","_bleed_fatigue"];

_unit = _this;
_unit setVariable ["btc_rev_statehandler",true];

#define _damageHead _unit getVariable ["btc_rev_head",0]
#define _damageBody _unit getVariable ["btc_rev_body",0]
#define _damageHands _unit getVariable ["btc_rev_hands",0]
#define _damagelegs _unit getVariable ["btc_rev_legs",0]

#define _fatigue_bleed 4
#define _fatigue_dam 10

#define __STATE _unit getVariable ["btc_rev_isUnc",false]

//Init var
btc_rev_fx_effects = false;
btc_rev_fx_effect_pain = false;
_fatigue = 0;
_cond = true;

While {Alive _unit && _cond} do
{
	_fatigue = 0;
//DAM CHECK
	if (_unit getVariable ["btc_rev_head",0] > btc_rev_max_damage_head && !(__STATE)) then {_unit setvariable ["btc_rev_pain",1];_unit spawn btc_fnc_rev_unc;} else {_fatigue = _fatigue + ((_unit getVariable ["btc_rev_head",0]) * (((speed _unit) / _fatigue_dam)));};
	if (_unit getVariable ["btc_rev_body",0] > btc_rev_max_damage_body && !(__STATE)) then {_unit setvariable ["btc_rev_pain",1];_unit spawn btc_fnc_rev_unc;} else {_fatigue = _fatigue + ((_unit getVariable ["btc_rev_body",0]) * (((speed _unit) / _fatigue_dam)/2));};
	if (_unit getVariable ["btc_rev_hands",0] > btc_rev_max_damage_hands && !(__STATE)) then {_unit setvariable ["btc_rev_pain",1];_unit spawn btc_fnc_rev_unc;} else {_fatigue = _fatigue + ((_unit getVariable ["btc_rev_hands",0]) * (((speed _unit) / _fatigue_dam)/2));};
	if (_unit getVariable ["btc_rev_legs",0] > btc_rev_max_damage_legs && !(__STATE)) then {_unit setvariable ["btc_rev_pain",1];_unit spawn btc_fnc_rev_unc;} else {_fatigue = _fatigue + ((_unit getVariable ["btc_rev_legs",0]) * (((speed _unit) / _fatigue_dam)/2));};

//BLOSS CHECK
	if ((_unit getvariable ["btc_rev_bleed",0]) > 0) then
	{
		if ((_unit getvariable ["btc_rev_bleed",0]) > 1) then {_unit setvariable ["btc_rev_bleed",1]};
		_moving_factor = if (speed _unit >= 3) then {0.0001} else {0.00005};
		_bleed = (_unit getvariable ["btc_rev_bleed",0])/1000;
		_bloss = _unit getvariable ["btc_rev_bloss",0];
		_new_bloss = _bloss + _bleed + _moving_factor;if (_new_bloss > 1) then {_new_bloss = 1;};
		_unit setVariable ["btc_rev_bloss",_new_bloss];
		_bleed = _unit getvariable ["btc_rev_bleed",0];
		_pain_to_add = (_bleed + (_unit getVariable ["btc_rev_head",0]) + (_unit getVariable ["btc_rev_body",0]) + (_unit getVariable ["btc_rev_hands",0]) + (_unit getVariable ["btc_rev_legs",0])) / 2500;
		_pain = _unit getvariable ["btc_rev_pain",0];
		_new_pain = _pain + _pain_to_add;if (_new_pain > 1) then {_new_pain = 1;};
		_unit setvariable ["btc_rev_pain",_new_pain];
	} 
	else
	{
		/*_bloss = _unit getvariable ["btc_rev_bloss",0];
		_new_bloss = _bloss - 0.0001;if (_new_bloss <= 0) then {_new_bloss = 0;};
		_unit setVariable ["btc_rev_bloss",_new_bloss];*/

		_new_dam = 0.001;
		_dam = _unit getVariable ["btc_rev_head",0];
		if (_dam > 0) then {_unit setVariable ["btc_rev_head",(_dam - _new_dam)];};
		_dam = _unit getVariable ["btc_rev_body",0];
		if (_dam > 0) then {_unit setVariable ["btc_rev_body",(_dam - _new_dam)];};
		_dam = _unit getVariable ["btc_rev_hands",0];
		if (_dam > 0) then {_unit setVariable ["btc_rev_hands",(_dam - _new_dam)];};
		_dam = _unit getVariable ["btc_rev_legs",0];
		if (_dam > 0) then {_unit setVariable ["btc_rev_legs",(_dam - _new_dam)];};
	};
	if (_unit getvariable ["btc_rev_bloss",0] > 1 && {!(__STATE)}) then {_unit setVariable ["btc_rev_bloss",1];_unit spawn btc_fnc_rev_unc;};
//PAIN
	_pain = _unit getvariable ["btc_rev_pain",0];
	_mor = _unit getvariable ["btc_rev_mor",0];
	if (_mor > 0 && {_unit getvariable ["btc_rev_pain",0] > 0}) then
	{
		_reduce = _mor * 0.001;
		_unit setvariable ["btc_rev_pain",(_pain - _reduce)];
	};
	if ((_unit getvariable ["btc_rev_pain",0] >= btc_rev_max_pain || (_unit getvariable ["btc_rev_mor",0] > btc_rev_max_mor)) && {!(__STATE)}) then {_unit spawn btc_fnc_rev_unc;};
//MOR
	if (_mor > 0) then {_unit setvariable ["btc_rev_mor",(_mor - 0.00025)];};
//FATIGUE
	_get_fatigue = getFatigue _unit;
	_new_fatigue = if ((_get_fatigue + (_fatigue / 100)) > 1) then {1} else {(_get_fatigue + (_fatigue / 100))};
	_unit setFatigue _new_fatigue;
	////diag_log format ["%1 - %2 / OLD = %3 NEW = %4",_fatigue,_fatigue / 100,_get_fatigue,(_get_fatigue + (_fatigue / 100))];
//EFFECTS
	if (!(__STATE) && {((_unit getvariable ["btc_rev_bleed",0]) > 0 || (_unit getvariable ["btc_rev_bloss",0]) > 0.4)} && {!btc_rev_fx_effects}) then {[] spawn btc_fnc_rev_effects;};
	if (((_unit getvariable ["btc_rev_pain",0]) > 0) && {!btc_rev_fx_effect_pain}) then {[] spawn btc_fnc_rev_effect_pain;};

//STATE CHECK
	if (_unit getVariable ["btc_rev_legs",0] > 0.7 || {_unit getVariable ["btc_rev_bloss",0] > 0.7}) then {_unit forceWalk true;} else {_unit forceWalk false;};
	//if (__STATE == 1) then {_unit spawn btc_fnc_rev_unc;};
	sleep 0.1;
};

_unit setVariable ["btc_rev_statehandler",nil];