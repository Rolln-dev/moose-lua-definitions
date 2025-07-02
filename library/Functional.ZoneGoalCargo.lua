---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/MOOSE.JPG" width="100%">
---
---**Functional** - Base class that models processes to achieve goals involving a Zone and Cargo.
---
---===
---
---ZONE_GOAL_CARGO models processes that have a Goal with a defined achievement involving a Zone and Cargo.  
---Derived classes implement the ways how the achievements can be realized.
---
---# Developer Note
---
---![Banner Image](..\Images\deprecated.png)
---
---Note while this class still works, it is no longer supported as the original author stopped active development of MOOSE
---Therefore, this class is considered to be deprecated
---
---===
---
---### Author: **FlightControl**
---
---===
---Models processes that have a Goal with a defined achievement involving a Zone and Cargo.
---Derived classes implement the ways how the achievements can be realized.
---
---## 1. ZONE_GOAL_CARGO constructor
---  
---  * #ZONE_GOAL_CARGO.New(): Creates a new ZONE_GOAL_CARGO object.
---
---## 2. ZONE_GOAL_CARGO is a finite state machine (FSM).
---
---### 2.1 ZONE_GOAL_CARGO States
--- 
---  * **Deployed**: The Zone has been captured by an other coalition.
---  * **Airborne**: The Zone is currently intruded by an other coalition. There are units of the owning coalition and an other coalition in the Zone.
---  * **Loaded**: The Zone is guarded by the owning coalition. There is no other unit of an other coalition in the Zone.
---  * **Empty**: The Zone is empty. There is not valid unit in the Zone.
---
---### 2.2 ZONE_GOAL_CARGO Events
---
---  * **Capture**: The Zone has been captured by an other coalition.
---  * **Attack**: The Zone is currently intruded by an other coalition. There are units of the owning coalition and an other coalition in the Zone.
---  * **Guard**: The Zone is guarded by the owning coalition. There is no other unit of an other coalition in the Zone.
---  * **Empty**: The Zone is empty. There is not valid unit in the Zone.
---  
---### 2.3 ZONE_GOAL_CARGO State Machine
---@class ZONE_GOAL_CARGO 
---@field Coalition NOTYPE 
---@field MarkBlue NOTYPE 
---@field MarkRed NOTYPE 
---@field ScheduleStatusZone NOTYPE 
---@field SmokeScheduler NOTYPE 
---@field States table 
ZONE_GOAL_CARGO = {}

---Attack Trigger for ZONE_GOAL_CARGO
---
------
function ZONE_GOAL_CARGO:Attack() end

---Capture Trigger for ZONE_GOAL_CARGO
---
------
function ZONE_GOAL_CARGO:Capture() end

---Empty Trigger for ZONE_GOAL_CARGO
---
------
function ZONE_GOAL_CARGO:Empty() end

---Get the owning coalition of the zone.
---
------
---@return number #Coalition.
function ZONE_GOAL_CARGO:GetCoalition() end

---Get the owning coalition name of the zone.
---
------
---@return string #Coalition name.
function ZONE_GOAL_CARGO:GetCoalitionName() end

---Guard Trigger for ZONE_GOAL_CARGO
---
------
function ZONE_GOAL_CARGO:Guard() end


---
------
function ZONE_GOAL_CARGO:IsAttacked() end


---
------
function ZONE_GOAL_CARGO:IsCaptured() end


---
------
function ZONE_GOAL_CARGO:IsEmpty() end


---
------
function ZONE_GOAL_CARGO:IsGuarded() end

---Mark.
---
------
function ZONE_GOAL_CARGO:Mark() end

---ZONE_GOAL_CARGO Constructor.
---
------
---@param Zone ZONE A @{Core.Zone} object with the goal to be achieved.
---@param Coalition number The initial coalition owning the zone.
---@return ZONE_GOAL_CARGO #
function ZONE_GOAL_CARGO:New(Zone, Coalition) end

---Attack Handler OnAfter for ZONE_GOAL_CARGO
---
------
---@param From string 
---@param Event string 
---@param To string 
function ZONE_GOAL_CARGO:OnAfterAttack(From, Event, To) end

---Capture Handler OnAfter for ZONE_GOAL_CARGO
---
------
---@param From string 
---@param Event string 
---@param To string 
function ZONE_GOAL_CARGO:OnAfterCapture(From, Event, To) end

---Empty Handler OnAfter for ZONE_GOAL_CARGO
---
------
---@param From string 
---@param Event string 
---@param To string 
function ZONE_GOAL_CARGO:OnAfterEmpty(From, Event, To) end

---Guard Handler OnAfter for ZONE_GOAL_CARGO
---
------
---@param From string 
---@param Event string 
---@param To string 
function ZONE_GOAL_CARGO:OnAfterGuard(From, Event, To) end

---Attack Handler OnBefore for ZONE_GOAL_CARGO
---
------
---@param From string 
---@param Event string 
---@param To string 
---@return boolean #
function ZONE_GOAL_CARGO:OnBeforeAttack(From, Event, To) end

---Capture Handler OnBefore for ZONE_GOAL_CARGO
---
------
---@param From string 
---@param Event string 
---@param To string 
---@return boolean #
function ZONE_GOAL_CARGO:OnBeforeCapture(From, Event, To) end

---Empty Handler OnBefore for ZONE_GOAL_CARGO
---
------
---@param From string 
---@param Event string 
---@param To string 
---@return boolean #
function ZONE_GOAL_CARGO:OnBeforeEmpty(From, Event, To) end

---Guard Handler OnBefore for ZONE_GOAL_CARGO
---
------
---@param From string 
---@param Event string 
---@param To string 
---@return boolean #
function ZONE_GOAL_CARGO:OnBeforeGuard(From, Event, To) end

---Set the owning coalition of the zone.
---
------
---@param Coalition number 
function ZONE_GOAL_CARGO:SetCoalition(Coalition) end

---Check status Coalition ownership.
---
------
function ZONE_GOAL_CARGO:StatusZone() end

---Attack Asynchronous Trigger for ZONE_GOAL_CARGO
---
------
---@param Delay number 
function ZONE_GOAL_CARGO:__Attack(Delay) end

---Capture Asynchronous Trigger for ZONE_GOAL_CARGO
---
------
---@param Delay number 
function ZONE_GOAL_CARGO:__Capture(Delay) end

---Empty Asynchronous Trigger for ZONE_GOAL_CARGO
---
------
---@param Delay number 
function ZONE_GOAL_CARGO:__Empty(Delay) end

---Guard Asynchronous Trigger for ZONE_GOAL_CARGO
---
------
---@param Delay number 
function ZONE_GOAL_CARGO:__Guard(Delay) end

---When started, check the Coalition status.
---
------
---@private
function ZONE_GOAL_CARGO:onafterGuard() end


---
------
---@private
function ZONE_GOAL_CARGO:onenterAttacked() end


---
------
---@private
function ZONE_GOAL_CARGO:onenterCaptured() end


---
------
---@private
function ZONE_GOAL_CARGO:onenterEmpty() end

---Bound.
---
------
---@private
function ZONE_GOAL_CARGO:onenterGuarded() end



