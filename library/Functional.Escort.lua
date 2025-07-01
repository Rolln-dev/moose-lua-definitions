---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Escorting.JPG" width="100%">
---
---**Functional** - Taking the lead of AI escorting your flight.
---
---===
---
---## Features:
---
---  * Escort navigation commands.
---  * Escort hold at position commands.
---  * Escorts reporting detected targets.
---  * Escorts scanning targets in advance.
---  * Escorts attacking specific targets.
---  * Request assistance from other groups for attack.
---  * Manage rule of engagement of escorts.
---  * Manage the allowed evasion techniques of escorts.
---  * Make escort to execute a defined mission or path.
---  * Escort tactical situation reporting.
---
---===
---
---## Additional Material:
---
---* **Demo Missions:** [GitHub](https://github.com/FlightControl-Master/MOOSE_MISSIONS/tree/master/Functional/Escort)
---* **YouTube videos:** None
---* **Guides:** None
---
---===
---
---Allows you to interact with escorting AI on your flight and take the lead.
---
---Each escorting group can be commanded with a whole set of radio commands (radio menu in your flight, and then F10).
---
---The radio commands will vary according the category of the group. The richest set of commands are with Helicopters and AirPlanes.
---Ships and Ground troops will have a more limited set, but they can provide support through the bombing of targets designated by the other escorts.
---
---# RADIO MENUs that can be created:
---
---Find a summary below of the current available commands:
---
---## Navigation ...:
---
---Escort group navigation functions:
---
---  * **"Join-Up and Follow at x meters":** The escort group fill follow you at about x meters, and they will follow you.
---  * **"Flare":** Provides menu commands to let the escort group shoot a flare in the air in a color.
---  * **"Smoke":** Provides menu commands to let the escort group smoke the air in a color. Note that smoking is only available for ground and naval troops.
---
---## Hold position ...:
---
---Escort group navigation functions:
---
---  * **"At current location":** Stops the escort group and they will hover 30 meters above the ground at the position they stopped.
---  * **"At client location":** Stops the escort group and they will hover 30 meters above the ground at the position they stopped.
---
---## Report targets ...:
---
---Report targets will make the escort group to report any target that it identifies within a 8km range. Any detected target can be attacked using the 4. Attack nearby targets function. (see below).
---
---  * **"Report now":** Will report the current detected targets.
---  * **"Report targets on":** Will make the escort group to report detected targets and will fill the "Attack nearby targets" menu list.
---  * **"Report targets off":** Will stop detecting targets.
---
---## Scan targets ...:
---
---Menu items to pop-up the escort group for target scanning. After scanning, the escort group will resume with the mission or defined task.
---
---  * **"Scan targets 30 seconds":** Scan 30 seconds for targets.
---  * **"Scan targets 60 seconds":** Scan 60 seconds for targets.
---
---## Attack targets ...:
---
---This menu item will list all detected targets within a 15km range. Depending on the level of detection (known/unknown) and visuality, the targets type will also be listed.
---
---## Request assistance from ...:
---
---This menu item will list all detected targets within a 15km range, as with the menu item **Attack Targets**.
---This menu item allows to request attack support from other escorts supporting the current client group.
---eg. the function allows a player to request support from the Ship escort to attack a target identified by the Plane escort with its Tomahawk missiles.
---eg. the function allows a player to request support from other Planes escorting to bomb the unit with illumination missiles or bombs, so that the main plane escort can attack the area.
---
---## ROE ...:
---
---Sets the Rules of Engagement (ROE) of the escort group when in flight.
---
---  * **"Hold Fire":** The escort group will hold fire.
---  * **"Return Fire":** The escort group will return fire.
---  * **"Open Fire":** The escort group will open fire on designated targets.
---  * **"Weapon Free":** The escort group will engage with any target.
---
---## Evasion ...:
---
---Will define the evasion techniques that the escort group will perform during flight or combat.
---
---  * **"Fight until death":** The escort group will have no reaction to threats.
---  * **"Use flares, chaff and jammers":** The escort group will use passive defense using flares and jammers. No evasive manoeuvres are executed.
---  * **"Evade enemy fire":** The rescort group will evade enemy fire before firing.
---  * **"Go below radar and evade fire":** The escort group will perform evasive vertical manoeuvres.
---
---## Resume Mission ...:
---
---Escort groups can have their own mission. This menu item will allow the escort group to resume their Mission from a given waypoint.
---Note that this is really fantastic, as you now have the dynamic of taking control of the escort groups, and allowing them to resume their path or mission.
---
---===
---
---### Authors: **FlightControl** 
---
---===
---ESCORT class
---
---# ESCORT construction methods.
---
---Create a new SPAWN object with the #ESCORT.New method:
---
--- * #ESCORT.New: Creates a new ESCORT object from a Wrapper.Group#GROUP for a Wrapper.Client#CLIENT, with an optional briefing text.
---@class ESCORT : BASE
---@field CT1 number 
---@field Detection NOTYPE 
---@field EscortBriefing NOTYPE 
---@field EscortClient CLIENT 
---@field EscortGroup GROUP 
---@field EscortMenu NOTYPE 
---@field EscortMenuAttackNearbyTargets NOTYPE 
---@field EscortMenuEvasion NOTYPE 
---@field EscortMenuEvasionEvadeFire NOTYPE 
---@field EscortMenuEvasionNoReaction NOTYPE 
---@field EscortMenuEvasionPassiveDefense NOTYPE 
---@field EscortMenuFlare NOTYPE 
---@field EscortMenuFlareGreen NOTYPE 
---@field EscortMenuFlareRed NOTYPE 
---@field EscortMenuFlareWhite NOTYPE 
---@field EscortMenuFlareYellow NOTYPE 
---@field EscortMenuHold NOTYPE 
---@field EscortMenuHoldAtLeaderPosition table 
---@field EscortMenuHoldPosition table 
---@field EscortMenuJoinUpAndFollow table 
---@field EscortMenuOptionEvasionVertical NOTYPE 
---@field EscortMenuROE NOTYPE 
---@field EscortMenuROEHoldFire NOTYPE 
---@field EscortMenuROEOpenFire NOTYPE 
---@field EscortMenuROEReturnFire NOTYPE 
---@field EscortMenuROEWeaponFree NOTYPE 
---@field EscortMenuReportNavigation NOTYPE 
---@field EscortMenuReportNearbyTargets NOTYPE 
---@field EscortMenuReportNearbyTargetsNow NOTYPE 
---@field EscortMenuReportNearbyTargetsOff NOTYPE 
---@field EscortMenuReportNearbyTargetsOn NOTYPE 
---@field EscortMenuResumeMission NOTYPE 
---@field EscortMenuScan NOTYPE 
---@field EscortMenuScanForTargets table 
---@field EscortMenuSmoke NOTYPE 
---@field EscortMenuSmokeBlue NOTYPE 
---@field EscortMenuSmokeGreen NOTYPE 
---@field EscortMenuSmokeOrange NOTYPE 
---@field EscortMenuSmokeRed NOTYPE 
---@field EscortMenuSmokeWhite NOTYPE 
---@field EscortMenuTargetAssistance NOTYPE 
---@field EscortMode ESCORT.MODE The mode the escort is in.
---@field EscortName string 
---@field EscortSetGroup NOTYPE 
---@field FollowDistance number The current follow distance.
---@field FollowScheduler SCHEDULER The instance of the SCHEDULER class.
---@field GT1 number 
---@field OptionReactionOnThreat AI.Option.Air.val.REACTION_ON_THREAT Which REACTION_ON_THREAT is set to the EscortGroup.
---@field ReportTargets boolean If true, nearby targets are reported.
ESCORT = {}

---JoinsUp and Follows a CLIENT.
---
------
---@param self ESCORT 
---@param EscortGroup GROUP 
---@param EscortClient CLIENT 
---@param Distance Distance 
function ESCORT:JoinUpAndFollow(EscortGroup, EscortClient, Distance) end

---Defines a menu slot to let the escort attack its detected targets using assisted attack from another escort joined also with the client.
---This menu will appear under **Request assistance from**.
---Note that this method needs to be preceded with the method MenuReportTargets.
---
------
---@param self ESCORT 
---@return ESCORT #
function ESCORT:MenuAssistedAttack() end

---Defines a menu to let the escort set its evasion when under threat.
---All rules of engagement will appear under the menu **Evasion**.
---
------
---@param self ESCORT 
---@param MenuTextFormat NOTYPE 
---@return ESCORT #
function ESCORT:MenuEvasion(MenuTextFormat) end

---Defines a menu slot to let the escort disperse a flare in a certain color.
---This menu will appear under **Navigation**.
---The flare will be fired from the first unit in the group.
---
------
---@param self ESCORT 
---@param MenuTextFormat string Optional parameter that shows the menu option text. If no text is given, the default text will be displayed.
---@return ESCORT #
function ESCORT:MenuFlare(MenuTextFormat) end

---Defines a menu slot to let the escort Join and Follow you at a certain distance.
---This menu will appear under **Navigation**.
---
------
---@param self ESCORT 
---@param Distance Distance The distance in meters that the escort needs to follow the client.
---@return ESCORT #
function ESCORT:MenuFollowAt(Distance) end

---Defines a menu slot to let the escort hold at their current position and stay low with a specified height during a specified time in seconds.
---This menu will appear under **Hold position**.
---
------
---@param self ESCORT 
---@param Height Distance Optional parameter that sets the height in meters to let the escort orbit at the current location. The default value is 30 meters.
---@param Seconds Time Optional parameter that lets the escort orbit at the current position for a specified time. (not implemented yet). The default value is 0 seconds, meaning, that the escort will orbit forever until a sequent command is given.
---@param MenuTextFormat string Optional parameter that shows the menu option text. The text string is formatted, and should contain two %d tokens in the string. The first for the Height, the second for the Time (if given). If no text is given, the default text will be displayed.
---@return ESCORT #TODO: Implement Seconds parameter. Challenge is to first develop the "continue from last activity" function.
function ESCORT:MenuHoldAtEscortPosition(Height, Seconds, MenuTextFormat) end

---Defines a menu slot to let the escort hold at the client position and stay low with a specified height during a specified time in seconds.
---This menu will appear under **Navigation**.
---
------
---@param self ESCORT 
---@param Height Distance Optional parameter that sets the height in meters to let the escort orbit at the current location. The default value is 30 meters.
---@param Seconds Time Optional parameter that lets the escort orbit at the current position for a specified time. (not implemented yet). The default value is 0 seconds, meaning, that the escort will orbit forever until a sequent command is given.
---@param MenuTextFormat string Optional parameter that shows the menu option text. The text string is formatted, and should contain one or two %d tokens in the string. The first for the Height, the second for the Time (if given). If no text is given, the default text will be displayed.
---@return ESCORT #TODO: Implement Seconds parameter. Challenge is to first develop the "continue from last activity" function.
function ESCORT:MenuHoldAtLeaderPosition(Height, Seconds, MenuTextFormat) end

---Defines a menu to let the escort set its rules of engagement.
---All rules of engagement will appear under the menu **ROE**.
---
------
---@param self ESCORT 
---@param MenuTextFormat NOTYPE 
---@return ESCORT #
function ESCORT:MenuROE(MenuTextFormat) end

---Defines a menu slot to let the escort report their current detected targets with a specified time interval in seconds.
---This menu will appear under **Report targets**.
---Note that if a report targets menu is not specified, no targets will be detected by the escort, and the attack and assisted attack menus will not be displayed.
---
------
---@param self ESCORT 
---@param Seconds Time Optional parameter that lets the escort report their current detected targets after specified time interval in seconds. The default time is 30 seconds.
---@return ESCORT #
function ESCORT:MenuReportTargets(Seconds) end

---Defines a menu to let the escort resume its mission from a waypoint on its route.
---All rules of engagement will appear under the menu **Resume mission from**.
---
------
---@param self ESCORT 
---@return ESCORT #
function ESCORT:MenuResumeMission() end

---Defines a menu slot to let the escort scan for targets at a certain height for a certain time in seconds.
---This menu will appear under **Scan targets**.
---
------
---@param self ESCORT 
---@param Height Distance Optional parameter that sets the height in meters to let the escort orbit at the current location. The default value is 30 meters.
---@param Seconds Time Optional parameter that lets the escort orbit at the current position for a specified time. (not implemented yet). The default value is 0 seconds, meaning, that the escort will orbit forever until a sequent command is given.
---@param MenuTextFormat string Optional parameter that shows the menu option text. The text string is formatted, and should contain one or two %d tokens in the string. The first for the Height, the second for the Time (if given). If no text is given, the default text will be displayed.
---@return ESCORT #
function ESCORT:MenuScanForTargets(Height, Seconds, MenuTextFormat) end

---Defines a menu slot to let the escort disperse a smoke in a certain color.
---This menu will appear under **Navigation**.
---Note that smoke menu options will only be displayed for ships and ground units. Not for air units.
---The smoke will be fired from the first unit in the group.
---
------
---@param self ESCORT 
---@param MenuTextFormat string Optional parameter that shows the menu option text. If no text is given, the default text will be displayed.
---@return ESCORT #
function ESCORT:MenuSmoke(MenuTextFormat) end

---Defines the default menus
---
------
---@param self ESCORT 
---@return ESCORT #
function ESCORT:Menus() end

---ESCORT class constructor for an AI group
---
------
---
---USAGE
---```
----- Declare a new EscortPlanes object as follows:
---
----- First find the GROUP object and the CLIENT object.
---local EscortClient = CLIENT:FindByName( "Unit Name" ) -- The Unit Name is the name of the unit flagged with the skill Client in the mission editor.
---local EscortGroup = GROUP:FindByName( "Group Name" ) -- The Group Name is the name of the group that will escort the Escort Client.
---
----- Now use these 2 objects to construct the new EscortPlanes object.
---EscortPlanes = ESCORT:New( EscortClient, EscortGroup, "Desert", "Welcome to the mission. You are escorted by a plane with code name 'Desert', which can be instructed through the F10 radio menu." )
---```
------
---@param self ESCORT 
---@param EscortClient CLIENT The client escorted by the EscortGroup.
---@param EscortGroup GROUP The group AI escorting the EscortClient.
---@param EscortName string Name of the escort.
---@param EscortBriefing string A text showing the ESCORT briefing to the player. Note that if no EscortBriefing is provided, the default briefing will be shown.
---@return ESCORT #self
function ESCORT:New(EscortClient, EscortGroup, EscortName, EscortBriefing) end

---Registers the waypoints
---
------
---@param self ESCORT 
---@return table #
function ESCORT:RegisterRoute() end

---Set a Detection method for the EscortClient to be reported upon.
---Detection methods are based on the derived classes from DETECTION_BASE.
---
------
---@param self ESCORT 
---@param Detection DETECTION_BASE 
function ESCORT:SetDetection(Detection) end

---This function is for test, it will put on the frequency of the FollowScheduler a red smoke at the direction vector calculated for the escort to fly to.
---This allows to visualize where the escort is flying to.
---
------
---@param self ESCORT 
---@param SmokeDirection boolean If true, then the direction vector will be smoked.
function ESCORT:TestSmokeDirectionVector(SmokeDirection) end


---
------
---@param self ESCORT 
---@param DetectedItem DETECTION_BASE.DetectedItem 
---@param EscortGroupAttack NOTYPE 
function ESCORT:_AssistTarget(DetectedItem, EscortGroupAttack) end


---
------
---@param self NOTYPE 
---@param DetectedItem NOTYPE 
function ESCORT:_AttackTarget(DetectedItem) end


---
------
---@param self NOTYPE 
---@param Color NOTYPE 
---@param Message NOTYPE 
function ESCORT:_Flare(Color, Message) end


---
------
---@param self NOTYPE 
function ESCORT:_FollowScheduler() end


---
------
---@param self NOTYPE 
---@param OrbitGroup NOTYPE 
---@param OrbitHeight NOTYPE 
---@param OrbitSeconds NOTYPE 
function ESCORT:_HoldPosition(OrbitGroup, OrbitHeight, OrbitSeconds) end


---
------
---@param self NOTYPE 
---@param Distance NOTYPE 
function ESCORT:_JoinUpAndFollow(Distance) end


---
------
---@param self NOTYPE 
---@param EscortROEFunction NOTYPE 
---@param EscortROEMessage NOTYPE 
function ESCORT:_ROE(EscortROEFunction, EscortROEMessage) end


---
------
---@param self NOTYPE 
---@param EscortROTFunction NOTYPE 
---@param EscortROTMessage NOTYPE 
function ESCORT:_ROT(EscortROTFunction, EscortROTMessage) end


---
------
---@param self NOTYPE 
function ESCORT:_ReportNearbyTargetsNow() end

---Report Targets Scheduler.
---
------
---@param self ESCORT 
function ESCORT:_ReportTargetsScheduler() end


---
------
---@param self NOTYPE 
---@param WayPoint NOTYPE 
function ESCORT:_ResumeMission(WayPoint) end


---
------
---@param self NOTYPE 
---@param ScanDuration NOTYPE 
function ESCORT:_ScanTargets(ScanDuration) end


---
------
---@param self NOTYPE 
---@param Color NOTYPE 
---@param Message NOTYPE 
function ESCORT:_Smoke(Color, Message) end


---
------
---@param self NOTYPE 
---@param ReportTargets NOTYPE 
function ESCORT:_SwitchReportNearbyTargets(ReportTargets) end


---ESCORT.Mode class
---@class ESCORT.MODE 
---@field FOLLOW number 
---@field MISSION number 
ESCORT.MODE = {}


---MENUPARAM type
---@class MENUPARAM 
---@field ParamDistance Distance 
---@field ParamFunction function 
---@field ParamMessage string 
---@field ParamSelf ESCORT 
MENUPARAM = {}



