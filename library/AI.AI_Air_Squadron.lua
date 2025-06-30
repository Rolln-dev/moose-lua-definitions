---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/MOOSE.JPG" width="100%">
---
---**AI** - Models squadrons for airplanes and helicopters.
---
---This is a class used in the AI.AI_Air_Dispatcher and derived dispatcher classes.
---
---===
---
---### Author: **FlightControl**
---
---===
---Implements the core functions modeling squadrons for airplanes and helicopters.
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
---@class AI_AIR_SQUADRON : BASE
---@field Airbase  
---@field AirbaseName  
---@field Captured boolean 
---@field EngageProbability  
---@field FuelThreshold  
---@field Grouping  
---@field Landing  
---@field Name  
---@field Overhead  
---@field RadioFrequency  
---@field ResourceCount  
---@field Takeoff  
---@field TankerName  
---@field TemplatePrefixes  
AI_AIR_SQUADRON = {}

---Add Resources to the Squadron.
---
------
---@param self AI_AIR_SQUADRON 
---@param Resources number The Resources to be added.
---@return AI_AIR_SQUADRON #The Squadron.
function AI_AIR_SQUADRON:AddResources(Resources) end

---Get the EngageProbability of the Squadron.
---
------
---@param self AI_AIR_SQUADRON 
---@return number #The Squadron EngageProbability.
function AI_AIR_SQUADRON:GetEngageProbability() end

---Get the FuelThreshold of the Squadron.
---
------
---@param self AI_AIR_SQUADRON 
---@return number #The Squadron FuelThreshold.
function AI_AIR_SQUADRON:GetFuelThreshold() end

---Get the Grouping of the Squadron.
---
------
---@param self AI_AIR_SQUADRON 
---@return number #The Squadron Grouping.
function AI_AIR_SQUADRON:GetGrouping() end

---Get the Landing of the Squadron.
---
------
---@param self AI_AIR_SQUADRON 
---@return number #The Squadron Landing.
function AI_AIR_SQUADRON:GetLanding() end

---Get the Name of the Squadron.
---
------
---@param self AI_AIR_SQUADRON 
---@return string #The Squadron Name.
function AI_AIR_SQUADRON:GetName() end

---Get the Overhead of the Squadron.
---
------
---@param self AI_AIR_SQUADRON 
---@return number #The Squadron Overhead.
function AI_AIR_SQUADRON:GetOverhead() end

---Get the ResourceCount of the Squadron.
---
------
---@param self AI_AIR_SQUADRON 
---@return number #The Squadron ResourceCount.
function AI_AIR_SQUADRON:GetResourceCount() end

---Get the Takeoff of the Squadron.
---
------
---@param self AI_AIR_SQUADRON 
---@return number #The Squadron Takeoff.
function AI_AIR_SQUADRON:GetTakeoff() end

---Get the Tanker Name of the Squadron.
---
------
---@param self AI_AIR_SQUADRON 
---@return string #The Squadron Tanker Name.
function AI_AIR_SQUADRON:GetTankerName() end

---Creates a new AI_AIR_SQUADRON object
---
------
---@param self AI_AIR_SQUADRON 
---@param SquadronName NOTYPE 
---@param AirbaseName NOTYPE 
---@param TemplatePrefixes NOTYPE 
---@param ResourceCount NOTYPE 
---@return AI_AIR_SQUADRON #
function AI_AIR_SQUADRON:New(SquadronName, AirbaseName, TemplatePrefixes, ResourceCount) end

---Remove Resources to the Squadron.
---
------
---@param self AI_AIR_SQUADRON 
---@param Resources number The Resources to be removed.
---@return AI_AIR_SQUADRON #The Squadron.
function AI_AIR_SQUADRON:RemoveResources(Resources) end

---Set the EngageProbability of the Squadron.
---
------
---@param self AI_AIR_SQUADRON 
---@param EngageProbability number The Squadron EngageProbability.
---@return AI_AIR_SQUADRON #The Squadron.
function AI_AIR_SQUADRON:SetEngageProbability(EngageProbability) end

---Set the FuelThreshold of the Squadron.
---
------
---@param self AI_AIR_SQUADRON 
---@param FuelThreshold number The Squadron FuelThreshold.
---@return AI_AIR_SQUADRON #The Squadron.
function AI_AIR_SQUADRON:SetFuelThreshold(FuelThreshold) end

---Set the Grouping of the Squadron.
---
------
---@param self AI_AIR_SQUADRON 
---@param Grouping number The Squadron Grouping.
---@return AI_AIR_SQUADRON #The Squadron.
function AI_AIR_SQUADRON:SetGrouping(Grouping) end

---Set the Landing of the Squadron.
---
------
---@param self AI_AIR_SQUADRON 
---@param Landing number The Squadron Landing.
---@return AI_AIR_SQUADRON #The Squadron.
function AI_AIR_SQUADRON:SetLanding(Landing) end

---Set the Name of the Squadron.
---
------
---@param self AI_AIR_SQUADRON 
---@param Name string The Squadron Name.
---@return AI_AIR_SQUADRON #The Squadron.
function AI_AIR_SQUADRON:SetName(Name) end

---Set the Overhead of the Squadron.
---
------
---@param self AI_AIR_SQUADRON 
---@param Overhead number The Squadron Overhead.
---@return AI_AIR_SQUADRON #The Squadron.
function AI_AIR_SQUADRON:SetOverhead(Overhead) end

---Set the Radio of the Squadron.
---
------
---@param self AI_AIR_SQUADRON 
---@param RadioFrequency number The frequency of communication.
---@param RadioModulation number The modulation of communication.
---@param RadioPower number The power in Watts of communication.
---@param Language string The language of the radio speech.
---@return AI_AIR_SQUADRON #The Squadron.
function AI_AIR_SQUADRON:SetRadio(RadioFrequency, RadioModulation, RadioPower, Language) end

---Set the ResourceCount of the Squadron.
---
------
---@param self AI_AIR_SQUADRON 
---@param ResourceCount number The Squadron ResourceCount.
---@return AI_AIR_SQUADRON #The Squadron.
function AI_AIR_SQUADRON:SetResourceCount(ResourceCount) end

---Set the Takeoff of the Squadron.
---
------
---@param self AI_AIR_SQUADRON 
---@param Takeoff number The Squadron Takeoff.
---@return AI_AIR_SQUADRON #The Squadron.
function AI_AIR_SQUADRON:SetTakeoff(Takeoff) end

---Set the TankerName of the Squadron.
---
------
---@param self AI_AIR_SQUADRON 
---@param TankerName string The Squadron Tanker Name.
---@return AI_AIR_SQUADRON #The Squadron.
function AI_AIR_SQUADRON:SetTankerName(TankerName) end



