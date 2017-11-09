
params ["_create_object_point"];

private _objects = nearestObjects [_create_object_point, btc_containers_mat, 3];

if (_objects isEqualTo []) exitWith {hint (localize "STR_BTC_HAM_O_COPY_NOCONTAINER")}; //No container around!

btc_int_ask_data = nil;
[9, _objects select 0, player] remoteExec ["btc_fnc_int_ask_var", 2];
waitUntil {!(isNil "btc_int_ask_data")};

btc_copy_container = +btc_int_ask_data;

hint (localize "STR_BTC_HAM_O_COPY_SUCCSESS"); //Container and cargo copied! Clear the area to paste.
