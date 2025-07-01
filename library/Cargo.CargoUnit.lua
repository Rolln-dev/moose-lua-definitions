---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Cargo_Units.JPG" width="100%">
---
---**Cargo** - Management of single cargo logistics, which are based on a UNIT object.
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
---Use the event functions as described above to Load, UnLoad, Board, UnBoard the CARGO_UNIT objects to and from carriers.
---Note that ground forces behave in a group, and thus, act in formation, regardless if one unit is commanded to move.
---
---This class is used in CARGO_GROUP, and is not meant to be used by mission designers individually.
---
---# Developer Note
---
---![Banner Image](..\Images\deprecated.png)
---
---Note while this class still works, it is no longer supported as the original author stopped active development of MOOSE
---Therefore, this class is considered to be deprecated
---
---===
---Models CARGO in the form of units, which can be boarded, unboarded, loaded, unloaded.
---@deprecated
---@class CARGO_UNIT : CARGO_REPRESENTABLE
---@field CargoCarrier NOTYPE 
---@field CargoInAir NOTYPE 
---@field CargoObject NOTYPE 
---@field RunCount number 
CARGO_UNIT = {}

---Get the transportation method of the Cargo.
---
------
---@param self CARGO_UNIT 
---@return string #The transportation method of the Cargo.
function CARGO_UNIT:GetTransportationMethod() end

---CARGO_UNIT Constructor.
---
------
---@param self CARGO_UNIT 
---@param CargoUnit UNIT 
---@param Type string 
---@param Name string 
---@param Weight number 
---@param LoadRadius? number (optional)
---@param NearRadius? number (optional)
---@return CARGO_UNIT #
function CARGO_UNIT:New(CargoUnit, Type, Name, Weight, LoadRadius, NearRadius) end

---Board Event.
---
------
---@param self CARGO_UNIT 
---@param Event string 
---@param From string 
---@param To string 
---@param CargoCarrier GROUP 
---@param NearRadius number 
---@param ... NOTYPE 
---@private
function CARGO_UNIT:onafterBoard(Event, From, To, CargoCarrier, NearRadius, ...) end

---Boarding Event.
---
------
---@param self CARGO_UNIT 
---@param Event string 
---@param From string 
---@param To string 
---@param CargoCarrier CLIENT 
---@param NearRadius number Default 25 m.
---@param ... NOTYPE 
---@private
function CARGO_UNIT:onafterBoarding(Event, From, To, CargoCarrier, NearRadius, ...) end

---UnBoard Event.
---
------
---@param self CARGO_UNIT 
---@param Event string 
---@param From string 
---@param To string 
---@param ToPointVec2 COORDINATE 
---@param NearRadius? number (optional) Defaut 100 m.
---@private
function CARGO_UNIT:onafterUnBoarding(Event, From, To, ToPointVec2, NearRadius) end

---Loaded State.
---
------
---@param self CARGO_UNIT 
---@param Event string 
---@param From string 
---@param To string 
---@param CargoCarrier UNIT 
---@private
function CARGO_UNIT:onenterLoaded(Event, From, To, CargoCarrier) end

---Enter UnBoarding State.
---
------
---@param self CARGO_UNIT 
---@param Event string 
---@param From string 
---@param To string 
---@param ToPointVec2 COORDINATE 
---@param NearRadius? number (optional) Defaut 25 m.
---@private
function CARGO_UNIT:onenterUnBoarding(Event, From, To, ToPointVec2, NearRadius) end

---Enter UnLoaded State.
---
------
---@param self CARGO_UNIT 
---@param Event string 
---@param From string 
---@param To string 
---@param Core NOTYPE Point#COORDINATE
---@param ToPointVec2 NOTYPE 
---@private
function CARGO_UNIT:onenterUnLoaded(Event, From, To, Core, ToPointVec2) end

---Leave UnBoarding State.
---
------
---@param self CARGO_UNIT 
---@param Event string 
---@param From string 
---@param To string 
---@param ToPointVec2 COORDINATE 
---@param NearRadius? number (optional) Defaut 100 m.
---@private
function CARGO_UNIT:onleaveUnBoarding(Event, From, To, ToPointVec2, NearRadius) end



