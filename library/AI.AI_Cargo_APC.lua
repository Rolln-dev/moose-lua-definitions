---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/AI_Cargo_Dispatching_For_APC.JPG" width="100%">
---
---**AI** - Models the intelligent transportation of cargo using ground vehicles.
---
---===
---
---### Author: **FlightControl**
---
---===
---Brings a dynamic cargo handling capability for an AI vehicle group.
---
---![Banner Image](..\Images\deprecated.png)
---
---Armoured Personnel Carriers (APC), Trucks, Jeeps and other ground based carrier equipment can be mobilized to intelligently transport infantry and other cargo within the simulation.
---
---The AI_CARGO_APC class uses the Cargo.Cargo capabilities within the MOOSE framework.
---Cargo.Cargo must be declared within the mission to make the AI_CARGO_APC object recognize the cargo.
---Please consult the Cargo.Cargo module for more information. 
---
---## Cargo loading.
---
---The module will load automatically cargo when the APCs are within boarding or loading radius.
---The boarding or loading radius is specified when the cargo is created in the simulation, and therefore, this radius depends on the type of cargo
---and the specified boarding radius.
---
---## **Defending** the APCs when enemies nearby.
---
---Cargo will defend the carrier with its available arms, and to avoid cargo being lost within the battlefield.
--- 
---When the APCs are approaching enemy units, something special is happening. 
---The APCs will stop moving, and the loaded infantry will unboard and follow the APCs and will help to defend the group.
---The carrier will hold the route once the unboarded infantry is further than 50 meters from the APCs, 
---to ensure that the APCs are not too far away from the following running infantry.
---Once all enemies are cleared, the infantry will board again automatically into the APCs. Once boarded, the APCs will follow its pre-defined route.
---
---A combat radius needs to be specified in meters at the #AI_CARGO_APC.New() method. 
---This combat radius will trigger the unboarding of troops when enemies are within the combat radius around the APCs.
---During my tests, I've noticed that there is a balance between ensuring that the infantry is within sufficient hit radius (effectiveness) versus
---vulnerability of the infantry. It all depends on the kind of enemies that are expected to be encountered. 
---A combat radius of 350 meters to 500 meters has been proven to be the most effective and efficient.
---
---However, when the defense of the carrier, is not required, it must be switched off.
---This is done by disabling the defense of the carrier using the method #AI_CARGO_APC.SetCombatRadius(), and providing a combat radius of 0 meters.
---It can be switched on later when required by reenabling the defense using the method and providing a combat radius larger than 0.
---
---## Infantry or cargo **health**.
---
---When infantry is unboarded from the APCs, the infantry is actually respawned into the battlefield. 
---As a result, the unboarding infantry is very _healthy_ every time it unboards.
---This is due to the limitation of the DCS simulator, which is not able to specify the health of new spawned units as a parameter.
---However, infantry that was destroyed when unboarded and following the APCs, won't be respawned again. Destroyed is destroyed.
---As a result, there is some additional strength that is gained when an unboarding action happens, but in terms of simulation balance this has
---marginal impact on the overall battlefield simulation. Fortunately, the firing strength of infantry is limited, and thus, respacing healthy infantry every
---time is not so much of an issue ... 
---
---## Control the APCs on the map.
---
---It is possible also as a human ground commander to influence the path of the APCs, by pointing a new path using the DCS user interface on the map.
---In this case, the APCs will change the direction towards its new indicated route. However, there is a catch!
---Once the APCs are near the enemy, and infantry is unboarded, the APCs won't be able to hold the route until the infantry could catch up.
---The APCs will simply drive on and won't stop! This is a limitation in ED that prevents user actions being controlled by the scripting engine.
---No workaround is possible on this.
---
---## Cargo deployment.
--- 
---Using the #AI_CARGO_APC.Deploy() method, you are able to direct the APCs towards a point on the battlefield to unboard/unload the cargo at the specific coordinate. 
---The APCs will follow nearby roads as much as possible, to ensure fast and clean cargo transportation between the objects and villages in the simulation environment.
---
---## Cargo pickup.
--- 
---Using the #AI_CARGO_APC.Pickup() method, you are able to direct the APCs towards a point on the battlefield to board/load the cargo at the specific coordinate. 
---The APCs will follow nearby roads as much as possible, to ensure fast and clean cargo transportation between the objects and villages in the simulation environment.
---
---
---# Developer Note
---
---Note while this class still works, it is no longer supported as the original author stopped active development of MOOSE
---Therefore, this class is considered to be deprecated
---@deprecated
---@class AI_CARGO_APC 
---@field CargoCarrier GROUP 
---@field CarrierCoordinate NOTYPE 
---@field CarrierStopped boolean 
---@field Coalition NOTYPE 
---@field RouteDeploy boolean 
---@field RouteHome boolean 
---@field RoutePickup boolean 
---@field Zone NOTYPE 
---@field private deployOffroad NOTYPE 
---@field private pickupOffroad NOTYPE 
AI_CARGO_APC = {}

---Find a free Carrier within a radius.
---
------
---@param Coordinate COORDINATE 
---@param Radius number 
---@return GROUP #NewCarrier
function AI_CARGO_APC:FindCarrier(Coordinate, Radius) end

---Follow Infantry to the Carrier.
---
------
---@param Me AI_CARGO_APC 
---@param APCUnit UNIT 
---@param Cargo CARGO_GROUP 
---@param CargoGroup NOTYPE 
---@return AI_CARGO_APC #
function AI_CARGO_APC:FollowToCarrier(Me, APCUnit, Cargo, CargoGroup) end

---Creates a new AI_CARGO_APC object.
---
------
---@param APC GROUP The carrier APC group.
---@param CargoSet SET_CARGO The set of cargo to be transported.
---@param CombatRadius number Provide the combat radius to defend the carrier by unboarding the cargo when enemies are nearby. When the combat radius is 0, no defense will happen of the carrier.
---@return AI_CARGO_APC #
function AI_CARGO_APC:New(APC, CargoSet, CombatRadius) end

---Set the Carrier.
---
------
---@param CargoCarrier GROUP 
---@return AI_CARGO_APC #
function AI_CARGO_APC:SetCarrier(CargoCarrier) end

---Enable/Disable unboarding of cargo (infantry) when enemies are nearby (to help defend the carrier).
---This is only valid for APCs and trucks etc, thus ground vehicles.
---
------
---
---USAGE
---```
---
----- Disembark the infantry when the carrier is under attack.
---AICargoAPC:SetCombatRadius( true )
---
----- Keep the cargo in the carrier when the carrier is under attack.
---AICargoAPC:SetCombatRadius( false )
---```
------
---@param CombatRadius number Provide the combat radius to defend the carrier by unboarding the cargo when enemies are nearby.  When the combat radius is 0, no defense will happen of the carrier.  When the combat radius is not provided, no defense will happen!
---@return AI_CARGO_APC #
function AI_CARGO_APC:SetCombatRadius(CombatRadius) end

---Set whether the carrier will *not* use roads to *deploy* the cargo.
---
------
---@param Offroad boolean If true, carrier will not use roads.
---@param Formation number Offroad formation used. Default is `ENUMS.Formation.Vehicle.Offroad`.
---@return AI_CARGO_APC #self
function AI_CARGO_APC:SetDeployOffRoad(Offroad, Formation) end

---Set whether or not the carrier will use roads to *pickup* and *deploy* the cargo.
---
------
---@param Offroad boolean If true, carrier will not use roads. If `nil` or `false` the carrier will use roads when available.
---@param Formation number Offroad formation used. Default is `ENUMS.Formation.Vehicle.Offroad`.
---@return AI_CARGO_APC #self
function AI_CARGO_APC:SetOffRoad(Offroad, Formation) end

---Set whether the carrier will *not* use roads to *pickup* the cargo.
---
------
---@param Offroad boolean If true, carrier will not use roads.
---@param Formation number Offroad formation used. Default is `ENUMS.Formation.Vehicle.Offroad`.
---@return AI_CARGO_APC #self
function AI_CARGO_APC:SetPickupOffRoad(Offroad, Formation) end

---Deploy task function.
---Triggers Unload event.
---
------
---@param self AI_CARGO_APC `AI_CARGO_APC` class.
---@param Coordinate COORDINATE  The coordinate (not used).
---@param DeployZone ZONE Deploy zone.
function AI_CARGO_APC._Deploy(APC, self, Coordinate, DeployZone) end

---Pickup task function.
---Triggers Load event.
---
------
---@param sel AI_CARGO_APC `AI_CARGO_APC` class.
---@param Coordinate COORDINATE  The coordinate (not used).
---@param Speed number Speed (not used).
---@param PickupZone ZONE Pickup zone.
---@param self NOTYPE 
function AI_CARGO_APC._Pickup(APC, sel, Coordinate, Speed, PickupZone, self) end

---On after Deploy event.
---
------
---@param APC GROUP 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@param Coordinate COORDINATE Deploy place.
---@param Speed number Speed in km/h to drive to the depoly coordinate. Default is 50% of max possible speed the unit can go.
---@param Height number Height in meters to move to the deploy coordinate. This parameter is ignored for APCs.
---@param DeployZone ZONE The zone where the cargo will be deployed.
---@private
function AI_CARGO_APC:onafterDeploy(APC, From, Event, To, Coordinate, Speed, Height, DeployZone) end

---On after Deployed event.
---
------
---@param Carrier GROUP 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param DeployZone ZONE The zone wherein the cargo is deployed. This can be any zone type, like a ZONE, ZONE_GROUP, ZONE_AIRBASE.
---@param APC NOTYPE 
---@param Defend NOTYPE 
---@private
function AI_CARGO_APC:onafterDeployed(Carrier, From, Event, To, DeployZone, APC, Defend) end

---On after Follow event.
---
------
---@param APC GROUP 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function AI_CARGO_APC:onafterFollow(APC, From, Event, To) end

---On after Home event.
---
------
---@param APC GROUP 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@param Coordinate COORDINATE Home place.
---@param Speed number Speed in km/h to drive to the pickup coordinate. Default is 50% of max possible speed the unit can go.
---@param Height number Height in meters to move to the home coordinate. This parameter is ignored for APCs.
---@param HomeZone NOTYPE 
---@private
function AI_CARGO_APC:onafterHome(APC, From, Event, To, Coordinate, Speed, Height, HomeZone) end

---On after Monitor event.
---
------
---@param APC GROUP 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function AI_CARGO_APC:onafterMonitor(APC, From, Event, To) end

---On after Pickup event.
---
------
---@param APC GROUP 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@param Coordinate COORDINATE of the pickup point.
---@param Speed number Speed in km/h to drive to the pickup coordinate. Default is 50% of max possible speed the unit can go.
---@param Height number Height in meters to move to the pickup coordinate. This parameter is ignored for APCs.
---@param PickupZone? ZONE (optional) The zone where the cargo will be picked up. The PickupZone can be nil, if there wasn't any PickupZoneSet provided.
---@private
function AI_CARGO_APC:onafterPickup(APC, From, Event, To, Coordinate, Speed, Height, PickupZone) end

---On after Unloaded event.
---
------
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
function AI_CARGO_APC:onafterUnloaded(Carrier, From, Event, To, Cargo, Deployed, DeployZone, CarrierUnit, Defend) end



