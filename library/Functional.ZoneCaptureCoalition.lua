---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Capture_Zones.JPG" width="100%">
---
---**Functional** - Models the process to zone guarding and capturing.
---
---===
---
---## Features:
---
---  * Models the possible state transitions between the Guarded, Attacked, Empty and Captured states.
---  * A zone has an owning coalition, that means that at a specific point in time, a zone can be owned by the red or blue coalition.
---  * Provide event handlers to tailor the actions when a zone changes coalition or state.
---
---===
---
---## Missions:
---
---[CAZ - Capture Zones](https://github.com/FlightControl-Master/MOOSE_MISSIONS/tree/master/Functional/ZoneCaptureCoalition)
---
---===
---
---# Player Experience
---
---![States](..\Presentations\ZONE_CAPTURE_COALITION\Dia3.JPG)
--- 
---The above models the possible state transitions between the **Guarded**, **Attacked**, **Empty** and **Captured** states.  
---A zone has an __owning coalition__, that means that at a specific point in time, a zone can be owned by the red or blue coalition.
---
---The Zone can be in the state **Guarded** by the __owning coalition__, which is the coalition that initially occupies the zone with units of its coalition.  
---Once units of an other coalition are entering the Zone, the state will change to **Attacked**. As long as these units remain in the zone, the state keeps set to Attacked.  
---When all units are destroyed in the Zone, the state will change to **Empty**, which expresses that the Zone is empty, and can be captured.  
---When units of the other coalition are in the Zone, and no other units of the owning coalition is in the Zone, the Zone is captured, and its state will change to **Captured**.  
---
---The zone needs to be monitored regularly for the presence of units to interprete the correct state transition required.  
---This monitoring process MUST be started using the #ZONE_CAPTURE_COALITION.Start() method.  
---Otherwise no monitoring will be active and the zone will stay in the current state forever.  
---
---===
---
---## [YouTube Playlist](https://www.youtube.com/watch?v=0m6K6Yxa-os&list=PL7ZUrU4zZUl0qqJsfa8DPvZWDY-OyDumE)
---
---===
---
---### Author: **FlightControl**
---### Contributions: **Millertime** - Concept, **funkyfranky**
---
---===
---Models the process to capture a Zone for a Coalition, which is guarded by another Coalition.
---This is a powerful concept that allows to create very dynamic missions based on the different state transitions of various zones.
---
---===
---
---In order to use ZONE_CAPTURE_COALITION, you need to:
---
---  * Create a Core.Zone object from one of the ZONE_ classes.    
---    The functional ZONE_ classses are those derived from a ZONE_RADIUS.
---    In order to use a ZONE_POLYGON, hand over the **GROUP name** of a late activated group forming a polygon with it's waypoints.
---  * Set the state of the zone. Most of the time, Guarded would be the initial state.
---  * Start the zone capturing **monitoring process**.  
---    This will check the presence of friendly and/or enemy units within the zone and will transition the state of the zone when the tactical situation changed.
---    The frequency of the monitoring must not be real-time, a 30 second interval to execute the checks is sufficient. 
---
---![New](..\Presentations\ZONE_CAPTURE_COALITION\Dia5.JPG)
---
---### Important:
---
---You must start the monitoring process within your code, or there won't be any state transition checks executed.  
---See further the start/stop monitoring process.
---
---### Important:
---
---Ensure that the object containing the ZONE_CAPTURE_COALITION object is persistent.
---Otherwise the garbage collector of lua will remove the object and the monitoring process will stop.
---This will result in your object to be destroyed (removed) from internal memory and there won't be any zone state transitions anymore detected!
---So use the `local` keyword in lua with thought! Most of the time, you can declare your object gobally.
---
---
---
---# Example:
---
---      -- Define a new ZONE object, which is based on the trigger zone `CaptureZone`, which is defined within the mission editor.
---      CaptureZone = ZONE:New( "CaptureZone" )
---      
---      -- Here we create a new ZONE_CAPTURE_COALITION object, using the :New constructor.
---      ZoneCaptureCoalition = ZONE_CAPTURE_COALITION:New( CaptureZone, coalition.side.RED )
---      
---      -- Set the zone to Guarding state.
---      ZoneCaptureCoalition:__Guard( 1 )
---      
---      -- Start the zone monitoring process in 30 seconds and check every 30 seconds.
---      ZoneCaptureCoalition:Start( 30, 30 ) 
---  
---
---# Constructor:
---  
---Use the #ZONE_CAPTURE_COALITION.New() constructor to create a new ZONE_CAPTURE_COALITION object.
---
---# ZONE_CAPTURE_COALITION is a finite state machine (FSM).
---
---![States](..\Presentations\ZONE_CAPTURE_COALITION\Dia4.JPG)
---
---## ZONE_CAPTURE_COALITION States
---
---  * **Captured**: The Zone has been captured by an other coalition.
---  * **Attacked**: The Zone is currently intruded by an other coalition. There are units of the owning coalition and an other coalition in the Zone.
---  * **Guarded**: The Zone is guarded by the owning coalition. There is no other unit of an other coalition in the Zone.
---  * **Empty**: The Zone is empty. There is not valid unit in the Zone.
---  
---## 2.2 ZONE_CAPTURE_COALITION Events
---
---  * **Capture**: The Zone has been captured by an other coalition.
---  * **Attack**: The Zone is currently intruded by an other coalition. There are units of the owning coalition and an other coalition in the Zone.
---  * **Guard**: The Zone is guarded by the owning coalition. There is no other unit of an other coalition in the Zone.
---  * **Empty**: The Zone is empty. There is not valid unit in the Zone.
---
---# "Script It"
---
---ZONE_CAPTURE_COALITION allows to take action on the various state transitions and add your custom code and logic.
---
---## Take action using state- and event handlers.
---
---![States](..\Presentations\ZONE_CAPTURE_COALITION\Dia6.JPG)
---
---The most important to understand is how states and events can be tailored.
---Carefully study the diagram and the explanations.
---
---**State Handlers** capture the moment:
---
---  - On Leave from the old state. Return false to cancel the transition.
---  - On Enter to the new state.
---
---**Event Handlers** capture the moment:
---
---  - On Before the event is triggered. Return false to cancel the transition.
---  - On After the event is triggered.
---
---![States](..\Presentations\ZONE_CAPTURE_COALITION\Dia7.JPG)
---
---Each handler can receive optionally 3 parameters:
---
---  - **From**: A string containing the From State.
---  - **Event**: A string containing the Event.
---  - **To**: A string containing the To State.
---  
---The mission designer can use these values to alter the logic.
---For example:
---
---    -- @param Functional.ZoneCaptureCoalition#ZONE_CAPTURE_COALITION self
---    function ZoneCaptureCoalition:OnEnterGuarded( From, Event, To )
---      if From ~= "Empty" then
---        -- Display a message
---      end
---    end
---
---This code checks that when the __Guarded__ state has been reached, that if the **From** state was __Empty__, then display a message.
---
---## Example Event Handler.
---
---    -- @param Functional.ZoneCaptureCoalition#ZONE_CAPTURE_COALITION self
---    function ZoneCaptureCoalition:OnEnterGuarded( From, Event, To )
---      if From ~= To then
---        local Coalition = self:GetCoalition()
---        self:E( { Coalition = Coalition } )
---        if Coalition == coalition.side.BLUE then
---          ZoneCaptureCoalition:Smoke( SMOKECOLOR.Blue )
---          US_CC:MessageTypeToCoalition( string.format( "%s is under protection of the USA", ZoneCaptureCoalition:GetZoneName() ), MESSAGE.Type.Information )
---          RU_CC:MessageTypeToCoalition( string.format( "%s is under protection of the USA", ZoneCaptureCoalition:GetZoneName() ), MESSAGE.Type.Information )
---        else
---          ZoneCaptureCoalition:Smoke( SMOKECOLOR.Red )
---          RU_CC:MessageTypeToCoalition( string.format( "%s is under protection of Russia", ZoneCaptureCoalition:GetZoneName() ), MESSAGE.Type.Information )
---          US_CC:MessageTypeToCoalition( string.format( "%s is under protection of Russia", ZoneCaptureCoalition:GetZoneName() ), MESSAGE.Type.Information )
---        end
---      end
---    end
---    
---## Stop and Start the zone monitoring process.
---
---At regular intervals, the state of the zone needs to be monitored.
---The zone needs to be scanned for the presence of units within the zone boundaries.
---Depending on the owning coalition of the zone and the presence of units (of the owning and/or other coalition(s)), the zone will transition to another state.
---
---However, ... this scanning process is rather CPU intensive. Imagine you have 10 of these capture zone objects setup within your mission.
---That would mean that your mission would check 10 capture zones simultaneously, each checking for the presence of units.
---It would be highly **CPU inefficient**, as some of these zones are not required to be monitored (yet).
---
---Therefore, the mission designer is given 2 methods that allow to take control of the CPU utilization efficiency:
---
---  * #ZONE_CAPTURE_COALITION.Start(): This starts the monitoring process.
---  * #ZONE_CAPTURE_COALITION.Stop(): This stops the monitoring process.
---  
---### IMPORTANT
---
---**Each capture zone object must have the monitoring process started specifically. The monitoring process is NOT started by default!**
---  
---
---# Full Example
---
---The following annotated code shows a real example of how ZONE_CAPTURE_COALITION can be applied.
---
---The concept is simple.
---
---The USA (US), blue coalition, needs to capture the Russian (RU), red coalition, zone, which is near groom lake.
---
---A capture zone has been setup that guards the presence of the troops.
---Troops are guarded by red forces. Blue is required to destroy the red forces and capture the zones.
---
---At first, we setup the Command Centers
---
---     do
---       
---       RU_CC = COMMANDCENTER:New( GROUP:FindByName( "REDHQ" ), "Russia HQ" )
---       US_CC = COMMANDCENTER:New( GROUP:FindByName( "BLUEHQ" ), "USA HQ" )
---     
---     end
---     
---Next, we define the mission, and add some scoring to it.
---     
---     do -- Missions
---       
---       US_Mission_EchoBay = MISSION:New( US_CC, "Echo Bay", "Primary",
---         "Welcome trainee. The airport Groom Lake in Echo Bay needs to be captured.\n" ..
---         "There are five random capture zones located at the airbase.\n" ..
---         "Move to one of the capture zones, destroy the fuel tanks in the capture zone, " ..
---         "and occupy each capture zone with a platoon.\n " .. 
---         "Your orders are to hold position until all capture zones are taken.\n" ..
---         "Use the map (F10) for a clear indication of the location of each capture zone.\n" ..
---         "Note that heavy resistance can be expected at the airbase!\n" ..
---         "Mission 'Echo Bay' is complete when all five capture zones are taken, and held for at least 5 minutes!"
---         , coalition.side.RED )
---         
---       US_Mission_EchoBay:Start()
---     
---     end
---     
---     
---Now the real work starts.
---We define a **CaptureZone** object, which is a ZONE object.
---Within the mission, a trigger zone is created with the name __CaptureZone__, with the defined radius within the mission editor.
---
---     CaptureZone = ZONE:New( "CaptureZone" )
---
---Next, we define the **ZoneCaptureCoalition** object, as explained above.
---     
---     ZoneCaptureCoalition = ZONE_CAPTURE_COALITION:New( CaptureZone, coalition.side.RED ) 
---     
---Of course, we want to let the **ZoneCaptureCoalition** object do something when the state transitions.
---Do accomodate this, it is very simple, as explained above.
---We use **Event Handlers** to tailor the logic.
---
---Here we place an Event Handler at the Guarded event. So when the **Guarded** event is triggered, then this method is called!
---With the variables **From**, **Event**, **To**. Each of these variables containing a string.
---
---We check if the previous state wasn't Guarded also.
---If not, we retrieve the owning Coalition of the **ZoneCaptureCoalition**, using `self:GetCoalition()`.
---So **Coalition** will contain the current owning coalition of the zone.
---
---Depending on the zone ownership, different messages are sent.
---Note the methods `ZoneCaptureCoalition:GetZoneName()`.
---     
---     -- @param Functional.ZoneCaptureCoalition#ZONE_CAPTURE_COALITION self
---     function ZoneCaptureCoalition:OnEnterGuarded( From, Event, To )
---       if From ~= To then
---         local Coalition = self:GetCoalition()
---         self:E( { Coalition = Coalition } )
---         if Coalition == coalition.side.BLUE then
---           ZoneCaptureCoalition:Smoke( SMOKECOLOR.Blue )
---           US_CC:MessageTypeToCoalition( string.format( "%s is under protection of the USA", ZoneCaptureCoalition:GetZoneName() ), MESSAGE.Type.Information )
---           RU_CC:MessageTypeToCoalition( string.format( "%s is under protection of the USA", ZoneCaptureCoalition:GetZoneName() ), MESSAGE.Type.Information )
---         else
---           ZoneCaptureCoalition:Smoke( SMOKECOLOR.Red )
---           RU_CC:MessageTypeToCoalition( string.format( "%s is under protection of Russia", ZoneCaptureCoalition:GetZoneName() ), MESSAGE.Type.Information )
---           US_CC:MessageTypeToCoalition( string.format( "%s is under protection of Russia", ZoneCaptureCoalition:GetZoneName() ), MESSAGE.Type.Information )
---         end
---       end
---     end
---
---As you can see, not a rocket science.
---Next is the Event Handler when the **Empty** state transition is triggered.
---Now we smoke the ZoneCaptureCoalition with a green color, using `self:Smoke( SMOKECOLOR.Green )`.
---     
---     -- @param Functional.Protect#ZONE_CAPTURE_COALITION self
---     function ZoneCaptureCoalition:OnEnterEmpty()
---       self:Smoke( SMOKECOLOR.Green )
---       US_CC:MessageTypeToCoalition( string.format( "%s is unprotected, and can be captured!", ZoneCaptureCoalition:GetZoneName() ), MESSAGE.Type.Information )
---       RU_CC:MessageTypeToCoalition( string.format( "%s is unprotected, and can be captured!", ZoneCaptureCoalition:GetZoneName() ), MESSAGE.Type.Information )
---     end
---
---The next Event Handlers speak for itself.
---When the zone is Attacked, we smoke the zone white and send some messages to each coalition.     
---     
---     -- @param Functional.Protect#ZONE_CAPTURE_COALITION self
---     function ZoneCaptureCoalition:OnEnterAttacked()
---       ZoneCaptureCoalition:Smoke( SMOKECOLOR.White )
---       local Coalition = self:GetCoalition()
---       self:E({Coalition = Coalition})
---       if Coalition == coalition.side.BLUE then
---         US_CC:MessageTypeToCoalition( string.format( "%s is under attack by Russia", ZoneCaptureCoalition:GetZoneName() ), MESSAGE.Type.Information )
---         RU_CC:MessageTypeToCoalition( string.format( "We are attacking %s", ZoneCaptureCoalition:GetZoneName() ), MESSAGE.Type.Information )
---       else
---         RU_CC:MessageTypeToCoalition( string.format( "%s is under attack by the USA", ZoneCaptureCoalition:GetZoneName() ), MESSAGE.Type.Information )
---         US_CC:MessageTypeToCoalition( string.format( "We are attacking %s", ZoneCaptureCoalition:GetZoneName() ), MESSAGE.Type.Information )
---       end
---     end
---
---When the zone is Captured, we send some victory or loss messages to the correct coalition.
---And we add some score.
---
---     -- @param Functional.Protect#ZONE_CAPTURE_COALITION self
---     function ZoneCaptureCoalition:OnEnterCaptured()
---       local Coalition = self:GetCoalition()
---       self:E({Coalition = Coalition})
---       if Coalition == coalition.side.BLUE then
---         RU_CC:MessageTypeToCoalition( string.format( "%s is captured by the USA, we lost it!", ZoneCaptureCoalition:GetZoneName() ), MESSAGE.Type.Information )
---         US_CC:MessageTypeToCoalition( string.format( "We captured %s, Excellent job!", ZoneCaptureCoalition:GetZoneName() ), MESSAGE.Type.Information )
---       else
---         US_CC:MessageTypeToCoalition( string.format( "%s is captured by Russia, we lost it!", ZoneCaptureCoalition:GetZoneName() ), MESSAGE.Type.Information )
---         RU_CC:MessageTypeToCoalition( string.format( "We captured %s, Excellent job!", ZoneCaptureCoalition:GetZoneName() ), MESSAGE.Type.Information )
---       end
---       
---       self:__Guard( 30 )
---     end
---
---And this call is the most important of all!
---In the context of the mission, we need to start the zone capture monitoring process.
---Or nothing will be monitored and the zone won't change states.
---We start the monitoring after 5 seconds, and will repeat every 30 seconds a check.
---       
---     ZoneCaptureCoalition:Start( 5, 30 )
---@class ZONE_CAPTURE_COALITION 
---@field HitsOn  
---@field MarkBlue  
---@field MarkOn boolean 
---@field MarkRed  
---@field ScheduleStatusZone  
---@field SmokeScheduler  
ZONE_CAPTURE_COALITION = {}

---Attack Trigger for ZONE_CAPTURE_COALITION
---
------
---@param self ZONE_CAPTURE_COALITION 
function ZONE_CAPTURE_COALITION:Attack() end

---Capture Trigger for ZONE_CAPTURE_COALITION
---
------
---@param self ZONE_CAPTURE_COALITION 
function ZONE_CAPTURE_COALITION:Capture() end

---Empty Trigger for ZONE_CAPTURE_COALITION
---
------
---@param self ZONE_CAPTURE_COALITION 
function ZONE_CAPTURE_COALITION:Empty() end

---Guard Trigger for ZONE_CAPTURE_COALITION
---
------
---@param self ZONE_CAPTURE_COALITION 
function ZONE_CAPTURE_COALITION:Guard() end

---Check if zone is "Attacked", i.e.
---another coalition entered the zone.
---
------
---@param self ZONE_CAPTURE_COALITION 
---@return boolean #self:IsSomeInZoneOfCoalition( self.Coalition )
function ZONE_CAPTURE_COALITION:IsAttacked() end

---Check if zone is "Captured", i.e.
---another coalition took control over the zone and is the only one present.
---
------
---@param self ZONE_CAPTURE_COALITION 
---@return boolean #self:IsAllInZoneOfOtherCoalition( self.Coalition )
function ZONE_CAPTURE_COALITION:IsCaptured() end

---Check if zone is "Empty".
---
------
---@param self ZONE_CAPTURE_COALITION 
---@return boolean #self:IsNoneInZone()
function ZONE_CAPTURE_COALITION:IsEmpty() end

---Check if zone is "Guarded", i.e.
---only one (the defending) coalition is present inside the zone.
---
------
---@param self ZONE_CAPTURE_COALITION 
---@return boolean #self:IsAllInZoneOfCoalition( self.Coalition )
function ZONE_CAPTURE_COALITION:IsGuarded() end

---Update Mark on F10 map.
---
------
---@param self ZONE_CAPTURE_COALITION 
function ZONE_CAPTURE_COALITION:Mark() end

---ZONE_CAPTURE_COALITION Constructor.
---
------
---
---USAGE
---```
---
--- AttackZone = ZONE:New( "AttackZone" )
---
--- ZoneCaptureCoalition = ZONE_CAPTURE_COALITION:New( AttackZone, coalition.side.RED, {UNITS ) -- Create a new ZONE_CAPTURE_COALITION object of zone AttackZone with ownership RED coalition.
--- ZoneCaptureCoalition:__Guard( 1 ) -- Start the Guarding of the AttackZone.
---```
------
---@param self ZONE_CAPTURE_COALITION 
---@param Zone ZONE A @{Core.Zone} object with the goal to be achieved. Alternatively, can be handed as the name of late activated group describing a @{Core.Zone#ZONE_POLYGON} with its waypoints.
---@param Coalition number The initial coalition owning the zone.
---@param UnitCategories table Table of unit categories. See [DCS Class Unit](https://wiki.hoggitworld.com/view/DCS_Class_Unit). Default {Unit.Category.GROUND_UNIT}.
---@param ObjectCategories table Table of unit categories. See [DCS Class Object](https://wiki.hoggitworld.com/view/DCS_Class_Object). Default {Object.Category.UNIT, Object.Category.STATIC}, i.e. all UNITS and STATICS.
---@return ZONE_CAPTURE_COALITION #
function ZONE_CAPTURE_COALITION:New(Zone, Coalition, UnitCategories, ObjectCategories) end

---Attack Handler OnAfter for ZONE_CAPTURE_COALITION
---
------
---@param self ZONE_CAPTURE_COALITION 
---@param From string 
---@param Event string 
---@param To string 
function ZONE_CAPTURE_COALITION:OnAfterAttack(From, Event, To) end

---Capture Handler OnAfter for ZONE_CAPTURE_COALITION
---
------
---@param self ZONE_CAPTURE_COALITION 
---@param From string 
---@param Event string 
---@param To string 
function ZONE_CAPTURE_COALITION:OnAfterCapture(From, Event, To) end

---Empty Handler OnAfter for ZONE_CAPTURE_COALITION
---
------
---@param self ZONE_CAPTURE_COALITION 
---@param From string 
---@param Event string 
---@param To string 
function ZONE_CAPTURE_COALITION:OnAfterEmpty(From, Event, To) end

---Guard Handler OnAfter for ZONE_CAPTURE_COALITION
---
------
---@param self ZONE_CAPTURE_COALITION 
---@param From string 
---@param Event string 
---@param To string 
function ZONE_CAPTURE_COALITION:OnAfterGuard(From, Event, To) end

---Attack Handler OnBefore for ZONE_CAPTURE_COALITION
---
------
---@param self ZONE_CAPTURE_COALITION 
---@param From string 
---@param Event string 
---@param To string 
---@return boolean #
function ZONE_CAPTURE_COALITION:OnBeforeAttack(From, Event, To) end

---Capture Handler OnBefore for ZONE_CAPTURE_COALITION
---
------
---@param self ZONE_CAPTURE_COALITION 
---@param From string 
---@param Event string 
---@param To string 
---@return boolean #
function ZONE_CAPTURE_COALITION:OnBeforeCapture(From, Event, To) end

---Empty Handler OnBefore for ZONE_CAPTURE_COALITION
---
------
---@param self ZONE_CAPTURE_COALITION 
---@param From string 
---@param Event string 
---@param To string 
---@return boolean #
function ZONE_CAPTURE_COALITION:OnBeforeEmpty(From, Event, To) end

---Guard Handler OnBefore for ZONE_CAPTURE_COALITION
---
------
---@param self ZONE_CAPTURE_COALITION 
---@param From string 
---@param Event string 
---@param To string 
---@return boolean #
function ZONE_CAPTURE_COALITION:OnBeforeGuard(From, Event, To) end

---Monitor hit events.
---
------
---@param self ZONE_CAPTURE_COALITION 
---@param EventData EVENTDATA The event data.
function ZONE_CAPTURE_COALITION:OnEventHit(EventData) end

---Set whether marks on the F10 map are shown, which display the current zone status.
---
------
---@param self ZONE_CAPTURE_COALITION 
---@param Switch boolean If *true* or *nil*, marks are shown. If *false*, marks are not displayed.
---@return ZONE_CAPTURE_COALITION #self
function ZONE_CAPTURE_COALITION:SetMarkZone(Switch) end

---Set whether hit events of defending units are monitored and trigger "Attack" events.
---
------
---@param self ZONE_CAPTURE_COALITION 
---@param Switch boolean If *true*, hit events are monitored. If *false* or *nil*, hit events are not monitored.
---@param TimeAttackOver number (Optional) Time in seconds after an attack is over after the last hit and the zone state goes to "Guarded". Default is 300 sec = 5 min.
---@return ZONE_CAPTURE_COALITION #self
function ZONE_CAPTURE_COALITION:SetMonitorHits(Switch, TimeAttackOver) end

---Starts the zone capturing monitoring process.
---This process can be CPU intensive, ensure that you specify reasonable time intervals for the monitoring process.
---Note that the monitoring process is NOT started automatically during the `:New()` constructor.
---It is advised that the zone monitoring process is only started when the monitoring is of relevance in context of the current mission goals.
---When the zone is of no relevance, it is advised NOT to start the monitoring process, or to stop the monitoring process to save CPU resources.
---Therefore, the mission designer will need to use the `:Start()` method within his script to start the monitoring process specifically.
---
------
---
---USAGE
---```
---
----- Setup the zone.
---CaptureZone = ZONE:New( "CaptureZone" )
---ZoneCaptureCoalition = ZONE_CAPTURE_COALITION:New( CaptureZone, coalition.side.RED )
---
----- This starts the monitoring process within 15 seconds, repeating every 15 seconds.
---ZoneCaptureCoalition:Start() 
---     
----- This starts the monitoring process immediately, but repeats every 30 seconds.
---ZoneCaptureCoalition:Start( 0, 30 )
---```
------
---@param self ZONE_CAPTURE_COALITION 
---@param StartInterval number (optional) Specifies the start time interval in seconds when the zone state will be checked for the first time.
---@param RepeatInterval number (optional) Specifies the repeat time interval in seconds when the zone state will be checked repeatedly.
---@return ZONE_CAPTURE_COALITION #self
function ZONE_CAPTURE_COALITION:Start(StartInterval, RepeatInterval) end

---Check status Coalition ownership.
---
------
---@param self ZONE_CAPTURE_COALITION 
function ZONE_CAPTURE_COALITION:StatusZone() end

---Stops the zone capturing monitoring process.
---When the zone capturing monitor process is stopped, there won't be any changes anymore in the state and the owning coalition of the zone.
---This method becomes really useful when the zone is of no relevance anymore within a long lasting mission.
---In this case, it is advised to stop the monitoring process, not to consume unnecessary the CPU intensive scanning of units presence within the zone.
---
------
---
---USAGE
---```
---
----- Setup the zone.
---CaptureZone = ZONE:New( "CaptureZone" )
---ZoneCaptureCoalition = ZONE_CAPTURE_COALITION:New( CaptureZone, coalition.side.RED )
---
----- This starts the monitoring process within 15 seconds, repeating every 15 seconds.
---ZoneCaptureCoalition:Start() 
---
----- When the zone capturing is of no relevance anymore, stop the monitoring!
---ZoneCaptureCoalition:Stop()
---```
------
---@param self ZONE_CAPTURE_COALITION 
function ZONE_CAPTURE_COALITION:Stop() end

---Attack Asynchronous Trigger for ZONE_CAPTURE_COALITION
---
------
---@param self ZONE_CAPTURE_COALITION 
---@param Delay number 
function ZONE_CAPTURE_COALITION:__Attack(Delay) end

---Capture Asynchronous Trigger for ZONE_CAPTURE_COALITION
---
------
---@param self ZONE_CAPTURE_COALITION 
---@param Delay number 
function ZONE_CAPTURE_COALITION:__Capture(Delay) end

---Empty Asynchronous Trigger for ZONE_CAPTURE_COALITION
---
------
---@param self ZONE_CAPTURE_COALITION 
---@param Delay number 
function ZONE_CAPTURE_COALITION:__Empty(Delay) end

---Guard Asynchronous Trigger for ZONE_CAPTURE_COALITION
---
------
---@param self ZONE_CAPTURE_COALITION 
---@param Delay number 
function ZONE_CAPTURE_COALITION:__Guard(Delay) end

---On after "Guard" event.
---
------
---@param self ZONE_CAPTURE_COALITION 
function ZONE_CAPTURE_COALITION:onafterGuard() end

---On enter "Attacked" state.
---
------
---@param self ZONE_CAPTURE_COALITION    
function ZONE_CAPTURE_COALITION:onenterAttacked() end

---On enter "Captured" state.
---
------
---@param self ZONE_CAPTURE_COALITION  
function ZONE_CAPTURE_COALITION:onenterCaptured() end

---On enter "Empty" state.
---
------
---@param self ZONE_CAPTURE_COALITION    
function ZONE_CAPTURE_COALITION:onenterEmpty() end

---On enter "Guarded" state.
---
------
---@param self ZONE_CAPTURE_COALITION 
function ZONE_CAPTURE_COALITION:onenterGuarded() end



