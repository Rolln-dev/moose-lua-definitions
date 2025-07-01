---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Core_Zones.JPG" width="100%">
---
---**Core** - Define zones within your mission of various forms, with various capabilities.
---
---===
---
---## Features:
---
---  * Create radius zones.
---  * Create trigger zones.
---  * Create polygon zones.
---  * Create moving zones around a unit.
---  * Create moving zones around a group.
---  * Provide the zone behavior. Some zones are static, while others are moveable.
---  * Enquire if a coordinate is within a zone.
---  * Smoke zones.
---  * Set a zone probability to control zone selection.
---  * Get zone coordinates.
---  * Get zone properties.
---  * Get zone bounding box.
---  * Set/get zone name.
---  * Draw zones (circular and polygon) on the F10 map.
---
---
---There are essentially two core functions that zones accommodate:
---
---  * Test if an object is within the zone boundaries.
---  * Provide the zone behavior. Some zones are static, while others are moveable.
---
---The object classes are using the zone classes to test the zone boundaries, which can take various forms:
---
---  * Test if completely within the zone.
---  * Test if partly within the zone (for Wrapper.Group#GROUP objects).
---  * Test if not in the zone.
---  * Distance to the nearest intersecting point of the zone.
---  * Distance to the center of the zone.
---  * ...
---
---Each of these ZONE classes have a zone name, and specific parameters defining the zone type:
---
---  * #ZONE_BASE: The ZONE_BASE class defining the base for all other zone classes.
---  * #ZONE_RADIUS: The ZONE_RADIUS class defined by a zone name, a location and a radius.
---  * #ZONE: The ZONE class, defined by the zone name as defined within the Mission Editor.
---  * #ZONE_UNIT: The ZONE_UNIT class defines by a zone around a Wrapper.Unit#UNIT with a radius.
---  * #ZONE_GROUP: The ZONE_GROUP class defines by a zone around a Wrapper.Group#GROUP with a radius.
---  * #ZONE_POLYGON: The ZONE_POLYGON class defines by a sequence of Wrapper.Group#GROUP waypoints within the Mission Editor, forming a polygon.
---  * #ZONE_OVAL: The ZONE_OVAL class is defined by a center point, major axis, minor axis, and angle.
---
---===
---
---### [Demo Missions](https://github.com/FlightControl-Master/MOOSE_Demos/tree/master/Core/Zone)
---
---===
---
---### Author: **FlightControl**
---### Contributions: **Applevangelist**, **FunkyFranky**, **coconutcockpit**
---
---===
---The ZONE class, defined by the zone name as defined within the Mission Editor.
---This class implements the inherited functions from #ZONE_RADIUS taking into account the own zone format and properties.
---
---## ZONE constructor
---
---  * #ZONE.New(): Constructor. This will search for a trigger zone with the name given, and will return for you a ZONE object.
---
---## Declare a ZONE directly in the DCS mission editor!
---
---You can declare a ZONE using the DCS mission editor by adding a trigger zone in the mission editor.
---
---Then during mission startup, when loading Moose.lua, this trigger zone will be detected as a ZONE declaration.
---Within the background, a ZONE object will be created within the Core.Database.
---The ZONE name will be the trigger zone name.
---
---So, you can search yourself for the ZONE object by using the #ZONE.FindByName() method.
---In this example, `local TriggerZone = ZONE:FindByName( "DefenseZone" )` would return the ZONE object
---that was created at mission startup, and reference it into the `TriggerZone` local object.
---
---Refer to mission `ZON-110` for a demonstration.
---
---This is especially handy if you want to quickly setup a SET_ZONE...
---So when you would declare `local SetZone = SET_ZONE:New():FilterPrefixes( "Defense" ):FilterStart()`,
---then SetZone would contain the ZONE object `DefenseZone` as part of the zone collection,
---without much scripting overhead!!!
---@class ZONE : ZONE_RADIUS
ZONE = {}

---Find a zone in the _DATABASE using the name of the zone.
---
------
---@param self ZONE 
---@param ZoneName string The name of the zone.
---@return ZONE #self
function ZONE:FindByName(ZoneName) end

---Constructor of ZONE taking the zone name.
---
------
---@param self ZONE 
---@param ZoneName string The name of the zone as defined within the mission editor.
---@return ZONE #self
function ZONE:New(ZoneName) end


---The ZONE_AIRBASE class defines by a zone around a Wrapper.Airbase#AIRBASE with a radius.
---This class implements the inherited functions from #ZONE_RADIUS taking into account the own zone format and properties.
---@class ZONE_AIRBASE : ZONE_RADIUS
---@field private isAirdrome boolean If `true`, airbase is an airdrome.
---@field private isHelipad boolean If `true`, airbase is a helipad.
---@field private isShip boolean If `true`, airbase is a ship.
ZONE_AIRBASE = {}

---Get the airbase as part of the ZONE_AIRBASE object.
---
------
---@param self ZONE_AIRBASE 
---@return AIRBASE #The airbase.
function ZONE_AIRBASE:GetAirbase() end

---Returns a Core.Point#COORDINATE object reflecting a random 2D location within the zone.
---Note that this is actually a Core.Point#COORDINATE type object, and not a simple Vec2 table.
---
------
---@param self ZONE_AIRBASE 
---@param inner? number (optional) Minimal distance from the center of the zone. Default is 0.
---@param outer? number (optional) Maximal distance from the outer edge of the zone. Default is the radius of the zone.
---@return COORDINATE #The @{Core.Point#COORDINATE} object reflecting the random 3D location within the zone.
function ZONE_AIRBASE:GetRandomPointVec2(inner, outer) end

---Returns the current location of the AIRBASE.
---
------
---@param self ZONE_AIRBASE 
---@return Vec2 #The location of the zone based on the AIRBASE location.
function ZONE_AIRBASE:GetVec2() end

---Constructor to create a ZONE_AIRBASE instance, taking the zone name, a zone Wrapper.Airbase#AIRBASE and a radius.
---
------
---@param self ZONE_AIRBASE 
---@param AirbaseName string Name of the airbase.
---@param Radius? Distance (Optional)The radius of the zone in meters. Default 4000 meters.
---@return ZONE_AIRBASE #self
function ZONE_AIRBASE:New(AirbaseName, Radius) end


---This class is an abstract BASE class for derived classes, and is not meant to be instantiated.
---
---## Each zone has a name:
---
---  * #ZONE_BASE.GetName(): Returns the name of the zone.
---  * #ZONE_BASE.SetName(): Sets the name of the zone.
---
---
---## Each zone implements two polymorphic functions defined in #ZONE_BASE:
---
---  * #ZONE_BASE.IsVec2InZone(): Returns if a 2D vector is within the zone.
---  * #ZONE_BASE.IsVec3InZone(): Returns if a 3D vector is within the zone.
---  * #ZONE_BASE.IsPointVec2InZone(): Returns if a 2D point vector is within the zone.
---  * #ZONE_BASE.IsPointVec3InZone(): Returns if a 3D point vector is within the zone.
---
---## A zone has a probability factor that can be set to randomize a selection between zones:
---
---  * #ZONE_BASE.SetZoneProbability(): Set the randomization probability of a zone to be selected, taking a value between 0 and 1 ( 0 = 0%, 1 = 100% )
---  * #ZONE_BASE.GetZoneProbability(): Get the randomization probability of a zone to be selected, passing a value between 0 and 1 ( 0 = 0%, 1 = 100% )
---  * #ZONE_BASE.GetZoneMaybe(): Get the zone taking into account the randomization probability. nil is returned if this zone is not a candidate.
---
---## A zone manages vectors:
---
---  * #ZONE_BASE.GetVec2(): Returns the 2D vector coordinate of the zone.
---  * #ZONE_BASE.GetVec3(): Returns the 3D vector coordinate of the zone.
---  * #ZONE_BASE.GetPointVec2(): Returns the 2D point vector coordinate of the zone.
---  * #ZONE_BASE.GetPointVec3(): Returns the 3D point vector coordinate of the zone.
---  * #ZONE_BASE.GetRandomVec2(): Define a random 2D vector within the zone.
---  * #ZONE_BASE.GetRandomPointVec2(): Define a random 2D point vector within the zone.
---  * #ZONE_BASE.GetRandomPointVec3(): Define a random 3D point vector within the zone.
---
---## A zone has a bounding square:
---
---  * #ZONE_BASE.GetBoundingSquare(): Get the outer most bounding square of the zone.
---
---## A zone can be marked:
---
---  * #ZONE_BASE.SmokeZone(): Smokes the zone boundaries in a color.
---  * #ZONE_BASE.FlareZone(): Flares the zone boundaries in a color.
---
---## A zone might have additional Properties created in the DCS Mission Editor, which can be accessed:
---
---  *#ZONE_BASE.GetProperty(): Returns the Value of the zone with the given PropertyName, or nil if no matching property exists.
---  *#ZONE_BASE.GetAllProperties(): Returns the zone Properties table.
---@class ZONE_BASE : FSM
---@field Checktime number Check every Checktime seconds, used for ZONE:Trigger()
---@field Color table Table with four entries, e.g. {1, 0, 0, 0.15}. First three are RGB color code. Fourth is the transparency Alpha value.
---@field Coordinate NOTYPE 
---@field DrawID number Unique ID of the drawn zone on the F10 map.
---@field FillColor table Table with four entries, e.g. {1, 0, 0, 0.15}. First three are RGB color code. Fourth is the transparency Alpha value.
---@field ObjectsInZone boolean 
---@field Surface number Type of surface. Only determined at the center of the zone!
---@field Table table of any trigger zone properties from the ME. The key is the Name of the property, and the value is the property's Value.
---@field ZoneID number ID of zone. Only zones defined in the ME have an ID!
---@field ZoneName string Name of the zone.
---@field ZoneProbability number A value between 0 and 1. 0 = 0% and 1 = 100% probability.
---@field private checkobjects NOTYPE 
---@field private drawCoalition number Draw coalition.
---@field private objectset NOTYPE 
ZONE_BASE = {}

---Bound the zone boundaries with a tires.
---
------
---@param self ZONE_BASE 
function ZONE_BASE:BoundZone() end

---Get 2D distance to a coordinate.
---
------
---@param self ZONE_BASE 
---@param Coordinate COORDINATE Reference coordinate. Can also be a DCS#Vec2 or DCS#Vec3 object.
---@return number #Distance to the reference coordinate in meters.
function ZONE_BASE:Get2DDistance(Coordinate) end

---Returns the zone Properties table.
---
------
---@param self ZONE_BASE 
---@return table #The Key:Value table of TriggerZone properties of the zone.
function ZONE_BASE:GetAllProperties() end

---Get the bounding square the zone.
---
------
---@param self ZONE_BASE 
---@return nil #The bounding square.
function ZONE_BASE:GetBoundingSquare() end

---Get color table of the zone.
---
------
---@param self ZONE_BASE 
---@return table #Table with four entries, e.g. {1, 0, 0, 0.15}. First three are RGB color code. Fourth is the transparency Alpha value.
function ZONE_BASE:GetColor() end

---Get transparency Alpha value of zone.
---
------
---@param self ZONE_BASE 
---@return number #Alpha value.
function ZONE_BASE:GetColorAlpha() end

---Get RGB color of zone.
---
------
---@param self ZONE_BASE 
---@return table #Table with three entries, e.g. {1, 0, 0}, which is the RGB color code.
function ZONE_BASE:GetColorRGB() end

---Returns a Core.Point#COORDINATE of the zone.
---
------
---@param self ZONE_BASE 
---@param Height Distance The height to add to the land height where the center of the zone is located.
---@return COORDINATE #The Coordinate of the zone.
function ZONE_BASE:GetCoordinate(Height) end

---Get draw coalition of zone.
---
------
---@param self ZONE_BASE 
---@return number #Draw coalition.
function ZONE_BASE:GetDrawCoalition() end

---Get ID of the zone object drawn on the F10 map.
---The ID can be used to remove the drawn object from the F10 map view via `UTILS.RemoveMark(MarkID)`.
---
------
---@param self ZONE_BASE 
---@return number #Unique ID of the
function ZONE_BASE:GetDrawID() end

---Get fill color table of the zone.
---
------
---@param self ZONE_BASE 
---@return table #Table with four entries, e.g. {1, 0, 0, 0.15}. First three are RGB color code. Fourth is the transparency Alpha value.
function ZONE_BASE:GetFillColor() end

---Get transparency Alpha fill value of zone.
---
------
---@param self ZONE_BASE 
---@return number #Alpha value.
function ZONE_BASE:GetFillColorAlpha() end

---Get RGB fill color of zone.
---
------
---@param self ZONE_BASE 
---@return table #Table with three entries, e.g. {1, 0, 0}, which is the RGB color code.
function ZONE_BASE:GetFillColorRGB() end

---Returns the name of the zone.
---
------
---@param self ZONE_BASE 
---@return string #The name of the zone.
function ZONE_BASE:GetName() end

---Returns a Core.Point#COORDINATE of the zone.
---
------
---@param self ZONE_BASE 
---@param Height Distance The height to add to the land height where the center of the zone is located.
---@return COORDINATE #The COORDINATE of the zone.
function ZONE_BASE:GetPointVec2(Height) end

---Returns a Core.Point#COORDINATE of the zone.
---
------
---@param self ZONE_BASE 
---@param Height Distance The height to add to the land height where the center of the zone is located.
---@return COORDINATE #The PointVec3 of the zone.
function ZONE_BASE:GetPointVec3(Height) end

---Returns the Value of the zone with the given PropertyName, or nil if no matching property exists.
---
------
---
---USAGE
---```
---
---local PropertiesZone = ZONE:FindByName("Properties Zone")
---local Property = "ExampleProperty"
---local PropertyValue = PropertiesZone:GetProperty(Property)
---```
------
---@param self ZONE_BASE 
---@param PropertyName string The name of a the TriggerZone Property to be retrieved.
---@return string #The Value of the TriggerZone Property with the given PropertyName, or nil if absent.
function ZONE_BASE:GetProperty(PropertyName) end

---Define a random Core.Point#COORDINATE within the zone.
---Note that this is actually a Core.Point#COORDINATE type object, and not a simple Vec2 table.
---
------
---@param self ZONE_BASE 
---@return COORDINATE #The COORDINATE coordinates.
function ZONE_BASE:GetRandomPointVec2() end

---Define a random Core.Point#COORDINATE within the zone.
---Note that this is actually a Core.Point#COORDINATE type object, and not a simple Vec3 table.
---
------
---@param self ZONE_BASE 
---@return COORDINATE #The COORDINATE coordinates.
function ZONE_BASE:GetRandomPointVec3() end

---Define a random DCS#Vec2 within the zone.
---
------
---@param self ZONE_BASE 
---@return Vec2 #The Vec2 coordinates.
function ZONE_BASE:GetRandomVec2() end

---Get surface type of the zone.
---
------
---@param self ZONE_BASE 
---@return SurfaceType #Type of surface.
function ZONE_BASE:GetSurfaceType() end

---Returns the DCS#Vec2 coordinate of the zone.
---
------
---@param self ZONE_BASE 
---@return nil #
function ZONE_BASE:GetVec2() end

---Returns the DCS#Vec3 of the zone.
---
------
---@param self ZONE_BASE 
---@param Height Distance The height to add to the land height where the center of the zone is located.
---@return Vec3 #The Vec3 of the zone.
function ZONE_BASE:GetVec3(Height) end

---Get the zone taking into account the randomization probability of a zone to be selected.
---
------
---
---USAGE
---```
---
---local ZoneArray = { ZONE:New( "Zone1" ), ZONE:New( "Zone2" ) }
---
----- We set a zone probability of 70% to the first zone and 30% to the second zone.
---ZoneArray[1]:SetZoneProbability( 0.5 )
---ZoneArray[2]:SetZoneProbability( 0.5 )
---
---local ZoneSelected = nil
---
---while ZoneSelected == nil do
---  for _, Zone in pairs( ZoneArray ) do
---    ZoneSelected = Zone:GetZoneMaybe()
---    if ZoneSelected ~= nil then
---      break
---    end
---  end
---end
---
----- The result should be that Zone1 would be more probable selected than Zone2.
---```
------
---@param self ZONE_BASE 
---@return ZONE_BASE #The zone is selected taking into account the randomization probability factor.
---@return nil #The zone is not selected taking into account the randomization probability factor.
function ZONE_BASE:GetZoneMaybe() end

---Get the randomization probability of a zone to be selected.
---
------
---@param self ZONE_BASE 
---@return number #A value between 0 and 1. 0 = 0% and 1 = 100% probability.
function ZONE_BASE:GetZoneProbability() end

---Returns if a Coordinate is within the zone.
---
------
---@param self ZONE_BASE 
---@param Coordinate COORDINATE The coordinate to test.
---@return boolean #true if the coordinate is within the zone.
function ZONE_BASE:IsCoordinateInZone(Coordinate) end

---Returns if a PointVec2 is within the zone.
---(Name is misleading, actually takes a #COORDINATE)
---
------
---@param self ZONE_BASE 
---@param Coordinate COORDINATE The coordinate to test.
---@return boolean #true if the PointVec2 is within the zone.
function ZONE_BASE:IsPointVec2InZone(Coordinate) end

---Returns if a PointVec3 is within the zone.
---
------
---@param self ZONE_BASE 
---@param PointVec3 COORDINATE The PointVec3 to test.
---@return boolean #true if the PointVec3 is within the zone.
function ZONE_BASE:IsPointVec3InZone(PointVec3) end

---Returns if a Vec2 is within the zone.
---
------
---@param self ZONE_BASE 
---@param Vec2 Vec2 The Vec2 to test.
---@return boolean #true if the Vec2 is within the zone.
function ZONE_BASE:IsVec2InZone(Vec2) end

---Returns if a Vec3 is within the zone.
---
------
---@param self ZONE_BASE 
---@param Vec3 Vec3 The point to test.
---@return boolean #true if the Vec3 is within the zone.
function ZONE_BASE:IsVec3InZone(Vec3) end

---ZONE_BASE constructor
---
------
---@param self ZONE_BASE 
---@param ZoneName string Name of the zone.
---@return ZONE_BASE #self
function ZONE_BASE:New(ZoneName) end

---On After "EnteredZone" event.
---An observed object has entered the zone.
---
------
---@param self ZONE_BASE 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Controllable CONTROLLABLE The controllable entering the zone.
function ZONE_BASE:OnAfterEnteredZone(From, Event, To, Controllable) end

---On After "LeftZone" event.
---An observed object has left the zone.
---
------
---@param self ZONE_BASE 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Controllable CONTROLLABLE The controllable leaving the zone.
function ZONE_BASE:OnAfterLeftZone(From, Event, To, Controllable) end

---On After "ObjectDead" event.
---An observed object has left the zone.
---
------
---@param self ZONE_BASE 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Controllable CONTROLLABLE The controllable which died. Might be nil.
function ZONE_BASE:OnAfterObjectDead(From, Event, To, Controllable) end

---On After "ZoneEmpty" event.
---All observed objects have left the zone or are dead.
---
------
---@param self ZONE_BASE 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function ZONE_BASE:OnAfterZoneEmpty(From, Event, To) end

---Set the check time for ZONE:Trigger()
---
------
---@param self ZONE_BASE 
---@param seconds number Check every seconds for objects entering or leaving the zone. Defaults to 5 secs.
---@return ZONE_BASE #self
function ZONE_BASE:SetCheckTime(seconds) end

---Set color of zone.
---
------
---@param self ZONE_BASE 
---@param RGBcolor table RGB color table. Default `{1, 0, 0}`.
---@param Alpha number Transparency between 0 and 1. Default 0.15.
---@return ZONE_BASE #self
function ZONE_BASE:SetColor(RGBcolor, Alpha) end

---Set draw coalition of zone.
---
------
---@param self ZONE_BASE 
---@param Coalition number Coalition. Default -1.
---@return ZONE_BASE #self
function ZONE_BASE:SetDrawCoalition(Coalition) end

---Set fill color of zone.
---
------
---@param self ZONE_BASE 
---@param RGBcolor table RGB color table. Default `{1, 0, 0}`.
---@param Alpha number Transparacy between 0 and 1. Default 0.15.
---@return ZONE_BASE #self
function ZONE_BASE:SetFillColor(RGBcolor, Alpha) end

---Sets the name of the zone.
---
------
---@param self ZONE_BASE 
---@param ZoneName string The name of the zone.
---@return ZONE_BASE #
function ZONE_BASE:SetName(ZoneName) end

---Set the randomization probability of a zone to be selected.
---
------
---@param self ZONE_BASE 
---@param ZoneProbability number A value between 0 and 1. 0 = 0% and 1 = 100% probability.
---@return ZONE_BASE #self
function ZONE_BASE:SetZoneProbability(ZoneProbability) end

---Smokes the zone boundaries in a color.
---
------
---@param self ZONE_BASE 
---@param SmokeColor SMOKECOLOR The smoke color.
function ZONE_BASE:SmokeZone(SmokeColor) end

---Start watching if the Object or Objects move into or out of a zone.
---
------
---
---USAGE
---```
---           -- Create a new zone and start watching it every 5 secs for a defined GROUP entering or leaving
---           local triggerzone = ZONE:New("ZonetoWatch"):Trigger(GROUP:FindByName("Aerial-1"))
---
---           -- This FSM function will be called when the group enters the zone
---           function triggerzone:OnAfterEnteredZone(From,Event,To,Group)
---             MESSAGE:New("Group has entered zone!",15):ToAll()
---           end
---
---           -- This FSM function will be called when the group leaves the zone
---           function triggerzone:OnAfterLeftZone(From,Event,To,Group)
---             MESSAGE:New("Group has left zone!",15):ToAll()
---           end
---
---           -- Stop watching the zone after 1 hour
---          triggerzone:__TriggerStop(3600)
---```
------
---@param self ZONE_BASE 
---@param Objects CONTROLLABLE Object or Objects to watch, can be of type UNIT, GROUP, CLIENT, or SET\_UNIT, SET\_GROUP, SET\_CLIENT
---@return ZONE_BASE #self
function ZONE_BASE:Trigger(Objects) end

---Triggers the FSM event "TriggerStop".
---Stops the ZONE_BASE Trigger.
---
------
---@param self ZONE_BASE 
function ZONE_BASE:TriggerStop() end

---Remove the drawing of the zone from the F10 map.
---
------
---@param self ZONE_BASE 
---@param Delay? number (Optional) Delay before the drawing is removed.
---@return ZONE_BASE #self
function ZONE_BASE:UndrawZone(Delay) end

---(Internal) Check the assigned objects for being in/out of the zone
---
------
---@param self ZONE_BASE 
---@param fromstart boolean If true, do the init of the objects
---@return ZONE_BASE #self
function ZONE_BASE:_TriggerCheck(fromstart) end

---Triggers the FSM event "TriggerStop" after a delay.
---
------
---@param self ZONE_BASE 
---@param delay number Delay in seconds.
function ZONE_BASE:__TriggerStop(delay) end

---(Internal) Check the assigned objects for being in/out of the zone
---
------
---@param self ZONE_BASE 
---@param From string 
---@param Event string 
---@param to string 
---@param To NOTYPE 
---@return ZONE_BASE #self
---@private
function ZONE_BASE:onafterTriggerRunCheck(From, Event, to, To) end


---The ZONE_BASE.BoundingSquare
---@class ZONE_BASE.BoundingSquare 
---@field private x1 Distance The lower x coordinate (left down)
---@field private x2 Distance The higher x coordinate (right up)
---@field private y1 Distance The lower y coordinate (left down)
---@field private y2 Distance The higher y coordinate (right up)
ZONE_BASE.BoundingSquare = {}


---The ZONE_ELASTIC class defines a dynamic polygon zone, where only the convex hull is used.
---@class ZONE_ELASTIC : ZONE_POLYGON_BASE
---@field SurfaceArea NOTYPE 
---@field _Triangles NOTYPE 
---@field private points table Points in 2D.
---@field private setGroups table Set of GROUPs.
---@field private setOpsGroups table Set of OPSGROUPS.
---@field private setUnits table Set of UNITs.
---@field private updateID number Scheduler ID for updating.
ZONE_ELASTIC = {}

---Add a set of groups.
---Positions of the group will be considered as polygon vertices when contructing the convex hull.
---
------
---@param self ZONE_ELASTIC 
---@param GroupSet SET_GROUP Set of groups.
---@return ZONE_ELASTIC #self
function ZONE_ELASTIC:AddSetGroup(GroupSet) end

---Add a vertex (point) to the polygon.
---
------
---@param self ZONE_ELASTIC 
---@param Vec2 Vec2 Point in 2D (with x and y coordinates).
---@return ZONE_ELASTIC #self
function ZONE_ELASTIC:AddVertex2D(Vec2) end

---Add a vertex (point) to the polygon.
---
------
---@param self ZONE_ELASTIC 
---@param Vec3 Vec3 Point in 3D (with x, y and z coordinates). Only the x and z coordinates are used.
---@return ZONE_ELASTIC #self
function ZONE_ELASTIC:AddVertex3D(Vec3) end

---Constructor to create a ZONE_ELASTIC instance.
---
------
---@param self ZONE_ELASTIC 
---@param ZoneName string Name of the zone.
---@param Points? Vec2 (Optional) Fixed points.
---@return ZONE_ELASTIC #self
function ZONE_ELASTIC:New(ZoneName, Points) end

---Remove a vertex (point) from the polygon.
---
------
---@param self ZONE_ELASTIC 
---@param Vec2 Vec2 Point in 2D (with x and y coordinates).
---@return ZONE_ELASTIC #self
function ZONE_ELASTIC:RemoveVertex2D(Vec2) end

---Remove a vertex (point) from the polygon.
---
------
---@param self ZONE_ELASTIC 
---@param Vec3 Vec3 Point in 3D (with x, y and z coordinates). Only the x and z coordinates are used.
---@return ZONE_ELASTIC #self
function ZONE_ELASTIC:RemoveVertex3D(Vec3) end

---Start the updating scheduler.
---
------
---@param self ZONE_ELASTIC 
---@param Tstart number Time in seconds before the updating starts.
---@param dT number Time interval in seconds between updates. Default 60 sec.
---@param Tstop number Time in seconds after which the updating stops. Default `nil`.
---@param Draw boolean Draw the zone. Default `nil`.
---@return ZONE_ELASTIC #self
function ZONE_ELASTIC:StartUpdate(Tstart, dT, Tstop, Draw) end

---Stop the updating scheduler.
---
------
---@param self ZONE_ELASTIC 
---@param Delay number Delay in seconds before the scheduler will be stopped. Default 0.
---@return ZONE_ELASTIC #self
function ZONE_ELASTIC:StopUpdate(Delay) end

---Update the convex hull of the polygon.
---This uses the [Graham scan](https://en.wikipedia.org/wiki/Graham_scan).
---
------
---@param self ZONE_ELASTIC 
---@param Delay number Delay in seconds before the zone is updated. Default 0.
---@param Draw boolean Draw the zone. Default `nil`.
---@return ZONE_ELASTIC #self
function ZONE_ELASTIC:Update(Delay, Draw) end

---Create a convex hull.
---
------
---@param self ZONE_ELASTIC 
---@param pl table Points
---@return table #Points
function ZONE_ELASTIC:_ConvexHull(pl) end


---The ZONE_GROUP class defines by a zone around a Wrapper.Group#GROUP with a radius.
---The current leader of the group defines the center of the zone.
---This class implements the inherited functions from #ZONE_RADIUS taking into account the own zone format and properties.
---@class ZONE_GROUP : ZONE_RADIUS
ZONE_GROUP = {}

---Returns a Core.Point#COORDINATE object reflecting a random 2D location within the zone.
---Note that this is actually a Core.Point#COORDINATE type object, and not a simple Vec2 table.
---
------
---@param self ZONE_GROUP 
---@param inner? number (optional) Minimal distance from the center of the zone. Default is 0.
---@param outer? number (optional) Maximal distance from the outer edge of the zone. Default is the radius of the zone.
---@return COORDINATE #The @{Core.Point#COORDINATE} object reflecting the random 3D location within the zone.
function ZONE_GROUP:GetRandomPointVec2(inner, outer) end

---Returns a random location within the zone of the Wrapper.Group.
---
------
---@param self ZONE_GROUP 
---@return Vec2 #The random location of the zone based on the @{Wrapper.Group} location.
function ZONE_GROUP:GetRandomVec2() end

---Returns the current location of the Wrapper.Group.
---
------
---@param self ZONE_GROUP 
---@return Vec2 #The location of the zone based on the @{Wrapper.Group} location.
function ZONE_GROUP:GetVec2() end

---Constructor to create a ZONE_GROUP instance, taking the zone name, a zone Wrapper.Group#GROUP and a radius.
---
------
---@param self ZONE_GROUP 
---@param ZoneName string Name of the zone.
---@param ZoneGROUP GROUP The @{Wrapper.Group} as the center of the zone.
---@param Radius Distance The radius of the zone.
---@return ZONE_GROUP #self
function ZONE_GROUP:New(ZoneName, ZoneGROUP, Radius) end


---## ZONE_OVAL class, extends #ZONE_BASE
---
---The ZONE_OVAL class is defined by a center point, major axis, minor axis, and angle.
---This class implements the inherited functions from #ZONE_BASE taking into account the own zone format and properties.
---ZONE_OVAL created from a center point, major axis, minor axis, and angle.
---Ported from https://github.com/nielsvaes/CCMOOSE/blob/master/Moose%20Development/Moose/Shapes/Oval.lua
---@class ZONE_OVAL : ZONE_BASE
---@field Angle NOTYPE 
---@field CenterVec2 table 
---@field DrawPoly NOTYPE 
---@field MajorAxis NOTYPE 
---@field MinorAxis NOTYPE 
---@field ZoneName NOTYPE 
ZONE_OVAL = {}

---Draw the zone on the F10 map.
---- ported from https://github.com/nielsvaes/CCMOOSE/blob/master/Moose%20Development/Moose/Shapes/Oval.lua
---
------
---@param self ZONE_OVAL 
---@param Coalition number Coalition: All=-1, Neutral=0, Red=1, Blue=2. Default -1=All.
---@param Color table RGB color table {r, g, b}, e.g. {1,0,0} for red.
---@param Alpha number Transparency [0,1]. Default 1.
---@param FillColor table RGB color table {r, g, b}, e.g. {1,0,0} for red. Default is same as `Color` value. -- doesn't seem to work
---@param FillAlpha number Transparency [0,1]. Default 0.15.                                                 -- doesn't seem to work
---@param LineType number Line type: 0=No line, 1=Solid, 2=Dashed, 3=Dotted, 4=Dot dash, 5=Long dash, 6=Two dash. Default 1=Solid.
---@param ReadOnly? boolean (Optional) Mark is readonly and cannot be removed by users. Default false.
---@return ZONE_OVAL #self
function ZONE_OVAL:DrawZone(Coalition, Color, Alpha, FillColor, FillAlpha, LineType, ReadOnly) end

---Gets the angle of the oval.
---
------
---@param self ZONE_OVAL 
---@return number #The angle of the oval
function ZONE_OVAL:GetAngle() end

---Calculates the bounding box of the oval.
---The bounding box is the smallest rectangle that contains the oval.
---
------
---@param self ZONE_OVAL 
---@return table #The bounding box of the oval
function ZONE_OVAL:GetBoundingSquare() end

---Gets the major axis of the oval.
---
------
---@param self ZONE_OVAL 
---@return number #The major axis of the oval
function ZONE_OVAL:GetMajorAxis() end

---Gets the minor axis of the oval.
---
------
---@param self ZONE_OVAL 
---@return number #The minor axis of the oval
function ZONE_OVAL:GetMinorAxis() end

---Define a random Core.Point#COORDINATE within the zone.
---Note that this is actually a Core.Point#COORDINATE type object, and not a simple Vec2 table.
---
------
---@param self ZONE_OVAL 
---@return COORDINATE #The COORDINATE coordinates.
function ZONE_OVAL:GetRandomPointVec2() end

---Define a random Core.Point#COORDINATE within the zone.
---Note that this is actually a Core.Point#COORDINATE type object, and not a simple Vec3 table.
---
------
---@param self ZONE_OVAL 
---@return COORDINATE #The COORDINATE coordinates.
function ZONE_OVAL:GetRandomPointVec3() end

---Returns a random Vec2 within the oval.
---
------
---@param self ZONE_OVAL 
---@return table #The random Vec2
function ZONE_OVAL:GetRandomVec2() end

---Returns a the center point of the oval
---
------
---@param self ZONE_OVAL 
---@return table #The center Vec2
function ZONE_OVAL:GetVec2() end

---Checks if a point is contained within the oval.
---
------
---@param self ZONE_OVAL 
---@param point table The point to check
---@param vec2 NOTYPE 
---@return boolean #True if the point is contained, false otherwise
function ZONE_OVAL:IsVec2InZone(point, vec2) end

---Creates a new ZONE_OVAL from a center point, major axis, minor axis, and angle.
---- ported from https://github.com/nielsvaes/CCMOOSE/blob/master/Moose%20Development/Moose/Shapes/Oval.lua
---
------
---@param self ZONE_OVAL 
---@param name string Name of the zone.
---@param vec2 table The center point of the oval
---@param major_axis number The major axis of the oval
---@param minor_axis number The minor axis of the oval
---@param angle number The angle of the oval
---@return ZONE_OVAL #The new oval
function ZONE_OVAL:New(name, vec2, major_axis, minor_axis, angle) end

---Constructor to create a ZONE_OVAL instance, taking the name of a drawing made with the draw tool in the Mission Editor.
---- ported from https://github.com/nielsvaes/CCMOOSE/blob/master/Moose%20Development/Moose/Shapes/Oval.lua
---
------
---@param self ZONE_OVAL 
---@param DrawingName string The name of the drawing in the Mission Editor
---@return ZONE_OVAL #self
function ZONE_OVAL:NewFromDrawing(DrawingName) end

---Find points on the edge of the oval
---
------
---@param self ZONE_OVAL 
---@param num_points number How many points should be found. More = smoother shape
---@return table #Points on he edge
function ZONE_OVAL:PointsOnEdge(num_points) end

---Remove drawing from F10 map
---
------
---@param self ZONE_OVAL 
function ZONE_OVAL:UndrawZone() end


---The ZONE_POLYGON class defined by a sequence of Wrapper.Group#GROUP waypoints within the Mission Editor, forming a polygon, OR by drawings made with the Draw tool
---- in the Mission Editor
---This class implements the inherited functions from #ZONE_RADIUS taking into account the own zone format and properties.
---
---## Declare a ZONE_POLYGON directly in the DCS mission editor!
---
---You can declare a ZONE_POLYGON using the DCS mission editor by adding the #ZONE_POLYGON tag in the group name.
---
---So, imagine you have a group declared in the mission editor, with group name `DefenseZone#ZONE_POLYGON`.
---Then during mission startup, when loading Moose.lua, this group will be detected as a ZONE_POLYGON declaration.
---Within the background, a ZONE_POLYGON object will be created within the Core.Database using the properties of the group.
---The ZONE_POLYGON name will be the group name without the #ZONE_POLYGON tag.
---
---So, you can search yourself for the ZONE_POLYGON by using the #ZONE_POLYGON.FindByName() method.
---In this example, `local PolygonZone = ZONE_POLYGON:FindByName( "DefenseZone" )` would return the ZONE_POLYGON object
---that was created at mission startup, and reference it into the `PolygonZone` local object.
---
---Mission `ZON-510` shows a demonstration of this feature or method.
---
---This is especially handy if you want to quickly setup a SET_ZONE...
---So when you would declare `local SetZone = SET_ZONE:New():FilterPrefixes( "Defense" ):FilterStart()`,
---then SetZone would contain the ZONE_POLYGON object `DefenseZone` as part of the zone collection,
---without much scripting overhead!
---
---This class now also supports drawings made with the Draw tool in the Mission Editor. Any drawing made with Line > Segments > Closed, Polygon > Rect or Polygon > Free can be
---made into a ZONE_POLYGON.
---
---This class has been updated to use a accurate way of generating random points inside the polygon without having to use trial and error guesses.
---You can also get the surface area of the polygon now, handy if you want measure which coalition has the largest captured area, for example.
---@class ZONE_POLYGON : ZONE_POLYGON_BASE
---@field ScanData table 
---@field ScanSetGroup SET_GROUP 
ZONE_POLYGON = {}

---Check if a certain coalition is inside a scanned zone.
---
------
---@param self ZONE_POLYGON 
---@param Coalition number The coalition id, e.g. coalition.side.BLUE.
---@return boolean #If true, the coalition is inside the zone.
function ZONE_POLYGON:CheckScannedCoalition(Coalition) end

---Count the number of different coalitions inside the zone.
---
------
---@param self ZONE_POLYGON 
---@return number #Counted coalitions.
function ZONE_POLYGON:CountScannedCoalitions() end

---Find a polygon zone in the _DATABASE using the name of the polygon zone.
---
------
---@param self ZONE_POLYGON 
---@param ZoneName string The name of the polygon zone.
---@return ZONE_POLYGON #self
function ZONE_POLYGON:FindByName(ZoneName) end

---Get Coalitions of the units in the Zone, or Check if there are units of the given Coalition in the Zone.
---Returns nil if there are none to two Coalitions in the zone!
---Returns one Coalition if there are only Units of one Coalition in the Zone.
---Returns the Coalition for the given Coalition if there are units of the Coalition in the Zone.
---
------
---@param self ZONE_POLYGON 
---@param Coalition NOTYPE 
---@return table #
function ZONE_POLYGON:GetScannedCoalition(Coalition) end

---Get scanned scenery table
---
------
---@param self ZONE_POLYGON 
---@return table #Structured table of [type].[name].Wrapper.Scenery#SCENERY scenery objects.
function ZONE_POLYGON:GetScannedScenery() end

---Get scanned scenery table
---
------
---@param self ZONE_POLYGON 
---@return table #Table of Wrapper.Scenery#SCENERY scenery objects.
function ZONE_POLYGON:GetScannedSceneryObjects() end

---Get scanned scenery types
---
------
---@param self ZONE_POLYGON 
---@param SceneryType NOTYPE 
---@return table #Table of DCS scenery type objects.
function ZONE_POLYGON:GetScannedSceneryType(SceneryType) end

---Get a set of scanned units.
---
------
---@param self ZONE_POLYGON 
---@return SET_GROUP #Set of groups.
function ZONE_POLYGON:GetScannedSetGroup() end

---Get scanned set of scenery objects
---
------
---@param self ZONE_POLYGON 
---@return table #Table of Wrapper.Scenery#SCENERY scenery objects.
function ZONE_POLYGON:GetScannedSetScenery() end

---Get a set of scanned units.
---
------
---@param self ZONE_POLYGON 
---@return SET_UNIT #Set of units and statics inside the zone.
function ZONE_POLYGON:GetScannedSetUnit() end

---Count the number of different coalitions inside the zone.
---
------
---@param self ZONE_POLYGON 
---@return table #Table of DCS units and DCS statics inside the zone.
function ZONE_POLYGON:GetScannedUnits() end

---Is All in Zone of Coalition?
---Check if only the specified coalition is inside the zone and noone else.
---
------
---
---USAGE
---```
---   self.Zone:Scan()
---   local IsGuarded = self.Zone:IsAllInZoneOfCoalition( self.Coalition )
---```
------
---@param self ZONE_POLYGON 
---@param Coalition number Coalition ID of the coalition which is checked to be the only one in the zone.
---@return boolean #True, if **only** that coalition is inside the zone and no one else.
function ZONE_POLYGON:IsAllInZoneOfCoalition(Coalition) end

---Is All in Zone of Other Coalition?
---Check if only one coalition is inside the zone and the specified coalition is not the one.
---You first need to use the #ZONE_POLYGON.Scan method to scan the zone before it can be evaluated!
---Note that once a zone has been scanned, multiple evaluations can be done on the scan result set.
---
------
---
---USAGE
---```
---   self.Zone:Scan()
---   local IsCaptured = self.Zone:IsAllInZoneOfOtherCoalition( self.Coalition )
---```
------
---@param self ZONE_POLYGON 
---@param Coalition number Coalition ID of the coalition which is not supposed to be in the zone.
---@return boolean #True, if and only if only one coalition is inside the zone and the specified coalition is not it.
function ZONE_POLYGON:IsAllInZoneOfOtherCoalition(Coalition) end

---Is None in Zone?
---You first need to use the #ZONE_POLYGON.Scan method to scan the zone before it can be evaluated!
---Note that once a zone has been scanned, multiple evaluations can be done on the scan result set.
---
------
---
---USAGE
---```
---   self.Zone:Scan()
---   local IsEmpty = self.Zone:IsNoneInZone()
---```
------
---@param self ZONE_POLYGON 
---@return boolean #
function ZONE_POLYGON:IsNoneInZone() end

---Is None in Zone of Coalition?
---You first need to use the #ZONE_POLYGON.Scan method to scan the zone before it can be evaluated!
---Note that once a zone has been scanned, multiple evaluations can be done on the scan result set.
---
------
---
---USAGE
---```
---   self.Zone:Scan()
---   local IsOccupied = self.Zone:IsNoneInZoneOfCoalition( self.Coalition )
---```
------
---@param self ZONE_POLYGON 
---@param Coalition NOTYPE 
---@return boolean #
function ZONE_POLYGON:IsNoneInZoneOfCoalition(Coalition) end

---Is Some in Zone of Coalition?
---Check if more than one coalition is inside the zone and the specified coalition is one of them.
---You first need to use the #ZONE_POLYGON.Scan method to scan the zone before it can be evaluated!
---Note that once a zone has been scanned, multiple evaluations can be done on the scan result set.
---
------
---
---USAGE
---```
---   self.Zone:Scan()
---   local IsAttacked = self.Zone:IsSomeInZoneOfCoalition( self.Coalition )
---```
------
---@param self ZONE_POLYGON 
---@param Coalition number ID of the coalition which is checked to be inside the zone.
---@return boolean #True if more than one coalition is inside the zone and the specified coalition is one of them.
function ZONE_POLYGON:IsSomeInZoneOfCoalition(Coalition) end

---Constructor to create a ZONE_POLYGON instance, taking the zone name and the Wrapper.Group#GROUP defined within the Mission Editor.
---The Wrapper.Group#GROUP waypoints define the polygon corners. The first and the last point are automatically connected by ZONE_POLYGON.
---
------
---@param self ZONE_POLYGON 
---@param ZoneName string Name of the zone.
---@param ZoneGroup GROUP The GROUP waypoints as defined within the Mission Editor define the polygon shape.
---@return ZONE_POLYGON #self
function ZONE_POLYGON:New(ZoneName, ZoneGroup) end

---Constructor to create a ZONE_POLYGON instance, taking the name of a drawing made with the draw tool in the Mission Editor.
---
------
---@param self ZONE_POLYGON 
---@param DrawingName string The name of the drawing in the Mission Editor
---@return ZONE_POLYGON #self
function ZONE_POLYGON:NewFromDrawing(DrawingName) end

---Constructor to create a ZONE_POLYGON instance, taking the zone name and the **name** of the Wrapper.Group#GROUP defined within the Mission Editor.
---The Wrapper.Group#GROUP waypoints define the polygon corners. The first and the last point are automatically connected by ZONE_POLYGON.
---
------
---@param self ZONE_POLYGON 
---@param GroupName string The group name of the GROUP defining the waypoints within the Mission Editor to define the polygon shape.
---@return ZONE_POLYGON #self
function ZONE_POLYGON:NewFromGroupName(GroupName) end

---Constructor to create a ZONE_POLYGON instance, taking the zone name and an array of DCS#Vec2, forming a polygon.
---
------
---@param self ZONE_POLYGON 
---@param ZoneName string Name of the zone.
---@param PointsArray ZONE_POLYGON_BASE.ListVec2 An array of @{DCS#Vec2}, forming a polygon.
---@return ZONE_POLYGON #self
function ZONE_POLYGON:NewFromPointsArray(ZoneName, PointsArray) end

---Scan the zone for the presence of units of the given ObjectCategories.
---Does **not** scan for scenery at the moment.
---Note that **only after** a zone has been scanned, the zone can be evaluated by:
---
---  * Core.Zone#ZONE_POLYGON.IsAllInZoneOfCoalition(): Scan the presence of units in the zone of a coalition.
---  * Core.Zone#ZONE_POLYGON.IsAllInZoneOfOtherCoalition(): Scan the presence of units in the zone of an other coalition.
---  * Core.Zone#ZONE_POLYGON.IsSomeInZoneOfCoalition(): Scan if there is some presence of units in the zone of the given coalition.
---  * Core.Zone#ZONE_POLYGON.IsNoneInZoneOfCoalition(): Scan if there isn't any presence of units in the zone of an other coalition than the given one.
---  * Core.Zone#ZONE_POLYGON.IsNoneInZone(): Scan if the zone is empty.
---
------
---
---USAGE
---```
---   myzone:Scan({Object.Category.UNIT},{Unit.Category.GROUND_UNIT})
---   local IsAttacked = myzone:IsSomeInZoneOfCoalition( self.Coalition )
---```
------
---@param self ZONE_POLYGON 
---@param ObjectCategories NOTYPE An array of categories of the objects to find in the zone. E.g. `{Object.Category.UNIT}`
---@param UnitCategories NOTYPE An array of unit categories of the objects to find in the zone. E.g. `{Unit.Category.GROUND_UNIT,Unit.Category.SHIP}`
function ZONE_POLYGON:Scan(ObjectCategories, UnitCategories) end


---The ZONE_POLYGON_BASE class defined by a sequence of Wrapper.Group#GROUP waypoints within the Mission Editor, forming a polygon.
---This class implements the inherited functions from #ZONE_RADIUS taking into account the own zone format and properties.
---This class is an abstract BASE class for derived classes, and is not meant to be instantiated.
---
---## Zone point randomization
---
---Various functions exist to find random points within the zone.
---
---  * #ZONE_POLYGON_BASE.GetRandomVec2(): Gets a random 2D point in the zone.
---  * #ZONE_POLYGON_BASE.GetRandomPointVec2(): Return a Core.Point#COORDINATE object representing a random 2D point within the zone.
---  * #ZONE_POLYGON_BASE.GetRandomPointVec3(): Return a Core.Point#COORDINATE object representing a random 3D point at landheight within the zone.
---
---## Draw zone
---
---  * #ZONE_POLYGON_BASE.DrawZone(): Draws the zone on the F10 map.
---  * #ZONE_POLYGON_BASE.Boundary(): Draw a frontier on the F10 map with small filled circles.
---@class ZONE_POLYGON_BASE : ZONE_BASE
---@field Borderlines table 
---@field DrawID table 
---@field FillTriangles table 
---@field Polygon ZONE_POLYGON_BASE.ListVec2 The polygon defined by an array of @{DCS#Vec2}.
---@field SurfaceArea number 
---@field _Triangles table 
ZONE_POLYGON_BASE = {}

---Smokes the zone boundaries in a color.
---
------
---@param self ZONE_POLYGON_BASE 
---@param UnBound boolean If true, the tyres will be destroyed.
---@return ZONE_POLYGON_BASE #self
function ZONE_POLYGON_BASE:BoundZone(UnBound) end

---Draw a frontier on the F10 map with small filled circles.
---
------
---@param self ZONE_POLYGON_BASE 
---@param Coalition? number (Optional) Coalition: All=-1, Neutral=0, Red=1, Blue=2. Default -1= All.
---@param Color? table (Optional) RGB color table {r, g, b}, e.g. {1, 0, 0} for red. Default {1, 1, 1}= White.
---@param Radius? number (Optional) Radius of the circles in meters. Default 1000.
---@param Alpha? number (Optional) Alpha transparency [0,1]. Default 1.
---@param Segments? number (Optional) Number of segments within boundary line. Default 10.
---@param Closed? boolean (Optional) Link the last point with the first one to obtain a closed boundary. Default false
---@return ZONE_POLYGON_BASE #self
function ZONE_POLYGON_BASE:Boundary(Coalition, Color, Radius, Alpha, Segments, Closed) end

---Draw the zone on the F10 map.
--- Infinite number of points supported
---- ported from https://github.com/nielsvaes/CCMOOSE/blob/master/Moose%20Development/Moose/Shapes/Polygon.lua
---
------
---@param self ZONE_POLYGON_BASE 
---@param Coalition number Coalition: All=-1, Neutral=0, Red=1, Blue=2. Default -1=All.
---@param Color table RGB color table {r, g, b}, e.g. {1,0,0} for red.
---@param Alpha number Transparency [0,1]. Default 1.
---@param FillColor table RGB color table {r, g, b}, e.g. {1,0,0} for red. Default is same as `Color` value. -- doesn't seem to work
---@param FillAlpha number Transparency [0,1]. Default 0.15.                                                 -- doesn't seem to work
---@param LineType number Line type: 0=No line, 1=Solid, 2=Dashed, 3=Dotted, 4=Dot dash, 5=Long dash, 6=Two dash. Default 1=Solid.
---@param ReadOnly? boolean (Optional) Mark is readonly and cannot be removed by users. Default false.s
---@param IncludeTriangles NOTYPE 
---@return ZONE_POLYGON_BASE #self
function ZONE_POLYGON_BASE:DrawZone(Coalition, Color, Alpha, FillColor, FillAlpha, LineType, ReadOnly, IncludeTriangles) end

---Flare the zone boundaries in a color.
---
------
---@param self ZONE_POLYGON_BASE 
---@param FlareColor FLARECOLOR The flare color.
---@param Segments? number (Optional) Number of segments within boundary line. Default 10.
---@param Azimuth? Azimuth (optional) Azimuth The azimuth of the flare.
---@param AddHeight? number (optional) The height to be added for the smoke.
---@return ZONE_POLYGON_BASE #self
function ZONE_POLYGON_BASE:FlareZone(FlareColor, Segments, Azimuth, AddHeight) end

---Flush polygon coordinates as a table in DCS.log.
---
------
---@param self ZONE_POLYGON_BASE 
---@return ZONE_POLYGON_BASE #self
function ZONE_POLYGON_BASE:Flush() end

---Get the bounding square the zone.
---
------
---@param self ZONE_POLYGON_BASE 
---@return ZONE_POLYGON_BASE.BoundingSquare #The bounding square.
function ZONE_POLYGON_BASE:GetBoundingSquare() end

---Get the bounding 2D vectors of the polygon.
---
------
---@param self ZONE_POLYGON_BASE 
---@return Vec2 #Coordinates of western-southern-lower vertex of the box.
---@return Vec2 #Coordinates of eastern-northern-upper vertex of the box.
function ZONE_POLYGON_BASE:GetBoundingVec2() end

---Get the smallest radius encompassing all points of the polygon zone.
---
------
---@param self ZONE_POLYGON_BASE 
---@return number #Radius of the zone in meters.
function ZONE_POLYGON_BASE:GetRadius() end

---Return a Core.Point#COORDINATE object representing a random 3D point at landheight within the zone.
---
------
---@param self ZONE_POLYGON_BASE 
---@return COORDINATE #
function ZONE_POLYGON_BASE:GetRandomCoordinate() end

---Return a Core.Point#COORDINATE object representing a random 2D point at landheight within the zone.
---Note that this is actually a Core.Point#COORDINATE type object, and not a simple Vec2 table.
---
------
---@param self ZONE_POLYGON_BASE 
---@return  #@{Core.Point#COORDINATE}
function ZONE_POLYGON_BASE:GetRandomPointVec2() end

---Return a Core.Point#COORDINATE object representing a random 3D point at landheight within the zone.
---Note that this is actually a Core.Point#COORDINATE type object, and not a simple Vec3 table.
---
------
---@param self ZONE_POLYGON_BASE 
---@return  #@{Core.Point#COORDINATE}
function ZONE_POLYGON_BASE:GetRandomPointVec3() end

---Define a random DCS#Vec2 within the zone.
---- ported from https://github.com/nielsvaes/CCMOOSE/blob/master/Moose%20Development/Moose/Shapes/Polygon.lua
---
------
---@param self ZONE_POLYGON_BASE 
---@return Vec2 #The Vec2 coordinate.
function ZONE_POLYGON_BASE:GetRandomVec2() end

---Get the surface area of this polygon
---
------
---@param self ZONE_POLYGON_BASE 
---@return number #Surface area
function ZONE_POLYGON_BASE:GetSurfaceArea() end

---Returns the center location of the polygon.
---
------
---@param self ZONE_POLYGON_BASE 
---@return Vec2 #The location of the zone based on the @{Wrapper.Group} location.
function ZONE_POLYGON_BASE:GetVec2() end

---Get a vertex of the polygon.
---
------
---@param self ZONE_POLYGON_BASE 
---@param Index number Index of the vertex. Default 1.
---@return COORDINATE #Vertex of the polygon.
function ZONE_POLYGON_BASE:GetVertexCoordinate(Index) end

---Get a vertex of the polygon.
---
------
---@param self ZONE_POLYGON_BASE 
---@param Index number Index of the vertex. Default 1.
---@return Vec2 #Vertex of the polygon.
function ZONE_POLYGON_BASE:GetVertexVec2(Index) end

---Get a vertex of the polygon.
---
------
---@param self ZONE_POLYGON_BASE 
---@param Index number Index of the vertex. Default 1.
---@return Vec3 #Vertex of the polygon.
function ZONE_POLYGON_BASE:GetVertexVec3(Index) end

---Get a list of verticies of the polygon.
---
------
---@param self ZONE_POLYGON_BASE 
---@return table #List of COORDINATES verticies defining the edges of the polygon.
function ZONE_POLYGON_BASE:GetVerticiesCoordinates() end

---Get a list of verticies of the polygon.
---
------
---@param self ZONE_POLYGON_BASE 
---@return  #<DCS#Vec2> List of DCS#Vec2 verticies defining the edges of the polygon.
function ZONE_POLYGON_BASE:GetVerticiesVec2() end

---Get a list of verticies of the polygon.
---
------
---@param self ZONE_POLYGON_BASE 
---@return table #List of DCS#Vec3 verticies defining the edges of the polygon.
function ZONE_POLYGON_BASE:GetVerticiesVec3() end

---Get the smallest rectangular zone encompassing all points points of the polygon zone.
---
------
---@param self ZONE_POLYGON_BASE 
---@param ZoneName? string (Optional) Name of the zone. Default is the name of the polygon zone.
---@param DoNotRegisterZone? boolean (Optional) If `true`, zone is not registered.
---@return ZONE_POLYGON #The rectangular zone.
function ZONE_POLYGON_BASE:GetZoneQuad(ZoneName, DoNotRegisterZone) end

---Get the smallest circular zone encompassing all points of the polygon zone.
---
------
---@param self ZONE_POLYGON_BASE 
---@param ZoneName? string (Optional) Name of the zone. Default is the name of the polygon zone.
---@param DoNotRegisterZone? boolean (Optional) If `true`, zone is not registered.
---@return ZONE_RADIUS #The circular zone.
function ZONE_POLYGON_BASE:GetZoneRadius(ZoneName, DoNotRegisterZone) end

---Returns if a location is within the zone.
---Source learned and taken from: https://www.ecse.rpi.edu/Homepages/wrf/Research/Short_Notes/pnpoly.html
---
------
---@param self ZONE_POLYGON_BASE 
---@param Vec2 Vec2 The location to test.
---@return boolean #true if the location is within the zone.
function ZONE_POLYGON_BASE:IsVec2InZone(Vec2) end

---Returns if a point is within the zone.
---
------
---@param self ZONE_POLYGON_BASE 
---@param Vec3 Vec3 The point to test.
---@return boolean #true if the point is within the zone.
function ZONE_POLYGON_BASE:IsVec3InZone(Vec3) end

---Constructor to create a ZONE_POLYGON_BASE instance, taking the zone name and an array of DCS#Vec2, forming a polygon.
---The Wrapper.Group#GROUP waypoints define the polygon corners. The first and the last point are automatically connected.
---
------
---@param self ZONE_POLYGON_BASE 
---@param ZoneName string Name of the zone.
---@param PointsArray ZONE_POLYGON_BASE.ListVec2 An array of @{DCS#Vec2}, forming a polygon.
---@return ZONE_POLYGON_BASE #self
function ZONE_POLYGON_BASE:New(ZoneName, PointsArray) end

---Change/Re-draw the border of a Polygon Zone
---
------
---@param self ZONE_POLYGON_BASE 
---@param Color table RGB color table {r, g, b}, e.g. {1,0,0} for red.
---@param Alpha number Transparency [0,1]. Default 1.
---@param LineType number Line type: 0=No line, 1=Solid, 2=Dashed, 3=Dotted, 4=Dot dash, 5=Long dash, 6=Two dash. Default 1=Solid.
---@return ZONE_POLYGON_BASE #
function ZONE_POLYGON_BASE:ReDrawBorderline(Color, Alpha, LineType) end

---Change/Re-fill a Polygon Zone
---
------
---@param self ZONE_POLYGON_BASE 
---@param Color table RGB color table {r, g, b}, e.g. {1,0,0} for red.
---@param Alpha number Transparency [0,1]. Default 1.
---@return ZONE_POLYGON_BASE #self
function ZONE_POLYGON_BASE:ReFill(Color, Alpha) end

---Remove junk inside the zone.
---Due to DCS limitations, this works only for rectangular zones. So we get the smallest rectangular zone encompassing all points points of the polygon zone.
---
------
---@param self ZONE_POLYGON_BASE 
---@param Height number Height of the box in meters. Default 1000.
---@return number #Number of removed objects.
function ZONE_POLYGON_BASE:RemoveJunk(Height) end

---Smokes the zone boundaries in a color.
---
------
---@param self ZONE_POLYGON_BASE 
---@param SmokeColor SMOKECOLOR The smoke color.
---@param Segments? number (Optional) Number of segments within boundary line. Default 10.
---@return ZONE_POLYGON_BASE #self
function ZONE_POLYGON_BASE:SmokeZone(SmokeColor, Segments) end

---Update polygon points with an array of DCS#Vec2.
---
------
---@param self ZONE_POLYGON_BASE 
---@param Vec2Array ZONE_POLYGON_BASE.ListVec2 An array of @{DCS#Vec2}, forming a polygon.
---@return ZONE_POLYGON_BASE #self
function ZONE_POLYGON_BASE:UpdateFromVec2(Vec2Array) end

---Update polygon points with an array of DCS#Vec3.
---
------
---@param self ZONE_POLYGON_BASE 
---@param Vec2Array ZONE_POLYGON_BASE.ListVec3 An array of @{DCS#Vec3}, forming a polygon.
---@param Vec3Array NOTYPE 
---@return ZONE_POLYGON_BASE #self
function ZONE_POLYGON_BASE:UpdateFromVec3(Vec2Array, Vec3Array) end

---Calculates the surface area of the polygon.
---The surface area is the sum of the areas of the triangles that make up the polygon.
---- ported from https://github.com/nielsvaes/CCMOOSE/blob/master/Moose%20Development/Moose/Shapes/Polygon.lua
---
------
---@param self ZONE_POLYGON_BASE 
---@return number #The surface area of the polygon
function ZONE_POLYGON_BASE:_CalculateSurfaceArea() end

---Triangulates the polygon.
---- ported from https://github.com/nielsvaes/CCMOOSE/blob/master/Moose%20Development/Moose/Shapes/Polygon.lua
---
------
---@param self ZONE_POLYGON_BASE 
---@return table #The #_ZONE_TRIANGLE list that makes up the polygon
function ZONE_POLYGON_BASE:_Triangulate() end


---The ZONE_RADIUS class defined by a zone name, a location and a radius.
---This class implements the inherited functions from #ZONE_BASE taking into account the own zone format and properties.
---
---## ZONE_RADIUS constructor
---
---  * #ZONE_RADIUS.New(): Constructor.
---
---## Manage the radius of the zone
---
---  * #ZONE_RADIUS.SetRadius(): Sets the radius of the zone.
---  * #ZONE_RADIUS.GetRadius(): Returns the radius of the zone.
---
---## Manage the location of the zone
---
---  * #ZONE_RADIUS.SetVec2(): Sets the DCS#Vec2 of the zone.
---  * #ZONE_RADIUS.GetVec2(): Returns the DCS#Vec2 of the zone.
---  * #ZONE_RADIUS.GetVec3(): Returns the DCS#Vec3 of the zone, taking an additional height parameter.
---
---## Zone point randomization
---
---Various functions exist to find random points within the zone.
---
---  * #ZONE_RADIUS.GetRandomVec2(): Gets a random 2D point in the zone.
---  * #ZONE_RADIUS.GetRandomPointVec2(): Gets a Core.Point#COORDINATE object representing a random 2D point in the zone.
---  * #ZONE_RADIUS.GetRandomPointVec3(): Gets a Core.Point#COORDINATE object representing a random 3D point in the zone. Note that the height of the point is at landheight.
---
---## Draw zone
---
---  * #ZONE_RADIUS.DrawZone(): Draws the zone on the F10 map.
---The ZONE_RADIUS class, defined by a zone name, a location and a radius.
---@class ZONE_RADIUS : ZONE_BASE
---@field DrawID NOTYPE 
---@field Radius Distance The radius of the zone.
---@field ScanData table 
---@field ScanSetGroup SET_GROUP 
---@field Vec2 Vec2 The current location of the zone.
ZONE_RADIUS = {}

---Bounds the zone with tires.
---
------
---@param self ZONE_RADIUS 
---@param Points? number (optional) The amount of points in the circle. Default 360.
---@param CountryID country.id The country id of the tire objects, e.g. country.id.USA for blue or country.id.RUSSIA for red.
---@param UnBound? boolean (Optional) If true the tyres will be destroyed.
---@return ZONE_RADIUS #self
function ZONE_RADIUS:BoundZone(Points, CountryID, UnBound) end

---Check if a certain coalition is inside a scanned zone.
---
------
---@param self ZONE_RADIUS 
---@param Coalition number The coalition id, e.g. coalition.side.BLUE.
---@return boolean #If true, the coalition is inside the zone.
function ZONE_RADIUS:CheckScannedCoalition(Coalition) end

---Count the number of different coalitions inside the zone.
---
------
---@param self ZONE_RADIUS 
---@return number #Counted coalitions.
function ZONE_RADIUS:CountScannedCoalitions() end

---Draw the zone circle on the F10 map.
---
------
---@param self ZONE_RADIUS 
---@param Coalition number Coalition: All=-1, Neutral=0, Red=1, Blue=2. Default -1=All.
---@param Color table RGB color table {r, g, b}, e.g. {1,0,0} for red.
---@param Alpha number Transparency [0,1]. Default 1.
---@param FillColor table RGB color table {r, g, b}, e.g. {1,0,0} for red. Default is same as `Color` value.
---@param FillAlpha number Transparency [0,1]. Default 0.15.
---@param LineType number Line type: 0=No line, 1=Solid, 2=Dashed, 3=Dotted, 4=Dot dash, 5=Long dash, 6=Two dash. Default 1=Solid.
---@param ReadOnly? boolean (Optional) Mark is readonly and cannot be removed by users. Default false.
---@return ZONE_RADIUS #self
function ZONE_RADIUS:DrawZone(Coalition, Color, Alpha, FillColor, FillAlpha, LineType, ReadOnly) end

---Flares the zone boundaries in a color.
---
------
---@param self ZONE_RADIUS 
---@param FlareColor FLARECOLOR The flare color.
---@param Points? number (optional) The amount of points in the circle.
---@param Azimuth? Azimuth (optional) Azimuth The azimuth of the flare.
---@param AddHeight? number (optional) The height to be added for the smoke.
---@return ZONE_RADIUS #self
function ZONE_RADIUS:FlareZone(FlareColor, Points, Azimuth, AddHeight) end

---Returns the radius of the zone.
---
------
---@param self ZONE_RADIUS 
---@return Distance #The radius of the zone.
function ZONE_RADIUS:GetRadius() end

---Returns a Core.Point#COORDINATE object reflecting a random 3D location within the zone.
---
------
---@param self ZONE_RADIUS 
---@param inner? number (Optional) Minimal distance from the center of the zone in meters. Default is 0 m.
---@param outer? number (Optional) Maximal distance from the outer edge of the zone in meters. Default is the radius of the zone.
---@param surfacetypes? table (Optional) Table of surface types. Can also be a single surface type. We will try max 100 times to find the right type!
---@return COORDINATE #The random coordinate.
function ZONE_RADIUS:GetRandomCoordinate(inner, outer, surfacetypes) end

---Returns a Core.Point#COORDINATE object reflecting a random location within the zone where there are no **map objects** of type "Building".
---Does not find statics you might have placed there. **Note** This might be quite CPU intensive, use with care.
---
------
---@param self ZONE_RADIUS 
---@param inner? number (Optional) Minimal distance from the center of the zone in meters. Default is 0m.
---@param outer? number (Optional) Maximal distance from the outer edge of the zone in meters. Default is the radius of the zone.
---@param distance? number (Optional) Minimum distance from any building coordinate. Defaults to 100m.
---@param markbuildings? boolean (Optional) Place markers on found buildings (if any).
---@param markfinal? boolean (Optional) Place marker on the final coordinate (if any).
---@return COORDINATE #The random coordinate or `nil` if cannot be found in 1000 iterations.
function ZONE_RADIUS:GetRandomCoordinateWithoutBuildings(inner, outer, distance, markbuildings, markfinal) end

---Returns a Core.Point#COORDINATE object reflecting a random 2D location within the zone.
---Note that this is actually a Core.Point#COORDINATE type object, and not a simple Vec2 table.
---
------
---@param self ZONE_RADIUS 
---@param inner? number (optional) Minimal distance from the center of the zone. Default is 0.
---@param outer? number (optional) Maximal distance from the outer edge of the zone. Default is the radius of the zone.
---@return COORDINATE #The @{Core.Point#COORDINATE} object reflecting the random 3D location within the zone.
function ZONE_RADIUS:GetRandomPointVec2(inner, outer) end

---Returns a Core.Point#COORDINATE object reflecting a random 3D location within the zone.
---Note that this is actually a Core.Point#COORDINATE type object, and not a simple Vec3 table.
---
------
---@param self ZONE_RADIUS 
---@param inner? number (optional) Minimal distance from the center of the zone. Default is 0.
---@param outer? number (optional) Maximal distance from the outer edge of the zone. Default is the radius of the zone.
---@return COORDINATE #The @{Core.Point#COORDINATE} object reflecting the random 3D location within the zone.
function ZONE_RADIUS:GetRandomPointVec3(inner, outer) end

---Returns a random Vec2 location within the zone.
---
------
---@param self ZONE_RADIUS 
---@param inner? number (Optional) Minimal distance from the center of the zone. Default is 0.
---@param outer? number (Optional) Maximal distance from the outer edge of the zone. Default is the radius of the zone.
---@param surfacetypes? table (Optional) Table of surface types. Can also be a single surface type. We will try max 100 times to find the right type!
---@return Vec2 #The random location within the zone.
function ZONE_RADIUS:GetRandomVec2(inner, outer, surfacetypes) end

---Returns Returns a random Vec3 location within the zone.
---
------
---@param self ZONE_RADIUS 
---@param inner? number (optional) Minimal distance from the center of the zone. Default is 0.
---@param outer? number (optional) Maximal distance from the outer edge of the zone. Default is the radius of the zone.
---@return Vec3 #The random location within the zone.
function ZONE_RADIUS:GetRandomVec3(inner, outer) end

---Get Coalitions of the units in the Zone, or Check if there are units of the given Coalition in the Zone.
---Returns nil if there are none to two Coalitions in the zone!
---Returns one Coalition if there are only Units of one Coalition in the Zone.
---Returns the Coalition for the given Coalition if there are units of the Coalition in the Zone.
---
------
---@param self ZONE_RADIUS 
---@param Coalition NOTYPE 
---@return table #
function ZONE_RADIUS:GetScannedCoalition(Coalition) end

---Get scanned scenery table
---
------
---@param self ZONE_RADIUS 
---@return table #Structured object table: [type].[name].SCENERY
function ZONE_RADIUS:GetScannedScenery() end

---Get table of scanned scenery objects
---
------
---@param self ZONE_RADIUS 
---@return table #Table of SCENERY objects.
function ZONE_RADIUS:GetScannedSceneryObjects() end

---Get scanned scenery type
---
------
---@param self ZONE_RADIUS 
---@param SceneryType NOTYPE 
---@return table #Table of DCS scenery type objects.
function ZONE_RADIUS:GetScannedSceneryType(SceneryType) end

---Get a set of scanned groups.
---
------
---@param self ZONE_RADIUS 
---@return SET_GROUP #Set of groups.
function ZONE_RADIUS:GetScannedSetGroup() end

---Get set of scanned scenery objects
---
------
---@param self ZONE_RADIUS 
---@return table #Table of Wrapper.Scenery#SCENERY scenery objects.
function ZONE_RADIUS:GetScannedSetScenery() end

---Get a set of scanned units.
---
------
---@param self ZONE_RADIUS 
---@return SET_UNIT #Set of units and statics inside the zone.
function ZONE_RADIUS:GetScannedSetUnit() end

---Get a table  of scanned units.
---
------
---@param self ZONE_RADIUS 
---@return table #Table of DCS units and DCS statics inside the zone.
function ZONE_RADIUS:GetScannedUnits() end

---Returns the DCS#Vec2 of the zone.
---
------
---@param self ZONE_RADIUS 
---@return Vec2 #The location of the zone.
function ZONE_RADIUS:GetVec2() end

---Returns the DCS#Vec3 of the ZONE_RADIUS.
---
------
---@param self ZONE_RADIUS 
---@param Height Distance The height to add to the land height where the center of the zone is located.
---@return Vec3 #The point of the zone.
function ZONE_RADIUS:GetVec3(Height) end

---Is All in Zone of Coalition?
---Check if only the specified coalition is inside the zone and no one else.
---
------
---
---USAGE
---```
---   self.Zone:Scan()
---   local IsGuarded = self.Zone:IsAllInZoneOfCoalition( self.Coalition )
---```
------
---@param self ZONE_RADIUS 
---@param Coalition number Coalition ID of the coalition which is checked to be the only one in the zone.
---@return boolean #True, if **only** that coalition is inside the zone and no one else.
function ZONE_RADIUS:IsAllInZoneOfCoalition(Coalition) end

---Is All in Zone of Other Coalition?
---Check if only one coalition is inside the zone and the specified coalition is not the one.
---You first need to use the #ZONE_RADIUS.Scan method to scan the zone before it can be evaluated!
---Note that once a zone has been scanned, multiple evaluations can be done on the scan result set.
---
------
---
---USAGE
---```
---   self.Zone:Scan()
---   local IsCaptured = self.Zone:IsAllInZoneOfOtherCoalition( self.Coalition )
---```
------
---@param self ZONE_RADIUS 
---@param Coalition number Coalition ID of the coalition which is not supposed to be in the zone.
---@return boolean #True, if and only if only one coalition is inside the zone and the specified coalition is not it.
function ZONE_RADIUS:IsAllInZoneOfOtherCoalition(Coalition) end

---Is None in Zone?
---You first need to use the #ZONE_RADIUS.Scan method to scan the zone before it can be evaluated!
---Note that once a zone has been scanned, multiple evaluations can be done on the scan result set.
---
------
---
---USAGE
---```
---   self.Zone:Scan()
---   local IsEmpty = self.Zone:IsNoneInZone()
---```
------
---@param self ZONE_RADIUS 
---@return boolean #
function ZONE_RADIUS:IsNoneInZone() end

---Is None in Zone of Coalition?
---You first need to use the #ZONE_RADIUS.Scan method to scan the zone before it can be evaluated!
---Note that once a zone has been scanned, multiple evaluations can be done on the scan result set.
---
------
---
---USAGE
---```
---   self.Zone:Scan()
---   local IsOccupied = self.Zone:IsNoneInZoneOfCoalition( self.Coalition )
---```
------
---@param self ZONE_RADIUS 
---@param Coalition NOTYPE 
---@return boolean #
function ZONE_RADIUS:IsNoneInZoneOfCoalition(Coalition) end

---Is Some in Zone of Coalition?
---Check if more than one coalition is inside the zone and the specified coalition is one of them.
---You first need to use the #ZONE_RADIUS.Scan method to scan the zone before it can be evaluated!
---Note that once a zone has been scanned, multiple evaluations can be done on the scan result set.
---
------
---
---USAGE
---```
---   self.Zone:Scan()
---   local IsAttacked = self.Zone:IsSomeInZoneOfCoalition( self.Coalition )
---```
------
---@param self ZONE_RADIUS 
---@param Coalition number ID of the coalition which is checked to be inside the zone.
---@return boolean #True if more than one coalition is inside the zone and the specified coalition is one of them.
function ZONE_RADIUS:IsSomeInZoneOfCoalition(Coalition) end

---Returns if a location is within the zone.
---
------
---@param self ZONE_RADIUS 
---@param Vec2 Vec2 The location to test.
---@return boolean #true if the location is within the zone.
function ZONE_RADIUS:IsVec2InZone(Vec2) end

---Returns if a point is within the zone.
---
------
---@param self ZONE_RADIUS 
---@param Vec3 Vec3 The point to test.
---@return boolean #true if the point is within the zone.
function ZONE_RADIUS:IsVec3InZone(Vec3) end

---Mark the zone with markers on the F10 map.
---
------
---@param self ZONE_RADIUS 
---@param Points? number (Optional) The amount of points in the circle. Default 360.
---@return ZONE_RADIUS #self
function ZONE_RADIUS:MarkZone(Points) end

---Constructor of #ZONE_RADIUS, taking the zone name, the zone location and a radius.
---
------
---@param self ZONE_RADIUS 
---@param ZoneName string Name of the zone.
---@param Vec2 Vec2 The location of the zone.
---@param Radius Distance The radius of the zone.
---@param DoNotRegisterZone Boolean Determines if the Zone should not be registered in the _Database Table. Default=false
---@return ZONE_RADIUS #self
function ZONE_RADIUS:New(ZoneName, Vec2, Radius, DoNotRegisterZone) end

---Remove junk inside the zone using the `world.removeJunk` function.
---
------
---@param self ZONE_RADIUS 
---@return number #Number of deleted objects.
function ZONE_RADIUS:RemoveJunk() end

---Scan the zone for the presence of units of the given ObjectCategories.
---Note that **only after** a zone has been scanned, the zone can be evaluated by:
---
---  * Core.Zone#ZONE_RADIUS.IsAllInZoneOfCoalition(): Scan the presence of units in the zone of a coalition.
---  * Core.Zone#ZONE_RADIUS.IsAllInZoneOfOtherCoalition(): Scan the presence of units in the zone of an other coalition.
---  * Core.Zone#ZONE_RADIUS.IsSomeInZoneOfCoalition(): Scan if there is some presence of units in the zone of the given coalition.
---  * Core.Zone#ZONE_RADIUS.IsNoneInZoneOfCoalition(): Scan if there isn't any presence of units in the zone of an other coalition than the given one.
---  * Core.Zone#ZONE_RADIUS.IsNoneInZone(): Scan if the zone is empty.
---
------
---
---USAGE
---```
---   myzone:Scan({Object.Category.UNIT},{Unit.Category.GROUND_UNIT})
---   local IsAttacked = myzone:IsSomeInZoneOfCoalition( self.Coalition )
---```
------
---@param self ZONE_RADIUS 
---@param ObjectCategories NOTYPE An array of categories of the objects to find in the zone. E.g. `{Object.Category.UNIT}`
---@param UnitCategories NOTYPE An array of unit categories of the objects to find in the zone. E.g. `{Unit.Category.GROUND_UNIT,Unit.Category.SHIP}`
function ZONE_RADIUS:Scan(ObjectCategories, UnitCategories) end

---Searches the zone
---
------
---@param self ZONE_RADIUS 
---@param ObjectCategories NOTYPE A list of categories, which are members of Object.Category
---@param EvaluateFunction NOTYPE 
function ZONE_RADIUS:SearchZone(ObjectCategories, EvaluateFunction) end

---Sets the radius of the zone.
---
------
---@param self ZONE_RADIUS 
---@param Radius Distance The radius of the zone.
---@return Distance #The radius of the zone.
function ZONE_RADIUS:SetRadius(Radius) end

---Sets the DCS#Vec2 of the zone.
---
------
---@param self ZONE_RADIUS 
---@param Vec2 Vec2 The new location of the zone.
---@return Vec2 #The new location of the zone.
function ZONE_RADIUS:SetVec2(Vec2) end

---Smokes the zone boundaries in a color.
---
------
---@param self ZONE_RADIUS 
---@param SmokeColor SMOKECOLOR The smoke color.
---@param Points? number (optional) The amount of points in the circle.
---@param AddHeight? number (optional) The height to be added for the smoke.
---@param AddOffSet? number (optional) The angle to be added for the smoking start position.
---@param AngleOffset NOTYPE 
---@return ZONE_RADIUS #self
function ZONE_RADIUS:SmokeZone(SmokeColor, Points, AddHeight, AddOffSet, AngleOffset) end

---Update zone from a 2D vector.
---
------
---@param self ZONE_RADIUS 
---@param Vec2 Vec2 The location of the zone.
---@param Radius Distance The radius of the zone.
---@return ZONE_RADIUS #self
function ZONE_RADIUS:UpdateFromVec2(Vec2, Radius) end

---Update zone from a 2D vector.
---
------
---@param self ZONE_RADIUS 
---@param Vec3 Vec3 The location of the zone.
---@param Radius Distance The radius of the zone.
---@return ZONE_RADIUS #self
function ZONE_RADIUS:UpdateFromVec3(Vec3, Radius) end


---# ZONE_UNIT class, extends #ZONE_RADIUS
---
---The ZONE_UNIT class defined by a zone attached to a Wrapper.Unit#UNIT with a radius and optional offsets.
---This class implements the inherited functions from #ZONE_RADIUS taking into account the own zone format and properties.
---@class ZONE_UNIT : ZONE_RADIUS
---@field LastVec2 NOTYPE 
---@field ZoneUNIT UNIT 
ZONE_UNIT = {}

---Returns a random location within the zone.
---
------
---@param self ZONE_UNIT 
---@return Vec2 #The random location within the zone.
function ZONE_UNIT:GetRandomVec2() end

---Returns the current location of the Wrapper.Unit#UNIT.
---
------
---@param self ZONE_UNIT 
---@return Vec2 #The location of the zone based on the @{Wrapper.Unit#UNIT}location and the offset, if any.
function ZONE_UNIT:GetVec2() end

---Returns the DCS#Vec3 of the ZONE_UNIT.
---
------
---@param self ZONE_UNIT 
---@param Height Distance The height to add to the land height where the center of the zone is located.
---@return Vec3 #The point of the zone.
function ZONE_UNIT:GetVec3(Height) end

---Constructor to create a ZONE_UNIT instance, taking the zone name, a zone unit and a radius and optional offsets in X and Y directions.
---
------
---@param self ZONE_UNIT 
---@param ZoneName string Name of the zone.
---@param ZoneUNIT UNIT The unit as the center of the zone.
---@param Radius number The radius of the zone in meters.
---@param Offset table A table specifying the offset. The offset table may have the following elements:  dx The offset in X direction, +x is north.  dy The offset in Y direction, +y is east.  rho The distance of the zone from the unit  theta The azimuth of the zone relative to unit  relative_to_unit If true, theta is measured clockwise from unit's direction else clockwise from north. If using dx, dy setting this to true makes +x parallel to unit heading.  dx, dy OR rho, theta may be used, not both.
---@return ZONE_UNIT #self
function ZONE_UNIT:New(ZoneName, ZoneUNIT, Radius, Offset) end


---## _ZONE_TRIANGLE class, extends #ZONE_BASE
---
---_ZONE_TRIANGLE class is a helper class for ZONE_POLYGON
---This class implements the inherited functions from #ZONE_BASE taking into account the own zone format and properties.
---Ported from https://github.com/nielsvaes/CCMOOSE/blob/master/Moose%20Development/Moose/Shapes/Triangle.lua
---- This triangle "zone" is not really to be used on its own, it only serves as building blocks for
---- ZONE_POLYGON to accurately find a point inside a polygon; as well as getting the correct surface area of
---- a polygon.
---@class _ZONE_TRIANGLE : ZONE_BASE
_ZONE_TRIANGLE = {}

---Checks if a point is contained within the triangle.
---
------
---@param self _ZONE_TRIANGLE 
---@param pt table The point to check
---@param points? table (optional) The points of the triangle, or 3 other points if you're just using the TRIANGLE class without an object of it
---@return boolean #True if the point is contained, false otherwise
function _ZONE_TRIANGLE:ContainsPoint(pt, points) end

---Draw the triangle
---
------
---@param self _ZONE_TRIANGLE 
---@param Coalition NOTYPE 
---@param Color NOTYPE 
---@param Alpha NOTYPE 
---@param FillColor NOTYPE 
---@param FillAlpha NOTYPE 
---@param LineType NOTYPE 
---@param ReadOnly NOTYPE 
---@return table #of draw IDs
function _ZONE_TRIANGLE:Draw(Coalition, Color, Alpha, FillColor, FillAlpha, LineType, ReadOnly) end

---Draw the triangle
---
------
---@param self _ZONE_TRIANGLE 
---@param Coalition NOTYPE 
---@param FillColor NOTYPE 
---@param FillAlpha NOTYPE 
---@param ReadOnly NOTYPE 
---@return table #of draw IDs
function _ZONE_TRIANGLE:Fill(Coalition, FillColor, FillAlpha, ReadOnly) end

---Returns a random Vec2 within the triangle.
---
------
---@param self _ZONE_TRIANGLE 
---@param points table The points of the triangle, or 3 other points if you're just using the TRIANGLE class without an object of it
---@return table #The random Vec2
function _ZONE_TRIANGLE:GetRandomVec2(points) end


---
------
---@param self _ZONE_TRIANGLE 
---@param p1 Vec 
---@param p2 Vec 
---@param p3 Vec 
---@return _ZONE_TRIANGLE #self
function _ZONE_TRIANGLE:New(p1, p2, p3) end



