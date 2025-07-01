---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/AI_Cargo_Dispatcher.JPG" width="100%">
---
---**AI** - Models the intelligent transportation of infantry and other cargo.
---
---===
---
---### Author: **acrojason** (derived from AI_Cargo_APC by FlightControl)
---
---===
---Brings a dynamic cargo handling capability for an AI naval group.
---
---![Banner Image](..\Images\deprecated.png)
---
---Naval ships can be utilized to transport cargo around the map following naval shipping lanes.
---The AI_CARGO_SHIP class uses the Cargo.Cargo capabilities within the MOOSE framework. 
---Cargo.Cargo must be declared within the mission or warehouse to make the AI_CARGO_SHIP recognize the cargo.
---Please consult the Cargo.Cargo module for more information.
---
---## Cargo loading.
---
---The module will automatically load cargo when the Ship is within boarding or loading radius. 
---The boarding or loading radius is specified when the cargo is created in the simulation and depends on the type of 
---cargo and the specified boarding radius.
---
---## Defending the Ship when enemies are nearby
---This is not supported for naval cargo because most tanks don't float. Protect your transports...
---
---## Infantry or cargo **health**.
---When cargo is unboarded from the Ship, the cargo is actually respawned into the battlefield.
---As a result, the unboarding cargo is very _healthy_ every time it unboards.
---This is due to the limitation of the DCS simulator, which is not able to specify the health of newly spawned units as a parameter.
---However, cargo that was destroyed when unboarded and following the Ship won't be respawned again (this is likely not a thing for
---naval cargo due to the lack of support for defending the Ship mentioned above). Destroyed is destroyed.
---As a result, there is some additional strength that is gained when an unboarding action happens, but in terms of simulation balance
---this has marginal impact on the overall battlefield simulation. Given the relatively short duration of DCS missions and the somewhat
---lengthy naval transport times, most units entering the Ship as cargo will be freshly en route to an amphibious landing or transporting 
---between warehouses.
---
---## Control the Ships on the map.
---
---Currently, naval transports can only be controlled via scripts due to their reliance upon predefined Shipping Lanes created in the Mission
---Editor. An interesting future enhancement could leverage new pathfinding functionality for ships in the Ops module.
---
---## Cargo deployment.
---
---Using the #AI_CARGO_SHIP.Deploy() method, you are able to direct the Ship towards a Deploy zone to unboard/unload the cargo at the
---specified coordinate. The Ship will follow the Shipping Lane to ensure consistent cargo transportation within the simulation environment.
---
---## Cargo pickup.
---
---Using the #AI_CARGO_SHIP.Pickup() method, you are able to direct the Ship towards a Pickup zone to board/load the cargo at the specified
---coordinate. The Ship will follow the Shipping Lane to ensure consistent cargo transportation within the simulation environment.
---
---
---# Developer Note
---
---Note while this class still works, it is no longer supported as the original author stopped active development of MOOSE
---Therefore, this class is considered to be deprecated
---@deprecated
---@class AI_CARGO_SHIP 
---@field CargoCarrier GROUIP 
---@field Coalition NOTYPE 
---@field Zone NOTYPE 
AI_CARGO_SHIP = {}

---FInd a free Carrier within a radius
---
------
---@param self AI_CARGO_SHIP 
---@param Coordinate COORDINATE 
---@param Radius number 
---@return GROUP #NewCarrier
function AI_CARGO_SHIP:FindCarrier(Coordinate, Radius) end

---Follow Infantry to the Carrier
---
------
---@param self AI_CARGO_SHIP 
---@param Me AI_CARGO_SHIP 
---@param ShipUnit UNIT 
---@param Cargo CARGO_GROUP 
---@param CargoGroup NOTYPE 
---@return AI_CARGO_SHIP #
function AI_CARGO_SHIP:FollowToCarrier(Me, ShipUnit, Cargo, CargoGroup) end

---Creates a new AI_CARGO_SHIP object.
---
------
---@param self AI_CARGO_SHIP 
---@param Ship GROUP  The carrier Ship group
---@param CargoSet SET_CARGO  The set of cargo to be transported
---@param CombatRadius number  Provide the combat radius to defend the carrier by unboarding the cargo when enemies are nearby. When CombatRadius is 0, no defense will occur.
---@param ShippingLane table  Table containing list of Shipping Lanes to be used
---@return AI_CARGO_SHIP #
function AI_CARGO_SHIP:New(Ship, CargoSet, CombatRadius, ShippingLane) end

---Set the Carrier
---
------
---@param self AI_CARGO_SHIP 
---@param CargoCarrier GROUP 
---@return AI_CARGO_SHIP #
function AI_CARGO_SHIP:SetCarrier(CargoCarrier) end


---
------
---@param self NOTYPE 
---@param CombatRadius NOTYPE 
function AI_CARGO_SHIP:SetCombatRadius(CombatRadius) end


---
------
---@param self NOTYPE 
---@param ShippingLane NOTYPE 
function AI_CARGO_SHIP:SetShippingLane(ShippingLane) end

---Check if cargo ship is alive and trigger Unload event.
---Good time to remind people that Lua is case sensitive and Unload != UnLoad
---
------
---@param Ship GROUP 
---@param self AI_CARGO_SHIP 
---@param Coordinate NOTYPE 
---@param DeployZone NOTYPE 
function AI_CARGO_SHIP._Deploy(Ship, self, Coordinate, DeployZone) end

---Check if cargo ship is alive and trigger Load event
---
------
---@param Ship Group 
---@param self AI_CARGO_SHIP 
---@param Coordinate NOTYPE 
---@param Speed NOTYPE 
---@param PickupZone NOTYPE 
function AI_CARGO_SHIP._Pickup(Ship, self, Coordinate, Speed, PickupZone) end

---On after Deploy event.
---
------
---@param self AI_CARGO_SHIP 
---@param SHIP GROUP 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@param Coordinate COORDINATE  Coordinate of the deploy point
---@param Speed number  Speed in km/h to sail to the deploy coordinate. Default is 50% of max speed for the unit
---@param Height number  Altitude in meters to move to the deploy coordinate. This parameter is ignored for Ships
---@param DeployZone ZONE The zone where the cargo will be deployed.
---@param Ship NOTYPE 
---@private
function AI_CARGO_SHIP:onafterDeploy(SHIP, From, Event, To, Coordinate, Speed, Height, DeployZone, Ship) end


---
------
---@param self NOTYPE 
---@param Ship NOTYPE 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@param Coordinate NOTYPE 
---@param Speed NOTYPE 
---@param Height NOTYPE 
---@param HomeZone NOTYPE 
---@private
function AI_CARGO_SHIP:onafterHome(Ship, From, Event, To, Coordinate, Speed, Height, HomeZone) end


---
------
---@param self NOTYPE 
---@param Ship NOTYPE 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@private
function AI_CARGO_SHIP:onafterMonitor(Ship, From, Event, To) end

---on after Pickup event.
---
------
---@param AI_CARGO_SHIP NOTYPE Ship
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@param Coordinate COORDINATE of the pickup point
---@param Speed number  Speed in km/h to sail to the pickup coordinate. Default is 50% of max speed for the unit
---@param Height number  Altitude in meters to move to the pickup coordinate. This parameter is ignored for Ships
---@param PickupZone? ZONE (optional)  The zone where the cargo will be picked up. The PickupZone can be nil if there was no PickupZoneSet provided
---@param self NOTYPE 
---@param Ship NOTYPE 
---@private
function AI_CARGO_SHIP.onafterPickup(AI_CARGO_SHIP, From, Event, To, Coordinate, Speed, Height, PickupZone, self, Ship) end

---On after Unload event.
---
------
---@param self AI_CARGO_SHIP 
---@param Ship GROUP 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param DeployZone ZONE The zone wherein the cargo is deployed. This can be any zone type, like a ZONE, ZONE_GROUP, ZONE_AIRBASE.
---@param Defend NOTYPE 
---@private
function AI_CARGO_SHIP:onafterUnload(Ship, From, Event, To, DeployZone, Defend) end



