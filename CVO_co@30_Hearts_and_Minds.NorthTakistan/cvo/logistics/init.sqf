[ missionNamespace, "HAM_EH_Init_Object",
    {
        params ["_object"];

        [_object] call cvo_logistics_fnc_initCreatedObject;
    }
] call BIS_fnc_addScriptedEventHandler;
