---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/AI_Air_Patrolling.JPG" width="100%">
---
---**AI** - Perform Air Patrolling for airplanes.
---
---**Features:**
---
---  * Patrol AI airplanes within a given zone.
---  * Trigger detected events when enemy airplanes are detected.
---  * Manage a fuel threshold to RTB on time.
---
---===
---
---AI PATROL classes makes AI Controllables execute an Patrol.
---
---There are the following types of PATROL classes defined:
---
---  * #AI_PATROL_ZONE: Perform a PATROL in a zone.
---  
---===
---
---### [Demo Missions](https://github.com/FlightControl-Master/MOOSE_MISSIONS/tree/master/AI/AI_Patrol)
---
---===
---
---### [YouTube Playlist](https://www.youtube.com/playlist?list=PL7ZUrU4zZUl35HvYZKA6G22WMt7iI3zky)
---
---===
---
---### Author: **FlightControl**
---### Contributions: 
---
---  * **Dutch_Baron**: Working together with James has resulted in the creation of the AI_BALANCER class. James has shared his ideas on balancing AI with air units, and together we made a first design which you can use now :-)
---  * **Pikey**: Testing and API concept review.
---
---===
---Implements the core functions to patrol a Core.Zone by an AI Wrapper.Controllable or Wrapper.Group.
---
---![Banner Image](..\Images\deprecated.png)
---
---![Process](..\Presentations\AI_PATROL\Dia3.JPG)
---
---The AI_PATROL_ZONE is assigned a Wrapper.Group and this must be done before the AI_PATROL_ZONE process can be started using the **Start** event.
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
---## 1. AI_PATROL_ZONE constructor
---  
---  * #AI_PATROL_ZONE.New(): Creates a new AI_PATROL_ZONE object.
---
---## 2. AI_PATROL_ZONE is a FSM
---
---![Process](..\Presentations\AI_PATROL\Dia2.JPG)
---
---### 2.1. AI_PATROL_ZONE States
---
---  * **None** ( Group ): The process is not started yet.
---  * **Patrolling** ( Group ): The AI is patrolling the Patrol Zone.
---  * **Returning** ( Group ): The AI is returning to Base.
---  * **Stopped** ( Group ): The process is stopped.
---  * **Crashed** ( Group ): The AI has crashed or is dead.
---
---### 2.2. AI_PATROL_ZONE Events
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
---  * #AI_PATROL_ZONE.SetControllable(): Set the AIControllable.
---  * #AI_PATROL_ZONE.GetControllable(): Get the AIControllable.
---
---## 4. Set the Speed and Altitude boundaries of the AI controllable
---
---  * #AI_PATROL_ZONE.SetSpeed(): Set the patrol speed boundaries of the AI, for the next patrol.
---  * #AI_PATROL_ZONE.SetAltitude(): Set altitude boundaries of the AI, for the next patrol.
---
---## 5. Manage the detection process of the AI controllable
---
---The detection process of the AI controllable can be manipulated.
---Detection requires an amount of CPU power, which has an impact on your mission performance.
---Only put detection on when absolutely necessary, and the frequency of the detection can also be set.
---
---  * #AI_PATROL_ZONE.SetDetectionOn(): Set the detection on. The AI will detect for targets.
---  * #AI_PATROL_ZONE.SetDetectionOff(): Set the detection off, the AI will not detect for targets. The existing target list will NOT be erased.
---
---The detection frequency can be set with #AI_PATROL_ZONE.SetRefreshTimeInterval( seconds ), where the amount of seconds specify how much seconds will be waited before the next detection.
---Use the method #AI_PATROL_ZONE.GetDetectedUnits() to obtain a list of the Wrapper.Units detected by the AI.
---
---The detection can be filtered to potential targets in a specific zone.
---Use the method #AI_PATROL_ZONE.SetDetectionZone() to set the zone where targets need to be detected.
---Note that when the zone is too far away, or the AI is not heading towards the zone, or the AI is too high, no targets may be detected
---according the weather conditions.
---
---## 6. Manage the "out of fuel" in the AI_PATROL_ZONE
---
---When the AI is out of fuel, it is required that a new AI is started, before the old AI can return to the home base.
---Therefore, with a parameter and a calculation of the distance to the home base, the fuel threshold is calculated.
---When the fuel threshold is reached, the AI will continue for a given time its patrol task in orbit, 
---while a new AI is targeted to the AI_PATROL_ZONE.
---Once the time is finished, the old AI will return to the base.
---Use the method #AI_PATROL_ZONE.ManageFuel() to have this process in place.
---
---## 7. Manage "damage" behaviour of the AI in the AI_PATROL_ZONE
---
---When the AI is damaged, it is required that a new AIControllable is started. However, damage cannon be foreseen early on. 
---Therefore, when the damage threshold is reached, the AI will return immediately to the home base (RTB).
---Use the method #AI_PATROL_ZONE.ManageDamage() to have this process in place.
---
---# Developer Note
---
---Note while this class still works, it is no longer supported as the original author stopped active development of MOOSE
---Therefore, this class is considered to be deprecated
---
---===
---AI_PATROL_ZONE class
---@deprecated
---@class AI_PATROL_ZONE : FSM_CONTROLLABLE
---@field AIControllable CONTROLLABLE The @{Wrapper.Controllable} patrolling.
---@field CheckStatus boolean 
---@field CoordTest SPAWN 
---@field DetectActivated boolean 
---@field DetectInterval NOTYPE 
---@field DetectOn boolean 
---@field DetectZone NOTYPE 
---@field DetectedUnits table 
---@field PatrolCeilingAltitude Altitude The highest altitude in meters where to execute the patrol.
---@field PatrolDamageThreshold NOTYPE 
---@field PatrolFloorAltitude Altitude The lowest altitude in meters where to execute the patrol.
---@field PatrolFuelThresholdPercentage NOTYPE 
---@field PatrolManageDamage boolean 
---@field PatrolMaxSpeed Speed The maximum speed of the @{Wrapper.Controllable} in km/h.
---@field PatrolMinSpeed Speed The minimum speed of the @{Wrapper.Controllable} in km/h.
---@field PatrolOutOfFuelOrbitTime NOTYPE 
---@field PatrolZone ZONE_BASE The @{Core.Zone} where the patrol needs to be executed.
AI_PATROL_ZONE = {}

---Clears the list of Wrapper.Unit#UNITs that were detected by the AI.
---
------
---@param self AI_PATROL_ZONE 
function AI_PATROL_ZONE:ClearDetectedUnits() end

---Synchronous Event Trigger for Event Detect.
---
------
---@param self AI_PATROL_ZONE 
function AI_PATROL_ZONE:Detect() end

---Synchronous Event Trigger for Event Detected.
---
------
---@param self AI_PATROL_ZONE 
function AI_PATROL_ZONE:Detected() end

---Gets a list of Wrapper.Unit#UNITs that were detected by the AI.
---No filtering is applied, so, ANY detected UNIT can be in this list.
---It is up to the mission designer to use the Wrapper.Unit class and methods to filter the targets.
---
------
---@param self AI_PATROL_ZONE 
---@return table #The list of @{Wrapper.Unit#UNIT}s
function AI_PATROL_ZONE:GetDetectedUnits() end

---When the AI is damaged beyond a certain threshold, it is required that the AI returns to the home base.
---However, damage cannot be foreseen early on. 
---Therefore, when the damage threshold is reached, 
---the AI will return immediately to the home base (RTB).
---Note that for groups, the average damage of the complete group will be calculated.
---So, in a group of 4 airplanes, 2 lost and 2 with damage 0.2, the damage threshold will be 0.25.
---
------
---@param self AI_PATROL_ZONE 
---@param PatrolDamageThreshold number The threshold in percentage (between 0 and 1) when the AI is considered to be damaged.
---@return AI_PATROL_ZONE #self
function AI_PATROL_ZONE:ManageDamage(PatrolDamageThreshold) end

---When the AI is out of fuel, it is required that a new AI is started, before the old AI can return to the home base.
---Therefore, with a parameter and a calculation of the distance to the home base, the fuel threshold is calculated.
---When the fuel threshold is reached, the AI will continue for a given time its patrol task in orbit, while a new AIControllable is targeted to the AI_PATROL_ZONE.
---Once the time is finished, the old AI will return to the base.
---
------
---@param self AI_PATROL_ZONE 
---@param PatrolFuelThresholdPercentage number The threshold in percentage (between 0 and 1) when the AIControllable is considered to get out of fuel.
---@param PatrolOutOfFuelOrbitTime number The amount of seconds the out of fuel AIControllable will orbit before returning to the base.
---@return AI_PATROL_ZONE #self
function AI_PATROL_ZONE:ManageFuel(PatrolFuelThresholdPercentage, PatrolOutOfFuelOrbitTime) end

---Creates a new AI_PATROL_ZONE object
---
------
---
---USAGE
---```
----- Define a new AI_PATROL_ZONE Object. This PatrolArea will patrol an AIControllable within PatrolZone between 3000 and 6000 meters, with a variying speed between 600 and 900 km/h.
---PatrolZone = ZONE:New( 'PatrolZone' )
---PatrolSpawn = SPAWN:New( 'Patrol Group' )
---PatrolArea = AI_PATROL_ZONE:New( PatrolZone, 3000, 6000, 600, 900 )
---```
------
---@param self AI_PATROL_ZONE 
---@param PatrolZone ZONE_BASE The @{Core.Zone} where the patrol needs to be executed.
---@param PatrolFloorAltitude Altitude The lowest altitude in meters where to execute the patrol.
---@param PatrolCeilingAltitude Altitude The highest altitude in meters where to execute the patrol.
---@param PatrolMinSpeed Speed The minimum speed of the @{Wrapper.Controllable} in km/h.
---@param PatrolMaxSpeed Speed The maximum speed of the @{Wrapper.Controllable} in km/h.
---@param PatrolAltType AltitudeType The altitude type ("RADIO"=="AGL", "BARO"=="ASL"). Defaults to RADIO
---@return AI_PATROL_ZONE #self
function AI_PATROL_ZONE:New(PatrolZone, PatrolFloorAltitude, PatrolCeilingAltitude, PatrolMinSpeed, PatrolMaxSpeed, PatrolAltType) end

---OnAfter Transition Handler for Event Detect.
---
------
---@param self AI_PATROL_ZONE 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function AI_PATROL_ZONE:OnAfterDetect(Controllable, From, Event, To) end

---OnAfter Transition Handler for Event Detected.
---
------
---@param self AI_PATROL_ZONE 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function AI_PATROL_ZONE:OnAfterDetected(Controllable, From, Event, To) end

---OnAfter Transition Handler for Event RTB.
---
------
---@param self AI_PATROL_ZONE 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function AI_PATROL_ZONE:OnAfterRTB(Controllable, From, Event, To) end

---OnAfter Transition Handler for Event Route.
---
------
---@param self AI_PATROL_ZONE 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function AI_PATROL_ZONE:OnAfterRoute(Controllable, From, Event, To) end

---OnAfter Transition Handler for Event Start.
---
------
---@param self AI_PATROL_ZONE 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function AI_PATROL_ZONE:OnAfterStart(Controllable, From, Event, To) end

---OnAfter Transition Handler for Event Status.
---
------
---@param self AI_PATROL_ZONE 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function AI_PATROL_ZONE:OnAfterStatus(Controllable, From, Event, To) end

---OnAfter Transition Handler for Event Stop.
---
------
---@param self AI_PATROL_ZONE 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function AI_PATROL_ZONE:OnAfterStop(Controllable, From, Event, To) end

---OnBefore Transition Handler for Event Detect.
---
------
---@param self AI_PATROL_ZONE 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function AI_PATROL_ZONE:OnBeforeDetect(Controllable, From, Event, To) end

---OnBefore Transition Handler for Event Detected.
---
------
---@param self AI_PATROL_ZONE 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function AI_PATROL_ZONE:OnBeforeDetected(Controllable, From, Event, To) end

---OnBefore Transition Handler for Event RTB.
---
------
---@param self AI_PATROL_ZONE 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function AI_PATROL_ZONE:OnBeforeRTB(Controllable, From, Event, To) end

---OnBefore Transition Handler for Event Route.
---
------
---@param self AI_PATROL_ZONE 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function AI_PATROL_ZONE:OnBeforeRoute(Controllable, From, Event, To) end

---OnBefore Transition Handler for Event Start.
---
------
---@param self AI_PATROL_ZONE 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function AI_PATROL_ZONE:OnBeforeStart(Controllable, From, Event, To) end

---OnBefore Transition Handler for Event Status.
---
------
---@param self AI_PATROL_ZONE 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function AI_PATROL_ZONE:OnBeforeStatus(Controllable, From, Event, To) end

---OnBefore Transition Handler for Event Stop.
---
------
---@param self AI_PATROL_ZONE 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function AI_PATROL_ZONE:OnBeforeStop(Controllable, From, Event, To) end


---
------
---@param self NOTYPE 
---@param EventData NOTYPE 
function AI_PATROL_ZONE:OnCrash(EventData) end


---
------
---@param self NOTYPE 
---@param EventData NOTYPE 
function AI_PATROL_ZONE:OnEjection(EventData) end

---OnEnter Transition Handler for State Patrolling.
---
------
---@param self AI_PATROL_ZONE 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function AI_PATROL_ZONE:OnEnterPatrolling(Controllable, From, Event, To) end

---OnEnter Transition Handler for State Returning.
---
------
---@param self AI_PATROL_ZONE 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function AI_PATROL_ZONE:OnEnterReturning(Controllable, From, Event, To) end

---OnEnter Transition Handler for State Stopped.
---
------
---@param self AI_PATROL_ZONE 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function AI_PATROL_ZONE:OnEnterStopped(Controllable, From, Event, To) end

---OnLeave Transition Handler for State Patrolling.
---
------
---@param self AI_PATROL_ZONE 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function AI_PATROL_ZONE:OnLeavePatrolling(Controllable, From, Event, To) end

---OnLeave Transition Handler for State Returning.
---
------
---@param self AI_PATROL_ZONE 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function AI_PATROL_ZONE:OnLeaveReturning(Controllable, From, Event, To) end

---OnLeave Transition Handler for State Stopped.
---
------
---@param self AI_PATROL_ZONE 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function AI_PATROL_ZONE:OnLeaveStopped(Controllable, From, Event, To) end


---
------
---@param self NOTYPE 
---@param EventData NOTYPE 
function AI_PATROL_ZONE:OnPilotDead(EventData) end

---Synchronous Event Trigger for Event RTB.
---
------
---@param self AI_PATROL_ZONE 
function AI_PATROL_ZONE:RTB() end

---Synchronous Event Trigger for Event Route.
---
------
---@param self AI_PATROL_ZONE 
function AI_PATROL_ZONE:Route() end

---Sets the floor and ceiling altitude of the patrol.
---
------
---@param self AI_PATROL_ZONE 
---@param PatrolFloorAltitude Altitude The lowest altitude in meters where to execute the patrol.
---@param PatrolCeilingAltitude Altitude The highest altitude in meters where to execute the patrol.
---@return AI_PATROL_ZONE #self
function AI_PATROL_ZONE:SetAltitude(PatrolFloorAltitude, PatrolCeilingAltitude) end

---Activate the detection.
---The AI will detect for targets if the Detection is switched On.
---
------
---@param self AI_PATROL_ZONE 
---@return AI_PATROL_ZONE #self
function AI_PATROL_ZONE:SetDetectionActivated() end

---Deactivate the detection.
---The AI will NOT detect for targets.
---
------
---@param self AI_PATROL_ZONE 
---@return AI_PATROL_ZONE #self
function AI_PATROL_ZONE:SetDetectionDeactivated() end

---Set the detection off.
---The AI will NOT detect for targets.
---However, the list of already detected targets will be kept and can be enquired!
---
------
---@param self AI_PATROL_ZONE 
---@return AI_PATROL_ZONE #self
function AI_PATROL_ZONE:SetDetectionOff() end

---Set the detection on.
---The AI will detect for targets.
---
------
---@param self AI_PATROL_ZONE 
---@return AI_PATROL_ZONE #self
function AI_PATROL_ZONE:SetDetectionOn() end

---Set the detection zone where the AI is detecting targets.
---
------
---@param self AI_PATROL_ZONE 
---@param DetectionZone ZONE The zone where to detect targets.
---@return AI_PATROL_ZONE #self
function AI_PATROL_ZONE:SetDetectionZone(DetectionZone) end

---Set the interval in seconds between each detection executed by the AI.
---The list of already detected targets will be kept and updated.
---Newly detected targets will be added, but already detected targets that were 
---not detected in this cycle, will NOT be removed!
---The default interval is 30 seconds.
---
------
---@param self AI_PATROL_ZONE 
---@param Seconds number The interval in seconds.
---@return AI_PATROL_ZONE #self
function AI_PATROL_ZONE:SetRefreshTimeInterval(Seconds) end

---Sets (modifies) the minimum and maximum speed of the patrol.
---
------
---@param self AI_PATROL_ZONE 
---@param PatrolMinSpeed Speed The minimum speed of the @{Wrapper.Controllable} in km/h.
---@param PatrolMaxSpeed Speed The maximum speed of the @{Wrapper.Controllable} in km/h.
---@return AI_PATROL_ZONE #self
function AI_PATROL_ZONE:SetSpeed(PatrolMinSpeed, PatrolMaxSpeed) end

---Set the status checking off.
---
------
---@param self AI_PATROL_ZONE 
---@return AI_PATROL_ZONE #self
function AI_PATROL_ZONE:SetStatusOff() end

---Synchronous Event Trigger for Event Start.
---
------
---@param self AI_PATROL_ZONE 
function AI_PATROL_ZONE:Start() end

---Synchronous Event Trigger for Event Status.
---
------
---@param self AI_PATROL_ZONE 
function AI_PATROL_ZONE:Status() end

---Synchronous Event Trigger for Event Stop.
---
------
---@param self AI_PATROL_ZONE 
function AI_PATROL_ZONE:Stop() end


---
------
---@param self NOTYPE 
---@param AIControllable NOTYPE 
function AI_PATROL_ZONE:_NewPatrolRoute(AIControllable) end

---Asynchronous Event Trigger for Event Detect.
---
------
---@param self AI_PATROL_ZONE 
---@param Delay number The delay in seconds.
function AI_PATROL_ZONE:__Detect(Delay) end

---Asynchronous Event Trigger for Event Detected.
---
------
---@param self AI_PATROL_ZONE 
---@param Delay number The delay in seconds.
function AI_PATROL_ZONE:__Detected(Delay) end

---Asynchronous Event Trigger for Event RTB.
---
------
---@param self AI_PATROL_ZONE 
---@param Delay number The delay in seconds.
function AI_PATROL_ZONE:__RTB(Delay) end

---Asynchronous Event Trigger for Event Route.
---
------
---@param self AI_PATROL_ZONE 
---@param Delay number The delay in seconds.
function AI_PATROL_ZONE:__Route(Delay) end

---Asynchronous Event Trigger for Event Start.
---
------
---@param self AI_PATROL_ZONE 
---@param Delay number The delay in seconds.
function AI_PATROL_ZONE:__Start(Delay) end

---Asynchronous Event Trigger for Event Status.
---
------
---@param self AI_PATROL_ZONE 
---@param Delay number The delay in seconds.
function AI_PATROL_ZONE:__Status(Delay) end

---Asynchronous Event Trigger for Event Stop.
---
------
---@param self AI_PATROL_ZONE 
---@param Delay number The delay in seconds.
function AI_PATROL_ZONE:__Stop(Delay) end


---
------
---@param self NOTYPE 
---@private
function AI_PATROL_ZONE:onafterDead() end


---
------
---@param self NOTYPE 
---@param Controllable NOTYPE 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@private
function AI_PATROL_ZONE:onafterDetect(Controllable, From, Event, To) end


---
------
---@param self NOTYPE 
---@private
function AI_PATROL_ZONE:onafterRTB() end

---Defines a new patrol route using the #AI_PATROL_ZONE parameters and settings.
---
------
---@param self AI_PATROL_ZONE 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@private
function AI_PATROL_ZONE:onafterRoute(Controllable, From, Event, To) end

---Defines a new patrol route using the #AI_PATROL_ZONE parameters and settings.
---
------
---@param self AI_PATROL_ZONE 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return AI_PATROL_ZONE #self
---@private
function AI_PATROL_ZONE:onafterStart(Controllable, From, Event, To) end


---
------
---@param self NOTYPE 
---@private
function AI_PATROL_ZONE:onafterStatus() end


---
------
---@param self NOTYPE 
---@param Controllable NOTYPE 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@private
function AI_PATROL_ZONE:onbeforeDetect(Controllable, From, Event, To) end


---
------
---@param self NOTYPE 
---@private
function AI_PATROL_ZONE:onbeforeStatus() end



