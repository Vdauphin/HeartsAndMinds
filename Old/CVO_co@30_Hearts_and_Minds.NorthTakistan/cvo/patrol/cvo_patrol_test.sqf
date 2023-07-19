result = [];
_array = btc_city_all; 
 
 
for "_i" from 0 to (count _array -1) do {
	_iteration = _array select _i; 
	_town = [];

	if (isNull _iteration) then {continue};
	if (_iteration getVariable ["occupied", false]) then {continue}; 

	_discon = [_iteration] call cvo_side_fnc_distanceCondition;
	if (!_discon) then {continue};

	_town pushBack _iteration;
	_town pushBack ( getPos _iteration);
	_town pushback ( (getPos _iteration) distance (getPos cvo_patrol_helipad) ); 
	_town pushBack (_iteration getVariable ["name", false]); 
	_town pushBack (_iteration getVariable ["occupied", false]);
	_town pushback (_discon);
	result pushBack _town; 
};


[
[1171667: empty.p3d,[13964.5,17903.1,0],"KalaenoowiHospital",false],
[1171669: empty.p3d,[11278,2877.98,1.90735e-006],"Kinduf",false],
[1171671: empty.p3d,[15920.4,3012.99,0],"Orfar",false],
[1171679: empty.p3d,[1353.61,14253.3,0],"Mayankel",false],
[1171681: empty.p3d,[20092,6252.23,0],"Yemara",false],
[1171687: empty.p3d,[19071.6,10494.8,0],"Anyakar",false],
[1171689: empty.p3d,[14228.2,518.821,0],"PuestoMate",false],
[1171691: empty.p3d,[17755.3,17915,0],"Kamir",false],
[1171693: empty.p3d,[19834.4,19895.3,0],"Morar",false],
[1171699: empty.p3d,[11443.1,6525.97,0],"Orcarif",false],
[1171701: empty.p3d,[9863.6,384.169,0],"Zagun",false],
[1171703: empty.p3d,[3757.01,498.684,0],"MozaratDeath",false],
[1171709: empty.p3d,[13750.5,9331.58,0],"PuestoCrow",false],
[1171711: empty.p3d,[10649,10200.7,0],"Limari",false],
[1171713: empty.p3d,[2228.53,17301,0],"IbanRiverbed",false],
[1171721: empty.p3d,[17215.9,11309.1,0],"ZekoValley",false],
[1171729: empty.p3d,[18450.3,7840.08,0],"YerayRiver",false],
[1171731: empty.p3d,[19266.7,1531.75,0],"RommellCaves",false],
[1171733: empty.p3d,[19213,995.223,0],"DigurValley",false],
[1171737: empty.p3d,[5194.27,10304.8,0],"Mafaraz",false],
[1171741: empty.p3d,[10961.5,7538.25,0],"GreenCampBase",false],
[1171745: empty.p3d,[15825.9,5649.04,1.90735e-006],"FabianoCampBase",false],
[1171747: empty.p3d,[14007.9,3424.07,1.90735e-006],"IbanCampBase",false],
[1171749: empty.p3d,[8105.99,16550.7,0],"Kandar",false],
[1171755: empty.p3d,[12616,15188.6,0],"Ramir",false],
[1171757: empty.p3d,[7771.74,19272.1,0],"Doran",false],
[1171761: empty.p3d,[6768.79,2610.34,0],"Benamair",false],
[1171771: empty.p3d,[19267.6,3362.29,0],"Teruk",false],
[1171773: empty.p3d,[15049.4,532.488,3.8147e-006],"KindufFactory",false],
[1171781: empty.p3d,[8051.66,12977.8,0],"Kunara",false],
[1171783: empty.p3d,[3812.69,17822.4,0],"MartinFob",false]
]

[[1171672: empty.p3d,[11039.7,20261.7,6.10352e-005],2574.6,"Alfaraz",false,true]
,[1171722: empty.p3d,[7771.74,19272.1,0],4555.99,"Doran",false,true]
,[1171746: empty.p3d,[8051.66,12977.8,0],6384.78,"Kunara",false,true]]