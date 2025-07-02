---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/AI_Close_Air_Support.JPG" width="100%">
---
---**AI** - Perform Close Air Support (CAS) near friendlies.
---
---**Features:**
---
---  * Hold and standby within a patrol zone.
---  * Engage upon command the enemies within an engagement zone.
---  * Loop the zone until all enemies are eliminated.
---  * Trigger different events upon the results achieved.
---  * After combat, return to the patrol zone and hold.
---  * RTB when commanded or after fuel.
---
---===
---
---### [Demo Missions](https://github.com/FlightControl-Master/MOOSE_MISSIONS/tree/master/AI/AI_CAS)
---
---===
---
---### [YouTube Playlist](https://www.youtube.com/playlist?list=PL7ZUrU4zZUl3JBO1WDqqpyYRRmIkR2ir2)
---
---===
---
---### Author: **FlightControl**
---### Contributions: 
---
---  * **Quax**: Concept, Advice & Testing.
---  * **Pikey**: Concept, Advice & Testing.
---  * **Gunterlund**: Test case revision.
---
---===
---Implements the core functions to provide Close Air Support in an Engage Core.Zone by an AIR Wrapper.Controllable or Wrapper.Group.
---
---![Banner Image](..\Images\deprecated.png)
---
---The AI_CAS_ZONE runs a process. It holds an AI in a Patrol Zone and when the AI is commanded to engage, it will fly to an Engage Zone.
---
---![HoldAndEngage](..\Presentations\AI_CAS\Dia3.JPG)
---
---The AI_CAS_ZONE is assigned a Wrapper.Group and this must be done before the AI_CAS_ZONE process can be started through the **Start** event.
--- 
---![Start Event](..\Presentations\AI_CAS\Dia4.JPG)
---
---Upon started, The AI will **Route** itself towards the random 3D point within a patrol zone, 
---using a random speed within the given altitude and speed limits.
---Upon arrival at the 3D point, a new random 3D point will be selected within the patrol zone using the given limits.
---This cycle will continue until a fuel or damage threshold has been reached by the AI, or when the AI is commanded to RTB.
---
---![Route Event](..\Presentations\AI_CAS\Dia5.JPG)
---
---When the AI is commanded to provide Close Air Support (through the event **Engage**), the AI will fly towards the Engage Zone.
---Any target that is detected in the Engage Zone will be reported and will be destroyed by the AI.
---
---![Engage Event](..\Presentations\AI_CAS\Dia6.JPG)
---
---The AI will detect the targets and will only destroy the targets within the Engage Zone.
---
---![Engage Event](..\Presentations\AI_CAS\Dia7.JPG)
---
---Every target that is destroyed, is reported< by the AI.
---
---![Engage Event](..\Presentations\AI_CAS\Dia8.JPG)
---
---Note that the AI does not know when the Engage Zone is cleared, and therefore will keep circling in the zone. 
---
---![Engage Event](..\Presentations\AI_CAS\Dia9.JPG)
---
---Until it is notified through the event **Accomplish**, which is to be triggered by an observing party:
---
---  * a FAC
---  * a timed event
---  * a menu option selected by a human
---  * a condition
---  * others ...
---
---![Engage Event](..\Presentations\AI_CAS\Dia10.JPG)
---
---When the AI has accomplished the CAS, it will fly back to the Patrol Zone.
---
---![Engage Event](..\Presentations\AI_CAS\Dia11.JPG)
---
---It will keep patrolling there, until it is notified to RTB or move to another CAS Zone.
---It can be notified to go RTB through the **RTB** event.
---
---When the fuel threshold has been reached, the airplane will fly towards the nearest friendly airbase and will land.
---
---![Engage Event](..\Presentations\AI_CAS\Dia12.JPG)
---
---## AI_CAS_ZONE constructor
---
---  * #AI_CAS_ZONE.New(): Creates a new AI_CAS_ZONE object.
---
---## AI_CAS_ZONE is a FSM
---
---![Process](..\Presentations\AI_CAS\Dia2.JPG)
---
---### 2.1. AI_CAS_ZONE States
---
---  * **None** ( Group ): The process is not started yet.
---  * **Patrolling** ( Group ): The AI is patrolling the Patrol Zone.
---  * **Engaging** ( Group ): The AI is engaging the targets in the Engage Zone, executing CAS.
---  * **Returning** ( Group ): The AI is returning to Base..
---
---### 2.2. AI_CAS_ZONE Events
---
---  * **AI.AI_Patrol#AI_PATROL_ZONE.Start**: Start the process.
---  * **AI.AI_Patrol#AI_PATROL_ZONE.Route**: Route the AI to a new random 3D point within the Patrol Zone.
---  * **#AI_CAS_ZONE.Engage**: Engage the AI to provide CAS in the Engage Zone, destroying any target it finds.
---  * **#AI_CAS_ZONE.Abort**: Aborts the engagement and return patrolling in the patrol zone.
---  * **AI.AI_Patrol#AI_PATROL_ZONE.RTB**: Route the AI to the home base.
---  * **AI.AI_Patrol#AI_PATROL_ZONE.Detect**: The AI is detecting targets.
---  * **AI.AI_Patrol#AI_PATROL_ZONE.Detected**: The AI has detected new targets.
---  * **#AI_CAS_ZONE.Destroy**: The AI has destroyed a target Wrapper.Unit.
---  * **#AI_CAS_ZONE.Destroyed**: The AI has destroyed all target Wrapper.Units assigned in the CAS task.
---  * **Status**: The AI is checking status (fuel and damage). When the thresholds have been reached, the AI will RTB.
---
---# Developer Note
---
---Note while this class still works, it is no longer supported as the original author stopped active development of MOOSE
---Therefore, this class is considered to be deprecated
---
---===
---AI_CAS_ZONE class
---@deprecated
---@class AI_CAS_ZONE : AI_PATROL_ZONE
---@field AIControllable CONTROLLABLE The @{Wrapper.Controllable} patrolling.
---@field Accomplished boolean 
---@field EngageZone NOTYPE 
---@field TargetZone ZONE_BASE The @{Core.Zone} where the patrol needs to be executed.
AI_CAS_ZONE = {}

---Synchronous Event Trigger for Event Abort.
---
------
function AI_CAS_ZONE:Abort() end

---Synchronous Event Trigger for Event Accomplish.
---
------
function AI_CAS_ZONE:Accomplish() end

---Synchronous Event Trigger for Event Destroy.
---
------
function AI_CAS_ZONE:Destroy() end

---Synchronous Event Trigger for Event Engage.
---
------
---@param EngageSpeed? number (optional) The speed the Group will hold when engaging to the target zone.
---@param EngageAltitude? Distance (optional) Desired altitude to perform the unit engagement.
---@param EngageWeaponExpend? AI.Task.WeaponExpend (optional) Determines how much weapon will be released at each attack.  If parameter is not defined the unit / controllable will choose expend on its own discretion. Use the structure @{DCS#AI.Task.WeaponExpend} to define the amount of weapons to be release at each attack.
---@param EngageAttackQty? number (optional) This parameter limits maximal quantity of attack. The aicraft/controllable will not make more attack than allowed even if the target controllable not destroyed and the aicraft/controllable still have ammo. If not defined the aircraft/controllable will attack target until it will be destroyed or until the aircraft/controllable will run out of ammo.
---@param EngageDirection? Azimuth (optional) Desired ingress direction from the target to the attacking aircraft. Controllable/aircraft will make its attacks from the direction. Of course if there is no way to attack from the direction due the terrain controllable/aircraft will choose another direction.
function AI_CAS_ZONE:Engage(EngageSpeed, EngageAltitude, EngageWeaponExpend, EngageAttackQty, EngageDirection) end


---
------
---@param Fsm NOTYPE 
function AI_CAS_ZONE.EngageRoute(EngageGroup, Fsm) end

---Synchronous Event Trigger for Event Fired.
---
------
function AI_CAS_ZONE:Fired() end

---Creates a new AI_CAS_ZONE object
---
------
---@param PatrolZone ZONE_BASE The @{Core.Zone} where the patrol needs to be executed.
---@param PatrolFloorAltitude Altitude The lowest altitude in meters where to execute the patrol.
---@param PatrolCeilingAltitude Altitude The highest altitude in meters where to execute the patrol.
---@param PatrolMinSpeed Speed The minimum speed of the @{Wrapper.Controllable} in km/h.
---@param PatrolMaxSpeed Speed The maximum speed of the @{Wrapper.Controllable} in km/h.
---@param EngageZone ZONE_BASE The zone where the engage will happen.
---@param PatrolAltType AltitudeType The altitude type ("RADIO"=="AGL", "BARO"=="ASL"). Defaults to RADIO
---@return AI_CAS_ZONE #self
function AI_CAS_ZONE:New(PatrolZone, PatrolFloorAltitude, PatrolCeilingAltitude, PatrolMinSpeed, PatrolMaxSpeed, EngageZone, PatrolAltType) end

---OnAfter Transition Handler for Event Abort.
---
------
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function AI_CAS_ZONE:OnAfterAbort(Controllable, From, Event, To) end

---OnAfter Transition Handler for Event Accomplish.
---
------
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function AI_CAS_ZONE:OnAfterAccomplish(Controllable, From, Event, To) end

---OnAfter Transition Handler for Event Destroy.
---
------
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function AI_CAS_ZONE:OnAfterDestroy(Controllable, From, Event, To) end

---OnAfter Transition Handler for Event Engage.
---
------
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function AI_CAS_ZONE:OnAfterEngage(Controllable, From, Event, To) end

---OnAfter Transition Handler for Event Fired.
---
------
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function AI_CAS_ZONE:OnAfterFired(Controllable, From, Event, To) end

---OnBefore Transition Handler for Event Abort.
---
------
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function AI_CAS_ZONE:OnBeforeAbort(Controllable, From, Event, To) end

---OnBefore Transition Handler for Event Accomplish.
---
------
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function AI_CAS_ZONE:OnBeforeAccomplish(Controllable, From, Event, To) end

---OnBefore Transition Handler for Event Destroy.
---
------
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function AI_CAS_ZONE:OnBeforeDestroy(Controllable, From, Event, To) end

---OnBefore Transition Handler for Event Engage.
---
------
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function AI_CAS_ZONE:OnBeforeEngage(Controllable, From, Event, To) end

---OnBefore Transition Handler for Event Fired.
---
------
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function AI_CAS_ZONE:OnBeforeFired(Controllable, From, Event, To) end

---OnEnter Transition Handler for State Engaging.
---
------
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function AI_CAS_ZONE:OnEnterEngaging(Controllable, From, Event, To) end


---
------
---@param EventData NOTYPE 
function AI_CAS_ZONE:OnEventDead(EventData) end

---OnLeave Transition Handler for State Engaging.
---
------
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function AI_CAS_ZONE:OnLeaveEngaging(Controllable, From, Event, To) end

---Set the Engage Zone where the AI is performing CAS.
---Note that if the EngageZone is changed, the AI needs to re-detect targets.
---
------
---@param EngageZone ZONE The zone where the AI is performing CAS.
---@return AI_CAS_ZONE #self
function AI_CAS_ZONE:SetEngageZone(EngageZone) end

---Asynchronous Event Trigger for Event Abort.
---
------
---@param Delay number The delay in seconds.
function AI_CAS_ZONE:__Abort(Delay) end

---Asynchronous Event Trigger for Event Accomplish.
---
------
---@param Delay number The delay in seconds.  
function AI_CAS_ZONE:__Accomplish(Delay) end

---Asynchronous Event Trigger for Event Destroy.
---
------
---@param Delay number The delay in seconds.
function AI_CAS_ZONE:__Destroy(Delay) end

---Asynchronous Event Trigger for Event Engage.
---
------
---@param Delay number The delay in seconds.
---@param EngageSpeed? number (optional) The speed the Group will hold when engaging to the target zone.
---@param EngageAltitude? Distance (optional) Desired altitude to perform the unit engagement.
---@param EngageWeaponExpend? AI.Task.WeaponExpend (optional) Determines how much weapon will be released at each attack.  If parameter is not defined the unit / controllable will choose expend on its own discretion. Use the structure @{DCS#AI.Task.WeaponExpend} to define the amount of weapons to be release at each attack.
---@param EngageAttackQty? number (optional) This parameter limits maximal quantity of attack. The aicraft/controllable will not make more attack than allowed even if the target controllable not destroyed and the aicraft/controllable still have ammo. If not defined the aircraft/controllable will attack target until it will be destroyed or until the aircraft/controllable will run out of ammo.
---@param EngageDirection? Azimuth (optional) Desired ingress direction from the target to the attacking aircraft. Controllable/aircraft will make its attacks from the direction. Of course if there is no way to attack from the direction due the terrain controllable/aircraft will choose another direction.
function AI_CAS_ZONE:__Engage(Delay, EngageSpeed, EngageAltitude, EngageWeaponExpend, EngageAttackQty, EngageDirection) end

---Asynchronous Event Trigger for Event Fired.
---
------
---@param Delay number The delay in seconds.
function AI_CAS_ZONE:__Fired(Delay) end


---
------
---@param Controllable NOTYPE 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@private
function AI_CAS_ZONE:onafterAbort(Controllable, From, Event, To) end


---
------
---@param Controllable NOTYPE 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@private
function AI_CAS_ZONE:onafterAccomplish(Controllable, From, Event, To) end


---
------
---@param Controllable NOTYPE 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@param EventData NOTYPE 
---@private
function AI_CAS_ZONE:onafterDestroy(Controllable, From, Event, To, EventData) end


---
------
---@param Controllable NOTYPE 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@param EngageSpeed NOTYPE 
---@param EngageAltitude NOTYPE 
---@param EngageWeaponExpend NOTYPE 
---@param EngageAttackQty NOTYPE 
---@param EngageDirection NOTYPE 
---@private
function AI_CAS_ZONE:onafterEngage(Controllable, From, Event, To, EngageSpeed, EngageAltitude, EngageWeaponExpend, EngageAttackQty, EngageDirection) end

---onafter State Transition for Event Start.
---
------
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@private
function AI_CAS_ZONE:onafterStart(Controllable, From, Event, To) end


---
------
---@param Controllable NOTYPE 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@private
function AI_CAS_ZONE:onafterTarget(Controllable, From, Event, To) end


---
------
---@param Controllable NOTYPE 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@private
function AI_CAS_ZONE:onbeforeEngage(Controllable, From, Event, To) end



