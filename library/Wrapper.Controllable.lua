---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Wrapper_Controllable.JPG" width="100%">
---
---**Wrapper** - CONTROLLABLE is an intermediate class wrapping Group and Unit classes "controllers".
---
---===
---
---### Author: **FlightControl**
---
---### Contributions:
---
---===
---Wrapper class to handle the "DCS Controllable objects", which are Groups and Units:
---
--- * Support all DCS Controllable APIs.
--- * Enhance with Controllable specific APIs not in the DCS Controllable API set.
--- * Handle local Controllable Controller.
--- * Manage the "state" of the DCS Controllable.
---
---# 1) CONTROLLABLE constructor
---
---The CONTROLLABLE class provides the following functions to construct a CONTROLLABLE instance:
---
--- * #CONTROLLABLE.New(): Create a CONTROLLABLE instance.
---
---# 2) CONTROLLABLE Task methods
---
---Several controllable task methods are available that help you to prepare tasks.
---These methods return a string consisting of the task description, which can then be given to either a #CONTROLLABLE.PushTask() or #CONTROLLABLE.SetTask() method to assign the task to the CONTROLLABLE.
---Tasks are specific for the category of the CONTROLLABLE, more specific, for AIR, GROUND or AIR and GROUND.
---Each task description where applicable indicates for which controllable category the task is valid.
---There are 2 main subdivisions of tasks: Assigned tasks and EnRoute tasks.
---
---## 2.1) Task assignment
---
---Assigned task methods make the controllable execute the task where the location of the (possible) targets of the task are known before being detected.
---This is different from the EnRoute tasks, where the targets of the task need to be detected before the task can be executed.
---
---Find below a list of the **assigned task** methods:
---
---  * #CONTROLLABLE.TaskAttackGroup: (AIR) Attack a Controllable.
---  * #CONTROLLABLE.TaskAttackMapObject: (AIR) Attacking the map object (building, structure, e.t.c).
---  * #CONTROLLABLE.TaskAttackUnit: (AIR) Attack the Unit.
---  * #CONTROLLABLE.TaskBombing: (AIR) Delivering weapon at the point on the ground.
---  * #CONTROLLABLE.TaskBombingRunway: (AIR) Delivering weapon on the runway.
---  * #CONTROLLABLE.TaskEmbarking: (AIR) Move the controllable to a Vec2 Point, wait for a defined duration and embark a controllable.
---  * #CONTROLLABLE.TaskEmbarkToTransport: (GROUND) Embark to a Transport landed at a location.
---  * #CONTROLLABLE.TaskEscort: (AIR) Escort another airborne controllable.
---  * #CONTROLLABLE.TaskGroundEscort: (AIR/HELO) Escort a ground controllable.
---  * #CONTROLLABLE.TaskFAC_AttackGroup: (AIR + GROUND) The task makes the controllable/unit a FAC and orders the FAC to control the target (enemy ground controllable) destruction.
---  * #CONTROLLABLE.TaskFireAtPoint: (GROUND) Fire some or all ammunition at a VEC2 point.
---  * #CONTROLLABLE.TaskFollow: (AIR) Following another airborne controllable.
---  * #CONTROLLABLE.TaskHold: (GROUND) Hold ground controllable from moving.
---  * #CONTROLLABLE.TaskHoldPosition: (AIR) Hold position at the current position of the first unit of the controllable.
---  * #CONTROLLABLE.TaskLandAtVec2: (AIR HELICOPTER) Landing at the ground. For helicopters only.
---  * #CONTROLLABLE.TaskLandAtZone: (AIR) Land the controllable at a Core.Zone#ZONE_RADIUS).
---  * @{#CONTROLLABLE.TaskOrbitCircle: (AIR) Orbit at the current position of the first unit of the controllable at a specified altitude.
---  * #CONTROLLABLE.TaskOrbitCircleAtVec2: (AIR) Orbit at a specified position at a specified altitude during a specified duration with a specified speed.
---  * #CONTROLLABLE.TaskStrafing: (AIR) Strafe a point Vec2 with onboard weapons.
---  * #CONTROLLABLE.TaskRefueling: (AIR) Refueling from the nearest tanker. No parameters.
---  * #CONTROLLABLE.TaskRecoveryTanker: (AIR) Set  group to act as recovery tanker for a naval group.
---  * #CONTROLLABLE.TaskRoute: (AIR + GROUND) Return a Mission task to follow a given route defined by Points.
---  * #CONTROLLABLE.TaskRouteToVec2: (AIR + GROUND) Make the Controllable move to a given point.
---  * #CONTROLLABLE.TaskRouteToVec3: (AIR + GROUND) Make the Controllable move to a given point.
---  * #CONTROLLABLE.TaskRouteToZone: (AIR + GROUND) Route the controllable to a given zone.
---
---## 2.2) EnRoute assignment
---
---EnRoute tasks require the targets of the task need to be detected by the controllable (using its sensors) before the task can be executed:
---
---  * #CONTROLLABLE.EnRouteTaskAWACS: (AIR) Aircraft will act as an AWACS for friendly units (will provide them with information about contacts). No parameters.
---  * #CONTROLLABLE.EnRouteTaskEngageControllable: (AIR) Engaging a controllable. The task does not assign the target controllable to the unit/controllable to attack now; it just allows the unit/controllable to engage the target controllable as well as other assigned targets.
---  * #CONTROLLABLE.EnRouteTaskEngageTargets: (AIR) Engaging targets of defined types.
---  * #CONTROLLABLE.EnRouteTaskEngageTargetsInZone: (AIR) Engaging a targets of defined types at circle-shaped zone.
---  * #CONTROLLABLE.EnRouteTaskEWR: (AIR) Attack the Unit.
---  * #CONTROLLABLE.EnRouteTaskFAC: (AIR + GROUND) The task makes the controllable/unit a FAC and lets the FAC to choose a targets (enemy ground controllable) around as well as other assigned targets.
---  * #CONTROLLABLE.EnRouteTaskFAC_EngageControllable: (AIR + GROUND) The task makes the controllable/unit a FAC and lets the FAC to choose the target (enemy ground controllable) as well as other assigned targets.
---  * #CONTROLLABLE.EnRouteTaskTanker: (AIR) Aircraft will act as a tanker for friendly units. No parameters.
---
---## 2.3) Task preparation
---
---There are certain task methods that allow to tailor the task behavior:
---
---  * #CONTROLLABLE.TaskWrappedAction: Return a WrappedAction Task taking a Command.
---  * #CONTROLLABLE.TaskCombo: Return a Combo Task taking an array of Tasks.
---  * #CONTROLLABLE.TaskCondition: Return a condition section for a controlled task.
---  * #CONTROLLABLE.TaskControlled: Return a Controlled Task taking a Task and a TaskCondition.
---
---## 2.4) Call a function as a Task
---
---A function can be called which is part of a Task. The method #CONTROLLABLE.TaskFunction() prepares
---a Task that can call a GLOBAL function from within the Controller execution.
---This method can also be used to **embed a function call when a certain waypoint has been reached**.
---See below the **Tasks at Waypoints** section.
---
---Demonstration Mission: [GRP-502 - Route at waypoint to random point](https://github.com/FlightControl-Master/MOOSE_Demos/tree/master/Wrapper/Group/502-Route-at-waypoint-to-random-point)
---
---## 2.5) Tasks at Waypoints
---
---Special Task methods are available to set tasks at certain waypoints.
---The method #CONTROLLABLE.SetTaskWaypoint() helps preparing a Route, embedding a Task at the Waypoint of the Route.
---
---This creates a Task element, with an action to call a function as part of a Wrapped Task.
---
---## 2.6) Obtain the mission from controllable templates
---
---Controllable templates contain complete mission descriptions. Sometimes you want to copy a complete mission from a controllable and assign it to another:
---
---  * #CONTROLLABLE.TaskMission: (AIR + GROUND) Return a mission task from a mission template.
---
---# 3) Command methods
---
---Controllable **command methods** prepare the execution of commands using the #CONTROLLABLE.SetCommand method:
---
---  * #CONTROLLABLE.CommandDoScript: Do Script command.
---  * #CONTROLLABLE.CommandSwitchWayPoint: Perform a switch waypoint command.
---
---# 4) Routing of Controllables
---
---Different routing methods exist to route GROUPs and UNITs to different locations:
---
---  * #CONTROLLABLE.Route(): Make the Controllable to follow a given route.
---  * #CONTROLLABLE.RouteGroundTo(): Make the GROUND Controllable to drive towards a specific coordinate.
---  * #CONTROLLABLE.RouteAirTo(): Make the AIR Controllable to fly towards a specific coordinate.
---  * #CONTROLLABLE.RelocateGroundRandomInRadius(): Relocate the GROUND controllable to a random point in a given radius.
---
---# 5) Option methods
---
---Controllable **Option methods** change the behavior of the Controllable while being alive.
---
---## 5.1) Rule of Engagement:
---
---  * #CONTROLLABLE.OptionROEWeaponFree
---  * #CONTROLLABLE.OptionROEOpenFire
---  * #CONTROLLABLE.OptionROEReturnFire
---  * #CONTROLLABLE.OptionROEEvadeFire
---
---To check whether an ROE option is valid for a specific controllable, use:
---
---  * #CONTROLLABLE.OptionROEWeaponFreePossible
---  * #CONTROLLABLE.OptionROEOpenFirePossible
---  * #CONTROLLABLE.OptionROEReturnFirePossible
---  * #CONTROLLABLE.OptionROEEvadeFirePossible
---
---## 5.2) Reaction On Thread:
---
---  * #CONTROLLABLE.OptionROTNoReaction
---  * #CONTROLLABLE.OptionROTPassiveDefense
---  * #CONTROLLABLE.OptionROTEvadeFire
---  * #CONTROLLABLE.OptionROTVertical
---
---To test whether an ROT option is valid for a specific controllable, use:
---
---  * #CONTROLLABLE.OptionROTNoReactionPossible
---  * #CONTROLLABLE.OptionROTPassiveDefensePossible
---  * #CONTROLLABLE.OptionROTEvadeFirePossible
---  * #CONTROLLABLE.OptionROTVerticalPossible
---
---## 5.3) Alarm state:
---
---  * #CONTROLLABLE.OptionAlarmStateAuto
---  * #CONTROLLABLE.OptionAlarmStateGreen
---  * #CONTROLLABLE.OptionAlarmStateRed
---
---## 5.4) Jettison weapons:
---
---  * #CONTROLLABLE.OptionAllowJettisonWeaponsOnThreat
---  * #CONTROLLABLE.OptionKeepWeaponsOnThreat
---
---## 5.5) Air-2-Air missile attack range:
---  * #CONTROLLABLE.OptionAAAttackRange(): Defines the usage of A2A missiles against possible targets.
---  
---# 6) [GROUND] IR Maker Beacons for GROUPs and UNITs
--- * #CONTROLLABLE:NewIRMarker(): Create a blinking IR Marker on a GROUP or UNIT.
---@class CONTROLLABLE : POSITIONABLE
---@field ControllableName string The name of the controllable.
---@field DCSControllable Controllable The DCS controllable class.
---@field IRMarkerUnit boolean 
---@field TaskScheduler NOTYPE 
---@field WayPoints NOTYPE 
---@field private spot NOTYPE 
---@field private timer NOTYPE 
CONTROLLABLE = {}

---Clear all tasks from the controllable.
---
------
---@return CONTROLLABLE #
function CONTROLLABLE:ClearTasks() end

---Activate ACLS system of the CONTROLLABLE.
---The controllable should be an aircraft carrier! Also needs Link4 to work.
---
------
---@param UnitID? number (Optional) The DCS UNIT ID of the unit the ACLS system is attached to. Defaults to the UNIT itself.
---@param Name? string (Optional) Name of the ACLS Beacon
---@param Delay? number (Optional) Delay in seconds before the ICLS is activated.
---@return CONTROLLABLE #self
function CONTROLLABLE:CommandActivateACLS(UnitID, Name, Delay) end

---Give the CONTROLLABLE the command to activate a beacon.
---See [DCS_command_activateBeacon](https://wiki.hoggitworld.com/view/DCS_command_activateBeacon) on Hoggit.
---For specific beacons like TACAN use the more convenient #BEACON class.
---Note that a controllable can only have one beacon activated at a time with the execption of ICLS.
---
------
---@param Type BEACON.Type Beacon type (VOR, DME, TACAN, RSBN, ILS etc).
---@param System BEACON.System Beacon system (VOR, DME, TACAN, RSBN, ILS etc).
---@param Frequency number Frequency in Hz the beacon is running on. Use @{#UTILS.TACANToFrequency} to generate a frequency for TACAN beacons.
---@param UnitID number The ID of the unit the beacon is attached to. Useful if more units are in one group.
---@param Channel number Channel the beacon is using. For, e.g. TACAN beacons.
---@param ModeChannel string The TACAN mode of the beacon, i.e. "X" or "Y".
---@param AA boolean If true, create and Air-Air beacon. IF nil, automatically set if CONTROLLABLE depending on whether unit is and aircraft or not.
---@param Callsign string Morse code identification callsign.
---@param Bearing boolean If true, beacon provides bearing information - if supported by the unit the beacon is attached to.
---@param Delay? number (Optional) Delay in seconds before the beacon is activated.
---@return CONTROLLABLE #self
function CONTROLLABLE:CommandActivateBeacon(Type, System, Frequency, UnitID, Channel, ModeChannel, AA, Callsign, Bearing, Delay) end

---Activate ICLS system of the CONTROLLABLE.
---The controllable should be an aircraft carrier!
---
------
---@param Channel number ICLS channel.
---@param UnitID number The DCS UNIT ID of the unit the ICLS system is attached to. Useful if more units are in one group.
---@param Callsign string Morse code identification callsign.
---@param Delay? number (Optional) Delay in seconds before the ICLS is activated.
---@return CONTROLLABLE #self
function CONTROLLABLE:CommandActivateICLS(Channel, UnitID, Callsign, Delay) end

---Activate LINK4 system of the CONTROLLABLE.
---The controllable should be an aircraft carrier!
---
------
---@param Frequency number Link4 Frequency in MHz, e.g. 336 (defaults to 336 MHz)
---@param UnitID? number (Optional) The DCS UNIT ID of the unit the LINK4 system is attached to. Defaults to the UNIT itself.
---@param Callsign? string (Optional) Morse code identification callsign.
---@param Delay? number (Optional) Delay in seconds before the LINK4 is activated.
---@return CONTROLLABLE #self
function CONTROLLABLE:CommandActivateLink4(Frequency, UnitID, Callsign, Delay) end

---Deactivate ACLS system of the CONTROLLABLE.
---The controllable should be an aircraft carrier!
---
------
---@param Delay? number (Optional) Delay in seconds before the ICLS is deactivated.
---@return CONTROLLABLE #self
function CONTROLLABLE:CommandDeactivateACLS(Delay) end

---Deactivate the active beacon of the CONTROLLABLE.
---
------
---@param Delay? number (Optional) Delay in seconds before the beacon is deactivated.
---@return CONTROLLABLE #self
function CONTROLLABLE:CommandDeactivateBeacon(Delay) end

---Deactivate the ICLS of the CONTROLLABLE.
---
------
---@param Delay? number (Optional) Delay in seconds before the ICLS is deactivated.
---@return CONTROLLABLE #self
function CONTROLLABLE:CommandDeactivateICLS(Delay) end

---Deactivate the active Link4 of the CONTROLLABLE.
---
------
---@param Delay? number (Optional) Delay in seconds before the Link4 is deactivated.
---@return CONTROLLABLE #self
function CONTROLLABLE:CommandDeactivateLink4(Delay) end

---Do Script command
---
------
---@param DoScript string 
---@return DCSCommand #
function CONTROLLABLE:CommandDoScript(DoScript) end

---Set EPLRS of the CONTROLLABLE on/off.
---See [DCS command EPLRS](https://wiki.hoggitworld.com/view/DCS_command_eplrs)
---
------
---@param SwitchOnOff boolean If true (or nil) switch EPLRS on. If false switch off.
---@param Delay? number (Optional) Delay in seconds before the callsign is set. Default is immediately.
---@return CONTROLLABLE #self
function CONTROLLABLE:CommandEPLRS(SwitchOnOff, Delay) end

---Set callsign of the CONTROLLABLE.
---See [DCS command setCallsign](https://wiki.hoggitworld.com/view/DCS_command_setCallsign)
---
------
---@param CallName CALLSIGN Number corresponding the the callsign identifier you wish this group to be called.
---@param CallNumber number The number value the group will be referred to as. Only valid numbers are 1-9. For example Uzi **5**-1. Default 1.
---@param Delay? number (Optional) Delay in seconds before the callsign is set. Default is immediately.
---@return CONTROLLABLE #self
function CONTROLLABLE:CommandSetCallsign(CallName, CallNumber, Delay) end

---Set radio frequency.
---See [DCS command SetFrequency](https://wiki.hoggitworld.com/view/DCS_command_setFrequency)
---
------
---@param Frequency number Radio frequency in MHz.
---@param Modulation number Radio modulation. Default `radio.modulation.AM`.
---@param Power? number (Optional) Power of the Radio in Watts. Defaults to 10.
---@param Delay? number (Optional) Delay in seconds before the frequency is set. Default is immediately.
---@return CONTROLLABLE #self
function CONTROLLABLE:CommandSetFrequency(Frequency, Modulation, Power, Delay) end

---[AIR] Set radio frequency.
---See [DCS command SetFrequencyForUnit](https://wiki.hoggitworld.com/view/DCS_command_setFrequencyForUnit)
---
------
---@param Frequency number Radio frequency in MHz.
---@param Modulation number Radio modulation. Default `radio.modulation.AM`.
---@param Power? number (Optional) Power of the Radio in Watts. Defaults to 10.
---@param UnitID number (Optional, if your object is a UNIT) The UNIT ID this is for.
---@param Delay? number (Optional) Delay in seconds before the frequency is set. Default is immediately.
---@return CONTROLLABLE #self
function CONTROLLABLE:CommandSetFrequencyForUnit(Frequency, Modulation, Power, UnitID, Delay) end

---Set unlimited fuel.
---See [DCS command Unlimited Fuel](https://wiki.hoggitworld.com/view/DCS_command_setUnlimitedFuel).
---
------
---@param OnOff boolean Set unlimited fuel on = true or off = false.
---@param Delay? number (Optional) Set the option only after x seconds.
---@return CONTROLLABLE #self
function CONTROLLABLE:CommandSetUnlimitedFuel(OnOff, Delay) end

---[AIR] Set smoke off.
---See [DCS command smoke on off](https://wiki.hoggitworld.com/view/DCS_command_smoke_on_off)
---
------
---@param Delay? number (Optional) Delay the command by this many seconds.
---@return CONTROLLABLE #self
function CONTROLLABLE:CommandSmokeOFF(Delay) end

---[AIR] Set smoke on.
---See [DCS command smoke on off](https://wiki.hoggitworld.com/view/DCS_command_smoke_on_off)
---
------
---@param Delay? number (Optional) Delay the command by this many seconds.
---@return CONTROLLABLE #self
function CONTROLLABLE:CommandSmokeON(Delay) end

---[AIR] Set smoke on or off.
---See [DCS command smoke on off](https://wiki.hoggitworld.com/view/DCS_command_smoke_on_off)
---
------
---@param OnOff boolean Set to true for on and false for off. Defaults to true.
---@param Delay? number (Optional) Delay the command by this many seconds.
---@return CONTROLLABLE #self
function CONTROLLABLE:CommandSmokeOnOff(OnOff, Delay) end

---Create a stop route command, which returns a string containing the command.
---Use the result in the method #CONTROLLABLE.SetCommand().
---A value of true will make the ground group stop, a value of false will make it continue.
---Note that this can only work on GROUP level, although individual UNITs can be commanded, the whole GROUP will react.
---
---Example missions:
---
---  * GRP-310
---
------
---@param StopRoute boolean true if the ground unit needs to stop, false if it needs to continue to move.
---@return Task #
function CONTROLLABLE:CommandStopRoute(StopRoute) end

---Perform a switch waypoint command
---
------
---
---USAGE
---```
---
---  -- This test demonstrates the use(s) of the SwitchWayPoint method of the GROUP class.
---  HeliGroup = GROUP:FindByName( "Helicopter" )
---
---  -- Route the helicopter back to the FARP after 60 seconds.
---  -- We use the SCHEDULER class to do this.
---  SCHEDULER:New( nil,
---    function( HeliGroup )
---      local CommandRTB = HeliGroup:CommandSwitchWayPoint( 2, 8 )
---      HeliGroup:SetCommand( CommandRTB )
---    end, { HeliGroup }, 90
---  )
---```
------
---@param FromWayPoint number 
---@param ToWayPoint number 
---@return Task #
function CONTROLLABLE:CommandSwitchWayPoint(FromWayPoint, ToWayPoint) end

---Return the route of a controllable by using the Core.Database#DATABASE class.
---
------
---@param Begin number The route point from where the copy will start. The base route point is 0.
---@param End number The route point where the copy will end. The End point is the last point - the End point. The last point has base 0.
---@param Randomize boolean Randomization of the route, when true.
---@param Radius number When randomization is on, the randomization is within the radius.
function CONTROLLABLE:CopyRoute(Begin, End, Randomize, Radius) end

---[GROUND] Disable the IR marker.
---
------
---@return CONTROLLABLE #self 
function CONTROLLABLE:DisableIRMarker() end

---[GROUND] Disable the IR markers for a whole group.
---
------
---@return CONTROLLABLE #self 
function CONTROLLABLE:DisableIRMarkerForGroup() end

---(AIR) Aircraft will act as an AWACS for friendly units (will provide them with information about contacts).
---No parameters.
---[hoggit](https://wiki.hoggitworld.com/view/DCS_task_awacs).
---
------
---@return Task #The DCS task structure.
function CONTROLLABLE:EnRouteTaskAWACS() end

---(AIR) Enroute anti-ship task.
---
------
---@param TargetTypes AttributeNameArray Array of target categories allowed to engage. Default `{"Ships"}`.
---@param Priority? number (Optional) All en-route tasks have the priority parameter. This is a number (less value - higher priority) that determines actions related to what task will be performed first. Default 0.
---@return Task #The DCS task structure.
function CONTROLLABLE:EnRouteTaskAntiShip(TargetTypes, Priority) end

---(AIR) Enroute CAP task.
---
------
---@param TargetTypes AttributeNameArray Array of target categories allowed to engage. Default `{"Air"}`.
---@param Priority? number (Optional) All en-route tasks have the priority parameter. This is a number (less value - higher priority) that determines actions related to what task will be performed first. Default 0.
---@return Task #The DCS task structure.
function CONTROLLABLE:EnRouteTaskCAP(TargetTypes, Priority) end

---(GROUND) Ground unit (EW-radar) will act as an EWR for friendly units (will provide them with information about contacts).
---No parameters.
---See [hoggit](https://wiki.hoggitworld.com/view/DCS_task_ewr).
---
------
---@return Task #The DCS task structure.
function CONTROLLABLE:EnRouteTaskEWR() end

---(AIR) Engaging a controllable.
---The task does not assign the target controllable to the unit/controllable to attack now;
---it just allows the unit/controllable to engage the target controllable as well as other assigned targets.
---See [hoggit](https://wiki.hoggitworld.com/view/DCS_task_engageGroup).
---
------
---@param AttackGroup CONTROLLABLE The Controllable to be attacked.
---@param Priority number All en-route tasks have the priority parameter. This is a number (less value - higher priority) that determines actions related to what task will be performed first.
---@param WeaponType? number (optional) Bitmask of weapon types those allowed to use. If parameter is not defined that means no limits on weapon usage.
---@param WeaponExpend? AI.Task.WeaponExpend (optional) Determines how much weapon will be released at each attack. If parameter is not defined the unit / controllable will choose expend on its own discretion.
---@param AttackQty? number (optional) This parameter limits maximal quantity of attack. The aircraft/controllable will not make more attack than allowed even if the target controllable not destroyed and the aircraft/controllable still have ammo. If not defined the aircraft/controllable will attack target until it will be destroyed or until the aircraft/controllable will run out of ammo.
---@param Direction? Azimuth (optional) Desired ingress direction from the target to the attacking aircraft. Controllable/aircraft will make its attacks from the direction. Of course if there is no way to attack from the direction due the terrain controllable/aircraft will choose another direction.
---@param Altitude? Distance (optional) Desired attack start altitude. Controllable/aircraft will make its attacks from the altitude. If the altitude is too low or too high to use weapon aircraft/controllable will choose closest altitude to the desired attack start altitude. If the desired altitude is defined controllable/aircraft will not attack from safe altitude.
---@param AttackQtyLimit? boolean (optional) The flag determines how to interpret attackQty parameter. If the flag is true then attackQty is a limit on maximal attack quantity for "AttackGroup" and "AttackUnit" tasks. If the flag is false then attackQty is a desired attack quantity for "Bombing" and "BombingRunway" tasks.
---@return Task #The DCS task structure.
function CONTROLLABLE:EnRouteTaskEngageGroup(AttackGroup, Priority, WeaponType, WeaponExpend, AttackQty, Direction, Altitude, AttackQtyLimit) end

---(AIR) Engaging targets of defined types.
---
------
---@param Distance Distance Maximal distance from the target to a route leg. If the target is on a greater distance it will be ignored.
---@param TargetTypes AttributeNameArray Array of target categories allowed to engage.
---@param Priority number All enroute tasks have the priority parameter. This is a number (less value - higher priority) that determines actions related to what task will be performed first. Default 0.
---@return Task #The DCS task structure.
function CONTROLLABLE:EnRouteTaskEngageTargets(Distance, TargetTypes, Priority) end

---(AIR) Engaging a targets of defined types at circle-shaped zone.
---
------
---@param Vec2 Vec2 2D-coordinates of the zone.
---@param Radius Distance Radius of the zone.
---@param TargetTypes? AttributeNameArray (Optional) Array of target categories allowed to engage. Default {"Air"}.
---@param Priority? number (Optional) All en-route tasks have the priority parameter. This is a number (less value - higher priority) that determines actions related to what task will be performed first. Default 0.
---@return Task #The DCS task structure.
function CONTROLLABLE:EnRouteTaskEngageTargetsInZone(Vec2, Radius, TargetTypes, Priority) end

---(AIR) Search and attack the Unit.
---See [hoggit](https://wiki.hoggitworld.com/view/DCS_task_engageUnit).
---
------
---@param EngageUnit UNIT The UNIT.
---@param Priority? number (optional) All en-route tasks have the priority parameter. This is a number (less value - higher priority) that determines actions related to what task will be performed first.
---@param GroupAttack? boolean (optional) If true, all units in the group will attack the Unit when found.
---@param WeaponExpend? AI.Task.WeaponExpend (optional) Determines how much weapon will be released at each attack. If parameter is not defined the unit / controllable will choose expend on its own discretion.
---@param AttackQty? number (optional) This parameter limits maximal quantity of attack. The aircraft/controllable will not make more attack than allowed even if the target controllable not destroyed and the aircraft/controllable still have ammo. If not defined the aircraft/controllable will attack target until it will be destroyed or until the aircraft/controllable will run out of ammo.
---@param Direction? Azimuth (optional) Desired ingress direction from the target to the attacking aircraft. Controllable/aircraft will make its attacks from the direction. Of course if there is no way to attack from the direction due the terrain controllable/aircraft will choose another direction.
---@param Altitude? Distance (optional) Desired altitude to perform the unit engagement.
---@param Visible? boolean (optional) Unit must be visible.
---@param ControllableAttack? boolean (optional) Flag indicates that the target must be engaged by all aircrafts of the controllable. Has effect only if the task is assigned to a controllable, not to a single aircraft.
---@return Task #The DCS task structure.
function CONTROLLABLE:EnRouteTaskEngageUnit(EngageUnit, Priority, GroupAttack, WeaponExpend, AttackQty, Direction, Altitude, Visible, ControllableAttack) end

---(AIR + GROUND) The task makes the controllable/unit a FAC and lets the FAC to choose a targets (enemy ground controllable) around as well as other assigned targets.
---Assigns the controlled group to act as a Forward Air Controller or JTAC. Any detected targets will be assigned as targets to the player via the JTAC radio menu.
---Target designation is set to auto and is dependent on the circumstances.
---See [hoggit](https://wiki.hoggitworld.com/view/DCS_task_fac).
---
------
---@param Frequency number Frequency in MHz. Default 133 MHz.
---@param Modulation number Radio modulation. Default `radio.modulation.AM`.
---@param CallsignID number CallsignID, e.g. `CALLSIGN.JTAC.Anvil` for ground or `CALLSIGN.Aircraft.Ford` for air.
---@param CallsignNumber number Callsign first number, e.g. 2 for `Ford-2`.
---@param Priority number All en-route tasks have the priority parameter. This is a number (less value - higher priority) that determines actions related to what task will be performed first.
---@return Task #The DCS task structure.
function CONTROLLABLE:EnRouteTaskFAC(Frequency, Modulation, CallsignID, CallsignNumber, Priority) end

---(AIR + GROUND) The task makes the controllable/unit a FAC and lets the FAC to choose the target (enemy ground controllable) as well as other assigned targets.
---The killer is player-controlled allied CAS-aircraft that is in contact with the FAC.
---If the task is assigned to the controllable lead unit will be a FAC.
---See [hoggit](https://wiki.hoggitworld.com/view/DCS_task_fac_engageGroup).
---
------
---@param AttackGroup CONTROLLABLE Target CONTROLLABLE.
---@param Priority? number (Optional) All en-route tasks have the priority parameter. This is a number (less value - higher priority) that determines actions related to what task will be performed first. Default is 0.
---@param WeaponType? number (Optional) Bitmask of weapon types those allowed to use. Default is "Auto".
---@param Designation? AI.Task.Designation (Optional) Designation type.
---@param Datalink? boolean (optional) Allows to use datalink to send the target information to attack aircraft. Enabled by default.
---@param CallsignID number CallsignID, e.g. `CALLSIGN.JTAC.Anvil` for ground or `CALLSIGN.Aircraft.Ford` for air.
---@param CallsignNumber number Callsign first number, e.g. 2 for `Ford-2`.
---@param Frequency NOTYPE 
---@param Modulation NOTYPE 
---@return Task #The DCS task structure.
function CONTROLLABLE:EnRouteTaskFAC_EngageGroup(AttackGroup, Priority, WeaponType, Designation, Datalink, CallsignID, CallsignNumber, Frequency, Modulation) end

---(AIR) Enroute SEAD task.
---
------
---@param TargetTypes AttributeNameArray Array of target categories allowed to engage. Default `{"Air Defence"}`.
---@param Priority? number (Optional) All en-route tasks have the priority parameter. This is a number (less value - higher priority) that determines actions related to what task will be performed first. Default 0.
---@return Task #The DCS task structure.
function CONTROLLABLE:EnRouteTaskSEAD(TargetTypes, Priority) end

---(AIR) Aircraft will act as a tanker for friendly units.
---No parameters.
---See [hoggit](https://wiki.hoggitworld.com/view/DCS_task_tanker).
---
------
---@return Task #The DCS task structure.
function CONTROLLABLE:EnRouteTaskTanker() end

---[GROUND] Enable the IR marker.
---
------
---@param Runtime number (Optionally) Run this IR Marker for the given number of seconds, then stop. Else run until you call `myobject:DisableIRMarker()`.
---@return CONTROLLABLE #self 
function CONTROLLABLE:EnableIRMarker(Runtime) end

---[GROUND] Enable the IR markers for a whole group.
---
------
---@param Runtime number Runtime of the marker in seconds
---@return CONTROLLABLE #self 
function CONTROLLABLE:EnableIRMarkerForGroup(Runtime) end

---Return the detected target groups of the controllable as a Core.Set#SET_GROUP.
---The optional parametes specify the detection methods that can be applied.
---If no detection method is given, the detection will use all the available methods by default.
---
------
---@param DetectVisual? boolean (Optional) If *false*, do not include visually detected targets.
---@param DetectOptical? boolean (Optional) If *false*, do not include optically detected targets.
---@param DetectRadar? boolean (Optional) If *false*, do not include targets detected by radar.
---@param DetectIRST? boolean (Optional) If *false*, do not include targets detected by IRST.
---@param DetectRWR? boolean (Optional) If *false*, do not include targets detected by RWR.
---@param DetectDLINK? boolean (Optional) If *false*, do not include targets detected by data link.
---@return SET_GROUP #Set of detected groups.
function CONTROLLABLE:GetDetectedGroupSet(DetectVisual, DetectOptical, DetectRadar, DetectIRST, DetectRWR, DetectDLINK) end

---Return the detected targets of the controllable.
---The optional parameters specify the detection methods that can be applied.
---If no detection method is given, the detection will use all the available methods by default.
---
------
---@param DetectVisual? boolean (optional)
---@param DetectOptical? boolean (optional)
---@param DetectRadar? boolean (optional)
---@param DetectIRST? boolean (optional)
---@param DetectRWR? boolean (optional)
---@param DetectDLINK? boolean (optional)
---@return table #DetectedTargets
function CONTROLLABLE:GetDetectedTargets(DetectVisual, DetectOptical, DetectRadar, DetectIRST, DetectRWR, DetectDLINK) end

---Return the detected targets of the controllable.
---The optional parametes specify the detection methods that can be applied.
---If **no** detection method is given, the detection will use **all** the available methods by default.
---If **at least one** detection method is specified, only the methods set to *true* will be used.
---
------
---@param DetectVisual? boolean (Optional) If *false*, do not include visually detected targets.
---@param DetectOptical? boolean (Optional) If *false*, do not include optically detected targets.
---@param DetectRadar? boolean (Optional) If *false*, do not include targets detected by radar.
---@param DetectIRST? boolean (Optional) If *false*, do not include targets detected by IRST.
---@param DetectRWR? boolean (Optional) If *false*, do not include targets detected by RWR.
---@param DetectDLINK? boolean (Optional) If *false*, do not include targets detected by data link.
---@return SET_UNIT #Set of detected units.
function CONTROLLABLE:GetDetectedUnitSet(DetectVisual, DetectOptical, DetectRadar, DetectIRST, DetectRWR, DetectDLINK) end

---Returns relative amount of fuel (from 0.0 to 1.0) the unit has in its internal tanks.
---This method returns nil to ensure polymorphic behavior! This method needs to be overridden by GROUP or UNIT.
---
------
---@return nil #The CONTROLLABLE is not existing or alive.
function CONTROLLABLE:GetFuel() end

---Returns relative average amount of fuel (from 0.0 to 1.0) a unit or group has in its internal tanks.
---This method returns nil to ensure polymorphic behavior! This method needs to be overridden by GROUP or UNIT.
---
------
---@return nil #The CONTROLLABLE is not existing or alive.
function CONTROLLABLE:GetFuelAve() end

---Returns relative minimum amount of fuel (from 0.0 to 1.0) a unit or group has in its internal tanks.
---This method returns nil to ensure polymorphic behavior! This method needs to be overridden by GROUP or UNIT.
---
------
---@return nil #The CONTROLLABLE is not existing or alive.
function CONTROLLABLE:GetFuelMin() end

---Returns the health.
---Dead controllables have health <= 1.0.
---
------
---@return number #The controllable health value (unit or group average).
---@return nil #The controllable is not existing or alive.
function CONTROLLABLE:GetLife() end

---Returns the initial health.
---
------
---@return number #The controllable health value (unit or group average) or `nil` if the controllable does not exist.
function CONTROLLABLE:GetLife0() end

---Return the mission template of the controllable.
---
------
---@return table #The MissionTemplate TODO: Rework the method how to retrieve a template ...
function CONTROLLABLE:GetTaskMission() end

---Return the mission route of the controllable.
---
------
---@return table #The mission route defined by points.
function CONTROLLABLE:GetTaskRoute() end

---Get the current WayPoints set with the WayPoint functions( Note that the WayPoints can be nil, although there ARE waypoints).
---
------
---@return table #WayPoints If WayPoints is given, then return the WayPoints structure.
function CONTROLLABLE:GetWayPoints() end

---[GROUND] Check if an IR Spot exists.
---
------
---@return boolean #outcome
function CONTROLLABLE:HasIRMarker() end

---Checking the Task Queue of the controllable.
---Returns false if no task is on the queue. true if there is a task.
---
------
---@return CONTROLLABLE #self
function CONTROLLABLE:HasTask() end

---Returns if the Controllable contains AirPlanes.
---
------
---@return boolean #true if Controllable contains AirPlanes.
function CONTROLLABLE:IsAirPlane() end

---Check if a certain GROUP is detected by the controllable.
---The optional parametes specify the detection methods that can be applied.
---If **no** detection method is given, the detection will use **all** the available methods by default.
---If **at least one** detection method is specified, only the methods set to *true* will be used.
---
------
---@param Group GROUP The group that is supposed to be detected.
---@param DetectVisual? boolean (Optional) If *false*, do not include visually detected targets.
---@param DetectOptical? boolean (Optional) If *false*, do not include optically detected targets.
---@param DetectRadar? boolean (Optional) If *false*, do not include targets detected by radar.
---@param DetectIRST? boolean (Optional) If *false*, do not include targets detected by IRST.
---@param DetectRWR? boolean (Optional) If *false*, do not include targets detected by RWR.
---@param DetectDLINK? boolean (Optional) If *false*, do not include targets detected by data link.
---@return boolean #True if any unit of the group is detected.
function CONTROLLABLE:IsGroupDetected(Group, DetectVisual, DetectOptical, DetectRadar, DetectIRST, DetectRWR, DetectDLINK) end

---Returns if the Controllable contains Helicopters.
---
------
---@return boolean #true if Controllable contains Helicopters.
function CONTROLLABLE:IsHelicopter() end

---Returns if the unit is a submarine.
---
------
---@return boolean #Submarines attributes result.
function CONTROLLABLE:IsSubmarine() end

---Check if a DCS object (unit or static) is detected by the controllable.
---Note that after a target is detected it remains "detected" for a certain amount of time, even if the controllable cannot "see" the target any more with it's sensors.
---The optional parametes specify the detection methods that can be applied.
---
---If **no** detection method is given, the detection will use **all** the available methods by default.
---If **at least one** detection method is specified, only the methods set to *true* will be used.
---
------
---@param DCSObject Object The DCS object that is checked.
---@param DetectVisual? boolean (Optional) If *false*, do not include visually detected targets.
---@param DetectOptical? boolean (Optional) If *false*, do not include optically detected targets.
---@param DetectRadar? boolean (Optional) If *false*, do not include targets detected by radar.
---@param DetectIRST? boolean (Optional) If *false*, do not include targets detected by IRST.
---@param DetectRWR? boolean (Optional) If *false*, do not include targets detected by RWR.
---@param DetectDLINK? boolean (Optional) If *false*, do not include targets detected by data link.
---@return boolean #`true` if target is detected.
---@return boolean #`true` if target is *currently* visible by line of sight. Target must be detected (first parameter returns `true`).
---@return boolean #`true` if target type is known. Target must be detected (first parameter returns `true`).
---@return boolean #`true` if distance to target is known. Target must be detected (first parameter returns `true`).
---@return number #Mission time in seconds when target was last detected. Only present if the target is currently not visible (second parameter returns `false`) otherwise `nil` is returned.
---@return Vec3 #Last known position vector of the target. Only present if the target is currently not visible (second parameter returns `false`) otherwise `nil` is returned.
---@return Vec3 #Last known velocity vector of the target. Only present if the target is currently not visible (second parameter returns `false`) otherwise `nil` is returned.
function CONTROLLABLE:IsTargetDetected(DCSObject, DetectVisual, DetectOptical, DetectRadar, DetectIRST, DetectRWR, DetectDLINK) end

---Check if a certain UNIT is detected by the controllable.
---The optional parametes specify the detection methods that can be applied.
---
---If **no** detection method is given, the detection will use **all** the available methods by default.
---If **at least one** detection method is specified, only the methods set to *true* will be used.
---
------
---@param Unit UNIT The unit that is supposed to be detected.
---@param DetectVisual? boolean (Optional) If *false*, do not include visually detected targets.
---@param DetectOptical? boolean (Optional) If *false*, do not include optically detected targets.
---@param DetectRadar? boolean (Optional) If *false*, do not include targets detected by radar.
---@param DetectIRST? boolean (Optional) If *false*, do not include targets detected by IRST.
---@param DetectRWR? boolean (Optional) If *false*, do not include targets detected by RWR.
---@param DetectDLINK? boolean (Optional) If *false*, do not include targets detected by data link.
---@return boolean #`true` if target is detected.
---@return boolean #`true` if target is *currently* visible by line of sight. Target must be detected (first parameter returns `true`).
---@return boolean #`true` if target type is known. Target must be detected (first parameter returns `true`).
---@return boolean #`true` if distance to target is known. Target must be detected (first parameter returns `true`).
---@return number #Mission time in seconds when target was last detected. Only present if the target is currently not visible (second parameter returns `false`) otherwise `nil` is returned.
---@return Vec3 #Last known position vector of the target. Only present if the target is currently not visible (second parameter returns `false`) otherwise `nil` is returned.
---@return Vec3 #Last known velocity vector of the target. Only present if the target is currently not visible (second parameter returns `false`) otherwise `nil` is returned.
function CONTROLLABLE:IsUnitDetected(Unit, DetectVisual, DetectOptical, DetectRadar, DetectIRST, DetectRWR, DetectDLINK) end

---Create a new CONTROLLABLE from a DCSControllable
---
------
---@param ControllableName string The DCS Controllable name
---@return CONTROLLABLE #self
function CONTROLLABLE:New(ControllableName) end

---[GROUND] Create and enable a new IR Marker for the given controllable UNIT or GROUP.
---
------
---@param EnableImmediately boolean (Optionally) If true start up the IR Marker immediately. Else you need to call `myobject:EnableIRMarker()` later on.
---@param Runtime number (Optionally) Run this IR Marker for the given number of seconds, then stop. Use in conjunction with EnableImmediately. Defaults to 60 seconds.
---@return CONTROLLABLE #self
function CONTROLLABLE:NewIRMarker(EnableImmediately, Runtime) end

---Sets Controllable Option for A2A attack range for AIR FIGHTER units.
---
------
---
---USAGE
---```
---Range can be one of MAX_RANGE = 0, NEZ_RANGE = 1, HALF_WAY_RMAX_NEZ = 2, TARGET_THREAT_EST = 3, RANDOM_RANGE = 4. Defaults to 3. See: https://wiki.hoggitworld.com/view/DCS_option_missileAttack
---```
------
---@param range number Defines the range
---@return CONTROLLABLE #self
function CONTROLLABLE:OptionAAAttackRange(range) end

---Alarm state to Auto: AI will automatically switch alarm states based on the presence of threats.
---The AI kind of cheats in this regard.
---
------
---@return CONTROLLABLE #self
function CONTROLLABLE:OptionAlarmStateAuto() end

---Alarm state to Green: Group is not combat ready.
---Sensors are stowed if possible.
---
------
---@return CONTROLLABLE #self
function CONTROLLABLE:OptionAlarmStateGreen() end

---Alarm state to Red: Group is combat ready and actively searching for targets.
---
------
---@return CONTROLLABLE #self
function CONTROLLABLE:OptionAlarmStateRed() end

---Allow to Jettison of weapons upon threat.
---
------
---@return CONTROLLABLE #self
function CONTROLLABLE:OptionAllowJettisonWeaponsOnThreat() end

---Defines how long a GROUND unit/group will move to avoid an ongoing attack.
---
------
---@param Seconds number Any positive number: AI will disperse, but only for the specified time before continuing their route. 0: AI will not disperse.
---@return CONTROLLABLE #self
function CONTROLLABLE:OptionDisperseOnAttack(Seconds) end

---[Air] Defines the usage of Electronic Counter Measures by airborne forces.
---
------
---@param ECMvalue number Can be - 0=Never on, 1=if locked by radar, 2=if detected by radar, 3=always on, defaults to 1
---@return CONTROLLABLE #self
function CONTROLLABLE:OptionECM(ECMvalue) end

---[Air] Defines the usage of Electronic Counter Measures by airborne forces.
---AI will leave their ECM on all the time.
---
------
---@return CONTROLLABLE #self
function CONTROLLABLE:OptionECM_AlwaysOn() end

---[Air] Defines the usage of Electronic Counter Measures by airborne forces.
---If the AI is being detected by a radar they will enable their ECM.
---
------
---@return CONTROLLABLE #self
function CONTROLLABLE:OptionECM_DetectedLockByRadar() end

---[Air] Defines the usage of Electronic Counter Measures by airborne forces.
---Disables the ability for AI to use their ECM.
---
------
---@return CONTROLLABLE #self
function CONTROLLABLE:OptionECM_Never() end

---[Air] Defines the usage of Electronic Counter Measures by airborne forces.
---If the AI is actively being locked by an enemy radar they will enable their ECM jammer.
---
------
---@return CONTROLLABLE #self
function CONTROLLABLE:OptionECM_OnlyLockByRadar() end

---Defines the range at which a GROUND unit/group is allowed to use its weapons automatically.
---
------
---@param EngageRange number Engage range limit in percent (a number between 0 and 100). Default 100.
---@return CONTROLLABLE #self
function CONTROLLABLE:OptionEngageRange(EngageRange) end

---[Ground] Allows AI radar units to take defensive actions to avoid anti radiation missiles.
---Units are allowed to shut radar off and displace.
---
------
---@param Seconds number Can be - nil, 0 or false = switch off this option, any positive number = number of seconds the escape sequency runs.
---@return CONTROLLABLE #self
function CONTROLLABLE:OptionEvasionOfARM(Seconds) end

---[Ground] Option that defines the vehicle spacing when in an on road and off road formation.
---
------
---@param meters number Can be zero to 100 meters. Defaults to 50 meters.
---@return CONTROLLABLE #self
function CONTROLLABLE:OptionFormationInterval(meters) end

---Keep weapons upon threat.
---
------
---@return CONTROLLABLE #self
function CONTROLLABLE:OptionKeepWeaponsOnThreat() end

---Prohibit Afterburner.
---
------
---@param Prohibit boolean If true or nil, prohibit. If false, do not prohibit.
---@return CONTROLLABLE #self
function CONTROLLABLE:OptionProhibitAfterburner(Prohibit) end

---Set option for Rules of Engagement (ROE).
---
------
---@param ROEvalue number ROE value. See ENUMS.ROE.
---@return CONTROLLABLE #self
function CONTROLLABLE:OptionROE(ROEvalue) end

---Weapons Hold: AI will hold fire under all circumstances.
---
------
---@return CONTROLLABLE #self
function CONTROLLABLE:OptionROEHoldFire() end

---Can the CONTROLLABLE hold their weapons?
---
------
---@return boolean #
function CONTROLLABLE:OptionROEHoldFirePossible() end

---Open Fire (Only Designated): AI will engage only targets specified in its taskings.
---
------
---@return CONTROLLABLE #self
function CONTROLLABLE:OptionROEOpenFire() end

---Can the CONTROLLABLE attack designated targets?
---
------
---@return boolean #
function CONTROLLABLE:OptionROEOpenFirePossible() end

---Open Fire, Weapons Free (Priority Designated): AI will engage any enemy group it detects, but will prioritize targets specified in the groups tasking.
---**Only for AIR units!**
---
------
---@return CONTROLLABLE #self
function CONTROLLABLE:OptionROEOpenFireWeaponFree() end

---Can the CONTROLLABLE attack priority designated targets?
---Only for AIR!
---
------
---@return boolean #
function CONTROLLABLE:OptionROEOpenFireWeaponFreePossible() end

---Return Fire: AI will only engage threats that shoot first.
---
------
---@return CONTROLLABLE #self
function CONTROLLABLE:OptionROEReturnFire() end

---Can the CONTROLLABLE attack returning on enemy fire?
---
------
---@return boolean #
function CONTROLLABLE:OptionROEReturnFirePossible() end

---Weapon free.
---
------
---@return CONTROLLABLE #self
function CONTROLLABLE:OptionROEWeaponFree() end

---Can the CONTROLLABLE attack targets of opportunity?
---
------
---@return boolean #
function CONTROLLABLE:OptionROEWeaponFreePossible() end

---Set Reation On Threat behaviour.
---
------
---@param ROTvalue number ROT value. See ENUMS.ROT.
---@return CONTROLLABLE #self
function CONTROLLABLE:OptionROT(ROTvalue) end

---Evade on fire.
---
------
---@return CONTROLLABLE #self
function CONTROLLABLE:OptionROTEvadeFire() end

---Can the CONTROLLABLE evade on enemy fire?
---
------
---@return boolean #
function CONTROLLABLE:OptionROTEvadeFirePossible() end

---No evasion on enemy threats.
---
------
---@return CONTROLLABLE #self
function CONTROLLABLE:OptionROTNoReaction() end

---Can the CONTROLLABLE ignore enemy fire?
---
------
---@return boolean #
function CONTROLLABLE:OptionROTNoReactionPossible() end

---Evasion passive defense.
---
------
---@return CONTROLLABLE #self
function CONTROLLABLE:OptionROTPassiveDefense() end

---Can the CONTROLLABLE evade using passive defenses?
---
------
---@return boolean #
function CONTROLLABLE:OptionROTPassiveDefensePossible() end

---Evade on fire using vertical manoeuvres.
---
------
---@return CONTROLLABLE #self
function CONTROLLABLE:OptionROTVertical() end

---Can the CONTROLLABLE evade on fire using vertical manoeuvres?
---
------
---@return boolean #
function CONTROLLABLE:OptionROTVerticalPossible() end

---Set RTB on ammo.
---
------
---@param WeaponsFlag boolean Weapons.flag enumerator.
---@return CONTROLLABLE #self
function CONTROLLABLE:OptionRTBAmmo(WeaponsFlag) end

---Set RTB on bingo fuel.
---
------
---@param RTB boolean true if RTB on bingo fuel (default), false if no RTB on bingo fuel. Warning! When you switch this option off, the airborne group will continue to fly until all fuel has been consumed, and will crash.
---@return CONTROLLABLE #self
function CONTROLLABLE:OptionRTBBingoFuel(RTB) end

---Sets Controllable Option for Restriction of Afterburner.
---
------
---@param RestrictBurner boolean If true, restrict burner. If false or nil, allow (unrestrict) burner.
function CONTROLLABLE:OptionRestrictBurner(RestrictBurner) end

---[Air] Make an airplane or helicopter patrol between two points in a racetrack - resulting in a much tighter track around the start and end points.
---
------
---@param Point1 COORDINATE Start point.
---@param Point2 COORDINATE End point.
---@param Altitude? number (Optional) Altitude in meters. Defaults to the altitude of the coordinate.
---@param Speed? number (Optional) Speed in kph. Defaults to 500 kph.
---@param Formation? number (Optional) Formation to take, e.g. ENUMS.Formation.FixedWing.Trail.Close, also see [Hoggit Wiki](https://wiki.hoggitworld.com/view/DCS_option_formation).
---@param AGL? boolean (Optional) If true, set altitude to above ground level (AGL), not above sea level (ASL).
---@param Delay? number  (Optional) Set the task after delay seconds only.
---@return CONTROLLABLE #self
function CONTROLLABLE:PatrolRaceTrack(Point1, Point2, Altitude, Speed, Formation, AGL, Delay) end

---(GROUND) Patrol iteratively using the waypoints of the (parent) group.
---
------
---@return CONTROLLABLE #
function CONTROLLABLE:PatrolRoute() end

---(GROUND) Patrol randomly to the waypoints the for the (parent) group.
---A random waypoint will be picked and the group will move towards that point.
---
------
---@param Speed number Speed in km/h.
---@param Formation string The formation the group uses.
---@param ToWaypoint COORDINATE The waypoint where the group should move to.
---@return CONTROLLABLE #
function CONTROLLABLE:PatrolRouteRandom(Speed, Formation, ToWaypoint) end

---(GROUND) Patrol randomly to the waypoints the for the (parent) group.
---A random waypoint will be picked and the group will move towards that point.
---
------
---@param ZoneList table Table of zones.
---@param Speed number Speed in km/h the group moves at.
---@param Formation? string (Optional) Formation the group should use.
---@param DelayMin number Delay in seconds before the group progresses to the next route point. Default 1 sec.
---@param DelayMax number Max. delay in seconds. Actual delay is randomly chosen between DelayMin and DelayMax. Default equal to DelayMin.
---@return CONTROLLABLE #
function CONTROLLABLE:PatrolZones(ZoneList, Speed, Formation, DelayMin, DelayMax) end

---Popping current Task from the controllable.
---
------
---@return CONTROLLABLE #self
function CONTROLLABLE:PopCurrentTask() end

---Pushing Task on the queue from the controllable.
---
------
---@param DCSTask NOTYPE 
---@param WaitTime NOTYPE 
---@return CONTROLLABLE #self
function CONTROLLABLE:PushTask(DCSTask, WaitTime) end

---(GROUND) Relocate controllable to a random point within a given radius; use e.g.for evasive actions; Note that not all ground controllables can actually drive, also the alarm state of the controllable might stop it from moving.
---
------
---@param speed number Speed of the controllable, default 20
---@param radius number Radius of the relocation zone, default 500
---@param onroad boolean If true, route on road (less problems with AI way finding), default true
---@param shortcut boolean If true and onroad is set, take a shorter route - if available - off road, default false
---@param formation string Formation string as in the mission editor, e.g. "Vee", "Diamond", "Line abreast", etc. Defaults to "Off Road"
---@param onland? boolean (optional) If true, try up to 50 times to get a coordinate on land.SurfaceType.LAND. Note - this descriptor value is not reliably implemented on all maps.
---@return CONTROLLABLE #self
function CONTROLLABLE:RelocateGroundRandomInRadius(speed, radius, onroad, shortcut, formation, onland) end

---Make the controllable to follow a given route.
---
------
---@param Route table A table of Route Points.
---@param DelaySeconds? number (Optional) Wait for the specified seconds before executing the Route. Default is one second.
---@return CONTROLLABLE #The CONTROLLABLE.
function CONTROLLABLE:Route(Route, DelaySeconds) end

---Make the AIR Controllable fly towards a specific point.
---
------
---@param ToCoordinate COORDINATE A Coordinate to drive to.
---@param AltType COORDINATE.RoutePointAltType The altitude type.
---@param Type COORDINATE.RoutePointType The route point type.
---@param Action COORDINATE.RoutePointAction The route point action.
---@param Speed? number (optional) Speed in km/h. The default speed is 500 km/h.
---@param DelaySeconds number Wait for the specified seconds before executing the Route.
---@return CONTROLLABLE #The CONTROLLABLE.
function CONTROLLABLE:RouteAirTo(ToCoordinate, AltType, Type, Action, Speed, DelaySeconds) end

---Make the TRAIN Controllable to drive towards a specific point using railroads.
---
------
---@param ToCoordinate COORDINATE A Coordinate to drive to.
---@param Speed? number (Optional) Speed in km/h. The default speed is 20 km/h.
---@param DelaySeconds? number (Optional) Wait for the specified seconds before executing the Route. Default is one second.
---@param WaypointFunction? function (Optional) Function called when passing a waypoint. First parameters of the function are the @{#CONTROLLABLE} object, the number of the waypoint and the total number of waypoints.
---@param WaypointFunctionArguments? table (Optional) List of parameters passed to the *WaypointFunction*.
---@return CONTROLLABLE #The CONTROLLABLE.
function CONTROLLABLE:RouteGroundOnRailRoads(ToCoordinate, Speed, DelaySeconds, WaypointFunction, WaypointFunctionArguments) end

---Make the GROUND Controllable to drive towards a specific point using (mostly) roads.
---
------
---@param ToCoordinate COORDINATE A Coordinate to drive to.
---@param Speed? number (Optional) Speed in km/h. The default speed is 20 km/h.
---@param DelaySeconds? number (Optional) Wait for the specified seconds before executing the Route. Default is one second.
---@param OffRoadFormation? string (Optional) The formation at initial and final waypoint. Default is "Off Road".
---@param WaypointFunction? function (Optional) Function called when passing a waypoint. First parameters of the function are the @{#CONTROLLABLE} object, the number of the waypoint and the total number of waypoints.
---@param WaypointFunctionArguments? table (Optional) List of parameters passed to the *WaypointFunction*.
---@return CONTROLLABLE #The CONTROLLABLE.
function CONTROLLABLE:RouteGroundOnRoad(ToCoordinate, Speed, DelaySeconds, OffRoadFormation, WaypointFunction, WaypointFunctionArguments) end

---Make the GROUND Controllable to drive towards a specific point.
---
------
---@param ToCoordinate COORDINATE A Coordinate to drive to.
---@param Speed? number (optional) Speed in km/h. The default speed is 20 km/h.
---@param Formation? string (optional) The route point Formation, which is a text string that specifies exactly the Text in the Type of the route point, like "Vee", "Echelon Right".
---@param DelaySeconds number Wait for the specified seconds before executing the Route.
---@param WaypointFunction? function (Optional) Function called when passing a waypoint. First parameters of the function are the @{#CONTROLLABLE} object, the number of the waypoint and the total number of waypoints.
---@param WaypointFunctionArguments? table (Optional) List of parameters passed to the *WaypointFunction*.
---@return CONTROLLABLE #The CONTROLLABLE.
function CONTROLLABLE:RouteGroundTo(ToCoordinate, Speed, Formation, DelaySeconds, WaypointFunction, WaypointFunctionArguments) end

---Make the controllable to push follow a given route.
---
------
---@param Route table A table of Route Points.
---@param DelaySeconds? number (Optional) Wait for the specified seconds before executing the Route. Default is one second.
---@return CONTROLLABLE #The CONTROLLABLE.
function CONTROLLABLE:RoutePush(Route, DelaySeconds) end

---Resumes the movement of the vehicle on the route.
---
------
---@return CONTROLLABLE #
function CONTROLLABLE:RouteResume() end

---Stops the movement of the vehicle on the route.
---
------
---@return CONTROLLABLE #
function CONTROLLABLE:RouteStop() end

---(AIR + GROUND) Make the Controllable move to fly to a given point.
---
------
---@param Point Vec3 The destination point in Vec3 format.
---@param Speed number The speed [m/s] to travel.
---@return CONTROLLABLE #self
function CONTROLLABLE:RouteToVec2(Point, Speed) end

---(AIR + GROUND) Make the Controllable move to a given point.
---
------
---@param Point Vec3 The destination point in Vec3 format.
---@param Speed number The speed [m/s] to travel.
---@return CONTROLLABLE #self
function CONTROLLABLE:RouteToVec3(Point, Speed) end

---[AIR] Sets the controlled aircraft group to fly at the specified altitude in meters.
---
------
---@param Altitude number Altitude in meters.
---@param Keep? boolean (Optional) When set to true, will maintain the altitude on passing waypoints. If not present or false, the controlled group will return to the altitude as defined by their route.
---@param AltType? string (Optional) Specifies the altitude type used. If nil, the altitude type of the current waypoint will be used. Accepted values are "BARO" and "RADIO".
---@return CONTROLLABLE #self
function CONTROLLABLE:SetAltitude(Altitude, Keep, AltType) end

---Executes a command action for the CONTROLLABLE.
---
------
---@param DCSCommand Command The command to be executed.
---@return CONTROLLABLE #self
function CONTROLLABLE:SetCommand(DCSCommand) end

---Set option.
---
------
---@param OptionID number ID/Type of the option.
---@param OptionValue number Value of the option
---@return CONTROLLABLE #self
function CONTROLLABLE:SetOption(OptionID, OptionValue) end

---[AIR] Set how the AI uses the onboard radar.
---
------
---@param Option number Options are: `NEVER = 0, FOR_ATTACK_ONLY = 1,FOR_SEARCH_IF_REQUIRED = 2, FOR_CONTINUOUS_SEARCH = 3`
---@return CONTROLLABLE #self
function CONTROLLABLE:SetOptionRadarUsing(Option) end

---[AIR] Set how the AI uses the onboard radar, here: for attack only.
---
------
---@return CONTROLLABLE #self
function CONTROLLABLE:SetOptionRadarUsingForAttackOnly() end

---[AIR] Set how the AI uses the onboard radar, here: always on.
---
------
---@return CONTROLLABLE #self
function CONTROLLABLE:SetOptionRadarUsingForContinousSearch() end

---[AIR] Set how the AI uses the onboard radar, here: when required for searching.
---
------
---@return CONTROLLABLE #self
function CONTROLLABLE:SetOptionRadarUsingForSearchIfRequired() end

---[AIR] Set how the AI uses the onboard radar.
---Here: never.
---
------
---@return CONTROLLABLE #self
function CONTROLLABLE:SetOptionRadarUsingNever() end

---[AIR] Set the AI to report contact for certain types of objects.
---
------
---@param Objects table Table of attribute names for which AI reports contact. Defaults to {"Air"}. See [Hoggit Wiki](https://wiki.hoggitworld.com/view/DCS_enum_attributes)
---@return CONTROLLABLE #self
function CONTROLLABLE:SetOptionRadioContact(Objects) end

---[AIR] Set the AI to report engaging certain types of objects.
---
------
---@param Objects table Table of attribute names for which AI reports contact. Defaults to {"Air"}, see [Hoggit Wiki](https://wiki.hoggitworld.com/view/DCS_enum_attributes)
---@return CONTROLLABLE #self
function CONTROLLABLE:SetOptionRadioEngage(Objects) end

---[AIR] Set the AI to report killing certain types of objects.
---
------
---@param Objects table Table of attribute names for which AI reports contact. Defaults to {"Air"}, see [Hoggit Wiki](https://wiki.hoggitworld.com/view/DCS_enum_attributes)
---@return CONTROLLABLE #self
function CONTROLLABLE:SetOptionRadioKill(Objects) end

---[AIR] Set the AI to not report anything over the radio - radio silence
---
------
---@param OnOff boolean If true or nil, radio is set to silence, if false radio silence is lifted.
---@return CONTROLLABLE #self
function CONTROLLABLE:SetOptionRadioSilence(OnOff) end

---[AIR] Set if the AI is reporting passing of waypoints
---
------
---@param OnOff boolean If true or nil, AI will report passing waypoints, if false, it will not.
---@return CONTROLLABLE #self
function CONTROLLABLE:SetOptionWaypointPassReport(OnOff) end

---Sets the controlled group to go at the specified speed in meters per second.
---
------
---@param Speed number Speed in meters per second
---@param Keep? boolean (Optional) When set to true, will maintain the speed on passing waypoints. If not present or false, the controlled group will return to the speed as defined by their route.
---@return CONTROLLABLE #self
function CONTROLLABLE:SetSpeed(Speed, Keep) end

---Clearing the Task Queue and Setting the Task on the queue from the controllable.
---
------
---@param DCSTask Task DCS Task array.
---@param WaitTime number Time in seconds, before the task is set.
---@return CONTROLLABLE #self
function CONTROLLABLE:SetTask(DCSTask, WaitTime) end

---Set a Task at a Waypoint using a Route list.
---
------
---@param Waypoint table The Waypoint!
---@param Task Task The Task structure to be executed!
---@return Task #
function CONTROLLABLE:SetTaskWaypoint(Waypoint, Task) end

---Give an uncontrolled air controllable the start command.
---
------
---@param delay? number (Optional) Delay before start command in seconds.
---@return CONTROLLABLE #self
function CONTROLLABLE:StartUncontrolled(delay) end

---Return an empty task shell for Aerobatics.
---
------
---
---USAGE
---```
---       local plane = GROUP:FindByName("Aerial-1")
---       -- get a task shell
---       local aerotask = plane:TaskAerobatics()
---       -- add a series of maneuvers
---       aerotask = plane:TaskAerobaticsHorizontalEight(aerotask,1,5000,850,true,false,1,70)
---       aerotask = plane:TaskAerobaticsWingoverFlight(aerotask,1,0,0,true,true,20)
---       aerotask = plane:TaskAerobaticsLoop(aerotask,1,0,0,false,true)
---       -- set the task
---       plane:SetTask(aerotask)
---```
------
---@return Task #
function CONTROLLABLE:TaskAerobatics() end

---Add an aerobatics entry of type "AILERON_ROLL" to the Aerobatics Task.
---
------
---@param TaskAerobatics Task The Aerobatics Task
---@param Repeats? number (Optional) The number of repeats, defaults to 1.
---@param InitAltitude? number (Optional) Starting altitude in meters, defaults to 0.
---@param InitSpeed? number (Optional) Starting speed in KPH, defaults to 0.
---@param UseSmoke? boolean (Optional)  Using smoke, defaults to false.
---@param StartImmediately? boolean (Optional) If true, start immediately and ignore  InitAltitude and InitSpeed.
---@param Side? number (Optional) On which side to fly,  0 == left, 1 == right side, defaults to 0.
---@param RollRate? number (Optional) How many degrees to roll per sec(?), can be between 15 and 450, defaults to 90.
---@param TurnAngle? number (Optional) Angles to turn overall, defaults to 360.
---@param FixAngle? number (Optional) No idea what this does, can be between 0 and 180 degrees, defaults to 180.
---@return Task #
function CONTROLLABLE:TaskAerobaticsAileronRoll(TaskAerobatics, Repeats, InitAltitude, InitSpeed, UseSmoke, StartImmediately, Side, RollRate, TurnAngle, FixAngle) end

---Add an aerobatics entry of type "BARREL_ROLL" to the Aerobatics Task.
---
------
---@param TaskAerobatics Task The Aerobatics Task
---@param Repeats? number (Optional) The number of repeats, defaults to 1.
---@param InitAltitude? number (Optional) Starting altitude in meters, defaults to 0.
---@param InitSpeed? number (Optional) Starting speed in KPH, defaults to 0.
---@param UseSmoke? boolean (Optional)  Using smoke, defaults to false.
---@param StartImmediately? boolean (Optional) If true, start immediately and ignore  InitAltitude and InitSpeed.
---@param Side? number (Optional) On which side to fly,  0 == left, 1 == right side, defaults to 0.
---@param RollRate? number (Optional) How many degrees to roll per sec(?), can be between 15 and 450, defaults to 90.
---@param TurnAngle? number (Optional) Turn angle, defaults to 360 degrees.
---@return Task #
function CONTROLLABLE:TaskAerobaticsBarrelRoll(TaskAerobatics, Repeats, InitAltitude, InitSpeed, UseSmoke, StartImmediately, Side, RollRate, TurnAngle) end

---Add an aerobatics entry of type "CANDLE" to the Aerobatics Task.
---
------
---@param TaskAerobatics Task The Aerobatics Task
---@param Repeats? number (Optional) The number of repeats, defaults to 1.
---@param InitAltitude? number (Optional) Starting altitude in meters, defaults to 0.
---@param InitSpeed? number (Optional) Starting speed in KPH, defaults to 0.
---@param UseSmoke? boolean (Optional)  Using smoke, defaults to false.
---@param StartImmediately? boolean (Optional) If true, start immediately and ignore  InitAltitude and InitSpeed.
---@return Task #
function CONTROLLABLE:TaskAerobaticsCandle(TaskAerobatics, Repeats, InitAltitude, InitSpeed, UseSmoke, StartImmediately) end

---Add an aerobatics entry of type "CLIMB" to the Aerobatics Task.
---
------
---@param TaskAerobatics Task The Aerobatics Task
---@param Repeats? number (Optional) The number of repeats, defaults to 1.
---@param InitAltitude? number (Optional) Starting altitude in meters, defaults to 0.
---@param InitSpeed? number (Optional) Starting speed in KPH, defaults to 0.
---@param UseSmoke? boolean (Optional)  Using smoke, defaults to false.
---@param StartImmediately? boolean (Optional) If true, start immediately and ignore  InitAltitude and InitSpeed.
---@param Angle? number (Optional) Angle to climb. Can be between 15 and 90 degrees. Defaults to 45 degrees.
---@param FinalAltitude? number (Optional) Altitude to climb to in meters. Defaults to 5000m.
---@return Task #
function CONTROLLABLE:TaskAerobaticsClimb(TaskAerobatics, Repeats, InitAltitude, InitSpeed, UseSmoke, StartImmediately, Angle, FinalAltitude) end

---Add an aerobatics entry of type "DIVE" to the Aerobatics Task.
---
------
---@param TaskAerobatics Task The Aerobatics Task
---@param Repeats? number (Optional) The number of repeats, defaults to 1.
---@param InitAltitude? number (Optional) Starting altitude in meters, defaults to 5000.
---@param InitSpeed? number (Optional) Starting speed in KPH, defaults to 0.
---@param UseSmoke? boolean (Optional)  Using smoke, defaults to false.
---@param StartImmediately? boolean (Optional) If true, start immediately and ignore  InitAltitude and InitSpeed.
---@param Angle? number (Optional) With how many degrees to dive, defaults to 45. Can be 15 to 90 degrees.
---@param FinalAltitude? number (Optional) Final altitude in meters, defaults to 1000.
---@return Task #
function CONTROLLABLE:TaskAerobaticsDive(TaskAerobatics, Repeats, InitAltitude, InitSpeed, UseSmoke, StartImmediately, Angle, FinalAltitude) end

---Add an aerobatics entry of type "EDGE_FLIGHT" to the Aerobatics Task.
---
------
---@param TaskAerobatics Task The Aerobatics Task
---@param Repeats? number (Optional) The number of repeats, defaults to 1.
---@param InitAltitude? number (Optional) Starting altitude in meters, defaults to 0.
---@param InitSpeed? number (Optional) Starting speed in KPH, defaults to 0.
---@param UseSmoke? boolean (Optional)  Using smoke, defaults to false.
---@param StartImmediately? boolean (Optional) If true, start immediately and ignore  InitAltitude and InitSpeed.
---@param FlightTime? number (Optional) Time to fly this manoever in seconds, defaults to 10.
---@param Side? number (Optional) On which side to fly,  0 == left, 1 == right side, defaults to 0.
---@return Task #
function CONTROLLABLE:TaskAerobaticsEdgeFlight(TaskAerobatics, Repeats, InitAltitude, InitSpeed, UseSmoke, StartImmediately, FlightTime, Side) end

---Add an aerobatics entry of type "FORCED_TURN" to the Aerobatics Task.
---
------
---@param TaskAerobatics Task The Aerobatics Task
---@param Repeats? number (Optional) The number of repeats, defaults to 1.
---@param InitAltitude? number (Optional) Starting altitude in meters, defaults to 0.
---@param InitSpeed? number (Optional) Starting speed in KPH, defaults to 0.
---@param UseSmoke? boolean (Optional)  Using smoke, defaults to false.
---@param StartImmediately? boolean (Optional) If true, start immediately and ignore  InitAltitude and InitSpeed.
---@param TurnAngle? number (Optional) Angles to turn, defaults to 360.
---@param Side? number (Optional) On which side to fly,  0 == left, 1 == right side, defaults to 0.
---@param FlightTime? number (Optional) Flight time in seconds for thos maneuver. Defaults to 30.
---@param MinSpeed? number (Optional) Minimum speed to keep in kph, defaults to 250 kph.
---@return Task #
function CONTROLLABLE:TaskAerobaticsForcedTurn(TaskAerobatics, Repeats, InitAltitude, InitSpeed, UseSmoke, StartImmediately, TurnAngle, Side, FlightTime, MinSpeed) end

---Add an aerobatics entry of type "HAMMERHEAD" to the Aerobatics Task.
---
------
---@param TaskAerobatics Task The Aerobatics Task
---@param Repeats? number (Optional) The number of repeats, defaults to 1.
---@param InitAltitude? number (Optional) Starting altitude in meters, defaults to 0.
---@param InitSpeed? number (Optional) Starting speed in KPH, defaults to 0.
---@param UseSmoke? boolean (Optional)  Using smoke, defaults to false.
---@param StartImmediately? boolean (Optional) If true, start immediately and ignore  InitAltitude and InitSpeed.
---@param Side? number (Optional) On which side to fly,  0 == left, 1 == right side, defaults to 0.
---@return Task #
function CONTROLLABLE:TaskAerobaticsHammerhead(TaskAerobatics, Repeats, InitAltitude, InitSpeed, UseSmoke, StartImmediately, Side) end

---Add an aerobatics entry of type "HORIZONTAL_EIGHT" to the Aerobatics Task.
---
------
---@param TaskAerobatics Task The Aerobatics Task
---@param Repeats? number (Optional) The number of repeats, defaults to 1.
---@param InitAltitude? number (Optional) Starting altitude in meters, defaults to 0.
---@param InitSpeed? number (Optional) Starting speed in KPH, defaults to 0.
---@param UseSmoke? boolean (Optional)  Using smoke, defaults to false.
---@param StartImmediately? boolean (Optional) If true, start immediately and ignore  InitAltitude and InitSpeed.
---@param Side? number (Optional) On which side to fly,  0 == left, 1 == right side, defaults to 0.
---@param RollDeg? number (Optional) Roll degrees for Roll 1 and 2, defaults to 60.
---@return Task #
function CONTROLLABLE:TaskAerobaticsHorizontalEight(TaskAerobatics, Repeats, InitAltitude, InitSpeed, UseSmoke, StartImmediately, Side, RollDeg) end

---Add an aerobatics entry of type "IMMELMAN" to the Aerobatics Task.
---
------
---@param TaskAerobatics Task The Aerobatics Task
---@param Repeats? number (Optional) The number of repeats, defaults to 1.
---@param InitAltitude? number (Optional) Starting altitude in meters, defaults to 0.
---@param InitSpeed? number (Optional) Starting speed in KPH, defaults to 0.
---@param UseSmoke? boolean (Optional)  Using smoke, defaults to false.
---@param StartImmediately? boolean (Optional) If true, start immediately and ignore  InitAltitude and InitSpeed.
---@return Task #
function CONTROLLABLE:TaskAerobaticsImmelmann(TaskAerobatics, Repeats, InitAltitude, InitSpeed, UseSmoke, StartImmediately) end

---Add an aerobatics entry of type "LOOP" to the Aerobatics Task.
---
------
---@param TaskAerobatics Task The Aerobatics Task
---@param Repeats? number (Optional) The number of repeats, defaults to 1.
---@param InitAltitude? number (Optional) Starting altitude in meters, defaults to 0.
---@param InitSpeed? number (Optional) Starting speed in KPH, defaults to 0.
---@param UseSmoke? boolean (Optional)  Using smoke, defaults to false.
---@param StartImmediately? boolean (Optional) If true, start immediately and ignore  InitAltitude and InitSpeed.
---@return Task #
function CONTROLLABLE:TaskAerobaticsLoop(TaskAerobatics, Repeats, InitAltitude, InitSpeed, UseSmoke, StartImmediately) end

---Add an aerobatics entry of type "MILITARY_TURN" to the Aerobatics Task.
---
------
---@param TaskAerobatics Task The Aerobatics Task
---@param Repeats? number (Optional) The number of repeats, defaults to 1.
---@param InitAltitude? number (Optional) Starting altitude in meters, defaults to 0.
---@param InitSpeed? number (Optional) Starting speed in KPH, defaults to 0.
---@param UseSmoke? boolean (Optional)  Using smoke, defaults to false.
---@param StartImmediately? boolean (Optional) If true, start immediately and ignore  InitAltitude and InitSpeed.
---@return Task #
function CONTROLLABLE:TaskAerobaticsMilitaryTurn(TaskAerobatics, Repeats, InitAltitude, InitSpeed, UseSmoke, StartImmediately) end

---Add an aerobatics entry of type "SKEWED_LOOP" to the Aerobatics Task.
---
------
---@param TaskAerobatics Task The Aerobatics Task
---@param Repeats? number (Optional) The number of repeats, defaults to 1.
---@param InitAltitude? number (Optional) Starting altitude in meters, defaults to 0.
---@param InitSpeed? number (Optional) Starting speed in KPH, defaults to 0.
---@param UseSmoke? boolean (Optional)  Using smoke, defaults to false.
---@param StartImmediately? boolean (Optional) If true, start immediately and ignore  InitAltitude and InitSpeed.
---@param Side? number (Optional) On which side to fly,  0 == left, 1 == right side, defaults to 0.
---@param RollDeg? number (Optional) Roll degrees for Roll 1 and 2, defaults to 60.
---@return Task #
function CONTROLLABLE:TaskAerobaticsSkewedLoop(TaskAerobatics, Repeats, InitAltitude, InitSpeed, UseSmoke, StartImmediately, Side, RollDeg) end

---Add an aerobatics entry of type "SPIRAL" to the Aerobatics Task.
---
------
---@param TaskAerobatics Task The Aerobatics Task
---@param Repeats? number (Optional) The number of repeats, defaults to 1.
---@param InitAltitude? number (Optional) Starting altitude in meters, defaults to 0.
---@param InitSpeed? number (Optional) Starting speed in KPH, defaults to 0.
---@param UseSmoke? boolean (Optional)  Using smoke, defaults to false.
---@param StartImmediately? boolean (Optional) If true, start immediately and ignore  InitAltitude and InitSpeed.
---@param TurnAngle? number (Optional) Turn angle, defaults to 360 degrees.
---@param Roll? number (Optional) Roll to take, defaults to 60 degrees.
---@param Side? number (Optional) On which side to fly,  0 == left, 1 == right side, defaults to 0.
---@param UpDown? number (Optional) Spiral upwards (1) or downwards (0). Defaults to 0 - downwards.
---@param Angle? number (Optional) Angle to spiral. Can be between 15 and 90 degrees. Defaults to 45 degrees.
---@return Task #
function CONTROLLABLE:TaskAerobaticsSpiral(TaskAerobatics, Repeats, InitAltitude, InitSpeed, UseSmoke, StartImmediately, TurnAngle, Roll, Side, UpDown, Angle) end

---Add an aerobatics entry of type "SPLIT_S" to the Aerobatics Task.
---
------
---@param TaskAerobatics Task The Aerobatics Task
---@param Repeats? number (Optional) The number of repeats, defaults to 1.
---@param InitAltitude? number (Optional) Starting altitude in meters, defaults to 0.
---@param InitSpeed? number (Optional) Starting speed in KPH, defaults to 0.
---@param UseSmoke? boolean (Optional)  Using smoke, defaults to false.
---@param StartImmediately? boolean (Optional) If true, start immediately and ignore  InitAltitude and InitSpeed.
---@param FinalSpeed? number (Optional) Final speed to reach in KPH. Defaults to 500 kph.
---@return Task #
function CONTROLLABLE:TaskAerobaticsSplitS(TaskAerobatics, Repeats, InitAltitude, InitSpeed, UseSmoke, StartImmediately, FinalSpeed) end

---Add an aerobatics entry of type "STRAIGHT_FLIGHT" to the Aerobatics Task.
---
------
---@param TaskAerobatics Task The Aerobatics Task
---@param Repeats? number (Optional) The number of repeats, defaults to 1.
---@param InitAltitude? number (Optional) Starting altitude in meters, defaults to 0.
---@param InitSpeed? number (Optional) Starting speed in KPH, defaults to 0.
---@param UseSmoke? boolean (Optional)  Using smoke, defaults to false.
---@param StartImmediately? boolean (Optional) If true, start immediately and ignore  InitAltitude and InitSpeed.
---@param FlightTime? number (Optional) Time to fly this manoever in seconds, defaults to 10.
---@return Task #
function CONTROLLABLE:TaskAerobaticsStraightFlight(TaskAerobatics, Repeats, InitAltitude, InitSpeed, UseSmoke, StartImmediately, FlightTime) end

---Add an aerobatics entry of type "TURN" to the Aerobatics Task.
---
------
---@param TaskAerobatics Task The Aerobatics Task
---@param Repeats? number (Optional) The number of repeats, defaults to 1.
---@param InitAltitude? number (Optional) Starting altitude in meters, defaults to 0.
---@param InitSpeed? number (Optional) Starting speed in KPH, defaults to 0.
---@param UseSmoke? boolean (Optional)  Using smoke, defaults to false.
---@param StartImmediately? boolean (Optional) If true, start immediately and ignore  InitAltitude and InitSpeed.
---@param Side? number (Optional) On which side to fly,  0 == left, 1 == right side, defaults to 0.
---@param RollDeg? number (Optional) Roll degrees for Roll 1 and 2, defaults to 60.
---@param Pull? number (Optional) How many Gs to pull in this, defaults to 2.
---@param Angle? number (Optional) How many degrees to turn, defaults to 180.
---@return Task #
function CONTROLLABLE:TaskAerobaticsTurn(TaskAerobatics, Repeats, InitAltitude, InitSpeed, UseSmoke, StartImmediately, Side, RollDeg, Pull, Angle) end

---Add an aerobatics entry of type "WINGOVER_FLIGHT" to the Aerobatics Task.
---
------
---@param TaskAerobatics Task The Aerobatics Task
---@param Repeats? number (Optional) The number of repeats, defaults to 1.
---@param InitAltitude? number (Optional) Starting altitude in meters, defaults to 0.
---@param InitSpeed? number (Optional) Starting speed in KPH, defaults to 0.
---@param UseSmoke? boolean (Optional)  Using smoke, defaults to false.
---@param StartImmediately? boolean (Optional) If true, start immediately and ignore  InitAltitude and InitSpeed.
---@param FlightTime? number (Optional) Time to fly this manoever in seconds, defaults to 10.
---@return Task #
function CONTROLLABLE:TaskAerobaticsWingoverFlight(TaskAerobatics, Repeats, InitAltitude, InitSpeed, UseSmoke, StartImmediately, FlightTime) end

---(AIR + GROUND) Attack a Controllable.
---
------
---@param AttackGroup GROUP The Group to be attacked.
---@param WeaponType? number (optional) Bitmask of weapon types those allowed to use. If parameter is not defined that means no limits on weapon usage.
---@param WeaponExpend? AI.Task.WeaponExpend (optional) Determines how much weapon will be released at each attack. If parameter is not defined the unit / controllable will choose expend on its own discretion.
---@param AttackQty? number (optional) This parameter limits maximal quantity of attack. The aircraft/controllable will not make more attack than allowed even if the target controllable not destroyed and the aircraft/controllable still have ammo. If not defined the aircraft/controllable will attack target until it will be destroyed or until the aircraft/controllable will run out of ammo.
---@param Direction? Azimuth (optional) Desired ingress direction from the target to the attacking aircraft. Controllable/aircraft will make its attacks from the direction. Of course if there is no way to attack from the direction due the terrain controllable/aircraft will choose another direction.
---@param Altitude? Distance (optional) Desired attack start altitude. Controllable/aircraft will make its attacks from the altitude. If the altitude is too low or too high to use weapon aircraft/controllable will choose closest altitude to the desired attack start altitude. If the desired altitude is defined controllable/aircraft will not attack from safe altitude.
---@param AttackQtyLimit? boolean (optional) The flag determines how to interpret attackQty parameter. If the flag is true then attackQty is a limit on maximal attack quantity for "AttackGroup" and "AttackUnit" tasks. If the flag is false then attackQty is a desired attack quantity for "Bombing" and "BombingRunway" tasks.
---@param GroupAttack? boolean (Optional) If true, attack as group.
---@return Task #The DCS task structure.
function CONTROLLABLE:TaskAttackGroup(AttackGroup, WeaponType, WeaponExpend, AttackQty, Direction, Altitude, AttackQtyLimit, GroupAttack) end

---(AIR) Attacking the map object (building, structure, etc).
---
------
---@param Vec2 Vec2 2D-coordinates of the point to deliver weapon at.
---@param GroupAttack? boolean (Optional) If true, all units in the group will attack the Unit when found.
---@param WeaponExpend? AI.Task.WeaponExpend (Optional) Determines how much weapon will be released at each attack. If parameter is not defined the unit will choose expend on its own discretion.
---@param AttackQty? number (Optional) This parameter limits maximal quantity of attack. The aircraft/controllable will not make more attack than allowed even if the target controllable not destroyed and the aircraft/controllable still have ammo. If not defined the aircraft/controllable will attack target until it will be destroyed or until the aircraft/controllable will run out of ammo.
---@param Direction? Azimuth (Optional) Desired ingress direction from the target to the attacking aircraft. Controllable/aircraft will make its attacks from the direction. Of course if there is no way to attack from the direction due the terrain controllable/aircraft will choose another direction.
---@param Altitude? number (Optional) The altitude [meters] from where to attack. Default 30 m.
---@param WeaponType? number (Optional) The WeaponType. Default Auto=1073741822.
---@return Task #The DCS task structure.
function CONTROLLABLE:TaskAttackMapObject(Vec2, GroupAttack, WeaponExpend, AttackQty, Direction, Altitude, WeaponType) end

---(AIR + GROUND) Attack the Unit.
---
------
---@param AttackUnit UNIT The UNIT to be attacked
---@param GroupAttack? boolean (Optional) If true, all units in the group will attack the Unit when found. Default false.
---@param WeaponExpend? AI.Task.WeaponExpend (Optional) Determines how many weapons will be released at each attack. If parameter is not defined the unit / controllable will choose expend on its own discretion.
---@param AttackQty? number (Optional) Limits maximal quantity of attack. The aircraft/controllable will not make more attacks than allowed even if the target controllable not destroyed and the aircraft/controllable still have ammo. If not defined the aircraft/controllable will attack target until it will be destroyed or until the aircraft/controllable will run out of ammo.
---@param Direction? Azimuth (Optional) Desired ingress direction from the target to the attacking aircraft. Controllable/aircraft will make its attacks from the direction.
---@param Altitude? number (Optional) The (minimum) altitude in meters from where to attack. Default is altitude of unit to attack but at least 1000 m.
---@param WeaponType? number (optional) The WeaponType. See [DCS Enumerator Weapon Type](https://wiki.hoggitworld.com/view/DCS_enum_weapon_flag) on Hoggit.
---@return Task #The DCS task structure.
function CONTROLLABLE:TaskAttackUnit(AttackUnit, GroupAttack, WeaponExpend, AttackQty, Direction, Altitude, WeaponType) end

---(AIR) Delivering weapon at the point on the ground.
---
------
---@param Vec2 Vec2 2D-coordinates of the point to deliver weapon at.
---@param GroupAttack? boolean (optional) If true, all units in the group will attack the Unit when found.
---@param WeaponExpend? AI.Task.WeaponExpend (optional) Determines how much weapon will be released at each attack. If parameter is not defined the unit / controllable will choose expend on its own discretion.
---@param AttackQty? number (optional) This parameter limits maximal quantity of attack. The aircraft/controllable will not make more attack than allowed even if the target controllable not destroyed and the aircraft/controllable still have ammo. If not defined the aircraft/controllable will attack target until it will be destroyed or until the aircraft/controllable will run out of ammo.
---@param Direction? Azimuth (optional) Desired ingress direction from the target to the attacking aircraft. Controllable/aircraft will make its attacks from the direction. Of course if there is no way to attack from the direction due the terrain controllable/aircraft will choose another direction.
---@param Altitude? number (optional) The altitude from where to attack.
---@param WeaponType? number (optional) The WeaponType.
---@param Divebomb? boolean (optional) Perform dive bombing. Default false.
---@return Task #The DCS task structure.
function CONTROLLABLE:TaskBombing(Vec2, GroupAttack, WeaponExpend, AttackQty, Direction, Altitude, WeaponType, Divebomb) end

---(AIR) Delivering weapon on the runway.
---See [hoggit](https://wiki.hoggitworld.com/view/DCS_task_bombingRunway)
---
---Make sure the aircraft has the following role:
---
---* CAS
---* Ground Attack
---* Runway Attack
---* Anti-Ship Strike
---* AFAC
---* Pinpoint Strike
---
------
---@param Airbase AIRBASE Airbase to attack.
---@param WeaponType? number (optional) Bitmask of weapon types those allowed to use. See [DCS enum weapon flag](https://wiki.hoggitworld.com/view/DCS_enum_weapon_flag). Default 2147485694 = AnyBomb (GuidedBomb + AnyUnguidedBomb).
---@param WeaponExpend AI.Task.WeaponExpend Enum AI.Task.WeaponExpend that defines how much munitions the AI will expend per attack run. Default "ALL".
---@param AttackQty number Number of times the group will attack if the target. Default 1.
---@param Direction? Azimuth (optional) Desired ingress direction from the target to the attacking aircraft. Controllable/aircraft will make its attacks from the direction. Of course if there is no way to attack from the direction due the terrain controllable/aircraft will choose another direction.
---@param GroupAttack? boolean (optional) Flag indicates that the target must be engaged by all aircrafts of the controllable. Has effect only if the task is assigned to a group and not to a single aircraft.
---@return Task #The DCS task structure.
function CONTROLLABLE:TaskBombingRunway(Airbase, WeaponType, WeaponExpend, AttackQty, Direction, GroupAttack) end

---(AIR) Delivering weapon via CarpetBombing (all bombers in formation release at same time) at the point on the ground.
---
------
---@param Vec2 Vec2 2D-coordinates of the point to deliver weapon at.
---@param GroupAttack? boolean (optional) If true, all units in the group will attack the Unit when found.
---@param WeaponExpend? AI.Task.WeaponExpend (optional) Determines how much weapon will be released at each attack. If parameter is not defined the unit will choose expend on its own discretion.
---@param AttackQty? number (optional) This parameter limits maximal quantity of attack. The aircraft/controllable will not make more attack than allowed even if the target controllable not destroyed and the aircraft/controllable still have ammo. If not defined the aircraft/controllable will attack target until it will be destroyed or until the aircraft/controllable will run out of ammo.
---@param Direction? Azimuth (optional) Desired ingress direction from the target to the attacking aircraft. Controllable/aircraft will make its attacks from the direction. Of course if there is no way to attack from the direction due the terrain controllable/aircraft will choose another direction.
---@param Altitude? number (optional) The altitude from where to attack.
---@param WeaponType? number (optional) The WeaponType.
---@param CarpetLength? number (optional) default to 500 m.
---@return Task #The DCS task structure.
function CONTROLLABLE:TaskCarpetBombing(Vec2, GroupAttack, WeaponExpend, AttackQty, Direction, Altitude, WeaponType, CarpetLength) end

---Return a Combo Task taking an array of Tasks.
---
------
---@param DCSTasks TaskArray Array of DCSTasking.Task#Task
---@return Task #
function CONTROLLABLE:TaskCombo(DCSTasks) end

---Return a condition section for a controlled task.
---
------
---@param time Time DCS mission time.
---@param userFlag string Name of the user flag.
---@param userFlagValue boolean User flag value *true* or *false*. Could also be numeric, i.e. either 0=*false* or 1=*true*. Other numeric values don't work!
---@param condition string Lua string.
---@param duration Time Duration in seconds.
---@param lastWayPoint number Last waypoint. return DCS#Task
function CONTROLLABLE:TaskCondition(time, userFlag, userFlagValue, condition, duration, lastWayPoint) end

---Return a Controlled Task taking a Task and a TaskCondition.
---
------
---@param DCSTask Task 
---@param DCSStopCondition DCSStopCondition 
---@return Task #
function CONTROLLABLE:TaskControlled(DCSTask, DCSStopCondition) end

---Specifies the location infantry groups that is being transported by helicopters will be unloaded at.
---Used in conjunction with the EmbarkToTransport task.
---
------
---@param Coordinate COORDINATE Coordinates where AI is expecting to be picked up.
---@param GroupSetToDisembark NOTYPE 
---@return Task #Embark to transport task.
function CONTROLLABLE:TaskDisembarking(Coordinate, GroupSetToDisembark) end

---Set EPLRS data link on/off.
---
------
---@param SwitchOnOff boolean If true (or nil) switch EPLRS on. If false switch off.
---@param idx number Task index. Default 1.
---@return table #Task wrapped action.
function CONTROLLABLE:TaskEPLRS(SwitchOnOff, idx) end

---Used in conjunction with the embarking task for a transport helicopter group.
---The Ground units will move to the specified location and wait to be picked up by a helicopter.
---The helicopter will then fly them to their dropoff point defined by another task for the ground forces; DisembarkFromTransport task.
---The controllable has to be an infantry group!
---
------
---@param Coordinate COORDINATE Coordinates where AI is expecting to be picked up.
---@param Radius number Radius in meters. Default 200 m.
---@param UnitType string The unit type name of the carrier, e.g. "UH-1H". Must not be specified.
---@return Task #Embark to transport task.
function CONTROLLABLE:TaskEmbarkToTransport(Coordinate, Radius, UnitType) end

---(AIR HELICOPTER) Move the controllable to a Vec2 Point, wait for a defined duration and embark infantry groups.
---
------
---@param Coordinate COORDINATE The point where to pickup the troops.
---@param GroupSetForEmbarking SET_GROUP Set of groups to embark.
---@param Duration? number (Optional) The maximum duration in seconds to wait until all groups have embarked.
---@param Distribution? table (Optional) Distribution used to put the infantry groups into specific carrier units.
---@return Task #The DCS task structure.
function CONTROLLABLE:TaskEmbarking(Coordinate, GroupSetForEmbarking, Duration, Distribution) end

---Return an Empty Task.
---
------
---@return Task #
function CONTROLLABLE:TaskEmptyTask() end

---(AIR) Escort another airborne controllable.
---The unit / controllable will follow lead unit of another controllable, wingmens of both controllables will continue following their leaders.
---The unit / controllable will also protect that controllable from threats of specified types.
---
------
---@param FollowControllable CONTROLLABLE The controllable to be escorted.
---@param Vec3 Vec3 Position of the unit / lead unit of the controllable relative lead unit of another controllable in frame reference oriented by course of lead unit of another controllable. If another controllable is on land the unit / controllable will orbit around.
---@param LastWaypointIndex number Detach waypoint of another controllable. Once reached the unit / controllable Escort task is finished.
---@param EngagementDistance number Maximal distance from escorted controllable to threat in meters. If the threat is already engaged by escort escort will disengage if the distance becomes greater than 1.5 * engagementDistMax.
---@param TargetTypes AttributeNameArray Array of AttributeName that is contains threat categories allowed to engage. Default {"Air"}. See https://wiki.hoggit.us/view/DCS_enum_attributes
---@return Task #The DCS task structure.
function CONTROLLABLE:TaskEscort(FollowControllable, Vec3, LastWaypointIndex, EngagementDistance, TargetTypes) end

---(AIR + GROUND) The task makes the controllable/unit a FAC and orders the FAC to control the target (enemy ground controllable) destruction.
---The killer is player-controlled allied CAS-aircraft that is in contact with the FAC.
---If the task is assigned to the controllable lead unit will be a FAC.
---It's important to note that depending on the type of unit that is being assigned the task (AIR or GROUND), you must choose the correct type of callsign enumerator. For airborne controllables use CALLSIGN.Aircraft and for ground based use CALLSIGN.JTAC enumerators.
---
------
---@param AttackGroup GROUP Target GROUP object.
---@param WeaponType number Bitmask of weapon types, which are allowed to use.
---@param Designation? AI.Task.Designation (Optional) Designation type.
---@param Datalink? boolean (Optional) Allows to use datalink to send the target information to attack aircraft. Enabled by default.
---@param Frequency number Frequency in MHz used to communicate with the FAC. Default 133 MHz.
---@param Modulation number Modulation of radio for communication. Default 0=AM.
---@param CallsignName number Callsign enumerator name of the FAC. (CALLSIGN.Aircraft.{name} for airborne controllables, CALLSIGN.JTACS.{name} for ground units)
---@param CallsignNumber number Callsign number, e.g. Axeman-**1**.
---@return Task #The DCS task structure.
function CONTROLLABLE:TaskFAC_AttackGroup(AttackGroup, WeaponType, Designation, Datalink, Frequency, Modulation, CallsignName, CallsignNumber) end

---(GROUND) Fire at a VEC2 point until ammunition is finished.
---
------
---@param Vec2 Vec2 The point to fire at.
---@param Radius Distance The radius of the zone to deploy the fire at.
---@param AmmoCount? number (optional) Quantity of ammunition to expand (omit to fire until ammunition is depleted).
---@param WeaponType? number (optional) Enum for weapon type ID. This value is only required if you want the group firing to use a specific weapon, for instance using the task on a ship to force it to fire guided missiles at targets within cannon range. See http://wiki.hoggit.us/view/DCS_enum_weapon_flag
---@param Altitude? number (Optional) Altitude in meters.
---@param ASL number Altitude is above mean sea level. Default is above ground level.
---@return Task #The DCS task structure.
function CONTROLLABLE:TaskFireAtPoint(Vec2, Radius, AmmoCount, WeaponType, Altitude, ASL) end

---(AIR) Following another airborne controllable.
---The unit / controllable will follow lead unit of another controllable, wingmens of both controllables will continue following their leaders.
---If another controllable is on land the unit / controllable will orbit around.
---
------
---@param FollowControllable CONTROLLABLE The controllable to be followed.
---@param Vec3 Vec3 Position of the unit / lead unit of the controllable relative lead unit of another controllable in frame reference oriented by course of lead unit of another controllable. If another controllable is on land the unit / controllable will orbit around.
---@param LastWaypointIndex number Detach waypoint of another controllable. Once reached the unit / controllable Follow task is finished.
---@return Task #The DCS task structure.
function CONTROLLABLE:TaskFollow(FollowControllable, Vec3, LastWaypointIndex) end

---(AIR) Following another airborne controllable.
---The unit / controllable will follow lead unit of another controllable, wingmens of both controllables will continue following their leaders.
---Used to support CarpetBombing Task
---
------
---@param FollowControllable CONTROLLABLE The controllable to be followed.
---@param Vec3 Vec3 Position of the unit / lead unit of the controllable relative lead unit of another controllable in frame reference oriented by course of lead unit of another controllable. If another controllable is on land the unit / controllable will orbit around.
---@param LastWaypointIndex number Detach waypoint of another controllable. Once reached the unit / controllable Follow task is finished.
---@return Task #The DCS task structure.
function CONTROLLABLE:TaskFollowBigFormation(FollowControllable, Vec3, LastWaypointIndex) end

---This creates a Task element, with an action to call a function as part of a Wrapped Task.
---This Task can then be embedded at a Waypoint by calling the method #CONTROLLABLE.SetTaskWaypoint.
---
------
---
---USAGE
---```
---
--- local ZoneList = {
---   ZONE:New( "ZONE1" ),
---   ZONE:New( "ZONE2" ),
---   ZONE:New( "ZONE3" ),
---   ZONE:New( "ZONE4" ),
---   ZONE:New( "ZONE5" )
--- }
---
--- GroundGroup = GROUP:FindByName( "Vehicle" )
---
--- --- @param Wrapper.Group#GROUP GroundGroup
--- function RouteToZone( Vehicle, ZoneRoute )
---
---   local Route = {}
---
---   Vehicle:E( { ZoneRoute = ZoneRoute } )
---
---   Vehicle:MessageToAll( "Moving to zone " .. ZoneRoute:GetName(), 10 )
---
---   -- Get the current coordinate of the Vehicle
---   local FromCoord = Vehicle:GetCoordinate()
---
---   -- Select a random Zone and get the Coordinate of the new Zone.
---   local RandomZone = ZoneList[ math.random( 1, #ZoneList ) ] -- Core.Zone#ZONE
---   local ToCoord = RandomZone:GetCoordinate()
---
---   -- Create a "ground route point", which is a "point" structure that can be given as a parameter to a Task
---   Route[#Route+1] = FromCoord:WaypointGround( 72 )
---   Route[#Route+1] = ToCoord:WaypointGround( 60, "Vee" )
---
---   local TaskRouteToZone = Vehicle:TaskFunction( "RouteToZone", RandomZone )
---
---   Vehicle:SetTaskWaypoint( Route[#Route], TaskRouteToZone ) -- Set for the given Route at Waypoint 2 the TaskRouteToZone.
---
---   Vehicle:Route( Route, math.random( 10, 20 ) ) -- Move after a random seconds to the Route. See the Route method for details.
---
--- end
---
---   RouteToZone( GroundGroup, ZoneList[1] )
---```
------
---@param FunctionString string The function name embedded as a string that will be called.
---@param ... NOTYPE The variable arguments passed to the function when called! These arguments can be of any type!
---@return CONTROLLABLE #
function CONTROLLABLE:TaskFunction(FunctionString, ...) end

---(AIR/HELO) Escort a ground controllable.
---The unit / controllable will follow lead unit of the other controllable, additional units of both controllables will continue following their leaders.
---The unit / controllable will also protect that controllable from threats of specified types.
---
------
---@param FollowControllable CONTROLLABLE The controllable to be escorted.
---@param LastWaypointIndex? number (optional) Detach waypoint of another controllable. Once reached the unit / controllable Escort task is finished.
---@param OrbitDistance? number (optional) Maximum distance helo will orbit around the ground unit in meters. Defaults to 2000 meters.
---@param TargetTypes? AttributeNameArray (optional) Array of AttributeName that is contains threat categories allowed to engage. Default {"Ground vehicles"}. See [https://wiki.hoggit.us/view/DCS_enum_attributes](https://wiki.hoggit.us/view/DCS_enum_attributes)
---@return Task #The DCS task structure.
function CONTROLLABLE:TaskGroundEscort(FollowControllable, LastWaypointIndex, OrbitDistance, TargetTypes) end

---Make a task for a TRAIN Controllable to drive towards a specific point using railroad.
---
------
---@param ToCoordinate COORDINATE A Coordinate to drive to.
---@param Speed? number (Optional) Speed in km/h. The default speed is 20 km/h.
---@param WaypointFunction? function (Optional) Function called when passing a waypoint. First parameters of the function are the @{#CONTROLLABLE} object, the number of the waypoint and the total number of waypoints.
---@param WaypointFunctionArguments? table (Optional) List of parameters passed to the *WaypointFunction*.
---@return NOTYPE #Task
function CONTROLLABLE:TaskGroundOnRailRoads(ToCoordinate, Speed, WaypointFunction, WaypointFunctionArguments) end

---Make a task for a GROUND Controllable to drive towards a specific point using (mostly) roads.
---
------
---@param ToCoordinate COORDINATE A Coordinate to drive to.
---@param Speed? number (Optional) Speed in km/h. The default speed is 20 km/h.
---@param OffRoadFormation? string (Optional) The formation at initial and final waypoint. Default is "Off Road".
---@param Shortcut? boolean (Optional) If true, controllable will take the direct route if the path on road is 10x longer or path on road is less than 5% of total path.
---@param FromCoordinate? COORDINATE (Optional) Explicit initial coordinate. Default is the position of the controllable.
---@param WaypointFunction? function (Optional) Function called when passing a waypoint. First parameters of the function are the @{#CONTROLLABLE} object, the number of the waypoint and the total number of waypoints.
---@param WaypointFunctionArguments? table (Optional) List of parameters passed to the *WaypointFunction*.
---@return Task #Task.
---@return boolean #If true, path on road is possible. If false, task will route the group directly to its destination.
function CONTROLLABLE:TaskGroundOnRoad(ToCoordinate, Speed, OffRoadFormation, Shortcut, FromCoordinate, WaypointFunction, WaypointFunctionArguments) end

---(GROUND) Hold ground controllable from moving.
---
------
---@return Task #The DCS task structure.
function CONTROLLABLE:TaskHold() end

---(AIR) Hold position at the current position of the first unit of the controllable.
---
------
---@param Duration number The maximum duration in seconds to hold the position.
---@return CONTROLLABLE #self
function CONTROLLABLE:TaskHoldPosition(Duration) end

---(AIR HELICOPTER) Landing at the ground.
---For helicopters only.
---
------
---@param Vec2 Vec2 The point where to land.
---@param Duration number The duration in seconds to stay on the ground.
---@param CombatLanding? boolean (optional) If true, set the Combat Landing option.
---@param DirectionAfterLand? number (optional) Heading after landing in degrees.
---@return CONTROLLABLE #self
function CONTROLLABLE:TaskLandAtVec2(Vec2, Duration, CombatLanding, DirectionAfterLand) end

---(AIR) Land the controllable at a @{Core.Zone#ZONE_RADIUS).
---
------
---@param Zone ZONE The zone where to land.
---@param Duration number The duration in seconds to stay on the ground.
---@param RandomPoint? boolean (optional) If true,land at a random point inside of the zone. 
---@param CombatLanding? boolean (optional) If true, set the Combat Landing option.
---@param DirectionAfterLand? number (optional) Heading after landing in degrees.
---@return Task #The DCS task structure.
function CONTROLLABLE:TaskLandAtZone(Zone, Duration, RandomPoint, CombatLanding, DirectionAfterLand) end

---(AIR + GROUND) Return a mission task from a mission template.
---
------
---@param TaskMission table A table containing the mission task.
---@return Task #
function CONTROLLABLE:TaskMission(TaskMission) end

---(AIR) Orbit at a position with at a given altitude and speed.
---Optionally, a race track pattern can be specified.
---
------
---@param Coord COORDINATE Coordinate at which the CONTROLLABLE orbits. Can also be given as a `DCS#Vec3` or `DCS#Vec2` object.
---@param Altitude number Altitude in meters of the orbit pattern. Default y component of Coord.
---@param Speed number Speed [m/s] flying the orbit pattern. Default 128 m/s = 250 knots.
---@param CoordRaceTrack? COORDINATE (Optional) If this coordinate is specified, the CONTROLLABLE will fly a race-track pattern using this and the initial coordinate.
---@return CONTROLLABLE #self
function CONTROLLABLE:TaskOrbit(Coord, Altitude, Speed, CoordRaceTrack) end

---(AIR) Orbit at the current position of the first unit of the controllable at a specified altitude.
---
------
---@param Altitude number The altitude [m] to hold the position.
---@param Speed number The speed [m/s] flying when holding the position.
---@param Coordinate? COORDINATE (Optional) The coordinate where to orbit. If the coordinate is not given, then the current position of the controllable is used.
---@return CONTROLLABLE #self
function CONTROLLABLE:TaskOrbitCircle(Altitude, Speed, Coordinate) end

---(AIR) Orbit at a specified position at a specified altitude during a specified duration with a specified speed.
---
------
---@param Point Vec2 The point to hold the position.
---@param Altitude number The altitude AGL in meters to hold the position.
---@param Speed number The speed [m/s] flying when holding the position.
---@return CONTROLLABLE #self
function CONTROLLABLE:TaskOrbitCircleAtVec2(Point, Altitude, Speed) end

---(AIR) Act as Recovery Tanker for a naval/carrier group.
---
------
---@param CarrierGroup GROUP 
---@param Speed number Speed in meters per second
---@param Altitude number Altitude the tanker orbits at in meters
---@param LastWptNumber? number (optional) Waypoint of carrier group that when reached, ends the recovery tanker task
---@return Task #The DCS task structure.
function CONTROLLABLE:TaskRecoveryTanker(CarrierGroup, Speed, Altitude, LastWptNumber) end

---(AIR) Refueling from the nearest tanker.
---No parameters.
---
------
---@return Task #The DCS task structure.
function CONTROLLABLE:TaskRefueling() end

---Return a "Misson" task to follow a given route defined by Points.
---
------
---@param Points table A table of route points.
---@return Task #DCS mission task. Has entries `.id="Mission"`, `params`, were params has entries `airborne` and `route`, which is a table of `points`.
function CONTROLLABLE:TaskRoute(Points) end

---(GROUND) Route the controllable to a given Vec2.
---A speed can be given in km/h.
---A given formation can be given.
---
------
---@param Vec2 Vec2 The Vec2 where to route to.
---@param Speed number The speed in m/s. Default is 5.555 m/s = 20 km/h.
---@param Formation FORMATION The formation string.
function CONTROLLABLE:TaskRouteToVec2(Vec2, Speed, Formation) end

---(AIR + GROUND) Route the controllable to a given zone.
---The controllable final destination point can be randomized.
---A speed can be given in km/h.
---A given formation can be given.
---
------
---@param Zone ZONE The zone where to route to.
---@param Randomize boolean Defines whether to target point gets randomized within the Zone.
---@param Speed number The speed in m/s. Default is 5.555 m/s = 20 km/h.
---@param Formation FORMATION The formation string.
function CONTROLLABLE:TaskRouteToZone(Zone, Randomize, Speed, Formation) end

---(AIR) Strafe the point on the ground.
---
------
---
---USAGE
---```
---local attacker = GROUP:FindByName("Aerial-1")
---local attackVec2 = ZONE:New("Strafe Attack"):GetVec2()
----- Attack with any cannons = 805306368, 4 runs, strafe a field of 200 meters
---local task = attacker:TaskStrafing(attackVec2,4,200,805306368,AI.Task.WeaponExpend.ALL)
---attacker:SetTask(task,2)
---```
------
---@param Vec2 Vec2 2D-coordinates of the point to deliver strafing at.
---@param AttackQty? number (optional) This parameter limits maximal quantity of attack. The aircraft/controllable will not make more attack than allowed even if the target controllable not destroyed and the aircraft/controllable still have ammo. If not defined the aircraft/controllable will attack target until it will be destroyed or until the aircraft/controllable will run out of ammo.
---@param Length? number (optional) Length of the strafing area.
---@param WeaponType? number (optional) The WeaponType. WeaponType is a number associated with a [corresponding weapons flags](https://wiki.hoggitworld.com/view/DCS_enum_weapon_flag)
---@param WeaponExpend? AI.Task.WeaponExpend (optional) Determines how much ammunition will be released at each attack. If parameter is not defined the unit / controllable will choose expend on its own discretion, e.g. AI.Task.WeaponExpend.ALL.
---@param Direction? Azimuth (optional) Desired ingress direction from the target to the attacking aircraft. Controllable/aircraft will make its attacks from the direction. Of course if there is no way to attack from the direction due the terrain controllable/aircraft will choose another direction.
---@param GroupAttack? boolean (optional) If true, all units in the group will attack the Unit when found.
---@return Task #The DCS task structure.
function CONTROLLABLE:TaskStrafing(Vec2, AttackQty, Length, WeaponType, WeaponExpend, Direction, GroupAttack) end

---Return a WrappedAction Task taking a Command.
---
------
---@param DCSCommand Command 
---@param Index NOTYPE 
---@return Task #
function CONTROLLABLE:TaskWrappedAction(DCSCommand, Index) end

---Executes the WayPoint plan.
---The function gets a WayPoint parameter, that you can use to restart the mission at a specific WayPoint.
---Note that when the WayPoint parameter is used, the new start mission waypoint of the controllable will be 1!
---
------
---
---USAGE
---```
---Intended Workflow is:
---mygroup:WayPointInitialize()
---mygroup:WayPointFunction( WayPoint, WayPointIndex, WayPointFunction, ... )
---mygroup:WayPointExecute()
---```
------
---@param WayPoint number The WayPoint from where to execute the mission.
---@param WaitTime number The amount seconds to wait before initiating the mission.
---@return CONTROLLABLE #self
function CONTROLLABLE:WayPointExecute(WayPoint, WaitTime) end

---Registers a waypoint function that will be executed when the controllable moves over the WayPoint.
---
------
---
---USAGE
---```
---Intended Workflow is:
---mygroup:WayPointInitialize()
---mygroup:WayPointFunction( WayPoint, WayPointIndex, WayPointFunction, ... )
---mygroup:WayPointExecute()
---```
------
---@param WayPoint number The waypoint number. Note that the start waypoint on the route is WayPoint 1!
---@param WayPointIndex number When defining multiple WayPoint functions for one WayPoint, use WayPointIndex to set the sequence of actions.
---@param WayPointFunction function The waypoint function to be called when the controllable moves over the waypoint. The waypoint function takes variable parameters.
---@param ... NOTYPE 
---@return CONTROLLABLE #self
function CONTROLLABLE:WayPointFunction(WayPoint, WayPointIndex, WayPointFunction, ...) end

---Retrieve the controllable mission and allow to place function hooks within the mission waypoint plan.
---Use the method #CONTROLLABLE.WayPointFunction() to define the hook functions for specific waypoints.
---Use the method #CONTROLLABLE.WayPointExecute() to start the execution of the new mission plan.
---Note that when WayPointInitialize is called, the Mission of the controllable is RESTARTED!
---
------
---
---USAGE
---```
---Intended Workflow is:
---mygroup:WayPointInitialize()
---mygroup:WayPointFunction( WayPoint, WayPointIndex, WayPointFunction, ... )
---mygroup:WayPointExecute()
---```
------
---@param WayPoints table If WayPoints is given, then use the route.
---@return CONTROLLABLE #self
function CONTROLLABLE:WayPointInitialize(WayPoints) end

---Get the controller for the CONTROLLABLE.
---
------
---@return Controller #
function CONTROLLABLE:_GetController() end

---[Internal] This method is called by the scheduler after enabling the IR marker.
---
------
---@return CONTROLLABLE #self 
function CONTROLLABLE:_MarkerBlink() end


---
------
function CONTROLLABLE._StopSpot(spot) end

---Task function when controllable passes a waypoint.
---
------
---@param n number Current waypoint number passed.
---@param N number Total number of waypoints.
---@param waypointfunction function Function called when a waypoint is passed.
---@param ... NOTYPE 
function CONTROLLABLE.___PassingWaypoint(controllable, n, N, waypointfunction, ...) end



