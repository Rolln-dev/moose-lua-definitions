---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/MOOSE.JPG" width="100%">
---
---(SP) (MP) (FSM) Route AI or players through waypoints or to zones.
---
---===
---
---![Banner Image](..\Images\deprecated.png)
---
---# #ACT_ROUTE FSM class, extends Core.Fsm#FSM_PROCESS
---
---## ACT_ROUTE state machine:
---
---This class is a state machine: it manages a process that is triggered by events causing state transitions to occur.
---All derived classes from this class will start with the class name, followed by a \_. See the relevant derived class descriptions below.
---Each derived class follows exactly the same process, using the same events and following the same state transitions,
---but will have **different implementation behaviour** upon each event or state transition.
---
---### ACT_ROUTE **Events**:
---
---These are the events defined in this class:
---
---  * **Start**:  The process is started. The process will go into the Report state.
---  * **Report**: The process is reporting to the player the route to be followed.
---  * **Route**: The process is routing the controllable.
---  * **Pause**: The process is pausing the route of the controllable.
---  * **Arrive**: The controllable has arrived at a route point.
---  * **More**:  There are more route points that need to be followed. The process will go back into the Report state.
---  * **NoMore**:  There are no more route points that need to be followed. The process will go into the Success state.
---
---### ACT_ROUTE **Event methods**:
---
---Event methods are available (dynamically allocated by the state machine), that accomodate for state transitions occurring in the process.
---There are two types of event methods, which you can use to influence the normal mechanisms in the state machine:
---
---  * **Immediate**: The event method has exactly the name of the event.
---  * **Delayed**: The event method starts with a __ + the name of the event. The first parameter of the event method is a number value, expressing the delay in seconds when the event will be executed.
---
---### ACT_ROUTE **States**:
---
---  * **None**: The controllable did not receive route commands.
---  * **Arrived (*)**: The controllable has arrived at a route point.
---  * **Aborted (*)**: The controllable has aborted the route path.
---  * **Routing**: The controllable is understay to the route point.
---  * **Pausing**: The process is pausing the routing. AI air will go into hover, AI ground will stop moving. Players can fly around.
---  * **Success (*)**: All route points were reached.
---  * **Failed (*)**: The process has failed.
---
---(*) End states of the process.
---
---### ACT_ROUTE state transition methods:
---
---State transition functions can be set **by the mission designer** customizing or improving the behaviour of the state.
---There are 2 moments when state transition methods will be called by the state machine:
---
---  * **Before** the state transition.
---    The state transition method needs to start with the name **OnBefore + the name of the state**.
---    If the state transition method returns false, then the processing of the state transition will not be done!
---    If you want to change the behaviour of the AIControllable at this event, return false,
---    but then you'll need to specify your own logic using the AIControllable!
---
---  * **After** the state transition.
---    The state transition method needs to start with the name **OnAfter + the name of the state**.
---    These state transition methods need to provide a return value, which is specified at the function description.
---
---===
---
---# 1) #ACT_ROUTE_ZONE class, extends #ACT_ROUTE
---
---The ACT_ROUTE_ZONE class implements the core functions to route an AIR Wrapper.Controllable player Wrapper.Unit to a Core.Zone.
---The player receives on perioding times messages with the coordinates of the route to follow.
---Upon arrival at the zone, a confirmation of arrival is sent, and the process will be ended.
---
---# 1.1) ACT_ROUTE_ZONE constructor:
---
---  * #ACT_ROUTE_ZONE.New(): Creates a new ACT_ROUTE_ZONE object.
---
---# Developer Note
---
---Note while this class still works, it is no longer supported as the original author stopped active development of MOOSE
---Therefore, this class is considered to be deprecated
---
---===
---ACT_ROUTE class
---@class ACT_ROUTE : FSM_PROCESS
---@field CancelMenuGroupCommand NOTYPE 
---@field ClassName string 
---@field Coordinate COORDINATE 
---@field DisplayCount number 
---@field ProcessUnit UNIT 
---@field RouteMode NOTYPE 
---@field TASK TASK 
---@field Zone ZONE_BASE 
ACT_ROUTE = {}

---Get the routing text to be displayed.
---The route mode determines the text displayed.
---
------
---@param self ACT_ROUTE 
---@param Controllable UNIT 
---@return string #
function ACT_ROUTE:GetRouteText(Controllable) end


---
------
---@param self NOTYPE 
function ACT_ROUTE:MenuCancel() end

---Creates a new routing state machine.
---The process will route a CLIENT to a ZONE until the CLIENT is within that ZONE.
---
------
---@param self ACT_ROUTE 
---@return ACT_ROUTE #self
function ACT_ROUTE:New() end

---Set a Cancel Menu item.
---
------
---@param self ACT_ROUTE 
---@param MenuGroup NOTYPE 
---@param MenuText NOTYPE 
---@param ParentMenu NOTYPE 
---@param MenuTime NOTYPE 
---@param MenuTag NOTYPE 
---@return ACT_ROUTE #
function ACT_ROUTE:SetMenuCancel(MenuGroup, MenuText, ParentMenu, MenuTime, MenuTag) end

---Set the route mode.
---There are 2 route modes supported:
---
---  * SetRouteMode( "B" ): Route mode is Bearing and Range.
---  * SetRouteMode( "C" ): Route mode is LL or MGRS according coordinate system setup.
---
------
---@param self ACT_ROUTE 
---@param RouteMode NOTYPE 
---@return ACT_ROUTE #
function ACT_ROUTE:SetRouteMode(RouteMode) end

---StateMachine callback function
---
------
---@param self ACT_ROUTE 
---@param ProcessUnit UNIT 
---@param Event string 
---@param From string 
---@param To string 
---@private
function ACT_ROUTE:onafterStart(ProcessUnit, Event, From, To) end

---StateMachine callback function
---
------
---@param self ACT_ROUTE 
---@param ProcessUnit UNIT 
---@param Event string 
---@param From string 
---@param To string 
---@private
function ACT_ROUTE:onbeforeRoute(ProcessUnit, Event, From, To) end

---Check if the controllable has arrived.
---
------
---@param self ACT_ROUTE 
---@param ProcessUnit UNIT 
---@return boolean #
---@private
function ACT_ROUTE:onfuncHasArrived(ProcessUnit) end


---ACT_ROUTE_POINT class
---@class ACT_ROUTE_POINT : ACT_ROUTE
---@field ClassName string 
---@field Coordinate NOTYPE 
---@field DisplayCount number 
---@field DisplayInterval number 
---@field DisplayMessage boolean 
---@field DisplayTime number 
---@field TASK TASK 
ACT_ROUTE_POINT = {}

---Get Coordinate
---
------
---@param self ACT_ROUTE_POINT 
---@return COORDINATE #Coordinate The Coordinate to route to.
function ACT_ROUTE_POINT:GetCoordinate() end

---Get Range around Coordinate
---
------
---@param self ACT_ROUTE_POINT 
---@return number #The Range to consider the arrival. Default is 10000 meters.
function ACT_ROUTE_POINT:GetRange() end

---Creates a new routing state machine.
---The task will route a controllable to a Coordinate until the controllable is within the Range.
---
------
---@param self ACT_ROUTE_POINT 
---@param FsmRoute NOTYPE 
function ACT_ROUTE_POINT:Init(FsmRoute) end

---Creates a new routing state machine.
---The task will route a controllable to a Coordinate until the controllable is within the Range.
---
------
---@param self ACT_ROUTE_POINT 
---@param The COORDINATE Coordinate to Target.
---@param Range number The Distance to Target.
---@param Zone ZONE_BASE 
---@param Coordinate NOTYPE 
function ACT_ROUTE_POINT:New(The, Range, Zone, Coordinate) end

---Set Coordinate
---
------
---@param self ACT_ROUTE_POINT 
---@param Coordinate COORDINATE The Coordinate to route to.
function ACT_ROUTE_POINT:SetCoordinate(Coordinate) end

---Set Range around Coordinate
---
------
---@param self ACT_ROUTE_POINT 
---@param Range number The Range to consider the arrival. Default is 10000 meters.
function ACT_ROUTE_POINT:SetRange(Range) end

---StateMachine callback function
---
------
---@param self ACT_ROUTE_POINT 
---@param ProcessUnit UNIT 
---@param Event string 
---@param From string 
---@param To string 
---@private
function ACT_ROUTE_POINT:onafterReport(ProcessUnit, Event, From, To) end

---Method override to check if the controllable has arrived.
---
------
---@param self ACT_ROUTE_POINT 
---@param ProcessUnit UNIT 
---@return boolean #
---@private
function ACT_ROUTE_POINT:onfuncHasArrived(ProcessUnit) end


---ACT_ROUTE_ZONE class
---@class ACT_ROUTE_ZONE : ACT_ROUTE
---@field Altitude NOTYPE 
---@field ClassName string 
---@field DisplayCount number 
---@field DisplayInterval number 
---@field DisplayMessage boolean 
---@field DisplayTime number 
---@field Heading NOTYPE 
---@field ProcessUnit UNIT 
---@field TASK TASK 
---@field Zone ZONE_BASE 
ACT_ROUTE_ZONE = {}

---Get Zone
---
------
---@param self ACT_ROUTE_ZONE 
---@return ZONE_BASE #Zone The Zone object where to route to.
function ACT_ROUTE_ZONE:GetZone() end


---
------
---@param self NOTYPE 
---@param FsmRoute NOTYPE 
function ACT_ROUTE_ZONE:Init(FsmRoute) end

---Creates a new routing state machine.
---The task will route a controllable to a ZONE until the controllable is within that ZONE.
---
------
---@param self ACT_ROUTE_ZONE 
---@param Zone ZONE_BASE 
function ACT_ROUTE_ZONE:New(Zone) end

---Set Zone
---
------
---@param self ACT_ROUTE_ZONE 
---@param Zone ZONE_BASE The Zone object where to route to.
---@param Altitude number 
---@param Heading number 
function ACT_ROUTE_ZONE:SetZone(Zone, Altitude, Heading) end

---StateMachine callback function
---
------
---@param self ACT_ROUTE_ZONE 
---@param ProcessUnit UNIT 
---@param Event string 
---@param From string 
---@param To string 
---@private
function ACT_ROUTE_ZONE:onafterReport(ProcessUnit, Event, From, To) end

---Method override to check if the controllable has arrived.
---
------
---@param self ACT_ROUTE 
---@param ProcessUnit UNIT 
---@return boolean #
---@private
function ACT_ROUTE_ZONE:onfuncHasArrived(ProcessUnit) end



