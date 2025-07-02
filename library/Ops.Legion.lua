---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/OPS_Legion.png" width="100%">
---
---**Ops** - Legion Warehouse.
---
---Parent class of Airwings, Brigades and Fleets.
---
---===
---
---### Author: **funkyfranky**
---
---===
---*Per aspera ad astra.*
---
---===
---
---# The LEGION Concept
---
---The LEGION class contains all functions that are common for the AIRWING, BRIGADE and FLEET classes, which inherit the LEGION class.
---
---An LEGION consists of multiple COHORTs. These cohorts "live" in a WAREHOUSE, i.e. a physical structure that can be destroyed or captured.
---
---** The LEGION class is not meant to be used directly. Use AIRWING, BRIGADE or FLEET instead! **
---LEGION class.
---@class LEGION : WAREHOUSE
---@field ClassName string Name of the class.
---@field RandomAssetScore number Random score that is added to the asset score in the selection process.
---@field private chief CHIEF Chief of this legion.
---@field private cohorts table Cohorts of this legion.
---@field private commander COMMANDER Commander of this legion.
---@field private destbase NOTYPE 
---@field private homebase NOTYPE 
---@field private homezone NOTYPE 
---@field private lid string Class id string for output to DCS log file.
---@field private missionqueue table Mission queue table.
---@field private tacview boolean If `true`, show tactical overview on status update.
---@field private transportqueue table Transport queue.
---@field private verbose number Verbosity of output.
---@field private version string LEGION class version.
LEGION = {}

---Add cohort to cohort table of this legion.
---
------
---@param Cohort COHORT The cohort to be added.
---@return LEGION #self
function LEGION:AddCohort(Cohort) end

---Add a mission for the legion.
---It will pick the best available assets for the mission and lauch it when ready.
---
------
---@param Mission AUFTRAG Mission for this legion.
---@return LEGION #self
function LEGION:AddMission(Mission) end

---Add transport assignment to queue.
---
------
---@param OpsTransport OPSTRANSPORT Transport assignment.
---@return LEGION #self
function LEGION:AddOpsTransport(OpsTransport) end

---Recruit and assign assets performing an escort mission for a given asset list.
---Note that each asset gets an escort.
---
------
---@param Cohorts table Cohorts for escorting assets.
---@param Assets table Table of assets to be escorted.
---@param NescortMin number Min number of escort groups required per escorted asset.
---@param NescortMax number Max number of escort groups required per escorted asset.
---@param MissionType string Mission type.
---@param TargetTypes string Types of targets that are engaged.
---@param EngageRange number EngageRange in Nautical Miles.
---@return boolean #If `true`, enough assets could be recruited or no escort was required in the first place.
function LEGION:AssignAssetsForEscort(Cohorts, Assets, NescortMin, NescortMax, MissionType, TargetTypes, EngageRange) end

---Recruit and assign assets performing an OPSTRANSPORT for a given asset list.
---
------
---@param Legions table Transport legions.
---@param CargoAssets table Weight of the heaviest cargo group to be transported.
---@param NcarriersMin number Min number of carrier assets.
---@param NcarriersMax number Max number of carrier assets.
---@param DeployZone ZONE Deploy zone.
---@param DisembarkZone? ZONE (Optional) Disembark zone. 
---@param Categories table Group categories.
---@param Attributes table Generalizes group attributes.
---@param Properties table DCS attributes.
---@return boolean #If `true`, enough assets could be recruited and an OPSTRANSPORT object was created.
---@return OPSTRANSPORT #Transport The transport.
function LEGION:AssignAssetsForTransport(Legions, CargoAssets, NcarriersMin, NcarriersMax, DeployZone, DisembarkZone, Categories, Attributes, Properties) end

---Calculate the mission score of an asset.
---
------
---@param MissionType string Mission type for which the best assets are desired.
---@param TargetVec2 Vec2 Target 2D vector.
---@param IncludePayload boolean If `true`, include the payload in the calulation if the asset has one attached.
---@param TotalWeight number The total weight of the cargo to be transported, if applicable.
---@return number #Mission score.
function LEGION.CalculateAssetMissionScore(asset, MissionType, TargetVec2, IncludePayload, TotalWeight) end

---Check mission queue and assign ONE mission.
---
------
---@return boolean #If `true`, a mission was found and requested.
function LEGION:CheckMissionQueue() end

---Check transport queue and assign ONE transport.
---
------
---@return boolean #If `true`, a transport was found and requested.
function LEGION:CheckTransportQueue() end

---Count total number of assets of the legion.
---
------
---@param InStock boolean If `true`, only assets that are in the warehouse stock/inventory are counted. If `false`, only assets that are NOT in stock (i.e. spawned) are counted. If `nil`, all assets are counted.
---@param MissionTypes? table (Optional) Count only assest that can perform certain mission type(s). Default is all types.
---@param Attributes? table (Optional) Count only assest that have a certain attribute(s), e.g. `GROUP.Attribute.AIR_BOMBER`.
---@return number #Amount of asset groups in stock.
function LEGION:CountAssets(InStock, MissionTypes, Attributes) end

---Count assets on mission.
---
------
---@param MissionTypes table Types on mission to be checked. Default all.
---@param Cohort COHORT Only count assets of this cohort. Default count assets of all cohorts.
---@return number #Number of pending and queued assets.
---@return number #Number of pending assets.
---@return number #Number of queued assets.
function LEGION:CountAssetsOnMission(MissionTypes, Cohort) end

---Count total number of assets in LEGION warehouse stock that also have a payload.
---
------
---@param Payloads? boolean (Optional) Specifc payloads to consider. Default all.
---@param MissionTypes? table (Optional) Count only assest that can perform certain mission type(s). Default is all types.
---@param Attributes? table (Optional) Count only assest that have a certain attribute(s), e.g. `WAREHOUSE.Attribute.AIR_BOMBER`.
---@return number #Amount of asset groups in stock.
function LEGION:CountAssetsWithPayloadsInStock(Payloads, MissionTypes, Attributes) end

---Count missions in mission queue.
---
------
---@param MissionTypes table Types on mission to be checked. Default *all* possible types `AUFTRAG.Type`.
---@return number #Number of missions that are not over yet.
function LEGION:CountMissionsInQueue(MissionTypes) end

---Count payloads in stock.
---
------
---@param MissionTypes table Types on mission to be checked. Default *all* possible types `AUFTRAG.Type`.
---@param UnitTypes table Types of units.
---@param Payloads table Specific payloads to be counted only.
---@return number #Count of available payloads in stock.
function LEGION:CountPayloadsInStock(MissionTypes, UnitTypes, Payloads) end

---Remove specific asset from legion.
---
------
---@param Asset WAREHOUSE.Assetitem The asset.
---@return LEGION #self
function LEGION:DelAsset(Asset) end

---Remove cohort from cohor table of this legion.
---
------
---@param Cohort COHORT The cohort to be added.
---@return LEGION #self
function LEGION:DelCohort(Cohort) end

---Fetch a payload from the airwing resources for a given unit and mission type.
---The payload with the highest priority is preferred.
---
------
---@param UnitType string The type of the unit.
---@param MissionType string The mission type.
---@param Payloads table Specific payloads only to be considered.
---@return AIRWING.Payload #Payload table or *nil*.
function LEGION:FetchPayloadFromStock(UnitType, MissionType, Payloads) end

---Get the unit types of this legion.
---These are the unit types of all assigned cohorts.
---
------
---@param onlyactive boolean Count only the active ones.
---@param cohorts table Table of cohorts. Default all.
---@return table #Table of unit types.
function LEGION:GetAircraftTypes(onlyactive, cohorts) end

---Get the current mission of the asset.
---
------
---@param asset WAREHOUSE.Assetitem The asset.
---@return AUFTRAG #Current mission or *nil*.
function LEGION:GetAssetCurrentMission(asset) end

---Get assets on mission.
---
------
---@param MissionTypes table Types on mission to be checked. Default all.
---@return table #Assets on pending requests.
function LEGION:GetAssetsOnMission(MissionTypes) end

---Returns the mission for a given mission ID (Autragsnummer).
---
------
---@param mid number Mission ID (Auftragsnummer).
---@return AUFTRAG #Mission table.
function LEGION:GetMissionByID(mid) end

---Returns the mission for a given request.
---
------
---@param Request WAREHOUSE.Queueitem The warehouse request.
---@return AUFTRAG #Mission table or *nil*.
function LEGION:GetMissionFromRequest(Request) end

---Returns the mission for a given request ID.
---
------
---@param RequestID number Unique ID of the request.
---@return AUFTRAG #Mission table or *nil*.
function LEGION:GetMissionFromRequestID(RequestID) end

---Get name of legion.
---This is the alias of the warehouse.
---
------
---@return string #Name of legion.
function LEGION:GetName() end

---Get OPSGROUPs that are spawned and alive.
---
------
---@param MissionTypes? table (Optional) Get only assest that can perform certain mission type(s). Default is all types.
---@param Attributes? table (Optional) Get only assest that have a certain attribute(s), e.g. `WAREHOUSE.Attribute.AIR_BOMBER`.
---@return SET_OPSGROUP #The set of OPSGROUPs. Can be empty if no groups are spawned or alive!
function LEGION:GetOpsGroups(MissionTypes, Attributes) end

---Returns the mission for a given ID.
---
------
---@param uid number Transport UID.
---@return OPSTRANSPORT #Transport assignment.
function LEGION:GetTransportByID(uid) end

---Check if the AIRWING class is calling.
---
------
---@return boolean #If true, this is an AIRWING.
function LEGION:IsAirwing() end

---Check if an asset is currently on a mission (STARTED or EXECUTING).
---
------
---@param asset WAREHOUSE.Assetitem The asset.
---@param MissionTypes table Types on mission to be checked. Default all.
---@return boolean #If true, asset has at least one mission of that type in the queue.
function LEGION:IsAssetOnMission(asset, MissionTypes) end

---Check if a BRIGADE class is calling.
---
------
---@return boolean #If true, this is a BRIGADE.
function LEGION:IsBrigade() end

---Check if cohort is part of this legion.
---
------
---@param CohortName string Name of the platoon.
---@return boolean #If `true`, cohort is part of this legion.
function LEGION:IsCohort(CohortName) end

---Check if the FLEET class is calling.
---
------
---@return boolean #If true, this is a FLEET.
function LEGION:IsFleet() end

---Triggers the FSM event "LegionAssetReturned".
---
------
---@param Cohort COHORT The cohort the asset belongs to.
---@param Asset WAREHOUSE.Assetitem The asset that returned.
function LEGION:LegionAssetReturned(Cohort, Asset) end

---Triggers the FSM event "MissionAssign".
---
------
---@param Mission AUFTRAG The mission.
---@param Legions table The legion(s) from which the mission assets are requested.
function LEGION:MissionAssign(Mission, Legions) end

---Triggers the FSM event "MissionCancel".
---
------
---@param Mission AUFTRAG The mission.
function LEGION:MissionCancel(Mission) end

---Triggers the FSM event "MissionRequest".
---
------
---@param Mission AUFTRAG The mission.
---@param Assets? table (Optional) Assets to add.
function LEGION:MissionRequest(Mission, Assets) end

---Create a new LEGION class object.
---
------
---@param WarehouseName string Name of the warehouse STATIC or UNIT object representing the warehouse.
---@param LegionName string Name of the legion. Must be **unique**!
---@return LEGION #self
function LEGION:New(WarehouseName, LegionName) end

---On after "LegionAssetReturned" event.
---Triggered when an asset group returned to its Legion.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Cohort COHORT The cohort the asset belongs to.
---@param Asset WAREHOUSE.Assetitem The asset that returned.
function LEGION:OnAfterLegionAssetReturned(From, Event, To, Cohort, Asset) end

---On after "MissionAssign" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Mission AUFTRAG The mission.
---@param Legions table The legion(s) from which the mission assets are requested.
function LEGION:OnAfterMissionAssign(From, Event, To, Mission, Legions) end

---On after "MissionCancel" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Mission AUFTRAG The mission.
function LEGION:OnAfterMissionCancel(From, Event, To, Mission) end

---On after "MissionRequest" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Mission AUFTRAG The mission.
---@param Assets? table (Optional) Assets to add.
function LEGION:OnAfterMissionRequest(From, Event, To, Mission, Assets) end

---On after "OpsOnMission" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param OpsGroup OPSGROUP The OPS group on mission.
---@param Mission AUFTRAG The mission.
function LEGION:OnAfterOpsOnMission(From, Event, To, OpsGroup, Mission) end

---On after "TransportAssign" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Transport OPSTRANSPORT The transport.
---@param Legions table The legion(s) to which this transport is assigned.
function LEGION:OnAfterTransportAssign(From, Event, To, Transport, Legions) end

---On after "TransportCancel" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Transport OPSTRANSPORT The transport.
function LEGION:OnAfterTransportCancel(From, Event, To, Transport) end

---On after "TransportRequest" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Transport OPSTRANSPORT The transport.
function LEGION:OnAfterTransportRequest(From, Event, To, Transport) end

---Triggers the FSM event "OpsOnMission".
---
------
---@param OpsGroup OPSGROUP The OPS group on mission.
---@param Mission AUFTRAG The mission.
function LEGION:OpsOnMission(OpsGroup, Mission) end

---Recruit assets performing an escort mission for a given asset.
---
------
---@param Mission AUFTRAG The mission.
---@param Assets table Table of assets.
---@return boolean #If `true`, enough assets could be recruited or no escort was required in the first place.
function LEGION:RecruitAssetsForEscort(Mission, Assets) end

---Recruit assets for a given mission.
---
------
---@param Mission AUFTRAG The mission.
---@return boolean #If `true` enough assets could be recruited.
---@return table #Recruited assets.
---@return table #Legions of recruited assets.
function LEGION:RecruitAssetsForMission(Mission) end

---Recruit assets for a given OPS transport.
---
------
---@param Transport OPSTRANSPORT The OPS transport.
---@return boolean #If `true`, enough assets could be recruited.
---@return table #assets Recruited assets.
---@return table #legions Legions of recruited assets.
function LEGION:RecruitAssetsForTransport(Transport) end

---Recruit assets from Cohorts for the given parameters.
---**NOTE** that we set the `asset.isReserved=true` flag so it cannot be recruited by anyone else.
---
------
---@param MissionTypeRecruit string Mission type for recruiting the cohort assets.
---@param MissionTypeOpt string Mission type for which the assets are optimized. Default is the same as `MissionTypeRecruit`.
---@param NreqMin number Minimum number of required assets.
---@param NreqMax number Maximum number of required assets.
---@param TargetVec2 Vec2 Target position as 2D vector.
---@param Payloads table Special payloads.
---@param RangeMax number Max range in meters.
---@param RefuelSystem number Refuelsystem.
---@param CargoWeight number Cargo weight for recruiting transport carriers.
---@param TotalWeight number Total cargo weight in kg.
---@param MaxWeight number Max weight [kg] of the asset group.
---@param Categories table Group categories. 
---@param Attributes table Group attributes. See `GROUP.Attribute.`
---@param Properties table DCS attributes.
---@param WeaponTypes table Bit of weapon types.
---@return boolean #If `true` enough assets could be recruited.
---@return table #Recruited assets. **NOTE** that we set the `asset.isReserved=true` flag so it cant be recruited by anyone else.
---@return table #Legions of recruited assets.
function LEGION.RecruitCohortAssets(Cohorts, MissionTypeRecruit, MissionTypeOpt, NreqMin, NreqMax, TargetVec2, Payloads, RangeMax, RefuelSystem, CargoWeight, TotalWeight, MaxWeight, Categories, Attributes, Properties, WeaponTypes) end

---Relocate a cohort to another legion.
---Assets in stock are spawned and routed to the new legion.
---If assets are spawned, running missions will be cancelled.
---Cohort assets will not be available until relocation is finished.
---
------
---@param Cohort COHORT The cohort to be relocated.
---@param Legion LEGION The legion where the cohort is relocated to.
---@param Delay number Delay in seconds before relocation takes place. Default `nil`, *i.e.* ASAP.
---@param NcarriersMin number Min number of transport carriers in case the troops should be transported. Default `nil` for no transport.
---@param NcarriersMax number Max number of transport carriers.
---@param TransportLegions table Legion(s) assigned for transportation. Default is that transport assets can only be recruited from this legion.
---@return LEGION #self
function LEGION:RelocateCohort(Cohort, Legion, Delay, NcarriersMin, NcarriersMax, TransportLegions) end

---Remove mission from queue.
---
------
---@param Mission AUFTRAG Mission to be removed.
---@return LEGION #self
function LEGION:RemoveMission(Mission) end

---Return payload from asset back to stock.
---
------
---@param asset WAREHOUSE.Assetitem The squadron asset.
function LEGION:ReturnPayloadFromAsset(asset) end

---Set tactical overview on.
---
------
---@return LEGION #self
function LEGION:SetTacticalOverviewOn() end

---Set verbosity level.
---
------
---@param VerbosityLevel number Level of output (higher=more). Default 0.
---@return LEGION #self
function LEGION:SetVerbosity(VerbosityLevel) end

---Triggers the FSM event "Start".
---Starts the LEGION. Initializes parameters and starts event handlers.
---
------
function LEGION:Start() end

---Triggers the FSM event "TransportAssign".
---
------
---@param Transport OPSTRANSPORT The transport.
---@param Legions table The legion(s) to which this transport is assigned.
function LEGION:TransportAssign(Transport, Legions) end

---Triggers the FSM event "TransportCancel".
---
------
---@param Transport OPSTRANSPORT The transport.
function LEGION:TransportCancel(Transport) end

---Triggers the FSM event "TransportRequest".
---
------
---@param Transport OPSTRANSPORT The transport.
function LEGION:TransportRequest(Transport) end

---Unrecruit assets.
---Set `isReserved` to false, return payload to airwing and (optionally) remove from assigned mission.
---
------
---@param Mission? AUFTRAG (Optional) The mission from which the assets will be deleted.
function LEGION.UnRecruitAssets(Assets, Mission) end

---Create a request and add it to the warehouse queue.
---
------
---@param AssetDescriptor WAREHOUSE.Descriptor Descriptor describing the asset that is requested.
---@param AssetDescriptorValue NOTYPE Value of the asset descriptor. Type depends on descriptor, i.e. could be a string, etc.
---@param nAsset number Number of groups requested that match the asset specification.
---@param Prio number Priority of the request. Number ranging from 1=high to 100=low.
---@param Assignment string A keyword or text that can later be used to identify this request and postprocess the assets.
---@return WAREHOUSE.Queueitem #The request.
function LEGION:_AddRequest(AssetDescriptor, AssetDescriptorValue, nAsset, Prio, Assignment) end

---Recruit assets from Cohorts for the given parameters.
---**NOTE** that we set the `asset.isReserved=true` flag so it cant be recruited by anyone else.
---
------
---@param MissionType string Misson type(s).
---@param Categories table Group categories.
---@param Attributes table Group attributes. See `GROUP.Attribute.`
---@param Properties table DCS attributes.
---@param WeaponTypes table Bit of weapon types.
---@param TargetVec2 Vec2 Target position.
---@param RangeMax NOTYPE Max range in meters.
---@param RefuelSystem number Refueling system (boom or probe).
---@param CargoWeight number Cargo weight [kg]. This checks the cargo bay of the cohort assets and ensures that it is large enough to carry the given cargo weight.
---@param MaxWeight number Max weight [kg]. This checks whether the cohort asset group is not too heavy.
---@return boolean #Returns `true` if given cohort can meet all requirements.
function LEGION._CohortCan(Cohort, MissionType, Categories, Attributes, Properties, WeaponTypes, TargetVec2, RangeMax, RefuelSystem, CargoWeight, MaxWeight) end

---Count payloads of all cohorts for all unit types.
---
------
---@param MissionType string Mission type.
---@param Cohorts table Cohorts included.
---@param Payloads? table (Optional) Special payloads.
---@return table #Table of payloads for each unit type.
function LEGION:_CountPayloads(MissionType, Cohorts, Payloads) end

---Create a new OPS group after an asset was spawned.
---
------
---@param asset WAREHOUSE.Assetitem The asset.
---@return FLIGHTGROUP #The created flightgroup object.
function LEGION:_CreateFlightGroup(asset) end

---Get cohort by name.
---
------
---@param CohortName string Name of the platoon.
---@return COHORT #The Cohort object.
function LEGION:_GetCohort(CohortName) end

---Get cohort of an asset.
---
------
---@param Asset WAREHOUSE.Assetitem The asset.
---@return COHORT #The Cohort object.
function LEGION:_GetCohortOfAsset(Asset) end

---Get cohorts.
---
------
---@param Cohorts table Special cohorts.
---@param Operation OPERATION Operation.
---@param OpsQueue table Queue of operations.
---@return table #Cohorts.
function LEGION._GetCohorts(Legions, Cohorts, Operation, OpsQueue) end

---Optimize chosen assets for the mission at hand.
---
------
---@param MissionType string Mission type.
---@param TargetVec2 Vec2 Target position as 2D vector.
---@param IncludePayload boolean If `true`, include the payload in the calulation if the asset has one attached.
---@param TotalWeight number The total weight of the cargo to be transported, if applicable.
function LEGION._OptimizeAssetSelection(assets, MissionType, TargetVec2, IncludePayload, TotalWeight) end

---Display tactical overview.
---
------
function LEGION:_TacticalOverview() end

---Triggers the FSM event "LegionAssetReturned" after a delay.
---
------
---@param delay number Delay in seconds. 
---@param Cohort COHORT The cohort the asset belongs to.
---@param Asset WAREHOUSE.Assetitem The asset that returned.
function LEGION:__LegionAssetReturned(delay, Cohort, Asset) end

---Triggers the FSM event "MissionAssign" after a delay.
---
------
---@param delay number Delay in seconds.
---@param Mission AUFTRAG The mission.
---@param Legions table The legion(s) from which the mission assets are requested.
function LEGION:__MissionAssign(delay, Mission, Legions) end

---Triggers the FSM event "MissionCancel" after a delay.
---
------
---@param delay number Delay in seconds.
---@param Mission AUFTRAG The mission.
function LEGION:__MissionCancel(delay, Mission) end

---Triggers the FSM event "MissionRequest" after a delay.
---
------
---@param delay number Delay in seconds.
---@param Mission AUFTRAG The mission.
---@param Assets? table (Optional) Assets to add.
function LEGION:__MissionRequest(delay, Mission, Assets) end

---Triggers the FSM event "OpsOnMission" after a delay.
---
------
---@param delay number Delay in seconds.
---@param OpsGroup OPSGROUP The OPS group on mission.
---@param Mission AUFTRAG The mission.
function LEGION:__OpsOnMission(delay, OpsGroup, Mission) end

---Triggers the FSM event "Start" after a delay.
---Starts the LEGION. Initializes parameters and starts event handlers.
---
------
---@param delay number Delay in seconds.
function LEGION:__Start(delay) end

---Triggers the FSM event "Stop" after a delay.
---Stops the LEGION and all its event handlers.
---
------
---@param delay number Delay in seconds.
function LEGION:__Stop(delay) end

---Triggers the FSM event "TransportAssign" after a delay.
---
------
---@param delay number Delay in seconds.
---@param Transport OPSTRANSPORT The transport.
---@param Legions table The legion(s) to which this transport is assigned.
function LEGION:__TransportAssign(delay, Transport, Legions) end

---Triggers the FSM event "TransportCancel" after a delay.
---
------
---@param delay number Delay in seconds.
---@param Transport OPSTRANSPORT The transport.
function LEGION:__TransportCancel(delay, Transport) end

---Triggers the FSM event "TransportRequest" after a delay.
---
------
---@param delay number Delay in seconds.
---@param Transport OPSTRANSPORT The transport.
function LEGION:__TransportRequest(delay, Transport) end

---On after "AssetDead" event triggered when an asset group died.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param asset WAREHOUSE.Assetitem The asset that is dead.
---@param request WAREHOUSE.Pendingitem The request of the dead asset.
---@private
function LEGION:onafterAssetDead(From, Event, To, asset, request) end

---On after "AssetSpawned" event triggered when an asset group is spawned into the cruel world.
---Creates a new flightgroup element and adds the mission to the flightgroup queue.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param group GROUP The group spawned.
---@param asset WAREHOUSE.Assetitem The asset that was spawned.
---@param request WAREHOUSE.Pendingitem The request of the dead asset.
---@private
function LEGION:onafterAssetSpawned(From, Event, To, group, asset, request) end

---On after "Captured" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Coalition coalition.side which captured the warehouse.
---@param Country country.id which has captured the warehouse.
---@private
function LEGION:onafterCaptured(From, Event, To, Coalition, Country) end

---On after "Destroyed" event.
---Remove assets from cohorts. Stop cohorts.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function LEGION:onafterDestroyed(From, Event, To) end

---On after "LegionAssetReturned" event.
---Triggered when an asset group returned to its legion.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Cohort COHORT The cohort the asset belongs to.
---@param Asset WAREHOUSE.Assetitem The asset that returned.
---@private
function LEGION:onafterLegionAssetReturned(From, Event, To, Cohort, Asset) end

---On after "MissionAssign" event.
---Mission is added to a LEGION mission queue and already requested. Needs assets to be added to the mission already.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Mission AUFTRAG The mission.
---@param Legions table The LEGIONs.
---@private
function LEGION:onafterMissionAssign(From, Event, To, Mission, Legions) end

---On after "MissionCancel" event.
---Cancels the missions of all flightgroups. Deletes request from warehouse queue.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Mission AUFTRAG The mission to be cancelled.
---@private
function LEGION:onafterMissionCancel(From, Event, To, Mission) end

---On after "MissionRequest" event.
---Performs a self request to the warehouse for the mission assets. Sets mission status to REQUESTED.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Mission AUFTRAG The requested mission.
---@param Assets? table (Optional) Assets to add.
---@private
function LEGION:onafterMissionRequest(From, Event, To, Mission, Assets) end

---On after "NewAsset" event.
---Asset is added to the given cohort (asset assignment).
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param asset WAREHOUSE.Assetitem The asset that has just been added.
---@param assignment? string The (optional) assignment for the asset.
---@private
function LEGION:onafterNewAsset(From, Event, To, asset, assignment) end

---On after "OpsOnMission".
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param OpsGroup OPSGROUP Ops group on mission
---@param Mission AUFTRAG The requested mission.
---@private
function LEGION:onafterOpsOnMission(From, Event, To, OpsGroup, Mission) end

---On after "Request" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Request WAREHOUSE.Queueitem Information table of the request.
---@private
function LEGION:onafterRequest(From, Event, To, Request) end

---On after "RequestSpawned" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Request WAREHOUSE.Pendingitem Information table of the request.
---@param CargoGroupSet SET_GROUP Set of cargo groups.
---@param TransportGroupSet SET_GROUP Set of transport groups if any.
---@private
function LEGION:onafterRequestSpawned(From, Event, To, Request, CargoGroupSet, TransportGroupSet) end

---On after "SelfRequest" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param groupset SET_GROUP The set of asset groups that was delivered to the warehouse itself.
---@param request WAREHOUSE.Pendingitem Pending self request.
---@private
function LEGION:onafterSelfRequest(From, Event, To, groupset, request) end

---Start LEGION FSM.
---
------
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@private
function LEGION:onafterStart(From, Event, To) end

---On after "TransportAssign" event.
---Transport is added to a LEGION transport queue and assets are requested from the LEGION warehouse.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Transport OPSTRANSPORT The transport.
---@param Legions table The legion(s) to which the transport is assigned.
---@private
function LEGION:onafterTransportAssign(From, Event, To, Transport, Legions) end

---On after "TransportCancel" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Transport OPSTRANSPORT The transport to be cancelled.
---@private
function LEGION:onafterTransportCancel(From, Event, To, Transport) end

---On after "TransportRequest" event.
---Performs a self request to the warehouse for the transport assets. Sets transport status to REQUESTED.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Opstransport OPSTRANSPORT The requested mission.
---@param OpsTransport NOTYPE 
---@private
function LEGION:onafterTransportRequest(From, Event, To, Opstransport, OpsTransport) end



