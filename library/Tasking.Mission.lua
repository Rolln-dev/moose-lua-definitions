---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Task_Mission.JPG" width="100%">
---
---**Tasking** - A mission models a goal to be achieved through the execution and completion of tasks by human players.
---
---**Features:**
---
---  * A mission has a goal to be achieved, through the execution and completion of tasks of different categories by human players.
---  * A mission manages these tasks.
---  * A mission has a state, that indicates the fase of the mission.
---  * A mission has a menu structure, that facilitates mission reports and tasking menus.
---  * A mission can assign a task to a player.
---
---===
---
---### Author: **FlightControl**
---
---### Contributions: 
---
---===
---Models goals to be achieved and can contain multiple tasks to be executed to achieve the goals.
---
---![Banner Image](..\Images\deprecated.png)
---
---A mission contains multiple tasks and can be of different task types.
---These tasks need to be assigned to human players to be executed.
---
---A mission can have multiple states, which will evolve as the mission progresses during the DCS simulation.
---
---  - **IDLE**: The mission is defined, but not started yet. No task has yet been joined by a human player as part of the mission.
---  - **ENGAGED**: The mission is ongoing, players have joined tasks to be executed.
---  - **COMPLETED**: The goals of the mission has been successfully reached, and the mission is flagged as completed.
---  - **FAILED**: For a certain reason, the goals of the mission has not been reached, and the mission is flagged as failed.
---  - **HOLD**: The mission was enaged, but for some reason it has been put on hold.
---  
---Note that a mission goals need to be checked by a goal check trigger: #MISSION.OnBeforeMissionGoals(), which may return false if the goal has not been reached.
---This goal is checked automatically by the mission object every x seconds.
---
---  - #MISSION.Start() or #MISSION.__Start() will start the mission, and will bring it from **IDLE** state to **ENGAGED** state.
---  - #MISSION.Stop() or #MISSION.__Stop() will stop the mission, and will bring it from **ENGAGED** state to **IDLE** state.
---  - #MISSION.Complete() or #MISSION.__Complete() will complete the mission, and will bring the mission state to **COMPLETED**.
---    Note that the mission must be in state **ENGAGED** to be able to complete the mission.
---  - #MISSION.Fail() or #MISSION.__Fail() will fail the mission, and will bring the mission state to **FAILED**.
---    Note that the mission must be in state **ENGAGED** to be able to fail the mission.
---  - #MISSION.Hold() or #MISSION.__Hold() will hold the mission, and will bring the mission state to **HOLD**.
---    Note that the mission must be in state **ENGAGED** to be able to hold the mission.
---    Re-engage the mission using the engage trigger.
---
---The following sections provide an overview of the most important methods that can be used as part of a mission object.
---Note that the Tasking.CommandCenter system is using most of these methods to manage the missions in its system.
---
---## 1. Create a mission object.
---
---  - #MISSION.New(): Creates a new MISSION object.
---
---## 2. Mission task management.
---
---Missions maintain tasks, which can be added or removed, or enquired.
---
---  - #MISSION.AddTask(): Adds a task to the mission.
---  - #MISSION.RemoveTask(): Removes a task from the mission.
---
---## 3. Mission detailed methods.
---
---Various methods are added to manage missions.
---
---### 3.1. Naming and description.
---
---There are several methods that can be used to retrieve the properties of a mission:
---
---  - Use the method #MISSION.GetName() to retrieve the name of the mission. 
---    This is the name given as part of the #MISSION.New() constructor.
---
---A textual description can be retrieved that provides the mission name to be used within message communication:
---
---  - #MISSION.GetShortText() returns the mission name as `Mission "MissionName"`.
---  - #MISSION.GetText() returns the mission  name as `Mission "MissionName (MissionPriority)"`. A longer version including the priority text of the mission.
---
---### 3.2. Get task information.
---
---  - #MISSION.GetTasks(): Retrieves a list of the tasks controlled by the mission.
---  - #MISSION.GetTask(): Retrieves a specific task controlled by the mission.
---  - #MISSION.GetTasksRemaining(): Retrieve a list of the tasks that aren't finished or failed, and are governed by the mission.
---  - #MISSION.GetGroupTasks(): Retrieve a list of the tasks that can be assigned to a Wrapper.Group.
---  - #MISSION.GetTaskTypes(): Retrieve a list of the different task types governed by the mission.
---
---### 3.3. Get the command center.
---
---  - #MISSION.GetCommandCenter(): Retrieves the Tasking.CommandCenter governing the mission.
---
---### 3.4. Get the groups active in the mission as a Core.Set.
---
---  - #MISSION.GetGroups(): Retrieves a Core.Set#SET_GROUP of all the groups active in the mission (as part of the tasks).
---  
---### 3.5. Get the names of the players.
---
---  - #MISSION.GetPlayerNames(): Retrieves the list of the players that were active within th mission..
---
---## 4. Menu management.
---
---A mission object is able to manage its own menu structure. Use the #MISSION.GetMenu() and #MISSION.SetMenu() to manage the underlying submenu
---structure managing the tasks of the mission.
---
---## 5. Reporting management.
--- 
---Several reports can be generated for a mission, and will return a text string that can be used to display using the Core.Message system.
---
---  - #MISSION.ReportBriefing(): Generates the briefing for the mission.
---  - #MISSION.ReportOverview(): Generates an overview of the tasks and status of the mission.
---  - #MISSION.ReportDetails(): Generates a detailed report of the tasks of the mission.
---  - #MISSION.ReportSummary(): Generates a summary report of the tasks of the mission.
---  - #MISSION.ReportPlayersPerTask(): Generates a report showing the active players per task.
---  - #MISSION.ReportPlayersProgress(): Generates a report showing the task progress per player.
---
---
---# Developer Note
---
---Note while this class still works, it is no longer supported as the original author stopped active development of MOOSE
---Therefore, this class is considered to be deprecated
---@deprecated
---@class MISSION : FSM
---@field MissionBriefing string 
---@field MissionMenu MENU_COALITION 
---@field Scoring  
MISSION = {}

---Aborts a PlayerUnit from the Mission.
---For each Task within the Mission, the PlayerUnit is removed from Task where it is assigned.
---If the Unit was not part of a Task in the Mission, false is returned.
---If the Unit is part of a Task in the Mission, true is returned.
---
------
---@param self MISSION 
---@param PlayerUnit UNIT The CLIENT or UNIT of the Player joining the Mission.
---@return MISSION #
function MISSION:AbortUnit(PlayerUnit) end

---Adds the groups for which TASKS are given in the mission
---
------
---@param self MISSION 
---@param GroupSet SET_GROUP 
---@return SET_GROUP #
function MISSION:AddGroups(GroupSet) end


---
------
---@param self NOTYPE 
---@param PlayerName NOTYPE 
function MISSION:AddPlayerName(PlayerName) end

---Add a scoring to the mission.
---
------
---@param self MISSION 
---@param Scoring NOTYPE 
---@return MISSION #self
function MISSION:AddScoring(Scoring) end

---Register a Tasking.Task to be completed within the Tasking.Mission.
---Note that there can be multiple Tasking.Tasks registered to be completed. 
---Each Task can be set a certain Goals. The Mission will not be completed until all Goals are reached.
---
------
---@param self MISSION 
---@param Task TASK is the @{Tasking.Task} object.
---@return TASK #The task added.
function MISSION:AddTask(Task) end

---Clear the Wrapper.Group assignment from the Tasking.Mission.
---
------
---@param self MISSION 
---@param MissionGroup GROUP 
---@return MISSION #
function MISSION:ClearGroupAssignment(MissionGroup) end

---Synchronous Event Trigger for Event Complete.
---
------
---@param self MISSION 
function MISSION:Complete() end

---Handles a crash of a PlayerUnit from the Mission.
---For each Task within the Mission, the PlayerUnit is removed from Task where it is assigned.
---If the Unit was not part of a Task in the Mission, false is returned.
---If the Unit is part of a Task in the Mission, true is returned.
---
------
---@param self MISSION 
---@param PlayerUnit UNIT The CLIENT or UNIT of the Player crashing.
---@return MISSION #
function MISSION:CrashUnit(PlayerUnit) end

---Synchronous Event Trigger for Event Fail.
---
------
---@param self MISSION 
function MISSION:Fail() end

---Gets the COMMANDCENTER.
---
------
---@param self MISSION 
---@return COMMANDCENTER #
function MISSION:GetCommandCenter() end

---Get the relevant tasks of a TaskGroup.
---
------
---@param TaskGroup GROUP 
---@param self NOTYPE 
---@return list #
function MISSION.GetGroupTasks(TaskGroup, self) end

---Gets the groups for which TASKS are given in the mission
---
------
---@param self MISSION 
---@param GroupSet SET_GROUP 
---@return SET_GROUP #
function MISSION:GetGroups(GroupSet) end

---Gets the mission menu for the TaskGroup.
---
------
---@param self MISSION 
---@param TaskGroup GROUP Task group.
---@return MENU_COALITION #self
function MISSION:GetMenu(TaskGroup) end

---Gets the mission name.
---
------
---@param self MISSION 
---@return MISSION #self
function MISSION:GetName() end

---Return the next Tasking.Task ID to be completed within the Tasking.Mission.
---
------
---@param self MISSION 
---@param Task TASK is the @{Tasking.Task} object.
---@return TASK #The task added.
function MISSION:GetNextTaskID(Task) end


---
------
---@param self NOTYPE 
function MISSION:GetPlayerNames() end

---Gets the root mission menu for the TaskGroup.
---Obsolete?! Originally no reference to TaskGroup parameter!
---
------
---@param self MISSION 
---@param TaskGroup GROUP Task group.
---@return MENU_COALITION #self
function MISSION:GetRootMenu(TaskGroup) end

---Get the scoring object of a mission.
---
------
---@param self MISSION 
---@return SCORING #Scoring
function MISSION:GetScoring() end

---Gets the short mission text.
---
------
---@param self MISSION 
---@return MISSION #self
function MISSION:GetShortText() end

---Get the TASK identified by the TaskNumber from the Mission.
---This function is useful in GoalFunctions.
---
------
---@param TaskName string The Name of the @{Tasking.Task} within the @{Tasking.Mission}.
---@param self NOTYPE 
---@return TASK #The Task
---@return nil #Returns nil if no task was found.
function MISSION.GetTask(TaskName, self) end


---
------
---@param self NOTYPE 
function MISSION:GetTaskTypes() end

---Get all the TASKs from the Mission.
---This function is useful in GoalFunctions.
---
------
---
---USAGE
---```
----- Get Tasks from the Mission.
---Tasks = Mission:GetTasks()
---env.info( "Task 2 Completion = " .. Tasks[2]:GetGoalPercentage() .. "%" )
---```
------
---@param self NOTYPE 
---@return  #{TASK,...} Structure of TASKS with the @{Tasking.Task#TASK} number as the key.
function MISSION:GetTasks() end


---
------
---@param self NOTYPE 
function MISSION:GetTasksRemaining() end

---Gets the mission text.
---
------
---@param self MISSION 
---@return MISSION #self
function MISSION:GetText() end

---Validates if the Mission has a Group
---
------
---@param self NOTYPE 
---@param TaskGroup NOTYPE 
---@return boolean #true if the Mission has a Group.
function MISSION:HasGroup(TaskGroup) end

---Is the Tasking.Mission **COMPLETED**.
---
------
---@param self MISSION 
---@return boolean #
function MISSION:IsCOMPLETED() end

---Is the Tasking.Mission **ENGAGED**.
---
------
---@param self MISSION 
---@return boolean #
function MISSION:IsENGAGED() end

---Is the Tasking.Mission **FAILED**.
---
------
---@param self MISSION 
---@return boolean #
function MISSION:IsFAILED() end

---Returns if the Tasking.Mission is assigned to the Group.
---
------
---@param self MISSION 
---@param MissionGroup GROUP 
---@return boolean #
function MISSION:IsGroupAssigned(MissionGroup) end

---Is the Tasking.Mission **HOLD**.
---
------
---@param self MISSION 
---@return boolean #
function MISSION:IsHOLD() end

---Is the Tasking.Mission **IDLE**.
---
------
---@param self MISSION 
---@return boolean #
function MISSION:IsIDLE() end

---Add a Unit to join the Mission.
---For each Task within the Mission, the Unit is joined with the Task.
---If the Unit was not part of a Task in the Mission, false is returned.
---If the Unit is part of a Task in the Mission, true is returned.
---
------
---@param self MISSION 
---@param PlayerUnit UNIT The CLIENT or UNIT of the Player joining the Mission.
---@param PlayerGroup GROUP The GROUP of the player joining the Mission.
---@return boolean #true if Unit is part of a Task in the Mission.
function MISSION:JoinUnit(PlayerUnit, PlayerGroup) end

---Mark all the target locations on the Map.
---
------
---@param self MISSION 
---@param ReportGroup GROUP 
---@return string #
function MISSION:MarkTargetLocations(ReportGroup) end

---Mark all the targets of the Mission on the Map.
---
------
---@param self MISSION 
---@param ReportGroup GROUP 
function MISSION:MenuMarkTargetLocations(ReportGroup) end

---Reports the briefing.
---
------
---@param self MISSION 
---@param ReportGroup GROUP The group to which the report needs to be sent.
function MISSION:MenuReportBriefing(ReportGroup) end


---
------
---@param self NOTYPE 
---@param ReportGroup NOTYPE 
function MISSION:MenuReportPlayersPerTask(ReportGroup) end


---
------
---@param self NOTYPE 
---@param ReportGroup NOTYPE 
function MISSION:MenuReportPlayersProgress(ReportGroup) end


---
------
---@param self NOTYPE 
---@param ReportGroup NOTYPE 
---@param TaskStatus NOTYPE 
function MISSION:MenuReportTasksPerStatus(ReportGroup, TaskStatus) end

---Report the task summary.
---
------
---@param self MISSION 
---@param ReportGroup GROUP 
function MISSION:MenuReportTasksSummary(ReportGroup) end

---MissionGoals Trigger for MISSION
---
------
---@param self MISSION 
function MISSION:MissionGoals() end

---This is the main MISSION declaration method.
---Each Mission is like the master or a Mission orchestration between, Clients, Tasks, Stages etc.
---
------
---@param self MISSION 
---@param CommandCenter COMMANDCENTER 
---@param MissionName string Name of the mission. This name will be used to reference the status of each mission by the players.
---@param MissionPriority string String indicating the "priority" of the Mission. e.g. "Primary", "Secondary". It is free format and up to the Mission designer to choose. There are no rules behind this field.
---@param MissionBriefing string String indicating the mission briefing to be shown when a player joins a @{Wrapper.Client#CLIENT}.
---@param MissionCoalition coalition.side Side of the coalition, i.e. and enumerator @{#DCS.coalition.side} corresponding to RED, BLUE or NEUTRAL.
---@return MISSION #self
function MISSION:New(CommandCenter, MissionName, MissionPriority, MissionBriefing, MissionCoalition) end

---OnAfter Transition Handler for Event Complete.
---
------
---@param self MISSION 
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function MISSION:OnAfterComplete(From, Event, To) end

---OnAfter Transition Handler for Event Fail.
---
------
---@param self MISSION 
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function MISSION:OnAfterFail(From, Event, To) end

---MissionGoals Handler OnAfter for MISSION
---
------
---@param self MISSION 
---@param From string 
---@param Event string 
---@param To string 
function MISSION:OnAfterMissionGoals(From, Event, To) end

---OnAfter Transition Handler for Event Start.
---
------
---@param self MISSION 
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function MISSION:OnAfterStart(From, Event, To) end

---OnAfter Transition Handler for Event Stop.
---
------
---@param self MISSION 
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function MISSION:OnAfterStop(From, Event, To) end

---OnBefore Transition Handler for Event Complete.
---
------
---@param self MISSION 
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function MISSION:OnBeforeComplete(From, Event, To) end

---OnBefore Transition Handler for Event Fail.
---
------
---@param self MISSION 
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function MISSION:OnBeforeFail(From, Event, To) end

---MissionGoals Handler OnBefore for MISSION
---
------
---@param self MISSION 
---@param From string 
---@param Event string 
---@param To string 
---@return boolean #
function MISSION:OnBeforeMissionGoals(From, Event, To) end

---OnBefore Transition Handler for Event Start.
---
------
---@param self MISSION 
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function MISSION:OnBeforeStart(From, Event, To) end

---OnBefore Transition Handler for Event Stop.
---
------
---@param self MISSION 
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function MISSION:OnBeforeStop(From, Event, To) end

---OnEnter Transition Handler for State COMPLETED.
---
------
---@param self MISSION 
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function MISSION:OnEnterCOMPLETED(From, Event, To) end

---OnEnter Transition Handler for State ENGAGED.
---
------
---@param self MISSION 
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function MISSION:OnEnterENGAGED(From, Event, To) end

---OnEnter Transition Handler for State FAILED.
---
------
---@param self MISSION 
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function MISSION:OnEnterFAILED(From, Event, To) end

---OnEnter Transition Handler for State IDLE.
---
------
---@param self MISSION 
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function MISSION:OnEnterIDLE(From, Event, To) end

---OnLeave Transition Handler for State COMPLETED.
---
------
---@param self MISSION 
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function MISSION:OnLeaveCOMPLETED(From, Event, To) end

---OnLeave Transition Handler for State ENGAGED.
---
------
---@param self MISSION 
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function MISSION:OnLeaveENGAGED(From, Event, To) end

---OnLeave Transition Handler for State FAILED.
---
------
---@param self MISSION 
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function MISSION:OnLeaveFAILED(From, Event, To) end

---OnLeave Transition Handler for State IDLE.
---
------
---@param self MISSION 
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function MISSION:OnLeaveIDLE(From, Event, To) end

---Removes the Planned Task menu.
---
------
---@param self MISSION 
---@param MenuTime number 
function MISSION:RemoveMenu(MenuTime) end

---Removes a Tasking.Task to be completed within the Tasking.Mission.
---Note that there can be multiple Tasking.Tasks registered to be completed. 
---Each Task can be set a certain Goals. The Mission will not be completed until all Goals are reached.
---
------
---@param self MISSION 
---@param Task TASK is the @{Tasking.Task} object.
---@return nil #The cleaned Task reference.
function MISSION:RemoveTask(Task) end

---Removes a Task menu.
---
------
---@param self MISSION 
---@param Task TASK 
---@return MISSION #self
function MISSION:RemoveTaskMenu(Task) end

---Create a briefing report of the Mission.
---
------
---@param self MISSION 
---@return string #
function MISSION:ReportBriefing() end

---Create a detailed report of the Mission, listing all the details of the Task.
---
------
---@param self MISSION 
---@param ReportGroup NOTYPE 
---@return string #
function MISSION:ReportDetails(ReportGroup) end

---Create a overview report of the Mission (multiple lines).
---
------
---@param self MISSION 
---@param ReportGroup NOTYPE 
---@param TaskStatus NOTYPE 
---@return string #
function MISSION:ReportOverview(ReportGroup, TaskStatus) end

---Create an active player report of the Mission.
---This reports provides a one liner of the mission status. It indicates how many players and how many Tasks.
---
---    Mission "<MissionName>" - <MissionStatus> - Active Players Report
---     - Player "<PlayerName>: Task <TaskName> <TaskStatus>, Task <TaskName> <TaskStatus>
---     - Player <PlayerName>: Task <TaskName> <TaskStatus>, Task <TaskName> <TaskStatus>
---     - ..
---
------
---@param self MISSION 
---@param ReportGroup NOTYPE 
---@return string #
function MISSION:ReportPlayersPerTask(ReportGroup) end

---Create an Mission Progress report of the Mission.
---This reports provides a one liner per player of the mission achievements per task.
---
---    Mission "<MissionName>" - <MissionStatus> - Active Players Report
---     - Player <PlayerName>: Task <TaskName> <TaskStatus>: <Progress>
---     - Player <PlayerName>: Task <TaskName> <TaskStatus>: <Progress>
---     - ..
---
------
---@param self MISSION 
---@param ReportGroup NOTYPE 
---@return string #
function MISSION:ReportPlayersProgress(ReportGroup) end

---Create a summary report of the Mission (one line).
---
------
---@param self MISSION 
---@param ReportGroup GROUP 
---@return string #
function MISSION:ReportSummary(ReportGroup) end

---Set Wrapper.Group assigned to the Tasking.Mission.
---
------
---@param self MISSION 
---@param MissionGroup GROUP 
---@return MISSION #
function MISSION:SetGroupAssigned(MissionGroup) end

---Sets the Planned Task menu.
---
------
---@param self MISSION 
---@param MenuTime number 
function MISSION:SetMenu(MenuTime) end

---Synchronous Event Trigger for Event Start.
---
------
---@param self MISSION 
function MISSION:Start() end

---Synchronous Event Trigger for Event Stop.
---
------
---@param self MISSION 
function MISSION:Stop() end

---Asynchronous Event Trigger for Event Complete.
---
------
---@param self MISSION 
---@param Delay number The delay in seconds.
function MISSION:__Complete(Delay) end

---Asynchronous Event Trigger for Event Fail.
---
------
---@param self MISSION 
---@param Delay number The delay in seconds.
function MISSION:__Fail(Delay) end

---MissionGoals Asynchronous Trigger for MISSION
---
------
---@param self MISSION 
---@param Delay number 
function MISSION:__MissionGoals(Delay) end

---Asynchronous Event Trigger for Event Start.
---
------
---@param self MISSION 
---@param Delay number The delay in seconds.
function MISSION:__Start(Delay) end

---Asynchronous Event Trigger for Event Stop.
---
------
---@param self MISSION 
---@param Delay number The delay in seconds.
function MISSION:__Stop(Delay) end

---FSM function for a MISSION
---
------
---@param self MISSION 
---@param From string 
---@param Event string 
---@param To string 
function MISSION:onenterCOMPLETED(From, Event, To) end



