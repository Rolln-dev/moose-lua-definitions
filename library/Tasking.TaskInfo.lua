---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/MOOSE.JPG" width="100%">
---
---**Tasking** - Controls the information of a Task.
---
---===
---
---### Author: **FlightControl**
---
---### Contributions: 
---
---===
---# TASKINFO class, extends Core.Base#BASE
---
---![Banner Image](..\Images\deprecated.png)
---
---## The TASKINFO class implements the methods to contain information and display information of a task.
---
---# Developer Note
---
---Note while this class still works, it is no longer supported as the original author stopped active development of MOOSE
---Therefore, this class is considered to be deprecated
---@deprecated
---@class TASKINFO : BASE
---@field Detail TASKINFO.Detail 
---@field Info NOTYPE 
TASKINFO = {}

---Add Cargo.
---
------
---@param Cargo CARGO 
---@param Order number The display order, which is a number from 0 to 100.
---@param Detail TASKINFO.Detail The detail Level.
---@param Keep? boolean (optional) If true, this would indicate that the planned taskinfo would be persistent when the task is completed, so that the original planned task info is used at the completed reports.
---@return TASKINFO #self
function TASKINFO:AddCargo(Cargo, Order, Detail, Keep) end

---Add Cargo set.
---
------
---@param SetCargo SET_CARGO 
---@param Order number The display order, which is a number from 0 to 100.
---@param Detail TASKINFO.Detail The detail Level.
---@param Keep? boolean (optional) If true, this would indicate that the planned taskinfo would be persistent when the task is completed, so that the original planned task info is used at the completed reports.
---@return TASKINFO #self
function TASKINFO:AddCargoSet(SetCargo, Order, Detail, Keep) end

---Add a Coordinate.
---
------
---@param Coordinate COORDINATE 
---@param Order number The display order, which is a number from 0 to 100.
---@param Detail TASKINFO.Detail The detail Level.
---@param Keep? boolean (optional) If true, this would indicate that the planned taskinfo would be persistent when the task is completed, so that the original planned task info is used at the completed reports.
---@param ShowKey NOTYPE 
---@param Name NOTYPE 
---@return TASKINFO #self
function TASKINFO:AddCoordinate(Coordinate, Order, Detail, Keep, ShowKey, Name) end

---Add Coordinates.
---
------
---@param Coordinates list 
---@param Order number The display order, which is a number from 0 to 100.
---@param Detail TASKINFO.Detail The detail Level.
---@param Keep? boolean (optional) If true, this would indicate that the planned taskinfo would be persistent when the task is completed, so that the original planned task info is used at the completed reports.
---@return TASKINFO #self
function TASKINFO:AddCoordinates(Coordinates, Order, Detail, Keep) end

---Add taskinfo.
---
------
---@param Key string The info key.
---@param Data NOTYPE The data of the info.
---@param Order number The display order, which is a number from 0 to 100.
---@param Detail TASKINFO.Detail The detail Level.
---@param Keep? boolean (optional) If true, this would indicate that the planned taskinfo would be persistent when the task is completed, so that the original planned task info is used at the completed reports.
---@param ShowKey NOTYPE 
---@param Type NOTYPE 
---@return TASKINFO #self
function TASKINFO:AddInfo(Key, Data, Order, Detail, Keep, ShowKey, Type) end

---Add the QFE at a Coordinate.
---
------
---@param Coordinate COORDINATE 
---@param Order number The display order, which is a number from 0 to 100.
---@param Detail TASKINFO.Detail The detail Level.
---@param Keep? boolean (optional) If true, this would indicate that the planned taskinfo would be persistent when the task is completed, so that the original planned task info is used at the completed reports.
---@return TASKINFO #self
function TASKINFO:AddQFEAtCoordinate(Coordinate, Order, Detail, Keep) end

---Add the Target count.
---
------
---@param TargetCount number The amount of targets.
---@param Order number The display order, which is a number from 0 to 100.
---@param Detail TASKINFO.Detail The detail Level.
---@param Keep? boolean (optional) If true, this would indicate that the planned taskinfo would be persistent when the task is completed, so that the original planned task info is used at the completed reports.
---@return TASKINFO #self
function TASKINFO:AddTargetCount(TargetCount, Order, Detail, Keep) end

---Add the Targets.
---
------
---@param TargetCount number The amount of targets.
---@param TargetTypes string The text containing the target types.
---@param Order number The display order, which is a number from 0 to 100.
---@param Detail TASKINFO.Detail The detail Level.
---@param Keep? boolean (optional) If true, this would indicate that the planned taskinfo would be persistent when the task is completed, so that the original planned task info is used at the completed reports.
---@return TASKINFO #self
function TASKINFO:AddTargets(TargetCount, TargetTypes, Order, Detail, Keep) end

---Add the task name.
---
------
---@param Order number The display order, which is a number from 0 to 100.
---@param Detail TASKINFO.Detail The detail Level.
---@param Keep? boolean (optional) If true, this would indicate that the planned taskinfo would be persistent when the task is completed, so that the original planned task info is used at the completed reports.
---@return TASKINFO #self
function TASKINFO:AddTaskName(Order, Detail, Keep) end

---Add the Temperature at a Coordinate.
---
------
---@param Coordinate COORDINATE 
---@param Order number The display order, which is a number from 0 to 100.
---@param Detail TASKINFO.Detail The detail Level.
---@param Keep? boolean (optional) If true, this would indicate that the planned taskinfo would be persistent when the task is completed, so that the original planned task info is used at the completed reports.
---@return TASKINFO #self
function TASKINFO:AddTemperatureAtCoordinate(Coordinate, Order, Detail, Keep) end

---Add Text.
---
------
---@param Key string The key.
---@param Text string The text.
---@param Order number The display order, which is a number from 0 to 100.
---@param Detail TASKINFO.Detail The detail Level.
---@param Keep? boolean (optional) If true, this would indicate that the planned taskinfo would be persistent when the task is completed, so that the original planned task info is used at the completed reports.
---@return TASKINFO #self
function TASKINFO:AddText(Key, Text, Order, Detail, Keep) end

---Add Threat.
---
------
---@param ThreatText string The text of the Threat.
---@param ThreatLevel string The level of the Threat.
---@param Order number The display order, which is a number from 0 to 100.
---@param Detail TASKINFO.Detail The detail Level.
---@param Keep? boolean (optional) If true, this would indicate that the planned taskinfo would be persistent when the task is completed, so that the original planned task info is used at the completed reports.
---@return TASKINFO #self
function TASKINFO:AddThreat(ThreatText, ThreatLevel, Order, Detail, Keep) end

---Add the Wind at a Coordinate.
---
------
---@param Coordinate COORDINATE 
---@param Order number The display order, which is a number from 0 to 100.
---@param Detail TASKINFO.Detail The detail Level.
---@param Keep? boolean (optional) If true, this would indicate that the planned taskinfo would be persistent when the task is completed, so that the original planned task info is used at the completed reports.
---@return TASKINFO #self
function TASKINFO:AddWindAtCoordinate(Coordinate, Order, Detail, Keep) end

---Get the Coordinate.
---
------
---@param Name NOTYPE 
---@return COORDINATE #Coordinate
function TASKINFO:GetCoordinate(Name) end

---Get data.
---
------
---@param The string info key.
---@param Key NOTYPE 
---@return NOTYPE #Data The data of the info.
function TASKINFO:GetData(The, Key) end

---Get taskinfo.
---
------
---@param The string info key.
---@param Key NOTYPE 
---@return NOTYPE #Data The data of the info.
---@return number #Order The display order, which is a number from 0 to 100.
---@return TASKINFO.Detail #Detail The detail Level.
function TASKINFO:GetInfo(The, Key) end

---Get Targets.
---
------
---@return string #The targets
function TASKINFO:GetTargets() end

---Get Threat.
---
------
---@return string #The threat
function TASKINFO:GetThreat() end

---Instantiates a new TASKINFO.
---
------
---@param Task TASK The task owning the information.
---@return TASKINFO #self
function TASKINFO:New(Task) end

---Create the taskinfo Report
---
------
---@param Report REPORT 
---@param Detail TASKINFO.Detail The detail Level.
---@param ReportGroup GROUP 
---@param Task TASK 
---@return TASKINFO #self
function TASKINFO:Report(Report, Detail, ReportGroup, Task) end



