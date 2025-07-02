---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Escorting.JPG" width="100%">
---
---**AI** - Taking the lead of AI escorting your flight or of other AI.
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
---## Missions:
---
---[ESC - Escorting](https://github.com/FlightControl-Master/MOOSE_MISSIONS/tree/master/AI/AI_Escort)
---
---===
---
---Allows you to interact with escorting AI on your flight and take the lead.
---
---![Banner Image](..\Images\deprecated.png)
---
---Each escorting group can be commanded with a complete set of radio commands (radio menu in your flight, and then F10).
---
---The radio commands will vary according the category of the group. The richest set of commands are with helicopters and airPlanes.
---Ships and Ground troops will have a more limited set, but they can provide support through the bombing of targets designated by the other escorts.
---
---Escorts detect targets using a built-in detection mechanism. The detected targets are reported at a specified time interval.
---Once targets are reported, each escort has these targets as menu options to command the attack of these targets.
---Targets are by default grouped per area of 5000 meters, but the kind of detection and the grouping range can be altered.
---
---Different formations can be selected in the Flight menu: Trail, Stack, Left Line, Right Line, Left Wing, Right Wing, Central Wing and Boxed formations are available.
---The Flight menu also allows for a mass attack, where all of the escorts are commanded to attack a target.
---
---Escorts can emit flares to reports their location. They can be commanded to hold at a location, which can be their current or the leader location.
---In this way, you can spread out the escorts over the battle field before a coordinated attack.
---
---But basically, the escort class provides 4 modes of operation, and depending on the mode, you are either leading the flight, or following the flight.
---
---## Leading the flight
---
---When leading the flight, you are expected to guide the escorts towards the target areas, 
---and carefully coordinate the attack based on the threat levels reported, and the available weapons
---carried by the escorts. Ground ships or ground troops can execute A-assisted attacks, when they have long-range ground precision weapons for attack.
---
---## Following the flight
---
---Escorts can be commanded to execute a specific mission path. In this mode, the escorts are in the lead.
---You as a player, are following the escorts, and are commanding them to progress the mission while
---ensuring that the escorts survive. You are joining the escorts in the battlefield. They will detect and report targets
---and you will ensure that the attacks are well coordinated, assigning the correct escort type for the detected target
---type. Once the attack is finished, the escort will resume the mission it was assigned.
---In other words, you can use the escorts for reconnaissance, and for guiding the attack.
---Imagine you as a mi-8 pilot, assigned to pickup cargo. Two ka-50s are guiding the way, and you are
---following. You are in control. The ka-50s detect targets, report them, and you command how the attack
---will commence and from where. You can control where the escorts are holding position and which targets
---are attacked first. You are in control how the ka-50s will follow their mission path.
---
---Escorts can act as part of a AI A2G dispatcher offensive. In this way, You was a player are in control.
---The mission is defined by the A2G dispatcher, and you are responsible to join the flight and ensure that the
---attack is well coordinated.
---
---It is with great proud that I present you this class, and I hope you will enjoy the functionality and the dynamism
---it brings in your DCS world simulations.
---
---# RADIO MENUs that can be created:
---
---Find a summary below of the current available commands:
---
---## Navigation ...:
---
---Escort group navigation functions:
---
---  * **"Join-Up":** The escort group fill follow you in the assigned formation.
---  * **"Flare":** Provides menu commands to let the escort group shoot a flare in the air in a color.
---  * **"Smoke":** Provides menu commands to let the escort group smoke the air in a color. Note that smoking is only available for ground and naval troops.
---
---## Hold position ...:
---
---Escort group navigation functions:
---
---  * **"At current location":** The escort group will hover above the ground at the position they were. The altitude can be specified as a parameter.
---  * **"At my location":** The escort group will hover or orbit at the position where you are. The escort will fly to your location and hold position. The altitude can be specified as a parameter.
---
---## Report targets ...:
---
---Report targets will make the escort group to report any target that it identifies within detection range. Any detected target can be attacked using the "Attack Targets" menu function. (see below).
---
---  * **"Report now":** Will report the current detected targets.
---  * **"Report targets on":** Will make the escorts to report the detected targets and will fill the "Attack Targets" menu list.
---  * **"Report targets off":** Will stop detecting targets.
---
---## Attack targets ...:
---
---This menu item will list all detected targets within a 15km range. Depending on the level of detection (known/unknown) and visuality, the targets type will also be listed.
---This menu will be available in Flight menu or in each Escort menu.
---
---## Scan targets ...:
---
---Menu items to pop-up the escort group for target scanning. After scanning, the escort group will resume with the mission or rejoin formation.
---
---  * **"Scan targets 30 seconds":** Scan 30 seconds for targets.
---  * **"Scan targets 60 seconds":** Scan 60 seconds for targets.
---
---## Request assistance from ...:
---
---This menu item will list all detected targets within a 15km range, similar as with the menu item **Attack Targets**.
---This menu item allows to request attack support from other ground based escorts supporting the current escort.
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
---AI_ESCORT class
---
---# AI_ESCORT construction methods.
---
---Create a new AI_ESCORT object with the #AI_ESCORT.New method:
---
--- * #AI_ESCORT.New: Creates a new AI_ESCORT object from a Wrapper.Group#GROUP for a Wrapper.Client#CLIENT, with an optional briefing text.
---@class AI_ESCORT : AI_FORMATION
---@field CT1 number 
---@field Detection NOTYPE 
---@field EscortBriefing NOTYPE 
---@field EscortGroupSet NOTYPE 
---@field EscortMenuScan NOTYPE 
---@field EscortMenuScanForTargets table 
---@field EscortMenuTargetAssistance NOTYPE 
---@field EscortName NOTYPE 
---@field FollowDistance number 
---@field GT1 number 
---@field Menu table 
---@field PlayerGroup GROUP 
---@field PlayerUnit UNIT 
AI_ESCORT = {}

---Measure distance between coordinate player and coordinate detected item.
---
------
---@param PlayerUnit NOTYPE 
---@param DetectedItem NOTYPE 
function AI_ESCORT:Distance(PlayerUnit, DetectedItem) end


---
------
function AI_ESCORT:GetFlightReportType() end

---Defines a menu slot to let the escort attack its detected targets using assisted attack from another escort joined also with the client.
---This menu will appear under **Request assistance from**.
---Note that this method needs to be preceded with the method MenuTargets.
---
------
---@return AI_ESCORT #
function AI_ESCORT:MenuAssistedAttack() end

---Defines a menu slot to let the escort disperse a flare in a certain color.
---This menu will appear under **Navigation**.
---The flare will be fired from the first unit in the group.
---
------
---@param MenuTextFormat string Optional parameter that shows the menu option text. If no text is given, the default text will be displayed.
---@return AI_ESCORT #
function AI_ESCORT:MenuFlare(MenuTextFormat) end


---
------
---@param Formation NOTYPE 
---@param ... NOTYPE 
function AI_ESCORT:MenuFormation(Formation, ...) end

---Defines a menu slot to let the escort to join in a box formation.
---This menu will appear under **Formation**.
---
------
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param YSpace number The space between groups on the Y-axis in meters for each sequent group.
---@param ZStart number The start position on the Z-axis in meters for the first group.
---@param ZSpace number The space between groups on the Z-axis in meters for each sequent group.
---@param ZLevels number The amount of levels on the Z-axis.
---@return AI_ESCORT #
function AI_ESCORT:MenuFormationBox(XStart, XSpace, YStart, YSpace, ZStart, ZSpace, ZLevels) end

---Defines a menu slot to let the escort to join in a center wing formation.
---This menu will appear under **Formation**.
---
------
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param YSpace number The space between groups on the Y-axis in meters for each sequent group.
---@param ZStart number The start position on the Z-axis in meters for the first group.
---@param ZSpace number The space between groups on the Z-axis in meters for each sequent group.
---@return AI_ESCORT #
function AI_ESCORT:MenuFormationCenterWing(XStart, XSpace, YStart, YSpace, ZStart, ZSpace) end

---Defines a menu slot to let the escort to join in a leFt wing formation.
---This menu will appear under **Formation**.
---
------
---@param XStart number The start position on the X-axis in meters for the first group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param ZStart number The start position on the Z-axis in meters for the first group.
---@param ZSpace number The space between groups on the Z-axis in meters for each sequent group.
---@return AI_ESCORT #
function AI_ESCORT:MenuFormationLeftLine(XStart, YStart, ZStart, ZSpace) end

---Defines a menu slot to let the escort to join in a left wing formation.
---This menu will appear under **Formation**.
---
------
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param ZStart number The start position on the Z-axis in meters for the first group.
---@param ZSpace number The space between groups on the Z-axis in meters for each sequent group.
---@return AI_ESCORT #
function AI_ESCORT:MenuFormationLeftWing(XStart, XSpace, YStart, ZStart, ZSpace) end

---Defines a menu slot to let the escort to join in a right line formation.
---This menu will appear under **Formation**.
---
------
---@param XStart number The start position on the X-axis in meters for the first group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param ZStart number The start position on the Z-axis in meters for the first group.
---@param ZSpace number The space between groups on the Z-axis in meters for each sequent group.
---@return AI_ESCORT #
function AI_ESCORT:MenuFormationRightLine(XStart, YStart, ZStart, ZSpace) end

---Defines a menu slot to let the escort to join in a right wing formation.
---This menu will appear under **Formation**.
---
------
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param ZStart number The start position on the Z-axis in meters for the first group.
---@param ZSpace number The space between groups on the Z-axis in meters for each sequent group.
---@return AI_ESCORT #
function AI_ESCORT:MenuFormationRightWing(XStart, XSpace, YStart, ZStart, ZSpace) end

---Defines a menu slot to let the escort to join in a stacked formation.
---This menu will appear under **Formation**.
---
------
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param YSpace number The space between groups on the Y-axis in meters for each sequent group.
---@return AI_ESCORT #
function AI_ESCORT:MenuFormationStack(XStart, XSpace, YStart, YSpace) end

---Defines a menu slot to let the escort to join in a trail formation.
---This menu will appear under **Formation**.
---
------
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@return AI_ESCORT #
function AI_ESCORT:MenuFormationTrail(XStart, XSpace, YStart) end

---Defines a menu slot to let the escort to join in a vic formation.
---This menu will appear under **Formation**.
---
------
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param YSpace number The space between groups on the Y-axis in meters for each sequent group.
---@param ZStart number The start position on the Z-axis in meters for the first group.
---@param ZSpace number The space between groups on the Z-axis in meters for each sequent group.
---@return AI_ESCORT #
function AI_ESCORT:MenuFormationVic(XStart, XSpace, YStart, YSpace, ZStart, ZSpace) end

---Defines a menu slot to let the escort hold at their current position and stay low with a specified height during a specified time in seconds.
---This menu will appear under **Hold position**.
---
------
---@param Height Distance Optional parameter that sets the height in meters to let the escort orbit at the current location. The default value is 30 meters.
---@param Speed Time Optional parameter that lets the escort orbit with a specified speed. The default value is a speed that is average for the type of airplane or helicopter.
---@param MenuTextFormat string Optional parameter that shows the menu option text. The text string is formatted, and should contain two %d tokens in the string. The first for the Height, the second for the Time (if given). If no text is given, the default text will be displayed.
---@return AI_ESCORT #
function AI_ESCORT:MenuHoldAtEscortPosition(Height, Speed, MenuTextFormat) end

---Defines a menu slot to let the escort hold at the client position and stay low with a specified height during a specified time in seconds.
---This menu will appear under **Navigation**.
---
------
---@param Height Distance Optional parameter that sets the height in meters to let the escort orbit at the current location. The default value is 30 meters.
---@param Speed Time Optional parameter that lets the escort orbit at the current position for a specified time. (not implemented yet). The default value is 0 seconds, meaning, that the escort will orbit forever until a sequent command is given.
---@param MenuTextFormat string Optional parameter that shows the menu option text. The text string is formatted, and should contain one or two %d tokens in the string. The first for the Height, the second for the Time (if given). If no text is given, the default text will be displayed.
---@return AI_ESCORT #
function AI_ESCORT:MenuHoldAtLeaderPosition(Height, Speed, MenuTextFormat) end

---Defines --- Defines a menu slot to let the escort to join formation.
---
------
---@return AI_ESCORT #
function AI_ESCORT:MenuJoinUp() end

---Defines a menu to let the escort set its rules of engagement.
---All rules of engagement will appear under the menu **ROE**.
---
------
---@return AI_ESCORT #
function AI_ESCORT:MenuROE() end

---Defines a menu to let the escort set its evasion when under threat.
---All rules of engagement will appear under the menu **Evasion**.
---
------
---@param MenuTextFormat NOTYPE 
---@return AI_ESCORT #
function AI_ESCORT:MenuROT(MenuTextFormat) end

---Defines a menu slot to let the escort scan for targets at a certain height for a certain time in seconds.
---This menu will appear under **Scan targets**.
---
------
---@param Height Distance Optional parameter that sets the height in meters to let the escort orbit at the current location. The default value is 30 meters.
---@param Seconds Time Optional parameter that lets the escort orbit at the current position for a specified time. (not implemented yet). The default value is 0 seconds, meaning, that the escort will orbit forever until a sequent command is given.
---@param MenuTextFormat string Optional parameter that shows the menu option text. The text string is formatted, and should contain one or two %d tokens in the string. The first for the Height, the second for the Time (if given). If no text is given, the default text will be displayed.
---@return AI_ESCORT #
function AI_ESCORT:MenuScanForTargets(Height, Seconds, MenuTextFormat) end

---Defines a menu slot to let the escort disperse a smoke in a certain color.
---This menu will appear under **Navigation**.
---Note that smoke menu options will only be displayed for ships and ground units. Not for air units.
---The smoke will be fired from the first unit in the group.
---
------
---@param MenuTextFormat string Optional parameter that shows the menu option text. If no text is given, the default text will be displayed.
---@return AI_ESCORT #
function AI_ESCORT:MenuSmoke(MenuTextFormat) end

---Defines a menu slot to let the escort report their current detected targets with a specified time interval in seconds.
---This menu will appear under **Report targets**.
---Note that if a report targets menu is not specified, no targets will be detected by the escort, and the attack and assisted attack menus will not be displayed.
---
------
---@param Seconds Time Optional parameter that lets the escort report their current detected targets after specified time interval in seconds. The default time is 30 seconds.
---@return AI_ESCORT #
function AI_ESCORT:MenuTargets(Seconds) end

---Defines the default menus for airplanes.
---
------
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param YSpace number The space between groups on the Y-axis in meters for each sequent group.
---@param ZStart number The start position on the Z-axis in meters for the first group.
---@param ZSpace number The space between groups on the Z-axis in meters for each sequent group.
---@param ZLevels number The amount of levels on the Z-axis.
---@return AI_ESCORT #
function AI_ESCORT:MenusAirplanes(XStart, XSpace, YStart, YSpace, ZStart, ZSpace, ZLevels) end

---Defines the default menus for helicopters.
---
------
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param YSpace number The space between groups on the Y-axis in meters for each sequent group.
---@param ZStart number The start position on the Z-axis in meters for the first group.
---@param ZSpace number The space between groups on the Z-axis in meters for each sequent group.
---@param ZLevels number The amount of levels on the Z-axis.
---@return AI_ESCORT #
function AI_ESCORT:MenusHelicopters(XStart, XSpace, YStart, YSpace, ZStart, ZSpace, ZLevels) end

---AI_ESCORT class constructor for an AI group
---
------
---
---USAGE
---```
----- Declare a new EscortPlanes object as follows:
---
----- First find the GROUP object and the CLIENT object.
---local EscortUnit = CLIENT:FindByName( "Unit Name" ) -- The Unit Name is the name of the unit flagged with the skill Client in the mission editor.
---local EscortGroup = SET_GROUP:New():FilterPrefixes("Escort"):FilterOnce() -- The the group name of the escorts contains "Escort".
---
----- Now use these 2 objects to construct the new EscortPlanes object.
---EscortPlanes = AI_ESCORT:New( EscortUnit, EscortGroup, "Desert", "Welcome to the mission. You are escorted by a plane with code name 'Desert', which can be instructed through the F10 radio menu." )
---EscortPlanes:MenusAirplanes() -- create menus for airplanes
---EscortPlanes:__Start(2)
---```
------
---@param EscortUnit CLIENT The client escorted by the EscortGroup.
---@param EscortGroupSet SET_GROUP The set of group AI escorting the EscortUnit.
---@param EscortName string Name of the escort.
---@param EscortBriefing string A text showing the AI_ESCORT briefing to the player. Note that if no EscortBriefing is provided, the default briefing will be shown.
---@return AI_ESCORT #self
function AI_ESCORT:New(EscortUnit, EscortGroupSet, EscortName, EscortBriefing) end

---Registers the waypoints
---
------
---@return table #
function AI_ESCORT:RegisterRoute() end

---Set a Detection method for the EscortUnit to be reported upon.
---Detection methods are based on the derived classes from DETECTION_BASE.
---
------
---@param Detection DETECTION_AREAS 
function AI_ESCORT:SetDetection(Detection) end


---
------
---@param EscortGroup NOTYPE 
function AI_ESCORT:SetEscortMenuFlare(EscortGroup) end


---
------
---@param EscortGroup NOTYPE 
function AI_ESCORT:SetEscortMenuHoldAtEscortPosition(EscortGroup) end


---
------
---@param EscortGroup NOTYPE 
function AI_ESCORT:SetEscortMenuHoldAtLeaderPosition(EscortGroup) end

---Sets a menu slot to join formation for an escort.
---
------
---@param EscortGroup NOTYPE 
---@return AI_ESCORT #
function AI_ESCORT:SetEscortMenuJoinUp(EscortGroup) end


---
------
---@param EscortGroup NOTYPE 
function AI_ESCORT:SetEscortMenuROE(EscortGroup) end


---
------
---@param EscortGroup NOTYPE 
function AI_ESCORT:SetEscortMenuROT(EscortGroup) end

---Defines a menu to let the escort resume its mission from a waypoint on its route.
---All rules of engagement will appear under the menu **Resume mission from**.
---
------
---@param EscortGroup NOTYPE 
---@return AI_ESCORT #
function AI_ESCORT:SetEscortMenuResumeMission(EscortGroup) end


---
------
---@param EscortGroup NOTYPE 
function AI_ESCORT:SetEscortMenuSmoke(EscortGroup) end


---
------
---@param EscortGroup NOTYPE 
function AI_ESCORT:SetEscortMenuTargets(EscortGroup) end


---
------
function AI_ESCORT:SetFlightMenuFlare() end


---
------
---@param Formation NOTYPE 
function AI_ESCORT:SetFlightMenuFormation(Formation) end


---
------
function AI_ESCORT:SetFlightMenuHoldAtEscortPosition() end


---
------
function AI_ESCORT:SetFlightMenuHoldAtLeaderPosition() end


---
------
function AI_ESCORT:SetFlightMenuJoinUp() end


---
------
function AI_ESCORT:SetFlightMenuROE() end


---
------
function AI_ESCORT:SetFlightMenuROT() end


---
------
function AI_ESCORT:SetFlightMenuReportType() end


---
------
function AI_ESCORT:SetFlightMenuSmoke() end


---
------
function AI_ESCORT:SetFlightMenuTargets() end


---
------
---@param ReportType NOTYPE 
function AI_ESCORT:SetFlightReportType(ReportType) end

---This function is for test, it will put on the frequency of the FollowScheduler a red smoke at the direction vector calculated for the escort to fly to.
---This allows to visualize where the escort is flying to.
---
------
---@param SmokeDirection boolean If true, then the direction vector will be smoked.
function AI_ESCORT:TestSmokeDirectionVector(SmokeDirection) end


---
------
---@param EscortGroup GROUP The escort group that will attack the detected item.
---@param DetectedItem DETECTION_BASE.DetectedItem 
function AI_ESCORT:_AssistTarget(EscortGroup, DetectedItem) end


---
------
---@param EscortGroup NOTYPE 
---@param DetectedItem NOTYPE 
function AI_ESCORT:_AttackTarget(EscortGroup, DetectedItem) end

---Lets the escort to join in a stacked formation.
---
------
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param YSpace number The space between groups on the Y-axis in meters for each sequent group.
---@param EscortGroup NOTYPE 
---@return AI_ESCORT #
function AI_ESCORT:_EscortFormationStack(XStart, XSpace, YStart, YSpace, EscortGroup) end

---Lets the escort to join in a trail formation.
---
------
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param EscortGroup NOTYPE 
---@return AI_ESCORT #
function AI_ESCORT:_EscortFormationTrail(XStart, XSpace, YStart, EscortGroup) end


---
------
---@param EscortGroup NOTYPE 
---@param Color NOTYPE 
---@param Message NOTYPE 
function AI_ESCORT:_Flare(EscortGroup, Color, Message) end


---
------
---@param TargetType NOTYPE 
function AI_ESCORT:_FlightAttackNearestTarget(TargetType) end


---
------
---@param DetectedItem NOTYPE 
function AI_ESCORT:_FlightAttackTarget(DetectedItem) end


---
------
---@param Color NOTYPE 
---@param Message NOTYPE 
function AI_ESCORT:_FlightFlare(Color, Message) end


---
------
---@param XStart NOTYPE 
---@param XSpace NOTYPE 
---@param YStart NOTYPE 
---@param YSpace NOTYPE 
function AI_ESCORT:_FlightFormationStack(XStart, XSpace, YStart, YSpace) end


---
------
---@param XStart NOTYPE 
---@param XSpace NOTYPE 
---@param YStart NOTYPE 
function AI_ESCORT:_FlightFormationTrail(XStart, XSpace, YStart) end


---
------
---@param OrbitGroup NOTYPE 
---@param OrbitHeight NOTYPE 
---@param OrbitSeconds NOTYPE 
function AI_ESCORT:_FlightHoldPosition(OrbitGroup, OrbitHeight, OrbitSeconds) end


---
------
function AI_ESCORT:_FlightJoinUp() end


---
------
---@param EscortROEMessage NOTYPE 
function AI_ESCORT:_FlightROEHoldFire(EscortROEMessage) end


---
------
---@param EscortROEMessage NOTYPE 
function AI_ESCORT:_FlightROEOpenFire(EscortROEMessage) end


---
------
---@param EscortROEMessage NOTYPE 
function AI_ESCORT:_FlightROEReturnFire(EscortROEMessage) end


---
------
---@param EscortROEMessage NOTYPE 
function AI_ESCORT:_FlightROEWeaponFree(EscortROEMessage) end


---
------
---@param EscortROTMessage NOTYPE 
function AI_ESCORT:_FlightROTEvadeFire(EscortROTMessage) end


---
------
---@param EscortROTMessage NOTYPE 
function AI_ESCORT:_FlightROTNoReaction(EscortROTMessage) end


---
------
---@param EscortROTMessage NOTYPE 
function AI_ESCORT:_FlightROTPassiveDefense(EscortROTMessage) end


---
------
---@param EscortROTMessage NOTYPE 
function AI_ESCORT:_FlightROTVertical(EscortROTMessage) end


---
------
function AI_ESCORT:_FlightReportNearbyTargetsNow() end

---Report Targets Scheduler for the flight.
---The report is generated from the perspective of the player plane, and is reported by the first plane in the formation set.
---
------
---@param EscortGroup GROUP 
function AI_ESCORT:_FlightReportTargetsScheduler(EscortGroup) end


---
------
---@param Color NOTYPE 
---@param Message NOTYPE 
function AI_ESCORT:_FlightSmoke(Color, Message) end


---
------
---@param ReportTargets NOTYPE 
function AI_ESCORT:_FlightSwitchReportNearbyTargets(ReportTargets) end


---
------
function AI_ESCORT:_FlightSwitchReportTypeAirborne() end


---
------
function AI_ESCORT:_FlightSwitchReportTypeAll() end


---
------
function AI_ESCORT:_FlightSwitchReportTypeGround() end


---
------
function AI_ESCORT:_FlightSwitchReportTypeGroundRadar() end


---
------
---@param OrbitGroup NOTYPE 
---@param EscortGroup NOTYPE 
---@param OrbitHeight NOTYPE 
---@param OrbitSeconds NOTYPE 
function AI_ESCORT:_HoldPosition(OrbitGroup, EscortGroup, OrbitHeight, OrbitSeconds) end


---
------
---@param EscortGroup NOTYPE 
function AI_ESCORT:_InitEscortMenus(EscortGroup) end


---
------
---@param EscortGroup NOTYPE 
function AI_ESCORT:_InitEscortRoute(EscortGroup) end


---
------
function AI_ESCORT:_InitFlightMenus() end


---
------
---@param EscortGroup NOTYPE 
function AI_ESCORT:_JoinUp(EscortGroup) end


---
------
---@param EscortGroup NOTYPE 
---@param EscortROEFunction NOTYPE 
---@param EscortROEMessage NOTYPE 
function AI_ESCORT:_ROE(EscortGroup, EscortROEFunction, EscortROEMessage) end


---
------
---@param EscortGroup NOTYPE 
---@param EscortROTFunction NOTYPE 
---@param EscortROTMessage NOTYPE 
function AI_ESCORT:_ROT(EscortGroup, EscortROTFunction, EscortROTMessage) end


---
------
---@param EscortGroup NOTYPE 
function AI_ESCORT:_ReportNearbyTargetsNow(EscortGroup) end

---Report Targets Scheduler.
---
------
---@param EscortGroup GROUP 
---@param Report NOTYPE 
function AI_ESCORT:_ReportTargetsScheduler(EscortGroup, Report) end


---
------
---@param EscortGroup NOTYPE 
---@param WayPoint NOTYPE 
function AI_ESCORT:_ResumeMission(EscortGroup, WayPoint) end

---Resume Scheduler.
---
------
---@param EscortGroup GROUP 
function AI_ESCORT:_ResumeScheduler(EscortGroup) end


---
------
---@param ScanDuration NOTYPE 
function AI_ESCORT:_ScanTargets(ScanDuration) end


---
------
---@param EscortGroup NOTYPE 
---@param Color NOTYPE 
---@param Message NOTYPE 
function AI_ESCORT:_Smoke(EscortGroup, Color, Message) end


---
------
---@param self NOTYPE 
function AI_ESCORT.___Resume(EscortGroup, self) end


---
------
---@param EscortGroupSet NOTYPE 
---@private
function AI_ESCORT:onafterStart(EscortGroupSet) end


---
------
---@param EscortGroupSet NOTYPE 
---@private
function AI_ESCORT:onafterStop(EscortGroupSet) end



