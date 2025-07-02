---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/OPS_CSAR.jpg" width="100%">
---
---**Ops** - Combat Search and Rescue.
---
---===
---
---**CSAR** - MOOSE based Helicopter CSAR Operations.
---
---===
---
---## Missions:--- **Ops** -- Combat Search and Rescue.
---
---===
---
---**CSAR** - MOOSE based Helicopter CSAR Operations.
---
---===
---
---## Missions:
---
---### [CSAR - Combat Search & Rescue](https://github.com/FlightControl-Master/MOOSE_MISSIONS/tree/develop/Ops/CSAR)
---
---===
---
---**Main Features:**
---
---   * MOOSE-based Helicopter CSAR Operations for Players.
---
---===
---
---### Author: **Applevangelist** (Moose Version), ***Ciribob*** (original), Thanks to: Shadowze, Cammel (testing), The Chosen One (Persistence)
---*Combat search and rescue (CSAR) are search and rescue operations that are carried out during war that are within or near combat zones.* (Wikipedia)
---
---===
---
---# CSAR Concept
---
--- * MOOSE-based Helicopter CSAR Operations for Players.
--- * Object oriented refactoring of Ciribob\'s fantastic CSAR script.
--- * No need for extra MIST loading. 
--- * Additional events to tailor your mission.
--- * Optional SpawnCASEVAC to create casualties without beacon (e.g. handling dead ground vehicles and create CASVAC requests).
---
---## 0. Prerequisites
---
---You need to load an .ogg soundfile for the pilot\'s beacons into the mission, e.g. "beacon.ogg", use a once trigger, "sound to country" for that.
---Create a late-activated single infantry unit as template in the mission editor and name it e.g. "Downed Pilot".
---
---Example sound files are here: [Moose Sound](https://github.com/FlightControl-Master/MOOSE_SOUND/tree/master/CTLD%20CSAR)
---
---## 1. Basic Setup
---
---A basic setup example is the following:
---       
---       -- Instantiate and start a CSAR for the blue side, with template "Downed Pilot" and alias "Luftrettung"
---       local my_csar = CSAR:New(coalition.side.BLUE,"Downed Pilot","Luftrettung")
---       -- options
---       my_csar.immortalcrew = true -- downed pilot spawn is immortal
---       my_csar.invisiblecrew = false -- downed pilot spawn is visible
---       -- start the FSM
---       my_csar:__Start(5)
---
---## 2. Options
---
---The following options are available (with their defaults). Only set the ones you want changed:
---
---        mycsar.allowDownedPilotCAcontrol = false -- Set to false if you don\'t want to allow control by Combined Arms.
---        mycsar.allowFARPRescue = true -- allows pilots to be rescued by landing at a FARP or Airbase. Else MASH only!
---        mycsar.FARPRescueDistance = 1000 -- you need to be this close to a FARP or Airport for the pilot to be rescued.
---        mycsar.autosmoke = false -- automatically smoke a downed pilot\'s location when a heli is near.
---        mycsar.autosmokedistance = 1000 -- distance for autosmoke
---        mycsar.coordtype = 1 -- Use Lat/Long DDM (0), Lat/Long DMS (1), MGRS (2), Bullseye imperial (3) or Bullseye metric (4) for coordinates.
---        mycsar.csarOncrash = false -- (WIP) If set to true, will generate a downed pilot when a plane crashes as well.
---        mycsar.enableForAI = false -- set to false to disable AI pilots from being rescued.
---        mycsar.pilotRuntoExtractPoint = true -- Downed pilot will run to the rescue helicopter up to mycsar.extractDistance in meters. 
---        mycsar.extractDistance = 500 -- Distance the downed pilot will start to run to the rescue helicopter.
---        mycsar.immortalcrew = true -- Set to true to make wounded crew immortal.
---        mycsar.invisiblecrew = false -- Set to true to make wounded crew insvisible.
---        mycsar.loadDistance = 75 -- configure distance for pilots to get into helicopter in meters.
---        mycsar.mashprefix = {"MASH"} -- prefixes of #GROUP objects used as MASHes. Will also try to add ZONE and STATIC objects with this prefix once at startup.
---        mycsar.max_units = 6 -- max number of pilots that can be carried if #CSAR.AircraftType is undefined.
---        mycsar.messageTime = 15 -- Time to show messages for in seconds. Doubled for long messages.
---        mycsar.radioSound = "beacon.ogg" -- the name of the sound file to use for the pilots\' radio beacons. 
---        mycsar.smokecolor = 4 -- Color of smokemarker, 0 is green, 1 is red, 2 is white, 3 is orange and 4 is blue.
---        mycsar.useprefix = true  -- Requires CSAR helicopter #GROUP names to have the prefix(es) defined below.
---        mycsar.csarPrefix = { "helicargo", "MEDEVAC"} -- #GROUP name prefixes used for useprefix=true - DO NOT use # in helicopter names in the Mission Editor! 
---        mycsar.verbose = 0 -- set to > 1 for stats output for debugging.
---        -- limit amount of downed pilots spawned by **ejection** events
---        mycsar.limitmaxdownedpilots = true
---        mycsar.maxdownedpilots = 10 
---        -- allow to set far/near distance for approach and optionally pilot must open doors
---        mycsar.approachdist_far = 5000 -- switch do 10 sec interval approach mode, meters
---        mycsar.approachdist_near = 3000 -- switch to 5 sec interval approach mode, meters
---        mycsar.pilotmustopendoors = false -- switch to true to enable check of open doors
---        mycsar.suppressmessages = false -- switch off all messaging if you want to do your own
---        mycsar.rescuehoverheight = 20 -- max height for a hovering rescue in meters
---        mycsar.rescuehoverdistance = 10 -- max distance for a hovering rescue in meters
---        -- Country codes for spawned pilots
---        mycsar.countryblue= country.id.USA
---        mycsar.countryred = country.id.RUSSIA
---        mycsar.countryneutral = country.id.UN_PEACEKEEPERS
---        mycsar.topmenuname = "CSAR" -- set the menu entry name
---        mycsar.ADFRadioPwr = 1000 -- ADF Beacons sending with 1KW as default
---        mycsar.PilotWeight = 80 --  Loaded pilots weigh 80kgs each
---        mycsar.AllowIRStrobe = false -- Allow a menu item to request an IR strobe to find a downed pilot at night (requires NVGs to see it).
---        mycsar.IRStrobeRuntime = 300 -- If an IR Strobe is activated, it runs for 300 seconds (5 mins).
--- 
---## 2.1 Create own SET_GROUP to manage CTLD Pilot groups
---
---        -- Parameter: Set The SET_GROUP object created by the mission designer/user to represent the CSAR pilot groups.
---        -- Needs to be set before starting the CSAR instance.
---        local myset = SET_GROUP:New():FilterPrefixes("Helikopter"):FilterCoalitions("red"):FilterStart()
---        mycsar:SetOwnSetPilotGroups(myset)
---        
---## 2.2 SRS Features and Other Features
---
---      mycsar.useSRS = false -- Set true to use FF\'s SRS integration
---      mycsar.SRSPath = "C:\\Progra~1\\DCS-SimpleRadio-Standalone\\" -- adjust your own path in your SRS installation -- server(!)
---      mycsar.SRSchannel = 300 -- radio channel
---      mycsar.SRSModulation = radio.modulation.AM -- modulation
---      mycsar.SRSport = 5002  -- and SRS Server port
---      mycsar.SRSCulture = "en-GB" -- SRS voice culture
---      mycsar.SRSVoice = nil -- SRS voice for downed pilot, relevant for Google TTS
---      mycsar.SRSGPathToCredentials = nil -- Path to your Google credentials json file, set this if you want to use Google TTS
---      mycsar.SRSVolume = 1 -- Volume, between 0 and 1
---      mycsar.SRSGender = "male" -- male or female voice
---      mycsar.CSARVoice = MSRS.Voices.Google.Standard.en_US_Standard_A -- SRS voice for CSAR Controller, relevant for Google TTS
---      mycsar.CSARVoiceMS = MSRS.Voices.Microsoft.Hedda -- SRS voice for CSAR Controller, relevant for MS Desktop TTS
---      mycsar.coordinate -- Coordinate from which CSAR TTS is sending. Defaults to a random MASH object position
---      --
---      mycsar.csarUsePara = false -- If set to true, will use the LandingAfterEjection Event instead of Ejection. Requires mycsar.enableForAI to be set to true. --shagrat
---      mycsar.wetfeettemplate = "man in floating thingy" -- if you use a mod to have a pilot in a rescue float, put the template name in here for wet feet spawns. Note: in conjunction with csarUsePara this might create dual ejected pilots in edge cases.
---      mycsar.allowbronco = false  -- set to true to use the Bronco mod as a CSAR plane
---      mycsar.CreateRadioBeacons = true -- set to false to disallow creating ADF radio beacons.
---       
---## 3. Results
---
---Number of successful landings with save pilots and aggregated number of saved pilots is stored in these variables in the object:
---     
---       mycsar.rescues -- number of successful landings *with* saved pilots
---       mycsar.rescuedpilots -- aggregated number of pilots rescued from the field (of *all* players)
---
---## 4. Events
---
--- The class comes with a number of FSM-based events that missions designers can use to shape their mission.
--- These are:
--- 
---### 4.1. PilotDown. 
---     
---     The event is triggered when a new downed pilot is detected. Use e.g. `function my_csar:OnAfterPilotDown(...)` to link into this event:
---     
---         function my_csar:OnAfterPilotDown(from, event, to, spawnedgroup, frequency, groupname, coordinates_text)
---           ... your code here ...
---         end
---   
---### 4.2. Approach. 
---     
---     A CSAR helicpoter is closing in on a downed pilot. Use e.g. `function my_csar:OnAfterApproach(...)` to link into this event:
---     
---         function my_csar:OnAfterApproach(from, event, to, heliname, groupname)
---           ... your code here ...
---         end
---   
---### 4.3. Boarded. 
---   
---     The pilot has been boarded to the helicopter. Use e.g. `function my_csar:OnAfterBoarded(...)` to link into this event:
---     
---         function my_csar:OnAfterBoarded(from, event, to, heliname, groupname, description)
---           ... your code here ...
---         end
---   
---### 4.4. Returning. 
---     
---      The CSAR helicopter is ready to return to an Airbase, FARP or MASH. Use e.g. `function my_csar:OnAfterReturning(...)` to link into this event:
---      
---         function my_csar:OnAfterReturning(from, event, to, heliname, groupname)
---           ... your code here ...
---         end
---   
---### 4.5. Rescued. 
---   
---     The CSAR helicopter has landed close to an Airbase/MASH/FARP and the pilots are safe. Use e.g. `function my_csar:OnAfterRescued(...)` to link into this event:
---     
---         function my_csar:OnAfterRescued(from, event, to, heliunit, heliname, pilotssaved)
---           ... your code here ...
---         end     
---
---## 5. Spawn downed pilots at location to be picked up.
--- 
---     If missions designers want to spawn downed pilots into the field, e.g. at mission begin to give the helicopter guys works, they can do this like so:
---     
---       -- Create downed "Pilot Wagner" in #ZONE "CSAR_Start_1" at a random point for the blue coalition
---       my_csar:SpawnCSARAtZone( "CSAR_Start_1", coalition.side.BLUE, "Pilot Wagner", true )
---
---     --Create a casualty and CASEVAC request from a "Point" (VEC2) for the blue coalition --shagrat
---     my_csar:SpawnCASEVAC(Point, coalition.side.BLUE)  
---     
---## 6. Save and load downed pilots - Persistance
---
---You can save and later load back downed pilots to make your mission persistent.
---For this to work, you need to de-sanitize **io** and **lfs** in your MissionScripting.lua, which is located in your DCS installtion folder under Scripts.
---There is a risk involved in doing that; if you do not know what that means, this is possibly not for you.
---
---Use the following options to manage your saves:
---
---             mycsar.enableLoadSave = true -- allow auto-saving and loading of files
---             mycsar.saveinterval = 600 -- save every 10 minutes
---             mycsar.filename = "missionsave.csv" -- example filename
---             mycsar.filepath = "C:\\Users\\myname\\Saved Games\\DCS\Missions\\MyMission" -- example path
--- 
--- Then use an initial load at the beginning of your mission:
--- 
---           mycsar:__Load(10)
---           
--- **Caveat:**
---Dropped troop noMessage and forcedesc parameters aren't saved.
---- **CSAR** class, extends Core.Base#BASE, Core.Fsm#FSM
---@class CSAR : FSM
---@field ADFRadioPwr number 
---@field AircraftType CSAR.AircraftType 
---@field BeaconTimer NOTYPE 
---@field CSARVoice NOTYPE 
---@field CSARVoiceMS NOTYPE 
---@field CallsignTranslations NOTYPE 
---@field ClassName string Name of the class.
---@field FARPRescueDistance number 
---@field FreeVHFFrequencies NOTYPE 
---@field PilotWeight number 
---@field PlayerTaskQueue NOTYPE 
---@field SRSCulture string 
---@field SRSGender string 
---@field SRSModulation NOTYPE 
---@field SRSPath string 
---@field SRSQueue MSRSQUEUE 
---@field SRSVoice NOTYPE 
---@field SRSVolume number 
---@field SRSchannel number 
---@field SRSport number 
---@field ShortCallsign boolean 
---@field UsedVHFFrequencies table 
---@field UserSetGroup SET_GROUP Set of CSAR heli groups as designed by the mission designer (if any set).
---@field private addedTo table 
---@field private alias NOTYPE 
---@field private allheligroupset SET_GROUP Set of CSAR heli groups.
---@field private allowDownedPilotCAcontrol boolean 
---@field private allowFARPRescue boolean 
---@field private allowbronco boolean 
---@field private approachdist_far number 
---@field private approachdist_near number 
---@field private autosmoke boolean 
---@field private autosmokedistance number 
---@field private beaconRefresher number 
---@field private coalition number Coalition side number, e.g. `coalition.side.RED`.
---@field private coalitiontxt NOTYPE 
---@field private coordinate NOTYPE 
---@field private coordtype number 
---@field private countryblue NOTYPE 
---@field private countryneutral NOTYPE 
---@field private countryred NOTYPE 
---@field private csarOncrash boolean 
---@field private csarPrefix table 
---@field private csarUnits table 
---@field private csarUsePara boolean 
---@field private downedPilots table 
---@field private downedpilotcounter number 
---@field private enableForAI boolean 
---@field private enableLoadSave boolean 
---@field private extractDistance number 
---@field private filename NOTYPE 
---@field private heliCloseMessage table 
---@field private heliVisibleMessage table 
---@field private hoverStatus table 
---@field private immortalcrew boolean 
---@field private inTransitGroups table 
---@field private invisiblecrew boolean 
---@field private landedStatus table 
---@field private lastCrash table 
---@field private lid string Class id string for output to DCS log file.
---@field private limitmaxdownedpilots boolean 
---@field private loadDistance number 
---@field private loadtimemax number 
---@field private mash NOTYPE 
---@field private mashprefix table 
---@field private max_units number 
---@field private maxdownedpilots number 
---@field private messageTime number 
---@field private msrs MSRS 
---@field private pilotRuntoExtractPoint boolean 
---@field private pilotmustopendoors boolean 
---@field private radioSound string 
---@field private rescuedpilots number 
---@field private rescuehoverdistance number 
---@field private rescuehoverheight number 
---@field private rescues number 
---@field private saveinterval number 
---@field private smokeMarkers table 
---@field private smokecolor number 
---@field private staticmashes NOTYPE 
---@field private suppressmessages boolean 
---@field private takenOff table 
---@field private useSRS boolean 
---@field private useprefix boolean 
---@field private usewetfeet boolean 
---@field private verbose number Verbosity level.
---@field private version string CSAR class version.
---@field private woundedGroups table 
---@field private zonemashes NOTYPE 
CSAR = {}

---(User) Add a PLAYERTASK - FSM events will check success
---
------
---@param PlayerTask PLAYERTASK 
---@return CSAR #self
function CSAR:AddPlayerTask(PlayerTask) end

---Triggers the FSM event "Save".
---
------
function CSAR:Load() end

---Create a new CSAR object and start the FSM.
---
------
---@param Coalition number Coalition side. Can also be passed as a string "red", "blue" or "neutral".
---@param Template string Name of the late activated infantry unit standing in for the downed pilot.
---@param Alias string An *optional* alias how this object is called in the logs etc.
---@return CSAR #self
function CSAR:New(Coalition, Template, Alias) end

---On After "Aproach" event.
---Heli close to downed Pilot.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Heliname string Name of the helicopter group.
---@param Woundedgroupname string Name of the downed pilot\'s group.
function CSAR:OnAfterApproach(From, Event, To, Heliname, Woundedgroupname) end

---On After "Boarded" event.
---Downed pilot boarded heli.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Heliname string Name of the helicopter group.
---@param Woundedgroupname string Name of the downed pilot\'s group.
---@param Description string Descriptive name of the group.
function CSAR:OnAfterBoarded(From, Event, To, Heliname, Woundedgroupname, Description) end

---On After "KIA" event.
---Pilot is dead.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Pilotname string Name of the pilot KIA.
function CSAR:OnAfterKIA(From, Event, To, Pilotname) end

---On After "Landed" event.
---Heli landed at an airbase.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param HeliName string Name of the #UNIT which has landed.
---@param Airbase AIRBASE Airbase where the heli landed.
function CSAR:OnAfterLanded(From, Event, To, HeliName, Airbase) end

---FSM Function OnAfterLoad.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param path? string (Optional) Path where the file is located. Default is the DCS root installation folder or your "Saved Games\\DCS" folder if the lfs module is desanitized.
---@param filename? string (Optional) File name for loading. Default is "CSAR_<alias>_Persist.csv".
function CSAR:OnAfterLoad(From, Event, To, path, filename) end

---On After "PilotDown" event.
---Downed Pilot detected.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Group GROUP Group object of the downed pilot.
---@param Frequency number Beacon frequency in kHz.
---@param Leadername string Name of the #UNIT of the downed pilot.
---@param CoordinatesText string String of the position of the pilot. Format determined by self.coordtype.
---@param Playername string Player name if any given. Might be nil!
function CSAR:OnAfterPilotDown(From, Event, To, Group, Frequency, Leadername, CoordinatesText, Playername) end

---On After "Rescued" event.
---Pilot(s) have been brought to the MASH/FARP/AFB.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param HeliUnit UNIT Unit of the helicopter.
---@param HeliName string Name of the helicopter group.
---@param PilotsSaved number Number of the saved pilots on board when landing.
function CSAR:OnAfterRescued(From, Event, To, HeliUnit, HeliName, PilotsSaved) end

---On After "Returning" event.
---Heli can return home with downed pilot(s).
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Heliname string Name of the helicopter group.
---@param Woundedgroupname string Name of the downed pilot\'s group.
function CSAR:OnAfterReturning(From, Event, To, Heliname, Woundedgroupname) end

---FSM Function OnAfterSave.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param path? string (Optional) Path where the file is saved. Default is the DCS root installation folder or your "Saved Games\\DCS" folder if the lfs module is desanitized.
---@param filename? string (Optional) File name for saving. Default is "CSAR_<alias>_Persist.csv".
function CSAR:OnAfterSave(From, Event, To, path, filename) end

---[User] Set callsign options for TTS output.
---See Wrapper.Group#GROUP.GetCustomCallSign() on how to set customized callsigns.
---
------
---@param ShortCallsign boolean If true, only call out the major flight number
---@param Keepnumber boolean If true, keep the **customized callsign** in the #GROUP name for players as-is, no amendments or numbers.
---@param CallsignTranslations? table (optional) Table to translate between DCS standard callsigns and bespoke ones. Does not apply if using customized callsigns from playername or group name.
---@return CSAR #self
function CSAR:SetCallSignOptions(ShortCallsign, Keepnumber, CallsignTranslations) end

---User - Function to add onw SET_GROUP Set-up for pilot filtering and assignment.
---Needs to be set before starting the CSAR instance.
---
------
---@param Set SET_GROUP The SET_GROUP object created by the mission designer/user to represent the CSAR pilot groups.
---@return CSAR #self 
function CSAR:SetOwnSetPilotGroups(Set) end

---Function to add a CSAR object into the scene at a zone coordinate.
---For mission designers wanting to add e.g. PoWs to the scene.
---
------
---
---USAGE
---```
---If missions designers want to spawn downed pilots into the field, e.g. at mission begin, to give the helicopter guys work, they can do this like so:
---     
---       -- Create casualty  "CASEVAC" at coordinate Core.Point#COORDINATE for the blue coalition.
---       my_csar:SpawnCASEVAC( coordinate, coalition.side.BLUE )
---```
------
---@param Point COORDINATE 
---@param Coalition number Coalition.
---@param Description? string (optional) Description.
---@param Nomessage? boolean (optional) If true, don\'t send a message to SAR.
---@param Unitname? string (optional) Name of the lost unit.
---@param Typename? string (optional) Type of plane.
---@param Forcedesc? boolean (optional) Force to use the **description passed only** for the pilot track entry. Use to have fully custom names.
function CSAR:SpawnCASEVAC(Point, Coalition, Description, Nomessage, Unitname, Typename, Forcedesc) end

---Function to add a CSAR object into the scene at a zone coordinate.
---For mission designers wanting to add e.g. PoWs to the scene.
---
------
---
---USAGE
---```
---If missions designers want to spawn downed pilots into the field, e.g. at mission begin, to give the helicopter guys work, they can do this like so:
---     
---       -- Create downed "Pilot Wagner" in #ZONE "CSAR_Start_1" at a random point for the blue coalition
---       my_csar:SpawnCSARAtZone( "CSAR_Start_1", coalition.side.BLUE, "Wagner", true, false, "Charly-1-1", "F5E" )
---```
------
---@param Zone string Name of the zone. Can also be passed as a (normal, round) ZONE object.
---@param Coalition number Coalition.
---@param Description? string (optional) Description.
---@param RandomPoint? boolean (optional) Random yes or no.
---@param Nomessage? boolean (optional) If true, don\'t send a message to SAR.
---@param Unitname? string (optional) Name of the lost unit.
---@param Typename? string (optional) Type of plane.
---@param Forcedesc? boolean (optional) Force to use the **description passed only** for the pilot track entry. Use to have fully custom names.
function CSAR:SpawnCSARAtZone(Zone, Coalition, Description, RandomPoint, Nomessage, Unitname, Typename, Forcedesc) end

---Triggers the FSM event "Start".
---Starts the CSAR. Initializes parameters and starts event handlers.
---
------
function CSAR:Start() end

---Triggers the FSM event "Status".
---
------
function CSAR:Status() end

---(Internal) Function to add beacon to downed pilot.
---
------
---@param _group GROUP Group #GROUP object.
---@param _freq number Frequency to use
---@param BeaconName string Beacon Name to use
---@return CSAR #self
function CSAR:_AddBeaconToGroup(_group, _freq, BeaconName) end

---(Internal) Function to spawn a CSAR object into the scene.
---
------
---@param _coalition number Coalition
---@param _country country.id Country ID
---@param _point COORDINATE Coordinate
---@param _typeName string Typename
---@param _unitName string Unitname
---@param _playerName string Playername
---@param _freq number Frequency
---@param noMessage boolean 
---@param _description string Description
---@param forcedesc boolean Use the description only for the pilot track entry
---@return GROUP #PilotInField Pilot GROUP object
---@return string #AliasName Alias display name
function CSAR:_AddCsar(_coalition, _country, _point, _typeName, _unitName, _playerName, _freq, noMessage, _description, forcedesc) end

---(Internal) Populate F10 menu for CSAR players.
---
------
function CSAR:_AddMedevacMenuItem() end

---(Internal) Add options to a downed pilot
---
------
---@param group GROUP Group to use.
function CSAR:_AddSpecialOptions(group) end

---(Internal) Function to check if heli is close to group.
---
------
---@param _distance number 
---@param _heliUnit UNIT 
---@param _heliName string 
---@param _woundedGroup GROUP 
---@param _woundedGroupName string 
---@return boolean #Outcome
function CSAR:_CheckCloseWoundedGroup(_distance, _heliUnit, _heliName, _woundedGroup, _woundedGroupName) end

---(Internal) Function called before Status() event.
---
------
function CSAR:_CheckDownedPilotTable() end

---(Internal) Check if a name is in downed pilot table
---
------
---@param name string Name to search for.
---@return boolean #Outcome.
---@return CSAR.DownedPilot #Table if found else nil.
function CSAR:_CheckNameInDownedPilots(name) end

---(Internal) Display onboarded rescued pilots.
---
------
---@param _unitName string Name of the chopper
function CSAR:_CheckOnboard(_unitName) end

---(Internal) Check state of wounded group.
---
------
---@param heliname string heliname
---@param woundedgroupname string woundedgroupname
function CSAR:_CheckWoundedGroupStatus(heliname, woundedgroupname) end

---(Internal) Helper function to count active downed pilots.
---
------
---@return number #Number of pilots in the field.
function CSAR:_CountActiveDownedPilots() end

---(Internal) Function to insert downed pilot tracker object.
---
------
---@param Group GROUP The #GROUP object
---@param Groupname string Name of the spawned group.
---@param Side number Coalition.
---@param OriginalUnit string Name of original Unit.
---@param Description string Descriptive text.
---@param Typename string Typename of unit.
---@param Frequency number Frequency of the NDB in Hz
---@param Playername string Name of Player (if applicable)
---@param Wetfeet boolean Ejected over water
---@param BeaconName NOTYPE 
---@return CSAR #self.
function CSAR:_CreateDownedPilotTrack(Group, Groupname, Side, OriginalUnit, Description, Typename, Frequency, Playername, Wetfeet, BeaconName) end

---(Internal) Display active SAR tasks to player.
---
------
---@param _unitName string Unit to display to
function CSAR:_DisplayActiveSAR(_unitName) end

---(Internal) Display message to single Unit.
---
------
---@param _unit UNIT Unit #UNIT to display to.
---@param _text string Text of message.
---@param _time number Message show duration.
---@param _clear? boolean (optional) Clear screen.
---@param _speak? boolean (optional) Speak message via SRS.
---@param _override? boolean (optional) Override message suppression
function CSAR:_DisplayMessageToSAR(_unit, _text, _time, _clear, _speak, _override) end

---(Internal) Display info to all SAR groups.
---
------
---@param _message string Message to display.
---@param _side number Coalition of message. 
---@param _messagetime number How long to show.
---@param ToSRS boolean If true or nil, send to SRS TTS
---@param ToScreen boolean If true or nil, send to Screen
function CSAR:_DisplayToAllSAR(_message, _side, _messagetime, ToSRS, ToScreen) end

---(Internal) Function to check for dupe eject events.
---
------
---@param _unitname string Name of unit.
---@return boolean #Outcome
function CSAR:_DoubleEjection(_unitname) end

---(Internal) Event handler.
---
------
---@param EventData NOTYPE 
function CSAR:_EventHandler(EventData) end

---(Internal) Pop frequency from prepopulated table.
---
------
---@return number #frequency
function CSAR:_GenerateADFFrequency() end

---(Internal) Populate table with available beacon frequencies.
---
------
function CSAR:_GenerateVHFrequencies() end

---(Internal) Function to determine clockwise direction for flares.
---
------
---@param _heli UNIT The Helicopter
---@param _group GROUP The downed Group
---@return number #direction
function CSAR:_GetClockDirection(_heli, _group) end

---(Internal) Find the closest downed pilot to a heli.
---
------
---@param _heli UNIT Helicopter #UNIT
---@return table #Table of results
function CSAR:_GetClosestDownedPilot(_heli) end

---(Internal) Determine distance to closest MASH.
---
------
---@param _heli UNIT Helicopter #UNIT
---@return number #Distance in meters
---@return string #MASH Name as string
function CSAR:_GetClosestMASH(_heli) end

---(Internal) Check if a name is in downed pilot table and remove it.
---
------
---@param UnitName string 
---@return string #CallSign
function CSAR:_GetCustomCallSign(UnitName) end

---(Internal) Return distance in meters between two coordinates.
---
------
---@param _point1 COORDINATE Coordinate one
---@param _point2 COORDINATE Coordinate two
---@return number #Distance in meters
function CSAR:_GetDistance(_point1, _point2) end

---(Internal) Function to get string of a group\'s position.
---
------
---@param _woundedGroup CONTROLLABLE Group or Unit object.
---@param _Unit UNIT Requesting helo pilot unit
---@return string #Coordinates as Text
function CSAR:_GetPositionOfWounded(_woundedGroup, _Unit) end

---(Internal) Check and return Wrappe.Unit#UNIT based on the name if alive.
---
------
---@param _unitname string Name of Unit
---@param _unitName NOTYPE 
---@return UNIT #The unit or nil
function CSAR:_GetSARHeli(_unitname, _unitName) end

---(Internal)  Initialize the action for a pilot.
---
------
---@param _downedGroup GROUP The group to rescue.
---@param _GroupName string Name of the Group
---@param _freq number Beacon frequency.
---@param _nomessage boolean Send message true or false.
---@param _playername string Name of the downed pilot if any
function CSAR:_InitSARForPilot(_downedGroup, _GroupName, _freq, _nomessage, _playername) end

---(internal) Function to check if the heli door(s) are open.
---Thanks to Shadowze.
---
------
---@param unit_name string Name of unit.
---@return boolean #outcome The outcome.
function CSAR:_IsLoadingDoorOpen(unit_name) end

---(Internal) Move group to destination.
---
------
---@param _leader GROUP 
---@param _destination COORDINATE 
function CSAR:_OrderGroupToMoveToPoint(_leader, _destination) end

---(Internal) Function to pickup the wounded pilot from the ground.
---
------
---@param _heliUnit UNIT Object of the group.
---@param _pilotName string Name of the pilot.
---@param _woundedGroup GROUP Object of the group.
---@param _woundedGroupName string Name of the group.
function CSAR:_PickupUnit(_heliUnit, _pilotName, _woundedGroup, _woundedGroupName) end

---(Internal) Count pilots on board.
---
------
---@param _heliName string 
---@return number #count  
function CSAR:_PilotsOnboard(_heliName) end

---(Internal) Function to pop a smoke at a wounded pilot\'s positions.
---
------
---@param _woundedGroupName string Name of the group.
---@param _woundedLeader GROUP Object of the group.
function CSAR:_PopSmokeForGroup(_woundedGroupName, _woundedLeader) end

---(Internal) Helper to decide if we're over max limit.
---
------
---@return boolean #True or false.
function CSAR:_ReachedPilotLimit() end

---(Internal) Helper function to (re-)add beacon to downed pilot.
---
------
---@return CSAR #self
function CSAR:_RefreshRadioBeacons() end

---(Internal) Check if a name is in downed pilot table and remove it.
---
------
---@param name string Name to search for.
---@param force boolean Force removal.
---@return boolean #Outcome.
function CSAR:_RemoveNameFromDownedPilots(name, force) end

---(Internal) Request IR Strobe at closest downed pilot.
---
------
---@param _unitName string Name of the helicopter
function CSAR:_ReqIRStrobe(_unitName) end

---(Internal) Request smoke at closest downed pilot.
---
------
---@param _unitName string Name of the helicopter
function CSAR:_Reqsmoke(_unitName) end

---(Internal) Mark pilot as rescued and remove from tables.
---
------
---@param _heliUnit UNIT 
function CSAR:_RescuePilots(_heliUnit) end

---(Internal) Monitor in-flight returning groups.
---
------
---@param heliname string Heli name
---@param groupname string Group name
---@param isairport boolean If true, EVENT.Landing took place at an airport or FARP
---@param noreschedule boolean If true, do not try to reschedule this is distances are not ok (coming from landing event)
function CSAR:_ScheduledSARFlight(heliname, groupname, isairport, noreschedule) end

---(Internal) Fire a flare at the point of a downed pilot.
---
------
---@param _unitName string Name of the unit.
function CSAR:_SignalFlare(_unitName) end

---(Internal) Function to add a CSAR object into the scene at a Point coordinate (VEC_2).
---For mission designers wanting to add e.g. casualties to the scene, that don't use beacons.
---
------
---@param _Point COORDINATE 
---@param _coalition number Coalition.
---@param _description? string (optional) Description.
---@param _nomessage? boolean (optional) If true, don\'t send a message to SAR.
---@param unitname? string (optional) Name of the lost unit.
---@param typename? string (optional) Type of plane.
---@param forcedesc? boolean (optional) Force to use the description passed only for the pilot track entry. Use to have fully custom names.
function CSAR:_SpawnCASEVAC(_Point, _coalition, _description, _nomessage, unitname, typename, forcedesc) end

---(Internal) Function to add a CSAR object into the scene at a zone coordinate.
---For mission designers wanting to add e.g. PoWs to the scene.
---
------
---@param _zone string Name of the zone. Can also be passed as a (normal, round) ZONE object.
---@param _coalition number Coalition.
---@param _description? string (optional) Description.
---@param _randomPoint? boolean (optional) Random yes or no.
---@param _nomessage? boolean (optional) If true, don\'t send a message to SAR.
---@param unitname? string (optional) Name of the lost unit.
---@param typename? string (optional) Type of plane.
---@param forcedesc? boolean (optional) Force to use the description passed only for the pilot track entry. Use to have fully custom names.
function CSAR:_SpawnCsarAtZone(_zone, _coalition, _description, _randomPoint, _nomessage, unitname, typename, forcedesc) end

---(Internal) Spawn a downed pilot
---
------
---@param country number Country for template.
---@param point COORDINATE Coordinate to spawn at.
---@param frequency number Frequency of the pilot's beacon
---@param wetfeet boolean Spawn is over water
---@return GROUP #group The #GROUP object.
---@return string #alias The alias name.
function CSAR:_SpawnPilotInField(country, point, frequency, wetfeet) end

---(Internal) Function to calculate and set Unit internal cargo mass
---
------
---@param _heliName string Unit name
---@return CSAR #self
function CSAR:_UpdateUnitCargoMass(_heliName) end

---Triggers the FSM event "Load" after a delay.
---
------
---@param delay number Delay in seconds.
function CSAR:__Load(delay) end

---Triggers the FSM event "Save" after a delay.
---
------
---@param delay number Delay in seconds.
function CSAR:__Save(delay) end

---Triggers the FSM event "Start" after a delay.
---Starts the CSAR. Initializes parameters and starts event handlers.
---
------
---@param delay number Delay in seconds.
function CSAR:__Start(delay) end

---Triggers the FSM event "Status" after a delay.
---
------
---@param delay number Delay in seconds.    --- Triggers the FSM event "Load".
---@param self CSAR 
function CSAR:__Status(delay, self) end

---Triggers the FSM event "Stop" after a delay.
---Stops the CSAR and all its event handlers.
---
------
---@param delay number Delay in seconds.
function CSAR:__Stop(delay) end

---On after "Load" event.
---Loads dropped units from file.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param path? string (Optional) Path where the file is located. Default is the DCS root installation folder or your "Saved Games\\DCS" folder if the lfs module is desanitized.
---@param filename? string (Optional) File name for loading. Default is "CSAR_<alias>_Persist.csv".
---@private
function CSAR:onafterLoad(From, Event, To, path, filename) end

---On after "Save" event.
---Player data is saved to file.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param path string Path where the file is saved. If nil, file is saved in the DCS root installtion directory or your "Saved Games" folder if lfs was desanitized.
---@param filename? string (Optional) File name for saving. Default is Default is "CSAR_<alias>_Persist.csv".
---@private
function CSAR:onafterSave(From, Event, To, path, filename) end

---(Internal) Function called after Start() event.
---
------
---@param From string From state.
---@param Event string Event triggered.
---@param To string To state.
---@private
function CSAR:onafterStart(From, Event, To) end

---(Internal) Function called after Status() event.
---
------
---@param From string From state.
---@param Event string Event triggered.
---@param To string To state.
---@private
function CSAR:onafterStatus(From, Event, To) end

---(Internal) Function called after Stop() event.
---
------
---@param From string From state.
---@param Event string Event triggered.
---@param To string To state.
---@private
function CSAR:onafterStop(From, Event, To) end

---(Internal) Function called before Approach() event.
---
------
---@param From string From state.
---@param Event string Event triggered.
---@param To string To state.
---@param Heliname string Name of the helicopter group.
---@param Woundedgroupname string Name of the downed pilot\'s group.
---@private
function CSAR:onbeforeApproach(From, Event, To, Heliname, Woundedgroupname) end

---(Internal) Function called before Boarded() event.
---
------
---@param From string From state.
---@param Event string Event triggered.
---@param To string To state.
---@param Heliname string Name of the helicopter group.
---@param Woundedgroupname string Name of the downed pilot\'s group.
---@private
function CSAR:onbeforeBoarded(From, Event, To, Heliname, Woundedgroupname) end

---(Internal) Function called before Landed() event.
---
------
---@param From string From state.
---@param Event string Event triggered.
---@param To string To state.
---@param HeliName string Name of the #UNIT which has landed.
---@param Airbase AIRBASE Airbase where the heli landed.
---@private
function CSAR:onbeforeLanded(From, Event, To, HeliName, Airbase) end

---On before "Load" event.
---Checks if io and lfs and the file are available.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param path? string (Optional) Path where the file is located. Default is the DCS root installation folder or your "Saved Games\\DCS" folder if the lfs module is desanitized.
---@param filename? string (Optional) File name for loading. Default is "CSAR_<alias>_Persist.csv".
---@private
function CSAR:onbeforeLoad(From, Event, To, path, filename) end

---(Internal) Function called before PilotDown() event.
---
------
---@param From string From state.
---@param Event string Event triggered.
---@param To string To state.
---@param Group GROUP Group object of the downed pilot.
---@param Frequency number Beacon frequency in kHz.
---@param Leadername string Name of the #UNIT of the downed pilot.
---@param CoordinatesText string String of the position of the pilot. Format determined by self.coordtype.
---@param Playername string Player name if any given. Might be nil!
---@private
function CSAR:onbeforePilotDown(From, Event, To, Group, Frequency, Leadername, CoordinatesText, Playername) end

---(Internal) Function called before Rescued() event.
---
------
---@param From string From state.
---@param Event string Event triggered.
---@param To string To state.
---@param HeliUnit UNIT Unit of the helicopter.
---@param HeliName string Name of the helicopter group.
---@param PilotsSaved number Number of the saved pilots on board when landing.
---@private
function CSAR:onbeforeRescued(From, Event, To, HeliUnit, HeliName, PilotsSaved) end

---(Internal) Function called before Returning() event.
---
------
---@param From string From state.
---@param Event string Event triggered.
---@param To string To state.
---@param Heliname string Name of the helicopter group.
---@param Woundedgroupname string Name of the downed pilot\'s group.
---@param IsAirport boolean True if heli has landed on an AFB (from event land).
---@param IsAirPort NOTYPE 
---@private
function CSAR:onbeforeReturning(From, Event, To, Heliname, Woundedgroupname, IsAirport, IsAirPort) end

---On before "Save" event.
---Checks if io and lfs are available.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param path? string (Optional) Path where the file is saved. Default is the DCS root installation folder or your "Saved Games\\DCS" folder if the lfs module is desanitized.
---@param filename? string (Optional) File name for saving. Default is "CSAR_<alias>_Persist.csv".
---@private
function CSAR:onbeforeSave(From, Event, To, path, filename) end

---(Internal) Function called before Status() event.
---
------
---@param From string From state.
---@param Event string Event triggered.
---@param To string To state.
---@private
function CSAR:onbeforeStatus(From, Event, To) end


---All slot / Limit settings
---@class CSAR.AircraftType 
---@field AH-64D_BLK_II number 
---@field Bell-47 number 
---@field Bronco-OV-10A number 
---@field CH-47Fbl1 number 
---@field MH-60R number 
---@field Mi-24P number 
---@field Mi-24V number 
---@field Mi-8MT number 
---@field Mi-8MTV2 number 
---@field OH-6A number 
---@field OH58D number 
---@field SA342L number 
---@field SA342M number 
---@field SA342Minigun number 
---@field SA342Mistral number 
---@field UH-1H number 
---@field UH-60L number 
---@field private typename string Unit type name.
CSAR.AircraftType = {}


---Downed pilots info.
---@class CSAR.DownedPilot 
---@field BeaconName string Name of radio beacon - if any.
---@field private alive boolean Group is alive or dead/rescued.
---@field private desc string Description.
---@field private frequency number Frequency of the NDB.
---@field private group GROUP Spawned group object.
---@field private index number Pilot index.
---@field private name string Name of the spawned group.
---@field private originalUnit string Name of the original unit.
---@field private player string Player name if applicable.
---@field private side number Coalition.
---@field private timestamp number Timestamp for approach process.
---@field private typename string Typename of Unit.
---@field private wetfeet boolean Group is spawned over (deep) water.
CSAR.DownedPilot = {}



