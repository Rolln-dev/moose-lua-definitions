---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Escorting.JPG" width="100%">
---
---**AI** - Taking the lead of AI escorting your flight or of other AI, upon request using the menu.
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
---# Developer Note
---
---Note while this class still works, it is no longer supported as the original author stopped active development of MOOSE
---Therefore, this class is considered to be deprecated
---
---===
---
---### Authors: **FlightControl** 
---
---===
---AI_ESCORT_REQUEST class
---
---# AI_ESCORT_REQUEST construction methods.
---
---Create a new AI_ESCORT_REQUEST object with the #AI_ESCORT_REQUEST.New method:
---
--- * #AI_ESCORT_REQUEST.New: Creates a new AI_ESCORT_REQUEST object from a Wrapper.Group#GROUP for a Wrapper.Client#CLIENT, with an optional briefing text.
---@class AI_ESCORT_REQUEST 
---@field Detection NOTYPE 
---@field EscortAirbase NOTYPE 
---@field EscortGroupSet NOTYPE 
---@field EscortSpawn NOTYPE 
---@field LeaderGroup NOTYPE 
---@field SpawnMode NOTYPE 
AI_ESCORT_REQUEST = {}

---AI_ESCORT_REQUEST class constructor for an AI group
---
------
---
---USAGE
---```
---EscortSpawn = SPAWN:NewWithAlias( "Red A2G Escort Template", "Red A2G Escort AI" ):InitLimit( 10, 10 )
---EscortSpawn:ParkAtAirbase( AIRBASE:FindByName( AIRBASE.Caucasus.Sochi_Adler ), AIRBASE.TerminalType.OpenBig )
---
---local EscortUnit = UNIT:FindByName( "Red A2G Pilot" )
---
---Escort = AI_ESCORT_REQUEST:New( EscortUnit, EscortSpawn, AIRBASE:FindByName(AIRBASE.Caucasus.Sochi_Adler), "A2G", "Briefing" )
---Escort:FormationTrail( 50, 100, 100 )
---Escort:Menus()
---Escort:__Start( 5 )
---```
------
---@param EscortUnit CLIENT The client escorted by the EscortGroup.
---@param EscortSpawn SPAWN The spawn object of AI, escorting the EscortUnit.
---@param EscortAirbase AIRBASE The airbase where escorts will be spawned once requested.
---@param EscortName string Name of the escort.
---@param EscortBriefing string A text showing the AI_ESCORT_REQUEST briefing to the player. Note that if no EscortBriefing is provided, the default briefing will be shown.
---@return AI_ESCORT_REQUEST #
function AI_ESCORT_REQUEST:New(EscortUnit, EscortSpawn, EscortAirbase, EscortName, EscortBriefing) end

---Set the spawn mode to be mission execution.
---
------
function AI_ESCORT_REQUEST:SetEscortSpawnMission() end


---
------
function AI_ESCORT_REQUEST:SpawnEscort() end


---
------
---@param EscortGroupSet NOTYPE 
---@private
function AI_ESCORT_REQUEST:onafterStart(EscortGroupSet) end


---
------
---@param EscortGroupSet NOTYPE 
---@private
function AI_ESCORT_REQUEST:onafterStop(EscortGroupSet) end


---AI_ESCORT_REQUEST.Mode class
---@class AI_ESCORT_REQUEST.MODE 
---@field FOLLOW number 
---@field MISSION number 
AI_ESCORT_REQUEST.MODE = {}


---MENUPARAM type
---@class MENUPARAM 
---@field ParamDistance Distance 
---@field ParamFunction function 
---@field ParamMessage string 
---@field ParamSelf AI_ESCORT_REQUEST 
MENUPARAM = {}



