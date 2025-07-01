---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Ops_RecoveryTanker.png" width="100%">
---
---**Ops** - Recovery tanker for carrier operations.
---
---Tanker aircraft flying a racetrack pattern overhead an aircraft carrier.
---
---**Main Features:**
---
---   * Regular pattern update with respect to carrier position.
---   * No restrictions regarding carrier waypoints and heading.
---   * Automatic respawning when tanker runs out of fuel for 24/7 operations.
---   * Tanker can be spawned cold or hot on the carrier or at any other airbase or directly in air.
---   * Automatic AA TACAN beacon setting.
---   * Multiple tankers at the same carrier.
---   * Multiple carriers due to object oriented approach.
---   * Finite State Machine (FSM) implementation, which allows the mission designer to hook into certain events.
---
---===
---
---### Author: **funkyfranky** 
---### Special thanks to **HighwaymanEd** for testing and suggesting improvements!
---Recovery Tanker.
---
---===
---
---![Banner Image](..\Presentations\RECOVERYTANKER\RecoveryTanker_Main.png)
---
---# Recovery Tanker
---
---A recovery tanker acts as refueling unit flying overhead an aircraft carrier in order to supply incoming flights with gas if they go "*Bingo on the Ball*".
---
---# Simple Script
---
---In the mission editor you have to set up a carrier unit, which will act as "mother". In the following, this unit will be named **"USS Stennis"**.
---
---Secondly, you need to define a recovery tanker group in the mission editor and set it to **"LATE ACTIVATED"**. The name of the group we'll use is **"Texaco"**.
---
---The basic script is very simple and consists of only two lines: 
---
---    TexacoStennis=RECOVERYTANKER:New(UNIT:FindByName("USS Stennis"), "Texaco")
---    TexacoStennis:Start()
---
---The first line will create a new RECOVERYTANKER object and the second line starts the process.
---
---With this setup, the tanker will be spawned on the USS Stennis with running engines. After it takes off, it will fly a position ~10 NM astern of the boat and from there start its
---pattern. This is a counter clockwise racetrack pattern at angels 6.
---
---A TACAN beacon will be automatically activated at channel 1Y with morse code "TKR". See below how to change this setting.
---
---Note that the Tanker entry in the F10 radio menu will appear once the tanker is on station and not before. If you spawn the tanker cold or hot on the carrier, this will take ~10 minutes.
---
---Also note, that currently the only carrier capable aircraft in DCS is the S-3B Viking (tanker version). If you want to use another refueling aircraft, you need to activate air spawn
---or set a different land based airport of the map. This will be explained below.
---
---![Banner Image](..\Presentations\RECOVERYTANKER\RecoveryTanker_Pattern.jpg)
---
---The "downwind" leg of the pattern is normally used for refueling.
---
---Once the tanker runs out of fuel itself, it will return to the carrier, respawn with full fuel and take up its pattern again.
---
---# Options and Fine Tuning
---
---Several parameters can be customized by the mission designer via user API functions.
---
---## Takeoff Type
---
---By default, the tanker is spawned with running engines on the carrier. The mission designer has set option to set the take off type via the #RECOVERYTANKER.SetTakeoff function.
---Or via shortcuts
---
---   * #RECOVERYTANKER.SetTakeoffHot(): Will set the takeoff to hot, which is also the default.
---   * #RECOVERYTANKER.SetTakeoffCold(): Will set the takeoff type to cold, i.e. with engines off.
---   * #RECOVERYTANKER.SetTakeoffAir(): Will set the takeoff type to air, i.e. the tanker will be spawned in air ~10 NM astern the carrier.  
---
---For example,
---    TexacoStennis=RECOVERYTANKER:New(UNIT:FindByName("USS Stennis"), "Texaco")
---    TexacoStennis:SetTakeoffAir()
---    TexacoStennis:Start()
---will spawn the tanker several nautical miles astern the carrier. From there it will start its pattern.
---
---Spawning in air is not as realistic but can be useful do avoid DCS bugs and shortcomings like aircraft crashing into each other on the flight deck.
---
---**Note** that when spawning in air is set, the tanker will also not return to the boat, once it is out of fuel. Instead it will be respawned directly in air.
---
---If only the first spawning should happen on the carrier, one use the #RECOVERYTANKER.SetRespawnInAir() function to command that all subsequent spawning
---will happen in air.
---
---If the tanker should not be respawned at all, one can set #RECOVERYTANKER.SetRespawnOff().
---
---## Pattern Parameters
---
---The racetrack pattern parameters can be fine tuned via the following functions:
---
---   * #RECOVERYTANKER.SetAltitude(*altitude*), where *altitude* is the pattern altitude in feet. Default 6000 ft.
---   * #RECOVERYTANKER.SetSpeed(*speed*), where *speed* is the pattern speed in knots. Default is 274 knots TAS which results in ~250 KIAS.
---   * #RECOVERYTANKER.SetRacetrackDistances(*distbow*, *diststern*), where *distbow* and *diststern* are the distances ahead and astern the boat (default 10 and 4 NM), respectively.
---   In principle, these number should be more like 8 and 6 NM but since the carrier is moving, we give translate the pattern points a bit forward.
---   
---## Home Base
---
---The home base is the airbase where the tanker is spawned (if not in air) and where it will go once it is running out of fuel. The default home base is the carrier itself.
---The home base can be changed via the #RECOVERYTANKER.SetHomeBase(*airbase*) function, where *airbase* can be a MOOSE Wrapper.Airbase#AIRBASE object or simply the 
---name of the airbase passed as string.
---
---Note that only the S3B Viking is a refueling aircraft that is carrier capable. You can use other tanker aircraft types, e.g. the KC-130, but in this case you must either 
---set an airport of the map as home base or activate spawning in air via #RECOVERYTANKER.SetTakeoffAir.
---
---## TACAN
---
---A TACAN beacon for the tanker can be activated via scripting, i.e. no need to do this within the mission editor.
---
---The beacon is create with the #RECOVERYTANKER.SetTACAN(*channel*, *morse*) function, where *channel* is the TACAN channel (a number), 
---and *morse* a three letter string that is send as morse code to identify the tanker:
---
---    TexacoStennis:SetTACAN(10, "TKR")
---    
---will activate a TACAN beacon 10Y with more code "TKR".
---
---If you do not set a TACAN beacon explicitly, it is automatically create on channel 1Y and morse code "TKR".
---The mode is *always* "Y" for AA TACAN stations since mode "X" does not work!
---
---In order to completely disable the TACAN beacon, you can use the #RECOVERYTANKER.SetTACANoff() function in your script.
---
---## Radio
---
---The radio frequency on optionally modulation can be set via the #RECOVERYTANKER.SetRadio(*frequency*, *modulation*) function. The first parameter denotes the radio frequency the tanker uses in MHz.
---The second parameter is *optional* and sets the modulation to either AM (default) or FM.
---
---For example,
---
---    TexacoStennis:SetRadio(260)
---
---will set the frequency of the tanker to 260 MHz AM.
---
---**Note** that if this is not set, the tanker frequency will be automatically set to **251 MHz AM**.
---
---## Pattern Update
---
---The pattern of the tanker is updated if at least one of the two following conditions apply:
---
---   * The aircraft carrier changes its position by more than 5 NM (see #RECOVERYTANKER.SetPatternUpdateDistance) and/or
---   * The aircraft carrier changes its heading by more than 5 degrees (see #RECOVERYTANKER.SetPatternUpdateHeading)
---
---**Note** that updating the pattern often leads to a more or less small disruption of the perfect racetrack pattern of the tanker. This is because a new waypoint and new racetrack points
---need to be set as DCS task. This is the reason why the pattern is not constantly updated but rather when the position or heading of the carrier changes significantly.
---
---The maximum update frequency is set to 10 minutes. You can adjust this by #RECOVERYTANKER.SetPatternUpdateInterval.
---Also the pattern will not be updated whilst the carrier is turning or the tanker is currently refueling another unit.
---
---## Callsign
---
---The callsign of the tanker can be set via the #RECOVERYTANKER.SetCallsign(*callsignname*, *callsignnumber*) function. Both parameters are *numbers*.
---The first parameter *callsignname* defines the name (1=Texaco, 2=Arco, 3=Shell). The second (optional) parameter specifies the first number and has to be between 1-9.
---Also see [DCS_enum_callsigns](https://wiki.hoggitworld.com/view/DCS_enum_callsigns) and [DCS_command_setCallsign](https://wiki.hoggitworld.com/view/DCS_command_setCallsign).
---
---    TexacoStennis:SetCallsign(CALLSIGN.Tanker.Arco)
---
---For convenience, MOOSE has a CALLSIGN enumerator introduced.
---
---## AWACS
---
---You can use the class also to have an AWACS orbiting overhead the carrier. This requires to add the #RECOVERYTANKER.SetAWACS(*switch*, *eplrs*) function to the script, which sets the enroute tasks AWACS 
---as soon as the aircraft enters its pattern. Note that the EPLRS data link is enabled by default. To disable it, the second parameter *eplrs* must be set to *false*.
---
---A simple script could look like this:
---
---    -- E-2D at USS Stennis spawning in air.
---    local awacsStennis=RECOVERYTANKER:New("USS Stennis", "E2D Group")
---    
---    -- Custom settings:
---    awacsStennis:SetAWACS()
---    awacsStennis:SetCallsign(CALLSIGN.AWACS.Wizard, 1)
---    awacsStennis:SetTakeoffAir()
---    awacsStennis:SetAltitude(20000)
---    awacsStennis:SetRadio(262)
---    awacsStennis:SetTACAN(2, "WIZ")
---    
---    -- Start AWACS.
---    awacsStennis:Start()
---
---# Finite State Machine
---
---The implementation uses a Finite State Machine (FSM). This allows the mission designer to hook in to certain events.
---
---   * #RECOVERYTANKER.Start: This event starts the FMS process and initialized parameters and spawns the tanker. DCS event handling is started.
---   * #RECOVERYTANKER.Status: This event is called in regular intervals (~60 seconds) and checks the status of the tanker and carrier. It triggers other events if necessary.
---   * #RECOVERYTANKER.PatternUpdate: This event commands the tanker to update its pattern
---   * #RECOVERYTANKER.RTB: This events sends the tanker to its home base (usually the carrier). This is called once the tanker runs low on gas.
---   * #RECOVERYTANKER.RefuelStart: This event is called when a tanker starts to refuel another unit.
---   * #RECOVERYTANKER.RefuelStop: This event is called when a tanker stopped to refuel another unit.
---   * #RECOVERYTANKER.Run: This event is called when the tanker resumes normal operations, e.g. after refueling stopped or tanker finished refueling.
---   * #RECOVERYTANKER.Stop: This event stops the FSM by unhandling DCS events.
---
---The mission designer can capture these events by RECOVERYTANKER.OnAfter*Eventname* functions, e.g. #RECOVERYTANKER.OnAfterPatternUpdate.
---
---# Debugging
---
---In case you have problems, it is always a good idea to have a look at your DCS log file. You find it in your "Saved Games" folder, so for example in
---    C:\Users\<yourname>\Saved Games\DCS\Logs\dcs.log
---All output concerning the #RECOVERYTANKER class should have the string "RECOVERYTANKER" in the corresponding line.
---Searching for lines that contain the string "error" or "nil" can also give you a hint what's wrong.
---
---The verbosity of the output can be increased by adding the following lines to your script:
---
---    BASE:TraceOnOff(true)
---    BASE:TraceLevel(1)
---    BASE:TraceClass("RECOVERYTANKER")
---
---To get even more output you can increase the trace level to 2 or even 3, c.f. Core.Base#BASE for more details.
---
---## Debug Mode
---
---You have the option to enable the debug mode for this class via the #RECOVERYTANKER.SetDebugModeON function.
---If enabled, text messages about the tanker status will be displayed on screen and marks of the pattern created on the F10 map.
---RECOVERYTANKER class.
---@class RECOVERYTANKER : FSM
---@field ClassName string Name of the class.
---@field Debug boolean Debug mode.
---@field Dupdate number Pattern update when carrier changes its position by more than this distance (meters).
---@field Hupdate number Pattern update when carrier changes its heading by more than this number (degrees).
---@field RadioFreq number Radio frequency in MHz of the tanker. Default 251 MHz.
---@field RadioModu string Radio modulation "AM" or "FM". Default "AM".
---@field TACANchannel number TACAN channel. Default 1.
---@field TACANmode string TACAN mode, i.e. "X" or "Y". Default "Y". Use only "Y" for AA TACAN stations!
---@field TACANmorse string TACAN morse code. Three letters identifying the TACAN station. Default "TKR".
---@field TACANon boolean If true, TACAN is automatically activated. If false, TACAN is disabled.
---@field Tupdate number Last time the pattern was updated.
---@field private airbase AIRBASE The home airbase object of the tanker. Normally the aircraft carrier.
---@field private alias string Alias of the spawn group.
---@field private altitude number Tanker orbit pattern altitude.
---@field private awacs boolean If true, the groups gets the enroute task AWACS instead of tanker.
---@field private beacon BEACON Tanker TACAN beacon.
---@field private callsignname number Number for the callsign name.
---@field private callsignnumber number Number of the callsign name.
---@field private carrier UNIT The carrier the tanker is attached to.
---@field private carriertype string Carrier type.
---@field private dTupdate number Minimum time interval in seconds before the next pattern update can happen.
---@field private distBow number Race-track distance bow. distBow is >0.
---@field private distStern number Race-track distance astern. distStern is <0.
---@field private eplrs boolean If true, enable data link, e.g. if used as AWACS.
---@field private lid string Log debug id text.
---@field private lowfuel number Low fuel threshold in percent.
---@field private modex string Tail number of the tanker.
---@field private orientation Vec3 Orientation of the carrier. Used to monitor changes and update the pattern if heading changes significantly.
---@field private orientlast Vec3 Orientation of the carrier for checking if carrier is currently turning.
---@field private position COORDINATE Position of carrier. Used to monitor if carrier significantly changed its position and then update the tanker pattern.
---@field private recovery boolean If true, tanker will recover using the AIRBOSS marshal pattern.
---@field private respawn boolean If true, tanker be respawned (default). If false, no respawning will happen.
---@field private respawninair boolean If true, tanker will always be respawned in air. This has no impact on the initial spawn setting.
---@field private speed number Tanker speed when flying pattern.
---@field private takeoff number Takeoff type (cold, hot, air).
---@field private tanker GROUP Tanker group.
---@field private tankergroupname string Name of the late activated tanker template group.
---@field private terminaltype number Terminal type of used parking spots on airbases.
---@field private uid number Unique ID of this tanker.
---@field private uncontrolledac boolean If true, use and uncontrolled tanker group already present in the mission.
---@field private unlimitedfuel boolean If true, the tanker will have unlimited fuel.
---@field private version string Class version.
RECOVERYTANKER = {}

---Alias of tanker spawn group.
---
------
---@param self RECOVERYTANKER 
---@return string #Alias of the tanker. 
function RECOVERYTANKER:GetAlias() end

---Get unit name of the spawned tanker.
---
------
---@param self RECOVERYTANKER 
---@return string #Name of the tanker unit or nil if it does not exist. 
function RECOVERYTANKER:GetUnitName() end

---Check if tanker is currently refueling another aircraft.
---
------
---@param self RECOVERYTANKER 
---@return boolean #If true, tanker is refueling. 
function RECOVERYTANKER:IsRefueling() end

---Check if tanker has returned to base.
---
------
---@param self RECOVERYTANKER 
---@return boolean #If true, tanker has returned to base. 
function RECOVERYTANKER:IsReturned() end

---Check if tanker is currently returning to base.
---
------
---@param self RECOVERYTANKER 
---@return boolean #If true, tanker is returning to base. 
function RECOVERYTANKER:IsReturning() end

---Check if tanker is currently operating.
---
------
---@param self RECOVERYTANKER 
---@return boolean #If true, tanker is operating. 
function RECOVERYTANKER:IsRunning() end

---Check if FMS was stopped.
---
------
---@param self RECOVERYTANKER 
---@return boolean #If true, is stopped. 
function RECOVERYTANKER:IsStopped() end

---Create new RECOVERYTANKER object.
---
------
---@param self RECOVERYTANKER 
---@param carrierunit UNIT Carrier unit.
---@param tankergroupname string Name of the late activated tanker aircraft template group.
---@return RECOVERYTANKER #RECOVERYTANKER object.
function RECOVERYTANKER:New(carrierunit, tankergroupname) end

---On after "PatternEvent" event user function.
---Called when a the pattern of the tanker is updated.
---
------
---@param self RECOVERYTANKER 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function RECOVERYTANKER:OnAfterPatternUpdate(From, Event, To) end

---On after "RTB" event user function.
---Called when a the the tanker returns to its home base.
---
------
---@param self RECOVERYTANKER 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param airbase AIRBASE The airbase where the tanker should return to.
function RECOVERYTANKER:OnAfterRTB(From, Event, To, airbase) end

---On after "RefuelStart" event user function.
---Called when a the the tanker started to refuel another unit.
---
------
---@param self RECOVERYTANKER 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param receiver UNIT Unit receiving fuel from the tanker.
function RECOVERYTANKER:OnAfterRefuelStart(From, Event, To, receiver) end

---On after "RefuelStop" event user function.
---Called when a the the tanker stopped to refuel another unit.
---
------
---@param self RECOVERYTANKER 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param receiver UNIT Unit that received fuel from the tanker.
function RECOVERYTANKER:OnAfterRefuelStop(From, Event, To, receiver) end

---On after "Returned" event user function.
---Called when a the the tanker has landed at an airbase.
---
------
---@param self RECOVERYTANKER 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param airbase AIRBASE The airbase the tanker has landed.
function RECOVERYTANKER:OnAfterReturned(From, Event, To, airbase) end

---On after "Start" event function.
---Called when FSM is started.
---
------
---@param self RECOVERYTANKER 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function RECOVERYTANKER:OnAfterStart(From, Event, To) end

---Event handler for engine shutdown of recovery tanker.
---Respawn tanker group once it landed because it was out of fuel.
---
------
---@param self RECOVERYTANKER 
---@param EventData EVENTDATA Event data.
function RECOVERYTANKER:OnEventEngineShutdown(EventData) end

---Event handler for landing of recovery tanker.
---
------
---@param self RECOVERYTANKER 
---@param EventData EVENTDATA Event data.
function RECOVERYTANKER:OnEventLand(EventData) end

---Triggers the FSM event "PatternUpdate" that updates the pattern of the tanker wrt to the carrier position.
---
------
---@param self RECOVERYTANKER 
function RECOVERYTANKER:PatternUpdate() end

---Triggers the FSM event "RTB" that sends the tanker home.
---
------
---@param self RECOVERYTANKER 
---@param airbase AIRBASE The airbase where the tanker should return to.
function RECOVERYTANKER:RTB(airbase) end

---Triggers the FSM event "RefuelStart" when the tanker starts refueling another aircraft.
---
------
---@param self RECOVERYTANKER 
---@param receiver UNIT Unit receiving fuel from the tanker.
function RECOVERYTANKER:RefuelStart(receiver) end

---Triggers the FSM event "RefuelStop" when the tanker stops refueling another aircraft.
---
------
---@param self RECOVERYTANKER 
---@param receiver UNIT Unit stoped receiving fuel from the tanker.
function RECOVERYTANKER:RefuelStop(receiver) end

---Triggers the FSM event "Returned" after the tanker has landed.
---
------
---@param self RECOVERYTANKER 
---@param airbase AIRBASE The airbase the tanker has landed.
function RECOVERYTANKER:Returned(airbase) end

---Triggers the FSM event "Run".
---Simply puts the group into "Running" state.
---
------
---@param self RECOVERYTANKER 
function RECOVERYTANKER:Run() end

---Set that the group takes the role of an AWACS instead of a refueling tanker.
---
------
---@param self RECOVERYTANKER 
---@param switch boolean If true or nil, set role AWACS.
---@param eplrs boolean If true or nil, enable EPLRS. If false, EPLRS will be off.
---@return RECOVERYTANKER #self
function RECOVERYTANKER:SetAWACS(switch, eplrs) end

---Set orbit pattern altitude of the tanker.
---
------
---@param self RECOVERYTANKER 
---@param altitude number Tanker altitude in feet. Default 6000 ft.
---@return RECOVERYTANKER #self
function RECOVERYTANKER:SetAltitude(altitude) end

---Set callsign of the tanker group.
---
------
---@param self RECOVERYTANKER 
---@param callsignname number Number
---@param callsignnumber number Number
---@return RECOVERYTANKER #self
function RECOVERYTANKER:SetCallsign(callsignname, callsignnumber) end

---Deactivate debug mode.
---This is also the default setting.
---
------
---@param self RECOVERYTANKER 
---@return RECOVERYTANKER #self
function RECOVERYTANKER:SetDebugModeOFF() end

---Activate debug mode.
---Marks of pattern on F10 map and debug messages displayed on screen.
---
------
---@param self RECOVERYTANKER 
---@return RECOVERYTANKER #self
function RECOVERYTANKER:SetDebugModeON() end

---Set home airbase of the tanker.
---This is the airbase where the tanker will go when it is out of fuel.
---
------
---@param self RECOVERYTANKER 
---@param airbase AIRBASE The home airbase. Can be the airbase name or a Moose AIRBASE object.
---@param terminaltype? number (Optional) The terminal type of parking spots used for spawning at airbases. Default AIRBASE.TerminalType.OpenMedOrBig.
---@return RECOVERYTANKER #self
function RECOVERYTANKER:SetHomeBase(airbase, terminaltype) end

---Set low fuel state of tanker.
---When fuel is below this threshold, the tanker will RTB or be respawned if takeoff type is in air.
---
------
---@param self RECOVERYTANKER 
---@param fuelthreshold number Low fuel threshold in percent. Default 10 % of max fuel.
---@return RECOVERYTANKER #self
function RECOVERYTANKER:SetLowFuelThreshold(fuelthreshold) end

---Set modex (tail number) of the tanker.
---
------
---@param self RECOVERYTANKER 
---@param modex number Tail number.
---@return RECOVERYTANKER #self
function RECOVERYTANKER:SetModex(modex) end

---Set pattern update distance threshold.
---Tanker will update its pattern when the carrier changes its position by more than this distance.
---
------
---@param self RECOVERYTANKER 
---@param distancechange number Distance threshold in NM. Default 5 NM (=9.62 km).
---@return RECOVERYTANKER #self
function RECOVERYTANKER:SetPatternUpdateDistance(distancechange) end

---Set pattern update heading threshold.
---Tanker will update its pattern when the carrier changes its heading by more than this value.
---
------
---@param self RECOVERYTANKER 
---@param headingchange number Heading threshold in degrees. Default 5 degrees.
---@return RECOVERYTANKER #self
function RECOVERYTANKER:SetPatternUpdateHeading(headingchange) end

---Set minimum pattern update interval.
---After a pattern update this time interval has to pass before the next update is allowed.
---
------
---@param self RECOVERYTANKER 
---@param interval number Min interval in minutes. Default is 10 minutes.
---@return RECOVERYTANKER #self
function RECOVERYTANKER:SetPatternUpdateInterval(interval) end

---Set race-track distances.
---
------
---@param self RECOVERYTANKER 
---@param distbow number Distance [NM] in front of the carrier. Default 10 NM.
---@param diststern number Distance [NM] behind the carrier. Default 4 NM.
---@return RECOVERYTANKER #self
function RECOVERYTANKER:SetRacetrackDistances(distbow, diststern) end

---Set radio frequency and optionally modulation of the tanker.
---
------
---@param self RECOVERYTANKER 
---@param frequency number Radio frequency in MHz. Default 251 MHz.
---@param modulation string Radio modulation, either "AM" or "FM". Default "AM".
---@return RECOVERYTANKER #self
function RECOVERYTANKER:SetRadio(frequency, modulation) end

---Activate recovery by the AIRBOSS class.
---Tanker will get a Marshal stack and perform a CASE I, II or III recovery when RTB.
---
------
---@param self RECOVERYTANKER 
---@param switch boolean If true or nil, recovery is done by AIRBOSS.
---@return RECOVERYTANKER #self
function RECOVERYTANKER:SetRecoveryAirboss(switch) end

---Tanker will be respawned in air, even it was initially spawned on the carrier.
---So only the first spawn will be on the carrier while all subsequent spawns will happen in air.
---This allows for undisrupted operations and less problems on the carrier deck.
---
------
---@param self RECOVERYTANKER 
---@return RECOVERYTANKER #self
function RECOVERYTANKER:SetRespawnInAir() end

---Disable respawning of tanker.
---
------
---@param self RECOVERYTANKER 
---@return RECOVERYTANKER #self
function RECOVERYTANKER:SetRespawnOff() end

---Enable respawning of tanker.
---Note that this is the default behaviour.
---
------
---@param self RECOVERYTANKER 
---@return RECOVERYTANKER #self
function RECOVERYTANKER:SetRespawnOn() end

---Set whether tanker shall be respawned or not.
---
------
---@param self RECOVERYTANKER 
---@param switch boolean If true (or nil), tanker will be respawned. If false, tanker will not be respawned. 
---@return RECOVERYTANKER #self
function RECOVERYTANKER:SetRespawnOnOff(switch) end

---Set the speed the tanker flys in its orbit pattern.
---
------
---@param self RECOVERYTANKER 
---@param speed number True air speed (TAS) in knots. Default 274 knots, which results in ~250 KIAS.
---@return RECOVERYTANKER #self
function RECOVERYTANKER:SetSpeed(speed) end

---Set TACAN channel of tanker.
---Note that mode is automatically set to "Y" for AA TACAN since only that works.
---
------
---@param self RECOVERYTANKER 
---@param channel number TACAN channel. Default 1.
---@param morse string TACAN morse code identifier. Three letters. Default "TKR".
---@param mode string TACAN mode, which can be either "Y" (default) or "X".
---@return RECOVERYTANKER #self
function RECOVERYTANKER:SetTACAN(channel, morse, mode) end

---Disable automatic TACAN activation.
---
------
---@param self RECOVERYTANKER 
---@return RECOVERYTANKER #self 
function RECOVERYTANKER:SetTACANoff() end

---Set takeoff type.
---
------
---@param self RECOVERYTANKER 
---@param takeofftype number Takeoff type.
---@return RECOVERYTANKER #self
function RECOVERYTANKER:SetTakeoff(takeofftype) end

---Set takeoff in air at the defined pattern altitude and ~10 NM astern the carrier.
---
------
---@param self RECOVERYTANKER 
---@return RECOVERYTANKER #self
function RECOVERYTANKER:SetTakeoffAir() end

---Set takeoff with engines off (cold).
---
------
---@param self RECOVERYTANKER 
---@return RECOVERYTANKER #self
function RECOVERYTANKER:SetTakeoffCold() end

---Set takeoff with engines running (hot).
---
------
---@param self RECOVERYTANKER 
---@return RECOVERYTANKER #self
function RECOVERYTANKER:SetTakeoffHot() end

---Set the tanker to have unlimited fuel.
---
------
---@param self RECOVERYTANKER 
---@param OnOff boolean If true, the tanker will have unlimited fuel.
---@return RECOVERYTANKER #self
function RECOVERYTANKER:SetUnlimitedFuel(OnOff) end

---Use an uncontrolled aircraft already present in the mission rather than spawning a new tanker as initial recovery thanker.
---This can be useful when interfaced with, e.g., a MOOSE Functional.Warehouse#WAREHOUSE.
---The group name is the one specified in the #RECOVERYTANKER.New function.
---
------
---@param self RECOVERYTANKER 
---@return RECOVERYTANKER #self
function RECOVERYTANKER:SetUseUncontrolledAircraft() end

---Triggers the FSM event "Start" that starts the recovery tanker.
---Initializes parameters and starts event handlers.
---
------
---@param self RECOVERYTANKER 
function RECOVERYTANKER:Start() end

---Triggers the FSM event "Status" that updates the tanker status.
---
------
---@param self RECOVERYTANKER 
function RECOVERYTANKER:Status() end

---Triggers the FSM event "Stop" that stops the recovery tanker.
---Event handlers are stopped.
---
------
---@param self RECOVERYTANKER 
function RECOVERYTANKER:Stop() end

---Activate TACAN of tanker.
---
------
---@param self RECOVERYTANKER 
---@param delay number Delay in seconds.
function RECOVERYTANKER:_ActivateTACAN(delay) end

---Check if heading or position have changed significantly.
---
------
---@param self RECOVERYTANKER 
---@param dt number Time since last update in seconds.
---@return boolean #If true, heading and/or position have changed more than 5 degrees or 10 km, respectively.
function RECOVERYTANKER:_CheckPatternUpdate(dt) end

---Task function to
---
------
---@param self RECOVERYTANKER 
function RECOVERYTANKER:_InitPatternTaskFunction() end

---Init waypoint after spawn.
---Tanker is first guided to a position astern the carrier and starts its racetrack pattern from there.
---
------
---@param self RECOVERYTANKER 
---@param dist number Distance [NM] of initial waypoint astern carrier. Default 8 NM.
---@param delay number Delay before routing in seconds. Default 1 second.
function RECOVERYTANKER:_InitRoute(dist, delay) end

---A unit crashed or died.
---
------
---@param self RECOVERYTANKER 
---@param EventData EVENTDATA Event data.
function RECOVERYTANKER:_OnEventCrashOrDead(EventData) end

---Self made race track pattern.
---Not working as desired, since tanker changes course too rapidly after each waypoint.
---
------
---@param self RECOVERYTANKER 
---@return table #Table of pattern waypoints.
function RECOVERYTANKER:_Pattern() end

---Event handler for refueling started.
---
------
---@param self RECOVERYTANKER 
---@param EventData EVENTDATA Event data.
function RECOVERYTANKER:_RefuelingStart(EventData) end

---Event handler for refueling stopped.
---
------
---@param self RECOVERYTANKER 
---@param EventData EVENTDATA Event data.
function RECOVERYTANKER:_RefuelingStop(EventData) end

---Triggers the delayed FSM event "PatternUpdate" that updates the pattern of the tanker wrt to the carrier position.
---
------
---@param self RECOVERYTANKER 
---@param delay number Delay in seconds.
function RECOVERYTANKER:__PatternUpdate(delay) end

---Triggers the FSM event "RTB" that sends the tanker home after a delay.
---
------
---@param self RECOVERYTANKER 
---@param delay number Delay in seconds.
---@param airbase AIRBASE The airbase where the tanker should return to.
function RECOVERYTANKER:__RTB(delay, airbase) end

---Triggers the delayed FSM event "Returned" after the tanker has landed.
---
------
---@param self RECOVERYTANKER 
---@param delay number Delay in seconds.
---@param airbase AIRBASE The airbase the tanker has landed.
function RECOVERYTANKER:__Returned(delay, airbase) end

---Triggers delayed the FSM event "Run".
---Simply puts the group into "Running" state.
---
------
---@param self RECOVERYTANKER 
---@param delay number Delay in seconds.
function RECOVERYTANKER:__Run(delay) end

---Triggers the FSM event "Start" that starts the recovery tanker after a delay.
---Initializes parameters and starts event handlers.
---
------
---@param self RECOVERYTANKER 
---@param delay number Delay in seconds.
function RECOVERYTANKER:__Start(delay) end

---Triggers the delayed FSM event "Status" that updates the tanker status.
---
------
---@param self RECOVERYTANKER 
---@param delay number Delay in seconds.
function RECOVERYTANKER:__Status(delay) end

---Triggers the FSM event "Stop" that stops the recovery tanker after a delay.
---Event handlers are stopped.
---
------
---@param self RECOVERYTANKER 
---@param delay number Delay in seconds.
function RECOVERYTANKER:__Stop(delay) end

---On after "PatternUpdate" event.
---Updates the racetrack pattern of the tanker wrt the carrier position.
---
------
---@param self RECOVERYTANKER 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function RECOVERYTANKER:onafterPatternUpdate(From, Event, To) end

---On after "RTB" event.
---Send tanker back to carrier.
---
------
---@param self RECOVERYTANKER 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param airbase AIRBASE The airbase where the tanker should return to.
---@private
function RECOVERYTANKER:onafterRTB(From, Event, To, airbase) end

---On after Returned event.
---The tanker has landed.
---
------
---@param self RECOVERYTANKER 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param airbase AIRBASE The base at which the tanker landed.
---@private
function RECOVERYTANKER:onafterReturned(From, Event, To, airbase) end

---On after Start event.
---Starts the warehouse. Addes event handlers and schedules status updates of reqests and queue.
---
------
---@param self RECOVERYTANKER 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function RECOVERYTANKER:onafterStart(From, Event, To) end

---On after Status event.
---Checks player status.
---
------
---@param self RECOVERYTANKER 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function RECOVERYTANKER:onafterStatus(From, Event, To) end

---On after Stop event.
---Unhandle events and stop status updates.
---
------
---@param self RECOVERYTANKER 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function RECOVERYTANKER:onafterStop(From, Event, To) end



