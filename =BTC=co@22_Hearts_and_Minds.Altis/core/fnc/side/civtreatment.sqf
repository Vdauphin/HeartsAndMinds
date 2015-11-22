
private ["_useful","_veh","_vehpos","_city","_pos","_r","_houses","_roads","_marker","_unit_type","_fx","_btc_civ_type_phone","_item_type","_unconsciousTime","_selection","_type"];

//// Choose a clear City \\\\
_useful = [];
{if (!(_x getVariable ["occupied",false]) && {_x getVariable ["type",""] != "NameLocal"} && {_x getVariable ["type",""] != "Hill"}) then {_useful = _useful + [_x];};} foreach btc_city_all;
if (count _useful == 0) exitWith {[] spawn btc_fnc_side_create;};
_city = _useful select (floor random count _useful);
_pos = getPos _city;

//// Choose spawn in house or on road \\\\
_r = random 2;
if ( _r < 1)	then {
	_roads = _pos nearRoads 200;
	if (count _roads > 0) then {_pos = getPos (_roads select (floor random count _roads));};
	_vehpos = [_pos, 10] call btc_fnc_randomize_pos;
} else {
	_houses = [[(_pos select 0),(_pos select 1),0],200] call btc_fnc_getHouses;
	_pos = getPos (_houses select (floor random count _houses));
	_vehpos = [(_pos select 0),(_pos select 1),(_pos select 2) + 0.1];
};

btc_side_aborted = false;
btc_side_done = false;
btc_side_failed = false;
btc_side_assigned = true;publicVariable "btc_side_assigned";

[[8,_pos,_city getVariable "name"],"btc_fnc_task_create",true] spawn BIS_fnc_MP;

btc_side_jip_data = [8,_pos,_city getVariable "name"];

//// Create marker \\\\
_marker = createmarker [format ["sm_2_%1",_pos],_pos];
_marker setmarkertype "hd_flag";
_marker setmarkertext "Civil need help";
_marker setMarkerSize [0.6, 0.6];

//// Create civ on _pos \\\\
if ( _r < 1) then {
	_veh_type = btc_civ_type_veh select (floor (random (count btc_civ_type_veh)));
	_veh = createVehicle [_veh_type, _vehpos, [], 0, "NONE"];
	_veh setDir (random 360);
	_veh setDamage 0.7;
	//// Random wheel hit \\\\
	if (_r <0.5) then {
		_veh setHit ["wheel_1_2_steering", 1];
	} else {
		_veh setHit ["wheel_2_1_steering", 1];
	};
	_veh setHit ["wheel_1_1_steering", 1];
	//// Add smoke effect on car \\\\
	_fx = "test_EmptyObjectForSmoke" createVehicle (getposATL _veh);
	_fx attachTo [_veh,[0,0,0]];
} else {
	_btc_civ_type_phone = ["Land_PortableLongRangeRadio_F","Land_MobilePhone_smart_F","Land_MobilePhone_old_F"];
	_item_type = _btc_civ_type_phone select (floor (random (count _btc_civ_type_phone)));
	_veh = createVehicle [_item_type, _vehpos, [], 0, "NONE"];
	_veh setDir (random 360);
};

_unit_type = btc_civ_type_units select (floor random count btc_civ_type_units);
_group = createGroup civilian;
_group setVariable ["no_cache",true];
_group setVariable ["btc_patrol",true];
_unit =_group createUnit [_unit_type, _pos, [], 0, "NONE"];
(leader _group) setpos _pos;
_unit setBehaviour "CARELESS";
_unit setDir (random 360);
_unit setPosATL _pos;
_unit setUnitPos "DOWN";
{_x call btc_fnc_civ_unit_create} foreach units _group;

/*
Author: SENSEI
Last modified: 10/3/2015
Description: set unit in cardiac arrest
Note: needs delay if called directly after spawning unit
Return: nothing
__________________________________________________________________*/
sleep 1;
_selection = [
    "head",
    "body",
    "hand_l",
    "hand_r",
    "leg_l",
    "leg_r"
];
_type = [
    "bullet",
    "grenade",
    "explosive",
    "shell"
];
if (ace_medical_level isEqualTo 1) then {
	_unconsciousTime = 120 + round (random 600);
	[_unit,true,_unconsciousTime,true] call ace_medical_fnc_setUnconscious;
	for "_i" from 0 to 2 do {
		[_unit, (_selection select (random ((count _selection) - 1))), 0.7 + (random 0.15), objNull, (_type select (random ((count _type) - 1)))] call ace_medical_fnc_handleDamage;
	};
	[{
		params ["_args","_id"];
		_args params ["_unit","_time"];

		if (diag_tickTime > _time) exitWith {
			[_id] call CBA_fnc_removePerFrameHandler;
			if !([_unit] call ace_common_fnc_isAwake) then {
				_unit setDamage 1;
			};
		};
	}, 1, [_unit,diag_tickTime + _unconsciousTime]] call CBA_fnc_addPerFrameHandler;
} else {
	[_unit, 0.5] call ace_medical_fnc_adjustPainLevel;
	[_unit,true,10,true] call ace_medical_fnc_setUnconscious;
	[_unit] call ace_medical_fnc_setCardiacArrest;
	[_unit, (_selection select (random ((count _selection) - 1))), 0, objNull, (_type select (random ((count _type) - 1))), 0, 0.2] call ace_medical_fnc_handleDamage_advanced;
};

waitUntil {sleep 5; (btc_side_aborted || btc_side_failed || !Alive _unit || {[_unit] call ace_common_fnc_isAwake && ((_unit getVariable ["ace_medical_pain", 0]) < 0.4)})};

{deletemarker _x} foreach [_marker];

if (btc_side_aborted || btc_side_failed || !Alive _unit) exitWith {
	[8,"btc_fnc_task_fail",true] spawn BIS_fnc_MP;
	btc_side_assigned = false;publicVariable "btc_side_assigned";
	{_x spawn {
	waitUntil {sleep 5; ({_x distance _this < 300} count playableUnits == 0)};
	deleteVehicle _this;
	};} forEach [_unit,_veh];
};

15 call btc_fnc_rep_change;

[8,"btc_fnc_task_set_done",true] spawn BIS_fnc_MP;

_unit setUnitPos "UP";
{_x spawn {
	waitUntil {sleep 5; ({_x distance _this < 300} count playableUnits == 0)};
	deleteVehicle _this;
};} forEach [_unit,_veh];

btc_side_assigned = false;publicVariable "btc_side_assigned";