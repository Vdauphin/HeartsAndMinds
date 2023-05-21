
/* ----------------------------------------------------------------------------
Function: btc_delay_fnc_createAgent

Description:
    Create agent when all previous agents have been created. btc_delay_time define the time (in second) when the agent will be created.

Parameters:
    _agentType - Type of agents to create. [Array]
    _pos - Position of creation. [Array]
    _special - Agent placement special. [String]
    _city - City where the animal is created. [Object]

Returns:

Examples:
    (begin example)
        ["Sheep_random_F", getPosATL player] call btc_delay_fnc_createAgent;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

btc_delay_time = btc_delay_time + btc_delay_agent;

[{
    btc_delay_time = btc_delay_time - btc_delay_agent;

    params [
        ["_agentType", "", [""]],
        ["_pos", [0, 0, 0], [[]]],
        ["_special", "CAN_COLLIDE", [""]],
        ["_city", objNull, [objNull]]
    ];

    private _agent = createAgent [_agentType, _pos, [], 0, _special];
    _agent setVariable ["btc_city", _city];
    _agent setDir random 360; // https://feedback.bistudio.com/T155634
}, _this, btc_delay_createUnit - 0.01] call CBA_fnc_waitAndExecute;
