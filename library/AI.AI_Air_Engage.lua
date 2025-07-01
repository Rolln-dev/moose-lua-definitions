---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/AI_Air_To_Ground_Engage.JPG" width="100%">
---
---**AI** - Models the process of air to ground engagement for airplanes and helicopters.
---
---This is a class used in the AI.AI_A2G_Dispatcher.
---
---===
---
---### Author: **FlightControl**
---
---===
---Implements the core functions to intercept intruders.
---Use the Engage trigger to intercept intruders.
---
---![Banner Image](..\Images\deprecated.png)
---
---The AI_AIR_ENGAGE is assigned a Wrapper.Group and this must be done before the AI_AIR_ENGAGE process can be started using the **Start** event.
---
---The AI will fly towards the random 3D point within the patrol zone, using a random speed within the given altitude and speed limits.
---Upon arrival at the 3D point, a new random 3D point will be selected within the patrol zone using the given limits.
---
---This cycle will continue.
---
---During the patrol, the AI will detect enemy targets, which are reported through the **Detected** event.
---
---When enemies are detected, the AI will automatically engage the enemy.
---
---Until a fuel or damage threshold has been reached by the AI, or when the AI is commanded to RTB.
---When the fuel threshold has been reached, the airplane will fly towards the nearest friendly airbase and will land.
---
---## 1. AI_AIR_ENGAGE constructor
---  
---  * #AI_AIR_ENGAGE.New(): Creates a new AI_AIR_ENGAGE object.
---
---## 2. Set the Zone of Engagement
---
---An optional Core.Zone can be set,
---that will define when the AI will engage with the detected airborne enemy targets.
---Use the method AI.AI_CAP#AI_AIR_ENGAGE.SetEngageZone() to define that Zone.
---
---# Developer Note
---
---Note while this class still works, it is no longer supported as the original author stopped active development of MOOSE
---Therefore, this class is considered to be deprecated
---
---# Developer Note
---
---Note while this class still works, it is no longer supported as the original author stopped active development of MOOSE
---Therefore, this class is considered to be deprecated
---
---===
---@deprecated
---@class AI_AIR_ENGAGE : AI_AIR
---@field Accomplished boolean 
---@field Engaging boolean 
AI_AIR_ENGAGE = {}

---Synchronous Event Trigger for Event Abort.
---
------
---@param self AI_AIR_ENGAGE 
function AI_AIR_ENGAGE:Abort() end

---Synchronous Event Trigger for Event Accomplish.
---
------
---@param self AI_AIR_ENGAGE 
function AI_AIR_ENGAGE:Accomplish() end

---Synchronous Event Trigger for Event Destroy.
---
------
---@param self AI_AIR_ENGAGE 
function AI_AIR_ENGAGE:Destroy() end

---Synchronous Event Trigger for Event Engage.
---
------
---@param self AI_AIR_ENGAGE 
function AI_AIR_ENGAGE:Engage() end

---Synchronous Event Trigger for Event EngageRoute.
---
------
---@param self AI_AIR_ENGAGE 
function AI_AIR_ENGAGE:EngageRoute() end

---Synchronous Event Trigger for Event Fired.
---
------
---@param self AI_AIR_ENGAGE 
function AI_AIR_ENGAGE:Fired() end

---Creates a new AI_AIR_ENGAGE object
---
------
---@param self AI_AIR_ENGAGE 
---@param AI_Air AI_AIR The AI_AIR FSM.
---@param AIGroup GROUP The AI group.
---@param EngageMinSpeed Speed (optional, default = 50% of max speed) The minimum speed of the @{Wrapper.Group} in km/h when engaging a target.
---@param EngageMaxSpeed Speed (optional, default = 75% of max speed) The maximum speed of the @{Wrapper.Group} in km/h when engaging a target.
---@param EngageFloorAltitude Altitude (optional, default = 1000m ) The lowest altitude in meters where to execute the engagement.
---@param EngageCeilingAltitude Altitude (optional, default = 1500m ) The highest altitude in meters where to execute the engagement.
---@param EngageAltType AltitudeType The altitude type ("RADIO"=="AGL", "BARO"=="ASL"). Defaults to "RADIO".
---@return AI_AIR_ENGAGE #
function AI_AIR_ENGAGE:New(AI_Air, AIGroup, EngageMinSpeed, EngageMaxSpeed, EngageFloorAltitude, EngageCeilingAltitude, EngageAltType) end

---OnAfter Transition Handler for Event Abort.
---
------
---@param self AI_AIR_ENGAGE 
---@param AIGroup GROUP The Group Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function AI_AIR_ENGAGE:OnAfterAbort(AIGroup, From, Event, To) end

---OnAfter Transition Handler for Event Accomplish.
---
------
---@param self AI_AIR_ENGAGE 
---@param AIGroup GROUP The Group Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function AI_AIR_ENGAGE:OnAfterAccomplish(AIGroup, From, Event, To) end

---OnAfter Transition Handler for Event Destroy.
---
------
---@param self AI_AIR_ENGAGE 
---@param AIGroup GROUP The Group Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function AI_AIR_ENGAGE:OnAfterDestroy(AIGroup, From, Event, To) end

---OnAfter Transition Handler for Event Engage.
---
------
---@param self AI_AIR_ENGAGE 
---@param AIGroup GROUP The Group Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function AI_AIR_ENGAGE:OnAfterEngage(AIGroup, From, Event, To) end

---OnAfter Transition Handler for Event EngageRoute.
---
------
---@param self AI_AIR_ENGAGE 
---@param AIGroup GROUP The Group Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function AI_AIR_ENGAGE:OnAfterEngageRoute(AIGroup, From, Event, To) end

---OnAfter Transition Handler for Event Fired.
---
------
---@param self AI_AIR_ENGAGE 
---@param AIGroup GROUP The Group Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function AI_AIR_ENGAGE:OnAfterFired(AIGroup, From, Event, To) end

---OnBefore Transition Handler for Event Abort.
---
------
---@param self AI_AIR_ENGAGE 
---@param AIGroup GROUP The Group Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function AI_AIR_ENGAGE:OnBeforeAbort(AIGroup, From, Event, To) end

---OnBefore Transition Handler for Event Accomplish.
---
------
---@param self AI_AIR_ENGAGE 
---@param AIGroup GROUP The Group Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function AI_AIR_ENGAGE:OnBeforeAccomplish(AIGroup, From, Event, To) end

---OnBefore Transition Handler for Event Destroy.
---
------
---@param self AI_AIR_ENGAGE 
---@param AIGroup GROUP The Group Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function AI_AIR_ENGAGE:OnBeforeDestroy(AIGroup, From, Event, To) end

---OnBefore Transition Handler for Event Engage.
---
------
---@param self AI_AIR_ENGAGE 
---@param AIGroup GROUP The Group Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function AI_AIR_ENGAGE:OnBeforeEngage(AIGroup, From, Event, To) end

---OnBefore Transition Handler for Event EngageRoute.
---
------
---@param self AI_AIR_ENGAGE 
---@param AIGroup GROUP The Group Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function AI_AIR_ENGAGE:OnBeforeEngageRoute(AIGroup, From, Event, To) end

---OnBefore Transition Handler for Event Fired.
---
------
---@param self AI_AIR_ENGAGE 
---@param AIGroup GROUP The Group Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function AI_AIR_ENGAGE:OnBeforeFired(AIGroup, From, Event, To) end

---OnEnter Transition Handler for State Engaging.
---
------
---@param self AI_AIR_ENGAGE 
---@param AIGroup GROUP The Group Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function AI_AIR_ENGAGE:OnEnterEngaging(AIGroup, From, Event, To) end


---
------
---@param self NOTYPE 
---@param EventData NOTYPE 
function AI_AIR_ENGAGE:OnEventDead(EventData) end

---OnLeave Transition Handler for State Engaging.
---
------
---@param self AI_AIR_ENGAGE 
---@param AIGroup GROUP The Group Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function AI_AIR_ENGAGE:OnLeaveEngaging(AIGroup, From, Event, To) end


---
------
---@param AIEngage NOTYPE 
---@param Fsm NOTYPE 
function AI_AIR_ENGAGE.Resume(AIEngage, Fsm) end

---Asynchronous Event Trigger for Event Abort.
---
------
---@param self AI_AIR_ENGAGE 
---@param Delay number The delay in seconds.
function AI_AIR_ENGAGE:__Abort(Delay) end

---Asynchronous Event Trigger for Event Accomplish.
---
------
---@param self AI_AIR_ENGAGE 
---@param Delay number The delay in seconds.  
function AI_AIR_ENGAGE:__Accomplish(Delay) end

---Asynchronous Event Trigger for Event Destroy.
---
------
---@param self AI_AIR_ENGAGE 
---@param Delay number The delay in seconds.
function AI_AIR_ENGAGE:__Destroy(Delay) end

---Asynchronous Event Trigger for Event Engage.
---
------
---@param self AI_AIR_ENGAGE 
---@param Delay number The delay in seconds.
function AI_AIR_ENGAGE:__Engage(Delay) end

---Asynchronous Event Trigger for Event EngageRoute.
---
------
---@param self AI_AIR_ENGAGE 
---@param Delay number The delay in seconds.
function AI_AIR_ENGAGE:__EngageRoute(Delay) end

---Asynchronous Event Trigger for Event Fired.
---
------
---@param self AI_AIR_ENGAGE 
---@param Delay number The delay in seconds.
function AI_AIR_ENGAGE:__Fired(Delay) end


---
------
---@param AIGroup NOTYPE 
---@param Fsm NOTYPE 
---@param AttackSetUnit NOTYPE 
function AI_AIR_ENGAGE.___Engage(AIGroup, Fsm, AttackSetUnit) end


---
------
---@param AIGroup NOTYPE 
---@param Fsm NOTYPE 
---@param AttackSetUnit NOTYPE 
function AI_AIR_ENGAGE.___EngageRoute(AIGroup, Fsm, AttackSetUnit) end

---onafter event handler for Abort event.
---
------
---@param self AI_AIR_ENGAGE 
---@param AIGroup GROUP The AI Group managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@private
function AI_AIR_ENGAGE:onafterAbort(AIGroup, From, Event, To) end


---
------
---@param self NOTYPE 
---@param AIGroup NOTYPE 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@private
function AI_AIR_ENGAGE:onafterAccomplish(AIGroup, From, Event, To) end


---
------
---@param self NOTYPE 
---@param AIGroup NOTYPE 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@param EventData NOTYPE 
---@private
function AI_AIR_ENGAGE:onafterDestroy(AIGroup, From, Event, To, EventData) end

---onafter event handler for Engage event.
---
------
---@param self AI_AIR_ENGAGE 
---@param AIGroup GROUP The AI Group managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@private
function AI_AIR_ENGAGE:onafterEngage(AIGroup, From, Event, To) end


---
------
---@param self NOTYPE 
---@param DefenderGroup NOTYPE 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@param AttackSetUnit NOTYPE 
---@private
function AI_AIR_ENGAGE:onafterEngageRoute(DefenderGroup, From, Event, To, AttackSetUnit) end

---onafter event handler for Start event.
---
------
---@param self AI_AIR_ENGAGE 
---@param AIGroup GROUP The AI group managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@private
function AI_AIR_ENGAGE:onafterStart(AIGroup, From, Event, To) end

---onbefore event handler for Engage event.
---
------
---@param self AI_AIR_ENGAGE 
---@param AIGroup GROUP The group Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@private
function AI_AIR_ENGAGE:onbeforeEngage(AIGroup, From, Event, To) end



