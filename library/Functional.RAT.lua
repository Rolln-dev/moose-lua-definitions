---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/RAT.JPG" width="100%">
---
---**Functional** - Create random air traffic in your missions.
---
---===
---
---The aim of the RAT class is to fill the empty DCS world with randomized air traffic and bring more life to your airports.
---In particular, it is designed to spawn AI air units at random airports. These units will be assigned a random flight path to another random airport on the map.
---Even the mission designer will not know where aircraft will be spawned and which route they follow.
---
---## Features:
---
---  * Very simple interface. Just one unit and two lines of Lua code needed to fill your map.
---  * High degree of randomization. Aircraft will spawn at random airports, have random routes and random destinations.
---  * Specific departure and/or destination airports can be chosen.
---  * Departure and destination airports can be restricted by coalition.
---  * Planes and helicopters supported. Helicopters can also be send to FARPs and ships.
---  * Units can also be spawned in air within pre-defined zones of the map.
---  * Aircraft will be removed when they arrive at their destination (or get stuck on the ground).
---  * When a unit is removed a new unit with a different flight plan is respawned.
---  * Aircraft can report their status during the route.
---  * All of the above can be customized by the user if necessary.
---  * All current (Caucasus, Nevada, Normandy, Persian Gulf) and future maps are supported.
---
---The RAT class creates an entry in the F10 radio menu which allows to:
---
---  * Create new groups on-the-fly, i.e. at run time within the mission,
---  * Destroy specific groups (e.g. if they get stuck or damaged and block a runway),
---  * Request the status of all RAT aircraft or individual groups,
---  * Place markers at waypoints on the F10 map for each group.
---
---Note that by its very nature, this class is suited best for civil or transport aircraft. However, it also works perfectly fine for military aircraft of any kind.
---
---More of the documentation include some simple examples can be found further down this page.
---
---===
---
---## Additional Material:
---
---* **Demo Missions:** [GitHub](https://github.com/FlightControl-Master/MOOSE_MISSIONS/tree/master/Functional/RAT)
---* **YouTube videos:** [Random Air Traffic](https://www.youtube.com/playlist?list=PL7ZUrU4zZUl0u4Zxywtg-mx_ov4vi68CO)
---* **Guides:** None
---
---===
---
---### Author: **funkyfranky**
---
---===
---Implements an easy to use way to randomly fill your map with AI aircraft.
---
---## Airport Selection
---
---![Process](..\Presentations\RAT\RAT_Airport_Selection.png)
---
---### Default settings:
---
---* By default, aircraft are spawned at airports of their own coalition (blue or red) or neutral airports.
---* Destination airports are by default also of neutral or of the same coalition as the template group of the spawned aircraft.
---* Possible destinations are restricted by their distance to the departure airport. The maximal distance depends on the max range of spawned aircraft type and its initial fuel amount.
---
---### The default behavior can be changed:
---
---* A specific departure and/or destination airport can be chosen.
---* Valid coalitions can be set, e.g. only red, blue or neutral, all three "colours".
---* It is possible to start in air within a zone or within a zone above an airport of the map.
---
---## Flight Plan
---
---![Process](..\Presentations\RAT\RAT_Flight_Plan.png)
---
---* A general flight plan has five main airborne segments: Climb, cruise, descent, holding and final approach.
---* Events monitored during the flight are: birth, engine-start, take-off, landing and engine-shutdown.
---* The default flight level (FL) is set to ~FL200, i.e. 20000 feet ASL but randomized for each aircraft.
---Service ceiling of aircraft type is into account for max FL as well as the distance between departure and destination.
---* Maximal distance between destination and departure airports depends on range and initial fuel of aircraft.
---* Climb rate is set to a moderate value of ~1500 ft/min.
---* The standard descent rate follows the 3:1 rule, i.e. 1000 ft decent per 3 miles of travel. Hence, angle of descent is ~3.6 degrees.
---* A holding point is randomly selected at a distance between 5 and 10 km away from destination airport.
---* The altitude of the holding point is ~1200 m AGL. Holding patterns might or might not happen with variable duration.
---* If an aircraft is spawned in air, the procedure omits taxi and take-off and starts with the climb/cruising part.
---* All values are randomized for each spawned aircraft.
---
---## Mission Editor Setup
---
---![Process](..\Presentations\RAT\RAT_Mission_Setup.png)
---
---Basic mission setup is very simple and essentially a three step process:
---
---* Place your aircraft **anywhere** on the map. It really does not matter where you put it.
---* Give the group a good name. In the example above the group is named "RAT_YAK".
---* Activate the "LATE ACTIVATION" tick box. Note that this aircraft will not be spawned itself but serves a template for each RAT aircraft spawned when the mission starts.
---
---Voilà, your already done!
---
---Optionally, you can set a specific livery for the aircraft or give it some weapons.
---However, the aircraft will by default not engage any enemies. Think of them as being on a peaceful or ferry mission.
---
---## Basic Lua Script
---
---![Process](..\Presentations\RAT\RAT_Basic_Lua_Script.png)
---
---The basic Lua script for one template group consists of two simple lines as shown in the picture above.
---
---* **Line 2** creates a new RAT object "yak". The only required parameter for the constructor #RAT.New() is the name of the group as defined in the mission editor. In this example it is "RAT_YAK".
---* **Line 5** trigger the command to spawn the aircraft. The (optional) parameter for the #RAT.Spawn() function is the number of aircraft to be spawned of this object.
---By default each of these aircraft gets a random departure airport anywhere on the map and a random destination airport, which lies within range of the of the selected aircraft type.
---
---In this simple example aircraft are respawned with a completely new flightplan when they have reached their destination airport.
---The "old" aircraft is despawned (destroyed) after it has shut-down its engines and a new aircraft of the same type is spawned at a random departure airport anywhere on the map.
---Hence, the default flight plan for a RAT aircraft will be: Fly from airport A to B, get respawned at C and fly to D, get respawned at E and fly to F, ...
---This ensures that you always have a constant number of AI aircraft on your map.
---
---## Parking Problems
---
---One big issue in DCS is that not all aircraft can be spawned on every airport or airbase. In particular, bigger aircraft might not have a valid parking spot at smaller airports and
---airstrips. This can lead to multiple problems in DCS.
---
---* Landing: When an aircraft tries to land at an airport where it does not have a valid parking spot, it is immediately despawned the moment its wheels touch the runway, i.e.
---when a landing event is triggered. This leads to the loss of the RAT aircraft. On possible way to circumvent the this problem is to let another RAT aircraft spawn at landing
---and not when it shuts down its engines. See the #RAT.RespawnAfterLanding() function.
---* Spawning: When a big aircraft is dynamically spawned on a small airbase a few things can go wrong. For example, it could be spawned at a parking spot with a shelter.
---Or it could be damaged by a scenery object when it is taxiing out to the runway, or it could overlap with other aircraft on parking spots near by.
---
---You can check yourself if an aircraft has a valid parking spot at an airbase by dragging its group on the airport in the mission editor and set it to start from ramp.
---If it stays at the airport, it has a valid parking spot, if it jumps to another airport, it does not have a valid parking spot on that airbase.
---
---### Setting the Terminal Type
---Each parking spot has a specific type depending on its size or if a helicopter spot or a shelter etc. The classification is not perfect but it is the best we have.
---If you encounter problems described above, you can request a specific terminal type for the RAT aircraft. This can be done by the #RAT.SetTerminalType(*terminaltype*)
---function. The parameter *terminaltype* can be set as follows
---
---* AIRBASE.TerminalType.HelicopterOnly: Special spots for Helicopers.
---* AIRBASE.TerminalType.Shelter: Hardened Air Shelter. Currently only on Caucaus map.
---* AIRBASE.TerminalType.OpenMed: Open/Shelter air airplane only.
---* AIRBASE.TerminalType.OpenBig: Open air spawn points. Generally larger but does not guarantee large aircraft are capable of spawning there.
---* AIRBASE.TerminalType.OpenMedOrBig: Combines OpenMed and OpenBig spots.
---* AIRBASE.TerminalType.HelicopterUsable: Combines HelicopterOnly, OpenMed and OpenBig.
---* AIRBASE.TerminalType.FighterAircraft: Combines Shelter, OpenMed and OpenBig spots. So effectively all spots usable by fixed wing aircraft.
---
---So for example
---     c17=RAT:New("C-17")
---     c17:SetTerminalType(AIRBASE.TerminalType.OpenBig)
---     c17:Spawn(5)
---
---This would randomly spawn five C-17s but only on airports which have big open air parking spots. Note that also only destination airports are allowed
---which do have this type of parking spot. This should ensure that the aircraft is able to land at the destination without being despawned immediately.
---
---Also, the aircraft are spawned only on the requested parking spot types and not on any other type. If no parking spot of this type is available at the
---moment of spawning, the group is automatically spawned in air above the selected airport.
---
---## Examples
---
---Here are a few examples, how you can modify the default settings of RAT class objects.
---
---### Specify Departure and Destinations
---
---![Process](..\Presentations\RAT\RAT_Examples_Specify_Departure_and_Destination.png)
---
---In the picture above you find a few possibilities how to modify the default behaviour to spawn at random airports and fly to random destinations.
---
---In particular, you can specify fixed departure and/or destination airports. This is done via the #RAT.SetDeparture() or #RAT.SetDestination() functions, respectively.
---
---* If you only fix a specific departure airport via #RAT.SetDeparture() all aircraft will be spawned at that airport and get random destination airports.
---* If you only fix the destination airport via #RAT.SetDestination(), aircraft a spawned at random departure airports but will all fly to the destination airport.
---* If you fix departure and destination airports, aircraft will only travel from between those airports.
---When the aircraft reaches its destination, it will be respawned at its departure and fly again to its destination.
---
---There is also an option that allows aircraft to "continue their journey" from their destination. This is achieved by the #RAT.ContinueJourney() function.
---In that case, when the aircraft arrives at its first destination it will be respawned at that very airport and get a new random destination.
---So the flight plan in this case would be: Fly from airport A to B, then from B to C, then from C to D, ...
---
---It is also possible to make aircraft "commute" between two airports, i.e. flying from airport A to B and then back from B to A, etc.
---This can be done by the #RAT.Commute() function. Note that if no departure or destination airports are specified, the first departure and destination are chosen randomly.
---Then the aircraft will fly back and forth between those two airports indefinitely.
---
---
---### Spawn in Air
---
---![Process](..\Presentations\RAT\RAT_Examples_Spawn_in_Air.png)
---
---Aircraft can also be spawned in air rather than at airports on the ground. This is done by setting #RAT.SetTakeoff() to "air".
---
---By default, aircraft are spawned randomly above airports of the map.
---
---The #RAT.SetDeparture() option can be used to specify zones, which have been defined in the mission editor as departure zones.
---Aircraft will then be spawned at a random point within the zone or zones.
---
---Note that #RAT.SetDeparture() also accepts airport names. For an air takeoff these are treated like zones with a radius of XX kilometers.
---Again, aircraft are spawned at random points within these zones around the airport.
---
---### Misc Options
---
---![Process](..\Presentations\RAT\RAT_Examples_Misc.png)
---
---The default "takeoff" type of RAT aircraft is that they are spawned with hot or cold engines.
---The choice is random, so 50% of aircraft will be spawned with hot engines while the other 50% will be spawned with cold engines.
---This setting can be changed using the #RAT.SetTakeoff() function. The possible parameters for starting on ground are:
---
---*  #RAT.SetTakeoff("cold"), which means that all aircraft are spawned with their engines off,
---*  #RAT.SetTakeoff("hot"), which means that all aircraft are spawned with their engines on,
---*  #RAT.SetTakeoff("runway"), which means that all aircraft are spawned already at the runway ready to takeoff.
---Note that in this case the default spawn intervall is set to 180 seconds in order to avoid aircraft jams on the runway. Generally, this takeoff at runways should be used with care and problems are to be expected.
---
---
---The options #RAT.SetMinDistance() and #RAT.SetMaxDistance() can be used to restrict the range from departure to destination. For example
---
---* #RAT.SetMinDistance(100) will cause only random destination airports to be selected which are **at least** 100 km away from the departure airport.
---* #RAT.SetMaxDistance(150) will allow only destination airports which are **less than** 150 km away from the departure airport.
---
---![Process](..\Presentations\RAT\RAT_Gaussian.png)
---
---By default planes get a cruise altitude of ~20,000 ft ASL. The actual altitude is sampled from a Gaussian distribution. The picture shows this distribution
---if one would spawn 1000 planes. As can be seen most planes get a cruising alt of around FL200. Other values are possible but less likely the further away
---one gets from the expectation value.
---
---The expectation value, i.e. the altitude most aircraft get, can be set with the function #RAT.SetFLcruise().
---It is possible to restrict the minimum cruise altitude by #RAT.SetFLmin() and the maximum cruise altitude by #RAT.SetFLmax()
---
---The cruise altitude can also be given in meters ASL by the functions #RAT.SetCruiseAltitude(), #RAT.SetMinCruiseAltitude() and #RAT.SetMaxCruiseAltitude().
---
---For example:
---
---* #RAT.SetFLcruise(300) will cause most planes fly around FL300.
---* #RAT.SetFLmin(100) restricts the cruising alt such that no plane will fly below FL100. Note that this automatically changes the minimum distance from departure to destination.
---That means that only destinations are possible for which the aircraft has had enough time to reach that flight level and descent again.
---* #RAT.SetFLmax(200) will restrict the cruise alt to maximum FL200, i.e. no aircraft will travel above this height.
---- RAT class
---@class RAT : SPAWN
---@field ATC RAT.ATC 
---@field ATCswitch boolean Enable/disable ATC if set to true/false.
---@field AlphaDescent number Default angle of descenti in degrees. A value of 3.6 follows the 3:1 rule of 3 miles of travel and 1000 ft descent.
---@field ClassName string Name of the Class.
---@field Debug boolean Turn debug messages on or off.
---@field FLcruise number Cruise altitude of aircraft. Default FL200 for planes and F005 for helos.
---@field FLmaxuser number Maximum flight level set by user.
---@field FLminuser number Minimum flight level set by user.
---@field FLuser number Flight level set by users explicitly.
---@field Menu table F10 menu items for this RAT object.
---@field MenuF10 string Main F10 menu.
---@field Ndeparture_Airports number Number of departure airports set via SetDeparture().
---@field Ndeparture_Zones number Number of departure zones set via SetDeparture.
---@field Ndestination_Airports number Number of destination airports set via SetDestination().
---@field Ndestination_Zones number Number of destination zones set via SetDestination().
---@field NspawnMax number Max number of spawns.
---@field ROE RAT.ROE 
---@field ROT RAT.ROT 
---@field SubMenuName string Submenu name for RAT object.
---@field Tinactive number Time in seconds after which inactive units will be destroyed. Default is 300 seconds.
---@field Vclimb number Default climb rate in ft/min.
---@field Vcruisemax number Max cruise speed in m/s (250 m/s = 900 km/h = 486 kt) set by user.
---@field private activate_delay number Delay in seconds before first uncontrolled group is activated. Default is 5 seconds.
---@field private activate_delta number Time interval in seconds between activation of uncontrolled groups. Default is 5 seconds.
---@field private activate_frand number Randomization factor of time interval (activate_delta) between activating uncontrolled groups. Default is 0.
---@field private activate_max number Maximum number of uncontrolled aircraft, which will be activated at the same time. Default is 1.
---@field private activate_uncontrolled boolean If true, uncontrolled are activated randomly after certain time intervals.
---@field private actype NOTYPE 
---@field private addfriendlydepartures boolean Add all friendly airports to departures.
---@field private addfriendlydestinations boolean Add all friendly airports to destinations.
---@field private aircraft table Table which holds the basic aircraft properties (speed, range, ...).
---@field private airports table All airports of friedly coalitions.
---@field private airports_map table All airports available on current map (Caucasus, Nevada, Normandy, ...).
---@field private alias string Alias for spawned group.
---@field private alive number Number of groups which are alive.
---@field private cat RAT.cat 
---@field private category string Category of aircarft: "plane" or "heli".
---@field private checkonrunway boolean Aircraft are checked if they were accidentally spawned on the runway. Default is true.
---@field private checkontop boolean Aircraft are checked if they were accidentally spawned on top of another unit. Default is true.
---@field private coal RAT.coal 
---@field private coalition number Coalition of spawn group template.
---@field private commute boolean Aircraft commute between departure and destination, i.e. when respawned the departure airport becomes the new destiation.
---@field private continuejourney boolean Aircraft will continue their journey, i.e. get respawned at their destination with a new random destination.
---@field private country number Country of spawn group template.
---@field private ctable table Table with the valid coalitions from choice self.friendly.
---@field private departure_Azone ZONE Zone containing the departure airports.
---@field private departure_ports table Array containing the names of the destination airports or zones.
---@field private despawnair boolean If true, aircraft are despawned when they reach their destination zone. Default.
---@field private destination_Azone ZONE Zone containing the destination airports.
---@field private destination_ports table Array containing the names of the destination airports or zones.
---@field private destinationzone boolean Destination is a zone and not an airport.
---@field private eplrs boolean If true, turn on EPLSR datalink for the RAT group.
---@field private excluded_ports table Array containing the names of explicitly excluded airports.
---@field private f10menu boolean If true, add an F10 radiomenu for RAT. Default is false.
---@field private frequency number Radio frequency used by the RAT groups.
---@field private friendly string Possible departure/destination airport: all=blue+red+neutral, same=spawn+neutral, spawnonly=spawn, blue=blue+neutral, blueonly=blue, red=red+neutral, redonly=red.
---@field private groupsize number Number of aircraft in group.
---@field private homebase string Home base for commute and return zone. Aircraft will always return to this base but otherwise travel in a star shaped way.
---@field private id string Some ID to identify who we are in output of the DCS.log file.
---@field private immortal boolean If true, aircraft are spawned as immortal.
---@field private index NOTYPE 
---@field private invisible boolean If true aircraft are set to invisible for other AI forces.
---@field private landing number Landing type. Determines if we actually land at an airport or treat it as zone.
---@field private lid string Log identifier.
---@field private livery string Livery of the aircraft set by user.
---@field private markerid number Running number of placed markers on the F10 map.
---@field private markerids table Array with marker IDs.
---@field private maxdist number Max distance from departure to destination in meters. Default 5000 km.
---@field private mindist number Min distance from departure to destination in meters. Default 5 km.
---@field private modulation string Ratio modulation. Either "FM" or "AM".
---@field private ngroups number Number of groups to be spawned in total.
---@field private norespawn boolean Aircraft will not be respawned after they have finished their route.
---@field private onboardnum string Sets the onboard number prefix. Same as setting "TAIL #" in the mission editor.
---@field private onboardnum0 number (Optional) Starting value of the automatically appended numbering of aircraft within a flight. Default is 1.
---@field private onrunwaymaxretry number Number of respawn retries (on ground) at other airports if a group gets accidentally spawned on the runway. Default is 3.
---@field private onrunwayradius number Distance (in meters) from a runway spawn point until a unit is considered to have accidentally been spawned on a runway. Default is 75 m.
---@field private ontopradius number Radius in meters until which a unit is considered to be on top of another. Default is 2 m.
---@field private parkingscanradius number Radius in meters until which parking spots are scanned for obstacles like other units, statics or scenery.
---@field private parkingscanscenery boolean If true, area around parking spots is scanned for scenery objects. Default is false.
---@field private parkingverysafe boolean If true, parking spots are considered as non-free until a possible aircraft has left and taken off. Default false.
---@field private placemarkers boolean Place markers of waypoints on F10 map.
---@field private radio boolean If true/false disables radio messages from the RAT groups.
---@field private random_departure boolean By default a random friendly airport is chosen as departure.
---@field private random_destination boolean By default a random friendly airport is chosen as destination.
---@field private ratcraft table Array with the spawned RAT aircraft.
---@field private reportstatus boolean Aircraft report status.
---@field private respawn_after_crash boolean Aircraft will be respawned after a crash, e.g. when they get shot down.
---@field private respawn_after_takeoff boolean Aircraft will be respawned directly after take-off.
---@field private respawn_at_landing boolean Respawn aircraft the moment they land rather than at engine shutdown.
---@field private respawn_delay number Delay in seconds until a repawn happens.
---@field private respawn_inair boolean Aircraft are allowed to spawned in air if they cannot be respawned on ground because there is not free parking spot. Default is true.
---@field private return_zones table Array containing the names of the return zones.
---@field private returnzone boolean Zone where aircraft will fly to before returning to their departure airport.
---@field private roe string ROE of spawned groups, default is weapon hold (this is a peaceful class for civil aircraft or ferry missions). Possible: "hold", "return", "free".
---@field private rot string ROT of spawned groups, default is no reaction. Possible: "noreaction", "passive", "evade".
---@field private sid_Activate NOTYPE 
---@field private sid_Spawn NOTYPE 
---@field private sid_Status NOTYPE 
---@field private skill string Skill of AI.
---@field private spawndelay number Delay time in seconds before first spawning happens.
---@field private spawninitialized boolean If RAT:Spawn() was already called this RAT object is set to true to prevent users to call it again.
---@field private spawninterval number Interval between spawning units/groups. Note that we add a randomization of 50%.
---@field private starshape boolean If true, aircraft travel A-->B-->A-->C-->A-->D... for commute.
---@field private status RAT.status 
---@field private statusinterval number Intervall between status checks (and reports if enabled).
---@field private takeoff number Takeoff type. 0=coldorhot.
---@field private templategroup GROUP Group serving as template for the RAT aircraft.
---@field private termtype AIRBASE.TerminalType Type of terminal to be used when spawning at an airbase.
---@field private uncontrolled boolean If true aircraft are spawned in uncontrolled state and will only sit on their parking spots. They can later be activated.
---@field private unit RAT.unit 
---@field private version table RAT version.
---@field private waypointdescriptions table Table with strings for waypoint descriptions of markers.
---@field private waypointstatus table Table with strings of waypoint status.
---@field private wp RAT.wp 
RAT = {}

---Max number of planes that get landing clearance of the RAT ATC.
---This setting effects all RAT objects and groups!
---
------
---@param self RAT 
---@param n number Number of aircraft that are allowed to land simultaniously. Default is 2.
---@return RAT #RAT self object.
function RAT:ATC_Clearance(n) end

---Delay between granting landing clearance for simultanious landings.
---This setting effects all RAT objects and groups!
---
------
---@param self RAT 
---@param time number Delay time when the next aircraft will get landing clearance event if the previous one did not land yet. Default is 240 sec.
---@return RAT #RAT self object.
function RAT:ATC_Delay(time) end

---Turn messages from ATC on or off.
---Default is on. This setting effects all RAT objects and groups!
---
------
---@param self RAT 
---@param switch boolean Enable (true) or disable (false) messages from ATC.
---@return RAT #RAT self object.
function RAT:ATC_Messages(switch) end

---Define how aircraft that are spawned in uncontrolled state are activate.
---
------
---@param self RAT 
---@param maxactivated number Maximal numnber of activated aircraft. Absolute maximum will be the number of spawned groups. Default is 1.
---@param delay number Time delay in seconds before (first) aircraft is activated. Default is 1 second.
---@param delta number Time difference in seconds before next aircraft is activated. Default is 1 second.
---@param frand number Factor [0,...,1] for randomization of time difference between aircraft activations. Default is 0, i.e. no randomization.
---@return RAT #RAT self object.
function RAT:ActivateUncontrolled(maxactivated, delay, delta, frand) end

---Add all friendly airports to the list of possible departures.
---
------
---@param self RAT 
---@return RAT #RAT self object.
function RAT:AddFriendlyAirportsToDepartures() end

---Add all friendly airports to the list of possible destinations
---
------
---@param self RAT 
---@return RAT #RAT self object.
function RAT:AddFriendlyAirportsToDestinations() end

---Change aircraft type.
---This is a dirty hack which allows to change the aircraft type of the template group.
---Note that all parameters like cruise speed, climb rate, range etc are still taken from the template group which likely leads to strange behaviour.
---
------
---@param self RAT 
---@param actype string Type of aircraft which is spawned independent of the template group. Use with care and expect problems!
---@return RAT #RAT self object.
function RAT:ChangeAircraft(actype) end

---Check if aircraft have accidentally been spawned on the runway.
---If so they will be removed immediately.
---
------
---@param self RAT 
---@param switch boolean If true, check is performed. If false, this check is omitted.
---@param radius number Distance in meters until a unit is considered to have spawned accidentally on the runway. Default is 75 m.
---@param distance NOTYPE 
---@return RAT #RAT self object.
function RAT:CheckOnRunway(switch, radius, distance) end

---Check if aircraft have accidentally been spawned on top of each other.
---If yes, they will be removed immediately.
---
------
---@param self RAT 
---@param switch boolean If true, check is performed. If false, this check is omitted.
---@param radius number Radius in meters until which a unit is considered to be on top of each other. Default is 2 m.
---@return RAT #RAT self object.
function RAT:CheckOnTop(switch, radius) end

---Clear flight for landing.
---Sets tigger value to 1.
---
------
---@param self RAT 
---@param name string Name of flight to be cleared for landing.
function RAT:ClearForLanding(name) end

---Aircraft will commute between their departure and destination airports or zones.
---
------
---@param self RAT 
---@param starshape boolean If true, keep homebase, i.e. travel A-->B-->A-->C-->A-->D... instead of A-->B-->A-->B-->A...
---@return RAT #RAT self object.
function RAT:Commute(starshape) end

---Aircraft will continue their journey from their destination.
---This means they are respawned at their destination and get a new random destination.
---
------
---@param self RAT 
---@return RAT #RAT self object.
function RAT:ContinueJourney() end

---Enable debug mode.
---More output in dcs.log file and onscreen messages to all.
---
------
---@param self RAT 
---@return RAT #RAT self object.
function RAT:Debugmode() end

---Destinations are treated as zones.
---Aircraft will not land but rather be despawned when they reach a random point in the zone.
---
------
---@param self RAT 
---@return RAT #RAT self object.
function RAT:DestinationZone() end

---Enable ATC, which manages the landing queue for RAT aircraft if they arrive simultaniously at the same airport.
---
------
---@param self RAT 
---@param switch boolean Enable ATC (true) or Disable ATC (false). No argument means ATC enabled.
---@return RAT #RAT self object.
function RAT:EnableATC(switch) end

---Airports, FARPs and ships explicitly excluded as departures and destinations.
---
------
---@param self RAT 
---@param ports string Name or table of names of excluded airports.
---@return RAT #RAT self object.
function RAT:ExcludedAirports(ports) end

---Get status of group.
---
------
---@param self RAT 
---@param group GROUP Group.
---@return string #status Status of group.
function RAT:GetStatus(group) end

---Aircraft are immortal.
---
------
---@param self RAT 
---@return RAT #RAT self object.
function RAT:Immortal() end

---Aircraft are invisible.
---
------
---@param self RAT 
---@return RAT #RAT self object.
function RAT:Invisible() end

---Set livery of aircraft.
---If more than one livery is specified in a table, the actually used one is chosen randomly from the selection.
---
------
---@param self RAT 
---@param skins table Name of livery or table of names of liveries.
---@return RAT #RAT self object.
function RAT:Livery(skins) end

---Set the name of the F10 submenu.
---Default is the name of the template group.
---
------
---@param self RAT 
---@param name string Submenu name.
---@return RAT #RAT self object.
function RAT:MenuName(name) end

---Create a new RAT object.
---
------
---
---USAGE
---```
---yak1:RAT("RAT_YAK") will create a RAT object called "yak1". The template group in the mission editor must have the name "RAT_YAK".
---```
------
---@param self RAT 
---@param groupname string Name of the group as defined in the mission editor. This group is serving as a template for all spawned units.
---@param alias? string (Optional) Alias of the group. This is and optional parameter but must(!) be used if the same template group is used for more than one RAT object.
---@return RAT #Object of RAT class or nil if the group does not exist in the mission editor.
function RAT:New(groupname, alias) end

---Aircraft will not get respawned when they finished their route.
---
------
---@param self RAT 
---@return RAT #RAT self object.
function RAT:NoRespawn() end

---Place markers of waypoints on the F10 map.
---Default is off.
---
------
---@param self RAT 
---@param switch boolean true=yes, false=no.
---@return RAT #RAT self object.
function RAT:PlaceMarkers(switch) end

---Set radio frequency.
---
------
---@param self RAT 
---@param frequency number Radio frequency.
---@return RAT #RAT self object.
function RAT:RadioFrequency(frequency) end

---Radio menu Off.
---This is the default setting.
---
------
---@param self RAT 
---@return RAT #RAT self object.
function RAT:RadioMenuOFF() end

---Radio menu On.
---Default is off.
---
------
---@param self RAT 
---@return RAT #RAT self object.
function RAT:RadioMenuON() end

---Set radio modulation.
---Default is AM.
---
------
---@param self RAT 
---@param modulation string Either "FM" or "AM". If no value is given, modulation is set to AM.
---@return RAT #RAT self object.
function RAT:RadioModulation(modulation) end

---Disable Radio.
---Overrules the ME setting.
---
------
---@param self RAT 
---@return RAT #RAT self object.
function RAT:RadioOFF() end

---Enable Radio.
---Overrules the ME setting.
---
------
---@param self RAT 
---@return RAT #RAT self object.
function RAT:RadioON() end

---Aircraft will not be respawned after they crashed or get shot down.
---
------
---@param self RAT 
---@return RAT #RAT self object.
function RAT:RespawnAfterCrashOFF() end

---Aircraft will be respawned after they crashed or get shot down.
---This is the default behavior.
---
------
---@param self RAT 
---@return RAT #RAT self object.
function RAT:RespawnAfterCrashON() end

---Make aircraft respawn the moment they land rather than at engine shut down.
---
------
---@param self RAT 
---@param delay? number (Optional) Delay in seconds until respawn happens after landing. Default is 1 second. Minimum is 1 second.
---@return RAT #RAT self object.
function RAT:RespawnAfterLanding(delay) end

---A new aircraft is spawned directly after the last one took off.
---This creates a lot of outbound traffic. Aircraft are not respawned after they reached their destination.
---Therefore, this option is not to be used with the "commute" or "continue journey" options.
---
------
---@param self RAT 
---@return RAT #RAT self object.
function RAT:RespawnAfterTakeoff() end

---If aircraft cannot be spawned on parking spots, it is allowed to spawn them in air above the same airport.
---Note that this is also the default behavior.
---
------
---@param self RAT 
---@return RAT #RAT self object.
function RAT:RespawnInAirAllowed() end

---If aircraft cannot be spawned on parking spots, it is NOT allowed to spawn them in air.
---This has only impact if aircraft are supposed to be spawned on the ground (and not in a zone).
---
------
---@param self RAT 
---@return RAT #RAT self object.
function RAT:RespawnInAirNotAllowed() end

---Aircraft will fly to a random point within a zone and then return to its departure airport or zone.
---
------
---@param self RAT 
---@return RAT #RAT self object.
function RAT:ReturnZone() end

---Set skill of AI aircraft.
---Default is "High".
---
------
---@param self RAT 
---@param skill string Skill, options are "Average", "Good", "High", "Excellent" and "Random". Parameter is case insensitive.
---@return RAT #RAT self object.
function RAT:SetAISkill(skill) end

---Set the climb rate.
---This automatically sets the climb angle.
---
------
---@param self RAT 
---@param rate number Climb rate in ft/min. Default is 1500 ft/min. Minimum is 100 ft/min. Maximum is 15,000 ft/min.
---@return RAT #RAT self object.
function RAT:SetClimbRate(rate) end

---Set the friendly coalitions from which the airports can be used as departure and destination.
---
------
---
---USAGE
---```
---yak:SetCoalition("neutral") will spawn aircraft randomly on all neutral airports.
---```
------
---@param self RAT 
---@param friendly string "same"=own coalition+neutral (default), "sameonly"=own coalition only, "neutral"=all neutral airports. Default is "same", so aircraft will use airports of the coalition their spawn template has plus all neutral airports.
---@return RAT #RAT self object.
function RAT:SetCoalition(friendly) end

---Set coalition of RAT group.
---You can make red templates blue and vice versa.
---Note that a country is also set automatically if it has not done before via RAT:SetCountry.
---
---* For blue, the country is set to USA.
---* For red, the country is set to RUSSIA.
---* For neutral, the country is set to SWITZERLAND.
---
---This is important, since it is ultimately the COUNTRY that determines the coalition of the aircraft.
---You can set the country explicitly via the RAT:SetCountry() function if necessary.
---
------
---@param self RAT 
---@param color string Color of coalition, i.e. "red" or blue" or "neutral".
---@return RAT #RAT self object.
function RAT:SetCoalitionAircraft(color) end

---Set country of RAT group.
---See [DCS_enum_country](https://wiki.hoggitworld.com/view/DCS_enum_country).
---
---This overrules the coalition settings. So if you want your group to be of a specific coalition, you have to set a country that is part of that coalition.
---
------
---@param self RAT 
---@param id country.id DCS country enumerator ID. For example country.id.USA or country.id.RUSSIA.
---@return RAT #RAT self object.
function RAT:SetCountry(id) end

---Set cruising altitude.
---This is still be checked for consitancy with selected route and prone to radomization.
---
------
---@param self RAT 
---@param alt number Cruising altitude ASL in meters.
---@return RAT #RAT self object.
function RAT:SetCruiseAltitude(alt) end

---Set possible departure ports.
---This can be an airport or a zone.
---
------
---
---USAGE
---```
---RAT:SetDeparture("Sochi-Adler") will spawn RAT objects at Sochi-Adler airport.
---```
------
---@param self RAT 
---@param departurenames string Name or table of names of departure airports or zones.
---@return RAT #RAT self object.
function RAT:SetDeparture(departurenames) end

---Include all airports which lie in a zone as possible destinations.
---
------
---@param self RAT 
---@param zone ZONE Zone in which the departure airports lie. Has to be a MOOSE zone.
---@return RAT #RAT self object.
function RAT:SetDeparturesFromZone(zone) end

---Set the angle of descent.
---Default is 3.6 degrees, which corresponds to 3000 ft descent after one mile of travel.
---
------
---@param self RAT 
---@param angle number Angle of descent in degrees. Minimum is 0.5 deg. Maximum 50 deg.
---@return RAT #RAT self object.
function RAT:SetDescentAngle(angle) end

---Aircraft that reach their destination zone are not despawned.
---They will probably go the the nearest airbase and try to land.
---
------
---@param self RAT 
---@return RAT #RAT self object.
function RAT:SetDespawnAirOFF() end

---Set name of destination airports or zones for the AI aircraft.
---
------
---
---USAGE
---```
---RAT:SetDestination("Krymsk") makes all aircraft of this RAT object fly to Krymsk airport.
---```
------
---@param self RAT 
---@param destinationnames string Name of the destination airport or #table of destination airports.
---@return RAT #RAT self object.
function RAT:SetDestination(destinationnames) end

---Include all airports which lie in a zone as possible destinations.
---
------
---@param self RAT 
---@param zone ZONE Zone in which the destination airports lie. Has to be a MOOSE zone.
---@return RAT #RAT self object.
function RAT:SetDestinationsFromZone(zone) end

---Turn EPLRS datalink on/off.
---
------
---@param self RAT 
---@param switch boolean If true (or nil), turn EPLRS on.
---@return RAT #RAT self object.
function RAT:SetEPLRS(switch) end

---Set flight level.
---Setting this value will overrule all other logic. Aircraft will try to fly at this height regardless.
---
------
---@param self RAT 
---@param FL number Fight Level in hundrets of feet. E.g. FL200 = 20000 ft ASL.
---@return RAT #RAT self object.
function RAT:SetFL(FL) end

---Set flight level of cruising part.
---This is still be checked for consitancy with selected route and prone to radomization.
---Default is FL200 for planes and FL005 for helicopters.
---
------
---@param self RAT 
---@param FL number Flight level in hundrets of feet. E.g. FL200 = 20000 ft ASL.
---@return RAT #RAT self object.
function RAT:SetFLcruise(FL) end

---Set max flight level.
---Setting this value will overrule all other logic. Aircraft will try to fly at less than this FL regardless.
---
------
---@param self RAT 
---@param FL number Maximum Fight Level in hundrets of feet.
---@return RAT #RAT self object.
function RAT:SetFLmax(FL) end

---Set min flight level.
---Setting this value will overrule all other logic. Aircraft will try to fly at higher than this FL regardless.
---
------
---@param self RAT 
---@param FL number Maximum Fight Level in hundrets of feet.
---@return RAT #RAT self object.
function RAT:SetFLmin(FL) end

---Set max cruising altitude above sea level.
---
------
---@param self RAT 
---@param alt number Altitude ASL in meters.
---@return RAT #RAT self object.
function RAT:SetMaxCruiseAltitude(alt) end

---Set the maximum cruise speed of the aircraft.
---
------
---@param self RAT 
---@param speed number Speed in km/h.
---@return RAT #RAT self object.
function RAT:SetMaxCruiseSpeed(speed) end

---Set maximum distance between departure and destination.
---Default is 5000 km but aircarft range is also taken into account automatically.
---
------
---@param self RAT 
---@param dist number Distance in km.
---@return RAT #RAT self object.
function RAT:SetMaxDistance(dist) end

---Number of tries to respawn an aircraft in case it has accidentally been spawned on runway.
---
------
---@param self RAT 
---@param n number Number of retries. Default is 3.
---@return RAT #RAT self object.
function RAT:SetMaxRespawnTriedWhenSpawnedOnRunway(n) end

---Set min cruising altitude above sea level.
---
------
---@param self RAT 
---@param alt number Altitude ASL in meters.
---@return RAT #RAT self object.
function RAT:SetMinCruiseAltitude(alt) end

---Set minimum distance between departure and destination.
---Default is 5 km.
---Minimum distance should not be smaller than maybe ~100 meters to ensure that departure and destination are different.
---
------
---@param self RAT 
---@param dist number Distance in km.
---@return RAT #RAT self object.
function RAT:SetMinDistance(dist) end

---Set onboard number prefix.
---Same as setting "TAIL #" in the mission editor. Note that if you dont use this function, the values defined in the template group of the ME are taken.
---
------
---@param self RAT 
---@param tailnumprefix string String of the tail number prefix. If flight consists of more than one aircraft, two digits are appended automatically, i.e. <tailnumprefix>001, <tailnumprefix>002, ...
---@param zero? number (Optional) Starting value of the automatically appended numbering of aircraft within a flight. Default is 0.
---@return RAT #RAT self object.
function RAT:SetOnboardNum(tailnumprefix, zero) end

---Set the scan radius around parking spots.
---Parking spot is considered to be occupied if any obstacle is found with the radius.
---
------
---@param self RAT 
---@param radius number Radius in meters. Default 50 m.
---@return RAT #RAT self object.
function RAT:SetParkingScanRadius(radius) end

---Disables scanning for scenery objects around parking spots which might block the spot.
---This is also the default setting.
---
------
---@param self RAT 
---@return RAT #RAT self object.
function RAT:SetParkingScanSceneryOFF() end

---Enables scanning for scenery objects around parking spots which might block the spot.
---
------
---@param self RAT 
---@return RAT #RAT self object.
function RAT:SetParkingScanSceneryON() end

---A parking spot is free as soon as possible aircraft has left the place.
---This is the default.
---
------
---@param self RAT 
---@return RAT #RAT self object.
function RAT:SetParkingSpotSafeOFF() end

---A parking spot is not free until a possible aircraft has left and taken off.
---
------
---@param self RAT 
---@return RAT #RAT self object.
function RAT:SetParkingSpotSafeON() end

---Set rules of engagement (ROE).
---Default is weapon hold. This is a peaceful class.
---
------
---@param self RAT 
---@param roe string "hold" = weapon hold, "return" = return fire, "free" = weapons free.
---@return RAT #RAT self object.
function RAT:SetROE(roe) end

---Set reaction to threat (ROT).
---Default is no reaction, i.e. aircraft will simply ignore all enemies.
---
------
---@param self RAT 
---@param rot string "noreaction" = no reaction to threats, "passive" = passive defence, "evade" = evade enemy attacks.
---@return RAT #RAT self object.
function RAT:SetROT(rot) end

---Sets the delay between despawning and respawning aircraft.
---
------
---@param self RAT 
---@param delay number Delay in seconds until respawn happens. Default is 1 second. Minimum is 1 second.
---@return RAT #RAT self object.
function RAT:SetRespawnDelay(delay) end

---Set the delay before first group is spawned.
---
------
---@param self RAT 
---@param delay number Delay in seconds. Default is 5 seconds. Minimum delay is 0.5 seconds.
---@return RAT #RAT self object.
function RAT:SetSpawnDelay(delay) end

---Set the interval between spawnings of the template group.
---
------
---@param self RAT 
---@param interval number Interval in seconds. Default is 5 seconds. Minimum is 0.5 seconds.
---@return RAT #RAT self object.
function RAT:SetSpawnInterval(interval) end

---Set max number of groups that will be spawned.
---When this limit is reached, no more RAT groups are spawned.
---
------
---@param self RAT 
---@param Nmax number Max number of groups. Default `nil`=unlimited.
---@return RAT #RAT self object.
function RAT:SetSpawnLimit(Nmax) end

---Set takeoff type.
---Starting cold at airport, starting hot at airport, starting at runway, starting in the air.
---Default is "takeoff-coldorhot". So there is a 50% chance that the aircraft starts with cold engines and 50% that it starts with hot engines.
---
------
---
---USAGE
---```
---RAT:Takeoff("hot") will spawn RAT objects at airports with engines started.
---```
------
---@param self RAT 
---@param type string Type can be "takeoff-cold" or "cold", "takeoff-hot" or "hot", "takeoff-runway" or "runway", "air".
---@return RAT #RAT self object.
function RAT:SetTakeoff(type) end

---Set takeoff type to air.
---Aircraft will spawn in the air.
---
------
---@param self RAT 
---@return RAT #RAT self object.
function RAT:SetTakeoffAir() end

---Set takeoff type cold.
---Aircraft will spawn at a parking spot with engines off.
---
------
---@param self RAT 
---@return RAT #RAT self object.
function RAT:SetTakeoffCold() end

---Set takeoff type to cold or hot.
---Aircraft will spawn at a parking spot with 50:50 change of engines on or off.
---
------
---@param self RAT 
---@return RAT #RAT self object.
function RAT:SetTakeoffColdOrHot() end

---Set takeoff type to hot.
---Aircraft will spawn at a parking spot with engines on.
---
------
---@param self RAT 
---@return RAT #RAT self object.
function RAT:SetTakeoffHot() end

---Set takeoff type to runway.
---Aircraft will spawn directly on the runway.
---
------
---@param self RAT 
---@return RAT #RAT self object.
function RAT:SetTakeoffRunway() end

---Set the terminal type the aircraft use when spawning at an airbase.
---See [DCS_func_getParking](https://wiki.hoggitworld.com/view/DCS_func_getParking).
---Note that some additional terminal types have been introduced. Check Wrapper.Airbase#AIRBASE class for details.
---Also note that only airports which have this kind of terminal are possible departures and/or destinations.
---
------
---
---USAGE
---```
---c17=RAT:New("C-17 BIG Plane")
---c17:SetTerminalType(AIRBASE.TerminalType.OpenBig) -- Only very big parking spots are used.
---c17:Spawn(5)
---```
------
---@param self RAT 
---@param termtype AIRBASE.TerminalType Type of terminal. Use enumerator AIRBASE.TerminalType.XXX.
---@return RAT #RAT self object. 
function RAT:SetTerminalType(termtype) end

---Triggers the spawning of AI aircraft.
---Note that all additional options should be set before giving the spawn command.
---
------
---
---USAGE
---```
---yak:Spawn(5) will spawn five aircraft. By default aircraft will spawn at neutral and red airports if the template group is part of the red coalition.
---```
------
---@param self RAT 
---@param naircraft? number (Optional) Number of aircraft to spawn. Default is one aircraft.
---@return boolean #True if spawning was successful or nil if nothing was spawned.
function RAT:Spawn(naircraft) end

---Report status of RAT groups.
---
------
---@param self RAT 
---@param message? boolean (Optional) Send message with report to all if true.
---@param forID? number (Optional) Send message only for this ID.
function RAT:Status(message, forID) end

---Aircraft report status update messages along the route.
---
------
---@param self RAT 
---@param switch boolean Swtich reports on (true) or off (false). No argument is on.
---@return RAT #RAT self object.
function RAT:StatusReports(switch) end

---Stop RAT spawning by unhandling events, stoping schedulers etc.
---
------
---@param self RAT 
---@param delay number Delay before stop in seconds.
function RAT:Stop(delay) end

---Set the time after which inactive groups will be destroyed.
---
------
---@param self RAT 
---@param time number Time in seconds. Default is 600 seconds = 10 minutes. Minimum is 60 seconds.
---@return RAT #RAT self object.
function RAT:TimeDestroyInactive(time) end

---Spawn aircraft in uncontrolled state.
---Aircraft will only sit at their parking spots. They can be activated randomly by the RAT:ActivateUncontrolled() function.
---
------
---@param self RAT 
---@return RAT #RAT self object.
function RAT:Uncontrolled() end

---Adds andd initializes a new flight after it was spawned.
---
------
---@param self RAT 
---@param name string Group name of the flight.
---@param dest string Name of the destination airport.
function RAT:_ATCAddFlight(name, dest) end


---
------
function RAT._ATCCheck() end

---Giving landing clearance for aircraft by setting user flag.
---
------
---@param airportname string Name of destination airport.
---@param flightname string Group name of flight, which gets landing clearence.
function RAT._ATCClearForLanding(airportname, flightname) end

---Deletes a flight from ATC lists after it landed.
---
------
---@param t table Table.
---@param entry string Flight name which shall be deleted.
function RAT._ATCDelFlight(t, entry) end

---Takes care of organisational stuff after a plane has landed.
---
------
---@param name string Group name of flight.
function RAT._ATCFlightLanded(name) end

---Initializes the ATC arrays and starts schedulers.
---
------
---@param airports_map table List of all airports of the map.
function RAT._ATCInit(airports_map) end


---
------
function RAT._ATCQueue() end

---Registers a flight once it is near its holding point at the final destination.
---
------
---@param self RAT 
---@param name string Group name of the flight.
---@param time number Time the fight first registered.
function RAT:_ATCRegisterFlight(name, time) end


---
------
function RAT._ATCStatus() end

---Randomly activates an uncontrolled aircraft.
---
------
---@param self RAT 
function RAT:_ActivateUncontrolled() end

---Add names of all friendly airports to possible departure or destination airports if they are not already in the list.
---
------
---@param self RAT 
---@param ports table List of departure or destination airports/zones that will be added.
function RAT:_AddFriendlyAirports(ports) end

---Test if an airport exists on the current map.
---
------
---@param self RAT 
---@param name string 
---@return boolean #True if airport exsits, false otherwise.
function RAT:_AirportExists(name) end

---Anticipated group name from alias and spawn index.
---
------
---@param self RAT 
---@param index number Spawnindex of group if given or self.SpawnIndex+1 by default.
---@return string #Name the group will get after it is spawned.
function RAT:_AnticipatedGroupName(index) end

---Function checks consistency of user input and automatically adjusts parameters if necessary.
---
------
---@param self RAT 
function RAT:_CheckConsistency() end

---Find aircraft that have accidentally been spawned on top of each other.
---
------
---@param self RAT 
---@param group GROUP Units of this group will be checked.
---@param distmin number Allowed distance in meters between units. Units with a distance smaller than this number are considered to be on top of each other.
---@return boolean #True if group was destroyed because it was on top of another unit. False if otherwise.
function RAT:_CheckOnTop(group, distmin) end

---Set RAT group to be (im-)mortal.
---
------
---@param self RAT 
---@param group GROUP Group to be set (im-)mortal.
---@param switch boolean True enables immortality, false disables it.
function RAT:_CommandImmortal(group, switch) end

---Set RAT group to (in-)visible for other AI forces.
---
------
---@param self RAT 
---@param group GROUP Group to be set (in)visible.
---@param switch boolean If true, the group is invisible. If false the group will be visible.
function RAT:_CommandInvisible(group, switch) end

---Determine the heading from point a to point b.
---
------
---@param self RAT 
---@param a COORDINATE Point from.
---@param b COORDINATE Point to.
---@return number #Heading/angle in degrees.
function RAT:_Course(a, b) end

---Turn debug messages on or off.
---Default is off.
---
------
---@param self RAT 
---@param switch boolean Turn debug on=true or off=false. No argument means on.
---@return RAT #RAT self object.
function RAT:_Debug(switch) end

---Delete all markers on F10 map.
---
------
---@param self RAT 
function RAT:_DeleteMarkers() end

---Despawn group.
---The `FLIGHTGROUP` is despawned and stopped. The ratcraft is removed from the self.ratcraft table. Menues are removed.
---
------
---@param self RAT 
---@param group GROUP Group to be despawned.
---@param delay number Delay in seconds before the despawn happens. Default is immidiately.
function RAT:_Despawn(group, delay) end

---Check if airport is excluded from possible departures and destinations.
---
------
---@param self RAT 
---@param port string Name of airport, FARP or ship to check.
---@return boolean #true if airport is excluded and false otherwise.
function RAT:_Excluded(port) end

---Find airports within a zone.
---
------
---@param self RAT 
---@param zone ZONE 
---@return  ##list Table with airport names that lie within the zone.
function RAT:_GetAirportsInZone(zone) end

---Get all "friendly" airports of the current map.
---Fills the self.airports{} table.
---
------
---@param self RAT 
function RAT:_GetAirportsOfCoalition() end

---Get all airports of the current map.
---
------
---@param self RAT 
function RAT:_GetAirportsOfMap() end

---Get departure airbase of a given ratcraft.
---
------
---@param self RAT 
---@param ratcraft RAT.RatCraft Ratcraft object.
---@return AIRBASE #Destination airbase or nil.
function RAT:_GetDepartureAirbase(ratcraft) end

---Get destination airbase of a given ratcraft.
---
------
---@param self RAT 
---@param ratcraft RAT.RatCraft Ratcraft object.
---@return AIRBASE #Destination airbase or nil.
function RAT:_GetDestinationAirbase(ratcraft) end

---Get (relative) life of first unit of a group.
---
------
---@param self RAT 
---@param group GROUP Group of unit.
---@return number #Life of unit in percent.
function RAT:_GetLife(group) end

---Get aircraft dimensions length, width, height.
---
------
---@param self RAT 
---@param unit UNIT The unit which is we want the size of.
---@return number #Size, i.e. max(length,width) of unit.
function RAT:_GetObjectSize(unit) end

---Get ratcraft from group.
---
------
---@param self RAT 
---@param group Group The group object.
---@return RAT.RatCraft #The ratcraft object.
function RAT:_GetRatcraftFromGroup(group) end

---Determine the heading for an aircraft to be entered in the route template.
---
------
---@param self RAT 
---@param course number The course between two points in degrees.
---@return number #heading Heading in rad.
function RAT:_Heading(course) end

---Initialize basic parameters of the aircraft based on its (template) group in the mission editor.
---
------
---@param self RAT 
---@param DCSgroup Group Group of the aircraft in the mission editor.
function RAT:_InitAircraft(DCSgroup) end

---Check if a given airbase has a FLIGHTCONTROL.
---
------
---@param self RAT 
---@param airbase AIRBASE The airbase.
---@return boolean #`true` if the airbase has a FLIGHTCONTROL.
function RAT:_IsFlightControlAirbase(airbase) end

---Check if airport is friendly, i.e.
---belongs to the right coalition.
---
------
---@param self RAT 
---@param port string Name of airport, FARP or ship to check.
---@return boolean #true if airport is friendly and false otherwise.
function RAT:_IsFriendly(port) end

---Calculate minimum distance between departure and destination for given minimum flight level and climb/decent rates.
---
------
---@param self RAT 
---@param alpha number Angle of climb [rad].
---@param beta number Angle of descent [rad].
---@param ha number Height difference between departure and cruise altiude.
---@param hb number Height difference between cruise altitude and destination.
---@return number #d1 Minimum distance for climb phase to reach cruise altitude.
---@return number #d2 Minimum distance for descent phase to reach destination height.
---@return number #dtot Minimum total distance to climb and descent.
function RAT:_MinDistance(alpha, beta, ha, hb) end

---Modifies the template of the group to be spawned.
---In particular, the waypoints of the group's flight plan are copied into the spawn template.
---This allows to spawn at airports and also land at other airports, i.e. circumventing the DCS "landing bug".
---
------
---@param self RAT 
---@param waypoints table The waypoints of the AI flight plan.
---@param livery? string (Optional) Livery of the aircraft. All members of a flight will get the same livery.
---@param spawnplace? COORDINATE (Optional) Place where spawning should happen. If not present, first waypoint is taken.
---@param departure AIRBASE Departure airbase or zone.
---@param takeoff number Takeoff type.
---@param parkingdata table Parking data, i.e. parking spot coordinates and terminal ids for all units of the group.
---@param uncontrolled boolean If `true`, group is spawned uncontrolled.
---@return boolean #True if modification was successful or nil if not, e.g. when no parking space was found and spawn in air is disabled.
function RAT:_ModifySpawnTemplate(waypoints, livery, spawnplace, departure, takeoff, parkingdata, uncontrolled) end

---Check if a name/string is in a list or not.
---
------
---@param self RAT 
---@param liste table List of names to be checked.
---@param name string Name to be checked for.
function RAT:_NameInList(liste, name) end

---Function is executed when a unit is spawned.
---
------
---@param self RAT 
---@param EventData EVENTDATA 
function RAT:_OnBirth(EventData) end

---Function is executed when a unit crashes.
---
------
---@param self RAT 
---@param EventData EVENTDATA 
function RAT:_OnCrash(EventData) end

---Function is executed when a unit is dead.
---
------
---@param self RAT 
---@param EventData EVENTDATA 
function RAT:_OnDead(EventData) end

---Function is executed when a unit is dead or crashes.
---
------
---@param self RAT 
---@param EventData EVENTDATA 
function RAT:_OnDeadOrCrash(EventData) end

---Function is executed when a unit shuts down its engines.
---
------
---@param self RAT 
---@param EventData EVENTDATA 
function RAT:_OnEngineShutdown(EventData) end

---Function is executed when a unit starts its engines.
---
------
---@param self RAT 
---@param EventData EVENTDATA 
function RAT:_OnEngineStartup(EventData) end

---Function is executed when a unit is hit.
---
------
---@param self RAT 
---@param EventData EVENTDATA 
function RAT:_OnHit(EventData) end

---Function is executed when a unit lands.
---
------
---@param self RAT 
---@param EventData EVENTDATA 
function RAT:_OnLand(EventData) end

---Function is executed when a unit takes off.
---
------
---@param self RAT 
---@param EventData EVENTDATA 
function RAT:_OnTakeoff(EventData) end

---Set the departure airport of the AI.
---If no airport name is given explicitly an airport from the coalition is chosen randomly.
---If takeoff style is set to "air", we use zones around the airports or the zones specified by user input.
---
------
---@param self RAT 
---@param takeoff number Takeoff type.
---@return AIRBASE #Departure airport if spawning at airport.
---@return ZONE #Departure zone if spawning in air.
function RAT:_PickDeparture(takeoff) end

---Pick destination airport or zone depending on departure position.
---
------
---@param self RAT 
---@param departure AIRBASE Departure airport or zone.
---@param q COORDINATE Coordinate of the departure point.
---@param minrange number Minimum range to q in meters.
---@param maxrange number Maximum range to q in meters.
---@param random boolean Destination is randomly selected from friendly airport (true) or from destinations specified by user input (false).
---@param landing number Number indicating whether we land at a destination airport or fly to a zone object.
---@return AIRBASE #destination Destination airport or zone.
function RAT:_PickDestination(departure, q, minrange, maxrange, random, landing) end

---Place markers of the waypoints.
---Note we assume a very specific number and type of waypoints here.
---
------
---@param self RAT 
---@param waypoints table Table with waypoints.
---@param waypointdescriptions table Table with waypoint descriptions
---@param index number Spawn index of group.
function RAT:_PlaceMarkers(waypoints, waypointdescriptions, index) end

---Randomize a value by a certain amount.
---
------
---
---USAGE
---```
---_Randomize(100, 0.1) returns a value between 90 and 110, i.e. a plus/minus ten percent variation.
---```
------
---@param self RAT 
---@param value number The value which should be randomized
---@param fac number Randomization factor.
---@param lower? number (Optional) Lower limit of the returned value.
---@param upper? number (Optional) Upper limit of the returned value.
---@return number #Randomized value.
function RAT:_Randomize(value, fac, lower, upper) end

---Remove ratcraft from self.ratcraft table.
---
------
---@param self RAT 
---@param ratcraft RAT.RatCraft The ratcraft to be removed.
---@return RAT #self
function RAT:_RemoveRatcraft(ratcraft) end

---Despawn the original group and re-spawn a new one.
---
------
---@param self RAT 
---@param group GROUP The group that should be respawned.
---@param lastpos COORDINATE Last known position of the group.
---@param delay number Delay before despawn in seconds.
function RAT:_Respawn(group, lastpos, delay) end

---Provide information about the assigned flightplan.
---
------
---@param self RAT 
---@param waypoints table Waypoints of the flight plan.
---@param comment string Some comment to identify the provided information.
---@param waypointdescriptions table Waypoint descriptions.
---@return number #total Total route length in meters.
function RAT:_Routeinfo(waypoints, comment, waypointdescriptions) end

---Create a table with the valid coalitions for departure and destination airports.
---
------
---@param self RAT 
function RAT:_SetCoalitionTable() end

---Set a marker visible for all on the F10 map.
---
------
---@param self RAT 
---@param text string Info text displayed at maker.
---@param wp table Position of marker coming in as waypoint, i.e. has x, y and alt components.
---@param index number Spawn index of group.
function RAT:_SetMarker(text, wp, index) end

---Set ROE for a group.
---
------
---@param self RAT 
---@param flightgroup FLIGHTGROUP Group for which the ROE is set.
---@param roe string ROE of group.
function RAT:_SetROE(flightgroup, roe) end

---Set ROT for a group.
---
------
---@param self RAT 
---@param flightgroup FLIGHTGROUP Group for which the ROT is set.
---@param rot string ROT of group.
function RAT:_SetROT(flightgroup, rot) end

---Set the route of the AI plane.
---Due to DCS landing bug, this has to be done before the unit is spawned.
---
------
---@param self RAT 
---@param takeoff number Takeoff type. Could also be air start.
---@param landing number Landing type. Could also be a destination in air.
---@param _departure? AIRBASE (Optional) Departure airbase.
---@param _destination? AIRBASE (Optional) Destination airbase.
---@param _waypoint table Initial waypoint.
---@return AIRBASE #Departure airbase.
---@return AIRBASE #Destination airbase.
---@return table #Table of flight plan waypoints.
---@return table #Table of waypoint descriptions.
---@return table #Table of waypoint status.
function RAT:_SetRoute(takeoff, landing, _departure, _destination, _waypoint) end

---Set status of group.
---
------
---@param self RAT 
---@param group GROUP Group.
---@param status string Status of group.
function RAT:_SetStatus(group, status) end

---Spawn the AI aircraft with a route.
---Sets the departure and destination airports and waypoints.
---Modifies the spawn template.
---Sets ROE/ROT.
---Initializes the ratcraft array and group menu.
---
------
---@param self RAT 
---@param _departure? string (Optional) Name of departure airbase.
---@param _destination? string (Optional) Name of destination airbase.
---@param _takeoff number Takeoff type id.
---@param _landing number Landing type id.
---@param _livery string Livery to use for this group.
---@param _waypoint table First waypoint to be used (for continue journey, commute, etc).
---@param _lastpos? COORDINATE (Optional) Position where the aircraft will be spawned.
---@param _nrespawn number Number of already performed respawn attempts (e.g. spawning on runway bug).
---@param parkingdata table Explicitly specify the parking spots when spawning at an airport.
---@return number #Spawn index.
function RAT:_SpawnWithRoute(_departure, _destination, _takeoff, _landing, _livery, _waypoint, _lastpos, _nrespawn, parkingdata) end

---Create a waypoint that can be used with the Route command.
---
------
---@param self RAT 
---@param index number Running index of waypoints. Starts with 1 which is normally departure/spawn waypoint.
---@param description string Descrition of Waypoint.
---@param Type number Type of waypoint.
---@param Coord COORDINATE 3D coordinate of the waypoint.
---@param Speed number Speed in m/s.
---@param Altitude number Altitude in m.
---@param Airport AIRBASE Airport of object to spawn.
---@return table #Waypoints for DCS task route or spawn template.
function RAT:_Waypoint(index, description, Type, Coord, Speed, Altitude, Airport) end

---Test if a zone exists.
---
------
---@param self RAT 
---@param name string 
---@return boolean #True if zone exsits, false otherwise.
function RAT:_ZoneExists(name) end


---RAT ATC.
---@class RAT.ATC 
---@field Nclearance number Number of flights that get landing clearance simultaniously. Default 2.
---@field T0 number Time stamp [sec, timer.getTime()] when ATC was initialized.
---@field private airport table List of airports.
---@field private delay number Delay between landing flights in seconds. Default 240 sec.
---@field private flight table List of flights.
---@field private init boolean True if ATC was initialized.
---@field private messages boolean If `true`, ATC sends messages.
---@field private onfinal number Enumerator onfinal=100.
---@field private unregistered number Enumerator for unregistered flights unregistered=-1.
RAT.ATC = {}


---Data structure a RAT ATC airbase object.
---@class RAT.AtcAirport 
---@field Nonfinal number Number of flights on final.
---@field Tlastclearance number Time stamp when last flight started final approach.
---@field private busy boolean Whether airport is busy.
---@field private onfinal table List of flights on final.
---@field private queue table Queue.
---@field private traffic number Number of flights that landed (just for stats).
RAT.AtcAirport = {}


---Data structure a RAT ATC airbase object.
---@class RAT.AtcFlight 
---@field Tarrive number Time stamp when flight arrived at holding.
---@field Tonfinal number Time stamp when flight started final approach.
---@field private destination string Name of the destination airbase.
---@field private holding number Holding time.
RAT.AtcFlight = {}


---RAT rules of engagement.
---@class RAT.ROE 
---@field private returnfire string 
---@field private weaponfree string 
---@field private weaponhold string 
RAT.ROE = {}


---RAT reaction to threat.
---@class RAT.ROT 
---@field private evade string 
---@field private noreaction string 
---@field private passive string 
RAT.ROT = {}


---Datastructure of a spawned RAT group.
---@class RAT.RatCraft 
---@field Distance number Distance travelled in meters.
---@field Pnow COORDINATE Current position.
---@field private active boolean Whether the group is active or uncontrolled.
---@field private airborne boolean Whether this group is airborne.
---@field private departure AIRBASE Departure place of this group. Can also be a ZONE.
---@field private despawnme boolean Despawn group if `true` in the next status update.
---@field private destination AIRBASE Destination of this group. Can also be a ZONE.
---@field private flightgroup FLIGHTGROUP The flight group.
---@field private group Group The aircraft group.
---@field private index number Spawn index.
---@field private landing number Laning type.
---@field private livery string Livery of the group.
---@field private nrespawn number Number of respawns.
---@field private nunits number Number of units.
---@field private status string Status of the group.
---@field private takeoff number Takeoff type.
---@field private waypoints table Waypoints.
---@field private wpdesc table Waypoint descriptins.
---@field private wpstatus table Waypoint status.
RAT.RatCraft = {}


---Categories of the RAT class.
---@class RAT.cat 
---@field private heli string Heli.
---@field private plane string Plane.
RAT.cat = {}


---RAT friendly coalitions.
---@class RAT.coal 
---@field private neutral string 
---@field private same string 
---@field private sameonly string 
RAT.coal = {}


---RAT aircraft status.
---@class RAT.status 
---@field Climb string 
---@field Cruise string 
---@field Departure string 
---@field Descent string 
---@field DescentHolding string 
---@field Destination string 
---@field EventBirth string 
---@field EventBirthAir string 
---@field EventCrash string 
---@field EventDead string 
---@field EventEngineShutdown string 
---@field EventEngineStart string 
---@field EventEngineStartAir string 
---@field EventLand string 
---@field EventTakeoff string 
---@field Holding string 
---@field Spawned string 
---@field Uncontrolled string 
---@field Uturn string 
RAT.status = {}


---RAT unit conversions.
---@class RAT.unit 
---@field FL2m number 
---@field private ft2meter number 
---@field private kmh2ms number 
---@field private nm2km number 
---@field private nm2m number 
RAT.unit = {}


---RAT waypoint type.
---@class RAT.wp 
---@field private air number 
---@field private climb number 
---@field private cold number 
---@field private coldorhot number 
---@field private cruise number 
---@field private descent number 
---@field private finalwp number 
---@field private holding number 
---@field private hot number 
---@field private landing number 
---@field private runway number 
RAT.wp = {}


---# RATMANAGER class, extends Core.Base#BASE
---The RATMANAGER class manages spawning of multiple RAT objects in a very simple way.
---It is created by the  #RATMANAGER.New() contructor.
---RAT objects with different "tasks" can be defined as usual. However, they **must not** be spawned via the #RAT.Spawn() function.
---
---Instead, these objects can be added to the manager via the #RATMANAGER.Add(ratobject, min) function, where the first parameter "ratobject" is the #RAT object, while the second parameter "min" defines the
---minimum number of RAT aircraft of that object, which are alive at all time.
---
---The #RATMANAGER must be started by the #RATMANAGER.Start(startime) function, where the optional argument "startime" specifies the delay time in seconds after which the manager is started and the spawning beginns.
---If desired, the #RATMANAGER can be stopped by the #RATMANAGER.Stop(stoptime) function. The parameter "stoptime" specifies the time delay in seconds after which the manager stops.
---When this happens, no new aircraft will be spawned and the population will eventually decrease to zero.
---
---When you are using a time intervall like #RATMANAGER.dTspawn(delay), #RATMANAGER will ignore the amount set with #RATMANAGER.New(). #RATMANAGER.dTspawn(delay) will spawn infinite groups.
---
---## Example
---In this example, three different #RAT objects are created (but not spawned manually). The #RATMANAGER takes care that at least five aircraft of each type are alive and that the total number of aircraft
---spawned is 25. The #RATMANAGER is started after 30 seconds and stopped after two hours.
---
---    local a10c=RAT:New("RAT_A10C", "A-10C managed")
---    a10c:SetDeparture({"Batumi"})
---
---    local f15c=RAT:New("RAT_F15C", "F15C managed")
---    f15c:SetDeparture({"Sochi-Adler"})
---    f15c:DestinationZone()
---    f15c:SetDestination({"Zone C"})
---
---    local av8b=RAT:New("RAT_AV8B", "AV8B managed")
---    av8b:SetDeparture({"Zone C"})
---    av8b:SetTakeoff("air")
---    av8b:DestinationZone()
---    av8b:SetDestination({"Zone A"})
---
---    local manager=RATMANAGER:New(25)
---    manager:Add(a10c, 5)
---    manager:Add(f15c, 5)
---    manager:Add(av8b, 5)
---    manager:Start(30)
---    manager:Stop(7200)
---- RATMANAGER class
---@class RATMANAGER : BASE
---@field ClassName string Name of the Class.
---@field Debug boolean If true, be more verbose on output in DCS.log file.
---@field Tcheck number Time interval in seconds between checking of alive groups.
---@field private alive table Number of currently alive groups.
---@field private dTspawn number Time interval in seconds between spawns of groups.
---@field private id string Some ID to identify who we are in output of the DCS.log file.
---@field private manager SCHEDULER Scheduler managing the RAT objects.
---@field private managerid number Managing scheduler id.
---@field private min table Minimum number of RAT groups alive.
---@field private name string Name (alias) of RAT object.
---@field private nrat number Number of RAT objects.
---@field private ntot number Total number of active RAT groups.
---@field private rat table Array holding RAT objects etc.
RATMANAGER = {}

---Adds a RAT object to the RAT manager.
---Parameter min specifies the limit how many RAT groups are at least alive.
---
------
---@param self RATMANAGER 
---@param ratobject RAT RAT object to be managed.
---@param min number Minimum number of groups for this RAT object. Default is 1.
---@return RATMANAGER #RATMANAGER self object.
function RATMANAGER:Add(ratobject, min) end

---Creates a new RATMANAGER object.
---
------
---@param self RATMANAGER 
---@param ntot number Total number of RAT flights.
---@return RATMANAGER #RATMANAGER object
function RATMANAGER:New(ntot) end

---Sets the time interval between checks of alive RAT groups.
---Default is 60 seconds.
---
------
---@param self RATMANAGER 
---@param dt number Time interval in seconds.
---@return RATMANAGER #RATMANAGER self object.
function RATMANAGER:SetTcheck(dt) end

---Sets the time interval between spawning of groups.
---
------
---@param self RATMANAGER 
---@param dt number Time interval in seconds. Default is 1 second.
---@return RATMANAGER #RATMANAGER self object.
function RATMANAGER:SetTspawn(dt) end

---Starts the RAT manager and spawns the initial random number RAT groups for each RAT object.
---
------
---@param self RATMANAGER 
---@param delay number Time delay in seconds after which the RAT manager is started. Default is 5 seconds.
---@return RATMANAGER #RATMANAGER self object.
function RATMANAGER:Start(delay) end

---Stops the RAT manager.
---
------
---@param self RATMANAGER 
---@param delay number Delay in seconds before the manager is stopped. Default is 1 second.
---@return RATMANAGER #RATMANAGER self object.
function RATMANAGER:Stop(delay) end

---Counts the number of alive RAT objects.
---
------
---@param self RATMANAGER 
function RATMANAGER:_Count() end

---Manager function.
---Calculating the number of current groups and respawning new groups if necessary.
---
------
---@param self RATMANAGER 
function RATMANAGER:_Manage() end

---Rolls the dice for the number of necessary spawns.
---
------
---@param self RATMANAGER 
---@param nrat number Number of RAT objects.
---@param ntot number Total number of RAT flights.
---@param min table Minimum number of groups for each RAT object.
---@param alive table Number of alive groups of each RAT object.
function RATMANAGER:_RollDice(nrat, ntot, min, alive) end

---Instantly starts the RAT manager and spawns the initial random number RAT groups for each RAT object.
---
------
---@param self RATMANAGER 
---@param RATMANAGER RATMANAGER self object.
---@param i number Index.
function RATMANAGER:_Spawn(RATMANAGER, i) end



