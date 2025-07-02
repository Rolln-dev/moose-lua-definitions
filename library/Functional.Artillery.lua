---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Artillery.JPG" width="100%">
---
---**Functional** - Control artillery units.
---
---===
---
---The ARTY class can be used to easily assign and manage targets for artillery units using an advanced queueing system.
---
---## Features:
---
---  * Multiple targets can be assigned. No restriction on number of targets.
---  * Targets can be given a priority. Engagement of targets is executed a according to their priority.
---  * Engagements can be scheduled, i.e. will be executed at a certain time of the day.
---  * Multiple relocations of the group can be assigned and scheduled via queueing system.
---  * Special weapon types can be selected for each attack, e.g. cruise missiles for Naval units.
---  * Automatic rearming once the artillery is out of ammo (optional).
---  * Automatic relocation after each firing engagement to prevent counter strikes (optional).
---  * Automatic relocation movements to get the battery within firing range (optional).
---  * Simulation of tactical nuclear shells as well as illumination and smoke shells.
---  * New targets can be added during the mission, e.g. when they are detected by recon units.
---  * Targets and relocations can be assigned by placing markers on the F10 map.
---  * Finite state machine implementation. Mission designer can interact when certain events occur.
---
---====
---
---## [MOOSE YouTube Channel](https://www.youtube.com/channel/UCjrA9j5LQoWsG4SpS8i79Qg)
---
---===
---
---### Author: **funkyfranky**
---
---### Contributions: FlightControl
---
---====
---Enables mission designers easily to assign targets for artillery units.
---Since the implementation is based on a Finite State Model (FSM), the mission designer can
---interact with the process at certain events or states.
---
---A new ARTY object can be created with the #ARTY.New(*group*) constructor.
---The parameter *group* has to be a MOOSE Group object and defines ARTY group.
---
---The ARTY FSM process can be started by the #ARTY.Start() command.
---
---## The ARTY Process
---
---![Process](..\Presentations\ARTY\ARTY_Process.png)
---
---### Blue Branch
---After the FMS process is started the ARTY group will be in the state **CombatReady**. Once a target is assigned the **OpenFire** event will be triggered and the group starts
---firing. At this point the group in in the state **Firing**.
---When the defined number of shots has been fired on the current target the event **CeaseFire** is triggered. The group will stop firing and go back to the state **CombatReady**.
---If another target is defined (or multiple engagements of the same target), the cycle starts anew.
---
---### Violet Branch
---When the ARTY group runs out of ammunition, the event **Winchester** is triggered and the group enters the state **OutOfAmmo**.
---In this state, the group is unable to engage further targets.
---
---### Red Branch
---With the #ARTY.SetRearmingGroup(*group*) command, a special group can be defined to rearm the ARTY group. If this unit has been assigned and the group has entered the state
---**OutOfAmmo** the event **Rearm** is triggered followed by a transition to the state **Rearming**.
---If the rearming group is less than 100 meters away from the ARTY group, the rearming process starts. If the rearming group is more than 100 meters away from the ARTY unit, the
---rearming group is routed to a point 20 to 100 m from the ARTY group.
---
---Once the rearming is complete, the **Rearmed** event is triggered and the group enters the state **CombatReady**. At this point targeted can be engaged again.
---
---### Green Branch
---The ARTY group can be ordered to change its position via the #ARTY.AssignMoveCoord() function as described below. When the group receives the command to move
---the event **Move** is triggered and the state changes to **Moving**. When the unit arrives to its destination the event **Arrived** is triggered and the group
---becomes **CombatReady** again.
---
---Note, that the ARTY group will not open fire while it is in state **Moving**. This property differentiates artillery from tanks.
---
---### Yellow Branch
---When a new target is assigned via the #ARTY.AssignTargetCoord() function (see below), the **NewTarget** event is triggered.
---
---## Assigning Targets
---Assigning targets is a central point of the ARTY class. Multiple targets can be assigned simultaneously and are put into a queue.
---Of course, targets can be added at any time during the mission. For example, once they are detected by a reconnaissance unit.
---
---In order to add a target, the function #ARTY.AssignTargetCoord(*coord*, *prio*, *radius*, *nshells*, *maxengage*, *time*, *weapontype*, *name*) has to be used.
---Only the first parameter *coord* is mandatory while all remaining parameters are all optional.
---
---### Parameters:
---
---* *coord*: Coordinates of the target, given as Core.Point#COORDINATE object.
---* *prio*: Priority of the target. This a number between 1 (high prio) and 100 (low prio). Targets with higher priority are engaged before targets with lower priority.
---* *radius*: Radius in meters which defines the area the ARTY group will attempt to be hitting. Default is 100 meters.
---* *nshells*: Number of shots (shells, rockets, missiles) fired by the group at each engagement of a target. Default is 5.
---* *maxengage*: Number of times a target is engaged.
---* *time*: Time of day the engagement is schedule in the format "hh:mm:ss" for hh=hours, mm=minutes, ss=seconds.
---For example "10:15:35". In the case the attack will be executed at a quarter past ten in the morning at the day the mission started.
---If the engagement should start on the following day the format can be specified as "10:15:35+1", where the +1 denotes the following day.
---This is useful for longer running missions or if the mission starts at 23:00 hours and the attack should be scheduled at 01:00 hours on the following day.
---Of course, later days are also possible by appending "+2", "+3", etc.
---**Note** that the time has to be given as a string. So the enclosing quotation marks "" are important.
---* *weapontype*: Specified the weapon type that should be used for this attack if the ARTY group has multiple weapons to engage the target.
---For example, this is useful for naval units which carry a bigger arsenal (cannons and missiles). Default is Auto, i.e. DCS logic selects the appropriate weapon type.
---*name*: A special name can be defined for this target. Default name are the coordinates of the target in LL DMS format. If a name is already given for another target
---or the same target should be attacked two or more times with different parameters a suffix "#01", "#02", "#03" is automatically appended to the specified name.
---
---## Target Queue
---In case multiple targets have been defined, it is important to understand how the target queue works.
---
---Here, the essential parameters are the priority *prio*, the number of engagements *maxengage* and the scheduled *time* as described above.
---
---For example, we have assigned two targets one with *prio*=10 and the other with *prio*=50 and both targets should be engaged three times (*maxengage*=3).
---Let's first consider the case that none of the targets is scheduled to be executed at a certain time (*time*=nil).
---The ARTY group will first engage the target with higher priority (*prio*=10). After the engagement is finished, the target with lower priority is attacked.
---This is because the target with lower prio has been attacked one time less. After the attack on the lower priority task is finished and both targets
---have been engaged equally often, the target with the higher priority is engaged again. This continues until a target has engaged three times.
---Once the maximum number of engagements is reached, the target is deleted from the queue.
---
---In other words, the queue is first sorted with respect to the number of engagements and targets with the same number of engagements are sorted with
---respect to their priority.
---
---### Timed Engagements
---
---As mentioned above, targets can be engaged at a specific time of the day via the *time* parameter.
---
---If the *time* parameter is specified for a target, the first engagement of that target will happen at that time of the day and not before.
---This also applies when multiple engagements are requested via the *maxengage* parameter. The first attack will not happen before the specified time.
---When that timed attack is finished, the *time* parameter is deleted and the remaining engagements are carried out in the same manner as for untimed targets (described above).
---
---Of course, it can happen that a scheduled task should be executed at a time, when another target is already under attack.
---If the priority of the target is higher than the priority of the current target, then the current attack is cancelled and the engagement of the target with the higher
---priority is started.
---
---By contrast, if the current target has a higher priority than the target scheduled at that time, the current attack is finished before the scheduled attack is started.
---
---## Determining the Amount of Ammo
---
---In order to determine when a unit is out of ammo and possible initiate the rearming process it is necessary to know which types of weapons have to be counted.
---For most artillery unit types, this is simple because they only have one type of weapon and hence ammunition.
---
---However, there are more complex scenarios. For example, naval units carry a big arsenal of different ammunition types ranging from various cannon shell types
---over surface-to-air missiles to cruise missiles. Obviously, not all of these ammo types can be employed for artillery tasks.
---
---Unfortunately, there is no easy way to count only those ammo types useable as artillery. Therefore, to keep the implementation general the user
---can specify the names of the ammo types by the following functions:
---
---* #ARTY.SetShellTypes(*tableofnames*): Defines the ammo types for unguided cannons, e.g. *tableofnames*={"weapons.shells"}, i.e. **all** types of shells are counted.
---* #ARTY.SetRocketTypes(*tableofnames*): Defines the ammo types of unguided rockets, e.g. *tableofnames*={"weapons.nurs"}, i.e. **all** types of rockets are counted.
---* #ARTY.SetMissileTypes(*tableofnames*): Defines the ammo types of guided missiles, e.g. is *tableofnames*={"weapons.missiles"}, i.e. **all** types of missiles are counted.
---
---**Note** that the default parameters "weapons.shells", "weapons.nurs", "weapons.missiles" **should in priciple** capture all the corresponding ammo types.
---However, the logic searches for the string "weapon.missies" in the ammo type. Especially for missiles, this string is often not contained in the ammo type descriptor.
---
---One way to determine which types of ammo the unit carries, one can use the debug mode of the arty class via #ARTY.SetDebugON().
---In debug mode, the all ammo types of the group are printed to the monitor as message and can be found in the DCS.log file.
---
---## Employing Selected Weapons
---
---If an ARTY group carries multiple weapons, which can be used for artillery task, a certain weapon type can be selected to attack the target.
---This is done via the *weapontype* parameter of the #ARTY.AssignTargetCoord(..., *weapontype*, ...) function.
---
---The enumerator #ARTY.WeaponType has been defined to select a certain weapon type. Supported values are:
---
---* #ARTY.WeaponType.Auto: Automatic weapon selection by the DCS logic. This is the default setting.
---* #ARTY.WeaponType.Cannon: Only cannons are used during the attack. Corresponding ammo type are shells and can be defined by #ARTY.SetShellTypes.
---* #ARTY.WeaponType.Rockets: Only unguided are used during the attack. Corresponding ammo type are rockets/nurs and can be defined by #ARTY.SetRocketTypes.
---* #ARTY.WeaponType.CruiseMissile: Only cruise missiles are used during the attack. Corresponding ammo type are missiles and can be defined by #ARTY.SetMissileTypes.
---* #ARTY.WeaponType.TacticalNukes: Use tactical nuclear shells. This works only with units that have shells and is described below.
---* #ARTY.WeaponType.IlluminationShells: Use illumination shells. This works only with units that have shells and is described below.
---* #ARTY.WeaponType.SmokeShells: Use smoke shells. This works only with units that have shells and is described below.
---
---## Assigning Relocation Movements
---The ARTY group can be commanded to move. This is done by the #ARTY.AssignMoveCoord(*coord*, *time*, *speed*, *onroad*, *cancel*, *name*) function.
---With this multiple timed moves of the group can be scheduled easily. By default, these moves will only be executed if the group is state **CombatReady**.
---
---### Parameters
---
---* *coord*: Coordinates where the group should move to given as Core.Point#COORDINATE object.
---* *time*: The time when the move should be executed. This has to be given as a string in the format "hh:mm:ss" (hh=hours, mm=minutes, ss=seconds).
---* *speed*: Speed of the group in km/h.
---* *onroad*: If this parameter is set to true, the group uses mainly roads to get to the commanded coordinates.
---* *cancel*: If set to true, any current engagement of targets is cancelled at the time the move should be executed.
---* *name*: Can be used to set a user defined name of the move. By default the name is created from the LL DMS coordinates.
---
---## Automatic Rearming
---
---If an ARTY group runs out of ammunition, it can be rearmed automatically.
---
---### Rearming Group
---The first way to activate the automatic rearming is to define a rearming group with the function #ARTY.SetRearmingGroup(*group*). For the blue side, this
---could be a M181 transport truck and for the red side an Ural-375 truck.
---
---Once the ARTY group is out of ammo and the **Rearm** event is triggered, the defined rearming truck will drive to the ARTY group.
---So the rearming truck does not have to be placed nearby the artillery group. When the rearming is complete, the rearming truck will drive back to its original position.
---
---### Rearming Place
---The second alternative is to define a rearming place, e.g. a FRAP, airport or any other warehouse. This is done with the function #ARTY.SetRearmingPlace(*coord*).
---The parameter *coord* specifies the coordinate of the rearming place which should not be further away then 100 meters from the warehouse.
---
---When the **Rearm** event is triggered, the ARTY group will move to the rearming place. Of course, the group must be mobil. So for a mortar this rearming procedure would not work.
---
---After the rearming is complete, the ARTY group will move back to its original position and resume normal operations.
---
---### Rearming Group **and** Rearming Place
---If both a rearming group *and* a rearming place are specified like described above, both the ARTY group and the rearming truck will move to the rearming place and meet there.
---
---After the rearming is complete, both groups will move back to their original positions.
---
---## Simulated Weapons
---
---In addition to the standard weapons a group has available some special weapon types that are not possible to use in the native DCS environment are simulated.
---
---### Tactical Nukes
---
---ARTY groups that can fire shells can also be used to fire tactical nukes. This is achieved by setting the weapon type to **ARTY.WeaponType.TacticalNukes** in the
---#ARTY.AssignTargetCoord() function.
---
---By default, they group does not have any nukes available. To give the group the ability the function #ARTY.SetTacNukeShells(*n*) can be used.
---This supplies the group with *n* nuclear shells, where *n* is restricted to the number of conventional shells the group can carry.
---Note that the group must always have conventional shells left in order to fire a nuclear shell.
---
---The default explosion strength is 0.075 kilo tons TNT. The can be changed with the #ARTY.SetTacNukeWarhead(*strength*), where *strength* is given in kilo tons TNT.
---
---### Illumination Shells
---
---ARTY groups that possess shells can fire shells with illumination bombs. First, the group needs to be equipped with this weapon. This is done by the
---function #ARTY.SetIlluminationShells(*n*, *power*), where *n* is the number of shells the group has available and *power* the illumination power in mega candela (mcd).
---
---In order to execute an engagement with illumination shells one has to use the weapon type *ARTY.WeaponType.IlluminationShells* in the
---#ARTY.AssignTargetCoord() function.
---
---In the simulation, the explosive shell that is fired is destroyed once it gets close to the target point but before it can actually impact.
---At this position an illumination bomb is triggered at a random altitude between 500 and 1000 meters. This interval can be set by the function
---#ARTY.SetIlluminationMinMaxAlt(*minalt*, *maxalt*).
---
---### Smoke Shells
---
---In a similar way to illumination shells, ARTY groups can also employ smoke shells. The number of smoke shells the group has available is set by the function
---#ARTY.SetSmokeShells(*n*, *color*), where *n* is the number of shells and *color* defines the smoke color. Default is SMOKECOLOR.Red.
---
---The weapon type to be used in the #ARTY.AssignTargetCoord() function is *ARTY.WeaponType.SmokeShells*.
---
---The explosive shell the group fired is destroyed shortly before its impact on the ground and smoke of the specified color is triggered at that position.
---
---
---## Assignments via Markers on F10 Map
---
---Targets and relocations can be assigned by players via placing a mark on the F10 map. The marker text must contain certain keywords.
---
---This feature can be turned on with the #ARTY.SetMarkAssignmentsOn(*key*, *readonly*). The parameter *key* is optional. When set, it can be used as PIN, i.e. only
---players who know the correct key are able to assign and cancel targets or relocations. Default behavior is that all players belonging to the same coalition as the
---ARTY group are able to assign targets and moves without a key.
---
---### Target Assignments
---A new target can be assigned by writing **arty engage** in the marker text.
---This is followed by a **comma separated list** of (optional) keywords and parameters.
---First, it is important to address the ARTY group or groups that should engage. This can be done in numerous ways. The keywords are *battery*, *alias*, *cluster*.
---It is also possible to address all ARTY groups by the keyword *everyone* or *allbatteries*. These two can be used synonymously.
---**Note that**, if no battery is assigned nothing will happen.
---
---* *everyone* or *allbatteries* The target is assigned to all batteries.
---* *battery* Name of the ARTY group that the target is assigned to. Note that **the name is case sensitive** and has to be given in quotation marks. Default is all ARTY groups of the right coalition.
---* *alias* Alias of the ARTY group that the target is assigned to. The alias is **case sensitive** and needs to be in quotation marks.
---* *cluster* The cluster of ARTY groups that is addressed. Clusters can be defined by the function #ARTY.AddToCluster(*clusters*). Names are **case sensitive** and need to be in quotation marks.
---* *key* A number to authorize the target assignment. Only specifying the correct number will trigger an engagement.
---* *time* Time for which which the engagement is schedules, e.g. 08:42. Default is as soon as possible.
---* *prio*  Priority of the engagement as number between 1 (high prio) and 100 (low prio). Default is 50, i.e. medium priority.
---* *shots* Number of shots (shells, rockets or missiles) fired at each engagement. Default is 5.
---* *maxengage* Number of times the target is engaged. Default is 1.
---* *radius* Scattering radius of the fired shots in meters. Default is 100 m.
---* *weapon* Type of weapon to be used. Valid parameters are *cannon*, *rocket*, *missile*, *nuke*. Default is automatic selection.
---* *lldms* Specify the coordinates in Lat/Long degrees, minutes and seconds format. The actual location of the marker is unimportant here. The group will engage the coordinates given in the lldms keyword.
---Format is DD:MM:SS[N,S] DD:MM:SS[W,E]. See example below. This can be useful when coordinates in this format are obtained from elsewhere.
---* *readonly* The marker is readonly and cannot be deleted by users. Hence, assignment cannot be cancelled by removing the marker.
---
---Here are examples of valid marker texts:
---     arty engage, battery "Blue Paladin Alpha"
---     arty engage, everyone
---     arty engage, allbatteries
---     arty engage, alias "Bob", weapon missiles
---     arty engage, cluster "All Mortas"
---     arty engage, cluster "Northern Batteries" "Southern Batteries"
---     arty engage, cluster "Northern Batteries", cluster "Southern Batteries"
---     arty engage, cluster "Horwitzers", shots 20, prio 10, time 08:15, weapon cannons
---     arty engage, battery "Blue Paladin 1" "Blue MRLS 1", shots 10, time 10:15
---     arty engage, battery "Blue MRLS 1", key 666
---     arty engage, battery "Paladin Alpha", weapon nukes, shots 1, time 20:15
---     arty engage, battery "Horwitzer 1", lldms 41:51:00N 41:47:58E
---
---Note that the keywords and parameters are *case insensitive*. Only exception are the battery, alias and cluster names.
---These must be exactly the same as the names of the groups defined in the mission editor or the aliases and cluster names defined in the script.
---
---### Relocation Assignments
---
---Markers can also be used to relocate the group with the keyphrase **arty move**. This is done in a similar way as assigning targets. Here, the (optional) keywords and parameters are:
---
---* *time* Time for which which the relocation/move is schedules, e.g. 08:42. Default is as soon as possible.
---* *speed* The speed in km/h the group will drive at. Default is 70% of its max possible speed.
---* *on road* Group will use mainly roads. Default is off, i.e. it will go in a straight line from its current position to the assigned coordinate.
---* *canceltarget* Group will cancel all running firing engagements and immediately start to move. Default is that group will wait until is current assignment is over.
---* *battery* Name of the ARTY group that the relocation is assigned to.
---* *alias* Alias of the ARTY group that the target is assigned to. The alias is **case sensitive** and needs to be in quotation marks.
---* *cluster* The cluster of ARTY groups that is addressed. Clusters can be defined by the function #ARTY.AddToCluster(*clusters*). Names are **case sensitive** and need to be in quotation marks.
---* *key* A number to authorize the target assignment. Only specifying the correct number will trigger an engagement.
---* *lldms* Specify the coordinates in Lat/Long degrees, minutes and seconds format. The actual location of the marker is unimportant. The group will move to the coordinates given in the lldms keyword.
---Format is DD:MM:SS[N,S] DD:MM:SS[W,E]. See example below.
---* *readonly* Marker cannot be deleted by users any more. Hence, assignment cannot be cancelled by removing the marker.
---
---Here are some examples:
---     arty move, battery "Blue Paladin"
---     arty move, battery "Blue MRLS", canceltarget, speed 10, on road
---     arty move, cluster "mobile", lldms 41:51:00N 41:47:58E
---     arty move, alias "Bob", weapon missiles
---     arty move, cluster "All Howitzer"
---     arty move, cluster "Northern Batteries" "Southern Batteries"
---     arty move, cluster "Northern Batteries", cluster "Southern Batteries"
---     arty move, everyone
---
---### Requests
---
---Marks can also be to send requests to the ARTY group. This is done by the keyword **arty request**, which can have the keywords
---
---* *target* All assigned targets are reported.
---* *move* All assigned relocation moves are reported.
---* *ammo* Current ammunition status is reported.
---
---For example
---     arty request, everyone, ammo
---     arty request, battery "Paladin Bravo", targets
---     arty request, cluster "All Mortars", move
---
---The actual location of the marker is irrelevant for these requests.
---
---### Cancel
---
---Current actions can be cancelled by the keyword **arty cancel**. Actions that can be cancelled are current engagements, relocations and rearming assignments.
---
---For example
---     arty cancel, target, battery "Paladin Bravo"
---     arty cancel, everyone, move
---     arty cancel, rearming, battery "MRLS Charly"
---
---### Settings
---
---A few options can be set by marks. The corresponding keyword is **arty set**. This can be used to define the rearming place and group for a battery.
---
---To set the rearming place of a group at the marker position type
---     arty set, battery "Paladin Alpha", rearming place
---
---Setting the rearming group is independent of the position of the mark. Just create one anywhere on the map and type
---     arty set, battery "Mortar Bravo", rearming group "Ammo Truck M939"
---Note that the name of the rearming group has to be given in quotation marks and spelt exactly as the group name defined in the mission editor.
---
---## Transporting
---
---ARTY groups can be transported to another location as Cargo.Cargo by means of classes such as AI.AI_Cargo_APC, AI.AI_Cargo_Dispatcher_APC,
---AI.AI_Cargo_Helicopter, AI.AI_Cargo_Dispatcher_Helicopter or AI.AI_Cargo_Airplane.
---
---In order to do this, one needs to define an ARTY object via the #ARTY.NewFromCargoGroup(*cargogroup*, *alias*) function.
---The first argument *cargogroup* has to be a Cargo.CargoGroup#CARGO_GROUP object. The second argument *alias* is a string which can be freely chosen by the user.
---
---## Fine Tuning
---
---The mission designer has a few options to tailor the ARTY object according to his needs.
---
---* #ARTY.SetAutoRelocateToFiringRange(*maxdist*, *onroad*) lets the ARTY group automatically move to within firing range if a current target is outside the min/max firing range. The
---optional parameter *maxdist* is the maximum distance im km the group will move. If the distance is greater no relocation is performed. Default is 50 km.
---* #ARTY.SetAutoRelocateAfterEngagement(*rmax*, *rmin*) will cause the ARTY group to change its position after each firing assignment.
---Optional parameters *rmax*, *rmin* define the max/min distance for relocation of the group. Default distance is randomly between 300 and 800 m.
---* #ARTY.AddToCluster(*clusters*) Can be used to add the ARTY group to one or more clusters. All groups in a cluster can be addressed simultaniously with one marker command.
---* #ARTY.SetSpeed(*speed*) sets the speed in km/h the group moves at if not explicitly stated otherwise.
---* #ARTY.RemoveAllTargets() removes all targets from the target queue.
---* #ARTY.RemoveTarget(*name*) deletes the target with *name* from the target queue.
---* #ARTY.SetMaxFiringRange(*range*) defines the maximum firing range. Targets further away than this distance are not engaged.
---* #ARTY.SetMinFiringRange(*range*) defines the minimum firing range. Targets closer than this distance are not engaged.
---* #ARTY.SetRearmingGroup(*group*) sets the group responsible for rearming of the ARTY group once it is out of ammo.
---* #ARTY.SetReportON() and #ARTY.SetReportOFF() can be used to enable/disable status reports of the ARTY group send to all coalition members.
---* #ARTY.SetWaitForShotTime(*waittime*) sets the time after which a target is deleted from the queue if no shooting event occured after the target engagement started.
---Default is 300 seconds. Note that this can for example happen, when the assigned target is out of range.
---*  #ARTY.SetDebugON() and #ARTY.SetDebugOFF() can be used to enable/disable the debug mode.
---
---## Examples
---
---### Assigning Multiple Targets
---This basic example illustrates how to assign multiple targets and defining a rearming group.
---    -- Creat a new ARTY object from a Paladin group.
---    paladin=ARTY:New(GROUP:FindByName("Blue Paladin"))
---
---    -- Define a rearming group. This is a Transport M939 truck.
---    paladin:SetRearmingGroup(GROUP:FindByName("Blue Ammo Truck"))
---
---    -- Set the max firing range. A Paladin unit has a range of 20 km.
---    paladin:SetMaxFiringRange(20)
---
---    -- Low priorty (90) target, will be engage last. Target is engaged two times. At each engagement five shots are fired.
---    paladin:AssignTargetCoord(GROUP:FindByName("Red Targets 3"):GetCoordinate(),  90, nil,  5, 2)
---    -- Medium priorty (nil=50) target, will be engage second. Target is engaged two times. At each engagement ten shots are fired.
---    paladin:AssignTargetCoord(GROUP:FindByName("Red Targets 1"):GetCoordinate(), nil, nil, 10, 2)
---    -- High priorty (10) target, will be engage first. Target is engaged three times. At each engagement twenty shots are fired.
---    paladin:AssignTargetCoord(GROUP:FindByName("Red Targets 2"):GetCoordinate(),  10, nil, 20, 3)
---
---    -- Start ARTY process.
---    paladin:Start()
---**Note**
---
---* If a parameter should be set to its default value, it has to be set to *nil* if other non-default parameters follow. Parameters at the end can simply be skiped.
---* In this example, the target coordinates are taken from groups placed in the mission edit using the COORDINATE:GetCoordinate() function.
---
---### Scheduled Engagements
---    -- Mission starts at 8 o'clock.
---    -- Assign two scheduled targets.
---
---    -- Create ARTY object from Paladin group.
---    paladin=ARTY:New(GROUP:FindByName("Blue Paladin"))
---
---    -- Assign target coordinates. Priority=50 (medium), radius=100 m, use 5 shells per engagement, engage 1 time at two past 8 o'clock.
---    paladin:AssignTargetCoord(GROUP:FindByName("Red Targets 1"):GetCoordinate(), 50, 100,  5, 1, "08:02:00", ARTY.WeaponType.Auto, "Target 1")
---
---    -- Assign target coordinates. Priority=10 (high), radius=300 m, use 10 shells per engagement, engage 1 time at seven past 8 o'clock.
---    paladin:AssignTargetCoord(GROUP:FindByName("Red Targets 2"):GetCoordinate(), 10, 300, 10, 1, "08:07:00", ARTY.WeaponType.Auto, "Target 2")
---
---    -- Start ARTY process.
---    paladin:Start()
---
---### Specific Weapons
---This example demonstrates how to use specific weapons during an engagement.
---    -- Define the Normandy as ARTY object.
---    normandy=ARTY:New(GROUP:FindByName("Normandy"))
---
---    -- Add target: prio=50, radius=300 m, number of missiles=20, number of engagements=1, start time=08:05 hours, only use cruise missiles for this attack.
---    normandy:AssignTargetCoord(GROUP:FindByName("Red Targets 1"):GetCoordinate(),  20, 300,  50, 1, "08:01:00", ARTY.WeaponType.CruiseMissile)
---
---    -- Add target: prio=50, radius=300 m, number of shells=100, number of engagements=1, start time=08:15 hours, only use cannons during this attack.
---    normandy:AssignTargetCoord(GROUP:FindByName("Red Targets 1"):GetCoordinate(),  50, 300, 100, 1, "08:15:00", ARTY.WeaponType.Cannon)
---
---    -- Define shells that are counted to check whether the ship is out of ammo.
---    -- Note that this is necessary because the Normandy has a lot of other shell type weapons which cannot be used to engage ground targets in an artillery style manner.
---    normandy:SetShellTypes({"MK45_127"})
---
---    -- Define missile types that are counted.
---    normandy:SetMissileTypes({"BGM"})
---
---    -- Start ARTY process.
---    normandy:Start()
---
---### Transportation as Cargo
---This example demonstates how an ARTY group can be transported to another location as cargo.
---     -- Define a group as CARGO_GROUP
---     CargoGroupMortars=CARGO_GROUP:New(GROUP:FindByName("Mortars"), "Mortars", "Mortar Platoon Alpha", 100 , 10)
---
---     -- Define the mortar CARGO GROUP as ARTY object
---     mortars=ARTY:NewFromCargoGroup(CargoGroupMortars, "Mortar Platoon Alpha")
---
---     -- Start ARTY process
---     mortars:Start()
---
---     -- Setup AI cargo dispatcher for e.g. helos
---     SetHeloCarriers = SET_GROUP:New():FilterPrefixes("CH-47D"):FilterStart()
---     SetCargoMortars = SET_CARGO:New():FilterTypes("Mortars"):FilterStart()
---     SetZoneDepoly   = SET_ZONE:New():FilterPrefixes("Deploy"):FilterStart()
---     CargoHelo=AI_CARGO_DISPATCHER_HELICOPTER:New(SetHeloCarriers, SetCargoMortars, SetZoneDepoly)
---     CargoHelo:Start()
---The ARTY group will be transported and resume its normal operation after it has been deployed. New targets can be assigned at any time also during the transportation process.
---- ARTY class
---@class ARTY : FSM_CONTROLLABLE
---@field ClassName string Name of the class.
---@field Controllable NOTYPE 
---@field DCSdesc table DCS descriptors of the ARTY group.
---@field Debug boolean Write Debug messages to DCS log file and send Debug messages to all players.
---@field DisplayName string Extended type name of the ARTY group.
---@field IniGroupStrength number Inital number of units in the ARTY group.
---@field InitialCoord COORDINATE Initial coordinates of the ARTY group.
---@field IsArtillery boolean If true, ARTY group has attribute "Artillery". This is automatically derived from the DCS descriptor table.
---@field Nammo0 number Initial amount total ammunition (shells+rockets+missiles) of the whole group.
---@field Narty0 number Initial amount of artillery shells of the whole group.
---@field Nillu number Number of illumination shells the group has available. Note that if normal shells are empty, firing illumination shells is also not possible any more.
---@field Nillu0 number Initial amount of illumination shells of the whole group. Default is 0.
---@field Nmissiles0 number Initial amount of missiles of the whole group.
---@field Nrockets0 number Initial amount of rockets of the whole group.
---@field Nshells0 number Initial amount of shells of the whole group.
---@field Nshots number Number of shots fired on current target.
---@field Nsmoke number Number of smoke shells the group has available. Note that if normal shells are empty, firing smoke shells is also not possible any more.
---@field Nsmoke0 number Initial amount of smoke shells of the whole group. Default is 0.
---@field Nukes number Number of nuclear shells, the group has available. Note that if normal shells are empty, firing nukes is also not possible any more.
---@field Nukes0 number Initial amount of tactical nukes of the whole group. Default is 0.
---@field RearmingArtyOnRoad boolean If true, ARTY group will move to rearming place using mainly roads. Default false.
---@field RearmingDistance number Safe distance in meters between ARTY group and rearming group or place at which rearming is possible. Default 100 m.
---@field RearmingGroup GROUP Unit designated to rearm the ARTY group.
---@field RearmingGroupCoord COORDINATE Initial coordinates of the rearming unit. After rearming complete, the unit will return to this position.
---@field RearmingGroupOnRoad boolean If true, rearming group will move to ARTY group or rearming place using mainly roads. Default false.
---@field RearmingGroupSpeed number Speed in km/h the rearming unit moves at. Default is 50% of the max speed possible of the group.
---@field RearmingPlaceCoord COORDINATE Coordinates of the rearming place. If the place is more than 100 m away from the ARTY group, the group will go there.
---@field Smoke SMOKECOLOR color of smoke shells. Default SMOKECOLOR.red.
---@field Speed number Default speed in km/h the ARTY group moves at. Maximum speed possible is 80% of maximum speed the group can do.
---@field SpeedMax number Maximum speed of ARTY group in km/h. This is determined from the DCS descriptor table.
---@field StatusInterval number Update interval in seconds between status updates. Default 10 seconds.
---@field Type string Type of the ARTY group.
---@field WaitForShotTime number Max time in seconds to wait until fist shot event occurs after target is assigned. If time is passed without shot, the target is deleted. Default is 300 seconds.
---@field WeaponType ARTY.WeaponType 
---@field private alias string Name of the ARTY group.
---@field private ammomissiles table Table holding names of the missile types which are included when counting the ammo. Default is {"weapons.missiles"} which includes some guided missiles.
---@field private ammorockets table Table holding names of the rocket types which are included when counting the ammo. Default is {"weapons.nurs"} which includes most unguided rockets.
---@field private ammoshells table Table holding names of the shell types which are included when counting the ammo. Default is {"weapons.shells"} which include most shells.
---@field private autorelocate boolean ARTY group will automatically move to within the max/min firing range.
---@field private autorelocatemaxdist number Max distance [m] the ARTY group will travel to get within firing range. Default 50000 m = 50 km.
---@field private autorelocateonroad boolean ARTY group will use mainly road to automatically get within firing range. Default is false.
---@field private cargogroup CARGO_GROUP Cargo group object if ARTY group is a cargo that will be transported to another place.
---@field private clusters table Table of names of clusters the group belongs to. Can be used to address all groups within the cluster simultaniously.
---@field private coalition number The coalition of the arty group.
---@field private currentMove table Holds the current commanded move, if there is one assigned.
---@field private currentTarget ARTY.Target Holds the current target, if there is one assigned.
---@field private db ARTY.db 
---@field private dtTrack number Time interval in seconds for weapon tracking.
---@field private groupname string Name of the ARTY group as defined in the mission editor.
---@field private illuMaxalt number Maximum altitude in meters the illumination warhead will detonate.
---@field private illuMinalt number Minimum altitude in meters the illumination warhead will detonate.
---@field private illuPower number Power of illumination warhead in mega candela. Default 1 mcd.
---@field private iscargo boolean If true, ARTY group is defined as possible cargo. If it is immobile, targets out of range are not deleted from the queue.
---@field private ismobile boolean If true, ARTY group can move.
---@field private lid string Log id for DCS.log file.
---@field private markallow boolean If true, Players are allowed to assign targets and moves for ARTY group by placing markers on the F10 map. Default is false.
---@field private markkey number Authorization key. Only player who know this key can assign targets and moves via markers on the F10 map. Default no authorization required.
---@field private markreadonly boolean Marks for targets are readonly and cannot be removed by players. Default is false.
---@field private maxrange number Maximum firing range in kilometers. Targets further away than this distance are not engaged. Default 10000 km.
---@field private minrange number Minimum firing range in kilometers. Targets closer than this distance are not engaged. Default 0.1 km.
---@field private moves table All moves assigned.
---@field private nukefire boolean Ignite additional fires and smoke for nuclear explosions Default true.
---@field private nukefires number Number of nuclear fires and subexplosions.
---@field private nukerange number Demolition range of tactical nuclear explostions.
---@field private nukewarhead number Explosion strength of tactical nuclear warhead in kg TNT. Default 75000.
---@field private relocateRmax number Maximum distance in meters the group will look for places to relocate.
---@field private relocateRmin number Minimum distance in meters the group will look for places to relocate.
---@field private relocateafterfire boolean Group will relocate after each firing task. Default false.
---@field private report boolean Arty group sends messages about their current state or target to its coalition.
---@field private respawnafterdeath boolean Respawn arty group after all units are dead.
---@field private respawndelay number Respawn delay in seconds.
---@field private respawning boolean 
---@field private targets table All targets assigned.
---@field private version string Arty script version.
ARTY = {}

---Add ARTY group to one or more clusters.
---Enables addressing all ARTY groups within a cluster simultaniously via marker assignments.
---
------
---@param clusters table Table of cluster names the group should belong to.
---@return NOTYPE #self
function ARTY:AddToCluster(clusters) end

---Tell ARTY group it has arrived at its destination.
---Triggers the FSM event "Arrived".
---
------
function ARTY:Arrived() end

---Assign a target group to the ARTY group.
---Note that this will use the Attack Group Task rather than the Fire At Point Task.
---
------
---
---USAGE
---```
---paladin=ARTY:New(GROUP:FindByName("Blue Paladin"))
---paladin:AssignTargetCoord(GROUP:FindByName("Red Targets 1"):GetCoordinate(), 10, 300, 10, 1, "08:02:00", ARTY.WeaponType.Auto, "Target 1")
---paladin:Start()
---```
------
---@param group GROUP Target group.
---@param prio? number (Optional) Priority of target. Number between 1 (high) and 100 (low). Default 50.
---@param radius? number (Optional) Radius. Default is 100 m.
---@param nshells? number (Optional) How many shells (or rockets) are fired on target per engagement. Default 5.
---@param maxengage? number (Optional) How many times a target is engaged. Default 1.
---@param time? string (Optional) Day time at which the target should be engaged. Passed as a string in format "08:13:45". Current task will be canceled.
---@param weapontype? number (Optional) Type of weapon to be used to attack this target. Default ARTY.WeaponType.Auto, i.e. the DCS logic automatically determins the appropriate weapon.
---@param name? string (Optional) Name of the target. Default is LL DMS coordinate of the target. If the name was already given, the numbering "#01", "#02",... is appended automatically.
---@param unique? boolean (Optional) Target is unique. If the target name is already known, the target is rejected. Default false.
---@return string #Name of the target. Can be used for further reference, e.g. deleting the target from the list.
function ARTY:AssignAttackGroup(group, prio, radius, nshells, maxengage, time, weapontype, name, unique) end

---Assign coordinate to where the ARTY group should move.
---
------
---@param coord COORDINATE Coordinates of the new position.
---@param time? string (Optional) Day time at which the group should start moving. Passed as a string in format "08:13:45". Default is now.
---@param speed number (Optinal) Speed in km/h the group should move at. Default 70% of max posible speed of group.
---@param onroad? boolean (Optional) If true, group will mainly use roads. Default off, i.e. go directly towards the specified coordinate.
---@param cancel? boolean (Optional) If true, cancel any running attack when move should begin. Default is false.
---@param name? string (Optional) Name of the coordinate. Default is LL DMS string of the coordinate. If the name was already given, the numbering "#01", "#02",... is appended automatically.
---@param unique? boolean (Optional) Move is unique. If the move name is already known, the move is rejected. Default false.
---@return string #Name of the move. Can be used for further reference, e.g. deleting the move from the list.
function ARTY:AssignMoveCoord(coord, time, speed, onroad, cancel, name, unique) end

---Assign target coordinates to the ARTY group.
---Only the first parameter, i.e. the coordinate of the target is mandatory. The remaining parameters are optional and can be used to fine tune the engagement.
---
------
---
---USAGE
---```
---paladin=ARTY:New(GROUP:FindByName("Blue Paladin"))
---paladin:AssignTargetCoord(GROUP:FindByName("Red Targets 1"):GetCoordinate(), 10, 300, 10, 1, "08:02:00", ARTY.WeaponType.Auto, "Target 1")
---paladin:Start()
---```
------
---@param coord COORDINATE Coordinates of the target.
---@param prio? number (Optional) Priority of target. Number between 1 (high) and 100 (low). Default 50.
---@param radius? number (Optional) Radius. Default is 100 m.
---@param nshells? number (Optional) How many shells (or rockets) are fired on target per engagement. Default 5.
---@param maxengage? number (Optional) How many times a target is engaged. Default 1.
---@param time? string (Optional) Day time at which the target should be engaged. Passed as a string in format "08:13:45". Current task will be canceled.
---@param weapontype? number (Optional) Type of weapon to be used to attack this target. Default ARTY.WeaponType.Auto, i.e. the DCS logic automatically determins the appropriate weapon.
---@param name? string (Optional) Name of the target. Default is LL DMS coordinate of the target. If the name was already given, the numbering "#01", "#02",... is appended automatically.
---@param unique? boolean (Optional) Target is unique. If the target name is already known, the target is rejected. Default false.
---@return string #Name of the target. Can be used for further reference, e.g. deleting the target from the list.
function ARTY:AssignTargetCoord(coord, prio, radius, nshells, maxengage, time, weapontype, name, unique) end

---Order ARTY group to cease firing on a target.
---Triggers the FSM event "CeaseFire".
---
------
---@param target table Array holding the target data.
function ARTY:CeaseFire(target) end

---Tell ARTY group it is combat ready.
---Triggers the FSM event "CombatReady".
---
------
function ARTY:CombatReady() end

---Function called when a unit of the ARTY group died.
---Triggers the FSM event "Dead".
---
------
---@param unitname string Name of the unit that died.
function ARTY:Dead(unitname) end

---Get the number of shells a unit or group currently has.
---For a group the ammo count of all units is summed up.
---
------
---@param display boolean Display ammo table as message to all. Default false.
---@return number #Total amount of ammo the whole group has left.
---@return number #Number of shells the group has left.
---@return number #Number of rockets the group has left.
---@return number #Number of missiles the group has left.
---@return number #Number of artillery shells the group has left.
function ARTY:GetAmmo(display) end

---Order ARTY group to move to another location.
---Triggers the FSM event "Move".
---
------
---@param move table Array holding the relocation move data.
function ARTY:Move(move) end

---Creates a new ARTY object from a MOOSE group object.
---
------
---@param group GROUP The GROUP object for which artillery tasks should be assigned.
---@param alias? NOTYPE (Optional) Alias name the group will be calling itself when sending messages. Default is the group name.
---@return ARTY #ARTY object or nil if group does not exist or is not a ground or naval group.
function ARTY:New(group, alias) end

---Creates a new ARTY object from a MOOSE CARGO_GROUP object.
---
------
---@param cargogroup CARGO_GROUP The CARGO GROUP object for which artillery tasks should be assigned.
---@param alias? NOTYPE (Optional) Alias name the group will be calling itself when sending messages. Default is the group name.
---@return ARTY #ARTY object or nil if group does not exist or is not a ground or naval group.
function ARTY:NewFromCargoGroup(cargogroup, alias) end

---Add a new relocation move for the ARTY group.
---Triggers the FSM event "NewMove".
---
------
---@param move table Array holding the relocation move data.
function ARTY:NewMove(move) end

---Add a new target for the ARTY group.
---Triggers the FSM event "NewTarget".
---
------
---@param target table Array holding the target data.
function ARTY:NewTarget(target) end

---User function for OnAfer "Arrived" event.
---
------
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function ARTY:OnAfterArrvied(Controllable, From, Event, To) end

---User function for OnAfter "CeaseFire" event.
---
------
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param target table Array holding the target info.
function ARTY:OnAfterCeaseFire(Controllable, From, Event, To, target) end

---User function for OnAfter "Dead" event.
---
------
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Unitname string Name of the dead unit.
function ARTY:OnAfterDead(Controllable, From, Event, To, Unitname) end

---User function for OnAfer "Move" event.
---
------
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param move table Array holding the move info.
function ARTY:OnAfterMove(Controllable, From, Event, To, move) end

---User function for OnAfer "NewMove" event.
---
------
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param move table Array holding the move info.
function ARTY:OnAfterNewMove(Controllable, From, Event, To, move) end

---User function for OnAfter "NewTarget" event.
---
------
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param target table Array holding the target info.
function ARTY:OnAfterNewTarget(Controllable, From, Event, To, target) end

---User function for OnAfter "OpenFire" event.
---
------
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param target table Array holding the target info.
function ARTY:OnAfterOpenFire(Controllable, From, Event, To, target) end

---User function for OnAfter "Rearm" event.
---
------
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function ARTY:OnAfterRearm(Controllable, From, Event, To) end

---User function for OnAfter "Rearmed" event.
---
------
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function ARTY:OnAfterRearmed(Controllable, From, Event, To) end

---User function for OnAfter "Respawn" event.
---
------
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function ARTY:OnAfterRespawn(Controllable, From, Event, To) end

---User function for OnAfter "Start" event.
---
------
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function ARTY:OnAfterStart(Controllable, From, Event, To) end

---User function for OnAfter "Status" event.
---
------
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function ARTY:OnAfterStatus(Controllable, From, Event, To) end

---User function for OnAfter "Winchester" event.
---
------
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function ARTY:OnAfterWinchester(Controllable, From, Event, To) end

---User function for OnEnter "CombatReady" state.
---
------
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function ARTY:OnEnterCombatReady(Controllable, From, Event, To) end

---User function for OnEnter "Firing" state.
---
------
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function ARTY:OnEnterFiring(Controllable, From, Event, To) end

---User function for OnEnter "Moving" state.
---
------
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function ARTY:OnEnterMoving(Controllable, From, Event, To) end

---User function for OnEnter "OutOfAmmo" state.
---
------
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function ARTY:OnEnterOutOfAmmo(Controllable, From, Event, To) end

---User function for OnEnter "Rearmed" state.
---
------
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function ARTY:OnEnterRearmed(Controllable, From, Event, To) end

---User function for OnEnter "Rearming" state.
---
------
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function ARTY:OnEnterRearming(Controllable, From, Event, To) end

---Event handler for event Dead.
---
------
---@param EventData EVENTDATA 
function ARTY:OnEventDead(EventData) end

---Eventhandler for shot event.
---
------
---@param EventData EVENTDATA 
function ARTY:OnEventShot(EventData) end

---Order ARTY group to open fire on a target.
---Triggers the FSM event "OpenFire".
---
------
---@param target table Array holding the target data.
function ARTY:OpenFire(target) end

---Delete ALL targets from current target list.
---
------
function ARTY:RemoveAllTargets() end

---Delete a move from move list.
---
------
---@param name string Name of the target.
function ARTY:RemoveMove(name) end

---Delete a target from target list.
---If the target is currently engaged, it is cancelled.
---
------
---@param name string Name of the target.
function ARTY:RemoveTarget(name) end

---Respawn ARTY group.
---
------
function ARTY:Respawn() end

---Set alias, i.e.
---the name the group will use when sending messages.
---
------
---@param alias string The alias for the group.
---@return NOTYPE #self
function ARTY:SetAlias(alias) end

---Set relocate after firing.
---Group will find a new location after each engagement. Default is off
---
------
---@param rmax? number (Optional) Max distance in meters, the group will move to relocate. Default is 800 m.
---@param rmin? number (Optional) Min distance in meters, the group will move to relocate. Default is 300 m.
---@return NOTYPE #self
function ARTY:SetAutoRelocateAfterEngagement(rmax, rmin) end

---Set automatic relocation of ARTY group if a target is assigned which is out of range.
---The unit will drive automatically towards or away from the target to be in max/min firing range.
---
------
---@param maxdistance? number (Optional) The maximum distance in km the group will travel to get within firing range. Default is 50 km. No automatic relocation is performed if targets are assigned which are further away.
---@param onroad? boolean (Optional) If true, ARTY group uses roads whenever possible. Default false, i.e. group will move in a straight line to the assigned coordinate.
---@return NOTYPE #self
function ARTY:SetAutoRelocateToFiringRange(maxdistance, onroad) end

---Turn debug mode off.
---This is the default setting.
---
------
---@return NOTYPE #self
function ARTY:SetDebugOFF() end

---Turn debug mode on.
---Information is printed to screen.
---
------
---@return NOTYPE #self
function ARTY:SetDebugON() end

---Set minimum and maximum detotation altitude for illumination shells.
---A value between min/max is selected randomly.
---The illumination bomb will burn for 300 seconds (5 minutes). Assuming a descent rate of ~3 m/s the "optimal" altitude would be 900 m.
---
------
---@param minalt? number (Optional) Minium altitude in meters. Default 500 m.
---@param maxalt? number (Optional) Maximum altitude in meters. Default 1000 m.
---@return NOTYPE #self
function ARTY:SetIlluminationMinMaxAlt(minalt, maxalt) end

---Set number of illumination shells available to the group.
---Note that it can be max the number of normal shells. Also if all normal shells are empty, firing illumination shells is also not possible any more until group gets rearmed.
---
------
---@param n number Number of illumination shells for the whole group.
---@param power? number (Optional) Power of illumination warhead in mega candela. Default 1.0 mcd.
---@return NOTYPE #self
function ARTY:SetIlluminationShells(n, power) end

---Enable assigning targets and moves by placing markers on the F10 map.
---
------
---@param key? number (Optional) Authorization key. Only players knowing this key can assign targets. Default is no authorization required.
---@param readonly? boolean (Optional) Marks are readonly and cannot be removed by players. This also means that targets cannot be cancelled by removing the mark. Default false.
---@return NOTYPE #self
function ARTY:SetMarkAssignmentsOn(key, readonly) end

---Disable assigning targets by placing markers on the F10 map.
---
------
---@return NOTYPE #self
function ARTY:SetMarkTargetsOff() end

---Set maximum firing range.
---Targets further away than this distance are not engaged.
---
------
---@param range number Max range in kilometers. Default is 1000 km.
---@return NOTYPE #self
function ARTY:SetMaxFiringRange(range) end

---Set minimum firing range.
---Targets closer than this distance are not engaged.
---
------
---@param range number Min range in kilometers. Default is 0.1 km.
---@return NOTYPE #self
function ARTY:SetMinFiringRange(range) end

---Define missile types that are counted to determine the ammo amount the ARTY group has.
---
------
---@param tableofnames table Table of rocket type names.
---@return NOTYPE #self
function ARTY:SetMissileTypes(tableofnames) end

---Define if ARTY group uses mainly roads to drive to the rearming place.
---
------
---@param onroad boolean If true, ARTY group uses mainly roads. If false, it drives directly to the rearming place.
---@return NOTYPE #self
function ARTY:SetRearmingArtyOnRoad(onroad) end

---Define the safe distance between ARTY group and rearming unit or rearming place at which rearming process is possible.
---
------
---@param distance number Safe distance in meters. Default is 100 m.
---@return NOTYPE #self
function ARTY:SetRearmingDistance(distance) end

---Assign a group, which is responsible for rearming the ARTY group.
---If the group is too far away from the ARTY group it will be guided towards the ARTY group.
---
------
---@param group GROUP Group that is supposed to rearm the ARTY group. For the blue coalition, this is often a unarmed M939 transport whilst for red an unarmed Ural-375 transport can be used.
---@return NOTYPE #self
function ARTY:SetRearmingGroup(group) end

---Define if rearming group uses mainly roads to drive to the ARTY group or rearming place.
---
------
---@param onroad boolean If true, rearming group uses mainly roads. If false, it drives directly to the ARTY group or rearming place.
---@return NOTYPE #self
function ARTY:SetRearmingGroupOnRoad(onroad) end

---Set the speed the rearming group moves at towards the ARTY group or the rearming place.
---
------
---@param speed number Speed in km/h.
---@return NOTYPE #self
function ARTY:SetRearmingGroupSpeed(speed) end

---Defines the rearming place of the ARTY group.
---If the place is too far away from the ARTY group it will be routed to the place.
---
------
---@param coord COORDINATE Coordinates of the rearming place.
---@return NOTYPE #self
function ARTY:SetRearmingPlace(coord) end

---Report messages of ARTY group turned off.
---Default is on.
---
------
---@return NOTYPE #self
function ARTY:SetReportOFF() end

---Report messages of ARTY group turned on.
---This is the default.
---
------
---@return NOTYPE #self
function ARTY:SetReportON() end

---Respawn group once all units are dead.
---
------
---@param delay? number (Optional) Delay before respawn in seconds.
---@return NOTYPE #self
function ARTY:SetRespawnOnDeath(delay) end

---Define rocket types that are counted to determine the ammo amount the ARTY group has.
---
------
---@param tableofnames table Table of rocket type names.
---@return NOTYPE #self
function ARTY:SetRocketTypes(tableofnames) end

---Define shell types that are counted to determine the ammo amount the ARTY group has.
---
------
---@param tableofnames table Table of shell type names.
---@return NOTYPE #self
function ARTY:SetShellTypes(tableofnames) end

---Set number of smoke shells available to the group.
---Note that it can be max the number of normal shells. Also if all normal shells are empty, firing smoke shells is also not possible any more until group gets rearmed.
---
------
---@param n number Number of smoke shells for the whole group.
---@param color? SMOKECOLOR (Optional) Color of the smoke. Default SMOKECOLOR.Red.
---@return NOTYPE #self
function ARTY:SetSmokeShells(n, color) end

---Set default speed the group is moving at if not specified otherwise.
---
------
---@param speed number Speed in km/h.
---@return NOTYPE #self
function ARTY:SetSpeed(speed) end

---Set time interval between status updates.
---During the status check, new events are triggered.
---
------
---@param interval number Time interval in seconds. Default 10 seconds.
---@return NOTYPE #self
function ARTY:SetStatusInterval(interval) end

---Set nuclear fires and extra demolition explosions.
---
------
---@param nfires? number (Optional) Number of big smoke and fire objects created in the demolition zone.
---@param demolitionrange? number (Optional) Demolition range in meters.
---@param range NOTYPE 
---@return NOTYPE #self
function ARTY:SetTacNukeFires(nfires, demolitionrange, range) end

---Set number of tactical nuclear warheads available to the group.
---Note that it can be max the number of normal shells. Also if all normal shells are empty, firing nuclear shells is also not possible any more until group gets rearmed.
---
------
---@param n number Number of warheads for the whole group.
---@return NOTYPE #self
function ARTY:SetTacNukeShells(n) end

---Set nuclear warhead explosion strength.
---
------
---@param strength number Explosion strength in kilo tons TNT. Default is 0.075 kt.
---@return NOTYPE #self
function ARTY:SetTacNukeWarhead(strength) end

---Set time interval for weapon tracking.
---
------
---@param interval number Time interval in seconds. Default 0.2 seconds.
---@return NOTYPE #self
function ARTY:SetTrackInterval(interval) end

---Set time how it is waited a unit the first shot event happens.
---If no shot is fired after this time, the task to fire is aborted and the target removed.
---
------
---@param waittime number Time in seconds. Default 300 seconds.
---@return NOTYPE #self
function ARTY:SetWaitForShotTime(waittime) end

---Function to start the ARTY FSM process.
---
------
function ARTY:Start() end

---Function to update the status of the ARTY group and tigger FSM events.
---Triggers the FSM event "Status".
---
------
function ARTY:Status() end

---Tell ARTY group it is out of ammo.
---Triggers the FSM event "Winchester".
---
------
function ARTY:Winchester() end

---Set task for attacking a group.
---
------
---@param target ARTY.Target Target data.
function ARTY:_AttackGroup(target) end

---Check the DB for properties of the specified artillery unit type.
---
------
---@param displayname NOTYPE 
---@return table #Properties of the requested artillery type. Returns nil if no matching DB entry could be found.
function ARTY:_CheckDB(displayname) end

---Check all moves and return the one which should be executed next.
---
------
---@return table #Move which is due.
function ARTY:_CheckMoves() end

---Check if a name is unique.
---If not, a new unique name can be created by adding a running index #01, #02, ...
---
------
---@param givennames table Table with entries of already given names. Must contain a .name item.
---@param name string Name to check if it already exists in givennames table.
---@param makeunique boolean If true, a new unique name is returned by appending the running index.
---@return string #Unique name, which is not already given for another target.
function ARTY:_CheckName(givennames, name, makeunique) end

---Check all normal (untimed) targets and return the target with the highest priority which has been engaged the fewest times.
---
------
---@return table #Target which is due to be attacked now or nil if no target could be found.
function ARTY:_CheckNormalTargets() end

---Check if group is (partly) out of ammo of a special weapon type.
---
------
---@param targets table Table of targets.
---@return NOTYPE #@boolean True if any target requests a weapon type that is empty.
function ARTY:_CheckOutOfAmmo(targets) end

---Check if ARTY group is rearmed, i.e.
---has its full amount of ammo.
---
------
---@return boolean #True if rearming is complete, false otherwise.
function ARTY:_CheckRearmed() end

---Check whether shooting started within a certain time (~5 min).
---If not, the current target is considered invalid and removed from the target list.
---
------
function ARTY:_CheckShootingStarted() end

---Check all targets whether they are in range.
---
------
function ARTY:_CheckTargetsInRange() end

---Check all timed targets and return the target which should be attacked next.
---
------
---@return table #Target which is due to be attacked now.
function ARTY:_CheckTimedTargets() end

---Check if a selected weapon type is available for this target, i.e.
---if the current amount of ammo of this weapon type is currently available.
---
------
---@param target boolean Target array data structure.
---@return number #Amount of shells, rockets or missiles available of the weapon type selected for the target.
function ARTY:_CheckWeaponTypeAvailable(target) end

---Check if a selected weapon type is in principle possible for this group.
---The current amount of ammo might be zero but the group still can be rearmed at a later point in time.
---
------
---@param target boolean Target array data structure.
---@return boolean #True if the group can carry this weapon type, false otherwise.
function ARTY:_CheckWeaponTypePossible(target) end

---Convert clock time from hours, minutes and seconds to seconds.
---
------
---@param clock string String of clock time. E.g., "06:12:35".
function ARTY:_ClockToSeconds(clock) end

---Print event-from-to string to DCS log file.
---
------
---@param BA string Before/after info.
---@param Event string Event.
---@param From string From state.
---@param To string To state.
function ARTY:_EventFromTo(BA, Event, From, To) end

---Set task for firing at a coordinate.
---
------
---@param coord COORDINATE Coordinates to fire upon.
---@param radius number Radius around coordinate.
---@param nshells number Number of shells to fire.
---@param weapontype number Type of weapon to use.
function ARTY:_FireAtCoord(coord, radius, nshells, weapontype) end

---Function called after impact of weapon.
---
------
---@param self ARTY ARTY object.
---@param target ARTY.Target Target of the weapon.
function ARTY._FuncImpact(weapon, self, target) end

---Function called during tracking of weapon.
---
------
---@param self ARTY ARTY object.
---@param target ARTY.Target Target of the weapon.
function ARTY._FuncTrack(weapon, self, target) end

--- Heading from point a to point b in degrees.
---
------
---@param a COORDINATE Coordinate.
---@param b COORDINATE Coordinate.
---@return number #angle Angle from a to b in degrees.
function ARTY:_GetHeading(a, b) end

---Get the marker ID from the assigned task name.
---
------
---@param name string Name of the assignment.
---@return string #Name of the ARTY group or nil
---@return number #ID of the marked target or nil.
---@return number #ID of the marked relocation move or nil
function ARTY:_GetMarkIDfromName(name) end

---Get the index of a move by its name.
---
------
---@param name string Name of move.
---@return number #Arrayindex of move.
function ARTY:_GetMoveIndexByName(name) end

---Get the index of a target by its name.
---
------
---@param name string Name of target.
---@return number #Arrayindex of target.
function ARTY:_GetTargetIndexByName(name) end

---Convert Latitude and Lontigude from DMS to DD.
---
------
---@param l1 string Latitude or longitude as string in the format DD:MM:SS N/S/W/E
---@param l2 string Latitude or longitude as string in the format DD:MM:SS N/S/W/E
---@return number #Latitude in decimal degree format.
---@return number #Longitude in decimal degree format.
function ARTY:_LLDMS2DD(l1, l2) end

---Create a name for a relocation move initiated by placing a marker.
---
------
---@param markerid number ID of the placed marker.
---@return string #Name of relocation move.
function ARTY:_MarkMoveName(markerid) end

---Request ammo via mark.
---
------
function ARTY:_MarkRequestAmmo() end

---Request Moves.
---
------
function ARTY:_MarkRequestMoves() end

---Request status via mark.
---
------
function ARTY:_MarkRequestStatus() end

---Request Targets.
---
------
function ARTY:_MarkRequestTargets() end

---Create a name for an engagement initiated by placing a marker.
---
------
---@param markerid number ID of the placed marker.
---@return string #Name of target engagement.
function ARTY:_MarkTargetName(markerid) end

---Extract engagement assignments and parameters from mark text.
---
------
---@param text string Marker text.
---@return boolean #If true, authentification successful.
function ARTY:_MarkerKeyAuthentification(text) end

---Extract engagement assignments and parameters from mark text.
---
------
---@param text string Marker text to be analyzed.
---@return table #Table with assignment parameters, e.g. number of shots, radius, time etc.
function ARTY:_Markertext(text) end

---Returns a name of a missile category.
---
------
---@param categorynumber number Number of missile category from weapon missile category enumerator. See https://wiki.hoggitworld.com/view/DCS_Class_Weapon
---@return string #Missile category name.
function ARTY:_MissileCategoryName(categorynumber) end

---Route group to a certain point.
---
------
---@param group GROUP Group to route.
---@param ToCoord COORDINATE Coordinate where we want to go.
---@param Speed? number (Optional) Speed in km/h. Default is 70% of max speed the group can do.
---@param OnRoad boolean If true, use (mainly) roads.
function ARTY:_Move(group, ToCoord, Speed, OnRoad) end

---Returns a formatted string with information about all move parameters.
---
------
---@param move table Move table item.
---@return string #Info string.
function ARTY:_MoveInfo(move) end

---Model a nuclear blast/destruction by creating fires and destroy scenery.
---
------
---@param _coord COORDINATE Coordinate of the impact point (center of the blast).
function ARTY:_NuclearBlast(_coord) end

---Function called when a F10 map mark was changed.
---This happens when a user enters text.
---
------
---@param Event table Event data.
function ARTY:_OnEventMarkChange(Event) end

---Function called when a F10 map mark was removed.
---
------
---@param Event table Event data.
function ARTY:_OnEventMarkRemove(Event) end

---Function called when group is passing a waypoint.
---
------
---@param arty ARTY ARTY object.
---@param i number Waypoint number that has been reached.
---@param final boolean True if it is the final waypoint.
function ARTY._PassingWaypoint(group, arty, i, final) end

---Relocate to another position, e.g.
---after an engagement to avoid couter strikes.
---
------
function ARTY:_Relocate() end

---Convert time in seconds to hours, minutes and seconds.
---
------
---@param seconds number Time in seconds.
---@return string #Time in format Hours:minutes:seconds.
function ARTY:_SecondsToClock(seconds) end

---Sort array with respect to time.
---Array elements must have a .time entry.
---
------
---@param queue table Array to sort. Should have elemnt .time.
function ARTY:_SortQueueTime(queue) end

---Sort targets with respect to priority and number of times it was already engaged.
---
------
function ARTY:_SortTargetQueuePrio() end

---After "Start" event.
---Initialized ROE and alarm state. Starts the event handler.
---
------
---@param display? boolean (Optional) If true, send message to coalition. Default false.
function ARTY:_StatusReport(display) end

---Check if target is in range.
---
------
---@param target table Target table.
---@param message? boolean (Optional) If true, send a message to the coalition if the target is not in range. Default is no message is send.
---@return boolean #True if target is in range, false otherwise.
---@return boolean #True if ARTY group is too far away from the target, i.e. distance > max firing range.
---@return boolean #True if ARTY group is too close to the target, i.e. distance < min finring range.
---@return boolean #True if target should be removed since ARTY group is immobile and not cargo.
function ARTY:_TargetInRange(target, message) end

---Returns the target parameters as formatted string.
---
------
---@param target ARTY.Target The target data.
---@return string #name, prio, radius, nshells, engaged, maxengage, time, weapontype
function ARTY:_TargetInfo(target) end

---Find a random coordinate in the vicinity of another coordinate.
---
------
---@param coord COORDINATE Center coordinate.
---@param rmin? number (Optional) Minimum distance in meters from center coordinate. Default 20 m.
---@param rmax? number (Optional) Maximum distance in meters from center coordinate. Default 80 m.
---@return COORDINATE #Random coordinate in a certain distance from center coordinate.
function ARTY:_VicinityCoord(coord, rmin, rmax) end

---Get the weapon type name, which should be used to attack the target.
---
------
---@param tnumber number Number of weapon type ARTY.WeaponType.XXX
---@return number #tnumber of weapon type.
function ARTY:_WeaponTypeName(tnumber) end

---Tell ARTY group it has arrived at its destination after a delay.
---Triggers the FSM event "Arrived".
---
------
---@param delay number Delay in seconds.
function ARTY:__Arrived(delay) end

---Order ARTY group to cease firing on a target after a delay.
---Triggers the FSM event "CeaseFire".
---
------
---@param delay number Delay in seconds.
---@param target table Array holding the target data.
function ARTY:__CeaseFire(delay, target) end

---Tell ARTY group it is combat ready after a delay.
---Triggers the FSM event "CombatReady".
---
------
---@param delay number Delay in seconds.
function ARTY:__CombatReady(delay) end

---Function called when a unit of the ARTY group died after a delay.
---Triggers the FSM event "Dead".
---
------
---@param Delay number in seconds.
---@param unitname string Name of the unit that died.
function ARTY:__Dead(Delay, unitname) end

---Order ARTY group to move to another location after a delay.
---Triggers the FSM event "Move".
---
------
---@param delay number Delay in seconds.
---@param move table Array holding the relocation move data.
function ARTY:__Move(delay, move) end

---Add a new relocation for the ARTY group after a delay.
---Triggers the FSM event "NewMove".
---
------
---@param delay number Delay in seconds.
---@param move table Array holding the relocation move data.
function ARTY:__NewMove(delay, move) end

---Add a new target for the ARTY group with a delay.
---Triggers the FSM event "NewTarget".
---
------
---@param delay number Delay in seconds.
---@param target table Array holding the target data.
function ARTY:__NewTarget(delay, target) end

---Order ARTY group to open fire on a target with a delay.
---Triggers the FSM event "Move".
---
------
---@param delay number Delay in seconds.
---@param target table Array holding the target data.
function ARTY:__OpenFire(delay, target) end

---Respawn ARTY group after a delay.
---
------
---@param delay number Delay in seconds.
function ARTY:__Respawn(delay) end

---Function to start the ARTY FSM process after a delay.
---
------
---@param Delay number before start in seconds.
function ARTY:__Start(Delay) end

---Function to update the status of the ARTY group and tigger FSM events after a delay.
---Triggers the FSM event "Status".
---
------
---@param Delay number in seconds.
function ARTY:__Status(Delay) end

---Tell ARTY group it is out of ammo after a delay.
---Triggers the FSM event "Winchester".
---
------
---@param delay number Delay in seconds.
function ARTY:__Winchester(delay) end

---Split string.
---C.f. http://stackoverflow.com/questions/1426954/split-string-in-lua
---
------
---@param str string Sting to split.
---@param sep string Speparator for split.
---@return table #Split text.
function ARTY:_split(str, sep) end

---After "Start" event.
---Initialized ROE and alarm state. Starts the event handler.
---
------
---@param Event table 
---@private
function ARTY:onEvent(Event) end

---After "Arrived" event.
---Group has reached its destination.
---
------
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function ARTY:onafterArrived(Controllable, From, Event, To) end

---After "CeaseFire" event.
---Clears task of the group and removes the target if max engagement was reached.
---
------
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param target table Array holding the target info.
---@private
function ARTY:onafterCeaseFire(Controllable, From, Event, To, target) end

---After "Dead" event, when a unit has died.
---When all units of a group are dead trigger "Stop" event.
---
------
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Unitname string Name of the unit that died.
---@private
function ARTY:onafterDead(Controllable, From, Event, To, Unitname) end

---After "Move" event.
---Route group to given coordinate.
---
------
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param move table Table containing the move parameters.
---@private
function ARTY:onafterMove(Controllable, From, Event, To, move) end

---After "NewMove" event.
---
------
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param move table Array holding the move parameters.
---@private
function ARTY:onafterNewMove(Controllable, From, Event, To, move) end

---After "NewTarget" event.
---
------
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param target table Array holding the target parameters.
---@private
function ARTY:onafterNewTarget(Controllable, From, Event, To, target) end

---After "OpenFire" event.
---Sets the current target and starts the fire at point task.
---
------
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param target ARTY.Target Array holding the target info.
---@private
function ARTY:onafterOpenFire(Controllable, From, Event, To, target) end

---After "Rearm" event.
---Send message if reporting is on. Route rearming unit to ARTY group.
---
------
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function ARTY:onafterRearm(Controllable, From, Event, To) end

---After "Rearmed" event.
---Send ARTY and rearming group back to their inital positions.
---
------
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function ARTY:onafterRearmed(Controllable, From, Event, To) end

---After "Dead" event, when a unit has died.
---When all units of a group are dead trigger "Stop" event.
---
------
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function ARTY:onafterRespawn(Controllable, From, Event, To) end

---After "Start" event.
---Initialized ROE and alarm state. Starts the event handler.
---
------
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function ARTY:onafterStart(Controllable, From, Event, To) end

---After "Status" event.
---Report status of group.
---
------
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function ARTY:onafterStatus(Controllable, From, Event, To) end

---After "Stop" event.
---Unhandle events and cease fire on current target.
---
------
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function ARTY:onafterStop(Controllable, From, Event, To) end

---After "UnLoaded" event.
---Group is combat ready again.
---
------
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@return boolean #If true, proceed to onafterLoaded.
---@private
function ARTY:onafterUnLoaded(Controllable, From, Event, To) end

---After "Winchester" event.
---Group is out of ammo. Trigger "Rearm" event.
---
------
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function ARTY:onafterWinchester(Controllable, From, Event, To) end

---Before "Loaded" event.
---Checks if group is currently firing and removes the target by calling CeaseFire.
---
------
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@return boolean #If true, proceed to onafterLoaded.
---@private
function ARTY:onbeforeLoaded(Controllable, From, Event, To) end

---Before "Move" event.
---Check if a unit to rearm the ARTY group has been defined.
---
------
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param move table Table containing the move parameters.
---@param ToCoord COORDINATE Coordinate to which the ARTY group should move.
---@param OnRoad boolean If true group should move on road mainly.
---@return boolean #If true, proceed to onafterMove.
---@private
function ARTY:onbeforeMove(Controllable, From, Event, To, move, ToCoord, OnRoad) end

---Before "OpenFire" event.
---Checks if group already has a target. Checks for valid min/max range and removes the target if necessary.
---
------
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param target table Array holding the target info.
---@return boolean #If true, proceed to onafterOpenfire.
---@private
function ARTY:onbeforeOpenFire(Controllable, From, Event, To, target) end

---Before "Rearm" event.
---Check if a unit to rearm the ARTY group has been defined.
---
------
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@return boolean #If true, proceed to onafterRearm.
---@private
function ARTY:onbeforeRearm(Controllable, From, Event, To) end

---Enter "CombatReady" state.
---Route the group back if necessary.
---
------
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function ARTY:onenterCombatReady(Controllable, From, Event, To) end


---Target.
---@class ARTY.Target 
---@field Tassigned number Abs. mission time when target was assigned.
---@field private attackgroup boolean If true, use task attack group rather than fire at point for engagement.
---@field private coord COORDINATE Target coordinates.
---@field private engaged number Number of times this target was engaged.
---@field private maxengage number Max number of times, the target will be engaged.
---@field private name string Name of target.
---@field private nshells number Number of shells (or other weapon types) fired upon target.
---@field private prio number Priority of target.
---@field private radius number Shelling radius in meters.
---@field private time number Abs. mission time in seconds, when the target is scheduled to be attacked.
---@field private underfire boolean If true, target is currently under fire.
---@field private weapontype number Type of weapon used for engagement. See #ARTY.WeaponType.
ARTY.Target = {}


---Weapong type ID.
---See [here](http://wiki.hoggit.us/view/DCS_enum_weapon_flag).
---@class ARTY.WeaponType 
---@field Auto number Automatic selection of weapon type.
---@field Cannon number Cannons using conventional shells.
---@field CruiseMissile number Cruise missiles.
---@field IlluminationShells number Illumination shells (simulated).
---@field Rockets number Unguided rockets.
---@field SmokeShells number Smoke shells (simulated).
---@field TacticalNukes number Tactical nuclear shells (simulated).
ARTY.WeaponType = {}


---Database of common artillery unit properties.
---Table key is the "type name" and table value is and `ARTY.dbitem`.
---@class ARTY.db 
---@field 2B11 mortar table 
---@field Grad-URAL table 
---@field HL_B8M1 table 
---@field L118_Unit table 
---@field LeFH_18-40-105 table 
---@field M-109 table 
---@field M12_GMC table 
---@field M2A1-105 table 
---@field MLRS table 
---@field PLZ05 table 
---@field Pak40 table 
---@field SAU 2-C9 table 
---@field SAU Akatsia table 
---@field SAU Gvozdika table 
---@field SAU Msta table 
---@field Smerch table 
---@field Smerch_HE table 
---@field SpGH_Dana table 
---@field T155_Firtina table 
---@field Uragan_BM-27 table 
---@field Wespe124 table 
---@field private tt_B8M1 table 
ARTY.db = {}


---Database of common artillery unit properties.
---@class ARTY.dbitem 
---@field private displayname string Name displayed in ME.
---@field private maxrange number Maximum firing range in meters.
---@field private minrange number Minimum firing range in meters.
---@field private reloadtime number Reload time in seconds.
ARTY.dbitem = {}



