private "_obj";
_obj = _this createVehicle [getpos btc_create_object_point select 0,getpos btc_create_object_point select 1,0];
btc_log_obj_created = btc_log_obj_created + [_obj];
btc_curator addCuratorEditableObjects [[_obj], false];