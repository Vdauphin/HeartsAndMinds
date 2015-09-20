_obj = _this select 0;
_var = _this select 1;
_value = _this select 2;

if (_var == "tow") then 
{
_obj setVariable [_var,_value, true];
}
else 
{
_obj setVariable [_var,_value,false];
};
