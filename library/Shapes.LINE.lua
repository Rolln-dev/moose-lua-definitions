---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/MOOSE.JPG" width="100%">
---
---
---### Author: **nielsvaes/coconutcockpit**
---
---===
---LINE class.
---@class LINE 
---@field ClassName string Name of the class.
---@field Coords number coordinates of the line
---@field Points number points of the line
LINE = {}

---Gets the coordinates of the line.
---
------
---@param self NOTYPE 
---@return table #The coordinates of the line
function LINE:Coordinates() end

---Draws the line on the map.
---
------
---@param points table The points of the line
---@param self NOTYPE 
function LINE.Draw(points, self) end

---Finds a line by its name in the database.
---
------
---@param shape_name string Name of the line to find
---@param self NOTYPE 
---@return LINE #The found line, or nil if not found
function LINE.Find(shape_name, self) end

---Finds a line on the map by its name.
---The line must be drawn in the Mission Editor
---
------
---@param line_name string Name of the line to find
---@param self NOTYPE 
---@return LINE #The found line, or nil if not found
function LINE.FindOnMap(line_name, self) end

---Calculates the bounding box of the line.
---The bounding box is the smallest rectangle that contains the line.
---
------
---@param self NOTYPE 
---@return table #The bounding box of the line
function LINE:GetBoundingBox() end

---Gets a number of points in between the start and end points of the line.
---
------
---@param amount number The number of points to get
---@param start_point table (Optional) The start point of the line, defaults to the object's start point
---@param end_point table (Optional) The end point of the line, defaults to the object's end point
---@param self NOTYPE 
---@return table #The points
function LINE.GetCoordinatesInBetween(amount, start_point, end_point, self) end

---Gets the end coordinate of the line.
---The end coordinate is the last point of the line.
---
------
---@param self NOTYPE 
---@return COORDINATE #The end coordinate of the line
function LINE:GetEndCoordinate() end

---Gets the end point of the line.
---The end point is the last point of the line.
---
------
---@param self NOTYPE 
---@return table #The end point of the line
function LINE:GetEndPoint() end

---Gets the heading of the line.
---
------
---@param points table (optional) The points of the line or 2 other points if you're just using the LINE class without an object of it
---@param self NOTYPE 
---@return number #The heading of the line
function LINE.GetHeading(points, self) end

---Return each part of the line as a new line
---
------
---@param self NOTYPE 
---@return table #The points
function LINE:GetIndividualParts() end

---Gets the length of the line.
---
------
---@param self NOTYPE 
---@return number #The length of the line
function LINE:GetLength() end

---Gets a number of points on a sine wave between the start and end points of the line.
---
------
---@param amount number The number of points to get
---@param start_point table (Optional) The start point of the line, defaults to the object's start point
---@param end_point table (Optional) The end point of the line, defaults to the object's end point
---@param frequency number (Optional) The frequency of the sine wave, default 1
---@param phase number (Optional) The phase of the sine wave, default 0
---@param amplitude number (Optional) The amplitude of the sine wave, default 100
---@param self NOTYPE 
---@return table #The points
function LINE.GetPointsBetweenAsSineWave(amount, start_point, end_point, frequency, phase, amplitude, self) end

---Gets a number of points in between the start and end points of the line.
---
------
---@param amount number The number of points to get
---@param start_point table (Optional) The start point of the line, defaults to the object's start point
---@param end_point table (Optional) The end point of the line, defaults to the object's end point
---@param self NOTYPE 
---@return table #The points
function LINE.GetPointsInbetween(amount, start_point, end_point, self) end


---
------
---@param self NOTYPE 
---@param start_point NOTYPE 
---@param end_point NOTYPE 
function LINE:GetRandomCoordinate(start_point, end_point) end

---Returns a random point on the line.
---
------
---@param points table (optional) The points of the line or 2 other points if you're just using the LINE class without an object of it
---@param self NOTYPE 
---@return table #The random point
function LINE.GetRandomPoint(points, self) end

---Gets the start coordinate of the line.
---The start coordinate is the first point of the line.
---
------
---@param self NOTYPE 
---@return COORDINATE #The start coordinate of the line
function LINE:GetStartCoordinate() end

---Gets the start point of the line.
---The start point is the first point of the line.
---
------
---@param self NOTYPE 
---@return table #The start point of the line
function LINE:GetStartPoint() end

---Creates a new line from two points.
---
------
---@param vec2 table The first point of the line
---@param radius number The second point of the line
---@param self NOTYPE 
---@param ... NOTYPE 
---@return LINE #The new line
function LINE.New(vec2, radius, self, ...) end

---Creates a new line from a circle.
---
------
---@param center_point table center point of the circle
---@param radius number radius of the circle, half length of the line
---@param angle_degrees number degrees the line will form from center point
---@param self NOTYPE 
---@return LINE #The new line
function LINE.NewFromCircle(center_point, radius, angle_degrees, self) end


---
------
---@param self NOTYPE 
function LINE:RemoveDraw() end



