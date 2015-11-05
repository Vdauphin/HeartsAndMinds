
private ["_trigger","_array","_expl1","_expl2","_expl3","_man","_cond"];

[_this] joinSilent btc_hq;
[_this] joinSilent GrpNull;

_this call btc_fnc_rep_remove_eh;

while {(count (waypoints group _this)) > 0} do { deleteWaypoint ((waypoints group _this) select 0); };

_trigger = createTrigger["EmptyDetector",getPos _this];
_trigger setTriggerArea[5,5,0,false];
_trigger setTriggerActivation[str(btc_player_side),"PRESENT",false];
_trigger setTriggerStatements["this", "_spawn = thislist spawn btc_fnc_ied_allahu_akbar", ""]; 

_trigger attachTo [_this,[0,0,0]];

_array = getpos _this nearEntities ["SoldierWB", 30];

if (count _array == 0) exitWith {};

_expl1 = "DemoCharge_Remote_Ammo" createVehicle (position _this);
_expl1 attachTo [_this, [-0.1,0.1,0.15],"Pelvis"];
_expl1 setVectorDirAndUp [[0.5,0.5,0],[-0.5,0.5,0]];
_expl2 = "DemoCharge_Remote_Ammo" createVehicle (position _this);
_expl2 attachTo [_this, [0,0.15,0.15],"Pelvis"];
_expl2 setVectorDirAndUp [[1,0,0],[0,1,0]];
_expl3 = "DemoCharge_Remote_Ammo" createVehicle (position _this);
_expl3 attachTo [_this, [0.1,0.1,0.15],"Pelvis"];
_expl3 setVectorDirAndUp [[0.5,-0.5,0],[0.5,0.5,0]];

_man = _array select 0;

_cond = true;
(group _this) setBehaviour "CARELESS";
(group _this) setSpeedMode "FULL";

if (btc_debug_log) then {diag_log format ["btc_fnc_ied_suicider_active: _this = %1; POS %2 START LOOP",_this,getpos _this];};

while {Alive _this && _cond} do {
	_this doMove (position _man);//hint format ["MOVING %1",_man];
	//_trigger setPos getPos _this;
	if (!Alive _man || _man distance _this > 30) then
	{
		private ["_array"];
		_array = getpos _this nearEntities ["SoldierWB", 30];
		if (count _array == 0) then {_cond = false;} else {_man = _array select 0;};
	};
	sleep 0.5;
};
if (btc_debug_log) then {diag_log format ["btc_fnc_ied_suicider_active: _this = %1; POS %2 END LOOP",_this,getpos _this];};

sleep 3;

if (Alive _this) then {group _this setVariable ["suicider",true];deleteVehicle _trigger;};