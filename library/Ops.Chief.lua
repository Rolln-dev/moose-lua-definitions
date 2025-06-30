---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/OPS_Chief.png" width="100%">
---
---**Ops** - Chief of Staff.
---
---**Main Features:**
---
---   * Automatic target engagement based on detection network
---   * Define multiple border, conflict and attack zones
---   * Define strategic "capture" zones 
---   * Set strategy of chief from passive to agressive
---   * Manual target engagement via AUFTRAG and TARGET classes
---   * Add AIRWINGS, BRIGADES and FLEETS as resources
---   * Seamless air-to-air, air-to-ground, ground-to-ground dispatching
---
---===
---
---### Author: **funkyfranky**
---*In preparing for battle I have always found that plans are useless, but planning is indispensable* -- Dwight D Eisenhower
---
---===
---
---# The CHIEF Concept
---
---The Chief of staff gathers INTEL and assigns missions (AUFTRAG) to the airforce, army and/or navy.
---The distinguished feature here is that this class combines all three
---forces under one hood. Therefore, this class be used as an air-to-air, air-to-ground, ground-to-ground, air-to-sea, sea-to-ground, etc. dispachter.
---
---# Territory
---
---The chief class allows you to define boarder zones, conflict zones and attack zones.
---
---## Border Zones
---
---Border zones define your own territory.
---They can be set via the #CHIEF.SetBorderZones() function as a set or added zone by zone via the #CHIEF.AddBorderZone() function.
---
---## Conflict Zones
---
---Conflict zones define areas, which usually are under dispute of different coalitions.
---They can be set via the #CHIEF.SetConflictZones() function as a set or added zone by zone via the #CHIEF.AddConflictZone() function.
---
---## Attack Zones
---
---Attack zones are zones that usually lie within the enemy territory. They are only enganged with an agressive strategy.
---They can be set via the #CHIEF.SetAttackZones() function as a set or added zone by zone via the #CHIEF.AddAttackZone() function.
---
---# Defense Condition
---
---The defence condition (DEFCON) depends on enemy activity detected in the different zone types and is set automatically.
---
---* `CHIEF.Defcon.GREEN`: No enemy activities detected.
---* `CHIEF.Defcon.YELLOW`: Enemy activity detected in conflict zones.
---* `CHIEF.Defcon.RED`: Enemy activity detected in border zones.
---
---The current DEFCON can be retrieved with the @(#CHIEF.GetDefcon)() function.
---
---When the DEFCON changed, an FSM event #CHIEF.DefconChange is triggered. Mission designers can hook into this event via the #CHIEF.OnAfterDefconChange() function:
---
---    --- Function called when the DEFCON changes.
---    function myChief:OnAfterDefconChange(From, Event, To, Defcon)
---      local text=string.format("Changed DEFCON to %s", Defcon)
---      MESSAGE:New(text, 120):ToAll()    
---    end
---
---# Strategy
---
---The strategy of the chief determines, in which areas targets are engaged automatically.
---
---* `CHIEF.Strategy.PASSIVE`: Chief is completely passive. No targets at all are engaged automatically.
---* `CHIEF.Strategy.DEFENSIVE`: Chief acts defensively. Only targets in his own territory are engaged.
---* `CHIEF.Strategy.OFFENSIVE`: Chief behaves offensively. Targets in his own territory and in conflict zones are enganged.
---* `CHIEF.Strategy.AGGRESSIVE`: Chief is aggressive. Targets in his own territory, in conflict zones and in attack zones are enganged.
---* `CHIEF.Strategy.TOTALWAR`: Anything anywhere is enganged.
---
---The strategy can be set by the @(#CHIEF.SetStrategy)() and retrieved with the @(#CHIEF.GetStrategy)() function.
---
---When the strategy is changed, the FSM event #CHIEF.StrategyChange is triggered and customized code can be added to the #CHIEF.OnAfterStrategyChange() function:
---
---    --- Function called when the STRATEGY changes.
---    function myChief:OnAfterStrategyChange(From, Event, To, Strategy)
---      local text=string.format("Strategy changd to %s", Strategy)
---      MESSAGE:New(text, 120):ToAll()
---    end
---    
---# Resources
---
---A chief needs resources such as air, ground and naval assets. These can be added in form of AIRWINGs, BRIGADEs and FLEETs.
---
---Whenever the chief detects a target or receives a mission, he will select the best available assets and assign them to the mission.
---The best assets are determined by their mission performance, payload performance (in case of air), distance to the target, skill level, etc.
---
---## Adding Airwings 
---
---Airwings can be added via the #CHIEF.AddAirwing() function.
---
---## Adding Brigades
---
---Brigades can be added via the #CHIEF.AddBrigade() function.
---
---## Adding Fleets
---
---Fleets can be added via the #CHIEF.AddFleet() function.
---
---## Response on Target
---
---When the chief detects a valid target, he will launch a certain number of selected assets. Only whole groups from SQUADRONs, PLATOONs or FLOTILLAs can be selected.
---In other words, it is not possible to specify the abount of individual *units*.
---
---By default, one group is selected for any detected target. This can, however, be customized with the #CHIEF.SetResponseOnTarget() function. The number of min and max
---asset groups can be specified depending on threatlevel, category, mission type, number of units, defcon and strategy.
---
---For example:
---
---    -- One group for aircraft targets of threat level 0 or higher.
---    myChief:SetResponseOnTarget(1, 1, 0, TARGET.Category.AIRCRAFT)
---    -- At least one and up to two groups for aircraft targets of threat level 8 or higher. This will overrule the previous response!
---    myChief:SetResponseOnTarget(1, 2, 8, TARGET.Category.AIRCRAFT)
---    
---    -- At least one and up to three groups for ground targets of threat level 0 or higher if current strategy is aggressive.  
---    myChief:SetResponseOnTarget(1, 1, 0, TARGET.Category.GROUND, nil ,nil, nil, CHIEF.Strategy.DEFENSIVE)
---    
---    -- One group for BAI missions if current defcon is green.
---    myChief:SetResponseOnTarget(1, 1, 0, nil, AUFTRAG.Type.BAI, nil, CHIEF.DEFCON.GREEN)
---    
---    -- At least one and up to four groups for BAI missions if current defcon is red.
---    myChief:SetResponseOnTarget(1, 2, 0, nil, AUFTRAG.Type.BAI, nil, CHIEF.DEFCON.YELLOW)
---    
---    -- At least one and up to four groups for BAI missions if current defcon is red.
---    myChief:SetResponseOnTarget(1, 3, 0, nil, AUFTRAG.Type.BAI, nil, CHIEF.DEFCON.RED)
---
--- 
---# Strategic (Capture) Zones
---
---Strategically important zones, which should be captured can be added via the #CHIEF.AddStrategicZone(*OpsZone, Prio, Importance*) function.
---The first parameter *OpsZone* is an Ops.OpsZone#OPSZONE specifying the zone. This has to be a **circular zone** due to DCS API restrictions.
---The second parameter *Prio* is the priority. The zone queue is sorted wrt to lower prio values. By default this is set to 50.
---The third parameter *Importance* is the importance of the zone. By default this is `nil`. If you specify one zone with importance 2 and a second zone with
---importance 3, then the zone of importance 2 is attacked first and only if that zone has been captured, zones that have importances with higher values are attacked.
---
---For example:
---
---    local myStratZone=myChief:AddStrategicZone(myOpsZone, nil , 2)
---
---Will at a strategic zone with importance 2.
---
---If the zone is currently owned by another coalition and enemy ground troops are present in the zone, a CAS and an ARTY mission are launched:
---
---* A mission of type `AUFTRAG.Type.CASENHANCED` is started if assets are available that can carry out this mission type.
---* A mission of type `AUFTRAG.Type.ARTY` is started provided assets are available.
---
---The CAS flight(s) will patrol the zone randomly and take out enemy ground units they detect. It can always be possible that the enemies cannot be detected however.
---The assets will shell the zone. However, it is unlikely that they hit anything as they do not have any information about the location of the enemies.
---
---Once the zone is cleaned of enemy forces, ground troops are send there. By default, two missions are launched:
---
---* First mission is of type `AUFTRAG.Type.ONGUARD` and will send infantry groups. These are transported by helicopters. Therefore, helo assets with `AUFTRAG.Type.OPSTRANSPORT` need to be available.
---* The second mission is also of type `AUFTRAG.Type.ONGUARD` but will send tanks if these are available.
---
---## Customized Reaction
---
---The default mission types and number of assets can be customized for the two scenarious (zone empty or zone occupied by the enemy).
---
---In order to do this, you need to create resource lists (one for each scenario) via the #CHIEF.CreateResource() function.
---These lists can than passed as additional parameters to the #CHIEF.AddStrategicZone function.
---
---For example:
---    
---    --- Create a resource list of mission types and required assets for the case that the zone is OCCUPIED.
---    --
---    -- Here, we create an enhanced CAS mission and employ at least on and at most two asset groups.
---    -- NOTE that two objects are returned, the resource list (ResourceOccupied) and the first resource of that list (resourceCAS).
---    local ResourceOccupied, resourceCAS=myChief:CreateResource(AUFTRAG.Type.CASENHANCED, 1, 2)
---    -- We also add ARTY missions with at least one and at most two assets. We additionally require these to be MLRS groups (and not howitzers).
---    myChief:AddToResource(ResourceOccupied, AUFTRAG.Type.ARTY, 1, 2, nil, "MLRS")
---    -- Add at least one RECON mission that uses UAV type assets.
---    myChief:AddToResource(ResourceOccupied, AUFTRAG.Type.RECON, 1, nil, GROUP.Attribute.AIR_UAV)
---    -- Add at least one but at most two BOMBCARPET missions.
---    myChief:AddToResource(ResourceOccupied, AUFTRAG.Type.BOMBCARPET, 1, 2)
---    
---    --- Create a resource list of mission types and required assets for the case that the zone is EMPTY.
---    -- NOTE that two objects are returned, the resource list (ResourceEmpty) and the first resource of that list (resourceInf).
---    -- Here, we create an ONGUARD mission and employ at least on and at most five infantry assets.
---    local ResourceEmpty, resourceInf=myChief:CreateResource(AUFTRAG.Type.ONGUARD, 1, 5, GROUP.Attribute.GROUND_INFANTRY)
---    -- Additionally, we send up to three tank groups.
---    myChief:AddToResource(ResourceEmpty, AUFTRAG.Type.ONGUARD, 1, 3, GROUP.Attribute.GROUND_TANK)
---    -- Finally, we send two groups that patrol the zone.
---    myChief:AddToResource(ResourceEmpty, AUFTRAG.Type.PATROLZONE, 2)
---    
---    -- Add a transport to the infantry resource. We want at least one and up to two transport helicopters.
---    myChief:AddTransportToResource(resourceInf, 1, 2, GROUP.Attribute.AIR_TRANSPORTHELO)
---    
---    -- Add stratetic zone with customized reaction.
---    myChief:AddStrategicZone(myOpsZone, nil , 2, ResourceOccupied, ResourceEmpty)
---
---As the location of the enemies is not known, only mission types that don't require an explicit target group are possible. These are
---
---* `AUFTRAG.Type.CASENHANCED`
---* `AUFTRAG.Type.ARTY`
---* `AUFTRAG.Type.PATROLZONE`
---* `AUFTRAG.Type.ONGUARD`
---* `AUFTRAG.Type.CAPTUREZONE`
---* `AUFTRAG.Type.RECON`
---* `AUFTRAG.Type.AMMOSUPPLY`
---* `AUFTRAG.Type.BOMBING`
---* `AUFTRAG.Type.BOMBCARPET`
---* `AUFTRAG.Type.BARRAGE`
---
---## Events
---
---Whenever a strategic zone is captured by us the FSM event #CHIEF.ZoneCaptured is triggered and customized further actions can be executed 
---with the #CHIEF.OnAfterZoneCaptured() function.
---
---Whenever a strategic zone is lost (captured by the enemy), the FSM event #CHIEF.ZoneLost is triggered and customized further actions can be executed 
---with the #CHIEF.OnAfterZoneLost() function.
---
---Further events are 
---
---* #CHIEF.ZoneEmpty, once the zone is completely empty of ground troops. Code can be added to the  #CHIEF.OnAfterZoneEmpty() function.
---* #CHIEF.ZoneAttacked, once the zone is under attack. Code can be added to the  #CHIEF.OnAfterZoneAttacked() function.
---
---Note that the ownership of a zone is determined via zone scans, i.e. not via the detection network. In other words, there is an all knowing eye.
---Think of it as the local population providing the intel. It's not totally realistic but the best compromise within the limits of DCS.
---
---CHIEF class.
---@class CHIEF : INTEL
---@field ClassName string Name of the class.
---@field Defcon string Defence condition.
---@field Nattack number 
---@field Nborder number 
---@field Nconflict number 
---@field Nfailure number Number of failed mission.
---@field Nsuccess number Number of successful missions.
---@field borderzoneset SET_ZONE Set of zones defining the border of our territory.
---@field commander COMMANDER Commander of assigned legions.
---@field engagezoneset SET_ZONE Set of zones where enemies are actively engaged.
---@field lid string Class id string for output to DCS log file.
---@field strategy string Strategy of the CHIEF.
---@field tacview boolean 
---@field threatLevelMax number Highest threat level of targets to attack.
---@field threatLevelMin number Lowest threat level of targets to attack.
---@field verbose number Verbosity level.
---@field version string CHIEF class version.
---@field yellowzoneset SET_ZONE Set of zones defining the extended border. Defcon is set to YELLOW if enemy activity is detected.
CHIEF = {}

---Add an AIRWING to the chief's commander.
---
------
---@param self CHIEF 
---@param Airwing AIRWING The airwing to add.
---@return CHIEF #self
function CHIEF:AddAirwing(Airwing) end

---Add an attack zone.
---
---* Enemies in these zones will only be engaged if strategy is at least `CHIEF.STRATEGY.AGGRESSIVE`.
---
------
---@param self CHIEF 
---@param Zone ZONE The zone to add.
---@return CHIEF #self
function CHIEF:AddAttackZone(Zone) end

---Add an AWACS zone.
---
------
---@param self CHIEF 
---@param Zone ZONE Zone.
---@param Altitude number Orbit altitude in feet. Default is 12,000 feet.
---@param Speed number Orbit speed in KIAS. Default 350 kts.
---@param Heading number Heading of race-track pattern in degrees. Default 270 (East to West).
---@param Leg number Length of race-track in NM. Default 30 NM.
---@return AIRWING.PatrolZone #The AWACS zone data.
function CHIEF:AddAwacsZone(Zone, Altitude, Speed, Heading, Leg) end

---Add a zone defining your territory.
---
---* Detected enemy troops in these zones will trigger defence condition `RED`.
---* Enemies in these zones will only be engaged if strategy is at least `CHIEF.STRATEGY.DEFENSIVE`.
---
------
---@param self CHIEF 
---@param Zone ZONE The zone to be added.
---@return CHIEF #self
function CHIEF:AddBorderZone(Zone) end

---Add a BRIGADE to the chief's commander.
---
------
---@param self CHIEF 
---@param Brigade BRIGADE The brigade to add.
---@return CHIEF #self
function CHIEF:AddBrigade(Brigade) end

---Add a CAP zone.
---Flights will engage detected targets inside this zone.
---
------
---@param self CHIEF 
---@param Zone ZONE CAP Zone. Has to be a circular zone.
---@param Altitude number Orbit altitude in feet. Default is 12,000 feet.
---@param Speed number Orbit speed in KIAS. Default 350 kts.
---@param Heading number Heading of race-track pattern in degrees. Default 270 (East to West).
---@param Leg number Length of race-track in NM. Default 30 NM.
---@return AIRWING.PatrolZone #The CAP zone data.
function CHIEF:AddCapZone(Zone, Altitude, Speed, Heading, Leg) end

---Add a conflict zone.
---
---* Detected enemy troops in these zones will trigger defence condition `YELLOW`.
---* Enemies in these zones will only be engaged if strategy is at least `CHIEF.STRATEGY.OFFENSIVE`.
---
------
---@param self CHIEF 
---@param Zone ZONE The zone to be added.
---@return CHIEF #self
function CHIEF:AddConflictZone(Zone) end

---Add a FLEET to the chief's commander.
---
------
---@param self CHIEF 
---@param Fleet FLEET The fleet to add.
---@return CHIEF #self
function CHIEF:AddFleet(Fleet) end

---Add a GCI CAP.
---
------
---@param self CHIEF 
---@param Zone ZONE Zone, where the flight orbits.
---@param Altitude number Orbit altitude in feet. Default is 12,000 feet.
---@param Speed number Orbit speed in KIAS. Default 350 kts.
---@param Heading number Heading of race-track pattern in degrees. Default 270 (East to West).
---@param Leg number Length of race-track in NM. Default 30 NM.
---@return AIRWING.PatrolZone #The CAP zone data.
function CHIEF:AddGciCapZone(Zone, Altitude, Speed, Heading, Leg) end

---Add a LEGION to the chief's commander.
---
------
---@param self CHIEF 
---@param Legion LEGION The legion to add.
---@return CHIEF #self
function CHIEF:AddLegion(Legion) end

---Add mission to mission queue of the COMMANDER.
---
------
---@param self CHIEF 
---@param Mission AUFTRAG Mission to be added.
---@return CHIEF #self
function CHIEF:AddMission(Mission) end

---Add transport to transport queue of the COMMANDER.
---
------
---@param self CHIEF 
---@param Transport OPSTRANSPORT Transport to be added.
---@return CHIEF #self
function CHIEF:AddOpsTransport(Transport) end

---Add a rearming zone.
---
------
---@param self CHIEF 
---@param RearmingZone ZONE Rearming zone.
---@return BRIGADE.SupplyZone #The rearming zone data.
function CHIEF:AddRearmingZone(RearmingZone) end

---Add a refuelling zone.
---
------
---@param self CHIEF 
---@param RefuellingZone ZONE Refuelling zone.
---@return BRIGADE.SupplyZone #The refuelling zone data.
function CHIEF:AddRefuellingZone(RefuellingZone) end

---Add strategically important zone.
---By default two resource lists are created. One for the case that the zone is empty and the other for the case that the zone is occupied.
---
---Occupied:
---
---* `AUFTRAG.Type.ARTY` with Nmin=1, Nmax=2
---* `AUFTRAG.Type.CASENHANCED` with Nmin=1, Nmax=2
---
---Empty:
---
---* `AUFTRAG.Type.ONGURAD` with Nmin=0 and Nmax=1 assets, Attribute=`GROUP.Attribute.GROUND_TANK`.
---* `AUFTRAG.Type.ONGURAD` with Nmin=0 and Nmax=1 assets, Attribute=`GROUP.Attribute.GROUND_IFV`.
---* `AUFTRAG.Type.ONGUARD` with Nmin=1 and Nmax=3 assets, Attribute=`GROUP.Attribute.GROUND_INFANTRY`.
---* `AUFTRAG.Type.OPSTRANSPORT` with Nmin=0 and Nmax=1 assets, Attribute=`GROUP.Attribute.AIR_TRANSPORTHELO` or `GROUP.Attribute.GROUND_APC`. This asset is used to transport the infantry groups.
---
---Resources can be created with the #CHIEF.CreateResource and #CHIEF.AddToResource functions.
---
------
---@param self CHIEF 
---@param OpsZone OPSZONE OPS zone object.
---@param Priority number Priority. Default 50.
---@param Importance number Importance. Default `#nil`.
---@param ResourceOccupied CHIEF.Resources (Optional) Resources used then zone is occupied by the enemy.
---@param ResourceEmpty CHIEF.Resources (Optional) Resources used then zone is empty.
---@return CHIEF.StrategicZone #The strategic zone.
function CHIEF:AddStrategicZone(OpsZone, Priority, Importance, ResourceOccupied, ResourceEmpty) end

---Add a refuelling tanker zone.
---
------
---@param self CHIEF 
---@param Zone ZONE Zone.
---@param Altitude number Orbit altitude in feet. Default is 12,000 feet.
---@param Speed number Orbit speed in KIAS. Default 350 kts.
---@param Heading number Heading of race-track pattern in degrees. Default 270 (East to West).
---@param Leg number Length of race-track in NM. Default 30 NM.
---@param RefuelSystem number Refuelling system.
---@return AIRWING.TankerZone #The tanker zone data.
function CHIEF:AddTankerZone(Zone, Altitude, Speed, Heading, Leg, RefuelSystem) end

---Add target.
---
------
---@param self CHIEF 
---@param Target TARGET Target object to be added.
---@return CHIEF #self
function CHIEF:AddTarget(Target) end

---Add mission type and number of required assets to resource list.
---
------
---@param self CHIEF 
---@param Resource CHIEF.Resources List of resources.
---@param MissionType string Mission Type.
---@param Nmin number Min number of required assets. Default 1.
---@param Nmax number Max number of requried assets. Default equal `Nmin`.
---@param Attributes table Generalized attribute(s).
---@param Properties table DCS attribute(s). Default `nil`.
---@param Categories table Group categories.
---@return CHIEF.Resource #Resource table.
function CHIEF:AddToResource(Resource, MissionType, Nmin, Nmax, Attributes, Properties, Categories) end

---Define which assets will be transported and define the number and attributes/properties of the cargo carrier assets.
---
------
---@param self CHIEF 
---@param Resource CHIEF.Resource Resource table.
---@param Nmin number Min number of required assets. Default 1.
---@param Nmax number Max number of requried assets. Default is equal to `Nmin`.
---@param CarrierAttributes table Generalized attribute(s) of the carrier assets.
---@param CarrierProperties table DCS attribute(s) of the carrier assets.
---@param CarrierCategories table Group categories of the carrier assets.
---@return CHIEF #self
function CHIEF:AddTransportToResource(Resource, Nmin, Nmax, CarrierAttributes, CarrierProperties, CarrierCategories) end

---Allow chief to use GROUND units for transport tasks.
---Helicopters are still preferred, and be aware there's no check as of now
---if a destination can be reached on land.
---
------
---@param self CHIEF 
---@return CHIEF #self
function CHIEF:AllowGroundTransport() end

---Check if group is in a attack zone.
---
------
---@param self CHIEF 
---@param group GROUP The group.
---@return boolean #If true, group is in any attack zone.
function CHIEF:CheckGroupInAttack(group) end

---Check if group is inside our border.
---
------
---@param self CHIEF 
---@param group GROUP The group.
---@return boolean #If true, group is in any border zone.
function CHIEF:CheckGroupInBorder(group) end

---Check if group is in a conflict zone.
---
------
---@param self CHIEF 
---@param group GROUP The group.
---@return boolean #If true, group is in any conflict zone.
function CHIEF:CheckGroupInConflict(group) end

---Check if group is inside a zone.
---
------
---@param self CHIEF 
---@param group GROUP The group.
---@param zoneset SET_ZONE Set of zones.
---@return boolean #If true, group is in any zone.
function CHIEF:CheckGroupInZones(group, zoneset) end

---Check strategic zone queue.
---
------
---@param self CHIEF 
function CHIEF:CheckOpsZoneQueue() end

---Check if group is inside a zone.
---
------
---@param self CHIEF 
---@param target TARGET The target.
---@param zoneset SET_ZONE Set of zones.
---@return boolean #If true, group is in any zone.
function CHIEF:CheckTargetInZones(target, zoneset) end

---Check target queue and assign ONE valid target by adding it to the mission queue of the COMMANDER.
---
------
---@param self CHIEF 
function CHIEF:CheckTargetQueue() end

---Create a new resource list of required assets.
---
------
---@param self CHIEF 
---@param MissionType string The mission type.
---@param Nmin number Min number of required assets. Default 1.
---@param Nmax number Max number of requried assets. Default 1.
---@param Attributes table Generalized attribute(s). Default `nil`.
---@param Properties table DCS attribute(s). Default `nil`.
---@param Categories table Group categories.
---@return CHIEF.Resources #The newly created resource list table.
---@return CHIEF.Resource #The resource object that was added.
function CHIEF:CreateResource(MissionType, Nmin, Nmax, Attributes, Properties, Categories) end

---Triggers the FSM event "DefconChange".
---
------
---@param self CHIEF 
---@param Defcon string New Defence Condition.
function CHIEF:DefconChange(Defcon) end

---Delete mission type from resource list.
---All running missions are cancelled.
---
------
---@param self CHIEF 
---@param Resource table Resource table.
---@param MissionType string Mission Type.
---@return CHIEF #self
function CHIEF:DeleteFromResource(Resource, MissionType) end

---Forbid chief to use GROUND units for transport tasks.
---Restrict to Helicopters. This is the default
---
------
---@param self CHIEF 
---@return CHIEF #self
function CHIEF:ForbidGroundTransport() end

---Get the commander.
---
------
---@param self CHIEF 
---@return COMMANDER #The commander.
function CHIEF:GetCommander() end

---Get defence condition.
---
------
---@param self CHIEF 
---@param Current string Defence condition. See @{#CHIEF.DEFCON}, e.g. `CHIEF.DEFCON.RED`.
---@param Defcon NOTYPE 
function CHIEF:GetDefcon(Current, Defcon) end

---Get mission limit.
---
------
---@param self CHIEF 
---@param MissionType string Type of mission.
---@return number #Limit. Unlimited mission types are returned as 999.
function CHIEF:GetMissionLimit(MissionType) end

---Get the resource list of missions and assets employed when the zone is empty.
---
------
---@param self CHIEF 
---@param StrategicZone CHIEF.StrategicZone The strategic zone.
---@return CHIEF.Resource #Resource list of missions and assets.
function CHIEF:GetStrategicZoneResourceEmpty(StrategicZone) end

---Get the resource list of missions and assets employed when the zone is occupied by the enemy.
---
------
---@param self CHIEF 
---@param StrategicZone CHIEF.StrategicZone The strategic zone.
---@return CHIEF.Resource #Resource list of missions and assets.
function CHIEF:GetStrategicZoneResourceOccupied(StrategicZone) end

---Get current strategy.
---
------
---@param self CHIEF 
---@return string #Strategy.
function CHIEF:GetStrategy() end

---Check if current strategy is aggressive.
---
------
---@param self CHIEF 
---@return boolean #If `true`, strategy is agressive.
function CHIEF:IsAgressive() end

---Check if current strategy is defensive.
---
------
---@param self CHIEF 
---@return boolean #If `true`, strategy is defensive.
function CHIEF:IsDefensive() end

---Check if current strategy is offensive.
---
------
---@param self CHIEF 
---@return boolean #If `true`, strategy is offensive.
function CHIEF:IsOffensive() end

---Check if current strategy is passive.
---
------
---@param self CHIEF 
---@return boolean #If `true`, strategy is passive.
function CHIEF:IsPassive() end

---Check if a TARGET is already in the queue.
---
------
---@param self CHIEF 
---@param Target TARGET Target object to be added.
---@return boolean #If `true`, target exists in the target queue.
function CHIEF:IsTarget(Target) end

---Check if current strategy is total war.
---
------
---@param self CHIEF 
---@return boolean #If `true`, strategy is total war.
function CHIEF:IsTotalWar() end

---Triggers the FSM event "LegionLost".
---
------
---@param self CHIEF 
---@param Legion LEGION The legion that was lost.
---@param Coalition coalition.side which captured the warehouse.
---@param Country country.id which has captured the warehouse.
function CHIEF:LegionLost(Legion, Coalition, Country) end

---Triggers the FSM event "MissionAssign".
---
------
---@param self CHIEF 
---@param Mission AUFTRAG The mission.
---@param Legions table The Legion(s) to which the mission is assigned.
function CHIEF:MissionAssign(Mission, Legions) end

---Triggers the FSM event "MissionCancel".
---
------
---@param self CHIEF 
---@param Mission AUFTRAG The mission.
function CHIEF:MissionCancel(Mission) end

---Create a new CHIEF object and start the FSM.
---
------
---@param self CHIEF 
---@param Coalition number Coalition side, e.g. `coaliton.side.BLUE`. Can also be passed as a string "red", "blue" or "neutral".
---@param AgentSet SET_GROUP Set of agents (groups) providing intel. Default is an empty set.
---@param Alias string An *optional* alias how this object is called in the logs etc.
---@return CHIEF #self
function CHIEF:New(Coalition, AgentSet, Alias) end

---On after "DefconChange" event.
---
------
---@param self CHIEF 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Defcon string New Defence Condition.
function CHIEF:OnAfterDefconChange(From, Event, To, Defcon) end

---On after "LegionLost" event.
---
------
---@param self CHIEF 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Legion LEGION The legion that was lost.
---@param Coalition coalition.side which captured the warehouse.
---@param Country country.id which has captured the warehouse.
function CHIEF:OnAfterLegionLost(From, Event, To, Legion, Coalition, Country) end

---On after "MissionAssign" event.
---
------
---@param self CHIEF 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Mission AUFTRAG The mission.
---@param Legions table The Legion(s) to which the mission is assigned.
function CHIEF:OnAfterMissionAssign(From, Event, To, Mission, Legions) end

---On after "MissionCancel" event.
---
------
---@param self CHIEF 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Mission AUFTRAG The mission.
function CHIEF:OnAfterMissionCancel(From, Event, To, Mission) end

---On after "OpsOnMission" event.
---
------
---@param self CHIEF 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param OpsGroup OPSGROUP The OPS group on mission.
---@param Mission AUFTRAG The mission.
function CHIEF:OnAfterOpsOnMission(From, Event, To, OpsGroup, Mission) end

---On after "StrategyChange" event.
---
------
---@param self CHIEF 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Strategy string New strategy.
function CHIEF:OnAfterStrategyChange(From, Event, To, Strategy) end

---On after "TransportCancel" event.
---
------
---@param self CHIEF 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Transport OPSTRANSPORT The transport.
function CHIEF:OnAfterTransportCancel(From, Event, To, Transport) end

---On after "ZoneAttacked" event.
---
------
---@param self CHIEF 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param OpsZone OPSZONE Zone that is being attacked. 
function CHIEF:OnAfterZoneAttacked(From, Event, To, OpsZone) end

---On after "ZoneCaptured" event.
---
------
---@param self CHIEF 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param OpsZone OPSZONE Zone that was captured. 
function CHIEF:OnAfterZoneCaptured(From, Event, To, OpsZone) end

---On after "ZoneEmpty" event.
---
------
---@param self CHIEF 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param OpsZone OPSZONE Zone that is empty now.
function CHIEF:OnAfterZoneEmpty(From, Event, To, OpsZone) end

---On after "ZoneLost" event.
---
------
---@param self CHIEF 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param OpsZone OPSZONE Zone that was lost. 
function CHIEF:OnAfterZoneLost(From, Event, To, OpsZone) end

---Triggers the FSM event "OpsOnMission".
---
------
---@param self CHIEF 
---@param OpsGroup OPSGROUP The OPS group on mission.
---@param Mission AUFTRAG The mission.
function CHIEF:OpsOnMission(OpsGroup, Mission) end

---Recruit assets for a given OPS zone.
---
------
---@param self CHIEF 
---@param StratZone CHIEF.StrategicZone The strategic zone.
---@param Resource CHIEF.Resource The required resources.
---@return boolean #If `true` enough assets could be recruited.
function CHIEF:RecruitAssetsForZone(StratZone, Resource) end

---Remove an attack zone.
---
------
---@param self CHIEF 
---@param Zone ZONE The zone to be removed.
---@return CHIEF #self
function CHIEF:RemoveAttackZone(Zone) end

---Remove a AWACS zone.
---
------
---@param self CHIEF 
---@param Zone ZONE Zone, where the flight orbits.
function CHIEF:RemoveAwacsZone(Zone) end

---Remove a border zone defining your territory.
---
------
---@param self CHIEF 
---@param Zone ZONE The zone to be removed.
---@return CHIEF #self
function CHIEF:RemoveBorderZone(Zone) end

---Remove a conflict zone.
---
------
---@param self CHIEF 
---@param Zone ZONE The zone to be removed.
---@return CHIEF #self
function CHIEF:RemoveConflictZone(Zone) end

---Remove a GCI CAP
---
------
---@param self CHIEF 
---@param Zone ZONE Zone, where the flight orbits.
function CHIEF:RemoveGciCapZone(Zone) end

---Remove a LEGION to the chief's commander.
---
------
---@param self CHIEF 
---@param Legion LEGION The legion to add.
---@return CHIEF #self
function CHIEF:RemoveLegion(Legion) end

---Remove mission from queue.
---
------
---@param self CHIEF 
---@param Mission AUFTRAG Mission to be removed.
---@return CHIEF #self
function CHIEF:RemoveMission(Mission) end

---Remove strategically important zone.
---All runing missions are cancelled.
---
------
---@param self CHIEF 
---@param OpsZone OPSZONE OPS zone object.
---@param Delay number Delay in seconds before the zone is removed. Default immidiately.
---@return CHIEF #self
function CHIEF:RemoveStrategicZone(OpsZone, Delay) end

---Remove a refuelling tanker zone.
---
------
---@param self CHIEF 
---@param Zone ZONE Zone, where the flight orbits.
function CHIEF:RemoveTankerZone(Zone) end

---Remove target from queue.
---
------
---@param self CHIEF 
---@param Target TARGET The target.
---@return CHIEF #self
function CHIEF:RemoveTarget(Target) end

---Remove transport from queue.
---
------
---@param self CHIEF 
---@param Transport OPSTRANSPORT Transport to be removed.
---@return CHIEF #self
function CHIEF:RemoveTransport(Transport) end

---Set this to be an air-to-air dispatcher.
---
------
---@param self CHIEF 
---@return CHIEF #self
function CHIEF:SetAirToAir() end

---Set this to be an air-to-any dispatcher, i.e.
---engaging air, ground and naval targets. This is the default anyway.
---
------
---@param self CHIEF 
---@return CHIEF #self
function CHIEF:SetAirToAny() end

---Set this to be an air-to-ground dispatcher, i.e.
---engage only ground units
---
------
---@param self CHIEF 
---@return CHIEF #self
function CHIEF:SetAirToGround() end

---Set this to be an air-to-sea dispatcher, i.e.
---engage only naval units.
---
------
---@param self CHIEF 
---@return CHIEF #self
function CHIEF:SetAirToSea() end

---Set this to be an air-to-surface dispatcher, i.e.
---engaging ground and naval groups.
---
------
---@param self CHIEF 
---@return CHIEF #self
function CHIEF:SetAirToSurface() end

---Set attack zone set.
---
---* Enemies in these zones will only be engaged if strategy is at least `CHIEF.STRATEGY.AGGRESSIVE`.
---
------
---@param self CHIEF 
---@param ZoneSet SET_ZONE Set of zones.
---@return CHIEF #self
function CHIEF:SetAttackZones(ZoneSet) end

---Set border zone set, defining your territory.
---
---* Detected enemy troops in these zones will trigger defence condition `RED`.
---* Enemies in these zones will only be engaged if strategy is at least `CHIEF.STRATEGY.DEFENSIVE`.
---
------
---@param self CHIEF 
---@param BorderZoneSet SET_ZONE Set of zones defining our borders.
---@return CHIEF #self
function CHIEF:SetBorderZones(BorderZoneSet) end

---Set conflict zone set.
---
---* Detected enemy troops in these zones will trigger defence condition `YELLOW`.
---* Enemies in these zones will only be engaged if strategy is at least `CHIEF.STRATEGY.OFFENSIVE`.
---
------
---@param self CHIEF 
---@param ZoneSet SET_ZONE Set of zones.
---@return CHIEF #self
function CHIEF:SetConflictZones(ZoneSet) end

---Set defence condition.
---
------
---@param self CHIEF 
---@param Defcon string Defence condition. See @{#CHIEF.DEFCON}, e.g. `CHIEF.DEFCON.RED`.
---@return CHIEF #self
function CHIEF:SetDefcon(Defcon) end

---Set limit for number of total or specific missions to be executed simultaniously.
---
------
---@param self CHIEF 
---@param Limit number Number of max. mission of this type. Default 10.
---@param MissionType string Type of mission, e.g. `AUFTRAG.Type.BAI`. Default `"Total"` for total number of missions.
---@return CHIEF #self
function CHIEF:SetLimitMission(Limit, MissionType) end

---Set number of assets requested for detected targets.
---
------
---@param self CHIEF 
---@param NassetsMin number Min number of assets. Should be at least 1. Default 1.
---@param NassetsMax number Max number of assets. Default is same as `NassetsMin`.
---@param ThreatLevel number Only apply this setting if the target threat level is greater or equal this number. Default 0.
---@param TargetCategory string Only apply this setting if the target is of this category, e.g. `TARGET.Category.AIRCRAFT`.
---@param MissionType string Only apply this setting for this mission type, e.g. `AUFTRAG.Type.INTERCEPT`.
---@param Nunits string Only apply this setting if the number of enemy units is greater or equal this number.
---@param Defcon string Only apply this setting if this defense condition is in place.
---@param Strategy string Only apply this setting if this strategy is in currently. place.
---@return CHIEF #self
function CHIEF:SetResponseOnTarget(NassetsMin, NassetsMax, ThreatLevel, TargetCategory, MissionType, Nunits, Defcon, Strategy) end

---Set the resource list of missions and assets employed when the zone is empty.
---
------
---@param self CHIEF 
---@param StrategicZone CHIEF.StrategicZone The strategic zone.
---@param Resource CHIEF.Resource Resource list of missions and assets.
---@param NoCopy boolean If `true`, do **not** create a deep copy of the resource.
---@return CHIEF #self
function CHIEF:SetStrategicZoneResourceEmpty(StrategicZone, Resource, NoCopy) end

---Set the resource list of missions and assets employed when the zone is occupied by the enemy.
---
------
---@param self CHIEF 
---@param StrategicZone CHIEF.StrategicZone The strategic zone.
---@param Resource CHIEF.Resource Resource list of missions and assets.
---@param NoCopy boolean If `true`, do **not** create a deep copy of the resource.
---@return CHIEF #self
function CHIEF:SetStrategicZoneResourceOccupied(StrategicZone, Resource, NoCopy) end

---Set strategy.
---
------
---@param self CHIEF 
---@param Strategy string Strategy. See @{#CHIEF.strategy}, e.g. `CHIEF.Strategy.DEFENSIVE` (default).
---@return CHIEF #self
function CHIEF:SetStrategy(Strategy) end

---Set tactical overview off.
---
------
---@param self CHIEF 
---@return CHIEF #self
function CHIEF:SetTacticalOverviewOff() end

---Set tactical overview on.
---
------
---@param self CHIEF 
---@return CHIEF #self
function CHIEF:SetTacticalOverviewOn() end

---Set a threat level range that will be engaged.
---Threat level is a number between 0 and 10, where 10 is a very dangerous threat.
---Targets with threat level 0 are usually harmless.
---
------
---@param self CHIEF 
---@param ThreatLevelMin number Min threat level. Default 1.
---@param ThreatLevelMax number Max threat level. Default 10.
---@return CHIEF #self
function CHIEF:SetThreatLevelRange(ThreatLevelMin, ThreatLevelMax) end

---Triggers the FSM event "Start".
---
------
---@param self CHIEF 
function CHIEF:Start() end

---Triggers the FSM event "Status".
---
------
---@param self CHIEF 
function CHIEF:Status() end

---Triggers the FSM event "StrategyChange".
---
------
---@param self CHIEF 
---@param Strategy string New strategy.
function CHIEF:StrategyChange(Strategy) end

---Triggers the FSM event "TransportCancel".
---
------
---@param self CHIEF 
---@param Transport OPSTRANSPORT The transport.
function CHIEF:TransportCancel(Transport) end

---Triggers the FSM event "ZoneAttacked".
---
------
---@param self CHIEF 
---@param OpsZone OPSZONE Zone that is being attacked.
function CHIEF:ZoneAttacked(OpsZone) end

---Triggers the FSM event "ZoneCaptured".
---
------
---@param self CHIEF 
---@param OpsZone OPSZONE Zone that was captured.
function CHIEF:ZoneCaptured(OpsZone) end

---Triggers the FSM event "ZoneEmpty".
---
------
---@param self CHIEF 
---@param OpsZone OPSZONE Zone that is empty now.
function CHIEF:ZoneEmpty(OpsZone) end

---Triggers the FSM event "ZoneLost".
---
------
---@param self CHIEF 
---@param OpsZone OPSZONE Zone that was lost.
function CHIEF:ZoneLost(OpsZone) end

---Check if a given asset has certain attribute(s).
---
------
---@param Asset WAREHOUSE.Assetitem The asset item.
---@param Attributes table The required attributes. See `WAREHOUSE.Attribute` enum. Can also be passed as a single attribute `#string`.
---@return boolean #Returns `true`, the asset has at least one requested attribute.
function CHIEF._CheckAssetAttributes(Asset, Attributes) end

---Check if a given asset has certain categories.
---
------
---@param Asset WAREHOUSE.Assetitem The asset item.
---@param Categories table DCS group categories.
---@return boolean #Returns `true`, the asset has at least one requested category.
function CHIEF._CheckAssetCategories(Asset, Categories) end

---Check if a given asset has certain properties.
---
------
---@param Asset WAREHOUSE.Assetitem The asset item.
---@param Categories table DCS group categories.
---@param Properties NOTYPE 
---@return boolean #Returns `true`, the asset has at least one requested property.
function CHIEF._CheckAssetProperties(Asset, Categories, Properties) end

---Check if limit of missions has been reached.
---
------
---@param self CHIEF 
---@param MissionType string Type of mission.
---@return boolean #If `true`, mission limit has **not** been reached. If `false`, limit has been reached.
function CHIEF:_CheckMissionLimit(MissionType) end

---Create a mission performance table.
---
------
---@param self CHIEF 
---@param MissionType string Mission type.
---@param Performance number Performance.
---@return CHIEF.MissionPerformance #Mission performance.
function CHIEF:_CreateMissionPerformance(MissionType, Performance) end

---Filter assets, which have certain categories, attributes and/or properties.
---
------
---@param Assets table The assets to be filtered.
---@param Categories table Group categories.
---@param Attributes table Generalized attributes.
---@param Properties table DCS attributes
---@return table #Table of filtered assets.
function CHIEF._FilterAssets(Assets, Categories, Attributes, Properties) end

---Add mission type and number of required assets to resource.
---
------
---@param self CHIEF 
---@param Target TARGET The target.
---@param MissionType string Mission type.
---@return number #Number of min assets.
---@return number #Number of max assets.
function CHIEF:_GetAssetsForTarget(Target, MissionType) end

---Get mission performance for a given TARGET.
---
------
---@param self CHIEF 
---@param Target TARGET The target.
---@return table #Mission performances of type `#CHIEF.MissionPerformance`.
function CHIEF:_GetMissionPerformanceFromTarget(Target) end

---Get mission performances for a given Group Attribute.
---
------
---@param self CHIEF 
---@param Attribute string Group attibute.
---@return table #Mission performances of type `#CHIEF.MissionPerformance`.
function CHIEF:_GetMissionTypeForGroupAttribute(Attribute) end

---Display tactical overview.
---
------
---@param self CHIEF 
function CHIEF:_TacticalOverview() end

---Triggers the FSM event "DefconChange" after a delay.
---
------
---@param self CHIEF 
---@param delay number Delay in seconds.
---@param Defcon string New Defence Condition.
function CHIEF:__DefconChange(delay, Defcon) end

---Triggers the FSM event "LegionLost".
---
------
---@param self CHIEF 
---@param delay number Delay in seconds.
---@param Legion LEGION The legion that was lost.
---@param Coalition coalition.side which captured the warehouse.
---@param Country country.id which has captured the warehouse.
function CHIEF:__LegionLost(delay, Legion, Coalition, Country) end

---Triggers the FSM event "MissionAssign" after a delay.
---
------
---@param self CHIEF 
---@param delay number Delay in seconds.
---@param Mission AUFTRAG The mission.
---@param Legions table The Legion(s) to which the mission is assigned.
function CHIEF:__MissionAssign(delay, Mission, Legions) end

---Triggers the FSM event "MissionCancel" after a delay.
---
------
---@param self CHIEF 
---@param delay number Delay in seconds.
---@param Mission AUFTRAG The mission.
function CHIEF:__MissionCancel(delay, Mission) end

---Triggers the FSM event "OpsOnMission" after a delay.
---
------
---@param self CHIEF 
---@param delay number Delay in seconds.
---@param OpsGroup OPSGROUP The OPS group on mission.
---@param Mission AUFTRAG The mission.
function CHIEF:__OpsOnMission(delay, OpsGroup, Mission) end

---Triggers the FSM event "Start" after a delay.
---
------
---@param self CHIEF 
---@param delay number Delay in seconds.
function CHIEF:__Start(delay) end

---Triggers the FSM event "Status" after a delay.
---
------
---@param self CHIEF 
---@param delay number Delay in seconds.
function CHIEF:__Status(delay) end

---Triggers the FSM event "Stop" after a delay.
---
------
---@param self CHIEF 
---@param delay number Delay in seconds.
function CHIEF:__Stop(delay) end

---Triggers the FSM event "StrategyChange" after a delay.
---
------
---@param self CHIEF 
---@param delay number Delay in seconds.
---@param Strategy string New strategy.
function CHIEF:__StrategyChange(delay, Strategy) end

---Triggers the FSM event "TransportCancel" after a delay.
---
------
---@param self CHIEF 
---@param delay number Delay in seconds.
---@param Transport OPSTRANSPORT The transport.
function CHIEF:__TransportCancel(delay, Transport) end

---Triggers the FSM event "ZoneAttacked" after a delay.
---
------
---@param self CHIEF 
---@param delay number Delay in seconds.
---@param OpsZone OPSZONE Zone that is being attacked.
function CHIEF:__ZoneAttacked(delay, OpsZone) end

---Triggers the FSM event "ZoneCaptured" after a delay.
---
------
---@param self CHIEF 
---@param delay number Delay in seconds.
---@param OpsZone OPSZONE Zone that was captured.
function CHIEF:__ZoneCaptured(delay, OpsZone) end

---Triggers the FSM event "ZoneEmpty" after a delay.
---
------
---@param self CHIEF 
---@param delay number Delay in seconds.
---@param OpsZone OPSZONE Zone that is empty now.
function CHIEF:__ZoneEmpty(delay, OpsZone) end

---Triggers the FSM event "ZoneLost" after a delay.
---
------
---@param self CHIEF 
---@param delay number Delay in seconds.
---@param OpsZone OPSZONE Zone that was lost.
function CHIEF:__ZoneLost(delay, OpsZone) end

---On after "DefconChange" event.
---
------
---@param self CHIEF 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Defcon string New defence condition.
function CHIEF:onafterDefconChange(From, Event, To, Defcon) end

---On after "MissionAssignToAny" event.
---
------
---@param self CHIEF 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Mission AUFTRAG The mission.
---@param Legions table The Legion(s) to which the mission is assigned.
function CHIEF:onafterMissionAssign(From, Event, To, Mission, Legions) end

---On after "MissionCancel" event.
---
------
---@param self CHIEF 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Mission AUFTRAG The mission.
function CHIEF:onafterMissionCancel(From, Event, To, Mission) end

---On after "OpsOnMission".
---
------
---@param self CHIEF 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param OpsGroup OPSGROUP Ops group on mission
---@param Mission AUFTRAG The requested mission.
function CHIEF:onafterOpsOnMission(From, Event, To, OpsGroup, Mission) end

---On after Start event.
---
------
---@param self CHIEF 
---@param Group GROUP Flight group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function CHIEF:onafterStart(Group, From, Event, To) end

---On after "Status" event.
---
------
---@param self CHIEF 
---@param Group GROUP Flight group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function CHIEF:onafterStatus(Group, From, Event, To) end

---On after "StrategyChange" event.
---
------
---@param self CHIEF 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Strategy string 
function CHIEF:onafterStrategyChange(From, Event, To, Strategy) end

---On after "TransportCancel" event.
---
------
---@param self CHIEF 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Transport OPSTRANSPORT The transport.
function CHIEF:onafterTransportCancel(From, Event, To, Transport) end

---On after "ZoneAttacked".
---
------
---@param self CHIEF 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param OpsZone OPSZONE The zone that being attacked.
function CHIEF:onafterZoneAttacked(From, Event, To, OpsZone) end

---On after "ZoneCaptured".
---
------
---@param self CHIEF 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param OpsZone OPSZONE The zone that was captured by us.
function CHIEF:onafterZoneCaptured(From, Event, To, OpsZone) end

---On after "ZoneEmpty".
---
------
---@param self CHIEF 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param OpsZone OPSZONE The zone that is empty now.
function CHIEF:onafterZoneEmpty(From, Event, To, OpsZone) end

---On after "ZoneLost".
---
------
---@param self CHIEF 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param OpsZone OPSZONE The zone that was lost.
function CHIEF:onafterZoneLost(From, Event, To, OpsZone) end


---Asset numbers for detected targets.
---@class CHIEF.AssetNumber 
---@field defcon string Defense condition.
---@field missionType string Mission type.
---@field nAssetMax number Max number of assets.
---@field nAssetMin number Min number of assets.
---@field nUnits number Number of enemy units.
---@field strategy string Strategy.
---@field targetCategory string Target category.
---@field threatlevel number Threat level.
CHIEF.AssetNumber = {}


---Defence condition.
---@class CHIEF.DEFCON 
---@field GREEN string No enemy activities detected in our terretory or conflict zones.
---@field RED string Enemy within our border.
---@field YELLOW string Enemy in conflict zones.
CHIEF.DEFCON = {}


---Mission performance.
---@class CHIEF.MissionPerformance 
---@field MissionType string Mission Type.
---@field Performance number Performance: a number between 0 and 100, where 100 is best performance.
CHIEF.MissionPerformance = {}


---Resource.
---@class CHIEF.Resource 
---@field MissionType string Mission type, e.g. `AUFTRAG.Type.BAI`.
---@field Nmax number Max number of assets.
---@field Nmin number Min number of assets.
---@field carrierNmax number Max number of assets.
---@field carrierNmin number Min number of assets.
---@field mission AUFTRAG Attached mission.
CHIEF.Resource = {}


---Resource list.
---@class CHIEF.Resources 
CHIEF.Resources = {}


---Strategic zone.
---@class CHIEF.StrategicZone 
---@field importance number Importance.
---@field opszone OPSZONE OPS zone.
---@field prio number Priority.
CHIEF.StrategicZone = {}


---Strategy.
---@class CHIEF.Strategy 
---@field AGGRESSIVE string Targets in own terretory, conflict zones and attack zones are engaged.
---@field DEFENSIVE string Only target in our own terretory are engaged.
---@field OFFENSIVE string Targets in own terretory and yellow zones are engaged.
---@field PASSIVE string No targets at all are engaged.
---@field TOTALWAR string Anything is engaged anywhere.
CHIEF.Strategy = {}



