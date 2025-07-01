---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Core_Spot.JPG" width="100%">
---
---**Core** - Management of spotting logistics, that can be activated and deactivated upon command.
---
---===
---
---SPOT implements the DCS Spot class functionality, but adds additional luxury to be able to:
---
---  * Spot for a defined duration.
---  * Updates of laser spot position every 0.2 seconds for moving targets.
---  * Wiggle the spot at the target.
---  * Provide a Wrapper.Unit as a target, instead of a point.
---  * Implement a status machine, LaseOn, LaseOff.
---
---===
---
---# Demo Missions
---
---### [Demo Missions on GitHub](https://github.com/FlightControl-Master/MOOSE_MISSIONS)
---
---===
---
---### Author: **FlightControl**
---### Contributions: 
---
---  * **Ciribob**: Showing the way how to lase targets + how laser codes work!!! Explained the autolase script.
---  * **EasyEB**: Ideas and Beta Testing
---  * **Wingthor**: Beta Testing
---
---===
---Implements the target spotting or marking functionality, but adds additional luxury to be able to:
---
---  * Mark targets for a defined duration.
---  * Updates of laser spot position every 0.25 seconds for moving targets.
---  * Wiggle the spot at the target.
---  * Provide a Wrapper.Unit as a target, instead of a point.
---  * Implement a status machine, LaseOn, LaseOff.
---
---## 1. SPOT constructor
---  
---  * #SPOT.New(): Creates a new SPOT object.
---
---## 2. SPOT is a FSM
---
---![Process]()
---
---### 2.1 SPOT States
---
---  * **Off**: Lasing is switched off.
---  * **On**: Lasing is switched on.
---  * **Destroyed**: Target is destroyed.
---
---### 2.2 SPOT Events
---
---  * **#SPOT.LaseOn(Target, LaserCode, Duration)**: Lase to a target.
---  * **#SPOT.LaseOff()**: Stop lasing the target.
---  * **#SPOT.Lasing()**: Target is being lased.
---  * **#SPOT.Destroyed()**: Triggered when target is destroyed.
---
---## 3. Check if a Target is being lased
---
---The method #SPOT.IsLasing() indicates whether lasing is on or off.
---@class SPOT : FSM
---@field LaseScheduler NOTYPE 
---@field LaserCode NOTYPE 
---@field Lasing boolean 
---@field Recce NOTYPE 
---@field RecceName NOTYPE 
---@field ScheduleID NOTYPE 
---@field SpotIR NOTYPE 
---@field SpotLaser NOTYPE 
---@field TargetCoord NOTYPE 
---@field TargetName NOTYPE 
SPOT = {}

---Destroyed Trigger for SPOT
---
------
---@param self SPOT 
function SPOT:Destroyed() end

---Check if the SPOT is lasing
---
------
---@param self SPOT 
---@return boolean #true if it is lasing
function SPOT:IsLasing() end

---LaseOff Trigger for SPOT
---
------
---@param self SPOT 
function SPOT:LaseOff() end

---LaseOn Trigger for SPOT
---
------
---@param self SPOT 
---@param Target POSITIONABLE 
---@param LaserCode number Laser code.
---@param Duration number Duration of lasing in seconds.
function SPOT:LaseOn(Target, LaserCode, Duration) end

---LaseOnCoordinate Trigger for SPOT.
---
------
---@param self SPOT 
---@param Coordinate COORDINATE The coordinate to lase.
---@param LaserCode number Laser code.
---@param Duration number Duration of lasing in seconds.
function SPOT:LaseOnCoordinate(Coordinate, LaserCode, Duration) end

---SPOT Constructor.
---
------
---@param self SPOT 
---@param Recce UNIT Unit that is lasing
---@return SPOT #
function SPOT:New(Recce) end

---Destroyed Handler OnAfter for SPOT
---
------
---@param self SPOT 
---@param From string 
---@param Event string 
---@param To string 
function SPOT:OnAfterDestroyed(From, Event, To) end

---LaseOff Handler OnAfter for SPOT
---
------
---@param self SPOT 
---@param From string 
---@param Event string 
---@param To string 
function SPOT:OnAfterLaseOff(From, Event, To) end

---LaseOn Handler OnAfter for SPOT
---
------
---@param self SPOT 
---@param From string 
---@param Event string 
---@param To string 
function SPOT:OnAfterLaseOn(From, Event, To) end

---LaseOnCoordinate Handler OnAfter for SPOT.
---
------
---@param self SPOT 
---@param From string 
---@param Event string 
---@param To string 
function SPOT:OnAfterLaseOnCoordinate(From, Event, To) end

---Destroyed Handler OnBefore for SPOT
---
------
---@param self SPOT 
---@param From string 
---@param Event string 
---@param To string 
---@return boolean #
function SPOT:OnBeforeDestroyed(From, Event, To) end

---LaseOff Handler OnBefore for SPOT
---
------
---@param self SPOT 
---@param From string 
---@param Event string 
---@param To string 
---@return boolean #
function SPOT:OnBeforeLaseOff(From, Event, To) end

---LaseOn Handler OnBefore for SPOT
---
------
---@param self SPOT 
---@param From string 
---@param Event string 
---@param To string 
---@return boolean #
function SPOT:OnBeforeLaseOn(From, Event, To) end

---LaseOnCoordinate Handler OnBefore for SPOT.
---
------
---@param self SPOT 
---@param From string 
---@param Event string 
---@param To string 
---@return boolean #
function SPOT:OnBeforeLaseOnCoordinate(From, Event, To) end


---
------
---@param self SPOT 
---@param EventData EVENTDATA 
function SPOT:OnEventDead(EventData) end

---Set laser start position relative to the lasing unit.
---
------
---
---USAGE
---```
---     -- Set lasing position to be the position of the optics of the Gazelle M:
---     myspot:SetRelativeStartPosition({ x = 1.7, y = 1.2, z = 0 })
---```
------
---@param self SPOT 
---@param position table Start position of the laser relative to the lasing unit. Default is { x = 0, y = 2, z = 0 }
---@return SPOT #self
function SPOT:SetRelativeStartPosition(position) end

---Destroyed Asynchronous Trigger for SPOT
---
------
---@param self SPOT 
---@param Delay number 
function SPOT:__Destroyed(Delay) end

---LaseOff Asynchronous Trigger for SPOT
---
------
---@param self SPOT 
---@param Delay number 
function SPOT:__LaseOff(Delay) end

---LaseOn Asynchronous Trigger for SPOT
---
------
---@param self SPOT 
---@param Delay number 
---@param Target POSITIONABLE 
---@param LaserCode number Laser code.
---@param Duration number Duration of lasing in seconds.
function SPOT:__LaseOn(Delay, Target, LaserCode, Duration) end


---
------
---@param self SPOT 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@return SPOT #
---@private
function SPOT:onafterLaseOff(From, Event, To) end

---On after LaseOn event.
---Activates the laser spot.
---
------
---@param self SPOT 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@param Target POSITIONABLE Unit that is being lased.
---@param LaserCode number Laser code.
---@param Duration number Duration of lasing in seconds.
---@private
function SPOT:onafterLaseOn(From, Event, To, Target, LaserCode, Duration) end

---On after LaseOnCoordinate event.
---Activates the laser spot.
---
------
---@param self SPOT 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@param Coordinate COORDINATE The coordinate at which the laser is pointing.
---@param LaserCode number Laser code.
---@param Duration number Duration of lasing in seconds.
---@private
function SPOT:onafterLaseOnCoordinate(From, Event, To, Coordinate, LaserCode, Duration) end


---
------
---@param self SPOT 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@private
function SPOT:onafterLasing(From, Event, To) end



