---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/MOOSE.JPG" width="100%">
---
---**Actions** - ACT_ACCOUNT_ classes **account for** (detect, count & report) various DCS events occurring on UNITs.
---
---![Banner Image](..\Images\deprecated.png)
---
---===
---# #ACT_ACCOUNT FSM class, extends Core.Fsm#FSM_PROCESS
---
---![Banner Image](..\Images\deprecated.png)
---
---## ACT_ACCOUNT state machine:
---
---This class is a state machine: it manages a process that is triggered by events causing state transitions to occur.
---All derived classes from this class will start with the class name, followed by a \_. See the relevant derived class descriptions below.
---Each derived class follows exactly the same process, using the same events and following the same state transitions,
---but will have **different implementation behaviour** upon each event or state transition.
---
---### ACT_ACCOUNT States
---
---  * **Assigned**: The player is assigned.
---  * **Waiting**: Waiting for an event.
---  * **Report**: Reporting.
---  * **Account**: Account for an event.
---  * **Accounted**: All events have been accounted for, end of the process.
---  * **Failed**: Failed the process.
---
---### ACT_ACCOUNT Events
---
---  * **Start**: Start the process.
---  * **Wait**: Wait for an event.
---  * **Report**: Report the status of the accounting.
---  * **Event**: An event happened, process the event.
---  * **More**: More targets.
---  * **NoMore (*)**: No more targets.
---  * **Fail (*)**: The action process has failed.
---
---(*) End states of the process.
---
---### ACT_ACCOUNT state transition methods:
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
---@deprecated
---@class ACT_ACCOUNT : FSM_PROCESS
---@field ClassName string 
---@field DisplayCount number 
---@field TargetSetUnit SET_UNIT 
ACT_ACCOUNT = {}

---Creates a new DESTROY process.
---
------
---@param self ACT_ACCOUNT 
---@return ACT_ACCOUNT #
function ACT_ACCOUNT:New() end

---StateMachine callback function
---
------
---@param self ACT_ACCOUNT 
---@param ProcessUnit UNIT 
---@param Event string 
---@param From string 
---@param To string 
---@private
function ACT_ACCOUNT:onafterEvent(ProcessUnit, Event, From, To) end

---StateMachine callback function
---
------
---@param self ACT_ACCOUNT 
---@param ProcessUnit UNIT 
---@param Event string 
---@param From string 
---@param To string 
---@private
function ACT_ACCOUNT:onafterStart(ProcessUnit, Event, From, To) end

---StateMachine callback function
---
------
---@param self ACT_ACCOUNT 
---@param ProcessUnit UNIT 
---@param Event string 
---@param From string 
---@param To string 
---@private
function ACT_ACCOUNT:onenterWaiting(ProcessUnit, Event, From, To) end


---# #ACT_ACCOUNT_DEADS FSM class, extends #ACT_ACCOUNT
---
---The ACT_ACCOUNT_DEADS class accounts (detects, counts and reports) successful kills of DCS units.
---The process is given a Core.Set of units that will be tracked upon successful destruction.
---The process will end after each target has been successfully destroyed.
---Each successful dead will trigger an Account state transition that can be scored, modified or administered.
---
---
---## ACT_ACCOUNT_DEADS constructor:
---
---  * #ACT_ACCOUNT_DEADS.New(): Creates a new ACT_ACCOUNT_DEADS object.
---@class ACT_ACCOUNT_DEADS : ACT_ACCOUNT
---@field ClassName string 
---@field DisplayCategory string 
---@field DisplayCount number 
---@field DisplayInterval number 
---@field DisplayMessage boolean 
---@field DisplayTime number 
---@field TargetSetUnit SET_UNIT 
ACT_ACCOUNT_DEADS = {}


---
------
---@param self NOTYPE 
---@param FsmAccount NOTYPE 
function ACT_ACCOUNT_DEADS:Init(FsmAccount) end

---Creates a new DESTROY process.
---
------
---@param self ACT_ACCOUNT_DEADS 
---@param TargetSetUnit SET_UNIT 
---@param TaskName string 
function ACT_ACCOUNT_DEADS:New(TargetSetUnit, TaskName) end


---
------
---@param self NOTYPE 
---@param EventData NOTYPE 
function ACT_ACCOUNT_DEADS:OnEventHit(EventData) end

---StateMachine callback function
---
------
---@param self ACT_ACCOUNT_DEADS 
---@param ProcessUnit UNIT 
---@param Task TASK 
---@param From string 
---@param Event string 
---@param To string 
---@param EventData EVENTDATA 
---@private
function ACT_ACCOUNT_DEADS:onafterEvent(ProcessUnit, Task, From, Event, To, EventData) end

---StateMachine callback function
---
------
---@param self ACT_ACCOUNT_DEADS 
---@param ProcessUnit UNIT 
---@param Task TASK 
---@param From string 
---@param Event string 
---@param To string 
---@param EventData EVENTDATA 
---@private
function ACT_ACCOUNT_DEADS:onenterAccountForOther(ProcessUnit, Task, From, Event, To, EventData) end

---StateMachine callback function
---
------
---@param self ACT_ACCOUNT_DEADS 
---@param ProcessUnit UNIT 
---@param Task TASK 
---@param From string 
---@param Event string 
---@param To string 
---@param EventData EVENTDATA 
---@private
function ACT_ACCOUNT_DEADS:onenterAccountForPlayer(ProcessUnit, Task, From, Event, To, EventData) end

---StateMachine callback function
---
------
---@param self ACT_ACCOUNT_DEADS 
---@param ProcessUnit UNIT 
---@param Event string 
---@param From string 
---@param To string 
---@param Task NOTYPE 
---@private
function ACT_ACCOUNT_DEADS:onenterReport(ProcessUnit, Event, From, To, Task) end


---
------
---@param self NOTYPE 
---@param EventData NOTYPE 
---@private
function ACT_ACCOUNT_DEADS:onfuncEventCrash(EventData) end


---
------
---@param self NOTYPE 
---@param EventData NOTYPE 
---@private
function ACT_ACCOUNT_DEADS:onfuncEventDead(EventData) end



