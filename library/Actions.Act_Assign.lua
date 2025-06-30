---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/MOOSE.JPG" width="100%">
---
---(SP) (MP) (FSM) Accept or reject process for player (task) assignments.
---
---===
---
---![Banner Image](..\Images\deprecated.png)
---
---# #ACT_ASSIGN FSM template class, extends Core.Fsm#FSM_PROCESS
---
---## ACT_ASSIGN state machine:
---
---This class is a state machine: it manages a process that is triggered by events causing state transitions to occur.
---All derived classes from this class will start with the class name, followed by a \_. See the relevant derived class descriptions below.
---Each derived class follows exactly the same process, using the same events and following the same state transitions,
---but will have **different implementation behaviour** upon each event or state transition.
---
---### ACT_ASSIGN **Events**:
---
---These are the events defined in this class:
---
---  * **Start**:  Start the tasking acceptance process.
---  * **Assign**:  Assign the task.
---  * **Reject**:  Reject the task..
---
---### ACT_ASSIGN **Event methods**:
---
---Event methods are available (dynamically allocated by the state machine), that accomodate for state transitions occurring in the process.
---There are two types of event methods, which you can use to influence the normal mechanisms in the state machine:
---
---  * **Immediate**: The event method has exactly the name of the event.
---  * **Delayed**: The event method starts with a __ + the name of the event. The first parameter of the event method is a number value, expressing the delay in seconds when the event will be executed.
---
---### ACT_ASSIGN **States**:
---
---  * **UnAssigned**: The player has not accepted the task.
---  * **Assigned (*)**: The player has accepted the task.
---  * **Rejected (*)**: The player has not accepted the task.
---  * **Waiting**: The process is awaiting player feedback.
---  * **Failed (*)**: The process has failed.
---
---(*) End states of the process.
---
---### ACT_ASSIGN state transition methods:
---
---State transition functions can be set **by the mission designer** customizing or improving the behaviour of the state.
---There are 2 moments when state transition methods will be called by the state machine:
---
---  * **Before** the state transition.
---    The state transition method needs to start with the name **OnBefore + the name of the state**.
---    If the state transition method returns false, then the processing of the state transition will not be done!
---    If you want to change the behaviour of the AIControllable at this event, return false,
---    but then you'll need to specify your own logic using the AIControllable!
---
---  * **After** the state transition.
---    The state transition method needs to start with the name **OnAfter + the name of the state**.
---    These state transition methods need to provide a return value, which is specified at the function description.
---
---# Developer Note
---
---Note while this class still works, it is no longer supported as the original author stopped active development of MOOSE
---Therefore, this class is considered to be deprecated
---
---===
---
---# 1) #ACT_ASSIGN_ACCEPT class, extends Core.Fsm#ACT_ASSIGN
---
---The ACT_ASSIGN_ACCEPT class accepts by default a task for a player. No player intervention is allowed to reject the task.
---
---## 1.1) ACT_ASSIGN_ACCEPT constructor:
---
---  * #ACT_ASSIGN_ACCEPT.New(): Creates a new ACT_ASSIGN_ACCEPT object.
---
---===
---
---# 2) #ACT_ASSIGN_MENU_ACCEPT class, extends Core.Fsm#ACT_ASSIGN
---
---The ACT_ASSIGN_MENU_ACCEPT class accepts a task when the player accepts the task through an added menu option.
---This assignment type is useful to conditionally allow the player to choose whether or not he would accept the task.
---The assignment type also allows to reject the task.
---
---## 2.1) ACT_ASSIGN_MENU_ACCEPT constructor:
--------------------------------------------
---
---  * #ACT_ASSIGN_MENU_ACCEPT.New(): Creates a new ACT_ASSIGN_MENU_ACCEPT object.
---
---===
---ACT_ASSIGN class
---@class ACT_ASSIGN : FSM_PROCESS
---@field ClassName string 
---@field ProcessUnit UNIT 
---@field TargetZone ZONE_BASE 
---@field Task TASK 
ACT_ASSIGN = {}

---Creates a new task assignment state machine.
---The process will accept the task by default, no player intervention accepted.
---
------
---@param self ACT_ASSIGN 
---@return ACT_ASSIGN #The task acceptance process.
function ACT_ASSIGN:New() end


---ACT_ASSIGN_ACCEPT class
---@class ACT_ASSIGN_ACCEPT : ACT_ASSIGN
---@field ClassName string 
---@field ProcessUnit UNIT 
---@field TargetZone ZONE_BASE 
---@field Task TASK 
---@field TaskBriefing  
ACT_ASSIGN_ACCEPT = {}


---
------
---@param self NOTYPE 
---@param FsmAssign NOTYPE 
function ACT_ASSIGN_ACCEPT:Init(FsmAssign) end

---Creates a new task assignment state machine.
---The process will accept the task by default, no player intervention accepted.
---
------
---@param self ACT_ASSIGN_ACCEPT 
---@param TaskBriefing string 
function ACT_ASSIGN_ACCEPT:New(TaskBriefing) end

---StateMachine callback function
---
------
---@param self ACT_ASSIGN_ACCEPT 
---@param ProcessUnit UNIT 
---@param Event string 
---@param From string 
---@param To string 
---@param Task NOTYPE 
function ACT_ASSIGN_ACCEPT:onafterStart(ProcessUnit, Event, From, To, Task) end

---StateMachine callback function
---
------
---@param self ACT_ASSIGN_ACCEPT 
---@param ProcessUnit UNIT 
---@param Event string 
---@param From string 
---@param To string 
---@param Task NOTYPE 
---@param TaskGroup NOTYPE 
function ACT_ASSIGN_ACCEPT:onenterAssigned(ProcessUnit, Event, From, To, Task, TaskGroup) end


---ACT_ASSIGN_MENU_ACCEPT class
---@class ACT_ASSIGN_MENU_ACCEPT : ACT_ASSIGN
---@field ClassName string 
---@field Menu  
---@field MenuAcceptTask  
---@field MenuRejectTask  
---@field ProcessUnit UNIT 
---@field TargetZone ZONE_BASE 
---@field Task TASK 
---@field TaskBriefing  
ACT_ASSIGN_MENU_ACCEPT = {}

---Creates a new task assignment state machine.
---The process will request from the menu if it accepts the task, if not, the unit is removed from the simulator.
---
------
---@param self ACT_ASSIGN_MENU_ACCEPT 
---@param TaskBriefing string 
---@return ACT_ASSIGN_MENU_ACCEPT #self
function ACT_ASSIGN_MENU_ACCEPT:Init(TaskBriefing) end

---Menu function.
---
------
---@param self ACT_ASSIGN_MENU_ACCEPT 
---@param TaskGroup NOTYPE 
function ACT_ASSIGN_MENU_ACCEPT:MenuAssign(TaskGroup) end

---Menu function.
---
------
---@param self ACT_ASSIGN_MENU_ACCEPT 
---@param TaskGroup NOTYPE 
function ACT_ASSIGN_MENU_ACCEPT:MenuReject(TaskGroup) end

---Init.
---
------
---@param self ACT_ASSIGN_MENU_ACCEPT 
---@param TaskBriefing string 
---@return ACT_ASSIGN_MENU_ACCEPT #self
function ACT_ASSIGN_MENU_ACCEPT:New(TaskBriefing) end

---StateMachine callback function
---
------
---@param self ACT_ASSIGN_MENU_ACCEPT 
---@param ProcessUnit UNIT 
---@param Event string 
---@param From string 
---@param To string 
---@param Task NOTYPE 
---@param TaskGroup NOTYPE 
function ACT_ASSIGN_MENU_ACCEPT:onafterAssign(ProcessUnit, Event, From, To, Task, TaskGroup) end

---StateMachine callback function
---
------
---@param self ACT_ASSIGN_MENU_ACCEPT 
---@param ProcessUnit UNIT 
---@param Event string 
---@param From string 
---@param To string 
---@param Task NOTYPE 
---@param TaskGroup NOTYPE 
function ACT_ASSIGN_MENU_ACCEPT:onafterReject(ProcessUnit, Event, From, To, Task, TaskGroup) end

---StateMachine callback function
---
------
---@param self ACT_ASSIGN_MENU_ACCEPT 
---@param ProcessUnit UNIT 
---@param Event string 
---@param From string 
---@param To string 
---@param Task NOTYPE 
function ACT_ASSIGN_MENU_ACCEPT:onafterStart(ProcessUnit, Event, From, To, Task) end

---StateMachine callback function
---
------
---@param self ACT_ASSIGN_ACCEPT 
---@param ProcessUnit UNIT 
---@param Event string 
---@param From string 
---@param To string 
---@param Task NOTYPE 
---@param TaskGroup NOTYPE 
function ACT_ASSIGN_MENU_ACCEPT:onenterAssigned(ProcessUnit, Event, From, To, Task, TaskGroup) end



