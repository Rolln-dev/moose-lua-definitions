---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Core_Spawnstatic.JPG" width="100%">
---
---**Core** - Spawn statics.
---
---===
---
---## Features:
---
---  * Spawn new statics from a static already defined in the mission editor.
---  * Spawn new statics from a given template.
---  * Spawn new statics from a given type.
---  * Spawn with a custom heading and location.
---  * Spawn within a zone.
---  * Spawn statics linked to units, .e.g on aircraft carriers.
---
---===
---
---# Demo Missions
---
---## [SPAWNSTATIC Demo Missions](https://github.com/FlightControl-Master/MOOSE_Demos/tree/master/Core/SpawnStatic)
---
---
---===
---
---# YouTube Channel
---
---## No videos yet!
---
---===
---
---### Author: **FlightControl**
---### Contributions: **funkyfranky**
---
---===
---Allows to spawn dynamically new Wrapper.Statics into your mission.
---
---Through creating a copy of an existing static object template as defined in the Mission Editor (ME), SPAWNSTATIC can retireve the properties of the defined static object template (like type, category etc),
---and "copy" these properties to create a new static object and place it at the desired coordinate.
---
---New spawned Wrapper.Statics get **the same name** as the name of the template Static, or gets the given name when a new name is provided at the Spawn method.
---By default, spawned Wrapper.Statics will follow a naming convention at run-time:
---
---  * Spawned Wrapper.Statics will have the name _StaticName_#_nnn_, where _StaticName_ is the name of the **Template Static**, and _nnn_ is a **counter from 0 to 99999**.
---
---# SPAWNSTATIC Constructors
---
---Firstly, we need to create a SPAWNSTATIC object that will be used to spawn new statics into the mission. There are three ways to do this.
---
---## Use another Static
---
---A new SPAWNSTATIC object can be created using another static by the #SPAWNSTATIC.NewFromStatic() function. All parameters such as position, heading, country will be initialized
---from the static.
---
---## From a Template
---
---A SPAWNSTATIC object can also be created from a template table using the #SPAWNSTATIC.NewFromTemplate(SpawnTemplate, CountryID) function. All parameters are taken from the template.
---
---## From a Type
---
---A very basic method is to create a SPAWNSTATIC object by just giving the type of the static. All parameters must be initialized from the InitXYZ functions described below. Otherwise default values
---are used. For example, if no spawn coordinate is given, the static will be created at the origin of the map.
---
---# Setting Parameters
---
---Parameters such as the spawn position, heading, country etc. can be set via :Init*XYZ* functions. Note that these functions must be given before the actual spawn command!
---
---  * #SPAWNSTATIC.InitCoordinate(Coordinate) Sets the coordinate where the static is spawned. Statics are always spawnd on the ground.
---  * #SPAWNSTATIC.InitHeading(Heading) sets the orientation of the static.
---  * #SPAWNSTATIC.InitLivery(LiveryName) sets the livery of the static. Not all statics support this.
---  * #SPAWNSTATIC.InitType(StaticType) sets the type of the static.
---  * #SPAWNSTATIC.InitShape(StaticType) sets the shape of the static. Not all statics have this parameter.
---  * #SPAWNSTATIC.InitNamePrefix(NamePrefix) sets the name prefix of the spawned statics.
---  * #SPAWNSTATIC.InitCountry(CountryID) sets the country and therefore the coalition of the spawned statics.
---  * #SPAWNSTATIC.InitLinkToUnit(Unit, OffsetX, OffsetY, OffsetAngle) links the static to a unit, e.g. to an aircraft carrier.
---
---# Spawning the Statics
---
---Once the SPAWNSTATIC object is created and parameters are initialized, the spawn command can be given. There are different methods where some can be used to directly set parameters
---such as position and heading.
---
---  * #SPAWNSTATIC.Spawn(Heading, NewName) spawns the static with the set parameters. Optionally, heading and name can be given. The name **must be unique**!
---  * #SPAWNSTATIC.SpawnFromCoordinate(Coordinate, Heading, NewName) spawn the static at the given coordinate. Optionally, heading and name can be given. The name **must be unique**!
---  * #SPAWNSTATIC.SpawnFromPointVec2(PointVec2, Heading, NewName) spawns the static at a COORDINATE coordinate. Optionally, heading and name can be given. The name **must be unique**!
---  * #SPAWNSTATIC.SpawnFromZone(Zone, Heading, NewName) spawns the static at the center of a Core.Zone. Optionally, heading and name can be given. The name **must be unique**!
---@class SPAWNSTATIC : BASE
---@field CategoryID number Category ID.
---@field CoalitionID number Coalition ID.
---@field CountryID number Country ID.
---@field InitFarp boolean 
---@field InitLinkUnit UNIT The unit the static is linked to.
---@field InitOffsetAngle number Link offset angle in degrees.
---@field InitOffsetX number Link offset X coordinate.
---@field InitOffsetY number Link offset Y coordinate.
---@field InitStaticCargo boolean If true, static can act as cargo.
---@field InitStaticCargoMass number Mass of cargo in kg.
---@field InitStaticCategory string Categrory of the static.
---@field InitStaticCoordinate COORDINATE Coordinate where to spawn the static.
---@field InitStaticDead boolean Set static to be dead if true.
---@field InitStaticHeading number Heading of the static.
---@field InitStaticLivery string Livery for aircraft.
---@field InitStaticName string Name of the static.
---@field InitStaticShape string Shape of the static.
---@field InitStaticType string Type of the static.
---@field SpawnFunctionArguments table 
---@field SpawnFunctionHook NOTYPE 
---@field SpawnIndex number Running number increased with each new Spawn.
---@field SpawnTemplatePrefix string Name of the template group.
---@field TemplateStaticUnit table 
---@field private heliport_callsign_id NOTYPE 
---@field private heliport_frequency NOTYPE 
---@field private heliport_modulation NOTYPE 
SPAWNSTATIC = {}

---(User/Cargo) Add to resource table for STATIC object that should be spawned containing storage objects.
---Inits the object table if necessary and sets it to be cargo for helicopters.
---
------
---@param self SPAWNSTATIC 
---@param Type string Type of cargo. Known types are: STORAGE.Type.WEAPONS, STORAGE.Type.LIQUIDS, STORAGE.Type.AIRCRAFT. Liquids are fuel.
---@param Name string Name of the cargo type. Liquids can be STORAGE.LiquidName.JETFUEL, STORAGE.LiquidName.GASOLINE, STORAGE.LiquidName.MW50 and STORAGE.LiquidName.DIESEL. The currently available weapon items are available in the `ENUMS.Storage.weapons`, e.g. `ENUMS.Storage.weapons.bombs.Mk_82Y`. Aircraft go by their typename.
---@param Amount number of tons (liquids) or number (everything else) to add.
---@param CombinedWeight number Combined weight to be set to this static cargo object. NOTE - some static cargo objects have fixed weights!
---@return SPAWNSTATIC #self
function SPAWNSTATIC:AddCargoResource(Type, Name, Amount, CombinedWeight) end

---Initialize as cargo.
---
------
---@param self SPAWNSTATIC 
---@param IsCargo boolean If true, this static can act as cargo.
---@return SPAWNSTATIC #self
function SPAWNSTATIC:InitCargo(IsCargo) end

---Initialize cargo mass.
---
------
---@param self SPAWNSTATIC 
---@param Mass number Mass of the cargo in kg.
---@return SPAWNSTATIC #self
function SPAWNSTATIC:InitCargoMass(Mass) end

---Initialize heading of the spawned static.
---
------
---@param self SPAWNSTATIC 
---@param Coordinate COORDINATE Position where the static is spawned.
---@return SPAWNSTATIC #self
function SPAWNSTATIC:InitCoordinate(Coordinate) end

---Initialize country of the spawned static.
---This determines the category.
---
------
---@param self SPAWNSTATIC 
---@param CountryID string The country ID, e.g. country.id.USA.
---@return SPAWNSTATIC #self
function SPAWNSTATIC:InitCountry(CountryID) end

---Initialize as dead.
---
------
---@param self SPAWNSTATIC 
---@param IsDead boolean If true, this static is dead.
---@return SPAWNSTATIC #self
function SPAWNSTATIC:InitDead(IsDead) end

---Initialize parameters for spawning FARPs.
---
------
---@param self SPAWNSTATIC 
---@param CallsignID number Callsign ID. Default 1 (="London").
---@param Frequency number Frequency in MHz. Default 127.5 MHz.
---@param Modulation number Modulation 0=AM, 1=FM.
---@return SPAWNSTATIC #self
function SPAWNSTATIC:InitFARP(CallsignID, Frequency, Modulation) end

---Initialize heading of the spawned static.
---
------
---@param self SPAWNSTATIC 
---@param Heading number The heading in degrees.
---@return SPAWNSTATIC #self
function SPAWNSTATIC:InitHeading(Heading) end

---Init link to a unit.
---
------
---@param self SPAWNSTATIC 
---@param Unit UNIT The unit to which the static is linked.
---@param OffsetX number Offset in X.
---@param OffsetY number Offset in Y.
---@param OffsetAngle number Offset angle in degrees.
---@return SPAWNSTATIC #self
function SPAWNSTATIC:InitLinkToUnit(Unit, OffsetX, OffsetY, OffsetAngle) end

---Initialize livery of the spawned static.
---
------
---@param self SPAWNSTATIC 
---@param LiveryName string Name of the livery to use.
---@return SPAWNSTATIC #self
function SPAWNSTATIC:InitLivery(LiveryName) end

---Initialize name prefix statics get.
---This will be appended by "#0001", "#0002" etc.
---
------
---@param self SPAWNSTATIC 
---@param NamePrefix string Name prefix of statics spawned. Will append #0001, etc to the name.
---@return SPAWNSTATIC #self
function SPAWNSTATIC:InitNamePrefix(NamePrefix) end

---Initialize shape of the spawned static.
---Required by some but not all statics.
---
------
---@param self SPAWNSTATIC 
---@param StaticShape string Shape of the static, e.g. "carrier_tech_USA".
---@return SPAWNSTATIC #self
function SPAWNSTATIC:InitShape(StaticShape) end

---Initialize type of the spawned static.
---
------
---@param self SPAWNSTATIC 
---@param StaticType string Type of the static, e.g. "FA-18C_hornet".
---@return SPAWNSTATIC #self
function SPAWNSTATIC:InitType(StaticType) end

---Creates the main object to spawn a Wrapper.Static defined in the mission editor (ME).
---
------
---@param self SPAWNSTATIC 
---@param SpawnTemplateName string Name of the static object in the ME. Each new static will have the name starting with this prefix.
---@param SpawnCountryID? country.id (Optional) The ID of the country.
---@return SPAWNSTATIC #self
function SPAWNSTATIC:NewFromStatic(SpawnTemplateName, SpawnCountryID) end

---Creates the main object to spawn a Wrapper.Static given a template table.
---
------
---@param self SPAWNSTATIC 
---@param SpawnTemplate table Template used for spawning.
---@param CountryID country.id The ID of the country. Default `country.id.USA`.
---@return SPAWNSTATIC #self
function SPAWNSTATIC:NewFromTemplate(SpawnTemplate, CountryID) end

---Creates the main object to spawn a Wrapper.Static from a given type.
---NOTE that you have to init many other parameters as spawn coordinate etc.
---
------
---@param self SPAWNSTATIC 
---@param StaticType string Type of the static.
---@param StaticCategory string Category of the static, e.g. "Planes".
---@param CountryID country.id The ID of the country. Default `country.id.USA`.
---@return SPAWNSTATIC #self
function SPAWNSTATIC:NewFromType(StaticType, StaticCategory, CountryID) end

---Allows to place a CallFunction hook when a new static spawns.
---The provided method will be called when a new group is spawned, including its given parameters.
---The first parameter of the SpawnFunction is the Wrapper.Static#STATIC that was spawned.
---
------
---@param self SPAWNSTATIC 
---@param SpawnCallBackFunction function The function to be called when a group spawns.
---@param SpawnFunctionArguments NOTYPE A random amount of arguments to be provided to the function when the group spawns.
---@param ... NOTYPE 
---@return SPAWNSTATIC #self
function SPAWNSTATIC:OnSpawnStatic(SpawnCallBackFunction, SpawnFunctionArguments, ...) end

---(User/Cargo) Resets resource table to zero for STATIC object that should be spawned containing storage objects.
---Inits the object table if necessary and sets it to be cargo for helicopters.
---Handy if you spawn from cargo statics which have resources already set.
---
------
---@param self SPAWNSTATIC 
---@return SPAWNSTATIC #self 
function SPAWNSTATIC:ResetCargoResources() end

---Spawn a new STATIC object.
---
------
---@param self SPAWNSTATIC 
---@param Heading? number (Optional) The heading of the static, which is a number in degrees from 0 to 360. Default is the heading of the template.
---@param NewName? string (Optional) The name of the new static.
---@return STATIC #The static spawned.
function SPAWNSTATIC:Spawn(Heading, NewName) end

---Creates a new Wrapper.Static from a COORDINATE.
---
------
---@param self SPAWNSTATIC 
---@param Coordinate COORDINATE The 3D coordinate where to spawn the static.
---@param Heading? number (Optional) Heading The heading of the static in degrees. Default is 0 degrees.
---@param NewName? string (Optional) The name of the new static.
---@return STATIC #The spawned STATIC object.
function SPAWNSTATIC:SpawnFromCoordinate(Coordinate, Heading, NewName) end

---Creates a new Wrapper.Static from a COORDINATE.
---
------
---@param self SPAWNSTATIC 
---@param PointVec2 COORDINATE The 2D coordinate where to spawn the static.
---@param Heading number The heading of the static, which is a number in degrees from 0 to 360.
---@param NewName? string (Optional) The name of the new static.
---@return STATIC #The static spawned.
function SPAWNSTATIC:SpawnFromPointVec2(PointVec2, Heading, NewName) end

---Creates a new Wrapper.Static from a Core.Zone.
---
------
---@param self SPAWNSTATIC 
---@param Zone ZONE_BASE The Zone where to spawn the static.
---@param Heading? number (Optional)The heading of the static in degrees. Default is the heading of the template.
---@param NewName? string (Optional) The name of the new static.
---@return STATIC #The static spawned.
function SPAWNSTATIC:SpawnFromZone(Zone, Heading, NewName) end

---(Internal/Cargo) Init the resource table for STATIC object that should be spawned containing storage objects.
---NOTE that you have to init many other parameters as the resources.
---
------
---@param self SPAWNSTATIC 
---@param CombinedWeight number The weight this cargo object should have (some have fixed weights!), defaults to 1kg.
---@return SPAWNSTATIC #self
function SPAWNSTATIC:_InitResourceTable(CombinedWeight) end

---Spawns a new static using a given template.
---Additionally, the country ID needs to be specified, which also determines the coalition of the spawned static.
---
------
---@param self SPAWNSTATIC 
---@param Template SPAWNSTATIC.TemplateData Spawn unit template.
---@param CountryID number The country ID.
---@return STATIC #The static spawned.
function SPAWNSTATIC:_SpawnStatic(Template, CountryID) end


---Static template table data.
---@class SPAWNSTATIC.TemplateData 
---@field private alt NOTYPE 
---@field private canCargo boolean Static can be a cargo.
---@field private category string Category of the static.
---@field private dead boolean Static is dead if true.
---@field private groupId number Group ID.
---@field private heading number Heading in rad.
---@field private heliport_callsign_id NOTYPE 
---@field private heliport_frequency NOTYPE 
---@field private heliport_modulation NOTYPE 
---@field private linkOffset boolean 
---@field private linkUnit NOTYPE 
---@field private livery_id string Livery name.
---@field private mass number Cargo mass in kg.
---@field private name string Name of the static.
---@field private offsets table Offset parameters when linked to a unit.
---@field private shape_name NOTYPE 
---@field private type string Type of the static.
---@field private unitId number Unit ID.
---@field private x number X-coordinate of the static.
---@field private y number Y-coordinate of teh static.
SPAWNSTATIC.TemplateData = {}



