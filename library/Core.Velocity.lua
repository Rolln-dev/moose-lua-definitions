---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/MOOSE.JPG" width="100%">
---
---**Core** - Models a velocity or speed, which can be expressed in various formats according the settings.
---
---===
---
---## Features:
---
---  * Convert velocity in various metric systems.
---  * Set the velocity.
---  * Create a text in a specific format of a velocity.
---  
---===
---
---### Author: **FlightControl**
---### Contributions: 
---
---===
---VELOCITY models a speed, which can be expressed in various formats according the Settings.
---
---## VELOCITY constructor
---  
---  * #VELOCITY.New(): Creates a new VELOCITY object.
---@class VELOCITY 
---@field Velocity NOTYPE 
VELOCITY = {}

---Get the velocity in Mps (meters per second).
---
------
---@param self VELOCITY 
---@return number #The velocity in meters per second. 
function VELOCITY:Get() end

---Get the velocity in Kmph (kilometers per hour).
---
------
---@param self VELOCITY 
---@return number #The velocity in kilometers per hour. 
function VELOCITY:GetKmph() end

---Get the velocity in Miph (miles per hour).
---
------
---@param self VELOCITY 
---@return number #The velocity in miles per hour. 
function VELOCITY:GetMiph() end

---Get the velocity in text, according the player Core.Settings.
---
------
---@param self VELOCITY 
---@param Settings SETTINGS 
---@return string #The velocity in text. 
function VELOCITY:GetText(Settings) end

---VELOCITY Constructor.
---
------
---@param self VELOCITY 
---@param VelocityMps number The velocity in meters per second. 
---@return VELOCITY #
function VELOCITY:New(VelocityMps) end

---Set the velocity in Mps (meters per second).
---
------
---@param self VELOCITY 
---@param VelocityMps number The velocity in meters per second. 
---@return VELOCITY #
function VELOCITY:Set(VelocityMps) end

---Set the velocity in Kmph (kilometers per hour).
---
------
---@param self VELOCITY 
---@param VelocityKmph number The velocity in kilometers per hour. 
---@return VELOCITY #
function VELOCITY:SetKmph(VelocityKmph) end

---Set the velocity in Miph (miles per hour).
---
------
---@param self VELOCITY 
---@param VelocityMiph number The velocity in miles per hour. 
---@return VELOCITY #
function VELOCITY:SetMiph(VelocityMiph) end

---Get the velocity in text, according the player or default Core.Settings.
---
------
---@param self VELOCITY 
---@param Controllable CONTROLLABLE 
---@param Settings SETTINGS 
---@param VelocityGroup NOTYPE 
---@return string #The velocity in text according the player or default @{Core.Settings}
function VELOCITY:ToString(Controllable, Settings, VelocityGroup) end


---# VELOCITY_POSITIONABLE class, extends Core.Base#BASE
---
---#VELOCITY_POSITIONABLE monitors the speed of a Wrapper.Positionable#POSITIONABLE in the simulation, which can be expressed in various formats according the Settings.
---
---## 1. VELOCITY_POSITIONABLE constructor
---  
---  * #VELOCITY_POSITIONABLE.New(): Creates a new VELOCITY_POSITIONABLE object.
---@class VELOCITY_POSITIONABLE 
---@field Positionable NOTYPE 
---@field Velocity NOTYPE 
VELOCITY_POSITIONABLE = {}

---Get the velocity in Mps (meters per second).
---
------
---@param self VELOCITY_POSITIONABLE 
---@return number #The velocity in meters per second. 
function VELOCITY_POSITIONABLE:Get() end

---Get the velocity in Kmph (kilometers per hour).
---
------
---@param self VELOCITY_POSITIONABLE 
---@return number #The velocity in kilometers per hour. 
function VELOCITY_POSITIONABLE:GetKmph() end

---Get the velocity in Miph (miles per hour).
---
------
---@param self VELOCITY_POSITIONABLE 
---@return number #The velocity in miles per hour. 
function VELOCITY_POSITIONABLE:GetMiph() end

---VELOCITY_POSITIONABLE Constructor.
---
------
---@param self VELOCITY_POSITIONABLE 
---@param Positionable POSITIONABLE The Positionable to monitor the speed. 
---@return VELOCITY_POSITIONABLE #
function VELOCITY_POSITIONABLE:New(Positionable) end

---Get the velocity in text, according the player or default Core.Settings.
---
------
---@param self VELOCITY_POSITIONABLE 
---@return string #The velocity in text according the player or default @{Core.Settings}
function VELOCITY_POSITIONABLE:ToString() end



