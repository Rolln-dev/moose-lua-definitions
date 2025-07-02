---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Wrapper_Group.JPG" width="100%">
---
---**Wrapper** - GROUP wraps the DCS Class Group objects.
---
---===
---
---The #GROUP class is a wrapper class to handle the DCS Group objects.
---
---## Features:
---
--- * Support all DCS Group APIs.
--- * Enhance with Group specific APIs not in the DCS Group API set.
--- * Handle local Group Controller.
--- * Manage the "state" of the DCS Group.
---
---**IMPORTANT: ONE SHOULD NEVER SANITIZE these GROUP OBJECT REFERENCES! (make the GROUP object references nil).**
---
---===
---
---For each DCS Group object alive within a running mission, a GROUP wrapper object (instance) will be created within the global _DATABASE object (an instance of Core.Database#DATABASE).
---This is done at the beginning of the mission (when the mission starts), and dynamically when new DCS Group objects are spawned (using the Core.Spawn class).
---
---The GROUP class does not contain a :New() method, rather it provides :Find() methods to retrieve the object reference
---using the DCS Group or the DCS GroupName.
---
---The GROUP methods will reference the DCS Group object by name when it is needed during API execution.
---If the DCS Group object does not exist or is nil, the GROUP methods will return nil and may log an exception in the DCS.log file.
---
---===
---
---### [Demo Missions](https://github.com/FlightControl-Master/MOOSE_Demos/tree/master/Wrapper/Group)
---
---===
---
---### Author: **FlightControl**
---
---### Contributions:
---
---  * **Entropy**, **Afinegan**: Came up with the requirement for AIOnOff().
---  * **Applevangelist**: various
---
---===
---Wrapper class of the DCS world Group object.
---
---## Finding groups
---
---The GROUP class provides the following functions to retrieve quickly the relevant GROUP instance:
---
--- * #GROUP.Find(): Find a GROUP instance from the global _DATABASE object (an instance of Core.Database#DATABASE) using a DCS Group object.
--- * #GROUP.FindByName(): Find a GROUP instance from the global _DATABASE object (an instance of Core.Database#DATABASE) using a DCS Group name.
--- * #GROUP.FindByMatching(): Find a GROUP instance from the global _DATABASE object (an instance of Core.Database#DATABASE) using pattern matching.
--- * #GROUP.FindAllByMatching(): Find all GROUP instances from the global _DATABASE object (an instance of Core.Database#DATABASE) using pattern matching.
---
---## Tasking of groups
---
---A GROUP is derived from the wrapper class CONTROLLABLE (Wrapper.Controllable#CONTROLLABLE).
---See the Wrapper.Controllable task methods section for a description of the task methods.
---
---But here is an example how a group can be assigned a task.
---
---This test demonstrates the use(s) of the SwitchWayPoint method of the GROUP class.
---
---First we look up the objects. We create a GROUP object `HeliGroup`, using the #GROUP:FindByName() method, looking up the `"Helicopter"` group object.
---Same for the `"AttackGroup"`.
---
---         local HeliGroup = GROUP:FindByName( "Helicopter" )
---         local AttackGroup = GROUP:FindByName( "AttackGroup" )
---
---Now we retrieve the Wrapper.Unit#UNIT objects of the `AttackGroup` object, using the method `:GetUnits()`.
---
---         local AttackUnits = AttackGroup:GetUnits()
---
---Tasks are actually text strings that we build using methods of GROUP.
---So first, we declare an list of `Tasks`.
---
---         local Tasks = {}
---
---Now we loop over the `AttackUnits` using a for loop.
---We retrieve the `AttackUnit` using the `AttackGroup:GetUnit()` method.
---Each `AttackUnit` found, will be attacked by `HeliGroup`, using the method `HeliGroup:TaskAttackUnit()`.
---This method returns a string containing a command line to execute the task to the `HeliGroup`.
---The code will assign the task string command to the next element in the `Task` list, using `Tasks[#Tasks+1]`.
---This little code will take the count of `Task` using `#` operator, and will add `1` to the count.
---This result will be the index of the `Task` element.
---
---         for i = 1, #AttackUnits do
---           local AttackUnit = AttackGroup:GetUnit( i )
---           Tasks[#Tasks+1] = HeliGroup:TaskAttackUnit( AttackUnit )
---         end
---
---Once these tasks have been executed, a function `_Resume` will be called ...
---
---         Tasks[#Tasks+1] = HeliGroup:TaskFunction( "_Resume", { "''" } )
---
---         -- @param Wrapper.Group#GROUP HeliGroup
---         function _Resume( HeliGroup )
---           env.info( '_Resume' )
---
---           HeliGroup:MessageToAll( "Resuming",10,"Info")
---         end
---
---Now here is where the task gets assigned!
---Using `HeliGroup:PushTask`, the task is pushed onto the task queue of the group `HeliGroup`.
---Since `Tasks` is an array of tasks, we use the `HeliGroup:TaskCombo` method to execute the tasks.
---The `HeliGroup:PushTask` method can receive a delay parameter in seconds.
---In the example, `30` is given as a delay.
---
---
---         HeliGroup:PushTask(
---           HeliGroup:TaskCombo(
---           Tasks
---           ), 30
---         )
---
---That's it!
---But again, please refer to the Wrapper.Controllable task methods section for a description of the different task methods that are available.
---
---
---
---### Obtain the mission from group templates
---
---Group templates contain complete mission descriptions. Sometimes you want to copy a complete mission from a group and assign it to another:
---
---  * Wrapper.Controllable#CONTROLLABLE.TaskMission: (AIR + GROUND) Return a mission task from a mission template.
---
---## GROUP Command methods
---
---A GROUP is a Wrapper.Controllable. See the Wrapper.Controllable command methods section for a description of the command methods.
---
---## GROUP option methods
---
---A GROUP is a Wrapper.Controllable. See the Wrapper.Controllable option methods section for a description of the option methods.
---
---## GROUP Zone validation methods
---
---The group can be validated whether it is completely, partly or not within a Core.Zone.
---Use the following Zone validation methods on the group:
---
---  * #GROUP.IsCompletelyInZone: Returns true if all units of the group are within a Core.Zone.
---  * #GROUP.IsPartlyInZone: Returns true if some units of the group are within a Core.Zone.
---  * #GROUP.IsNotInZone: Returns true if none of the group units of the group are within a Core.Zone.
---
---The zone can be of any Core.Zone class derived from Core.Zone#ZONE_BASE. So, these methods are polymorphic to the zones tested on.
---
---## GROUP AI methods
---
---A GROUP has AI methods to control the AI activation.
---
---  * #GROUP.SetAIOnOff(): Turns the GROUP AI On or Off.
---  * #GROUP.SetAIOn(): Turns the GROUP AI On.
---  * #GROUP.SetAIOff(): Turns the GROUP AI Off.
---@class GROUP : CONTROLLABLE
---@field Attribute GROUP.Attribute 
---@field DCSObject NOTYPE 
---@field GroupCoalition NOTYPE 
---@field GroupName string The name of the group.
---@field InitCoord NOTYPE 
---@field InitRespawnFreq NOTYPE 
---@field InitRespawnHeading NOTYPE 
---@field InitRespawnHeight NOTYPE 
---@field InitRespawnModex NOTYPE 
---@field InitRespawnModu NOTYPE 
---@field InitRespawnRadio boolean 
---@field InitRespawnRandomizePositionZone NOTYPE 
---@field InitRespawnZone NOTYPE 
---@field LastCallDCSObject NOTYPE 
---@field Takeoff GROUP.Takeoff 
GROUP = {}

---Activates a late activated GROUP.
---
------
---@param delay number Delay in seconds, before the group is activated.
---@return GROUP #self
function GROUP:Activate(delay) end

---Returns if all units of the group are on the ground or landed.
---If all units of this group are on the ground, this function will return true, otherwise false.
---
------
---@return boolean #All units on the ground result.
function GROUP:AllOnGround() end

---Calculate the maxium A2G threat level of the Group.
---
------
---@return number #Number between 0 and 10.
function GROUP:CalculateThreatLevelA2G() end

---Switch on/off immortal flag for the group.
---
------
---@param switch boolean If true, Immortal is enabled. If false, Immortal is disabled.
---@return GROUP #self
function GROUP:CommandSetImmortal(switch) end

---Switch on/off invisible flag for the group.
---
------
---@param switch boolean If true, Invisible is enabled. If false, Invisible is disabled.
---@return GROUP #self
function GROUP:CommandSetInvisible(switch) end

---Return the route of a group by using the global _DATABASE object (an instance of Core.Database#DATABASE).
---
------
---@param Begin number The route point from where the copy will start. The base route point is 0.
---@param End number The route point where the copy will end. The End point is the last point - the End point. The last point has base 0.
---@param Randomize boolean Randomization of the route, when true.
---@param Radius number When randomization is on, the randomization is within the radius.
function GROUP:CopyRoute(Begin, End, Randomize, Radius) end

---Count number of alive units in the group.
---
------
---@return number #Number of alive units. If DCS group is nil, 0 is returned.
function GROUP:CountAliveUnits() end

---Returns the number of UNITs that are in the Core.Zone
---
------
---@param Zone ZONE_BASE The zone to test.
---@return number #The number of UNITs that are in the @{Core.Zone}
function GROUP:CountInZone(Zone) end

---Deactivates an activated GROUP.
---
------
---@param delay number Delay in seconds, before the group is activated.
---@return GROUP #self
function GROUP:Deactivate(delay) end

---Destroys the DCS Group and all of its DCS Units.
---Note that this destroy method also can raise a destroy event at run-time.
---So all event listeners will catch the destroy event of this group for each unit in the group.
---To raise these events, provide the `GenerateEvent` parameter.
---
------
---
---USAGE
---```
----- Air unit example: destroy the Helicopter and generate a S_EVENT_CRASH for each unit in the Helicopter group.
---Helicopter = GROUP:FindByName( "Helicopter" )
---Helicopter:Destroy( true )
---```
------
---@param GenerateEvent boolean If true, a crash [AIR] or dead [GROUND] event for each unit is generated. If false, if no event is triggered. If nil, a RemoveUnit event is triggered.
---@param delay number Delay in seconds before despawning the group.
function GROUP:Destroy(GenerateEvent, delay) end

---GROUND - Switch on/off radar emissions for the group.
---
------
---@param switch boolean If true, emission is enabled. If false, emission is disabled.
---@return GROUP #self
function GROUP:EnableEmission(switch) end

---Find the GROUP wrapper class instance using the DCS Group.
---
------
---@param DCSGroup Group The DCS Group.
---@return GROUP #The GROUP.
function GROUP:Find(DCSGroup) end

---Find all GROUP objects matching using patterns.
---Note that this is **a lot** slower than `:FindByName()`!
---
------
---
---USAGE
---```
---         -- Find all group with a partial group name
---         local grptable = GROUP:FindAllByMatching( "Apple" )
---         -- will return all groups with "Apple" in the name
---
---         -- using a pattern
---         local grp = GROUP:FindAllByMatching( ".%d.%d$" )
---         -- will return the all groups found ending in "-1-1" to "-9-9", but not e.g. "-10-1" or "-1-10"
---```
------
---@param Pattern string The pattern to look for. Refer to [LUA patterns](http://www.easyuo.com/openeuo/wiki/index.php/Lua_Patterns_and_Captures_\(Regular_Expressions\)) for regular expressions in LUA.
---@return table #Groups Table of matching #GROUP objects found
function GROUP:FindAllByMatching(Pattern) end

---Find the first(!) GROUP matching using patterns.
---Note that this is **a lot** slower than `:FindByName()`!
---
------
---
---USAGE
---```
---         -- Find a group with a partial group name
---         local grp = GROUP:FindByMatching( "Apple" )
---         -- will return e.g. a group named "Apple-1-1"
---
---         -- using a pattern
---         local grp = GROUP:FindByMatching( ".%d.%d$" )
---         -- will return the first group found ending in "-1-1" to "-9-9", but not e.g. "-10-1"
---```
------
---@param Pattern string The pattern to look for. Refer to [LUA patterns](http://www.easyuo.com/openeuo/wiki/index.php/Lua_Patterns_and_Captures_\(Regular_Expressions\)) for regular expressions in LUA.
---@return GROUP #The GROUP.
function GROUP:FindByMatching(Pattern) end

---Find a GROUP using the DCS Group Name.
---
------
---@param GroupName string The DCS Group Name.
---@return GROUP #The GROUP.
function GROUP:FindByName(GroupName) end

---Returns the average group altitude in meters.
---
------
---@param FromGround boolean Measure from the ground or from sea level (ASL). Provide **true** for measuring from the ground (AGL). **false** or **nil** if you measure from sea level.
---@return number #The altitude of the group or nil if is not existing or alive.
function GROUP:GetAltitude(FromGround) end

---Get the number of shells, rockets, bombs and missiles the whole group currently has.
---
------
---@return number #Total amount of ammo the group has left. This is the sum of shells, rockets, bombs and missiles of all units.
---@return number #Number of shells left.
---@return number #Number of rockets left.
---@return number #Number of bombs left.
---@return number #Number of missiles left.
---@return number #Number of artillery shells left (with explosive mass, included in shells; shells can also be machine gun ammo)
function GROUP:GetAmmunition() end

---Get the generalized attribute of a self.
---Note that for a heterogenious self, the attribute is determined from the attribute of the first unit!
---
------
---@return string #Generalized attribute of the self.
function GROUP:GetAttribute() end

---Returns a COORDINATE object indicating the average position of the GROUP within the mission.
---
------
---@return COORDINATE #The COORDINATE of the GROUP.
function GROUP:GetAverageCoordinate() end

---Returns the average Vec3 vector of the Units in the GROUP.
---
------
---@return Vec3 #Current Vec3 of the GROUP  or nil if cannot be found.
function GROUP:GetAverageVec3() end

---Gets the CallSign of the first DCS Unit of the DCS Group.
---
------
---@return string #The CallSign of the first DCS Unit of the DCS Group.
function GROUP:GetCallsign() end

---Returns category of the DCS Group.
---Returns one of
---
---* Group.Category.AIRPLANE
---* Group.Category.HELICOPTER
---* Group.Category.GROUND
---* Group.Category.SHIP
---* Group.Category.TRAIN
---
------
---@return Group.Category #The category ID.
function GROUP:GetCategory() end

---Returns the category name of the #GROUP.
---
------
---@return string #Category name = Helicopter, Airplane, Ground Unit, Ship, Train.
function GROUP:GetCategoryName() end

---Returns the coalition of the DCS Group.
---
------
---@return coalition.side #The coalition side of the DCS Group.
function GROUP:GetCoalition() end

---Returns a COORDINATE object indicating the point of the first UNIT of the GROUP within the mission.
---
------
---@return COORDINATE #The COORDINATE of the GROUP.
function GROUP:GetCoordinate() end

---Returns the country of the DCS Group.
---
------
---@return country.id #The country identifier or nil if the DCS Group is not existing or alive.
function GROUP:GetCountry() end

---Get TTS friendly, optionally customized callsign mainly for **player groups**.
---A customized callsign is taken from the #GROUP name, after an optional '#' sign, e.g. "Aerial 1-1#Ghostrider" resulting in "Ghostrider 9", or,
---if that isn't available, from the playername, as set in the mission editor main screen under Logbook, after an optional '|' sign (actually, more of a personal call sign), e.g. "Apple|Moose" results in "Moose 9 1". Options see below.
---
------
---
---USAGE
---```
---           -- suppose there are three groups with one (client) unit each:
---           -- Slot 1               -- with mission editor callsign Enfield-1
---           -- Slot 2 # Apollo 403  -- with mission editor callsign Enfield-2
---           -- Slot 3 | Apollo      -- with mission editor callsign Enfield-3
---           -- Slot 4 | Apollo      -- with mission editor callsign Devil-4
---           -- and suppose these Custom CAP Flight Callsigns for use with TTS are set
---           mygroup:GetCustomCallSign(true,false,{
---             Devil = 'Bengal',
---             Snake = 'Winder',
---             Colt = 'Camelot',
---             Enfield = 'Victory',
---             Uzi = 'Evil Eye'
---           })
---           -- then GetCustomCallsign will return
---           -- Enfield-1 for Slot 1
---           -- Apollo for Slot 2 or Apollo 403 if Keepnumber is set
---           -- Apollo for Slot 3
---           -- Bengal-4 for Slot 4
---
---           -- Using a custom function (for player units **only**):
---           -- Imagine your playernames are looking like so: "[Squadname] | Cpt Apple" and you only want to have the last word as callsign, i.e. "Apple" here. Then this custom function will return this:
---           local callsign = mygroup:GetCustomCallSign(true,false,nil,function(groupname,playername) return string.match(playername,"([%a]+)$") end)
---```
------
---@param ShortCallsign boolean Return a shortened customized callsign, i.e. "Ghostrider 9" and not "Ghostrider 9 1"
---@param Keepnumber boolean (Player only) Return customized callsign, incl optional numbers at the end, e.g. "Aerial 1-1#Ghostrider 109" results in "Ghostrider 109", if you want to e.g. use historical US Navy Callsigns
---@param CallsignTranslations? table (Optional) Table to translate between DCS standard callsigns and bespoke ones. Overrides personal/parsed callsigns if set callsigns from playername or group name.
---@param CustomFunction? func (Optional) For player names only(!). If given, this function will return the callsign. Needs to take the groupname and the playername as first arguments.
---@param ...? arg (Optional) Comma separated arguments to add to the CustomFunction call after groupname and playername.
---@return string #Callsign
function GROUP:GetCustomCallSign(ShortCallsign, Keepnumber, CallsignTranslations, CustomFunction, ...) end

---Returns the DCS descriptor table of the nth unit of the group.
---
------
---@param n? number (Optional) The number of the unit for which the dscriptor is returned.
---@return Object.Desc #The descriptor of the first unit of the group or #nil if the group does not exist any more.
function GROUP:GetDCSDesc(n) end

---Returns the DCS Group.
---
------
---@return Group #The DCS Group.
function GROUP:GetDCSObject() end

---Returns the DCS Unit with number UnitNumber.
---If the underlying DCS Unit does not exist, the method will return try to find the next unit. Returns nil if no units are found.
---
------
---@param UnitNumber number The number of the DCS Unit to be returned.
---@return Unit #The DCS Unit.
function GROUP:GetDCSUnit(UnitNumber) end

---Returns the DCS Units of the DCS Group.
---
------
---@return table #The DCS Units.
function GROUP:GetDCSUnits() end

---Get the first unit of the group.
---Might be nil!
---
------
---@return UNIT #First unit or nil if it does not exist.
function GROUP:GetFirstUnit() end

---Get the first unit of the group which is alive.
---
------
---@return UNIT #First unit alive.
function GROUP:GetFirstUnitAlive() end

---Returns relative amount of fuel (from 0.0 to 1.0) the group has in its internal tanks.
---If there are additional fuel tanks the value may be greater than 1.0.
---
------
---@return number #The relative amount of fuel (from 0.0 to 1.0).
---@return nil #The GROUP is not existing or alive.
function GROUP:GetFuel() end

---Returns relative amount of fuel (from 0.0 to 1.0) the group has in its
--- internal tanks.
---If there are additional fuel tanks the value may be
--- greater than 1.0.
---
------
---@return number #The relative amount of fuel (from 0.0 to 1.0).
---@return nil #The GROUP is not existing or alive.
function GROUP:GetFuelAvg() end

---Return the fuel state and unit reference for the unit with the least
---amount of fuel in the group.
---
------
---@return number #The fuel state of the unit with the least amount of fuel.
---@return UNIT #reference to #Unit object for further processing.
function GROUP:GetFuelMin() end

---Get a list of Link16 S/TN data from a GROUP.
---Can (as of Nov 2023) be obtained from F-18, F-16, F-15E (not the user flyable one) and A-10C-II groups.
---
------
---@return table #Table of data entries, indexed by unit name, each entry is a table containing STN, VCL (voice call label), VCN (voice call number), and Lead (#boolean, if true it's the flight lead)
---@return string #Report Formatted report of all data
function GROUP:GetGroupSTN() end

---Returns the mean heading of every UNIT in the GROUP in degrees
---
------
---@return number #Mean heading of the GROUP in degrees or #nil The first UNIT is not existing or alive.
function GROUP:GetHeading() end

---Returns the average group height in meters.
---
------
---@param FromGround boolean Measure from the ground or from sea level (ASL). Provide **true** for measuring from the ground (AGL). **false** or **nil** if you measure from sea level.
---@return number #The height of the group or nil if is not existing or alive.
function GROUP:GetHeight(FromGround) end

---Get the unit in the group with the highest threat level, which is still alive.
---
------
---@return UNIT #The most dangerous unit in the group.
---@return number #Threat level of the unit.
function GROUP:GetHighestThreat() end

---- Returns the initial size of the DCS Group.
---If some of the DCS Units of the DCS Group are destroyed, the initial size of the DCS Group is unchanged.
---
------
---@return number #The DCS Group initial size.
function GROUP:GetInitialSize() end

---Returns the current maximum height of the group, i.e.
---the highest unit height of that group.
---Each unit within the group gets evaluated, and the maximum height (= the unit which is the highest elevated) is returned.
---
------
---@return number #Maximum height found.
function GROUP:GetMaxHeight() end

---Returns the current maximum velocity of the group.
---Each unit within the group gets evaluated, and the maximum velocity (= the unit which is going the fastest) is returned.
---
------
---@return number #Maximum velocity found.
function GROUP:GetMaxVelocity() end

---Returns the current minimum height of the group.
---Each unit within the group gets evaluated, and the minimum height (= the unit which is the lowest elevated) is returned.
---
------
---@return number #Minimum height found.
function GROUP:GetMinHeight() end

--- [AIRPLANE] Get the NATO reporting name (platform, e.g.
---"Flanker") of a GROUP (note - first unit the group). "Bogey" if not found. Currently airplanes only!
---
------
---@return string #NatoReportingName or "Bogey" if unknown.
function GROUP:GetNatoReportingName() end

---Get the active player count in the group.
---
------
---@return number #The amount of players.
function GROUP:GetPlayerCount() end

---Gets the player name of the group.
---
------
---@return string #The player name of the group.
function GROUP:GetPlayerName() end

---Get player names
---
------
---@return table #The group has players, an array of player names is returned.
---@return nil #The group has no players
function GROUP:GetPlayerNames() end

---Returns a list of Wrapper.Unit objects of the Wrapper.Group that are occupied by a player.
---
------
---@return list #The list of player occupied @{Wrapper.Unit} objects of the @{Wrapper.Group}.
function GROUP:GetPlayerUnits() end

---Returns a COORDINATE object indicating the point in 2D of the first UNIT of the GROUP within the mission.
---
------
---@return COORDINATE #The 3D point vector of the first DCS Unit of the GROUP.
---@return nil #The first UNIT is not existing or alive.
function GROUP:GetPointVec2() end

---Returns the DCS#Position3 position vectors indicating the point and direction vectors in 3D of the POSITIONABLE within the mission.
---
------
---@return Position #The 3D position vectors of the POSITIONABLE or #nil if the groups not existing or alive.
function GROUP:GetPositionVec3() end

---Returns a random DCS#Vec3 vector (point in 3D of the UNIT within the mission) within a range around the first UNIT of the GROUP.
---
------
---
---USAGE
---```
----- If Radius is ignored, returns the DCS#Vec3 of first UNIT of the GROUP
---```
------
---@param Radius number Radius in meters.
---@return Vec3 #The random 3D point vector around the first UNIT of the GROUP or #nil The GROUP is invalid or empty.
function GROUP:GetRandomVec3(Radius) end

---Returns the maximum range of the group.
---If the group is heterogenious and consists of different units, the smallest range of all units is returned.
---
------
---@return number #Range in meters.
function GROUP:GetRange() end

---Returns current size of the DCS Group.
---If some of the DCS Units of the DCS Group are destroyed the size of the DCS Group is changed.
---
------
---@return number #The DCS Group size.
function GROUP:GetSize() end

---Get skill from Group.
---Effectively gets the skill from Unit 1 as the group holds no skill value.
---
------
---@return string #Skill String of skill name.
function GROUP:GetSkill() end

---Returns the maximum speed of the group.
---If the group is heterogenious and consists of different units, the max speed of the slowest unit is returned.
---
------
---@return number #Speed in km/h.
function GROUP:GetSpeedMax() end

---Return the mission template of the group.
---
------
---@return table #The MissionTemplate
function GROUP:GetTaskMission() end

---Return the mission route of the group.
---
------
---@return table #The mission route defined by points.
function GROUP:GetTaskRoute() end

---Returns the group template from the global _DATABASE object (an instance of Core.Database#DATABASE).
---
------
---@return table #Template table.
function GROUP:GetTemplate() end

---Returns the group template route.points[] (the waypoints) from the global _DATABASE object (an instance of Core.Database#DATABASE).
---
------
---@return table #
function GROUP:GetTemplateRoutePoints() end

---Get threat level of the group.
---
------
---@return number #Max threat level (a number between 0 and 10).
function GROUP:GetThreatLevel() end

---Gets the type name of the group.
---
------
---@return string #The type name of the group.
function GROUP:GetTypeName() end

---Returns the UNIT wrapper object with number UnitNumber.
---If it doesn't exist, tries to return the next available unit.
---If no underlying DCS Units exist, the method will return nil.
---
------
---@param UnitNumber number The number of the UNIT wrapper class to be returned.
---@return UNIT #The UNIT object or nil
function GROUP:GetUnit(UnitNumber) end

---Returns a list of Wrapper.Unit objects of the Wrapper.Group.
---
------
---@return table #of Wrapper.Unit#UNIT objects, indexed by number.
function GROUP:GetUnits() end

---Returns the current point (Vec2 vector) of the first DCS Unit in the DCS Group.
---
------
---@return Vec2 #Current Vec2 point of the first DCS Unit of the DCS Group.
function GROUP:GetVec2() end

---Returns the current Vec3 vector of the first Unit in the GROUP.
---
------
---@return Vec3 #Current Vec3 of the first Unit of the GROUP or nil if cannot be found.
function GROUP:GetVec3() end

---Returns the average velocity Vec3 vector.
---
------
---@return Vec3 #The velocity Vec3 vector or `#nil` if the GROUP is not existing or alive.
function GROUP:GetVelocityVec3() end

---Subscribe to a DCS Event.
---
------
---@param Event EVENTS 
---@param EventFunction? function (optional) The function to be called when the event occurs for the GROUP.
---@param ... NOTYPE 
---@return GROUP #
function GROUP:HandleEvent(Event, EventFunction, ...) end

---Check if at least one (or all) unit(s) has (have) a certain attribute.
---See [hoggit documentation](https://wiki.hoggitworld.com/view/DCS_func_hasAttribute).
---
------
---@param attribute string The name of the attribute the group is supposed to have. Valid attributes can be found in the "db_attributes.lua" file which is located at in "C:\Program Files\Eagle Dynamics\DCS World\Scripts\Database".
---@param all boolean If true, all units of the group must have the attribute in order to return true. Default is only one unit of a heterogenious group needs to have the attribute.
---@return boolean #Group has this attribute.
function GROUP:HasAttribute(attribute, all) end

---Returns true if the first unit of the GROUP is in the air.
---
------
---@return boolean #true if in the first unit of the group is in the air or #nil if the GROUP is not existing or not alive.
function GROUP:InAir() end

---Set respawn coordinate.
---
------
---@param coordinate COORDINATE Coordinate where the group should be respawned.
---@return GROUP #self
function GROUP:InitCoordinate(coordinate) end

---Set the heading for the units in degrees within the respawned group.
---
------
---@param Heading number The heading in meters.
---@return GROUP #self
function GROUP:InitHeading(Heading) end

---Set the height for the units in meters for the respawned group.
---(This is applicable for air units).
---
------
---@param Height number The height in meters.
---@return GROUP #self
function GROUP:InitHeight(Height) end

---Sets the modex (tail number) of the first unit of the group.
---If more units are in the group, the number is increased with every unit.
---
------
---@param modex string Tail number of the first unit.
---@return GROUP #self
function GROUP:InitModex(modex) end

---Sets the radio comms on or off when the group is respawned.
---Same as checking/unchecking the COMM box in the mission editor.
---
------
---@param switch boolean If true (or nil), enables the radio comms. If false, disables the radio for the spawned group.
---@return GROUP #self
function GROUP:InitRadioCommsOnOff(switch) end

---Sets the radio frequency of the group when it is respawned.
---
------
---@param frequency number The frequency in MHz.
---@return GROUP #self
function GROUP:InitRadioFrequency(frequency) end

---Set radio modulation when the group is respawned.
---Default is AM.
---
------
---@param modulation string Either "FM" or "AM". If no value is given, modulation is set to AM.
---@return GROUP #self
function GROUP:InitRadioModulation(modulation) end

---Randomize the positions of the units of the respawned group in a circle band.
---When a Respawn happens, the units of the group will be positioned at random places within the Outer and Inner radius.
---Thus, a band is created around the respawn location where the units will be placed at random positions.
---
------
---@param OuterRadius boolean Outer band in meters from the center.
---@param InnerRadius boolean Inner band in meters from the center.
---@return GROUP #self
function GROUP:InitRandomizePositionRadius(OuterRadius, InnerRadius) end

---Randomize the positions of the units of the respawned group within the Core.Zone.
---When a Respawn happens, the units of the group will be placed at random positions within the Zone (selected).
---NOTE: InitRandomizePositionZone will not ensure, that every unit is placed within the zone!
---
------
---@param PositionZone boolean true will randomize the positions within the Zone.
---@return GROUP #self
function GROUP:InitRandomizePositionZone(PositionZone) end

---Set the respawn Core.Zone for the respawned group.
---
------
---@param Zone ZONE The zone in meters.
---@return GROUP #self
function GROUP:InitZone(Zone) end

---[GROUND] Determine if a GROUP has a AAA unit, i.e.
---has no radar or optical tracker but the AAA = true or the "Mobile AAA" = true attribute.
---
------
---@return boolean #IsAAA True if AAA, else false
function GROUP:IsAAA() end

---Returns if the group is activated.
---
------
---@return boolean #`true` if group is activated or `#nil` The group is not existing or alive.
function GROUP:IsActive() end

---Returns if the group is of an air category.
---If the group is a helicopter or a plane, then this method will return true, otherwise false.
---
------
---@return boolean #Air category evaluation result.
function GROUP:IsAir() end

---Returns if the DCS Group contains AirPlanes.
---
------
---@return boolean #true if DCS Group contains AirPlanes.
function GROUP:IsAirPlane() end

---Checks whether any unit (or optionally) all units of a group is(are) airbore or not.
---
------
---@param AllUnits? boolean (Optional) If true, check whether all units of the group are airborne.
---@return boolean #True if at least one (optionally all) unit(s) is(are) airborne or false otherwise. Nil if no unit exists or is alive.
function GROUP:IsAirborne(AllUnits) end

---Returns if the group is alive.
---The Group must:
---
---  * Exist at run-time.
---  * Has at least one unit.
---
---When the first Wrapper.Unit of the group is active, it will return true.
---If the first Wrapper.Unit of the group is inactive, it will return false.
---
------
---@return boolean #`true` if the group is alive *and* active, `false` if the group is alive but inactive or `#nil` if the group does not exist anymore.
function GROUP:IsAlive() end

---Returns true if any units of the group are within a Core.Zone.
---
------
---@param Zone ZONE_BASE The zone to test.
---@return boolean #Returns true if any unit of the Group is within the @{Core.Zone#ZONE_BASE}
function GROUP:IsAnyInZone(Zone) end

---Returns true if all units of the group are within a Core.Zone.
---
------
---@param Zone ZONE_BASE The zone to test.
---@return boolean #Returns true if the Group is completely within the @{Core.Zone#ZONE_BASE}
function GROUP:IsCompletelyInZone(Zone) end

---Returns if the DCS Group contains Ground troops.
---
------
---@return boolean #true if DCS Group contains Ground troops.
function GROUP:IsGround() end

---Returns if the DCS Group contains Helicopters.
---
------
---@return boolean #true if DCS Group contains Helicopters.
function GROUP:IsHelicopter() end

---Check if any unit of a group is inside a Core.Zone.
---
------
---@param Zone ZONE_BASE The zone to test.
---@return boolean #Returns `true` if *at least one unit* is inside the zone or `false` if *no* unit is inside.
function GROUP:IsInZone(Zone) end

---Returns true if none of the group units of the group are within a Core.Zone.
---
------
---@param Zone ZONE_BASE The zone to test.
---@return boolean #Returns true if the Group is not within the @{Core.Zone#ZONE_BASE}
function GROUP:IsNotInZone(Zone) end

---Returns true if some but NOT ALL units of the group are within a Core.Zone.
---
------
---@param Zone ZONE_BASE The zone to test.
---@return boolean #Returns true if the Group is partially within the @{Core.Zone#ZONE_BASE}
function GROUP:IsPartlyInZone(Zone) end

---Returns true if part or all units of the group are within a Core.Zone.
---
------
---@param Zone ZONE_BASE The zone to test.
---@return boolean #Returns true if the Group is partially or completely within the @{Core.Zone#ZONE_BASE}.
function GROUP:IsPartlyOrCompletelyInZone(Zone) end

---Check if an (air) group is a client or player slot.
---Information is retrieved from the group template.
---
------
---@return boolean #If true, group is associated with a client or player slot.
function GROUP:IsPlayer() end

---[GROUND] Determine if a GROUP is a SAM unit, i.e.
---has radar or optical tracker and is no mobile AAA.
---
------
---@return boolean #IsSAM True if SAM, else false
function GROUP:IsSAM() end

---Returns if the DCS Group contains Ships.
---
------
---@return boolean #true if DCS Group contains Ships.
function GROUP:IsShip() end

---Create a new GROUP from a given GroupTemplate as a parameter.
---Note that the GroupTemplate is NOT spawned into the mission.
---It is merely added to the Core.Database.
---
------
---@param GroupTemplate table The GroupTemplate Structure exactly as defined within the mission editor.
---@param CoalitionSide coalition.side The coalition.side of the group.
---@param CategoryID Group.Category The Group.Category of the group.
---@param CountryID country.id the country.id of the group.
---@return GROUP #self
function GROUP:NewTemplate(GroupTemplate, CoalitionSide, CategoryID, CountryID) end


---
------
---@param ReSpawnFunction NOTYPE 
function GROUP:OnReSpawn(ReSpawnFunction) end

---Create a new GROUP from an existing Group in the Mission.
---
------
---@param GroupName string The Group name
---@return GROUP #self
function GROUP:Register(GroupName) end

---Reset the subscriptions.
---
------
---@return GROUP #
function GROUP:ResetEvents() end

---Respawn the Wrapper.Group at a Core.Point.
---The method will setup the new group template according the Init(Respawn) settings provided for the group.
---These settings can be provided by calling the relevant Init...() methods of the Group.
---
---  - #GROUP.InitHeading: Set the heading for the units in degrees within the respawned group.
---  - #GROUP.InitHeight: Set the height for the units in meters for the respawned group. (This is applicable for air units).
---  - #GROUP.InitRandomizeHeading: Randomize the headings for the units within the respawned group.
---  - #GROUP.InitZone: Set the respawn Core.Zone for the respawned group.
---  - #GROUP.InitRandomizePositionZone: Randomize the positions of the units of the respawned group within the Core.Zone.
---  - #GROUP.InitRandomizePositionRadius: Randomize the positions of the units of the respawned group in a circle band.
---
---Notes:
---
---  - The current alive group will always be destroyed and respawned using the template definition.
---
------
---@param Template? table (optional) The template of the Group retrieved with GROUP:GetTemplate(). If the template is not provided, the template will be retrieved of the group itself.
---@param Reset boolean Reset positions if TRUE.
---@return GROUP #self
function GROUP:Respawn(Template, Reset) end

---Respawn a group at an airbase.
---Note that the group has to be on parking spots at the airbase already in order for this to work.
---So each unit of the group is respawned at exactly the same parking spot as it currently occupies.
---
------
---@param SpawnTemplate? table (Optional) The spawn template for the group. If no template is given it is exacted from the group.
---@param Takeoff? SPAWN.Takeoff (Optional) Takeoff type. Sould be either SPAWN.Takeoff.Cold or SPAWN.Takeoff.Hot. Default is SPAWN.Takeoff.Hot.
---@param Uncontrolled? boolean (Optional) If true, spawn in uncontrolled state.
---@return GROUP #Group spawned at airbase or nil if group could not be spawned.
function GROUP:RespawnAtCurrentAirbase(SpawnTemplate, Takeoff, Uncontrolled) end

---(AIR) Return the Group to an Wrapper.Airbase#AIRBASE.
---The following things are to be taken into account:
---
---  * The group is respawned to achieve the RTB, there may be side artefacts as a result of this. (Like weapons suddenly come back).
---  * A group consisting out of more than one unit, may rejoin formation when respawned.
---  * A speed can be given in km/h. If no speed is specified, the maximum speed of the first unit will be taken to return to base.
---  * When there is no Wrapper.Airbase object specified, the group will return to the home base if the route of the group is pinned at take-off or at landing to a base.
---  * When there is no Wrapper.Airbase object specified and the group route is not pinned to any airbase, it will return to the nearest airbase.
---
------
---@param RTBAirbase? AIRBASE (optional) The @{Wrapper.Airbase} to return to. If blank, the controllable will return to the nearest friendly airbase.
---@param Speed? number (optional) The Speed, if no Speed is given, 80% of maximum Speed of the group is selected.
---@return GROUP #self
function GROUP:RouteRTB(RTBAirbase, Speed) end

---Turns the AI Off for the GROUP.
---
------
---@return GROUP #The GROUP.
function GROUP:SetAIOff() end

---Turns the AI On for the GROUP.
---
------
---@return GROUP #The GROUP.
function GROUP:SetAIOn() end

---Turns the AI On or Off for the GROUP.
---
------
---@param AIOnOff boolean The value true turns the AI On, the value false turns the AI Off.
---@return GROUP #The GROUP.
function GROUP:SetAIOnOff(AIOnOff) end

---Set a GROUP to act as recovery tanker
---
------
---@param CarrierGroup GROUP 
---@param Speed number Speed in knots.
---@param ToKIAS boolean If true, adjust speed to altitude (KIAS).
---@param Altitude number Altitude the tanker orbits at in feet.
---@param Delay? number (optional) Set the task after this many seconds. Defaults to one.
---@param LastWaypoint? number (optional) Waypoint number of carrier group that when reached, ends the recovery tanker task.
---@return GROUP #self
function GROUP:SetAsRecoveryTanker(CarrierGroup, Speed, ToKIAS, Altitude, Delay, LastWaypoint) end

---Switch on/off immortal flag for the group.
---
------
---@param switch boolean If true, Immortal is enabled. If false, Immortal is disabled.
---@return GROUP #self
function GROUP:SetCommandImmortal(switch) end

---Switch on/off invisible flag for the group.
---
------
---@param switch boolean If true, Invisible is enabled. If false, Invisible is disabled.
---@return GROUP #self
function GROUP:SetCommandInvisible(switch) end

---Sets the CoalitionID of the group in a Template.
---
------
---@param CoalitionID coalition.side The coalition ID.
---@param Template NOTYPE 
---@return table #
function GROUP:SetTemplateCoalition(CoalitionID, Template) end

---Sets the controlled status in a Template.
---
------
---@param Controlled boolean true is controlled, false is uncontrolled.
---@param Template NOTYPE 
---@return table #
function GROUP:SetTemplateControlled(Controlled, Template) end

---Sets the CountryID of the group in a Template.
---
------
---@param CountryID country.id The country ID.
---@param Template NOTYPE 
---@return table #
function GROUP:SetTemplateCountry(CountryID, Template) end

---Respawn the Wrapper.Group at a Core.Point#COORDINATE.
---The method will setup the new group template according the Init(Respawn) settings provided for the group.
---These settings can be provided by calling the relevant Init...() methods of the Group prior.
---
---  - #GROUP.InitHeading: Set the heading for the units in degrees within the respawned group.
---  - #GROUP.InitHeight: Set the height for the units in meters for the respawned group. (This is applicable for air units).
---  - #GROUP.InitRandomizeHeading: Randomize the headings for the units within the respawned group.
---  - #GROUP.InitRandomizePositionZone: Randomize the positions of the units of the respawned group within the Core.Zone.
---  - #GROUP.InitRandomizePositionRadius: Randomize the positions of the units of the respawned group in a circle band.
---
---Notes:
---
---  - When no coordinate is given, the position of the respawned group will be its current position.
---  - The current alive group will always be destroyed first.
---  - The new group will have all of its original units and health restored.
---
------
---@param Coordinate COORDINATE Where to respawn the group. Can be handed as a @{Core.Zone#ZONE_BASE} object.
---@return GROUP #self
function GROUP:Teleport(Coordinate) end

---UnSubscribe to a DCS event.
---
------
---@param Event EVENTS 
---@return GROUP #
function GROUP:UnHandleEvent(Event) end


---Generalized group attributes.
---See [DCS attributes](https://wiki.hoggitworld.com/view/DCS_enum_attributes) on hoggit.
---@class GROUP.Attribute 
---@field AIR_ATTACKHELO string Attack helicopter.
---@field AIR_AWACS string Airborne Early Warning and Control System.
---@field AIR_BOMBER string Aircraft which can be used for strategic bombing.
---@field AIR_FIGHTER string Fighter, interceptor, ... airplane.
---@field AIR_OTHER string Any airborne unit that does not fall into any other airborne category.
---@field AIR_TANKER string Airplane which can refuel other aircraft.
---@field AIR_TRANSPORTHELO string Helicopter with transport capability. This can be used to transport other assets.
---@field AIR_TRANSPORTPLANE string Airplane with transport capability. This can be used to transport other assets.
---@field AIR_UAV string Unpiloted Aerial Vehicle, e.g. drones.
---@field GROUND_AAA string Anti-Aircraft Artillery.
---@field GROUND_APC string Infantry carriers, in particular Amoured Personell Carrier. This can be used to transport other assets.
---@field GROUND_ARTILLERY string Artillery assets.
---@field GROUND_EWR string Early Warning Radar.
---@field GROUND_IFV string Ground Infantry Fighting Vehicle.
---@field GROUND_INFANTRY string Ground infantry assets.
---@field GROUND_OTHER string Any ground unit that does not fall into any other ground category.
---@field GROUND_SAM string Surface-to-Air Missile system or components.
---@field GROUND_TANK string Tanks (modern or old).
---@field GROUND_TRAIN string Trains. Not that trains are **not** yet properly implemented in DCS and cannot be used currently.
---@field GROUND_TRUCK string Unarmed ground vehicles, which has the DCS "Truck" attribute.
---@field NAVAL_AIRCRAFTCARRIER string Aircraft carrier.
---@field NAVAL_ARMEDSHIP string Any armed ship that is not an aircraft carrier, a cruiser, destroyer, firgatte or corvette.
---@field NAVAL_OTHER string Any naval unit that does not fall into any other naval category.
---@field NAVAL_UNARMEDSHIP string Any unarmed naval vessel.
---@field NAVAL_WARSHIP string War ship, i.e. cruisers, destroyers, firgates and corvettes.
---@field OTHER_UNKNOWN string Anything that does not fall into any other category.
GROUP.Attribute = {}


---Enumerator for location at airbases
---@class GROUP.Takeoff 
---@field Air number 
---@field Cold number 
---@field Hot number 
---@field Runway number 
GROUP.Takeoff = {}



