
/* ----------------------------------------------------------------------------
Function: btc_fnc_delay_createAgent

Description:
    Create agent when all previous agents have been created. btc_delay_createagent define the time (in second) when the agent will be created.

Parameters:
    _agentType - Type of agents to create. [Array]
    _pos - Position of creation. [Array]
    _special - Agent placement special. [String]
    _city - City where the animal is created. [Object]

Returns:

Examples:
    (begin example)
        ["Sheep_random_F", getPosATL player] call btc_fnc_delay_createAgent;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

btc_delay_createUnit = btc_delay_createUnit + 0.1;

[{
    params [
        ["_agentType", "", [""]],
        ["_pos", [0, 0, 0], [[]]],
        ["_special", "CAN_COLLIDE", [""]],
        ["_city", objNull, [objNull]]
    ];

    (createAgent [_agentType, _pos, [], 0, _special]) setVariable ["btc_city", _city];

    btc_delay_createUnit = btc_delay_createUnit - 0.1;
}, _this, btc_delay_createUnit - 0.01] call CBA_fnc_waitAndExecute;
