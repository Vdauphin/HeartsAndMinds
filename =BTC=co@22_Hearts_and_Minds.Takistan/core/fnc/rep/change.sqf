if (btc_debug_log) then	{diag_log format ["fnc_rep_change = GLOBAL %1 - CHANGE %2",btc_global_reputation,_this];};
btc_global_reputation = btc_global_reputation + _this;//publicVariable "btc_global_reputation";
true