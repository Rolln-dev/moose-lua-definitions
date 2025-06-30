---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/AI_Ground_Control_Intercept.JPG" width="100%">
---
---**AI** - Models the process of Ground Controlled Interception (GCI) for airplanes.
---
---This is a class used in the AI.AI_A2A_Dispatcher.
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
---The AI_A2A_GCI is assigned a Wrapper.Group and this must be done before the AI_A2A_GCI process can be started using the **Start** event.
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
---## 1. AI_A2A_GCI constructor
---
---  * #AI_A2A_GCI.New(): Creates a new AI_A2A_GCI object.
---
---## 2. AI_A2A_GCI is a FSM
---
---![Process](..\Presentations\AI_GCI\Dia2.JPG)
---
---### 2.1 AI_A2A_GCI States
---
---  * **None** ( Group ): The process is not started yet.
---  * **Patrolling** ( Group ): The AI is patrolling the Patrol Zone.
---  * **Engaging** ( Group ): The AI is engaging the bogeys.
---  * **Returning** ( Group ): The AI is returning to Base..
---
---### 2.2 AI_A2A_GCI Events
---
---  * **AI.AI_Patrol#AI_PATROL_ZONE.Start**: Start the process.
---  * **AI.AI_Patrol#AI_PATROL_ZONE.Route**: Route the AI to a new random 3D point within the Patrol Zone.
---  * **#AI_A2A_GCI.Engage**: Let the AI engage the bogeys.
---  * **#AI_A2A_GCI.Abort**: Aborts the engagement and return patrolling in the patrol zone.
---  * **AI.AI_Patrol#AI_PATROL_ZONE.RTB**: Route the AI to the home base.
---  * **AI.AI_Patrol#AI_PATROL_ZONE.Detect**: The AI is detecting targets.
---  * **AI.AI_Patrol#AI_PATROL_ZONE.Detected**: The AI has detected new targets.
---  * **#AI_A2A_GCI.Destroy**: The AI has destroyed a bogey Wrapper.Unit.
---  * **#AI_A2A_GCI.Destroyed**: The AI has destroyed all bogeys Wrapper.Units assigned in the CAS task.
---  * **Status** ( Group ): The AI is checking status (fuel and damage). When the thresholds have been reached, the AI will RTB.
---
---# Developer Note
---
---Note while this class still works, it is no longer supported as the original author stopped active development of MOOSE
---Therefore, this class is considered to be deprecated
---
---===
---@deprecated
---@class AI_A2A_GCI 
AI_A2A_GCI = {}

---Evaluate the attack and create an AttackUnitTask list.
---
------
---@param self AI_A2A_GCI 
---@param AttackSetUnit SET_UNIT The set of units to attack.
---@param DefenderGroup GROUP The group of defenders.
---@param EngageAltitude number The altitude to engage the targets.
---@return AI_A2A_GCI #self
function AI_A2A_GCI:CreateAttackUnitTasks(AttackSetUnit, DefenderGroup, EngageAltitude) end

---Creates a new AI_A2A_GCI object
---
------
---@param self AI_A2A_GCI 
---@param AIIntercept GROUP 
---@param EngageMinSpeed Speed The minimum speed of the @{Wrapper.Group} in km/h when engaging a target.
---@param EngageMaxSpeed Speed The maximum speed of the @{Wrapper.Group} in km/h when engaging a target.
---@param EngageFloorAltitude Altitude The lowest altitude in meters where to execute the engagement.
---@param EngageCeilingAltitude Altitude The highest altitude in meters where to execute the engagement.
---@param EngageAltType AltitudeType The altitude type ("RADIO"=="AGL", "BARO"=="ASL"). Defaults to "RADIO".
---@return AI_A2A_GCI #
function AI_A2A_GCI:New(AIIntercept, EngageMinSpeed, EngageMaxSpeed, EngageFloorAltitude, EngageCeilingAltitude, EngageAltType) end

---Creates a new AI_A2A_GCI object
---
------
---@param self AI_A2A_GCI 
---@param AIIntercept GROUP 
---@param EngageMinSpeed Speed The minimum speed of the @{Wrapper.Group} in km/h when engaging a target.
---@param EngageMaxSpeed Speed The maximum speed of the @{Wrapper.Group} in km/h when engaging a target.
---@param EngageFloorAltitude Altitude The lowest altitude in meters where to execute the engagement.
---@param EngageCeilingAltitude Altitude The highest altitude in meters where to execute the engagement.
---@param EngageAltType AltitudeType The altitude type ("RADIO"=="AGL", "BARO"=="ASL"). Defaults to "RADIO".
---@return AI_A2A_GCI #
function AI_A2A_GCI:New2(AIIntercept, EngageMinSpeed, EngageMaxSpeed, EngageFloorAltitude, EngageCeilingAltitude, EngageAltType) end

---onafter State Transition for Event Patrol.
---
------
---@param self AI_A2A_GCI 
---@param AIIntercept GROUP The AI Group managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function AI_A2A_GCI:onafterStart(AIIntercept, From, Event, To) end



