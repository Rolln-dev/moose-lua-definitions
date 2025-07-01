---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Core_Coordinate.JPG" width="100%">
---
---**Core** - Defines an extensive API to manage 3D points in the DCS World 3D simulation space.
---
---## Features:
---
---  * Provides a COORDINATE class, which allows to manage points in 3D space and perform various operations on it.
---  * Provides a POINT\_VEC2 class, which is derived from COORDINATE, and allows to manage points in 3D space, but from a Lat/Lon and Altitude perspective.
---  * Provides a POINT\_VEC3 class, which is derived from COORDINATE, and allows to manage points in 3D space, but from a X, Z and Y vector perspective.
---
---===
---
---### Authors:
---
---  * FlightControl (Design & Programming)
---
---### Contributions:
---
---  * funkyfranky
---  * Applevangelist
---  
---===
---Defines a 3D point in the simulator and with its methods, you can use or manipulate the point in 3D space.
---
---# 1) Create a COORDINATE object.
---
---A new COORDINATE object can be created with 3 various methods:
---
--- * #COORDINATE.New(): from a 3D point.
--- * #COORDINATE.NewFromVec2(): from a DCS#Vec2 and possible altitude.
--- * #COORDINATE.NewFromVec3(): from a DCS#Vec3.
---
---
---# 2) Smoke, flare, explode, illuminate at the coordinate.
---
---At the point a smoke, flare, explosion and illumination bomb can be triggered. Use the following methods:
---
---## 2.1) Smoke
---
---  * #COORDINATE.Smoke(): To smoke the point in a certain color.
---  * #COORDINATE.SmokeBlue(): To smoke the point in blue.
---  * #COORDINATE.SmokeRed(): To smoke the point in red.
---  * #COORDINATE.SmokeOrange(): To smoke the point in orange.
---  * #COORDINATE.SmokeWhite(): To smoke the point in white.
---  * #COORDINATE.SmokeGreen(): To smoke the point in green.
---  * #COORDINATE.SetSmokeOffsetDirection(): To set an offset point direction for smoke.
---  * #COORDINATE.SetSmokeOffsetDistance(): To set an offset point distance for smoke.
---  * #COORDINATE.SwitchSmokeOffsetOn(): To set an offset point for smoke to on.
---  * #COORDINATE.SwitchSmokeOffsetOff(): To set an offset point for smoke to off.
---
---## 2.2) Flare
---
---  * #COORDINATE.Flare(): To flare the point in a certain color.
---  * #COORDINATE.FlareRed(): To flare the point in red.
---  * #COORDINATE.FlareYellow(): To flare the point in yellow.
---  * #COORDINATE.FlareWhite(): To flare the point in white.
---  * #COORDINATE.FlareGreen(): To flare the point in green.
---
---## 2.3) Explode
---
---  * #COORDINATE.Explosion(): To explode the point with a certain intensity.
---
---## 2.4) Illuminate
---
---  * #COORDINATE.IlluminationBomb(): To illuminate the point.
---
---
---# 3) Create markings on the map.
---
---Place markers (text boxes with clarifications for briefings, target locations or any other reference point)
---on the map for all players, coalitions or specific groups:
---
---  * #COORDINATE.MarkToAll(): Place a mark to all players.
---  * #COORDINATE.MarkToCoalition(): Place a mark to a coalition.
---  * #COORDINATE.MarkToCoalitionRed(): Place a mark to the red coalition.
---  * #COORDINATE.MarkToCoalitionBlue(): Place a mark to the blue coalition.
---  * #COORDINATE.MarkToGroup(): Place a mark to a group (needs to have a client in it or a CA group (CA group is bugged)).
---  * #COORDINATE.RemoveMark(): Removes a mark from the map.
---
---# 4) Coordinate calculation methods.
---
---Various calculation methods exist to use or manipulate 3D space. Find below a short description of each method:
---
---## 4.1) Get the distance between 2 points.
---
---  * #COORDINATE.Get3DDistance(): Obtain the distance from the current 3D point to the provided 3D point in 3D space.
---  * #COORDINATE.Get2DDistance(): Obtain the distance from the current 3D point to the provided 3D point in 2D space.
---
---## 4.2) Get the angle.
---
---  * #COORDINATE.GetAngleDegrees(): Obtain the angle in degrees from the current 3D point with the provided 3D direction vector.
---  * #COORDINATE.GetAngleRadians(): Obtain the angle in radians from the current 3D point with the provided 3D direction vector.
---  * #COORDINATE.GetDirectionVec3(): Obtain the 3D direction vector from the current 3D point to the provided 3D point.
---
---## 4.3) Coordinate translation.
---
---  * #COORDINATE.Translate(): Translate the current 3D point towards an other 3D point using the given Distance and Angle.
---
---## 4.4) Get the North correction of the current location.
---
---  * #COORDINATE.GetNorthCorrectionRadians(): Obtains the north correction at the current 3D point.
---
---## 4.5) Point Randomization
---
---Various methods exist to calculate random locations around a given 3D point.
---
---  * #COORDINATE.GetRandomVec2InRadius(): Provides a random 2D vector around the current 3D point, in the given inner to outer band.
---  * #COORDINATE.GetRandomVec3InRadius(): Provides a random 3D vector around the current 3D point, in the given inner to outer band.
---
---## 4.6) LOS between coordinates.
---
---Calculate if the coordinate has Line of Sight (LOS) with the other given coordinate.
---Mountains, trees and other objects can be positioned between the two 3D points, preventing visibilty in a straight continuous line.
---The method #COORDINATE.IsLOS() returns if the two coordinates have LOS.
---
---## 4.7) Check the coordinate position.
---
---Various methods are available that allow to check if a coordinate is:
---
---  * #COORDINATE.IsInRadius(): in a give radius.
---  * #COORDINATE.IsInSphere(): is in a given sphere.
---  * #COORDINATE.IsAtCoordinate2D(): is in a given coordinate within a specific precision.
---
---
---
---# 5) Measure the simulation environment at the coordinate.
---
---## 5.1) Weather specific.
---
---Within the DCS simulator, a coordinate has specific environmental properties, like wind, temperature, humidity etc.
---
---  * #COORDINATE.GetWind(): Retrieve the wind at the specific coordinate within the DCS simulator.
---  * #COORDINATE.GetTemperature(): Retrieve the temperature at the specific height within the DCS simulator.
---  * #COORDINATE.GetPressure(): Retrieve the pressure at the specific height within the DCS simulator.
---
---## 5.2) Surface specific.
---
---Within the DCS simulator, the surface can have various objects placed at the coordinate, and the surface height will vary.
---
---  * #COORDINATE.GetLandHeight(): Retrieve the height of the surface (on the ground) within the DCS simulator.
---  * #COORDINATE.GetSurfaceType(): Retrieve the surface type (on the ground) within the DCS simulator.
---
---# 6) Create waypoints for routes.
---
---A COORDINATE can prepare waypoints for Ground and Air groups to be embedded into a Route.
---
---  * #COORDINATE.WaypointAir(): Build an air route point.
---  * #COORDINATE.WaypointGround(): Build a ground route point.
---  * #COORDINATE.WaypointNaval(): Build a naval route point.
---
---Route points can be used in the Route methods of the Wrapper.Group#GROUP class.
---
---## 7) Manage the roads.
---
---Important for ground vehicle transportation and movement, the method #COORDINATE.GetClosestPointToRoad() will calculate
---the closest point on the nearest road.
---
---In order to use the most optimal road system to transport vehicles, the method #COORDINATE.GetPathOnRoad() will calculate
---the most optimal path following the road between two coordinates.
---
---## 8) Metric or imperial system
---
---  * #COORDINATE.IsMetric(): Returns if the 3D point is Metric or Nautical Miles.
---  * #COORDINATE.SetMetric(): Sets the 3D point to Metric or Nautical Miles.
---
---
---## 9) Coordinate text generation
---
---  * #COORDINATE.ToStringBR(): Generates a Bearing & Range text in the format of DDD for DI where DDD is degrees and DI is distance.
---  * #COORDINATE.ToStringBRA(): Generates a Bearing, Range & Altitude text.
---  * #COORDINATE.ToStringBRAANATO(): Generates a Generates a Bearing, Range, Aspect & Altitude text in NATOPS.
---  * #COORDINATE.ToStringLL(): Generates a Latitude & Longitude text.
---  * #COORDINATE.ToStringLLDMS(): Generates a Lat, Lon, Degree, Minute, Second text.
---  * #COORDINATE.ToStringLLDDM(): Generates a Lat, Lon, Degree, decimal Minute text.
---  * #COORDINATE.ToStringMGRS(): Generates a MGRS grid coordinate text.
---
---## 10) Drawings on F10 map
---
---  * #COORDINATE.CircleToAll(): Draw a circle on the F10 map.
---  * #COORDINATE.LineToAll(): Draw a line on the F10 map.
---  * #COORDINATE.RectToAll(): Draw a rectangle on the F10 map.
---  * #COORDINATE.QuadToAll(): Draw a shape with four points on the F10 map.
---  * #COORDINATE.TextToAll(): Write some text on the F10 map.
---  * #COORDINATE.ArrowToAll(): Draw an arrow on the F10 map.
---Coordinate class
---@class COORDINATE : BASE
---@field ClassName string Name of the class
---@field Heading number Heading in degrees. Needs to be set first.
---@field SmokeOffset boolean 
---@field Velocity number Velocity in meters per second. Needs to be set first.
---@field WaypointAction COORDINATE.WaypointAction 
---@field WaypointAltType COORDINATE.WaypointAltType 
---@field WaypointType COORDINATE.WaypointType 
---@field private x number Component of the 3D vector.
---@field private y number Component of the 3D vector.
---@field private z number Component of the 3D vector.
COORDINATE = {}

---Add to the current land height an altitude.
---
------
---@param self COORDINATE 
---@param Altitude number The Altitude to add. If nothing (nil) is given, then the current land altitude is set.
---@return COORDINATE #
function COORDINATE:AddAlt(Altitude) end

---Add to the x coordinate of the COORDINATE.
---
------
---@param self COORDINATE 
---@param x number The x coordinate value to add to the current x coordinate.
---@return COORDINATE #
function COORDINATE:AddX(x) end

---Add to the y coordinate of the COORDINATE.
---
------
---@param self COORDINATE 
---@param y number The y coordinate value to add to the current y coordinate.
---@return COORDINATE #
function COORDINATE:AddY(y) end

---Add to the z coordinate of the COORDINATE.
---
------
---@param self COORDINATE 
---@param z number The z coordinate value to add to the current z coordinate.
---@return COORDINATE #
function COORDINATE:AddZ(z) end

---Arrow to all.
---Creates an arrow from the COORDINATE to the endpoint COORDINATE on the F10 map. There is no control over other dimensions of the arrow.
---
------
---@param self COORDINATE 
---@param Endpoint COORDINATE COORDINATE where the tip of the arrow is pointing at.
---@param Coalition number Coalition: All=-1, Neutral=0, Red=1, Blue=2. Default -1=All.
---@param Color table RGB color table {r, g, b}, e.g. {1,0,0} for red (default).
---@param Alpha number Transparency [0,1]. Default 1.
---@param FillColor table RGB color table {r, g, b}, e.g. {1,0,0} for red. Default is same as `Color` value.
---@param FillAlpha number Transparency [0,1]. Default 0.15.
---@param LineType number Line type: 0=No line, 1=Solid, 2=Dashed, 3=Dotted, 4=Dot dash, 5=Long dash, 6=Two dash. Default 1=Solid.
---@param ReadOnly? boolean (Optional) Mark is readonly and cannot be removed by users. Default false.
---@param Text? string (Optional) Text displayed when mark is added. Default none.
---@return number #The resulting Mark ID, which is a number. Can be used to remove the object again.
function COORDINATE:ArrowToAll(Endpoint, Coalition, Color, Alpha, FillColor, FillAlpha, LineType, ReadOnly, Text) end

---Big smoke and fire at the coordinate.
---
------
---@param self COORDINATE 
---@param Preset number Smoke preset (1=small smoke and fire, 2=medium smoke and fire, 3=large smoke and fire, 4=huge smoke and fire, 5=small smoke, 6=medium smoke, 7=large smoke, 8=huge smoke).
---@param Density? number (Optional) Smoke density. Number in [0,...,1]. Default 0.5.
---@param Duration? number (Optional) Duration of the smoke and fire in seconds.
---@param Delay? number (Optional) Delay before the smoke and fire is started in seconds.
---@param Name? string (Optional) Name of the fire to stop it later again if not using the same COORDINATE object. Defaults to "Fire-" plus a random 5-digit-number.
---@return COORDINATE #self
function COORDINATE:BigSmokeAndFire(Preset, Density, Duration, Delay, Name) end

---Huge smoke and fire at the coordinate.
---
------
---@param self COORDINATE 
---@param Density? number (Optional) Smoke density. Number between 0 and 1. Default 0.5.
---@param Duration? number (Optional) Duration of the smoke and fire in seconds.
---@param Delay? number (Optional) Delay before the smoke and fire is started in seconds.
---@param Name? string (Optional) Name of the fire to stop it later again if not using the same COORDINATE object. Defaults to "Fire-" plus a random 5-digit-number.
---@return COORDINATE #self
function COORDINATE:BigSmokeAndFireHuge(Density, Duration, Delay, Name) end

---Large smoke and fire at the coordinate.
---
------
---@param self COORDINATE 
---@param Density? number (Optional) Smoke density. Number between 0 and 1. Default 0.5.
---@param Duration? number (Optional) Duration of the smoke and fire in seconds.
---@param Delay? number (Optional) Delay before the smoke and fire is started in seconds.
---@param Name? string (Optional) Name of the fire to stop it later again if not using the same COORDINATE object. Defaults to "Fire-" plus a random 5-digit-number.
---@return COORDINATE #self
function COORDINATE:BigSmokeAndFireLarge(Density, Duration, Delay, Name) end

---Medium smoke and fire at the coordinate.
---
------
---@param self COORDINATE 
---@param Density? number (Optional) Smoke density. Number between 0 and 1. Default 0.5.
---@param Duration? number (Optional) Duration of the smoke and fire in seconds.
---@param Delay? number (Optional) Delay before the smoke and fire is started in seconds.
---@param Name? string (Optional) Name of the fire to stop it later again if not using the same COORDINATE object. Defaults to "Fire-" plus a random 5-digit-number.
---@return COORDINATE #self
function COORDINATE:BigSmokeAndFireMedium(Density, Duration, Delay, Name) end

---Small smoke and fire at the coordinate.
---
------
---@param self COORDINATE 
---@param Density? number (Optional) Smoke density. Number between 0 and 1. Default 0.5.
---@param Duration? number (Optional) Duration of the smoke and fire in seconds.
---@param Delay? number (Optional) Delay before the smoke and fire is started in seconds.
---@param Name? string (Optional) Name of the fire to stop it later again if not using the same COORDINATE object. Defaults to "Fire-" plus a random 5-digit-number.
---@return COORDINATE #self
function COORDINATE:BigSmokeAndFireSmall(Density, Duration, Delay, Name) end

---Huge smoke at the coordinate.
---
------
---@param self COORDINATE 
---@param Density? number (Optional) Smoke density. Number between 0 and 1. Default 0.5.
---@param Duration? number (Optional) Duration of the smoke and fire in seconds.
---@param Delay? number (Optional) Delay before the smoke and fire is started in seconds.
---@param Name? string (Optional) Name of the fire to stop it later again if not using the same COORDINATE object. Defaults to "Fire-" plus a random 5-digit-number.
---@return COORDINATE #self
function COORDINATE:BigSmokeHuge(Density, Duration, Delay, Name) end

---Large smoke at the coordinate.
---
------
---@param self COORDINATE 
---@param Density? number (Optional) Smoke density. Number between 0 and 1. Default 0.5.
---@param Duration? number (Optional) Duration of the smoke and fire in seconds.
---@param Delay? number (Optional) Delay before the smoke and fire is started in seconds.
---@param Name? string (Optional) Name of the fire to stop it later again if not using the same COORDINATE object. Defaults to "Fire-" plus a random 5-digit-number.
---@return COORDINATE #self
function COORDINATE:BigSmokeLarge(Density, Duration, Delay, Name) end

---Medium smoke at the coordinate.
---
------
---@param self COORDINATE 
---@param Density? number (Optional) Smoke density. Number between 0 and 1. Default 0.5.
---@param Duration? number (Optional) Duration of the smoke and fire in seconds.
---@param Delay? number (Optional) Delay before the smoke and fire is started in seconds.
---@param Name? string (Optional) Name of the fire to stop it later again if not using the same COORDINATE object. Defaults to "Fire-" plus a random 5-digit-number.
---@return COORDINATE #self
function COORDINATE:BigSmokeMedium(Density, Duration, Delay, Name) end

---Small smoke at the coordinate.
---
------
---@param self COORDINATE 
---@param Density? number (Optional) Smoke density. Number between 0 and 1. Default 0.5.
---@param Duration? number (Optional) Duration of the smoke and fire in seconds.
---@param Delay? number (Optional) Delay before the smoke and fire is started in seconds.
---@param Name? string (Optional) Name of the fire to stop it later again if not using the same COORDINATE object. Defaults to "Fire-" plus a random 5-digit-number.
---@return COORDINATE #self
function COORDINATE:BigSmokeSmall(Density, Duration, Delay, Name) end

---Circle to all.
---Creates a circle on the map with a given radius, color, fill color, and outline.
---
------
---@param self COORDINATE 
---@param Radius number Radius in meters. Default 1000 m.
---@param Coalition number Coalition: All=-1, Neutral=0, Red=1, Blue=2. Default -1=All.
---@param Color table RGB color table {r, g, b}, e.g. {1,0,0} for red (default).
---@param Alpha number Transparency [0,1]. Default 1.
---@param FillColor table RGB color table {r, g, b}, e.g. {1,0,0} for red. Default is same as `Color` value.
---@param FillAlpha number Transparency [0,1]. Default 0.15.
---@param LineType number Line type: 0=No line, 1=Solid, 2=Dashed, 3=Dotted, 4=Dot dash, 5=Long dash, 6=Two dash. Default 1=Solid.
---@param ReadOnly? boolean (Optional) Mark is readonly and cannot be removed by users. Default false.
---@param Text? string (Optional) Text displayed when mark is added. Default none.
---@return number #The resulting Mark ID, which is a number. Can be used to remove the object again.
function COORDINATE:CircleToAll(Radius, Coalition, Color, Alpha, FillColor, FillAlpha, LineType, ReadOnly, Text) end

---Calculate the distance from a reference #COORDINATE.
---
------
---@param self COORDINATE 
---@param PointVec2Reference COORDINATE The reference @{#COORDINATE}.
---@return Distance #The distance from the reference @{#COORDINATE} in meters.
function COORDINATE:DistanceFromPointVec2(PointVec2Reference) end

---Creates an explosion at the point of a certain intensity.
---
------
---@param self COORDINATE 
---@param ExplosionIntensity number Intensity of the explosion in kg TNT. Default 100 kg.
---@param Delay? number (Optional) Delay before explosion is triggered in seconds.
---@return COORDINATE #self
function COORDINATE:Explosion(ExplosionIntensity, Delay) end

---Find the closest scenery to the COORDINATE within a certain radius.
---
------
---@param self COORDINATE 
---@param radius number Scan radius in meters. Default 100 m.
---@return SCENERY #The closest scenery or #nil if no object is inside the given radius.
function COORDINATE:FindClosestScenery(radius) end

---Find the closest static to the COORDINATE within a certain radius.
---
------
---@param self COORDINATE 
---@param radius number Scan radius in meters. Default 100 m.
---@return STATIC #The closest static or #nil if no unit is inside the given radius.
function COORDINATE:FindClosestStatic(radius) end

---Find the closest unit to the COORDINATE within a certain radius.
---
------
---@param self COORDINATE 
---@param radius number Scan radius in meters. Default 100 m.
---@return UNIT #The closest unit or #nil if no unit is inside the given radius.
function COORDINATE:FindClosestUnit(radius) end

---Flares the point in a color.
---
------
---@param self COORDINATE 
---@param FlareColor FLARECOLOR 
---@param Azimuth? Azimuth (optional) The azimuth of the flare direction. The default azimuth is 0.
function COORDINATE:Flare(FlareColor, Azimuth) end

---Flare the COORDINATE Green.
---
------
---@param self COORDINATE 
---@param Azimuth? Azimuth (optional) The azimuth of the flare direction. The default azimuth is 0.
function COORDINATE:FlareGreen(Azimuth) end

---Flare the COORDINATE Red.
---
------
---@param self COORDINATE 
---@param Azimuth? Azimuth (optional) The azimuth of the flare direction. The default azimuth is 0.
function COORDINATE:FlareRed(Azimuth) end

---Flare the COORDINATE White.
---
------
---@param self COORDINATE 
---@param Azimuth? Azimuth (optional) The azimuth of the flare direction. The default azimuth is 0.
function COORDINATE:FlareWhite(Azimuth) end

---Flare the COORDINATE Yellow.
---
------
---@param self COORDINATE 
---@param Azimuth? Azimuth (optional) The azimuth of the flare direction. The default azimuth is 0.
function COORDINATE:FlareYellow(Azimuth) end

---Return the 2D distance in meters between the target COORDINATE and the COORDINATE.
---
------
---@param self COORDINATE 
---@param TargetCoordinate COORDINATE The target COORDINATE. Can also be a DCS#Vec3.
---@return Distance #Distance The distance in meters.
function COORDINATE:Get2DDistance(TargetCoordinate) end

---Return the 3D distance in meters between the target COORDINATE and the COORDINATE.
---
------
---@param self COORDINATE 
---@param TargetCoordinate COORDINATE The target COORDINATE. Can also be a DCS#Vec3.
---@return Distance #Distance The distance in meters.
function COORDINATE:Get3DDistance(TargetCoordinate) end

---Return the altitude (height) of the land at the COORDINATE.
---
------
---@param self COORDINATE 
---@return number #The land altitude.
function COORDINATE:GetAlt() end

---Return the altitude text of the COORDINATE.
---
------
---@param self COORDINATE 
---@param Settings SETTINGS 
---@param Language SETTINGS.Locale 
---@return string #Altitude text.
function COORDINATE:GetAltitudeText(Settings, Language) end

---Return an angle in degrees from the COORDINATE using a **direction vector in Vec3 format**.
---
------
---
---USAGE
---```
---        local directionAngle = currentCoordinate:GetAngleDegrees(currentCoordinate:GetDirectionVec3(sourceCoordinate:GetVec3()))
---```
------
---@param self COORDINATE 
---@param DirectionVec3 Vec3 The direction vector in Vec3 format.
---@return number #DirectionRadians The angle in degrees.
function COORDINATE:GetAngleDegrees(DirectionVec3) end

---Return an angle in radians from the COORDINATE using a **direction vector in Vec3 format**.
---
------
---@param self COORDINATE 
---@param DirectionVec3 Vec3 The direction vector in Vec3 format.
---@return number #DirectionRadians The angle in radians.
function COORDINATE:GetAngleRadians(DirectionVec3) end

---Provides a Bearing / Range / Altitude string
---
------
---@param self COORDINATE 
---@param AngleRadians number The angle in randians
---@param Distance number The distance
---@param Settings SETTINGS 
---@param Language? string (Optional) Language "en" or "ru"
---@param MagVar boolean If true, also state angle in magnetic
---@return string #The BRA Text
function COORDINATE:GetBRAText(AngleRadians, Distance, Settings, Language, MagVar) end

---Provides a Bearing / Range string
---
------
---@param self COORDINATE 
---@param AngleRadians number The angle in randians
---@param Distance number The distance
---@param Settings SETTINGS 
---@param Language? string (Optional) Language "en" or "ru"
---@param MagVar boolean If true, also state angle in magnetic
---@param Precision number Rounding precision, defaults to 0
---@return string #The BR Text
function COORDINATE:GetBRText(AngleRadians, Distance, Settings, Language, MagVar, Precision) end

---Provides a bearing text in degrees.
---
------
---@param self COORDINATE 
---@param AngleRadians number The angle in randians.
---@param Precision number The precision.
---@param Settings SETTINGS 
---@param MagVar boolean If true, include magentic degrees
---@return string #The bearing text in degrees.
function COORDINATE:GetBearingText(AngleRadians, Precision, Settings, MagVar) end

---Return the BULLSEYE as COORDINATE Object
---
------
---
---USAGE
---```
---         -- note the dot (.) here,not using the colon (:)
---         local redbulls = COORDINATE.GetBullseyeCoordinate(coalition.side.RED)
---```
------
---@param Coalition number Coalition of the bulls eye to return, e.g. coalition.side.BLUE
---@return COORDINATE #self
function COORDINATE.GetBullseyeCoordinate(Coalition) end

---Gets the nearest airbase with respect to the current coordinates.
---
------
---@param self COORDINATE 
---@param Category? number (Optional) Category of the airbase. Enumerator of @{Wrapper.Airbase#AIRBASE.Category}.
---@param Coalition? number (Optional) Coalition of the airbase.
---@return AIRBASE #Closest Airbase to the given coordinate.
---@return number #Distance to the closest airbase in meters.
function COORDINATE:GetClosestAirbase(Category, Coalition) end

---[kept for downwards compatibility only] Gets the nearest airbase with respect to the current coordinates.
---
------
---@param self COORDINATE 
---@param Category? number (Optional) Category of the airbase. Enumerator of @{Wrapper.Airbase#AIRBASE.Category}.
---@param Coalition? number (Optional) Coalition of the airbase.
---@return AIRBASE #Closest Airbase to the given coordinate.
---@return number #Distance to the closest airbase in meters.
function COORDINATE:GetClosestAirbase2(Category, Coalition) end

---Gets the nearest free parking spot.
---
------
---@param self COORDINATE 
---@param airbase? AIRBASE (Optional) Search only parking spots at that airbase.
---@param terminaltype? Terminaltype (Optional) Type of the terminal.
---@return COORDINATE #Coordinate of the nearest free parking spot.
---@return number #Terminal ID.
---@return number #Distance to closest free parking spot in meters.
function COORDINATE:GetClosestFreeParkingSpot(airbase, terminaltype) end

---Gets the nearest occupied parking spot.
---
------
---@param self COORDINATE 
---@param airbase? AIRBASE (Optional) Search only parking spots at that airbase.
---@param terminaltype? Terminaltype (Optional) Type of the terminal.
---@return COORDINATE #Coordinate of the nearest occupied parking spot.
---@return number #Terminal ID.
---@return number #Distance to closest occupied parking spot in meters.
function COORDINATE:GetClosestOccupiedParkingSpot(airbase, terminaltype) end

---Gets the nearest parking spot.
---
------
---@param self COORDINATE 
---@param airbase? AIRBASE (Optional) Search only parking spots at this airbase.
---@param terminaltype? Terminaltype (Optional) Type of the terminal. Default any execpt valid spawn points on runway.
---@param free? boolean (Optional) If true, returns the closest free spot. If false, returns the closest occupied spot. If nil, returns the closest spot regardless of free or occupied.
---@return COORDINATE #Coordinate of the nearest parking spot.
---@return number #Terminal ID.
---@return number #Distance to closest parking spot in meters.
---@return AIRBASE #ParkingSpot Parking spot table.
function COORDINATE:GetClosestParkingSpot(airbase, terminaltype, free) end

---Gets the nearest coordinate to a road (or railroad).
---
------
---@param self COORDINATE 
---@param Railroad? boolean (Optional) If true, closest point to railroad is returned rather than closest point to conventional road. Default false.
---@return COORDINATE #Coordinate of the nearest road.
function COORDINATE:GetClosestPointToRoad(Railroad) end

---Return the coordinates itself.
---Sounds stupid but can be useful for compatibility.
---
------
---@param self COORDINATE 
---@return COORDINATE #self
function COORDINATE:GetCoordinate() end

---Return a direction vector Vec3 from COORDINATE to the COORDINATE.
---
------
---@param self COORDINATE 
---@param TargetCoordinate COORDINATE The target COORDINATE.
---@return Vec3 #DirectionVec3 The direction vector in Vec3 format.
function COORDINATE:GetDirectionVec3(TargetCoordinate) end

---Provides a distance text expressed in the units of measurement.
---
------
---@param self COORDINATE 
---@param Distance number The distance in meters.
---@param Settings SETTINGS 
---@param Language? string (optional) "EN" or "RU"
---@param Precision? number (optional) round to this many decimal places
---@return string #The distance text expressed in the units of measurement.
function COORDINATE:GetDistanceText(Distance, Settings, Language, Precision) end

---Get the heading of the coordinate, if applicable.
---
------
---@param self COORDINATE 
---@return number #or nil
function COORDINATE:GetHeading() end

---Return the heading text of the COORDINATE.
---
------
---@param self COORDINATE 
---@param Settings SETTINGS 
---@return string #Heading text.
function COORDINATE:GetHeadingText(Settings) end

---Return an intermediate COORDINATE between this an another coordinate.
---
------
---@param self COORDINATE 
---@param ToCoordinate COORDINATE The other coordinate.
---@param Fraction number The fraction (0,1) where the new coordinate is created. Default 0.5, i.e. in the middle.
---@return COORDINATE #Coordinate between this and the other coordinate.
function COORDINATE:GetIntermediateCoordinate(ToCoordinate, Fraction) end

---Get Latitude and Longitude in Degrees Decimal Minutes (DDM).
---
------
---@param self COORDINATE 
---@return number #Latitude in DDM.
---@return number #Lontitude in DDM.
function COORDINATE:GetLLDDM() end

---Return the height of the land at the coordinate.
---
------
---@param self COORDINATE 
---@return number #Land height (ASL) in meters.
function COORDINATE:GetLandHeight() end

---Return Return the Lat(itude) coordinate of the COORDINATE (ie: (parent)COORDINATE.x).
---
------
---@param self COORDINATE 
---@return number #The x coordinate.
function COORDINATE:GetLat() end


---
------
---@param self NOTYPE 
function COORDINATE:GetLon() end

---Returns the magnetic declination at the given coordinate.
---NOTE that this needs `require` to be available so you need to desanitize the `MissionScripting.lua` file in your DCS/Scrips folder.
---If `require` is not available, a constant value for the whole map.
---
------
---@param self COORDINATE 
---@param Month? number (Optional) The month at which the declination is calculated. Default is the mission month.
---@param Year? number (Optional) The year at which the declination is calculated. Default is the mission year.
---@return number #Magnetic declination in degrees.
function COORDINATE:GetMagneticDeclination(Month, Year) end

---Get minutes until the next sun rise at this coordinate.
---
------
---@param self COORDINATE 
---@param OnlyToday boolean If true, only calculate the sun rise of today. If sun has already risen, the time in negative minutes since sunrise is reported.
---@return number #Minutes to the next sunrise.
function COORDINATE:GetMinutesToSunrise(OnlyToday) end

---Get minutes until the next sun set at this coordinate.
---
------
---@param self COORDINATE 
---@param OnlyToday boolean If true, only calculate the sun set of today. If sun has already set, the time in negative minutes since sunset is reported.
---@return number #Minutes to the next sunrise.
function COORDINATE:GetMinutesToSunset(OnlyToday) end

---Return velocity text of the COORDINATE.
---
------
---@param self COORDINATE 
---@param Settings SETTINGS 
---@return string #
function COORDINATE:GetMovingText(Settings) end

---Return the "name" of the COORDINATE.
---Obviously, a coordinate does not have a name like a unit, static or group. So here we take the MGRS coordinates of the position.
---
------
---@param self COORDINATE 
---@return string #MGRS coordinates.
function COORDINATE:GetName() end

---Get a correction in radians of the real magnetic north of the COORDINATE.
---
------
---@param self COORDINATE 
---@return number #CorrectionRadians The correction in radians.
function COORDINATE:GetNorthCorrectionRadians() end

---Returns a table of coordinates to a destination using only roads or railroads.
---The first point is the closest point on road of the given coordinate.
---By default, the last point is the closest point on road of the ToCoord. Hence, the coordinate itself and the final ToCoord are not necessarily included in the path.
---
------
---@param self COORDINATE 
---@param ToCoord COORDINATE Coordinate of destination.
---@param IncludeEndpoints? boolean (Optional) Include the coordinate itself and the ToCoordinate in the path.
---@param Railroad? boolean (Optional) If true, path on railroad is returned. Default false.
---@param MarkPath? boolean (Optional) If true, place markers on F10 map along the path.
---@param SmokePath? boolean (Optional) If true, put (green) smoke along the
---@return table #Table of coordinates on road. If no path on road can be found, nil is returned or just the endpoints.
---@return number #Tonal length of path.
---@return boolean #If true a valid path on road/rail was found. If false, only the direct way is possible.
function COORDINATE:GetPathOnRoad(ToCoord, IncludeEndpoints, Railroad, MarkPath, SmokePath) end

---Returns the pressure in hPa.
---
------
---@param self COORDINATE 
---@param height? number (Optional) parameter specifying the height ASL. E.g. set height=0 for QNH.
---@return  #Pressure in hPa.
function COORDINATE:GetPressure(height) end

---Returns a text of the pressure according the measurement system Core.Settings.
---The text will contain always the pressure in hPa and:
---
---  - For Russian and European aircraft using the metric system - hPa and mmHg
---  - For American and European aircraft we link to the imperial system - hPa and inHg
---
---A text containing a pressure will look like this:
---
---  - `QFE: x hPa (y mmHg)`
---  - `QFE: x hPa (y inHg)`
---
------
---@param self COORDINATE 
---@param height? number (Optional) parameter specifying the height ASL. E.g. set height=0 for QNH.
---@param Settings SETTINGS 
---@return string #Pressure in hPa and mmHg or inHg depending on the measurement system @{Core.Settings}.
function COORDINATE:GetPressureText(height, Settings) end

---Return a random Coordinate within an Outer Radius and optionally NOT within an Inner Radius of the COORDINATE.
---
------
---@param self COORDINATE 
---@param OuterRadius Distance Outer radius in meters.
---@param InnerRadius Distance Inner radius in meters.
---@return COORDINATE #self
function COORDINATE:GetRandomCoordinateInRadius(OuterRadius, InnerRadius) end

---Return a random COORDINATE within an Outer Radius and optionally NOT within an Inner Radius of the COORDINATE.
---
------
---@param self COORDINATE 
---@param OuterRadius Distance 
---@param InnerRadius Distance 
---@return COORDINATE #
function COORDINATE:GetRandomPointVec2InRadius(OuterRadius, InnerRadius) end

---Return a random COORDINATE within an Outer Radius and optionally NOT within an Inner Radius of the COORDINATE.
---
------
---@param self COORDINATE 
---@param OuterRadius Distance 
---@param InnerRadius Distance 
---@return COORDINATE #
function COORDINATE:GetRandomPointVec3InRadius(OuterRadius, InnerRadius) end

---Return a random Vec2 within an Outer Radius and optionally NOT within an Inner Radius of the COORDINATE.
---
------
---@param self COORDINATE 
---@param OuterRadius Distance 
---@param InnerRadius Distance 
---@return Vec2 #Vec2
function COORDINATE:GetRandomVec2InRadius(OuterRadius, InnerRadius) end

---Return a random Vec3 within an Outer Radius and optionally NOT within an Inner Radius of the COORDINATE.
---
------
---@param self COORDINATE 
---@param OuterRadius Distance 
---@param InnerRadius Distance 
---@return Vec3 #Vec3
function COORDINATE:GetRandomVec3InRadius(OuterRadius, InnerRadius) end

---Get the offset direction when using `COORDINATE:Smoke()`.
---
------
---@param self COORDINATE 
---@return number #Direction in degrees.
function COORDINATE:GetSmokeOffsetDirection() end

---Get the offset distance when using `COORDINATE:Smoke()`.
---
------
---@param self COORDINATE 
---@return number #Distance Distance in meters.
function COORDINATE:GetSmokeOffsetDistance() end

---Get todays sun rise time.
---
------
---@param self COORDINATE 
---@param InSeconds boolean If true, return the sun rise time in seconds.
---@return string #Sunrise time, e.g. "05:41".
function COORDINATE:GetSunrise(InSeconds) end

---Get sun rise time for a specific date at the coordinate.
---
------
---@param self COORDINATE 
---@param Day number The day.
---@param Month number The month.
---@param Year number The year.
---@param InSeconds boolean If true, return the sun rise time in seconds.
---@return string #Sunrise time, e.g. "05:41".
function COORDINATE:GetSunriseAtDate(Day, Month, Year, InSeconds) end

---Get sun rise time for a specific day of the year at the coordinate.
---
------
---@param self COORDINATE 
---@param DayOfYear number The day of the year.
---@param InSeconds boolean If true, return the sun rise time in seconds.
---@return string #Sunrise time, e.g. "05:41".
function COORDINATE:GetSunriseAtDayOfYear(DayOfYear, InSeconds) end

---Get todays sun set time.
---
------
---@param self COORDINATE 
---@param InSeconds boolean If true, return the sun set time in seconds.
---@return string #Sunrise time, e.g. "20:41".
function COORDINATE:GetSunset(InSeconds) end

---Get sun set time for a specific date at the coordinate.
---
------
---@param self COORDINATE 
---@param Day number The day.
---@param Month number The month.
---@param Year number The year.
---@param InSeconds boolean If true, return the sun rise time in seconds.
---@return string #Sunset time, e.g. "20:41".
function COORDINATE:GetSunsetAtDate(Day, Month, Year, InSeconds) end

---Gets the surface type at the coordinate.
---
------
---@param self COORDINATE 
---@return SurfaceType #Surface type.
function COORDINATE:GetSurfaceType() end

---Returns the temperature in Degrees Celsius.
---
------
---@param self COORDINATE 
---@param height? number (Optional) parameter specifying the height ASL.
---@return  #Temperature in Degrees Celsius.
function COORDINATE:GetTemperature(height) end

---Returns a text of the temperature according the measurement system Core.Settings.
---The text will reflect the temperature like this:
---
---  - For Russian and European aircraft using the metric system - Degrees Celcius (°C)
---  - For American aircraft we link to the imperial system - Degrees Fahrenheit (°F)
---
---A text containing a pressure will look like this:
---
---  - `Temperature: %n.d °C`
---  - `Temperature: %n.d °F`
---
------
---@param self COORDINATE 
---@param height? number (Optional) parameter specifying the height ASL.
---@param Settings SETTINGS 
---@return string #Temperature according the measurement system @{Core.Settings}.
function COORDINATE:GetTemperatureText(height, Settings) end

---Return the coordinates of the COORDINATE in Vec2 format.
---
------
---@param self COORDINATE 
---@return Vec2 #The Vec2 format coordinate.
function COORDINATE:GetVec2() end

---Return the coordinates of the COORDINATE in Vec3 format.
---
------
---@param self COORDINATE 
---@return Vec3 #The Vec3 format coordinate.
function COORDINATE:GetVec3() end

---Return the velocity of the COORDINATE.
---
------
---@param self COORDINATE 
---@return number #Velocity in meters per second.
function COORDINATE:GetVelocity() end

---Return the velocity text of the COORDINATE.
---
------
---@param self COORDINATE 
---@param Settings SETTINGS 
---@return string #Velocity text.
function COORDINATE:GetVelocityText(Settings) end

---Returns the wind direction (from) and strength.
---
------
---@param self COORDINATE 
---@param height? number (Optional) parameter specifying the height ASL. The minimum height will be always be the land height since the wind is zero below the ground.
---@param turbulence boolean If `true`, include turbulence. If `false` or `nil`, wind without turbulence.
---@return number #Direction the wind is blowing from in degrees.
---@return number #Wind strength in m/s.
function COORDINATE:GetWind(height, turbulence) end

---Returns a text documenting the wind direction (from) and strength according the measurement system Core.Settings.
---The text will reflect the wind like this:
---
---  - For Russian and European aircraft using the metric system - Wind direction in degrees (°) and wind speed in meters per second (mps).
---  - For American aircraft we link to the imperial system - Wind direction in degrees (°) and wind speed in knots per second (kps).
---
---A text containing a pressure will look like this:
---
---  - `Wind: %n ° at n.d mps`
---  - `Wind: %n ° at n.d kps`
---
------
---@param self COORDINATE 
---@param height? number (Optional) parameter specifying the height ASL. The minimum height will be always be the land height since the wind is zero below the ground.
---@param Settings SETTINGS 
---@return string #Wind direction and strength according the measurement system @{Core.Settings}.
function COORDINATE:GetWindText(height, Settings) end

---Returns the 3D wind direction vector.
---Note that vector points into the direction the wind in blowing to.
---
------
---@param self COORDINATE 
---@param height? number (Optional) parameter specifying the height ASL in meters. The minimum height will be always be the land height since the wind is zero below the ground.
---@param turbulence? boolean (Optional) If `true`, include turbulence.
---@return Vec3 #Wind 3D vector. Components in m/s.
function COORDINATE:GetWindVec3(height, turbulence) end

---Returns the wind direction (from) and strength.
---
------
---@param self COORDINATE 
---@param height? number (Optional) parameter specifying the height ASL. The minimum height will be always be the land height since the wind is zero below the ground.
---@return  #Direction the wind is blowing from in degrees.
function COORDINATE:GetWindWithTurbulenceVec3(height) end

---Return the x coordinate of the COORDINATE.
---
------
---@param self COORDINATE 
---@return number #The x coordinate.
function COORDINATE:GetX() end

---Return the y coordinate of the COORDINATE.
---
------
---@param self COORDINATE 
---@return number #The y coordinate.
function COORDINATE:GetY() end

---Return the z coordinate of the COORDINATE.
---
------
---@param self COORDINATE 
---@return number #The z coordinate.
function COORDINATE:GetZ() end

---Returns the heading from this to another coordinate.
---
------
---@param self COORDINATE 
---@param ToCoordinate COORDINATE 
---@return number #Heading in degrees.
function COORDINATE:HeadingTo(ToCoordinate) end

---Creates an illumination bomb at the point.
---
------
---@param self COORDINATE 
---@param Power number Power of illumination bomb in Candela. Default 1000 cd.
---@param Delay? number (Optional) Delay before bomb is ignited in seconds.
---@return COORDINATE #self
function COORDINATE:IlluminationBomb(Power, Delay) end

---Returns if the 2 coordinates are at the same 2D position.
---
------
---@param self COORDINATE 
---@param Coordinate COORDINATE 
---@param Precision number 
---@return boolean #true if at the same position.
function COORDINATE:IsAtCoordinate2D(Coordinate, Precision) end

---Check if it is day, i.e.
---if the sun has risen about the horizon at this coordinate.
---
------
---@param self COORDINATE 
---@param Clock? string (Optional) Time in format "HH:MM:SS+D", e.g. "05:40:00+3" to check if is day at 5:40 at third day after mission start. Default is to check right now.
---@return boolean #If true, it is day. If false, it is night time.
function COORDINATE:IsDay(Clock) end

---Function to check if a coordinate is in a flat (<8% elevation) area of the map
---
------
---@param self COORDINATE 
---@param Radius? number (Optional) Radius to check around the coordinate, defaults to 50m (100m diameter)
---@param Minelevation? number (Optional) Elevation from which on a area is defined as steep, defaults to 8% (8m height gain across 100 meters)
---@return boolean #IsFlat If true, area is flat
---@return number #MaxElevation Elevation in meters measured over 100m
function COORDINATE:IsInFlatArea(Radius, Minelevation) end

---Returns if a Coordinate is in a certain Radius of this Coordinate in 2D plane using the X and Z axis.
---
------
---@param self COORDINATE 
---@param Coordinate COORDINATE The coordinate that will be tested if it is in the radius of this coordinate.
---@param Radius number The radius of the circle on the 2D plane around this coordinate.
---@return boolean #true if in the Radius.
function COORDINATE:IsInRadius(Coordinate, Radius) end

---Returns if a Coordinate is in a certain radius of this Coordinate in 3D space using the X, Y and Z axis.
---So Radius defines the radius of the a Sphere in 3D space around this coordinate.
---
------
---@param self COORDINATE 
---@param Coordinate COORDINATE The coordinate that will be tested if it is in the radius of this coordinate.
---@param Radius number The radius of the sphere in the 3D space around this coordinate.
---@return boolean #true if in the Sphere.
function COORDINATE:IsInSphere(Coordinate, Radius) end

---Function to check if a coordinate is in a steep (>8% elevation) area of the map
---
------
---@param self COORDINATE 
---@param Radius? number (Optional) Radius to check around the coordinate, defaults to 50m (100m diameter)
---@param Minelevation? number (Optional) Elevation from which on a area is defined as steep, defaults to 8% (8m height gain across 100 meters)
---@return boolean #IsSteep If true, area is steep
---@return number #MaxElevation Elevation in meters measured over 100m
function COORDINATE:IsInSteepArea(Radius, Minelevation) end

---Returns if a Coordinate has Line of Sight (LOS) with the ToCoordinate.
---
------
---@param self COORDINATE 
---@param ToCoordinate COORDINATE 
---@param Offset number Height offset in meters. Default 2 m.
---@return boolean #true If the ToCoordinate has LOS with the Coordinate, otherwise false.
function COORDINATE:IsLOS(ToCoordinate, Offset) end

---Check if it is night, i.e.
---if the sun has set below the horizon at this coordinate.
---
------
---@param self COORDINATE 
---@param Clock? string (Optional) Time in format "HH:MM:SS+D", e.g. "05:40:00+3" to check if is night at 5:40 at third day after mission start. Default is to check right now.
---@return boolean #If true, it is night. If false, it is day time.
function COORDINATE:IsNight(Clock) end

---Checks if the surface type is on land.
---
------
---@param self COORDINATE 
---@return boolean #If true, the surface type at the coordinate is land.
function COORDINATE:IsSurfaceTypeLand() end

---Checks if the surface type is road.
---
------
---@param self COORDINATE 
---@return boolean #If true, the surface type at the coordinate is a road.
function COORDINATE:IsSurfaceTypeRoad() end

---Checks if the surface type is runway.
---
------
---@param self COORDINATE 
---@return boolean #If true, the surface type at the coordinate is a runway or taxi way.
function COORDINATE:IsSurfaceTypeRunway() end

---Checks if the surface type is shallow water.
---
------
---@param self COORDINATE 
---@return boolean #If true, the surface type at the coordinate is a shallow water.
function COORDINATE:IsSurfaceTypeShallowWater() end

---Checks if the surface type is water.
---
------
---@param self COORDINATE 
---@return boolean #If true, the surface type at the coordinate is a deep water.
function COORDINATE:IsSurfaceTypeWater() end

---Line to all.
---Creates a line on the F10 map from one point to another.
---
------
---@param self COORDINATE 
---@param Endpoint COORDINATE COORDINATE to where the line is drawn.
---@param Coalition number Coalition: All=-1, Neutral=0, Red=1, Blue=2. Default -1=All.
---@param Color table RGB color table {r, g, b}, e.g. {1,0,0} for red (default).
---@param Alpha number Transparency [0,1]. Default 1.
---@param LineType number Line type: 0=No line, 1=Solid, 2=Dashed, 3=Dotted, 4=Dot dash, 5=Long dash, 6=Two dash. Default 1=Solid.
---@param ReadOnly? boolean (Optional) Mark is readonly and cannot be removed by users. Default false.
---@param Text? string (Optional) Text displayed when mark is added. Default none.
---@return number #The resulting Mark ID, which is a number. Can be used to remove the object again.
function COORDINATE:LineToAll(Endpoint, Coalition, Color, Alpha, LineType, ReadOnly, Text) end

---Mark to All
---
------
---
---USAGE
---```
---  local TargetCoord = TargetGroup:GetCoordinate()
---  local MarkID = TargetCoord:MarkToAll( "This is a target for all players" )
---```
------
---@param self COORDINATE 
---@param MarkText string Free format text that shows the marking clarification.
---@param ReadOnly? boolean (Optional) Mark is readonly and cannot be removed by users. Default false.
---@param Text? string (Optional) Text displayed when mark is added. Default none.
---@return number #The resulting Mark ID which is a number.
function COORDINATE:MarkToAll(MarkText, ReadOnly, Text) end

---Mark to Coalition
---
------
---
---USAGE
---```
---  local TargetCoord = TargetGroup:GetCoordinate()
---  local MarkID = TargetCoord:MarkToCoalition( "This is a target for the red coalition", coalition.side.RED )
---```
------
---@param self COORDINATE 
---@param MarkText string Free format text that shows the marking clarification.
---@param Coalition coalition 
---@param ReadOnly? boolean (Optional) Mark is readonly and cannot be removed by users. Default false.
---@param Text? string (Optional) Text displayed when mark is added. Default none.
---@return number #The resulting Mark ID which is a number.
function COORDINATE:MarkToCoalition(MarkText, Coalition, ReadOnly, Text) end

---Mark to Blue Coalition
---
------
---
---USAGE
---```
---  local TargetCoord = TargetGroup:GetCoordinate()
---  local MarkID = TargetCoord:MarkToCoalitionBlue( "This is a target for the blue coalition" )
---```
------
---@param self COORDINATE 
---@param MarkText string Free format text that shows the marking clarification.
---@param ReadOnly? boolean (Optional) Mark is readonly and cannot be removed by users. Default false.
---@param Text? string (Optional) Text displayed when mark is added. Default none.
---@return number #The resulting Mark ID which is a number.
function COORDINATE:MarkToCoalitionBlue(MarkText, ReadOnly, Text) end

---Mark to Red Coalition
---
------
---
---USAGE
---```
---  local TargetCoord = TargetGroup:GetCoordinate()
---  local MarkID = TargetCoord:MarkToCoalitionRed( "This is a target for the red coalition" )
---```
------
---@param self COORDINATE 
---@param MarkText string Free format text that shows the marking clarification.
---@param ReadOnly? boolean (Optional) Mark is readonly and cannot be removed by users. Default false.
---@param Text? string (Optional) Text displayed when mark is added. Default none.
---@return number #The resulting Mark ID which is a number.
function COORDINATE:MarkToCoalitionRed(MarkText, ReadOnly, Text) end

---Mark to Group
---
------
---
---USAGE
---```
---  local TargetCoord = TargetGroup:GetCoordinate()
---  local MarkGroup = GROUP:FindByName( "AttackGroup" )
---  local MarkID = TargetCoord:MarkToGroup( "This is a target for the attack group", AttackGroup )
---```
------
---@param self COORDINATE 
---@param MarkText string Free format text that shows the marking clarification.
---@param MarkGroup GROUP The @{Wrapper.Group} that receives the mark.
---@param ReadOnly? boolean (Optional) Mark is readonly and cannot be removed by users. Default false.
---@param Text? string (Optional) Text displayed when mark is added. Default none.
---@return number #The resulting Mark ID which is a number.
function COORDINATE:MarkToGroup(MarkText, MarkGroup, ReadOnly, Text) end

---Creates a free form shape on the F10 map.
---The first point is the current COORDINATE. The remaining points need to be specified.
---
------
---@param self COORDINATE 
---@param Coordinates table Table of coordinates of the remaining points of the shape.
---@param Coalition number Coalition: All=-1, Neutral=0, Red=1, Blue=2. Default -1=All.
---@param Color table RGB color table {r, g, b}, e.g. {1,0,0} for red (default).
---@param Alpha number Transparency [0,1]. Default 1.
---@param FillColor table RGB color table {r, g, b}, e.g. {1,0,0} for red. Default is same as `Color` value.
---@param FillAlpha number Transparency [0,1]. Default 0.15.
---@param LineType number Line type: 0=No line, 1=Solid, 2=Dashed, 3=Dotted, 4=Dot dash, 5=Long dash, 6=Two dash. Default 1=Solid.
---@param ReadOnly? boolean (Optional) Mark is readonly and cannot be removed by users. Default false.
---@param Text? string (Optional) Text displayed when mark is added. Default none.
---@return number #The resulting Mark ID, which is a number. Can be used to remove the object again.
function COORDINATE:MarkupToAllFreeForm(Coordinates, Coalition, Color, Alpha, FillColor, FillAlpha, LineType, ReadOnly, Text) end

---COORDINATE constructor.
---
------
---@param self COORDINATE 
---@param x Distance The x coordinate of the Vec3 point, pointing to the North.
---@param y Distance The y coordinate of the Vec3 point, pointing to up.
---@param z Distance The z coordinate of the Vec3 point, pointing to the right.
---@return COORDINATE #self
function COORDINATE:New(x, y, z) end

---COORDINATE constructor.
---
------
---@param self COORDINATE 
---@param Coordinate COORDINATE 
---@return COORDINATE #self
function COORDINATE:NewFromCoordinate(Coordinate) end

---Returns the coordinate from the latitude and longitude given in decimal degrees.
---
------
---@param self COORDINATE 
---@param latitude number Latitude in decimal degrees.
---@param longitude number Longitude in decimal degrees.
---@param altitude? number (Optional) Altitude in meters. Default is the land height at the coordinate.
---@return COORDINATE #
function COORDINATE:NewFromLLDD(latitude, longitude, altitude) end

---Provides a COORDINATE from an MGRS Coordinate
---
------
---@param self COORDINATE 
---@param UTMZone string UTM Zone, e.g. "37T"
---@param MGRSDigraph string Digraph, e.g. "DK"
---@param Easting string Meters easting - string in order to allow for leading zeros, e.g. "01234". Should be 5 digits.
---@param Northing string Meters northing - string in order to allow for leading zeros, e.g. "12340". Should be 5 digits.
---@return COORDINATE #self
function COORDINATE:NewFromMGRS(UTMZone, MGRSDigraph, Easting, Northing) end

---Provides a COORDINATE from an MGRS String
---
------
---@param self COORDINATE 
---@param MGRSString string MGRS String, e.g. "MGRS 37T DK 12345 12345"
---@return COORDINATE #self
function COORDINATE:NewFromMGRSString(MGRSString) end

---Create a new COORDINATE object from  Vec2 coordinates.
---
------
---@param self COORDINATE 
---@param Vec2 Vec2 The Vec2 point.
---@param LandHeightAdd? Distance (Optional) The default height if required to be evaluated will be the land height of the x, y coordinate. You can specify an extra height to be added to the land height.
---@return COORDINATE #self
function COORDINATE:NewFromVec2(Vec2, LandHeightAdd) end

---Create a new COORDINATE object from  Vec3 coordinates.
---
------
---@param self COORDINATE 
---@param Vec3 Vec3 The Vec3 point.
---@return COORDINATE #self
function COORDINATE:NewFromVec3(Vec3) end

---Create a new COORDINATE object from a waypoint.
---This uses the components
---
--- * `waypoint.x`
--- * `waypoint.alt`
--- * `waypoint.y`
---
------
---@param self COORDINATE 
---@param Waypoint Waypoint The waypoint.
---@return COORDINATE #self
function COORDINATE:NewFromWaypoint(Waypoint) end

---Creates a shape defined by 4 points on the F10 map.
---The first point is the current COORDINATE. The remaining three points need to be specified.
---
------
---@param self COORDINATE 
---@param Coord2 COORDINATE Second COORDINATE of the quad shape.
---@param Coord3 COORDINATE Third COORDINATE of the quad shape.
---@param Coord4 COORDINATE Fourth COORDINATE of the quad shape.
---@param Coalition number Coalition: All=-1, Neutral=0, Red=1, Blue=2. Default -1=All.
---@param Color table RGB color table {r, g, b}, e.g. {1,0,0} for red (default).
---@param Alpha number Transparency [0,1]. Default 1.
---@param FillColor table RGB color table {r, g, b}, e.g. {1,0,0} for red. Default is same as `Color` value.
---@param FillAlpha number Transparency [0,1]. Default 0.15.
---@param LineType number Line type: 0=No line, 1=Solid, 2=Dashed, 3=Dotted, 4=Dot dash, 5=Long dash, 6=Two dash. Default 1=Solid.
---@param ReadOnly? boolean (Optional) Mark is readonly and cannot be removed by users. Default false.
---@param Text? string (Optional) Text displayed when mark is added. Default none.
---@return number #The resulting Mark ID, which is a number. Can be used to remove the object again.
function COORDINATE:QuadToAll(Coord2, Coord3, Coord4, Coalition, Color, Alpha, FillColor, FillAlpha, LineType, ReadOnly, Text) end

---Rectangle to all.
---Creates a rectangle on the map from the COORDINATE in one corner to the end COORDINATE in the opposite corner.
---Creates a line on the F10 map from one point to another.
---
------
---@param self COORDINATE 
---@param Endpoint COORDINATE COORDINATE in the opposite corner.
---@param Coalition number Coalition: All=-1, Neutral=0, Red=1, Blue=2. Default -1=All.
---@param Color table RGB color table {r, g, b}, e.g. {1,0,0} for red (default).
---@param Alpha number Transparency [0,1]. Default 1.
---@param FillColor table RGB color table {r, g, b}, e.g. {1,0,0} for red. Default is same as `Color` value.
---@param FillAlpha number Transparency [0,1]. Default 0.15.
---@param LineType number Line type: 0=No line, 1=Solid, 2=Dashed, 3=Dotted, 4=Dot dash, 5=Long dash, 6=Two dash. Default 1=Solid.
---@param ReadOnly? boolean (Optional) Mark is readonly and cannot be removed by users. Default false.
---@param Text? string (Optional) Text displayed when mark is added. Default none.
---@return number #The resulting Mark ID, which is a number. Can be used to remove the object again.
function COORDINATE:RectToAll(Endpoint, Coalition, Color, Alpha, FillColor, FillAlpha, LineType, ReadOnly, Text) end

---Remove a mark
---
------
---
---USAGE
---```
---  local TargetCoord = TargetGroup:GetCoordinate()
---  local MarkGroup = GROUP:FindByName( "AttackGroup" )
---  local MarkID = TargetCoord:MarkToGroup( "This is a target for the attack group", AttackGroup )
---  <<< logic >>>
---  TargetCoord:RemoveMark( MarkID ) -- The mark is now removed
---```
------
---@param self COORDINATE 
---@param MarkID number The ID of the mark to be removed.
function COORDINATE:RemoveMark(MarkID) end

---Rotate coordinate in 2D (x,z) space.
---
------
---@param self COORDINATE 
---@param Angle Angle Angle of rotation in degrees.
---@return COORDINATE #The rotated coordinate.
function COORDINATE:Rotate2D(Angle) end

---Scan/find objects (units, statics, scenery) within a certain radius around the coordinate using the world.searchObjects() DCS API function.
---
------
---@param self COORDINATE 
---@param radius? number (Optional) Scan radius in meters. Default 100 m.
---@param scanunits? boolean (Optional) If true scan for units. Default true.
---@param scanstatics? boolean (Optional) If true scan for static objects. Default true.
---@param scanscenery? boolean (Optional) If true scan for scenery objects. Default false.
---@return boolean #True if units were found.
---@return boolean #True if statics were found.
---@return boolean #True if scenery objects were found.
---@return table #Table of MOOSE @{Wrapper.Unit#UNIT} objects found.
---@return table #Table of DCS static objects found.
---@return table #Table of DCS scenery objects found.
function COORDINATE:ScanObjects(radius, scanunits, scanstatics, scanscenery) end

---Scan/find SCENERY objects within a certain radius around the coordinate using the world.searchObjects() DCS API function.
---
------
---@param self COORDINATE 
---@param radius? number (Optional) Scan radius in meters. Default 100 m.
---@return  #table Table of SCENERY objects.
function COORDINATE:ScanScenery(radius) end

---Scan/find STATICS within a certain radius around the coordinate using the world.searchObjects() DCS API function.
---
------
---@param self COORDINATE 
---@param radius? number (Optional) Scan radius in meters. Default 100 m.
---@return SET_UNIT #Set of units.
function COORDINATE:ScanStatics(radius) end

---Scan/find UNITS within a certain radius around the coordinate using the world.searchObjects() DCS API function.
---
------
---@param self COORDINATE 
---@param radius? number (Optional) Scan radius in meters. Default 100 m.
---@return SET_UNIT #Set of units.
function COORDINATE:ScanUnits(radius) end

---Set the altitude of the COORDINATE.
---
------
---@param self COORDINATE 
---@param Altitude number The land altitude. If nothing (nil) is given, then the current land altitude is set.
---@return COORDINATE #
function COORDINATE:SetAlt(Altitude) end

---Set altitude.
---
------
---@param self COORDINATE 
---@param altitude number New altitude in meters.
---@param asl boolean Altitude above sea level. Default is above ground level.
---@return COORDINATE #The COORDINATE with adjusted altitude.
function COORDINATE:SetAltitude(altitude, asl) end

---Set altitude to be at land height (i.e.
---on the ground!)
---
------
---@param self COORDINATE 
function COORDINATE:SetAtLandheight() end

---Set the heading of the coordinate, if applicable.
---
------
---@param self COORDINATE 
---@param Heading number 
function COORDINATE:SetHeading(Heading) end

---Set the Lat(itude) coordinate of the COORDINATE (ie: COORDINATE.x).
---
------
---@param self COORDINATE 
---@param x number The x coordinate.
---@return COORDINATE #
function COORDINATE:SetLat(x) end

---Set the Lon(gitude) coordinate of the COORDINATE (ie: COORDINATE.z).
---
------
---@param self COORDINATE 
---@param z number The z coordinate.
---@return COORDINATE #
function COORDINATE:SetLon(z) end

---Set the offset direction when using `COORDINATE:Smoke()`.
---
------
---@param self COORDINATE 
---@param Direction? number (Optional) This is the direction of the offset, 1-359 (degrees). Default random.
---@return COORDINATE #self
function COORDINATE:SetSmokeOffsetDirection(Direction) end

---Set the offset distance when using `COORDINATE:Smoke()`.
---
------
---@param self COORDINATE 
---@param Distance? number (Optional) This is the distance of the offset in meters. Default random 10-20.
---@return COORDINATE #self
function COORDINATE:SetSmokeOffsetDistance(Distance) end

---Set the velocity of the COORDINATE.
---
------
---@param self COORDINATE 
---@param Velocity string Velocity in meters per second.
function COORDINATE:SetVelocity(Velocity) end

---Set the x coordinate of the COORDINATE.
---
------
---@param self COORDINATE 
---@param x number The x coordinate.
---@return COORDINATE #
function COORDINATE:SetX(x) end

---Set the y coordinate of the COORDINATE.
---
------
---@param self COORDINATE 
---@param y number The y coordinate.
---@return COORDINATE #
function COORDINATE:SetY(y) end

---Set the z coordinate of the COORDINATE.
---
------
---@param self COORDINATE 
---@param z number The z coordinate.
---@return COORDINATE #
function COORDINATE:SetZ(z) end

---Create colored smoke the point.
---The smoke we last up to 5 min (DCS limitation) but you can optionally specify a shorter duration or stop it manually.
---
------
---@param self COORDINATE 
---@param SmokeColor number Color of smoke, e.g. `SMOKECOLOR.Green` for green smoke.
---@param Duration? number (Optional) Duration of the smoke in seconds. DCS stopps the smoke automatically after 5 min.
---@param Delay? number (Optional) Delay before the smoke is started in seconds.
---@param Name? string (Optional) Name if you want to stop the smoke early (normal duration: 5mins)
---@param Offset? boolean (Optional) If true, offset the smokle a bit.
---@param Direction? number (Optional) If Offset is true this is the direction of the offset, 1-359 (degrees). Default random.
---@param Distance? number (Optional) If Offset is true this is the distance of the offset in meters. Default random 10-20.
---@return COORDINATE #self
function COORDINATE:Smoke(SmokeColor, Duration, Delay, Name, Offset, Direction, Distance) end

---Smoke the COORDINATE Blue.
---
------
---@param self COORDINATE 
---@param Duration? number (Optional) Duration of the smoke in seconds. DCS stopps the smoke automatically after 5 min.
---@param Delay? number (Optional) Delay before the smoke is started in seconds.
---@return COORDINATE #self
function COORDINATE:SmokeBlue(Duration, Delay) end

---Smoke the COORDINATE Green.
---
------
---@param self COORDINATE 
---@param Duration? number (Optional) Duration of the smoke in seconds. DCS stopps the smoke automatically after 5 min.
---@param Delay? number (Optional) Delay before the smoke is started in seconds.
---@return COORDINATE #self
function COORDINATE:SmokeGreen(Duration, Delay) end

---Smoke the COORDINATE Orange.
---
------
---@param self COORDINATE 
---@param Duration? number (Optional) Duration of the smoke in seconds. DCS stopps the smoke automatically after 5 min.
---@param Delay? number (Optional) Delay before the smoke is started in seconds.
---@return COORDINATE #self
function COORDINATE:SmokeOrange(Duration, Delay) end

---Smoke the COORDINATE Red.
---
------
---@param self COORDINATE 
---@param Duration? number (Optional) Duration of the smoke in seconds. DCS stopps the smoke automatically after 5 min.
---@param Delay? number (Optional) Delay before the smoke is started in seconds.
---@return COORDINATE #self
function COORDINATE:SmokeRed(Duration, Delay) end

---Smoke the COORDINATE White.
---
------
---@param self COORDINATE 
---@param Duration? number (Optional) Duration of the smoke in seconds. DCS stopps the smoke automatically after 5 min.
---@param Delay? number (Optional) Delay before the smoke is started in seconds.
---@return COORDINATE #self 
function COORDINATE:SmokeWhite(Duration, Delay) end

---Stop big smoke and fire at the coordinate.
---
------
---@param self COORDINATE 
---@param name? string (Optional) Name of the fire to stop it, if not using the same COORDINATE object.
function COORDINATE:StopBigSmokeAndFire(name) end

---Stops smoking the point in a color.
---
------
---@param self COORDINATE 
---@param name? string (Optional) Name if you want to stop the smoke early (normal duration: 5mins)
function COORDINATE:StopSmoke(name) end

---Set the offset off when using `COORDINATE:Smoke()`.
---
------
---@param self COORDINATE 
---@return COORDINATE #self
function COORDINATE:SwitchSmokeOffsetOff() end

---Set the offset on when using `COORDINATE:Smoke()`.
---
------
---@param self COORDINATE 
---@return COORDINATE #self
function COORDINATE:SwitchSmokeOffsetOn() end

---Text to all.
---Creates a text imposed on the map at the COORDINATE. Text scales with the map.
---
------
---@param self COORDINATE 
---@param Text string Text displayed on the F10 map.
---@param Coalition number Coalition: All=-1, Neutral=0, Red=1, Blue=2. Default -1=All.
---@param Color table RGB color table {r, g, b}, e.g. {1,0,0} for red (default).
---@param Alpha number Transparency [0,1]. Default 1.
---@param FillColor table RGB color table {r, g, b}, e.g. {1,0,0} for red. Default is same as `Color` value.
---@param FillAlpha number Transparency [0,1]. Default 0.3.
---@param FontSize number Font size. Default 14.
---@param ReadOnly? boolean (Optional) Mark is readonly and cannot be removed by users. Default false.
---@return number #The resulting Mark ID, which is a number. Can be used to remove the object again.
function COORDINATE:TextToAll(Text, Coalition, Color, Alpha, FillColor, FillAlpha, FontSize, ReadOnly) end

---Provides a coordinate string of the point, based on a coordinate format system:
---  * Uses default settings in COORDINATE.
---  * Can be overridden if for a GROUP containing x clients, a menu was selected to override the default.
---
------
---@param self COORDINATE 
---@param Controllable CONTROLLABLE The controllable to retrieve the settings from, otherwise the default settings will be chosen.
---@param Settings? SETTINGS (optional) The settings. Can be nil, and in this case the default settings are used. If you want to specify your own settings, use the _SETTINGS object.
---@return string #The coordinate Text in the configured coordinate system.
function COORDINATE:ToString(Controllable, Settings) end

---Provides a coordinate string of the point, based on the A2A coordinate format system.
---
------
---@param self COORDINATE 
---@param Controllable CONTROLLABLE 
---@param Settings? SETTINGS (optional) The settings. Can be nil, and in this case the default settings are used. If you want to specify your own settings, use the _SETTINGS object.
---@param MagVar boolean If true, also get angle in MagVar for BR/BRA
---@return string #The coordinate Text in the configured coordinate system.
function COORDINATE:ToStringA2A(Controllable, Settings, MagVar) end

---Provides a coordinate string of the point, based on the A2G coordinate format system.
---
------
---@param self COORDINATE 
---@param Controllable CONTROLLABLE 
---@param Settings? SETTINGS (optional) The settings. Can be nil, and in this case the default settings are used. If you want to specify your own settings, use the _SETTINGS object.
---@param MagVar boolean If true, also get angle in MagVar for BR/BRA
---@return string #The coordinate Text in the configured coordinate system.
function COORDINATE:ToStringA2G(Controllable, Settings, MagVar) end

---Return an aspect string from a COORDINATE to the Angle of the object.
---
------
---@param self COORDINATE 
---@param TargetCoordinate COORDINATE The target COORDINATE.
---@return string #The Aspect string, which is Hot, Cold or Flanking.
function COORDINATE:ToStringAspect(TargetCoordinate) end

---Return a BR string from a COORDINATE to the COORDINATE.
---
------
---@param self COORDINATE 
---@param FromCoordinate COORDINATE The coordinate to measure the distance and the bearing from.
---@param Settings? SETTINGS (optional) The settings. Can be nil, and in this case the default settings are used. If you want to specify your own settings, use the _SETTINGS object.
---@param MagVar boolean If true, also get angle in MagVar for BR/BRA
---@param Precision number Rounding precision, currently full km as default (=0)
---@return string #The BR text.
function COORDINATE:ToStringBR(FromCoordinate, Settings, MagVar, Precision) end

---Return a BRA string from a COORDINATE to the COORDINATE.
---
------
---@param self COORDINATE 
---@param FromCoordinate COORDINATE The coordinate to measure the distance and the bearing from.
---@param Settings? SETTINGS (optional) The settings. Can be nil, and in this case the default settings are used. If you want to specify your own settings, use the _SETTINGS object.
---@param MagVar boolean If true, also get angle in MagVar for BR/BRA
---@return string #The BR text.
function COORDINATE:ToStringBRA(FromCoordinate, Settings, MagVar) end

---Create a BRAA NATO call string to this COORDINATE from the FromCOORDINATE.
---Note - BRA delivered if no aspect can be obtained and "Merged" if range < 3nm
---
------
---@param self COORDINATE 
---@param FromCoordinate COORDINATE The coordinate to measure the distance and the bearing from.
---@param Bogey boolean Add "Bogey" at the end if true (not yet declared hostile or friendly)
---@param Spades boolean Add "Spades" at the end if true (no IFF/VID ID yet known)
---@param SSML boolean Add SSML tags speaking aspect as 0 1 2 and "brah" instead of BRAA
---@param Angels boolean If true, altitude is e.g. "Angels 25" (i.e., a friendly plane), else "25 thousand"
---@param Zeros boolean If using SSML, be aware that Google TTS will say "oh" and not "zero" for "0"; if Zeros is set to true, "0" will be replaced with "zero"
---@return string #The BRAA text.
function COORDINATE:ToStringBRAANATO(FromCoordinate, Bogey, Spades, SSML, Angels, Zeros) end

---Return a BULLS string out of the BULLS of the coalition to the COORDINATE.
---
------
---@param self COORDINATE 
---@param Coalition coalition.side The coalition.
---@param Settings? SETTINGS (optional) The settings. Can be nil, and in this case the default settings are used. If you want to specify your own settings, use the _SETTINGS object.
---@param MagVar boolean If true, als get angle in magnetic
---@return string #The BR text.
function COORDINATE:ToStringBULLS(Coalition, Settings, MagVar) end

---Provides a coordinate string of the point, based on a coordinate format system:
---  * Uses default settings in COORDINATE.
---  * Can be overridden if for a GROUP containing x clients, a menu was selected to override the default.
---
------
---@param self COORDINATE 
---@param ReferenceCoord COORDINATE The reference coordinate.
---@param ReferenceName string The reference name.
---@param Controllable CONTROLLABLE 
---@param Settings? SETTINGS (optional) The settings. Can be nil, and in this case the default settings are used. If you want to specify your own settings, use the _SETTINGS object.
---@param MagVar boolean If true also show angle in magnetic
---@return string #The coordinate Text in the configured coordinate system.
function COORDINATE:ToStringFromRP(ReferenceCoord, ReferenceName, Controllable, Settings, MagVar) end

---Provides a coordinate string of the point, based on a coordinate format system:
---  * Uses default settings in COORDINATE.
---  * Can be overridden if for a GROUP containing x clients, a menu was selected to override the default.
---
------
---@param self COORDINATE 
---@param ReferenceCoord COORDINATE The reference coordinate.
---@param ReferenceName string The reference name.
---@param Controllable CONTROLLABLE 
---@param Settings? SETTINGS (optional) The settings. Can be nil, and in this case the default settings are used. If you want to specify your own settings, use the _SETTINGS object.
---@param MagVar boolean If true also get the angle as magnetic
---@return string #The coordinate Text in the configured coordinate system.
function COORDINATE:ToStringFromRPShort(ReferenceCoord, ReferenceName, Controllable, Settings, MagVar) end

---Get Latitude & Longitude text.
---
------
---@param self COORDINATE 
---@param Settings? SETTINGS (optional) The settings. Can be nil, and in this case the default settings are used. If you want to specify your own settings, use the _SETTINGS object.
---@return string #LLText
function COORDINATE:ToStringLL(Settings) end

---Provides a Lat Lon string in Degree Decimal Minute format.
---
------
---@param self COORDINATE 
---@param Settings? SETTINGS (optional) The settings. Can be nil, and in this case the default settings are used. If you want to specify your own settings, use the _SETTINGS object.
---@return string #The LL DDM Text
function COORDINATE:ToStringLLDDM(Settings) end

---Provides a Lat Lon string in Degree Minute Second format.
---
------
---@param self COORDINATE 
---@param Settings? SETTINGS (optional) The settings. Can be nil, and in this case the default settings are used. If you want to specify your own settings, use the _SETTINGS object.
---@return string #The LL DMS Text
function COORDINATE:ToStringLLDMS(Settings) end

---Provides a MGRS string
---
------
---@param self COORDINATE 
---@param Settings? SETTINGS (optional) The settings. Can be nil, and in this case the default settings are used. If you want to specify your own settings, use the _SETTINGS object.
---@return string #The MGRS Text
function COORDINATE:ToStringMGRS(Settings) end

---Provides a pressure string of the point, based on a measurement system:
---  * Uses default settings in COORDINATE.
---  * Can be overridden if for a GROUP containing x clients, a menu was selected to override the default.
---
------
---@param self COORDINATE 
---@param Controllable CONTROLLABLE 
---@param Settings? SETTINGS (optional) The settings. Can be nil, and in this case the default settings are used. If you want to specify your own settings, use the _SETTINGS object.
---@return string #The pressure text in the configured measurement system.
function COORDINATE:ToStringPressure(Controllable, Settings) end

---Provides a temperature string of the point, based on a measurement system:
---  * Uses default settings in COORDINATE.
---  * Can be overridden if for a GROUP containing x clients, a menu was selected to override the default.
---
------
---@param self COORDINATE 
---@param Controllable CONTROLLABLE 
---@param Settings SETTINGS 
---@return string #The temperature text in the configured measurement system.
function COORDINATE:ToStringTemperature(Controllable, Settings) end

---Provides a wind string of the point, based on a measurement system:
---  * Uses default settings in COORDINATE.
---  * Can be overridden if for a GROUP containing x clients, a menu was selected to override the default.
---
------
---@param self COORDINATE 
---@param Controllable CONTROLLABLE 
---@param Settings? SETTINGS (optional) The settings. Can be nil, and in this case the default settings are used. If you want to specify your own settings, use the _SETTINGS object.
---@return string #The wind text in the configured measurement system.
function COORDINATE:ToStringWind(Controllable, Settings) end

---Add a Distance in meters from the COORDINATE orthonormal plane, with the given angle, and calculate the new COORDINATE.
---
------
---@param self COORDINATE 
---@param Distance Distance The Distance to be added in meters.
---@param Angle Angle The Angle in degrees. Defaults to 0 if not specified (nil).
---@param Keepalt boolean If true, keep altitude of original coordinate. Default is that the new coordinate is created at the translated land height.
---@param Overwrite boolean If true, overwrite the original COORDINATE with the translated one. Otherwise, create a new COORDINATE.
---@return COORDINATE #The new calculated COORDINATE.
function COORDINATE:Translate(Distance, Angle, Keepalt, Overwrite) end

---Update x,y,z coordinates from another given COORDINATE.
---
------
---@param self COORDINATE 
---@param Coordinate COORDINATE The coordinate with the new x,y,z positions.
---@return COORDINATE #The modified COORDINATE itself.
function COORDINATE:UpdateFromCoordinate(Coordinate) end

---Update x and z coordinates from a given 2D vector.
---
------
---@param self COORDINATE 
---@param Vec2 Vec2 The 2D vector with x,y components. x is overwriting COORDINATE.x while y is overwriting COORDINATE.z.
---@return COORDINATE #The modified COORDINATE itself.
function COORDINATE:UpdateFromVec2(Vec2) end

---Update x,y,z coordinates from a given 3D vector.
---
------
---@param self COORDINATE 
---@param Vec3 Vec3 The 3D vector with x,y,z components.
---@return COORDINATE #The modified COORDINATE itself.
function COORDINATE:UpdateFromVec3(Vec3) end

---Build an air type route point.
---
------
---@param self COORDINATE 
---@param AltType COORDINATE.WaypointAltType The altitude type.
---@param Type COORDINATE.WaypointType The route point type.
---@param Action COORDINATE.WaypointAction The route point action.
---@param Speed Speed Airspeed in km/h. Default is 500 km/h.
---@param SpeedLocked boolean true means the speed is locked.
---@param airbase AIRBASE The airbase for takeoff and landing points.
---@param DCSTasks table A table of @{DCS#Task} items which are executed at the waypoint.
---@param description string A text description of the waypoint, which will be shown on the F10 map.
---@param timeReFuAr number Time in minutes the aircraft stays at the airport for ReFueling and ReArming.
---@return table #The route point.
function COORDINATE:WaypointAir(AltType, Type, Action, Speed, SpeedLocked, airbase, DCSTasks, description, timeReFuAr) end

---Build a Waypoint Air "Fly Over Point".
---
------
---@param self COORDINATE 
---@param AltType COORDINATE.WaypointAltType The altitude type.
---@param Speed Speed Airspeed in km/h.
---@return table #The route point.
function COORDINATE:WaypointAirFlyOverPoint(AltType, Speed) end

---Build a Waypoint Air "Landing".
---
------
---
---USAGE
---```
---
---   LandingZone = ZONE:New( "LandingZone" )
---   LandingCoord = LandingZone:GetCoordinate()
---   LandingWaypoint = LandingCoord:WaypointAirLanding( 60 )
---   HeliGroup:Route( { LandWaypoint }, 1 ) -- Start landing the helicopter in one second.
---```
------
---@param self COORDINATE 
---@param Speed Speed Airspeed in km/h.
---@param airbase AIRBASE The airbase for takeoff and landing points.
---@param DCSTasks table A table of @{DCS#Task} items which are executed at the waypoint.
---@param description string A text description of the waypoint, which will be shown on the F10 map.
---@return table #The route point.
function COORDINATE:WaypointAirLanding(Speed, airbase, DCSTasks, description) end

---Build a Waypoint Air "LandingReFuAr".
---Mimics the aircraft ReFueling and ReArming.
---
------
---@param self COORDINATE 
---@param Speed Speed Airspeed in km/h.
---@param airbase AIRBASE The airbase for takeoff and landing points.
---@param timeReFuAr number Time in minutes, the aircraft stays at the airbase. Default 10 min.
---@param DCSTasks table A table of @{DCS#Task} items which are executed at the waypoint.
---@param description string A text description of the waypoint, which will be shown on the F10 map.
---@return table #The route point.
function COORDINATE:WaypointAirLandingReFu(Speed, airbase, timeReFuAr, DCSTasks, description) end

---Build a Waypoint Air "Take Off Parking".
---
------
---@param self COORDINATE 
---@param AltType COORDINATE.WaypointAltType The altitude type.
---@param Speed Speed Airspeed in km/h.
---@return table #The route point.
function COORDINATE:WaypointAirTakeOffParking(AltType, Speed) end

---Build a Waypoint Air "Take Off Parking Hot".
---
------
---@param self COORDINATE 
---@param AltType COORDINATE.WaypointAltType The altitude type.
---@param Speed Speed Airspeed in km/h.
---@return table #The route point.
function COORDINATE:WaypointAirTakeOffParkingHot(AltType, Speed) end

---Build a Waypoint Air "Take Off Runway".
---
------
---@param self COORDINATE 
---@param AltType COORDINATE.WaypointAltType The altitude type.
---@param Speed Speed Airspeed in km/h.
---@return table #The route point.
function COORDINATE:WaypointAirTakeOffRunway(AltType, Speed) end

---Build a Waypoint Air "Turning Point".
---
------
---@param self COORDINATE 
---@param AltType COORDINATE.WaypointAltType The altitude type.
---@param Speed Speed Airspeed in km/h.
---@param DCSTasks? table (Optional) A table of @{DCS#Task} items which are executed at the waypoint.
---@param description? string (Optional) A text description of the waypoint, which will be shown on the F10 map.
---@return table #The route point.
function COORDINATE:WaypointAirTurningPoint(AltType, Speed, DCSTasks, description) end

---Build an ground type route point.
---
------
---@param self COORDINATE 
---@param Speed? number (Optional) Speed in km/h. The default speed is 20 km/h.
---@param Formation? string (Optional) The route point Formation, which is a text string that specifies exactly the Text in the Type of the route point, like "Vee", "Echelon Right".
---@param DCSTasks? table (Optional) A table of DCS tasks that are executed at the waypoints. Mind the curly brackets {}!
---@return table #The route point.
function COORDINATE:WaypointGround(Speed, Formation, DCSTasks) end

---Build route waypoint point for Naval units.
---
------
---@param self COORDINATE 
---@param Speed? number (Optional) Speed in km/h. The default speed is 20 km/h.
---@param Depth? string (Optional) Dive depth in meters. Only for submarines. Default is COORDINATE.y component.
---@param DCSTasks? table (Optional) A table of DCS tasks that are executed at the waypoints. Mind the curly brackets {}!
---@return table #The route point.
function COORDINATE:WaypointNaval(Speed, Depth, DCSTasks) end


---Waypoint actions.
---@class COORDINATE.WaypointAction 
---@field FlyoverPoint string Fly over point.
---@field FromGroundArea string From ground area.
---@field FromGroundAreaHot string From ground area hot.
---@field FromParkingArea string From parking area.
---@field FromParkingAreaHot string From parking area hot.
---@field FromRunway string From runway.
---@field Landing string Landing.
---@field LandingReFuAr string Landing and refuel and rearm.
---@field TurningPoint string Turning point.
COORDINATE.WaypointAction = {}


---Waypoint altitude types.
---@class COORDINATE.WaypointAltType 
---@field BARO string Barometric altitude.
---@field RADIO string Radio altitude.
COORDINATE.WaypointAltType = {}


---Waypoint types.
---@class COORDINATE.WaypointType 
---@field Land string Landing point.
---@field LandingReFuAr string Landing and refuel and rearm.
---@field TakeOff string Take off parking hot.
---@field TakeOffGround string 
---@field TakeOffGroundHot string Take of from ground hot.
---@field TakeOffParking string Take of parking.
---@field TakeOffParkingHot string Take of parking hot.
---@field TurningPoint string Turning point.
COORDINATE.WaypointType = {}


---Defines a 2D point in the simulator.
---The height coordinate (if needed) will be the land height + an optional added height specified.
---
--- **DEPRECATED - PLEASE USE COORDINATE!**
---
---## POINT_VEC2 constructor
---
---A new POINT_VEC2 instance can be created with:
---
--- * Core.Point#POINT_VEC2.New(): a 2D point, taking an additional height parameter.
--- * Core.Point#POINT_VEC2.NewFromVec2(): a 2D point created from a DCS#Vec2.
---
---## Manupulate the X, Altitude, Y coordinates of the 2D point
---
---A POINT_VEC2 class works in 2D space, with an altitude setting. It contains internally an X, Altitude, Y coordinate.
---Methods exist to manupulate these coordinates.
---
---The current X, Altitude, Y axis can be retrieved with the methods #POINT_VEC2.GetX(), #POINT_VEC2.GetAlt(), #POINT_VEC2.GetY() respectively.
---The methods #POINT_VEC2.SetX(), #POINT_VEC2.SetAlt(), #POINT_VEC2.SetY() change the respective axis with a new value.
---The current Lat(itude), Alt(itude), Lon(gitude) values can also be retrieved with the methods #POINT_VEC2.GetLat(), #POINT_VEC2.GetAlt(), #POINT_VEC2.GetLon() respectively.
---The current axis values can be changed by using the methods #POINT_VEC2.AddX(), #POINT_VEC2.AddAlt(), #POINT_VEC2.AddY()
---to add or substract a value from the current respective axis value.
---Note that the Set and Add methods return the current POINT_VEC2 object, so these manipulation methods can be chained... For example:
---
---     local Vec2 = PointVec2:AddX( 100 ):AddY( 2000 ):GetVec2()
---@deprecated
---@class POINT_VEC2 : COORDINATE
---@field private x Distance The x coordinate in meters.
---@field private y Distance the y coordinate in meters.
POINT_VEC2 = {}

---POINT_VEC2 constructor.
---
------
---@param self POINT_VEC2 
---@param x Distance The x coordinate of the Vec3 point, pointing to the North.
---@param y Distance The y coordinate of the Vec3 point, pointing to the Right.
---@param LandHeightAdd? Distance (optional) The default height if required to be evaluated will be the land height of the x, y coordinate. You can specify an extra height to be added to the land height.
---@return POINT_VEC2 #
function POINT_VEC2:New(x, y, LandHeightAdd) end


---Defines a 3D point in the simulator and with its methods, you can use or manipulate the point in 3D space.
---
---**DEPRECATED - PLEASE USE COORDINATE!**
---
---**Important Note:** Most of the functions in this section were taken from MIST, and reworked to OO concepts.
---In order to keep the credibility of the the author,
---I want to emphasize that the formulas embedded in the MIST framework were created by Grimes or previous authors,
---who you can find on the Eagle Dynamics Forums.
---
---
---## POINT_VEC3 constructor
---
---A new POINT_VEC3 object can be created with:
---
--- * #POINT_VEC3.New(): a 3D point.
--- * #POINT_VEC3.NewFromVec3(): a 3D point created from a DCS#Vec3.
---
---
---## Manupulate the X, Y, Z coordinates of the POINT_VEC3
---
---A POINT_VEC3 class works in 3D space. It contains internally an X, Y, Z coordinate.
---Methods exist to manupulate these coordinates.
---
---The current X, Y, Z axis can be retrieved with the methods #POINT_VEC3.GetX(), #POINT_VEC3.GetY(), #POINT_VEC3.GetZ() respectively.
---The methods #POINT_VEC3.SetX(), #POINT_VEC3.SetY(), #POINT_VEC3.SetZ() change the respective axis with a new value.
---The current axis values can be changed by using the methods #POINT_VEC3.AddX(), #POINT_VEC3.AddY(), #POINT_VEC3.AddZ()
---to add or substract a value from the current respective axis value.
---Note that the Set and Add methods return the current POINT_VEC3 object, so these manipulation methods can be chained... For example:
---
---     local Vec3 = PointVec3:AddX( 100 ):AddZ( 150 ):GetVec3()
---
---
---## 3D calculation methods
---
---Various calculation methods exist to use or manipulate 3D space. Find below a short description of each method:
---
---
---## Point Randomization
---
---Various methods exist to calculate random locations around a given 3D point.
---
---  * #POINT_VEC3.GetRandomPointVec3InRadius(): Provides a random 3D point around the current 3D point, in the given inner to outer band.
---The POINT_VEC3 class
---@deprecated
---@class POINT_VEC3 : COORDINATE
---@field FlareColor FLARECOLOR 
---@field RoutePointAction POINT_VEC3.RoutePointAction 
---@field RoutePointAltType POINT_VEC3.RoutePointAltType 
---@field RoutePointType POINT_VEC3.RoutePointType 
---@field SmokeColor SMOKECOLOR 
---@field private x number The x coordinate in 3D space.
---@field private y number The y coordinate in 3D space.
---@field private z number The z COORDINATE in 3D space.
POINT_VEC3 = {}

---Create a new POINT_VEC3 object.
---
------
---@param self POINT_VEC3 
---@param x Distance The x coordinate of the Vec3 point, pointing to the North.
---@param y Distance The y coordinate of the Vec3 point, pointing Upwards.
---@param z Distance The z coordinate of the Vec3 point, pointing to the Right.
---@return POINT_VEC3 #
function POINT_VEC3:New(x, y, z) end


---RoutePoint Actions
---@class POINT_VEC3.RoutePointAction 
POINT_VEC3.RoutePointAction = {}


---RoutePoint AltTypes
---@class POINT_VEC3.RoutePointAltType 
POINT_VEC3.RoutePointAltType = {}


---RoutePoint Types
---@class POINT_VEC3.RoutePointType 
POINT_VEC3.RoutePointType = {}



