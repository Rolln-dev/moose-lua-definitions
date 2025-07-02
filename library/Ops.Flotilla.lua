---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/OPS_Flotilla.png" width="100%">
---
---**Ops** - Flotilla is a small naval group belonging to a fleet.
---
---**Main Features:**
---
---   * Set parameters like livery, skill valid for all flotilla members.
---   * Define mission types, this flotilla can perform (see Ops.Auftrag#AUFTRAG).
---   * Pause/unpause flotilla operations.
---
---===
---
---### Author: **funkyfranky**
---
---===
---*No captain can do very wrong if he places his ship alongside that of an enemy.* -- Horation Nelson
---
---===
---
---# The FLOTILLA Concept
---
---A FLOTILLA is an essential part of a FLEET.
---
---FLOTILLA class.
---@class FLOTILLA : COHORT
---@field ClassName string Name of the class.
---@field private ammo NOTYPE 
---@field private isNaval boolean 
---@field private legion NOTYPE 
---@field private verbose number Verbosity level.
---@field private version string FLOTILLA class version.
---@field private weaponData OPSGROUP.WeaponData Weapon data table with key=BitType.
FLOTILLA = {}

---Get fleet of this flotilla.
---
------
---@return FLEET #The fleet.
function FLOTILLA:GetFleet() end

---Create a new FLOTILLA object and start the FSM.
---
------
---@param TemplateGroupName string Name of the template group.
---@param Ngroups number Number of asset groups of this flotilla. Default 3.
---@param FlotillaName string Name of the flotilla. Must be **unique**!
---@return FLOTILLA #self
function FLOTILLA:New(TemplateGroupName, Ngroups, FlotillaName) end

---Set fleet of this flotilla.
---
------
---@param Fleet FLEET The fleet.
---@return FLOTILLA #self
function FLOTILLA:SetFleet(Fleet) end

---On after Start event.
---Starts the FLIGHTGROUP FSM and event handlers.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function FLOTILLA:onafterStart(From, Event, To) end

---On after "Status" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function FLOTILLA:onafterStatus(From, Event, To) end



