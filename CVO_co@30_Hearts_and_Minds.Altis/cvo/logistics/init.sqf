if (isServer) then {
    [ missionNamespace, "HAM_EH_Init_Object",
        {
            params ["_object"];

            [_object] remoteExec ["cvo_logistics_fnc_initCreatedObject", 0, _object];
        }
    ] call BIS_fnc_addScriptedEventHandler;
};
