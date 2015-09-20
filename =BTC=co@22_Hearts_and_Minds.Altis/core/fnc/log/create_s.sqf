_new = _this createVehicle [getpos btc_create_object_point select 0,getpos btc_create_object_point select 1,0];

if ((_this == btc_fob_mat) && (_this == btc_supplies_mat)) then 
	{
		_new setMass 2000;
	};