#define SAFETY_ZONES [["RUSFOR", 50],["RESPAWN_Guer",50],["respawn_east",50]]  //create RUSFOR location on map
#define MESSAGE "Weapon Safe In Base"

if (isDedicated) exitWith {};
waitUntil {!isNull player};

//Safe Zone
player addEventHandler ["Fired", {
    if ({(_this select 0) distance getMarkerPos (_x select 0) < _x select 1} count SAFETY_ZONES > 0) then
    {
        deleteVehicle (_this select 6);
        titleText [MESSAGE, "PLAIN", 3];
    };
}];

