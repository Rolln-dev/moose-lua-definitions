---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/MOOSE.JPG" width="100%">
---
---(SP) (MP) (FSM) Route AI or players through waypoints or to zones.
---
---![Banner Image](..\Images\deprecated.png)
---## ACT_ASSIST state machine:
---
---This class is a state machine: it manages a process that is triggered by events causing state transitions to occur.
---All derived classes from this class will start with the class name, followed by a \_. See the relevant derived class descriptions below.
---Each derived class follows exactly the same process, using the same events and following the same state transitions,
---but will have **different implementation behaviour** upon each event or state transition.
---
---### ACT_ASSIST **Events**:
---
---These are the events defined in this class:
---
---  * **Start**:  The process is started.
---  * **Next**: The process is smoking the targets in the given zone.
---
---### ACT_ASSIST **Event methods**:
---
---Event methods are available (dynamically allocated by the state machine), that accomodate for state transitions occurring in the process.
---There are two types of event methods, which you can use to influence the normal mechanisms in the state machine:
---
---  * **Immediate**: The event method has exactly the name of the event.
---  * **Delayed**: The event method starts with a __ + the name of the event. The first parameter of the event method is a number value, expressing the delay in seconds when the event will be executed.
---
---### ACT_ASSIST **States**:
---
---  * **None**: The controllable did not receive route commands.
---  * **AwaitSmoke (*)**: The process is awaiting to smoke the targets in the zone.
---  * **Smoking (*)**: The process is smoking the targets in the zone.
---  * **Failed (*)**: The process has failed.
---
---(*) End states of the process.
---
---### ACT_ASSIST state transition methods:
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
---===
---
---# 1) #ACT_ASSIST_SMOKE_TARGETS_ZONE class, extends #ACT_ASSIST
---
---The ACT_ASSIST_SMOKE_TARGETS_ZONE class implements the core functions to smoke targets in a Core.Zone.
---The targets are smoked within a certain range around each target, simulating a realistic smoking behaviour.
---At random intervals, a new target is smoked.
---
---# 1.1) ACT_ASSIST_SMOKE_TARGETS_ZONE constructor:
---
---  * #ACT_ASSIST_SMOKE_TARGETS_ZONE.New(): Creates a new ACT_ASSIST_SMOKE_TARGETS_ZONE object.
---
---# Developer Note
---
---Note while this class still works, it is no longer supported as the original author stopped active development of MOOSE
---Therefore, this class is considered to be deprecated
---
---===
---ACT_ASSIST class
---@class ACT_ASSIST : FSM_PROCESS
---@field ClassName string 
---@field Menu NOTYPE 
---@field MenuSmokeBlue NOTYPE 
---@field MenuSmokeGreen NOTYPE 
---@field MenuSmokeOrange NOTYPE 
---@field MenuSmokeRed NOTYPE 
---@field MenuSmokeWhite NOTYPE 
---@field TargetSetUnit NOTYPE 
---@field TargetZone NOTYPE 
ACT_ASSIST = {}

---Creates a new target smoking state machine.
---The process will request from the menu if it accepts the task, if not, the unit is removed from the simulator.
---
------
---@param self ACT_ASSIST 
---@return ACT_ASSIST #
function ACT_ASSIST:New() end

---StateMachine callback function
---
------
---@param self ACT_ASSIST 
---@param ProcessUnit CONTROLLABLE 
---@param Event string 
---@param From string 
---@param To string 
---@private
function ACT_ASSIST:onafterStart(ProcessUnit, Event, From, To) end

---StateMachine callback function
---
------
---@param self ACT_ASSIST 
---@param ProcessUnit CONTROLLABLE 
---@param Event string 
---@param From string 
---@param To string 
---@private
function ACT_ASSIST:onafterStop(ProcessUnit, Event, From, To) end


---ACT_ASSIST_SMOKE_TARGETS_ZONE class
---@class ACT_ASSIST_SMOKE_TARGETS_ZONE : ACT_ASSIST
---@field ClassName string 
---@field TargetSetUnit SET_UNIT 
---@field TargetZone ZONE_BASE 
ACT_ASSIST_SMOKE_TARGETS_ZONE = {}


---
------
---@param self NOTYPE 
---@param FsmSmoke NOTYPE 
function ACT_ASSIST_SMOKE_TARGETS_ZONE:Init(FsmSmoke) end

---Creates a new target smoking state machine.
---The process will request from the menu if it accepts the task, if not, the unit is removed from the simulator.
---
------
---@param self ACT_ASSIST_SMOKE_TARGETS_ZONE 
---@param TargetSetUnit SET_UNIT 
---@param TargetZone ZONE_BASE 
function ACT_ASSIST_SMOKE_TARGETS_ZONE:New(TargetSetUnit, TargetZone) end

---StateMachine callback function
---
------
---@param self ACT_ASSIST_SMOKE_TARGETS_ZONE 
---@param ProcessUnit CONTROLLABLE 
---@param Event string 
---@param From string 
---@param To string 
---@private
function ACT_ASSIST_SMOKE_TARGETS_ZONE:onenterSmoking(ProcessUnit, Event, From, To) end



