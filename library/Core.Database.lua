---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Core_Database.JPG" width="100%">
---
---**Core** - Manages several databases containing templates, mission objects, and mission information.
---
---===
---
---## Features:
---
---  * During mission startup, scan the mission environment, and create / instantiate intelligently the different objects as defined within the mission.
---  * Manage database of DCS Group templates (as modelled using the mission editor).
---    - Group templates.
---    - Unit templates.
---    - Statics templates.
---  * Manage database of Wrapper.Group#GROUP objects alive in the mission.
---  * Manage database of Wrapper.Unit#UNIT objects alive in the mission.
---  * Manage database of Wrapper.Static#STATIC objects alive in the mission.
---  * Manage database of players.
---  * Manage database of client slots defined using the mission editor.
---  * Manage database of airbases on the map, and from FARPs and ships as defined using the mission editor.
---  * Manage database of countries.
---  * Manage database of zone names.
---  * Manage database of hits to units and statics.
---  * Manage database of destroys of units and statics.
---  * Manage database of Core.Zone#ZONE_BASE objects.
---  * Manage database of Wrapper.DynamicCargo#DYNAMICCARGO objects alive in the mission.
---
---===
---
---### Author: **FlightControl**
---### Contributions: **funkyfranky**
---
---===
---Contains collections of wrapper objects defined within MOOSE that reflect objects within the simulator.
---
---Mission designers can use the DATABASE class to refer to:
---
--- * STATICS
--- * UNITS
--- * GROUPS
--- * CLIENTS
--- * AIRBASES
--- * PLAYERSJOINED
--- * PLAYERS
--- * CARGOS
--- * STORAGES (DCS warehouses)
--- * DYNAMICCARGO
---
---On top, for internal MOOSE administration purposes, the DATABASE administers the Unit and Group TEMPLATES as defined within the Mission Editor.
---
---The singleton object **_DATABASE** is automatically created by MOOSE, that administers all objects within the mission.
---Moose refers to **_DATABASE** within the framework extensively, but you can also refer to the _DATABASE object within your missions if required.
---@class DATABASE : BASE
---@field CLIENTS table Clients.
---@field ClassName string Name of the class.
---@field DYNAMICCARGO table Dynamic Cargo objects.
---@field SADL table Used Link16 octal numbers for A10/C-II planes.
---@field STNS table Used Link16 octal numbers for F16/15/18/AWACS planes.
---@field STORAGES table DCS warehouse storages.
---@field Templates table Templates: Units, Groups, Statics, ClientsByName, ClientsByID.
---@field UNITS_Position number 
DATABASE = {}

---Account the destroys.
---
------
---@param Event EVENTDATA 
function DATABASE:AccountDestroys(Event) end

---Account the Hits of the Players.
---
------
---@param Event EVENTDATA 
function DATABASE:AccountHits(Event) end

---Adds a Airbase based on the Airbase Name in the DATABASE.
---
------
---@param AirbaseName string The name of the airbase.
---@return AIRBASE #Airbase object.
function DATABASE:AddAirbase(AirbaseName) end

---Adds a Cargo based on the Cargo Name in the DATABASE.
---
------
---@param CargoName string The name of the airbase
---@param Cargo NOTYPE 
function DATABASE:AddCargo(CargoName, Cargo) end

---Adds a CLIENT based on the ClientName in the DATABASE.
---
------
---@param ClientName string Name of the Client unit.
---@param Force? boolean (optional) Force registration of client.
---@return CLIENT #The client object.
function DATABASE:AddClient(ClientName, Force) end

---Add a DynamicCargo to the database.
---
------
---@param Name string Name of the dynamic cargo.
---@return DYNAMICCARGO #The dynamic cargo object.
function DATABASE:AddDynamicCargo(Name) end

---Add a flight control to the data base.
---
------
---@param flightcontrol FLIGHTCONTROL 
function DATABASE:AddFlightControl(flightcontrol) end

---Adds a GROUP based on the GroupName in the DATABASE.
---
------
---@param GroupName string 
---@param force boolean 
---@return GROUP #The Group
function DATABASE:AddGroup(GroupName, force) end

---Add an OPS group (FLIGHTGROUP, ARMYGROUP, NAVYGROUP) to the data base.
---
------
---@param opsgroup OPSGROUP The OPS group added to the DB.
function DATABASE:AddOpsGroup(opsgroup) end

---Adds a Ops.OpsZone#OPSZONE based on the zone name in the DATABASE.
---
------
---@param OpsZone OPSZONE The zone.
function DATABASE:AddOpsZone(OpsZone) end

---Adds a Core.Pathline based on its name in the DATABASE.
---
------
---@param PathlineName string The name of the pathline
---@param Pathline PATHLINE The pathline.
function DATABASE:AddPathline(PathlineName, Pathline) end

---Adds a player based on the Player Name in the DATABASE.
---
------
---@param UnitName NOTYPE 
---@param PlayerName NOTYPE 
function DATABASE:AddPlayer(UnitName, PlayerName) end

---Adds a Static based on the Static Name in the DATABASE.
---
------
---@param DCSStaticName string Name of the static.
---@return STATIC #The static object.
function DATABASE:AddStatic(DCSStaticName) end

---Adds a STORAGE (DCS warehouse wrapper) based on the Airbase Name to the DATABASE.
---
------
---@param AirbaseName string The name of the airbase.
---@return STORAGE #Storage object.
function DATABASE:AddStorage(AirbaseName) end

---Adds a Unit based on the Unit Name in the DATABASE.
---
------
---@param DCSUnitName string Unit name.
---@param force boolean 
---@return UNIT #The added unit.
function DATABASE:AddUnit(DCSUnitName, force) end

---Adds a Core.Zone based on the zone name in the DATABASE.
---
------
---@param ZoneName string The name of the zone.
---@param Zone ZONE_BASE The zone.
function DATABASE:AddZone(ZoneName, Zone) end

---Adds a Core.Zone based on the zone name in the DATABASE.
---
------
---@param ZoneName string The name of the zone.
---@param Zone ZONE_BASE The zone.
function DATABASE:AddZoneGoal(ZoneName, Zone) end

---Deletes a Airbase from the DATABASE based on the Airbase Name.
---
------
---@param AirbaseName string The name of the airbase
function DATABASE:DeleteAirbase(AirbaseName) end

---Deletes a Cargo from the DATABASE based on the Cargo Name.
---
------
---@param CargoName string The name of the airbase
function DATABASE:DeleteCargo(CargoName) end

---Deletes a DYNAMICCARGO from the DATABASE based on the Dynamic Cargo Name.
---
------
---@param DynamicCargoName NOTYPE 
function DATABASE:DeleteDynamicCargo(DynamicCargoName) end

---Deletes a Ops.OpsZone#OPSZONE from the DATABASE based on the zone name.
---
------
---@param ZoneName string The name of the zone.
function DATABASE:DeleteOpsZone(ZoneName) end

---Deletes a Core.Pathline from the DATABASE based on its name.
---
------
---@param PathlineName string The name of the PATHLINE.
function DATABASE:DeletePathline(PathlineName) end

---Deletes a player from the DATABASE based on the Player Name.
---
------
---@param UnitName NOTYPE 
---@param PlayerName NOTYPE 
function DATABASE:DeletePlayer(UnitName, PlayerName) end

---Deletes a Static from the DATABASE based on the Static Name.
---
------
---@param DCSStaticName NOTYPE 
function DATABASE:DeleteStatic(DCSStaticName) end

---Deletes a STORAGE from the DATABASE based on the name of the associated airbase.
---
------
---@param AirbaseName string The name of the airbase.
function DATABASE:DeleteStorage(AirbaseName) end

---Deletes a Unit from the DATABASE based on the Unit Name.
---
------
---@param DCSUnitName NOTYPE 
function DATABASE:DeleteUnit(DCSUnitName) end

---Deletes a Core.Zone from the DATABASE based on the zone name.
---
------
---@param ZoneName string The name of the zone.
function DATABASE:DeleteZone(ZoneName) end

---Deletes a Core.Zone from the DATABASE based on the zone name.
---
------
---@param ZoneName string The name of the zone.
function DATABASE:DeleteZoneGoal(ZoneName) end

---Finds an AIRBASE based on the AirbaseName.
---
------
---@param AirbaseName string 
---@return AIRBASE #The found AIRBASE.
function DATABASE:FindAirbase(AirbaseName) end

---Finds an CARGO based on the CargoName.
---
------
---@param CargoName string 
---@return CARGO #The found CARGO.
function DATABASE:FindCargo(CargoName) end

---Finds a CLIENT based on the ClientName.
---
------
---@param ClientName string - Note this is the UNIT name of the client!
---@return CLIENT #The found CLIENT.
function DATABASE:FindClient(ClientName) end

---Finds a DYNAMICCARGO based on the Dynamic Cargo Name.
---
------
---@param DynamicCargoName string 
---@return DYNAMICCARGO #The found DYNAMICCARGO.
function DATABASE:FindDynamicCargo(DynamicCargoName) end

---Finds a GROUP based on the GroupName.
---
------
---@param GroupName string 
---@return GROUP #The found GROUP.
function DATABASE:FindGroup(GroupName) end

---Find an OPSGROUP (FLIGHTGROUP, ARMYGROUP, NAVYGROUP) in the data base.
---
------
---@param groupname string Group name of the group. Can also be passed as GROUP object.
---@return OPSGROUP #OPS group object.
function DATABASE:FindOpsGroup(groupname) end

---Find an OPSGROUP (FLIGHTGROUP, ARMYGROUP, NAVYGROUP) in the data base for a given unit.
---
------
---@param unitname string Unit name. Can also be passed as UNIT object.
---@return OPSGROUP #OPS group object.
function DATABASE:FindOpsGroupFromUnit(unitname) end

---Finds a Ops.OpsZone#OPSZONE based on the zone name.
---
------
---@param ZoneName string The name of the zone.
---@return OPSZONE #The found OPSZONE.
function DATABASE:FindOpsZone(ZoneName) end

---Finds a Core.Pathline by its name.
---
------
---@param PathlineName string The name of the Pathline.
---@return PATHLINE #The found PATHLINE.
function DATABASE:FindPathline(PathlineName) end

---Finds a STATIC based on the Static Name.
---
------
---@param StaticName string Name of the static object.
---@return STATIC #The found STATIC.
function DATABASE:FindStatic(StaticName) end

---Finds an STORAGE based on the name of the associated airbase.
---
------
---@param AirbaseName string Name of the airbase.
---@return STORAGE #The found STORAGE.
function DATABASE:FindStorage(AirbaseName) end

---Finds a Unit based on the Unit Name.
---
------
---@param UnitName string 
---@return UNIT #The found Unit.
function DATABASE:FindUnit(UnitName) end

---Finds a Core.Zone based on the zone name.
---
------
---@param ZoneName string The name of the zone.
---@return ZONE_BASE #The found ZONE.
function DATABASE:FindZone(ZoneName) end

---Finds a Core.Zone based on the zone name.
---
------
---@param ZoneName string The name of the zone.
---@return ZONE_BASE #The found ZONE.
function DATABASE:FindZoneGoal(ZoneName) end

---Iterate the DATABASE and call an iterator function for the given set, providing the Object for each element within the set and optional parameters.
---
------
---@param IteratorFunction function The function that will be called when there is an alive player in the database.
---@param FinalizeFunction NOTYPE 
---@param arg NOTYPE 
---@param Set NOTYPE 
---@return DATABASE #self
function DATABASE:ForEach(IteratorFunction, FinalizeFunction, arg, Set) end

---Iterate the DATABASE and call an iterator function for each CARGO, providing the CARGO object to the function and optional parameters.
---
------
---@param IteratorFunction function The function that will be called for each object in the database. The function needs to accept a CLIENT parameter.
---@param FinalizeFunction NOTYPE 
---@param ... NOTYPE 
---@return DATABASE #self
function DATABASE:ForEachCargo(IteratorFunction, FinalizeFunction, ...) end

---Iterate the DATABASE and call an iterator function for each CLIENT, providing the CLIENT to the function and optional parameters.
---
------
---@param IteratorFunction function The function that will be called object in the database. The function needs to accept a CLIENT parameter.
---@param FinalizeFunction NOTYPE 
---@param ... NOTYPE 
---@return DATABASE #self
function DATABASE:ForEachClient(IteratorFunction, FinalizeFunction, ...) end

---Iterate the DATABASE and call an iterator function for each **alive** GROUP, providing the GROUP and optional parameters.
---
------
---@param IteratorFunction function The function that will be called for each object in the database. The function needs to accept a GROUP parameter.
---@param FinalizeFunction NOTYPE 
---@param ... NOTYPE 
---@return DATABASE #self
function DATABASE:ForEachGroup(IteratorFunction, FinalizeFunction, ...) end

---Iterate the DATABASE and call an iterator function for each **ALIVE** player, providing the player name and optional parameters.
---
------
---@param IteratorFunction function The function that will be called for each object in the database. The function needs to accept the player name.
---@param FinalizeFunction NOTYPE 
---@param ... NOTYPE 
---@return DATABASE #self
function DATABASE:ForEachPlayer(IteratorFunction, FinalizeFunction, ...) end

---Iterate the DATABASE and call an iterator function for each player who has joined the mission, providing the Unit of the player and optional parameters.
---
------
---@param IteratorFunction function The function that will be called for each object in the database. The function needs to accept a UNIT parameter.
---@param FinalizeFunction NOTYPE 
---@param ... NOTYPE 
---@return DATABASE #self
function DATABASE:ForEachPlayerJoined(IteratorFunction, FinalizeFunction, ...) end

---Iterate the DATABASE and call an iterator function for each **ALIVE** player UNIT, providing the player UNIT and optional parameters.
---
------
---@param IteratorFunction function The function that will be called for each object in the database. The function needs to accept the player name.
---@param FinalizeFunction NOTYPE 
---@param ... NOTYPE 
---@return DATABASE #self
function DATABASE:ForEachPlayerUnit(IteratorFunction, FinalizeFunction, ...) end

---Iterate the DATABASE and call an iterator function for each **alive** STATIC, providing the STATIC and optional parameters.
---
------
---@param IteratorFunction function The function that will be called for each object in the database. The function needs to accept a STATIC parameter.
---@param FinalizeFunction NOTYPE 
---@param ... NOTYPE 
---@return DATABASE #self
function DATABASE:ForEachStatic(IteratorFunction, FinalizeFunction, ...) end

---Iterate the DATABASE and call an iterator function for each **alive** UNIT, providing the UNIT and optional parameters.
---
------
---@param IteratorFunction function The function that will be called for each object in the database. The function needs to accept a UNIT parameter.
---@param FinalizeFunction NOTYPE 
---@param ... NOTYPE 
---@return DATABASE #self
function DATABASE:ForEachUnit(IteratorFunction, FinalizeFunction, ...) end

---Get category from airbase name.
---
------
---@param AirbaseName string Name of the airbase.
---@return number #Category.
function DATABASE:GetCategoryFromAirbase(AirbaseName) end

---Get category ID from client name.
---
------
---@param ClientName string Name of the Client.
---@return number #Category ID.
function DATABASE:GetCategoryFromClientTemplate(ClientName) end

---Get coalition ID from airbase name.
---
------
---@param AirbaseName string Name of the airbase.
---@return number #Coalition ID.
function DATABASE:GetCoalitionFromAirbase(AirbaseName) end

---Get coalition ID from client name.
---
------
---@param ClientName string Name of the Client.
---@return number #Coalition ID.
function DATABASE:GetCoalitionFromClientTemplate(ClientName) end

---Get country ID from client name.
---
------
---@param ClientName string Name of the Client.
---@return number #Country ID.
function DATABASE:GetCountryFromClientTemplate(ClientName) end

---Get a flight control object from the data base.
---
------
---@param airbasename string Name of the associated airbase.
---@return FLIGHTCONTROL #The FLIGHTCONTROL object.s
function DATABASE:GetFlightControl(airbasename) end

---Get group name from unit name.
---
------
---@param UnitName string Name of the unit.
---@return string #Group name.
function DATABASE:GetGroupNameFromUnitName(UnitName) end

---Get group template.
---
------
---@param GroupName string Group name.
---@return table #Group template table.
function DATABASE:GetGroupTemplate(GroupName) end

---Get group template from unit name.
---
------
---@param UnitName string Name of the unit.
---@return table #Group template.
function DATABASE:GetGroupTemplateFromUnitName(UnitName) end

---Get next (consecutive) free SADL as octal number.
---
------
---@param octal number Starting octal.
---@param unitname string Name of the associated unit.
---@return number #Octal
function DATABASE:GetNextSADL(octal, unitname) end

---Get next (consecutive) free STN as octal number.
---
------
---@param octal number Starting octal.
---@param unitname string Name of the associated unit.
---@return number #Octal
function DATABASE:GetNextSTN(octal, unitname) end

---Get an OPS group (FLIGHTGROUP, ARMYGROUP, NAVYGROUP) from the data base.
---
------
---@param groupname string Group name of the group. Can also be passed as GROUP object.
---@return OPSGROUP #OPS group object.
function DATABASE:GetOpsGroup(groupname) end

---Gets the player settings
---
------
---@param PlayerName string 
---@return SETTINGS #
function DATABASE:GetPlayerSettings(PlayerName) end

---Get the player table from the DATABASE, which contains all UNIT objects.
---The player table contains all UNIT objects of the player with the key the name of the player (PlayerName).
---
------
---
---USAGE
---```
---  local PlayerUnits = _DATABASE:GetPlayerUnits()
---  for PlayerName, PlayerUnit in pairs( PlayerUnits ) do
---    ..
---  end
---```
------
function DATABASE:GetPlayerUnits() end

---Get the player table from the DATABASE.
---The player table contains all unit names with the key the name of the player (PlayerName).
---
------
---
---USAGE
---```
---  local Players = _DATABASE:GetPlayers()
---  for PlayerName, UnitName in pairs( Players ) do
---    ..
---  end
---```
------
function DATABASE:GetPlayers() end

---Get the player table from the DATABASE which have joined in the mission historically.
---The player table contains all UNIT objects with the key the name of the player (PlayerName).
---
------
---
---USAGE
---```
---  local PlayersJoined = _DATABASE:GetPlayersJoined()
---  for PlayerName, PlayerUnit in pairs( PlayersJoined ) do
---    ..
---  end
---```
------
function DATABASE:GetPlayersJoined() end

---Get static group template.
---
------
---@param StaticName string Name of the static.
---@return table #Static template table.
function DATABASE:GetStaticGroupTemplate(StaticName) end

---Get static unit template.
---
------
---@param StaticName string Name of the static.
---@return table #Static template table.
function DATABASE:GetStaticUnitTemplate(StaticName) end

---Get a status to a Group within the Database, this to check crossing events for example.
---
------
---@param GroupName string Group name.
---@return string #Status or an empty string "".
function DATABASE:GetStatusGroup(GroupName) end

---Get group template from unit name.
---
------
---@param UnitName string Name of the unit.
---@return table #Group template.
function DATABASE:GetUnitTemplateFromUnitName(UnitName) end

---Checks if the Template name has a #CARGO tag.
---If yes, the group is a cargo.
---
------
---@param TemplateName string 
---@return boolean #
function DATABASE:IsCargo(TemplateName) end

---Creates a new DATABASE object, building a set of units belonging to a coalitions, categories, countries, types or with defined prefix names.
---
------
---
---USAGE
---```
----- Define a new DATABASE Object. This DBObject will contain a reference to all Group and Unit Templates defined within the ME and the DCSRTE.
---DBObject = DATABASE:New()
---```
------
---@return DATABASE #
function DATABASE:New() end

---Handles the OnEventDeleteCargo.
---
------
---@param EventData EVENTDATA 
function DATABASE:OnEventDeleteCargo(EventData) end

---Handles the OnEventDeleteZone.
---
------
---@param EventData EVENTDATA 
function DATABASE:OnEventDeleteZone(EventData) end

---Handles the OnEventNewCargo event.
---
------
---@param EventData EVENTDATA 
function DATABASE:OnEventNewCargo(EventData) end

---Handles the OnEventNewZone event.
---
------
---@param EventData EVENTDATA 
function DATABASE:OnEventNewZone(EventData) end

---Sets the player settings
---
------
---@param PlayerName string 
---@param Settings SETTINGS 
---@return SETTINGS #
function DATABASE:SetPlayerSettings(PlayerName, Settings) end

---Set a status to a Group within the Database, this to check crossing events for example.
---
------
---@param GroupName string Group name.
---@param Status string Status.
function DATABASE:SetStatusGroup(GroupName, Status) end

---Instantiate new Groups within the DCSRTE.
---This method expects EXACTLY the same structure as a structure within the ME, and needs 2 additional fields defined:
---SpawnCountryID, SpawnCategoryID
---This method is used by the SPAWN class.
---
------
---@param SpawnTemplate table Template of the group to spawn.
---@return GROUP #Spawned group.
function DATABASE:Spawn(SpawnTemplate) end

---Handles the OnBirth event for the alive units set.
---
------
---@param Event EVENTDATA 
function DATABASE:_EventOnBirth(Event) end

---Handles the OnDead or OnCrash event for alive units set.
---
------
---@param Event EVENTDATA 
function DATABASE:_EventOnDeadOrCrash(Event) end

---Handles the OnDynamicCargoRemoved event to clean the active dynamic cargo table.
---
------
---@param Event EVENTDATA 
function DATABASE:_EventOnDynamicCargoRemoved(Event) end

---Handles the OnPlayerEnterUnit event to fill the active players table for CA units (with the unit filter applied).
---
------
---@param Event EVENTDATA 
function DATABASE:_EventOnPlayerEnterUnit(Event) end

---Handles the OnPlayerLeaveUnit event to clean the active players table.
---
------
---@param Event EVENTDATA 
function DATABASE:_EventOnPlayerLeaveUnit(Event) end

---Get a PlayerName by UnitName from PLAYERS in DATABASE.
---
------
---@param UnitName NOTYPE 
---@return string #PlayerName
---@return UNIT #PlayerUnit
function DATABASE:_FindPlayerNameByUnitName(UnitName) end

---Get a generic static cargo group template from scratch for dynamic cargo spawns register.
---Does not register the template!
---
------
---@param Name string Name of the static.
---@param Typename string Typename of the static. Defaults to "container_cargo".
---@param Mass number Mass of the static. Defaults to 0.
---@param Coalition number Coalition of the static. Defaults to coalition.side.BLUE.
---@param Country number Country of the static. Defaults to country.id.GERMANY.
---@return table #Static template table.
function DATABASE:_GetGenericStaticCargoGroupTemplate(Name, Typename, Mass, Coalition, Country) end

---Register a DCS airbase.
---
------
---@param airbase Airbase Airbase.
---@return DATABASE #self
function DATABASE:_RegisterAirbase(airbase) end

---Register all world airbases.
---
------
---@return DATABASE #self
function DATABASE:_RegisterAirbases() end

---Private method that registers new Static Templates within the DATABASE Object.
---
------
---@return DATABASE #self
function DATABASE:_RegisterCargos() end

---Private method that registers all Units of skill Client or Player within in the mission.
---
------
---@return DATABASE #self
function DATABASE:_RegisterClients() end

---Private method that registers a single dynamic slot Group and Units within in the mission.
---
------
---@param Groupname NOTYPE 
---@return DATABASE #self
function DATABASE:_RegisterDynamicGroup(Groupname) end

---Private method that registers new Group Templates within the DATABASE Object.
---
------
---@param GroupTemplate table 
---@param CoalitionSide coalition.side The coalition.side of the object.
---@param CategoryID Object.Category The Object.category of the object.
---@param CountryID country.id the country ID of the object.
---@param GroupName? string (Optional) The name of the group. Default is `GroupTemplate.name`.
---@return DATABASE #self
function DATABASE:_RegisterGroupTemplate(GroupTemplate, CoalitionSide, CategoryID, CountryID, GroupName) end

---Private method that registers all Groups and Units within in the mission.
---
------
---@return DATABASE #self
function DATABASE:_RegisterGroupsAndUnits() end

---Private method that registers all alive players in the mission.
---
------
---@return DATABASE #self
function DATABASE:_RegisterPlayers() end

---Private method that registers new Static Templates within the DATABASE Object.
---
------
---@param StaticTemplate table Template table.
---@param CoalitionID number Coalition ID.
---@param CategoryID number Category ID.
---@param CountryID number Country ID.
---@return DATABASE #self
function DATABASE:_RegisterStaticTemplate(StaticTemplate, CoalitionID, CategoryID, CountryID) end

---Private method that registeres all static objects.
---
------
function DATABASE:_RegisterStatics() end


---
------
function DATABASE:_RegisterTemplates() end

---Private method that registers new ZONE_BASE derived objects within the DATABASE Object.
---
------
---@return DATABASE #self
function DATABASE:_RegisterZones() end



