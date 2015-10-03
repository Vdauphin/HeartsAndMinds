if (btc_debug_log) then {diag_log format ["IED BOOM %1 - POS %2",_this,getPos _this]};
_pos = getPos _this;
deleteVehicle _this;
"Bo_GBU12_LGB_MI10" createVehicle _pos;
playSound3d["A3\Missions_F_EPA\data\sounds\combat_deafness.wss", objNull, false, _pos, 1, 1];