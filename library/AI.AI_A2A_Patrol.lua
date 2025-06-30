---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/AI_Air_Patrolling.JPG" width="100%">
---
---**AI** - Models the process of air patrol of airplanes.
---
---===
---
---### Author: **FlightControl**
---
---===
---Implements the core functions to patrol a Core.Zone by an AI Wrapper.Group or Wrapper.Group.
---
---![Banner Image](..\Images\deprecated.png)
---
---![Process](..\Presentations\AI_PATROL\Dia3.JPG)
---
---The AI_A2A_PATROL is assigned a Wrapper.Group and this must be done before the AI_A2A_PATROL process can be started using the **Start** event.
---
---![Process](..\Presentations\AI_PATROL\Dia4.JPG)
---
---The AI will fly towards the random 3D point within the patrol zone, using a random speed within the given altitude and speed limits.
---Upon arrival at the 3D point, a new random 3D point will be selected within the patrol zone using the given limits.
---
---![Process](..\Presentations\AI_PATROL\Dia5.JPG)
---
---This cycle will continue.
---
---![Process](..\Presentations\AI_PATROL\Dia6.JPG)
---
---During the patrol, the AI will detect enemy targets, which are reported through the **Detected** event.
---
---![Process](..\Presentations\AI_PATROL\Dia9.JPG)
---
----- Note that the enemy is not engaged! To model enemy engagement, either tailor the **Detected** event, or
---use derived AI_ classes to model AI offensive or defensive behaviour.
---
---![Process](..\Presentations\AI_PATROL\Dia10.JPG)
---
---Until a fuel or damage threshold has been reached by the AI, or when the AI is commanded to RTB.
---When the fuel threshold has been reached, the airplane will fly towards the nearest friendly airbase and will land.
---
---![Process](..\Presentations\AI_PATROL\Dia11.JPG)
---
---## 1. AI_A2A_PATROL constructor
---  
---  * #AI_A2A_PATROL.New(): Creates a new AI_A2A_PATROL object.
---
---## 2. AI_A2A_PATROL is a FSM
---
---![Process](..\Presentations\AI_PATROL\Dia2.JPG)
---
---### 2.1. AI_A2A_PATROL States
---
---  * **None** ( Group ): The process is not started yet.
---  * **Patrolling** ( Group ): The AI is patrolling the Patrol Zone.
---  * **Returning** ( Group ): The AI is returning to Base.
---  * **Stopped** ( Group ): The process is stopped.
---  * **Crashed** ( Group ): The AI has crashed or is dead.
---
---### 2.2. AI_A2A_PATROL Events
---
---  * **Start** ( Group ): Start the process.
---  * **Stop** ( Group ): Stop the process.
---  * **Route** ( Group ): Route the AI to a new random 3D point within the Patrol Zone.
---  * **RTB** ( Group ): Route the AI to the home base.
---  * **Detect** ( Group ): The AI is detecting targets.
---  * **Detected** ( Group ): The AI has detected new targets.
---  * **Status** ( Group ): The AI is checking status (fuel and damage). When the thresholds have been reached, the AI will RTB.
---   
---## 3. Set or Get the AI controllable
---
---  * #AI_A2A_PATROL.SetControllable(): Set the AIControllable.
---  * #AI_A2A_PATROL.GetControllable(): Get the AIControllable.
---
---## 4. Set the Speed and Altitude boundaries of the AI controllable
---
---  * #AI_A2A_PATROL.SetSpeed(): Set the patrol speed boundaries of the AI, for the next patrol.
---  * #AI_A2A_PATROL.SetAltitude(): Set altitude boundaries of the AI, for the next patrol.
---
---## 5. Manage the detection process of the AI controllable
---
---The detection process of the AI controllable can be manipulated.
---Detection requires an amount of CPU power, which has an impact on your mission performance.
---Only put detection on when absolutely necessary, and the frequency of the detection can also be set.
---
---  * #AI_A2A_PATROL.SetDetectionOn(): Set the detection on. The AI will detect for targets.
---  * #AI_A2A_PATROL.SetDetectionOff(): Set the detection off, the AI will not detect for targets. The existing target list will NOT be erased.
---
---The detection frequency can be set with #AI_A2A_PATROL.SetRefreshTimeInterval( seconds ), where the amount of seconds specify how much seconds will be waited before the next detection.
---Use the method #AI_A2A_PATROL.GetDetectedUnits() to obtain a list of the Wrapper.Units detected by the AI.
---
---The detection can be filtered to potential targets in a specific zone.
---Use the method #AI_A2A_PATROL.SetDetectionZone() to set the zone where targets need to be detected.
---Note that when the zone is too far away, or the AI is not heading towards the zone, or the AI is too high, no targets may be detected
---according the weather conditions.
---
---## 6. Manage the "out of fuel" in the AI_A2A_PATROL
---
---When the AI is out of fuel, it is required that a new AI is started, before the old AI can return to the home base.
---Therefore, with a parameter and a calculation of the distance to the home base, the fuel threshold is calculated.
---When the fuel threshold is reached, the AI will continue for a given time its patrol task in orbit, 
---while a new AI is targeted to the AI_A2A_PATROL.
---Once the time is finished, the old AI will return to the base.
---Use the method #AI_A2A_PATROL.ManageFuel() to have this proces in place.
---
---## 7. Manage "damage" behaviour of the AI in the AI_A2A_PATROL
---
---When the AI is damaged, it is required that a new Patrol is started. However, damage cannon be foreseen early on. 
---Therefore, when the damage threshold is reached, the AI will return immediately to the home base (RTB).
---Use the method #AI_A2A_PATROL.ManageDamage() to have this proces in place.
---
---# Developer Note
---
---Note while this class still works, it is no longer supported as the original author stopped active development of MOOSE
---Therefore, this class is considered to be deprecated
---
---===
---@deprecated
---@class AI_A2A_PATROL 
---@field PatrolCeilingAltitude  
---@field PatrolFloorAltitude  
---@field PatrolMaxSpeed  
---@field PatrolMinSpeed  
---@field PatrolZone  
AI_A2A_PATROL = {}

---Creates a new AI_A2A_PATROL object
---
------
---
---USAGE
---```
----- Define a new AI_A2A_PATROL Object. This PatrolArea will patrol a Group within PatrolZone between 3000 and 6000 meters, with a variying speed between 600 and 900 km/h.
---PatrolZone = ZONE:New( 'PatrolZone' )
---PatrolSpawn = SPAWN:New( 'Patrol Group' )
---PatrolArea = AI_A2A_PATROL:New( PatrolZone, 3000, 6000, 600, 900 )
---```
------
---@param self AI_A2A_PATROL 
---@param AIPatrol GROUP The patrol group object.
---@param PatrolZone ZONE_BASE The @{Core.Zone} where the patrol needs to be executed.
---@param PatrolFloorAltitude Altitude The lowest altitude in meters where to execute the patrol.
---@param PatrolCeilingAltitude Altitude The highest altitude in meters where to execute the patrol.
---@param PatrolMinSpeed Speed The minimum speed of the @{Wrapper.Group} in km/h.
---@param PatrolMaxSpeed Speed The maximum speed of the @{Wrapper.Group} in km/h.
---@param PatrolAltType AltitudeType The altitude type ("RADIO"=="AGL", "BARO"=="ASL"). Defaults to BARO
---@return AI_A2A_PATROL #self
function AI_A2A_PATROL:New(AIPatrol, PatrolZone, PatrolFloorAltitude, PatrolCeilingAltitude, PatrolMinSpeed, PatrolMaxSpeed, PatrolAltType) end

---OnAfter Transition Handler for Event Patrol.
---
------
---@param self AI_A2A_PATROL 
---@param AIPatrol GROUP The Group Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function AI_A2A_PATROL:OnAfterPatrol(AIPatrol, From, Event, To) end

---OnAfter Transition Handler for Event Route.
---
------
---@param self AI_A2A_PATROL 
---@param AIPatrol GROUP The Group Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function AI_A2A_PATROL:OnAfterRoute(AIPatrol, From, Event, To) end

---OnBefore Transition Handler for Event Patrol.
---
------
---@param self AI_A2A_PATROL 
---@param AIPatrol GROUP The Group Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function AI_A2A_PATROL:OnBeforePatrol(AIPatrol, From, Event, To) end

---OnBefore Transition Handler for Event Route.
---
------
---@param self AI_A2A_PATROL 
---@param AIPatrol GROUP The Group Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function AI_A2A_PATROL:OnBeforeRoute(AIPatrol, From, Event, To) end

---OnEnter Transition Handler for State Patrolling.
---
------
---@param self AI_A2A_PATROL 
---@param AIPatrol GROUP The Group Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function AI_A2A_PATROL:OnEnterPatrolling(AIPatrol, From, Event, To) end

---OnLeave Transition Handler for State Patrolling.
---
------
---@param self AI_A2A_PATROL 
---@param AIPatrol GROUP The Group Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function AI_A2A_PATROL:OnLeavePatrolling(AIPatrol, From, Event, To) end

---Synchronous Event Trigger for Event Patrol.
---
------
---@param self AI_A2A_PATROL 
function AI_A2A_PATROL:Patrol() end

---This static method is called from the route path within the last task at the last waypoint of the AIPatrol.
---Note that this method is required, as triggers the next route when patrolling for the AIPatrol.
---
------
---@param AIPatrol GROUP The AI group.
---@param Fsm AI_A2A_PATROL The FSM.
function AI_A2A_PATROL.PatrolRoute(AIPatrol, Fsm) end

---Synchronous Event Trigger for Event Route.
---
------
---@param self AI_A2A_PATROL 
function AI_A2A_PATROL:Route() end

---Sets the floor and ceiling altitude of the patrol.
---
------
---@param self AI_A2A_PATROL 
---@param PatrolFloorAltitude Altitude The lowest altitude in meters where to execute the patrol.
---@param PatrolCeilingAltitude Altitude The highest altitude in meters where to execute the patrol.
---@return AI_A2A_PATROL #self
function AI_A2A_PATROL:SetAltitude(PatrolFloorAltitude, PatrolCeilingAltitude) end

---Sets (modifies) the minimum and maximum speed of the patrol.
---
------
---@param self AI_A2A_PATROL 
---@param PatrolMinSpeed Speed The minimum speed of the @{Wrapper.Group} in km/h.
---@param PatrolMaxSpeed Speed The maximum speed of the @{Wrapper.Group} in km/h.
---@return AI_A2A_PATROL #self
function AI_A2A_PATROL:SetSpeed(PatrolMinSpeed, PatrolMaxSpeed) end

---Asynchronous Event Trigger for Event Patrol.
---
------
---@param self AI_A2A_PATROL 
---@param Delay number The delay in seconds.
function AI_A2A_PATROL:__Patrol(Delay) end

---Asynchronous Event Trigger for Event Route.
---
------
---@param self AI_A2A_PATROL 
---@param Delay number The delay in seconds.
function AI_A2A_PATROL:__Route(Delay) end

---Defines a new patrol route using the AI.AI_Patrol#AI_PATROL_ZONE parameters and settings.
---
------
---@param self AI_A2A_PATROL 
---@param AIPatrol GROUP The Group Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return AI_A2A_PATROL #self
function AI_A2A_PATROL:onafterPatrol(AIPatrol, From, Event, To) end

---Defines a new patrol route using the AI.AI_Patrol#AI_PATROL_ZONE parameters and settings.
---
------
---@param self AI_A2A_PATROL 
---@param AIPatrol GROUP The Group managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function AI_A2A_PATROL:onafterRoute(AIPatrol, From, Event, To) end



