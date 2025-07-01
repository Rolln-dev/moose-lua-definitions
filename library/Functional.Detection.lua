---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Detection.JPG" width="100%">
---
---**Functional** - Models the detection of enemy units by FACs or RECCEs and group them according various methods.
---
---===
---
---## Features:
---
---  * Detection of targets by recce units.
---  * Group detected targets per unit, type or area (zone).
---  * Keep persistency of detected targets, if when detection is lost.
---  * Provide an indication of detected targets.
---  * Report detected targets.
---  * Refresh detection upon specified time intervals.
---
---===
---
---## Missions:
---
---[DET - Detection](https://github.com/FlightControl-Master/MOOSE_MISSIONS/tree/develop/Functional/Detection)
---
---===
---
---Facilitate the detection of enemy units within the battle zone executed by FACs (Forward Air Controllers) or RECCEs (Reconnaissance Units).
---It uses the in-built detection capabilities of DCS World, but adds new functionalities.
---
---===
---
---### Contributions:
---
---  * Mechanist : Early concept of DETECTION_AREAS.
---
---### Authors:
---
---  * FlightControl : Analysis, Design, Programming, Testing
---
---===
--- Detect units within the battle zone for a list of Wrapper.Groups detecting targets following (a) detection method(s),
--- and will build a list (table) of Core.Set#SET_UNITs containing the Wrapper.Unit#UNITs detected.
--- The class is group the detected units within zones given a DetectedZoneRange parameter.
--- A set with multiple detected zones will be created as there are groups of units detected.
---
--- ## 4.1) Retrieve the Detected Unit Sets and Detected Zones
--- 
--- The methods to manage the DetectedItems[].Set(s) are implemented in Functional.Detection#DECTECTION_BASE and 
--- the methods to manage the DetectedItems[].Zone(s) are implemented in Functional.Detection#DETECTION_AREAS.
--- 
--- Retrieve the DetectedItems[].Set with the method Functional.Detection#DETECTION_BASE.GetDetectedSet(). A Core.Set#SET_UNIT object will be returned.
--- 
--- Retrieve the formed Core.Zone@ZONE_UNITs as a result of the grouping the detected units within the DetectionZoneRange, use the method Functional.Detection#DETECTION_AREAS.GetDetectionZones().
--- To understand the amount of zones created, use the method Functional.Detection#DETECTION_AREAS.GetDetectionZoneCount(). 
--- If you want to obtain a specific zone from the DetectedZones, use the method Functional.Detection#DETECTION_AREAS.GetDetectionZoneByID() with a given index.
--- 
--- ## 4.4) Flare or Smoke detected units
---
--- Use the methods Functional.Detection#DETECTION_AREAS.FlareDetectedUnits() or Functional.Detection#DETECTION_AREAS.SmokeDetectedUnits() to flare or smoke the detected units when a new detection has taken place.
---
--- ## 4.5) Flare or Smoke or Bound detected zones
---
--- Use the methods:
---
---   * Functional.Detection#DETECTION_AREAS.FlareDetectedZones() to flare in a color
---   * Functional.Detection#DETECTION_AREAS.SmokeDetectedZones() to smoke in a color
---   * Functional.Detection#DETECTION_AREAS.SmokeDetectedZones() to bound with a tire with a white flag
---
--- the detected zones when a new detection has taken place.
---@class DETECTION_AREAS : DETECTION_BASE
---@field CountryID NOTYPE 
---@field DetectedItems DETECTION_BASE.DetectedItems A list of areas containing the set of @{Wrapper.Unit}s, @{Core.Zone}s, the center @{Wrapper.Unit} within the zone, and ID of each area that was detected within a DetectionZoneRange.
---@field DetectionZoneRange Distance The range till which targets are grouped upon the first detected target.
---@field _BoundDetectedZones boolean 
---@field _FlareDetectedUnits boolean 
---@field _FlareDetectedZones boolean 
---@field _SmokeDetectedUnits boolean 
---@field _SmokeDetectedZones boolean 
DETECTION_AREAS = {}

---Bound the detected zones
---
------
---@param self DETECTION_AREAS 
---@return DETECTION_AREAS #self
function DETECTION_AREAS:BoundDetectedZones() end

---Calculate the optimal intercept point of the DetectedItem.
---
------
---@param self DETECTION_AREAS 
---@param DetectedItem DETECTION_BASE.DetectedItem 
function DETECTION_AREAS:CalculateIntercept(DetectedItem) end

---Make a DetectionSet table.
---This function will be overridden in the derived classes.
---
------
---@param self DETECTION_AREAS 
---@return DETECTION_AREAS #self
function DETECTION_AREAS:CreateDetectionItems() end

---Report summary of a detected item using a given numeric index.
---
------
---@param self DETECTION_AREAS 
---@param DetectedItem DETECTION_BASE.DetectedItem The DetectedItem.
---@param AttackGroup GROUP The group to get the settings for.
---@param Settings? SETTINGS (Optional) Message formatting settings to use.
---@return REPORT #The report of the detection items.
function DETECTION_AREAS:DetectedItemReportMenu(DetectedItem, AttackGroup, Settings) end

---Report summary of a detected item using a given numeric index.
---
------
---@param self DETECTION_AREAS 
---@param DetectedItem DETECTION_BASE.DetectedItem The DetectedItem.
---@param AttackGroup GROUP The group to get the settings for.
---@param Settings? SETTINGS (Optional) Message formatting settings to use.
---@return REPORT #The report of the detection items.
function DETECTION_AREAS:DetectedItemReportSummary(DetectedItem, AttackGroup, Settings) end

---Report detailed of a detection result.
---
------
---@param self DETECTION_AREAS 
---@param AttackGroup GROUP The group to generate the report for.
---@return string #
function DETECTION_AREAS:DetectedReportDetailed(AttackGroup) end

---Flare the detected units
---
------
---@param self DETECTION_AREAS 
---@return DETECTION_AREAS #self
function DETECTION_AREAS:FlareDetectedUnits() end

---Flare the detected zones
---
------
---@param self DETECTION_AREAS 
---@return DETECTION_AREAS #self
function DETECTION_AREAS:FlareDetectedZones() end

---Make text documenting the changes of the detected zone.
---
------
---@param self DETECTION_AREAS 
---@param DetectedItem DETECTION_BASE.DetectedItem 
---@return string #The Changes text
function DETECTION_AREAS:GetChangeText(DetectedItem) end

---Retrieve a specific zone by its ID (number)
---
------
---@param self DETECTION_AREAS 
---@param ID number 
---@return ZONE_UNIT #The zone or nil if it does not exist
function DETECTION_AREAS:GetDetectionZoneByID(ID) end

---Retrieve number of detected zones.
---
------
---@param self DETECTION_AREAS 
---@return number #The number of zones.
function DETECTION_AREAS:GetDetectionZoneCount() end

---Retrieve set of detected zones.
---
------
---@param self DETECTION_AREAS 
---@return SET_ZONE #The @{Core.Set} of ZONE_UNIT objects detected.
function DETECTION_AREAS:GetDetectionZones() end

---DETECTION_AREAS constructor.
---
------
---@param self DETECTION_AREAS 
---@param DetectionSetGroup SET_GROUP The @{Core.Set} of GROUPs in the Forward Air Controller role.
---@param DetectionZoneRange number The range in meters within which targets are grouped upon the first detected target. Default 5000m.
---@return DETECTION_AREAS #
function DETECTION_AREAS:New(DetectionSetGroup, DetectionZoneRange) end

---Smoke the detected units
---
------
---@param self DETECTION_AREAS 
---@return DETECTION_AREAS #self
function DETECTION_AREAS:SmokeDetectedUnits() end

---Smoke the detected zones
---
------
---@param self DETECTION_AREAS 
---@return DETECTION_AREAS #self
function DETECTION_AREAS:SmokeDetectedZones() end


---Defines the core functions to administer detected objects.
---The DETECTION_BASE class will detect objects within the battle zone for a list of Wrapper.Groups detecting targets following (a) detection method(s).
---
---## DETECTION_BASE constructor
---
---Construct a new DETECTION_BASE instance using the #DETECTION_BASE.New() method.
---
---## Initialization
---
---By default, detection will return detected objects with all the detection sensors available.
---However, you can ask how the objects were found with specific detection methods.
---If you use one of the below methods, the detection will work with the detection method specified.
---You can specify to apply multiple detection methods.
---
---Use the following functions to report the objects it detected using the methods Visual, Optical, Radar, IRST, RWR, DLINK:
---
---  * #DETECTION_BASE.InitDetectVisual(): Detected using Visual.
---  * #DETECTION_BASE.InitDetectOptical(): Detected using Optical.
---  * #DETECTION_BASE.InitDetectRadar(): Detected using Radar.
---  * #DETECTION_BASE.InitDetectIRST(): Detected using IRST.
---  * #DETECTION_BASE.InitDetectRWR(): Detected using RWR.
---  * #DETECTION_BASE.InitDetectDLINK(): Detected using DLINK.
---
---## **Filter** detected units based on **category of the unit**
---
---Filter the detected units based on Unit.Category using the method #DETECTION_BASE.FilterCategories().
---The different values of Unit.Category can be:
---
---  * Unit.Category.AIRPLANE
---  * Unit.Category.GROUND_UNIT
---  * Unit.Category.HELICOPTER
---  * Unit.Category.SHIP
---  * Unit.Category.STRUCTURE
---
---Multiple Unit.Category entries can be given as a table and then these will be evaluated as an OR expression.
---
---Example to filter a single category (Unit.Category.AIRPLANE).
---
---    DetectionObject:FilterCategories( Unit.Category.AIRPLANE )
---
---Example to filter multiple categories (Unit.Category.AIRPLANE, Unit.Category.HELICOPTER). Note the {}.
---
---    DetectionObject:FilterCategories( { Unit.Category.AIRPLANE, Unit.Category.HELICOPTER } )
---
---
---## Radar Blur - use to make the radar less exact, e.g. for WWII scenarios
---
--- * #DETECTION_BASE.SetRadarBlur(): Set the radar blur to be used.
--- 
---## **DETECTION_ derived classes** group the detected units into a **DetectedItems[]** list
---
---DETECTION_BASE derived classes build a list called DetectedItems[], which is essentially a first later
---of grouping of detected units. Each DetectedItem within the DetectedItems[] list contains
---a SET_UNIT object that contains the  detected units that belong to that group.
---
---Derived classes will apply different methods to group the detected units.
---Examples are per area, per quadrant, per distance, per type.
---See further the derived DETECTION classes on which grouping methods are currently supported.
---
---Various methods exist how to retrieve the grouped items from a DETECTION_BASE derived class:
---
---  * The method Functional.Detection#DETECTION_BASE.GetDetectedItems() retrieves the DetectedItems[] list.
---  * A DetectedItem from the DetectedItems[] list can be retrieved using the method Functional.Detection#DETECTION_BASE.GetDetectedItem( DetectedItemIndex ).
---    Note that this method returns a DetectedItem element from the list, that contains a Set variable and further information
---    about the DetectedItem that is set by the DETECTION_BASE derived classes, used to group the DetectedItem.
---  * A DetectedSet from the DetectedItems[] list can be retrieved using the method Functional.Detection#DETECTION_BASE.GetDetectedSet( DetectedItemIndex ).
---    This method retrieves the Set from a DetectedItem element from the DetectedItem list (DetectedItems[ DetectedItemIndex ].Set ).
---
---## **Visual filters** to fine-tune the probability of the detected objects
---
---By default, DCS World will return any object that is in LOS and within "visual reach", or detectable through one of the electronic detection means.
---That being said, the DCS World detection algorithm can sometimes be unrealistic.
---Especially for a visual detection, DCS World is able to report within 1 second a detailed detection of a group of 20 units (including types of the units) that are 10 kilometers away, using only visual capabilities.
---Additionally, trees and other obstacles are not accounted during the DCS World detection.
---
---Therefore, an additional (optional) filtering has been built into the DETECTION_BASE class, that can be set for visual detected units.
---For electronic detection, this filtering is not applied, only for visually detected targets.
---
---The following additional filtering can be applied for visual filtering:
---
---  * A probability factor per kilometer distance.
---  * A probability factor based on the alpha angle between the detected object and the unit detecting.
---    A detection from a higher altitude allows for better detection than when on the ground.
---  * Define a probability factor for "cloudy zones", which are zones where forests or villages are located. In these zones, detection will be much more difficult.
---    The mission designer needs to define these cloudy zones within the mission, and needs to register these zones in the DETECTION_ objects adding a probability factor per zone.
---
---I advise however, that, when you first use the DETECTION derived classes, that you don't use these filters.
---Only when you experience unrealistic behavior in your missions, these filters could be applied.
---
---### Distance visual detection probability
---
---Upon a **visual** detection, the further away a detected object is, the less likely it is to be detected properly.
---Also, the speed of accurate detection plays a role.
---
---A distance probability factor between 0 and 1 can be given, that will model a linear extrapolated probability over 10 km distance.
---
---For example, if a probability factor of 0.6 (60%) is given, the extrapolated probabilities over 15 kilometers would like like:
---1 km: 96%, 2 km: 92%, 3 km: 88%, 4 km: 84%, 5 km: 80%, 6 km: 76%, 7 km: 72%, 8 km: 68%, 9 km: 64%, 10 km: 60%, 11 km: 56%, 12 km: 52%, 13 km: 48%, 14 km: 44%, 15 km: 40%.
---
---Note that based on this probability factor, not only the detection but also the **type** of the unit will be applied!
---
---Use the method Functional.Detection#DETECTION_BASE.SetDistanceProbability() to set the probability factor upon a 10 km distance.
---
---### Alpha Angle visual detection probability
---
---Upon a **visual** detection, the higher the unit is during the detecting process, the more likely the detected unit is to be detected properly.
---A detection at a 90% alpha angle is the most optimal, a detection at 10% is less and a detection at 0% is less likely to be correct.
---
---A probability factor between 0 and 1 can be given, that will model a progressive extrapolated probability if the target would be detected at a 0° angle.
---
---For example, if a alpha angle probability factor of 0.7 is given, the extrapolated probabilities of the different angles would look like:
---0°: 70%, 10°: 75,21%, 20°: 80,26%, 30°: 85%, 40°: 89,28%, 50°: 92,98%, 60°: 95,98%, 70°: 98,19%, 80°: 99,54%, 90°: 100%
---
---Use the method Functional.Detection#DETECTION_BASE.SetAlphaAngleProbability() to set the probability factor if 0°.
---
---### Cloudy Zones detection probability
---
---Upon a **visual** detection, the more a detected unit is within a cloudy zone, the less likely the detected unit is to be detected successfully.
---The Cloudy Zones work with the ZONE_BASE derived classes. The mission designer can define within the mission
---zones that reflect cloudy areas where detected units may not be so easily visually detected.
---
---Use the method Functional.Detection#DETECTION_BASE.SetZoneProbability() to set for a defined number of zones, the probability factors.
---
---Note however, that the more zones are defined to be "cloudy" within a detection, the more performance it will take
---from the DETECTION_BASE to calculate the presence of the detected unit within each zone.
---Especially for ZONE_POLYGON, try to limit the amount of nodes of the polygon!
---
---Typically, this kind of filter would be applied for very specific areas where a detection needs to be very realistic for
---AI not to detect so easily targets within a forrest or village rich area.
---
---## Accept / Reject detected units
---
---DETECTION_BASE can accept or reject successful detections based on the location of the detected object,
---if it is located in range or located inside or outside of specific zones.
---
---### Detection acceptance of within range limit
---
---A range can be set that will limit a successful detection for a unit.
---Use the method Functional.Detection#DETECTION_BASE.SetAcceptRange() to apply a range in meters till where detected units will be accepted.
---
---     local SetGroup = SET_GROUP:New():FilterPrefixes( "FAC" ):FilterStart() -- Build a SetGroup of Forward Air Controllers.
---
---     -- Build a detect object.
---     local Detection = DETECTION_UNITS:New( SetGroup )
---
---     -- This will accept detected units if the range is below 5000 meters.
---     Detection:SetAcceptRange( 5000 )
---
---     -- Start the Detection.
---     Detection:Start()
---
---
---### Detection acceptance if within zone(s).
---
---Specific ZONE_BASE object(s) can be given as a parameter, which will only accept a detection if the unit is within the specified ZONE_BASE object(s).
---Use the method Functional.Detection#DETECTION_BASE.SetAcceptZones() will accept detected units if they are within the specified zones.
---
---     local SetGroup = SET_GROUP:New():FilterPrefixes( "FAC" ):FilterStart() -- Build a SetGroup of Forward Air Controllers.
---
---     -- Search fo the zones where units are to be accepted.
---     local ZoneAccept1 = ZONE:New( "AcceptZone1" )
---     local ZoneAccept2 = ZONE:New( "AcceptZone2" )
---
---     -- Build a detect object.
---     local Detection = DETECTION_UNITS:New( SetGroup )
---
---     -- This will accept detected units by Detection when the unit is within ZoneAccept1 OR ZoneAccept2.
---     Detection:SetAcceptZones( { ZoneAccept1, ZoneAccept2 } ) 
---
---     -- Start the Detection.
---     Detection:Start()
---
---### Detection rejection if within zone(s).
---
---Specific ZONE_BASE object(s) can be given as a parameter, which will reject detection if the unit is within the specified ZONE_BASE object(s).
---Use the method Functional.Detection#DETECTION_BASE.SetRejectZones() will reject detected units if they are within the specified zones.
---An example of how to use the method is shown below.
---
---     local SetGroup = SET_GROUP:New():FilterPrefixes( "FAC" ):FilterStart() -- Build a SetGroup of Forward Air Controllers.
---
---     -- Search fo the zones where units are to be rejected.
---     local ZoneReject1 = ZONE:New( "RejectZone1" )
---     local ZoneReject2 = ZONE:New( "RejectZone2" )
---
---     -- Build a detect object.
---     local Detection = DETECTION_UNITS:New( SetGroup )
---
---     -- This will reject detected units by Detection when the unit is within ZoneReject1 OR ZoneReject2.
---     Detection:SetRejectZones( { ZoneReject1, ZoneReject2 } )
---
---     -- Start the Detection.
---     Detection:Start()
---
---## Detection of Friendlies Nearby
---
---Use the method Functional.Detection#DETECTION_BASE.SetFriendliesRange() to set the range what will indicate when friendlies are nearby
---a DetectedItem. The default range is 6000 meters. For air detections, it is advisory to use about 30.000 meters.
---
---## DETECTION_BASE is a Finite State Machine
---
---Various Events and State Transitions can be tailored using DETECTION_BASE.
---
---### DETECTION_BASE States
---
---  * **Detecting**: The detection is running.
---  * **Stopped**: The detection is stopped.
---
---### DETECTION_BASE Events
---
---  * **Start**: Start the detection process.
---  * **Detect**: Detect new units.
---  * **Detected**: New units have been detected.
---  * **Stop**: Stop the detection process.
---@class DETECTION_BASE : FSM
---@field AcceptRange NOTYPE 
---@field AcceptZones table 
---@field AlphaAngleProbability NOTYPE 
---@field DetectDLINK NOTYPE 
---@field DetectIRST NOTYPE 
---@field DetectOptical NOTYPE 
---@field DetectRWR NOTYPE 
---@field DetectRadar NOTYPE 
---@field DetectVisual NOTYPE 
---@field DetectedItems table 
---@field DetectedObjects DETECTION_BASE.DetectedObjects The list of detected objects.
---@field DetectedObjectsIdentified table Map of the DetectedObjects identified.
---@field DetectionRange Distance The range till which targets are accepted to be detected.
---@field DetectionRun number 
---@field DetectionScheduler NOTYPE 
---@field DetectionSet NOTYPE 
---@field DetectionSetGroup SET_GROUP The @{Core.Set} of GROUPs in the Forward Air Controller role.
---@field DistanceProbability NOTYPE 
---@field FriendliesRange NOTYPE 
---@field Intercept NOTYPE 
---@field InterceptDelay NOTYPE 
---@field Locking boolean 
---@field RadarBlur boolean 
---@field RefreshTimeInterval NOTYPE 
---@field RejectZones table 
---@field ScheduleDelayTime NOTYPE 
---@field ScheduleRepeatInterval NOTYPE 
---@field ZoneProbability NOTYPE 
DETECTION_BASE = {}

---Accepts changes from the detected item.
---
------
---@param self DETECTION_BASE 
---@param DetectedItem DETECTION_BASE.DetectedItem 
---@return DETECTION_BASE #self
function DETECTION_BASE:AcceptChanges(DetectedItem) end

---Add a change to the detected zone.
---
------
---@param self DETECTION_BASE 
---@param DetectedItem DETECTION_BASE.DetectedItem 
---@param ChangeCode string 
---@param ItemUnitType NOTYPE 
---@return DETECTION_BASE #self
function DETECTION_BASE:AddChangeItem(DetectedItem, ChangeCode, ItemUnitType) end

---Add a change to the detected zone.
---
------
---@param self DETECTION_BASE 
---@param DetectedItem DETECTION_BASE.DetectedItem 
---@param ChangeCode string 
---@param ChangeUnitType string 
---@return DETECTION_BASE #self
function DETECTION_BASE:AddChangeUnit(DetectedItem, ChangeCode, ChangeUnitType) end

---Adds a new DetectedItem to the DetectedItems list.
---The DetectedItem is a table and contains a SET_UNIT in the field Set.
---
------
---@param self DETECTION_BASE 
---@param ItemPrefix string Prefix of detected item.
---@param DetectedItemKey number The key of the DetectedItem. Default self.DetectedItemMax. Could also be a string in principle.
---@param Set? SET_UNIT (optional) The Set of Units to be added.
---@return DETECTION_BASE.DetectedItem #
function DETECTION_BASE:AddDetectedItem(ItemPrefix, DetectedItemKey, Set) end

---Adds a new DetectedItem to the DetectedItems list.
---The DetectedItem is a table and contains a SET_UNIT in the field Set.
---
------
---@param self DETECTION_BASE 
---@param DetectedItemKey NOTYPE The key of the DetectedItem.
---@param Set? SET_UNIT (optional) The Set of Units to be added.
---@param Zone? ZONE_UNIT (optional) The Zone to be added where the Units are located.
---@param ItemPrefix NOTYPE 
---@return DETECTION_BASE.DetectedItem #
function DETECTION_BASE:AddDetectedItemZone(DetectedItemKey, Set, Zone, ItemPrefix) end

---Clean the DetectedItem table.
---
------
---@param self DETECTION_BASE 
---@param DetectedItem NOTYPE 
---@param DetectedItemID NOTYPE 
---@return DETECTION_BASE #
function DETECTION_BASE:CleanDetectionItem(DetectedItem, DetectedItemID) end


---
------
---@param self NOTYPE 
function DETECTION_BASE:CountAliveRecce() end

---Make a DetectionSet table.
---This function will be overridden in the derived clsses.
---
------
---@param self DETECTION_BASE 
---@return DETECTION_BASE #
function DETECTION_BASE:CreateDetectionItems() end

---Synchronous Event Trigger for Event Detect.
---
------
---@param self DETECTION_BASE 
function DETECTION_BASE:Detect() end

---Synchronous Event Trigger for Event Detected.
---
------
---@param self DETECTION_BASE 
---@param Units table Table of detected units.
function DETECTION_BASE:Detected(Units) end

---Report summary of a detected item using a given numeric index.
---
------
---@param self DETECTION_BASE 
---@param DetectedItem DETECTION_BASE.DetectedItem The DetectedItem.
---@param AttackGroup GROUP The group to generate the report for.
---@param Settings SETTINGS Message formatting settings to use.
---@return REPORT #
function DETECTION_BASE:DetectedItemReportSummary(DetectedItem, AttackGroup, Settings) end

---Report detailed of a detection result.
---
------
---@param self DETECTION_BASE 
---@param AttackGroup GROUP The group to generate the report for.
---@return string #
function DETECTION_BASE:DetectedReportDetailed(AttackGroup) end

---Filter the detected units based on Unit.Category  
---The different values of Unit.Category can be:
---
---  * Unit.Category.AIRPLANE
---  * Unit.Category.GROUND_UNIT
---  * Unit.Category.HELICOPTER
---  * Unit.Category.SHIP
---  * Unit.Category.STRUCTURE
---  
---Multiple Unit.Category entries can be given as a table and then these will be evaluated as an OR expression.
---
---Example to filter a single category (Unit.Category.AIRPLANE).
---
---    DetectionObject:FilterCategories( Unit.Category.AIRPLANE ) 
---
---Example to filter multiple categories (Unit.Category.AIRPLANE, Unit.Category.HELICOPTER). Note the {}.
---
---    DetectionObject:FilterCategories( { Unit.Category.AIRPLANE, Unit.Category.HELICOPTER } )
---
------
---@param self DETECTION_BASE 
---@param FilterCategories list The Categories entries
---@return DETECTION_BASE #self
function DETECTION_BASE:FilterCategories(FilterCategories) end


---
------
---@param self NOTYPE 
---@param IteratorFunction NOTYPE 
---@param ... NOTYPE 
function DETECTION_BASE:ForEachAliveRecce(IteratorFunction, ...) end

---Forget a Unit from a DetectionItem
---
------
---@param self DETECTION_BASE 
---@param UnitName string The UnitName that needs to be forgotten from the DetectionItem Sets.
---@return DETECTION_BASE #
function DETECTION_BASE:ForgetDetectedUnit(UnitName) end

---Get a detected ID using a given numeric index.
---
------
---@param self DETECTION_BASE 
---@param Index number 
---@return string #DetectedItemID
function DETECTION_BASE:GetDetectedID(Index) end

---Get a detected item using a given numeric index.
---
------
---@param self DETECTION_BASE 
---@param Index number 
---@return DETECTION_BASE.DetectedItem #
function DETECTION_BASE:GetDetectedItemByIndex(Index) end

---Get a detected item using a given Key.
---
------
---@param self DETECTION_BASE 
---@param Key NOTYPE 
---@return DETECTION_BASE.DetectedItem #
function DETECTION_BASE:GetDetectedItemByKey(Key) end

---Get the detected item coordinate.
---
------
---@param self DETECTION_BASE 
---@param DetectedItem DETECTION_BASE.DetectedItem The DetectedItem to set the coordinate at.
---@return COORDINATE #
function DETECTION_BASE:GetDetectedItemCoordinate(DetectedItem) end

---Get a list of the detected item coordinates.
---
------
---@param self DETECTION_BASE 
---@return table #A table of Core.Point#COORDINATE
function DETECTION_BASE:GetDetectedItemCoordinates() end

---Get a detected ItemID using a given numeric index.
---
------
---@param self DETECTION_BASE 
---@param DetectedItem DETECTION_BASE.DetectedItem The DetectedItem.
---@return string #DetectedItemID
function DETECTION_BASE:GetDetectedItemID(DetectedItem) end

---Get the Core.Set#SET_UNIT of a detection area using a given numeric index.
---
------
---@param self DETECTION_BASE 
---@param DetectedItem DETECTION_BASE.DetectedItem 
---@return SET_UNIT #DetectedSet
function DETECTION_BASE:GetDetectedItemSet(DetectedItem) end

---Get the detected item coordinate.
---
------
---@param self DETECTION_BASE 
---@param DetectedItem DETECTION_BASE.DetectedItem The DetectedItem.
---@return number #ThreatLevel
function DETECTION_BASE:GetDetectedItemThreatLevel(DetectedItem) end

---Get the Core.Zone#ZONE_UNIT of a detection area using a given numeric index.
---
------
---@param self DETECTION_BASE 
---@param DetectedItem DETECTION_BASE.DetectedItem The DetectedItem.
---@return ZONE_UNIT #DetectedZone
function DETECTION_BASE:GetDetectedItemZone(DetectedItem) end

---Get the DetectedItems by Key.
---This will return the DetectedItems collection, indexed by the Key, which can be any object that acts as the key of the detection.
---
------
---@param self DETECTION_BASE 
---@return DETECTION_BASE.DetectedItems #
function DETECTION_BASE:GetDetectedItems() end

---Get the DetectedItems by Index.
---This will return the DetectedItems collection, indexed by an internal numerical Index.
---
------
---@param self DETECTION_BASE 
---@return DETECTION_BASE.DetectedItems #
function DETECTION_BASE:GetDetectedItemsByIndex() end

---Get the amount of SETs with detected objects.
---
------
---@param self DETECTION_BASE 
---@return number #The amount of detected items. Note that the amount of detected items can differ with the reality, because detections are not real-time but done in intervals!
function DETECTION_BASE:GetDetectedItemsCount() end

---Gets a detected object with a given name.
---
------
---@param self DETECTION_BASE 
---@param ObjectName string 
---@return DETECTION_BASE.DetectedObject #
function DETECTION_BASE:GetDetectedObject(ObjectName) end

---Gets a detected unit type name, taking into account the detection results.
---
------
---@param self DETECTION_BASE 
---@param DetectedUnit UNIT 
---@return string #The type name
function DETECTION_BASE:GetDetectedUnitTypeName(DetectedUnit) end

---Get the Detection Set.
---
------
---@param self DETECTION_BASE 
---@return DETECTION_BASE #self
function DETECTION_BASE:GetDetectionSet() end

---Returns the distance used to identify friendlies near the detected item ...
---
------
---@param self DETECTION_BASE 
---@param DetectedItem DETECTION_BASE.DetectedItem The detected item.
---@return table #A table of distances to friendlies. 
function DETECTION_BASE:GetFriendliesDistance(DetectedItem) end

---Returns friendly units nearby the FAC units ...
---
------
---@param self DETECTION_BASE 
---@param DetectedItem DETECTION_BASE.DetectedItem 
---@param Category Unit.Category The category of the unit.
---@return map #The map of Friendly UNITs.
function DETECTION_BASE:GetFriendliesNearBy(DetectedItem, Category) end

---Returns friendly units nearby the intercept point ...
---
------
---@param self DETECTION_BASE 
---@param DetectedItem DETECTION_BASE.DetectedItem The detected item.
---@return map #The map of Friendly UNITs. 
function DETECTION_BASE:GetFriendliesNearIntercept(DetectedItem) end

---Returns friendly units nearby the FAC units ...
---
------
---@param self DETECTION_BASE 
---@param DetectedItem DETECTION_BASE.DetectedItem The detected item.
---@return map #The map of Friendly UNITs.
function DETECTION_BASE:GetPlayersNearBy(DetectedItem) end

---Identifies a detected object during detection processing.
---
------
---@param self DETECTION_BASE 
---@param DetectedObject DETECTION_BASE.DetectedObject 
function DETECTION_BASE:IdentifyDetectedObject(DetectedObject) end

---Detect DLINK.
---
------
---@param self DETECTION_BASE 
---@param DetectDLINK boolean 
---@return DETECTION_BASE #self
function DETECTION_BASE:InitDetectDLINK(DetectDLINK) end

---Detect IRST.
---
------
---@param self DETECTION_BASE 
---@param DetectIRST boolean 
---@return DETECTION_BASE #self
function DETECTION_BASE:InitDetectIRST(DetectIRST) end

---Detect Optical.
---
------
---@param self DETECTION_BASE 
---@param DetectOptical boolean 
---@return DETECTION_BASE #self
function DETECTION_BASE:InitDetectOptical(DetectOptical) end

---Detect RWR.
---
------
---@param self DETECTION_BASE 
---@param DetectRWR boolean 
---@return DETECTION_BASE #self
function DETECTION_BASE:InitDetectRWR(DetectRWR) end

---Detect Radar.
---
------
---@param self DETECTION_BASE 
---@param DetectRadar boolean 
---@return DETECTION_BASE #self
function DETECTION_BASE:InitDetectRadar(DetectRadar) end

---Detect Visual.
---
------
---@param self DETECTION_BASE 
---@param DetectVisual boolean 
---@return DETECTION_BASE #self
function DETECTION_BASE:InitDetectVisual(DetectVisual) end

---Checks if there is at least one UNIT detected in the Set of the the DetectedItem.
---
------
---@param self DETECTION_BASE 
---@param DetectedItem DETECTION_BASE.DetectedItem 
---@return boolean #true if at least one UNIT is detected from the DetectedSet, false if no UNIT was detected from the DetectedSet.
function DETECTION_BASE:IsDetectedItemDetected(DetectedItem) end

---Validate if the detected item is locked.
---
------
---@param self DETECTION_BASE 
---@param DetectedItem DETECTION_BASE.DetectedItem The DetectedItem.
---@return boolean #
function DETECTION_BASE:IsDetectedItemLocked(DetectedItem) end

---Determines if a detected object has already been identified during detection processing.
---
------
---@param self DETECTION_BASE 
---@param DetectedObject DETECTION_BASE.DetectedObject 
---@return boolean #true if already identified.
function DETECTION_BASE:IsDetectedObjectIdentified(DetectedObject) end

---Returns if there are friendlies nearby the FAC units ...
---
------
---@param self DETECTION_BASE 
---@param DetectedItem DETECTION_BASE.DetectedItem 
---@param Category Unit.Category The category of the unit.
---@return boolean #true if there are friendlies nearby 
function DETECTION_BASE:IsFriendliesNearBy(DetectedItem, Category) end

---Returns if there are friendlies nearby the intercept ...
---
------
---@param self DETECTION_BASE 
---@param DetectedItem DETECTION_BASE.DetectedItem 
---@return boolean #trhe if there are friendlies near the intercept.
function DETECTION_BASE:IsFriendliesNearIntercept(DetectedItem) end

---Returns if there are friendlies nearby the FAC units ...
---
------
---@param self DETECTION_BASE 
---@param DetectedItem DETECTION_BASE.DetectedItem 
---@return boolean #true if there are friendlies nearby
function DETECTION_BASE:IsPlayersNearBy(DetectedItem) end

---Lock a detected item.
---
------
---@param self DETECTION_BASE 
---@param DetectedItem DETECTION_BASE.DetectedItem The DetectedItem.
---@return DETECTION_BASE #
function DETECTION_BASE:LockDetectedItem(DetectedItem) end

---Lock the detected items when created and lock all existing detected items.
---
------
---@param self DETECTION_BASE 
---@return DETECTION_BASE #
function DETECTION_BASE:LockDetectedItems() end

---Find the nearest Recce of the DetectedItem.
---
------
---@param self DETECTION_BASE 
---@param DetectedItem DETECTION_BASE.DetectedItem 
---@return UNIT #The nearest FAC unit
function DETECTION_BASE:NearestRecce(DetectedItem) end

---DETECTION constructor.
---
------
---@param self DETECTION_BASE 
---@param DetectionSet SET_GROUP The @{Core.Set} of @{Wrapper.Group}s that is used to detect the units.
---@return DETECTION_BASE #self
function DETECTION_BASE:New(DetectionSet) end

---OnAfter Transition Handler for Event Detect.
---
------
---@param self DETECTION_BASE 
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function DETECTION_BASE:OnAfterDetect(From, Event, To) end

---OnAfter Transition Handler for Event Detected.
---
------
---@param self DETECTION_BASE 
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@param Units table Table of detected units.
function DETECTION_BASE:OnAfterDetected(From, Event, To, Units) end

---OnAfter Transition Handler for Event DetectedItem.
---
------
---@param self DETECTION_BASE 
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@param DetectedItem DetectedItem The DetectedItem data structure.
function DETECTION_BASE:OnAfterDetectedItem(From, Event, To, DetectedItem) end

---OnAfter Transition Handler for Event Start.
---
------
---@param self DETECTION_BASE 
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function DETECTION_BASE:OnAfterStart(From, Event, To) end

---OnAfter Transition Handler for Event Stop.
---
------
---@param self DETECTION_BASE 
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function DETECTION_BASE:OnAfterStop(From, Event, To) end

---OnBefore Transition Handler for Event Detect.
---
------
---@param self DETECTION_BASE 
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function DETECTION_BASE:OnBeforeDetect(From, Event, To) end

---OnBefore Transition Handler for Event Detected.
---
------
---@param self DETECTION_BASE 
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function DETECTION_BASE:OnBeforeDetected(From, Event, To) end

---OnBefore Transition Handler for Event Start.
---
------
---@param self DETECTION_BASE 
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function DETECTION_BASE:OnBeforeStart(From, Event, To) end

---OnBefore Transition Handler for Event Stop.
---
------
---@param self DETECTION_BASE 
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function DETECTION_BASE:OnBeforeStop(From, Event, To) end

---OnEnter Transition Handler for State Detecting.
---
------
---@param self DETECTION_BASE 
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function DETECTION_BASE:OnEnterDetecting(From, Event, To) end

---OnEnter Transition Handler for State Stopped.
---
------
---@param self DETECTION_BASE 
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
function DETECTION_BASE:OnEnterStopped(From, Event, To) end

---OnLeave Transition Handler for State Detecting.
---
------
---@param self DETECTION_BASE 
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function DETECTION_BASE:OnLeaveDetecting(From, Event, To) end

---OnLeave Transition Handler for State Stopped.
---
------
---@param self DETECTION_BASE 
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@return boolean #Return false to cancel Transition.
function DETECTION_BASE:OnLeaveStopped(From, Event, To) end

---Removes an existing DetectedItem from the DetectedItems list.
---The DetectedItem is a table and contains a SET_UNIT in the field Set.
---
------
---@param self DETECTION_BASE 
---@param DetectedItemKey NOTYPE The key in the DetectedItems list where the item needs to be removed.
function DETECTION_BASE:RemoveDetectedItem(DetectedItemKey) end

---Background worker function to determine if there are friendlies nearby ...
---
------
---@param self DETECTION_BASE 
---@param TargetData table 
function DETECTION_BASE:ReportFriendliesNearBy(TargetData) end

---Schedule the DETECTION construction.
---
------
---@param self DETECTION_BASE 
---@param DelayTime number The delay in seconds to wait the reporting.
---@param RepeatInterval number The repeat interval in seconds for the reporting to happen repeatedly.
---@return DETECTION_BASE #self
function DETECTION_BASE:Schedule(DelayTime, RepeatInterval) end

---Accept detections if within a range in meters.
---
------
---@param self DETECTION_BASE 
---@param AcceptRange number Accept a detection if the unit is within the AcceptRange in meters.
---@return DETECTION_BASE #self
function DETECTION_BASE:SetAcceptRange(AcceptRange) end

---Accept detections if within the specified zone(s).
---
------
---@param self DETECTION_BASE 
---@param AcceptZones ZONE_BASE Can be a list or ZONE_BASE objects, or a single ZONE_BASE object.
---@return DETECTION_BASE #self
function DETECTION_BASE:SetAcceptZones(AcceptZones) end

---Upon a **visual** detection, the higher the unit is during the detecting process, the more likely the detected unit is to be detected properly.
---A detection at a 90% alpha angle is the most optimal, a detection at 10% is less and a detection at 0% is less likely to be correct.
---
---A probability factor between 0 and 1 can be given, that will model a progressive extrapolated probability if the target would be detected at a 0° angle.
---
---For example, if a alpha angle probability factor of 0.7 is given, the extrapolated probabilities of the different angles would look like:
---0°: 70%, 10°: 75,21%, 20°: 80,26%, 30°: 85%, 40°: 89,28%, 50°: 92,98%, 60°: 95,98%, 70°: 98,19%, 80°: 99,54%, 90°: 100%
---
------
---@param self DETECTION_BASE 
---@param AlphaAngleProbability NOTYPE The probability factor.
---@return DETECTION_BASE #self
function DETECTION_BASE:SetAlphaAngleProbability(AlphaAngleProbability) end

---Set the detected item coordinate.
---
------
---@param self DETECTION_BASE 
---@param DetectedItem DETECTION_BASE.DetectedItem The DetectedItem to set the coordinate at.
---@param Coordinate COORDINATE The coordinate to set the last know detected position at.
---@param DetectedItemUnit UNIT The unit to set the heading and altitude from.
---@return DETECTION_BASE #
function DETECTION_BASE:SetDetectedItemCoordinate(DetectedItem, Coordinate, DetectedItemUnit) end

---Set the detected item threat level.
---
------
---@param self DETECTION_BASE 
---@param The DETECTION_BASE.DetectedItem DetectedItem to calculate the threat level for.
---@param DetectedItem NOTYPE 
---@return DETECTION_BASE #
function DETECTION_BASE:SetDetectedItemThreatLevel(The, DetectedItem) end

---Upon a **visual** detection, the further away a detected object is, the less likely it is to be detected properly.
---Also, the speed of accurate detection plays a role.
---A distance probability factor between 0 and 1 can be given, that will model a linear extrapolated probability over 10 km distance.
---For example, if a probability factor of 0.6 (60%) is given, the extrapolated probabilities over 15 kilometers would like like:
---1 km: 96%, 2 km: 92%, 3 km: 88%, 4 km: 84%, 5 km: 80%, 6 km: 76%, 7 km: 72%, 8 km: 68%, 9 km: 64%, 10 km: 60%, 11 km: 56%, 12 km: 52%, 13 km: 48%, 14 km: 44%, 15 km: 40%.
---
------
---@param self DETECTION_BASE 
---@param DistanceProbability NOTYPE The probability factor.
---@return DETECTION_BASE #self
function DETECTION_BASE:SetDistanceProbability(DistanceProbability) end

---Set the radius in meters to validate if friendlies are nearby.
---
------
---@param self DETECTION_BASE 
---@param FriendliesRange number Radius to use when checking if Friendlies are nearby.
---@return DETECTION_BASE #self
function DETECTION_BASE:SetFriendliesRange(FriendliesRange) end

---This will allow during friendly search any recce or detection unit to be also considered as a friendly.
---By default, recce aren't considered friendly, because that would mean that a recce would be also an attacking friendly,
---and this is wrong.
---However, in a CAP situation, when the CAP is part of an EWR network, the CAP is also an attacker.
---This, this method allows to register for a detection the CAP unit name prefixes to be considered CAP.
---
------
---@param self DETECTION_BASE 
---@param FriendlyPrefixes string A string or a list of prefixes.
---@return DETECTION_BASE #
function DETECTION_BASE:SetFriendlyPrefixes(FriendlyPrefixes) end

---Set the parameters to calculate to optimal intercept point.
---
------
---@param self DETECTION_BASE 
---@param Intercept boolean Intercept is true if an intercept point is calculated. Intercept is false if it is disabled. The default Intercept is false.
---@param InterceptDelay number If Intercept is true, then InterceptDelay is the average time it takes to get airplanes airborne.
---@return DETECTION_BASE #self
function DETECTION_BASE:SetIntercept(Intercept, InterceptDelay) end

---Method to make the radar detection less accurate, e.g.
---for WWII scenarios.
---
------
---@param self DETECTION_BASE 
---@param minheight number Minimum flight height to be detected, in meters AGL (above ground)
---@param thresheight number Threshold to escape the radar if flying below minheight, defaults to 90 (90% escape chance)
---@param thresblur number Threshold to be detected by the radar overall, defaults to 85 (85% chance to be found)
---@param closing number Closing-in in km - the limit of km from which on it becomes increasingly difficult to escape radar detection if flying towards the radar position. Should be about 1/3 of the radar detection radius in kilometers, defaults to 20.
---@return DETECTION_BASE #self
function DETECTION_BASE:SetRadarBlur(minheight, thresheight, thresblur, closing) end

---Set the detection interval time in seconds.
---
------
---@param self DETECTION_BASE 
---@param RefreshTimeInterval number Interval in seconds.
---@return DETECTION_BASE #self
function DETECTION_BASE:SetRefreshTimeInterval(RefreshTimeInterval) end

---Reject detections if within the specified zone(s).
---
------
---@param self DETECTION_BASE 
---@param RejectZones ZONE_BASE Can be a list or ZONE_BASE objects, or a single ZONE_BASE object.
---@return DETECTION_BASE #self
function DETECTION_BASE:SetRejectZones(RejectZones) end

---Upon a **visual** detection, the more a detected unit is within a cloudy zone, the less likely the detected unit is to be detected successfully.
---The Cloudy Zones work with the ZONE_BASE derived classes. The mission designer can define within the mission
---zones that reflect cloudy areas where detected units may not be so easily visually detected.
---
------
---@param self DETECTION_BASE 
---@param ZoneArray NOTYPE Aray of a The ZONE_BASE object and a ZoneProbability pair..
---@return DETECTION_BASE #self
function DETECTION_BASE:SetZoneProbability(ZoneArray) end

---Synchronous Event Trigger for Event Start.
---
------
---@param self DETECTION_BASE 
function DETECTION_BASE:Start() end

---Synchronous Event Trigger for Event Stop.
---
------
---@param self DETECTION_BASE 
function DETECTION_BASE:Stop() end

---UnIdentify all detected objects during detection processing.
---
------
---@param self DETECTION_BASE 
function DETECTION_BASE:UnIdentifyAllDetectedObjects() end

---UnIdentify a detected object during detection processing.
---
------
---@param self DETECTION_BASE 
---@param DetectedObject DETECTION_BASE.DetectedObject 
function DETECTION_BASE:UnIdentifyDetectedObject(DetectedObject) end

---Unlock a detected item.
---
------
---@param self DETECTION_BASE 
---@param DetectedItem DETECTION_BASE.DetectedItem The DetectedItem.
---@return DETECTION_BASE #
function DETECTION_BASE:UnlockDetectedItem(DetectedItem) end

---Unlock the detected items when created and unlock all existing detected items.
---
------
---@param self DETECTION_BASE 
---@return DETECTION_BASE #
function DETECTION_BASE:UnlockDetectedItems() end

---Set IsDetected flag for the DetectedItem, which can have more units.
---
------
---@param self DETECTION_BASE 
---@param DetectedItem NOTYPE 
---@return DETECTION_BASE.DetectedItem #DetectedItem
---@return boolean #true if at least one UNIT is detected from the DetectedSet, false if no UNIT was detected from the DetectedSet.
function DETECTION_BASE:UpdateDetectedItemDetection(DetectedItem) end

---Asynchronous Event Trigger for Event Detect.
---
------
---@param self DETECTION_BASE 
---@param Delay number The delay in seconds.
function DETECTION_BASE:__Detect(Delay) end

---Asynchronous Event Trigger for Event Detected.
---
------
---@param self DETECTION_BASE 
---@param Delay number The delay in seconds.
---@param Units table Table of detected units.
function DETECTION_BASE:__Detected(Delay, Units) end

---Asynchronous Event Trigger for Event Start.
---
------
---@param self DETECTION_BASE 
---@param Delay number The delay in seconds.
function DETECTION_BASE:__Start(Delay) end

---Asynchronous Event Trigger for Event Stop.
---
------
---@param self DETECTION_BASE 
---@param Delay number The delay in seconds.
function DETECTION_BASE:__Stop(Delay) end


---
------
---@param self NOTYPE 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@private
function DETECTION_BASE:onafterDetect(From, Event, To) end


---
------
---@param self DETECTION_BASE 
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@param Detection GROUP The Group detecting.
---@param DetectionTimeStamp number Time stamp of detection event.
---@private
function DETECTION_BASE:onafterDetection(From, Event, To, Detection, DetectionTimeStamp) end


---
------
---@param self NOTYPE 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@private
function DETECTION_BASE:onafterStart(From, Event, To) end


---Detected item data structure.
---@class DETECTION_BASE.DetectedItem 
---@field CategoryName string Category name of the detected unit.
---@field Changed boolean Documents if the detected area has changed.
---@field Changes table A list of the changes reported on the detected area. (It is up to the user of the detected area to consume those changes).
---@field Coordinate COORDINATE The last known coordinate of the DetectedItem.
---@field Distance number Distance to the detected item.
---@field DistanceRecce number Distance in meters of the Recce.
---@field FriendliesDistance table Table of distances to friendly units.
---@field FriendliesNearBy boolean Indicates if there are friendlies within the detected area.
---@field ID number The identifier of the detected area.
---@field Index number Detected item key. Could also be a string.
---@field InterceptCoord COORDINATE Intercept coordinate.
---@field IsDetected boolean Indicates if the DetectedItem has been detected or not.
---@field IsVisible boolean If true, detected object is visible.
---@field ItemID string ItemPrefix .. "." .. self.DetectedItemMax.
---@field KnowDistance boolean Distance to the detected item is known.
---@field KnowType boolean Type of detected item is known.
---@field LastPos Vec3 Last known position of the detected item.
---@field LastTime number Last time the detected item was seen.
---@field LastVelocity Vec3 Last recorded 3D velocity vector of the detected item.
---@field Locked boolean Lock detected item.
---@field Name string Name of the detected object.
---@field NearestFAC UNIT The nearest FAC near the Area.
---@field PlayersNearBy table Table of nearby players.
---@field Removed boolean 
---@field Set SET_UNIT The Set of Units in the detected area.
---@field TypeName string Type name of the detected unit.
---@field Zone ZONE_UNIT The Zone of the detected area.
DETECTION_BASE.DetectedItem = {}


---@class DETECTION_BASE.DetectedObject 
---@field Distance number 
---@field Identified boolean 
---@field IsVisible boolean 
---@field KnowDistance boolean 
---@field KnowType boolean 
---@field LastPos boolean 
---@field LastTime number 
---@field LastVelocity number 
---@field Name string 
---@field Type string 
DETECTION_BASE.DetectedObject = {}


---Will detect units within the battle zone.
---It will build a DetectedItems[] list filled with DetectedItems, grouped by the type of units detected.
---Each DetectedItem will contain a field Set, which contains a Core.Set#SET_UNIT containing ONE Wrapper.Unit#UNIT object reference.
---Beware that when the amount of different types detected is large, the DetectedItems[] list will be large also.
---@class DETECTION_TYPES : DETECTION_BASE
---@field _BoundDetectedZones boolean 
---@field _FlareDetectedUnits boolean 
---@field _FlareDetectedZones boolean 
---@field _SmokeDetectedUnits boolean 
---@field _SmokeDetectedZones boolean 
DETECTION_TYPES = {}

---Create the DetectedItems list from the DetectedObjects table.
---For each DetectedItem, a one field array is created containing the Unit detected.
---
------
---@param self DETECTION_TYPES 
---@return DETECTION_TYPES #self
function DETECTION_TYPES:CreateDetectionItems() end

---Report summary of a DetectedItem using a given numeric index.
---
------
---@param self DETECTION_TYPES 
---@param DetectedItem DETECTION_BASE.DetectedItem The DetectedItem.
---@param AttackGroup GROUP The group to generate the report for.
---@param Settings SETTINGS Message formatting settings to use.
---@return REPORT #The report of the detection items.
function DETECTION_TYPES:DetectedItemReportSummary(DetectedItem, AttackGroup, Settings) end

---Report detailed of a detection result.
---
------
---@param self DETECTION_TYPES 
---@param AttackGroup GROUP The group to generate the report for.
---@return string #
function DETECTION_TYPES:DetectedReportDetailed(AttackGroup) end

---Make text documenting the changes of the detected zone.
---
------
---@param self DETECTION_TYPES 
---@param DetectedItem DETECTION_BASE.DetectedItem 
---@return string #The Changes text
function DETECTION_TYPES:GetChangeText(DetectedItem) end

---DETECTION_TYPES constructor.
---
------
---@param self DETECTION_TYPES 
---@param DetectionSetGroup SET_GROUP The @{Core.Set} of GROUPs in the Recce role.
---@return DETECTION_TYPES #self
function DETECTION_TYPES:New(DetectionSetGroup) end


---Will detect units within the battle zone.
---
---It will build a DetectedItems list filled with DetectedItems. Each DetectedItem will contain a field Set, which contains a Core.Set#SET_UNIT containing ONE Wrapper.Unit#UNIT object reference.
---Beware that when the amount of units detected is large, the DetectedItems list will be large also.
---@class DETECTION_UNITS : DETECTION_BASE
---@field DetectionRange Distance The range till which targets are detected.
---@field _BoundDetectedZones boolean 
---@field _FlareDetectedUnits boolean 
---@field _FlareDetectedZones boolean 
---@field _SmokeDetectedUnits boolean 
---@field _SmokeDetectedZones boolean 
DETECTION_UNITS = {}

---Create the DetectedItems list from the DetectedObjects table.
---For each DetectedItem, a one field array is created containing the Unit detected.
---
------
---@param self DETECTION_UNITS 
---@return DETECTION_UNITS #self
function DETECTION_UNITS:CreateDetectionItems() end

---Report summary of a DetectedItem using a given numeric index.
---
------
---@param self DETECTION_UNITS 
---@param DetectedItem DETECTION_BASE.DetectedItem The DetectedItem.
---@param AttackGroup GROUP The group to generate the report for.
---@param Settings SETTINGS Message formatting settings to use.
---@param ForceA2GCoordinate boolean Set creation of A2G coordinate
---@return REPORT #The report of the detection items.
function DETECTION_UNITS:DetectedItemReportSummary(DetectedItem, AttackGroup, Settings, ForceA2GCoordinate) end

---Report detailed of a detection result.
---
------
---@param self DETECTION_UNITS 
---@param AttackGroup GROUP The group to generate the report for.
---@return string #
function DETECTION_UNITS:DetectedReportDetailed(AttackGroup) end

---Make text documenting the changes of the detected zone.
---
------
---@param self DETECTION_UNITS 
---@param DetectedItem DETECTION_BASE.DetectedItem 
---@return string #The Changes text
function DETECTION_UNITS:GetChangeText(DetectedItem) end

---DETECTION_UNITS constructor.
---
------
---@param self DETECTION_UNITS 
---@param DetectionSetGroup SET_GROUP The @{Core.Set} of GROUPs in the Forward Air Controller role.
---@return DETECTION_UNITS #self
function DETECTION_UNITS:New(DetectionSetGroup) end



