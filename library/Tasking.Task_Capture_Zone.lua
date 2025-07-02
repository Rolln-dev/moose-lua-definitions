---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/MOOSE.JPG" width="100%">
---
---**Tasking** - The TASK_Protect models tasks for players to protect or capture specific zones.
---
---===
---
---### Author: **FlightControl**
---
---### Contributions: MillerTime
---
---===
---# TASK_CAPTURE_ZONE class, extends Tasking.Task_Capture_Zone#TASK_ZONE_GOAL
---
---The TASK_CAPTURE_ZONE class defines an Suppression or Extermination of Air Defenses task for a human player to be executed.
---These tasks are important to be executed as they will help to achieve air superiority at the vicinity.
---
---The TASK_CAPTURE_ZONE is used by the Tasking.Task_A2G_Dispatcher#TASK_A2G_DISPATCHER to automatically create SEAD tasks 
---based on detected enemy ground targets.
---The TASK_CAPTURE_ZONE class
---@class TASK_CAPTURE_ZONE : TASK_ZONE_GOAL
---@field TaskCoalition NOTYPE 
---@field TaskCoalitionName NOTYPE 
---@field TaskZoneName NOTYPE 
---@field ZoneGoal ZONE_GOAL_COALITION 
TASK_CAPTURE_ZONE = {}

---This function is called from the Tasking.CommandCenter#COMMANDCENTER to determine the method of automatic task selection.
---
------
---@param AutoAssignMethod number The method to be applied to the task.
---@param CommandCenter COMMANDCENTER The command center.
---@param TaskGroup GROUP The player group.
---@param AutoAssignReference NOTYPE 
function TASK_CAPTURE_ZONE:GetAutoAssignPriority(AutoAssignMethod, CommandCenter, TaskGroup, AutoAssignReference) end

---Instantiates a new TASK_CAPTURE_ZONE.
---
------
---@param Mission MISSION 
---@param SetGroup SET_GROUP The set of groups for which the Task can be assigned.
---@param TaskName string The name of the Task.
---@param ZoneGoalCoalition ZONE_GOAL_COALITION 
---@param TaskBriefing string The briefing of the task.
---@return TASK_CAPTURE_ZONE #self
function TASK_CAPTURE_ZONE:New(Mission, SetGroup, TaskName, ZoneGoalCoalition, TaskBriefing) end


---
------
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@param PlayerUnit NOTYPE 
---@param PlayerName NOTYPE 
function TASK_CAPTURE_ZONE:OnAfterGoal(From, Event, To, PlayerUnit, PlayerName) end


---
------
---@param ReportGroup NOTYPE 
function TASK_CAPTURE_ZONE:ReportOrder(ReportGroup) end

---Instantiates a new TASK_CAPTURE_ZONE.
---
------
---@param Persist NOTYPE 
function TASK_CAPTURE_ZONE:UpdateTaskInfo(Persist) end


---# TASK_ZONE_GOAL class, extends Tasking.Task#TASK
---
---![Banner Image](..\Images\deprecated.png)
---
---The TASK_ZONE_GOAL class defines the task to protect or capture a protection zone.
---The TASK_ZONE_GOAL is implemented using a Core.Fsm#FSM_TASK, and has the following statuses:
---
---  * **None**: Start of the process
---  * **Planned**: The A2G task is planned.
---  * **Assigned**: The A2G task is assigned to a Wrapper.Group#GROUP.
---  * **Success**: The A2G task is successfully completed.
---  * **Failed**: The A2G task has failed. This will happen if the player exists the task early, without communicating a possible cancellation to HQ.
---
---## Set the scoring of achievements in an A2G attack.
---
---Scoring or penalties can be given in the following circumstances:
---
---  * #TASK_ZONE_GOAL.SetScoreOnDestroy(): Set a score when a target in scope of the A2G attack, has been destroyed.
---  * #TASK_ZONE_GOAL.SetScoreOnSuccess(): Set a score when all the targets in scope of the A2G attack, have been destroyed.
---  * #TASK_ZONE_GOAL.SetPenaltyOnFailed(): Set a penalty when the A2G attack has failed.
---
---# Developer Note
---
---Note while this class still works, it is no longer supported as the original author stopped active development of MOOSE
---Therefore, this class is considered to be deprecated
---The TASK_ZONE_GOAL class
---@deprecated
---@class TASK_ZONE_GOAL : TASK
---@field TaskType NOTYPE 
---@field ZoneGoal ZONE_GOAL 
TASK_ZONE_GOAL = {}


---
------
function TASK_ZONE_GOAL:GetGoalTotal() end


---
------
function TASK_ZONE_GOAL:GetPlannedMenuText() end


---
------
---@param TaskUnit NOTYPE 
function TASK_ZONE_GOAL:GetTargetZone(TaskUnit) end

---Instantiates a new TASK_ZONE_GOAL.
---
------
---@param Mission MISSION 
---@param SetGroup SET_GROUP The set of groups for which the Task can be assigned.
---@param TaskName string The name of the Task.
---@param ZoneGoal ZONE_GOAL_COALITION 
---@param TaskType NOTYPE 
---@param TaskBriefing NOTYPE 
---@return TASK_ZONE_GOAL #self
function TASK_ZONE_GOAL:New(Mission, SetGroup, TaskName, ZoneGoal, TaskType, TaskBriefing) end


---
------
---@param GoalTotal NOTYPE 
function TASK_ZONE_GOAL:SetGoalTotal(GoalTotal) end


---
------
---@param ZoneGoal NOTYPE 
function TASK_ZONE_GOAL:SetProtect(ZoneGoal) end


---
------
---@param TargetZone NOTYPE 
---@param TaskUnit NOTYPE 
function TASK_ZONE_GOAL:SetTargetZone(TargetZone, TaskUnit) end



