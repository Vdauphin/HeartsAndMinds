
private ["_useful","_city","_pos","_road","_roads","_boxes","_marker","_markers","_statics","_tower_type","_tower","_roadConnectedTo","_connectedRoad","_direction","_btc_type_barrel","_btc_type_canister","_btc_type_pallet","_btc_type_box","_type_barrel","_type_canister","_type_pallet","_type_box","_btc_composition_checkpoint"];

//// Choose an occupied City \\\\
_useful = [];
{if (_x getVariable ["occupied",false] && {_x getVariable ["type",""] != "NameLocal"} && {_x getVariable ["type",""] != "Hill"}) then {_useful = _useful + [_x];};} foreach btc_city_all;
if (count _useful == 0) exitWith {[] spawn btc_fnc_side_create;};
_city = _useful select (floor random count _useful);
_pos = getPos _city;

btc_side_aborted = false;
btc_side_done = false;
btc_side_failed = false;
btc_side_assigned = true;publicVariable "btc_side_assigned";

[[9,_pos,_city getVariable "name"],"btc_fnc_task_create",true] spawn BIS_fnc_MP;

btc_side_jip_data = [9,_pos,_city getVariable "name"];

_city setVariable ["spawn_more",true];

_btc_type_barrel = ["Land_GarbageBarrel_01_F","Land_BarrelSand_grey_F","MetalBarrel_burning_F","Land_BarrelWater_F","Land_MetalBarrel_F","Land_MetalBarrel_empty_F"];
_btc_type_canister = ["Land_CanisterPlastic_F"];
_btc_type_pallet = ["Land_Pallets_stack_F","Land_Pallets_F","Land_Pallet_F"];
_btc_type_box = ["Box_East_Wps_F","Box_East_WpsSpecial_F","Box_East_Ammo_F"];
_statics = btc_type_gl + btc_type_mg;

_boxes = [];
_markers = [];
for "_i" from 1 to (1 + round random 2) do {
	//// Choose a road \\\\
	_pos = [getPos _city, 300] call btc_fnc_randomize_pos;
	_roads = _pos nearRoads 300;
	if (count _roads > 0) then {_road = (_roads select (floor random count _roads));
		_pos = getPos _road;
		};
	_roadConnectedTo = roadsConnectedTo _road;
	_connectedRoad = _roadConnectedTo select 0;
	_direction = [_road, _connectedRoad] call BIS_fnc_dirTo;

	//// Create marker \\\\
	_marker = createmarker [format ["sm_2_%1",_pos],_pos];
	_marker setmarkertype "hd_flag";
	_marker setmarkertext "Checkpoint";
	_marker setMarkerColor "ColorRed";
	_marker setMarkerSize [0.6, 0.6];
	_markers = _markers + [_marker];

	//// Randomise composition \\\\
	_type_barrel = _btc_type_barrel select (floor (random (count _btc_type_barrel)));
	_type_barrel_canister1 = (_btc_type_barrel + _btc_type_canister) select (floor (random (count (_btc_type_barrel +_btc_type_canister))));
	_type_barrel_canister2 = (_btc_type_barrel + _btc_type_canister) select (floor (random (count (_btc_type_barrel +_btc_type_canister))));
	_type_pallet = _btc_type_pallet select (floor (random (count _btc_type_pallet)));
	_type_box = _btc_type_box select (floor (random (count _btc_type_box)));
	_btc_composition_checkpoint = [
		[_type_barrel,10,[0.243652,-2.78906,0]],
		[_type_barrel,20,[-0.131836,3.12939,0]],
		["Land_BagFence_Long_F",90,[0.769531,-4.021,0]],
		["Land_BagFence_Long_F",90,[-0.638672,4.31787,0]],
		["Flag_Red_F",-90,[2.23193,-4.375,0]],
		[_type_barrel_canister1,0,[1.27393,-4.93604,0]],
		[_type_pallet,-70,[-3.98071,3.75342,0]],
		[_type_barrel_canister2,0,[1.83984,-4.95264,0]],
		[_type_box,180,[-1.97998,4.88574,0]],
		["Land_CncBarrier_stripes_F",180,[2.26367,-5.38623,0]],
		["RoadCone_L_F",180,[1.14771,-5.89697,0.00211954]],
		["Land_CncBarrier_stripes_F",0,[-2.1416,5.66553,0]],
		["RoadCone_L_F",0,[-1.03101,6.18164,0.00211954]],
		["RoadCone_L_F",180,[2.81616,-5.81689,0.00211954]],
		["RoadCone_L_F",0,[-2.6731,6.17773,0.00211954]]
	];

	//// Create checkpoint with static at _pos \\\\
	[[((_pos select 0) -2.39185*cos(-_direction) - 2.33984*sin(-_direction)), ((_pos select 1)  + 2.33984 *cos(-_direction) -2.39185*sin(-_direction)), (_pos select 2)],_statics,_direction + 180] call btc_fnc_mil_create_static;
	[[((_pos select 0) + 2.72949*cos(-_direction) - -2.03857*sin(-_direction)), ((_pos select 1) -2.03857*cos(-_direction) +2.72949*sin(-_direction)), (_pos select 2)],_statics,_direction ] call btc_fnc_mil_create_static;
	[_pos,_direction,_btc_composition_checkpoint] call btc_fnc_create_composition;

	_boxes = _boxes + [nearestObject [_pos, _type_box]];
};

waitUntil {sleep 5; (btc_side_aborted || btc_side_failed || ({Alive _x} count _boxes == 0))};

{deletemarker _x} foreach _markers;

if (btc_side_aborted || btc_side_failed ) exitWith {
	[9,"btc_fnc_task_fail",true] spawn BIS_fnc_MP;
	btc_side_assigned = false;publicVariable "btc_side_assigned";
	{
		_x spawn {
			waitUntil {sleep 5; ({_x distance _this < 300} count playableUnits == 0)};
			deleteVehicle _this;
		};
	} forEach _boxes;
};

80 call btc_fnc_rep_change;

[9,"btc_fnc_task_set_done",true] spawn BIS_fnc_MP;

{
	_x spawn {
		waitUntil {sleep 5; ({_x distance _this < 300} count playableUnits == 0)};
		deleteVehicle _this;
	};
} forEach _boxes;

btc_side_assigned = false;publicVariable "btc_side_assigned";