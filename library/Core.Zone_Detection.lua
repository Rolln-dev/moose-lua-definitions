---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/MOOSE.JPG" width="100%">
---
---**Core** - The ZONE_DETECTION class, defined by a zone name, a detection object and a radius.
---The ZONE_DETECTION class defined by a zone name, a location and a radius.
---This class implements the inherited functions from Core.Zone#ZONE_BASE taking into account the own zone format and properties.
---
---## ZONE_DETECTION constructor
---
---  * #ZONE_DETECTION.New(): Constructor.
---@class ZONE_DETECTION : ZONE_BASE
---@field Detection NOTYPE 
---@field Radius Distance The radius of the zone.
---@field Vec2 Vec2 The current location of the zone.
ZONE_DETECTION = {}

---Bounds the zone with tires.
---
------
---@param self ZONE_DETECTION 
---@param Points? number (optional) The amount of points in the circle. Default 360.
---@param CountryID country.id The country id of the tire objects, e.g. country.id.USA for blue or country.id.RUSSIA for red.
---@param UnBound? boolean (Optional) If true the tyres will be destroyed.
---@return ZONE_DETECTION #self
function ZONE_DETECTION:BoundZone(Points, CountryID, UnBound) end

---Flares the zone boundaries in a color.
---
------
---@param self ZONE_DETECTION 
---@param FlareColor FLARECOLOR The flare color.
---@param Points? number (optional) The amount of points in the circle.
---@param Azimuth? Azimuth (optional) Azimuth The azimuth of the flare.
---@param AddHeight? number (optional) The height to be added for the smoke.
---@return ZONE_DETECTION #self
function ZONE_DETECTION:FlareZone(FlareColor, Points, Azimuth, AddHeight) end

---Returns the radius around the detected locations defining the combine zone.
---
------
---@param self ZONE_DETECTION 
---@return Distance #The radius.
function ZONE_DETECTION:GetRadius() end

---Returns if a location is within the zone.
---
------
---@param self ZONE_DETECTION 
---@param Vec2 Vec2 The location to test.
---@return boolean #true if the location is within the zone.
function ZONE_DETECTION:IsVec2InZone(Vec2) end

---Returns if a point is within the zone.
---
------
---@param self ZONE_DETECTION 
---@param Vec3 Vec3 The point to test.
---@return boolean #true if the point is within the zone.
function ZONE_DETECTION:IsVec3InZone(Vec3) end

---Constructor of #ZONE_DETECTION, taking the zone name, the zone location and a radius.
---
------
---@param self ZONE_DETECTION 
---@param ZoneName string Name of the zone.
---@param Detection DETECTION_BASE The detection object defining the locations of the central detections.
---@param Radius Distance The radius around the detections defining the combined zone.
---@return ZONE_DETECTION #self
function ZONE_DETECTION:New(ZoneName, Detection, Radius) end

---Sets the radius around the detected locations defining the combine zone.
---
------
---@param self ZONE_DETECTION 
---@param Radius Distance The radius.
---@return ZONE_DETECTION #self
function ZONE_DETECTION:SetRadius(Radius) end

---Smokes the zone boundaries in a color.
---
------
---@param self ZONE_DETECTION 
---@param SmokeColor SMOKECOLOR The smoke color.
---@param Points? number (optional) The amount of points in the circle.
---@param AddHeight? number (optional) The height to be added for the smoke.
---@param AddOffSet? number (optional) The angle to be added for the smoking start position.
---@param AngleOffset NOTYPE 
---@return ZONE_DETECTION #self
function ZONE_DETECTION:SmokeZone(SmokeColor, Points, AddHeight, AddOffSet, AngleOffset) end



