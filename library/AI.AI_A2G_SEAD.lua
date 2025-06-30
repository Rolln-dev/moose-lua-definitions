---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/AI_Air_To_Ground_Engage.JPG" width="100%">
---
---**AI** - Models the process of air to ground SEAD engagement for airplanes and helicopters.
---
---This is a class used in the AI.AI_A2G_Dispatcher.
---
---===
---
---### Author: **FlightControl**
---
---===
---Implements the core functions to SEAD intruders.
---Use the Engage trigger to intercept intruders.
---
---![Banner Image](..\Images\deprecated.png)
---
---The AI_A2G_SEAD is assigned a Wrapper.Group and this must be done before the AI_A2G_SEAD process can be started using the **Start** event.
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
---## 1. AI_A2G_SEAD constructor
---  
---  * #AI_A2G_SEAD.New(): Creates a new AI_A2G_SEAD object.
---
---## 3. Set the Range of Engagement
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
---@class AI_A2G_SEAD 
AI_A2G_SEAD = {}

---Evaluate the attack and create an AttackUnitTask list.
---
------
---@param self AI_A2G_SEAD 
---@param AttackSetUnit SET_UNIT The set of units to attack.
---@param DefenderGroup GROUP The group of defenders.
---@param EngageAltitude number The altitude to engage the targets.
---@return AI_A2G_SEAD #self
function AI_A2G_SEAD:CreateAttackUnitTasks(AttackSetUnit, DefenderGroup, EngageAltitude) end

---Creates a new AI_A2G_SEAD object
---
------
---@param self AI_A2G_SEAD 
---@param AIGroup GROUP 
---@param EngageMinSpeed Speed The minimum speed of the @{Wrapper.Group} in km/h when engaging a target.
---@param EngageMaxSpeed Speed The maximum speed of the @{Wrapper.Group} in km/h when engaging a target.
---@param EngageFloorAltitude Altitude The lowest altitude in meters where to execute the engagement.
---@param EngageCeilingAltitude Altitude The highest altitude in meters where to execute the engagement.
---@param PatrolZone ZONE_BASE The @{Core.Zone} where the patrol needs to be executed.
---@param PatrolFloorAltitude Altitude The lowest altitude in meters where to execute the patrol.
---@param PatrolCeilingAltitude Altitude The highest altitude in meters where to execute the patrol.
---@param PatrolMinSpeed Speed The minimum speed of the @{Wrapper.Group} in km/h.
---@param PatrolMaxSpeed Speed The maximum speed of the @{Wrapper.Group} in km/h.
---@param PatrolAltType AltitudeType The altitude type ("RADIO"=="AGL", "BARO"=="ASL"). Defaults to RADIO
---@return AI_A2G_SEAD #
function AI_A2G_SEAD:New(AIGroup, EngageMinSpeed, EngageMaxSpeed, EngageFloorAltitude, EngageCeilingAltitude, PatrolZone, PatrolFloorAltitude, PatrolCeilingAltitude, PatrolMinSpeed, PatrolMaxSpeed, PatrolAltType) end

---Creates a new AI_A2G_SEAD object
---
------
---@param self AI_A2G_SEAD 
---@param AIGroup GROUP 
---@param EngageMinSpeed Speed The minimum speed of the @{Wrapper.Group} in km/h when engaging a target.
---@param EngageMaxSpeed Speed The maximum speed of the @{Wrapper.Group} in km/h when engaging a target.
---@param EngageFloorAltitude Altitude The lowest altitude in meters where to execute the engagement.
---@param EngageCeilingAltitude Altitude The highest altitude in meters where to execute the engagement.
---@param EngageAltType AltitudeType The altitude type ("RADIO"=="AGL", "BARO"=="ASL"). Defaults to "RADIO".
---@param PatrolZone ZONE_BASE The @{Core.Zone} where the patrol needs to be executed.
---@param PatrolFloorAltitude Altitude The lowest altitude in meters where to execute the patrol.
---@param PatrolCeilingAltitude Altitude The highest altitude in meters where to execute the patrol.
---@param PatrolMinSpeed Speed The minimum speed of the @{Wrapper.Group} in km/h.
---@param PatrolMaxSpeed Speed The maximum speed of the @{Wrapper.Group} in km/h.
---@param PatrolAltType AltitudeType The altitude type ("RADIO"=="AGL", "BARO"=="ASL"). Defaults to RADIO
---@return AI_A2G_SEAD #
function AI_A2G_SEAD:New2(AIGroup, EngageMinSpeed, EngageMaxSpeed, EngageFloorAltitude, EngageCeilingAltitude, EngageAltType, PatrolZone, PatrolFloorAltitude, PatrolCeilingAltitude, PatrolMinSpeed, PatrolMaxSpeed, PatrolAltType) end



