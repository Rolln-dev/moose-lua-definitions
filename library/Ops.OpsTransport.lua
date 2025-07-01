---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/OPS_OpsTransport.png" width="100%">
---
---**Ops** - Transport assignment for OPS groups and storage.
---
---## Main Features:
---
---   * Transport troops from A to B
---   * Transport of warehouse storage (fuel, weapons and equipment)
---   * Supports ground, naval and airborne (airplanes and helicopters) units as carriers
---   * Use combined forces (ground, naval, air) to transport the troops
---   * Additional FSM events to hook into and customize your mission design
---
---===
---
---## Example Missions:
---
---Demo missions can be found on [github](https://github.com/FlightControl-Master/MOOSE_MISSIONS/tree/develop/Ops/Transport).
---   
---===
---
---### Author: **funkyfranky**
---
---===
---*Victory is the beautiful, bright-colored flower; Transport is the stem without which it could never have blossomed* -- Winston Churchill
---
---===
---
---# The OPSTRANSPORT Concept
---
---This class simulates troop transport using carriers such as APCs, ships, helicopters or airplanes.
---The carriers and transported groups need to be OPSGROUPS (see ARMYGROUP, NAVYGROUP and FLIGHTGROUP classes).
---
---**IMPORTANT NOTES**
---
---* Cargo groups are **not** split and distributed into different carrier *units*. That means that the whole cargo group **must fit** into one of the carrier units.
---* Cargo groups must be inside the pickup zones to be considered for loading. Groups not inside the pickup zone will not get the command to board. 
---
---# Troop Transport
---
---A new cargo transport assignment is created with the #OPSTRANSPORT.New() function
---
---    local opstransport=OPSTRANSPORT:New(Cargo, PickupZone, DeployZone)
---
---Here `Cargo` is an object of the troops to be transported. This can be a GROUP, OPSGROUP, SET_GROUP or SET_OPSGROUP object.
---
---`PickupZone` is the zone where the troops are picked up by the transport carriers. **Note** that troops *must* be inside this zone to be considered for loading!
---
---`DeployZone` is the zone where the troops are transported to.
---
---## Assign to Carrier(s)
---
---A transport can be assigned to one or multiple carrier OPSGROUPS with this Ops.OpsGroup#OPSGROUP.AddOpsTransport() function
---
---    myopsgroup:AddOpsTransport(opstransport)
---
---There is no restriction to the type of the carrier. It can be a ground group (e.g. an APC), a helicopter, an airplane or even a ship.
---
---You can also mix carrier types. For instance, you can assign the same transport to APCs and helicopters. Or to helicopters and airplanes.
---
---# Storage Transport
---
---An instance of the OPSTRANSPORT class is created similarly to the troop transport case. However, the first parameter is `nil` as not troops 
---are transported.
---
---    local storagetransport=OPSTRANSPORT:New(nil, PickupZone, DeployZone) 
---
---## Defining Storage
---
---The storage warehouses from which the cargo is taken and to which the cargo is delivered have to be specified
---
---    storagetransport:AddCargoStorage(berlinStorage, batumiStorage, STORAGE.Liquid.JETFUEL, 1000)
---    
---Here `berlinStorage` and `batumiStorage` are Wrapper.Storage#STORAGE objects of DCS warehouses. 
---
---Furthermore, that type of cargo (liquids or weapons/equipment) and the amount has to be specified. If weapons/equipment is the cargo,
---we also need to specify the weight per storage item as this cannot be retrieved from the DCS API and is not stored in any MOOSE database.
---
---    storagetransport:AddCargoStorage(berlinStorage, batumiStorage, ENUMS.Storage.weapons.bombs.Mk_82, 9, 230)     
---
---Finally, the transport is assigned to one or multiple groups, which carry out the transport
---
---    myopsgroup:AddOpsTransport(storagetransport)
---
---# Examples
---
---A carrier group is assigned to transport infantry troops from zone "Zone Kobuleti X" to zone "Zone Alpha".
---
---    -- Carrier group.
---    local carrier=ARMYGROUP:New("TPz Fuchs Group")
---      
---    -- Set of groups to transport.
---    local infantryset=SET_GROUP:New():FilterPrefixes("Infantry Platoon Alpha"):FilterOnce()
---    
---    -- Cargo transport assignment.
---    local opstransport=OPSTRANSPORT:New(infantryset, ZONE:New("Zone Kobuleti X"), ZONE:New("Zone Alpha"))
---    
---    -- Assign transport to carrier.
---    carrier:AddOpsTransport(opstransport)
---OPSTRANSPORT class.
---@class OPSTRANSPORT : FSM
---@field CargoType OPSTRANSPORT.CargoType 
---@field ClassName string Name of the class.
---@field Ncargo number Total number of cargo groups.
---@field NcargoDead number Totalnumber of dead cargo groups.
---@field Ncarrier number Total number of assigned carriers.
---@field NcarrierDead number Total number of dead carrier groups
---@field Ndelivered number Total number of cargo groups delivered.
---@field Status OPSTRANSPORT.Status 
---@field Tover NOTYPE 
---@field Tstart number Start time in *abs.* seconds.
---@field Tstop number Stop time in *abs.* seconds. Default `#nil` (never stops).
---@field private assets table Warehouse assets assigned for this transport.
---@field private cargocounter number Running number to generate cargo UIDs.
---@field private carrierTransportStatus table Status of each carrier.
---@field private carriers table Carriers assigned for this transport.
---@field private chief CHIEF Chief of the transport.
---@field private commander COMMANDER Commander of the transport.
---@field private conditionStart table Start conditions.
---@field private duration number Duration (`Tstop-Tstart`) of the transport in seconds.
---@field private formationArmy string Default formation for ground vehicles.
---@field private formationHelo string Default formation for helicopters.
---@field private formationPlane string Default formation for airplanes.
---@field private importance number Importance of this transport. Smaller=higher.
---@field private legions table Assigned legions.
---@field private lid string Log ID.
---@field private mission AUFTRAG The mission attached to this transport.
---@field private opszone OPSZONE OPS zone.
---@field private prio number Priority of this transport. Should be a number between 0 (high prio) and 100 (low prio).
---@field private requestID table The ID of the queued warehouse request. Necessary to cancel the request if the transport was cancelled before the request is processed.
---@field private statusCommander string Staus of the COMMANDER.
---@field private statusLegion table Transport status of all assigned LEGIONs.
---@field private tzCombos table Table of transport zone combos. Each element of the table is of type `#OPSTRANSPORT.TransportZoneCombo`.
---@field private tzcCounter number Running number of added transport zone combos.
---@field private tzcDefault OPSTRANSPORT.TransportZoneCombo Default transport zone combo.
---@field private uid number Unique ID of the transport.
---@field private urgent boolean If true, transport is urgent.
---@field private verbose number Verbosity level.
---@field private version string Army Group version.
OPSTRANSPORT = {}

---Add carrier asset to transport.
---
------
---@param self OPSTRANSPORT 
---@param Asset WAREHOUSE.Assetitem The asset to be added.
---@param TransportZoneCombo OPSTRANSPORT.TransportZoneCombo Transport zone combo.
---@return OPSTRANSPORT #self
function OPSTRANSPORT:AddAsset(Asset, TransportZoneCombo) end

---Add cargo asset.
---
------
---@param self OPSTRANSPORT 
---@param Asset WAREHOUSE.Assetitem The asset to be added.
---@param TransportZoneCombo OPSTRANSPORT.TransportZoneCombo Transport zone combo.
---@return OPSTRANSPORT #self
function OPSTRANSPORT:AddAssetCargo(Asset, TransportZoneCombo) end

---Add cargo groups to be transported.
---
------
---@param self OPSTRANSPORT 
---@param GroupSet SET_GROUP Set of groups to be transported. Can also be passed as a single GROUP or OPSGROUP object.
---@param TransportZoneCombo OPSTRANSPORT.TransportZoneCombo Transport zone combo.
---@param DisembarkActivation boolean If `true`, cargo group is activated when disembarked. If `false`, cargo groups are late activated when disembarked. Default `nil` (usually activated).
---@param DisembarkZone ZONE Zone where the groups disembark to.
---@param DisembarkCarriers SET_OPSGROUP Carrier groups where the cargo directly disembarks to.
---@return OPSTRANSPORT #self
function OPSTRANSPORT:AddCargoGroups(GroupSet, TransportZoneCombo, DisembarkActivation, DisembarkZone, DisembarkCarriers) end

---Add cargo warehouse storage to be transported.
---This adds items such as fuel, weapons and other equipment, which is to be transported
---from one DCS warehouse to another.
---For weapons and equipment, the weight per item has to be specified explicitly as these cannot be retrieved by the DCS API. For liquids the
---default value of 1 kg per item should be used as the amount of liquid is already given in kg.
---
------
---@param self OPSTRANSPORT 
---@param StorageFrom STORAGE Storage warehouse from which the cargo is taken.
---@param StorageTo STORAGE Storage warehouse to which the cargo is delivered.
---@param CargoType string Type of cargo, *e.g.* `"weapons.bombs.Mk_84"` or liquid type as #number.
---@param CargoAmount number Amount of cargo. Liquids in kg.
---@param CargoWeight number Weight of a single cargo item in kg. Default 1 kg.
---@param TransportZoneCombo OPSTRANSPORT.TransportZoneCombo Transport zone combo if other than default.
---@return OPSTRANSPORT #self
function OPSTRANSPORT:AddCargoStorage(StorageFrom, StorageTo, CargoType, CargoAmount, CargoWeight, TransportZoneCombo) end

---Add start condition.
---
------
---@param self OPSTRANSPORT 
---@param ConditionFunction function Function that needs to be true before the transport can be started. Must return a #boolean.
---@param ... NOTYPE Condition function arguments if any.
---@return OPSTRANSPORT #self
function OPSTRANSPORT:AddConditionStart(ConditionFunction, ...) end

---Add LEGION to the transport.
---
------
---@param self OPSTRANSPORT 
---@param Legion LEGION The legion.
---@return OPSTRANSPORT #self
function OPSTRANSPORT:AddLegion(Legion) end

---Add path used for transportation from the pickup to the deploy zone.
---If multiple paths are defined, a random one is chosen. The path is retrieved from the waypoints of a given group.
---**NOTE** that the category group defines for which carriers this path is valid.
---For example, if you specify a GROUND group to provide the waypoints, only assigned GROUND carriers will use the
---path.
---
------
---@param self OPSTRANSPORT 
---@param PathGroup GROUP A (late activated) GROUP defining a transport path by their waypoints.
---@param Radius number Randomization radius in meters. Default 0 m.
---@param TransportZoneCombo OPSTRANSPORT.TransportZoneCombo Transport Zone combo.
---@param Reversed NOTYPE 
---@return OPSTRANSPORT #self
function OPSTRANSPORT:AddPathTransport(PathGroup, Radius, TransportZoneCombo, Reversed) end

---Add pickup and deploy zone combination.
---
------
---@param self OPSTRANSPORT 
---@param CargoGroups SET_GROUP Groups to be transported as cargo. Can also be a single @{Wrapper.Group#GROUP} or @{Ops.OpsGroup#OPSGROUP} object.
---@param PickupZone ZONE Zone where the troops are picked up.
---@param DeployZone ZONE Zone where the troops are picked up.
---@return OPSTRANSPORT.TransportZoneCombo #Transport zone table.
function OPSTRANSPORT:AddTransportZoneCombo(CargoGroups, PickupZone, DeployZone) end

---Triggers the FSM event "Cancel".
---
------
---@param self OPSTRANSPORT 
function OPSTRANSPORT:Cancel() end

---Delete carrier asset from transport.
---
------
---@param self OPSTRANSPORT 
---@param Asset WAREHOUSE.Assetitem The asset to be removed.
---@return OPSTRANSPORT #self
function OPSTRANSPORT:DelAsset(Asset) end

---Triggers the FSM event "Delivered".
---
------
---@param self OPSTRANSPORT 
function OPSTRANSPORT:Delivered() end

---Check if all given condition are true.
---
------
---@param self OPSTRANSPORT 
---@param Conditions table Table of conditions.
---@return boolean #If true, all conditions were true. Returns false if at least one condition returned false.
function OPSTRANSPORT:EvalConditionsAll(Conditions) end

---Triggers the FSM event "Executing".
---
------
---@param self OPSTRANSPORT 
function OPSTRANSPORT:Executing() end

---Find transfer carrier element for cargo group.
---
------
---@param self OPSTRANSPORT 
---@param CargoGroup OPSGROUP The cargo group that needs to be loaded into a carrier unit/element of the carrier group.
---@param Zone? ZONE (Optional) Zone where the carrier must be in.
---@param DisembarkCarriers table Disembark carriers.
---@param DeployAirbase AIRBASE Airbase where to deploy.
---@return OPSGROUP.Element #New carrier element for cargo or nil.
---@return OPSGROUP #New carrier group for cargo or nil.
function OPSTRANSPORT:FindTransferCarrierForCargo(CargoGroup, Zone, DisembarkCarriers, DeployAirbase) end

---Get (all) cargo Ops.OpsGroup#OPSGROUPs.
---Optionally, only delivered or undelivered groups can be returned.
---
------
---@param self OPSTRANSPORT 
---@param Delivered boolean If `true`, only delivered groups are returned. If `false` only undelivered groups are returned. If `nil`, all groups are returned.
---@param Carrier? OPSGROUP (Optional) Only count cargo groups that fit into the given carrier group. Current cargo is not a factor.
---@param TransportZoneCombo OPSTRANSPORT.TransportZoneCombo Transport zone combo.
---@return table #Cargo Ops groups. Can be and empty table `{}`.
function OPSTRANSPORT:GetCargoOpsGroups(Delivered, Carrier, TransportZoneCombo) end

---Get (all) cargo Ops.OpsGroup#OPSGROUPs.
---Optionally, only delivered or undelivered groups can be returned.
---
------
---@param self OPSTRANSPORT 
---@param Delivered boolean If `true`, only delivered groups are returned. If `false` only undelivered groups are returned. If `nil`, all groups are returned.
---@param Carrier? OPSGROUP (Optional) Only count cargo groups that fit into the given carrier group. Current cargo is not a factor.
---@param TransportZoneCombo OPSTRANSPORT.TransportZoneCombo Transport zone combo.
---@return table #Cargo Ops groups. Can be and empty table `{}`.
function OPSTRANSPORT:GetCargoStorages(Delivered, Carrier, TransportZoneCombo) end

---Get total weight.
---
------
---@param self OPSTRANSPORT 
---@param Cargo OPSGROUP.CargoGroup Cargo data.
---@param IncludeReserved boolean Include reserved cargo.
---@return number #Weight in kg.
function OPSTRANSPORT:GetCargoTotalWeight(Cargo, IncludeReserved) end

---Get cargos.
---
------
---@param self OPSTRANSPORT 
---@param TransportZoneCombo OPSTRANSPORT.TransportZoneCombo Transport zone combo.
---@param Carrier OPSGROUP Specific carrier.
---@param Delivered boolean Delivered status.
---@return table #Cargos.
function OPSTRANSPORT:GetCargos(TransportZoneCombo, Carrier, Delivered) end

---Get carrier transport status.
---
------
---@param self OPSTRANSPORT 
---@param CarrierGroup OPSGROUP Carrier OPSGROUP.
---@return string #Carrier status.
function OPSTRANSPORT:GetCarrierTransportStatus(CarrierGroup) end

---Get carriers.
---
------
---@param self OPSTRANSPORT 
---@return table #Carrier Ops groups.
function OPSTRANSPORT:GetCarriers() end

---Get deploy zone.
---
------
---@param self OPSTRANSPORT 
---@param TransportZoneCombo OPSTRANSPORT.TransportZoneCombo Transport zone combo.
---@return ZONE #Zone where the troops are deployed.
function OPSTRANSPORT:GetDeployZone(TransportZoneCombo) end

---Get disembark activation.
---
------
---@param self OPSTRANSPORT 
---@param TransportZoneCombo OPSTRANSPORT.TransportZoneCombo Transport zone combo.
---@return boolean #If `true`, groups are spawned in late activated state.
function OPSTRANSPORT:GetDisembarkActivation(TransportZoneCombo) end

---Get transfer carrier(s).
---These are carrier groups, where the cargo is directly loaded into when disembarked.
---
------
---@param self OPSTRANSPORT 
---@param TransportZoneCombo OPSTRANSPORT.TransportZoneCombo Transport zone combo.
---@return table #Table of carrier OPS groups.
function OPSTRANSPORT:GetDisembarkCarriers(TransportZoneCombo) end

---Get disembark in utero.
---
------
---@param self OPSTRANSPORT 
---@param TransportZoneCombo OPSTRANSPORT.TransportZoneCombo Transport zone combo.
---@return boolean #If `true`, groups stay in utero after disembarkment.
function OPSTRANSPORT:GetDisembarkInUtero(TransportZoneCombo) end

---Get disembark zone.
---
------
---@param self OPSTRANSPORT 
---@param TransportZoneCombo OPSTRANSPORT.TransportZoneCombo Transport zone combo.
---@return ZONE #Zone where the troops are disembarked to.
function OPSTRANSPORT:GetDisembarkZone(TransportZoneCombo) end

---Get embark zone.
---
------
---@param self OPSTRANSPORT 
---@param TransportZoneCombo OPSTRANSPORT.TransportZoneCombo Transport zone combo.
---@return ZONE #Zone where the troops are embarked from.
function OPSTRANSPORT:GetEmbarkZone(TransportZoneCombo) end

---Get LEGION transport status.
---
------
---@param self OPSTRANSPORT 
---@param Legion LEGION The legion.
---@return string #status Current status.
function OPSTRANSPORT:GetLegionStatus(Legion) end

---Get number of delivered cargo groups.
---
------
---@param self OPSTRANSPORT 
---@return number #Total number of delivered cargo groups.
function OPSTRANSPORT:GetNcargoDelivered() end

---Get number of cargo groups.
---
------
---@param self OPSTRANSPORT 
---@return number #Total number of cargo groups.
function OPSTRANSPORT:GetNcargoTotal() end

---Get number of carrier groups assigned for this transport.
---
------
---@param self OPSTRANSPORT 
---@return number #Total number of carrier groups.
function OPSTRANSPORT:GetNcarrier() end

---Get pickup zone.
---
------
---@param self OPSTRANSPORT 
---@param TransportZoneCombo OPSTRANSPORT.TransportZoneCombo Transport zone combo.
---@return ZONE #Zone where the troops are picked up.
function OPSTRANSPORT:GetPickupZone(TransportZoneCombo) end

---Get required cargos.
---This is a list of cargo groups that need to be loaded before the **first** transport will start.
---
------
---@param self OPSTRANSPORT 
---@param TransportZoneCombo OPSTRANSPORT.TransportZoneCombo Transport zone combo.
---@return table #Table of required cargo ops groups.
function OPSTRANSPORT:GetRequiredCargos(TransportZoneCombo) end

---Get the number of required carrier groups for an OPSTRANSPORT assignment.
---Only used if transport is assigned at **LEGION** or higher level.
---
------
---@param self OPSTRANSPORT 
---@return number #Number of carriers *at least* required.
---@return number #Number of carriers *at most* used for transportation.
function OPSTRANSPORT:GetRequiredCarriers() end

---Get transport zone combo of cargo group.
---
------
---@param self OPSTRANSPORT 
---@param GroupName string Group name of cargo.
---@return OPSTRANSPORT.TransportZoneCombo #TransportZoneCombo Transport zone combo.
function OPSTRANSPORT:GetTZCofCargo(GroupName) end

---Get unique ID of the transport assignment.
---
------
---@param self OPSTRANSPORT 
---@return number #UID.
function OPSTRANSPORT:GetUID() end

---Check if a cargo group was delivered.
---
------
---@param self OPSTRANSPORT 
---@param GroupName string Name of the group.
---@return boolean #If `true`, cargo was delivered.
function OPSTRANSPORT:IsCargoDelivered(GroupName) end

---Check if an OPS group is assigned as carrier for this transport.
---
------
---@param self OPSTRANSPORT 
---@param CarrierGroup OPSGROUP Potential carrier OPSGROUP.
---@return boolean #If true, group is an assigned carrier. 
function OPSTRANSPORT:IsCarrier(CarrierGroup) end

---Check if all cargo was delivered (or is dead).
---
------
---@param self OPSTRANSPORT 
---@param Nmin number Number of groups that must be actually delivered (and are not dead). Default 0.
---@return boolean #If true, all possible cargo was delivered. 
function OPSTRANSPORT:IsDelivered(Nmin) end

---Check if state is EXECUTING.
---
------
---@param self OPSTRANSPORT 
---@return boolean #If true, status is EXECUTING. 
function OPSTRANSPORT:IsExecuting() end

---Check if state is PLANNED.
---
------
---@param self OPSTRANSPORT 
---@return boolean #If true, status is PLANNED. 
function OPSTRANSPORT:IsPlanned() end

---Check if state is QUEUED.
---
------
---@param self OPSTRANSPORT 
---@param Legion? LEGION (Optional) Check if transport is queued at this legion.
---@return boolean #If true, status is QUEUED. 
function OPSTRANSPORT:IsQueued(Legion) end

---Check if transport is ready to be started.
---* Start time passed.
---* Stop time did not pass already.
---* All start conditions are true.
---
------
---@param self OPSTRANSPORT 
---@return boolean #If true, mission can be started.
function OPSTRANSPORT:IsReadyToGo() end

---Check if state is REQUESTED.
---
------
---@param self OPSTRANSPORT 
---@param Legion? LEGION (Optional) Check if transport is queued at this legion.
---@return boolean #If true, status is REQUESTED. 
function OPSTRANSPORT:IsRequested(Legion) end

---Check if state is SCHEDULED.
---
------
---@param self OPSTRANSPORT 
---@return boolean #If true, status is SCHEDULED. 
function OPSTRANSPORT:IsScheduled() end

---Triggers the FSM event "Loaded".
---
------
---@param self OPSTRANSPORT 
---@param OpsGroupCargo OPSGROUP OPSGROUP that was loaded into a carrier.
---@param OpsGroupCarrier OPSGROUP OPSGROUP that was loaded into a carrier.
---@param CarrierElement OPSGROUP.Element Carrier element.
function OPSTRANSPORT:Loaded(OpsGroupCargo, OpsGroupCarrier, CarrierElement) end

---Create a new OPSTRANSPORT class object.
---Essential input are the troops that should be transported and the zones where the troops are picked up and deployed.
---
------
---@param self OPSTRANSPORT 
---@param CargoGroups SET_GROUP Groups to be transported as cargo. Can also be a single @{Wrapper.Group#GROUP} or @{Ops.OpsGroup#OPSGROUP} object.
---@param PickupZone ZONE Pickup zone. This is the zone, where the carrier is going to pickup the cargo. **Important**: only cargo is considered, if it is in this zone when the carrier starts loading!
---@param DeployZone ZONE Deploy zone. This is the zone, where the carrier is going to drop off the cargo.
---@return OPSTRANSPORT #self
function OPSTRANSPORT:New(CargoGroups, PickupZone, DeployZone) end

---On after "Cancel" event.
---
------
---@param self OPSTRANSPORT 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function OPSTRANSPORT:OnAfterCancel(From, Event, To) end

---On after "Delivered" event.
---
------
---@param self OPSTRANSPORT 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function OPSTRANSPORT:OnAfterDelivered(From, Event, To) end

---On after "Executing" event.
---
------
---@param self OPSTRANSPORT 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function OPSTRANSPORT:OnAfterExecuting(From, Event, To) end

---On after "Loaded" event.
---
------
---@param self OPSTRANSPORT 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param OpsGroupCargo OPSGROUP OPSGROUP that was loaded into a carrier.
---@param OpsGroupCarrier OPSGROUP OPSGROUP that was loaded into a carrier.
---@param CarrierElement OPSGROUP.Element Carrier element.
function OPSTRANSPORT:OnAfterLoaded(From, Event, To, OpsGroupCargo, OpsGroupCarrier, CarrierElement) end

---On after "Planned" event.
---
------
---@param self OPSTRANSPORT 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function OPSTRANSPORT:OnAfterPlanned(From, Event, To) end

---On after "Queued" event.
---
------
---@param self OPSTRANSPORT 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function OPSTRANSPORT:OnAfterQueued(From, Event, To) end

---On after "Requested" event.
---
------
---@param self OPSTRANSPORT 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function OPSTRANSPORT:OnAfterRequested(From, Event, To) end

---On after "Scheduled" event.
---
------
---@param self OPSTRANSPORT 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function OPSTRANSPORT:OnAfterScheduled(From, Event, To) end

---On after "Unloaded" event.
---
------
---@param self OPSTRANSPORT 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param OpsGroupCargo OPSGROUP Cargo OPSGROUP that was unloaded from a carrier.
---@param OpsGroupCarrier OPSGROUP Carrier OPSGROUP that unloaded the cargo.
function OPSTRANSPORT:OnAfterUnloaded(From, Event, To, OpsGroupCargo, OpsGroupCarrier) end

---Triggers the FSM event "Planned".
---
------
---@param self OPSTRANSPORT 
function OPSTRANSPORT:Planned() end

---Triggers the FSM event "Queued".
---
------
---@param self OPSTRANSPORT 
function OPSTRANSPORT:Queued() end

---Remove LEGION from transport.
---
------
---@param self OPSTRANSPORT 
---@param Legion LEGION The legion.
---@return OPSTRANSPORT #self
function OPSTRANSPORT:RemoveLegion(Legion) end

---Triggers the FSM event "Requested".
---
------
---@param self OPSTRANSPORT 
function OPSTRANSPORT:Requested() end

---Triggers the FSM event "Scheduled".
---
------
---@param self OPSTRANSPORT 
function OPSTRANSPORT:Scheduled() end

---Add a carrier assigned for this transport.
---
------
---@param self OPSTRANSPORT 
---@param CarrierGroup OPSGROUP Carrier OPSGROUP.
---@param Status string Carrier Status.
---@return OPSTRANSPORT #self
function OPSTRANSPORT:SetCarrierTransportStatus(CarrierGroup, Status) end

---Set deploy zone.
---
------
---@param self OPSTRANSPORT 
---@param DeployZone ZONE Zone where the troops are deployed.
---@param TransportZoneCombo OPSTRANSPORT.TransportZoneCombo Transport zone combo.
---@return OPSTRANSPORT #self
function OPSTRANSPORT:SetDeployZone(DeployZone, TransportZoneCombo) end

---Set activation status of group when disembarked from transport carrier.
---
------
---@param self OPSTRANSPORT 
---@param Active boolean If `true` or `nil`, group is activated when disembarked. If `false`, group is late activated and needs to be activated manually.
---@param TransportZoneCombo OPSTRANSPORT.TransportZoneCombo Transport zone combo.
---@return OPSTRANSPORT #self
function OPSTRANSPORT:SetDisembarkActivation(Active, TransportZoneCombo) end

---Set/add transfer carrier(s).
---These are carrier groups, where the cargo is directly loaded into when disembarked.
---
------
---@param self OPSTRANSPORT 
---@param Carriers SET_GROUP Carrier set. Can also be passed as a #GROUP, #OPSGROUP or #SET_OPSGROUP object.
---@param TransportZoneCombo OPSTRANSPORT.TransportZoneCombo Transport zone combo.
---@return OPSTRANSPORT #self
function OPSTRANSPORT:SetDisembarkCarriers(Carriers, TransportZoneCombo) end

---Set if group remains *in utero* after disembarkment from carrier.
---Can be used to directly load the group into another carrier. Similar to disembark in late activated state.
---
------
---@param self OPSTRANSPORT 
---@param InUtero boolean If `true` or `nil`, group remains *in utero* after disembarkment.
---@param TransportZoneCombo OPSTRANSPORT.TransportZoneCombo Transport zone combo.
---@return OPSTRANSPORT #self
function OPSTRANSPORT:SetDisembarkInUtero(InUtero, TransportZoneCombo) end

---Set disembark zone.
---
------
---@param self OPSTRANSPORT 
---@param DisembarkZone ZONE Zone where the troops are disembarked.
---@param TransportZoneCombo OPSTRANSPORT.TransportZoneCombo Transport zone combo.
---@return OPSTRANSPORT #self
function OPSTRANSPORT:SetDisembarkZone(DisembarkZone, TransportZoneCombo) end

---Set embark zone.
---
------
---@param self OPSTRANSPORT 
---@param EmbarkZone ZONE Zone where the troops are embarked.
---@param TransportZoneCombo OPSTRANSPORT.TransportZoneCombo Transport zone combo.
---@return OPSTRANSPORT #self
function OPSTRANSPORT:SetEmbarkZone(EmbarkZone, TransportZoneCombo) end

---Set pickup formation.
---
------
---@param self OPSTRANSPORT 
---@param Formation number Pickup formation.
---@param TransportZoneCombo OPSTRANSPORT.TransportZoneCombo Transport zone combo.
---@return OPSTRANSPORT #self
function OPSTRANSPORT:SetFormationPickup(Formation, TransportZoneCombo) end

---Set transport formation.
---
------
---@param self OPSTRANSPORT 
---@param Formation number Pickup formation.
---@param TransportZoneCombo OPSTRANSPORT.TransportZoneCombo Transport zone combo.
---@return OPSTRANSPORT #self
function OPSTRANSPORT:SetFormationTransport(Formation, TransportZoneCombo) end

---Set LEGION transport status.
---
------
---@param self OPSTRANSPORT 
---@param Legion LEGION The legion.
---@param Status string New status.
---@return OPSTRANSPORT #self
function OPSTRANSPORT:SetLegionStatus(Legion, Status) end

---Set pickup zone.
---
------
---@param self OPSTRANSPORT 
---@param PickupZone ZONE Zone where the troops are picked up.
---@param TransportZoneCombo OPSTRANSPORT.TransportZoneCombo Transport zone combo.
---@return OPSTRANSPORT #self
function OPSTRANSPORT:SetPickupZone(PickupZone, TransportZoneCombo) end

---Set mission priority and (optional) urgency.
---Urgent missions can cancel other running missions.
---
------
---@param self OPSTRANSPORT 
---@param Prio number Priority 1=high, 100=low. Default 50.
---@param Importance number Number 1-10. If missions with lower value are in the queue, these have to be finished first. Default is `nil`.
---@param Urgent boolean If *true*, another running mission might be cancelled if it has a lower priority.
---@return OPSTRANSPORT #self
function OPSTRANSPORT:SetPriority(Prio, Importance, Urgent) end

---Set required cargo.
---This is a list of cargo groups that need to be loaded before the **first** transport will start.
---
------
---@param self OPSTRANSPORT 
---@param Cargos SET_GROUP Required cargo set. Can also be passed as a #GROUP, #OPSGROUP or #SET_OPSGROUP object.
---@param TransportZoneCombo OPSTRANSPORT.TransportZoneCombo Transport zone combo.
---@return OPSTRANSPORT #self
function OPSTRANSPORT:SetRequiredCargos(Cargos, TransportZoneCombo) end

---Set number of required carrier groups for an OPSTRANSPORT assignment.
---Only used if transport is assigned at **LEGION** or higher level.
---
------
---@param self OPSTRANSPORT 
---@param NcarriersMin number Number of carriers *at least* required. Default 1.
---@param NcarriersMax number Number of carriers *at most* used for transportation. Default is same as `NcarriersMin`.
---@return OPSTRANSPORT #self
function OPSTRANSPORT:SetRequiredCarriers(NcarriersMin, NcarriersMax) end

---Set transport start and stop time.
---
------
---@param self OPSTRANSPORT 
---@param ClockStart string Time the transport is started, e.g. "05:00" for 5 am. If specified as a #number, it will be relative (in seconds) to the current mission time. Default is 5 seconds after mission was added.
---@param ClockStop? string (Optional) Time the transport is stopped, e.g. "13:00" for 1 pm. If mission could not be started at that time, it will be removed from the queue. If specified as a #number it will be relative (in seconds) to the current mission time.
---@return OPSTRANSPORT #self
function OPSTRANSPORT:SetTime(ClockStart, ClockStop) end

---Set verbosity.
---
------
---@param self OPSTRANSPORT 
---@param Verbosity number Be more verbose. Default 0
---@return OPSTRANSPORT #self
function OPSTRANSPORT:SetVerbosity(Verbosity) end

---Triggers the FSM event "StatusUpdate".
---
------
---@param self OPSTRANSPORT 
function OPSTRANSPORT:StatusUpdate() end

---Triggers the FSM event "Unloaded".
---
------
---@param self OPSTRANSPORT 
---@param OpsGroupCargo OPSGROUP Cargo OPSGROUP that was unloaded from a carrier.
---@param OpsGroupCarrier OPSGROUP Carrier OPSGROUP that unloaded the cargo.
function OPSTRANSPORT:Unloaded(OpsGroupCargo, OpsGroupCarrier) end

---Add a carrier assigned for this transport.
---
------
---@param self OPSTRANSPORT 
---@param CarrierGroup OPSGROUP Carrier OPSGROUP.
---@return OPSTRANSPORT #self
function OPSTRANSPORT:_AddCarrier(CarrierGroup) end

---Set/add transfer carrier(s).
---These are carrier groups, where the cargo is directly loaded into when disembarked.
---
------
---@param self OPSTRANSPORT 
---@param Carriers SET_GROUP Carrier set. Can also be passed as a #GROUP, #OPSGROUP or #SET_OPSGROUP object.
---@param Table table the table to add.
---@return OPSTRANSPORT #self
function OPSTRANSPORT:_AddDisembarkCarriers(Carriers, Table) end

---Check if all cargo of this transport assignment was delivered.
---
------
---@param self OPSTRANSPORT 
function OPSTRANSPORT:_CheckDelivered() end

---Check if all required cargos are loaded.
---
------
---@param self OPSTRANSPORT 
---@param TransportZoneCombo OPSTRANSPORT.TransportZoneCombo Transport zone combo.
---@param CarrierGroup OPSGROUP The carrier group asking.
---@return boolean #If true, all required cargos are loaded or there is no required cargo or asking carrier is full.
function OPSTRANSPORT:_CheckRequiredCargos(TransportZoneCombo, CarrierGroup) end

---Count how many cargo groups are inside a zone.
---
------
---@param self OPSTRANSPORT 
---@param Zone ZONE The zone object.
---@param Delivered boolean If `true`, only delivered groups are returned. If `false` only undelivered groups are returned. If `nil`, all groups are returned.
---@param Carrier? OPSGROUP (Optional) Only count cargo groups that fit into the given carrier group. Current cargo is not a factor.
---@param TransportZoneCombo OPSTRANSPORT.TransportZoneCombo Transport zone combo.
---@return number #Number of cargo groups.
function OPSTRANSPORT:_CountCargosInZone(Zone, Delivered, Carrier, TransportZoneCombo) end

---Create a cargo group data structure.
---
------
---@param self OPSTRANSPORT 
---@param group GROUP The GROUP or OPSGROUP object.
---@param TransportZoneCombo OPSTRANSPORT.TransportZoneCombo Transport zone combo.
---@param DisembarkActivation boolean If `true`, cargo group is activated when disembarked. 
---@param DisembarkZone ZONE Disembark zone, where the cargo is spawned when delivered.
---@param DisembarkCarriers SET_OPSGROUP Disembark carriers cargo is directly loaded into when delivered.
---@return OPSGROUP.CargoGroup #Cargo group data.
function OPSTRANSPORT:_CreateCargoGroupData(group, TransportZoneCombo, DisembarkActivation, DisembarkZone, DisembarkCarriers) end

---Create a cargo group data structure.
---
------
---@param self OPSTRANSPORT 
---@param StorageFrom STORAGE Storage from.
---@param StorageTo STORAGE Storage to.
---@param CargoType string Type of cargo.
---@param CargoAmount number Total amount of cargo that should be transported. Liquids in kg.
---@param CargoWeight number Weight of a single cargo item in kg. Default 1 kg.
---@param TransportZoneCombo OPSTRANSPORT.TransportZoneCombo Transport zone combo.
---@return OPSGROUP.CargoGroup #Cargo group data.
function OPSTRANSPORT:_CreateCargoStorage(StorageFrom, StorageTo, CargoType, CargoAmount, CargoWeight, TransportZoneCombo) end

---Remove group from the current carrier list/table.
---
------
---@param self OPSTRANSPORT 
---@param CarrierGroup OPSGROUP Carrier OPSGROUP.
---@param Delay number Delay in seconds before the carrier is removed.
---@return OPSTRANSPORT #self
function OPSTRANSPORT:_DelCarrier(CarrierGroup, Delay) end

---Get a list of alive carriers.
---
------
---@param self OPSTRANSPORT 
---@return table #Names of all carriers
function OPSTRANSPORT:_GetCarrierNames() end

---Get pickup formation.
---
------
---@param self OPSTRANSPORT 
---@param OpsGroup OPSGROUP 
---@return string #Formation.
function OPSTRANSPORT:_GetFormationDefault(OpsGroup) end

---Get pickup formation.
---
------
---@param self OPSTRANSPORT 
---@param TransportZoneCombo OPSTRANSPORT.TransportZoneCombo Transport zone combo.
---@param OpsGroup OPSGROUP 
---@return number #Formation.
function OPSTRANSPORT:_GetFormationPickup(TransportZoneCombo, OpsGroup) end

---Get transport formation.
---
------
---@param self OPSTRANSPORT 
---@param TransportZoneCombo OPSTRANSPORT.TransportZoneCombo Transport zone combo.
---@param OpsGroup OPSGROUP 
---@return number #Formation.
function OPSTRANSPORT:_GetFormationTransport(TransportZoneCombo, OpsGroup) end

---Get an OPSGROUP from a given OPSGROUP or GROUP object.
---If the object is a GROUP, an OPSGROUP is created automatically.
---
------
---@param self OPSTRANSPORT 
---@param Object BASE The object, which can be a GROUP or OPSGROUP.
---@return OPSGROUP #Ops Group.
function OPSTRANSPORT:_GetOpsGroupFromObject(Object) end

---Get a path for transportation.
---
------
---@param self OPSTRANSPORT 
---@param Category number Group category.
---@param TransportZoneCombo OPSTRANSPORT.TransportZoneCombo Transport Zone combo.
---@return OPSTRANSPORT.Path #The path object.
function OPSTRANSPORT:_GetPathTransport(Category, TransportZoneCombo) end

---Get a transport zone combination (TZC) for a carrier group.
---The pickup zone will be a zone, where the most cargo groups are located that fit into the carrier.
---
------
---@param self OPSTRANSPORT 
---@param Carrier OPSGROUP The carrier OPS group.
---@return ZONE #Pickup zone or `#nil`.
function OPSTRANSPORT:_GetTransportZoneCombo(Carrier) end

---Triggers the FSM event "Cancel" after a delay.
---
------
---@param self OPSTRANSPORT 
---@param delay number Delay in seconds.
function OPSTRANSPORT:__Cancel(delay) end

---Triggers the FSM event "Delivered" after a delay.
---
------
---@param self OPSTRANSPORT 
---@param delay number Delay in seconds.
function OPSTRANSPORT:__Delivered(delay) end

---Triggers the FSM event "Executing" after a delay.
---
------
---@param self OPSTRANSPORT 
---@param delay number Delay in seconds.
function OPSTRANSPORT:__Executing(delay) end

---Triggers the FSM event "Loaded" after a delay.
---
------
---@param self OPSTRANSPORT 
---@param delay number Delay in seconds.
---@param OpsGroupCargo OPSGROUP OPSGROUP that was loaded into a carrier.
---@param OpsGroupCarrier OPSGROUP OPSGROUP that was loaded into a carrier.
---@param CarrierElement OPSGROUP.Element Carrier element.
function OPSTRANSPORT:__Loaded(delay, OpsGroupCargo, OpsGroupCarrier, CarrierElement) end

---Triggers the FSM event "Planned" after a delay.
---
------
---@param self OPSTRANSPORT 
---@param delay number Delay in seconds.
function OPSTRANSPORT:__Planned(delay) end

---Triggers the FSM event "Queued" after a delay.
---
------
---@param self OPSTRANSPORT 
---@param delay number Delay in seconds.
function OPSTRANSPORT:__Queued(delay) end

---Triggers the FSM event "Requested" after a delay.
---
------
---@param self OPSTRANSPORT 
---@param delay number Delay in seconds.
function OPSTRANSPORT:__Requested(delay) end

---Triggers the FSM event "Scheduled" after a delay.
---
------
---@param self OPSTRANSPORT 
---@param delay number Delay in seconds.
function OPSTRANSPORT:__Scheduled(delay) end

---Triggers the FSM event "Status" after a delay.
---
------
---@param self OPSTRANSPORT 
---@param delay number Delay in seconds.
function OPSTRANSPORT:__StatusUpdate(delay) end

---Triggers the FSM event "Unloaded" after a delay.
---
------
---@param self OPSTRANSPORT 
---@param delay number Delay in seconds.
---@param OpsGroupCargo OPSGROUP Cargo OPSGROUP that was unloaded from a carrier.
---@param OpsGroupCarrier OPSGROUP Carrier OPSGROUP that unloaded the cargo.
function OPSTRANSPORT:__Unloaded(delay, OpsGroupCargo, OpsGroupCarrier) end

---On after "Cancel" event.
---
------
---@param self OPSTRANSPORT 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function OPSTRANSPORT:onafterCancel(From, Event, To) end

---On after "DeadCarrierAll" event.
---
------
---@param self OPSTRANSPORT 
---@param From string From state.
---@param Event string Event.
---@param To string To state. 
---@private
function OPSTRANSPORT:onafterDeadCarrierAll(From, Event, To) end

---On after "DeadCarrierGroup" event.
---
------
---@param self OPSTRANSPORT 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param OpsGroup OPSGROUP Carrier OPSGROUP that is dead. 
---@private
function OPSTRANSPORT:onafterDeadCarrierGroup(From, Event, To, OpsGroup) end

---On after "Delivered" event.
---
------
---@param self OPSTRANSPORT 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function OPSTRANSPORT:onafterDelivered(From, Event, To) end

---On after "Executing" event.
---
------
---@param self OPSTRANSPORT 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function OPSTRANSPORT:onafterExecuting(From, Event, To) end

---On after "Loaded" event.
---
------
---@param self OPSTRANSPORT 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param OpsGroupCargo OPSGROUP OPSGROUP that was loaded into a carrier.
---@param OpsGroupCarrier OPSGROUP OPSGROUP that was loaded into a carrier.
---@param CarrierElement OPSGROUP.Element Carrier element.
---@private
function OPSTRANSPORT:onafterLoaded(From, Event, To, OpsGroupCargo, OpsGroupCarrier, CarrierElement) end

---On after "Planned" event.
---
------
---@param self OPSTRANSPORT 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function OPSTRANSPORT:onafterPlanned(From, Event, To) end

---On after "Scheduled" event.
---
------
---@param self OPSTRANSPORT 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function OPSTRANSPORT:onafterScheduled(From, Event, To) end

---On after "StatusUpdate" event.
---
------
---@param self OPSTRANSPORT 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function OPSTRANSPORT:onafterStatusUpdate(From, Event, To) end

---On after "Unloaded" event.
---
------
---@param self OPSTRANSPORT 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param OpsGroupCargo OPSGROUP Cargo OPSGROUP that was unloaded from a carrier.
---@param OpsGroupCarrier OPSGROUP Carrier OPSGROUP that unloaded the cargo.
---@private
function OPSTRANSPORT:onafterUnloaded(From, Event, To, OpsGroupCargo, OpsGroupCarrier) end

---On before "Delivered" event.
---
------
---@param self OPSTRANSPORT 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function OPSTRANSPORT:onbeforeDelivered(From, Event, To) end


---Storage data.
---@class OPSTRANSPORT.CargoType 
---@field OPSGROUP string Cargo is an OPSGROUP.
---@field STORAGE string Cargo is storage of DCS warehouse.
OPSTRANSPORT.CargoType = {}


---Generic transport condition.
---@class OPSTRANSPORT.Condition 
---@field private arg table Optional arguments passed to the condition callback function.
---@field private func function Callback function to check for a condition. Should return a #boolean.
OPSTRANSPORT.Condition = {}


---Path used for pickup or transport.
---@class OPSTRANSPORT.Path 
---@field private category number Category for which carriers this path is used.
---@field private radius number Radomization radius for waypoints in meters. Default 0 m.
---@field private reverse boolean If `true`, path is used in reversed order.
---@field private waypoints table Table of waypoints.
OPSTRANSPORT.Path = {}


---Cargo transport status.
---@class OPSTRANSPORT.Status 
---@field CANCELLED string Transport was cancelled.
---@field DELIVERED string Transport was delivered. 
---@field EXECUTING string Transport is being executed.
---@field FAILED string Transport failed.
---@field PLANNED string Planning state.
---@field QUEUED string Queued state.
---@field REQUESTED string Requested state.
---@field SCHEDULED string Transport is scheduled in the cargo queue.
---@field SUCCESS string Transport was a success.
OPSTRANSPORT.Status = {}


---Storage data.
---@class OPSTRANSPORT.Storage 
---@field private cargoAmount number Amount of cargo that should be transported.
---@field private cargoDelivered number Amount of cargo that has been delivered.
---@field private cargoLoaded number Amount of cargo that is loading.
---@field private cargoLost number Amount of cargo that was lost.
---@field private cargoReserved number Amount of cargo that is reserved for a carrier group.
---@field private cargoType string Type of cargo.
---@field private cargoWeight number Weight of one single cargo item in kg. Default 1 kg.
---@field private storageFrom STORAGE Storage from.
---@field private storageTo STORAGE Storage To.
OPSTRANSPORT.Storage = {}


---Transport zone combination.
---@class OPSTRANSPORT.TransportZoneCombo 
---@field Cargos table Cargo groups of the TZ combo. Each element is of type `Ops.OpsGroup#OPSGROUP.CargoGroup`.
---@field DeployAirbase AIRBASE Airbase for deploy.
---@field DeployZone ZONE Deploy zone.
---@field DisembarkCarriers table Carriers where the cargo is directly disembarked to.
---@field DisembarkZone ZONE Zone where the troops are disembared to.
---@field EmbarkZone ZONE Embark zone if different from pickup zone.
---@field Ncargo number Number of cargos assigned. This is a running number and *not* decreased if cargo is delivered or dead.
---@field Ncarriers number Number of carrier groups using this transport zone.
---@field PickupAirbase AIRBASE Airbase for pickup.
---@field PickupFormation number Formation used to pickup.
---@field PickupPaths table Paths for pickup. 
---@field PickupZone ZONE Pickup zone.
---@field RequiredCargos table Required cargos.
---@field TransportFormation number Formation used to transport.
---@field TransportPaths table Path for Transport. Each elment of the table is of type `#OPSTRANSPORT.Path`. 
---@field private assets boolean Cargo assets.
---@field private disembarkActivation boolean If true, troops are spawned in late activated state when disembarked from carrier.
---@field private disembarkInUtero boolean If true, troops are disembarked "in utero".
---@field private disembarkToCarriers boolean If `true`, cargo is supposed to embark to another carrier.
---@field private uid number Unique ID of the TZ combo.
OPSTRANSPORT.TransportZoneCombo = {}



