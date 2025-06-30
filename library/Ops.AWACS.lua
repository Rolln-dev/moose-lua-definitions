---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/OPS_AWACS.jpg" width="100%">
---
---**Ops** - MOOSE AI AWACS Operations using text-to-speech.
---
---===
---
---**AWACS** - MOOSE AI AWACS Operations using text-to-speech.
---
---===
---
---## Example Missions:
---
---Demo missions can be found on [GitHub](https://github.com/FlightControl-Master/MOOSE_MISSIONS/tree/develop/Ops/Awacs/).
---
---## Videos:
---
---Demo videos can be found on [Youtube](https://www.youtube.com/watch?v=ocdy8QzTNN4&list=PLFxp425SeXnq-oS0DSjam1HtddywH8i_k)
---   
---===
---
---### Author: **applevangelist**
---
---*Of all men\'s miseries the bitterest is this: to know so much and to have control over nothing.* (Herodotus)
---
---===
---
---# AWACS AI Air Controller
---
--- * WIP (beta)
--- * AWACS replacement for the in-game AWACS
--- * Will control a fighter engagement zone and assign tasks to AI and human CAP flights
--- * Callouts referenced from:   
--- ** References from ARN33396 ATP 3-52.4 (Sep 2021) (Combined Forces)   
--- ** References from CNATRA P-877 (Rev 12-20) (NAVY)   
--- * FSM events that the mission designer can hook into
--- * Can also be used as GCI Controller
---
---## 0 Note for Multiplayer Setup
---
---Due to DCS limitations you need to set up a second, "normal" AWACS plane in multi-player/server environments to keep the EPLRS/DataLink going in these environments.
---Though working in single player, the situational awareness screens of the e.g. F14/16/18 will else not receive datalink targets.
---
---## 1 Prerequisites
---
---The radio callouts in this class are ***exclusively*** created with Text-To-Speech (TTS), based on the Moose Sound.SRS Class, and output is via [Ciribob's SRS system](https://github.com/ciribob/DCS-SimpleRadioStandalone/releases)
---Ensure you have this covered and working before tackling this class. TTS generation can thus be done via the Windows built-in system or via Google TTS; 
---the latter offers a wider range of voices and options, but you need to set up your own Google product account for this to work correctly.
---
---## 2 Mission Design - Operational Priorities
---
---Basic operational target of the AWACS is to control a Fighter Engagement Zone, or FEZ, and defend itself.
---
---## 3 Airwing(s)
---
---The AWACS plane, the optional escort planes, and the AI CAP planes work based on the Ops.Airwing class. Read and understand the manual for this class in 
---order to set everything up correctly. You will at least need one Squadron containing the AWACS plane itself.
---
---Set up the Airwing
---
---           local AwacsAW = AIRWING:New("AirForce WH-1","AirForce One")
---           AwacsAW:SetMarker(false)
---           AwacsAW:SetAirbase(AIRBASE:FindByName(AIRBASE.Caucasus.Kutaisi))
---           AwacsAW:SetRespawnAfterDestroyed(900)
---           AwacsAW:SetTakeoffAir()
---           AwacsAW:__Start(2)
---
---Add the AWACS template Squadron - **Note**: remove the task AWACS in the mission editor under "Advanced Waypoint Actions" from the template to remove the DCS F10 AWACS menu
---
---           local Squad_One = SQUADRON:New("Awacs One",2,"Awacs North")
---           Squad_One:AddMissionCapability({AUFTRAG.Type.ORBIT},100)
---           Squad_One:SetFuelLowRefuel(true)
---           Squad_One:SetFuelLowThreshold(0.2)
---           Squad_One:SetTurnoverTime(10,20)
---           AwacsAW:AddSquadron(Squad_One)
---           AwacsAW:NewPayload("Awacs One One",-1,{AUFTRAG.Type.ORBIT},100)
---           
---Add Escorts Squad (recommended, optional)
---
---           local Squad_Two = SQUADRON:New("Escorts",4,"Escorts North") -- taking a template with 2 planes here, will result in a group of 2 escorts which can fly in formation escorting the AWACS.
---           Squad_Two:AddMissionCapability({AUFTRAG.Type.ESCORT})
---           Squad_Two:SetFuelLowRefuel(true)
---           Squad_Two:SetFuelLowThreshold(0.3)
---           Squad_Two:SetTurnoverTime(10,20)
---           Squad_Two:SetTakeoffAir()
---           Squad_Two:SetRadio(255,radio.modulation.AM)
---           AwacsAW:AddSquadron(Squad_Two)
---           AwacsAW:NewPayload("Escorts",-1,{AUFTRAG.Type.ESCORT},100)
---           
---Add CAP Squad (recommended, optional)
---
---           local Squad_Three = SQUADRON:New("CAP",10,"CAP North")
---           Squad_Three:AddMissionCapability({AUFTRAG.Type.ALERT5, AUFTRAG.Type.CAP, AUFTRAG.Type.GCICAP, AUFTRAG.Type.INTERCEPT},80)
---           Squad_Three:SetFuelLowRefuel(true)
---           Squad_Three:SetFuelLowThreshold(0.3)
---           Squad_Three:SetTurnoverTime(10,20)
---           Squad_Three:SetTakeoffAir()
---           Squad_Two:SetRadio(255,radio.modulation.AM)
---           AwacsAW:AddSquadron(Squad_Three)
---           AwacsAW:NewPayload("Aerial-1-2",-1,{AUFTRAG.Type.ALERT5,AUFTRAG.Type.CAP, AUFTRAG.Type.GCICAP, AUFTRAG.Type.INTERCEPT},100)
---
---## 4 Zones
---
---For the setup, you need to set up a couple of zones:
---
---* An Orbit Zone, where your AWACS will orbit
---* A Fighter Engagement Zone or FEZ
---* A zone where your CAP flights will be stationed, waiting for assignments
---* Optionally, an additional zone you wish to defend
---* Optionally, a border of the opposing party
---* Also, and move your BullsEye in the mission accordingly - this will be the key reference point for most AWACS callouts
---
---### 4.1 Strategic considerations
---
---Your AWACS is an HVT or high-value-target. Thus it makes sense to position the Orbit Zone in a way that your FEZ and thus your CAP flights defend it. 
---It should hence be positioned behind the FEZ, away from the direction of enemy engagement.
---The zone for CAP stations should be close to the FEZ, but not inside it.
---The optional additional defense zone can be anywhere, but keep an eye on the location so your CAP flights don't take ages to get there. 
---The optional border is useful for e.g. "cold war" scenarios - planes across the border will not be considered as targets by AWACS.
---
---## 5 Set up AWACS
---
---           -- Set up AWACS called "AWACS North". It will use the AwacsAW Airwing set up above and be of the "blue" coalition. Homebase is Kutaisi.
---           -- The AWACS Orbit Zone is a round zone set in the mission editor named "Awacs Orbit", the FEZ is a Polygon-Zone called "Rock" we have also
---           -- set up in the mission editor with a late activated helo named "Rock#ZONE_POLYGON". Note this also sets the BullsEye to be referenced as "Rock".
---           -- The CAP station zone is called "Fremont". We will be on 255 AM.
---           local testawacs = AWACS:New("AWACS North",AwacsAW,"blue",AIRBASE.Caucasus.Kutaisi,"Awacs Orbit",ZONE:FindByName("Rock"),"Fremont",255,radio.modulation.AM )
---           -- set one escort group; this example has two units in the template group, so they can fly a nice formation.
---           testawacs:SetEscort(1,ENUMS.Formation.FixedWing.FingerFour.Group,{x=-500,y=50,z=500},45)
---           -- Callsign will be "Focus". We'll be a Angels 30, doing 300 knots, orbit leg to 88deg with a length of 25nm.
---           testawacs:SetAwacsDetails(CALLSIGN.AWACS.Focus,1,30,300,88,25)
---           -- Set up SRS on port 5010 - change the below to your path and port
---           testawacs:SetSRS("C:\\Program Files\\DCS-SimpleRadio-Standalone","female","en-GB",5010)
---           -- Add a "red" border we don't want to cross, set up in the mission editor with a late activated helo named "Red Border#ZONE_POLYGON"
---           testawacs:SetRejectionZone(ZONE:FindByName("Red Border"))
---           -- Our CAP flight will have the callsign "Ford", we want 4 AI planes, Time-On-Station is four hours, doing 300 kn IAS.
---           testawacs:SetAICAPDetails(CALLSIGN.Aircraft.Ford,4,4,300)
---           -- We're modern (default), e.g. we have EPLRS and get more fill-in information on detections
---           testawacs:SetModernEra()
---           -- And start
---           testawacs:__Start(5)
---           
---### 5.1 Alternative - Set up as GCI (no AWACS plane needed) Theater Air Control System (TACS)
---
---           -- Set up as TACS called "GCI Senaki". It will use the AwacsAW Airwing set up above and be of the "blue" coalition. Homebase is Senaki.
---           -- No need to set the AWACS Orbit Zone; the FEZ is still a Polygon-Zone called "Rock" we have also
---           -- set up in the mission editor with a late activated helo named "Rock#ZONE_POLYGON". Note this also sets the BullsEye to be referenced as "Rock".
---           -- The CAP station zone is called "Fremont". We will be on 255 AM. Note the Orbit Zone is given as *nil* in the `New()`-Statement
---           local testawacs = AWACS:New("GCI Senaki",AwacsAW,"blue",AIRBASE.Caucasus.Senaki_Kolkhi,nil,ZONE:FindByName("Rock"),"Fremont",255,radio.modulation.AM )
---           -- Set up SRS on port 5010 - change the below to your path and port
---           testawacs:SetSRS("C:\\Program Files\\DCS-SimpleRadio-Standalone","female","en-GB",5010)
---           -- Add a "red" border we don't want to cross, set up in the mission editor with a late activated helo named "Red Border#ZONE_POLYGON"
---           testawacs:SetRejectionZone(ZONE:FindByName("Red Border"))
---           -- Our CAP flight will have the callsign "Ford", we want 4 AI planes, Time-On-Station is four hours, doing 300 kn IAS.
---           testawacs:SetAICAPDetails(CALLSIGN.Aircraft.Ford,4,4,300)
---           -- We're modern (default), e.g. we have EPLRS and get more fill-in information on detections
---           testawacs:SetModernEra()
---           -- Give it a fancy callsign
---           testawacs:SetAwacsDetails(CALLSIGN.AWACS.Wizard)
---           -- And start as GCI using a group name "Blue EWR" as main EWR station
---           testawacs:SetAsGCI(GROUP:FindByName("Blue EWR"),2)
---           -- Set Custom CAP Flight Callsigns for use with TTS
---           testawacs:SetCustomCallsigns({
---             Devil = 'Bengal',
---             Snake = 'Winder',
---             Colt = 'Camelot',
---             Enfield = 'Victory',
---             Uzi = 'Evil Eye'
---           })
---           testawacs:__Start(4)
---           
---## 6 Menu entries
---
---**Note on Radio Menu entries**: Due to a DCS limitation, these are on GROUP level and not individual (UNIT level). Hence, either put each player in his/her own group,
---or ensure that only the flight lead will use the menu. Recommend the 1st option, unless you have a disciplined team.
---
---### 6.1 Check-in
---
---In the base setup, you need to check in to the AWACS to get the full menu. This can be done once the AWACS is airborne. You will get an Alpha Check callout 
---and be assigned a CAP station.
---
---### 6.2 Check-out
---
---You can check-out anytime, of course.
---
---### 6.3 Picture
---
---Get a picture from the AWACS. It will call out the three most important groups. References are **always** to the (named) BullsEye position.
---**Note** that AWACS will anyway do a regular picture call to all stations every five minutes.
---
---### 6.4 Bogey Dope
---
---Get bogey dope from the AWACS. It will call out the closest bogey group, if any. Reference is BRAA to the Player position.
---
---### 6.5 Declare
---
---AWACS will declare, if the bogey closest to the calling player in a 3nm circle is hostile, friendly or neutral.
---
---### 6.6 Tasking
---
---Tasking will show you the current task with "Showtask". Updated directions are shown, also.
---You can decline a **requested** task with "unable", and abort **any task but CAP station** with "abort".
---You can "commit" to a requested task within 3 minutes.
---"VID" - if AWACS is set to Visial ID or VID oncoming planes first, there will also be an "VID" entry. Similar to "Declare" you can declare the requested contact 
---to be hostile, friendly or neutral if you are close enough to it (3nm). If hostile, at the time of writing, an engagement task will be assigned to you (not: requested).
---If neutral/friendly, contact will be excluded from further tasking.
---
---## 7 Air-to-Air Timeline Support
---
---To support your engagement timeline, AWACS will make Tac-Range, Meld, Merge and Threat call-outs to the player/group (Figure 7-3, CNATRA P-877). Default settings in NM are 
---
---           Tac Distance = 45
---           Meld Distance = 35
---           Threat Distance = 25
---           Merge Distance = 5 
---
---## 8 Bespoke Player CallSigns
---
---Append the GROUP name of your client slots with "#CallSign" to use bespoke callsigns in AWACS callouts. E.g. "Player F14#Ghostrider" will be refered to 
---as "Ghostrider" plus group number, e.g. "Ghostrider 9". Alternatively, if you have set up your Player name in the "Logbook" in the mission editor main screen
---as e.g. "Pikes | Goose", you will be addressed as "Goose" by the AWACS callouts.
---
---## 9 Options
---
---There's a number of functions available, to set various options for the setup.
---
---* #AWACS.SetBullsEyeAlias() : Set the alias name of the Bulls Eye.
---* #AWACS.SetTOS() : Set time on station for AWACS and CAP.
---* #AWACS.SetReassignmentPause() : Pause this number of seconds before re-assigning a Player to a task.
---* #AWACS.SuppressScreenMessages() : Suppress message output on screen.
---* #AWACS.SetRadarBlur() : Set the radar blur faktor in percent.
---* #AWACS.SetColdWar() : Set to cold war - no fill-ins, no EPLRS, VID as standard.
---* #AWACS.SetModernEraDefensive() : Set to modern, EPLRS, BVR/IFF engagement, fill-ins.
---* #AWACS.SetModernEraAggressive() : Set to modern, EPLRS, BVR/IFF engagement, fill-ins.
---* #AWACS.SetPolicingModern() : Set to modern, EPLRS, VID engagement, fill-ins.
---* #AWACS.SetPolicingColdWar() : Set to cold war, no EPLRS, VID engagement, no fill-ins.
---* #AWACS.SetInterceptTimeline() : Set distances for TAC, Meld and Threat range calls.
---* #AWACS.SetAdditionalZone() : Add one additional defense zone, e.g. own border.
---* #AWACS.SetRejectionZone() : Add one foreign border. Targets beyond will be ignored for tasking.
---* #AWACS.DrawFEZ() : Show the FEZ on the F10 map.
---* #AWACS.SetAWACSDetails() : Set AWACS details.
---* #AWACS.AddGroupToDetection() : Add a GROUP or SET_GROUP object to INTEL detection, e.g. EWR.
---* #AWACS.SetSRS() : Set SRS details.
---* #AWACS.SetSRSVoiceCAP() : Set voice details for AI CAP planes, using Windows dektop TTS.
---* #AWACS.SetAICAPDetails() : Set AI CAP details.
---* #AWACS.SetEscort() : Set number of escorting planes for AWACS.
---* #AWACS.AddCAPAirWing() : Add an additional Ops.Airwing#AIRWING for CAP flights.
---* #AWACS.ZipLip() : Do not show messages on screen, no extra calls for player guidance, use short callsigns, no group tags.
---* #AWACS.AddFrequencyAndModulation() : Add additional frequencies with modulation which will receive AWACS SRS messages.
---
---## 9.1 Single Options
---
---Further single options (set before starting your AWACS instance, but after `:New()`)
---
---           testawacs.PlayerGuidance = true -- allow missile warning call-outs.
---           testawacs.NoGroupTags = false -- use group tags like Alpha, Bravo .. etc in call outs.
---           testawacs.callsignshort = true -- use short callsigns, e.g. "Moose 1", not "Moose 1-1".
---           testawacs.DeclareRadius = 5 -- you need to be this close to the lead unit for declare/VID to work, in NM.
---           testawacs.MenuStrict = true -- Players need to check-in to see the menu; check-in still require to use the menu.
---           testawacs.maxassigndistance = 100 -- Don't assign targets further out than this, in NM.
---           testawacs.debug = false -- set to true to produce more log output.
---           testawacs.NoMissileCalls = true -- suppress missile callouts
---           testawacs.PlayerCapAssignment = true -- no intercept task assignments for players
---           testawacs.invisible = false -- set AWACS to be invisible to hostiles
---           testawacs.immortal = false -- set AWACS to be immortal
---           -- By default, the radio queue is checked every 10 secs. This is altered by the calculated length of the sentence to speak
---           -- over the radio. Google and Windows speech speed is different. Use the below to fine-tune the setup in case of overlapping
---           -- messages or too long pauses
---           testawacs.GoogleTTSPadding = 1 -- seconds
---           testawacs.WindowsTTSPadding = 2.5 -- seconds
---           testawacs.PikesSpecialSwitch = false -- if set to true, AWACS will omit the "doing xy knots" on the station assignement callout
---           testawacs.IncludeHelicopters = false -- if set to true, Helicopter pilots will also get the AWACS Menu and options
---
---## 9.2 Bespoke random voices for AI CAP (Google TTS only)
---
---Currently there are 10 voices defined which are randomly assigned to the AI CAP flights:
---
---Defaults are:
---
---         testawacs.CapVoices = {
---           [1] = "de-DE-Wavenet-A",
---           [2] = "de-DE-Wavenet-B",
---           [3] = "fr-FR-Wavenet-A",
---           [4] = "fr-FR-Wavenet-B",
---           [5] = "en-GB-Wavenet-A",
---           [6] = "en-GB-Wavenet-B",
---           [7] = "en-GB-Wavenet-D",
---           [8] = "en-AU-Wavenet-B",
---           [9] = "en-US-Wavenet-J",
---           [10] = "en-US-Wavenet-H",
---          }
---
---## 10 Using F10 map markers to create new player station points
---
---You can use F10 map markers to create new station points for human CAP flights. The latest created station will take priority for (new) station assignments for humans.
---Enable this option with
---
---           testawacs.AllowMarkers = true
---           
---Set a marker on the map and add the following text to create a station: "AWACS Station London" - "AWACS Station" are the necessary keywords, "London" 
---in this example will be the name of the new station point. The user marker can then be deleted, an info marker point at the same place will remain.
---You can delete a player station point the same way: "AWACS Delete London"; note this will only work if currently there are no assigned flights on this station. 
---Lastly, you can move the station around with keyword "Move": "AWACS Move London".
---
---## 11 Localization
---
---Localization for English text is build-in. Default setting is English. Change with #AWACS.SetLocale()
---
---### 11.1 Adding Localization
---
---A list of fields to be defined follows below. **Note** that in some cases `string.format()` is used to format texts for screen and SRS. 
---Hence, the `%d`, `%s` and `%f` special characters need to appear in the exact same amount and order of appearance in the localized text or it will create errors.
---To add a localization, the following texts need to be translated and set in your mission script **before** #AWACS.Start():   
---
---     AWACS.Messages = {
---       EN =
---         {
---         DEFEND = "%s, %s! %s! %s! Defend!",
---         VECTORTO = "%s, %s. Vector%s %s",
---         VECTORTOTTS = "%s, %s, Vector%s %s",
---         ANGELS = ". Angels ",
---         ZERO = "zero",
---         VANISHED = "%s, %s Group. Vanished.",
---         VANISHEDTTS = "%s, %s group vanished.",
---         SHIFTCHANGE = "%s shift change for %s control.",
---         GROUPCAP = "Group",
---         GROUP = "group",
---         MILES = "miles",
---         THOUSAND = "thousand",
---         BOGEY = "Bogey",
---         ALLSTATIONS = "All Stations",
---         PICCLEAN = "%s. %s. Picture Clean.",
---         PICTURE = "Picture",
---         ONE = "One",
---         GROUPMULTI = "groups",
---         NOTCHECKEDIN = "%s. %s. Negative. You are not checked in.",
---         CLEAN = "%s. %s. Clean.",
---         DOPE = "%s. %s. Bogey Dope. ",
---         VIDPOS = "%s. %s. Copy, target identified as %s.",
---         VIDNEG = "%s. %s. Negative, get closer to target.",
---         FFNEUTRAL = "Neutral",
---         FFFRIEND = "Friendly",
---         FFHOSTILE = "Hostile",
---         FFSPADES = "Spades",
---         FFCLEAN = "Clean",
---         COPY = "%s. %s. Copy.",
---         TARGETEDBY = "Targeted by %s.",
---         STATUS = "Status",
---         ALREADYCHECKEDIN = "%s. %s. Negative. You are already checked in.",
---         ALPHACHECK = "Alpha Check",
---         CHECKINAI = "%s. %s. Checking in as fragged. Expected playtime %d hours. Request Alpha Check %s.",
---         SAFEFLIGHT = "%s. %s. Copy. Have a safe flight home.",
---         VERYLOW = "very low",
---         AIONSTATION = "%s. %s. On station over anchor %d at angels  %d. Ready for tasking.",
---         POPUP = "Pop-up",
---         NEWGROUP = "New group",
---         HIGH= " High.",
---         VERYFAST = " Very fast.",
---         FAST = " Fast.",
---         THREAT = "Threat",
---         MERGED = "Merged",
---         SCREENVID = "Intercept and VID %s group.",
---         SCREENINTER = "Intercept %s group.",
---         ENGAGETAG = "Targeted by %s.",
---         REQCOMMIT = "%s. %s group. %s. %s, request commit.",
---         AICOMMIT = "%s. %s group. %s. %s, commit.",
---         COMMIT = "Commit",
---         SUNRISE = "%s. All stations, SUNRISE SUNRISE SUNRISE, %s.",
---         AWONSTATION = "%s on station for %s control.",
---         STATIONAT = "%s. %s. Station at %s at angels %d.",
---         STATIONATLONG = "%s. %s. Station at %s at angels %d doing %d knots.",
---         STATIONSCREEN = "%s. %s.\nStation at %s\nAngels %d\nSpeed %d knots\nCoord %s\nROE %s.",
---         STATIONTASK = "Station at %s\nAngels %d\nSpeed %d knots\nCoord %s\nROE %s",
---         VECTORSTATION = " to Station",
---         TEXTOPTIONS1 = "Lost friendly flight",
---         TEXTOPTIONS2 =  "Vanished friendly flight",
---         TEXTOPTIONS3 =  "Faded friendly contact",
---         TEXTOPTIONS4 =  "Lost contact with",
---         },
---        } 
---
---e.g.
---
---           testawacs.Messages = {
---             DE = {
---               ...
---               FFNEUTRAL = "Neutral",
---               FFFRIEND = "Freund",
---               FFHOSTILE = "Feind",
---               FFSPADES = "Uneindeutig",
---               FFCLEAN = "Sauber",
---               ...
---             },
---            
---## 12 Discussion
---
---If you have questions or suggestions, please visit the [MOOSE Discord](https://discord.gg/AeYAkHP) #ops-awacs channel.
---
---
---Ops AWACS Class
---@class AWACS : FSM
---@field AICAPMissions FIFO FIFO for Ops.Auftrag#AUFTRAG for AI CAP
---@field AIonCAP number 
---@field AOCoordinate COORDINATE Coordinate of bulls eye
---@field AOName string name of the FEZ, e.g. Rock
---@field AccessKey  
---@field AirWing AIRWING 
---@field Airbase AIRBASE 
---@field AllowMarkers boolean 
---@field AnchorBaseAngels  
---@field AnchorStacks FIFO 
---@field AwacsAngels number 
---@field AwacsFG  
---@field AwacsInZone boolean 
---@field AwacsMission AUFTRAG 
---@field AwacsMissionReplacement AUFTRAG 
---@field AwacsROE string 
---@field AwacsROT string 
---@field AwacsReady boolean 
---@field AwacsSRS  
---@field AwacsTimeOnStation number 
---@field AwacsTimeStamp number 
---@field BorderZone ZONE 
---@field CAPAirwings FIFO 
---@field CAPIdleAI FIFO 
---@field CAPIdleHuman FIFO 
---@field CallSign number 
---@field CallSignClear  
---@field CallSignNo number 
---@field ClassName string Name of this class.
---@field Contacts FIFO 
---@field ContactsAO FIFO 
---@field ControlZone  
---@field Countactcounter number 
---@field DetectionSet SET_GROUP 
---@field EscortFormation  
---@field EscortMission AUFTRAG 
---@field EscortMissionReplacement AUFTRAG 
---@field EscortNumber  
---@field EscortsTimeOnStation number 
---@field EscortsTimeStamp number 
---@field FlightGroups FIFO 
---@field Frequency number 
---@field GCI boolean Act as GCI
---@field GCIGroup GROUP EWR group object for GCI ops
---@field GoogleTTSPadding number 
---@field HasEscorts boolean 
---@field IncludeHelicopters boolean 
---@field ManagedGrpID number 
---@field ManagedTaskID number 
---@field ManagedTasks FIFO 
---@field MarkerOps  
---@field MaxAIonCAP number 
---@field MaxMissionRange number 
---@field MeldDistance number 25nm - distance for "Meld" Call , usually shortly before the actual engagement 
---@field MenuStrict boolean 
---@field ModernEra boolean if true we get more intel on targets, and EPLR on the AIC
---@field Modulation number 
---@field MonitoringOn boolean 
---@field NoGroupTags boolean Set to true if you don't want group tags.
---@field NoMissileCalls boolean Suppress missile callouts
---@field OpenTasks FIFO 
---@field OpsZone ZONE 
---@field OrbitZone ZONE 
---@field PathToGoogleKey  
---@field PictureAO FIFO 
---@field PictureEWR FIFO 
---@field PictureInterval number Interval in seconds for general picture
---@field PictureTimeStamp number Interval timestamp
---@field PlayerCapAssignment boolean Assign players to CAP tasks when they are logged on
---@field PlayerGuidance boolean if true additional callouts to guide/warn players
---@field PlayerStationName string 
---@field PrioRadioQueue FIFO 
---@field RadarBlur number Radar blur in %
---@field RadioQueue FIFO 
---@field ReassignmentPause number Wait this many seconds before re-assignment of a player
---@field RejectZone ZONE 
---@field RejectZoneSet  
---@field ShiftChangeAwacsFlag boolean 
---@field ShiftChangeAwacsRequested boolean 
---@field ShiftChangeEscortsFlag boolean 
---@field ShiftChangeEscortsRequested boolean 
---@field Speed  
---@field SpeedBase  
---@field StationZone ZONE 
---@field SuppressScreenOutput boolean Set to true to suppress all screen output.
---@field TacDistance number 30nm - distance for "TAC" Call
---@field TacticalBaseFreq number 
---@field TacticalIncrFreq number 
---@field TacticalInterval number 
---@field TacticalMenu boolean 
---@field TacticalModulation number 
---@field TacticalQueue FIFO 
---@field TacticalSRS  
---@field TacticalSRSQ  
---@field TaskedCAPAI FIFO 
---@field TaskedCAPHuman FIFO 
---@field ThreatDistance number 15nm - distance to declare untargeted (new) threats
---@field WindowsTTSPadding number 
---@field ZoneSet  
---@field callsignCustomFunc  
---@field callsignshort boolean if true use short (group) callsigns, e.g. "Ghost 1", else "Ghost 1 1"
---@field callsigntxt  
---@field clientmenus FIFO 
---@field clientset SET_CLIENT 
---@field coalition number Coalition side.
---@field coalitiontxt string e.g."blue"
---@field debug boolean 
---@field gettext TEXTANDSOUND 
---@field intel INTEL 
---@field intelstarted boolean 
---@field keepnumber boolean if true, use the full string after # for a player custom callsign
---@field lid string LID for log entries.
---@field locale string Localization
---@field maxassigndistance number Only assing AI/Pilots to targets max this far away
---@field sunrisedone boolean 
---@field verbose number 
---@field version string Versioning.
AWACS = {}

---[User] Add another AirWing for AI CAP Flights under management
---
------
---@param self AWACS 
---@param AirWing AIRWING The AirWing to (also) obtain CAP flights from
---@param Zone ZONE_RADIUS (optional) This AirWing has it's own station zone, AI CAP will be send there
---@return AWACS #self
function AWACS:AddCAPAirWing(AirWing, Zone) end

---[User] Add additional frequency and modulation for AWACS SRS output.
---
------
---@param self AWACS 
---@param Frequency number The frequency to add, e.g. 132.5
---@param Modulation number The modulation to add for the frequency, e.g. radio.modulation.AM
---@return AWACS #self
function AWACS:AddFrequencyAndModulation(Frequency, Modulation) end

---[User] Add a radar GROUP object to the INTEL detection SET_GROUP
---
------
---@param self AWACS 
---@param Group GROUP The GROUP to be added. Can be passed as SET_GROUP.
---@return AWACS #self
function AWACS:AddGroupToDetection(Group) end

---[User] Draw a line around the FEZ on the F10 map.
---
------
---@param self AWACS 
---@return AWACS #self
function AWACS:DrawFEZ() end

---[User] Get AWACS Name
---
------
---@param self AWACS 
---@return string #Name of this instance
function AWACS:GetName() end

---Set up a new AI AWACS.
---
------
---
---USAGE
---```
---You can set up the OpsZone/FEZ in a number of ways:
---* As a string denominating a normal, round zone you have created and named in the mission editor, e.g. "Rock".
---* As a polygon zone, defined e.g. like `ZONE_POLYGON:New("Rock",GROUP:FindByName("RockZone"))` where "RockZone" is the name of a late activated helo, and it\'s waypoints (not more than 10) describe a closed polygon zone in the mission editor.
---* As a string denominating a polygon zone from the mission editor (same late activated helo, but named "Rock#ZONE_POLYGON" in the mission editor. Here, Moose will auto-create a polygon zone when loading, and name it "Rock". Pass as `ZONE:FindByName("Rock")`.
---```
------
---@param self AWACS 
---@param Name string Name of this AWACS for the radio menu.
---@param AirWing string The core Ops.Airwing#AIRWING managing the AWACS, Escort and (optionally) AI CAP planes for us.
---@param Coalition number Coalition, e.g. coalition.side.BLUE. Can also be passed as "blue", "red" or "neutral".
---@param AirbaseName string Name of the home airbase.
---@param AwacsOrbit string Name of the round, mission editor created zone where this AWACS orbits.
---@param OpsZone string Name of the round, mission editor created Fighter Engagement operations zone (FEZ) this AWACS controls. Can be passed as #ZONE_POLYGON.  The name of the zone will be used in reference calls as bulls eye name, so ensure a radio friendly name that does not collide with NATOPS keywords.
---@param StationZone string Name of the round, mission editor created anchor zone where CAP groups will be stationed. Usually a short city name.
---@param Frequency number Radio frequency, e.g. 271.
---@param Modulation number Radio modulation, e.g. radio.modulation.AM or radio.modulation.FM.
---@return AWACS #self
function AWACS:New(Name, AirWing, Coalition, AirbaseName, AwacsOrbit, OpsZone, StationZone, Frequency, Modulation) end

---On After "AssignedAnchor" event.
---AI or Player has been assigned a CAP station.
---
------
---@param self AWACS 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function AWACS:OnAfterAssignedAnchor(From, Event, To) end

---On After "AwacsShiftChange" event.
---AWACS shift change.
---
------
---@param self AWACS 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function AWACS:OnAfterAwacsShiftChange(From, Event, To) end

---On After "CheckedIn" event.
---AI or Player checked in.
---
------
---@param self AWACS 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function AWACS:OnAfterCheckedIn(From, Event, To) end

---On After "CheckedOut" event.
---AI or Player checked out.
---
------
---@param self AWACS 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function AWACS:OnAfterCheckedOut(From, Event, To) end

---On After "EscortShiftChange" event.
---AWACS escorts shift change.
---
------
---@param self AWACS 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function AWACS:OnAfterEscortShiftChange(From, Event, To) end

---On After "InterceptFailure" event.
---Intercept failure.
---
------
---@param self AWACS 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function AWACS:OnAfterIntercept(From, Event, To) end

---On After "LostCluster" event.
---AWACS lost a radar cluster.
---
------
---@param self AWACS 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function AWACS:OnAfterLostCluster(From, Event, To) end

---On After "LostContact" event.
---AWACS lost a radar contact.
---
------
---@param self AWACS 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function AWACS:OnAfterLostContact(From, Event, To) end

---On After "NewCluster" event.
---AWACS detected a cluster.
---
------
---@param self AWACS 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function AWACS:OnAfterNewCluster(From, Event, To) end

---On After "NewContact" event.
---AWACS detected a contact.
---
------
---@param self AWACS 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function AWACS:OnAfterNewContact(From, Event, To) end

---On After "ReAnchor" event.
---AI or Player has been send back to station.
---
------
---@param self AWACS 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function AWACS:OnAfterReAnchor(From, Event, To) end

---[User] Set AI CAP Plane Details
---
------
---@param self AWACS 
---@param Callsign number Callsign name of AI CAP, e.g. CALLSIGN.Aircraft.Dodge. Defaults to CALLSIGN.Aircraft.Colt. Note that not all available callsigns work for all plane types.
---@param MaxAICap number Maximum number of AI CAP planes on station that AWACS will set up automatically. Default to 4.
---@param TOS number Time on station, in  hours. AI planes might go back to base earlier if they run out of fuel or missiles.
---@param Speed number Airspeed to be used in knots. Will be adjusted to flight height automatically. Defaults to 270.
---@return AWACS #self
function AWACS:SetAICAPDetails(Callsign, MaxAICap, TOS, Speed) end

---[User] Set additional defensive zone, e.g.
---the zone behind the FEZ to also be defended
---
------
---@param self AWACS 
---@param Zone ZONE 
---@param Draw boolean Draw lines around this zone if true
---@return AWACS #self
function AWACS:SetAdditionalZone(Zone, Draw) end

---[User] Set this instance to act as GCI TACS Theater Air Control System
---
------
---@param self AWACS 
---@param EWR GROUP The **main** Early Warning Radar (EWR) GROUP object for GCI.
---@param Delay number (option) Start after this many seconds (optional).
---@return AWACS #self
function AWACS:SetAsGCI(EWR, Delay) end

---[User] Set AWACS flight details
---
------
---@param self AWACS 
---@param CallSign number Defaults to CALLSIGN.AWACS.Magic
---@param CallSignNo number Defaults to 1
---@param Angels number Defaults to 25 (i.e. 25000 ft)
---@param Speed number Defaults to 250kn
---@param Heading number Defaults to 0 (North)
---@param Leg number Defaults to 25nm
---@return AWACS #self
function AWACS:SetAwacsDetails(CallSign, CallSignNo, Angels, Speed, Heading, Leg) end

---[User] Change the bulls eye alias for AWACS callout.
---Defaults to "Rock"
---
------
---@param self AWACS 
---@param Name string 
---@return AWACS #self
function AWACS:SetBullsEyeAlias(Name) end

---[User] Set player callsign options for TTS output.
---See Wrapper.Group#GROUP.GetCustomCallSign() on how to set customized callsigns.
---
------
---@param self AWACS 
---@param ShortCallsign boolean If true, only call out the major flight number
---@param Keepnumber boolean If true, keep the **customized callsign** in the #GROUP name as-is, no amendments or numbers.
---@param CallsignTranslations table (Optional) Table to translate between DCS standard callsigns and bespoke ones. Does not apply if using customized. callsigns from playername or group name.
---@param CallsignCustomFunc func (Optional) For player names only(!). If given, this function will return the callsign. Needs to take the groupname and the playername as first two arguments.
---@param ... arg (Optional) Comma separated arguments to add to the custom function call after groupname and playername.
---@return AWACS #self
function AWACS:SetCallSignOptions(ShortCallsign, Keepnumber, CallsignTranslations, CallsignCustomFunc, ...) end

---[User] Set AWACS to Cold War standards - ROE to VID, ROT to Passive (bypass and escape).
---Radar blur 25%.
---Sets TAC/Meld/Threat call distances to 35, 25 and 15 nm.
---
------
---@param self AWACS 
---@return AWACS #self
function AWACS:SetColdWar() end

---[User] Set AWACS custom callsigns for TTS
---
------
---
---USAGE
---```
---You can overwrite the standard AWACS callsign for TTS usage with your own naming, e.g. like so:
---             testawacs:SetCustomAWACSCallSign({
---               [1]="Overlord", -- Overlord
---               [2]="Bookshelf", -- Magic
---               [3]="Wizard", -- Wizard
---               [4]="Focus", -- Focus
---               [5]="Darkstar", -- Darkstar
---               })
---The default callsign used in AWACS is "Magic". With the above change, the AWACS will call itself "Bookshelf" over TTS instead.
---```
------
---@param self AWACS 
---@param CallsignTable table Table of custom callsigns to use with TTS
---@return AWACS #self
function AWACS:SetCustomAWACSCallSign(CallsignTable) end

---[User] For CAP flights: Replace ME callsigns with user-defined callsigns for use with TTS and on-screen messaging
---
------
---
---USAGE
---```
---           -- Set Custom CAP Flight Callsigns for use with TTS
---           testawacs:SetCustomCallsigns({
---             Devil = 'Bengal',
---             Snake = 'Winder',
---             Colt = 'Camelot',
---             Enfield = 'Victory',
---             Uzi = 'Evil Eye'
---           })
---```
------
---@param self AWACS 
---@param translationTable table with DCS callsigns as keys and replacements as values
---@return AWACS #self
function AWACS:SetCustomCallsigns(translationTable) end

---[User] Set AWACS Escorts Template
---
------
---@param self AWACS 
---@param EscortNumber number Number of fighther plane GROUPs to accompany this AWACS. 0 or nil means no escorts. If you want >1 plane in an escort group, you can either set the respective squadron grouping to the desired number, or use a template for escorts with >1 unit.
---@param Formation number Formation the escort should take (if more than one plane), e.g. `ENUMS.Formation.FixedWing.FingerFour.Group`. Formation is used on GROUP level, multiple groups of one unit will NOT conform to this formation.
---@param OffsetVector table Offset the escorts should fly behind the AWACS, given as table, distance in meters, e.g. `{x=-500,y=0,z=500}` - 500m behind (negative value) and to the right (negative for left), no vertical separation (positive over, negative under the AWACS flight). For multiple groups, the vectors will be slightly changed to avoid collisions.
---@param EscortEngageMaxDistance number Escorts engage air targets max this NM away, defaults to 45NM.
---@return AWACS #self
function AWACS:SetEscort(EscortNumber, Formation, OffsetVector, EscortEngageMaxDistance) end

---[User] Set AWACS intercept timeline support distance.
---
------
---@param self AWACS 
---@param TacDistance number Distance for TAC call, default 45nm
---@param MeldDistance number Distance for Meld call, default 35nm
---@param ThreatDistance number Distance for Threat call, default 25nm
---@return AWACS #self
function AWACS:SetInterceptTimeline(TacDistance, MeldDistance, ThreatDistance) end

---[User] Set locale for localization.
---Defaults to "en"
---
------
---@param self AWACS 
---@param Locale string The locale to use
---@return AWACS #self
function AWACS:SetLocale(Locale) end

---[User] Set the max mission range flights can be away from their home base.
---
------
---@param self AWACS 
---@param NM number Distance in nautical miles
---@return AWACS #self
function AWACS:SetMaxMissionRange(NM) end

---[User] Set AWACS to Modern Era standards - ROE to BVR, ROT to defensive (evade fire).
---Radar blur 15%.
---
------
---@param self AWACS 
---@return AWACS #self
function AWACS:SetModernEra() end

---[User] Set AWACS to Modern Era standards - ROE to BVR, ROT to return fire.
---Radar blur 15%.
---
------
---@param self AWACS 
---@return AWACS #self
function AWACS:SetModernEraAggressive() end

---[User] Set AWACS to Modern Era standards - ROE to IFF, ROT to defensive (evade fire).
---Radar blur 15%.
---
------
---@param self AWACS 
---@return AWACS #self
function AWACS:SetModernEraDefensive() end

---[User] Set AWACS Player Guidance - influences missile callout and the "New" label in group callouts.
---
------
---@param self AWACS 
---@param Switch boolean If true (default) it is on, if false, it is off.
---@return AWACS #self
function AWACS:SetPlayerGuidance(Switch) end

---[User] Set AWACS to Policing standards - ROE to VID, ROT to Lock (bypass and escape).
---Radar blur 25%.
---Sets TAC/Meld/Threat call distances to 35, 25 and 15 nm.
---
------
---@param self AWACS 
---@return AWACS #self
function AWACS:SetPolicingColdWar() end

---[User] Set AWACS to Policing standards - ROE to VID, ROT to Lock (bypass and escape).
---Radar blur 15%.
---
------
---@param self AWACS 
---@return AWACS #self
function AWACS:SetPolicingModern() end

---[User] Set AWACS Radar Blur - the radar contact count per group/cluster will be distored up or down by this number percent.
---Defaults to 15 in Modern Era and 25 in Cold War.
---
------
---@param self AWACS 
---@param Percent number 
---@return AWACS #self
function AWACS:SetRadarBlur(Percent) end

---[User] Change number of seconds AWACS waits until a Player is re-assigned a different task.
---Defaults to 180.
---
------
---@param self AWACS 
---@param Seconds number 
---@return AWACS #self
function AWACS:SetReassignmentPause(Seconds) end

---[User] Set rejection zone, e.g.
---a border of a foreign country. Detected bogeys in here won't be engaged.
---
------
---@param self AWACS 
---@param Zone ZONE 
---@param Draw boolean Draw lines around this zone if true
---@return AWACS #self
function AWACS:SetRejectionZone(Zone, Draw) end

---[User] Set AWACS SRS TTS details - see Sound.SRS for details.
---`SetSRS()` will try to use as many attributes configured with Sound.SRS#MSRS.LoadConfigFile() as possible.
---
------
---@param self AWACS 
---@param PathToSRS string Defaults to "C:\\Program Files\\DCS-SimpleRadio-Standalone"
---@param Gender string Defaults to "male"
---@param Culture string Defaults to "en-US"
---@param Port number Defaults to 5002
---@param Voice string (Optional) Use a specifc voice with the @{Sound.SRS#SetVoice} function, e.g, `:SetVoice("Microsoft Hedda Desktop")`. Note that this must be installed on your windows system. Can also be Google voice types, if you are using Google TTS.
---@param Volume number Volume - between 0.0 (silent) and 1.0 (loudest)
---@param PathToGoogleKey string (Optional) Path to your google key if you want to use google TTS; if you use a config file for MSRS, hand in nil here.
---@param AccessKey string (Optional) Your Google API access key. This is necessary if DCS-gRPC is used as backend; if you use a config file for MSRS, hand in nil here.
---@param Backend string (Optional) Your MSRS Backend if different from your config file settings, e.g. MSRS.Backend.SRSEXE or MSRS.Backend.GRPC
---@return AWACS #self
function AWACS:SetSRS(PathToSRS, Gender, Culture, Port, Voice, Volume, PathToGoogleKey, AccessKey, Backend) end

---[User] Set AWACS Voice Details for AI CAP Planes  - SRS TTS - see Sound.SRS for details
---
------
---@param self AWACS 
---@param Gender string Defaults to "male"
---@param Culture string Defaults to "en-US"
---@param Voice string (Optional) Use a specifc voice with the @{#MSRS.SetVoice} function, e.g, `:SetVoice("Microsoft Hedda Desktop")`. Note that this must be installed on your windows system. Can also be Google voice types, if you are using Google TTS.
---@return AWACS #self
function AWACS:SetSRSVoiceCAP(Gender, Culture, Voice) end

---[User] Set TOS Time-on-Station in Hours
---
------
---@param self AWACS 
---@param AICHours number AWACS stays this number of hours on station before shift change, default is 4.
---@param CapHours number (optional) CAP stays this number of hours on station before shift change, default is 4.
---@return AWACS #self
function AWACS:SetTOS(AICHours, CapHours) end

---[User] Set the tactical information option, create 10 radio channels groups can subscribe and get Bogey Dope on a specific frequency automatically.
---You **need** to set up SRS first before using this!
---
------
---@param self AWACS 
---@param BaseFreq number Base Frequency to use, defaults to 130.
---@param Increase number Increase to use, defaults to 0.5, thus channels created are 130, 130.5, 131 .. etc.
---@param Modulation number Modulation to use, defaults to radio.modulation.AM.
---@param Interval number Seconds between each update call.
---@param Number number Number of Frequencies to create, can be 1..10.
---@return AWACS #self
function AWACS:SetTacticalRadios(BaseFreq, Increase, Modulation, Interval, Number) end

---Triggers the FSM event "Start".
---Starts the AWACS. Initializes parameters and starts event handlers.
---
------
---@param self AWACS 
function AWACS:Start() end

---[User] Do not show messages on screen
---
------
---@param self AWACS 
---@param Switch boolean If true, no messages will be shown on screen.
---@return AWACS #self
function AWACS:SuppressScreenMessages(Switch) end

---[User] Do not show messages on screen, no extra calls for player guidance, use short callsigns etc.
---
------
---@param self AWACS 
---@return AWACS #self
function AWACS:ZipLip() end

---[Internal] Announce a new contact
---
------
---@param self AWACS 
---@param Contact AWACS.ManagedContact 
---@param IsNew boolean Is a new contact
---@param Group GROUP Announce to Group if not nil
---@param IsBogeyDope boolean If true, this is a bogey dope announcement
---@param Tag string Tag name for this contact. Alpha, Brave, Charlie ... 
---@param IsPopup boolean This is a pop-up group
---@param ReportingName string The NATO code reporting name for the contact, e.g. "Foxbat". "Bogey" if unknown.
---@param Tactical boolean 
---@return AWACS #self
function AWACS:_AnnounceContact(Contact, IsNew, Group, IsBogeyDope, Tag, IsPopup, ReportingName, Tactical) end

---[Internal] AWACS Assign Anchor Position to a Group
---
------
---@param self AWACS 
---@param GID number Managed Group ID
---@param HasOwnStation boolean 
---@param StationName string 
---@return AWACS #self
function AWACS:_AssignAnchorToID(GID, HasOwnStation, StationName) end

---[Internal] Assign a Pilot to a target
---
------
---@param self AWACS 
---@param Pilots table Table of #AWACS.ManagedGroup Pilot 
---@param Targets FIFO FiFo of #AWACS.ManagedContact Targets
---@return AWACS #self 
function AWACS:_AssignPilotToTarget(Pilots, Targets) end

---[Internal] AWACS Menu for Bogey Dope
---
------
---@param self AWACS 
---@param Group GROUP Group to use
---@param Tactical boolean Check for tactical info
---@return AWACS #self
function AWACS:_BogeyDope(Group, Tactical) end

---[Internal] Check Enough AI CAP on Station
---
------
---@param self AWACS 
---@return AWACS #self
function AWACS:_CheckAICAPOnStation() end


---
------
---@param self NOTYPE 
function AWACS:_CheckAwacsStatus() end

---[Internal] AWACS Menu for Check in
---
------
---@param self AWACS 
---@param Group GROUP Group to use
---@return AWACS #self
function AWACS:_CheckIn(Group) end

---[Internal] AWACS Menu for CheckInAI
---
------
---@param self AWACS 
---@param FlightGroup FLIGHTGROUP to use
---@param Group GROUP Group to use
---@param AuftragsNr number Ops.Auftrag#AUFTRAG.auftragsnummer
---@return AWACS #self
function AWACS:_CheckInAI(FlightGroup, Group, AuftragsNr) end

---[Internal] Check merges for Players
---
------
---@param self AWACS 
---@return AWACS #self
function AWACS:_CheckMerges() end

---[Internal] AWACS Menu for Check Out
---
------
---@param self AWACS 
---@param Group GROUP Group to use
---@param GID number GroupID
---@param dead boolean If true, group is dead crashed or otherwise n/a
---@return AWACS #self
function AWACS:_CheckOut(Group, GID, dead) end

---[Internal] _CheckSubscribers
---
------
---@param self AWACS 
---@return AWACS #self
function AWACS:_CheckSubscribers() end

---[Internal] Check available tasks and status
---
------
---@param self AWACS 
---@return AWACS #self
function AWACS:_CheckTaskQueue() end

---[Internal] Clean up mission stack
---
------
---@param self AWACS 
---@return number #CAPMissions
---@return number #Alert5Missions
---@return number #InterceptMissions
function AWACS:_CleanUpAIMissionStack() end

---[Internal] Clean up contacts list
---
------
---@param self AWACS 
---@return AWACS #self
function AWACS:_CleanUpContacts() end

---[Internal] AWACS Menu for Commit
---
------
---@param self AWACS 
---@param Group GROUP Group to use
---@return AWACS #self
function AWACS:_Commit(Group) end


---
------
---@param self NOTYPE 
function AWACS:_ConsistencyCheck() end

---[Internal] AWACS Create a new Anchor Stack
---
------
---@param self AWACS 
---@return boolean #success
---@return number #AnchorStackNo
function AWACS:_CreateAnchorStack() end

---[Internal] AWACS Create a new Anchor Stack from a Marker - this then is the preferred station for players
---
------
---@param self AWACS 
---@param Name NOTYPE 
---@param Coord NOTYPE 
---@return AWACS #self 
function AWACS:_CreateAnchorStackFromMarker(Name, Coord) end

---[Internal] AWACS Speak Bogey Dope entries
---
------
---@param self AWACS 
---@param Callsign string Callsign to address
---@param GID number GroupID for comms
---@param Tactical boolean Is for tactical info
---@return AWACS #self
function AWACS:_CreateBogeyDope(Callsign, GID, Tactical) end

---[Internal] AWACS Speak Picture AO/EWR entries
---
------
---@param self AWACS 
---@param AO boolean If true this is for AO, else EWR
---@param Callsign string Callsign to address
---@param GID number GroupID for comms
---@param MaxEntries number Max entries to show
---@param IsGeneral boolean Is a general picture, address all stations
---@return AWACS #self
function AWACS:_CreatePicture(AO, Callsign, GID, MaxEntries, IsGeneral) end

---[Internal] Register Task for Group by GID
---
------
---@param self AWACS 
---@param GroupID number ManagedGroup ID
---@param Description AWACS.TaskDescription Short Description Task Type
---@param ScreenText string Long task description for screen output
---@param Object table Object for Ops.Target#TARGET assignment
---@param TaskStatus AWACS.TaskStatus Status of this task
---@param Auftrag AUFTRAG The Auftrag for this task if any
---@param Cluster INTEL.Cluster Intel Cluster for this task
---@param Contact INTEL.Contact Intel Contact for this task
---@return number #TID Task ID created
function AWACS:_CreateTaskForGroup(GroupID, Description, ScreenText, Object, TaskStatus, Auftrag, Cluster, Contact) end

---[Internal] AWACS Menu for Declare
---
------
---@param self AWACS 
---@param Group GROUP Group to use
---@return AWACS #self
function AWACS:_Declare(Group) end

---[Internal] AWACS Delete a new Anchor Stack from a Marker - only works if no assignments are on the station
---
------
---@param self AWACS 
---@param Name NOTYPE 
---@param Coord NOTYPE 
---@return AWACS #self 
function AWACS:_DeleteAnchorStackFromMarker(Name, Coord) end

---[Internal] Event handler
---
------
---@param self AWACS 
---@param EventData EVENTDATA 
---@return AWACS #self
function AWACS:_EventHandler(EventData) end

---[Internal] Check for alive OpsGroup from Mission OpsGroups table
---
------
---@param self AWACS 
---@param OpsGroups table 
---@return OPSGROUP #or nil
function AWACS:_GetAliveOpsGroupFromTable(OpsGroups) end

---[Internal] Get BR text for TTS - ie "Rock 214, 24 miles" and TTS "Rock 2 1 4, 24 miles"
---
------
---@param self AWACS 
---@param clustercoordinate COORDINATE 
---@return string #BRAText
---@return string #BRATextTTS
function AWACS:_GetBRAfromBullsOrAO(clustercoordinate) end

---[Internal] Get blurred size of group or cluster
---
------
---@param self AWACS 
---@param size number 
---@return number #adjusted size
---@return string #AWACS.Shipsize entry for size 1..4
function AWACS:_GetBlurredSize(size) end

---[Internal] AWACS Get TTS compatible callsign
---
------
---@param self AWACS 
---@param Group GROUP Group to use
---@param GID number GID to use
---@param IsPlayer boolean Check in player if true
---@return string #Callsign
function AWACS:_GetCallSign(Group, GID, IsPlayer) end

---[Internal] AWACS get free anchor stack for managed groups
---
------
---@param self AWACS 
---@return number #AnchorStackNo
---@return boolean #free 
function AWACS:_GetFreeAnchorStack() end

---[Internal] Event handler
---
------
---@param self AWACS 
---@param Group GROUP Group, can also be passed as #string group name
---@return boolean #found
---@return number #GID
---@return string #CallSign
function AWACS:_GetGIDFromGroupOrName(Group) end

---[Internal] Select pilots available for tasking, return AI and Human
---
------
---@param self AWACS 
---@return table #AIPilots Table of #AWACS.ManagedGroup
---@return table #HumanPilots Table of #AWACS.ManagedGroup
function AWACS:_GetIdlePilots() end

---[Internal] Check if a group has checked in
---
------
---@param self AWACS 
---@param Group GROUP Group to check
---@return number #ID
---@return boolean #CheckedIn
---@return string #CallSign
function AWACS:_GetManagedGrpID(Group) end

---[Internal] Get threat level as clear test
---
------
---@param self AWACS 
---@param threatlevel number 
---@return string #threattext
function AWACS:_GetThreatLevelText(threatlevel) end

---[Internal] Init localization
---
------
---@param self AWACS 
---@return AWACS #self
function AWACS:_InitLocalization() end

---[Internal] AWACS Menu for Judy
---
------
---@param self AWACS 
---@param Group GROUP Group to use
---@return AWACS #self
function AWACS:_Judy(Group) end

---[Internal] Write stats to log
---
------
---@param self AWACS 
---@return AWACS #self
function AWACS:_LogStatistics() end

---[Internal] Meld Range Call to Pilot
---
------
---@param self AWACS 
---@param GID number GID
---@param Contact AWACS.ManagedContact 
---@return AWACS #self
function AWACS:_MeldRangeCall(GID, Contact) end

---[Internal] Merged Call to Pilot
---
------
---@param self AWACS 
---@param GID number 
---@return AWACS #self
function AWACS:_MergedCall(GID) end

---[Internal] Create radio entry to tell players that CAP is on station in Anchor
---
------
---@param self AWACS 
---@param GID number Group ID 
---@return AWACS #self
function AWACS:_MessageAIReadyForTasking(GID) end

---[Internal] Message a vector BR to a position
---
------
---@param self AWACS 
---@param GID number Group GID
---@param Tag string (optional) Text to add after Vector, e.g. " to Anchor" - NOTE the leading space
---@param Coordinate COORDINATE The Coordinate to use
---@param Angels number (Optional) Add Angels 
---@return AWACS #self
function AWACS:_MessageVector(GID, Tag, Coordinate, Angels) end

---[Internal] Missile Warning Callout
---
------
---@param self AWACS 
---@param Coordinate COORDINATE Where the shot happened
---@param Type string Type to call out, e.i. "SAM" or "Missile"
---@param Warndist number Distance in NM to find friendly planes
---@return AWACS #self
function AWACS:_MissileWarning(Coordinate, Type, Warndist) end

---[Internal] AWACS Move a new Anchor Stack from a Marker
---
------
---@param self AWACS 
---@param Name NOTYPE 
---@param Coord NOTYPE 
---@return AWACS #self 
function AWACS:_MoveAnchorStackFromMarker(Name, Coord) end

---[Internal] Create a AIC-TTS message entry
---
------
---@param self AWACS 
---@param TextTTS string Text to speak
---@param TextScreen string Text for screen
---@param GID number Group ID #AWACS.ManagedGroup GID
---@param IsGroup boolean Has a group
---@param ToScreen boolean Show on screen
---@param IsNew boolean New
---@param FromAI boolean From AI
---@param IsPrio boolean Priority entry
---@param Tactical boolean Is for tactical info
---@return AWACS #self
function AWACS:_NewRadioEntry(TextTTS, TextScreen, GID, IsGroup, ToScreen, IsNew, FromAI, IsPrio, Tactical) end

---[Internal] AWACS Menu for Picture
---
------
---@param self AWACS 
---@param Group GROUP Group to use
---@param IsGeneral boolean General picture if true, address no-one specific
---@return AWACS #self
function AWACS:_Picture(Group, IsGeneral) end

---[Internal] Read assigned Group from a TaskID
---
------
---@param self AWACS 
---@param TaskID number ManagedTask ID
---@return AWACS.ManagedGroup #Group structure or nil if n/e
function AWACS:_ReadAssignedGroupFromTID(TaskID) end

---[Internal] Read registered Task for Group by its ID
---
------
---@param self AWACS 
---@param GroupID number ManagedGroup ID
---@return AWACS.ManagedTask #Task or nil if n/e
function AWACS:_ReadAssignedTaskFromGID(GroupID) end

---TODO
---[Internal] _RefreshMenuNonSubscribed
---
------
---@param self AWACS 
---@return AWACS #self
function AWACS:_RefreshMenuNonSubscribed() end

---[Internal] Remove GID (group) from Anchor Stack
---
------
---@param self AWACS 
---@param ID AWACS.ManagedGroup.GID 
---@param AnchorStackNo number 
---@param Angels number 
---@param GID NOTYPE 
---@return AWACS #self
function AWACS:_RemoveIDFromAnchor(ID, AnchorStackNo, Angels, GID) end

---[Internal] Set ROE for AI CAP
---
------
---@param self AWACS 
---@param FlightGroup FLIGHTGROUP 
---@param Group GROUP 
---@return AWACS #self
function AWACS:_SetAIROE(FlightGroup, Group) end

---[Internal] AWACS set client menus
---
------
---@param self AWACS 
---@return AWACS #self
function AWACS:_SetClientMenus() end

---[Internal] AWACS Menu for Show Info
---
------
---@param self AWACS 
---@param Group GROUP Group to use
---@return AWACS #self
function AWACS:_ShowAwacsInfo(Group) end

---[Internal] AWACS Menu for Showtask
---
------
---@param self AWACS 
---@param Group GROUP Group to use
---@return AWACS #self
function AWACS:_Showtask(Group) end

---[Internal] Start AWACS Escorts FlightGroup
---
------
---@param self AWACS 
---@param Shiftchange boolean This is a shift change call
---@return AWACS #self
function AWACS:_StartEscorts(Shiftchange) end

---[Internal] Start INTEL detection when we reach the AWACS Orbit Zone
---
------
---@param self AWACS 
---@param awacs GROUP 
---@return AWACS #self
function AWACS:_StartIntel(awacs) end

---[Internal] AWACS further Start Settings
---
------
---@param self AWACS 
---@param FlightGroup FLIGHTGROUP 
---@param Mission AUFTRAG 
---@return AWACS #self
function AWACS:_StartSettings(FlightGroup, Mission) end

---[Internal] _SubScribeTactRadio
---
------
---@param self AWACS 
---@param Group GROUP 
---@param Frequency number 
---@return AWACS #self
function AWACS:_SubScribeTactRadio(Group, Frequency) end

---[Internal] TAC Range Call to Pilot
---
------
---@param self AWACS 
---@param GID number GID
---@param Contact AWACS.ManagedContact 
---@return AWACS #self
function AWACS:_TACRangeCall(GID, Contact) end

---[Internal] Select max 3 targets for picture, bogey dope etc
---
------
---@param self AWACS 
---@param Untargeted boolean Return not yet targeted contacts only
---@return boolean #HaveTargets True if targets could be found, else false
---@return FIFO #Targetselection
function AWACS:_TargetSelectionProcess(Untargeted) end

---[Internal] AWACS Menu for Abort
---
------
---@param self AWACS 
---@param Group GROUP Group to use
---@return AWACS #self
function AWACS:_TaskAbort(Group) end

---[Internal] Threat Range Call to Pilot
---
------
---@param self AWACS 
---@param GID NOTYPE 
---@param Contact NOTYPE 
---@return AWACS #self
function AWACS:_ThreatRangeCall(GID, Contact) end

---[Internal] Get BR text for TTS
---
------
---@param self AWACS 
---@param FromCoordinate COORDINATE 
---@param ToCoordinate COORDINATE 
---@return string #BRText Desired Output (BR) "214, 35 miles"
---@return string #BRTextTTS Desired Output (BR) "2 1 4, 35 miles"
function AWACS:_ToStringBR(FromCoordinate, ToCoordinate) end

---[Internal] Get BRA text for TTS
---
------
---@param self AWACS 
---@param FromCoordinate COORDINATE 
---@param ToCoordinate COORDINATE 
---@param Altitude number Altitude in meters
---@return string #BRText Desired Output (BRA) "214, 35 miles, 20 thousand"
---@return string #BRTextTTS Desired Output (BRA) "2 1 4, 35 miles, 20 thousand"
function AWACS:_ToStringBRA(FromCoordinate, ToCoordinate, Altitude) end

---[Internal] Return Bullseye BR for Alpha Check etc, returns e.g.
---"Rock 021, 16" ("Rock" being the set BE name)
---
------
---@param self AWACS 
---@param Coordinate COORDINATE 
---@param ssml boolean Add SSML tag
---@param TTS boolean For non-Alpha checks, hand back in format "Rock 0 2 1, 16"
---@return string #BullseyeBR
function AWACS:_ToStringBULLS(Coordinate, ssml, TTS) end

---[Internal] Change Bullseye string to be TTS friendly,  "Bullseye 021, 16" returns e.g.
---"Bulls eye 0 2 1. 1 6"
---
------
---@param self AWACS 
---@param Text string Input text
---@return string #BullseyeBRTTS
function AWACS:_ToStringBullsTTS(Text) end

---[Internal] AWACS Menu for Unable
---
------
---@param self AWACS 
---@param Group GROUP Group to use
---@return AWACS #self
function AWACS:_Unable(Group) end

---[Internal] _UnsubScribeTactRadio
---
------
---@param self AWACS 
---@param Group GROUP 
---@return AWACS #self
function AWACS:_UnsubScribeTactRadio(Group) end

---[Internal] Update Contact Tag
---
------
---@param self AWACS 
---@param CID number Contact ID
---@param Text string Text to be used
---@param TAC boolean TAC Call done
---@param MELD boolean MELD Call done
---@param TaskStatus string Overwrite status with #AWACS.TaskStatus  Status
---@return AWACS #self
function AWACS:_UpdateContactEngagementTag(CID, Text, TAC, MELD, TaskStatus) end

---[Internal] Update contact from cluster data
---
------
---@param self AWACS 
---@param CID number Contact ID
---@return AWACS #self
function AWACS:_UpdateContactFromCluster(CID) end

---[Internal] AWACS Menu for VID
---
------
---@param self AWACS 
---@param Group GROUP Group to use
---@param Declaration string Text declaration the player used
---@return AWACS #self
function AWACS:_VID(Group, Declaration) end

---Triggers the FSM event "Start" after a delay.
---Starts the AWACS. Initializes parameters and starts event handlers.
---
------
---@param self AWACS 
---@param delay number Delay in seconds.
function AWACS:__Start(delay) end

---Triggers the FSM event "Stop" after a delay.
---Stops the AWACS and all its event handlers.
---
------
---@param self AWACS 
---@param delay number Delay in seconds.
function AWACS:__Stop(delay) end

---[Internal] onafterAssignAnchor
---
------
---@param self AWACS 
---@param From string 
---@param Event string 
---@param To string 
---@param GID number Group ID
---@param HasOwnStation boolean 
---@param HasOwnStation string 
---@param StationName NOTYPE 
---@return AWACS #self
function AWACS:onafterAssignAnchor(From, Event, To, GID, HasOwnStation, HasOwnStation, StationName) end

---[Internal] onafterAssignedAnchor
---
------
---@param self AWACS 
---@param From string 
---@param Event string 
---@param To string 
---@param GID number Managed Group ID
---@param Anchor AWACS.AnchorData 
---@param AnchorStackNo number 
---@param AnchorAngels NOTYPE 
---@return AWACS #self
function AWACS:onafterAssignedAnchor(From, Event, To, GID, Anchor, AnchorStackNo, AnchorAngels) end

---[Internal] onafterAwacsShiftChange
---
------
---@param self AWACS 
---@param From string 
---@param Event string 
---@param To string 
---@return AWACS #self
function AWACS:onafterAwacsShiftChange(From, Event, To) end

---[Internal] onafterCheckRadioQueue
---
------
---@param self AWACS 
---@param From string 
---@param Event string 
---@param To string 
---@return AWACS #self
function AWACS:onafterCheckRadioQueue(From, Event, To) end

---[Internal] onafterCheckTacticalQueue
---
------
---@param self AWACS 
---@param From string 
---@param Event string 
---@param To string 
---@return AWACS #self
function AWACS:onafterCheckTacticalQueue(From, Event, To) end

---[Internal] onafterCheckedOut
---
------
---@param self AWACS 
---@param From string 
---@param Event string 
---@param To string 
---@param Group AWACS.ManagedGroup.GID ID 
---@param AnchorStackNo number 
---@param Angels number 
---@param GID NOTYPE 
---@return AWACS #self
function AWACS:onafterCheckedOut(From, Event, To, Group, AnchorStackNo, Angels, GID) end

---[Internal] onafterEscortShiftChange
---
------
---@param self AWACS 
---@param From string 
---@param Event string 
---@param To string 
---@return AWACS #self
function AWACS:onafterEscortShiftChange(From, Event, To) end

---On after "FlightOnMission".
---
------
---@param self AWACS 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param FlightGroup FLIGHTGROUP on mission.
---@param Mission AUFTRAG The requested mission.
---@return AWACS #self
function AWACS:onafterFlightOnMission(From, Event, To, FlightGroup, Mission) end

---[Internal] onafterLostCluster
---
------
---@param self AWACS 
---@param From string 
---@param Event string 
---@param To string 
---@param Cluster INTEL.Cluster 
---@param Mission AUFTRAG 
---@return AWACS #self
function AWACS:onafterLostCluster(From, Event, To, Cluster, Mission) end

---[Internal] onafterLostContact
---
------
---@param self AWACS 
---@param From string 
---@param Event string 
---@param To string 
---@param Contact INTEL.Contact 
---@return AWACS #self
function AWACS:onafterLostContact(From, Event, To, Contact) end

---[Internal] onafterNewCluster
---
------
---@param self AWACS 
---@param From string 
---@param Event string 
---@param To string 
---@param Cluster INTEL.Cluster 
---@return AWACS #self
function AWACS:onafterNewCluster(From, Event, To, Cluster) end

---[Internal] onafterNewContact
---
------
---@param self AWACS 
---@param From string 
---@param Event string 
---@param To string 
---@param Contact INTEL.Contact 
---@return AWACS #self 
function AWACS:onafterNewContact(From, Event, To, Contact) end

---On after "ReAnchor".
---
------
---@param self AWACS 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param GID number Group ID to check and re-anchor if possible
---@return AWACS #self
function AWACS:onafterReAnchor(From, Event, To, GID) end

---[Internal] onafterStart
---
------
---@param self AWACS 
---@param From string 
---@param Event string 
---@param To string 
---@return AWACS #self
function AWACS:onafterStart(From, Event, To) end

---[Internal] onafterStatus
---
------
---@param self AWACS 
---@param From string 
---@param Event string 
---@param To string 
---@return AWACS #self
function AWACS:onafterStatus(From, Event, To) end

---[Internal] onafterStop
---
------
---@param self AWACS 
---@param From string 
---@param Event string 
---@param To string 
---@return AWACS #self
function AWACS:onafterStop(From, Event, To) end

---[Internal] onbeforeStart
---
------
---@param self AWACS 
---@param From string 
---@param Event string 
---@param To string 
---@return AWACS #self
function AWACS:onbeforeStart(From, Event, To) end


---@class AWACS.AnchorAssignedEntry 
---@field Angels number 
---@field ID number 
AWACS.AnchorAssignedEntry = {}


---@class AWACS.AnchorData 
---@field AnchorAssignedID FIFO FiFo of #AWACS.AnchorAssignedEntry
---@field AnchorBaseAngels number 
---@field AnchorMarker MARKER Tag for this station
---@field Anchors FIFO FiFo of available stacks
---@field StationName string 
---@field StationZone ZONE_RADIUS 
---@field StationZoneCoordinate COORDINATE 
---@field StationZoneCoordinateText string 
AWACS.AnchorData = {}


---Contact Data
---@class AWACS.ManagedContact 
---@field CID number 
---@field Cluster INTEL.Cluster 
---@field Contact INTEL.Contact 
---@field EngagementTag string 
---@field IFF string -- ID'ed or not (yet)
---@field LinkedGroup number --> GID
---@field LinkedTask number --> TID
---@field MeldCallDone boolean 
---@field MergeCallDone boolean 
---@field ReportingName string -- NATO platform name
---@field Status string - #AWACS.TaskStatus
---@field TACCallDone boolean 
---@field Target TARGET 
---@field TargetGroupNaming string -- Alpha, Charlie
AWACS.ManagedContact = {}


---Group Data
---@class AWACS.ManagedGroup 
---@field AnchorStackAngels number 
---@field AnchorStackNo number 
---@field Blocked boolean 
---@field CallSign string 
---@field ContactCID number 
---@field CurrentAuftrag number -- Auftragsnummer for AI
---@field CurrentTask number -- ManagedTask ID
---@field FlightGroup FLIGHTGROUP for AI
---@field GID number 
---@field Group GROUP 
---@field GroupName string 
---@field HasAssignedTask boolean 
---@field IsAI boolean 
---@field IsPlayer boolean 
---@field LastKnownPosition COORDINATE 
---@field LastTasking number TimeStamp
AWACS.ManagedGroup = {}


---@class AWACS.ManagedTask 
---@field AssignedGroupID number 
---@field Auftrag AUFTRAG 
---@field Cluster INTEL.Cluster 
---@field Contact INTEL.Contact 
---@field CurrentAuftrag number 
---@field IsPlayerTask boolean 
---@field IsUnassigned boolean 
---@field RequestedTimestamp number 
---@field ScreenText string Long descrition
---@field TID number 
---@field Target TARGET 
AWACS.ManagedTask = {}


---@class AWACS.MenuStructure 
---@field abort MENU_GROUP_COMMAND 
---@field basemenu MENU_GROUP 
---@field bogeydope MENU_GROUP_COMMAND 
---@field checkin MENU_GROUP_COMMAND 
---@field checkout MENU_GROUP_COMMAND 
---@field commit MENU_GROUP_COMMAND 
---@field declare MENU_GROUP_COMMAND 
---@field friendly MENU_GROUP_COMMAND 
---@field groupname string 
---@field hostile MENU_GROUP_COMMAND 
---@field judy MENU_GROUP_COMMAND 
---@field menuset boolean 
---@field neutral MENU_GROUP_COMMAND 
---@field picture MENU_GROUP_COMMAND 
---@field showtask MENU_GROUP_COMMAND 
---@field tasking MENU_GROUP 
---@field unable MENU_GROUP_COMMAND 
---@field vid MENU_GROUP 
AWACS.MenuStructure = {}


---@class AWACS.MonitoringData 
---@field AICAPCurrent number 
---@field AICAPMax number 
---@field Airwings number 
---@field AwacsShiftChange boolean 
---@field AwacsStateFG string 
---@field AwacsStateMission string 
---@field EscortsShiftChange boolean 
---@field Players number 
---@field PlayersCheckedin number 
AWACS.MonitoringData = {}


---@class AWACS.RadioEntry 
---@field FromAI  
---@field GroupID  
---@field IsGroup  
---@field IsNew  
---@field TextTTS  
---@field ToScreen  
AWACS.RadioEntry = {}


---@class AWACS.TaskDescription 
---@field ANCHOR string 
---@field IFF string 
---@field INTERCEPT string 
---@field REANCHOR string 
---@field RTB string 
---@field SWEEP string 
---@field VID string 
AWACS.TaskDescription = {}


---@class AWACS.TaskStatus 
---@field ASSIGNED string 
---@field DEAD string 
---@field EXECUTING string 
---@field FAILED string 
---@field IDLE string 
---@field REQUESTED string 
---@field SUCCESS string 
---@field UNASSIGNED string 
AWACS.TaskStatus = {}


---@class RadioEntry 
---@field Duration number 
---@field FromAI boolean 
---@field GroupID boolean 
---@field IsGroup boolean 
---@field IsNew boolean 
---@field TextScreen string 
---@field TextTTS string 
---@field ToScreen boolean 
RadioEntry = {}



