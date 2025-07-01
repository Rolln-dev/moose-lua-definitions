---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/MOOSE.JPG" width="100%">
---
---**AI** - Models the process of AI air operations.
---
---===
---
---### Author: **FlightControl**
---
---===
---The AI_AIR class implements the core functions to operate an AI Wrapper.Group.
---
---![Banner Image](..\Images\deprecated.png)
---
---# 1) AI_AIR constructor
---  
---  * #AI_AIR.New(): Creates a new AI_AIR object.
---
---# 2) AI_AIR is a Finite State Machine.
---
---This section must be read as follows. Each of the rows indicate a state transition, triggered through an event, and with an ending state of the event was executed.
---The first column is the **From** state, the second column the **Event**, and the third column the **To** state.
---
---So, each of the rows have the following structure.
---
---  * **From** => **Event** => **To**
---
---Important to know is that an event can only be executed if the **current state** is the **From** state.
---This, when an **Event** that is being triggered has a **From** state that is equal to the **Current** state of the state machine, the event will be executed,
---and the resulting state will be the **To** state.
---
---These are the different possible state transitions of this state machine implementation: 
---
---  * Idle => Start => Monitoring
---
---## 2.1) AI_AIR States.
---
---  * **Idle**: The process is idle.
---
---## 2.2) AI_AIR Events.
---
---  * **Start**: Start the transport process.
---  * **Stop**: Stop the transport process.
---  * **Monitor**: Monitor and take action.
---
---# Developer Note
---
---Note while this class still works, it is no longer supported as the original author stopped active development of MOOSE
---Therefore, this class is considered to be deprecated
---@deprecated
---@class AI_AIR : FSM_CONTROLLABLE
---@field CheckStatus boolean 
---@field DisengageRadius NOTYPE 
---@field FuelThresholdPercentage NOTYPE 
---@field HomeAirbase NOTYPE 
---@field IdleCount number 
---@field OutOfFuelOrbitTime NOTYPE 
---@field PatrolCeilingAltitude NOTYPE 
---@field PatrolDamageThreshold NOTYPE 
---@field PatrolFloorAltitude NOTYPE 
---@field PatrolManageDamage boolean 
---@field PatrolMaxSpeed NOTYPE 
---@field PatrolMinSpeed NOTYPE 
---@field RTBMaxSpeed NOTYPE 
---@field RTBMinSpeed NOTYPE 
---@field RTBSpeedMaxFactor number 
---@field RTBSpeedMinFactor number 
---@field TankerName NOTYPE 
---@field TaskDelay number 
AI_AIR = {}


---
------
---@param self NOTYPE 
function AI_AIR:ClearTargetDistance() end


---
------
---@param self NOTYPE 
function AI_AIR:GetDispatcher() end

---Creates a new AI_AIR process.
---
------
---@param self AI_AIR 
---@param AIGroup GROUP The group object to receive the A2G Process.
---@return AI_AIR #
function AI_AIR:New(AIGroup) end

---OnAfter Transition Handler for Event RTB.
---
------
---@param self AI_AIR 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function AI_AIR:OnAfterRTB(Controllable, From, Event, To) end

---Refuel Handler OnAfter for AI_AIR
---
------
---@param self AI_AIR 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string 
---@param Event string 
---@param To string 
function AI_AIR:OnAfterRefuel(Controllable, From, Event, To) end

---Start Handler OnAfter for AI_AIR
---
------
---@param self AI_AIR 
---@param From string 
---@param Event string 
---@param To string 
function AI_AIR:OnAfterStart(From, Event, To) end

---OnAfter Transition Handler for Event Status.
---
------
---@param self AI_AIR 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function AI_AIR:OnAfterStatus(Controllable, From, Event, To) end

---OnAfter Transition Handler for Event Stop.
---
------
---@param self AI_AIR 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function AI_AIR:OnAfterStop(Controllable, From, Event, To) end

---OnBefore Transition Handler for Event RTB.
---
------
---@param self AI_AIR 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function AI_AIR:OnBeforeRTB(Controllable, From, Event, To) end

---Refuel Handler OnBefore for AI_AIR
---
------
---@param self AI_AIR 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string 
---@param Event string 
---@param To string 
---@return boolean #
function AI_AIR:OnBeforeRefuel(Controllable, From, Event, To) end

---Start Handler OnBefore for AI_AIR
---
------
---@param self AI_AIR 
---@param From string 
---@param Event string 
---@param To string 
---@return boolean #
function AI_AIR:OnBeforeStart(From, Event, To) end

---OnBefore Transition Handler for Event Status.
---
------
---@param self AI_AIR 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function AI_AIR:OnBeforeStatus(Controllable, From, Event, To) end

---OnBefore Transition Handler for Event Stop.
---
------
---@param self AI_AIR 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function AI_AIR:OnBeforeStop(Controllable, From, Event, To) end


---
------
---@param self NOTYPE 
---@param EventData NOTYPE 
function AI_AIR:OnCrash(EventData) end


---
------
---@param self NOTYPE 
---@param EventData NOTYPE 
function AI_AIR:OnEjection(EventData) end

---OnEnter Transition Handler for State Returning.
---
------
---@param self AI_AIR 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function AI_AIR:OnEnterReturning(Controllable, From, Event, To) end

---OnEnter Transition Handler for State Stopped.
---
------
---@param self AI_AIR 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function AI_AIR:OnEnterStopped(Controllable, From, Event, To) end

---OnLeave Transition Handler for State Returning.
---
------
---@param self AI_AIR 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function AI_AIR:OnLeaveReturning(Controllable, From, Event, To) end

---OnLeave Transition Handler for State Stopped.
---
------
---@param self AI_AIR 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function AI_AIR:OnLeaveStopped(Controllable, From, Event, To) end


---
------
---@param self NOTYPE 
---@param EventData NOTYPE 
function AI_AIR:OnPilotDead(EventData) end

---Synchronous Event Trigger for Event RTB.
---
------
---@param self AI_AIR 
function AI_AIR:RTB() end


---
------
---@param AIGroup NOTYPE 
---@param Fsm NOTYPE 
function AI_AIR.RTBHold(AIGroup, Fsm) end


---
------
---@param AIGroup NOTYPE 
---@param Fsm NOTYPE 
function AI_AIR.RTBRoute(AIGroup, Fsm) end

---Refuel Trigger for AI_AIR
---
------
---@param self AI_AIR 
function AI_AIR:Refuel() end


---
------
---@param AIGroup NOTYPE 
---@param Fsm NOTYPE 
function AI_AIR.Resume(AIGroup, Fsm) end

---Sets the floor and ceiling altitude of the patrol.
---
------
---@param self AI_AIR 
---@param PatrolFloorAltitude Altitude The lowest altitude in meters where to execute the patrol.
---@param PatrolCeilingAltitude Altitude The highest altitude in meters where to execute the patrol.
---@return AI_AIR #self
function AI_AIR:SetAltitude(PatrolFloorAltitude, PatrolCeilingAltitude) end

---When the AI is damaged beyond a certain threshold, it is required that the AI returns to the home base.
---However, damage cannot be foreseen early on. 
---Therefore, when the damage threshold is reached, 
---the AI will return immediately to the home base (RTB).
---Note that for groups, the average damage of the complete group will be calculated.
---So, in a group of 4 airplanes, 2 lost and 2 with damage 0.2, the damage threshold will be 0.25.
---
------
---@param self AI_AIR 
---@param PatrolDamageThreshold number The threshold in percentage (between 0 and 1) when the AI is considered to be damaged.
---@return AI_AIR #self
function AI_AIR:SetDamageThreshold(PatrolDamageThreshold) end

---Sets the disengage range, that when engaging a target beyond the specified range, the engagement will be cancelled and the plane will RTB.
---
------
---@param self AI_AIR 
---@param DisengageRadius number The disengage range.
---@return AI_AIR #self
function AI_AIR:SetDisengageRadius(DisengageRadius) end


---
------
---@param self NOTYPE 
---@param Dispatcher NOTYPE 
function AI_AIR:SetDispatcher(Dispatcher) end

---When the AI is out of fuel, it is required that a new AI is started, before the old AI can return to the home base.
---Therefore, with a parameter and a calculation of the distance to the home base, the fuel threshold is calculated.
---When the fuel threshold is reached, the AI will continue for a given time its patrol task in orbit, while a new AIControllable is targeted to the AI_AIR.
---Once the time is finished, the old AI will return to the base.
---
------
---@param self AI_AIR 
---@param FuelThresholdPercentage number The threshold in percentage (between 0 and 1) when the AIControllable is considered to get out of fuel.
---@param OutOfFuelOrbitTime number The amount of seconds the out of fuel AIControllable will orbit before returning to the base.
---@return AI_AIR #self
function AI_AIR:SetFuelThreshold(FuelThresholdPercentage, OutOfFuelOrbitTime) end

---Sets the home airbase.
---
------
---@param self AI_AIR 
---@param HomeAirbase AIRBASE 
---@return AI_AIR #self
function AI_AIR:SetHomeAirbase(HomeAirbase) end

---Sets (modifies) the minimum and maximum RTB speed of the patrol.
---
------
---@param self AI_AIR 
---@param RTBMinSpeed Speed The minimum speed of the @{Wrapper.Controllable} in km/h.
---@param RTBMaxSpeed Speed The maximum speed of the @{Wrapper.Controllable} in km/h.
---@return AI_AIR #self
function AI_AIR:SetRTBSpeed(RTBMinSpeed, RTBMaxSpeed) end

---Set the min and max factors on RTB speed.
---Use this, if your planes are heading back to base too fast. Default values are 0.5 and 0.6. 
---The RTB speed is calculated as the max speed of the unit multiplied by MinFactor (lower bracket) and multiplied by MaxFactor (upper bracket). 
---A random value in this bracket is then applied in the waypoint routing generation.
---
------
---@param self AI_AIR 
---@param MinFactor number Lower bracket factor. Defaults to 0.5.
---@param MaxFactor number Upper bracket factor. Defaults to 0.6.
---@return AI_AIR #self
function AI_AIR:SetRTBSpeedFactors(MinFactor, MaxFactor) end

---Sets (modifies) the minimum and maximum speed of the patrol.
---
------
---@param self AI_AIR 
---@param PatrolMinSpeed Speed The minimum speed of the @{Wrapper.Controllable} in km/h.
---@param PatrolMaxSpeed Speed The maximum speed of the @{Wrapper.Controllable} in km/h.
---@return AI_AIR #self
function AI_AIR:SetSpeed(PatrolMinSpeed, PatrolMaxSpeed) end

---Set the status checking off.
---
------
---@param self AI_AIR 
---@return AI_AIR #self
function AI_AIR:SetStatusOff() end

---Sets to refuel at the given tanker.
---
------
---@param self AI_AIR 
---@param TankerName GROUP The group name of the tanker as defined within the Mission Editor or spawned.
---@return AI_AIR #self
function AI_AIR:SetTanker(TankerName) end


---
------
---@param self NOTYPE 
---@param Coordinate NOTYPE 
function AI_AIR:SetTargetDistance(Coordinate) end

---Start Trigger for AI_AIR
---
------
---@param self AI_AIR 
function AI_AIR:Start() end

---Synchronous Event Trigger for Event Status.
---
------
---@param self AI_AIR 
function AI_AIR:Status() end

---Synchronous Event Trigger for Event Stop.
---
------
---@param self AI_AIR 
function AI_AIR:Stop() end

---Asynchronous Event Trigger for Event RTB.
---
------
---@param self AI_AIR 
---@param Delay number The delay in seconds.
function AI_AIR:__RTB(Delay) end

---Refuel Asynchronous Trigger for AI_AIR
---
------
---@param self AI_AIR 
---@param Delay number 
function AI_AIR:__Refuel(Delay) end

---Start Asynchronous Trigger for AI_AIR
---
------
---@param self AI_AIR 
---@param Delay number 
function AI_AIR:__Start(Delay) end

---Asynchronous Event Trigger for Event Status.
---
------
---@param self AI_AIR 
---@param Delay number The delay in seconds.
function AI_AIR:__Status(Delay) end

---Asynchronous Event Trigger for Event Stop.
---
------
---@param self AI_AIR 
---@param Delay number The delay in seconds.
function AI_AIR:__Stop(Delay) end


---
------
---@param self NOTYPE 
---@private
function AI_AIR:onafterDead() end


---
------
---@param self NOTYPE 
---@param AIGroup NOTYPE 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@param HoldTime NOTYPE 
---@private
function AI_AIR:onafterHold(AIGroup, From, Event, To, HoldTime) end


---
------
---@param self NOTYPE 
---@param AIGroup NOTYPE 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@private
function AI_AIR:onafterHome(AIGroup, From, Event, To) end


---
------
---@param self NOTYPE 
---@param AIGroup NOTYPE 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@private
function AI_AIR:onafterRTB(AIGroup, From, Event, To) end


---
------
---@param self NOTYPE 
---@param AIGroup NOTYPE 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@private
function AI_AIR:onafterRefuel(AIGroup, From, Event, To) end

---Coordinates the approriate returning action.
---
------
---@param self AI_AIR 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return AI_AIR #self
---@private
function AI_AIR:onafterReturn(Controllable, From, Event, To) end

---Defines a new patrol route using the AI.AI_Patrol#AI_PATROL_ZONE parameters and settings.
---
------
---@param self AI_AIR 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return AI_AIR #self
---@private
function AI_AIR:onafterStart(Controllable, From, Event, To) end


---
------
---@param self NOTYPE 
---@private
function AI_AIR:onafterStatus() end


---
------
---@param self NOTYPE 
---@private
function AI_AIR:onbeforeStatus() end



