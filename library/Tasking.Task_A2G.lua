---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/MOOSE.JPG" width="100%">
---
---**Tasking** - The TASK_A2G models tasks for players in Air to Ground engagements.
---
---===
---
---### Author: **FlightControl**
---
---### Contributions:
---
---===
---The TASK_A2G class defines Air To Ground tasks for a Core.Set of Target Units,
---based on the tasking capabilities defined in Tasking.Task#TASK.
---
---![Banner Image](..\Images\deprecated.png)
---
---The TASK_A2G is implemented using a Core.Fsm#FSM_TASK, and has the following statuses:
---
---  * **None**: Start of the process
---  * **Planned**: The A2G task is planned.
---  * **Assigned**: The A2G task is assigned to a Wrapper.Group#GROUP.
---  * **Success**: The A2G task is successfully completed.
---  * **Failed**: The A2G task has failed. This will happen if the player exists the task early, without communicating a possible cancellation to HQ.
---
---## 1) Set the scoring of achievements in an A2G attack.
---
---Scoring or penalties can be given in the following circumstances:
---
---  * #TASK_A2G.SetScoreOnDestroy(): Set a score when a target in scope of the A2G attack, has been destroyed.
---  * #TASK_A2G.SetScoreOnSuccess(): Set a score when all the targets in scope of the A2G attack, have been destroyed.
---  * #TASK_A2G.SetPenaltyOnFailed(): Set a penalty when the A2G attack has failed.
---
---# Developer Note
---
---Note while this class still works, it is no longer supported as the original author stopped active development of MOOSE
---Therefore, this class is considered to be deprecated
---The TASK_A2G class
---@deprecated
---@class TASK_A2G : TASK
---@field TargetSetUnit SET_UNIT 
TASK_A2G = {}

---This function is called from the Tasking.CommandCenter#COMMANDCENTER to determine the method of automatic task selection.
---
------
---@param AutoAssignMethod number The method to be applied to the task.
---@param CommandCenter COMMANDCENTER The command center.
---@param TaskGroup GROUP The player group.
function TASK_A2G:GetAutoAssignPriority(AutoAssignMethod, CommandCenter, TaskGroup) end


---
------
function TASK_A2G:GetGoalTotal() end


---
------
function TASK_A2G:GetPlannedMenuText() end


---
------
---@param TaskUnit NOTYPE 
function TASK_A2G:GetRendezVousCoordinate(TaskUnit) end


---
------
---@param TaskUnit NOTYPE 
function TASK_A2G:GetRendezVousZone(TaskUnit) end


---
------
---@param TaskUnit NOTYPE 
function TASK_A2G:GetTargetCoordinate(TaskUnit) end


---
------
---@param TaskUnit NOTYPE 
function TASK_A2G:GetTargetZone(TaskUnit) end

---Instantiates a new TASK_A2G.
---
------
---@param Mission MISSION 
---@param SetGroup SET_GROUP The set of groups for which the Task can be assigned.
---@param TaskName string The name of the Task.
---@param UnitSetTargets SET_UNIT 
---@param TargetDistance number The distance to Target when the Player is considered to have "arrived" at the engagement range.
---@param TargetZone ZONE_BASE The target zone, if known. If the TargetZone parameter is specified, the player will be routed to the center of the zone where all the targets are assumed to be.
---@param TargetSetUnit NOTYPE 
---@param TaskType NOTYPE 
---@param TaskBriefing NOTYPE 
---@return TASK_A2G #self
function TASK_A2G:New(Mission, SetGroup, TaskName, UnitSetTargets, TargetDistance, TargetZone, TargetSetUnit, TaskType, TaskBriefing) end

---Return the relative distance to the target vicinity from the player, in order to sort the targets in the reports per distance from the threats.
---
------
---@param ReportGroup NOTYPE 
function TASK_A2G:ReportOrder(ReportGroup) end


---
------
function TASK_A2G:SetGoalTotal() end


---
------
---@param RendezVousCoordinate NOTYPE 
---@param RendezVousRange NOTYPE 
---@param TaskUnit NOTYPE 
function TASK_A2G:SetRendezVousCoordinate(RendezVousCoordinate, RendezVousRange, TaskUnit) end


---
------
---@param RendezVousZone NOTYPE 
---@param TaskUnit NOTYPE 
function TASK_A2G:SetRendezVousZone(RendezVousZone, TaskUnit) end


---
------
---@param TargetCoordinate NOTYPE 
---@param TaskUnit NOTYPE 
function TASK_A2G:SetTargetCoordinate(TargetCoordinate, TaskUnit) end


---
------
---@param TargetSetUnit NOTYPE 
function TASK_A2G:SetTargetSetUnit(TargetSetUnit) end


---
------
---@param TargetZone NOTYPE 
---@param TaskUnit NOTYPE 
function TASK_A2G:SetTargetZone(TargetZone, TaskUnit) end


---
------
---@param DetectedItem NOTYPE 
function TASK_A2G:UpdateTaskInfo(DetectedItem) end

---This method checks every 10 seconds if the goal has been reached of the task.
---
------
---@param TaskUnit NOTYPE 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@private
function TASK_A2G:onafterGoal(TaskUnit, From, Event, To) end


---Defines a Battlefield Air Interdiction task for a human player to be executed.
---These tasks are more strategic in nature and are most of the time further away from friendly forces.
---BAI tasks can also be used to express the abscence of friendly forces near the vicinity.
---
---The TASK_A2G_BAI is used by the Tasking.Task_A2G_Dispatcher#TASK_A2G_DISPATCHER to automatically create BAI tasks 
---based on detected enemy ground targets.
---The TASK_A2G_BAI class
---@class TASK_A2G_BAI : TASK
---@field TargetSetUnit SET_UNIT 
TASK_A2G_BAI = {}

---Instantiates a new TASK_A2G_BAI.
---
------
---@param Mission MISSION 
---@param SetGroup SET_GROUP The set of groups for which the Task can be assigned.
---@param TaskName string The name of the Task.
---@param TargetSetUnit SET_UNIT 
---@param TaskBriefing string The briefing of the task.
---@return TASK_A2G_BAI #self
function TASK_A2G_BAI:New(Mission, SetGroup, TaskName, TargetSetUnit, TaskBriefing) end

---Set a penalty when the A2G attack has failed.
---
------
---@param PlayerName string The name of the player.
---@param Penalty number The penalty in points, must be a negative value!
---@param TaskUnit UNIT 
---@return TASK_A2G_BAI #
function TASK_A2G_BAI:SetScoreOnFail(PlayerName, Penalty, TaskUnit) end

---Set a score when a target in scope of the A2G attack, has been destroyed .
---
------
---@param PlayerName string The name of the player.
---@param Score number The score in points to be granted when task process has been achieved.
---@param TaskUnit UNIT 
---@return TASK_A2G_BAI #
function TASK_A2G_BAI:SetScoreOnProgress(PlayerName, Score, TaskUnit) end

---Set a score when all the targets in scope of the A2G attack, have been destroyed.
---
------
---@param PlayerName string The name of the player.
---@param Score number The score in points.
---@param TaskUnit UNIT 
---@return TASK_A2G_BAI #
function TASK_A2G_BAI:SetScoreOnSuccess(PlayerName, Score, TaskUnit) end


---Defines an Close Air Support task for a human player to be executed.
---Friendly forces will be in the vicinity within 6km from the enemy.
---
---The TASK_A2G_CAS is used by the Tasking.Task_A2G_Dispatcher#TASK_A2G_DISPATCHER to automatically create CAS tasks 
---based on detected enemy ground targets.
---The TASK_A2G_CAS class
---@class TASK_A2G_CAS : TASK
---@field TargetSetUnit SET_UNIT 
TASK_A2G_CAS = {}

---Instantiates a new TASK_A2G_CAS.
---
------
---@param Mission MISSION 
---@param SetGroup SET_GROUP The set of groups for which the Task can be assigned.
---@param TaskName string The name of the Task.
---@param TargetSetUnit SET_UNIT 
---@param TaskBriefing string The briefing of the task.
---@return TASK_A2G_CAS #self
function TASK_A2G_CAS:New(Mission, SetGroup, TaskName, TargetSetUnit, TaskBriefing) end

---Set a penalty when the A2G attack has failed.
---
------
---@param PlayerName string The name of the player.
---@param Penalty number The penalty in points, must be a negative value!
---@param TaskUnit UNIT 
---@return TASK_A2G_CAS #
function TASK_A2G_CAS:SetScoreOnFail(PlayerName, Penalty, TaskUnit) end

---Set a score when a target in scope of the A2G attack, has been destroyed .
---
------
---@param PlayerName string The name of the player.
---@param Score number The score in points to be granted when task process has been achieved.
---@param TaskUnit UNIT 
---@return TASK_A2G_CAS #
function TASK_A2G_CAS:SetScoreOnProgress(PlayerName, Score, TaskUnit) end

---Set a score when all the targets in scope of the A2G attack, have been destroyed.
---
------
---@param PlayerName string The name of the player.
---@param Score number The score in points.
---@param TaskUnit UNIT 
---@return TASK_A2G_CAS #
function TASK_A2G_CAS:SetScoreOnSuccess(PlayerName, Score, TaskUnit) end


---Defines an Suppression or Extermination of Air Defenses task for a human player to be executed.
---These tasks are important to be executed as they will help to achieve air superiority at the vicinity.
---
---The TASK_A2G_SEAD is used by the Tasking.Task_A2G_Dispatcher#TASK_A2G_DISPATCHER to automatically create SEAD tasks 
---based on detected enemy ground targets.
---The TASK_A2G_SEAD class
---@class TASK_A2G_SEAD : TASK
---@field TargetSetUnit SET_UNIT 
TASK_A2G_SEAD = {}

---Instantiates a new TASK_A2G_SEAD.
---
------
---@param Mission MISSION 
---@param SetGroup SET_GROUP The set of groups for which the Task can be assigned.
---@param TaskName string The name of the Task.
---@param TargetSetUnit SET_UNIT 
---@param TaskBriefing string The briefing of the task.
---@return TASK_A2G_SEAD #self
function TASK_A2G_SEAD:New(Mission, SetGroup, TaskName, TargetSetUnit, TaskBriefing) end

---Set a penalty when the A2G attack has failed.
---
------
---@param PlayerName string The name of the player.
---@param Penalty number The penalty in points, must be a negative value!
---@param TaskUnit UNIT 
---@return TASK_A2G_SEAD #
function TASK_A2G_SEAD:SetScoreOnFail(PlayerName, Penalty, TaskUnit) end

---Set a score when a target in scope of the A2G attack, has been destroyed .
---
------
---@param PlayerName string The name of the player.
---@param Score number The score in points to be granted when task process has been achieved.
---@param TaskUnit UNIT 
---@return TASK_A2G_SEAD #
function TASK_A2G_SEAD:SetScoreOnProgress(PlayerName, Score, TaskUnit) end

---Set a score when all the targets in scope of the A2G attack, have been destroyed.
---
------
---@param PlayerName string The name of the player.
---@param Score number The score in points.
---@param TaskUnit UNIT 
---@return TASK_A2G_SEAD #
function TASK_A2G_SEAD:SetScoreOnSuccess(PlayerName, Score, TaskUnit) end



