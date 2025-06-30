---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/AI_Air_To_Ground_Patrol.JPG" width="100%">
---
---**AI** - Models the process of A2G patrolling and engaging ground targets for airplanes and helicopters.
---
---===
---
---### Author: **FlightControl**
---
---===
---The AI_AIR_PATROL class implements the core functions to patrol a Core.Zone by an AI Wrapper.Group
---and automatically engage any airborne enemies that are within a certain range or within a certain zone.
---
---![Banner Image](..\Images\deprecated.png)
---
---![Process](..\Presentations\AI_CAP\Dia3.JPG)
---
---The AI_AIR_PATROL is assigned a Wrapper.Group and this must be done before the AI_AIR_PATROL process can be started using the **Start** event.
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
---## 1. AI_AIR_PATROL constructor
---  
---  * #AI_AIR_PATROL.New(): Creates a new AI_AIR_PATROL object.
---
---## 2. AI_AIR_PATROL is a FSM
---
---![Process](..\Presentations\AI_CAP\Dia2.JPG)
---
---### 2.1 AI_AIR_PATROL States
---
---  * **None** ( Group ): The process is not started yet.
---  * **Patrolling** ( Group ): The AI is patrolling the Patrol Zone.
---  * **Engaging** ( Group ): The AI is engaging the bogeys.
---  * **Returning** ( Group ): The AI is returning to Base..
---
---### 2.2 AI_AIR_PATROL Events
---
---  * **AI.AI_Patrol#AI_PATROL_ZONE.Start**: Start the process.
---  * **AI.AI_Patrol#AI_PATROL_ZONE.PatrolRoute**: Route the AI to a new random 3D point within the Patrol Zone.
---  * **#AI_AIR_PATROL.Engage**: Let the AI engage the bogeys.
---  * **#AI_AIR_PATROL.Abort**: Aborts the engagement and return patrolling in the patrol zone.
---  * **AI.AI_Patrol#AI_PATROL_ZONE.RTB**: Route the AI to the home base.
---  * **AI.AI_Patrol#AI_PATROL_ZONE.Detect**: The AI is detecting targets.
---  * **AI.AI_Patrol#AI_PATROL_ZONE.Detected**: The AI has detected new targets.
---  * **#AI_AIR_PATROL.Destroy**: The AI has destroyed a bogey Wrapper.Unit.
---  * **#AI_AIR_PATROL.Destroyed**: The AI has destroyed all bogeys Wrapper.Units assigned in the CAS task.
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
---Use the method #AI_AIR_PATROL.SetEngageRange() to define that range.
---
---# Developer Note
---
---Note while this class still works, it is no longer supported as the original author stopped active development of MOOSE
---Therefore, this class is considered to be deprecated
---
---===
---@deprecated
---@class AI_AIR_PATROL 
---@field EngageRange  
---@field PatrolZone  
---@field racetrack boolean 
---@field racetrackcapcoordinates  
---@field racetrackdurationmax  
---@field racetrackdurationmin  
AI_AIR_PATROL = {}

---Creates a new AI_AIR_PATROL object
---
------
---@param self AI_AIR_PATROL 
---@param AI_Air AI_AIR The AI_AIR FSM.
---@param AIGroup GROUP The AI group.
---@param PatrolZone ZONE_BASE The @{Core.Zone} where the patrol needs to be executed.
---@param PatrolFloorAltitude Altitude (optional, default = 1000m ) The lowest altitude in meters where to execute the patrol.
---@param PatrolCeilingAltitude Altitude (optional, default = 1500m ) The highest altitude in meters where to execute the patrol.
---@param PatrolMinSpeed Speed (optional, default = 50% of max speed) The minimum speed of the @{Wrapper.Group} in km/h.
---@param PatrolMaxSpeed Speed (optional, default = 75% of max speed) The maximum speed of the @{Wrapper.Group} in km/h.
---@param PatrolAltType AltitudeType The altitude type ("RADIO"=="AGL", "BARO"=="ASL"). Defaults to RADIO.
---@return AI_AIR_PATROL #
function AI_AIR_PATROL:New(AI_Air, AIGroup, PatrolZone, PatrolFloorAltitude, PatrolCeilingAltitude, PatrolMinSpeed, PatrolMaxSpeed, PatrolAltType) end

---OnAfter Transition Handler for Event Patrol.
---
------
---@param self AI_AIR_PATROL 
---@param AIPatrol GROUP The Group Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function AI_AIR_PATROL:OnAfterPatrol(AIPatrol, From, Event, To) end

---OnAfter Transition Handler for Event PatrolRoute.
---
------
---@param self AI_AIR_PATROL 
---@param AIPatrol GROUP The Group Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function AI_AIR_PATROL:OnAfterPatrolRoute(AIPatrol, From, Event, To) end

---OnBefore Transition Handler for Event Patrol.
---
------
---@param self AI_AIR_PATROL 
---@param AIPatrol GROUP The Group Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function AI_AIR_PATROL:OnBeforePatrol(AIPatrol, From, Event, To) end

---OnBefore Transition Handler for Event PatrolRoute.
---
------
---@param self AI_AIR_PATROL 
---@param AIPatrol GROUP The Group Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function AI_AIR_PATROL:OnBeforePatrolRoute(AIPatrol, From, Event, To) end

---OnEnter Transition Handler for State Patrolling.
---
------
---@param self AI_AIR_PATROL 
---@param AIPatrol GROUP The Group Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function AI_AIR_PATROL:OnEnterPatrolling(AIPatrol, From, Event, To) end

---OnLeave Transition Handler for State Patrolling.
---
------
---@param self AI_AIR_PATROL 
---@param AIPatrol GROUP The Group Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function AI_AIR_PATROL:OnLeavePatrolling(AIPatrol, From, Event, To) end

---Synchronous Event Trigger for Event Patrol.
---
------
---@param self AI_AIR_PATROL 
function AI_AIR_PATROL:Patrol() end

---Synchronous Event Trigger for Event PatrolRoute.
---
------
---@param self AI_AIR_PATROL 
function AI_AIR_PATROL:PatrolRoute() end

---Resumes the AIPatrol
---
------
---@param AIPatrol GROUP 
---@param Fsm FSM 
function AI_AIR_PATROL.Resume(AIPatrol, Fsm) end

---Set the Engage Range when the AI will engage with airborne enemies.
---
------
---@param self AI_AIR_PATROL 
---@param EngageRange number The Engage Range.
---@return AI_AIR_PATROL #self
function AI_AIR_PATROL:SetEngageRange(EngageRange) end

---Set race track parameters.
---CAP flights will perform race track patterns rather than randomly patrolling the zone.
---
------
---@param self AI_AIR_PATROL 
---@param LegMin number Min Length of the race track leg in meters. Default 10,000 m.
---@param LegMax number Max length of the race track leg in meters. Default 15,000 m.
---@param HeadingMin number Min heading of the race track in degrees. Default 0 deg, i.e. from South to North.
---@param HeadingMax number Max heading of the race track in degrees. Default 180 deg, i.e. from South to North.
---@param DurationMin number (Optional) Min duration before switching the orbit position. Default is keep same orbit until RTB or engage.
---@param DurationMax number (Optional) Max duration before switching the orbit position. Default is keep same orbit until RTB or engage.
---@param CapCoordinates table Table of coordinates of first race track point. Second point is determined by leg length and heading. 
---@return AI_AIR_PATROL #self
function AI_AIR_PATROL:SetRaceTrackPattern(LegMin, LegMax, HeadingMin, HeadingMax, DurationMin, DurationMax, CapCoordinates) end

---Asynchronous Event Trigger for Event Patrol.
---
------
---@param self AI_AIR_PATROL 
---@param Delay number The delay in seconds.
function AI_AIR_PATROL:__Patrol(Delay) end

---Asynchronous Event Trigger for Event PatrolRoute.
---
------
---@param self AI_AIR_PATROL 
---@param Delay number The delay in seconds.
function AI_AIR_PATROL:__PatrolRoute(Delay) end

---This static method is called from the route path within the last task at the last waypoint of the AIPatrol.
---Note that this method is required, as triggers the next route when patrolling for the AIPatrol.
---
------
---@param AIPatrol GROUP The AI group.
---@param Fsm AI_AIR_PATROL The FSM.
function AI_AIR_PATROL.___PatrolRoute(AIPatrol, Fsm) end

---Defines a new patrol route using the AI.AI_Patrol#AI_PATROL_ZONE parameters and settings.
---
------
---@param self AI_AIR_PATROL 
---@param AIPatrol GROUP The Group Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return AI_AIR_PATROL #self
function AI_AIR_PATROL:onafterPatrol(AIPatrol, From, Event, To) end

---Defines a new patrol route using the AI.AI_Patrol#AI_PATROL_ZONE parameters and settings.
---
------
---@param self AI_AIR_PATROL 
---@param AIPatrol GROUP The Group managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function AI_AIR_PATROL:onafterPatrolRoute(AIPatrol, From, Event, To) end



