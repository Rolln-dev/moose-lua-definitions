---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Range.JPG" width="100%">
---
---**Functional** - Range Practice.
---
---===
---
---The RANGE class enables easy set up of bombing and strafing ranges within DCS World.
---
---Implementation is based on the [Simple Range Script](https://forums.eagle.ru/showthread.php?t=157991) by Ciribob, which itself was motivated
---by a script by SNAFU [see here](https://forums.eagle.ru/showthread.php?t=109174).
---
---[476th - Air Weapons Range Objects mod](https://www.476vfightergroup.com/downloads.php?do=download&downloadid=482) is highly recommended for this class.
---
---**Main Features:**
---
---  * Impact points of bombs, rockets and missiles are recorded and distance to closest range target is measured and reported to the player.
---  * Number of hits on strafing passes are counted and reported. Also the percentage of hits w.r.t fired shots is evaluated.
---  * Results of all bombing and strafing runs are stored and top 10 results can be displayed.
---  * Range targets can be marked by smoke.
---  * Range can be illuminated by illumination bombs for night missions.
---  * Bomb, rocket and missile impact points can be marked by smoke.
---  * Direct hits on targets can trigger flares.
---  * Smoke and flare colors can be adjusted for each player via radio menu.
---  * Range information and weather at the range can be obtained via radio menu.
---  * Persistence: Bombing range results can be saved to disk and loaded the next time the mission is started.
---  * Range control voice overs (>40) for hit assessment.
---
---===
---
---## Youtube Videos:
---
---   * [MOOSE YouTube Channel](https://www.youtube.com/channel/UCjrA9j5LQoWsG4SpS8i79Qg)
---   * [MOOSE - On the Range - Demonstration Video](https://www.youtube.com/watch?v=kIXcxNB9_3M)
---
---===
---
---## Missions:
---
---   * [MAR - On the Range - MOOSE - SC](https://www.digitalcombatsimulator.com/en/files/3317765/) by shagrat
---
---===
---
---## Sound files: [MOOSE Sound Files](https://github.com/FlightControl-Master/MOOSE_SOUND/releases)
---
---===
---
---### Author: **funkyfranky**
---
---### Contributions: FlightControl, Ciribob
---### SRS Additions: Applevangelist
---
---===
---*Don't only practice your art, but force your way into its secrets; art deserves that, for it and knowledge can raise man to the Divine.* - Ludwig van Beethoven
---
---===
---
---![Banner Image](..\Presentations\RANGE\RANGE_Main.png)
---
---# The Range Concept
---
---The RANGE class enables a mission designer to easily set up practice ranges in DCS.
---A new RANGE object can be created with the #RANGE.New(*rangename*) contructor.
---The parameter *rangename* defines the name of the range. It has to be unique since this is also the name displayed in the radio menu.
---
---Generally, a range consists of strafe pits and bombing targets. For strafe pits the number of hits for each pass is counted and tabulated.
---For bombing targets, the distance from the impact point of the bomb, rocket or missile to the closest range target is measured and tabulated.
---Each player can display his best results via a function in the radio menu or see the best best results from all players.
---
---When all targets have been defined in the script, the range is started by the #RANGE.Start() command.
---
---**IMPORTANT**
---
---Due to a DCS bug, it is not possible to directly monitor when a player enters a plane. So in a mission with client slots, it is vital that
---a player first enters as spectator or hits ESC twice and **after that** jumps into the slot of his aircraft!
---If that is not done, the script is not started correctly. This can be checked by looking at the radio menues. If the mission was entered correctly,
---there should be an "On the Range" menu items in the "F10. Other..." menu.
---
---# Strafe Pits
---
---Each strafe pit can consist of multiple targets. Often one finds two or three strafe targets next to each other.
---
---A strafe pit can be added to the range by the #RANGE.AddStrafePit(*targetnames, boxlength, boxwidth, heading, inverseheading, goodpass, foulline*) function.
---
---* The first parameter *targetnames* defines the target or targets. This can be a single item or a Table with the name(s) of Wrapper.Unit or Wrapper.Static objects defined in the mission editor.
---* In order to perform a valid pass on the strafe pit, the pilot has to begin his run from the correct direction. Therefore, an "approach box" is defined in front
---  of the strafe targets. The parameters *boxlength* and *boxwidth* define the size of the box in meters, while the *heading* parameter defines the heading of the box FROM the target.
---  For example, if heading 120 is set, the approach box will start FROM the target and extend outwards on heading 120. A strafe run approach must then be flown apx. heading 300 TOWARDS the target.
---  If the parameter *heading* is passed as **nil**, the heading is automatically taken from the heading set in the ME for the first target unit.
---* The parameter *inverseheading* turns the heading around by 180 degrees. This is useful when the default heading of strafe target units point in the wrong/opposite direction.
---* The parameter *goodpass* defines the number of hits a pilot has to achieve during a run to be judged as a "good" pass.
---* The last parameter *foulline* sets the distance from the pit targets to the foul line. Hit from closer than this line are not counted!
---
---Another function to add a strafe pit is #RANGE.AddStrafePitGroup(*group, boxlength, boxwidth, heading, inverseheading, goodpass, foulline*). Here,
---the first parameter *group* is a MOOSE Wrapper.Group object and **all** units in this group define **one** strafe pit.
---
---Finally, a valid approach has to be performed below a certain maximum altitude. The default is 914 meters (3000 ft) AGL. This is a parameter valid for all
---strafing pits of the range and can be adjusted by the #RANGE.SetMaxStrafeAlt(maxalt) function.
---
---# Bombing targets
---
---One ore multiple bombing targets can be added to the range by the #RANGE.AddBombingTargets(targetnames, goodhitrange, randommove) function.
---
---* The first parameter *targetnames* defines the target or targets. This can be a single item or a Table with the name(s) of Wrapper.Unit or Wrapper.Static objects defined in the mission editor.
---* The (optional) parameter *goodhitrange* specifies the radius in metres around the target within which a bomb/rocket hit is considered to be "good".
---* If final (optional) parameter "*randommove*" can be enabled to create moving targets. If this parameter is set to true, the units of this bombing target will randomly move within the range zone.
---  Note that there might be quirks since DCS units can get stuck in buildings etc. So it might be safer to manually define a route for the units in the mission editor if moving targets are desired.
---
---## Adding Groups
---
---Another possibility to add bombing targets is the #RANGE.AddBombingTargetGroup(*group, goodhitrange, randommove*) function. Here the parameter *group* is a MOOSE Wrapper.Group object
---and **all** units in this group are defined as bombing targets.
---
---## Specifying Coordinates
---
---It is also possible to specify coordinates rather than unit or static objects as bombing target locations. This has the advantage, that even when the unit/static object is dead, the specified
---coordinate will still be a valid impact point. This can be done via the #RANGE.AddBombingTargetCoordinate(*coord*, *name*, *goodhitrange*) function.
---
---# Fine Tuning
---
---Many range parameters have good default values. However, the mission designer can change these settings easily with the supplied user functions:
---
---* #RANGE.SetMaxStrafeAlt() sets the max altitude for valid strafing runs.
---* #RANGE.SetMessageTimeDuration() sets the duration how long (most) messages are displayed.
---* #RANGE.SetDisplayedMaxPlayerResults() sets the number of results displayed.
---* #RANGE.SetRangeRadius() defines the total range area.
---* #RANGE.SetBombTargetSmokeColor() sets the color used to smoke bombing targets.
---* #RANGE.SetStrafeTargetSmokeColor() sets the color used to smoke strafe targets.
---* #RANGE.SetStrafePitSmokeColor() sets the color used to smoke strafe pit approach boxes.
---* #RANGE.SetSmokeTimeDelay() sets the time delay between smoking bomb/rocket impact points after impact.
---* #RANGE.TrackBombsON() or #RANGE.TrackBombsOFF() can be used to enable/disable tracking and evaluating of all bomb types a player fires.
---* #RANGE.TrackRocketsON() or #RANGE.TrackRocketsOFF() can be used to enable/disable tracking and evaluating of all rocket types a player fires.
---* #RANGE.TrackMissilesON() or #RANGE.TrackMissilesOFF() can be used to enable/disable tracking and evaluating of all missile types a player fires.
---
---# Radio Menu
---
---Each range gets a radio menu with various submenus where each player can adjust his individual settings or request information about the range or his scores.
---
---The main range menu can be found at "F10. Other..." --> "F*X*. On the Range..." --> "F1. <Range Name>...".
---
---The range menu contains the following submenus:
---
---![Banner Image](..\Presentations\RANGE\Menu_Main.png)
---
---* "F1. Statistics...": Range results of all players and personal stats.
---* "F2. Mark Targets": Mark range targets by smoke or flares.
---* "F3. My Settings" Personal settings.
---* "F4. Range Info": Information about the range, such as bearing and range.
---
---## F1 Statistics
---
---![Banner Image](..\Presentations\RANGE\Menu_Stats.png)
---
---## F2 Mark Targets
---
---![Banner Image](..\Presentations\RANGE\Menu_Stats.png)
---
---## F3 My Settings
---
---![Banner Image](..\Presentations\RANGE\Menu_MySettings.png)
---
---## F4 Range Info
---
---![Banner Image](..\Presentations\RANGE\Menu_RangeInfo.png)
---
---# Voice Overs
---
---Voice over sound files can be downloaded from the Moose Discord. Check the pinned messages in the *#func-range* channel.
---
---Instructor radio will inform players when they enter or exit the range zone and provide the radio frequency of the range control for hit assessment.
---This can be enabled via the #RANGE.SetInstructorRadio(*frequency*) functions, where *frequency* is the AM frequency in MHz.
---
---The range control can be enabled via the #RANGE.SetRangeControl(*frequency*) functions, where *frequency* is the AM frequency in MHz.
---
---By default, the sound files are placed in the "Range Soundfiles/" folder inside the mission (.miz) file. Another folder can be specified via the #RANGE.SetSoundfilesPath(*path*) function.
---
---## Voice output via SRS
---
---Alternatively, the voice output can be fully done via SRS, **no sound file additions needed**. Set up SRS with #RANGE.SetSRS().
---Range control and instructor frequencies and voices can then be set via #RANGE.SetSRSRangeControl() and #RANGE.SetSRSRangeInstructor().
---
---# Persistence
---
---To automatically save bombing results to disk, use the #RANGE.SetAutosave() function. Bombing results will be saved as csv file in your "Saved Games\DCS.openbeta\Logs" directory.
---Each range has a separate file, which is named "RANGE-<*RangeName*>_BombingResults.csv".
---
---The next time you start the mission, these results are also automatically loaded.
---
---Strafing results are currently **not** saved.
---
---# FSM Events
---
---This class creates additional events that can be used by mission designers for custom reactions
---
---* `EnterRange` when a player enters a range zone. See #RANGE.OnAfterEnterRange
---* `ExitRange`  when a player leaves a range zone. See #RANGE.OnAfterExitRange
---* `Impact` on impact of a player's weapon on a bombing target. See #RANGE.OnAfterImpact
---* `RollingIn` when a player rolls in on a strafing target. See #RANGE.OnAfterRollingIn
---* `StrafeResult` when a player finishes a strafing run. See #RANGE.OnAfterStrafeResult
---
---# Examples
---
---## Goldwater Range
---
---This example shows hot to set up the [Barry M. Goldwater range](https://en.wikipedia.org/wiki/Barry_M._Goldwater_Air_Force_Range).
---It consists of two strafe pits each has two targets plus three bombing targets.
---
---     -- Strafe pits. Each pit can consist of multiple targets. Here we have two pits and each of the pits has two targets.
---     -- These are names of the corresponding units defined in the ME.
---     local strafepit_left={"GWR Strafe Pit Left 1", "GWR Strafe Pit Left 2"}
---     local strafepit_right={"GWR Strafe Pit Right 1", "GWR Strafe Pit Right 2"}
---
---     -- Table of bombing target names. Again these are the names of the corresponding units as defined in the ME.
---     local bombtargets={"GWR Bomb Target Circle Left", "GWR Bomb Target Circle Right", "GWR Bomb Target Hard"}
---
---     -- Create a range object.
---     GoldwaterRange=RANGE:New("Goldwater Range")
---
---     -- Set and enable the range ceiling altitude in feet MSL.  If aircraft are above this altitude they are not considered to be in the range.
---     GoldwaterRange:SetRangeCeiling(20000)
---     GoldwaterRange:EnableRangeCeiling(true)
---
---     -- Distance between strafe target and foul line. You have to specify the names of the unit or static objects.
---     -- Note that this could also be done manually by simply measuring the distance between the target and the foul line in the ME.
---     GoldwaterRange:GetFoullineDistance("GWR Strafe Pit Left 1", "GWR Foul Line Left")
---
---     -- Add strafe pits. Each pit (left and right) consists of two targets. Where "nil" is used as input, the default value is used.
---     GoldwaterRange:AddStrafePit(strafepit_left, 3000, 300, nil, true, 30, 500)
---     GoldwaterRange:AddStrafePit(strafepit_right, nil, nil, nil, true, nil, 500)
---
---     -- Add bombing targets. A good hit is if the bomb falls less then 50 m from the target.
---     GoldwaterRange:AddBombingTargets(bombtargets, 50)
---
---     -- Start range.
---     GoldwaterRange:Start()
---
---The [476th - Air Weapons Range Objects mod](http://www.476vfightergroup.com/downloads.php?do=file&id=287) is (implicitly) used in this example.
---
---
---# Debugging
---
---In case you have problems, it is always a good idea to have a look at your DCS log file. You find it in your "Saved Games" folder, so for example in
---     C:\Users\<yourname>\Saved Games\DCS\Logs\dcs.log
---All output concerning the RANGE class should have the string "RANGE" in the corresponding line.
---
---The verbosity of the output can be increased by adding the following lines to your script:
---
---     BASE:TraceOnOff(true)
---     BASE:TraceLevel(1)
---     BASE:TraceClass("RANGE")
---
---To get even more output you can increase the trace level to 2 or even 3, c.f. Core.Base#BASE for more details.
---
---The function #RANGE.DebugON() can be used to send messages on screen. It also smokes all defined strafe and bombing targets, the strafe pit approach boxes and the range zone.
---
---Note that it can happen that the RANGE radio menu is not shown. Check that the range object is defined as a **global** variable rather than a local one.
---The could avoid the lua garbage collection to accidentally/falsely deallocate the RANGE objects.
---RANGE class
---@class RANGE 
---@field BombSmokeColor SMOKECOLOR Color id used for smoking bomb targets.
---@field BombtrackThreshold number Bombs/rockets/missiles are only tracked if player-range distance is smaller than this threshold [m]. Default 25000 m.
---@field ClassName string Name of the Class.
---@field Coalition number Coalition side for the menu, if any.
---@field Debug boolean If true, debug info is sent as messages on the screen.
---@field Defaults RANGE.Defaults 
---@field MenuAddedTo table Table for monitoring which players already got an F10 menu.
---@field MenuF10 table Main radio menu on group level.
---@field MenuF10Root table Main radio menu on mission level.
---@field Names table Global list of all defined range names.
---@field PlayerSettings table Individual player settings.
---@field Sound RANGE.Sound 
---@field StrafePitSmokeColor SMOKECOLOR Color id used to smoke strafe pit approach boxes.
---@field StrafeSmokeColor SMOKECOLOR Color id used to smoke strafe targets.
---@field TargetType RANGE.TargetType 
---@field TdelaySmoke number Time delay in seconds between impact of bomb and starting the smoke. Default 3 seconds.
---@field Tmsg number Time [sec] messages to players are displayed. Default 30 sec.
---@field private autosave boolean If true, automatically save results every X seconds.
---@field private bombPlayerResults table Table containing the bombing results of each player.
---@field private bombingTargets table Table of targets to bomb.
---@field private ceilingaltitude number Range ceiling altitude in ft MSL.  Aircraft above this altitude are not considered to be in the range. Default is 20000 ft.
---@field private ceilingenabled boolean Range has a ceiling and is not unlimited.  Default is false.
---@field private controlmsrs MSRS SRS wrapper for range controller.
---@field private controlsrsQ MSRSQUEUE SRS queue for range controller.
---@field private defaultsmokebomb boolean If true, initialize player settings to smoke bomb.
---@field private dtBombtrack number Time step [sec] used for tracking released bomb/rocket positions. Default 0.005 seconds.
---@field private examinerexclusive boolean If true, only the examiner gets messages. If false, clients and examiner get messages.
---@field private examinergroupname string Name of the examiner group which should get all messages.
---@field private funkmanSocket NOTYPE 
---@field private illuminationmaxalt number Maximum altitude in meters AGL at which illumination bombs are fired. Default is 1000 m.
---@field private illuminationminalt number Minimum altitude in meters AGL at which illumination bombs are fired. Default is 500 m.
---@field private instructmsrs MSRS SRS wrapper for range instructor.
---@field private instructor RADIOQUEUE Instructor radio queue.
---@field private instructorfreq number Frequency on which the range control transmitts.
---@field private instructorrelayname string Name of relay unit.
---@field private instructsrsQ MSRSQUEUE SRS queue for range instructor.
---@field private lid string String id of range for output in DCS log.
---@field private location COORDINATE Coordinate of the range location.
---@field private menuF10root MENU_MISSION Specific user defined root F10 menu.
---@field private messages boolean Globally enable/disable all messages to players.
---@field private nbombtargets number Number of bombing targets.
---@field private ndisplayresult number Number of (player) results that a displayed. Default is 10.
---@field private nstrafetargets number Number of strafing targets.
---@field private planes table Table for administration.
---@field private rangecontrol RADIOQUEUE Range control radio queue.
---@field private rangecontrolfreq number Frequency on which the range control transmitts.
---@field private rangecontrolrelayname string Name of relay unit.
---@field private rangename string Name of the range.
---@field private rangeradius number Radius of range defining its total size for e.g. smoking bomb impact points and sending radio messages. Default 5 km.
---@field private rangezone ZONE MOOSE zone object of the range. For example, no bomb impacts are smoked if bombs fall outside of the range zone.
---@field private scorebombdistance number Distance from closest target up to which bomb hits are counted. Default 1000 m.
---@field private soundpath string Path inside miz file where the sound files are located. Default is "Range Soundfiles/".
---@field private strafePlayerResults table Table containing the strafing results of each player.
---@field private strafeStatus table Table containing the current strafing target a player as assigned to.
---@field private strafeTargets table Table of strafing targets.
---@field private strafemaxalt number Maximum altitude in meters AGL for registering for a strafe run. Default is 914 m = 3000 ft.
---@field private targetpath string Path where to save the target sheets.
---@field private targetprefix string File prefix for target sheet files.
---@field private targetsheet boolean If true, players can save their target sheets. Rangeboss will not work if targetsheets do not save.
---@field private timerCheckZone NOTYPE 
---@field private trackbombs boolean If true (default), all bomb types are tracked and impact point to closest bombing target is evaluated.
---@field private trackmissiles boolean If true (default), all missile types are tracked and impact point to closest bombing target is evaluated.
---@field private trackrockets boolean If true (default), all rocket types are tracked and impact point to closest bombing target is evaluated.
---@field private useSRS boolean 
---@field private verbose boolean Verbosity level. Higher means more output to DCS log file.
---@field private version string Range script version.
RANGE = {}

---Add a coordinate of a bombing target.
---This
---
------
---@param coord COORDINATE The coordinate.
---@param name string Name of target.
---@param goodhitrange number Max distance from unit which is considered as a good hit.
---@return RANGE #self
function RANGE:AddBombingTargetCoordinate(coord, name, goodhitrange) end

---Add all units of a group as bombing targets.
---
------
---@param group GROUP Group of bombing targets. Can also be given as group name.
---@param goodhitrange number Max distance from unit which is considered as a good hit.
---@param randommove boolean If true, unit will move randomly within the range. Default is false.
---@return RANGE #self
function RANGE:AddBombingTargetGroup(group, goodhitrange, randommove) end

---Add a scenery object as bombing target.
---
------
---@param scenery SCENERY Scenary object.
---@param goodhitrange number Max distance from unit which is considered as a good hit.
---@return RANGE #self
function RANGE:AddBombingTargetScenery(scenery, goodhitrange) end

---Add a unit or static object as bombing target.
---
------
---@param unit POSITIONABLE Positionable (unit or static) of the bombing target.
---@param goodhitrange number Max distance from unit which is considered as a good hit.
---@param randommove boolean If true, unit will move randomly within the range. Default is false.
---@return RANGE #self
function RANGE:AddBombingTargetUnit(unit, goodhitrange, randommove) end

---Add bombing target(s) to range.
---
------
---@param targetnames table Single or multiple (Table) names of unit or static objects serving as bomb targets.
---@param goodhitrange? number (Optional) Max distance from target unit (in meters) which is considered as a good hit. Default is 25 m.
---@param randommove boolean If true, unit will move randomly within the range. Default is false.
---@return RANGE #self
function RANGE:AddBombingTargets(targetnames, goodhitrange, randommove) end

---Add new strafe pit.
---For a strafe pit, hits from guns are counted. One pit can consist of several units.
---A strafe run approach is only valid if the player enters via a zone in front of the pit, which is defined by boxlength, boxwidth, and heading.
---Furthermore, the player must not be too high and fly in the direction of the pit to make a valid target apporoach.
---
------
---@param targetnames table Single or multiple (Table) unit or static names defining the strafe targets. The first target in the list determines the approach box origin (heading and box).
---@param boxlength? number (Optional) Length of the approach box in meters. Default is 3000 m.
---@param boxwidth? number (Optional) Width of the approach box in meters. Default is 300 m.
---@param heading? number (Optional) Approach box heading in degrees (originating FROM the target). Default is the heading set in the ME for the first target unit
---@param inverseheading? boolean (Optional) Use inverse heading (heading --> heading - 180 Degrees). Default is false.
---@param goodpass? number (Optional) Number of hits for a "good" strafing pass. Default is 20.
---@param foulline? number (Optional) Foul line distance. Hits from closer than this distance are not counted. Default is 610 m = 2000 ft. Set to 0 for no foul line.
---@return RANGE #self
function RANGE:AddStrafePit(targetnames, boxlength, boxwidth, heading, inverseheading, goodpass, foulline) end

---Add all units of a group as one new strafe target pit.
---For a strafe pit, hits from guns are counted. One pit can consist of several units.
---Note, an approach is only valid, if the player enters via a zone in front of the pit, which defined by boxlength and boxheading.
---Furthermore, the player must not be too high and fly in the direction of the pit to make a valid target apporoach.
---
------
---@param group GROUP MOOSE group of unit names defining the strafe target pit. The first unit in the group determines the approach zone (heading and box).
---@param boxlength? number (Optional) Length of the approach box in meters. Default is 3000 m.
---@param boxwidth? number (Optional) Width of the approach box in meters. Default is 300 m.
---@param heading? number (Optional) Approach heading in Degrees. Default is heading of the unit as defined in the mission editor.
---@param inverseheading? boolean (Optional) Take inverse heading (heading --> heading - 180 Degrees). Default is false.
---@param goodpass? number (Optional) Number of hits for a "good" strafing pass. Default is 20.
---@param foulline? number (Optional) Foul line distance. Hits from closer than this distance are not counted. Default 610 m = 2000 ft. Set to 0 for no foul line.
---@return RANGE #self
function RANGE:AddStrafePitGroup(group, boxlength, boxwidth, heading, inverseheading, goodpass, foulline) end

---Disable debug modus.
---
------
---@return RANGE #self
function RANGE:DebugOFF() end

---Enable debug modus.
---
------
---@return RANGE #self
function RANGE:DebugON() end

---Enable range ceiling.
---Aircraft must be below the ceiling altitude to be considered in the range zone.
---
------
---@param enabled boolean True if you would like to enable the ceiling check.  If no value give, will Default to false.
---@return RANGE #self
function RANGE:EnableRangeCeiling(enabled) end

---Triggers the FSM event "EnterRange".
---
------
---@param player RANGE.PlayerData Data of player settings etc.
function RANGE:EnterRange(player) end

---Triggers the FSM event "ExitRange".
---
------
---@param player RANGE.PlayerData Data of player settings etc.
function RANGE:ExitRange(player) end

---Measures the foule line distance between two unit or static objects.
---
------
---@param namepit string Name of the strafe pit target object.
---@param namefoulline string Name of the fould line distance marker object.
---@return number #Foul line distance in meters.
function RANGE:GetFoullineDistance(namepit, namefoulline) end

---Triggers the FSM event "Impact".
---
------
---@param result RANGE.BombResult Data of bombing run.
---@param player RANGE.PlayerData Data of player settings etc.
function RANGE:Impact(result, player) end

---RANGE contructor.
---Creates a new RANGE object.
---
------
---@param RangeName string Name of the range. Has to be unique. Will we used to create F10 menu items etc.
---@param Coalition? number (optional) Coalition of the range, if any, e.g. coalition.side.BLUE.
---@return RANGE #RANGE object.
function RANGE:New(RangeName, Coalition) end

---On after "EnterRange" event user function.
---Called when a player enters the range zone.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param player RANGE.PlayerData Data of player settings etc.
function RANGE:OnAfterEnterRange(From, Event, To, player) end

---On after "ExitRange" event user function.
---Called when a player leaves the range zone.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param player RANGE.PlayerData Data of player settings etc.
function RANGE:OnAfterExitRange(From, Event, To, player) end

---On after "Impact" event user function.
---Called when a bomb/rocket/missile impacted.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param result RANGE.BombResult Data of the bombing run.
---@param player RANGE.PlayerData Data of player settings etc.
function RANGE:OnAfterImpact(From, Event, To, result, player) end

---On after "RollingIn" event user function.
---Called when a player rolls in to a strafe taret.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param player RANGE.PlayerData Data of player settings etc.
---@param target RANGE.StrafeTarget Strafe target.
function RANGE:OnAfterRollingIn(From, Event, To, player, target) end

---On after "StrafeResult" event user function.
---Called when a player finished a strafing run.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param player RANGE.PlayerData Data of player settings etc.
---@param result RANGE.StrafeResult Data of the strafing run.
function RANGE:OnAfterStrafeResult(From, Event, To, player, result) end

---Range event handler for event birth.
---
------
---@param EventData EVENTDATA 
function RANGE:OnEventBirth(EventData) end

---Range event handler for event hit.
---
------
---@param EventData EVENTDATA 
function RANGE:OnEventHit(EventData) end

---Range event handler for event shot (when a unit releases a rocket or bomb (but not a fast firing gun).
---
------
---@param EventData EVENTDATA 
function RANGE:OnEventShot(EventData) end

---Triggers the FSM event "RollingIn".
---
------
---@param player RANGE.PlayerData Data of player settings etc.
---@param target RANGE.StrafeTarget Strafe target.
function RANGE:RollingIn(player, target) end

---Switch off auto save player results.
---
------
---@return RANGE #self
function RANGE:SetAutosaveOff() end

---Automatically save player results to disc.
---
------
---@return RANGE #self
function RANGE:SetAutosaveOn() end

---Set smoke color for marking bomb targets.
---By default bomb targets are marked by red smoke.
---
------
---@param colorid SMOKECOLOR Color id. Default `SMOKECOLOR.Red`.
---@return RANGE #self
function RANGE:SetBombTargetSmokeColor(colorid) end

---Set bomb track threshold distance.
---Bombs/rockets/missiles are only tracked if player-range distance is less than this distance. Default 25 km.
---
------
---@param distance number Threshold distance in km. Default 25 km.
---@return RANGE #self
function RANGE:SetBombtrackThreshold(distance) end

---Set time interval for tracking bombs.
---A smaller time step increases accuracy but needs more CPU time.
---
------
---@param dt number Time interval in seconds. Default is 0.005 s.
---@return RANGE #self
function RANGE:SetBombtrackTimestep(dt) end

---Set player setting whether bomb impact points are smoked or not.
---
------
---@param switch boolean If true nor nil default is to smoke impact points of bombs.
---@return RANGE #self
function RANGE:SetDefaultPlayerSmokeBomb(switch) end

---Set max number of player results that are displayed.
---
------
---@param nmax number Number of results. Default is 10.
---@return RANGE #self
function RANGE:SetDisplayedMaxPlayerResults(nmax) end

---Set FunkMan socket.
---Bombing and strafing results will be send to your Discord bot.
---**Requires running FunkMan program**.
---
------
---@param Port number Port. Default `10042`.
---@param Host string Host. Default "127.0.0.1".
---@return RANGE #self
function RANGE:SetFunkManOn(Port, Host) end

---Enable instructor radio and set frequency (non-SRS).
---
------
---@param frequency number Frequency in MHz. Default 305 MHz.
---@param relayunitname string Name of the unit used for transmission.
---@return RANGE #self
function RANGE:SetInstructorRadio(frequency, relayunitname) end

---Set maximal strafing altitude.
---Player entering a strafe pit above that altitude are not registered for a valid pass.
---
------
---@param maxalt number Maximum altitude in meters AGL. Default is 914 m = 3000 ft.
---@return RANGE #self
function RANGE:SetMaxStrafeAlt(maxalt) end

---Set the root F10 menu under which the range F10 menu is created.
---
------
---@param menu MENU_MISSION The root F10 menu.
---@return RANGE #self
function RANGE:SetMenuRoot(menu) end

---Set time how long (most) messages are displayed.
---
------
---@param time number Time in seconds. Default is 30 s.
---@return RANGE #self
function RANGE:SetMessageTimeDuration(time) end

---Set messages to examiner.
---The examiner will receive messages from all clients.
---
------
---@param examinergroupname string Name of the group of the examiner.
---@param exclusively boolean If true, messages are send exclusively to the examiner, i.e. not to the clients.
---@return RANGE #self
function RANGE:SetMessageToExaminer(examinergroupname, exclusively) end

---Disable ALL messages to players.
---
------
---@return RANGE #self
function RANGE:SetMessagesOFF() end

---Enable messages to players.
---This is the default
---
------
---@return RANGE #self
function RANGE:SetMessagesON() end

---Set range ceiling altitude in feet MSL.
---
------
---@param altitude? number (optional) Ceiling altitude of the range in ft MSL. Default 20000ft MSL
---@return RANGE #self
function RANGE:SetRangeCeiling(altitude) end

---Enable range control and set frequency (non-SRS).
---
------
---@param frequency number Frequency in MHz. Default 256 MHz.
---@param relayunitname string Name of the unit used for transmission.
---@return RANGE #self
function RANGE:SetRangeControl(frequency, relayunitname) end

---Set range location.
---If this is not done, one (random) unit position of the range is used to determine the location of the range.
---The range location determines the position at which the weather data is evaluated.
---
------
---@param coordinate COORDINATE Coordinate of the range.
---@return RANGE #self
function RANGE:SetRangeLocation(coordinate) end

---Set range radius.
---Defines the area in which e.g. bomb impacts are smoked.
---
------
---@param radius number Radius in km. Default 5 km.
---@return RANGE #self
function RANGE:SetRangeRadius(radius) end

---Set range zone.
---For example, no bomb impact points are smoked if a bomb falls outside of this zone.
---If a zone is not explicitly specified, the range zone is determined by its location and radius.
---
------
---@param zone ZONE MOOSE zone defining the range perimeters.
---@return RANGE #self
function RANGE:SetRangeZone(zone) end

---Use SRS Simple-Text-To-Speech for transmissions.
---No sound files necessary.
---
------
---@param PathToSRS string Path to SRS directory.
---@param Port number SRS port. Default 5002.
---@param Coalition number Coalition side, e.g. `coalition.side.BLUE` or `coalition.side.RED`. Default `coalition.side.BLUE`.
---@param Frequency number Frequency to use. Default is 256 MHz for range control and 305 MHz for instructor. If given, both control and instructor get this frequency.
---@param Modulation number Modulation to use, defaults to radio.modulation.AM
---@param Volume number Volume, between 0.0 and 1.0. Defaults to 1.0
---@param PathToGoogleKey string Path to Google TTS credentials.
---@return RANGE #self
function RANGE:SetSRS(PathToSRS, Port, Coalition, Frequency, Modulation, Volume, PathToGoogleKey) end

---(SRS) Set range control frequency and voice.
---Use `RANGE:SetSRS()` once first before using this function.
---
------
---@param frequency number Frequency in MHz. Default 256 MHz.
---@param modulation number Modulation, defaults to radio.modulation.AM.
---@param voice string Voice.
---@param culture string Culture, defaults to "en-US".
---@param gender string Gender, defaults to "female".
---@param relayunitname string Name of the unit used for transmission location.
---@return RANGE #self
function RANGE:SetSRSRangeControl(frequency, modulation, voice, culture, gender, relayunitname) end

---(SRS) Set range instructor frequency and voice.
---Use `RANGE:SetSRS()` once first before using this function.
---
------
---@param frequency number Frequency in MHz. Default 305 MHz.
---@param modulation number Modulation, defaults to radio.modulation.AM.
---@param voice string Voice.
---@param culture string Culture, defaults to "en-US".
---@param gender string Gender, defaults to "male".
---@param relayunitname string Name of the unit used for transmission location.
---@return RANGE #self
function RANGE:SetSRSRangeInstructor(frequency, modulation, voice, culture, gender, relayunitname) end

---Set score bomb distance.
---
------
---@param distance number Distance in meters. Default 1000 m.
---@return RANGE #self
function RANGE:SetScoreBombDistance(distance) end

---Set time delay between bomb impact and starting to smoke the impact point.
---
------
---@param delay number Time delay in seconds. Default is 3 seconds.
---@return RANGE #self
function RANGE:SetSmokeTimeDelay(delay) end

---Set the path to the csv file that contains information about the used sound files.
---The parameter file has to be located on your local disk (**not** inside the miz file).
---
------
---@param csvfile string Full path to the csv file on your local disk.
---@return RANGE #self
function RANGE:SetSoundfilesInfo(csvfile) end

---Set sound files folder within miz file.
---
------
---@param path string Path for sound files. Default "Range Soundfiles/". Mind the slash "/" at the end!
---@return RANGE #self
function RANGE:SetSoundfilesPath(path) end

---Set smoke color for marking strafe pit approach boxes.
---By default strafe pit boxes are marked by white smoke.
---
------
---@param colorid SMOKECOLOR Color id. Default `SMOKECOLOR.White`.
---@return RANGE #self
function RANGE:SetStrafePitSmokeColor(colorid) end

---Set smoke color for marking strafe targets.
---By default strafe targets are marked by green smoke.
---
------
---@param colorid SMOKECOLOR Color id. Default `SMOKECOLOR.Green`.
---@return RANGE #self
function RANGE:SetStrafeTargetSmokeColor(colorid) end

---Enable saving of player's target sheets and specify an optional directory path.
---
------
---@param path? string (Optional) Path where to save the target sheets.
---@param prefix? string (Optional) Prefix for target sheet files. File name will be saved as *prefix_aircrafttype-0001.csv*, *prefix_aircrafttype-0002.csv*, etc.
---@return RANGE #self
function RANGE:SetTargetSheet(path, prefix) end

---Triggers the FSM event "Start".
---Starts the RANGE. Initializes parameters and starts event handlers.
---
------
function RANGE:Start() end

---Triggers the FSM event "Status".
---
------
function RANGE:Status() end

---Triggers the FSM event "StrafeResult".
---
------
---@param player RANGE.PlayerData Data of player settings etc.
---@param result RANGE.StrafeResult Data of the strafing run.
function RANGE:StrafeResult(player, result) end

---Disables tracking of all bomb types.
---
------
---@return RANGE #self
function RANGE:TrackBombsOFF() end

---Enables tracking of all bomb types.
---Note that this is the default setting.
---
------
---@return RANGE #self
function RANGE:TrackBombsON() end

---Disables tracking of all missile types.
---
------
---@return RANGE #self
function RANGE:TrackMissilesOFF() end

---Enables tracking of all missile types.
---Note that this is the default setting.
---
------
---@return RANGE #self
function RANGE:TrackMissilesON() end

---Disables tracking of all rocket types.
---
------
---@return RANGE #self
function RANGE:TrackRocketsOFF() end

---Enables tracking of all rocket types.
---Note that this is the default setting.
---
------
---@return RANGE #self
function RANGE:TrackRocketsON() end

---Add menu commands for player.
---
------
---@param _unitName string Name of player unit.
function RANGE:_AddF10Commands(_unitName) end

---Check if player is inside a strafing zone.
---If he is, we start looking for hits. If he was and left the zone again, the result is stored.
---
------
---@param _unitName string Name of player unit.
function RANGE:_CheckInZone(_unitName) end

---Check status of players.
---
------
---@param _unitName string Name of player unit.
function RANGE:_CheckPlayers(_unitName) end

---Checks if a static object with a certain name exists.
---It also added it to the MOOSE data base, if it is not already in there.
---
------
---@param name string Name of the potential static object.
---@return boolean #Returns true if a static with this name exists. Retruns false if a unit with this name exists. Returns nil if neither unit or static exist.
function RANGE:_CheckStatic(name) end

---Display bombing target locations to player.
---
------
---@param _unitname string Name of the player unit.
function RANGE:_DisplayBombTargets(_unitname) end

---Display best bombing results of top 10 players.
---
------
---@param _unitName string Name of player unit.
function RANGE:_DisplayBombingResults(_unitName) end

---Display message to group.
---
------
---@param _unit UNIT Player unit.
---@param _text string Message text.
---@param _time number Duration how long the message is displayed.
---@param _clear boolean Clear up old messages.
---@param display boolean If true, display message regardless of player setting "Messages Off".
---@param _togroup boolean If true, display the message to the group in any case
function RANGE:_DisplayMessageToGroup(_unit, _text, _time, _clear, display, _togroup) end

---Display top 10 bombing run results of specific player.
---
------
---@param _unitName string Name of the player unit.
function RANGE:_DisplayMyBombingResults(_unitName) end

---Display top 10 stafing results of a specific player.
---
------
---@param _unitName string Name of the player unit.
function RANGE:_DisplayMyStrafePitResults(_unitName) end

---Report information like bearing and range from player unit to range.
---
------
---@param _unitname string Name of the player unit.
function RANGE:_DisplayRangeInfo(_unitname) end

---Report weather conditions at range.
---Temperature, QFE pressure and wind data.
---
------
---@param _unitname string Name of the player unit.
function RANGE:_DisplayRangeWeather(_unitname) end

---Display top 10 strafing results of all players.
---
------
---@param _unitName string Name fo the player unit.
function RANGE:_DisplayStrafePitResults(_unitName) end

---Display pit location and heading to player.
---
------
---@param _unitname string Name of the player unit.
function RANGE:_DisplayStrafePits(_unitname) end

---Toggle status of flaring direct hits of range targets.
---
------
---@param unitname string Name of the player unit.
function RANGE:_FlareDirectHitsOnOff(unitname) end

---Get the number of shells a unit currently has.
---
------
---@param unitname string Name of the player unit.
---@return NOTYPE #Number of shells left
function RANGE:_GetAmmo(unitname) end

---Get the number of shells a unit currently has.
---
------
---@param target RANGE.BombTarget Bomb target data.
---@return COORDINATE #Target coordinate.
function RANGE:_GetBombTargetCoordinate(target) end

---Returns the unit of a player and the player name.
---If the unit does not belong to a player, nil is returned.
---
------
---@param _unitName string Name of the player unit.
---@param PlayerName NOTYPE 
---@return UNIT #Unit of player.
---@return string #Name of the player.
---@return boolean #If true, group has > 1 player in it
function RANGE:_GetPlayerUnitAndName(_unitName, PlayerName) end

---Get max speed of controllable.
---
------
---@param controllable CONTROLLABLE 
---@return NOTYPE #Maximum speed in km/h.
function RANGE:_GetSpeed(controllable) end

---Illuminate targets.
---Fires illumination bombs at one random bomb and one random strafe target at a random altitude between 400 and 800 m.
---
------
---@param _unitName? string (Optional) Name of the player unit.
function RANGE:_IlluminateBombTargets(_unitName) end

---Mark targets on F10 map.
---
------
---@param _unitName string Name of the player unit.
function RANGE:_MarkTargetsOnMap(_unitName) end

---Toggle display messages to player.
---
------
---@param unitname string Name of the player unit.
function RANGE:_MessagesToPlayerOnOff(unitname) end

---Function called on impact of a tracked weapon.
---
------
---@param self RANGE RANGE object.
---@param playerData RANGE.PlayerData Player data table.
---@param attackHdg number Attack heading.
---@param attackAlt number Attack altitude.
---@param attackVel number Attack velocity.
function RANGE._OnImpact(weapon, self, playerData, attackHdg, attackAlt, attackVel) end

---Reset player statistics.
---
------
---@param _unitName string Name of the player unit.
function RANGE:_ResetRangeStats(_unitName) end

---Save target sheet.
---
------
---@param _playername string Player name.
---@param result RANGE.StrafeResult Results table.
function RANGE:_SaveTargetSheet(_playername, result) end

---Toggle status of time delay for smoking bomb impact points
---
------
---@param unitname string Name of the player unit.
function RANGE:_SmokeBombDelayOnOff(unitname) end

---Toggle status of smoking bomb impact points.
---
------
---@param unitname string Name of the player unit.
function RANGE:_SmokeBombImpactOnOff(unitname) end

---Mark bombing targets with smoke.
---
------
---@param unitname string Name of the player unit.
function RANGE:_SmokeBombTargets(unitname) end

---Mark approach boxes of strafe targets with smoke.
---
------
---@param unitname string Name of the player unit.
function RANGE:_SmokeStrafeTargetBoxes(unitname) end

---Mark strafing targets with smoke.
---
------
---@param unitname string Name of the player unit.
function RANGE:_SmokeStrafeTargets(unitname) end

---Targetsheet saves if player on or off.
---
------
---@param _unitname string Name of the player unit.
function RANGE:_TargetsheetOnOff(_unitname) end

---Triggers the FSM delayed event "EnterRange".
---
------
---@param delay number Delay in seconds before the function is called.
---@param player RANGE.PlayerData Data of player settings etc.
function RANGE:__EnterRange(delay, player) end

---Triggers the FSM delayed event "ExitRange".
---
------
---@param delay number Delay in seconds before the function is called.
---@param player RANGE.PlayerData Data of player settings etc.
function RANGE:__ExitRange(delay, player) end

---Triggers the FSM delayed event "Impact".
---
------
---@param delay number Delay in seconds before the function is called.
---@param result RANGE.BombResult Data of the bombing run.
---@param player RANGE.PlayerData Data of player settings etc.
function RANGE:__Impact(delay, result, player) end

---Triggers the FSM event "Start" after a delay.
---Starts the RANGE. Initializes parameters and starts event handlers.
---
------
---@param delay number Delay in seconds.
function RANGE:__Start(delay) end

---Triggers the FSM event "Status" after a delay.
---
------
---@param delay number Delay in seconds.
function RANGE:__Status(delay) end

---Triggers the FSM event "Stop" after a delay.
---Stops the RANGE and all its event handlers.
---
------
---@param delay number Delay in seconds.
function RANGE:__Stop(delay) end

---Sets the flare color used to flare players direct target hits.
---
------
---@param color FLARECOLOR Color Id.
---@return string #Color text.
function RANGE:_flarecolor2text(color) end

---Returns a string which consists of the player name.
---
------
---@param unitname string Name of the player unit.
function RANGE:_myname(unitname) end

---Sets the flare color used when player makes a direct hit on target.
---
------
---@param _unitName string Name of the player unit.
---@param color FLARECOLOR ID of flare color.
function RANGE:_playerflarecolor(_unitName, color) end

---Sets the smoke color used to smoke players bomb impact points.
---
------
---@param _unitName string Name of the player unit.
---@param color SMOKECOLOR ID of the smoke color.
function RANGE:_playersmokecolor(_unitName, color) end

---Converts a smoke color id to text.
---E.g. SMOKECOLOR.Blue --> "blue".
---
------
---@param color SMOKECOLOR Color Id.
---@return string #Color text.
function RANGE:_smokecolor2text(color) end

---Function called after player enters the range zone.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param player RANGE.PlayerData Player data.
---@private
function RANGE:onafterEnterRange(From, Event, To, player) end

---Function called after player leaves the range zone.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param player RANGE.PlayerData Player data.
---@private
function RANGE:onafterExitRange(From, Event, To, player) end

---Function called after bomb impact on range.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param result RANGE.BombResult Result of bomb impact.
---@param player RANGE.PlayerData Player data table.
---@private
function RANGE:onafterImpact(From, Event, To, result, player) end

---On after "Load" event.
---Loads results of all players from file.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function RANGE:onafterLoad(From, Event, To) end

---Function called after save.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function RANGE:onafterSave(From, Event, To) end

---Initializes number of targets and location of the range.
---Starts the event handlers.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function RANGE:onafterStart(From, Event, To) end

---Check spawn queue and spawn aircraft if necessary.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function RANGE:onafterStatus(From, Event, To) end

---Function called after strafing run.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param player RANGE.PlayerData Player data table.
---@param result RANGE.StrafeResult Result of run.
---@private
function RANGE:onafterStrafeResult(From, Event, To, player, result) end

---Function called before save event.
---Checks that io and lfs are desanitized.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function RANGE:onbeforeLoad(From, Event, To) end

---Function called before save event.
---Checks that io and lfs are desanitized.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function RANGE:onbeforeSave(From, Event, To) end


---Bomb target result.
---@class RANGE.BombResult 
---@field private airframe string Aircraft type of player.
---@field private attackAlt number Attack altitude in feet.
---@field private attackHdg number Attack heading in degrees.
---@field private attackVel number Attack velocity in knots.
---@field private clock string Time of the run.
---@field private command NOTYPE 
---@field private date string OS date.
---@field private distance number Distance in meters.
---@field private midate NOTYPE 
---@field private name string Name of closest target.
---@field private player string Player name.
---@field private quality string Hit quality.
---@field private radial number Radial in degrees.
---@field private rangename string Name of the range.
---@field private roundsFired number 
---@field private roundsHit number 
---@field private roundsQuality string 
---@field private theatre NOTYPE 
---@field private time number Time via timer.getAbsTime() in seconds of impact.
---@field private weapon string Name of the weapon.
RANGE.BombResult = {}


---Bomb target data.
---@class RANGE.BombTarget 
---@field private coordinate COORDINATE Coordinate of the target.
---@field private goodhitrange number Range in meters for a good hit.
---@field private move boolean If true, unit move randomly.
---@field private name string Name of unit.
---@field private speed number Speed of unit.
---@field private target UNIT Target unit.
---@field private type RANGE.TargetType Type of target.
RANGE.BombTarget = {}


---Default range parameters.
---@class RANGE.Defaults 
---@field TdelaySmoke number 
---@field Tmsg number 
---@field private boxlength number 
---@field private boxwidth number 
---@field private dtBombtrack number 
---@field private foulline number 
---@field private goodhitrange number 
---@field private goodpass number 
---@field private ndisplayresult number 
---@field private rangeradius number 
---@field private strafemaxalt number 
RANGE.Defaults = {}


---Player settings.
---@class RANGE.PlayerData 
---@field private airframe string Aircraft type name.
---@field private client CLIENT Client object of player.
---@field private flarecolor number Color of flares.
---@field private flaredirecthits boolean Flare when player directly hits a target.
---@field private inzone boolean If true, player is inside the range zone.
---@field private messages boolean Display info messages.
---@field private playername string Name of player.
---@field private smokebombimpact boolean Smoke bomb impact points.
---@field private smokecolor number Color of smoke.
---@field private targeton boolean Target on.
---@field private unit UNIT Player unit.
---@field private unitname string Name of player aircraft unit.
RANGE.PlayerData = {}


---Sound files.
---@class RANGE.Sound 
---@field IR0 RANGE.Soundfile 
---@field IR1 RANGE.Soundfile 
---@field IR2 RANGE.Soundfile 
---@field IR3 RANGE.Soundfile 
---@field IR4 RANGE.Soundfile 
---@field IR5 RANGE.Soundfile 
---@field IR6 RANGE.Soundfile 
---@field IR7 RANGE.Soundfile 
---@field IR8 RANGE.Soundfile 
---@field IR9 RANGE.Soundfile 
---@field IRDecimal RANGE.Soundfile 
---@field IREnterRange RANGE.Soundfile 
---@field IRExitRange RANGE.Soundfile 
---@field IRMegaHertz RANGE.Soundfile 
---@field RC0 RANGE.Soundfile 
---@field RC1 RANGE.Soundfile 
---@field RC2 RANGE.Soundfile 
---@field RC3 RANGE.Soundfile 
---@field RC4 RANGE.Soundfile 
---@field RC5 RANGE.Soundfile 
---@field RC6 RANGE.Soundfile 
---@field RC7 RANGE.Soundfile 
---@field RC8 RANGE.Soundfile 
---@field RC9 RANGE.Soundfile 
---@field RCAccuracy RANGE.Soundfile 
---@field RCDegrees RANGE.Soundfile 
---@field RCExcellentHit RANGE.Soundfile 
---@field RCExcellentPass RANGE.Soundfile 
---@field RCFeet RANGE.Soundfile 
---@field RCFor RANGE.Soundfile 
---@field RCGoodHit RANGE.Soundfile 
---@field RCGoodPass RANGE.Soundfile 
---@field RCHitsOnTarget RANGE.Soundfile 
---@field RCImpact RANGE.Soundfile 
---@field RCIneffectiveHit RANGE.Soundfile 
---@field RCIneffectivePass RANGE.Soundfile 
---@field RCInvalidHit RANGE.Soundfile 
---@field RCLeftStrafePitTooQuickly RANGE.Soundfile 
---@field RCPercent RANGE.Soundfile 
---@field RCPoorHit RANGE.Soundfile 
---@field RCPoorPass RANGE.Soundfile 
---@field RCRollingInOnStrafeTarget RANGE.Soundfile 
---@field RCTotalRoundsFired RANGE.Soundfile 
---@field RCWeaponImpactedTooFar RANGE.Soundfile 
RANGE.Sound = {}


---Sound file data.
---@class RANGE.Soundfile 
---@field private duration number Duration in seconds.
---@field private filename string Name of the file
RANGE.Soundfile = {}


---Strafe result.
---@class RANGE.StrafeResult 
---@field private airframe string Aircraft type of player.
---@field private clock string Time of the run.
---@field private command NOTYPE 
---@field private date string OS date.
---@field private invalid boolean Invalid pass.
---@field private midate NOTYPE 
---@field private name string Name of the target pit.
---@field private player string Player name.
---@field private rangename string Name of the range.
---@field private roundsFired number Number of rounds fired.
---@field private roundsHit number Number of rounds that hit the target.
---@field private roundsQuality NOTYPE 
---@field private strafeAccuracy number Accuracy of the run in percent.
---@field private theatre NOTYPE 
---@field private time number Time via timer.getAbsTime() in seconds of impact.
RANGE.StrafeResult = {}


---Strafe status for player.
---@class RANGE.StrafeStatus 
---@field private ammo number Amount of ammo.
---@field private hits number Number of hits on target.
---@field private pastfoulline boolean If `true`, player passed foul line. Invalid pass.
---@field private time number Number of times.
---@field private zone RANGE.StrafeTarget Strafe target.
RANGE.StrafeStatus = {}


---Strafe target data.
---@class RANGE.StrafeTarget 
---@field private coordinate COORDINATE Center coordinate of the pit.
---@field private foulline number Foul line
---@field private goodPass number Number of hits for a good pass.
---@field private heading number Heading of pit.
---@field private name string Name of the unit.
---@field private polygon ZONE_POLYGON Polygon zone.
---@field private smokepoints number Number of smoke points.
---@field private targets table Table of target units.
RANGE.StrafeTarget = {}


---Target type, i.e.
---unit, static, or coordinate.
---@class RANGE.TargetType 
---@field COORD string Target is a coordinate.
---@field SCENERY string Target is a scenery object.
---@field STATIC string Target is a static object.
---@field UNIT string Target is a unitobject.
RANGE.TargetType = {}



