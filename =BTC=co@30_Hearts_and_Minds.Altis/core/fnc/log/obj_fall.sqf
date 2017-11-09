
params ["_obj"];

private _pos = getPos _obj;
private _fall = createVehicle ["Box_T_NATO_WpsSpecial_F", [_pos select 0, _pos select 1, (_pos select 2) + 0.7], [], 0, "FLY"];
_fall setDir getDir _obj;
_fall setPosASL getPosASL _obj;
_fall setObjectTextureGlobal [0, ""];
_fall setObjectTextureGlobal [1, ""];
_obj attachTo [_fall,[0, 0, abs(((_obj modelToWorld [0,0,0]) select 2) - ((_fall  modelToWorld [0,0,0]) select 2))]];

sleep 0.1;

waitUntil {(Velocity _fall select 2) isEqualTo 0};

detach _obj;
deleteVehicle _fall;