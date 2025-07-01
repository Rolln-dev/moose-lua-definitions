---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Cargo_Groups.JPG" width="100%">
---
---**Cargo** - Management of grouped cargo logistics, which are based on a GROUP object.
---
---===
---
---### [Demo Missions]()
---
---### [YouTube Playlist]()
---
---===
---
---### Author: **FlightControl**
---### Contributions: 
---
---===
---Defines a cargo that is represented by a Wrapper.Group object within the simulator.
---
---![Banner Image](..\Images\deprecated.png)
---The cargo can be Loaded, UnLoaded, Boarded, UnBoarded to and from Carriers.
---
---The above cargo classes are used by the following AI_CARGO_ classes to allow AI groups to transport cargo:
---
---  * AI Armoured Personnel Carriers to transport cargo and engage in battles, using the AI.AI_Cargo_APC module.
---  * AI Helicopters to transport cargo, using the AI.AI_Cargo_Helicopter module.
---  * AI Planes to transport cargo, using the AI.AI_Cargo_Airplane module.
---  * AI Ships is planned.
---
---The above cargo classes are also used by the TASK_CARGO_ classes to allow human players to transport cargo as part of a tasking:
---
---  * Tasking.Task_Cargo_Transport#TASK_CARGO_TRANSPORT to transport cargo by human players.
---  * Tasking.Task_Cargo_Transport#TASK_CARGO_CSAR to transport downed pilots by human players.
---
---# Developer Note
---
---Note while this class still works, it is no longer supported as the original author stopped active development of MOOSE
---Therefore, this class is considered to be deprecated
---@deprecated
---@class CARGO_GROUP : CARGO_REPORTABLE
---@field CargoGroup NOTYPE 
---@field CargoName NOTYPE 
---@field CargoObject NOTYPE 
---@field CargoSet SET_CARGO The collection of derived CARGO objects.
---@field CargoTemplate NOTYPE 
---@field CargoUnitTemplate table 
---@field GroupName string The name of the CargoGroup.
---@field GroupTemplate NOTYPE 
---@field Grouped boolean 
---@field NearRadius NOTYPE 
---@field Ã GROU  CargoCarrier The carrier group.
CARGO_GROUP = {}

---Signal a flare at the position of the CargoGroup.
---
------
---@param self CARGO_GROUP 
---@param FlareColor FLARECOLOR 
function CARGO_GROUP:Flare(FlareColor) end

---Get the current Coordinate of the CargoGroup.
---
------
---@param self CARGO_GROUP 
---@return COORDINATE #The current Coordinate of the first Cargo of the CargoGroup.
---@return nil #There is no valid Cargo in the CargoGroup.
function CARGO_GROUP:GetCoordinate() end

---Get the amount of cargo units in the group.
---
------
---@param self CARGO_GROUP 
---@return CARGO_GROUP #
function CARGO_GROUP:GetCount() end

---Get the first alive Cargo Unit of the Cargo Group.
---
------
---@param self CARGO_GROUP 
---@return CARGO_GROUP #
function CARGO_GROUP:GetFirstAlive() end

---Get the underlying GROUP object from the CARGO_GROUP.
---
------
---@param self CARGO_GROUP 
---@param Cargo NOTYPE 
---@return CARGO_GROUP #
function CARGO_GROUP:GetGroup(Cargo) end

---Get the transportation method of the Cargo.
---
------
---@param self CARGO_GROUP 
---@return string #The transportation method of the Cargo.
function CARGO_GROUP:GetTransportationMethod() end

---Check if the CargoGroup is alive.
---
------
---@param self CARGO_GROUP 
---@return boolean #true if the CargoGroup is alive.
---@return boolean #false if the CargoGroup is dead.
function CARGO_GROUP:IsAlive() end

---Check if Cargo Group is in the radius for the Cargo to be Boarded.
---
------
---@param self CARGO_GROUP 
---@param Coordinate COORDINATE 
---@return boolean #true if the Cargo Group is within the load radius.
function CARGO_GROUP:IsInLoadRadius(Coordinate) end

---Check if Cargo Group is in the report radius.
---
------
---@param self CARGO_GROUP 
---@param Coordinate Coordinate 
---@return boolean #true if the Cargo Group is within the report radius.
function CARGO_GROUP:IsInReportRadius(Coordinate) end

---Check if the first element of the CargoGroup is the given Core.Zone.
---
------
---@param self CARGO_GROUP 
---@param Zone ZONE_BASE 
---@return boolean #**true** if the first element of the CargoGroup is in the Zone
---@return boolean #**false** if there is no element of the CargoGroup in the Zone.
function CARGO_GROUP:IsInZone(Zone) end

---Check if Cargo is near to the Carrier.
---The Cargo is near to the Carrier if the first unit of the Cargo Group is within NearRadius.
---
------
---@param self CARGO_GROUP 
---@param CargoCarrier GROUP 
---@param NearRadius number 
---@return boolean #The Cargo is near to the Carrier or #nil if the Cargo is not near to the Carrier.
function CARGO_GROUP:IsNear(CargoCarrier, NearRadius) end

---CARGO_GROUP constructor.
---This make a new CARGO_GROUP from a Wrapper.Group object.
---It will "ungroup" the group object within the sim, and will create a Core.Set of individual Unit objects.
---
------
---@param self CARGO_GROUP 
---@param CargoGroup GROUP Group to be transported as cargo.
---@param Type string Cargo type, e.g. "Infantry". This is the type used in SET_CARGO:New():FilterTypes("Infantry") to define the valid cargo groups of the set.
---@param Name string A user defined name of the cargo group. This name CAN be the same as the group object but can also have a different name. This name MUST be unique!
---@param LoadRadius? number (optional) Distance in meters until which a cargo is loaded into the carrier. Cargo outside this radius has to be routed by other means to within the radius to be loaded.
---@param NearRadius? number (optional) Once the units are within this radius of the carrier, they are actually loaded, i.e. disappear from the scene.
---@return CARGO_GROUP #Cargo group object.
function CARGO_GROUP:New(CargoGroup, Type, Name, LoadRadius, NearRadius) end


---
------
---@param self CARGO_GROUP 
---@param EventData EVENTDATA 
function CARGO_GROUP:OnEventCargoDead(EventData) end

---Regroup the cargo group into one group with multiple unit.
---This is required because by default a group will move in formation and this is really an issue for group control.
---Therefore this method is made to be able to regroup a group.
---This works for ground only groups.
---
------
---@param self CARGO_GROUP 
function CARGO_GROUP:Regroup() end

---Respawn the CargoGroup.
---
------
---@param self CARGO_GROUP 
function CARGO_GROUP:Respawn() end

---Route Cargo to Coordinate and randomize locations.
---
------
---@param self CARGO_GROUP 
---@param Coordinate COORDINATE 
function CARGO_GROUP:RouteTo(Coordinate) end

---Smoke the CargoGroup.
---
------
---@param self CARGO_GROUP 
---@param SmokeColor SMOKECOLOR The color of the smoke.
---@param Radius number The radius of randomization around the center of the first element of the CargoGroup.
function CARGO_GROUP:Smoke(SmokeColor, Radius) end

---Ungroup the cargo group into individual groups with one unit.
---This is required because by default a group will move in formation and this is really an issue for group control.
---Therefore this method is made to be able to ungroup a group.
---This works for ground only groups.
---
------
---@param self CARGO_GROUP 
function CARGO_GROUP:Ungroup() end

---After Board Event.
---
------
---@param self CARGO_GROUP 
---@param Event string 
---@param From string 
---@param To string 
---@param CargoCarrier UNIT 
---@param NearRadius number If distance is smaller than this number, cargo is loaded into the carrier.
---@param ... NOTYPE 
---@private
function CARGO_GROUP:onafterBoard(Event, From, To, CargoCarrier, NearRadius, ...) end

---Leave Boarding State.
---
------
---@param self CARGO_GROUP  
---@param Event string 
---@param From string 
---@param To string 
---@param CargoCarrier UNIT 
---@param NearRadius number If distance is smaller than this number, cargo is loaded into the carrier.
---@param ... NOTYPE 
---@private
function CARGO_GROUP:onafterBoarding(Event, From, To, CargoCarrier, NearRadius, ...) end

---Enter Loaded State.
---
------
---@param self CARGO_GROUP 
---@param Event string 
---@param From string 
---@param To string 
---@param CargoCarrier UNIT 
---@param ... NOTYPE 
---@private
function CARGO_GROUP:onafterLoad(Event, From, To, CargoCarrier, ...) end

---Enter UnBoarding State.
---
------
---@param self CARGO_GROUP 
---@param Event string 
---@param From string 
---@param To string 
---@param ToPointVec2 COORDINATE 
---@param NearRadius number If distance is smaller than this number, cargo is loaded into the carrier.
---@param ... NOTYPE 
---@private
function CARGO_GROUP:onafterUnBoard(Event, From, To, ToPointVec2, NearRadius, ...) end

---Leave UnBoarding State.
---
------
---@param self CARGO_GROUP 
---@param Event string 
---@param From string 
---@param To string 
---@param ToPointVec2 COORDINATE 
---@param NearRadius number If distance is smaller than this number, cargo is loaded into the carrier.
---@param ... NOTYPE 
---@private
function CARGO_GROUP:onafterUnBoarding(Event, From, To, ToPointVec2, NearRadius, ...) end

---Enter UnLoaded State.
---
------
---@param self CARGO_GROUP 
---@param Event string 
---@param From string 
---@param To string 
---@param ToPointVec2 COORDINATE 
---@param ... NOTYPE 
---@private
function CARGO_GROUP:onafterUnLoad(Event, From, To, ToPointVec2, ...) end



