---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Core_Event.JPG" width="100%">
---
---**Core** - Models DCS event dispatching using a publish-subscribe model.
---
---===
---
---## Features:
---
---  * Capture DCS events and dispatch them to the subscribed objects.
---  * Generate DCS events to the subscribed objects from within the code.
---
---===
---
---# Event Handling Overview
---
---![Objects](..\Presentations\EVENT\Dia2.JPG)
---
---Within a running mission, various DCS events occur. Units are dynamically created, crash, die, shoot stuff, get hit etc.
---This module provides a mechanism to dispatch those events occurring within your running mission, to the different objects orchestrating your mission.
---
---![Objects](..\Presentations\EVENT\Dia3.JPG)
---
---Objects can subscribe to different events. The Event dispatcher will publish the received DCS events to the subscribed MOOSE objects, in a specified order.
---In this way, the subscribed MOOSE objects are kept in sync with your evolving running mission.
---
---## 1. Event Dispatching
---
---![Objects](..\Presentations\EVENT\Dia4.JPG)
---
---The _EVENTDISPATCHER object is automatically created within MOOSE,
---and handles the dispatching of DCS Events occurring
---in the simulator to the subscribed objects
---in the correct processing order.
---
---![Objects](..\Presentations\EVENT\Dia5.JPG)
---
---There are 5 types/levels of objects that the _EVENTDISPATCHER services:
---
--- * _DATABASE object: The core of the MOOSE objects. Any object that is created, deleted or updated, is done in this database.
--- * SET_ derived classes: These are subsets of the global _DATABASE object (an instance of Core.Database#DATABASE). These subsets are updated by the _EVENTDISPATCHER as the second priority.
--- * UNIT objects: UNIT objects can subscribe to DCS events. Each DCS event will be directly published to the subscribed UNIT object.
--- * GROUP objects: GROUP objects can subscribe to DCS events. Each DCS event will be directly published to the subscribed GROUP object.
--- * Any other object: Various other objects can subscribe to DCS events. Each DCS event triggered will be published to each subscribed object.
---
---![Objects](..\Presentations\EVENT\Dia6.JPG)
---
---For most DCS events, the above order of updating will be followed.
---
---![Objects](..\Presentations\EVENT\Dia7.JPG)
---
---But for some DCS events, the publishing order is reversed. This is due to the fact that objects need to be **erased** instead of added.
---
---# 2. Event Handling
---
---![Objects](..\Presentations\EVENT\Dia8.JPG)
---
---The actual event subscribing and handling is not facilitated through the _EVENTDISPATCHER, but it is done through the Core.Base#BASE class, Wrapper.Unit#UNIT class and Wrapper.Group#GROUP class.
---The _EVENTDISPATCHER is a component that is quietly working in the background of MOOSE.
---
---![Objects](..\Presentations\EVENT\Dia9.JPG)
---
---The BASE class provides methods to catch DCS Events. These are events that are triggered from within the DCS simulator,
---and handled through lua scripting. MOOSE provides an encapsulation to handle these events more efficiently.
---
---## 2.1. Subscribe to / Unsubscribe from DCS Events.
---
---At first, the mission designer will need to **Subscribe** to a specific DCS event for the class.
---So, when the DCS event occurs, the class will be notified of that event.
---There are two functions which you use to subscribe to or unsubscribe from an event.
---
---  * Core.Base#BASE.HandleEvent(): Subscribe to a DCS Event.
---  * Core.Base#BASE.UnHandleEvent(): Unsubscribe from a DCS Event.
---
---Note that for a UNIT, the event will be handled **for that UNIT only**!
---Note that for a GROUP, the event will be handled **for all the UNITs in that GROUP only**!
---
---For all objects of other classes, the subscribed events will be handled for **all UNITs within the Mission**!
---So if a UNIT within the mission has the subscribed event for that object,
---then the object event handler will receive the event for that UNIT!
---
---## 2.2 Event Handling of DCS Events
---
---Once the class is subscribed to the event, an **Event Handling** method on the object or class needs to be written that will be called
---when the DCS event occurs. The Event Handling method receives an Core.Event#EVENTDATA structure, which contains a lot of information
---about the event that occurred.
---
---Find below an example of the prototype how to write an event handling function for two units:
---
---     local Tank1 = UNIT:FindByName( "Tank A" )
---     local Tank2 = UNIT:FindByName( "Tank B" )
---
---     -- Here we subscribe to the Dead events. So, if one of these tanks dies, the Tank1 or Tank2 objects will be notified.
---     Tank1:HandleEvent( EVENTS.Dead )
---     Tank2:HandleEvent( EVENTS.Dead )
---
---     --- This function is an Event Handling function that will be called when Tank1 is Dead.
---     -- @param Wrapper.Unit#UNIT self
---     -- @param Core.Event#EVENTDATA EventData
---     function Tank1:OnEventDead( EventData )
---
---       self:SmokeGreen()
---     end
---
---     --- This function is an Event Handling function that will be called when Tank2 is Dead.
---     -- @param Wrapper.Unit#UNIT self
---     -- @param Core.Event#EVENTDATA EventData
---     function Tank2:OnEventDead( EventData )
---
---       self:SmokeBlue()
---     end
---
---## 2.3 Event Handling methods that are automatically called upon subscribed DCS events.
---
---![Objects](..\Presentations\EVENT\Dia10.JPG)
---
---The following list outlines which EVENTS item in the structure corresponds to which Event Handling method.
---Always ensure that your event handling methods align with the events being subscribed to, or nothing will be executed.
---
---# 3. EVENTS type
---
---The EVENTS structure contains names for all the different DCS events that objects can subscribe to using the
---Core.Base#BASE.HandleEvent() method.
---
---# 4. EVENTDATA type
---
---The Core.Event#EVENTDATA structure contains all the fields that are populated with event information before
---an Event Handler method is being called by the event dispatcher.
---The Event Handler received the EVENTDATA object as a parameter, and can be used to investigate further the different events.
---There are basically 4 main categories of information stored in the EVENTDATA structure:
---
---   * Initiator Unit data: Several fields documenting the initiator unit related to the event.
---   * Target Unit data: Several fields documenting the target unit related to the event.
---   * Weapon data: Certain events populate weapon information.
---   * Place data: Certain events populate place information.
---
---     --- This function is an Event Handling function that will be called when Tank1 is Dead.
---     -- EventData is an EVENTDATA structure.
---     -- We use the EventData.IniUnit to smoke the tank Green.
---     -- @param Wrapper.Unit#UNIT self
---     -- @param Core.Event#EVENTDATA EventData
---     function Tank1:OnEventDead( EventData )
---
---       EventData.IniUnit:SmokeGreen()
---     end
---
---
---Find below an overview which events populate which information categories:
---
---![Objects](..\Presentations\EVENT\Dia14.JPG)
---
---**IMPORTANT NOTE:** Some events can involve not just UNIT objects, but also STATIC objects!!!
---In that case the initiator or target unit fields will refer to a STATIC object!
---In case a STATIC object is involved, the documentation indicates which fields will and won't not be populated.
---The fields **IniObjectCategory** and **TgtObjectCategory** contain the indicator which **kind of object is involved** in the event.
---You can use the enumerator **Object.Category.UNIT** and **Object.Category.STATIC** to check on IniObjectCategory and TgtObjectCategory.
---Example code snippet:
---
---     if Event.IniObjectCategory == Object.Category.UNIT then
---      ...
---     end
---     if Event.IniObjectCategory == Object.Category.STATIC then
---      ...
---     end
---
---When a static object is involved in the event, the Group and Player fields won't be populated.
---
---===
---
---### Author: **FlightControl**
---### Contributions:
---
---===
---The EVENT class
---@class EVENT : BASE
---@field Events EVENT.Events 
---@field MissionEnd boolean 
EVENT = {}

---Creation of a Cargo Deletion Event.
---
------
---@param self EVENT 
---@param Cargo AI_CARGO The Cargo created.
function EVENT:CreateEventDeleteCargo(Cargo) end

---Creation of a Zone Deletion Event.
---
------
---@param self EVENT 
---@param Zone ZONE_BASE The Zone created.
function EVENT:CreateEventDeleteZone(Zone) end

---Creation of a ZoneGoal Deletion Event.
---
------
---@param self EVENT 
---@param ZoneGoal ZONE_GOAL The ZoneGoal created.
function EVENT:CreateEventDeleteZoneGoal(ZoneGoal) end

---Creation of a S_EVENT_DYNAMIC_CARGO_LOADED event.
---
------
---@param self EVENT 
---@param DynamicCargo DYNAMICCARGO the dynamic cargo object
function EVENT:CreateEventDynamicCargoLoaded(DynamicCargo) end

---Creation of a S_EVENT_DYNAMIC_CARGO_REMOVED event.
---
------
---@param self EVENT 
---@param DynamicCargo DYNAMICCARGO the dynamic cargo object
function EVENT:CreateEventDynamicCargoRemoved(DynamicCargo) end

---Creation of a S_EVENT_DYNAMIC_CARGO_UNLOADED event.
---
------
---@param self EVENT 
---@param DynamicCargo DYNAMICCARGO the dynamic cargo object
function EVENT:CreateEventDynamicCargoUnloaded(DynamicCargo) end

---Creation of a New Cargo Event.
---
------
---@param self EVENT 
---@param Cargo AI_CARGO The Cargo created.
function EVENT:CreateEventNewCargo(Cargo) end

---Creation of a S_EVENT_NEW_DYNAMIC_CARGO event.
---
------
---@param self EVENT 
---@param DynamicCargo DYNAMICCARGO the dynamic cargo object
function EVENT:CreateEventNewDynamicCargo(DynamicCargo) end

---Creation of a New Zone Event.
---
------
---@param self EVENT 
---@param Zone ZONE_BASE The Zone created.
function EVENT:CreateEventNewZone(Zone) end

---Creation of a New ZoneGoal Event.
---
------
---@param self EVENT 
---@param ZoneGoal ZONE_GOAL The ZoneGoal created.
function EVENT:CreateEventNewZoneGoal(ZoneGoal) end

---Creation of a S_EVENT_PLAYER_ENTER_AIRCRAFT event.
---
------
---@param self EVENT 
---@param PlayerUnit UNIT The aircraft unit the player entered.
function EVENT:CreateEventPlayerEnterAircraft(PlayerUnit) end

---Creation of a S_EVENT_PLAYER_ENTER_UNIT Event.
---
------
---@param self EVENT 
---@param PlayerUnit UNIT 
function EVENT:CreateEventPlayerEnterUnit(PlayerUnit) end

---Initializes the Events structure for the event.
---
------
---@param self EVENT 
---@param EventID world.event Event ID.
---@param EventClass BASE The class object for which events are handled.
---@return EVENT.Events #
function EVENT:Init(EventID, EventClass) end

---Create new event handler.
---
------
---@param self EVENT 
---@return EVENT #self
function EVENT:New() end

---Create an OnBirth event handler for a group
---
------
---@param self EVENT 
---@param EventGroup GROUP 
---@param EventFunction function The function to be called when the event occurs for the unit.
---@param EventClass NOTYPE The self instance of the class for which the event is.
---@param EventTemplate NOTYPE 
---@return EVENT #self
function EVENT:OnBirthForTemplate(EventGroup, EventFunction, EventClass, EventTemplate) end

---Create an OnCrash event handler for a group
---
------
---@param self EVENT 
---@param EventGroup GROUP 
---@param EventFunction function The function to be called when the event occurs for the unit.
---@param EventClass NOTYPE The self instance of the class for which the event is.
---@param EventTemplate NOTYPE 
---@return EVENT #
function EVENT:OnCrashForTemplate(EventGroup, EventFunction, EventClass, EventTemplate) end

---Create an OnDead event handler for a group
---
------
---@param self EVENT 
---@param EventGroup GROUP The GROUP object.
---@param EventFunction function The function to be called when the event occurs for the unit.
---@param EventClass table The self instance of the class for which the event is.
---@param EventTemplate NOTYPE 
---@return EVENT #self
function EVENT:OnDeadForTemplate(EventGroup, EventFunction, EventClass, EventTemplate) end

---Create an OnDead event handler for a group
---
------
---@param self EVENT 
---@param EventTemplate table 
---@param EventFunction function The function to be called when the event occurs for the unit.
---@param EventClass NOTYPE The self instance of the class for which the event is.
---@return EVENT #
function EVENT:OnEngineShutDownForTemplate(EventTemplate, EventFunction, EventClass) end

---Set a new listener for an S_EVENT_X event for a GROUP.
---
------
---@param self EVENT 
---@param GroupName string The name of the GROUP.
---@param EventFunction function The function to be called when the event occurs for the GROUP.
---@param EventClass BASE The self instance of the class for which the event is.
---@param EventID number Event ID.
---@param ... NOTYPE Optional arguments passed to the event function.
---@return EVENT #self
function EVENT:OnEventForGroup(GroupName, EventFunction, EventClass, EventID, ...) end

---Create an OnDead event handler for a group
---
------
---@param self EVENT 
---@param EventTemplate table 
---@param EventFunction function The function to be called when the event occurs for the unit.
---@param EventClass NOTYPE The instance of the class for which the event is.
---@param OnEventFunction function 
---@param EventID NOTYPE 
---@return EVENT #self
function EVENT:OnEventForTemplate(EventTemplate, EventFunction, EventClass, OnEventFunction, EventID) end

---Set a new listener for an `S_EVENT_X` event for a UNIT.
---
------
---@param self EVENT 
---@param UnitName string The name of the UNIT.
---@param EventFunction function The function to be called when the event occurs for the GROUP.
---@param EventClass BASE The self instance of the class for which the event is.
---@param EventID NOTYPE 
---@return EVENT #self
function EVENT:OnEventForUnit(UnitName, EventFunction, EventClass, EventID) end

---Set a new listener for an `S_EVENT_X` event independent from a unit or a weapon.
---
------
---@param self EVENT 
---@param EventFunction function The function to be called when the event occurs for the unit.
---@param EventClass BASE The self instance of the class for which the event is captured. When the event happens, the event process will be called in this class provided.
---@param EventID NOTYPE 
---@return EVENT #
function EVENT:OnEventGeneric(EventFunction, EventClass, EventID) end

---Create an OnLand event handler for a group
---
------
---@param self EVENT 
---@param EventTemplate table 
---@param EventFunction function The function to be called when the event occurs for the unit.
---@param EventClass table The self instance of the class for which the event is.
---@return EVENT #self
function EVENT:OnLandForTemplate(EventTemplate, EventFunction, EventClass) end

---Create an OnTakeOff event handler for a group
---
------
---@param self EVENT 
---@param EventTemplate table Template table.
---@param EventFunction function The function to be called when the event occurs for the unit.
---@param EventClass table The self instance of the class for which the event is.
---@return EVENT #self
function EVENT:OnTakeOffForTemplate(EventTemplate, EventFunction, EventClass) end

---Clears all event subscriptions for a Core.Base#BASE derived object.
---
------
---@param self EVENT 
---@param EventClass BASE The self class object for which the events are removed.
---@return EVENT #self
function EVENT:RemoveAll(EventClass) end

---Removes a subscription
---
------
---@param self EVENT 
---@param EventClass BASE The self instance of the class for which the event is.
---@param EventID world.event Event ID.
---@return EVENT #self
function EVENT:RemoveEvent(EventClass, EventID) end

---Resets subscriptions.
---
------
---@param self EVENT 
---@param EventClass BASE The self instance of the class for which the event is.
---@param EventID world.event Event ID.
---@param EventObject NOTYPE 
---@return EVENT.Events #
function EVENT:Reset(EventClass, EventID, EventObject) end

---Main event function.
---
------
---@param self EVENT 
---@param Event EVENTDATA Event data table.
---@private
function EVENT:onEvent(Event) end


---The Events structure
---@class EVENT.Events 
---@field IniUnit number 
EVENT.Events = {}


---The Event structure
---Note that at the beginning of each field description, there is an indication which field will be populated depending on the object type involved in the Event:
---
---  * A (Object.Category.)UNIT : A UNIT object type is involved in the Event.
---  * A (Object.Category.)STATIC : A STATIC object type is involved in the Event.
---@class EVENTDATA 
---@field Cargo CARGO The cargo object.
---@field CargoName string The name of the cargo object.
---@field IniCategory Unit.Category (UNIT) The category of the initiator.
---@field IniCoalition coalition.side (UNIT) The coalition of the initiator.
---@field IniDCSGroup Group (UNIT) The initiating {DCSGroup#Group}.
---@field IniDCSGroupName string (UNIT) The initiating Group name.
---@field IniDCSUnit Unit (UNIT/STATIC) The initiating @{DCS#Unit} or @{DCS#StaticObject}.
---@field IniDCSUnitName string (UNIT/STATIC) The initiating Unit name.
---@field IniDynamicCargo DYNAMICCARGO The dynamic cargo object.
---@field IniDynamicCargoName string The dynamic cargo unit name.
---@field IniGroup GROUP (UNIT) The initiating MOOSE wrapper @{Wrapper.Group#GROUP} of the initiator Group object.
---@field IniGroupName string UNIT) The initiating GROUP name (same as IniDCSGroupName).
---@field IniObjectCategory Object.Category (UNIT/STATIC/SCENERY) The initiator object category ( Object.Category.UNIT or Object.Category.STATIC ).
---@field IniPlayerName string (UNIT) The name of the initiating player in case the Unit is a client or player slot.
---@field IniPlayerUCID string (UNIT) The UCID of the initiating player in case the Unit is a client or player slot and on a multi-player server.
---@field IniTypeName string (UNIT) The type name of the initiator.
---@field IniUnit UNIT (UNIT/STATIC) The initiating MOOSE wrapper @{Wrapper.Unit#UNIT} of the initiator Unit object.
---@field IniUnitName string (UNIT/STATIC) The initiating UNIT name (same as IniDCSUnitName).
---@field MarkCoalition NOTYPE 
---@field MarkCoordinate NOTYPE 
---@field MarkGroupID NOTYPE 
---@field MarkID NOTYPE 
---@field MarkText NOTYPE 
---@field MarkVec3 NOTYPE 
---@field Place AIRBASE The MOOSE airbase object.
---@field PlaceName string The name of the airbase.
---@field TgtCategory Unit.Category (UNIT) The category of the target.
---@field TgtCoalition coalition.side (UNIT) The coalition of the target.
---@field TgtDCSGroup Group (UNIT) The target {DCSGroup#Group}.
---@field TgtDCSGroupName string (UNIT) The target Group name.
---@field TgtDCSUnit Unit (UNIT/STATIC) The target @{DCS#Unit} or @{DCS#StaticObject}.
---@field TgtDCSUnitName string (UNIT/STATIC) The target Unit name.
---@field TgtGroup GROUP (UNIT) The target MOOSE wrapper @{Wrapper.Group#GROUP} of the target Group object.
---@field TgtGroupName string (UNIT) The target GROUP name (same as TgtDCSGroupName).
---@field TgtObjectCategory Object.Category (UNIT/STATIC) The target object category ( Object.Category.UNIT or Object.Category.STATIC ).
---@field TgtPlayerName string (UNIT) The name of the target player in case the Unit is a client or player slot.
---@field TgtPlayerUCID string (UNIT) The UCID of the target player in case the Unit is a client or player slot and on a multi-player server.
---@field TgtTypeName string (UNIT) The type name of the target.
---@field TgtUnit UNIT (UNIT/STATIC) The target MOOSE wrapper @{Wrapper.Unit#UNIT} of the target Unit object.
---@field TgtUnitName string (UNIT/STATIC) The target UNIT name (same as TgtDCSUnitName).
---@field Weapon Weapon The weapon used during the event.
---@field WeaponName string Name of the weapon.
---@field WeaponTgtDCSUnit Unit Target DCS unit of the weapon.
---@field WeaponUNIT NOTYPE 
---@field Zone ZONE The zone object.
---@field ZoneName string The name of the zone.
---@field private id number The identifier of the event.
---@field private initiator Unit (UNIT/STATIC/SCENERY) The initiating @{DCS#Unit} or @{DCS#StaticObject}.
---@field private place Airbase The @{DCS#Airbase}
---@field private target Unit (UNIT/STATIC) The target @{DCS#Unit} or @{DCS#StaticObject}.
---@field private weapon Weapon The weapon used during the event.
EVENTDATA = {}


---The EVENTHANDLER structure.
---@class EVENTHANDLER : BASE
---@field ClassID number 
---@field ClassName string 
EVENTHANDLER = {}

---The EVENTHANDLER constructor.
---
------
---@param self EVENTHANDLER 
---@return EVENTHANDLER #self
function EVENTHANDLER:New() end


---The different types of events supported by MOOSE.
---Use this structure to subscribe to events using the Core.Base#BASE.HandleEvent() method.
---@class EVENTS 
---@field BaseCaptured NOTYPE 
---@field Birth NOTYPE 
---@field Crash NOTYPE 
---@field Dead NOTYPE 
---@field DeleteCargo NOTYPE 
---@field DeleteZone NOTYPE 
---@field DeleteZoneGoal NOTYPE 
---@field Ejection NOTYPE 
---@field EngineShutdown NOTYPE 
---@field EngineStartup NOTYPE 
---@field Hit NOTYPE 
---@field HumanFailure NOTYPE 
---@field Land NOTYPE 
---@field MarkAdded NOTYPE 
---@field MarkChange NOTYPE 
---@field MarkRemoved NOTYPE 
---@field MissionEnd NOTYPE 
---@field MissionStart NOTYPE 
---@field NewCargo NOTYPE 
---@field NewZone NOTYPE 
---@field NewZoneGoal NOTYPE 
---@field PilotDead NOTYPE 
---@field PlayerComment NOTYPE 
---@field PlayerEnterAircraft NOTYPE 
---@field PlayerEnterUnit NOTYPE 
---@field PlayerLeaveUnit NOTYPE 
---@field Refueling NOTYPE 
---@field RefuelingStop NOTYPE 
---@field RemoveUnit NOTYPE 
---@field ShootingEnd NOTYPE 
---@field ShootingStart NOTYPE 
---@field Shot NOTYPE 
---@field Takeoff NOTYPE 
---@field TookControl NOTYPE 
EVENTS = {}



