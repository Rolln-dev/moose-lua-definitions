---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/OPS_OpsGroup.png" width="100%">
---
---**Ops** - Generic group enhancement.
---
---This class is **not** meant to be used itself by the end user. It contains common functionalities of derived classes for air, ground and sea.
---
---===
---
---### Author: **funkyfranky**
---
---===
---*A small group of determined and like-minded people can change the course of history.* -- Mahatma Gandhi
---
---===
---
---# The OPSGROUP Concept
---
---The OPSGROUP class contains common functions used by other classes such as FLIGHTGROUP, NAVYGROUP and ARMYGROUP.
---Those classes inherit everything of this class and extend it with features specific to their unit category.
---
---This class is **NOT** meant to be used by the end user itself.
---OPSGROUP class.
---@class OPSGROUP : FSM
---@field Astar ASTAR path finding.
---@field CargoStatus OPSGROUP.CargoStatus 
---@field CarrierStatus OPSGROUP.CarrierStatus 
---@field ClassName string Name of the class.
---@field EPLRS NOTYPE 
---@field ElementStatus OPSGROUP.ElementStatus 
---@field GroupStatus OPSGROUP.GroupStatus 
---@field Ndestroyed number Number of destroyed units.
---@field Nhit number Number of hits taken.
---@field Nkills number Number kills of this groups.
---@field TaskStatus OPSGROUP.TaskStatus 
---@field TaskType OPSGROUP.TaskType 
---@field TpositionUpdate NOTYPE 
---@field Twaiting number Abs. mission time stamp when the group was ordered to wait.
---@field private actype NOTYPE 
---@field private adinfinitum boolean Resume route at first waypoint when final waypoint is reached.
---@field private altitudeCruise NOTYPE 
---@field private ammo OPSGROUP.Ammo Initial ammount of ammo.
---@field private attribute string Generalized attribute.
---@field private callsign OPSGROUP.Callsign Current callsign settings.
---@field private callsignAlias string Callsign alias.
---@field private callsignDefault OPSGROUP.Callsign Default callsign settings.
---@field private callsignName string Callsign name.
---@field private cargoBay table Table containing OPSGROUP loaded into this group.
---@field private cargoStatus string Cargo status of this group acting as cargo.
---@field private cargoTZC OPSTRANSPORT.TransportZoneCombo Transport zone combo (pickup, deploy etc.) currently used.
---@field private cargoTransport OPSTRANSPORT Current cargo transport assignment.
---@field private cargoTransportUID number Unique ID of the transport assignment this cargo group is associated with.
---@field private cargoqueue table Table containing cargo groups to be transported.
---@field private carrier OPSGROUP.Element Carrier the group is loaded into as cargo.
---@field private carrierGroup OPSGROUP Carrier group transporting this group as cargo.
---@field private carrierLoader OPSGROUP.CarrierLoader Carrier loader parameters.
---@field private carrierStatus string Carrier status of this group acting as cargo carrier.
---@field private carrierUnloader OPSGROUP.CarrierLoader Carrier unloader parameters.
---@field private category NOTYPE 
---@field private ceiling NOTYPE 
---@field private checkzones SET_ZONE Set of zones.
---@field private cohort COHORT Cohort the group belongs to.
---@field private controller Controller The DCS controller of the group.
---@field private coordinate COORDINATE Current coordinate.
---@field private currbase AIRBASE The current airbase of the flight group, i.e. where it is currently located or landing at.
---@field private currentmission number The ID (auftragsnummer) of the currently assigned AUFTRAG.
---@field private currentwp number Current waypoint index. This is the index of the last passed waypoint.
---@field private dTwait number Time to wait in seconds. Default `nil` (for ever).
---@field private dcsgroup Group The DCS group object.
---@field private descriptors NOTYPE 
---@field private destbase AIRBASE The destination base of the flight group.
---@field private destzone ZONE The destination zone of the flight group. Set when final waypoint is in air.
---@field private detectedgroups SET_GROUP Set of detected groups.
---@field private detectedunits SET_UNIT Set of detected units.
---@field private detectionOn boolean If true, detected units of the group are analyzed.
---@field private elements table Table of elements, i.e. units of the group.
---@field private engagedetectedEngageZones SET_ZONE Set of zones in which targets are engaged. Default is anywhere.
---@field private engagedetectedNoEngageZones SET_ZONE Set of zones in which targets are *not* engaged. Default is nowhere.
---@field private engagedetectedOn boolean If `true`, auto engage detected targets.
---@field private engagedetectedRmax number Max range in NM. Only detected targets within this radius from the group will be engaged. Default is 25 NM.
---@field private engagedetectedTypes table Types of target attributes that will be engaged. See [DCS enum attributes](https://wiki.hoggitworld.com/view/DCS_enum_attributes). Default "All".
---@field private group GROUP Group object.
---@field private groupinitialized boolean If true, group parameters were initialized.
---@field private groupname string Name of the group.
---@field private heading number Heading of the group at last status check.
---@field private headingLast number Backup of last heading to monitor changes.
---@field private homebase AIRBASE The home base of the flight group.
---@field private homezone ZONE The home zone of the flight group. Set when spawn happens in air.
---@field private icls OPSGROUP.Beacon Current ICLS settings.
---@field private iclsDefault OPSGROUP.Beacon Default ICLS settings.
---@field private inzones SET_ZONE Set of zones in which the group is currently in.
---@field private isAI boolean If true, group is purely AI.
---@field private isArmygroup boolean Is an ARMYGROUP.
---@field private isDead boolean If true, the whole group is dead.
---@field private isDestroyed boolean If true, the whole group was destroyed.
---@field private isEPLRS NOTYPE 
---@field private isFlightgroup boolean Is a FLIGHTGROUP.
---@field private isHelo boolean If true, this is a helicopter group.
---@field private isHoldingAtHoldingPoint boolean 
---@field private isLateActivated boolean Is the group late activated.
---@field private isMobile boolean If `true`, group is mobile (speed > 1 m/s)
---@field private isNavygroup boolean Is a NAVYGROUP.
---@field private isSubmarine boolean If true, this is a submarine group.
---@field private isTrain boolean 
---@field private isUncontrolled boolean Is the group uncontrolled.
---@field private isVTOL boolean If true, this is capable of Vertical TakeOff and Landing (VTOL).
---@field private ispathfinding boolean If true, group is on pathfinding route.
---@field private legion LEGION Legion the group belongs to.
---@field private legionReturn boolean 
---@field private lid string Class id string for output to DCS log file.
---@field private life number 
---@field private missionqueue table Queue of missions.
---@field private msrs MSRS MOOSE SRS wrapper.
---@field private mycarrier OPSGROUP.MyCarrier Carrier group for this group.
---@field private option OPSGROUP.Option Current optional settings.
---@field private optionDefault OPSGROUP.Option Default option settings.
---@field private orientX Vec3 Orientation at last status check.
---@field private orientXLast Vec3 Backup of last orientation to monitor changes.
---@field private outofAmmo boolean 
---@field private outofBombs boolean 
---@field private outofGuns boolean 
---@field private outofMissiles boolean 
---@field private outofMissilesAA boolean 
---@field private outofMissilesAG boolean 
---@field private outofMissilesAS boolean 
---@field private outofRockets boolean 
---@field private outofTorpedos boolean 
---@field private passedfinalwp boolean Group has passed the final waypoint.
---@field private pausedmissions table Paused missions.
---@field private position Vec3 Position of the group at last status check.
---@field private positionLast Vec3 Backup of last position vec to monitor changes.
---@field private radio OPSGROUP.Radio Current radio settings.
---@field private radioDefault OPSGROUP.Radio Default radio settings.
---@field private radioQueue RADIOQUEUE Radio queue.
---@field private rearmOnOutOfAmmo boolean If `true`, group will go to rearm once it runs out of ammo.
---@field private reconindecies table 
---@field private refueltype NOTYPE 
---@field private retreatOnOutOfAmmo boolean 
---@field private rtzOnOutOfAmmo boolean 
---@field private scheduleIDDespawn NOTYPE 
---@field private speed NOTYPE 
---@field private speedCruise number Cruising speed in km/h.
---@field private speedMax number Max speed in km/h.
---@field private speedWp number Speed to the next waypoint in m/s.
---@field private spot OPSGROUP.Spot Laser and IR spot.
---@field private stuckDespawn boolean If `true`, group gets despawned after beeing stuck for a certain time.
---@field private stuckTimestamp number Time stamp [sec], when the group got stuck.
---@field private stuckVec3 Vec3 Position where the group got stuck.
---@field private tacan OPSGROUP.Beacon Current TACAN settings.
---@field private tacanDefault OPSGROUP.Beacon Default TACAN settings.
---@field private tankertype NOTYPE 
---@field private taskcounter number Running number of task ids.
---@field private taskcurrent number ID of current task. If 0, there is no current task assigned.
---@field private taskenroute table Enroute task of the group.
---@field private taskpaused table Paused tasks.
---@field private taskqueue table Queue of tasks.
---@field private template Template Template table of the group.
---@field private timerCheckZone TIMER Timer for check zones.
---@field private timerQueueUpdate TIMER Timer for queue updates.
---@field private timerStatus TIMER Timer for status update.
---@field private traveldist number Distance traveled in meters. This is a lower bound.
---@field private travelds NOTYPE 
---@field private traveltime number Time.
---@field private useMEtasks boolean If `true`, use tasks set in the ME. Default `false`.
---@field private useSRS boolean Use SRS for transmissions.
---@field private velocity NOTYPE 
---@field private verbose number Verbosity level. 0=silent.
---@field private version string OpsGroup version.
---@field private waypoints table Table of waypoints.
---@field private waypoints0 table Table of initial waypoints.
---@field private weaponData OPSGROUP.WeaponData Weapon data table with key=BitType.
---@field private wpcounter number Running number counting waypoints.
OPSGROUP = {}

---Activate a *late activated* group.
---
------
---@param delay? number (Optional) Delay in seconds before the group is activated. Default is immediately.
---@return OPSGROUP #self
function OPSGROUP:Activate(delay) end

---Add a zone that triggers and event if the group enters or leaves any of the zones.
---
------
---@param CheckZone ZONE Zone to check.
---@return OPSGROUP #self
function OPSGROUP:AddCheckZone(CheckZone) end

---Add mission to queue.
---
------
---@param Mission AUFTRAG Mission for this group.
---@return OPSGROUP #self
function OPSGROUP:AddMission(Mission) end

---Create a cargo transport assignment.
---
------
---@param OpsTransport OPSTRANSPORT The troop transport assignment.
---@return OPSGROUP #self
function OPSGROUP:AddOpsTransport(OpsTransport) end

---Add a *scheduled* task.
---
------
---@param task table DCS task table structure.
---@param clock string Mission time when task is executed. Default in 5 seconds. If argument passed as #number, it defines a relative delay in seconds.
---@param description string Brief text describing the task, e.g. "Attack SAM".
---@param prio number Priority of the task.
---@param duration number Duration before task is cancelled in seconds counted after task started. Default never.
---@return OPSGROUP.Task #The task structure.
function OPSGROUP:AddTask(task, clock, description, prio, duration) end

---Add an *enroute* task.
---
------
---@param task table DCS task table structure.
function OPSGROUP:AddTaskEnroute(task) end

---Add a *waypoint* task.
---
------
---@param task table DCS task table structure.
---@param Waypoint OPSGROUP.Waypoint where the task is executed. Default is the at *next* waypoint.
---@param description string Brief text describing the task, e.g. "Attack SAM".
---@param prio number Priority of the task. Number between 1 and 100. Default is 50.
---@param duration number Duration before task is cancelled in seconds counted after task started. Default never.
---@return OPSGROUP.Task #The task structure.
function OPSGROUP:AddTaskWaypoint(task, Waypoint, description, prio, duration) end

---Add a weapon range for ARTY auftrag.
---
------
---@param RangeMin number Minimum range in nautical miles. Default 0 NM.
---@param RangeMax number Maximum range in nautical miles. Default 10 NM.
---@param BitType number Bit mask of weapon type for which the given min/max ranges apply. Default is `ENUMS.WeaponFlag.Auto`, i.e. for all weapon types.
---@param ConversionToMeters function Function that converts input units of ranges to meters. Defaul `UTILS.NMToMeters`.
---@return OPSGROUP #self
function OPSGROUP:AddWeaponRange(RangeMin, RangeMax, BitType, ConversionToMeters) end

---Add weight to the internal cargo of an element of the group.
---
------
---@param UnitName string Name of the unit. Default is of the whole group.
---@param Weight number Cargo weight to be added in kg.
function OPSGROUP:AddWeightCargo(UnitName, Weight) end

---Check if the group can *in principle* be carrier of a cargo group.
---This checks the max cargo capacity of the group but *not* how much cargo is already loaded (if any).
---**Note** that the cargo group *cannot* be split into units, i.e. the largest cargo bay of any element of the group must be able to load the whole cargo group in one piece.
---
------
---@param Cargo OPSGROUP.CargoGroup Cargo data, which needs a carrier.
---@return boolean #If `true`, there is an element of the group that can load the whole cargo group.
function OPSGROUP:CanCargo(Cargo) end

---Cancel all missions in mission queue that are not already done or cancelled.
---
------
function OPSGROUP:CancelAllMissions() end

---Check if task description is unique.
---
------
---@param description string Task destription
---@return boolean #If true, no other task has the same description.
function OPSGROUP:CheckTaskDescriptionUnique(description) end

---Clear DCS tasks.
---
------
---@return OPSGROUP #self
function OPSGROUP:ClearTasks() end

---Clear waypoints.
---
------
---@param IndexMin number Clear waypoints up to this min WP index. Default 1.
---@param IndexMax number Clear waypoints up to this max WP index. Default `#self.waypoints`.
function OPSGROUP:ClearWaypoints(IndexMin, IndexMax) end

---Count elements of the group.
---
------
---@param States? table (Optional) Only count elements in specific states. Can also be a single state passed as #string.
---@return number #Number of elements.
function OPSGROUP:CountElements(States) end

---Count remaining missons.
---
------
---@return number #Number of missions to be done.
function OPSGROUP:CountRemainingMissison() end

---Count the number of tasks that still pending in the queue.
---
------
---@return number #Total number of tasks remaining.
---@return number #Number of SCHEDULED tasks remaining.
---@return number #Number of WAYPOINT tasks remaining.
function OPSGROUP:CountRemainingTasks() end

---Count remaining cargo transport assignments.
---
------
---@return number #Number of unfinished transports in the queue.
function OPSGROUP:CountRemainingTransports() end

---Count remaining waypoint tasks.
---
------
---@param uid number Unique waypoint ID.
---@param id NOTYPE 
---@return number #Number of waypoint tasks.
function OPSGROUP:CountTasksWaypoint(uid, id) end

---Deactivate the group.
---Group will be respawned in late activated state.
---
------
---@param delay? number (Optional) Delay in seconds before the group is deactivated. Default is immediately.
---@return OPSGROUP #self
function OPSGROUP:Deactivate(delay) end

---Delete a cargo transport assignment from the cargo queue.
---
------
---@param CargoTransport OPSTRANSPORT Cargo transport do be deleted.
---@return OPSGROUP #self
function OPSGROUP:DelOpsTransport(CargoTransport) end

---Despawn the group.
---The whole group is despawned and a "`Remove Unit`" event is generated for all current units of the group.
---If no `Remove Unit` event should be generated, the second optional parameter needs to be set to `true`.
---If this group belongs to an AIRWING, BRIGADE or FLEET, it will be added to the warehouse stock if the `NoEventRemoveUnit` parameter is `false` or `nil`.
---
------
---@param Delay number Delay in seconds before the group will be despawned. Default immediately.
---@param NoEventRemoveUnit boolean If `true`, **no** event "Remove Unit" is generated.
---@return OPSGROUP #self
function OPSGROUP:Despawn(Delay, NoEventRemoveUnit) end

---Despawn an element/unit of the group.
---
------
---@param Element OPSGROUP.Element The element that will be despawned.
---@param Delay number Delay in seconds before the element will be despawned. Default immediately.
---@param NoEventRemoveUnit boolean If true, no event "Remove Unit" is generated.
---@return OPSGROUP #self
function OPSGROUP:DespawnElement(Element, Delay, NoEventRemoveUnit) end

---Despawn a unit of the group.
---A "Remove Unit" event is generated by default.
---
------
---@param UnitName string Name of the unit
---@param Delay number Delay in seconds before the group will be despawned. Default immediately.
---@param NoEventRemoveUnit boolean If true, no event "Remove Unit" is generated.
---@return OPSGROUP #self
function OPSGROUP:DespawnUnit(UnitName, Delay, NoEventRemoveUnit) end

---Destroy group.
---The whole group is despawned and a *Unit Lost* for aircraft or *Dead* event for ground/naval units is generated for all current units.
---
------
---@param Delay number Delay in seconds before the group will be destroyed. Default immediately.
---@return OPSGROUP #self
function OPSGROUP:Destroy(Delay) end

---Destroy a unit of the group.
---A *Unit Lost* for aircraft or *Dead* event for ground/naval units is generated.
---
------
---@param UnitName string Name of the unit which should be destroyed.
---@param Delay number Delay in seconds before the group will be destroyed. Default immediately.
---@return OPSGROUP #self
function OPSGROUP:DestroyUnit(UnitName, Delay) end

---Find carrier for cargo by evaluating the free cargo bay storage.
---
------
---@param Weight number Weight of cargo in kg.
---@return OPSGROUP.Element #Carrier able to transport the cargo.
function OPSGROUP:FindCarrierForCargo(Weight) end

---Get 2D distance to a coordinate.
---
------
---@param Coordinate COORDINATE  Can also be a DCS#Vec2 or DCS#Vec3.
---@return number #Distance in meters.
function OPSGROUP:Get2DDistance(Coordinate) end

---Get current Alarm State of the group.
---
------
---@return number #Current Alarm State.
function OPSGROUP:GetAlarmstate() end

---Set current altitude.
---
------
---@return number #Altitude in feet.
function OPSGROUP:GetAltitude() end

---Get inital amount of ammunition.
---
------
---@return OPSGROUP.Ammo #Initial ammo table.
function OPSGROUP:GetAmmo0() end

---Get the number of shells a unit or group currently has.
---For a group the ammo count of all units is summed up.
---
------
---@param element OPSGROUP.Element The element.
---@return OPSGROUP.Ammo #Ammo data.
function OPSGROUP:GetAmmoElement(element) end

---Get total amount of ammunition of the whole group.
---
------
---@return OPSGROUP.Ammo #Ammo data.
function OPSGROUP:GetAmmoTot() end

---Get the number of shells a unit or group currently has.
---For a group the ammo count of all units is summed up.
---
------
---@param unit UNIT The unit object.
---@param display boolean Display ammo table as message to all. Default false.
---@return OPSGROUP.Ammo #Ammo data.
function OPSGROUP:GetAmmoUnit(unit, display) end

---Get generalized attribute.
---
------
---@return string #Generalized attribute.
function OPSGROUP:GetAttribute() end

---Get current TACAN parameters.
---
------
---@return OPSGROUP.Beacon #TACAN beacon.
function OPSGROUP:GetBeaconTACAN() end

---Get callsign of the first element alive.
---
------
---@param ShortCallsign boolean If true, append major flight number only
---@param Keepnumber boolean (Player only) If true, and using a customized callsign in the #GROUP name after an #-sign, use all of that information.
---@param CallsignTranslations? table (optional) Translation table between callsigns
---@return string #Callsign name, e.g. Uzi11, or "Ghostrider11".
function OPSGROUP:GetCallsignName(ShortCallsign, Keepnumber, CallsignTranslations) end

---Get all groups currently loaded as cargo.
---
------
---@param CarrierName? string (Optional) Only return cargo groups loaded into a particular carrier unit.
---@return table #Cargo ops groups.
function OPSGROUP:GetCargoGroups(CarrierName) end

---Get OPSGROUPs in the cargo bay.
---
------
---@return table #Cargo OPSGROUPs.
function OPSGROUP:GetCargoOpsGroups() end

---Get coalition.
---
------
---@return number #Coalition side of carrier.
function OPSGROUP:GetCoalition() end

---Get current coordinate of the group.
---If the current position cannot be determined, the last known position is returned.
---
------
---@param NewObject boolean Create a new coordiante object.
---@param UnitName? string (Optional) Get position of a specifc unit of the group. Default is the first existing unit in the group.
---@return COORDINATE #The coordinate (of the first unit) of the group.
function OPSGROUP:GetCoordinate(NewObject, UnitName) end

---Get a coordinate, which is in weapon range.
---
------
---@param TargetCoord COORDINATE Coordinate of the target.
---@param WeaponBitType number Weapon type.
---@param RefCoord COORDINATE Reference coordinate.
---@param SurfaceTypes table Valid surfaces types of the coordinate. Default any (nil).
---@return COORDINATE #Coordinate in weapon range
function OPSGROUP:GetCoordinateInRange(TargetCoord, WeaponBitType, RefCoord, SurfaceTypes) end

---Get default cruise speed.
---
------
---@return number #Cruise altitude in feet.
function OPSGROUP:GetCruiseAltitude() end

---Get DCS GROUP object.
---
------
---@return Group #DCS group object.
function OPSGROUP:GetDCSGroup() end

---Get DCS group object.
---
------
---@return Group #DCS group object.
function OPSGROUP:GetDCSObject() end

---Get DCS GROUP object.
---
------
---@param UnitNumber number Number of the unit in the group. Default first unit.
---@return Unit #DCS group object.
function OPSGROUP:GetDCSUnit(UnitNumber) end

---Get DCS units.
---
------
---@return list #DCS units.
function OPSGROUP:GetDCSUnits() end

---Get set of detected groups.
---
------
---@return SET_GROUP #Set of detected groups.
function OPSGROUP:GetDetectedGroups() end

---Get set of detected units.
---
------
---@return SET_UNIT #Set of detected units.
function OPSGROUP:GetDetectedUnits() end

---Get distance to waypoint.
---
------
---@param indx number Waypoint index. Default is the next waypoint.
---@return number #Distance in meters.
function OPSGROUP:GetDistanceToWaypoint(indx) end

---Get current EPLRS state.
---
------
---@return boolean #If `true`, EPLRS is on.
function OPSGROUP:GetEPLRS() end

---Get the first element of a group, which is alive.
---
------
---@return OPSGROUP.Element #The element or `#nil` if no element is alive any more.
function OPSGROUP:GetElementAlive() end

---Get the element of a group.
---
------
---@param unitname string Name of unit.
---@return OPSGROUP.Element #The element.
function OPSGROUP:GetElementByName(unitname) end

---Get the bounding box of the element.
---
------
---@param UnitName string Name of unit.
---@return ZONE_POLYGON #Bounding box polygon zone.
function OPSGROUP:GetElementZoneBoundingBox(UnitName) end

---Get the loading zone of the element.
---
------
---@param UnitName string Name of unit.
---@return ZONE_POLYGON #Bounding box polygon zone.
function OPSGROUP:GetElementZoneLoad(UnitName) end

---Get the unloading zone of the element.
---
------
---@param UnitName string Name of unit.
---@return ZONE_POLYGON #Bounding box polygon zone.
function OPSGROUP:GetElementZoneUnload(UnitName) end

---Get current emission state.
---
------
---@return boolean #If `true`, emission is on.
function OPSGROUP:GetEmission() end

---Returns the currently expected speed.
---
------
---@return number #Expected speed in m/s.
function OPSGROUP:GetExpectedSpeed() end

---Get free cargo bay weight.
---
------
---@param UnitName string Name of the unit. Default is of the whole group.
---@param IncludeReserved boolean If `false`, cargo weight that is only *reserved* is **not** counted. By default (`true` or `nil`), the reserved cargo is included.
---@return number #Free cargo bay in kg.
function OPSGROUP:GetFreeCargobay(UnitName, IncludeReserved) end

---Get max weight of cargo (group) this group can load.
---This is the largest free cargo bay of any (not dead) element of the group.
---Optionally, you can calculate the current max weight possible, which accounts for currently loaded cargo.
---
------
---@param Currently boolean If true, calculate the max weight currently possible in case there is already cargo loaded.
---@return number #Max weight in kg.
function OPSGROUP:GetFreeCargobayMax(Currently) end

---Get relative free cargo bay in percent.
---
------
---@param UnitName string Name of the unit. Default is of the whole group.
---@param IncludeReserved boolean If `false`, cargo weight that is only *reserved* is **not** counted. By default (`true` or `nil`), the reserved cargo is included.
---@return number #Free cargo bay in percent.
function OPSGROUP:GetFreeCargobayRelative(UnitName, IncludeReserved) end

---Get MOOSE GROUP object.
---
------
---@return GROUP #Moose group object.
function OPSGROUP:GetGroup() end

---Get current heading of the group or (optionally) of a specific unit of the group.
---
------
---@param UnitName? string (Optional) Get heading of a specific unit of the group. Default is from the first existing unit in the group.
---@return number #Current heading of the group in degrees.
function OPSGROUP:GetHeading(UnitName) end

---Get highest threat.
---
------
---@return UNIT #The highest threat unit.
---@return number #Threat level of the unit.
function OPSGROUP:GetHighestThreat() end

---Get LASER code.
---
------
---@return number #Current Laser code.
function OPSGROUP:GetLaserCode() end

---Get current LASER coordinate, i.e.
---where the beam is pointing at if the LASER is on.
---
------
---@return COORDINATE #Current position where the LASER is pointing at.
function OPSGROUP:GetLaserCoordinate() end

---Get current target of the LASER.
---This can be a STATIC or UNIT object.
---
------
---@return POSITIONABLE #Current target object.
function OPSGROUP:GetLaserTarget() end

---Returns the absolute total life points of the group.
---
------
---@param Element? OPSGROUP.Element (Optional) Only get life points of this element.
---@return number #Life points, *i.e.* the sum of life points over all units in the group (unless a specific element was passed).  
---@return number #Initial life points.
function OPSGROUP:GetLifePoints(Element) end

---Get mission by its id (auftragsnummer).
---
------
---@param id number Mission id (auftragsnummer).
---@return AUFTRAG #The mission.
function OPSGROUP:GetMissionByID(id) end

---Get mission by its task id.
---
------
---@param taskid number The id of the (waypoint) task of the mission.
---@return AUFTRAG #The mission.
function OPSGROUP:GetMissionByTaskID(taskid) end

---Get current mission.
---
------
---@return AUFTRAG #The current mission or *nil*.
function OPSGROUP:GetMissionCurrent() end

---Get the group name.
---
------
---@return string #Group name.
function OPSGROUP:GetName() end

---Get number of elements alive.
---
------
---@param status? string (Optional) Only count number, which are in a special status.
---@return number #Number of elements.
function OPSGROUP:GetNelements(status) end

---Get coordinate of next waypoint of the group.
---
------
---@param cyclic boolean If true, return first waypoint if last waypoint was reached.
---@return COORDINATE #Coordinate of the next waypoint.
function OPSGROUP:GetNextWaypointCoordinate(cyclic) end

---Get cargo transport assignment from the cargo queue by its unique ID.
---
------
---@param uid number Unique ID of the transport
---@return OPSTRANSPORT #Transport.
function OPSGROUP:GetOpsTransportByUID(uid) end

---Get current orientation of the group.
---
------
---@param UnitName? string (Optional) Get orientation of a specific unit of the group. Default is the first existing unit of the group.
---@return Vec3 #Orientation X parallel to where the "nose" is pointing.
---@return Vec3 #Orientation Y pointing "upwards".
---@return Vec3 #Orientation Z perpendicular to the "nose".
function OPSGROUP:GetOrientation(UnitName) end

---Get current "X" orientation of the first unit in the group.
---
------
---@param UnitName? string (Optional) Get orientation of a specific unit of the group. Default is the first existing unit of the group.
---@return Vec3 #Orientation X parallel to where the "nose" is pointing.
function OPSGROUP:GetOrientationX(UnitName) end

---Get current ROE of the group.
---
------
---@return number #Current ROE.
function OPSGROUP:GetROE() end

---Get current ROT of the group.
---
------
---@return number #Current ROT.
function OPSGROUP:GetROT() end

---Get current Radio frequency and modulation.
---
------
---@return number #Radio frequency in MHz or nil.
---@return number #Radio modulation or nil.
---@return boolean #If true, the radio is on. Otherwise, radio is turned off.
function OPSGROUP:GetRadio() end

---Get default cruise speed.
---
------
---@return number #Cruise speed (>0) in knots.
function OPSGROUP:GetSpeedCruise() end

---Returns a non-zero speed to the next waypoint (even if the waypoint speed is zero).
---
------
---@param indx number Waypoint index.
---@return number #Speed to next waypoint (>0) in knots.
function OPSGROUP:GetSpeedToWaypoint(indx) end

---Get current TACAN parameters.
---
------
---@return number #TACAN channel.
---@return string #TACAN Morse code.
---@return string #TACAN band ("X" or "Y").
---@return boolean #TACAN is On (true) or Off (false).
---@return string #UnitName Name of the unit acting as beacon.
function OPSGROUP:GetTACAN() end

---Get task by its id.
---
------
---@param id number Task id.
---@param status? string (Optional) Only return tasks with this status, e.g. OPSGROUP.TaskStatus.SCHEDULED.
---@return OPSGROUP.Task #The task or nil.
function OPSGROUP:GetTaskByID(id, status) end

---Get the currently executed task if there is any.
---
------
---@return OPSGROUP.Task #Current task or nil.
function OPSGROUP:GetTaskCurrent() end

---Get the unfinished waypoint tasks
---
------
---@param id number Unique waypoint ID.
---@return table #Table of tasks. Table could also be empty {}.
function OPSGROUP:GetTasksWaypoint(id) end

---Get highest detected threat.
---Detection must be turned on. The threat level is a number between 0 and 10, where 0 is the lowest, e.g. unarmed units.
---
------
---@param ThreatLevelMin number Only consider threats with level greater or equal to this number. Default 1 (so unarmed units wont be considered).
---@param ThreatLevelMax number Only consider threats with level smaller or queal to this number. Default 10.
---@return UNIT #Highest threat unit detected by the group or `nil` if no threat is currently detected.
---@return number #Threat level.
function OPSGROUP:GetThreat(ThreatLevelMin, ThreatLevelMax) end

---Get time to waypoint based on current velocity.
---
------
---@param indx number Waypoint index. Default is the next waypoint.
---@return number #Time in seconds. If velocity is 0
function OPSGROUP:GetTimeToWaypoint(indx) end

---Get MOOSE UNIT object.
---
------
---@param UnitNumber number Number of the unit in the group. Default first unit.
---@return UNIT #The MOOSE UNIT object.
function OPSGROUP:GetUnit(UnitNumber) end

---Get relative used (loaded) cargo bay in percent.
---
------
---@param UnitName string Name of the unit. Default is of the whole group.
---@param IncludeReserved boolean If `false`, cargo weight that is only *reserved* is **not** counted. By default (`true` or `nil`), the reserved cargo is included.
---@return number #Used cargo bay in percent.
function OPSGROUP:GetUsedCargobayRelative(UnitName, IncludeReserved) end

---Get current 2D position vector of the group.
---
------
---@param UnitName? string (Optional) Get position of a specifc unit of the group. Default is the first existing unit in the group.
---@return Vec2 #Vector with x,y components.
function OPSGROUP:GetVec2(UnitName) end

---Get current 3D position vector of the group.
---
------
---@param UnitName? string (Optional) Get position of a specifc unit of the group. Default is the first existing unit in the group.
---@return Vec3 #Vector with x,y,z components.
function OPSGROUP:GetVec3(UnitName) end

---Get current velocity of the group.
---
------
---@param UnitName? string (Optional) Get velocity of a specific unit of the group. Default is from the first existing unit in the group.
---@return number #Velocity in m/s.
function OPSGROUP:GetVelocity(UnitName) end

---Get waypoint.
---
------
---@param indx number Waypoint index.
---@return OPSGROUP.Waypoint #Waypoint table.
function OPSGROUP:GetWaypoint(indx) end

---Get the waypoint from its unique ID.
---
------
---@param uid number Waypoint unique ID.
---@return OPSGROUP.Waypoint #Waypoint data.
function OPSGROUP:GetWaypointByID(uid) end

---Get the waypoint from its index.
---
------
---@param index number Waypoint index.
---@return OPSGROUP.Waypoint #Waypoint data.
function OPSGROUP:GetWaypointByIndex(index) end

---Get waypoint coordinates.
---
------
---@param index number Waypoint index.
---@return COORDINATE #Coordinate of the next waypoint.
function OPSGROUP:GetWaypointCoordinate(index) end

---Get current waypoint.
---
------
---@return OPSGROUP.Waypoint #Current waypoint table.
function OPSGROUP:GetWaypointCurrent() end

---Get current waypoint UID.
---
------
---@return number #Current waypoint UID.
function OPSGROUP:GetWaypointCurrentUID() end

---Get final waypoint.
---
------
---@return OPSGROUP.Waypoint #Final waypoint table.
function OPSGROUP:GetWaypointFinal() end

---Get unique ID of waypoint given its index.
---
------
---@param indx number Waypoint index.
---@return number #Unique ID.
function OPSGROUP:GetWaypointID(indx) end

---Get the waypoint index (its position in the current waypoints table).
---
------
---@param uid number Waypoint unique ID.
---@return OPSGROUP.Waypoint #Waypoint data.
function OPSGROUP:GetWaypointIndex(uid) end

---Get waypoint index after waypoint with given ID.
---So if the waypoint has index 3 it will return 4.
---
------
---@param uid number Unique ID of the waypoint. Default is new waypoint index after the last current one.
---@return number #Index after waypoint with given ID.
function OPSGROUP:GetWaypointIndexAfterID(uid) end

---Get current waypoint index.
---This is the index of the last passed waypoint.
---
------
---@return number #Current waypoint index.
function OPSGROUP:GetWaypointIndexCurrent() end

---Get next waypoint index.
---
------
---@param cyclic boolean If `true`, return first waypoint if last waypoint was reached. Default is patrol ad infinitum value set.
---@param i number Waypoint index from which the next index is returned. Default is the last waypoint passed.
---@return number #Next waypoint index.
function OPSGROUP:GetWaypointIndexNext(cyclic, i) end

---Get next waypoint.
---
------
---@param cyclic boolean If true, return first waypoint if last waypoint was reached.
---@return OPSGROUP.Waypoint #Next waypoint table.
function OPSGROUP:GetWaypointNext(cyclic) end

---Get waypoint speed.
---
------
---@param indx number Waypoint index.
---@return number #Speed set at waypoint in knots.
function OPSGROUP:GetWaypointSpeed(indx) end

---Get unique ID of waypoint.
---
------
---@param waypoint OPSGROUP.Waypoint The waypoint data table.
---@return number #Unique ID.
function OPSGROUP:GetWaypointUID(waypoint) end

---Get the waypoint UID from its index, i.e.
---its current position in the waypoints table.
---
------
---@param index number Waypoint index.
---@return number #Unique waypoint ID.
function OPSGROUP:GetWaypointUIDFromIndex(index) end

---Get the waypoints.
---
------
---@return table #Table of all waypoints.
function OPSGROUP:GetWaypoints() end

---Get weapon data.
---
------
---@param BitType number Type of weapon.
---@return OPSGROUP.WeaponData #Weapon range data.
function OPSGROUP:GetWeaponData(BitType) end

---Get weight of the internal cargo the group is carriing right now.
---
------
---@param UnitName string Name of the unit. Default is of the whole group.
---@param IncludeReserved boolean If `false`, cargo weight that is only *reserved* is **not** counted. By default (`true` or `nil`), the reserved cargo is included.
---@return number #Cargo weight in kg.
function OPSGROUP:GetWeightCargo(UnitName, IncludeReserved) end

---Get max weight of the internal cargo the group can carry.
---Optionally, the max cargo weight of a specific unit can be requested.
---
------
---@param UnitName string Name of the unit. Default is of the whole group.
---@return number #Max cargo weight in kg. This does **not** include any cargo loaded or reserved currently.
function OPSGROUP:GetWeightCargoMax(UnitName) end

---Get total weight of the group including cargo.
---Optionally, the total weight of a specific unit can be requested.
---
------
---@param UnitName string Name of the unit. Default is of the whole group.
---@param IncludeReserved boolean If `false`, cargo weight that is only *reserved* is **not** counted. By default (`true` or `nil`), the reserved cargo is included.
---@return number #Total weight in kg.
function OPSGROUP:GetWeightTotal(UnitName, IncludeReserved) end

---Check if an element of the group has line of sight to a coordinate.
---
------
---@param Coordinate COORDINATE The position to which we check the LoS. Can also be a DCS#Vec3.
---@param Element OPSGROUP.Element The (optinal) element. If not given, all elements are checked.
---@param OffsetElement Vec3 Offset vector of the element.
---@param OffsetCoordinate Vec3 Offset vector of the coordinate.
---@return boolean #If `true`, there is line of sight to the specified coordinate.
function OPSGROUP:HasLoS(Coordinate, Element, OffsetElement, OffsetCoordinate) end

---Check if this group has passed its final waypoint.
---
------
---@return boolean #If true, this group has passed the final waypoint.
function OPSGROUP:HasPassedFinalWaypoint() end

---Returns true if the DCS controller currently has a task.
---
------
---@return boolean #True or false if the controller has a task. Nil if no controller.
function OPSGROUP:HasTaskController() end

---Check if a given coordinate is in weapon range.
---
------
---@param TargetCoord COORDINATE Coordinate of the target.
---@param WeaponBitType number Weapon type.
---@param RefCoord COORDINATE Reference coordinate.
---@return boolean #If `true`, coordinate is in range.
function OPSGROUP:InWeaponRange(TargetCoord, WeaponBitType, RefCoord) end

---Check if group is activated.
---
------
---@return boolean #If true, the group exists or false if the group does not exist. If nil, the DCS group could not be found.
function OPSGROUP:IsActive() end

---Check if group is alive.
---
------
---@return boolean #*true* if group is exists and is activated, *false* if group is exist but is NOT activated. *nil* otherwise, e.g. the GROUP object is *nil* or the group is not spawned yet.
function OPSGROUP:IsAlive() end

---Check if this is a ARMYGROUP.
---
------
---@return boolean #If true, this is a ground group.
function OPSGROUP:IsArmygroup() end

---Check if awaiting a transport lift.
---
------
---@param Transport? OPSTRANSPORT (Optional) The transport.
---@return boolean #If true, group is awaiting transport lift..
function OPSGROUP:IsAwaitingLift(Transport) end

---Check if the group is currently boarding a carrier.
---
------
---@param CarrierGroupName? string (Optional) Additionally check if group is boarding this particular carrier group.
---@return boolean #If true, group is boarding.
function OPSGROUP:IsBoarding(CarrierGroupName) end

---Check if the group is currently busy doing something.
---
---* Boarding
---* Rearming
---* Returning
---* Pickingup, Loading, Transporting, Unloading
---* Engageing
---
------
---@return boolean #If `true`, group is busy.
function OPSGROUP:IsBusy() end

---Check if the group is assigned as cargo.
---
------
---@param CheckTransport boolean If `true` or `nil`, also check if cargo is associated with a transport assignment. If not, we consider it not cargo.
---@return boolean #If true, group is cargo.
function OPSGROUP:IsCargo(CheckTransport) end

---Check if the group is a carrier.
---
------
---@return boolean #If true, group is a carrier.
function OPSGROUP:IsCarrier() end

---Check if group is dead.
---Could be destroyed or despawned. FSM state of dead group is `InUtero` though.
---
------
---@return boolean #If true, all units/elements of the group are dead.
function OPSGROUP:IsDead() end

---Check if group was destroyed.
---
------
---@return boolean #If true, all units/elements of the group were destroyed.
function OPSGROUP:IsDestroyed() end

---Check if the group is engaging another unit or group.
---
------
---@return boolean #If true, group is engaging.
function OPSGROUP:IsEngaging() end

---Check if group is exists.
---
------
---@return boolean #If true, the group exists or false if the group does not exist. If nil, the DCS group could not be found.
function OPSGROUP:IsExist() end

---Check if this is a FLIGHTGROUP.
---
------
---@return boolean #If true, this is an airplane or helo group.
function OPSGROUP:IsFlightgroup() end

---Check if group is in state in utero.
---Note that dead groups are also in utero but will return `false` here.
---
------
---@return boolean #If true, group is not spawned yet.
function OPSGROUP:IsInUtero() end

---Check if group is currently inside a zone.
---
------
---@param Zone ZONE The zone.
---@return boolean #If true, group is in this zone
function OPSGROUP:IsInZone(Zone) end

---Check if the group has currently switched a LASER on.
---
------
---@return boolean #If true, LASER of the group is on.
function OPSGROUP:IsLasing() end

---Check if this group is currently "late activated" and needs to be "activated" to appear in the mission.
---
------
---@return boolean #Is this the group late activated?
function OPSGROUP:IsLateActivated() end

---Check if the group is currently loaded into a carrier.
---
------
---@param CarrierGroupName? string (Optional) Additionally check if group is loaded into a particular carrier group(s).
---@return boolean #If true, group is loaded.
function OPSGROUP:IsLoaded(CarrierGroupName) end

---Check if the group is loading cargo.
---
------
---@return boolean #If true, group is loading.
function OPSGROUP:IsLoading() end

---Check if a given mission is already in the queue.
---
------
---@param Mission AUFTRAG the mission to check
---@return boolean #If `true`, the mission is in the queue.
function OPSGROUP:IsMissionInQueue(Mission) end

---Check if a given mission type is already in the queue.
---
------
---@param MissionType string MissionType Type of mission.
---@return boolean #If `true`, the mission type is in the queue.
function OPSGROUP:IsMissionTypeInQueue(MissionType) end

---Check if this is a NAVYGROUP.
---
------
---@return boolean #If true, this is a ship group.
function OPSGROUP:IsNavygroup() end

---Check if the group is **not** cargo.
---
------
---@param CheckTransport boolean If `true` or `nil`, also check if cargo is associated with a transport assignment. If not, we consider it not cargo.
---@return boolean #If true, group is *not* cargo.
function OPSGROUP:IsNotCargo(CheckTransport) end

---Check if the group is not a carrier yet.
---
------
---@return boolean #If true, group is not a carrier.
function OPSGROUP:IsNotCarrier() end

---Check if group is currently on a mission.
---
------
---@param MissionUID? number (Optional) Check if group is currently on a mission with this UID. Default is to check for any current mission.
---@return boolean #If `true`, group is currently on a mission.
function OPSGROUP:IsOnMission(MissionUID) end

---Check if the group is completely out of ammo.
---
------
---@return boolean #If `true`, group is out-of-ammo.
function OPSGROUP:IsOutOfAmmo() end

---Check if the group is out of bombs.
---
------
---@return boolean #If `true`, group is out of bombs.
function OPSGROUP:IsOutOfBombs() end

---Check if the group is out of guns.
---
------
---@return boolean #If `true`, group is out of guns.
function OPSGROUP:IsOutOfGuns() end

---Check if the group is out of missiles.
---
------
---@return boolean #If `true`, group is out of missiles.
function OPSGROUP:IsOutOfMissiles() end

---Check if the group is out of torpedos.
---
------
---@return boolean #If `true`, group is out of torpedos.
function OPSGROUP:IsOutOfTorpedos() end

---Check if the group is picking up cargo.
---
------
---@return boolean #If true, group is picking up.
function OPSGROUP:IsPickingup() end

---Check if the group is currently rearming or on its way to the rearming place.
---
------
---@return boolean #If true, group is rearming.
function OPSGROUP:IsRearming() end

---Check if the group is retreated (has reached its retreat zone).
---
------
---@return boolean #If true, group is retreated.
function OPSGROUP:IsRetreated() end

---Check if the group is currently retreating or retreated.
---
------
---@return boolean #If true, group is retreating or retreated.
function OPSGROUP:IsRetreating() end

---Check if the group is currently returning to a zone.
---
------
---@return boolean #If true, group is returning.
function OPSGROUP:IsReturning() end

---Check if group is in state spawned.
---
------
---@return boolean #If true, group is spawned.
function OPSGROUP:IsSpawned() end

---Check if FSM is stopped.
---
------
---@return boolean #If true, FSM state is stopped.
function OPSGROUP:IsStopped() end

---Check if target is detected.
---
------
---@param TargetObject POSITIONABLE The target object.
---@return boolean #If `true`, target was detected.
function OPSGROUP:IsTargetDetected(TargetObject) end

---Check if the group is transporting cargo.
---
------
---@return boolean #If true, group is transporting.
function OPSGROUP:IsTransporting() end

---Check if this group is currently "uncontrolled" and needs to be "started" to begin its route.
---
------
---@return boolean #If true, this group uncontrolled.
function OPSGROUP:IsUncontrolled() end

---Check if the group is unloading cargo.
---
------
---@return boolean #If true, group is unloading.
function OPSGROUP:IsUnloading() end

---Check if group is currently waiting.
---
------
---@return boolean #If true, group is currently waiting.
function OPSGROUP:IsWaiting() end

---Set detection on or off.
---If detection is on, detected targets of the group will be evaluated and FSM events triggered.
---
------
---@param TargetObject POSITIONABLE The target object.
---@param KnowType boolean Make type known.
---@param KnowDist boolean Make distance known.
---@param Delay number Delay in seconds before the target is known.
---@return OPSGROUP #self
function OPSGROUP:KnowTarget(TargetObject, KnowType, KnowDist, Delay) end

---Mark waypoints on F10 map.
---
------
---@param Duration number Duration in seconds how long the waypoints are displayed before they are automatically removed. Default is that they are never removed.
---@return OPSGROUP #self
function OPSGROUP:MarkWaypoints(Duration) end

---Triggers the FSM event "MissionCancel".
---
------
---@param Mission AUFTRAG The mission.
function OPSGROUP:MissionCancel(Mission) end

---Triggers the FSM event "MissionDone".
---
------
---@param Mission AUFTRAG The mission.
function OPSGROUP:MissionDone(Mission) end

---Triggers the FSM event "MissionExecute".
---
------
---@param Mission AUFTRAG The mission.
function OPSGROUP:MissionExecute(Mission) end

---Triggers the FSM event "MissionStart".
---
------
---@param Mission AUFTRAG The mission.
function OPSGROUP:MissionStart(Mission) end

---Create a new OPSGROUP class object.
---
------
---@param group GROUP The GROUP object. Can also be given by its group name as `#string`.
---@return OPSGROUP #self
function OPSGROUP:New(group) end

---Create a *scheduled* task.
---
------
---@param task table DCS task table structure.
---@param clock string Mission time when task is executed. Default in 5 seconds. If argument passed as #number, it defines a relative delay in seconds.
---@param description string Brief text describing the task, e.g. "Attack SAM".
---@param prio number Priority of the task.
---@param duration number Duration before task is cancelled in seconds counted after task started. Default never.
---@return OPSGROUP.Task #The task structure.
function OPSGROUP:NewTaskScheduled(task, clock, description, prio, duration) end

---On After "DetectedGroup" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Group Group Detected Group.
function OPSGROUP:OnAfterDetectedGroup(From, Event, To, Group) end

---On After "DetectedGroupKnown" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Group Group Known detected group.
function OPSGROUP:OnAfterDetectedGroupKnown(From, Event, To, Group) end

---On After "DetectedGroupLost" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Group Group Lost detected group.
function OPSGROUP:OnAfterDetectedGroupLost(From, Event, To, Group) end

---On After "DetectedGroupNew" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Group Group Newly detected group.
function OPSGROUP:OnAfterDetectedGroupNew(From, Event, To, Group) end

---On After "DetectedUnit" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Unit Unit Detected Unit.
function OPSGROUP:OnAfterDetectedUnit(From, Event, To, Unit) end

---On After "DetectedUnitKnown" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Unit Unit Known detected unit.
function OPSGROUP:OnAfterDetectedUnitKnown(From, Event, To, Unit) end

---On After "DetectedUnitLost" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Unit Unit Lost detected unit.
function OPSGROUP:OnAfterDetectedUnitLost(From, Event, To, Unit) end

---On After "DetectedUnitNew" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Unit Unit Newly detected unit.
function OPSGROUP:OnAfterDetectedUnitNew(From, Event, To, Unit) end

---On after "HoverEnd" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function OPSGROUP:OnAfterHoverEnd(From, Event, To) end

---On after "HoverStart" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function OPSGROUP:OnAfterHoverStart(From, Event, To) end

---On after "MissionCancel" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Mission AUFTRAG The mission.
function OPSGROUP:OnAfterMissionCancel(From, Event, To, Mission) end

---On after "MissionDone" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Mission AUFTRAG The mission.
function OPSGROUP:OnAfterMissionDone(From, Event, To, Mission) end

---On after "MissionExecute" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Mission AUFTRAG The mission.
function OPSGROUP:OnAfterMissionExecute(From, Event, To, Mission) end

---On after "MissionStart" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Mission AUFTRAG The mission.
function OPSGROUP:OnAfterMissionStart(From, Event, To, Mission) end

---On after "TransportCancel" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Transport OPSTRANSPORT The transport.
function OPSGROUP:OnAfterTransportCancel(From, Event, To, Transport) end

---Event function handling the birth of a unit.
---
------
---@param EventData EVENTDATA Event data.
function OPSGROUP:OnEventBirth(EventData) end

---Event function handling the dead of a unit.
---
------
---@param EventData EVENTDATA Event data.
function OPSGROUP:OnEventDead(EventData) end

---Event function handling the hit of a unit.
---
------
---@param EventData EVENTDATA Event data.
function OPSGROUP:OnEventHit(EventData) end

---Event function handling the event that a unit achieved a kill.
---
------
---@param EventData EVENTDATA Event data.
function OPSGROUP:OnEventKill(EventData) end

---Event function handling when a unit is removed from the game.
---
------
---@param EventData EVENTDATA Event data.
function OPSGROUP:OnEventPlayerLeaveUnit(EventData) end

---Event function handling when a unit is removed from the game.
---
------
---@param EventData EVENTDATA Event data.
function OPSGROUP:OnEventRemoveUnit(EventData) end

---Push DCS task.
---
------
---@param DCSTask table DCS task structure.
---@return OPSGROUP #self
function OPSGROUP:PushTask(DCSTask) end

---Send a radio transmission via SRS Text-To-Speech.
---
------
---@param Text string Text of transmission.
---@param Delay number Delay in seconds before the transmission is started.
---@param SayCallsign boolean If `true`, the callsign is prepended to the given text. Default `false`.
---@param Frequency number Override sender frequency, helpful when you need multiple radios from the same sender. Default is the frequency set for the OpsGroup.
---@return OPSGROUP #self
function OPSGROUP:RadioTransmission(Text, Delay, SayCallsign, Frequency) end

---Reduce weight to the internal cargo of an element of the group.
---
------
---@param UnitName string Name of the unit.
---@param Weight number Cargo weight to be reduced in kg.
function OPSGROUP:RedWeightCargo(UnitName, Weight) end

---Remove mission from queue.
---
------
---@param Mission AUFTRAG Mission to be removed.
---@return OPSGROUP #self
function OPSGROUP:RemoveMission(Mission) end

---Remove task from task queue.
---
------
---@param Task OPSGROUP.Task The task to be removed from the queue.
---@return boolean #True if task could be removed.
function OPSGROUP:RemoveTask(Task) end

---Remove a waypoint.
---
------
---@param wpindex number Waypoint number.
---@return OPSGROUP #self
function OPSGROUP:RemoveWaypoint(wpindex) end

---Remove a waypoint with a ceratin UID.
---
------
---@param uid number Waypoint UID.
---@return OPSGROUP #self
function OPSGROUP:RemoveWaypointByID(uid) end

---Remove waypoints markers on the F10 map.
---
------
---@param Delay number Delay in seconds before the markers are removed. Default is immediately.
---@return OPSGROUP #self
function OPSGROUP:RemoveWaypointMarkers(Delay) end

---Return group back to the legion it belongs to.
---Group is despawned and added back to the stock.
---
------
---@param Delay number Delay in seconds before the group will be despawned. Default immediately
---@return OPSGROUP #self
function OPSGROUP:ReturnToLegion(Delay) end

---Route group along waypoints.
---
------
---@param waypoints table Table of waypoints.
---@param delay number Delay in seconds.
---@return OPSGROUP #self
function OPSGROUP:Route(waypoints, delay) end

---Route group to mission.
---
------
---@param mission AUFTRAG The mission table.
---@param delay number Delay in seconds.
function OPSGROUP:RouteToMission(mission, delay) end

---Self destruction of group.
---An explosion is created at the position of each element.
---
------
---@param Delay number Delay in seconds. Default now.
---@param ExplosionPower? number (Optional) Explosion power in kg TNT. Default 100 kg.
---@param ElementName string Name of the element that should be destroyed. Default is all elements.
---@return OPSGROUP #self
function OPSGROUP:SelfDestruction(Delay, ExplosionPower, ElementName) end

---Set current altitude.
---
------
---@param Altitude number Altitude in feet. Default is 10,000 ft for airplanes and 1,500 feet for helicopters.
---@param Keep boolean If `true` the group will maintain that speed on passing waypoints. If `nil` or `false` the group will return to the speed as defined by their route.
---@param RadarAlt NOTYPE 
---@return OPSGROUP #self
function OPSGROUP:SetAltitude(Altitude, Keep, RadarAlt) end

---Set max weight that each unit of the group can handle.
---
------
---@param Weight number Max weight of cargo in kg the unit can carry.
---@param UnitName string Name of the Unit. If not given, weight is set for all units of the group.
---@return OPSGROUP #self
function OPSGROUP:SetCargoBayLimit(Weight, UnitName) end

---Set that this carrier is an all aspect loader.
---
------
---@param Length number Length of loading zone in meters. Default 50 m.
---@param Width number Width of loading zone in meters. Default 20 m.
---@return OPSGROUP #self
function OPSGROUP:SetCarrierLoaderAllAspect(Length, Width) end

---Set that this carrier is a back loader.
---
------
---@param Length number Length of loading zone in meters. Default 50 m.
---@param Width number Width of loading zone in meters. Default 20 m.
---@return OPSGROUP #self
function OPSGROUP:SetCarrierLoaderBack(Length, Width) end

---Set that this carrier is a front loader.
---
------
---@param Length number Length of loading zone in meters. Default 50 m.
---@param Width number Width of loading zone in meters. Default 20 m.
---@return OPSGROUP #self
function OPSGROUP:SetCarrierLoaderFront(Length, Width) end

---Set that this carrier is a port (left side) loader.
---
------
---@param Length number Length of loading zone in meters. Default 50 m.
---@param Width number Width of loading zone in meters. Default 20 m.
---@return OPSGROUP #self
function OPSGROUP:SetCarrierLoaderPort(Length, Width) end

---Set that this carrier is a starboard (right side) loader.
---
------
---@param Length number Length of loading zone in meters. Default 50 m.
---@param Width number Width of loading zone in meters. Default 20 m.
---@return OPSGROUP #self
function OPSGROUP:SetCarrierLoaderStarboard(Length, Width) end

---Set that this carrier is an all aspect unloader.
---
------
---@param Length number Length of loading zone in meters. Default 50 m.
---@param Width number Width of loading zone in meters. Default 20 m.
---@return OPSGROUP #self
function OPSGROUP:SetCarrierUnloaderAllAspect(Length, Width) end

---Set that this carrier is a back unloader.
---
------
---@param Length number Length of loading zone in meters. Default 50 m.
---@param Width number Width of loading zone in meters. Default 20 m.
---@return OPSGROUP #self
function OPSGROUP:SetCarrierUnloaderBack(Length, Width) end

---Set that this carrier is a front unloader.
---
------
---@param Length number Length of loading zone in meters. Default 50 m.
---@param Width number Width of loading zone in meters. Default 20 m.
---@return OPSGROUP #self
function OPSGROUP:SetCarrierUnloaderFront(Length, Width) end

---Set that this carrier is a port (left side) unloader.
---
------
---@param Length number Length of loading zone in meters. Default 50 m.
---@param Width number Width of loading zone in meters. Default 20 m.
---@return OPSGROUP #self
function OPSGROUP:SetCarrierUnloaderPort(Length, Width) end

---Set that this carrier is a starboard (right side) unloader.
---
------
---@param Length number Length of loading zone in meters. Default 50 m.
---@param Width number Width of loading zone in meters. Default 20 m.
---@return OPSGROUP #self
function OPSGROUP:SetCarrierUnloaderStarboard(Length, Width) end

---Define a SET of zones that trigger and event if the group enters or leaves any of the zones.
---
------
---@param CheckZonesSet SET_ZONE Set of zones.
---@return OPSGROUP #self
function OPSGROUP:SetCheckZones(CheckZonesSet) end

---Set the default Alarm State for the group.
---This is the state gets when the group is spawned or to which it defaults back after a mission.
---
------
---@param alarmstate number Alarm state of group. Default is `AI.Option.Ground.val.ALARM_STATE.AUTO` (0).
---@return OPSGROUP #self
function OPSGROUP:SetDefaultAlarmstate(alarmstate) end

---Set default cruise altitude.
---
------
---@param Altitude number Altitude in feet. Default is 10,000 ft for airplanes and 1,500 feet for helicopters.
---@return OPSGROUP #self
function OPSGROUP:SetDefaultAltitude(Altitude) end

---Set default callsign.
---
------
---@param CallsignName number Callsign name.
---@param CallsignNumber number Callsign number. Default 1.
---@return OPSGROUP #self
function OPSGROUP:SetDefaultCallsign(CallsignName, CallsignNumber) end

---Set the default EPLRS for the group.
---
------
---@param OnOffSwitch boolean If `true`, EPLRS is on by default. If `false` default EPLRS setting is off. If `nil`, default is on if group has EPLRS and off if it does not have a datalink.
---@return OPSGROUP #self
function OPSGROUP:SetDefaultEPLRS(OnOffSwitch) end

---Set the default emission state for the group.
---
------
---@param OnOffSwitch boolean If `true`, EPLRS is on by default. If `false` default EPLRS setting is off. If `nil`, default is on if group has EPLRS and off if it does not have a datalink.
---@return OPSGROUP #self
function OPSGROUP:SetDefaultEmission(OnOffSwitch) end

---Set default formation.
---
------
---@param Formation number The formation the groups flies in.
---@return OPSGROUP #self
function OPSGROUP:SetDefaultFormation(Formation) end

---Set default ICLS parameters.
---
------
---@param Channel number ICLS channel. Default is 1.
---@param Morse string Morse code. Default "XXX".
---@param UnitName string Name of the unit acting as beacon.
---@param OffSwitch boolean If true, TACAN is off by default.
---@return OPSGROUP #self
function OPSGROUP:SetDefaultICLS(Channel, Morse, UnitName, OffSwitch) end

---Set the default immortal for the group.
---
------
---@param OnOffSwitch boolean If `true`, group is immortal by default.
---@return OPSGROUP #self
function OPSGROUP:SetDefaultImmortal(OnOffSwitch) end

---Set the default invisible for the group.
---
------
---@param OnOffSwitch boolean If `true`, group is ivisible by default.
---@return OPSGROUP #self
function OPSGROUP:SetDefaultInvisible(OnOffSwitch) end

---Set the default ROE for the group.
---This is the ROE state gets when the group is spawned or to which it defaults back after a mission.
---
------
---@param roe number ROE of group. Default is `ENUMS.ROE.ReturnFire`.
---@return OPSGROUP #self
function OPSGROUP:SetDefaultROE(roe) end

---Set the default ROT for the group.
---This is the ROT state gets when the group is spawned or to which it defaults back after a mission.
---
------
---@param rot number ROT of group. Default is `ENUMS.ROT.PassiveDefense`.
---@return OPSGROUP #self
function OPSGROUP:SetDefaultROT(rot) end

---Set default Radio frequency and modulation.
---
------
---@param Frequency number Radio frequency in MHz. Default 251 MHz.
---@param Modulation number Radio modulation. Default `radio.modulation.AM`.
---@param OffSwitch boolean If true, radio is OFF by default.
---@return OPSGROUP #self
function OPSGROUP:SetDefaultRadio(Frequency, Modulation, OffSwitch) end

---Set default cruise speed.
---
------
---@param Speed number Speed in knots.
---@return OPSGROUP #self
function OPSGROUP:SetDefaultSpeed(Speed) end

---Set default TACAN parameters.
---
------
---@param Channel number TACAN channel. Default is 74.
---@param Morse string Morse code. Default "XXX".
---@param UnitName string Name of the unit acting as beacon.
---@param Band string TACAN mode. Default is "X" for ground and "Y" for airborne units.
---@param OffSwitch boolean If true, TACAN is off by default.
---@return OPSGROUP #self
function OPSGROUP:SetDefaultTACAN(Channel, Morse, UnitName, Band, OffSwitch) end

---Set detection on or off.
---If detection is on, detected targets of the group will be evaluated and FSM events triggered.
---
------
---@param Switch boolean If `true`, detection is on. If `false` or `nil`, detection is off. Default is off.
---@return OPSGROUP #self
function OPSGROUP:SetDetection(Switch) end

---Disable to automatically engage detected targets.
---
------
---@return OPSGROUP #self
function OPSGROUP:SetEngageDetectedOff() end

---Enable to automatically engage detected targets.
---
------
---@param RangeMax number Max range in NM. Only detected targets within this radius from the group will be engaged. Default is 25 NM.
---@param TargetTypes table Types of target attributes that will be engaged. See [DCS enum attributes](https://wiki.hoggitworld.com/view/DCS_enum_attributes). Default "All".
---@param EngageZoneSet SET_ZONE Set of zones in which targets are engaged. Default is anywhere.
---@param NoEngageZoneSet SET_ZONE Set of zones in which targets are *not* engaged. Default is nowhere.
---@return OPSGROUP #self
function OPSGROUP:SetEngageDetectedOn(RangeMax, TargetTypes, EngageZoneSet, NoEngageZoneSet) end

---Set LASER parameters.
---
------
---@param Code number Laser code. Default 1688.
---@param CheckLOS boolean Check if lasing unit has line of sight to target coordinate. Default is `true`.
---@param IROff boolean If true, then dont switch on the additional IR pointer.
---@param UpdateTime number Time interval in seconds the beam gets up for moving targets. Default every 0.5 sec.
---@return OPSGROUP #self
function OPSGROUP:SetLaser(Code, CheckLOS, IROff, UpdateTime) end

---Set LASER target.
---
------
---@param Target POSITIONABLE The target to lase. Can also be a COORDINATE object.
function OPSGROUP:SetLaserTarget(Target) end

---Set that group is going to rearm once it runs out of ammo.
---
------
---@return OPSGROUP #self
function OPSGROUP:SetRearmOnOutOfAmmo() end

---Set that group is retreating once it runs out of ammo.
---
------
---@return OPSGROUP #self
function OPSGROUP:SetRetreatOnOutOfAmmo() end

---Set that group is return to legion once it runs out of ammo.
---
------
---@return OPSGROUP #self
function OPSGROUP:SetReturnOnOutOfAmmo() end

---**[GROUND, NAVAL]** Set whether this group should return to its legion once all mission etc are finished.
---Only for ground and naval groups. Aircraft will
---
------
---@param Switch boolean If `true` or `nil`, group will return. If `false`, group will not return and stay where it finishes its last mission.
---@return OPSGROUP #self
function OPSGROUP:SetReturnToLegion(Switch) end

---Use SRS Simple-Text-To-Speech for transmissions.
---
------
---@param PathToSRS string Path to SRS directory.
---@param Gender string Gender: "male" or "female" (default).
---@param Culture string Culture, e.g. "en-GB" (default).
---@param Voice string Specific voice. Overrides `Gender` and `Culture`.
---@param Port number SRS port. Default 5002.
---@param PathToGoogleKey string Full path to the google credentials JSON file, e.g. `"C:\Users\myUsername\Downloads\key.json"`.
---@param Label string Label of the SRS comms for the SRS Radio overlay. Defaults to "ROBOT". No spaces allowed!
---@param Volume number Volume to be set, 0.0 = silent, 1.0 = loudest. Defaults to 1.0
---@return OPSGROUP #self
function OPSGROUP:SetSRS(PathToSRS, Gender, Culture, Voice, Port, PathToGoogleKey, Label, Volume) end

---Set current speed.
---
------
---@param Speed number Speed in knots. Default is 70% of max speed.
---@param Keep boolean If `true` the group will maintain that speed on passing waypoints. If `nil` or `false` the group will return to the speed as defined by their route.
---@param AltCorrected boolean If `true`, use altitude corrected indicated air speed.
---@return OPSGROUP #self
function OPSGROUP:SetSpeed(Speed, Keep, AltCorrected) end

---Set DCS task.
---Enroute tasks are injected automatically.
---
------
---@param DCSTask table DCS task structure.
---@return OPSGROUP #self
function OPSGROUP:SetTask(DCSTask) end

---Set verbosity level.
---
------
---@param VerbosityLevel number Level of output (higher=more). Default 0.
---@return OPSGROUP #self
function OPSGROUP:SetVerbosity(VerbosityLevel) end

---Triggers the FSM event "Status".
---
------
function OPSGROUP:Status() end

---Triggers the FSM event "Stop".
---Stops the OPSGROUP and all its event handlers.
---
------
function OPSGROUP:Stop() end

---Set current Alarm State of the group.
---
---* 0 = "Auto"
---* 1 = "Green"
---* 2 = "Red"
---
------
---@param alarmstate number Alarm state of group. Default is 0="Auto".
---@return OPSGROUP #self
function OPSGROUP:SwitchAlarmstate(alarmstate) end

---Switch to a specific callsign.
---
------
---@param CallsignName number Callsign name.
---@param CallsignNumber number Callsign number.
---@return OPSGROUP #self
function OPSGROUP:SwitchCallsign(CallsignName, CallsignNumber) end

---Switch EPLRS datalink on or off.
---
------
---@param OnOffSwitch boolean If `true` or `nil`, switch EPLRS on. If `false` EPLRS switched off.
---@return OPSGROUP #self
function OPSGROUP:SwitchEPLRS(OnOffSwitch) end

---Switch emission on or off.
---
------
---@param OnOffSwitch boolean If `true` or `nil`, switch emission on. If `false` emission switched off.
---@return OPSGROUP #self
function OPSGROUP:SwitchEmission(OnOffSwitch) end

---Switch to a specific formation.
---
------
---@param Formation number New formation the group will fly in. Default is the setting of `SetDefaultFormation()`.
---@return OPSGROUP #self
function OPSGROUP:SwitchFormation(Formation) end

---Activate/switch ICLS beacon settings.
---
------
---@param Channel number ICLS Channel. Default is what is set in `SetDefaultICLS()` so usually channel 1.
---@param Morse string ICLS morse code. Default is what is set in `SetDefaultICLS()` so usually "XXX".
---@param UnitName string Name of the unit in the group which should activate the ICLS beacon. Can also be given as #number to specify the unit number. Default is the first unit of the group.
---@return OPSGROUP #self
function OPSGROUP:SwitchICLS(Channel, Morse, UnitName) end

---Switch immortality on or off.
---
------
---@param OnOffSwitch boolean If `true` or `nil`, switch immortality on. If `false` immortality switched off.
---@return OPSGROUP #self
function OPSGROUP:SwitchImmortal(OnOffSwitch) end

---Switch invisibility on or off.
---
------
---@param OnOffSwitch boolean If `true` or `nil`, switch invisibliity on. If `false` invisibility switched off.
---@return OPSGROUP #self
function OPSGROUP:SwitchInvisible(OnOffSwitch) end

---Set current ROE for the group.
---
------
---@param roe string ROE of group. Default is value set in `SetDefaultROE` (usually `ENUMS.ROE.ReturnFire`).
---@return OPSGROUP #self
function OPSGROUP:SwitchROE(roe) end

---Set ROT for the group.
---
------
---@param rot string ROT of group. Default is value set in `:SetDefaultROT` (usually `ENUMS.ROT.PassiveDefense`).
---@return OPSGROUP #self
function OPSGROUP:SwitchROT(rot) end

---Turn radio on or switch frequency/modulation.
---
------
---@param Frequency number Radio frequency in MHz. Default is value set in `SetDefaultRadio` (usually 251 MHz).
---@param Modulation number Radio modulation. Default is value set in `SetDefaultRadio` (usually `radio.modulation.AM`).
---@return OPSGROUP #self
function OPSGROUP:SwitchRadio(Frequency, Modulation) end

---Activate/switch TACAN beacon settings.
---
------
---@param Channel number TACAN Channel.
---@param Morse string TACAN morse code. Default is the value set in @{#OPSGROUP.SetDefaultTACAN} or if not set "XXX".
---@param UnitName string Name of the unit in the group which should activate the TACAN beacon. Can also be given as #number to specify the unit number. Default is the first unit of the group.
---@param Band string TACAN channel mode "X" or "Y". Default is "Y" for aircraft and "X" for ground and naval groups.
---@return OPSGROUP #self
function OPSGROUP:SwitchTACAN(Channel, Morse, UnitName, Band) end

---Teleport the group to a different location.
---
------
---@param Coordinate COORDINATE Coordinate where the group is teleported to.
---@param Delay number Delay in seconds before respawn happens. Default 0.
---@param NoPauseMission boolean If `true`, dont pause a running mission.
---@return OPSGROUP #self
function OPSGROUP:Teleport(Coordinate, Delay, NoPauseMission) end

---Triggers the FSM event "TransportCancel".
---
------
---@param Transport OPSTRANSPORT The transport.
function OPSGROUP:TransportCancel(Transport) end

---Deactivate ICLS beacon.
---
------
---@return OPSGROUP #self
function OPSGROUP:TurnOffICLS() end

---Turn radio off.
---
------
---@return OPSGROUP #self
function OPSGROUP:TurnOffRadio() end

---Deactivate TACAN beacon.
---
------
---@return OPSGROUP #self
function OPSGROUP:TurnOffTACAN() end

---Add OPSGROUP to cargo bay of a carrier.
---
------
---@param CargoGroup OPSGROUP Cargo group.
---@param CarrierElement OPSGROUP.Element The element of the carrier.
---@param Reserved boolean Only reserve the cargo bay space.
function OPSGROUP:_AddCargobay(CargoGroup, CarrierElement, Reserved) end

---Add warehouse storage to cargo bay of a carrier.
---
------
---@param CarrierElement OPSGROUP.Element The element of the carrier.
---@param CargoUID number UID of the cargo data.
---@param StorageType string Storage type.
---@param StorageAmount number Storage amount.
---@param StorageWeight number Weight of a single storage item in kg.
function OPSGROUP:_AddCargobayStorage(CarrierElement, CargoUID, StorageType, StorageAmount, StorageWeight) end

---Add a unit/element to the OPS group.
---
------
---@param unitname string Name of unit.
---@return OPSGROUP.Element #The element or nil.
function OPSGROUP:_AddElementByName(unitname) end

---Add storage to cargo bay of a carrier.
---
------
---@param MyCargo OPSGROUP.MyCargo My cargo.
---@param CarrierElement OPSGROUP.Element The element of the carrier.
function OPSGROUP:_AddMyCargoBay(MyCargo, CarrierElement) end

---Check if awaiting a transport.
---
------
---@param Transport OPSTRANSPORT The transport.
---@return OPSGROUP #self
function OPSGROUP:_AddMyLift(Transport) end

---Initialize Mission Editor waypoints.
---
------
---@param waypoint OPSGROUP.Waypoint Waypoint data.
---@param wpnumber number Waypoint index/number. Default is as last waypoint.
function OPSGROUP:_AddWaypoint(waypoint, wpnumber) end

---Check if all elements of the group have the same status (or are dead).
---
------
---@param unitname string Name of unit.
---@param status NOTYPE 
function OPSGROUP:_AllSameStatus(unitname, status) end

---Check if all elements of the group have the same status (or are dead).
---
------
---@param status string Status to check.
---@return boolean #If true, all elements have a similar status.
function OPSGROUP:_AllSimilarStatus(status) end

---Check ammo is full.
---
------
---@return boolean #If true, ammo is full.
function OPSGROUP:_CheckAmmoFull() end

---Check ammo status.
---
------
function OPSGROUP:_CheckAmmoStatus() end

---Check cargo transport assignments.
---
------
---@return OPSGROUP #self
function OPSGROUP:_CheckCargoTransport() end

---Check damage.
---
------
---@return OPSGROUP #self
function OPSGROUP:_CheckDamage() end

---Check if all cargo of this transport assignment was delivered.
---
------
---@param CargoTransport OPSTRANSPORT The next due cargo transport or `nil`.
---@return boolean #If true, all cargo was delivered.
function OPSGROUP:_CheckDelivered(CargoTransport) end

---Check detected units.
---
------
function OPSGROUP:_CheckDetectedUnits() end

---Check if all cargo of this transport assignment was delivered.
---
------
---@param CargoTransport OPSTRANSPORT The next due cargo transport or `nil`.
---@return boolean #If true, all cargo was delivered.
function OPSGROUP:_CheckGoPickup(CargoTransport) end

---Check if passed the final waypoint and, if necessary, update route.
---
------
---@param delay number Delay in seconds.
function OPSGROUP:_CheckGroupDone(delay) end

---Check if group is in zones.
---
------
function OPSGROUP:_CheckInZones() end

---Check if group got stuck.
---
------
function OPSGROUP:_CheckStuck() end

---Get coordinate from an object.
---
------
---@param Object OBJECT The object.
---@return COORDINATE #The coordinate of the object.
function OPSGROUP:_CoordinateFromObject(Object) end

---Count paused mission.
---
------
---@return number #Number of paused missions.
function OPSGROUP:_CountPausedMissions() end

---Add OPSGROUP to cargo bay of a carrier.
---
------
---@param CargoUID number UID of the cargo data.
---@param OpsGroup OPSGROUP Cargo group.
---@param StorageType string Storage type.
---@param StorageAmount number Storage amount.
---@param StorageWeight number Weight of a single storage item in kg.
---@return OPSGROUP.MyCargo #My cargo object.
function OPSGROUP:_CreateMyCargo(CargoUID, OpsGroup, StorageType, StorageAmount, StorageWeight) end

---Enhance waypoint table.
---
------
---@param Waypoint OPSGROUP.Waypoint data.
---@param waypoint NOTYPE 
---@return OPSGROUP.Waypoint #Modified waypoint data.
function OPSGROUP:_CreateWaypoint(Waypoint, waypoint) end

---Remove OPSGROUP from cargo bay of a carrier.
---
------
---@param CargoGroup OPSGROUP Cargo group.
---@return boolean #If `true`, cargo could be removed.
function OPSGROUP:_DelCargobay(CargoGroup) end

---Remove OPSGROUP from cargo bay of a carrier.
---
------
---@param Element OPSGROUP.Element Cargo group.
---@param MyCargo OPSGROUP.MyCargo My cargo data.
---@return boolean #If `true`, cargo could be removed.
function OPSGROUP:_DelCargobayElement(Element, MyCargo) end

---Remove my lift.
---
------
---@param Transport OPSTRANSPORT The transport.
---@return OPSGROUP #self
function OPSGROUP:_DelMyLift(Transport) end

---Get cargo bay item.
---
------
---@param CargoGroup OPSGROUP Cargo group.
---@return OPSGROUP.MyCargo #Cargo bay item or `nil` if the group is not in the carrier.
---@return number #CargoBayIndex Index of item in the cargo bay table.
---@return OPSGROUP.Element #Carrier element.
function OPSGROUP:_GetCargobay(CargoGroup) end

---Remove OPSGROUP from cargo bay of a carrier.
---
------
---@param Element OPSGROUP.Element Cargo group.
---@param CargoUID number Cargo UID.
---@return OPSGROUP.MyCargo #MyCargo My cargo data.
function OPSGROUP:_GetCargobayElement(Element, CargoUID) end

---Get target group.
---
------
---@return GROUP #Detected target group.
---@return number #Distance to target.
function OPSGROUP:_GetDetectedTarget() end

---Get/update the (un-)loading zone of the element.
---
------
---@param Element OPSGROUP.Element Element.
---@param Zone ZONE_POLYGON The zone.
---@param Loader OPSGROUP.CarrierLoader Loader parameters.
---@return ZONE_POLYGON #Bounding box polygon zone.
function OPSGROUP:_GetElementZoneLoader(Element, Zone, Loader) end

---Get cargo bay data from a cargo data id.
---
------
---@param uid number Unique ID of cargo data.
---@return OPSGROUP.MyCargo #Cargo My cargo.
---@return OPSGROUP.Element #Element that has loaded the cargo.
function OPSGROUP:_GetMyCargoBayFromUID(uid) end

---Get my carrier.
---
------
---@return OPSGROUP #Carrier group.
---@return OPSGROUP.Element #Carrier element.
---@return boolean #If `true`, space is reserved for me
function OPSGROUP:_GetMyCarrier() end

---Get my carrier element.
---
------
---@return OPSGROUP.Element #Carrier element.
function OPSGROUP:_GetMyCarrierElement() end

---Get my carrier group.
---
------
---@return OPSGROUP #Carrier group.
function OPSGROUP:_GetMyCarrierGroup() end

---Get cargo transport from cargo queue.
---
------
---@return OPSTRANSPORT #The next due cargo transport or `nil`.
function OPSGROUP:_GetNextCargoTransport() end

---Get next mission.
---
------
---@return AUFTRAG #Next mission or *nil*.
function OPSGROUP:_GetNextMission() end

---Get next task in queue.
---Task needs to be in state SCHEDULED and time must have passed.
---
------
---@return OPSGROUP.Task #The next task in line or `nil`.
function OPSGROUP:_GetNextTask() end

---Get paused mission.
---
------
---@return AUFTRAG #Paused mission or nil.
function OPSGROUP:_GetPausedMission() end

---Get name of ROE corresponding to the numerical value.
---
------
---@param roe NOTYPE 
---@return string #Name of ROE.
function OPSGROUP:_GetROEName(roe) end

---Get the template of the group.
---
------
---@param Copy boolean Get a deep copy of the template.
---@return table #Template table.
function OPSGROUP:_GetTemplate(Copy) end

---Get weight of warehouse storage to transport.
---
------
---@param Storage OPSTRANSPORT.Storage 
---@param Total boolean Get total weight. Otherweise the amount left to deliver (total-loaded-lost-delivered).
---@param Reserved boolean Reduce weight that is reserved.
---@param Amount boolean Return amount not weight.
---@return number #Weight of cargo in kg or amount in number of items, if `Amount=true`.
function OPSGROUP:_GetWeightStorage(Storage, Total, Reserved, Amount) end

---Initialize Mission Editor waypoints.
---
------
---@param WpIndexMin number 
---@param WpIndexMax number 
---@return OPSGROUP #self
function OPSGROUP:_InitWaypoints(WpIndexMin, WpIndexMax) end

---Check if a unit is an element of the flightgroup.
---
------
---@param unitname string Name of unit.
---@return boolean #If true, unit is element of the flight group or false if otherwise.
function OPSGROUP:_IsElement(unitname) end

---Check if a group is in the cargo bay.
---
------
---@param OpsGroup OPSGROUP Group to check.
---@return boolean #If `true`, group is in the cargo bay.
function OPSGROUP:_IsInCargobay(OpsGroup) end

---Is my carrier reserved.
---
------
---@return boolean #If `true`, space for me was reserved.
function OPSGROUP:_IsMyCarrierReserved() end

---Returns a name of a missile category.
---
------
---@param categorynumber number Number of missile category from weapon missile category enumerator. See https://wiki.hoggitworld.com/view/DCS_Class_Weapon
---@return string #Missile category name.
function OPSGROUP:_MissileCategoryName(categorynumber) end

---Set (new) cargo status.
---
------
---@param Status string New status.
function OPSGROUP:_NewCargoStatus(Status) end

---Set (new) carrier status.
---
------
---@param Status string New status.
function OPSGROUP:_NewCarrierStatus(Status) end

---Set passed final waypoint value.
---
------
---@param final boolean If `true`, final waypoint was passed.
---@param comment string Some comment as to why the final waypoint was passed.
function OPSGROUP:_PassedFinalWaypoint(final, comment) end

--- Function called when a group is passing a waypoint.
---
------
---@param uid number Waypoint UID.
function OPSGROUP._PassingWaypoint(opsgroup, uid) end

---Print info on mission and task status to DCS log file.
---
------
function OPSGROUP:_PrintTaskAndMissionStatus() end

---On after "QueueUpdate" event.
---
------
function OPSGROUP:_QueueUpdate() end

---On after "MissionDone" event.
---
------
---@param Mission AUFTRAG 
---@param Silently boolean Remove waypoints by `table.remove()` and do not update the route.
function OPSGROUP:_RemoveMissionWaypoints(Mission, Silently) end

---Remove my carrier.
---
------
---@return OPSGROUP #self
function OPSGROUP:_RemoveMyCarrier() end

---Remove paused mission from the table.
---
------
---@param AuftragsNummer number Mission ID of the paused mission to remove.
---@return OPSGROUP #self
function OPSGROUP:_RemovePausedMission(AuftragsNummer) end

---Respawn the group.
---
------
---@param Delay number Delay in seconds before respawn happens. Default 0.
---@param Template? Template (optional) The template of the Group retrieved with GROUP:GetTemplate(). If the template is not provided, the template will be retrieved of the group itself.
---@param Reset boolean Reset waypoints and reinit group if `true`.
---@return OPSGROUP #self
function OPSGROUP:_Respawn(Delay, Template, Reset) end

---Sandwitch DCS task in stop condition and push the task to the group.
---
------
---@param DCSTask Task The DCS task.
---@param Task OPSGROUP.Task 
---@param SetTask boolean Set task instead of pushing it.
---@param Delay number Delay in seconds. Default nil.
function OPSGROUP:_SandwitchDCSTask(DCSTask, Task, SetTask, Delay) end

---Set status for all elements (except dead ones).
---
------
---@param status string Element status.
function OPSGROUP:_SetElementStatusAll(status) end

---Set legion this ops group belongs to.
---
------
---@param Legion LEGION The Legion.
---@return OPSGROUP #self
function OPSGROUP:_SetLegion(Legion) end

---Set mission specific options for ROE, Alarm state, etc.
---
------
---@param mission AUFTRAG The mission table.
function OPSGROUP:_SetMissionOptions(mission) end

---Set my carrier.
---
------
---@param CarrierGroup OPSGROUP Carrier group.
---@param CarrierElement OPSGROUP.Element Carrier element.
---@param Reserved boolean If `true`, reserve space for me.
function OPSGROUP:_SetMyCarrier(CarrierGroup, CarrierElement, Reserved) end

---Set the template of the group.
---
------
---@param Template table Template to set. Default is from the GROUP.
---@return OPSGROUP #self
function OPSGROUP:_SetTemplate(Template) end

---Set tasks at this waypoint
---
------
---@param Waypoint OPSGROUP.Waypoint The waypoint.
---@return number #Number of tasks.
function OPSGROUP:_SetWaypointTasks(Waypoint) end

---Simple task function.
---Can be used to call a function which has the warehouse and the executing group as parameters.
---
------
---@param Function string The name of the function to call passed as string.
---@param uid number Waypoint UID.
function OPSGROUP:_SimpleTaskFunction(Function, uid) end

---On after "Loading" event.
---
------
---@param Cargos table Table of cargos.
---@return table #Table of sorted cargos.
function OPSGROUP:_SortCargo(Cargos) end

---Sort task queue.
---
------
function OPSGROUP:_SortTaskQueue() end

---Spawn group from a given template.
---
------
---@param Delay number Delay in seconds before respawn happens. Default 0.
---@param Template? Template (optional) The template of the Group retrieved with GROUP:GetTemplate(). If the template is not provided, the template will be retrieved of the group itself.
---@return OPSGROUP #self
function OPSGROUP:_Spawn(Delay, Template) end

---Activate/switch ICLS beacon settings.
---
------
---@param Icls OPSGROUP.Beacon ICLS data table.
---@return OPSGROUP #self
function OPSGROUP:_SwitchICLS(Icls) end

---Activate/switch TACAN beacon settings.
---
------
---@param Tacan OPSGROUP.Beacon TACAN data table. Default is the default TACAN settings.
---@return OPSGROUP #self
function OPSGROUP:_SwitchTACAN(Tacan) end

--- Function called when a task is done.
---
------
---@param opsgroup OPSGROUP Ops group.
---@param task OPSGROUP.Task Task.
function OPSGROUP._TaskDone(group, opsgroup, task) end

--- Function called when a task is executed.
---
------
---@param opsgroup OPSGROUP Ops group.
---@param task OPSGROUP.Task Task.
function OPSGROUP._TaskExecute(group, opsgroup, task) end

---Transfer cargo from to another carrier.
---
------
---@param CargoGroup OPSGROUP The cargo group to be transferred.
---@param CarrierGroup OPSGROUP The new carrier group.
---@param CarrierElement OPSGROUP.Element The new carrier element.
function OPSGROUP:_TransferCargo(CargoGroup, CarrierGroup, CarrierElement) end

---Update laser point.
---
------
function OPSGROUP:_UpdateLaser() end

---Check if all elements of the group have the same status (or are dead).
---
------
---@return OPSGROUP #self
function OPSGROUP:_UpdatePosition() end

---Check if all elements of the group have the same status or are dead.
---
------
---@param element OPSGROUP.Element Element.
---@param newstatus string New status of element
---@param airbase AIRBASE Airbase if applicable.
function OPSGROUP:_UpdateStatus(element, newstatus, airbase) end

---Update (DCS) task.
---
------
---@param Task OPSGROUP.Task The task.
---@param Mission AUFTRAG The mission.
function OPSGROUP:_UpdateTask(Task, Mission) end

---Initialize Mission Editor waypoints.
---
------
---@param n number Waypoint
function OPSGROUP:_UpdateWaypointTasks(n) end

---Triggers the FSM event "MissionCancel" after a delay.
---
------
---@param delay number Delay in seconds.
---@param Mission AUFTRAG The mission.
function OPSGROUP:__MissionCancel(delay, Mission) end

---Triggers the FSM event "MissionDone" after a delay.
---
------
---@param delay number Delay in seconds.
---@param Mission AUFTRAG The mission.
function OPSGROUP:__MissionDone(delay, Mission) end

---Triggers the FSM event "MissionExecute" after a delay.
---
------
---@param delay number Delay in seconds.
---@param Mission AUFTRAG The mission.
function OPSGROUP:__MissionExecute(delay, Mission) end

---Triggers the FSM event "MissionStart" after a delay.
---
------
---@param delay number Delay in seconds.
---@param Mission AUFTRAG The mission.
function OPSGROUP:__MissionStart(delay, Mission) end

---Triggers the FSM event "Status" after a delay.
---
------
---@param delay number Delay in seconds.
function OPSGROUP:__Status(delay) end

---Triggers the FSM event "Stop" after a delay.
---Stops the OPSGROUP and all its event handlers.
---
------
---@param delay number Delay in seconds.
function OPSGROUP:__Stop(delay) end

---Triggers the FSM event "TransportCancel" after a delay.
---
------
---@param delay number Delay in seconds.
---@param Transport OPSTRANSPORT The transport.
function OPSGROUP:__TransportCancel(delay, Transport) end

---On after "Board" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param CarrierGroup OPSGROUP The carrier group.
---@param Carrier OPSGROUP.Element The OPSGROUP element
---@private
function OPSGROUP:onafterBoard(From, Event, To, CarrierGroup, Carrier) end

---On after "Damaged" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function OPSGROUP:onafterDamaged(From, Event, To) end

---On after "Dead" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function OPSGROUP:onafterDead(From, Event, To) end

---On after "Delivered" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param CargoTransport OPSTRANSPORT The cargo transport assignment.
---@private
function OPSGROUP:onafterDelivered(From, Event, To, CargoTransport) end

---On after "Destroyed" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function OPSGROUP:onafterDestroyed(From, Event, To) end

---On after "DetectedGroup" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Group GROUP The detected Group.
---@private
function OPSGROUP:onafterDetectedGroup(From, Event, To, Group) end

---On after "DetectedGroupNew" event.
---Add newly detected group to detected group set.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Group GROUP The detected group.
---@private
function OPSGROUP:onafterDetectedGroupNew(From, Event, To, Group) end

---On after "DetectedUnit" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Unit UNIT The detected unit.
---@private
function OPSGROUP:onafterDetectedUnit(From, Event, To, Unit) end

---On after "DetectedUnitNew" event.
---Add newly detected unit to detected unit set.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Unit UNIT The detected unit.
---@private
function OPSGROUP:onafterDetectedUnitNew(From, Event, To, Unit) end

---On after "ElementDamaged" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Element OPSGROUP.Element The flight group element.
---@private
function OPSGROUP:onafterElementDamaged(From, Event, To, Element) end

---On after "ElementDead" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Element OPSGROUP.Element The flight group element.
---@private
function OPSGROUP:onafterElementDead(From, Event, To, Element) end

---On after "ElementDestroyed" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Element OPSGROUP.Element The flight group element.
---@private
function OPSGROUP:onafterElementDestroyed(From, Event, To, Element) end

---On after "ElementHit" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Element OPSGROUP.Element The flight group element.
---@param Enemy UNIT Unit that hit the element or `nil`.
---@private
function OPSGROUP:onafterElementHit(From, Event, To, Element, Enemy) end

---On after "ElementInUtero" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Element OPSGROUP.Element The flight group element.
---@private
function OPSGROUP:onafterElementInUtero(From, Event, To, Element) end

---On after "EnterZone" event.
---Sets self.inzones[zonename]=true.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Zone ZONE The zone that the group entered.
---@private
function OPSGROUP:onafterEnterZone(From, Event, To, Zone) end

---On after "GotoWaypoint" event.
---Group will got to the given waypoint and execute its route from there.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param UID number The goto waypoint unique ID.
---@param Speed? number (Optional) Speed to waypoint in knots.
---@private
function OPSGROUP:onafterGotoWaypoint(From, Event, To, UID, Speed) end

---On after "Hit" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Enemy UNIT Unit that hit the element or `nil`.
---@private
function OPSGROUP:onafterHit(From, Event, To, Enemy) end

---On after "InUtero" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function OPSGROUP:onafterInUtero(From, Event, To) end

---On after "LaserCode" event.
---Changes the LASER code.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Code number Laser code. Default is 1688.
---@private
function OPSGROUP:onafterLaserCode(From, Event, To, Code) end

---On after "LaserGotLOS" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function OPSGROUP:onafterLaserGotLOS(From, Event, To) end

---On after "LaserLostLOS" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function OPSGROUP:onafterLaserLostLOS(From, Event, To) end

---On after "LaserOff" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function OPSGROUP:onafterLaserOff(From, Event, To) end

---On after "LaserOn" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Target COORDINATE Target Coordinate. Target can also be any POSITIONABLE from which we can obtain its coordinates.
---@private
function OPSGROUP:onafterLaserOn(From, Event, To, Target) end

---On after "LaserPause" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function OPSGROUP:onafterLaserPause(From, Event, To) end

---On after "LaserResume" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function OPSGROUP:onafterLaserResume(From, Event, To) end

---On after "LeaveZone" event.
---Sets self.inzones[zonename]=false.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Zone ZONE The zone that the group entered.
---@private
function OPSGROUP:onafterLeaveZone(From, Event, To, Zone) end

---On after "Load" event.
---Carrier loads a cargo group into ints cargo bay.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param CargoGroup OPSGROUP The OPSGROUP loaded as cargo.
---@param Carrier OPSGROUP.Element The carrier element/unit.
---@private
function OPSGROUP:onafterLoad(From, Event, To, CargoGroup, Carrier) end

---On after "Loading" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function OPSGROUP:onafterLoading(From, Event, To) end

---On after "LoadingDone" event.
---Carrier has loaded all (possible) cargo at the pickup zone.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function OPSGROUP:onafterLoadingDone(From, Event, To) end

---On after "MissionCancel" event.
---Cancels the mission.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Mission AUFTRAG The mission to be cancelled.
---@private
function OPSGROUP:onafterMissionCancel(From, Event, To, Mission) end

---On after "MissionDone" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Mission AUFTRAG The mission that is done.
---@private
function OPSGROUP:onafterMissionDone(From, Event, To, Mission) end

---On after "MissionExecute" event.
---Mission execution began.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Mission AUFTRAG The mission table.
---@private
function OPSGROUP:onafterMissionExecute(From, Event, To, Mission) end

---On after "MissionStart" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Mission AUFTRAG The mission table.
---@private
function OPSGROUP:onafterMissionStart(From, Event, To, Mission) end

---On after "OutOfAmmo" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function OPSGROUP:onafterOutOfAmmo(From, Event, To) end

---On after "PassedFinalWaypoint" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function OPSGROUP:onafterPassedFinalWaypoint(From, Event, To) end

---On after "PassingWaypoint" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Waypoint OPSGROUP.Waypoint Waypoint data passed.
---@private
function OPSGROUP:onafterPassingWaypoint(From, Event, To, Waypoint) end

---On after "PauseMission" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function OPSGROUP:onafterPauseMission(From, Event, To) end

---On after "Pickup" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function OPSGROUP:onafterPickup(From, Event, To) end

---On after "Respawn" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Template table The template used to respawn the group. Default is the inital template of the group.
---@private
function OPSGROUP:onafterRespawn(From, Event, To, Template) end

---On after "Stop" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function OPSGROUP:onafterStop(From, Event, To) end

---On after "TaskCancel" event.
---Cancels the current task or simply sets the status to DONE if the task is not the current one.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Task OPSGROUP.Task The task to cancel. Default is the current task (if any).
---@private
function OPSGROUP:onafterTaskCancel(From, Event, To, Task) end

---On after "TaskDone" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Task OPSGROUP.Task 
---@private
function OPSGROUP:onafterTaskDone(From, Event, To, Task) end

---On after "TaskExecute" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Task OPSGROUP.Task The task.
---@private
function OPSGROUP:onafterTaskExecute(From, Event, To, Task) end

---On after "Transport" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function OPSGROUP:onafterTransport(From, Event, To) end

---On after "TransportCancel" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param The OPSTRANSPORT transport to be cancelled.
---@param Transport NOTYPE 
---@private
function OPSGROUP:onafterTransportCancel(From, Event, To, The, Transport) end

---On after "Unload" event.
---Carrier unloads a cargo group from its cargo bay.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param OpsGroup OPSGROUP The OPSGROUP loaded as cargo.
---@param Coordinate COORDINATE Coordinate were the group is unloaded to.
---@param Activated boolean If `true`, group is active. If `false`, group is spawned in late activated state.
---@param Heading? number (Optional) Heading of group in degrees. Default is random heading for each unit.
---@private
function OPSGROUP:onafterUnload(From, Event, To, OpsGroup, Coordinate, Activated, Heading) end

---On after "Unloaded" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param OpsGroupCargo OPSGROUP Cargo OPSGROUP that was unloaded from a carrier.
---@private
function OPSGROUP:onafterUnloaded(From, Event, To, OpsGroupCargo) end

---On after "Unloading" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function OPSGROUP:onafterUnloading(From, Event, To) end

---On after "UnloadingDone" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function OPSGROUP:onafterUnloadingDone(From, Event, To) end

---On after "UnpauseMission" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function OPSGROUP:onafterUnpauseMission(From, Event, To) end

---On after "Wait" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Duration number Duration in seconds how long the group will be waiting. Default `nil` (for ever).
---@private
function OPSGROUP:onafterWait(From, Event, To, Duration) end

---On before "Board" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param CarrierGroup OPSGROUP The carrier group.
---@param Carrier OPSGROUP.Element The OPSGROUP element
---@private
function OPSGROUP:onbeforeBoard(From, Event, To, CarrierGroup, Carrier) end

---On before "Dead" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function OPSGROUP:onbeforeDead(From, Event, To) end

---On before "ElementSpawned" event.
---Check that element is not in status spawned already.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Element OPSGROUP.Element The flight group element.
---@private
function OPSGROUP:onbeforeElementSpawned(From, Event, To, Element) end

---On before "LaserOff" event.
---Check if LASER is on.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function OPSGROUP:onbeforeLaserOff(From, Event, To) end

---On before "LaserOn" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Target COORDINATE Target Coordinate. Target can also be any POSITIONABLE from which we can obtain its coordinates.
---@private
function OPSGROUP:onbeforeLaserOn(From, Event, To, Target) end

---On before "LaserResume" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function OPSGROUP:onbeforeLaserResume(From, Event, To) end

---On before "MissionStart" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Mission AUFTRAG The mission table.
---@private
function OPSGROUP:onbeforeMissionStart(From, Event, To, Mission) end

---On before "Stop" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function OPSGROUP:onbeforeStop(From, Event, To) end

---On before "TaskDone" event.
---Deny transition if task status is PAUSED.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Task OPSGROUP.Task 
---@private
function OPSGROUP:onbeforeTaskDone(From, Event, To, Task) end

---On before "TaskExecute" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Task OPSGROUP.Task The task.
---@private
function OPSGROUP:onbeforeTaskExecute(From, Event, To, Task) end

---On before "Transport" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function OPSGROUP:onbeforeTransport(From, Event, To) end

---On before "Unload" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param OpsGroup OPSGROUP The OPSGROUP loaded as cargo.
---@param Coordinate COORDINATE Coordinate were the group is unloaded to.
---@param Heading number Heading of group.
---@private
function OPSGROUP:onbeforeUnload(From, Event, To, OpsGroup, Coordinate, Heading) end

---On before "Wait" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Duration number Duration how long the group will be waiting in seconds. Default `nil` (=forever).
---@private
function OPSGROUP:onbeforeWait(From, Event, To, Duration) end


---Ammo data.
---@class OPSGROUP.Ammo 
---@field Bombs number Amount of bombs.
---@field Guns number Amount of gun shells.
---@field Missiles number Amount of missiles.
---@field MissilesAA number Amount of air-to-air missiles.
---@field MissilesAG number Amount of air-to-ground missiles.
---@field MissilesAS number Amount of anti-ship missiles.
---@field MissilesBM number Amount of ballistic missiles.
---@field MissilesCR number Amount of cruise missiles.
---@field MissilesSA number Amount of surfe-to-air missiles.
---@field Rockets number Amount of rockets.
---@field Torpedos number Amount of torpedos.
---@field Total number Total amount of ammo.
OPSGROUP.Ammo = {}


---Beacon data.
---@class OPSGROUP.Beacon 
---@field Band string Band "X" or "Y" for TACAN beacon.
---@field BeaconName string Name of the unit acting as beacon.
---@field BeaconUnit UNIT Unit object acting as beacon.
---@field Channel number Channel.
---@field Morse number Morse Code.
---@field On boolean If true, beacon is on, if false, beacon is turned off. If nil, has not been used yet.
OPSGROUP.Beacon = {}


---Callsign data.
---@class OPSGROUP.Callsign 
---@field NameSquad string Name of the squad, e.g. "Uzi".
---@field NumberGroup number Group number. First number after name, e.g. "Uzi-**1**-1".
---@field NumberSquad number Squadron number corresponding to a name like "Uzi".
OPSGROUP.Callsign = {}


---Cargo group data.
---@class OPSGROUP.CargoGroup 
---@field private delivered boolean If `true`, group was delivered.
---@field private disembarkActivation boolean If `true`, group is activated. If `false`, group is late activated.
---@field private disembarkCarriers SET_OPSGROUP Carriers where this group is directly disembared to.
---@field private disembarkZone ZONE Zone where this group is disembarked to.
---@field private opsgroup OPSGROUP The cargo opsgroup.
---@field private status string Status of the cargo group. Not used yet.
---@field private storage OPSTRANSPORT.Storage Storage data.
---@field private type string Type of cargo: "OPSGROUP" or "STORAGE".
---@field private uid number Unique ID of this cargo data.
OPSGROUP.CargoGroup = {}


---Cargo status.
---@class OPSGROUP.CargoStatus 
---@field ASSIGNED string Cargo is assigned to a carrier. (Not used!)
---@field AWAITING string Group is awaiting carrier.
---@field BOARDING string Cargo is boarding a carrier.
---@field LOADED string Cargo is loaded into a carrier.
---@field NOTCARGO string This group is no cargo yet.
OPSGROUP.CargoStatus = {}


---Cargo carrier loader parameters.
---@class OPSGROUP.CarrierLoader 
---@field private length number Length of (un-)loading zone in meters.
---@field private type string Loader type "Front", "Back", "Left", "Right", "All".
---@field private width number Width of (un-)loading zone in meters.
OPSGROUP.CarrierLoader = {}


---Cargo Carrier status.
---@class OPSGROUP.CarrierStatus 
---@field LOADED string Carrier has loaded cargo.
---@field LOADING string Carrier is loading cargo.
---@field NOTCARRIER string This group is not a carrier yet.
---@field PICKUP string Carrier is on its way to pickup cargo.
---@field TRANSPORTING string Carrier is transporting cargo.
---@field UNLOADING string Carrier is unloading cargo.
OPSGROUP.CarrierStatus = {}


---OPS group element.
---@class OPSGROUP.Element 
---@field DCSunit Unit The DCS unit object.
---@field Nhit number Number of times the element was hit.
---@field private ai boolean If true, element is AI.
---@field private callsign string Call sign, e.g. "Uzi 1-1".
---@field private cargoBay table Cargo bay.
---@field private category number Aircraft category.
---@field private categoryname string Aircraft category name.
---@field private client CLIENT The client if element is occupied by a human player.
---@field private controller Controller The DCS controller of the unit.
---@field private damage number Damage of element in percent.
---@field private descriptors Object.Desc Descriptors table.
---@field private engineOn boolean If `true`, engines were started.
---@field private fuelmass number Mass of fuel in kg.
---@field private group GROUP The GROUP object.
---@field private heading number Last known heading in degrees.
---@field private height number Height of element in meters.
---@field private length number Length of element in meters.
---@field private life number Life points when last updated.
---@field private life0 number Initial life points.
---@field private modex string Tail number.
---@field private name string Name of the element, i.e. the unit.
---@field private orientX Vec3 Last known ordientation vector in the direction of the nose X.
---@field private parking AIRBASE.ParkingSpot The parking spot table the element is parking on.
---@field private playerName string Name of player if this is a client.
---@field private pylons table Table of pylons.
---@field private size number Size (max of length, width, height) in meters.
---@field private skill string Skill level.
---@field private status string The element status. See @{#OPSGROUP.ElementStatus}.
---@field private typename string Type name.
---@field private unit UNIT The UNIT object.
---@field private vec3 Vec3 Last known 3D position vector.
---@field private weight number Current weight including cargo in kg.
---@field private weightCargo number Current cargo weight in kg.
---@field private weightEmpty number Empty weight in kg.
---@field private weightMaxCargo number Max. cargo weight in kg.
---@field private weightMaxTotal number Max. total weight in kg.
---@field private width number Width of element in meters.
---@field private zoneBoundingbox ZONE_POLYGON_BASE Bounding box zone of the element unit.
---@field private zoneLoad ZONE_POLYGON_BASE Loading zone.
---@field private zoneUnload ZONE_POLYGON_BASE Unloading zone.
OPSGROUP.Element = {}


---Status of group element.
---@class OPSGROUP.ElementStatus 
---@field AIRBORNE string Element is airborne. Either after takeoff or after air start.
---@field ARRIVED string Element arrived at its parking spot and shut down its engines.
---@field DEAD string Element is dead after it crashed, pilot ejected or pilot dead events.
---@field ENGINEON string Element started its engines.
---@field INUTERO string Element was not spawned yet or its status is unknown so far.
---@field LANDED string Element landed and is taxiing to its parking spot.
---@field LANDING string Element is landing.
---@field PARKING string Element is parking after spawned on ramp.
---@field SPAWNED string Element was spawned into the world.
---@field TAKEOFF string Element took of after takeoff event.
---@field TAXIING string Element is taxiing after engine startup.
OPSGROUP.ElementStatus = {}


---Status of group.
---@class OPSGROUP.GroupStatus 
---@field AIRBORNE string Element is airborne. Either after takeoff or after air start.
---@field ARRIVED string Arrived at its parking spot and shut down its engines.
---@field DEAD string Element is dead after it crashed, pilot ejected or pilot dead events.
---@field INBOUND string 
---@field INUTERO string Not spawned yet or its status is unknown so far.
---@field LANDED string Landed and is taxiing to its parking spot.
---@field LANDING string Landing.
---@field PARKING string Parking after spawned on ramp.
---@field TAXIING string Taxiing after engine startup.
OPSGROUP.GroupStatus = {}


---Element cargo bay data.
---@class OPSGROUP.MyCargo 
---@field private cargoUID NOTYPE 
---@field private group OPSGROUP The cargo group.
---@field private reserved boolean If `true`, the cargo bay space is reserved but cargo has not actually been loaded yet.
---@field private storageAmount number Amount of storage.
---@field private storageType number Type of storage.
---@field private storageWeight number Weight of storage item.
OPSGROUP.MyCargo = {}


---Data of the carrier that has loaded this group.
---@class OPSGROUP.MyCarrier 
---@field private element OPSGROUP.Element The carrier element.
---@field private group OPSGROUP The carrier group.
---@field private reserved boolean If `true`, the carrier has caro space reserved for me.
OPSGROUP.MyCarrier = {}


---Option data.
---@class OPSGROUP.Option 
---@field Alarm number Alarm state.
---@field Disperse boolean Disperse under fire.
---@field EPLRS boolean data link.
---@field Emission boolean Emission on/off.
---@field Formation number Formation.
---@field Immortal boolean Immortal on/off.
---@field Invisible boolean Invisible on/off.
---@field ROE number Rule of engagement.
---@field ROT number Reaction on threat.
OPSGROUP.Option = {}


---Radio data.
---@class OPSGROUP.Radio 
---@field Freq number Frequency
---@field Modu number Modulation.
---@field On boolean If true, radio is on, if false, radio is turned off. If nil, has not been used yet.
OPSGROUP.Radio = {}


---Spawn point data.
---@class OPSGROUP.Spawnpoint 
---@field Airport AIRBASE Airport where to spawn.
---@field Coordinate COORDINATE Coordinate where to spawn
---@field TerminalIDs table Terminal IDs, where to spawn the group. It is a table of `#number`s because a group can consist of multiple units.
OPSGROUP.Spawnpoint = {}


---Laser and IR spot data.
---@class OPSGROUP.Spot 
---@field CheckLOS boolean If true, check LOS to target.
---@field Code number Laser code.
---@field Coordinate COORDINATE where the spot is pointing.
---@field IR Spot Infra-red spot.
---@field IRon boolean If true, turn IR pointer on.
---@field LOS boolean 
---@field Laser Spot Laser spot.
---@field On boolean If true, the laser is on.
---@field Paused boolean If true, laser is paused.
---@field TargetGroup GROUP The target group.
---@field TargetType number Type of target: 0=coordinate, 1=static, 2=unit, 3=group.
---@field TargetUnit POSITIONABLE The current target unit.
---@field private dt number Update time interval in seconds.
---@field private element OPSGROUP.Element The element of the group that is lasing.
---@field private lostLOS boolean If true, laser lost LOS.
---@field private offset Vec3 Local offset of the laser source.
---@field private offsetTarget Vec3 Offset of the target.
---@field private timer TIMER Spot timer.
---@field private vec3 Vec3 The 3D positon vector of the laser (and IR) spot.
OPSGROUP.Spot = {}


---Task structure.
---@class OPSGROUP.Task 
---@field private backupROE number Rules of engagement that are restored once the task is over.
---@field private dcstask table DCS task structure.
---@field private description string Brief text which describes the task.
---@field private duration number Duration before task is cancelled in seconds. Default never.
---@field private id number Task ID. Running number to get the task.
---@field private ismission boolean This is an AUFTRAG task.
---@field private prio number Priority.
---@field private status string Task status.
---@field private stopflag USERFLAG If flag is set to 1 (=true), the task is stopped.
---@field private target TARGET Target object.
---@field private time number Abs. mission time when to execute the task.
---@field private timestamp number Abs. mission time, when task was started.
---@field private type string Type of task: either SCHEDULED or WAYPOINT.
---@field private waypoint number Waypoint index if task is a waypoint task.
OPSGROUP.Task = {}


---Ops group task status.
---@class OPSGROUP.TaskStatus 
---@field DONE string Task is done.
---@field EXECUTING string Task is being executed.
---@field PAUSED string Task is paused.
---@field SCHEDULED string Task is scheduled.
OPSGROUP.TaskStatus = {}


---Ops group task status.
---@class OPSGROUP.TaskType 
---@field SCHEDULED string Task is scheduled and will be executed at a given time.
---@field WAYPOINT string Task is executed at a specific waypoint.
OPSGROUP.TaskType = {}


---Waypoint data.
---@class OPSGROUP.Waypoint 
---@field private action string Waypoint action (turning point, etc.). Ground groups have the formation here.
---@field private alt number Altitude in meters. For submaries use negative sign for depth.
---@field private astar boolean If true, this waypint was found by A* pathfinding algorithm.
---@field private coordinate COORDINATE Waypoint coordinate.
---@field private detour number Signifies that this waypoint is not part of the normal route: 0=Hold, 1=Resume Route.
---@field private formation string Ground formation. Similar to action but on/off road.
---@field private intowind boolean If true, this waypoint is a turn into wind route point.
---@field private marker MARKER Marker on the F10 map.
---@field private missionUID number Mission UID (Auftragsnr) this waypoint belongs to.
---@field private name string Waypoint description. Shown in the F10 map.
---@field private npassed number Number of times a groups passed this waypoint.
---@field private patrol boolean 
---@field private roadcoord COORDINATE Closest point to road.
---@field private roaddist number Distance to closest point on road.
---@field private speed number Speed in m/s.
---@field private task table Waypoint DCS task combo.
---@field private temp boolean If true, this is a temporary waypoint and will be deleted when passed. Also the passing waypoint FSM event is not triggered.
---@field private type string Waypoint type.
---@field private uid number Waypoint's unit id, which is a running number.
---@field private x number Waypoint x-coordinate.
---@field private y number Waypoint y-coordinate.
OPSGROUP.Waypoint = {}


---Weapon range data.
---@class OPSGROUP.WeaponData 
---@field BitType number Type of weapon.
---@field RangeMax number Max range in meters.
---@field RangeMin number Min range in meters.
---@field ReloadTime number Time to reload in seconds.
OPSGROUP.WeaponData = {}



