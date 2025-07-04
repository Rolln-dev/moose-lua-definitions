---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Functional.Mantis.jpg" width="100%">
---
---**Functional** - Modular, Automatic and Network capable Targeting and Interception System for Air Defenses.
---
---===
---
---## Features:
---
--- * Moose derived  Modular, Automatic and Network capable Targeting and Interception System.
--- * Controls a network of SAM sites. Uses detection to switch on the AA site closest to the enemy.   
--- * Automatic mode (default since 0.8) can set-up your SAM site network automatically for you.   
--- * Leverage evasiveness from SEAD, leverage attack range setting.   
---
---===
---
---## Missions:
---
---### [MANTIS - Modular, Automatic and Network capable Targeting and Interception System](https://github.com/FlightControl-Master/MOOSE_MISSIONS/tree/master/Functional/Mantis)
---
---===
---
---### Author : **applevangelist **
---*The worst thing that can happen to a good cause is, not to be skillfully attacked, but to be ineptly defended.* - Frédéric Bastiat
---
---Moose class for a more intelligent Air Defense System
---
---# MANTIS
---
---* Moose derived  Modular, Automatic and Network capable Targeting and Interception System.
---* Controls a network of SAM sites. Uses detection to switch on the SAM site closest to the enemy.
---* **Automatic mode** (default) will set-up your SAM site network automatically for you.
---* Leverage evasiveness from SEAD, leverage attack range setting.
---* Automatic setup of SHORAD based on groups of the class "short-range".
---
---# 0. Base considerations and naming conventions
---
---**Before** you start to set up your SAM sites in the mission editor, please think of naming conventions. This is especially critical to make
---eveything work as intended, also if you have both a blue and a red installation!
---
---You need three **non-overlapping** "name spaces" for everything to work properly:
---
---* SAM sites, e.g. each **group name** begins with "Red SAM"
---* EWR network and AWACS, e.g. each **group name** begins with "Red EWR" and *not* e.g. "Red SAM EWR" (overlap with  "Red SAM"), "Red EWR Awacs" will be found by "Red EWR"
---* SHORAD, e.g. each **group name** begins with "Red SHORAD" and *not" e.g. just "SHORAD" because you might also have "Blue SHORAD"
---* Point Defense, e.g. each **group name** begins with "Red AAA" and *not" e.g. just "AAA" because you might also have "Blue AAA"
---
---It's important to get this right because of the nature of the filter-system in Core.Set#SET_GROUP. Filters are "greedy", that is they
---will match *any* string that contains the search string - hence we need to avoid that SAMs, EWR and SHORAD step on each other\'s toes.
---
---Second, for auto-mode to work, the SAMs need the **SAM Type Name** in their group name, as MANTIS will determine their capabilities from this.
---This is case-sensitive, so "sa-11" is not equal to "SA-11" is not equal to "Sa-11"!
---
---Known SAM types at the time of writing are:
---
---* Avenger
---* Chaparral
---* Hawk
---* Linebacker
---* NASAMS
---* Patriot
---* Rapier
---* Roland
---* Silkworm (though strictly speaking this is a surface to ship missile)
---* SA-2, SA-3, SA-5, SA-6, SA-7, SA-8, SA-9, SA-10, SA-11, SA-13, SA-15, SA-19
---* From IDF mod: STUNNER IDFA, TAMIR IDFA (Note all caps!)
---* From HDS (see note on HDS below): SA-2, SA-3, SA-10B, SA-10C, SA-12, SA-17, SA-20A, SA-20B, SA-23, HQ-2
---
---* From SMA: RBS98M, RBS70, RBS90, RBS90M, RBS103A, RBS103B, RBS103AM, RBS103BM, Lvkv9040M 
---**NOTE** If you are using the Swedish Military Assets (SMA), please note that the **group name** for RBS-SAM types also needs to contain the keyword "SMA"
---
---* From CH: 2S38, PantsirS1, PantsirS2, PGL-625, HQ-17A, M903PAC2, M903PAC3, TorM2, TorM2K, TorM2M, NASAMS3-AMRAAMER, NASAMS3-AIM9X2, C-RAM, PGZ-09, S350-9M100, S350-9M96D
---**NOTE** If you are using the Military Assets by Currenthill (CH), please note that the **group name** for CH-SAM types also needs to contain the keyword "CHM"
---
---Following the example started above, an SA-6 site group name should start with "Red SAM SA-6" then, or a blue Patriot installation with e.g. "Blue SAM Patriot". 
---**NOTE** If you are using the High-Digit-Sam Mod, please note that the **group name** for the following SAM types also needs to contain the keyword "HDS":
---
---* SA-2 (with V759 missile, e.g. "Red SAM SA-2 HDS")
---* SA-2 (with HQ-2 launcher, use HQ-2 in the group name, e.g. "Red SAM HQ-2" )
---* SA-3 (with V601P missile, e.g. "Red SAM SA-3 HDS")
---* SA-10B (overlap with other SA-10 types, e.g. "Red SAM SA-10B HDS")
---* SA-10C (overlap with other SA-10 types, e.g. "Red SAM SA-10C HDS")
---* SA-12 (launcher dependent range, e.g. "Red SAM SA-12 HDS")
---* SA-23 (launcher dependent range, e.g. "Red SAM SA-23 HDS") 
---
---The other HDS types work like the rest of the known SAM systems.
---
---# 0.1 Set-up in the mission editor
---
---Set up your SAM sites in the mission editor. Name the groups using a systematic approach like above.Can be e.g. AWACS or a combination of AWACS and Search Radars like e.g. EWR 1L13 etc. 
---Search Radars usually have "SR" or "STR" in their names. Use the encyclopedia in the mission editor to inform yourself.
---Set up your SHORAD systems. They need to be **close** to (i.e. around) the SAM sites to be effective. Use **one unit ** per group (multiple groups) for the SAM location. 
---Else, evasive manoevers might club up all defenders in one place. Red SA-15 TOR systems offer a good missile defense.
---
---[optional] Set up your HQ. Can be any group, e.g. a command vehicle.
---
---# 1. Basic tactical considerations when setting up your SAM sites
---
---## 1.1 Radar systems and AWACS
---
--- Typically, your setup should consist of EWR (early warning) radars to detect and track targets, accompanied by AWACS if your scenario forsees that. Ensure that your EWR radars have a good coverage of the area you want to track.
--- **Location** is of highest importance here. Whilst AWACS in DCS has almost the "all seeing eye", EWR don't have that. Choose your location wisely, against a mountain backdrop or inside a valley even the best EWR system
--- doesn't work well. Prefer higher-up locations with a good view; use F7 in-game to check where you actually placed your EWR and have a look around. Apart from the obvious choice, do also consider other radar units
--- for this role, most have "SR" (search radar) or "STR" (search and track radar) in their names, use the encyclopedia to see what they actually do.
--- **HINT** Set at least one EWR on invisible and immortal so MANTIS doesn't stop working.
---
---## 1.2 SAM sites
---
---Typically your SAM should cover all attack ranges. The closer the enemy gets, the more systems you will need to deploy to defend your location. Use a combination of long-range systems like the SA-5/10/11, midrange like SA-6 and short-range like
---SA-2 for defense (Patriot, Hawk, Gepard, Blindfire for the blue side). For close-up defense and defense against HARMs or low-flying aircraft, helicopters it is also advisable to deploy SA-15 TOR systems, Shilka, Strela and Tunguska units, as well as manpads (Think Gepard, Avenger, Chaparral,
---Linebacker, Roland systems for the blue side). If possible, overlap ranges for mutual coverage.
---
---## 1.3 Typical problems
---
---Often times, people complain because the detection cannot "see" oncoming targets and/or Mantis switches on too late. Three typial problems here are
---
---  * bad placement of radar units,
---  * overestimation how far units can "see" and
---  * not taking into account that a SAM site will take (e.g for a SA-6) 30-40 seconds between switching on, acquiring the target and firing.
---
---An attacker doing 350knots will cover ca 180meters/second or thus more than 6km until the SA-6 fires. Use triggers zones and the ruler in the mission editor to understand distances and zones. Take into account that the ranges given by the circles
---in the mission editor are absolute maximum ranges; in-game this is rather 50-75% of that depending on the system. Fiddle with placement and options to see what works best for your scenario, and remember **everything in here is in meters**.
---
---# 2. Start up your MANTIS with a basic setting
---
---       myredmantis = MANTIS:New("myredmantis","Red SAM","Red EWR",nil,"red",false)
---       myredmantis:Start()
---
---Use
---
--- *     MANTIS:SetEWRGrouping(radius) [classic mode]
--- *     MANTIS:SetSAMRadius(radius) [classic mode]
--- *     MANTIS:SetDetectInterval(interval) [classic & auto modes]
--- *     MANTIS:SetAutoRelocate(hq, ewr) [classic & auto modes]
---
---before starting #MANTIS to fine-tune your setup.
---
---If you want to use a separate AWACS unit to support your EWR system, use e.g. the following setup:
---
---       mybluemantis = MANTIS:New("bluemantis","Blue SAM","Blue EWR",nil,"blue",false,"Blue Awacs")
---       mybluemantis:Start()
---
---## 2.1 Auto mode features
---
---### 2.1.1 You can add Accept-, Reject- and Conflict-Zones to your setup, e.g. to consider borders or de-militarized zones:   
---
---       -- Parameters are tables of Core.Zone#ZONE objects!   
---       -- This is effectively a 3-stage filter allowing for zone overlap. A coordinate is accepted first when   
---       -- it is inside any AcceptZone. Then RejectZones are checked, which enforces both borders, but also overlaps of   
---       -- Accept- and RejectZones. Last, if it is inside a conflict zone, it is accepted.   
---       mybluemantis:AddZones(AcceptZones,RejectZones,ConflictZones)   
---       
---       
---### 2.1.2 Change the number of long-, mid- and short-range, point defense systems going live on a detected target:   
---
---       -- parameters are numbers. Defaults are 1,2,2,6,6 respectively
---       mybluemantis:SetMaxActiveSAMs(Short,Mid,Long,Classic,Point)
---
---### 2.1.3 SHORAD/Point defense will automatically be added from SAM sites of type "point" or if the range is less than 5km or if the type is AAA. 
---       
---### 2.1.4 Advanced features   
---       
---       -- Option to set the scale of the activation range, i.e. don't activate at the fringes of max range, defaults below.   
---       -- also see engagerange below.   
---           self.radiusscale[MANTIS.SamType.LONG] = 1.1   
---           self.radiusscale[MANTIS.SamType.MEDIUM] = 1.2   
---           self.radiusscale[MANTIS.SamType.SHORT] = 1.3 
---           self.radiusscale[MANTIS.SamType.POINT] = 1.4 
---       
---### 2.1.5 Friendlies check in firing range
---
---       -- For some scenarios, like Cold War, it might be useful not to activate SAMs if friendly aircraft are around to avoid death by friendly fire.
---       mybluemantis.checkforfriendlies = true  
---       
---### 2.1.6 Shoot & Scoot
---
---       -- Option to make the (driveable) SHORAD units drive around and shuffle positions
---       -- We use a SET_ZONE for that, number of zones to consider defaults to three, Random is true for random coordinates and Formation is e.g. "Vee".
---       mybluemantis:AddScootZones(ZoneSet, Number, Random, Formation)
---
---# 3. Default settings [both modes unless stated otherwise]
---
---By default, the following settings are active:
---
--- * SAM_Templates_Prefix = "Red SAM" - SAM site group names in the mission editor begin with "Red SAM"
--- * EWR_Templates_Prefix = "Red EWR" - EWR group names in the mission editor begin with "Red EWR" - can also be combined with an AWACS unit
--- * [classic mode] checkradius = 25000 (meters) - SAMs will engage enemy flights, if they are within a 25km around each SAM site - `MANTIS:SetSAMRadius(radius)`
--- * grouping = 5000 (meters) - Detection (EWR) will group enemy flights to areas of 5km for tracking - `MANTIS:SetEWRGrouping(radius)`
--- * detectinterval = 30 (seconds) - MANTIS will decide every 30 seconds which SAM to activate - `MANTIS:SetDetectInterval(interval)`
--- * engagerange = 95 (percent) - SAMs will only fire if flights are inside of a 95% radius of their max firerange - `MANTIS:SetSAMRange(range)`
--- * dynamic = false - Group filtering is set to once, i.e. newly added groups will not be part of the setup by default - `MANTIS:New(name,samprefix,ewrprefix,hq,coalition,dynamic)`
--- * autorelocate = false - HQ and (mobile) EWR system will not relocate in random intervals between 30mins and 1 hour - `MANTIS:SetAutoRelocate(hq, ewr)`
--- * debug = false - Debugging reports on screen are set to off - `MANTIS:Debug(onoff)`
---
---# 4. Advanced Mode
---
--- Advanced mode will *decrease* reactivity of MANTIS, if HQ and/or EWR  network dies.  Awacs is counted as one EWR unit. It will set SAMs to RED state if both are dead.  Requires usage of an **HQ** object and the **dynamic** option.
---
--- E.g.        mymantis:SetAdvancedMode( true, 90 )
---
--- Use this option if you want to make use of or allow advanced SEAD tactics.
--- 
---# 5. Integrated SEAD
--- 
--- MANTIS is using Functional.Sead#SEAD internally to both detect and evade HARM attacks. No extra efforts needed to set this up! 
--- Once a HARM attack is detected, MANTIS (via SEAD) will shut down the radars of the attacked SAM site and take evasive action by moving the SAM
--- vehicles around (*if they are __drivable__*, that is). There's a component of randomness in detection and evasion, which is based on the
--- skill set of the SAM set (the higher the skill, the more likely). When a missile is fired from far away, the SAM will stay active for a 
--- period of time to stay defensive, before it takes evasive actions.
--- 
--- You can link into the SEAD driven events of MANTIS like so:
--- 
---       function mymantis:OnAfterSeadSuppressionPlanned(From, Event, To, Group, Name, SuppressionStartTime, SuppressionEndTime)
---         -- your code here - SAM site shutdown and evasion planned, but not yet executed
---         -- Time entries relate to timer.getTime() - see https://wiki.hoggitworld.com/view/DCS_func_getTime
---       end
---       
---       function mymantis:OnAfterSeadSuppressionStart(From, Event, To, Group, Name)
---         -- your code here - SAM site is emissions off and possibly moving
---       end
---       
---       function mymantis:OnAfterSeadSuppressionEnd(From, Event, To, Group, Name)
---         -- your code here - SAM site is back online
---       end
---- **MANTIS** class, extends Core.Base#BASE
---@class MANTIS : BASE
---@field AWACS_Detection DETECTION_AREAS The #DETECTION_AREAS object for AWACS
---@field AWACS_Prefix NOTYPE 
---@field Adv_EWR_Group SET_GROUP The EWR #SET_GROUP used for advanced mode
---@field AdvancedState MANTIS.AdvancedState 
---@field ClassName string 
---@field DLTimeStamp NOTYPE 
---@field DLink boolean 
---@field DLinkCacheTime number Seconds after which cached contacts in DLink will decay.
---@field Detection DETECTION_AREAS The #DETECTION_AREAS object for EWR
---@field EWR_Group SET_GROUP The EWR #SET_GROUP
---@field EWR_Templates_Prefix string Prefix to build the #SET_GROUP for EWR group
---@field FilterZones table Table of Core.Zone#ZONE Zones Consider SAM groups in this zone(s) only for this MANTIS instance, must be handed as #table of Zone objects.
---@field Groupset NOTYPE 
---@field HQ_CC GROUP The #GROUP object of the HQ
---@field HQ_Template_CC string The ME name of the HQ object
---@field SAM_Group SET_GROUP The SAM #SET_GROUP
---@field SAM_Table table Table of SAM sites
---@field SAM_Table_Long NOTYPE 
---@field SAM_Table_Medium NOTYPE 
---@field SAM_Table_PointDef NOTYPE 
---@field SAM_Table_Short NOTYPE 
---@field SAM_Templates_Prefix string Prefix to build the #SET_GROUP for SAM sites
---@field SamData MANTIS.SamData 
---@field SamDataCH MANTIS.SamDataCH 
---@field SamDataHDS MANTIS.SamDataHDS 
---@field SamDataSMA MANTIS.SamDataSMA 
---@field SamStateTracker table 
---@field SamType MANTIS.SamType 
---@field ScootRandom NOTYPE 
---@field Shorad SHORAD SHORAD Object, if available
---@field ShoradActDistance number Distance of an attacker in meters from a Mantis SAM site, on which Shorad will be switched on. Useful to not give away Shorad sites too early. Default 15km. Should be smaller than checkradius.
---@field ShoradGroupSet SET_GROUP 
---@field ShoradLink boolean If true, #MANTIS has #SHORAD enabled
---@field ShoradTime number Timer in seconds, how long #SHORAD will be active after a detection inside of the defense range
---@field SkateZones NOTYPE 
---@field SmokeDecoy boolean If true, smoke short range SAM units as decoy if a plane is in firing range.
---@field SmokeDecoyColor number Color to use, defaults to SMOKECOLOR.White
---@field SuppressedGroups table 
---@field TimeStamp NOTYPE 
---@field UseEmOnOff boolean Decide if we are using Emissions on/off (true) or AlarmState red/green (default)
---@field private acceptrange number Radius of the EWR detection
---@field private advAwacs boolean Boolean switch to use Awacs as a separate detection stream
---@field private adv_ratio number Percentage to use for advanced mode, defaults to 100%
---@field private adv_state number Advanced mode state tracker
---@field private advanced boolean Use advanced mode, will decrease reactivity of MANTIS, if HQ and/or EWR network dies. Set SAMs to RED state if both are dead. Requires usage of an HQ object
---@field private automode boolean 
---@field private autorelocate boolean Relocate HQ and EWR groups in random intervals. Note: You need to select units for this which are *actually mobile*
---@field private autorelocateunits table 
---@field private autoshorad boolean 
---@field private awacsrange number Detection range of an optional Awacs unit
---@field private checkcounter number Counter for SAM Table refreshes.
---@field private checkforfriendlies boolean If true, do not activate a SAM installation if a friendly aircraft is in firing range.
---@field private checkradius number Radius of the SAM sites
---@field private debug boolean Switch on extra messages
---@field private detectinterval number Interval in seconds for the target detection
---@field private engagerange number Firing engage range of the SAMs, see [https://wiki.hoggitworld.com/view/DCS_option_engagementRange]
---@field private ewr_templates table 
---@field private friendlyset NOTYPE 
---@field private grouping number Radius to group detected objects
---@field private intelset table 
---@field private lid string Prefix for logging
---@field private logsamstatus boolean Log SAM status in dcs.log every cycle if true
---@field private mysead NOTYPE 
---@field private name string Name of this Mantis
---@field private radiusscale MANTIS.radiusscale 
---@field private relointerval NOTYPE 
---@field private shootandscoot boolean 
---@field private state2flag boolean 
---@field private usezones boolean 
---@field private verbose boolean Switch on extra logging
---@field private version string 
MANTIS = {}

---Add a SET_ZONE of zones for Shoot&Scoot - SHORAD units will move around
---
------
---@param ZoneSet SET_ZONE Set of zones to be used. Units will move around to the next (random) zone between 100m and 3000m away.
---@param Number number Number of closest zones to be considered, defaults to 3.
---@param Random boolean If true, use a random coordinate inside the next zone to scoot to.
---@param Formation string Formation to use, defaults to "Cone". See mission editor dropdown for options.
---@return MANTIS #self
function MANTIS:AddScootZones(ZoneSet, Number, Random, Formation) end

---Function to link up #MANTIS with a #SHORAD installation
---
------
---@param Shorad SHORAD The #SHORAD object
---@param Shoradtime number Number of seconds #SHORAD stays active post wake-up
function MANTIS:AddShorad(Shorad, Shoradtime) end

---Function to set accept and reject zones.
---
------
---
---USAGE
---```
---Parameters are **tables of Core.Zone#ZONE** objects!   
---This is effectively a 3-stage filter allowing for zone overlap. A coordinate is accepted first when   
---it is inside any AcceptZone. Then RejectZones are checked, which enforces both borders, but also overlaps of   
---Accept- and RejectZones. Last, if it is inside a conflict zone, it is accepted.
---```
------
---@param AcceptZones table Table of @{Core.Zone#ZONE} objects
---@param RejectZones table Table of @{Core.Zone#ZONE} objects
---@param ConflictZones table Table of @{Core.Zone#ZONE} objects
---@return MANTIS #self
function MANTIS:AddZones(AcceptZones, RejectZones, ConflictZones) end

---Function to set switch-on/off the debug state
---
------
---@param onoff boolean Set true to switch on
function MANTIS:Debug(onoff) end

---Function to get the HQ object for further use
---
------
---@return GROUP #The HQ #GROUP object or *nil* if it doesn't exist
function MANTIS:GetCommandCenter() end

--- Function to instantiate a new object of class MANTIS
---
------
---
---USAGE
---```
---Start up your MANTIS with a basic setting
---
---        myredmantis = MANTIS:New("myredmantis","Red SAM","Red EWR",nil,"red",false)
---        myredmantis:Start()
---
--- [optional] Use
---
---        myredmantis:SetDetectInterval(interval)
---        myredmantis:SetAutoRelocate(hq, ewr)
---
--- before starting #MANTIS to fine-tune your setup.
---
--- If you want to use a separate AWACS unit (default detection range: 250km) to support your EWR system, use e.g. the following setup:
---
---        mybluemantis = MANTIS:New("bluemantis","Blue SAM","Blue EWR",nil,"blue",false,"Blue Awacs")
---        mybluemantis:Start()
---```
------
---@param name string Name of this MANTIS for reporting
---@param samprefix string Prefixes for the SAM groups from the ME, e.g. all groups starting with "Red Sam..."
---@param ewrprefix string Prefixes for the EWR groups from the ME, e.g. all groups starting with "Red EWR..."
---@param hq? string Group name of your HQ (optional)
---@param coalition string Coalition side of your setup, e.g. "blue", "red" or "neutral"
---@param dynamic? boolean Use constant (true) filtering or just filter once (false, default) (optional)
---@param awacs? string Group name of your Awacs (optional)
---@param EmOnOff? boolean Make MANTIS switch Emissions on and off instead of changing the alarm state between RED and GREEN (optional)
---@param Padding? number For #SEAD - Extra number of seconds to add to radar switch-back-on time (optional)
---@param Zones table Table of Core.Zone#ZONE Zones Consider SAM groups in this zone(s) only for this MANTIS instance, must be handed as #table of Zone objects
---@return MANTIS #self
function MANTIS:New(name, samprefix, ewrprefix, hq, coalition, dynamic, awacs, EmOnOff, Padding, Zones) end

---On After "AdvStateChange" event.
---Advanced state changed, influencing detection speed.
---
------
---@param From string The From State
---@param Event string The Event
---@param To string The To State
---@param Oldstate number Old state - 0 = green, 1 = amber, 2 = red
---@param Newstate number New state - 0 = green, 1 = amber, 2 = red
---@param Interval number Calculated detection interval based on state and advanced feature setting
---@return MANTIS #self
function MANTIS:OnAfterAdvStateChange(From, Event, To, Oldstate, Newstate, Interval) end

---On After "GreenState" event.
---A SAM group was switched to GREEN alert.
---
------
---@param From string The From State
---@param Event string The Event
---@param To string The To State
---@param Group GROUP The GROUP object whose state was changed
---@return MANTIS #self
function MANTIS:OnAfterGreenState(From, Event, To, Group) end

---On After "RedState" event.
---A SAM group was switched to RED alert.
---
------
---@param From string The From State
---@param Event string The Event
---@param To string The To State
---@param Group GROUP The GROUP object whose state was changed
---@return MANTIS #self
function MANTIS:OnAfterRedState(From, Event, To, Group) end

---On After "Relocating" event.
---HQ and/or EWR moved.
---
------
---@param From string The From State
---@param Event string The Event
---@param To string The To State
---@return MANTIS #self
function MANTIS:OnAfterRelocating(From, Event, To) end

---On After "SeadSuppressionEnd" event.
---Mantis has switched on a site after a SEAD attack.
---
------
---@param From string The From State
---@param Event string The Event
---@param To string The To State
---@param Group GROUP The suppressed GROUP object
---@param Name string Name of the suppressed group
function MANTIS:OnAfterSeadSuppressionEnd(From, Event, To, Group, Name) end

---On After "SeadSuppressionPlanned" event.
---Mantis has planned to switch off a site to defend SEAD attack.
---
------
---@param From string The From State
---@param Event string The Event
---@param To string The To State
---@param Group GROUP The suppressed GROUP object
---@param Name string Name of the suppressed group
---@param SuppressionStartTime number Model start time of the suppression from `timer.getTime()`
---@param SuppressionEndTime number Model end time of the suppression from `timer.getTime()`
---@param Attacker GROUP The attacking GROUP object
function MANTIS:OnAfterSeadSuppressionPlanned(From, Event, To, Group, Name, SuppressionStartTime, SuppressionEndTime, Attacker) end

---On After "SeadSuppressionStart" event.
---Mantis has switched off a site to defend a SEAD attack.
---
------
---@param From string The From State
---@param Event string The Event
---@param To string The To State
---@param Group GROUP The suppressed GROUP object
---@param Name string Name of the suppressed group
---@param Attacker GROUP The attacking GROUP object
function MANTIS:OnAfterSeadSuppressionStart(From, Event, To, Group, Name, Attacker) end

---On After "ShoradActivated" event.
---Mantis has activated a SHORAD.
---
------
---@param From string The From State
---@param Event string The Event
---@param To string The To State
---@param Name string Name of the GROUP which SHORAD shall protect
---@param Radius number Radius around the named group to find SHORAD groups
---@param Ontime number Seconds the SHORAD will stay active
function MANTIS:OnAfterShoradActivated(From, Event, To, Name, Radius, Ontime) end

---Function to unlink #MANTIS from a #SHORAD installation
---
------
function MANTIS:RemoveShorad() end

---Function to set Advanded Mode
---
------
---
---USAGE
---```
---Advanced mode will *decrease* reactivity of MANTIS, if HQ and/or EWR network dies.  Set SAMs to RED state if both are dead.  Requires usage of an **HQ** object and the **dynamic** option.
---E.g. `mymantis:SetAdvancedMode(true, 90)`
---```
------
---@param onoff boolean If true, will activate Advanced Mode
---@param ratio number [optional] Percentage to use for advanced mode, defaults to 100%
function MANTIS:SetAdvancedMode(onoff, ratio) end

---Function to set autorelocation for HQ and EWR objects.
---Note: Units must be actually mobile in DCS!
---
------
---@param hq boolean If true, will relocate HQ object
---@param ewr boolean If true, will relocate  EWR objects
function MANTIS:SetAutoRelocate(hq, ewr) end

---Function to set separate AWACS detection instance
---
------
---@param prefix string Name of the AWACS group in the mission editor
function MANTIS:SetAwacs(prefix) end

---Function to set AWACS detection range.
---Defaults to 250.000m (250km) - use **before** starting your Mantis!
---
------
---@param range number Detection range of the AWACS group
function MANTIS:SetAwacsRange(range) end

---Function to set the HQ object for further use
---
------
---@param group GROUP The #GROUP object to be set as HQ
function MANTIS:SetCommandCenter(group) end

---Function to set how long INTEL DLINK remembers contacts.
---
------
---@param seconds number Remember this many seconds, at least 5 seconds.
---@return MANTIS #self
function MANTIS:SetDLinkCacheTime(seconds) end

---Function to set the detection interval
---
------
---@param interval number The interval in seconds
function MANTIS:SetDetectInterval(interval) end

---Function to set the grouping radius of the detection in meters
---
------
---@param radius number Radius upon which detected objects will be grouped
function MANTIS:SetEWRGrouping(radius) end

---Function to set the detection radius of the EWR in meters.
---(Deprecated, SAM range is used)
---
------
---@param radius number Radius of the EWR detection zone
function MANTIS:SetEWRRange(radius) end

---Function to set number of SAMs going active on a valid, detected thread
---
------
---@param Short number Number of short-range systems activated, defaults to 1.
---@param Mid number Number of mid-range systems activated, defaults to 2.
---@param Long number Number of long-range systems activated, defaults to 2.
---@param Classic number (non-automode) Number of overall systems activated, defaults to 6.
---@param Point number Number of point defense and AAA systems activated, defaults to 6.
---@return MANTIS #self
function MANTIS:SetMaxActiveSAMs(Short, Mid, Long, Classic, Point) end

---Function to set a new SAM firing engage range, use this method to adjust range while running MANTIS, e.g.
---for different setups day and night
---
------
---@param range number Percent of the max fire range
function MANTIS:SetNewSAMRangeWhileRunning(range) end

---Function to set switch-on/off zone for the SAM sites in meters.
---Overwritten per SAM in automode.
---
------
---@param radius number Radius of the firing zone in classic mode
function MANTIS:SetSAMRadius(radius) end

---Function to set SAM firing engage range, 0-100 percent, e.g.
---85
---
------
---@param range number Percent of the max fire range
function MANTIS:SetSAMRange(range) end

---[Internal] Function to set the SAM start state
---
------
---@return MANTIS #self
function MANTIS:SetSAMStartState() end

---Function to set Short Range SAMs to spit out smoke as decoy, if an enemy plane is in range.
---
------
---@param Onoff boolean Set to true for on and nil/false for off.
---@param Color? number (Optional) Color to use, defaults to `SMOKECOLOR.White`
function MANTIS:SetSmokeDecoy(Onoff, Color) end

---Set using your own #INTEL_DLINK object instead of #DETECTION
---
------
---@param DLink INTEL_DLINK The data link object to be used.
function MANTIS:SetUsingDLink(DLink) end

---Set using Emissions on/off instead of changing alarm state
---
------
---@param switch boolean Decide if we are changing alarm state or Emission state
function MANTIS:SetUsingEmOnOff(switch) end

---Triggers the FSM event "Start".
---Starts the MANTIS. Initializes parameters and starts event handlers.
---
------
function MANTIS:Start() end

---[Internal] Function to start the detection via AWACS if defined as separate (classic)
---
------
---@return DETECTION_AREAS #The running detection set
function MANTIS:StartAwacsDetection() end

---[Internal] Function to start the detection via EWR groups - if INTEL isn\'t available
---
------
---@return DETECTION_AREAS #The running detection set
function MANTIS:StartDetection() end

---[Internal] Function to start the detection with INTEL via EWR groups
---
------
---@return INTEL_DLINK #The running detection set
function MANTIS:StartIntelDetection() end

---Triggers the FSM event "Status".
---
------
function MANTIS:Status() end

---[Internal] Function to determine state of the advanced mode
---
------
---@return number #Newly calculated interval
---@return number #Previous state for tracking 0, 1, or 2
function MANTIS:_CalcAdvState() end

---[Internal] Check detection function
---
------
---@param detection DETECTION_AREAS Detection object
---@param dlink boolean 
---@param reporttolog boolean 
---@return MANTIS #self
function MANTIS:_Check(detection, dlink, reporttolog) end

---[Internal] Check advanced state
---
------
---@return MANTIS #self
function MANTIS:_CheckAdvState() end

---[Internal] Check if any EWR or AWACS is still alive
---
------
---@return boolean #outcome
function MANTIS:_CheckAnyEWRAlive() end

---[Internal] Function to check accept and reject zones
---
------
---@param coord COORDINATE The coordinate to check
---@return boolean #outcome
function MANTIS:_CheckCoordinateInZones(coord) end

---[Internal] Check DLink state
---
------
---@return MANTIS #self
function MANTIS:_CheckDLinkState() end

---[Internal] Function to check if EWR is (at least partially) alive
---
------
---@return boolean #True if EWR is alive, else false
function MANTIS:_CheckEWRState() end

---[Internal] Function to check if HQ is alive
---
------
---@return boolean #True if HQ is alive, else false
function MANTIS:_CheckHQState() end

---[Internal] Check detection function
---
------
---@param samset table Table of SAM data
---@param detset table Table of COORDINATES
---@param dlink boolean Using DLINK
---@param limit number of SAM sites to go active on a contact
---@return number #instatusred
---@return number #instatusgreen
---@return number #activeshorads
function MANTIS:_CheckLoop(samset, detset, dlink, limit) end

---[Internal] Function to check if any object is in the given SAM zone
---
------
---@param dectset table Table of coordinates of detected items
---@param samcoordinate COORDINATE Coordinate object.
---@param radius number Radius to check.
---@param height number Height to check.
---@param dlink boolean Data from DLINK.
---@return boolean #True if in any zone, else false
---@return number #Distance Target distance in meters or zero when no object is in zone
function MANTIS:_CheckObjectInZone(dectset, samcoordinate, radius, height, dlink) end

---[Internal] Function to get SAM firing data from units types.
---
------
---@param grpname string Name of the group
---@param mod boolean HDS mod flag
---@param sma boolean SMA mod flag
---@param chm boolean CH mod flag
---@return number #range Max firing range
---@return number #height Max firing height
---@return string #type Long, medium or short range
---@return number #blind "blind" spot
function MANTIS:_GetSAMDataFromUnits(grpname, mod, sma, chm) end

---[Internal] Function to get SAM firing data
---
------
---@param grpname string Name of the group
---@return number #range Max firing range
---@return number #height Max firing height
---@return string #type Long, medium or short range
---@return number #blind "blind" spot
function MANTIS:_GetSAMRange(grpname) end

---[Internal] Function to get the self.SAM_Table
---
------
---@return table #table
function MANTIS:_GetSAMTable() end

---[Internal] Function to prefilter height based
---
------
---@param height number 
---@return table #set
function MANTIS:_PreFilterHeight(height) end

---[Internal] Function to update SAM table and SEAD state
---
------
---@return MANTIS #self
function MANTIS:_RefreshSAMTable() end

---[Internal] Relocation relay function
---
------
---@return MANTIS #self
function MANTIS:_Relocate() end

---[Internal] Function to execute the relocation
---
------
---@return MANTIS #self 
function MANTIS:_RelocateGroups() end

---[Internal] Function to set the self.SAM_Table
---
------
---@param table NOTYPE 
---@return MANTIS #self
function MANTIS:_SetSAMTable(table) end

---Triggers the FSM event "Start" after a delay.
---Starts the MANTIS. Initializes parameters and starts event handlers.
---
------
---@param delay number Delay in seconds.
function MANTIS:__Start(delay) end

---Triggers the FSM event "Status" after a delay.
---
------
---@param delay number Delay in seconds.
function MANTIS:__Status(delay) end

---Triggers the FSM event "Stop" after a delay.
---Stops the MANTIS and all its event handlers.
---
------
---@param delay number Delay in seconds.
function MANTIS:__Stop(delay) end

---[Internal] Function triggered by Event AdvStateChange
---
------
---@param From string The From State
---@param Event string The Event
---@param To string The To State
---@param Oldstate number Old state - 0 = green, 1 = amber, 2 = red
---@param Newstate number New state - 0 = green, 1 = amber, 2 = red
---@param Interval number Calculated detection interval based on state and advanced feature setting
---@return MANTIS #self
---@private
function MANTIS:onafterAdvStateChange(From, Event, To, Oldstate, Newstate, Interval) end

---[Internal] Function triggered by Event GreenState
---
------
---@param From string The From State
---@param Event string The Event
---@param To string The To State
---@param Group GROUP The GROUP object whose state was changed
---@return MANTIS #self
---@private
function MANTIS:onafterGreenState(From, Event, To, Group) end

---[Internal] Function triggered by Event RedState
---
------
---@param From string The From State
---@param Event string The Event
---@param To string The To State
---@param Group GROUP The GROUP object whose state was changed
---@return MANTIS #self
---@private
function MANTIS:onafterRedState(From, Event, To, Group) end

---[Internal] Function triggered by Event Relocating
---
------
---@param From string The From State
---@param Event string The Event
---@param To string The To State
---@return MANTIS #self
---@private
function MANTIS:onafterRelocating(From, Event, To) end

---[Internal] Function triggered by Event SeadSuppressionEnd
---
------
---@param From string The From State
---@param Event string The Event
---@param To string The To State
---@param Group GROUP The suppressed GROUP object
---@param Name string Name of the suppressed group
---@private
function MANTIS:onafterSeadSuppressionEnd(From, Event, To, Group, Name) end

---[Internal] Function triggered by Event SeadSuppressionPlanned
---
------
---@param From string The From State
---@param Event string The Event
---@param To string The To State
---@param Group GROUP The suppressed GROUP object
---@param Name string Name of the suppressed group
---@param SuppressionStartTime number Model start time of the suppression from `timer.getTime()`
---@param SuppressionEndTime number Model end time of the suppression from `timer.getTime()`
---@param Attacker GROUP The attacking GROUP object
---@private
function MANTIS:onafterSeadSuppressionPlanned(From, Event, To, Group, Name, SuppressionStartTime, SuppressionEndTime, Attacker) end

---[Internal] Function triggered by Event SeadSuppressionStart
---
------
---@param From string The From State
---@param Event string The Event
---@param To string The To State
---@param Group GROUP The suppressed GROUP object
---@param Name string Name of the suppressed group
---@param Attacker GROUP The attacking GROUP object
---@private
function MANTIS:onafterSeadSuppressionStart(From, Event, To, Group, Name, Attacker) end

---[Internal] Function triggered by Event ShoradActivated
---
------
---@param From string The From State
---@param Event string The Event
---@param To string The To State
---@param Name string Name of the GROUP which SHORAD shall protect
---@param Radius number Radius around the named group to find SHORAD groups
---@param Ontime number Seconds the SHORAD will stay active
---@private
function MANTIS:onafterShoradActivated(From, Event, To, Name, Radius, Ontime) end

---[Internal] Function to set start state
---
------
---@param From string The From State
---@param Event string The Event
---@param To string The To State
---@return MANTIS #self
---@private
function MANTIS:onafterStart(From, Event, To) end

---[Internal] Status function for MANTIS
---
------
---@param From string The From State
---@param Event string The Event
---@param To string The To State
---@return MANTIS #self
---@private
function MANTIS:onafterStatus(From, Event, To) end

---[Internal] Function to stop MANTIS
---
------
---@param From string The From State
---@param Event string The Event
---@param To string The To State
---@return MANTIS #self
---@private
function MANTIS:onafterStop(From, Event, To) end

---[Internal] Before status function for MANTIS
---
------
---@param From string The From State
---@param Event string The Event
---@param To string The To State
---@return MANTIS #self
---@private
function MANTIS:onbeforeStatus(From, Event, To) end


---Advanced state enumerator
---@class MANTIS.AdvancedState 
---@field AMBER number 
---@field GREEN number 
---@field RED number 
MANTIS.AdvancedState = {}


---SAM data
---@class MANTIS.SamData 
---@field Avenger table 
---@field Blindspot number no-firing range (green circle)
---@field Chaparral table 
---@field Gepard table 
---@field HEMTT_C-RAM_Phalanx table 
---@field HQ-2 table 
---@field HQ-7 table 
---@field Hawk table 
---@field Height number Max firing height in km
---@field Linebacker table 
---@field NASAMS table 
---@field Patriot table 
---@field Point string Point defense capable
---@field Radar string Radar typename on unit level (used as key)
---@field Range number Max firing range in km
---@field Rapier table 
---@field Roland table 
---@field SA-10 table 
---@field SA-10B table 
---@field SA-11 table 
---@field SA-13 table 
---@field SA-15 table 
---@field SA-17 table 
---@field SA-19 table 
---@field SA-2 table 
---@field SA-20A table 
---@field SA-20B table 
---@field SA-3 table 
---@field SA-5 table 
---@field SA-6 table 
---@field SA-8 table 
---@field SA-9 table 
---@field STUNNER IDFA table 
---@field Silkworm table 
---@field TAMIR IDFA table 
---@field Type string #MANTIS.SamType of SAM, i.e. SHORT, MEDIUM or LONG (range)
MANTIS.SamData = {}


---SAM data CH
---@class MANTIS.SamDataCH 
---@field 2S38 CHM table 
---@field Blindspot number no-firing range (green circle)
---@field BukM3-9M317M CHM table 
---@field BukM3-9M317MA CHM table 
---@field C-RAM CHM table 
---@field FlaRakRad CHM table 
---@field HQ-17A CHM table 
---@field HQ-22 CHM table 
---@field Height number Max firing height in km
---@field IRIS-T SLM CHM table 
---@field LAV-AD CHM table 
---@field LD-3000 CHM table 
---@field LD-3000M CHM table 
---@field Lvkv9040M CHM table 
---@field M903PAC2 CHM table 
---@field M903PAC2KAT1 CHM table 
---@field M903PAC3 CHM table 
---@field NASAMS3-AIM9X2 CHM table 
---@field NASAMS3-AMRAAMER CHM table 
---@field PGL-625 CHM table 
---@field PGZ-09 CHM table 
---@field PGZ-95 CHM table 
---@field PantsirS1 CHM table 
---@field PantsirS2 CHM table 
---@field Point string Point defense capable
---@field RBS103A CHM table 
---@field RBS103AM CHM table 
---@field RBS103B CHM table 
---@field RBS103BM CHM table 
---@field RBS70 CHM table 
---@field RBS70M CHM table 
---@field RBS90 CHM table 
---@field RBS90M CHM table 
---@field RBS98M CHM table 
---@field Radar string Radar typename on unit level (used as key)
---@field Range number Max firing range in km
---@field S350-9M100 CHM table 
---@field S350-9M96D CHM table 
---@field SkySabre CHM table 
---@field Skynex CHM table 
---@field Skyshield CHM table 
---@field Stormer CHM table 
---@field THAAD CHM table 
---@field TorM2 CHM table 
---@field TorM2K CHM table 
---@field TorM2M CHM table 
---@field Type string #MANTIS.SamType of SAM, i.e. SHORT, MEDIUM or LONG (range)
---@field USInfantryFIM92K CHM table 
---@field WieselOzelot CHM table 
MANTIS.SamDataCH = {}


---SAM data HDS
---@class MANTIS.SamDataHDS 
---@field Blindspot number no-firing range (green circle)
---@field HQ-2 HDS table 
---@field Height number Max firing height in km
---@field Point string Point defense capable
---@field Radar string Radar typename on unit level (used as key)
---@field Range number Max firing range in km
---@field SA-10C HDS 1 table 
---@field SA-10C HDS 2 table 
---@field SA-12 HDS 1 table 
---@field SA-12 HDS 2 table 
---@field SA-2 HDS table 
---@field SA-23 HDS 1 table 
---@field SA-23 HDS 2 table 
---@field SA-3 HDS table 
---@field Type string #MANTIS.SamType of SAM, i.e. SHORT, MEDIUM or LONG (range)
MANTIS.SamDataHDS = {}


---SAM data SMA
---@class MANTIS.SamDataSMA 
---@field Blindspot number no-firing range (green circle)
---@field Height number Max firing height in km
---@field Lvkv9040M SMA table 
---@field Point string Point defense capable
---@field RBS103A SMA table 
---@field RBS103AM SMA table 
---@field RBS103B SMA table 
---@field RBS103BM SMA table 
---@field RBS70 SMA table 
---@field RBS70M SMA table 
---@field RBS90 SMA table 
---@field RBS90M SMA table 
---@field RBS98M SMA table 
---@field Radar string Radar typename on unit level (used as key)
---@field Range number Max firing range in km
---@field Type string #MANTIS.SamType of SAM, i.e. SHORT, MEDIUM or LONG (range)
MANTIS.SamDataSMA = {}


---SAM Type
---@class MANTIS.SamType 
---@field LONG string 
---@field MEDIUM string 
---@field POINT string 
---@field SHORT string 
MANTIS.SamType = {}



