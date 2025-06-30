---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/AI_Combat_Air_Patrol.JPG" width="100%">
---
---Easy CAP/GCI Class, based on OPS classes
--------------------------------------------------------------------------
---Documentation
---
---https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Documentation/Ops.EasyGCICAP.html
---
--------------------------------------------------------------------------
---Date: September 2023
---Last Update: July 2024
--------------------------------------------------------------------------
---
---- **Ops** - Easy GCI & CAP Manager
---
---===
---
---**Main Features:**
---
---   * Automatically create and manage A2A CAP/GCI defenses using an AirWing and Squadrons for one coalition
---   * Easy set-up
---   * Add additional AirWings on other airbases
---   * Each wing can have more than one Squadron - tasking to Squadrons is done on a random basis per AirWing
---   * Create borders and zones of engagement
---   * Detection can be ground based and/or via AWACS
---
---===
---
---### AUTHOR: **applevangelist**
---*“Airspeed, altitude, and brains.
---Two are always needed to successfully complete the flight.”* -- Unknown.
---
---===
---
---# The EasyGCICAP Concept
---
---The idea of this class is partially to make the OPS classes easier operational for an A2A CAP/GCI defense network, and to replace the legacy AI_A2A_Dispatcher system - not to it's
---full extent, but make a basic system work very quickly.
---
---# Setup
---
---## Basic understanding
---
---The basics are, there is **one** and only **one** AirWing per airbase. Each AirWing has **at least** one Squadron, who will do both CAP and GCI tasks. Squadrons will be randomly chosen for the task at hand.
---Each AirWing has **at least** one CAP Point that it manages. CAP Points will be covered by the AirWing automatically as long as airframes are available. Detected intruders will be assigned to **one**
---AirWing based on proximity (that is, if you have more than one). 
---
---## Assignment of tasks for intruders
---
---Either a CAP Plane or a newly spawned GCI plane will take care of the intruders. Standard overhead is 0.75, i.e. a group of 3 intrudes will
---be managed by 2 planes from the assigned AirWing. There is an maximum missions limitation per AirWing, so we do not spam the skies.
---
---## Basic set-up code
---
---### Prerequisites
---
---You have to put a **STATIC WAREHOUSE** object on the airbase with the UNIT name according to the name of the airbase. **Do not put any other static type or it creates a conflict with the airbase name!** 
---E.g. for Kuitaisi this has to have the unit name Kutaisi. This object symbolizes the AirWing HQ.
---Next put a late activated template group for your CAP/GCI Squadron on the map. Last, put a zone on the map for the CAP operations, let's name it "Blue Zone 1". Size of the zone plays no role.
---Put an EW radar system on the map and name it aptly, like "Blue EWR".
---
---### Zones
---
---For our example, you create a RED and a BLUE border, as a closed polygonal zone representing the borderlines. You can also have conflict zone, where - for our example - BLUE will attack
---RED planes, despite being on RED territory. Think of a no-fly zone or an limited area of engagement. Conflict zones take precedence over borders, i.e. they can overlap all borders.
---
---### Code it
---
---         -- Set up a basic system for the blue side, we'll reside on Kutaisi, and use GROUP objects with "Blue EWR" in the name as EW Radar Systems.
---         local mywing = EASYGCICAP:New("Blue CAP Operations",AIRBASE.Caucasus.Kutaisi,"blue","Blue EWR")
---         
---         -- Add a CAP patrol point belonging to our airbase, we'll be at 30k ft doing 400 kn, initial direction 90 degrees (East), leg 20NM
---         mywing:AddPatrolPointCAP(AIRBASE.Caucasus.Kutaisi,ZONE:FindByName("Blue Zone 1"):GetCoordinate(),30000,400,90,20)
---         
---         -- Add a Squadron with template "Blue Sq1 M2000c", 20 airframes, skill good, Modex starting with 102 and skin "Vendee Jeanne"
---         mywing:AddSquadron("Blue Sq1 M2000c","CAP Kutaisi",AIRBASE.Caucasus.Kutaisi,20,AI.Skill.GOOD,102,"ec1.5_Vendee_Jeanne_clean")
---         
---         -- Add a couple of zones
---         -- We'll defend our own border
---         mywing:AddAcceptZone(ZONE_POLYGON:New( "Blue Border", GROUP:FindByName( "Blue Border" ) ))
---         -- We'll attack intruders also here - conflictzones can overlap borders(!) - limited zone of engagement
---         mywing:AddConflictZone(ZONE_POLYGON:New("Red Defense Zone", GROUP:FindByName( "Red Defense Zone" )))
---         -- We'll leave the reds alone on their turf
---         mywing:AddRejectZone(ZONE_POLYGON:New( "Red Border", GROUP:FindByName( "Red Border" ) ))
---         
---         -- Optional - Draw the borders on the map so we see what's going on
---         -- Set up borders on map
---         local BlueBorder = ZONE_POLYGON:New( "Blue Border", GROUP:FindByName( "Blue Border" ) )
---         BlueBorder:DrawZone(-1,{0,0,1},1,FillColor,FillAlpha,1,true)
---         local ConflictZone = ZONE_POLYGON:New("Red Defense Zone", GROUP:FindByName( "Red Defense Zone" ))
---         ConflictZone:DrawZone(-1,{1,1,0},1,FillColor,FillAlpha,2,true)
---         local BlueNoGoZone = ZONE_POLYGON:New( "Red Border", GROUP:FindByName( "Red Border" ) )
---         BlueNoGoZone:DrawZone(-1,{1,0,0},1,FillColor,FillAlpha,4,true)
---         
---### Add a second airwing with squads and own CAP point (optional)
---         
---         -- Set this up at Sukhumi
---         mywing:AddAirwing(AIRBASE.Caucasus.Sukhumi_Babushara,"Blue CAP Sukhumi")
---         -- CAP Point "Blue Zone 2"
---         mywing:AddPatrolPointCAP(AIRBASE.Caucasus.Sukhumi_Babushara,ZONE:FindByName("Blue Zone 2"):GetCoordinate(),30000,400,90,20)
---         
---         -- This one has two squadrons to choose from
---         mywing:AddSquadron("Blue Sq3 F16","CAP Sukhumi II",AIRBASE.Caucasus.Sukhumi_Babushara,20,AI.Skill.GOOD,402,"JASDF 6th TFS 43-8526 Skull Riders")
---         mywing:AddSquadron("Blue Sq2 F15","CAP Sukhumi I",AIRBASE.Caucasus.Sukhumi_Babushara,20,AI.Skill.GOOD,202,"390th Fighter SQN")
---         
---### Add a tanker (optional)
---       
---       -- **Note** If you need different tanker types, i.e. Boom and Drogue, set them up at different AirWings!
---       -- Add a tanker point
---       mywing:AddPatrolPointTanker(AIRBASE.Caucasus.Kutaisi,ZONE:FindByName("Blue Zone Tanker"):GetCoordinate(),20000,280,270,50)
---       -- Add a tanker squad - Radio 251 AM, TACAN 51Y
---       mywing:AddTankerSquadron("Blue Tanker","Tanker Ops Kutaisi",AIRBASE.Caucasus.Kutaisi,20,AI.Skill.EXCELLENT,602,nil,251,radio.modulation.AM,51)
---       
---### Add an AWACS (optional)
---       
---       -- Add an AWACS point
---       mywing:AddPatrolPointAwacs(AIRBASE.Caucasus.Kutaisi,ZONE:FindByName("Blue Zone AWACS"):GetCoordinate(),25000,300,270,50)
---       -- Add an AWACS squad - Radio 251 AM, TACAN 51Y
---       mywing:AddAWACSSquadron("Blue AWACS","AWACS Ops Kutaisi",AIRBASE.Caucasus.Kutaisi,20,AI.Skill.AVERAGE,702,nil,271,radio.modulation.AM)        
---
---# Fine-Tuning
---
---## Change Defaults
---
---* #EASYGCICAP.SetDefaultResurrection: Set how many seconds the AirWing stays inoperable after the AirWing STATIC HQ ist destroyed, default 900 secs. 
---* #EASYGCICAP.SetDefaultCAPSpeed: Set how many knots the CAP flights should do (will be altitude corrected), default 300 kn.
---* #EASYGCICAP.SetDefaultCAPAlt: Set at which altitude (ASL) the CAP planes will fly, default 25,000 ft.
---* #EASYGCICAP.SetDefaultCAPDirection: Set the initial direction from the CAP point the planes will fly in degrees, default is 90°.
---* #EASYGCICAP.SetDefaultCAPLeg: Set the length of the CAP leg, default is 15 NM.
---* #EASYGCICAP.SetDefaultCAPGrouping: Set how many planes will be spawned per mission (CVAP/GCI), defaults to 2.
---* #EASYGCICAP.SetDefaultMissionRange: Set how many NM the planes can go from the home base, defaults to 100.
---* #EASYGCICAP.SetDefaultNumberAlert5Standby: Set how many planes will be spawned on cold standby (Alert5), default 2.
---* #EASYGCICAP.SetDefaultEngageRange: Set max engage range for CAP flights if they detect intruders, defaults to 50.
---* #EASYGCICAP.SetMaxAliveMissions: Set max parallel missions can be done (CAP+GCI+Alert5+Tanker+AWACS), defaults to 8.
---* #EASYGCICAP.SetDefaultRepeatOnFailure: Set max repeats on failure for intercepting/killing intruders, defaults to 3.
---* #EASYGCICAP.SetTankerAndAWACSInvisible: Set Tanker and AWACS to be invisible to enemy AI eyes. Is set to `true` by default.
---
---## Debug and Monitor
---
---         mywing.debug = true -- log information
---         mywing.Monitor = true -- show some statistics on screen
---EASYGCICAP Class
---@class EASYGCICAP : FSM
---@field CapFormation number 
---@field ClassName string 
---@field ConflictZoneSet SET_ZONE 
---@field DespawnAfterHolding boolean 
---@field DespawnAfterLanding boolean 
---@field EWRName  
---@field GoZoneSet SET_ZONE 
---@field Intel INTEL 
---@field MaxAliveMissions number 
---@field Monitor boolean 
---@field NoGoZoneSet SET_ZONE 
---@field TankerInvisible boolean 
---@field airbase AIRBASE 
---@field airbasename string 
---@field alias string 
---@field capalt number 
---@field capdir number 
---@field capgrouping number 
---@field capleg number 
---@field capspeed number 
---@field coalition number 
---@field debug boolean 
---@field defaulttakeofftype string Take off type
---@field engagerange number 
---@field lid  
---@field maxinterceptsize number 
---@field missionrange number 
---@field noalert5 number 
---@field overhead number 
---@field repeatsonfailure number 
---@field resurrection number 
---@field version string EASYGCICAP class version.
EASYGCICAP = {}

---Add an AWACS Squadron to an Airwing of the manager
---
------
---@param self EASYGCICAP 
---@param TemplateName string Name of the group template.
---@param SquadName string Squadron name - must be unique!
---@param AirbaseName string Name of the airbase the airwing resides on, e.g. AIRBASE.Caucasus.Kutaisi
---@param AirFrames number Number of available airframes, e.g. 20.
---@param Skill string optional) Skill level, e.g. AI.Skill.AVERAGE
---@param Modex string (optional) Modex to be used,e.g. 402.
---@param Livery string (optional) Livery name to be used.
---@param Frequency number (optional) Radio Frequency to be used. 
---@param Modulation number (optional) Radio Modulation to be used, e.g. radio.modulation.AM or radio.modulation.FM
---@return EASYGCICAP #self 
function EASYGCICAP:AddAWACSSquadron(TemplateName, SquadName, AirbaseName, AirFrames, Skill, Modex, Livery, Frequency, Modulation) end

---Add a zone to the accepted zones set.
---
------
---@param self EASYGCICAP 
---@param Zone ZONE_BASE 
---@return EASYGCICAP #self 
function EASYGCICAP:AddAcceptZone(Zone) end

---Add an AirWing to the manager
---
------
---@param self EASYGCICAP 
---@param Airbasename string 
---@param Alias string 
---@return EASYGCICAP #self 
function EASYGCICAP:AddAirwing(Airbasename, Alias) end

---Add a zone to the conflict zones set.
---
------
---@param self EASYGCICAP 
---@param Zone ZONE_BASE 
---@return EASYGCICAP #self 
function EASYGCICAP:AddConflictZone(Zone) end

---Add an AWACS patrol point to a Wing
---
------
---@param self EASYGCICAP 
---@param AirbaseName string Name of the Wing's airbase
---@param Coordinate COORDINATE 
---@param Altitude number Defaults to 25000 feet.
---@param Speed number  Defaults to 300 knots.
---@param Heading number Defaults to 90 degrees (East).
---@param LegLength number Defaults to 15 NM.
---@return EASYGCICAP #self
function EASYGCICAP:AddPatrolPointAwacs(AirbaseName, Coordinate, Altitude, Speed, Heading, LegLength) end

---Add a CAP patrol point to a Wing
---
------
---@param self EASYGCICAP 
---@param AirbaseName string Name of the Wing's airbase
---@param Coordinate COORDINATE 
---@param Altitude number Defaults to 25000 feet ASL.
---@param Speed number  Defaults to 300 knots TAS.
---@param Heading number Defaults to 90 degrees (East).
---@param LegLength number Defaults to 15 NM.
---@return EASYGCICAP #self
function EASYGCICAP:AddPatrolPointCAP(AirbaseName, Coordinate, Altitude, Speed, Heading, LegLength) end

---Add a RECON patrol point to a Wing
---
------
---@param self EASYGCICAP 
---@param AirbaseName string Name of the Wing's airbase
---@param Coordinate COORDINATE 
---@param Altitude number Defaults to 25000 feet.
---@param Speed number  Defaults to 300 knots.
---@param Heading number Defaults to 90 degrees (East).
---@param LegLength number Defaults to 15 NM.
---@return EASYGCICAP #self
function EASYGCICAP:AddPatrolPointRecon(AirbaseName, Coordinate, Altitude, Speed, Heading, LegLength) end

---Add a TANKER patrol point to a Wing
---
------
---@param self EASYGCICAP 
---@param AirbaseName string Name of the Wing's airbase
---@param Coordinate COORDINATE 
---@param Altitude number Defaults to 25000 feet.
---@param Speed number  Defaults to 300 knots.
---@param Heading number Defaults to 90 degrees (East).
---@param LegLength number Defaults to 15 NM.
---@return EASYGCICAP #self
function EASYGCICAP:AddPatrolPointTanker(AirbaseName, Coordinate, Altitude, Speed, Heading, LegLength) end

---Add a Recon Squadron to an Airwing of the manager
---
------
---@param self EASYGCICAP 
---@param TemplateName string Name of the group template.
---@param SquadName string Squadron name - must be unique!
---@param AirbaseName string Name of the airbase the airwing resides on, e.g. AIRBASE.Caucasus.Kutaisi
---@param AirFrames number Number of available airframes, e.g. 20.
---@param Skill string optional) Skill level, e.g. AI.Skill.AVERAGE
---@param Modex string (optional) Modex to be used,e.g. 402.
---@param Livery string (optional) Livery name to be used.
---@return EASYGCICAP #self 
function EASYGCICAP:AddReconSquadron(TemplateName, SquadName, AirbaseName, AirFrames, Skill, Modex, Livery) end

---Add a zone to the rejected zones set.
---
------
---@param self EASYGCICAP 
---@param Zone ZONE_BASE 
---@return EASYGCICAP #self 
function EASYGCICAP:AddRejectZone(Zone) end

---Add a Squadron to an Airwing of the manager
---
------
---@param self EASYGCICAP 
---@param TemplateName string Name of the group template.
---@param SquadName string Squadron name - must be unique!
---@param AirbaseName string Name of the airbase the airwing resides on, e.g. AIRBASE.Caucasus.Kutaisi
---@param AirFrames number Number of available airframes, e.g. 20.
---@param Skill string optional) Skill level, e.g. AI.Skill.AVERAGE
---@param Modex string (optional) Modex to be used,e.g. 402.
---@param Livery string (optional) Livery name to be used.
---@return EASYGCICAP #self 
function EASYGCICAP:AddSquadron(TemplateName, SquadName, AirbaseName, AirFrames, Skill, Modex, Livery) end

---Add a Tanker Squadron to an Airwing of the manager
---
------
---@param self EASYGCICAP 
---@param TemplateName string Name of the group template.
---@param SquadName string Squadron name - must be unique!
---@param AirbaseName string Name of the airbase the airwing resides on, e.g. AIRBASE.Caucasus.Kutaisi
---@param AirFrames number Number of available airframes, e.g. 20.
---@param Skill string optional) Skill level, e.g. AI.Skill.AVERAGE
---@param Modex string (optional) Modex to be used,e.g. 402.
---@param Livery string (optional) Livery name to be used.
---@param Frequency number (optional) Radio Frequency to be used. 
---@param Modulation number (optional) Radio Modulation to be used, e.g. radio.modulation.AM or radio.modulation.FM
---@param TACAN number (optional)  TACAN channel, e.g. 71, resulting in Channel 71Y
---@return EASYGCICAP #self 
function EASYGCICAP:AddTankerSquadron(TemplateName, SquadName, AirbaseName, AirFrames, Skill, Modex, Livery, Frequency, Modulation, TACAN) end

---Create a new GCICAP Manager
---
------
---@param self EASYGCICAP 
---@param Alias string A Name for this GCICAP
---@param AirbaseName string Name of the Home Airbase
---@param Coalition string Coalition, e.g. "blue" or "red"
---@param EWRName string (Partial) group name of the EWR system of the coalition, e.g. "Red EWR", can be handed in as table of names, e.g.{"EWR","Radar","SAM"}
---@return EASYGCICAP #self
function EASYGCICAP:New(Alias, AirbaseName, Coalition, EWRName) end

---Set CAP formation.
---
------
---@param self EASYGCICAP 
---@param Formation number Formation to fly, defaults to ENUMS.Formation.FixedWing.FingerFour.Group
---@return EASYGCICAP #self
function EASYGCICAP:SetCAPFormation(Formation) end

---Set CAP mission start to vary randomly between Start end End seconds.
---
------
---@param self EASYGCICAP 
---@param Start number 
---@param End number 
---@return EASYGCICAP #self
function EASYGCICAP:SetCapStartTimeVariation(Start, End) end

---Set default CAP Altitude in feet
---
------
---@param self EASYGCICAP 
---@param Altitude number Altitude defaults to 25000
---@return EASYGCICAP #self
function EASYGCICAP:SetDefaultCAPAlt(Altitude) end

---Set default CAP lieg initial direction in degrees
---
------
---@param self EASYGCICAP 
---@param Direction number Direction defaults to 90 (East)
---@return EASYGCICAP #self
function EASYGCICAP:SetDefaultCAPDirection(Direction) end

---Set default grouping, i.e.
---how many airplanes per CAP point
---
------
---@param self EASYGCICAP 
---@param Grouping number Grouping defaults to 2
---@return EASYGCICAP #self
function EASYGCICAP:SetDefaultCAPGrouping(Grouping) end

---Set default leg length in NM
---
------
---@param self EASYGCICAP 
---@param Leg number Leg defaults to 15
---@return EASYGCICAP #self
function EASYGCICAP:SetDefaultCAPLeg(Leg) end

---Set default CAP Speed in knots
---
------
---@param self EASYGCICAP 
---@param Speed number Speed defaults to 300
---@return EASYGCICAP #self
function EASYGCICAP:SetDefaultCAPSpeed(Speed) end

---Set default despawning after holding (despawn in air close to AFB).
---
------
---@param self EASYGCICAP 
---@return EASYGCICAP #self
function EASYGCICAP:SetDefaultDespawnAfterHolding() end

---Set default despawning after landing.
---
------
---@param self EASYGCICAP 
---@return EASYGCICAP #self
function EASYGCICAP:SetDefaultDespawnAfterLanding() end

---Set default engage range for intruders detected by CAP flights in NM.
---
------
---@param self EASYGCICAP 
---@param Range number defaults to 50NM
---@return EASYGCICAP #self
function EASYGCICAP:SetDefaultEngageRange(Range) end

---Set default range planes can fly from their homebase in NM
---
------
---@param self EASYGCICAP 
---@param Range number Range defaults to 100 NM
---@return EASYGCICAP #self
function EASYGCICAP:SetDefaultMissionRange(Range) end

---Set default number of airframes standing by for intercept tasks (visible on the airfield)
---
------
---@param self EASYGCICAP 
---@param Airframes number defaults to 2
---@return EASYGCICAP #self
function EASYGCICAP:SetDefaultNumberAlert5Standby(Airframes) end

---Set default overhead for intercept calculations
---
------
---
---USAGE
---```
---Either a CAP Plane or a newly spawned GCI plane will take care of intruders. Standard overhead is 0.75, i.e. a group of 3 intrudes will
---be managed by 2 planes from the assigned AirWing. There is an maximum missions limitation per AirWing, so we do not spam the skies.
---```
------
---@param self EASYGCICAP 
---@param Overhead number The overhead to use.
---@return EASYGCICAP #self
function EASYGCICAP:SetDefaultOverhead(Overhead) end

---Add default repeat attempts if an Intruder intercepts fails.
---
------
---@param self EASYGCICAP 
---@param Retries number Retries, defaults to 3
---@return EASYGCICAP #self 
function EASYGCICAP:SetDefaultRepeatOnFailure(Retries) end

---Add default time to resurrect Airwing building if destroyed
---
------
---@param self EASYGCICAP 
---@param Seconds number Seconds, defaults to 900
---@return EASYGCICAP #self 
function EASYGCICAP:SetDefaultResurrection(Seconds) end

---Add default take off type for the airwings.
---
------
---@param self EASYGCICAP 
---@param Takeoff string Can be "hot", "cold", or "air" - default is "hot".
---@return EASYGCICAP #self 
function EASYGCICAP:SetDefaultTakeOffType(Takeoff) end

---Set Maximum of alive missions created by this instance to stop airplanes spamming the map
---
------
---@param self EASYGCICAP 
---@param Maxiumum number Maxmimum number of parallel missions allowed. Count is Intercept-Missions + Alert5-Missions, default is 8
---@return EASYGCICAP #self 
function EASYGCICAP:SetMaxAliveMissions(Maxiumum) end

---Set Tanker and AWACS to be invisible to enemy AI eyes
---
------
---@param self EASYGCICAP 
---@param Switch boolean Set to true or false, by default this is set to true already
---@return EASYGCICAP #self 
function EASYGCICAP:SetTankerAndAWACSInvisible(Switch) end

---(Internal) Add a AWACS Squadron to an Airwing of the manager
---
------
---@param self EASYGCICAP 
---@param TemplateName string Name of the group template.
---@param SquadName string Squadron name - must be unique!
---@param AirbaseName string Name of the airbase the airwing resides on, e.g. AIRBASE.Caucasus.Kutaisi
---@param AirFrames number Number of available airframes, e.g. 20.
---@param Skill string optional) Skill level, e.g. AI.Skill.AVERAGE
---@param Modex string (optional) Modex to be used,e.g. 402.
---@param Livery string (optional) Livery name to be used.
---@param Frequency number (optional) Radio frequency of the AWACS
---@param Modulation number (Optional) Radio modulation of the AWACS
---@return EASYGCICAP #self 
function EASYGCICAP:_AddAWACSSquadron(TemplateName, SquadName, AirbaseName, AirFrames, Skill, Modex, Livery, Frequency, Modulation) end

---(internal) Create and add another AirWing to the manager
---
------
---@param self EASYGCICAP 
---@param Airbasename string 
---@param Alias string 
---@return EASYGCICAP #self 
function EASYGCICAP:_AddAirwing(Airbasename, Alias) end

---(Internal) Add a Recon Squadron to an Airwing of the manager
---
------
---@param self EASYGCICAP 
---@param TemplateName string Name of the group template.
---@param SquadName string Squadron name - must be unique!
---@param AirbaseName string Name of the airbase the airwing resides on, e.g. AIRBASE.Caucasus.Kutaisi
---@param AirFrames number Number of available airframes, e.g. 20.
---@param Skill string optional) Skill level, e.g. AI.Skill.AVERAGE
---@param Modex string (optional) Modex to be used,e.g. 402.
---@param Livery string (optional) Livery name to be used.
---@return EASYGCICAP #self 
function EASYGCICAP:_AddReconSquadron(TemplateName, SquadName, AirbaseName, AirFrames, Skill, Modex, Livery) end

---(Internal) Add a Squadron to an Airwing of the manager
---
------
---@param self EASYGCICAP 
---@param TemplateName string Name of the group template.
---@param SquadName string Squadron name - must be unique!
---@param AirbaseName string Name of the airbase the airwing resides on, e.g. AIRBASE.Caucasus.Kutaisi
---@param AirFrames number Number of available airframes, e.g. 20.
---@param Skill string optional) Skill level, e.g. AI.Skill.AVERAGE
---@param Modex string (optional) Modex to be used,e.g. 402.
---@param Livery string (optional) Livery name to be used.
---@param Frequency number (optional) Radio Frequency to be used. 
---@param Modulation number (optional) Radio Modulation to be used, e.g. radio.modulation.AM or radio.modulation.FM
---@return EASYGCICAP #self 
function EASYGCICAP:_AddSquadron(TemplateName, SquadName, AirbaseName, AirFrames, Skill, Modex, Livery, Frequency, Modulation) end

---(Internal) Add a Tanker Squadron to an Airwing of the manager
---
------
---@param self EASYGCICAP 
---@param TemplateName string Name of the group template.
---@param SquadName string Squadron name - must be unique!
---@param AirbaseName string Name of the airbase the airwing resides on, e.g. AIRBASE.Caucasus.Kutaisi
---@param AirFrames number Number of available airframes, e.g. 20.
---@param Skill string optional) Skill level, e.g. AI.Skill.AVERAGE
---@param Modex string (optional) Modex to be used,e.g. 402.
---@param Livery string (optional) Livery name to be used.
---@param Frequency number (optional) Radio frequency of the Tanker
---@param Modulation number (Optional) Radio modulation of the Tanker
---@param TACAN number (Optional) TACAN Channel to be used, will always be an "Y" channel
---@return EASYGCICAP #self 
function EASYGCICAP:_AddTankerSquadron(TemplateName, SquadName, AirbaseName, AirFrames, Skill, Modex, Livery, Frequency, Modulation, TACAN) end

---Here, we'll decide if we need to launch an intercepting flight, and from where
---
------
---@param self EASYGCICAP 
---@param Cluster INTEL.Cluster 
---@return EASYGCICAP #self 
function EASYGCICAP:_AssignIntercept(Cluster) end

---Count alive missions in our internal stack.
---
------
---@param self EASYGCICAP 
---@return number #count
function EASYGCICAP:_CountAliveAuftrags() end

---(Internal) Create actual AirWings from the list
---
------
---@param self EASYGCICAP 
---@return EASYGCICAP #self 
function EASYGCICAP:_CreateAirwings() end

---(Internal) Create actual Squadrons from the list
---
------
---@param self EASYGCICAP 
---@return EASYGCICAP #self 
function EASYGCICAP:_CreateSquads() end

---(Internal) Set actual Awacs Points from the list
---
------
---@param self EASYGCICAP 
---@return EASYGCICAP #self 
function EASYGCICAP:_SetAwacsPatrolPoints() end

---(Internal) Set actual PatrolPoints from the list
---
------
---@param self EASYGCICAP 
---@return EASYGCICAP #self 
function EASYGCICAP:_SetCAPPatrolPoints() end

---(Internal) Set actual PatrolPoints from the list
---
------
---@param self EASYGCICAP 
---@return EASYGCICAP #self 
function EASYGCICAP:_SetReconPatrolPoints() end

---(Internal) Set actual Tanker Points from the list
---
------
---@param self EASYGCICAP 
---@return EASYGCICAP #self 
function EASYGCICAP:_SetTankerPatrolPoints() end

---(Internal) Start detection.
---
------
---@param self EASYGCICAP 
---@return EASYGCICAP #self
function EASYGCICAP:_StartIntel() end

---(Internal) Try to assign the intercept to a FlightGroup already in air and ready.
---
------
---@param self EASYGCICAP 
---@param ReadyFlightGroups table ReadyFlightGroups
---@param InterceptAuftrag AUFTRAG The Auftrag
---@param Group GROUP The Target
---@param WingSize number Calculated number of Flights
---@return boolean #assigned
---@return number #leftover
function EASYGCICAP:_TryAssignIntercept(ReadyFlightGroups, InterceptAuftrag, Group, WingSize) end

---(Internal) FSM Function onafterStart
---
------
---@param self EASYGCICAP 
---@param From string 
---@param Event string 
---@param To string 
---@return EASYGCICAP #self
function EASYGCICAP:onafterStart(From, Event, To) end

---(Internal) FSM Function onafterStatus
---
------
---@param self EASYGCICAP 
---@param From string 
---@param Event string 
---@param To string 
---@return EASYGCICAP #self
function EASYGCICAP:onafterStatus(From, Event, To) end

---(Internal) FSM Function onafterStop
---
------
---@param self EASYGCICAP 
---@param From string 
---@param Event string 
---@param To string 
---@return EASYGCICAP #self
function EASYGCICAP:onafterStop(From, Event, To) end

---(Internal) FSM Function onbeforeStatus
---
------
---@param self EASYGCICAP 
---@param From string 
---@param Event string 
---@param To string 
---@return EASYGCICAP #self
function EASYGCICAP:onbeforeStatus(From, Event, To) end


---Internal CapPoint data type
---@class EASYGCICAP.CapPoint 
---@field AirbaseName string 
---@field Altitude number 
---@field Coordinate COORDINATE 
---@field Heading number 
---@field LegLength number 
---@field Speed number 
EASYGCICAP.CapPoint = {}


---Internal Squadron data type
---@class EASYGCICAP.Squad 
---@field AWACS boolean 
---@field AirFrames number 
---@field AirbaseName string 
---@field Frequency number 
---@field Livery string 
---@field Modex string 
---@field Modulation number 
---@field RECON boolean 
---@field Skill string 
---@field SquadName string 
---@field TACAN number 
---@field Tanker boolean 
---@field TemplateName string 
EASYGCICAP.Squad = {}


---Internal Wing data type
---@class EASYGCICAP.Wing 
---@field AirbaseName string 
---@field Alias string 
---@field CapZoneName string 
EASYGCICAP.Wing = {}



