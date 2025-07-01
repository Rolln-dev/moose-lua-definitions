---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/OPS_Target.png" width="100%">
---
---**Ops** - Target.
---
---**Main Features:**
---
---   * Manages target, number alive, life points, damage etc.
---   * Events when targets are damaged or destroyed
---   * Various target objects: UNIT, GROUP, STATIC, SCENERY, AIRBASE, COORDINATE, ZONE, SET_GROUP, SET_UNIT, SET_STATIC, SET_SCENERY, SET_ZONE
---
---===
---
---### Author: **funkyfranky**
---### Additions: **applevangelist**
---**It is far more important to be able to hit the target than it is to haggle over who makes a weapon or who pulls a trigger** -- Dwight D Eisenhower
---
---===
---
---# The TARGET Concept
---
---Define a target of your mission and monitor its status.
---Events are triggered when the target is damaged or destroyed.
---
---A target can consist of one or multiple "objects".
---TARGET class.
---@class TARGET : FSM
---@field Category TARGET.Category 
---@field ClassName string Name of the class.
---@field N0 number Number of initial target elements/units.
---@field Ndead number Number of target elements/units that are dead (destroyed or despawned).
---@field Ndestroyed number Number of target elements/units that were destroyed.
---@field Ntargets0 number Number of initial target objects.
---@field ObjectStatus TARGET.ObjectStatus 
---@field ObjectType TARGET.ObjectType 
---@field TStatus number 
---@field private casualties table Table of dead element names.
---@field private category number Target category (Ground, Air, Sea).
---@field private conditionStart table Start condition functions.
---@field private contact INTEL.Contact Contact attached to this target.
---@field private elements table Table of target elements/units.
---@field private importance number Importance.
---@field private isDestroyed boolean If true, target objects were destroyed.
---@field private lid string Class id string for output to DCS log file.
---@field private life number Total life points on last status update.
---@field private life0 number Total life points of completely healthy targets.
---@field private mission AUFTRAG Mission attached to this target.
---@field private name NOTYPE 
---@field private operation OPERATION Operation this target is part of.
---@field private prio number Priority.
---@field private resources table Resource list.
---@field private targetcounter number Running number to generate target object IDs.
---@field private targets table Table of target objects.
---@field private threatlevel0 number Initial threat level.
---@field private uid number Unique ID of the target.
---@field private verbose number Verbosity level.
---@field private version string TARGET class version.
TARGET = {}

---Add start condition.
---
------
---@param self TARGET 
---@param ConditionFunction function Function that needs to be true before the mission can be started. Must return a #boolean.
---@param ... NOTYPE Condition function arguments if any.
---@return TARGET #self
function TARGET:AddConditionStart(ConditionFunction, ...) end

---Add stop condition.
---
------
---@param self TARGET 
---@param ConditionFunction function Function that needs to be true before the mission can be started. Must return a #boolean.
---@param ... NOTYPE Condition function arguments if any.
---@return TARGET #self
function TARGET:AddConditionStop(ConditionFunction, ...) end

---Create target data from a given object.
---Valid objects are:
---
---* GROUP
---* UNIT
---* STATIC
---* SCENERY
---* AIRBASE
---* COORDINATE
---* ZONE
---* SET_GROUP
---* SET_UNIT
---* SET_STATIC
---* SET_SCENERY
---* SET_OPSGROUP
---* SET_ZONE
---* SET_OPSZONE
---
------
---@param self TARGET 
---@param Object POSITIONABLE The target UNIT, GROUP, STATIC, SCENERY, AIRBASE, COORDINATE, ZONE, SET_GROUP, SET_UNIT, SET_STATIC, SET_SCENERY, SET_ZONE
function TARGET:AddObject(Object) end

---Add mission type and number of required assets to resource.
---
------
---@param self TARGET 
---@param MissionType string Mission Type.
---@param Nmin number Min number of required assets.
---@param Nmax number Max number of requried assets.
---@param Attributes table Generalized attribute(s).
---@param Properties table DCS attribute(s). Default `nil`.
---@return TARGET.Resource #The resource table.
function TARGET:AddResource(MissionType, Nmin, Nmax, Attributes, Properties) end

---Count alive objects.
---
------
---@param self TARGET 
---@param Target TARGET.Object Target objective.
---@param Coalitions? table (Optional) Only count targets of the given coalition(s). 
---@return number #Number of alive target objects.
function TARGET:CountObjectives(Target, Coalitions) end

---Count alive targets.
---
------
---@param self TARGET 
---@param Coalitions? table (Optional) Only count targets of the given coalition(s). 
---@return number #Number of alive target objects.
function TARGET:CountTargets(Coalitions) end

---Triggers the FSM event "Damaged".
---
------
---@param self TARGET 
function TARGET:Damaged() end

---Triggers the FSM event "Dead".
---
------
---@param self TARGET 
function TARGET:Dead() end

---Triggers the FSM event "Destroyed".
---
------
---@param self TARGET 
function TARGET:Destroyed() end

---Check if all given condition are true.
---
------
---@param self TARGET 
---@param Conditions table Table of conditions.
---@return boolean #If true, all conditions were true. Returns false if at least one condition returned false.
function TARGET:EvalConditionsAll(Conditions) end

---Check if any of the given conditions is true.
---
------
---@param self TARGET 
---@param Conditions table Table of conditions.
---@return boolean #If true, at least one condition is true.
function TARGET:EvalConditionsAny(Conditions) end

---Get average coordinate.
---
------
---@param self TARGET 
---@return COORDINATE #Coordinate of the target.
function TARGET:GetAverageCoordinate() end

---Get category.
---
------
---@param self TARGET 
---@return string #Target category. See `TARGET.Category.X`, where `X=AIRCRAFT, GROUND`.
function TARGET:GetCategory() end

---Get coordinate.
---
------
---@param self TARGET 
---@return COORDINATE #Coordinate of the target.
function TARGET:GetCoordinate() end

---Get coordinates of all targets.
---(e.g. for a SET_STATIC)
---
------
---@param self TARGET 
---@return table #Table with coordinates of all targets.
function TARGET:GetCoordinates() end

---Get current damage.
---
------
---@param self TARGET 
---@return number #Damage in percent.
function TARGET:GetDamage() end

---Get heading of target.
---
------
---@param self TARGET 
---@return number #Heading of the target in degrees.
function TARGET:GetHeading() end

---Get current total life points.
---This is the sum of all target objects.
---
------
---@param self TARGET 
---@return number #Life points of target.
function TARGET:GetLife() end

---Get target life points.
---
------
---@param self TARGET 
---@return number #Number of initial life points when mission was planned.
function TARGET:GetLife0() end

---Get name.
---
------
---@param self TARGET 
---@return string #Name of the target usually the first object.
function TARGET:GetName() end

---Get the first target object alive.
---
------
---@param self TARGET 
---@param RefCoordinate COORDINATE Reference coordinate to determine the closest target objective.
---@param Coalitions? table (Optional) Only consider targets of the given coalition(s). 
---@return POSITIONABLE #The target object or nil.
function TARGET:GetObject(RefCoordinate, Coalitions) end

---Get the first target objective alive.
---
------
---@param self TARGET 
---@param RefCoordinate? COORDINATE (Optional) Reference coordinate to determine the closest target objective.
---@param Coalitions? table (Optional) Only consider targets of the given coalition(s). 
---@return TARGET.Object #The target objective.
function TARGET:GetObjective(RefCoordinate, Coalitions) end

---Get all target objects.
---
------
---@param self TARGET 
---@return table #List of target objects.
function TARGET:GetObjects() end

---Get a target object by its name.
---
------
---@param self TARGET 
---@param ObjectName string Object name.
---@return TARGET.Object #The target object table or nil.
function TARGET:GetTargetByName(ObjectName) end

---Get target category.
---
------
---@param self TARGET 
---@param Target TARGET.Object Target object.
---@return TARGET.Category #Target category.
function TARGET:GetTargetCategory(Target) end

---Get coalition of target object.
---If an object has no coalition (*e.g.* a coordinate) it is returned as neutral.
---
------
---@param self TARGET 
---@param Target TARGET.Object Target object.
---@return number #Coalition number.
function TARGET:GetTargetCoalition(Target) end

---Get target coordinate.
---
------
---@param self TARGET 
---@param Target TARGET.Object Target object.
---@param Average boolean 
---@return COORDINATE #Coordinate of the target.
function TARGET:GetTargetCoordinate(Target, Average) end

---Get heading of the target.
---
------
---@param self TARGET 
---@param Target TARGET.Object Target object.
---@return number #Heading in degrees.
function TARGET:GetTargetHeading(Target) end

---Get target life points.
---
------
---@param self TARGET 
---@param Target TARGET.Object Target object.
---@return number #Life points of target.
function TARGET:GetTargetLife(Target) end

---Get target name.
---
------
---@param self TARGET 
---@param Target TARGET.Object Target object.
---@return string #Name of the target object.
function TARGET:GetTargetName(Target) end

---Get target threat level
---
------
---@param self TARGET 
---@param Target TARGET.Object Target object.
---@return number #Threat level of target.
function TARGET:GetTargetThreatLevelMax(Target) end

---Get target 2D position vector.
---
------
---@param self TARGET 
---@param Target TARGET.Object Target object.
---@return Vec2 #Vector with x,y components.
function TARGET:GetTargetVec2(Target) end

---Get target 3D position vector.
---
------
---@param self TARGET 
---@param Target TARGET.Object Target object.
---@param Average boolean 
---@return Vec3 #Vector with x,y,z components.
function TARGET:GetTargetVec3(Target, Average) end

---Get threat level.
---
------
---@param self TARGET 
---@return number #Threat level.
function TARGET:GetThreatLevelMax() end

---Get 2D vector.
---
------
---@param self TARGET 
---@return Vec2 #2D vector of the target.
function TARGET:GetVec2() end

---Get 3D vector.
---
------
---@param self TARGET 
---@return Vec3 #3D vector of the target.
function TARGET:GetVec3() end

---Check if TARGET is alive.
---
------
---@param self TARGET 
---@return boolean #If true, target is alive.
function TARGET:IsAlive() end

---Check if something is a a casualty of this TARGET.
---
------
---@param self TARGET 
---@param Name string The name of the potential element.
---@return boolean #If `true`, this name is a casualty of this TARGET.
function TARGET:IsCasualty(Name) end

---Check if TARGET is dead.
---
------
---@param self TARGET 
---@return boolean #If true, target is dead.
function TARGET:IsDead() end

---Check if TARGET is destroyed.
---
------
---@param self TARGET 
---@return boolean #If true, target is destroyed.
function TARGET:IsDestroyed() end

---Check if something is an element of the TARGET.
---
------
---@param self TARGET 
---@param Name string The name of the potential element.
---@return boolean #If `true`, this name is part of this TARGET.
function TARGET:IsElement(Name) end

---Check if target object is alive.
---
------
---@param self TARGET 
---@param TargetObject TARGET.Object The target object.
---@return boolean #If true, target is dead.
function TARGET:IsTargetAlive(TargetObject) end

---Check if target object is dead.
---
------
---@param self TARGET 
---@param TargetObject TARGET.Object The target object.
---@return boolean #If true, target is dead.
function TARGET:IsTargetDead(TargetObject) end

---Create a new TARGET object and start the FSM.
---
------
---@param self TARGET 
---@param TargetObject table Target object. Can be a: UNIT, GROUP, STATIC, SCENERY, AIRBASE, COORDINATE, ZONE, SET_GROUP, SET_UNIT, SET_STATIC, SET_SCENERY, SET_ZONE
---@return TARGET #self
function TARGET:New(TargetObject) end

---Triggers the FSM event "ObjectDamaged".
---
------
---@param self TARGET 
---@param Target TARGET.Object Target object.
function TARGET:ObjectDamaged(Target) end

---Triggers the FSM event "ObjectDead".
---
------
---@param self TARGET 
---@param Target TARGET.Object Target object.
function TARGET:ObjectDead(Target) end

---Triggers the FSM event "ObjectDestroyed".
---
------
---@param self TARGET 
---@param Target TARGET.Object Target object.
function TARGET:ObjectDestroyed(Target) end

---On After "Damaged" event.
---Any of the target objects has been damaged.
---
------
---@param self TARGET 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function TARGET:OnAfterDamaged(From, Event, To) end

---On After "Dead" event.
---All target objects are dead.
---
------
---@param self TARGET 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function TARGET:OnAfterDead(From, Event, To) end

---On After "Destroyed" event.
---All target objects have been destroyed.
---
------
---@param self TARGET 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function TARGET:OnAfterDestroyed(From, Event, To) end

---On After "ObjectDamaged" event.
---A (sub-) target object has been damaged, e.g. a UNIT of a GROUP, or an object of a SET
---
------
---@param self TARGET 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Target TARGET.Object Target object.
function TARGET:OnAfterObjectDamaged(From, Event, To, Target) end

---On After "ObjectDead" event.
---A (sub-) target object is dead, e.g. a UNIT of a GROUP, or an object of a SET
---
------
---@param self TARGET 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Target TARGET.Object Target object.
function TARGET:OnAfterObjectDead(From, Event, To, Target) end

---On After "ObjectDestroyed" event.
---A (sub-) target object has been destroyed, e.g. a UNIT of a GROUP, or an object of a SET
---
------
---@param self TARGET 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Target TARGET.Object Target object.
function TARGET:OnAfterObjectDestroyed(From, Event, To, Target) end

---Event function handling the loss of a unit.
---
------
---@param self TARGET 
---@param EventData EVENTDATA Event data.
function TARGET:OnEventUnitDeadOrLost(EventData) end

---Set importance of the target.
---
------
---@param self TARGET 
---@param Importance number Importance of the target. Default `nil`.
---@return TARGET #self
function TARGET:SetImportance(Importance) end

---Set priority of the target.
---
------
---@param self TARGET 
---@param Priority number Priority of the target. Default 50.
---@return TARGET #self
function TARGET:SetPriority(Priority) end

---Triggers the FSM event "Start".
---Starts the TARGET. Initializes parameters and starts event handlers.
---
------
---@param self TARGET 
function TARGET:Start() end

---Triggers the FSM event "Status".
---
------
---@param self TARGET 
function TARGET:Status() end

---Create target data from a given object.
---
------
---@param self TARGET 
---@param Object POSITIONABLE The target UNIT, GROUP, STATIC, SCENERY, AIRBASE, COORDINATE, ZONE, SET_GROUP, SET_UNIT, SET_STATIC, SET_SCENERY, SET_ZONE
function TARGET:_AddObject(Object) end

---Triggers the FSM event "Start" after a delay.
---Starts the TARGET. Initializes parameters and starts event handlers.
---
------
---@param self TARGET 
---@param delay number Delay in seconds.
function TARGET:__Start(delay) end

---Triggers the FSM event "Status" after a delay.
---
------
---@param self TARGET 
---@param delay number Delay in seconds.
function TARGET:__Status(delay) end

---Triggers the FSM event "Stop" after a delay.
---Stops the TARGET and all its event handlers.
---
------
---@param self TARGET 
---@param delay number Delay in seconds.
function TARGET:__Stop(delay) end

---On after "Damaged" event.
---
------
---@param self TARGET 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function TARGET:onafterDamaged(From, Event, To) end

---On after "Dead" event.
---
------
---@param self TARGET 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function TARGET:onafterDead(From, Event, To) end

---On after "Destroyed" event.
---
------
---@param self TARGET 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function TARGET:onafterDestroyed(From, Event, To) end

---On after "ObjectDamaged" event.
---
------
---@param self TARGET 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Target TARGET.Object Target object.
---@private
function TARGET:onafterObjectDamaged(From, Event, To, Target) end

---On after "ObjectDead" event.
---
------
---@param self TARGET 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Target TARGET.Object Target object.
---@private
function TARGET:onafterObjectDead(From, Event, To, Target) end

---On after "ObjectDestroyed" event.
---
------
---@param self TARGET 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Target TARGET.Object Target object.
---@private
function TARGET:onafterObjectDestroyed(From, Event, To, Target) end

---On after Start event.
---Starts the FLIGHTGROUP FSM and event handlers.
---
------
---@param self TARGET 
---@param Group GROUP Flight group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function TARGET:onafterStart(Group, From, Event, To) end

---On after "Status" event.
---
------
---@param self TARGET 
---@param Group GROUP Flight group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function TARGET:onafterStatus(Group, From, Event, To) end


---Category.
---@class TARGET.Category 
---@field AIRBASE string 
---@field AIRCRAFT string 
---@field COORDINATE string 
---@field GROUND string 
---@field NAVAL string 
---@field ZONE string 
TARGET.Category = {}


---Target object.
---@class TARGET.Object 
---@field Coordinate COORDINATE of the target object.
---@field ID number Target unique ID.
---@field Life number Life points on last status update.
---@field Life0 number Life points of completely healthy target.
---@field N0 number Number of initial elements.
---@field Name string Target name.
---@field Ndead number Number of dead elements.
---@field Ndestroyed number Number of destroyed elements.
---@field Object POSITIONABLE The object, which can be many things, e.g. a UNIT, GROUP, STATIC, SCENERY, AIRBASE or COORDINATE object.
---@field Status string Status "Alive" or "Dead".
---@field Type string Target type.
TARGET.Object = {}


---Object status.
---@class TARGET.ObjectStatus 
---@field ALIVE string Object is alive.
---@field DAMAGED string Object is damaged.
---@field DEAD string Object is dead.
TARGET.ObjectStatus = {}


---Type.
---@class TARGET.ObjectType 
---@field AIRBASE string Target is an AIRBASE.
---@field COORDINATE string Target is a COORDINATE.
---@field GROUP string Target is a GROUP object.
---@field OPSZONE string Target is an OPSZONE object.
---@field SCENERY string Target is a SCENERY object.
---@field STATIC string Target is a STATIC object.
---@field UNIT string Target is a UNIT object.
---@field ZONE string Target is a ZONE object.
TARGET.ObjectType = {}


---Resource.
---@class TARGET.Resource 
---@field Attributes table Generalized attribute, e.g. `{GROUP.Attribute.GROUND_INFANTRY}`.
---@field MissionType string Mission type, e.g. `AUFTRAG.Type.BAI`.
---@field Nmax number Max number of assets.
---@field Nmin number Min number of assets.
---@field Properties table Properties ([DCS attributes](https://wiki.hoggitworld.com/view/DCS_enum_attributes)), e.g. `"Attack helicopters"` or `"Mobile AAA"`.
---@field private mission AUFTRAG Attached mission.
TARGET.Resource = {}



