_idc = _this select 0;
_cond = _this select 1;

_ui = uiNamespace getVariable "btc_gear_dlg";
(_ui displayCtrl _idc) ctrlShow _cond;