
/* ----------------------------------------------------------------------------
Function: btc_ied_fnc_boom

Description:
    Create the boom and the visual effect player side.

Parameters:
    _wreck - Simple object around the ied. [Object]
    _ied - ACE IED. [Object]

Returns:

Examples:
    (begin example)
        [wreck, ied] call btc_ied_fnc_boom;
    (end)

Author:
    Giallustio
    

---------------------------------------------------------------------------- */

params [
    ["_wreck", objNull, [objNull]],
    ["_ied", objNull, [objNull]]
];

if (btc_debug_log) then {
    [format ["%1 - POS %2", [_wreck, _ied], getPos _wreck], __FILE__, [false]] call btc_debug_fnc_message;
};

private _pos = getPos _ied;

deleteVehicle _ied;


if (btc_ied_power isEqualTo "RANDOM") then {

    _explosive = (selectRandomWeighted CVO_weightedArrayIED);

    _explosive  params [
	    ["_classname", 			"", 		        [""]],
	    ["_needSetDamage", 		false, 		        [false]],
	    ["_needDirectional", 	[false,[0,0,0]], 	[false,[]]],
	    ["_needSetVelocity", 	false, 		        [false]],
	    ["_needAltitute", 		false, 		        [false]],
	    ["_canCookOff", 		false, 		        [false]],
	    ["_doesBlurry", 		false, 		        [false]],
	    ["_doesHearing", 		false, 		        [false]],
    	["_canDelay",    	    [false,7], 	        [[false,0]]]
    ];
    private "_exo";
    private _willDelay = false;

    if (_canCookOff)            then {

            [_pos,_classname, 0.01] spawn cvo_ied_fnc_failedIED;
    
    } else {

        _exo = _classname createVehicle _pos;

        if (_canDelay#0)            then { if (random < 0.3) then {_willDelay = true;}          };

        if (_needDirectional)       then { _exo setDir round random 360;                        };
        if (_needSetVelocity#0)     then { _exo setVelocity _needSetVelocity#1;                 };
        if (_needAltitute)          then { _exo setPos (getPos _exo vectorAdd [0,0,1]);         };

        if (_needSetDamage)         then { 
            if (_willDelay)         then {
                [_exo, _canDelay#1]                         spawn cvo_ied_fnc_delay_fx;
                [{_this setDamage 1;}, [_exo], _canDelay#1]  call CBA_fnc_waitAndExecute;
            } else { _exo setDamage 1;};
        };

        if (_doesHearing)   then {
            if (_willDelay) then { 
                [{_this call btc_deaf_fnc_earringing}, [_pos], _canDelay#1] call CBA_fnc_waitAndExecute;   
            } else {
                [_pos] call btc_deaf_fnc_earringing;    
            };   
        };

        if (_doesBlurry)    then {
            if (_willDelay) then { 
                [
                    {
                        _this remoteExecCall ["btc_ied_fnc_effects", [0, -2] select isDedicated];
                    }, 
                    [_pos], 
                    _canDelay#1
                ] call CBA_fnc_waitAndExecute;   
            } else {
                [_pos] remoteExecCall ["btc_ied_fnc_effects", [0, -2] select isDedicated];    
            }   
        };
    };


} else {

    btc_ied_power createVehicle _pos;

    [_pos] call btc_deaf_fnc_earringing;
    [_pos] remoteExecCall ["btc_ied_fnc_effects", [0, -2] select isDedicated];

};



deleteVehicle _wreck;

[_pos] call btc_deaf_fnc_earringing;
[_pos] remoteExecCall ["btc_ied_fnc_effects", [0, -2] select isDedicated];

["btc_ied_boom", [_pos]] call CBA_fnc_localEvent;
