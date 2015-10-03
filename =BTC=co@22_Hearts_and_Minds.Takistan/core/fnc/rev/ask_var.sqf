
_target = player;
_asker  = _this select 0;

//_isUnc = _target getVariable ["btc_rev_isUnc",false];
_isBusy = _target getVariable ["btc_int_busy",false];
_isDragging = _target getVariable ["btc_rev_isDragging",false];
_bleed = _target getVariable ["btc_rev_bleed",0];
_bloss = _target getVariable ["btc_rev_bloss",0];
_pain = _target getVariable ["btc_rev_pain",0];
_mor = _target getVariable ["btc_rev_mor",0];

_data = [_target,/*_isUnc,*/_isBusy,_isDragging,_bleed,_bloss,_pain,_mor];
[[player, _data],"btc_fnc_rev_ans_var",_asker,false] spawn BIS_fnc_MP;