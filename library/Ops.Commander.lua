---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/OPS_Commander.png" width="100%">
---
---**Ops** - Commander of Airwings, Brigades and Fleets.
---
---**Main Features:**
---
---   * Manages AIRWINGS, BRIGADEs and FLEETs
---   * Handles missions (AUFTRAG) and finds the best assets for the job 
---
---===
---
---### Author: **funkyfranky**
---
---===
---*He who has never leared to obey cannot be a good commander.* -- Aristotle
---
---===
---
---# The COMMANDER Concept
---
---A commander is the head of legions.
---He/she will find the best LEGIONs to perform an assigned AUFTRAG (mission) or OPSTRANSPORT.
---A legion can be an AIRWING, BRIGADE or FLEET.
---
---# Constructor
---
---A new COMMANDER object is created with the #COMMANDER.New(*Coalition, Alias*) function, where the parameter *Coalition* is the coalition side.
---It can be `coalition.side.RED`, `coalition.side.BLUE` or `coalition.side.NEUTRAL`. This parameter is mandatory!
---
---The second parameter *Alias* is optional and can be used to give the COMMANDER a "name", which is used for output in the dcs.log file.
---
---    local myCommander=COMANDER:New(coalition.side.BLUE, "General Patton")
---
---# Adding Legions
---
---Legions, i.e. AIRWINGS, BRIGADES and FLEETS can be added via the #COMMANDER.AddLegion(*Legion*) command:
---
---    myCommander:AddLegion(myLegion)
---
---## Adding Airwings
---
---It is also possible to use #COMMANDER.AddAirwing(*myAirwing*) function. This does the same as the `AddLegion` function but might be a bit more intuitive.
---
---## Adding Brigades
---
---It is also possible to use #COMMANDER.AddBrigade(*myBrigade*) function. This does the same as the `AddLegion` function but might be a bit more intuitive.
---
---## Adding Fleets
---
---It is also possible to use #COMMANDER.AddFleet(*myFleet*) function. This does the same as the `AddLegion` function but might be a bit more intuitive.
---
---# Adding Missions
---
---Mission can be added via the #COMMANDER.AddMission(*myMission*) function.
---
---# Adding OPS Transports
---
---Transportation assignments can be added via the #COMMANDER.AddOpsTransport(*myTransport*) function.
---
---# Adding CAP Zones
---
---A CAP zone can be added via the #COMMANDER.AddCapZone() function.
---
---# Adding Rearming Zones
---
---A rearming zone can be added via the #COMMANDER.AddRearmingZone() function.
---
---# Adding Refuelling Zones
---
---A refuelling zone can be added via the #COMMANDER.AddRefuellingZone() function.
---
---
---# FSM Events
---
---The COMMANDER will 
---
---## OPSGROUP on Mission
---
---Whenever an OPSGROUP (FLIGHTGROUP, ARMYGROUP or NAVYGROUP) is send on a mission, the `OnAfterOpsOnMission()` event is triggered.
---Mission designers can hook into the event with the #COMMANDER.OnAfterOpsOnMission() function
---
---    function myCommander:OnAfterOpsOnMission(From, Event, To, OpsGroup, Mission)
---      -- Your code
---    end
---    
---## Canceling a Mission
---
---A mission can be cancelled with the #COMMMANDER.MissionCancel() function
---
---    myCommander:MissionCancel(myMission)
---    
---or
---    myCommander:__MissionCancel(5*60, myMission)
---    
---The last commander cancels the mission after 5 minutes (300 seconds).
---
---The cancel command will be forwarded to all assigned legions and OPS groups, which will abort their mission or remove it from their queue.
---COMMANDER class.
---@class COMMANDER : FSM
---@field ClassName string Name of the class.
---@field private alias string Alias name.
---@field private awacsZones table AWACS zones. Each element is of type `#AIRWING.PatrolZone`.
---@field private capZones table CAP zones. Each element is of type `#AIRWING.PatrolZone`.
---@field private chief CHIEF Chief of staff.
---@field private coalition number Coalition side of the commander.
---@field private gcicapZones table GCICAP zones. Each element is of type `#AIRWING.PatrolZone`.
---@field private legions table Table of legions which are commanded.
---@field private lid string Class id string for output to DCS log file.
---@field private limitMission table Table of limits for mission types.
---@field private missionqueue table Mission queue.
---@field private opsqueue table Operations queue.
---@field private rearmingZones table Rearming zones. Each element is of type `#BRIGADE.SupplyZone`.
---@field private refuellingZones table Refuelling zones. Each element is of type `#BRIGADE.SupplyZone`.
---@field private tankerZones table Tanker zones. Each element is of type `#AIRWING.TankerZone`.
---@field private targetqueue table Target queue.
---@field private transportqueue table Transport queue.
---@field private verbose number Verbosity level.
---@field private version string COMMANDER class version.
COMMANDER = {}

---Add an AIRWING to the commander.
---
------
---@param self COMMANDER 
---@param Airwing AIRWING The airwing to add.
---@return COMMANDER #self
function COMMANDER:AddAirwing(Airwing) end

---Add an AWACS zone.
---
------
---@param self COMMANDER 
---@param Zone ZONE Zone.
---@param Altitude number Orbit altitude in feet. Default is 12,000 feet.
---@param Speed number Orbit speed in KIAS. Default 350 kts.
---@param Heading number Heading of race-track pattern in degrees. Default 270 (East to West).
---@param Leg number Length of race-track in NM. Default 30 NM.
---@return AIRWING.PatrolZone #The AWACS zone data.
function COMMANDER:AddAwacsZone(Zone, Altitude, Speed, Heading, Leg) end

---Add a BRIGADE to the commander.
---
------
---@param self COMMANDER 
---@param Brigade BRIGADE The brigade to add.
---@return COMMANDER #self
function COMMANDER:AddBrigade(Brigade) end

---Add a CAP zone.
---
------
---@param self COMMANDER 
---@param Zone ZONE CapZone Zone.
---@param Altitude number Orbit altitude in feet. Default is 12,000 feet.
---@param Speed number Orbit speed in KIAS. Default 350 kts.
---@param Heading number Heading of race-track pattern in degrees. Default 270 (East to West).
---@param Leg number Length of race-track in NM. Default 30 NM.
---@return AIRWING.PatrolZone #The CAP zone data.
function COMMANDER:AddCapZone(Zone, Altitude, Speed, Heading, Leg) end

---Add a FLEET to the commander.
---
------
---@param self COMMANDER 
---@param Fleet FLEET The fleet to add.
---@return COMMANDER #self
function COMMANDER:AddFleet(Fleet) end

---Add a GCICAP zone.
---
------
---@param self COMMANDER 
---@param Zone ZONE CapZone Zone.
---@param Altitude number Orbit altitude in feet. Default is 12,000 feet.
---@param Speed number Orbit speed in KIAS. Default 350 kts.
---@param Heading number Heading of race-track pattern in degrees. Default 270 (East to West).
---@param Leg number Length of race-track in NM. Default 30 NM.
---@return AIRWING.PatrolZone #The CAP zone data.
function COMMANDER:AddGciCapZone(Zone, Altitude, Speed, Heading, Leg) end

---Add a LEGION to the commander.
---
------
---@param self COMMANDER 
---@param Legion LEGION The legion to add.
---@return COMMANDER #self
function COMMANDER:AddLegion(Legion) end

---Add mission to mission queue.
---
------
---@param self COMMANDER 
---@param Mission AUFTRAG Mission to be added.
---@return COMMANDER #self
function COMMANDER:AddMission(Mission) end

---Add operation.
---
------
---@param self COMMANDER 
---@param Operation OPERATION The operation to be added.
---@return COMMANDER #self
function COMMANDER:AddOperation(Operation) end

---Add transport to queue.
---
------
---@param self COMMANDER 
---@param Transport OPSTRANSPORT The OPS transport to be added.
---@return COMMANDER #self
function COMMANDER:AddOpsTransport(Transport) end

---Add a rearming zone.
---
------
---@param self COMMANDER 
---@param RearmingZone ZONE Rearming zone.
---@return BRIGADE.SupplyZone #The rearming zone data.
function COMMANDER:AddRearmingZone(RearmingZone) end

---Add a refuelling zone.
---
------
---@param self COMMANDER 
---@param RefuellingZone ZONE Refuelling zone.
---@return BRIGADE.SupplyZone #The refuelling zone data.
function COMMANDER:AddRefuellingZone(RefuellingZone) end

---Add a refuelling tanker zone.
---
------
---@param self COMMANDER 
---@param Zone ZONE Zone.
---@param Altitude number Orbit altitude in feet. Default is 12,000 feet.
---@param Speed number Orbit speed in KIAS. Default 350 kts.
---@param Heading number Heading of race-track pattern in degrees. Default 270 (East to West).
---@param Leg number Length of race-track in NM. Default 30 NM.
---@param RefuelSystem number Refuelling system.
---@return AIRWING.TankerZone #The tanker zone data.
function COMMANDER:AddTankerZone(Zone, Altitude, Speed, Heading, Leg, RefuelSystem) end

---Add target.
---
------
---@param self COMMANDER 
---@param Target TARGET Target object to be added.
---@return COMMANDER #self
function COMMANDER:AddTarget(Target) end

---Check mission queue and assign ONE planned mission.
---
------
---@param self COMMANDER 
function COMMANDER:CheckMissionQueue() end

---Check OPERATIONs queue.
---
------
---@param self COMMANDER 
function COMMANDER:CheckOpsQueue() end

---Check target queue and assign ONE valid target by adding it to the mission queue of the COMMANDER.
---
------
---@param self COMMANDER 
function COMMANDER:CheckTargetQueue() end

---Check transport queue and assign ONE planned transport.
---
------
---@param self COMMANDER 
function COMMANDER:CheckTransportQueue() end

---Count assets of all assigned legions.
---
------
---@param self COMMANDER 
---@param InStock boolean If true, only assets that are in the warehouse stock/inventory are counted.
---@param MissionTypes? table (Optional) Count only assest that can perform certain mission type(s). Default is all types.
---@param Attributes? table (Optional) Count only assest that have a certain attribute(s), e.g. `WAREHOUSE.Attribute.AIR_BOMBER`.
---@return number #Amount of asset groups.
function COMMANDER:CountAssets(InStock, MissionTypes, Attributes) end

---Count assets of all assigned legions.
---
------
---@param self COMMANDER 
---@param MissionTypes? table (Optional) Count only missions of these types. Default is all types.
---@param OnlyRunning boolean If `true`, only count running missions.
---@return number #Amount missions.
function COMMANDER:CountMissions(MissionTypes, OnlyRunning) end

---Count assets of all assigned legions.
---
------
---@param self COMMANDER 
---@param InStock boolean If true, only assets that are in the warehouse stock/inventory are counted.
---@param Legions? table (Optional) Table of legions. Default is all legions.
---@param MissionTypes? table (Optional) Count only assest that can perform certain mission type(s). Default is all types.
---@param Attributes? table (Optional) Count only assest that have a certain attribute(s), e.g. `WAREHOUSE.Attribute.AIR_BOMBER`.
---@return number #Amount of asset groups.
function COMMANDER:GetAssets(InStock, Legions, MissionTypes, Attributes) end

---Get assets on given mission or missions.
---
------
---@param self COMMANDER 
---@param MissionTypes table Types on mission to be checked. Default all.
---@return table #Assets on pending requests.
function COMMANDER:GetAssetsOnMission(MissionTypes) end

---Get coalition.
---
------
---@param self COMMANDER 
---@return number #Coalition.
function COMMANDER:GetCoalition() end

---Check all legions if they are able to do a specific mission type at a certain location with a given number of assets.
---
------
---@param self COMMANDER 
---@param Mission AUFTRAG The mission.
---@return table #Table of LEGIONs that can do the mission and have at least one asset available right now.
function COMMANDER:GetLegionsForMission(Mission) end

---Check if this mission is already in the queue.
---
------
---@param self COMMANDER 
---@param Mission AUFTRAG The mission.
---@return boolean #If `true`, this mission is in the queue.
function COMMANDER:IsMission(Mission) end

---Check if a TARGET is already in the queue.
---
------
---@param self COMMANDER 
---@param Target TARGET Target object to be added.
---@return boolean #If `true`, target exists in the target queue.
function COMMANDER:IsTarget(Target) end

---Triggers the FSM event "LegionLost".
---
------
---@param self COMMANDER 
---@param Legion LEGION The legion that was lost.
---@param Coalition coalition.side which captured the warehouse.
---@param Country country.id which has captured the warehouse.
function COMMANDER:LegionLost(Legion, Coalition, Country) end

---Triggers the FSM event "MissionAssign".
---Mission is added to a LEGION mission queue and already requested. Needs assets to be added to the mission!
---
------
---@param self COMMANDER 
---@param Mission AUFTRAG The mission.
---@param Legions table The Legion(s) to which the mission is assigned.
function COMMANDER:MissionAssign(Mission, Legions) end

---Triggers the FSM event "MissionCancel".
---
------
---@param self COMMANDER 
---@param Mission AUFTRAG The mission.
function COMMANDER:MissionCancel(Mission) end

---Create a new COMMANDER object and start the FSM.
---
------
---@param self COMMANDER 
---@param Coalition number Coaliton of the commander.
---@param Alias string Some name you want the commander to be called.
---@return COMMANDER #self
function COMMANDER:New(Coalition, Alias) end

---On after "LegionLost" event.
---
------
---@param self COMMANDER 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Legion LEGION The legion that was lost.
---@param Coalition coalition.side which captured the warehouse.
---@param Country country.id which has captured the warehouse.
function COMMANDER:OnAfterLegionLost(From, Event, To, Legion, Coalition, Country) end

---On after "MissionAssign" event.
---
------
---@param self COMMANDER 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Mission AUFTRAG The mission.
---@param Legions table The Legion(s) to which the mission is assigned.
function COMMANDER:OnAfterMissionAssign(From, Event, To, Mission, Legions) end

---On after "MissionCancel" event.
---
------
---@param self COMMANDER 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Mission AUFTRAG The mission.
function COMMANDER:OnAfterMissionCancel(From, Event, To, Mission) end

---On after "OpsOnMission" event.
---
------
---@param self COMMANDER 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param OpsGroup OPSGROUP The OPS group on mission.
---@param Mission AUFTRAG The mission.
function COMMANDER:OnAfterOpsOnMission(From, Event, To, OpsGroup, Mission) end

---On after "TransportAssign" event.
---
------
---@param self COMMANDER 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Transport OPSTRANSPORT The transport.
---@param Legions table The legion(s) to which this transport is assigned.
function COMMANDER:OnAfterTransportAssign(From, Event, To, Transport, Legions) end

---On after "TransportCancel" event.
---
------
---@param self COMMANDER 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Transport OPSTRANSPORT The transport.
function COMMANDER:OnAfterTransportCancel(From, Event, To, Transport) end

---Triggers the FSM event "OpsOnMission".
---
------
---@param self COMMANDER 
---@param OpsGroup OPSGROUP The OPS group on mission.
---@param Mission AUFTRAG The mission.
function COMMANDER:OpsOnMission(OpsGroup, Mission) end

---Recruit assets performing an escort mission for a given asset.
---
------
---@param self COMMANDER 
---@param Mission AUFTRAG The mission.
---@param Assets table Table of assets to be escorted.
---@return boolean #If `true`, enough assets could be recruited or no escort was required in the first place.
function COMMANDER:RecruitAssetsForEscort(Mission, Assets) end

---Recruit assets for a given mission.
---
------
---@param self COMMANDER 
---@param Mission AUFTRAG The mission.
---@return boolean #If `true` enough assets could be recruited.
---@return table #Recruited assets.
---@return table #Legions that have recruited assets.
function COMMANDER:RecruitAssetsForMission(Mission) end

---Recruit assets for a given TARGET.
---
------
---@param self COMMANDER 
---@param Target TARGET The target.
---@param MissionType string Mission Type.
---@param NassetsMin number Min number of required assets.
---@param NassetsMax number Max number of required assets.
---@return boolean #If `true` enough assets could be recruited.
---@return table #Assets that have been recruited from all legions.
---@return table #Legions that have recruited assets.
function COMMANDER:RecruitAssetsForTarget(Target, MissionType, NassetsMin, NassetsMax) end

---Recruit assets for a given OPS transport.
---
------
---@param self COMMANDER 
---@param Transport OPSTRANSPORT The OPS transport.
---@param CargoWeight number Weight of the heaviest cargo group.
---@param TotalWeight number Total weight of all cargo groups.
---@return boolean #If `true`, enough assets could be recruited.
---@return table #Recruited assets.
---@return table #Legions that have recruited assets.
function COMMANDER:RecruitAssetsForTransport(Transport, CargoWeight, TotalWeight) end

---Relocate a cohort to another legion.
---Assets in stock are spawned and routed to the new legion.
---If assets are spawned, running missions will be cancelled.
---Cohort assets will not be available until relocation is finished.
---
------
---@param self COMMANDER 
---@param Cohort COHORT The cohort to be relocated.
---@param Legion LEGION The legion where the cohort is relocated to.
---@param Delay number Delay in seconds before relocation takes place. Default `nil`, *i.e.* ASAP.
---@param NcarriersMin number Min number of transport carriers in case the troops should be transported. Default `nil` for no transport.
---@param NcarriersMax number Max number of transport carriers.
---@param TransportLegions table Legion(s) assigned for transportation. Default is all legions of the commander.
---@return COMMANDER #self
function COMMANDER:RelocateCohort(Cohort, Legion, Delay, NcarriersMin, NcarriersMax, TransportLegions) end

---Remove a AWACS zone.
---
------
---@param self COMMANDER 
---@param Zone ZONE Zone, where the flight orbits.
function COMMANDER:RemoveAwacsZone(Zone) end

---Remove a GCI CAP.
---
------
---@param self COMMANDER 
---@param Zone ZONE Zone, where the flight orbits.
function COMMANDER:RemoveGciCapZone(Zone) end

---Remove a LEGION to the commander.
---
------
---@param self COMMANDER 
---@param Legion LEGION The legion to be removed.
---@return COMMANDER #self
function COMMANDER:RemoveLegion(Legion) end

---Remove mission from queue.
---
------
---@param self COMMANDER 
---@param Mission AUFTRAG Mission to be removed.
---@return COMMANDER #self
function COMMANDER:RemoveMission(Mission) end

---Remove a refuelling tanker zone.
---
------
---@param self COMMANDER 
---@param Zone ZONE Zone, where the flight orbits.
function COMMANDER:RemoveTankerZone(Zone) end

---Remove target from queue.
---
------
---@param self COMMANDER 
---@param Target TARGET The target.
---@return COMMANDER #self
function COMMANDER:RemoveTarget(Target) end

---Remove transport from queue.
---
------
---@param self COMMANDER 
---@param Transport OPSTRANSPORT The OPS transport to be removed.
---@return COMMANDER #self
function COMMANDER:RemoveTransport(Transport) end

---Set limit for number of total or specific missions to be executed simultaniously.
---
------
---@param self COMMANDER 
---@param Limit number Number of max. mission of this type. Default 10.
---@param MissionType string Type of mission, e.g. `AUFTRAG.Type.BAI`. Default `"Total"` for total number of missions.
---@return COMMANDER #self
function COMMANDER:SetLimitMission(Limit, MissionType) end

---Set verbosity level.
---
------
---@param self COMMANDER 
---@param VerbosityLevel number Level of output (higher=more). Default 0.
---@return COMMANDER #self
function COMMANDER:SetVerbosity(VerbosityLevel) end

---Triggers the FSM event "Start".
---Starts the COMMANDER.
---
------
---@param self COMMANDER 
function COMMANDER:Start() end

---Triggers the FSM event "Status".
---
------
---@param self COMMANDER 
function COMMANDER:Status() end

---Triggers the FSM event "TransportAssign".
---
------
---@param self COMMANDER 
---@param Transport OPSTRANSPORT The transport.
---@param Legions table The legion(s) to which this transport is assigned.
function COMMANDER:TransportAssign(Transport, Legions) end

---Triggers the FSM event "TransportCancel".
---
------
---@param self COMMANDER 
---@param Transport OPSTRANSPORT The transport.
function COMMANDER:TransportCancel(Transport) end

---Check if limit of missions has been reached.
---
------
---@param self COMMANDER 
---@param MissionType string Type of mission.
---@return boolean #If `true`, mission limit has **not** been reached. If `false`, limit has been reached.
function COMMANDER:_CheckMissionLimit(MissionType) end

---Get cohorts.
---
------
---@param self COMMANDER 
---@param Legions table Special legions.
---@param Cohorts table Special cohorts.
---@param Operation OPERATION Operation.
---@return table #Cohorts.
function COMMANDER:_GetCohorts(Legions, Cohorts, Operation) end

---Triggers the FSM event "LegionLost".
---
------
---@param self COMMANDER 
---@param delay number Delay in seconds.
---@param Legion LEGION The legion that was lost.
---@param Coalition coalition.side which captured the warehouse.
---@param Country country.id which has captured the warehouse.
function COMMANDER:__LegionLost(delay, Legion, Coalition, Country) end

---Triggers the FSM event "MissionAssign" after a delay.
---Mission is added to a LEGION mission queue and already requested. Needs assets to be added to the mission!
---
------
---@param self COMMANDER 
---@param delay number Delay in seconds.
---@param Mission AUFTRAG The mission.
---@param Legions table The Legion(s) to which the mission is assigned.
function COMMANDER:__MissionAssign(delay, Mission, Legions) end

---Triggers the FSM event "MissionCancel" after a delay.
---
------
---@param self COMMANDER 
---@param delay number Delay in seconds.
---@param Mission AUFTRAG The mission.
function COMMANDER:__MissionCancel(delay, Mission) end

---Triggers the FSM event "OpsOnMission" after a delay.
---
------
---@param self COMMANDER 
---@param delay number Delay in seconds.
---@param OpsGroup OPSGROUP The OPS group on mission.
---@param Mission AUFTRAG The mission.
function COMMANDER:__OpsOnMission(delay, OpsGroup, Mission) end

---Triggers the FSM event "Start" after a delay.
---Starts the COMMANDER.
---
------
---@param self COMMANDER 
---@param delay number Delay in seconds.
function COMMANDER:__Start(delay) end

---Triggers the FSM event "Status" after a delay.
---
------
---@param self COMMANDER 
---@param delay number Delay in seconds.
function COMMANDER:__Status(delay) end

---Triggers the FSM event "Stop" after a delay.
---Stops the COMMANDER.
---
------
---@param self COMMANDER 
---@param delay number Delay in seconds.
function COMMANDER:__Stop(delay) end

---Triggers the FSM event "TransportAssign" after a delay.
---
------
---@param self COMMANDER 
---@param delay number Delay in seconds.
---@param Transport OPSTRANSPORT The transport.
---@param Legions table The legion(s) to which this transport is assigned.
function COMMANDER:__TransportAssign(delay, Transport, Legions) end

---Triggers the FSM event "TransportCancel" after a delay.
---
------
---@param self COMMANDER 
---@param delay number Delay in seconds.
---@param Transport OPSTRANSPORT The transport.
function COMMANDER:__TransportCancel(delay, Transport) end

---On after "MissionAssign" event.
---Mission is added to a LEGION mission queue and already requested. Needs assets to be added to the mission already.
---
------
---@param self COMMANDER 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Mission AUFTRAG The mission.
---@param Legions table The Legion(s) to which the mission is assigned.
---@private
function COMMANDER:onafterMissionAssign(From, Event, To, Mission, Legions) end

---On after "MissionCancel" event.
---
------
---@param self COMMANDER 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Mission AUFTRAG The mission.
---@private
function COMMANDER:onafterMissionCancel(From, Event, To, Mission) end

---On after "OpsOnMission".
---
------
---@param self COMMANDER 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param OpsGroup OPSGROUP Ops group on mission
---@param Mission AUFTRAG The requested mission.
---@private
function COMMANDER:onafterOpsOnMission(From, Event, To, OpsGroup, Mission) end

---On after Start event.
---Starts the FLIGHTGROUP FSM and event handlers.
---
------
---@param self COMMANDER 
---@param Group GROUP Flight group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function COMMANDER:onafterStart(Group, From, Event, To) end

---On after "Status" event.
---
------
---@param self COMMANDER 
---@param Group GROUP Flight group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function COMMANDER:onafterStatus(Group, From, Event, To) end

---On after "TransportAssign" event.
---Transport is added to a LEGION transport queue.
---
------
---@param self COMMANDER 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Transport OPSTRANSPORT The transport.
---@param Legions table The legion(s) to which this transport is assigned.
---@private
function COMMANDER:onafterTransportAssign(From, Event, To, Transport, Legions) end

---On after "TransportCancel" event.
---
------
---@param self COMMANDER 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Transport OPSTRANSPORT The transport.
---@private
function COMMANDER:onafterTransportCancel(From, Event, To, Transport) end



