---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/CORE_Pathline.png" width="100%">
---
---**Shapes** - Class that serves as the base shapes drawn in the Mission Editor
---
---
---### Author: **nielsvaes/coconutcockpit**
---
---===
---*I'm in love with the shape of you -- Ed Sheeran
---
---===
---
---# SHAPE_BASE
---The class serves as the base class to deal with these shapes using MOOSE.
---You should never use this class on its own,
---rather use:
---     CIRCLE
---     LINE
---     OVAL
---     POLYGON
---     TRIANGLE (although this one's a bit special as well)
---
---===
---The idea is that anything you draw on the map in the Mission Editor can be turned in a shape to work with in MOOSE.
---This is the base class that all other shape classes are built on. There are some shared functions, most of which are overridden in the derived classes
---SHAPE_BASE class.
---@class SHAPE_BASE : BASE
---@field CenterVec2 table Vec2 of the center of the shape, this will be assigned automatically
---@field ClassName string Name of the class.
---@field Coords table List of COORDINATE defining the path, this will be assigned automatically
---@field MarkIDs table List any MARKIDs this class use, this will be assigned automatically
---@field Name string Name of the shape
---@field Points table List of 3D points defining the shape, this will be assigned automatically
SHAPE_BASE = {}

---Checks if all units of a group are contained within the shape.
---
------
---@param self NOTYPE 
---@return bool #True if all units of the group are contained, false otherwise
function SHAPE_BASE.ContainsAllOfGroup(group_name, self) end

---Checks if any unit of a group is contained within the shape.
---
------
---@param self NOTYPE 
---@return bool #True if any unit of the group is contained, false otherwise
function SHAPE_BASE.ContainsAnyOfGroup(group_name, self) end

---Checks if a point is contained within the shape.
---
------
---@param self NOTYPE 
---@return bool #True if the point is contained, false otherwise
function SHAPE_BASE.ContainsPoint(_, self) end

---Checks if a unit is contained within the shape.
---
------
---@param self NOTYPE 
---@return bool #True if the unit is contained, false otherwise
function SHAPE_BASE.ContainsUnit(unit_name, self) end

---Finds a shape on the map by its name.
---
------
---@param self NOTYPE 
---@return SHAPE_BASE #The found shape
function SHAPE_BASE.FindOnMap(shape_name, self) end


---
------
---@param filter NOTYPE 
function SHAPE_BASE:GetAllShapes(filter) end

---Gets the center coordinate of the shape.
---
------
---@return COORDINATE #The center coordinate
function SHAPE_BASE:GetCenterCoordinate() end

---Gets the center position of the shape.
---
------
---@return table #The center position
function SHAPE_BASE:GetCenterVec2() end


---
------
function SHAPE_BASE:GetColorAlpha() end


---
------
function SHAPE_BASE:GetColorBlue() end


---
------
function SHAPE_BASE:GetColorGreen() end


---
------
function SHAPE_BASE:GetColorRGBA() end


---
------
function SHAPE_BASE:GetColorRed() end


---
------
function SHAPE_BASE:GetColorString() end

---Gets the coordinate of the shape.
---
------
---@return COORDINATE #The coordinate
function SHAPE_BASE:GetCoordinate() end

---Gets the name of the shape.
---
------
---@return string #The name of the shape
function SHAPE_BASE:GetName() end

---Creates a new instance of SHAPE_BASE.
---
------
---@return SHAPE_BASE #The new instance
function SHAPE_BASE:New() end

---Offsets the shape to a new position.
---
------
---@param self NOTYPE 
function SHAPE_BASE.Offset(new_vec2, self) end



