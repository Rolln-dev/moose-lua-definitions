---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/MOOSE.JPG" width="100%">
---
---**Tasking** - The TASK_A2A models tasks for players in Air to Air engagements.
---
---===
---
---### Author: **FlightControl**
---
---### Contributions:
---
---===
---Defines Air To Air tasks for a Core.Set of Target Units, 
---based on the tasking capabilities defined in Tasking.Task#TASK.
---
---![Banner Image](..\Images\deprecated.png)
---
---The TASK_A2A is implemented using a Core.Fsm#FSM_TASK, and has the following statuses:
---
---  * **None**: Start of the process
---  * **Planned**: The A2A task is planned.
---  * **Assigned**: The A2A task is assigned to a Wrapper.Group#GROUP.
---  * **Success**: The A2A task is successfully completed.
---  * **Failed**: The A2A task has failed. This will happen if the player exists the task early, without communicating a possible cancellation to HQ.
---
---# 1) Set the scoring of achievements in an A2A attack.
---
---Scoring or penalties can be given in the following circumstances:
---
---  * #TASK_A2A.SetScoreOnDestroy(): Set a score when a target in scope of the A2A attack, has been destroyed.
---  * #TASK_A2A.SetScoreOnSuccess(): Set a score when all the targets in scope of the A2A attack, have been destroyed.
---  * #TASK_A2A.SetPenaltyOnFailed(): Set a penalty when the A2A attack has failed.
---
---# Developer Note
---
---Note while this class still works, it is no longer supported as the original author stopped active development of MOOSE
---Therefore, this class is considered to be deprecated
---The TASK_A2A class
---@deprecated
---@class TASK_A2A : TASK
---@field TargetSetUnit SET_UNIT 
TASK_A2A = {}

---This function is called from the Tasking.CommandCenter#COMMANDCENTER to determine the method of automatic task selection.
---
------
---@param self TASK_A2A 
---@param AutoAssignMethod number The method to be applied to the task.
---@param CommandCenter COMMANDCENTER The command center.
---@param TaskGroup GROUP The player group.
function TASK_A2A:GetAutoAssignPriority(AutoAssignMethod, CommandCenter, TaskGroup) end


---
------
---@param self NOTYPE 
function TASK_A2A:GetGoalTotal() end


---
------
---@param self NOTYPE 
function TASK_A2A:GetPlannedMenuText() end


---
------
---@param self NOTYPE 
---@param TaskUnit NOTYPE 
function TASK_A2A:GetRendezVousCoordinate(TaskUnit) end


---
------
---@param self NOTYPE 
---@param TaskUnit NOTYPE 
function TASK_A2A:GetRendezVousZone(TaskUnit) end


---
------
---@param self NOTYPE 
---@param TaskUnit NOTYPE 
function TASK_A2A:GetTargetCoordinate(TaskUnit) end


---
------
---@param self NOTYPE 
---@param TaskUnit NOTYPE 
function TASK_A2A:GetTargetZone(TaskUnit) end

---Instantiates a new TASK_A2A.
---
------
---@param self TASK_A2A 
---@param Mission MISSION 
---@param SetAttack SET_GROUP The set of groups for which the Task can be assigned.
---@param TaskName string The name of the Task.
---@param UnitSetTargets SET_UNIT 
---@param TargetDistance number The distance to Target when the Player is considered to have "arrived" at the engagement range.
---@param TargetZone ZONE_BASE The target zone, if known. If the TargetZone parameter is specified, the player will be routed to the center of the zone where all the targets are assumed to be.
---@param TargetSetUnit NOTYPE 
---@param TaskType NOTYPE 
---@param TaskBriefing NOTYPE 
---@return TASK_A2A #self
function TASK_A2A:New(Mission, SetAttack, TaskName, UnitSetTargets, TargetDistance, TargetZone, TargetSetUnit, TaskType, TaskBriefing) end

---Return the relative distance to the target vicinity from the player, in order to sort the targets in the reports per distance from the threats.
---
------
---@param self TASK_A2A 
---@param ReportGroup NOTYPE 
function TASK_A2A:ReportOrder(ReportGroup) end


---
------
---@param self NOTYPE 
function TASK_A2A:SetGoalTotal() end


---
------
---@param self NOTYPE 
---@param RendezVousCoordinate NOTYPE 
---@param RendezVousRange NOTYPE 
---@param TaskUnit NOTYPE 
function TASK_A2A:SetRendezVousCoordinate(RendezVousCoordinate, RendezVousRange, TaskUnit) end


---
------
---@param self NOTYPE 
---@param RendezVousZone NOTYPE 
---@param TaskUnit NOTYPE 
function TASK_A2A:SetRendezVousZone(RendezVousZone, TaskUnit) end


---
------
---@param self NOTYPE 
---@param TargetCoordinate NOTYPE 
---@param TaskUnit NOTYPE 
function TASK_A2A:SetTargetCoordinate(TargetCoordinate, TaskUnit) end


---
------
---@param self NOTYPE 
---@param TargetSetUnit NOTYPE 
function TASK_A2A:SetTargetSetUnit(TargetSetUnit) end


---
------
---@param self NOTYPE 
---@param TargetZone NOTYPE 
---@param Altitude NOTYPE 
---@param Heading NOTYPE 
---@param TaskUnit NOTYPE 
function TASK_A2A:SetTargetZone(TargetZone, Altitude, Heading, TaskUnit) end


---
------
---@param self NOTYPE 
---@param DetectedItem NOTYPE 
function TASK_A2A:UpdateTaskInfo(DetectedItem) end

---This method checks every 10 seconds if the goal has been reached of the task.
---
------
---@param self TASK_A2A 
---@param TaskUnit NOTYPE 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
function TASK_A2A:onafterGoal(TaskUnit, From, Event, To) end


---Defines an engage task for a human player to be executed.
---When enemy planes are close to human players, use this task type is used urge the players to get out there!
---
---The TASK_A2A_ENGAGE is used by the Tasking.Task_A2A_Dispatcher#TASK_A2A_DISPATCHER to automatically create engage tasks
---based on detected airborne enemy targets intruding friendly airspace.
---
---The task is defined for a Tasking.Mission#MISSION, where a friendly Core.Set#SET_GROUP consisting of GROUPs with one human players each, is engaging the targets.
---The task is given a name and a briefing, that is used in the menu structure and in the reporting.
---The TASK_A2A_ENGAGE class
---@class TASK_A2A_ENGAGE : TASK
---@field TargetSetUnit SET_UNIT 
TASK_A2A_ENGAGE = {}

---Instantiates a new TASK_A2A_ENGAGE.
---
------
---@param self TASK_A2A_ENGAGE 
---@param Mission MISSION 
---@param SetGroup SET_GROUP The set of groups for which the Task can be assigned.
---@param TaskName string The name of the Task.
---@param TargetSetUnit SET_UNIT 
---@param TaskBriefing string The briefing of the task.
---@return TASK_A2A_ENGAGE #self
function TASK_A2A_ENGAGE:New(Mission, SetGroup, TaskName, TargetSetUnit, TaskBriefing) end

---Set a penalty when the A2A attack has failed.
---
------
---@param self TASK_A2A_ENGAGE 
---@param PlayerName string The name of the player.
---@param Penalty number The penalty in points, must be a negative value!
---@param TaskUnit UNIT 
---@return TASK_A2A_ENGAGE #
function TASK_A2A_ENGAGE:SetScoreOnFail(PlayerName, Penalty, TaskUnit) end

---Set a score when a target in scope of the A2A attack, has been destroyed .
---
------
---@param self TASK_A2A_ENGAGE 
---@param PlayerName string The name of the player.
---@param Score number The score in points to be granted when task process has been achieved.
---@param TaskUnit UNIT 
---@return TASK_A2A_ENGAGE #
function TASK_A2A_ENGAGE:SetScoreOnProgress(PlayerName, Score, TaskUnit) end

---Set a score when all the targets in scope of the A2A attack, have been destroyed.
---
------
---@param self TASK_A2A_ENGAGE 
---@param PlayerName string The name of the player.
---@param Score number The score in points.
---@param TaskUnit UNIT 
---@return TASK_A2A_ENGAGE #
function TASK_A2A_ENGAGE:SetScoreOnSuccess(PlayerName, Score, TaskUnit) end


---Defines an intercept task for a human player to be executed.
---When enemy planes need to be intercepted by human players, use this task type to urge the players to get out there!
---
---The TASK_A2A_INTERCEPT is used by the Tasking.Task_A2A_Dispatcher#TASK_A2A_DISPATCHER to automatically create intercept tasks
---based on detected airborne enemy targets intruding friendly airspace.
---
---The task is defined for a Tasking.Mission#MISSION, where a friendly Core.Set#SET_GROUP consisting of GROUPs with one human players each, is intercepting the targets.
---The task is given a name and a briefing, that is used in the menu structure and in the reporting.
---The TASK_A2A_INTERCEPT class
---@class TASK_A2A_INTERCEPT : TASK
---@field TargetSetUnit SET_UNIT 
TASK_A2A_INTERCEPT = {}

---Instantiates a new TASK_A2A_INTERCEPT.
---
------
---@param self TASK_A2A_INTERCEPT 
---@param Mission MISSION 
---@param SetGroup SET_GROUP The set of groups for which the Task can be assigned.
---@param TaskName string The name of the Task.
---@param TargetSetUnit SET_UNIT 
---@param TaskBriefing string The briefing of the task.
---@return TASK_A2A_INTERCEPT #
function TASK_A2A_INTERCEPT:New(Mission, SetGroup, TaskName, TargetSetUnit, TaskBriefing) end

---Set a penalty when the A2A attack has failed.
---
------
---@param self TASK_A2A_INTERCEPT 
---@param PlayerName string The name of the player.
---@param Penalty number The penalty in points, must be a negative value!
---@param TaskUnit UNIT 
---@return TASK_A2A_INTERCEPT #
function TASK_A2A_INTERCEPT:SetScoreOnFail(PlayerName, Penalty, TaskUnit) end

---Set a score when a target in scope of the A2A attack, has been destroyed.
---
------
---@param self TASK_A2A_INTERCEPT 
---@param PlayerName string The name of the player.
---@param Score number The score in points to be granted when task process has been achieved.
---@param TaskUnit UNIT 
---@return TASK_A2A_INTERCEPT #
function TASK_A2A_INTERCEPT:SetScoreOnProgress(PlayerName, Score, TaskUnit) end

---Set a score when all the targets in scope of the A2A attack, have been destroyed.
---
------
---@param self TASK_A2A_INTERCEPT 
---@param PlayerName string The name of the player.
---@param Score number The score in points.
---@param TaskUnit UNIT 
---@return TASK_A2A_INTERCEPT #
function TASK_A2A_INTERCEPT:SetScoreOnSuccess(PlayerName, Score, TaskUnit) end


---Defines a sweep task for a human player to be executed.
---A sweep task needs to be given when targets were detected but somehow the detection was lost.
---Most likely, these enemy planes are hidden in the mountains or are flying under radar.
---These enemy planes need to be sweeped by human players, and use this task type to urge the players to get out there and find those enemy fighters.
---
---The TASK_A2A_SWEEP is used by the Tasking.Task_A2A_Dispatcher#TASK_A2A_DISPATCHER to automatically create sweep tasks
---based on detected airborne enemy targets intruding friendly airspace, for which the detection has been lost for more than 60 seconds.
---
---The task is defined for a Tasking.Mission#MISSION, where a friendly Core.Set#SET_GROUP consisting of GROUPs with one human players each, is sweeping the targets.
---The task is given a name and a briefing, that is used in the menu structure and in the reporting.
---The TASK_A2A_SWEEP class
---@class TASK_A2A_SWEEP : TASK
---@field TargetSetUnit SET_UNIT 
TASK_A2A_SWEEP = {}

---Instantiates a new TASK_A2A_SWEEP.
---
------
---@param self TASK_A2A_SWEEP 
---@param Mission MISSION 
---@param SetGroup SET_GROUP The set of groups for which the Task can be assigned.
---@param TaskName string The name of the Task.
---@param TargetSetUnit SET_UNIT 
---@param TaskBriefing string The briefing of the task.
---@return TASK_A2A_SWEEP #self
function TASK_A2A_SWEEP:New(Mission, SetGroup, TaskName, TargetSetUnit, TaskBriefing) end

---Set a penalty when the A2A attack has failed.
---
------
---@param self TASK_A2A_SWEEP 
---@param PlayerName string The name of the player.
---@param Penalty number The penalty in points, must be a negative value!
---@param TaskUnit UNIT 
---@return TASK_A2A_SWEEP #
function TASK_A2A_SWEEP:SetScoreOnFail(PlayerName, Penalty, TaskUnit) end

---Set a score when a target in scope of the A2A attack, has been destroyed.
---
------
---@param self TASK_A2A_SWEEP 
---@param PlayerName string The name of the player.
---@param Score number The score in points to be granted when task process has been achieved.
---@param TaskUnit UNIT 
---@return TASK_A2A_SWEEP #
function TASK_A2A_SWEEP:SetScoreOnProgress(PlayerName, Score, TaskUnit) end

---Set a score when all the targets in scope of the A2A attack, have been destroyed.
---
------
---@param self TASK_A2A_SWEEP 
---@param PlayerName string The name of the player.
---@param Score number The score in points.
---@param TaskUnit UNIT 
---@return TASK_A2A_SWEEP #
function TASK_A2A_SWEEP:SetScoreOnSuccess(PlayerName, Score, TaskUnit) end


---
------
---@param self NOTYPE 
---@param TaskUnit NOTYPE 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
function TASK_A2A_SWEEP:onafterGoal(TaskUnit, From, Event, To) end



