---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/MOOSE.JPG" width="100%">
---
---**DCS API** Prototypes.
---
---===
---
---See the [Simulator Scripting Engine Documentation](https://wiki.hoggitworld.com/view/Simulator_Scripting_Engine_Documentation) on Hoggit for further explanation and examples.
---[https://wiki.hoggitworld.com/view/DCS_enum_AI](https://wiki.hoggitworld.com/view/DCS_enum_AI)
---@class AI 
AI = {}


---@class AI.Option 
AI.Option = {}


---@class AI.Option.Air 
AI.Option.Air = {}


---@class AI.Option.Air.id 
AI.Option.Air.id = {}


---@class AI.Option.Air.val 
AI.Option.Air.val = {}


---@class AI.Option.Air.val.ECM_USING 
AI.Option.Air.val.ECM_USING = {}


---@class AI.Option.Air.val.FLARE_USING 
AI.Option.Air.val.FLARE_USING = {}


---@class AI.Option.Air.val.MISSILE_ATTACK 
AI.Option.Air.val.MISSILE_ATTACK = {}


---@class AI.Option.Air.val.RADAR_USING 
AI.Option.Air.val.RADAR_USING = {}


---@class AI.Option.Air.val.REACTION_ON_THREAT 
AI.Option.Air.val.REACTION_ON_THREAT = {}


---@class AI.Option.Air.val.ROE 
AI.Option.Air.val.ROE = {}


---@class AI.Option.Ground 
AI.Option.Ground = {}


---@class AI.Option.Ground.id 
AI.Option.Ground.id = {}


---@class AI.Option.Ground.mid 
AI.Option.Ground.mid = {}


---@class AI.Option.Ground.mval 
AI.Option.Ground.mval = {}


---@class AI.Option.Ground.mval.ENGAGE_TARGETS 
AI.Option.Ground.mval.ENGAGE_TARGETS = {}


---@class AI.Option.Ground.val 
AI.Option.Ground.val = {}


---@class AI.Option.Ground.val.ALARM_STATE 
AI.Option.Ground.val.ALARM_STATE = {}


---@class AI.Option.Ground.val.ROE 
AI.Option.Ground.val.ROE = {}


---@class AI.Option.Naval.id 
AI.Option.Naval.id = {}


---@class AI.Option.Naval.val 
AI.Option.Naval.val = {}


---@class AI.Option.Naval.val.ROE 
AI.Option.Naval.val.ROE = {}


---[https://wiki.hoggitworld.com/view/DCS_enum_AI](https://wiki.hoggitworld.com/view/DCS_enum_AI)
---@class AI.Skill 
AI.Skill = {}


---[https://wiki.hoggitworld.com/view/DCS_enum_AI](https://wiki.hoggitworld.com/view/DCS_enum_AI)
---@class AI.Task 
AI.Task = {}


---@class AI.Task.AltitudeType 
AI.Task.AltitudeType = {}


---[https://wiki.hoggitworld.com/view/DCS_enum_AI](https://wiki.hoggitworld.com/view/DCS_enum_AI)
---@class AI.Task.Designation 
AI.Task.Designation = {}


---[https://wiki.hoggitworld.com/view/DCS_enum_AI](https://wiki.hoggitworld.com/view/DCS_enum_AI)
---@class AI.Task.OrbitPattern 
AI.Task.OrbitPattern = {}


---@class AI.Task.TurnMethod 
AI.Task.TurnMethod = {}


---@class AI.Task.VehicleFormation 
AI.Task.VehicleFormation = {}


---@class AI.Task.WaypointType 
AI.Task.WaypointType = {}


---[https://wiki.hoggitworld.com/view/DCS_enum_AI](https://wiki.hoggitworld.com/view/DCS_enum_AI)
---@class AI.Task.WeaponExpend 
AI.Task.WeaponExpend = {}


---[DCS Class Airbase](https://wiki.hoggitworld.com/view/DCS_Class_Airbase)
---Represents airbases: airdromes, helipads and ships with flying decks or landing pads.

---@class Airbase : CoalitionObject
Airbase = {}

---Enables or disables the airbase and FARP auto capture game mechanic where ownership of a base can change based on the presence of ground forces or the 
---default setting assigned in the editor.
---
------
---@param self NOTYPE 
---@param setting boolean `true` : enables autoCapture behavior, `false` : disables autoCapture behavior
function Airbase:autoCapture(setting) end

---Returns the current autoCapture setting for the passed base.
---
------
---@param self NOTYPE 
---@return boolean #`true` if autoCapture behavior is enabled and `false` otherwise.
function Airbase:autoCaptureIsOn() end

---Returns airbase by its name.
---If no airbase found the function will return nil.
---
------
---@param name string 
---@return Airbase #
function Airbase.getByName(name) end

---Returns the airbase's callsign - the localized string.
---
------
---@param self NOTYPE 
---@return string #
function Airbase:getCallsign() end

---Returns descriptor of the airbase.
---
------
---@param self NOTYPE 
---@return Airbase.Desc #
function Airbase:getDesc() end

---Returns airbase descriptor by type name.
---If no descriptor is found the function will return nil.
---
------
---@param typeName TypeName Airbase type name.
---@return Airbase.Desc #
function Airbase.getDescByName(typeName) end

---Returns identifier of the airbase.
---
------
---@param self NOTYPE 
---@return Airbase.ID #
function Airbase:getID() end

---Returns the wsType of every object that exists in DCS.
---A wsType is a table consisting of 4 entries indexed numerically. 
---It can be used to broadly categorize object types. The table can be broken down as: {mainCategory, subCat1, subCat2, index}
---
------
---@param self NOTYPE 
---@return table #wsType of every object that exists in DCS.
function Airbase:getResourceMap() end

---Returns Unit that is corresponded to the airbase.
---Works only for ships.
---
------
---@param self NOTYPE 
---@return Unit #
function Airbase:getUnit() end

---Returns the warehouse object associated with the airbase object.
---Can then be used to call the warehouse class functions to modify the contents of the warehouse.
---
------
---@param self NOTYPE 
---@return Warehouse #The DCS warehouse object of this airbase.
function Airbase:getWarehouse() end

---Changes the passed airbase object's coalition to the set value.
---Must be used with Airbase.autoCapture to disable auto capturing of the base, 
---otherwise the base can revert back to a different coalition depending on the situation and built in game capture rules.
---
------
---@param self NOTYPE 
---@param coa number The new owner coalition: 0=neutra, 1=red, 2=blue.
function Airbase:setCoalition(coa) end


---Enum contains identifiers of airbase categories.
---@class Airbase.Category 
Airbase.Category = {}


---Airbase descriptor.
---Airdromes are unique and their types are unique, but helipads and ships are not always unique and may have the same type.
---@class Airbase.Desc : Desc
Airbase.Desc = {}


---3-dimensional box.
---@class Box3 
Box3 = {}


---[DCS Class CoalitionObject](https://wiki.hoggitworld.com/view/DCS_Class_Coalition_Object)
---@class CoalitionObject : Object
CoalitionObject = {}

---Returns coalition of the object.
---
------
---@param self CoalitionObject 
---@return coalition.side #
function CoalitionObject:getCoalition() end

---Returns object country.
---
------
---@param self CoalitionObject 
---@return country.id #
function CoalitionObject:getCountry() end


---Controller is an object that performs A.I.-tasks.
---Other words controller is an instance of A.I.. Controller stores current main task, active enroute tasks and behavior options. Controller performs commands. Please, read DCS A-10C GUI Manual EN.pdf chapter "Task Planning for Unit Groups", page 91 to understand A.I. system of DCS:A-10C. 
---
---This class has 2 types of functions:
---
---* Tasks
---* Commands: Commands are instant actions those required zero time to perform. Commands may be used both for control unit/group behavior and control game mechanics.
---@class Controller 
Controller = {}

---Returns list of detected targets.
---If one or more detection method is specified the function will return targets which were detected by at least one of these methods. If no detection methods are specified the function will return targets which were detected by any method.
---
------
---@param self NOTYPE 
---@param detection Controller.Detection Controller.Detection detection1, Controller.Detection detection2, ... Controller.Detection detectionN 
---@return list #array of DetectedTarget
function Controller:getDetectedTargets(detection) end

---Returns true if the controller has a task.
---
------
---@param self NOTYPE 
---@return boolean #
function Controller:hasTask() end

---Checks if the target is detected or not.
---If one or more detection method is specified the function will return true if the target is detected by at least one of these methods. If no detection methods are specified the function will return true if the target is detected by any method.
---
------
---@param self NOTYPE 
---@param target Object Target to check
---@param detection Controller.Detection Controller.Detection detection1, Controller.Detection detection2, ... Controller.Detection detectionN 
---@return boolean #detected True if the target is detected. 
---@return boolean #visible Has effect only if detected is true. True if the target is visible now. 
---@return boolean #type Has effect only if detected is true. True if the target type is known.
---@return boolean #distance Has effect only if detected is true. True if the distance to the target is known.
---@return ModelTime #lastTime Has effect only if visible is false. Last time when target was seen. 
---@return Vec3 #lastPos Has effect only if visible is false. Last position of the target when it was seen. 
---@return Vec3 #lastVel Has effect only if visible is false. Last velocity of the target when it was seen. 
function Controller:isTargetDetected(target, detection) end

---Know a target.
---
------
---@param self NOTYPE 
---@param object Object The target.
---@param type boolean Target type is known.
---@param distance boolean Distance to target is known.
function Controller:knowTarget(object, type, distance) end

---Pops current (front) task from the queue and makes active next task in the queue (if exists).
---If no more tasks in the queue the function works like function Controller.resetTask() function. Does nothing if the queue is empty.
---
------
---@param self NOTYPE 
function Controller:popTask() end

---Pushes the task to the front of the queue and makes the task active.
---Further call of function Controller.setTask() function will stop current task, clear the queue and set the new task active. If the task queue is empty the function will work like function Controller.setTask() function.
---
------
---@param self NOTYPE 
---@param task Task 
function Controller:pushTask(task) end

---Resets current task of the controller.
---
------
---@param self NOTYPE 
function Controller:resetTask() end

---Enables and disables the controller.
---Note: Now it works only for ground / naval groups!
---
------
---@param self NOTYPE 
---@param value boolean Enable / Disable.
function Controller:setOnOff(value) end

---Sets the option to the controller.
---Option is a pair of identifier and value. Behavior options are global parameters those affect controller behavior in all tasks it performs.
---Option identifiers and values are stored in table AI.Option in subtables Air, Ground and Naval.
---
---OptionId = #AI.Option.Air.id or #AI.Option.Ground.id or #AI.Option.Naval.id
---OptionValue = AI.Option.Air.val[optionName] or AI.Option.Ground.val[optionName] or AI.Option.Naval.val[optionName]
---
------
---@param self NOTYPE 
---@param optionId OptionId Option identifier. 
---@param optionValue OptionValue Value of the option.
function Controller:setOption(optionId, optionValue) end

---Resets current task and then sets the task to the controller.
---Task is a table that contains task identifier and task parameters.
---
------
---@param self NOTYPE 
---@param task Task 
function Controller:setTask(task) end


---Detected target.
---@class Controller.DetectedTarget 
---@field distance boolean Distance to the target is known
---@field object Object The target
---@field type boolean The target type is known
---@field visible boolean The target is visible
Controller.DetectedTarget = {}


---Enum containing detection types.
---@class Controller.Detection 
---@field DLINK number Data link detection. Numeric value 32.
---@field IRST number Infra-red search and track detection. Numeric value 8.
---@field OPTIC number Optical detection. Numeric value 2.
---@field RADAR number Radar detection. Numeric value 4.
---@field RWR number Radar Warning Receiver detection. Numeric value 16.
---@field VISUAL number Visual detection. Numeric value 1.
Controller.Detection = {}


---Descriptors.
---@class Desc 
---@field Hmax number Max height in meters.
---@field Kab number ?
---@field Kmax number ?
---@field NyMax number ?
---@field NyMin number ?
---@field RCS number ?
---@field VyMax number Max vertical velocity in m/s.
---@field category number Unit category.
---@field displayName string Localized display name.
---@field fuelMassMax number Max fuel mass in kg.
---@field life number Life points.
---@field massEmpty number Empty mass in kg.
---@field massMax number Max mass of unit.
---@field range number Range in km(?).
---@field speedMax0 number Max speed in meters/second at zero altitude.
---@field speedMax10K number Max speed in meters/second.
---@field tankerType number Type of refueling system: 0=boom, 1=probe.
Desc = {}


---Event structure.
---Note that present fields depend on type of event.
---@class Event 
---@field coalition number Coalition ID.
---@field comment string Comment, *e.g.* LSO score.
---@field groupID number Group ID, *e.g.* of group that added mark point.
---@field id number Event ID.
---@field idx number Mark ID.
---@field initiator Unit Unit initiating the event.
---@field place Airbase Airbase.
---@field pos Vec3 Position vector, *e.g.* of mark point.
---@field target Unit Target unit.
---@field text string Text, *e.g.* of mark point.
---@field time number Mission time in seconds.
---@field weapon_name string Weapoin name.
Event = {}


---Represents group of Units.
---@class Group 
Group = {}

---Destroys the group and all of its units.
---
------
---@param self Group 
function Group:destroy() end

---GROUND - Switch on/off radar emissions
---
------
---@param self Group 
---@param switch boolean 
function Group:enableEmission(switch) end

---Returns group by the name assigned to the group in Mission Editor.
---
------
---@param name string 
---@return Group #
function Group.getByName(name) end

---Returns category of the group.
---
------
---@param self Group 
---@return Group.Category #
function Group:getCategory() end

---Returns the coalition of the group.
---
------
---@param self Group 
---@return coalition.side #
function Group:getCoalition() end

---Returns controller of the group.
---
------
---@param self Group 
---@return Controller #
function Group:getController() end

---Returns the group identifier.
---
------
---@param self Group 
---@return ID #
function Group:getID() end

---Returns initial size of the group.
---If some of the units will be destroyed, initial size of the group will not be changed; Initial size limits the unitNumber parameter for Group.getUnit() function.
---
------
---@param self Group 
---@return number #
function Group:getInitialSize() end

---Returns the group's name.
---This is the same name assigned to the group in Mission Editor.
---
------
---@param self Group 
---@return string #
function Group:getName() end

---Returns current size of the group.
---If some of the units will be destroyed, As units are destroyed the size of the group will be changed.
---
------
---@param self Group 
---@return number #
function Group:getSize() end

---Returns the unit with number unitNumber.
---If the unit is not exists the function will return nil.
---
------
---@param self Group 
---@param unitNumber number 
---@return Unit #
function Group:getUnit(unitNumber) end

---Returns array of the units present in the group now.
---Destroyed units will not be enlisted at all.
---
------
---@param self Group 
---@return list #array of Units
function Group:getUnits() end

---returns true if the group exist or false otherwise.
---
------
---@param self Group 
---@return boolean #
function Group:isExist() end


---Enum contains identifiers of group types.
---@class Group.Category 
Group.Category = {}


---[DCS Class Object](https://wiki.hoggitworld.com/view/DCS_Class_Object)
---@class Object 
Object = {}


---
------
---@param self Object 
function Object:destroy() end

---Returns an enumerator of the category for the specific object.
---The enumerator returned is dependent on the category of the object and how the function is called. 
---As of DCS 2.9.2 when this function is called on an Object, Unit, Weapon, or Airbase a 2nd value will be returned which details the object sub-category value.
---
------
---@param self Object 
---@return Object.Category #The object category (1=UNIT, 2=WEAPON, 3=STATIC, 4=BASE, 5=SCENERY, 6=Cargo)
---@return number #The subcategory of the passed object, e.g. Unit.Category if a unit object was passed.
function Object:getCategory() end

---Returns object descriptor.
---
------
---@param self Object 
---@return Object.Desc #
function Object:getDesc() end

---Returns name of the object.
---This is the name that is assigned to the object in the Mission Editor.
---
------
---@param self Object 
---@return string #
function Object:getName() end

---Returns object coordinates for current time.
---
------
---@param self Object 
---@return Vec3 #3D position vector with x,y,z components.
function Object:getPoint() end

---Returns object position for current time.
---
------
---@param self Object 
---@return Position3 #
function Object:getPosition() end

---Returns type name of the Object.
---
------
---@param self Object 
---@return string #
function Object:getTypeName() end

---Returns the unit's velocity vector.
---
------
---@param self Object 
---@return Vec3 #3D velocity vector.
function Object:getVelocity() end

---Returns true if the object belongs to the category.
---
------
---@param self Object 
---@param attributeName AttributeName Attribute name to check.
---@return boolean #
function Object:hasAttribute(attributeName) end

---Returns true if the unit is in air.
---
------
---@param self Object 
---@return boolean #
function Object:inAir() end


---
------
---@param self Object 
---@return boolean #
function Object:isActive() end


---
------
---@param self Object 
---@return boolean #
function Object:isExist() end


---[DCS Enum Object.Category](https://wiki.hoggitworld.com/view/DCS_Class_Object)
---@class Object.Category 
Object.Category = {}


---Position is a composite structure.
---It consists of both coordinate vector and orientation matrix. Position3 (also known as "Pos3" for short) is a table that has following format:
---@class Position3 
Position3 = {}


---[DCS Class Spot](https://wiki.hoggitworld.com/view/DCS_Class_Spot)
---Represents a spot from laser or IR-pointer.
---@class Spot 
Spot = {}

---Creates an infrared ray emanating from the given object to a point in 3d space.
---Can be seen with night vision goggles.
---
------
---@param Source Object Source position of the IR ray.
---@param LocalRef Vec3 An optional 3D offset for the source.
---@param Vec3 Vec3 Target coordinate where the ray is pointing at.
---@return Spot #
function Spot.createInfraRed(Source, LocalRef, Vec3) end

---Creates a laser ray emanating from the given object to a point in 3d space.
---
------
---@param Source Object The source object of the laser.
---@param LocalRef Vec3 An optional 3D offset for the source.
---@param Vec3 Vec3 Target coordinate where the ray is pointing at.
---@param LaserCode number Any 4 digit number between 1111 and 1788.
---@return Spot #
function Spot.createLaser(Source, LocalRef, Vec3, LaserCode) end

---Destroys the spot.
---
------
---@param self Spot 
function Spot:destroy() end

---Gets the category of the spot (laser or IR).
---
------
---@param self Spot 
---@return string #Category.
function Spot:getCategory() end

---Returns the number that is used to define the laser code for which laser designation can track.
---
------
---@param self Spot 
---@return number #Code The laser code used.
function Spot:getCode() end

---Returns a vec3 table of the x, y, and z coordinates for the position of the given object in 3D space.
---Coordinates are dependent on the position of the maps origin.
---
------
---@param self Spot 
---@return Vec3 #Point in 3D, where the beam is pointing at.
function Spot:getPoint() end

---Sets the number that is used to define the laser code for which laser designation can track.
---
------
---@param self Spot 
---@param Code number The laser code. Default value is 1688.
function Spot:setCode(Code) end

---Sets the destination point from which the source of the spot is drawn toward.
---
------
---@param self Spot 
---@param Vec3 Vec3 Point in 3D, where the beam is pointing at.
function Spot:setPoint(Vec3) end


---Enum that stores spot categories.
---@class Spot.Category 
---@field INFRA_RED string 
---@field LASER string 
Spot.Category = {}


---Represents a static object.
---@class StaticObject : Object
StaticObject = {}

---Returns the static object.
---
------
---@param name string Name of the static object.
---@return StaticObject #
function StaticObject.getByName(name) end


---A task descriptor (internal structure for DCS World).
---See [https://wiki.hoggitworld.com/view/Category:Tasks](https://wiki.hoggitworld.com/view/Category:Tasks).
---In MOOSE, these tasks can be accessed via Wrapper.Controllable#CONTROLLABLE.
---@class Task 
---@field id string 
Task = {}


---DCS template data structure.
---@class Template 
---@field lateActivation boolean Group is late activated.
---@field uncontrolled boolean Aircraft is uncontrolled.
---@field x number 2D Position on x-axis in meters.
---@field y number 2D Position on y-axis in meters.
Template = {}


--- Unit data structure.
---@class Template.Unit 
---@field alt number 
---@field name string Name of the unit.
---@field x number 
---@field y number 
Template.Unit = {}


---Unit.
---@class Unit : CoalitionObject
Unit = {}

---GROUND - Switch on/off radar emissions
---
------
---@param self Unit 
---@param switch boolean 
function Unit:enableEmission(switch) end

---Returns the unit ammunition.
---
------
---@param self Unit 
---@return Unit.Ammo #
function Unit:getAmmo() end

---Returns unit object by the name assigned to the unit in Mission Editor.
---If there is unit with such name or the unit is destroyed the function will return nil. The function provides access to non-activated units too.
---
------
---@param name string 
---@return Unit #
function Unit.getByName(name) end

---Returns the unit's callsign - the localized string.
---
------
---@param self Unit 
---@return string #
function Unit:getCallsign() end

---Returns controller of the unit if it exist and nil otherwise
---
------
---@param self Unit 
---@return Controller #
function Unit:getController() end

---Returns unit descriptor.
---Descriptor type depends on unit category.
---
------
---@param self Unit 
---@return Unit.Desc #
function Unit:getDesc() end

---Returns the number of infantry that can be embark onto the aircraft.
---Only returns a value if run on airplanes or helicopters. Returns nil if run on ground or ship units.
---
------
---@param self Unit 
---@return number #Number of soldiers that embark.
function Unit:getDescentCapacity() end

---Returns relative amount of fuel (from 0.0 to 1.0) the unit has in its internal tanks.
---If there are additional fuel tanks the value may be greater than 1.0.
---
------
---@param self Unit 
---@return number #
function Unit:getFuel() end

---Returns the unit's group if it exist and nil otherwise
---
------
---@param self Unit 
---@return Group #
function Unit:getGroup() end

---returns the unit's unique identifier.
---
------
---@param self Unit 
---@return Unit.ID #
function Unit:getID() end

---Returns the unit's health.
---Dead units has health <= 1.0
---
------
---@param self Unit 
---@return number #
function Unit:getLife() end

---returns the unit's initial health.
---
------
---@param self Unit 
---@return number #
function Unit:getLife0() end

---Returns the unit's number in the group.
---The number is the same number the unit has in ME. It may not be changed during the mission. If any unit in the group is destroyed, the numbers of another units will not be changed.
---
------
---@param self Unit 
---@return number #
function Unit:getNumber() end

---Returns name of the player that control the unit or nil if the unit is controlled by A.I.
---
------
---@param self Unit 
---@return string #
function Unit:getPlayerName() end

---returns two values:
---First value indicates if at least one of the unit's radar(s) is on.
---Second value is the object of the radar's interest. Not nil only if at least one radar of the unit is tracking a target.
---
------
---@param self Unit 
---@return Object #
function Unit:getRadar() end

---Returns the unit sensors.
---
------
---@param self Unit 
---@return Unit.Sensors #
function Unit:getSensors() end

---Returns true if the unit has specified types of sensors.
---This function is more preferable than Unit.getSensors() if you don't want to get information about all the unit's sensors, and just want to check if the unit has specified types of sensors.
---
------
---
---USAGE
---```
---If sensorType is Unit.SensorType.OPTIC, additional parameters are optic sensor types. Following example checks if the unit has LLTV or IR optics:
---unit:hasSensors(Unit.SensorType.OPTIC, Unit.OpticType.LLTV, Unit.OpticType.IR)
---If sensorType is Unit.SensorType.RADAR, additional parameters are radar types. Following example checks if the unit has air search radars:
---unit:hasSensors(Unit.SensorType.RADAR, Unit.RadarType.AS)
---If no additional parameters are specified the function returns true if the unit has at least one sensor of specified type.
---If sensor type is not specified the function returns true if the unit has at least one sensor of any type.
---```
------
---@param self Unit 
---@param sensorType Unit.SensorType (= nil) Sensor type.
---@param ... NOTYPE Additional parameters.
---@return boolean #
function Unit:hasSensors(sensorType, ...) end

---Returns if the unit is activated.
---
------
---@param self Unit 
---@return boolean #
function Unit:isActive() end


---ammunition item: "type-count" pair.
---@class Unit.AmmoItem 
---@field count number ammunition count
Unit.AmmoItem = {}


---Enum that stores unit categories.
---@class Unit.Category 
Unit.Category = {}


---A unit descriptor.
---@class Unit.Desc : Object.Desc
---@field speedMax number istance / Time, --maximal velocity
Unit.Desc = {}


---An aircraft descriptor.
---@class Unit.DescAircraft : Unit.Desc
---@field NyMax number maximal safe acceleration
---@field NyMin number minimal safe acceleration
---@field VyMax number  #Distance / #Time, --maximal climb rate
Unit.DescAircraft = {}


---An airplane descriptor.
---@class Unit.DescAirplane : Unit.DescAircraft
---@field speedMax0 number Distance / Time maximal TAS at ground level
---@field speedMax10K number Distance / Time maximal TAS at altitude of 10 km
Unit.DescAirplane = {}


---A helicopter descriptor.
---@class Unit.DescHelicopter : Unit.DescAircraft
Unit.DescHelicopter = {}


---A vehicle descriptor.
---@class Unit.DescVehicle : Unit.Desc
---@field riverCrossing boolean can the vehicle cross a rivers
Unit.DescVehicle = {}


---An IRST.
---@class Unit.IRST : Unit.Sensor
Unit.IRST = {}


---An optic sensor.
---@class Unit.Optic : Unit.Sensor
Unit.Optic = {}


---Enum that stores types of optic sensors.
---@class Unit.OpticType 
Unit.OpticType = {}


---A radar.
---@class Unit.Radar : Unit.Sensor
Unit.Radar = {}


---A radar.
---@class Unit.Radar.detectionDistanceAir 
Unit.Radar.detectionDistanceAir = {}


---A radar.
---@class Unit.Radar.detectionDistanceAir.lowerHemisphere 
Unit.Radar.detectionDistanceAir.lowerHemisphere = {}


---A radar.
---@class Unit.Radar.detectionDistanceAir.upperHemisphere 
Unit.Radar.detectionDistanceAir.upperHemisphere = {}


---Enum that stores radar types.
---@class Unit.RadarType 
Unit.RadarType = {}


---Enum that stores aircraft refueling system types.
---@class Unit.RefuelingSystem 
Unit.RefuelingSystem = {}


---A unit sensor.
---@class Unit.Sensor 
Unit.Sensor = {}


---Enum that stores sensor types.
---@class Unit.SensorType 
Unit.SensorType = {}


---Vec2 is a 2D-vector for the ground plane as a reference plane.
---@class Vec2 
Vec2 = {}


---Vec3 type is a 3D-vector.
---DCS world has 3-dimensional coordinate system. DCS ground is an infinite plain.
---@class Vec3 
Vec3 = {}


---[DCS Class Warehouse](https://wiki.hoggitworld.com/view/DCS_Class_Warehouse)
---The warehouse class gives control over warehouses that exist in airbase objects.
---These warehouses can limit the aircraft, munitions, and fuel available to coalition aircraft.
---@class Warehouse 
Warehouse = {}

---Adds the passed amount of a given item to the warehouse.
---itemName is the typeName associated with the item: "weapons.missiles.AIM_54C_Mk47"
---A wsType table can also be used, however the last digit with wsTypes has been known to change. {4, 4, 7, 322}
---
------
---@param self NOTYPE 
---@param itemName string Name of the item.
---@param count number Number of items to add.
function Warehouse:addItem(itemName, count) end

---Adds the passed amount of a liquid fuel into the warehouse inventory.
---
------
---@param self NOTYPE 
---@param liquidType number Type of liquid to add: 0=jetfuel, 1=aviation gasoline, 2=MW50, 3=Diesel.
---@param count number Amount of liquid to add.
function Warehouse:addLiquid(liquidType, count) end

---Get a warehouse by passing its name.
---
------
---@param Name string Name of the warehouse.
---@return Warehouse #The warehouse object.
function Warehouse.getByName(Name) end

---Returns a full itemized list of everything currently in a warehouse.
---If a category is set to unlimited then the table will be returned empty.
---Aircraft and weapons are indexed by strings. Liquids are indexed by number.
---
------
---@param self NOTYPE 
---@param itemName string Name of the item.
---@return table #Itemized list of everything currently in a warehouse
function Warehouse:getInventory(itemName) end

---Returns the number of the passed type of item currently in a warehouse object.
---
------
---@param self NOTYPE 
---@param itemName string Name of the item.
function Warehouse:getItemCount(itemName) end

---Returns the amount of the passed liquid type within a given warehouse.
---
------
---@param self NOTYPE 
---@param liquidType number Type of liquid to add: 0=jetfuel, 1=aviation gasoline, 2=MW50, 3=Diesel.
---@return number #Amount of liquid.
function Warehouse:getLiquidAmount(liquidType) end

---Returns the airbase object associated with the warehouse object.
---
------
---@param self NOTYPE 
---@return Airbase #The airbase object owning this warehouse.
function Warehouse:getOwner() end

---Removes the amount of the passed item from the warehouse.
---
------
---@param self NOTYPE 
---@param itemName string Name of the item.
---@param count number Number of items to be removed.
function Warehouse:removeItem(itemName, count) end

---Sets the passed amount of a given item to the warehouse.
---
------
---@param self NOTYPE 
---@param itemName string Name of the item.
---@param count number Number of items to add.
function Warehouse:setItem(itemName, count) end

---Removes the set amount of liquid from the inventory in a warehouse.
---
------
---@param self NOTYPE 
---@param liquidType number Type of liquid to add: 0=jetfuel, 1=aviation gasoline, 2=MW50, 3=Diesel.
---@param count number Amount of liquid.
function Warehouse:setLiquidAmount(liquidType, count) end


---@class WaypointAir 
---@field lateActivated boolean 
---@field uncontrolled boolean 
WaypointAir = {}


---[DCS Class Weapon](https://wiki.hoggitworld.com/view/DCS_Class_Weapon)
---@class Weapon : CoalitionObject
Weapon = {}

---returns weapon descriptor.
---Descriptor type depends on weapon category.
---
------
---@param self Weapon 
---@return Weapon.Desc #
function Weapon:getDesc() end

---Returns the unit that launched the weapon.
---
------
---@param self Weapon 
---@return Unit #
function Weapon:getLauncher() end

---returns target of the guided weapon.
---Unguided weapons and guided weapon that is targeted at the point on the ground will return nil.
---
------
---@param self Weapon 
---@return Object #
function Weapon:getTarget() end


---Weapon.Category enum that stores weapon categories.
---@class Weapon.Category 
---@field BOMB number Bomb.
---@field MISSILE number Missile
---@field ROCKET number Rocket.
---@field SHELL number Shell.
---@field TORPEDO number Torpedo.
Weapon.Category = {}


---Weapon.GuidanceType enum that stores guidance methods.
---Available only for guided weapon (Weapon.Category.MISSILE and some Weapon.Category.BOMB).
---@class Weapon.GuidanceType 
Weapon.GuidanceType = {}


---Weapon.MissileCategory enum that stores missile category.
---Available only for missiles (Weapon.Category.MISSILE).
---@class Weapon.MissileCategory 
Weapon.MissileCategory = {}


---Weapon.WarheadType enum that stores warhead types.
---@class Weapon.WarheadType 
Weapon.WarheadType = {}


---enum stores weapon flags.
---Some of them are combination of another flags.
---@class Weapon.flag 
Weapon.flag = {}


---[DCS Enum coalition](https://wiki.hoggitworld.com/view/DCS_enum_coalition)
---@class coalition 
coalition = {}

---Dynamically spawns a group.
---See [hoggit](https://wiki.hoggitworld.com/view/DCS_func_addGroup)
---
------
---@param countryId number Id of the country.
---@param groupCategory number Group category. Set -1 for spawning FARPS.
---@param groupData table Group data table.
---@return Group #The spawned Group object.
function coalition.addGroup(countryId, groupCategory, groupData) end

---Dynamically spawns a static object.
---See [hoggit](https://wiki.hoggitworld.com/view/DCS_func_addStaticObject)
---
------
---@param countryId number Id of the country.
---@param groupData table Group data table.
---@return Static #The spawned static object.
function coalition.addStaticObject(countryId, groupData) end

---Get country coalition.
---
------
---@param countryId number Country ID.
---@return number #coalitionId Coalition ID.
function coalition.getCountryCoalition(countryId) end


---[DCS Enum coalition.side](https://wiki.hoggitworld.com/view/DCS_enum_coalition)
---@class coalition.side 
coalition.side = {}


---[DCS Enum country](https://wiki.hoggitworld.com/view/DCS_enum_country)
---@class country 
country = {}


---[DCS enumerator country](https://wiki.hoggitworld.com/view/DCS_enum_country)
---@class country.id 
country.id = {}


---[DCS Singleton env](https://wiki.hoggitworld.com/view/DCS_singleton_env)
---[DCS Singleton env](https://wiki.hoggitworld.com/view/DCS_singleton_env)
---@class env 
env = {}

---Add message to simulator log with caption "ERROR".
---Message box is optional.
---
------
---@param message string message string to add to log.
---@param showMessageBox boolean If the parameter is true Message Box will appear. Optional.
function env.error(message, showMessageBox) end

---Add message to simulator log with caption "INFO".
---Message box is optional.
---
------
---@param message string message string to add to log.
---@param showMessageBox boolean If the parameter is true Message Box will appear. Optional.
function env.info(message, showMessageBox) end

---Enables/disables appearance of message box each time lua error occurs.
---
------
---@param on boolean if true message box appearance is enabled.
function env.setErrorMessageBoxEnabled(on) end

---Add message to simulator log with caption "WARNING".
---Message box is optional.
---
------
---@param message string message string to add to log.
---@param showMessageBox boolean If the parameter is true Message Box will appear. Optional.
function env.warning(message, showMessageBox) end


---[DCS Singleton land](https://wiki.hoggitworld.com/view/DCS_singleton_land)
---[DCS Singleton land](https://wiki.hoggitworld.com/view/DCS_singleton_land)
---@class land 
land = {}

---Returns the distance from sea level (y-axis) of a given vec2 point.
---
------
---@param point Vec2 Point on the ground. 
---@return number #Height in meters.
function land.getHeight(point) end

---Returns the surface height and depth of a point.
---Useful for checking if the path is deep enough to support a given ship. 
---Both values are positive. When checked over water at sea level the first value is always zero. 
---When checked over water at altitude, for example the reservoir of the Inguri Dam, the first value is the corresponding altitude the water level is at.
---
------
---@param point Vec2 Position where to check.
---@return number #Height in meters.
---@return number #Depth in meters.
function land.getSurfaceHeightWithSeabed(point) end

---Returns surface type at the given point.
---
------
---@param point Vec2 Point on the land. 
---@return number #Enumerator value from `land.SurfaceType` (LAND=1, SHALLOW_WATER=2, WATER=3, ROAD=4, RUNWAY=5)
function land.getSurfaceType(point) end


---[Type of surface enumerator](https://wiki.hoggitworld.com/view/DCS_singleton_land)
---@class land.SurfaceType 
land.SurfaceType = {}


---@class radio.modulation 
radio.modulation = {}


---[DCS Singleton timer](https://wiki.hoggitworld.com/view/DCS_singleton_timer)
---[DCS Singleton timer](https://wiki.hoggitworld.com/view/DCS_singleton_timer)
---@class timer 
timer = {}

---Returns mission time in seconds.
---
------
---@return Time #
function timer.getAbsTime() end

---Returns model time in seconds.
---
------
---@return Time #  
function timer.getTime() end

---Returns mission start time in seconds.
---
------
---@return Time #
function timer.getTime0() end

---Removes the function from schedule.
---
------
---@param functionId NOTYPE Function identifier to remove from schedule 
function timer.removeFunction(functionId) end

---Schedules function to call at desired model time.
--- Time function FunctionToCall(any argument, Time time)
--- 
--- ...
--- 
--- return ...
--- 
--- end
--- 
--- Must return model time of next call or nil. Note that the DCS scheduler calls the function in protected mode and any Lua errors in the called function will be trapped and not reported. If the function triggers a Lua error then it will be terminated and not scheduled to run again.
---
------
---@param functionToCall FunctionToCall Lua-function to call. Must have prototype of FunctionToCall. 
---@param functionArgument NOTYPE Function argument of any type to pass to functionToCall.
---@param time Time Model time of the function call.
---@return  #functionId
function timer.scheduleFunction(functionToCall, functionArgument, time) end

---Re-schedules function to call at another model time.
---
------
---@param functionId NOTYPE Lua-function to call. Must have prototype of FunctionToCall. 
---@param time Time Model time of the function call. 
function timer.setFunctionTime(functionId, time) end


---The world singleton contains functions centered around two different but extremely useful functions.
---* Events and event handlers are all governed within world.
---* A number of functions to get information about the game world.
---
---See [https://wiki.hoggitworld.com/view/DCS_singleton_world](https://wiki.hoggitworld.com/view/DCS_singleton_world)
---[DCS Enum world](https://wiki.hoggitworld.com/view/DCS_enum_world)
---@class world 
world = {}

---Adds a function as an event handler that executes whenever a simulator event occurs.
---See [hoggit](https://wiki.hoggitworld.com/view/DCS_func_addEventHandler).
---
------
---@param handler table Event handler table.
function world.addEventHandler(handler) end

---Returns a table of DCS airbase objects.
---
------
---@param coalitionId number The coalition side number ID. Default is all airbases are returned.
---@return table #Table of DCS airbase objects.
function world.getAirbases(coalitionId) end

---Returns a table of mark panels indexed numerically that are present within the mission.
---See [hoggit](https://wiki.hoggitworld.com/view/DCS_func_getMarkPanels)
---
------
---@return table #Table of marks.
function world.getMarkPanels() end

---Returns a table of the single unit object in the game who's skill level is set as "Player".
---See [hoggit](https://wiki.hoggitworld.com/view/DCS_func_getPlayer).
---There is only a single player unit in a mission and in single player the user will always spawn into this unit automatically unless other client or Combined Arms slots are available.
---
------
---@return Unit # 
function world.getPlayer() end

---Removes the specified event handler from handling events.
---
------
---@param handler table Event handler table.
function world.removeEventHandler(handler) end

---Searches a defined volume of 3d space for the specified objects within it and then can run function on each returned object.
---See [hoggit](https://wiki.hoggitworld.com/view/DCS_func_searchObjects).
---
------
---@param objectcategory Object.Category Category (can be a table) of objects to search.
---@param volume word.VolumeType Shape of the search area/volume.
---@param ObjectSeachHandler NOTYPE handler A function that handles the search.
---@param any table Additional data.
---@return Unit # 
function world.searchObjects(objectcategory, volume, ObjectSeachHandler, any) end


---The birthplace enumerator is used to define where an aircraft or helicopter has spawned in association with birth events.
---@class world.BirthPlace 
world.BirthPlace = {}


---Fog animation data structure.
---@class world.FogAnimation 
---@field thickness number 
---@field time number 
---@field visibility number 
world.FogAnimation = {}


---The volumeType enumerator defines the types of 3d geometery used within the #world.searchObjects function.
---@class world.VolumeType 
world.VolumeType = {}


---[https://wiki.hoggitworld.com/view/DCS_enum_world](https://wiki.hoggitworld.com/view/DCS_enum_world)
---@class world.event 
world.event = {}


---Weather functions.
---@class world.weather 
world.weather = {}

---Returns the current fog thickness.
---
------
---@return number #Fog thickness in meters. If there is no fog, zero is returned.
function world.weather.getFogThickness() end

---Returns the current fog visibility distance.
---
------
function world.weather.getFogVisibilityDistance() end

---Sets fog animation keys.
---Time is set in seconds and relative to the current simulation time, where time=0 is the current moment. 
---Time must be increasing. Previous animation is always discarded despite the data being correct.
---
------
---@param animation world.FogAnimation List of fog animations
function world.weather.setFogAnimation(animation) end

---Sets the fog thickness instantly.
---Any current fog animation is discarded.
---
------
---@param thickness number Fog thickness in meters. Set to zero to disable fog.
function world.weather.setFogThickness(thickness) end

---Instantly sets the maximum visibility distance of fog at sea level when looking at the horizon.
---Any current fog animation is discarded. Set zero to disable the fog.
---
------
---@param visibility number Max fog visibility in meters. Set to zero to disable fog.
function world.weather.setFogVisibilityDistance(visibility) end



