
/* ----------------------------------------------------------------------------
Function: btc_ied_fnc_checkLoop

Description:
    Loop over IED and check if player is around. If yes, trigger the explosion.

Parameters:
    _city - City where IED has been created. [Object]
    _ieds - All IED (even FACK IED). [Array]
    _ieds_check - Real IED triggering the explosion. [Array]

Returns:

Examples:
    (begin example)
       [_city, _ieds, _ieds_check] call btc_ied_fnc_checkLoop;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

[{
    params ["_city", "_ieds", "_ieds_check"];

    if (_city getVariable ["active", false]) exitWith {
        {
            _x params ["_wreck", "_type", "_ied"];

            if (!isNull _ied && {alive _ied}) then {
                {
                    if (side _x isEqualTo btc_player_side && {
                        (
                            _x isKindOf "UGV_02_Base_F" &&
                            {speed _x > 10}
                        ) ||
                        !(_x isKindOf "UGV_02_Base_F") && {
                            driver _x != _x ||
                            speed _x > 5
                        }
                    }) then {
                        [_wreck, _ied] call btc_ied_fnc_boom;
                        if (0.5 < random 1) then {
                            [getPos _wreck] call btc_rep_fnc_call_militia;
                        };
                    };
                } forEach (_ied nearEntities ["allVehicles", btc_ied_range]);
            } else {
                _ieds_check = _ieds_check - [_ied];
            };
        } forEach _ieds_check;
        [_city, _ieds, _ieds_check] call btc_ied_fnc_checkLoop;
    };

    private _data = [];
    {
        _x params ["_wreck", "_type", "_ied"];

        if (!isNull _wreck && {alive _wreck}) then {
            _data pushBack [getPosATL _wreck, _type, getDir _wreck, _ied isNotEqualTo objNull];

            deleteVehicle _ied;
            deleteVehicle _wreck;
        };
    } forEach _ieds;

    _city setVariable ["ieds", _data];

    if (btc_debug || btc_debug_log) then {
        [format ["END CITY ID %1", _city getVariable "id"], __FILE__, [btc_debug, btc_debug_log]] call btc_debug_fnc_message;
    };

}, _this, 1] call CBA_fnc_waitAndExecute;
