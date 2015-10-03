
_injured = _this;

closeDialog 0;

_veh = (nearestObjects [player, ["Air","LandVehicle"], 5]) select 0;

if (isNull _injured) exitWith {hint "Error: No unit";};
if (isNull _veh) exitWith {hint "Error: No vehicle";};

player setVariable ["btc_rev_busy",false];
player setVariable ["btc_rev_isCarrying",false];
player setVariable ["btc_rev_isDragging",false];

sleep 0.2;

[[3,_injured, _veh],"btc_fnc_code_on_local",_injured,false] spawn BIS_fnc_MP;