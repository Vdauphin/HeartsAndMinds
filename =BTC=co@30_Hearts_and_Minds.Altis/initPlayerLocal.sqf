setCurrentChannel 3;

//[] execVM "scripts\whitelist_test.sqf";
[] execVM "scripts\heli.sqf";
//[] execVM "uid.sqf"
[] execVM "scripts\whitelist.sqf";
[] execVM "scripts\tscheck.sqf";


#define SAFETY_ZONES [["RUSFOR", 50],["RESPAWN_Guer",50],["respawn_east",50]]//["NATO", 50] 50为限制开火范围
#define MESSAGE "基地内禁止开火"
#define MESSAGE2 "你不能使用这种武器"

if (isDedicated) exitWith {};
waitUntil {!isNull player};

//安全区
player addEventHandler ["Fired", {
    if ({(_this select 0) distance getMarkerPos (_x select 0) < _x select 1} count SAFETY_ZONES > 0) then
    {
        deleteVehicle (_this select 6);
        titleText [MESSAGE, "PLAIN", 3];
    };
}];

