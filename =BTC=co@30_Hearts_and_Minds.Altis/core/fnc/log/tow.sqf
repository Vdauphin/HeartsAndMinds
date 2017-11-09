btc_fnc_log_tow = {
private _tower = _this;

btc_int_ask_data = nil;
[4,_tower,player] remoteExec ["btc_fnc_int_ask_var", 2];

waitUntil {!(isNil "btc_int_ask_data")};

if (!isNull btc_int_ask_data) exitWith {hint "This vehicle is already attached to another!"};

private _posASL = getPosASL btc_log_vehicle_selected;
private _pos = getPos btc_log_vehicle_selected;
private _bottom = abs(btc_log_vehicle_selected worldtoModel _pos select 2); //more accurate than boundingBoxReal btc_log_vehicle_selected select 0 select 2
if (_pos select 2 < -0.1) then {btc_log_vehicle_selected setpos [_posASL select 0, _posASL select 1, 0]};

private _simulation = createVehicle ["Land_Pallet_F", _pos , [], 0, "CAN_COLLIDE"];
_simulation enableSimulation false;
_simulation setPosASL _posASL;
_simulation setDir getDir btc_log_vehicle_selected;
_simulation setVectorUp vectorUp btc_log_vehicle_selected;

btc_log_vehicle_selected attachTo [_simulation, [0, 0, _bottom]];

private _model_rear_tower = ([_tower] call btc_fnc_log_hitch_points) select 1;
private _model_front_selected = ([btc_log_vehicle_selected] call btc_fnc_log_hitch_points) select 0;
private _pos_front = btc_log_vehicle_selected modelToWorld _model_front_selected;
private _pos_rear = _tower modelToWorld _model_rear_tower;
private _distance = 0.3 + (_pos_front distance _pos_rear);
_model_front_selected = _simulation worldToModel _pos_front;

ropeCreate [_tower, _model_rear_tower, _simulation, [(_model_front_selected select 0) - 0.4, _model_front_selected select 1, _model_front_selected select 2], _distance];
ropeCreate [_tower, _model_rear_tower, _simulation, [(_model_front_selected select 0) + 0.4, _model_front_selected select 1, _model_front_selected select 2], _distance];

_simulation enableSimulation true;

[_tower,"tow",btc_log_vehicle_selected] remoteExec ["btc_fnc_int_change_var", 2];
[btc_log_vehicle_selected,"tow",_tower] remoteExec ["btc_fnc_int_change_var", 2];

_tower addEventHandler ["RopeBreak", {
	(_this select 0) removeEventHandler ["RopeBreak", _thisEventHandler];
	(_this select 0) spawn btc_fnc_log_unhook;
	deleteVehicle (_this select 2);
}];};