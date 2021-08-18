
[] call compile preprocessFileLineNumbers "\userconfig\Permissions\UIDLIST.hpp";
// Permissions Handler


Player addEventHandler ["GetInMan", {
    params ["_unit", "_role", "_vehicle", "_turret"];
    private _ID = getPlayerUID _unit;
    if (_vehicle isKindOf "Helicopter" && {assignedVehicleRole _unit in [['driver'], ['turret', [0]]]}) then {
        if !(_ID in ROTARY_PERMS) then  {["You don't have permission to operate this vehicle"] spawn BIS_fnc_guiMessage;moveOut _unit;};
    };
    if (_vehicle isKindOf "Plane" && {assignedVehicleRole _unit in [['driver'], ['turret', [0]]]}) then {
        if !(_ID in FIXEDWING_PERMS) then  {["You don't have permission to operate this vehicle"] spawn BIS_fnc_guiMessage;moveOut _unit;};
    };
    if (_vehicle isKindOf "Tank" && {assignedVehicleRole _unit in [['driver'], ['turret', [0]]]}) then {
        if !(_ID in TANK_PERMS) then  {["You don't have permission to operate this vehicle"] spawn BIS_fnc_guiMessage;moveOut _unit;};
    };
}];


/*
To create a custom permission, choose or create a UID list from the permissions UID variables above,
then use the bellow code to add a new section to the "GetInMan" Event handler:
    if (_vehicle isKindOf "VEHICLECLASSNAMEHERE" && {assignedVehicleRole _unit in [ROLESFROMABOVEDEBUGHERE]}) then {
        if !(_ID in PERMISSIONLISTHERE) then  {["KICKMESSAGEHERE"] spawn BIS_fnc_guiMessage;moveOut _unit;};
    };
UID list can be created in this file or externally using precompile code:

Use :
_RoleArray = assignedVehicleRole player;
hint format ["%1",_RoleArray]
In debug to find the slot for assignedVehicleRole
*/
