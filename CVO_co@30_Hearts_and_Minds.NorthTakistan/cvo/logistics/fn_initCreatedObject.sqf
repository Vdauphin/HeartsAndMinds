/*
    Author: Skippie

    Description:
        Initializes an object with CVO logistics actions.

    Parameter(s):
        0: OBJECT - object that will be initialized


    Returns:
        NOTHING

    Examples:
        [cursorObject] call cvo_logistics_fnc_initCreatedObject;
*/

params ["_object"];

if (!((typeOf _object) isKindOf "Static")) then {
    private _action = [
        "CVO_Logistics_Action",
        localize "STR_BTC_HAM_ACTION_LOC_MAIN",
        "\A3\ui_f\data\igui\cfg\simpleTasks\letters\L_ca.paa",
        {},
        { 
    		params ["_cargo"];
            (isNull isVehicleCargo _cargo) &&
            (count nearestObjects [_cargo, ["Car", "Truck"], 10, true] > 0)
    	}
    ] call ace_interact_menu_fnc_createAction;
    [_object, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

    _action = [
        "CVO_Logistics_LoadInCargo_Action",
        "Load in cargo",
        "",
        {
        	params ["_cargo"];

        	[_cargo, nearestObjects [_cargo, ["Car", "Truck"], 10, true] select 0] call cvo_logistics_fnc_loadInCargo;
        },
        { 
    		params ["_cargo"];

    		(isNull isVehicleCargo _cargo) &&
            (count nearestObjects [_cargo, ["Car", "Truck"], 10, true] > 0)
        },
        {
            params ["_cargo"];

            [nearestObjects [_cargo, ["Car", "Truck"], 10, true], {
                params ["_target", "_player", "_vehicle"];

                [_target, _vehicle] call cvo_logistics_fnc_loadInCargo;
            }, _cargo] call ace_interact_menu_fnc_createVehiclesActions;
        },
        [_object]
    ] call ace_interact_menu_fnc_createAction;
    [_object, 0, ["ACE_MainActions", "CVO_Logistics_Action"], _action] call ace_interact_menu_fnc_addActionToObject;
};

["CVO Logistics: object %1 has been initialized", str _object] call BIS_fnc_logFormat;
