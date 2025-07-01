---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/AI_Combat_Air_Patrol.JPG" width="100%">
---
---**AI** - Perform Combat Air Patrolling (CAP) for airplanes.
---
---**Features:**
---
---  * Patrol AI airplanes within a given zone.
---  * Trigger detected events when enemy airplanes are detected.
---  * Manage a fuel threshold to RTB on time.
---  * Engage the enemy when detected.
---
---===
---
---### [Demo Missions](https://github.com/FlightControl-Master/MOOSE_MISSIONS/tree/master/AI/AI_CAP)
---
---===
---
---### [YouTube Playlist](https://www.youtube.com/playlist?list=PL7ZUrU4zZUl1YCyPxJgoZn-CfhwyeW65L)
---
---===
---
---### Author: **FlightControl**
---### Contributions:
---
---  * **Quax**: Concept, Advice & Testing.
---  * **Pikey**: Concept, Advice & Testing.
---  * **Gunterlund**: Test case revision.
---  * **Whisper**: Testing.
---  * **Delta99**: Testing.
---
---===
---Implements the core functions to patrol a Core.Zone by an AI Wrapper.Controllable or Wrapper.Group 
---and automatically engage any airborne enemies that are within a certain range or within a certain zone.
---
---![Banner Image](..\Images\deprecated.png)
---
---![Process](..\Presentations\AI_CAP\Dia3.JPG)
---
---The AI_CAP_ZONE is assigned a Wrapper.Group and this must be done before the AI_CAP_ZONE process can be started using the **Start** event.
---
---![Process](..\Presentations\AI_CAP\Dia4.JPG)
---
---The AI will fly towards the random 3D point within the patrol zone, using a random speed within the given altitude and speed limits.
---Upon arrival at the 3D point, a new random 3D point will be selected within the patrol zone using the given limits.
---
---![Process](..\Presentations\AI_CAP\Dia5.JPG)
---
---This cycle will continue.
---
---![Process](..\Presentations\AI_CAP\Dia6.JPG)
---
---During the patrol, the AI will detect enemy targets, which are reported through the **Detected** event.
---
---![Process](..\Presentations\AI_CAP\Dia9.JPG)
---
---When enemies are detected, the AI will automatically engage the enemy.
---
---![Process](..\Presentations\AI_CAP\Dia10.JPG)
---
---Until a fuel or damage threshold has been reached by the AI, or when the AI is commanded to RTB.
---When the fuel threshold has been reached, the airplane will fly towards the nearest friendly airbase and will land.
---
---![Process](..\Presentations\AI_CAP\Dia13.JPG)
---
---## 1. AI_CAP_ZONE constructor
---  
---  * #AI_CAP_ZONE.New(): Creates a new AI_CAP_ZONE object.
---
---## 2. AI_CAP_ZONE is a FSM
---
---![Process](..\Presentations\AI_CAP\Dia2.JPG)
---
---### 2.1 AI_CAP_ZONE States
---
---  * **None** ( Group ): The process is not started yet.
---  * **Patrolling** ( Group ): The AI is patrolling the Patrol Zone.
---  * **Engaging** ( Group ): The AI is engaging the bogeys.
---  * **Returning** ( Group ): The AI is returning to Base..
---
---### 2.2 AI_CAP_ZONE Events
---
---  * **AI.AI_Patrol#AI_PATROL_ZONE.Start**: Start the process.
---  * **AI.AI_Patrol#AI_PATROL_ZONE.Route**: Route the AI to a new random 3D point within the Patrol Zone.
---  * **#AI_CAP_ZONE.Engage**: Let the AI engage the bogeys.
---  * **#AI_CAP_ZONE.Abort**: Aborts the engagement and return patrolling in the patrol zone.
---  * **AI.AI_Patrol#AI_PATROL_ZONE.RTB**: Route the AI to the home base.
---  * **AI.AI_Patrol#AI_PATROL_ZONE.Detect**: The AI is detecting targets.
---  * **AI.AI_Patrol#AI_PATROL_ZONE.Detected**: The AI has detected new targets.
---  * **#AI_CAP_ZONE.Destroy**: The AI has destroyed a bogey Wrapper.Unit.
---  * **#AI_CAP_ZONE.Destroyed**: The AI has destroyed all bogeys Wrapper.Units assigned in the CAS task.
---  * **Status** ( Group ): The AI is checking status (fuel and damage). When the thresholds have been reached, the AI will RTB.
---
---## 3. Set the Range of Engagement
---
---![Range](..\Presentations\AI_CAP\Dia11.JPG)
---
---An optional range can be set in meters, 
---that will define when the AI will engage with the detected airborne enemy targets.
---The range can be beyond or smaller than the range of the Patrol Zone.
---The range is applied at the position of the AI.
---Use the method #AI_CAP_ZONE.SetEngageRange() to define that range.
---
---## 4. Set the Zone of Engagement
---
---![Zone](..\Presentations\AI_CAP\Dia12.JPG)
---
---An optional Core.Zone can be set, 
---that will define when the AI will engage with the detected airborne enemy targets.
---Use the method #AI_CAP_ZONE.SetEngageZone() to define that Zone.
---
---# Developer Note
---
---Note while this class still works, it is no longer supported as the original author stopped active development of MOOSE
---Therefore, this class is considered to be deprecated
---
---===
---@deprecated
---@class AI_CAP_ZONE 
---@field Accomplished boolean 
---@field EngageRange NOTYPE 
---@field EngageZone NOTYPE 
---@field Engaging boolean 
AI_CAP_ZONE = {}

---Synchronous Event Trigger for Event Abort.
---
------
---@param self AI_CAP_ZONE 
function AI_CAP_ZONE:Abort() end

---Synchronous Event Trigger for Event Accomplish.
---
------
---@param self AI_CAP_ZONE 
function AI_CAP_ZONE:Accomplish() end

---Synchronous Event Trigger for Event Destroy.
---
------
---@param self AI_CAP_ZONE 
function AI_CAP_ZONE:Destroy() end

---Synchronous Event Trigger for Event Engage.
---
------
---@param self AI_CAP_ZONE 
function AI_CAP_ZONE:Engage() end


---
------
---@param EngageGroup NOTYPE 
---@param Fsm NOTYPE 
function AI_CAP_ZONE.EngageRoute(EngageGroup, Fsm) end

---Synchronous Event Trigger for Event Fired.
---
------
---@param self AI_CAP_ZONE 
function AI_CAP_ZONE:Fired() end

---Creates a new AI_CAP_ZONE object
---
------
---@param self AI_CAP_ZONE 
---@param PatrolZone ZONE_BASE The @{Core.Zone} where the patrol needs to be executed.
---@param PatrolFloorAltitude Altitude The lowest altitude in meters where to execute the patrol.
---@param PatrolCeilingAltitude Altitude The highest altitude in meters where to execute the patrol.
---@param PatrolMinSpeed Speed The minimum speed of the @{Wrapper.Controllable} in km/h.
---@param PatrolMaxSpeed Speed The maximum speed of the @{Wrapper.Controllable} in km/h.
---@param PatrolAltType AltitudeType The altitude type ("RADIO"=="AGL", "BARO"=="ASL"). Defaults to RADIO
---@return AI_CAP_ZONE #self
function AI_CAP_ZONE:New(PatrolZone, PatrolFloorAltitude, PatrolCeilingAltitude, PatrolMinSpeed, PatrolMaxSpeed, PatrolAltType) end

---OnAfter Transition Handler for Event Abort.
---
------
---@param self AI_CAP_ZONE 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function AI_CAP_ZONE:OnAfterAbort(Controllable, From, Event, To) end

---OnAfter Transition Handler for Event Accomplish.
---
------
---@param self AI_CAP_ZONE 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function AI_CAP_ZONE:OnAfterAccomplish(Controllable, From, Event, To) end

---OnAfter Transition Handler for Event Destroy.
---
------
---@param self AI_CAP_ZONE 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function AI_CAP_ZONE:OnAfterDestroy(Controllable, From, Event, To) end

---OnAfter Transition Handler for Event Engage.
---
------
---@param self AI_CAP_ZONE 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function AI_CAP_ZONE:OnAfterEngage(Controllable, From, Event, To) end

---OnAfter Transition Handler for Event Fired.
---
------
---@param self AI_CAP_ZONE 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function AI_CAP_ZONE:OnAfterFired(Controllable, From, Event, To) end

---OnBefore Transition Handler for Event Abort.
---
------
---@param self AI_CAP_ZONE 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function AI_CAP_ZONE:OnBeforeAbort(Controllable, From, Event, To) end

---OnBefore Transition Handler for Event Accomplish.
---
------
---@param self AI_CAP_ZONE 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function AI_CAP_ZONE:OnBeforeAccomplish(Controllable, From, Event, To) end

---OnBefore Transition Handler for Event Destroy.
---
------
---@param self AI_CAP_ZONE 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function AI_CAP_ZONE:OnBeforeDestroy(Controllable, From, Event, To) end

---OnBefore Transition Handler for Event Engage.
---
------
---@param self AI_CAP_ZONE 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function AI_CAP_ZONE:OnBeforeEngage(Controllable, From, Event, To) end

---OnBefore Transition Handler for Event Fired.
---
------
---@param self AI_CAP_ZONE 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function AI_CAP_ZONE:OnBeforeFired(Controllable, From, Event, To) end

---OnEnter Transition Handler for State Engaging.
---
------
---@param self AI_CAP_ZONE 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function AI_CAP_ZONE:OnEnterEngaging(Controllable, From, Event, To) end


---
------
---@param self NOTYPE 
---@param EventData NOTYPE 
function AI_CAP_ZONE:OnEventDead(EventData) end

---OnLeave Transition Handler for State Engaging.
---
------
---@param self AI_CAP_ZONE 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function AI_CAP_ZONE:OnLeaveEngaging(Controllable, From, Event, To) end

---Set the Engage Range when the AI will engage with airborne enemies.
---
------
---@param self AI_CAP_ZONE 
---@param EngageRange number The Engage Range.
---@return AI_CAP_ZONE #self
function AI_CAP_ZONE:SetEngageRange(EngageRange) end

---Set the Engage Zone which defines where the AI will engage bogies.
---
------
---@param self AI_CAP_ZONE 
---@param EngageZone ZONE The zone where the AI is performing CAP.
---@return AI_CAP_ZONE #self
function AI_CAP_ZONE:SetEngageZone(EngageZone) end

---Asynchronous Event Trigger for Event Abort.
---
------
---@param self AI_CAP_ZONE 
---@param Delay number The delay in seconds.
function AI_CAP_ZONE:__Abort(Delay) end

---Asynchronous Event Trigger for Event Accomplish.
---
------
---@param self AI_CAP_ZONE 
---@param Delay number The delay in seconds.  
function AI_CAP_ZONE:__Accomplish(Delay) end

---Asynchronous Event Trigger for Event Destroy.
---
------
---@param self AI_CAP_ZONE 
---@param Delay number The delay in seconds.
function AI_CAP_ZONE:__Destroy(Delay) end

---Asynchronous Event Trigger for Event Engage.
---
------
---@param self AI_CAP_ZONE 
---@param Delay number The delay in seconds.
function AI_CAP_ZONE:__Engage(Delay) end

---Asynchronous Event Trigger for Event Fired.
---
------
---@param self AI_CAP_ZONE 
---@param Delay number The delay in seconds.
function AI_CAP_ZONE:__Fired(Delay) end


---
------
---@param self NOTYPE 
---@param Controllable NOTYPE 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@private
function AI_CAP_ZONE:onafterAbort(Controllable, From, Event, To) end


---
------
---@param self NOTYPE 
---@param Controllable NOTYPE 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@private
function AI_CAP_ZONE:onafterAccomplish(Controllable, From, Event, To) end


---
------
---@param self NOTYPE 
---@param Controllable NOTYPE 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@param EventData NOTYPE 
---@private
function AI_CAP_ZONE:onafterDestroy(Controllable, From, Event, To, EventData) end


---
------
---@param self NOTYPE 
---@param Controllable NOTYPE 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@private
function AI_CAP_ZONE:onafterDetected(Controllable, From, Event, To) end


---
------
---@param self NOTYPE 
---@param Controllable NOTYPE 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@private
function AI_CAP_ZONE:onafterEngage(Controllable, From, Event, To) end

---onafter State Transition for Event Start.
---
------
---@param self AI_CAP_ZONE 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@private
function AI_CAP_ZONE:onafterStart(Controllable, From, Event, To) end


---
------
---@param self NOTYPE 
---@param Controllable NOTYPE 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@private
function AI_CAP_ZONE:onbeforeEngage(Controllable, From, Event, To) end



