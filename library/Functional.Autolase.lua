---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Designation.JPG" width="100%">
---
---**Functional** - Autolase targets in the field.
---
---===
---
---**AUOTLASE** - Autolase targets in the field.
---
---===
---
---## Missions:
---
---None yet.
---
---===
---
---**Main Features:**
---
---   * Detect and lase contacts automatically
---   * Targets are lased by threat priority order
---   * Use FSM events to link functionality into your scripts
---   * Easy setup
---
---===
---
---- Spot on!
---
---===
---
---# 1 Autolase concept
---
---* Detect and lase contacts automatically
---* Targets are lased by threat priority order
---* Use FSM events to link functionality into your scripts
---* Set laser codes and smoke colors per Recce unit
---* Easy set-up
---
---# 2 Basic usage
---
---## 2.2 Set up a group of Recce Units:
---
---           local FoxSet = SET_GROUP:New():FilterPrefixes("Recce"):FilterCoalitions("blue"):FilterStart()
---           
---## 2.3 (Optional) Set up a group of pilots, this will drive who sees the F10 menu entry:
---
---           local Pilotset = SET_CLIENT:New():FilterCoalitions("blue"):FilterActive(true):FilterStart()
---           
---## 2.4 Set up and start Autolase:
---
---           local autolaser = AUTOLASE:New(FoxSet,coalition.side.BLUE,"Wolfpack",Pilotset)
---           
---## 2.5 Example - Using a fixed laser code and color for a specific Recce unit:
---
---           local recce = SPAWN:New("Reaper")
---             :InitDelayOff()
---             :OnSpawnGroup(
---               function (group)
---                 local unit = group:GetUnit(1)
---                 local name = unit:GetName()
---                 autolaser:SetRecceLaserCode(name,1688)
---                 autolaser:SetRecceSmokeColor(name,SMOKECOLOR.Red)
---               end
---             )
---             :InitCleanUp(60)
---             :InitLimit(1,0)
---             :SpawnScheduled(30,0.5)
---             
---## 2.6 Example - Inform pilots about events:
---
---           autolaser:SetNotifyPilots(true) -- defaults to true, also shown if debug == true
---           -- Note - message are shown to pilots in the #SET_CLIENT only if using the pilotset option, else to the coalition.
---
---
---### Author: **applevangelist**
---@class AUTOLASE 
---@field CurrentLasing NOTYPE 
---@field DetectDLINK boolean 
---@field DetectIRST boolean 
---@field DetectOptical boolean 
---@field DetectRWR boolean 
---@field DetectRadar boolean 
---@field DetectVisual boolean 
---@field GroupsByThreat NOTYPE 
---@field Label NOTYPE 
---@field Menu NOTYPE 
---@field NoMenus boolean 
---@field PathToGoogleKey NOTYPE 
---@field RecceLaserCode table 
---@field RecceNames table 
---@field RecceSet NOTYPE 
---@field RecceSmokeColor table 
---@field RecceUnitNames table 
---@field RecceUnits table 
---@field SRS NOTYPE 
---@field SRSFreq number 
---@field SRSMod NOTYPE 
---@field SRSPath string 
---@field SRSQueue NOTYPE 
---@field UnitsByThreat NOTYPE 
---@field Voice NOTYPE 
---@field private alias NOTYPE 
---@field private blacklistattributes table 
---@field private coalition NOTYPE 
---@field private cooldowntime number 
---@field private deadunitnotes table 
---@field private forcecooldown boolean 
---@field private increasegroundawareness boolean 
---@field private lid NOTYPE 
---@field private minthreatlevel NOTYPE 
---@field private pilotset NOTYPE 
---@field private playermenus table 
---@field private smokemenu boolean 
---@field private smoketargets NOTYPE 
---@field private targetsperrecce NOTYPE 
---@field private threatmenu boolean 
---@field private useSRS boolean 
---@field private usepilotset boolean 
---@field private version string AUTOLASE class version.
AUTOLASE = {}

---(User) Set list of #UNIT level attributes that won't be lased.
---For list of attributes see [Hoggit Wiki](https://wiki.hoggitworld.com/view/DCS_enum_attributes) and [GitHub](https://github.com/mrSkortch/DCS-miscScripts/tree/master/ObjectDB)
---
------
---
---USAGE
---```
---To exclude e.g. manpads from being lased:
---
---           `myautolase:AddBlackListAttributes("MANPADS")`
---
---To exclude trucks and artillery:
---
---           `myautolase:AddBlackListAttributes({"Trucks","Artillery"})`
---```
------
---@param Attributes table Table of #string attributes to blacklist. Can be handed over as a single #string.
---@return AUTOLASE #self
function AUTOLASE:AddBlackListAttributes(Attributes) end

---(Internal) Function to check if a unit can be lased.
---
------
---@param Recce UNIT The Recce #UNIT
---@param Unit UNIT The lased #UNIT
---@return boolean #outcome True or false
function AUTOLASE:CanLase(Recce, Unit) end

---Triggers the FSM event "Cancel".
---
------
function AUTOLASE:Cancel() end

---(Internal) Function to check if a unit is already lased.
---
------
---@param unitname string Name of the unit to check
---@return boolean #outcome True or false
function AUTOLASE:CheckIsLased(unitname) end

---(Internal) Function to check on lased targets.
---
------
---@return AUTOLASE #self
function AUTOLASE:CleanCurrentLasing() end

---[User] Do not improve ground unit detection by using a zone scan and LOS check.
---
------
---@return AUTOLASE #self 
function AUTOLASE:DisableImproveGroundUnitsDetection() end

---(User) Do not show the "Switch smoke target..." menu entry for pilots.
---
------
---@return AUTOLASE #self 
function AUTOLASE:DisableSmokeMenu() end

---(User) Do not show the "Switch min threat lasing..." menu entry for pilots.
---
------
---@return AUTOLASE #self 
function AUTOLASE:DisableThreatLevelMenu() end

---[User] Improve ground unit detection by using a zone scan and LOS check.
---
------
---@return AUTOLASE #self 
function AUTOLASE:EnableImproveGroundUnitsDetection() end

---(User) Show the "Switch smoke target..." menu entry for pilots.
---On by default.
---
------
---@param Offset? table (Optional) Define an offset for the smoke, i.e. not directly on the unit itself, angle is degrees and distance is meters. E.g. `autolase:EnableSmokeMenu({Angle=30,Distance=20})`
---@return AUTOLASE #self 
function AUTOLASE:EnableSmokeMenu(Offset) end

---(User) Show the "Switch min threat lasing..." menu entry for pilots.
---On by default.
---
------
---@return AUTOLASE #self 
function AUTOLASE:EnableThreatLevelMenu() end

---(Internal) Function to get a laser code by recce name
---
------
---@param RecceName string Unit(!) name of the Recce
---@return AUTOLASE #self 
function AUTOLASE:GetLaserCode(RecceName) end

---(Internal) Function to calculate line of sight.
---
------
---@param Unit UNIT 
---@return number #LOS Line of sight in meters
function AUTOLASE:GetLosFromUnit(Unit) end

---(Internal) Function to get a smoke color by recce name
---
------
---@param RecceName string Unit(!) name of the Recce
---@return AUTOLASE #self 
function AUTOLASE:GetSmokeColor(RecceName) end

---Constructor for a new Autolase instance.
---
------
---@param RecceSet SET_GROUP Set of detecting and lasing units
---@param Coalition number Coalition side. Can also be passed as a string "red", "blue" or "neutral".
---@param Alias? string (Optional) An alias how this object is called in the logs etc.
---@param PilotSet? SET_CLIENT (Optional) Set of clients for precision bombing, steering menu creation. Leave nil for a coalition-wide F10 entry and display.
---@return AUTOLASE #self 
function AUTOLASE:New(RecceSet, Coalition, Alias, PilotSet) end

---(Internal) Function to show messages.
---
------
---@param Message string The message to be sent
---@param Duration number Duration in seconds
---@return AUTOLASE #self
function AUTOLASE:NotifyPilots(Message, Duration) end

---(User) Send messages via SRS.
---
------
---
---USAGE
---```
---Step 1 - set up the radio basics **once** with
---           my_autolase:SetUsingSRS(true,"C:\\path\\SRS-Folder",251,radio.modulation.AM)
---Step 2 - send a message, e.g.
---           function my_autolase:OnAfterLasing(From, Event, To, LaserSpot)
---               my_autolase:NotifyPilotsWithSRS("Reaper lasing new target!")
---           end
---```
------
---@param Message string The (short!) message to be sent, e.g. "Lasing target!"
---@return AUTOLASE #self
function AUTOLASE:NotifyPilotsWithSRS(Message) end

---On After "LaserTimeout" event.
---
------
---@param From string The from state
---@param Event string The event
---@param To string The to state
---@param UnitName string The lost unit\'s name
---@param RecceName string The Recce name lasing
function AUTOLASE:OnAfterLaserTimeout(From, Event, To, UnitName, RecceName) end

---On After "Lasing" event.
---
------
---@param From string The from state
---@param Event string The event
---@param To string The to state
---@param LaserSpot AUTOLASE.LaserSpot The LaserSpot data table
function AUTOLASE:OnAfterLasing(From, Event, To, LaserSpot) end

---On After "RecceKIA" event.
---
------
---@param From string The from state
---@param Event string The event
---@param To string The to state
---@param RecceName string The lost Recce
function AUTOLASE:OnAfterRecceKIA(From, Event, To, RecceName) end

---On After "TargetDestroyed" event.
---
------
---@param From string The from state
---@param Event string The event
---@param To string The to state
---@param UnitName string The destroyed unit\'s name
---@param RecceName string The Recce name lasing
function AUTOLASE:OnAfterTargetDestroyed(From, Event, To, UnitName, RecceName) end

---On After "TargetLost" event.
---
------
---@param From string The from state
---@param Event string The event
---@param To string The to state
---@param UnitName string The lost unit\'s name
---@param RecceName string The Recce name lasing
function AUTOLASE:OnAfterTargetLost(From, Event, To, UnitName, RecceName) end

---[User] Set a table of possible laser codes.
---Each new RECCE can select a code from this table, default is { 1688, 1130, 4785, 6547, 1465, 4578 }.
---
------
---@param LaserCodes list 
---@return AUTOLASE #self
function AUTOLASE:SetLaserCodes(LaserCodes) end

---(User) Function to force laser cooldown and cool down time
---
------
---@param OnOff boolean Switch cool down on (true) or off (false) - defaults to true
---@param Seconds number Number of seconds for cooldown - dafaults to 60 seconds
---@return AUTOLASE #self 
function AUTOLASE:SetLaserCoolDown(OnOff, Seconds) end

---(User) Function to set lasing distance in meters and duration in seconds
---
------
---@param Distance number (Max) distance for lasing in meters - default 5000 meters
---@param Duration number (Max) duration for lasing in seconds - default 300 secs
---@return AUTOLASE #self 
function AUTOLASE:SetLasingParameters(Distance, Duration) end

---(User) Function set max lasing targets
---
------
---@param Number number Max number of targets to lase at once
---@return AUTOLASE #self 
function AUTOLASE:SetMaxLasingTargets(Number) end

---(User) Set minimum threat level for target selection, can be 0 (lowest) to 10 (highest).
---
------
---
---USAGE
---```
---Filter for level 3 and above:
---           `myautolase:SetMinThreatLevel(3)`
---```
------
---@param Level number Level used for filtering, defaults to 0. SAM systems and manpads have level 7 to 10, AAA level 6, MTBs and armoured vehicles level 3 to 5, APC, Artillery, Infantry and EWR level 1 to 2.
---@return AUTOLASE #self
function AUTOLASE:SetMinThreatLevel(Level) end

---[User] When using Monitor, set the frequency here in which the report will appear
---
------
---@param Seconds number Run the report loop every number of seconds defined here.
---@return AUTOLASE #self
function AUTOLASE:SetMonitorFrequency(Seconds) end

---(Internal) Function set notify pilots on events
---
------
---@param OnOff boolean Switch messaging on (true) or off (false)
---@return AUTOLASE #self 
function AUTOLASE:SetNotifyPilots(OnOff) end

---(Internal) Function to set pilot menu.
---
------
---@return AUTOLASE #self 
function AUTOLASE:SetPilotMenu() end

---(User) Function to set a specific code to a Recce.
---
------
---@param RecceName string (Unit!) Name of the Recce
---@param Code number The lase code
---@param Refresh boolean If true, refresh menu entries
---@return AUTOLASE #self 
function AUTOLASE:SetRecceLaserCode(RecceName, Code, Refresh) end

---(User) Function to set a specific smoke color for a Recce.
---
------
---@param RecceName string (Unit!) Name of the Recce
---@param Color number The color, e.g. SMOKECOLOR.Red, SMOKECOLOR.Green etc
---@return AUTOLASE #self 
function AUTOLASE:SetRecceSmokeColor(RecceName, Color) end

---(User) Function to set message show times.
---
------
---@param long number Longer show time
---@param short number Shorter show time
---@return AUTOLASE #self 
function AUTOLASE:SetReportingTimes(long, short) end

---(User) Function to set rounding precision for BR distance output.
---
------
---@param IDP number Rounding precision before/after the decimal sign. Defaults to zero. Positive values round right of the decimal sign, negative ones left of the decimal sign. 
---@return AUTOLASE #self 
function AUTOLASE:SetRoundingPrecsion(IDP) end

---(User) Function to set smoking of targets.
---
------
---@param OnOff boolean Switch smoking on or off
---@param Color number Smokecolor, e.g. SMOKECOLOR.Red
---@return AUTOLASE #self 
function AUTOLASE:SetSmokeTargets(OnOff, Color) end

---(User) Function enable sending messages via SRS.
---
------
---@param OnOff boolean Switch usage on and off
---@param Path string Path to SRS directory, e.g. C:\\Program Files\\DCS-SimpleRadio-Standalone
---@param Frequency number Frequency to send, e.g. 243
---@param Modulation number Modulation i.e. radio.modulation.AM or radio.modulation.FM
---@param Label? string (Optional) Short label to be used on the SRS Client Overlay
---@param Gender? string (Optional) Defaults to "male"
---@param Culture? string (Optional) Defaults to "en-US"
---@param Port? number (Optional) Defaults to 5002
---@param Voice? string (Optional) Use a specifc voice with the @{Sound.SRS#SetVoice} function, e.g, `:SetVoice("Microsoft Hedda Desktop")`. Note that this must be installed on your windows system. Can also be Google voice types, if you are using Google TTS.
---@param Volume? number (Optional) Volume - between 0.0 (silent) and 1.0 (loudest)
---@param PathToGoogleKey? string (Optional) Path to your google key if you want to use google TTS
---@return AUTOLASE #self 
function AUTOLASE:SetUsingSRS(OnOff, Path, Frequency, Modulation, Label, Gender, Culture, Port, Voice, Volume, PathToGoogleKey) end

---(Internal) Function to show status.
---
------
---@param Group? GROUP (Optional) show to a certain group
---@param Unit? UNIT (Optional) show to a certain unit
---@return AUTOLASE #self
function AUTOLASE:ShowStatus(Group, Unit) end

---Triggers the FSM event "Monitor".
---
------
function AUTOLASE:Status() end

---(Internal) Event function for new pilots.
---
------
---@param EventData EVENTDATA 
---@return AUTOLASE #self 
function AUTOLASE:_EventHandler(EventData) end

---(Internal) Function to do a zone check per ground Recce and make found units and statics "known".
---
------
---@return AUTOLASE #self 
function AUTOLASE:_Prescient() end

---Triggers the FSM event "Cancel" after a delay.
---
------
---@param delay number Delay in seconds.
function AUTOLASE:__Cancel(delay) end

---Triggers the FSM event "Monitor" after a delay.
---
------
---@param delay number Delay in seconds.
function AUTOLASE:__Status(delay) end

---(Internal) FSM Function for monitoring
---
------
---@param From string The from state
---@param Event string The event
---@param To string The to state
---@return AUTOLASE #self
---@private
function AUTOLASE:onafterMonitor(From, Event, To) end

---(Internal) FSM Function onbeforeCancel
---
------
---@param From string The from state
---@param Event string The event
---@param To string The to state
---@return AUTOLASE #self
---@private
function AUTOLASE:onbeforeCancel(From, Event, To) end

---(Internal) FSM Function onbeforeLaserTimeout
---
------
---@param From string The from state
---@param Event string The event
---@param To string The to state
---@param UnitName string The lost unit\'s name
---@param RecceName string The Recce name lasing
---@return AUTOLASE #self
---@private
function AUTOLASE:onbeforeLaserTimeout(From, Event, To, UnitName, RecceName) end

---(Internal) FSM Function onbeforeLasing
---
------
---@param From string The from state
---@param Event string The event
---@param To string The to state
---@param LaserSpot AUTOLASE.LaserSpot The LaserSpot data table
---@return AUTOLASE #self
---@private
function AUTOLASE:onbeforeLasing(From, Event, To, LaserSpot) end

---(Internal) FSM Function for monitoring
---
------
---@param From string The from state
---@param Event string The event
---@param To string The to state
---@return AUTOLASE #self
---@private
function AUTOLASE:onbeforeMonitor(From, Event, To) end

---(Internal) FSM Function onbeforeRecceKIA
---
------
---@param From string The from state
---@param Event string The event
---@param To string The to state
---@param RecceName string The lost Recce
---@return AUTOLASE #self
---@private
function AUTOLASE:onbeforeRecceKIA(From, Event, To, RecceName) end

---(Internal) FSM Function onbeforeTargetDestroyed
---
------
---@param From string The from state
---@param Event string The event
---@param To string The to state
---@param UnitName string The destroyed unit\'s name
---@param RecceName string The Recce name lasing
---@return AUTOLASE #self
---@private
function AUTOLASE:onbeforeTargetDestroyed(From, Event, To, UnitName, RecceName) end

---(Internal) FSM Function onbeforeTargetLost
---
------
---@param From string The from state
---@param Event string The event
---@param To string The to state
---@param UnitName string The lost unit\'s name
---@param RecceName string The Recce name lasing
---@return AUTOLASE #self
---@private
function AUTOLASE:onbeforeTargetLost(From, Event, To, UnitName, RecceName) end


---Laser spot info
---@class AUTOLASE.LaserSpot 
---@field private coordinate COORDINATE 
---@field private lasedunit UNIT 
---@field private lasercode number 
---@field private laserspot SPOT 
---@field private lasingunit UNIT 
---@field private location string 
---@field private reccename string 
---@field private timestamp number 
---@field private unitname string 
---@field private unittype string 
AUTOLASE.LaserSpot = {}



