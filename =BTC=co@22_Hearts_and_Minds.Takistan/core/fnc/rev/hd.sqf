_unit = _this select 0;
_part = _this select 1;
_dam = _this select 2;
_injurer = _this select 3;
_ammo = _this select 4;

_v_bleed = 4;
_v_bloss = 10;
_v_pain = 2;

_eh_array = _unit getVariable ["btc_rev_eh_array",[]];
//#define __ammocfg configFile >> "cfgAmmo" >> _ammo _explosive = (getNumber(__ammocfg >> "explosive") > 0);
switch (_part) do
{
	case "head_hit" : {_part = "head";};
	case "hand_l" : {_part = "hands";};
	case "hand_r" : {_part = "hands";};
	case "leg_l" : {_part = "legs";};
	case "leg_r" : {_part = "legs";};
};
if (_part != "") then 
{
	if (_part == "head" && (count _eh_array) > 0) exitWith {0};
	_eh_array set [(count _eh_array), [_part,_dam]];
	_unit setVariable ["btc_rev_eh_array",_eh_array];
};

if (vehicle _unit != _unit && {_part == ""} && {(count _eh_array) == 0}) then 
{
	{_eh_array set [(count _eh_array), [_part,_dam]];_unit setVariable ["btc_rev_eh_array",_eh_array];} foreach [1,2,3,4];
};

//diag_log format ["BTC HD = %1 - %2",_this,_eh_array];

if (count _eh_array < 4) exitWith {0};

if (vehicle _unit != _unit) then
{
	if (!Alive (vehicle _unit)) then
	{
		_unit action ["getOut",vehicle _unit];//EJECT
		_unit setvariable ["btc_rev_bloss",1];
		_unit setvariable ["btc_rev_bleed",1];
		_unit setvariable ["btc_rev_pain",1];
		_unit spawn btc_fnc_rev_unc;	
	}
	else
	{
		_unit spawn
		{
			private "_veh";
			_veh = (vehicle _this);
			sleep 2.5;
			if (!Alive _veh) then
			{
				_this action ["getOut",vehicle _this];
				_this setvariable ["btc_rev_bloss",1];
				_this setvariable ["btc_rev_bleed",1];
				_this setvariable ["btc_rev_pain",1];
				_this switchMove "AinjPpneMstpSnonWrflDnon";
				_this spawn btc_fnc_rev_unc;
			};
		};
	};
};

_unit setVariable ["btc_rev_eh_array",[]];

_part = "";_dam = 0;
{
	if ((_x select 1) > _dam) then
	{
		_part = (_x select 0);
		_dam = (_x select 1);
	};
} foreach _eh_array;

//diag_log text format ["HD = P %1 - DAM %2 - PAIN %3 (%4) - BLEED %5 (%6)",_part,_dam,_unit getvariable ["btc_rev_pain",0],(_dam / _v_pain),_unit getvariable ["btc_rev_bleed",0],(_dam / _v_bleed)];

_prevDamage = _unit getvariable (format ["btc_rev_%1",_part]);
_unit setVariable [(format ["btc_rev_%1",_part]), (_prevDamage + _dam)];

_fatigue = getFatigue player;
_new_fatigue = (_dam / 3) + _fatigue;
player setFatigue _new_fatigue;

_bloss = _unit getvariable ["btc_rev_bloss",0];
_bleed = _unit getvariable ["btc_rev_bleed",0];
_pain = _unit getvariable ["btc_rev_pain",0];
addCamShake [(_dam * 10), 1, 15];
[_dam * 100] call BIS_fnc_bloodEffect;


if (_dam > 0.2) then
{
	_unit setvariable ["btc_rev_bloss",(_bloss + (_dam / _v_bloss))];
	_unit setvariable ["btc_rev_bleed",(_bleed + (_dam / _v_bleed))];
	_unit setvariable ["btc_rev_pain",(_pain + (_dam / _v_pain))];
};

if (isNil {_unit getVariable "btc_rev_statehandler"}) then {_unit spawn btc_fnc_rev_statehandler;};

0