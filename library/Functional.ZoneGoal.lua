---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/MOOSE.JPG" width="100%">
---
---**Functional** - Base class that models processes to achieve goals involving a Zone.
---
---===
---
---ZONE_GOAL models processes that have a Goal with a defined achievement involving a Zone. 
---Derived classes implement the ways how the achievements can be realized.
---
---===
---
---### Author: **FlightControl**
---### Contributions: **funkyfranky**, **Applevangelist**
---
---===
---Models processes that have a Goal with a defined achievement involving a Zone.
---Derived classes implement the ways how the achievements can be realized.
---
---## 1. ZONE_GOAL constructor
---  
---  * #ZONE_GOAL.New(): Creates a new ZONE_GOAL object.
---
---## 2. ZONE_GOAL is a finite state machine (FSM).
---
---### 2.1 ZONE_GOAL States
---
--- * None: Initial State
---
---### 2.2 ZONE_GOAL Events
---
---  * DestroyedUnit: A Wrapper.Unit is destroyed in the Zone. The event will only get triggered if the method #ZONE_GOAL.MonitorDestroyedUnits() is used.
---@class ZONE_GOAL 
---@field SmokeColor NOTYPE 
---@field SmokeScheduler NOTYPE 
---@field SmokeTime NOTYPE 
---@field SmokeZone NOTYPE 
ZONE_GOAL = {}

---DestroyedUnit event.
---
------
function ZONE_GOAL:DestroyedUnit() end

---Flare the zone boundary.
---
------
---@param FlareColor SMOKECOLOR.Color 
function ZONE_GOAL:Flare(FlareColor) end

---Get the Zone.
---
------
---@return ZONE_GOAL #
function ZONE_GOAL:GetZone() end

---Get the name of the Zone.
---
------
---@return string #
function ZONE_GOAL:GetZoneName() end

---Activate the event UnitDestroyed to be fired when a unit is destroyed in the zone.
---
------
function ZONE_GOAL:MonitorDestroyedUnits() end

---ZONE_GOAL Constructor.
---
------
---@param Zone ZONE_RADIUS A @{Core.Zone} object with the goal to be achieved. Alternatively, can be handed as the name of late activated group describing a ZONE_POLYGON with its waypoints.
---@return ZONE_GOAL #
function ZONE_GOAL:New(Zone) end

---DestroyedUnit Handler OnAfter for ZONE_GOAL
---
------
---@param From string 
---@param Event string 
---@param To string 
---@param DestroyedUnit UNIT The destroyed unit.
---@param PlayerName string The name of the player.
function ZONE_GOAL:OnAfterDestroyedUnit(From, Event, To, DestroyedUnit, PlayerName) end

---Activate smoking of zone with the color or the current owner.
---
------
---@param switch boolean If *true* or *nil* activate smoke. If *false* or *nil*, no smoke.
---@return ZONE_GOAL #
function ZONE_GOAL:SetSmokeZone(switch) end

---Set the smoke color.
---
------
---@param SmokeColor SMOKECOLOR.Color 
function ZONE_GOAL:Smoke(SmokeColor) end

---Check status Smoke.
---
------
function ZONE_GOAL:StatusSmoke() end


---
------
---@param EventData NOTYPE 
function ZONE_GOAL:__Destroyed(EventData) end

---DestroyedUnit delayed event
---
------
---@param delay number Delay in seconds.
function ZONE_GOAL:__DestroyedUnit(delay) end

---When started, check the Smoke and the Zone status.
---
------
---@private
function ZONE_GOAL:onafterGuard() end



