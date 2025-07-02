---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Ops_PlayerRecce.png" width="100%">
---
---**Ops** - Allow a player in a helo like the Gazelle, KA-50 to recon and lase ground targets.
---
---## Features:
---
---  * Allow a player in a helicopter to detect, smoke, flare, lase and report ground units to others.
---  * Implements visual detection from the helo
---  * Implements optical detection via the Gazelle Vivianne system and lasing
---  * KA-50 BlackShark basic support
---  * Everyone else gets visual detection only
---  * Upload target info to a PLAYERTASKCONTROLLER Instance
---
---===
---
---# Demo Missions
---
---### Demo missions can be found on [github](https://github.com/FlightControl-Master/MOOSE_MISSIONS/tree/develop/).
---
---===
---
---
---### Authors:
---
---  * Applevangelist (Design & Programming)
---  
---===
---@class Cameraheight 
---@field Ka-50 number 
---@field Ka-50_3 number 
---@field OH58D number 
---@field SA342L number 
---@field SA342M number 
---@field SA342Minigun number 
---@field SA342Mistral number 
---@field private typename string Unit type name
Cameraheight = {}


---@class CanLase 
---@field Ka-50 boolean 
---@field Ka-50_3 boolean 
---@field OH58D boolean 
---@field SA342L boolean 
---@field SA342M boolean 
---@field SA342Minigun boolean 
---@field SA342Mistral boolean 
---@field private typename string Unit type name
CanLase = {}


---@class FlareColor 
---@field private color string 
---@field private highflare NOTYPE 
---@field private laserflare NOTYPE 
---@field private lowflare NOTYPE 
---@field private medflare NOTYPE 
---@field private ownflare NOTYPE 
FlareColor = {}


---@class LaserRelativePos 
---@field Ka-50 table 
---@field Ka-50_3 table 
---@field OH58D table 
---@field SA342L table 
---@field SA342M table 
---@field SA342Minigun table 
---@field SA342Mistral table 
---@field private typename string Unit type name
LaserRelativePos = {}


---@class MaxViewDistance 
---@field Ka-50 number 
---@field Ka-50_3 number 
---@field OH58D number 
---@field SA342L number 
---@field SA342M number 
---@field SA342Minigun number 
---@field SA342Mistral number 
---@field private typename string Unit type name
MaxViewDistance = {}


---
---*It is our attitude at the beginning of a difficult task which, more than anything else, which will affect its successful outcome.* (William James)
---
---===
---
---# PLAYERRECCE 
---
---  * Allow a player in a helicopter to detect, smoke, flare, lase and report ground units to others.
---  * Implements visual detection from the helo
---  * Implements optical detection via the Gazelle Vivianne system and lasing
---  * KA-50 BlackShark basic support
---  * Everyone else gets visual detection only
---  * Upload target info to a PLAYERTASKCONTROLLER Instance
---   
---If you have questions or suggestions, please visit the [MOOSE Discord](https://discord.gg/AeYAkHP) channel.  
---
---PLAYERRECCE class.
---@class PLAYERRECCE : FSM
---@field AttackSet SET_CLIENT 
---@field AutoLase table 
---@field BCFrequency NOTYPE 
---@field BCModulation NOTYPE 
---@field CallsignCustomFunc NOTYPE 
---@field CallsignTranslations table 
---@field Cameraheight Cameraheight 
---@field CanLase CanLase 
---@field ClassName string Name of the class.
---@field ClientMenus table 
---@field Coalition number 
---@field CoalitionName string 
---@field Controller PLAYERTASKCONTROLLER 
---@field FlareColor FlareColor 
---@field Keepnumber boolean 
---@field LaserCodes table 
---@field LaserFOV table 
---@field LaserRelativePos LaserRelativePos 
---@field LaserSpots table 
---@field LaserTarget table 
---@field MaxViewDistance MaxViewDistance 
---@field MenuName NOTYPE 
---@field Name string 
---@field OnStation table 
---@field PathToGoogleKey NOTYPE 
---@field PlayerSet SET_CLIENT 
---@field RPMarker MARKER 
---@field RPName string 
---@field ReferencePoint COORDINATE 
---@field SRS MSRS 
---@field SRSQueue MSRSQUEUE 
---@field ShortCallsign boolean 
---@field SmokeColor SmokeColor 
---@field SmokeOwn table 
---@field TForget number 
---@field TargetCache FIFO 
---@field TransmitOnlyWithPlayers boolean 
---@field UnitLaserCodes table 
---@field UseController boolean 
---@field UseSRS boolean 
---@field ViewZone table 
---@field ViewZoneLaser table 
---@field ViewZoneVisual table 
---@field private debug boolean 
---@field private lasingtime number 
---@field private lid string Class id string for output to DCS log file.
---@field private minthreatlevel number 
---@field private reporttostringbullsonly boolean 
---@field private smokeaveragetargetpos boolean 
---@field private smokeownposition boolean 
---@field private timestamp NOTYPE 
---@field private verbose boolean Switch verbosity.
---@field private version string 
PLAYERRECCE = {}

---[User] Disable smoking of average target positions, instead of all targets visible.
---Default is - smoke all positions.
---
------
---@return PLAYERRECCE #
function PLAYERRECCE:DisableSmokeAverageTargetPosition() end

---[User] Disable smoking of own position
---
------
---@return PLAYERRECCE #
function PLAYERRECCE:DisableSmokeOwnPosition() end

---[User] Enable auto lasing for the Kiowa OH-58D.
---
------
---@return PLAYERRECCE #self
function PLAYERRECCE:EnableKiowaAutolase() end

---[User] Enable smoking of average target positions, instead of all targets visible.
---Loses smoke per threatlevel -- each is med threat. Default is - smoke all positions.
---
------
---@return PLAYERRECCE #self
function PLAYERRECCE:EnableSmokeAverageTargetPosition() end

---[User] Enable smoking of own position
---
------
---@return PLAYERRECCE #self
function PLAYERRECCE:EnableSmokeOwnPosition() end

---Create and run a new PlayerRecce instance.
---
------
---@param Name string The name of this instance
---@param Coalition number  e.g. coalition.side.BLUE
---@param PlayerSet SET_CLIENT The set of pilots working as recce
---@return PLAYERRECCE #self
function PLAYERRECCE:New(Name, Coalition, PlayerSet) end

---FSM Function OnAfterIllumination.
---Illumination rocket shot.
---
------
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@param Client CLIENT 
---@param Playername string 
---@param TargetSet SET_UNIT 
---@return PLAYERRECCE #self
function PLAYERRECCE:OnAfterIllumination(From, Event, To, Client, Playername, TargetSet) end

---FSM Function OnAfterRecceOffStation.
---Recce went off duty.
---
------
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@param Client CLIENT 
---@param Playername string 
---@return PLAYERRECCE #self
function PLAYERRECCE:OnAfterRecceOffStation(From, Event, To, Client, Playername) end

---FSM Function OnAfterRecceOnStation.
---Recce came on station.
---
------
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@param Client CLIENT 
---@param Playername string 
---@return PLAYERRECCE #self
function PLAYERRECCE:OnAfterRecceOnStation(From, Event, To, Client, Playername) end

---FSM Function OnAfterShack.
---Lased target has been destroyed.
---
------
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@param Client CLIENT 
---@param Target UNIT The destroyed target (if obtainable)
---@return PLAYERRECCE #self
function PLAYERRECCE:OnAfterShack(From, Event, To, Client, Target) end

---FSM Function OnAfterTargetDetected.
---Targets detected.
---
------
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@param Targetsbyclock table #table with index 1..12 containing a #table of Wrapper.Unit#UNIT objects each.
---@param Client CLIENT 
---@param Playername string 
---@return PLAYERRECCE #self
function PLAYERRECCE:OnAfterTargetDetected(From, Event, To, Targetsbyclock, Client, Playername) end

---FSM Function OnAfterTargetLOSLost.
---Lost LOS on lased target.
---
------
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@param Client CLIENT 
---@param Target UNIT 
---@return PLAYERRECCE #self
function PLAYERRECCE:OnAfterTargetLOSLost(From, Event, To, Client, Target) end

---FSM Function OnAfterTargetLasing.
---Lasing a new target.
---
------
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@param Client CLIENT 
---@param Target UNIT 
---@param Lasercode number 
---@param Lasingtime number 
---@return PLAYERRECCE #self
function PLAYERRECCE:OnAfterTargetLasing(From, Event, To, Client, Target, Lasercode, Lasingtime) end

---FSM Function OnAfterTargetReport.
---Laser target report sent.
---
------
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@param Client CLIENT 
---@param TargetSet SET_UNIT 
---@param Target UNIT Target currently lased
---@param Text string 
---@return PLAYERRECCE #self
function PLAYERRECCE:OnAfterTargetReport(From, Event, To, Client, TargetSet, Target, Text) end

---FSM Function OnAfterTargetReportSent.
---All targets report sent.
---
------
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@param Client CLIENT Client sending the report
---@param Playername string Player name
---@param TargetSet SET_UNIT Set of targets
---@return PLAYERRECCE #self
function PLAYERRECCE:OnAfterTargetReportSent(From, Event, To, Client, Playername, TargetSet) end

---FSM Function OnAfterTargetsFlared.
---Flares shot.
---
------
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@param Client CLIENT 
---@param Playername string 
---@param TargetSet SET_UNIT 
---@return PLAYERRECCE #self
function PLAYERRECCE:OnAfterTargetsFlared(From, Event, To, Client, Playername, TargetSet) end

---FSM Function OnAfterTargetsSmoked.
---Smoke grenade shot.
---
------
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@param Client CLIENT 
---@param Playername string 
---@param TargetSet SET_UNIT 
---@return PLAYERRECCE #self
function PLAYERRECCE:OnAfterTargetsSmoked(From, Event, To, Client, Playername, TargetSet) end

---[User] Set a set of clients which will receive target reports
---
------
---@param AttackSet SET_CLIENT 
---@return PLAYERRECCE #
function PLAYERRECCE:SetAttackSet(AttackSet) end

---[User] Set callsign options for TTS output.
---See Wrapper.Group#GROUP.GetCustomCallSign() on how to set customized callsigns.
---
------
---@param ShortCallsign boolean If true, only call out the major flight number
---@param Keepnumber boolean If true, keep the **customized callsign** in the #GROUP name for players as-is, no amendments or numbers.
---@param CallsignTranslations? table (optional) Table to translate between DCS standard callsigns and bespoke ones. Does not apply if using customized callsigns from playername or group name.
---@param CallsignCustomFunc? func (Optional) For player names only(!). If given, this function will return the callsign. Needs to take the groupname and the playername as first two arguments.
---@param ...? arg (Optional) Comma separated arguments to add to the custom function call after groupname and playername.
---@return PLAYERRECCE #self
function PLAYERRECCE:SetCallSignOptions(ShortCallsign, Keepnumber, CallsignTranslations, CallsignCustomFunc, ...) end

---[User] Set a table of possible laser codes.
---Each new RECCE can select a code from this table, default is { 1688, 1130, 4785, 6547, 1465, 4578 }.
---
------
---@param LaserCodes list 
---@return PLAYERRECCE #
function PLAYERRECCE:SetLaserCodes(LaserCodes) end

---[User] Set the top menu name to a custom string.
---
------
---@param Name string The name to use as the top menu designation.
---@return PLAYERRECCE #self
function PLAYERRECCE:SetMenuName(Name) end

---[User] Set PlayerTaskController.
---Allows to upload target reports to the controller, in turn creating tasks for other players.
---
------
---@param Controller PLAYERTASKCONTROLLER 
---@return PLAYERRECCE #
function PLAYERRECCE:SetPlayerTaskController(Controller) end

---[User] Set a reference point coordinate for A2G Operations.
---Will be used in coordinate references.
---
------
---@param Coordinate COORDINATE Coordinate of the RP
---@param Name string Name of the RP
---@return PLAYERRECCE #
function PLAYERRECCE:SetReferencePoint(Coordinate, Name) end

---[User] Set reporting to be BULLS only or BULLS plus playersettings based coordinate.
---
------
---@param OnOff boolean 
---@return PLAYERRECCE #self
function PLAYERRECCE:SetReportBullsOnly(OnOff) end

---[User] Set SRS TTS details - see Sound.SRS for details
---
------
---@param Frequency number Frequency to be used. Can also be given as a table of multiple frequencies, e.g. 271 or {127,251}. There needs to be exactly the same number of modulations!
---@param Modulation number Modulation to be used. Can also be given as a table of multiple modulations, e.g. radio.modulation.AM or {radio.modulation.FM,radio.modulation.AM}. There needs to be exactly the same number of frequencies!
---@param PathToSRS string Defaults to "C:\\Program Files\\DCS-SimpleRadio-Standalone"
---@param Gender? string (Optional) Defaults to "male"
---@param Culture? string (Optional) Defaults to "en-US"
---@param Port? number (Optional) Defaults to 5002
---@param Voice? string (Optional) Use a specifc voice with the @{Sound.SRS#SetVoice} function, e.g, `:SetVoice("Microsoft Hedda Desktop")`. Note that this must be installed on your windows system. Can also be Google voice types, if you are using Google TTS.
---@param Volume? number (Optional) Volume - between 0.0 (silent) and 1.0 (loudest)
---@param PathToGoogleKey? string (Optional) Path to your google key if you want to use google TTS
---@param Backend? string (optional) Backend to be used, can be MSRS.Backend.SRSEXE or MSRS.Backend.GRPC
---@return PLAYERRECCE #self
function PLAYERRECCE:SetSRS(Frequency, Modulation, PathToSRS, Gender, Culture, Port, Voice, Volume, PathToGoogleKey, Backend) end

---[User] For SRS - Switch to only transmit if there are players on the server.
---
------
---@param Switch boolean If true, only send SRS if there are alive Players.
---@return PLAYERRECCE #self
function PLAYERRECCE:SetTransmitOnlyWithPlayers(Switch) end

---Triggers the FSM event "Start".
---Starts the PLAYERRECCE. Note: Start() is called automatically after New().
---
------
function PLAYERRECCE:Start() end

---[Internal] Build Menus
---
------
---@param Client? CLIENT (optional) Client object
---@return PLAYERRECCE #self
function PLAYERRECCE:_BuildMenus(Client) end

---[Internal] Check Helicopter camera in on
---
------
---@param client CLIENT 
---@param playername string 
---@return boolean #OnOff
function PLAYERRECCE:_CameraOn(client, playername) end

---[Internal]
---
------
---@param targetset SET_UNIT 
---@param client CLIENT 
---@param playername string 
---@return PLAYERRECCE #self
function PLAYERRECCE:_CheckNewTargets(targetset, client, playername) end

--- [Internal]
---
------
---@return PLAYERRECCE #self
function PLAYERRECCE:_CleanupTargetCache() end

---[Internal] Event handling
---
------
---@param EventData EVENTDATA 
---@return PLAYERRECCE #self
function PLAYERRECCE:_EventHandler(EventData) end

---[Internal]
---
------
---@param client CLIENT 
---@param group GROUP 
---@param playername string 
---@return PLAYERRECCE #self
function PLAYERRECCE:_FlareTargets(client, group, playername) end

---[Internal] Get the max line of sight based on unit head and camera nod via trigonometry.
---Returns 0 if camera is off.
---
------
---@param unit UNIT The unit which LOS we want
---@param vheading number Heading where the unit or camera is looking
---@param vnod number Nod down in degrees
---@param vivoff boolean Camera on or off
---@return number #maxview Max view distance in meters
function PLAYERRECCE:_GetActualMaxLOSight(unit, vheading, vnod, vivoff) end

---(Internal) Function to determine clockwise direction to target.
---
------
---@param unit UNIT The Helicopter
---@param target UNIT The downed Group
---@return number #direction
function PLAYERRECCE:_GetClockDirection(unit, target) end

---[Internal] Get the view parameters from a Gazelle camera
---
------
---@param Gazelle UNIT 
---@return number #cameraheading in degrees.
---@return number #cameranodding in degrees.
---@return number #maxview in meters.
---@return boolean #cameraison If true, camera is on, else off.
function PLAYERRECCE:_GetGazelleVivianneSight(Gazelle) end

---[Internal]
---
------
---@param targetset SET_UNIT Set of targets, can be empty!
---@return UNIT #Target or nil
function PLAYERRECCE:_GetHVTTarget(targetset) end

---[Internal] Get the view parameters from a Kiowa MMS camera
---
------
---@param Kiowa UNIT 
---@return number #cameraheading in degrees.
---@return number #cameranodding in degrees.
---@return number #maxview in meters.
---@return boolean #cameraison If true, camera is on, else off.
function PLAYERRECCE:_GetKiowaMMSSight(Kiowa) end

--- [Internal]
---
------
---@param client CLIENT 
---@return SET_UNIT #Set of targets, can be empty!
---@return number #count Count of targets
function PLAYERRECCE:_GetKnownTargets(client) end

--- [Internal]
---
------
---@param unit UNIT The FACA unit
---@param camera boolean If true, use the unit's camera for targets in sight
---@param laser laser Use laser zone
---@return SET_UNIT #Set of targets, can be empty!
---@return number #count Count of targets
function PLAYERRECCE:_GetTargetSet(unit, camera, laser) end

---[Internal] Get text for text-to-speech.
---Numbers are spaced out, e.g. "Heading 180" becomes "Heading 1 8 0 ".
---
------
---@param text string Original text.
---@return string #Spoken text.
function PLAYERRECCE:_GetTextForSpeech(text) end

---[Internal] Build a ZONE_POLYGON from a given viewport of a unit
---
------
---@param unit UNIT The unit which is looking
---@param vheading number Heading where the unit or camera is looking
---@param minview number Min line of sight - for lasing
---@param maxview number Max line of sight
---@param angle number  Angle left/right to be added to heading to form a triangle
---@param camon boolean Camera is switched on
---@param laser boolean Zone is for lasing
---@return ZONE_POLYGON #ViewZone or nil if camera is off
function PLAYERRECCE:_GetViewZone(unit, vheading, minview, maxview, angle, camon, laser) end

---[Internal]
---
------
---@param client CLIENT 
---@param group GROUP 
---@param playername string 
---@return PLAYERRECCE #self
function PLAYERRECCE:_IlluTargets(client, group, playername) end

--- [Internal]
---
------
---@param client CLIENT The FACA unit
---@param targetset SET_UNIT Set of targets, can be empty!
---@return PLAYERRECCE #self
function PLAYERRECCE:_LaseTarget(client, targetset) end

---[Internal]
---
------
---@param client CLIENT 
---@param group GROUP 
---@param playername string 
---@return PLAYERRECCE #self
function PLAYERRECCE:_ReportLaserTargets(client, group, playername) end

---[Internal]
---
------
---@param client CLIENT 
---@param group GROUP 
---@param playername string 
---@return PLAYERRECCE #self
function PLAYERRECCE:_ReportVisualTargets(client, group, playername) end

---[Internal]
---
------
---@param client CLIENT 
---@param group GROUP 
---@param playername string 
---@param code NOTYPE 
---@return PLAYERRECCE #self
function PLAYERRECCE:_SetClientLaserCode(client, group, playername, code) end

---[Internal]
---
------
---@param client CLIENT 
---@param group GROUP 
---@param playername string 
---@return PLAYERRECCE #self
function PLAYERRECCE:_SmokeTargets(client, group, playername) end

---[Internal]
---
------
---@param client CLIENT 
---@param group GROUP 
---@param playername string 
---@return PLAYERRECCE #self
function PLAYERRECCE:_SwitchLasing(client, group, playername) end

---[Internal]
---
------
---@param client CLIENT 
---@param group GROUP 
---@param playername string 
---@param mindist number 
---@param maxdist number 
---@return PLAYERRECCE #self
function PLAYERRECCE:_SwitchLasingDist(client, group, playername, mindist, maxdist) end

---[Internal]
---
------
---@param client CLIENT 
---@param group GROUP 
---@param playername string 
---@return PLAYERRECCE #self
function PLAYERRECCE:_SwitchOnStation(client, group, playername) end

---[Internal]
---
------
---@param client CLIENT 
---@param group GROUP 
---@param playername string 
---@return PLAYERRECCE #self
function PLAYERRECCE:_SwitchSmoke(client, group, playername) end

---[Internal]
---
------
---@param client CLIENT 
---@param group GROUP 
---@param playername string 
---@return PLAYERRECCE #self
function PLAYERRECCE:_UploadTargets(client, group, playername) end

---[Internal]
---
------
---@param client CLIENT 
---@param group GROUP 
---@param playername string 
---@return PLAYERRECCE #self
function PLAYERRECCE:_WIP(client, group, playername) end

---Triggers the FSM event "Start" after a delay.
---Starts the PLAYERRECCE. Note: Start() is called automatically after New().
---
------
---@param delay number Delay in seconds.
function PLAYERRECCE:__Start(delay) end

---Triggers the FSM event "Stop" after a delay.
---Stops the PLAYERRECCE and all its event handlers.
---
------
---@param delay number Delay in seconds.
function PLAYERRECCE:__Stop(delay) end

---[Internal] Targets Illuminated
---
------
---@param From string 
---@param Event string 
---@param To string 
---@param Client CLIENT 
---@param Playername string 
---@param TargetSet SET_UNIT 
---@return PLAYERRECCE #self
---@private
function PLAYERRECCE:onafterIllumination(From, Event, To, Client, Playername, TargetSet) end

---[Internal] Recce off station
---
------
---@param From string 
---@param Event string 
---@param To string 
---@param Client CLIENT 
---@param Playername string 
---@return PLAYERRECCE #self
---@private
function PLAYERRECCE:onafterRecceOffStation(From, Event, To, Client, Playername) end

---[Internal] Recce on station
---
------
---@param From string 
---@param Event string 
---@param To string 
---@param Client CLIENT 
---@param Playername string 
---@return PLAYERRECCE #self
---@private
function PLAYERRECCE:onafterRecceOnStation(From, Event, To, Client, Playername) end

---[Internal] Lased target destroyed
---
------
---@param From string 
---@param Event string 
---@param To string 
---@param Client CLIENT 
---@param Target UNIT 
---@return PLAYERRECCE #self
---@private
function PLAYERRECCE:onafterShack(From, Event, To, Client, Target) end

---[Internal] Status Loop
---
------
---@param From string 
---@param Event string 
---@param To string 
---@return PLAYERRECCE #self
---@private
function PLAYERRECCE:onafterStatus(From, Event, To) end

---[Internal] Stop
---
------
---@param From string 
---@param Event string 
---@param To string 
---@return PLAYERRECCE #self
---@private
function PLAYERRECCE:onafterStop(From, Event, To) end

---[Internal] Target Detected
---
------
---@param From string 
---@param Event string 
---@param To string 
---@param Targetsbyclock table  #table with index 1..12 containing a #table of Wrapper.Unit#UNIT objects each.
---@param Client CLIENT 
---@param Playername string 
---@return PLAYERRECCE #self
---@private
function PLAYERRECCE:onafterTargetDetected(From, Event, To, Targetsbyclock, Client, Playername) end

---[Internal] Laser lost LOS
---
------
---@param From string 
---@param Event string 
---@param To string 
---@param Client CLIENT 
---@param Target UNIT 
---@return PLAYERRECCE #self
---@private
function PLAYERRECCE:onafterTargetLOSLost(From, Event, To, Client, Target) end

---[Internal] Target lasing
---
------
---@param From string 
---@param Event string 
---@param To string 
---@param Client CLIENT 
---@param Target UNIT 
---@param Lasercode number 
---@param Lasingtime number 
---@return PLAYERRECCE #self
---@private
function PLAYERRECCE:onafterTargetLasing(From, Event, To, Client, Target, Lasercode, Lasingtime) end

---[Internal] Target report
---
------
---@param From string 
---@param Event string 
---@param To string 
---@param Client CLIENT 
---@param TargetSet SET_UNIT 
---@param Target UNIT 
---@param Text string 
---@return PLAYERRECCE #self
---@private
function PLAYERRECCE:onafterTargetReport(From, Event, To, Client, TargetSet, Target, Text) end

---[Internal] Target data upload
---
------
---@param From string 
---@param Event string 
---@param To string 
---@param Client CLIENT Client sending the report
---@param Playername string Player name
---@param TargetSet SET_UNIT Set of targets
---@return PLAYERRECCE #self
---@private
function PLAYERRECCE:onafterTargetReportSent(From, Event, To, Client, Playername, TargetSet) end

---[Internal] Targets Flared
---
------
---@param From string 
---@param Event string 
---@param To string 
---@param Client CLIENT 
---@param Playername string 
---@param TargetSet SET_UNIT 
---@return PLAYERRECCE #self
---@private
function PLAYERRECCE:onafterTargetsFlared(From, Event, To, Client, Playername, TargetSet) end

---[Internal] Targets Smoked
---
------
---@param From string 
---@param Event string 
---@param To string 
---@param Client CLIENT 
---@param Playername string 
---@param TargetSet SET_UNIT 
---@return PLAYERRECCE #self
---@private
function PLAYERRECCE:onafterTargetsSmoked(From, Event, To, Client, Playername, TargetSet) end


---@class PlayerRecceDetected 
---@field private detected boolean 
---@field private playername string 
---@field private recce CLIENT 
---@field private timestamp number 
PlayerRecceDetected = {}


---@class SmokeColor 
---@field private color string 
---@field private highsmoke NOTYPE 
---@field private lasersmoke NOTYPE 
---@field private lowsmoke NOTYPE 
---@field private medsmoke NOTYPE 
---@field private ownsmoke NOTYPE 
SmokeColor = {}



