_text = format ["%1 ",name _this];
//unc
_isUnc = _this getVariable ["btc_rev_isUnc",false];
if (_isUnc) then {_text = _text + "is unconscious.";} else {_text = _text + "is awake.";};
_text = _text + "<br/>";
//bleed
_bleed = _this getVariable ["btc_rev_bleed",0];
switch (true) do
{
	case (_bleed <= 0) : {_text = _text + "He's not bleeding.";};
	case (_bleed < 0.5 && {_bleed > 0}) : {_text = _text + "He's bleeding.";};
	case (_bleed >= 0.5) : {_text = _text + "He's bleeding a lot.";};
};
_text = _text + "<br/>";
//pain
_pain = _this getVariable ["btc_rev_pain",0];
switch (true) do
{
	case (_pain <= 0) : {_text = _text + "He isn't in pain.";};
	case (_pain < 0.5 && {_pain > 0}) : {_text = _text + "He is in pain.";};
	case (_pain >= 0.5) : {_text = _text + "He is in heavy pain.";};
};
_text = _text + "<br/>";
//mor
_mor = _this getVariable ["btc_rev_mor",0];
switch (true) do
{
	case (_mor <= 0) : {_text = _text + "He isn't on morphine.";};
	case (_mor > 0 && {_mor < 1.5}) : {_text = _text + "He is on morphine.";};
	case (_mor >= 1.5) : {_text = _text + "He is on some morphine.";};
};
_text = _text + "<br/>";
//bloss
_bloss = _this getVariable ["btc_rev_bloss",0];
switch (true) do
{
	case (_bloss <= 0) : {_text = _text + "He hasn't lost any blood.";};
	case (_bloss < 0.5 && {_bloss > 0}) : {_text = _text + "He has already lost some blood.";};
	case (_bloss < 0.85 && {_bloss > 0.5}) : {_text = _text + "He has lost a lot of blood.";};
	case (_bloss >= 0.85) : {_text = _text + "He has lost a lot of blood and need a transfution.";};
};

hintSilent parseText _text;
//player sideChat _text;