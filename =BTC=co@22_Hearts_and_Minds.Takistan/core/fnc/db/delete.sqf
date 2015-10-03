
profileNamespace setVariable ["btc_hm_date",nil];
profileNamespace setVariable ["btc_hm_cities",nil];
profileNamespace setVariable ["btc_hm_ho",nil];
profileNamespace setVariable ["btc_hm_ho_sel",nil];
profileNamespace setVariable ["btc_hm_cache",nil];
profileNamespace setVariable ["btc_hm_rep",nil];
profileNamespace setVariable ["btc_hm_fobs",nil];
profileNamespace setVariable ["btc_hm_vehs",nil];
profileNamespace setVariable ["btc_hm_objs",nil];
profileNamespace setVariable ["btc_hm_db",nil];

saveProfileNamespace;

[[10],"btc_fnc_show_hint"] spawn BIS_fnc_MP;