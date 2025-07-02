---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Ops_RescueHelo.png" width="100%">
---
---**Ops** - Rescue helicopter for carrier operations.
---
---Recue helicopter for carrier operations.
---
---**Main Features:**
---
---   * Close formation with carrier.
---   * No restrictions regarding carrier waypoints and heading.
---   * Automatic respawning on empty fuel for 24/7 operations.
---   * Automatic rescuing of crashed or ejected pilots in the vicinity of the carrier.
---   * Multiple helos at different carriers due to object oriented approach.
---   * Finite State Machine (FSM) implementation.
---   
---## Known (DCS) Issues
---
---   * CH-53E does only report 27.5% fuel even if fuel is set to 100% in the ME. See [bug report](https://forums.eagle.ru/showthread.php?t=223712)
---   * CH-53E does not accept USS Tarawa as landing airbase (even it can be spawned on it).
---   * Helos dont move away from their landing position on carriers.
---
---===
---
---### Author: **funkyfranky**
---### Contributions: Flightcontrol (AI.AI_Formation class being used here)
---Rescue Helo
---
---===
---
---# Recue Helo
---
---The rescue helo will fly in close formation with another unit, which is typically an aircraft carrier.
---It's mission is to rescue crashed or ejected pilots. Well, and to look cool...
---
---# Simple Script
---
---In the mission editor you have to set up a carrier unit, which will act as "mother". In the following, this unit will be named "*USS Stennis*".
---
---Secondly, you need to define a rescue helicopter group in the mission editor and set it to "**LATE ACTIVATED**". The name of the group we'll use is "*Recue Helo*".
---
---The basic script is very simple and consists of only two lines. 
---
---     RescueheloStennis=RESCUEHELO:New(UNIT:FindByName("USS Stennis"), "Rescue Helo")
---     RescueheloStennis:Start()
---
---The first line will create a new #RESCUEHELO object via #RESCUEHELO.New and the second line starts the process by calling #RESCUEHELO.Start.
---
---**NOTE** that it is *very important* to define the RESCUEHELO object as **global** variable. Otherwise, the lua garbage collector will kill the formation for unknown reasons!
---
---By default, the helo will be spawned on the *USS Stennis* with hot engines. Then it will take off and go on station on the starboard side of the boat.
---
---Once the helo is out of fuel, it will return to the carrier. When the helo lands, it will be respawned immidiately and go back on station.
---
---If a unit crashes or a pilot ejects within a radius of 30 km from the USS Stennis, the helo will automatically fly to the crash side and 
---rescue to pilot. This will take around 5 minutes. After that, the helo will return to the Stennis, land there and bring back the poor guy.
---When this is done, the helo will go back on station.
---
---# Fine Tuning
---
---The implementation allows to customize quite a few settings easily via user API functions.
---
---## Takeoff Type
---
---By default, the helo is spawned with running engines on the carrier. The mission designer has set option to set the take off type via the #RESCUEHELO.SetTakeoff function.
---Or via shortcuts
---
---   * #RESCUEHELO.SetTakeoffHot(): Will set the takeoff to hot, which is also the default.
---   * #RESCUEHELO.SetTakeoffCold(): Will set the takeoff type to cold, i.e. with engines off.
---   * #RESCUEHELO.SetTakeoffAir(): Will set the takeoff type to air, i.e. the helo will be spawned in air near the unit which he follows.  
---
---For example,
---     RescueheloStennis=RESCUEHELO:New(UNIT:FindByName("USS Stennis"), "Rescue Helo")
---     RescueheloStennis:SetTakeoffAir()
---     RescueheloStennis:Start()
---will spawn the helo near the USS Stennis in air.
---
---Spawning in air is not as realistic but can be useful do avoid DCS bugs and shortcomings like aircraft crashing into each other on the flight deck.
---
---**Note** that when spawning in air is set, the helo will also not return to the boat, once it is out of fuel. Instead it will be respawned in air.
---
---If only the first spawning should happen on the carrier, one use the #RESCUEHELO.SetRespawnInAir() function to command that all subsequent spawning
---will happen in air.
---
---If the helo should no be respawned at all, one can set #RESCUEHELO.SetRespawnOff(). 
---
---## Home Base
---
---It is possible to define a "home base" other than the aircraft carrier using the #RESCUEHELO.SetHomeBase(*airbase*) function, where *airbase* is
---a Wrapper.Airbase#AIRBASE object or simply the name of the airbase.
---
---For example, one could imagine a strike group, and the helo will be spawned from another ship which has a helo pad.
---
---     RescueheloStennis=RESCUEHELO:New(UNIT:FindByName("USS Stennis"), "Rescue Helo")
---     RescueheloStennis:SetHomeBase(AIRBASE:FindByName("USS Normandy"))
---     RescueheloStennis:Start()
---
---In this case, the helo will be spawned on the USS Normandy and then make its way to the USS Stennis to establish the formation.
---Note that the distance to the mother ship should be rather small since the helo will go there very slowly.
---
---Once the helo runs out of fuel, it will return to the USS Normandy and not the Stennis for respawning.
---
---## Formation Position
---
---The position of the helo relative to the mother ship can be tuned via the functions
---
---   * #RESCUEHELO.SetAltitude(*altitude*), where *altitude* is the altitude the helo flies at in meters. Default is 70 meters.
---   * #RESCUEHELO.SetOffsetX(*distance*), where *distance is the distance in the direction of movement of the carrier. Default is 200 meters.
---   * #RESCUEHELO.SetOffsetZ(*distance*), where *distance is the distance on the starboard side. Default is 100 meters.
---
---## Rescue Operations
---
---By default the rescue helo will start a rescue operation if an aircraft crashes or a pilot ejects in the vicinity of the carrier.
---This is restricted to aircraft of the same coalition as the rescue helo. Enemy (or neutral) pilots will be left on their own.
---
---The standard "rescue zone" has a radius of 15 NM (~28 km) around the carrier. The radius can be adjusted via the #RESCUEHELO.SetRescueZone(*radius*) functions,
---where *radius* is the radius of the zone in nautical miles. If you use multiple rescue helos in the same mission, you might want to ensure that the radii
---are not overlapping so that two helos try to rescue the same pilot. But it should not hurt either way.
---
---Once the helo reaches the crash site, the rescue operation will last 5 minutes. This time can be changed by #RESCUEHELO.SetRescueDuration(*time*),
---where *time* is the duration in minutes.
---
---During the rescue operation, the helo will hover (orbit) over the crash site at a speed of 5 knots. The speed can be set by @{#RESCUEHELO.SetRescueHoverSpeed(*speed*),
---where the *speed* is given in knots.
---
---If no rescue operations should be carried out by the helo, this option can be completely disabled by using #RESCUEHELO.SetRescueOff().
---
---# Finite State Machine
---
---The implementation uses a Finite State Machine (FSM). This allows the mission designer to hook in to certain events.
---
---   * #RESCUEHELO.Start: This eventfunction starts the FMS process and initialized parameters and spawns the helo. DCS event handling is started.
---   * #RESCUEHELO.Status: This eventfunction is called in regular intervals (~60 seconds) and checks the status of the helo and carrier. It triggers other events if necessary.
---   * #RESCUEHELO.Rescue: This eventfunction commands the helo to go on a rescue operation at a certain coordinate.
---   * #RESCUEHELO.RTB: This eventsfunction sends the helo to its home base (usually the carrier). This is called once the helo runs low on gas.
---   * #RESCUEHELO.Run: This eventfunction is called when the helo resumes normal operations and goes back on station.  
---   * #RESCUEHELO.Stop: This eventfunction stops the FSM by unhandling DCS events.
---
---The mission designer can capture these events by RESCUEHELO.OnAfter*Eventname* functions, e.g. #RESCUEHELO.OnAfterRescue.
---
---# Debugging
---
---In case you have problems, it is always a good idea to have a look at your DCS log file. You find it in your "Saved Games" folder, so for example in
---    C:\Users\<yourname>\Saved Games\DCS\Logs\dcs.log
---All output concerning the #RESCUEHELO class should have the string "RESCUEHELO" in the corresponding line.
---Searching for lines that contain the string "error" or "nil" can also give you a hint what's wrong.
---
---The verbosity of the output can be increased by adding the following lines to your script:
---
---    BASE:TraceOnOff(true)
---    BASE:TraceLevel(1)
---    BASE:TraceClass("RESCUEHELO")
---
---To get even more output you can increase the trace level to 2 or even 3, c.f. Core.Base#BASE for more details.
---
---## Debug Mode
---
---You have the option to enable the debug mode for this class via the #RESCUEHELO.SetDebugModeON function.
---If enabled, text messages about the helo status will be displayed on screen and marks of the pattern created on the F10 map.
---RESCUEHELO class.
---@class RESCUEHELO : FSM
---@field ClassName string Name of the class.
---@field Debug boolean Debug mode on/off.
---@field HeloFuel0 number Initial fuel of helo in percent. Necessary due to DCS bug that helo with full tank does not return fuel via API function.
---@field private airbase AIRBASE The airbase object acting as home base of the helo.
---@field private alias string Alias of the spawn group.
---@field private altitude number Altitude of helo in meters.
---@field private carrier UNIT The carrier the helo is attached to.
---@field private carrierstop boolean If true, route of carrier was stopped.
---@field private carriertype string Carrier type.
---@field private dtFollow number Follow time update interval in seconds. Default 1.0 sec.
---@field private followset SET_GROUP Follow group set.
---@field private formation AI_FORMATION AI_FORMATION object.
---@field private helo GROUP Helo group.
---@field private helogroupname string Name of the late activated helo template group.
---@field private hid number Unit ID of the helo group. (Global) Running number.
---@field private lid string Log debug id text.
---@field private lowfuel number Low fuel threshold of helo in percent.
---@field private modex number Tail number of the helo.
---@field private offsetX number Offset in meters to carrier in longitudinal direction.
---@field private offsetZ number Offset in meters to carrier in latitudinal direction.
---@field private rescueduration number Time the rescue helicopter hovers over the crash site in seconds.
---@field private rescueon boolean If true, helo will rescue crashed pilots. If false, no recuing will happen.
---@field private rescuespeed number Speed in m/s the rescue helicopter hovers at over the crash site.
---@field private rescuestopboat boolean If true, stop carrier during rescue operations.
---@field private rescuezone ZONE_RADIUS Zone around the carrier in which helo will rescue crashed or ejected units.
---@field private respawn boolean If true, helo be respawned (default). If false, no respawning will happen.
---@field private respawninair boolean If true, helo will always be respawned in air. This has no impact on the initial spawn setting.
---@field private rtb boolean If true, Helo will be return to base on the next status check.
---@field private takeoff number Takeoff type.
---@field private uid number Unique ID of this helo.
---@field private uncontrolledac boolean If true, use and uncontrolled helo group already present in the mission.
---@field private version string Class version.
RESCUEHELO = {}

---Alias of helo spawn group.
---
------
---@return string #Alias of the helo. 
function RESCUEHELO:GetAlias() end

---Get unit name of the spawned helo.
---
------
---@return string #Name of the helo unit or nil if it does not exist. 
function RESCUEHELO:GetUnitName() end

---Check if helo is on a rescue mission.
---
------
---@return boolean #If true, helo is rescuing somebody. 
function RESCUEHELO:IsRescuing() end

---Check if helo is returning to base.
---
------
---@return boolean #If true, helo is returning to base. 
function RESCUEHELO:IsReturning() end

---Check if helo is operating.
---
------
---@return boolean #If true, helo is operating. 
function RESCUEHELO:IsRunning() end

---Check if FMS was stopped.
---
------
---@return boolean #If true, is stopped. 
function RESCUEHELO:IsStopped() end

---Create a new RESCUEHELO object.
---
------
---@param carrierunit UNIT Carrier unit object or simply the unit name.
---@param helogroupname string Name of the late activated rescue helo template group.
---@return RESCUEHELO #RESCUEHELO object.
function RESCUEHELO:New(carrierunit, helogroupname) end

---On after "RTB" event user function.
---Called when a the the helo returns to its home base.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param airbase AIRBASE The airbase to return to. Default is the home base.
function RESCUEHELO:OnAfterRTB(From, Event, To, airbase) end

---On after "Rescue" event user function.
---Called when a the the helo goes on a rescue mission.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param RescueCoord COORDINATE Crash site where the rescue operation takes place.
function RESCUEHELO:OnAfterRescue(From, Event, To, RescueCoord) end

---On after "Returned" event user function.
---Called when a the the helo has landed at an airbase.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param airbase AIRBASE The airbase the helo has landed.
function RESCUEHELO:OnAfterReturned(From, Event, To, airbase) end

---On after "Start" event function.
---Called when FSM is started.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function RESCUEHELO:OnAfterStart(From, Event, To) end

---Handle landing event of rescue helo.
---
------
---@param EventData EVENTDATA Event data.
function RESCUEHELO:OnEventLand(EventData) end

---Triggers the FSM event "RTB" that sends the helo home.
---
------
---@param airbase AIRBASE The airbase to return to. Default is the home base.
function RESCUEHELO:RTB(airbase) end

---Triggers the FSM event "Rescue" that sends the helo on a rescue mission to a specifc coordinate.
---
------
---@param RescueCoord COORDINATE Coordinate where the resue mission takes place.
function RESCUEHELO:Rescue(RescueCoord) end

---Triggers the FSM event "Returned" after the helo has landed.
---
------
---@param airbase AIRBASE The airbase the helo has landed.
function RESCUEHELO:Returned(airbase) end

---Route helo back to its home base.
---
------
---@param RTBAirbase AIRBASE 
---@param Speed number Speed.
function RESCUEHELO:RouteRTB(RTBAirbase, Speed) end

---Triggers the FSM event "Run".
---
------
function RESCUEHELO:Run() end

---Set altitude of helo.
---
------
---@param alt number Altitude in meters. Default 70 m.
---@return RESCUEHELO #self
function RESCUEHELO:SetAltitude(alt) end

---Deactivate debug mode.
---This is also the default setting.
---
------
---@return RESCUEHELO #self
function RESCUEHELO:SetDebugModeOFF() end

---Activate debug mode.
---Display debug messages on screen.
---
------
---@return RESCUEHELO #self
function RESCUEHELO:SetDebugModeON() end

---Set follow time update interval.
---
------
---@param dt number Time interval in seconds. Default 1.0 sec.
---@return RESCUEHELO #self
function RESCUEHELO:SetFollowTimeInterval(dt) end

---Set home airbase of the helo.
---This is the airbase where the helo is spawned (if not in air) and will go when it is out of fuel.
---
------
---@param airbase AIRBASE The home airbase. Can be the airbase name (passed as a string) or a Moose AIRBASE object.
---@return RESCUEHELO #self
function RESCUEHELO:SetHomeBase(airbase) end

---Set low fuel state of helo.
---When fuel is below this threshold, the helo will RTB or be respawned if takeoff type is in air.
---
------
---@param threshold number Low fuel threshold in percent. Default 5%.
---@return RESCUEHELO #self
function RESCUEHELO:SetLowFuelThreshold(threshold) end

---Set modex (tail number) of the helo.
---
------
---@param modex number Tail number.
---@return RESCUEHELO #self
function RESCUEHELO:SetModex(modex) end

---Set offset parallel to orientation of carrier.
---
------
---@param distance number Offset distance in meters. Default 200 m (~660 ft).
---@return RESCUEHELO #self
function RESCUEHELO:SetOffsetX(distance) end

---Set offset perpendicular to orientation to carrier.
---
------
---@param distance number Offset distance in meters. Default 240 m (~780 ft).
---@return RESCUEHELO #self
function RESCUEHELO:SetOffsetZ(distance) end

---Set rescue duration.
---This is the time it takes to rescue a pilot at the crash site.
---
------
---@param duration number Duration in minutes. Default 5 min.
---@return RESCUEHELO #self
function RESCUEHELO:SetRescueDuration(duration) end

---Set rescue hover speed.
---
------
---@param speed number Speed in knots. Default 5 kts.
---@return RESCUEHELO #self
function RESCUEHELO:SetRescueHoverSpeed(speed) end

---Deactivate rescue option.
---Crashed and ejected pilots will not be rescued.
---
------
---@return RESCUEHELO #self
function RESCUEHELO:SetRescueOff() end

---Activate rescue option.
---Crashed and ejected pilots will be rescued. This is the default setting.
---
------
---@return RESCUEHELO #self
function RESCUEHELO:SetRescueOn() end

---Do not stop carrier during rescue operations.
---This is the default setting.
---
------
---@return RESCUEHELO #self
function RESCUEHELO:SetRescueStopBoatOff() end

---Stop carrier during rescue operations.
---NOT WORKING!
---
------
---@return RESCUEHELO #self
function RESCUEHELO:SetRescueStopBoatOn() end

---Set rescue zone radius.
---Crashed or ejected units inside this radius of the carrier will be rescued if possible.
---
------
---@param radius number Radius of rescue zone in nautical miles. Default is 15 NM.
---@return RESCUEHELO #self
function RESCUEHELO:SetRescueZone(radius) end

---Helo will be respawned in air, even it was initially spawned on the carrier.
---So only the first spawn will be on the carrier while all subsequent spawns will happen in air.
---This allows for undisrupted operations and less problems on the carrier deck.
---
------
---@return RESCUEHELO #self
function RESCUEHELO:SetRespawnInAir() end

---Disable respawning of helo.
---
------
---@return RESCUEHELO #self
function RESCUEHELO:SetRespawnOff() end

---Enable respawning of helo.
---Note that this is the default behaviour.
---
------
---@return RESCUEHELO #self
function RESCUEHELO:SetRespawnOn() end

---Set whether helo shall be respawned or not.
---
------
---@param switch boolean If true (or nil), helo will be respawned. If false, helo will not be respawned. 
---@return RESCUEHELO #self
function RESCUEHELO:SetRespawnOnOff(switch) end

---Set takeoff type.
---
------
---@param takeofftype number Takeoff type. Default SPAWN.Takeoff.Hot.
---@return RESCUEHELO #self
function RESCUEHELO:SetTakeoff(takeofftype) end

---Set takeoff in air near the carrier.
---
------
---@return RESCUEHELO #self
function RESCUEHELO:SetTakeoffAir() end

---Set takeoff with engines off (cold).
---
------
---@return RESCUEHELO #self
function RESCUEHELO:SetTakeoffCold() end

---Set takeoff with engines running (hot).
---
------
---@return RESCUEHELO #self
function RESCUEHELO:SetTakeoffHot() end

---Use an uncontrolled aircraft already present in the mission rather than spawning a new helo as initial rescue helo.
---This can be useful when interfaced with, e.g., a warehouse.
---The group name is the one specified in the #RESCUEHELO.New function.
---
------
---@return RESCUEHELO #self
function RESCUEHELO:SetUseUncontrolledAircraft() end

---Triggers the FSM event "Start" that starts the rescue helo.
---Initializes parameters and starts event handlers.
---
------
function RESCUEHELO:Start() end

---Triggers the FSM event "Status" that updates the helo status.
---
------
function RESCUEHELO:Status() end

---Triggers the FSM event "Stop" that stops the rescue helo.
---Event handlers are stopped.
---
------
function RESCUEHELO:Stop() end

---A unit crashed or a player ejected.
---
------
---@param EventData EVENTDATA Event data.
function RESCUEHELO:_OnEventCrashOrEject(EventData) end

---Task to send the helo RTB.
---
------
---@return Task #DCS Task table.
function RESCUEHELO:_TaskRTB() end

---Triggers the FSM event "RTB" that sends the helo home after a delay.
---
------
---@param delay number Delay in seconds.
---@param airbase AIRBASE The airbase to return to. Default is the home base.
function RESCUEHELO:__RTB(delay, airbase) end

---Triggers the delayed FSM event "Rescue" that sends the helo on a rescue mission to a specifc coordinate.
---
------
---@param delay number Delay in seconds.
---@param RescueCoord COORDINATE Coordinate where the resue mission takes place.
function RESCUEHELO:__Rescue(delay, RescueCoord) end

---Triggers the delayed FSM event "Returned" after the helo has landed.
---
------
---@param delay number Delay in seconds.
---@param airbase AIRBASE The airbase the helo has landed.
function RESCUEHELO:__Returned(delay, airbase) end

---Triggers the delayed FSM event "Run".
---
------
---@param delay number Delay in seconds.
function RESCUEHELO:__Run(delay) end

---Triggers the FSM event "Start" that starts the rescue helo after a delay.
---Initializes parameters and starts event handlers.
---
------
---@param delay number Delay in seconds.
function RESCUEHELO:__Start(delay) end

---Triggers the delayed FSM event "Status" that updates the helo status.
---
------
---@param delay number Delay in seconds.
function RESCUEHELO:__Status(delay) end

---Triggers the FSM event "Stop" that stops the rescue helo after a delay.
---Event handlers are stopped.
---
------
---@param delay number Delay in seconds.
function RESCUEHELO:__Stop(delay) end

---On after RTB event.
---Send helo back to carrier.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param airbase AIRBASE The base to return to. Default is the home base.
---@private
function RESCUEHELO:onafterRTB(From, Event, To, airbase) end

---On after "Rescue" event.
---Helo will fly to the given coordinate, orbit there for 5 minutes and then return to the carrier.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param RescueCoord COORDINATE Coordinate where the rescue should happen.
---@private
function RESCUEHELO:onafterRescue(From, Event, To, RescueCoord) end

---On after Returned event.
---Helo has landed.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param airbase AIRBASE The base to which the helo has returned.
---@private
function RESCUEHELO:onafterReturned(From, Event, To, airbase) end

---On after "Run" event.
---FSM will go to "Running" state. If formation is stopped, it will be started again.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function RESCUEHELO:onafterRun(From, Event, To) end

---On after Start event.
---Starts the warehouse. Addes event handlers and schedules status updates of reqests and queue.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function RESCUEHELO:onafterStart(From, Event, To) end

---On after Status event.
---Checks player status.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function RESCUEHELO:onafterStatus(From, Event, To) end

---On after Stop event.
---Unhandle events and stop status updates. If helo is alive, it is despawned.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function RESCUEHELO:onafterStop(From, Event, To) end



