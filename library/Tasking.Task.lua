---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/MOOSE.JPG" width="100%">
---
---**Tasking** - A task object governs the main engine to administer human taskings.
---
---**Features:**
---
---  * A base class for other task classes filling in the details and making a concrete task process.
---  * Manage the overall task execution, following-up the progression made by the pilots and actors.
---  * Provide a mechanism to set a task status, depending on the progress made within the task.
---  * Manage a task briefing.
---  * Manage the players executing the task.
---  * Manage the task menu system.
---  * Manage the task goal and scoring.
---
---===
---
---![Banner Image](..\Images\deprecated.png)
---
---# 1) Tasking from a player perspective.
---
---Tasking can be controlled by using the "other" menu in the radio menu of the player group.
---
---![Other Menu](../Tasking/Menu_Main.JPG)
---
---## 1.1) Command Centers govern multiple Missions.
---
---Depending on the tactical situation, your coalition may have one (or multiple) command center(s).
---These command centers govern one (or multiple) mission(s).
---
---For each command center, there will be a separate **Command Center Menu** that focuses on the missions governed by that command center.
---
---![Command Center](../Tasking/Menu_CommandCenter.JPG)
---
---In the above example menu structure, there is one command center with the name **`[Lima]`**.
---The command center has one Tasking.Mission, named **`"Overlord"`** with **`High`** priority.
---
---## 1.2) Missions govern multiple Tasks.
---
---A mission has a mission goal to be achieved by the players within the coalition.
---The mission goal is actually dependent on the tactical situation of the overall battlefield and the conditions set to achieve the goal.
---So a mission can be much more than just shoot stuff ... It can be a combination of different conditions or events to complete a mission goal.
---
---A mission can be in a specific state during the simulation run. For more information about these states, please check the Tasking.Mission section.
---
---To achieve the mission goal, a mission administers #TASKs that are set to achieve the mission goal by the human players.
---Each of these tasks can be **dynamically created** using a task dispatcher, or **coded** by the mission designer.
---Each mission has a separate **Mission Menu**, that focuses on the administration of these tasks.
---
---On top, a mission has a mission briefing, can help to allocate specific points of interest on the map, and provides various reports.
---
---![Mission](../Tasking/Menu_Mission.JPG)
---
---The above shows a mission menu in detail of **`"Overlord"`**.
---
---The two other menus are related to task assignment. Which will be detailed later.
---
---### 1.2.1) Mission briefing.
---
---The task briefing will show a message containing a description of the mission goal, and other tactical information.
---
---![Mission](../Tasking/Report_Briefing.JPG)
---
---### 1.2.2) Mission Map Locations.
---
---Various points of interest as part of the mission can be indicated on the map using the *Mark Task Locations on Map* menu.
---As a result, the map will contain various points of interest for the player (group).
---
---![Mission](../Tasking/Report_Mark_Task_Location.JPG)
---
---### 1.2.3) Mission Task Reports.
---
---Various reports can be generated on the status of each task governed within the mission.
---
---![Mission](../Tasking/Report_Task_Summary.JPG)
---
---The Task Overview Report will show each task, with its task status and a short coordinate information.
---
---![Mission](../Tasking/Report_Tasks_Planned.JPG)
---
---The other Task Menus will show for each task more details, for example here the planned tasks report. 
---Note that the order of the tasks are shortest distance first to the unit position seated by the player.
---
---### 1.2.4) Mission Statistics.
---
---Various statistics can be displayed regarding the mission.
---
---![Mission](../Tasking/Report_Statistics_Progress.JPG)
---
---A statistic report on the progress of the mission. Each task achievement will increase the % to 100% as a goal to complete the task.
---
---## 1.3) Join a Task.
---
---The mission menu contains a very important option, that is to join a task governed within the mission.
---In order to join a task, select the **Join Planned Task** menu, and a new menu will be given.
---
---![Mission](../Tasking/Menu_Join_Planned_Tasks.JPG)
---
---A mission governs multiple tasks, as explained earlier. Each task is of a certain task type.
---This task type was introduced to have some sort of task classification system in place for the player.
---A short acronym is shown that indicates the task type. The meaning of each acronym can be found in the task types explanation.
---
---![Mission](../Tasking/Menu_Join_Tasks.JPG)
---
---When the player selects a task type, a list of the available tasks of that type are listed...
---In this case the **`SEAD`** task type was selected and a list of available **`SEAD`** tasks can be selected.
---
---![Mission](../Tasking/Menu_Join_Planned_Task.JPG)
---
---A new list of menu options are now displayed that allow to join the task selected, but also to obtain first some more information on the task.
---
---### 1.3.1) Report Task Details.
---
---![Mission](../Tasking/Report_Task_Detailed.JPG)
---
---When selected, a message is displayed that shows detailed information on the task, like the coordinate, enemy target information, threat level etc.
---
---### 1.3.2) Mark Task Location on Map.
---
---![Mission](../Tasking/Report_Task_Detailed.JPG)
---
---When selected, the target location on the map is indicated with specific information on the task.
---
---### 1.3.3) Join Task.
---
---![Mission](../Tasking/Report_Task_Detailed.JPG)
---
---By joining a task, the player will indicate that the task is assigned to him, and the task is started.
---The Command Center will communicate several task details to the player and the coalition of the player.
---
---## 1.4) Task Control and Actions.
---
---![Mission](../Tasking/Menu_Main_Task.JPG)
---
---When a player has joined a task, a **Task Action Menu** is available to be used by the player. 
---
---![Mission](../Tasking/Menu_Task.JPG)
---
---The task action menu contains now menu items specific to the task, but also one generic menu item, which is to control the task.
---This **Task Control Menu** allows to display again the task details and the task map location information.
---But it also allows to abort a task!
---
---Depending on the task type, the task action menu can contain more menu items which are specific to the task.
---For example, cargo transportation tasks will contain various additional menu items to select relevant cargo coordinates,
---or to load/unload cargo.
---
---## 1.5) Automatic task assignment.
---
---![Command Center](../Tasking/Menu_CommandCenter.JPG)
---
---When we take back the command center menu, you see two additional **Assign Task** menu items.
---The menu **Assign Task On** will automatically allocate a task to the player.
---After the selection of this menu, the menu will change into **Assign Task Off**,
---and will need to be selected again by the player to switch of the automatic task assignment.
---
---The other option is to select **Assign Task**, which will assign a new random task to the player.
---
---When a task is automatically assigned to a player, the task needs to be confirmed as accepted within 30 seconds.
---If this is not the case, the task will be cancelled automatically, and a new random task will be assigned to the player.
---This will continue to happen until the player accepts the task or switches off the automatic task assignment process.
---
---The player can accept the task using the menu **Confirm Task Acceptance** ...
---
---## 1.6) Task states.
---
---A task has a state, reflecting the progress or completion status of the task:
---
---  - **Planned**: Expresses that the task is created, but not yet in execution and is not assigned yet to a pilot.
---  - **Assigned**: Expresses that the task is assigned to a group of pilots, and that the task is in execution mode.
---  - **Success**: Expresses the successful execution and finalization of the task.
---  - **Failed**: Expresses the failure of a task.
---  - **Abort**: Expresses that the task is aborted by by the player using the abort menu.
---  - **Cancelled**: Expresses that the task is cancelled by HQ or through a logical situation where a cancellation of the task is required.
---
---### 1.6.1) Task progress.
---
---The task governor takes care of the **progress** and **completion** of the task **goal(s)**.
---Tasks are executed by **human pilots** and actors within a DCS simulation.
---Pilots can use a **menu system** to engage or abort a task, and provides means to
---understand the **task briefing** and goals, and the relevant **task locations** on the map and 
---obtain **various reports** related to the task.
---
---### 1.6.2) Task completion.
---
---As the task progresses, the **task status** will change over time, from Planned state to Completed state.
---**Multiple pilots** can execute the same task, as such, the tasking system provides a **co-operative model** for joint task execution.
---Depending on the task progress, a **scoring** can be allocated to award pilots of the achievements made.
---The scoring is fully flexible, and different levels of awarding can be provided depending on the task type and complexity.
---
---A normal flow of task status would evolve from the **Planned** state, to the **Assigned** state ending either in a **Success** or a **Failed** state.
---
---     Planned -> Assigned -> Success
---                         -> Failed
---                         -> Cancelled
---                         
---The state completion is by default set to **Success**, if the goals of the task have been reached, but can be overruled by a goal method.
---
---Depending on the tactical situation, a task can be **Cancelled** by the mission governor.
---It is actually the mission designer who has the flexibility to decide at which conditions a task would be set to **Success**, **Failed** or **Cancelled**.
---This decision all depends on the task goals, and the phase/evolution of the task conditions that would accomplish the goals.
---
---For example, if the task goal is to merely destroy a target, and the target is mid-mission destroyed by another event than the pilot destroying the target,
---the task goal could be set to **Failed**, or .. **Cancelled** ...
---However, it could very well be also acceptable that the task would be flagged as **Success**.
---
---The tasking mechanism governs beside the progress also a scoring mechanism, and in case of goal completion without any active pilot involved
---in the execution of the task, could result in a **Success** task completion status, but no score would be awarded, as there were no players involved. 
---
---These different completion states are important for the mission designer to reflect scoring to a player.
---A success could mean a positive score to be given, while a failure could mean a negative score or penalties to be awarded.
---
---# Developer Note
---
---Note while this class still works, it is no longer supported as the original author stopped active development of MOOSE
---Therefore, this class is considered to be deprecated
---
---===
---
---### Author(s): **FlightControl**
---
---### Contribution(s):
---
---===
---Governs the main engine to administer human taskings.
---
---A task is governed by a Tasking.Mission object. Tasks are of different types.
---The #TASK object is used or derived by more detailed tasking classes that will implement the task execution mechanisms
---and goals. 
---
---# 1) Derived task classes.
---
---The following TASK_ classes are derived from #TASK.
---
---     TASK
---       TASK_A2A
---         TASK_A2A_ENGAGE
---         TASK_A2A_INTERCEPT
---         TASK_A2A_SWEEP
---       TASK_A2G
---         TASK_A2G_SEAD
---         TASK_A2G_CAS
---         TASK_A2G_BAI
---       TASK_CARGO
---         TASK_CARGO_TRANSPORT
---         TASK_CARGO_CSAR
---
---## 1.1) A2A Tasks
---
---  - Tasking.Task_A2A#TASK_A2A_ENGAGE - Models an A2A engage task of a target group of airborne intruders mid-air.
---  - Tasking.Task_A2A#TASK_A2A_INTERCEPT - Models an A2A ground intercept task of a target group of airborne intruders mid-air.
---  - Tasking.Task_A2A#TASK_A2A_SWEEP - Models an A2A sweep task to clean an area of previously detected intruders mid-air.
---
---## 1.2) A2G Tasks
---
---  - Tasking.Task_A2G#TASK_A2G_SEAD - Models an A2G Suppression or Extermination of Air Defenses task to clean an area of air to ground defense threats.
---  - Tasking.Task_A2G#TASK_A2G_CAS - Models an A2G Close Air Support task to provide air support to nearby friendlies near the front-line.
---  - Tasking.Task_A2G#TASK_A2G_BAI - Models an A2G Battlefield Air Interdiction task to provide air support to nearby friendlies near the front-line.
---
---## 1.3) Cargo Tasks  
---
---  - Tasking.Task_CARGO#TASK_CARGO_TRANSPORT - Models the transportation of cargo to deployment zones. 
---  - Tasking.Task_CARGO#TASK_CARGO_CSAR - Models the rescue of downed friendly pilots from behind enemy lines.    
---
---
---# 2) Task status events.
---
---The task statuses can be set by using the following methods:
---
---  - #TASK.Success() - Set the task to **Success** state.
---  - #TASK.Fail() - Set the task to **Failed** state.
---  - #TASK.Hold() - Set the task to **Hold** state.
---  - #TASK.Abort() - Set the task to **Aborted** state, aborting the task. The task may be replanned.
---  - #TASK.Cancel() - Set the task to **Cancelled** state, cancelling the task.
---
---The mentioned derived TASK_ classes are implementing the task status transitions out of the box.
---So no extra logic needs to be written.
---  
---# 3) Goal conditions for a task.
---
---Every 30 seconds, a #Task.Goal trigger method is fired. 
---You as a mission designer, can capture the **Goal** event trigger to check your own task goal conditions and take action!
---
---## 3.1) Goal event handler `OnAfterGoal()`.
---
---And this is a really great feature! Imagine a task which has **several conditions to check** before the task can move into **Success** state.
---You can do this with the OnAfterGoal method.
---
---The following code provides an example of such a goal condition check implementation.
---
---     function Task:OnAfterGoal()
---       if condition == true then
---         self:Success() -- This will flag the task to Success when the condition is true.
---       else
---         if condition2 == true and condition3 == true then
---           self:Fail() -- This will flag the task to Failed, when condition2 and condition3 would be true.
---         end
---       end
---     end
---
---So the #TASK.OnAfterGoal() event handler would be called every 30 seconds automatically, 
---and within this method, you can now check the conditions and take respective action.
---
---## 3.2) Goal event trigger `Goal()`.
---
---If you would need to check a goal at your own defined event timing, then just call the #TASK.Goal() method within your logic.
---The #TASK.OnAfterGoal() event handler would then directly be called and would execute the logic. 
---Note that you can also delay the goal check by using the delayed event trigger syntax `:__Goal( Delay )`. 
---
---
---# 4) Score task completion.
---
---Upon reaching a certain task status in a task, additional scoring can be given. If the Mission has a scoring system attached, the scores will be added to the mission scoring.
---Use the method #TASK.AddScore() to add scores when a status is reached.
---
---# 5) Task briefing.
---
---A task briefing is a text that is shown to the player when he is assigned to the task.
---The briefing is broadcasted by the command center owning the mission.
---
---The briefing is part of the parameters in the #TASK.New() constructor, 
---but can separately be modified later in your mission using the
---#TASK.SetBriefing() method.
---@class TASK : FSM_TASK
---@field CommandCenter COMMANDCENTER 
---@field DetectedItem  
---@field Detection  
---@field Dispatcher  
---@field FlashTaskStatus  
---@field FsmTemplate FSM_PROCESS 
---@field Mission MISSION 
---@field SetGroup SET_GROUP The Set of Groups assigned to the Task
---@field TaskBriefing  
---@field TaskControlMenuTime  
---@field TaskID  
---@field TaskInfo TASKINFO 
---@field TaskName  
---@field TaskScheduler SCHEDULER 
---@field TaskType  
---@field TimeOut  
TASK = {}

---FSM Abort synchronous event function for TASK.
---Use this event to Abort the Task.
---
------
---@param self TASK 
function TASK:Abort() end

---A group aborting the task.
---
------
---@param self TASK 
---@param PlayerGroup GROUP The group aborting the task.
---@return TASK #
function TASK:AbortGroup(PlayerGroup) end

---Gets the SET_GROUP assigned to the TASK.
---
------
---@param self TASK 
---@param GroupSet SET_GROUP 
---@return SET_GROUP #
function TASK:AddGroups(GroupSet) end

---Add Task Progress for a Player Name
---
------
---@param self TASK 
---@param PlayerName string The name of the player.
---@param ProgressText string The text that explains the Progress achieved.
---@param ProgressTime number The time the progress was achieved.
---@param ProgressPoints NOTYPE 
---@return TASK #
function TASK:AddProgress(PlayerName, ProgressText, ProgressTime, ProgressPoints) end

---Assign the #TASK to a Wrapper.Group.
---
------
---@param self TASK 
---@param TaskGroup GROUP 
---@return TASK #
function TASK:AssignToGroup(TaskGroup) end

---Assign the #TASK to an alive Wrapper.Unit.
---
------
---@param self TASK 
---@param TaskUnit UNIT 
---@return TASK #self
function TASK:AssignToUnit(TaskUnit) end

---FSM Cancel synchronous event function for TASK.
---Use this event to Cancel the Task.
---
------
---@param self TASK 
function TASK:Cancel() end

---Clear the Wrapper.Group assignment from the #TASK.
---
------
---@param self TASK 
---@param TaskGroup GROUP 
---@return TASK #
function TASK:ClearGroupAssignment(TaskGroup) end

---A group crashing and thus aborting from the task.
---
------
---@param self TASK 
---@param PlayerGroup GROUP The group aborting the task.
---@return TASK #
function TASK:CrashGroup(PlayerGroup) end

---FSM Fail synchronous event function for TASK.
---Use this event to Fail the Task.
---
------
---@param self TASK 
function TASK:Fail() end


---
------
---@param self NOTYPE 
---@param TaskUnitName NOTYPE 
function TASK:FailProcesses(TaskUnitName) end

---Gets the #TASK briefing.
---
------
---@param self TASK 
---@return string #The briefing text.
function TASK:GetBriefing() end

---Get goal of a task
---
------
---@param self TASK 
---@return GOAL #The Goal
function TASK:GetGoal() end

---Gets the SET_GROUP assigned to the TASK.
---
------
---@param self TASK 
---@return SET_GROUP #
function TASK:GetGroups() end

---Gets the ID of the Task
---
------
---@param self TASK 
---@return string #TaskID
function TASK:GetID() end

---Gets the Mission to where the TASK belongs.
---
------
---@param self TASK 
---@return MISSION #
function TASK:GetMission() end

---Gets the Name of the Task
---
------
---@param self TASK 
---@return string #The Task Name
function TASK:GetName() end

---Create a count of the players in the Task.
---
------
---@param self TASK 
---@return number #The total number of players in the task.
function TASK:GetPlayerCount() end

---Create a list of the players in the Task.
---
------
---@param self TASK 
---@return map #A map of the players
function TASK:GetPlayerNames() end


---
------
---@param self NOTYPE 
---@param PlayerName NOTYPE 
function TASK:GetPlayerProgress(PlayerName) end

---Get the default or currently assigned Core.Fsm#FSM_PROCESS template with key ProcessName.
---
------
---@param self TASK 
---@param ProcessName string 
---@return FSM_PROCESS #
function TASK:GetProcessTemplate(ProcessName) end

---Gets the Scoring of the task
---
------
---@param self TASK 
---@return SCORING #Scoring
function TASK:GetScoring() end

---Gets the FiniteStateMachine of #TASK with key Wrapper.Unit.
---
------
---@param self TASK 
---@param TaskUnit UNIT 
---@return FSM_PROCESS #
function TASK:GetStateMachine(TaskUnit) end

---Gets the #TASK status.
---
------
---@param self TASK 
function TASK:GetStateString() end

---Returns the #TASK briefing.
---
------
---@param self TASK 
---@return string #Task briefing.
function TASK:GetTaskBriefing() end

---Get Task Control Menu
---
------
---@param self TASK 
---@param TaskUnit UNIT The @{Wrapper.Unit} that contains a player.
---@param TaskName NOTYPE 
---@return MENU_GROUP #TaskControlMenu The Task Control Menu
function TASK:GetTaskControlMenu(TaskUnit, TaskName) end

---Gets the Task Index, which is a combination of the Task type, the Task name.
---
------
---@param self TASK 
---@return string #The Task ID
function TASK:GetTaskIndex() end

---Returns the #TASK name.
---
------
---@param self TASK 
---@return string #TaskName
function TASK:GetTaskName() end

---Gets the Type of the Task
---
------
---@param self TASK 
---@return string #TaskType
function TASK:GetType() end

---Get the Task FSM Process Template
---
------
---@param self TASK 
---@param TaskUnit NOTYPE 
---@return FSM_PROCESS #
function TASK:GetUnitProcess(TaskUnit) end

---Goal Trigger for TASK
---
------
---@param self TASK 
---@param PlayerUnit UNIT The @{Wrapper.Unit} of the player.
---@param PlayerName string The name of the player.
function TASK:Goal(PlayerUnit, PlayerName) end

---Returns if the #TASK has still alive and assigned Units.
---
------
---@param self TASK 
---@return boolean #
function TASK:HasAliveUnits() end


---
------
---@param self TASK 
---@param FindGroup GROUP 
---@return boolean #
function TASK:HasGroup(FindGroup) end

---Checks if there is a FiniteStateMachine assigned to Wrapper.Unit for #TASK.
---
------
---@param self TASK 
---@param TaskUnit UNIT 
---@return TASK #self
function TASK:HasStateMachine(TaskUnit) end

---Init Task Control Menu
---
------
---@param self TASK 
---@param TaskUnit UNIT The @{Wrapper.Unit} that contains a player.
---@return  #Task Control Menu Refresh ID
function TASK:InitTaskControlMenu(TaskUnit) end

---Returns if the #TASK is assigned to the Group.
---
------
---@param self TASK 
---@param TaskGroup GROUP 
---@return boolean #
function TASK:IsGroupAssigned(TaskGroup) end

---Is the #TASK status **Aborted**.
---
------
---@param self TASK 
function TASK:IsStateAborted() end

---Is the #TASK status **Assigned**.
---
------
---@param self TASK 
function TASK:IsStateAssigned() end

---Is the #TASK status **Cancelled**.
---
------
---@param self TASK 
function TASK:IsStateCancelled() end

---Is the #TASK status **Failed**.
---
------
---@param self TASK 
function TASK:IsStateFailed() end

---Is the #TASK status **Hold**.
---
------
---@param self TASK 
function TASK:IsStateHold() end

---Is the #TASK status **Planned**.
---
------
---@param self TASK 
function TASK:IsStatePlanned() end

---Is the #TASK status **Replanned**.
---
------
---@param self TASK 
function TASK:IsStateReplanned() end

---Is the #TASK status **Success**.
---
------
---@param self TASK 
function TASK:IsStateSuccess() end

---Add a PlayerUnit to join the Task.
---For each Group within the Task, the Unit is checked if it can join the Task.
---If the Unit was not part of the Task, false is returned.
---If the Unit is part of the Task, true is returned.
---
------
---@param self TASK 
---@param PlayerUnit UNIT The CLIENT or UNIT of the Player joining the Mission.
---@param PlayerGroup GROUP The GROUP of the player joining the Mission.
---@return boolean #true if Unit is part of the Task.
function TASK:JoinUnit(PlayerUnit, PlayerGroup) end


---
------
---@param self NOTYPE 
---@param TaskGroup NOTYPE 
function TASK:MenuAssignToGroup(TaskGroup) end

---Report the task status.
---
------
---@param self TASK 
---@param TaskGroup NOTYPE 
---@param Flash NOTYPE 
function TASK:MenuFlashTaskStatus(TaskGroup, Flash) end


---
------
---@param self NOTYPE 
---@param TaskGroup NOTYPE 
function TASK:MenuMarkToGroup(TaskGroup) end

---Report the task status.
---
------
---@param self TASK 
---@param TaskGroup NOTYPE 
function TASK:MenuTaskAbort(TaskGroup) end

---Report the task status.
---
------
---@param self TASK 
---@param TaskGroup GROUP 
function TASK:MenuTaskStatus(TaskGroup) end

---Send a message of the #TASK to the assigned Wrapper.Groups.
---
------
---@param self TASK 
---@param Message NOTYPE 
function TASK:MessageToGroups(Message) end

---Instantiates a new TASK.
---Should never be used. Interface Class.
---
------
---@param self TASK 
---@param Mission MISSION The mission wherein the Task is registered.
---@param SetGroupAssign SET_GROUP The set of groups for which the Task can be assigned.
---@param TaskName string The name of the Task
---@param TaskType string The type of the Task
---@param TaskBriefing NOTYPE 
---@return TASK #self
function TASK:New(Mission, SetGroupAssign, TaskName, TaskType, TaskBriefing) end

---Goal Handler OnAfter for TASK
---
------
---@param self TASK 
---@param From string 
---@param Event string 
---@param To string 
---@param PlayerUnit UNIT The @{Wrapper.Unit} of the player.
---@param PlayerName string The name of the player.
function TASK:OnAfterGoal(From, Event, To, PlayerUnit, PlayerName) end

---FSM PlayerAborted event handler prototype for TASK.
---
------
---@param self TASK 
---@param PlayerUnit UNIT The Unit of the Player when he went back to spectators or left the mission.
---@param PlayerName string The name of the Player.
function TASK:OnAfterPlayerAborted(PlayerUnit, PlayerName) end

---FSM PlayerCrashed event handler prototype for TASK.
---
------
---@param self TASK 
---@param PlayerUnit UNIT The Unit of the Player when he crashed in the mission.
---@param PlayerName string The name of the Player.
function TASK:OnAfterPlayerCrashed(PlayerUnit, PlayerName) end

---FSM PlayerDead event handler prototype for TASK.
---
------
---@param self TASK 
---@param PlayerUnit UNIT The Unit of the Player when he died in the mission.
---@param PlayerName string The name of the Player.
function TASK:OnAfterPlayerDead(PlayerUnit, PlayerName) end

---Goal Handler OnBefore for TASK
---
------
---@param self TASK 
---@param From string 
---@param Event string 
---@param To string 
---@param PlayerUnit UNIT The @{Wrapper.Unit} of the player.
---@param PlayerName string The name of the player.
---@return boolean #
function TASK:OnBeforeGoal(From, Event, To, PlayerUnit, PlayerName) end

---Remove the menu option of the #TASK for a Wrapper.Group.
---
------
---@param self TASK 
---@param TaskGroup GROUP 
---@param MenuTime number 
---@return TASK #self
function TASK:RefreshMenus(TaskGroup, MenuTime) end

---Refresh Task Control Menu
---
------
---@param self TASK 
---@param TaskUnit UNIT The @{Wrapper.Unit} that contains a player.
---@param MenuTime NOTYPE The refresh time that was used to refresh the Task Control Menu items.
---@param MenuTag NOTYPE The tag.
function TASK:RefreshTaskControlMenu(TaskUnit, MenuTime, MenuTag) end

---A group rejecting a planned task.
---
------
---@param self TASK 
---@param PlayerGroup GROUP The group rejecting the task.
---@return TASK #
function TASK:RejectGroup(PlayerGroup) end

---Remove the assigned menu option of the #TASK for a Wrapper.Group.
---
------
---@param self TASK 
---@param TaskGroup GROUP 
---@param MenuTime number 
---@return TASK #self
function TASK:RemoveAssignedMenuForGroup(TaskGroup, MenuTime) end

---Remove the menu options of the #TASK to all the groups in the SetGroup.
---
------
---@param self TASK 
---@param MenuTime number 
---@return TASK #
function TASK:RemoveMenu(MenuTime) end

---Remove FiniteStateMachines from #TASK with key Wrapper.Unit.
---
------
---@param self TASK 
---@param TaskUnit UNIT 
---@return TASK #self
function TASK:RemoveStateMachine(TaskUnit) end

---Remove Task Control Menu
---
------
---@param self TASK 
---@param TaskUnit UNIT The @{Wrapper.Unit} that contains a player.
function TASK:RemoveTaskControlMenu(TaskUnit) end

---FSM Replan synchronous event function for TASK.
---Use this event to Replan the Task.
---
------
---@param self TASK 
function TASK:Replan() end

---Create a detailed report of the Task.
---List the Task Status, and the Players assigned to the Task.
---
------
---@param self TASK 
---@param TaskGroup GROUP 
---@param ReportGroup NOTYPE 
---@return string #
function TASK:ReportDetails(TaskGroup, ReportGroup) end

---Create an overiew report of the Task.
---List the Task Name and Status
---
------
---@param self TASK 
---@param ReportGroup NOTYPE 
---@return string #
function TASK:ReportOverview(ReportGroup) end

---Create a summary report of the Task.
---List the Task Name and Status
---
------
---@param self TASK 
---@param ReportGroup GROUP 
---@return string #
function TASK:ReportSummary(ReportGroup) end

---Send the briefing message of the #TASK to the assigned Wrapper.Groups.
---
------
---@param self TASK 
function TASK:SendBriefingToAssignedGroups() end


---
------
---@param self NOTYPE 
---@param AcceptClass NOTYPE 
function TASK:SetAssignMethod(AcceptClass) end

---Set the assigned menu options of the #TASK.
---
------
---@param self TASK 
---@param TaskGroup GROUP 
---@param MenuTime number 
---@return TASK #self
function TASK:SetAssignedMenuForGroup(TaskGroup, MenuTime) end

---Sets a #TASK briefing.
---
------
---@param self TASK 
---@param TaskBriefing string 
---@return TASK #self
function TASK:SetBriefing(TaskBriefing) end

---Set detection of a task
---
------
---@param self TASK 
---@param Detection DETECTION_BASE 
---@param DetectedItem NOTYPE 
---@return TASK #
function TASK:SetDetection(Detection, DetectedItem) end

---Set dispatcher of a task
---
------
---@param self TASK 
---@param Dispatcher DETECTION_MANAGER 
---@return TASK #
function TASK:SetDispatcher(Dispatcher) end

---Set goal of a task
---
------
---@param self TASK 
---@param Goal GOAL 
---@return TASK #
function TASK:SetGoal(Goal) end

---Set Wrapper.Group assigned to the #TASK.
---
------
---@param self TASK 
---@param TaskGroup GROUP 
---@return TASK #
function TASK:SetGroupAssigned(TaskGroup) end

---Sets the ID of the Task
---
------
---@param self TASK 
---@param TaskID string 
function TASK:SetID(TaskID) end

---Set the menu options of the #TASK to all the groups in the SetGroup.
---
------
---@param self TASK 
---@param MenuTime number 
---@return TASK #
function TASK:SetMenu(MenuTime) end

---Set the Menu for a Group
---
------
---@param self TASK 
---@param MenuTime number 
---@param TaskGroup NOTYPE 
---@return TASK #
function TASK:SetMenuForGroup(MenuTime, TaskGroup) end

---Sets the Name of the Task
---
------
---@param self TASK 
---@param TaskName string 
function TASK:SetName(TaskName) end

---Set the planned menu option of the #TASK.
---
------
---@param self TASK 
---@param TaskGroup GROUP 
---@param MenuText string The menu text.
---@param MenuTime number 
---@return TASK #self
function TASK:SetPlannedMenuForGroup(TaskGroup, MenuText, MenuTime) end

---Set a penalty when the A2A attack has failed.
---
------
---@param self TASK 
---@param PlayerName string The name of the player.
---@param Penalty number The penalty in points, must be a negative value!
---@param TaskUnit UNIT 
---@return TASK #
function TASK:SetScoreOnFail(PlayerName, Penalty, TaskUnit) end

---Set a score when progress has been made by the player.
---
------
---@param self TASK 
---@param PlayerName string The name of the player.
---@param Score number The score in points to be granted when task process has been achieved.
---@param TaskUnit UNIT 
---@return TASK #
function TASK:SetScoreOnProgress(PlayerName, Score, TaskUnit) end

---Set a score when all the targets in scope of the A2A attack, have been destroyed.
---
------
---@param self TASK 
---@param PlayerName string The name of the player.
---@param Score number The score in points.
---@param TaskUnit UNIT 
---@return TASK #
function TASK:SetScoreOnSuccess(PlayerName, Score, TaskUnit) end

---Add a FiniteStateMachine to #TASK with key Wrapper.Unit.
---
------
---@param self TASK 
---@param TaskUnit UNIT 
---@param Fsm FSM_PROCESS 
---@return TASK #self
function TASK:SetStateMachine(TaskUnit, Fsm) end

---Sets the TimeOut for the #TASK.
---If #TASK stayed planned for longer than TimeOut, it gets into Cancelled status.
---
------
---@param self TASK 
---@param Timer integer in seconds
---@return TASK #self
function TASK:SetTimeOut(Timer) end

---Sets the Type of the Task
---
------
---@param self TASK 
---@param TaskType string 
function TASK:SetType(TaskType) end

---Sets the Task FSM Process Template
---
------
---@param self TASK 
---@param Core NOTYPE Fsm#FSM_PROCESS
---@param FsmTemplate NOTYPE 
function TASK:SetUnitProcess(Core, FsmTemplate) end

---Sets a #TASK to status **Aborted**.
---
------
---@param self TASK 
function TASK:StateAborted() end

---Sets a #TASK to status **Assigned**.
---
------
---@param self TASK 
function TASK:StateAssigned() end

---Sets a #TASK to status **Cancelled**.
---
------
---@param self TASK 
function TASK:StateCancelled() end

---Sets a #TASK to status **Failed**.
---
------
---@param self TASK 
function TASK:StateFailed() end

---Sets a #TASK to status **Hold**.
---
------
---@param self TASK 
function TASK:StateHold() end

---Sets a #TASK to status **Planned**.
---
------
---@param self TASK 
function TASK:StatePlanned() end

---Sets a #TASK to status **Replanned**.
---
------
---@param self TASK 
function TASK:StateReplanned() end

---Sets a #TASK to status **Success**.
---
------
---@param self TASK 
function TASK:StateSuccess() end

---FSM Success synchronous event function for TASK.
---Use this event to make the Task a Success.
---
------
---@param self TASK 
function TASK:Success() end

---UnAssign the #TASK from a Wrapper.Group.
---
------
---@param self TASK 
---@param TaskGroup GROUP 
function TASK:UnAssignFromGroup(TaskGroup) end

---UnAssign the #TASK from the Wrapper.Groups.
---
------
---@param self TASK 
function TASK:UnAssignFromGroups() end

---UnAssign the #TASK from an alive Wrapper.Unit.
---
------
---@param self TASK 
---@param TaskUnit UNIT 
---@return TASK #self
function TASK:UnAssignFromUnit(TaskUnit) end

---FSM Abort asynchronous event function for TASK.
---Use this event to Abort the Task.
---
------
---@param self TASK 
function TASK:__Abort() end

---FSM Cancel asynchronous event function for TASK.
---Use this event to Cancel the Task.
---
------
---@param self TASK 
function TASK:__Cancel() end

---FSM Fail asynchronous event function for TASK.
---Use this event to Fail the Task.
---
------
---@param self TASK 
function TASK:__Fail() end

---Goal Asynchronous Trigger for TASK
---
------
---@param self TASK 
---@param Delay number 
---@param PlayerUnit UNIT The @{Wrapper.Unit} of the player.
---@param PlayerName string The name of the player.
function TASK:__Goal(Delay, PlayerUnit, PlayerName) end

---FSM Replan asynchronous event function for TASK.
---Use this event to Replan the Task.
---
------
---@param self TASK 
function TASK:__Replan() end

---FSM Success asynchronous event function for TASK.
---Use this event to make the Task a Success.
---
------
---@param self TASK 
function TASK:__Success() end

---FSM function for a TASK
---
------
---@param self TASK 
---@param From string 
---@param Event string 
---@param To string 
function TASK:onafterReplan(From, Event, To) end

---FSM function for a TASK
---
------
---@param self TASK 
---@param Event string 
---@param From string 
---@param To string 
function TASK:onbeforeTimeOut(Event, From, To) end

---FSM function for a TASK
---
------
---@param self TASK 
---@param From string 
---@param Event string 
---@param To string 
function TASK:onenterAborted(From, Event, To) end

---FSM function for a TASK
---
------
---@param self TASK 
---@param Event string 
---@param From string 
---@param To string 
---@param PlayerUnit NOTYPE 
---@param PlayerName NOTYPE 
function TASK:onenterAssigned(Event, From, To, PlayerUnit, PlayerName) end

---FSM function for a TASK
---
------
---@param self TASK 
---@param From string 
---@param Event string 
---@param To string 
function TASK:onenterCancelled(From, Event, To) end

---FSM function for a TASK
---
------
---@param self TASK 
---@param From string 
---@param Event string 
---@param To string 
function TASK:onenterFailed(From, Event, To) end

---FSM function for a TASK
---
------
---@param self TASK 
---@param Event string 
---@param From string 
---@param To string 
function TASK:onenterPlanned(Event, From, To) end

---FSM function for a TASK
---
------
---@param self TASK 
---@param Event string 
---@param From string 
---@param To string 
function TASK:onenterSuccess(Event, From, To) end

---FSM function for a TASK
---
------
---@param self TASK 
---@param Event string 
---@param From string 
---@param To string 
function TASK:onstatechange(Event, From, To) end



