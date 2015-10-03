
_item = lbData [372, lbCurSel 372];

switch (btc_gear_acc_type) do
{
	case 0 : {player addPrimaryWeaponItem _item;};
	case 1 : {player addSecondaryWeaponItem _item;};
	case 2 : {player addHandGunItem _item;};
};

