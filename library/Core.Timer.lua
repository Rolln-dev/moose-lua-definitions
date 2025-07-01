---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Core_Scheduler.JPG" width="100%">
---
---**Core** - Timer scheduler.
---
---**Main Features:**
---
---   * Delay function calls
---   * Easy set up and little overhead
---   * Set start, stop and time interval
---   * Define max function calls
---
---===
---
---### Author: **funkyfranky**
---*Better three hours too soon than a minute too late.* - William Shakespeare
---
---===
---
---# The TIMER Concept
---
---The TIMER class is the little sister of the Core.Scheduler#SCHEDULER class.
---It does the same thing but is a bit easier to use and has less overhead. It should be sufficient in many cases.
---
---It provides an easy interface to the DCS [timer.scheduleFunction](https://wiki.hoggitworld.com/view/DCS_func_scheduleFunction).
---
---# Construction
---
---A new TIMER is created by the #TIMER.New(*func*, *...*) function
---
---    local mytimer=TIMER:New(myfunction, a, b)
---    
---The first parameter *func* is the function that is called followed by the necessary comma separeted parameters that are passed to that function.
---
---## Starting the Timer
---
---The timer is started by the #TIMER.Start(*Tstart*, *dT*, *Duration*) function
---
---    mytimer:Start(5, 1, 20)
---    
---where
---
---* *Tstart* is the relative start time in seconds. In the example, the first function call happens after 5 sec.
---* *dT* is the time interval between function calls in seconds. Above, the function is called once per second.
---* *Duration* is the duration in seconds after which the timer is stopped. This is relative to the start time. Here, the timer will run for 20 seconds.
--- 
---Note that
---
---* if *Tstart* is not specified (*nil*), the first function call happens immediately, i.e. after one millisecond.
---* if *dT* is not specified (*nil*), the function is called only once.
---* if *Duration* is not specified (*nil*), the timer runs forever or until stopped manually or until the max function calls are reached (see below).
---
---For example,
---
---    mytimer:Start(3)            -- Will call the function once after 3 seconds.
---    mytimer:Start(nil, 0.5)     -- Will call right now and then every 0.5 sec until all eternity.
---    mytimer:Start(nil, 2.0, 20) -- Will call right now and then every 2.0 sec for 20 sec.
---    mytimer:Start(1.0, nil, 10) -- Does not make sense as the function is only called once anyway. 
---
---## Stopping the Timer
---
---The timer can be stopped manually by the #TIMER.Stop(*Delay*) function
---
---    mytimer:Stop()
---
---If the optional paramter *Delay* is specified, the timer is stopped after *delay* seconds.
---
---## Limit Function Calls
---
---The timer can be stopped after a certain amount of function calles with the #TIMER.SetMaxFunctionCalls(*Nmax*) function
---
---    mytimer:SetMaxFunctionCalls(20)
---
---where *Nmax* is the number of calls after which the timer is stopped, here 20.
---
---For example,
---
---    mytimer:SetMaxFunctionCalls(66):Start(1.0, 0.1)
---    
---will start the timer after one second and call the function every 0.1 seconds. Once the function has been called 66 times, the timer is stopped.
---TIMER class.
---@class TIMER : BASE
---@field ClassName string Name of the class.
---@field Tstart number Relative start time in seconds.
---@field Tstop number Relative stop time in seconds.
---@field private dT number Time interval between function calls in seconds.
---@field private func function Timer function.
---@field private isrunning boolean If `true`, timer is running. Else it was not started yet or was stopped.
---@field private lid string Class id string for output to DCS log file.
---@field private ncalls number Counter of function calls.
---@field private ncallsMax number Max number of function calls. If reached, timer is stopped.
---@field private para table Parameters passed to the timer function.
---@field private tid number Timer ID returned by the DCS API function.
---@field private uid number Unique ID of the timer.
---@field private version string TIMER class version.
TIMER = {}

---Check if the timer has been started and was not stopped.
---
------
---@param self TIMER 
---@return boolean #If `true`, the timer is running.
function TIMER:IsRunning() end

---Create a new TIMER object.
---
------
---@param self TIMER 
---@param Function function The function to call.
---@param ... NOTYPE Parameters passed to the function if any.
---@return TIMER #self
function TIMER:New(Function, ...) end

---Set max number of function calls.
---When the function has been called this many times, the TIMER is stopped.
---
------
---@param self TIMER 
---@param Nmax number Set number of max function calls.
---@return TIMER #self
function TIMER:SetMaxFunctionCalls(Nmax) end

---Set time interval.
---Can also be set when the timer is already running and is applied after the next function call.
---
------
---@param self TIMER 
---@param dT number Time interval in seconds.
---@return TIMER #self
function TIMER:SetTimeInterval(dT) end

---Start TIMER object.
---
------
---@param self TIMER 
---@param Tstart number Relative start time in seconds.
---@param dT number Interval between function calls in seconds. If not specified `nil`, the function is called only once.
---@param Duration number Time in seconds for how long the timer is running. If not specified `nil`, the timer runs forever or until stopped manually by the `TIMER:Stop()` function.
---@return TIMER #self
function TIMER:Start(Tstart, dT, Duration) end

---Start TIMER object if a condition is met.
---Useful for e.g. debugging.
---
------
---@param self TIMER 
---@param Condition boolean Must be true for the TIMER to start
---@param Tstart number Relative start time in seconds.
---@param dT number Interval between function calls in seconds. If not specified `nil`, the function is called only once.
---@param Duration number Time in seconds for how long the timer is running. If not specified `nil`, the timer runs forever or until stopped manually by the `TIMER:Stop()` function.
---@return TIMER #self
function TIMER:StartIf(Condition, Tstart, dT, Duration) end

---Stop the timer by removing the timer function.
---
------
---@param self TIMER 
---@param Delay? number (Optional) Delay in seconds, before the timer is stopped.
---@return TIMER #self
function TIMER:Stop(Delay) end

---Call timer function.
---
------
---@param self TIMER 
---@param time number DCS model time in seconds.
---@return number #Time when the function is called again or `nil` if the timer is stopped.
function TIMER:_Function(time) end



