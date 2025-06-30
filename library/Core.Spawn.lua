---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Core_Spawn.JPG" width="100%">
---
---**Core** - Spawn dynamically new groups of units in running missions.
---
---===
---
---## Features:
---
---  * Spawn new groups in running missions.
---  * Schedule spawning of new groups.
---  * Put limits on the amount of groups that can be spawned, and the amount of units that can be alive at the same time.
---  * Randomize the spawning location between different zones.
---  * Randomize the initial positions within the zones.
---  * Spawn in array formation.
---  * Spawn uncontrolled (for planes or helicopters only).
---  * Clean up inactive helicopters that "crashed".
---  * Place a hook to capture a spawn event, and tailor with customer code.
---  * Spawn late activated.
---  * Spawn with or without an initial delay.
---  * Respawn after landing, on the runway or at the ramp after engine shutdown.
---  * Spawn with custom heading, both for a group formation and for the units in the group.
---  * Spawn with different skills.
---  * Spawn with different liveries.
---  * Spawn with an inner and outer radius to set the initial position.
---  * Spawn with a randomize route.
---  * Spawn with a randomized template.
---  * Spawn with a randomized start points on a route.
---  * Spawn with an alternative name.
---  * Spawn and keep the unit names.
---  * Spawn with a different coalition and country.
---  * Enquiry methods to check on spawn status.
---
---===
---
---### [Demo Missions](https://github.com/FlightControl-Master/MOOSE_MISSIONS/tree/master/Core/Spawn)
---
---===
---
---### [YouTube Playlist](https://www.youtube.com/playlist?list=PL7ZUrU4zZUl1jirWIo4t4YxqN-HxjqRkL)
---
---===
---
---### Author: **FlightControl**
---### Contributions: A lot of people within this community!
---
---===
---Allows to spawn dynamically new Wrapper.Groups.
---
---Each SPAWN object needs to be have related **template groups** setup in the Mission Editor (ME),
---which is a normal group with the **Late Activation** flag set.
---This template group will never be activated in your mission.
---SPAWN uses that **template group** to reference to all the characteristics
---(air, ground, livery, unit composition, formation, skill level etc) of each new group to be spawned.
---
---Therefore, when creating a SPAWN object, the #SPAWN.New and #SPAWN.NewWithAlias require
---**the name of the template group** to be given as a string to those constructor methods.
---
---Initialization settings can be applied on the SPAWN object,
---which modify the behavior or the way groups are spawned.
---These initialization methods have the prefix **Init**.
---There are also spawn methods with the prefix **Spawn** and will spawn new groups in various ways.
---
---### IMPORTANT! The methods with prefix **Init** must be used before any methods with prefix **Spawn** method are used, or unexpected results may appear!!!
---
---Because SPAWN can spawn multiple groups of a template group,
---SPAWN has an **internal index** that keeps track
---which was the latest group that was spawned.
---
---**Limits** can be set on how many groups can be spawn in each SPAWN object,
---using the method #SPAWN.InitLimit. SPAWN has 2 kind of limits:
---
---  * The maximum amount of Wrapper.Units that can be **alive** at the same time...
---  * The maximum amount of Wrapper.Groups that can be **spawned**... This is more of a **resource**-type of limit.
---
---When new groups get spawned using the **Spawn** methods,
---it will be evaluated whether any limits have been reached.
---When no spawn limit is reached, a new group will be created by the spawning methods,
---and the internal index will be increased with 1.
---
---These limits ensure that your mission does not accidentally get flooded with spawned groups.
---Additionally, it also guarantees that independent of the group composition,
---at any time, the most optimal amount of groups are alive in your mission.
---For example, if your template group has a group composition of 10 units, and you specify a limit of 100 units alive at the same time,
---with unlimited resources = :InitLimit( 100, 0 ) and 10 groups are alive, but two groups have only one unit alive in the group,
---then a sequent Spawn(Scheduled) will allow a new group to be spawned!!!
---
---### IMPORTANT!! If a limit has been reached, it is possible that a **Spawn** method returns **nil**, meaning, no Wrapper.Group had been spawned!!!
---
---Spawned groups get **the same name** as the name of the template group.
---Spawned units in those groups keep _by default_ **the same name** as the name of the template group.
---However, because multiple groups and units are created from the template group,
---a suffix is added to each spawned group and unit.
---
---Newly spawned groups will get the following naming structure at run-time:
---
---  1. Spawned groups will have the name _GroupName_#_nnn_, where _GroupName_ is the name of the **template group**,
---  and _nnn_ is a **counter from 0 to 999**.
---  2. Spawned units will have the name _GroupName_#_nnn_-_uu_,
---  where _uu_ is a **counter from 0 to 99** for each new spawned unit belonging to the group.
---
---That being said, there is a way to keep the same unit names!
---The method #SPAWN.InitKeepUnitNames() will keep the same unit names as defined within the template group, thus:
---
---  3. Spawned units will have the name _UnitName_#_nnn_-_uu_,
---  where _UnitName_ is the **unit name as defined in the template group*,
---  and _uu_ is a **counter from 0 to 99** for each new spawned unit belonging to the group.
---
---Some **additional notes that need to be considered!!**:
---
---  * templates are actually groups defined within the mission editor, with the flag "Late Activation" set.
---  As such, these groups are never used within the mission, but are used by the #SPAWN module.
---  * It is important to defined BEFORE you spawn new groups, 
---  a proper initialization of the SPAWN instance is done with the options you want to use.
---  * When designing a mission, NEVER name groups using a "#" within the name of the group Spawn template(s),
---  or the SPAWN module logic won't work anymore.
---
---## SPAWN construction methods
---
---Create a new SPAWN object with the #SPAWN.New() or the #SPAWN.NewWithAlias() methods:
---
---  * #SPAWN.New(): Creates a new SPAWN object taking the name of the group that represents the GROUP template (definition).
---  * #SPAWN.NewWithAlias(): Creates a new SPAWN object taking the name of the group that represents the GROUP template (definition), and gives each spawned Wrapper.Group an different name.
---
---It is important to understand how the SPAWN class works internally. The SPAWN object created will contain internally a list of groups that will be spawned and that are already spawned.
---The initialization methods will modify this list of groups so that when a group gets spawned, ALL information is already prepared when spawning. This is done for performance reasons.
---So in principle, the group list will contain all parameters and configurations after initialization, and when groups get actually spawned, this spawning can be done quickly and efficient.
---
---## SPAWN **Init**ialization methods
---
---A spawn object will behave differently based on the usage of **initialization** methods, which all start with the **Init** prefix:
---
---### Unit Names
---
---  * #SPAWN.InitKeepUnitNames(): Keeps the unit names as defined within the mission editor, but note that anything after a # mark is ignored, and any spaces before and after the resulting name are removed. IMPORTANT! This method MUST be the first used after :New !!!
---
---### Route randomization
---
---  * #SPAWN.InitRandomizeRoute(): Randomize the routes of spawned groups, and for air groups also optionally the height.
---
---### Group composition randomization
---
---  * #SPAWN.InitRandomizeTemplate(): Randomize the group templates so that when a new group is spawned, a random group template is selected from one of the templates defined. 
---
---### Uncontrolled
---
---  * #SPAWN.InitUnControlled(): Spawn plane groups uncontrolled.
---
---### Array formation
---
---  * #SPAWN.InitArray(): Make groups visible before they are actually activated, and order these groups like a battalion in an array.
---  
---### Group initial position - if wanted different from template position, for use with e.g. #SPAWN.SpawnScheduled().   
---
---  * #SPAWN.InitPositionCoordinate(): Set initial position of group via a COORDINATE.
---  * #SPAWN.InitPositionVec2(): Set initial position of group via a VEC2. 
---  
---### Set the positions of a group's units to absolute positions, or relative positions to unit No. 1
---
---  * #SPAWN.InitSetUnitRelativePositions(): Spawn the UNITs of this group with individual relative positions to unit #1 and individual headings.
---  * #SPAWN.InitSetUnitAbsolutePositions(): Spawn the UNITs of this group with individual absolute positions and individual headings.
---  
---### Position randomization
---
---  * #SPAWN.InitRandomizePosition(): Randomizes the position of Wrapper.Groups that are spawned within a **radius band**, given an Outer and Inner radius, from the point that the spawn happens.
---  * #SPAWN.InitRandomizeUnits(): Randomizes the Wrapper.Units in the Wrapper.Group that is spawned within a **radius band**, given an Outer and Inner radius.
---  * #SPAWN.InitRandomizeZones(): Randomizes the spawning between a predefined list of Core.Zones that are declared using this function. Each zone can be given a probability factor.
---
---### Enable / Disable AI when spawning a new Wrapper.Group
---
---  * #SPAWN.InitAIOn(): Turns the AI On when spawning the new Wrapper.Group object.
---  * #SPAWN.InitAIOff(): Turns the AI Off when spawning the new Wrapper.Group object.
---  * #SPAWN.InitAIOnOff(): Turns the AI On or Off when spawning the new Wrapper.Group object.
---
---### Limit scheduled spawning
---
---  * #SPAWN.InitLimit(): Limits the amount of groups that can be alive at the same time and that can be dynamically spawned.
---
---### Delay initial scheduled spawn
---
---  * #SPAWN.InitDelayOnOff(): Turns the initial delay On/Off when scheduled spawning the first Wrapper.Group object.
---  * #SPAWN.InitDelayOn(): Turns the initial delay On when scheduled spawning the first Wrapper.Group object.
---  * #SPAWN.InitDelayOff(): Turns the initial delay Off when scheduled spawning the first Wrapper.Group object.
---
---### Repeat spawned Wrapper.Groups upon landing
---
---  * #SPAWN.InitRepeat() or #SPAWN.InitRepeatOnLanding(): This method is used to re-spawn automatically the same group after it has landed.
---  * #SPAWN.InitRepeatOnEngineShutDown(): This method is used to re-spawn automatically the same group after it has landed and it shuts down the engines at the ramp.
---  * #SPAWN.StopRepeat(): This method is used to stop the repeater.
---  
---### Link-16 Datalink STN and SADL IDs (limited at the moment to F15/16/18/AWACS/Tanker/B1B, but not the F15E for clients, SADL A10CII only)
---
---  * #SPAWN.InitSTN(): Set the STN of the first unit in the group. All other units will have consecutive STNs, provided they have not been used yet.
---  * #SPAWN.InitSADL(): Set the SADL of the first unit in the group. All other units will have consecutive SADLs, provided they have not been used yet.
---  
---### Callsigns
---
---  * #SPAWN.InitRandomizeCallsign(): Set a random callsign name per spawn.
---  * #SPAWN.SpawnInitCallSign(): Set a specific callsign for a spawned group.
---  
---### Speed
---
---  * #SPAWN.InitSpeedMps(): Set the initial speed on spawning in meters per second.
---  * #SPAWN.InitSpeedKph(): Set the initial speed on spawning in kilometers per hour.
---  * #SPAWN.InitSpeedKnots(): Set the initial speed on spawning in knots.
---
---## SPAWN **Spawn** methods
---
---Groups can be spawned at different times and methods:
---
---### **Single** spawning methods
---
---  * #SPAWN.Spawn(): Spawn one new group based on the last spawned index.
---  * #SPAWN.ReSpawn(): Re-spawn a group based on a given index.
---  * #SPAWN.SpawnFromVec3(): Spawn a new group from a Vec3 coordinate. (The group will can be spawned at a point in the air).
---  * #SPAWN.SpawnFromVec2(): Spawn a new group from a Vec2 coordinate. (The group will be spawned at land height ).
---  * #SPAWN.SpawnFromStatic(): Spawn a new group from a structure, taking the position of a Wrapper.Static.
---  * #SPAWN.SpawnFromUnit(): Spawn a new group taking the position of a Wrapper.Unit.
---  * #SPAWN.SpawnInZone(): Spawn a new group in a Core.Zone.
---  * #SPAWN.SpawnAtAirbase(): Spawn a new group at an Wrapper.Airbase, which can be an airdrome, ship or helipad.
---
---Note that #SPAWN.Spawn and #SPAWN.ReSpawn return a Wrapper.Group#GROUP.New object, that contains a reference to the DCSGroup object.
---You can use the Wrapper.Group#GROUP object to do further actions with the DCSGroup.
---
---### **Scheduled** spawning methods
---
---  * #SPAWN.SpawnScheduled(): Spawn groups at scheduled but randomized intervals.
----  * #SPAWN.SpawnScheduleStart(): Start or continue to spawn groups at scheduled time intervals.
---  * #SPAWN.SpawnScheduleStop(): Stop the spawning of groups at scheduled time intervals.
---
---## Retrieve alive GROUPs spawned by the SPAWN object
---
---The SPAWN class administers which GROUPS it has reserved (in stock) or has created during mission execution.
---Every time a SPAWN object spawns a new GROUP object, a reference to the GROUP object is added to an internal table of GROUPS.
---SPAWN provides methods to iterate through that internal GROUP object reference table:
---
---  * #SPAWN.GetFirstAliveGroup(): Will find the first alive GROUP it has spawned, and return the alive GROUP object and the first Index where the first alive GROUP object has been found.
---  * #SPAWN.GetNextAliveGroup(): Will find the next alive GROUP object from a given Index, and return a reference to the alive GROUP object and the next Index where the alive GROUP has been found.
---  * #SPAWN.GetLastAliveGroup(): Will find the last alive GROUP object, and will return a reference to the last live GROUP object and the last Index where the last alive GROUP object has been found.
---
---You can use the methods #SPAWN.GetFirstAliveGroup() and sequently #SPAWN.GetNextAliveGroup() to iterate through the alive GROUPS within the SPAWN object, and to actions... See the respective methods for an example.
---The method #SPAWN.GetGroupFromIndex() will return the GROUP object reference from the given Index, dead or alive...
---
---## Spawned cleaning of inactive groups
---
---Sometimes, it will occur during a mission run-time, that ground or especially air objects get damaged, and will while being damaged stop their activities, while remaining alive.
---In such cases, the SPAWN object will just sit there and wait until that group gets destroyed, but most of the time it won't,
---and it may occur that no new groups are or can be spawned as limits are reached.
---To prevent this, a #SPAWN.InitCleanUp() initialization method has been defined that will silently monitor the status of each spawned group.
---Once a group has a velocity = 0, and has been waiting for a defined interval, that group will be cleaned or removed from run-time.
---There is a catch however :-) If a damaged group has returned to an airbase within the coalition, that group will not be considered as "lost"...
---In such a case, when the inactive group is cleaned, a new group will Re-spawned automatically.
---This models AI that has successfully returned to their airbase, to restart their combat activities.
---Check the #SPAWN.InitCleanUp() for further info.
---
---## Catch the Wrapper.Group Spawn Event in a callback function!
---
---When using the #SPAWN.SpawnScheduled)() method, new @{Wrapper.Groups are created following the spawn time interval parameters.
---When a new Wrapper.Group is spawned, you maybe want to execute actions with that group spawned at the spawn event.
---The SPAWN class supports this functionality through the method #SPAWN.OnSpawnGroup( **function( SpawnedGroup ) end ** ),
---which takes a function as a parameter that you can define locally.
---Whenever a new Wrapper.Group is spawned, the given function is called, and the Wrapper.Group that was just spawned, is given as a parameter.
---As a result, your spawn event handling function requires one parameter to be declared, which will contain the spawned Wrapper.Group object.
---A coding example is provided at the description of the #SPAWN.OnSpawnGroup( **function( SpawnedGroup ) end ** ) method.
---
---## Delay the initial spawning
---
---When using the #SPAWN.SpawnScheduled)() method, the default behavior of this method will be that it will spawn the initial (first) @{Wrapper.Group
---immediately when :SpawnScheduled() is initiated. The methods #SPAWN.InitDelayOnOff() and #SPAWN.InitDelayOn() can be used to
---activate a delay before the first Wrapper.Group is spawned. For completeness, a method #SPAWN.InitDelayOff() is also available, that
---can be used to switch off the initial delay. Because there is no delay by default, this method would only be used when a
---#SPAWN.SpawnScheduleStop() ; #SPAWN.SpawnScheduleStart() sequence would have been used.
---SPAWN Class
---@class SPAWN : BASE
---@field AIOnOff boolean 
---@field AliveUnits number 
---@field CleanUpScheduler  
---@field DelayOnOff boolean 
---@field InitSpeed  
---@field MaxAliveGroups number 
---@field MaxAliveUnits number 
---@field Repeat boolean 
---@field RepeatOnEngineShutDown boolean 
---@field RepeatOnLanding boolean 
---@field SpawnAliasPrefix string 
---@field SpawnAliasPrefixEscaped  
---@field SpawnCleanUpInterval  
---@field SpawnFromNewPosition boolean 
---@field SpawnFunctionHook  
---@field SpawnGrouping  
---@field SpawnHiddenOnMFD boolean 
---@field SpawnHiddenOnPlanner boolean 
---@field SpawnHookScheduler  
---@field SpawnIndex number 
---@field SpawnInitAirbase  
---@field SpawnInitCallSign boolean 
---@field SpawnInitCallSignName  
---@field SpawnInitCategory  
---@field SpawnInitCoalition  
---@field SpawnInitCountry  
---@field SpawnInitFreq  
---@field SpawnInitGroupHeadingMax  
---@field SpawnInitGroupHeadingMin  
---@field SpawnInitGroupUnitVar  
---@field SpawnInitHeadingMax  
---@field SpawnInitHeadingMin  
---@field SpawnInitKeepUnitNames boolean 
---@field SpawnInitLimit boolean 
---@field SpawnInitLivery  
---@field SpawnInitModu  
---@field SpawnInitPosition  
---@field SpawnInitSADL  
---@field SpawnInitSkill string 
---@field SpawnInitTerminalType  
---@field SpawnIsScheduled boolean 
---@field SpawnMaxGroups number 
---@field SpawnMaxUnitsAlive number 
---@field SpawnRandomCallsign boolean 
---@field SpawnRandomize boolean 
---@field SpawnRandomizeRoute boolean 
---@field SpawnRandomizeRouteEndPoint  
---@field SpawnRandomizeRouteHeight  
---@field SpawnRandomizeRouteRadius  
---@field SpawnRandomizeRouteStartPoint  
---@field SpawnRandomizeTemplate boolean 
---@field SpawnRandomizeZones boolean 
---@field SpawnScheduler  
---@field SpawnTemplate  
---@field SpawnTemplatePrefix string 
---@field SpawnTemplatePrefixEscaped  
---@field SpawnTemplatePrefixTable  
---@field SpawnUnitsWithAbsolutePositions boolean 
---@field SpawnUnitsWithRelativePositions boolean 
---@field SpawnVisible boolean 
---@field TweakedTemplate boolean 
---@field UnControlled boolean 
---@field UnitsAbsolutePositions  
---@field UnitsRelativePositions  
---@field hidden  
---@field speed  
SPAWN = {}

---Get the Coordinate of the Group that is Late Activated as the template for the SPAWN object.
---
------
---@param self SPAWN 
---@return COORDINATE #The Coordinate
function SPAWN:GetCoordinate() end

---Will find the first alive Wrapper.Group it has spawned, and return the alive Wrapper.Group object and the first Index where the first alive Wrapper.Group object has been found.
---
------
---
---USAGE
---```
---
---  -- Find the first alive @{Wrapper.Group} object of the SpawnPlanes SPAWN object @{Wrapper.Group} collection that it has spawned during the mission.
---  local GroupPlane, Index = SpawnPlanes:GetFirstAliveGroup()
---  while GroupPlane ~= nil do
---    -- Do actions with the GroupPlane object.
---    GroupPlane, Index = SpawnPlanes:GetNextAliveGroup( Index )
---  end
---```
------
---@param self SPAWN 
---@return number #The @{Wrapper.Group} object found, the new Index where the group was found.
---@return nil #When no group is found, #nil is returned.
function SPAWN:GetFirstAliveGroup() end

---Get the group from an index.
---Returns the group from the SpawnGroups list.
---If no index is given, it will return the first group in the list.
---
------
---@param self SPAWN 
---@param SpawnIndex number The index of the group to return.
---@return GROUP #self
function SPAWN:GetGroupFromIndex(SpawnIndex) end

---Will find the last alive Wrapper.Group object, and will return a reference to the last live Wrapper.Group object and the last Index where the last alive Wrapper.Group object has been found.
---
------
---
---USAGE
---```
---
---  -- Find the last alive @{Wrapper.Group} object of the SpawnPlanes SPAWN object @{Wrapper.Group} collection that it has spawned during the mission.
---  local GroupPlane, Index = SpawnPlanes:GetLastAliveGroup()
---  if GroupPlane then -- GroupPlane can be nil!!!
---    -- Do actions with the GroupPlane object.
---  end
---```
------
---@param self SPAWN 
---@return number #The last alive @{Wrapper.Group} object found, the last Index where the last alive @{Wrapper.Group} object was found.
---@return nil #When no alive @{Wrapper.Group} object is found, #nil is returned.
function SPAWN:GetLastAliveGroup() end

---Will find the next alive Wrapper.Group object from a given Index, and return a reference to the alive Wrapper.Group object and the next Index where the alive Wrapper.Group has been found.
---
------
---
---USAGE
---```
---
---  -- Find the first alive @{Wrapper.Group} object of the SpawnPlanes SPAWN object @{Wrapper.Group} collection that it has spawned during the mission.
---  local GroupPlane, Index = SpawnPlanes:GetFirstAliveGroup()
---  while GroupPlane ~= nil do
---    -- Do actions with the GroupPlane object.
---    GroupPlane, Index = SpawnPlanes:GetNextAliveGroup( Index )
---  end
---```
------
---@param self SPAWN 
---@param SpawnIndexStart number A Index holding the start position to search from. This method can also be used to find the first alive @{Wrapper.Group} object from the given Index.
---@return number #The next alive @{Wrapper.Group} object found, the next Index where the next alive @{Wrapper.Group} object was found.
---@return nil #When no alive @{Wrapper.Group} object is found from the start Index position, #nil is returned.
function SPAWN:GetNextAliveGroup(SpawnIndexStart) end


---
------
---@param self NOTYPE 
---@param SpawnGroup NOTYPE 
function SPAWN:GetSpawnIndexFromGroup(SpawnGroup) end

---Turns the AI Off for the Wrapper.Group when spawning.
---
------
---@param self SPAWN 
---@return SPAWN #The SPAWN object
function SPAWN:InitAIOff() end

---Turns the AI On for the Wrapper.Group when spawning.
---
------
---@param self SPAWN 
---@return SPAWN #The SPAWN object
function SPAWN:InitAIOn() end

---Turns the AI On or Off for the Wrapper.Group when spawning.
---
------
---@param self SPAWN 
---@param AIOnOff boolean A value of true sets the AI On, a value of false sets the AI Off.
---@return SPAWN #The SPAWN object
function SPAWN:InitAIOnOff(AIOnOff) end

---Set spawns to happen at a particular airbase.
---Only for aircraft, of course.
---
------
---@param self SPAWN 
---@param AirbaseName string Name of the airbase.
---@param Takeoff number (Optional) Takeoff type. Can be SPAWN.Takeoff.Hot (default), SPAWN.Takeoff.Cold or SPAWN.Takeoff.Runway.
---@param TerminalType number (Optional) The terminal type.
---@return SPAWN #self
function SPAWN:InitAirbase(AirbaseName, Takeoff, TerminalType) end

---Makes the groups visible before start (like a battalion).
---The method will take the position of the group as the first position in the array.
---CAUTION: this directive will NOT work with OnSpawnGroup function.
---
------
---
---USAGE
---```
---
---  -- Define an array of Groups.
---  Spawn_BE_Ground = SPAWN:New( 'BE Ground' )
---                         :InitLimit( 2, 24 )
---                         :InitArray( 90, 10, 100, 50 )
---```
------
---@param self SPAWN 
---@param SpawnAngle number The angle in degrees how the groups and each unit of the group will be positioned.
---@param SpawnWidth number The amount of Groups that will be positioned on the X axis.
---@param SpawnDeltaX number The space between each Group on the X-axis.
---@param SpawnDeltaY number The space between each Group on the Y-axis.
---@return SPAWN #self
function SPAWN:InitArray(SpawnAngle, SpawnWidth, SpawnDeltaX, SpawnDeltaY) end

---[BLUE AIR only!] This method sets a specific callsign for a spawned group.
---Use for a group with one unit only!
---
------
---@param self SPAWN 
---@param ID number ID of the callsign enumerator, e.g. CALLSIGN.Tanker.Texaco - - resulting in e.g. Texaco-2-1
---@param Name string Name of this callsign as it cannot be determined from the ID because of the dependency on the task type of the plane, and the plane type. E.g. "Texaco"
---@param Minor number Minor number, i.e. the unit number within the group, e.g 2 - resulting in e.g. Texaco-2-1
---@param Major number Major number, i.e. the group number of this name, e.g. 1 - resulting in e.g. Texaco-2-1
---@return SPAWN #self
function SPAWN:InitCallSign(ID, Name, Minor, Major) end

---Sets category ID of the group.
---
------
---@param self SPAWN 
---@param Category number Category id.
---@return SPAWN #self
function SPAWN:InitCategory(Category) end

---Delete groups that have not moved for X seconds - AIR ONLY!!!
---DO NOT USE ON GROUPS THAT DO NOT MOVE OR YOUR SERVER WILL BURN IN HELL (Pikes - April 2020)
---When groups are still alive and have become inactive due to damage and are unable to contribute anything, then this group will be removed at defined intervals in seconds.
---
------
---
---USAGE
---```
---
---  Spawn_Helicopter:InitCleanUp( 20 )  -- CleanUp the spawning of the helicopters every 20 seconds when they become inactive.
---```
------
---@param self SPAWN 
---@param SpawnCleanUpInterval string The interval to check for inactive groups within seconds.
---@return SPAWN #self
function SPAWN:InitCleanUp(SpawnCleanUpInterval) end

---Sets the coalition of the spawned group.
---Note that it might be necessary to also set the country explicitly!
---
------
---@param self SPAWN 
---@param Coalition coalition.side Coalition of the group as number of enumerator:    * @{DCS#coalition.side.NEUTRAL}   * @{DCS#coalition.side.RED}   * @{DCS#coalition.side.BLUE}  
---@return SPAWN #self
function SPAWN:InitCoalition(Coalition) end

---Sets the country of the spawn group.
---Note that the country determines the coalition of the group depending on which country is defined to be on which side for each specific mission!
---
------
---@param self SPAWN 
---@param Country number Country id as number or enumerator:    * @{DCS#country.id.RUSSIA}   * @{DCS#country.id.USA} 
---@return SPAWN #self
function SPAWN:InitCountry(Country) end

---Turns the Delay Off for the Wrapper.Group when spawning.
---
------
---@param self SPAWN 
---@return SPAWN #The SPAWN object
function SPAWN:InitDelayOff() end

---Turns the Delay On for the Wrapper.Group when spawning with #SpawnScheduled().
---In effect then the 1st group will only be spawned
---after the number of seconds given in SpawnScheduled as arguments, and not immediately.
---
------
---@param self SPAWN 
---@return SPAWN #The SPAWN object
function SPAWN:InitDelayOn() end


---
------
---@param self NOTYPE 
---@param DelayOnOff NOTYPE 
function SPAWN:InitDelayOnOff(DelayOnOff) end

---Defines the heading of the overall formation of the new spawned group.
---The heading can be given as one fixed degree, or can be randomized between minimum and maximum degrees.
---The Group's formation as laid out in its template will be rotated around the first unit in the group
---Group individual units facings will rotate to match.  If InitHeading is also applied to this SPAWN then that will take precedence for individual unit facings.
---Note that InitGroupHeading does *not* rotate the groups route; only its initial facing!
---
------
---
---USAGE
---```
---
---mySpawner = SPAWN:New( ... )
---
---  -- Spawn the Group with the formation rotated +100 degrees around unit #1, compared to the mission template.
---  mySpawner:InitGroupHeading( 100 )
---
---  -- Spawn the Group with the formation rotated units between +100 and +150 degrees around unit #1, compared to the mission template, and with individual units varying by +/- 10 degrees from their templated facing.
---  mySpawner:InitGroupHeading( 100, 150, 10 )
---
---  -- Spawn the Group with the formation rotated -60 degrees around unit #1, compared to the mission template, but with all units facing due north regardless of how they were laid out in the template.
---  mySpawner:InitGroupHeading(-60):InitHeading(0)
---  -- or
---  mySpawner:InitHeading(0):InitGroupHeading(-60)
---```
------
---@param self SPAWN 
---@param HeadingMin number The minimum or fixed heading in degrees.
---@param HeadingMax number (optional) The maximum heading in degrees. This there is no maximum heading, then the heading for the group will be HeadingMin.
---@param unitVar number (optional) Individual units within the group will have their heading randomized by +/- unitVar degrees.  Default is zero.
---@return SPAWN #self
function SPAWN:InitGroupHeading(HeadingMin, HeadingMax, unitVar) end

---When spawning a new group, make the grouping of the units according the InitGrouping setting.
---
------
---@param self SPAWN 
---@param Grouping number Indicates the maximum amount of units in the group.
---@return SPAWN #
function SPAWN:InitGrouping(Grouping) end

---Defines the Heading for the new spawned units.
---The heading can be given as one fixed degree, or can be randomized between minimum and maximum degrees.
---
------
---
---USAGE
---```
---
---  Spawn = SPAWN:New( ... )
---
---  -- Spawn the units pointing to 100 degrees.
---  Spawn:InitHeading( 100 )
---
---  -- Spawn the units pointing between 100 and 150 degrees.
---  Spawn:InitHeading( 100, 150 )
---```
------
---@param self SPAWN 
---@param HeadingMin number The minimum or fixed heading in degrees.
---@param HeadingMax number (optional) The maximum heading in degrees. This there is no maximum heading, then the heading will be fixed for all units using minimum heading.
---@return SPAWN #self
function SPAWN:InitHeading(HeadingMin, HeadingMax) end

---Hide the group on MFDs (visible to game master slots!).
---
------
---@param self SPAWN 
---@return SPAWN #The SPAWN object
function SPAWN:InitHiddenOnMFD() end

---Hide the group on the map view (visible to game master slots!).
---
------
---@param self SPAWN 
---@param OnOff boolean Defaults to true
---@return SPAWN #The SPAWN object
function SPAWN:InitHiddenOnMap(OnOff) end

---Hide the group on planner (visible to game master slots!).
---
------
---@param self SPAWN 
---@return SPAWN #The SPAWN object
function SPAWN:InitHiddenOnPlanner() end

---Keeps the unit names as defined within the mission editor, 
---but note that anything after a # mark is ignored, 
---and any spaces before and after the resulting name are removed.
---IMPORTANT! This method MUST be the first used after :New !!!
---
------
---@param self SPAWN 
---@param KeepUnitNames boolean (optional) If true, the unit names are kept, false or not provided create new unit names.
---@return SPAWN #self
function SPAWN:InitKeepUnitNames(KeepUnitNames) end

---Flags that the spawned groups must be spawned late activated.
---
------
---@param self SPAWN 
---@param LateActivated boolean (optional) If true, the spawned groups are late activated.
---@return SPAWN #self
function SPAWN:InitLateActivated(LateActivated) end

---Stops any more repeat spawns from happening once the UNIT count of Alive units, spawned by the same SPAWN object, exceeds the first parameter.
---Also can stop spawns from happening once a total GROUP still alive is met.
---Exceptionally powerful when combined with SpawnSchedule for Respawning.
---Note that this method is exceptionally important to balance the performance of the mission. Depending on the machine etc, a mission can only process a maximum amount of units.
---If the time interval must be short, but there should not be more Units or Groups alive than a maximum amount of units, then this method should be used...
---When a #SPAWN.New is executed and the limit of the amount of units alive is reached, then no new spawn will happen of the group, until some of these units of the spawn object will be destroyed.
---
------
---
---USAGE
---```
---
---  -- NATO helicopters engaging in the battle field.
---  -- This helicopter group consists of one Unit. So, this group will SPAWN maximum 2 groups simultaneously within the DCSRTE.
---  -- There will be maximum 24 groups spawned during the whole mission lifetime. 
---  Spawn_BE_KA50 = SPAWN:New( 'BE KA-50@RAMP-Ground Defense' ):InitLimit( 2, 24 )
---```
------
---@param self SPAWN 
---@param SpawnMaxUnitsAlive number The maximum amount of units that can be alive at runtime.
---@param SpawnMaxGroups number The maximum amount of groups that can be spawned. When the limit is reached, then no more actual spawns will happen of the group. This parameter is useful to define a maximum amount of airplanes, ground troops, helicopters, ships etc within a supply area. This parameter accepts the value 0, which defines that there are no maximum group limits, but there are limits on the maximum of units that can be alive at the same time.
---@return SPAWN #self
function SPAWN:InitLimit(SpawnMaxUnitsAlive, SpawnMaxGroups) end

---Sets livery of the group.
---
------
---@param self SPAWN 
---@param Livery string Livery name. Note that this is not necessarily the same name as displayed in the mission editor.
---@return SPAWN #self
function SPAWN:InitLivery(Livery) end

---Sets the modex of the first unit of the group.
---If more units are in the group, the number is increased by one with every unit.
---
------
---@param self SPAWN 
---@param modex number Modex of the first unit.
---@param prefix string (optional) String to prefix to modex, e.g. for French AdA Modex, eg. -L-102 then "-L-" would be the prefix.
---@param postfix string (optional) String to postfix to modex, example tbd.
---@return SPAWN #self
function SPAWN:InitModex(modex, prefix, postfix) end

---This method sets a spawn position for the group that is different from the location of the template.
---
------
---@param self SPAWN 
---@param Coordinate COORDINATE The position to spawn from
---@return SPAWN #self
function SPAWN:InitPositionCoordinate(Coordinate) end

---This method sets a spawn position for the group that is different from the location of the template.
---
------
---@param self SPAWN 
---@param Vec2 Vec2 The position to spawn from
---@return SPAWN #self
function SPAWN:InitPositionVec2(Vec2) end

---Sets the radio communication on or off.
---Same as checking/unchecking the COMM box in the mission editor.
---
------
---@param self SPAWN 
---@param switch number If true (or nil), enables the radio communication. If false, disables the radio for the spawned group.
---@return SPAWN #self
function SPAWN:InitRadioCommsOnOff(switch) end

---Sets the radio frequency of the group.
---
------
---@param self SPAWN 
---@param frequency number The frequency in MHz.
---@return SPAWN #self
function SPAWN:InitRadioFrequency(frequency) end

---Set radio modulation.
---Default is AM.
---
------
---@param self SPAWN 
---@param modulation string Either "FM" or "AM". If no value is given, modulation is set to AM.
---@return SPAWN #self
function SPAWN:InitRadioModulation(modulation) end

---[AIR/Fighter only!] This method randomizes the callsign for a new group.
---
------
---@param self SPAWN 
---@return SPAWN #self
function SPAWN:InitRandomizeCallsign() end

---Randomizes the position of Wrapper.Groups that are spawned within a **radius band**, given an Outer and Inner radius, from the point that the spawn happens.
---
------
---@param self SPAWN 
---@param RandomizePosition boolean If true, SPAWN will perform the randomization of the @{Wrapper.Group}s position between a given outer and inner radius.
---@param OuterRadius Distance (optional) The outer radius in meters where the new group will be spawned.
---@param InnerRadius Distance (optional) The inner radius in meters where the new group will NOT be spawned.
---@return SPAWN #
function SPAWN:InitRandomizePosition(RandomizePosition, OuterRadius, InnerRadius) end

---Randomizes the defined route of the SpawnTemplatePrefix group in the ME.
---This is very useful to define extra variation of the behavior of groups.
---
------
---
---USAGE
---```
---
---  -- NATO helicopters engaging in the battle field.
---  -- The KA-50 has waypoints Start point ( =0 or SP ), 1, 2, 3, 4, End point (= 5 or DP).
---  -- Waypoints 2 and 3 will only be randomized. The others will remain on their original position with each new spawn of the helicopter.
---  -- The randomization of waypoint 2 and 3 will take place within a radius of 2000 meters.
---  Spawn_BE_KA50 = SPAWN:New( 'BE KA-50@RAMP-Ground Defense' ):InitRandomizeRoute( 2, 2, 2000 )
---```
------
---@param self SPAWN 
---@param SpawnStartPoint number is the waypoint where the randomization begins. Note that the StartPoint = 0 equaling the point where the group is spawned.
---@param SpawnEndPoint number is the waypoint where the randomization ends counting backwards. This parameter is useful to avoid randomization to end at a waypoint earlier than the last waypoint on the route.
---@param SpawnRadius number is the radius in meters in which the randomization of the new waypoints, with the original waypoint of the original template located in the middle ...
---@param SpawnHeight number (optional) Specifies the **additional** height in meters that can be added to the base height specified at each waypoint in the ME.
---@return SPAWN #
function SPAWN:InitRandomizeRoute(SpawnStartPoint, SpawnEndPoint, SpawnRadius, SpawnHeight) end

---This method is rather complicated to understand.
---But I'll try to explain.
---This method becomes useful when you need to spawn groups with random templates of groups defined within the mission editor,
---but they will all follow the same Template route and have the same prefix name.
---In other words, this method randomizes between a defined set of groups the template to be used for each new spawn of a group.
---
------
---
---USAGE
---```
---
---  -- NATO Tank Platoons invading Gori.
---  -- Choose between 13 different 'US Tank Platoon' configurations for each new SPAWN the Group to be spawned for the
---  -- 'US Tank Platoon Left', 'US Tank Platoon Middle' and 'US Tank Platoon Right' SpawnTemplatePrefixes.
---  -- Each new SPAWN will randomize the route, with a defined time interval of 200 seconds with 40% time variation (randomization) and
---  -- with a limit set of maximum 12 Units alive simultaneously  and 150 Groups to be spawned during the whole mission.
---  Spawn_US_Platoon = { 'US Tank Platoon 1', 'US Tank Platoon 2', 'US Tank Platoon 3', 'US Tank Platoon 4', 'US Tank Platoon 5',
---                       'US Tank Platoon 6', 'US Tank Platoon 7', 'US Tank Platoon 8', 'US Tank Platoon 9', 'US Tank Platoon 10',
---                       'US Tank Platoon 11', 'US Tank Platoon 12', 'US Tank Platoon 13' }
---  Spawn_US_Platoon_Left = SPAWN:New( 'US Tank Platoon Left' ):InitLimit( 12, 150 ):SpawnScheduled( 200, 0.4 ):InitRandomizeTemplate( Spawn_US_Platoon ):InitRandomizeRoute( 3, 3, 2000 )
---  Spawn_US_Platoon_Middle = SPAWN:New( 'US Tank Platoon Middle' ):InitLimit( 12, 150 ):SpawnScheduled( 200, 0.4 ):InitRandomizeTemplate( Spawn_US_Platoon ):InitRandomizeRoute( 3, 3, 2000 )
---  Spawn_US_Platoon_Right = SPAWN:New( 'US Tank Platoon Right' ):InitLimit( 12, 150 ):SpawnScheduled( 200, 0.4 ):InitRandomizeTemplate( Spawn_US_Platoon ):InitRandomizeRoute( 3, 3, 2000 )
---```
------
---@param self SPAWN 
---@param SpawnTemplatePrefixTable list A table with the names of the groups defined within the mission editor, from which one will be chosen when a new group will be spawned.
---@return SPAWN #
function SPAWN:InitRandomizeTemplate(SpawnTemplatePrefixTable) end

---Randomize templates to be used as the unit representatives for the Spawned group, defined by specifying the prefix names.
---This method becomes useful when you need to spawn groups with random templates of groups defined within the mission editor,
---but they will all follow the same Template route and have the same prefix name.
---In other words, this method randomizes between a defined set of groups the template to be used for each new spawn of a group.
---
------
---
---USAGE
---```
---
--- -- NATO Tank Platoons invading Gori.
---
---  -- Choose between different 'US Tank Platoon Templates' configurations to be spawned for the
---  -- 'US Tank Platoon Left', 'US Tank Platoon Middle' and 'US Tank Platoon Right' SPAWN objects.
---
---  -- Each new SPAWN will randomize the route, with a defined time interval of 200 seconds with 40% time variation (randomization) and
---  -- with a limit set of maximum 12 Units alive simultaneously  and 150 Groups to be spawned during the whole mission.
---
---  Spawn_US_Platoon_Left = SPAWN:New( 'US Tank Platoon Left' ):InitLimit( 12, 150 ):SpawnScheduled( 200, 0.4 ):InitRandomizeTemplatePrefixes( "US Tank Platoon Templates" ):InitRandomizeRoute( 3, 3, 2000 )
---  Spawn_US_Platoon_Middle = SPAWN:New( 'US Tank Platoon Middle' ):InitLimit( 12, 150 ):SpawnScheduled( 200, 0.4 ):InitRandomizeTemplatePrefixes( "US Tank Platoon Templates" ):InitRandomizeRoute( 3, 3, 2000 )
---  Spawn_US_Platoon_Right = SPAWN:New( 'US Tank Platoon Right' ):InitLimit( 12, 150 ):SpawnScheduled( 200, 0.4 ):InitRandomizeTemplatePrefixes( "US Tank Platoon Templates" ):InitRandomizeRoute( 3, 3, 2000 )
---```
------
---@param self SPAWN 
---@param SpawnTemplatePrefixes string A string or a list of string that contains the prefixes of the groups that are possible unit representatives of the group to be spawned.
---@param RandomizePositionInZone boolean If nil or true, also the position inside the selected random zone will be randomized. Set to false to use the center of the zone. 
---@return SPAWN #
function SPAWN:InitRandomizeTemplatePrefixes(SpawnTemplatePrefixes, RandomizePositionInZone) end

---Randomize templates to be used as the unit representatives for the Spawned group, defined using a SET_GROUP object.
---This method becomes useful when you need to spawn groups with random templates of groups defined within the mission editor,
---but they will all follow the same Template route and have the same prefix name.
---In other words, this method randomizes between a defined set of groups the template to be used for each new spawn of a group.
---
------
---
---USAGE
---```
---
---  -- NATO Tank Platoons invading Gori.
---
---  -- Choose between different 'US Tank Platoon Template' configurations to be spawned for the
---  -- 'US Tank Platoon Left', 'US Tank Platoon Middle' and 'US Tank Platoon Right' SPAWN objects.
---
---  -- Each new SPAWN will randomize the route, with a defined time interval of 200 seconds with 40% time variation (randomization) and
---  -- with a limit set of maximum 12 Units alive simultaneously  and 150 Groups to be spawned during the whole mission.
---
---  Spawn_US_PlatoonSet = SET_GROUP:New():FilterPrefixes( "US Tank Platoon Templates" ):FilterOnce()
---
---  -- Now use the Spawn_US_PlatoonSet to define the templates using InitRandomizeTemplateSet.
---  Spawn_US_Platoon_Left = SPAWN:New( 'US Tank Platoon Left' ):InitLimit( 12, 150 ):SpawnScheduled( 200, 0.4 ):InitRandomizeTemplateSet( Spawn_US_PlatoonSet ):InitRandomizeRoute( 3, 3, 2000 )
---  Spawn_US_Platoon_Middle = SPAWN:New( 'US Tank Platoon Middle' ):InitLimit( 12, 150 ):SpawnScheduled( 200, 0.4 ):InitRandomizeTemplateSet( Spawn_US_PlatoonSet ):InitRandomizeRoute( 3, 3, 2000 )
---  Spawn_US_Platoon_Right = SPAWN:New( 'US Tank Platoon Right' ):InitLimit( 12, 150 ):SpawnScheduled( 200, 0.4 ):InitRandomizeTemplateSet( Spawn_US_PlatoonSet ):InitRandomizeRoute( 3, 3, 2000 )
---```
------
---@param self SPAWN 
---@param SpawnTemplateSet SET_GROUP A SET_GROUP object set, that contains the groups that are possible unit representatives of the group to be spawned.
---@param RandomizePositionInZone boolean If nil or true, also the position inside the selected random zone will be randomized. Set to false to use the center of the zone.
---@return SPAWN #
function SPAWN:InitRandomizeTemplateSet(SpawnTemplateSet, RandomizePositionInZone) end

---Randomizes the UNITs that are spawned within a radius band given an Outer and Inner radius.
---
------
---
---USAGE
---```
---
---  -- NATO helicopters engaging in the battle field.
---  -- UNIT positions of this group will be randomized around the base unit #1 in a circle of 50 to 500 meters.
---  Spawn_BE_KA50 = SPAWN:New( 'BE KA-50@RAMP-Ground Defense' ):InitRandomizeUnits( true, 500, 50 )
---```
------
---@param self SPAWN 
---@param RandomizeUnits boolean If true, SPAWN will perform the randomization of the @{Wrapper.Unit#UNIT}s position within the group between a given outer and inner radius.
---@param OuterRadius Distance (optional) The outer radius in meters where the new group will be spawned.
---@param InnerRadius Distance (optional) The inner radius in meters where the new group will NOT be spawned.
---@return SPAWN #
function SPAWN:InitRandomizeUnits(RandomizeUnits, OuterRadius, InnerRadius) end

---This method provides the functionality to randomize the spawning of the Groups at a given list of zones of different types.
---
------
---
---USAGE
---```
---
---   -- Create a zone table of the 2 zones.
---   ZoneTable = { ZONE:New( "Zone1" ), ZONE:New( "Zone2" ) }
---
---   Spawn_Vehicle_1 = SPAWN:New( "Spawn Vehicle 1" )
---                          :InitLimit( 10, 10 )
---                          :InitRandomizeRoute( 1, 1, 200 )
---                          :InitRandomizeZones( ZoneTable )
---                          :SpawnScheduled( 5, .5 )
---```
------
---@param self SPAWN 
---@param SpawnZoneTable table A table with @{Core.Zone} objects. If this table is given, then each spawn will be executed within the given list of @{Core.Zone}s objects.
---@param RandomizePositionInZone boolean If nil or true, also the position inside the selected random zone will be randomized. Set to false to use the center of the zone.
---@return SPAWN #self
function SPAWN:InitRandomizeZones(SpawnZoneTable, RandomizePositionInZone) end

---For planes and helicopters, when these groups go home and land on their home airbases and FARPs, they normally would taxi to the parking spot, shut-down their engines and wait forever until the Group is removed by the runtime environment.
---This method is used to re-spawn automatically (so no extra call is needed anymore) the same group after it has landed.
---This will enable a spawned group to be re-spawned after it lands, until it is destroyed...
---Note: When the group is respawned, it will re-spawn from the original airbase where it took off.
---So ensure that the routes for groups that respawn, always return to the original airbase, or players may get confused ...
---
------
---
---USAGE
---```
---
---  -- RU Su-34 - AI Ship Attack
---  -- Re-SPAWN the Group(s) after each landing and Engine Shut-Down automatically.
---  SpawnRU_SU34 = SPAWN:New( 'Su-34' )
---                      :Schedule( 2, 3, 1800, 0.4 )
---                      :SpawnUncontrolled()
---                      :InitRandomizeRoute( 1, 1, 3000 )
---                      :InitRepeatOnEngineShutDown()
---```
------
---@param self SPAWN 
---@return SPAWN #self
function SPAWN:InitRepeat() end

---Respawn after landing when its engines have shut down.
---
------
---
---USAGE
---```
---
---  -- RU Su-34 - AI Ship Attack
---  -- Re-SPAWN the Group(s) after each landing and Engine Shut-Down automatically.
---  SpawnRU_SU34 = SPAWN:New( 'Su-34' )
---                      :SpawnUncontrolled()
---                      :InitRandomizeRoute( 1, 1, 3000 )
---                      :InitRepeatOnEngineShutDown()
---                      :Spawn()
---```
------
---@param self SPAWN 
---@return SPAWN #self
function SPAWN:InitRepeatOnEngineShutDown() end

---Respawn group after landing.
---
------
---
---USAGE
---```
---
---  -- RU Su-34 - AI Ship Attack
---  -- Re-SPAWN the Group(s) after each landing and Engine Shut-Down automatically.
---  SpawnRU_SU34 = SPAWN:New( 'Su-34' )
---                      :InitRandomizeRoute( 1, 1, 3000 )
---                      :InitRepeatOnLanding(20)
---                      :Spawn()
---```
------
---@param self SPAWN 
---@param WaitingTime number Wait this many seconds before despawning the alive group after landing. Defaults to 3 .
---@return SPAWN #self
function SPAWN:InitRepeatOnLanding(WaitingTime) end

---[Airplane - A10-C II only] Set the SADL TN starting number of the Group; each unit of the spawned group will have a consecutive SADL set.
---
------
---@param self SPAWN 
---@param Octal number The octal number (digits 1..7, max 4 digits, i.e. 1..7777) to set the SADL to. Every SADL needs to be unique!
---@return SPAWN #self
function SPAWN:InitSADL(Octal) end

---[Airplane - F15/16/18/AWACS/B1B/Tanker only] Set the STN Link16 starting number of the Group; each unit of the spawned group will have a consecutive STN set.
---
------
---@param self SPAWN 
---@param Octal number The octal number (digits 1..7, max 5 digits, i.e. 1..77777) to set the STN to. Every STN needs to be unique!
---@return SPAWN #self
function SPAWN:InitSTN(Octal) end

---Spawn the UNITs of this group with individual absolute positions and individual headings.
---
------
---
---USAGE
---```
---
---  -- NATO helicopter group of three units engaging in the battle field.
---  local Positions = { [1] = {x = 0, y = 0, heading = 0}, [2] = {x = 50, y = 50, heading = 90}, [3] = {x = -50, y = 50, heading = 180} }
---  Spawn_BE_KA50 = SPAWN:New( 'BE KA-50@RAMP-Ground Defense' ):InitSetUnitAbsolutePositions(Positions)
---```
------
---@param self SPAWN 
---@param Positions table Table of positions, needs to one entry per unit in the group(!). The table contains one table each for each unit, with x,y, and optionally z  absolute positions, and optionally an individual heading.
---@return SPAWN #
function SPAWN:InitSetUnitAbsolutePositions(Positions) end

---Spawn the UNITs of this group with individual relative positions to unit #1 and individual headings.
---
------
---
---USAGE
---```
---
---  -- NATO helicopter group of three units engaging in the battle field.
---  local Positions = { [1] = {x = 0, y = 0, heading = 0}, [2] = {x = 50, y = 50, heading = 90}, [3] = {x = -50, y = 50, heading = 180} }
---  Spawn_BE_KA50 = SPAWN:New( 'BE KA-50@RAMP-Ground Defense' ):InitSetUnitRelativePositions(Positions)
---```
------
---@param self SPAWN 
---@param Positions table Table of positions, needs to one entry per unit in the group(!). The table contains one table each for each unit, with x,y, and optionally z  relative positions, and optionally an individual heading.
---@return SPAWN #
function SPAWN:InitSetUnitRelativePositions(Positions) end

---Sets skill of the group.
---
------
---@param self SPAWN 
---@param Skill string Skill, possible values "Average", "Good", "High", "Excellent" or "Random".
---@return SPAWN #self
function SPAWN:InitSkill(Skill) end

---[Airplane] Set the initial speed on spawning in knots.
---Useful when spawning in-air only.
---
------
---@param self SPAWN 
---@param Knots number The speed in knots to use.
---@return SPAWN #self
function SPAWN:InitSpeedKnots(Knots) end

---[Airplane] Set the initial speed on spawning in kilometers per hour.
---Useful when spawning in-air only.
---
------
---@param self SPAWN 
---@param KPH number The speed in KPH to use.
---@return SPAWN #self
function SPAWN:InitSpeedKph(KPH) end

---[Airplane] Set the initial speed on spawning in meters per second.
---Useful when spawning in-air only.
---
------
---@param self SPAWN 
---@param MPS number The speed in MPS to use.
---@return SPAWN #self
function SPAWN:InitSpeedMps(MPS) end

---(**AIR**) Will spawn a plane group in UnControlled or Controlled mode...
---This will be similar to the uncontrolled flag setting in the ME.
---You can use UnControlled mode to simulate planes startup and ready for take-off but aren't moving (yet).
---ReSpawn the plane in Controlled mode, and the plane will move...
---
------
---@param self SPAWN 
---@param UnControlled boolean true if UnControlled, false if Controlled.
---@return SPAWN #self
function SPAWN:InitUnControlled(UnControlled) end

---Creates the main object to spawn a Wrapper.Group defined in the DCS ME.
---
------
---
---USAGE
---```
----- NATO helicopters engaging in the battle field.
---Spawn_BE_KA50 = SPAWN:New( 'BE KA-50@RAMP-Ground Defense' )
---```
------
---@param self SPAWN 
---@param SpawnTemplatePrefix string is the name of the Group in the ME that defines the Template.  Each new group will have the name starting with SpawnTemplatePrefix.
---@return SPAWN #
function SPAWN:New(SpawnTemplatePrefix) end

---Creates a new SPAWN instance to create new groups based on the provided template.
---This will also register the template for future use.
---
------
---
---USAGE
---```
----- Spawn a P51 Mustang from scratch
---local ttemp =  
---  {
---      ["modulation"] = 0,
---      ["tasks"] = 
---      {
---      }, -- end of ["tasks"]
---      ["task"] = "Reconnaissance",
---      ["uncontrolled"] = false,
---      ["route"] = 
---      {
---          ["points"] = 
---          {
---              [1] = 
---              {
---                  ["alt"] = 2000,
---                  ["action"] = "Turning Point",
---                  ["alt_type"] = "BARO",
---                  ["speed"] = 125,
---                  ["task"] = 
---                  {
---                      ["id"] = "ComboTask",
---                      ["params"] = 
---                      {
---                          ["tasks"] = 
---                          {
---                          }, -- end of ["tasks"]
---                      }, -- end of ["params"]
---                  }, -- end of ["task"]
---                  ["type"] = "Turning Point",
---                  ["ETA"] = 0,
---                  ["ETA_locked"] = true,
---                  ["y"] = 666285.71428571,
---                  ["x"] = -312000,
---                  ["formation_template"] = "",
---                  ["speed_locked"] = true,
---              }, -- end of [1]
---          }, -- end of ["points"]
---      }, -- end of ["route"]
---      ["groupId"] = 1,
---      ["hidden"] = false,
---      ["units"] = 
---      {
---          [1] = 
---          {
---              ["alt"] = 2000,
---              ["alt_type"] = "BARO",
---              ["livery_id"] = "USAF 364th FS",
---              ["skill"] = "High",
---              ["speed"] = 125,
---              ["type"] = "TF-51D",
---              ["unitId"] = 1,
---              ["psi"] = 0,
---              ["y"] = 666285.71428571,
---              ["x"] = -312000,
---              ["name"] = "P51-1-1",
---              ["payload"] = 
---              {
---                  ["pylons"] = 
---                  {
---                  }, -- end of ["pylons"]
---                  ["fuel"] = 340.68,
---                  ["flare"] = 0,
---                  ["chaff"] = 0,
---                  ["gun"] = 100,
---              }, -- end of ["payload"]
---              ["heading"] = 0,
---              ["callsign"] = 
---              {
---                  [1] = 1,
---                  [2] = 1,
---                  ["name"] = "Enfield11",
---                  [3] = 1,
---              }, -- end of ["callsign"]
---              ["onboard_num"] = "010",
---          }, -- end of [1]
---      }, -- end of ["units"]
---      ["y"] = 666285.71428571,
---      ["x"] = -312000,
---      ["name"] = "P51",
---      ["communication"] = true,
---      ["start_time"] = 0,
---      ["frequency"] = 124,
---  } 
---
---
---local mustang = SPAWN:NewFromTemplate(ttemp,"P51D")
----- you MUST set the next three:
---mustang:InitCountry(country.id.FRANCE)
---mustang:InitCategory(Group.Category.AIRPLANE)
---mustang:InitCoalition(coalition.side.BLUE)
---mustang:OnSpawnGroup(
---  function(grp)
---    MESSAGE:New("Group Spawned: "..grp:GetName(),15,"SPAWN"):ToAll()
---  end
---)
---mustang:Spawn()
---```
------
---@param self SPAWN 
---@param SpawnTemplate table is the Template of the Group. This must be a valid Group Template structure - see [Hoggit Wiki](https://wiki.hoggitworld.com/view/DCS_func_addGroup)!
---@param SpawnTemplatePrefix string [Mandatory] is the name of the template and the prefix of the GROUP on spawn. The name in the template **will** be overwritten!
---@param SpawnAliasPrefix string [Optional] is the prefix that will be given to the GROUP on spawn.
---@param NoMooseNamingPostfix boolean [Optional] If true, skip the Moose naming additions (like groupname#001-01) - **but** you need to ensure yourself no duplicate group names exist!
---@return SPAWN #self
function SPAWN:NewFromTemplate(SpawnTemplate, SpawnTemplatePrefix, SpawnAliasPrefix, NoMooseNamingPostfix) end

---Creates a new SPAWN instance to create new groups based on the defined template and using a new alias for each new group.
---
------
---
---USAGE
---```
----- NATO helicopters engaging in the battle field.
---Spawn_BE_KA50 = SPAWN:NewWithAlias( 'BE KA-50@RAMP-Ground Defense', 'Helicopter Attacking a City' )
---```
------
---@param self SPAWN 
---@param SpawnTemplatePrefix string is the name of the Group in the ME that defines the Template.
---@param SpawnAliasPrefix string is the name that will be given to the Group at runtime.
---@return SPAWN #self
function SPAWN:NewWithAlias(SpawnTemplatePrefix, SpawnAliasPrefix) end

---Allows to place a CallFunction hook when a new group spawns.
---The provided method will be called when a new group is spawned, including its given parameters.
---The first parameter of the SpawnFunction is the Wrapper.Group#GROUP that was spawned.
---
------
---
---USAGE
---```
---
---   -- Declare SpawnObject and call a function when a new Group is spawned.
---   local SpawnObject = SPAWN:New( "SpawnObject" )
---                            :InitLimit( 2, 10 )
---                            :OnSpawnGroup( function( SpawnGroup )
---                                SpawnGroup:E( "I am spawned" )
---                                end
---                              )
---                            :SpawnScheduled( 300, 0.3 )
---```
------
---@param self SPAWN 
---@param SpawnCallBackFunction function The function to be called when a group spawns.
---@param SpawnFunctionArguments NOTYPE A random amount of arguments to be provided to the function when the group spawns.
---@param ... NOTYPE 
---@return SPAWN #
function SPAWN:OnSpawnGroup(SpawnCallBackFunction, SpawnFunctionArguments, ...) end

---Will park a group at an Wrapper.Airbase.
---
------
---@param self SPAWN 
---@param SpawnAirbase AIRBASE The @{Wrapper.Airbase} where to spawn the group.
---@param TerminalType AIRBASE.TerminalType (optional) The terminal type the aircraft should be spawned at. See @{Wrapper.Airbase#AIRBASE.TerminalType}.
---@param Parkingdata table (optional) Table holding the coordinates and terminal ids for all units of the group. Spawning will be forced to happen at exactily these spots!
---@param SpawnIndex NOTYPE 
---@return nil #Nothing is returned!
function SPAWN:ParkAircraft(SpawnAirbase, TerminalType, Parkingdata, SpawnIndex) end

---Will park a group at an Wrapper.Airbase.
---This method is mostly advisable to be used if you want to simulate parking units at an airbase and be visible.
---Note that each point in the route assigned to the spawning group is reset to the point of the spawn.
---
---All groups that are in the spawn collection and that are alive, and not in the air, are parked.
---
---The Wrapper.Airbase#AIRBASE object must refer to a valid airbase known in the sim.
---You can use the following enumerations to search for the pre-defined airbases on the current known maps of DCS:
---
---  * Wrapper.Airbase#AIRBASE.Caucasus: The airbases on the Caucasus map.
---  * Wrapper.Airbase#AIRBASE.Nevada: The airbases on the Nevada (NTTR) map.
---  * Wrapper.Airbase#AIRBASE.Normandy: The airbases on the Normandy map.
---
---Use the method Wrapper.Airbase#AIRBASE.FindByName() to retrieve the airbase object.
---The known AIRBASE objects are automatically imported at mission start by MOOSE.
---Therefore, there isn't any New() constructor defined for AIRBASE objects.
---
---Ships and FARPs are added within the mission, and are therefore not known.
---For these AIRBASE objects, there isn't an Wrapper.Airbase#AIRBASE enumeration defined.
---You need to provide the **exact name** of the airbase as the parameter to the Wrapper.Airbase#AIRBASE.FindByName() method!
---
------
---
---USAGE
---```
---  Spawn_Plane = SPAWN:New( "Plane" )
---  Spawn_Plane:ParkAtAirbase( AIRBASE:FindByName( AIRBASE.Caucasus.Krymsk ) )
---
---  Spawn_Heli = SPAWN:New( "Heli")
---
---  Spawn_Heli:ParkAtAirbase( AIRBASE:FindByName( "FARP Cold" ) )
---
---  Spawn_Heli:ParkAtAirbase( AIRBASE:FindByName( "Carrier" ) )
---
---  Spawn_Plane:ParkAtAirbase( AIRBASE:FindByName( AIRBASE.Caucasus.Krymsk ), AIRBASE.TerminalType.OpenBig )
---```
------
---@param self SPAWN 
---@param SpawnAirbase AIRBASE The @{Wrapper.Airbase} where to spawn the group.
---@param TerminalType AIRBASE.TerminalType (optional) The terminal type the aircraft should be spawned at. See @{Wrapper.Airbase#AIRBASE.TerminalType}.
---@param Parkingdata table (optional) Table holding the coordinates and terminal ids for all units of the group. Spawning will be forced to happen at exactily these spots!
---@return nil #Nothing is returned!
function SPAWN:ParkAtAirbase(SpawnAirbase, TerminalType, Parkingdata) end

---Will re-spawn a group based on a given index.
---Note: This method uses the global _DATABASE object (an instance of Core.Database#DATABASE), which contains ALL initial and new spawned objects in MOOSE.
---
------
---@param self SPAWN 
---@param SpawnIndex string The index of the group to be spawned.
---@return GROUP #The group that was spawned. You can use this group for further actions.
function SPAWN:ReSpawn(SpawnIndex) end

---Set the spawn index to a specified index number.
---This method can be used to "reset" the spawn counter to a specific index number.
---This will actually enable a respawn of groups from the specific index.
---
------
---@param self SPAWN 
---@param SpawnIndex string The index of the group from where the spawning will start again. The default value would be 0, which means a complete reset of the spawnindex.
---@return SPAWN #self
function SPAWN:SetSpawnIndex(SpawnIndex) end

---Will spawn a group based on the internal index.
---Note: This method uses the global _DATABASE object (an instance of Core.Database#DATABASE), which contains ALL initial and new spawned objects in MOOSE.
---
------
---@param self SPAWN 
---@return GROUP #The group that was spawned. You can use this group for further actions.
function SPAWN:Spawn() end

---Will spawn a group at an Wrapper.Airbase.
---This method is mostly advisable to be used if you want to simulate spawning units at an airbase.
---Note that each point in the route assigned to the spawning group is reset to the point of the spawn.
---You can use the returned group to further define the route to be followed.
---
---The Wrapper.Airbase#AIRBASE object must refer to a valid airbase known in the sim.
---You can use the following enumerations to search for the pre-defined airbases on the current known maps of DCS:
---
---  * Wrapper.Airbase#AIRBASE.Caucasus: The airbases on the Caucasus map.
---  * Wrapper.Airbase#AIRBASE.Nevada: The airbases on the Nevada (NTTR) map.
---  * Wrapper.Airbase#AIRBASE.Normandy: The airbases on the Normandy map.
---
---Use the method Wrapper.Airbase#AIRBASE.FindByName() to retrieve the airbase object.
---The known AIRBASE objects are automatically imported at mission start by MOOSE.
---Therefore, there isn't any New() constructor defined for AIRBASE objects.
---
---Ships and FARPs are added within the mission, and are therefore not known.
---For these AIRBASE objects, there isn't an Wrapper.Airbase#AIRBASE enumeration defined.
---You need to provide the **exact name** of the airbase as the parameter to the Wrapper.Airbase#AIRBASE.FindByName() method!
---
------
---
---USAGE
---```
---
---  Spawn_Plane = SPAWN:New( "Plane" )
---  Spawn_Plane:SpawnAtAirbase( AIRBASE:FindByName( AIRBASE.Caucasus.Krymsk ), SPAWN.Takeoff.Cold )
---  Spawn_Plane:SpawnAtAirbase( AIRBASE:FindByName( AIRBASE.Caucasus.Krymsk ), SPAWN.Takeoff.Hot )
---  Spawn_Plane:SpawnAtAirbase( AIRBASE:FindByName( AIRBASE.Caucasus.Krymsk ), SPAWN.Takeoff.Runway )
---
---  Spawn_Plane:SpawnAtAirbase( AIRBASE:FindByName( "Carrier" ), SPAWN.Takeoff.Cold )
---
---  Spawn_Heli = SPAWN:New( "Heli")
---
---  Spawn_Heli:SpawnAtAirbase( AIRBASE:FindByName( "FARP Cold" ), SPAWN.Takeoff.Cold )
---  Spawn_Heli:SpawnAtAirbase( AIRBASE:FindByName( "FARP Hot" ), SPAWN.Takeoff.Hot )
---  Spawn_Heli:SpawnAtAirbase( AIRBASE:FindByName( "FARP Runway" ), SPAWN.Takeoff.Runway )
---  Spawn_Heli:SpawnAtAirbase( AIRBASE:FindByName( "FARP Air" ), SPAWN.Takeoff.Air )
---
---  Spawn_Heli:SpawnAtAirbase( AIRBASE:FindByName( "Carrier" ), SPAWN.Takeoff.Cold )
---
---  Spawn_Plane:SpawnAtAirbase( AIRBASE:FindByName( AIRBASE.Caucasus.Krymsk ), SPAWN.Takeoff.Cold, nil, AIRBASE.TerminalType.OpenBig )
---```
------
---@param self SPAWN 
---@param SpawnAirbase AIRBASE The @{Wrapper.Airbase} where to spawn the group.
---@param Takeoff SPAWN.Takeoff (optional) The location and takeoff method. Default is Hot.
---@param TakeoffAltitude number (optional) The altitude above the ground.
---@param TerminalType AIRBASE.TerminalType (optional) The terminal type the aircraft should be spawned at. See @{Wrapper.Airbase#AIRBASE.TerminalType}.
---@param EmergencyAirSpawn boolean (optional) If true (default), groups are spawned in air if there is no parking spot at the airbase. If false, nothing is spawned if no parking spot is available.
---@param Parkingdata table (optional) Table holding the coordinates and terminal ids for all units of the group. Spawning will be forced to happen at exactly these spots!
---@return GROUP #The group that was spawned or nil when nothing was spawned.
function SPAWN:SpawnAtAirbase(SpawnAirbase, Takeoff, TakeoffAltitude, TerminalType, EmergencyAirSpawn, Parkingdata) end

---Spawn a group on an Wrapper.Airbase at a specific parking spot.
---
------
---@param self SPAWN 
---@param Airbase AIRBASE The @{Wrapper.Airbase} where to spawn the group.
---@param Spots table Table of parking spot IDs. Note that these in general are different from the numbering in the mission editor!
---@param Takeoff SPAWN.Takeoff (Optional) Takeoff type, i.e. either SPAWN.Takeoff.Cold or SPAWN.Takeoff.Hot. Default is Hot.
---@return GROUP #The group that was spawned or nil when nothing was spawned.
function SPAWN:SpawnAtParkingSpot(Airbase, Spots, Takeoff) end

---Will spawn a group from a Coordinate in 3D space.
---This method is mostly advisable to be used if you want to simulate spawning units in the air, like helicopters or airplanes.
---Note that each point in the route assigned to the spawning group is reset to the point of the spawn.
---You can use the returned group to further define the route to be followed.
---
------
---@param self SPAWN 
---@param Coordinate Coordinate The Coordinate coordinates where to spawn the group.
---@param SpawnIndex number (optional) The index which group to spawn within the given zone.
---@return GROUP #that was spawned or #nil if nothing was spawned.
function SPAWN:SpawnFromCoordinate(Coordinate, SpawnIndex) end

---Will spawn a group from a COORDINATE in 3D space.
---This method is mostly advisable to be used if you want to simulate spawning groups on the ground from air units, like vehicles.
---Note that each point in the route assigned to the spawning group is reset to the point of the spawn.
---You can use the returned group to further define the route to be followed.
---
------
---
---USAGE
---```
---
---  local SpawnPointVec2 = ZONE:New( ZoneName ):GetPointVec2() 
---
---  -- Spawn at the zone center position at the height specified in the ME of the group template!
---  SpawnAirplanes:SpawnFromPointVec2( SpawnPointVec2 )
---
---  -- Spawn from the static position at the height randomized between 2000 and 4000 meters.
---  SpawnAirplanes:SpawnFromPointVec2( SpawnPointVec2, 2000, 4000 )
---```
------
---@param self SPAWN 
---@param PointVec2 COORDINATE The coordinates where to spawn the group.
---@param MinHeight number (optional) The minimum height to spawn an airborne group into the zone.
---@param MaxHeight number (optional) The maximum height to spawn an airborne group into the zone.
---@param SpawnIndex number (optional) The index which group to spawn within the given zone.
---@return GROUP #that was spawned or #nil if nothing was spawned.
function SPAWN:SpawnFromPointVec2(PointVec2, MinHeight, MaxHeight, SpawnIndex) end

---Will spawn a group from a PointVec3 in 3D space.
---This method is mostly advisable to be used if you want to simulate spawning units in the air, like helicopters or airplanes.
---Note that each point in the route assigned to the spawning group is reset to the point of the spawn.
---You can use the returned group to further define the route to be followed.
---
------
---
---USAGE
---```
---
---  local SpawnPointVec3 = ZONE:New( ZoneName ):GetPointVec3( 2000 ) -- Get the center of the ZONE object at 2000 meters from the ground.
---
---  -- Spawn at the zone center position at 2000 meters from the ground!
---  SpawnAirplanes:SpawnFromPointVec3( SpawnPointVec3 )
---```
------
---@param self SPAWN 
---@param PointVec3 COORDINATE The COORDINATE coordinates where to spawn the group.
---@param SpawnIndex number (optional) The index which group to spawn within the given zone.
---@return GROUP #that was spawned or #nil if nothing was spawned.
function SPAWN:SpawnFromPointVec3(PointVec3, SpawnIndex) end

---Will spawn a group from a hosting static.
---This method is mostly advisable to be used if you want to simulate spawning from buldings and structures (static buildings).
---You can use the returned group to further define the route to be followed.
---
------
---
---USAGE
---```
---
---  local SpawnStatic = STATIC:FindByName( StaticName )
---
---  -- Spawn from the static position at the height specified in the ME of the group template!
---  SpawnAirplanes:SpawnFromStatic( SpawnStatic )
---
---  -- Spawn from the static position at the height randomized between 2000 and 4000 meters.
---  SpawnAirplanes:SpawnFromStatic( SpawnStatic, 2000, 4000 )
---```
------
---@param self SPAWN 
---@param HostStatic STATIC The static dropping or unloading the group.
---@param MinHeight number (optional) The minimum height to spawn an airborne group into the zone.
---@param MaxHeight number (optional) The maximum height to spawn an airborne group into the zone.
---@param SpawnIndex number (optional) The index which group to spawn within the given zone.
---@return GROUP #that was spawned or #nil if nothing was spawned.
function SPAWN:SpawnFromStatic(HostStatic, MinHeight, MaxHeight, SpawnIndex) end

---Will spawn a group from a hosting unit.
---This method is mostly advisable to be used if you want to simulate spawning from air units, like helicopters, which are dropping infantry into a defined Landing Zone.
---Note that each point in the route assigned to the spawning group is reset to the point of the spawn.
---You can use the returned group to further define the route to be followed.
---
------
---
---USAGE
---```
---
---  local SpawnStatic = STATIC:FindByName( StaticName )
---
---  -- Spawn from the static position at the height specified in the ME of the group template!
---  SpawnAirplanes:SpawnFromUnit( SpawnStatic )
---
---  -- Spawn from the static position at the height randomized between 2000 and 4000 meters.
---  SpawnAirplanes:SpawnFromUnit( SpawnStatic, 2000, 4000 )
---```
------
---@param self SPAWN 
---@param HostUnit UNIT The air or ground unit dropping or unloading the group.
---@param MinHeight number (optional) The minimum height to spawn an airborne group into the zone.
---@param MaxHeight number (optional) The maximum height to spawn an airborne group into the zone.
---@param SpawnIndex number (optional) The index which group to spawn within the given zone.
---@return GROUP #that was spawned.
---@return nil #Nothing was spawned.
function SPAWN:SpawnFromUnit(HostUnit, MinHeight, MaxHeight, SpawnIndex) end

---Will spawn a group from a Vec2 in 3D space.
---This method is mostly advisable to be used if you want to simulate spawning groups on the ground from air units, like vehicles.
---Note that each point in the route assigned to the spawning group is reset to the point of the spawn.
---You can use the returned group to further define the route to be followed.
---
------
---
---USAGE
---```
---
---  local SpawnVec2 = ZONE:New( ZoneName ):GetVec2()
---
---  -- Spawn at the zone center position at the height specified in the ME of the group template!
---  SpawnAirplanes:SpawnFromVec2( SpawnVec2 )
---
---  -- Spawn from the static position at the height randomized between 2000 and 4000 meters.
---  SpawnAirplanes:SpawnFromVec2( SpawnVec2, 2000, 4000 )
---```
------
---@param self SPAWN 
---@param Vec2 Vec2 The Vec2 coordinates where to spawn the group.
---@param MinHeight number (optional) The minimum height to spawn an airborne group into the zone.
---@param MaxHeight number (optional) The maximum height to spawn an airborne group into the zone.
---@param SpawnIndex number (optional) The index which group to spawn within the given zone.
---@return GROUP #that was spawned or #nil if nothing was spawned.
function SPAWN:SpawnFromVec2(Vec2, MinHeight, MaxHeight, SpawnIndex) end

---Will spawn a group from a Vec3 in 3D space.
---This method is mostly advisable to be used if you want to simulate spawning units in the air, like helicopters or airplanes.
---Note that each point in the route assigned to the spawning group is reset to the point of the spawn.
---You can use the returned group to further define the route to be followed.
---
------
---@param self SPAWN 
---@param Vec3 Vec3 The Vec3 coordinates where to spawn the group.
---@param SpawnIndex number (optional) The index which group to spawn within the given zone.
---@return GROUP #that was spawned or #nil if nothing was spawned.
function SPAWN:SpawnFromVec3(Vec3, SpawnIndex) end

---Will return the SpawnGroupName either with with a specific count number or without any count.
---
------
---@param self SPAWN 
---@param SpawnIndex number Is the number of the Group that is to be spawned.
---@return string #SpawnGroupName
function SPAWN:SpawnGroupName(SpawnIndex) end

---Will spawn a Group within a given Core.Zone.
---The Core.Zone can be of any type derived from Core.Zone#ZONE_BASE.
---Once the Wrapper.Group is spawned within the zone, the Wrapper.Group will continue on its route.
---The **first waypoint** (where the group is spawned) is replaced with the zone location coordinates.
---
------
---
---USAGE
---```
---
---  local SpawnZone = ZONE:New( ZoneName )
---
---  -- Spawn at the zone center position at the height specified in the ME of the group template!
---  SpawnAirplanes:SpawnInZone( SpawnZone )
---
---  -- Spawn in the zone at a random position at the height specified in the Me of the group template.
---  SpawnAirplanes:SpawnInZone( SpawnZone, true )
---
---  -- Spawn in the zone at a random position at the height randomized between 2000 and 4000 meters.
---  SpawnAirplanes:SpawnInZone( SpawnZone, true, 2000, 4000 )
---
---  -- Spawn at the zone center position at the height randomized between 2000 and 4000 meters.
---  SpawnAirplanes:SpawnInZone( SpawnZone, false, 2000, 4000 )
---
---  -- Spawn at the zone center position at the height randomized between 2000 and 4000 meters.
---  SpawnAirplanes:SpawnInZone( SpawnZone, nil, 2000, 4000 )
---```
------
---@param self SPAWN 
---@param Zone ZONE The zone where the group is to be spawned.
---@param RandomizeGroup boolean (optional) Randomization of the @{Wrapper.Group} position in the zone.
---@param MinHeight number (optional) The minimum height to spawn an airborne group into the zone.
---@param MaxHeight number (optional) The maximum height to spawn an airborne group into the zone.
---@param SpawnIndex number (optional) The index which group to spawn within the given zone.
---@return GROUP #that was spawned or #nil if nothing was spawned. 
function SPAWN:SpawnInZone(Zone, RandomizeGroup, MinHeight, MaxHeight, SpawnIndex) end

---Will re-start the spawning scheduler.
---Note: This method is only required to be called when the schedule was stopped.
---
------
---@param self SPAWN 
---@return SPAWN #
function SPAWN:SpawnScheduleStart() end

---Will stop the scheduled spawning scheduler.
---
------
---@param self SPAWN 
---@return SPAWN #
function SPAWN:SpawnScheduleStop() end

---Spawns new groups at varying time intervals.
---This is useful if you want to have continuity within your missions of certain (AI) groups to be present (alive) within your missions.
---**WARNING** - Setting a very low SpawnTime heavily impacts your mission performance and CPU time, it is NOT useful to check the alive state of an object every split second! Be reasonable and stay at 15 seconds and above!
---
------
---
---USAGE
---```
----- NATO helicopters engaging in the battle field.
----- The time interval is set to SPAWN new helicopters between each 600 seconds, with a time variation of 50%.
----- The time variation in this case will be between 450 seconds and 750 seconds.
----- This is calculated as follows:
-----      Low limit:   600 * ( 1 - 0.5 / 2 ) = 450
-----      High limit:  600 * ( 1 + 0.5 / 2 ) = 750
----- Between these two values, a random amount of seconds will be chosen for each new spawn of the helicopters.
---Spawn_BE_KA50 = SPAWN:New( 'BE KA-50@RAMP-Ground Defense' ):SpawnScheduled( 600, 0.5 )
---```
------
---@param self SPAWN 
---@param SpawnTime number The time interval defined in seconds between each new spawn of new groups.
---@param SpawnTimeVariation number The variation to be applied on the defined time interval between each new spawn. The variation is a number between 0 and 1, representing the % of variation to be applied on the time interval.
---@param WithDelay boolean Do not spawn the **first** group immediately, but delay the spawn as per the calculation below. Effectively the same as @{#InitDelayOn}().
---@return SPAWN #self
function SPAWN:SpawnScheduled(SpawnTime, SpawnTimeVariation, WithDelay) end

---Will spawn a group with a specified index number.
---Note: This method uses the global _DATABASE object (an instance of Core.Database#DATABASE), which contains ALL initial and new spawned objects in MOOSE.
---
------
---@param self SPAWN 
---@param SpawnIndex string The index of the group to be spawned.
---@param NoBirth NOTYPE 
---@return GROUP #The group that was spawned. You can use this group for further actions.
function SPAWN:SpawnWithIndex(SpawnIndex, NoBirth) end

---Stop the SPAWN InitRepeat function (EVENT handler for takeoff, land and engine shutdown)
---
------
---
---USAGE
---```
---         local spawn = SPAWN:New("Template Group")
---           :InitRepeatOnEngineShutDown()
---         local plane = spawn:Spawn() -- it is important that we keep the SPAWN object and do not overwrite it with the resulting GROUP object by just calling :Spawn()
---         
---         -- later on
---         spawn:StopRepeat()
---```
------
---@param self SPAWN 
---@return SPAWN #self
function SPAWN:StopRepeat() end


---
------
---@param self SPAWN 
---@return number #count
function SPAWN:_CountAliveUnits() end


---
------
---@param self NOTYPE 
---@param SpawnPrefix NOTYPE 
function SPAWN:_GetGroupCategoryID(SpawnPrefix) end


---
------
---@param self NOTYPE 
---@param SpawnPrefix NOTYPE 
function SPAWN:_GetGroupCoalitionID(SpawnPrefix) end


---
------
---@param self NOTYPE 
---@param SpawnPrefix NOTYPE 
function SPAWN:_GetGroupCountryID(SpawnPrefix) end


---
------
---@param self NOTYPE 
function SPAWN:_GetLastIndex() end

---Return the prefix of a SpawnUnit.
---The method will search for a #-mark, and will return the text before the #-mark.
---It will return nil of no prefix was found.
---
------
---@param self SPAWN 
---@param SpawnGroup GROUP The GROUP object.
---@return string #The prefix or #nil if nothing was found.
function SPAWN:_GetPrefixFromGroup(SpawnGroup) end

---Return the prefix of a spawned group.
---The method will search for a `#`-mark, and will return the text before the `#`-mark. It will return nil of no prefix was found.
---
------
---@param self SPAWN 
---@param SpawnGroupName string The name of the spawned group.
---@return string #The prefix or #nil if nothing was found.
function SPAWN:_GetPrefixFromGroupName(SpawnGroupName) end

---Get the next index of the groups to be spawned.
---This method is complicated, as it is used at several spaces.
---
------
---@param self SPAWN 
---@param SpawnIndex number Spawn index.
---@return number #self.SpawnIndex
function SPAWN:_GetSpawnIndex(SpawnIndex) end

---Gets the Group Template from the ME environment definition.
---Note: This method uses the global _DATABASE object (an instance of Core.Database#DATABASE), which contains ALL initial and new spawned objects in MOOSE.
---
------
---@param self SPAWN 
---@param SpawnTemplatePrefix string 
---@return  #@SPAWN self
function SPAWN:_GetTemplate(SpawnTemplatePrefix) end

---Initalize the SpawnGroups collection.
---
------
---@param self SPAWN 
---@param SpawnIndex NOTYPE 
function SPAWN:_InitializeSpawnGroups(SpawnIndex) end


---
------
---@param self NOTYPE 
---@param EventData NOTYPE 
function SPAWN:_OnBirth(EventData) end


---
------
---@param self SPAWN 
---@param EventData EVENTDATA 
function SPAWN:_OnDeadOrCrash(EventData) end

---Will detect AIR Units shutting down their engines ...
---When the event takes place, and the method #InitRepeatOnEngineShutDown was called, the spawned Group will Re-SPAWN.
---But only when the Unit was registered to have landed.
---
------
---@param self SPAWN 
---@param EventData EVENTDATA 
function SPAWN:_OnEngineShutDown(EventData) end

---Will detect AIR Units landing...
---When the event takes place, the spawned Group is registered as landed.
---This is needed to ensure that Re-SPAWNing is only done for landed AIR Groups.
---
------
---@param self SPAWN 
---@param EventData EVENTDATA 
function SPAWN:_OnLand(EventData) end

---Will detect AIR Units taking off...
---When the event takes place, the spawned Group is registered as airborne...
---This is needed to ensure that Re-SPAWNing only is done for landed AIR Groups.
---
------
---@param self SPAWN 
---@param EventData EVENTDATA 
function SPAWN:_OnTakeOff(EventData) end

---Prepares the new Group Template.
---
------
---@param self SPAWN 
---@param SpawnTemplatePrefix string 
---@param SpawnIndex number 
---@return SPAWN #self
function SPAWN:_Prepare(SpawnTemplatePrefix, SpawnIndex) end

---Private method randomizing the routes.
---
------
---@param self SPAWN 
---@param SpawnIndex number The index of the group to be spawned.
---@return SPAWN #
function SPAWN:_RandomizeRoute(SpawnIndex) end

---Private method that randomizes the template of the group.
---
------
---@param self SPAWN 
---@param SpawnIndex number 
---@return SPAWN #self
function SPAWN:_RandomizeTemplate(SpawnIndex) end

---Private method that randomizes the Core.Zones where the Group will be spawned.
---
------
---@param self SPAWN 
---@param SpawnIndex number 
---@param RandomizePositionInZone boolean If nil or true, also the position inside the selected random zone will be randomized. Set to false to use the center of the zone.
---@return SPAWN #self
function SPAWN:_RandomizeZones(SpawnIndex, RandomizePositionInZone) end

---This function is called automatically by the Spawning scheduler.
---It is the internal worker method SPAWNing new Groups on the defined time intervals.
---
------
---@param self SPAWN 
function SPAWN:_Scheduler() end

---Private method that sets the DCS#Vec2 where the Group will be spawned.
---
------
---@param self SPAWN 
---@param SpawnIndex number 
---@return SPAWN #self
function SPAWN:_SetInitialPosition(SpawnIndex) end

---Schedules the CleanUp of Groups
---
------
---@param self SPAWN 
---@return boolean #True = Continue Scheduler
function SPAWN:_SpawnCleanUpScheduler() end


---
------
---@param self NOTYPE 
---@param SpawnIndex NOTYPE 
---@param SpawnRootX NOTYPE 
---@param SpawnRootY NOTYPE 
---@param SpawnX NOTYPE 
---@param SpawnY NOTYPE 
---@param SpawnAngle NOTYPE 
function SPAWN:_TranslateRotate(SpawnIndex, SpawnRootX, SpawnRootY, SpawnX, SpawnY, SpawnAngle) end


---Enumerator for spawns at airbases
---@class SPAWN.Takeoff 
---@field Air number Take off happens in air.
---@field Cold number Spawn at parking with engines off.
---@field Hot number Spawn at parking with engines on.
---@field Runway number Spawn on runway. Does not work in MP!
SPAWN.Takeoff = {}



