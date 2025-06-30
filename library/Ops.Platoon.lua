---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/OPS_Platoon.png" width="100%">
---
---**Ops** - Brigade Platoon.
---
---**Main Features:**
---
---   * Set parameters like livery, skill valid for all platoon members.
---   * Define modex and callsigns.
---   * Define mission types, this platoon can perform (see Ops.Auftrag#AUFTRAG).
---   * Pause/unpause platoon operations.
---
---===
---
---### Author: **funkyfranky**
---*Some cool cohort quote* -- Known Author
---
---===
---
---# The PLATOON Concept
---
---A PLATOON is essential part of an BRIGADE.
---
---PLATOON class.
---@class PLATOON : COHORT
---@field ClassName string Name of the class.
---@field ammo  
---@field isGround boolean 
---@field legion  
---@field verbose number Verbosity level.
---@field version string PLATOON class version.
---@field weaponData OPSGROUP.WeaponData Weapon data table with key=BitType.
PLATOON = {}

---Get brigade of this platoon.
---
------
---@param self PLATOON 
---@return BRIGADE #The brigade.
function PLATOON:GetBrigade() end

---Create a new PLATOON object and start the FSM.
---
------
---@param self PLATOON 
---@param TemplateGroupName string Name of the template group.
---@param Ngroups number Number of asset groups of this platoon. Default 3.
---@param PlatoonName string Name of the platoon. Must be **unique**!
---@return PLATOON #self
function PLATOON:New(TemplateGroupName, Ngroups, PlatoonName) end

---Set brigade of this platoon.
---
------
---@param self PLATOON 
---@param Brigade BRIGADE The brigade.
---@return PLATOON #self
function PLATOON:SetBrigade(Brigade) end

---On after "Status" event.
---
------
---@param self PLATOON 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function PLATOON:onafterStatus(From, Event, To) end



