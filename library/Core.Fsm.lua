---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Core_Finite_State_Machine.JPG" width="100%">
---
---**Core** - FSM (Finite State Machine) are objects that model and control long lasting business processes and workflow.
---
---===
---
---## Features:
---
---  * Provide a base class to model your own state machines.
---  * Trigger events synchronously.
---  * Trigger events asynchronously.
---  * Handle events before or after the event was triggered.
---  * Handle state transitions as a result of event before and after the state change.
---  * For internal moose purposes, further state machines have been designed:
---    - to handle controllables (groups and units).
---    - to handle tasks.
---    - to handle processes.
---
---===
---
---A Finite State Machine (FSM) models a process flow that transitions between various **States** through triggered **Events**.
---
---A FSM can only be in one of a finite number of states.
---The machine is in only one state at a time; the state it is in at any given time is called the **current state**.
---It can change from one state to another when initiated by an **__internal__ or __external__ triggering event**, which is called a **transition**.
---A **FSM implementation** is defined by **a list of its states**, **its initial state**, and **the triggering events** for **each possible transition**.
---A FSM implementation is composed out of **two parts**, a set of **state transition rules**, and an implementation set of **state transition handlers**, implementing those transitions.
---
---The FSM class supports a **hierarchical implementation of a Finite State Machine**,
---that is, it allows to **embed existing FSM implementations in a master FSM**.
---FSM hierarchies allow for efficient FSM re-use, **not having to re-invent the wheel every time again** when designing complex processes.
---
---![Workflow Example](..\Presentations\FSM\Dia2.JPG)
---
---The above diagram shows a graphical representation of a FSM implementation for a **Task**, which guides a Human towards a Zone,
---orders him to destroy x targets and account the results.
---Other examples of ready made FSM could be:
---
---  * Route a plane to a zone flown by a human.
---  * Detect targets by an AI and report to humans.
---  * Account for destroyed targets by human players.
---  * Handle AI infantry to deploy from or embark to a helicopter or airplane or vehicle.
---  * Let an AI patrol a zone.
---
---The **MOOSE framework** extensively uses the FSM class and derived FSM\_ classes,
---because **the goal of MOOSE is to simplify mission design complexity for mission building**.
---By efficiently utilizing the FSM class and derived classes, MOOSE allows mission designers to quickly build processes.
---**Ready made FSM-based implementations classes** exist within the MOOSE framework that **can easily be re-used,
---and tailored** by mission designers through **the implementation of Transition Handlers**.
---Each of these FSM implementation classes start either with:
---
---  * an acronym **AI\_**, which indicates a FSM implementation directing **AI controlled** Wrapper.Group#GROUP and/or Wrapper.Unit#UNIT. These AI\_ classes derive the #FSM_CONTROLLABLE class.
---  * an acronym **TASK\_**, which indicates a FSM implementation executing a Tasking.Task#TASK executed by Groups of players. These TASK\_ classes derive the #FSM_TASK class.
---  * an acronym **ACT\_**, which indicates an Sub-FSM implementation, directing **Humans actions** that need to be done in a Tasking.Task#TASK, seated in a Wrapper.Client#CLIENT (slot) or a Wrapper.Unit#UNIT (CA join). These ACT\_ classes derive the #FSM_PROCESS class.
---
---Detailed explanations and API specifics are further below clarified and FSM derived class specifics are described in those class documentation sections.
---
---##__Disclaimer:__
---The FSM class development is based on a finite state machine implementation made by Conroy Kyle.
---The state machine can be found on [github](https://github.com/kyleconroy/lua-state-machine)
---I've reworked this development (taken the concept), and created a **hierarchical state machine** out of it, embedded within the DCS simulator.
---Additionally, I've added extendability and created an API that allows seamless FSM implementation.
---
---The following derived classes are available in the MOOSE framework, that implement a specialized form of a FSM:
---
---  * #FSM_TASK: Models Finite State Machines for Tasking.Tasks.
---  * #FSM_PROCESS: Models Finite State Machines for Tasking.Task actions, which control Wrapper.Clients.
---  * #FSM_CONTROLLABLE: Models Finite State Machines for Wrapper.Controllables, which are Wrapper.Groups, Wrapper.Units, Wrapper.Clients.
---  * #FSM_SET: Models Finite State Machines for Core.Sets. Note that these FSMs control multiple objects!!! So State concerns here
---    for multiple objects or the position of the state machine in the process.
---
---===
---
---### Author: **FlightControl**
---### Contributions: **funkyfranky**
---
---===
---A Finite State Machine (FSM) models a process flow that transitions between various **States** through triggered **Events**.
---
---A FSM can only be in one of a finite number of states. 
---The machine is in only one state at a time; the state it is in at any given time is called the **current state**.
---It can change from one state to another when initiated by an **__internal__ or __external__ triggering event**, which is called a **transition**.
---An **FSM implementation** is defined by **a list of its states**, **its initial state**, and **the triggering events** for **each possible transition**.
---An FSM implementation is composed out of **two parts**, a set of **state transition rules**, and an implementation set of **state transition handlers**, implementing those transitions.
---
---The FSM class supports a **hierarchical implementation of a Finite State Machine**,
---that is, it allows to **embed existing FSM implementations in a master FSM**.
---FSM hierarchies allow for efficient FSM re-use, **not having to re-invent the wheel every time again** when designing complex processes.
---
---![Workflow Example](..\Presentations\FSM\Dia2.JPG)
---
---The above diagram shows a graphical representation of a FSM implementation for a **Task**, which guides a Human towards a Zone,
---orders him to destroy x targets and account the results.
---Other examples of ready made FSM could be:
---
---  * route a plane to a zone flown by a human
---  * detect targets by an AI and report to humans
---  * account for destroyed targets by human players
---  * handle AI infantry to deploy from or embark to a helicopter or airplane or vehicle
---  * let an AI patrol a zone
---
---The **MOOSE framework** uses extensively the FSM class and derived FSM\_ classes,
---because **the goal of MOOSE is to simplify mission design complexity for mission building**.
---By efficiently utilizing the FSM class and derived classes, MOOSE allows mission designers to quickly build processes.
---**Ready made FSM-based implementations classes** exist within the MOOSE framework that **can easily be re-used,
---and tailored** by mission designers through **the implementation of Transition Handlers**.
---Each of these FSM implementation classes start either with:
---
---  * an acronym **AI\_**, which indicates an FSM implementation directing **AI controlled** Wrapper.Group#GROUP and/or Wrapper.Unit#UNIT. These AI\_ classes derive the #FSM_CONTROLLABLE class.
---  * an acronym **TASK\_**, which indicates an FSM implementation executing a Tasking.Task#TASK executed by Groups of players. These TASK\_ classes derive the #FSM_TASK class.
---  * an acronym **ACT\_**, which indicates an Sub-FSM implementation, directing **Humans actions** that need to be done in a Tasking.Task#TASK, seated in a Wrapper.Client#CLIENT (slot) or a Wrapper.Unit#UNIT (CA join). These ACT\_ classes derive the #FSM_PROCESS class.
---
---![Transition Rules and Transition Handlers and Event Triggers](..\Presentations\FSM\Dia3.JPG)
---
---The FSM class is the base class of all FSM\_ derived classes. It implements the main functionality to define and execute Finite State Machines.
---The derived FSM\_ classes extend the Finite State Machine functionality to run a workflow process for a specific purpose or component.
---
---Finite State Machines have **Transition Rules**, **Transition Handlers** and **Event Triggers**.
---
---The **Transition Rules** define the "Process Flow Boundaries", that is,
---the path that can be followed hopping from state to state upon triggered events.
---If an event is triggered, and there is no valid path found for that event,
---an error will be raised and the FSM will stop functioning.
---
---The **Transition Handlers** are special methods that can be defined by the mission designer, following a defined syntax.
---If the FSM object finds a method of such a handler, then the method will be called by the FSM, passing specific parameters.
---The method can then define its own custom logic to implement the FSM workflow, and to conduct other actions.
---
---The **Event Triggers** are methods that are defined by the FSM, which the mission designer can use to implement the workflow.
---Most of the time, these Event Triggers are used within the Transition Handler methods, so that a workflow is created running through the state machine.
---
---As explained above, a FSM supports **Linear State Transitions** and **Hierarchical State Transitions**, and both can be mixed to make a comprehensive FSM implementation.
---The below documentation has a separate chapter explaining both transition modes, taking into account the **Transition Rules**, **Transition Handlers** and **Event Triggers**.
---
---## FSM Linear Transitions
---
---Linear Transitions are Transition Rules allowing an FSM to transition from one or multiple possible **From** state(s) towards a **To** state upon a Triggered **Event**.
---The Linear transition rule evaluation will always be done from the **current state** of the FSM.
---If no valid Transition Rule can be found in the FSM, the FSM will log an error and stop.
---
---### FSM Transition Rules
---
---The FSM has transition rules that it follows and validates, as it walks the process.
---These rules define when an FSM can transition from a specific state towards an other specific state upon a triggered event.
---
---The method #FSM.AddTransition() specifies a new possible Transition Rule for the FSM.
---
---The initial state can be defined using the method #FSM.SetStartState(). The default start state of an FSM is "None".
---
---Find below an example of a Linear Transition Rule definition for an FSM.
---
---     local Fsm3Switch = FSM:New() -- #FsmDemo
---     FsmSwitch:SetStartState( "Off" )
---     FsmSwitch:AddTransition( "Off", "SwitchOn", "On" )
---     FsmSwitch:AddTransition( "Off", "SwitchMiddle", "Middle" )
---     FsmSwitch:AddTransition( "On", "SwitchOff", "Off" )
---     FsmSwitch:AddTransition( "Middle", "SwitchOff", "Off" )
---
---The above code snippet models a 3-way switch Linear Transition:
---
---   * It can be switched **On** by triggering event **SwitchOn**.
---   * It can be switched to the **Middle** position, by triggering event **SwitchMiddle**.
---   * It can be switched **Off** by triggering event **SwitchOff**.
---   * Note that once the Switch is **On** or **Middle**, it can only be switched **Off**.
---
---#### Some additional comments:
---
---Note that Linear Transition Rules **can be declared in a few variations**:
---
---   * The From states can be **a table of strings**, indicating that the transition rule will be valid **if the current state** of the FSM will be **one of the given From states**.
---   * The From state can be a **"*"**, indicating that **the transition rule will always be valid**, regardless of the current state of the FSM.
---
---The below code snippet shows how the two last lines can be rewritten and condensed.
---
---     FsmSwitch:AddTransition( { "On",  "Middle" }, "SwitchOff", "Off" )
---
---### Transition Handling
---
---![Transition Handlers](..\Presentations\FSM\Dia4.JPG)
---
---An FSM transitions in **4 moments** when an Event is being triggered and processed.
---The mission designer can define for each moment specific logic within methods implementations following a defined API syntax.
---These methods define the flow of the FSM process; because in those methods the FSM Internal Events will be triggered.
---
---   * To handle **State** transition moments, create methods starting with OnLeave or OnEnter concatenated with the State name.
---   * To handle **Event** transition moments, create methods starting with OnBefore or OnAfter concatenated with the Event name.
---
---**The OnLeave and OnBefore transition methods may return false, which will cancel the transition!**
---
---Transition Handler methods need to follow the above specified naming convention, but are also passed parameters from the FSM.
---These parameters are on the correct order: From, Event, To:
---
---   * From = A string containing the From state.
---   * Event = A string containing the Event name that was triggered.
---   * To = A string containing the To state.
---
---On top, each of these methods can have a variable amount of parameters passed. See the example in section [1.1.3](#1.1.3\)-event-triggers).
---
---### Event Triggers
---
---![Event Triggers](..\Presentations\FSM\Dia5.JPG)
---
---The FSM creates for each Event two **Event Trigger methods**.
---There are two modes how Events can be triggered, which is **synchronous** and **asynchronous**:
---
---   * The method **FSM:Event()** triggers an Event that will be processed **synchronously** or **immediately**.
---   * The method **FSM:__Event( __seconds__ )** triggers an Event that will be processed **asynchronously** over time, waiting __x seconds__.
---
---The distinction between these 2 Event Trigger methods are important to understand. An asynchronous call will "log" the Event Trigger to be executed at a later time.
---Processing will just continue. Synchronous Event Trigger methods are useful to change states of the FSM immediately, but may have a larger processing impact.
---
---The following example provides a little demonstration on the difference between synchronous and asynchronous Event Triggering.
---
---      function FSM:OnAfterEvent( From, Event, To, Amount )
---        self:T( { Amount = Amount } )
---      end
---
---      local Amount = 1
---      FSM:__Event( 5, Amount )
---
---      Amount = Amount + 1
---      FSM:Event( Text, Amount )
---
---In this example, the **:OnAfterEvent**() Transition Handler implementation will get called when **Event** is being triggered.
---Before we go into more detail, let's look at the last 4 lines of the example.
---The last line triggers synchronously the **Event**, and passes Amount as a parameter.
---The 3rd last line of the example triggers asynchronously **Event**.
---Event will be processed after 5 seconds, and Amount is given as a parameter.
---
---The output of this little code fragment will be:
---
---   * Amount = 2
---   * Amount = 2
---
---Because ... When Event was asynchronously processed after 5 seconds, Amount was set to 2. So be careful when processing and passing values and objects in asynchronous processing!
---
---### Linear Transition Example
---
---This example is fully implemented in the MOOSE test mission on GitHub: [FSM-100 - Transition Explanation](https://github.com/FlightControl-Master/MOOSE_MISSIONS/tree/master/Core/FSM/FSM-100%20-%20Transition%20Explanation)
---
---It models a unit standing still near Batumi, and flaring every 5 seconds while switching between a Green flare and a Red flare.
---The purpose of this example is not to show how exciting flaring is, but it demonstrates how a Linear Transition FSM can be build.
---Have a look at the source code. The source code is also further explained below in this section.
---
---The example creates a new FsmDemo object from class FSM.
---It will set the start state of FsmDemo to state **Green**.
---Two Linear Transition Rules are created, where upon the event **Switch**,
---the FsmDemo will transition from state **Green** to **Red** and from **Red** back to **Green**.
---
---![Transition Example](..\Presentations\FSM\Dia6.JPG)
---
---     local FsmDemo = FSM:New() -- #FsmDemo
---     FsmDemo:SetStartState( "Green" )
---     FsmDemo:AddTransition( "Green", "Switch", "Red" )
---     FsmDemo:AddTransition( "Red", "Switch", "Green" )
---
---In the above example, the FsmDemo could flare every 5 seconds a Green or a Red flare into the air.
---The next code implements this through the event handling method **OnAfterSwitch**.
---
---![Transition Flow](..\Presentations\FSM\Dia7.JPG)
---
---     function FsmDemo:OnAfterSwitch( From, Event, To, FsmUnit )
---       self:T( { From, Event, To, FsmUnit } )
---
---       if From == "Green" then
---         FsmUnit:Flare(FLARECOLOR.Green)
---       else
---         if From == "Red" then
---           FsmUnit:Flare(FLARECOLOR.Red)
---         end
---       end
---       self:__Switch( 5, FsmUnit ) -- Trigger the next Switch event to happen in 5 seconds.
---     end
---
---     FsmDemo:__Switch( 5, FsmUnit ) -- Trigger the first Switch event to happen in 5 seconds.
---
---The OnAfterSwitch implements a loop. The last line of the code fragment triggers the Switch Event within 5 seconds.
---Upon the event execution (after 5 seconds), the OnAfterSwitch method is called of FsmDemo (cfr. the double point notation!!! ":").
---The OnAfterSwitch method receives from the FSM the 3 transition parameter details ( From, Event, To ),
---and one additional parameter that was given when the event was triggered, which is in this case the Unit that is used within OnSwitchAfter.
---
---     function FsmDemo:OnAfterSwitch( From, Event, To, FsmUnit )
---
---For debugging reasons the received parameters are traced within the DCS.log.
---
---        self:T( { From, Event, To, FsmUnit } )
---
---The method will check if the From state received is either "Green" or "Red" and will flare the respective color from the FsmUnit.
---
---       if From == "Green" then
---         FsmUnit:Flare(FLARECOLOR.Green)
---       else
---         if From == "Red" then
---           FsmUnit:Flare(FLARECOLOR.Red)
---         end
---       end
---
---It is important that the Switch event is again triggered, otherwise, the FsmDemo would stop working after having the first Event being handled.
---
---       FsmDemo:__Switch( 5, FsmUnit ) -- Trigger the next Switch event to happen in 5 seconds.
---
---The below code fragment extends the FsmDemo, demonstrating multiple **From states declared as a table**, adding a **Linear Transition Rule**.
---The new event **Stop** will cancel the Switching process.
---The transition for event Stop can be executed if the current state of the FSM is either "Red" or "Green".
---
---     local FsmDemo = FSM:New() -- #FsmDemo
---     FsmDemo:SetStartState( "Green" )
---     FsmDemo:AddTransition( "Green", "Switch", "Red" )
---     FsmDemo:AddTransition( "Red", "Switch", "Green" )
---     FsmDemo:AddTransition( { "Red", "Green" }, "Stop", "Stopped" )
---
---The transition for event Stop can also be simplified, as any current state of the FSM is valid.
---
---     FsmDemo:AddTransition( "*", "Stop", "Stopped" )
---
---So... When FsmDemo:Stop() is being triggered, the state of FsmDemo will transition from Red or Green to Stopped.
---And there is no transition handling method defined for that transition, thus, no new event is being triggered causing the FsmDemo process flow to halt.
---
---## FSM Hierarchical Transitions
---
---Hierarchical Transitions allow to re-use readily available and implemented FSMs.
---This becomes in very useful for mission building, where mission designers build complex processes and workflows,
---combining smaller FSMs to one single FSM.
---
---The FSM can embed **Sub-FSMs** that will execute and return **multiple possible Return (End) States**.
---Depending upon **which state is returned**, the main FSM can continue the flow **triggering specific events**.
---
---The method #FSM.AddProcess() adds a new Sub-FSM to the FSM.
---
---===
---@class FSM 
---@field CallScheduler NOTYPE 
---@field Events table 
---@field Scores table 
---@field _EndStates table 
---@field _EventSchedules table 
---@field _Processes table 
---@field _Scores table 
---@field _StartState NOTYPE 
---@field _Transitions table 
---@field private current NOTYPE 
---@field private endstates table 
---@field private subs table 
FSM = {}

---Adds an End state.
---
------
---@param self FSM 
---@param State string The FSM state.
function FSM:AddEndState(State) end

---Set the default #FSM_PROCESS template with key ProcessName providing the ProcessClass and the process object when it is assigned to a Wrapper.Controllable by the task.
---
------
---@param self FSM 
---@param From table Can contain a string indicating the From state or a table of strings containing multiple From states.
---@param Event string The Event name.
---@param Process FSM_PROCESS An sub-process FSM.
---@param ReturnEvents table A table indicating for which returned events of the SubFSM which Event must be triggered in the FSM.
---@return FSM_PROCESS #The SubFSM.
function FSM:AddProcess(From, Event, Process, ReturnEvents) end

---Adds a score for the FSM to be achieved.
---
------
---@param self FSM 
---@param State string is the state of the process when the score needs to be given. (See the relevant state descriptions of the process).
---@param ScoreText string is a text describing the score that is given according the status.
---@param Score number is a number providing the score of the status.
---@return FSM #self
function FSM:AddScore(State, ScoreText, Score) end

---Adds a score for the FSM_PROCESS to be achieved.
---
------
---@param self FSM 
---@param From string is the From State of the main process.
---@param Event string is the Event of the main process.
---@param State string is the state of the process when the score needs to be given. (See the relevant state descriptions of the process).
---@param ScoreText string is a text describing the score that is given according the status.
---@param Score number is a number providing the score of the status.
---@return FSM #self
function FSM:AddScoreProcess(From, Event, State, ScoreText, Score) end

---Add a new transition rule to the FSM.
---A transition rule defines when and if the FSM can transition from a state towards another state upon a triggered event.
---
------
---@param self FSM 
---@param From table Can contain a string indicating the From state or a table of strings containing multiple From states.
---@param Event string The Event name.
---@param To string The To state.
function FSM:AddTransition(From, Event, To) end

---Get current state.
---
------
---@param self FSM 
---@return string #Current FSM state.
function FSM:GetCurrentState() end

---Returns the End states.
---
------
---@param self FSM 
---@return table #End states.
function FSM:GetEndStates() end


---
------
---@param self NOTYPE 
---@param From NOTYPE 
---@param Event NOTYPE 
function FSM:GetProcess(From, Event) end

---Returns a table of the SubFSM rules defined within the FSM.
---
------
---@param self FSM 
---@return table #Sub processes.
function FSM:GetProcesses() end

---Returns a table with the scores defined.
---
------
---@param self FSM 
---@return table #Scores.
function FSM:GetScores() end

---Returns the start state of the FSM.
---
------
---@param self FSM 
---@return string #A string containing the start state.
function FSM:GetStartState() end

---Get current state.
---
------
---@param self FSM 
---@return string #Current FSM state.
function FSM:GetState() end

---Returns a table with the Subs defined.
---
------
---@param self FSM 
---@return table #Sub processes.
function FSM:GetSubs() end

---Returns a table of the transition rules defined within the FSM.
---
------
---@param self FSM 
---@return table #Transitions.
function FSM:GetTransitions() end

---Check if FSM is in state.
---
------
---@param self FSM 
---@param State string State name.
---@return boolean #If true, FSM is in this state.
function FSM:Is(State) end

---Load call backs.
---
------
---@param self FSM 
---@param CallBackTable table Table of call backs.
function FSM:LoadCallBacks(CallBackTable) end

---Creates a new FSM object.
---
------
---@param self FSM 
---@return FSM #
function FSM:New() end


---
------
---@param self NOTYPE 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param Fsm NOTYPE 
function FSM:SetProcess(From, Event, Fsm) end

---Sets the start state of the FSM.
---
------
---@param self FSM 
---@param State string A string defining the start state.
function FSM:SetStartState(State) end

---Add to map.
---
------
---@param self FSM 
---@param Map table Map.
---@param Event table Event table.
function FSM:_add_to_map(Map, Event) end

---Call handler.
---
------
---@param self FSM 
---@param step string Step "onafter", "onbefore", "onenter", "onleave".
---@param trigger string Trigger.
---@param params table Parameters.
---@param EventName string Event name.
---@return  #Value.
function FSM:_call_handler(step, trigger, params, EventName) end

---Create transition.
---
------
---@param self FSM 
---@param EventName string Event name.
---@return function #Function.
function FSM:_create_transition(EventName) end

---Delayed transition.
---
------
---@param self FSM 
---@param EventName string Event name.
---@return function #Function.
function FSM:_delayed_transition(EventName) end

---Event map.
---
------
---@param self FSM 
---@param Events table Events.
---@param EventStructure table Event structure.
function FSM:_eventmap(Events, EventStructure) end

---Go sub.
---
------
---@param self FSM 
---@param ParentFrom string Parent from state.
---@param ParentEvent string Parent event name.
---@return table #Subs.
function FSM:_gosub(ParentFrom, ParentEvent) end

---Handler.
---
------
---@param self FSM 
---@param EventName string Event name.
---@param ... NOTYPE Arguments.
function FSM:_handler(EventName, ...) end

---Is end state.
---
------
---@param self FSM 
---@param Current string Current state name.
---@return table #FSM parent.
---@return string #Event name.
function FSM:_isendstate(Current) end

---Sub maps.
---
------
---@param self FSM 
---@param subs table Subs.
---@param sub table Sub.
---@param name string Name.
function FSM:_submap(subs, sub, name) end

---Check if can do an event.
---
------
---@param self FSM 
---@param e string Event name.
---@return boolean #If true, FSM can do the event.
---@return string #To state.
---@private
function FSM:can(e) end

---Check if cannot do an event.
---
------
---@param self FSM 
---@param e string Event name.
---@return boolean #If true, FSM cannot do the event.
---@private
function FSM:cannot(e) end

---Check if FSM is in state.
---
------
---@param self FSM 
---@param State string State name.
---@param state NOTYPE 
---@return boolean #If true, FSM is in this state.  
---@private
function FSM:is(State, state) end


---Models Finite State Machines for Wrapper.Controllables, which are Wrapper.Groups, Wrapper.Units, Wrapper.Clients.
---
---===
---@class FSM_CONTROLLABLE : FSM
---@field Controllable CONTROLLABLE 
FSM_CONTROLLABLE = {}

---Gets the CONTROLLABLE object that the FSM_CONTROLLABLE governs.
---
------
---@param self FSM_CONTROLLABLE 
---@return CONTROLLABLE #
function FSM_CONTROLLABLE:GetControllable() end

---Creates a new FSM_CONTROLLABLE object.
---
------
---@param self FSM_CONTROLLABLE 
---@param FSMT table Finite State Machine Table
---@param Controllable? CONTROLLABLE (optional) The CONTROLLABLE object that the FSM_CONTROLLABLE governs.
---@return FSM_CONTROLLABLE #
function FSM_CONTROLLABLE:New(FSMT, Controllable) end

---OnAfter Transition Handler for Event Stop.
---
------
---@param self FSM_CONTROLLABLE 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function FSM_CONTROLLABLE:OnAfterStop(Controllable, From, Event, To) end

---OnBefore Transition Handler for Event Stop.
---
------
---@param self FSM_CONTROLLABLE 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function FSM_CONTROLLABLE:OnBeforeStop(Controllable, From, Event, To) end

---OnEnter Transition Handler for State Stopped.
---
------
---@param self FSM_CONTROLLABLE 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function FSM_CONTROLLABLE:OnEnterStopped(Controllable, From, Event, To) end

---OnLeave Transition Handler for State Stopped.
---
------
---@param self FSM_CONTROLLABLE 
---@param Controllable CONTROLLABLE The Controllable Object managed by the FSM.
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function FSM_CONTROLLABLE:OnLeaveStopped(Controllable, From, Event, To) end

---Sets the CONTROLLABLE object that the FSM_CONTROLLABLE governs.
---
------
---@param self FSM_CONTROLLABLE 
---@param FSMControllable CONTROLLABLE 
---@return FSM_CONTROLLABLE #
function FSM_CONTROLLABLE:SetControllable(FSMControllable) end

---Synchronous Event Trigger for Event Stop.
---
------
---@param self FSM_CONTROLLABLE 
function FSM_CONTROLLABLE:Stop() end

---Asynchronous Event Trigger for Event Stop.
---
------
---@param self FSM_CONTROLLABLE 
---@param Delay number The delay in seconds.  
function FSM_CONTROLLABLE:__Stop(Delay) end


---
------
---@param self NOTYPE 
---@param step NOTYPE 
---@param trigger NOTYPE 
---@param params NOTYPE 
---@param EventName NOTYPE 
function FSM_CONTROLLABLE:_call_handler(step, trigger, params, EventName) end


---FSM_PROCESS class models Finite State Machines for Tasking.Task actions, which control Wrapper.Clients.
---
---===
---@class FSM_PROCESS : FSM_CONTROLLABLE
---@field Task TASK 
FSM_PROCESS = {}

---Assign the process to a Wrapper.Unit and activate the process.
---
------
---@param self FSM_PROCESS 
---@param Task TASK 
---@param ProcessUnit UNIT 
---@return FSM_PROCESS #self
function FSM_PROCESS:Assign(Task, ProcessUnit) end

---Creates a new FSM_PROCESS object based on this FSM_PROCESS.
---
------
---@param self FSM_PROCESS 
---@param Controllable NOTYPE 
---@param Task NOTYPE 
---@return FSM_PROCESS #
function FSM_PROCESS:Copy(Controllable, Task) end

---Gets the mission of the process.
---
------
---@param self FSM_PROCESS 
---@return COMMANDCENTER #
function FSM_PROCESS:GetCommandCenter() end

---Gets the mission of the process.
---
------
---@param self FSM_PROCESS 
---@return MISSION #
function FSM_PROCESS:GetMission() end

---Gets the task of the process.
---
------
---@param self FSM_PROCESS 
---@return TASK #
function FSM_PROCESS:GetTask() end


---
------
---@param self NOTYPE 
---@param FsmProcess NOTYPE 
function FSM_PROCESS:Init(FsmProcess) end

---Send a message of the Tasking.Task to the Group of the Unit.
---
------
---@param self FSM_PROCESS 
---@param Message NOTYPE 
function FSM_PROCESS:Message(Message) end

---Creates a new FSM_PROCESS object.
---
------
---@param self FSM_PROCESS 
---@param Controllable NOTYPE 
---@param Task NOTYPE 
---@return FSM_PROCESS #
function FSM_PROCESS:New(Controllable, Task) end

---Removes an FSM_PROCESS object.
---
------
---@param self FSM_PROCESS 
---@return FSM_PROCESS #
function FSM_PROCESS:Remove() end

---Sets the task of the process.
---
------
---@param self FSM_PROCESS 
---@param Task TASK 
---@return FSM_PROCESS #
function FSM_PROCESS:SetTask(Task) end


---
------
---@param self NOTYPE 
---@param step NOTYPE 
---@param trigger NOTYPE 
---@param params NOTYPE 
---@param EventName NOTYPE 
function FSM_PROCESS:_call_handler(step, trigger, params, EventName) end


---
------
---@param self NOTYPE 
---@param ProcessUnit NOTYPE 
---@param Task NOTYPE 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@private
function FSM_PROCESS:onenterFailed(ProcessUnit, Task, From, Event, To) end

---StateMachine callback function for a FSM_PROCESS
---
------
---@param self FSM_PROCESS 
---@param ProcessUnit CONTROLLABLE 
---@param Event string 
---@param From string 
---@param To string 
---@param Task NOTYPE 
---@private
function FSM_PROCESS:onstatechange(ProcessUnit, Event, From, To, Task) end


---FSM_SET class models Finite State Machines for Core.Sets.
---Note that these FSMs control multiple objects!!! So State concerns here
---for multiple objects or the position of the state machine in the process.
---
---===
---FSM_SET class
---@class FSM_SET : FSM
---@field Set SET_BASE 
FSM_SET = {}

---Gets the SET_BASE object that the FSM_SET governs.
---
------
---@param self FSM_SET 
---@return SET_BASE #
function FSM_SET:Get() end

---Creates a new FSM_SET object.
---
------
---@param self FSM_SET 
---@param FSMT table Finite State Machine Table
---@param Set_SET_BASE? NOTYPE FSMSet (optional) The Set object that the FSM_SET governs.
---@param FSMSet NOTYPE 
---@return FSM_SET #
function FSM_SET:New(FSMT, Set_SET_BASE, FSMSet) end


---
------
---@param self NOTYPE 
---@param step NOTYPE 
---@param trigger NOTYPE 
---@param params NOTYPE 
---@param EventName NOTYPE 
function FSM_SET:_call_handler(step, trigger, params, EventName) end


---Models Finite State Machines for Tasking.Tasks.
---
---===
---FSM_TASK class
---@class FSM_TASK : FSM
---@field Task TASK 
FSM_TASK = {}

---Creates a new FSM_TASK object.
---
------
---@param self FSM_TASK 
---@param TaskName string The name of the task.
---@return FSM_TASK #
function FSM_TASK:New(TaskName) end


---
------
---@param self NOTYPE 
---@param step NOTYPE 
---@param trigger NOTYPE 
---@param params NOTYPE 
---@param EventName NOTYPE 
function FSM_TASK:_call_handler(step, trigger, params, EventName) end



