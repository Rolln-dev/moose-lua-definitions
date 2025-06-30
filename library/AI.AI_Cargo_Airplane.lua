---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/AI_Cargo_Dispatching_For_Airplanes.JPG" width="100%">
---
---**AI** - Models the intelligent transportation of cargo using airplanes.
---
---===
---
---### Author: **FlightControl**
---
---===
---Brings a dynamic cargo handling capability for an AI airplane group.
---
---![Banner Image](..\Images\deprecated.png)
--- 
---Airplane carrier equipment can be mobilized to intelligently transport infantry and other cargo within the simulation between airbases.
---
---The AI_CARGO_AIRPLANE module uses the Cargo.Cargo capabilities within the MOOSE framework.
---Cargo.Cargo must be declared within the mission to make AI_CARGO_AIRPLANE recognize the cargo.
---Please consult the Cargo.Cargo module for more information. 
---
---## Cargo pickup.
--- 
---Using the #AI_CARGO_AIRPLANE.Pickup() method, you are able to direct the helicopters towards a point on the battlefield to board/load the cargo at the specific coordinate. 
---Ensure that the landing zone is horizontally flat, and that trees cannot be found in the landing vicinity, or the helicopters won't land or will even crash!
---
---## Cargo deployment.
--- 
---Using the #AI_CARGO_AIRPLANE.Deploy() method, you are able to direct the helicopters towards a point on the battlefield to unboard/unload the cargo at the specific coordinate. 
---Ensure that the landing zone is horizontally flat, and that trees cannot be found in the landing vicinity, or the helicopters won't land or will even crash!
---
---## Infantry health.
---
---When infantry is unboarded from the APCs, the infantry is actually respawned into the battlefield. 
---As a result, the unboarding infantry is very _healthy_ every time it unboards.
---This is due to the limitation of the DCS simulator, which is not able to specify the health of new spawned units as a parameter.
---However, infantry that was destroyed when unboarded, won't be respawned again. Destroyed is destroyed.
---As a result, there is some additional strength that is gained when an unboarding action happens, but in terms of simulation balance this has
---marginal impact on the overall battlefield simulation. Fortunately, the firing strength of infantry is limited, and thus, respacing healthy infantry every
---time is not so much of an issue ... 
---
---
---# Developer Note
---
---Note while this class still works, it is no longer supported as the original author stopped active development of MOOSE
---Therefore, this class is considered to be deprecated
---@deprecated
---@class AI_CARGO_AIRPLANE 
---@field Airbase  
---@field Airplane GROUP 
---@field Coalition  
---@field RouteDeploy boolean 
---@field RouteHome boolean 
---@field RoutePickup boolean 
AI_CARGO_AIRPLANE = {}

---Deploy Trigger for AI_CARGO_AIRPLANE
---
------
---@param self AI_CARGO_AIRPLANE 
---@param Coordinate COORDINATE Coordinate where to deploy stuff.
---@param Speed number Speed in km/h for travelling to the deploy base.
---@param Height number Height in meters to move to the home coordinate.
---@param DeployZone ZONE_AIRBASE The airbase zone where the cargo will be deployed. 
function AI_CARGO_AIRPLANE:Deploy(Coordinate, Speed, Height, DeployZone) end

---Find a free Carrier within a range.
---
------
---@param self AI_CARGO_AIRPLANE 
---@param Airbase AIRBASE 
---@param Radius number 
---@param Coordinate NOTYPE 
---@return GROUP #NewCarrier
function AI_CARGO_AIRPLANE:FindCarrier(Airbase, Radius, Coordinate) end

---Creates a new AI_CARGO_AIRPLANE object.
---
------
---@param self AI_CARGO_AIRPLANE 
---@param Airplane GROUP Plane used for transportation of cargo.
---@param CargoSet SET_CARGO Cargo set to be transported.
---@return AI_CARGO_AIRPLANE #
function AI_CARGO_AIRPLANE:New(Airplane, CargoSet) end

---Deploy Handler OnAfter for AI_CARGO_AIRPLANE
---
------
---@param self AI_CARGO_AIRPLANE 
---@param Airplane GROUP Cargo plane.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Coordinate COORDINATE Coordinate where to deploy stuff.
---@param Speed number Speed in km/h for travelling to the deploy base.
---@param Height number Height in meters to move to the home coordinate.
---@param DeployZone ZONE_AIRBASE The airbase zone where the cargo will be deployed.
function AI_CARGO_AIRPLANE:OnAfterDeploy(Airplane, From, Event, To, Coordinate, Speed, Height, DeployZone) end

---On after Deployed event.
---
------
---@param self AI_CARGO_AIRPLANE 
---@param Airplane GROUP Cargo plane.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param DeployZone ZONE The zone wherein the cargo is deployed.
function AI_CARGO_AIRPLANE:OnAfterDeployed(Airplane, From, Event, To, DeployZone) end

---On after Loaded event, i.e.
---triggered when the cargo is inside the carrier.
---
------
---@param self AI_CARGO_AIRPLANE 
---@param Airplane GROUP Cargo plane.
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
function AI_CARGO_AIRPLANE:OnAfterLoaded(Airplane, From, Event, To) end

---Pickup Handler OnAfter for AI_CARGO_AIRPLANE
---
------
---@param self AI_CARGO_AIRPLANE 
---@param Airplane GROUP Cargo transport plane.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Coordinate COORDINATE The coordinate where to pickup stuff.
---@param Speed number Speed in km/h for travelling to pickup base.
---@param Height number Height in meters to move to the pickup coordinate.
---@param PickupZone ZONE_AIRBASE The airbase zone where the cargo will be picked up.
function AI_CARGO_AIRPLANE:OnAfterPickup(Airplane, From, Event, To, Coordinate, Speed, Height, PickupZone) end

---Deploy Handler OnBefore for AI_CARGO_AIRPLANE
---
------
---@param self AI_CARGO_AIRPLANE 
---@param Airplane GROUP Cargo plane.
---@param From string 
---@param Event string 
---@param To string 
---@param Airbase AIRBASE Destination airbase where troops are deployed.
---@param Speed number Speed in km/h for travelling to deploy base.
---@return boolean #
function AI_CARGO_AIRPLANE:OnBeforeDeploy(Airplane, From, Event, To, Airbase, Speed) end

---Pickup Handler OnBefore for AI_CARGO_AIRPLANE
---
------
---@param self AI_CARGO_AIRPLANE 
---@param Airplane GROUP Cargo transport plane.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Airbase AIRBASE Airbase where troops are picked up.
---@param Speed number in km/h for travelling to pickup base.
---@return boolean #
function AI_CARGO_AIRPLANE:OnBeforePickup(Airplane, From, Event, To, Airbase, Speed) end

---Pickup Trigger for AI_CARGO_AIRPLANE
---
------
---@param self AI_CARGO_AIRPLANE 
---@param Coordinate COORDINATE The coordinate where to pickup stuff.
---@param Speed number Speed in km/h for travelling to pickup base.
---@param Height number Height in meters to move to the pickup coordinate.
---@param PickupZone ZONE_AIRBASE The airbase zone where the cargo will be picked up.
function AI_CARGO_AIRPLANE:Pickup(Coordinate, Speed, Height, PickupZone) end

---Route the airplane from one airport or it's current position to another airbase.
---
------
---@param self AI_CARGO_AIRPLANE 
---@param Airplane GROUP Airplane group to be routed.
---@param Airbase AIRBASE Destination airbase.
---@param Speed number Speed in km/h. Default is 80% of max possible speed the group can do.
---@param Height number Height in meters to move to the Airbase.
---@param Uncontrolled boolean If true, spawn group in uncontrolled state.
function AI_CARGO_AIRPLANE:Route(Airplane, Airbase, Speed, Height, Uncontrolled) end

---Set the Carrier (controllable).
---Also initializes events for carrier and defines the coalition.
---
------
---@param self AI_CARGO_AIRPLANE 
---@param Airplane GROUP Transport plane.
---@return AI_CARGO_AIRPLANE #self
function AI_CARGO_AIRPLANE:SetCarrier(Airplane) end

---Deploy Asynchronous Trigger for AI_CARGO_AIRPLANE
---
------
---@param self AI_CARGO_AIRPLANE 
---@param Delay number Delay in seconds.
---@param Coordinate COORDINATE Coordinate where to deploy stuff.
---@param Speed number Speed in km/h for travelling to the deploy base.
---@param Height number Height in meters to move to the home coordinate.
---@param DeployZone ZONE_AIRBASE The airbase zone where the cargo will be deployed.
function AI_CARGO_AIRPLANE:__Deploy(Delay, Coordinate, Speed, Height, DeployZone) end

---Pickup Asynchronous Trigger for AI_CARGO_AIRPLANE
---
------
---@param self AI_CARGO_AIRPLANE 
---@param Delay number Delay in seconds.
---@param Coordinate COORDINATE The coordinate where to pickup stuff.
---@param Speed number Speed in km/h for travelling to pickup base.
---@param Height number Height in meters to move to the pickup coordinate.
---@param PickupZone ZONE_AIRBASE The airbase zone where the cargo will be picked up.
function AI_CARGO_AIRPLANE:__Pickup(Delay, Coordinate, Speed, Height, PickupZone) end

---On after Depoly event.
---Routes plane to the airbase where the troops are deployed.
---
------
---@param self AI_CARGO_AIRPLANE 
---@param Airplane GROUP Cargo transport plane.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Coordinate COORDINATE Coordinate where to deploy stuff.
---@param Speed number Speed in km/h for travelling to the deploy base.
---@param Height number Height in meters to move to the home coordinate.
---@param DeployZone ZONE_AIRBASE The airbase zone where the cargo will be deployed.
function AI_CARGO_AIRPLANE:onafterDeploy(Airplane, From, Event, To, Coordinate, Speed, Height, DeployZone) end

---On after Home event.
---Aircraft will be routed to their home base.
---
------
---@param self AI_CARGO_AIRPLANE 
---@param Airplane GROUP The cargo plane.
---@param From NOTYPE From state.
---@param Event NOTYPE Event.
---@param To NOTYPE To State.
---@param Coordinate COORDINATE Home place (not used).
---@param Speed number Speed in km/h to fly to the home airbase (zone). Default is 80% of max possible speed the unit can go.
---@param Height number Height in meters to move to the home coordinate.
---@param HomeZone ZONE_AIRBASE The home airbase (zone) where the plane should return to.
function AI_CARGO_AIRPLANE:onafterHome(Airplane, From, Event, To, Coordinate, Speed, Height, HomeZone) end

---On after "Landed" event.
---Called on engine shutdown and initiates the pickup mission or unloading event.
---
------
---@param self AI_CARGO_AIRPLANE 
---@param Airplane GROUP Cargo transport plane.
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
function AI_CARGO_AIRPLANE:onafterLanded(Airplane, From, Event, To) end

---On after "Pickup" event.
---Routes transport to pickup airbase.
---
------
---@param self AI_CARGO_AIRPLANE 
---@param Airplane GROUP Cargo transport plane.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Coordinate COORDINATE The coordinate where to pickup stuff.
---@param Speed number Speed in km/h for travelling to pickup base.
---@param Height number Height in meters to move to the pickup coordinate.
---@param PickupZone ZONE_AIRBASE The airbase zone where the cargo will be picked up.
function AI_CARGO_AIRPLANE:onafterPickup(Airplane, From, Event, To, Coordinate, Speed, Height, PickupZone) end

---On after Unload event.
---Cargo is beeing unloaded, i.e. the unboarding process is started.
---
------
---@param self AI_CARGO_AIRPLANE 
---@param Airplane GROUP Cargo transport plane.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param DeployZone ZONE_AIRBASE The airbase zone where the cargo will be deployed.
function AI_CARGO_AIRPLANE:onafterUnload(Airplane, From, Event, To, DeployZone) end



