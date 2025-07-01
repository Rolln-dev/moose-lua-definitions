---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/OPS_Fleet.png" width="100%">
---
---**Ops** - Fleet Warehouse.
---
---**Main Features:**
---
---   * Manage flotillas
---   * Carry out ARTY and PATROLZONE missions (AUFTRAG)
---
---===
---
---## Example Missions:
---
---Demo missions can be found on [github](https://github.com/FlightControl-Master/MOOSE_MISSIONS/tree/develop/Ops/Fleet).
---
---===
---
---### Author: **funkyfranky**
---
---===
---*A fleet of British ships at war are the best negotiators.* -- Horatio Nelson
---
---===
---
---# The FLEET Concept
---
---A FLEET consists of one or multiple FLOTILLAs.
---These flotillas "live" in a WAREHOUSE that has a phyiscal struction (STATIC or UNIT) and can be captured or destroyed.
---
---# Basic Setup
---
---A new `FLEET` object can be created with the #FLEET.New(`WarehouseName`, `FleetName`) function, where `WarehouseName` is the name of the static or unit object hosting the fleet
---and `FleetName` is the name you want to give the fleet. This must be *unique*!
---
---    myFleet=FLEET:New("myWarehouseName", "1st Fleet")
---    myFleet:SetPortZone(ZonePort1stFleet)
---    myFleet:Start()
---    
---A fleet needs a *port zone*, which is set via the #FLEET.SetPortZone(`PortZone`) function. This is the zone where the naval assets are spawned and return to.
---
---Finally, the fleet needs to be started using the #FLEET.Start() function. If the fleet is not started, it will not process any requests.
---
---## Adding Flotillas
---
---Flotillas can be added via the #FLEET.AddFlotilla(`Flotilla`) function. See Ops.Flotilla#FLOTILLA for how to create a flotilla.
---
---    myFleet:AddFlotilla(FlotillaTiconderoga)
---    myFleet:AddFlotilla(FlotillaPerry)
---    
---FLEET class.
---@class FLEET : LEGION
---@field ClassName string Name of the class.
---@field private lid NOTYPE 
---@field private pathfinding boolean Set pathfinding on for all spawned navy groups.
---@field private retreatZones SET_ZONE Retreat zone set.
---@field private verbose number Verbosity of output.
---@field private version string FLEET class version.
---@field private warehouseOpsElement NOTYPE 
---@field private warehouseOpsGroup NAVYGROUP 
FLEET = {}

---Add asset group(s) to flotilla.
---
------
---@param self FLEET 
---@param Flotilla FLOTILLA The flotilla object.
---@param Nassets number Number of asset groups to add.
---@return FLEET #self
function FLEET:AddAssetToFlotilla(Flotilla, Nassets) end

---Add a flotilla to the fleet.
---
------
---@param self FLEET 
---@param Flotilla FLOTILLA The flotilla object.
---@return FLEET #self
function FLEET:AddFlotilla(Flotilla) end

---Add a retreat zone.
---
------
---@param self FLEET 
---@param RetreatZone ZONE Retreat zone.
---@return FLEET #self
function FLEET:AddRetreatZone(RetreatZone) end

---Get flotilla by name.
---
------
---@param self FLEET 
---@param FlotillaName string Name of the flotilla.
---@return FLOTILLA #The Flotilla object.
function FLEET:GetFlotilla(FlotillaName) end

---Get flotilla of an asset.
---
------
---@param self FLEET 
---@param Asset WAREHOUSE.Assetitem The flotilla asset.
---@return FLOTILLA #The flotilla object.
function FLEET:GetFlotillaOfAsset(Asset) end

---Get retreat zones.
---
------
---@param self FLEET 
---@return SET_ZONE #Set of retreat zones.
function FLEET:GetRetreatZones() end

---Triggers the FSM event "NavyOnMission".
---
------
---@param self FLEET 
---@param ArmyGroup NAVYGROUP The NAVYGROUP on mission.
---@param Mission AUFTRAG The mission.
function FLEET:NavyOnMission(ArmyGroup, Mission) end

---Create a new FLEET class object.
---
------
---@param self FLEET 
---@param WarehouseName string Name of the warehouse STATIC or UNIT object representing the warehouse.
---@param FleetName string Name of the fleet.
---@return FLEET #self
function FLEET:New(WarehouseName, FleetName) end

---On after "NavyOnMission" event.
---
------
---@param self FLEET 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param NavyGroup NAVYGROUP The NAVYGROUP on mission.
---@param Mission AUFTRAG The mission.
function FLEET:OnAfterNavyOnMission(From, Event, To, NavyGroup, Mission) end

---Remove asset from flotilla.
---
------
---@param self FLEET 
---@param Asset WAREHOUSE.Assetitem The flotilla asset.
function FLEET:RemoveAssetFromFlotilla(Asset) end

---Set pathfinding for all spawned naval groups.
---
------
---@param self FLEET 
---@param Switch boolean If `true`, pathfinding is used.
---@return FLEET #self
function FLEET:SetPathfinding(Switch) end

---Define a set of retreat zones.
---
------
---@param self FLEET 
---@param RetreatZoneSet SET_ZONE Set of retreat zones.
---@return FLEET #self
function FLEET:SetRetreatZones(RetreatZoneSet) end

---Triggers the FSM event "Start".
---Starts the FLEET. Initializes parameters and starts event handlers.
---
------
---@param self FLEET 
function FLEET:Start() end

---Triggers the FSM event "NavyOnMission" after a delay.
---
------
---@param self FLEET 
---@param delay number Delay in seconds.
---@param ArmyGroup NAVYGROUP The NAVYGROUP on mission.
---@param Mission AUFTRAG The mission.
function FLEET:__NavyOnMission(delay, ArmyGroup, Mission) end

---Triggers the FSM event "Start" after a delay.
---Starts the FLEET. Initializes parameters and starts event handlers.
---
------
---@param self FLEET 
---@param delay number Delay in seconds.
function FLEET:__Start(delay) end

---Triggers the FSM event "Stop" after a delay.
---Stops the FLEET and all its event handlers.
---
------
---@param self FLEET 
---@param delay number Delay in seconds.
function FLEET:__Stop(delay) end

---On after "NavyOnMission".
---
------
---@param self FLEET 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param ArmyGroup ARMYGROUP Ops army group on mission.
---@param Mission AUFTRAG The requested mission.
---@param NavyGroup NOTYPE 
---@private
function FLEET:onafterNavyOnMission(From, Event, To, ArmyGroup, Mission, NavyGroup) end

---Start FLEET FSM.
---
------
---@param self FLEET 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@private
function FLEET:onafterStart(From, Event, To) end

---Update status.
---
------
---@param self FLEET 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@private
function FLEET:onafterStatus(From, Event, To) end


---Supply Zone.
---@class FLEET.SupplyZone 
---@field private marker MARKER F10 marker.
---@field private markerOn boolean If `true`, marker is on.
---@field private mission AUFTRAG Mission assigned to supply ammo or fuel.
---@field private zone ZONE The zone.
FLEET.SupplyZone = {}



