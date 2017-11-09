params [
  ["_pos", [0,0,0]],
  ["_caller", player]
];

[_pos,_caller] spawn btc_fnc_ied_effect_blurEffect;
[_pos] spawn btc_fnc_ied_effect_smoke;
[_pos] spawn btc_fnc_ied_effect_rocks;
[_pos] spawn btc_fnc_ied_effect_shock_wave;
