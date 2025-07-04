---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Wrapper_Storage.png" width="100%">
---
---**Wrapper** - Dynamic Cargo create from the F8 menu.
---
---## Main Features:
---
---   * Convenient access to Ground Crew created cargo items.
---
---===
---
---## Example Missions:
---
---Demo missions can be found on [github](https://github.com/FlightControl-Master/MOOSE_Demos/tree/master/).
---
---===
---
---### Author: **Applevangelist**; additional checks **Chesster**
---
---===
---*The capitalist cannot store labour-power in warehouses after he has bought it, as he may do with the raw material.* -- Karl Marx
---
---===
---
---# The DYNAMICCARGO Concept
---
---The DYNAMICCARGO class offers an easy-to-use wrapper interface to all DCS API functions of DCS dynamically spawned cargo crates.
---We named the class DYNAMICCARGO, because the name WAREHOUSE is already taken by another MOOSE class..
---
---# Constructor
---DYNAMICCARGO class.
---@class DYNAMICCARGO : POSITIONABLE
---@field AircraftDimensions DYNAMICCARGO.AircraftDimensions 
---@field AircraftTypes DYNAMICCARGO.AircraftTypes 
---@field CargoState string 
---@field ClassName string Name of the class.
---@field DCS table Vec3 LastPosition.
---@field Interval number Check Interval. 20 secs default.
---@field LastPosition NOTYPE 
---@field Liquid DYNAMICCARGO.Liquid 
---@field LiquidName DYNAMICCARGO.LiquidName 
---@field Owner string The playername who has created, loaded or unloaded this cargo. Depends on state.
---@field State DYNAMICCARGO.State 
---@field StaticName NOTYPE 
---@field Type DYNAMICCARGO.Type 
---@field private lid string Class id string for output to DCS log file.
---@field private testing boolean 
---@field private timer TIMER Timmer to run intervals
---@field private verbose number Verbosity level.
---@field private version string 
---@field private warehouse STORAGE The STORAGE object.
DYNAMICCARGO = {}

---Find all DYNAMICCARGO objects matching using patterns.
---Note that this is **a lot** slower than `:FindByName()`!
---
------
---
---USAGE
---```
---         -- Find all dynamic cargo with a partial dynamic cargo name
---         local grptable = DYNAMICCARGO:FindAllByMatching( "Apple" )
---         -- will return all dynamic cargos with "Apple" in the name
---
---         -- using a pattern
---         local grp = DYNAMICCARGO:FindAllByMatching( ".%d.%d$" )
---         -- will return the all dynamic cargos found ending in "-1-1" to "-9-9", but not e.g. "-10-1" or "-1-10"
---```
------
---@param Pattern string The pattern to look for. Refer to [LUA patterns](http://www.easyuo.com/openeuo/wiki/index.php/Lua_Patterns_and_Captures_\(Regular_Expressions\)) for regular expressions in LUA.
---@return table #Groups Table of matching #DYNAMICCARGO objects found
function DYNAMICCARGO:FindAllByMatching(Pattern) end

---Find the first(!) DYNAMICCARGO matching using patterns.
---Note that this is **a lot** slower than `:FindByName()`!
---
------
---
---USAGE
---```
---         -- Find a dynamic cargo with a partial dynamic cargo name
---         local grp = DYNAMICCARGO:FindByMatching( "Apple" )
---         -- will return e.g. a dynamic cargo named "Apple|08:00|PKG08"
---
---         -- using a pattern
---         local grp = DYNAMICCARGO:FindByMatching( ".%d.%d$" )
---         -- will return the first dynamic cargo found ending in "-1-1" to "-9-9", but not e.g. "-10-1"
---```
------
---@param Pattern string The pattern to look for. Refer to [LUA patterns](http://www.easyuo.com/openeuo/wiki/index.php/Lua_Patterns_and_Captures_\(Regular_Expressions\)) for regular expressions in LUA.
---@return DYNAMICCARGO #The DYNAMICCARGO.
function DYNAMICCARGO:FindByMatching(Pattern) end

---Find a DYNAMICCARGO in the **_DATABASE** using the name associated with it.
---
------
---@param Name string The dynamic cargo name
---@return DYNAMICCARGO #self
function DYNAMICCARGO:FindByName(Name) end

---Get the cargo display name from this dynamic cargo.
---
------
---@return string #The display name
function DYNAMICCARGO:GetCargoDisplayName() end

---Get the weight in kgs from this dynamic cargo.
---
------
---@return number #Weight in kgs.
function DYNAMICCARGO:GetCargoWeight() end

---[CTLD] Get number of crates this DYNAMICCARGO consists of.
---Always one.
---
------
---@return number #crate number, always one
function DYNAMICCARGO:GetCratesNeeded() end

---Get DCS object.
---
------
---@return NOTYPE #DCS static object
function DYNAMICCARGO:GetDCSObject() end

---Get last known owner name of this DYNAMICCARGO
---
------
---@return string #Owner
function DYNAMICCARGO:GetLastOwner() end

---Find last known position of this DYNAMICCARGO
---
------
---@return Vec3 #Position in 3D space
function DYNAMICCARGO:GetLastPosition() end

---Find current state of this DYNAMICCARGO
---
------
---@return NOTYPE #string The current state
function DYNAMICCARGO:GetState() end

---Get the #STORAGE object from this dynamic cargo.
---
------
---@return STORAGE #Storage The #STORAGE object
function DYNAMICCARGO:GetStorageObject() end

---[CTLD] Get CTLD_CARGO.Enum type of this DYNAMICCARGO
---
------
---@return string #Type, only one at the moment is CTLD_CARGO.Enum.GCLOADABLE
function DYNAMICCARGO:GetType() end

---Returns true if the cargo been loaded into a Helo.
---
------
---@return boolean #Outcome
function DYNAMICCARGO:IsLoaded() end

---Returns true if the cargo is new and has never been loaded into a Helo.
---
------
---@return boolean #Outcome
function DYNAMICCARGO:IsNew() end

---Returns true if the cargo has been removed.
---
------
---@return boolean #Outcome
function DYNAMICCARGO:IsRemoved() end

---Returns true if the cargo has been unloaded from a Helo.
---
------
---@return boolean #Outcome
function DYNAMICCARGO:IsUnloaded() end

---Create a new DYNAMICCARGO object from the DCS static cargo object.
---
------
---@param CargoName string Name of the Cargo.
---@return DYNAMICCARGO #self
function DYNAMICCARGO:Register(CargoName) end

---[CTLD] Get this DYNAMICCARGO drop state.
---True if DYNAMICCARGO.State.UNLOADED
---
------
---@return boolean #Dropped
function DYNAMICCARGO:WasDropped() end

---[Internal] Track helos for loaded/unloaded decision making.
---
------
---@return boolean #IsIn
function DYNAMICCARGO._FilterHeloTypes(client) end

---[Internal] _Get Possible Player Helo Nearby
---
------
---@param pos COORDINATE 
---@param loading boolean If true measure distance for loading else for unloading
---@return boolean #Success
---@return CLIENT #Helo
---@return string #PlayerName
function DYNAMICCARGO:_GetPossibleHeloNearby(pos, loading) end

---[Internal] _Get helo hovering intel
---
------
---@param Unit UNIT The Unit to test
---@param ropelength number Ropelength to test
---@return boolean #Outcome
function DYNAMICCARGO:_HeloHovering(Unit, ropelength) end

---[Internal] Update internal states.
---
------
---@return DYNAMICCARGO #self
function DYNAMICCARGO:_UpdatePosition() end


---Helo types possible.
---@class DYNAMICCARGO.AircraftDimensions 
---@field CH-47Fbl1 table 
DYNAMICCARGO.AircraftDimensions = {}


---Helo types possible.
---@class DYNAMICCARGO.AircraftTypes 
---@field CH-47Fbl1 string 
DYNAMICCARGO.AircraftTypes = {}


---Liquid types.
---@class DYNAMICCARGO.Liquid 
---@field DIESEL number Diesel (3).
---@field GASOLINE number Aviation gasoline (1).
---@field JETFUEL number Jet fuel (0).
---@field MW50 number MW50 (2).
DYNAMICCARGO.Liquid = {}


---Liquid Names for the static cargo resource table.
---@class DYNAMICCARGO.LiquidName 
---@field DIESEL number "diesel".
---@field GASOLINE number "gasoline".
---@field JETFUEL number "jet_fuel".
---@field MW50 number "methanol_mixture".
DYNAMICCARGO.LiquidName = {}


---State types
---@class DYNAMICCARGO.State 
---@field LOADED string 
---@field NEW string 
---@field REMOVED string 
---@field UNLOADED string 
DYNAMICCARGO.State = {}


---Storage types.
---@class DYNAMICCARGO.Type 
---@field AIRCRAFT number aircraft.
---@field LIQUIDS number liquids. Also see #list<#DYNAMICCARGO.Liquid> for types of liquids.
---@field WEAPONS number weapons.
DYNAMICCARGO.Type = {}



