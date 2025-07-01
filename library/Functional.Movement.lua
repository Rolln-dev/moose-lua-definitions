---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/MOOSE.JPG" width="100%">
---
---**Functional** - Limit the movement of simulaneous moving ground vehicles.
---
---===
--- 
---Limit the simultaneous movement of Groups within a running Mission.
---This module is defined to improve the performance in missions, and to bring additional realism for GROUND vehicles.
---Performance: If in a DCSRTE there are a lot of moving GROUND units, then in a multi player mission, this WILL create lag if
---the main DCS execution core of your CPU is fully utilized. So, this class will limit the amount of simultaneous moving GROUND units
---on defined intervals (currently every minute).
---@class MOVEMENT : BASE
---@field AliveUnits number 
---@field MoveCount number 
---@field MoveMaximum NOTYPE 
---@field MovePrefixes NOTYPE 
---@field MoveUnits table 
MOVEMENT = {}


---
------
---@param self NOTYPE 
---@param MovePrefixes NOTYPE 
---@param MoveMaximum NOTYPE 
function MOVEMENT:New(MovePrefixes, MoveMaximum) end


---
------
---@param self NOTYPE 
---@param Event NOTYPE 
function MOVEMENT:OnDeadOrCrash(Event) end

---Captures the birth events when new Units were spawned.
---
------
---@param self MOVEMENT 
---@param self EVENTDATA 
---@param EventData NOTYPE 
function MOVEMENT:OnEventBirth(self, EventData) end


---
------
---@param self NOTYPE 
function MOVEMENT:ScheduleStart() end


---
------
---@param self NOTYPE 
function MOVEMENT:ScheduleStop() end


---
------
---@param self NOTYPE 
function MOVEMENT:_Scheduler() end



