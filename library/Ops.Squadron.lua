---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/OPS_Squadron.png" width="100%">
---
---**Ops** - Airwing Squadron.
---
---**Main Features:**
---
---   * Set parameters like livery, skill valid for all squadron members.
---   * Define modex and callsigns.
---   * Define mission types, this squadron can perform (see Ops.Auftrag#AUFTRAG).
---   * Pause/unpause squadron operations.
---
---===
---
---### Author: **funkyfranky**
---*It is unbelievable what a squadron of twelve aircraft did to tip the balance* -- Adolf Galland
---
---===
---
---# The SQUADRON Concept
---
---A SQUADRON is essential part of an Ops.Airwing#AIRWING and consists of **one** type of aircraft.
---
---SQUADRON class.
---@class SQUADRON : COHORT
---@field ClassName string Name of the class.
---@field Ngroups number Number of asset flight groups this squadron has. 
---@field private aircrafttype string Type of the airframe the squadron is using.
---@field private assets table Squadron assets.
---@field private attribute string Generalized attribute of the squadron template group.
---@field private callsignName string Callsign name.
---@field private callsigncounter number Counter to increase callsign names for new assets.
---@field private despawnAfterHolding boolean Aircraft are despawned after holding.
---@field private despawnAfterLanding boolean Aircraft are despawned after landing.
---@field private engageRange number Mission range in meters.
---@field private fuellow number Low fuel threshold.
---@field private fuellowRefuel boolean If `true`, flight tries to refuel at the nearest tanker.
---@field private isAir boolean 
---@field private legion NOTYPE 
---@field private lid string Class id string for output to DCS log file.
---@field private livery string Livery of the squadron.
---@field private maintenancetime number Time in seconds needed for maintenance of a returned flight.
---@field private missiontypes table Capabilities (mission types and performances) of the squadron.
---@field private modex number Modex.
---@field private modexcounter number Counter to incease modex number for assets.
---@field private name string Name of the squadron.
---@field private ngrouping number User defined number of units in the asset group.
---@field private parkingIDs table Parking IDs for this squadron.
---@field private radioFreq number Radio frequency in MHz the squad uses.
---@field private radioModu number Radio modulation the squad uses.
---@field private refuelSystem number For refuelable squads, the refuel system used (boom=0 or probe=1). Default nil.
---@field private repairtime number Time in seconds for each
---@field private skill number Skill of squadron members.
---@field private tacanChannel table List of TACAN channels available to the squadron.
---@field private takeoffType string Take of type.
---@field private tankerSystem number For tanker squads, the refuel system used (boom=0 or probpe=1). Default nil.
---@field private templategroup GROUP Template group.
---@field private templatename string Name of the template group.
---@field private verbose number Verbosity level.
---@field private version string SQUADRON class version.
SQUADRON = {}

---Get airwing.
---
------
---@param self SQUADRON 
---@param Airwing NOTYPE 
---@return AIRWING #The airwing.
function SQUADRON:GetAirwing(Airwing) end

---Create a new SQUADRON object and start the FSM.
---
------
---@param self SQUADRON 
---@param TemplateGroupName string Name of the template group.
---@param Ngroups number Number of asset groups of this squadron. Default 3.
---@param SquadronName string Name of the squadron, e.g. "VFA-37". Must be **unique**!
---@return SQUADRON #self
function SQUADRON:New(TemplateGroupName, Ngroups, SquadronName) end

---Set airwing.
---
------
---@param self SQUADRON 
---@param Airwing AIRWING The airwing.
---@return SQUADRON #self
function SQUADRON:SetAirwing(Airwing) end

---Set despawn after holding.
---Aircraft will be despawned when they arrive at their holding position at the airbase.
---Can help to avoid DCS AI taxiing issues.
---
------
---@param self SQUADRON 
---@param Switch boolean If `true` (default), activate despawn after holding.
---@return SQUADRON #self
function SQUADRON:SetDespawnAfterHolding(Switch) end

---Set despawn after landing.
---Aircraft will be despawned after the landing event.
---Can help to avoid DCS AI taxiing issues.
---
------
---@param self SQUADRON 
---@param Switch boolean If `true` (default), activate despawn after landing.
---@return SQUADRON #self
function SQUADRON:SetDespawnAfterLanding(Switch) end

---Set if low fuel threshold is reached, flight tries to refuel at the neares tanker.
---
------
---@param self SQUADRON 
---@param switch boolean If true or nil, flight goes for refuelling. If false, turn this off.
---@return SQUADRON #self
function SQUADRON:SetFuelLowRefuel(switch) end

---Set low fuel threshold.
---
------
---@param self SQUADRON 
---@param LowFuel number Low fuel threshold in percent. Default 25.
---@return SQUADRON #self
function SQUADRON:SetFuelLowThreshold(LowFuel) end

---Set number of units in groups.
---
------
---@param self SQUADRON 
---@param nunits number Number of units. Must be >=1 and <=4. Default 2.
---@return SQUADRON #self
function SQUADRON:SetGrouping(nunits) end

---Set valid parking spot IDs.
---Assets of this squad are only allowed to be spawned at these parking spots. **Note** that the IDs are different from the ones displayed in the mission editor!
---
------
---@param self SQUADRON 
---@param ParkingIDs table Table of parking ID numbers or a single `#number`.
---@return SQUADRON #self
function SQUADRON:SetParkingIDs(ParkingIDs) end

---Set takeoff type air.
---All assets of this squadron will be spawned in air above the airbase.
---
------
---@param self SQUADRON 
---@return SQUADRON #self
function SQUADRON:SetTakeoffAir() end

---Set takeoff type cold (default).
---All assets of this squadron will be spawned with engines off (cold).
---
------
---@param self SQUADRON 
---@return SQUADRON #self
function SQUADRON:SetTakeoffCold() end

---Set takeoff type hot.
---All assets of this squadron will be spawned with engines on (hot).
---
------
---@param self SQUADRON 
---@return SQUADRON #self
function SQUADRON:SetTakeoffHot() end

---Set takeoff type.
---All assets of this squadron will be spawned with cold (default) or hot engines.
---Spawning on runways is not supported.
---
------
---@param self SQUADRON 
---@param TakeoffType string Take off type: "Cold" (default) or "Hot" with engines on or "Air" for spawning in air.
---@return SQUADRON #self
function SQUADRON:SetTakeoffType(TakeoffType) end

---On after Start event.
---Starts the FLIGHTGROUP FSM and event handlers.
---
------
---@param self SQUADRON 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function SQUADRON:onafterStart(From, Event, To) end

---On after "Status" event.
---
------
---@param self SQUADRON 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function SQUADRON:onafterStatus(From, Event, To) end



