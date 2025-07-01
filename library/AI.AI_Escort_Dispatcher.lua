---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/MOOSE.JPG" width="100%">
---
---**AI** - Models the automatic assignment of AI escorts to player flights.
---
---## Features:
-----     
---  * Provides the facilities to trigger escorts when players join flight slots.
---  * 
---
---===
---
---### Author: **FlightControl**
---
---===
---Models the automatic assignment of AI escorts to player flights.
---
---# Developer Note
---
---![Banner Image](..\Images\deprecated.png)
---
---Note while this class still works, it is no longer supported as the original author stopped active development of MOOSE
---Therefore, this class is considered to be deprecated
---
---===
---@deprecated
---@class AI_ESCORT_DISPATCHER 
---@field AI_Escorts table 
---@field CarrierSet NOTYPE 
---@field EscortAirbase NOTYPE 
---@field EscortBriefing NOTYPE 
---@field EscortName NOTYPE 
---@field EscortSpawn NOTYPE 
AI_ESCORT_DISPATCHER = {}

---Creates a new AI_ESCORT_DISPATCHER object.
---
------
---
---USAGE
---```
---
----- Create a new escort when a player joins an SU-25T plane.
---Create a carrier set, which contains the player slots that can be joined by the players, for which escorts will be defined.
---local Red_SU25T_CarrierSet = SET_GROUP:New():FilterPrefixes( "Red A2G Player Su-25T" ):FilterStart()
---
----- Create a spawn object that will spawn in the escorts, once the player has joined the player slot.
---local Red_SU25T_EscortSpawn = SPAWN:NewWithAlias( "Red A2G Su-25 Escort", "Red AI A2G SU-25 Escort" ):InitLimit( 10, 10 )
---
----- Create an airbase object, where the escorts will be spawned.
---local Red_SU25T_Airbase = AIRBASE:FindByName( AIRBASE.Caucasus.Maykop_Khanskaya )
---
----- Park the airplanes at the airbase, visible before start.
---Red_SU25T_EscortSpawn:ParkAtAirbase( Red_SU25T_Airbase, AIRBASE.TerminalType.OpenMedOrBig )
---
----- New create the escort dispatcher, using the carrier set, the escort spawn object at the escort airbase.
----- Provide a name of the escort, which will be also the name appearing on the radio menu for the group.
----- And a briefing to appear when the player joins the player slot.
---Red_SU25T_EscortDispatcher = AI_ESCORT_DISPATCHER:New( Red_SU25T_CarrierSet, Red_SU25T_EscortSpawn, Red_SU25T_Airbase, "Escort Su-25", "You Su-25T is escorted by one Su-25. Use the radio menu to control the escorts." )
---
----- The dispatcher needs to be started using the :Start() method.
---Red_SU25T_EscortDispatcher:Start()
---```
------
---@param self AI_ESCORT_DISPATCHER 
---@param CarrierSet SET_GROUP The set of @{Wrapper.Group#GROUP} objects of carriers for which escorts are spawned in.
---@param EscortSpawn SPAWN The spawn object that will spawn in the Escorts.
---@param EscortAirbase AIRBASE The airbase where the escorts are spawned.
---@param EscortName string Name of the escort, which will also be the name of the escort menu.
---@param EscortBriefing string A text showing the briefing to the player. Note that if no EscortBriefing is provided, the default briefing will be shown.
---@return AI_ESCORT_DISPATCHER #
function AI_ESCORT_DISPATCHER:New(CarrierSet, EscortSpawn, EscortAirbase, EscortName, EscortBriefing) end


---
------
---@param self NOTYPE 
---@param EventData NOTYPE 
function AI_ESCORT_DISPATCHER:OnEventBirth(EventData) end


---
------
---@param self NOTYPE 
---@param EventData NOTYPE 
function AI_ESCORT_DISPATCHER:OnEventExit(EventData) end

---Start Trigger for AI_ESCORT_DISPATCHER
---
------
---@param self AI_ESCORT_DISPATCHER 
function AI_ESCORT_DISPATCHER:Start() end

---Stop Trigger for AI_ESCORT_DISPATCHER
---
------
---@param self AI_ESCORT_DISPATCHER 
function AI_ESCORT_DISPATCHER:Stop() end

---Start Asynchronous Trigger for AI_ESCORT_DISPATCHER
---
------
---@param self AI_ESCORT_DISPATCHER 
---@param Delay number 
function AI_ESCORT_DISPATCHER:__Start(Delay) end

---Stop Asynchronous Trigger for AI_ESCORT_DISPATCHER
---
------
---@param self AI_ESCORT_DISPATCHER 
---@param Delay number 
function AI_ESCORT_DISPATCHER:__Stop(Delay) end


---
------
---@param self NOTYPE 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@private
function AI_ESCORT_DISPATCHER:onafterStart(From, Event, To) end



