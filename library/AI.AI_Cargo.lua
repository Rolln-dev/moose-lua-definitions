---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Cargo.JPG" width="100%">
---
---**AI** - Models the intelligent transportation of infantry and other cargo.
---
---===
---
---### Author: **FlightControl**
---
---===
---Base class for the dynamic cargo handling capability for AI groups.
---
---![Banner Image](..\Images\deprecated.png)
---
---Carriers can be mobilized to intelligently transport infantry and other cargo within the simulation.
---The AI_CARGO module uses the Cargo.Cargo capabilities within the MOOSE framework.
---CARGO derived objects must be declared within the mission to make the AI_CARGO object recognize the cargo.
---Please consult the Cargo.Cargo module for more information. 
---
---The derived classes from this module are:
---
---   * AI.AI_Cargo_APC - Cargo transportation using APCs and other vehicles between zones.
---   * AI.AI_Cargo_Helicopter - Cargo transportation using helicopters between zones.
---   * AI.AI_Cargo_Airplane - Cargo transportation using airplanes to and from airbases.
---
---# Developer Note
---
---Note while this class still works, it is no longer supported as the original author stopped active development of MOOSE
---Therefore, this class is considered to be deprecated
---@deprecated
---@class AI_CARGO : FSM_CONTROLLABLE
---@field CargoCarrier NOTYPE 
---@field CargoSet SET_CARGO 
---@field Carrier_Cargo table 
---@field Relocating boolean 
---@field Transporting boolean 
AI_CARGO = {}

---Deploy Trigger for AI_CARGO
---
------
---@param self AI_CARGO 
---@param Coordinate COORDINATE 
---@param Speed number Speed in km/h. Default is 50% of max possible speed the group can do.
function AI_CARGO:Deploy(Coordinate, Speed) end


---
------
---@param self NOTYPE 
function AI_CARGO:IsRelocating() end


---
------
---@param self NOTYPE 
function AI_CARGO:IsTransporting() end

---Creates a new AI_CARGO object.
---
------
---@param self AI_CARGO 
---@param Carrier GROUP Cargo carrier group.
---@param CargoSet SET_CARGO Set of cargo(s) to transport.
---@return AI_CARGO #self
function AI_CARGO:New(Carrier, CargoSet) end

---Deploy Handler OnAfter for AI_CARGO
---
------
---@param self AI_CARGO 
---@param From string 
---@param Event string 
---@param To string 
---@param Coordinate COORDINATE 
---@param Speed number Speed in km/h. Default is 50% of max possible speed the group can do.
function AI_CARGO:OnAfterDeploy(From, Event, To, Coordinate, Speed) end

---On after Deployed event.
---
------
---@param self AI_CARGO 
---@param Carrier GROUP 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param DeployZone ZONE The zone wherein the cargo is deployed. This can be any zone type, like a ZONE, ZONE_GROUP, ZONE_AIRBASE.
---@param Defend boolean Defend for APCs.
function AI_CARGO:OnAfterDeployed(Carrier, From, Event, To, DeployZone, Defend) end

---Loaded Handler OnAfter for AI_CARGO
---
------
---@param self AI_CARGO 
---@param Carrier GROUP 
---@param From string 
---@param Event string 
---@param To string 
function AI_CARGO:OnAfterLoaded(Carrier, From, Event, To) end

---Pickup Handler OnAfter for AI_CARGO
---
------
---@param self AI_CARGO 
---@param From string 
---@param Event string 
---@param To string 
---@param Coordinate COORDINATE 
---@param Speed number Speed in km/h. Default is 50% of max possible speed the group can do.
function AI_CARGO:OnAfterPickup(From, Event, To, Coordinate, Speed) end

---Unloaded Handler OnAfter for AI_CARGO
---
------
---@param self AI_CARGO 
---@param Carrier GROUP 
---@param From string 
---@param Event string 
---@param To string 
function AI_CARGO:OnAfterUnloaded(Carrier, From, Event, To) end

---Deploy Handler OnBefore for AI_CARGO
---
------
---@param self AI_CARGO 
---@param From string 
---@param Event string 
---@param To string 
---@param Coordinate COORDINATE 
---@param Speed number Speed in km/h. Default is 50% of max possible speed the group can do.
---@return boolean #
function AI_CARGO:OnBeforeDeploy(From, Event, To, Coordinate, Speed) end

---Pickup Handler OnBefore for AI_CARGO
---
------
---@param self AI_CARGO 
---@param From string 
---@param Event string 
---@param To string 
---@param Coordinate COORDINATE 
---@param Speed number Speed in km/h. Default is 50% of max possible speed the group can do. 
---@return boolean #
function AI_CARGO:OnBeforePickup(From, Event, To, Coordinate, Speed) end

---Pickup Trigger for AI_CARGO
---
------
---@param self AI_CARGO 
---@param Coordinate COORDINATE 
---@param Speed number Speed in km/h. Default is 50% of max possible speed the group can do.
function AI_CARGO:Pickup(Coordinate, Speed) end

---Deploy Asynchronous Trigger for AI_CARGO
---
------
---@param self AI_CARGO 
---@param Delay number 
---@param Coordinate COORDINATE 
---@param Speed number Speed in km/h. Default is 50% of max possible speed the group can do.
function AI_CARGO:__Deploy(Delay, Coordinate, Speed) end

---Pickup Asynchronous Trigger for AI_CARGO
---
------
---@param self AI_CARGO 
---@param Delay number 
---@param Coordinate COORDINATE Pickup place. If not given, loading starts at the current location.
---@param Speed number Speed in km/h. Default is 50% of max possible speed the group can do.
function AI_CARGO:__Pickup(Delay, Coordinate, Speed) end

---On after Board event.
---
------
---@param self AI_CARGO 
---@param Carrier GROUP 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Cargo CARGO Cargo object.
---@param CarrierUnit UNIT 
---@param PickupZone? ZONE (optional) The zone where the cargo will be picked up. The PickupZone can be nil, if there wasn't any PickupZoneSet provided.
---@private
function AI_CARGO:onafterBoard(Carrier, From, Event, To, Cargo, CarrierUnit, PickupZone) end

---On after Deploy event.
---
------
---@param self AI_CARGO 
---@param APC GROUP 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@param Coordinate COORDINATE Deploy place.
---@param Speed number Speed in km/h to drive to the depoly coordinate. Default is 50% of max possible speed the unit can go.
---@param Height number Height in meters to move to the deploy coordinate.
---@param DeployZone ZONE The zone where the cargo will be deployed.
---@private
function AI_CARGO:onafterDeploy(APC, From, Event, To, Coordinate, Speed, Height, DeployZone) end

---On after Deployed event.
---
------
---@param self AI_CARGO 
---@param Carrier GROUP 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param DeployZone ZONE The zone wherein the cargo is deployed. This can be any zone type, like a ZONE, ZONE_GROUP, ZONE_AIRBASE.
---@param Defend boolean Defend for APCs.
---@private
function AI_CARGO:onafterDeployed(Carrier, From, Event, To, DeployZone, Defend) end

---On after Loaded event.
---
------
---@param self AI_CARGO 
---@param Carrier GROUP 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param PickupZone? ZONE (optional) The zone where the cargo will be picked up. The PickupZone can be nil, if there wasn't any PickupZoneSet provided.
---@param Cargo NOTYPE 
---@return boolean #Cargo loaded.
---@private
function AI_CARGO:onafterLoaded(Carrier, From, Event, To, PickupZone, Cargo) end

---On after PickedUp event.
---
------
---@param self AI_CARGO 
---@param Carrier GROUP 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param PickupZone? ZONE (optional) The zone where the cargo will be picked up. The PickupZone can be nil, if there wasn't any PickupZoneSet provided.
---@private
function AI_CARGO:onafterPickedUp(Carrier, From, Event, To, PickupZone) end

---On after Pickup event.
---
------
---@param self AI_CARGO 
---@param APC GROUP 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@param Coordinate COORDINATE of the pickup point.
---@param Speed number Speed in km/h to drive to the pickup coordinate. Default is 50% of max possible speed the unit can go.
---@param Height number Height in meters to move to the home coordinate.
---@param PickupZone? ZONE (optional) The zone where the cargo will be picked up. The PickupZone can be nil, if there wasn't any PickupZoneSet provided.
---@private
function AI_CARGO:onafterPickup(APC, From, Event, To, Coordinate, Speed, Height, PickupZone) end

---On after Unboard event.
---
------
---@param self AI_CARGO 
---@param Carrier GROUP 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Cargo string Cargo#CARGO Cargo Cargo object.
---@param DeployZone ZONE The zone wherein the cargo is deployed. This can be any zone type, like a ZONE, ZONE_GROUP, ZONE_AIRBASE.
---@param CarrierUnit NOTYPE 
---@param Defend NOTYPE 
---@private
function AI_CARGO:onafterUnboard(Carrier, From, Event, To, Cargo, DeployZone, CarrierUnit, Defend) end

---On after Unload event.
---
------
---@param self AI_CARGO 
---@param Carrier GROUP 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param DeployZone ZONE The zone wherein the cargo is deployed. This can be any zone type, like a ZONE, ZONE_GROUP, ZONE_AIRBASE.
---@param Defend NOTYPE 
---@private
function AI_CARGO:onafterUnload(Carrier, From, Event, To, DeployZone, Defend) end

---On after Unloaded event.
---
------
---@param self AI_CARGO 
---@param Carrier GROUP 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Cargo string Cargo#CARGO Cargo Cargo object.
---@param Deployed boolean Cargo is deployed.
---@param DeployZone ZONE The zone wherein the cargo is deployed. This can be any zone type, like a ZONE, ZONE_GROUP, ZONE_AIRBASE.
---@param CarrierUnit NOTYPE 
---@param Defend NOTYPE 
---@private
function AI_CARGO:onafterUnloaded(Carrier, From, Event, To, Cargo, Deployed, DeployZone, CarrierUnit, Defend) end

---On before Load event.
---
------
---@param self AI_CARGO 
---@param Carrier GROUP 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param PickupZone? ZONE (optional) The zone where the cargo will be picked up. The PickupZone can be nil, if there wasn't any PickupZoneSet provided.
---@private
function AI_CARGO:onbeforeLoad(Carrier, From, Event, To, PickupZone) end

---On before Reload event.
---
------
---@param self AI_CARGO 
---@param Carrier GROUP 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param PickupZone? ZONE (optional) The zone where the cargo will be picked up. The PickupZone can be nil, if there wasn't any PickupZoneSet provided.
---@private
function AI_CARGO:onbeforeReload(Carrier, From, Event, To, PickupZone) end



