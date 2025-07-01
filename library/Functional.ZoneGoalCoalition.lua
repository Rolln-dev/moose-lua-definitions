---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/MOOSE.JPG" width="100%">
---
---**Functional (WIP)** - Base class modeling processes to achieve goals involving coalition zones.
---
---===
---
---ZONE_GOAL_COALITION models processes that have a Goal with a defined achievement involving a Zone for a Coalition.
---Derived classes implement the ways how the achievements can be realized.
---
---===
---
---### Author: **FlightControl**
---
---===
---ZONE_GOAL_COALITION models processes that have a Goal with a defined achievement involving a Zone for a Coalition.
---Derived classes implement the ways how the achievements can be realized.
---
---## 1. ZONE_GOAL_COALITION constructor
---
---  * #ZONE_GOAL_COALITION.New(): Creates a new ZONE_GOAL_COALITION object.
---
---## 2. ZONE_GOAL_COALITION is a finite state machine (FSM).
---
---### 2.1 ZONE_GOAL_COALITION States
---
---### 2.2 ZONE_GOAL_COALITION Events
---
---### 2.3 ZONE_GOAL_COALITION State Machine
---@class ZONE_GOAL_COALITION 
---@field Coalition NOTYPE 
---@field States table 
ZONE_GOAL_COALITION = {}

---Get the owning coalition of the zone.
---
------
---@param self ZONE_GOAL_COALITION 
---@return number #Coalition.
function ZONE_GOAL_COALITION:GetCoalition() end

---Get the owning coalition name of the zone.
---
------
---@param self ZONE_GOAL_COALITION 
---@return string #Coalition name.
function ZONE_GOAL_COALITION:GetCoalitionName() end

---Get the previous coalition, i.e.
---the one owning the zone before the current one.
---
------
---@param self ZONE_GOAL_COALITION 
---@return number #Coalition.
function ZONE_GOAL_COALITION:GetPreviousCoalition() end

---ZONE_GOAL_COALITION Constructor.
---
------
---@param self ZONE_GOAL_COALITION 
---@param Zone ZONE A @{Core.Zone} object with the goal to be achieved.
---@param Coalition number The initial coalition owning the zone. Default coalition.side.NEUTRAL.
---@param UnitCategories table Table of unit categories. See [DCS Class Unit](https://wiki.hoggitworld.com/view/DCS_Class_Unit). Default {Unit.Category.GROUND_UNIT}.
---@return ZONE_GOAL_COALITION #
function ZONE_GOAL_COALITION:New(Zone, Coalition, UnitCategories) end

---Set the owning coalition of the zone.
---
------
---@param self ZONE_GOAL_COALITION 
---@param Coalition number The coalition ID, e.g. *coalition.side.RED*.
---@return ZONE_GOAL_COALITION #
function ZONE_GOAL_COALITION:SetCoalition(Coalition) end

---Set the owning coalition of the zone.
---
------
---@param self ZONE_GOAL_COALITION 
---@param ObjectCategories table Table of unit categories. See [DCS Class Object](https://wiki.hoggitworld.com/view/DCS_Class_Object). Default {Object.Category.UNIT, Object.Category.STATIC}, i.e. all UNITS and STATICS.
---@return ZONE_GOAL_COALITION #
function ZONE_GOAL_COALITION:SetObjectCategories(ObjectCategories) end

---Set the owning coalition of the zone.
---
------
---@param self ZONE_GOAL_COALITION 
---@param UnitCategories table Table of unit categories. See [DCS Class Unit](https://wiki.hoggitworld.com/view/DCS_Class_Unit). Default {Unit.Category.GROUND_UNIT}.
---@return ZONE_GOAL_COALITION #
function ZONE_GOAL_COALITION:SetUnitCategories(UnitCategories) end

---Check status Coalition ownership.
---
------
---@param self ZONE_GOAL_COALITION 
---@return ZONE_GOAL_COALITION #
function ZONE_GOAL_COALITION:StatusZone() end



