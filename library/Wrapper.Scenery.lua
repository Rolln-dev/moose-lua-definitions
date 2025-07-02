---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Wrapper_Scenery.JPG" width="100%">
---
---**Wrapper** - SCENERY models scenery within the DCS simulator.
---
---===
---
---### Author: **FlightControl**
---
---### Contributions: **Applevangelist**, **funkyfranky**
---
---===
---Wrapper class to handle Scenery objects that are defined on the map.
---
---The Wrapper.Scenery#SCENERY class is a wrapper class to handle the DCS Scenery objects:
---
---* Wraps the DCS Scenery objects.
---* Support all DCS Scenery APIs.
---* Enhance with Scenery specific APIs not in the DCS API set.
---SCENERY Class
---@class SCENERY : POSITIONABLE
---@field ClassName string Name of the class.
---@field Life0 number Initial life points.
---@field Properties table 
---@field SceneryName string Name of the scenery object.
---@field SceneryObject Object DCS scenery object.
SCENERY = {}

--- SCENERY objects cannot be destroyed via the API (at the punishment of game crash).
---
------
---@return SCENERY #self
function SCENERY:Destroy() end

--- Scan and find all SCENERY objects from a zone by zone-name.
---Since SCENERY isn't registered in the Moose database (just too many objects per map), we need to do a scan first
--- to find the correct object.
---
------
---@param ZoneName string The name of the zone, can be handed as ZONE_RADIUS or ZONE_POLYGON object
---@return table #of SCENERY Objects, or `nil` if nothing found
function SCENERY:FindAllByZoneName(ZoneName) end

--- Find a SCENERY object from its name or id.
---Since SCENERY isn't registered in the Moose database (just too many objects per map), we need to do a scan first
--- to find the correct object.
---
------
---@param Name string The name/id of the scenery object as taken from the ME. Ex. '595785449'
---@param Coordinate COORDINATE Where to find the scenery object
---@param Radius? number (optional) Search radius around coordinate, defaults to 100
---@param Role NOTYPE 
---@return SCENERY #Scenery Object or `nil` if it cannot be found
function SCENERY:FindByName(Name, Coordinate, Radius, Role) end

--- Find a SCENERY object from its name or id.
---Since SCENERY isn't registered in the Moose database (just too many objects per map), we need to do a scan first
--- to find the correct object.
---
------
---@param Name string The name or id of the scenery object as taken from the ME. Ex. '595785449'
---@param Zone ZONE_BASE Where to find the scenery object. Can be handed as zone name.
---@param Radius? number (optional) Search radius around coordinate, defaults to 100
---@return SCENERY #Scenery Object or `nil` if it cannot be found
function SCENERY:FindByNameInZone(Name, Zone, Radius) end

--- Find a SCENERY object from its zone name.
---Since SCENERY isn't registered in the Moose database (just too many objects per map), we need to do a scan first
--- to find the correct object.
---
------
---@param ZoneName string The name of the scenery zone as created with a right-click on the map in the mission editor and select "assigned to...". Can be handed over as ZONE object.
---@return SCENERY #First found Scenery Object or `nil` if it cannot be found
function SCENERY:FindByZoneName(ZoneName) end

---Returns the scenery Properties table.
---
------
---@return table #The Key:Value table of QuadZone properties of the zone from the scenery assignment .
function SCENERY:GetAllProperties() end

--- Obtain DCS Object from the SCENERY Object.
---
------
---@return Object #DCS scenery object.
function SCENERY:GetDCSObject() end

--- Get current life points from the SCENERY Object.
---Note - Some scenery objects always have 0 life points.
---  **CAVEAT**: Some objects change their life value or "hitpoints" **after** the first hit. Hence we will adjust the life0 value to 120% 
---  of the last life value if life exceeds life0 (initial life) at any point. Thus will will get a smooth percentage decrease, if you use this e.g. as success 
---  criteria for a bombing task.
---
------
---@return number #life
function SCENERY:GetLife() end

--- Get initial life points of the SCENERY Object.
---
------
---@return number #life
function SCENERY:GetLife0() end

--- Obtain object name.
---
------
---@return string #Name
function SCENERY:GetName() end

---Returns the value of the scenery with the given PropertyName, or nil if no matching property exists.
---
------
---@param PropertyName string The name of a the QuadZone Property from the scenery assignment to be retrieved.
---@return string #The Value of the QuadZone Property from the scenery assignment with the given PropertyName, or nil if absent.
function SCENERY:GetProperty(PropertyName) end

--- Get SCENERY relative life in percent, e.g.
---75. Note - Some scenery objects always have 0 life points.
---
------
---@return number #rlife
function SCENERY:GetRelativeLife() end

--- Get the threat level of a SCENERY object.
---Always 0 as scenery does not pose a threat to anyone.
---
------
---@return number #Threat level 0.
---@return string # "Scenery".
function SCENERY:GetThreatLevel() end

---Checks if the value of the scenery with the given PropertyName exists.
---
------
---@param PropertyName string The name of a the QuadZone Property from the scenery assignment to be retrieved.
---@return boolean #Outcome True if it exists, else false.
function SCENERY:HasProperty(PropertyName) end

--- Check if SCENERY Object is alive.
---Note - Some scenery objects always have 0 life points.
---
------
---@param Threshold? number (Optional) If given, SCENERY counts as alive above this relative life in percent (1..100).
---@return number #life
function SCENERY:IsAlive(Threshold) end

--- Check if SCENERY Object is dead.
---Note - Some scenery objects always have 0 life points.
---
------
---@param Threshold? number (Optional) If given, SCENERY counts as dead below this relative life in percent (1..100).
---@return number #life
function SCENERY:IsDead(Threshold) end

--- Register scenery object as POSITIONABLE.
---
------
---@param SceneryName string Scenery name.
---@param SceneryObject Object DCS scenery object.
---@return SCENERY #Scenery object.
function SCENERY:Register(SceneryName, SceneryObject) end

---Set a scenery property
---
------
---@param PropertyName string 
---@param PropertyValue string 
---@return SCENERY #self
function SCENERY:SetProperty(PropertyName, PropertyValue) end



