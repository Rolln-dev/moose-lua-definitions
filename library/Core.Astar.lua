---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/CORE_Astar.png" width="100%">
---
---**Core** - A* Pathfinding.
---
---**Main Features:**
---
---   * Find path from A to B.
---   * Pre-defined as well as custom valid neighbour functions.
---   * Pre-defined as well as custom cost functions.
---   * Easy rectangular grid setup.
---
---===
---
---### Author: **funkyfranky**
---
---===
---*When nothing goes right...
---Go left!*
---
---===
---
---# The ASTAR Concept
---
---Pathfinding algorithm.
---
---
---# Start and Goal
---
---The first thing we need to define is obviously the place where we want to start and where we want to go eventually.
---
---## Start
---
---The start
---
---## Goal 
---
---
---# Nodes
---
---## Rectangular Grid
---
---A rectangular grid can be created using the #ASTAR.CreateGrid(*ValidSurfaceTypes, BoxHY, SpaceX, deltaX, deltaY, MarkGrid*), where
---
---* *ValidSurfaceTypes* is a table of valid surface types. By default all surface types are valid.
---* *BoxXY* is the width of the grid perpendicular the the line between start and end node. Default is 40,000 meters (40 km).
---* *SpaceX* is the additional space behind the start and end nodes. Default is 20,000 meters (20 km).
---* *deltaX* is the grid spacing between nodes in the direction of start and end node. Default is 2,000 meters (2 km).
---* *deltaY* is the grid spacing perpendicular to the direction of start and end node. Default is the same as *deltaX*.
---* *MarkGrid* If set to *true*, this places marker on the F10 map on each grid node. Note that this can stall DCS if too many nodes are created. 
---
---## Valid Surfaces
---
---Certain unit types can only travel on certain surfaces types, for example
---
---* Naval units can only travel on water (that also excludes shallow water in DCS currently),
---* Ground units can only traval on land.
---
---By restricting the surface type in the grid construction, we also reduce the number of nodes, which makes the algorithm more efficient.
---
---## Box Width (BoxHY)
---
---The box width needs to be large enough to capture all paths you want to consider.
---
---## Space in X
---
---The space in X value is important if the algorithm needs to to backwards from the start node or needs to extend even further than the end node.
---
---## Grid Spacing
---
---The grid spacing is an important factor as it determines the number of nodes and hence the performance of the algorithm. It should be as large as possible.
---However, if the value is too large, the algorithm might fail to get a valid path.
---
---A good estimate of the grid spacing is to set it to be smaller (~ half the size) of the smallest gap you need to path.
---
---# Valid Neighbours
---
---The A* algorithm needs to know if a transition from one node to another is allowed or not. By default, hopping from one node to another is always possible.
---
---## Line of Sight
---
---For naval
--- 
---
---# Heuristic Cost
---
---In order to determine the optimal path, the pathfinding algorithm needs to know, how costly it is to go from one node to another.
---Often, this can simply be determined by the distance between two nodes. Therefore, the default cost function is set to be the 2D distance between two nodes.
---
---
---# Calculate the Path
---
---Finally, we have to calculate the path. This is done by the #GetPath(*ExcludeStart, ExcludeEnd*) function. This function returns a table of nodes, which
---describe the optimal path from the start node to the end node.
---
---By default, the start and end node are include in the table that is returned.
---
---Note that a valid path must not always exist. So you should check if the function returns *nil*.
---
---Common reasons that a path cannot be found are:
---
---* The grid is too small ==> increase grid size, e.g. *BoxHY* and/or *SpaceX* if you use a rectangular grid.  
---* The grid spacing is too large ==> decrease *deltaX* and/or *deltaY*
---* There simply is no valid path ==> you are screwed :(
---
---
---# Examples
---
---## Strait of Hormuz
---
---Carrier Group finds its way through the Stait of Hormuz.
---
---## 
---
---ASTAR class.
---@class ASTAR : BASE
---@field ClassName string Name of the class.
---@field CostArg table Optional arguments passed to the cost function. 
---@field CostFunc function Function to calculate the heuristic "cost" to go from one node to another.
---@field Debug boolean Debug mode. Messages to all about status.
---@field INF number ASTAR infinity.
---@field Nnodes number Number of nodes.
---@field ValidNeighbourArg table Optional arguments passed to the valid neighbour function.
---@field ValidNeighbourFunc function Function to check if a node is valid.
---@field private counter number Node counter.
---@field private endCoord COORDINATE End coordinate.
---@field private endNode ASTAR.Node End node.
---@field private lid string Class id string for output to DCS log file.
---@field private ncost number Number of cost evaluations.
---@field private ncostcache number Number of cached cost evals.
---@field private nodes table Table of nodes.
---@field private nvalid number Number of nvalid calls.
---@field private nvalidcache number Number of cached valid evals.
---@field private startCoord COORDINATE Start coordinate.
---@field private startNode ASTAR.Node Start node.
---@field private version string ASTAR class version.
ASTAR = {}

---Add a node to the table of grid nodes.
---
------
---@param self ASTAR 
---@param Node ASTAR.Node The node to be added.
---@return ASTAR #self
function ASTAR:AddNode(Node) end

---Add a node to the table of grid nodes specifying its coordinate.
---
------
---@param self ASTAR 
---@param Coordinate COORDINATE The coordinate where the node is created.
---@return ASTAR.Node #The node.
function ASTAR:AddNodeFromCoordinate(Coordinate) end

---Check if the coordinate of a node has is at a valid surface type.
---
------
---@param self ASTAR 
---@param Node ASTAR.Node The node to be added.
---@param SurfaceTypes table Surface types, for example `{land.SurfaceType.WATER}`. By default all surface types are valid.
---@return boolean #If true, surface type of node is valid.
function ASTAR:CheckValidSurfaceType(Node, SurfaceTypes) end

---Create a rectangular grid of nodes between star and end coordinate.
---The coordinate system is oriented along the line between start and end point.
---
------
---@param self ASTAR 
---@param ValidSurfaceTypes table Valid surface types. By default is all surfaces are allowed.
---@param BoxHY number Box "height" in meters along the y-coordinate. Default 40000 meters (40 km).
---@param SpaceX number Additional space in meters before start and after end coordinate. Default 10000 meters (10 km).
---@param deltaX number Increment in the direction of start to end coordinate in meters. Default 2000 meters.
---@param deltaY number Increment perpendicular to the direction of start to end coordinate in meters. Default is same as deltaX.
---@param MarkGrid boolean If true, create F10 map markers at grid nodes.
---@return ASTAR #self
function ASTAR:CreateGrid(ValidSurfaceTypes, BoxHY, SpaceX, deltaX, deltaY, MarkGrid) end

---Heuristic cost is given by the 2D distance between the nodes.
---
------
---@param nodeA ASTAR.Node First node.
---@param nodeB ASTAR.Node Other node.
---@return number #Distance between the two nodes.
function ASTAR.Dist2D(nodeA, nodeB) end

---Heuristic cost is given by the 3D distance between the nodes.
---
------
---@param nodeA ASTAR.Node First node.
---@param nodeB ASTAR.Node Other node.
---@return number #Distance between the two nodes.
function ASTAR.Dist3D(nodeA, nodeB) end

---Function to check if distance between two nodes is less than a threshold distance.
---
------
---@param nodeA ASTAR.Node First node.
---@param nodeB ASTAR.Node Other node.
---@param distmax number Max distance in meters. Default is 2000 m.
---@return boolean #If true, distance between the two nodes is below threshold.
function ASTAR.DistMax(nodeA, nodeB, distmax) end

---Heuristic cost is given by the distance between the nodes on road.
---
------
---@param nodeA ASTAR.Node First node.
---@param nodeB ASTAR.Node Other node.
---@return number #Distance between the two nodes.
function ASTAR.DistRoad(nodeA, nodeB) end

---Find the closest node from a given coordinate.
---
------
---@param self ASTAR 
---@param Coordinate COORDINATE 
---@return ASTAR.Node #Cloest node to the coordinate.
---@return number #Distance to closest node in meters.
function ASTAR:FindClosestNode(Coordinate) end

---Add a node.
---
------
---@param self ASTAR 
---@param Node ASTAR.Node The node to be added to the nodes table.
---@return ASTAR #self
function ASTAR:FindEndNode(Node) end

---Find the start node.
---
------
---@param self ASTAR 
---@param Node ASTAR.Node The node to be added to the nodes table.
---@return ASTAR #self
function ASTAR:FindStartNode(Node) end

---Create a node from a given coordinate.
---
------
---@param self ASTAR 
---@param Coordinate COORDINATE The coordinate where to create the node.
---@return ASTAR.Node #The node.
function ASTAR:GetNodeFromCoordinate(Coordinate) end

---A* pathfinding function.
---This seaches the path along nodes between start and end nodes/coordinates.
---
------
---@param self ASTAR 
---@param ExcludeStartNode boolean If *true*, do not include start node in found path. Default is to include it.
---@param ExcludeEndNode boolean If *true*, do not include end node in found path. Default is to include it.
---@return table #Table of nodes from start to finish.
function ASTAR:GetPath(ExcludeStartNode, ExcludeEndNode) end

---Function to check if two nodes have line of sight (LoS).
---
------
---@param nodeA ASTAR.Node First node.
---@param nodeB ASTAR.Node Other node.
---@param corridor? number (Optional) Width of corridor in meters.
---@return boolean #If true, two nodes have LoS.
function ASTAR.LoS(nodeA, nodeB, corridor) end

---Create a new ASTAR object.
---
------
---@param self ASTAR 
---@return ASTAR #self
function ASTAR:New() end

---Function to check if two nodes have a road connection.
---
------
---@param nodeA ASTAR.Node First node.
---@param nodeB ASTAR.Node Other node.
---@return boolean #If true, two nodes are connected via a road.
function ASTAR.Road(nodeA, nodeB) end

---Set heuristic cost to go from one node to another to be their 2D distance.
---
------
---@param self ASTAR 
---@return ASTAR #self
function ASTAR:SetCostDist2D() end

---Set heuristic cost to go from one node to another to be their 3D distance.
---
------
---@param self ASTAR 
---@return ASTAR #self
function ASTAR:SetCostDist3D() end

---Set the function which calculates the "cost" to go from one to another node.
---The first to arguments of this function are always the two nodes under consideration. But you can add optional arguments.
---Very often the distance between nodes is a good measure for the cost.
---
------
---@param self ASTAR 
---@param CostFunction function Function that returns the "cost".
---@param ... NOTYPE Condition function arguments if any.
---@return ASTAR #self
function ASTAR:SetCostFunction(CostFunction, ...) end

---Set heuristic cost to go from one node to another to be their 3D distance.
---
------
---@param self ASTAR 
---@return ASTAR #self
function ASTAR:SetCostRoad() end

---Set coordinate where you want to go.
---
------
---@param self ASTAR 
---@param Coordinate COORDINATE end coordinate.
---@return ASTAR #self
function ASTAR:SetEndCoordinate(Coordinate) end

---Set coordinate from where to start.
---
------
---@param self ASTAR 
---@param Coordinate COORDINATE Start coordinate.
---@return ASTAR #self
function ASTAR:SetStartCoordinate(Coordinate) end

---Set valid neighbours to be in a certain distance.
---
------
---@param self ASTAR 
---@param MaxDistance number Max distance between nodes in meters. Default is 2000 m.
---@return ASTAR #self
function ASTAR:SetValidNeighbourDistance(MaxDistance) end

---Add a function to determine if a neighbour of a node is valid.
---
------
---@param self ASTAR 
---@param NeighbourFunction function Function that needs to return *true* for a neighbour to be valid.
---@param ... NOTYPE Condition function arguments if any.
---@return ASTAR #self
function ASTAR:SetValidNeighbourFunction(NeighbourFunction, ...) end

---Set valid neighbours to require line of sight between two nodes.
---
------
---@param self ASTAR 
---@param CorridorWidth number Width of LoS corridor in meters.
---@return ASTAR #self
function ASTAR:SetValidNeighbourLoS(CorridorWidth) end

---Set valid neighbours to be in a certain distance.
---
------
---@param self ASTAR 
---@param MaxDistance number Max distance between nodes in meters. Default is 2000 m.
---@return ASTAR #self
function ASTAR:SetValidNeighbourRoad(MaxDistance) end

---Calculate 2D distance between two nodes.
---
------
---@param self ASTAR 
---@param nodeA ASTAR.Node Node A.
---@param nodeB ASTAR.Node Node B.
---@return number #Distance between nodes in meters.
function ASTAR:_DistNodes(nodeA, nodeB) end

---Heuristic "cost" function to go from node A to node B.
---Default is the distance between the nodes.
---
------
---@param self ASTAR 
---@param nodeA ASTAR.Node Node A.
---@param nodeB ASTAR.Node Node B.
---@return number #"Cost" to go from node A to node B.
function ASTAR:_HeuristicCost(nodeA, nodeB) end

---Check if going from a node to a neighbour is possible.
---
------
---@param self ASTAR 
---@param node ASTAR.Node A node.
---@param neighbor ASTAR.Node Neighbour node.
---@return boolean #If true, transition between nodes is possible.
function ASTAR:_IsValidNeighbour(node, neighbor) end

---Function that calculates the lowest F score.
---
------
---@param self ASTAR 
---@param set table The set of nodes IDs.
---@param f_score number F score.
---@return ASTAR.Node #Best node.
function ASTAR:_LowestFscore(set, f_score) end

---Function to get valid neighbours of a node.
---
------
---@param self ASTAR 
---@param theNode ASTAR.Node The node.
---@param nodes table Possible neighbours.
---@param Valid table neighbour nodes.
function ASTAR:_NeighbourNodes(theNode, nodes, Valid) end

---Function to check if a node is not in a set.
---
------
---@param self ASTAR 
---@param set table Set of nodes.
---@param theNode ASTAR.Node The node to check.
---@return boolean #If true, the node is not in the set.
function ASTAR:_NotIn(set, theNode) end

---Unwind path function.
---
------
---@param self ASTAR 
---@param flat_path table Flat path.
---@param map table Map.
---@param current_node ASTAR.Node The current node.
---@return table #Unwinded path.
function ASTAR:_UnwindPath(flat_path, map, current_node) end


---Node data.
---@class ASTAR.Node 
---@field private coordinate COORDINATE Coordinate of the node.
---@field private cost table Cached cost.
---@field private id number Node id.
---@field private surfacetype number Surface type.
---@field private valid table Cached valid/invalid nodes.
ASTAR.Node = {}



