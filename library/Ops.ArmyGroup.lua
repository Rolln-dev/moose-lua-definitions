---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/OPS_ArmyGroup.png" width="100%">
---
---**Ops** - Enhanced Ground Group.
---
---## Main Features:
---
---   * Patrol waypoints *ad infinitum*
---   * Easy change of ROE and alarm state, formation and other settings
---   * Dynamically add and remove waypoints
---   * Sophisticated task queueing system  (know when DCS tasks start and end)
---   * Convenient checks when the group enters or leaves a zone
---   * Detection events for new, known and lost units
---   * Simple LASER and IR-pointer setup
---   * Compatible with AUFTRAG class
---   * Many additional events that the mission designer can hook into
---
---===
---
---## Example Missions:
---
---Demo missions can be found on [GitHub](https://github.com/FlightControl-Master/MOOSE_MISSIONS/tree/develop/Ops/Armygroup).
---
---===
---
---### Author: **funkyfranky**
---
---==
---*Your soul may belong to Jesus, but your ass belongs to the marines.* -- Eugene B Sledge
---
---===
---
---# The ARMYGROUP Concept
---
---This class enhances ground groups.
---ARMYGROUP class.
---@class ARMYGROUP : OPSGROUP
---@field TsuppressAve number Bla
---@field TsuppressMax number Bla
---@field TsuppressMin number Bla
---@field private adinfinitum boolean Resume route at first waypoint when final waypoint is reached.
---@field private ammo NOTYPE 
---@field private engage ARMYGROUP.Target Engage target.
---@field private formationPerma boolean Formation that is used permanently and overrules waypoint formations.
---@field private groupinitialized boolean 
---@field private isAI boolean 
---@field private isDead boolean 
---@field private isDestroyed boolean 
---@field private isLateActivated NOTYPE 
---@field private isMobile boolean If true, group is mobile.
---@field private isSuppressed boolean Bla
---@field private isUncontrolled boolean 
---@field private lid NOTYPE 
---@field private retreatZones SET_ZONE Set of retreat zones.
---@field private speedMax NOTYPE 
---@field private speedWp NOTYPE 
---@field private suppressOn boolean Bla
---@field private suppressionOn boolean 
---@field private suppressionROE NOTYPE 
---@field private tacan NOTYPE 
---@field private timerCheckZone NOTYPE 
---@field private timerQueueUpdate NOTYPE 
---@field private timerStatus NOTYPE 
---@field private version string Army Group version.
ARMYGROUP = {}

---Add a zone to the retreat zone set.
---
------
---@param RetreatZone ZONE_BASE The retreat zone.
---@return ARMYGROUP #self
function ARMYGROUP:AddRetreatZone(RetreatZone) end

---Add a *scheduled* task.
---
------
---@param TargetGroup GROUP Target group.
---@param WeaponExpend number How much weapons does are used.
---@param WeaponType number Type of weapon. Default auto.
---@param Clock string Time when to start the attack.
---@param Prio number Priority of the task.
---@return OPSGROUP.Task #The task table.
function ARMYGROUP:AddTaskAttackGroup(TargetGroup, WeaponExpend, WeaponType, Clock, Prio) end

---Add a *scheduled* task to fire at a given coordinate.
---
------
---@param Clock string Time when to start the attack.
---@param Heading number Heading min in Degrees.
---@param Alpha number Shooting angle in Degrees.
---@param Altitude number Altitude in meters.
---@param Radius number Radius in meters. Default 100 m.
---@param Nshots number Number of shots to fire. Default nil.
---@param WeaponType number Type of weapon. Default auto.
---@param Prio number Priority of the task.
---@return OPSGROUP.Task #The task table.
function ARMYGROUP:AddTaskBarrage(Clock, Heading, Alpha, Altitude, Radius, Nshots, WeaponType, Prio) end

---Add a *scheduled* task to transport group(s).
---
------
---@param GroupSet SET_GROUP Set of cargo groups. Can also be a singe @{Wrapper.Group#GROUP} object.
---@param PickupZone ZONE Zone where the cargo is picked up.
---@param DeployZone ZONE Zone where the cargo is delivered to.
---@param Clock string Time when to start the attack.
---@param Prio number Priority of the task.
---@return OPSGROUP.Task #The task table.
function ARMYGROUP:AddTaskCargoGroup(GroupSet, PickupZone, DeployZone, Clock, Prio) end

---Add a *scheduled* task to fire at a given coordinate.
---
------
---@param Coordinate COORDINATE Coordinate of the target.
---@param Clock string Time when to start the attack.
---@param Radius number Radius in meters. Default 100 m.
---@param Nshots number Number of shots to fire. Default 3.
---@param WeaponType number Type of weapon. Default auto.
---@param Prio number Priority of the task.
---@return OPSGROUP.Task #The task table.
function ARMYGROUP:AddTaskFireAtPoint(Coordinate, Clock, Radius, Nshots, WeaponType, Prio) end

---Add a *waypoint* task to fire at a given coordinate.
---
------
---@param Coordinate COORDINATE Coordinate of the target.
---@param Waypoint OPSGROUP.Waypoint Where the task is executed. Default is next waypoint.
---@param Radius number Radius in meters. Default 100 m.
---@param Nshots number Number of shots to fire. Default 3.
---@param WeaponType number Type of weapon. Default auto.
---@param Prio number Priority of the task.
---@return OPSGROUP.Task #The task table.
function ARMYGROUP:AddTaskWaypointFireAtPoint(Coordinate, Waypoint, Radius, Nshots, WeaponType, Prio) end

---Add an a waypoint to the route.
---
------
---@param Coordinate COORDINATE The coordinate of the waypoint.
---@param Speed number Speed in knots. Default is default cruise speed or 70% of max speed.
---@param AfterWaypointWithID number Insert waypoint after waypoint given ID. Default is to insert as last waypoint.
---@param Formation string Formation the group will use.
---@param Updateroute boolean If true or nil, call UpdateRoute. If false, no call.
---@return OPSGROUP.Waypoint #Waypoint table.
function ARMYGROUP:AddWaypoint(Coordinate, Speed, AfterWaypointWithID, Formation, Updateroute) end

---Triggers the FSM event "Cruise".
---
------
---@param Speed number Speed in knots until next waypoint is reached.
---@param Formation number Formation.
function ARMYGROUP:Cruise(Speed, Formation) end

---Triggers the FSM event "Detour".
---
------
function ARMYGROUP:Detour() end

---Triggers the FSM event "DetourReached".
---
------
function ARMYGROUP:DetourReached() end

---Triggers the FSM event "Disengage".
---
------
function ARMYGROUP:Disengage() end

---Triggers the FSM event "EngageTarget".
---
------
---@param Target TARGET The target to be engaged. Can also be a GROUP or UNIT object.
---@param Speed number Speed in knots.
---@param Formation string Formation used in the engagement.
function ARMYGROUP:EngageTarget(Target, Speed, Formation) end

---Find the neares ammo supply group within a given radius.
---
------
---@param Radius number Search radius in NM. Default 30 NM.
---@return GROUP #Closest ammo supplying group or `nil` if no group is in the given radius.
---@return number #Distance to closest group in meters.
function ARMYGROUP:FindNearestAmmoSupply(Radius) end

---Triggers the FSM event "FullStop".
---
------
function ARMYGROUP:FullStop() end

---Get coordinate of the closest road.
---
------
---@return COORDINATE #Coordinate of a road closest to the group.
function ARMYGROUP:GetClosestRoad() end

---Get 2D distance to the closest road.
---
------
---@return number #Distance in meters to the closest road.
function ARMYGROUP:GetClosestRoadDist() end

---Check if the group is ready for combat.
---I.e. not reaming, retreating, retreated, out of ammo or engaging.
---
------
---@return boolean #If true, group is on a combat ready.
function ARMYGROUP:IsCombatReady() end

---Check if the group is currently cruising.
---
------
---@return boolean #If true, group cruising.
function ARMYGROUP:IsCruising() end

---Check if the group is currently holding its positon.
---
------
---@return boolean #If true, group was ordered to hold.
function ARMYGROUP:IsHolding() end

---Check if the group is currently on a detour.
---
------
---@return boolean #If true, group is on a detour.
function ARMYGROUP:IsOnDetour() end

---Create a new ARMYGROUP class object.
---
------
---@param group GROUP The GROUP object. Can also be given by its group name as `#string`.
---@return ARMYGROUP #self
function ARMYGROUP:New(group) end

---On after "Cruise" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Speed number Speed in knots until next waypoint is reached.
---@param Formation number Formation.
function ARMYGROUP:OnAfterCruise(From, Event, To, Speed, Formation) end

---On after "Detour" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function ARMYGROUP:OnAfterDetour(From, Event, To) end

---On after "DetourReached" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function ARMYGROUP:OnAfterDetourReached(From, Event, To) end

---On after "Disengage" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function ARMYGROUP:OnAfterDisengage(From, Event, To) end

---On after "EngageTarget" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Group GROUP the group to be engaged.
---@param Speed number Speed in knots.
---@param Formation string Formation used in the engagement.
function ARMYGROUP:OnAfterEngageTarget(From, Event, To, Group, Speed, Formation) end

---On after "FullStop" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function ARMYGROUP:OnAfterFullStop(From, Event, To) end

---On after "RTZ" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function ARMYGROUP:OnAfterRTZ(From, Event, To) end

---On after "Rearm" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Coordinate COORDINATE Coordinate where to rearm.
---@param Formation number Formation of the group.
function ARMYGROUP:OnAfterRearm(From, Event, To, Coordinate, Formation) end

---On after "Rearmed" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function ARMYGROUP:OnAfterRearmed(From, Event, To) end

---On after "Rearming" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function ARMYGROUP:OnAfterRearming(From, Event, To) end

---On after "Retreat" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Zone ZONE_BASE Zone where to retreat.
---@param Formation number Formation of the group. Can be #nil.
function ARMYGROUP:OnAfterRetreat(From, Event, To, Zone, Formation) end

---On after "Retreated" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function ARMYGROUP:OnAfterRetreated(From, Event, To) end

---On after "Returned" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function ARMYGROUP:OnAfterReturned(From, Event, To) end

---Triggers the FSM event "RTZ".
---
------
function ARMYGROUP:RTZ() end

---Triggers the FSM event "Rearm".
---
------
---@param Coordinate COORDINATE Coordinate where to rearm.
---@param Formation number Formation of the group.
function ARMYGROUP:Rearm(Coordinate, Formation) end

---Triggers the FSM event "Rearmed".
---
------
function ARMYGROUP:Rearmed() end

---Triggers the FSM event "Rearming".
---
------
function ARMYGROUP:Rearming() end

---Triggers the FSM event "Retreat".
---
------
---@param Zone? ZONE_BASE (Optional) Zone where to retreat. Default is the closest retreat zone.
---@param Formation? number (Optional) Formation of the group.
function ARMYGROUP:Retreat(Zone, Formation) end

---Triggers the FSM event "Retreated".
---
------
function ARMYGROUP:Retreated() end

---Triggers the FSM event "Returned".
---
------
function ARMYGROUP:Returned() end

---Group patrols ad inifintum.
---If the last waypoint is reached, it will go to waypoint one and repeat its route.
---
------
---@param switch boolean If true or nil, patrol until the end of time. If false, go along the waypoints once and stop.
---@return ARMYGROUP #self
function ARMYGROUP:SetPatrolAdInfinitum(switch) end

---Define a set of possible retreat zones.
---
------
---@param RetreatZoneSet SET_ZONE The retreat zone set. Default is an empty set.
---@return ARMYGROUP #self
function ARMYGROUP:SetRetreatZones(RetreatZoneSet) end

---Set suppression off.
---
------
---@return ARMYGROUP #self
function ARMYGROUP:SetSuppressionOff() end

---Set suppression on.
---average, minimum and maximum time a unit is suppressed each time it gets hit.
---
------
---@param Tave number Average time [seconds] a group will be suppressed. Default is 15 seconds.
---@param Tmin? number (Optional) Minimum time [seconds] a group will be suppressed. Default is 5 seconds.
---@param Tmax? number (Optional) Maximum time a group will be suppressed. Default is 25 seconds.
---@return ARMYGROUP #self
function ARMYGROUP:SetSuppressionOn(Tave, Tmin, Tmax) end

---Update status.
---
------
function ARMYGROUP:Status() end

---Switch to a specific formation.
---
------
---@param Formation number New formation the group will fly in. Default is the setting of `SetDefaultFormation()`.
---@param Permanently boolean If true, formation always used from now on.
---@param NoRouteUpdate boolean If true, route is not updated.
---@return ARMYGROUP #self
function ARMYGROUP:SwitchFormation(Formation, Permanently, NoRouteUpdate) end

---Initialize group parameters.
---Also initializes waypoints if self.waypoints is nil.
---
------
---@param Template table Template used to init the group. Default is `self.template`.
---@param Delay number Delay in seconds before group is initialized. Default `nil`, *i.e.* instantaneous.
---@return ARMYGROUP #self
function ARMYGROUP:_InitGroup(Template, Delay) end

---Suppress fire of the group by setting its ROE to weapon hold.
---
------
function ARMYGROUP:_Suppress() end

---Update engage target.
---
------
function ARMYGROUP:_UpdateEngageTarget() end

---Triggers the FSM event "Cruise" after a delay.
---
------
---@param delay number Delay in seconds.
---@param Speed number Speed in knots until next waypoint is reached.
---@param Formation number Formation.
function ARMYGROUP:__Cruise(delay, Speed, Formation) end

---Triggers the FSM event "Detour" after a delay.
---
------
---@param delay number Delay in seconds.
function ARMYGROUP:__Detour(delay) end

---Triggers the FSM event "DetourReached" after a delay.
---
------
---@param delay number Delay in seconds.
function ARMYGROUP:__DetourReached(delay) end

---Triggers the FSM event "Disengage" after a delay.
---
------
---@param delay number Delay in seconds.
function ARMYGROUP:__Disengage(delay) end

---Triggers the FSM event "EngageTarget" after a delay.
---
------
---@param delay number Delay in seconds.
---@param Group GROUP the group to be engaged.
---@param Speed number Speed in knots.
---@param Formation string Formation used in the engagement.
function ARMYGROUP:__EngageTarget(delay, Group, Speed, Formation) end

---Triggers the FSM event "FullStop" after a delay.
---
------
---@param delay number Delay in seconds.
function ARMYGROUP:__FullStop(delay) end

---Triggers the FSM event "RTZ" after a delay.
---
------
---@param delay number Delay in seconds.
function ARMYGROUP:__RTZ(delay) end

---Triggers the FSM event "Rearm" after a delay.
---
------
---@param delay number Delay in seconds.
---@param Coordinate COORDINATE Coordinate where to rearm.
---@param Formation number Formation of the group.
function ARMYGROUP:__Rearm(delay, Coordinate, Formation) end

---Triggers the FSM event "Rearmed" after a delay.
---
------
---@param delay number Delay in seconds.
function ARMYGROUP:__Rearmed(delay) end

---Triggers the FSM event "Rearming" after a delay.
---
------
---@param delay number Delay in seconds.
function ARMYGROUP:__Rearming(delay) end

---Triggers the FSM event "Retreat" after a delay.
---
------
---@param Zone? ZONE_BASE (Optional) Zone where to retreat. Default is the closest retreat zone.
---@param Formation? number (Optional) Formation of the group.
---@param delay number Delay in seconds.
function ARMYGROUP:__Retreat(Zone, Formation, delay) end

---Triggers the FSM event "Retreated" after a delay.
---
------
---@param delay number Delay in seconds.
function ARMYGROUP:__Retreated(delay) end

---Triggers the FSM event "Returned" after a delay.
---
------
---@param delay number Delay in seconds.
function ARMYGROUP:__Returned(delay) end

---On after "Cruise" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Speed number Speed in knots.
---@param Formation number Formation.
---@private
function ARMYGROUP:onafterCruise(From, Event, To, Speed, Formation) end

---On after "Detour" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Coordinate COORDINATE Coordinate where to go.
---@param Speed number Speed in knots. Default cruise speed.
---@param Formation number Formation of the group.
---@param ResumeRoute number If true, resume route after detour point was reached. If false, the group will stop at the detour point and wait for futher commands.
---@private
function ARMYGROUP:onafterDetour(From, Event, To, Coordinate, Speed, Formation, ResumeRoute) end

---On after "DetourReached" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function ARMYGROUP:onafterDetourReached(From, Event, To) end

---On after "Disengage" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function ARMYGROUP:onafterDisengage(From, Event, To) end

---On after "ElementSpawned" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Element OPSGROUP.Element The group element.
---@private
function ARMYGROUP:onafterElementSpawned(From, Event, To, Element) end

---On after "EngageTarget" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Target TARGET The target to be engaged. Can also be a group or unit.
---@param Speed number Attack speed in knots.
---@param Formation string Formation used in the engagement. Default `ENUMS.Formation.Vehicle.Vee`.
---@private
function ARMYGROUP:onafterEngageTarget(From, Event, To, Target, Speed, Formation) end

---On after "FullStop" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function ARMYGROUP:onafterFullStop(From, Event, To) end

---On after "GotoWaypoint" event.
---Group will got to the given waypoint and execute its route from there.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param UID number The goto waypoint unique ID.
---@param Speed? number (Optional) Speed to waypoint in knots.
---@param Formation? number (Optional) Formation to waypoint.
---@private
function ARMYGROUP:onafterGotoWaypoint(From, Event, To, UID, Speed, Formation) end

---On after "Hit" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Enemy UNIT Unit that hit the element or `nil`.
---@private
function ARMYGROUP:onafterHit(From, Event, To, Enemy) end

---On after "OutOfAmmo" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function ARMYGROUP:onafterOutOfAmmo(From, Event, To) end

---On after "RTZ" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Zone ZONE The zone to return to.
---@param Formation number Formation of the group.
---@private
function ARMYGROUP:onafterRTZ(From, Event, To, Zone, Formation) end

---On after "Rearm" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Coordinate COORDINATE Coordinate where to rearm.
---@param Formation number Formation of the group.
---@private
function ARMYGROUP:onafterRearm(From, Event, To, Coordinate, Formation) end

---On after "Rearmed" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function ARMYGROUP:onafterRearmed(From, Event, To) end

---On after "Rearming" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function ARMYGROUP:onafterRearming(From, Event, To) end

---On after "Retreat" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Zone? ZONE_BASE (Optional) Zone where to retreat. Default is the closest retreat zone.
---@param Formation? number (Optional) Formation of the group.
---@private
function ARMYGROUP:onafterRetreat(From, Event, To, Zone, Formation) end

---On after "Retreated" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function ARMYGROUP:onafterRetreated(From, Event, To) end

---On after "Returned" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function ARMYGROUP:onafterReturned(From, Event, To) end

---On after "Spawned" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function ARMYGROUP:onafterSpawned(From, Event, To) end

---After "Recovered" event.
---Group has recovered and its ROE is set back to the "normal" unsuppressed state. Optionally the group is flared green.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function ARMYGROUP:onafterUnsuppressed(From, Event, To) end

---On after "UpdateRoute" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param n number Next waypoint index. Default is the one coming after that one that has been passed last.
---@param N number Waypoint  Max waypoint index to be included in the route. Default is the final waypoint.
---@param Speed number Speed in knots. Default cruise speed.
---@param Formation number Formation of the group.
---@private
function ARMYGROUP:onafterUpdateRoute(From, Event, To, n, N, Speed, Formation) end

---On after "EngageTarget" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Group GROUP the group to be engaged.
---@param Speed number Speed in knots.
---@param Formation string Formation used in the engagement. Default `ENUMS.Formation.Vehicle.Vee`.
---@param Target NOTYPE 
---@private
function ARMYGROUP:onbeforeEngageTarget(From, Event, To, Group, Speed, Formation, Target) end

---On before "RTZ" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Zone ZONE The zone to return to.
---@param Formation number Formation of the group.
---@private
function ARMYGROUP:onbeforeRTZ(From, Event, To, Zone, Formation) end

---On before "Rearm" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Coordinate COORDINATE Coordinate where to rearm.
---@param Formation number Formation of the group.
---@private
function ARMYGROUP:onbeforeRearm(From, Event, To, Coordinate, Formation) end

---On before "Retreat" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Zone? ZONE_BASE (Optional) Zone where to retreat. Default is the closest retreat zone.
---@param Formation? number (Optional) Formation of the group.
---@private
function ARMYGROUP:onbeforeRetreat(From, Event, To, Zone, Formation) end

---Before "Recovered" event.
---Check if suppression time is over.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@return boolean #
---@private
function ARMYGROUP:onbeforeUnsuppressed(From, Event, To) end

---On before "UpdateRoute" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param n number Next waypoint index. Default is the one coming after that one that has been passed last.
---@param N number Waypoint  Max waypoint index to be included in the route. Default is the final waypoint.
---@param Speed number Speed in knots. Default cruise speed.
---@param Formation number Formation of the group.
---@private
function ARMYGROUP:onbeforeUpdateRoute(From, Event, To, n, N, Speed, Formation) end


---Engage Target.
---@class ARMYGROUP.Target 
---@field Coordinate COORDINATE Last known coordinate of the target.
---@field Formation string Formation used in the engagement.
---@field Speed number Speed in knots.
---@field Target TARGET The target.
---@field Waypoint OPSGROUP.Waypoint the waypoint created to go to the target.
---@field private alarmstate number Alarm state backup.
---@field private roe number ROE backup.
ARMYGROUP.Target = {}



