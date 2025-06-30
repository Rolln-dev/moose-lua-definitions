---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/CleanUp_Airbases.JPG" width="100%">
---
---**Functional** - Keep airbases clean of crashing or colliding airplanes, and kill missiles when being fired at airbases.
---
---===
---
---## Features:
---
---
--- * Try to keep the airbase clean and operational.
--- * Prevent airplanes from crashing.
--- * Clean up obstructing airplanes from the runway that are standing still for a period of time.
--- * Prevent airplanes firing missiles within the airbase zone.
---
---===
---
---## Missions:
---
---[CLA - CleanUp Airbase](https://github.com/FlightControl-Master/MOOSE_MISSIONS/tree/master/Functional/CleanUp)
---
---===
---
---Specific airbases need to be provided that need to be guarded. Each airbase registered, will be guarded within a zone of 8 km around the airbase.
---Any unit that fires a missile, or shoots within the zone of an airbase, will be monitored by CLEANUP_AIRBASE.
---Within the 8km zone, units cannot fire any missile, which prevents the airbase runway to receive missile or bomb hits.
---Any airborne or ground unit that is on the runway below 30 meters (default value) will be automatically removed if it is damaged.
---
---This is not a full 100% secure implementation. It is still possible that CLEANUP_AIRBASE cannot prevent (in-time) to keep the airbase clean.
---The following situations may happen that will still stop the runway of an airbase:
---
---  * A damaged unit is not removed on time when above the runway, and crashes on the runway.
---  * A bomb or missile is still able to dropped on the runway.
---  * Units collide on the airbase, and could not be removed on time.
---
---When a unit is within the airbase zone and needs to be monitored,
---its status will be checked every 0.25 seconds! This is required to ensure that the airbase is kept clean.
---But as a result, there is more CPU overload.
---
---So as an advise, I suggest you use the CLEANUP_AIRBASE class with care:
---
---  * Only monitor airbases that really need to be monitored!
---  * Try not to monitor airbases that are likely to be invaded by enemy troops.
---    For these airbases, there is little use to keep them clean, as they will be invaded anyway...
---
---By following the above guidelines, you can add airbase cleanup with acceptable CPU overhead.
---
---===
---
---### Author: **FlightControl**
---### Contributions:
---
---===
---Keeps airbases clean, and tries to guarantee continuous airbase operations, even under combat.
---
---# 1. CLEANUP_AIRBASE Constructor
---
---Creates the main object which is preventing the airbase to get polluted with debris on the runway, which halts the airbase.
---
---     -- Clean these Zones.
---     CleanUpAirports = CLEANUP_AIRBASE:New( { AIRBASE.Caucasus.Tbilisi, AIRBASE.Caucasus.Kutaisi } )
---
---     -- or
---     CleanUpTbilisi = CLEANUP_AIRBASE:New( AIRBASE.Caucasus.Tbilisi )
---     CleanUpKutaisi = CLEANUP_AIRBASE:New( AIRBASE.Caucasus.Kutaisi )
---
---# 2. Add or Remove airbases
---
---The method #CLEANUP_AIRBASE.AddAirbase() to add an airbase to the cleanup validation process.
---The method #CLEANUP_AIRBASE.RemoveAirbase() removes an airbase from the cleanup validation process.
---
---# 3. Clean missiles and bombs within the airbase zone.
---
---When missiles or bombs hit the runway, the airbase operations stop.
---Use the method #CLEANUP_AIRBASE.SetCleanMissiles() to control the cleaning of missiles, which will prevent airbases to stop.
---Note that this method will not allow anymore airbases to be attacked, so there is a trade-off here to do.
---@class CLEANUP_AIRBASE : CLEANUP_AIRBASE.__
CLEANUP_AIRBASE = {}

---Adds an airbase to the airbase validation list.
---
------
---@param self CLEANUP_AIRBASE 
---@param AirbaseName string 
---@return CLEANUP_AIRBASE #
function CLEANUP_AIRBASE:AddAirbase(AirbaseName) end

---Creates the main object which is handling the cleaning of the debris within the given Zone Names.
---
------
---
---USAGE
---```
--- -- Clean these Zones.
---CleanUpAirports = CLEANUP_AIRBASE:New( { AIRBASE.Caucasus.Tbilisi, AIRBASE.Caucasus.Kutaisi )
---or
---CleanUpTbilisi = CLEANUP_AIRBASE:New( AIRBASE.Caucasus.Tbilisi )
---CleanUpKutaisi = CLEANUP_AIRBASE:New( AIRBASE.Caucasus.Kutaisi )
---```
------
---@param self CLEANUP_AIRBASE 
---@param AirbaseNames list Is a table of airbase names where the debris should be cleaned. Also a single string can be passed with one airbase name.
---@return CLEANUP_AIRBASE #
function CLEANUP_AIRBASE:New(AirbaseNames) end

---Removes an airbase from the airbase validation list.
---
------
---@param self CLEANUP_AIRBASE 
---@param AirbaseName string 
---@return CLEANUP_AIRBASE #
function CLEANUP_AIRBASE:RemoveAirbase(AirbaseName) end

---Enables or disables the cleaning of missiles within the airbase zones.
---Airbase operations stop when a missile or bomb is dropped at a runway.
---Note that when this method is used, the airbase operations won't stop if
---the missile or bomb was cleaned within the airbase zone, which is 8km from the center of the airbase.
---However, there is a trade-off to make. Attacks on airbases won't be possible anymore if this method is used.
---Note, one can also use the method #CLEANUP_AIRBASE.RemoveAirbase() to remove the airbase from the control process as a whole,
---when an enemy unit is near. That is also an option...
---
------
---@param self CLEANUP_AIRBASE 
---@param CleanMissiles string (Default=true) If true, missiles fired are immediately destroyed. If false missiles are not controlled.
---@return CLEANUP_AIRBASE #
function CLEANUP_AIRBASE:SetCleanMissiles(CleanMissiles) end


---@class CLEANUP_AIRBASE.__ : BASE
CLEANUP_AIRBASE.__ = {}



