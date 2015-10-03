_n = _this select 0;

_array = ["N","E","W","S","NW","NE","SE","SW"];

_card = "";

switch (true) do
{
	case (_n > 345 || _n <= 15) : {_card = "N";};
	case (_n > 15 && _n <= 75) : {_card = "NE";};
	case (_n > 75 && _n <= 105) : {_card = "E";};
	case (_n > 105 && _n <= 165) : {_card = "SE";};
	case (_n > 165 && _n <= 195) : {_card = "S";};
	case (_n > 195 && _n <= 255) : {_card = "SW";};
	case (_n > 255 && _n <= 285) : {_card = "W";};
	case (_n > 285 && _n <= 345) : {_card = "NW";};
};
_card