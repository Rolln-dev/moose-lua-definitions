---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/MOOSE.JPG" width="100%">
---
---**Tasking** - Creates and manages player TASK_ZONE_CAPTURE tasks.
---
---The **TASK_CAPTURE_DISPATCHER** allows you to setup various tasks for let human
---players capture zones in a co-operation effort. 
--- 
---The dispatcher will implement for you mechanisms to create capture zone tasks:
--- 
---  * As setup by the mission designer.
---  * Dynamically capture zone tasks.
---  
---
---  
---**Specific features:**
---
---  * Creates a task to capture zones and achieve mission goals.
---  * Orchestrate the task flow, so go from Planned to Assigned to Success, Failed or Cancelled.
---  * Co-operation tasking, so a player joins a group of players executing the same task.
---
---
---**A complete task menu system to allow players to:**
---  
---  * Join the task, abort the task.
---  * Mark the location of the zones to capture on the map.
---  * Provide details of the zones.
---  * Route to the zones.
---  * Display the task briefing.
---  
---  
---**A complete mission menu system to allow players to:**
---  
---  * Join a task, abort the task.
---  * Display task reports.
---  * Display mission statistics.
---  * Mark the task locations on the map.
---  * Provide details of the zones.
---  * Display the mission briefing.
---  * Provide status updates as retrieved from the command center.
---  * Automatically assign a random task as part of a mission.
---  * Manually assign a specific task as part of a mission.
---  
---  
--- **A settings system, using the settings menu:**
--- 
---  * Tweak the duration of the display of messages.
---  * Switch between metric and imperial measurement system.
---  * Switch between coordinate formats used in messages: BR, BRA, LL DMS, LL DDM, MGRS.
---  * Various other options.
---
---# Developer Note
---
---Note while this class still works, it is no longer supported as the original author stopped active development of MOOSE
---Therefore, this class is considered to be deprecated
---
---===
---
---### Author: **FlightControl**
---
---### Contributions: 
---
---===
---Implements the dynamic dispatching of capture zone tasks.
---
---![Banner Image](..\Images\deprecated.png)
---
---The **TASK_CAPTURE_DISPATCHER** allows you to setup various tasks for let human
---players capture zones in a co-operation effort. 
--- 
---Let's explore **step by step** how to setup the task capture zone dispatcher.
---
---# 1. Setup a mission environment.
---
---It is easy, as it works just like any other task setup, so setup a command center and a mission.
---
---## 1.1. Create a command center.
---
---First you need to create a command center using the Tasking.CommandCenter#COMMANDCENTER.New() constructor.
---The command assumes that you´ve setup a group in the mission editor with the name HQ.
---This group will act as the command center object.
---It is a good practice to mark this group as invisible and invulnerable.
---
---    local CommandCenter = COMMANDCENTER
---       :New( GROUP:FindByName( "HQ" ), "HQ" ) -- Create the CommandCenter.
---    
---## 1.2. Create a mission.
---
---Tasks work in a **mission**, which groups these tasks to achieve a joint **mission goal**. A command center can **govern multiple missions**.
---
---Create a new mission, using the Tasking.Mission#MISSION.New() constructor.
---
---    -- Declare the Mission for the Command Center.
---    local Mission = MISSION
---      :New( CommandCenter, 
---            "Overlord", 
---            "High", 
---            "Capture the blue zones.", 
---            coalition.side.RED 
---          ) 
---
---
---# 2. Dispatch a **capture zone** task.
---
---So, now that we have a command center and a mission, we now create the capture zone task.
---We create the capture zone task using the #TASK_CAPTURE_DISPATCHER.AddCaptureZoneTask() constructor.
---
---## 2.1. Create the capture zones.
---
---Because a capture zone task will not generate the capture zones, you'll need to create them first.
---
---    
---    -- We define here a capture zone; of the type ZONE_CAPTURE_COALITION.
---    -- The zone to be captured has the name Alpha, and was defined in the mission editor as a trigger zone.
---    CaptureZone = ZONE:New( "Alpha" )
---    CaptureZoneCoalitionApha = ZONE_CAPTURE_COALITION:New( CaptureZone, coalition.side.RED )
---
---## 2.2. Create a set of player groups.
---   
---What is also needed, is to have a set of Wrapper.Groups defined that contains the clients of the players.
---
---    -- Allocate the player slots, which must be aircraft (airplanes or helicopters), that can be manned by players.
---    -- We use the method FilterPrefixes to filter those player groups that have client slots, as defined in the mission editor.
---    -- In this example, we filter the groups where the name starts with "Blue Player", which captures the blue player slots.
---    local PlayerGroupSet = SET_GROUP:New():FilterPrefixes( "Blue Player" ):FilterStart()
---
---## 2.3. Setup the capture zone task.
---
---First, we need to create a TASK_CAPTURE_DISPATCHER object.
---
---    TaskCaptureZoneDispatcher = TASK_CAPTURE_DISPATCHER:New( Mission, PilotGroupSet )
---
---So, the variable `TaskCaptureZoneDispatcher` will contain the object of class TASK_CAPTURE_DISPATCHER, 
---which will allow you to dispatch capture zone tasks:
--- 
---  * for mission `Mission`, as was defined in section 1.2.
---  * for the group set `PilotGroupSet`, as was defined in section 2.2.
---
---Now that we have `TaskDispatcher` object, we can now **create the TaskCaptureZone**, using the #TASK_CAPTURE_DISPATCHER.AddCaptureZoneTask() method!
---
---    local TaskCaptureZone = TaskCaptureZoneDispatcher:AddCaptureZoneTask( 
---      "Capture zone Alpha", 
---      CaptureZoneCoalitionAlpha, 
---      "Fly to zone Alpha and eliminate all enemy forces to capture it." )
---
---As a result of this code, the `TaskCaptureZone` (returned) variable will contain an object of #TASK_CAPTURE_ZONE!
---We pass to the method the title of the task, and the `CaptureZoneCoalitionAlpha`, which is the zone to be captured, as defined in section 2.1!
---This returned `TaskCaptureZone` object can now be used to setup additional task configurations, or to control this specific task with special events.
---
---And you're done! As you can see, it is a small bit of work, but the reward is great.
---And, because all this is done using program interfaces, you can easily build a mission to capture zones yourself!
---Based on various events happening within your mission, you can use the above methods to create new capture zones, 
---and setup a new capture zone task and assign it to a group of players, while your mission is running!
---
---TASK_CAPTURE_DISPATCHER class.
---@deprecated
---@class TASK_CAPTURE_DISPATCHER : TASK_MANAGER
---@field AI_A2G_Dispatcher AI_A2G_DISPATCHER 
---@field DefenseAIA2GDispatcher NOTYPE 
---@field DefenseTaskCaptureDispatcher NOTYPE 
---@field FlashNewTask boolean 
---@field Mission NOTYPE 
TASK_CAPTURE_DISPATCHER = {}

---Add a capture zone task.
---
------
---
---USAGE
---```
---
---```
------
---@param TaskPrefix? string (optional) The prefix of the capture zone task.  If no TaskPrefix is given, then "Capture" will be used as the TaskPrefix.  The TaskPrefix will be appended with a . + a number of 3 digits, if the TaskPrefix already exists in the task collection.
---@param CaptureZone ZONE_CAPTURE_COALITION The zone of the coalition to be captured as the task goal.
---@param Briefing string The briefing of the task to be shown to the player.
---@return TASK_CAPTURE_ZONE #
function TASK_CAPTURE_DISPATCHER:AddCaptureZoneTask(TaskPrefix, CaptureZone, Briefing) end

---Get the linked AI A2G dispatcher from the other coalition to understand its plan for defenses.
---This is used for the tactical overview, so the players also know the zones attacked by the AI A2G dispatcher!
---
------
---@return AI_A2G_DISPATCHER #
function TASK_CAPTURE_DISPATCHER:GetDefenseAIA2GDispatcher() end

---Get the linked task capture dispatcher from the other coalition to understand its plan for defenses.
---This is used for the tactical overview, so the players also know the zones attacked by the other coalition!
---
------
---@return TASK_CAPTURE_DISPATCHER #
function TASK_CAPTURE_DISPATCHER:GetDefenseTaskCaptureDispatcher() end

---Link an AI_A2G_DISPATCHER to the TASK_CAPTURE_DISPATCHER.
---
------
---@param AI_A2G_Dispatcher AI_A2G_DISPATCHER The AI Dispatcher to be linked to the tasking. 
---@return TASK_CAPTURE_ZONE #
function TASK_CAPTURE_DISPATCHER:Link_AI_A2G_Dispatcher(AI_A2G_Dispatcher) end

---Assigns tasks to the Core.Set#SET_GROUP.
---
------
---@return boolean #Return true if you want the task assigning to continue... false will cancel the loop.
function TASK_CAPTURE_DISPATCHER:ManageTasks() end

---TASK_CAPTURE_DISPATCHER constructor.
---
------
---@param Mission MISSION The mission for which the task dispatching is done.
---@param SetGroup SET_GROUP The set of groups that can join the tasks within the mission.
---@return TASK_CAPTURE_DISPATCHER #self
function TASK_CAPTURE_DISPATCHER:New(Mission, SetGroup) end

---Link an AI A2G dispatcher from the other coalition to understand its plan for defenses.
---This is used for the tactical overview, so the players also know the zones attacked by the other AI A2G dispatcher!
---
------
---@param DefenseAIA2GDispatcher AI_A2G_DISPATCHER 
function TASK_CAPTURE_DISPATCHER:SetDefenseAIA2GDispatcher(DefenseAIA2GDispatcher) end

---Link a task capture dispatcher from the other coalition to understand its plan for defenses.
---This is used for the tactical overview, so the players also know the zones attacked by the other coalition!
---
------
---@param DefenseTaskCaptureDispatcher TASK_CAPTURE_DISPATCHER 
function TASK_CAPTURE_DISPATCHER:SetDefenseTaskCaptureDispatcher(DefenseTaskCaptureDispatcher) end



