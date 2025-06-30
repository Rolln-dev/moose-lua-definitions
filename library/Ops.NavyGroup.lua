---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/OPS_NavyGroup.png" width="100%">
---
---**Ops** - Enhanced Naval Group.
---
---## Main Features:
---
---   * Let the group steam into the wind
---   * Command a full stop
---   * Patrol waypoints *ad infinitum*
---   * Collision warning, if group is heading towards a land mass or another obstacle
---   * Automatic pathfinding, e.g. around islands
---   * Let a submarine dive and surface
---   * Manage TACAN and ICLS beacons
---   * Dynamically add and remove waypoints
---   * Sophisticated task queueing system (know when DCS tasks start and end)
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
---Demo missions can be found on [GitHub](https://github.com/FlightControl-Master/MOOSE_MISSIONS/tree/develop/Ops/Navygroup)
---
---===
---
---### Author: **funkyfranky**
---
---===
---*Something must be left to chance; nothing is sure in a sea fight above all.* -- Horatio Nelson
---
---===
---
---# The NAVYGROUP Concept
---
---This class enhances naval groups.
---NAVYGROUP class.
---@class NAVYGROUP : OPSGROUP
---@field adinfinitum boolean 
---@field altWp  
---@field ammo  
---@field collisionwarning boolean If true, collition warning.
---@field depth number Ordered depth in meters.
---@field groupinitialized boolean 
---@field icls  
---@field intowindcounter number Counter of into wind IDs.
---@field intowindold boolean Use old calculation to determine heading into wind.
---@field isAI boolean 
---@field isDead boolean 
---@field isDestroyed boolean 
---@field isLateActivated  
---@field isMobile boolean 
---@field isUncontrolled boolean 
---@field ispathfinding boolean If true, group is currently path finding.
---@field lid  
---@field pathCorridor number Path corrdidor width in meters.
---@field pathfindingOn boolean If true, enable pathfining.
---@field speedMax  
---@field speedWp  
---@field tacan  
---@field timerCheckZone  
---@field timerQueueUpdate  
---@field timerStatus  
---@field turning boolean If true, group is currently turning.
---@field version string NavyGroup version.
NAVYGROUP = {}

---Add a *scheduled* task.
---
------
---@param self NAVYGROUP 
---@param TargetGroup GROUP Target group.
---@param WeaponExpend number How much weapons does are used.
---@param WeaponType number Type of weapon. Default auto.
---@param Clock string Time when to start the attack.
---@param Prio number Priority of the task.
---@return OPSGROUP.Task #The task data.
function NAVYGROUP:AddTaskAttackGroup(TargetGroup, WeaponExpend, WeaponType, Clock, Prio) end

---Add a *scheduled* task.
---
------
---@param self NAVYGROUP 
---@param Coordinate COORDINATE Coordinate of the target.
---@param Clock string Time when to start the attack.
---@param Radius number Radius in meters. Default 100 m.
---@param Nshots number Number of shots to fire. Default 3.
---@param WeaponType number Type of weapon. Default auto.
---@param Prio number Priority of the task.
---@return OPSGROUP.Task #The task data.
function NAVYGROUP:AddTaskFireAtPoint(Coordinate, Clock, Radius, Nshots, WeaponType, Prio) end

---Add a *waypoint* task.
---
------
---@param self NAVYGROUP 
---@param Coordinate COORDINATE Coordinate of the target.
---@param Waypoint OPSGROUP.Waypoint Where the task is executed. Default is next waypoint.
---@param Radius number Radius in meters. Default 100 m.
---@param Nshots number Number of shots to fire. Default 3.
---@param WeaponType number Type of weapon. Default auto.
---@param Prio number Priority of the task.
---@param Duration number Duration in seconds after which the task is cancelled. Default *never*.
---@return OPSGROUP.Task #The task table.
function NAVYGROUP:AddTaskWaypointFireAtPoint(Coordinate, Waypoint, Radius, Nshots, WeaponType, Prio, Duration) end

---Add a time window, where the groups steams into the wind.
---
------
---@param self NAVYGROUP 
---@param starttime string Start time, e.g. "8:00" for eight o'clock. Default now.
---@param stoptime string Stop time, e.g. "9:00" for nine o'clock. Default 90 minutes after start time.
---@param speed number Wind speed on deck in knots during turn into wind leg. Default 20 knots.
---@param uturn boolean If `true` (or `nil`), carrier wil perform a U-turn and go back to where it came from before resuming its route to the next waypoint. If false, it will go directly to the next waypoint.
---@param offset number Offset angle clock-wise in degrees, *e.g.* to account for an angled runway. Default 0 deg. Use around -9.1° for US carriers.
---@return NAVYGROUP.IntoWind #Turn into window data table.
function NAVYGROUP:AddTurnIntoWind(starttime, stoptime, speed, uturn, offset) end

---Add an a waypoint to the route.
---
------
---@param self NAVYGROUP 
---@param Coordinate COORDINATE The coordinate of the waypoint. Use `COORDINATE:SetAltitude()` to define the altitude.
---@param Speed number Speed in knots. Default is default cruise speed or 70% of max speed.
---@param AfterWaypointWithID number Insert waypoint after waypoint given ID. Default is to insert as last waypoint.
---@param Depth number Depth at waypoint in feet. Only for submarines.
---@param Updateroute boolean If true or nil, call UpdateRoute. If false, no call.
---@return OPSGROUP.Waypoint #Waypoint table.
function NAVYGROUP:AddWaypoint(Coordinate, Speed, AfterWaypointWithID, Depth, Updateroute) end

---Triggers the FSM event "ClearAhead".
---
------
---@param self NAVYGROUP 
function NAVYGROUP:ClearAhead() end

---Triggers the FSM event "CollisionWarning".
---
------
---@param self NAVYGROUP 
function NAVYGROUP:CollisionWarning() end

---Triggers the FSM event "Cruise".
---
------
---@param self NAVYGROUP 
---@param Speed number Speed in knots until next waypoint is reached.
function NAVYGROUP:Cruise(Speed) end

---Triggers the FSM event "Dive".
---
------
---@param self NAVYGROUP 
---@param Depth number Dive depth in meters. Default 50 meters.
---@param Speed number Speed in knots until next waypoint is reached.
function NAVYGROUP:Dive(Depth, Speed) end

---Extend duration of turn into wind.
---
------
---@param self NAVYGROUP 
---@param Duration number Duration in seconds. Default 300 sec.
---@param TurnIntoWind NAVYGROUP.IntoWind (Optional) Turn into window data table. If not given, the currently open one is used (if there is any).
---@return NAVYGROUP #self
function NAVYGROUP:ExtendTurnIntoWind(Duration, TurnIntoWind) end

---Get heading of group into the wind.
---This minimizes the cross wind for an angled runway.
---Implementation based on [Mags & Bami](https://magwo.github.io/carrier-cruise/) work.
---
------
---@param self NAVYGROUP 
---@param Offset number Offset angle in degrees, e.g. to account for an angled runway.
---@param vdeck number Desired wind speed on deck in Knots.
---@return number #Carrier heading in degrees.
---@return number #Carrier speed in knots.
function NAVYGROUP:GetHeadingIntoWind(Offset, vdeck) end

---Get heading of group into the wind.
---This minimizes the cross wind for an angled runway.
---Implementation based on [Mags & Bami](https://magwo.github.io/carrier-cruise/) work.
---
------
---@param self NAVYGROUP 
---@param Offset number Offset angle in degrees, e.g. to account for an angled runway.
---@param vdeck number Desired wind speed on deck in Knots.
---@return number #Carrier heading in degrees.
---@return number #Carrier speed in knots.
function NAVYGROUP:GetHeadingIntoWind_new(Offset, vdeck) end

---Get heading of group into the wind.
---
------
---@param self NAVYGROUP 
---@param Offset number Offset angle in degrees, e.g. to account for an angled runway.
---@param vdeck number Desired wind speed on deck in Knots.
---@return number #Carrier heading in degrees.
---@return number #Carrier speed in knots.
function NAVYGROUP:GetHeadingIntoWind_old(Offset, vdeck) end

---Get "Turn Into Wind" data.
---You can specify a certain ID.
---
------
---@param self NAVYGROUP 
---@param TID number (Optional) Turn Into wind ID. If not given, the currently open "Turn into Wind" data is return (if there is any).
---@return NAVYGROUP.IntoWind #Turn into window data table.
function NAVYGROUP:GetTurnIntoWind(TID) end

---Get the turn into wind window, which is currently open.
---
------
---@param self NAVYGROUP 
---@return NAVYGROUP.IntoWind #Current into wind data. Could be `nil` if there is no window currenly open.
function NAVYGROUP:GetTurnIntoWindCurrent() end

---Get the next turn into wind window, which is not yet running.
---
------
---@param self NAVYGROUP 
---@return NAVYGROUP.IntoWind #Next into wind data. Could be `nil` if there is not next window.
function NAVYGROUP:GetTurnIntoWindNext() end

---Get wind direction and speed at current position.
---
------
---@param self NAVYGROUP 
---@param Altitude number Altitude in meters above main sea level at which the wind is calculated. Default 18 meters.
---@return number #Direction the wind is blowing **from** in degrees.
---@return number #Wind speed in m/s.
function NAVYGROUP:GetWind(Altitude) end

---Check if the group is currently cruising.
---
------
---@param self NAVYGROUP 
---@return boolean #If true, group cruising.
function NAVYGROUP:IsCruising() end

---Check if the group is currently diving.
---
------
---@param self NAVYGROUP 
---@return boolean #If true, group is currently diving.
function NAVYGROUP:IsDiving() end

---Check if the group is currently holding its positon.
---
------
---@param self NAVYGROUP 
---@return boolean #If true, group was ordered to hold.
function NAVYGROUP:IsHolding() end

---Check if the group is currently launching aircraft.
---
------
---@param self NAVYGROUP 
---@return boolean #If true, group is currently launching.
function NAVYGROUP:IsLaunching() end

---Check if the group is currently on a detour.
---
------
---@param self NAVYGROUP 
---@return boolean #If true, group is on a detour
function NAVYGROUP:IsOnDetour() end

---Check if the group is currently recovering aircraft.
---
------
---@param self NAVYGROUP 
---@return boolean #If true, group is currently recovering.
function NAVYGROUP:IsRecovering() end

---Check if the group is currently steaming into the wind.
---
------
---@param self NAVYGROUP 
---@return boolean #If true, group is currently steaming into the wind.
function NAVYGROUP:IsSteamingIntoWind() end

---Check if the group is currently turning.
---
------
---@param self NAVYGROUP 
---@return boolean #If true, group is currently turning.
function NAVYGROUP:IsTurning() end

---Create a new NAVYGROUP class object.
---
------
---@param self NAVYGROUP 
---@param group GROUP The group object. Can also be given by its group name as `#string`.
---@return NAVYGROUP #self
function NAVYGROUP:New(group) end

---On after "ClearAhead" event.
---
------
---@param self NAVYGROUP 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function NAVYGROUP:OnAfterClearAhead(From, Event, To) end

---On after "CollisionWarning" event.
---
------
---@param self NAVYGROUP 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function NAVYGROUP:OnAfterCollisionWarning(From, Event, To) end

---On after "Cruise" event.
---
------
---@param self NAVYGROUP 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Speed number Speed in knots until next waypoint is reached.
function NAVYGROUP:OnAfterCruise(From, Event, To, Speed) end

---On after "Dive" event.
---
------
---@param self NAVYGROUP 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Depth number Dive depth in meters. Default 50 meters.
---@param Speed number Speed in knots until next waypoint is reached.
function NAVYGROUP:OnAfterDive(From, Event, To, Depth, Speed) end

---On after "Surface" event.
---
------
---@param self NAVYGROUP 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Speed number Speed in knots until next waypoint is reached.
function NAVYGROUP:OnAfterSurface(From, Event, To, Speed) end

---On after "TurnIntoWind" event.
---
------
---@param self NAVYGROUP 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Into NAVYGROUP.IntoWind wind parameters.
function NAVYGROUP:OnAfterTurnIntoWind(From, Event, To, Into) end

---On after "TurnIntoWindOver" event.
---
------
---@param self NAVYGROUP 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param IntoWindData NAVYGROUP.IntoWind Data table.
function NAVYGROUP:OnAfterTurnIntoWindOver(From, Event, To, IntoWindData) end

---On after "TurnIntoWindStop" event.
---
------
---@param self NAVYGROUP 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function NAVYGROUP:OnAfterTurnIntoWindStop(From, Event, To) end

---On after "TurnedIntoWind" event.
---
------
---@param self NAVYGROUP 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function NAVYGROUP:OnAfterTurnedIntoWind(From, Event, To) end

---On after "TurningStarted" event.
---
------
---@param self NAVYGROUP 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function NAVYGROUP:OnAfterTurningStarted(From, Event, To) end

---On after "TurningStopped" event.
---
------
---@param self NAVYGROUP 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function NAVYGROUP:OnAfterTurningStopped(From, Event, To) end

---Remove steam into wind window from queue.
---If the window is currently active, it is stopped first.
---
------
---@param self NAVYGROUP 
---@param IntoWindData NAVYGROUP.IntoWind Turn into window data table.
---@return NAVYGROUP #self
function NAVYGROUP:RemoveTurnIntoWind(IntoWindData) end

---Set if old into wind calculation is used when carrier turns into the wind for a recovery.
---
------
---@param self NAVYGROUP 
---@param SwitchOn boolean If `true` or `nil`, use old into wind calculation.
---@return NAVYGROUP #self
function NAVYGROUP:SetIntoWindLegacy(SwitchOn) end

---Enable/disable pathfinding.
---
------
---@param self NAVYGROUP 
---@param Switch boolean If true, enable pathfinding.
---@param CorridorWidth number Corridor with in meters. Default 400 m.
---@return NAVYGROUP #self
function NAVYGROUP:SetPathfinding(Switch, CorridorWidth) end

---Disable pathfinding.
---
------
---@param self NAVYGROUP 
---@return NAVYGROUP #self
function NAVYGROUP:SetPathfindingOff() end

---Enable pathfinding.
---
------
---@param self NAVYGROUP 
---@param CorridorWidth number Corridor with in meters. Default 400 m.
---@return NAVYGROUP #self
function NAVYGROUP:SetPathfindingOn(CorridorWidth) end

---Group patrols ad inifintum.
---If the last waypoint is reached, it will go to waypoint one and repeat its route.
---
------
---@param self NAVYGROUP 
---@param switch boolean If true or nil, patrol until the end of time. If false, go along the waypoints once and stop.
---@return NAVYGROUP #self
function NAVYGROUP:SetPatrolAdInfinitum(switch) end

---Update status.
---
------
---@param self NAVYGROUP 
function NAVYGROUP:Status() end

---Triggers the FSM event "Surface".
---
------
---@param self NAVYGROUP 
---@param Speed number Speed in knots until next waypoint is reached.
function NAVYGROUP:Surface(Speed) end

---Triggers the FSM event "TurnIntoWind".
---
------
---@param self NAVYGROUP 
---@param Into NAVYGROUP.IntoWind wind parameters.
function NAVYGROUP:TurnIntoWind(Into) end

---Triggers the FSM event "TurnIntoWindOver".
---
------
---@param self NAVYGROUP 
---@param IntoWindData NAVYGROUP.IntoWind Data table.
function NAVYGROUP:TurnIntoWindOver(IntoWindData) end

---Triggers the FSM event "TurnIntoWindStop".
---
------
---@param self NAVYGROUP 
function NAVYGROUP:TurnIntoWindStop() end

---Triggers the FSM event "TurnedIntoWind".
---
------
---@param self NAVYGROUP 
function NAVYGROUP:TurnedIntoWind() end

---Triggers the FSM event "TurningStarted".
---
------
---@param self NAVYGROUP 
function NAVYGROUP:TurningStarted() end

---Triggers the FSM event "TurningStopped".
---
------
---@param self NAVYGROUP 
function NAVYGROUP:TurningStopped() end

---Check for possible collisions between two coordinates.
---
------
---@param self NAVYGROUP 
---@param DistanceMax number Max distance in meters ahead to check. Default 5000.
---@param dx number 
---@return number #Free distance in meters.
function NAVYGROUP:_CheckFreePath(DistanceMax, dx) end

---Check if group is turning.
---
------
---@param self NAVYGROUP 
function NAVYGROUP:_CheckTurning() end

---Check queued turns into wind.
---
------
---@param self NAVYGROUP 
function NAVYGROUP:_CheckTurnsIntoWind() end

---Create a turn into wind window.
---Note that this is not executed as it not added to the queue.
---
------
---@param self NAVYGROUP 
---@param starttime string Start time, e.g. "8:00" for eight o'clock. Default now.
---@param stoptime string Stop time, e.g. "9:00" for nine o'clock. Default 90 minutes after start time.
---@param speed number Speed in knots during turn into wind leg.
---@param uturn boolean If true (or nil), carrier wil perform a U-turn and go back to where it came from before resuming its route to the next waypoint. If false, it will go directly to the next waypoint.
---@param offset number Offset angle in degrees, e.g. to account for an angled runway. Default 0 deg.
---@return NAVYGROUP.IntoWind #Recovery window.
function NAVYGROUP:_CreateTurnIntoWind(starttime, stoptime, speed, uturn, offset) end

---Find free path to next waypoint.
---
------
---@param self NAVYGROUP 
---@return boolean #If true, a path was found.
function NAVYGROUP:_FindPathToNextWaypoint() end

---Initialize group parameters.
---Also initializes waypoints if self.waypoints is nil.
---
------
---@param self NAVYGROUP 
---@param Template table Template used to init the group. Default is `self.template`.
---@param Delay number Delay in seconds before group is initialized. Default `nil`, *i.e.* instantaneous. 
---@return NAVYGROUP #self
function NAVYGROUP:_InitGroup(Template, Delay) end

---Update engage target.
---
------
---@param self NAVYGROUP 
function NAVYGROUP:_UpdateEngageTarget() end

---Triggers the FSM event "ClearAhead" after a delay.
---
------
---@param self NAVYGROUP 
---@param delay number Delay in seconds.
function NAVYGROUP:__ClearAhead(delay) end

---Triggers the FSM event "CollisionWarning" after a delay.
---
------
---@param self NAVYGROUP 
---@param delay number Delay in seconds.
function NAVYGROUP:__CollisionWarning(delay) end

---Triggers the FSM event "Cruise" after a delay.
---
------
---@param self NAVYGROUP 
---@param delay number Delay in seconds.
---@param Speed number Speed in knots until next waypoint is reached.
function NAVYGROUP:__Cruise(delay, Speed) end

---Triggers the FSM event "Dive" after a delay.
---
------
---@param self NAVYGROUP 
---@param delay number Delay in seconds.
---@param Depth number Dive depth in meters. Default 50 meters.
---@param Speed number Speed in knots until next waypoint is reached.
function NAVYGROUP:__Dive(delay, Depth, Speed) end

---Triggers the FSM event "Surface" after a delay.
---
------
---@param self NAVYGROUP 
---@param delay number Delay in seconds.
---@param Speed number Speed in knots until next waypoint is reached.
function NAVYGROUP:__Surface(delay, Speed) end

---Triggers the FSM event "TurnIntoWind" after a delay.
---
------
---@param self NAVYGROUP 
---@param delay number Delay in seconds.
---@param Into NAVYGROUP.IntoWind wind parameters.
function NAVYGROUP:__TurnIntoWind(delay, Into) end

---Triggers the FSM event "TurnIntoWindOver" after a delay.
---
------
---@param self NAVYGROUP 
---@param delay number Delay in seconds.
---@param IntoWindData NAVYGROUP.IntoWind Data table.
function NAVYGROUP:__TurnIntoWindOver(delay, IntoWindData) end

---Triggers the FSM event "TurnIntoWindStop" after a delay.
---
------
---@param self NAVYGROUP 
---@param delay number Delay in seconds.
function NAVYGROUP:__TurnIntoWindStop(delay) end

---Triggers the FSM event "TurnedIntoWind" after a delay.
---
------
---@param self NAVYGROUP 
---@param delay number Delay in seconds.
function NAVYGROUP:__TurnedIntoWind(delay) end

---Triggers the FSM event "TurningStarted" after a delay.
---
------
---@param self NAVYGROUP 
---@param delay number Delay in seconds.
function NAVYGROUP:__TurningStarted(delay) end

---Triggers the FSM event "TurningStopped" after a delay.
---
------
---@param self NAVYGROUP 
---@param delay number Delay in seconds.
function NAVYGROUP:__TurningStopped(delay) end

---On after "CollisionWarning" event.
---
------
---@param self NAVYGROUP 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Distance number Distance in meters where obstacle was detected.
function NAVYGROUP:onafterCollisionWarning(From, Event, To, Distance) end

---On after "Cruise" event.
---
------
---@param self NAVYGROUP 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Speed number Speed in knots until next waypoint is reached. Default is speed set for waypoint.
function NAVYGROUP:onafterCruise(From, Event, To, Speed) end

---On after "Detour" event.
---
------
---@param self NAVYGROUP 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Coordinate COORDINATE Coordinate where to go.
---@param Speed number Speed in knots. Default cruise speed.
---@param Depth number Depth in meters. Default 0 meters.
---@param ResumeRoute number If true, resume route after detour point was reached. If false, the group will stop at the detour point and wait for futher commands.
function NAVYGROUP:onafterDetour(From, Event, To, Coordinate, Speed, Depth, ResumeRoute) end

---On after "DetourReached" event.
---
------
---@param self NAVYGROUP 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function NAVYGROUP:onafterDetourReached(From, Event, To) end

---On after "Disengage" event.
---
------
---@param self NAVYGROUP 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function NAVYGROUP:onafterDisengage(From, Event, To) end

---On after "Dive" event.
---
------
---@param self NAVYGROUP 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Depth number Dive depth in meters. Default 50 meters.
---@param Speed number Speed in knots until next waypoint is reached.
function NAVYGROUP:onafterDive(From, Event, To, Depth, Speed) end

---On after "ElementSpawned" event.
---
------
---@param self NAVYGROUP 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Element OPSGROUP.Element The group element.
function NAVYGROUP:onafterElementSpawned(From, Event, To, Element) end

---On after "EngageTarget" event.
---
------
---@param self NAVYGROUP 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Group GROUP the group to be engaged.
---@param Target NOTYPE 
function NAVYGROUP:onafterEngageTarget(From, Event, To, Group, Target) end

---On after "FullStop" event.
---
------
---@param self NAVYGROUP 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function NAVYGROUP:onafterFullStop(From, Event, To) end

---On after "OutOfAmmo" event.
---
------
---@param self NAVYGROUP 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function NAVYGROUP:onafterOutOfAmmo(From, Event, To) end

---On after "RTZ" event.
---
------
---@param self NAVYGROUP 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Zone ZONE The zone to return to.
---@param Formation number Formation of the group.
function NAVYGROUP:onafterRTZ(From, Event, To, Zone, Formation) end

---On after "Returned" event.
---
------
---@param self NAVYGROUP 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function NAVYGROUP:onafterReturned(From, Event, To) end

---On after "Spawned" event.
---
------
---@param self NAVYGROUP 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function NAVYGROUP:onafterSpawned(From, Event, To) end

---On after "Surface" event.
---
------
---@param self NAVYGROUP 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Speed number Speed in knots until next waypoint is reached.
function NAVYGROUP:onafterSurface(From, Event, To, Speed) end

---On after "TurnIntoWind" event.
---
------
---@param self NAVYGROUP 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Into NAVYGROUP.IntoWind wind parameters.
---@param IntoWind NOTYPE 
function NAVYGROUP:onafterTurnIntoWind(From, Event, To, Into, IntoWind) end

---On after "TurnIntoWindOver" event.
---
------
---@param self NAVYGROUP 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param IntoWindData NAVYGROUP.IntoWind Data table.
function NAVYGROUP:onafterTurnIntoWindOver(From, Event, To, IntoWindData) end

---On after "TurnIntoWindStop" event.
---
------
---@param self NAVYGROUP 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function NAVYGROUP:onafterTurnIntoWindStop(From, Event, To) end

---On after "TurningStarted" event.
---
------
---@param self NAVYGROUP 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function NAVYGROUP:onafterTurningStarted(From, Event, To) end

---On after "TurningStarted" event.
---
------
---@param self NAVYGROUP 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function NAVYGROUP:onafterTurningStopped(From, Event, To) end

---On after "UpdateRoute" event.
---
------
---@param self NAVYGROUP 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param n number Next waypoint index. Default is the one coming after that one that has been passed last.
---@param N number Waypoint  Max waypoint index to be included in the route. Default is the final waypoint.
---@param Speed number Speed in knots to the next waypoint.
---@param Depth number Depth in meters to the next waypoint.
function NAVYGROUP:onafterUpdateRoute(From, Event, To, n, N, Speed, Depth) end

---On before "TurnIntoWindStop" event.
---
------
---@param self NAVYGROUP 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function NAVYGROUP:onbeforeTurnIntoWindStop(From, Event, To) end

---On before "UpdateRoute" event.
---
------
---@param self NAVYGROUP 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param n number Next waypoint index. Default is the one coming after that one that has been passed last.
---@param N number Waypoint  Max waypoint index to be included in the route. Default is the final waypoint.
---@param Speed number Speed in knots to the next waypoint.
---@param Depth number Depth in meters to the next waypoint.
function NAVYGROUP:onbeforeUpdateRoute(From, Event, To, n, N, Speed, Depth) end


---Turn into wind parameters.
---@class NAVYGROUP.IntoWind 
---@field Coordinate COORDINATE Coordinate where we left the route.
---@field Heading number Heading the boat will take in degrees.
---@field Id number Unique ID of the turn.
---@field Offset number Offset angle in degrees.
---@field Open boolean Currently active.
---@field Over boolean This turn is over.
---@field Recovery boolean If `true` this is a recovery window. If `false`, this is a launch window. If `nil` this is just a turn into the wind.
---@field Speed number Speed in knots.
---@field Tstart number Time to start.
---@field Tstop number Time to stop.
---@field Uturn boolean U-turn.
---@field waypoint OPSGROUP.Waypoint Turn into wind waypoint.
NAVYGROUP.IntoWind = {}


---Engage Target.
---@class NAVYGROUP.Target 
---@field Coordinate COORDINATE Last known coordinate of the target.
---@field Target TARGET The target.
---@field Waypoint OPSGROUP.Waypoint the waypoint created to go to the target.
---@field alarmstate number Alarm state backup.
---@field roe number ROE backup.
NAVYGROUP.Target = {}



