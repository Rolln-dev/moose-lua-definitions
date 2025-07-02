---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/MOOSE.JPG" width="100%">
---
---**AI** - Models the assignment of AI escorts to player flights upon request using the radio menu.
---
---## Features:
---    
---  * Provides the facilities to trigger escorts when players join flight units.
---  * Provide a menu for which escorts can be requested.
---
---===
---
---### Author: **FlightControl**
---
---===
---Models the assignment of AI escorts to player flights upon request using the radio menu.
---
---![Banner Image](..\Images\deprecated.png)
---
---# Developer Note
---
---Note while this class still works, it is no longer supported as the original author stopped active development of MOOSE
---Therefore, this class is considered to be deprecated
---
---===
---@deprecated
---@class AI_ESCORT_DISPATCHER_REQUEST 
---@field AI_Escorts table 
---@field CarrierSet NOTYPE 
---@field EscortAirbase NOTYPE 
---@field EscortBriefing NOTYPE 
---@field EscortName NOTYPE 
---@field EscortSpawn NOTYPE 
AI_ESCORT_DISPATCHER_REQUEST = {}

---Creates a new AI_ESCORT_DISPATCHER_REQUEST object.
---
------
---@param CarrierSet SET_GROUP The set of @{Wrapper.Group#GROUP} objects of carriers for which escorts are requested. 
---@param EscortSpawn SPAWN The spawn object that will spawn in the Escorts.
---@param EscortAirbase AIRBASE The airbase where the escorts are spawned.
---@param EscortName string Name of the escort, which will also be the name of the escort menu.
---@param EscortBriefing string A text showing the briefing to the player. Note that if no EscortBriefing is provided, the default briefing will be shown.
---@return AI_ESCORT_DISPATCHER_REQUEST #
function AI_ESCORT_DISPATCHER_REQUEST:New(CarrierSet, EscortSpawn, EscortAirbase, EscortName, EscortBriefing) end


---
------
---@param EventData NOTYPE 
function AI_ESCORT_DISPATCHER_REQUEST:OnEventBirth(EventData) end


---
------
---@param EventData NOTYPE 
function AI_ESCORT_DISPATCHER_REQUEST:OnEventExit(EventData) end

---Start Trigger for AI_ESCORT_DISPATCHER_REQUEST
---
------
function AI_ESCORT_DISPATCHER_REQUEST:Start() end

---Stop Trigger for AI_ESCORT_DISPATCHER_REQUEST
---
------
function AI_ESCORT_DISPATCHER_REQUEST:Stop() end

---Start Asynchronous Trigger for AI_ESCORT_DISPATCHER_REQUEST
---
------
---@param Delay number 
function AI_ESCORT_DISPATCHER_REQUEST:__Start(Delay) end

---Stop Asynchronous Trigger for AI_ESCORT_DISPATCHER_REQUEST
---
------
---@param Delay number 
function AI_ESCORT_DISPATCHER_REQUEST:__Stop(Delay) end


---
------
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@private
function AI_ESCORT_DISPATCHER_REQUEST:onafterStart(From, Event, To) end



