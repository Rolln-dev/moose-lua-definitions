---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Core_Userflag.JPG" width="100%">
---
---**Core** - Manage user flags to interact with the mission editor trigger system and server side scripts.
---
---===
---
---## Features:
---
---  * Set or get DCS user flags within running missions.
---
---===
---
---### Author: **FlightControl**
---
---===
---Management of DCS User Flags.
---
---# 1. USERFLAG constructor
---  
---  * #USERFLAG.New(): Creates a new USERFLAG object.
---@class USERFLAG 
---@field UserFlagName  
USERFLAG = {}

---Get the userflag Number.
---
------
---
---USAGE
---```
---  local BlueVictory = USERFLAG:New( "VictoryBlue" )
---  local BlueVictoryValue = BlueVictory:Get() -- Get the UserFlag VictoryBlue value.
---```
------
---@param self USERFLAG 
---@return number #Number The number value to be checked if it is the same as the userflag.
function USERFLAG:Get() end

---Get the userflag name.
---
------
---@param self USERFLAG 
---@return string #Name of the user flag.
function USERFLAG:GetName() end

---Check if the userflag has a value of Number.
---
------
---
---USAGE
---```
---  local BlueVictory = USERFLAG:New( "VictoryBlue" )
---  if BlueVictory:Is( 1 ) then
---    return "Blue has won"
---  end
---```
------
---@param self USERFLAG 
---@param Number number The number value to be checked if it is the same as the userflag.
---@return boolean #true if the Number is the value of the userflag.
function USERFLAG:Is(Number) end

---USERFLAG Constructor.
---
------
---@param self USERFLAG 
---@param UserFlagName string The name of the userflag, which is a free text string.
---@return USERFLAG #
function USERFLAG:New(UserFlagName) end

---Set the userflag to a given Number.
---
------
---
---USAGE
---```
---  local BlueVictory = USERFLAG:New( "VictoryBlue" )
---  BlueVictory:Set( 100 ) -- Set the UserFlag VictoryBlue to 100.
---```
------
---@param self USERFLAG 
---@param Number number The number value to set the flag to.
---@param Delay number Delay in seconds, before the flag is set.
---@return USERFLAG #The userflag instance.
function USERFLAG:Set(Number, Delay) end



