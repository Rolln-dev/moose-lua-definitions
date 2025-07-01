---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/CORE_Pathline.png" width="100%">
---
---**Core** - Path from A to B.
---
---**Main Features:**
---
---   * Path from A to B
---   * Arbitrary number of points
---   * Automatically from lines drawtool
---
---===
---
---### Author: **funkyfranky**
---
---===
---*The shortest distance between two points is a straight line.* -- Archimedes
---
---===
---
---# The PATHLINE Concept
---
---List of points defining a path from A to B.
---The pathline can consist of multiple points. Each point holds the information of its position, the surface type, the land height
---and the water depth (if over sea).
---
---Line drawings created in the mission editor are automatically registered as pathlines and stored in the MOOSE database.
---They can be accessed with the #PATHLINE.FindByName) function.
---
---# Constructor
---
---The @{PATHLINE.New) function creates a new PATHLINE object. This does not hold any points. Points can be added with the @{#PATHLINE.AddPointFromVec2 and #PATHLINE.AddPointFromVec3
---
---For a given table of 2D or 3D positions, a new PATHLINE object can be created with the #PATHLINE.NewFromVec2Array or #PATHLINE.NewFromVec3Array, respectively.
---
---# Line Drawings
---
---The most convenient way to create a pathline is the draw panel feature in the DCS mission editor. You can select "Line" and then "Segments", "Segment" or "Free" to draw your lines.
---These line drawings are then automatically added to the MOOSE database as PATHLINE objects and can be retrieved with the #PATHLINE.FindByName) function, where the name is the one
---you specify in the draw panel.
---
---# Mark on F10 map
---
---The ponints of the PATHLINE can be marked on the F10 map with the @{#PATHLINE.MarkPoints(`true`) function. The mark points contain information of the surface type, land height and 
---water depth.
---
---To remove the marks, use #PATHLINE.MarkPoints(`false`).
---PATHLINE class.
---@class PATHLINE : BASE
---@field ClassName string Name of the class.
---@field private lid string Class id string for output to DCS log file.
---@field private name string Name of the path line.
---@field private points table List of 3D points defining the path.
---@field private version string PATHLINE class version.
PATHLINE = {}

---Add a point to the path from a given 2D position.
---The third dimension is determined from the land height.
---
------
---@param self PATHLINE 
---@param Vec2 Vec2 The 2D vector (x,y) to add.
---@return PATHLINE #self
function PATHLINE:AddPointFromVec2(Vec2) end

---Add a point to the path from a given 3D position.
---
------
---@param self PATHLINE 
---@param Vec3 Vec3 The 3D vector (x,y) to add.
---@return PATHLINE #self
function PATHLINE:AddPointFromVec3(Vec3) end

---Find a pathline in the database.
---
------
---@param self PATHLINE 
---@param Name string The name of the pathline.
---@return PATHLINE #self
function PATHLINE:FindByName(Name) end

---Get COORDINATES of pathline.
---Note that COORDINATE objects are created when calling this function. That does involve deep copy calls and can have an impact on performance if done too often.
---
------
---@param self PATHLINE 
---@return  #<Core.Point#COORDINATE> List of COORDINATES points.
function PATHLINE:GetCoordinates() end

---Get name of pathline.
---
------
---@param self PATHLINE 
---@return string #Name of the pathline.
function PATHLINE:GetName() end

---Get number of points.
---
------
---@param self PATHLINE 
---@return number #Number of points.
function PATHLINE:GetNumberOfPoints() end

---Get the 2D position of the n-th point.
---
------
---@param self PATHLINE 
---@param n number The n-th point.
---@return VEC2 #Position in 3D.
function PATHLINE:GetPoint2DFromIndex(n) end

---Get the 3D position of the n-th point.
---
------
---@param self PATHLINE 
---@param n number The n-th point.
---@return VEC3 #Position in 3D.
function PATHLINE:GetPoint3DFromIndex(n) end

---Get the n-th point of the pathline.
---
------
---@param self PATHLINE 
---@param n number The index of the point. Default is the first point.
---@return PATHLINE.Point #Point.
function PATHLINE:GetPointFromIndex(n) end

---Get points of pathline.
---Not that points are tables, that contain more information as just the 2D or 3D position but also the surface type etc.
---
------
---@param self PATHLINE 
---@return list #List of points.
function PATHLINE:GetPoints() end

---Get 2D points of pathline.
---
------
---@param self PATHLINE 
---@return  #<DCS#Vec2> List of DCS#Vec2 points.
function PATHLINE:GetPoints2D() end

---Get 3D points of pathline.
---
------
---@param self PATHLINE 
---@return  #<DCS#Vec3> List of DCS#Vec3 points.
function PATHLINE:GetPoints3D() end

---Mark points on F10 map.
---
------
---@param self PATHLINE 
---@param Switch boolean If `true` or nil, set marks. If `false`, remove marks.
---@return  #<DCS#Vec3> List of DCS#Vec3 points.
function PATHLINE:MarkPoints(Switch) end

---Create a new PATHLINE object.
---Points need to be added later.
---
------
---@param self PATHLINE 
---@param Name string Name of the path.
---@return PATHLINE #self
function PATHLINE:New(Name) end

---Create a new PATHLINE object from a given list of 2D points.
---
------
---@param self PATHLINE 
---@param Name string Name of the pathline.
---@param Vec2Array table List of DCS#Vec2 points.
---@return PATHLINE #self
function PATHLINE:NewFromVec2Array(Name, Vec2Array) end

---Create a new PATHLINE object from a given list of 3D points.
---
------
---@param self PATHLINE 
---@param Name string Name of the pathline.
---@param Vec3Array table List of DCS#Vec3 points.
---@return PATHLINE #self
function PATHLINE:NewFromVec3Array(Name, Vec3Array) end

---Get 3D points of pathline.
---
------
---@param self PATHLINE 
---@param Vec Vec3 Position vector. Can also be a DCS#Vec2 in which case the altitude at landheight is taken.
---@return PATHLINE.Point #
function PATHLINE:_CreatePoint(Vec) end


---Point of line.
---@class PATHLINE.Point 
---@field private depth number Water depth in meters.
---@field private landHeight number Land height in meters.
---@field private markerID number Marker ID.
---@field private surfaceType number Surface type.
---@field private vec2 Vec2 2D position.
---@field private vec3 Vec3 3D position.
PATHLINE.Point = {}



