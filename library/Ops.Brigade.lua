---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/OPS_Brigade_.png" width="100%">
---
---**Ops** - Brigade Warehouse.
---
---**Main Features:**
---
---   * Manage platoons
---   * Carry out ARTY and PATROLZONE missions (AUFTRAG)
---   * Define rearming zones
---
---===
---
---## Example Missions:
---
---Demo missions can be found on [github](https://github.com/FlightControl-Master/MOOSE_MISSIONS/tree/develop/Ops/Brigade).
---
---===
---
---### Author: **funkyfranky**
---
---===
---*I am not afraid of an Army of lions lead by a sheep; I am afraid of sheep lead by a lion* -- Alexander the Great
---
---===
---
---# The BRIGADE Concept
---
---A BRIGADE consists of one or multiple PLATOONs.
---These platoons "live" in a WAREHOUSE that has a phyiscal struction (STATIC or UNIT) and can be captured or destroyed.
---BRIGADE class.
---@class BRIGADE : LEGION
---@field ClassName string Name of the class.
---@field private lid NOTYPE 
---@field private rearmingZones table Rearming zones. Each element is of type `#BRIGADE.SupplyZone`.
---@field private refuellingZones table Refuelling zones. Each element is of type `#BRIGADE.SupplyZone`.
---@field private retreatZones SET_ZONE Retreat zone set.
---@field private verbose number Verbosity of output.
---@field private version string BRIGADE class version.
---@field private warehouseOpsElement NOTYPE 
---@field private warehouseOpsGroup NAVYGROUP 
BRIGADE = {}

---Add asset group(s) to platoon.
---
------
---@param Platoon PLATOON The platoon object.
---@param Nassets number Number of asset groups to add.
---@return BRIGADE #self
function BRIGADE:AddAssetToPlatoon(Platoon, Nassets) end

---Add a platoon to the brigade.
---
------
---@param Platoon PLATOON The platoon object.
---@return BRIGADE #self
function BRIGADE:AddPlatoon(Platoon) end

---Add a rearming zone.
---
------
---@param RearmingZone ZONE Rearming zone.
---@return BRIGADE.SupplyZone #The rearming zone data.
function BRIGADE:AddRearmingZone(RearmingZone) end

---Add a refuelling zone.
---
------
---@param RefuellingZone ZONE Refuelling zone.
---@return BRIGADE.SupplyZone #The refuelling zone data.
function BRIGADE:AddRefuellingZone(RefuellingZone) end

---Add a retreat zone.
---
------
---@param RetreatZone ZONE Retreat zone.
---@return BRIGADE #self
function BRIGADE:AddRetreatZone(RetreatZone) end

---Triggers the FSM event "ArmyOnMission".
---
------
---@param ArmyGroup ARMYGROUP The ARMYGROUP on mission.
---@param Mission AUFTRAG The mission.
function BRIGADE:ArmyOnMission(ArmyGroup, Mission) end

---Get platoon by name.
---
------
---@param PlatoonName string Name of the platoon.
---@return PLATOON #The Platoon object.
function BRIGADE:GetPlatoon(PlatoonName) end

---Get platoon of an asset.
---
------
---@param Asset WAREHOUSE.Assetitem The platoon asset.
---@return PLATOON #The platoon object.
function BRIGADE:GetPlatoonOfAsset(Asset) end

---Get retreat zones.
---
------
---@return SET_ZONE #Set of retreat zones.
function BRIGADE:GetRetreatZones() end

---[ GROUND ] Function to load back an asset in the field that has been filed before.
---
------
---
---USAGE
---```
---Prerequisites:
---Save the assets spawned by BRIGADE/CHIEF regularly (~every 5 mins) into a file, e.g. like this: 
---  
---             local Path = FilePath or "C:\\Users\\<yourname>\\Saved Games\\DCS\\Missions\\" -- example path
---             local BlueOpsFilename = BlueFileName or "ExamplePlatoonSave.csv" -- example filename 
---             local BlueSaveOps = SET_OPSGROUP:New():FilterCoalitions("blue"):FilterCategoryGround():FilterOnce()
---             UTILS.SaveSetOfOpsGroups(BlueSaveOps,Path,BlueOpsFilename)
---         
---where Path and Filename are strings, as chosen by you.
---You can then load back the assets at the start of your next mission run. Be aware that it takes a couple of seconds for the 
---platoon data to arrive in brigade, so make this an action after ~20 seconds, e.g. like so:
---
---           function LoadBackAssets()
---             local Path = FilePath or "C:\\Users\\<yourname>\\Saved Games\\DCS\\Missions\\" -- example path
---             local BlueOpsFilename = BlueFileName or "ExamplePlatoonSave.csv" -- example filename  
---             if UTILS.CheckFileExists(Path,BlueOpsFilename) then
---               local loadback = UTILS.LoadSetOfOpsGroups(Path,BlueOpsFilename,false)
---               for _,_platoondata in pairs (loadback) do
---                 local groupname = _platoondata.groupname -- #string
---                 local coordinate = _platoondata.coordinate -- Core.Point#COORDINATE
---                 Your_Brigade:LoadBackAssetInPosition(groupname,coordinate)
---               end
---             end
---           end
--- 
---           local AssetLoader = TIMER:New(LoadBackAssets)
---           AssetLoader:Start(20)
---
---The assets loaded back into the mission will be considered for AUFTRAG type missions from CHIEF and BRIGADE.
---```
------
---@param Templatename string e.g."1 PzDv LogRg I\_AID-976" - that's the alias (name) of an platoon spawned as `"platoon - alias"_AID-"asset-ID"`
---@param Position COORDINATE where to spawn the platoon
---@return BRIGADE #self
function BRIGADE:LoadBackAssetInPosition(Templatename, Position) end

---Create a new BRIGADE class object.
---
------
---@param WarehouseName string Name of the warehouse STATIC or UNIT object representing the warehouse.
---@param BrigadeName string Name of the brigade.
---@return BRIGADE #self
function BRIGADE:New(WarehouseName, BrigadeName) end

---On after "ArmyOnMission" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param ArmyGroup ARMYGROUP The ARMYGROUP on mission.
---@param Mission AUFTRAG The mission.
function BRIGADE:OnAfterArmyOnMission(From, Event, To, ArmyGroup, Mission) end

---Remove asset from platoon.
---
------
---@param Asset WAREHOUSE.Assetitem The platoon asset.
function BRIGADE:RemoveAssetFromPlatoon(Asset) end

---Define a set of retreat zones.
---
------
---@param RetreatZoneSet SET_ZONE Set of retreat zones.
---@return BRIGADE #self
function BRIGADE:SetRetreatZones(RetreatZoneSet) end

---Triggers the FSM event "Start".
---Starts the BRIGADE. Initializes parameters and starts event handlers.
---
------
function BRIGADE:Start() end

---Triggers the FSM event "ArmyOnMission" after a delay.
---
------
---@param delay number Delay in seconds.
---@param ArmyGroup ARMYGROUP The ARMYGROUP on mission.
---@param Mission AUFTRAG The mission.
function BRIGADE:__ArmyOnMission(delay, ArmyGroup, Mission) end

---Triggers the FSM event "Start" after a delay.
---Starts the BRIGADE. Initializes parameters and starts event handlers.
---
------
---@param delay number Delay in seconds.
function BRIGADE:__Start(delay) end

---Triggers the FSM event "Stop" after a delay.
---Stops the BRIGADE and all its event handlers.
---
------
---@param delay number Delay in seconds.
function BRIGADE:__Stop(delay) end

---On after "ArmyOnMission".
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param ArmyGroup ARMYGROUP Ops army group on mission.
---@param Mission AUFTRAG The requested mission.
---@private
function BRIGADE:onafterArmyOnMission(From, Event, To, ArmyGroup, Mission) end

---Start BRIGADE FSM.
---
------
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@private
function BRIGADE:onafterStart(From, Event, To) end

---Update status.
---
------
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@private
function BRIGADE:onafterStatus(From, Event, To) end


---Supply Zone.
---@class BRIGADE.SupplyZone 
---@field private marker MARKER F10 marker.
---@field private markerOn boolean If `true`, marker is on.
---@field private mission AUFTRAG Mission assigned to supply ammo or fuel.
---@field private zone ZONE The zone.
BRIGADE.SupplyZone = {}



