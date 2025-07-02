---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/MOOSE.JPG" width="100%">
---
---**Functional** - Captures the class DETECTION_ZONES.
---@class DETECTION_BASE.DetectedItem 
---@field Changed boolean 
---@field InterceptCoord NOTYPE 
DETECTION_BASE.DetectedItem = {}


---(old, to be revised ) Detect units within the battle zone for a list of Core.Zones detecting targets following (a) detection method(s), 
---and will build a list (table) of Core.Set#SET_UNITs containing the Wrapper.Unit#UNITs detected.
---The class is group the detected units within zones given a DetectedZoneRange parameter.
---A set with multiple detected zones will be created as there are groups of units detected.
---
---## 4.1) Retrieve the Detected Unit Sets and Detected Zones
---
---The methods to manage the DetectedItems[].Set(s) are implemented in Functional.Detection#DECTECTION_BASE and 
---the methods to manage the DetectedItems[].Zone(s) is implemented in Functional.Detection#DETECTION_ZONES.
---
---Retrieve the DetectedItems[].Set with the method Functional.Detection#DETECTION_BASE.GetDetectedSet(). A Core.Set#SET_UNIT object will be returned.
---
---Retrieve the formed Core.Zone#ZONE_UNITs as a result of the grouping the detected units within the DetectionZoneRange, use the method Functional.Detection#DETECTION_BASE.GetDetectionZones().
---To understand the amount of zones created, use the method Functional.Detection#DETECTION_BASE.GetDetectionZoneCount(). 
---If you want to obtain a specific zone from the DetectedZones, use the method Functional.Detection#DETECTION_BASE.GetDetectionZone() with a given index.
---
---## 4.4) Flare or Smoke detected units
---
---Use the methods Functional.Detection#DETECTION_ZONES.FlareDetectedUnits() or Functional.Detection#DETECTION_ZONES.SmokeDetectedUnits() to flare or smoke the detected units when a new detection has taken place.
---
---## 4.5) Flare or Smoke or Bound detected zones
---
---Use the methods:
---
---  * Functional.Detection#DETECTION_ZONES.FlareDetectedZones() to flare in a color 
---  * Functional.Detection#DETECTION_ZONES.SmokeDetectedZones() to smoke in a color
---  * Functional.Detection#DETECTION_ZONES.SmokeDetectedZones() to bound with a tire with a white flag
---  
---the detected zones when a new detection has taken place.
---@class DETECTION_ZONES 
---@field CountryID NOTYPE 
---@field DetectionCoalition NOTYPE 
---@field DetectionSetZone SET_ZONE 
---@field _BoundDetectedZones boolean 
---@field _FlareDetectedUnits boolean 
---@field _FlareDetectedZones boolean 
---@field _SmokeDetectedUnits boolean 
---@field _SmokeDetectedZones boolean 
DETECTION_ZONES = {}

---Bound the detected zones
---
------
---@return DETECTION_ZONES #self
function DETECTION_ZONES:BoundDetectedZones() end

---Calculate the optimal intercept point of the DetectedItem.
---
------
---@param DetectedItem DETECTION_BASE.DetectedItem 
function DETECTION_ZONES:CalculateIntercept(DetectedItem) end


---
------
function DETECTION_ZONES:CountAliveRecce() end

---Make a DetectionSet table.
---This function will be overridden in the derived clsses.
---
------
---@return DETECTION_ZONES #self
function DETECTION_ZONES:CreateDetectionItems() end

---Report summary of a detected item using a given numeric index.
---
------
---@param DetectedItem DETECTION_BASE.DetectedItem The DetectedItem.
---@param AttackGroup GROUP The group to get the settings for.
---@param Settings? SETTINGS (Optional) Message formatting settings to use.
---@return REPORT #The report of the detection items.
function DETECTION_ZONES:DetectedItemReportSummary(DetectedItem, AttackGroup, Settings) end

---Report detailed of a detection result.
---
------
---@param AttackGroup GROUP The group to generate the report for.
---@return string #
function DETECTION_ZONES:DetectedReportDetailed(AttackGroup) end

---Flare the detected units
---
------
---@return DETECTION_ZONES #self
function DETECTION_ZONES:FlareDetectedUnits() end

---Flare the detected zones
---
------
---@return DETECTION_ZONES #self
function DETECTION_ZONES:FlareDetectedZones() end


---
------
---@param IteratorFunction NOTYPE 
---@param ... NOTYPE 
function DETECTION_ZONES:ForEachAliveRecce(IteratorFunction, ...) end

---Make text documenting the changes of the detected zone.
---
------
---@param DetectedItem DETECTION_BASE.DetectedItem 
---@return string #The Changes text
function DETECTION_ZONES:GetChangeText(DetectedItem) end

---DETECTION_ZONES constructor.
---
------
---@param DetectionSetZone SET_ZONE The @{Core.Set} of ZONE_RADIUS.
---@param DetectionCoalition Coalition.side The coalition of the detection.
---@return DETECTION_ZONES #
function DETECTION_ZONES:New(DetectionSetZone, DetectionCoalition) end

---Smoke the detected units
---
------
---@return DETECTION_ZONES #self
function DETECTION_ZONES:SmokeDetectedUnits() end

---Smoke the detected zones
---
------
---@return DETECTION_ZONES #self
function DETECTION_ZONES:SmokeDetectedZones() end

---Set IsDetected flag for the DetectedItem, which can have more units.
---
------
---@param DetectedItem NOTYPE 
---@return DETECTION_ZONES.DetectedItem #DetectedItem
---@return boolean #true if at least one UNIT is detected from the DetectedSet, false if no UNIT was detected from the DetectedSet.
function DETECTION_ZONES:UpdateDetectedItemDetection(DetectedItem) end


---
------
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@param Detection NOTYPE 
---@param DetectionTimeStamp NOTYPE 
---@private
function DETECTION_ZONES:onafterDetection(From, Event, To, Detection, DetectionTimeStamp) end



