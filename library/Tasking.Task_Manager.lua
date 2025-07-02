---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/MOOSE.JPG" width="100%">
---
---**Tasking** - This module contains the TASK_MANAGER class and derived classes.
---
---===
---
---![Banner Image](..\Images\deprecated.png)
---
---1) Tasking.Task_Manager#TASK_MANAGER class, extends Core.Fsm#FSM
---===
---The Tasking.Task_Manager#TASK_MANAGER class defines the core functions to report tasks to groups.
---Reportings can be done in several manners, and it is up to the derived classes if TASK_MANAGER to model the reporting behaviour.
---
---1.1) TASK_MANAGER constructor:
--------------------------------------
---  * Tasking.Task_Manager#TASK_MANAGER.New(): Create a new TASK_MANAGER instance.
---
---1.2) TASK_MANAGER reporting:
------------------------------------
---Derived TASK_MANAGER classes will manage tasks using the method Tasking.Task_Manager#TASK_MANAGER.ManageTasks(). This method implements polymorphic behaviour.
---
---The time interval in seconds of the task management can be changed using the methods Tasking.Task_Manager#TASK_MANAGER.SetRefreshTimeInterval(). 
---To control how long a reporting message is displayed, use Tasking.Task_Manager#TASK_MANAGER.SetReportDisplayTime().
---Derived classes need to implement the method Tasking.Task_Manager#TASK_MANAGER.GetReportDisplayTime() to use the correct display time for displayed messages during a report.
---
---Task management can be started and stopped using the methods Tasking.Task_Manager#TASK_MANAGER.StartTasks() and Tasking.Task_Manager#TASK_MANAGER.StopTasks() respectively.
---If an ad-hoc report is requested, use the method Tasking.Task_Manager#TASK_MANAGER#ManageTasks().
---
---The default task management interval is every 60 seconds.
---
---# Developer Note
---
---Note while this class still works, it is no longer supported as the original author stopped active development of MOOSE
---Therefore, this class is considered to be deprecated
---
---===
---
---### Contributions: Mechanist, Prof_Hilactic, FlightControl - Concept & Testing
---### Author: FlightControl - Framework Design &  Programming
---TASK_MANAGER class.
---@class TASK_MANAGER : FSM
---@field ClassName string 
---@field SetGroup SET_GROUP The set of group objects containing players for which tasks are managed.
---@field _RefreshTimeInterval NOTYPE 
TASK_MANAGER = {}

---Manages the tasks for the Core.Set#SET_GROUP.
---
------
---@return TASK_MANAGER #self
function TASK_MANAGER:ManageTasks() end

---TASK\_MANAGER constructor.
---
------
---@param SetGroup SET_GROUP The set of group objects containing players for which tasks are managed.
---@return TASK_MANAGER #self
function TASK_MANAGER:New(SetGroup) end

---Aborted Handler OnAfter for TASK_MANAGER
---
------
---@param From string 
---@param Event string 
---@param To string 
---@param Task TASK 
function TASK_MANAGER:OnAfterAborted(From, Event, To, Task) end

---Cancelled Handler OnAfter for TASK_MANAGER
---
------
---@param From string 
---@param Event string 
---@param To string 
---@param Task TASK 
function TASK_MANAGER:OnAfterCancelled(From, Event, To, Task) end

---Failed Handler OnAfter for TASK_MANAGER
---
------
---@param From string 
---@param Event string 
---@param To string 
---@param Task TASK 
function TASK_MANAGER:OnAfterFailed(From, Event, To, Task) end

---StartTasks Handler OnAfter for TASK_MANAGER
---
------
---@param From string 
---@param Event string 
---@param To string 
function TASK_MANAGER:OnAfterStartTasks(From, Event, To) end

---StopTasks Handler OnAfter for TASK_MANAGER
---
------
---@param From string 
---@param Event string 
---@param To string 
function TASK_MANAGER:OnAfterStopTasks(From, Event, To) end

---Success Handler OnAfter for TASK_MANAGER
---
------
---@param From string 
---@param Event string 
---@param To string 
---@param Task TASK 
function TASK_MANAGER:OnAfterSuccess(From, Event, To, Task) end

---StartTasks Handler OnBefore for TASK_MANAGER
---
------
---@param From string 
---@param Event string 
---@param To string 
---@return boolean #
function TASK_MANAGER:OnBeforeStartTasks(From, Event, To) end

---StopTasks Handler OnBefore for TASK_MANAGER
---
------
---@param From string 
---@param Event string 
---@param To string 
---@return boolean #
function TASK_MANAGER:OnBeforeStopTasks(From, Event, To) end

---Set the refresh time interval in seconds when a new task management action needs to be done.
---
------
---@param RefreshTimeInterval number The refresh time interval in seconds when a new task management action needs to be done.
---@return TASK_MANAGER #self
function TASK_MANAGER:SetRefreshTimeInterval(RefreshTimeInterval) end

---StartTasks Trigger for TASK_MANAGER
---
------
function TASK_MANAGER:StartTasks() end

---StopTasks Trigger for TASK_MANAGER
---
------
function TASK_MANAGER:StopTasks() end

---StartTasks Asynchronous Trigger for TASK_MANAGER
---
------
---@param Delay number 
function TASK_MANAGER:__StartTasks(Delay) end

---StopTasks Asynchronous Trigger for TASK_MANAGER
---
------
---@param Delay number 
function TASK_MANAGER:__StopTasks(Delay) end


---
------
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@private
function TASK_MANAGER:onafterManage(From, Event, To) end


---
------
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@private
function TASK_MANAGER:onafterStartTasks(From, Event, To) end



