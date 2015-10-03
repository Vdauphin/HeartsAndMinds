
private ["_veh","_type","_pos","_dir","_marker"];

_veh = _this select 0;
_type = typeOf _veh;
_pos = getPos _veh;
_dir = getDir _veh;
_marker = _veh getVariable ["marker",""];

btc_vehicles = btc_vehicles - [_veh];

if (_marker != "") then {deleteMarker _marker;};
deleteVehicle _veh;
sleep 1;	
_veh  = createVehicle [_type, _pos, [], 0, "NONE"];
_veh setDir _dir;
_veh setPos _pos;
_veh setVariable ["btc_dont_delete",true];
if(getNumber(configFile >> "CfgVehicles" >> typeof _veh >> "isUav")==1) then {
	createVehicleCrew _veh;    
};

btc_vehicles = btc_vehicles + [_veh];