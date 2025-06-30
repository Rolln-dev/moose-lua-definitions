---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/MOOSE.JPG" width="100%">
---
---**Wrapper** - IDENTIFIABLE is an intermediate class wrapping DCS Object class derived Objects.
---
---===
---
---### Author: **FlightControl**
---
---### Contributions: 
---
---===
---Wrapper class to handle the DCS Identifiable objects.
---
--- * Support all DCS Identifiable APIs.
--- * Enhance with Identifiable specific APIs not in the DCS Identifiable API set.
--- * Manage the "state" of the DCS Identifiable.
---
---## IDENTIFIABLE constructor
---
---The IDENTIFIABLE class provides the following functions to construct a IDENTIFIABLE instance:
---
--- * #IDENTIFIABLE.New(): Create a IDENTIFIABLE instance.
---@class IDENTIFIABLE : OBJECT
---@field IdentifiableName string The name of the identifiable.
IDENTIFIABLE = {}

---Gets the CallSign of the IDENTIFIABLE, which is a blank by default.
---
------
---@param self IDENTIFIABLE 
---@return string #The CallSign of the IDENTIFIABLE.
function IDENTIFIABLE:GetCallsign() end

---Returns object category of the DCS Identifiable.
---One of
---
--- * Object.Category.UNIT = 1
--- * Object.Category.WEAPON = 2
--- * Object.Category.STATIC = 3
--- * Object.Category.BASE = 4
--- * Object.Category.SCENERY = 5
--- * Object.Category.Cargo = 6
--- 
--- For UNITs this returns a second value, one of
--- 
--- Unit.Category.AIRPLANE      = 0  
--- Unit.Category.HELICOPTER    = 1  
--- Unit.Category.GROUND_UNIT   = 2  
--- Unit.Category.SHIP          = 3  
--- Unit.Category.STRUCTURE     = 4  
---
------
---@param self IDENTIFIABLE 
---@return Object.Category #The category ID, i.e. a number.
---@return Unit.Category #The unit category ID, i.e. a number. For units only.
function IDENTIFIABLE:GetCategory() end

---Returns the DCS Identifiable category name as defined within the DCS Identifiable Descriptor.
---
------
---@param self IDENTIFIABLE 
---@return string #The DCS Identifiable Category Name
function IDENTIFIABLE:GetCategoryName() end

---Returns coalition of the Identifiable.
---
------
---@param self IDENTIFIABLE 
---@return coalition.side #The side of the coalition or `#nil` The DCS Identifiable is not existing or alive.  
function IDENTIFIABLE:GetCoalition() end

---Returns the name of the coalition of the Identifiable.
---
------
---@param self IDENTIFIABLE 
---@return string #The name of the coalition.
---@return nil #The DCS Identifiable is not existing or alive.  
function IDENTIFIABLE:GetCoalitionName() end

---Returns country of the Identifiable.
---
------
---@param self IDENTIFIABLE 
---@return country.id #The country identifier or `#nil` The DCS Identifiable is not existing or alive.  
function IDENTIFIABLE:GetCountry() end

---Returns country name of the Identifiable.
---
------
---@param self IDENTIFIABLE 
---@return string #Name of the country.  
function IDENTIFIABLE:GetCountryName() end

---Returns Identifiable descriptor.
---Descriptor type depends on Identifiable category.
---
------
---@param self IDENTIFIABLE 
---@return Object.Desc #The Identifiable descriptor or `#nil` The DCS Identifiable is not existing or alive.  
function IDENTIFIABLE:GetDesc() end

---Returns DCS Identifiable object name.
---The function provides access to non-activated objects too.
---
------
---@param self IDENTIFIABLE 
---@return string #The name of the DCS Identifiable or `#nil`.  
function IDENTIFIABLE:GetName() end

---Gets the threat level.
---
------
---@param self IDENTIFIABLE 
---@return number #Threat level.
---@return string #Type.
function IDENTIFIABLE:GetThreatLevel() end

---Returns the type name of the DCS Identifiable.
---
------
---@param self IDENTIFIABLE 
---@return string #The type name of the DCS Identifiable.
function IDENTIFIABLE:GetTypeName() end

---Check if the Object has the attribute.
---
------
---@param self IDENTIFIABLE 
---@param AttributeName string The attribute name.
---@return boolean #true if the attribute exists or `#nil` The DCS Identifiable is not existing or alive.  
function IDENTIFIABLE:HasAttribute(AttributeName) end

---Returns if the Identifiable is alive.
---If the Identifiable is not alive, nil is returned.  
---If the Identifiable is alive, true is returned.
---
------
---@param self IDENTIFIABLE 
---@return boolean #true if Identifiable is alive or `#nil` if the Identifiable is not existing or is not alive.  
function IDENTIFIABLE:IsAlive() end

---Create a new IDENTIFIABLE from a DCSIdentifiable
---
------
---@param self IDENTIFIABLE 
---@param IdentifiableName string The DCS Identifiable name
---@return IDENTIFIABLE #self
function IDENTIFIABLE:New(IdentifiableName) end



