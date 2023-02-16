/*

https://community.bistudio.com/wiki/nearEntities
https://community.bistudio.com/wiki/forgetTarget
https://community.bistudio.com/wiki/setCombatBehaviour
https://community.bistudio.com/wiki/AI_Behaviour
https://community.bistudio.com/wiki/setCombatMode


Input: _Group, _Waypoint

What does this function do?
Takes the group that should disengage, removes knowledge of nearby entitites, 
removes all current waypoints, 
gives a new waypoint to provided position, 
set Combat Mode Blue, Ai Behavior Careless 

Once within 100 of set waypoint,
set Combat Mode to yellow, behavior to aware.
run check-status -> end.


*/

