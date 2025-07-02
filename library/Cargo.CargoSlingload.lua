---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Cargo_Slingload.JPG" width="100%">
---
---**Cargo** - Management of single cargo crates, which are based on a STATIC object.
---The cargo can only be slingloaded.
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
---Defines a cargo that is represented by a UNIT object within the simulator, and can be transported by a carrier.
---
---The above cargo classes are also used by the TASK_CARGO_ classes to allow human players to transport cargo as part of a tasking:
---
---  * Tasking.Task_Cargo_Transport#TASK_CARGO_TRANSPORT to transport cargo by human players.
---  * Tasking.Task_Cargo_Transport#TASK_CARGO_CSAR to transport downed pilots by human players.
---
---# Developer Note
---
---![Banner Image](..\Images\deprecated.png)
---
---Note while this class still works, it is no longer supported as the original author stopped active development of MOOSE
---Therefore, this class is considered to be deprecated
---
---===
---Models the behaviour of cargo crates, which can only be slingloaded.
---@deprecated
---@class CARGO_SLINGLOAD : CARGO_REPRESENTABLE
---@field CargoObject NOTYPE 
CARGO_SLINGLOAD = {}

---Check if the cargo can be Boarded.
---
------
function CARGO_SLINGLOAD:CanBoard() end

---Check if the cargo can be Loaded.
---
------
function CARGO_SLINGLOAD:CanLoad() end

---Check if the cargo can be Slingloaded.
---
------
function CARGO_SLINGLOAD:CanSlingload() end

---Check if the cargo can be Unboarded.
---
------
function CARGO_SLINGLOAD:CanUnboard() end

---Check if the cargo can be Unloaded.
---
------
function CARGO_SLINGLOAD:CanUnload() end

---Get the current Coordinate of the CargoGroup.
---
------
---@return COORDINATE #The current Coordinate of the first Cargo of the CargoGroup.
---@return nil #There is no valid Cargo in the CargoGroup.
function CARGO_SLINGLOAD:GetCoordinate() end

---Get the transportation method of the Cargo.
---
------
---@return string #The transportation method of the Cargo.
function CARGO_SLINGLOAD:GetTransportationMethod() end

---Check if the CargoGroup is alive.
---
------
---@return boolean #true if the CargoGroup is alive.
---@return boolean #false if the CargoGroup is dead.
function CARGO_SLINGLOAD:IsAlive() end

---Check if Cargo Slingload is in the radius for the Cargo to be Boarded or Loaded.
---
------
---@param Coordinate COORDINATE 
---@return boolean #true if the Cargo Slingload is within the loading radius.
function CARGO_SLINGLOAD:IsInLoadRadius(Coordinate) end

---Check if Cargo Crate is in the radius for the Cargo to be reported.
---
------
---@param Coordinate COORDINATE 
---@return boolean #true if the Cargo Crate is within the report radius.
function CARGO_SLINGLOAD:IsInReportRadius(Coordinate) end

---Check if Cargo is near to the Carrier.
---The Cargo is near to the Carrier within NearRadius.
---
------
---@param CargoCarrier GROUP 
---@param NearRadius number 
---@return boolean #The Cargo is near to the Carrier.
---@return nil #The Cargo is not near to the Carrier.
function CARGO_SLINGLOAD:IsNear(CargoCarrier, NearRadius) end

---CARGO_SLINGLOAD Constructor.
---
------
---@param CargoStatic STATIC 
---@param Type string 
---@param Name string 
---@param LoadRadius? number (optional)
---@param NearRadius? number (optional)
---@return CARGO_SLINGLOAD #
function CARGO_SLINGLOAD:New(CargoStatic, Type, Name, LoadRadius, NearRadius) end


---
------
---@param EventData NOTYPE 
function CARGO_SLINGLOAD:OnEventCargoDead(EventData) end

---Respawn the CargoGroup.
---
------
function CARGO_SLINGLOAD:Respawn() end

---Route Cargo to Coordinate and randomize locations.
---
------
---@param Coordinate COORDINATE 
function CARGO_SLINGLOAD:RouteTo(Coordinate) end

---Respawn the CargoGroup.
---
------
---@private
function CARGO_SLINGLOAD:onafterReset() end



