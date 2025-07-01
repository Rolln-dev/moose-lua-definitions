---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/AI_Cargo_Dispatching_For_Helicopters.JPG" width="100%">
---
---**AI** - Models the intelligent transportation of cargo using helicopters.
---
---===
---
---### Author: **FlightControl**
---
---===
---Brings a dynamic cargo handling capability for an AI helicopter group.
--- 
--- ![Banner Image](..\Images\deprecated.png)
--- 
---Helicopter carriers can be mobilized to intelligently transport infantry and other cargo within the simulation.
---
---The AI_CARGO_HELICOPTER class uses the Cargo.Cargo capabilities within the MOOSE framework.
---Cargo.Cargo must be declared within the mission to make the AI_CARGO_HELICOPTER object recognize the cargo.
---Please consult the Cargo.Cargo module for more information. 
---
---## Cargo pickup.
--- 
---Using the #AI_CARGO_HELICOPTER.Pickup() method, you are able to direct the helicopters towards a point on the battlefield to board/load the cargo at the specific coordinate. 
---Ensure that the landing zone is horizontally flat, and that trees cannot be found in the landing vicinity, or the helicopters won't land or will even crash!
---
---## Cargo deployment.
--- 
---Using the #AI_CARGO_HELICOPTER.Deploy() method, you are able to direct the helicopters towards a point on the battlefield to unboard/unload the cargo at the specific coordinate. 
---Ensure that the landing zone is horizontally flat, and that trees cannot be found in the landing vicinity, or the helicopters won't land or will even crash!
---
---## Infantry health.
---
---When infantry is unboarded from the helicopters, the infantry is actually respawned into the battlefield. 
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
---
---===
---@deprecated
---@class AI_CARGO_HELICOPTER 
---@field Coalition NOTYPE 
---@field Helicopter GROUP 
---@field PickupZone NOTYPE 
---@field RouteDeploy boolean 
---@field RouteHome boolean 
---@field RoutePickup boolean 
---@field Zone NOTYPE 
---@field private landingheight NOTYPE 
---@field private landingspeed NOTYPE 
AI_CARGO_HELICOPTER = {}

---Deploy Trigger for AI_CARGO_HELICOPTER
---
------
---@param self AI_CARGO_HELICOPTER 
---@param Coordinate COORDINATE Place at which the cargo is deployed.
---@param Speed number Speed in km/h to fly to the pickup coordinate. Default is 50% of max possible speed the unit can go.
function AI_CARGO_HELICOPTER:Deploy(Coordinate, Speed) end

---Home Trigger for AI_CARGO_HELICOPTER
---
------
---@param self AI_CARGO_HELICOPTER 
---@param Coordinate COORDINATE Place to which the helicopter will go.
---@param Speed? number (optional) Speed in km/h to fly to the pickup coordinate. Default is 50% of max possible speed the unit can go.
---@param Height? number (optional) Height the Helicopter should be flying at.
function AI_CARGO_HELICOPTER:Home(Coordinate, Speed, Height) end

---Creates a new AI_CARGO_HELICOPTER object.
---
------
---@param self AI_CARGO_HELICOPTER 
---@param Helicopter GROUP 
---@param CargoSet SET_CARGO 
---@return AI_CARGO_HELICOPTER #
function AI_CARGO_HELICOPTER:New(Helicopter, CargoSet) end

---Deploy Handler OnAfter for AI_CARGO_HELICOPTER
---
------
---@param self AI_CARGO_HELICOPTER 
---@param From string 
---@param Event string 
---@param To string 
---@param Coordinate COORDINATE 
---@param Speed number Speed in km/h to fly to the pickup coordinate. Default is 50% of max possible speed the unit can go.
function AI_CARGO_HELICOPTER:OnAfterDeploy(From, Event, To, Coordinate, Speed) end

---Deployed Handler OnAfter for AI_CARGO_HELICOPTER
---
------
---@param self AI_CARGO_HELICOPTER 
---@param From string 
---@param Event string 
---@param To string 
function AI_CARGO_HELICOPTER:OnAfterDeployed(From, Event, To) end

---PickedUp Handler OnAfter for AI_CARGO_HELICOPTER - Cargo set has been picked up, ready to deploy
---
------
---@param self AI_CARGO_HELICOPTER 
---@param Helicopter GROUP The helicopter #GROUP object
---@param From string 
---@param Event string 
---@param To string 
---@param Unit UNIT The helicopter #UNIT object
function AI_CARGO_HELICOPTER:OnAfterPickedUp(Helicopter, From, Event, To, Unit) end

---Pickup Handler OnAfter for AI_CARGO_HELICOPTER
---
------
---@param self AI_CARGO_HELICOPTER 
---@param From string 
---@param Event string 
---@param To string 
---@param Coordinate COORDINATE 
---@param Speed number Speed in km/h to fly to the pickup coordinate. Default is 50% of max possible speed the unit can go.
function AI_CARGO_HELICOPTER:OnAfterPickup(From, Event, To, Coordinate, Speed) end

---Unloaded Handler OnAfter for AI_CARGO_HELICOPTER - Cargo unloaded, carrier is empty
---
------
---@param self AI_CARGO_HELICOPTER 
---@param From string 
---@param Event string 
---@param To string 
---@param Cargo CARGO_GROUP The #CARGO_GROUP object.
---@param Unit UNIT The helicopter #UNIT object
function AI_CARGO_HELICOPTER:OnAfterUnloaded(From, Event, To, Cargo, Unit) end

---Deploy Handler OnBefore for AI_CARGO_HELICOPTER
---
------
---@param self AI_CARGO_HELICOPTER 
---@param From string 
---@param Event string 
---@param To string 
---@param Coordinate COORDINATE Place at which cargo is deployed.
---@param Speed number Speed in km/h to fly to the pickup coordinate. Default is 50% of max possible speed the unit can go.
---@return boolean #
function AI_CARGO_HELICOPTER:OnBeforeDeploy(From, Event, To, Coordinate, Speed) end

---Pickup Handler OnBefore for AI_CARGO_HELICOPTER
---
------
---@param self AI_CARGO_HELICOPTER 
---@param From string 
---@param Event string 
---@param To string 
---@param Coordinate COORDINATE 
---@return boolean #
function AI_CARGO_HELICOPTER:OnBeforePickup(From, Event, To, Coordinate) end

---Pickup Trigger for AI_CARGO_HELICOPTER
---
------
---@param self AI_CARGO_HELICOPTER 
---@param Coordinate COORDINATE 
---@param Speed number Speed in km/h to fly to the pickup coordinate. Default is 50% of max possible speed the unit can go.
function AI_CARGO_HELICOPTER:Pickup(Coordinate, Speed) end

---Set the Carrier.
---
------
---@param self AI_CARGO_HELICOPTER 
---@param Helicopter GROUP 
---@return AI_CARGO_HELICOPTER #
function AI_CARGO_HELICOPTER:SetCarrier(Helicopter) end

---Set landingspeed and -height for helicopter landings.
---Adjust after tracing if your helis get stuck after landing.
---
------
---
---USAGE
---```
---If your choppers get stuck, add tracing to your script to determine if they hit the right parameters like so:
---   
---       BASE:TraceOn()
---       BASE:TraceClass("AI_CARGO_HELICOPTER")
---       
---Watch the DCS.log for entries stating `Helicopter:<name>, Height = Helicopter:<number>, Velocity = Helicopter:<number>`
---Adjust if necessary.
---```
------
---@param self AI_CARGO_HELICOPTER 
---@param speed number Landing speed in kph(!), e.g. 15
---@param height number Landing height in meters(!), e.g. 5.5
---@return AI_CARGO_HELICOPTER #self
function AI_CARGO_HELICOPTER:SetLandingSpeedAndHeight(speed, height) end

---Depoloy function and queue.
---
------
---@param self AI_CARGO_HELICOPTER 
---@param AICargoHelicopter GROUP 
---@param Coordinate COORDINATE Coordinate
---@param DeployZone NOTYPE 
function AI_CARGO_HELICOPTER:_Deploy(AICargoHelicopter, Coordinate, DeployZone) end

---Deploy Asynchronous Trigger for AI_CARGO_HELICOPTER
---
------
---@param Delay number Delay in seconds.
---@param self AI_CARGO_HELICOPTER 
---@param Coordinate COORDINATE Place at which the cargo is deployed.
---@param Speed number Speed in km/h to fly to the pickup coordinate. Default is 50% of max possible speed the unit can go.
function AI_CARGO_HELICOPTER.__Deploy(Delay, self, Coordinate, Speed) end

---Home Asynchronous Trigger for AI_CARGO_HELICOPTER
---
------
---@param Delay number Delay in seconds.
---@param self AI_CARGO_HELICOPTER 
---@param Coordinate COORDINATE Place to which the helicopter will go.
---@param Speed? number (optional) Speed in km/h to fly to the pickup coordinate. Default is 50% of max possible speed the unit can go.
---@param Height? number (optional) Height the Helicopter should be flying at. 
function AI_CARGO_HELICOPTER.__Home(Delay, self, Coordinate, Speed, Height) end

---Pickup Asynchronous Trigger for AI_CARGO_HELICOPTER
---
------
---@param self AI_CARGO_HELICOPTER 
---@param Delay number Delay in seconds.
---@param Coordinate COORDINATE 
---@param Speed number Speed in km/h to go to the pickup coordinate. Default is 50% of max possible speed the unit can go.
function AI_CARGO_HELICOPTER:__Pickup(Delay, Coordinate, Speed) end

---On after Deploy event.
---
------
---@param self AI_CARGO_HELICOPTER 
---@param Helicopter GROUP Transport helicopter.
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@param Coordinate COORDINATE Place at which the cargo is deployed.
---@param Speed number Speed in km/h to fly to the pickup coordinate. Default is 50% of max possible speed the unit can go.
---@param Height number Height in meters to move to the deploy coordinate.
---@param DeployZone NOTYPE 
---@private
function AI_CARGO_HELICOPTER:onafterDeploy(Helicopter, From, Event, To, Coordinate, Speed, Height, DeployZone) end

---On after Deployed event.
---
------
---@param self AI_CARGO_HELICOPTER 
---@param Helicopter GROUP 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Cargo CARGO Cargo object.
---@param Deployed boolean Cargo is deployed.
---@param DeployZone NOTYPE 
---@return boolean #True if all cargo has been unloaded.
---@private
function AI_CARGO_HELICOPTER:onafterDeployed(Helicopter, From, Event, To, Cargo, Deployed, DeployZone) end

---On after Home event.
---
------
---@param self AI_CARGO_HELICOPTER 
---@param Helicopter GROUP 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@param Coordinate COORDINATE Home place.
---@param Speed number Speed in km/h to fly to the pickup coordinate. Default is 50% of max possible speed the unit can go.
---@param Height number Height in meters to move to the home coordinate.
---@param HomeZone ZONE The zone wherein the carrier will return when all cargo has been transported. This can be any zone type, like a ZONE, ZONE_GROUP, ZONE_AIRBASE.
---@private
function AI_CARGO_HELICOPTER:onafterHome(Helicopter, From, Event, To, Coordinate, Speed, Height, HomeZone) end


---
------
---@param self NOTYPE 
---@param Helicopter NOTYPE 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@private
function AI_CARGO_HELICOPTER:onafterLanded(Helicopter, From, Event, To) end


---
------
---@param self NOTYPE 
---@param Helicopter NOTYPE 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@param Coordinate NOTYPE 
---@private
function AI_CARGO_HELICOPTER:onafterOrbit(Helicopter, From, Event, To, Coordinate) end

---On after Pickup event.
---
------
---@param self AI_CARGO_HELICOPTER 
---@param Helicopter GROUP 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@param Coordinate COORDINATE Pickup place.
---@param Speed number Speed in km/h to fly to the pickup coordinate. Default is 50% of max possible speed the unit can go.
---@param Height number Height in meters to move to the pickup coordinate. This parameter is ignored for APCs.
---@param PickupZone? ZONE (optional) The zone where the cargo will be picked up. The PickupZone can be nil, if there wasn't any PickupZoneSet provided.
---@private
function AI_CARGO_HELICOPTER:onafterPickup(Helicopter, From, Event, To, Coordinate, Speed, Height, PickupZone) end


---
------
---@param self NOTYPE 
---@param Helicopter NOTYPE 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@param Coordinate NOTYPE 
---@param Speed NOTYPE 
---@param DeployZone NOTYPE 
---@private
function AI_CARGO_HELICOPTER:onafterQueue(Helicopter, From, Event, To, Coordinate, Speed, DeployZone) end



