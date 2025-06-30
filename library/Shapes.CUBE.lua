---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/MOOSE.JPG" width="100%">
---
---
---### Author: **nielsvaes/coconutcockpit**
---
---===
---LINE class.
---@class CUBE 
---@field ClassName string Name of the class.
---@field Coords number coordinates of the line
---@field Points number points of the line
CUBE = {}


---
------
---@param self NOTYPE 
---@param point NOTYPE 
---@param cube_points NOTYPE 
function CUBE:ContainsPoint(point, cube_points) end


---
------
---@param self NOTYPE 
function CUBE:GetCenter() end


---
------
---@param self NOTYPE 
---@param p1 NOTYPE 
---@param p2 NOTYPE 
---@param p3 NOTYPE 
---@param p4 NOTYPE 
---@param p5 NOTYPE 
---@param p6 NOTYPE 
---@param p7 NOTYPE 
---@param p8 NOTYPE 
function CUBE:New(p1, p2, p3, p4, p5, p6, p7, p8) end



