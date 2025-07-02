---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Wrapper_Static.JPG" width="100%">
---
---**Wrapper** - STATIC wraps the DCS StaticObject class.
---
---===
---
---### Author: **FlightControl**
---
---### Contributions: **funkyfranky**
---
---===
---Wrapper class to handle Static objects.
---
---Note that Statics are almost the same as Units, but they don't have a controller.
---The Wrapper.Static#STATIC class is a wrapper class to handle the DCS Static objects:
---
--- * Wraps the DCS Static objects.
--- * Support all DCS Static APIs.
--- * Enhance with Static specific APIs not in the DCS API set.
---
---## STATIC reference methods
---
---For each DCS Static will have a STATIC wrapper object (instance) within the global _DATABASE object (an instance of Core.Database#DATABASE).
---This is done at the beginning of the mission (when the mission starts).
--- 
---The #STATIC class does not contain a :New() method, rather it provides :Find() methods to retrieve the object reference
---using the Static Name.
---
---Another thing to know is that STATIC objects do not "contain" the DCS Static object. 
---The #STATIC methods will reference the DCS Static object by name when it is needed during API execution.
---If the DCS Static object does not exist or is nil, the STATIC methods will return nil and log an exception in the DCS.log file.
--- 
---The #STATIC class provides the following functions to retrieve quickly the relevant STATIC instance:
---
--- * #STATIC.FindByName(): Find a STATIC instance from the global _DATABASE object (an instance of Core.Database#DATABASE) using a DCS Static name.
--- 
---IMPORTANT: ONE SHOULD NEVER SANITIZE these STATIC OBJECT REFERENCES! (make the STATIC object references nil).
---@class STATIC : POSITIONABLE
---@field StaticName NOTYPE 
STATIC = {}

---Destroys the STATIC.
---
------
---
---USAGE
---```
----- Air static example: destroy the static Helicopter and generate a S_EVENT_CRASH.
---Helicopter = STATIC:FindByName( "Helicopter" )
---Helicopter:Destroy( true )
---```
------
---@param GenerateEvent? boolean (Optional) true if you want to generate a crash or dead event for the static.
---@return nil #The DCS StaticObject is not existing or alive.  
function STATIC:Destroy(GenerateEvent) end

---Finds a STATIC from the _DATABASE using a DCSStatic object.
---
------
---@param DCSStatic StaticObject An existing DCS Static object reference.
---@return STATIC #self
function STATIC:Find(DCSStatic) end

---Find all STATIC objects matching using patterns.
---Note that this is **a lot** slower than `:FindByName()`!
---
------
---
---USAGE
---```
---         -- Find all static with a partial static name
---         local grptable = STATIC:FindAllByMatching( "Apple" )
---         -- will return all statics with "Apple" in the name
---
---         -- using a pattern
---         local grp = STATIC:FindAllByMatching( ".%d.%d$" )
---         -- will return the all statics found ending in "-1-1" to "-9-9", but not e.g. "-10-1" or "-1-10"
---```
------
---@param Pattern string The pattern to look for. Refer to [LUA patterns](http://www.easyuo.com/openeuo/wiki/index.php/Lua_Patterns_and_Captures_\(Regular_Expressions\)) for regular expressions in LUA.
---@return table #Groups Table of matching #STATIC objects found
function STATIC:FindAllByMatching(Pattern) end

---Find the first(!) STATIC matching using patterns.
---Note that this is **a lot** slower than `:FindByName()`!
---
------
---
---USAGE
---```
---         -- Find a static with a partial static name
---         local grp = STATIC:FindByMatching( "Apple" )
---         -- will return e.g. a static named "Apple-1-1"
---
---         -- using a pattern
---         local grp = STATIC:FindByMatching( ".%d.%d$" )
---         -- will return the first static found ending in "-1-1" to "-9-9", but not e.g. "-10-1"
---```
------
---@param Pattern string The pattern to look for. Refer to [LUA patterns](http://www.easyuo.com/openeuo/wiki/index.php/Lua_Patterns_and_Captures_\(Regular_Expressions\)) for regular expressions in LUA.
---@return STATIC #The STATIC.
function STATIC:FindByMatching(Pattern) end

---Finds a STATIC from the _DATABASE using the relevant Static Name.
---As an optional parameter, a briefing text can be given also.
---
------
---@param StaticName string Name of the DCS **Static** as defined within the Mission Editor.
---@param RaiseError boolean Raise an error if not found.
---@return STATIC #self or *nil*
function STATIC:FindByName(StaticName, RaiseError) end

---Get the Cargo Weight of a static object in kgs.
---Returns -1 if not found.
---
------
---@return number #Mass Weight in kgs.
function STATIC:GetCargoWeight() end

---Get DCS object of static of static.
---
------
---@return NOTYPE #DCS static object
function STATIC:GetDCSObject() end

---Get current life points
---
------
---@return number #lifepoints or nil
function STATIC:GetLife() end

---Get initial life points
---
------
---@return number #lifepoints
function STATIC:GetLife0() end

---Get the Wrapper.Storage#STORAGE object of an static if it is used as cargo and has been set up as storage object.
---
------
---@return STORAGE #Storage or `nil` if not fund or set up.
function STATIC:GetStaticStorage() end

---Get threat level of static.
---
------
---@return number #Threat level 1.
---@return string #"Static"
function STATIC:GetThreatLevel() end

---Returns a list of one Wrapper.Static.
---
------
---@return list #A list of one @{Wrapper.Static}.
function STATIC:GetUnits() end

---Respawn the Wrapper.Static at the same location with the same properties.
---This is useful to respawn a cargo after it has been destroyed.
---
------
---@param CountryID? country.id (Optional) The country ID used for spawning the new static. Default is same as currently.
---@param Delay? number (Optional) Delay in seconds before static is respawned. Default now.
function STATIC:ReSpawn(CountryID, Delay) end

---Respawn the Wrapper.Unit at a defined Coordinate with an optional heading.
---
------
---@param Coordinate COORDINATE The coordinate where to spawn the new Static.
---@param Heading? number (Optional) The heading of the static respawn in degrees. Default the current heading.
---@param Delay? number (Optional) Delay in seconds before static is respawned. Default now.
function STATIC:ReSpawnAt(Coordinate, Heading, Delay) end

---Register a static object.
---
------
---@param StaticName string Name of the static object.
---@return STATIC #self
function STATIC:Register(StaticName) end

---Spawn the Wrapper.Static at a specific coordinate and heading.
---
------
---@param Coordinate COORDINATE The coordinate where to spawn the new Static.
---@param Heading number The heading of the static respawn in degrees. Default is 0 deg.
---@param Delay number Delay in seconds before the static is spawned.
function STATIC:SpawnAt(Coordinate, Heading, Delay) end



