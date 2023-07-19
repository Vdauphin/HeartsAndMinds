
/* ----------------------------------------------------------------------------
Function: btc_info_fnc_path

Description:
    Show path of a patrol to set an amboush.

Parameters:
    _unit - Unit to show path. [Object]
    _endPos - End position of the group. [Array]
    _taskID - Unique ID for created markers. It is easy to get them later with: allMapMarkers select {(_x select [0, count _taskID]) isEqualTo _taskID}. [String]

Returns:
    _agent - An agent to add the "PathCalculated" event handler to. [Object]

Examples:
    (begin example)
        [group player, [0, 0, 0], "playerPath"] call btc_info_fnc_path;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_startPos", [0, 0, 0], [[]]],
    ["_endPos", [0, 0, 0], [[]]],
    ["_taskID", "btc_side", [""]],
    ["_typeVehicle", "Man", [""]],
    ["_behaviour", "safe", [""]]
];

private _parent = [configFile >> "CfgVehicles" >> _typeVehicle, true] call BIS_fnc_returnParents;
private _type = (_parent arrayIntersect ["Man", "Car", "Tank", "Wheeled_APC", "Boat", "Plane", "Helicopter"]) select 0;
private _agent = calculatePath [_type, _behaviour, _startPos, _endPos];

[_agent, "PathCalculated", {
    params ["_agent", "_path"];
    _thisArgs params [
        ["_taskID", "btc_side", [""]]
    ];

    _agent removeEventHandler ["PathCalculated", _thisId];
    _agent setVariable ["btc_path", _path];

    private _color = configName selectRandom (configProperties [configFile >> "CfgMarkerColors"]);
    private _delta = 10;
    for "_i" from 1 to (count _path) step 30 do {
        private _position = _path select (_i - 1);
        private _direction = _position getDir (_path select _i);

        private _mrk = createMarker [format ["%1_%2", _taskID, _i], _position];
        _mrk setMarkerType "hd_arrow";
        _mrk setMarkerAlpha 0.7;
        _mrk setMarkerColor _color;
        _mrk setMarkerDir _direction;

        if (btc_debug) then {
            _mrk setMarkerText format ["%1°", floor _direction];
        };
    };
    if (btc_debug) then {
        {
            private _mrk = createMarker [format ["%1_debug_%2", _taskID, _forEachIndex], _x];
            _mrk setMarkerType "mil_dot";
            _mrk setMarkerAlpha 0.3;
        } forEach _path;
    };
}, [_taskID]] call CBA_fnc_addBISEventHandler;

_agent
