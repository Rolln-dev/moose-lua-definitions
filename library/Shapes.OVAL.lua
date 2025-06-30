---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/MOOSE.JPG" width="100%">
---
---
---### Author: **nielsvaes/coconutcockpit**
---
---===
---OVAL class with properties and methods for handling ovals.
---OVAL class.
---@class OVAL 
---@field Angle number The angle the oval is rotated on
---@field ClassName string Name of the class.
---@field MajorAxis number The major axis (radius) of the oval
---@field MinorAxis number The minor axis (radius) of the oval
OVAL = {}

---Checks if a point is contained within the oval.
---
------
---@param point table The point to check
---@param self NOTYPE 
---@return bool #True if the point is contained, false otherwise
function OVAL.ContainsPoint(point, self) end

---Draws the oval on the map, for debugging
---
------
---@param angle number (Optional) The angle of the oval. If nil will use self.Angle
---@param self NOTYPE 
function OVAL.Draw(angle, self) end

---Finds an oval by its name in the database.
---
------
---@param shape_name string Name of the oval to find
---@param self NOTYPE 
---@return OVAL #The found oval, or nil if not found
function OVAL.Find(shape_name, self) end

---Finds an oval on the map by its name.
---The oval must be drawn on the map.
---
------
---@param shape_name string Name of the oval to find
---@param self NOTYPE 
---@return OVAL #The found oval, or nil if not found
function OVAL.FindOnMap(shape_name, self) end

---Gets the angle of the oval.
---
------
---@param self NOTYPE 
---@return number #The angle of the oval
function OVAL:GetAngle() end

---Calculates the bounding box of the oval.
---The bounding box is the smallest rectangle that contains the oval.
---
------
---@param self NOTYPE 
---@return table #The bounding box of the oval
function OVAL:GetBoundingBox() end

---Gets the major axis of the oval.
---
------
---@param self NOTYPE 
---@return number #The major axis of the oval
function OVAL:GetMajorAxis() end

---Gets the minor axis of the oval.
---
------
---@param self NOTYPE 
---@return number #The minor axis of the oval
function OVAL:GetMinorAxis() end

---Returns a random Vec2 within the oval.
---
------
---@param self NOTYPE 
---@return table #The random Vec2
function OVAL:GetRandomVec2() end

---Creates a new oval from a center point, major axis, minor axis, and angle.
---
------
---@param vec2 table The center point of the oval
---@param major_axis number The major axis of the oval
---@param minor_axis number The minor axis of the oval
---@param angle number The angle of the oval
---@param self NOTYPE 
---@return OVAL #The new oval
function OVAL.New(vec2, major_axis, minor_axis, angle, self) end


---
------
---@param self NOTYPE 
---@param num_points NOTYPE 
function OVAL:PointsOnEdge(num_points) end


---
------
---@param self NOTYPE 
function OVAL:RemoveDraw() end

---Sets the angle of the oval.
---
------
---@param value number The new angle
---@param self NOTYPE 
function OVAL.SetAngle(value, self) end

---Sets the major axis of the oval.
---
------
---@param value number The new major axis
---@param self NOTYPE 
function OVAL.SetMajorAxis(value, self) end

---Sets the minor axis of the oval.
---
------
---@param value number The new minor axis
---@param self NOTYPE 
function OVAL.SetMinorAxis(value, self) end



