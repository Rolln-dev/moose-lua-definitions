---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Ops_Airboss.png" width="100%">
---
---**Ops** - Manages aircraft CASE X recoveries for carrier operations (X=I, II, III).
---
---The AIRBOSS class manages recoveries of human pilots and AI aircraft on aircraft carriers.
---
---**Main Features:**
---
---   * CASE I, II and III recoveries.
---   * Supports human pilots as well as AI flight groups.
---   * Automatic LSO grading including (optional) live grading while in the groove.
---   * Different skill levels from on-the-fly tips for flight students to *ziplip* for pros. Can be set for each player individually.
---   * Define recovery time windows with individual recovery cases in the same mission.
---   * Option to let the carrier steam into the wind automatically.
---   * Automatic TACAN and ICLS channel setting of carrier.
---   * Separate radio channels for LSO and Marshal transmissions.
---   * Voice over support for LSO and Marshal radio transmissions.
---   * Advanced F10 radio menu including carrier info, weather, radio frequencies, TACAN/ICLS channels, player LSO grades, marking of zones etc.
---   * Recovery tanker and refueling option via integration of Ops.RecoveryTanker class.
---   * Rescue helicopter option via Ops.RescueHelo class.
---   * Combine multiple human players to sections.
---   * Many parameters customizable by convenient user API functions.
---   * Multiple carrier support due to object oriented approach.
---   * Unlimited number of players.
---   * Persistence of player results (optional). LSO grading data is saved to csv file.
---   * Trap sheet (optional).
---   * Finite State Machine (FSM) implementation.
---
---**Supported Carriers:**
---
---   * [USS John C. Stennis](https://en.wikipedia.org/wiki/USS_John_C._Stennis) (CVN-74)
---   * [USS Theodore Roosevelt](https://en.wikipedia.org/wiki/USS_Theodore_Roosevelt_\(CVN-71\)) (CVN-71) [Super Carrier Module]
---   * [USS Abraham Lincoln](https://en.wikipedia.org/wiki/USS_Abraham_Lincoln_\(CVN-72\)) (CVN-72) [Super Carrier Module]
---   * [USS George Washington](https://en.wikipedia.org/wiki/USS_George_Washington_\(CVN-73\)) (CVN-73) [Super Carrier Module]
---   * [USS Harry S. Truman](https://en.wikipedia.org/wiki/USS_Harry_S._Truman) (CVN-75) [Super Carrier Module]
---   * [USS Forrestal](https://en.wikipedia.org/wiki/USS_Forrestal_\(CV-59\)) (CV-59) [Heatblur Carrier Module]
---   * [Essex Class](https://en.wikipedia.org/wiki/Essex-class_aircraft_carrier) (CV-11) [Magnitude 3 Carrier Module]
---   * [HMS Hermes](https://en.wikipedia.org/wiki/HMS_Hermes_\(R12\)) (R12)
---   * [HMS Invincible](https://en.wikipedia.org/wiki/HMS_Invincible_\(R05\)) (R05)
---   * [USS Tarawa](https://en.wikipedia.org/wiki/USS_Tarawa_\(LHA-1\)) (LHA-1)
---   * [USS America](https://en.wikipedia.org/wiki/USS_America_\(LHA-6\)) (LHA-6)
---   * [Juan Carlos I](https://en.wikipedia.org/wiki/Spanish_amphibious_assault_ship_Juan_Carlos_I) (L61)
---   * [HMAS Canberra](https://en.wikipedia.org/wiki/HMAS_Canberra_\(L02\)) (L02)
---
---**Supported Aircraft:**
---
---   * [F/A-18C Hornet Lot 20](https://forums.eagle.ru/forumdisplay.php?f=557) (Player & AI)
---   * [F-14A/B Tomcat](https://forums.eagle.ru/forumdisplay.php?f=395) (Player & AI)
---   * [A-4E Skyhawk Community Mod](https://forums.eagle.ru/showthread.php?t=224989) (Player & AI)
---   * [AV-8B N/A Harrier](https://forums.eagle.ru/forumdisplay.php?f=555) (Player & AI)
---   * [T-45C Goshawk](https://forum.dcs.world/topic/203816-vnao-t-45-goshawk/) (VNAO mod) (Player & AI)
---   * [FE/A-18E/F/G Superhornet](https://forum.dcs.world/topic/316971-cjs-super-hornet-community-mod-v20-official-thread/) (CJS mod) (Player & AI)
---   * [F4U-1D Corsair](https://forum.dcs.world/forum/781-f4u-1d/) (Player & AI)
---   * F/A-18C Hornet (AI)
---   * F-14A Tomcat (AI)
---   * E-2D Hawkeye (AI)
---   * S-3B Viking & tanker version (AI)
---   * [C-2A Greyhound](https://forums.eagle.ru/showthread.php?t=255641) (AI)
---
---At the moment, optimized parameters are available for the F/A-18C Hornet (Lot 20) and A-4E community mod as aircraft and the USS John C. Stennis as carrier.
---
---The AV-8B Harrier, HMS Hermes, HMS Invincible, the USS Tarawa, USS America, HMAS Canberra, and Juan Carlos I are WIP. The AV-8B harrier and the LHA's and LHD can only be used together, i.e. these ships are the only carriers the harrier is supposed to land on and
---no other fixed wing aircraft (human or AI controlled) are supposed to land on these ships. Currently only Case I is supported. Case II/III take slightly different steps from the CVN carrier.
---However, if no offset is used for the holding radial this provides a very close representation of the V/STOL Case III, allowing for an approach to over the deck and a vertical landing.
---
---Heatblur's mighty F-14B Tomcat has been added (March 13th 2019) as well. Same goes for the A version.
---
---The [DCS Supercarriers](https://www.digitalcombatsimulator.com/de/shop/modules/supercarrier/) are also supported.
---
---## Discussion
---
---If you have questions or suggestions, please visit the [MOOSE Discord](https://discord.gg/AeYAkHP) #ops-airboss channel.
---There you also find an example mission and the necessary voice over sound files. Check out the **pinned messages**.
---
---## Example Missions
---
---Example missions can be found [here](https://github.com/FlightControl-Master/MOOSE_MISSIONS/tree/master/Ops/Airboss).
---They contain the latest development Moose.lua file.
---
---## IMPORTANT
---
---Some important restrictions (of DCS) you should be aware of:
---
---   * Each player slot (client) should be in a separate group as DCS does only allow for sending messages to groups and not individual units.
---   * Players are identified by their player name. Hence, ensure that no two player have the same name, e.g. "New Callsign", as this will lead to unexpected results.
---   * The modex (tail number) of an aircraft should **not** be changed dynamically in the mission by a player. Unfortunately, there is no way to get this information via scripting API functions.
---   * The A-4E-C mod needs *easy comms* activated to interact with the F10 radio menu.
---
---## Youtube Videos
---
---### AIRBOSS videos:
---
---   * [[MOOSE] Airboss - Groove Testing (WIP)](https://www.youtube.com/watch?v=94KHQxxX3UI)
---   * [[MOOSE] Airboss - Groove Test A-4E Community Mod](https://www.youtube.com/watch?v=ZbjD7FHiaHo)
---   * [[MOOSE] Airboss - Groove Test: On-the-fly LSO Grading](https://www.youtube.com/watch?v=Xgs1hwDcPyM)
---   * [[MOOSE] Airboss - Carrier Auto Steam Into Wind](https://www.youtube.com/watch?v=IsU8dYgsp90)
---   * [[MOOSE] Airboss - CASE I Walkthrough in the F/A-18C by TG](https://www.youtube.com/watch?v=o1UrP4Q6PMM)
---   * [[MOOSE] Airboss - New LSO/Marshal Voice Overs by Raynor](https://www.youtube.com/watch?v=_Suo68bRu8k)
---   * [[MOOSE] Airboss - CASE I, "Until We Go Down" featuring the F-14B by Pikes](https://www.youtube.com/watch?v=ojgHDSw3Doc)
---   * [[MOOSE] Airboss - Skipper Menu](https://youtu.be/awnecCxRoNQ)
---
---### Jabbers Case I and III Recovery Tutorials:
---
---   * [DCS World - F/A-18 - Case I Carrier Recovery Tutorial](https://www.youtube.com/watch?v=lm-M3VUy-_I)
---   * [DCS World - Case I Recovery Tutorial - Followup](https://www.youtube.com/watch?v=cW5R32Q6xC8)
---   * [DCS World - CASE III Recovery Tutorial](https://www.youtube.com/watch?v=Lnfug5CVAvo)
---
---### Wags DCS Hornet Videos:
---
---   * [DCS: F/A-18C Hornet - Episode 9: CASE I Carrier Landing](https://www.youtube.com/watch?v=TuigBLhtAH8)
---   * [DCS: F/A-18C Hornet â€“ Episode 16: CASE III Introduction](https://www.youtube.com/watch?v=DvlMHnLjbDQ)
---   * [DCS: F/A-18C Hornet Case I Carrier Landing Training Lesson Recording](https://www.youtube.com/watch?v=D33uM9q4xgA)
---
---### AV-8B Harrier and V/STOL Operations:
---
---   * [Harrier Ship Landing Mission with Auto LSO!](https://www.youtube.com/watch?v=lqmVvpunk2c)
---   * [Updated Airboss V/STOL Features USS Tarawa](https://youtu.be/K7I4pU6j718)
---   * [Harrier Practice pattern USS America](https://youtu.be/99NigITYmcI)
---   * [Harrier CASE III TACAN Approach USS Tarawa](https://www.youtube.com/watch?v=bTgJXZ9Mhdc&t=1s)
---   * [Harrier CASE III TACAN Approach USS Tarawa](https://www.youtube.com/watch?v=wWHag5WpNZ0)
---
---===
---
---### Author: **funkyfranky** LHA and LHD V/STOL additions by **Pene**
---### Special Thanks To **Bankler**
---For his great [Recovery Trainer](https://forums.eagle.ru/showthread.php?t=221412) mission and script!
---His work was the initial inspiration for this class. Also note that this implementation uses some routines for determining the player position in Case I recoveries he developed.
---Bankler was kind enough to allow me to add this to the class - thanks again!
---Be the boss!
---
---===
---
---![Banner Image](..\Presentations\AIRBOSS\Airboss_Main.png)
---
---# The AIRBOSS Concept
---
---On a carrier, the AIRBOSS is guy who is really in charge - don't mess with him!
---
---# Recovery Cases
---
---The AIRBOSS class supports all three commonly used recovery cases, i.e.
---
---   * **CASE I** during daytime and good weather (ceiling > 3000 ft, visibility > 5 NM),
---   * **CASE II** during daytime but poor visibility conditions (ceiling > 1000 ft, visibility > 5NM),
---   * **CASE III** when below Case II conditions and during nighttime (ceiling < 1000 ft, visibility < 5 NM).
---
---That being said, this script allows you to use any of the three cases to be used at any time. Or, in other words, *you* need to specify when which case is safe and appropriate.
---
---This is a lot of responsibility. *You* are the boss, but *you* need to make the right decisions or things will go terribly wrong!
---
---Recovery windows can be set up via the #AIRBOSS.AddRecoveryWindow function as explained below. With this it is possible to seamlessly (within reason!) switch recovery cases in the same mission.
---
---## CASE I
---
---As mentioned before, Case I recovery is the standard procedure during daytime and good visibility conditions.
---
---### Holding Pattern
---
---![Banner Image](..\Presentations\AIRBOSS\Airboss_Case1_Holding.png)
---
---The graphic depicts a the standard holding pattern during a Case I recovery. Incoming aircraft enter the holding pattern, which is a counter clockwise turn with a
---diameter of 5 NM, at their assigned altitude. The holding altitude of the first stack is 2000 ft. The interval between stacks is 1000 ft.
---
---Once a recovery window opens, the aircraft of the lowest stack commence their landing approach and the rest of the Marshal stack collapses, i.e. aircraft switch from
---their current stack to the next lower stack.
---
---The flight that transitions form the holding pattern to the landing approach, it should leave the Marshal stack at the 3 position and make a left hand turn to the *Initial*
---position, which is 3 NM astern of the boat. Note that you need to be below 1300 feet to be registered in the initial zone.
---The altitude can be set via the function #AIRBOSS.SetInitialMaxAlt(*altitude*) function.
---As described below, the initial zone can be smoked or flared via the AIRBOSS F10 Help radio menu.
---
---### Landing Pattern
---
---![Banner Image](..\Presentations\AIRBOSS\Airboss_Case1_Landing.png)
---
---Once the aircraft reaches the Initial, the landing pattern begins. The important steps of the pattern are shown in the image above.
---The AV-8B Harrier pattern is very similar, the only differences are as there is no angled deck there is no wake check. from the ninety you wil fly a straight approach offset 26 ft to port (left) of the tram line.
---The aim is to arrive abeam the landing spot in a stable hover at 120 ft with forward speed matched to the boat. From there the LSO will call "cleared to land". You then level cross to the tram line at the designated landing spot at land vertcally. When you stabalise over the landing spot LSO will call Stabalise to indicate you are centered at the correct spot.
---
---## CASE III
---
---![Banner Image](..\Presentations\AIRBOSS\Airboss_Case3.png)
---
---A Case III recovery is conducted during nighttime or when the visibility is below CASE II minima during the day. The holding position and the landing pattern are rather different from a Case I recovery as can be seen in the image above.
---
---The first holding zone starts 21 NM astern the carrier at angels 6. The separation between the stacks is 1000 ft just like in Case I. However, the distance to the boat
---increases by 1 NM with each stack. The general form can be written as D=15+6+(N-1), where D is the distance to the boat in NM and N the number of the stack starting at N=1.
---
---Once the aircraft of the lowest stack is allowed to commence to the landing pattern, it starts a descent at 4000 ft/min until it reaches the "*Platform*" at 5000 ft and
---~19 NM DME. From there a shallower descent at 2000 ft/min should be performed. At an altitude of 1200 ft the aircraft should level out and "*Dirty Up*" (gear, flaps & hook down).
---
---At 3 NM distance to the carrier, the aircraft should intercept the 3.5 degrees glideslope at the "*Bullseye*". From there the pilot should "follow the needles" of the ICLS.
---
---## CASE II
---
---![Banner Image](..\Presentations\AIRBOSS\Airboss_Case2.png)
---
---Case II is the common recovery procedure at daytime if visibility conditions are poor. It can be viewed as hybrid between Case I and III.
---The holding pattern is very similar to that of the Case III recovery with the difference the the radial is the inverse of the BRC instead of the FB.
---From the holding zone aircraft are follow the Case III path until they reach the Initial position 3 NM astern the boat. From there a standard Case I recovery procedure is
---in place.
---
---Note that the image depicts the case, where the holding zone has an angle offset of 30 degrees with respect to the BRC. This is optional. Commonly used offset angels
---are 0 (no offset), +-15 or +-30 degrees. The AIRBOSS class supports all these scenarios which are used during Case II and III recoveries.
---
---===
---
---# The F10 Radio Menu
---
---The F10 radio menu can be used to post requests to Marshal but also provides information about the player and carrier status. Additionally, helper functions
---can be called.
---
---![Banner Image](..\Presentations\AIRBOSS\Airboss_MenuMain.png)
---
---By default, the script creates a submenu "Airboss" in the "F10 Other ..." menu and each #AIRBOSS carrier gets its own submenu.
---If you intend to have only one carrier, you can simplify the menu structure using the #AIRBOSS.SetMenuSingleCarrier function, which will create all carrier specific menu entries directly
---in the "Airboss" submenu. (Needless to say, that if you enable this and define multiple carriers, the menu structure will get completely screwed up.)
---
---## Root Menu
---
---![Banner Image](..\Presentations\AIRBOSS\Airboss_MenuRoot.png)
---
---The general structure
---
---   * **F1 Help...**  (Help submenu, see below.)
---   * **F2 Kneeboard...** (Kneeboard submenu, see below. Carrier information, weather report, player status.)
---   * **F3 Request Marshal**
---   * **F4 Request Commence**
---   * **F5 Request Refueling**
---   * **F6 Spinning**
---   * **F7 Emergency Landing**
---   * **F8 [Reset My Status]**
---
---### Request Marshal
---
---This radio command can be used to request a stack in the holding pattern from Marshal. Necessary conditions are that the flight is inside the Carrier Controlled Area (CCA)
---(see #AIRBOSS.SetCarrierControlledArea).
---
---Marshal will assign an individual stack for each player group depending on the current or next open recovery case window.
---If multiple players have registered as a section, the section lead will be assigned a stack and is responsible to guide his section to the assigned holding position.
---
---### Request Commence
---
---This command can be used to request commencing from the marshal stack to the landing pattern. Necessary condition is that the player is in the lowest marshal stack
---and that the number of aircraft in the landing pattern is smaller than four (or the number set by the mission designer).
---
---![Banner Image](..\Presentations\AIRBOSS\Airboss_Case1Pattern.png)
---
---The image displays the standard Case I Marshal pattern recovery. Pilots are supposed to fly a clockwise circle and descent between the **3** and **1** positions.
---
---Commence should be performed at around the **3** position. If the pilot is in the lowest Marshal stack, and flies through this area, he is automatically cleared for the
---landing pattern. In other words, there is no need for the "Request Commence" radio command. The zone can be marked via smoke or flared using the player's F10 radio menu.
---
---A player can also request commencing if he is not registered in a marshal stack yet. If the pattern is free, Marshal will allow him to directly enter the landing pattern.
---However, this is only possible when the Airboss has a nice day - see #AIRBOSS.SetAirbossNiceGuy.
---
---### Request Refueling
---
---If a recovery tanker has been set up via the #AIRBOSS.SetRecoveryTanker, the player can request refueling at any time. If currently in the marshal stack, the stack above will collapse.
---The player will be informed if the tanker is currently busy or going RTB to refuel itself at its home base. Once the re-fueling is complete, the player has to re-register to the marshal stack.
---
---### Spinning
---
---If the pattern is full, players can go into the spinning pattern. This step is only allowed, if the player is in the pattern and his next step
---is initial, break entry, early/late break. At this point, the player should climb to 1200 ft a fly on the port side of the boat to go back to the initial again.
---
---If a player is in the spin pattern, flights in the Marshal queue should hold their altitude and are not allowed into the pattern until the spinning aircraft
---proceeds.
---
---Once the player reaches a point 100 meters behind the boat and at least 1 NM port, his step is set to "Initial" and he can resume the normal pattern approach.
---
---If necessary, the player can call "Spinning" again when in the above mentioned steps.
---
---### Emergency Landing
---
---Request an emergency landing, i.e. bypass all pattern steps and go directly to the final approach.
---
---All section members are supposed to follow. Player (or section lead) is removed from all other queues and automatically added to the landing pattern queue.
---
---If this command is called while the player is currently on the carrier, he will be put in the bolter pattern. So the next expected step after take of
---is the abeam position. This allows for quick landing training exercises without having to go through the whole pattern.
---
---The mission designer can forbid this option my setting #AIRBOSS.SetEmergencyLandings(false) in the script.
---
---### [Reset My Status]
---
---This will reset the current player status. If player is currently in a marshal stack, he will be removed from the marshal queue and the stack above will collapse.
---The player needs to re-register later if desired. If player is currently in the landing pattern, he will be removed from the pattern queue.
---
---## Help Menu
---
---![Banner Image](..\Presentations\AIRBOSS\Airboss_MenuHelp.png)
---
---This menu provides commands to help the player.
---
---### Mark Zones Submenu
---
---![Banner Image](..\Presentations\AIRBOSS\Airboss_MenuMarkZones.png)
---
---These commands can be used to mark marshal or landing pattern zones.
---
---   * **Smoke Pattern Zones** Smoke is used to mark the landing pattern zone of the player depending on his recovery case.
---   For Case I this is the initial zone. For Case II/III and three these are the Platform, Arc turn, Dirty Up, Bullseye/Initial zones as well as the approach corridor.
---   * **Flare Pattern Zones** Similar to smoke but uses flares to mark the pattern zones.
---   * **Smoke Marshal Zone** This smokes the surrounding area of the currently assigned Marshal zone of the player. Player has to be registered in Marshal queue.
---   * **Flare Marshal Zone** Similar to smoke but uses flares to mark the Marshal zone.
---
---Note that the smoke lasts ~5 minutes but the zones are moving along with the carrier. So after some time, the smoke gives shows you a picture of the past.
---
---![Banner Image](..\Presentations\AIRBOSS\Airboss_Case3_FlarePattern.png)
---
---### Skill Level Submenu
---
---![Banner Image](..\Presentations\AIRBOSS\Airboss_MenuSkill.png)
---
---The player can choose between three skill or difficulty levels.
---
---   * **Flight Student**: The player receives tips at certain stages of the pattern, e.g. if he is at the right altitude, speed, etc.
---   * **Naval Aviator**: Less tips are show. Player should be familiar with the procedures and its aircraft parameters.
---   * **TOPGUN Graduate**: Only very few information is provided to the player. This is for the pros.
---   * **Hints On/Off**: Toggle displaying hints.
---
---### My Status
---
---![Banner Image](..\Presentations\AIRBOSS\Airboss_MenuMyStatus.png)
---
---This command provides information about the current player status. For example, his current step in the pattern.
---
---### Attitude Monitor
---
---![Banner Image](..\Presentations\AIRBOSS\Airboss_MenuAttitudeMonitor.png)
---
---This command displays the current aircraft attitude of the player aircraft in short intervals as message on the screen.
---It provides information about current pitch, roll, yaw, orientation of the plane with respect to the carrier's orientation (*Gamma*) etc.
---
---If you are in the groove, current lineup and glideslope errors are displayed and you get an on-the-fly LSO grade.
---
---### LSO Radio Check
---
---LSO will transmit a short message on his radio frequency. See #AIRBOSS.SetLSORadio. Note that in the A-4E you will not hear the message unless you are in the pattern.
---
---### Marshal Radio Check
---
---Marshal will transmit a short message on his radio frequency. See #AIRBOSS.SetMarshalRadio.
---
---### Subtitles On/Off
---
---This command toggles the display of radio message subtitles if no radio relay unit is used. By default subtitles are on.
---Note that subtitles for radio messages which do not have a complete voice over are always displayed.
---
---### Trapsheet On/Off
---
---Each player can activated or deactivate the recording of his flight data (AoA, glideslope, lineup, etc.) during his landing approaches.
---Note that this feature also has to be enabled by the mission designer.
---
---## Kneeboard Menu
---
---![Banner Image](..\Presentations\AIRBOSS\Airboss_MenuKneeboard.png)
---
---The Kneeboard menu provides information about the carrier, weather and player results.
---
---### Results Submenu
---
---![Banner Image](..\Presentations\AIRBOSS\Airboss_MenuResults.png)
---
---Here you find your LSO grading results as well as scores of other players.
---
---   * **Greenie Board** lists average scores of all players obtained during landing approaches.
---   * **My LSO Grades** lists all grades the player has received for his approaches in this mission.
---   * **Last Debrief** shows the detailed debriefing of the player's last approach.
---
---### Carrier Info
---
---![Banner Image](..\Presentations\AIRBOSS\Airboss_MenuCarrierInfo.png)
---
---Information about the current carrier status is displayed. This includes current BRC, FB, LSO and Marshal frequencies, list of next recovery windows.
---
---### Weather Report
---
---![Banner Image](..\Presentations\AIRBOSS\Airboss_MenuWeatherReport.png)
---
---Displays information about the current weather at the carrier such as QFE, wind and temperature.
---
---For missions using static weather, more information such as cloud base, thickness, precipitation, visibility distance, fog and dust are displayed.
---If your mission uses dynamic weather, you can disable this output via the #AIRBOSS.SetStaticWeather(**false**) function.
---
---### Set Section
---
---With this command, you can define a section of human flights. The player who issues the command becomes the section lead and all other human players
---within a radius of 100 meters become members of the section.
---
---The responsibilities of the section leader are:
---
---   * To request Marshal. The section members are not allowed to do this and have to follow the lead to his assigned stack.
---   * To lead the right way to the pattern if the flight is allowed to commence.
---   * The lead is also the only one who can request commence if the flight wants to bypass the Marshal stack.
---
---Each time the command is issued by the lead, the complete section is set up from scratch. Members which are not inside the 100 m radius any more are
---removed and/or new members which are now in range are added.
---
---If a section member issues this command, it is removed from the section of his lead. All flights which are not yet in another section will become members.
---
---The default maximum size of a section is two human players. This can be adjusted by the #AIRBOSS.SetMaxSectionSize(*size*) function. The maximum allowed size
---is four.
---
---### Marshal Queue
---
---![Banner Image](..\Presentations\AIRBOSS\Airboss_MenuMarshalQueue.png)
---
---Lists all flights currently in the Marshal queue including their assigned stack, recovery case and Charlie time estimate.
---By default, the number of available Case I stacks is three, i.e. at angels 2, 3 and 4. Usually, the recovery thanker orbits at angels 6.
---The number of available stacks can be set by the #AIRBOSS.SetMaxMarshalStack function.
---
---The default number of human players per stack is two. This can be set via the #AIRBOSS.SetMaxFlightsPerStack function but has to be between one and four.
---
---Due to technical reasons, each AI group always gets its own stack. DCS does not allow to control the AI in a manner that more than one group per stack would make sense unfortunately.
---
---### Pattern Queue
---
---![Banner Image](..\Presentations\AIRBOSS\Airboss_MenuPatternQueue.png)
---
---Lists all flights currently in the landing pattern queue showing the time since they entered the pattern.
---By default, a maximum of four flights is allowed to enter the pattern. This can be set via the #AIRBOSS.SetMaxLandingPattern function.
---
---### Waiting Queue
---
---Lists all flights currently waiting for a free Case I Marshal stack. Note, stacks are limited only for Case I recovery ops but not for Case II or III.
---If the carrier is switches recovery ops form Case I to Case II or III, all waiting flights will be assigned a stack.
---
---# Landing Signal Officer (LSO)
---
---The LSO will first contact you on his radio channel when you are at the the abeam position (Case I) with the phrase "Paddles, contact.".
---Once you are in the groove the LSO will ask you to "Call the ball." and then acknowledge your ball call by "Roger Ball."
---
---During the groove the LSO will give you advice if you deviate from the correct landing path. These advices will be given when you are
---
---   * too low or too high with respect to the glideslope,
---   * too fast or too slow with respect to the optimal AoA,
---   * too far left or too far right with respect to the lineup of the (angled) runway.
---
---## LSO Grading
---
---LSO grading starts when the player enters the groove. The flight path and aircraft attitude is evaluated at certain steps (distances measured from rundown):
---
---   * **X** At the Start (0.75 NM = 1390 m).
---   * **IM** In the Middle (0.5 NM = 926 m), middle one third of the glideslope.
---   * **IC** In Close (0.25 NM = 463 m), last one third of the glideslope.
---   * **AR** At the Ramp (0.027 NM = 50 m).
---   * **IW** In the Wires (at the landing position).
---
---Grading at each step includes the above calls, i.e.
---
---   * **L**ined **U**p **L**eft or **R**ight: LUL, LUR
---   * Too **H**igh or too **LO**w: H, LO
---   * Too **F**ast or too **SLO**w: F, SLO
---   * **O**ver**S**hoot: OS, only referenced during **X**
---   * **Fly through** glideslope **down** or **up**: \\ , /, advisory only
---   * **D**rift **L**eft or **R**ight:DL, DR, advisory only
---   * **A**ngled **A**pproach: Angled approach (wings level and LUL): AA, advisory only
---
---Each grading, x, is subdivided by
---
---   * (x): parenthesis, indicating "a little" for a minor deviation and
---   * \_x\_: underline, indicating "a lot" for major deviations.
---
---The position at the landing event is analyzed and the corresponding trapped wire calculated. If no wire was caught, the LSO will give the bolter call.
---
---If a player is significantly off from the ideal parameters from IC to AR, the LSO will wave the player off. Thresholds for wave off are
---
---   * Line up error > 3.0 degrees left or right and/or
---   * Glideslope error < -1.2 degrees or > 1.8 degrees and/or
---   * AOA depending on aircraft type and only applied if skill level is "TOPGUN graduate".
---
---![Banner Image](..\Presentations\AIRBOSS\Airboss_LSOPlatcam.png)
---
---Line up and glideslope error thresholds were tested extensively using [VFA-113 Stingers LSO Mod](https://forums.eagle.ru/showthread.php?t=211557),
---if the aircraft is outside the red box. In the picture above, **blue** numbers denote the line up thresholds while the **blacks** refer to the glideslope.
---
---A wave off is called, when the aircraft is outside the red rectangle. The measurement stops already ~50 m before the rundown, since the error in the calculation
---increases the closer the aircraft gets to the origin/reference point.
---
---The optimal glideslope is assumed to be 3.5 degrees leading to a touch down point between the second and third wire.
---The height of the carrier deck and the exact wire locations are taken into account in the calculations.
---
---## Pattern Waveoff
---
---The player's aircraft position is evaluated at certain critical locations in the landing pattern. If the player is far off from the ideal approach, the LSO will
---issue a pattern wave off. Currently, this is only implemented for Case I recoveries and the Case I part in the Case II recovery, i.e.
---
---   * Break Entry
---   * Early Break
---   * Late Break
---   * Abeam
---   * Ninety
---   * Wake
---   * Groove
---
---At these points it is also checked if a player comes too close to another aircraft ahead of him in the pattern.
---
---## Grading Points
---
---Currently grades are given by as follows
---
---   * 5.0 Points **\_OK\_**: "Okay underline", given only for a perfect pass, i.e. when no deviations at all were observed by the LSO. The unicorn!
---   * 4.0 Points **OK**: "Okay pass" when only minor () deviations happened.
---   * 3.0 Points **(OK)**: "Fair pass", when only "normal" deviations were detected.
---   * 2.0 Points **--**: "No grade", for larger deviations.
---
---Furthermore, we have the cases:
---
---   * 2.5 Points **B**: "Bolter", when the player landed but did not catch a wire.
---   * 2.0 Points **WOP**: "Pattern Wave-Off", when pilot was far away from where he should be in the pattern.
---   * 2.0 Points **OWO**: "Own Wave-Off**, when pilot flies past the deck without touching it.
---   * 1.0 Points **WO**: "Technique Wave-Off": Player got waved off in the final parts of the groove.
---   * 1.0 Points **LIG**: "Long In the Groove", when pilot extents the downwind leg too far and screws up the timing for the following aircraft.
---   * 0.0 Points **CUT**: "Cut pass", when player was waved off but landed anyway. In addition if a V/STOL lands without having been Cleared to Land.
---
---## Foul Deck Waveoff
---
---A foul deck waveoff is called by the LSO if an aircraft is detected within the landing area when an approaching aircraft is at position IM-IC during Case I/II operations,
---or with an aircraft approaching the 3/4 NM during Case III operations.
---
---The approaching aircraft will be notified via LSO radio comms and is supposed to overfly the landing area to enter the Bolter pattern. **This pass is not graded**.
---
---===
---
---# Scripting
---
---Writing a basic script is easy and can be done in two lines.
---
---    local airbossStennis=AIRBOSS:New("USS Stennis", "Stennis")
---    airbossStennis:Start()
---
---The **first line** creates and AIRBOSS object via the #AIRBOSS.New(*carriername*, *alias*) constructor. The first parameter *carriername* is name of the carrier unit as
---defined in the mission editor. The second parameter *alias* is optional. This name will, e.g., be used for the F10 radio menu entry. If not given, the alias is identical
---to the *carriername* of the first parameter.
---
---This simple script initializes a lot of parameters with default values:
---
---   * TACAN channel is set to 74X, see #AIRBOSS.SetTACAN,
---   * ICSL channel is set to 1, see #AIRBOSS.SetICLS,
---   * LSO radio is set to 264 MHz FM, see #AIRBOSS.SetLSORadio,
---   * Marshal radio is set to 305 MHz FM, see #AIRBOSS.SetMarshalRadio,
---   * Default recovery case is set to 1, see #AIRBOSS.SetRecoveryCase,
---   * Carrier Controlled Area (CCA) is set to 50 NM, see #AIRBOSS.SetCarrierControlledArea,
---   * Default player skill "Flight Student" (easy), see #AIRBOSS.SetDefaultPlayerSkill,
---   * Once the carrier reaches its final waypoint, it will restart its route, see #AIRBOSS.SetPatrolAdInfinitum.
---
---The **second line** starts the AIRBOSS class. If you set options this should happen after the #AIRBOSS.New and before #AIRBOSS.Start command.
---
---However, good mission planning involves also planning when aircraft are supposed to be launched or recovered. The definition of *case specific* recovery ops within the same mission is described in
---the next section.
---
---## Recovery Windows
---
---Recovery of aircraft is only allowed during defined time slots. You can define these slots via the #AIRBOSS.AddRecoveryWindow(*start*, *stop*, *case*, *holdingoffset*) function.
---The parameters are:
---
---  * *start*: The start time as a string. For example "8:00" for a window opening at 8 am. Or "13:30+1" for half past one on the next day. Default (nil) is ASAP.
---  * *stop*: Time when the window closes as a string. Same format as *start*. Default is 90 minutes after start time.
---  * *case*: The recovery case during that window (1, 2 or 3). Default 1.
---  * *holdingoffset*: Holding offset angle in degrees. Only for Case II or III recoveries. Default 0 deg. Common +-15 deg or +-30 deg.
---
---If recovery is closed, AI flights will be send to marshal stacks and orbit there until the next window opens.
---Players can request marshal via the F10 menu and will also be given a marshal stack. Currently, human players can request commence via the F10 radio regardless of
---whether a window is open or not and will be allowed to enter the pattern (if not already full). This will probably change in the future.
---
---At the moment there is no automatic recovery case set depending on weather or daytime. So it is the AIRBOSS (i.e. you as mission designer) who needs to make that decision.
---It is probably a good idea to synchronize the timing with the waypoints of the carrier. For example, setting up the waypoints such that the carrier
---already has turning into the wind, when a recovery window opens.
---
---The code for setting up multiple recovery windows could look like this
---    local airbossStennis=AIRBOSS:New("USS Stennis", "Stennis")
---    airbossStennis:AddRecoveryWindow("8:30", "9:30", 1)
---    airbossStennis:AddRecoveryWindow("12:00", "13:15", 2, 15)
---    airbossStennis:AddRecoveryWindow("23:30", "00:30+1", 3, -30)
---    airbossStennis:Start()
---
---This will open a Case I recovery window from 8:30 to 9:30. Then a Case II recovery from 12:00 to 13:15, where the holing offset is +15 degrees wrt BRC.
---Finally, a Case III window opens 23:30 on the day the mission starts and closes 0:30 on the following day. The holding offset is -30 degrees wrt FB.
---
---Note that incoming flights will be assigned a holding pattern for the next opening window case if no window is open at the moment. So in the above example,
---all flights incoming after 13:15 will be assigned to a Case III marshal stack. Therefore, you should make sure that no flights are incoming long before the
---next window opens or adjust the recovery planning accordingly.
---
---The following example shows how you set up a recovery window for the next week:
---
---    for i=0,7 do
---       airbossStennis:AddRecoveryWindow(string.format("08:05:00+%d", i), string.format("08:50:00+%d", i))
---    end
---
---### Turning into the Wind
---
---For each recovery window, you can define if the carrier should automatically turn into the wind. This is done by passing one or two additional arguments to the #AIRBOSS.AddRecoveryWindow function:
---
---    airbossStennis:AddRecoveryWindow("8:30", "9:30", 1, nil, true, 20)
---
---Setting the fifth parameter to *true* enables the automatic turning into the wind. The sixth parameter (here 20) specifies the speed in knots the carrier will go so that to total wind above the deck
---corresponds to this wind speed. For example, if the is blowing with 5 knots, the carrier will go 15 knots so that the total velocity adds up to the specified 20 knots for the pilot.
---
---The carrier will steam into the wind for as long as the recovery window is open. The distance up to which possible collisions are detected can be set by the #AIRBOSS.SetCollisionDistance function.
---
---However, the AIRBOSS scans the type of the surface up to 5 NM in the direction of movement of the carrier. If he detects anything but deep water, he will stop the current course and head back to
---the point where he initially turned into the wind.
---
---The same holds true after the recovery window closes. The carrier will head back to the place where he left its assigned route and resume the path to the next waypoint defined in the mission editor.
---
---Note that the carrier will only head into the wind, if the wind direction is different by more than 5° from the current heading of the carrier (the angled runway, if any, fis taken into account here).
---
---===
---
---# Persistence of Player Results
---
---LSO grades of players can be saved to disk and later reloaded when a new mission is started.
---
---## Prerequisites
---
---**Important** By default, DCS does not allow for writing data to files. Therefore, one first has to comment out the line "sanitizeModule('io')" and "sanitizeModule('lfs')", i.e.
---
---    do
---      sanitizeModule('os')
---      --sanitizeModule('io')    -- required for saving files
---      --sanitizeModule('lfs')   -- optional for setting the default path to your "Saved Games\DCS" folder
---      require = nil
---      loadlib = nil
---    end
---
---in the file "MissionScripting.lua", which is located in the subdirectory "Scripts" of your DCS installation root directory.
---
---**WARNING** Desanitizing the "io" and "lfs" modules makes your machine or server vulnerable to attacks from the outside! Use this at your own risk.
---
---## Save Results
---
---Saving asset data to file is achieved by the #AIRBOSS.Save(*path*, *filename*) function.
---
---The parameter *path* specifies the path on the file system where the
---player grades are saved. If you do not specify a path, the file is saved your the DCS installation root directory if the **lfs** module is *not* desanizied or
---your "Saved Games\\DCS" folder in case you did desanitize the **lfs** module.
---
---The parameter *filename* is optional and defines the name of the saved file. By default this is automatically created from the AIRBOSS carrier name/alias, i.e.
---"Airboss-USS Stennis_LSOgrades.csv", if the alias is "USS Stennis".
---
---In the easiest case, you desanitize the **io** and **lfs** modules and just add the line
---
---    airbossStennis:Save()
---
---If you want to specify an explicit path you can do this by
---
---    airbossStennis:Save("D:\\My Airboss Data\\")
---
---This will save all player grades to in "D:\\My Airboss Data\\Airboss-USS Stennis_LSOgrades.csv".
---
---### Automatic Saving
---
---The player grades can be saved automatically after each graded player pass via the #AIRBOSS.SetAutoSave(*path*, *filename*) function. Again the parameters *path* and *filename* are optional.
---In the simplest case, you desanitize the **lfs** module and just add
---
---    airbossStennis:SetAutoSave()
---
---Note that the the stats are saved after the *final* grade has been given, i.e. the player has landed on the carrier. After intermediate results such as bolters or waveoffs the stats are not automatically saved.
---
---In case you want to specify an explicit path, you can write
---
---    airbossStennis:SetAutoSave("D:\\My Airboss Data\\")
---
---## Results Output
---
---![Banner Image](..\Presentations\AIRBOSS\Airboss_PersistenceResultsTable.png)
---
---The results file is stored as comma separated file. The columns are
---
---   * *Name*: The player name.
---   * *Pass*: A running number counting the passes of the player
---   * *Points Final*: The final points (i.e. when the player has landed). This is the average over all previous bolters or waveoffs, if any.
---   * *Points Pass*: The points of each pass including bolters and waveoffs.
---   * *Grade*: LSO grade.
---   * *Details*: Detailed analysis of deviations within the groove.
---   * *Wire*: Trapped wire, if any.
---   * *Tgroove*: Time in the groove in seconds (not applicable during Case III).
---   * *Case*: The recovery case operations in progress during the pass.
---   * *Wind*: Wind on deck in knots during approach.
---   * *Modex*: Tail number of the player.
---   * *Airframe*: Aircraft type used in the recovery.
---   * *Carrier Type*: Type name of the carrier.
---   * *Carrier Name*: Name/alias of the carrier.
---   * *Theatre*: DCS map.
---   * *Mission Time*: Mission time at the end of the approach.
---   * *Mission Date*: Mission date in yyyy/mm/dd format.
---   * *OS Date*: Real life date from os.date(). Needs **os** to be desanitized.
---
---## Load Results
---
---Loading player grades from file is achieved by the #AIRBOSS.Load(*path*, *filename*) function. The parameter *path* specifies the path on the file system where the
---data is loaded from. If you do not specify a path, the file is loaded from your the DCS installation root directory or, if **lfs** was desanitized from you "Saved Games\DCS" directory.
---The parameter *filename* is optional and defines the name of the file to load. By default this is automatically generated from the AIBOSS carrier name/alias, for example
---"Airboss-USS Stennis_LSOgrades.csv".
---
---Note that the AIRBOSS FSM **must not be started** in order to load the data. In other words, loading should happen **after** the
---#AIRBOSS.New command is specified in the code but **before** the #AIRBOSS.Start command is given.
---
---The easiest was to load player results is
---
---    airbossStennis:New("USS Stennis")
---    airbossStennis:Load()
---    airbossStennis:SetAutoSave()
---    -- Additional specification of parameters such as recovery windows etc, if required.
---    airbossStennis:Start()
---
---This sequence loads all available player grades from the default file and automatically saved them when a player received a (final) grade. Again, if **lfs** was desanitized, the files are save to and loaded
---from the "Saved Games\DCS" directory. If **lfs** was *not* desanitized, the DCS root installation folder is the default path.
---
---# Trap Sheet
---
---Important aircraft attitude parameters during the Groove can be saved to file for later analysis. This also requires the **io** and optionally **lfs** modules to be desanitized.
---
---In the script you have to add the #AIRBOSS.SetTrapSheet(*path*) function to activate this feature.
---
---![Banner Image](..\Presentations\AIRBOSS\Airboss_TrapSheetTable.png)
---
---Data the is written to a file in csv format and contains the following information:
---
---   * *Time*: time in seconds since start.
---   * *Rho*: distance from rundown to player aircraft in NM.
---   * *X*: distance parallel to the carrier in meters.
---   * *Z*: distance perpendicular to the carrier in meters.
---   * *Alt*: altitude of player aircraft in feet.
---   * *AoA*: angle of attack in degrees.
---   * *GSE*: glideslope error in degrees.
---   * *LUE*: lineup error in degrees.
---   * *Vtot*: total velocity of player aircraft in knots.
---   * *Vy*: vertical (descent) velocity in ft/min.
---   * *Gamma*: angle between vector of aircraft nose and vector point in the direction of the carrier runway in degrees.
---   * *Pitch*: pitch angle of player aircraft in degrees.
---   * *Roll*: roll angle of player aircraft in degrees.
---   * *Yaw*: yaw angle of player aircraft in degrees.
---   * *Step*: Step in the groove.
---   * *Grade*: Current LSO grade.
---   * *Points*: Current points for the pass.
---   * *Details*: Detailed grading analysis.
---
---## Lineup Error
---
---![Banner Image](..\Presentations\AIRBOSS\Airboss_TrapSheetLUE.png)
---
---The graph displays the lineup error (LUE) as a function of the distance to the carrier.
---
---The pilot approaches the carrier from the port side, LUE>0°, at a distance of ~1 NM.
---At the beginning of the groove (X), he significantly overshoots to the starboard side (LUE<5°).
---In the middle (IM), he performs good corrections and smoothly reduces the lineup error.
---Finally, at a distance of ~0.3 NM (IC) he has corrected his lineup with the runway to a reasonable level, |LUE|<0.5°.
---
---## Glideslope Error
---
---![Banner Image](..\Presentations\AIRBOSS\Airboss_TrapSheetGLE.png)
---
---The graph displays the glideslope error (GSE) as a function of the distance to the carrier.
---
---In this case the pilot already enters the groove (X) below the optimal glideslope. He is not able to correct his height in the IM part and
---stays significantly too low. In close, he performs a harsh correction to gain altitude and ends up even slightly too high (GSE>0.5°).
---At his point further corrections are necessary.
---
---## Angle of Attack
---
---![Banner Image](..\Presentations\AIRBOSS\Airboss_TrapSheetAoA.png)
---
---The graph displays the angle of attack (AoA) as a function of the distance to the carrier.
---
---The pilot starts off being on speed after the ball call. Then he get way to fast troughout the most part of the groove. He manages to correct
---this somewhat short before touchdown.
---
---===
---
---# Sound Files
---
---An important aspect of the AIRBOSS is that it uses voice overs for greater immersion. The necessary sound files can be obtained from the
---MOOSE Discord in the [#ops-airboss](https://discordapp.com/channels/378590350614462464/527363141185830915) channel. Check out the **pinned messages**.
---
---However, including sound files into a new mission is tedious as these usually need to be included into the mission **miz** file via (unused) triggers.
---
---The default location inside the miz file is "l10n/DEFAULT/". But simply opening the *miz* file with e.g. [7-zip](https://www.7-zip.org/) and copying the files into that folder does not work.
---The next time the mission is saved, files not included via trigger are automatically removed by DCS.
---
---However, if you create a new folder inside the miz file, which contains the sounds, it will not be deleted and can be used. The location of the sound files can be specified
---via the #AIRBOSS.SetSoundfilesFolder(*folderpath*) function. The parameter *folderpath* defines the location of the sound files folder within the mission *miz* file.
---
---![Banner Image](..\Presentations\AIRBOSS\Airboss_SoundfilesFolder.png)
---
---For example as
---
---    airbossStennis:SetSoundfilesFolder("Airboss Soundfiles/")
---
---## Carrier Specific Voice Overs
---
---It is possible to use different sound files for different carriers. If you have set up two (or more) AIRBOSS objects at different carriers - say Stennis and Tarawa - each
---carrier would use the files in the specified directory, e.g.
---
---    airbossStennis:SetSoundfilesFolder("Airboss Soundfiles Stennis/")
---    airbossTarawa:SetSoundfilesFolder("Airboss Soundfiles Tarawa/")
---
---## Sound Packs
---
---The AIRBOSS currently has two different "sound packs" for LSO and three different "sound Packs" for Marshal radios. These contain voice overs by different actors.
---These can be set by #AIRBOSS.SetVoiceOversLSOByRaynor() and #AIRBOSS.SetVoiceOversMarshalByRaynor(). These are the default settings.
---The other sound files can be set by #AIRBOSS.SetVoiceOversLSOByFF(), #AIRBOSS.SetVoiceOversMarshalByGabriella() and #AIRBOSS.SetVoiceOversMarshalByFF().
---Also combinations can be used, e.g.
---
---    airbossStennis:SetVoiceOversLSOByFF()
---    airbossStennis:SetVoiceOversMarshalByRaynor()
---
---In this example LSO voice overs by FF and Marshal voice overs by Raynor are used.
---
---**Note** that this only initializes the correct parameters parameters of sound files, i.e. the duration. The correct files have to be in the directory set by the
---#AIRBOSS.SetSoundfilesFolder(*folder*) function.
---
---## How To Use Your Own Voice Overs
---
---If you have a set of AIRBOSS sound files recorded or got it from elsewhere it is possible to use those instead of the default ones.
---I recommend to use exactly the same file names as the original sound files have.
---
---However, the **timing is critical**! As sometimes sounds are played directly after one another, e.g. by saying the modex but also on other occations, the airboss
---script has a radio queue implemented (actually two - one for the LSO and one for the Marshal/Airboss radio).
---By this it is automatically taken care that played messages are not overlapping and played over each other. The disadvantage is, that the script needs to know
---the exact duration of *each* voice over. For the default sounds this is hard coded in the source code. For your own files, you need to give that bit of information
---to the script via the #AIRBOSS.SetVoiceOver(**radiocall**, **duration**, **subtitle**, **subduration**, **filename**, **suffix**) function. Only the first two
---parameters **radiocall** and **duration** are usually important to adjust here.
---
---For example, if you want to change the LSO "Call the Ball" and "Roger Ball" calls:
---
---    airbossStennis:SetVoiceOver(airbossStennis.LSOCall.CALLTHEBALL, 0.6)
---    airbossStennis:SetVoiceOver(airbossStennis.LSOCall.ROGERBALL, 0.7)
---
---Again, changing the file name, subtitle, subtitle duration is not required if you name the file exactly like the original one, which is this case would be "LSO-RogerBall.ogg".
---
---## The Radio Dilemma
---
---DCS offers two (actually three) ways to send radio messages. Each one has its advantages and disadvantages and it is important to understand the differences.
---
---### Transmission via Command
---
---*In principle*, the best way to transmit messages is via the [TransmitMessage](https://wiki.hoggitworld.com/view/DCS_command_transmitMessage) command.
---This method has the advantage that subtitles can be used and these subtitles are only displayed to the players who dialed in the same radio frequency as
---used for the transmission.
---However, this method unfortunately only works if the sending unit is an **aircraft**. Therefore, it is not usable by the AIRBOSS per se as the transmission comes from
---a naval unit (i.e. the carrier).
---
---As a workaround, you can put an aircraft, e.g. a Helicopter on the deck of the carrier or another ship of the strike group. The aircraft should be set to
---uncontrolled and maybe even to immortal. With the #AIRBOSS.SetRadioUnitName(*unitname*) function you can use this unit as "radio repeater" for both Marshal and LSO
---radio channels. However, this might lead to interruptions in the transmission if both channels transmit simultaniously. Therefore, it is better to assign a unit for
---each radio via the #AIRBOSS.SetRadioRelayLSO(unitname) and #AIRBOSS.SetRadioRelayMarshal(unitname) functions.
---
---Of course you can also use any other aircraft in the vicinity of the carrier, e.g. a rescue helo or a recovery tanker. It is just important that this
---unit is and stays close the the boat as the distance from the sender to the receiver is modeled in DCS. So messages from too far away might not reach the players.
---
---**Note** that not all radio messages the airboss sends have voice overs. Therefore, if you use a radio relay unit, users should *not* disable the
---subtitles in the DCS game menu.
---
---### Transmission via Trigger
---
---Another way to broadcast messages is via the [radio transmission trigger](https://wiki.hoggitworld.com/view/DCS_func_radioTransmission). This method can be used for all
---units (land, air, naval). However, messages cannot be subtitled. Therefore, subtitles are displayed to the players via normal textout messages.
---The disadvantage is that is is impossible to know which players have the right radio frequencies dialed in. Therefore, subtitles of the Marshal radio calls are displayed to all players
---inside the CCA. Subtitles on the LSO radio frequency are displayed to all players in the pattern.
---
---### Sound to User
---
---The third way to play sounds to the user via the [outsound trigger](https://wiki.hoggitworld.com/view/DCS_func_outSound).
---These sounds are not coming from a radio station and therefore can be heard by players independent of their actual radio frequency setting.
---The AIRBOSS class uses this method to play sounds to players which are of a more "private" nature - for example when a player has left his assigned altitude
---in the Marshal stack. Often this is the modex of the player in combination with a textout messaged displayed on screen.
---
---If you want to use this method for all radio messages you can enable it via the #AIRBOSS.SetUserSoundRadio() function. This is the analogue of activating easy comms in DCS.
---
---Note that this method is used for all players who are in the A-4E community mod as this mod does not have the ability to use radios due to current DCS restrictions.
---Therefore, A-4E drivers will hear all radio transmissions from the Marshal/Airboss and all LSO messages as soon as their commence the pattern.
---
---===
---
---# AI Handling
---
---The #AIRBOSS class allows to handle incoming AI units and integrate them into the marshal and landing pattern.
---
---By default, incoming carrier capable aircraft which are detecting inside the Carrier Controlled Area (CCA) and approach the carrier by more than 5 NM are automatically guided to the holding zone.
---Each AI group gets its own marshal stack in the holding pattern. Once a recovery window opens, the AI group of the lowest stack is transitioning to the landing pattern
---and the Marshal stack collapses.
---
---If no AI handling is desired, this can be turned off via the #AIRBOSS.SetHandleAIOFF function.
---
---In case only specifc AI groups shall be excluded, it can be done by adding the groups to a set, e.g.
---
---    -- AI groups explicitly excluded from handling by the Airboss
---    local CarrierExcludeSet=SET_GROUP:New():FilterPrefixes("E-2D Wizard Group"):FilterStart()
---    AirbossStennis:SetExcludeAI(CarrierExcludeSet)
---
---Similarly, to the #AIRBOSS.SetExcludeAI function, AI groups can be explicitly *included* via the #AIRBOSS.SetSquadronAI function. If this is used, only the *included* groups are handled
---by the AIRBOSS.
---
---## Keep the Deck Clean
---
---Once the AI groups have landed on the carrier, they can be despawned automatically after they shut down their engines. This is achieved by the #AIRBOSS.SetDespawnOnEngineShutdown() function.
---
---## Refueling
---
---AI groups in the marshal pattern can be send to refuel at the recovery tanker or if none is defined to the nearest divert airfield. This can be enabled by the #AIRBOSS.SetRefuelAI(*lowfuelthreshold*).
---The parameter *lowfuelthreshold* is the threshold of fuel in percent. If the fuel drops below this value, the group will go for refueling. If refueling is performed at the recovery tanker,
---the group will return to the marshal stack when done. The aircraft will not return from the divert airfield however.
---
---Note that this feature is not enabled by default as there might be bugs in DCS that prevent a smooth refueling of the AI. Enable at your own risk.
---
---## Respawning - DCS Landing Bug
---
---AI groups that enter the CCA are usually guided to Marshal stack. However, due to DCS limitations they might not obey the landing task if they have another airfield as departure and/or destination in
---their mission task. Therefore, AI groups can be respawned when detected in the CCA. This should clear all other airfields and allow the aircraft to land on the carrier.
---This is achieved by the #AIRBOSS.SetRespawnAI() function.
---
---## Known Issues
---
---Dealing with the DCS AI is a big challenge and there is only so much one can do. Please bear this in mind!
---
---### Pattern Updates
---
---The holding position of the AI is updated regularly when the carrier has changed its position by more then 2.5 NM or changed its course significantly.
---The patterns are realized by orbit or racetrack patterns of the DCS scripting API.
---However, when the position is updated or the marshal stack collapses, it comes to disruptions of the regular orbit because a new waypoint with a new
---orbit task needs to be created.
---
---### Recovery Cases
---
---The AI performs a very realistic Case I recovery. Therefore, we already have a good Case I and II recovery simulation since the final part of Case II is a
---Case I recovery. However, I don't think the AI can do a proper Case III recovery. If you give the AI the landing command, it is out of our hands and will
---always go for a Case I in the final pattern part. Maybe this will improve in future DCS version but right now, there is not much we can do about it.
---
---===
---
---# Finite State Machine (FSM)
---
---The AIRBOSS class has a Finite State Machine (FSM) implementation for the carrier. This allows mission designers to hook into certain events and helps
---simulate complex behaviour easier.
---
---FSM events are:
---
---   * #AIRBOSS.Start: Starts the AIRBOSS FSM.
---   * #AIRBOSS.Stop: Stops the AIRBOSS FSM.
---   * #AIRBOSS.Idle: Carrier is set to idle and not recovering.
---   * #AIRBOSS.RecoveryStart: Starts the recovery ops.
---   * #AIRBOSS.RecoveryStop: Stops the recovery ops.
---   * #AIRBOSS.RecoveryPause: Pauses the recovery ops.
---   * #AIRBOSS.RecoveryUnpause: Unpauses the recovery ops.
---   * #AIRBOSS.RecoveryCase: Sets/switches the recovery case.
---   * #AIRBOSS.PassingWaypoint: Carrier passes a waypoint defined in the mission editor.
---
---These events can be used in the user script. When the event is triggered, it is automatically a function OnAfter*Eventname* called. For example
---
---    --- Carrier just passed waypoint *n*.
---    function AirbossStennis:OnAfterPassingWaypoint(From, Event, To, n)
---     -- Launch green flare.
---     self.carrier:FlareGreen()
---    end
---
---In this example, we only launch a green flare every time the carrier passes a waypoint defined in the mission editor. But, of course, you can also use it to add new
---recovery windows each time a carrier passes a waypoint. Therefore, you can create an "infinite" number of windows easily.
---
---===
---
---# Examples
---
---In this section a few simple examples are given to illustrate the scripting part.
---
---## Simple Case
---
---    -- Create AIRBOSS object.
---    local AirbossStennis=AIRBOSS:New("USS Stennis")
---
---    -- Add recovery windows:
---    -- Case I from 9 to 10 am. Carrier will turn into the wind 5 min before window opens and go at a speed so that wind over the deck is 25 knots.
---    local window1=AirbossStennis:AddRecoveryWindow("9:00",  "10:00", 1, nil, true, 25)
---    -- Case II with +15 degrees holding offset from 15:00 for 60 min.
---    local window2=AirbossStennis:AddRecoveryWindow("15:00", "16:00", 2, 15)
---    -- Case III with +30 degrees holding offset from 21:00 to 23:30.
---    local window3=AirbossStennis:AddRecoveryWindow("21:00", "23:30", 3, 30)
---
---    -- Load all saved player grades from your "Saved Games\DCS" folder (if lfs was desanitized).
---    AirbossStennis:Load()
---
---    -- Automatically save player results to your "Saved Games\DCS" folder each time a player get a final grade from the LSO.
---    AirbossStennis:SetAutoSave()
---
---    -- Start airboss class.
---    AirbossStennis:Start()
---
---===
---
---# Debugging
---
---In case you have problems, it is always a good idea to have a look at your DCS log file. You find it in your "Saved Games" folder, so for example in
---    C:\Users\<yourname>\Saved Games\DCS\Logs\dcs.log
---All output concerning the #AIRBOSS class should have the string "AIRBOSS" in the corresponding line.
---Searching for lines that contain the string "error" or "nil" can also give you a hint what's wrong.
---
---The verbosity of the output can be increased by adding the following lines to your script:
---
---    BASE:TraceOnOff(true)
---    BASE:TraceLevel(1)
---    BASE:TraceClass("AIRBOSS")
---
---To get even more output you can increase the trace level to 2 or even 3, c.f. Core.Base#BASE for more details.
---
---### Debug Mode
---
---You have the option to enable the debug mode for this class via the #AIRBOSS.SetDebugModeON function.
---If enabled, status and debug text messages will be displayed on the screen. Also informative marks on the F10 map are created.
---AIRBOSS class.
---@class AIRBOSS : FSM
---@field Abeam AIRBOSS.Checkpoint Abeam checkpoint.
---@field AirbossFreq number Airboss radio frequency in MHz.
---@field AirbossModu string Airboss radio modulation "AM" or "FM".
---@field AirbossRadio AIRBOSS.Radio Radio for carrier calls.
---@field AircraftCarrier AIRBOSS.AircraftCarrier 
---@field BreakEarly AIRBOSS.Checkpoint Early break checkpoint.
---@field BreakEntry AIRBOSS.Checkpoint Break entry checkpoint.
---@field BreakLate AIRBOSS.Checkpoint Late break checkpoint.
---@field Bullseye AIRBOSS.Checkpoint Case III intercept glideslope and follow ICLS aka "bullseye".
---@field CarrierType AIRBOSS.CarrierType 
---@field ClassName string Name of the class.
---@field Corientation Vec3 Carrier orientation in space.
---@field Corientlast Vec3 Last known carrier orientation.
---@field Cposition COORDINATE Carrier position.
---@field Creturnto COORDINATE Position to return to after turn into the wind leg is over.
---@field Debug boolean Debug mode. Messages to all about status.
---@field Difficulty AIRBOSS.Difficulty 
---@field DirtyUp AIRBOSS.Checkpoint Case II/III dirty up and on speed position at 1200 ft and 10-12 NM from the carrier.
---@field Final AIRBOSS.Checkpoint Checkpoint when turning to final.
---@field Groove AIRBOSS.Checkpoint In the groove checkpoint.
---@field GroovePos AIRBOSS.GroovePos 
---@field ICLSchannel number ICLS channel.
---@field ICLSmorse string ICLS morse code, e.g. "STN".
---@field ICLSon boolean Automatic ICLS is activated.
---@field LSOCall AIRBOSS.LSOCalls Radio voice overs of the LSO.
---@field LSOFreq number LSO radio frequency in MHz.
---@field LSOModu string LSO radio modulation "AM" or "FM".
---@field LSORadio AIRBOSS.Radio Radio for LSO calls.
---@field LSOdT number Time interval in seconds before the LSO will make its next call.
---@field MarshalCall AIRBOSS.MarshalCalls Radio voice over of the Marshal/Airboss.
---@field MarshalFreq number Marshal radio frequency in MHz.
---@field MarshalModu string Marshal radio modulation "AM" or "FM".
---@field MarshalRadio AIRBOSS.Radio Radio for carrier calls.
---@field MenuF10 table Main group level radio menu: F10 Other/Airboss.
---@field MenuF10Root table Airboss mission level F10 root menu.
---@field Ninety AIRBOSS.Checkpoint At the ninety checkpoint.
---@field NmaxSection number Number of max section members (excluding the lead itself), i.e. NmaxSection=1 is a section of two.
---@field NmaxStack number Number of max flights per stack. Default 2.
---@field Nmaxmarshal number Number of max Case I Marshal stacks available. Default 3, i.e. angels 2, 3 and 4.
---@field Nmaxpattern number Max number of aircraft in landing pattern.
---@field PatternStep AIRBOSS.PatternStep 
---@field PilotCall AIRBOSS.PilotCalls Radio voice over from AI pilots.
---@field PilotRadio AIRBOSS.Radio Radio for Pilot calls.
---@field Platform AIRBOSS.Checkpoint Case II/III descent at 2000 ft/min at 5000 ft platform.
---@field Qmarshal table Queue of marshalling aircraft groups.
---@field Qpattern table Queue of aircraft groups in the landing pattern.
---@field Qspinning table Queue of aircraft currently spinning.
---@field Qwaiting table Queue of aircraft groups waiting outside 10 NM zone for the next free Marshal stack.
---@field RQLSO table Radio queue of LSO.
---@field RQLid NOTYPE 
---@field RQMarshal table Radio queue of marshal.
---@field RQMid NOTYPE 
---@field SRS NOTYPE 
---@field SRSQ NOTYPE 
---@field StatusTimer NOTYPE 
---@field TACANchannel number TACAN channel.
---@field TACANmode string TACAN mode, i.e. "X" or "Y".
---@field TACANmorse string TACAN morse code, e.g. "STN".
---@field TACANon boolean Automatic TACAN is activated.
---@field TQLSO number Abs mission time, the last transmission ended.
---@field TQMarshal number Abs mission time, the last transmission ended.
---@field Tbeacon number Last time the beacons were refeshed.
---@field Tcollapse number Last time timer.gettime() the stack collapsed.
---@field Tmessage number Default duration in seconds messages are displayed to players.
---@field TowerFreq number Tower radio frequency in MHz.
---@field Tpupdate NOTYPE 
---@field Tqueue number Last time in seconds of timer.getTime() the queue was updated.
---@field Wake AIRBOSS.Checkpoint Checkpoint right behind the carrier.
---@field private adinfinitum boolean If true, carrier patrols ad infinitum, i.e. when reaching its last waypoint it starts at waypoint one again.
---@field private airbase AIRBASE Carrier airbase object.
---@field private airbossnice boolean Airboss is a nice guy.
---@field private alias string Alias of the carrier.
---@field private autosave boolean If true, all player grades are automatically saved to a file on disk.
---@field private autosavefile NOTYPE 
---@field private autosavefilename string File name of the auto player grades save file. Default is auto generated from carrier name/alias.
---@field private autosavepath string Path where the player grades file is saved on auto save.
---@field private awacs NOTYPE 
---@field private beacon BEACON Carrier beacon for TACAN and ICLS.
---@field private carrier UNIT Aircraft carrier unit on which we want to practice.
---@field private carrierparam AIRBOSS.CarrierParameters Carrier specific parameters.
---@field private carriertype string Type name of aircraft carrier.
---@field private case number Recovery case I, II or III currently in progress.
---@field private collisiondist number Distance up to which collision checks are done.
---@field private currentwp number Current waypoint, i.e. the one that has been passed last.
---@field private dTbeacon number Time interval to refresh the beacons. Default 5 minutes.
---@field private dTqueue number Time interval in seconds for updating the queues etc.
---@field private dTstatus number Time interval for call FSM status updates.
---@field private defaultcase number Default recovery case. This is the case used if not specified otherwise.
---@field private defaultoffset number Default holding pattern update if not specified otherwise.
---@field private defaultskill string Default player skill @{#AIRBOSS.Difficulty}.
---@field private despawnshutdown boolean Despawn group after engine shutdown.
---@field private detour boolean If true, carrier is currently making a detour from its path along the ME waypoints.
---@field private emergency boolean If true (default), allow emergency landings, i.e. bypass any pattern and go for final approach.
---@field private excludesetAI SET_GROUP AI groups in this set will be explicitly excluded from handling by the airboss and not forced into the Marshal pattern.
---@field private flights table List of all flights in the CCA.
---@field private funkmanSocket NOTYPE 
---@field private gle AIRBOSS.GLE Glidesope error thresholds.
---@field private handleai boolean If true (default), handle AI aircraft.
---@field private holdingoffset number Offset [degrees] of Case II/III holding pattern.
---@field private holdtimestamp number Timestamp when the carrier first came to an unexpected hold.
---@field private initialmaxalt number Max altitude in meters to register in the inital zone.
---@field private intowindold boolean If true, use old into wind calculation.
---@field private landingcoord COORDINATE 
---@field private landingspotcoord COORDINATE 
---@field private lid string Class id string for output to DCS log file.
---@field private lowfuelAI number Low fuel threshold for AI groups in percent.
---@field private lue AIRBOSS.LUE Lineup error thresholds.
---@field private magvar number Magnetic declination in degrees.
---@field private marshalradius number Radius of the Marshal stack zone.
---@field private menuadded table Table of units where the F10 radio menu was added.
---@field private menumarkzones boolean If false, disables the option to mark zones via smoke or flares.
---@field private menusingle boolean If true, menu is optimized for a single carrier.
---@field private menusmokezones boolean If false, disables the option to mark zones via smoke.
---@field private players table Table of players.
---@field private playerscores table Table holding all player scores and grades.
---@field private radiorelayLSO string Name of the aircraft acting as sender for broadcasting LSO radio messages from the carrier. DCS shortcoming workaround.
---@field private radiorelayMSH string Name of the aircraft acting as sender for broadcasting Marhsal radio messages from the carrier. DCS shortcoming workaround.
---@field private radiotimer SCHEDULER Radio queue scheduler.
---@field private recoverytimes table List of time windows when aircraft are recovered including the recovery case and holding offset.
---@field private recoverywindow AIRBOSS.Recovery Current or next recovery window opened.
---@field private respawnAI boolean If true, respawn AI flights as they enter the CCA to detach and airfields from the mission plan. Default false.
---@field private senderac string Name of the aircraft acting as sender for broadcasting radio messages from the carrier. DCS shortcoming workaround.
---@field private skipperCase number Manual recovery case.
---@field private skipperMenu boolean If true, add skipper menu.
---@field private skipperOffset number Holding offset angle in degrees for Case II/III manual recoveries.
---@field private skipperSpeed number Speed in knots for manual recovery start.
---@field private skipperTime number Recovery time in min for manual recovery.
---@field private skipperUturn boolean U-turn on/off via menu.
---@field private soundfolder string Folder within the mission (miz) file where airboss sound files are located.
---@field private soundfolderLSO string Folder withing the mission (miz) file where LSO sound files are stored.
---@field private soundfolderMSH string Folder withing the mission (miz) file where Marshal sound files are stored.
---@field private squadsetAI SET_GROUP AI groups in this set will be handled by the airboss.
---@field private staticweather boolean Mission uses static rather than dynamic weather.
---@field private sterncoord COORDINATE 
---@field private tanker RECOVERYTANKER Recovery tanker flying overhead of carrier.
---@field private theatre string The DCS map used in the mission.
---@field private trappath string Path where to save the trap sheets.
---@field private trapprefix string File prefix for trap sheet files.
---@field private trapsheet boolean If true, players can save their trap sheets.
---@field private turning boolean If true, carrier is currently turning.
---@field private turnintowind boolean If true, carrier is currently turning into the wind.
---@field private usersoundradio boolean Use user sound output instead of radio transmissions.
---@field private version string Airboss class version.
---@field private waypoints table Waypoint coordinates of carrier.
---@field private welcome boolean If true, display welcome message to player.
---@field private windowcount number Running number counting the recovery windows.
---@field private xtVoiceOvers NOTYPE 
---@field private xtVoiceOversAI NOTYPE 
---@field private zoneCCA ZONE_UNIT Carrier controlled area (CCA), i.e. a zone of 50 NM radius around the carrier.
---@field private zoneCCZ ZONE_UNIT Carrier controlled zone (CCZ), i.e. a zone of 5 NM radius around the carrier.
---@field private zoneHolding NOTYPE 
AIRBOSS = {}

---Add a group to the exclude set.
---If no set exists, it is created.
---
------
---@param Group GROUP The group to be excluded.
---@return AIRBOSS #self
function AIRBOSS:AddExcludeAI(Group) end

---Add aircraft recovery time window and recovery case.
---
------
---@param starttime string Start time, e.g. "8:00" for eight o'clock. Default now.
---@param stoptime string Stop time, e.g. "9:00" for nine o'clock. Default 90 minutes after start time.
---@param case number Recovery case for that time slot. Number between one and three.
---@param holdingoffset number Only for CASE II/III: Angle in degrees the holding pattern is offset.
---@param turnintowind boolean If true, carrier will turn into the wind 5 minutes before the recovery window opens.
---@param speed number Speed in knots during turn into wind leg.
---@param uturn boolean If true (or nil), carrier wil perform a U-turn and go back to where it came from before resuming its route to the next waypoint. If false, it will go directly to the next waypoint.
---@return AIRBOSS.Recovery #Recovery window.
function AIRBOSS:AddRecoveryWindow(starttime, stoptime, case, holdingoffset, turnintowind, speed, uturn) end

---Broadcast radio message.
---
------
---@param radio AIRBOSS.Radio Radio sending transmission.
---@param call AIRBOSS.RadioCall Radio sound files and subtitles.
---@param loud boolean Play loud version of file.
function AIRBOSS:Broadcast(radio, call, loud) end

---Let the carrier make a detour to a given point.
---When it reaches the point, it will resume its normal route.
---
------
---@param coord COORDINATE Coordinate of the detour.
---@param speed number Speed in knots. Default is current carrier velocity.
---@param uturn? boolean (Optional) If true, carrier will go back to where it came from before it resumes its route to the next waypoint.
---@param uspeed number Speed in knots after U-turn. Default is same as before.
---@param tcoord COORDINATE Additional coordinate to make turn smoother.
---@return AIRBOSS #self
function AIRBOSS:CarrierDetour(coord, speed, uturn, uspeed, tcoord) end

---Carrier resumes the route at its next waypoint.
---
------
---@param gotocoord? COORDINATE (Optional) First goto this coordinate before resuming route.
---@return AIRBOSS #self
function AIRBOSS:CarrierResumeRoute(gotocoord) end

---Let the carrier turn into the wind.
---
------
---@param time number Time in seconds.
---@param vdeck number Speed on deck m/s. Carrier will
---@param uturn boolean Make U-turn and go back to initial after downwind leg.
---@return AIRBOSS #self
function AIRBOSS:CarrierTurnIntoWind(time, vdeck, uturn) end

---Close currently running recovery window and stop recovery ops.
---Recovery window is deleted.
---
------
---@param Delay? number (Optional) Delay in seconds before the window is deleted.
function AIRBOSS:CloseCurrentRecoveryWindow(Delay) end

---Delete all recovery windows.
---
------
---@param Delay? number (Optional) Delay in seconds before the windows are deleted.
---@return AIRBOSS #self
function AIRBOSS:DeleteAllRecoveryWindows(Delay) end

---Delete a recovery window.
---If the window is currently open, it is closed and the recovery stopped.
---
------
---@param Window AIRBOSS.Recovery Recovery window.
---@param Delay number Delay in seconds, before the window is deleted.
function AIRBOSS:DeleteRecoveryWindow(Window, Delay) end

---Set up SRS for usage without sound files
---
------
---@param PathToSRS string Path to SRS folder, e.g. "C:\\Program Files\\DCS-SimpleRadio-Standalone".
---@param Port number Port of the SRS server, defaults to 5002.
---@param Culture string (Optional, Airboss Culture)  Culture, defaults to "en-US".
---@param Gender string (Optional, Airboss Gender)  Gender, e.g. "male" or "female". Defaults to "male".
---@param Voice string (Optional, Airboss Voice) Set to use a specific voice. Will **override gender and culture** settings.
---@param GoogleCreds? string (Optional) Path to Google credentials, e.g. "C:\\Program Files\\DCS-SimpleRadio-Standalone\\yourgooglekey.json".
---@param Volume? number (Optional) E.g. 0.75. Defaults to 1.0 (loudest).
---@param AltBackend? table (Optional) See MSRS for details.
---@return AIRBOSS #self
function AIRBOSS:EnableSRS(PathToSRS, Port, Culture, Gender, Voice, GoogleCreds, Volume, AltBackend) end

---Get base recovery course (BRC) of carrier.
---The is the magnetic heading of the carrier.
---
------
---@return number #BRC in degrees.
function AIRBOSS:GetBRC() end

---Get base recovery course (BRC) when the carrier would head into the wind.
---This includes the current wind direction and accounts for the angled runway.
---
------
---@param vdeck number Desired wind velocity over deck in knots.
---@return number #BRC into the wind in degrees.
function AIRBOSS:GetBRCintoWind(vdeck) end

---Get carrier coalition.
---
------
---@return number #Coalition side of carrier.
function AIRBOSS:GetCoalition() end

---Get carrier coordinate.
---
------
---@return COORDINATE #Carrier coordinate.
function AIRBOSS:GetCoord() end

---Get carrier coordinate.
---
------
---@return COORDINATE #Carrier coordinate.
function AIRBOSS:GetCoordinate() end

---Get final bearing (FB) of carrier.
---By default, the routine returns the magnetic FB depending on the current map (Caucasus, NTTR, Normandy, Persion Gulf etc).
---The true bearing can be obtained by setting the *TrueNorth* parameter to true.
---
------
---@param magnetic boolean If true, magnetic FB is returned.
---@return number #FB in degrees.
function AIRBOSS:GetFinalBearing(magnetic) end

---Get true (or magnetic) heading of carrier.
---
------
---@param magnetic boolean If true, calculate magnetic heading. By default true heading is returned.
---@return number #Carrier heading in degrees.
function AIRBOSS:GetHeading(magnetic) end

---Get true (or magnetic) heading of carrier into the wind.
---This accounts for the angled runway.
---
------
---@param vdeck number Desired wind velocity over deck in knots.
---@param magnetic boolean If true, calculate magnetic heading. By default true heading is returned.
---@param coord? COORDINATE (Optional) Coordinate from which heading is calculated. Default is current carrier position.
---@return number #Carrier heading in degrees.
---@return number #Carrier speed in knots to reach desired wind speed on deck.
function AIRBOSS:GetHeadingIntoWind(vdeck, magnetic, coord) end

---Get true (or magnetic) heading of carrier into the wind.
---This accounts for the angled runway.
---Implementation based on [Mags & Bambi](https://magwo.github.io/carrier-cruise/).
---
------
---@param vdeck number Desired wind velocity over deck in knots.
---@param magnetic boolean If true, calculate magnetic heading. By default true heading is returned.
---@param coord? COORDINATE (Optional) Coordinate from which heading is calculated. Default is current carrier position.
---@return number #Carrier heading in degrees.
---@return number #Carrier speed in knots to reach desired wind speed on deck.
function AIRBOSS:GetHeadingIntoWind_new(vdeck, magnetic, coord) end

---Get true (or magnetic) heading of carrier into the wind.
---This accounts for the angled runway.
---
------
---@param vdeck number Desired wind velocity over deck in knots.
---@param magnetic boolean If true, calculate magnetic heading. By default true heading is returned.
---@param coord? COORDINATE (Optional) Coordinate from which heading is calculated. Default is current carrier position.
---@return number #Carrier heading in degrees.
function AIRBOSS:GetHeadingIntoWind_old(vdeck, magnetic, coord) end

---Get next time the carrier will start recovering aircraft.
---
------
---@param InSeconds boolean If true, abs. mission time seconds is returned. Default is a clock #string.
---@return string #Clock start (or start time in abs. seconds).
---@return string #Clock stop (or stop time in abs. seconds).
function AIRBOSS:GetNextRecoveryTime(InSeconds) end

---Get radial with respect to carrier BRC or FB and (optionally) holding offset.
---
---* case=1: radial=FB-180
---* case=2: radial=HDG-180 (+offset)
---* case=3: radial=FB-180 (+offset)
---
------
---@param case number Recovery case.
---@param magnetic boolean If true, magnetic radial is returned. Default is true radial.
---@param offset boolean If true, inlcude holding offset.
---@param inverse boolean Return inverse, i.e. radial-180 degrees.
---@return number #Radial in degrees.
function AIRBOSS:GetRadial(case, magnetic, offset, inverse) end

---Return the recovery window of the given ID.
---
------
---@param id number The ID of the recovery window.
---@return AIRBOSS.Recovery #Recovery window with the right ID or nil if no such window exists.
function AIRBOSS:GetRecoveryWindowByID(id) end

---Get wind direction and speed at carrier position.
---
------
---@param alt number Altitude ASL in meters. Default 18 m.
---@param magnetic boolean Direction including magnetic declination.
---@param coord? COORDINATE (Optional) Coordinate at which to get the wind. Default is current carrier position.
---@return number #Direction the wind is blowing **from** in degrees.
---@return number #Wind speed in m/s.
function AIRBOSS:GetWind(alt, magnetic, coord) end

---Get wind speed on carrier deck parallel and perpendicular to runway.
---
------
---@param alt number Altitude in meters. Default 18 m.
---@return number #Wind component parallel to runway im m/s.
---@return number #Wind component perpendicular to runway in m/s.
---@return number #Total wind strength in m/s.
function AIRBOSS:GetWindOnDeck(alt) end

---Triggers the FSM event "Idle" that puts the carrier into state "Idle" where no recoveries are carried out.
---
------
function AIRBOSS:Idle() end

---Check if carrier is idle, i.e.
---no operations are carried out.
---
------
---@return boolean #If true, carrier is in idle state.
function AIRBOSS:IsIdle() end

---Check if recovery of aircraft is paused.
---
------
---@return boolean #If true, recovery is paused
function AIRBOSS:IsPaused() end

---Check if carrier is recovering aircraft.
---
------
---@return boolean #If true, time slot for recovery is open.
function AIRBOSS:IsRecovering() end

---Triggers the FSM event "LSOGrade".
---Called when the LSO grades a player
---
------
---@param playerData AIRBOSS.PlayerData Player Data.
---@param grade AIRBOSS.LSOgrade LSO grade.
function AIRBOSS:LSOGrade(playerData, grade) end

---Triggers the FSM event "Load" that loads the player scores from a file.
---AIRBOSS FSM must **not** be started at this point.
---
------
---@param path string Path where the file is located. Default is the DCS installation root directory.
---@param filename? string (Optional) File name. Default is AIRBOSS-<ALIAS>_LSOgrades.csv.
function AIRBOSS:Load(path, filename) end

---Triggers the FSM event "Marshal".
---Called when a flight is send to the Marshal stack.
---
------
---@param flight AIRBOSS.FlightGroup The flight group data.
function AIRBOSS:Marshal(flight) end

---Send text message to all players in the marshal queue.
---Message format will be "SENDER: RECCEIVER, MESSAGE".
---
------
---@param message string The message to send.
---@param sender string The person who sends the message or nil.
---@param receiver string The person who receives the message. Default player's onboard number. Set to "" for no receiver.
---@param duration number Display message duration. Default 10 seconds.
---@param clear boolean If true, clear screen from previous messages.
---@param delay number Delay in seconds, before the message is displayed.
function AIRBOSS:MessageToMarshal(message, sender, receiver, duration, clear, delay) end

---Send text message to all players in the pattern queue.
---Message format will be "SENDER: RECCEIVER, MESSAGE".
---
------
---@param message string The message to send.
---@param sender string The person who sends the message or nil.
---@param receiver string The person who receives the message. Default player's onboard number. Set to "" for no receiver.
---@param duration number Display message duration. Default 10 seconds.
---@param clear boolean If true, clear screen from previous messages.
---@param delay number Delay in seconds, before the message is displayed.
function AIRBOSS:MessageToPattern(message, sender, receiver, duration, clear, delay) end

---Send text message to player client.
---Message format will be "SENDER: RECCEIVER, MESSAGE".
---
------
---@param playerData AIRBOSS.PlayerData Player data.
---@param message string The message to send.
---@param sender string The person who sends the message or nil.
---@param receiver string The person who receives the message. Default player's onboard number. Set to "" for no receiver.
---@param duration number Display message duration. Default 10 seconds.
---@param clear boolean If true, clear screen from previous messages.
---@param delay number Delay in seconds, before the message is displayed.
function AIRBOSS:MessageToPlayer(playerData, message, sender, receiver, duration, clear, delay) end

---Create a new AIRBOSS class object for a specific aircraft carrier unit.
---
------
---@param carriername string Name of the aircraft carrier unit as defined in the mission editor.
---@param alias? string (Optional) Alias for the carrier. This will be used for radio messages and the F10 radius menu. Default is the carrier name as defined in the mission editor.
---@return AIRBOSS #self or nil if carrier unit does not exist.
function AIRBOSS:New(carriername, alias) end

---On after "LSOGrade" user function.
---Called when the carrier passes a waypoint of its route.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param playerData AIRBOSS.PlayerData Player Data.
---@param grade AIRBOSS.LSOgrade LSO grade.
function AIRBOSS:OnAfterLSOGrade(From, Event, To, playerData, grade) end

---On after "Load" event user function.
---Called when the player scores are loaded from disk.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param path string Path where the file is located. Default is the DCS installation root directory or your "Saved Games\DCS" folder if lfs was desanitized.
---@param filename? string (Optional) File name. Default is AIRBOSS-*ALIAS*_LSOgrades.csv.
function AIRBOSS:OnAfterLoad(From, Event, To, path, filename) end

---On after "Marshal" user function.
---Called when a flight is send to the Marshal stack.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param flight AIRBOSS.FlightGroup The flight group data.
function AIRBOSS:OnAfterMarshal(From, Event, To, flight) end

---On after "PassingWaypoint" user function.
---Called when the carrier passes a waypoint of its route.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param waypoint number Number of waypoint.
function AIRBOSS:OnAfterPassingWaypoint(From, Event, To, waypoint) end

---On after "RecoveryStart" user function.
---Called when recovery of aircraft is started and carrier switches to state "Recovering".
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Case number The recovery case (1, 2 or 3) to start.
---@param Offset number Holding pattern offset angle in degrees for CASE II/III recoveries.
function AIRBOSS:OnAfterRecoveryStart(From, Event, To, Case, Offset) end

---On after "RecoveryStop" user function.
---Called when recovery of aircraft is stopped.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function AIRBOSS:OnAfterRecoveryStop(From, Event, To) end

---On after "Save" event user function.
---Called when the player scores are saved to disk.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param path string Path where the file is saved. Default is the DCS installation root directory or your "Saved Games\DCS" folder if lfs was desanitized.
---@param filename? string (Optional) File name. Default is AIRBOSS-*ALIAS*_LSOgrades.csv.
function AIRBOSS:OnAfterSave(From, Event, To, path, filename) end

---On after "Start" user function.
---Called when the AIRBOSS FSM is started.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function AIRBOSS:OnAfterStart(From, Event, To) end

---Airboss event handler for event birth.
---
------
---@param EventData EVENTDATA 
function AIRBOSS:OnEventBirth(EventData) end

---Airboss event handler for event crash.
---
------
---@param EventData EVENTDATA 
function AIRBOSS:OnEventCrash(EventData) end

---Airboss event handler for event Ejection.
---
------
---@param EventData EVENTDATA 
function AIRBOSS:OnEventEjection(EventData) end

---Airboss event handler for event that a unit shuts down its engines.
---
------
---@param EventData EVENTDATA 
function AIRBOSS:OnEventEngineShutdown(EventData) end

---Airboss event function handling the mission end event.
---Handles the case when the mission is ended.
---
------
---@param EventData EVENTDATA Event data.
function AIRBOSS:OnEventMissionEnd(EventData) end

---Airboss event handler for event REMOVEUNIT.
---
------
---@param EventData EVENTDATA 
function AIRBOSS:OnEventRemoveUnit(EventData) end

---Airboss event handler for event land.
---
------
---@param EventData EVENTDATA 
function AIRBOSS:OnEventRunwayTouch(EventData) end

---Airboss event handler for event that a unit takes off.
---
------
---@param EventData EVENTDATA 
function AIRBOSS:OnEventTakeoff(EventData) end

---Triggers the FSM event "PassingWaypoint".
---Called when the carrier passes a waypoint.
---
------
---@param waypoint number Number of waypoint.
function AIRBOSS:PassingWaypoint(waypoint) end

---Add Radio transmission to radio queue.
---
------
---@param radio AIRBOSS.Radio Radio sending the transmission.
---@param call AIRBOSS.RadioCall Radio sound files and subtitles.
---@param loud boolean If true, play loud sound file version.
---@param delay number Delay in seconds, before the message is broadcasted.
---@param interval number Interval in seconds after the last sound has been played.
---@param click boolean If true, play radio click at the end.
---@param pilotcall boolean If true, it's a pilot call.
function AIRBOSS:RadioTransmission(radio, call, loud, delay, interval, click, pilotcall) end

---Triggers the FSM event "RecoveryCase" that switches the aircraft recovery case.
---
------
---@param Case number The new recovery case (1, 2 or 3).
---@param Offset number Holding pattern offset angle in degrees for CASE II/III recoveries.
function AIRBOSS:RecoveryCase(Case, Offset) end

---Triggers the FSM event "RecoveryPause" that pauses the recovery of aircraft.
---
------
---@param duration number Duration of pause in seconds. After that recovery is automatically resumed.
function AIRBOSS:RecoveryPause(duration) end

---Triggers the FSM event "RecoveryStart" that starts the recovery of aircraft.
---Marshalling aircraft are send to the landing pattern.
---
------
---@param Case number Recovery case (1, 2 or 3) that is started.
---@param Offset number Holding pattern offset angle in degrees for CASE II/III recoveries.
function AIRBOSS:RecoveryStart(Case, Offset) end

---Triggers the FSM event "RecoveryStop" that stops the recovery of aircraft.
---
------
function AIRBOSS:RecoveryStop() end

---Triggers the FSM event "RecoveryUnpause" that resumes the recovery of aircraft if it was paused.
---
------
function AIRBOSS:RecoveryUnpause() end

---Triggers the FSM event "Save" that saved the player scores to a file.
---
------
---@param path string Path where the file is saved. Default is the DCS installation root directory or your "Saved Games\DCS" folder if lfs was desanitized.
---@param filename? string (Optional) File name. Default is AIRBOSS-*ALIAS*_LSOgrades.csv.
function AIRBOSS:Save(path, filename) end

---Define an AWACS associated with the carrier.
---
------
---@param awacs RECOVERYTANKER AWACS (recovery tanker) object.
---@return AIRBOSS #self
function AIRBOSS:SetAWACS(awacs) end

---Airboss is a rather nice guy and not strictly following the rules.
---Fore example, he does allow you into the landing pattern if you are not coming from the Marshal stack.
---
------
---@param Switch boolean If true or nil, Airboss bends the rules a bit.
---@return AIRBOSS #self
function AIRBOSS:SetAirbossNiceGuy(Switch) end

---Set Airboss radio frequency and modulation.
---Default frequency is Tower frequency.
---
------
---
---USAGE
---```
---   -- Set single frequency
---   myairboss:SetAirbossRadio(127.5,"AM",MSRS.Voices.Google.Standard.en_GB_Standard_F)
---
---   -- Set multiple frequencies, note you **need** to pass one modulation per frequency given!
---   myairboss:SetAirbossRadio({127.5,243},{radio.modulation.AM,radio.modulation.AM},MSRS.Voices.Google.Standard.en_GB_Standard_F)
---```
------
---@param Frequency? number (Optional) Frequency in MHz. Default frequency is Tower frequency.
---@param Modulation? string (Optional) Modulation, "AM" or "FM". Default "AM".
---@param Voice? string (Optional) SRS specific voice
---@param Gender? string (Optional) SRS specific gender
---@param Culture? string (Optional) SRS specific culture
---@return AIRBOSS #self
function AIRBOSS:SetAirbossRadio(Frequency, Modulation, Voice, Gender, Culture) end

---Enable auto save of player results each time a player is *finally* graded.
---*Finally* means after the player landed on the carrier! After intermediate passes (bolter or waveoff) the stats are *not* saved.
---
------
---@param path string Path where to save the asset data file. Default is the DCS root installation directory or your "Saved Games\\DCS" folder if lfs was desanitized.
---@param filename string File name. Default is generated automatically from airboss carrier name/alias.
---@return AIRBOSS #self
function AIRBOSS:SetAutoSave(path, filename) end

---Set beacon (TACAN/ICLS) time refresh interfal in case the beacons die.
---
------
---@param TimeInterval? number (Optional) Time interval in seconds. Default 1200 sec = 20 min.
---@return AIRBOSS #self
function AIRBOSS:SetBeaconRefresh(TimeInterval) end

---Set carrier controlled area (CCA).
---This is a large zone around the carrier, which is constantly updated wrt the carrier position.
---
------
---@param Radius number Radius of zone in nautical miles (NM). Default 50 NM.
---@return AIRBOSS #self
function AIRBOSS:SetCarrierControlledArea(Radius) end

---Set carrier controlled zone (CCZ).
---This is a small zone (usually 5 NM radius) around the carrier, which is constantly updated wrt the carrier position.
---
------
---@param Radius number Radius of zone in nautical miles (NM). Default 5 NM.
---@return AIRBOSS #self
function AIRBOSS:SetCarrierControlledZone(Radius) end

---Set distance up to which water ahead is scanned for collisions.
---
------
---@param Distance number Distance in NM. Default 5 NM.
---@return AIRBOSS #self
function AIRBOSS:SetCollisionDistance(Distance) end

---Deactivate debug mode.
---This is also the default setting.
---
------
---@return AIRBOSS #self
function AIRBOSS:SetDebugModeOFF() end

---Activate debug mode.
---Display debug messages on screen.
---
------
---@return AIRBOSS #self
function AIRBOSS:SetDebugModeON() end

---Set duration how long messages are displayed to players.
---
------
---@param Duration number Duration in seconds. Default 10 sec.
---@return AIRBOSS #self
function AIRBOSS:SetDefaultMessageDuration(Duration) end

---Set default player skill.
---New players will be initialized with this skill.
---
---* "Flight Student" = #AIRBOSS.Difficulty.Easy
---* "Naval Aviator" = #AIRBOSS.Difficulty.Normal
---* "TOPGUN Graduate" = #AIRBOSS.Difficulty.Hard
---
------
---@param skill string Player skill. Default "Naval Aviator".
---@return AIRBOSS #self
function AIRBOSS:SetDefaultPlayerSkill(skill) end

---Despawn AI groups after they they shut down their engines.
---
------
---@param Switch boolean If true or nil, AI groups are despawned.
---@return AIRBOSS #self
function AIRBOSS:SetDespawnOnEngineShutdown(Switch) end

---Allow emergency landings, i.e.
---bypassing any pattern and go directly to final approach.
---
------
---@param Switch boolean If true or nil, emergency landings are okay.
---@return AIRBOSS #self
function AIRBOSS:SetEmergencyLandings(Switch) end

---Define a set of AI groups that excluded from AI handling.
---Members of this set will be left allone by the airboss and not forced into the Marshal pattern.
---
------
---@param SetGroup SET_GROUP The set of AI groups which are excluded.
---@return AIRBOSS #self
function AIRBOSS:SetExcludeAI(SetGroup) end

---Will play the inbound calls, commencing, initial, etc.
---from the player when requesteing marshal
---
------
---@param status AIRBOSS Boolean to activate (true) / deactivate (false) the radio inbound calls (default is ON)
---@return AIRBOSS #self
function AIRBOSS:SetExtraVoiceOvers(status) end

---Will simulate the inbound call, commencing, initial, etc from the AI when requested by Airboss
---
------
---@param status AIRBOSS Boolean to activate (true) / deactivate (false) the radio inbound calls (default is ON)
---@return AIRBOSS #self
function AIRBOSS:SetExtraVoiceOversAI(status) end

---Set FunkMan socket.
---LSO grades and trap sheets will be send to your Discord bot.
---**Requires running FunkMan program**.
---
------
---@param Port number Port. Default `10042`.
---@param Host string Host. Default `"127.0.0.1"`.
---@return AIRBOSS #self
function AIRBOSS:SetFunkManOn(Port, Host) end


---
------
---@param _max NOTYPE 
---@param _min NOTYPE 
---@param High NOTYPE 
---@param HIGH NOTYPE 
---@param Low NOTYPE 
---@param LOW NOTYPE 
function AIRBOSS:SetGlideslopeErrorThresholds(_max, _min, High, HIGH, Low, LOW) end

---Do not handle AI aircraft.
---
------
---@return AIRBOSS #self
function AIRBOSS:SetHandleAIOFF() end

---Handle AI aircraft.
---
------
---@return AIRBOSS #self
function AIRBOSS:SetHandleAION() end

---Set holding pattern offset from final bearing for Case II/III recoveries.
---Usually, this is +-15 or +-30 degrees. You should not use and offset angle >= 90 degrees, because this will cause a devision by zero in some of the equations used to calculate the approach corridor.
---So best stick to the defaults up to 30 degrees.
---
------
---@param Offset number Offset angle in degrees. Default 0.
---@return AIRBOSS #self
function AIRBOSS:SetHoldingOffsetAngle(Offset) end

---Set ICLS channel of carrier.
---
------
---@param Channel? number (Optional) ICLS channel. Default 1.
---@param MorseCode? string (Optional) Morse code identifier. Three letters, e.g. "STN". Default "STN".
---@return AIRBOSS #self
function AIRBOSS:SetICLS(Channel, MorseCode) end

---Disable automatic ICLS activation.
---
------
---@return AIRBOSS #self
function AIRBOSS:SetICLSoff() end

---Set max altitude to register flights in the initial zone.
---Aircraft above this altitude will not be registerered.
---
------
---@param MaxAltitude number Max altitude in feet. Default 1300 ft.
---@return AIRBOSS #self
function AIRBOSS:SetInitialMaxAlt(MaxAltitude) end

---Set if old into wind calculation is used when carrier turns into the wind for a recovery.
---
------
---@param SwitchOn boolean If `true` or `nil`, use old into wind calculation.
---@return AIRBOSS #self
function AIRBOSS:SetIntoWindLegacy(SwitchOn) end

---Set time interval between LSO calls.
---Optimal time in the groove is ~16 seconds. So the default of 4 seconds gives around 3-4 correction calls in the groove.
---
------
---@param TimeInterval number Time interval in seconds between LSO calls. Default 4 sec.
---@return AIRBOSS #self
function AIRBOSS:SetLSOCallInterval(TimeInterval) end

---Set LSO radio frequency and modulation.
---Default frequency is 264 MHz AM.
---
------
---@param Frequency? number (Optional) Frequency in MHz. Default 264 MHz.
---@param Modulation? string (Optional) Modulation, "AM" or "FM". Default "AM".
---@param Voice? string (Optional) SRS specific voice
---@param Gender? string (Optional) SRS specific gender
---@param Culture? string (Optional) SRS specific culture
---@return AIRBOSS #self
function AIRBOSS:SetLSORadio(Frequency, Modulation, Voice, Gender, Culture) end


---
------
---@param _max NOTYPE 
---@param _min NOTYPE 
---@param Left NOTYPE 
---@param LeftMed NOTYPE 
---@param LEFT NOTYPE 
---@param Right NOTYPE 
---@param RightMed NOTYPE 
---@param RIGHT NOTYPE 
function AIRBOSS:SetLineupErrorThresholds(_max, _min, Left, LeftMed, LEFT, Right, RightMed, RIGHT) end

---Set multiplayer environment wire correction.
---
------
---@param Dcorr number Correction distance in meters. Default 12 m.
---@return AIRBOSS #self
function AIRBOSS:SetMPWireCorrection(Dcorr) end

---Set the magnetic declination (or variation).
---By default this is set to the standard declination of the map.
---
------
---@param declination number Declination in degrees or nil for default declination of the map.
---@return AIRBOSS #self
function AIRBOSS:SetMagneticDeclination(declination) end

---Set Marshal radio frequency and modulation.
---Default frequency is 305 MHz AM.
---
------
---@param Frequency? number (Optional) Frequency in MHz. Default 305 MHz.
---@param Modulation? string (Optional) Modulation, "AM" or "FM". Default "AM".
---@param Voice? string (Optional) SRS specific voice
---@param Gender? string (Optional) SRS specific gender
---@param Culture? string (Optional) SRS specific culture
---@return AIRBOSS #self
function AIRBOSS:SetMarshalRadio(Frequency, Modulation, Voice, Gender, Culture) end

---Set Case I Marshal radius.
---This is the radius of the valid zone around "the post" aircraft are supposed to be holding in the Case I Marshal stack.
---The post is 2.5 NM port of the carrier.
---
------
---@param Radius number Radius in NM. Default 2.8 NM, which gives a diameter of 5.6 NM.
---@return AIRBOSS #self
function AIRBOSS:SetMarshalRadius(Radius) end

---Set max number of flights per stack.
---All members of a section count as one "flight".
---
------
---@param nmax number Number of max allowed flights per stack. Default is two. Minimum is one, maximum is 4.
---@return AIRBOSS #self
function AIRBOSS:SetMaxFlightsPerStack(nmax) end

---Set number of aircraft units, which can be in the landing pattern before the pattern is full.
---
------
---@param nmax number Max number. Default 4. Minimum is 1, maximum is 6.
---@return AIRBOSS #self
function AIRBOSS:SetMaxLandingPattern(nmax) end

---Set number available Case I Marshal stacks.
---If Marshal stacks are full, flights requesting Marshal will be told to hold outside 10 NM zone until a stack becomes available again.
---Marshal stacks for Case II/III are unlimited.
---
------
---@param nmax number Max number of stacks available to players and AI flights. Default 3, i.e. angels 2, 3, 4. Minimum is 1.
---@return AIRBOSS #self
function AIRBOSS:SetMaxMarshalStacks(nmax) end

---Set maximum distance up to which section members are allowed (default: 100 meters).
---
------
---@param dmax number Max distance in meters (default 100 m). Minimum is 10 m, maximum is 5000 m.
---@return AIRBOSS #self
function AIRBOSS:SetMaxSectionDistance(dmax) end

---Set max number of section members.
---Minimum is one, i.e. the section lead itself. Maximum number is four. Default is two, i.e. the lead and one other human flight.
---
------
---@param nmax number Number of max allowed members including the lead itself. For example, Nmax=2 means a section lead plus one member.
---@return AIRBOSS #self
function AIRBOSS:SetMaxSectionSize(nmax) end

---Enable or disable F10 radio menu for marking zones via smoke or flares.
---
------
---@param Switch boolean If true or nil, menu is enabled. If false, menu is not available to players.
---@return AIRBOSS #self
function AIRBOSS:SetMenuMarkZones(Switch) end

---Enable F10 menu to manually start recoveries.
---
------
---@param Duration number Default duration of the recovery in minutes. Default 30 min.
---@param WindOnDeck number Default wind on deck in knots. Default 25 knots.
---@param Uturn boolean U-turn after recovery window closes on=true or off=false/nil. Default off.
---@param Offset number Relative Marshal radial in degrees for Case II/III recoveries. Default 30°.
---@return AIRBOSS #self
function AIRBOSS:SetMenuRecovery(Duration, WindOnDeck, Uturn, Offset) end

---Optimized F10 radio menu for a single carrier.
---The menu entries will be stored directly under F10 Other/Airboss/ and not F10 Other/Airboss/"Carrier Alias"/.
---**WARNING**: If you use this with two airboss objects/carriers, the radio menu will be screwed up!
---
------
---@param Switch boolean If true or nil single menu is enabled. If false, menu is for multiple carriers in the mission.
---@return AIRBOSS #self
function AIRBOSS:SetMenuSingleCarrier(Switch) end

---Enable or disable F10 radio menu for marking zones via smoke.
---
------
---@param Switch boolean If true or nil, menu is enabled. If false, menu is not available to players.
---@return AIRBOSS #self
function AIRBOSS:SetMenuSmokeZones(Switch) end

---Carrier patrols ad inifintum.
---If the last waypoint is reached, it will go to waypoint one and repeat its route.
---
------
---@param switch boolean If true or nil, patrol until the end of time. If false, go along the waypoints once and stop.
---@return AIRBOSS #self
function AIRBOSS:SetPatrolAdInfinitum(switch) end

---Set time interval for updating queues and other stuff.
---
------
---@param TimeInterval number Time interval in seconds. Default 30 sec.
---@return AIRBOSS #self
function AIRBOSS:SetQueueUpdateTime(TimeInterval) end

---Set unit acting as radio relay for the LSO radio.
---
------
---@param unitname string Name of the unit.
---@return AIRBOSS #self
function AIRBOSS:SetRadioRelayLSO(unitname) end

---Set unit acting as radio relay for the Marshal radio.
---
------
---@param unitname string Name of the unit.
---@return AIRBOSS #self
function AIRBOSS:SetRadioRelayMarshal(unitname) end

---Set unit name for sending radio messages.
---
------
---@param unitname string Name of the unit.
---@return AIRBOSS #self
function AIRBOSS:SetRadioUnitName(unitname) end

---Set the default recovery case.
---
------
---@param Case number Case of recovery. Either 1, 2 or 3. Default 1.
---@return AIRBOSS #self
function AIRBOSS:SetRecoveryCase(Case) end

---Define recovery tanker associated with the carrier.
---
------
---@param recoverytanker RECOVERYTANKER Recovery tanker object.
---@return AIRBOSS #self
function AIRBOSS:SetRecoveryTanker(recoverytanker) end

---Set time before carrier turns and recovery window opens.
---
------
---@param Interval number Time interval in seconds. Default 300 sec.
---@return AIRBOSS #self
function AIRBOSS:SetRecoveryTurnTime(Interval) end

---Give AI aircraft the refueling task if a recovery tanker is present or send them to the nearest divert airfield.
---
------
---@param LowFuelThreshold number Low fuel threshold in percent. AI will go refueling if their fuel level drops below this value. Default 10 %.
---@return AIRBOSS #self
function AIRBOSS:SetRefuelAI(LowFuelThreshold) end

---Respawn AI groups once they reach the CCA.
---Clears any attached airbases and allows making them land on the carrier via script.
---
------
---@param Switch boolean If true or nil, AI groups are respawned.
---@return AIRBOSS #self
function AIRBOSS:SetRespawnAI(Switch) end

---Set SRS voice for the pilot calls.
---
------
---@param Voice? string (Optional) SRS specific voice
---@param Gender? string (Optional) SRS specific gender
---@param Culture? string (Optional) SRS specific culture
---@return AIRBOSS #self
function AIRBOSS:SetSRSPilotVoice(Voice, Gender, Culture) end

---Set folder path where the airboss sound files are located **within you mission (miz) file**.
---The default path is "l10n/DEFAULT/" but sound files simply copied there will be removed by DCS the next time you save the mission.
---However, if you create a new folder inside the miz file, which contains the sounds, it will not be deleted and can be used.
---
------
---@param FolderPath string The path to the sound files, e.g. "Airboss Soundfiles/".
---@return AIRBOSS #self
function AIRBOSS:SetSoundfilesFolder(FolderPath) end

---Define a set of AI groups that are handled by the airboss.
---
------
---@param SetGroup SET_GROUP The set of AI groups which are handled by the airboss.
---@return AIRBOSS #self
function AIRBOSS:SetSquadronAI(SetGroup) end

---Specify weather the mission has set static or dynamic weather.
---
------
---@param Switch boolean If true or nil, mission uses static weather. If false, dynamic weather is used in this mission.
---@return AIRBOSS #self
function AIRBOSS:SetStaticWeather(Switch) end

---Set time interval for updating player status and other things.
---
------
---@param TimeInterval number Time interval in seconds. Default 0.5 sec.
---@return AIRBOSS #self
function AIRBOSS:SetStatusUpdateTime(TimeInterval) end

---Set TACAN channel of carrier and switches TACAN on.
---
------
---@param Channel? number (Optional) TACAN channel. Default 74.
---@param Mode? string (Optional) TACAN mode, i.e. "X" or "Y". Default "X".
---@param MorseCode? string (Optional) Morse code identifier. Three letters, e.g. "STN". Default "STN".
---@return AIRBOSS #self
function AIRBOSS:SetTACAN(Channel, Mode, MorseCode) end

---Disable automatic TACAN activation
---
------
---@return AIRBOSS #self
function AIRBOSS:SetTACANoff() end

---Enable saving of player's trap sheets and specify an optional directory path.
---
------
---@param Path? string (Optional) Path where to save the trap sheets.
---@param Prefix? string (Optional) Prefix for trap sheet files. File name will be saved as *prefix_aircrafttype-0001.csv*, *prefix_aircrafttype-0002.csv*, etc.
---@return AIRBOSS #self
function AIRBOSS:SetTrapSheet(Path, Prefix) end

---Use user sound output instead of radio transmission for messages.
---Might be handy if radio transmissions are broken.
---
------
---@return AIRBOSS #self
function AIRBOSS:SetUserSoundRadio() end

---Init voice over radio transmission call.
---
------
---@param radiocall AIRBOSS.RadioCall LSO or Marshal radio call object.
---@param duration number Duration of the voice over in seconds.
---@param subtitle? string (Optional) Subtitle to be displayed along with voice over.
---@param subduration? number (Optional) Duration how long the subtitle is displayed.
---@param filename? string (Optional) Name of the voice over sound file.
---@param suffix? string (Optional) Extention of file. Default ".ogg".
function AIRBOSS:SetVoiceOver(radiocall, duration, subtitle, subduration, filename, suffix) end

---Set parameters for LSO Voice overs by *funkyfranky*.
---
------
---@param mizfolder? string (Optional) Folder within miz file where the sound files are located.
function AIRBOSS:SetVoiceOversLSOByFF(mizfolder) end

---Set parameters for LSO Voice overs by *Raynor*.
---
------
---@param mizfolder? string (Optional) Folder within miz file where the sound files are located.
function AIRBOSS:SetVoiceOversLSOByRaynor(mizfolder) end

---Intit parameters for Marshal Voice overs by *funkyfranky*.
---
------
---@param mizfolder? string (Optional) Folder within miz file where the sound files are located.
function AIRBOSS:SetVoiceOversMarshalByFF(mizfolder) end

---Init parameters for Marshal Voice overs *Gabriella* by HighwaymanEd.
---
------
---@param mizfolder? string (Optional) Folder within miz file where the sound files are located.
function AIRBOSS:SetVoiceOversMarshalByGabriella(mizfolder) end

---Init parameters for Marshal Voice overs by *Raynor*.
---
------
---@param mizfolder? string (Optional) Folder within miz file where the sound files are located.
function AIRBOSS:SetVoiceOversMarshalByRaynor(mizfolder) end

---Set welcome messages for players.
---
------
---@param Switch boolean If true, display welcome message to player.
---@return AIRBOSS #self
function AIRBOSS:SetWelcomePlayers(Switch) end

---Player user sound to player if he is inside the CCA.
---
------
---@param playerData AIRBOSS.PlayerData Player data.
---@param radio AIRBOSS.Radio The radio used for transmission.
---@param call AIRBOSS.RadioCall Radio sound files and subtitles.
---@param loud boolean If true, play loud sound file version.
---@param delay number Delay in seconds, before the message is broadcasted.
function AIRBOSS:Sound2Player(playerData, radio, call, loud, delay) end

---Test LSO radio sounds.
---
------
---@param delay number Delay in seconds be sound check starts.
---@return AIRBOSS #self
function AIRBOSS:SoundCheckLSO(delay) end

---Test Marshal radio sounds.
---
------
---@param delay number Delay in seconds be sound check starts.
---@return AIRBOSS #self
function AIRBOSS:SoundCheckMarshal(delay) end

---Triggers the FSM event "Start" that starts the airboss.
---Initializes parameters and starts event handlers.
---
------
function AIRBOSS:Start() end

---Triggers the FSM event "Stop" that stops the airboss.
---Event handlers are stopped.
---
------
function AIRBOSS:Stop() end

---Abeam position.
---
------
---@param playerData AIRBOSS.PlayerData Player data table.
function AIRBOSS:_Abeam(playerData) end

---Pattern aborted.
---
------
---@param playerData AIRBOSS.PlayerData Player data.
---@param X number X distance player to carrier.
---@param Z number Z distance player to carrier.
---@param posData AIRBOSS.Checkpoint Checkpoint data.
---@param patternwo? boolean (Optional) Pattern wave off.
function AIRBOSS:_AbortPattern(playerData, X, Z, posData, patternwo) end

---Activate TACAN and ICLS beacons.
---
------
function AIRBOSS:_ActivateBeacons() end

---Add menu commands for player.
---
------
---@param _unitName string Name of player unit.
function AIRBOSS:_AddF10Commands(_unitName) end

---Add flight to pattern queue and set recoverd to false for all elements of the flight and its section members.
---
------
---@param Flight AIRBOSS.FlightGroup group of element.
---@param flight NOTYPE 
function AIRBOSS:_AddFlightToPatternQueue(Flight, flight) end

---Add a flight group to the Marshal queue at a specific stack.
---Flight is informed via message. This fixes the recovery case to the current case ops in progress self.case).
---
------
---@param flight AIRBOSS.FlightGroup Flight group.
---@param stack number Marshal stack. This (re-)sets the flag value.
function AIRBOSS:_AddMarshalGroup(flight, stack) end

---Append text to debriefing.
---
------
---@param playerData AIRBOSS.PlayerData Player data.
---@param hint string Debrief text of this step.
---@param step? string (Optional) Current step in the pattern. Default from playerData.
function AIRBOSS:_AddToDebrief(playerData, hint, step) end

---Evaluate player's altitude at checkpoint.
---
------
---@param playerData AIRBOSS.PlayerData Player data table.
---@param altopt number Optimal altitude in meters.
---@return string #Feedback text.
---@return string #Debriefing text.
---@return AIRBOSS.RadioCall #Radio call.
function AIRBOSS:_AltitudeCheck(playerData, altopt) end

---Score for correct AoA.
---
------
---@param playerData AIRBOSS.PlayerData Player data.
---@param optaoa number Optimal AoA.
---@return string #Feedback message text or easy and normal difficulty level or nil for hard.
---@return string #Debriefing text.
---@return AIRBOSS.RadioCall #Radio call.
function AIRBOSS:_AoACheck(playerData, optaoa) end

---Convert AoA from degrees to arbitrary units.
---
------
---@param playerData AIRBOSS.PlayerData Player data table.
---@param degrees number AoA in degrees.
---@return number #AoA in arbitrary units.
function AIRBOSS:_AoADeg2Units(playerData, degrees) end

---Convert AoA from arbitrary units to degrees.
---
------
---@param playerData AIRBOSS.PlayerData Player data table.
---@param aoaunits number AoA in arbitrary units.
---@return number #AoA in degrees.
function AIRBOSS:_AoAUnit2Deg(playerData, aoaunits) end

---Arc in turn for case II/III recoveries.
---
------
---@param playerData AIRBOSS.PlayerData Player data table.
function AIRBOSS:_ArcInTurn(playerData) end

---Arc out turn for case II/III recoveries.
---
------
---@param playerData AIRBOSS.PlayerData Player data table.
function AIRBOSS:_ArcOutTurn(playerData) end

---Provide info about player status on the fly.
---
------
---@param playerData AIRBOSS.PlayerData Player data.
function AIRBOSS:_AttitudeMonitor(playerData) end

---Bolter pattern.
---Sends player to abeam for Case I/II or Bullseye for Case III ops.
---
------
---@param playerData AIRBOSS.PlayerData Player data table.
function AIRBOSS:_BolterPattern(playerData) end

---Break.
---
------
---@param playerData AIRBOSS.PlayerData Player data table.
---@param part string Part of the break.
function AIRBOSS:_Break(playerData, part) end

---Break entry for case I/II recoveries.
---
------
---@param playerData AIRBOSS.PlayerData Player data table.
function AIRBOSS:_BreakEntry(playerData) end

---Intercept glide slop and follow ICLS, aka Bullseye for case III recovery.
---
------
---@param playerData AIRBOSS.PlayerData Player data table.
---@return boolean #If true, player is in bullseye zone.
function AIRBOSS:_Bullseye(playerData) end

---Check AI status.
---Pattern queue AI in the groove? Marshal queue AI arrived in holding zone?
---
------
function AIRBOSS:_CheckAIStatus() end

---Check if a player is within the right area.
---
------
---@param X number X distance player to carrier.
---@param Z number Z distance player to carrier.
---@param pos AIRBOSS.Checkpoint Position data limits.
---@return boolean #If true, approach should be aborted.
function AIRBOSS:_CheckAbort(X, Z, pos) end

---Check if carrier is turning.
---If turning started or stopped, we inform the players via radio message.
---
------
function AIRBOSS:_CheckCarrierTurning() end

---Check for possible collisions between two coordinates.
---
------
---@param coordto COORDINATE Coordinate to which the collision is check.
---@param coordfrom COORDINATE Coordinate from which the collision is check.
---@return boolean #If true, surface type ahead is not deep water.
---@return number #Max free distance in meters.
function AIRBOSS:_CheckCollisionCoord(coordto, coordfrom) end

---Check if player is in CASE II/III approach corridor.
---
------
---@param playerData AIRBOSS.PlayerData Player data table.
function AIRBOSS:_CheckCorridor(playerData) end

---Long downwind leg check.
---
------
---@param playerData AIRBOSS.PlayerData Player data table.
function AIRBOSS:_CheckForLongDownwind(playerData) end

---Check if other aircraft are currently on the landing runway.
---
------
---@param playerData AIRBOSS.PlayerData Player data.
---@return NOTYPE #boolean If true, we have a foul deck.
function AIRBOSS:_CheckFoulDeck(playerData) end

---Check Collision.
---
------
---@param fromcoord COORDINATE Coordinate from which the path to the next WP is calculated. Default current carrier position.
---@return boolean #If true, surface type ahead is not deep water.
function AIRBOSS:_CheckFreePathToNextWP(fromcoord) end

---Check limits for reaching next step.
---
------
---@param X number X position of player unit.
---@param Z number Z position of player unit.
---@param check AIRBOSS.Checkpoint Checkpoint.
---@return boolean #If true, checkpoint condition for next step was reached.
function AIRBOSS:_CheckLimits(X, Z, check) end

---Checks if a player is in the pattern queue and has missed a step in Case II/III approach.
---
------
---@param playerData AIRBOSS.PlayerData Player data.
function AIRBOSS:_CheckMissedStepOnEntry(playerData) end

---Check if heading or position of carrier have changed significantly.
---
------
function AIRBOSS:_CheckPatternUpdate() end

---Check if player in the landing pattern is too close to another aircarft in the pattern.
---
------
---@param player AIRBOSS.PlayerData Player data.
function AIRBOSS:_CheckPlayerPatternDistance(player) end

---Check current player status.
---
------
function AIRBOSS:_CheckPlayerStatus() end

---Check marshal and pattern queues.
---
------
function AIRBOSS:_CheckQueue() end

---Check radio queue for transmissions to be broadcasted.
---
------
---@param radioqueue table The radio queue.
---@param name string Name of the queue.
function AIRBOSS:_CheckRadioQueue(radioqueue, name) end

---Function called by DCS timer.
---Unused.
---
------
---@param time number Time.
function AIRBOSS._CheckRadioQueueT(param, time) end

---Check recovery times and start/stop recovery mode of aircraft.
---
------
function AIRBOSS:_CheckRecoveryTimes() end

---Check if all elements of a flight were recovered.
---This also checks potential section members.
---If so, flight is removed from the queue.
---
------
---@param flight AIRBOSS.FlightGroup Flight group to check.
---@return boolean #If true, all elements landed.
function AIRBOSS:_CheckSectionRecovered(flight) end

---LSO check if player needs to wave off.
---Wave off conditions are:
---
---* Glideslope error <1.2 or >1.8 degrees.
---* |Line up error| > 3 degrees.
---* AoA check but only for TOPGUN graduates.
---
------
---@param glideslopeError number Glideslope error in degrees.
---@param lineupError number Line up error in degrees.
---@param AoA number Angle of attack of player aircraft.
---@param playerData AIRBOSS.PlayerData Player data.
---@return boolean #If true, player should wave off!
function AIRBOSS:_CheckWaveOff(glideslopeError, lineupError, AoA, playerData) end

---Clear flight for landing.
---AI are removed from Marshal queue and the Marshal stack is collapsed.
---If next in line is an AI flight, this is done. If human player is next, we wait for "Commence" via F10 radio menu command.
---
------
---@param flight AIRBOSS.FlightGroup Flight to go to pattern.
function AIRBOSS:_ClearForLanding(flight) end

---Collapse marshal stack.
---
------
---@param flight AIRBOSS.FlightGroup Flight that left the marshal stack.
---@param nopattern boolean If true, flight does not go to pattern.
function AIRBOSS:_CollapseMarshalStack(flight, nopattern) end

---Commence approach.
---This step initializes the player data. Section members are also set to commence. Next step depends on recovery case:
---
---* Case 1: Initial
---* Case 2/3: Platform
---
------
---@param playerData AIRBOSS.PlayerData Player data.
---@param zonecheck boolean If true, zone is checked before player is released.
function AIRBOSS:_Commencing(playerData, zonecheck) end

---Aircraft commencing call (both for players and AI).
---
------
---@param modex string Tail number.
---@param unit NOTYPE 
---@return UNIT #Unit of player or nil.
function AIRBOSS:_CommencingCall(modex, unit) end

---Create a new flight group.
---Usually when a flight appears in the CCA.
---
------
---@param group GROUP Aircraft group.
---@return AIRBOSS.FlightGroup #Flight group.
function AIRBOSS:_CreateFlightGroup(group) end

---Debrief player and set next step.
---
------
---@param playerData AIRBOSS.PlayerData Player data.
function AIRBOSS:_Debrief(playerData) end

---Dirty up and level out at 1200 ft for case III recovery.
---
------
---@param playerData AIRBOSS.PlayerData Player data table.
function AIRBOSS:_DirtyUp(playerData) end

---Turn player's aircraft attitude display on or off.
---
------
---@param _unitname string Name of the player unit.
function AIRBOSS:_DisplayAttitude(_unitname) end

---Report information about carrier.
---
------
---@param _unitname string Name of the player unit.
function AIRBOSS:_DisplayCarrierInfo(_unitname) end

---Report weather conditions at the carrier location.
---Temperature, QFE pressure and wind data.
---
------
---@param _unitname string Name of the player unit.
function AIRBOSS:_DisplayCarrierWeather(_unitname) end

---Display last debriefing.
---
------
---@param _unitName string Name fo the player unit.
function AIRBOSS:_DisplayDebriefing(_unitName) end

---Display top 10 player scores.
---
------
---@param _unitName string Name fo the player unit.
function AIRBOSS:_DisplayPlayerGrades(_unitName) end

---Display player status.
---
------
---@param _unitName string Name of the player unit.
function AIRBOSS:_DisplayPlayerStatus(_unitName) end

---Display marshal or pattern queue.
---
------
---@param _unitname string Name of the player unit.
---@param qname string Name of the queue.
function AIRBOSS:_DisplayQueue(_unitname, qname) end

---Display top 10 player scores.
---
------
---@param _unitName string Name fo the player unit.
function AIRBOSS:_DisplayScoreBoard(_unitName) end

---Evaluate player's distance to the boat at checkpoint.
---
------
---@param playerData AIRBOSS.PlayerData Player data table.
---@param optdist number Optimal distance in meters.
---@return string #Feedback message text.
---@return string #Debriefing text.
---@return AIRBOSS.RadioCall #Distance radio call. Not implemented yet.
function AIRBOSS:_DistanceCheck(playerData, optdist) end

---Grade player time in the groove - from turning to final until touchdown.
---
---If time
---
---* < 9 seconds: No Grade "--"
---* 9-11 seconds: Fair "(OK)"
---* 12-21 seconds: OK (15-18 is ideal)
---* 22-24 seconds: Fair "(OK)
---* > 24 seconds: No Grade "--"
---
---If you manage to be between 16.4 and and 16.6 seconds, you will even get and okay underline "\_OK\_".
---No groove time for Harrier on LHA, LHD set to Tgroove Unicorn as starting point to allow possible _OK_ 5.0.
---
---If time in the AV-8B
---
---* < 55 seconds: Fast V/STOL
---* < 75 seconds: OK V/STOL
---* > 76 Seconds: SLOW V/STOL (Early hover stop selection)
---
---If you manage to be between 60.0 and 65.0 seconds in the AV-8B, you will even get and okay underline "\_OK\_"
---
------
---@param playerData AIRBOSS.PlayerData Player data table.
---@return string #LSO grade for time in groove, i.e. \_OK\_, OK, (OK), --.
function AIRBOSS:_EvalGrooveTime(playerData) end

---Turn to final.
---
------
---@param playerData AIRBOSS.PlayerData Player data table.
---@param nocheck boolean If true, player is not checked to be in the right position.
function AIRBOSS:_Final(playerData, nocheck) end

---Grade flight data.
---
------
---@param playerData AIRBOSS.PlayerData Player data.
---@param groovestep string Step in the groove.
---@param fdata AIRBOSS.GrooveData Flight data in the groove.
---@return string #LSO grade or empty string if flight data table is nil.
---@return number #Number of deviations from perfect flight path.
function AIRBOSS:_Flightdata2Text(playerData, groovestep, fdata) end

---Get short name of the grove step.
---
------
---@param step string Player step.
---@param n number Use -1 for previous or +1 for next. Default 0.
---@return string #Shortcut name "X", "RB", "IM", "AR", "IW".
function AIRBOSS:_GS(step, n) end

---Get aircraft nickname.
---
------
---@param actype string Aircraft type name.
---@return string #Aircraft nickname. E.g. "Hornet" for the F/A-18C or "Tomcat" For the F-14A.
function AIRBOSS:_GetACNickname(actype) end

---Get optimal aircraft AoA parameters..
---
------
---@param playerData AIRBOSS.PlayerData Player data table.
---@return AIRBOSS.AircraftAoA #AoA parameters for the given aircraft type.
function AIRBOSS:_GetAircraftAoA(playerData) end

---Get optimal aircraft flight parameters at checkpoint.
---
------
---@param playerData AIRBOSS.PlayerData Player data table.
---@param step string Pattern step.
---@return number #Altitude in meters or nil.
---@return number #Angle of Attack or nil.
---@return number #Distance to carrier in meters or nil.
---@return number #Speed in m/s or nil.
function AIRBOSS:_GetAircraftParameters(playerData, step) end

---Get altitude of aircraft wrt carrier deck.
---Should give zero when the aircraft touched down.
---
------
---@param unit UNIT Aircraft unit.
---@return number #Altitude in meters wrt carrier height.
function AIRBOSS:_GetAltCarrier(unit) end

---Convert altitude from meters to angels (thousands of feet).
---
------
---@param alt NOTYPE altitude in meters.
---@return number #Altitude in Anglels = thousands of feet using math.floor().
function AIRBOSS:_GetAngels(alt) end

---Calculate an estimate of the charlie time of the player based on how many other aircraft are in the marshal or pattern queue before him.
---
------
---@param flightgroup AIRBOSS.FlightGroup Flight data.
---@return number #Charlie (abs) time in seconds. Or nil, if stack<0 or no recovery window will open.
function AIRBOSS:_GetCharlieTime(flightgroup) end

---Get difference between to headings in degrees taking into accound the [0,360) periodocity.
---
------
---@param hdg1 number Heading one.
---@param hdg2 number Heading two.
---@return number #Difference between the two headings in degrees.
function AIRBOSS:_GetDeltaHeading(hdg1, hdg2) end

---Calculate distances between carrier and aircraft unit.
---
------
---@param unit UNIT Aircraft unit.
---@return number #Distance [m] in the direction of the orientation of the carrier.
---@return number #Distance [m] perpendicular to the orientation of the carrier.
---@return number #Distance [m] to the carrier.
---@return number #Angle [Deg] from carrier to plane. Phi=0 if the plane is directly behind the carrier, phi=90 if the plane is starboard, phi=180 if the plane is in front of the carrier.
function AIRBOSS:_GetDistances(unit) end

---Estimated the carrier position at some point in the future given the current waypoints and speeds.
---
------
---@return time #ETA abs. time in seconds.
function AIRBOSS:_GetETAatNextWP() end

---Get element in flight.
---
------
---@param unitname string Name of the unit.
---@return AIRBOSS.FlightElement #Element of the flight or nil.
---@return number #Element index or nil.
---@return AIRBOSS.FlightGroup #The Flight group or nil
function AIRBOSS:_GetFlightElement(unitname) end

---Get flight from group in a queue.
---
------
---@param group GROUP Group that will be removed from queue.
---@param queue table The queue from which the group will be removed.
---@return AIRBOSS.FlightGroup #Flight group or nil.
---@return number #Queue index or nil.
function AIRBOSS:_GetFlightFromGroupInQueue(group, queue) end

---Get section lead of a flight.
---
------
---@param flight AIRBOSS.FlightGroup 
---@return AIRBOSS.FlightGroup #The leader of the section. Could be the flight itself.
---@return boolean #If true, flight is lead.
function AIRBOSS:_GetFlightLead(flight) end

---Get number of (airborne) units in a flight.
---
------
---@param flight AIRBOSS.FlightGroup The flight group.
---@param onground boolean If true, include units on the ground. By default only airborne units are counted.
---@return number #Number of units in flight including section members.
---@return number #Number of units in flight excluding section members.
---@return number #Number of section members.
function AIRBOSS:_GetFlightUnits(flight, onground) end

---Get next free Marshal stack.
---Depending on AI/human and recovery case.
---
------
---@param ai boolean If true, get a free stack for an AI flight group.
---@param case number Recovery case. Default current (self) case in progress.
---@param empty boolean Return lowest stack that is completely empty.
---@return number #Lowest free stack available for the given case or nil if all Case I stacks are taken.
function AIRBOSS:_GetFreeStack(ai, case, empty) end

---Get next free Marshal stack.
---Depending on AI/human and recovery case.
---
------
---@param ai boolean If true, get a free stack for an AI flight group.
---@param case number Recovery case. Default current (self) case in progress.
---@param empty boolean Return lowest stack that is completely empty.
---@return number #Lowest free stack available for the given case or nil if all Case I stacks are taken.
function AIRBOSS:_GetFreeStack_Old(ai, case, empty) end

---Get fuel state in pounds.
---
------
---@param unit UNIT The unit for which the mass is determined.
---@return number #Fuel state in pounds.
function AIRBOSS:_GetFuelState(unit) end

---Get error margin depending on player skill.
---
---* Flight students: 10% and 20%
---* Naval Aviators: 5% and 10%
---* TOPGUN Graduates: 2.5% and 5%
---
------
---@param playerData AIRBOSS.PlayerData Player data table.
---@return number #Error margin for still being okay.
---@return number #Error margin for really sucking.
function AIRBOSS:_GetGoodBadScore(playerData) end

---Get groove data.
---
------
---@param playerData AIRBOSS.PlayerData Player data table.
---@return AIRBOSS.GrooveData #Groove data table.
function AIRBOSS:_GetGrooveData(playerData) end

---Get landing spot on Tarawa and others.
---
------
---@return COORDINATE #Primary landing spot coordinate.
function AIRBOSS:_GetLandingSpotCoordinate() end

---Get the lead flight group of a flight group.
---
------
---@param flight AIRBOSS.FlightGroup Flight group to check.
---@return AIRBOSS.FlightGroup #Flight group of the leader or flight itself if no other leader.
function AIRBOSS:_GetLeadFlight(flight) end

---Get marshal altitude and two positions of a counter-clockwise race track pattern.
---
------
---@param stack number Assigned stack number. Counting starts at one, i.e. stack=1 is the first stack.
---@param case number Recovery case. Default is self.case.
---@return number #Holding altitude in meters.
---@return COORDINATE #First race track coordinate.
---@return COORDINATE #Second race track coordinate.
function AIRBOSS:_GetMarshalAltitude(stack, case) end

---Get next marshal flight which is ready to enter the landing pattern.
---
------
---@return AIRBOSS.FlightGroup #Marshal flight next in line and ready to enter the pattern. Or nil if no flight is ready.
function AIRBOSS:_GetNextMarshalFight() end

---Get next waypoint of the carrier.
---
------
---@return COORDINATE #Coordinate of the next waypoint.
---@return number #Number of waypoint.
function AIRBOSS:_GetNextWaypoint() end

---Format text into SRS friendly string
---
------
---@param text string 
---@return string #text
function AIRBOSS:_GetNiceSRSText(text) end

---Get onboard number of player or client.
---
------
---@param group GROUP Aircraft group.
---@return string #Onboard number as string.
function AIRBOSS:_GetOnboardNumberPlayer(group) end

---Get onboard numbers of all units in a group.
---
------
---@param group GROUP Aircraft group.
---@param playeronly boolean If true, return the onboard number for player or client skill units.
---@return table #Table of onboard numbers.
function AIRBOSS:_GetOnboardNumbers(group, playeronly) end

---Get optimal landing position of the aircraft.
---Usually between second and third wire. In case of Tarawa, Canberrra, Juan Carlos and America we take the abeam landing spot 120 ft above and 21 ft abeam the 7.5 position, for the Juan Carlos I, HMS Invincible, and HMS Hermes and Invincible it is 120 ft above and 21 ft abeam the 5 position. For CASE III it is 120ft directly above the landing spot.
---
------
---@return COORDINATE #Optimal landing coordinate.
function AIRBOSS:_GetOptLandingCoordinate() end

---Get player data from group object.
---
------
---@param group GROUP Group in question.
---@return AIRBOSS.PlayerData #Player data or nil if not player with this name or unit exists.
function AIRBOSS:_GetPlayerDataGroup(group) end

---Get player data from unit object
---
------
---@param unit UNIT Unit in question.
---@return AIRBOSS.PlayerData #Player data or nil if not player with this name or unit exists.
function AIRBOSS:_GetPlayerDataUnit(unit) end

---Returns the unit of a player and the player name from the self.players table if it exists.
---
------
---@param _unitName string Name of the player unit.
---@return UNIT #Unit of player or nil.
---@return string #Name of player or nil.
function AIRBOSS:_GetPlayerUnit(_unitName) end

---Returns the unit of a player and the player name.
---If the unit does not belong to a player, nil is returned.
---
------
---@param _unitName string Name of the player unit.
---@return UNIT #Unit of player or nil.
---@return string #Name of the player or nil.
function AIRBOSS:_GetPlayerUnitAndName(_unitName) end

---Get number of groups and units in queue, which are alive and airborne.
---In units we count the section members as well.
---
------
---@param queue table The queue. Can be self.flights, self.Qmarshal or self.Qpattern.
---@param case? number (Optional) Only count flights, which are in a specific recovery case. Note that you can use case=23 for flights that are either in Case II or III. By default all groups/units regardless of case are counted.
---@return number #Total number of flight groups in queue.
---@return number #Total number of aircraft in queue since each flight group can contain multiple aircraft.
function AIRBOSS:_GetQueueInfo(queue, case) end

---Get unit from which we want to transmit a radio message.
---This has to be an aircraft for subtitles to work.
---
------
---@param radio AIRBOSS.Radio Airboss radio data.
---@return UNIT #Sending aircraft unit or nil if was not setup, is not an aircraft or is not alive.
function AIRBOSS:_GetRadioSender(radio) end

---Get relative heading of player wrt carrier.
---This is the angle between the direction/orientation vector of the carrier and the direction/orientation vector of the provided unit.
---Note that this is calculated in the X-Z plane, i.e. the altitude Y is not taken into account.
---
------
---@param unit UNIT Player unit.
---@param runway? boolean (Optional) If true, return relative heading of unit wrt to angled runway of the carrier.
---@return number #Relative heading in degrees. An angle of 0 means, unit fly parallel to carrier. An angle of + or - 90 degrees means, unit flies perpendicular to carrier.
function AIRBOSS:_GetRelativeHeading(unit, runway) end

---Get relative velocity of player unit wrt to carrier
---
------
---@param unit UNIT Player unit.
---@return number #Relative velocity in m/s.
function AIRBOSS:_GetRelativeVelocity(unit) end

---Get static weather of this mission from env.mission.weather.
---
------
---@param Clouds table table which has entries "thickness", "density", "base", "iprecptns".
---@param Visibility number distance in meters.
---@param Fog table table, which has entries "thickness", "visibility" or nil if fog is disabled in the mission.
---@param Dust number density or nil if dust is disabled in the mission.
function AIRBOSS:_GetStaticWeather(Clouds, Visibility, Fog, Dust) end

---Get "stern" coordinate.
---
------
---@return COORDINATE #Coordinate at the rundown of the carrier.
function AIRBOSS:_GetSternCoord() end

---Get time in the groove of player.
---
------
---@param playerData AIRBOSS.PlayerData Player data.
---@return number #Player's time in groove in seconds.
function AIRBOSS:_GetTimeInGroove(playerData) end

---Get Tower frequency of carrier.
---
------
function AIRBOSS:_GetTowerFrequency() end

---Get unit masses especially fuel from DCS descriptor values.
---
------
---@param unit UNIT The unit for which the mass is determined.
---@return number #Mass of fuel in kg.
---@return number #Empty weight of unit in kg.
---@return number #Max weight of unit in kg.
---@return number #Max cargo weight in kg.
function AIRBOSS:_GetUnitMasses(unit) end

---Get wire from landing position.
---
------
---@param Lcoord COORDINATE Landing position.
---@param dc number Distance correction. Shift the landing coord back if dc>0 and forward if dc<0.
---@return number #Trapped wire (1-4) or 99 if no wire was trapped.
function AIRBOSS:_GetWire(Lcoord, dc) end

---Get wire from draw argument.
---
------
---@param Lcoord COORDINATE Landing position.
---@return number #Trapped wire (1-4) or 99 if no wire was trapped.
function AIRBOSS:_GetWireFromDrawArg(Lcoord) end

---Allow for Clear to land call from LSO approaching abeam the landing spot if stable as per NATOPS 00-80T
---
------
---@return ZONE_POLYGON #Zone surrounding landing runway.
function AIRBOSS:_GetZoneAbeamLandingSpot() end

---Get arc in zone with radius 1 NM and DME 14 NM from the carrier.
---Radial depends on recovery case.
---
------
---@param case number Recovery case.
---@return ZONE_RADIUS #Arc in zone.
function AIRBOSS:_GetZoneArcIn(case) end

---Get arc out zone with radius 1 NM and DME 12 NM from the carrier.
---Radial depends on recovery case.
---
------
---@param case number Recovery case.
---@return ZONE_RADIUS #Arc in zone.
function AIRBOSS:_GetZoneArcOut(case) end

---Get Bullseye zone with radius 1 NM and DME 3 NM from the carrier.
---Radial depends on recovery case.
---
------
---@param case number Recovery case.
---@return ZONE_RADIUS #Arc in zone.
function AIRBOSS:_GetZoneBullseye(case) end

---Get zone of carrier.
---Carrier is approximated as rectangle.
---
------
---@return ZONE #Zone surrounding the carrier.
function AIRBOSS:_GetZoneCarrierBox() end

---Get zone where player are automatically commence when enter.
---
------
---@param case number Recovery case.
---@param stack number Stack for Case II/III as we commence from stack>=1.
---@return ZONE #Holding zone.
function AIRBOSS:_GetZoneCommence(case, stack) end

---Get approach corridor zone.
---Shape depends on recovery case.
---
------
---@param case number Recovery case.
---@param l number Length of the zone in NM. Default 31 (=21+10) NM.
---@return ZONE_POLYGON_BASE #Box zone.
function AIRBOSS:_GetZoneCorridor(case, l) end

---Get dirty up zone with radius 1 NM and DME 9 NM from the carrier.
---Radial depends on recovery case.
---
------
---@param case number Recovery case.
---@return ZONE_RADIUS #Dirty up zone.
function AIRBOSS:_GetZoneDirtyUp(case) end

---Get groove zone.
---
------
---@param l number Length of the groove in NM. Default 1.5 NM.
---@param w number Width of the groove in NM. Default 0.25 NM.
---@param b number Width of the beginning in NM. Default 0.10 NM.
---@return ZONE_POLYGON_BASE #Groove zone.
function AIRBOSS:_GetZoneGroove(l, w, b) end

---Get holding zone of player.
---
------
---@param case number Recovery case.
---@param stack number Marshal stack number.
---@return ZONE #Holding zone.
function AIRBOSS:_GetZoneHolding(case, stack) end

---Get Initial zone for Case I or II.
---
------
---@param case number Recovery Case.
---@return ZONE_POLYGON_BASE #Initial zone.
function AIRBOSS:_GetZoneInitial(case) end

---Get zone of the primary landing spot of the USS Tarawa.
---
------
---@return ZONE_POLYGON #Zone surrounding landing runway.
function AIRBOSS:_GetZoneLandingSpot() end

---Get lineup groove zone.
---
------
---@return ZONE_POLYGON_BASE #Lineup zone.
function AIRBOSS:_GetZoneLineup() end

---Get platform zone with radius 1 NM and DME 19 NM from the carrier.
---Radial depends on recovery case.
---
------
---@param case number Recovery case.
---@return ZONE_RADIUS #Circular platform zone.
function AIRBOSS:_GetZonePlatform(case) end

---Get zone of landing runway.
---
------
---@return ZONE_POLYGON #Zone surrounding landing runway.
function AIRBOSS:_GetZoneRunwayBox() end

---Get glide slope of aircraft unit.
---
------
---@param unit UNIT Aircraft unit.
---@param optangle? number (Optional) Return glide slope relative to this angle, i.e. the error from the optimal glide slope ~3.5 degrees.
---@return number #Glide slope angle in degrees measured from the deck of the carrier and third wire.
function AIRBOSS:_Glideslope(unit, optangle) end

---Get glide slope of aircraft unit.
---
------
---@param unit UNIT Aircraft unit.
---@param optangle? number (Optional) Return glide slope relative to this angle, i.e. the error from the optimal glide slope ~3.5 degrees.
---@return number #Glide slope angle in degrees measured from the deck of the carrier and third wire.
function AIRBOSS:_Glideslope2(unit, optangle) end

---In the groove.
---
------
---@param playerData AIRBOSS.PlayerData Player data table.
function AIRBOSS:_Groove(playerData) end

---Holding.
---
------
---@param playerData AIRBOSS.PlayerData Player data.
function AIRBOSS:_Holding(playerData) end

---Check if a group is in a queue.
---
------
---@param queue table The queue to check.
---@param group GROUP The group to be checked.
---@return boolean #If true, group is in the queue. False otherwise.
function AIRBOSS:_InQueue(queue, group) end

---Init parameters for LHA-6 America carrier.
---
------
function AIRBOSS:_InitAmerica() end

---Init parameters for L02 Canberra carrier.
---
------
function AIRBOSS:_InitCanberra() end

---Init parameters for Essec class carriers.
---
------
function AIRBOSS:_InitEssex() end

---Init parameters for Forrestal class super carriers.
---
------
function AIRBOSS:_InitForrestal() end

---Init parameters for R12 HMS Hermes carrier.
---
------
function AIRBOSS:_InitHermes() end

---Init parameters for R05 HMS Invincible carrier.
---
------
function AIRBOSS:_InitInvincible() end

---Init parameters for L61 Juan Carlos carrier.
---
------
function AIRBOSS:_InitJcarlos() end

---Init parameters for Nimitz class super carriers.
---
------
function AIRBOSS:_InitNimitz() end

---Initialize player data by (re-)setting parmeters to initial values.
---
------
---@param playerData AIRBOSS.PlayerData Player data.
---@param step? string (Optional) New player step. Default UNDEFINED.
---@return AIRBOSS.PlayerData #Initialized player data.
function AIRBOSS:_InitPlayer(playerData, step) end

---Init parameters for USS Stennis carrier.
---
------
function AIRBOSS:_InitStennis() end

---Init parameters for LHA-1 Tarawa carrier.
---
------
function AIRBOSS:_InitTarawa() end

---Init voice over radio transmission call.
---
------
function AIRBOSS:_InitVoiceOvers() end

---Initialize Mission Editor waypoints.
---
------
---@return AIRBOSS #self
function AIRBOSS:_InitWaypoints() end

---Start pattern when player enters the initial zone in case I/II recoveries.
---
------
---@param playerData AIRBOSS.PlayerData Player data table.
---@return boolean #True if player is in the initial zone.
function AIRBOSS:_Initial(playerData) end

---Check if aircraft is capable of landing on this aircraft carrier.
---
------
---@param unit UNIT Aircraft unit. (Will also work with groups as given parameter.)
---@return boolean #If true, aircraft can land on a carrier.
function AIRBOSS:_IsCarrierAircraft(unit) end

---Checks if a group has a human player.
---
------
---@param group GROUP Aircraft group.
---@return boolean #If true, human player inside group.
function AIRBOSS:_IsHuman(group) end

---Checks if a human player sits in the unit.
---
------
---@param unit UNIT Aircraft unit.
---@return boolean #If true, human player inside the unit.
function AIRBOSS:_IsHumanUnit(unit) end

---Check if text is an onboard number of a flight.
---
------
---@param text string Text to check.
---@return boolean #If true, text is an onboard number of a flight.
function AIRBOSS:_IsOnboard(text) end

---AI aircraft calls the ball.
---
------
---@param modex string Tail number.
---@param nickname string Aircraft nickname.
---@param fuelstate number Aircraft fuel state in thouthands of pounds.
function AIRBOSS:_LSOCallAircraftBall(modex, nickname, fuelstate) end

---LSO radio check.
---Will broadcase LSO message at given LSO frequency.
---
------
---@param _unitName string Name fo the player unit.
function AIRBOSS:_LSORadioCheck(_unitName) end

---LSO advice radio call.
---
------
---@param playerData AIRBOSS.PlayerData Player data table.
---@param glideslopeError number Error in degrees.
---@param lineupError number Error in degrees.
function AIRBOSS:_LSOadvice(playerData, glideslopeError, lineupError) end

---Grade approach.
---
------
---@param playerData AIRBOSS.PlayerData Player data table.
---@return string #LSO grade, i.g. _OK_, OK, (OK), --, etc.
---@return number #Points.
---@return string #LSO analysis of flight path.
function AIRBOSS:_LSOgrade(playerData) end

---Tell AI to land on the carrier.
---
------
---@param flight AIRBOSS.FlightGroup Flight group.
function AIRBOSS:_LandAI(flight) end

---Get line up of player wrt to carrier.
---
------
---@param unit UNIT Aircraft unit.
---@param runway boolean If true, include angled runway.
---@return number #Line up with runway heading in degrees. 0 degrees = perfect line up. +1 too far left. -1 too far right.
function AIRBOSS:_Lineup(unit, runway) end

---Mark CASE I or II/II zones by either smoke or flares.
---
------
---@param _unitName string Name of the player unit.
---@param flare boolean If true, flare the zone. If false, smoke the zone.
function AIRBOSS:_MarkCaseZones(_unitName, flare) end

---Mark current marshal zone of player by either smoke or flares.
---
------
---@param _unitName string Name of the player unit.
---@param flare boolean If true, flare the zone. If false, smoke the zone.
function AIRBOSS:_MarkMarshalZone(_unitName, flare) end

---Command AI flight to orbit at a specified position at a specified altitude with a specified speed.
---If flight is not in the Marshal queue yet, it is added. This fixes the recovery case.
---If the flight is not already holding in the Marshal stack, it is guided there first.
---
------
---@param flight AIRBOSS.FlightGroup Flight group.
---@param nstack number Stack number of group. Can also be the current stack if AI position needs to be updated wrt to changed carrier position.
---@param respawn boolean If true, respawn the flight otherwise update mission task with new waypoints.
function AIRBOSS:_MarshalAI(flight, nstack, respawn) end

---Compile a radio call when Marshal tells a flight the holding altitude.
---
------
---@param modex string Tail number.
---@param case number Recovery case.
---@param brc number Base recovery course.
---@param altitude number Holding altitude.
---@param charlie string Charlie Time estimate.
---@param qfe number Alitmeter inHg.
function AIRBOSS:_MarshalCallArrived(modex, case, brc, altitude, charlie, qfe) end

---Compile a radio call when Marshal tells a flight the holding altitude.
---
------
---@param hdg number Heading in degrees.
function AIRBOSS:_MarshalCallCarrierTurnTo(hdg) end

---Inform flight that he is cleared for recovery.
---
------
---@param modex string Tail number.
---@param case number Recovery case.
function AIRBOSS:_MarshalCallClearedForRecovery(modex, case) end

---AI is bingo and goes to the divert field.
---
------
---@param modex string Tail number.
---@param divertname string Name of the divert field.
function AIRBOSS:_MarshalCallGasAtDivert(modex, divertname) end

---AI is bingo and goes to the recovery tanker.
---
------
---@param modex string Tail number.
function AIRBOSS:_MarshalCallGasAtTanker(modex) end

---Inform everyone about new final bearing.
---
------
---@param FB number Final Bearing in degrees.
function AIRBOSS:_MarshalCallNewFinalBearing(FB) end

---Inform everyone that recovery is paused and will resume at a certain time.
---
------
---@param clock string Time.
function AIRBOSS:_MarshalCallRecoveryPausedResumedAt(clock) end

---Inform everyone that recovery is paused and will resume at a certain time.
---
------
function AIRBOSS:_MarshalCallRecoveryPausedUntilFurtherNotice() end

---Compile a radio call when Marshal tells a flight the holding altitude.
---
------
---@param case NOTYPE 
function AIRBOSS:_MarshalCallRecoveryStart(case) end

---Inform everyone that recovery ops are stopped and deck is closed.
---
------
---@param case number Recovery case.
function AIRBOSS:_MarshalCallRecoveryStopped(case) end

---Inform everyone that recovery is resumed after pause.
---
------
function AIRBOSS:_MarshalCallResumeRecovery() end

---Compile a radio call when Marshal tells a flight the holding altitude.
---
------
---@param modex string Tail number.
---@param nwaiting number Number of flights already waiting.
function AIRBOSS:_MarshalCallStackFull(modex, nwaiting) end

---Orbit at a specified position at a specified altitude with a specified speed.
---
------
---@param playerData AIRBOSS.PlayerData Player data.
---@param stack number The Marshal stack the player gets.
function AIRBOSS:_MarshalPlayer(playerData, stack) end

---Marshal radio check.
---Will broadcase Marshal message at given Marshal frequency.
---
------
---@param _unitName string Name fo the player unit.
function AIRBOSS:_MarshalRadioCheck(_unitName) end

---Aircraft request marshal (Inbound call both for players and AI).
---
------
---@param modex string Tail number.
---@param unit NOTYPE 
---@return UNIT #Unit of player or nil.
function AIRBOSS:_MarshallInboundCall(modex, unit) end

---Check if a call needs a subtitle because the complete voice overs are not available.
---
------
---@param call AIRBOSS.RadioCall Radio sound files and subtitles.
---@return boolean #If true, call needs a subtitle.
function AIRBOSS:_NeedsSubtitle(call) end

---Initialize player data after birth event of player unit.
---
------
---@param unitname string Name of the player unit.
---@return AIRBOSS.PlayerData #Player data.
function AIRBOSS:_NewPlayer(unitname) end

---Generate a new radio call (deepcopy) from an existing default call.
---
------
---@param call AIRBOSS.RadioCall Radio call to be enhanced.
---@param sender string Sender of the message. Default is the radio alias.
---@param subtitle string Subtitle of the message. Default from original radio call. Use "" for no subtitle.
---@param subduration number Time in seconds the subtitle is displayed. Default 10 seconds.
---@param modexreceiver string Onboard number of the receiver or nil.
---@param modexsender string Onboard number of the sender or nil.
function AIRBOSS:_NewRadioCall(call, sender, subtitle, subduration, modexreceiver, modexsender) end

---At the Ninety.
---
------
---@param playerData AIRBOSS.PlayerData Player data table.
function AIRBOSS:_Ninety(playerData) end

---Convert a number (as string) into a radio message.
---E.g. for board number or headings.
---
------
---@param radio AIRBOSS.Radio Radio used for transmission.
---@param number string Number string, e.g. "032" or "183".
---@param delay number Delay before transmission in seconds.
---@param interval number Interval between the next call.
---@param pilotcall boolean If true, use pilot sound files.
---@return number #Duration of the call in seconds.
function AIRBOSS:_Number2Radio(radio, number, delay, interval, pilotcall) end

---Convert a number (as string) into an outsound and play it to a player group.
---E.g. for board number or headings.
---
------
---@param playerData AIRBOSS.PlayerData Player data.
---@param sender string Who is sending the call, either "LSO" or "MARSHAL".
---@param number string Number string, e.g. "032" or "183".
---@param delay number Delay before transmission in seconds.
---@return number #Duration of the call in seconds.
function AIRBOSS:_Number2Sound(playerData, sender, number, delay) end

---Function called when a group is passing a waypoint.
---
------
---@param airboss AIRBOSS Airboss object.
---@param i number Waypoint number that has been reached.
---@param final number Final waypoint number.
function AIRBOSS._PassingWaypoint(group, airboss, i, final) end

---Find free path to the next waypoint.
---
------
function AIRBOSS:_Pathfinder() end

---Patrol carrier.
---
------
---@param n number Next waypoint number.
---@return AIRBOSS #self
function AIRBOSS:_PatrolRoute(n) end

---Platform at 5k ft for case II/III recoveries.
---Descent at 2000 ft/min.
---
------
---@param playerData AIRBOSS.PlayerData Player data table.
function AIRBOSS:_Platform(playerData) end

---Display hint to player.
---
------
---@param playerData AIRBOSS.PlayerData Player data table.
---@param delay number Delay before playing sound messages. Default 0 sec.
---@param soundoff boolean If true, don't play and sound hint.
function AIRBOSS:_PlayerHint(playerData, delay, soundoff) end

---Airboss event handler for event player leave unit.
---
------
---@param EventData EVENTDATA function AIRBOSS:OnEventPlayerLeaveUnit(EventData)
function AIRBOSS:_PlayerLeft(EventData) end

---Print holding queue.
---
------
---@param queue table Queue to print.
---@param name string Queue name.
function AIRBOSS:_PrintQueue(queue, name) end

---Get full file name for radio call.
---
------
---@param call AIRBOSS.RadioCall Radio sound files and subtitles.
---@param loud boolean Use loud version of file if available.
---@param channel string Radio channel alias "LSO" or "LSOCall", "MARSHAL" or "MarshalCall".
---@return string #The file name of the radio sound.
function AIRBOSS:_RadioFilename(call, loud, channel) end

---Create radio subtitle from radio call.
---
------
---@param radio AIRBOSS.Radio The radio used for transmission.
---@param call AIRBOSS.RadioCall Radio sound files and subtitles.
---@param loud boolean If true, append "!" else ".".
---@return string #Subtitle to be displayed.
function AIRBOSS:_RadioSubtitle(radio, call, loud) end

---Function called when a group has reached the holding zone.
---
------
---@param airboss AIRBOSS Airboss object.
---@param flight AIRBOSS.FlightGroup Flight group that has reached the holding zone.
function AIRBOSS._ReachedHoldingZone(group, airboss, flight) end

---Sets flag recovered=true for a flight element, which was successfully recovered (landed).
---
------
---@param unit UNIT The aircraft unit that was recovered.
---@return AIRBOSS.FlightGroup #Flight group of element.
function AIRBOSS:_RecoveredElement(unit) end

---Tell AI to refuel.
---Either at the recovery tanker or at the nearest divert airfield.
---
------
---@param flight AIRBOSS.FlightGroup Flight group.
function AIRBOSS:_RefuelAI(flight) end

---Remove dead flight groups from all queues.
---
------
---@param group GROUP Aircraft group.
---@return AIRBOSS.FlightGroup #Flight group.
function AIRBOSS:_RemoveDeadFlightGroups(group) end

---Remove a flight from Marshal, Pattern and Waiting queues.
---If flight is in Marhal queue, the above stack is collapsed.
---Also set player step to undefined if applicable or remove human flight if option *completely* is true.
---
------
---@param flight AIRBOSS.PlayerData The flight to be removed.
---@param completely boolean If true, also remove human flight from all flights table.
function AIRBOSS:_RemoveFlight(flight, completely) end

---Get element in flight.
---
------
---@param unitname string Name of the unit.
---@return boolean #If true, element could be removed or nil otherwise.
function AIRBOSS:_RemoveFlightElement(unitname) end

---Remove a flight group from the Marshal queue.
---Marshal stack is collapsed, too, if flight was in the queue. Waiting flights are send to marshal.
---
------
---@param flight AIRBOSS.FlightGroup Flight group that will be removed from queue.
---@param nopattern boolean If true, flight is NOT going to landing pattern.
---@return boolean #True, flight was removed or false otherwise.
---@return number #Table index of the flight in the Marshal queue.
function AIRBOSS:_RemoveFlightFromMarshalQueue(flight, nopattern) end

---Remove a flight group from a queue.
---
------
---@param queue table The queue from which the group will be removed.
---@param flight AIRBOSS.FlightGroup Flight group that will be removed from queue.
---@return boolean #True, flight was in Queue and removed. False otherwise.
---@return number #Table index of removed queue element or nil.
function AIRBOSS:_RemoveFlightFromQueue(queue, flight) end

---Remove a flight, which is a member of a section, from this section.
---
------
---@param flight AIRBOSS.FlightGroup The flight to be removed from the section
function AIRBOSS:_RemoveFlightFromSection(flight) end

---Remove a member from the player's section.
---
------
---@param playerData AIRBOSS.PlayerData Player
---@param sectionmember AIRBOSS.PlayerData The section member to be removed.
---@return boolean #If true, flight was a section member and could be removed. False otherwise.
function AIRBOSS:_RemoveSectionMember(playerData, sectionmember) end

---Remove a unit and its element from a flight group (e.g.
---when landed) and update all queues if the whole flight group is gone.
---
------
---@param unit UNIT The unit to be removed.
function AIRBOSS:_RemoveUnitFromFlight(unit) end

---Request to commence landing approach.
---
------
---@param _unitName string Name fo the player unit.
function AIRBOSS:_RequestCommence(_unitName) end

---Request emergency landing.
---
------
---@param _unitName string Name fo the player unit.
function AIRBOSS:_RequestEmergency(_unitName) end

---Request marshal.
---
------
---@param _unitName string Name fo the player unit.
function AIRBOSS:_RequestMarshal(_unitName) end

---Player requests refueling.
---
------
---@param _unitName string Name of the player unit.
function AIRBOSS:_RequestRefueling(_unitName) end

---Request spinning.
---
------
---@param _unitName string Name fo the player unit.
function AIRBOSS:_RequestSpinning(_unitName) end

---Reset player status.
---Player is removed from all queues and its status is set to undefined.
---
------
---@param _unitName string Name fo the player unit.
function AIRBOSS:_ResetPlayerStatus(_unitName) end

---Carrier Strike Group resumes the route of the waypoints defined in the mission editor.
---
------
---@param airboss AIRBOSS Airboss object.
---@param gotocoord COORDINATE Go to coordinate before route is resumed.
function AIRBOSS._ResumeRoute(group, airboss, gotocoord) end

---Save trapsheet data.
---
------
---@param playerData AIRBOSS.PlayerData Player data table.
---@param grade AIRBOSS.LSOgrade LSO grad data.
function AIRBOSS:_SaveTrapSheet(playerData, grade) end

---Scan carrier zone for (new) units.
---
------
function AIRBOSS:_ScanCarrierZone() end

---Set difficulty level.
---
------
---@param _unitname string Name of the player unit.
---@param difficulty AIRBOSS.Difficulty Difficulty level.
function AIRBOSS:_SetDifficulty(_unitname, difficulty) end

---Turn player's aircraft attitude display on or off.
---
------
---@param _unitname string Name of the player unit.
function AIRBOSS:_SetHintsOnOff(_unitname) end

---Set player step.
---Any warning is erased and next step hint shown.
---
------
---@param playerData AIRBOSS.PlayerData Player data.
---@param step string Next step.
---@param delay? number (Optional) Set set after a delay in seconds.
function AIRBOSS:_SetPlayerStep(playerData, step, delay) end

---Set all flights within maxsectiondistance meters to be part of my section (default: 100 meters).
---
------
---@param _unitName string Name of the player unit.
function AIRBOSS:_SetSection(_unitName) end

---Set time in the groove for player.
---
------
---@param playerData AIRBOSS.PlayerData Player data.
function AIRBOSS:_SetTimeInGroove(playerData) end

---Skipper set recovery offset angle.
---
------
---@param _unitName string Name fo the player unit.
---@param offset number Recovery holding offset angle in degrees for Case II/III.
function AIRBOSS:_SkipperRecoveryOffset(_unitName, offset) end

---Skipper set recovery speed.
---
------
---@param _unitName string Name fo the player unit.
---@param speed number Recovery speed in knots.
function AIRBOSS:_SkipperRecoverySpeed(_unitName, speed) end

---Skipper set recovery time.
---
------
---@param _unitName string Name fo the player unit.
---@param time number Recovery time in minutes.
function AIRBOSS:_SkipperRecoveryTime(_unitName, time) end

---Skipper set recovery speed.
---
------
---@param _unitName string Name fo the player unit.
function AIRBOSS:_SkipperRecoveryUturn(_unitName) end

---Reset player status.
---Player is removed from all queues and its status is set to undefined.
---
------
---@param _unitName string Name fo the player unit.
---@param case number Recovery case.
function AIRBOSS:_SkipperStartRecovery(_unitName, case) end

---Skipper Stop recovery function.
---
------
---@param _unitName string Name fo the player unit.
function AIRBOSS:_SkipperStopRecovery(_unitName) end

---Evaluate player's speed.
---
------
---@param playerData AIRBOSS.PlayerData Player data table.
---@param speedopt number Optimal speed in m/s.
---@return string #Feedback text.
---@return string #Debriefing text.
---@return AIRBOSS.RadioCall #Radio call.
function AIRBOSS:_SpeedCheck(playerData, speedopt) end

---Spinning
---
------
---@param playerData AIRBOSS.PlayerData Player data.
function AIRBOSS:_Spinning(playerData) end

---Check AI status.
---Pattern queue AI in the groove? Marshal queue AI arrived in holding zone?
---
------
function AIRBOSS:_Status() end

---Display hint for flight students about the (next) step.
---Message is displayed after one second.
---
------
---@param playerData AIRBOSS.PlayerData Player data.
---@param step string Step for which hint is given.
function AIRBOSS:_StepHint(playerData, step) end

---Turn radio subtitles of player on or off.
---
------
---@param _unitname string Name of the player unit.
function AIRBOSS:_SubtitlesOnOff(_unitname) end

---Function called when a group should be send to the Marshal stack.
---If stack is full, it is send to wait.
---
------
---@param airboss AIRBOSS Airboss object.
---@param flight AIRBOSS.FlightGroup Flight group that has reached the holding zone.
function AIRBOSS._TaskFunctionMarshalAI(group, airboss, flight) end

---Generate a text if a player is too far from where he should be.
---
------
---@param X number X distance player to carrier.
---@param Z number Z distance player to carrier.
---@param posData AIRBOSS.Checkpoint Checkpoint data.
function AIRBOSS:_TooFarOutText(X, Z, posData) end

---Trapped?
---Check if in air or not after landing event.
---
------
---@param playerData AIRBOSS.PlayerData Player data table.
function AIRBOSS:_Trapped(playerData) end

---Turn radio subtitles of player on or off.
---
------
---@param _unitname string Name of the player unit.
function AIRBOSS:_TrapsheetOnOff(_unitname) end

---Update section if a flight is removed.
---If removed flight is member of a section, he is removed for the leaders section.
---If removed flight is the section lead, we try to find a new leader.
---
------
---@param flight AIRBOSS.FlightGroup The flight to be removed.
function AIRBOSS:_UpdateFlightSection(flight) end

---Command AI flight to orbit outside the 10 NM zone and wait for a free Marshal stack.
---If the flight is not already holding in the Marshal stack, it is guided there first.
---
------
---@param flight AIRBOSS.FlightGroup Flight group.
---@param respawn boolean If true respawn the group. Otherwise reset the mission task with new waypoints.
function AIRBOSS:_WaitAI(flight, respawn) end

---Tell player to wait outside the 10 NM zone until a Marshal stack is available.
---
------
---@param playerData AIRBOSS.PlayerData Player data.
function AIRBOSS:_WaitPlayer(playerData) end

---Waiting outside 10 NM zone for free Marshal stack.
---
------
---@param playerData AIRBOSS.PlayerData Player data.
function AIRBOSS:_Waiting(playerData) end

---At the Wake.
---
------
---@param playerData AIRBOSS.PlayerData Player data table.
function AIRBOSS:_Wake(playerData) end

---Triggers the FSM delayed event "Idle" that puts the carrier into state "Idle" where no recoveries are carried out.
---
------
---@param delay number Delay in seconds.
function AIRBOSS:__Idle(delay) end

---Triggers the FSM event "LSOGrade".
---Delayed called when the LSO grades a player.
---
------
---@param delay number Delay in seconds.
---@param playerData AIRBOSS.PlayerData Player Data.
---@param grade AIRBOSS.LSOgrade LSO grade.
function AIRBOSS:__LSOGrade(delay, playerData, grade) end

---Triggers the FSM delayed event "Load" that loads the player scores from a file.
---AIRBOSS FSM must **not** be started at this point.
---
------
---@param delay number Delay in seconds.
---@param path string Path where the file is located. Default is the DCS installation root directory or your "Saved Games\DCS" folder if lfs was desanitized.
---@param filename? string (Optional) File name. Default is AIRBOSS-*ALIAS*_LSOgrades.csv.
function AIRBOSS:__Load(delay, path, filename) end

---Triggers the FSM event "Marshal".
---Delayed call when a flight is send to the Marshal stack.
---
------
---@param delay number Delay in seconds.
---@param flight AIRBOSS.FlightGroup The flight group data.
function AIRBOSS:__Marshal(delay, flight) end

---Triggers the FSM delayed event "PassingWaypoint".
---Called when the carrier passes a waypoint.
---
------
---@param delay number Delay in seconds.
---@param Case number Recovery case (1, 2 or 3) that is started.
---@param Offset number Holding pattern offset angle in degrees for CASE II/III recoveries.
function AIRBOSS:__PassingWaypoint(delay, Case, Offset) end

---Triggers the delayed FSM event "RecoveryCase" that sets the used aircraft recovery case.
---
------
---@param delay number Delay in seconds.
---@param Case number The new recovery case (1, 2 or 3).
---@param Offset number Holding pattern offset angle in degrees for CASE II/III recoveries.
function AIRBOSS:__RecoveryCase(delay, Case, Offset) end

---Triggers the FSM delayed event "RecoveryPause" that pauses the recovery of aircraft.
---
------
---@param delay number Delay in seconds.
---@param duration number Duration of pause in seconds. After that recovery is automatically resumed.
function AIRBOSS:__RecoveryPause(delay, duration) end

---Triggers the FSM delayed event "RecoveryStart" that starts the recovery of aircraft.
---Marshalling aircraft are send to the landing pattern.
---
------
---@param delay number Delay in seconds.
---@param Case number Recovery case (1, 2 or 3) that is started.
---@param Offset number Holding pattern offset angle in degrees for CASE II/III recoveries.
function AIRBOSS:__RecoveryStart(delay, Case, Offset) end

---Triggers the FSM delayed event "RecoveryStop" that stops the recovery of aircraft.
---
------
---@param delay number Delay in seconds.
function AIRBOSS:__RecoveryStop(delay) end

---Triggers the FSM delayed event "RecoveryUnpause" that resumes the recovery of aircraft if it was paused.
---
------
---@param delay number Delay in seconds.
function AIRBOSS:__RecoveryUnpause(delay) end

---Triggers the FSM delayed event "Save" that saved the player scores to a file.
---
------
---@param delay number Delay in seconds.
---@param path string Path where the file is saved. Default is the DCS installation root directory or your "Saved Games\DCS" folder if lfs was desanitized.
---@param filename? string (Optional) File name. Default is AIRBOSS-*ALIAS*_LSOgrades.csv.
function AIRBOSS:__Save(delay, path, filename) end

---Triggers the FSM event "Start" that starts the airboss after a delay.
---Initializes parameters and starts event handlers.
---
------
---@param delay number Delay in seconds.
function AIRBOSS:__Start(delay) end

---Triggers the FSM event "Stop" that stops the airboss after a delay.
---Event handlers are stopped.
---
------
---@param delay number Delay in seconds.
function AIRBOSS:__Stop(delay) end

---On after "Idle" event.
---Carrier goes to state "Idle".
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function AIRBOSS:onafterIdle(From, Event, To) end

---On after "LSOGrade" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param playerData AIRBOSS.PlayerData Player Data.
---@param grade AIRBOSS.LSOgrade LSO grade.
---@private
function AIRBOSS:onafterLSOGrade(From, Event, To, playerData, grade) end

---On after "Load" event.
---Loads grades of all players from file.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param path string Path where the file is loaded from. Default is the DCS root installation folder or your "Saved Games\\DCS" folder if lfs was desanizied.
---@param filename? string (Optional) File name for saving the player grades. Default is "AIRBOSS-<ALIAS>_LSOgrades.csv".
---@private
function AIRBOSS:onafterLoad(From, Event, To, path, filename) end

---On after "PassingWaypoint" event.
---Carrier has just passed a waypoint
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param n number Number of waypoint that was passed.
---@private
function AIRBOSS:onafterPassingWaypoint(From, Event, To, n) end

---On after "RecoveryCase" event.
---Sets new aircraft recovery case. Updates
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Case number The recovery case (1, 2 or 3) to switch to.
---@param Offset number Holding pattern offset angle in degrees for CASE II/III recoveries.
---@private
function AIRBOSS:onafterRecoveryCase(From, Event, To, Case, Offset) end

---On after "RecoveryPause" event.
---Recovery of aircraft is paused. Marshal queue stays intact.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param duration number Duration of pause in seconds. After that recovery is resumed automatically.
---@private
function AIRBOSS:onafterRecoveryPause(From, Event, To, duration) end

---On after "RecoveryStart" event.
---Recovery of aircraft is started and carrier switches to state "Recovering".
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Case number The recovery case (1, 2 or 3) to start.
---@param Offset number Holding pattern offset angle in degrees for CASE II/III recoveries.
---@private
function AIRBOSS:onafterRecoveryStart(From, Event, To, Case, Offset) end

---On after "RecoveryStop" event.
---Recovery of aircraft is stopped and carrier switches to state "Idle". Running recovery window is deleted.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function AIRBOSS:onafterRecoveryStop(From, Event, To) end

---On after "RecoveryUnpause" event.
---Recovery of aircraft is resumed.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function AIRBOSS:onafterRecoveryUnpause(From, Event, To) end

---On after "Save" event.
---Player data is saved to file.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param path string Path where the file is saved. If nil, file is saved in the DCS root installtion directory or your "Saved Games" folder if lfs was desanitized.
---@param filename? string (Optional) File name for saving the player grades. Default is "AIRBOSS-<ALIAS>_LSOgrades.csv".
---@private
function AIRBOSS:onafterSave(From, Event, To, path, filename) end

---On after Start event.
---Starts the AIRBOSS. Adds event handlers and schedules status updates of requests and queue.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function AIRBOSS:onafterStart(From, Event, To) end

---On after Status event.
---Checks for new flights, updates queue and checks player status.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function AIRBOSS:onafterStatus(From, Event, To) end

---On after Stop event.
---Unhandle events.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function AIRBOSS:onafterStop(From, Event, To) end

---On before "Load" event.
---Checks if the file that the player grades from exists.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param path? string (Optional) Path where the file is loaded from. Default is the DCS installation root directory or your "Saved Games\\DCS" folder if lfs was desanizized.
---@param filename? string (Optional) File name for saving the player grades. Default is "AIRBOSS-<ALIAS>_LSOgrades.csv".
---@private
function AIRBOSS:onbeforeLoad(From, Event, To, path, filename) end

---On before "RecoveryCase" event.
---Check if case or holding offset did change. If not transition is denied.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Case number The recovery case (1, 2 or 3) to switch to.
---@param Offset number Holding pattern offset angle in degrees for CASE II/III recoveries.
---@private
function AIRBOSS:onbeforeRecoveryCase(From, Event, To, Case, Offset) end

---On before "Save" event.
---Checks if io and lfs are available.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param path? string (Optional) Path where the file is saved. Default is the DCS root installation folder or your "Saved Games\\DCS" folder if the lfs module is desanitized.
---@param filename? string (Optional) File name for saving the player grades. Default is "AIRBOSS-<ALIAS>_LSOgrades.csv".
---@private
function AIRBOSS:onbeforeSave(From, Event, To, path, filename) end


---Aircraft specific Angle of Attack (AoA) (or alpha) parameters.
---@class AIRBOSS.AircraftAoA 
---@field FAST number Really fast AoA threshold.
---@field Fast number Fast AoA threshold. Smaller means faster.
---@field OnSpeed number Optimal on-speed AoA.
---@field OnSpeedMax number Maximum on speed AoA. Values above are slow.
---@field OnSpeedMin number Minimum on speed AoA. Values below are fast
---@field SLOW number Really slow AoA threshold.
---@field Slow number Slow AoA threshold. Larger means slower.
AIRBOSS.AircraftAoA = {}


---Aircraft types capable of landing on carrier (human+AI).
---@class AIRBOSS.AircraftCarrier 
---@field A4EC string A-4E Community mod.
---@field AV8B string AV-8B Night Harrier. Works only with the HMS Hermes, HMS Invincible, USS Tarawa, USS America, and Juan Carlos I.
---@field C2A string Grumman C-2A Greyhound from Military Aircraft Mod.
---@field CORSAIR string F4U-1D Corsair.
---@field CORSAIR_CW string F4U-1D Corsair Mk.4 (clipped wing).
---@field E2D string Grumman E-2D Hawkeye AWACS.
---@field F14A string F-14A by Heatblur.
---@field F14A_AI string F-14A Tomcat (AI).
---@field F14B string F-14B by Heatblur.
---@field FA18C string F/A-18C Hornet (AI).
---@field GROWLER string FEA-18G Superhornet (mod).
---@field HORNET string F/A-18C Lot 20 Hornet by Eagle Dynamics.
---@field RHINOE string F/A-18E Superhornet (mod).
---@field RHINOF string F/A-18F Superhornet (mod).
---@field S3B string Lockheed S-3B Viking.
---@field S3BTANKER string Lockheed S-3B Viking tanker.
---@field T45C string T-45C by VNAO.
AIRBOSS.AircraftCarrier = {}


---Carrier specific parameters.
---@class AIRBOSS.CarrierParameters 
---@field private deckheight number Height of deck in meters. For USS Stennis ~63 ft = 19 meters.
---@field private landingdist number Distance in meeters to the landing position.
---@field private landingspot number 
---@field private rwyangle number Runway angle in degrees. for carriers with angled deck. For USS Stennis -9 degrees.
---@field private rwylength number Length of the landing runway in meters.
---@field private rwywidth number Width of the landing runway in meters.
---@field private sterndist number Distance in meters from carrier position to stern of carrier. For USS Stennis -150 meters.
---@field private totlength number Total length of carrier.
---@field private totwidthport number Total with of the carrier from stern position to port side (asymmetric carriers).
---@field private totwidthstarboard number Total with of the carrier from stern position to starboard side (asymmetric carriers).
---@field private wire1 number Distance in meters from carrier position to first wire.
---@field private wire10 number 
---@field private wire11 number 
---@field private wire12 number 
---@field private wire13 number 
---@field private wire14 number 
---@field private wire15 number 
---@field private wire2 number Distance in meters from carrier position to second wire.
---@field private wire3 number Distance in meters from carrier position to third wire.
---@field private wire4 number Distance in meters from carrier position to fourth wire.
---@field private wire5 number 
---@field private wire6 number 
---@field private wire7 number 
---@field private wire8 number 
---@field private wire9 number 
AIRBOSS.CarrierParameters = {}


---Carrier types.
---@class AIRBOSS.CarrierType 
---@field AMERICA string USS America (LHA-6) [V/STOL Carrier]
---@field CANBERRA string 
---@field ESSEX string Essex class carrier (e.g. USS Yorktown (CV-10)) [Magnitude 3 Carrier Module]
---@field FORRESTAL string USS Forrestal (CV-59) [Heatblur Carrier Module]
---@field HERMES string HMS Hermes (R12) [V/STOL Carrier]
---@field HMAS string Canberra (L02) [V/STOL Carrier]
---@field INVINCIBLE string HMS Invincible (R05) [V/STOL Carrier]
---@field JCARLOS string Juan Carlos I (L61) [V/STOL Carrier]
---@field KUZNETSOV string Admiral Kuznetsov (CV 1143.5)
---@field LINCOLN string USS Abraham Lincoln (CVN-72) [Super Carrier Module]
---@field ROOSEVELT string USS Theodore Roosevelt (CVN-71) [Super Carrier Module]
---@field STENNIS string USS John C. Stennis (CVN-74)
---@field TARAWA string USS Tarawa (LHA-1) [V/STOL Carrier]
---@field TRUMAN string USS Harry S. Truman (CVN-75) [Super Carrier Module]
---@field VINSON string USS Carl Vinson (CVN-70) [Deprecated!]
---@field WASHINGTON string USS George Washington (CVN-73) [Super Carrier Module]
AIRBOSS.CarrierType = {}


---Checkpoint parameters triggering the next step in the pattern.
---@class AIRBOSS.Checkpoint 
---@field LimitXmax number Latitudal threshold for triggering the next step if X>Xmax.
---@field LimitXmin number Latitudal threshold for triggering the next step if X<Xmin.
---@field LimitZmax number Latitudal threshold for triggering the next step if Z>Zmax.
---@field LimitZmin number Latitudal threshold for triggering the next step if Z<Zmin.
---@field Xmax number Maximum allowed longitual distance to carrier.
---@field Xmin number Minimum allowed longitual distance to carrier.
---@field Zmax number Maximum allowed latitudal distance to carrier.
---@field Zmin number Minimum allowed latitudal distance to carrier.
---@field private name string Name of checkpoint.
AIRBOSS.Checkpoint = {}


---Difficulty level.
---@class AIRBOSS.Difficulty 
---@field EASY string Flight Student. Shows tips and hints in important phases of the approach.
---@field HARD string TOPGUN graduate. For people who know what they are doing. Nearly *ziplip*.
---@field NORMAL string Naval aviator. Moderate number of hints but not really zip lip.
AIRBOSS.Difficulty = {}


---Parameters of an element in a flight group.
---@class AIRBOSS.FlightElement 
---@field private ai boolean If true, AI sits inside. If false, human player is flying.
---@field private ballcall boolean If true, flight called the ball in the groove.
---@field private onboard string Onboard number of the aircraft.
---@field private recovered boolean If true, element was successfully recovered.
---@field private unit UNIT Aircraft unit.
---@field private unitname string Name of the unit.
AIRBOSS.FlightElement = {}


---Parameters of a flight group.
---@class AIRBOSS.FlightGroup 
---@field Tcharlie number Charlie (abs) time in seconds.
---@field private actype string Aircraft type name.
---@field private ai boolean If true, flight is purly AI.
---@field private ballcall boolean If true, flight called the ball in the groove.
---@field private case number Recovery case of flight.
---@field private dist0 number Distance to carrier in meters when the group was first detected inside the CCA.
---@field private elements table Flight group elements.
---@field private flag number Flag value describing the current stack.
---@field private group GROUP Flight group.
---@field private groupname string Name of the group.
---@field private holding boolean If true, flight is in holding zone.
---@field private name string Player name or name of first AI unit.
---@field private nunits number Number of units in group.
---@field private onboard string Onboard number of player or first unit in group.
---@field private onboardnumbers table Onboard numbers of aircraft in the group.
---@field private recovered boolean 
---@field private refueling boolean Flight is refueling.
---@field private seclead string Name of section lead.
---@field private section table Other human flight groups belonging to this flight. This flight is the lead.
---@field private time number Timestamp in seconds of timer.getAbsTime() of the last important event, e.g. added to the queue.
AIRBOSS.FlightGroup = {}


---Glideslope error thresholds in degrees.
---@class AIRBOSS.GLE 
---@field HIGH number  H  threshold. Default 1.5 deg.
---@field High number (H) threshold. Default 0.8 deg.
---@field LOW number   L  threshold. Default -0.9 deg.
---@field Low number  (L) threshold. Default -0.6 deg.
---@field _max number Max _OK_ value. Default 0.4 deg.
---@field _min number Min _OK_ value. Default -0.3 deg.
AIRBOSS.GLE = {}


---Groove data.
---@class AIRBOSS.GrooveData 
---@field Alt number Altitude in meters.
---@field AoA number Angle of Attack.
---@field Drift string 
---@field FlyThrough string Fly through up "/" or fly through down "\\".
---@field GSE number Glideslope error in degrees.
---@field Gamma number Relative heading player to carrier's runway. 0=parallel, +-90=perpendicular.
---@field Grade string LSO grade.
---@field GradeDetail string LSO grade details.
---@field GradePoints number LSO grade points
---@field LUE number Lineup error in degrees.
---@field Pitch number Pitch angle in degrees.
---@field Rho number Distance in meters.
---@field Roll number Roll angle in degrees.
---@field Step number Current step.
---@field Time number Time in seconds.
---@field Vel number Total velocity in m/s.
---@field Vy number Vertical velocity in m/s.
---@field X number Distance in meters.
---@field Yaw number Yaw angle in degrees.
---@field Z number Distance in meters.
AIRBOSS.GrooveData = {}


---Groove position.
---@class AIRBOSS.GroovePos 
---@field AL string "AL": Abeam landing position (V/STOL).
---@field AR string "AR": At the ramp.
---@field IC string "IC": In close.
---@field IM string "IM": In the middle.
---@field IW string "IW": In the wires.
---@field LC string "LC": Level crossing (V/STOL).
---@field X0 string "X0": Entering the groove.
---@field XX string "XX": At the start, i.e. 3/4 from the run down.
AIRBOSS.GroovePos = {}


---LSO radio calls.
---@class AIRBOSS.LSOCalls 
---@field BOLTER AIRBOSS.RadioCall "Bolter, Bolter" call.
---@field CALLTHEBALL AIRBOSS.RadioCall "Call the Ball" call.
---@field CHECK AIRBOSS.RadioCall "CHECK" call.
---@field CLEAREDTOLAND AIRBOSS.RadioCall "Cleared to land" call.
---@field CLICK AIRBOSS.RadioCall Radio end transmission click sound.
---@field COMELEFT AIRBOSS.RadioCall "Come left" call.
---@field DEPARTANDREENTER AIRBOSS.RadioCall "Depart and re-enter" call.
---@field EXPECTHEAVYWAVEOFF AIRBOSS.RadioCall "Expect heavy wavoff" call.
---@field EXPECTSPOT5 AIRBOSS.RadioCall "Expect spot 5" call.
---@field EXPECTSPOT75 AIRBOSS.RadioCall "Expect spot 7.5" call.
---@field FAST AIRBOSS.RadioCall "You're fast" call.
---@field FOULDECK AIRBOSS.RadioCall "Foul Deck" call.
---@field HIGH AIRBOSS.RadioCall "You're high" call.
---@field IDLE AIRBOSS.RadioCall "Idle" call.
---@field LONGINGROOVE AIRBOSS.RadioCall "You're long in the groove" call.
---@field LOW AIRBOSS.RadioCall "You're low" call.
---@field N0 AIRBOSS.RadioCall "Zero" call.
---@field N1 AIRBOSS.RadioCall "One" call.
---@field N2 AIRBOSS.RadioCall "Two" call.
---@field N3 AIRBOSS.RadioCall "Three" call.
---@field N4 AIRBOSS.RadioCall "Four" call.
---@field N5 AIRBOSS.RadioCall "Five" call.
---@field N6 AIRBOSS.RadioCall "Six" call.
---@field N7 AIRBOSS.RadioCall "Seven" call.
---@field N8 AIRBOSS.RadioCall "Eight" call.
---@field N9 AIRBOSS.RadioCall "Nine" call.
---@field NOISE AIRBOSS.RadioCall Static noise sound.
---@field PADDLESCONTACT AIRBOSS.RadioCall "Paddles, contact" call.
---@field POWER AIRBOSS.RadioCall "Power" call.
---@field RADIOCHECK AIRBOSS.RadioCall "Paddles, radio check" call.
---@field RIGHTFORLINEUP AIRBOSS.RadioCall "Right for line up" call.
---@field ROGERBALL AIRBOSS.RadioCall "Roger ball" call.
---@field SLOW AIRBOSS.RadioCall "You're slow" call.
---@field SPINIT AIRBOSS.RadioCall "Spin it" call.
---@field STABILIZED AIRBOSS.RadioCall "Stabilized" call.
---@field WAVEOFF AIRBOSS.RadioCall "Wave off" call.
---@field WELCOMEABOARD AIRBOSS.RadioCall "Welcome aboard" call.
AIRBOSS.LSOCalls = {}


---LSO grade data.
---@class AIRBOSS.LSOgrade 
---@field Tgroove number Time in the groove in seconds.
---@field private airframe string Aircraft type name of player.
---@field private carriername string Carrier name/alias.
---@field private carrierrwy NOTYPE 
---@field private carriertype string Carrier type name.
---@field private case number Recovery case.
---@field private details string Detailed flight analysis.
---@field private finalscore number Points received after player has finally landed. This is the average over all incomplete passes (bolter, waveoff) before.
---@field private grade string LSO grade, i.e. _OK_, OK, (OK), --, CUT
---@field private midate string Mission date in yyyy/mm/dd format.
---@field private mitime string Mission time in hh:mm:ss+d format
---@field private modex string Onboard number.
---@field private osdate string Real live date. Needs **os** to be desanitized.
---@field private points number Points received.
---@field private theatre string DCS map.
---@field private wind string Wind speed on deck in knots.
---@field private wire number Wire caught.
AIRBOSS.LSOgrade = {}


---Lineup error thresholds in degrees.
---@class AIRBOSS.LUE 
---@field LEFT number   LUR  threshold. Default -3.0 deg.
---@field Left number  (LUR) threshold. Default -1.0 deg.
---@field LeftMed number threshold for AA/OS measuring. Default -2.0 deg.
---@field RIGHT number  LUL  threshold. Default 3.0 deg.
---@field Right number (LUL) threshold. Default 1.0 deg.
---@field RightMed number threshold for AA/OS measuring. Default 2.0 deg.
---@field _max number Max _OK_ value. Default 0.5 deg.
---@field _min number Min _OK_ value. Default -0.5 deg.
AIRBOSS.LUE = {}


---Marshal radio calls.
---@class AIRBOSS.MarshalCalls 
---@field AFFIRMATIVE AIRBOSS.RadioCall "Affirmative" call.
---@field ALTIMETER AIRBOSS.RadioCall "Altimeter" call.
---@field BRC AIRBOSS.RadioCall "BRC" call.
---@field CARRIERTURNTOHEADING AIRBOSS.RadioCall "Turn to heading" call.
---@field CASE AIRBOSS.RadioCall "Case" call.
---@field CHARLIETIME AIRBOSS.RadioCall "Charlie Time" call.
---@field CLEAREDFORRECOVERY AIRBOSS.RadioCall "You're cleared for case" call.
---@field CLICK AIRBOSS.RadioCall Radio end transmission click sound.
---@field DECKCLOSED AIRBOSS.RadioCall "Deck closed" sound.
---@field DEGREES AIRBOSS.RadioCall "Degrees" call.
---@field EXPECTED AIRBOSS.RadioCall "Expected" call.
---@field FLYNEEDLES AIRBOSS.RadioCall "Fly your needles" call.
---@field HOLDATANGELS AIRBOSS.RadioCall "Hold at angels" call.
---@field HOURS AIRBOSS.RadioCall "Hours" sound.
---@field MARSHALRADIAL AIRBOSS.RadioCall "Marshal radial" call.
---@field N0 AIRBOSS.RadioCall "Zero" call.
---@field N1 AIRBOSS.RadioCall "One" call.
---@field N2 AIRBOSS.RadioCall "Two" call.
---@field N3 AIRBOSS.RadioCall "Three" call.
---@field N4 AIRBOSS.RadioCall "Four" call.
---@field N5 AIRBOSS.RadioCall "Five" call.
---@field N6 AIRBOSS.RadioCall "Six" call.
---@field N7 AIRBOSS.RadioCall "Seven" call.
---@field N8 AIRBOSS.RadioCall "Eight" call.
---@field N9 AIRBOSS.RadioCall "Nine" call.
---@field NEGATIVE AIRBOSS.RadioCall "Negative" sound.
---@field NEWFB AIRBOSS.RadioCall "New final bearing" call.
---@field NOISE AIRBOSS.RadioCall Static noise sound.
---@field OBS AIRBOSS.RadioCall "Obs" call.
---@field POINT AIRBOSS.RadioCall "Point" call.
---@field RADIOCHECK AIRBOSS.RadioCall "Radio check" call.
---@field RECOVERY AIRBOSS.RadioCall "Recovery" call.
---@field RECOVERYOPSSTOPPED AIRBOSS.RadioCall "Recovery ops stopped" sound.
---@field RECOVERYPAUSEDNOTICE AIRBOSS.RadioCall "Recovery paused until further notice" call.
---@field RECOVERYPAUSEDRESUMED AIRBOSS.RadioCall "Recovery paused and will be resumed at" call.
---@field REPORTSEEME AIRBOSS.RadioCall "Report see me" call.
---@field RESUMERECOVERY AIRBOSS.RadioCall "Resuming aircraft recovery" call.
---@field ROGER AIRBOSS.RadioCall "Roger" call.
---@field SAYNEEDLES AIRBOSS.RadioCall "Say needles" call.
---@field STACKFULL AIRBOSS.RadioCall "Marshal stack is currently full. Hold outside 10 NM zone and wait for further instructions" call.
---@field STARTINGRECOVERY AIRBOSS.RadioCall "Starting aircraft recovery" call.
AIRBOSS.MarshalCalls = {}


---Pattern steps.
---@class AIRBOSS.PatternStep 
---@field ABEAM string "Abeam".
---@field ARCIN string "Arc Turn In".
---@field ARCOUT string "Arc Turn Out".
---@field BOLTER string "Bolter Pattern".
---@field BREAKENTRY string "Break Entry".
---@field BULLSEYE string "Bullseye".
---@field COMMENCING string "Commencing".
---@field DEBRIEF string "Debrief".
---@field DIRTYUP string "Dirty Up".
---@field EARLYBREAK string "Early Break".
---@field EMERGENCY string "Emergency Landing".
---@field FINAL string "Final".
---@field GROOVE_AL string "Groove Abeam Landing Spot".
---@field GROOVE_AR string "Groove At the Ramp".
---@field GROOVE_IC string "Groove In Close".
---@field GROOVE_IM string "Groove In the Middle".
---@field GROOVE_IW string "Groove In the Wires".
---@field GROOVE_LC string "Groove Level Cross".
---@field GROOVE_XX string "Groove X".
---@field HOLDING string "Holding".
---@field INITIAL string "Initial".
---@field LATEBREAK string "Late Break".
---@field NINETY string "Ninety".
---@field PLATFORM string "Platform".
---@field REFUELING string "Refueling".
---@field SPINNING string "Spinning".
---@field UNDEFINED string "Undefined".
---@field WAITING string "Waiting for free Marshal stack".
---@field WAKE string "Wake".
AIRBOSS.PatternStep = {}


---Pilot radio calls.
---@class AIRBOSS.PilotCalls 
---@field BALL AIRBOSS.RadioCall "Ball" call.
---@field BINGOFUEL AIRBOSS.RadioCall "Bingo Fuel" call.
---@field GASATDIVERT AIRBOSS.RadioCall "Going for gas at the divert field" call.
---@field GASATTANKER AIRBOSS.RadioCall "Going for gas at the recovery tanker" call.
---@field HARRIER AIRBOSS.RadioCall "Harrier" call.
---@field HAWKEYE AIRBOSS.RadioCall "Hawkeye" call.
---@field HORNET AIRBOSS.RadioCall "Hornet" call.
---@field N0 AIRBOSS.RadioCall "Zero" call.
---@field N1 AIRBOSS.RadioCall "One" call.
---@field N2 AIRBOSS.RadioCall "Two" call.
---@field N3 AIRBOSS.RadioCall "Three" call.
---@field N4 AIRBOSS.RadioCall "Four" call.
---@field N5 AIRBOSS.RadioCall "Five" call.
---@field N6 AIRBOSS.RadioCall "Six" call.
---@field N7 AIRBOSS.RadioCall "Seven" call.
---@field N8 AIRBOSS.RadioCall "Eight" call.
---@field N9 AIRBOSS.RadioCall "Nine" call.
---@field POINT AIRBOSS.RadioCall "Point" call.
---@field SKYHAWK AIRBOSS.RadioCall "Skyhawk" call.
---@field TOMCAT AIRBOSS.RadioCall "Tomcat" call.
---@field VIKING AIRBOSS.RadioCall "Viking" call.
AIRBOSS.PilotCalls = {}


---Player data table holding all important parameters of each player.
---@class AIRBOSS.PlayerData : AIRBOSS.FlightGroup
---@field SRS MSRS 
---@field SRSQ MSRSQUEUE 
---@field TIG0 number Time in groove start timer.getTime().
---@field Tgroove number Time in the groove in seconds.
---@field Tlso number Last time the LSO gave an advice.
---@field private airframe NOTYPE 
---@field private attitudemonitor boolean If true, display aircraft attitude and other parameters constantly.
---@field private boltered boolean If true, player boltered.
---@field private callsign string Callsign of player.
---@field private case NOTYPE 
---@field private client CLIENT Client object of player.
---@field private debrief table Debrief analysis of the current step of this pass.
---@field private debriefschedulerID string Debrief scheduler ID.
---@field private difficulty string Difficulty level.
---@field private finalscore number Final score if points are averaged over multiple passes.
---@field private flag NOTYPE 
---@field private grade NOTYPE 
---@field private groove AIRBOSS.GroovePos Data table at each position in the groove. Elements are of type @{#AIRBOSS.GrooveData}.
---@field private hover boolean 
---@field private landed boolean If true, player landed or attempted to land.
---@field private lastdebrief table Debrief of player performance of last completed pass.
---@field private lig boolean If true, player was long in the groove.
---@field private messages table 
---@field private modex NOTYPE 
---@field private name NOTYPE 
---@field private owo boolean If true, own waveoff by player.
---@field private passes number Number of passes.
---@field private points table Points of passes until finally landed.
---@field private refueling boolean 
---@field private seclead NOTYPE 
---@field private showhints boolean If true, show step hints.
---@field private stable boolean 
---@field private step string Current/next pattern step.
---@field private subtitles boolean If true, display subtitles of radio messages.
---@field private time NOTYPE 
---@field private trapon boolean If true, save trap sheets.
---@field private trapsheet table Groove data table recorded every 0.5 seconds.
---@field private unit UNIT Aircraft of the player.
---@field private unitname string Name of the unit.
---@field private valid boolean If true, player made a valid approach. Is set true on start of Groove X.
---@field private warning boolean Set true once the player got a warning.
---@field private waveoff boolean If true, player was waved off during final approach.
---@field private wire number Wire caught by player when trapped.
---@field private wofd boolean If true, player was waved off because of a foul deck.
---@field private wop boolean If true, player was waved off during the pattern.
AIRBOSS.PlayerData = {}


---Radio.
---@class AIRBOSS.Radio 
---@field private alias string Radio alias.
---@field private frequency number Frequency in Hz.
---@field private modulation number Band modulation.
---@field private voice NOTYPE 
AIRBOSS.Radio = {}


---Radio sound file and subtitle.
---@class AIRBOSS.RadioCall 
---@field private duration number Duration of the sound in seconds. This is also the duration the subtitle is displayed.
---@field private file string Sound file name without suffix.
---@field private loud boolean Loud version of sound file available.
---@field private modexreceiver string Onboard number of the receiver (optional).
---@field private modexsender string Onboard number of the sender (optional).
---@field private sender string Sender of the message (optional). Default radio alias.
---@field private subduration number Duration in seconds the subtitle is displayed.
---@field private subtitle string Subtitle displayed during transmission.
---@field private suffix string File suffix/extension, e.g. "ogg".
AIRBOSS.RadioCall = {}


---Radio queue item.
---@class AIRBOSS.Radioitem 
---@field Tplay number Abs time when transmission should be played.
---@field Tstarted number Abs time when transmission began to play.
---@field private call AIRBOSS.RadioCall Radio call.
---@field private interval number Interval in seconds after the last sound was played.
---@field private isplaying boolean Currently playing.
---@field private loud boolean If true, play loud version of file.
---@field private radio AIRBOSS.Radio Radio object.
AIRBOSS.Radioitem = {}


---Recovery window parameters.
---@class AIRBOSS.Recovery 
---@field CASE number Recovery case (1-3) of that time slot.
---@field ID number Recovery window ID.
---@field OFFSET number Angle offset of the holding pattern in degrees. Usually 0, +-15, or +-30 degrees.
---@field OPEN boolean Recovery window is currently open.
---@field OVER boolean Recovery window is over and closed.
---@field SPEED number The speed in knots the carrier has during the recovery.
---@field START number Start of recovery in seconds of abs mission time.
---@field STOP number End of recovery in seconds of abs mission time.
---@field UTURN boolean If true, carrier makes a U-turn to the point it came from before resuming its route to the next waypoint.
---@field WIND boolean Carrier will turn into the wind.
AIRBOSS.Recovery = {}



