---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/OPS_AirWing.png" width="100%">
---
---**Ops** - Airwing Warehouse.
---
---**Main Features:**
---
---   * Manage squadrons.
---   * Launch A2A and A2G missions (AUFTRAG)
---
---
---===
---
---## Example Missions:
---
---Demo missions can be found on [github](https://github.com/FlightControl-Master/MOOSE_MISSIONS/tree/develop/Ops/Airwing).
---
---===
---
---### Author: **funkyfranky**
---
---===
---*I fly because it releases my mind from the tyranny of petty things.* -- Antoine de Saint-Exupery
---
---===
---
---# The AIRWING Concept
---
---An AIRWING consists of multiple SQUADRONS.
---These squadrons "live" in a WAREHOUSE, i.e. a physical structure that is connected to an airbase (airdrome, FRAP or ship).
---For an airwing to be operational, it needs airframes, weapons/fuel and an airbase.
---
---# Create an Airwing
---
---## Constructing the Airwing
---
---    airwing=AIRWING:New("Warehouse Batumi", "8th Fighter Wing")
---    airwing:Start()
---
---The first parameter specified the warehouse, i.e. the static building housing the airwing (or the name of the aircraft carrier). The second parameter is optional
---and sets an alias.
---
---## Adding Squadrons
---
---At this point the airwing does not have any assets (aircraft). In order to add these, one needs to first define SQUADRONS.
---
---    VFA151=SQUADRON:New("F-14 Group", 8, "VFA-151 (Vigilantes)")
---    VFA151:AddMissionCapability({AUFTRAG.Type.GCICAP, AUFTRAG.Type.INTERCEPT})
---
---    airwing:AddSquadron(VFA151)
---
---This adds eight Tomcat groups beloning to VFA-151 to the airwing. This squadron has the ability to perform combat air patrols and intercepts.
---
---## Adding Payloads
---
---Adding pure airframes is not enough. The aircraft also need weapons (and fuel) for certain missions. These must be given to the airwing from template groups
---defined in the Mission Editor.
---
---    -- F-14 payloads for CAP and INTERCEPT. Phoenix are first, sparrows are second choice.
---    airwing:NewPayload(GROUP:FindByName("F-14 Payload AIM-54C"), 2, {AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.GCICAP}, 80)
---    airwing:NewPayload(GROUP:FindByName("F-14 Payload AIM-7M"), 20, {AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.GCICAP})
---
---This will add two AIM-54C and 20 AIM-7M payloads.
---
---If the airwing gets an intercept or patrol mission assigned, it will first use the AIM-54s. Once these are consumed, the AIM-7s are attached to the aircraft.
---
---When an airwing does not have a payload for a certain mission type, the mission cannot be carried out.
---
---You can set the number of payloads to "unlimited" by setting its quantity to -1.
---
---# Adding Missions
---
---Various mission types can be added easily via the AUFTRAG class.
---
---Once you created an AUFTRAG you can add it to the AIRWING with the :AddMission(mission) function.
---
---This mission will be put into the AIRWING queue. Once the mission start time is reached and all resources (airframes and payloads) are available, the mission is started.
---If the mission stop time is over (and the mission is not finished), it will be cancelled and removed from the queue. This applies also to mission that were not even
---started.
---AIRWING class.
---@class AIRWING : LEGION
---@field ClassName string Name of the class.
---@field ConnectedOpsAwacs NOTYPE 
---@field UseConnectedOpsAwacs boolean 
---@field private airboss AIRBOSS Airboss attached to this wing.
---@field private capFormation number If capOptionPatrolRaceTrack is true, set the formation, also.
---@field private capOptionPatrolRaceTrack boolean Use closer patrol race track or standard orbit auftrag.
---@field private capOptionVaryEndTime number If set, vary mission start time for CAP missions generated random between capOptionVaryStartTime and capOptionVaryEndTime
---@field private capOptionVaryStartTime number If set, vary mission start time for CAP missions generated random between capOptionVaryStartTime and capOptionVaryEndTime
---@field private despawnAfterHolding boolean Aircraft are despawned after holding.
---@field private despawnAfterLanding boolean Aircraft are despawned after landing.
---@field private lid string Class id string for output to DCS log file.
---@field private markpoints boolean Display markers on the F10 map.
---@field private menu table Table of menu items.
---@field private missionqueue table Mission queue table.
---@field private nflightsAWACS number Number of AWACS flights constantly in the air.
---@field private nflightsCAP number Number of CAP flights constantly in the air.
---@field private nflightsRecon number Number of Recon flights constantly in the air.
---@field private nflightsRecoveryTanker number 
---@field private nflightsRescueHelo number Number of Rescue helo flights constantly in the air.
---@field private nflightsTANKERboom number Number of TANKER flights with BOOM constantly in the air.
---@field private nflightsTANKERprobe number Number of TANKER flights with PROBE constantly in the air.
---@field private payloadcounter number Running index of payloads.
---@field private payloads table Playloads for specific aircraft and mission types.
---@field private pointsAWACS table Table of AWACS points.
---@field private pointsCAP table Table of CAP points.
---@field private pointsRecon table Table of RECON points.
---@field private pointsTANKER table Table of Tanker points.
---@field private recoverytanker RECOVERYTANKER The recoverytanker.
---@field private rescuehelo RESCUEHELO The rescue helo.
---@field private squadrons table Table of squadrons.
---@field private takeoffType string Take of type.
---@field private verbose number Verbosity of output.
---@field private version string AIRWING class version.
---@field private zonesetAWACS SET_ZONE Set of AWACS zones.
---@field private zonesetCAP SET_ZONE Set of CAP zones.
---@field private zonesetRECON SET_ZONE Set of RECON zones. 
---@field private zonesetTANKER SET_ZONE Set of TANKER zones.
AIRWING = {}

---Add asset group(s) to squadron.
---
------
---@param self AIRWING 
---@param Squadron SQUADRON The squadron object.
---@param Nassets number Number of asset groups to add.
---@return AIRWING #self
function AIRWING:AddAssetToSquadron(Squadron, Nassets) end

---Add a patrol Point for AWACS missions.
---
------
---@param self AIRWING 
---@param Coordinate COORDINATE Coordinate of the patrol point.
---@param Altitude number Orbit altitude in feet.
---@param Speed number Orbit speed in knots.
---@param Heading number Heading in degrees.
---@param LegLength number Length of race-track orbit in NM.
---@return AIRWING #self
function AIRWING:AddPatrolPointAWACS(Coordinate, Altitude, Speed, Heading, LegLength) end

---Add a patrol Point for CAP missions.
---
------
---@param self AIRWING 
---@param Coordinate COORDINATE Coordinate of the patrol point.
---@param Altitude number Orbit altitude in feet.
---@param Speed number Orbit speed in knots.
---@param Heading number Heading in degrees.
---@param LegLength number Length of race-track orbit in NM.
---@return AIRWING #self
function AIRWING:AddPatrolPointCAP(Coordinate, Altitude, Speed, Heading, LegLength) end

---Add a patrol Point for RECON missions.
---
------
---@param self AIRWING 
---@param Coordinate COORDINATE Coordinate of the patrol point.
---@param Altitude number Orbit altitude in feet.
---@param Speed number Orbit speed in knots.
---@param Heading number Heading in degrees.
---@param LegLength number Length of race-track orbit in NM.
---@return AIRWING #self
function AIRWING:AddPatrolPointRecon(Coordinate, Altitude, Speed, Heading, LegLength) end

---Add a patrol Point for TANKER missions.
---
------
---@param self AIRWING 
---@param Coordinate COORDINATE Coordinate of the patrol point.
---@param Altitude number Orbit altitude in feet.
---@param Speed number Orbit speed in knots.
---@param Heading number Heading in degrees.
---@param LegLength number Length of race-track orbit in NM.
---@param RefuelSystem number Set refueling system of tanker: 0=boom, 1=probe. Default any (=nil).
---@return AIRWING #self
function AIRWING:AddPatrolPointTANKER(Coordinate, Altitude, Speed, Heading, LegLength, RefuelSystem) end

---Add a mission capability to an existing payload.
---
------
---@param self AIRWING 
---@param Payload AIRWING.Payload The payload table to which the capability should be added.
---@param MissionTypes table Mission types to be added.
---@param Performance number A number between 0 (worst) and 100 (best) to describe the performance of the loadout for the given mission types. Default is 50.
---@return AIRWING #self
function AIRWING:AddPayloadCapability(Payload, MissionTypes, Performance) end

---Add a squadron to the air wing.
---
------
---@param self AIRWING 
---@param Squadron SQUADRON The squadron object.
---@return AIRWING #self
function AIRWING:AddSquadron(Squadron) end

---Check how many AWACS missions are assigned and add number of missing missions.
---
------
---@param self AIRWING 
---@return AIRWING #self
function AIRWING:CheckAWACS() end

---Check how many CAP missions are assigned and add number of missing missions.
---
------
---@param self AIRWING 
---@return AIRWING #self
function AIRWING:CheckCAP() end

---Check how many RECON missions are assigned and add number of missing missions.
---
------
---@param self AIRWING 
---@return AIRWING #self
function AIRWING:CheckRECON() end

---Check how many Rescue helos are currently in the air.
---
------
---@param self AIRWING 
---@return AIRWING #self
function AIRWING:CheckRescuhelo() end

---Check how many TANKER missions are assigned and add number of missing missions.
---
------
---@param self AIRWING 
---@return AIRWING #self
function AIRWING:CheckTANKER() end

---Count payloads in stock.
---
------
---@param self AIRWING 
---@param MissionTypes table Types on mission to be checked. Default *all* possible types `AUFTRAG.Type`.
---@param UnitTypes table Types of units.
---@param Payloads table Specific payloads to be counted only.
---@return number #Count of available payloads in stock.
function AIRWING:CountPayloadsInStock(MissionTypes, UnitTypes, Payloads) end

---Fetch a payload from the airwing resources for a given unit and mission type.
---The payload with the highest priority is preferred.
---
------
---@param self AIRWING 
---@param UnitType string The type of the unit.
---@param MissionType string The mission type.
---@param Payloads table Specific payloads only to be considered.
---@return AIRWING.Payload #Payload table or *nil*.
function AIRWING:FetchPayloadFromStock(UnitType, MissionType, Payloads) end

---Triggers the FSM event "FlightOnMission".
---
------
---@param self AIRWING 
---@param FlightGroup FLIGHTGROUP The FLIGHTGROUP on mission.
---@param Mission AUFTRAG The mission.
function AIRWING:FlightOnMission(FlightGroup, Mission) end

---Get amount of payloads available for a given playload.
---
------
---@param self AIRWING 
---@param Payload AIRWING.Payload The payload table created by the `:NewPayload` function.
---@return number #Number of payloads available. Unlimited payloads will return -1.
function AIRWING:GetPayloadAmount(Payload) end

---Get capabilities of a given playload.
---
------
---@param self AIRWING 
---@param Payload AIRWING.Payload The payload data table.
---@return table #Capabilities.
function AIRWING:GetPayloadCapabilities(Payload) end

---Get mission types a payload can perform.
---
------
---@param self AIRWING 
---@param Payload AIRWING.Payload The payload table.
---@return table #Mission types.
function AIRWING:GetPayloadMissionTypes(Payload) end

---Get payload performance for a given type of misson type.
---
------
---@param self AIRWING 
---@param Payload AIRWING.Payload The payload table.
---@param MissionType string Type of mission.
---@return number #Performance or -1.
function AIRWING:GetPayloadPeformance(Payload, MissionType) end

---Get squadron by name.
---
------
---@param self AIRWING 
---@param SquadronName string Name of the squadron, e.g. "VFA-37".
---@return SQUADRON #The squadron object.
function AIRWING:GetSquadron(SquadronName) end

---Get squadron of an asset.
---
------
---@param self AIRWING 
---@param Asset WAREHOUSE.Assetitem The squadron asset.
---@return SQUADRON #The squadron object.
function AIRWING:GetSquadronOfAsset(Asset) end

---Check how many AWACS missions are assigned and add number of missing missions.
---
------
---@param self AIRWING 
---@param flightgroup FLIGHTGROUP The flightgroup.
---@return WAREHOUSE.Assetitem #The tanker asset.
function AIRWING:GetTankerForFlight(flightgroup) end

---Increase or decrease the amount of available payloads.
---Unlimited playloads first need to be set to a limited number with the `SetPayloadAmount` function.
---
------
---@param self AIRWING 
---@param Payload AIRWING.Payload The payload table created by the `:NewPayload` function.
---@param N number Number of payloads to be added. Use negative number to decrease amount. Default 1.
---@return AIRWING #self
function AIRWING:IncreasePayloadAmount(Payload, N) end

---Create a new AIRWING class object for a specific aircraft carrier unit.
---
------
---@param self AIRWING 
---@param warehousename string Name of the warehouse static or unit object representing the warehouse.
---@param airwingname string Name of the air wing, e.g. "AIRWING-8".
---@return AIRWING #self
function AIRWING:New(warehousename, airwingname) end

---Create a new generic patrol point.
---
------
---@param self AIRWING 
---@param Type string Patrol point type, e.g. "CAP" or "AWACS". Default "Unknown".
---@param Coordinate COORDINATE Coordinate of the patrol point. Default 10-15 NM away from the location of the airwing.
---@param Altitude number Orbit altitude in feet. Default random between Angels 10 and 20.
---@param Heading number Heading in degrees. Default random (0, 360] degrees.
---@param LegLength number Length of race-track orbit in NM. Default 15 NM.
---@param Speed number Orbit speed in knots. Default 350 knots.
---@param RefuelSystem number Refueling system: 0=Boom, 1=Probe. Default nil=any.
---@return AIRWING.PatrolData #Patrol point table.
function AIRWING:NewPatrolPoint(Type, Coordinate, Altitude, Heading, LegLength, Speed, RefuelSystem) end

---Add a **new** payload to the airwing resources.
---
------
---@param self AIRWING 
---@param Unit UNIT The unit, the payload is extracted from. Can also be given as *#string* name of the unit.
---@param Npayloads number Number of payloads to add to the airwing resources. Default 99 (which should be enough for most scenarios). Set to -1 for unlimited.
---@param MissionTypes table Mission types this payload can be used for.
---@param Performance number A number between 0 (worst) and 100 (best) to describe the performance of the loadout for the given mission types. Default is 50.
---@return AIRWING.Payload #The payload table or nil if the unit does not exist.
function AIRWING:NewPayload(Unit, Npayloads, MissionTypes, Performance) end

---On after "FlightOnMission" event.
---
------
---@param self AIRWING 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param FlightGroup FLIGHTGROUP  The FLIGHTGROUP on mission.
---@param Mission AUFTRAG The mission.
function AIRWING:OnAfterFlightOnMission(From, Event, To, FlightGroup, Mission) end

---Remove asset from squadron.
---
------
---@param self AIRWING 
---@param Asset WAREHOUSE.Assetitem The squad asset.
function AIRWING:RemoveAssetFromSquadron(Asset) end

---Remove the ability to call back an Ops.AWACS#AWACS object with an FSM call "FlightOnMission(FlightGroup, Mission)".
---
------
---@param self AIRWING 
---@return AIRWING #self
function AIRWING:RemoveUsingOpsAwacs() end

---Return payload from asset back to stock.
---
------
---@param self AIRWING 
---@param asset WAREHOUSE.Assetitem The squadron asset.
function AIRWING:ReturnPayloadFromAsset(asset) end

---Set airboss of this wing.
---He/she will take care that no missions are launched if the carrier is recovering.
---
------
---@param self AIRWING 
---@param airboss AIRBOSS The AIRBOSS object.
---@return AIRWING #self
function AIRWING:SetAirboss(airboss) end

---Set CAP flight formation.
---
------
---@param self AIRWING 
---@param Formation number Formation to take, e.g. ENUMS.Formation.FixedWing.Trail.Close, also see [Hoggit Wiki](https://wiki.hoggitworld.com/view/DCS_option_formation).
---@return AIRWING #self
function AIRWING:SetCAPFormation(Formation) end

---Set CAP close race track.We'll utilize the AUFTRAG PatrolRaceTrack instead of a standard race track orbit task.
---
------
---@param self AIRWING 
---@param OnOff boolean If true, switch this on, else switch off. Off by default.
---@return AIRWING #self
function AIRWING:SetCapCloseRaceTrack(OnOff) end

---Set CAP mission start to vary randomly between Start end End seconds.
---
------
---@param self AIRWING 
---@param Start number 
---@param End number 
---@return AIRWING #self
function AIRWING:SetCapStartTimeVariation(Start, End) end

---Set despawn after holding.
---Aircraft will be despawned when they arrive at their holding position at the airbase.
---Can help to avoid DCS AI taxiing issues.
---
------
---@param self AIRWING 
---@param Switch boolean If `true` (default), activate despawn after landing.
---@return AIRWING #self
function AIRWING:SetDespawnAfterHolding(Switch) end

---Set despawn after landing.
---Aircraft will be despawned after the landing event.
---Can help to avoid DCS AI taxiing issues.
---
------
---@param self AIRWING 
---@param Switch boolean If `true` (default), activate despawn after landing.
---@return AIRWING #self
function AIRWING:SetDespawnAfterLanding(Switch) end

---Set number of AWACS flights constantly in the air.
---
------
---@param self AIRWING 
---@param n number Number of flights. Default 1.
---@return AIRWING #self
function AIRWING:SetNumberAWACS(n) end

---Set number of CAP flights constantly carried out.
---
------
---@param self AIRWING 
---@param n number Number of flights. Default 1.
---@return AIRWING #self
function AIRWING:SetNumberCAP(n) end

---Set number of RECON flights constantly in the air.
---
------
---@param self AIRWING 
---@param n number Number of flights. Default 1.
---@return AIRWING #self
function AIRWING:SetNumberRecon(n) end

---Set number of Rescue helo flights constantly in the air.
---
------
---@param self AIRWING 
---@param n number Number of flights. Default 1.
---@return AIRWING #self
function AIRWING:SetNumberRescuehelo(n) end

---Set number of TANKER flights with Boom constantly in the air.
---
------
---@param self AIRWING 
---@param Nboom number Number of flights. Default 1.
---@return AIRWING #self
function AIRWING:SetNumberTankerBoom(Nboom) end

---Set number of TANKER flights with Probe constantly in the air.
---
------
---@param self AIRWING 
---@param Nprobe number Number of flights. Default 1.
---@return AIRWING #self
function AIRWING:SetNumberTankerProbe(Nprobe) end

---Set the number of payload available.
---
------
---@param self AIRWING 
---@param Payload AIRWING.Payload The payload table created by the `:NewPayload` function.
---@param Navailable number Number of payloads available to the airwing resources. Default 99 (which should be enough for most scenarios). Set to -1 for unlimited.
---@return AIRWING #self
function AIRWING:SetPayloadAmount(Payload, Navailable) end

---Set takeoff type air.
---All assets of this squadron will be spawned in air above the airbase.
---
------
---@param self AIRWING 
---@return AIRWING #self
function AIRWING:SetTakeoffAir() end

---Set takeoff type cold (default).
---All assets of this squadron will be spawned with engines off (cold).
---
------
---@param self AIRWING 
---@return AIRWING #self
function AIRWING:SetTakeoffCold() end

---Set takeoff type hot.
---All assets of this squadron will be spawned with engines on (hot).
---
------
---@param self AIRWING 
---@return AIRWING #self
function AIRWING:SetTakeoffHot() end

---Set takeoff type.
---All assets of this airwing will be spawned with this takeoff type.
---Spawning on runways is not supported.
---
------
---@param self AIRWING 
---@param TakeoffType string Take off type: "Cold" (default) or "Hot" with engines on or "Air" for spawning in air.
---@return AIRWING #self
function AIRWING:SetTakeoffType(TakeoffType) end

---Add the ability to call back an Ops.AWACS#AWACS object with an FSM call "FlightOnMission(FlightGroup, Mission)".
---
------
---@param self AIRWING 
---@param ConnectecdAwacs AWACS 
---@return AIRWING #self
function AIRWING:SetUsingOpsAwacs(ConnectecdAwacs) end

---Set markers on the map for Patrol Points.
---
------
---@param self AIRWING 
---@param onoff boolean Set to true to switch markers on.
---@return AIRWING #self
function AIRWING:ShowPatrolPointMarkers(onoff) end

---Triggers the FSM event "Start".
---Starts the AIRWING. Initializes parameters and starts event handlers.
---
------
---@param self AIRWING 
function AIRWING:Start() end

---Update marker of the patrol point.
---
------
---@param point AIRWING.PatrolData Patrol point table.
---@param self NOTYPE 
function AIRWING.UpdatePatrolPointMarker(point, self) end

---Get patrol data.
---
------
---@param self AIRWING 
---@param PatrolPoints table Patrol data points.
---@param RefuelSystem number If provided, only return points with the specific refueling system.
---@return AIRWING.PatrolData #Patrol point data table.
function AIRWING:_GetPatrolData(PatrolPoints, RefuelSystem) end


---
------
---@param self AIRWING 
---@param point AIRWING.PatrolData Patrol point table.
---@return string #Marker text.
function AIRWING:_PatrolPointMarkerText(point) end

---Triggers the FSM event "FlightOnMission" after a delay.
---
------
---@param self AIRWING 
---@param delay number Delay in seconds.
---@param FlightGroup FLIGHTGROUP The FLIGHTGROUP on mission.
---@param Mission AUFTRAG The mission.
function AIRWING:__FlightOnMission(delay, FlightGroup, Mission) end

---Triggers the FSM event "Start" after a delay.
---Starts the AIRWING. Initializes parameters and starts event handlers.
---
------
---@param self AIRWING 
---@param delay number Delay in seconds.
function AIRWING:__Start(delay) end

---Triggers the FSM event "Stop" after a delay.
---Stops the AIRWING and all its event handlers.
---
------
---@param self AIRWING 
---@param delay number Delay in seconds.
function AIRWING:__Stop(delay) end

---On after "FlightOnMission".
---
------
---@param self AIRWING 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param FlightGroup FLIGHTGROUP Ops flight group on mission.
---@param Mission AUFTRAG The requested mission.
---@private
function AIRWING:onafterFlightOnMission(From, Event, To, FlightGroup, Mission) end

---Start AIRWING FSM.
---
------
---@param self AIRWING 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@private
function AIRWING:onafterStart(From, Event, To) end

---Update status.
---
------
---@param self AIRWING 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@private
function AIRWING:onafterStatus(From, Event, To) end


---AWACS zone.
---@class AIRWING.AwacsZone 
---@field private altitude number Altitude in feet.
---@field private heading number Heading in degrees.
---@field private leg number Leg length in NM.
---@field private marker MARKER F10 marker.
---@field private mission AUFTRAG Mission assigned.
---@field private speed number Speed in knots.
---@field private zone ZONE Zone.
AIRWING.AwacsZone = {}


---Patrol data.
---@class AIRWING.PatrolData 
---@field private altitude number Altitude in feet.
---@field private coord COORDINATE Patrol coordinate.
---@field private heading number Heading in degrees.
---@field private leg number Leg length in NM.
---@field private marker MARKER F10 marker.
---@field private noccupied number Number of flights on this patrol point.
---@field private refuelsystem number Refueling system type: `0=Unit.RefuelingSystem.BOOM_AND_RECEPTACLE`, `1=Unit.RefuelingSystem.PROBE_AND_DROGUE`.
---@field private speed number Speed in knots.
---@field private type string Type name.
AIRWING.PatrolData = {}


---Patrol zone.
---@class AIRWING.PatrolZone 
---@field private altitude number Altitude in feet.
---@field private heading number Heading in degrees.
---@field private leg number Leg length in NM.
---@field private marker MARKER F10 marker.
---@field private mission AUFTRAG Mission assigned.
---@field private speed number Speed in knots.
---@field private zone ZONE Zone.
AIRWING.PatrolZone = {}


---Payload data.
---@class AIRWING.Payload 
---@field private aircrafttype string Type of aircraft, which can use this payload.
---@field private capabilities table Mission types and performances for which this payload can be used.
---@field private navail number Number of available payloads of this type.
---@field private pylons table Pylon data extracted for the unit template.
---@field private uid number Unique payload ID.
---@field private unitname string Name of the unit this pylon was extracted from.
---@field private unlimited boolean If true, this payload is unlimited and does not get consumed.
AIRWING.Payload = {}


---Tanker zone.
---@class AIRWING.TankerZone : AIRWING.PatrolZone
---@field private refuelsystem number Refueling system type: `0=Unit.RefuelingSystem.BOOM_AND_RECEPTACLE`, `1=Unit.RefuelingSystem.PROBE_AND_DROGUE`.
AIRWING.TankerZone = {}



