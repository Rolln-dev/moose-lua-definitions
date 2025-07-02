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
---# Developer Note
---
---![Banner Image](..\Images\deprecated.png)
---
---Note while this class still works, it is no longer supported as the original author stopped active development of MOOSE
---Therefore, this class is considered to be deprecated
---
---===
---@deprecated
---@class AI_A2G_CAS 
AI_A2G_CAS = {}

---Evaluate the attack and create an AttackUnitTask list.
---
------
---@param AttackSetUnit SET_UNIT The set of units to attack.
---@param DefenderGroup GROUP The group of defenders.
---@param EngageAltitude number The altitude to engage the targets.
---@return AI_A2G_CAS #self
function AI_A2G_CAS:CreateAttackUnitTasks(AttackSetUnit, DefenderGroup, EngageAltitude) end

---Creates a new AI_A2G_CAS object
---
------
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
---@return AI_A2G_CAS #
function AI_A2G_CAS:New(AIGroup, EngageMinSpeed, EngageMaxSpeed, EngageFloorAltitude, EngageCeilingAltitude, PatrolZone, PatrolFloorAltitude, PatrolCeilingAltitude, PatrolMinSpeed, PatrolMaxSpeed, PatrolAltType) end

---Creates a new AI_A2G_CAS object
---
------
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
---@return AI_A2G_CAS #
function AI_A2G_CAS:New2(AIGroup, EngageMinSpeed, EngageMaxSpeed, EngageFloorAltitude, EngageCeilingAltitude, EngageAltType, PatrolZone, PatrolFloorAltitude, PatrolCeilingAltitude, PatrolMinSpeed, PatrolMaxSpeed, PatrolAltType) end



