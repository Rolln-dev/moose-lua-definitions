---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/MOOSE.JPG" width="100%">
---
---TRIANGLE class with properties and methods for handling triangles.
---This class is mostly used by the POLYGON class, but you can use it on its own as well
---
---### Author: **nielsvaes/coconutcockpit**
---
---
---===
---LINE class.
---@class CUBE 
---@field ClassName string Name of the class.
---@field Coords number coordinates of the line
---@field Points number points of the line
CUBE = {}


---@class TRIANGLE 
TRIANGLE = {}

---Checks if a point is contained within the triangle.
---
------
---@param points? table (optional) The points of the triangle, or 3 other points if you're just using the TRIANGLE class without an object of it
---@param self NOTYPE 
---@return bool #True if the point is contained, false otherwise
function TRIANGLE.ContainsPoint(pt, points, self) end


---
------
function TRIANGLE:Draw() end

---Returns a random Vec2 within the triangle.
---
------
---@param self NOTYPE 
---@return table #The random Vec2
function TRIANGLE.GetRandomVec2(points, self) end

---Creates a new triangle from three points.
---The points need to be given as Vec2s
---
------
---@param p2 table The second point of the triangle
---@param p3 table The third point of the triangle
---@param self NOTYPE 
---@return TRIANGLE #The new triangle
function TRIANGLE.New(p1, p2, p3, self) end


---
------
function TRIANGLE:RemoveDraw() end



