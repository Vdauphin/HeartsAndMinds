_obj = _this select 0;
btc_log_place_camera = "camera" camCreate (position _obj);
btc_log_place_camera camSetTarget _obj;
btc_log_place_camera cameraEffect ["internal", "BACK"];
btc_log_place_camera camSetPos (_obj modelToWorld [0,-6,15]);
btc_log_place_camera camCommit 0;
showCinemaBorder false;
btc_log_place_camera_created = true;