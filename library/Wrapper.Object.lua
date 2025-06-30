---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/MOOSE.JPG" width="100%">
---
---**Wrapper** - OBJECT wraps the DCS Object derived objects.
---
---===
---
---### Author: **FlightControl**
---
---### Contributions: **funkyfranky
---
---===
---A DCSObject
---@class DCSObject 
DCSObject = {}


---Wrapper class to handle the DCS Object objects.
---
--- * Support all DCS Object APIs.
--- * Enhance with Object specific APIs not in the DCS Object API set.
--- * Manage the "state" of the DCS Object.
---
---## OBJECT constructor:
---
---The OBJECT class provides the following functions to construct a OBJECT instance:
---
--- * Wrapper.Object#OBJECT.New(): Create a OBJECT instance.
---OBJECT class.
---@class OBJECT : BASE
---@field ObjectName string The name of the Object.
OBJECT = {}

---Destroys the OBJECT.
---
------
---@param self OBJECT 
---@return boolean #Returns `true` if the object is destroyed or #nil if the object is nil.
function OBJECT:Destroy() end

---Returns the unit's unique identifier.
---
------
---@param self OBJECT 
---@return Object.ID #ObjectID or #nil if the DCS Object is not existing or alive. Note that the ID is passed as a string and not a number. 
function OBJECT:GetID() end

---Create a new OBJECT from a DCSObject
---
------
---@param self OBJECT 
---@param ObjectName Object The Object name
---@return OBJECT #self
function OBJECT:New(ObjectName) end



