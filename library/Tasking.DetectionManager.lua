---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Task_Detection_Manager.JPG" width="100%">
---
---**Tasking** - This module contains the DETECTION_MANAGER class and derived classes.
---
---===
---
---The #DETECTION_MANAGER class defines the core functions to report detected objects to groups.
---Reportings can be done in several manners, and it is up to the derived classes if DETECTION_MANAGER to model the reporting behaviour.
---
---![Banner Image](..\Images\deprecated.png)
---
---1.1) DETECTION_MANAGER constructor:
--------------------------------------
---  * #DETECTION_MANAGER.New(): Create a new DETECTION_MANAGER instance.
---
---1.2) DETECTION_MANAGER reporting:
------------------------------------
---Derived DETECTION_MANAGER classes will reports detected units using the method #DETECTION_MANAGER.ReportDetected(). This method implements polymorphic behaviour.
---
---The time interval in seconds of the reporting can be changed using the methods #DETECTION_MANAGER.SetRefreshTimeInterval(). 
---To control how long a reporting message is displayed, use #DETECTION_MANAGER.SetReportDisplayTime().
---Derived classes need to implement the method #DETECTION_MANAGER.GetReportDisplayTime() to use the correct display time for displayed messages during a report.
---
---Reporting can be started and stopped using the methods #DETECTION_MANAGER.StartReporting() and #DETECTION_MANAGER.StopReporting() respectively.
---If an ad-hoc report is requested, use the method #DETECTION_MANAGER.ReportNow().
---
---The default reporting interval is every 60 seconds. The reporting messages are displayed 15 seconds.
---
---===
---
---2) #DETECTION_REPORTING class, extends #DETECTION_MANAGER
---===
---The #DETECTION_REPORTING class implements detected units reporting. Reporting can be controlled using the reporting methods available in the Tasking.DetectionManager#DETECTION_MANAGER class.
---
---2.1) DETECTION_REPORTING constructor:
----------------------------------
---The #DETECTION_REPORTING.New() method creates a new DETECTION_REPORTING instance.
---   
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
---DETECTION_MANAGER class.
---@class DETECTION_MANAGER 
---@field CC NOTYPE 
---@field Detection NOTYPE 
---@field SetGroup NOTYPE 
---@field _RefreshTimeInterval NOTYPE 
---@field _ReportDisplayTime NOTYPE 
DETECTION_MANAGER = {}

---Get the command center to communicate actions to the players.
---
------
---@param self DETECTION_MANAGER 
---@return COMMANDCENTER #The command center.
function DETECTION_MANAGER:GetCommandCenter() end

---Get the reporting message display time.
---
------
---@param self DETECTION_MANAGER 
---@return number #ReportDisplayTime The display time in seconds when a report needs to be done.
function DETECTION_MANAGER:GetReportDisplayTime() end

---Send an information message to the players reporting to the command center.
---
------
---@param self DETECTION_MANAGER 
---@param Squadron table The squadron table.
---@param Message string The message to be sent.
---@param SoundFile string The name of the sound file .wav or .ogg.
---@param SoundDuration number The duration of the sound.
---@param SoundPath string The path pointing to the folder in the mission file.
---@param DefenderGroup GROUP The defender group sending the message.
---@return DETECTION_MANGER #self
function DETECTION_MANAGER:MessageToPlayers(Squadron, Message, SoundFile, SoundDuration, SoundPath, DefenderGroup) end

---FAC constructor.
---
------
---@param self DETECTION_MANAGER 
---@param SetGroup SET_GROUP 
---@param Detection DETECTION_BASE 
---@return DETECTION_MANAGER #self
function DETECTION_MANAGER:New(SetGroup, Detection) end

---Aborted Handler OnAfter for DETECTION_MANAGER
---
------
---@param self DETECTION_MANAGER 
---@param From string 
---@param Event string 
---@param To string 
---@param Task TASK 
function DETECTION_MANAGER:OnAfterAborted(From, Event, To, Task) end

---Cancelled Handler OnAfter for DETECTION_MANAGER
---
------
---@param self DETECTION_MANAGER 
---@param From string 
---@param Event string 
---@param To string 
---@param Task TASK 
function DETECTION_MANAGER:OnAfterCancelled(From, Event, To, Task) end

---Failed Handler OnAfter for DETECTION_MANAGER
---
------
---@param self DETECTION_MANAGER 
---@param From string 
---@param Event string 
---@param To string 
---@param Task TASK 
function DETECTION_MANAGER:OnAfterFailed(From, Event, To, Task) end

---Start Handler OnAfter for DETECTION_MANAGER
---
------
---@param self DETECTION_MANAGER 
---@param From string 
---@param Event string 
---@param To string 
function DETECTION_MANAGER:OnAfterStart(From, Event, To) end

---Stop Handler OnAfter for DETECTION_MANAGER
---
------
---@param self DETECTION_MANAGER 
---@param From string 
---@param Event string 
---@param To string 
function DETECTION_MANAGER:OnAfterStop(From, Event, To) end

---Success Handler OnAfter for DETECTION_MANAGER
---
------
---@param self DETECTION_MANAGER 
---@param From string 
---@param Event string 
---@param To string 
---@param Task TASK 
function DETECTION_MANAGER:OnAfterSuccess(From, Event, To, Task) end

---Start Handler OnBefore for DETECTION_MANAGER
---
------
---@param self DETECTION_MANAGER 
---@param From string 
---@param Event string 
---@param To string 
---@return boolean #
function DETECTION_MANAGER:OnBeforeStart(From, Event, To) end

---Stop Handler OnBefore for DETECTION_MANAGER
---
------
---@param self DETECTION_MANAGER 
---@param From string 
---@param Event string 
---@param To string 
---@return boolean #
function DETECTION_MANAGER:OnBeforeStop(From, Event, To) end

---Reports the detected items to the Core.Set#SET_GROUP.
---
------
---@param self DETECTION_MANAGER 
---@param Detection DETECTION_BASE 
---@return DETECTION_MANAGER #self
function DETECTION_MANAGER:ProcessDetected(Detection) end

---Set a command center to communicate actions to the players reporting to the command center.
---
------
---@param self DETECTION_MANAGER 
---@param CommandCenter COMMANDCENTER The command center.
---@return DETECTION_MANGER #self
function DETECTION_MANAGER:SetCommandCenter(CommandCenter) end

---Set the reporting time interval.
---
------
---@param self DETECTION_MANAGER 
---@param RefreshTimeInterval number The interval in seconds when a report needs to be done.
---@return DETECTION_MANAGER #self
function DETECTION_MANAGER:SetRefreshTimeInterval(RefreshTimeInterval) end

---Set the reporting message display time.
---
------
---@param self DETECTION_MANAGER 
---@param ReportDisplayTime number The display time in seconds when a report needs to be done.
---@return DETECTION_MANAGER #self
function DETECTION_MANAGER:SetReportDisplayTime(ReportDisplayTime) end

---Set a command center to communicate actions to the players reporting to the command center.
---
------
---@param self DETECTION_MANAGER 
---@param DispatcherMainMenuText NOTYPE 
---@param DispatcherMenuText NOTYPE 
---@return DETECTION_MANGER #self
function DETECTION_MANAGER:SetTacticalMenu(DispatcherMainMenuText, DispatcherMenuText) end

---Start Trigger for DETECTION_MANAGER
---
------
---@param self DETECTION_MANAGER 
function DETECTION_MANAGER:Start() end

---Stop Trigger for DETECTION_MANAGER
---
------
---@param self DETECTION_MANAGER 
function DETECTION_MANAGER:Stop() end

---Start Asynchronous Trigger for DETECTION_MANAGER
---
------
---@param self DETECTION_MANAGER 
---@param Delay number 
function DETECTION_MANAGER:__Start(Delay) end

---Stop Asynchronous Trigger for DETECTION_MANAGER
---
------
---@param self DETECTION_MANAGER 
---@param Delay number 
function DETECTION_MANAGER:__Stop(Delay) end


---
------
---@param self NOTYPE 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@private
function DETECTION_MANAGER:onafterReport(From, Event, To) end


---
------
---@param self NOTYPE 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@private
function DETECTION_MANAGER:onafterStart(From, Event, To) end


---DETECTION_REPORTING class.
---@class DETECTION_REPORTING : DETECTION_MANAGER
---@field ClassName string 
---@field Detection DETECTION_BASE The DETECTION_BASE object that is used to report the detected objects.
---@field SetGroup SET_GROUP The groups to which the FAC will report to.
DETECTION_REPORTING = {}

---Creates a string of the detected items in a Functional.Detection object.
---
------
---@param self DETECTION_MANAGER 
---@param DetectedSet SET_UNIT The detected Set created by the @{Functional.Detection#DETECTION_BASE} object.
---@return DETECTION_MANAGER #self
function DETECTION_REPORTING:GetDetectedItemsText(DetectedSet) end

---DETECTION_REPORTING constructor.
---
------
---@param self DETECTION_REPORTING 
---@param SetGroup SET_GROUP 
---@param Detection DETECTION_AREAS 
---@return DETECTION_REPORTING #self
function DETECTION_REPORTING:New(SetGroup, Detection) end

---Reports the detected items to the Core.Set#SET_GROUP.
---
------
---@param self DETECTION_REPORTING 
---@param Group GROUP The @{Wrapper.Group} object to where the report needs to go.
---@param Detection DETECTION_AREAS The detection created by the @{Functional.Detection#DETECTION_BASE} object.
---@return boolean #Return true if you want the reporting to continue... false will cancel the reporting loop.
function DETECTION_REPORTING:ProcessDetected(Group, Detection) end



