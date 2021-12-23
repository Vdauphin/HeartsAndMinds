
/* ----------------------------------------------------------------------------
Function: btc_fnc_patrol_addWP

Description:
    Add waypoint to the end city.

Parameters:
    _group - Group to add waypoint. [Group]
    _pos - Position of the end city. [Array]
    _waypointStatements - Code to execute on waypoint completion. [String]

Returns:

Examples:
    (begin example)
        [group cursorTarget, getPos player, "[group this, 1000, [0, 0, 0], [0, 1, 2], false] call btc_fnc_patrol_WPCheck;"] call btc_fnc_patrol_addWP;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_group", grpNull, [grpNull]],
    ["_pos", [0, 0, 0], [[]]],
    ["_waypointStatements", "", [""]]
];

if (isNull _group) exitWith {
    [format ["_group isNull %1, waypointStatements = %2 ", isNull _group, _waypointStatements], __FILE__] call btc_fnc_debug_message;
};

private _vehicle = vehicle leader _group;
if (_vehicle isKindOf "Air" || _vehicle isKindOf "LandVehicle") then {
    _vehicle setFuel 1;
};

[_group] call CBA_fnc_clearWaypoints;
private _behaviorMode = "SAFE";
private _combatMode = "RED";
if (side _group isEqualTo civilian) then {
    _behaviorMode = "CARELESS";
    _combatMode = "BLUE";
};

if (_vehicle isKindOf "Air") then {
    [_group, _pos, -1, "MOVE", _behaviorMode, _combatMode, "LIMITED", "STAG COLUMN", _waypointStatements, [0, 0, 0], 20] call CBA_fnc_addWaypoint;
} else {
    private _roadBlackList = [];

    // Function 2
    if (isNull [_pos getPos [100, random 360], 100]) then {
        private _newPos = [_pos getPos [100, random 360], 100];
        if (!isTerrainSurfaceTypeWater) then {
            if (isTerrainSurfaceTypeRoad) then {
                private _nearestRoad = [[_pos getPos [100, random 360], 100] nearestObject];

                // Function 3: Add to Black List of Roads for the next Waypoint.  This prevents the AI from going back and forth on roads.  It also prevents them from getting stuck in a road loop.  If they are stuck in a road loop they will eventually wander off their path and start wandering around randomly like normal infantry.  This is not ideal but it's better than being stuck on a road that leads nowhere!
                if (isNull _nearestRoad) then {
                    _roadBlackList pushBackUnique [_pos getPos [100, random 360], 100];
                } else {
                    _roadBlackList pushBackUnique _nearestRoad;
                };

            } else {
                private _newPos = [[_pos getPos [100, random 360], 100] nearestObject];

            };

        };

    // Function 4: If the AI is stuck on a road or in water they will wander off their path and start wandering around randomly like normal infantry.  This is not ideal but it's better than being stuck on a road that leads nowhere!
    } else if (isTerrainSurfaceTypeWater) then {
        private _newPos = [[_pos getPos [100, random 360], 100] nearestObject];

    // Function 5: If the AI is stuck on a road or in water they will wander off their path and start wandering around randomly like normal infantry.  This is not ideal but it's better than being stuck on a road that leads nowhere!    
    } else if (!isTerrainSurfaceTypeWater && !isTerrainSurfaceTypeRoad) then {
        private _newPos = [[_pos getPos [100, random 360], 100] nearestObject];

    } else {
        private _newPos = [_pos getPos [100, random 360], 100];
    };

    // Function 6: Add the new position to the black list of roads for the next Waypoint.  This prevents the AI from going back and forth on roads.  It also prevents them from getting stuck in a road loop.  If they are stuck in a road loop they will eventually wander off their path and start wandering around randomly like normal infantry.  This is not ideal but it's better than being stuck on a road that leads nowhere!
    if (!isNull _newPos) then {
        if (isTerrainSurfaceTypeRoad) then {
            private _nearestRoad = [[_pos getPos [100, random 360], 100] nearestObject];

            if (isNull _nearestRoad) then {
                _roadBlackList pushBackUnique [_pos getPos [100, random 360], 100];
            } else {
                _roadBlackList pushBackUnique _nearestRoad;
            };

        };

    };

    // Function 7: Add waypoints to move around obstacles or other units blocking the path of the AI group.  The more waypoints added here, the more accurate the AI will be able to navigate around obstacles.
    for "_i" from 0 to (2 + (floor random 3)) do {
        private _nearestRoad = [_pos getPos [100, random 360], 100, _roadBlackList] call BIS_fnc_nearestRoad;

        if (isNull _nearestRoad) then {
            private _newPos = [_pos getPos [100, random 360], 100];

        } else {
            private _roadBlackList pushBackUnique _nearestRoad;
            private _newPos = _nearestRoad;
        };

        // Function 8: Add waypoints to move around obstacles or other units blocking the path of the AI group.  The more waypoints added here, the more accurate the AI will be able to navigate around obstacles.  This is not ideal but it's better than being stuck on a road that leads nowhere!    
        if (!isTerrainSurfaceTypeWater && !isTerrainSurfaceTypeRoad) then {
            private _newPos = [[_pos getPos [100, random 360], 100] nearestObject];

        };

        [_group, _newPos, -1, "MOVE", "UNCHANGED", "NO CHANGE", "UNCHANGED", "NO CHANGE", _waypointStatements, [0, 0, 0], 20] call CBA_fnc_addWaypoint;
    };

    // Function 9: Add the final waypoint to move back to the original position.  This is important because if the AI group doesn't have a waypoint at their current position then they will wander off their path and start wandering around randomly like normal infantry.  This is not ideal but it's better than being stuck on a road that leads nowhere!
    [_group, _pos, -1, "MOVE", _behaviorMode, _combatMode, "LIMITED", "STAG COLUMN", _waypointStatements, [0, 0, 0], 50] call CBA_fnc_addWaypoint;
};

if (btc_debug) then {
    if (!isNil {_group getVariable "btc_patrol_id"}) then {
        private _patrol_id = _group getVariable ["btc_patrol_id", 0];
        private _marker = createMarker [format ["Patrol_fant_%1", _patrol_id], [(_pos select 0) + random 30, (_pos select 1) + random 30, 0]];
        _marker setMarkerType "mil_dot";
        _marker setMarkerText format ["P %1", _patrol_id];
        _marker setMarkerColor (["ColorWhite", "ColorRed"] select (_patrol_id > 0));
        _marker setMarkerSize [0.5, 0.5];
    };
};
