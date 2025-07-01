---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Functional.Stratego.png" width="100%">
---
---**Functional** - Stratego.
---
---**Main Features:**
---
---   * Helper class for mission designers to support classic capture-the-base scenarios.
---   * Creates a network of possible connections between bases (airbases, FARPs, Ships), Ports (defined as zones) and POIs (defined as zones).
---   * Assigns a strategic value to each of the resulting nodes.
---   * Can create a list of targets for your next mission move, both strategic and consolidation targets.
---   * Can be used with budgets to limit the target selection.
---   * Highly configureable.
---
---===
---
---### Author: **applevangelist**
---*If you see what is right and fail to act on it, you lack courage* --- Confucius
---
---===
---
---# The STRATEGO Concept
---
---STRATEGO is a helper class for mission designers.
---The basic idea is to create a network of nodes (bases) on the map, which each have a number of connections
---to other nodes. The base value of each node is the number of runways of the base (the bigger the more important), or in the case of Ports and POIs, the assigned value points.
---The strategic value of each base is determined by the number of routes going in and out of the node, where connections between more strategic nodes add a higher value to the
---strategic value than connections to less valueable nodes.
---
---## Setup
---
---Setup is map indepent and works automatically. All airbases, FARPS, and ships on the map are considered. **Note:** Later spawned objects are not considered at the moment.
---         
---         -- Setup and start STRATGEO for the blue side, maximal node distance is 100km
---         local Bluecher = STRATEGO:New("Bluecher",coalition.side.BLUE,100)
---         -- use budgets
---         Bluecher:SetUsingBudget(true,500)
---         -- draw on the map
---         Bluecher:SetDebug(true,true,true)
---         -- Start
---         Bluecher:Start()
---
---### Helper
---
---#STRATEGO.SetWeights(): Set weights for nodes and routes to determine their importance.
---
---### Hint
---         
---Each node is its own Ops.OpsZone#OPSZONE object to manage the coalition alignment of that node and how it can be conquered.
---
---### Distance
---
---The node distance factor determines how many connections are there on the map. The smaller the lighter is the resulting net. The higher the thicker it gets, with more strategic options.
---Play around with the distance to get an optimal map for your scenario.
---
---One some maps, e.g. Syria, lower distance factors can create "islands" of unconnected network parts on the map. FARPs and POIs can bridge those gaps, or you can add routes manually.
---
---#STRATEGO.AddRoutesManually(): Add a route manually.
---
---## Ports and POIs
---
---Ports and POIs are Core.Zone#ZONE objects on the map with specfic values. Zones with the keywords "Port" or "POI" in the name are automatically considered at setup time.
--- 
---## Get next possible targets
---
---There are two types of possible target lists, strategic and consolidation. Targets closer to the start node are chosen as possible targets. 
---
---
---     * Strategic targets are of higher or equal base weight from a given start point. Can also be obtained for the whole net.
---     * Consoliation targets are of smaller or equal base weight from a given start point. Can also be obtained for the whole net.  
---
---
--- #STRATEGO.UpdateNodeCoalitions(): Update alls node's coalition data before takign a decision.   
--- #STRATEGO.FindStrategicTargets(): Find a list of possible strategic targets in the network of the enemy or neutral coalition.   
--- #STRATEGO.FindConsolidationTargets(): Find a list of possible strategic targets in the network of the enemy or neutral coalition.     
--- #STRATEGO.FindAffordableStrategicTarget(): When using budgets, find **one** strategic target you can afford.   
--- #STRATEGO.FindAffordableConsolidationTarget(): When using budgets, find **one** consolidation target you can afford.   
--- #STRATEGO.FindClosestStrategicTarget(): Find closest strategic target from a given start point.   
--- #STRATEGO.FindClosestConsolidationTarget(): Find closest consolidation target from a given start point.   
--- #STRATEGO.GetHighestWeightNodes(): Get a list of the nodes with the highest weight. Coalition independent.   
--- #STRATEGO.GetNextHighestWeightNodes(): Get a list of the nodes a weight less than the give parameter. Coalition independent.   
---
--- 
---**How** you act on these suggestions is again totally up to your mission design.
--- 
---## Using budgets
--- 
--- Set up STRATEGO to use budgets to limit the target selection. **How** your side actually earns budgets is up to your mission design. However, when using budgets, a target will only be selected,
--- when you have more budget points available than the value points of the targeted base.
--- 
---         -- use budgets
---         Bluecher:SetUsingBudget(true,500)
--- 
---### Helpers:
---
--- 
--- #STRATEGO.GetBudget(): Get the current budget points.   
--- #STRATEGO.AddBudget(): Add a number of budget points.   
--- #STRATEGO.SubtractBudget(): Subtract a number of budget points.   
--- #STRATEGO.SetNeutralBenefit(): Set neutral benefit, i.e. how many points it is cheaper to decide for a neutral vs an enemy node when taking decisions.   
---
--- 
---## Functions to query a node's data
--- 
--- 
--- #STRATEGO.GetNodeBaseWeight(): Get the base weight of a node by its name.   
--- #STRATEGO.GetNodeCoalition(): Get the COALITION of a node by its name.   
--- #STRATEGO.GetNodeType(): Get the TYPE of a node by its name.   
--- #STRATEGO.GetNodeZone(): Get the ZONE of a node by its name.   
--- #STRATEGO.GetNodeOpsZone(): Get the OPSZONE of a node by its name.   
--- #STRATEGO.GetNodeCoordinate(): Get the COORDINATE of a node by its name.   
--- #STRATEGO.IsAirbase(): Check if the TYPE of a node is AIRBASE.   
--- #STRATEGO.IsPort(): Check if the TYPE of a node is PORT.   
--- #STRATEGO.IsPOI(): Check if the TYPE of a node is POI.   
--- #STRATEGO.IsFARP(): Check if the TYPE of a node is FARP.   
--- #STRATEGO.IsShip(): Check if the TYPE of a node is SHIP.   
--- 
--- 
---## Various
--- 
--- 
--- #STRATEGO.FindNeighborNodes(): Get neighbor nodes of a named node.   
--- #STRATEGO.FindRoute(): Find a route between two nodes.   
--- #STRATEGO.SetCaptureOptions(): Set how many units of which minimum threat level are needed to capture one node (i.e. the underlying OpsZone).   
--- #STRATEGO.SetDebug(): Set debug and draw options.   
--- #STRATEGO.SetStrategoZone(): Set a zone to restrict STRATEGO analytics to, can be any kind of ZONE Object.
---
---
---## Visualisation example code for the Syria map:
---
---           local Bluecher = STRATEGO:New("Bluecher",coalition.side.BLUE,100)
---           Bluecher:SetDebug(true,true,true)
---           Bluecher:Start()
---
---           Bluecher:AddRoutesManually(AIRBASE.Syria.Beirut_Rafic_Hariri,AIRBASE.Syria.Larnaca)
---           Bluecher:AddRoutesManually(AIRBASE.Syria.Incirlik,AIRBASE.Syria.Hatay)
---           Bluecher:AddRoutesManually(AIRBASE.Syria.Incirlik,AIRBASE.Syria.Minakh)
---           Bluecher:AddRoutesManually(AIRBASE.Syria.King_Hussein_Air_College,AIRBASE.Syria.H4)
---           Bluecher:AddRoutesManually(AIRBASE.Syria.Sayqal,AIRBASE.Syria.At_Tanf)
---
---           local route = Bluecher:FindRoute(AIRBASE.Syria.Rosh_Pina,AIRBASE.Syria.Incirlik,5,true)
---           UTILS.PrintTableToLog(route,1)  
---- **STRATEGO** class, extends Core.Base#BASE
---@class STRATEGO : BASE
---@field Budget number 
---@field CaptureObjectCategories table 
---@field CaptureThreatlevel number 
---@field CaptureUnits number 
---@field ClassName string 
---@field ExcludeShips boolean 
---@field NeutralBenefit number 
---@field OpsZones table 
---@field POIs NOTYPE 
---@field POIweight number 
---@field StrategoZone ZONE 
---@field Type STRATEGO.Type 
---@field private airbasetable table 
---@field private bases NOTYPE 
---@field private coalition number 
---@field private coalitiontext NOTYPE 
---@field private colors table 
---@field private debug boolean 
---@field private disttable table 
---@field private drawzone NOTYPE 
---@field private easynames table 
---@field private lid NOTYPE 
---@field private markzone NOTYPE 
---@field private maxdist number 
---@field private maxrunways number 
---@field private nonconnectedab table 
---@field private ports NOTYPE 
---@field private portweight number 
---@field private routefactor number 
---@field private routexists table 
---@field private usebudget boolean 
---@field private version string 
STRATEGO = {}

---[USER] Add budget points.
---
------
---@param self STRATEGO 
---@param Number number of points to add.
---@return STRATEGO #self
function STRATEGO:AddBudget(Number) end

---[USER] Manually add a route, for e.g.
---Island hopping or to connect isolated networks. Use **after** STRATEGO has been started!
---
------
---@param self STRATEGO 
---@param Startpoint string Starting Point, e.g. AIRBASE.Syria.Hatay
---@param Endpoint string End Point, e.g. AIRBASE.Syria.H4
---@param Color? table (Optional) RGB color table {r, g, b}, e.g. {1,0,0} for red. Defaults to violet.
---@param Linetype? number (Optional) Line type: 0=No line, 1=Solid, 2=Dashed, 3=Dotted, 4=Dot dash, 5=Long dash, 6=Two dash. Default 5.
---@param Draw? boolean (Optional) If true, draw route on the F10 map. Defaukt false.
---@return STRATEGO #self
function STRATEGO:AddRoutesManually(Startpoint, Endpoint, Color, Linetype, Draw) end

---[INTERNAL] Analyse airbase setups
---
------
---@param self STRATEGO 
---@return STRATEGO #self
function STRATEGO:AnalyseBases() end

---[INTERNAL] Analyse POI setups
---
------
---@param self STRATEGO 
---@param Set NOTYPE 
---@param Weight NOTYPE 
---@param Key NOTYPE 
---@return STRATEGO #self
function STRATEGO:AnalysePOIs(Set, Weight, Key) end

---[INTERNAL] Analyse routes
---
------
---@param self STRATEGO 
---@param tgtrwys NOTYPE 
---@param factor NOTYPE 
---@param color NOTYPE 
---@param linetype NOTYPE 
---@return STRATEGO #self
function STRATEGO:AnalyseRoutes(tgtrwys, factor, color, linetype) end

---[INTERNAL] Analyse non-connected points.
---
------
---@param self STRATEGO 
---@param Color table RGB color to be used.
---@return STRATEGO #self
function STRATEGO:AnalyseUnconnected(Color) end

---[USER] Find **one** affordable consolidation target.
---
------
---@param self STRATEGO 
---@return table #Target Table with #STRATEGO.Target data or nil if none found.
function STRATEGO:FindAffordableConsolidationTarget() end

---[USER] Find **one** affordable strategic target.
---
------
---@param self STRATEGO 
---@return table #Target Table with #STRATEGO.Target data or nil if none found.
function STRATEGO:FindAffordableStrategicTarget() end

---[USER] Get the next best consolidation target node with a lower BaseWeight.
---
------
---@param self STRATEGO 
---@param Startpoint string Name of start point.
---@param BaseWeight number Base weight of the node, i.e. the number of runways of an airbase or the weight of ports or POIs.
---@return number #ShortestDist Shortest distance found.
---@return string #Name Name of the target node.
---@return number #Weight Consolidated weight of the target node, zero if none found.
---@return number #Coalition Coaltion of the target.
function STRATEGO:FindClosestConsolidationTarget(Startpoint, BaseWeight) end

---[USER] Get the next best strategic target node with same or higher Consolidated Weight.
---
------
---@param self STRATEGO 
---@param Startpoint string Name of start point.
---@param Weight number Consolidated Weight of the node, i.e. the calculated weight of the node based on number of runways, connections and a weight factor.
---@return number #ShortestDist Shortest distance found.
---@return string #Name Name of the target node.
---@return number #Weight Consolidated weight of the target node, zero if none found.
---@return number #Coalition Coaltion of the target.
function STRATEGO:FindClosestStrategicTarget(Startpoint, Weight) end

---[USER] Get the next best consolidation target nodes in the network.
---
------
---@param self STRATEGO 
---@return table #of #STRATEGO.Target data points
function STRATEGO:FindConsolidationTargets() end

---[USER] Get neighbor nodes of a named node.
---
------
---@param self STRATEGO 
---@param Name string The name to search the neighbors for.
---@param Enemies? boolean (optional) If true, find only enemy neighbors.
---@param Friends? boolean (optional) If true, find only friendly or neutral neighbors.
---@return table #Neighbors Table of #STRATEGO.DistData entries indexed by neighbor node names.
---@return string #Nearest Name of the nearest node.
---@return number #Distance Distance of the nearest node.
function STRATEGO:FindNeighborNodes(Name, Enemies, Friends) end

---[USER] Find a route between two nodes.
---
------
---@param self STRATEGO 
---@param Start string The name of the start node.
---@param End string The name of the end node.
---@param Hops number Max iterations to find a route.
---@param Draw boolean If true, draw the route on the map.
---@param Color? table (Optional) RGB color table {r, g, b}, e.g. {1,0,0} for red. Defaults to black.
---@param LineType? number (Optional) Line type: 0=No line, 1=Solid, 2=Dashed, 3=Dotted, 4=Dot dash, 5=Long dash, 6=Two dash. Default 6.
---@param NoOptimize boolean If set to true, do not optimize (shorten) the resulting route if possible.
---@return table #Route Table of #string name entries of the route
---@return boolean #Complete If true, the route was found end-to-end.
---@return boolean #Reverse If true, the route was found with a reverse search, the route table will be from sorted from end point to start point.
function STRATEGO:FindRoute(Start, End, Hops, Draw, Color, LineType, NoOptimize) end

---[USER] Get the next best strategic target nodes in the network.
---
------
---@param self STRATEGO 
---@return table #of #STRATEGO.Target data points
function STRATEGO:FindStrategicTargets() end

---[USER] Get budget points.
---
------
---@param self STRATEGO 
---@return number #budget
function STRATEGO:GetBudget() end

---[USER] Get a list of the nodes with the highest weight.
---
------
---@param self STRATEGO 
---@param Coalition? number (Optional) Find for this coalition only. E.g. coalition.side.BLUE.
---@return table #Table of nodes.
---@return number #Weight The consolidated weight associated with the nodes.
---@return number #Highest Highest weight found.
---@return string #Name of the node with the highest weight.
function STRATEGO:GetHighestWeightNodes(Coalition) end

---[INTERNAL] Get an OpsZone from a Zone object.
---
------
---@param self STRATEGO 
---@param Zone ZONE 
---@param Coalition number 
---@return OPSZONE #OpsZone
function STRATEGO:GetNewOpsZone(Zone, Coalition) end

---[USER] Get a list of the nodes a weight less than the given parameter.
---
------
---@param self STRATEGO 
---@param Weight number Weight - nodes need to have less than this weight.
---@param Coalition? number (Optional) Find for this coalition only. E.g. coalition.side.BLUE.
---@return table #Table of nodes.
---@return number #Weight The consolidated weight associated with the nodes.
function STRATEGO:GetNextHighestWeightNodes(Weight, Coalition) end

---[USER] Get the base weight of a node by its name.
---
------
---@param self STRATEGO 
---@param Name string The name to look for.
---@return number #Weight The base weight or 0 if not found.
function STRATEGO:GetNodeBaseWeight(Name) end

---[USER] Get the COALITION of a node by its name.
---
------
---@param self STRATEGO 
---@param The string name to look for.
---@param Name NOTYPE 
---@return number #Coalition The coalition.
function STRATEGO:GetNodeCoalition(The, Name) end

---[USER] Get the COORDINATE of a node by its name.
---
------
---@param self STRATEGO 
---@param The string name to look for.
---@param Name NOTYPE 
---@return COORDINATE #Coordinate The Coordinate of the node or nil if not found.
function STRATEGO:GetNodeCoordinate(The, Name) end

---[USER] Get the OPSZONE of a node by its name.
---
------
---@param self STRATEGO 
---@param The string name to look for.
---@param Name NOTYPE 
---@return OPSZONE #OpsZone The OpsZone of the node or nil if not found.
function STRATEGO:GetNodeOpsZone(The, Name) end

---[USER] Get the TYPE of a node by its name.
---
------
---@param self STRATEGO 
---@param The string name to look for.
---@param Name NOTYPE 
---@return string #Type Type of the node, e.g. STRATEGO.Type.AIRBASE or nil if not found.
function STRATEGO:GetNodeType(The, Name) end

---[USER] Get the aggregated weight of a node by its name.
---
------
---@param self STRATEGO 
---@param Name string The name to look for.
---@return number #Weight The weight or 0 if not found.
function STRATEGO:GetNodeWeight(Name) end

---[USER] Get the ZONE of a node by its name.
---
------
---@param self STRATEGO 
---@param The string name to look for.
---@param Name NOTYPE 
---@return ZONE #Zone The Zone of the node or nil if not found.
function STRATEGO:GetNodeZone(The, Name) end

---[USER] Get available connecting nodes from one start node
---
------
---@param self STRATEGO 
---@param StartPoint string The starting name
---@return boolean #found
---@return table #Nodes 
function STRATEGO:GetRoutesFromNode(StartPoint) end

---[INTERNAL] Get nice route text
---
------
---@param self STRATEGO 
---@param StartPoint NOTYPE 
---@param EndPoint NOTYPE 
---@return STRATEGO #self
function STRATEGO:GetToFrom(StartPoint, EndPoint) end

---[USER] Check if the TYPE of a node is AIRBASE.
---
------
---@param self STRATEGO 
---@param The string name to look for.
---@param Name NOTYPE 
---@return boolean #Outcome
function STRATEGO:IsAirbase(The, Name) end

---[USER] Check if the TYPE of a node is FARP.
---
------
---@param self STRATEGO 
---@param The string name to look for.
---@param Name NOTYPE 
---@return boolean #Outcome
function STRATEGO:IsFARP(The, Name) end

---[USER] Check if the TYPE of a node is POI.
---
------
---@param self STRATEGO 
---@param The string name to look for.
---@param Name NOTYPE 
---@return boolean #Outcome
function STRATEGO:IsPOI(The, Name) end

---[USER] Check if the TYPE of a node is PORT.
---
------
---@param self STRATEGO 
---@param The string name to look for.
---@param Name NOTYPE 
---@return boolean #Outcome
function STRATEGO:IsPort(The, Name) end

---[USER] Check if the TYPE of a node is SHIP.
---
------
---@param self STRATEGO 
---@param The string name to look for.
---@param Name NOTYPE 
---@return boolean #Outcome
function STRATEGO:IsShip(The, Name) end

---[USER] Create a new STRATEGO object and start it up.
---
------
---@param self STRATEGO 
---@param Name string Name of the Adviser.
---@param Coalition number Coalition, e.g. coalition.side.BLUE.
---@param MaxDist number Maximum distance of a single route in kilometers, defaults to 150.
---@return STRATEGO #self 
function STRATEGO:New(Name, Coalition, MaxDist) end

---FSM Function OnAfterNodeEvent.
---A node changed coalition.
---
------
---@param self STRATEGO 
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@param OpsZone OPSZONE The OpsZone triggering the event.
---@param Coalition number The coalition of the new owner.
---@return STRATEGO #self
function STRATEGO:OnAfterNodeEvent(From, Event, To, OpsZone, Coalition) end

---[USER] Set how many units of which minimum threat level are needed to capture one node (i.e.
---the underlying OpsZone).
---
------
---@param self STRATEGO 
---@param CaptureUnits number Number of units needed, defaults to three.
---@param CaptureThreatlevel number Threat level needed, can be 0..10, defaults to one.
---@param CaptureCategories table Table of object categories which can capture a node, defaults to `{Object.Category.UNIT}`.
---@return STRATEGO #self
function STRATEGO:SetCaptureOptions(CaptureUnits, CaptureThreatlevel, CaptureCategories) end

---[USER] Set debugging.
---
------
---@param self STRATEGO 
---@param Debug boolean If true, switch on debugging.
---@param DrawZones boolean If true, draw the OpsZones on the F10 map.
---@param MarkZones boolean if true, mark the OpsZones on the F10 map (with further information).
function STRATEGO:SetDebug(Debug, DrawZones, MarkZones) end

---[USER] Set neutral benefit, i.e.
---how many points it is cheaper to decide for a neutral vs an enemy node when taking decisions.
---
------
---@param self STRATEGO 
---@param NeutralBenefit number Pointsm defaults to 100.
---@return STRATEGO #self
function STRATEGO:SetNeutralBenefit(NeutralBenefit) end

---[USER] Set the base weight of a single node found by its name manually.
---
------
---@param self STRATEGO 
---@param Name string The name to look for.
---@param Weight number The weight to be set.
---@return boolean #success
function STRATEGO:SetNodeBaseWeight(Name, Weight) end

---[USER] Set the aggregated weight of a single node found by its name manually.
---
------
---@param self STRATEGO 
---@param Name string The name to look for.
---@param Weight number The weight to be set.
---@return boolean #success
function STRATEGO:SetNodeWeight(Name, Weight) end

---[USER] Restrict Stratego to analyse this zone only.
---
------
---@param self STRATEGO 
---@param Zone ZONE The Zone to restrict Stratego to, can be any kind of ZONE Object.
---@return STRATEGO #self
function STRATEGO:SetStrategoZone(Zone) end

---[USER] Set up usage of budget and set an initial budget in points.
---
------
---@param self STRATEGO 
---@param Usebudget boolean If true, use budget for advisory calculations.
---@param StartBudget number Initial budget to be used, defaults to 500.
function STRATEGO:SetUsingBudget(Usebudget, StartBudget) end

---[USER] Set weights for nodes and routes to determine their importance.
---
------
---@param self STRATEGO 
---@param MaxRunways number Set the maximum number of runways the big (equals strategic) airbases on the map have. Defaults to 3. The weight of an airbase node hence equals the number of runways.
---@param PortWeight number Set what weight a port node has. Defaults to 3.
---@param POIWeight number Set what weight a POI node has. Defaults to 1.
---@param RouteFactor number Defines which weight each route between two defined nodes gets: Weight * RouteFactor.
---@return STRATEGO #self
function STRATEGO:SetWeights(MaxRunways, PortWeight, POIWeight, RouteFactor) end

---Triggers the FSM event "Start".
---Starts the STRATEGO. Initializes parameters and starts event handlers.
---
------
---@param self STRATEGO 
function STRATEGO:Start() end

---Triggers the FSM event "Stop".
---Stops the STRATEGO and all its event handlers.
---
------
---@param self STRATEGO 
function STRATEGO:Stop() end

---[USER] Subtract budget points.
---
------
---@param self STRATEGO 
---@param Number number of points to subtract.
---@return STRATEGO #self
function STRATEGO:SubtractBudget(Number) end

---[INTERNAL] Update node coalitions
---
------
---@param self STRATEGO 
---@return STRATEGO #self
function STRATEGO:UpdateNodeCoalitions() end

---[INTERNAL] Internal helper function to check for islands, aka Floodtest
---
------
---@param self STRATEGO 
---@param Start string Name of the start node
---@param ABTable? table (Optional) #table of node names to check.
---@return STRATEGO #self
function STRATEGO:_FloodFill(Start, ABTable) end

---[INTERNAL] Internal helper function to check for islands, aka Floodtest
---
------
---@param self STRATEGO 
---@param next string Name of the start node
---@param filled table #table of visited nodes
---@param unfilled table #table if unvisited nodes
---@return STRATEGO #self
function STRATEGO:_FloodNext(next, filled, unfilled) end

---[INTERNAL] Internal helper function to check for islands, aka Floodtest
---
------
---@param self STRATEGO 
---@param connect boolen If true, connect the two resulting islands at the shortest distance if necessary
---@param draw boolen If true, draw outer vertices of found node networks
---@return boolean #Connected If true, all nodes are in one network
---@return table #Network #table of node names in the network
---@return table #Unconnected #table of node names **not** in the network
function STRATEGO:_FloodTest(connect, draw) end

---[INTERNAL] Route Finding - Find the next hop towards an end node from a start node
---
------
---@param self STRATEGO 
---@param Start string The name of the start node.
---@param End string The name of the end node.
---@param InRoute table Table of node names making up the route so far.
---@return string #Name of the next closest node
function STRATEGO:_GetNextClosest(Start, End, InRoute) end

---Triggers the FSM event "Start" after a delay.
---Starts the STRATEGO. Initializes parameters and starts event handlers.
---
------
---@param self STRATEGO 
---@param delay number Delay in seconds.
function STRATEGO:__Start(delay) end

---Triggers the FSM event "Stop" after a delay.
---Stops the STRATEGO and all its event handlers.
---
------
---@param self STRATEGO 
---@param delay number Delay in seconds.
function STRATEGO:__Stop(delay) end

---[INTERNAL] FSM function for initial setup and getting ready.
---
------
---@param self STRATEGO 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@return STRATEGO #self
---@private
function STRATEGO:onafterStart(From, Event, To) end

---[INTERNAL] Update knot association
---
------
---@param self STRATEGO 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@return STRATEGO #self
---@private
function STRATEGO:onafterUpdate(From, Event, To) end


---@class STRATEGO.Data 
---@field private baseweight number 
---@field private coalition number 
---@field private connections number 
---@field private coord COORDINATE 
---@field private name string 
---@field private opszone OPSZONE 
---@field private port boolean 
---@field private type string 
---@field private weight number 
---@field private zone ZONE_RADIUS 
STRATEGO.Data = {}


---@class STRATEGO.DistData 
---@field private dist number 
---@field private start string 
---@field private target string 
STRATEGO.DistData = {}


---@class STRATEGO.Target 
---@field private coalition number 
---@field private coalitionname string  
---@field private coordinate COORDINATRE 
---@field private dist number 
---@field private name string 
---@field private points number 
STRATEGO.Target = {}


---@class STRATEGO.Type 
---@field AIRBASE string 
---@field FARP string 
---@field POI string 
---@field PORT string 
---@field SHIP string 
STRATEGO.Type = {}



