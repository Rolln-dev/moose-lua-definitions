---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Utils_Profiler.jpg" width="100%">
---
---**Utils** - Lua Profiler.
---
---Find out how many times functions are called and how much real time it costs.
---
---===
---
---### Author: **TAW CougarNL**, *funkyfranky*
---*The emperor counsels simplicity.* *First principles.
---Of each particular thing, ask: What is it in itself, in its own constitution? What is its causal nature?*
---
---===
---
---![Banner Image](..\Presentations\Utilities\PROFILER_Main.jpg)
---
---# The PROFILER Concept
---
---Profile your lua code. This tells you, which functions are called very often and which consume most real time.
---With this information you can optimize the performance of your code.
---
---# Prerequisites
---
---The modules **os**, **io** and **lfs** need to be de-sanitized. Comment out the lines
---
---    --sanitizeModule('os')
---    --sanitizeModule('io')
---    --sanitizeModule('lfs')
---
---in your *"DCS World OpenBeta/Scripts/MissionScripting.lua"* file.
---
---But be aware that these changes can make you system vulnerable to attacks.
---
---# Disclaimer
---
---**Profiling itself is CPU expensive!** Don't use this when you want to fly or host a mission.
---
---
---# Start
---
---The profiler can simply be started with the #PROFILER.Start(*Delay, Duration*) function
---
---    PROFILER.Start()
---
---The optional parameter *Delay* can be used to delay the start by a certain amount of seconds and the optional parameter *Duration* can be used to
---stop the profiler after a certain amount of seconds.
---
---# Stop
---
---The profiler automatically stops when the mission ends. But it can be stopped any time with the #PROFILER.Stop(*Delay*) function
---
---    PROFILER.Stop()
---
---The optional parameter *Delay* can be used to specify a delay after which the profiler is stopped.
---
---When the profiler is stopped, the output is written to a file.
---
---# Output
---
---The profiler output is written to a file in your DCS home folder
---
---    X:\User\<Your User Name>\Saved Games\DCS OpenBeta\Logs
---
---The default file name is "MooseProfiler.txt". If that file exists, the file name is "MooseProfiler-001.txt" etc.
---
---## Data
---
---The data in the output file provides information on the functions that were called in the mission.
---
---It will tell you how many times a function was called in total, how many times per second, how much time in total and the percentage of time.
---
---If you only want output for functions that are called more than *X* times per second, you can set
---
---    PROFILER.ThreshCPS=1.5
---
---With this setting, only functions which are called more than 1.5 times per second are displayed. The default setting is PROFILER.ThreshCPS=0.0 (no threshold).
---
---Furthermore, you can limit the output for functions that consumed a certain amount of CPU time in total by
---
---    PROFILER.ThreshTtot=0.005
---
---With this setting, which is also the default, only functions which in total used more than 5 milliseconds CPU time.
---PROFILER class.
---@class PROFILER 
---@field ClassName string Name of the class.
---@field Counters table Function counters.
---@field ThreshCPS number Low calls per second threshold. Only write output if function has more calls per second than this value.
---@field ThreshTtot number Total time threshold. Only write output if total function CPU time is more than this value.
---@field TstartGame number Game start time timer.getTime().
---@field TstartOS number OS real start time os.clock.
---@field private dInfo table Info.
---@field private eventhandler table Event handler to get mission end event.
---@field private fTime table Function time.
---@field private fTimeTotal table Total function time.
---@field private fileNamePrefix string Output file name prefix, e.g. "MooseProfiler".
---@field private fileNameSuffix string Output file name prefix, e.g. "txt"
---@field private logUnknown boolean Log unknown functions. Default is off.
PROFILER = {}

---Start profiler.
---
------
---@param Delay number Delay in seconds before profiler is stated. Default is immediately.
---@param Duration number Duration in (game) seconds before the profiler is stopped. Default is when mission ends.
function PROFILER.Start(Delay, Duration) end

---Stop profiler.
---
------
---@param Delay number Delay before stop in seconds.
function PROFILER.Stop(Delay) end

---Write text to log file.
---
------
---@param f function The file.
---@param txt string The text.
function PROFILER._flog(f, txt) end

---Get data.
---
------
---@param func function Function.
---@return string #Function name.
---@return string #Source file name.
---@return string #Line number.
---@return number #Function time in seconds.
---@private
function PROFILER.getData(func) end

---Write info to output file.
---
------
---@param ext string Extension.
---@return string #File name.
---@private
function PROFILER.getfilename(ext) end

---Debug hook.
---
------
---@param event table Event.
---@private
function PROFILER.hook(event) end

---Print csv file.
---
------
---@param data table Data table.
---@param runTimeGame number Game run time in seconds.
---@private
function PROFILER.printCSV(data, runTimeGame) end

---Write info to output file.
---
------
---@param runTimeGame number Game time in seconds.
---@param runTimeOS number OS time in seconds.
---@private
function PROFILER.showInfo(runTimeGame, runTimeOS) end

---Show table.
---
------
---@param data table Data table.
---@param f function The file.
---@param runTimeGame number Game run time in seconds.
---@private
function PROFILER.showTable(data, f, runTimeGame) end


---Waypoint data.
---@class PROFILER.Data 
---@field private count number Number of function calls.
---@field private func string The function name.
---@field private line number The line number
---@field private src string The source file.
---@field private tm number Total time in seconds.
PROFILER.Data = {}



