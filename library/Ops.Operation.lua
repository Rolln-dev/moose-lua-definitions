---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/OPS_Operation.png" width="100%">
---
---**Ops** - Operation with multiple phases.
---
---## Main Features:
---
---   * Define operation phases
---   * Define conditions when phases are over
---   * Option to have branches in the phase tree
---   * Dedicate resources to operations
---
---===
---
---## Example Missions:
---
---Demo missions can be found on [github](https://github.com/FlightControl-Master/MOOSE_MISSIONS/tree/develop/Ops/Operation).
---
---===
---
---### Author: **funkyfranky**
---
---===
---*Before this time tomorrow I shall have gained a peerage, or Westminster Abbey.* -- Horatio Nelson
---
---===
---
---# The OPERATION Concept
---
---This class allows you to create complex operations, which consist of multiple phases.
---Conditions can be specified, when a phase is over. If a phase is over, the next phase is started.
---FSM events can be used to customize code that is executed at each phase. Phases can also switched manually, of course.
---
---In the simplest case, adding phases leads to a linear chain. However, you can also create branches to contruct a more tree like structure of phases. You can switch between branches 
---manually or add "edges" with conditions when to switch branches. We are diving a bit into graph theory here. So don't feel embarrassed at all, if you stick to linear chains.
---
---# Constructor
---
---A new operation can be created with the #OPERATION.New(*Name*) function, where the parameter `Name` is a free to choose string.
---
---## Adding Phases
---
---You can add phases with the  #OPERATION.AddPhase(*Name*, *Branch*) function. The first parameter `Name` is the name of the phase. The second parameter `Branch` is the branch to which the phase is
---added. If this is omitted (nil), the phase is added to the default, *i.e.* "master branch". More about adding branches later.
---
---
---OPERATION class.
---@class OPERATION : FSM
---@field ClassName string Name of the class.
---@field Tstart number Start time in seconds of abs mission time.
---@field Tstop number Stop time in seconds of abs mission time.
---@field conditionOver CONDITION Over condition.
---@field conditionStart CONDITION Start condition.
---@field counterBranch number Running number counting the branches.
---@field counterPhase number Running number counting the phases.
---@field duration number Duration of the operation in seconds.
---@field lid string Class id string for output to DCS log file.
---@field name string Name of the operation.
---@field uid number Unique ID of the operation.
---@field verbose number Verbosity level.
---@field version string OPERATION class version.
OPERATION = {}

---Add a new branch to the operation.
---
------
---@param self OPERATION 
---@param Name string 
---@return OPERATION.Branch #Branch table object.
function OPERATION:AddBranch(Name) end

---Add (all) condition function when the whole operation is over.
---Must return a `#boolean`.
---
------
---@param self OPERATION 
---@param Function function Function that needs to be `true` before the operation is over. 
---@param ... NOTYPE Condition function arguments if any.
---@return CONDITION.Function #Condition function table.
function OPERATION:AddConditonOverAll(Function, ...) end

---Add (any) condition function when the whole operation is over.
---Must return a `#boolean`.
---
------
---@param self OPERATION 
---@param Function function Function that needs to be `true` before the operation is over. 
---@param ... NOTYPE Condition function arguments if any.
---@param Phase NOTYPE 
---@return CONDITION.Function #Condition function table.
function OPERATION:AddConditonOverAny(Function, ..., Phase) end

---Add an edge between two branches.
---
------
---@param self OPERATION 
---@param PhaseFrom OPERATION.Phase The phase of the *from* branch *after* which to switch.
---@param PhaseTo OPERATION.Phase The phase of the *to* branch *to* which to switch.
---@param ConditionSwitch CONDITION (Optional) Condition(s) when to switch the branches.
---@return OPERATION.Edge #Edge table object.
function OPERATION:AddEdge(PhaseFrom, PhaseTo, ConditionSwitch) end

---Add condition function to an edge when branches are switched.
---The function must return a `#boolean`.
---If multiple condition functions are added, all of these must return true for the branch switch to occur.
---
------
---@param self OPERATION 
---@param Edge OPERATION.Edge The edge connecting the two branches.
---@param Function function Function that needs to be `true` for switching between the branches. 
---@param ... NOTYPE Condition function arguments if any.
---@return CONDITION.Function #Condition function table.
function OPERATION:AddEdgeConditonSwitchAll(Edge, Function, ...) end

---Add mission to operation.
---
------
---@param self OPERATION 
---@param Mission AUFTRAG The mission to add.
---@param Phase OPERATION.Phase (Optional) The phase in which the mission should be executed. If no phase is given, it will be exectuted ASAP.
function OPERATION:AddMission(Mission, Phase) end

---Add a new phase to the operation.
---This is added add the end of all previously added phases (if any).
---
------
---@param self OPERATION 
---@param Name string Name of the phase. Default "Phase-01" where the last number is a running number.
---@param Branch OPERATION.Branch The branch to which this phase is added. Default is the master branch.
---@param Duration number Duration in seconds how long the phase will last. Default `nil`=forever.
---@return OPERATION.Phase #Phase table object.
function OPERATION:AddPhase(Name, Branch, Duration) end

---Add condition function when the given phase is over.
---Must return a `#boolean`.
---
------
---@param self OPERATION 
---@param Phase OPERATION.Phase The phase.
---@param Function function Function that needs to be `true` before the phase is over. 
---@param ... NOTYPE Condition function arguments if any.
---@return CONDITION.Function #Condition function table.
function OPERATION:AddPhaseConditonOverAll(Phase, Function, ...) end

---Add condition function when the given phase is over.
---Must return a `#boolean`.
---
------
---@param self OPERATION 
---@param Phase OPERATION.Phase The phase.
---@param Function function Function that needs to be `true` before the phase is over. 
---@param ... NOTYPE Condition function arguments if any.
---@return CONDITION.Function #Condition function table.
function OPERATION:AddPhaseConditonOverAny(Phase, Function, ...) end

---Add condition function when the given phase is to be repeated.
---The provided function must return a `#boolean`.
---If the condition evaluation returns `true`, the phase is set to state `Planned` instead of `Over` and can be repeated.
---
------
---@param self OPERATION 
---@param Phase OPERATION.Phase The phase.
---@param Function function Function that needs to be `true` before the phase is over. 
---@param ... NOTYPE Condition function arguments if any.
---@return OPERATION #self
function OPERATION:AddPhaseConditonRepeatAll(Phase, Function, ...) end

---Add Target to operation.
---
------
---@param self OPERATION 
---@param Target TARGET The target to add.
---@param Phase OPERATION.Phase (Optional) The phase in which the target should be attacked. If no phase is given, it will be attacked ASAP.
function OPERATION:AddTarget(Target, Phase) end

---Assign cohort to operation.
---
------
---@param self OPERATION 
---@param Cohort COHORT The cohort
---@return OPERATION #self
function OPERATION:AssignCohort(Cohort) end

---Assign legion to operation.
---All cohorts of this legion will be assigned and are only available.
---
------
---@param self OPERATION 
---@param Legion LEGION The legion to be assigned.
---@return OPERATION #self
function OPERATION:AssignLegion(Legion) end

---Triggers the FSM event "BranchSwitch".
---
------
---@param self OPERATION 
---@param Branch OPERATION.Branch The branch that is now active.
---@param Phase OPERATION.Phase The new phase.
function OPERATION:BranchSwitch(Branch, Phase) end

---Count phases.
---
------
---@param self OPERATION 
---@param Status string (Optional) Only count phases in a certain status, e.g. `OPERATION.PhaseStatus.PLANNED`.
---@param Branch OPERATION.Branch (Optional) Branch.
---@return number #Number of phases
function OPERATION:CountPhases(Status, Branch) end

---Count targets alive.
---
------
---@param self OPERATION 
---@param Phase OPERATION.Phase (Optional) Only count targets set for this phase.
---@return number #Number of phases
function OPERATION:CountTargets(Phase) end

---Get the currently active branch.
---
------
---@param self OPERATION 
---@return OPERATION.Branch #The active branch. If no branch is active, the master branch is returned.
function OPERATION:GetBranchActive() end

---Get the master branch.
---This is the default branch and should always exist (if it was not explicitly deleted).
---
------
---@param self OPERATION 
---@return OPERATION.Branch #The master branch.
function OPERATION:GetBranchMaster() end

---Get name of the branch.
---
------
---@param self OPERATION 
---@param Branch OPERATION.Branch The branch of which the name is requested. Default is the currently active or master branch.
---@return string #Name Name or "None"
function OPERATION:GetBranchName(Branch) end

---Get a name of this operation.
---
------
---@param self OPERATION 
---@return string #Name of this operation or "Unknown".
function OPERATION:GetName() end

---Get currrently active phase.
---
------
---@param self OPERATION 
---@return OPERATION.Phase #Current phase or `nil` if no current phase is active.
function OPERATION:GetPhaseActive() end

---Get a phase by its name.
---
------
---@param self OPERATION 
---@param Name string Name of the phase. Default "Phase-01" where the last number is a running number.
---@return OPERATION.Phase #Phase table object or nil if phase could not be found.
function OPERATION:GetPhaseByName(Name) end

---Get condition when the given phase is over.
---
------
---@param self OPERATION 
---@param Phase OPERATION.Phase The phase.
---@param Condition NOTYPE 
---@return CONDITION #Condition when the phase is over (if any).
function OPERATION:GetPhaseConditonOver(Phase, Condition) end

---Get index of phase.
---
------
---@param self OPERATION 
---@param Phase OPERATION.Phase The phase.
---@return number #The index.
---@return OPERATION.Branch #The branch.
function OPERATION:GetPhaseIndex(Phase) end

---Get how many times a phase has been active.
---
------
---@param self OPERATION 
---@param Phase OPERATION.Phase The phase.
---@return number #Number of times the phase has been active.
function OPERATION:GetPhaseNactive(Phase) end

---Get name of a phase.
---
------
---@param self OPERATION 
---@param Phase OPERATION.Phase The phase of which the name is returned. Default is the currently active phase.
---@return string #The name of the phase or "None" if no phase is given or active.
function OPERATION:GetPhaseName(Phase) end

---Get next phase.
---
------
---@param self OPERATION 
---@param Branch OPERATION.Branch (Optional) The branch from which the next phase is retrieved. Default is the currently active branch.
---@param PhaseStatus string (Optional) Only return a phase, which is in this status. For example, `OPERATION.PhaseStatus.PLANNED` to make sure, the next phase is planned.
---@return OPERATION.Phase #Next phase or `nil` if no next phase exists.
function OPERATION:GetPhaseNext(Branch, PhaseStatus) end

---Get status of a phase.
---
------
---@param self OPERATION 
---@param Phase OPERATION.Phase The phase.
---@return string #Phase status, *e.g.* `OPERATION.PhaseStatus.OVER`.
function OPERATION:GetPhaseStatus(Phase) end

---Get targets of operation.
---
------
---@param self OPERATION 
---@param Phase OPERATION.Phase (Optional) Only return targets set for this phase. Default is targets of all phases.
---@return table #Targets Table of #TARGET objects 
function OPERATION:GetTargets(Phase) end

---Insert a new phase after an already defined phase of the operation.
---
------
---@param self OPERATION 
---@param PhaseAfter OPERATION.Phase The phase after which the new phase is inserted.
---@param Name string Name of the phase. Default "Phase-01" where the last number is a running number.
---@return OPERATION.Phase #Phase table object.
function OPERATION:InsertPhaseAfter(PhaseAfter, Name) end

---Check if a given cohort is assigned to this operation.
---
------
---@param self OPERATION 
---@param Cohort COHORT The Cohort.
---@return boolean #If `true`, cohort is assigned to this operation.
function OPERATION:IsAssignedCohort(Cohort) end

---Check if a given cohort or legion is assigned to this operation.
---
------
---@param self OPERATION 
---@param Object OBJECT The cohort or legion object.
---@return boolean #If `true`, cohort is assigned to this operation.
function OPERATION:IsAssignedCohortOrLegion(Object) end

---Check if a given legion is assigned to this operation.
---All cohorts of this legion will be checked.
---
------
---@param self OPERATION 
---@param Legion LEGION The legion to be assigned.
---@return boolean #If `true`, legion is assigned to this operation.
function OPERATION:IsAssignedLegion(Legion) end

---Check if operation is **not** "Over" or "Stopped".
---
------
---@param self OPERATION 
---@return boolean #If `true`, operation is not "Over" or "Stopped".
function OPERATION:IsNotOver() end

---Check if operation is in FSM state "Over".
---
------
---@param self OPERATION 
---@return boolean #If `true`, operation is "Over".
function OPERATION:IsOver() end

---Check if operation is in FSM state "Paused".
---
------
---@param self OPERATION 
---@return boolean #If `true`, operation is "Paused".
function OPERATION:IsPaused() end

---Check if phase is in status "Active".
---
------
---@param self OPERATION 
---@param Phase OPERATION.Phase The phase.
---@return boolean #If `true`, phase is active.
function OPERATION:IsPhaseActive(Phase) end

---Check if phase is in status "Over".
---
------
---@param self OPERATION 
---@param Phase OPERATION.Phase The phase.
---@return boolean #If `true`, phase is over.
function OPERATION:IsPhaseOver(Phase) end

---Check if phase is in status "Planned".
---
------
---@param self OPERATION 
---@param Phase OPERATION.Phase The phase.
---@return boolean #If `true`, phase is Planned.
function OPERATION:IsPhasePlanned(Phase) end

---Check if operation is in FSM state "Planned".
---
------
---@param self OPERATION 
---@return boolean #If `true`, operation is "Planned".
function OPERATION:IsPlanned() end

---Check if operation is in FSM state "Running".
---
------
---@param self OPERATION 
---@return boolean #If `true`, operation is "Running".
function OPERATION:IsRunning() end

---Check if operation is in FSM state "Stopped".
---
------
---@param self OPERATION 
---@return boolean #If `true`, operation is "Stopped".
function OPERATION:IsStopped() end

---Create a new generic OPERATION object.
---
------
---@param self OPERATION 
---@param Name string Name of the operation. Be creative! Default "Operation-01" where the last number is a running number.
---@return OPERATION #self
function OPERATION:New(Name) end

---On after "BranchSwitch" event.
---
------
---@param self OPERATION 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Branch OPERATION.Branch The branch that is now active.
---@param Phase OPERATION.Phase The new phase.
function OPERATION:OnAfterBranchSwitch(From, Event, To, Branch, Phase) end

---On after "Over" event.
---
------
---@param self OPERATION 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function OPERATION:OnAfterOver(From, Event, To) end

---On after "PhaseChange" event.
---
------
---@param self OPERATION 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Phase OPERATION.Phase The new phase.
function OPERATION:OnAfterPhaseChange(From, Event, To, Phase) end

---On after "PhaseNext" event.
---
------
---@param self OPERATION 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function OPERATION:OnAfterPhaseNext(From, Event, To) end

---On after "PhaseOver" event.
---
------
---@param self OPERATION 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Phase OPERATION.Phase The phase that is over.
function OPERATION:OnAfterPhaseOver(From, Event, To, Phase) end

---On after "Start" event.
---
------
---@param self OPERATION 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function OPERATION:OnAfterStart(From, Event, To) end

---Triggers the FSM event "Over".
---
------
---@param self OPERATION 
function OPERATION:Over() end

---Triggers the FSM event "PhaseChange".
---
------
---@param self OPERATION 
---@param Phase OPERATION.Phase The new phase.
function OPERATION:PhaseChange(Phase) end

---Triggers the FSM event "PhaseNext".
---
------
---@param self OPERATION 
function OPERATION:PhaseNext() end

---Triggers the FSM event "PhaseOver".
---
------
---@param self OPERATION 
---@param Phase OPERATION.Phase The phase that is over.
function OPERATION:PhaseOver(Phase) end

---Set persistence of condition function.
---By default, condition functions are removed after a phase is over.
---
------
---@param self OPERATION 
---@param ConditionFunction CONDITION.Function Condition function table.
---@param IsPersistent boolean If `true` or `nil`, condition function is persistent.
---@return OPERATION #self
function OPERATION:SetConditionFunctionPersistence(ConditionFunction, IsPersistent) end

---Set condition when the given phase is over.
---
------
---@param self OPERATION 
---@param Phase OPERATION.Phase The phase.
---@param Condition CONDITION Condition when the phase is over.
---@return OPERATION #self
function OPERATION:SetPhaseConditonOver(Phase, Condition) end

---Set status of a phase.
---
------
---@param self OPERATION 
---@param Phase OPERATION.Phase The phase.
---@param Status string New status, *e.g.* `OPERATION.PhaseStatus.OVER`.
---@return OPERATION #self
function OPERATION:SetPhaseStatus(Phase, Status) end

---Set start and stop time of the operation.
---
------
---@param self OPERATION 
---@param ClockStart string Time the mission is started, e.g. "05:00" for 5 am. If specified as a #number, it will be relative (in seconds) to the current mission time. Default is 5 seconds after mission was added.
---@param ClockStop string (Optional) Time the mission is stopped, e.g. "13:00" for 1 pm. If mission could not be started at that time, it will be removed from the queue. If specified as a #number it will be relative (in seconds) to the current mission time.
---@return OPERATION #self
function OPERATION:SetTime(ClockStart, ClockStop) end

---Set verbosity level.
---
------
---@param self OPERATION 
---@param VerbosityLevel number Level of output (higher=more). Default 0.
---@return OPERATION #self
function OPERATION:SetVerbosity(VerbosityLevel) end

---Triggers the FSM event "Start".
---
------
---@param self OPERATION 
function OPERATION:Start() end

---Triggers the FSM event "StatusUpdate".
---
------
---@param self OPERATION 
function OPERATION:StatusUpdate() end

---Triggers the FSM event "Stop".
---
------
---@param self OPERATION 
function OPERATION:Stop() end

---Check phases.
---
------
---@param self OPERATION 
function OPERATION:_CheckPhases() end

---Create a new branch object.
---
------
---@param self OPERATION 
---@param Name string Name of the phase. Default "Phase-01" where the last number is a running number.
---@return OPERATION.Branch #Branch table object.
function OPERATION:_CreateBranch(Name) end

---Create a new phase object.
---
------
---@param self OPERATION 
---@param Name string Name of the phase. Default "Phase-01" where the last number is a running number.
---@return OPERATION.Phase #Phase table object.
function OPERATION:_CreatePhase(Name) end

---Triggers the FSM event "BranchSwitch" after a delay.
---
------
---@param self OPERATION 
---@param delay number Delay in seconds.
---@param Branch OPERATION.Branch The branch that is now active.
---@param Phase OPERATION.Phase The new phase.
function OPERATION:__BranchSwitch(delay, Branch, Phase) end

---Triggers the FSM event "Over" after a delay.
---
------
---@param self OPERATION 
---@param delay number Delay in seconds.
function OPERATION:__Over(delay) end

---Triggers the FSM event "PhaseChange" after a delay.
---
------
---@param self OPERATION 
---@param delay number Delay in seconds.
---@param Phase OPERATION.Phase The new phase.
function OPERATION:__PhaseChange(delay, Phase) end

---Triggers the FSM event "PhaseNext" after a delay.
---
------
---@param self OPERATION 
---@param delay number Delay in seconds.
function OPERATION:__PhaseNext(delay) end

---Triggers the FSM event "PhaseOver" after a delay.
---
------
---@param self OPERATION 
---@param delay number Delay in seconds.
---@param Phase OPERATION.Phase The phase that is over.
function OPERATION:__PhaseOver(delay, Phase) end

---Triggers the FSM event "Start" after a delay.
---
------
---@param self OPERATION 
---@param delay number Delay in seconds.
function OPERATION:__Start(delay) end

---Triggers the FSM event "Status" after a delay.
---
------
---@param self OPERATION 
---@param delay number Delay in seconds.
function OPERATION:__StatusUpdate(delay) end

---Triggers the FSM event "Stop" after a delay.
---
------
---@param self OPERATION 
---@param delay number Delay in seconds.
function OPERATION:__Stop(delay) end

---On after "BranchSwitch" event.
---
------
---@param self OPERATION 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Branch OPERATION.Branch The new branch.
---@param Phase OPERATION.Phase The phase.
function OPERATION:onafterBranchSwitch(From, Event, To, Branch, Phase) end

---On after "Over" event.
---
------
---@param self OPERATION 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function OPERATION:onafterOver(From, Event, To) end

---On after "PhaseChange" event.
---
------
---@param self OPERATION 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Phase OPERATION.Phase The new phase.
function OPERATION:onafterPhaseChange(From, Event, To, Phase) end

---On after "PhaseNext" event.
---
------
---@param self OPERATION 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function OPERATION:onafterPhaseNext(From, Event, To) end

---On after "PhaseOver" event.
---
------
---@param self OPERATION 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Phase OPERATION.Phase The phase that is over.
function OPERATION:onafterPhaseOver(From, Event, To, Phase) end

---On after "Start" event.
---
------
---@param self OPERATION 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function OPERATION:onafterStart(From, Event, To) end

---On after "StatusUpdate" event.
---
------
---@param self OPERATION 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function OPERATION:onafterStatusUpdate(From, Event, To) end


---Operation branch.
---@class OPERATION.Branch 
---@field name string Name of the branch.
---@field uid number Unique ID of the branch.
OPERATION.Branch = {}


---Operation edge.
---@class OPERATION.Edge 
---@field conditionSwitch CONDITION Conditions when to switch the branch.
---@field uid number Unique ID of the edge.
OPERATION.Edge = {}


---Operation phase.
---@class OPERATION.Phase 
---@field Tstart number Abs. mission time when the phase was started.
---@field conditionOver CONDITION Conditions when the phase is over.
---@field duration number Duration in seconds how long the phase should be active after it started.
---@field nActive number Number of times the phase was active.
---@field name string Name of the phase.
---@field status string Phase status.
---@field uid number Unique ID of the phase.
OPERATION.Phase = {}


---Operation phase.
---@class OPERATION.PhaseStatus 
---@field ACTIVE string Active phase.
---@field OVER string Phase is over.
---@field PLANNED string Planned.
OPERATION.PhaseStatus = {}



