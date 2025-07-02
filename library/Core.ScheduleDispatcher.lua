---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Core_Schedule_Dispatcher.JPG" width="100%">
---
---- **Core** - SCHEDULEDISPATCHER dispatches the different schedules.
---
---===
---
---Takes care of the creation and dispatching of scheduled functions for SCHEDULER objects.
---
---This class is tricky and needs some thorough explanation.
---SCHEDULE classes are used to schedule functions for objects, or as persistent objects.
---The SCHEDULEDISPATCHER class ensures that:
---
---  - Scheduled functions are planned according the SCHEDULER object parameters.
---  - Scheduled functions are repeated when requested, according the SCHEDULER object parameters.
---  - Scheduled functions are automatically removed when the schedule is finished, according the SCHEDULER object parameters.
---
---The SCHEDULEDISPATCHER class will manage SCHEDULER object in memory during garbage collection:
---
---  - When a SCHEDULER object is not attached to another object (that is, it's first :Schedule() parameter is nil), then the SCHEDULER object is _persistent_ within memory.
---  - When a SCHEDULER object *is* attached to another object, then the SCHEDULER object is _not persistent_ within memory after a garbage collection!
---
---The non-persistency of SCHEDULERS attached to objects is required to allow SCHEDULER objects to be garbage collected when the parent object is destroyed, or set to nil and garbage collected.
---Even when there are pending timer scheduled functions to be executed for the SCHEDULER object,
---these will not be executed anymore when the SCHEDULER object has been destroyed.
---
---The SCHEDULEDISPATCHER allows multiple scheduled functions to be planned and executed for one SCHEDULER object.
---The SCHEDULER object therefore keeps a table of "CallID's", which are returned after each planning of a new scheduled function by the SCHEDULEDISPATCHER.
---The SCHEDULER object plans new scheduled functions through the Core.Scheduler#SCHEDULER.Schedule() method.
---The Schedule() method returns the CallID that is the reference ID for each planned schedule.
---
---===
---
---### Contributions: -
---### Authors: FlightControl : Design & Programming
---The SCHEDULEDISPATCHER structure
---@class SCHEDULEDISPATCHER : BASE
---@field CallID number Call ID counter.
---@field ClassName string Name of the class.
---@field ObjectSchedulers table Schedulers that only exist as long as the master object exists.
---@field PersistentSchedulers table Persistent schedulers.
---@field Schedule table Meta table setmetatable( {}, { __mode = "k" } ).
SCHEDULEDISPATCHER = {}

---Add a Schedule to the ScheduleDispatcher.
---The development of this method was really tidy.
---It is constructed as such that a garbage collection is executed on the weak tables, when the Scheduler is set to nil.
---Nothing of this code should be modified without testing it thoroughly.
---
------
---@param Scheduler SCHEDULER Scheduler object.
---@param ScheduleFunction function Scheduler function.
---@param ScheduleArguments table Table of arguments passed to the ScheduleFunction.
---@param Start number Start time in seconds.
---@param Repeat number Repeat interval in seconds.
---@param Randomize number Randomization factor [0,1].
---@param Stop number Stop time in seconds.
---@param TraceLevel number Trace level [0,3].
---@param Fsm FSM Finite state model.
---@return string #Call ID or nil.
function SCHEDULEDISPATCHER:AddSchedule(Scheduler, ScheduleFunction, ScheduleArguments, Start, Repeat, Randomize, Stop, TraceLevel, Fsm) end

---Clear all schedules by stopping all dispatchers.
---
------
---@param Scheduler SCHEDULER Scheduler object.
function SCHEDULEDISPATCHER:Clear(Scheduler) end

---Create a new schedule dispatcher object.
---
------
---@return SCHEDULEDISPATCHER #self
function SCHEDULEDISPATCHER:New() end

---No tracing info.
---
------
---@param Scheduler SCHEDULER Scheduler object.
function SCHEDULEDISPATCHER:NoTrace(Scheduler) end

---Remove schedule.
---
------
---@param Scheduler SCHEDULER Scheduler object.
---@param CallID table Call ID.
function SCHEDULEDISPATCHER:RemoveSchedule(Scheduler, CallID) end

---Show tracing info.
---
------
---@param Scheduler SCHEDULER Scheduler object.
function SCHEDULEDISPATCHER:ShowTrace(Scheduler) end

---Start dispatcher.
---
------
---@param Scheduler SCHEDULER Scheduler object.
---@param CallID? table (Optional) Call ID.
---@param Info? string (Optional) Debug info.
function SCHEDULEDISPATCHER:Start(Scheduler, CallID, Info) end

---Stop dispatcher.
---
------
---@param Scheduler SCHEDULER Scheduler object.
---@param CallID? string (Optional) Scheduler Call ID. If nil, all pending schedules are stopped recursively.
function SCHEDULEDISPATCHER:Stop(Scheduler, CallID) end


---Player data table holding all important parameters of each player.
---@class SCHEDULEDISPATCHER.ScheduleData 
---@field Arguments table Schedule function arguments.
---@field CallHandler function Function to be passed to the DCS timer.scheduleFunction().
---@field Function function The schedule function to be called.
---@field Randomize number Randomization factor [0,1].
---@field Repeat number Repeat time interval in seconds.
---@field ScheduleID number Schedule ID.
---@field ShowTrace boolean If true, show tracing info.
---@field Start number Start time in seconds.
---@field StartTime number Time in seconds when the scheduler is created.
---@field Stop number Stop time in seconds.
SCHEDULEDISPATCHER.ScheduleData = {}



