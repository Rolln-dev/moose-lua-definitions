---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Functional.Tiresias.jpg" width="100%">
---
---**Functional** - TIRESIAS - manages AI behaviour.
---
---===
---
---The #TIRESIAS class is working in the back to keep your large-scale ground units in check.
---
---## Features:
---
--- * Designed to keep CPU and Network usage lower on missions with a lot of ground units.
--- * Does not affect ships to keep the Navy guys happy.
--- * Does not affect OpsGroup type groups.
--- * Distinguishes between SAM groups, AAA groups and other ground groups.
--- * Exceptions can be defined to keep certain actions going.
--- * Works coalition-independent in the back
--- * Easy setup.
---
---===
---
---## Missions:
---
---### [TIRESIAS](https://github.com/FlightControl-Master/MOOSE_MISSIONS/tree/master)
---
---===
---
---### Author : **applevangelist **
---*Tiresias, Greek demi-god and shapeshifter, blinded by the Gods, works as oracle for you.* (Wiki)
---
---===
---
---## TIRESIAS Concept
---
--- * Designed to keep CPU and Network usage lower on missions with a lot of ground units.
--- * Does not affect ships to keep the Navy guys happy.
--- * Does not affect OpsGroup type groups.
--- * Distinguishes between SAM groups, AAA groups and other ground groups.
--- * Exceptions can be defined in SET_GROUP objects to keep certain actions going.
--- * Works coalition-independent in the back
--- * Easy setup.
---
---## Setup
---
---Setup is a one-liner:
---
---         local blinder = TIRESIAS:New()
---         
---Optionally you can set up exceptions, e.g. for convoys driving around
---
---         local exceptionset = SET_GROUP:New():FilterCoalitions("red"):FilterPrefixes("Convoy"):FilterStart()
---         local blinder = TIRESIAS:New()
---         blinder:AddExceptionSet(exceptionset)
---
---Options 
---
---         -- Setup different radius for activation around helo and airplane groups (applies to AI and humans)
---         blinder:SetActivationRanges(10,25) -- defaults are 10, and 25
---
---         -- Setup engagement ranges for AAA (non-advanced SAM units like Flaks etc) and if you want them to be AIOff
---         blinder:SetAAARanges(60,true) -- defaults are 60, and true
---- **TIRESIAS** class, extends Core.Base#BASE
---@class TIRESIAS : FSM
---@field AAARange number 
---@field AAASet SET_GROUP 
---@field ClassName string 
---@field Coalition number 
---@field ExceptionSet SET_GROUP 
---@field FlightSet SET_GROUP 
---@field GroundSet SET_GROUP 
---@field HeloSwitchRange number 
---@field Interval number 
---@field OpsGroupSet SET_OPSGROUP 
---@field PlaneSwitchRange number 
---@field SAMSet SET_GROUP 
---@field SwitchAAA boolean 
---@field VehicleSet SET_GROUP 
---@field private debug booelan 
---@field private lid NOTYPE 
---@field private version string 
TIRESIAS = {}

---[USER] Add a SET_GROUP of GROUP objects as exceptions.
---Can be done multiple times. Does **not** work work for GROUP objects spawned into the SET after start, i.e. the groups need to exist in the game already.
---
------
---@param self TIRESIAS 
---@param Set SET_GROUP to add to the exception list.
---@return TIRESIAS #self
function TIRESIAS:AddExceptionSet(Set) end

---[USER] Create a new Tiresias object and start it up.
---
------
---@param self TIRESIAS 
---@return TIRESIAS #self 
function TIRESIAS:New() end

---[USER] Set AAA Ranges - AAA equals non-SAM systems which qualify as AAA in DCS world.
---
------
---@param self TIRESIAS 
---@param FiringRange number The engagement range that AAA units will be set to. Can be 0 to 100 (percent). Defaults to 60.
---@param SwitchAAA boolean Decide if these system will have their AI switched off, too. Defaults to true.
---@return TIRESIAS #self 
function TIRESIAS:SetAAARanges(FiringRange, SwitchAAA) end

---[USER] Set activation radius for Helos and Planes in Nautical Miles.
---
------
---@param self TIRESIAS 
---@param HeloMiles number Radius around a Helicopter in which AI ground units will be activated. Defaults to 10NM.
---@param PlaneMiles number Radius around an Airplane in which AI ground units will be activated. Defaults to 25NM.
---@return TIRESIAS #self 
function TIRESIAS:SetActivationRanges(HeloMiles, PlaneMiles) end

---Triggers the FSM event "Start".
---Starts TIRESIAS and all its event handlers. Note - `:New()` already starts the instance.
---
------
---@param self TIRESIAS 
function TIRESIAS:Start() end

---Triggers the FSM event "Stop".
---Stops TIRESIAS and all its event handlers.
---
------
---@param self TIRESIAS 
function TIRESIAS:Stop() end

---[INTERNAL] Event handler function
---
------
---@param self TIRESIAS 
---@param EventData EVENTDATA 
---@return TIRESIAS #self
function TIRESIAS:_EventHandler(EventData) end

---[INTERNAL] Filter Function
---
------
---@param Group GROUP 
---@return boolean #isin
function TIRESIAS._FilterAAA(Group) end

---[INTERNAL] Filter Function
---
------
---@param Group GROUP 
---@return boolean #isin
function TIRESIAS._FilterNotAAA(Group) end

---[INTERNAL] Filter Function
---
------
---@param Group GROUP 
---@return boolean #isin
function TIRESIAS._FilterNotSAM(Group) end

---[INTERNAL] Filter Function
---
------
---@param Group GROUP 
---@return boolean #isin
function TIRESIAS._FilterSAM(Group) end

---[INTERNAL] Init Groups
---
------
---@param self TIRESIAS 
---@return TIRESIAS #self
function TIRESIAS:_InitGroups() end

---[INTERNAL] Switch Groups Behaviour
---
------
---@param self TIRESIAS 
---@param group GROUP 
---@param radius number Radius in NM
---@return TIRESIAS #self
function TIRESIAS:_SwitchOnGroups(group, radius) end

---Triggers the FSM event "Start" after a delay.
---Starts TIRESIAS and all its event handlers. Note - `:New()` already starts the instance.
---
------
---@param self TIRESIAS 
---@param delay number Delay in seconds.  
function TIRESIAS:__Start(delay) end

---Triggers the FSM event "Stop" after a delay.
---Stops TIRESIAS and all its event handlers.
---
------
---@param self TIRESIAS 
---@param delay number Delay in seconds.
function TIRESIAS:__Stop(delay) end

---[INTERNAL] FSM Function
---
------
---@param self TIRESIAS 
---@param From string 
---@param Event string 
---@param To string 
---@return TIRESIAS #self
---@private
function TIRESIAS:onafterStart(From, Event, To) end

---[INTERNAL] FSM Function
---
------
---@param self TIRESIAS 
---@param From string 
---@param Event string 
---@param To string 
---@return TIRESIAS #self
---@private
function TIRESIAS:onafterStatus(From, Event, To) end

---[INTERNAL] FSM Function
---
------
---@param self TIRESIAS 
---@param From string 
---@param Event string 
---@param To string 
---@return TIRESIAS #self
---@private
function TIRESIAS:onafterStop(From, Event, To) end

---[INTERNAL] FSM Function
---
------
---@param self TIRESIAS 
---@param From string 
---@param Event string 
---@param To string 
---@return TIRESIAS #self
---@private
function TIRESIAS:onbeforeStatus(From, Event, To) end


---@class TIRESIAS.Data 
---@field AIOff boolean 
---@field private exception boolean 
---@field private invisible boolean 
---@field private range number 
---@field private type string 
TIRESIAS.Data = {}



