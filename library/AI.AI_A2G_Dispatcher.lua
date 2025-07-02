---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/AI_Air_To_Ground_Dispatching.JPG" width="100%">
---
---**AI** - Create an automated A2G defense system with reconnaissance units, coordinating SEAD, BAI and CAS operations.
---
---===
---
---Features:
---
---   * Setup quickly an A2G defense system for a coalition.
---   * Setup multiple defense zones to defend specific coordinates in your battlefield.
---   * Setup (SEAD) Suppression of Air Defense squadrons, to gain control in the air of enemy grounds.
---   * Setup (BAI) Battleground Air Interdiction squadrons to attack remote enemy ground units and targets.
---   * Setup (CAS) Controlled Air Support squadrons, to attack close by enemy ground units near friendly installations.
---   * Define and use a detection network controlled by recce.
---   * Define A2G defense squadrons at airbases, FARPs and carriers.
---   * Enable airbases for A2G defenses.
---   * Add different planes and helicopter templates to squadrons.
---   * Assign squadrons to execute a specific engagement type depending on threat level of the detected ground enemy unit composition.
---   * Add multiple squadrons to different airbases, FARPs or carriers.
---   * Define different ranges to engage upon.
---   * Establish an automatic in air refuel process for planes using refuel tankers.
---   * Setup default settings for all squadrons and A2G defenses.
---   * Setup specific settings for specific squadrons.
---
---===
---
---## Missions:
---
---[AID-A2G - AI A2G Dispatching](https://github.com/FlightControl-Master/MOOSE_MISSIONS/tree/master/AI/AI_A2G_Dispatcher)
---
---===
---
---## YouTube Channel:
---
---[DCS WORLD - MOOSE - A2G DISPATCHER - Build an automatic A2G Defense System - Introduction](https://www.youtube.com/watch?v=zwSxWRAGVH8)
---
---===
---
---# QUICK START GUIDE
---
---![Banner Image](..\Images\deprecated.png)
---
---The following class is available to model an A2G defense system.
---
---AI_A2G_DISPATCHER is the main A2G defense class that models the A2G defense system.
---
---Before you start using the AI_A2G_DISPATCHER, ask yourself the following questions:
---
---
---## 1. Which coalition am I modeling an A2G defense system for? Blue or red?
---
---One AI_A2G_DISPATCHER object can create a defense system for **one coalition**, which is blue or red.
---If you want to create a **mutual defense system**, for both blue and red, then you need to create **two** AI_A2G_DISPATCHER **objects**,
---each governing their defense system for one coalition.
---
---     
---## 2. Which type of detection will I setup? Grouping based per AREA, per TYPE or per UNIT? (Later others will follow).
---
---The MOOSE framework leverages the Functional.Detection classes to perform the reconnaissance, detecting enemy units
---and reporting them to the head quarters.
---Several types of Functional.Detection classes exist, and the most common characteristics of these classes is that they:
---
---   * Perform detections from multiple recce as one co-operating entity.
---   * Communicate with a Tasking.CommandCenter, which consolidates each detection.
---   * Groups detections based on a method (per area, per type or per unit).
---   * Communicates detections.
---
---
---## 3. Which recce units can be used as part of the detection system? Only ground based, or also airborne?
---
---Depending on the type of mission you want to achieve, different types of units can be engaged to perform ground enemy targets reconnaissance.
---Ground recce (FAC) are very useful units to determine the position of enemy ground targets when they spread out over the battlefield at strategic positions.
---Using their varying detection technology, and especially those ground units which have spotting technology, can be extremely effective at
---detecting targets at great range. The terrain elevation characteristics are a big tool in making ground recce to be more effective.
---Unfortunately, they lack sometimes the visibility to detect targets at greater range, or when scenery is preventing line of sight.
---If you succeed to position recce at higher level terrain providing a broad and far overview of the lower terrain in the distance, then
---the recce will be very effective at detecting approaching enemy targets. Therefore, always use the terrain very carefully!
---
---Airborne recce (AFAC) are also very effective. The are capable of patrolling at a functional detection altitude,
---having an overview of the whole battlefield. However, airborne recce can be vulnerable to air to ground attacks,
---so you need air superiority to make them effective. 
---Airborne recce will also have varying ground detection technology, which plays a big role in the effectiveness of the reconnaissance.
---Certain helicopter or plane types have ground searching radars or advanced ground scanning technology, and are very effective
---compared to air units having only visual detection capabilities.
---For example, for the red coalition, the Mi-28N and the Su-34; and for the blue side, the reaper, are such effective airborne recce units.
---
---Typically, don't want these recce units to engage with the enemy, you want to keep them at position. Therefore, it is a good practice
---to set the ROE for these recce to hold weapons, and make them invisible from the enemy.
---
---It is not possible to perform a recce function as a player (unit).
---
---
---## 4. How do the defenses decide **when and where to engage** on approaching enemy units?
---
---The A2G dispatcher needs you to setup (various) defense coordinates, which are strategic positions in the battle field to be defended.
---Any ground based enemy approaching within the proximity of such a defense point, may trigger for a defensive action by friendly air units.
---
---There are 2 important parameters that play a role in the defensive decision making: defensiveness and reactivity.
---
---The A2G dispatcher provides various parameters to setup the **defensiveness**, 
---which models the decision **when** a defender will engage with the approaching enemy.
---Defensiveness is calculated by a probability distribution model when to trigger a defense action, 
---depending on the distance of the enemy unit from the defense coordinates, and a **defensiveness factor**. 
---
---The other parameter considered for defensive action is **where the enemy is located**, thus the distance from a defense coordinate, 
---which we call the **reactive distance**. By default, the reactive distance is set to 60km, but can be changed by the mission designer
---using the available method explained further below.
---The combination of the defensiveness and reactivity results in a model that, the closer the attacker is to the defense point, 
---the higher the probability will be that a defense action will be launched!
---
---
---## 5. Are defense coordinates and defense reactivity the only parameters?
---
---No, depending on the target type, and the threat level of the target, the probability of defense will be higher.
---In other words, when a SAM-10 radar emitter is detected, its probability for defense will be much higher than when a BMP-1 vehicle is
---detected, even when both enemies are at the same distance from a defense coordinate.
---This will ensure optimal defenses, SEAD tasks will be launched much more quicker against engaging radar emitters, to ensure air superiority.
---Approaching main battle tanks will be engaged much faster, than a group of approaching trucks.
---
---
---## 6. Which Squadrons will I create and which name will I give each Squadron?
---
---The A2G defense system works with **Squadrons**. Each Squadron must be given a unique name, that forms the **key** to the squadron.
---Several options and activities can be set per Squadron. A free format name can be given, but always ensure that the name is meaningful
---for your mission, and remember that squadron names are used for communication to the players of your mission.
---
---There are mainly 3 types of defenses: **SEAD**, **BAI**, and **CAS**.
---
---Suppression of Air Defenses (SEAD) are effective against radar emitters.
---Battleground Air Interdiction (BAI) tasks are launched when there are no friendlies around.
---Close Air Support (CAS) is launched when the enemy is close near friendly units.
---
---Depending on the defense type, different payloads will be needed. See further points on squadron definition.
---
---
---## 7. Where will the Squadrons be located? On Airbases? On Carriers? On FARPs?
---
---Squadrons are placed at the **home base** on an **airfield**, **carrier** or **FARP**.
---Carefully plan where each Squadron will be located as part of the defense system required for mission effective defenses.
---If the home base of the squadron is too far from assumed enemy positions, then the defenses will be too late.
---The home bases must be **behind** enemy lines, you want to prevent your home bases to be engaged by enemies!
---Depending on the units applied for defenses, the home base can be further or closer to the enemies.
---Any airbase, FARP, or carrier can act as the launching platform for A2G defenses.
---Carefully plan which airbases will take part in the coalition. Color each airbase **in the color of the coalition**, using the mission editor,
---or your air units will not return for landing at the airbase!
---
---
---## 8. Which helicopter or plane models will I assign for each Squadron? Do I need one plane model or more plane models per squadron?
---
---Per Squadron, one or multiple helicopter or plane models can be allocated as **Templates**.
---These are late activated groups with one airplane or helicopter that start with a specific name, called the **template prefix**.
---The A2G defense system will select from the given templates a random template to spawn a new plane (group).
---
---A squadron will perform specific task types (SEAD, BAI or CAS). So, squadrons will require specific templates for the
---task types it will perform. A squadron executing SEAD defenses, will require a payload with long range anti-radar seeking missiles.
--- 
--- 
---## 9. Which payloads, skills and skins will these plane models have?
---
---Per Squadron, even if you have one plane model, you can still allocate multiple templates of one plane model, 
---each having different payloads, skills and skins. 
---The A2G defense system will select from the given templates a random template to spawn a new plane (group).
---
---
---## 10. How do squadrons engage in a defensive action?
---
---There are two ways how squadrons engage and execute your A2G defenses. 
---Squadrons can start the defense directly from the airbase, FARP or carrier. When a squadron launches a defensive group, that group
---will start directly from the airbase. The other way is to launch early on in the mission a patrolling mechanism.
---Squadrons will launch air units to patrol in specific zone(s), so that when ground enemy targets are detected, that the airborne
---A2G defenses can come immediately into action.
---
---
---## 11. For each Squadron doing a patrol, which zone types will I create?
---
---Per zone, evaluate whether you want:
---
---   * simple trigger zones
---   * polygon zones
---   * moving zones
---
---Depending on the type of zone selected, a different Core.Zone object needs to be created from a ZONE_ class.
---
---
---## 12. Are moving defense coordinates possible?
---
---Yes, different COORDINATE types are possible to be used.
---The COORDINATE_UNIT will help you to specify a defense coordinate that is attached to a moving unit.
---
---
---## 13. How many defense coordinates do I need to create?
---
---It depends, but the idea is to define only the necessary defense points that drive your mission.
---If you define too many defense coordinates, the performance of your mission may decrease. For each defined defense coordinate,
---all the possible enemies are evaluated. Note that each defense coordinate has a reach depending on the size of the associated defense radius.
---The default defense radius is about 60km. Depending on the defense reactivity, defenses will be launched when the enemy is at a
---closer distance from the defense coordinate than the defense radius.
---
---
---## 14. For each Squadron doing patrols, what are the time intervals and patrol amounts to be performed?
---
---For each patrol:
---
---   * **How many** patrols you want to have airborne at the same time?
---   * **How frequent** you want the defense mechanism to check whether to start a new patrol?
---
---Other considerations:
---
---   * **How far** is the patrol area from the engagement "hot zone". You want to ensure that the enemy is reached on time!
---   * **How safe** is the patrol area taking into account air superiority. Is it well defended, are there nearby A2A bases?
---
---
---## 15. For each Squadron, which takeoff method will I use?
---
---For each Squadron, evaluate which takeoff method will be used:
---
---   * Straight from the air
---   * From the runway
---   * From a parking spot with running engines
---   * From a parking spot with cold engines
---
---**The default takeoff method is straight in the air.**
---This takeoff method is the most useful if you want to avoid airplane clutter at airbases, but it is the least realistic one.
---
---
---## 16. For each Squadron, which landing method will I use?
---
---For each Squadron, evaluate which landing method will be used:
---
---   * Despawn near the airbase when returning
---   * Despawn after landing on the runway
---   * Despawn after engine shutdown after landing
---   
---**The default landing method is to despawn when near the airbase when returning.**
---This landing method is the most useful if you want to avoid aircraft clutter at airbases, but it is the least realistic one.
---
---
---## 19. For each Squadron, which **defense overhead** will I use?
---
---For each Squadron, depending on the helicopter or airplane type (modern, old) and payload, which overhead is required to provide any defense?
---
---In other words, if **X** enemy ground units are detected, how many **Y** defense helicopters or airplanes need to engage (per squadron)?
---The **Y** is dependent on the type of aircraft (era), payload, fuel levels, skills etc.
---But the most important factor is the payload, which is the amount of A2G weapons the defense can carry to attack the enemy ground units.
---For example, a Ka-50 can carry 16 Vikhrs, this means that it potentially can destroy at least 8 ground units without a reload of ammunition.
---That means, that one defender can destroy more enemy ground units.
---Thus, the overhead is a **factor** that will calculate dynamically how many **Y** defenses will be required based on **X** attackers detected.
---
---**The default overhead is 1. A smaller value than 1, like 0.25 will decrease the overhead to a 1 / 4 ratio, meaning, 
---one defender for each 4 detected ground enemy units. **
---
---
---## 19. For each Squadron, which grouping will I use?
---
---When multiple targets are detected, how will defenses be grouped when multiple defense air units are spawned for multiple enemy ground units?
---Per one, two, three, four?
---
---**The default grouping is 1. That means, that each spawned defender will act individually.**
---But you can specify a number between 1 and 4, so that the defenders will act as a group.
---
---# Developer Note
---
---Note while this class still works, it is no longer supported as the original author stopped active development of MOOSE
---Therefore, this class is considered to be deprecated
---
---===
---
---### Author: **FlightControl** rework of GCICAP + introduction of new concepts (squadrons).
---Create an automated A2G defense system based on a detection network of reconnaissance vehicles and air units, coordinating SEAD, BAI and CAS operations.
---
---===
---
---When your mission is in the need to take control of the AI to automate and setup a process of air to ground defenses, this is the module you need.
---The defense system work through the definition of defense coordinates, which are points in your friendly area within the battle field, that your mission need to have defended.
---Multiple defense coordinates can be setup. Defense coordinates can be strategic or tactical positions or references to strategic units or scenery.
---The A2G dispatcher will evaluate every x seconds the tactical situation around each defense coordinate. When a defense coordinate
---is under threat, it will communicate through the command center that defensive actions need to be taken and will launch groups of air units for defense.
---The level of threat to the defense coordinate varies upon the strength and types of the enemy units, the distance to the defense point, and the defensiveness parameters.
---Defensive actions are taken through probability, but the closer and the more threat the enemy poses to the defense coordinate, the faster it will be attacked by friendly A2G units.
---
---Please study carefully the underlying explanations how to setup and use this module, as it has many features.
---It also requires a little study to ensure that you get a good understanding of the defense mechanisms, to ensure a strong
---defense for your missions.
---
---===
---
---# USAGE GUIDE
---
---
---## 1. AI\_A2G\_DISPATCHER constructor:
---
---
---The #AI_A2G_DISPATCHER.New() method creates a new AI_A2G_DISPATCHER instance.
---
---
---### 1.1. Define the **reconnaissance network**:
---
---As part of the AI_A2G_DISPATCHER :New() constructor, a reconnaissance network must be given as the first parameter.
---A reconnaissance network is provided by passing a Functional.Detection object.
---The most effective reconnaissance for the A2G dispatcher would be to use the Functional.Detection#DETECTION_AREAS object.
---
---A reconnaissance network, is used to detect enemy ground targets, 
---potentially group them into areas, and to understand the position, level of threat of the enemy.
---
---As explained in the introduction, depending on the type of mission you want to achieve, different types of units can be applied to detect ground enemy targets.
---Ground based units are very useful to act as a reconnaissance, but they lack sometimes the visibility to detect targets at greater range.
---Recce are very useful to acquire the position of enemy ground targets when spread out over the battlefield at strategic positions.
---Ground units also have varying detectors, and especially the ground units which have laser guiding missiles can be extremely effective at
---detecting targets at great range. The terrain elevation characteristics are a big tool in making ground recce to be more effective.
---If you succeed to position recce at higher level terrain providing a broad and far overview of the lower terrain in the distance, then
---the recce will be very effective at detecting approaching enemy targets. Therefore, always use the terrain very carefully!
---
---Beside ground level units to use for reconnaissance, air units are also very effective. The are capable of patrolling at great speed
---covering a large terrain. However, airborne recce can be vulnerable to air to ground attacks, and you need air superiority to make then
---effective. Also the instruments available at the air units play a big role in the effectiveness of the reconnaissance.
---Air units which have ground detection capabilities will be much more effective than air units with only visual detection capabilities.
---For the red coalition, the Mi-28N and for the blue side, the reaper are such effective reconnaissance airborne units.
---
---Reconnaissance networks are **dynamically constructed**, that is, they form part of the Functional.Detection instance that is given as the first parameter to the A2G dispatcher.
---By defining in a **smart way the names or name prefixes of the reconnaissance groups**, these groups will be **automatically added or removed** to or from the reconnaissance network, 
---when these groups are spawned in or destroyed during the ongoing battle. 
---By spawning in dynamically additional recce, you can ensure that there is sufficient reconnaissance coverage so the defense mechanism is continuously
---alerted of new enemy ground targets.
---
---The following is an example defense of a new reconnaissance network using a Functional.Detection#DETECTION_AREAS object.
---
---       -- Define a SET_GROUP object that builds a collection of groups that define the recce network.
---       -- Here we build the network with all the groups that have a name starting with CCCP Recce.
---       DetectionSetGroup = SET_GROUP:New() -- Define a set of group objects, called DetectionSetGroup.
---
---       DetectionSetGroup:FilterPrefixes( { "CCCP Recce" } ) -- The DetectionSetGroup will search for groups that start with the name "CCCP Recce".
---
---       -- This command will start the dynamic filtering, so when groups spawn in or are destroyed,
---       -- which have a group name starting with "CCCP Recce", then these will be automatically added or removed from the set.
---       DetectionSetGroup:FilterStart()
---
---       -- This command defines the reconnaissance network.
---       -- It will group any detected ground enemy targets within a radius of 1km.
---       -- It uses the DetectionSetGroup, which defines the set of reconnaissance groups to detect for enemy ground targets.
---       Detection = DETECTION_AREAS:New( DetectionSetGroup, 1000 )
---
---       -- Setup the A2G dispatcher, and initialize it.
---       A2GDispatcher = AI_A2G_DISPATCHER:New( Detection )
---
---
---The above example creates a SET_GROUP instance, and stores this in the variable (object) **DetectionSetGroup**.
---**DetectionSetGroup** is then being configured to filter all active groups with a group name starting with `"CCCP Recce"` to be included in the set.
---**DetectionSetGroup** is then calling `FilterStart()`, which is starting the dynamic filtering or inclusion of these groups.
---Note that any destroy or new spawn of a group having a name, starting with the above prefix, will be removed or added to the set.
---
---Then a new detection object is created from the class `DETECTION_AREAS`. A grouping radius of 1000 meters (1km) is chosen.
---
---The `Detection` object is then passed to the #AI_A2G_DISPATCHER.New() method to indicate the reconnaissance network
---configuration and setup the A2G defense detection mechanism.
---
---
---### 1.2. Setup the A2G dispatcher for both a red and blue coalition.
---
---Following the above described procedure, you'll need to create for each coalition an separate detection network, and a separate A2G dispatcher.
---Ensure that while doing so, that you name the objects differently both for red and blue coalition.
---
---For example like this for the red coalition:
---
---       DetectionRed = DETECTION_AREAS:New( DetectionSetGroupRed, 1000 )
---       A2GDispatcherRed = AI_A2G_DISPATCHER:New( DetectionRed )
---       
---And for the blue coalition:
---
---       DetectionBlue = DETECTION_AREAS:New( DetectionSetGroupBlue, 1000 )
---       A2GDispatcherBlue = AI_A2G_DISPATCHER:New( DetectionBlue )
---
---Note: Also the SET_GROUP objects should be created for each coalition separately, containing each red and blue recce respectively!
---
---
---### 1.3. Define the enemy ground target **grouping radius**, in case you use DETECTION_AREAS:
---
---The target grouping radius is a property of the DETECTION_AREAS class, that was passed to the AI_A2G_DISPATCHER:New() method
---but can be changed. The grouping radius should not be too small, but also depends on the types of ground forces and the way you want your mission to evolve.
---A large radius will mean large groups of enemy ground targets, while making smaller groups will result in a more fragmented defense system.
---Typically I suggest a grouping radius of 1km. This is the right balance to create efficient defenses.
---
---Note that detected targets are constantly re-grouped, that is, when certain detected enemy ground units are moving further than the group radius
---then these units will become a separate area being detected. This may result in additional defenses being started by the dispatcher,
---so don't make this value too small! Again, about 1km, or 1000 meters, is recommended.
---
---
---## 2. Setup (a) **Defense Coordinate(s)**.
---
---As explained above, defense coordinates are the center of your defense operations.
---The more threat to the defense coordinate, the higher it is likely a defensive action will be launched.
---
---Find below an example how to add defense coordinates:
---
---       -- Add defense coordinates.
---       A2GDispatcher:AddDefenseCoordinate( "HQ", GROUP:FindByName( "HQ" ):GetCoordinate() )
---
---In this example, the coordinate of a group called `"HQ"` is retrieved, using `:GetCoordinate()`
---This returns a COORDINATE object, pointing to the first unit within the GROUP object.
---
---The method #AI_A2G_DISPATCHER.AddDefenseCoordinate() adds a new defense coordinate to the `A2GDispatcher` object.
---The first parameter is the key of the defense coordinate, the second the coordinate itself.
---
---Later, a COORDINATE_UNIT will be added to the framework, which can be used to assign "moving" coordinates to an A2G dispatcher.
---
---**REMEMBER!**
---
---  - **Defense coordinates are the center of the A2G dispatcher defense system!**
---  - **You can define more defense coordinates to defend a larger area.**
---  - **Detected enemy ground targets are not immediately engaged, but are engaged with a reactivity or probability calculation!**
---
---But, there is more to it ...
---
---
---### 2.1. The **Defense Radius**.
---
---The defense radius defines the maximum radius that a defense will be initiated around each defense coordinate.
---So even when there are targets further away than the defense radius, then these targets won't be engaged upon.
---By default, the defense radius is set to 100km (100.000 meters), but can be changed using the #AI_A2G_DISPATCHER.SetDefenseRadius() method.
---Note that the defense radius influences the defense reactivity also! The larger the defense radius, the more reactive the defenses will be.
---
---For example:
---
---       A2GDispatcher:SetDefenseRadius( 30000 )
---
---This defines an A2G dispatcher which will engage on enemy ground targets within 30km radius around the defense coordinate.
---Note that the defense radius **applies to all defense coordinates** defined within the A2G dispatcher.
---
---
---### 2.2. The **Defense Reactivity**.
---
---There are three levels that can be configured to tweak the defense reactivity. As explained above, the threat to a defense coordinate is
---also determined by the distance of the enemy ground target to the defense coordinate.
---If you want to have a **low** defense reactivity, that is, the probability that an A2G defense will engage to the enemy ground target, then
---use the #AI_A2G_DISPATCHER.SetDefenseReactivityLow() method. For medium and high reactivity, use the methods
---#AI_A2G_DISPATCHER.SetDefenseReactivityMedium() and #AI_A2G_DISPATCHER.SetDefenseReactivityHigh() respectively.
---
---Note that the reactivity of defenses is always in relation to the Defense Radius! the shorter the distance,
---the less reactive the defenses will be in terms of distance to enemy ground targets!
---
---For example:
---
---       A2GDispatcher:SetDefenseReactivityHigh()
---       
---This defines an A2G dispatcher with high defense reactivity.
---
---
---## 3. **Squadrons**.
---
---The A2G dispatcher works with **Squadrons**, that need to be defined using the different methods available.
---
---Use the method #AI_A2G_DISPATCHER.SetSquadron() to **setup a new squadron** active at an airfield, FARP or carrier,
---while defining which helicopter or plane **templates** are being used by the squadron and how many **resources** are available.
---
---**Multiple squadrons** can be defined within one A2G dispatcher, each having specific defense tasks and defense parameter settings!
---
---Squadrons:
---
---  * Have name (string) that is the identifier or **key** of the squadron.
---  * Have specific helicopter or plane **templates**.
---  * Are located at **one** airbase, farp or carrier.
---  * Optionally have a **limited set of resources**. The default is that squadrons have **unlimited resources**.
---
---The name of the squadron given acts as the **squadron key** in all `A2GDispatcher:SetSquadron...()` or `A2GDispatcher:GetSquadron...()` methods.
---
---Additionally, squadrons have specific configuration options to:
---
---  * Control how new helicopters or aircraft are taking off from the airfield, farp or carrier (in the air, cold, hot, at the runway).
---  * Control how returning helicopters or aircraft are landing at the airfield, farp or carrier (in the air near the airbase, after landing, after engine shutdown).
---  * Control the **grouping** of new helicopters or aircraft spawned at the airfield, farp or carrier. If there is more than one helicopter or aircraft to be spawned, these may be grouped.
---  * Control the **overhead** or defensive strength of the squadron. Depending on the types of helicopters, planes, amount of resources and payload (weapon configuration) chosen,
---    the mission designer can choose to increase or reduce the amount of planes spawned.
---
---The method #AI_A2G_DISPATCHER.SetSquadron() defines for you a new squadron. 
---The provided parameters are the squadron name, airbase name and a list of template prefixes, and a number that indicates the amount of resources.
---
---For example, this defines 3 new squadrons:
---
---       A2GDispatcher:SetSquadron( "Maykop SEAD", AIRBASE.Caucasus.Maykop_Khanskaya, { "CCCP KA-50" }, 10 )
---       A2GDispatcher:SetSquadron( "Maykop CAS", "CAS", { "CCCP KA-50" }, 10 )
---       A2GDispatcher:SetSquadron( "Maykop BAI", "BAI", { "CCCP KA-50" }, 10 )
---
---The latter 2 will depart from FARPs, which bare the name `"CAS"` and `"BAI"`.
---
---
---### 3.1. Squadrons **Tasking**.
---
---Squadrons can be commanded to execute 3 types of tasks, as explained above:
---
---  - SEAD: Suppression of Air Defenses, which are ground targets that have medium or long range radar emitters.
---  - BAI : Battlefield Air Interdiction, which are targets further away from the front-line.
---  - CAS : Close Air Support, when there are enemy ground targets close to friendly units.
---
---You need to configure each squadron which task types you want it to perform. Read on ...
---
---
---### 3.2. Squadrons enemy ground target **engagement types**.
---  
---There are two ways how targets can be engaged: directly **on call** from the airfield, FARP or carrier, or through a **patrol**.
---
---Patrols are extremely handy, as these will get your helicopters or airplanes airborne in advance. They will patrol in defined zones outlined,
---and will engage with the targets once commanded. If the patrol zone is close enough to the enemy ground targets, then the time required
---to engage is heavily minimized!
---
---However; patrols come with a side effect: since your resources are airborne, they will be vulnerable to incoming air attacks from the enemy.
---
---The mission designer needs to carefully balance the need for patrols or the need for engagement on call from the airfields.
---
---
---### 3.3. Squadron **on call** engagement.
---
---So to make squadrons engage targets from the airfields, use the following methods:
---
---  - For SEAD, use the #AI_A2G_DISPATCHER.SetSquadronSead() method.
---  - For BAI, use the #AI_A2G_DISPATCHER.SetSquadronBai() method.
---  - For CAS, use the #AI_A2G_DISPATCHER.SetSquadronCas() method.
---
---Note that for the tasks, specific helicopter or airplane templates are required to be used, which you can configure using your mission editor.
---Especially the payload (weapons configuration) is important to get right.
---
---For example, the following will define for the squadrons different tasks:
---
---       A2GDispatcher:SetSquadron( "Maykop SEAD", AIRBASE.Caucasus.Maykop_Khanskaya, { "CCCP KA-50 SEAD" }, 10 )
---       A2GDispatcher:SetSquadronSead( "Maykop SEAD", 120, 250 )
---       
---       A2GDispatcher:SetSquadron( "Maykop BAI", "BAI", { "CCCP KA-50 BAI" }, 10 )
---       A2GDispatcher:SetSquadronBai( "Maykop BAI", 120, 250 )
---
---       A2GDispatcher:SetSquadron( "Maykop CAS", "CAS", { "CCCP KA-50 CAS" }, 10 )
---       A2GDispatcher:SetSquadronCas( "Maykop CAS", 120, 250 )
---       
---
---### 3.4. Squadron **on patrol engagement**.
---
---Squadrons can be setup to patrol in the air near the engagement hot zone.
---When needed, the A2G defense units will be close to the battle area, and can engage quickly.
---
---So to make squadrons engage targets from a patrol zone, use the following methods:
---
---  - For SEAD, use the #AI_A2G_DISPATCHER.SetSquadronSeadPatrol() method.
---  - For BAI, use the #AI_A2G_DISPATCHER.SetSquadronBaiPatrol() method.
---  - For CAS, use the #AI_A2G_DISPATCHER.SetSquadronCasPatrol() method.
---
---Because a patrol requires more parameters, the following methods must be used to fine-tune the patrols for each squadron.
---
---  - For SEAD, use the #AI_A2G_DISPATCHER.SetSquadronSeadPatrolInterval() method.
---  - For BAI, use the #AI_A2G_DISPATCHER.SetSquadronBaiPatrolInterval() method.
---  - For CAS, use the #AI_A2G_DISPATCHER.SetSquadronCasPatrolInterval() method.
---
---Here an example to setup patrols of various task types:
---
---       A2GDispatcher:SetSquadron( "Maykop SEAD", AIRBASE.Caucasus.Maykop_Khanskaya, { "CCCP KA-50 SEAD" }, 10 )
---       A2GDispatcher:SetSquadronSeadPatrol( "Maykop SEAD", PatrolZone, 300, 500, 50, 80, 250, 300 )
---       A2GDispatcher:SetSquadronPatrolInterval( "Maykop SEAD", 2, 30, 60, 1, "SEAD" )
---       
---       A2GDispatcher:SetSquadron( "Maykop BAI", "BAI", { "CCCP KA-50 BAI" }, 10 )
---       A2GDispatcher:SetSquadronBaiPatrol( "Maykop BAI", PatrolZone, 800, 900, 50, 80, 250, 300 )
---       A2GDispatcher:SetSquadronPatrolInterval( "Maykop BAI", 2, 30, 60, 1, "BAI" )
---
---       A2GDispatcher:SetSquadron( "Maykop CAS", "CAS", { "CCCP KA-50 CAS" }, 10 )
---       A2GDispatcher:SetSquadronCasPatrol( "Maykop CAS", PatrolZone, 600, 700, 50, 80, 250, 300 )
---       A2GDispatcher:SetSquadronPatrolInterval( "Maykop CAS", 2, 30, 60, 1, "CAS" )
---       
---
---### 3.5. Set squadron takeoff methods
---
---Use the various SetSquadronTakeoff... methods to control how squadrons are taking-off from the home airfield, FARP or ship.
---
---  * #AI_A2G_DISPATCHER.SetSquadronTakeoff() is the generic configuration method to control takeoff from the air, hot, cold or from the runway. See the method for further details.
---  * #AI_A2G_DISPATCHER.SetSquadronTakeoffInAir() will spawn new aircraft from the squadron directly in the air.
---  * #AI_A2G_DISPATCHER.SetSquadronTakeoffFromParkingCold() will spawn new aircraft in without running engines at a parking spot at the airfield.
---  * #AI_A2G_DISPATCHER.SetSquadronTakeoffFromParkingHot() will spawn new aircraft in with running engines at a parking spot at the airfield.
---  * #AI_A2G_DISPATCHER.SetSquadronTakeoffFromRunway() will spawn new aircraft at the runway at the airfield.
---
---**The default landing method is to spawn new aircraft directly in the air.**
---
---Use these methods to fine-tune for specific airfields that are known to create bottlenecks, or have reduced airbase efficiency.
---The more and the longer aircraft need to taxi at an airfield, the more risk there is that:
---
---  * aircraft will stop waiting for each other or for a landing aircraft before takeoff.
---  * aircraft may get into a "dead-lock" situation, where two aircraft are blocking each other.
---  * aircraft may collide at the airbase.
---  * aircraft may be awaiting the landing of a plane currently in the air, but never lands ...
---
---Currently within the DCS engine, the airfield traffic coordination is erroneous and contains a lot of bugs.
---If you experience while testing problems with aircraft takeoff or landing, please use one of the above methods as a solution to workaround these issues!
---
---This example sets the default takeoff method to be from the runway.
---And for a couple of squadrons overrides this default method.
---
---     -- Setup the takeoff methods
---
---     -- Set the default takeoff method
---     A2GDispatcher:SetDefaultTakeoffFromRunway()
---
---     -- Set the individual squadrons takeoff method
---     A2GDispatcher:SetSquadronTakeoff( "Mineralnye", AI_A2G_DISPATCHER.Takeoff.Air )
---     A2GDispatcher:SetSquadronTakeoffInAir( "Sochi" )
---     A2GDispatcher:SetSquadronTakeoffFromRunway( "Mozdok" )
---     A2GDispatcher:SetSquadronTakeoffFromParkingCold( "Maykop" )
---     A2GDispatcher:SetSquadronTakeoffFromParkingHot( "Novo" )
---
---
---### 3.5.1. Set Squadron takeoff altitude when spawning new aircraft in the air.
---
---In the case of the #AI_A2G_DISPATCHER.SetSquadronTakeoffInAir() there is also an other parameter that can be applied.
---That is modifying or setting the **altitude** from where planes spawn in the air.
---Use the method #AI_A2G_DISPATCHER.SetSquadronTakeoffInAirAltitude() to set the altitude for a specific squadron.
---The default takeoff altitude can be modified or set using the method #AI_A2G_DISPATCHER.SetSquadronTakeoffInAirAltitude().
---As part of the method #AI_A2G_DISPATCHER.SetSquadronTakeoffInAir() a parameter can be specified to set the takeoff altitude.
---If this parameter is not specified, then the default altitude will be used for the squadron.
---
---
---### 3.5.2. Set Squadron takeoff interval.
---
---The different types of available airfields have different amounts of available launching platforms:
---
---  - Airbases typically have a lot of platforms.
---  - FARPs have 4 platforms.
---  - Ships have 2 to 4 platforms.
---
---Depending on the demand of requested takeoffs by the A2G dispatcher, an airfield can become overloaded. Too many aircraft need to be taken
---off at the same time, which will result in clutter as described above. In order to better control this behaviour, a takeoff scheduler is implemented,
---which can be used to control how many aircraft are ordered for takeoff between specific time intervals.
---The takeoff intervals can be specified per squadron, which make sense, as each squadron have a "home" airfield.
---
---For this purpose, the method #AI_A2G_DISPATCHER.SetSquadronTakeoffInterval() can be used to specify the takeoff intervals of
---aircraft groups per squadron to avoid cluttering of aircraft at airbases.
---This is especially useful for FARPs and ships. Each takeoff dispatch is queued by the dispatcher and when the interval time
---has been reached, a new group will be spawned or activated for takeoff.
---
---The interval needs to be estimated, and depends on the time needed for the aircraft group to actually depart from the launch platform, and
---the way how the aircraft are starting up. Cold starts take the longest duration, hot starts a few seconds, and runway takeoff also a few seconds for FARPs and ships.
---
---See the underlying example:
---
---     -- Imagine a squadron launched from a FARP, with a grouping of 4.
---     -- Aircraft will cold start from the FARP, and thus, a maximum of 4 aircraft can be launched at the same time.
---     -- Additionally, depending on the group composition of the aircraft, defending units will be ordered for takeoff together.
---     -- It takes about 3 to 4 minutes for helicopters to takeoff from FARPs in cold start.
---     A2GDispatcher:SetSquadronTakeoffInterval( "Mineralnye", 60 * 4 )
---
---
---### 3.6. Set squadron landing methods
---
---In analogy with takeoff, the landing methods are to control how squadrons land at the airfield:
---
---  * #AI_A2G_DISPATCHER.SetSquadronLanding() is the generic configuration method to control landing, namely despawn the aircraft near the airfield in the air, right after landing, or at engine shutdown.
---  * #AI_A2G_DISPATCHER.SetSquadronLandingNearAirbase() will despawn the returning aircraft in the air when near the airfield.
---  * #AI_A2G_DISPATCHER.SetSquadronLandingAtRunway() will despawn the returning aircraft directly after landing at the runway.
---  * #AI_A2G_DISPATCHER.SetSquadronLandingAtEngineShutdown() will despawn the returning aircraft when the aircraft has returned to its parking spot and has turned off its engines.
---
---You can use these methods to minimize the airbase coordination overhead and to increase the airbase efficiency.
---When there are lots of aircraft returning for landing, at the same airbase, the takeoff process will be halted, which can cause a complete failure of the
---A2G defense system, as no new SEAD, BAI or CAS planes can takeoff.
---Note that the method #AI_A2G_DISPATCHER.SetSquadronLandingNearAirbase() will only work for returning aircraft, not for damaged or out of fuel aircraft.
---Damaged or out-of-fuel aircraft are returning to the nearest friendly airbase and will land, and are out of control from ground control.
---
---This example defines the default landing method to be at the runway.
---And for a couple of squadrons overrides this default method.
---
---     -- Setup the Landing methods
---
---     -- The default landing method
---     A2GDispatcher:SetDefaultLandingAtRunway()
---
---     -- The individual landing per squadron
---     A2GDispatcher:SetSquadronLandingAtRunway( "Mineralnye" )
---     A2GDispatcher:SetSquadronLandingNearAirbase( "Sochi" )
---     A2GDispatcher:SetSquadronLandingAtEngineShutdown( "Mozdok" )
---     A2GDispatcher:SetSquadronLandingNearAirbase( "Maykop" )
---     A2GDispatcher:SetSquadronLanding( "Novo", AI_A2G_DISPATCHER.Landing.AtRunway )
---
---
---### 3.7. Set squadron **grouping**.
---
---Use the method #AI_A2G_DISPATCHER.SetSquadronGrouping() to set the grouping of aircraft when spawned in.
---
---In the case of **on call** engagement, the #AI_A2G_DISPATCHER.SetSquadronGrouping() method has additional behaviour.
---When there aren't enough patrol flights airborne, a on call will be initiated for the remaining
---targets to be engaged. Depending on the grouping parameter, the spawned flights for on call aircraft are grouped into this setting.   
---For example with a group setting of 2, if 3 targets are detected and cannot be engaged by the available patrols or any airborne flight, 
---an additional on call flight needs to be started.
---
---The **grouping value is set for a Squadron**, and can be **dynamically adjusted** during mission execution, so to adjust the defense flights grouping when the tactical situation changes.
---
---### 3.8. Set the squadron **overhead** to balance the effectiveness of the A2G defenses.
---
---The effectiveness can be set with the **overhead parameter**. This is a number that is used to calculate the amount of Units that dispatching command will allocate to GCI in surplus of detected amount of units.
---The **default value** of the overhead parameter is 1.0, which means **equal balance**.
---
---However, depending on the (type of) aircraft (strength and payload) in the squadron and the amount of resources available, this parameter can be changed.
---
---The #AI_A2G_DISPATCHER.SetSquadronOverhead() method can be used to tweak the defense strength,
---taking into account the plane types of the squadron. 
---
---For example, a A-10C with full long-distance A2G missiles payload, may still be less effective than a Su-23 with short range A2G missiles...
---So in this case, one may want to use the #AI_A2G_DISPATCHER.SetOverhead() method to allocate more defending planes as the amount of detected attacking ground units.
---The overhead must be given as a decimal value with 1 as the neutral value, which means that overhead values:
---
---  * Higher than 1.0, for example 1.5, will increase the defense unit amounts. For 4 attacking ground units detected, 6 aircraft will be spawned.
---  * Lower than 1, for example 0.75, will decrease the defense unit amounts. For 4 attacking ground units detected, only 3 aircraft will be spawned.
---
---The amount of defending units is calculated by multiplying the amount of detected attacking ground units as part of the detected group
---multiplied by the overhead parameter, and rounded up to the smallest integer.
---
---Typically, for A2G defenses, values small than 1 will be used. Here are some good values for a couple of aircraft to support CAS operations:
---
---  - A-10C: 0.15
---  - Su-34: 0.15
---  - A-10A: 0.25
---  - SU-25T: 0.10
---
---So generically, the amount of missiles that an aircraft can take will determine its attacking effectiveness. The longer the range of the missiles,
---the less risk that the defender may be destroyed by the enemy, thus, the less aircraft needs to be activated in a defense.
---
---The **overhead value is set for a Squadron**, and can be **dynamically adjusted** during mission execution, so to adjust the defense overhead when the tactical situation changes.
---
---### 3.8. Set the squadron **engage limit**.
---
---To limit the amount of aircraft to defend against a large group of intruders, an **engage limit** can be defined per squadron.
---This limit will avoid an extensive amount of aircraft to engage with the enemy if the attacking ground forces are enormous.
---
---Use the method #AI_A2G_DISPATCHER.SetSquadronEngageLimit() to limit the amount of aircraft that will engage with the enemy, per squadron.
---
---## 4. Set the **fuel threshold**.
---
---When an aircraft gets **out of fuel** with only a certain % of fuel left, which is **15% (0.15)** by default, there are two possible actions that can be taken:
--- - The aircraft will go RTB, and will be replaced with a new aircraft if possible.
--- - The aircraft will refuel at a tanker, if a tanker has been specified for the squadron.
---
---Use the method #AI_A2G_DISPATCHER.SetSquadronFuelThreshold() to set the **squadron fuel threshold** of the aircraft for all squadrons.
---
---## 6. Other configuration options
---
---### 6.1. Set a tactical display panel.
---
---Every 30 seconds, a tactical display panel can be shown that illustrates what the status is of the different groups controlled by AI_A2G_DISPATCHER.
---Use the method #AI_A2G_DISPATCHER.SetTacticalDisplay() to switch on the tactical display panel. The default will not show this panel.
---Note that there may be some performance impact if this panel is shown.
---
---## 10. Default settings.
---
---Default settings configure the standard behaviour of the squadrons.
---This section a good overview of the different parameters that setup the behaviour of **ALL** the squadrons by default.
---Note that default behaviour can be tweaked, and thus, this will change the behaviour of all the squadrons.
---Unless there is a specific behaviour set for a specific squadron, the default configured behaviour will be followed.
---
---## 10.1. Default **takeoff** behaviour.
---
---The default takeoff behaviour is set to **in the air**, which means that new spawned aircraft will be spawned directly in the air above the airbase by default.
---
---**The default takeoff method can be set for ALL squadrons that don't have an individual takeoff method configured.**
---
---  * #AI_A2G_DISPATCHER.SetDefaultTakeoff() is the generic configuration method to control takeoff by default from the air, hot, cold or from the runway. See the method for further details.
---  * #AI_A2G_DISPATCHER.SetDefaultTakeoffInAir() will spawn by default new aircraft from the squadron directly in the air.
---  * #AI_A2G_DISPATCHER.SetDefaultTakeoffFromParkingCold() will spawn by default new aircraft in without running engines at a parking spot at the airfield.
---  * #AI_A2G_DISPATCHER.SetDefaultTakeoffFromParkingHot() will spawn by default new aircraft in with running engines at a parking spot at the airfield.
---  * #AI_A2G_DISPATCHER.SetDefaultTakeoffFromRunway() will spawn by default new aircraft at the runway at the airfield.
---
---## 10.2. Default landing behaviour.
---
---The default landing behaviour is set to **near the airbase**, which means that returning aircraft will be despawned directly in the air by default.
---
---The default landing method can be set for ALL squadrons that don't have an individual landing method configured.
---
---  * #AI_A2G_DISPATCHER.SetDefaultLanding() is the generic configuration method to control by default landing, namely despawn the aircraft near the airfield in the air, right after landing, or at engine shutdown.
---  * #AI_A2G_DISPATCHER.SetDefaultLandingNearAirbase() will despawn by default the returning aircraft in the air when near the airfield.
---  * #AI_A2G_DISPATCHER.SetDefaultLandingAtRunway() will despawn by default the returning aircraft directly after landing at the runway.
---  * #AI_A2G_DISPATCHER.SetDefaultLandingAtEngineShutdown() will despawn by default the returning aircraft when the aircraft has returned to its parking spot and has turned off its engines.
---
---## 10.3. Default **overhead**.
---
---The default overhead is set to **0.25**. That essentially means that for each 4 ground enemies there will be 1 aircraft dispatched.
---
---The default overhead value can be set for ALL squadrons that don't have an individual overhead value configured.
---
---Use the #AI_A2G_DISPATCHER.SetDefaultOverhead() method can be used to set the default overhead or defense strength for ALL squadrons.
---
---## 10.4. Default **grouping**.
---
---The default grouping is set to **one aircraft**. That essentially means that there won't be any grouping applied by default.
---
---The default grouping value can be set for ALL squadrons that don't have an individual grouping value configured.
---
---Use the method #AI_A2G_DISPATCHER.SetDefaultGrouping() to set the **default grouping** of spawned aircraft for all squadrons.
---
---## 10.5. Default RTB fuel threshold.
---
---When an aircraft gets **out of fuel** with only a certain % of fuel left, which is **15% (0.15)** by default, it will go RTB, and will be replaced with a new aircraft when applicable.
---
---Use the method #AI_A2G_DISPATCHER.SetDefaultFuelThreshold() to set the **default fuel threshold** of spawned aircraft for all squadrons.
---
---## 10.6. Default RTB damage threshold.
---
---When an aircraft is **damaged** to a certain %, which is **40% (0.40)** by default, it will go RTB, and will be replaced with a new aircraft when applicable.
---
---Use the method #AI_A2G_DISPATCHER.SetDefaultDamageThreshold() to set the **default damage threshold** of spawned aircraft for all squadrons.
---
---## 10.7. Default settings for **patrol**.
---
---### 10.7.1. Default **patrol time Interval**.
---
---Patrol dispatching is time event driven, and will evaluate in random time intervals if a new patrol needs to be dispatched.
---
---The default patrol time interval is between **180** and **600** seconds.
---
---Use the method #AI_A2G_DISPATCHER.SetDefaultPatrolTimeInterval() to set the **default patrol time interval** of dispatched aircraft for ALL squadrons.
---  
---Note that you can still change the patrol limit and patrol time intervals for each patrol individually using 
---the #AI_A2G_DISPATCHER.SetSquadronPatrolTimeInterval() method.
---
---### 10.7.2. Default **patrol limit**.
---
---Multiple patrol can be airborne at the same time for one squadron, which is controlled by the **patrol limit**.
---The **default patrol limit** is 1 patrol per squadron to be airborne at the same time.
---Note that the default patrol limit is used when a squadron patrol is defined, and cannot be changed afterwards.
---So, ensure that you set the default patrol limit **before** you define or setup the squadron patrol.
---
---Use the method #AI_A2G_DISPATCHER.SetDefaultPatrolTimeInterval() to set the **default patrol time interval** of dispatched aircraft patrols for all squadrons.  
---Note that you can still change the patrol limit and patrol time intervals for each patrol individually using 
---the #AI_A2G_DISPATCHER.SetSquadronPatrolTimeInterval() method.
---
---## 10.7.3. Default tanker for refuelling when executing SEAD, BAI and CAS operations.
---
---Instead of sending SEAD, BAI and CAS aircraft to RTB when out of fuel, you can let SEAD, BAI and CAS aircraft refuel in mid air using a tanker.
---This greatly increases the efficiency of your SEAD, BAI and CAS operations.
---
---In the mission editor, setup a group with task Refuelling. A tanker unit of the correct coalition will be automatically selected.
---Then, use the method #AI_A2G_DISPATCHER.SetDefaultTanker() to set the tanker for the dispatcher.
---Use the method #AI_A2G_DISPATCHER.SetDefaultFuelThreshold() to set the % left in the defender aircraft tanks when a refuel action is needed.
---
---When the tanker specified is alive and in the air, the tanker will be used for refuelling.
---
---For example, the following setup will set the default refuel tanker to "Tanker":
---
---     -- Set the default tanker for refuelling to "Tanker", when the default fuel threshold has reached 90% fuel left.
---     A2GDispatcher:SetDefaultFuelThreshold( 0.9 )
---     A2GDispatcher:SetDefaultTanker( "Tanker" )
--- 
---## 10.8. Default settings for GCI.
---
---## 10.8.1. Optimal intercept point calculation.
---
---When intruders are detected, the intrusion path of the attackers can be monitored by the EWR.  
---Although defender planes might be on standby at the airbase, it can still take some time to get the defenses up in the air if there aren't any defenses airborne.
---This time can easily take 2 to 3 minutes, and even then the defenders still need to fly towards the target, which takes also time.
---
---Therefore, an optimal **intercept point** is calculated which takes a couple of parameters:
---
---  * The average bearing of the intruders for an amount of seconds.
---  * The average speed of the intruders for an amount of seconds.
---  * An assumed time it takes to get planes operational at the airbase.
---
---The **intercept point** will determine:
---
---  * If there are any friendlies close to engage the target. These can be defenders performing CAP or defenders in RTB.
---  * The optimal airbase from where defenders will takeoff for GCI.
---
---Use the method #AI_A2G_DISPATCHER.SetIntercept() to modify the assumed intercept delay time to calculate a valid interception.
---
---## 10.8.2. Default Disengage Radius.
---
---The radius to **disengage any target** when the **distance** of the defender to the **home base** is larger than the specified meters.
---The default Disengage Radius is **300km** (300000 meters). Note that the Disengage Radius is applicable to ALL squadrons!
---  
---Use the method #AI_A2G_DISPATCHER.SetDisengageRadius() to modify the default Disengage Radius to another distance setting.
---
---## 11. Airbase capture:
---
---Different squadrons can be located at one airbase.
---If the airbase gets captured, that is when there is an enemy unit near the airbase and there are no friendlies at the airbase, the airbase will change coalition ownership.
---As a result, further SEAD, BAI, and CAS operations from that airbase will stop.
---However, the squadron will still stay alive. Any aircraft that is airborne will continue its operations until all airborne aircraft
---of the squadron are destroyed. This is to keep consistency of air operations and avoid confusing players.
---
---
---AI_A2G_DISPATCHER class.
---@class AI_A2G_DISPATCHER : DETECTION_MANAGER
---@field DefenderDefault table 
---@field DefenderPatrolIndex number 
---@field DefenderSpawns table 
---@field DefenderSquadrons table 
---@field DefenderTasks table 
---@field DefenseApproach AI_A2G_DISPATCHER.DefenseApproach 
---@field DefenseCoordinates table 
---@field DefenseLimit NOTYPE 
---@field DefenseQueue table 
---@field Detection DETECTION_AREAS 
---@field Landing AI_A2G_DISPATCHER.Landing Defines Landing location.
---@field SetSendPlayerMessages NOTYPE 
---@field TacticalDisplay NOTYPE 
---@field Takeoff NOTYPE 
---@field TakeoffScheduleID NOTYPE 
---@field _DefenseApproach NOTYPE 
AI_A2G_DISPATCHER = {}


---
------
---@param Squadron NOTYPE 
---@param Defender NOTYPE 
---@param Size NOTYPE 
function AI_A2G_DISPATCHER:AddDefenderToSquadron(Squadron, Defender, Size) end


---
------
---@param DefenseCoordinateName NOTYPE 
---@param DefenseCoordinate NOTYPE 
function AI_A2G_DISPATCHER:AddDefenseCoordinate(DefenseCoordinateName, DefenseCoordinate) end

---Add resources to a Squadron
---
------
---@param Squadron string The squadron name.
---@param Amount number Number of resources to add.
function AI_A2G_DISPATCHER:AddToSquadron(Squadron, Amount) end


---
------
---@param SquadronName string The squadron name.
---@param DefenseTaskType NOTYPE 
---@return table #DefenderSquadron
function AI_A2G_DISPATCHER:CanDefend(SquadronName, DefenseTaskType) end


---
------
---@param SquadronName string The squadron name.
---@param DefenseTaskType NOTYPE 
---@return table #DefenderSquadron
function AI_A2G_DISPATCHER:CanPatrol(SquadronName, DefenseTaskType) end


---
------
---@param Defender NOTYPE 
function AI_A2G_DISPATCHER:ClearDefenderTask(Defender) end


---
------
---@param Defender NOTYPE 
function AI_A2G_DISPATCHER:ClearDefenderTaskTarget(Defender) end


---
------
---@param AttackerDetection NOTYPE 
---@param DefenderCount NOTYPE 
---@param DefenderTaskType NOTYPE 
function AI_A2G_DISPATCHER:CountDefenders(AttackerDetection, DefenderCount, DefenderTaskType) end


---
------
---@param AttackerDetection NOTYPE 
---@param AttackerCount NOTYPE 
function AI_A2G_DISPATCHER:CountDefendersEngaged(AttackerDetection, AttackerCount) end


---
------
---@param SquadronName NOTYPE 
---@param DefenseTaskType NOTYPE 
function AI_A2G_DISPATCHER:CountPatrolAirborne(SquadronName, DefenseTaskType) end

---Defend Trigger for AI_A2G_DISPATCHER
---
------
function AI_A2G_DISPATCHER:Defend() end

---Engage Trigger for AI_A2G_DISPATCHER
---
------
function AI_A2G_DISPATCHER:Engage() end

---Evaluates an BAI task.
---
------
---@param DetectedItem DETECTION_BASE.DetectedItem The detected item.
---@return SET_UNIT #The set of units of the targets to be engaged.
---@return nil #If there are no targets to be set.
function AI_A2G_DISPATCHER:Evaluate_BAI(DetectedItem) end

---Creates an CAS task.
---
------
---@param DetectedItem DETECTION_BASE.DetectedItem The detected item.
---@return SET_UNIT #The set of units of the targets to be engaged.
---@return nil #If there are no targets to be set.
function AI_A2G_DISPATCHER:Evaluate_CAS(DetectedItem) end

---Creates an SEAD task when the targets have radars.
---
------
---@param DetectedItem DETECTION_BASE.DetectedItem The detected item.
---@return SET_UNIT #The set of units of the targets to be engaged.
---@return nil #If there are no targets to be set.
function AI_A2G_DISPATCHER:Evaluate_SEAD(DetectedItem) end

---Gets the default method at which flights will land and despawn as part of the defense system.
---
------
---
---USAGE
---```
---
---
---  local A2GDispatcher = AI_A2G_DISPATCHER:New( ... )
---  
---  -- Let new flights by default despawn near the airbase when returning.
---  local LandingMethod = A2GDispatcher:GetDefaultLanding()
---  if LandingMethod == AI_A2G_Dispatcher.Landing.NearAirbase then
---   ...
---  end
---```
------
---@return number #Landing The landing method which can be NearAirbase, AtRunway, AtEngineShutdown
function AI_A2G_DISPATCHER:GetDefaultLanding() end

---Gets the default method at which new flights will spawn and takeoff as part of the defense system.
---
------
---
---USAGE
---```
---
---
---  local A2GDispatcher = AI_A2G_DISPATCHER:New( ... )
---  
---  -- Let new flights by default takeoff in the air.
---  local TakeoffMethod = A2GDispatcher:GetDefaultTakeoff()
---  if TakeoffMethod == , AI_A2G_Dispatcher.Takeoff.InAir then
---    ...
---  end
---```
------
---@return number #Takeoff From the airbase hot, from the airbase cold, in the air, from the runway.
function AI_A2G_DISPATCHER:GetDefaultTakeoff() end

---Calculates which defender friendlies are nearby the area, to help protect the area.
---
------
---@param DetectedItem NOTYPE 
---@return table #A list of the defender friendlies nearby, sorted by distance.
function AI_A2G_DISPATCHER:GetDefenderFriendliesNearBy(DetectedItem) end


---
------
---@param Defender NOTYPE 
function AI_A2G_DISPATCHER:GetDefenderTask(Defender) end


---
------
---@param Defender NOTYPE 
function AI_A2G_DISPATCHER:GetDefenderTaskFsm(Defender) end


---
------
---@param Defender NOTYPE 
function AI_A2G_DISPATCHER:GetDefenderTaskSquadronName(Defender) end


---
------
---@param Defender NOTYPE 
function AI_A2G_DISPATCHER:GetDefenderTaskTarget(Defender) end


---
------
function AI_A2G_DISPATCHER:GetDefenderTasks() end

---Calculates which friendlies are nearby the area.
---
------
---@param DetectedItem NOTYPE The detected item.
---@return REPORT #The amount of friendlies and a text string explaining which friendlies of which type.
function AI_A2G_DISPATCHER:GetFriendliesNearBy(DetectedItem) end


---
------
---@param SquadronName string The squadron name.
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:GetPatrolDelay(SquadronName) end

---Calculates which HUMAN friendlies are nearby the area.
---
------
---@param DetectedItem NOTYPE The detected item.
---@return REPORT #The amount of friendlies and a text string explaining which friendlies of which type.
function AI_A2G_DISPATCHER:GetPlayerFriendliesNearBy(DetectedItem) end

---Get an item from the Squadron table.
---
------
---@param SquadronName NOTYPE 
---@return table #
function AI_A2G_DISPATCHER:GetSquadron(SquadronName) end


---
------
---@param Defender NOTYPE 
function AI_A2G_DISPATCHER:GetSquadronFromDefender(Defender) end

---Gets the method at which flights will land and despawn as part of the defense system.
---
------
---
---USAGE
---```
---
---
---  local A2GDispatcher = AI_A2G_DISPATCHER:New( ... )
---  
---  -- Let new flights despawn near the airbase when returning.
---  local LandingMethod = A2GDispatcher:GetSquadronLanding( "SquadronName", AI_A2G_Dispatcher.Landing.NearAirbase )
---  if LandingMethod == AI_A2G_Dispatcher.Landing.NearAirbase then
---   ...
---  end
---```
------
---@param SquadronName string The name of the squadron.
---@return number #Landing The landing method which can be NearAirbase, AtRunway, AtEngineShutdown
function AI_A2G_DISPATCHER:GetSquadronLanding(SquadronName) end

---Gets the overhead of planes as part of the defense system, in comparison with the attackers.
---
------
---
---USAGE
---```
---
---
---  local A2GDispatcher = AI_A2G_DISPATCHER:New( ... )
---  
---  -- An overhead of 1,5 with 1 planes detected, will allocate 2 planes ( 1 * 1,5 ) = 1,5 => rounded up gives 2.
---  -- An overhead of 1,5 with 2 planes detected, will allocate 3 planes ( 2 * 1,5 ) = 3 =>  rounded up gives 3.
---  -- An overhead of 1,5 with 3 planes detected, will allocate 5 planes ( 3 * 1,5 ) = 4,5 => rounded up gives 5 planes.
---  -- An overhead of 1,5 with 4 planes detected, will allocate 6 planes ( 4 * 1,5 ) = 6  => rounded up gives 6 planes.
---  
---  local SquadronOverhead = A2GDispatcher:GetSquadronOverhead( "SquadronName" )
---```
------
---@param SquadronName string The name of the squadron.
---@return number #The % of Units that dispatching command will allocate to intercept in surplus of detected amount of units. The default overhead is 1, so equal balance. The @{#AI_A2G_DISPATCHER.SetOverhead}() method can be used to tweak the defense strength, taking into account the plane types of the squadron. For example, a MIG-31 with full long-distance A2G missiles payload, may still be less effective than a F-15C with short missiles... So in this case, one may want to use the Overhead method to allocate more defending planes as the amount of detected attacking planes. The overhead must be given as a decimal value with 1 as the neutral value, which means that Overhead values:     * Higher than 1, will increase the defense unit amounts.   * Lower than 1, will decrease the defense unit amounts.  The amount of defending units is calculated by multiplying the amount of detected attacking planes as part of the detected group  multiplied by the Overhead and rounded up to the smallest integer.   The Overhead value set for a Squadron, can be programmatically adjusted (by using this SetOverhead method), to adjust the defense overhead during mission execution.  See example below.  
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:GetSquadronOverhead(SquadronName) end

---Gets the method at which new flights will spawn and takeoff as part of the defense system.
---
------
---
---USAGE
---```
---
---
---  local A2GDispatcher = AI_A2G_DISPATCHER:New( ... )
---  
---  -- Let new flights takeoff in the air.
---  local TakeoffMethod = A2GDispatcher:GetSquadronTakeoff( "SquadronName" )
---  if TakeoffMethod == , AI_A2G_Dispatcher.Takeoff.InAir then
---    ...
---  end
---```
------
---@param SquadronName string The name of the squadron.
---@return number #Takeoff From the airbase hot, from the airbase cold, in the air, from the runway.
function AI_A2G_DISPATCHER:GetSquadronTakeoff(SquadronName) end


---
------
---@param DefenseCoordinate NOTYPE 
---@param DetectedItem NOTYPE 
function AI_A2G_DISPATCHER:HasDefenseLine(DefenseCoordinate, DetectedItem) end

---Check if the Squadron is visible before startup of the dispatcher.
---
------
---
---USAGE
---```
---
---       -- Set the Squadron visible before startup of dispatcher.
---       local IsVisible = A2GDispatcher:IsSquadronVisible( "Mineralnye" )
---```
------
---@param SquadronName string The squadron name.
---@return boolean #true if visible.
function AI_A2G_DISPATCHER:IsSquadronVisible(SquadronName) end

---Determine the distance as the keys of reference of the detected items.
---
------
---@param DetectedItem NOTYPE 
function AI_A2G_DISPATCHER:Keys(DetectedItem) end

---Locks the DefenseItem from being defended.
---
------
---@param DetectedItemIndex string The index of the detected item.
function AI_A2G_DISPATCHER:Lock(DetectedItemIndex) end

---AI_A2G_DISPATCHER constructor.
---This is defining the A2G DISPATCHER for one coalition.
---The Dispatcher works with a Functional.Detection#DETECTION_BASE object that is taking of the detection of targets using the EWR units.
---The Detection object is polymorphic, depending on the type of detection object chosen, the detection will work differently.
---
------
---
---USAGE
---```
---  
---  -- Setup the Detection, using DETECTION_AREAS.
---  -- First define the SET of GROUPs that are defining the EWR network.
---  -- Here with prefixes DF CCCP AWACS, DF CCCP EWR.
---  DetectionSetGroup = SET_GROUP:New()
---  DetectionSetGroup:FilterPrefixes( { "DF CCCP AWACS", "DF CCCP EWR" } )
---  DetectionSetGroup:FilterStart()
---  
---  -- Define the DETECTION_AREAS, using the DetectionSetGroup, with a 30km grouping radius.
---  Detection = DETECTION_AREAS:New( DetectionSetGroup, 30000 )
---
---  -- Now Setup the A2G dispatcher, and initialize it using the Detection object.
---  A2GDispatcher = AI_A2G_DISPATCHER:New( Detection )  
---```
------
---@param Detection DETECTION_BASE The DETECTION object that will detects targets using the the Early Warning Radar network.
---@return AI_A2G_DISPATCHER #self
function AI_A2G_DISPATCHER:New(Detection) end

---OnAfter Transition Handler for Event Assign.
---
------
---@param From string The From State string.
---@param Event string The Event string.
---@param To string The To State string.
---@param Task AI_A2G 
---@param TaskUnit UNIT 
---@param PlayerName string 
function AI_A2G_DISPATCHER:OnAfterAssign(From, Event, To, Task, TaskUnit, PlayerName) end

---Defend Handler OnAfter for AI_A2G_DISPATCHER
---
------
---@param From string 
---@param Event string 
---@param To string 
function AI_A2G_DISPATCHER:OnAfterDefend(From, Event, To) end

---Engage Handler OnAfter for AI_A2G_DISPATCHER
---
------
---@param From string 
---@param Event string 
---@param To string 
function AI_A2G_DISPATCHER:OnAfterEngage(From, Event, To) end

---Patrol Handler OnAfter for AI_A2G_DISPATCHER
---
------
---@param From string 
---@param Event string 
---@param To string 
function AI_A2G_DISPATCHER:OnAfterPatrol(From, Event, To) end

---Defend Handler OnBefore for AI_A2G_DISPATCHER
---
------
---@param From string 
---@param Event string 
---@param To string 
---@return boolean #
function AI_A2G_DISPATCHER:OnBeforeDefend(From, Event, To) end

---Engage Handler OnBefore for AI_A2G_DISPATCHER
---
------
---@param From string 
---@param Event string 
---@param To string 
---@return boolean #
function AI_A2G_DISPATCHER:OnBeforeEngage(From, Event, To) end

---Patrol Handler OnBefore for AI_A2G_DISPATCHER
---
------
---@param From string 
---@param Event string 
---@param To string 
---@return boolean #
function AI_A2G_DISPATCHER:OnBeforePatrol(From, Event, To) end


---
------
---@param EventData NOTYPE 
function AI_A2G_DISPATCHER:OnEventBaseCaptured(EventData) end


---
------
---@param EventData NOTYPE 
function AI_A2G_DISPATCHER:OnEventCrashOrDead(EventData) end


---
------
---@param EventData NOTYPE 
function AI_A2G_DISPATCHER:OnEventEngineShutdown(EventData) end


---
------
---@param EventData NOTYPE 
function AI_A2G_DISPATCHER:OnEventLand(EventData) end

---Assigns A2G AI Tasks in relation to the detected items.
---
------
---@param DetectedItem NOTYPE 
function AI_A2G_DISPATCHER:Order(DetectedItem) end

---Patrol Trigger for AI_A2G_DISPATCHER
---
------
function AI_A2G_DISPATCHER:Patrol() end

---Assigns A2G AI Tasks in relation to the detected items.
---
------
---@param Detection DETECTION_BASE The detection created by the @{Functional.Detection#DETECTION_BASE} derived object.
---@return boolean #Return true if you want the task assigning to continue... false will cancel the loop.
function AI_A2G_DISPATCHER:ProcessDetected(Detection) end

---Get a resource count from a specific squadron
---
------
---@param Squadron string Name of the squadron.
---@return number #Number of airframes available or nil if the squadron does not exist
function AI_A2G_DISPATCHER:QuerySquadron(Squadron) end


---
------
---@param Squadron NOTYPE 
---@param Defender NOTYPE 
function AI_A2G_DISPATCHER:RemoveDefenderFromSquadron(Squadron, Defender) end

---Remove resources from a Squadron
---
------
---@param Squadron string The squadron name.
---@param Amount number Number of resources to remove.
function AI_A2G_DISPATCHER:RemoveFromSquadron(Squadron, Amount) end


---
------
---@param DefenderSquadron NOTYPE 
---@param DefendersNeeded NOTYPE 
function AI_A2G_DISPATCHER:ResourceActivate(DefenderSquadron, DefendersNeeded) end


---
------
---@param DefenderSquadron NOTYPE 
---@param DefendersNeeded NOTYPE 
---@param Defense NOTYPE 
---@param DefenseTaskType NOTYPE 
---@param AttackerDetection NOTYPE 
---@param SquadronName NOTYPE 
function AI_A2G_DISPATCHER:ResourceEngage(DefenderSquadron, DefendersNeeded, Defense, DefenseTaskType, AttackerDetection, SquadronName) end


---
------
---@param DefenderSquadron NOTYPE 
function AI_A2G_DISPATCHER:ResourcePark(DefenderSquadron) end


---
------
---@param DefenderSquadron NOTYPE 
---@param DefendersNeeded NOTYPE 
---@param Patrol NOTYPE 
---@param DefenseTaskType NOTYPE 
---@param AttackerDetection NOTYPE 
---@param SquadronName NOTYPE 
function AI_A2G_DISPATCHER:ResourcePatrol(DefenderSquadron, DefendersNeeded, Patrol, DefenseTaskType, AttackerDetection, SquadronName) end


---
------
---@param Patrol NOTYPE 
---@param DefenderSquadron NOTYPE 
---@param DefendersNeeded NOTYPE 
---@param Defense NOTYPE 
---@param DefenseTaskType NOTYPE 
---@param AttackerDetection NOTYPE 
---@param SquadronName NOTYPE 
function AI_A2G_DISPATCHER:ResourceQueue(Patrol, DefenderSquadron, DefendersNeeded, Defense, DefenseTaskType, AttackerDetection, SquadronName) end


---
------
function AI_A2G_DISPATCHER:ResourceTakeoff() end

---Schedules a new Patrol for the given SquadronName.
---
------
---@param SquadronName string The squadron name.
function AI_A2G_DISPATCHER:SchedulerPatrol(SquadronName) end

---Define a border area to simulate a **cold war** scenario.
---A **cold war** is one where Patrol aircraft patrol their territory but will not attack enemy aircraft or launch GCI aircraft unless enemy aircraft enter their territory. In other words the EWR may detect an enemy aircraft but will only send aircraft to attack it if it crosses the border.
---A **hot war** is one where Patrol aircraft will intercept any detected enemy aircraft and GCI aircraft will launch against detected enemy aircraft without regard for territory. In other words if the ground radar can detect the enemy aircraft then it will send Patrol and GCI aircraft to attack it.
---If it's a cold war then the **borders of red and blue territory** need to be defined using a Core.Zone object derived from Core.Zone#ZONE_BASE. This method needs to be used for this.
---If a hot war is chosen then **no borders** actually need to be defined using the helicopter units other than it makes it easier sometimes for the mission maker to envisage where the red and blue territories roughly are. In a hot war the borders are effectively defined by the ground based radar coverage of a coalition. Set the noborders parameter to 1
---
------
---
---USAGE
---```
---
---  -- Now Setup the A2G dispatcher, and initialize it using the Detection object.
---  A2GDispatcher = AI_A2G_DISPATCHER:New( Detection )  
---  
---  -- Set one ZONE_POLYGON object as the border for the A2G dispatcher.
---  local BorderZone = ZONE_POLYGON( "CCCP Border", GROUP:FindByName( "CCCP Border" ) ) -- The GROUP object is a late activate helicopter unit.
---  A2GDispatcher:SetBorderZone( BorderZone )
---  
---or
---  
---  -- Set two ZONE_POLYGON objects as the border for the A2G dispatcher.
---  local BorderZone1 = ZONE_POLYGON( "CCCP Border1", GROUP:FindByName( "CCCP Border1" ) ) -- The GROUP object is a late activate helicopter unit.
---  local BorderZone2 = ZONE_POLYGON( "CCCP Border2", GROUP:FindByName( "CCCP Border2" ) ) -- The GROUP object is a late activate helicopter unit.
---  A2GDispatcher:SetBorderZone( { BorderZone1, BorderZone2 } )
---```
------
---@param BorderZone ZONE_BASE An object derived from ZONE_BASE, or a list of objects derived from ZONE_BASE.
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetBorderZone(BorderZone) end

---Set the default damage threshold when defenders will RTB.
---The default damage threshold is by default set to 40%, which means that when the aircraft is 40% damaged, it will go RTB.
---
------
---
---USAGE
---```
---
---  -- Now Setup the A2G dispatcher, and initialize it using the Detection object.
---  A2GDispatcher = AI_A2G_DISPATCHER:New( Detection )  
---  
---  -- Now Setup the default damage threshold.
---  A2GDispatcher:SetDefaultDamageThreshold( 0.90 ) -- Go RTB when the aircraft is 90% damaged.
---```
------
---@param DamageThreshold number A decimal number between 0 and 1, that expresses the % of damage when the aircraft will go RTB.
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetDefaultDamageThreshold(DamageThreshold) end

---Set the default engage limit for squadrons, which will be used to determine how many air units will engage at the same time with the enemy.
---The default eatrol limit is 1, which means one eatrol group maximum per squadron.
---
------
---
---USAGE
---```
---
---  -- Now Setup the A2G dispatcher, and initialize it using the Detection object.
---  A2GDispatcher = AI_A2G_DISPATCHER:New( Detection )  
---  
---  -- Now Setup the default Patrol limit.
---  A2GDispatcher:SetDefaultEngageLimit( 2 ) -- Maximum 2 engagements with the enemy per squadron.
---```
------
---@param EngageLimit number The maximum engages that can be done at the same time per squadron.
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetDefaultEngageLimit(EngageLimit) end

---Set the default fuel threshold when defenders will RTB or Refuel in the air.
---The fuel threshold is by default set to 15%, which means that an aircraft will stay in the air until 15% of its fuel is remaining.
---
------
---
---USAGE
---```
---
---  -- Now Setup the A2G dispatcher, and initialize it using the Detection object.
---  A2GDispatcher = AI_A2G_DISPATCHER:New( Detection )  
---  
---  -- Now Setup the default fuel threshold.
---  A2GDispatcher:SetDefaultFuelThreshold( 0.30 ) -- Go RTB when only 30% of fuel remaining in the tank.
---```
------
---@param FuelThreshold number A decimal number between 0 and 1, that expresses the % of the threshold of fuel remaining in the tank when the plane will go RTB or Refuel.
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetDefaultFuelThreshold(FuelThreshold) end

---Sets the default grouping of new aircraft spawned.
---Grouping will trigger how new aircraft will be grouped if more than one aircraft is spawned for defense.
---
------
---
---USAGE
---```
---
---
---  local A2GDispatcher = AI_A2G_DISPATCHER:New( ... )
---  
---  -- Set a grouping by default per 2 aircraft.
---  A2GDispatcher:SetDefaultGrouping( 2 )
---```
------
---@param Grouping number The level of grouping that will be applied for the Patrol.
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetDefaultGrouping(Grouping) end

---Defines the default method at which flights will land and despawn as part of the defense system.
---
------
---
---USAGE
---```
---
---
---  local A2GDispatcher = AI_A2G_DISPATCHER:New( ... )
---  
---  -- Let new flights by default despawn near the airbase when returning.
---  A2GDispatcher:SetDefaultLanding( AI_A2G_Dispatcher.Landing.NearAirbase )
---  
---  -- Let new flights by default despawn after landing land at the runway.
---  A2GDispatcher:SetDefaultLanding( AI_A2G_Dispatcher.Landing.AtRunway )
---  
---  -- Let new flights by default despawn after landing and parking, and after engine shutdown.
---  A2GDispatcher:SetDefaultLanding( AI_A2G_Dispatcher.Landing.AtEngineShutdown )
---```
------
---@param Landing number The landing method which can be NearAirbase, AtRunway, AtEngineShutdown
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetDefaultLanding(Landing) end

---Sets flights by default to land and despawn at engine shutdown, as part of the defense system.
---
------
---
---USAGE
---```
---
---
---  local A2GDispatcher = AI_A2G_DISPATCHER:New( ... )
---  
---  -- Let flights by default land and despawn at engine shutdown.
---  A2GDispatcher:SetDefaultLandingAtEngineShutdown()
---```
------
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetDefaultLandingAtEngineShutdown() end

---Sets flights by default to land and despawn at the runway, as part of the defense system.
---
------
---
---USAGE
---```
---
---
---  local A2GDispatcher = AI_A2G_DISPATCHER:New( ... )
---  
---  -- Let flights by default land at the runway and despawn.
---  A2GDispatcher:SetDefaultLandingAtRunway()
---```
------
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetDefaultLandingAtRunway() end

---Sets flights by default to land and despawn near the airbase in the air, as part of the defense system.
---
------
---
---USAGE
---```
---
---
---  local A2GDispatcher = AI_A2G_DISPATCHER:New( ... )
---  
---  -- Let flights by default to land near the airbase and despawn.
---  A2GDispatcher:SetDefaultLandingNearAirbase()
---```
------
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetDefaultLandingNearAirbase() end

---Defines the default amount of extra planes that will takeoff as part of the defense system.
---
------
---
---USAGE
---```
---
---
---  local A2GDispatcher = AI_A2G_DISPATCHER:New( ... )
---  
---  -- An overhead of 1,5 with 1 planes detected, will allocate 2 planes ( 1 * 1,5 ) = 1,5 => rounded up gives 2.
---  -- An overhead of 1,5 with 2 planes detected, will allocate 3 planes ( 2 * 1,5 ) = 3 =>  rounded up gives 3.
---  -- An overhead of 1,5 with 3 planes detected, will allocate 5 planes ( 3 * 1,5 ) = 4,5 => rounded up gives 5 planes.
---  -- An overhead of 1,5 with 4 planes detected, will allocate 6 planes ( 4 * 1,5 ) = 6  => rounded up gives 6 planes.
---  
---  A2GDispatcher:SetDefaultOverhead( 1.5 )
---```
------
---@param Overhead number The % of Units that dispatching command will allocate to intercept in surplus of detected amount of units. The default overhead is 1, so equal balance. The @{#AI_A2G_DISPATCHER.SetOverhead}() method can be used to tweak the defense strength, taking into account the plane types of the squadron. For example, a MIG-31 with full long-distance A2G missiles payload, may still be less effective than a F-15C with short missiles... So in this case, one may want to use the Overhead method to allocate more defending planes as the amount of detected attacking planes. The overhead must be given as a decimal value with 1 as the neutral value, which means that Overhead values:     * Higher than 1, will increase the defense unit amounts.   * Lower than 1, will decrease the defense unit amounts.  The amount of defending units is calculated by multiplying the amount of detected attacking planes as part of the detected group  multiplied by the Overhead and rounded up to the smallest integer.   The Overhead value set for a Squadron, can be programmatically adjusted (by using this SetOverhead method), to adjust the defense overhead during mission execution.  See example below.  
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetDefaultOverhead(Overhead) end

---Set the default Patrol limit for squadrons, which will be used to determine how many Patrol can be airborne at the same time for the squadron.
---The default Patrol limit is 1 Patrol, which means one Patrol group being spawned.
---
------
---
---USAGE
---```
---
---  -- Now Setup the A2G dispatcher, and initialize it using the Detection object.
---  A2GDispatcher = AI_A2G_DISPATCHER:New( Detection )  
---  
---  -- Now Setup the default Patrol limit.
---  A2GDispatcher:SetDefaultPatrolLimit( 2 ) -- Maximum 2 Patrol per squadron.
---```
------
---@param PatrolLimit number The maximum amount of Patrol that can be airborne at the same time for the squadron.
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetDefaultPatrolLimit(PatrolLimit) end

---Set the default Patrol time interval for squadrons, which will be used to determine a random Patrol timing.
---The default Patrol time interval is between 180 and 600 seconds.
---
------
---
---USAGE
---```
---
---  -- Now Setup the A2G dispatcher, and initialize it using the Detection object.
---  A2GDispatcher = AI_A2G_DISPATCHER:New( Detection )  
---  
---  -- Now Setup the default Patrol time interval.
---  A2GDispatcher:SetDefaultPatrolTimeInterval( 300, 1200 ) -- Between 300 and 1200 seconds.
---```
------
---@param PatrolMinSeconds number The minimum amount of seconds for the random time interval.
---@param PatrolMaxSeconds number The maximum amount of seconds for the random time interval.
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetDefaultPatrolTimeInterval(PatrolMinSeconds, PatrolMaxSeconds) end

---Defines the default method at which new flights will spawn and takeoff as part of the defense system.
---
------
---
---USAGE
---```
---
---
---  local A2GDispatcher = AI_A2G_DISPATCHER:New( ... )
---  
---  -- Let new flights by default takeoff in the air.
---  A2GDispatcher:SetDefaultTakeoff( AI_A2G_Dispatcher.Takeoff.Air )
---  
---  -- Let new flights by default takeoff from the runway.
---  A2GDispatcher:SetDefaultTakeoff( AI_A2G_Dispatcher.Takeoff.Runway )
---  
---  -- Let new flights by default takeoff from the airbase hot.
---  A2GDispatcher:SetDefaultTakeoff( AI_A2G_Dispatcher.Takeoff.Hot )
---
---  -- Let new flights by default takeoff from the airbase cold.
---  A2GDispatcher:SetDefaultTakeoff( AI_A2G_Dispatcher.Takeoff.Cold )
---```
------
---@param Takeoff number From the airbase hot, from the airbase cold, in the air, from the runway.
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetDefaultTakeoff(Takeoff) end

---Sets flights to by default takeoff from the airbase at a cold location, as part of the defense system.
---
------
---
---USAGE
---```
---
---
---  local A2GDispatcher = AI_A2G_DISPATCHER:New( ... )
---  
---  -- Let new flights takeoff from a cold parking spot.
---  A2GDispatcher:SetDefaultTakeoffFromParkingCold()
---```
------
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetDefaultTakeoffFromParkingCold() end

---Sets flights by default to takeoff from the airbase at a hot location, as part of the defense system.
---
------
---
---USAGE
---```
---
---
---  local A2GDispatcher = AI_A2G_DISPATCHER:New( ... )
---  
---  -- Let new flights by default takeoff at a hot parking spot.
---  A2GDispatcher:SetDefaultTakeoffFromParkingHot()
---```
------
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetDefaultTakeoffFromParkingHot() end

---Sets flights by default to takeoff from the runway, as part of the defense system.
---
------
---
---USAGE
---```
---
---
---  local A2GDispatcher = AI_A2G_DISPATCHER:New( ... )
---  
---  -- Let new flights by default takeoff from the runway.
---  A2GDispatcher:SetDefaultTakeoffFromRunway()
---```
------
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetDefaultTakeoffFromRunway() end

---Sets flights to default takeoff in the air, as part of the defense system.
---
------
---
---USAGE
---```
---
---
---  local A2GDispatcher = AI_A2G_DISPATCHER:New( ... )
---  
---  -- Let new flights by default takeoff in the air.
---  A2GDispatcher:SetDefaultTakeoffInAir()
---```
------
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetDefaultTakeoffInAir() end

---Defines the default altitude where aircraft will spawn in the air and takeoff as part of the defense system, when the takeoff in the air method has been selected.
---
------
---
---USAGE
---```
---
---
---  local A2GDispatcher = AI_A2G_DISPATCHER:New( ... )
---  
---  -- Set the default takeoff altitude when taking off in the air.
---  A2GDispatcher:SetDefaultTakeoffInAirAltitude( 2000 )  -- This makes planes start at 2000 meters above the ground.
---```
------
---@param TakeoffAltitude number The altitude in meters above ground level (AGL).
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetDefaultTakeoffInAirAltitude(TakeoffAltitude) end

---Set the default tanker where defenders will Refuel in the air.
---
------
---
---USAGE
---```
---
---  -- Now Setup the A2G dispatcher, and initialize it using the Detection object.
---  A2GDispatcher = AI_A2G_DISPATCHER:New( Detection )  
---  
---  -- Now Setup the default fuel threshold.
---  A2GDispatcher:SetDefaultFuelThreshold( 0.30 ) -- Go RTB when only 30% of fuel remaining in the tank.
---  
---  -- Now Setup the default tanker.
---  A2GDispatcher:SetDefaultTanker( "Tanker" ) -- The group name of the tanker is "Tanker" in the Mission Editor.
---```
------
---@param TankerName string A string defining the group name of the Tanker as defined within the Mission Editor.
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetDefaultTanker(TankerName) end


---
------
---@param SquadronName NOTYPE 
---@param Defender NOTYPE 
---@param Type NOTYPE 
---@param Fsm NOTYPE 
---@param Target NOTYPE 
---@param Size NOTYPE 
function AI_A2G_DISPATCHER:SetDefenderTask(SquadronName, Defender, Type, Fsm, Target, Size) end


---
------
---@param AIGroup GROUP 
---@param Defender NOTYPE 
---@param AttackerDetection NOTYPE 
function AI_A2G_DISPATCHER:SetDefenderTaskTarget(AIGroup, Defender, AttackerDetection) end

---Sets the method of the tactical approach of the defenses.
---
------
---@param DefenseApproach number Use the structure AI_A2G_DISPATCHER.DefenseApproach to set the defense approach. The default defense approach is AI_A2G_DISPATCHER.DefenseApproach.Random.
function AI_A2G_DISPATCHER:SetDefenseApproach(DefenseApproach) end

---Sets maximum zones to be engaged at one time by defenders.
---
------
---@param DefenseLimit number The maximum amount of detected items to be engaged at the same time.
function AI_A2G_DISPATCHER:SetDefenseLimit(DefenseLimit) end

---Define the defense radius to check if a target can be engaged by a squadron group for SEAD, BAI, or CAS for defense.
---When targets are detected that are still really far off, you don't want the AI_A2G_DISPATCHER to launch defenders, as they might need to travel too far.
---You want it to wait until a certain defend radius is reached, which is calculated as:
---  1. the **distance of the closest airbase to target**, being smaller than the **Defend Radius**.
---  2. the **distance to any defense reference point**.
---
---The **default** defense radius is defined as **40000** or **40km**. Override the default defense radius when the era of the warfare is early, or, 
---when you don't want to let the AI_A2G_DISPATCHER react immediately when a certain border or area is not being crossed.
---
---Use the method #AI_A2G_DISPATCHER.SetDefendRadius() to set a specific defend radius for all squadrons,
---**the Defense Radius is defined for ALL squadrons which are operational.**
---
------
---
---USAGE
---```
---
---  -- Now Setup the A2G dispatcher, and initialize it using the Detection object.
---  A2GDispatcher = AI_A2G_DISPATCHER:New( Detection ) 
---  
---  -- Set 100km as the radius to defend from detected targets from the nearest airbase.
---  A2GDispatcher:SetDefendRadius( 100000 )
---  
---  -- Set 200km as the radius to defend.
---  A2GDispatcher:SetDefendRadius() -- 200000 is the default value.
---```
------
---@param DefenseRadius number (Optional, Default = 20000) The defense radius to engage detected targets from the nearest capable and available squadron airbase.
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetDefenseRadius(DefenseRadius) end


---
------
function AI_A2G_DISPATCHER:SetDefenseReactivityHigh() end


---
------
function AI_A2G_DISPATCHER:SetDefenseReactivityLow() end


---
------
function AI_A2G_DISPATCHER:SetDefenseReactivityMedium() end

---Define the radius to disengage any target when the distance to the home base is larger than the specified meters.
---
------
---
---USAGE
---```
---
---  -- Set 50km as the Disengage Radius.
---  A2GDispatcher:SetDisengageRadius( 50000 )
---  
---  -- Set 100km as the Disengage Radius.
---  A2GDispatcher:SetDisengageRadius() -- 300000 is the default value.
---```
------
---@param DisengageRadius number (Optional, Default = 300000) The radius to disengage a target when too far from the home base.
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetDisengageRadius(DisengageRadius) end


---
------
---@param InterceptDelay NOTYPE 
function AI_A2G_DISPATCHER:SetIntercept(InterceptDelay) end

---Set flashing player messages on or off
---
------
---@param onoff boolean Set messages on (true) or off (false)
function AI_A2G_DISPATCHER:SetSendMessages(onoff) end

---This is the main method to define Squadrons programmatically.
---Squadrons:
---
---  * Have a **name or key** that is the identifier or key of the squadron.
---  * Have **specific plane types** defined by **templates**.
---  * Are **located at one specific airbase**. Multiple squadrons can be located at one airbase through.
---  * Optionally have a limited set of **resources**. The default is that squadrons have unlimited resources.
---
---The name of the squadron given acts as the **squadron key** in the AI\_A2G\_DISPATCHER:Squadron...() methods.
---
---Additionally, squadrons have specific configuration options to:
---
---  * Control how new aircraft are **taking off** from the airfield (in the air, cold, hot, at the runway).
---  * Control how returning aircraft are **landing** at the airfield (in the air near the airbase, after landing, after engine shutdown).
---  * Control the **grouping** of new aircraft spawned at the airfield. If there is more than one aircraft to be spawned, these may be grouped.
---  * Control the **overhead** or defensive strength of the squadron. Depending on the types of planes and amount of resources, the mission designer can choose to increase or reduce the amount of planes spawned.
---  
---For performance and bug workaround reasons within DCS, squadrons have different methods to spawn new aircraft or land returning or damaged aircraft.
---
------
---
---USAGE
---```
---  -- Now Setup the A2G dispatcher, and initialize it using the Detection object.
---  A2GDispatcher = AI_A2G_DISPATCHER:New( Detection )  
---```
------
---@param SquadronName string A string (text) that defines the squadron identifier or the key of the Squadron.  It can be any name, for example `"104th Squadron"` or `"SQ SQUADRON1"`, whatever.  As long as you remember that this name becomes the identifier of your squadron you have defined.  You need to use this name in other methods too! 
---@param AirbaseName string The airbase name where you want to have the squadron located.  You need to specify here EXACTLY the name of the airbase as you see it in the mission editor.  Examples are `"Batumi"` or `"Tbilisi-Lochini"`.  EXACTLY the airbase name, between quotes `""`. To ease the airbase naming when using the LDT editor and IntelliSense, the @{Wrapper.Airbase#AIRBASE} class contains enumerations of the airbases of each map.        * Caucasus: @{Wrapper.Airbase#AIRBASE.Caucaus}    * Nevada or NTTR: @{Wrapper.Airbase#AIRBASE.Nevada}    * Normandy: @{Wrapper.Airbase#AIRBASE.Normandy} 
---@param TemplatePrefixes string A string or an array of strings specifying the **prefix names of the templates** (not going to explain what is templates here again).  Examples are `{ "104th", "105th" }` or `"104th"` or `"Template 1"` or `"BLUE PLANES"`.  Just remember that your template (groups late activated) need to start with the prefix you have specified in your code. If you have only one prefix name for a squadron, you don't need to use the `{ }`, otherwise you need to use the brackets. 
---@param ResourceCount? number (optional) A number that specifies how many resources are in stock of the squadron. If not specified, the squadron will have infinite resources available. 
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetSquadron(SquadronName, AirbaseName, TemplatePrefixes, ResourceCount) end

---Set a squadron to engage for a battlefield area interdiction, when a defense point is under attack.
---
------
---
---USAGE
---```
---
---
---       -- BAI Squadron execution.
---       A2GDispatcher:SetSquadronBai( "Mozdok", 900, 1200, 4000, 5000 )
---       A2GDispatcher:SetSquadronBai( "Novo", 900, 2100, 6000, 8000 )
---       A2GDispatcher:SetSquadronBai( "Maykop", 900, 1200, 6000, 10000 )
---```
------
---@param SquadronName string The squadron name.
---@param EngageMinSpeed number (optional, default = 50% of max speed) The minimum speed at which the BAI task can be executed.
---@param EngageMaxSpeed number (optional, default = 75% of max speed) The maximum speed at which the BAI task can be executed.
---@param EngageFloorAltitude Altitude (optional, default = 1000m ) The lowest altitude in meters where to execute the engagement.
---@param EngageCeilingAltitude Altitude (optional, default = 1500m ) The highest altitude in meters where to execute the engagement.
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetSquadronBai(SquadronName, EngageMinSpeed, EngageMaxSpeed, EngageFloorAltitude, EngageCeilingAltitude) end

---Set a squadron to engage for a battlefield area interdiction, when a defense point is under attack.
---
------
---
---USAGE
---```
---
---
---       -- BAI Squadron execution.
---       A2GDispatcher:SetSquadronBai( "Mozdok", 900, 1200, 4000, 5000, "BARO" )
---       A2GDispatcher:SetSquadronBai( "Novo", 900, 2100, 6000, 9000, "BARO" )
---       A2GDispatcher:SetSquadronBai( "Maykop", 900, 1200, 30, 100, "RADIO" )
---```
------
---@param SquadronName string The squadron name.
---@param EngageMinSpeed number (optional, default = 50% of max speed) The minimum speed at which the BAI task can be executed.
---@param EngageMaxSpeed number (optional, default = 75% of max speed) The maximum speed at which the BAI task can be executed.
---@param EngageFloorAltitude Altitude (optional, default = 1000m ) The lowest altitude in meters where to execute the engagement.
---@param EngageCeilingAltitude Altitude (optional, default = 1500m ) The highest altitude in meters where to execute the engagement.
---@param EngageAltType number The altitude type when engaging, which is a string "BARO" defining Barometric or "RADIO" defining radio controlled altitude.
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetSquadronBai2(SquadronName, EngageMinSpeed, EngageMaxSpeed, EngageFloorAltitude, EngageCeilingAltitude, EngageAltType) end

---Set the squadron BAI engage limit.

---
------
---
---USAGE
---```
---
---       -- Patrol Squadron execution.
---       PatrolZoneEast = ZONE_POLYGON:New( "Patrol Zone East", GROUP:FindByName( "Patrol Zone East" ) )
---       A2GDispatcher:SetSquadronBaiEngageLimit( "Mineralnye", 2 ) -- Engage maximum 2 groups with the enemy for BAI defense.
---```
------
---@param SquadronName string The squadron name.
---@param EngageLimit number The maximum amount of groups to engage with the enemy for this squadron.
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetSquadronBaiEngageLimit(SquadronName, EngageLimit) end

---Set a Bai patrol for a Squadron.
---The Bai patrol will start a patrol of the aircraft at a specified zone, and will engage when commanded.
---
------
---
---USAGE
---```
---
---       -- Bai Patrol Squadron execution.
---       PatrolZoneEast = ZONE_POLYGON:New( "Patrol Zone East", GROUP:FindByName( "Patrol Zone East" ) )
---       A2GDispatcher:SetSquadronBaiPatrol( "Mineralnye", PatrolZoneEast, 4000, 10000, 500, 600, 800, 900 )
---```
------
---@param SquadronName string The squadron name.
---@param Zone ZONE_BASE The @{Core.Zone} object derived from @{Core.Zone#ZONE_BASE} that defines the zone wherein the Patrol will be executed.
---@param FloorAltitude number (optional, default = 1000m ) The minimum altitude at which the cap can be executed.
---@param CeilingAltitude number (optional, default = 1500m ) The maximum altitude at which the cap can be executed.
---@param PatrolMinSpeed number (optional, default = 50% of max speed) The minimum speed at which the cap can be executed.
---@param PatrolMaxSpeed number (optional, default = 75% of max speed) The maximum speed at which the cap can be executed.
---@param EngageMinSpeed number (optional, default = 50% of max speed) The minimum speed at which the engage can be executed.
---@param EngageMaxSpeed number (optional, default = 75% of max speed) The maximum speed at which the engage can be executed.
---@param AltType number The altitude type, which is a string "BARO" defining Barometric or "RADIO" defining radio controlled altitude.
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetSquadronBaiPatrol(SquadronName, Zone, FloorAltitude, CeilingAltitude, PatrolMinSpeed, PatrolMaxSpeed, EngageMinSpeed, EngageMaxSpeed, AltType) end

---Set a Bai patrol for a Squadron.
---The Bai patrol will start a patrol of the aircraft at a specified zone, and will engage when commanded.
---
------
---
---USAGE
---```
---
---       -- Bai Patrol Squadron execution.
---       PatrolZoneEast = ZONE_POLYGON:New( "Patrol Zone East", GROUP:FindByName( "Patrol Zone East" ) )
---       A2GDispatcher:SetSquadronBaiPatrol2( "Mineralnye", PatrolZoneEast, 500, 600, 4000, 10000, "BARO", 800, 900, 2000, 3000, "RADIO", )
---```
------
---@param SquadronName string The squadron name.
---@param Zone ZONE_BASE The @{Core.Zone} object derived from @{Core.Zone#ZONE_BASE} that defines the zone wherein the Patrol will be executed.
---@param PatrolMinSpeed number (optional, default = 50% of max speed) The minimum speed at which the cap can be executed.
---@param PatrolMaxSpeed number (optional, default = 75% of max speed) The maximum speed at which the cap can be executed.
---@param PatrolFloorAltitude number (optional, default = 1000m ) The minimum altitude at which the cap can be executed.
---@param PatrolCeilingAltitude number (optional, default = 1500m ) The maximum altitude at which the cap can be executed.
---@param PatrolAltType number The altitude type when patrolling, which is a string "BARO" defining Barometric or "RADIO" defining radio controlled altitude.
---@param EngageMinSpeed number (optional, default = 50% of max speed) The minimum speed at which the engage can be executed.
---@param EngageMaxSpeed number (optional, default = 75% of max speed) The maximum speed at which the engage can be executed.
---@param EngageFloorAltitude number (optional, default = 1000m ) The minimum altitude at which the engage can be executed.
---@param EngageCeilingAltitude number (optional, default = 1500m ) The maximum altitude at which the engage can be executed.
---@param EngageAltType number The altitude type when engaging, which is a string "BARO" defining Barometric or "RADIO" defining radio controlled altitude.
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetSquadronBaiPatrol2(SquadronName, Zone, PatrolMinSpeed, PatrolMaxSpeed, PatrolFloorAltitude, PatrolCeilingAltitude, PatrolAltType, EngageMinSpeed, EngageMaxSpeed, EngageFloorAltitude, EngageCeilingAltitude, EngageAltType) end

---Set the squadron Patrol parameters for BAI tasks.

---
------
---
---USAGE
---```
---
---       -- Patrol Squadron execution.
---       PatrolZoneEast = ZONE_POLYGON:New( "Patrol Zone East", GROUP:FindByName( "Patrol Zone East" ) )
---       A2GDispatcher:SetSquadronBaiPatrol( "Mineralnye", PatrolZoneEast, 4000, 10000, 500, 600, 800, 900 )
---       A2GDispatcher:SetSquadronBaiPatrolInterval( "Mineralnye", 2, 30, 60, 1 )
---```
------
---@param SquadronName string The squadron name.
---@param PatrolLimit? number (optional) The maximum amount of Patrol groups to be spawned. Each Patrol group can consist of 1 to 4 aircraft. The default is 1 Patrol group.
---@param LowInterval? number (optional) The minimum time in seconds between new Patrols being spawned. The default is 180 seconds.
---@param HighInterval? number (optional) The maximum time in seconds between new Patrols being spawned. The default is 600 seconds.
---@param Probability number Is not in use, you can skip this parameter.
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetSquadronBaiPatrolInterval(SquadronName, PatrolLimit, LowInterval, HighInterval, Probability) end

---Set a squadron to engage for close air support, when a defense point is under attack.
---
------
---
---USAGE
---```
---
---
---       -- CAS Squadron execution.
---       A2GDispatcher:SetSquadronCas( "Mozdok", 900, 1200, 4000, 5000 )
---       A2GDispatcher:SetSquadronCas( "Novo", 900, 2100, 6000, 8000 )
---       A2GDispatcher:SetSquadronCas( "Maykop", 900, 1200, 6000, 10000 )
---```
------
---@param SquadronName string The squadron name.
---@param EngageMinSpeed number (optional, default = 50% of max speed) The minimum speed at which the CAS task can be executed.
---@param EngageMaxSpeed number (optional, default = 75% of max speed) The maximum speed at which the CAS task can be executed.
---@param EngageFloorAltitude Altitude (optional, default = 1000m ) The lowest altitude in meters where to execute the engagement.
---@param EngageCeilingAltitude Altitude (optional, default = 1500m ) The highest altitude in meters where to execute the engagement.
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetSquadronCas(SquadronName, EngageMinSpeed, EngageMaxSpeed, EngageFloorAltitude, EngageCeilingAltitude) end

---Set a squadron to engage for close air support, when a defense point is under attack.
---
------
---
---USAGE
---```
---
---
---       -- CAS Squadron execution.
---       A2GDispatcher:SetSquadronCas( "Mozdok", 900, 1200, 4000, 5000, "BARO" )
---       A2GDispatcher:SetSquadronCas( "Novo", 900, 2100, 6000, 9000, "BARO" )
---       A2GDispatcher:SetSquadronCas( "Maykop", 900, 1200, 30, 100, "RADIO" )
---```
------
---@param SquadronName string The squadron name.
---@param EngageMinSpeed number (optional, default = 50% of max speed) The minimum speed at which the CAS task can be executed.
---@param EngageMaxSpeed number (optional, default = 75% of max speed) The maximum speed at which the CAS task can be executed.
---@param EngageFloorAltitude Altitude (optional, default = 1000m ) The lowest altitude in meters where to execute the engagement.
---@param EngageCeilingAltitude Altitude (optional, default = 1500m ) The highest altitude in meters where to execute the engagement.
---@param EngageAltType number The altitude type when engaging, which is a string "BARO" defining Barometric or "RADIO" defining radio controlled altitude.
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetSquadronCas2(SquadronName, EngageMinSpeed, EngageMaxSpeed, EngageFloorAltitude, EngageCeilingAltitude, EngageAltType) end

---Set the squadron CAS engage limit.

---
------
---
---USAGE
---```
---
---       -- Patrol Squadron execution.
---       PatrolZoneEast = ZONE_POLYGON:New( "Patrol Zone East", GROUP:FindByName( "Patrol Zone East" ) )
---       A2GDispatcher:SetSquadronCasEngageLimit( "Mineralnye", 2 ) -- Engage maximum 2 groups with the enemy for CAS defense.
---```
------
---@param SquadronName string The squadron name.
---@param EngageLimit number The maximum amount of groups to engage with the enemy for this squadron.
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetSquadronCasEngageLimit(SquadronName, EngageLimit) end

---Set a Cas patrol for a Squadron.
---The Cas patrol will start a patrol of the aircraft at a specified zone, and will engage when commanded.
---
------
---
---USAGE
---```
---
---       -- Cas Patrol Squadron execution.
---       PatrolZoneEast = ZONE_POLYGON:New( "Patrol Zone East", GROUP:FindByName( "Patrol Zone East" ) )
---       A2GDispatcher:SetSquadronCasPatrol( "Mineralnye", PatrolZoneEast, 4000, 10000, 500, 600, 800, 900 )
---```
------
---@param SquadronName string The squadron name.
---@param Zone ZONE_BASE The @{Core.Zone} object derived from @{Core.Zone#ZONE_BASE} that defines the zone wherein the Patrol will be executed.
---@param FloorAltitude number (optional, default = 1000m ) The minimum altitude at which the cap can be executed.
---@param CeilingAltitude number (optional, default = 1500m ) The maximum altitude at which the cap can be executed.
---@param PatrolMinSpeed number (optional, default = 50% of max speed) The minimum speed at which the cap can be executed.
---@param PatrolMaxSpeed number (optional, default = 75% of max speed) The maximum speed at which the cap can be executed.
---@param EngageMinSpeed number (optional, default = 50% of max speed) The minimum speed at which the engage can be executed.
---@param EngageMaxSpeed number (optional, default = 75% of max speed) The maximum speed at which the engage can be executed.
---@param AltType number The altitude type, which is a string "BARO" defining Barometric or "RADIO" defining radio controlled altitude.
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetSquadronCasPatrol(SquadronName, Zone, FloorAltitude, CeilingAltitude, PatrolMinSpeed, PatrolMaxSpeed, EngageMinSpeed, EngageMaxSpeed, AltType) end

---Set a Cas patrol for a Squadron.
---The Cas patrol will start a patrol of the aircraft at a specified zone, and will engage when commanded.
---
------
---
---USAGE
---```
---
---       -- Cas Patrol Squadron execution.
---       PatrolZoneEast = ZONE_POLYGON:New( "Patrol Zone East", GROUP:FindByName( "Patrol Zone East" ) )
---       A2GDispatcher:SetSquadronCasPatrol2( "Mineralnye", PatrolZoneEast, 500, 600, 4000, 10000, "BARO", 800, 900, 2000, 3000, "RADIO", )
---```
------
---@param SquadronName string The squadron name.
---@param Zone ZONE_BASE The @{Core.Zone} object derived from @{Core.Zone#ZONE_BASE} that defines the zone wherein the Patrol will be executed.
---@param PatrolMinSpeed number (optional, default = 50% of max speed) The minimum speed at which the cap can be executed.
---@param PatrolMaxSpeed number (optional, default = 75% of max speed) The maximum speed at which the cap can be executed.
---@param PatrolFloorAltitude number (optional, default = 1000m ) The minimum altitude at which the cap can be executed.
---@param PatrolCeilingAltitude number (optional, default = 1500m ) The maximum altitude at which the cap can be executed.
---@param PatrolAltType number The altitude type when patrolling, which is a string "BARO" defining Barometric or "RADIO" defining radio controlled altitude.
---@param EngageMinSpeed number (optional, default = 50% of max speed) The minimum speed at which the engage can be executed.
---@param EngageMaxSpeed number (optional, default = 75% of max speed) The maximum speed at which the engage can be executed.
---@param EngageFloorAltitude number (optional, default = 1000m ) The minimum altitude at which the engage can be executed.
---@param EngageCeilingAltitude number (optional, default = 1500m ) The maximum altitude at which the engage can be executed.
---@param EngageAltType number The altitude type when engaging, which is a string "BARO" defining Barometric or "RADIO" defining radio controlled altitude.
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetSquadronCasPatrol2(SquadronName, Zone, PatrolMinSpeed, PatrolMaxSpeed, PatrolFloorAltitude, PatrolCeilingAltitude, PatrolAltType, EngageMinSpeed, EngageMaxSpeed, EngageFloorAltitude, EngageCeilingAltitude, EngageAltType) end

---Set the squadron Patrol parameters for CAS tasks.

---
------
---
---USAGE
---```
---
---       -- Patrol Squadron execution.
---       PatrolZoneEast = ZONE_POLYGON:New( "Patrol Zone East", GROUP:FindByName( "Patrol Zone East" ) )
---       A2GDispatcher:SetSquadronCasPatrol( "Mineralnye", PatrolZoneEast, 4000, 10000, 500, 600, 800, 900 )
---       A2GDispatcher:SetSquadronCasPatrolInterval( "Mineralnye", 2, 30, 60, 1 )
---```
------
---@param SquadronName string The squadron name.
---@param PatrolLimit? number (optional) The maximum amount of Patrol groups to be spawned. Each Patrol group can consist of 1 to 4 aircraft. The default is 1 Patrol group.
---@param LowInterval? number (optional) The minimum time in seconds between new Patrols being spawned. The default is 180 seconds.
---@param HighInterval? number (optional) The maximum time in seconds between new Patrols being spawned. The default is 600 seconds.
---@param Probability number Is not in use, you can skip this parameter.
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetSquadronCasPatrolInterval(SquadronName, PatrolLimit, LowInterval, HighInterval, Probability) end

---Set the squadron engage limit for a specific task type.
---Mission designers should not use this method, instead use the below methods. This method is used by the below methods.
---
---  - #AI_A2G_DISPATCHER:SetSquadronSeadEngageLimit for SEAD tasks.
---  - #AI_A2G_DISPATCHER:SetSquadronSeadEngageLimit for CAS tasks.
---  - #AI_A2G_DISPATCHER:SetSquadronSeadEngageLimit for BAI tasks.
---
------
---
---USAGE
---```
---
---       -- Patrol Squadron execution.
---       PatrolZoneEast = ZONE_POLYGON:New( "Patrol Zone East", GROUP:FindByName( "Patrol Zone East" ) )
---       A2GDispatcher:SetSquadronEngageLimit( "Mineralnye", 2, "SEAD" ) -- Engage maximum 2 groups with the enemy for SEAD defense.
---```
------
---@param SquadronName string The squadron name.
---@param EngageLimit number The maximum amount of groups to engage with the enemy for this squadron.
---@param DefenseTaskType string Should contain "SEAD", "CAS" or "BAI".
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetSquadronEngageLimit(SquadronName, EngageLimit, DefenseTaskType) end

---Sets the engage probability if the squadron will engage on a detected target.
---This can be configured per squadron, to ensure that each squadron as a specific defensive probability setting.
---
------
---
---USAGE
---```
---
---
---  local A2GDispatcher = AI_A2G_DISPATCHER:New( ... )
---  
---  -- Set an defense probability for squadron SquadronName of 50%.
---  -- This will result that this squadron has 50% chance to engage on a detected target.
---  A2GDispatcher:SetSquadronEngageProbability( "SquadronName", 0.5 )
---```
------
---@param SquadronName string The name of the squadron.
---@param EngageProbability number The probability when the squadron will consider to engage the detected target. 
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetSquadronEngageProbability(SquadronName, EngageProbability) end

---Set the fuel threshold for the squadron when defenders will RTB or Refuel in the air.
---The fuel threshold is by default set to 15%, which means that an aircraft will stay in the air until 15% of its fuel is remaining.
---
------
---
---USAGE
---```
---
---  -- Now Setup the A2G dispatcher, and initialize it using the Detection object.
---  A2GDispatcher = AI_A2G_DISPATCHER:New( Detection )  
---  
---  -- Now Setup the default fuel threshold.
---  A2GDispatcher:SetSquadronRefuelThreshold( "SquadronName", 0.30 ) -- Go RTB when only 30% of fuel remaining in the tank.
---```
------
---@param SquadronName string The name of the squadron.
---@param FuelThreshold number A decimal number between 0 and 1, that expresses the % of the threshold of fuel remaining in the tank when the plane will go RTB or Refuel.
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetSquadronFuelThreshold(SquadronName, FuelThreshold) end

---Sets the Squadron grouping of new aircraft spawned.
---Grouping will trigger how new aircraft will be grouped if more than one aircraft is spawned for defense.
---
------
---
---USAGE
---```
---
---
---  local A2GDispatcher = AI_A2G_DISPATCHER:New( ... )
---  
---  -- Set a Squadron specific grouping per 2 aircraft.
---  A2GDispatcher:SetSquadronGrouping( "SquadronName", 2 )
---```
------
---@param SquadronName string The name of the squadron.
---@param Grouping number The level of grouping that will be applied for a Patrol from the Squadron.
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetSquadronGrouping(SquadronName, Grouping) end

---Defines the method at which flights will land and despawn as part of the defense system.
---
------
---
---USAGE
---```
---
---
---  local A2GDispatcher = AI_A2G_DISPATCHER:New( ... )
---  
---  -- Let new flights despawn near the airbase when returning.
---  A2GDispatcher:SetSquadronLanding( "SquadronName", AI_A2G_Dispatcher.Landing.NearAirbase )
---  
---  -- Let new flights despawn after landing land at the runway.
---  A2GDispatcher:SetSquadronLanding( "SquadronName", AI_A2G_Dispatcher.Landing.AtRunway )
---  
---  -- Let new flights despawn after landing and parking, and after engine shutdown.
---  A2GDispatcher:SetSquadronLanding( "SquadronName", AI_A2G_Dispatcher.Landing.AtEngineShutdown )
---```
------
---@param SquadronName string The name of the squadron.
---@param Landing number The landing method which can be NearAirbase, AtRunway, AtEngineShutdown
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetSquadronLanding(SquadronName, Landing) end

---Sets flights to land and despawn at engine shutdown, as part of the defense system.
---
------
---
---USAGE
---```
---
---
---  local A2GDispatcher = AI_A2G_DISPATCHER:New( ... )
---  
---  -- Let flights land and despawn at engine shutdown.
---  A2GDispatcher:SetSquadronLandingAtEngineShutdown( "SquadronName" )
---```
------
---@param SquadronName string The name of the squadron.
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetSquadronLandingAtEngineShutdown(SquadronName) end

---Sets flights to land and despawn at the runway, as part of the defense system.
---
------
---
---USAGE
---```
---
---
---  local A2GDispatcher = AI_A2G_DISPATCHER:New( ... )
---  
---  -- Let flights land at the runway and despawn.
---  A2GDispatcher:SetSquadronLandingAtRunway( "SquadronName" )
---```
------
---@param SquadronName string The name of the squadron.
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetSquadronLandingAtRunway(SquadronName) end

---Sets flights to land and despawn near the airbase in the air, as part of the defense system.
---
------
---
---USAGE
---```
---
---
---  local A2GDispatcher = AI_A2G_DISPATCHER:New( ... )
---  
---  -- Let flights to land near the airbase and despawn.
---  A2GDispatcher:SetSquadronLandingNearAirbase( "SquadronName" )
---```
------
---@param SquadronName string The name of the squadron.
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetSquadronLandingNearAirbase(SquadronName) end

---Defines the amount of extra planes that will takeoff as part of the defense system.
---
------
---
---USAGE
---```
---
---
---  local A2GDispatcher = AI_A2G_DISPATCHER:New( ... )
---  
---  -- An overhead of 1,5 with 1 planes detected, will allocate 2 planes ( 1 * 1,5 ) = 1,5 => rounded up gives 2.
---  -- An overhead of 1,5 with 2 planes detected, will allocate 3 planes ( 2 * 1,5 ) = 3 =>  rounded up gives 3.
---  -- An overhead of 1,5 with 3 planes detected, will allocate 5 planes ( 3 * 1,5 ) = 4,5 => rounded up gives 5 planes.
---  -- An overhead of 1,5 with 4 planes detected, will allocate 6 planes ( 4 * 1,5 ) = 6  => rounded up gives 6 planes.
---  
---  A2GDispatcher:SetSquadronOverhead( "SquadronName", 1.5 )
---```
------
---@param SquadronName string The name of the squadron.
---@param Overhead number The % of Units that dispatching command will allocate to intercept in surplus of detected amount of units. The default overhead is 1, so equal balance. The @{#AI_A2G_DISPATCHER.SetOverhead}() method can be used to tweak the defense strength, taking into account the plane types of the squadron. For example, a MIG-31 with full long-distance A2G missiles payload, may still be less effective than a F-15C with short missiles... So in this case, one may want to use the Overhead method to allocate more defending planes as the amount of detected attacking planes. The overhead must be given as a decimal value with 1 as the neutral value, which means that Overhead values:     * Higher than 1, will increase the defense unit amounts.   * Lower than 1, will decrease the defense unit amounts.  The amount of defending units is calculated by multiplying the amount of detected attacking planes as part of the detected group  multiplied by the Overhead and rounded up to the smallest integer.   The Overhead value set for a Squadron, can be programmatically adjusted (by using this SetOverhead method), to adjust the defense overhead during mission execution.  See example below.  
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetSquadronOverhead(SquadronName, Overhead) end

---Set the squadron patrol parameters for a specific task type.
---Mission designers should not use this method, instead use the below methods. This method is used by the below methods.
---
---  - #AI_A2G_DISPATCHER:SetSquadronSeadPatrolInterval for SEAD tasks.
---  - #AI_A2G_DISPATCHER:SetSquadronSeadPatrolInterval for CAS tasks.
---  - #AI_A2G_DISPATCHER:SetSquadronSeadPatrolInterval for BAI tasks.
---
------
---
---USAGE
---```
---
---       -- Patrol Squadron execution.
---       PatrolZoneEast = ZONE_POLYGON:New( "Patrol Zone East", GROUP:FindByName( "Patrol Zone East" ) )
---       A2GDispatcher:SetSquadronSeadPatrol( "Mineralnye", PatrolZoneEast, 4000, 10000, 500, 600, 800, 900 )
---       A2GDispatcher:SetSquadronPatrolInterval( "Mineralnye", 2, 30, 60, 1, "SEAD" )
---```
------
---@param SquadronName string The squadron name.
---@param PatrolLimit? number (optional) The maximum amount of Patrol groups to be spawned. Note that each Patrol is a group, and can consist of 1 to 4 aircraft. The default is 1 Patrol group.
---@param LowInterval? number (optional) The minimum time boundary in seconds when a new Patrol will be spawned. The default is 180 seconds.
---@param HighInterval? number (optional) The maximum time boundary in seconds when a new Patrol will be spawned. The default is 600 seconds.
---@param Probability number Is not in use, you can skip this parameter.
---@param DefenseTaskType string Should contain "SEAD", "CAS" or "BAI".
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetSquadronPatrolInterval(SquadronName, PatrolLimit, LowInterval, HighInterval, Probability, DefenseTaskType) end

---Set the frequency of communication and the mode of communication for voice overs.
---
------
---@param SquadronName string The name of the squadron.
---@param RadioFrequency number The frequency of communication.
---@param RadioModulation number The modulation of communication.
---@param RadioPower number The power in Watts of communication.
function AI_A2G_DISPATCHER:SetSquadronRadioFrequency(SquadronName, RadioFrequency, RadioModulation, RadioPower) end

---Set a squadron to engage for suppression of air defenses, when a defense point is under attack.
---
------
---
---USAGE
---```
---
---
---       -- SEAD Squadron execution.
---       A2GDispatcher:SetSquadronSead( "Mozdok", 900, 1200, 4000, 5000 )
---       A2GDispatcher:SetSquadronSead( "Novo", 900, 2100, 6000, 8000 )
---       A2GDispatcher:SetSquadronSead( "Maykop", 900, 1200, 6000, 10000 )
---```
------
---@param SquadronName string The squadron name.
---@param EngageMinSpeed number (optional, default = 50% of max speed) The minimum speed at which the SEAD task can be executed.
---@param EngageMaxSpeed number (optional, default = 75% of max speed) The maximum speed at which the SEAD task can be executed.
---@param EngageFloorAltitude Altitude (optional, default = 1000m ) The lowest altitude in meters where to execute the engagement.
---@param EngageCeilingAltitude Altitude (optional, default = 1500m ) The highest altitude in meters where to execute the engagement.
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetSquadronSead(SquadronName, EngageMinSpeed, EngageMaxSpeed, EngageFloorAltitude, EngageCeilingAltitude) end

---Set a squadron to engage for suppression of air defenses, when a defense point is under attack.
---
------
---
---USAGE
---```
---
---
---       -- SEAD Squadron execution.
---       A2GDispatcher:SetSquadronSead( "Mozdok", 900, 1200, 4000, 5000, "BARO" )
---       A2GDispatcher:SetSquadronSead( "Novo", 900, 2100, 6000, 9000, "BARO" )
---       A2GDispatcher:SetSquadronSead( "Maykop", 900, 1200, 30, 100, "RADIO" )
---```
------
---@param SquadronName string The squadron name.
---@param EngageMinSpeed number (optional, default = 50% of max speed) The minimum speed at which the SEAD task can be executed.
---@param EngageMaxSpeed number (optional, default = 75% of max speed) The maximum speed at which the SEAD task can be executed.
---@param EngageFloorAltitude Altitude (optional, default = 1000m ) The lowest altitude in meters where to execute the engagement.
---@param EngageCeilingAltitude Altitude (optional, default = 1500m ) The highest altitude in meters where to execute the engagement.
---@param EngageAltType number The altitude type when engaging, which is a string "BARO" defining Barometric or "RADIO" defining radio controlled altitude.
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetSquadronSead2(SquadronName, EngageMinSpeed, EngageMaxSpeed, EngageFloorAltitude, EngageCeilingAltitude, EngageAltType) end

---Set the squadron SEAD engage limit.

---
------
---
---USAGE
---```
---
---       -- Patrol Squadron execution.
---       PatrolZoneEast = ZONE_POLYGON:New( "Patrol Zone East", GROUP:FindByName( "Patrol Zone East" ) )
---       A2GDispatcher:SetSquadronSeadEngageLimit( "Mineralnye", 2 ) -- Engage maximum 2 groups with the enemy for SEAD defense.
---```
------
---@param SquadronName string The squadron name.
---@param EngageLimit number The maximum amount of groups to engage with the enemy for this squadron.
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetSquadronSeadEngageLimit(SquadronName, EngageLimit) end

---Set a Sead patrol for a Squadron.
---The Sead patrol will start a patrol of the aircraft at a specified zone, and will engage when commanded.
---
------
---
---USAGE
---```
---
---       -- Sead Patrol Squadron execution.
---       PatrolZoneEast = ZONE_POLYGON:New( "Patrol Zone East", GROUP:FindByName( "Patrol Zone East" ) )
---       A2GDispatcher:SetSquadronSeadPatrol( "Mineralnye", PatrolZoneEast, 4000, 10000, 500, 600, 800, 900 )
---```
------
---@param SquadronName string The squadron name.
---@param Zone ZONE_BASE The @{Core.Zone} object derived from @{Core.Zone#ZONE_BASE} that defines the zone wherein the Patrol will be executed.
---@param FloorAltitude number (optional, default = 1000m ) The minimum altitude at which the cap can be executed.
---@param CeilingAltitude number (optional, default = 1500m ) The maximum altitude at which the cap can be executed.
---@param PatrolMinSpeed number (optional, default = 50% of max speed) The minimum speed at which the cap can be executed.
---@param PatrolMaxSpeed number (optional, default = 75% of max speed) The maximum speed at which the cap can be executed.
---@param EngageMinSpeed number (optional, default = 50% of max speed) The minimum speed at which the engage can be executed.
---@param EngageMaxSpeed number (optional, default = 75% of max speed) The maximum speed at which the engage can be executed.
---@param AltType number The altitude type, which is a string "BARO" defining Barometric or "RADIO" defining radio controlled altitude.
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetSquadronSeadPatrol(SquadronName, Zone, FloorAltitude, CeilingAltitude, PatrolMinSpeed, PatrolMaxSpeed, EngageMinSpeed, EngageMaxSpeed, AltType) end

---Set a Sead patrol for a Squadron.
---The Sead patrol will start a patrol of the aircraft at a specified zone, and will engage when commanded.
---
------
---
---USAGE
---```
---
---       -- Sead Patrol Squadron execution.
---       PatrolZoneEast = ZONE_POLYGON:New( "Patrol Zone East", GROUP:FindByName( "Patrol Zone East" ) )
---       A2GDispatcher:SetSquadronSeadPatrol2( "Mineralnye", PatrolZoneEast, 500, 600, 4000, 10000, "BARO", 800, 900, 2000, 3000, "RADIO", )
---```
------
---@param SquadronName string The squadron name.
---@param Zone ZONE_BASE The @{Core.Zone} object derived from @{Core.Zone#ZONE_BASE} that defines the zone wherein the Patrol will be executed.
---@param PatrolMinSpeed number (optional, default = 50% of max speed) The minimum speed at which the cap can be executed.
---@param PatrolMaxSpeed number (optional, default = 75% of max speed) The maximum speed at which the cap can be executed.
---@param PatrolFloorAltitude number (optional, default = 1000m ) The minimum altitude at which the cap can be executed.
---@param PatrolCeilingAltitude number (optional, default = 1500m ) The maximum altitude at which the cap can be executed.
---@param PatrolAltType number The altitude type when patrolling, which is a string "BARO" defining Barometric or "RADIO" defining radio controlled altitude.
---@param EngageMinSpeed number (optional, default = 50% of max speed) The minimum speed at which the engage can be executed.
---@param EngageMaxSpeed number (optional, default = 75% of max speed) The maximum speed at which the engage can be executed.
---@param EngageFloorAltitude number (optional, default = 1000m ) The minimum altitude at which the engage can be executed.
---@param EngageCeilingAltitude number (optional, default = 1500m ) The maximum altitude at which the engage can be executed.
---@param EngageAltType number The altitude type when engaging, which is a string "BARO" defining Barometric or "RADIO" defining radio controlled altitude.
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetSquadronSeadPatrol2(SquadronName, Zone, PatrolMinSpeed, PatrolMaxSpeed, PatrolFloorAltitude, PatrolCeilingAltitude, PatrolAltType, EngageMinSpeed, EngageMaxSpeed, EngageFloorAltitude, EngageCeilingAltitude, EngageAltType) end

---Set the squadron Patrol parameters for SEAD tasks.

---
------
---
---USAGE
---```
---
---       -- Patrol Squadron execution.
---       PatrolZoneEast = ZONE_POLYGON:New( "Patrol Zone East", GROUP:FindByName( "Patrol Zone East" ) )
---       A2GDispatcher:SetSquadronSeadPatrol( "Mineralnye", PatrolZoneEast, 4000, 10000, 500, 600, 800, 900 )
---       A2GDispatcher:SetSquadronSeadPatrolInterval( "Mineralnye", 2, 30, 60, 1 )
---```
------
---@param SquadronName string The squadron name.
---@param PatrolLimit? number (optional) The maximum amount of Patrol groups to be spawned. Each Patrol group can consist of 1 to 4 aircraft. The default is 1 Patrol group.
---@param LowInterval? number (optional) The minimum time in seconds between new Patrols being spawned. The default is 180 seconds.
---@param HighInterval? number (optional) The maximum ttime in seconds between new Patrols being spawned. The default is 600 seconds.
---@param Probability number Is not in use, you can skip this parameter.
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetSquadronSeadPatrolInterval(SquadronName, PatrolLimit, LowInterval, HighInterval, Probability) end

---Defines the method at which new flights will spawn and takeoff as part of the defense system.
---
------
---
---USAGE
---```
---
---
---  local A2GDispatcher = AI_A2G_DISPATCHER:New( ... )
---  
---  -- Let new flights takeoff in the air.
---  A2GDispatcher:SetSquadronTakeoff( "SquadronName", AI_A2G_Dispatcher.Takeoff.Air )
---  
---  -- Let new flights takeoff from the runway.
---  A2GDispatcher:SetSquadronTakeoff( "SquadronName", AI_A2G_Dispatcher.Takeoff.Runway )
---  
---  -- Let new flights takeoff from the airbase hot.
---  A2GDispatcher:SetSquadronTakeoff( "SquadronName", AI_A2G_Dispatcher.Takeoff.Hot )
---
---  -- Let new flights takeoff from the airbase cold.
---  A2GDispatcher:SetSquadronTakeoff( "SquadronName", AI_A2G_Dispatcher.Takeoff.Cold )
---```
------
---@param SquadronName string The name of the squadron.
---@param Takeoff number From the airbase hot, from the airbase cold, in the air, from the runway.
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetSquadronTakeoff(SquadronName, Takeoff) end

---Sets flights to takeoff from the airbase at a cold location, as part of the defense system.
---
------
---
---USAGE
---```
---
---
---  local A2GDispatcher = AI_A2G_DISPATCHER:New( ... )
---  
---  -- Let new flights takeoff from a cold parking spot.
---  A2GDispatcher:SetSquadronTakeoffFromParkingCold( "SquadronName" )
---```
------
---@param SquadronName string The name of the squadron.
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetSquadronTakeoffFromParkingCold(SquadronName) end

---Sets flights to takeoff from the airbase at a hot location, as part of the defense system.
---
------
---
---USAGE
---```
---
---
---  local A2GDispatcher = AI_A2G_DISPATCHER:New( ... )
---  
---  -- Let new flights takeoff in the air.
---  A2GDispatcher:SetSquadronTakeoffFromParkingHot( "SquadronName" )
---```
------
---@param SquadronName string The name of the squadron.
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetSquadronTakeoffFromParkingHot(SquadronName) end

---Sets flights to takeoff from the runway, as part of the defense system.
---
------
---
---USAGE
---```
---
---
---  local A2GDispatcher = AI_A2G_DISPATCHER:New( ... )
---  
---  -- Let new flights takeoff from the runway.
---  A2GDispatcher:SetSquadronTakeoffFromRunway( "SquadronName" )
---```
------
---@param SquadronName string The name of the squadron.
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetSquadronTakeoffFromRunway(SquadronName) end

---Sets flights to takeoff in the air, as part of the defense system.
---
------
---
---USAGE
---```
---
---
---  local A2GDispatcher = AI_A2G_DISPATCHER:New( ... )
---  
---  -- Let new flights takeoff in the air.
---  A2GDispatcher:SetSquadronTakeoffInAir( "SquadronName" )
---```
------
---@param SquadronName string The name of the squadron.
---@param TakeoffAltitude? number (optional) The altitude in meters above the ground. If not given, the default takeoff altitude will be used.
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetSquadronTakeoffInAir(SquadronName, TakeoffAltitude) end

---Defines the default altitude where aircraft will spawn in the air and takeoff as part of the defense system, when the takeoff in the air method has been selected.
---
------
---
---USAGE
---```
---
---
---  local A2GDispatcher = AI_A2G_DISPATCHER:New( ... )
---  
---  -- Set the default takeoff altitude when taking off in the air.
---  A2GDispatcher:SetSquadronTakeoffInAirAltitude( "SquadronName", 2000 ) -- This makes aircraft start at 2000 meters above ground level (AGL).
---```
------
---@param SquadronName string The name of the squadron.
---@param TakeoffAltitude number The altitude in meters above ground level (AGL).
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetSquadronTakeoffInAirAltitude(SquadronName, TakeoffAltitude) end


---
------
---@param SquadronName NOTYPE 
---@param TakeoffInterval NOTYPE 
function AI_A2G_DISPATCHER:SetSquadronTakeoffInterval(SquadronName, TakeoffInterval) end

---Set the squadron tanker where defenders will Refuel in the air.
---
------
---
---USAGE
---```
---
---  -- Now Setup the A2G dispatcher, and initialize it using the Detection object.
---  A2GDispatcher = AI_A2G_DISPATCHER:New( Detection )  
---  
---  -- Now Setup the squadron fuel threshold.
---  A2GDispatcher:SetSquadronRefuelThreshold( "SquadronName", 0.30 ) -- Go RTB when only 30% of fuel remaining in the tank.
---  
---  -- Now Setup the squadron tanker.
---  A2GDispatcher:SetSquadronTanker( "SquadronName", "Tanker" ) -- The group name of the tanker is "Tanker" in the Mission Editor.
---```
------
---@param SquadronName string The name of the squadron.
---@param TankerName string A string defining the group name of the Tanker as defined within the Mission Editor.
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetSquadronTanker(SquadronName, TankerName) end

---Display a tactical report every 30 seconds about which aircraft are:
---  * Patrolling
---  * Engaging
---  * Returning
---  * Damaged
---  * Out of Fuel
---  * ...
---
------
---
---USAGE
---```
---
---  -- Now Setup the A2G dispatcher, and initialize it using the Detection object.
---  A2GDispatcher = AI_A2G_DISPATCHER:New( Detection )  
---  
---  -- Now Setup the Tactical Display for debug mode.
---  A2GDispatcher:SetTacticalDisplay( true )
---```
------
---@param TacticalDisplay boolean Provide a value of **true** to display every 30 seconds a tactical overview.
---@return AI_A2G_DISPATCHER #
function AI_A2G_DISPATCHER:SetTacticalDisplay(TacticalDisplay) end

---Shows the tactical display.
---
------
---@param Detection NOTYPE 
function AI_A2G_DISPATCHER:ShowTacticalDisplay(Detection) end

---Unlocks the DefenseItem from being defended.
---
------
---@param DetectedItemIndex string The index of the detected item.
function AI_A2G_DISPATCHER:Unlock(DetectedItemIndex) end

---Defend Asynchronous Trigger for AI_A2G_DISPATCHER
---
------
---@param Delay number 
function AI_A2G_DISPATCHER:__Defend(Delay) end

---Engage Asynchronous Trigger for AI_A2G_DISPATCHER
---
------
---@param Delay number 
function AI_A2G_DISPATCHER:__Engage(Delay) end

---Patrol Asynchronous Trigger for AI_A2G_DISPATCHER
---
------
---@param Delay number 
function AI_A2G_DISPATCHER:__Patrol(Delay) end


---
------
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@param DetectedItem NOTYPE 
---@param DefendersTotal NOTYPE 
---@param DefendersEngaged NOTYPE 
---@param DefendersMissing NOTYPE 
---@param DefenderFriendlies NOTYPE 
---@param DefenseTaskType NOTYPE 
---@private
function AI_A2G_DISPATCHER:onafterDefend(From, Event, To, DetectedItem, DefendersTotal, DefendersEngaged, DefendersMissing, DefenderFriendlies, DefenseTaskType) end


---
------
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@param AttackerDetection NOTYPE 
---@param Defenders NOTYPE 
---@private
function AI_A2G_DISPATCHER:onafterEngage(From, Event, To, AttackerDetection, Defenders) end


---
------
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@param SquadronName NOTYPE 
---@param DefenseTaskType NOTYPE 
---@private
function AI_A2G_DISPATCHER:onafterPatrol(From, Event, To, SquadronName, DefenseTaskType) end


---
------
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@private
function AI_A2G_DISPATCHER:onafterStart(From, Event, To) end


---@class AI_A2G_DISPATCHER.DefenderQueueItem 
---@field AttackerDetection NOTYPE 
---@field DefenderSquadron NOTYPE 
---@field DefendersNeeded NOTYPE 
---@field Defense NOTYPE 
---@field DefenseTaskType NOTYPE 
---@field Patrol NOTYPE 
---@field SquadronName NOTYPE 
AI_A2G_DISPATCHER.DefenderQueueItem = {}


---Defense approach types.
---@class AI_A2G_DISPATCHER.DefenseApproach 
---@field Distance number 
---@field Random number 
AI_A2G_DISPATCHER.DefenseApproach = {}


---A defense queue item description.
---@class AI_A2G_DISPATCHER.DefenseQueueItem 
---@field AttackerDetection DETECTION_BASE 
---@field DefenderSquadron AI_A2G_DISPATCHER.Squadron The squadron in the queue.
---@field SquadronName string The name of the squadron.
AI_A2G_DISPATCHER.DefenseQueueItem = {}


---Definition of a Squadron.
---@class AI_A2G_DISPATCHER.Squadron 
---@field Airbase AIRBASE The home airbase.
---@field AirbaseName string The name of the home airbase.
---@field Captured boolean true if the squadron is captured.
---@field Name string The Squadron name.
---@field Overhead number The overhead for the squadron.
---@field ResourceCount number The number of resources available.
---@field Spawn SPAWN The spawning object.
---@field TemplatePrefixes list The list of template prefixes.
AI_A2G_DISPATCHER.Squadron = {}



