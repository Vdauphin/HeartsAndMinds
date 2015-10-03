btc_rev_fx_effect_pain = true;
_bleed = player getVariable "btc_rev_pain";

"chromAberration" ppEffectEnable true;
while {player getVariable "btc_rev_pain" > 0} do 
{
	_strength = player getVariable "btc_rev_pain";
    "chromAberration" ppEffectAdjust [(_strength / 100), (_strength / 100), false];
    "chromAberration" ppEffectCommit 1;
    sleep (3 - _strength);
    "chromAberration" ppEffectAdjust [(_strength / 100) + (_strength / 10), (_strength / 100) + (_strength / 10), false];
    "chromAberration" ppEffectCommit 1;
    sleep 0.35;
};
"chromAberration" ppEffectEnable false;
btc_rev_fx_effect_pain = false;