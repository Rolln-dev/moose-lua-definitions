---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Cargo_Crates.JPG" width="100%">
---
---**Cargo** - Management of single cargo crates, which are based on a STATIC object.
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
---![Banner Image](..\Images\deprecated.png)
---
---- Defines a cargo that is represented by a UNIT object within the simulator, and can be transported by a carrier.
---Use the event functions as described above to Load, UnLoad, Board, UnBoard the CARGO\_CRATE objects to and from carriers.
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
---
---===
---Models the behaviour of cargo crates, which can be slingloaded and boarded on helicopters.
---@deprecated
---@class CARGO_CRATE : CARGO_REPRESENTABLE
---@field CargoObject STATIC 
---@field NoDestroy boolean 
CARGO_CRATE = {}

---Check if the cargo can be Boarded.
---
------
---@param self CARGO_CRATE 
function CARGO_CRATE:CanBoard() end

---Check if the cargo can be sling loaded.
---
------
---@param self CARGO_CRATE 
function CARGO_CRATE:CanSlingload() end

---Check if the cargo can be Unboarded.
---
------
---@param self CARGO_CRATE 
function CARGO_CRATE:CanUnboard() end

---Get the current Coordinate of the CargoGroup.
---
------
---@param self CARGO_CRATE 
---@return COORDINATE #The current Coordinate of the first Cargo of the CargoGroup.
---@return nil #There is no valid Cargo in the CargoGroup.
function CARGO_CRATE:GetCoordinate() end

---Get the transportation method of the Cargo.
---
------
---@param self CARGO_CRATE 
---@return string #The transportation method of the Cargo.
function CARGO_CRATE:GetTransportationMethod() end

---Check if the CargoGroup is alive.
---
------
---@param self CARGO_CRATE 
---@return boolean #true if the CargoGroup is alive.
---@return boolean #false if the CargoGroup is dead.
function CARGO_CRATE:IsAlive() end

---Check if Cargo Crate is in the radius for the Cargo to be Boarded or Loaded.
---
------
---@param self CARGO_CRATE 
---@param Coordinate Coordinate 
---@return boolean #true if the Cargo Crate is within the loading radius.
function CARGO_CRATE:IsInLoadRadius(Coordinate) end

---Check if Cargo Crate is in the radius for the Cargo to be reported.
---
------
---@param self CARGO_CRATE 
---@param Coordinate COORDINATE 
---@return boolean #true if the Cargo Crate is within the report radius.
function CARGO_CRATE:IsInReportRadius(Coordinate) end

---Check if Cargo is near to the Carrier.
---The Cargo is near to the Carrier within NearRadius.
---
------
---@param self CARGO_CRATE 
---@param CargoCarrier GROUP 
---@param NearRadius number 
---@return boolean #The Cargo is near to the Carrier.
---@return nil #The Cargo is not near to the Carrier.
function CARGO_CRATE:IsNear(CargoCarrier, NearRadius) end

---CARGO_CRATE Constructor.
---
------
---@param self CARGO_CRATE 
---@param CargoStatic STATIC 
---@param Type string 
---@param Name string 
---@param LoadRadius number (optional)
---@param NearRadius number (optional)
---@return CARGO_CRATE #
function CARGO_CRATE:New(CargoStatic, Type, Name, LoadRadius, NearRadius) end


---
------
---@param self NOTYPE 
---@param EventData NOTYPE 
function CARGO_CRATE:OnEventCargoDead(EventData) end

---Respawn the CargoGroup.
---
------
---@param self CARGO_CRATE 
function CARGO_CRATE:Respawn() end

---Route Cargo to Coordinate and randomize locations.
---
------
---@param self CARGO_CRATE 
---@param Coordinate COORDINATE 
function CARGO_CRATE:RouteTo(Coordinate) end

---Respawn the CargoGroup.
---
------
---@param self CARGO_CRATE 
function CARGO_CRATE:onafterReset() end

---Loaded State.
---
------
---@param self CARGO_CRATE 
---@param Event string 
---@param From string 
---@param To string 
---@param CargoCarrier UNIT 
function CARGO_CRATE:onenterLoaded(Event, From, To, CargoCarrier) end

---Enter UnLoaded State.
---
------
---@param self CARGO_CRATE 
---@param Event string 
---@param From string 
---@param To string 
---@param Core NOTYPE Point#COORDINATE
---@param ToPointVec2 NOTYPE 
function CARGO_CRATE:onenterUnLoaded(Event, From, To, Core, ToPointVec2) end



